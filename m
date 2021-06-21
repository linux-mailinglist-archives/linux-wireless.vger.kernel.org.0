Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6756C3AF8F2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFUXJe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 19:09:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229915AbhFUXJe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 19:09:34 -0400
X-UUID: 54a6f126e43d4046839a899c61c87cbe-20210622
X-UUID: 54a6f126e43d4046839a899c61c87cbe-20210622
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 365456887; Tue, 22 Jun 2021 07:07:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 07:07:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Jun 2021 07:07:15 +0800
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
Subject: [PATCH v2] mt76: mt7921: add .set_sar_specs support
Date:   Tue, 22 Jun 2021 07:07:14 +0800
Message-ID: <28d23d04a251490241763dd0b5fe50a523f6fb02.1624316313.git.objelf@gmail.com>
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
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 +++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 26 +++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 33 ++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 41 +++++++++++++++++++
 5 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 25c5ceef5257..63ce5242c4d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -636,6 +636,9 @@ struct mt76_phy {
 		struct sk_buff **tail;
 		u16 seqno;
 	} rx_amsdu[__MT_RXQ_MAX];
+
+	void *frp_data;
+	u8 num_frps;
 };
 
 struct mt76_dev {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index f49d97d0a1c5..95c7d1cac7c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -83,6 +83,11 @@ struct mt76_connac_coredump {
 	unsigned long last_activity;
 };
 
+struct mt76_connac_freq_range_power {
+	const struct cfg80211_sar_freq_ranges *range;
+	s8 power;
+};
+
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7921(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5c3a81e5f559..497de1d91c7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1749,6 +1749,26 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
 	}
 }
 
+static s8 mt76_connac_get_sar_power(struct mt76_phy *phy,
+				    struct ieee80211_channel *chan,
+				    s8 target_power)
+{
+	struct mt76_connac_freq_range_power *frp = phy->frp_data;
+	int freq, i;
+
+	freq = ieee80211_channel_to_frequency(chan->hw_value, chan->band);
+	for (i = 0 ; i < phy->num_frps; i++) {
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
@@ -1816,9 +1836,13 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
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
index a9ce10b98827..c11a5b925209 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -24,6 +24,20 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
+const struct cfg80211_sar_freq_ranges mt7921_sar_freq_ranges[] = {
+	{ .start_freq = 2402, .end_freq = 2494, },
+	{ .start_freq = 5150, .end_freq = 5350, },
+	{ .start_freq = 5350, .end_freq = 5470, },
+	{ .start_freq = 5470, .end_freq = 5725, },
+	{ .start_freq = 5725, .end_freq = 5950, },
+};
+
+static const struct cfg80211_sar_capa mt7921_sar_capa = {
+	.type = NL80211_SAR_TYPE_POWER,
+	.num_freq_ranges = ARRAY_SIZE(mt7921_sar_freq_ranges),
+	.freq_ranges = &mt7921_sar_freq_ranges[0],
+};
+
 static void
 mt7921_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
@@ -41,7 +55,7 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	mt7921_mutex_release(dev);
 }
 
-static void
+static int
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
@@ -75,6 +89,16 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_sched_scan_reqs = 1;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy->reg_notifier = mt7921_regd_notifier;
+	wiphy->sar_capa = &mt7921_sar_capa;
+
+	phy->mt76->frp_data = devm_kcalloc(dev->mt76.dev,
+					   wiphy->sar_capa->num_freq_ranges,
+					   sizeof(struct mt76_connac_freq_range_power),
+					   GFP_KERNEL);
+	if (!phy->mt76->frp_data)
+		return -ENOMEM;
+
+	phy->mt76->num_frps = wiphy->sar_capa->num_freq_ranges;
 
 	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
 			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
@@ -92,6 +116,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
 	hw->max_tx_fragments = 4;
+
+	return 0;
 }
 
 static void
@@ -207,7 +233,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
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
index 7fd21049ff5a..f1a08776ea97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1171,6 +1171,46 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 					     MCU_UNI_CMD_STA_REC_UPDATE);
 }
 
+static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	const struct cfg80211_sar_capa *capa = hw->wiphy->sar_capa;
+	struct mt76_connac_freq_range_power *frp_data, *frp;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+	u32 i;
+
+	if (!sar || sar->type != NL80211_SAR_TYPE_POWER || !sar->num_sub_specs)
+		return -EINVAL;
+
+	mt7921_mutex_acquire(dev);
+
+	frp_data = mphy->frp_data;
+
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		u32 index = sar->sub_specs[i].freq_range_index;
+		/* SAR specifies power limitaton in 0.25dbm */
+		s32 power = sar->sub_specs[i].power >> 1;
+
+		if (power > 127 || power < -127)
+			power = 127;
+
+		if (index >= mphy->num_frps)
+			continue;
+
+		frp = &frp_data[index];
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
@@ -1209,4 +1249,5 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_rekey_data = mt7921_set_rekey_data,
 #endif /* CONFIG_PM */
 	.flush = mt7921_flush,
+	.set_sar_specs = mt7921_set_sar_specs,
 };
-- 
2.25.1

