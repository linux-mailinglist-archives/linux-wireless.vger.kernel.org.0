Return-Path: <linux-wireless+bounces-31985-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJUuCmgxlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31985-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:38:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B515A41E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34B383023D45
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9A2FE575;
	Wed, 18 Feb 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9nC0y+8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A532E68D;
	Wed, 18 Feb 2026 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450620; cv=none; b=lVi20MsJQLwhQ9XMuWbd+/2ie0rm5QZM/ci3HnQOVeeMQ+ksqiiT9TDIpF+m0UmGjilZWR/NUnOBYBILn7Z+Jv+8zt9uyKbyvgUCtn50lO1bTgTenYjtOwFQ5hHe4YorWuMdFWyH7dfp2wNdWAWGv1EN559Y99Qgwx+cE9rs+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450620; c=relaxed/simple;
	bh=DnjzfD8UUtPv4slYL2pB1p87UHI2Kx6DNAW3W2bIPLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkFoiHQb7Zg6FYx44rAQYi/02Vr7fqphBLSxwWSDXzFTF01AcxcfMM4HFnL0L3TfR1NLEVTxizhacIYI34UpawVj2Z8eom6108wv+PKX/IwT3rta6nlJQ68qCzziROSk4h9dL/+cHl/KbaFgqzNPBy6/75BG9tayuep+dhFillM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9nC0y+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6DFC2BCB6;
	Wed, 18 Feb 2026 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450619;
	bh=DnjzfD8UUtPv4slYL2pB1p87UHI2Kx6DNAW3W2bIPLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9nC0y+8/G9755xCvbvHN7DAKjWuIifVrEaCp0dH8JCWSY/8/37cCz4/JnQuj7feq
	 7Y7XXMYb8fsKXNrT6/WTFWzZj2+yxF5NkANQMz+oVnWsBRlGJaurnowsom4L2nZ+Nm
	 Ym4oX9qP9/zITYlEI9YfMoGTwcAAe8GLr92c44TfjXeZspAAtgr7UpZoviaX5VXx+l
	 hTHXNg25Lu3VkKGAkTYbR2QA0UKgwMjm6/st6FQbn6gjOr0pWObiKLPnAoyjbmKBce
	 PfD5qahcQ+51pdMH8lVmK6F/lPHgr1QIKjnd4hk3XKjR8ng+EBDqxyIH6+mRCOeBrG
	 8eVL99dt8et3Q==
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
Subject: [PATCH 14/15] wifi: mac80211: Use AES-CMAC library in ieee80211_aes_cmac()
Date: Wed, 18 Feb 2026 13:35:00 -0800
Message-ID: <20260218213501.136844-15-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31985-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BF0B515A41E
X-Rspamd-Action: no action

Now that AES-CMAC has a library API, convert the mac80211 AES-CMAC
packet authentication code to use it instead of a "cmac(aes)"
crypto_shash.  This has multiple benefits, such as:

- It's faster.  The AES-CMAC code is now called directly, without
  unnecessary overhead such as indirect calls.

- MAC calculation can no longer fail.

