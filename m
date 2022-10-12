Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D195FC211
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 10:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJLIds (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 04:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJLIdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 04:33:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F736B5FEB
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 01:33:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29C8WReqC026287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29C8WReqC026287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Oct 2022 16:32:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 12 Oct 2022 16:32:57 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Oct
 2022 16:32:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: 8852b: rfk: add IQK
Date:   Wed, 12 Oct 2022 16:32:33 +0800
Message-ID: <20221012083234.20224-5-pkshih@realtek.com>
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

IQ signal calibration is a very important calibration to yield good RF
performance. We do this calibration only if we are going to run on AP
channel. During scanning phase, without this calibration RF performance
is still acceptable because it transmits with low data rate at this phase.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   19 +
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 1046 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |    1 +
 3 files changed, 1066 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 40b66c071b27d..6dc078969d588 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3295,6 +3295,7 @@
 #define RR_MOD_IQK GENMASK(19, 4)
 #define RR_MOD_DPK GENMASK(19, 5)
 #define RR_MOD_MASK GENMASK(19, 16)
+#define RR_MOD_RGM GENMASK(13, 4)
 #define RR_MOD_V_DOWN 0x0
 #define RR_MOD_V_STANDBY 0x1
 #define RR_MOD_V_TX 0x2
@@ -3368,6 +3369,7 @@
 #define RR_RXK_PLLEN BIT(5)
 #define RR_LUTWA 0x33
 #define RR_LUTWA_MASK GENMASK(9, 0)
+#define RR_LUTWA_M1 GENMASK(7, 0)
 #define RR_LUTWA_M2 GENMASK(4, 0)
 #define RR_LUTWD1 0x3e
 #define RR_LUTWD0 0x3f
@@ -3415,6 +3417,8 @@
 #define RR_TXA2_LDO GENMASK(19, 16)
 #define RR_TRXIQ 0x66
 #define RR_RSV6 0x6d
+#define RR_TXVBUF 0x7c
+#define RR_TXVBUF_DACEN BIT(5)
 #define RR_TXPOW 0x7f
 #define RR_TXPOW_TXA BIT(8)
 #define RR_TXPOW_TXAS BIT(7)
@@ -3438,7 +3442,9 @@
 #define RR_RXA2 0x8c
 #define RR_RXA2_C1 GENMASK(12, 10)
 #define RR_RXA2_C2 GENMASK(9, 3)
+#define RR_RXA2_CC2 GENMASK(8, 7)
 #define RR_RXA2_IATT GENMASK(7, 4)
+#define RR_RXA2_HATT GENMASK(6, 0)
 #define RR_RXA2_ATT GENMASK(3, 0)
 #define RR_RXIQGEN 0x8d
 #define RR_RXIQGEN_ATTL GENMASK(12, 8)
@@ -3450,6 +3456,7 @@
 #define RR_RXBB2_IDAC GENMASK(11, 9)
 #define RR_RXBB2_EBW GENMASK(6, 5)
 #define RR_XALNA2 0x90
+#define RR_XALNA2_SW2 GENMASK(9, 8)
 #define RR_XALNA2_SW GENMASK(1, 0)
 #define RR_DCK 0x92
 #define RR_DCK_DONE GENMASK(7, 5)
@@ -3530,6 +3537,8 @@
 #define R_RFE_O_SEL_A2 0x0338
 #define R_RFE_SEL0_A2 0x033C
 #define R_RFE_SEL32_A2 0x0340
+#define R_CIRST 0x035c
+#define B_CIRST_SYN GENMASK(11, 10)
 #define R_SWSI_DATA_V1 0x0370
 #define B_SWSI_DATA_VAL_V1 GENMASK(19, 0)
 #define B_SWSI_DATA_ADDR_V1 GENMASK(27, 20)
@@ -3777,6 +3786,11 @@
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
 #define R_S1_HW_SI_DIS 0x3200
 #define B_S1_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
+#define R_P1_RXCK 0x32A0
+#define B_P1_RXCK_BW3 BIT(30)
+#define B_P1_TXCK_ALL GENMASK(19, 12)
+#define B_P1_RXCK_ON BIT(19)
+#define B_P1_RXCK_VAL GENMASK(18, 16)
 #define R_P1_RFMODE 0x32AC
 #define B_P1_RFMODE_ORI_TXRX_FTM_TX GENMASK(31, 4)
 #define B_P1_RFMODE_MUX GENMASK(11, 4)
@@ -4107,6 +4121,7 @@
 #define R_P0_TSSI_AVG 0x5820
 #define B_P0_TSSI_AVG GENMASK(15, 12)
 #define R_P0_RFCTM 0x5864
+#define B_P0_RFCTM_EN BIT(29)
 #define B_P0_RFCTM_VAL GENMASK(25, 20)
 #define R_P0_RFCTM_RDY BIT(26)
 #define R_P0_TRSW 0x5868
@@ -4266,6 +4281,7 @@
 #define B_COEF_SEL_MDPD BIT(8)
 #define R_CFIR_SYS 0x8120
 #define R_IQK_RES 0x8124
+#define B_IQK_RES_K BIT(28)
 #define B_IQK_RES_TXCFIR GENMASK(11, 8)
 #define B_IQK_RES_RXCFIR GENMASK(3, 0)
 #define R_TXIQC 0x8138
@@ -4322,6 +4338,9 @@
 #define B_RPT_PER_TSSI GENMASK(28, 16)
 #define B_RPT_PER_OF GENMASK(15, 8)
 #define B_RPT_PER_TH GENMASK(5, 0)
+#define R_IQRSN 0x8220
+#define B_IQRSN_K1 BIT(28)
+#define B_IQRSN_K2 BIT(16)
 #define R_RXCFIR_P0C0 0x8D40
 #define R_RXCFIR_P0C1 0x8D84
 #define R_RXCFIR_P0C2 0x8DC8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 306f6a292c59a..466f908e0214a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -13,8 +13,189 @@
 #include "rtw8852b_table.h"
 
 #define RTW8852B_RXDCK_VER 0x1
+#define RTW8852B_IQK_VER 0x2a
+#define RTW8852B_IQK_SS 2
+#define RTW8852B_RXK_GROUP_NR 4
 #define ADDC_T_AVG 100
 
+enum rtw8852b_iqk_type {
+	ID_TXAGC = 0x0,
+	ID_FLOK_COARSE = 0x1,
+	ID_FLOK_FINE = 0x2,
+	ID_TXK = 0x3,
+	ID_RXAGC = 0x4,
+	ID_RXK = 0x5,
+	ID_NBTXK = 0x6,
+	ID_NBRXK = 0x7,
+	ID_FLOK_VBUFFER = 0x8,
+	ID_A_FLOK_COARSE = 0x9,
+	ID_G_FLOK_COARSE = 0xa,
+	ID_A_FLOK_FINE = 0xb,
+	ID_G_FLOK_FINE = 0xc,
+	ID_IQK_RESTORE = 0x10,
+};
+
+static const u32 _a_idxrxgain[RTW8852B_RXK_GROUP_NR] = {0x190, 0x198, 0x350, 0x352};
+static const u32 _a_idxattc2[RTW8852B_RXK_GROUP_NR] = {0x0f, 0x0f, 0x3f, 0x7f};
+static const u32 _a_idxattc1[RTW8852B_RXK_GROUP_NR] = {0x3, 0x1, 0x0, 0x0};
+static const u32 _g_idxrxgain[RTW8852B_RXK_GROUP_NR] = {0x212, 0x21c, 0x350, 0x360};
+static const u32 _g_idxattc2[RTW8852B_RXK_GROUP_NR] = {0x00, 0x00, 0x28, 0x5f};
+static const u32 _g_idxattc1[RTW8852B_RXK_GROUP_NR] = {0x3, 0x3, 0x2, 0x1};
+static const u32 _a_power_range[RTW8852B_RXK_GROUP_NR] = {0x0, 0x0, 0x0, 0x0};
+static const u32 _a_track_range[RTW8852B_RXK_GROUP_NR] = {0x3, 0x3, 0x6, 0x6};
+static const u32 _a_gain_bb[RTW8852B_RXK_GROUP_NR] = {0x08, 0x0e, 0x06, 0x0e};
+static const u32 _a_itqt[RTW8852B_RXK_GROUP_NR] = {0x12, 0x12, 0x12, 0x1b};
+static const u32 _g_power_range[RTW8852B_RXK_GROUP_NR] = {0x0, 0x0, 0x0, 0x0};
+static const u32 _g_track_range[RTW8852B_RXK_GROUP_NR] = {0x4, 0x4, 0x6, 0x6};
+static const u32 _g_gain_bb[RTW8852B_RXK_GROUP_NR] = {0x08, 0x0e, 0x06, 0x0e};
+static const u32 _g_itqt[RTW8852B_RXK_GROUP_NR] = {0x09, 0x12, 0x1b, 0x24};
+
+static const u32 rtw8852b_backup_bb_regs[] = {0x2344, 0x5800, 0x7800};
+static const u32 rtw8852b_backup_rf_regs[] = {
+	0xde, 0xdf, 0x8b, 0x90, 0x97, 0x85, 0x1e, 0x0, 0x2, 0x5, 0x10005
+};
+
+#define BACKUP_BB_REGS_NR ARRAY_SIZE(rtw8852b_backup_bb_regs)
+#define BACKUP_RF_REGS_NR ARRAY_SIZE(rtw8852b_backup_rf_regs)
+
+static const struct rtw89_reg3_def rtw8852b_set_nondbcc_path01[] = {
+	{0x20fc, 0xffff0000, 0x0303},
+	{0x5864, 0x18000000, 0x3},
+	{0x7864, 0x18000000, 0x3},
+	{0x12b8, 0x40000000, 0x1},
+	{0x32b8, 0x40000000, 0x1},
+	{0x030c, 0xff000000, 0x13},
+	{0x032c, 0xffff0000, 0x0041},
+	{0x12b8, 0x10000000, 0x1},
+	{0x58c8, 0x01000000, 0x1},
+	{0x78c8, 0x01000000, 0x1},
+	{0x5864, 0xc0000000, 0x3},
+	{0x7864, 0xc0000000, 0x3},
+	{0x2008, 0x01ffffff, 0x1ffffff},
+	{0x0c1c, 0x00000004, 0x1},
+	{0x0700, 0x08000000, 0x1},
+	{0x0c70, 0x000003ff, 0x3ff},
+	{0x0c60, 0x00000003, 0x3},
+	{0x0c6c, 0x00000001, 0x1},
+	{0x58ac, 0x08000000, 0x1},
+	{0x78ac, 0x08000000, 0x1},
+	{0x0c3c, 0x00000200, 0x1},
+	{0x2344, 0x80000000, 0x1},
+	{0x4490, 0x80000000, 0x1},
+	{0x12a0, 0x00007000, 0x7},
+	{0x12a0, 0x00008000, 0x1},
+	{0x12a0, 0x00070000, 0x3},
+	{0x12a0, 0x00080000, 0x1},
+	{0x32a0, 0x00070000, 0x3},
+	{0x32a0, 0x00080000, 0x1},
+	{0x0700, 0x01000000, 0x1},
+	{0x0700, 0x06000000, 0x2},
+	{0x20fc, 0xffff0000, 0x3333},
+};
+
+static const struct rtw89_reg3_def rtw8852b_restore_nondbcc_path01[] = {
+	{0x20fc, 0xffff0000, 0x0303},
+	{0x12b8, 0x40000000, 0x0},
+	{0x32b8, 0x40000000, 0x0},
+	{0x5864, 0xc0000000, 0x0},
+	{0x7864, 0xc0000000, 0x0},
+	{0x2008, 0x01ffffff, 0x0000000},
+	{0x0c1c, 0x00000004, 0x0},
+	{0x0700, 0x08000000, 0x0},
+	{0x0c70, 0x0000001f, 0x03},
+	{0x0c70, 0x000003e0, 0x03},
+	{0x12a0, 0x000ff000, 0x00},
+	{0x32a0, 0x000ff000, 0x00},
+	{0x0700, 0x07000000, 0x0},
+	{0x20fc, 0xffff0000, 0x0000},
+	{0x58c8, 0x01000000, 0x0},
+	{0x78c8, 0x01000000, 0x0},
+	{0x0c3c, 0x00000200, 0x0},
+	{0x2344, 0x80000000, 0x0},
+};
+
+static void _rfk_backup_bb_reg(struct rtw89_dev *rtwdev, u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		backup_bb_reg_val[i] =
+			rtw89_phy_read32_mask(rtwdev, rtw8852b_backup_bb_regs[i],
+					      MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]backup bb reg : %x, value =%x\n",
+			    rtw8852b_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_backup_rf_reg(struct rtw89_dev *rtwdev, u32 backup_rf_reg_val[],
+			       u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		backup_rf_reg_val[i] =
+			rtw89_read_rf(rtwdev, rf_path,
+				      rtw8852b_backup_rf_regs[i], RFREG_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]backup rf S%d reg : %x, value =%x\n", rf_path,
+			    rtw8852b_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
+static void _rfk_restore_bb_reg(struct rtw89_dev *rtwdev,
+				const u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, rtw8852b_backup_bb_regs[i],
+				       MASKDWORD, backup_bb_reg_val[i]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]restore bb reg : %x, value =%x\n",
+			    rtw8852b_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_restore_rf_reg(struct rtw89_dev *rtwdev,
+				const u32 backup_rf_reg_val[], u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		rtw89_write_rf(rtwdev, rf_path, rtw8852b_backup_rf_regs[i],
+			       RFREG_MASK, backup_rf_reg_val[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]restore rf S%d reg: %x, value =%x\n", rf_path,
+			    rtw8852b_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
+static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path)
+{
+	bool fail = true;
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x55,
+				       1, 8200, false, rtwdev, 0xbff8, MASKBYTE0);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]NCTL1 IQK timeout!!!\n");
+
+	udelay(200);
+
+	if (!ret)
+		fail = rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, B_NCTL_RPT_FLG);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, MASKBYTE0, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, ret=%d\n", path, ret);
+	val = rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x8008 = 0x%x\n", path, val);
+
+	return fail;
+}
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u8 val;
@@ -530,6 +711,803 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
 }
 
