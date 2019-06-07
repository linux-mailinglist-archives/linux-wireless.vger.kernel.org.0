Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D622E38E05
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfFGOue (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 10:50:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42486 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfFGOue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 10:50:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so2449480wrl.9
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcJMY+fqzbzAsxP+j3GnSWwHUteH8OqWbcpKZgatReo=;
        b=CZvlAiz3/tzc0J+yK6zjz21aKF5BPmxTt6qoB9PW1Yy0vRpVdqsicmFntJ4+afYK9B
         5+WCgfi/CcIVy1mRQ8MwEJk+K3tpzpt9G2WM9Uw3Rsc4rYc+6fQRn3xkeD77lBJX8umh
         chRJ3knrqwH3YGfvNnx2MuT4CxAYFNTBEBSdESyNZyW2owmYgVBQrGZfM6eRJiJLrnXO
         Hg+mMsjeYovYgWVQSvmBjW/0bKbM2FsAYCLSWFP0SP05sxTcnDrXRDmBBTor2dh1QlXG
         dzCO/Ddu3MVzWX68hZcTxKzZ/ED1+ddSPqU4t+3hiffiGE5ay8wyAjZsZ3OEzV5FjZv8
         Jo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcJMY+fqzbzAsxP+j3GnSWwHUteH8OqWbcpKZgatReo=;
        b=NXjvGZBwVQUu7pSAwJjYNmnrB0j/DoivprxkWyYlS/ilC8uLwCUot2fLDG1/1OzrlM
         eT+g78/uiY5DxW3oZZVXtQPkZ3pO8S1/5g2O2QbmGsVuMv9FvYF15/DVrSz4IpwEAP0f
         6f9ps2VzTrOZ66maadSH1hKAulD6mlreQD/1czuJjCX4MYR0LIMHL6OKbqEuopJ3h0bo
         yCN7IErVoHYb2nFVxIpwnfSsjDvTzFhhVI36XFaic4L4/+B91oMkB2KZe1BuqPkUz6k8
         Fca+01vHGS4WTBirTNQkdWk0OgL+nWlauIPB3oCFmgn+InwS/jSh9aV/VLFlz/c2LZ/9
         Y3Ug==
X-Gm-Message-State: APjAAAUEjchxjA94Ckf9qKQzqkZ/Gs4oqBTJLGhrERAXasQMepeePqD2
        ZwRnJjQIe3aI9MM90LN3/cNm35REE4GmYQ==
X-Google-Smtp-Source: APXvYqydF0s3UC9VVMUOwUe559EMfYIIyoRPoUa0LkLSDywz1iTI7f7ge76HX9sY9OnVNY5dSFie1Q==
X-Received: by 2002:adf:dc09:: with SMTP id t9mr34406067wri.69.1559919032627;
        Fri, 07 Jun 2019 07:50:32 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-126-188.w90-88.abo.wanadoo.fr. [90.88.7.188])
        by smtp.gmail.com with ESMTPSA id t13sm4129354wra.81.2019.06.07.07.50.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:50:31 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        davem@davemloft.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH 1/3] net/mac80211: switch to skcipher interface for arc4
Date:   Fri,  7 Jun 2019 16:49:42 +0200
Message-Id: <20190607144944.13485-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The mac80211 WEP code uses the cipher interface, and invokes it byte
by byte. This is rather inefficient, and since the cipher interface in
general is not really suitable for use outside of the crypto subsystem,
move this code to use the skcipher interface instead.

