Return-Path: <linux-wireless+bounces-31975-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH7JF2oxlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31975-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:38:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC10F15A42C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF6A3060BDB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9033507A;
	Wed, 18 Feb 2026 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDk5vBec"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AE335077;
	Wed, 18 Feb 2026 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450612; cv=none; b=VzKG2Cr5rSt9ZQATyKPPGJThp/I3psM7eLDMBFBcN65jUEythosDWsadxbIfTCiEOUze8tGh+gtkzOdjr8nePhzL+mN3DcmDMUYgdfPEmdveoTzGIqqE/kyBWSgLwDm7famkqH0SCk6puAp8Py/Vn0PojqXi+ZoIkxqz8aqn3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450612; c=relaxed/simple;
	bh=phuk8jYQce0F4jNXOX5zObjH9GAYqfm6mN8RyTfqKxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRr2XnJAssRjOLJgzCzEgDDw+Lrlc8apRlhiqMnrbutNe+MiNUgEjAidnBzBnDL9D+QALZruLX11riCYy8Y20j3YjuPBxOpZASLxki3TXCRKZG2pA50FP1/d19rCn4KIceewfHm1V5me7wmkuGW7RfDG6FQqFPk4nMC03vsPNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDk5vBec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D194EC2BC87;
	Wed, 18 Feb 2026 21:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450612;
	bh=phuk8jYQce0F4jNXOX5zObjH9GAYqfm6mN8RyTfqKxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDk5vBecbvLAatyHy+8rPljkUDUjwovG/5lkR86yOs+aba04Sw8ScWMjzZHM5nsP8
	 TYE1PW3d0A8+E2LJNr6h+18HQzhjPszUeXD5MhP7JZniMxF6auAInqxEzYB7eSczZI
	 2nushArwUNjn1uy1Imf7sPrjgUXBPjn70s1vJV/mLqClKipQ6F3hA38dLFoIUd9tc4
	 H6F4K0xUkPXDYa60HRZNx3CVa/9rrarlW4ne1mBraYE60RoXWL1OyhsouQQbnR38ti
	 WkBoUP7XrG7B1xH5zO3pGZyNlJkUfRKGV2w3Xnx7+3/HkMcyNoaNPWLP4KLBh0kWrm
	 Sv7Y7ERBgPDmw==
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
Subject: [PATCH 04/15] lib/crypto: arm64/aes: Move assembly code for AES modes into libaes
Date: Wed, 18 Feb 2026 13:34:50 -0800
Message-ID: <20260218213501.136844-5-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31975-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: CC10F15A42C
X-Rspamd-Action: no action

To migrate the support for CBC-based MACs into libaes, the corresponding
arm64 assembly code needs to be moved there.  However, the arm64 AES
assembly code groups many AES modes together; individual modes aren't
easily separable.  (This isn't unique to arm64; other architectures
organize their AES modes similarly.)

Since the other AES modes will be migrated into the library eventually
too, just move the full assembly files for the AES modes into the
library.  (This is similar to what I already did for PowerPC and SPARC.)

Specifically: move the assembly files aes-ce.S, aes-modes.S, and
aes-neon.S and their build rules; declare the assembly functions in
<crypto/aes.h>; and export the assembly functions from libaes.

