Return-Path: <linux-wireless+bounces-31976-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHDUB4UxlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31976-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:39:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9618715A444
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C06B301BCE0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AB335557;
	Wed, 18 Feb 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbJq6E7d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B642ECEA3;
	Wed, 18 Feb 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450613; cv=none; b=WgtBDN0aWJzAauBwygJTD2fDvjlXn7PCPpNOwyWsTArrYy3rHBOQNlNex3H3beyYUot8xz3bhzH0NrmhwOFD4Z1OW0vS8Kgicezo+nKtj72+xEMrt9TfAmCpQXkPq1QOwFa/Rvs2T19DUlzzhOQaxASmVSdFEP1Zeil+ptjCHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450613; c=relaxed/simple;
	bh=0LeGm98KqVExci2vvu6SjzoBtiGH1qcdbzcO5wJ5lqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYQ074nZyze9fFZGhyosLz7IbSoyKRJ8NZfv3pX1y7n1joWjZRlXhNFcCcJXmqnixQyqXgSD1sPxlJ3iuRVzmh+TC5xyEasbFuzhwWR74a2wRwAvpRxZ8iaiN2175DhYFvGqgB4LKmq9z/2SNaW50o3b1YrgoapUwMY8lG9W6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbJq6E7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0F2C19425;
	Wed, 18 Feb 2026 21:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450612;
	bh=0LeGm98KqVExci2vvu6SjzoBtiGH1qcdbzcO5wJ5lqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbJq6E7dirP6hem2BPoJf7hEAikTjbr3hVlsE85ume5etX0r62FaVHsSVLkjOmejW
	 ePbJxSQYQzLHqpMTY3wp2DNbv2cuwgGCFEbvTT+i5OAfd6zfTcnTRZIBthd++Hxg4f
	 v118WKqVPhyvA3RuXsBfd70pUtebHZTiHBS+7n8yQzaViumKZ0AtyN5WYOLJreV+p8
	 SRiVGLkS48KvrIiocik5O6ADvhtnqLVAvUqhc/gsSn7+5km9lnxDE9YBnnfV0fSW4J
	 ktxlyRbeEbtF7EwfFFFspdwYGJLJgYeLXKIpQT/F2aMwZV3byLAKL1LChfMaHbuxd0
	 ghbVX/hL6hFfQ==
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
Subject: [PATCH 05/15] lib/crypto: arm64/aes: Migrate optimized CBC-based MACs into library
Date: Wed, 18 Feb 2026 13:34:51 -0800
Message-ID: <20260218213501.136844-6-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31976-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9618715A444
X-Rspamd-Action: no action

Instead of exposing the arm64-optimized CMAC, XCBC-MAC, and CBC-MAC code
via arm64-specific crypto_shash algorithms, instead just implement the
aes_cbcmac_blocks_arch() library function.  This is much simpler, it
makes the corresponding library functions be arm64-optimized, and it
fixes the longstanding issue where this optimized code was disabled by
default.  The corresponding algorithms still remain available through
crypto_shash, but individual architectures no longer need to handle it.

