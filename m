Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F05B13DF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 07:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIHFNo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 01:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIHFNm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 01:13:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5FB3B6D4D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 22:13:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2885DAXZ0009404, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2885DAXZ0009404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 13:13:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Sep 2022 13:13:28 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 13:13:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <echuang@realtek.com>,
        <phhuang@realtek.com>, <chiuyitang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/9] wifi: rtw89: add DIG register struct to share common algorithm
Date:   Thu, 8 Sep 2022 13:12:49 +0800
Message-ID: <20220908051257.25353-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908051257.25353-1-pkshih@realtek.com>
References: <20220908051257.25353-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/08/2022 04:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvOCCkV6TIIDEyOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

Since control register address for DIG are different per IC, add a new
struct rtw89_dig_regs in chip info for each IC to define their own address.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 17 ++++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 59 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/reg.h      | 20 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 21 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 21 +++++++
 5 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b5fa61eb24f06..ac148c4b547c8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2550,6 +2550,22 @@ struct rtw89_imr_info {
 	u32 tmac_imr_set;
 };
 
+struct rtw89_dig_regs {
+	u32 seg0_pd_reg;
+	u32 pd_lower_bound_mask;
+	u32 pd_spatial_reuse_en;
+	struct rtw89_reg_def p0_lna_init;
+	struct rtw89_reg_def p1_lna_init;
+	struct rtw89_reg_def p0_tia_init;
+	struct rtw89_reg_def p1_tia_init;
+	struct rtw89_reg_def p0_rxb_init;
+	struct rtw89_reg_def p1_rxb_init;
+	struct rtw89_reg_def p0_p20_pagcugc_en;
+	struct rtw89_reg_def p0_s20_pagcugc_en;
+	struct rtw89_reg_def p1_p20_pagcugc_en;
+	struct rtw89_reg_def p1_s20_pagcugc_en;
+};
+
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	const struct rtw89_chip_ops *ops;
@@ -2592,6 +2608,7 @@ struct rtw89_chip_info {
 	const struct rtw89_phy_table *nctl_table;
 	const struct rtw89_txpwr_table *byr_table;
 	const struct rtw89_phy_dig_gain_table *dig_table;
+	const struct rtw89_dig_regs *dig_regs;
 	const struct rtw89_phy_tssi_dbw_table *tssi_dbw_table;
 	const s8 (*txpwr_lmt_2g)[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a2ebef0051b83..b381213329556 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3465,26 +3465,32 @@ static void rtw89_phy_dig_igi_offset_by_env(struct rtw89_dev *rtwdev)
 
 static void rtw89_phy_dig_set_lna_idx(struct rtw89_dev *rtwdev, u8 lna_idx)
 {
-	rtw89_phy_write32_mask(rtwdev, R_PATH0_LNA_INIT,
-			       B_PATH0_LNA_INIT_IDX_MSK, lna_idx);
-	rtw89_phy_write32_mask(rtwdev, R_PATH1_LNA_INIT,
-			       B_PATH1_LNA_INIT_IDX_MSK, lna_idx);
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
+
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_lna_init.addr,
+			       dig_regs->p0_lna_init.mask, lna_idx);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_lna_init.addr,
+			       dig_regs->p1_lna_init.mask, lna_idx);
 }
 
 static void rtw89_phy_dig_set_tia_idx(struct rtw89_dev *rtwdev, u8 tia_idx)
 {
-	rtw89_phy_write32_mask(rtwdev, R_PATH0_TIA_INIT,
-			       B_PATH0_TIA_INIT_IDX_MSK, tia_idx);
-	rtw89_phy_write32_mask(rtwdev, R_PATH1_TIA_INIT,
-			       B_PATH1_TIA_INIT_IDX_MSK, tia_idx);
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
+
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_tia_init.addr,
+			       dig_regs->p0_tia_init.mask, tia_idx);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_tia_init.addr,
+			       dig_regs->p1_tia_init.mask, tia_idx);
 }
 
 static void rtw89_phy_dig_set_rxb_idx(struct rtw89_dev *rtwdev, u8 rxb_idx)
 {
-	rtw89_phy_write32_mask(rtwdev, R_PATH0_RXB_INIT,
-			       B_PATH0_RXB_INIT_IDX_MSK, rxb_idx);
-	rtw89_phy_write32_mask(rtwdev, R_PATH1_RXB_INIT,
-			       B_PATH1_RXB_INIT_IDX_MSK, rxb_idx);
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
+
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_rxb_init.addr,
+			       dig_regs->p0_rxb_init.mask, rxb_idx);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_rxb_init.addr,
+			       dig_regs->p1_rxb_init.mask, rxb_idx);
 }
 
 static void rtw89_phy_dig_set_igi_cr(struct rtw89_dev *rtwdev,
@@ -3498,21 +3504,19 @@ static void rtw89_phy_dig_set_igi_cr(struct rtw89_dev *rtwdev,
 		    set.lna_idx, set.tia_idx, set.rxb_idx);
 }
 
