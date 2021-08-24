Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EAF3F5BFB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhHXKX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236216AbhHXKX5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EA71610FB;
        Tue, 24 Aug 2021 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800593;
        bh=cLObTUa8VQP5Jsqgfao37i78VkDKRbaLbQ3voofxYOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKEd7lQPVUUwZBEoZN58wnRsj82unLo32bT7Ey7KN7ukwn55jfWoH9JAMqQyDsWeB
         W5z4W2nL3Onv7x6QUIf6ln6LotF09BWF1Xt0/Hh1KI6kYoFPTqT61NND1IVfxTWfp5
         Rbryge2zHS95ldeUWdZt5/eoz2Fp6uz41xOReThj+zAc9yAw5axyQaVgFx+i++WAj2
         bmgRNav+HAj8ua68ebMaxyg29hgsl1lzlwvUcwrcNupIZoQQ4RTEa1zVaqEtXIH8jz
         kFNSHvu6BvGA2EdufG8x5YYTxGCiPanOLvi3N5ouPS2AHrI7+/LUA4bUTGSZ17aNeN
         hdhvURGjueNfA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 9/9] mt76: mt7921: add 6GHz support
Date:   Tue, 24 Aug 2021 12:22:27 +0200
Message-Id: <308d55c9dd3ae931c970166fbf5287dd8590eb36.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlock 6GHz band if supported by the device. Configure HE 6G
capabilities.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 33 ++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 39 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  6 ++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 4 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 55b7a52cd232..7eee67a4d184 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -355,7 +355,14 @@ mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
 		return;
 	}
 
-	status->band = chfreq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+	if (chfreq > 180) {
+		status->band = NL80211_BAND_6GHZ;
+		chfreq = (chfreq - 181) * 4 + 1;
+	} else if (chfreq > 14) {
+		status->band = NL80211_BAND_5GHZ;
+	} else {
+		status->band = NL80211_BAND_2GHZ;
+	}
 	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
 }
 
@@ -441,10 +448,17 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	mt7921_get_status_freq_info(dev, mphy, status, chfreq);
 
-	if (status->band == NL80211_BAND_5GHZ)
+	switch (status->band) {
+	case NL80211_BAND_5GHZ:
 		sband = &mphy->sband_5g.sband;
-	else
+		break;
+	case NL80211_BAND_6GHZ:
+		sband = &mphy->sband_6g.sband;
+		break;
+	default:
 		sband = &mphy->sband_2g.sband;
+		break;
+	}
 
 	if (!sband->channels)
 		return -EINVAL;
@@ -994,7 +1008,7 @@ mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 	u16 fc, tid;
 	u32 val;
 
-	if (!sta || !sta->ht_cap.ht_supported)
+	if (!sta || !(sta->ht_cap.ht_supported || sta->he_cap.has_he))
 		return;
 
 	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
@@ -1397,17 +1411,12 @@ void mt7921_mac_set_timing(struct mt7921_phy *phy)
 		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
-	int sifs, offset;
-	bool is_5ghz = phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ;
+	bool is_2ghz = phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ;
+	int sifs = is_2ghz ? 10 : 16, offset;
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
-	if (is_5ghz)
-		sifs = 16;
-	else
-		sifs = 10;
-
 	mt76_set(dev, MT_ARB_SCR(0),
 		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 	udelay(1);
@@ -1424,7 +1433,7 @@ void mt7921_mac_set_timing(struct mt7921_phy *phy)
 		FIELD_PREP(MT_IFS_SIFS, sifs) |
 		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
 
-	if (phy->slottime < 20 || is_5ghz)
+	if (phy->slottime < 20 || !is_2ghz)
 		val = MT7921_CFEND_RATE_DEFAULT;
 	else
 		val = MT7921_CFEND_RATE_11B;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 217ed7055aa0..cd3974b6ba8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -72,7 +72,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 		if (band == NL80211_BAND_2GHZ)
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
-		else if (band == NL80211_BAND_5GHZ)
+		else
 			he_cap_elem->phy_cap_info[0] =
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
 
@@ -93,7 +93,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 			if (band == NL80211_BAND_2GHZ)
 				he_cap_elem->phy_cap_info[0] |=
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
-			else if (band == NL80211_BAND_5GHZ)
+			else
 				he_cap_elem->phy_cap_info[0] |=
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
 
@@ -142,6 +142,32 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US;
 		}
+
+		if (band == NL80211_BAND_6GHZ) {
+			struct ieee80211_supported_band *sband =
+				&phy->mt76->sband_5g.sband;
+			struct ieee80211_sta_vht_cap *vht_cap = &sband->vht_cap;
+			struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
+			u32 exp;
+			u16 cap;
+
+			cap = u16_encode_bits(ht_cap->ampdu_density,
+					IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+			exp = u32_get_bits(vht_cap->cap,
+				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
+			cap |= u16_encode_bits(exp,
+					IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+			exp = u32_get_bits(vht_cap->cap,
+					   IEEE80211_VHT_CAP_MAX_MPDU_MASK);
+			cap |= u16_encode_bits(exp,
+					IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+			if (vht_cap->cap & IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN)
+				cap |= IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS;
+			if (vht_cap->cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
+				cap |= IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+			data->he_6ghz_capa.capa = cpu_to_le16(cap);
+		}
 		idx++;
 	}
 
@@ -170,6 +196,15 @@ void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
 		band = &phy->mt76->sband_5g.sband;
 		band->iftype_data = data;
 		band->n_iftype_data = n;
+
+		if (phy->mt76->cap.has_6ghz) {
+			data = phy->iftype[NL80211_BAND_6GHZ];
+			n = mt7921_init_he_caps(phy, NL80211_BAND_6GHZ, data);
+
+			band = &phy->mt76->sband_6g.sband;
+			band->iftype_data = data;
+			band->n_iftype_data = n;
+		}
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index f49fc8078125..34038f182bb0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1028,9 +1028,13 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
 		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
 		.rx_streams = phy->mt76->antenna_mask,
 		.band_idx = phy != &dev->phy,
-		.channel_band = chandef->chan->band,
 	};
 
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		req.channel_band = 2;
+	else
+		req.channel_band = chandef->chan->band;
+
 	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index a6caca73fdda..856035e0a5b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -111,7 +111,7 @@ struct mt7921_phy {
 	struct mt76_phy *mt76;
 	struct mt7921_dev *dev;
 
-	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
+	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 
 	u32 rxfilter;
 	u64 omac_mask;
-- 
2.31.1

