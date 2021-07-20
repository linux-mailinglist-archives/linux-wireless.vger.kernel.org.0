Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59293D04B7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhGTV5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 17:57:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39942 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229604AbhGTV5w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 17:57:52 -0400
X-UUID: 978dab0bcb7a4f1486d4219dbb59bf32-20210721
X-UUID: 978dab0bcb7a4f1486d4219dbb59bf32-20210721
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2054642541; Wed, 21 Jul 2021 06:38:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Jul 2021 06:38:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Jul 2021 06:38:23 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: add support for setting mcast rate
Date:   Wed, 21 Jul 2021 06:38:22 +0800
Message-ID: <541360d219d6443b39f37f1806d563563233ca34.1626820535.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mesh and ad-hoc interfaces allow users to set mcast rate through
NL80211_ATTR_MCAST_RATE, so rework mt76_default_basic_rate() to
adapt that.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  8 +++----
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 24 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 24 +++++++++++++------
 4 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d9a724a0f15e..4c11ffcfa901 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1337,16 +1337,16 @@ mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 }
 EXPORT_SYMBOL_GPL(mt76_init_queue);
 
-u16 mt76_default_basic_rate(struct mt76_phy *phy, struct ieee80211_vif *vif)
+u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
 {
-	int i = ffs(vif->bss_conf.basic_rates) - 1, offset = 0;
+	int offset = 0;
 	struct ieee80211_rate *rate;
 
 	if (phy->chandef.chan->band == NL80211_BAND_5GHZ)
 		offset = 4;
 
-	rate = &mt76_rates[offset + i];
+	rate = &mt76_rates[offset + rateidx];
 
 	return rate->hw_value;
 }
-EXPORT_SYMBOL_GPL(mt76_default_basic_rate);
+EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0322847f554c..53949a365fdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -883,7 +883,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
 		int ring_base);
-u16 mt76_default_basic_rate(struct mt76_phy *phy, struct ieee80211_vif *vif);
+u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx);
 static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
 				     int n_desc, int ring_base)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1c6f066de2dd..dfc5ea2cf7d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -904,17 +904,19 @@ mt7915_mac_write_txwi_8023(struct mt7915_dev *dev, __le32 *txwi,
 
 static void
 mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
-			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+			    struct sk_buff *skb, struct ieee80211_key_conf *key,
+			    bool *mcast)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	__le16 fc = hdr->frame_control;
 	u8 fc_type, fc_stype;
 	u32 val;
 
+	*mcast = is_multicast_ether_addr(hdr->addr1);
+
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
 	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
@@ -940,15 +942,15 @@ mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
 
 	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+	      FIELD_PREP(MT_TXD2_MULTICAST, *mcast);
 
-	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	if (key && *mcast && ieee80211_is_robust_mgmt_frame(skb) &&
 	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
 		val |= MT_TXD2_BIP;
 		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
 	}
 
-	if (!ieee80211_is_data(fc) || multicast ||
+	if (!ieee80211_is_data(fc) || *mcast ||
 	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
 		val |= MT_TXD2_FIX_RATE;
 
@@ -989,6 +991,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	bool mcast = false;
 	u16 tx_count = 15;
 	u32 val;
 
@@ -1051,15 +1054,22 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	if (is_8023)
 		mt7915_mac_write_txwi_8023(dev, txwi, skb, wcid);
 	else
-		mt7915_mac_write_txwi_80211(dev, txwi, skb, key);
+		mt7915_mac_write_txwi_80211(dev, txwi, skb, key, &mcast);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
+		u8 band = mphy->chandef.chan->band;
+		int rateidx, mcast_rate = vif->bss_conf.mcast_rate[band];
 		u16 rate, mode;
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
-		rate = mt76_default_basic_rate(mphy, vif);
+		if (mcast && mcast_rate > 0)
+			rateidx = mcast_rate - 1;
+		else
+			rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+
+		rate = mt76_calculate_default_rate(mphy, rateidx);
 		mode = rate >> 8;
 		rate &= GENMASK(7, 0);
 		rate |= FIELD_PREP(MT_TX_RATE_MODE, mode);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index b326525e4b65..2ae594f539e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -658,17 +658,19 @@ mt7921_mac_write_txwi_8023(struct mt7921_dev *dev, __le32 *txwi,
 
 static void
 mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
-			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+			    struct sk_buff *skb, struct ieee80211_key_conf *key,
+			    bool *mcast)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	__le16 fc = hdr->frame_control;
 	u8 fc_type, fc_stype;
 	u32 val;
 
+	*mcast = is_multicast_ether_addr(hdr->addr1);
+
 	if (ieee80211_is_action(fc) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
 	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
@@ -694,15 +696,15 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 
 	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+	      FIELD_PREP(MT_TXD2_MULTICAST, *mcast);
 
-	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	if (key && *mcast && ieee80211_is_robust_mgmt_frame(skb) &&
 	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
 		val |= MT_TXD2_BIP;
 		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
 	}
 
-	if (!ieee80211_is_data(fc) || multicast ||
+	if (!ieee80211_is_data(fc) || *mcast ||
 	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
 		val |= MT_TXD2_FIX_RATE;
 
@@ -759,6 +761,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	struct mt76_phy *mphy = &dev->mphy;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	bool mcast = false;
 	u16 tx_count = 15;
 	u32 val;
 
@@ -808,15 +811,22 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	if (is_8023)
 		mt7921_mac_write_txwi_8023(dev, txwi, skb, wcid);
 	else
-		mt7921_mac_write_txwi_80211(dev, txwi, skb, key);
+		mt7921_mac_write_txwi_80211(dev, txwi, skb, key, &mcast);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
+		u8 band = mphy->chandef.chan->band;
+		int rateidx, mcast_rate = vif->bss_conf.mcast_rate[band];
 		u16 rate, mode;
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
-		rate = mt76_default_basic_rate(mphy, vif);
+		if (mcast && mcast_rate > 0)
+			rateidx = mcast_rate - 1;
+		else
+			rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+
+		rate = mt76_calculate_default_rate(mphy, rateidx);
 		mode = rate >> 8;
 		rate &= GENMASK(7, 0);
 		rate |= FIELD_PREP(MT_TX_RATE_MODE, mode);
-- 
2.29.2

