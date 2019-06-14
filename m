Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB715458A5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 11:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFNJ3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 05:29:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51075 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFNJ3a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 05:29:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so1599751wmf.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Reb/CF6TRkBPh/xi/LMm8iS4C5a7CsOnYgOf4v6eLM8=;
        b=GC2duFe3eC8UGc1EBxcoBJqTPFPSrQXXMfn2d9lv3Oz09s9R8tMDjNFZn8XBjNkYSy
         4oHO/mAE1IG4eAxuVHqc8LkKKiM/MacGcpBE4QzOtZdFZ55K+PeSdGcQY7tKlBkrLDoy
         QkLt88z2IqAocr5AOpT6OX92cotl/8BZre4biXZmKrUyNV4pyeX7W5gFOUycgUB2L+QU
         gu/cg/ZUhD8oH6OjGG0NWdm92TSd1vURrJssbNK9fVZkvedd9trImLjxQI0YtXtrenI1
         8XIjHmllpacyS9Kr/5vaFXow5eSu4C9dvM4a6yOFJThTPqfzkAcj420wBkqjnzCvra7t
         cY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Reb/CF6TRkBPh/xi/LMm8iS4C5a7CsOnYgOf4v6eLM8=;
        b=SFOiaZKBzH3nUjd9ItdAlw4mjrlGbB9XiSf/TCC3pEV4fv/2aymF8P6EStqx4JFkaQ
         zbuZbx6dI7juXYYTE1XB3bzAkZyanavrmNV7IO7D/hE795BgRYK66uVwzB1QAqqU2Xf6
         lZiYwDxYz+N5l0jnrbK0OdCP/VVytBlAaZFwCU0U6LId5uDVTHantipxtgUHEDW9DlM/
         pt45c7Ku4Tj/Eqe7rf2v/6+cubMthUvpGW2caaeN22g4HrnpCFKDc+3PsSmurXDOHblw
         +YM68XPlNHpEJ46mn2fICIZURr5d0SRCjt3qm0sIN8//XQISZcZjCVnThhKGBfd1IfnG
         TkCA==
X-Gm-Message-State: APjAAAVRDk11FoY04hqseCftWGgIHF/5iJDunznh0zfotZEi8MX66oK6
        K5iy+QCPKYqHCW3R46ArPtFjGd+zmHc/BA==
X-Google-Smtp-Source: APXvYqy/ndpMNQ328GpMi7LU7Ovh4FzmAp+nfDeFRKsP1GWv2MHnBS+AFowk8QHjqseJ6WBJsJb4kw==
X-Received: by 2002:a1c:9813:: with SMTP id a19mr6907226wme.11.1560504566318;
        Fri, 14 Jun 2019 02:29:26 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:8d0e:a5b1:c005:e3b5])
        by smtp.gmail.com with ESMTPSA id y18sm2619040wmd.29.2019.06.14.02.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 02:29:25 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, herbert@gondor.apana.org.au,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] lib80211: use crypto API ccm(aes) transform for CCMP processing
Date:   Fri, 14 Jun 2019 11:29:22 +0200
Message-Id: <20190614092922.22517-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of open coding the CCM aead mode in the driver, and invoking
the AES block cipher block by block, use a ccm(aes) aead transform
which already encapsulates this functionality. This is a cleaner use
of the crypto API, and permits optimized implementations to be used,
which are typically much faster and deal more efficiently with the
SIMD register file, which usually needs to be preserved/restored in
order to use special AES instructions.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
NOTE: build tested only, since I don't have the hardware

Two other instances of this code exist in staging/. I should be able to
find someone who is willing to apply the same changes there, as a training
exercise (once we confirm that it works as expected)

 net/wireless/Kconfig               |   2 +
 net/wireless/lib80211_crypt_ccmp.c | 165 +++++++++-----------
 2 files changed, 76 insertions(+), 91 deletions(-)

diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index 578cce4fbe6c..5e3183c6cbd6 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -217,6 +217,8 @@ config LIB80211_CRYPT_WEP
 
 config LIB80211_CRYPT_CCMP
 	tristate
+	select CRYPTO_AES
+	select CRYPTO_CCM
 
 config LIB80211_CRYPT_TKIP
 	tristate
