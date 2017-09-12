/* Copyright (c) 2015, Google Inc.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE. */

#include <openssl/ssl.h>

#include <assert.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>

#include <openssl/bio.h>
#include <openssl/err.h>
#include <openssl/mem.h>

#include "../crypto/internal.h"
#include "internal.h"


namespace bssl {

// BIO uses int instead of size_t. No lengths will exceed uint16_t, so this will
// not overflow.
static_assert(0xffff <= INT_MAX, "uint16_t does not fit in int");

static_assert((SSL3_ALIGN_PAYLOAD & (SSL3_ALIGN_PAYLOAD - 1)) == 0,
              "SSL3_ALIGN_PAYLOAD must be a power of 2");

// ensure_buffer ensures |buf| has capacity at least |cap|, aligned such that
// data written after |header_len| is aligned to a |SSL3_ALIGN_PAYLOAD|-byte
// boundary. It returns one on success and zero on error.
static int ensure_buffer(SSL3_BUFFER *buf, size_t header_len, size_t cap) {
  if (cap > 0xffff) {
    OPENSSL_PUT_ERROR(SSL, ERR_R_INTERNAL_ERROR);
    return 0;
  }

  if (buf->cap >= cap) {
    return 1;
  }

  // Add up to |SSL3_ALIGN_PAYLOAD| - 1 bytes of slack for alignment.
  //
  // Since this buffer gets allocated quite frequently and doesn't contain any
  // sensitive data, we allocate with malloc rather than |OPENSSL_malloc| and
  // avoid zeroing on free.
  uint8_t *new_buf = (uint8_t *)malloc(cap + SSL3_ALIGN_PAYLOAD - 1);
  if (new_buf == NULL) {
    OPENSSL_PUT_ERROR(SSL, ERR_R_MALLOC_FAILURE);
    return 0;
  }

  // Offset the buffer such that the record body is aligned.
  size_t new_offset =
      (0 - header_len - (uintptr_t)new_buf) & (SSL3_ALIGN_PAYLOAD - 1);

  if (buf->buf != NULL) {
    OPENSSL_memcpy(new_buf + new_offset, buf->buf + buf->offset, buf->len);
    free(buf->buf);  // Allocated with malloc().
  }

  buf->buf = new_buf;
  buf->offset = new_offset;
  buf->cap = cap;
  return 1;
}

static void consume_buffer(SSL3_BUFFER *buf, size_t len) {
  if (len > buf->len) {
    abort();
  }
  buf->offset += (uint16_t)len;
  buf->len -= (uint16_t)len;
  buf->cap -= (uint16_t)len;
}

static void clear_buffer(SSL3_BUFFER *buf) {
  free(buf->buf);  // Allocated with malloc().
  OPENSSL_memset(buf, 0, sizeof(SSL3_BUFFER));
}

uint8_t *ssl_read_buffer(SSL *ssl) {
  return ssl->s3->read_buffer.buf + ssl->s3->read_buffer.offset;
}

size_t ssl_read_buffer_len(const SSL *ssl) {
  return ssl->s3->read_buffer.len;
}

static int dtls_read_buffer_next_packet(SSL *ssl) {
  SSL3_BUFFER *buf = &ssl->s3->read_buffer;

  if (buf->len > 0) {
    // It is an error to call |dtls_read_buffer_extend| when the read buffer is
    // not empty.
    OPENSSL_PUT_ERROR(SSL, ERR_R_INTERNAL_ERROR);
    return -1;
  }

  // Read a single packet from |ssl->rbio|. |buf->cap| must fit in an int.
  int ret = BIO_read(ssl->rbio, buf->buf + buf->offset, (int)buf->cap);
  if (ret <= 0) {
    ssl->rwstate = SSL_READING;
    return ret;
  }
  // |BIO_read| was bound by |buf->cap|, so this cannot overflow.
  buf->len = (uint16_t)ret;
  return 1;
}

static int tls_read_buffer_extend_to(SSL *ssl, size_t len) {
  SSL3_BUFFER *buf = &ssl->s3->read_buffer;

  if (len > buf->cap) {
    OPENSSL_PUT_ERROR(SSL, SSL_R_BUFFER_TOO_SMALL);
    return -1;
  }

  // Read until the target length is reached.
  while (buf->len < len) {
    // The amount of data to read is bounded by |buf->cap|, which must fit in an
    // int.
    int ret = BIO_read(ssl->rbio, buf->buf + buf->offset + buf->len,
                       (int)(len - buf->len));
    if (ret <= 0) {
      ssl->rwstate = SSL_READING;
      return ret;
    }
    // |BIO_read| was bound by |buf->cap - buf->len|, so this cannot
    // overflow.
    buf->len += (uint16_t)ret;
  }

  return 1;
}

int ssl_read_buffer_extend_to(SSL *ssl, size_t len) {
  // |ssl_read_buffer_extend_to| implicitly discards any consumed data.
  ssl_read_buffer_discard(ssl);

  if (SSL_is_dtls(ssl)) {
    static_assert(
        DTLS1_RT_HEADER_LENGTH + SSL3_RT_MAX_ENCRYPTED_LENGTH <= 0xffff,
        "DTLS read buffer is too large");

    // The |len| parameter is ignored in DTLS.
    len = DTLS1_RT_HEADER_LENGTH + SSL3_RT_MAX_ENCRYPTED_LENGTH;
  }

  if (!ensure_buffer(&ssl->s3->read_buffer, ssl_record_prefix_len(ssl), len)) {
    return -1;
  }

  if (ssl->rbio == NULL) {
    OPENSSL_PUT_ERROR(SSL, SSL_R_BIO_NOT_SET);
    return -1;
  }

  int ret;
  if (SSL_is_dtls(ssl)) {
    // |len| is ignored for a datagram transport.
    ret = dtls_read_buffer_next_packet(ssl);
  } else {
    ret = tls_read_buffer_extend_to(ssl, len);
  }

  if (ret <= 0) {
    // If the buffer was empty originally and remained empty after attempting to
    // extend it, release the buffer until the next attempt.
    ssl_read_buffer_discard(ssl);
  }
  return ret;
}

void ssl_read_buffer_consume(SSL *ssl, size_t len) {
  SSL3_BUFFER *buf = &ssl->s3->read_buffer;

  consume_buffer(buf, len);

  // The TLS stack never reads beyond the current record, so there will never be
  // unconsumed data. If read-ahead is ever reimplemented,
  // |ssl_read_buffer_discard| will require a |memcpy| to shift the excess back
  // to the front of the buffer, to ensure there is enough space for the next
  // record.
  assert(SSL_is_dtls(ssl) || len == 0 || buf->len == 0);
}

void ssl_read_buffer_discard(SSL *ssl) {
  if (ssl->s3->read_buffer.len == 0) {
    ssl_read_buffer_clear(ssl);
  }
}

void ssl_read_buffer_clear(SSL *ssl) {
  clear_buffer(&ssl->s3->read_buffer);
}


int ssl_write_buffer_is_pending(const SSL *ssl) {
  return ssl->s3->write_buffer.len > 0;
}

static_assert(SSL3_RT_HEADER_LENGTH * 2 +
                      SSL3_RT_SEND_MAX_ENCRYPTED_OVERHEAD * 2 +
                      SSL3_RT_MAX_PLAIN_LENGTH <=
                  0xffff,
              "maximum TLS write buffer is too large");

static_assert(DTLS1_RT_HEADER_LENGTH + SSL3_RT_SEND_MAX_ENCRYPTED_OVERHEAD +
                      SSL3_RT_MAX_PLAIN_LENGTH <=
                  0xffff,
              "maximum DTLS write buffer is too large");

int ssl_write_buffer_init(SSL *ssl, uint8_t **out_ptr, size_t max_len) {
  SSL3_BUFFER *buf = &ssl->s3->write_buffer;

  if (buf->buf != NULL) {
    OPENSSL_PUT_ERROR(SSL, ERR_R_INTERNAL_ERROR);
    return 0;
  }

  if (!ensure_buffer(buf, ssl_seal_align_prefix_len(ssl), max_len)) {
    return 0;
  }
  *out_ptr = buf->buf + buf->offset;
  return 1;
}

void ssl_write_buffer_set_len(SSL *ssl, size_t len) {
  SSL3_BUFFER *buf = &ssl->s3->write_buffer;

  if (len > buf->cap) {
    abort();
  }
  buf->len = len;
}

static int tls_write_buffer_flush(SSL *ssl) {
  SSL3_BUFFER *buf = &ssl->s3->write_buffer;

  while (buf->len > 0) {
    int ret = BIO_write(ssl->wbio, buf->buf + buf->offset, buf->len);
    if (ret <= 0) {
      ssl->rwstate = SSL_WRITING;
      return ret;
    }
    consume_buffer(buf, (size_t)ret);
  }
  ssl_write_buffer_clear(ssl);
  return 1;
}

static int dtls_write_buffer_flush(SSL *ssl) {
  SSL3_BUFFER *buf = &ssl->s3->write_buffer;
  if (buf->len == 0) {
    return 1;
  }

  int ret = BIO_write(ssl->wbio, buf->buf + buf->offset, buf->len);
  if (ret <= 0) {
    ssl->rwstate = SSL_WRITING;
    // If the write failed, drop the write buffer anyway. Datagram transports
    // can't write half a packet, so the caller is expected to retry from the
    // top.
    ssl_write_buffer_clear(ssl);
    return ret;
  }
  ssl_write_buffer_clear(ssl);
  return 1;
}

int ssl_write_buffer_flush(SSL *ssl) {
  if (ssl->wbio == NULL) {
    OPENSSL_PUT_ERROR(SSL, SSL_R_BIO_NOT_SET);
    return -1;
  }

  if (SSL_is_dtls(ssl)) {
    return dtls_write_buffer_flush(ssl);
  } else {
    return tls_write_buffer_flush(ssl);
  }
}

void ssl_write_buffer_clear(SSL *ssl) {
  clear_buffer(&ssl->s3->write_buffer);
}

}  // namespace bssl
