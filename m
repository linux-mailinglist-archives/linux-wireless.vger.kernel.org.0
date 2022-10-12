Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859105FC210
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJLIdq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJLIdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 04:33:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32CB5B5FE6
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 01:33:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29C8WRemC026287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29C8WRemC026287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Oct 2022 16:32:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 12 Oct 2022 16:32:56 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Oct
 2022 16:32:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: 8852b: rfk: add DACK
Date:   Wed, 12 Oct 2022 16:32:30 +0800
Message-ID: <20221012083234.20224-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012083234.20224-1-pkshih@realtek.com>
References: <20221012083234.20224-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/12/2022 08:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzEyIKRXpMggMDY6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

DACK (digital-to-analog converters calibration) is used to calibrate DAC
to output good quality signals.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  21 +
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 432 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |   1 +
 3 files changed, 454 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5482e32a72d55..40b66c071b27d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3524,6 +3524,7 @@
 #define B_ANAPAR_ADCCLK BIT(30)
 #define B_ANAPAR_FLTRST BIT(22)
 #define B_ANAPAR_CRXBB GENMASK(18, 16)
+#define B_ANAPAR_EN BIT(16)
 #define B_ANAPAR_14 GENMASK(15, 0)
 #define R_RFE_E_A2 0x0334
 #define R_RFE_O_SEL_A2 0x0338
@@ -4378,6 +4379,8 @@
 #define B_DACK_S0P3_OK BIT(2)
 #define R_DACK_DADCK01 0xC084
 #define B_DACK_DADCK01 GENMASK(31, 24)
+#define R_DRCK_FH 0xC094
+#define B_DRCK_LAT BIT(9)
 #define R_DRCK 0xC0C4
 #define B_DRCK_IDLE BIT(9)
 #define B_DRCK_EN BIT(6)
@@ -4385,15 +4388,28 @@
 #define R_DRCK_RES 0xC0C8
 #define B_DRCK_RES GENMASK(19, 15)
 #define B_DRCK_POL BIT(3)
+#define R_DRCK_V1 0xC0CC
+#define B_DRCK_V1_SEL BIT(9)
+#define B_DRCK_V1_KICK BIT(6)
+#define B_DRCK_V1_CV GENMASK(4, 0)
+#define R_DRCK_RS 0xC0D0
+#define B_DRCK_RS_LPS GENMASK(19, 15)
+#define B_DRCK_RS_DONE BIT(3)
 #define R_PATH0_SAMPL_DLY_T_V1 0xC0D4
 #define B_PATH0_SAMPL_DLY_T_MSK_V1 GENMASK(27, 26)
 #define R_P0_CFCH_BW0 0xC0D4
 #define B_P0_CFCH_BW0 GENMASK(27, 26)
 #define R_P0_CFCH_BW1 0xC0D8
 #define B_P0_CFCH_BW1 GENMASK(8, 5)
+#define R_ADDCK0D 0xC0F0
+#define B_ADDCK0D_VAL2 GENMASK(31, 26)
+#define B_ADDCK0D_VAL GENMASK(25, 16)
 #define R_ADDCK0 0xC0F4
+#define B_ADDCK0_TRG BIT(11)
 #define B_ADDCK0 GENMASK(9, 8)
+#define B_ADDCK0_MAN GENMASK(5, 4)
 #define B_ADDCK0_EN BIT(4)
+#define B_ADDCK0_VAL GENMASK(3, 0)
 #define B_ADDCK0_RST BIT(2)
 #define R_ADDCK0_RL 0xC0F8
 #define B_ADDCK0_RLS GENMASK(29, 28)
@@ -4434,8 +4450,13 @@
 #define B_PATH0_BW_SEL_MSK_V1 GENMASK(8, 5)
 #define R_PATH1_BW_SEL_V1 0xC1D8
 #define B_PATH1_BW_SEL_MSK_V1 GENMASK(8, 5)
