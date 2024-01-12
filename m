Return-Path: <linux-wireless+bounces-1786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B9682BB40
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 07:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFD01C24FC3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497C5C8F1;
	Fri, 12 Jan 2024 06:27:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131D1B28E
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C6R4ozC2173897, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C6R4ozC2173897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:27:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 12 Jan 2024 14:27:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 14:27:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: adjust init_he_cap() to add EHT cap into iftype_data
Date: Fri, 12 Jan 2024 14:26:37 +0800
Message-ID: <20240112062640.36922-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112062640.36922-1-pkshih@realtek.com>
References: <20240112062640.36922-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

EHT capabilities are also stored in struct ieee80211_sband_iftype_data, so
adjust allocation of iftype_data as common part named init_he_eht_cap(),
and then init_eht_cap() can be added later. Don't change logic at all
by this patch.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 216 +++++++++++-----------
 1 file changed, 113 insertions(+), 103 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index fd527a249996..c8d2492d98bd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3649,25 +3649,21 @@ static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
 	vht_cap->vht_mcs.tx_highest = highest[hal->tx_nss - 1];
 }
 
-#define RTW89_SBAND_IFTYPES_NR 2
-
 static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 			      enum nl80211_band band,
-			      struct ieee80211_supported_band *sband)
+			      enum nl80211_iftype iftype,
+			      struct ieee80211_sband_iftype_data *iftype_data)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct ieee80211_sband_iftype_data *iftype_data;
 	bool no_ng16 = (chip->chip_id == RTL8852A && hal->cv == CHIP_CBV) ||
 		       (chip->chip_id == RTL8852B && hal->cv == CHIP_CAV);
+	struct ieee80211_sta_he_cap *he_cap;
+	int nss = hal->rx_nss;
+	u8 *mac_cap_info;
+	u8 *phy_cap_info;
 	u16 mcs_map = 0;
 	int i;
