Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC93AAD34
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFQHUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:20:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54661 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229897AbhFQHUE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:20:04 -0400
X-UUID: cea92f1680d1431a8264cd3dda4e786a-20210617
X-UUID: cea92f1680d1431a8264cd3dda4e786a-20210617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2081792022; Thu, 17 Jun 2021 15:17:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 15:17:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 15:17:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>
Subject: [PATCH v3] mt76: fix iv and CCMP header insertion
Date:   Thu, 17 Jun 2021 15:17:49 +0800
Message-ID: <2e938041399b47ae04c6c339c6cd5cdb7786ee6b.1623912317.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The iv from RXD is only for TKIP_RSC/CCMP_PN/GCMP_PN, and it needs a
check for CCMP header insertion. Move mt76_cipher_type to mt76.h to
reduce duplicated code.

Signed-off-by: Xing Song <xing.song@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v3: fix warning: comparison between 'enum mt76x02_cipher_type' and 'enum mt76_cipher_
v2: Move mt76_cipher_type to mt76.h to reduce duplicated code
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 16 +++++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 33 +++++++---
 .../net/wireless/mediatek/mt76/mt7603/regs.h  | 12 ----
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 64 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 42 ------------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 28 ++++----
 .../net/wireless/mediatek/mt76/mt76x02_regs.h | 18 +++---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 ++++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 30 ++++-----
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 23 ++++---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 29 ++++++---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 30 ++++-----
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 23 ++++---
 13 files changed, 208 insertions(+), 169 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 971195c5ca95..c7085d6cdcc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -87,6 +87,22 @@ enum mt76_rxq_id {
 	__MT_RXQ_MAX
 };
 
+enum mt76_cipher_type {
+	MT_CIPHER_NONE,
+	MT_CIPHER_WEP40,
+	MT_CIPHER_TKIP,
+	MT_CIPHER_TKIP_NO_MIC,
+	MT_CIPHER_AES_CCMP,
+	MT_CIPHER_WEP104,
+	MT_CIPHER_BIP_CMAC_128,
+	MT_CIPHER_WEP128,
+	MT_CIPHER_WAPI,
+	MT_CIPHER_CCMP_CCX,
+	MT_CIPHER_CCMP_256,
+	MT_CIPHER_GCMP,
+	MT_CIPHER_GCMP_256,
+};
+
 struct mt76_queue_buf {
 	dma_addr_t addr;
 	u16 len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8435e9597688..3972c56136a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -550,14 +550,27 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 
 		rxd += 4;
@@ -831,7 +844,7 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
 	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 }
 
-static enum mt7603_cipher_type
+static enum mt76_cipher_type
 mt7603_mac_get_key_info(struct ieee80211_key_conf *key, u8 *key_data)
 {
 	memset(key_data, 0, 32);
@@ -863,7 +876,7 @@ mt7603_mac_get_key_info(struct ieee80211_key_conf *key, u8 *key_data)
 int mt7603_wtbl_set_key(struct mt7603_dev *dev, int wcid,
 			struct ieee80211_key_conf *key)
 {
-	enum mt7603_cipher_type cipher;
+	enum mt76_cipher_type cipher;
 	u32 addr = mt7603_wtbl3_addr(wcid);
 	u8 key_data[32];
 	int key_len = sizeof(key_data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index 6741e6907194..3b901090b29c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -765,16 +765,4 @@ enum {
 #define MT_WTBL1_OR			(MT_WTBL1_BASE + 0x2300)
 #define MT_WTBL1_OR_PSM_WRITE		BIT(31)
 
-enum mt7603_cipher_type {
-	MT_CIPHER_NONE,
-	MT_CIPHER_WEP40,
-	MT_CIPHER_TKIP,
-	MT_CIPHER_TKIP_NO_MIC,
-	MT_CIPHER_AES_CCMP,
-	MT_CIPHER_WEP104,
-	MT_CIPHER_BIP_CMAC_128,
-	MT_CIPHER_WEP128,
-	MT_CIPHER_WAPI,
-};
-
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 303d9f97b52a..f43df43512a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -57,6 +57,33 @@ static const struct mt7615_dfs_radar_spec jp_radar_specs = {
 	},
 };
 
+static enum mt76_cipher_type
+mt7615_mac_get_cipher(int cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return MT_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return MT_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return MT_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return MT_CIPHER_BIP_CMAC_128;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return MT_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return MT_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return MT_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return MT_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return MT_CIPHER_WAPI;
+	default:
+		return MT_CIPHER_NONE;
+	}
+}
+
 static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 					    u8 idx, bool unicast)
 {
@@ -313,14 +340,27 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD2_NORMAL_SEC_MODE, rxd2)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
@@ -1078,7 +1118,7 @@ EXPORT_SYMBOL_GPL(mt7615_mac_set_rates);
 static int
 mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key,
-			   enum mt7615_cipher_type cipher, u16 cipher_mask,
+			   enum mt76_cipher_type cipher, u16 cipher_mask,
 			   enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx) + 30 * 4;
