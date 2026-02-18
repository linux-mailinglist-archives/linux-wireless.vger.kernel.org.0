Return-Path: <linux-wireless+bounces-31972-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DgQKQwxlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31972-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:37:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD915A36E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A4373037457
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DCA2F39AB;
	Wed, 18 Feb 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNY7X+UH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C062F1FF1;
	Wed, 18 Feb 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450610; cv=none; b=CZtkrZAR7qmYOeDxGmxoyiTtPPC8bqHWXt66Ke1nKtKqiAeopWk/y+Yfxl2eVkHd/2G2wbcu1AvsLlSQdHeHiPKc5K9u5LEXg1OtDN1F8Vz5QxCAssQ39WX6MOiCrKBSnNs8ixga82tYy5z16Yn+6kJrqaBuPKt/qax31EnGSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450610; c=relaxed/simple;
	bh=B6d275uZRRFPEx+cNjtBQltncVwySv2uEdCFV1CD0Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJi/9gAYyyDFTZhtWXbpYZ8aU97ihhWBsvtvWu8evRfffFe4llb3Mv1pWfLeJbbQm+WrMGPkcCaeuwFKflORI5vBlniwJPkDINzMk4TCHOkXP9vmDAS4EvBVCLf/eMxk/6knnN92k/HUQR3aIr4A478Y5beMD/YJd6GgpubRKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNY7X+UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07080C116D0;
	Wed, 18 Feb 2026 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450610;
	bh=B6d275uZRRFPEx+cNjtBQltncVwySv2uEdCFV1CD0Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNY7X+UHZkxBL5KtYlX57pYHzFDROFqV80iskbBKwTzWrLT1AQjOgcQ4kxC1lVn4G
	 1RvOmbJfTuasBuvEAhhbS1ZwONy+UmkxRUyp8hM/8DMwyjFbPUhhjKQJRfF1JWIdob
	 Wx1lDKy1LlFPPog6CqVyk0zjnmxrBgRr/FRAPYWG4R2gnooPqZPZRqFt5ZCBIsg5EU
	 wiKS4C+QDx9fxk7FvDTLNojs9oyaHBE4sJB0dd5RJKcjEgIVsVrl5uVi5m5jnRfRGJ
	 Ed4GJ9NLvBqh5HnRdGIGgpZyc066hq2i5R58iYsA9uc4j+Mejh55RL4loy+sCmH3YS
	 9QdRnuw8iJr9w==
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
Subject: [PATCH 01/15] lib/crypto: aes: Add support for CBC-based MACs
Date: Wed, 18 Feb 2026 13:34:47 -0800
Message-ID: <20260218213501.136844-2-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31972-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 44AD915A36E
X-Rspamd-Action: no action

Add support for CBC-based MACs to the AES library, specifically
AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC.

Of these three algorithms, AES-CMAC is the most modern and the most
commonly used.  Use cases for the AES-CMAC library include the kernel's
SMB client and server, and the bluetooth and mac80211 drivers.

Support for AES-XCBC-MAC and AES-CBC-MAC is included so that there will
be no performance regression in the "xcbc(aes)" and "ccm(aes)" support
in the traditional crypto API once the arm64-optimized code is migrated
into the library.  AES-XCBC-MAC is given its own key preparation
function but is otherwise identical to AES-CMAC and just reuses the
AES-CMAC structs and functions.

The implementation automatically uses the optimized AES key expansion
and single block en/decryption functions.  It also allows architectures
to provide an optimized implementation of aes_cbcmac_blocks(), which
allows the existing arm64-optimized code for these modes to be used.

Just put the code for these modes directly in the libaes module rather
than in a separate module.  This is simpler, it makes it easier to share
code between AES modes, and it increases the amount of inlining that is
possible.  (Indeed, for these reasons, most of the
architecture-optimized AES code already provides multiple modes per
module.  x86 for example has only a single aesni-intel module.  So to a
large extent, this design choice just reflects the status quo.)

However, since there are a lot of AES modes, there's still some value in
omitting modes that are not needed at all in a given kernel.  Therefore,
make these modes an optional feature of libaes, controlled by
CONFIG_CRYPTO_LIB_AES_CBC_MACS.  This seems like a good middle ground.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/aes-cbc-macs.h | 154 ++++++++++++++++++++++++++
 lib/crypto/Kconfig            |  10 ++
 lib/crypto/aes.c              | 198 ++++++++++++++++++++++++++++++++++
 3 files changed, 362 insertions(+)
 create mode 100644 include/crypto/aes-cbc-macs.h