Note that to be compatible with the library using 'size_t' lengths, the
type of the return value and 'blocks' parameter to the assembly
functions had to be changed to 'size_t', and the assembly code had to be
updated accordingly to use the corresponding 64-bit registers.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/arm64/crypto/Kconfig    |   2 +-
 arch/arm64/crypto/aes-glue.c | 213 +----------------------------------
 include/crypto/aes.h         |   9 +-
 lib/crypto/arm64/aes-modes.S |  19 ++--
 lib/crypto/arm64/aes.h       |  48 +++++++-
 5 files changed, 61 insertions(+), 230 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 81ed892b3b72..82794afaffc9 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -142,11 +142,11 @@ config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AEAD cipher: AES in CCM mode (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE_BLK
 	select CRYPTO_AEAD
-	select CRYPTO_LIB_AES
+	select CRYPTO_LIB_AES_CBC_MACS
 	help
 	  AEAD cipher: AES cipher algorithms (FIPS-197) with
 	  CCM (Counter with Cipher Block Chaining-Message Authentication Code)
 	  authenticated encryption mode (NIST SP800-38C)
 
diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index fd7c3a560a71..e1b88f7e2d39 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -35,11 +35,10 @@
 #define aes_essiv_cbc_decrypt	ce_aes_essiv_cbc_decrypt
 #define aes_ctr_encrypt		ce_aes_ctr_encrypt
 #define aes_xctr_encrypt	ce_aes_xctr_encrypt
 #define aes_xts_encrypt		ce_aes_xts_encrypt
 #define aes_xts_decrypt		ce_aes_xts_decrypt
-#define aes_mac_update		ce_aes_mac_update
 MODULE_DESCRIPTION("AES-ECB/CBC/CTR/XTS/XCTR using ARMv8 Crypto Extensions");
 #else
 #define MODE			"neon"
 #define PRIO			200
 #define aes_ecb_encrypt		neon_aes_ecb_encrypt
@@ -52,11 +51,10 @@ MODULE_DESCRIPTION("AES-ECB/CBC/CTR/XTS/XCTR using ARMv8 Crypto Extensions");
 #define aes_essiv_cbc_decrypt	neon_aes_essiv_cbc_decrypt
 #define aes_ctr_encrypt		neon_aes_ctr_encrypt
 #define aes_xctr_encrypt	neon_aes_xctr_encrypt
 #define aes_xts_encrypt		neon_aes_xts_encrypt
 #define aes_xts_decrypt		neon_aes_xts_decrypt
-#define aes_mac_update		neon_aes_mac_update
 MODULE_DESCRIPTION("AES-ECB/CBC/CTR/XTS/XCTR using ARMv8 NEON");
 #endif
 #if defined(USE_V8_CRYPTO_EXTENSIONS) || !IS_ENABLED(CONFIG_CRYPTO_AES_ARM64_BS)
 MODULE_ALIAS_CRYPTO("ecb(aes)");
 MODULE_ALIAS_CRYPTO("cbc(aes)");
@@ -64,13 +62,10 @@ MODULE_ALIAS_CRYPTO("ctr(aes)");
 MODULE_ALIAS_CRYPTO("xts(aes)");
 MODULE_ALIAS_CRYPTO("xctr(aes)");
 #endif
 MODULE_ALIAS_CRYPTO("cts(cbc(aes))");
 MODULE_ALIAS_CRYPTO("essiv(cbc(aes),sha256)");
-MODULE_ALIAS_CRYPTO("cmac(aes)");
-MODULE_ALIAS_CRYPTO("xcbc(aes)");
-MODULE_ALIAS_CRYPTO("cbcmac(aes)");
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_IMPORT_NS("CRYPTO_INTERNAL");
 MODULE_LICENSE("GPL v2");
 
@@ -82,19 +77,10 @@ struct crypto_aes_xts_ctx {
 struct crypto_aes_essiv_cbc_ctx {
 	struct crypto_aes_ctx key1;
 	struct crypto_aes_ctx __aligned(8) key2;
 };
 
-struct mac_tfm_ctx {
-	struct crypto_aes_ctx key;
-	u8 __aligned(8) consts[];
-};
-
-struct mac_desc_ctx {
-	u8 dg[AES_BLOCK_SIZE];
-};
-
 static int skcipher_aes_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 			       unsigned int key_len)
 {
 	struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
@@ -721,215 +707,18 @@ static struct skcipher_alg aes_algs[] = { {
 	.setkey		= essiv_cbc_set_key,
 	.encrypt	= essiv_cbc_encrypt,
 	.decrypt	= essiv_cbc_decrypt,
 } };
 
-static int cbcmac_setkey(struct crypto_shash *tfm, const u8 *in_key,
-			 unsigned int key_len)
-{
-	struct mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
-
-	return aes_expandkey(&ctx->key, in_key, key_len);
-}
-
-static void cmac_gf128_mul_by_x(be128 *y, const be128 *x)
-{
-	u64 a = be64_to_cpu(x->a);
-	u64 b = be64_to_cpu(x->b);
-
-	y->a = cpu_to_be64((a << 1) | (b >> 63));
-	y->b = cpu_to_be64((b << 1) ^ ((a >> 63) ? 0x87 : 0));
-}
-
-static int cmac_setkey(struct crypto_shash *tfm, const u8 *in_key,
-		       unsigned int key_len)
-{
-	struct mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
-	be128 *consts = (be128 *)ctx->consts;
-	int rounds = 6 + key_len / 4;
-	int err;
-
-	err = cbcmac_setkey(tfm, in_key, key_len);
-	if (err)
-		return err;
-
-	/* encrypt the zero vector */
-	scoped_ksimd()
-		aes_ecb_encrypt(ctx->consts, (u8[AES_BLOCK_SIZE]){},
-				ctx->key.key_enc, rounds, 1);
-
-	cmac_gf128_mul_by_x(consts, consts);
-	cmac_gf128_mul_by_x(consts + 1, consts);
-
-	return 0;
-}
-
-static int xcbc_setkey(struct crypto_shash *tfm, const u8 *in_key,
-		       unsigned int key_len)
-{
-	static u8 const ks[3][AES_BLOCK_SIZE] = {
-		{ [0 ... AES_BLOCK_SIZE - 1] = 0x1 },
-		{ [0 ... AES_BLOCK_SIZE - 1] = 0x2 },
-		{ [0 ... AES_BLOCK_SIZE - 1] = 0x3 },
-	};
-
-	struct mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
-	int rounds = 6 + key_len / 4;
-	u8 key[AES_BLOCK_SIZE];
-	int err;
-
-	err = cbcmac_setkey(tfm, in_key, key_len);
-	if (err)
-		return err;
-
-	scoped_ksimd() {
-		aes_ecb_encrypt(key, ks[0], ctx->key.key_enc, rounds, 1);
-		aes_ecb_encrypt(ctx->consts, ks[1], ctx->key.key_enc, rounds, 2);
-	}
-
-	return cbcmac_setkey(tfm, key, sizeof(key));
-}
-
-static int mac_init(struct shash_desc *desc)
-{
-	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	memset(ctx->dg, 0, AES_BLOCK_SIZE);
-	return 0;
-}
-
-static void mac_do_update(struct crypto_aes_ctx *ctx, u8 const in[], int blocks,
-			  u8 dg[], int enc_before)
-{
-	int rounds = 6 + ctx->key_length / 4;
-	int rem;
-
-	do {
-		scoped_ksimd()
-			rem = aes_mac_update(in, ctx->key_enc, rounds, blocks,
-					     dg, enc_before, !enc_before);
-		in += (blocks - rem) * AES_BLOCK_SIZE;
-		blocks = rem;
-	} while (blocks);
-}
-
-static int mac_update(struct shash_desc *desc, const u8 *p, unsigned int len)
-{
-	struct mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
-	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
-	int blocks = len / AES_BLOCK_SIZE;
-
-	len %= AES_BLOCK_SIZE;
-	mac_do_update(&tctx->key, p, blocks, ctx->dg, 0);
-	return len;
-}
-
-static int cbcmac_finup(struct shash_desc *desc, const u8 *src,
-			unsigned int len, u8 *out)
-{
-	struct mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
-	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	if (len) {
-		crypto_xor(ctx->dg, src, len);
-		mac_do_update(&tctx->key, NULL, 0, ctx->dg, 1);
-	}
-	memcpy(out, ctx->dg, AES_BLOCK_SIZE);
-	return 0;
-}
-
-static int cmac_finup(struct shash_desc *desc, const u8 *src, unsigned int len,
-		      u8 *out)
-{
-	struct mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
-	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
-	u8 *consts = tctx->consts;
-
-	crypto_xor(ctx->dg, src, len);
-	if (len != AES_BLOCK_SIZE) {
-		ctx->dg[len] ^= 0x80;
-		consts += AES_BLOCK_SIZE;
-	}
-	mac_do_update(&tctx->key, consts, 1, ctx->dg, 0);
-	memcpy(out, ctx->dg, AES_BLOCK_SIZE);
-	return 0;
-}
-
-static struct shash_alg mac_algs[] = { {
-	.base.cra_name		= "cmac(aes)",
-	.base.cra_driver_name	= "cmac-aes-" MODE,
-	.base.cra_priority	= PRIO,
-	.base.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				  CRYPTO_AHASH_ALG_FINAL_NONZERO,
-	.base.cra_blocksize	= AES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct mac_tfm_ctx) +
-				  2 * AES_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-
-	.digestsize		= AES_BLOCK_SIZE,
-	.init			= mac_init,
-	.update			= mac_update,
-	.finup			= cmac_finup,
-	.setkey			= cmac_setkey,
-	.descsize		= sizeof(struct mac_desc_ctx),
-}, {
-	.base.cra_name		= "xcbc(aes)",
-	.base.cra_driver_name	= "xcbc-aes-" MODE,
-	.base.cra_priority	= PRIO,
-	.base.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				  CRYPTO_AHASH_ALG_FINAL_NONZERO,
-	.base.cra_blocksize	= AES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct mac_tfm_ctx) +
-				  2 * AES_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-
-	.digestsize		= AES_BLOCK_SIZE,
-	.init			= mac_init,
-	.update			= mac_update,
-	.finup			= cmac_finup,
-	.setkey			= xcbc_setkey,
-	.descsize		= sizeof(struct mac_desc_ctx),
-}, {
-	.base.cra_name		= "cbcmac(aes)",
-	.base.cra_driver_name	= "cbcmac-aes-" MODE,
-	.base.cra_priority	= PRIO,
-	.base.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY,
-	.base.cra_blocksize	= AES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct mac_tfm_ctx),
-	.base.cra_module	= THIS_MODULE,
-
-	.digestsize		= AES_BLOCK_SIZE,
-	.init			= mac_init,
-	.update			= mac_update,
-	.finup			= cbcmac_finup,
-	.setkey			= cbcmac_setkey,
-	.descsize		= sizeof(struct mac_desc_ctx),
-} };
-
 static void aes_exit(void)
 {
-	crypto_unregister_shashes(mac_algs, ARRAY_SIZE(mac_algs));
 	crypto_unregister_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
 static int __init aes_init(void)
 {
-	int err;
-
-	err = crypto_register_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
-	if (err)
-		return err;
-
-	err = crypto_register_shashes(mac_algs, ARRAY_SIZE(mac_algs));
-	if (err)
-		goto unregister_ciphers;
-
-	return 0;
-
-unregister_ciphers:
-	crypto_unregister_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
-	return err;
+	return crypto_register_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
 #ifdef USE_V8_CRYPTO_EXTENSIONS
 module_cpu_feature_match(AES, aes_init);
 #else
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 91bf4667d3e9..3feb4105c2a2 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -198,13 +198,10 @@ asmlinkage void neon_aes_essiv_cbc_encrypt(u8 out[], u8 const in[],
 					   u32 const rk2[]);
 asmlinkage void neon_aes_essiv_cbc_decrypt(u8 out[], u8 const in[],
 					   u32 const rk1[], int rounds,
 					   int blocks, u8 iv[],
 					   u32 const rk2[]);
-asmlinkage int neon_aes_mac_update(u8 const in[], u32 const rk[], int rounds,
-				   int blocks, u8 dg[], int enc_before,
-				   int enc_after);
 
 asmlinkage void ce_aes_ecb_encrypt(u8 out[], u8 const in[], u32 const rk[],
 				   int rounds, int blocks);
 asmlinkage void ce_aes_ecb_decrypt(u8 out[], u8 const in[], u32 const rk[],
 				   int rounds, int blocks);
@@ -231,13 +228,13 @@ asmlinkage void ce_aes_essiv_cbc_encrypt(u8 out[], u8 const in[],
 					 u32 const rk1[], int rounds,
 					 int blocks, u8 iv[], u32 const rk2[]);
 asmlinkage void ce_aes_essiv_cbc_decrypt(u8 out[], u8 const in[],
 					 u32 const rk1[], int rounds,
 					 int blocks, u8 iv[], u32 const rk2[]);
-asmlinkage int ce_aes_mac_update(u8 const in[], u32 const rk[], int rounds,
-				 int blocks, u8 dg[], int enc_before,
-				 int enc_after);
+asmlinkage size_t ce_aes_mac_update(u8 const in[], u32 const rk[], int rounds,
+				    size_t blocks, u8 dg[], int enc_before,
+				    int enc_after);
 #elif defined(CONFIG_PPC)
 void ppc_expand_key_128(u32 *key_enc, const u8 *key);
 void ppc_expand_key_192(u32 *key_enc, const u8 *key);
 void ppc_expand_key_256(u32 *key_enc, const u8 *key);
 void ppc_generate_decrypt_key(u32 *key_dec, u32 *key_enc, unsigned int key_len);
diff --git a/lib/crypto/arm64/aes-modes.S b/lib/crypto/arm64/aes-modes.S
index e793478f37c1..fb1332108986 100644
--- a/lib/crypto/arm64/aes-modes.S
+++ b/lib/crypto/arm64/aes-modes.S
@@ -813,54 +813,57 @@ AES_FUNC_START(aes_xts_decrypt)
 	st1		{v2.16b}, [x4]			/* overlapping stores */
 	mov		w4, wzr
 	b		.Lxtsdecctsout
 AES_FUNC_END(aes_xts_decrypt)
 
+#if IS_ENABLED(CONFIG_CRYPTO_LIB_AES_CBC_MACS)
 	/*
-	 * aes_mac_update(u8 const in[], u32 const rk[], int rounds,
-	 *		  int blocks, u8 dg[], int enc_before, int enc_after)
+	 * size_t aes_mac_update(u8 const in[], u32 const rk[], int rounds,
+	 *			 size_t blocks, u8 dg[], int enc_before,
+	 *			 int enc_after);
 	 */
 AES_FUNC_START(aes_mac_update)
 	ld1		{v0.16b}, [x4]			/* get dg */
 	enc_prepare	w2, x1, x7
 	cbz		w5, .Lmacloop4x
 
 	encrypt_block	v0, w2, x1, x7, w8
 
 .Lmacloop4x:
-	subs		w3, w3, #4
+	subs		x3, x3, #4
 	bmi		.Lmac1x
 	ld1		{v1.16b-v4.16b}, [x0], #64	/* get next pt block */
 	eor		v0.16b, v0.16b, v1.16b		/* ..and xor with dg */
 	encrypt_block	v0, w2, x1, x7, w8
 	eor		v0.16b, v0.16b, v2.16b
 	encrypt_block	v0, w2, x1, x7, w8
 	eor		v0.16b, v0.16b, v3.16b
 	encrypt_block	v0, w2, x1, x7, w8
 	eor		v0.16b, v0.16b, v4.16b
-	cmp		w3, wzr
+	cmp		x3, xzr
 	csinv		w5, w6, wzr, eq
 	cbz		w5, .Lmacout
 	encrypt_block	v0, w2, x1, x7, w8
 	st1		{v0.16b}, [x4]			/* return dg */
 	cond_yield	.Lmacout, x7, x8
 	b		.Lmacloop4x
 .Lmac1x:
-	add		w3, w3, #4
+	add		x3, x3, #4
 .Lmacloop:
-	cbz		w3, .Lmacout
+	cbz		x3, .Lmacout
 	ld1		{v1.16b}, [x0], #16		/* get next pt block */
 	eor		v0.16b, v0.16b, v1.16b		/* ..and xor with dg */
 
-	subs		w3, w3, #1
+	subs		x3, x3, #1
 	csinv		w5, w6, wzr, eq
 	cbz		w5, .Lmacout
 
 .Lmacenc:
 	encrypt_block	v0, w2, x1, x7, w8
 	b		.Lmacloop
 
 .Lmacout:
 	st1		{v0.16b}, [x4]			/* return dg */
-	mov		w0, w3
+	mov		x0, x3
 	ret
 AES_FUNC_END(aes_mac_update)
+#endif /* CONFIG_CRYPTO_LIB_AES_CBC_MACS */
diff --git a/lib/crypto/arm64/aes.h b/lib/crypto/arm64/aes.h
index 69f465c668f0..78e7b4e5f120 100644
--- a/lib/crypto/arm64/aes.h
+++ b/lib/crypto/arm64/aes.h
@@ -9,10 +9,11 @@
 #include <asm/neon.h>
 #include <asm/simd.h>
 #include <linux/unaligned.h>
 #include <linux/cpufeature.h>
 
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_aes);
 
 struct aes_block {
 	u8 b[AES_BLOCK_SIZE];
 };
@@ -26,10 +27,13 @@ asmlinkage void __aes_ce_encrypt(const u32 rk[], u8 out[AES_BLOCK_SIZE],
 asmlinkage void __aes_ce_decrypt(const u32 inv_rk[], u8 out[AES_BLOCK_SIZE],
 				 const u8 in[AES_BLOCK_SIZE], int rounds);
 asmlinkage u32 __aes_ce_sub(u32 l);
 asmlinkage void __aes_ce_invert(struct aes_block *out,
 				const struct aes_block *in);
+asmlinkage size_t neon_aes_mac_update(u8 const in[], u32 const rk[], int rounds,
+				      size_t blocks, u8 dg[], int enc_before,
+				      int enc_after);
 
 /*
  * Expand an AES key using the crypto extensions if supported and usable or
  * generic code otherwise.  The expanded key format is compatible between the
  * two cases.  The outputs are @rndkeys (required) and @inv_rndkeys (optional).
@@ -137,11 +141,10 @@ EXPORT_SYMBOL_NS_GPL(neon_aes_ctr_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(neon_aes_xctr_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(neon_aes_xts_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(neon_aes_xts_decrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(neon_aes_essiv_cbc_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(neon_aes_essiv_cbc_decrypt, "CRYPTO_INTERNAL");
-EXPORT_SYMBOL_NS_GPL(neon_aes_mac_update, "CRYPTO_INTERNAL");
 
 EXPORT_SYMBOL_NS_GPL(ce_aes_ecb_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_ecb_decrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_cbc_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_cbc_decrypt, "CRYPTO_INTERNAL");
@@ -151,10 +154,12 @@ EXPORT_SYMBOL_NS_GPL(ce_aes_ctr_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_xctr_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_xts_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_xts_decrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_essiv_cbc_encrypt, "CRYPTO_INTERNAL");
 EXPORT_SYMBOL_NS_GPL(ce_aes_essiv_cbc_decrypt, "CRYPTO_INTERNAL");
+#endif
+#if IS_MODULE(CONFIG_CRYPTO_AES_ARM64_CE_CCM)
 EXPORT_SYMBOL_NS_GPL(ce_aes_mac_update, "CRYPTO_INTERNAL");
 #endif
 
 static void aes_encrypt_arch(const struct aes_enckey *key,
 			     u8 out[AES_BLOCK_SIZE],
@@ -182,13 +187,50 @@ static void aes_decrypt_arch(const struct aes_key *key,
 		__aes_arm64_decrypt(key->inv_k.inv_rndkeys, out, in,
 				    key->nrounds);
 	}
 }
 
+#if IS_ENABLED(CONFIG_CRYPTO_LIB_AES_CBC_MACS)
+#define aes_cbcmac_blocks_arch aes_cbcmac_blocks_arch
+static bool aes_cbcmac_blocks_arch(u8 h[AES_BLOCK_SIZE],
+				   const struct aes_enckey *key, const u8 *data,
+				   size_t nblocks, bool enc_before,
+				   bool enc_after)
+{
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+	    static_branch_likely(&have_neon) && likely(may_use_simd())) {
+		do {
+			size_t rem;
+
+			scoped_ksimd() {
+				if (static_branch_likely(&have_aes))
+					rem = ce_aes_mac_update(
+						data, key->k.rndkeys,
+						key->nrounds, nblocks, h,
+						enc_before, enc_after);
+				else
+					rem = neon_aes_mac_update(
+						data, key->k.rndkeys,
+						key->nrounds, nblocks, h,
+						enc_before, enc_after);
+			}
+			data += (nblocks - rem) * AES_BLOCK_SIZE;
+			nblocks = rem;
+			enc_before = false;
+		} while (nblocks);
+		return true;
+	}
+	return false;
+}
+#endif /* CONFIG_CRYPTO_LIB_AES_CBC_MACS */
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 #define aes_mod_init_arch aes_mod_init_arch
 static void aes_mod_init_arch(void)
 {
-	if (cpu_have_named_feature(AES))
-		static_branch_enable(&have_aes);
+	if (cpu_have_named_feature(ASIMD)) {
+		static_branch_enable(&have_neon);
+		if (cpu_have_named_feature(AES))
+			static_branch_enable(&have_aes);
+	}
 }
 #endif /* CONFIG_KERNEL_MODE_NEON */
-- 
2.53.0


