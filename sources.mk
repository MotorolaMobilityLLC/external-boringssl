# This file is created by update_gypi_and_asm.py. Do not edit manually.

crypto_sources := \
  android_compat_hacks.c\
  src/crypto/aes/aes.c\
  src/crypto/aes/mode_wrappers.c\
  src/crypto/asn1/a_bitstr.c\
  src/crypto/asn1/a_bool.c\
  src/crypto/asn1/a_bytes.c\
  src/crypto/asn1/a_d2i_fp.c\
  src/crypto/asn1/a_dup.c\
  src/crypto/asn1/a_enum.c\
  src/crypto/asn1/a_gentm.c\
  src/crypto/asn1/a_i2d_fp.c\
  src/crypto/asn1/a_int.c\
  src/crypto/asn1/a_mbstr.c\
  src/crypto/asn1/a_object.c\
  src/crypto/asn1/a_octet.c\
  src/crypto/asn1/a_print.c\
  src/crypto/asn1/a_strnid.c\
  src/crypto/asn1/a_time.c\
  src/crypto/asn1/a_type.c\
  src/crypto/asn1/a_utctm.c\
  src/crypto/asn1/a_utf8.c\
  src/crypto/asn1/asn1_error.c\
  src/crypto/asn1/asn1_lib.c\
  src/crypto/asn1/asn1_par.c\
  src/crypto/asn1/asn_pack.c\
  src/crypto/asn1/bio_asn1.c\
  src/crypto/asn1/bio_ndef.c\
  src/crypto/asn1/f_enum.c\
  src/crypto/asn1/f_int.c\
  src/crypto/asn1/f_string.c\
  src/crypto/asn1/t_bitst.c\
  src/crypto/asn1/t_pkey.c\
  src/crypto/asn1/tasn_dec.c\
  src/crypto/asn1/tasn_enc.c\
  src/crypto/asn1/tasn_fre.c\
  src/crypto/asn1/tasn_new.c\
  src/crypto/asn1/tasn_prn.c\
  src/crypto/asn1/tasn_typ.c\
  src/crypto/asn1/tasn_utl.c\
  src/crypto/asn1/x_bignum.c\
  src/crypto/asn1/x_long.c\
  src/crypto/base64/base64.c\
  src/crypto/bio/bio.c\
  src/crypto/bio/bio_error.c\
  src/crypto/bio/bio_mem.c\
  src/crypto/bio/buffer.c\
  src/crypto/bio/connect.c\
  src/crypto/bio/fd.c\
  src/crypto/bio/file.c\
  src/crypto/bio/hexdump.c\
  src/crypto/bio/pair.c\
  src/crypto/bio/printf.c\
  src/crypto/bio/socket.c\
  src/crypto/bio/socket_helper.c\
  src/crypto/bn/add.c\
  src/crypto/bn/asm/x86_64-gcc.c\
  src/crypto/bn/bn.c\
  src/crypto/bn/bn_error.c\
  src/crypto/bn/cmp.c\
  src/crypto/bn/convert.c\
  src/crypto/bn/ctx.c\
  src/crypto/bn/div.c\
  src/crypto/bn/exponentiation.c\
  src/crypto/bn/gcd.c\
  src/crypto/bn/generic.c\
  src/crypto/bn/kronecker.c\
  src/crypto/bn/montgomery.c\
  src/crypto/bn/mul.c\
  src/crypto/bn/prime.c\
  src/crypto/bn/random.c\
  src/crypto/bn/rsaz_exp.c\
  src/crypto/bn/shift.c\
  src/crypto/bn/sqrt.c\
  src/crypto/buf/buf.c\
  src/crypto/buf/buf_error.c\
  src/crypto/bytestring/ber.c\
  src/crypto/bytestring/cbb.c\
  src/crypto/bytestring/cbs.c\
  src/crypto/chacha/chacha_generic.c\
  src/crypto/chacha/chacha_vec.c\
  src/crypto/cipher/aead.c\
  src/crypto/cipher/cipher.c\
  src/crypto/cipher/cipher_error.c\
  src/crypto/cipher/derive_key.c\
  src/crypto/cipher/e_aes.c\
  src/crypto/cipher/e_chacha20poly1305.c\
  src/crypto/cipher/e_des.c\
  src/crypto/cipher/e_null.c\
  src/crypto/cipher/e_rc2.c\
  src/crypto/cipher/e_rc4.c\
  src/crypto/cipher/e_ssl3.c\
  src/crypto/cipher/e_tls.c\
  src/crypto/cipher/tls_cbc.c\
  src/crypto/conf/conf.c\
  src/crypto/conf/conf_error.c\
  src/crypto/cpu-arm.c\
  src/crypto/cpu-intel.c\
  src/crypto/crypto.c\
  src/crypto/crypto_error.c\
  src/crypto/des/des.c\
  src/crypto/dh/check.c\
  src/crypto/dh/dh.c\
  src/crypto/dh/dh_asn1.c\
  src/crypto/dh/dh_error.c\
  src/crypto/dh/dh_impl.c\
  src/crypto/dh/params.c\
  src/crypto/digest/digest.c\
  src/crypto/digest/digest_error.c\
  src/crypto/digest/digests.c\
  src/crypto/directory_posix.c\
  src/crypto/directory_win.c\
  src/crypto/dsa/dsa.c\
  src/crypto/dsa/dsa_asn1.c\
  src/crypto/dsa/dsa_error.c\
  src/crypto/dsa/dsa_impl.c\
  src/crypto/ec/ec.c\
  src/crypto/ec/ec_asn1.c\
  src/crypto/ec/ec_error.c\
  src/crypto/ec/ec_key.c\
  src/crypto/ec/ec_montgomery.c\
  src/crypto/ec/oct.c\
  src/crypto/ec/simple.c\
  src/crypto/ec/wnaf.c\
  src/crypto/ecdh/ecdh.c\
  src/crypto/ecdh/ecdh_error.c\
  src/crypto/ecdsa/ecdsa.c\
  src/crypto/ecdsa/ecdsa_asn1.c\
  src/crypto/ecdsa/ecdsa_error.c\
  src/crypto/engine/engine.c\
  src/crypto/engine/engine_error.c\
  src/crypto/err/err.c\
  src/crypto/err/err_impl.c\
  src/crypto/evp/algorithm.c\
  src/crypto/evp/asn1.c\
  src/crypto/evp/digestsign.c\
  src/crypto/evp/evp.c\
  src/crypto/evp/evp_ctx.c\
  src/crypto/evp/evp_error.c\
  src/crypto/evp/p_ec.c\
  src/crypto/evp/p_ec_asn1.c\
  src/crypto/evp/p_hmac.c\
  src/crypto/evp/p_hmac_asn1.c\
  src/crypto/evp/p_rsa.c\
  src/crypto/evp/p_rsa_asn1.c\
  src/crypto/evp/pbkdf.c\
  src/crypto/evp/sign.c\
  src/crypto/ex_data.c\
  src/crypto/ex_data_impl.c\
  src/crypto/hkdf/hkdf.c\
  src/crypto/hkdf/hkdf_error.c\
  src/crypto/hmac/hmac.c\
  src/crypto/lhash/lhash.c\
  src/crypto/md4/md4.c\
  src/crypto/md5/md5.c\
  src/crypto/mem.c\
  src/crypto/modes/cbc.c\
  src/crypto/modes/cfb.c\
  src/crypto/modes/ctr.c\
  src/crypto/modes/gcm.c\
  src/crypto/modes/ofb.c\
  src/crypto/obj/obj.c\
  src/crypto/obj/obj_error.c\
  src/crypto/obj/obj_xref.c\
  src/crypto/pem/pem_all.c\
  src/crypto/pem/pem_error.c\
  src/crypto/pem/pem_info.c\
  src/crypto/pem/pem_lib.c\
  src/crypto/pem/pem_oth.c\
  src/crypto/pem/pem_pk8.c\
  src/crypto/pem/pem_pkey.c\
  src/crypto/pem/pem_x509.c\
  src/crypto/pem/pem_xaux.c\
  src/crypto/pkcs8/p5_pbe.c\
  src/crypto/pkcs8/p5_pbev2.c\
  src/crypto/pkcs8/p8_pkey.c\
  src/crypto/pkcs8/pkcs8.c\
  src/crypto/pkcs8/pkcs8_error.c\
  src/crypto/poly1305/poly1305.c\
  src/crypto/poly1305/poly1305_arm.c\
  src/crypto/poly1305/poly1305_vec.c\
  src/crypto/rand/rand.c\
  src/crypto/rand/urandom.c\
  src/crypto/rand/windows.c\
  src/crypto/rc4/rc4.c\
  src/crypto/rsa/blinding.c\
  src/crypto/rsa/padding.c\
  src/crypto/rsa/rsa.c\
  src/crypto/rsa/rsa_asn1.c\
  src/crypto/rsa/rsa_error.c\
  src/crypto/rsa/rsa_impl.c\
  src/crypto/sha/sha1.c\
  src/crypto/sha/sha256.c\
  src/crypto/sha/sha512.c\
  src/crypto/stack/stack.c\
  src/crypto/thread.c\
  src/crypto/time_support.c\
  src/crypto/x509/a_digest.c\
  src/crypto/x509/a_sign.c\
  src/crypto/x509/a_strex.c\
  src/crypto/x509/a_verify.c\
  src/crypto/x509/asn1_gen.c\
  src/crypto/x509/by_dir.c\
  src/crypto/x509/by_file.c\
  src/crypto/x509/i2d_pr.c\
  src/crypto/x509/pkcs7.c\
  src/crypto/x509/t_crl.c\
  src/crypto/x509/t_x509.c\
  src/crypto/x509/t_x509a.c\
  src/crypto/x509/x509.c\
  src/crypto/x509/x509_att.c\
  src/crypto/x509/x509_cmp.c\
  src/crypto/x509/x509_d2.c\
  src/crypto/x509/x509_def.c\
  src/crypto/x509/x509_error.c\
  src/crypto/x509/x509_ext.c\
  src/crypto/x509/x509_lu.c\
  src/crypto/x509/x509_obj.c\
  src/crypto/x509/x509_r2x.c\
  src/crypto/x509/x509_req.c\
  src/crypto/x509/x509_set.c\
  src/crypto/x509/x509_trs.c\
  src/crypto/x509/x509_txt.c\
  src/crypto/x509/x509_v3.c\
  src/crypto/x509/x509_vfy.c\
  src/crypto/x509/x509_vpm.c\
  src/crypto/x509/x509cset.c\
  src/crypto/x509/x509name.c\
  src/crypto/x509/x509rset.c\
  src/crypto/x509/x509spki.c\
  src/crypto/x509/x509type.c\
  src/crypto/x509/x_algor.c\
  src/crypto/x509/x_all.c\
  src/crypto/x509/x_attrib.c\
  src/crypto/x509/x_crl.c\
  src/crypto/x509/x_exten.c\
  src/crypto/x509/x_info.c\
  src/crypto/x509/x_name.c\
  src/crypto/x509/x_pkey.c\
  src/crypto/x509/x_pubkey.c\
  src/crypto/x509/x_req.c\
  src/crypto/x509/x_sig.c\
  src/crypto/x509/x_spki.c\
  src/crypto/x509/x_val.c\
  src/crypto/x509/x_x509.c\
  src/crypto/x509/x_x509a.c\
  src/crypto/x509v3/pcy_cache.c\
  src/crypto/x509v3/pcy_data.c\
  src/crypto/x509v3/pcy_lib.c\
  src/crypto/x509v3/pcy_map.c\
  src/crypto/x509v3/pcy_node.c\
  src/crypto/x509v3/pcy_tree.c\
  src/crypto/x509v3/v3_akey.c\
  src/crypto/x509v3/v3_akeya.c\
  src/crypto/x509v3/v3_alt.c\
  src/crypto/x509v3/v3_bcons.c\
  src/crypto/x509v3/v3_bitst.c\
  src/crypto/x509v3/v3_conf.c\
  src/crypto/x509v3/v3_cpols.c\
  src/crypto/x509v3/v3_crld.c\
  src/crypto/x509v3/v3_enum.c\
  src/crypto/x509v3/v3_extku.c\
  src/crypto/x509v3/v3_genn.c\
  src/crypto/x509v3/v3_ia5.c\
  src/crypto/x509v3/v3_info.c\
  src/crypto/x509v3/v3_int.c\
  src/crypto/x509v3/v3_lib.c\
  src/crypto/x509v3/v3_ncons.c\
  src/crypto/x509v3/v3_pci.c\
  src/crypto/x509v3/v3_pcia.c\
  src/crypto/x509v3/v3_pcons.c\
  src/crypto/x509v3/v3_pku.c\
  src/crypto/x509v3/v3_pmaps.c\
  src/crypto/x509v3/v3_prn.c\
  src/crypto/x509v3/v3_purp.c\
  src/crypto/x509v3/v3_skey.c\
  src/crypto/x509v3/v3_sxnet.c\
  src/crypto/x509v3/v3_utl.c\
  src/crypto/x509v3/x509v3_error.c\

