Return-Path: <linux-wireless+bounces-31973-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKU5BSYxlml5cAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31973-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:37:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA6515A3A4
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7D430480E1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4882FE575;
	Wed, 18 Feb 2026 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYQ3AI9B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593232F6920;
	Wed, 18 Feb 2026 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450611; cv=none; b=njgDNyEnoARfHs2+U0r4r3+8Gpa1J/urff5Gr1AGFBcxJw2OuAMhIIQuj0haiRKuDIZzPS3Ho/E+Azy4ooavCabfOS9QtFmxURtgyCdLhIOSqtrerpuRA85dtd3OkyFVCCBITIxcyrRvFJRX2/h3SoldPb2G6T6wTTsNoxef/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450611; c=relaxed/simple;
	bh=S4zQmtBxe0E3DIi0hm6e0ss7TJDmWjR02e2kDFr1lzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmFdqXTCg/nXSACamRjUzZotlCD0ds2eqmQ2TVSTF/fra/HOmtflubH8wSw3twHG3J8KNVNQegnTxdIF0eHj0vPOgHFnIYGn+DRwxOq5ApKdM6t5lU8CDl8NFX1WlwgEFDLSmoT1y8A5JYJsqB4OVQChXrBiwE+7CxdPL6yoRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYQ3AI9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B66DC2BC87;
	Wed, 18 Feb 2026 21:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450611;
	bh=S4zQmtBxe0E3DIi0hm6e0ss7TJDmWjR02e2kDFr1lzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYQ3AI9Bo8dGg0hMwROuintnVLzOqhK2vZI4c2yOwLofe1PQg6B/pItjzSqDpqS3I
	 ZV2871TKNFtzdqmW8TE5YM9EXZ7HRE8OWvdgawxtqpdQ5m7f/s8uS2vg+U8FEf7ikf
	 qcmc5aiVI4hhVHYMpjUEpv+HqJ13ZDr59hPhSR3Wla5Hw2htKzwRoxkQboT/b2SCBu
	 fbuQn8dLFKNA49erokFxe3JaiwdRd64x25iZMsgTojSyxvkU7xbJJ6PXS5XwPszmVQ
	 L1aCSsZQEX7m/YEgdFEU52qfbxDgSVR72hlpsVcMKI6DxiU2GhhwjD1XfT4D+YKp4s
	 B2vB+9dxg1Hmg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 02/15] crypto: aes - Add cmac, xcbc, and cbcmac algorithms using library
Date: Wed, 18 Feb 2026 13:34:48 -0800
Message-ID: <20260218213501.136844-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218213501.136844-1-ebiggers@kernel.org>
References: <20260218213501.136844-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31973-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7FA6515A3A4
X-Rspamd-Action: no action

Update the "aes" module to implement "cmac(aes)", "xcbc(aes)", and
"cbcmac(aes)" algorithms using the corresponding library functions, and
register these with the crypto_shash API.  Each algorithm is included
only if the corresponding existing kconfig option is enabled.

This allows the architecture-optimized implementations of these
algorithms to continue to be accessible via the crypto_shash API once
they are migrated into the library.

For "xcbc(aes)", I also fixed the bug where AES key lengths other than
128 bits were allowed, so that this bug didn't have to be implemented in
the library.  The AES-XCBC-MAC specification (RFC 3566) is clear that
key lengths other than 128 bits MUST NOT be supported.  AES-XCBC-MAC
derives a 128-bit subkey internally, so the nonstandard support for
longer AES keys didn't really work: AES-128 was still used internally.

In the unlikely event that someone is actually relying on the broken and
nonstandard support for longer AES-XCBC-MAC keys, we can fairly easily
reintroduce it.  But it seems unnecessary: the only user of "xcbc(aes)"
seems to be IPsec, which uses 128-bit keys with it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/Kconfig                       |   2 +
 crypto/aes.c                         | 183 ++++++++++++++++++++++++++-
 crypto/testmgr.c                     |  10 +-
 drivers/crypto/starfive/jh7110-aes.c |   2 +-
 4 files changed, 190 insertions(+), 7 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e2b4106ac961..256ce4729c8d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -359,10 +359,12 @@ menu "Block ciphers"
 
 config CRYPTO_AES
 	tristate "AES (Advanced Encryption Standard)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