+static void _iqk_rxk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 tmp;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL2G, 0x1);
+		tmp = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+		rtw89_write_rf(rtwdev, path, RR_RSV4, RFREG_MASK, tmp);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0xc);
+		rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL5G, 0x1);
+		tmp = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+		rtw89_write_rf(rtwdev, path, RR_RSV4, RFREG_MASK, tmp);
+		break;
+	default:
+		break;
+	}
+}
+
+static bool _iqk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			  u8 path, u8 ktype)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 iqk_cmd;
+	bool fail;
+
+	switch (ktype) {
+	case ID_FLOK_COARSE:
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		iqk_cmd = 0x108 | (1 << (4 + path));
+		break;
+	case ID_FLOK_FINE:
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		iqk_cmd = 0x208 | (1 << (4 + path));
+		break;
+	case ID_FLOK_VBUFFER:
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		iqk_cmd = 0x308 | (1 << (4 + path));
+		break;
+	case ID_TXK:
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+		iqk_cmd = 0x008 | (1 << (path + 4)) |
+			  (((0x8 + iqk_info->iqk_bw[path]) & 0xf) << 8);
+		break;
+	case ID_RXAGC:
+		iqk_cmd = 0x508 | (1 << (4 + path)) | (path << 1);
+		break;
+	case ID_RXK:
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		iqk_cmd = 0x008 | (1 << (path + 4)) |
+			  (((0xb + iqk_info->iqk_bw[path]) & 0xf) << 8);
+		break;
+	case ID_NBTXK:
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x011);
+		iqk_cmd = 0x308 | (1 << (4 + path));
+		break;
+	case ID_NBRXK:
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+		iqk_cmd = 0x608 | (1 << (4 + path));
+		break;
+	default:
+		return false;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, iqk_cmd + 1);
+	udelay(1);
+	fail = _iqk_check_cal(rtwdev, path);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	return fail;
+}
+
+static bool _rxk_group_sel(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			   u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool fail;
+	u8 gp;
+
+	for (gp = 0; gp < RTW8852B_RXK_GROUP_NR; gp++) {
+		switch (iqk_info->iqk_band[path]) {
+		case RTW89_BAND_2G:
+			rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM,
+				       _g_idxrxgain[gp]);
+			rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C2G,
+				       _g_idxattc2[gp]);
+			rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C1G,
+				       _g_idxattc1[gp]);
+			break;
+		case RTW89_BAND_5G:
+			rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM,
+				       _a_idxrxgain[gp]);
+			rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_HATT,
+				       _a_idxattc2[gp]);
+			rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_CC2,
+				       _a_idxattc1[gp]);
+			break;
+		default:
+			break;
+		}
+
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SET, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_GP_V1, gp);
+		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+		rtw89_phy_write32_mask(rtwdev, R_IQKINF,
+				       BIT(16 + gp + path * 4), fail);
+		kfail |= fail;
+	}
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL5G, 0x0);
+
+	if (kfail) {
+		iqk_info->nb_rxcfir[path] = 0x40000002;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_RXCFIR, 0x0);
+		iqk_info->is_wb_rxiqk[path] = false;
+	} else {
+		iqk_info->nb_rxcfir[path] = 0x40000000;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_RXCFIR, 0x5);
+		iqk_info->is_wb_rxiqk[path] = true;
+	}
+
+	return kfail;
+}
+
+static bool _iqk_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		       u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	const u8 gp = 0x3;
+	bool kfail = false;
+	bool fail;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM,
+			       _g_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C2G,
+			       _g_idxattc2[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_C1G,
+			       _g_idxattc1[gp]);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_RGM,
+			       _a_idxrxgain[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_HATT,
+			       _a_idxattc2[gp]);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_CC2,
+			       _a_idxattc1[gp]);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SEL, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SET, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_GP_V1, gp);
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80013);
+	udelay(1);
+
+	fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, BIT(16 + gp + path * 4), fail);
+	kfail |= fail;
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_SEL5G, 0x0);
+
+	if (!kfail)
+		iqk_info->nb_rxcfir[path] =
+			 rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD) | 0x2;
+	else
+		iqk_info->nb_rxcfir[path] = 0x40000002;
+
+	return kfail;
+}
+
+static void _iqk_rxclk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	if (iqk_info->iqk_bw[path] == RTW89_CHANNEL_WIDTH_80) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x0f);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x03);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0xa001);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0xa041);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_VAL, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RXCK, B_P1_RXCK_VAL, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RXCK, B_P1_RXCK_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_CLK_ADC_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_CLK_ADC_VAL, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x0f);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x03);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0xa001);
+		udelay(1);
+		rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0xa041);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_VAL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_RXCK_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RXCK, B_P1_RXCK_VAL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RXCK, B_P1_RXCK_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_CLK_ADC_ON, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_CLK_ADC_VAL, 0x0);
+	}
+}
+
+static bool _txk_group_sel(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail = false;
+	bool fail;
+	u8 gp;
+
+	for (gp = 0x0; gp < RTW8852B_RXK_GROUP_NR; gp++) {
+		switch (iqk_info->iqk_band[path]) {
+		case RTW89_BAND_2G:
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+				       _g_power_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+				       _g_track_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+				       _g_gain_bb[gp]);
+			rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+					       MASKDWORD, _g_itqt[gp]);
+			break;
+		case RTW89_BAND_5G:
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+				       _a_power_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+				       _a_track_range[gp]);
+			rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+				       _a_gain_bb[gp]);
+			rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+					       MASKDWORD, _a_itqt[gp]);
+			break;
+		default:
+			break;
+		}
+
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SEL, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_SET, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_G2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
+				       B_CFIR_LUT_GP, gp);
+		rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK);
+		rtw89_phy_write32_mask(rtwdev, R_IQKINF,
+				       BIT(8 + gp + path * 4), fail);
+		kfail |= fail;
+	}
+
+	if (kfail) {
+		iqk_info->nb_txcfir[path] = 0x40000002;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_TXCFIR, 0x0);
+		iqk_info->is_wb_txiqk[path] = false;
+	} else {
+		iqk_info->nb_txcfir[path] = 0x40000000;
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8),
+				       B_IQK_RES_TXCFIR, 0x5);
+		iqk_info->is_wb_txiqk[path] = true;
+	}
+
+	return kfail;
+}
+
+static bool _iqk_nbtxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool kfail;
+	u8 gp = 0x3;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+			       _g_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+			       _g_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+			       _g_gain_bb[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, _g_itqt[gp]);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0,
+			       _a_power_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1,
+			       _a_track_range[gp]);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG,
+			       _a_gain_bb[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8),
+				       MASKDWORD, _a_itqt[gp]);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SEL, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_SET, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_G2, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_GP, gp);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	kfail = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+
+	if (!kfail)
+		iqk_info->nb_txcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8),
+					      MASKDWORD) | 0x2;
+	else
+		iqk_info->nb_txcfir[path] = 0x40000002;
+
+	return kfail;
+}
+
+static void _lok_res_table(struct rtw89_dev *rtwdev, u8 path, u8 ibias)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, ibias = %x\n", path, ibias);
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x2);
+	if (iqk_info->iqk_band[path] == RTW89_BAND_2G)
+		rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, 0x0);
+	else
+		rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, ibias);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_TXVBUF, RR_TXVBUF_DACEN, 0x1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x7c = %x\n", path,
+		    rtw89_read_rf(rtwdev, path, RR_TXVBUF, RFREG_MASK));
+}
+
+static bool _lok_finetune_check(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool is_fail1, is_fail2;
+	u32 vbuff_i;
+	u32 vbuff_q;
+	u32 core_i;
+	u32 core_q;
+	u32 tmp;
+	u8 ch;
+
+	tmp = rtw89_read_rf(rtwdev, path, RR_TXMO, RFREG_MASK);
+	core_i = FIELD_GET(RR_TXMO_COI, tmp);
+	core_q = FIELD_GET(RR_TXMO_COQ, tmp);
+	ch = (iqk_info->iqk_times / 2) % RTW89_IQK_CHS_NR;
+
+	if (core_i < 0x2 || core_i > 0x1d || core_q < 0x2 || core_q > 0x1d)
+		is_fail1 = true;
+	else
+		is_fail1 = false;
+
+	iqk_info->lok_idac[ch][path] = tmp;
+
+	tmp = rtw89_read_rf(rtwdev, path, RR_LOKVB, RFREG_MASK);
+	vbuff_i = FIELD_GET(RR_LOKVB_COI, tmp);
+	vbuff_q = FIELD_GET(RR_LOKVB_COQ, tmp);
+
+	if (vbuff_i < 0x2 || vbuff_i > 0x3d || vbuff_q < 0x2 || vbuff_q > 0x3d)
+		is_fail2 = true;
+	else
+		is_fail2 = false;
+
+	iqk_info->lok_vbuf[ch][path] = tmp;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, lok_idac[%x][%x] = 0x%x\n", path, ch, path,
+		    iqk_info->lok_idac[ch][path]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, lok_vbuf[%x][%x] = 0x%x\n", path, ch, path,
+		    iqk_info->lok_vbuf[ch][path]);
+
+	return is_fail1 | is_fail2;
+}
+
+static bool _iqk_lok(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool tmp;
+
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x021);
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x6);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x4);
+		break;
+	default:
+		break;
+	}
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, 0x9);
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_COARSE);
+	iqk_info->lok_cor_fail[0][path] = tmp;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, 0x24);
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_VBUFFER);
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x0);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, 0x9);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x021);
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_FINE);
+	iqk_info->lok_fin_fail[0][path] = tmp;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0x12);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, 0x24);
+	_iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_VBUFFER);
+
+	return _lok_finetune_check(rtwdev, path);
+}
+
+static void _iqk_txk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+
+	switch (iqk_info->iqk_band[path]) {
+	case RTW89_BAND_2G:
+		rtw89_write_rf(rtwdev, path, RR_XALNA2, RR_XALNA2_SW2, 0x00);
+		rtw89_write_rf(rtwdev, path, RR_TXG1, RR_TXG1_ATT2, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXG1, RR_TXG1_ATT1, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXG2, RR_TXG2_ATT0, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TXGA, RR_TXGA_LOK_EXT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M1, 0x00);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_IQK, 0x403e);
+		udelay(1);
+		break;
+	case RTW89_BAND_5G:
+		rtw89_write_rf(rtwdev, path, RR_XGLNA2, RR_XGLNA2_SW, 0x00);
+		rtw89_write_rf(rtwdev, path, RR_BIASA, RR_BIASA_A, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TXGA, RR_TXGA_LOK_EXT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M1, 0x80);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_IQK, 0x403e);
+		udelay(1);
+		break;
+	default:
+		break;
+	}
+}
+
+static void _iqk_txclk_setting(struct rtw89_dev *rtwdev, u8 path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x1f);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x13);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0001);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0041);
+}
+
+static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 tmp;
+	bool flag;
+
+	iqk_info->thermal[path] =
+		ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+	iqk_info->thermal_rek_en = false;
+
+	flag = iqk_info->lok_cor_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_FCOR << (path * 4), flag);
+	flag = iqk_info->lok_fin_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_FFIN << (path * 4), flag);
+	flag = iqk_info->iqk_tx_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_FTX << (path * 4), flag);
+	flag = iqk_info->iqk_rx_fail[0][path];
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_F_RX << (path * 4), flag);
+
+	tmp = rtw89_phy_read32_mask(rtwdev, R_IQK_RES + (path << 8), MASKDWORD);
+	iqk_info->bp_iqkenable[path] = tmp;
+	tmp = rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD);
+	iqk_info->bp_txkresult[path] = tmp;
+	tmp = rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD);
+	iqk_info->bp_rxkresult[path] = tmp;
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF2, B_IQKINF2_KCNT, iqk_info->iqk_times);
+
+	tmp = rtw89_phy_read32_mask(rtwdev, R_IQKINF, B_IQKINF_FAIL << (path * 4));
+	if (tmp)
+		iqk_info->iqk_fail_cnt++;
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF2, B_IQKINF2_FCNT << (path * 4),
+			       iqk_info->iqk_fail_cnt);
+}
+
+static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool lok_is_fail = false;
+	const int try = 3;
+	u8 ibias = 0x1;
+	u8 i;
+
+	_iqk_txclk_setting(rtwdev, path);
+
+	/* LOK */
+	for (i = 0; i < try; i++) {
+		_lok_res_table(rtwdev, path, ibias++);
+		_iqk_txk_setting(rtwdev, path);
+		lok_is_fail = _iqk_lok(rtwdev, phy_idx, path);
+		if (!lok_is_fail)
+			break;
+	}
+
+	if (lok_is_fail)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] LOK (%d) fail\n", path);
+
+	/* TXK */
+	if (iqk_info->is_nbiqk)
+		iqk_info->iqk_tx_fail[0][path] = _iqk_nbtxk(rtwdev, phy_idx, path);
+	else
+		iqk_info->iqk_tx_fail[0][path] = _txk_group_sel(rtwdev, phy_idx, path);
+
+	/* RX */
+	_iqk_rxclk_setting(rtwdev, path);
+	_iqk_rxk_setting(rtwdev, path);
+	if (iqk_info->is_nbiqk)
+		iqk_info->iqk_rx_fail[0][path] = _iqk_nbrxk(rtwdev, phy_idx, path);
+	else
+		iqk_info->iqk_rx_fail[0][path] = _rxk_group_sel(rtwdev, phy_idx, path);
+
+	_iqk_info_iqk(rtwdev, phy_idx, path);
+}
+
+static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 reg_rf18;
+	u32 reg_35c;
+	u8 idx;
+	u8 get_empty_table = false;
+
+	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
+		if (iqk_info->iqk_mcc_ch[idx][path] == 0) {
+			get_empty_table = true;
+			break;
+		}
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (1)idx = %x\n", idx);
+
+	if (!get_empty_table) {
+		idx = iqk_info->iqk_table_idx[path] + 1;
+		if (idx > 1)
+			idx = 0;
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (2)idx = %x\n", idx);
+
+	reg_rf18 = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+	reg_35c = rtw89_phy_read32_mask(rtwdev, R_CIRST, B_CIRST_SYN);
+
+	iqk_info->iqk_band[path] = chan->band_type;
+	iqk_info->iqk_bw[path] = chan->band_width;
+	iqk_info->iqk_ch[path] = chan->channel;
+	iqk_info->iqk_mcc_ch[idx][path] = chan->channel;
+	iqk_info->iqk_table_idx[path] = idx;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x18= 0x%x, idx = %x\n",
+		    path, reg_rf18, idx);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, 0x18= 0x%x\n",
+		    path, reg_rf18);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]times = 0x%x, ch =%x\n",
+		    iqk_info->iqk_times, idx);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]iqk_mcc_ch[%x][%x] = 0x%x\n",
+		    idx, path, iqk_info->iqk_mcc_ch[idx][path]);
+
+	if (reg_35c == 0x01)
+		iqk_info->syn1to2 = 0x1;
+	else
+		iqk_info->syn1to2 = 0x0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, iqk_info->syn1to2= 0x%x\n", path,
+		    iqk_info->syn1to2);
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, B_IQKINF_VER, RTW8852B_IQK_VER);
+	/* 2GHz/5GHz/6GHz = 0/1/2 */
+	rtw89_phy_write32_mask(rtwdev, R_IQKCH, B_IQKCH_BAND << (path * 16),
+			       iqk_info->iqk_band[path]);
+	/* 20/40/80 = 0/1/2 */
+	rtw89_phy_write32_mask(rtwdev, R_IQKCH, B_IQKCH_BW << (path * 16),
+			       iqk_info->iqk_bw[path]);
+	rtw89_phy_write32_mask(rtwdev, R_IQKCH, B_IQKCH_CH << (path * 16),
+			       iqk_info->iqk_ch[path]);
+}
+
+static void _iqk_start_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+{
+	_iqk_by_path(rtwdev, phy_idx, path);
+}
+
+static void _iqk_restore(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	bool fail;
+
+	rtw89_phy_write32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD,
+			       iqk_info->nb_txcfir[path]);
+	rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD,
+			       iqk_info->nb_rxcfir[path]);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD,
+			       0x00000e19 + (path << 4));
+	fail = _iqk_check_cal(rtwdev, path);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "%s result =%x\n", __func__, fail);
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000000);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x80000000);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_SYS, B_IQK_RES_K, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_IQRSN, B_IQRSN_K1, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_IQRSN, B_IQRSN_K2, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RR_LUTWE_LOK, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, 0x3);
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x1);
+}
+
+static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	const struct rtw89_reg3_def *def;
+	int size;
+	u8 kpath;
+	int i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "===> %s\n", __func__);
+
+	kpath = _kpath(rtwdev, phy_idx);
+
+	switch (kpath) {
+	case RF_A:
+	case RF_B:
+		return;
+	default:
+		size = ARRAY_SIZE(rtw8852b_restore_nondbcc_path01);
+		def = rtw8852b_restore_nondbcc_path01;
+		break;
+	}
+
+	for (i = 0; i < size; i++, def++)
+		rtw89_phy_write32_mask(rtwdev, def->addr, def->mask, def->data);
+}
+
+static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 idx;
+
+	idx = iqk_info->iqk_table_idx[path];
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (3)idx = %x\n", idx);
+
+	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), B_COEF_SEL_IQC, idx);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_G3, idx);
+
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000080);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x81ff010a);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK](1)S%x, 0x8%x54 = 0x%x\n", path, 1 << path,
+		    rtw89_phy_read32_mask(rtwdev, R_CFIR_LUT + (path << 8), MASKDWORD));
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK](1)S%x, 0x8%x04 = 0x%x\n", path, 1 << path,
+		    rtw89_phy_read32_mask(rtwdev, R_COEF_SEL + (path << 8), MASKDWORD));
+}
+
+static void _iqk_macbb_setting(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx, u8 path)
+{
+	const struct rtw89_reg3_def *def;
+	int size;
+	u8 kpath;
+	int i;
+
+	kpath = _kpath(rtwdev, phy_idx);
+
+	switch (kpath) {
+	case RF_A:
+	case RF_B:
+		return;
+	default:
+		size = ARRAY_SIZE(rtw8852b_set_nondbcc_path01);
+		def = rtw8852b_set_nondbcc_path01;
+		break;
+	}
+
+	for (i = 0; i < size; i++, def++)
+		rtw89_phy_write32_mask(rtwdev, def->addr, def->mask, def->data);
+}
+
+static void _iqk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 idx, path;
+
+	rtw89_phy_write32_mask(rtwdev, R_IQKINF, MASKDWORD, 0x0);
+	if (iqk_info->is_iqk_init)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
+	iqk_info->is_iqk_init = true;
+	iqk_info->is_nbiqk = false;
+	iqk_info->iqk_fft_en = false;
+	iqk_info->iqk_sram_en = false;
+	iqk_info->iqk_cfir_en = false;
+	iqk_info->iqk_xym_en = false;
+	iqk_info->thermal_rek_en = false;
+	iqk_info->iqk_times = 0x0;
+
+	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
+		iqk_info->iqk_channel[idx] = 0x0;
+		for (path = 0; path < RTW8852B_IQK_SS; path++) {
+			iqk_info->lok_cor_fail[idx][path] = false;
+			iqk_info->lok_fin_fail[idx][path] = false;
+			iqk_info->iqk_tx_fail[idx][path] = false;
+			iqk_info->iqk_rx_fail[idx][path] = false;
+			iqk_info->iqk_mcc_ch[idx][path] = 0x0;
+			iqk_info->iqk_table_idx[path] = 0x0;
+		}
+	}
+}
+
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 {
 	u32 rf_mode;
@@ -548,6 +1526,58 @@ static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 	}
 }
 