ssl_sources := \
  src/ssl/d1_both.c\
  src/ssl/d1_clnt.c\
  src/ssl/d1_lib.c\
  src/ssl/d1_meth.c\
  src/ssl/d1_pkt.c\
  src/ssl/d1_srtp.c\
  src/ssl/d1_srvr.c\
  src/ssl/pqueue/pqueue.c\
  src/ssl/s3_both.c\
  src/ssl/s3_clnt.c\
  src/ssl/s3_enc.c\
  src/ssl/s3_lib.c\
  src/ssl/s3_meth.c\
  src/ssl/s3_pkt.c\
  src/ssl/s3_srvr.c\
  src/ssl/ssl_algs.c\
  src/ssl/ssl_asn1.c\
  src/ssl/ssl_cert.c\
  src/ssl/ssl_ciph.c\
  src/ssl/ssl_error.c\
  src/ssl/ssl_lib.c\
  src/ssl/ssl_rsa.c\
  src/ssl/ssl_sess.c\
  src/ssl/ssl_stat.c\
  src/ssl/ssl_txt.c\
  src/ssl/t1_enc.c\
  src/ssl/t1_lib.c\
  src/ssl/t1_reneg.c\

tool_sources := \
  src/tool/args.cc\
  src/tool/client.cc\
  src/tool/const.cc\
  src/tool/digest.cc\
  src/tool/pkcs12.cc\
  src/tool/server.cc\
  src/tool/speed.cc\
  src/tool/tool.cc\
  src/tool/transport_common.cc\

