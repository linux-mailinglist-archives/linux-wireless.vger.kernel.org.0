Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DB662C33
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjAIRGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjAIQ6U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F653B910
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:18 -0800 (PST)
X-UUID: 69da6ee6932549cb9c7a41c74255c2a0-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wcZrp6p93W/l9bpUulNq2/5fVebjH2RobnuR+0OEDxs=;
        b=UfGqE1jWt+TpCoo36jtnQWT5auoXnlqrZRJSeFyRTwRfZ7T2qW3qIgJrwjxFyDiNWWVyBWI+u7vCZnWpcUkOm1/F2zrUeKPPcE45thusE5r8noE6l/ar5r6Mw+rMBxZse+XkC+PdKywK8mV8tgm6pM7wrnwbtFZWNBCa7f9EOFc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:aac859e8-86f4-4bb2-8f47-19f8e82fc49d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:aac859e8-86f4-4bb2-8f47-19f8e82fc49d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:38edbb8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2301100058097E8RUKOW,BulkQuantity:2,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0,OSI:0,
        OSA:0
X-CID-BVR: 0,NGT
X-UUID: 69da6ee6932549cb9c7a41c74255c2a0-20230110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1420738047; Tue, 10 Jan 2023 00:58:06 +0800
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
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 09/13] wifi: mt76: mt7996: rework capability init
Date:   Tue, 10 Jan 2023 00:57:27 +0800
Message-ID: <20230109165731.682-10-shayne.chen@mediatek.com>
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

Rework and extract common code of capability init for the preparation of
adding EHT capability.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 296 ++++++++----------
 1 file changed, 139 insertions(+), 157 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 6bcf2649d8df..73bee7df468d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -37,8 +37,7 @@ static const struct ieee80211_iface_combination if_comb[] = {
 				       BIT(NL80211_CHAN_WIDTH_20) |
 				       BIT(NL80211_CHAN_WIDTH_40) |
 				       BIT(NL80211_CHAN_WIDTH_80) |
-				       BIT(NL80211_CHAN_WIDTH_160) |
-				       BIT(NL80211_CHAN_WIDTH_80P80),
+				       BIT(NL80211_CHAN_WIDTH_160),
 	}
 };
 
@@ -572,11 +571,15 @@ mt7996_gen_ppe_thresh(u8 *he_ppet, int nss)
 			 (0xff >> (8 - (ppet_bits - 1) % 8));
 }
 
-static int
+static void
 mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