+static void _doiqk(struct rtw89_dev *rtwdev, bool force,
+		   enum rtw89_phy_idx phy_idx, u8 path)
+{
+	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u32 backup_bb_val[BACKUP_BB_REGS_NR];
+	u32 backup_rf_val[RTW8852B_IQK_SS][BACKUP_RF_REGS_NR];
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]==========IQK strat!!!!!==========\n");
+	iqk_info->iqk_times++;
+	iqk_info->kcount = 0;
+	iqk_info->version = RTW8852B_IQK_VER;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
+	_iqk_get_ch_info(rtwdev, phy_idx, path);
+
+	_rfk_backup_bb_reg(rtwdev, &backup_bb_val[0]);
+	_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
+	_iqk_macbb_setting(rtwdev, phy_idx, path);
+	_iqk_preset(rtwdev, path);
+	_iqk_start_iqk(rtwdev, phy_idx, path);
+	_iqk_restore(rtwdev, path);
+	_iqk_afebb_restore(rtwdev, phy_idx, path);
+	_rfk_restore_bb_reg(rtwdev, &backup_bb_val[0]);
+	_rfk_restore_rf_reg(rtwdev, &backup_rf_val[path][0], path);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
+}
+
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+{
+	u8 kpath = _kpath(rtwdev, phy_idx);
+
+	switch (kpath) {
+	case RF_A:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		break;
+	case RF_B:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		break;
+	case RF_AB:
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		break;
+	default:
+		break;
+	}
+}
+
 void rtw8852b_rck(struct rtw89_dev *rtwdev)
 {
 	u8 path;
@@ -565,6 +1595,22 @@ void rtw8852b_dack(struct rtw89_dev *rtwdev)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
 
+void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u32 tx_en;
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
+
+	_iqk_init(rtwdev);
+	_iqk(rtwdev, phy_idx, false);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
+}
+
 void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
index 24e492484d274..81eb9bddb6d7a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -9,6 +9,7 @@
 
 void rtw8852b_rck(struct rtw89_dev *rtwdev);
 void rtw8852b_dack(struct rtw89_dev *rtwdev);
+void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
-- 
2.25.1