Note that the exports and public declarations of the assembly functions
are temporary.  They exist only to keep arch/arm64/crypto/ working until
the AES modes are fully moved into the library.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/arm64/crypto/Makefile                    |  4 +-
 arch/arm64/crypto/aes-ce-ccm-glue.c           |  4 --
 arch/arm64/crypto/aes-glue.c                  | 47 +------------
 arch/arm64/crypto/aes-neonbs-glue.c           | 15 +---
 include/crypto/aes.h                          | 69 +++++++++++++++++++
 lib/crypto/Makefile                           |  4 +-
 .../crypto => lib/crypto/arm64}/aes-ce.S      |  0
 .../crypto => lib/crypto/arm64}/aes-modes.S   |  0
 .../crypto => lib/crypto/arm64}/aes-neon.S    |  0
 lib/crypto/arm64/aes.h                        | 30 ++++++++
 10 files changed, 106 insertions(+), 67 deletions(-)
 rename {arch/arm64/crypto => lib/crypto/arm64}/aes-ce.S (100%)
 rename {arch/arm64/crypto => lib/crypto/arm64}/aes-modes.S (100%)
 rename {arch/arm64/crypto => lib/crypto/arm64}/aes-neon.S (100%)

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 3574e917bc37..8a8e3e551ed3 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -31,12 +31,12 @@ ghash-ce-y := ghash-ce-glue.o ghash-ce-core.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_CE_CCM) += aes-ce-ccm.o
 aes-ce-ccm-y := aes-ce-ccm-glue.o aes-ce-ccm-core.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_CE_BLK) += aes-ce-blk.o
-aes-ce-blk-y := aes-glue-ce.o aes-ce.o
+aes-ce-blk-y := aes-glue-ce.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_NEON_BLK) += aes-neon-blk.o
-aes-neon-blk-y := aes-glue-neon.o aes-neon.o
+aes-neon-blk-y := aes-glue-neon.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
 aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index db371ac051fc..45aed0073283 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -29,14 +29,10 @@ static int num_rounds(struct crypto_aes_ctx *ctx)
 	 * => n byte key	=> 6 + (n/4) rounds
 	 */
 	return 6 + ctx->key_length / 4;
 }
 
-asmlinkage u32 ce_aes_mac_update(u8 const in[], u32 const rk[], int rounds,
-				 int blocks, u8 dg[], int enc_before,
-				 int enc_after);
-
 asmlinkage void ce_aes_ccm_encrypt(u8 out[], u8 const in[], u32 cbytes,
 				   u32 const rk[], u32 rounds, u8 mac[],
 				   u8 ctr[], u8 const final_iv[]);
 
 asmlinkage void ce_aes_ccm_decrypt(u8 out[], u8 const in[], u32 cbytes,
diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 92f43e1cd097..fd7c3a560a71 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -69,52 +69,13 @@ MODULE_ALIAS_CRYPTO("essiv(cbc(aes),sha256)");
 MODULE_ALIAS_CRYPTO("cmac(aes)");
 MODULE_ALIAS_CRYPTO("xcbc(aes)");
 MODULE_ALIAS_CRYPTO("cbcmac(aes)");
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_IMPORT_NS("CRYPTO_INTERNAL");
 MODULE_LICENSE("GPL v2");
 
-/* defined in aes-modes.S */
-asmlinkage void aes_ecb_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				int rounds, int blocks);
-asmlinkage void aes_ecb_decrypt(u8 out[], u8 const in[], u32 const rk[],
-				int rounds, int blocks);
-
-asmlinkage void aes_cbc_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				int rounds, int blocks, u8 iv[]);
-asmlinkage void aes_cbc_decrypt(u8 out[], u8 const in[], u32 const rk[],
-				int rounds, int blocks, u8 iv[]);
-
-asmlinkage void aes_cbc_cts_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				int rounds, int bytes, u8 const iv[]);
-asmlinkage void aes_cbc_cts_decrypt(u8 out[], u8 const in[], u32 const rk[],
-				int rounds, int bytes, u8 const iv[]);
-
-asmlinkage void aes_ctr_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				int rounds, int bytes, u8 ctr[]);
-
-asmlinkage void aes_xctr_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				 int rounds, int bytes, u8 ctr[], int byte_ctr);
-
-asmlinkage void aes_xts_encrypt(u8 out[], u8 const in[], u32 const rk1[],
-				int rounds, int bytes, u32 const rk2[], u8 iv[],
-				int first);
-asmlinkage void aes_xts_decrypt(u8 out[], u8 const in[], u32 const rk1[],
-				int rounds, int bytes, u32 const rk2[], u8 iv[],
-				int first);
-
-asmlinkage void aes_essiv_cbc_encrypt(u8 out[], u8 const in[], u32 const rk1[],
-				      int rounds, int blocks, u8 iv[],
-				      u32 const rk2[]);
-asmlinkage void aes_essiv_cbc_decrypt(u8 out[], u8 const in[], u32 const rk1[],
-				      int rounds, int blocks, u8 iv[],
-				      u32 const rk2[]);
-
-asmlinkage int aes_mac_update(u8 const in[], u32 const rk[], int rounds,
-			      int blocks, u8 dg[], int enc_before,
-			      int enc_after);
-
 struct crypto_aes_xts_ctx {
 	struct crypto_aes_ctx key1;
 	struct crypto_aes_ctx __aligned(8) key2;
 };
 