-static const struct rtw89_reg_def sdagc_config[4] = {
-	{R_PATH0_P20_FOLLOW_BY_PAGCUGC, B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
-	{R_PATH0_S20_FOLLOW_BY_PAGCUGC, B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
-	{R_PATH1_P20_FOLLOW_BY_PAGCUGC, B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
-	{R_PATH1_S20_FOLLOW_BY_PAGCUGC, B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
-};
-
 static void rtw89_phy_dig_sdagc_follow_pagc_config(struct rtw89_dev *rtwdev,
 						   bool enable)
 {
-	u8 i = 0;
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 
-	for (i = 0; i < ARRAY_SIZE(sdagc_config); i++)
-		rtw89_phy_write32_mask(rtwdev, sdagc_config[i].addr,
-				       sdagc_config[i].mask, enable);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_p20_pagcugc_en.addr,
+			       dig_regs->p0_p20_pagcugc_en.mask, enable);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_s20_pagcugc_en.addr,
+			       dig_regs->p0_s20_pagcugc_en.mask, enable);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_p20_pagcugc_en.addr,
+			       dig_regs->p1_p20_pagcugc_en.mask, enable);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_s20_pagcugc_en.addr,
+			       dig_regs->p1_s20_pagcugc_en.mask, enable);
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG, "sdagc_follow_pagc=%d\n", enable);
 }
@@ -3539,6 +3543,7 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 				    bool enable)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 	enum rtw89_bandwidth cbw = chan->band_width;
 	struct rtw89_dig_info *dig = &rtwdev->dig;
 	u8 final_rssi = 0, under_region = dig->pd_low_th_ofst;
@@ -3581,10 +3586,10 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 			    "Dynamic PD th disabled, Set PD_low_bd=0\n");
 	}
 
-	rtw89_phy_write32_mask(rtwdev, R_SEG0R_PD, B_SEG0R_PD_LOWER_BOUND_MSK,
-			       pd_val);
-	rtw89_phy_write32_mask(rtwdev, R_SEG0R_PD,
-			       B_SEG0R_PD_SPATIAL_REUSE_EN_MSK, enable);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->seg0_pd_reg,
+			       dig_regs->pd_lower_bound_mask, pd_val);
+	rtw89_phy_write32_mask(rtwdev, dig_regs->seg0_pd_reg,
+			       dig_regs->pd_spatial_reuse_en, enable);
 
 	if (!rtwdev->hal.support_cckpd)
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 38139fff03475..d75894895dc7b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3756,15 +3756,22 @@
 #define R_PATH0_RXB_INIT 0x4658
 #define B_PATH0_RXB_INIT_IDX_MSK GENMASK(9, 5)
 #define R_PATH0_LNA_INIT 0x4668
