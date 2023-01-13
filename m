Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398A866925C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 10:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjAMJK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 04:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbjAMJJ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 04:09:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B965431B7
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 01:07:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30D95rZvA029938, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30D95rZvA029938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 13 Jan 2023 17:05:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 13 Jan 2023 17:06:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 13 Jan
 2023 17:06:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <echuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: 8852c: rfk: correct ADC clock settings
Date:   Fri, 13 Jan 2023 17:06:30 +0800
Message-ID: <20230113090632.60957-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113090632.60957-1-pkshih@realtek.com>
References: <20230113090632.60957-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/13/2023 08:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTMgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

Some hardware modules don't have good RF characteristic as regular.
It could get ADC abnormal in low temperature, and it causes bad RX
performance and affects calibration result of DPK.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  5 ++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 51 ++++++++++++++-----
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 412a6918efd6c..036953f0ec464 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4738,6 +4738,7 @@
 #define R_DRCK_FH 0xC094
 #define B_DRCK_LAT BIT(9)
 #define R_DRCK 0xC0C4
+#define B_DRCK_MUL GENMASK(21, 17)
 #define B_DRCK_IDLE BIT(9)
 #define B_DRCK_EN BIT(6)
 #define B_DRCK_VAL GENMASK(4, 0)
@@ -4755,9 +4756,13 @@
 #define B_PATH0_SAMPL_DLY_T_MSK_V1 GENMASK(27, 26)
 #define R_P0_CFCH_BW0 0xC0D4
 #define B_P0_CFCH_BW0 GENMASK(27, 26)
+#define B_P0_CFCH_EN GENMASK(14, 11)
+#define B_P0_CFCH_CTL GENMASK(10, 7)
 #define R_P0_CFCH_BW1 0xC0D8
 #define B_P0_CFCH_EX BIT(13)
 #define B_P0_CFCH_BW1 GENMASK(8, 5)
+#define R_ADCMOD 0xC0E8
+#define B_ADCMOD_LP GENMASK(31, 16)
 #define R_ADDCK0D 0xC0F0
 #define B_ADDCK0D_VAL2 GENMASK(31, 26)
 #define B_ADDCK0D_VAL GENMASK(25, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 3c5fa3bb2a8f4..2c0bc3a4ab3b1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -11,6 +11,15 @@
 #include "rtw8852c_rfk_table.h"
 #include "rtw8852c_table.h"
 
+struct rxck_def {
+	u32 ctl;
+	u32 en;
+	u32 bw0;
+	u32 bw1;
+	u32 mul;
+	u32 lp;
+};
+
 #define _TSSI_DE_MASK GENMASK(21, 12)
 static const u32 _tssi_de_cck_long[RF_PATH_NUM_8852C] = {0x5858, 0x7858};
 static const u32 _tssi_de_cck_short[RF_PATH_NUM_8852C] = {0x5860, 0x7860};
@@ -62,6 +71,10 @@ static const u32 dpk_par_regs[RTW89_DPK_RF_PATH][4] = {
 static const u8 _dck_addr_bs[RF_PATH_NUM_8852C] = {0x0, 0x10};
 static const u8 _dck_addr[RF_PATH_NUM_8852C] = {0xc, 0x1c};
 
+static const struct rxck_def _ck480M = {0x8, 0x2, 0x3, 0xf, 0x0, 0x9};
+static const struct rxck_def _ck960M = {0x8, 0x2, 0x2, 0x8, 0x0, 0x9};
+static const struct rxck_def _ck1920M = {0x8, 0x0, 0x2, 0x4, 0x6, 0x9};
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]dbcc_en: %x,  PHY%d\n",
@@ -440,6 +453,8 @@ static void rtw8852c_txck_force(struct rtw89_dev *rtwdev, u8 path, bool force,
 static void rtw8852c_rxck_force(struct rtw89_dev *rtwdev, u8 path, bool force,
 				enum adc_ck ck)
 {
+	const struct rxck_def *def;
+
 	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_ON, 0x0);
 
 	if (!force)
@@ -447,6 +462,26 @@ static void rtw8852c_rxck_force(struct rtw89_dev *rtwdev, u8 path, bool force,
 
 	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_VAL, ck);
 	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_ON, 0x1);