diff --git a/include/crypto/aes-cbc-macs.h b/include/crypto/aes-cbc-macs.h
new file mode 100644
index 000000000000..e61df108b926
--- /dev/null
+++ b/include/crypto/aes-cbc-macs.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Support for AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC
+ *
+ * Copyright 2026 Google LLC
+ */
+#ifndef _CRYPTO_AES_CBC_MACS_H
+#define _CRYPTO_AES_CBC_MACS_H
+
+#include <crypto/aes.h>
+
+/**
+ * struct aes_cmac_key - Prepared key for AES-CMAC or AES-XCBC-MAC
+ * @aes: The AES key for cipher block chaining
+ * @k_final: Finalization subkeys for the final block.
+ *	     k_final[0] (CMAC K1, XCBC-MAC K2) is used if it's a full block.
+ *	     k_final[1] (CMAC K2, XCBC-MAC K3) is used if it's a partial block.
+ */
+struct aes_cmac_key {
+	struct aes_enckey aes;
+	union {
+		u8 b[AES_BLOCK_SIZE];
+		__be64 w[2];
+	} k_final[2];
+};
+
+/**
+ * struct aes_cmac_ctx - Context for computing an AES-CMAC or AES-XCBC-MAC value
+ * @key: Pointer to the key struct.  A pointer is used rather than a copy of the
+ *	 struct, since the key struct size may be large.  It is assumed that the
+ *	 key lives at least as long as the context.
+ * @partial_len: Number of bytes that have been XOR'ed into @h since the last
+ *		 AES encryption.  This is 0 if no data has been processed yet,
+ *		 or between 1 and AES_BLOCK_SIZE inclusive otherwise.
+ * @h: The current chaining value
+ */
+struct aes_cmac_ctx {
+	const struct aes_cmac_key *key;
+	size_t partial_len;
+	u8 h[AES_BLOCK_SIZE];
+};
+
+/**
+ * aes_cmac_preparekey() - Prepare a key for AES-CMAC
+ * @key: (output) The key struct to initialize
+ * @in_key: The raw AES key
+ * @key_len: Length of the raw key in bytes.  The supported values are
+ *	     AES_KEYSIZE_128, AES_KEYSIZE_192, and AES_KEYSIZE_256.
+ *
+ * Context: Any context.
+ * Return: 0 on success or -EINVAL if the given key length is invalid.  No other
+ *	   errors are possible, so callers that always pass a valid key length
+ *	   don't need to check for errors.
+ */
+int aes_cmac_preparekey(struct aes_cmac_key *key, const u8 *in_key,
+			size_t key_len);
+
+/**
+ * aes_xcbcmac_preparekey() - Prepare a key for AES-XCBC-MAC
+ * @key: (output) The key struct to initialize
+ * @in_key: The raw key.  As per the AES-XCBC-MAC specification (RFC 3566), this
+ *	    is 128 bits, matching the internal use of AES-128.
+ *
+ * AES-XCBC-MAC and AES-CMAC are the same except for the key preparation.  After
+ * that step, AES-XCBC-MAC is supported via the aes_cmac_* functions.
+ *
+ * New users should use AES-CMAC instead of AES-XCBC-MAC.
+ *
+ * Context: Any context.
+ */
+void aes_xcbcmac_preparekey(struct aes_cmac_key *key,
+			    const u8 in_key[at_least AES_KEYSIZE_128]);
+
+/**
+ * aes_cmac_init() - Start computing an AES-CMAC or AES-XCBC-MAC value
+ * @ctx: (output) The context to initialize
+ * @key: The key to use.  Note that a pointer to the key is saved in the
+ *	 context, so the key must live at least as long as the context.
+ *
+ * This supports both AES-CMAC and AES-XCBC-MAC.  Which one is done depends on
+ * whether aes_cmac_preparekey() or aes_xcbcmac_preparekey() was called.
+ */
+static inline void aes_cmac_init(struct aes_cmac_ctx *ctx,
+				 const struct aes_cmac_key *key)
+{
+	*ctx = (struct aes_cmac_ctx){ .key = key };
+}
+
+/**
+ * aes_cmac_update() - Update an AES-CMAC or AES-XCBC-MAC context with more data
+ * @ctx: The context to update; must have been initialized
+ * @data: The message data
+ * @data_len: The data length in bytes.  Doesn't need to be block-aligned.
+ *
+ * This can be called any number of times.
+ *
+ * Context: Any context.
+ */
+void aes_cmac_update(struct aes_cmac_ctx *ctx, const u8 *data, size_t data_len);
+
+/**
+ * aes_cmac_final() - Finish computing an AES-CMAC or AES-XCBC-MAC value
+ * @ctx: The context to finalize; must have been initialized
+ * @out: (output) The resulting MAC
+ *
+ * After finishing, this zeroizes @ctx.  So the caller does not need to do it.
+ *
+ * Context: Any context.
+ */
+void aes_cmac_final(struct aes_cmac_ctx *ctx, u8 out[at_least AES_BLOCK_SIZE]);
+
+/**
+ * aes_cmac() - Compute AES-CMAC or AES-XCBC-MAC in one shot
+ * @key: The key to use
+ * @data: The message data
+ * @data_len: The data length in bytes
+ * @out: (output) The resulting AES-CMAC or AES-XCBC-MAC value
+ *
+ * This supports both AES-CMAC and AES-XCBC-MAC.  Which one is done depends on
+ * whether aes_cmac_preparekey() or aes_xcbcmac_preparekey() was called.
+ *
+ * Context: Any context.
+ */
+static inline void aes_cmac(const struct aes_cmac_key *key, const u8 *data,
+			    size_t data_len, u8 out[at_least AES_BLOCK_SIZE])
+{
+	struct aes_cmac_ctx ctx;
+
+	aes_cmac_init(&ctx, key);
+	aes_cmac_update(&ctx, data, data_len);
+	aes_cmac_final(&ctx, out);
+}
+
+/*
+ * AES-CBC-MAC support.  This is provided only for use by the implementation of
+ * AES-CCM.  It should have no other users.  Warning: unlike AES-CMAC and
+ * AES-XCBC-MAC, AES-CBC-MAC isn't a secure MAC for variable-length messages.
+ */
+struct aes_cbcmac_ctx {
+	const struct aes_enckey *key;
+	size_t partial_len;
+	u8 h[AES_BLOCK_SIZE];
+};
+static inline void aes_cbcmac_init(struct aes_cbcmac_ctx *ctx,
+				   const struct aes_enckey *key)
+{
+	*ctx = (struct aes_cbcmac_ctx){ .key = key };
+}
+void aes_cbcmac_update(struct aes_cbcmac_ctx *ctx, const u8 *data,
+		       size_t data_len);
+void aes_cbcmac_final(struct aes_cbcmac_ctx *ctx,
+		      u8 out[at_least AES_BLOCK_SIZE]);
+
+#endif /* _CRYPTO_AES_CBC_MACS_H */
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 032f9755f999..42ec51645915 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -8,10 +8,12 @@ config CRYPTO_HASH_INFO
 config CRYPTO_LIB_UTILS
 	tristate
 
 config CRYPTO_LIB_AES
 	tristate