-		    struct ieee80211_sband_iftype_data *data)
+		    struct ieee80211_sband_iftype_data *data,
+		    enum nl80211_iftype iftype)
 {
-	int i, idx = 0, nss = hweight8(phy->mt76->antenna_mask);
+	struct ieee80211_sta_he_cap *he_cap = &data->he_cap;
+	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap->he_cap_elem;
+	struct ieee80211_he_mcs_nss_supp *he_mcs = &he_cap->he_mcs_nss_supp;
+	int i, nss = hweight8(phy->mt76->antenna_mask);
 	u16 mcs_map = 0;
 
 	for (i = 0; i < 8; i++) {
@@ -586,179 +589,158 @@ mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
 			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
 	}
 
-	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
-		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
-		struct ieee80211_he_cap_elem *he_cap_elem =
-				&he_cap->he_cap_elem;
-		struct ieee80211_he_mcs_nss_supp *he_mcs =
-				&he_cap->he_mcs_nss_supp;
-
-		switch (i) {
-		case NL80211_IFTYPE_STATION:
-		case NL80211_IFTYPE_AP:
-#ifdef CONFIG_MAC80211_MESH
-		case NL80211_IFTYPE_MESH_POINT:
-#endif
-			break;
-		default:
-			continue;
-		}
+	he_cap->has_he = true;
 
-		data[idx].types_mask = BIT(i);
-		he_cap->has_he = true;
+	he_cap_elem->mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE;
+	he_cap_elem->mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+				       IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
+	he_cap_elem->mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
 
-		he_cap_elem->mac_cap_info[0] =
-			IEEE80211_HE_MAC_CAP0_HTC_HE;
-		he_cap_elem->mac_cap_info[3] =
-			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
-		he_cap_elem->mac_cap_info[4] =
-			IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+	if (band == NL80211_BAND_2GHZ)
+		he_cap_elem->phy_cap_info[0] =
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+	else
+		he_cap_elem->phy_cap_info[0] =
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+	he_cap_elem->phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+	he_cap_elem->phy_cap_info[2] = IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+				       IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+
+	switch (iftype) {
+	case NL80211_IFTYPE_AP:
+		he_cap_elem->mac_cap_info[0] |= IEEE80211_HE_MAC_CAP0_TWT_RES;
+		he_cap_elem->mac_cap_info[2] |= IEEE80211_HE_MAC_CAP2_BSR;
+		he_cap_elem->mac_cap_info[4] |= IEEE80211_HE_MAC_CAP4_BQR;
+		he_cap_elem->mac_cap_info[5] |=
+			IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+		he_cap_elem->phy_cap_info[3] |=
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+		he_cap_elem->phy_cap_info[6] |=
+			IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+		he_cap_elem->phy_cap_info[9] |=
+			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+			IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+		break;
+	case NL80211_IFTYPE_STATION:
+		he_cap_elem->mac_cap_info[1] |=
+			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
 
 		if (band == NL80211_BAND_2GHZ)
-			he_cap_elem->phy_cap_info[0] =
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+			he_cap_elem->phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
 		else
-			he_cap_elem->phy_cap_info[0] =
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+			he_cap_elem->phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] |=
+			IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+			IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+		he_cap_elem->phy_cap_info[3] |=
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+		he_cap_elem->phy_cap_info[6] |=
+			IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+			IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+		he_cap_elem->phy_cap_info[7] |=
+			IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+			IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+		he_cap_elem->phy_cap_info[8] |=
+			IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+			IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+			IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
+			IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+		he_cap_elem->phy_cap_info[9] |=
+			IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+			IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+			IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+			IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+			IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+		break;
+	default:
+		break;
+	}
 
-		he_cap_elem->phy_cap_info[1] =
-			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
-		he_cap_elem->phy_cap_info[2] =
-			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
-			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+	he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+	he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+	he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+	he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+
+	mt7996_set_stream_he_txbf_caps(phy, he_cap, iftype);
+
+	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+	if (he_cap_elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+		mt7996_gen_ppe_thresh(he_cap->ppe_thres, nss);
+	} else {
+		he_cap_elem->phy_cap_info[9] |=
+			u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+				       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+	}
 