- The AES-CMAC key struct is now a fixed size, allowing it to be
  embedded directly into 'struct ieee80211_key' rather than using a
  separate allocation.  Note that although this increases the size of
  the 'u.cmac' field of 'struct ieee80211_key', it doesn't cause it to
  exceed the size of the largest variant of the union 'u'.  Therefore,
  the size of 'struct ieee80211_key' itself is unchanged.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/mac80211/Kconfig    |  1 +
 net/mac80211/aes_cmac.c | 65 ++++++++---------------------------------
 net/mac80211/aes_cmac.h | 12 +++-----
 net/mac80211/key.c      | 11 ++-----
 net/mac80211/key.h      |  3 +-
 net/mac80211/wpa.c      | 13 +++------
 6 files changed, 26 insertions(+), 79 deletions(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index cf0f7780fb10..0afbe4f4f976 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MAC80211
 	tristate "Generic IEEE 802.11 Networking Stack (mac80211)"
 	depends on CFG80211
 	select CRYPTO
+	select CRYPTO_LIB_AES_CBC_MACS
 	select CRYPTO_LIB_ARC4
 	select CRYPTO_AES
 	select CRYPTO_CCM
 	select CRYPTO_GCM
 	select CRYPTO_CMAC
diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 0827965455dc..55b674ad7d7a 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -5,80 +5,39 @@
  * Copyright (C) 2020 Intel Corporation
  */
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/crypto.h>
 #include <linux/export.h>
 #include <linux/err.h>
-#include <crypto/aes.h>
+#include <crypto/aes-cbc-macs.h>
 
 #include <net/mac80211.h>
 #include "key.h"
 #include "aes_cmac.h"
 
 #define AAD_LEN 20
 
 static const u8 zero[IEEE80211_CMAC_256_MIC_LEN];
 
-int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-		       const u8 *data, size_t data_len, u8 *mic,
-		       unsigned int mic_len)
+void ieee80211_aes_cmac(const struct aes_cmac_key *key, const u8 *aad,
+			const u8 *data, size_t data_len, u8 *mic,
+			unsigned int mic_len)
 {
-	int err;
-	SHASH_DESC_ON_STACK(desc, tfm);
+	struct aes_cmac_ctx ctx;
 	u8 out[AES_BLOCK_SIZE];
 	const __le16 *fc;
 
-	desc->tfm = tfm;
-
-	err = crypto_shash_init(desc);
-	if (err)
-		return err;
-	err = crypto_shash_update(desc, aad, AAD_LEN);
-	if (err)
-		return err;
+	aes_cmac_init(&ctx, key);
+	aes_cmac_update(&ctx, aad, AAD_LEN);
 	fc = (const __le16 *)aad;
 	if (ieee80211_is_beacon(*fc)) {
 		/* mask Timestamp field to zero */
-		err = crypto_shash_update(desc, zero, 8);
-		if (err)
-			return err;
-		err = crypto_shash_update(desc, data + 8,
-					  data_len - 8 - mic_len);
-		if (err)
-			return err;
+		aes_cmac_update(&ctx, zero, 8);
+		aes_cmac_update(&ctx, data + 8, data_len - 8 - mic_len);
 	} else {
-		err = crypto_shash_update(desc, data, data_len - mic_len);
-		if (err)
-			return err;
+		aes_cmac_update(&ctx, data, data_len - mic_len);
 	}
-	err = crypto_shash_finup(desc, zero, mic_len, out);
-	if (err)
-		return err;
+	aes_cmac_update(&ctx, zero, mic_len);
+	aes_cmac_final(&ctx, out);
 	memcpy(mic, out, mic_len);
-
-	return 0;
-}
-
-struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
-						  size_t key_len)
-{
-	struct crypto_shash *tfm;
-
-	tfm = crypto_alloc_shash("cmac(aes)", 0, 0);
-	if (!IS_ERR(tfm)) {
-		int err = crypto_shash_setkey(tfm, key, key_len);
-
-		if (err) {
-			crypto_free_shash(tfm);
-			return ERR_PTR(err);
-		}
-	}
-
-	return tfm;
-}
-
-void ieee80211_aes_cmac_key_free(struct crypto_shash *tfm)
-{
-	crypto_free_shash(tfm);
 }
diff --git a/net/mac80211/aes_cmac.h b/net/mac80211/aes_cmac.h
index 5f971a8298cb..c7a6df47b327 100644
--- a/net/mac80211/aes_cmac.h
+++ b/net/mac80211/aes_cmac.h
@@ -4,16 +4,12 @@
  */
 
 #ifndef AES_CMAC_H
 #define AES_CMAC_H
 
-#include <linux/crypto.h>
-#include <crypto/hash.h>
+#include <crypto/aes-cbc-macs.h>
 
-struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
-						  size_t key_len);
-int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-		       const u8 *data, size_t data_len, u8 *mic,
-		       unsigned int mic_len);
-void ieee80211_aes_cmac_key_free(struct crypto_shash *tfm);
+void ieee80211_aes_cmac(const struct aes_cmac_key *key, const u8 *aad,
+			const u8 *data, size_t data_len, u8 *mic,
+			unsigned int mic_len);
 
 #endif /* AES_CMAC_H */
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 04c8809173d7..4b8965633df3 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -688,14 +688,13 @@ ieee80211_key_alloc(u32 cipher, int idx, size_t key_len,
 					seq[IEEE80211_CMAC_PN_LEN - j - 1];
 		/*
 		 * Initialize AES key state here as an optimization so that
 		 * it does not need to be initialized for every packet.
 		 */
-		key->u.aes_cmac.tfm =
-			ieee80211_aes_cmac_key_setup(key_data, key_len);
-		if (IS_ERR(key->u.aes_cmac.tfm)) {
-			err = PTR_ERR(key->u.aes_cmac.tfm);
+		err = aes_cmac_preparekey(&key->u.aes_cmac.key, key_data,
+					  key_len);
+		if (err) {
 			kfree(key);
 			return ERR_PTR(err);
 		}
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
@@ -748,14 +747,10 @@ static void ieee80211_key_free_common(struct ieee80211_key *key)
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
 		ieee80211_aes_key_free(key->u.ccmp.tfm);
 		break;
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		ieee80211_aes_cmac_key_free(key->u.aes_cmac.tfm);
-		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 		ieee80211_aes_gmac_key_free(key->u.aes_gmac.tfm);
 		break;
 	case WLAN_CIPHER_SUITE_GCMP:
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index 1fa0f4f78962..826e4e9387c5 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -10,10 +10,11 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/crypto.h>
 #include <linux/rcupdate.h>
+#include <crypto/aes-cbc-macs.h>
 #include <crypto/arc4.h>
 #include <net/mac80211.h>
 
 #define NUM_DEFAULT_KEYS 4
 #define NUM_DEFAULT_MGMT_KEYS 2
@@ -91,11 +92,11 @@ struct ieee80211_key {
 			struct crypto_aead *tfm;
 			u32 replays; /* dot11RSNAStatsCCMPReplays */
 		} ccmp;
 		struct {
 			u8 rx_pn[IEEE80211_CMAC_PN_LEN];
-			struct crypto_shash *tfm;
+			struct aes_cmac_key key;
 			u32 replays; /* dot11RSNAStatsCMACReplays */
 			u32 icverrors; /* dot11RSNAStatsCMACICVErrors */
 		} aes_cmac;
 		struct {
 			u8 rx_pn[IEEE80211_GMAC_PN_LEN];
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index fdf98c21d32c..59324b367bdd 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -870,15 +870,12 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx,
 	if (info->control.hw_key)
 		return TX_CONTINUE;
 
 	bip_aad(skb, aad);
 
-	if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-			       skb->data + 24, skb->len - 24,
-			       mmie->mic, mic_len))
-		return TX_DROP;
-
+	ieee80211_aes_cmac(&key->u.aes_cmac.key, aad, skb->data + 24,
+			   skb->len - 24, mmie->mic, mic_len);
 	return TX_CONTINUE;
 }
 
 ieee80211_rx_result
 ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx,
@@ -916,14 +913,12 @@ ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx,
 	}
 
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
-		if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-				       skb->data + 24, skb->len - 24,
-				       mic, mic_len))
-			return RX_DROP_U_DECRYPT_FAIL;
+		ieee80211_aes_cmac(&key->u.aes_cmac.key, aad, skb->data + 24,
+				   skb->len - 24, mic, mic_len);
 		if (crypto_memneq(mic, mmie->mic, mic_len)) {
 			key->u.aes_cmac.icverrors++;
 			return RX_DROP_U_MIC_FAIL;
 		}
 	}
-- 
2.53.0


