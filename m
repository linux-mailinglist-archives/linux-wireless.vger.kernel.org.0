Return-Path: <linux-wireless+bounces-31986-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNltG2kylmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31986-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:43:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54515A580
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 704D730CBF05
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD6335076;
	Wed, 18 Feb 2026 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7cvUUs2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36D3375D5;
	Wed, 18 Feb 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450621; cv=none; b=B0OziwgOG8oIf1jF2T5GxCA8AVXCKkZcVRR3MxDwahbxsu4vpenDFAakexYvfUCf299cdNSE+u0sQvrbmStxTqRuxBFOIkYRjDSkqPDZG8WA5h3UzJhhPcd2cFFl7iiXVToiN5sxxaPvFYRCM6VpFkRwjJLHmYBppz2KtCylBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450621; c=relaxed/simple;
	bh=MukATPOpIzjauahsnyw5/LgkOoeHj4ze2Fz2UAEw0rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCARcHjaAa9I7psvg9/omScekM0LR5tdRQGf+BgCxPiPrgCLtJpJiMMOUEw10fY0+mxPBewE/BdQVPR1s2Jfy7tvoH0+5ZDX0HqrrdqfrOa+oD8EgOCbA/YZHim90f/ZSjp2tXILWiF5JxQPFJArATF1mnH9i4uguP2GDy1T9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7cvUUs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2924C2BCB4;
	Wed, 18 Feb 2026 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450620;
	bh=MukATPOpIzjauahsnyw5/LgkOoeHj4ze2Fz2UAEw0rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7cvUUs2MbPHShNzMReODOXXx0055P+B5i6wUSiG6e9WEN6m6eioCUpXWfIz4SPHd
	 o2Jp/TgF7O6k4rs3A3NJzK32Pj7x0O9bWs75sgyw05p+8QPHl6J3iXMMcY2J/BSv03
	 pBovcGwo2XyB8w7WI+rZziQRib7Q7PXdefsaQDZORQah7mhr+W2KC+iVMfIJnwzjTn
	 Wv2DoQtvp6FRV+kUAeWFOybO9Ojm9HEgHVDla4zh2fQOJnhZTDqYNKySvsx6PNr4D4
	 lDUbu1wGNmXaGuU4e3y2JDb25S/GbeOLp7/b1VANEkR53N572/mF3aKaK96nxZXrDo
	 gYvDPt8fT+elQ==
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
Subject: [PATCH 15/15] wifi: mac80211: Use AES-CMAC library in aes_s2v()
Date: Wed, 18 Feb 2026 13:35:01 -0800
Message-ID: <20260218213501.136844-16-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31986-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: CB54515A580
X-Rspamd-Action: no action

Now that AES-CMAC has a library API, convert aes_s2v() to use it instead
of a "cmac(aes)" crypto_shash.  The result is faster and simpler code.

It's also more reliable, since with the library the only step that can
fail is preparing the key.  In contrast, crypto_shash_digest(),
crypto_shash_init(), crypto_shash_update(), and crypto_shash_final()
could all fail and return an errno value.  aes_s2v() ignored these
errors, which was a bug.  So that bug is fixed as well.

As part of this, change the prototype of aes_s2v() to take the raw key
directly instead of a prepared key.  Its only two callers prepare a key
for each call, so it might as well be done directly in aes_s2v().

Since this removes the last dependency on the "cmac(aes)" crypto_shash
from mac80211, also remove the 'select CRYPTO_CMAC'.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/mac80211/Kconfig     |  1 -
 net/mac80211/fils_aead.c | 48 ++++++++++++++--------------------------
 2 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 0afbe4f4f976..d6bc295e23a1 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -6,11 +6,10 @@ config MAC80211
 	select CRYPTO_LIB_AES_CBC_MACS
 	select CRYPTO_LIB_ARC4
 	select CRYPTO_AES
 	select CRYPTO_CCM
 	select CRYPTO_GCM
-	select CRYPTO_CMAC
 	select CRC32
 	help
 	  This option enables the hardware independent IEEE 802.11
 	  networking stack.
 
diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
index 912c46f74d24..d2f4a17eab99 100644
--- a/net/mac80211/fils_aead.c
+++ b/net/mac80211/fils_aead.c
@@ -2,17 +2,15 @@
 /*
  * FILS AEAD for (Re)Association Request/Response frames
  * Copyright 2016, Qualcomm Atheros, Inc.
  */
 
-#include <crypto/aes.h>
-#include <crypto/hash.h>
+#include <crypto/aes-cbc-macs.h>
 #include <crypto/skcipher.h>
 #include <crypto/utils.h>
 
 #include "ieee80211_i.h"
-#include "aes_cmac.h"
 #include "fils_aead.h"
 
 static void gf_mulx(u8 *pad)
 {
 	u64 a = get_unaligned_be64(pad);
@@ -20,58 +18,63 @@ static void gf_mulx(u8 *pad)
 
 	put_unaligned_be64((a << 1) | (b >> 63), pad);
 	put_unaligned_be64((b << 1) ^ ((a >> 63) ? 0x87 : 0), pad + 8);
 }
 