-		switch (i) {
-		case NL80211_IFTYPE_AP:
-			he_cap_elem->mac_cap_info[0] |=
-				IEEE80211_HE_MAC_CAP0_TWT_RES;
-			he_cap_elem->mac_cap_info[2] |=
-				IEEE80211_HE_MAC_CAP2_BSR;
-			he_cap_elem->mac_cap_info[4] |=
-				IEEE80211_HE_MAC_CAP4_BQR;
-			he_cap_elem->mac_cap_info[5] |=
-				IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
-			he_cap_elem->phy_cap_info[3] |=
-				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
-				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
-			he_cap_elem->phy_cap_info[6] |=
-				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
-				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
-			he_cap_elem->phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
-				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
-			break;
-		case NL80211_IFTYPE_STATION:
-			he_cap_elem->mac_cap_info[1] |=
-				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
-
-			if (band == NL80211_BAND_2GHZ)
-				he_cap_elem->phy_cap_info[0] |=
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
-			else
-				he_cap_elem->phy_cap_info[0] |=
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
-
-			he_cap_elem->phy_cap_info[1] |=
-				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
-				IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
-			he_cap_elem->phy_cap_info[3] |=
-				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
-				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
-			he_cap_elem->phy_cap_info[6] |=
-				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
-				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
-				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
-			he_cap_elem->phy_cap_info[7] |=
-				IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
-				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
-			he_cap_elem->phy_cap_info[8] |=
-				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
-				IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
-				IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
-				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
-			he_cap_elem->phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
-				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
-				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
-				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
-				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
-				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
-			break;
-		}
+	if (band == NL80211_BAND_6GHZ) {
+		u16 cap = IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
+			  IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
 
-		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
-		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
-		he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
-		he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
-		he_mcs->rx_mcs_80p80 = cpu_to_le16(mcs_map);
-		he_mcs->tx_mcs_80p80 = cpu_to_le16(mcs_map);
-
-		mt7996_set_stream_he_txbf_caps(phy, he_cap, i);
-
-		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
-		if (he_cap_elem->phy_cap_info[6] &
-		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			mt7996_gen_ppe_thresh(he_cap->ppe_thres, nss);
-		} else {
-			he_cap_elem->phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
-		}
+		cap |= u16_encode_bits(IEEE80211_HT_MPDU_DENSITY_2,
+				       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
+		       u16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
+				       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
+		       u16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+				       IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
 
-		if (band == NL80211_BAND_6GHZ) {
-			u16 cap = IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
-				  IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+		data->he_6ghz_capa.capa = cpu_to_le16(cap);
+	}
+}
 
-			cap |= u16_encode_bits(IEEE80211_HT_MPDU_DENSITY_2,
-					       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
-			       u16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
-					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
-			       u16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
-					       IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+static void
+__mt7996_set_stream_he_caps(struct mt7996_phy *phy,
+			    struct ieee80211_supported_band *sband,
+			    enum nl80211_band band)
+{
+	struct ieee80211_sband_iftype_data *data = phy->iftype[band];
+	int i, n = 0;
 
-			data[idx].he_6ghz_capa.capa = cpu_to_le16(cap);
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+#ifdef CONFIG_MAC80211_MESH
+		case NL80211_IFTYPE_MESH_POINT:
+#endif
+			break;
+		default:
+			continue;
 		}
 
-		idx++;
+		data[n].types_mask = BIT(i);
+		mt7996_init_he_caps(phy, band, &data[n], i);
+
+		n++;
 	}
 
-	return idx;
+	sband->iftype_data = data;
+	sband->n_iftype_data = n;
 }
 
 void mt7996_set_stream_he_caps(struct mt7996_phy *phy)
 {
-	struct ieee80211_sband_iftype_data *data;
-	struct ieee80211_supported_band *band;
-	int n;
-
-	if (phy->mt76->cap.has_2ghz) {
-		data = phy->iftype[NL80211_BAND_2GHZ];
-		n = mt7996_init_he_caps(phy, NL80211_BAND_2GHZ, data);
-
-		band = &phy->mt76->sband_2g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
-	}
-
-	if (phy->mt76->cap.has_5ghz) {
-		data = phy->iftype[NL80211_BAND_5GHZ];
-		n = mt7996_init_he_caps(phy, NL80211_BAND_5GHZ, data);
-
-		band = &phy->mt76->sband_5g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
-	}
+	if (phy->mt76->cap.has_2ghz)
+		__mt7996_set_stream_he_caps(phy, &phy->mt76->sband_2g.sband,
+					    NL80211_BAND_2GHZ);
 
-	if (phy->mt76->cap.has_6ghz) {
-		data = phy->iftype[NL80211_BAND_6GHZ];
-		n = mt7996_init_he_caps(phy, NL80211_BAND_6GHZ, data);
+	if (phy->mt76->cap.has_5ghz)
+		__mt7996_set_stream_he_caps(phy, &phy->mt76->sband_5g.sband,
+					    NL80211_BAND_5GHZ);
 
-		band = &phy->mt76->sband_6g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
-	}
+	if (phy->mt76->cap.has_6ghz)
+		__mt7996_set_stream_he_caps(phy, &phy->mt76->sband_6g.sband,
+					    NL80211_BAND_6GHZ);
 }
 
 int mt7996_register_device(struct mt7996_dev *dev)
-- 
2.25.1