@@ -1118,7 +1158,7 @@ mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 static int
 mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-			  enum mt7615_cipher_type cipher, u16 cipher_mask,
+			  enum mt76_cipher_type cipher, u16 cipher_mask,
 			  int keyidx, enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx), w0, w1;
@@ -1157,7 +1197,7 @@ mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 static void
 mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-			      enum mt7615_cipher_type cipher, u16 cipher_mask,
+			      enum mt76_cipher_type cipher, u16 cipher_mask,
 			      enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx);
@@ -1183,7 +1223,7 @@ int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 			      struct ieee80211_key_conf *key,
 			      enum set_key_cmd cmd)
 {
-	enum mt7615_cipher_type cipher;
+	enum mt76_cipher_type cipher;
 	u16 cipher_mask = wcid->cipher;
 	int err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 6bf9da040196..46f283eb8d0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -383,48 +383,6 @@ struct mt7615_dfs_radar_spec {
 	struct mt7615_dfs_pattern radar_pattern[16];
 };
 
-enum mt7615_cipher_type {
-	MT_CIPHER_NONE,
-	MT_CIPHER_WEP40,
-	MT_CIPHER_TKIP,
-	MT_CIPHER_TKIP_NO_MIC,
-	MT_CIPHER_AES_CCMP,
-	MT_CIPHER_WEP104,
-	MT_CIPHER_BIP_CMAC_128,
-	MT_CIPHER_WEP128,
-	MT_CIPHER_WAPI,
-	MT_CIPHER_CCMP_256 = 10,
-	MT_CIPHER_GCMP,
-	MT_CIPHER_GCMP_256,
-};
-
-static inline enum mt7615_cipher_type
-mt7615_mac_get_cipher(int cipher)
-{
-	switch (cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-		return MT_CIPHER_WEP40;
-	case WLAN_CIPHER_SUITE_WEP104:
-		return MT_CIPHER_WEP104;
-	case WLAN_CIPHER_SUITE_TKIP:
-		return MT_CIPHER_TKIP;
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		return MT_CIPHER_BIP_CMAC_128;
-	case WLAN_CIPHER_SUITE_CCMP:
-		return MT_CIPHER_AES_CCMP;
-	case WLAN_CIPHER_SUITE_CCMP_256:
-		return MT_CIPHER_CCMP_256;
-	case WLAN_CIPHER_SUITE_GCMP:
-		return MT_CIPHER_GCMP;
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		return MT_CIPHER_GCMP_256;
-	case WLAN_CIPHER_SUITE_SMS4:
-		return MT_CIPHER_WAPI;
-	default:
-		return MT_CIPHER_NONE;
-	}
-}
-
 static inline struct mt7615_txp_common *
 mt7615_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 7572c793aa51..c32e6dc68773 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -34,24 +34,24 @@ mt76x02_mac_get_key_info(struct ieee80211_key_conf *key, u8 *key_data)
 {
 	memset(key_data, 0, 32);
 	if (!key)
-		return MT_CIPHER_NONE;
+		return MT76X02_CIPHER_NONE;
 
 	if (key->keylen > 32)
-		return MT_CIPHER_NONE;
+		return MT76X02_CIPHER_NONE;
 
 	memcpy(key_data, key->key, key->keylen);
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
-		return MT_CIPHER_WEP40;
+		return MT76X02_CIPHER_WEP40;
 	case WLAN_CIPHER_SUITE_WEP104:
-		return MT_CIPHER_WEP104;
+		return MT76X02_CIPHER_WEP104;
 	case WLAN_CIPHER_SUITE_TKIP:
-		return MT_CIPHER_TKIP;
+		return MT76X02_CIPHER_TKIP;
 	case WLAN_CIPHER_SUITE_CCMP:
-		return MT_CIPHER_AES_CCMP;
+		return MT76X02_CIPHER_AES_CCMP;
 	default:
-		return MT_CIPHER_NONE;
+		return MT76X02_CIPHER_NONE;
 	}
 }
 