+#define R_ADDCK1D 0xC1F0
+#define B_ADDCK1D_VAL2 GENMASK(31, 26)
+#define B_ADDCK1D_VAL GENMASK(25, 16)
 #define R_ADDCK1 0xC1F4
+#define B_ADDCK1_TRG BIT(11)
 #define B_ADDCK1 GENMASK(9, 8)
+#define B_ADDCK1_MAN GENMASK(5, 4)
 #define B_ADDCK1_EN BIT(4)
 #define B_ADDCK1_RST BIT(2)
 #define R_ADDCK1_RL 0xC1F8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 761544b0dcca1..5c35f4fb38ff5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -12,6 +12,8 @@
 #include "rtw8852b_rfk_table.h"
 #include "rtw8852b_table.h"
 
+#define ADDC_T_AVG 100
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u8 val;
@@ -30,6 +32,436 @@ static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return val;
 }
 
+static void _afe_init(struct rtw89_dev *rtwdev)
+{
+	rtw89_write32(rtwdev, R_AX_PHYREG_SET, 0xf);
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_afe_init_defs_tbl);
+}
+
+static void _drck(struct rtw89_dev *rtwdev)
+{
+	u32 rck_d;
+	u32 val;
+	int ret;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]Ddie RCK start!!!\n");
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_V1, B_DRCK_V1_KICK, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val, 1, 10000,
+				       false, rtwdev, R_DRCK_RS, B_DRCK_RS_DONE);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DRCK timeout\n");
+
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_V1, B_DRCK_V1_KICK, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_FH, B_DRCK_LAT, 0x1);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_FH, B_DRCK_LAT, 0x0);
+	rck_d = rtw89_phy_read32_mask(rtwdev, R_DRCK_RS, B_DRCK_RS_LPS);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_V1, B_DRCK_V1_SEL, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_V1, B_DRCK_V1_CV, rck_d);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0xc0cc = 0x%x\n",
+		    rtw89_phy_read32_mask(rtwdev, R_DRCK_V1, MASKDWORD));
+}
+
+static void _addck_backup(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0, 0x0);
+	dack->addck_d[0][0] = rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_A0);
+	dack->addck_d[0][1] = rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_A1);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1, 0x0);
+	dack->addck_d[1][0] = rtw89_phy_read32_mask(rtwdev, R_ADDCKR1, B_ADDCKR1_A0);
+	dack->addck_d[1][1] = rtw89_phy_read32_mask(rtwdev, R_ADDCKR1, B_ADDCKR1_A1);
+}
+
+static void _addck_reload(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+
+	/* S0 */
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0D, B_ADDCK0D_VAL, dack->addck_d[0][0]);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_VAL, dack->addck_d[0][1] >> 6);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0D, B_ADDCK0D_VAL2, dack->addck_d[0][1] & 0x3f);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_MAN, 0x3);
+
+	/* S1 */
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1D, B_ADDCK1D_VAL, dack->addck_d[1][0]);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK0_VAL, dack->addck_d[1][1] >> 6);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1D, B_ADDCK1D_VAL2, dack->addck_d[1][1] & 0x3f);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1_MAN, 0x3);
+}
+
+static void _dack_backup_s0(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_V, i);
+		dack->msbk_d[0][0][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK_S0P2, B_DACK_S0M0);
+		rtw89_phy_write32_mask(rtwdev, R_DCOF8, B_DCOF8_V, i);
+		dack->msbk_d[0][1][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK_S0P3, B_DACK_S0M1);
+	}
+
+	dack->biask_d[0][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS00, B_DACK_BIAS00);
+	dack->biask_d[0][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS01, B_DACK_BIAS01);
+
+	dack->dadck_d[0][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK00, B_DACK_DADCK00);
+	dack->dadck_d[0][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK01, B_DACK_DADCK01);
+}
+
+static void _dack_backup_s1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, R_DACK10, B_DACK10, i);
+		dack->msbk_d[1][0][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK10S, B_DACK10S);
+		rtw89_phy_write32_mask(rtwdev, R_DACK11, B_DACK11, i);
+		dack->msbk_d[1][1][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK11S, B_DACK11S);
+	}
+
+	dack->biask_d[1][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS10, B_DACK_BIAS10);
+	dack->biask_d[1][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS11, B_DACK_BIAS11);
+
+	dack->dadck_d[1][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK10, B_DACK_DADCK10);
+	dack->dadck_d[1][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK11, B_DACK_DADCK11);
+}
+
+static void _check_addc(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	s32 dc_re = 0, dc_im = 0;
+	u32 tmp;
+	u32 i;
+
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_check_addc_defs_a_tbl,
+				 &rtw8852b_check_addc_defs_b_tbl);
+
+	for (i = 0; i < ADDC_T_AVG; i++) {
+		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
+		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
+		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
+	}
+
+	dc_re /= ADDC_T_AVG;
+	dc_im /= ADDC_T_AVG;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S%d,dc_re = 0x%x,dc_im =0x%x\n", path, dc_re, dc_im);
+}
+
+static void _addck(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 val;
+	int ret;
+
+	/* S0 */
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_MAN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1, 0x30, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xf);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1, BIT(1), 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0x3);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]before S0 ADDCK\n");
+	_check_addc(rtwdev, RF_PATH_A);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_TRG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_TRG, 0x0);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val, 1, 10000,
+				       false, rtwdev, R_ADDCKR0, BIT(0));
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADDCK timeout\n");
+		dack->addck_timeout[0] = true;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]ADDCK ret = %d\n", ret);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]after S0 ADDCK\n");
+	_check_addc(rtwdev, RF_PATH_A);
+
+	rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1, BIT(1), 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xc);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x0);
+
+	/* S1 */
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xf);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1, BIT(1), 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0x3);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]before S1 ADDCK\n");
+	_check_addc(rtwdev, RF_PATH_B);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1_TRG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1_TRG, 0x0);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val, 1, 10000,
+				       false, rtwdev, R_ADDCKR1, BIT(0));
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 ADDCK timeout\n");
+		dack->addck_timeout[1] = true;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]ADDCK ret = %d\n", ret);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]after S1 ADDCK\n");
+	_check_addc(rtwdev, RF_PATH_B);
+
+	rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1, BIT(1), 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xc);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x0);
+}
+
+static void _check_dadc(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_check_dadc_en_defs_a_tbl,
+				 &rtw8852b_check_dadc_en_defs_b_tbl);
+
+	_check_addc(rtwdev, path);
+
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_check_dadc_dis_defs_a_tbl,
+				 &rtw8852b_check_dadc_dis_defs_b_tbl);
+}
+
+static bool _dack_s0_check_done(struct rtw89_dev *rtwdev, bool part1)
+{
+	if (part1) {
+		if (rtw89_phy_read32_mask(rtwdev, R_DACK_S0P0, B_DACK_S0P0_OK) == 0 ||
+		    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P1, B_DACK_S0P1_OK) == 0)
+			return false;
+	} else {
+		if (rtw89_phy_read32_mask(rtwdev, R_DACK_S0P2, B_DACK_S0P2_OK) == 0 ||
+		    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P3, B_DACK_S0P3_OK) == 0)
+			return false;
+	}
+
+	return true;
+}
+
+static void _dack_s0(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	bool done;
+	int ret;
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dack_s0_1_defs_tbl);
+
+	ret = read_poll_timeout_atomic(_dack_s0_check_done, done, done, 1, 10000,
+				       false, rtwdev, true);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK timeout\n");
+		dack->msbk_timeout[0] = true;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK ret = %d\n", ret);
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dack_s0_2_defs_tbl);
+
+	ret = read_poll_timeout_atomic(_dack_s0_check_done, done, done, 1, 10000,
+				       false, rtwdev, false);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 DADCK timeout\n");
+		dack->dadck_timeout[0] = true;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK ret = %d\n", ret);
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dack_s0_3_defs_tbl);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]after S0 DADCK\n");
+
+	_dack_backup_s0(rtwdev);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x0);
+}
+
+static bool _dack_s1_check_done(struct rtw89_dev *rtwdev, bool part1)
+{
+	if (part1) {
+		if (rtw89_phy_read32_mask(rtwdev, R_DACK_S1P0, B_DACK_S1P0_OK) == 0 &&
+		    rtw89_phy_read32_mask(rtwdev, R_DACK_S1P1, B_DACK_S1P1_OK) == 0)
+			return false;
+	} else {
+		if (rtw89_phy_read32_mask(rtwdev, R_DACK10S, B_DACK_S1P2_OK) == 0 &&
+		    rtw89_phy_read32_mask(rtwdev, R_DACK11S, B_DACK_S1P3_OK) == 0)
+			return false;
+	}
+
+	return true;
+}
+
+static void _dack_s1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	bool done;
+	int ret;
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dack_s1_1_defs_tbl);
+
+	ret = read_poll_timeout_atomic(_dack_s1_check_done, done, done, 1, 10000,
+				       false, rtwdev, true);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK timeout\n");
+		dack->msbk_timeout[1] = true;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK ret = %d\n", ret);
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dack_s1_2_defs_tbl);
+
+	ret = read_poll_timeout_atomic(_dack_s1_check_done, done, done, 1, 10000,
+				       false, rtwdev, false);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 DADCK timeout\n");
+		dack->dadck_timeout[1] = true;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK ret = %d\n", ret);
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dack_s1_3_defs_tbl);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]after S1 DADCK\n");
+
+	_check_dadc(rtwdev, RF_PATH_B);
+	_dack_backup_s1(rtwdev);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x0);
+}
+
+static void _dack(struct rtw89_dev *rtwdev)
+{
+	_dack_s0(rtwdev);
+	_dack_s1(rtwdev);
+}
+
+static void _dack_dump(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+	u8 t;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S0 ADC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->addck_d[0][0], dack->addck_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S1 ADC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->addck_d[1][0], dack->addck_d[1][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S0 DAC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->dadck_d[0][0], dack->dadck_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S1 DAC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->dadck_d[1][0], dack->dadck_d[1][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S0 biask ic = 0x%x, qc = 0x%x\n",
+		    dack->biask_d[0][0], dack->biask_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S1 biask ic = 0x%x, qc = 0x%x\n",
+		    dack->biask_d[1][0], dack->biask_d[1][1]);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK ic:\n");
+	for (i = 0; i < 0x10; i++) {
+		t = dack->msbk_d[0][0][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK qc:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[0][1][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK ic:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[1][0][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK qc:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[1][1][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+}
+
+static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 rf0_0, rf1_0;
+
+	dack->dack_done = false;
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK 0x1\n");
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK start!!!\n");
+
+	rf0_0 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_MOD, RFREG_MASK);
+	rf1_0 = rtw89_read_rf(rtwdev, RF_PATH_B, RR_MOD, RFREG_MASK);
+	_afe_init(rtwdev);
+	_drck(rtwdev);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RFREG_MASK, 0x337e1);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_MOD, RFREG_MASK, 0x337e1);
+	_addck(rtwdev);
+	_addck_backup(rtwdev);
+	_addck_reload(rtwdev);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RFREG_MASK, 0x0);
+	_dack(rtwdev);
+	_dack_dump(rtwdev);
+	dack->dack_done = true;
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RFREG_MASK, rf0_0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_MOD, RFREG_MASK, rf1_0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RR_RSV1_RST, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, RR_RSV1_RST, 0x1);
+	dack->dack_cnt++;
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
+}
+
+void rtw8852b_dack(struct rtw89_dev *rtwdev)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
+	_dac_cal(rtwdev, false);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
+}
+
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			enum rtw89_bandwidth bw, bool dav)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
index d54256bbc9a0a..bc2ff7380b927 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8852b_dack(struct rtw89_dev *rtwdev);
 void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1

