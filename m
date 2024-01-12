Return-Path: <linux-wireless+bounces-1787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F282BB41
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 07:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3EB1F2576A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 06:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D95B5D8;
	Fri, 12 Jan 2024 06:27:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D501B28E
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C6R7kN42173900, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C6R7kN42173900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:27:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 12 Jan 2024 14:27:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jan
 2024 14:27:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: change supported bandwidths of chip_info to bit mask
Date: Fri, 12 Jan 2024 14:26:38 +0800
Message-ID: <20240112062640.36922-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Basically, all chips can support 20/40/80MHz bandwidth, and 8952C can
support 160MHz bandwidth, which is why we introduced support_bw160 before.
The coming WiFi 7 chips will support 320MHz optionally, so change it to
bit mask instead of adding another support_bw320.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 13 +++++++------
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  5 ++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  4 ++++
 7 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c8d2492d98bd..7a702e58670a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3611,7 +3611,8 @@ static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
 		cpu_to_le16(867), cpu_to_le16(1733), cpu_to_le16(2600), cpu_to_le16(3467),
 	};
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const __le16 *highest = chip->support_bw160 ? highest_bw160 : highest_bw80;
+	const __le16 *highest = chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160) ?
+				highest_bw160 : highest_bw80;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u16 tx_mcs_map = 0, rx_mcs_map = 0;
 	u8 sts_cap = 3;
@@ -3640,7 +3641,7 @@ static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
 	vht_cap->cap |= IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
 			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE;
 	vht_cap->cap |= sts_cap << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
-	if (chip->support_bw160)
+	if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160))
 		vht_cap->cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
 				IEEE80211_VHT_CAP_SHORT_GI_160;
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(rx_mcs_map);
@@ -3695,7 +3696,7 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 	} else {
 		phy_cap_info[0] =
 			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
-		if (chip->support_bw160)
+		if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160))
 			phy_cap_info[0] |= IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 	}
 	phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -3713,7 +3714,7 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 		phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU;
 	phy_cap_info[4] = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
 			  IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
-	if (chip->support_bw160)
+	if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160))
 		phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
 	phy_cap_info[5] = no_ng16 ? 0 :
 			  IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
@@ -3728,7 +3729,7 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 	phy_cap_info[8] = IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
 			  IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI |
 			  IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_996;
-	if (chip->support_bw160)
+	if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160))
 		phy_cap_info[8] |= IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
 				   IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
 	phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
@@ -3741,7 +3742,7 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 		phy_cap_info[9] |= IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
 	he_cap->he_mcs_nss_supp.rx_mcs_80 = cpu_to_le16(mcs_map);
 	he_cap->he_mcs_nss_supp.tx_mcs_80 = cpu_to_le16(mcs_map);
-	if (chip->support_bw160) {
+	if (chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_160)) {
 		he_cap->he_mcs_nss_supp.rx_mcs_160 = cpu_to_le16(mcs_map);
 		he_cap->he_mcs_nss_supp.tx_mcs_160 = cpu_to_le16(mcs_map);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 662425ba395b..4fcdeedd5ee1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3714,7 +3714,7 @@ struct rtw89_chip_info {
 	u32 rf_base_addr[2];
 	u8 support_chanctx_num;
 	u8 support_bands;
-	bool support_bw160;
+	u16 support_bandwidths;
 	bool support_unii4;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index b5cf093146cb..64571f339aba 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2394,7 +2394,9 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_chanctx_num	= 0,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
-	.support_bw160		= false,
+	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
+				  BIT(NL80211_CHAN_WIDTH_40) |
+				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0c76c52ce22c..c8bcf2d1ec7d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2130,7 +2130,9 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_chanctx_num	= 1,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
-	.support_bw160		= false,
+	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
+				  BIT(NL80211_CHAN_WIDTH_40) |
+				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index ab60cc11a385..5424b64891b6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2564,7 +2564,9 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_chanctx_num	= 0,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
-	.support_bw160		= false,
+	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
+				  BIT(NL80211_CHAN_WIDTH_40) |
+				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9a9b7103caeb..ce22ec308ad3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2902,7 +2902,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
-	.support_bw160		= true,
+	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
+				  BIT(NL80211_CHAN_WIDTH_40) |
+				  BIT(NL80211_CHAN_WIDTH_80) |
+				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 070d0c716659..8c4a2590db22 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -864,6 +864,10 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
+	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
+				  BIT(NL80211_CHAN_WIDTH_40) |
+				  BIT(NL80211_CHAN_WIDTH_80) |
+				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
-- 
2.25.1