+	select CRYPTO_LIB_AES_CBC_MACS if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
+	select CRYPTO_HASH if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
 	help
 	  AES cipher algorithms (Rijndael)(FIPS-197, ISO/IEC 18033-3)
 
 	  Rijndael appears to be consistently a very good performer in
 	  both hardware and software across a wide range of computing
diff --git a/crypto/aes.c b/crypto/aes.c
index ae8385df0ce5..6bf23eb0503f 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -3,12 +3,14 @@
  * Crypto API support for AES block cipher
  *
  * Copyright 2026 Google LLC
  */
 
+#include <crypto/aes-cbc-macs.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
+#include <crypto/internal/hash.h>
 #include <linux/module.h>
 
 static_assert(__alignof__(struct aes_key) <= CRYPTO_MINALIGN);
 
 static int crypto_aes_setkey(struct crypto_tfm *tfm, const u8 *in_key,
@@ -31,10 +33,102 @@ static void crypto_aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 	const struct aes_key *key = crypto_tfm_ctx(tfm);
 
 	aes_decrypt(key, out, in);
 }
 
+static_assert(__alignof__(struct aes_cmac_key) <= CRYPTO_MINALIGN);
+#define AES_CMAC_KEY(tfm) ((struct aes_cmac_key *)crypto_shash_ctx(tfm))
+#define AES_CMAC_CTX(desc) ((struct aes_cmac_ctx *)shash_desc_ctx(desc))
+
+static int __maybe_unused crypto_aes_cmac_setkey(struct crypto_shash *tfm,
+						 const u8 *in_key,
+						 unsigned int key_len)
+{
+	return aes_cmac_preparekey(AES_CMAC_KEY(tfm), in_key, key_len);
+}
+
+static int __maybe_unused crypto_aes_xcbc_setkey(struct crypto_shash *tfm,
+						 const u8 *in_key,
+						 unsigned int key_len)
+{
+	if (key_len != AES_KEYSIZE_128)
+		return -EINVAL;
+	aes_xcbcmac_preparekey(AES_CMAC_KEY(tfm), in_key);
+	return 0;
+}
+
+static int __maybe_unused crypto_aes_cmac_init(struct shash_desc *desc)
+{
+	aes_cmac_init(AES_CMAC_CTX(desc), AES_CMAC_KEY(desc->tfm));
+	return 0;
+}
+
+static int __maybe_unused crypto_aes_cmac_update(struct shash_desc *desc,
+						 const u8 *data,
+						 unsigned int len)
+{
+	aes_cmac_update(AES_CMAC_CTX(desc), data, len);
+	return 0;
+}
+
+static int __maybe_unused crypto_aes_cmac_final(struct shash_desc *desc,
+						u8 *out)
+{
+	aes_cmac_final(AES_CMAC_CTX(desc), out);
+	return 0;
+}
+
+static int __maybe_unused crypto_aes_cmac_digest(struct shash_desc *desc,
+						 const u8 *data,
+						 unsigned int len, u8 *out)
+{
+	aes_cmac(AES_CMAC_KEY(desc->tfm), data, len, out);
+	return 0;
+}
+
+static_assert(__alignof__(struct aes_enckey) <= CRYPTO_MINALIGN);
+#define AES_CBCMAC_KEY(tfm) ((struct aes_enckey *)crypto_shash_ctx(tfm))
+#define AES_CBCMAC_CTX(desc) ((struct aes_cbcmac_ctx *)shash_desc_ctx(desc))
+
+static int __maybe_unused crypto_aes_cbcmac_setkey(struct crypto_shash *tfm,
+						   const u8 *in_key,
+						   unsigned int key_len)
+{
+	return aes_prepareenckey(AES_CBCMAC_KEY(tfm), in_key, key_len);
+}
+
+static int __maybe_unused crypto_aes_cbcmac_init(struct shash_desc *desc)
+{
+	aes_cbcmac_init(AES_CBCMAC_CTX(desc), AES_CBCMAC_KEY(desc->tfm));
+	return 0;
+}
+
+static int __maybe_unused crypto_aes_cbcmac_update(struct shash_desc *desc,
+						   const u8 *data,
+						   unsigned int len)
+{
+	aes_cbcmac_update(AES_CBCMAC_CTX(desc), data, len);
+	return 0;
+}
+
+static int __maybe_unused crypto_aes_cbcmac_final(struct shash_desc *desc,
+						  u8 *out)
+{
+	aes_cbcmac_final(AES_CBCMAC_CTX(desc), out);
+	return 0;
+}
+
+static int __maybe_unused crypto_aes_cbcmac_digest(struct shash_desc *desc,
+						   const u8 *data,
+						   unsigned int len, u8 *out)
+{
+	aes_cbcmac_init(AES_CBCMAC_CTX(desc), AES_CBCMAC_KEY(desc->tfm));
+	aes_cbcmac_update(AES_CBCMAC_CTX(desc), data, len);
+	aes_cbcmac_final(AES_CBCMAC_CTX(desc), out);
+	return 0;
+}
+
 static struct crypto_alg alg = {
 	.cra_name = "aes",
 	.cra_driver_name = "aes-lib",
 	.cra_priority = 100,
 	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
@@ -46,21 +140,108 @@ static struct crypto_alg alg = {
 			       .cia_setkey = crypto_aes_setkey,
 			       .cia_encrypt = crypto_aes_encrypt,
 			       .cia_decrypt = crypto_aes_decrypt } }
 };
 
