Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA878D9D2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbjH3SeL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbjH3JaF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 05:30:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08648CCF
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 02:30:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37U9TLHw8014808, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37U9TLHw8014808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 17:29:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 30 Aug 2023 17:29:46 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 30 Aug
 2023 17:29:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: 8852c: Fix TSSI causes transmit power inaccuracy
Date:   Wed, 30 Aug 2023 17:28:49 +0800
Message-ID: <20230830092849.153251-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830092849.153251-1-pkshih@realtek.com>
References: <20230830092849.153251-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kuan-Chung Chen <damon.chen@realtek.com>

Modify TSSI ADC FIFO Clock follow RX ADC Clock can avoid
transmit power inaccuracy.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 ++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 23 +++++++++-
 .../realtek/rtw89/rtw8852c_rfk_table.c        | 42 +++++++++----------
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index f9b15a1cc790..7d25b76d90f5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4539,6 +4539,8 @@
 #define B_P0_TSSI_ALIM2 GENMASK(29, 0)
 #define R_P0_TSSI_ALIM4 0x5640
 #define R_TSSI_PA_K8 0x5644
+#define R_P0_TSSI_ADC_CLK 0x566c
+#define B_P0_TSSI_ADC_CLK GENMASK(17, 16)
 #define R_UPD_CLK 0x5670
 #define B_DAC_VAL BIT(31)
 #define B_ACK_VAL GENMASK(30, 29)
@@ -4651,6 +4653,8 @@
 #define B_P1_TSSI_ALIM31 GENMASK(9, 0)
 #define R_P1_TSSI_ALIM2 0x763c
 #define B_P1_TSSI_ALIM2 GENMASK(29, 0)
+#define R_P1_TSSI_ADC_CLK 0x766c
+#define B_P1_TSSI_ADC_CLK GENMASK(17, 16)
 #define R_P1_TSSIC 0x7814
 #define B_P1_TSSIC_BYPASS BIT(11)
 #define R_P1_TMETER 0x7810
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index de7714f871d5..7636368c8659 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -2893,18 +2893,37 @@ static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_bandwidth bw = chan->band_width;
 	enum rtw89_band band = chan->band_type;
+	u32 clk = 0x0;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_sys_defs_tbl);
 
-	if (path == RF_PATH_A)
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_80:
+		clk = 0x1;
+		break;
+	case RTW89_CHANNEL_WIDTH_80_80:
+	case RTW89_CHANNEL_WIDTH_160:
+		clk = 0x2;
+		break;
+	default:
+		break;
+	}
+
+	if (path == RF_PATH_A) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ADC_CLK,
+				       B_P0_TSSI_ADC_CLK, clk);
 		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
 					 &rtw8852c_tssi_sys_defs_2g_a_tbl,
 					 &rtw8852c_tssi_sys_defs_5g_a_tbl);
-	else
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_ADC_CLK,
+				       B_P1_TSSI_ADC_CLK, clk);
 		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
 					 &rtw8852c_tssi_sys_defs_2g_b_tbl,
 					 &rtw8852c_tssi_sys_defs_5g_b_tbl);
