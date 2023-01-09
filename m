Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43B662C2F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjAIRGp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjAIQ6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED91FE0DC
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:15 -0800 (PST)
X-UUID: 887ae1201db54188a2add77916d5e580-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SHKQIFTTLB3tWexUaoJ5ln6LATHuweK0ImnW5e4WBaQ=;
        b=RtalZnJ6e5zA+a8IyOKtY1xm+XGl2qdVMEW6izrrZj7cDGh7qX6gII6B/WMNr9faxeTPdQ4CKdCcMII2cyfrsVlFKenHI287wCz5f/Fvrp0pB99D/i3jWEEKOPAez4q/OxK8o1dw9g9cmYeuWBOqulZ8E0j18LgCPY8LEKwYrZ4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:39cce344-1e17-4136-a90a-f5a4eb548aeb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:39cce344-1e17-4136-a90a-f5a4eb548aeb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:37edbb8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2301100058097E8RUKOW,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0
X-CID-BVR: 0
X-UUID: 887ae1201db54188a2add77916d5e580-20230110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 866177584; Tue, 10 Jan 2023 00:58:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 00:58:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 10 Jan 2023 00:58:05 +0800
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
Subject: [PATCH 10/13] wifi: mt76: mt7996: add EHT capability init
Date:   Tue, 10 Jan 2023 00:57:28 +0800
Message-ID: <20230109165731.682-11-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230109165731.682-1-shayne.chen@mediatek.com>
References: <20230109165731.682-1-shayne.chen@mediatek.com>
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
index 58f9ea0125e5..a8793d5229c1 100644
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

