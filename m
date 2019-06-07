Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB738E0B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfFGOuh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 10:50:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37191 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfFGOuf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 10:50:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so2205624wmg.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6Wy0LB17Cj8+QFhDjq+MOW1OHqvbDIBczgJ5kYrrbI=;
        b=xzaE+3nRMJcAfiRFheJgq7ol8JYf2GZx2t/sk5NVe5j9CnldAHgP4s/Xz+Px6ZEz7X
         xGWKPQEEn4kDOJ+pKVrFNbvTsgIS/umEIQxDx8MbIpVlm5yU/d5ch7Z9/ojPCtMfOTR2
         RdCmaqud8/nO4QcdMTk5rD9ZYtzler0FRiC9sJ+KKr/Y4qg1HS14MC56w5tJzCmQfAeh
         q9Tra4gXU0dByQrHkPq7ksV6rxHvru13Tg2PmZcEzqaTWgK1bRPSXNELZuNWKVEPX4FO
         ArHQ2wGTRjh/rv/RmVmOrrPA1Sm0CDTt+Fp6hBIjoFOEAAjnc4DA0i/HU6jNZJh0T3kv
         hpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6Wy0LB17Cj8+QFhDjq+MOW1OHqvbDIBczgJ5kYrrbI=;
        b=IZ9Q3sqlDy9DbqfzMhQ5IvpnUw2V4oKvLG1Lm9LYYjmSc/j4uPqpL/iRYQSNFWVdSU
         FEOQpVouaqnPxLaVgiHNYURS6zTOOVyhEb/3DlZeHaIzWGqh0yBPgeEYKb/XHzQcgRac
         OV032ohwhTWiLS/kKMfhflToWSf48OzhE72JOX/9j11+bb0qYoBOBTkkkdjUzZC3Y9jr
         HVUHkCvGZh+Hg+MNxyCd1CTDSbjPhlToHbQr4xRB7o/sgtm8LSp6kigWoJJLuOtJ28Yo
         CJVnkymQKR8GaG/q2yStPok4fdr9eGT5P+FbZuNXr31xNZh6UaZQzV2AGGrPNw0Qr7DX
         x9Nw==
X-Gm-Message-State: APjAAAUxcGEUzZ/0qOBSlaRfLEL01zvCQ+s4uTnv1rglmDEZRWnAlL/R
        uYwF8Mq1RJLm7Q9QPoKJ2ZpkSw==
X-Google-Smtp-Source: APXvYqxDd2bsboZayCVfX84i2mTQBsV5ovAMJqvB6quHwmu93T6O11m5STFQcm12ih+7klauM967IQ==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192mr3942201wmb.152.1559919033813;
        Fri, 07 Jun 2019 07:50:33 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-126-188.w90-88.abo.wanadoo.fr. [90.88.7.188])
        by smtp.gmail.com with ESMTPSA id t13sm4129354wra.81.2019.06.07.07.50.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:50:33 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        davem@davemloft.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH 2/3] lib80211/tkip: switch to skcipher interface for arc4
Date:   Fri,  7 Jun 2019 16:49:43 +0200
Message-Id: <20190607144944.13485-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The TKIP code uses the arc4 cipher interface, and invokes it byte by
byte. This is rather inefficient, and since the cipher interface in
general is not really suitable for use outside of the crypto subsystem,
move this code to use the skcipher interface instead.

Given that the only driver that provides a RC4 cipher also provides
a skcipher implementation, this is guaranteed to work. (Note that
ARC4_BLOCK_SIZE is #define'd as 1 so ecb(arc4) behaves as a stream
cipher, as is required in this case)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 net/wireless/lib80211_crypt_tkip.c | 61 ++++++++++++++------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index 11eaa5956f00..456c85b03b32 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -30,6 +30,7 @@
 #include <net/iw_handler.h>
 
 #include <crypto/hash.h>
+#include <crypto/skcipher.h>
 #include <linux/crypto.h>
 #include <linux/crc32.h>
 