+	# Select dependencies of modes that are part of libaes.
+	select CRYPTO_LIB_UTILS if CRYPTO_LIB_AES_CBC_MACS
 
 config CRYPTO_LIB_AES_ARCH
 	bool
 	depends on CRYPTO_LIB_AES && !UML && !KMSAN
 	default y if ARM
@@ -26,10 +28,18 @@ config CRYPTO_LIB_AES_ARCH
 config CRYPTO_LIB_AESCFB
 	tristate
 	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_UTILS
 
+config CRYPTO_LIB_AES_CBC_MACS
+	tristate
+	select CRYPTO_LIB_AES
+	help
+	  The AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC library functions.  Select
+	  this if your module uses any of the functions from
+	  <crypto/aes-cbc-macs.h>.
+
 config CRYPTO_LIB_AESGCM
 	tristate
 	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_GF128MUL
 	select CRYPTO_LIB_UTILS
diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
index b73e19f1bb95..39deae6105c0 100644
--- a/lib/crypto/aes.c
+++ b/lib/crypto/aes.c
@@ -2,11 +2,13 @@
 /*
  * Copyright (C) 2017-2019 Linaro Ltd <ard.biesheuvel@linaro.org>
  * Copyright 2026 Google LLC
  */
 
+#include <crypto/aes-cbc-macs.h>
 #include <crypto/aes.h>
+#include <crypto/utils.h>
 #include <linux/cache.h>
 #include <linux/crypto.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/unaligned.h>