@@ -969,15 +930,9 @@ static int __init aes_init(void)
 	return err;
 }
 
 #ifdef USE_V8_CRYPTO_EXTENSIONS
 module_cpu_feature_match(AES, aes_init);
-EXPORT_SYMBOL_NS(ce_aes_mac_update, "CRYPTO_INTERNAL");
 #else
 module_init(aes_init);
-EXPORT_SYMBOL(neon_aes_ecb_encrypt);
-EXPORT_SYMBOL(neon_aes_cbc_encrypt);
-EXPORT_SYMBOL(neon_aes_ctr_encrypt);
-EXPORT_SYMBOL(neon_aes_xts_encrypt);
-EXPORT_SYMBOL(neon_aes_xts_decrypt);
 #endif
 module_exit(aes_exit);
diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index cb87c8fc66b3..7630a7bf5da9 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -15,10 +15,11 @@
 #include <crypto/xts.h>
 #include <linux/module.h>
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_DESCRIPTION("Bit sliced AES using NEON instructions");
+MODULE_IMPORT_NS("CRYPTO_INTERNAL");
 MODULE_LICENSE("GPL v2");
 
 MODULE_ALIAS_CRYPTO("ecb(aes)");
 MODULE_ALIAS_CRYPTO("cbc(aes)");
 MODULE_ALIAS_CRYPTO("ctr(aes)");
@@ -40,24 +41,10 @@ asmlinkage void aesbs_ctr_encrypt(u8 out[], u8 const in[], u8 const rk[],
 asmlinkage void aesbs_xts_encrypt(u8 out[], u8 const in[], u8 const rk[],
 				  int rounds, int blocks, u8 iv[]);
 asmlinkage void aesbs_xts_decrypt(u8 out[], u8 const in[], u8 const rk[],
 				  int rounds, int blocks, u8 iv[]);
 
-/* borrowed from aes-neon-blk.ko */
-asmlinkage void neon_aes_ecb_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				     int rounds, int blocks);
-asmlinkage void neon_aes_cbc_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				     int rounds, int blocks, u8 iv[]);
-asmlinkage void neon_aes_ctr_encrypt(u8 out[], u8 const in[], u32 const rk[],
-				     int rounds, int bytes, u8 ctr[]);
-asmlinkage void neon_aes_xts_encrypt(u8 out[], u8 const in[],
-				     u32 const rk1[], int rounds, int bytes,
-				     u32 const rk2[], u8 iv[], int first);
-asmlinkage void neon_aes_xts_decrypt(u8 out[], u8 const in[],
-				     u32 const rk1[], int rounds, int bytes,
-				     u32 const rk2[], u8 iv[], int first);
-
 struct aesbs_ctx {
 	u8	rk[13 * (8 * AES_BLOCK_SIZE) + 32];
 	int	rounds;
 } __aligned(AES_BLOCK_SIZE);
 
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index cbf1cc96db52..91bf4667d3e9 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -165,10 +165,79 @@ int aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
  * that code is migrated into lib/crypto/.
  */
 #ifdef CONFIG_ARM64
 int ce_aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
 		     unsigned int key_len);