-	int nss = hal->rx_nss;
-	int idx = 0;
-
-	iftype_data = kcalloc(RTW89_SBAND_IFTYPES_NR, sizeof(*iftype_data), GFP_KERNEL);
-	if (!iftype_data)
-		return;
 
 	for (i = 0; i < 8; i++) {
 		if (i < nss)
@@ -3676,12 +3672,109 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 			mcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
-	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
-		struct ieee80211_sta_he_cap *he_cap;
-		u8 *mac_cap_info;
-		u8 *phy_cap_info;
+	he_cap = &iftype_data->he_cap;
+	mac_cap_info = he_cap->he_cap_elem.mac_cap_info;
+	phy_cap_info = he_cap->he_cap_elem.phy_cap_info;
+
+	he_cap->has_he = true;
+	mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE;
+	if (iftype == NL80211_IFTYPE_STATION)
+		mac_cap_info[1] = IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+	mac_cap_info[2] = IEEE80211_HE_MAC_CAP2_ALL_ACK |
+			  IEEE80211_HE_MAC_CAP2_BSR;
+	mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2;
+	if (iftype == NL80211_IFTYPE_AP)
+		mac_cap_info[3] |= IEEE80211_HE_MAC_CAP3_OMI_CONTROL;
+	mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_OPS |
+			  IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+	if (iftype == NL80211_IFTYPE_STATION)
+		mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
+	if (band == NL80211_BAND_2GHZ) {
+		phy_cap_info[0] =
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+	} else {
+		phy_cap_info[0] =
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+		if (chip->support_bw160)
+			phy_cap_info[0] |= IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	}
+	phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+			  IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
+			  IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+	phy_cap_info[2] = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+			  IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			  IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+			  IEEE80211_HE_PHY_CAP2_DOPPLER_TX;
+	phy_cap_info[3] = IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_16_QAM;
+	if (iftype == NL80211_IFTYPE_STATION)
+		phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_16_QAM |
+				   IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_2;
+	if (iftype == NL80211_IFTYPE_AP)
+		phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU;
+	phy_cap_info[4] = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+			  IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
+	if (chip->support_bw160)
+		phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+	phy_cap_info[5] = no_ng16 ? 0 :
+			  IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+			  IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+	phy_cap_info[6] = IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+			  IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+			  IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+			  IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE;
+	phy_cap_info[7] = IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+			  IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
+			  IEEE80211_HE_PHY_CAP7_MAX_NC_1;
+	phy_cap_info[8] = IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
+			  IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI |
+			  IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_996;
+	if (chip->support_bw160)
+		phy_cap_info[8] |= IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+				   IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
+	phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+			  IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+			  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+			  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
+			  u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+					 IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+	if (iftype == NL80211_IFTYPE_STATION)
+		phy_cap_info[9] |= IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
+	he_cap->he_mcs_nss_supp.rx_mcs_80 = cpu_to_le16(mcs_map);
+	he_cap->he_mcs_nss_supp.tx_mcs_80 = cpu_to_le16(mcs_map);
+	if (chip->support_bw160) {
+		he_cap->he_mcs_nss_supp.rx_mcs_160 = cpu_to_le16(mcs_map);
+		he_cap->he_mcs_nss_supp.tx_mcs_160 = cpu_to_le16(mcs_map);
+	}
+
+	if (band == NL80211_BAND_6GHZ) {
+		__le16 capa;
 
-		switch (i) {
+		capa = le16_encode_bits(IEEE80211_HT_MPDU_DENSITY_NONE,
+					IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
+		       le16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
+					IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
+		       le16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+					IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+		iftype_data->he_6ghz_capa.capa = capa;
+	}
+}
+
+#define RTW89_SBAND_IFTYPES_NR 2
+
+static void rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
+				  enum nl80211_band band,
+				  struct ieee80211_supported_band *sband)
+{
+	struct ieee80211_sband_iftype_data *iftype_data;
+	enum nl80211_iftype iftype;
+	int idx = 0;
+
+	iftype_data = kcalloc(RTW89_SBAND_IFTYPES_NR, sizeof(*iftype_data), GFP_KERNEL);
+	if (!iftype_data)
+		return;
+
+	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
+		switch (iftype) {
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_AP:
 			break;
@@ -3694,92 +3787,9 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 			break;
 		}
 
-		iftype_data[idx].types_mask = BIT(i);
-		he_cap = &iftype_data[idx].he_cap;
-		mac_cap_info = he_cap->he_cap_elem.mac_cap_info;
-		phy_cap_info = he_cap->he_cap_elem.phy_cap_info;
-
-		he_cap->has_he = true;
-		mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE;
-		if (i == NL80211_IFTYPE_STATION)
-			mac_cap_info[1] = IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
-		mac_cap_info[2] = IEEE80211_HE_MAC_CAP2_ALL_ACK |
-				  IEEE80211_HE_MAC_CAP2_BSR;
-		mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2;
-		if (i == NL80211_IFTYPE_AP)
-			mac_cap_info[3] |= IEEE80211_HE_MAC_CAP3_OMI_CONTROL;
-		mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_OPS |
-				  IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
-		if (i == NL80211_IFTYPE_STATION)
-			mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
-		if (band == NL80211_BAND_2GHZ) {
-			phy_cap_info[0] =
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
-		} else {
-			phy_cap_info[0] =
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
-			if (chip->support_bw160)
-				phy_cap_info[0] |= IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-		}
-		phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
-				  IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
-				  IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
-		phy_cap_info[2] = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
-				  IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
-				  IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
-				  IEEE80211_HE_PHY_CAP2_DOPPLER_TX;
-		phy_cap_info[3] = IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_16_QAM;
-		if (i == NL80211_IFTYPE_STATION)
-			phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_16_QAM |
-					   IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_2;
-		if (i == NL80211_IFTYPE_AP)
-			phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU;
-		phy_cap_info[4] = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
-				  IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
-		if (chip->support_bw160)
-			phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
-		phy_cap_info[5] = no_ng16 ? 0 :
-				  IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
-				  IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
-		phy_cap_info[6] = IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
-				  IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
-				  IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
-				  IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE;
-		phy_cap_info[7] = IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
-				  IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
-				  IEEE80211_HE_PHY_CAP7_MAX_NC_1;
-		phy_cap_info[8] = IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
-				  IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI |
-				  IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_996;
-		if (chip->support_bw160)
-			phy_cap_info[8] |= IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
-					   IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
-		phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
-				  IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
-				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
-				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
-				  u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
-						 IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
-		if (i == NL80211_IFTYPE_STATION)
-			phy_cap_info[9] |= IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
-		he_cap->he_mcs_nss_supp.rx_mcs_80 = cpu_to_le16(mcs_map);
-		he_cap->he_mcs_nss_supp.tx_mcs_80 = cpu_to_le16(mcs_map);
-		if (chip->support_bw160) {
-			he_cap->he_mcs_nss_supp.rx_mcs_160 = cpu_to_le16(mcs_map);
-			he_cap->he_mcs_nss_supp.tx_mcs_160 = cpu_to_le16(mcs_map);
-		}
+		iftype_data[idx].types_mask = BIT(iftype);
 
-		if (band == NL80211_BAND_6GHZ) {
-			__le16 capa;
-
-			capa = le16_encode_bits(IEEE80211_HT_MPDU_DENSITY_NONE,
-						IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
-			       le16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
-						IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
-			       le16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
-						IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
-			iftype_data[idx].he_6ghz_capa.capa = capa;
-		}
+		rtw89_init_he_cap(rtwdev, band, iftype, &iftype_data[idx]);
 
 		idx++;
 	}
@@ -3800,7 +3810,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 		if (!sband_2ghz)
 			goto err;
 		rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
-		rtw89_init_he_cap(rtwdev, NL80211_BAND_2GHZ, sband_2ghz);
+		rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_2GHZ, sband_2ghz);
 		hw->wiphy->bands[NL80211_BAND_2GHZ] = sband_2ghz;
 	}
 
@@ -3810,7 +3820,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 			goto err;
 		rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
 		rtw89_init_vht_cap(rtwdev, &sband_5ghz->vht_cap);
-		rtw89_init_he_cap(rtwdev, NL80211_BAND_5GHZ, sband_5ghz);
+		rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_5GHZ, sband_5ghz);
 		hw->wiphy->bands[NL80211_BAND_5GHZ] = sband_5ghz;
 	}
 
@@ -3818,7 +3828,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 		sband_6ghz = kmemdup(&rtw89_sband_6ghz, size, GFP_KERNEL);
 		if (!sband_6ghz)
 			goto err;
-		rtw89_init_he_cap(rtwdev, NL80211_BAND_6GHZ, sband_6ghz);
+		rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_6GHZ, sband_6ghz);
 		hw->wiphy->bands[NL80211_BAND_6GHZ] = sband_6ghz;
 	}
 
-- 
2.25.1


