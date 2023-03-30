Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023B66CFDB2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjC3IFK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 04:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjC3IFG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 04:05:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C065B4
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 01:04:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32U84NYW0001248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32U84NYW0001248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 30 Mar 2023 16:04:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Mar 2023 16:04:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Mar
 2023 16:04:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: support parameter tables by RFE type
Date:   Thu, 30 Mar 2023 16:03:31 +0800
Message-ID: <20230330080331.37155-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

One chip can have different RFE (RF front end) types which we will judge
at runtime. And, different RFE types may use different RF parameter tables.
Though we didn't really meet this case previously, we are going to meet it
on upcoming chip RTL8851B. So, this commit handles parameter tables for
runtime RFE type.

We now encapsulate rtw89_txpwr_rule_<2/5/6>ghz tables into rtw89_rfe_parms.
Then, each chip defines its default parameter tables, and if needed, it can
configure extra parameter tables by RFE type. Finally we determine runtime
parameter tables by RFE type if one is configured. Otherwise, we use the
default parameter tables.

For now, we just move all settings under default parameter tables. We will
configure parameter tables by RFE types in separate commits afterwards.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 23 +++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 55 +++++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.c      | 64 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 +-
 .../wireless/realtek/rtw89/rtw8852a_table.c   | 15 +++++
 .../wireless/realtek/rtw89/rtw8852a_table.h   | 11 +---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  6 +-
 .../wireless/realtek/rtw89/rtw8852b_table.c   | 15 +++++
 .../wireless/realtek/rtw89/rtw8852b_table.h   | 11 +---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  8 +--
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 21 ++++++
 .../wireless/realtek/rtw89/rtw8852c_table.h   | 16 +----
 12 files changed, 161 insertions(+), 90 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 489fa7a86160d..cfeb2c1a5821d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3294,6 +3294,28 @@ static void rtw89_core_setup_phycap(struct rtw89_dev *rtwdev)
 		rtwdev->chip->chip_id == RTL8852A && rtwdev->hal.cv <= CHIP_CBV;
 }
 
+static void rtw89_core_setup_rfe_parms(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_rfe_parms_conf *conf = chip->rfe_parms_conf;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	u8 rfe_type = efuse->rfe_type;
+
+	if (!conf)
+		goto out;
+
+	while (conf->rfe_parms) {
+		if (rfe_type == conf->rfe_type) {
+			rtwdev->rfe_parms = conf->rfe_parms;
+			return;
+		}
+		conf++;
+	}
+
+out:
+	rtwdev->rfe_parms = chip->dflt_parms;
+}
+
 static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -3315,6 +3337,7 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_core_setup_phycap(rtwdev);
+	rtw89_core_setup_rfe_parms(rtwdev);
 
 	rtw89_mac_pwr_off(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e447bfec508b8..7581c7b9411a9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2935,6 +2935,41 @@ struct rtw89_txpwr_table {
 		     const struct rtw89_txpwr_table *tbl);
 };
 
