Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FA4CF26B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 08:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiCGHLh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 02:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiCGHLg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 02:11:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C3541BD
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 23:10:40 -0800 (PST)
X-UUID: d60b75f707f14f309478dd81f6737308-20220307
X-UUID: d60b75f707f14f309478dd81f6737308-20220307
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1692533356; Mon, 07 Mar 2022 15:10:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Mar 2022 15:10:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 15:10:34 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Shayne Chen <Shayne.Chen@mediatek.com>,
        Peter Chiu <Chui-Hao.Chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH v3 2/4] mt76: mt7915: add 6 GHz support
Date:   Mon, 7 Mar 2022 15:10:26 +0800
Message-ID: <20220307071028.5711-2-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220307071028.5711-1-MeiChia.Chiu@mediatek.com>
References: <20220307071028.5711-1-MeiChia.Chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Basic 6 GHz support is added to mt76.
Modification includes:
1. Add 6 GHz E2P definition
2. Register 6 GHz HE cap
3. Refactor existing code of adding a STA

This adds support for Wi-Fi 6E on MT7986/MT7916.
Detailed link:
https://www.mediatek.com/products/mediatek-filogic-830
Detailed link:
https://www.mediatek.com/products/products/broadband-wifi/mediatek-filogic-630

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <Shayne.Chen@mediatek.com>
Signed-off-by: Peter Chiu <Chui-Hao.Chiu@mediatek.com>
Signed-off-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
v2:
update commit message
avoid open-coded for 6G cap
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 21 ++++++++++++--
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  7 +++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 28 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 12 +++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 28 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  4 +++
 7 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 0fa539479aa7..136a6adab3df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -135,9 +135,24 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 
 	val = eeprom[MT_EE_WIFI_CONF + phy->band_idx];
 	val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
-	if (val == MT_EE_BAND_SEL_DEFAULT &&
-	    (!is_mt7915(&dev->mt76) || dev->dbdc_support))
-		val = phy->band_idx ? MT_EE_BAND_SEL_5GHZ : MT_EE_BAND_SEL_2GHZ;
+
+	if (!is_mt7915(&dev->mt76)) {
+		switch (val) {
+		case MT_EE_V2_BAND_SEL_5GHZ:
+			phy->mt76->cap.has_5ghz = true;
+			return;
+		case MT_EE_V2_BAND_SEL_6GHZ:
+			phy->mt76->cap.has_6ghz = true;
+			return;
+		case MT_EE_V2_BAND_SEL_5GHZ_6GHZ:
+			phy->mt76->cap.has_5ghz = true;
+			phy->mt76->cap.has_6ghz = true;
+			return;
+		default:
+			phy->mt76->cap.has_2ghz = true;
+			return;
+		}
+	}
 
 	switch (val) {
 	case MT_EE_BAND_SEL_5GHZ:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 5ffc56bb5c51..5dad5b0b5ac6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -76,6 +76,13 @@ enum mt7915_eeprom_band {
 	MT_EE_BAND_SEL_DUAL,
 };
 
+enum {
+	MT_EE_V2_BAND_SEL_2GHZ,
+	MT_EE_V2_BAND_SEL_5GHZ,
+	MT_EE_V2_BAND_SEL_6GHZ,
+	MT_EE_V2_BAND_SEL_5GHZ_6GHZ,
+};
+
 enum mt7915_sku_rate_group {
 	SKU_CCK,
 	SKU_OFDM,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index fd16d777f2e4..9a696687d61c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -872,7 +872,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		if (band == NL80211_BAND_2GHZ)
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
-		else if (band == NL80211_BAND_5GHZ)
+		else
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
@@ -911,7 +911,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 			if (band == NL80211_BAND_2GHZ)
 				he_cap_elem->phy_cap_info[0] |=
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
-			else if (band == NL80211_BAND_5GHZ)
+			else
 				he_cap_elem->phy_cap_info[0] |=
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
 
@@ -961,6 +961,21 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
 					       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
 		}
+
+		if (band == NL80211_BAND_6GHZ) {
+			u16 cap = IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
+				  IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+			cap |= u16_encode_bits(IEEE80211_HT_MPDU_DENSITY_8,
+					       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
+			       u16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
+			       u16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+					       IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+
+			data[idx].he_6ghz_capa.capa = cpu_to_le16(cap);
+		}
+
 		idx++;
 	}
 
@@ -990,6 +1005,15 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 		band->iftype_data = data;
 		band->n_iftype_data = n;
 	}
+
+	if (phy->mt76->cap.has_6ghz) {
+		data = phy->iftype[NL80211_BAND_6GHZ];
+		n = mt7915_init_he_caps(phy, NL80211_BAND_6GHZ, data);
+
+		band = &phy->mt76->sband_6g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
 }
 
 static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1da551f0b389..f3f48e7fc593 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -638,6 +638,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	status->band = mphy->chandef.chan->band;
 	if (status->band == NL80211_BAND_5GHZ)
 		sband = &mphy->sband_5g.sband;
+	else if (status->band == NL80211_BAND_6GHZ)
+		sband = &mphy->sband_6g.sband;
 	else
 		sband = &mphy->sband_2g.sband;
 
@@ -1350,7 +1352,7 @@ mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 	u16 fc, tid;
 	u32 val;
 
-	if (!sta || !sta->ht_cap.ht_supported)
+	if (!sta || !(sta->ht_cap.ht_supported || sta->he_cap.has_he))
 		return;
 
 	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