@@ -510,10 +512,206 @@ void aes_decrypt(const struct aes_key *key, u8 out[AES_BLOCK_SIZE],
 {
 	aes_decrypt_arch(key, out, in);
 }
 EXPORT_SYMBOL(aes_decrypt);
 
+#if IS_ENABLED(CONFIG_CRYPTO_LIB_AES_CBC_MACS)
+
+#ifndef aes_cbcmac_blocks_arch
+static bool aes_cbcmac_blocks_arch(u8 h[AES_BLOCK_SIZE],
+				   const struct aes_enckey *key, const u8 *data,
+				   size_t nblocks, bool enc_before,
+				   bool enc_after)
+{
+	return false;
+}
+#endif
+
+/* This assumes nblocks >= 1. */
+static void aes_cbcmac_blocks(u8 h[AES_BLOCK_SIZE],
+			      const struct aes_enckey *key, const u8 *data,
+			      size_t nblocks, bool enc_before, bool enc_after)
+{
+	if (aes_cbcmac_blocks_arch(h, key, data, nblocks, enc_before,
+				   enc_after))
+		return;
+
+	if (enc_before)
+		aes_encrypt(key, h, h);
+	for (; nblocks > 1; nblocks--) {
+		crypto_xor(h, data, AES_BLOCK_SIZE);
+		data += AES_BLOCK_SIZE;
+		aes_encrypt(key, h, h);
+	}
+	crypto_xor(h, data, AES_BLOCK_SIZE);
+	if (enc_after)
+		aes_encrypt(key, h, h);
+}
+
+int aes_cmac_preparekey(struct aes_cmac_key *key, const u8 *in_key,
+			size_t key_len)
+{
+	u64 hi, lo, mask;
+	int err;
+
+	/* Prepare the AES key. */
+	err = aes_prepareenckey(&key->aes, in_key, key_len);
+	if (err)
+		return err;
+
+	/*
+	 * Prepare the subkeys K1 and K2 by encrypting the all-zeroes block,
+	 * then multiplying by 'x' and 'x^2' (respectively) in GF(2^128).
+	 * Reference: NIST SP 800-38B, Section 6.1 "Subkey Generation".
+	 */
+	memset(key->k_final[0].b, 0, AES_BLOCK_SIZE);
+	aes_encrypt(&key->aes, key->k_final[0].b, key->k_final[0].b);
+	hi = be64_to_cpu(key->k_final[0].w[0]);
+	lo = be64_to_cpu(key->k_final[0].w[1]);
+	for (int i = 0; i < 2; i++) {
+		mask = ((s64)hi >> 63) & 0x87;
+		hi = (hi << 1) ^ (lo >> 63);
+		lo = (lo << 1) ^ mask;
+		key->k_final[i].w[0] = cpu_to_be64(hi);
+		key->k_final[i].w[1] = cpu_to_be64(lo);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aes_cmac_preparekey);
+
+void aes_xcbcmac_preparekey(struct aes_cmac_key *key,
+			    const u8 in_key[AES_KEYSIZE_128])
+{
+	static const u8 constants[3][AES_BLOCK_SIZE] = {
+		{ [0 ... AES_BLOCK_SIZE - 1] = 0x1 },
+		{ [0 ... AES_BLOCK_SIZE - 1] = 0x2 },
+		{ [0 ... AES_BLOCK_SIZE - 1] = 0x3 },
+	};
+	u8 new_aes_key[AES_BLOCK_SIZE];
+
+	static_assert(AES_BLOCK_SIZE == AES_KEYSIZE_128);
+	aes_prepareenckey(&key->aes, in_key, AES_BLOCK_SIZE);
+	aes_encrypt(&key->aes, new_aes_key, constants[0]);
+	aes_encrypt(&key->aes, key->k_final[0].b, constants[1]);
+	aes_encrypt(&key->aes, key->k_final[1].b, constants[2]);
+	aes_prepareenckey(&key->aes, new_aes_key, AES_BLOCK_SIZE);
+	memzero_explicit(new_aes_key, AES_BLOCK_SIZE);
+}
+EXPORT_SYMBOL_GPL(aes_xcbcmac_preparekey);
+
+void aes_cmac_update(struct aes_cmac_ctx *ctx, const u8 *data, size_t data_len)
+{
+	bool enc_before = false;
+	size_t nblocks;
+
+	if (ctx->partial_len) {
+		/* XOR data into a pending block. */
+		size_t l = min(data_len, AES_BLOCK_SIZE - ctx->partial_len);
+
+		crypto_xor(&ctx->h[ctx->partial_len], data, l);
+		data += l;
+		data_len -= l;
+		ctx->partial_len += l;
+		if (data_len == 0) {
+			/*
+			 * Either the pending block hasn't been filled yet, or
+			 * no more data was given so it's not yet known whether
+			 * the block is the final block.
+			 */
+			return;
+		}
+		/* Pending block has been filled and isn't the final block. */
+		enc_before = true;
+	}
+
+	nblocks = data_len / AES_BLOCK_SIZE;
+	data_len %= AES_BLOCK_SIZE;
+	if (nblocks == 0) {
+		/* 0 additional full blocks, then optionally a partial block */
+		if (enc_before)
+			aes_encrypt(&ctx->key->aes, ctx->h, ctx->h);
+		crypto_xor(ctx->h, data, data_len);
+		ctx->partial_len = data_len;
+	} else if (data_len != 0) {
+		/* 1 or more additional full blocks, then a partial block */
+		aes_cbcmac_blocks(ctx->h, &ctx->key->aes, data, nblocks,
+				  enc_before, /* enc_after= */ true);
+		data += nblocks * AES_BLOCK_SIZE;
+		crypto_xor(ctx->h, data, data_len);
+		ctx->partial_len = data_len;
+	} else {
+		/*
+		 * 1 or more additional full blocks only.  Encryption of the
+		 * last block is delayed until it's known whether it's the final
+		 * block in the message or not.
+		 */
+		aes_cbcmac_blocks(ctx->h, &ctx->key->aes, data, nblocks,
+				  enc_before, /* enc_after= */ false);
+		ctx->partial_len = AES_BLOCK_SIZE;
+	}
+}
+EXPORT_SYMBOL_GPL(aes_cmac_update);
+
+void aes_cmac_final(struct aes_cmac_ctx *ctx, u8 out[AES_BLOCK_SIZE])
+{
+	if (ctx->partial_len == AES_BLOCK_SIZE) {
+		/* Final block is a full block.  Use k_final[0]. */
+		crypto_xor(ctx->h, ctx->key->k_final[0].b, AES_BLOCK_SIZE);
+	} else {
+		/* Final block is a partial block.  Pad, and use k_final[1]. */
+		ctx->h[ctx->partial_len] ^= 0x80;
+		crypto_xor(ctx->h, ctx->key->k_final[1].b, AES_BLOCK_SIZE);
+	}
+	aes_encrypt(&ctx->key->aes, out, ctx->h);
+	memzero_explicit(ctx, sizeof(*ctx));
+}
+EXPORT_SYMBOL_GPL(aes_cmac_final);
+
+void aes_cbcmac_update(struct aes_cbcmac_ctx *ctx, const u8 *data,
+		       size_t data_len)
+{
+	bool enc_before = false;
+	size_t nblocks;
+
+	if (ctx->partial_len) {
+		size_t l = min(data_len, AES_BLOCK_SIZE - ctx->partial_len);
+
+		crypto_xor(&ctx->h[ctx->partial_len], data, l);
+		data += l;
+		data_len -= l;
+		ctx->partial_len += l;
+		if (ctx->partial_len < AES_BLOCK_SIZE)
+			return;
+		enc_before = true;
+	}
+
+	nblocks = data_len / AES_BLOCK_SIZE;
+	data_len %= AES_BLOCK_SIZE;
+	if (nblocks == 0) {
+		if (enc_before)
+			aes_encrypt(ctx->key, ctx->h, ctx->h);
+	} else {
+		aes_cbcmac_blocks(ctx->h, ctx->key, data, nblocks, enc_before,
+				  /* enc_after= */ true);
+		data += nblocks * AES_BLOCK_SIZE;
+	}
+	crypto_xor(ctx->h, data, data_len);
+	ctx->partial_len = data_len;
+}
+EXPORT_SYMBOL_NS_GPL(aes_cbcmac_update, "CRYPTO_INTERNAL");
+
+void aes_cbcmac_final(struct aes_cbcmac_ctx *ctx, u8 out[AES_BLOCK_SIZE])
+{
+	if (ctx->partial_len)
+		aes_encrypt(ctx->key, out, ctx->h);
+	else
+		memcpy(out, ctx->h, AES_BLOCK_SIZE);
+	memzero_explicit(ctx, sizeof(*ctx));
+}
+EXPORT_SYMBOL_NS_GPL(aes_cbcmac_final, "CRYPTO_INTERNAL");
+#endif /* CONFIG_CRYPTO_LIB_AES_CBC_MACS */
+
 #ifdef aes_mod_init_arch
 static int __init aes_mod_init(void)
 {
 	aes_mod_init_arch();
 	return 0;
-- 
2.53.0


