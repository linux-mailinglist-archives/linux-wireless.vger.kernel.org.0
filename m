Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98B3A53F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2019 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfFILzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jun 2019 07:55:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37656 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfFILzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jun 2019 07:55:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so6370365wrr.4
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jun 2019 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umqQnyDMdpEn6zwG2IG1Sf2HS5jaOEmJ4ynU8GI2sJ0=;
        b=aZXX2qvytl/4knmSgzfZg5z5r0fH5+eQJXF4y2kQoK+eP4tWCQ/DAZNt26x1uPdETu
         oxqpSnoaNRZ2mr4sHsb1ew5Dq39v4zvCxbNb2jU5ak+Tpkliqi6dMVGjLqKSVRmdYi3U
         L1OZnE++kxTVwNHR50tC/x4LlQkGs97gXs+N56yp7RbnYIH2O5+7RRRMluZgDIFagiWy
         bpl705rrhWxdtnFTrYX0RyBWEOCfSXNFvQANnJQM20j+2Cf1Ib+VOgUsrtaXEpa+Hv7r
         4vn+M/MZm9rzPuvFYiJMsVI8s3RgckLc7aCb4mJcOw+qogz/5dWcrgwsrYVSd1XYiTdP
         TOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umqQnyDMdpEn6zwG2IG1Sf2HS5jaOEmJ4ynU8GI2sJ0=;
        b=KLfaL2rMuIzqQsoDt2uEWaafsfuTGxTG5RKZn7raGpGh1CsqgZtv/5ziiG11ikpVAb
         drfvHs2hrVa+nRp+yABtEL5gMbSobtb3B1JoLT8bZyeW7Y4d9YAYeSGu1scEohXwP18t
         aZRUMQAlL99XVaHCWnZv3QjVa4iUDSW/mMxi7ommGboQz2Og5h100pmpK1rK9M/Qxq5x
         VVNwZicVSjuIsbGV9LL8waksvKnwkr64NbgbrqMkWmIOeQJtfjJDDmycYZVFwVkCeLTm
         y3tRyNQAfPYE1yzyJO7x2/RjpgnRXMazgJLfwZ6FkBYnOALkZZeNAtCtLVqjapRROf6j
         OB7w==
X-Gm-Message-State: APjAAAUyspx+4HzeKWXIQRYV+f4+Fn7qy8dGnMLFSUNQaMULcqonmRt9
        Ia95o5Vlkp7tKdKd0VvQaXOHZg==
X-Google-Smtp-Source: APXvYqwnkDftuk/fTsX9PFoxotJ5q2AhQ7Q1SlqB2SyHIuLCIxuAB25BRbHn9SPE0+RbcuZoOF+Rdg==
X-Received: by 2002:adf:e808:: with SMTP id o8mr8767859wrm.191.1560081317763;
        Sun, 09 Jun 2019 04:55:17 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:5129:23cd:5870:89d4])
        by smtp.gmail.com with ESMTPSA id r5sm14954317wrg.10.2019.06.09.04.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 04:55:17 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 4/7] net/lib80211: move TKIP handling to ARC4 library code
Date:   Sun,  9 Jun 2019 13:55:06 +0200
Message-Id: <20190609115509.26260-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190609115509.26260-1-ard.biesheuvel@linaro.org>
References: <20190609115509.26260-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The crypto API abstraction is not very useful for invoking ciphers
directly, especially in the case of arc4, which only has a generic
implementation in C. So let's invoke the library code directly.

Cc: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 net/wireless/lib80211_crypt_tkip.c | 42 ++++++--------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index 11eaa5956f00..c19528a39563 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -29,6 +29,7 @@
 #include <linux/ieee80211.h>
 #include <net/iw_handler.h>
 
+#include <crypto/arc4.h>
 #include <crypto/hash.h>
 #include <linux/crypto.h>
 #include <linux/crc32.h>
@@ -64,9 +65,9 @@ struct lib80211_tkip_data {
 
 	int key_idx;
 
-	struct crypto_cipher *rx_tfm_arc4;
+	struct crypto_arc4_ctx rx_ctx_arc4;
+	struct crypto_arc4_ctx tx_ctx_arc4;
 	struct crypto_shash *rx_tfm_michael;
-	struct crypto_cipher *tx_tfm_arc4;
 	struct crypto_shash *tx_tfm_michael;
 
 	/* scratch buffers for virt_to_page() (crypto API) */
@@ -99,24 +100,12 @@ static void *lib80211_tkip_init(int key_idx)
 
 	priv->key_idx = key_idx;
 
-	priv->tx_tfm_arc4 = crypto_alloc_cipher("arc4", 0, 0);
-	if (IS_ERR(priv->tx_tfm_arc4)) {
-		priv->tx_tfm_arc4 = NULL;
-		goto fail;
-	}
-
 	priv->tx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->tx_tfm_michael)) {
 		priv->tx_tfm_michael = NULL;
 		goto fail;
 	}
 