diff --git a/net/wireless/lib80211_crypt_ccmp.c b/net/wireless/lib80211_crypt_ccmp.c
index 55214fe925b2..568fc02381e5 100644
--- a/net/wireless/lib80211_crypt_ccmp.c
+++ b/net/wireless/lib80211_crypt_ccmp.c
@@ -26,6 +26,7 @@
 #include <linux/ieee80211.h>
 
 #include <linux/crypto.h>
+#include <crypto/aead.h>
 
 #include <net/lib80211.h>
 
@@ -52,20 +53,13 @@ struct lib80211_ccmp_data {
 
 	int key_idx;
 
-	struct crypto_cipher *tfm;
+	struct crypto_aead *tfm;
 
 	/* scratch buffers for virt_to_page() (crypto API) */
-	u8 tx_b0[AES_BLOCK_LEN], tx_b[AES_BLOCK_LEN],
-	    tx_e[AES_BLOCK_LEN], tx_s0[AES_BLOCK_LEN];
-	u8 rx_b0[AES_BLOCK_LEN], rx_b[AES_BLOCK_LEN], rx_a[AES_BLOCK_LEN];
+	u8 tx_aad[2 * AES_BLOCK_LEN];
+	u8 rx_aad[2 * AES_BLOCK_LEN];
 };
 
-static inline void lib80211_ccmp_aes_encrypt(struct crypto_cipher *tfm,
-					      const u8 pt[16], u8 ct[16])
-{
-	crypto_cipher_encrypt_one(tfm, ct, pt);
-}
-
 static void *lib80211_ccmp_init(int key_idx)
 {
 	struct lib80211_ccmp_data *priv;
@@ -75,7 +69,7 @@ static void *lib80211_ccmp_init(int key_idx)
 		goto fail;
 	priv->key_idx = key_idx;
 
-	priv->tfm = crypto_alloc_cipher("aes", 0, 0);
+	priv->tfm = crypto_alloc_aead("ccm(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(priv->tfm)) {
 		priv->tfm = NULL;
 		goto fail;
@@ -86,7 +80,7 @@ static void *lib80211_ccmp_init(int key_idx)
       fail:
 	if (priv) {
 		if (priv->tfm)
-			crypto_free_cipher(priv->tfm);
+			crypto_free_aead(priv->tfm);
 		kfree(priv);
 	}
 
@@ -97,7 +91,7 @@ static void lib80211_ccmp_deinit(void *priv)
 {
 	struct lib80211_ccmp_data *_priv = priv;
 	if (_priv && _priv->tfm)
-		crypto_free_cipher(_priv->tfm);
+		crypto_free_aead(_priv->tfm);
 	kfree(priv);
 }
 
@@ -108,14 +102,12 @@ static inline void xor_block(u8 * b, u8 * a, size_t len)
 		b[i] ^= a[i];
 }
 
-static void ccmp_init_blocks(struct crypto_cipher *tfm,
-			     struct ieee80211_hdr *hdr,
-			     u8 * pn, size_t dlen, u8 * b0, u8 * auth, u8 * s0)
+static void ccmp_init_blocks(struct ieee80211_hdr *hdr,
+			     u8 * pn, size_t dlen, u8 * b0, u8 * aad)
 {
 	u8 *pos, qc = 0;
 	size_t aad_len;
 	int a4_included, qc_included;
-	u8 aad[2 * AES_BLOCK_LEN];
 
 	a4_included = ieee80211_has_a4(hdr->frame_control);
 	qc_included = ieee80211_is_data_qos(hdr->frame_control);
@@ -131,17 +123,19 @@ static void ccmp_init_blocks(struct crypto_cipher *tfm,
 		aad_len += 2;
 	}
 
-	/* CCM Initial Block:
-	 * Flag (Include authentication header, M=3 (8-octet MIC),
-	 *       L=1 (2-octet Dlen))
-	 * Nonce: 0x00 | A2 | PN
-	 * Dlen */
-	b0[0] = 0x59;
+	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
+	 * mode authentication are not allowed to collide, yet both are derived
+	 * from this vector b0. We only set L := 1 here to indicate that the
+	 * data size can be represented in (L+1) bytes. The CCM layer will take
+	 * care of storing the data length in the top (L+1) bytes and setting
+	 * and clearing the other bits as is required to derive the two IVs.
+	 */
+	b0[0] = 0x1;
+
+	/* Nonce: QC | A2 | PN */
 	b0[1] = qc;
 	memcpy(b0 + 2, hdr->addr2, ETH_ALEN);
 	memcpy(b0 + 8, pn, CCMP_PN_LEN);
-	b0[14] = (dlen >> 8) & 0xff;
-	b0[15] = dlen & 0xff;
 
 	/* AAD:
 	 * FC with bits 4..6 and 11..13 masked to zero; 14 is always one
@@ -166,16 +160,6 @@ static void ccmp_init_blocks(struct crypto_cipher *tfm,
 		aad[a4_included ? 30 : 24] = qc;
 		/* rest of QC masked */
 	}
-
-	/* Start with the first block and AAD */
-	lib80211_ccmp_aes_encrypt(tfm, b0, auth);
-	xor_block(auth, aad, AES_BLOCK_LEN);
-	lib80211_ccmp_aes_encrypt(tfm, auth, auth);
-	xor_block(auth, &aad[AES_BLOCK_LEN], AES_BLOCK_LEN);
-	lib80211_ccmp_aes_encrypt(tfm, auth, auth);
-	b0[0] &= 0x07;
-	b0[14] = b0[15] = 0;
-	lib80211_ccmp_aes_encrypt(tfm, b0, s0);
 }
 
 static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
