Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CC38E09
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfFGOui (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 10:50:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42489 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFGOug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 10:50:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so2449610wrl.9
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9n8YJM2aN2Tojwoz4xxKnfvlttLhNaxdXPyMxomRKLg=;
        b=PUiwLSAco3hmTp+31PViC1LfHPHcDGVR3bNcQjgSgRJjL5nJRypoQcMaOu6BfKV9d9
         +aR/g1qclXtfM5JL40LECuhW9xZLo8lSFghvrCruHvVCtZurzrGCz89+ANOrEnSwL6T+
         BeQ264VKH7RvNB0dITMAfuDM7Evf7M2uvMz4s9RbQ1j13G1pE6obWzlInoyeobaUq5yE
         zI3ngdTy1ShFwn2bUWYQTT9qHfAHz81dlbC7TnYE7qTyMvkRA0WtxoKmbdZZf0sIaCp0
         ajAjfg4bB+IV00Qr0ODUYFnlqW81uXfG6zq5Bb/Jym8ZyZiowcHzpSWzplWN8B7YJbc7
         KFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9n8YJM2aN2Tojwoz4xxKnfvlttLhNaxdXPyMxomRKLg=;
        b=DkOjW+Skgx9TBvYb0rGo4NLsZA3WCtSuzUQiUhajpSLW/2I1siJkWAkFMkylsaLGYE
         pdxEtncyb9W77OW3t99WwwBRbWbzsu8TxQXIuLEvr4nhfVk73LEmc1ttENNf/lhstTWu
         D6UwDOiWmF0V6aCKVaMXU/IJgt/j8bvvyN3z2VZ8bYjxMRTTZ+2rRum2CLO5vSmG7+ZB
         xIz1lYzaS8pGS+cYfk+yiGR5XKaSAL42YwC2++ZoOo1DYE0xONmzQhA6ppPpuN2tI10q
         p1mttiITncpWEWAymTMCAg3MDrqZIgXlHiFbtGoe4/V5ZoKoLmsvcHW5yD1Ot2Vb8KKl
         78xg==
X-Gm-Message-State: APjAAAV/vlqtCArGkZTnIWcpsOTWPetbZRep03DpSimKNvZebJx99yrv
        WduhQ+k9tYXep8lJO58v9wejIA9dDl9THA==
X-Google-Smtp-Source: APXvYqxFVSY0azfTGLywjCh4fg09eiv7Zyyzv+CaMc66H7m3h97p81qndUThVkMzh6g2JCMQqkRIiw==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr32550695wrn.80.1559919034855;
        Fri, 07 Jun 2019 07:50:34 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-126-188.w90-88.abo.wanadoo.fr. [90.88.7.188])
        by smtp.gmail.com with ESMTPSA id t13sm4129354wra.81.2019.06.07.07.50.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:50:34 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        davem@davemloft.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH 3/3] lib80211/wep: switch to skcipher interface for arc4
Date:   Fri,  7 Jun 2019 16:49:44 +0200
Message-Id: <20190607144944.13485-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WEP code uses the arc4 cipher interface, and invokes it byte by
byte. This is rather inefficient, and since the cipher interface in
general is not really suitable for use outside of the crypto subsystem,
move this code to use the skcipher interface instead.

Given that the only driver that provides a RC4 cipher also provides
a skcipher implementation, this is guaranteed to work. (Note that
ARC4_BLOCK_SIZE is #define'd as 1 so ecb(arc4) behaves as a stream
cipher, as is required in this case)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 net/wireless/lib80211_crypt_wep.c | 52 ++++++++++++++------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/net/wireless/lib80211_crypt_wep.c b/net/wireless/lib80211_crypt_wep.c
index 20c1ad63ad44..461f94afe6e9 100644
--- a/net/wireless/lib80211_crypt_wep.c
+++ b/net/wireless/lib80211_crypt_wep.c
@@ -23,6 +23,7 @@
 #include <net/lib80211.h>
 
 #include <linux/crypto.h>
+#include <crypto/skcipher.h>
 #include <linux/crc32.h>
 
 MODULE_AUTHOR("Jouni Malinen");
@@ -35,8 +36,10 @@ struct lib80211_wep_data {
 	u8 key[WEP_KEY_LEN + 1];
 	u8 key_len;
 	u8 key_idx;
-	struct crypto_cipher *tx_tfm;
-	struct crypto_cipher *rx_tfm;
+	struct crypto_skcipher *tx_tfm;
+	struct crypto_skcipher *rx_tfm;
+	struct skcipher_request *tx_req;
+	struct skcipher_request *rx_req;
 };
 
 static void *lib80211_wep_init(int keyidx)