linux_aarch64_sources := \
  linux-aarch64/crypto/aes/aesv8-armx.S\
  linux-aarch64/crypto/modes/ghashv8-armx.S\
  linux-aarch64/crypto/sha/sha1-armv8.S\
  linux-aarch64/crypto/sha/sha256-armv8.S\
  linux-aarch64/crypto/sha/sha512-armv8.S\

linux_arm_sources := \
  linux-arm/crypto/aes/aes-armv4.S\
  linux-arm/crypto/aes/aesv8-armx.S\
  linux-arm/crypto/aes/bsaes-armv7.S\
  linux-arm/crypto/bn/armv4-mont.S\
  linux-arm/crypto/modes/ghash-armv4.S\
  linux-arm/crypto/modes/ghashv8-armx.S\
  linux-arm/crypto/sha/sha1-armv4-large.S\
  linux-arm/crypto/sha/sha256-armv4.S\
  linux-arm/crypto/sha/sha512-armv4.S\
  src/crypto/chacha/chacha_vec_arm.S\
  src/crypto/poly1305/poly1305_arm_asm.S\

linux_x86_sources := \
  linux-x86/crypto/aes/aes-586.S\
  linux-x86/crypto/aes/aesni-x86.S\
  linux-x86/crypto/aes/vpaes-x86.S\
  linux-x86/crypto/bn/bn-586.S\
  linux-x86/crypto/bn/co-586.S\
  linux-x86/crypto/bn/x86-mont.S\
  linux-x86/crypto/cpu-x86-asm.S\
  linux-x86/crypto/md5/md5-586.S\
  linux-x86/crypto/modes/ghash-x86.S\
  linux-x86/crypto/rc4/rc4-586.S\
  linux-x86/crypto/sha/sha1-586.S\
  linux-x86/crypto/sha/sha256-586.S\
  linux-x86/crypto/sha/sha512-586.S\