-	priv->rx_tfm_arc4 = crypto_alloc_cipher("arc4", 0, 0);
-	if (IS_ERR(priv->rx_tfm_arc4)) {
-		priv->rx_tfm_arc4 = NULL;
-		goto fail;
-	}
-
 	priv->rx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(priv->rx_tfm_michael)) {
 		priv->rx_tfm_michael = NULL;
@@ -128,9 +117,7 @@ static void *lib80211_tkip_init(int key_idx)
       fail:
 	if (priv) {
 		crypto_free_shash(priv->tx_tfm_michael);
-		crypto_free_cipher(priv->tx_tfm_arc4);
 		crypto_free_shash(priv->rx_tfm_michael);
-		crypto_free_cipher(priv->rx_tfm_arc4);
 		kfree(priv);
 	}
 
@@ -142,9 +129,7 @@ static void lib80211_tkip_deinit(void *priv)
 	struct lib80211_tkip_data *_priv = priv;
 	if (_priv) {
 		crypto_free_shash(_priv->tx_tfm_michael);
-		crypto_free_cipher(_priv->tx_tfm_arc4);
 		crypto_free_shash(_priv->rx_tfm_michael);
-		crypto_free_cipher(_priv->rx_tfm_arc4);
 	}
 	kfree(priv);
 }
@@ -345,7 +330,6 @@ static int lib80211_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	int len;
 	u8 rc4key[16], *pos, *icv;
 	u32 crc;
-	int i;
 
 	if (tkey->flags & IEEE80211_CRYPTO_TKIP_COUNTERMEASURES) {
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
@@ -370,9 +354,9 @@ static int lib80211_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	icv[2] = crc >> 16;
 	icv[3] = crc >> 24;
 
-	crypto_cipher_setkey(tkey->tx_tfm_arc4, rc4key, 16);
-	for (i = 0; i < len + 4; i++)
-		crypto_cipher_encrypt_one(tkey->tx_tfm_arc4, pos + i, pos + i);
+	crypto_arc4_set_key(&tkey->tx_ctx_arc4, rc4key, 16);
+	crypto_arc4_crypt(&tkey->tx_ctx_arc4, pos, pos, len + 4);
+
 	return 0;
 }
 
@@ -400,7 +384,6 @@ static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	u8 icv[4];
 	u32 crc;
 	int plen;
-	int i;
 
 	hdr = (struct ieee80211_hdr *)skb->data;
 
@@ -453,9 +436,8 @@ static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 
 	plen = skb->len - hdr_len - 12;
 
-	crypto_cipher_setkey(tkey->rx_tfm_arc4, rc4key, 16);
-	for (i = 0; i < plen + 4; i++)
-		crypto_cipher_decrypt_one(tkey->rx_tfm_arc4, pos + i, pos + i);
+	crypto_arc4_set_key(&tkey->rx_ctx_arc4, rc4key, 16);
+	crypto_arc4_crypt(&tkey->rx_ctx_arc4, pos, pos, plen + 4);
 
 	crc = ~crc32_le(~0, pos, plen);
 	icv[0] = crc;
@@ -640,17 +622,17 @@ static int lib80211_tkip_set_key(void *key, int len, u8 * seq, void *priv)
 	struct lib80211_tkip_data *tkey = priv;
 	int keyidx;
 	struct crypto_shash *tfm = tkey->tx_tfm_michael;
-	struct crypto_cipher *tfm2 = tkey->tx_tfm_arc4;
+	struct crypto_arc4_ctx *tfm2 = &tkey->tx_ctx_arc4;
 	struct crypto_shash *tfm3 = tkey->rx_tfm_michael;
-	struct crypto_cipher *tfm4 = tkey->rx_tfm_arc4;
+	struct crypto_arc4_ctx *tfm4 = &tkey->rx_ctx_arc4;
 
 	keyidx = tkey->key_idx;
 	memset(tkey, 0, sizeof(*tkey));
 	tkey->key_idx = keyidx;
 	tkey->tx_tfm_michael = tfm;
-	tkey->tx_tfm_arc4 = tfm2;
+	tkey->tx_ctx_arc4 = *tfm2;
 	tkey->rx_tfm_michael = tfm3;
-	tkey->rx_tfm_arc4 = tfm4;
+	tkey->rx_ctx_arc4 = *tfm4;
 	if (len == TKIP_KEY_LEN) {
 		memcpy(tkey->key, key, TKIP_KEY_LEN);
 		tkey->key_set = 1;
-- 
2.20.1

