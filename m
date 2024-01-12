Return-Path: <linux-wireless+bounces-1788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AC82BB42
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 07:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00473B24AED
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A85C8E7;
	Fri, 12 Jan 2024 06:27:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994D1B28E
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C6RCwkC2173918, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C6RCwkC2173918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:27:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 12 Jan 2024 14:27:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 14:27:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: add EHT capabilities for WiFi 7 chips
Date: Fri, 12 Jan 2024 14:26:39 +0800
Message-ID: <20240112062640.36922-4-pkshih@realtek.com>
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

The coming WiFi 7 chip 8922A will support EHT, so declare EHT along with
hardware capabilities.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 90 +++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7a702e58670a..7f3060898ea8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3760,6 +3760,95 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
+			       enum nl80211_band band,
+			       enum nl80211_iftype iftype,
+			       struct ieee80211_sband_iftype_data *iftype_data)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem;
+	struct ieee80211_eht_mcs_nss_supp *eht_nss;
+	struct ieee80211_sta_eht_cap *eht_cap;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool support_320mhz = false;
+	int sts = 3;
+	u8 val;
+
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		return;
+
+	if (band == NL80211_BAND_6GHZ &&
+	    chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_320))
+		support_320mhz = true;
+
+	eht_cap = &iftype_data->eht_cap;
+	eht_cap_elem = &eht_cap->eht_cap_elem;
+	eht_nss = &eht_cap->eht_mcs_nss_supp;
+
+	eht_cap->has_eht = true;
+
+	eht_cap_elem->mac_cap_info[0] =
+		u8_encode_bits(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991,
+			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
+	eht_cap_elem->mac_cap_info[1] = 0;
+
+	eht_cap_elem->phy_cap_info[0] =
+		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
+		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
+	if (support_320mhz)
+		eht_cap_elem->phy_cap_info[0] |=
+			IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+
+	eht_cap_elem->phy_cap_info[0] |=
+		u8_encode_bits(u8_get_bits(sts - 1, BIT(0)),
+			       IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK);
+	eht_cap_elem->phy_cap_info[1] =
+		u8_encode_bits(u8_get_bits(sts - 1, GENMASK(2, 1)),
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK) |
+		u8_encode_bits(sts - 1,
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
+	if (support_320mhz)
+		eht_cap_elem->phy_cap_info[1] |=
+			u8_encode_bits(sts - 1,
+				       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+
+	eht_cap_elem->phy_cap_info[2] = 0;
+
+	eht_cap_elem->phy_cap_info[3] =
+		IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+		IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK;
+
+	eht_cap_elem->phy_cap_info[4] =
+		IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
+		u8_encode_bits(1, IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
+
+	eht_cap_elem->phy_cap_info[5] =
+		IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_20US,
+			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
+
+	eht_cap_elem->phy_cap_info[6] = 0;
+	eht_cap_elem->phy_cap_info[7] = 0;
+	eht_cap_elem->phy_cap_info[8] = 0;
+
+	val = u8_encode_bits(hal->rx_nss, IEEE80211_EHT_MCS_NSS_RX) |
+	      u8_encode_bits(hal->tx_nss, IEEE80211_EHT_MCS_NSS_TX);
+	eht_nss->bw._80.rx_tx_mcs9_max_nss = val;
+	eht_nss->bw._80.rx_tx_mcs11_max_nss = val;
+	eht_nss->bw._80.rx_tx_mcs13_max_nss = val;
+	eht_nss->bw._160.rx_tx_mcs9_max_nss = val;
+	eht_nss->bw._160.rx_tx_mcs11_max_nss = val;
+	eht_nss->bw._160.rx_tx_mcs13_max_nss = val;
+	if (support_320mhz) {
+		eht_nss->bw._320.rx_tx_mcs9_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs11_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs13_max_nss = val;
+	}
+}
+
 #define RTW89_SBAND_IFTYPES_NR 2
 
 static void rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
@@ -3791,6 +3880,7 @@ static void rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
 		iftype_data[idx].types_mask = BIT(iftype);
 
 		rtw89_init_he_cap(rtwdev, band, iftype, &iftype_data[idx]);
+		rtw89_init_eht_cap(rtwdev, band, iftype, &iftype_data[idx]);
 
 		idx++;
 	}
-- 
2.25.1