@@ -218,13 +202,13 @@ static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
 static int lib80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct lib80211_ccmp_data *key = priv;
-	int data_len, i, blocks, last, len;
-	u8 *pos, *mic;
 	struct ieee80211_hdr *hdr;
-	u8 *b0 = key->tx_b0;
-	u8 *b = key->tx_b;
-	u8 *e = key->tx_e;
-	u8 *s0 = key->tx_s0;
+	struct aead_request *req;
+	struct scatterlist sg[2];
+	u8 *aad = key->tx_aad;
+	u8 b0[AES_BLOCK_LEN];
+	int len, data_len;
+	int ret;
 
 	if (skb_tailroom(skb) < CCMP_MIC_LEN || skb->len < hdr_len)
 		return -1;
@@ -234,31 +218,29 @@ static int lib80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	if (len < 0)
 		return -1;
 
-	pos = skb->data + hdr_len + CCMP_HDR_LEN;
+	req = kzalloc(sizeof(*req) + crypto_aead_reqsize(key->tfm), GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
+
 	hdr = (struct ieee80211_hdr *)skb->data;
-	ccmp_init_blocks(key->tfm, hdr, key->tx_pn, data_len, b0, b, s0);
-
-	blocks = DIV_ROUND_UP(data_len, AES_BLOCK_LEN);
-	last = data_len % AES_BLOCK_LEN;
-
-	for (i = 1; i <= blocks; i++) {
-		len = (i == blocks && last) ? last : AES_BLOCK_LEN;
-		/* Authentication */
-		xor_block(b, pos, len);
-		lib80211_ccmp_aes_encrypt(key->tfm, b, b);
-		/* Encryption, with counter */
-		b0[14] = (i >> 8) & 0xff;
-		b0[15] = i & 0xff;
-		lib80211_ccmp_aes_encrypt(key->tfm, b0, e);
-		xor_block(pos, e, len);
-		pos += len;
-	}
+	ccmp_init_blocks(hdr, key->tx_pn, data_len, b0, aad);
 
-	mic = skb_put(skb, CCMP_MIC_LEN);
-	for (i = 0; i < CCMP_MIC_LEN; i++)
-		mic[i] = b[i] ^ s0[i];
+	skb_put(skb, CCMP_MIC_LEN);
 
-	return 0;
+	sg_init_table(sg, 2);
+	sg_set_buf(&sg[0], aad + 2, be16_to_cpup((__be16 *)aad));
+	sg_set_buf(&sg[1], skb->data + hdr_len + CCMP_HDR_LEN,
+		   data_len + CCMP_MIC_LEN);
+
+	aead_request_set_tfm(req, key->tfm);
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_ad(req, sg[0].length);
+	aead_request_set_crypt(req, sg, sg, data_len, b0);
+
+	ret = crypto_aead_encrypt(req);
+	kzfree(req);
+
+	return ret;
 }
 
 /*
@@ -287,13 +269,13 @@ static int lib80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	struct lib80211_ccmp_data *key = priv;
 	u8 keyidx, *pos;
 	struct ieee80211_hdr *hdr;
-	u8 *b0 = key->rx_b0;
-	u8 *b = key->rx_b;
-	u8 *a = key->rx_a;
+	struct aead_request *req;
+	struct scatterlist sg[2];
+	u8 *aad = key->rx_aad;
+	u8 b0[AES_BLOCK_LEN];
 	u8 pn[6];
-	int i, blocks, last, len;
+	int ret;
 	size_t data_len = skb->len - hdr_len - CCMP_HDR_LEN - CCMP_MIC_LEN;
-	u8 *mic = skb->data + skb->len - CCMP_MIC_LEN;
 
 	if (skb->len < hdr_len + CCMP_HDR_LEN + CCMP_MIC_LEN) {
 		key->dot11RSNAStatsCCMPFormatErrors++;
@@ -341,28 +323,27 @@ static int lib80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		return -4;
 	}
 
-	ccmp_init_blocks(key->tfm, hdr, pn, data_len, b0, a, b);
-	xor_block(mic, b, CCMP_MIC_LEN);
-
-	blocks = DIV_ROUND_UP(data_len, AES_BLOCK_LEN);
-	last = data_len % AES_BLOCK_LEN;
-
-	for (i = 1; i <= blocks; i++) {
-		len = (i == blocks && last) ? last : AES_BLOCK_LEN;
-		/* Decrypt, with counter */
-		b0[14] = (i >> 8) & 0xff;
-		b0[15] = i & 0xff;
-		lib80211_ccmp_aes_encrypt(key->tfm, b0, b);
-		xor_block(pos, b, len);
-		/* Authentication */
-		xor_block(a, pos, len);
-		lib80211_ccmp_aes_encrypt(key->tfm, a, a);
-		pos += len;
-	}
+	req = kzalloc(sizeof(*req) + crypto_aead_reqsize(key->tfm), GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
 
-	if (memcmp(mic, a, CCMP_MIC_LEN) != 0) {
-		net_dbg_ratelimited("CCMP: decrypt failed: STA=%pM\n",
-				    hdr->addr2);
+	ccmp_init_blocks(hdr, pn, data_len, b0, aad);
+
+	sg_init_table(sg, 2);
+	sg_set_buf(&sg[0], aad + 2, be16_to_cpup((__be16 *)aad));
+	sg_set_buf(&sg[1], pos, data_len + CCMP_MIC_LEN);
+
+	aead_request_set_tfm(req, key->tfm);
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_ad(req, sg[0].length);
+	aead_request_set_crypt(req, sg, sg, data_len + CCMP_MIC_LEN, b0);
+
+	ret = crypto_aead_decrypt(req);
+	kzfree(req);
+
+	if (ret) {
+		net_dbg_ratelimited("CCMP: decrypt failed: STA=%pM (%d)\n",
+				    hdr->addr2, ret);
 		key->dot11RSNAStatsCCMPDecryptErrors++;
 		return -5;
 	}
@@ -381,7 +362,7 @@ static int lib80211_ccmp_set_key(void *key, int len, u8 * seq, void *priv)
 {
 	struct lib80211_ccmp_data *data = priv;
 	int keyidx;
-	struct crypto_cipher *tfm = data->tfm;
+	struct crypto_aead *tfm = data->tfm;
 
 	keyidx = data->key_idx;
 	memset(data, 0, sizeof(*data));
@@ -398,7 +379,9 @@ static int lib80211_ccmp_set_key(void *key, int len, u8 * seq, void *priv)
 			data->rx_pn[4] = seq[1];
 			data->rx_pn[5] = seq[0];
 		}
-		crypto_cipher_setkey(data->tfm, data->key, CCMP_TK_LEN);
+		if (crypto_aead_setauthsize(data->tfm, CCMP_MIC_LEN) ||
+		    crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
+			return -1;
 	} else if (len == 0)
 		data->key_set = 0;
 	else
-- 
2.20.1

