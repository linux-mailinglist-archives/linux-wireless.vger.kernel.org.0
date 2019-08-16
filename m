Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64D8FBCD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 09:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfHPHLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 03:11:08 -0400
Received: from mail.someserver.de ([31.15.66.35]:54055 "EHLO
        mail.someserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfHPHLI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 03:11:08 -0400
Received: from localhost (87-231-101-12.rev.numericable.fr [87.231.101.12])
        by mail.someserver.de (Postfix) with ESMTPSA id 244E8121549;
        Fri, 16 Aug 2019 09:00:48 +0200 (CEST)
From:   Christina Quast <contact@christina-quast.de>
To:     ard.biesheuvel@linaro.org
Cc:     Christina Quast <contact@christina-quast.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Anushka Shukla <anushkacharu9@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zach Turner <turnerzdp@gmail.com>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192u: ieee80211: ieee80211_crypt_ccmp.c: Use crypto API ccm(aes)
Date:   Fri, 16 Aug 2019 08:59:35 +0200
Message-Id: <20190816065936.12214-2-contact@christina-quast.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816065936.12214-1-contact@christina-quast.de>
References: <20190816065936.12214-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use ccm(aes) aead transform instead of invoking the AES block cipher
block by block.

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
 drivers/staging/rtl8192u/Kconfig              |   2 +
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 187 ++++++++----------
 2 files changed, 81 insertions(+), 108 deletions(-)

diff --git a/drivers/staging/rtl8192u/Kconfig b/drivers/staging/rtl8192u/Kconfig
index 22c2165e8b1c..1edca5c304fb 100644
--- a/drivers/staging/rtl8192u/Kconfig
+++ b/drivers/staging/rtl8192u/Kconfig
@@ -6,3 +6,5 @@ config RTL8192U
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select CRYPTO
+	select CRYPTO_AES
+	select CRYPTO_CCM
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index d7188b3f3190..aecee42be95e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -19,6 +19,7 @@
 #include "ieee80211.h"
 
 #include <linux/crypto.h>
+#include <crypto/aead.h>
     #include <linux/scatterlist.h>
 
 MODULE_AUTHOR("Jouni Malinen");
@@ -44,20 +45,13 @@ struct ieee80211_ccmp_data {
 
 	int key_idx;
 
-	struct crypto_tfm *tfm;
+	struct crypto_aead *tfm;
 
 	/* scratch buffers for virt_to_page() (crypto API) */
-	u8 tx_b0[AES_BLOCK_LEN], tx_b[AES_BLOCK_LEN],
-		tx_e[AES_BLOCK_LEN], tx_s0[AES_BLOCK_LEN];
-	u8 rx_b0[AES_BLOCK_LEN], rx_b[AES_BLOCK_LEN], rx_a[AES_BLOCK_LEN];
+	u8 tx_aad[2 * AES_BLOCK_LEN];
+	u8 rx_aad[2 * AES_BLOCK_LEN];
 };
 
-static void ieee80211_ccmp_aes_encrypt(struct crypto_tfm *tfm,
-			     const u8 pt[16], u8 ct[16])
-{
-	crypto_cipher_encrypt_one((void *)tfm, ct, pt);
-}
-
 static void *ieee80211_ccmp_init(int key_idx)
 {
 	struct ieee80211_ccmp_data *priv;
@@ -67,7 +61,7 @@ static void *ieee80211_ccmp_init(int key_idx)
 		goto fail;
 	priv->key_idx = key_idx;
 
-	priv->tfm = (void *)crypto_alloc_cipher("aes", 0, 0);
+	priv->tfm = crypto_alloc_aead("ccm(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(priv->tfm)) {
 		pr_debug("ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
 		priv->tfm = NULL;
@@ -79,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
 fail:
 	if (priv) {
 		if (priv->tfm)
-			crypto_free_cipher((void *)priv->tfm);
+			crypto_free_aead(priv->tfm);
 		kfree(priv);
 	}
 
@@ -91,28 +85,17 @@ static void ieee80211_ccmp_deinit(void *priv)
 	struct ieee80211_ccmp_data *_priv = priv;
 
 	if (_priv && _priv->tfm)
-		crypto_free_cipher((void *)_priv->tfm);
+		crypto_free_aead(_priv->tfm);
 	kfree(priv);
 }
 
-static inline void xor_block(u8 *b, u8 *a, size_t len)
-{
-	int i;
-
-	for (i = 0; i < len; i++)
-		b[i] ^= a[i];
-}
-
-static void ccmp_init_blocks(struct crypto_tfm *tfm,
-			     struct rtl_80211_hdr_4addr *hdr,
-			     u8 *pn, size_t dlen, u8 *b0, u8 *auth,
-			     u8 *s0)
+static int ccmp_init_iv_and_aad(struct rtl_80211_hdr_4addr *hdr,
+			     u8 *pn, u8 *iv, u8 *aad)
 {
 	u8 *pos, qc = 0;
 	size_t aad_len;
 	u16 fc;
 	int a4_included, qc_included;
-	u8 aad[2 * AES_BLOCK_LEN];
 
 	fc = le16_to_cpu(hdr->frame_ctl);
 	a4_included = ((fc & (IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS)) ==
@@ -133,18 +116,20 @@ static void ccmp_init_blocks(struct crypto_tfm *tfm,
 		qc = *pos & 0x0f;
 		aad_len += 2;
 	}
-	/* CCM Initial Block:
-	 * Flag (Include authentication header, M=3 (8-octet MIC),
-	 *       L=1 (2-octet Dlen))
-	 * Nonce: 0x00 | A2 | PN
-	 * Dlen
+
+	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
+	 * mode authentication are not allowed to collide, yet both are derived
+	 * from the same vector. We only set L := 1 here to indicate that the
+	 * data size can be represented in (L+1) bytes. The CCM layer will take
+	 * care of storing the data length in the top (L+1) bytes and setting
+	 * and clearing the other bits as is required to derive the two IVs.
 	 */
-	b0[0] = 0x59;
-	b0[1] = qc;
-	memcpy(b0 + 2, hdr->addr2, ETH_ALEN);
-	memcpy(b0 + 8, pn, CCMP_PN_LEN);
-	b0[14] = (dlen >> 8) & 0xff;
-	b0[15] = dlen & 0xff;
+	iv[0] = 0x1;
+
+	/* Nonce: QC | A2 | PN */
+	iv[1] = qc;
+	memcpy(iv + 2, hdr->addr2, ETH_ALEN);
+	memcpy(iv + 8, pn, CCMP_PN_LEN);
 
 	/* AAD:
 	 * FC with bits 4..6 and 11..13 masked to zero; 14 is always one
@@ -154,32 +139,21 @@ static void ccmp_init_blocks(struct crypto_tfm *tfm,
 	 * QC (if present)
 	 */
 	pos = (u8 *)hdr;
-	aad[0] = 0; /* aad_len >> 8 */
-	aad[1] = aad_len & 0xff;
-	aad[2] = pos[0] & 0x8f;
-	aad[3] = pos[1] & 0xc7;
-	memcpy(aad + 4, hdr->addr1, 3 * ETH_ALEN);
+	aad[0] = pos[0] & 0x8f;
+	aad[1] = pos[1] & 0xc7;
+	memcpy(aad + 2, hdr->addr1, 3 * ETH_ALEN);
 	pos = (u8 *)&hdr->seq_ctl;
-	aad[22] = pos[0] & 0x0f;
-	aad[23] = 0; /* all bits masked */
-	memset(aad + 24, 0, 8);
+	aad[20] = pos[0] & 0x0f;
+	aad[21] = 0; /* all bits masked */
+	memset(aad + 22, 0, 8);
 	if (a4_included)
-		memcpy(aad + 24, hdr->addr4, ETH_ALEN);
+		memcpy(aad + 22, hdr->addr4, ETH_ALEN);
 	if (qc_included) {
-		aad[a4_included ? 30 : 24] = qc;
+		aad[a4_included ? 28 : 22] = qc;
 		/* rest of QC masked */
 	}
 
-	/* Start with the first block and AAD */
-	ieee80211_ccmp_aes_encrypt(tfm, b0, auth);
-	xor_block(auth, aad, AES_BLOCK_LEN);
-	ieee80211_ccmp_aes_encrypt(tfm, auth, auth);
-	xor_block(auth, &aad[AES_BLOCK_LEN], AES_BLOCK_LEN);
-	ieee80211_ccmp_aes_encrypt(tfm, auth, auth);
-	b0[0] &= 0x07;
-	b0[14] = 0;
-	b0[15] = 0;
-	ieee80211_ccmp_aes_encrypt(tfm, b0, s0);
+	return aad_len;
 }
 
 static int ieee80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
@@ -220,36 +194,34 @@ static int ieee80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 
 	hdr = (struct rtl_80211_hdr_4addr *)skb->data;
 	if (!tcb_desc->bHwSec) {
-		int blocks, last, len;
-		u8 *mic;
-		u8 *b0 = key->tx_b0;
-		u8 *b = key->tx_b;
-		u8 *e = key->tx_e;
-		u8 *s0 = key->tx_s0;
+		struct aead_request *req;
+		struct scatterlist sg[2];
+		u8 *aad = key->tx_aad;
+		u8 iv[AES_BLOCK_LEN];
+		int aad_len, ret;
+		size_t data_len = skb->len - hdr_len - CCMP_HDR_LEN;
 
-		/* mic is moved to here by john */
-		mic = skb_put(skb, CCMP_MIC_LEN);
+		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
+		if (!req)
+			return -ENOMEM;
 
-		ccmp_init_blocks(key->tfm, hdr, key->tx_pn, data_len, b0, b, s0);
+		aad_len = ccmp_init_iv_and_aad(hdr, key->tx_pn, iv, aad);
 
-		blocks = DIV_ROUND_UP(data_len, AES_BLOCK_LEN);
-		last = data_len % AES_BLOCK_LEN;
+		skb_put(skb, CCMP_MIC_LEN);
 
-		for (i = 1; i <= blocks; i++) {
-			len = (i == blocks && last) ? last : AES_BLOCK_LEN;
-			/* Authentication */
-			xor_block(b, pos, len);
-			ieee80211_ccmp_aes_encrypt(key->tfm, b, b);
-			/* Encryption, with counter */
-			b0[14] = (i >> 8) & 0xff;
-			b0[15] = i & 0xff;
-			ieee80211_ccmp_aes_encrypt(key->tfm, b0, e);
-			xor_block(pos, e, len);
-			pos += len;
-		}
+		sg_init_table(sg, 2);
+		sg_set_buf(&sg[0], aad, aad_len);
+		sg_set_buf(&sg[1], skb->data + hdr_len + CCMP_HDR_LEN,
+			   data_len + CCMP_MIC_LEN);
 
-		for (i = 0; i < CCMP_MIC_LEN; i++)
-			mic[i] = b[i] ^ s0[i];
+		aead_request_set_callback(req, 0, NULL, NULL);
+		aead_request_set_ad(req, aad_len);
+		aead_request_set_crypt(req, sg, sg, data_len, iv);
+
+		ret = crypto_aead_encrypt(req);
+		aead_request_free(req);
+
+		return ret;
 	}
 	return 0;
 }
@@ -309,33 +281,31 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		return -4;
 	}
 	if (!tcb_desc->bHwSec) {
-		size_t data_len = skb->len - hdr_len - CCMP_HDR_LEN - CCMP_MIC_LEN;
-		u8 *mic = skb->data + skb->len - CCMP_MIC_LEN;
-		u8 *b0 = key->rx_b0;
-		u8 *b = key->rx_b;
-		u8 *a = key->rx_a;
-		int i, blocks, last, len;
+		struct aead_request *req;
+		struct scatterlist sg[2];
+		u8 *aad = key->rx_aad;
+		u8 iv[AES_BLOCK_LEN];
+		int aad_len, ret;
+		size_t data_len = skb->len - hdr_len - CCMP_HDR_LEN;
 
-		ccmp_init_blocks(key->tfm, hdr, pn, data_len, b0, a, b);
-		xor_block(mic, b, CCMP_MIC_LEN);
+		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
+		if (!req)
+			return -ENOMEM;
 
-		blocks = DIV_ROUND_UP(data_len, AES_BLOCK_LEN);
-		last = data_len % AES_BLOCK_LEN;
+		aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);
 
-		for (i = 1; i <= blocks; i++) {
-			len = (i == blocks && last) ? last : AES_BLOCK_LEN;
-			/* Decrypt, with counter */
-			b0[14] = (i >> 8) & 0xff;
-			b0[15] = i & 0xff;
-			ieee80211_ccmp_aes_encrypt(key->tfm, b0, b);
-			xor_block(pos, b, len);
-			/* Authentication */
-			xor_block(a, pos, len);
-			ieee80211_ccmp_aes_encrypt(key->tfm, a, a);
-			pos += len;
-		}
+		sg_init_table(sg, 2);
+		sg_set_buf(&sg[0], aad, aad_len);
+		sg_set_buf(&sg[1], pos, data_len);
 
-		if (memcmp(mic, a, CCMP_MIC_LEN) != 0) {
+		aead_request_set_callback(req, 0, NULL, NULL);
+		aead_request_set_ad(req, aad_len);
+		aead_request_set_crypt(req, sg, sg, data_len, iv);
+
+		ret = crypto_aead_decrypt(req);
+		aead_request_free(req);
+
+		if (ret) {
 			if (net_ratelimit()) {
 				netdev_dbg(skb->dev, "CCMP: decrypt failed: STA=%pM\n",
 					   hdr->addr2);
@@ -358,12 +328,11 @@ static int ieee80211_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct ieee80211_ccmp_data *data = priv;
 	int keyidx;
-	struct crypto_tfm *tfm = data->tfm;
+	struct crypto_aead *tfm = data->tfm;
 
 	keyidx = data->key_idx;
 	memset(data, 0, sizeof(*data));
 	data->key_idx = keyidx;
-	data->tfm = tfm;
 	if (len == CCMP_TK_LEN) {
 		memcpy(data->key, key, CCMP_TK_LEN);
 		data->key_set = 1;
@@ -375,7 +344,9 @@ static int ieee80211_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 			data->rx_pn[4] = seq[1];
 			data->rx_pn[5] = seq[0];
 		}
-		crypto_cipher_setkey((void *)data->tfm, data->key, CCMP_TK_LEN);
+		if (crypto_aead_setauthsize(tfm, CCMP_MIC_LEN) ||
+		    crypto_aead_setkey(tfm, data->key, CCMP_TK_LEN))
+				return -1;
 	} else if (len == 0) {
 		data->key_set = 0;
 	} else {
-- 
2.20.1

