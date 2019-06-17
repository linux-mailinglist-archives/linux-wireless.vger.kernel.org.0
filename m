Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC53A47E25
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 11:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfFQJTN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 05:19:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfFQJTN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 05:19:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so9107349wrl.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2019 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R32x3al6ApAYxWeR2Mh2B22F7hDk53CX1ThFEV+FJ+M=;
        b=nuf2C8J7/jGlpN4QCIJI5KhOcRIUyvppgZBdxuisTeJzwU1opvMglpB3tDZC2DvZrs
         HFpuP6VJ9XsShMjDZQzHLc01koHSKhHokrURSiiEeRRxUP0uo4iZX5CbVOmENZwOCSUj
         C3vAwvakXriTztH/HtVya29RnO/Vpa4xQgL1ju4QfROITi/hZ9FJiPV/bCKXnUJTYGYn
         Lx0z/KtptIeEW6JK6ZpwIGYZKyUKCw5JY6xIEEYS5StEvjF+esxS3knaV8lG+SR0rT49
         BQoRNZWJjOZ7ZgvokGVFyDAKV0WXFP64VoK4IHO0g+AdvRQlIyMgz1LD3aRyiiJ/pZLH
         3MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R32x3al6ApAYxWeR2Mh2B22F7hDk53CX1ThFEV+FJ+M=;
        b=N4zRVaHkkvWPqZudLek79CDdMTl5oolneWW/y1cuxbGMNYDsfFRlVauQG9P8NlO0RR
         C70EfX1F+5jK3z6G580kGEqzOaaZpQ7BPCrobU8jTqzyQxD6EF2O0a4pKyxsXAbeT2bb
         CDELhadue8zqzwk1iamKmlG+InhrOOyrPprZmDz7KoAmPi4HdvFDwgah6f+yCakDRxT8
         I1Q6V/k0KE3P+BGm5kxwF4Mf9W9/bIJqWWuYXoLLoP22bpTaWOD4GgxeRd9KkYRd2Ytt
         NAHlUNab2afztAhGiPjFONNy7E5csM0mmUiAo4VEiZUOoIzqJxsnneqyB6q8I3m3+xRH
         jTUg==
X-Gm-Message-State: APjAAAV+U5TdtmxjQhVwQc7IjUHBZsxkfUW/quOm5UK9cWuPQHxDFZhX
        8ql1oWeZnrfNNZDr8fPGpo/wf9sYa0A7nw==
X-Google-Smtp-Source: APXvYqwXjGm+CvBX9mEfOCMZGmUdplPPV1Deqz1nFMeF2CUUA9AkgZPGIhOxxeGaixTfIaF54cRK9g==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr58660416wrm.68.1560763149522;
        Mon, 17 Jun 2019 02:19:09 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id d4sm1278284wra.38.2019.06.17.02.19.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 02:19:08 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-wireless@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        ebiggers@kernel.org, johannes@sipsolutions.net,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2] lib80211: use crypto API ccm(aes) transform for CCMP processing
Date:   Mon, 17 Jun 2019 11:19:01 +0200
Message-Id: <20190617091901.7063-1-ard.biesheuvel@linaro.org>
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
v2: Address lots of style related issues flagged by Eric. Still untested on
    actual hardware.

 net/wireless/Kconfig               |   2 +
 net/wireless/lib80211_crypt_ccmp.c | 197 +++++++++-----------
 2 files changed, 87 insertions(+), 112 deletions(-)

diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index 6310ddede220..cf8ba192249e 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -216,6 +216,8 @@ config LIB80211_CRYPT_WEP
 
 config LIB80211_CRYPT_CCMP
 	tristate
+	select CRYPTO_AES
+	select CRYPTO_CCM
 
 config LIB80211_CRYPT_TKIP
 	tristate
diff --git a/net/wireless/lib80211_crypt_ccmp.c b/net/wireless/lib80211_crypt_ccmp.c
index 55214fe925b2..7297646c084a 100644
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
 
