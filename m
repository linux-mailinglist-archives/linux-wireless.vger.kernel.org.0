Return-Path: <linux-wireless+bounces-1512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C83824EB9
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151611F22CC6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B11F951;
	Fri,  5 Jan 2024 06:43:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B71DDCA
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056gl7N32200586, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056gl7N32200586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:42:47 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 Jan 2024 14:42:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:42:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: 8922a: update the register used in DIG and the DIG flow
Date: Fri, 5 Jan 2024 14:42:24 +0800
Message-ID: <20240105064228.36580-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105064228.36580-1-pkshih@realtek.com>
References: <20240105064228.36580-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>

DIG standing for dynamic initial gain that is used to adjust RX coverage,
and PD lower threshold is packet detection power level by received signal
strength to avoid false detection of the WiFi packet.

Because of the hardware is different between WiFi 7 and 6 ICs, we adjust
flow and add register definition for 8922A.

Signed-off-by: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      |  6 ++++-
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 +++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 25 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5e65d1e9a2c8..37fc1a7e888f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4551,6 +4551,9 @@ static void rtw89_phy_dig_set_rxb_idx(struct rtw89_dev *rtwdev, u8 rxb_idx)
 static void rtw89_phy_dig_set_igi_cr(struct rtw89_dev *rtwdev,
 				     const struct rtw89_agc_gaincode_set set)
 {
+	if (!rtwdev->hal.support_igi)
+		return;
+
 	rtw89_phy_dig_set_lna_idx(rtwdev, set.lna_idx);
 	rtw89_phy_dig_set_tia_idx(rtwdev, set.tia_idx);
 	rtw89_phy_dig_set_rxb_idx(rtwdev, set.rxb_idx);
@@ -4606,7 +4609,8 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 	s8 cck_cca_th;
 	u32 pd_val = 0;
 
-	under_region += PD_TH_SB_FLTR_CMP_VAL;
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
+		under_region += PD_TH_SB_FLTR_CMP_VAL;
 
 	switch (cbw) {
 	case RTW89_CHANNEL_WIDTH_40:
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 8456e2b0c14f..61ba52d5990e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7910,10 +7910,12 @@
 #define R_PATH0_P20_FOLLOW_BY_PAGCUGC 0x46A0
 #define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V1 0x4C24
 #define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V2 0x46E8
+#define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V3 0x41C8
 #define B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC 0x46A4
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V1 0x4C28
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V2 0x46EC
+#define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V3 0x41CC
 #define B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH0_RXB_INIT_V1 0x46A8
 #define B_PATH0_RXB_INIT_IDX_MSK_V1 GENMASK(14, 10)
@@ -7958,10 +7960,12 @@
 #define R_PATH1_P20_FOLLOW_BY_PAGCUGC 0x4774
 #define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V1 0x4CE8
 #define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V2 0x47A8
+#define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V3 0x45C8
 #define B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC 0x4778
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V1 0x4CEC
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V2 0x47AC
+#define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V3 0x45CC
 #define B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH1_G_TIA0_LNA6_OP1DB_V1 0x4778
 #define B_PATH1_G_TIA0_LNA6_OP1DB_V1 GENMASK(7, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 717e42be6793..070d0c716659 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -119,6 +119,30 @@ static const struct rtw89_imr_table rtw8922a_imr_cmac_table = {
 	.n_regs = ARRAY_SIZE(rtw8922a_imr_cmac_regs),
 };
 
+static const struct rtw89_dig_regs rtw8922a_dig_regs = {
+	.seg0_pd_reg = R_SEG0R_PD_V2,
+	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
+	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1,
+	.bmode_pd_reg = R_BMODE_PDTH_EN_V2,
+	.bmode_cca_rssi_limit_en = B_BMODE_PDTH_LIMIT_EN_MSK_V1,
+	.bmode_pd_lower_bound_reg = R_BMODE_PDTH_V2,
+	.bmode_rssi_nocca_low_th_mask = B_BMODE_PDTH_LOWER_BOUND_MSK_V1,
+	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
+	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
+	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
+	.p1_tia_init = {R_PATH1_TIA_INIT_V1, B_PATH1_TIA_INIT_IDX_MSK_V1},
+	.p0_rxb_init = {R_PATH0_RXB_INIT_V1, B_PATH0_RXB_INIT_IDX_MSK_V1},
+	.p1_rxb_init = {R_PATH1_RXB_INIT_V1, B_PATH1_RXB_INIT_IDX_MSK_V1},
+	.p0_p20_pagcugc_en = {R_PATH0_P20_FOLLOW_BY_PAGCUGC_V3,
+			      B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p0_s20_pagcugc_en = {R_PATH0_S20_FOLLOW_BY_PAGCUGC_V3,
+			      B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_p20_pagcugc_en = {R_PATH1_P20_FOLLOW_BY_PAGCUGC_V3,
+			      B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_s20_pagcugc_en = {R_PATH1_S20_FOLLOW_BY_PAGCUGC_V3,
+			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+};
+
 static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_SYS]			= {.offset = 0x00000, .size = 0x310},
 	[RTW89_EFUSE_BLOCK_RF]			= {.offset = 0x10000, .size = 0x240},
@@ -834,6 +858,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
+	.dig_regs		= &rtw8922a_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_chanctx_num	= 1,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
-- 
2.25.1