linux_x86_64_sources := \
  linux-x86_64/crypto/aes/aes-x86_64.S\
  linux-x86_64/crypto/aes/aesni-x86_64.S\
  linux-x86_64/crypto/aes/bsaes-x86_64.S\
  linux-x86_64/crypto/aes/vpaes-x86_64.S\
  linux-x86_64/crypto/bn/rsaz-avx2.S\
  linux-x86_64/crypto/bn/rsaz-x86_64.S\
  linux-x86_64/crypto/bn/x86_64-mont.S\
  linux-x86_64/crypto/bn/x86_64-mont5.S\
  linux-x86_64/crypto/cpu-x86_64-asm.S\
  linux-x86_64/crypto/md5/md5-x86_64.S\
  linux-x86_64/crypto/modes/aesni-gcm-x86_64.S\
  linux-x86_64/crypto/modes/ghash-x86_64.S\
  linux-x86_64/crypto/rc4/rc4-md5-x86_64.S\
  linux-x86_64/crypto/rc4/rc4-x86_64.S\
  linux-x86_64/crypto/sha/sha1-x86_64.S\
  linux-x86_64/crypto/sha/sha256-x86_64.S\
  linux-x86_64/crypto/sha/sha512-x86_64.S\

mac_x86_sources := \
  mac-x86/crypto/aes/aes-586.S\
  mac-x86/crypto/aes/aesni-x86.S\
  mac-x86/crypto/aes/vpaes-x86.S\
  mac-x86/crypto/bn/bn-586.S\
  mac-x86/crypto/bn/co-586.S\
  mac-x86/crypto/bn/x86-mont.S\
  mac-x86/crypto/cpu-x86-asm.S\
  mac-x86/crypto/md5/md5-586.S\
  mac-x86/crypto/modes/ghash-x86.S\
  mac-x86/crypto/rc4/rc4-586.S\
  mac-x86/crypto/sha/sha1-586.S\
  mac-x86/crypto/sha/sha256-586.S\
  mac-x86/crypto/sha/sha512-586.S\