-static int aes_s2v(struct crypto_shash *tfm,
+static int aes_s2v(const u8 *in_key, size_t key_len,
 		   size_t num_elem, const u8 *addr[], size_t len[], u8 *v)
 {
 	u8 d[AES_BLOCK_SIZE], tmp[AES_BLOCK_SIZE] = {};
-	SHASH_DESC_ON_STACK(desc, tfm);
+	struct aes_cmac_key key;
+	struct aes_cmac_ctx ctx;
 	size_t i;
+	int res;
 
-	desc->tfm = tfm;
+	res = aes_cmac_preparekey(&key, in_key, key_len);
+	if (res)
+		return res;
 
 	/* D = AES-CMAC(K, <zero>) */
-	crypto_shash_digest(desc, tmp, AES_BLOCK_SIZE, d);
+	aes_cmac(&key, tmp, AES_BLOCK_SIZE, d);
 
 	for (i = 0; i < num_elem - 1; i++) {
 		/* D = dbl(D) xor AES_CMAC(K, Si) */
 		gf_mulx(d); /* dbl */
-		crypto_shash_digest(desc, addr[i], len[i], tmp);
+		aes_cmac(&key, addr[i], len[i], tmp);
 		crypto_xor(d, tmp, AES_BLOCK_SIZE);
 	}
 
-	crypto_shash_init(desc);
+	aes_cmac_init(&ctx, &key);
 
 	if (len[i] >= AES_BLOCK_SIZE) {
 		/* len(Sn) >= 128 */
 		/* T = Sn xorend D */
-		crypto_shash_update(desc, addr[i], len[i] - AES_BLOCK_SIZE);
+		aes_cmac_update(&ctx, addr[i], len[i] - AES_BLOCK_SIZE);
 		crypto_xor(d, addr[i] + len[i] - AES_BLOCK_SIZE,
 			   AES_BLOCK_SIZE);
 	} else {
 		/* len(Sn) < 128 */
 		/* T = dbl(D) xor pad(Sn) */
 		gf_mulx(d); /* dbl */
 		crypto_xor(d, addr[i], len[i]);
 		d[len[i]] ^= 0x80;
 	}
 	/* V = AES-CMAC(K, T) */
-	crypto_shash_finup(desc, d, AES_BLOCK_SIZE, v);
+	aes_cmac_update(&ctx, d, AES_BLOCK_SIZE);
+	aes_cmac_final(&ctx, v);
 
+	memzero_explicit(&key, sizeof(key));
 	return 0;
 }
 
 /* Note: addr[] and len[] needs to have one extra slot at the end. */
 static int aes_siv_encrypt(const u8 *key, size_t key_len,
 			   const u8 *plain, size_t plain_len,
 			   size_t num_elem, const u8 *addr[],
 			   size_t len[], u8 *out)
 {
 	u8 v[AES_BLOCK_SIZE];
-	struct crypto_shash *tfm;
 	struct crypto_skcipher *tfm2;
 	struct skcipher_request *req;
 	int res;
 	struct scatterlist src[1], dst[1];
 	u8 *tmp;
@@ -81,19 +84,11 @@ static int aes_siv_encrypt(const u8 *key, size_t key_len,
 	addr[num_elem] = plain;
 	len[num_elem] = plain_len;
 	num_elem++;
 
 	/* S2V */
-
-	tfm = crypto_alloc_shash("cmac(aes)", 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-	/* K1 for S2V */
-	res = crypto_shash_setkey(tfm, key, key_len);
-	if (!res)
-		res = aes_s2v(tfm, num_elem, addr, len, v);
-	crypto_free_shash(tfm);
+	res = aes_s2v(key /* K1 */, key_len, num_elem, addr, len, v);
 	if (res)
 		return res;
 
 	/* Use a temporary buffer of the plaintext to handle need for
 	 * overwriting this during AES-CTR.
@@ -144,11 +139,10 @@ static int aes_siv_encrypt(const u8 *key, size_t key_len,
 static int aes_siv_decrypt(const u8 *key, size_t key_len,
 			   const u8 *iv_crypt, size_t iv_c_len,
 			   size_t num_elem, const u8 *addr[], size_t len[],
 			   u8 *out)
 {
-	struct crypto_shash *tfm;
 	struct crypto_skcipher *tfm2;
 	struct skcipher_request *req;
 	struct scatterlist src[1], dst[1];
 	size_t crypt_len;
 	int res;
@@ -196,19 +190,11 @@ static int aes_siv_decrypt(const u8 *key, size_t key_len,
 	crypto_free_skcipher(tfm2);
 	if (res)
 		return res;
 
 	/* S2V */
-
-	tfm = crypto_alloc_shash("cmac(aes)", 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-	/* K1 for S2V */
-	res = crypto_shash_setkey(tfm, key, key_len);
-	if (!res)
-		res = aes_s2v(tfm, num_elem, addr, len, check);
-	crypto_free_shash(tfm);
+	res = aes_s2v(key /* K1 */, key_len, num_elem, addr, len, check);
 	if (res)
 		return res;
 	if (memcmp(check, frame_iv, AES_BLOCK_SIZE) != 0)
 		return -EINVAL;
 	return 0;
-- 
2.53.0