@@ -1558,6 +1560,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
 		else
 			sband = &mphy->sband_2g.sband;
 
@@ -1803,7 +1807,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
 	int offset;
-	bool is_5ghz = phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ;
+	bool a_band = !(phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ);
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
@@ -1823,7 +1827,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	mt76_wr(dev, MT_TMAC_CDTR(phy->band_idx), cck + reg_offset);
 	mt76_wr(dev, MT_TMAC_ODTR(phy->band_idx), ofdm + reg_offset);
 	mt76_wr(dev, MT_TMAC_ICR0(phy->band_idx),
-		FIELD_PREP(MT_IFS_EIFS_OFDM, is_5ghz ? 84 : 78) |
+		FIELD_PREP(MT_IFS_EIFS_OFDM, a_band ? 84 : 78) |
 		FIELD_PREP(MT_IFS_RIFS, 2) |
 		FIELD_PREP(MT_IFS_SIFS, 10) |
 		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
@@ -1831,7 +1835,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	mt76_wr(dev, MT_TMAC_ICR1(phy->band_idx),
 		FIELD_PREP(MT_IFS_EIFS_CCK, 314));
 
-	if (phy->slottime < 20 || is_5ghz)
+	if (phy->slottime < 20 || a_band)
 		val = MT7915_CFEND_RATE_DEFAULT;
 	else
 		val = MT7915_CFEND_RATE_11B;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 77bf3d94782b..1bc86a289e8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -987,6 +987,9 @@ mt7915_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	struct sta_rec_ht *ht;
 	struct tlv *tlv;
 
+	if (!sta->ht_cap.ht_supported)
+		return;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
 
 	ht = (struct sta_rec_ht *)tlv;
@@ -1267,6 +1270,9 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	};
 	bool ebf;
 
+	if (!(sta->ht_cap.ht_supported || sta->he_cap.has_he))
+		return;
+
 	ebf = mt7915_is_ebf_supported(phy, vif, sta, false);
 	if (!ebf && !dev->ibf)
 		return;
@@ -1327,6 +1333,9 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	struct tlv *tlv;
 	u8 nrow = 0;
 
+	if (!(sta->vht_cap.vht_supported || sta->he_cap.has_he))
+		return;
+
 	if (!mt7915_is_ebf_supported(phy, vif, sta, true))
 		return;
 
@@ -1621,6 +1630,10 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 	if (sta->he_cap.has_he) {
 		ra->supp_mode |= MODE_HE;
 		cap |= STA_CAP_HE;
+
+		if (sta->he_6ghz_capa.capa)
+			ra->af = le16_get_bits(sta->he_6ghz_capa.capa,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
 	}
 
 	ra->sta_cap = cpu_to_le32(cap);
@@ -1643,7 +1656,7 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	 * once dev->rc_work changes the settings driver should also
 	 * update sta_rec_he here.
 	 */
-	if (sta->he_cap.has_he && changed)
+	if (changed)
 		mt7915_mcu_sta_he_tlv(skb, sta, vif);
 
 	/* sta_rec_ra accommodates BW, NSS and only MCS range format
@@ -1712,7 +1725,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		goto out;
 
 	/* tag order is in accordance with firmware dependency. */
-	if (sta && sta->ht_cap.ht_supported) {
+	if (sta) {
 		/* starec bfer */
 		mt7915_mcu_sta_bfer_tlv(dev, skb, vif, sta);
 		/* starec ht */
@@ -1729,7 +1742,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return ret;
 	}
 
-	if (sta && sta->ht_cap.ht_supported) {
+	if (sta) {
 		/* starec amsdu */
 		mt7915_mcu_sta_amsdu_tlv(dev, skb, vif, sta);
 		/* starec he */
@@ -2772,6 +2785,11 @@ int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
 
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 {
+	static const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 0,
+		[NL80211_BAND_5GHZ] = 1,
+		[NL80211_BAND_6GHZ] = 2,
+	};
 	struct mt7915_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	int freq1 = chandef->center_freq1;
@@ -2799,7 +2817,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
 		.rx_streams = phy->mt76->antenna_mask,
 		.band_idx = phy->band_idx,
-		.channel_band = chandef->chan->band,
+		.channel_band = ch_band[chandef->chan->band],
 	};
 
 #ifdef CONFIG_NL80211_TESTMODE
@@ -3461,6 +3479,8 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	case MT_PHY_TYPE_OFDM:
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
 		else
 			sband = &mphy->sband_2g.sband;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 2fe737f2f844..6efa0a2e2345 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -227,7 +227,7 @@ struct mt7915_phy {
 	struct mt76_phy *mt76;
 	struct mt7915_dev *dev;
 
-	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
+	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 
 	struct ieee80211_vif *monitor_vif;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 6605e24c4593..20f63644e929 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -271,6 +271,8 @@ mt7915_tm_set_tx_len(struct mt7915_phy *phy, u32 tx_time)
 	case MT76_TM_TX_MODE_OFDM:
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
 		else
 			sband = &mphy->sband_2g.sband;
 
@@ -572,6 +574,8 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 
 		if (chandef->chan->band == NL80211_BAND_5GHZ)
 			sband = &phy->mt76->sband_5g.sband;
+		else if (chandef->chan->band == NL80211_BAND_6GHZ)
+			sband = &phy->mt76->sband_6g.sband;
 		else
 			sband = &phy->mt76->sband_2g.sband;
 
-- 
2.18.0