mac_x86_64_sources := \
  mac-x86_64/crypto/aes/aes-x86_64.S\
  mac-x86_64/crypto/aes/aesni-x86_64.S\
  mac-x86_64/crypto/aes/bsaes-x86_64.S\
  mac-x86_64/crypto/aes/vpaes-x86_64.S\
  mac-x86_64/crypto/bn/rsaz-avx2.S\
  mac-x86_64/crypto/bn/rsaz-x86_64.S\
  mac-x86_64/crypto/bn/x86_64-mont.S\
  mac-x86_64/crypto/bn/x86_64-mont5.S\
  mac-x86_64/crypto/cpu-x86_64-asm.S\
  mac-x86_64/crypto/md5/md5-x86_64.S\
  mac-x86_64/crypto/modes/aesni-gcm-x86_64.S\
  mac-x86_64/crypto/modes/ghash-x86_64.S\
  mac-x86_64/crypto/rc4/rc4-md5-x86_64.S\
  mac-x86_64/crypto/rc4/rc4-x86_64.S\
  mac-x86_64/crypto/sha/sha1-x86_64.S\
  mac-x86_64/crypto/sha/sha256-x86_64.S\
  mac-x86_64/crypto/sha/sha512-x86_64.S\

win_x86_64_sources := \
  win-x86_64/crypto/aes/aes-x86_64.asm\
  win-x86_64/crypto/aes/aesni-x86_64.asm\
  win-x86_64/crypto/aes/bsaes-x86_64.asm\
  win-x86_64/crypto/aes/vpaes-x86_64.asm\
  win-x86_64/crypto/bn/rsaz-avx2.asm\
  win-x86_64/crypto/bn/rsaz-x86_64.asm\
  win-x86_64/crypto/bn/x86_64-mont.asm\
  win-x86_64/crypto/bn/x86_64-mont5.asm\
  win-x86_64/crypto/cpu-x86_64-asm.asm\
  win-x86_64/crypto/md5/md5-x86_64.asm\
  win-x86_64/crypto/modes/aesni-gcm-x86_64.asm\
  win-x86_64/crypto/modes/ghash-x86_64.asm\
  win-x86_64/crypto/rc4/rc4-md5-x86_64.asm\
  win-x86_64/crypto/rc4/rc4-x86_64.asm\
  win-x86_64/crypto/sha/sha1-x86_64.asm\
  win-x86_64/crypto/sha/sha256-x86_64.asm\
  win-x86_64/crypto/sha/sha512-x86_64.asm\