+static struct shash_alg mac_algs[] = {
+#if IS_ENABLED(CONFIG_CRYPTO_CMAC)
+	{
+		.base.cra_name = "cmac(aes)",
+		.base.cra_driver_name = "cmac-aes-lib",
+		.base.cra_priority = 300,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct aes_cmac_key),
+		.base.cra_module = THIS_MODULE,
+		.digestsize = AES_BLOCK_SIZE,
+		.setkey = crypto_aes_cmac_setkey,
+		.init = crypto_aes_cmac_init,
+		.update = crypto_aes_cmac_update,
+		.final = crypto_aes_cmac_final,
+		.digest = crypto_aes_cmac_digest,
+		.descsize = sizeof(struct aes_cmac_ctx),
+	},
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_XCBC)
+	{
+		/*
+		 * Note that the only difference between xcbc(aes) and cmac(aes)
+		 * is the preparekey function.
+		 */
+		.base.cra_name = "xcbc(aes)",
+		.base.cra_driver_name = "xcbc-aes-lib",
+		.base.cra_priority = 300,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct aes_cmac_key),
+		.base.cra_module = THIS_MODULE,
+		.digestsize = AES_BLOCK_SIZE,
+		.setkey = crypto_aes_xcbc_setkey,
+		.init = crypto_aes_cmac_init,
+		.update = crypto_aes_cmac_update,
+		.final = crypto_aes_cmac_final,
+		.digest = crypto_aes_cmac_digest,
+		.descsize = sizeof(struct aes_cmac_ctx),
+	},
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_CCM)
+	{
+		.base.cra_name = "cbcmac(aes)",
+		.base.cra_driver_name = "cbcmac-aes-lib",
+		.base.cra_priority = 300,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct aes_enckey),
+		.base.cra_module = THIS_MODULE,
+		.digestsize = AES_BLOCK_SIZE,
+		.setkey = crypto_aes_cbcmac_setkey,
+		.init = crypto_aes_cbcmac_init,
+		.update = crypto_aes_cbcmac_update,
+		.final = crypto_aes_cbcmac_final,
+		.digest = crypto_aes_cbcmac_digest,
+		.descsize = sizeof(struct aes_cbcmac_ctx),
+	},
+#endif
+};
+
 static int __init crypto_aes_mod_init(void)
 {
-	return crypto_register_alg(&alg);
+	int err = crypto_register_alg(&alg);
+
+	if (err)
+		return err;
+
+	if (ARRAY_SIZE(mac_algs) > 0) {
+		err = crypto_register_shashes(mac_algs, ARRAY_SIZE(mac_algs));
+		if (err)
+			goto err_unregister_alg;
+	} /* Else, CONFIG_CRYPTO_HASH might not be enabled. */
+	return 0;
+
+err_unregister_alg:
+	crypto_unregister_alg(&alg);
+	return err;
 }
 module_init(crypto_aes_mod_init);
 
 static void __exit crypto_aes_mod_exit(void)
 {
+	if (ARRAY_SIZE(mac_algs) > 0)
+		crypto_unregister_shashes(mac_algs, ARRAY_SIZE(mac_algs));
 	crypto_unregister_alg(&alg);
 }
 module_exit(crypto_aes_mod_exit);
 
 MODULE_DESCRIPTION("Crypto API support for AES block cipher");