+struct rtw89_txpwr_rule_2ghz {
+	const s8 (*lmt)[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
+		       [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+		       [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
+	const s8 (*lmt_ru)[RTW89_RU_NUM][RTW89_NTX_NUM]
+			  [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
+};
+
+struct rtw89_txpwr_rule_5ghz {
+	const s8 (*lmt)[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
+		       [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+		       [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+	const s8 (*lmt_ru)[RTW89_RU_NUM][RTW89_NTX_NUM]
+			  [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+};
+
+struct rtw89_txpwr_rule_6ghz {
+	const s8 (*lmt)[RTW89_6G_BW_NUM][RTW89_NTX_NUM]
+		       [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+		       [RTW89_REGD_NUM][RTW89_6G_CH_NUM];
+	const s8 (*lmt_ru)[RTW89_RU_NUM][RTW89_NTX_NUM]
+			  [RTW89_REGD_NUM][RTW89_6G_CH_NUM];
+};
+
+struct rtw89_rfe_parms {
+	struct rtw89_txpwr_rule_2ghz rule_2ghz;
+	struct rtw89_txpwr_rule_5ghz rule_5ghz;
+	struct rtw89_txpwr_rule_6ghz rule_6ghz;
+};
+
+struct rtw89_rfe_parms_conf {
+	const struct rtw89_rfe_parms *rfe_parms;
+	u8 rfe_type;
+};
+
 struct rtw89_page_regs {
 	u32 hci_fc_ctrl;
 	u32 ch_page_ctrl;
@@ -3071,21 +3106,10 @@ struct rtw89_chip_info {
 	const struct rtw89_phy_dig_gain_table *dig_table;
 	const struct rtw89_dig_regs *dig_regs;
 	const struct rtw89_phy_tssi_dbw_table *tssi_dbw_table;
-	const s8 (*txpwr_lmt_2g)[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
-				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-				[RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-	const s8 (*txpwr_lmt_5g)[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
-				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-				[RTW89_REGD_NUM][RTW89_5G_CH_NUM];
-	const s8 (*txpwr_lmt_6g)[RTW89_6G_BW_NUM][RTW89_NTX_NUM]
-				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-				[RTW89_REGD_NUM][RTW89_6G_CH_NUM];
-	const s8 (*txpwr_lmt_ru_2g)[RTW89_RU_NUM][RTW89_NTX_NUM]
-				   [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-	const s8 (*txpwr_lmt_ru_5g)[RTW89_RU_NUM][RTW89_NTX_NUM]
-				   [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
-	const s8 (*txpwr_lmt_ru_6g)[RTW89_RU_NUM][RTW89_NTX_NUM]
-				   [RTW89_REGD_NUM][RTW89_6G_CH_NUM];
+
+	/* NULL if no rfe-specific, or a null-terminated array by rfe_parms */
+	const struct rtw89_rfe_parms_conf *rfe_parms_conf;
+	const struct rtw89_rfe_parms *dflt_parms;
 
 	u8 txpwr_factor_rf;
 	u8 txpwr_factor_mac;
@@ -3922,6 +3946,7 @@ struct rtw89_dev {
 	struct rtw89_hw_scan_info scan_info;
 	const struct rtw89_chip_info *chip;
 	const struct rtw89_pci_info *pci_info;
+	const struct rtw89_rfe_parms *rfe_parms;
 	struct rtw89_hal hal;
 	struct rtw89_mcc_info mcc;
 	struct rtw89_mac_info mac;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d8b035972dd48..8cc4e22f0bbff 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1617,29 +1617,35 @@ static u8 rtw89_channel_to_idx(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
+	const struct rtw89_txpwr_rule_2ghz *rule_2ghz = &rfe_parms->rule_2ghz;
+	const struct rtw89_txpwr_rule_5ghz *rule_5ghz = &rfe_parms->rule_5ghz;
+	const struct rtw89_txpwr_rule_6ghz *rule_6ghz = &rfe_parms->rule_6ghz;
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt = 0, sar;
 
 	switch (band) {
 	case RTW89_BAND_2G:
-		lmt = (*chip->txpwr_lmt_2g)[bw][ntx][rs][bf][regd][ch_idx];
-		if (!lmt)
-			lmt = (*chip->txpwr_lmt_2g)[bw][ntx][rs][bf]
-						   [RTW89_WW][ch_idx];
+		lmt = (*rule_2ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
+		if (lmt)
+			break;
+
+		lmt = (*rule_2ghz->lmt)[bw][ntx][rs][bf][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_5G:
-		lmt = (*chip->txpwr_lmt_5g)[bw][ntx][rs][bf][regd][ch_idx];
-		if (!lmt)
-			lmt = (*chip->txpwr_lmt_5g)[bw][ntx][rs][bf]
-						   [RTW89_WW][ch_idx];
+		lmt = (*rule_5ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
+		if (lmt)
+			break;
+
+		lmt = (*rule_5ghz->lmt)[bw][ntx][rs][bf][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_6G:
-		lmt = (*chip->txpwr_lmt_6g)[bw][ntx][rs][bf][regd][ch_idx];
-		if (!lmt)
-			lmt = (*chip->txpwr_lmt_6g)[bw][ntx][rs][bf]
-						   [RTW89_WW][ch_idx];
+		lmt = (*rule_6ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
+		if (lmt)
+			break;
+
+		lmt = (*rule_6ghz->lmt)[bw][ntx][rs][bf][RTW89_WW][ch_idx];
 		break;
 	default:
 		rtw89_warn(rtwdev, "unknown band type: %d\n", band);
@@ -1862,29 +1868,35 @@ void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 					u8 ru, u8 ntx, u8 ch)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
+	const struct rtw89_txpwr_rule_2ghz *rule_2ghz = &rfe_parms->rule_2ghz;
+	const struct rtw89_txpwr_rule_5ghz *rule_5ghz = &rfe_parms->rule_5ghz;
+	const struct rtw89_txpwr_rule_6ghz *rule_6ghz = &rfe_parms->rule_6ghz;
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt_ru = 0, sar;
 
 	switch (band) {
 	case RTW89_BAND_2G:
-		lmt_ru = (*chip->txpwr_lmt_ru_2g)[ru][ntx][regd][ch_idx];
-		if (!lmt_ru)
-			lmt_ru = (*chip->txpwr_lmt_ru_2g)[ru][ntx]
-							 [RTW89_WW][ch_idx];
+		lmt_ru = (*rule_2ghz->lmt_ru)[ru][ntx][regd][ch_idx];
+		if (lmt_ru)
+			break;
+
+		lmt_ru = (*rule_2ghz->lmt_ru)[ru][ntx][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_5G:
-		lmt_ru = (*chip->txpwr_lmt_ru_5g)[ru][ntx][regd][ch_idx];
-		if (!lmt_ru)
-			lmt_ru = (*chip->txpwr_lmt_ru_5g)[ru][ntx]
-							 [RTW89_WW][ch_idx];
+		lmt_ru = (*rule_5ghz->lmt_ru)[ru][ntx][regd][ch_idx];
+		if (lmt_ru)
+			break;
+
+		lmt_ru = (*rule_5ghz->lmt_ru)[ru][ntx][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_6G:
-		lmt_ru = (*chip->txpwr_lmt_ru_6g)[ru][ntx][regd][ch_idx];
-		if (!lmt_ru)
-			lmt_ru = (*chip->txpwr_lmt_ru_6g)[ru][ntx]
-							 [RTW89_WW][ch_idx];
+		lmt_ru = (*rule_6ghz->lmt_ru)[ru][ntx][regd][ch_idx];
+		if (lmt_ru)
+			break;
+
+		lmt_ru = (*rule_6ghz->lmt_ru)[ru][ntx][RTW89_WW][ch_idx];
 		break;
 	default:
 		rtw89_warn(rtwdev, "unknown band type: %d\n", band);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9c42b6abd2232..4a08cc9a63b1e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2074,10 +2074,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 				   &rtw89_8852a_phy_radiob_table,},
 	.nctl_table		= &rtw89_8852a_phy_nctl_table,
 	.byr_table		= &rtw89_8852a_byr_table,
-	.txpwr_lmt_2g		= &rtw89_8852a_txpwr_lmt_2g,
-	.txpwr_lmt_5g		= &rtw89_8852a_txpwr_lmt_5g,
-	.txpwr_lmt_ru_2g	= &rtw89_8852a_txpwr_lmt_ru_2g,
-	.txpwr_lmt_ru_5g	= &rtw89_8852a_txpwr_lmt_ru_5g,
+	.dflt_parms		= &rtw89_8852a_dflt_parms,
+	.rfe_parms_conf		= NULL,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
index 320bcd4852c67..be54194558ffd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
@@ -43377,6 +43377,7 @@ static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5,
 	 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10};
 
+static
 const s8 rtw89_8852a_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				 [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
@@ -45566,6 +45567,7 @@ const s8 rtw89_8852a_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_UK][13] = 127,
 };
 
+static
 const s8 rtw89_8852a_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				 [RTW89_REGD_NUM][RTW89_5G_CH_NUM] = {
@@ -47898,6 +47900,7 @@ const s8 rtw89_8852a_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][1][2][1][RTW89_UK][41] = 40,
 };
 
+static
 const s8 rtw89_8852a_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
 				    [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
 	[0][0][RTW89_WW][0] = 32,
@@ -48994,6 +48997,7 @@ const s8 rtw89_8852a_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_UK][13] = 127,
 };
 
+static
 const s8 rtw89_8852a_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 				    [RTW89_REGD_NUM][RTW89_5G_CH_NUM] = {
 	[0][0][RTW89_WW][0] = 22,
@@ -51043,3 +51047,14 @@ const struct rtw89_phy_dig_gain_table rtw89_8852a_phy_dig_table = {
 	.cfg_lna_a = &rtw89_8852a_lna_gain_a_table,
 	.cfg_tia_a = &rtw89_8852a_tia_gain_a_table
 };
+
+const struct rtw89_rfe_parms rtw89_8852a_dflt_parms = {
+	.rule_2ghz = {
+		.lmt = &rtw89_8852a_txpwr_lmt_2g,
+		.lmt_ru = &rtw89_8852a_txpwr_lmt_ru_2g,
+	},
+	.rule_5ghz = {
+		.lmt = &rtw89_8852a_txpwr_lmt_5g,
+		.lmt_ru = &rtw89_8852a_txpwr_lmt_ru_5g,
+	},
+};
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
index 9137965062864..41c379b1044d7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
@@ -14,15 +14,6 @@ extern const struct rtw89_phy_table rtw89_8852a_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8852a_byr_table;
 extern const struct rtw89_phy_dig_gain_table rtw89_8852a_phy_dig_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852a_trk_cfg;
-extern const s8 rtw89_8852a_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
-					[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-					[RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-extern const s8 rtw89_8852a_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
-					[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-					[RTW89_REGD_NUM][RTW89_5G_CH_NUM];
-extern const s8 rtw89_8852a_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
-					   [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-extern const s8 rtw89_8852a_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
-					   [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+extern const struct rtw89_rfe_parms rtw89_8852a_dflt_parms;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 499ae0389c715..5e2aad9497366 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2451,10 +2451,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 				   &rtw89_8852b_phy_radiob_table,},
 	.nctl_table		= &rtw89_8852b_phy_nctl_table,
 	.byr_table		= &rtw89_8852b_byr_table,
-	.txpwr_lmt_2g		= &rtw89_8852b_txpwr_lmt_2g,
-	.txpwr_lmt_5g		= &rtw89_8852b_txpwr_lmt_5g,
-	.txpwr_lmt_ru_2g	= &rtw89_8852b_txpwr_lmt_ru_2g,
-	.txpwr_lmt_ru_5g	= &rtw89_8852b_txpwr_lmt_ru_5g,
+	.dflt_parms		= &rtw89_8852b_dflt_parms,
+	.rfe_parms_conf		= NULL,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index a6734965361f7..904cdb9e56fa7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -14706,6 +14706,7 @@ const u8 rtw89_8852b_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
 	[1][1][RTW89_UKRAINE] = 0,
 };
 
+static
 const s8 rtw89_8852b_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				 [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
@@ -16895,6 +16896,7 @@ const s8 rtw89_8852b_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_UK][13] = 127,
 };
 
+static
 const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				 [RTW89_REGD_NUM][RTW89_5G_CH_NUM] = {
@@ -19539,6 +19541,7 @@ const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[2][1][2][1][RTW89_UK][49] = 127,
 };
 
+static
 const s8 rtw89_8852b_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
 				    [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
 	[0][0][RTW89_WW][0] = 32,
@@ -20635,6 +20638,7 @@ const s8 rtw89_8852b_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_UK][13] = 127,
 };
 
+static
 const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 				    [RTW89_REGD_NUM][RTW89_5G_CH_NUM] = {
 	[0][0][RTW89_WW][0] = 24,
@@ -22875,3 +22879,14 @@ const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg = {
 	.delta_swingidx_2g_cck_a_n = _txpwr_track_delta_swingidx_2g_cck_a_n,
 	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
 };
+
+const struct rtw89_rfe_parms rtw89_8852b_dflt_parms = {
+	.rule_2ghz = {
+		.lmt = &rtw89_8852b_txpwr_lmt_2g,
+		.lmt_ru = &rtw89_8852b_txpwr_lmt_ru_2g,
+	},
+	.rule_5ghz = {
+		.lmt = &rtw89_8852b_txpwr_lmt_5g,
+		.lmt_ru = &rtw89_8852b_txpwr_lmt_ru_5g,
+	},
+};
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
index 114337ac9fb00..5f4161496a589 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
@@ -16,15 +16,6 @@ extern const struct rtw89_txpwr_table rtw89_8852b_byr_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg;
 extern const u8 rtw89_8852b_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
 				    [RTW89_REGD_NUM];
-extern const s8 rtw89_8852b_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
-					[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-					[RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-extern const s8 rtw89_8852b_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
-					[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-					[RTW89_REGD_NUM][RTW89_5G_CH_NUM];
-extern const s8 rtw89_8852b_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
-					   [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-extern const s8 rtw89_8852b_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
-					   [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+extern const struct rtw89_rfe_parms rtw89_8852b_dflt_parms;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8af813132f71d..4b9db52be1726 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2806,12 +2806,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 				   &rtw89_8852c_phy_radioa_table,},
 	.nctl_table		= &rtw89_8852c_phy_nctl_table,
 	.byr_table		= &rtw89_8852c_byr_table,
-	.txpwr_lmt_2g		= &rtw89_8852c_txpwr_lmt_2g,
-	.txpwr_lmt_5g		= &rtw89_8852c_txpwr_lmt_5g,
-	.txpwr_lmt_6g		= &rtw89_8852c_txpwr_lmt_6g,
-	.txpwr_lmt_ru_2g	= &rtw89_8852c_txpwr_lmt_ru_2g,
-	.txpwr_lmt_ru_5g	= &rtw89_8852c_txpwr_lmt_ru_5g,
-	.txpwr_lmt_ru_6g	= &rtw89_8852c_txpwr_lmt_ru_6g,
+	.dflt_parms		= &rtw89_8852c_dflt_parms,
+	.rfe_parms_conf		= NULL,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index 96c264a057ff4..7011e5a6f8fda 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -28590,6 +28590,7 @@ const u8 rtw89_8852c_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
 	[2][1][RTW89_KCC] = 0,
 };
 
+static
 const s8 rtw89_8852c_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				 [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
@@ -30107,6 +30108,7 @@ const s8 rtw89_8852c_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 	[1][1][2][1][RTW89_UK][13] = 127,
 };
 
+static
 const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				 [RTW89_REGD_NUM][RTW89_5G_CH_NUM] = {
@@ -32020,6 +32022,7 @@ const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
 	[3][1][2][1][RTW89_UK][45] = 127,
 };
 
+static
 const s8 rtw89_8852c_txpwr_lmt_6g[RTW89_6G_BW_NUM][RTW89_NTX_NUM]
 				 [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				 [RTW89_REGD_NUM][RTW89_6G_CH_NUM] = {
@@ -33977,6 +33980,7 @@ const s8 rtw89_8852c_txpwr_lmt_6g[RTW89_6G_BW_NUM][RTW89_NTX_NUM]
 	[3][1][2][1][RTW89_KCC][112] = 127,
 };
 
+static
 const s8 rtw89_8852c_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
 				    [RTW89_REGD_NUM][RTW89_2G_CH_NUM] = {
 	[0][0][RTW89_WW][0] = 32,
@@ -34737,6 +34741,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_UK][13] = 127,
 };
 
+static
 const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 				    [RTW89_REGD_NUM][RTW89_5G_CH_NUM] = {
 	[0][0][RTW89_WW][0] = 16,
@@ -36253,6 +36258,7 @@ const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_UK][52] = 127,
 };
 
+static
 const s8 rtw89_8852c_txpwr_lmt_ru_6g[RTW89_RU_NUM][RTW89_NTX_NUM]
 				    [RTW89_REGD_NUM][RTW89_6G_CH_NUM] = {
 	[0][0][RTW89_WW][0] = -16,
@@ -37472,3 +37478,18 @@ const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table = {
 	.data[RTW89_TSSI_BANDEDGE_MID] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 	.data[RTW89_TSSI_BANDEDGE_HIGH] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
+
+const struct rtw89_rfe_parms rtw89_8852c_dflt_parms = {
+	.rule_2ghz = {
+		.lmt = &rtw89_8852c_txpwr_lmt_2g,
+		.lmt_ru = &rtw89_8852c_txpwr_lmt_ru_2g,
+	},
+	.rule_5ghz = {
+		.lmt = &rtw89_8852c_txpwr_lmt_5g,
+		.lmt_ru = &rtw89_8852c_txpwr_lmt_ru_5g,
+	},
+	.rule_6ghz = {
+		.lmt = &rtw89_8852c_txpwr_lmt_6g,
+		.lmt_ru = &rtw89_8852c_txpwr_lmt_ru_6g,
+	},
+};
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
index 7d71a92e2d27c..6da1849fb1fac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
@@ -17,20 +17,6 @@ extern const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg;
 extern const u8 rtw89_8852c_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
 				    [RTW89_REGD_NUM];
-extern const s8 rtw89_8852c_txpwr_lmt_2g[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
-					[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-					[RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-extern const s8 rtw89_8852c_txpwr_lmt_5g[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
-					[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-					[RTW89_REGD_NUM][RTW89_5G_CH_NUM];
-extern const s8 rtw89_8852c_txpwr_lmt_6g[RTW89_6G_BW_NUM][RTW89_NTX_NUM]
-					[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
-					[RTW89_REGD_NUM][RTW89_6G_CH_NUM];
-extern const s8 rtw89_8852c_txpwr_lmt_ru_2g[RTW89_RU_NUM][RTW89_NTX_NUM]
-					   [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
-extern const s8 rtw89_8852c_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
-					   [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
-extern const s8 rtw89_8852c_txpwr_lmt_ru_6g[RTW89_RU_NUM][RTW89_NTX_NUM]
-					   [RTW89_REGD_NUM][RTW89_6G_CH_NUM];
+extern const struct rtw89_rfe_parms rtw89_8852c_dflt_parms;
 
 #endif
-- 
2.25.1