+asmlinkage void neon_aes_ecb_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				     int rounds, int blocks);
+asmlinkage void neon_aes_ecb_decrypt(u8 out[], u8 const in[], u32 const rk[],
+				     int rounds, int blocks);
+asmlinkage void neon_aes_cbc_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				     int rounds, int blocks, u8 iv[]);
+asmlinkage void neon_aes_cbc_decrypt(u8 out[], u8 const in[], u32 const rk[],
+				     int rounds, int blocks, u8 iv[]);
+asmlinkage void neon_aes_cbc_cts_encrypt(u8 out[], u8 const in[],
+					 u32 const rk[], int rounds, int bytes,
+					 u8 const iv[]);
+asmlinkage void neon_aes_cbc_cts_decrypt(u8 out[], u8 const in[],
+					 u32 const rk[], int rounds, int bytes,
+					 u8 const iv[]);
+asmlinkage void neon_aes_ctr_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				     int rounds, int bytes, u8 ctr[]);
+asmlinkage void neon_aes_xctr_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				      int rounds, int bytes, u8 ctr[],
+				      int byte_ctr);
+asmlinkage void neon_aes_xts_encrypt(u8 out[], u8 const in[], u32 const rk1[],
+				     int rounds, int bytes, u32 const rk2[],
+				     u8 iv[], int first);
+asmlinkage void neon_aes_xts_decrypt(u8 out[], u8 const in[], u32 const rk1[],
+				     int rounds, int bytes, u32 const rk2[],
+				     u8 iv[], int first);
+asmlinkage void neon_aes_essiv_cbc_encrypt(u8 out[], u8 const in[],
+					   u32 const rk1[], int rounds,
+					   int blocks, u8 iv[],
+					   u32 const rk2[]);
+asmlinkage void neon_aes_essiv_cbc_decrypt(u8 out[], u8 const in[],
+					   u32 const rk1[], int rounds,
+					   int blocks, u8 iv[],
+					   u32 const rk2[]);
+asmlinkage int neon_aes_mac_update(u8 const in[], u32 const rk[], int rounds,
+				   int blocks, u8 dg[], int enc_before,
+				   int enc_after);
+
+asmlinkage void ce_aes_ecb_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				   int rounds, int blocks);
+asmlinkage void ce_aes_ecb_decrypt(u8 out[], u8 const in[], u32 const rk[],
+				   int rounds, int blocks);
+asmlinkage void ce_aes_cbc_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				   int rounds, int blocks, u8 iv[]);
+asmlinkage void ce_aes_cbc_decrypt(u8 out[], u8 const in[], u32 const rk[],
+				   int rounds, int blocks, u8 iv[]);
+asmlinkage void ce_aes_cbc_cts_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				       int rounds, int bytes, u8 const iv[]);
+asmlinkage void ce_aes_cbc_cts_decrypt(u8 out[], u8 const in[], u32 const rk[],
+				       int rounds, int bytes, u8 const iv[]);
+asmlinkage void ce_aes_ctr_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				   int rounds, int bytes, u8 ctr[]);
+asmlinkage void ce_aes_xctr_encrypt(u8 out[], u8 const in[], u32 const rk[],
+				    int rounds, int bytes, u8 ctr[],
+				    int byte_ctr);
+asmlinkage void ce_aes_xts_encrypt(u8 out[], u8 const in[], u32 const rk1[],
+				   int rounds, int bytes, u32 const rk2[],
+				   u8 iv[], int first);
+asmlinkage void ce_aes_xts_decrypt(u8 out[], u8 const in[], u32 const rk1[],
+				   int rounds, int bytes, u32 const rk2[],
+				   u8 iv[], int first);
+asmlinkage void ce_aes_essiv_cbc_encrypt(u8 out[], u8 const in[],
+					 u32 const rk1[], int rounds,
+					 int blocks, u8 iv[], u32 const rk2[]);
+asmlinkage void ce_aes_essiv_cbc_decrypt(u8 out[], u8 const in[],
+					 u32 const rk1[], int rounds,
+					 int blocks, u8 iv[], u32 const rk2[]);
+asmlinkage int ce_aes_mac_update(u8 const in[], u32 const rk[], int rounds,
+				 int blocks, u8 dg[], int enc_before,
+				 int enc_after);
 #elif defined(CONFIG_PPC)
 void ppc_expand_key_128(u32 *key_enc, const u8 *key);
 void ppc_expand_key_192(u32 *key_enc, const u8 *key);
 void ppc_expand_key_256(u32 *key_enc, const u8 *key);
 void ppc_generate_decrypt_key(u32 *key_dec, u32 *key_enc, unsigned int key_len);
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 725eef05b758..c05d4b4e8e82 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -24,11 +24,13 @@ CFLAGS_aes.o += -I$(src)/$(SRCARCH)
 
 libaes-$(CONFIG_ARM) += arm/aes-cipher-core.o
 
 ifeq ($(CONFIG_ARM64),y)
 libaes-y += arm64/aes-cipher-core.o