@@ -63,7 +63,7 @@ int mt76x02_mac_shared_key_setup(struct mt76x02_dev *dev, u8 vif_idx,
 	u32 val;
 
 	cipher = mt76x02_mac_get_key_info(key, key_data);
-	if (cipher == MT_CIPHER_NONE && key)
+	if (cipher == MT76X02_CIPHER_NONE && key)
 		return -EOPNOTSUPP;
 
 	val = mt76_rr(dev, MT_SKEY_MODE(vif_idx));
@@ -91,10 +91,10 @@ void mt76x02_mac_wcid_sync_pn(struct mt76x02_dev *dev, u8 idx,
 	eiv = mt76_rr(dev, MT_WCID_IV(idx) + 4);
 
 	pn = (u64)eiv << 16;
-	if (cipher == MT_CIPHER_TKIP) {
+	if (cipher == MT76X02_CIPHER_TKIP) {
 		pn |= (iv >> 16) & 0xff;
 		pn |= (iv & 0xff) << 8;
-	} else if (cipher >= MT_CIPHER_AES_CCMP) {
+	} else if (cipher >= MT76X02_CIPHER_AES_CCMP) {
 		pn |= iv & 0xffff;
 	} else {
 		return;
@@ -112,7 +112,7 @@ int mt76x02_mac_wcid_set_key(struct mt76x02_dev *dev, u8 idx,
 	u64 pn;
 
 	cipher = mt76x02_mac_get_key_info(key, key_data);
-	if (cipher == MT_CIPHER_NONE && key)
+	if (cipher == MT76X02_CIPHER_NONE && key)
 		return -EOPNOTSUPP;
 
 	mt76_wr_copy(dev, MT_WCID_KEY(idx), key_data, sizeof(key_data));
@@ -126,16 +126,16 @@ int mt76x02_mac_wcid_set_key(struct mt76x02_dev *dev, u8 idx,
 		pn = atomic64_read(&key->tx_pn);
 
 		iv_data[3] = key->keyidx << 6;
-		if (cipher >= MT_CIPHER_TKIP) {
+		if (cipher >= MT76X02_CIPHER_TKIP) {
 			iv_data[3] |= 0x20;
 			put_unaligned_le32(pn >> 16, &iv_data[4]);
 		}
 
-		if (cipher == MT_CIPHER_TKIP) {
+		if (cipher == MT76X02_CIPHER_TKIP) {
 			iv_data[0] = (pn >> 8) & 0xff;
 			iv_data[1] = (iv_data[0] | 0x20) & 0x7f;
 			iv_data[2] = pn & 0xff;
-		} else if (cipher >= MT_CIPHER_AES_CCMP) {
+		} else if (cipher >= MT76X02_CIPHER_AES_CCMP) {
 			put_unaligned_le16((pn & 0xffff), &iv_data[0]);
 		}
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index 3e722276b5c2..fa7872ac22bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -692,15 +692,15 @@ struct mt76_wcid_key {
 } __packed __aligned(4);
 
 enum mt76x02_cipher_type {
-	MT_CIPHER_NONE,
-	MT_CIPHER_WEP40,
-	MT_CIPHER_WEP104,
-	MT_CIPHER_TKIP,
-	MT_CIPHER_AES_CCMP,
-	MT_CIPHER_CKIP40,
-	MT_CIPHER_CKIP104,
-	MT_CIPHER_CKIP128,
-	MT_CIPHER_WAPI,
+	MT76X02_CIPHER_NONE,
+	MT76X02_CIPHER_WEP40,
+	MT76X02_CIPHER_WEP104,
+	MT76X02_CIPHER_TKIP,
+	MT76X02_CIPHER_AES_CCMP,
+	MT76X02_CIPHER_CKIP40,
+	MT76X02_CIPHER_CKIP104,
+	MT76X02_CIPHER_CKIP128,
+	MT76X02_CIPHER_WAPI,
 };
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index c093c13bf1f1..2462704094b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -413,14 +413,27 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b565024404cf..863aa18b3024 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -88,28 +88,28 @@ struct mt7915_fw_region {
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
-static enum mt7915_cipher_type
+static enum mcu_cipher_type
 mt7915_mcu_get_cipher(int cipher)
 {
 	switch (cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
-		return MT_CIPHER_WEP40;
+		return MCU_CIPHER_WEP40;
 	case WLAN_CIPHER_SUITE_WEP104:
-		return MT_CIPHER_WEP104;
+		return MCU_CIPHER_WEP104;
 	case WLAN_CIPHER_SUITE_TKIP:
-		return MT_CIPHER_TKIP;
+		return MCU_CIPHER_TKIP;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		return MT_CIPHER_BIP_CMAC_128;
+		return MCU_CIPHER_BIP_CMAC_128;
 	case WLAN_CIPHER_SUITE_CCMP:
-		return MT_CIPHER_AES_CCMP;
+		return MCU_CIPHER_AES_CCMP;
 	case WLAN_CIPHER_SUITE_CCMP_256:
-		return MT_CIPHER_CCMP_256;
+		return MCU_CIPHER_CCMP_256;
 	case WLAN_CIPHER_SUITE_GCMP:
-		return MT_CIPHER_GCMP;
+		return MCU_CIPHER_GCMP;
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		return MT_CIPHER_GCMP_256;
+		return MCU_CIPHER_GCMP_256;
 	case WLAN_CIPHER_SUITE_SMS4:
-		return MT_CIPHER_WAPI;
+		return MCU_CIPHER_WAPI;
 	default:
 		return MT_CIPHER_NONE;
 	}
@@ -1207,14 +1207,14 @@ mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
 		sec_key = &sec->key[0];
 		sec_key->cipher_len = sizeof(*sec_key);
 
-		if (cipher == MT_CIPHER_BIP_CMAC_128) {
-			sec_key->cipher_id = MT_CIPHER_AES_CCMP;
+		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
+			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
 			sec_key->key_id = bip->keyidx;
 			sec_key->key_len = 16;
 			memcpy(sec_key->key, bip->key, 16);
 
 			sec_key = &sec->key[1];
-			sec_key->cipher_id = MT_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
 			sec_key->cipher_len = sizeof(*sec_key);
 			sec_key->key_len = 16;
 			memcpy(sec_key->key, key->key, 16);
@@ -1226,14 +1226,14 @@ mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
 			sec_key->key_len = key->keylen;
 			memcpy(sec_key->key, key->key, key->keylen);
 
-			if (cipher == MT_CIPHER_TKIP) {
+			if (cipher == MCU_CIPHER_TKIP) {
 				/* Rx/Tx MIC keys are swapped */
 				memcpy(sec_key->key + 16, key->key + 24, 8);
 				memcpy(sec_key->key + 24, key->key + 16, 8);
 			}
 
 			/* store key_conf for BIP batch update */
-			if (cipher == MT_CIPHER_AES_CCMP) {
+			if (cipher == MCU_CIPHER_AES_CCMP) {
 				memcpy(bip->key, key->key, key->keylen);
 				bip->keyidx = key->keyidx;
 			}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 9087a7771c35..edd3ba3a0c2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1072,18 +1072,17 @@ enum {
 	STA_REC_MAX_NUM
 };
 
-enum mt7915_cipher_type {
-	MT_CIPHER_NONE,
-	MT_CIPHER_WEP40,
-	MT_CIPHER_WEP104,
-	MT_CIPHER_WEP128,
-	MT_CIPHER_TKIP,
-	MT_CIPHER_AES_CCMP,
-	MT_CIPHER_CCMP_256,
-	MT_CIPHER_GCMP,
-	MT_CIPHER_GCMP_256,
-	MT_CIPHER_WAPI,
-	MT_CIPHER_BIP_CMAC_128,
+enum mcu_cipher_type {
+	MCU_CIPHER_WEP40 = 1,
+	MCU_CIPHER_WEP104,
+	MCU_CIPHER_WEP128,
+	MCU_CIPHER_TKIP,
+	MCU_CIPHER_AES_CCMP,
+	MCU_CIPHER_CCMP_256,
+	MCU_CIPHER_GCMP,
+	MCU_CIPHER_GCMP_256,
+	MCU_CIPHER_WAPI,
+	MCU_CIPHER_BIP_CMAC_128,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5af3a958e5b0..c879a258b4a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -433,14 +433,27 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
-			status->iv[0] = data[5];
-			status->iv[1] = data[4];
-			status->iv[2] = data[3];
-			status->iv[3] = data[2];
-			status->iv[4] = data[1];
-			status->iv[5] = data[0];
-
-			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+			switch (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
 		}
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ffc83717fd0d..a3ccf6b47967 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -88,28 +88,28 @@ struct mt7921_fw_region {
 #define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
 
-static enum mt7921_cipher_type
+static enum mcu_cipher_type
 mt7921_mcu_get_cipher(int cipher)
 {
 	switch (cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
-		return MT_CIPHER_WEP40;
+		return MCU_CIPHER_WEP40;
 	case WLAN_CIPHER_SUITE_WEP104:
-		return MT_CIPHER_WEP104;
+		return MCU_CIPHER_WEP104;
 	case WLAN_CIPHER_SUITE_TKIP:
-		return MT_CIPHER_TKIP;
+		return MCU_CIPHER_TKIP;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		return MT_CIPHER_BIP_CMAC_128;
+		return MCU_CIPHER_BIP_CMAC_128;
 	case WLAN_CIPHER_SUITE_CCMP:
-		return MT_CIPHER_AES_CCMP;
+		return MCU_CIPHER_AES_CCMP;
 	case WLAN_CIPHER_SUITE_CCMP_256:
-		return MT_CIPHER_CCMP_256;
+		return MCU_CIPHER_CCMP_256;
 	case WLAN_CIPHER_SUITE_GCMP:
-		return MT_CIPHER_GCMP;
+		return MCU_CIPHER_GCMP;
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		return MT_CIPHER_GCMP_256;
+		return MCU_CIPHER_GCMP_256;
 	case WLAN_CIPHER_SUITE_SMS4:
-		return MT_CIPHER_WAPI;
+		return MCU_CIPHER_WAPI;
 	default:
 		return MT_CIPHER_NONE;
 	}
@@ -625,14 +625,14 @@ mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
 		sec_key = &sec->key[0];
 		sec_key->cipher_len = sizeof(*sec_key);
 
-		if (cipher == MT_CIPHER_BIP_CMAC_128) {
-			sec_key->cipher_id = MT_CIPHER_AES_CCMP;
+		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
+			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
 			sec_key->key_id = bip->keyidx;
 			sec_key->key_len = 16;
 			memcpy(sec_key->key, bip->key, 16);
 
 			sec_key = &sec->key[1];
-			sec_key->cipher_id = MT_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
 			sec_key->cipher_len = sizeof(*sec_key);
 			sec_key->key_len = 16;
 			memcpy(sec_key->key, key->key, 16);
@@ -644,14 +644,14 @@ mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
 			sec_key->key_len = key->keylen;
 			memcpy(sec_key->key, key->key, key->keylen);
 
-			if (cipher == MT_CIPHER_TKIP) {
+			if (cipher == MCU_CIPHER_TKIP) {
 				/* Rx/Tx MIC keys are swapped */
 				memcpy(sec_key->key + 16, key->key + 24, 8);
 				memcpy(sec_key->key + 24, key->key + 16, 8);
 			}
 
 			/* store key_conf for BIP batch update */
-			if (cipher == MT_CIPHER_AES_CCMP) {
+			if (cipher == MCU_CIPHER_AES_CCMP) {
 				memcpy(bip->key, key->key, key->keylen);
 				bip->keyidx = key->keyidx;
 			}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 89fed2f71161..d76cf8f8dfdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -198,18 +198,17 @@ struct sta_rec_sec {
 	struct sec_key key[2];
 } __packed;
 
-enum mt7921_cipher_type {
-	MT_CIPHER_NONE,
-	MT_CIPHER_WEP40,
-	MT_CIPHER_WEP104,
-	MT_CIPHER_WEP128,
-	MT_CIPHER_TKIP,
-	MT_CIPHER_AES_CCMP,
-	MT_CIPHER_CCMP_256,
-	MT_CIPHER_GCMP,
-	MT_CIPHER_GCMP_256,
-	MT_CIPHER_WAPI,
-	MT_CIPHER_BIP_CMAC_128,
+enum mcu_cipher_type {
+	MCU_CIPHER_WEP40 = 1,
+	MCU_CIPHER_WEP104,
+	MCU_CIPHER_WEP128,
+	MCU_CIPHER_TKIP,
+	MCU_CIPHER_AES_CCMP,
+	MCU_CIPHER_CCMP_256,
+	MCU_CIPHER_GCMP,
+	MCU_CIPHER_GCMP_256,
+	MCU_CIPHER_WAPI,
+	MCU_CIPHER_BIP_CMAC_128,
 };
 
 enum {
-- 
2.18.0

