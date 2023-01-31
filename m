Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4710F6828FF
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjAaJgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjAaJgq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23FB2CFDA
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:44 -0800 (PST)
X-UUID: be39a5d2a14a11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ACNbbQIy6KhZd3gysisY0k4/t5d5swNS8Q/jT3WJW54=;
        b=e0khJXUnoBh33Pr6tHbM6PPCMlcD29nDZf7q4v/KZeSl6ST5U0I55zpigdLh/Y9M2uyRUuC4fBRd6bKGB2TXR7xggLvP9MPTqiyBnzrW5Bokz+9pbnX97FXZzRrHqZ7a9H/j9kf+1+RJkSHpUC685qLFhGlxmMrH5h7Urs+/tZM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:40825a1b-c72c-4e1d-b2c0-100431402dd9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:7932758d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: be39a5d2a14a11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2087916373; Tue, 31 Jan 2023 17:36:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:36:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:29 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: [PATCH v2 10/13] wifi: mt76: mt7996: add EHT capability init
Date:   Tue, 31 Jan 2023 17:36:08 +0800
Message-ID: <20230131093611.30914-11-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230131093611.30914-1-shayne.chen@mediatek.com>
References: <20230131093611.30914-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add EHT mac and phy capability init for mt7996 chipsets.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 124 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   2 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +-
 3 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 73bee7df468d..946da93eed32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -152,10 +152,12 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt76_dev *mdev = &phy->dev->mt76;
 	struct wiphy *wiphy = hw->wiphy;
+	u16 max_subframes = phy->dev->has_eht ? IEEE80211_MAX_AMPDU_BUF_EHT :
+						IEEE80211_MAX_AMPDU_BUF_HE;
 
 	hw->queues = 4;
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
-	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->max_rx_aggregation_subframes = max_subframes;
+	hw->max_tx_aggregation_subframes = max_subframes;
 	hw->netdev_features = NETIF_F_RXCSUM;
 
 	hw->radiotap_timestamp.units_pos =
@@ -213,7 +215,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7996_set_stream_vht_txbf_caps(phy);
-	mt7996_set_stream_he_caps(phy);
+	mt7996_set_stream_he_eht_caps(phy);
 
 	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
 	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
@@ -699,9 +701,104 @@ mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
 }
 
 static void
