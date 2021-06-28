Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8466F3B6B28
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jun 2021 01:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhF1XI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 19:08:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42237 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230163AbhF1XIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 19:08:25 -0400
X-UUID: 62e88197683447f3921f7c6db78e95d0-20210629
X-UUID: 62e88197683447f3921f7c6db78e95d0-20210629
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1756562193; Tue, 29 Jun 2021 07:05:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Jun 2021 07:05:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Jun 2021 07:05:54 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3] mt76: mt7921: add .set_sar_specs support
Date:   Tue, 29 Jun 2021 07:05:53 +0800
Message-ID: <212c2ca86c3da877bc70be8bdc9fc3f93ca4ff45.1624920521.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YN Chen <YN.Chen@mediatek.com>

add .set_sar_specs to allow configuring SAR power limitations on the
frequency ranges from the userland.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
---
v2: 1. loop enhancement with considering no overlapping freqs
    2. error handling for devm_kcalloc
    3. sanity check without acquire lock
v3:
    1. move cfg80211_sar_capa to mt76 core to provide a common
       ground to other mt76 station devices
    2. remove uneccessary condition check because nl80211_set_sar_specs
       already did it
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 15 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  8 ++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 30 ++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 17 ++++++++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 38 +++++++++++++++++++
 5 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d03aedc3286b..ee3a5b8d62d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -99,6 +99,21 @@ struct ieee80211_rate mt76_rates[] = {
 };
 EXPORT_SYMBOL_GPL(mt76_rates);
 
+static const struct cfg80211_sar_freq_ranges mt76_sar_freq_ranges[] = {
+	{ .start_freq = 2402, .end_freq = 2494, },
+	{ .start_freq = 5150, .end_freq = 5350, },
+	{ .start_freq = 5350, .end_freq = 5470, },
+	{ .start_freq = 5470, .end_freq = 5725, },
+	{ .start_freq = 5725, .end_freq = 5950, },
+};
+
+const struct cfg80211_sar_capa mt76_sar_capa = {
+	.type = NL80211_SAR_TYPE_POWER,
+	.num_freq_ranges = ARRAY_SIZE(mt76_sar_freq_ranges),
+	.freq_ranges = &mt76_sar_freq_ranges[0],
+};
+EXPORT_SYMBOL_GPL(mt76_sar_capa);
+
 static int mt76_led_init(struct mt76_dev *dev)
 {
 	struct device_node *np = dev->dev->of_node;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 25c5ceef5257..ec42b87c9779 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -545,6 +545,11 @@ struct mt76_rx_status {
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 };
 
+struct mt76_freq_range_power {
+	const struct cfg80211_sar_freq_ranges *range;
+	s8 power;
+};
+
 struct mt76_testmode_ops {
 	int (*set_state)(struct mt76_phy *phy, enum mt76_testmode_state state);
 	int (*set_params)(struct mt76_phy *phy, struct nlattr **tb,
@@ -636,6 +641,8 @@ struct mt76_phy {
 		struct sk_buff **tail;
 		u16 seqno;
 	} rx_amsdu[__MT_RXQ_MAX];
+
+	struct mt76_freq_range_power *frp;
 };
 
 struct mt76_dev {
@@ -769,6 +776,7 @@ enum mt76_phy_type {
 }
 
 extern struct ieee80211_rate mt76_rates[12];
+extern const struct cfg80211_sar_capa mt76_sar_capa;
 
 #define __mt76_rr(dev, ...)	(dev)->bus->rr((dev), __VA_ARGS__)
 #define __mt76_wr(dev, ...)	(dev)->bus->wr((dev), __VA_ARGS__)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5c3a81e5f559..a2555dc0f003 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1749,6 +1749,30 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
 	}
 }
 
+static s8 mt76_connac_get_sar_power(struct mt76_phy *phy,
+				    struct ieee80211_channel *chan,
+				    s8 target_power)
+{
+	const struct cfg80211_sar_capa *capa = phy->hw->wiphy->sar_capa;
+	struct mt76_freq_range_power *frp = phy->frp;
+	int freq, i;
+
+	if (!capa || !frp)
+		return target_power;
+
+	freq = ieee80211_channel_to_frequency(chan->hw_value, chan->band);
+	for (i = 0 ; i < capa->num_freq_ranges; i++) {
+		if (frp[i].range &&
+		    freq >= frp[i].range->start_freq &&
+		    freq < frp[i].range->end_freq) {
+			target_power = min_t(s8, frp[i].power, target_power);
+			break;
+		}
+	}
+
+	return target_power;
+}
+
 static int
 mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				  enum nl80211_band band)
@@ -1816,9 +1840,13 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				.hw_value = ch_list[idx],
 				.band = band,
 			};
+			s8 sar_power;
+
+			sar_power = mt76_connac_get_sar_power(phy, &chan,
+							      tx_power);
 
 			mt76_get_rate_power_limits(phy, &chan, &limits,
-						   tx_power);
+						   sar_power);
 
 			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
 			sku_tlbv.channel = ch_list[idx];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index a9ce10b98827..865cf8192e34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -41,7 +41,7 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	mt7921_mutex_release(dev);
 }
 
-static void
+static int
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
@@ -75,6 +75,14 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_sched_scan_reqs = 1;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy->reg_notifier = mt7921_regd_notifier;
+	wiphy->sar_capa = &mt76_sar_capa;
+
+	phy->mt76->frp = devm_kcalloc(dev->mt76.dev,
+				      wiphy->sar_capa->num_freq_ranges,
+				      sizeof(struct mt76_freq_range_power),
+				      GFP_KERNEL);
+	if (!phy->mt76->frp)
+		return -ENOMEM;
 
 	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
 			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
@@ -92,6 +100,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
 	hw->max_tx_fragments = 4;
+
+	return 0;
 }
 
 static void
@@ -207,7 +217,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	mt7921_init_wiphy(hw);
+	ret = mt7921_init_wiphy(hw);
+	if (ret)
+		return ret;
+
 	dev->mphy.sband_2g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7fd21049ff5a..c96a0d5408d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1171,6 +1171,43 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 					     MCU_UNI_CMD_STA_REC_UPDATE);
 }
 
+static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	const struct cfg80211_sar_capa *capa = hw->wiphy->sar_capa;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_freq_range_power *data, *frp;
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+	u32 i;
+
+	if (sar->type != NL80211_SAR_TYPE_POWER || !sar->num_sub_specs)
+		return -EINVAL;
+
+	mt7921_mutex_acquire(dev);
+
+	data = mphy->frp;
+
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		u32 index = sar->sub_specs[i].freq_range_index;
+		/* SAR specifies power limitaton in 0.25dbm */
+		s32 power = sar->sub_specs[i].power >> 1;
+
+		if (power > 127 || power < -127)
+			power = 127;
+
+		frp = &data[index];
+		frp->range = &capa->freq_ranges[index];
+		frp->power = power;
+	}
+
+	err = mt76_connac_mcu_set_rate_txpower(mphy);
+
+	mt7921_mutex_release(dev);
+
+	return err;
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -1209,4 +1246,5 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_rekey_data = mt7921_set_rekey_data,
 #endif /* CONFIG_PM */
 	.flush = mt7921_flush,
+	.set_sar_specs = mt7921_set_sar_specs,
 };
-- 
2.25.1