+
+	switch (ck) {
+	case ADC_480M:
+		def = &_ck480M;
+		break;
+	case ADC_960M:
+		def = &_ck960M;
+		break;
+	case ADC_1920M:
+	default:
+		def = &_ck1920M;
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_CTL, def->ctl);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_EN, def->en);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, def->bw0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, def->bw1);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK | (path << 8), B_DRCK_MUL, def->mul);
+	rtw89_phy_write32_mask(rtwdev, R_ADCMOD | (path << 8), B_ADCMOD_LP, def->lp);
 }
 
 static bool _check_dack_done(struct rtw89_dev *rtwdev, bool s0)
@@ -630,8 +665,6 @@ static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
 		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_DPD_GDIS, 0x1);
 		rtw8852c_rxck_force(rtwdev, path, true, ADC_480M);
 		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_ACK_VAL, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x3);
-		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xf);
 		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13), B_P0_NRBW_DBG, 0x1);
 		break;
@@ -639,8 +672,6 @@ static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
 		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_DPD_GDIS, 0x1);
 		rtw8852c_rxck_force(rtwdev, path, true, ADC_960M);
 		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_ACK_VAL, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x2);
-		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xd);
 		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13), B_P0_NRBW_DBG, 0x1);
 	break;
@@ -648,8 +679,6 @@ static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
 		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_DPD_GDIS, 0x1);
 		rtw8852c_rxck_force(rtwdev, path, true, ADC_1920M);
 		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_ACK_VAL, 0x2);
-		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xb);
 		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_CKT, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13), B_P0_NRBW_DBG, 0x1);
 		break;
@@ -1413,8 +1442,6 @@ static void _iqk_macbb_setting(struct rtw89_dev *rtwdev,
 	rtw8852c_rxck_force(rtwdev, path, true, ADC_1920M);
 	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK | (path << 13), B_ACK_VAL, 0x2);
 
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, 0x1);
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, 0xb);
 	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW | (path << 13), B_P0_NRBW_DBG, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x1f);
 	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x13);
@@ -1760,7 +1787,7 @@ u8 _rx_dck_channel_calc(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan)
 #define RTW8852C_DPK_VER 0xf
 #define RTW8852C_DPK_TH_AVG_NUM 4
 #define RTW8852C_DPK_RF_PATH 2
-#define RTW8852C_DPK_KIP_REG_NUM 5
+#define RTW8852C_DPK_KIP_REG_NUM 7
 #define RTW8852C_DPK_RXSRAM_DBG 0
 
 enum rtw8852c_dpk_id {
@@ -1919,8 +1946,6 @@ static void _dpk_bb_afe_setting(struct rtw89_dev *rtwdev,
 
 	/*4. Set ADC clk*/
 	rtw8852c_rxck_force(rtwdev, path, true, ADC_1920M);
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x1);
-	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xb);
 	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13),
 			       B_P0_NRBW_DBG, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, MASKBYTE3, 0x1f);
@@ -2671,12 +2696,14 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 			    enum rtw89_phy_idx phy, u8 kpath)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
-	static const u32 kip_reg[] = {0x813c, 0x8124, 0x8120, 0xc0d4, 0xc0d8};
+	static const u32 kip_reg[] = {0x813c, 0x8124, 0x8120, 0xc0c4, 0xc0e8, 0xc0d4, 0xc0d8};
 	u32 backup_rf_val[RTW8852C_DPK_RF_PATH][BACKUP_RF_REGS_NR];
 	u32 kip_bkup[RTW8852C_DPK_RF_PATH][RTW8852C_DPK_KIP_REG_NUM] = {};
 	u8 path;
 	bool is_fail = true, reloaded[RTW8852C_DPK_RF_PATH] = {false};
 
+	static_assert(ARRAY_SIZE(kip_reg) == RTW8852C_DPK_KIP_REG_NUM);
+
 	if (dpk->is_dpk_reload_en) {
 		for (path = 0; path < RTW8852C_DPK_RF_PATH; path++) {
 			if (!(kpath & BIT(path)))
-- 
2.25.1