+	}
 }
 
 static void _tssi_ini_txpwr_ctrl_bb(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
index d727d528b365..e5b0c2a686f0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
@@ -165,11 +165,11 @@ static const struct rtw89_reg5_def rtw8852c_tssi_sys_defs[] = {
 	RTW89_DECL_RFK_WM(0x12bc, 0x000ffff0, 0xb5b5),
 	RTW89_DECL_RFK_WM(0x32bc, 0x000ffff0, 0xb5b5),
 	RTW89_DECL_RFK_WM(0x0300, 0xff000000, 0x16),
-	RTW89_DECL_RFK_WM(0x0304, 0x0000ffff, 0x1f19),
-	RTW89_DECL_RFK_WM(0x0308, 0xff000000, 0x1c),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ffff, 0x1313),
+	RTW89_DECL_RFK_WM(0x0308, 0xff000000, 0x13),
 	RTW89_DECL_RFK_WM(0x0314, 0xffff0000, 0x2041),
-	RTW89_DECL_RFK_WM(0x0318, 0xffffffff, 0x20012041),
-	RTW89_DECL_RFK_WM(0x0324, 0xffff0000, 0x2001),
+	RTW89_DECL_RFK_WM(0x0318, 0xffffffff, 0x00410041),
+	RTW89_DECL_RFK_WM(0x0324, 0xffff0000, 0x0041),
 	RTW89_DECL_RFK_WM(0x0020, 0x00006000, 0x3),
 	RTW89_DECL_RFK_WM(0x0024, 0x00006000, 0x3),
 	RTW89_DECL_RFK_WM(0x0704, 0xffff0000, 0x601e),
@@ -222,7 +222,7 @@ static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_defs_a[] = {
 	RTW89_DECL_RFK_WM(0x5810, 0xffffffff, 0x59010000),
 	RTW89_DECL_RFK_WM(0x5814, 0x01ffffff, 0x026d000),
 	RTW89_DECL_RFK_WM(0x5814, 0xf8000000, 0x00),
-	RTW89_DECL_RFK_WM(0x5818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x5818, 0xffffffff, 0x002c18e8),
 	RTW89_DECL_RFK_WM(0x581c, 0x3fffffff, 0x3dc80280),
 	RTW89_DECL_RFK_WM(0x5820, 0xffffffff, 0x00000080),
 	RTW89_DECL_RFK_WM(0x58e8, 0x0000003f, 0x03),
@@ -251,7 +251,7 @@ static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_defs_a[] = {
 	RTW89_DECL_RFK_WM(0x58d4, 0x07fc0000, 0x100),
 	RTW89_DECL_RFK_WM(0x58d8, 0xffffffff, 0x8008016c),
 	RTW89_DECL_RFK_WM(0x58dc, 0x0001ffff, 0x0807f),
-	RTW89_DECL_RFK_WM(0x58dc, 0xfff00000, 0x800),
+	RTW89_DECL_RFK_WM(0x58dc, 0xfff00000, 0xc00),
 	RTW89_DECL_RFK_WM(0x58f0, 0x0003ffff, 0x001ff),
 	RTW89_DECL_RFK_WM(0x58f4, 0x000fffff, 0x000),
 	RTW89_DECL_RFK_WM(0x58f8, 0x000fffff, 0x000),
@@ -260,14 +260,14 @@ static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_defs_a[] = {
 RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_txpwr_ctrl_bb_defs_a);
 
 static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_defs_b[] = {
-	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x766c, 0x00001000, 0x0),
 	RTW89_DECL_RFK_WM(0x7800, 0xffffffff, 0x003f807f),
 	RTW89_DECL_RFK_WM(0x780c, 0x0000007f, 0x40),
 	RTW89_DECL_RFK_WM(0x780c, 0x0fffff00, 0x00040),
 	RTW89_DECL_RFK_WM(0x7810, 0xffffffff, 0x59010000),
 	RTW89_DECL_RFK_WM(0x7814, 0x01ffffff, 0x026d000),
 	RTW89_DECL_RFK_WM(0x7814, 0xf8000000, 0x00),
-	RTW89_DECL_RFK_WM(0x7818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x7818, 0xffffffff, 0x002c18e8),
 	RTW89_DECL_RFK_WM(0x781c, 0x3fffffff, 0x3dc80280),
 	RTW89_DECL_RFK_WM(0x7820, 0xffffffff, 0x00000080),
 	RTW89_DECL_RFK_WM(0x78e8, 0x0000003f, 0x03),
@@ -296,7 +296,7 @@ static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_defs_b[] = {
 	RTW89_DECL_RFK_WM(0x78d4, 0x07fc0000, 0x100),
 	RTW89_DECL_RFK_WM(0x78d8, 0xffffffff, 0x8008016c),
 	RTW89_DECL_RFK_WM(0x78dc, 0x0001ffff, 0x0807f),
-	RTW89_DECL_RFK_WM(0x78dc, 0xfff00000, 0x800),
+	RTW89_DECL_RFK_WM(0x78dc, 0xfff00000, 0xc00),
 	RTW89_DECL_RFK_WM(0x78f0, 0x0003ffff, 0x001ff),
 	RTW89_DECL_RFK_WM(0x78f4, 0x000fffff, 0x000),
 	RTW89_DECL_RFK_WM(0x78f8, 0x000fffff, 0x000),
@@ -511,9 +511,9 @@ static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_5g_a[] =
 	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
 	RTW89_DECL_RFK_WM(0x5640, 0x000003ff, 0x000),
 	RTW89_DECL_RFK_WM(0x5640, 0x000ffc00, 0x000),
-	RTW89_DECL_RFK_WM(0x5640, 0x3ff00000, 0x000),
-	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x000),
-	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x07d),
 };
 
 RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_5g_a);
@@ -531,9 +531,9 @@ static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_5g_b[] =
 	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
 	RTW89_DECL_RFK_WM(0x7640, 0x000003ff, 0x000),
 	RTW89_DECL_RFK_WM(0x7640, 0x000ffc00, 0x000),
-	RTW89_DECL_RFK_WM(0x7640, 0x3ff00000, 0x000),
-	RTW89_DECL_RFK_WM(0x7644, 0x000003ff, 0x000),
-	RTW89_DECL_RFK_WM(0x7644, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x7644, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x7644, 0x000ffc00, 0x07d),
 };
 
 RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_5g_b);
@@ -551,9 +551,9 @@ static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_6g_a[] =
 	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
 	RTW89_DECL_RFK_WM(0x5640, 0x000003ff, 0x000),
 	RTW89_DECL_RFK_WM(0x5640, 0x000ffc00, 0x000),
-	RTW89_DECL_RFK_WM(0x5640, 0x3ff00000, 0x000),
-	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x000),
-	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x080),
 };
 
 RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_6g_a);
@@ -571,9 +571,9 @@ static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_6g_b[] =
 	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
 	RTW89_DECL_RFK_WM(0x7640, 0x000003ff, 0x000),
 	RTW89_DECL_RFK_WM(0x7640, 0x000ffc00, 0x000),
-	RTW89_DECL_RFK_WM(0x7640, 0x3ff00000, 0x000),
-	RTW89_DECL_RFK_WM(0x7644, 0x000003ff, 0x000),
-	RTW89_DECL_RFK_WM(0x7644, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x7644, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x7644, 0x000ffc00, 0x080),
 };
 
 RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_6g_b);
-- 
2.25.1