+#define R_PATH0_LNA_INIT_V1 0x472C
 #define B_PATH0_LNA_INIT_IDX_MSK GENMASK(26, 24)
 #define R_PATH0_BTG 0x466C
 #define B_PATH0_BTG_SHEN GENMASK(18, 17)
 #define R_PATH0_TIA_INIT 0x4674
 #define B_PATH0_TIA_INIT_IDX_MSK BIT(17)
 #define R_PATH0_P20_FOLLOW_BY_PAGCUGC 0x46A0
+#define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V1 0x4C24
+#define R_PATH0_P20_FOLLOW_BY_PAGCUGC_V2 0x46E8
 #define B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH0_S20_FOLLOW_BY_PAGCUGC 0x46A4
+#define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V1 0x4C28
+#define R_PATH0_S20_FOLLOW_BY_PAGCUGC_V2 0x46EC
 #define B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
+#define R_PATH0_RXB_INIT_V1 0x46A8
+#define B_PATH0_RXB_INIT_IDX_MSK_V1 GENMASK(14, 10)
 #define R_PATH0_G_LNA6_OP1DB_V1 0x4688
 #define B_PATH0_G_LNA6_OP1DB_V1 GENMASK(31, 24)
 #define R_PATH0_G_TIA0_LNA6_OP1DB_V1 0x4694
@@ -3791,7 +3798,10 @@
 #define R_P0_AGC_CTL 0x4730
 #define B_P0_AGC_EN BIT(31)
 #define R_PATH1_LNA_INIT 0x473C
+#define R_PATH1_LNA_INIT_V1 0x4A80
 #define B_PATH1_LNA_INIT_IDX_MSK GENMASK(26, 24)
+#define R_PATH0_TIA_INIT_V1 0x473C
+#define B_PATH0_TIA_INIT_IDX_MSK_V1 BIT(9)
 #define R_PATH1_TIA_INIT 0x4748
 #define B_PATH1_TIA_INIT_IDX_MSK BIT(17)
 #define R_PATH1_BTG 0x4740
@@ -3801,8 +3811,12 @@
 #define R_PATH1_G_LNA6_OP1DB_V1 0x476C
 #define B_PATH1_G_LNA6_OP1DB_V1 GENMASK(31, 24)
 #define R_PATH1_P20_FOLLOW_BY_PAGCUGC 0x4774
+#define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V1 0x4CE8
+#define R_PATH1_P20_FOLLOW_BY_PAGCUGC_V2 0x47A8
 #define B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH1_S20_FOLLOW_BY_PAGCUGC 0x4778
+#define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V1 0x4CEC
+#define R_PATH1_S20_FOLLOW_BY_PAGCUGC_V2 0x47AC
 #define B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK BIT(5)
 #define R_PATH1_G_TIA0_LNA6_OP1DB_V1 0x4778
 #define B_PATH1_G_TIA0_LNA6_OP1DB_V1 GENMASK(7, 0)
@@ -3818,6 +3832,8 @@
 #define B_P1_NBIIDX_VAL GENMASK(11, 0)
 #define B_P1_NBIIDX_NOTCH_EN BIT(12)
 #define R_SEG0R_PD 0x481C
+#define R_SEG0R_PD_V1 0x4860
+#define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1 BIT(30)
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK BIT(29)
 #define B_SEG0R_PD_LOWER_BOUND_MSK GENMASK(10, 6)
 #define R_2P4G_BAND 0x4970
@@ -3841,8 +3857,12 @@
 #define B_BK_FC0_INV_MSK_V1 GENMASK(18, 0)
 #define R_CCK_FC0_INV_V1 0x4A20
 #define B_CCK_FC0_INV_MSK_V1 GENMASK(18, 0)
+#define R_PATH1_RXB_INIT_V1 0x4A5C
+#define B_PATH1_RXB_INIT_IDX_MSK_V1 GENMASK(14, 10)
 #define R_P1_AGC_CTL 0x4A9C
 #define B_P1_AGC_EN BIT(31)