@@ -48,17 +51,26 @@ static void *lib80211_wep_init(int keyidx)
 		goto fail;
 	priv->key_idx = keyidx;
 
-	priv->tx_tfm = crypto_alloc_cipher("arc4", 0, 0);
+	priv->tx_tfm = crypto_alloc_skcipher("ecb(arc4)", 0, 0);
 	if (IS_ERR(priv->tx_tfm)) {
 		priv->tx_tfm = NULL;
 		goto fail;
 	}
 
-	priv->rx_tfm = crypto_alloc_cipher("arc4", 0, 0);
+	priv->rx_tfm = crypto_alloc_skcipher("arc4", 0, 0);
 	if (IS_ERR(priv->rx_tfm)) {
 		priv->rx_tfm = NULL;
 		goto fail;
 	}
+
+	priv->tx_req = skcipher_request_alloc(priv->tx_tfm, GFP_KERNEL);
+	if (!priv->tx_req)
+		goto fail;
+
+	priv->rx_req = skcipher_request_alloc(priv->rx_tfm, GFP_KERNEL);
+	if (!priv->tx_req)
+		goto fail;
+
 	/* start WEP IV from a random value */
 	get_random_bytes(&priv->iv, 4);
 
@@ -66,8 +78,10 @@ static void *lib80211_wep_init(int keyidx)
 
       fail:
 	if (priv) {
-		crypto_free_cipher(priv->tx_tfm);
-		crypto_free_cipher(priv->rx_tfm);
+		skcipher_request_free(priv->tx_req);
+		skcipher_request_free(priv->rx_req);
+		crypto_free_skcipher(priv->tx_tfm);
+		crypto_free_skcipher(priv->rx_tfm);
 		kfree(priv);
 	}
 	return NULL;
@@ -77,8 +91,10 @@ static void lib80211_wep_deinit(void *priv)
 {
 	struct lib80211_wep_data *_priv = priv;
 	if (_priv) {
-		crypto_free_cipher(_priv->tx_tfm);
-		crypto_free_cipher(_priv->rx_tfm);
+		skcipher_request_free(_priv->tx_req);
+		skcipher_request_free(_priv->rx_req);
+		crypto_free_skcipher(_priv->tx_tfm);
+		crypto_free_skcipher(_priv->rx_tfm);
 	}
 	kfree(priv);
 }
@@ -129,10 +145,10 @@ static int lib80211_wep_build_iv(struct sk_buff *skb, int hdr_len,
 static int lib80211_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct lib80211_wep_data *wep = priv;
+	struct scatterlist sg;
 	u32 crc, klen, len;
 	u8 *pos, *icv;
 	u8 key[WEP_KEY_LEN + 3];
-	int i;
 
 	/* other checks are in lib80211_wep_build_iv */
 	if (skb_tailroom(skb) < 4)
@@ -160,10 +176,11 @@ static int lib80211_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	icv[2] = crc >> 16;
 	icv[3] = crc >> 24;
 
-	crypto_cipher_setkey(wep->tx_tfm, key, klen);
-
-	for (i = 0; i < len + 4; i++)
-		crypto_cipher_encrypt_one(wep->tx_tfm, pos + i, pos + i);
+	crypto_skcipher_setkey(wep->tx_tfm, key, klen);
+	sg_init_one(&sg, pos, len + 4);
+	skcipher_request_set_crypt(wep->tx_req, &sg, &sg, len + 4, NULL);
+	if (crypto_skcipher_encrypt(wep->tx_req) < 0)
+		return -1;
 
 	return 0;
 }
@@ -178,6 +195,7 @@ static int lib80211_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 static int lib80211_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct lib80211_wep_data *wep = priv;
+	struct scatterlist sg;
 	u32 crc, klen, plen;
 	u8 key[WEP_KEY_LEN + 3];
 	u8 keyidx, *pos, icv[4];
@@ -202,9 +220,11 @@ static int lib80211_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	/* Apply RC4 to data and compute CRC32 over decrypted data */
 	plen = skb->len - hdr_len - 8;
 
-	crypto_cipher_setkey(wep->rx_tfm, key, klen);
-	for (i = 0; i < plen + 4; i++)
-		crypto_cipher_decrypt_one(wep->rx_tfm, pos + i, pos + i);
+	crypto_skcipher_setkey(wep->rx_tfm, key, klen);
+	sg_init_one(&sg, pos, plen + 4);
+	skcipher_request_set_crypt(wep->rx_req, &sg, &sg, plen + 4, NULL);
+	if (crypto_skcipher_decrypt(wep->rx_req) < 0)
+		return -1;
 
 	crc = ~crc32_le(~0, pos, plen);
 	icv[0] = crc;
-- 
2.20.1