+MODULE_IMPORT_NS("CRYPTO_INTERNAL");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("aes");
 MODULE_ALIAS_CRYPTO("aes-lib");
+#if IS_ENABLED(CONFIG_CRYPTO_CMAC)
+MODULE_ALIAS_CRYPTO("cmac(aes)");
+MODULE_ALIAS_CRYPTO("cmac-aes-lib");
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_XCBC)
+MODULE_ALIAS_CRYPTO("xcbc(aes)");
+MODULE_ALIAS_CRYPTO("xcbc-aes-lib");
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_CCM)
+MODULE_ALIAS_CRYPTO("cbcmac(aes)");
+MODULE_ALIAS_CRYPTO("cbcmac-aes-lib");
+#endif
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index b940721447fa..fa7217029f44 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4386,11 +4386,11 @@ static const struct alg_test_desc alg_test_descs[] = {
 			.cipher = __VECS(aes_cbc_tv_template)
 		}
 	}, {
 #endif
 		.alg = "cbcmac(aes)",
-		.generic_driver = "cbcmac(aes-lib)",
+		.generic_driver = "cbcmac-aes-lib",
 		.test = alg_test_hash,
 		.suite = {
 			.hash = __VECS(aes_cbcmac_tv_template)
 		}
 	}, {
@@ -4399,11 +4399,11 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(sm4_cbcmac_tv_template)
 		}
 	}, {
 		.alg = "ccm(aes)",
-		.generic_driver = "ccm_base(ctr(aes-lib),cbcmac(aes-lib))",
+		.generic_driver = "ccm_base(ctr(aes-lib),cbcmac-aes-lib)",
 		.test = alg_test_aead,
 		.fips_allowed = 1,
 		.suite = {
 			.aead = {
 				____VECS(aes_ccm_tv_template),
@@ -4427,11 +4427,11 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.cipher = __VECS(chacha20_tv_template)
 		},
 	}, {
 		.alg = "cmac(aes)",
-		.generic_driver = "cmac(aes-lib)",
+		.generic_driver = "cmac-aes-lib",
 		.fips_allowed = 1,
 		.test = alg_test_hash,
 		.suite = {
 			.hash = __VECS(aes_cmac128_tv_template)
 		}
@@ -5324,11 +5324,11 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.aad_iv = 1,
 			}
 		}
 	}, {
 		.alg = "rfc4309(ccm(aes))",
-		.generic_driver = "rfc4309(ccm_base(ctr(aes-lib),cbcmac(aes-lib)))",
+		.generic_driver = "rfc4309(ccm_base(ctr(aes-lib),cbcmac-aes-lib))",
 		.test = alg_test_aead,
 		.fips_allowed = 1,
 		.suite = {
 			.aead = {
 				____VECS(aes_ccm_rfc4309_tv_template),
@@ -5513,11 +5513,11 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.sig = __VECS(x962_ecdsa_nist_p521_tv_template)
 		}
 	}, {
 		.alg = "xcbc(aes)",
-		.generic_driver = "xcbc(aes-lib)",
+		.generic_driver = "xcbc-aes-lib",
 		.test = alg_test_hash,
 		.suite = {
 			.hash = __VECS(aes_xcbc128_tv_template)
 		}
 	}, {
diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index c1dc1e43e117..2e2d97d17e6c 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -1001,11 +1001,11 @@ static int starfive_aes_ctr_init_tfm(struct crypto_skcipher *tfm)
 	return starfive_aes_init_tfm(tfm, "ctr(aes-lib)");
 }
 
 static int starfive_aes_ccm_init_tfm(struct crypto_aead *tfm)
 {
-	return starfive_aes_aead_init_tfm(tfm, "ccm_base(ctr(aes-lib),cbcmac(aes-lib))");
+	return starfive_aes_aead_init_tfm(tfm, "ccm_base(ctr(aes-lib),cbcmac-aes-lib)");
 }
 
 static int starfive_aes_gcm_init_tfm(struct crypto_aead *tfm)
 {
 	return starfive_aes_aead_init_tfm(tfm, "gcm_base(ctr(aes-lib),ghash-generic)");
-- 
2.53.0