-libaes-$(CONFIG_KERNEL_MODE_NEON) += arm64/aes-ce-core.o
+libaes-$(CONFIG_KERNEL_MODE_NEON) += arm64/aes-ce-core.o \
+				     arm64/aes-ce.o \
+				     arm64/aes-neon.o
 endif
 
 ifeq ($(CONFIG_PPC),y)
 ifeq ($(CONFIG_SPE),y)
 libaes-y += powerpc/aes-spe-core.o \
diff --git a/arch/arm64/crypto/aes-ce.S b/lib/crypto/arm64/aes-ce.S
similarity index 100%
rename from arch/arm64/crypto/aes-ce.S
rename to lib/crypto/arm64/aes-ce.S
diff --git a/arch/arm64/crypto/aes-modes.S b/lib/crypto/arm64/aes-modes.S
similarity index 100%
rename from arch/arm64/crypto/aes-modes.S
rename to lib/crypto/arm64/aes-modes.S
diff --git a/arch/arm64/crypto/aes-neon.S b/lib/crypto/arm64/aes-neon.S
similarity index 100%
rename from arch/arm64/crypto/aes-neon.S
rename to lib/crypto/arm64/aes-neon.S
diff --git a/lib/crypto/arm64/aes.h b/lib/crypto/arm64/aes.h
index 63eea6271ef9..69f465c668f0 100644
--- a/lib/crypto/arm64/aes.h
+++ b/lib/crypto/arm64/aes.h
@@ -124,10 +124,40 @@ int ce_aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
 			    6 + key_len / 4);
 	return 0;
 }
 EXPORT_SYMBOL(ce_aes_expandkey);
 
+#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON)
+EXPORT_SYMBOL_NS_GPL(neon_aes_ecb_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_ecb_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_cbc_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_cbc_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_cbc_cts_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_cbc_cts_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_ctr_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_xctr_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_xts_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_xts_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_essiv_cbc_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_essiv_cbc_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(neon_aes_mac_update, "CRYPTO_INTERNAL");
+
+EXPORT_SYMBOL_NS_GPL(ce_aes_ecb_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_ecb_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_cbc_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_cbc_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_cbc_cts_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_cbc_cts_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_ctr_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_xctr_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_xts_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_xts_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_essiv_cbc_encrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_essiv_cbc_decrypt, "CRYPTO_INTERNAL");
+EXPORT_SYMBOL_NS_GPL(ce_aes_mac_update, "CRYPTO_INTERNAL");
+#endif
+
 static void aes_encrypt_arch(const struct aes_enckey *key,
 			     u8 out[AES_BLOCK_SIZE],
 			     const u8 in[AES_BLOCK_SIZE])
 {
 	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
-- 
2.53.0