@@ -64,9 +65,11 @@ struct lib80211_tkip_data {
 
 	int key_idx;
 
-	struct crypto_cipher *rx_tfm_arc4;
+	struct crypto_skcipher *rx_tfm_arc4;
+	struct skcipher_request *rx_req_arc4;
 	struct crypto_shash *rx_tfm_michael;
-	struct crypto_cipher *tx_tfm_arc4;
+	struct crypto_skcipher *tx_tfm_arc4;
+	struct skcipher_request *tx_req_arc4;
 	struct crypto_shash *tx_tfm_michael;
 
 	/* scratch buffers for virt_to_page() (crypto API) */
@@ -99,7 +102,8 @@ static void *lib80211_tkip_init(int key_idx)
 
 	priv->key_idx = key_idx;
 
-	priv->tx_tfm_arc4 = crypto_alloc_cipher("arc4", 0, 0);
+	priv->tx_tfm_arc4 = crypto_alloc_skcipher("ecb(arc4)", 0,
+						  CRYPTO_ALG_ASYNC);
 	if (IS_ERR(priv->tx_tfm_arc4)) {
 		priv->tx_tfm_arc4 = NULL;
 		goto fail;
@@ -111,7 +115,8 @@ static void *lib80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
-	priv->rx_tfm_arc4 = crypto_alloc_cipher("arc4", 0, 0);
+	priv->rx_tfm_arc4 = crypto_alloc_skcipher("ecb(arc4)", 0,
+						  CRYPTO_ALG_ASYNC);
 	if (IS_ERR(priv->rx_tfm_arc4)) {
 		priv->rx_tfm_arc4 = NULL;
 		goto fail;
@@ -123,14 +128,26 @@ static void *lib80211_tkip_init(int key_idx)
 		goto fail;
 	}
 
+	priv->tx_req_arc4 = skcipher_request_alloc(priv->tx_tfm_arc4,
+						   GFP_KERNEL);
+	if (!priv->tx_req_arc4)
+		goto fail;
+
+	priv->rx_req_arc4 = skcipher_request_alloc(priv->rx_tfm_arc4,
+						   GFP_KERNEL);
+	if (!priv->rx_req_arc4)
+		goto fail;
+
 	return priv;
 
       fail:
 	if (priv) {
+		skcipher_request_free(priv->tx_req_arc4);
+		skcipher_request_free(priv->rx_req_arc4);
 		crypto_free_shash(priv->tx_tfm_michael);
-		crypto_free_cipher(priv->tx_tfm_arc4);
+		crypto_free_skcipher(priv->tx_tfm_arc4);
 		crypto_free_shash(priv->rx_tfm_michael);
-		crypto_free_cipher(priv->rx_tfm_arc4);
+		crypto_free_skcipher(priv->rx_tfm_arc4);
 		kfree(priv);
 	}
 
@@ -141,10 +158,12 @@ static void lib80211_tkip_deinit(void *priv)
 {
 	struct lib80211_tkip_data *_priv = priv;
 	if (_priv) {
+		skcipher_request_free(_priv->tx_req_arc4);
+		skcipher_request_free(_priv->rx_req_arc4);
 		crypto_free_shash(_priv->tx_tfm_michael);
-		crypto_free_cipher(_priv->tx_tfm_arc4);
+		crypto_free_skcipher(_priv->tx_tfm_arc4);
 		crypto_free_shash(_priv->rx_tfm_michael);
-		crypto_free_cipher(_priv->rx_tfm_arc4);
+		crypto_free_skcipher(_priv->rx_tfm_arc4);
 	}
 	kfree(priv);
 }
@@ -342,10 +361,10 @@ static int lib80211_tkip_hdr(struct sk_buff *skb, int hdr_len,
 static int lib80211_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct lib80211_tkip_data *tkey = priv;
+	struct scatterlist sg;
 	int len;
 	u8 rc4key[16], *pos, *icv;
 	u32 crc;
-	int i;
 
 	if (tkey->flags & IEEE80211_CRYPTO_TKIP_COUNTERMEASURES) {
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
@@ -370,10 +389,11 @@ static int lib80211_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	icv[2] = crc >> 16;
 	icv[3] = crc >> 24;
 
-	crypto_cipher_setkey(tkey->tx_tfm_arc4, rc4key, 16);
-	for (i = 0; i < len + 4; i++)
-		crypto_cipher_encrypt_one(tkey->tx_tfm_arc4, pos + i, pos + i);
-	return 0;
+	crypto_skcipher_setkey(tkey->tx_tfm_arc4, rc4key, 16);
+	sg_init_one(&sg, pos, len + 4);
+	skcipher_request_set_crypt(tkey->tx_req_arc4, &sg, &sg, len + 4, NULL);
+
+	return crypto_skcipher_encrypt(tkey->tx_req_arc4);
 }
 
 /*
@@ -392,6 +412,7 @@ static inline int tkip_replay_check(u32 iv32_n, u16 iv16_n,
 static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct lib80211_tkip_data *tkey = priv;
+	struct scatterlist sg;
 	u8 rc4key[16];
 	u8 keyidx, *pos;
 	u32 iv32;
@@ -400,7 +421,6 @@ static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	u8 icv[4];
 	u32 crc;
 	int plen;
-	int i;
 
 	hdr = (struct ieee80211_hdr *)skb->data;
 
@@ -453,9 +473,12 @@ static int lib80211_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 
 	plen = skb->len - hdr_len - 12;
 
-	crypto_cipher_setkey(tkey->rx_tfm_arc4, rc4key, 16);
-	for (i = 0; i < plen + 4; i++)
-		crypto_cipher_decrypt_one(tkey->rx_tfm_arc4, pos + i, pos + i);
+	crypto_skcipher_setkey(tkey->rx_tfm_arc4, rc4key, 16);
+	sg_init_one(&sg, pos, plen + 4);
+	skcipher_request_set_crypt(tkey->rx_req_arc4, &sg, &sg, plen + 4, NULL);
+
+	if (crypto_skcipher_decrypt(tkey->rx_req_arc4))
+		return -7;
 
 	crc = ~crc32_le(~0, pos, plen);
 	icv[0] = crc;
@@ -640,9 +663,9 @@ static int lib80211_tkip_set_key(void *key, int len, u8 * seq, void *priv)
 	struct lib80211_tkip_data *tkey = priv;
 	int keyidx;
 	struct crypto_shash *tfm = tkey->tx_tfm_michael;
-	struct crypto_cipher *tfm2 = tkey->tx_tfm_arc4;
+	struct crypto_skcipher *tfm2 = tkey->tx_tfm_arc4;
 	struct crypto_shash *tfm3 = tkey->rx_tfm_michael;
-	struct crypto_cipher *tfm4 = tkey->rx_tfm_arc4;
+	struct crypto_skcipher *tfm4 = tkey->rx_tfm_arc4;
 
 	keyidx = tkey->key_idx;
 	memset(tkey, 0, sizeof(*tkey));
-- 
2.20.1