Given that the only driver that provides a RC4 cipher also provides
a skcipher implementation, this is guaranteed to work. (Note that
ARC4_BLOCK_SIZE is #define'd as 1 so ecb(arc4) behaves as a stream
cipher, as is required in this case)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 net/mac80211/ieee80211_i.h |  6 +-
 net/mac80211/key.h         |  1 +
 net/mac80211/tkip.c        |  8 +-
 net/mac80211/tkip.h        |  4 +-
 net/mac80211/wep.c         | 81 +++++++++++++++-----
 net/mac80211/wep.h         |  4 +-
 net/mac80211/wpa.c         |  4 +-
 7 files changed, 75 insertions(+), 33 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 073a8235ae1b..c0773cf685b6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1258,8 +1258,10 @@ struct ieee80211_local {
 
 	struct rate_control_ref *rate_ctrl;
 
-	struct crypto_cipher *wep_tx_tfm;
-	struct crypto_cipher *wep_rx_tfm;
+	struct crypto_skcipher *wep_tx_tfm;
+	struct crypto_skcipher *wep_rx_tfm;
+	struct skcipher_request *wep_tx_req;
+	struct skcipher_request *wep_rx_req;
 	u32 wep_iv;
 
 	/* see iface.c */
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index f06fbd03d235..ee5e7f30a1f1 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/crypto.h>
+#include <crypto/skcipher.h>
 #include <linux/rcupdate.h>
 #include <net/mac80211.h>
 
diff --git a/net/mac80211/tkip.c b/net/mac80211/tkip.c
index b3622823bad2..23dd962633fe 100644
--- a/net/mac80211/tkip.c
+++ b/net/mac80211/tkip.c
@@ -222,7 +222,7 @@ EXPORT_SYMBOL(ieee80211_get_tkip_p2k);
  * @payload_len is the length of payload (_not_ including IV/ICV length).
  * @ta is the transmitter addresses.
  */
-int ieee80211_tkip_encrypt_data(struct crypto_cipher *tfm,
+int ieee80211_tkip_encrypt_data(struct skcipher_request *req,
 				struct ieee80211_key *key,
 				struct sk_buff *skb,
 				u8 *payload, size_t payload_len)
@@ -231,7 +231,7 @@ int ieee80211_tkip_encrypt_data(struct crypto_cipher *tfm,
 
 	ieee80211_get_tkip_p2k(&key->conf, skb, rc4key);
 
-	return ieee80211_wep_encrypt_data(tfm, rc4key, 16,
+	return ieee80211_wep_encrypt_data(req, rc4key, 16,
 					  payload, payload_len);
 }
 
@@ -239,7 +239,7 @@ int ieee80211_tkip_encrypt_data(struct crypto_cipher *tfm,
  * beginning of the buffer containing IEEE 802.11 header payload, i.e.,
  * including IV, Ext. IV, real data, Michael MIC, ICV. @payload_len is the
  * length of payload, including IV, Ext. IV, MIC, ICV.  */
-int ieee80211_tkip_decrypt_data(struct crypto_cipher *tfm,
+int ieee80211_tkip_decrypt_data(struct skcipher_request *req,
 				struct ieee80211_key *key,
 				u8 *payload, size_t payload_len, u8 *ta,
 				u8 *ra, int only_iv, int queue,
@@ -297,7 +297,7 @@ int ieee80211_tkip_decrypt_data(struct crypto_cipher *tfm,
 
 	tkip_mixing_phase2(tk, &rx_ctx->ctx, iv16, rc4key);
 
-	res = ieee80211_wep_decrypt_data(tfm, rc4key, 16, pos, payload_len - 12);
+	res = ieee80211_wep_decrypt_data(req, rc4key, 16, pos, payload_len - 12);
  done:
 	if (res == TKIP_DECRYPT_OK) {
 		/*
diff --git a/net/mac80211/tkip.h b/net/mac80211/tkip.h
index a1bcbfbefe7c..e66aac448786 100644
--- a/net/mac80211/tkip.h
+++ b/net/mac80211/tkip.h
@@ -13,7 +13,7 @@
 #include <linux/crypto.h>
 #include "key.h"
 
-int ieee80211_tkip_encrypt_data(struct crypto_cipher *tfm,
+int ieee80211_tkip_encrypt_data(struct skcipher_request *req,
 				struct ieee80211_key *key,
 				struct sk_buff *skb,
 				u8 *payload, size_t payload_len);
@@ -24,7 +24,7 @@ enum {
 	TKIP_DECRYPT_INVALID_KEYIDX = -2,
 	TKIP_DECRYPT_REPLAY = -3,
 };
-int ieee80211_tkip_decrypt_data(struct crypto_cipher *tfm,
+int ieee80211_tkip_decrypt_data(struct skcipher_request *req,
 				struct ieee80211_key *key,
 				u8 *payload, size_t payload_len, u8 *ta,
 				u8 *ra, int only_iv, int queue,
diff --git a/net/mac80211/wep.c b/net/mac80211/wep.c
index bfe9ed9f4c48..0336afb70c2b 100644
--- a/net/mac80211/wep.c
+++ b/net/mac80211/wep.c
@@ -27,31 +27,64 @@
 
 int ieee80211_wep_init(struct ieee80211_local *local)
 {
+	int err;
+
 	/* start WEP IV from a random value */
 	get_random_bytes(&local->wep_iv, IEEE80211_WEP_IV_LEN);
 
-	local->wep_tx_tfm = crypto_alloc_cipher("arc4", 0, 0);
+	local->wep_tx_tfm = crypto_alloc_skcipher("ecb(arc4)", 0,
+						  CRYPTO_ALG_ASYNC);
 	if (IS_ERR(local->wep_tx_tfm)) {
 		local->wep_rx_tfm = ERR_PTR(-EINVAL);
 		return PTR_ERR(local->wep_tx_tfm);
 	}
 
-	local->wep_rx_tfm = crypto_alloc_cipher("arc4", 0, 0);
+	local->wep_rx_tfm = crypto_alloc_skcipher("ecb(arc4)", 0,
+						  CRYPTO_ALG_ASYNC);
 	if (IS_ERR(local->wep_rx_tfm)) {
-		crypto_free_cipher(local->wep_tx_tfm);
-		local->wep_tx_tfm = ERR_PTR(-EINVAL);
-		return PTR_ERR(local->wep_rx_tfm);
+		err = PTR_ERR(local->wep_rx_tfm);
+		goto free_tx_tfm;
+	}
+
+	local->wep_tx_req = skcipher_request_alloc(local->wep_tx_tfm,
+						   GFP_KERNEL);
+	if (!local->wep_tx_req) {
+		err = -ENOMEM;
+		goto free_rx_tfm;
+	}
+
+	local->wep_rx_req = skcipher_request_alloc(local->wep_rx_tfm,
+						   GFP_KERNEL);
+	if (!local->wep_rx_req) {
+		err = -ENOMEM;
+		goto free_tx_req;
 	}
 
 	return 0;
+
+free_tx_req:
+	skcipher_request_free(local->wep_tx_req);
+	local->wep_tx_req = NULL;
+free_rx_tfm:
+	crypto_free_skcipher(local->wep_rx_tfm);
+	local->wep_rx_tfm = ERR_PTR(-EINVAL);
+free_tx_tfm:
+	crypto_free_skcipher(local->wep_tx_tfm);
+	local->wep_tx_tfm = ERR_PTR(-EINVAL);
+
+	return err;
 }
 
 void ieee80211_wep_free(struct ieee80211_local *local)
 {
+	if (local->wep_tx_req)
+		skcipher_request_free(local->wep_tx_req);
+	if (local->wep_rx_req)
+		skcipher_request_free(local->wep_rx_req);
 	if (!IS_ERR(local->wep_tx_tfm))
-		crypto_free_cipher(local->wep_tx_tfm);
+		crypto_free_skcipher(local->wep_tx_tfm);
 	if (!IS_ERR(local->wep_rx_tfm))
-		crypto_free_cipher(local->wep_rx_tfm);
+		crypto_free_skcipher(local->wep_rx_tfm);
 }
 
 static inline bool ieee80211_wep_weak_iv(u32 iv, int keylen)
@@ -131,21 +164,24 @@ static void ieee80211_wep_remove_iv(struct ieee80211_local *local,
 /* Perform WEP encryption using given key. data buffer must have tailroom
  * for 4-byte ICV. data_len must not include this ICV. Note: this function
  * does _not_ add IV. data = RC4(data | CRC32(data)) */
-int ieee80211_wep_encrypt_data(struct crypto_cipher *tfm, u8 *rc4key,
+int ieee80211_wep_encrypt_data(struct skcipher_request *req, u8 *rc4key,
 			       size_t klen, u8 *data, size_t data_len)
 {
+	struct scatterlist sg;
 	__le32 icv;
-	int i;
 
-	if (IS_ERR(tfm))
+	if (!req)
 		return -1;
 
 	icv = cpu_to_le32(~crc32_le(~0, data, data_len));
 	put_unaligned(icv, (__le32 *)(data + data_len));
 
-	crypto_cipher_setkey(tfm, rc4key, klen);
-	for (i = 0; i < data_len + IEEE80211_WEP_ICV_LEN; i++)
-		crypto_cipher_encrypt_one(tfm, data + i, data + i);
+	crypto_skcipher_setkey(crypto_skcipher_reqtfm(req), rc4key, klen);
+	sg_init_one(&sg, data, data_len + IEEE80211_WEP_ICV_LEN);
+	skcipher_request_set_crypt(req, &sg, &sg,
+				   data_len + IEEE80211_WEP_ICV_LEN, NULL);
+	if (crypto_skcipher_encrypt(req) < 0)
+		return -1;
 
 	return 0;
 }
@@ -184,7 +220,7 @@ int ieee80211_wep_encrypt(struct ieee80211_local *local,
 	/* Add room for ICV */
 	skb_put(skb, IEEE80211_WEP_ICV_LEN);
 
-	return ieee80211_wep_encrypt_data(local->wep_tx_tfm, rc4key, keylen + 3,
+	return ieee80211_wep_encrypt_data(local->wep_tx_req, rc4key, keylen + 3,
 					  iv + IEEE80211_WEP_IV_LEN, len);
 }
 
@@ -192,18 +228,21 @@ int ieee80211_wep_encrypt(struct ieee80211_local *local,
 /* Perform WEP decryption using given key. data buffer includes encrypted
  * payload, including 4-byte ICV, but _not_ IV. data_len must not include ICV.
  * Return 0 on success and -1 on ICV mismatch. */
-int ieee80211_wep_decrypt_data(struct crypto_cipher *tfm, u8 *rc4key,
+int ieee80211_wep_decrypt_data(struct skcipher_request *req, u8 *rc4key,
 			       size_t klen, u8 *data, size_t data_len)
 {
+	struct scatterlist sg;
 	__le32 crc;
-	int i;
 
-	if (IS_ERR(tfm))
+	if (!req)
 		return -1;
 
-	crypto_cipher_setkey(tfm, rc4key, klen);
-	for (i = 0; i < data_len + IEEE80211_WEP_ICV_LEN; i++)
-		crypto_cipher_decrypt_one(tfm, data + i, data + i);
+	crypto_skcipher_setkey(crypto_skcipher_reqtfm(req), rc4key, klen);
+	sg_init_one(&sg, data, data_len + IEEE80211_WEP_ICV_LEN);
+	skcipher_request_set_crypt(req, &sg, &sg,
+				   data_len + IEEE80211_WEP_ICV_LEN, NULL);
+	if (crypto_skcipher_decrypt(req) < 0)
+		return -1;
 
 	crc = cpu_to_le32(~crc32_le(~0, data, data_len));
 	if (memcmp(&crc, data + data_len, IEEE80211_WEP_ICV_LEN) != 0)
@@ -256,7 +295,7 @@ static int ieee80211_wep_decrypt(struct ieee80211_local *local,
 	/* Copy rest of the WEP key (the secret part) */
 	memcpy(rc4key + 3, key->conf.key, key->conf.keylen);
 
-	if (ieee80211_wep_decrypt_data(local->wep_rx_tfm, rc4key, klen,
+	if (ieee80211_wep_decrypt_data(local->wep_rx_req, rc4key, klen,
 				       skb->data + hdrlen +
 				       IEEE80211_WEP_IV_LEN, len))
 		ret = -1;
diff --git a/net/mac80211/wep.h b/net/mac80211/wep.h
index 9615749d1f65..6a392b1ed4b7 100644
--- a/net/mac80211/wep.h
+++ b/net/mac80211/wep.h
@@ -18,12 +18,12 @@
 
 int ieee80211_wep_init(struct ieee80211_local *local);
 void ieee80211_wep_free(struct ieee80211_local *local);
-int ieee80211_wep_encrypt_data(struct crypto_cipher *tfm, u8 *rc4key,
+int ieee80211_wep_encrypt_data(struct skcipher_request *req, u8 *rc4key,
 				size_t klen, u8 *data, size_t data_len);
 int ieee80211_wep_encrypt(struct ieee80211_local *local,
 			  struct sk_buff *skb,
 			  const u8 *key, int keylen, int keyidx);
-int ieee80211_wep_decrypt_data(struct crypto_cipher *tfm, u8 *rc4key,
+int ieee80211_wep_decrypt_data(struct skcipher_request *req, u8 *rc4key,
 			       size_t klen, u8 *data, size_t data_len);
 
 ieee80211_rx_result
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 58d0b258b684..a7870ec67a26 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -242,7 +242,7 @@ static int tkip_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb)
 	/* Add room for ICV */
 	skb_put(skb, IEEE80211_TKIP_ICV_LEN);
 
-	return ieee80211_tkip_encrypt_data(tx->local->wep_tx_tfm,
+	return ieee80211_tkip_encrypt_data(tx->local->wep_tx_req,
 					   key, skb, pos, len);
 }
 
@@ -293,7 +293,7 @@ ieee80211_crypto_tkip_decrypt(struct ieee80211_rx_data *rx)
 	if (status->flag & RX_FLAG_DECRYPTED)
 		hwaccel = 1;
 
-	res = ieee80211_tkip_decrypt_data(rx->local->wep_rx_tfm,
+	res = ieee80211_tkip_decrypt_data(rx->local->wep_rx_req,
 					  key, skb->data + hdrlen,
 					  skb->len - hdrlen, rx->sta->sta.addr,
 					  hdr->addr1, hwaccel, rx->security_idx,
-- 
2.20.1