+#define R_PATH1_TIA_INIT_V1 0x4AA8
+#define B_PATH1_TIA_INIT_IDX_MSK_V1 BIT(9)
 #define R_PATH0_RXBB_V1 0x4AD4
 #define B_PATH0_RXBB_MSK_V1 GENMASK(31, 0)
 #define R_PATH1_RXBB_V1 0x4AE0
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c872c8bfb33df..6cdecd833afbc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -453,6 +453,26 @@ static const struct rtw89_imr_info rtw8852a_imr_info = {
 	.tmac_imr_set		= B_AX_TMAC_IMR_SET,
 };
 
+static const struct rtw89_dig_regs rtw8852a_dig_regs = {
+	.seg0_pd_reg = R_SEG0R_PD,
+	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
+	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK,
+	.p0_lna_init = {R_PATH0_LNA_INIT, B_PATH0_LNA_INIT_IDX_MSK},
+	.p1_lna_init = {R_PATH1_LNA_INIT, B_PATH1_LNA_INIT_IDX_MSK},
+	.p0_tia_init = {R_PATH0_TIA_INIT, B_PATH0_TIA_INIT_IDX_MSK},
+	.p1_tia_init = {R_PATH1_TIA_INIT, B_PATH1_TIA_INIT_IDX_MSK},
+	.p0_rxb_init = {R_PATH0_RXB_INIT, B_PATH0_RXB_INIT_IDX_MSK},
+	.p1_rxb_init = {R_PATH1_RXB_INIT, B_PATH1_RXB_INIT_IDX_MSK},
+	.p0_p20_pagcugc_en = {R_PATH0_P20_FOLLOW_BY_PAGCUGC,
+			      B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p0_s20_pagcugc_en = {R_PATH0_S20_FOLLOW_BY_PAGCUGC,
+			      B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_p20_pagcugc_en = {R_PATH1_P20_FOLLOW_BY_PAGCUGC,
+			      B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_s20_pagcugc_en = {R_PATH1_S20_FOLLOW_BY_PAGCUGC,
+			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+};
+
 static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
 				    struct rtw8852a_efuse *map)
 {
@@ -2136,6 +2156,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
+	.dig_regs		= &rtw8852a_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_chanctx_num	= 1,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ac025618374f3..32f5077c1bcb6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -131,6 +131,26 @@ static const struct rtw89_imr_info rtw8852c_imr_info = {
 	.tmac_imr_set		= B_AX_TMAC_IMR_SET_V1,
 };
 
+static const struct rtw89_dig_regs rtw8852c_dig_regs = {
+	.seg0_pd_reg = R_SEG0R_PD,
+	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
+	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK,
+	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
+	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
+	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
+	.p1_tia_init = {R_PATH1_TIA_INIT_V1, B_PATH1_TIA_INIT_IDX_MSK_V1},
+	.p0_rxb_init = {R_PATH0_RXB_INIT_V1, B_PATH0_RXB_INIT_IDX_MSK_V1},
+	.p1_rxb_init = {R_PATH1_RXB_INIT_V1, B_PATH1_RXB_INIT_IDX_MSK_V1},
+	.p0_p20_pagcugc_en = {R_PATH0_P20_FOLLOW_BY_PAGCUGC_V1,
+			      B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p0_s20_pagcugc_en = {R_PATH0_S20_FOLLOW_BY_PAGCUGC_V1,
+			      B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_p20_pagcugc_en = {R_PATH1_P20_FOLLOW_BY_PAGCUGC_V1,
+			      B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_s20_pagcugc_en = {R_PATH1_S20_FOLLOW_BY_PAGCUGC_V1,
+			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+};
+
 static void rtw8852c_ctrl_btg(struct rtw89_dev *rtwdev, bool btg);
 
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
@@ -2967,6 +2987,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
+	.dig_regs		= &rtw8852c_dig_regs,
 	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
 	.support_chanctx_num	= 1,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
-- 
2.25.1

