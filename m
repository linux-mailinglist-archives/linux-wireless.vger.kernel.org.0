Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF083FA779
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Aug 2021 22:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhH1UB7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Aug 2021 16:01:59 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33100 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230253AbhH1UB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Aug 2021 16:01:59 -0400
X-UUID: dbbb5091496549b0afccf05d0df1e722-20210829
X-UUID: dbbb5091496549b0afccf05d0df1e722-20210829
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1699741830; Sun, 29 Aug 2021 04:01:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 29 Aug 2021 04:01:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 29 Aug 2021 04:01:03 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: enable configured beacon tx rate
Date:   Sun, 29 Aug 2021 04:01:02 +0800
Message-ID: <f915e8849cb416eb36dc655bb6208db43cd37e32.1630180819.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The user is allowed to change beacon tx rate (HT/VHT/HE) from hostapd.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 ++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 59 +++++++++++++++----
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6208f5662704..acc83e9f409b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -325,6 +325,10 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
 
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1b8e37e265cb..6305f3231537 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -993,6 +993,51 @@ mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[7] |= cpu_to_le32(val);
 }
 
+static u16
+mt7915_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+		       bool beacon, bool mcast)
+{
+	u8 mode = 0, band = mphy->chandef.chan->band;
+	int rateidx = 0, mcast_rate;
+
+	if (beacon) {
+		struct cfg80211_bitrate_mask *mask;
+
+		mask = &vif->bss_conf.beacon_tx_rate;
+		if (hweight16(mask->control[band].he_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].he_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_HE_SU;
+			goto out;
+		} else if (hweight16(mask->control[band].vht_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].vht_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_VHT;
+			goto out;
+		} else if (hweight8(mask->control[band].ht_mcs[0]) == 1) {
+			rateidx = ffs(mask->control[band].ht_mcs[0]) - 1;
+			mode = MT_PHY_TYPE_HT;
+			goto out;
+		} else if (hweight32(mask->control[band].legacy) == 1) {
+			rateidx = ffs(mask->control[band].legacy) - 1;
+			goto legacy;
+		}
+	}
+
+	mcast_rate = vif->bss_conf.mcast_rate[band];
+	if (mcast && mcast_rate > 0)
+		rateidx = mcast_rate - 1;
+	else
+		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+
+legacy:
+	rateidx = mt76_calculate_default_rate(mphy, rateidx);
+	mode = rateidx >> 8;
+	rateidx &= GENMASK(7, 0);
+
+out:
+	return FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
+	       FIELD_PREP(MT_TX_RATE_MODE, mode);
+}
+
 void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
 			   struct ieee80211_key_conf *key, bool beacon)
@@ -1069,23 +1114,11 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		mt7915_mac_write_txwi_80211(dev, txwi, skb, key, &mcast);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
-		u8 band = mphy->chandef.chan->band;
-		int rateidx, mcast_rate = vif->bss_conf.mcast_rate[band];
-		u16 rate, mode;
+		u16 rate = mt7915_mac_tx_rate_val(mphy, vif, beacon, mcast);
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
 		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
 
-		if (mcast && mcast_rate > 0)
-			rateidx = mcast_rate - 1;
-		else
-			rateidx = ffs(vif->bss_conf.basic_rates) - 1;
-
-		rate = mt76_calculate_default_rate(mphy, rateidx);
-		mode = rate >> 8;
-		rate &= GENMASK(7, 0);
-		rate |= FIELD_PREP(MT_TX_RATE_MODE, mode);
-
 		val = MT_TXD6_FIXED_BW |
 		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
 		txwi[6] |= cpu_to_le32(val);
-- 
2.29.2