-__mt7996_set_stream_he_caps(struct mt7996_phy *phy,
-			    struct ieee80211_supported_band *sband,
-			    enum nl80211_band band)
+mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
+		     struct ieee80211_sband_iftype_data *data,
+		     enum nl80211_iftype iftype)
+{
+	struct ieee80211_sta_eht_cap *eht_cap = &data->eht_cap;
+	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem = &eht_cap->eht_cap_elem;
+	struct ieee80211_eht_mcs_nss_supp *eht_nss = &eht_cap->eht_mcs_nss_supp;
+	enum nl80211_chan_width width = phy->mt76->chandef.width;
+	int nss = hweight8(phy->mt76->antenna_mask);
+	int sts = hweight16(phy->mt76->chainmask);
+	u8 val;
+
+	if (!phy->dev->has_eht)
+		return;
+
+	eht_cap->has_eht = true;
+
+	eht_cap_elem->mac_cap_info[0] =
+		IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
+		IEEE80211_EHT_MAC_CAP0_OM_CONTROL;
+
+	eht_cap_elem->phy_cap_info[0] =
+		IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ |
+		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
+		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
+		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
+
+	eht_cap_elem->phy_cap_info[0] |=
+		u8_encode_bits(u8_get_bits(sts - 1, BIT(0)),
+			       IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK);
+
+	eht_cap_elem->phy_cap_info[1] =
+		u8_encode_bits(u8_get_bits(sts - 1, GENMASK(2, 1)),
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK) |
+		u8_encode_bits(sts - 1,
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK) |
+		u8_encode_bits(sts - 1,
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+
+	eht_cap_elem->phy_cap_info[2] =
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK) |
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK) |
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK);
+
+	eht_cap_elem->phy_cap_info[3] =
+		IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+		IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK;
+
+	eht_cap_elem->phy_cap_info[4] =
+		u8_encode_bits(min_t(int, sts - 1, 2),
+			       IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
+
+	eht_cap_elem->phy_cap_info[5] =
+		IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US,
+			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK) |
+		u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
+			       IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK);
+
+	val = width == NL80211_CHAN_WIDTH_320 ? 0xf :
+	      width == NL80211_CHAN_WIDTH_160 ? 0x7 :
+	      width == NL80211_CHAN_WIDTH_80 ? 0x3 : 0x1;
+	eht_cap_elem->phy_cap_info[6] =
+		u8_encode_bits(u8_get_bits(0x11, GENMASK(4, 2)),
+			       IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK) |
+		u8_encode_bits(val, IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK);
+
+	eht_cap_elem->phy_cap_info[7] =
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
+
+	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
+	      u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_TX);
+#define SET_EHT_MAX_NSS(_bw, _val) do {				\
+		eht_nss->bw._##_bw.rx_tx_mcs9_max_nss = _val;	\
+		eht_nss->bw._##_bw.rx_tx_mcs11_max_nss = _val;	\
+		eht_nss->bw._##_bw.rx_tx_mcs13_max_nss = _val;	\
+	} while (0)
+
+	SET_EHT_MAX_NSS(80, val);
+	SET_EHT_MAX_NSS(160, val);
+	SET_EHT_MAX_NSS(320, val);
+#undef SET_EHT_MAX_NSS
+}
+
+static void
+__mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy,
+				struct ieee80211_supported_band *sband,
+				enum nl80211_band band)
 {
 	struct ieee80211_sband_iftype_data *data = phy->iftype[band];
 	int i, n = 0;
@@ -720,6 +817,7 @@ __mt7996_set_stream_he_caps(struct mt7996_phy *phy,
 
 		data[n].types_mask = BIT(i);
 		mt7996_init_he_caps(phy, band, &data[n], i);
+		mt7996_init_eht_caps(phy, band, &data[n], i);
 
 		n++;
 	}
@@ -728,19 +826,19 @@ __mt7996_set_stream_he_caps(struct mt7996_phy *phy,
 	sband->n_iftype_data = n;
 }
 
-void mt7996_set_stream_he_caps(struct mt7996_phy *phy)
+void mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy)
 {
 	if (phy->mt76->cap.has_2ghz)
-		__mt7996_set_stream_he_caps(phy, &phy->mt76->sband_2g.sband,
-					    NL80211_BAND_2GHZ);
+		__mt7996_set_stream_he_eht_caps(phy, &phy->mt76->sband_2g.sband,
+						NL80211_BAND_2GHZ);
 
 	if (phy->mt76->cap.has_5ghz)
-		__mt7996_set_stream_he_caps(phy, &phy->mt76->sband_5g.sband,
-					    NL80211_BAND_5GHZ);
+		__mt7996_set_stream_he_eht_caps(phy, &phy->mt76->sband_5g.sband,
+						NL80211_BAND_5GHZ);
 
 	if (phy->mt76->cap.has_6ghz)
-		__mt7996_set_stream_he_caps(phy, &phy->mt76->sband_6g.sband,
-					    NL80211_BAND_6GHZ);
+		__mt7996_set_stream_he_eht_caps(phy, &phy->mt76->sband_6g.sband,
+						NL80211_BAND_6GHZ);
 }
 
 int mt7996_register_device(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 993573e0c313..3e4da0350d96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -890,7 +890,7 @@ mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7996_set_stream_vht_txbf_caps(phy);
-	mt7996_set_stream_he_caps(phy);
+	mt7996_set_stream_he_eht_caps(phy);
 
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index b919a7bc606b..179d753d7a56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -515,7 +515,7 @@ void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7996_stats_work(struct work_struct *work);
 int mt76_dfs_start_rdd(struct mt7996_dev *dev, bool force);
 int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy);
-void mt7996_set_stream_he_caps(struct mt7996_phy *phy);
+void mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy);
 void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy);
 void mt7996_update_channel(struct mt76_phy *mphy);
 int mt7996_init_debugfs(struct mt7996_phy *phy);
-- 
2.25.1