@@ -97,25 +91,16 @@ static void lib80211_ccmp_deinit(void *priv)
 {
 	struct lib80211_ccmp_data *_priv = priv;
 	if (_priv && _priv->tfm)
-		crypto_free_cipher(_priv->tfm);
+		crypto_free_aead(_priv->tfm);
 	kfree(priv);
 }
 
-static inline void xor_block(u8 * b, u8 * a, size_t len)
-{
-	int i;
-	for (i = 0; i < len; i++)
-		b[i] ^= a[i];
-}
-
-static void ccmp_init_blocks(struct crypto_cipher *tfm,
-			     struct ieee80211_hdr *hdr,
-			     u8 * pn, size_t dlen, u8 * b0, u8 * auth, u8 * s0)
+static int ccmp_init_iv_and_aad(const struct ieee80211_hdr *hdr,
+				const u8 *pn, u8 *iv, u8 *aad)
 {
 	u8 *pos, qc = 0;
 	size_t aad_len;
 	int a4_included, qc_included;
-	u8 aad[2 * AES_BLOCK_LEN];
 
 	a4_included = ieee80211_has_a4(hdr->frame_control);
 	qc_included = ieee80211_is_data_qos(hdr->frame_control);
@@ -131,17 +116,19 @@ static void ccmp_init_blocks(struct crypto_cipher *tfm,
 		aad_len += 2;
 	}
 
-	/* CCM Initial Block:
-	 * Flag (Include authentication header, M=3 (8-octet MIC),
-	 *       L=1 (2-octet Dlen))
-	 * Nonce: 0x00 | A2 | PN
-	 * Dlen */
-	b0[0] = 0x59;
-	b0[1] = qc;
-	memcpy(b0 + 2, hdr->addr2, ETH_ALEN);
-	memcpy(b0 + 8, pn, CCMP_PN_LEN);
-	b0[14] = (dlen >> 8) & 0xff;
-	b0[15] = dlen & 0xff;
+	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
+	 * mode authentication are not allowed to collide, yet both are derived
+	 * from the same vector. We only set L := 1 here to indicate that the
+	 * data size can be represented in (L+1) bytes. The CCM layer will take
+	 * care of storing the data length in the top (L+1) bytes and setting
+	 * and clearing the other bits as is required to derive the two IVs.
+	 */
+	iv[0] = 0x1;
+
+	/* Nonce: QC | A2 | PN */
+	iv[1] = qc;
+	memcpy(iv + 2, hdr->addr2, ETH_ALEN);
+	memcpy(iv + 8, pn, CCMP_PN_LEN);
 
 	/* AAD:
 	 * FC with bits 4..6 and 11..13 masked to zero; 14 is always one
@@ -151,31 +138,20 @@ static void ccmp_init_blocks(struct crypto_cipher *tfm,
 	 * QC (if present)
 	 */
 	pos = (u8 *) hdr;
-	aad[0] = 0;		/* aad_len >> 8 */
-	aad[1] = aad_len & 0xff;
-	aad[2] = pos[0] & 0x8f;
-	aad[3] = pos[1] & 0xc7;
-	memcpy(aad + 4, hdr->addr1, 3 * ETH_ALEN);
+	aad[0] = pos[0] & 0x8f;
+	aad[1] = pos[1] & 0xc7;
+	memcpy(aad + 2, hdr->addr1, 3 * ETH_ALEN);
 	pos = (u8 *) & hdr->seq_ctrl;
-	aad[22] = pos[0] & 0x0f;
-	aad[23] = 0;		/* all bits masked */
-	memset(aad + 24, 0, 8);
+	aad[20] = pos[0] & 0x0f;
+	aad[21] = 0;		/* all bits masked */
+	memset(aad + 22, 0, 8);
 	if (a4_included)
-		memcpy(aad + 24, hdr->addr4, ETH_ALEN);
+		memcpy(aad + 22, hdr->addr4, ETH_ALEN);
 	if (qc_included) {
-		aad[a4_included ? 30 : 24] = qc;
+		aad[a4_included ? 28 : 22] = qc;
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
+	return aad_len;
 }
 
 static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
@@ -218,13 +194,13 @@ static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
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
+	u8 iv[AES_BLOCK_LEN];
+	int len, data_len, aad_len;
+	int ret;
 
 	if (skb_tailroom(skb) < CCMP_MIC_LEN || skb->len < hdr_len)
 		return -1;
@@ -234,31 +210,28 @@ static int lib80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	if (len < 0)
 		return -1;
 
-	pos = skb->data + hdr_len + CCMP_HDR_LEN;
+	req = aead_request_alloc(key->tfm, GFP_ATOMIC);
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
+	aad_len = ccmp_init_iv_and_aad(hdr, key->tx_pn, iv, aad);
 
-	mic = skb_put(skb, CCMP_MIC_LEN);
-	for (i = 0; i < CCMP_MIC_LEN; i++)
-		mic[i] = b[i] ^ s0[i];
+	skb_put(skb, CCMP_MIC_LEN);
 
-	return 0;
+	sg_init_table(sg, 2);
+	sg_set_buf(&sg[0], aad, aad_len);
+	sg_set_buf(&sg[1], skb->data + hdr_len + CCMP_HDR_LEN,
+		   data_len + CCMP_MIC_LEN);
+
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_ad(req, aad_len);
+	aead_request_set_crypt(req, sg, sg, data_len, iv);
+
+	ret = crypto_aead_encrypt(req);
+	aead_request_free(req);
+
+	return ret;
 }
 
 /*
@@ -287,13 +260,13 @@ static int lib80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	struct lib80211_ccmp_data *key = priv;
 	u8 keyidx, *pos;
 	struct ieee80211_hdr *hdr;
-	u8 *b0 = key->rx_b0;
-	u8 *b = key->rx_b;
-	u8 *a = key->rx_a;
+	struct aead_request *req;
+	struct scatterlist sg[2];
+	u8 *aad = key->rx_aad;
+	u8 iv[AES_BLOCK_LEN];
 	u8 pn[6];
-	int i, blocks, last, len;
-	size_t data_len = skb->len - hdr_len - CCMP_HDR_LEN - CCMP_MIC_LEN;
-	u8 *mic = skb->data + skb->len - CCMP_MIC_LEN;
+	int aad_len, ret;
+	size_t data_len = skb->len - hdr_len - CCMP_HDR_LEN;
 
 	if (skb->len < hdr_len + CCMP_HDR_LEN + CCMP_MIC_LEN) {
 		key->dot11RSNAStatsCCMPFormatErrors++;
@@ -341,28 +314,26 @@ static int lib80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
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
+	req = aead_request_alloc(key->tfm, GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
 
-	if (memcmp(mic, a, CCMP_MIC_LEN) != 0) {
-		net_dbg_ratelimited("CCMP: decrypt failed: STA=%pM\n",
-				    hdr->addr2);
+	aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);
+
+	sg_init_table(sg, 2);
+	sg_set_buf(&sg[0], aad, aad_len);
+	sg_set_buf(&sg[1], pos, data_len);
+
+	aead_request_set_callback(req, 0, NULL, NULL);
+	aead_request_set_ad(req, aad_len);
+	aead_request_set_crypt(req, sg, sg, data_len, iv);
+
+	ret = crypto_aead_decrypt(req);
+	aead_request_free(req);
+
+	if (ret) {
+		net_dbg_ratelimited("CCMP: decrypt failed: STA=%pM (%d)\n",
+				    hdr->addr2, ret);
 		key->dot11RSNAStatsCCMPDecryptErrors++;
 		return -5;
 	}
@@ -381,7 +352,7 @@ static int lib80211_ccmp_set_key(void *key, int len, u8 * seq, void *priv)
 {
 	struct lib80211_ccmp_data *data = priv;
 	int keyidx;
-	struct crypto_cipher *tfm = data->tfm;
+	struct crypto_aead *tfm = data->tfm;
 
 	keyidx = data->key_idx;
 	memset(data, 0, sizeof(*data));
@@ -398,7 +369,9 @@ static int lib80211_ccmp_set_key(void *key, int len, u8 * seq, void *priv)
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

