Return-Path: <linux-wireless+bounces-9361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA41911CED
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC834B23B7D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1213B59E;
	Fri, 21 Jun 2024 07:35:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5A16B732
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955325; cv=none; b=m8lrQBpZrlVCfQTc/tbX6lLKKCBUiyWDo37YWjN9FfULHz0rxznGwmjV49bCi3kwbz3WjFPsQ4UeUj5HCD7bfcDxw0xfezTutLMOeAarW7eSD67d4E3bxI+jTKQ+o9GYiEbEbkVi5rVBdI6j6phnrxMtNu22NS+ercqXyYDsDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955325; c=relaxed/simple;
	bh=E7IhsqoOiMpoIg69n2Oba7haRY68XRpn9W0vaZJjpbY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBGXGDiuExBcdJe4q0cM2ehiUnv2v/tZE+Ubxlr3Y1qXQrjpo6s66eAHO9ahrZsQ+InusIANRUXz6FMTAvv7kJ6k2MQ3YbDPyP+WxXqHdtBdM0E2JWki4lCxV4PrSkGPKd045MloTk+z9m3LTZ7EL7Me89u9Zfmkr0kGe1nznzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L7ZJU603868875, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L7ZJU603868875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 15:35:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 15:35:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 15:35:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: 8852bt: rfk: add DPK
Date: Fri, 21 Jun 2024 15:34:58 +0800
Message-ID: <20240621073458.55187-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621073458.55187-1-pkshih@realtek.com>
References: <20240621073458.55187-1-pkshih@realtek.com>
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

DPK is short for digital pre-distortion calibration. It can adjusts digital
waveform according to PA linear characteristics dynamically to enhance
TX EVM for high power.

Do this calibration when we are going to run on AP channel. To prevent
power offset out of boundary, it monitors thermal and set proper boundary
to register.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |    2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   24 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 1333 +++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |    3 +
 4 files changed, 1362 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e8ec0246bccd..06e14b80520d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4763,6 +4763,8 @@ struct rtw89_dpk_info {
 	u8 cur_idx[RTW89_DPK_RF_PATH];
 	u8 cur_k_set;
 	struct rtw89_dpk_bkup_para bp[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
+	u8 max_dpk_txagc[RTW89_DPK_RF_PATH];
+	u32 dpk_order[RTW89_DPK_RF_PATH];
 };
 
 struct rtw89_fem_info {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 68236fbc2f9a..449aeb264aef 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7870,6 +7870,7 @@
 #define R_RXCCA_BE1 0x0520
 #define B_RXCCA_BE1_DIS BIT(0)
 #define R_UPD_CLK_ADC 0x0700
+#define B_UPD_GEN_ON BIT(27)
 #define B_UPD_CLK_ADC_VAL GENMASK(26, 25)
 #define B_UPD_CLK_ADC_ON BIT(24)
 #define B_ENABLE_CCK BIT(5)
@@ -7938,6 +7939,8 @@
 #define B_MEASUREMENT_TRIG_MSK BIT(2)
 #define B_CCX_TRIG_OPT_MSK BIT(1)
 #define B_CCX_EN_MSK BIT(0)
+#define R_FAHM 0x0C1C
+#define B_RXTD_CKEN BIT(2)
 #define R_IFS_COUNTER 0x0C28
 #define B_IFS_CLM_PERIOD_MSK GENMASK(31, 16)
 #define B_IFS_CLM_COUNTER_UNIT_MSK GENMASK(15, 14)
@@ -7971,6 +7974,7 @@
 #define B_IQK_DPK_RST BIT(0)
 #define R_TX_COLLISION_T2R_ST 0x0C70
 #define B_TX_COLLISION_T2R_ST_M GENMASK(25, 20)
+#define B_TXRX_FORCE_VAL GENMASK(9, 0)
 #define R_TXGATING 0x0C74
 #define B_TXGATING_EN BIT(4)
 #define R_TXRFC 0x0C7C
@@ -8031,6 +8035,7 @@
 #define B_P0_RFMODE_FTM_RX GENMASK(11, 0)
 #define R_P0_NRBW 0x12B8
 #define B_P0_NRBW_DBG BIT(30)
+#define B_P0_NRBW_RSTB BIT(28)
 #define R_S0_RXDC 0x12D4
 #define B_S0_RXDC_I GENMASK(25, 16)
 #define B_S0_RXDC_Q GENMASK(31, 26)
@@ -8112,6 +8117,8 @@
 #define R_S0_ADDCK 0x1E00
 #define B_S0_ADDCK_I GENMASK(9, 0)
 #define B_S0_ADDCK_Q GENMASK(19, 10)
+#define R_TXCKEN_FORCE 0x2008
+#define B_TXCKEN_FORCE_ALL GENMASK(24, 0)
 #define R_EDCCA_RPT_SEL 0x20CC
 #define B_EDCCA_RPT_SEL_MSK GENMASK(2, 0)
 #define R_ADC_FIFO 0x20fc
@@ -8267,6 +8274,7 @@
 #define R_DCFO_COMP_S0 0x448C
 #define B_DCFO_COMP_S0_MSK GENMASK(11, 0)
 #define R_DCFO_WEIGHT 0x4490
+#define B_DAC_CLK_IDX BIT(31)
 #define B_DCFO_WEIGHT_MSK GENMASK(27, 24)
 #define R_DCFO_OPT 0x4494
 #define B_DCFO_OPT_EN BIT(29)
@@ -8629,6 +8637,8 @@
 #define B_P0_TMETER GENMASK(15, 10)
 #define B_P0_TMETER_DIS BIT(16)
 #define B_P0_TMETER_TRK BIT(24)
+#define R_P0_ADCFF_EN 0x58C8
+#define B_P0_ADCFF_EN BIT(24)
 #define R_P1_TSSIC 0x7814
 #define B_P1_TSSIC_BYPASS BIT(11)
 #define R_P0_TSSI_TRK 0x5818
@@ -8640,6 +8650,7 @@
 #define B_P0_TSSI_EN BIT(31)
 #define B_P0_TSSI_AVG GENMASK(15, 12)
 #define R_P0_RFCTM 0x5864
+#define B_P0_CLKG_FORCE GENMASK(31, 30)
 #define B_P0_RFCTM_EN BIT(29)
 #define B_P0_RFCTM_VAL GENMASK(25, 20)
 #define R_P0_RFCTM_RDY BIT(26)
@@ -8673,12 +8684,14 @@
 #define B_P0_RFM_BT_EN BIT(5)
 #define B_P0_RFM_OUT GENMASK(4, 0)
 #define R_P0_PATH_RST 0x58AC
+#define B_P0_PATH_RST BIT(27)
 #define R_P0_TXDPD 0x58D4
 #define B_P0_TXDPD GENMASK(31, 28)
 #define R_P0_TXPW_RSTB 0x58DC
 #define B_P0_TXPW_RSTB_MANON BIT(30)
 #define B_P0_TXPW_RSTB_TSSI BIT(31)
 #define R_P0_TSSI_MV_AVG 0x58E4
+#define B_P0_TXPW_RSTB GENMASK(28, 27)
 #define B_P0_TSSI_MV_MIX GENMASK(19, 11)
 #define B_P0_TSSI_MV_AVG GENMASK(13, 11)
 #define B_P0_TSSI_MV_CLR BIT(14)
@@ -8803,6 +8816,10 @@
 #define B_P1_TSSI_ALIM2 GENMASK(29, 0)
 #define R_P1_TSSI_ADC_CLK 0x766c
 #define B_P1_TSSI_ADC_CLK GENMASK(17, 16)
+#define R_P1_TXAGC_TH 0x7800
+#define B_P1_TXAGC_MAXMIN GENMASK(15, 0)
+#define R_P1_TXPW_FORCE 0x780C
+#define B_P1_TXPW_RDY BIT(15)
 #define R_P1_TSSIC 0x7814
 #define B_P1_TSSIC_BYPASS BIT(11)
 #define R_P1_TMETER 0x7810
@@ -8818,14 +8835,20 @@
 #define B_P1_TSSI_EN BIT(31)
 #define B_P1_TSSI_AVG GENMASK(15, 12)
 #define R_P1_RFCTM 0x7864
+#define B_P1_CLKG_FORCE GENMASK(31, 30)
+#define B_P1_GOT_TXRX GENMASK(28, 27)
 #define R_P1_RFCTM_RDY BIT(26)
 #define B_P1_RFCTM_VAL GENMASK(25, 20)
 #define B_P1_RFCTM_DEL GENMASK(19, 11)
 #define R_P1_PATH_RST 0x78AC
+#define B_P1_PATH_RST BIT(27)
+#define R_P1_ADCFF_EN 0x78C8
+#define B_P1_ADCFF_EN BIT(24)
 #define R_P1_TXPW_RSTB 0x78DC
 #define B_P1_TXPW_RSTB_MANON BIT(30)
 #define B_P1_TXPW_RSTB_TSSI BIT(31)
 #define R_P1_TSSI_MV_AVG 0x78E4
+#define B_P1_TXPW_RSTB GENMASK(28, 27)
 #define B_P1_TSSI_MV_MIX GENMASK(19, 11)
 #define B_P1_TSSI_MV_AVG GENMASK(13, 11)
 #define B_P1_TSSI_MV_CLR BIT(14)
@@ -9044,6 +9067,7 @@
 #define B_IQKINF2_FCNT GENMASK(23, 16)
 #define B_IQKINF2_KCNT GENMASK(15, 8)
 #define B_IQKINF2_NCTLV GENMASK(7, 0)
+#define R_RFK_ST 0xBFF8
 #define R_DCOF0 0xC000
 #define B_DCOF0_RST BIT(17)
 #define B_DCOF0_V GENMASK(4, 1)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index dcc15797f5db..d0a40eabfe2d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -13,9 +13,77 @@
 #include "rtw8852bt_rfk_table.h"
 #include "rtw8852b_common.h"
 
+#define RTW8852BT_SS 2
 #define RTW8852BT_TSSI_PATH_NR 2
+#define RTW8852BT_DPK_VER 0x06
+#define DPK_RF_PATH_MAX_8852BT 2
 
 #define _TSSI_DE_MASK GENMASK(21, 12)
+#define DPK_TXAGC_LOWER 0x2e
+#define DPK_TXAGC_UPPER 0x3f
+#define DPK_TXAGC_INVAL 0xff
+#define RFREG_MASKRXBB 0x003e0
+#define RFREG_MASKMODE 0xf0000
+
+enum rf_mode {
+	RF_SHUT_DOWN = 0x0,
+	RF_STANDBY = 0x1,
+	RF_TX = 0x2,
+	RF_RX = 0x3,
+	RF_TXIQK = 0x4,
+	RF_DPK = 0x5,
+	RF_RXK1 = 0x6,
+	RF_RXK2 = 0x7,
+};
+
+enum rtw8852bt_dpk_id {
+	LBK_RXIQK	= 0x06,
+	SYNC		= 0x10,
+	MDPK_IDL	= 0x11,
+	MDPK_MPA	= 0x12,
+	GAIN_LOSS	= 0x13,
+	GAIN_CAL	= 0x14,
+	DPK_RXAGC	= 0x15,
+	KIP_PRESET	= 0x16,
+	KIP_RESTORE	= 0x17,
+	DPK_TXAGC	= 0x19,
+	D_KIP_PRESET	= 0x28,
+	D_TXAGC		= 0x29,
+	D_RXAGC		= 0x2a,
+	D_SYNC		= 0x2b,
+	D_GAIN_LOSS	= 0x2c,
+	D_MDPK_IDL	= 0x2d,
+	D_GAIN_NORM	= 0x2f,
+	D_KIP_THERMAL	= 0x30,
+	D_KIP_RESTORE	= 0x31
+};
+
+enum dpk_agc_step {
+	DPK_AGC_STEP_SYNC_DGAIN,
+	DPK_AGC_STEP_GAIN_ADJ,
+	DPK_AGC_STEP_GAIN_LOSS_IDX,
+	DPK_AGC_STEP_GL_GT_CRITERION,
+	DPK_AGC_STEP_GL_LT_CRITERION,
+	DPK_AGC_STEP_SET_TX_GAIN,
+};
+
+enum adc_ck {
+	ADC_NA = 0,
+	ADC_480M = 1,
+	ADC_960M = 2,
+	ADC_1920M = 3,
+};
+
+enum dac_ck {
+	DAC_40M = 0,
+	DAC_80M = 1,
+	DAC_120M = 2,
+	DAC_160M = 3,
+	DAC_240M = 4,
+	DAC_320M = 5,
+	DAC_480M = 6,
+	DAC_960M = 7,
+};
 
 static const u32 _tssi_trigger[RTW8852BT_TSSI_PATH_NR] = {0x5820, 0x7820};
 static const u32 _tssi_cw_rpt_addr[RTW8852BT_TSSI_PATH_NR] = {0x1c18, 0x3c18};
@@ -33,6 +101,116 @@ static const u32 _tssi_de_mcs_80m_80m[RF_PATH_NUM_8852BT] = {0x5850, 0x7850};
 static const u32 _tssi_de_mcs_5m[RF_PATH_NUM_8852BT] = {0x5828, 0x7828};
 static const u32 _tssi_de_mcs_10m[RF_PATH_NUM_8852BT] = {0x5830, 0x7830};
 
+static const u32 rtw8852bt_backup_bb_regs[] = {0x2344, 0x5800, 0x7800, 0x0704};
+static const u32 rtw8852bt_backup_rf_regs[] = {
+	0xde, 0xdf, 0x8b, 0x90, 0x97, 0x85, 0x5, 0x10005};
+static const u32 rtw8852bt_backup_kip_regs[] = {
+	0x813c, 0x8124, 0x8120, 0xc0d4, 0xc0d8, 0xc0c4, 0xc0ec,
+	0x823c, 0x8224, 0x8220, 0xc1d4, 0xc1d8, 0xc1c4, 0xc1ec};
+
+#define BACKUP_BB_REGS_NR ARRAY_SIZE(rtw8852bt_backup_bb_regs)
+#define BACKUP_RF_REGS_NR ARRAY_SIZE(rtw8852bt_backup_rf_regs)
+#define BACKUP_KIP_REGS_NR ARRAY_SIZE(rtw8852bt_backup_kip_regs)
+
+static void _rfk_get_thermal(struct rtw89_dev *rtwdev, u8 kidx, enum rtw89_rf_path path)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x1);
+
+	udelay(200);
+
+	dpk->bp[path][kidx].ther_dpk = rtw89_read_rf(rtwdev, path, RR_TM, RR_TM_VAL);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] thermal@DPK = 0x%x\n",
+		    dpk->bp[path][kidx].ther_dpk);
+}
+
+static void _rfk_backup_bb_reg(struct rtw89_dev *rtwdev, u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		backup_bb_reg_val[i] =
+		rtw89_phy_read32_mask(rtwdev, rtw8852bt_backup_bb_regs[i], MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]backup bb reg : %x, value =%x\n",
+			    rtw8852bt_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_backup_kip_reg(struct rtw89_dev *rtwdev, u32 backup_kip_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_KIP_REGS_NR; i++) {
+		backup_kip_reg_val[i] =
+			rtw89_phy_read32_mask(rtwdev, rtw8852bt_backup_kip_regs[i],
+					      MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Backup 0x%x = %x\n",
+			    rtw8852bt_backup_kip_regs[i], backup_kip_reg_val[i]);
+	}
+}
+
+static
+void _rfk_backup_rf_reg(struct rtw89_dev *rtwdev, u32 backup_rf_reg_val[], u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		backup_rf_reg_val[i] =
+			rtw89_read_rf(rtwdev, rf_path, rtw8852bt_backup_rf_regs[i],
+				      RFREG_MASK);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Backup RF S%d 0x%x = %x\n",
+			    rf_path, rtw8852bt_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
+static void _rfk_reload_bb_reg(struct rtw89_dev *rtwdev, const u32 backup_bb_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_BB_REGS_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, rtw8852bt_backup_bb_regs[i],
+				       MASKDWORD, backup_bb_reg_val[i]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]restore bb reg : %x, value =%x\n",
+			    rtw8852bt_backup_bb_regs[i], backup_bb_reg_val[i]);
+	}
+}
+
+static void _rfk_reload_kip_reg(struct rtw89_dev *rtwdev, u32 backup_kip_reg_val[])
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_KIP_REGS_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, rtw8852bt_backup_kip_regs[i],
+				       MASKDWORD, backup_kip_reg_val[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]restore kip reg : %x, value =%x\n",
+			    rtw8852bt_backup_kip_regs[i], backup_kip_reg_val[i]);
+	}
+}
+
+static void _rfk_reload_rf_reg(struct rtw89_dev *rtwdev,
+			       const u32 backup_rf_reg_val[], u8 rf_path)
+{
+	u32 i;
+
+	for (i = 0; i < BACKUP_RF_REGS_NR; i++) {
+		rtw89_write_rf(rtwdev, rf_path, rtw8852bt_backup_rf_regs[i],
+			       RFREG_MASK, backup_rf_reg_val[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]restore rf S%d reg: %x, value =%x\n", rf_path,
+			    rtw8852bt_backup_rf_regs[i], backup_rf_reg_val[i]);
+	}
+}
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u8 val;
@@ -51,6 +229,124 @@ static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return val;
 }
 
+static
+void _txck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool force,
+		 enum dac_ck ck)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_TXCK_ON, 0x0);
+
+	if (!force)
+		return;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_TXCK_VAL, ck);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_TXCK_ON, 0x1);
+}
+
+static
+void _rxck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool force,
+		 enum adc_ck ck)
+{
+	u32 bw = 0;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_ON, 0x0);
+
+	if (!force)
+		return;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_VAL, ck);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_ON, 0x1);
+
+	switch (ck) {
+	case ADC_480M:
+		bw = RTW89_CHANNEL_WIDTH_40;
+		break;
+	case ADC_960M:
+		bw = RTW89_CHANNEL_WIDTH_80;
+		break;
+	case ADC_1920M:
+		bw = RTW89_CHANNEL_WIDTH_160;
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "%s==>Invalid ck", __func__);
+		break;
+	}
+
+	rtw8852bx_adc_cfg(rtwdev, bw, path);
+}
+
+static void _rfk_bb_afe_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path, u8 kpath)
+{
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, MASKHWORD, 0x0303);
+	rtw89_phy_write32_mask(rtwdev, R_P0_ADCFF_EN, B_P0_ADCFF_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_ADCFF_EN, B_P1_ADCFF_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_CLKG_FORCE, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_CLKG_FORCE, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_TXCKEN_FORCE, B_TXCKEN_FORCE_ALL, 0x1ffffff);
+	rtw89_phy_write32_mask(rtwdev, R_FAHM, B_RXTD_CKEN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_GEN_ON, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_TX_COLLISION_T2R_ST, B_TXRX_FORCE_VAL, 0x3ff);
+	rtw89_phy_write32_mask(rtwdev, R_IOQ_IQK_DPK, B_IOQ_IQK_DPK_CLKEN, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_RST, B_IQK_DPK_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_PATH_RST, B_P0_PATH_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_PATH_RST, B_P1_PATH_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DCFO_WEIGHT, B_DAC_CLK_IDX, 0x1);
+
+	_txck_force(rtwdev, RF_PATH_A, true, DAC_960M);
+	_txck_force(rtwdev, RF_PATH_B, true, DAC_960M);
+	_rxck_force(rtwdev, RF_PATH_A, true, ADC_1920M);
+	_rxck_force(rtwdev, RF_PATH_B, true, ADC_1920M);
+
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC,
+			       B_UPD_CLK_ADC_VAL | B_UPD_CLK_ADC_ON, 0x5);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, MASKBYTE3, 0x1f);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, MASKBYTE3, 0x13);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, MASKHWORD, 0x0001);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, MASKHWORD, 0x0041);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_RSTB, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, MASKHWORD, 0x3333);
+
+	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H, B_TXPWRB_RDY, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DPD_OFT_EN, MASKLWORD, 0x0000);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_FORCE, B_P1_TXPW_RDY, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXAGC_TH, MASKLWORD, 0x0000);
+}
+
+static void _rfk_bb_afe_restore(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path, u8 kpath)
+{
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, MASKHWORD, 0x0303);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_CLKG_FORCE, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_CLKG_FORCE, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_TXCKEN_FORCE, B_TXCKEN_FORCE_ALL, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_FAHM, B_RXTD_CKEN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_UPD_GEN_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_TX_COLLISION_T2R_ST, B_TXRX_FORCE_VAL, 0x63);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK, B_P0_TXCK_ALL, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RXCK, B_P1_TXCK_ALL, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC,
+			       B_UPD_CLK_ADC_VAL | B_UPD_CLK_ADC_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, MASKHWORD, 0x0000);
+	rtw89_phy_write32_mask(rtwdev, R_P0_ADCFF_EN, B_P0_ADCFF_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_ADCFF_EN, B_P1_ADCFF_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0);
+
+	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H, B_TXPWRB_RDY, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TXPW_RSTB, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TXPW_RSTB, 0x2);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_FORCE, B_P1_TXPW_RDY, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TXPW_RSTB, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TXPW_RSTB, 0x2);
+}
+
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 {
 	u32 rf_mode;
@@ -78,6 +374,1011 @@ static void _tmac_tx_pause(struct rtw89_dev *rtwdev, enum rtw89_phy_idx band_idx
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, band_idx));
 }
 
+static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool off)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 val, kidx = dpk->cur_idx[path];
+	bool off_reverse;
+
+	val = dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok;
+
+	if (off)
+		off_reverse = false;
+	else
+		off_reverse = true;
+
+	val = dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].path_ok;
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+			       BIT(24), val);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
+		    kidx, dpk->is_dpk_enable & off_reverse ? "enable" : "disable");
+}
+
+static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path, enum rtw8852bt_dpk_id id)
+{
+	u16 dpk_cmd;
+	u32 val;
+	int ret;
+
+	dpk_cmd = (id << 8) | (0x19 + (path << 4));
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, dpk_cmd);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x55,
+				       1, 30000, false,
+				       rtwdev, R_RFK_ST, MASKBYTE0);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] one-shot 1 over 30ms!!!!\n");
+
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, MASKDWORD, 0x00030000);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x8000,
+				       1, 2000, false,
+				       rtwdev, R_RPT_COM, MASKLWORD);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] one-shot 2 over 2ms!!!!\n");
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, MASKBYTE0, 0x0);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] one-shot for %s = 0x%04x\n",
+		    id == 0x06 ? "LBK_RXIQK" :
+		    id == 0x10 ? "SYNC" :
+		    id == 0x11 ? "MDPK_IDL" :
+		    id == 0x12 ? "MDPK_MPA" :
+		    id == 0x13 ? "GAIN_LOSS" :
+		    id == 0x14 ? "PWR_CAL" :
+		    id == 0x15 ? "DPK_RXAGC" :
+		    id == 0x16 ? "KIP_PRESET" :
+		    id == 0x17 ? "KIP_RESOTRE" :
+		    "DPK_TXAGC", dpk_cmd);
+}
+
+static void _dpk_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			enum rtw89_rf_path path)
+{
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x1);
+
+	udelay(600);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d RXDCK\n", path);
+}
+
+static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	u8 kidx = dpk->cur_idx[path];
+
+	dpk->bp[path][kidx].band = chan->band_type;
+	dpk->bp[path][kidx].ch = chan->channel;
+	dpk->bp[path][kidx].bw = chan->band_width;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
+		    path, dpk->cur_idx[path], phy,
+		    rtwdev->is_tssi_mode[path] ? "on" : "off",
+		    rtwdev->dbcc_en ? "on" : "off",
+		    dpk->bp[path][kidx].band == 0 ? "2G" :
+		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
+		    dpk->bp[path][kidx].ch,
+		    dpk->bp[path][kidx].bw == 0 ? "20M" :
+		    dpk->bp[path][kidx].bw == 1 ? "40M" : "80M");
+}
+
+static void _dpk_tssi_pause(struct rtw89_dev *rtwdev,
+			    enum rtw89_rf_path path, bool is_pause)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK + (path << 13),
+			       B_P0_TSSI_TRK_EN, is_pause);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d TSSI %s\n", path,
+		    is_pause ? "pause" : "resume");
+}
+
+static void _dpk_kip_restore(struct rtw89_dev *rtwdev,
+			     enum rtw89_rf_path path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000000);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x80000000);
+
+	if (rtwdev->hal.cv > CHIP_CAV)
+		rtw89_phy_write32_mask(rtwdev, R_DPD_COM + (path << 8),
+				       B_DPD_COM_OF, 0x1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d restore KIP\n", path);
+}
+
+static void _dpk_lbk_rxiqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			   enum rtw89_rf_path path, u8 cur_rxbb, u32 rf_18)
+{
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_RX_DCK, B_MDPK_RX_DCK_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8), B_IQK_RES_RXCFIR, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_RSV4, RFREG_MASK, rf_18);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASKMODE, 0xd);
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_PLLEN, 0x1);
+
+	if (cur_rxbb >= 0x11)
+		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT1, 0x13);
+	else if (cur_rxbb <= 0xa)
+		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT1, 0x00);
+	else
+		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT1, 0x05);
+
+	rtw89_write_rf(rtwdev, path, RR_XGLNA2, RR_XGLNA2_SW, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80014);
+
+	udelay(100);
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x025);
+
+	_dpk_one_shot(rtwdev, phy, path, LBK_RXIQK);
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_PLLEN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_RX_DCK, B_MDPK_RX_DCK_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_KPATH_CFG, B_KPATH_CFG_ED, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_DI, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASKMODE, 0x5);
+}
+
+static void _dpk_rf_setting(struct rtw89_dev *rtwdev, u8 gain,
+			    enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].band == RTW89_BAND_2G) {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK, 0x50220);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_FATT, 0xf2);
+		rtw89_write_rf(rtwdev, path, RR_LUTDBG, RR_LUTDBG_TIA, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TIA, RR_TIA_N6, 0x1);
+	} else {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK, 0x50220);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RAA2_SWATT, 0x5);
+		rtw89_write_rf(rtwdev, path, RR_LUTDBG, RR_LUTDBG_TIA, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TIA, RR_TIA_N6, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_RXA_LNA, RFREG_MASK, 0x920FC);
+		rtw89_write_rf(rtwdev, path, RR_XALNA2, RFREG_MASK, 0x002C0);
+		rtw89_write_rf(rtwdev, path, RR_IQGEN, RFREG_MASK, 0x38800);
+	}
+
+	rtw89_write_rf(rtwdev, path, RR_RCKD, RR_RCKD_BW, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_BTC, RR_BTC_TXBB, dpk->bp[path][kidx].bw + 1);
+	rtw89_write_rf(rtwdev, path, RR_BTC, RR_BTC_RXBB, 0x0);
+}
+
+static void _dpk_bypass_rxcfir(struct rtw89_dev *rtwdev,
+			       enum rtw89_rf_path path, bool is_bypass)
+{
+	if (is_bypass) {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       B_RXIQC_BYPASS2, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       B_RXIQC_BYPASS, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       B_RXIQC_BYPASS2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       B_RXIQC_BYPASS, 0x0);
+	}
+}
+
+static
+void _dpk_tpg_sel(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_80)
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x0);
+	else if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_40)
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x2);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] TPG_Select for %s\n",
+		    dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_80 ? "80M" :
+		    dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_40 ? "40M" : "20M");
+}
+
+static void _dpk_table_select(struct rtw89_dev *rtwdev,
+			      enum rtw89_rf_path path, u8 kidx, u8 gain)
+{
+	u8 val;
+
+	val = 0x80 + kidx * 0x20 + gain * 0x10;
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0 + (path << 8), MASKBYTE3, val);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] table select for Kidx[%d], Gain[%d] (0x%x)\n", kidx,
+		    gain, val);
+}
+
+static bool _dpk_sync_check(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
+{
+#define DPK_SYNC_TH_DC_I 200
+#define DPK_SYNC_TH_DC_Q 200
+#define DPK_SYNC_TH_CORR 170
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 corr_val, corr_idx;
+	u16 dc_i, dc_q;
+	u32 corr, dc;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x0);
+
+	corr = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKDWORD);
+	corr_idx = u32_get_bits(corr, B_PRT_COM_CORI);
+	corr_val = u32_get_bits(corr, B_PRT_COM_CORV);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] S%d Corr_idx / Corr_val = %d / %d\n",
+		    path, corr_idx, corr_val);
+
+	dpk->corr_idx[path][kidx] = corr_idx;
+	dpk->corr_val[path][kidx] = corr_val;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x9);
+
+	dc = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKDWORD);
+	dc_i = u32_get_bits(dc, B_PRT_COM_DCI);
+	dc_q = u32_get_bits(dc, B_PRT_COM_DCQ);
+
+	dc_i = abs(sign_extend32(dc_i, 11));
+	dc_q = abs(sign_extend32(dc_q, 11));
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d DC I/Q, = %d / %d\n",
+		    path, dc_i, dc_q);
+
+	dpk->dc_i[path][kidx] = dc_i;
+	dpk->dc_q[path][kidx] = dc_q;
+
+	if (dc_i > DPK_SYNC_TH_DC_I || dc_q > DPK_SYNC_TH_DC_Q ||
+	    corr_val < DPK_SYNC_TH_CORR)
+		return true;
+	else
+		return false;
+}
+
+static void _dpk_sync(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		      enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_one_shot(rtwdev, phy, path, SYNC);
+}
+
+static u16 _dpk_dgain_read(struct rtw89_dev *rtwdev)
+{
+	u16 dgain;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x0);
+
+	dgain = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DCI);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] DGain = 0x%x\n", dgain);
+
+	return dgain;
+}
+
+static s8 _dpk_dgain_mapping(struct rtw89_dev *rtwdev, u16 dgain)
+{
+	static const u16 bnd[15] = {
+		0xbf1, 0xaa5, 0x97d, 0x875, 0x789, 0x6b7, 0x5fc, 0x556,
+		0x4c1, 0x43d, 0x3c7, 0x35e, 0x2ac, 0x262, 0x220
+	};
+	s8 offset;
+
+	if (dgain >= bnd[0])
+		offset = 0x6;
+	else if (bnd[0] > dgain && dgain >= bnd[1])
+		offset = 0x6;
+	else if (bnd[1] > dgain && dgain >= bnd[2])
+		offset = 0x5;
+	else if (bnd[2] > dgain && dgain >= bnd[3])
+		offset = 0x4;
+	else if (bnd[3] > dgain && dgain >= bnd[4])
+		offset = 0x3;
+	else if (bnd[4] > dgain && dgain >= bnd[5])
+		offset = 0x2;
+	else if (bnd[5] > dgain && dgain >= bnd[6])
+		offset = 0x1;
+	else if (bnd[6] > dgain && dgain >= bnd[7])
+		offset = 0x0;
+	else if (bnd[7] > dgain && dgain >= bnd[8])
+		offset = 0xff;
+	else if (bnd[8] > dgain && dgain >= bnd[9])
+		offset = 0xfe;
+	else if (bnd[9] > dgain && dgain >= bnd[10])
+		offset = 0xfd;
+	else if (bnd[10] > dgain && dgain >= bnd[11])
+		offset = 0xfc;
+	else if (bnd[11] > dgain && dgain >= bnd[12])
+		offset = 0xfb;
+	else if (bnd[12] > dgain && dgain >= bnd[13])
+		offset = 0xfa;
+	else if (bnd[13] > dgain && dgain >= bnd[14])
+		offset = 0xf9;
+	else if (bnd[14] > dgain)
+		offset = 0xf8;
+	else
+		offset = 0x0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] DGain offset = %d\n", offset);
+
+	return offset;
+}
+
+static u8 _dpk_gainloss_read(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x6);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG2, B_DPK_CFG2_ST, 0x1);
+
+	return rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_GL);
+}
+
+static void _dpk_gainloss(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_one_shot(rtwdev, phy, path, GAIN_LOSS);
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x6);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG2, B_DPK_CFG2_ST, 0x1);
+}
+
+static void _dpk_kip_preset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_tpg_sel(rtwdev, path, kidx);
+	_dpk_one_shot(rtwdev, phy, path, KIP_PRESET);
+}
+
+static void _dpk_kip_pwr_clk_on(struct rtw89_dev *rtwdev,
+				enum rtw89_rf_path path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000080);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x807f030a);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_SYS + (path << 8), MASKDWORD, 0xce000a08);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] KIP Power/CLK on\n");
+}
+
+static
+u8 _dpk_txagc_check_8852bt(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 txagc)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (txagc >= dpk->max_dpk_txagc[path])
+		txagc = dpk->max_dpk_txagc[path];
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Set TxAGC = 0x%x\n", txagc);
+
+	return txagc;
+}
+
+static void _dpk_kip_set_txagc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			       enum rtw89_rf_path path, u8 txagc)
+{
+	u8 val;
+
+	val = _dpk_txagc_check_8852bt(rtwdev, path, txagc);
+	rtw89_write_rf(rtwdev, path, RR_TXAGC, RFREG_MASK, val);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	_dpk_one_shot(rtwdev, phy, path, DPK_TXAGC);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] set TXAGC = 0x%x\n", txagc);
+}
+
+static void _dpk_kip_set_rxagc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			       enum rtw89_rf_path path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_KIP_MOD, B_KIP_MOD, 0x50220);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	_dpk_one_shot(rtwdev, phy, path, DPK_RXAGC);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+}
+
+static u8 _dpk_set_offset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path, u8 txagc, s8 gain_offset)
+{
+	txagc = rtw89_read_rf(rtwdev, path, RR_TXAGC, RFREG_MASK);
+
+	if ((txagc - gain_offset) < DPK_TXAGC_LOWER)
+		txagc = DPK_TXAGC_LOWER;
+	else if ((txagc - gain_offset) > DPK_TXAGC_UPPER)
+		txagc = DPK_TXAGC_UPPER;
+	else
+		txagc = txagc - gain_offset;
+
+	_dpk_kip_set_txagc(rtwdev, phy, path, txagc);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] tmp_txagc (GL=%d) = 0x%x\n",
+		    gain_offset, txagc);
+	return txagc;
+}
+
+static bool _dpk_pas_read(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			  u8 is_check)
+{
+	u32 val1_i = 0, val1_q = 0, val2_i = 0, val2_q = 0;
+	u8 i;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, MASKBYTE2, 0x06);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG2, B_DPK_CFG2_ST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE2, 0x08);
+
+	if (is_check) {
+		rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE3, 0x00);
+		val1_i = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKHWORD);
+		val1_i = abs(sign_extend32(val1_i, 11));
+		val1_q = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKLWORD);
+		val1_q = abs(sign_extend32(val1_q, 11));
+
+		rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE3, 0x1f);
+		val2_i = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKHWORD);
+		val2_i = abs(sign_extend32(val2_i, 11));
+		val2_q = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKLWORD);
+		val2_q = abs(sign_extend32(val2_q, 11));
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] PAS_delta = 0x%x\n",
+			    phy_div(val1_i * val1_i + val1_q * val1_q,
+				    val2_i * val2_i + val2_q * val2_q));
+	} else {
+		for (i = 0; i < 32; i++) {
+			rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE3, i);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[DPK] PAS_Read[%02d]= 0x%08x\n", i,
+				    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKDWORD));
+		}
+	}
+
+	if (val1_i * val1_i + val1_q * val1_q >=
+	    (val2_i * val2_i + val2_q * val2_q) * 8 / 5)
+		return true;
+
+	return false;
+}
+
+static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   enum rtw89_rf_path path, u8 kidx, u8 init_txagc,
+		   bool loss_only)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 goout = 0, agc_cnt = 0, limited_rxbb = 0, gl_cnt = 0;
+	u8 tmp_txagc, tmp_rxbb, tmp_gl_idx = 0;
+	u8 step = DPK_AGC_STEP_SYNC_DGAIN;
+	int limit = 200;
+	s8 offset = 0;
+	u16 dgain = 0;
+	u32 rf_18;
+
+	tmp_txagc = init_txagc;
+
+	tmp_rxbb = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASKRXBB);
+	rf_18 = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+
+	do {
+		switch (step) {
+		case DPK_AGC_STEP_SYNC_DGAIN:
+			_dpk_sync(rtwdev, phy, path, kidx);
+			if (agc_cnt == 0) {
+				if (chan->band_width < 2)
+					_dpk_bypass_rxcfir(rtwdev, path, true);
+				else
+					_dpk_lbk_rxiqk(rtwdev, phy, path,
+						       tmp_rxbb, rf_18);
+			}
+
+			if (_dpk_sync_check(rtwdev, path, kidx) == true) {
+				tmp_txagc = 0xff;
+				goout = 1;
+				break;
+			}
+
+			dgain = _dpk_dgain_read(rtwdev);
+			offset = _dpk_dgain_mapping(rtwdev, dgain);
+
+			if (loss_only == 1 || limited_rxbb == 1 || offset == 0)
+				step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+			else
+				step = DPK_AGC_STEP_GAIN_ADJ;
+			break;
+		case DPK_AGC_STEP_GAIN_ADJ:
+			tmp_rxbb = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASKRXBB);
+
+			if (tmp_rxbb + offset > 0x1f) {
+				tmp_rxbb = 0x1f;
+				limited_rxbb = 1;
+			} else if (tmp_rxbb + offset < 0) {
+				tmp_rxbb = 0;
+				limited_rxbb = 1;
+			} else {
+				tmp_rxbb = tmp_rxbb + offset;
+			}
+
+			rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASKRXBB, tmp_rxbb);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[DPK] Adjust RXBB (%d) = 0x%x\n", offset, tmp_rxbb);
+
+			if (chan->band_width == RTW89_CHANNEL_WIDTH_80)
+				_dpk_lbk_rxiqk(rtwdev, phy, path, tmp_rxbb, rf_18);
+			if (dgain > 1922 || dgain < 342)
+				step = DPK_AGC_STEP_SYNC_DGAIN;
+			else
+				step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+
+			agc_cnt++;
+			break;
+		case DPK_AGC_STEP_GAIN_LOSS_IDX:
+			_dpk_gainloss(rtwdev, phy, path, kidx);
+
+			tmp_gl_idx = _dpk_gainloss_read(rtwdev);
+
+			if ((tmp_gl_idx == 0 && _dpk_pas_read(rtwdev, path, true)) ||
+			    tmp_gl_idx >= 7)
+				step = DPK_AGC_STEP_GL_GT_CRITERION;
+			else if (tmp_gl_idx == 0)
+				step = DPK_AGC_STEP_GL_LT_CRITERION;
+			else
+				step = DPK_AGC_STEP_SET_TX_GAIN;
+
+			gl_cnt++;
+			break;
+		case DPK_AGC_STEP_GL_GT_CRITERION:
+			if (tmp_txagc == 0x2e ||
+			    tmp_txagc == dpk->max_dpk_txagc[path]) {
+				goout = 1;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[DPK] Txagc@lower bound!!\n");
+			} else {
+				tmp_txagc = _dpk_set_offset(rtwdev, phy, path,
+							    tmp_txagc, 0x3);
+			}
+			step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+			agc_cnt++;
+			break;
+
+		case DPK_AGC_STEP_GL_LT_CRITERION:
+			if (tmp_txagc == 0x3f || tmp_txagc == dpk->max_dpk_txagc[path]) {
+				goout = 1;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[DPK] Txagc@upper bound!!\n");
+			} else {
+				tmp_txagc = _dpk_set_offset(rtwdev, phy, path,
+							    tmp_txagc, 0xfe);
+			}
+			step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+			agc_cnt++;
+			break;
+
+		case DPK_AGC_STEP_SET_TX_GAIN:
+			tmp_txagc = _dpk_set_offset(rtwdev, phy, path, tmp_txagc,
+						    tmp_gl_idx);
+			goout = 1;
+			agc_cnt++;
+			break;
+
+		default:
+			goout = 1;
+			break;
+		}
+	} while (!goout && agc_cnt < 6 && limit-- > 0);
+
+	if (gl_cnt >= 6)
+		_dpk_pas_read(rtwdev, path, false);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Txagc / RXBB for DPK = 0x%x / 0x%x\n", tmp_txagc, tmp_rxbb);
+
+	return tmp_txagc;
+}
+
+static void _dpk_set_mdpd_para(struct rtw89_dev *rtwdev,
+			       enum rtw89_rf_path path, u8 order)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	switch (order) {
+	case 0: /* (5,3,1) */
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP, order);
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_PN, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_MAN, 0x1);
+		dpk->dpk_order[path] = 0x3;
+		break;
+	case 1: /* (5,3,0) */
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP, order);
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_PN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_MAN, 0x0);
+		dpk->dpk_order[path] = 0x1;
+		break;
+	case 2: /* (5,0,0) */
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP, order);
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_PN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_MAN, 0x0);
+		dpk->dpk_order[path] = 0x0;
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Wrong MDPD order!!(0x%x)\n", order);
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Set %s for IDL\n",
+		    order == 0x0 ? "(5,3,1)" :
+		    order == 0x1 ? "(5,3,0)" : "(5,0,0)");
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Set MDPD order to 0x%x for IDL\n", order);
+}
+
+static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 enum rtw89_rf_path path, u8 kidx, u8 gain)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].bw < RTW89_CHANNEL_WIDTH_80 &&
+	    dpk->bp[path][kidx].band == RTW89_BAND_5G)
+		_dpk_set_mdpd_para(rtwdev, path, 0x2);
+	else
+		_dpk_set_mdpd_para(rtwdev, path, 0x0);
+
+	_dpk_one_shot(rtwdev, phy, path, MDPK_IDL);
+}
+
+static void _dpk_fill_result(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path, u8 kidx, u8 gain, u8 txagc)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 gs = dpk->dpk_gs[phy];
+	u16 pwsf = 0x78;
+
+	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), BIT(8), kidx);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Fill txagc/ pwsf/ gs = 0x%x/ 0x%x/ 0x%x\n",
+		    txagc, pwsf, gs);
+
+	dpk->bp[path][kidx].txagc_dpk = txagc;
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_RFK + (path << 8),
+			       0x3F << ((gain << 3) + (kidx << 4)), txagc);
+
+	dpk->bp[path][kidx].pwsf = pwsf;
+	rtw89_phy_write32_mask(rtwdev, R_DPD_BND + (path << 8) + (kidx << 2),
+			       0x1FF << (gain << 4), pwsf);
+
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_MDPD, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_MDPD, 0x0);
+
+	dpk->bp[path][kidx].gs = gs;
+	if (dpk->dpk_gs[phy] == 0x7f)
+		rtw89_phy_write32_mask(rtwdev,
+				       R_DPD_CH0A + (path << 8) + (kidx << 2),
+				       MASKDWORD, 0x007f7f7f);
+	else
+		rtw89_phy_write32_mask(rtwdev,
+				       R_DPD_CH0A + (path << 8) + (kidx << 2),
+				       MASKDWORD, 0x005b5b5b);
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+			       B_DPD_ORDER_V1, dpk->dpk_order[path]);
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_V1 + (path << 8), MASKDWORD, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_SEL, 0x0);
+}
+
+static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			      enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 idx, cur_band, cur_ch;
+	bool is_reload = false;
+
+	cur_band = chan->band_type;
+	cur_ch = chan->channel;
+
+	for (idx = 0; idx < RTW89_DPK_BKUP_NUM; idx++) {
+		if (cur_band != dpk->bp[path][idx].band ||
+		    cur_ch != dpk->bp[path][idx].ch)
+			continue;
+
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8),
+				       B_COEF_SEL_MDPD, idx);
+		dpk->cur_idx[path] = idx;
+		is_reload = true;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] reload S%d[%d] success\n", path, idx);
+	}
+
+	return is_reload;
+}
+
+static
+void _rf_direct_cntrl(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool is_bybb)
+{
+	if (is_bybb)
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x1);
+	else
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+}
+
+static
+void _drf_direct_cntrl(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool is_bybb)
+{
+	if (is_bybb)
+		rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x1);
+	else
+		rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x0);
+}
+
+static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		      enum rtw89_rf_path path, u8 gain)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 txagc = 0x38, kidx = dpk->cur_idx[path];
+	bool is_fail = false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] ========= S%d[%d] DPK Start =========\n", path, kidx);
+
+	_rf_direct_cntrl(rtwdev, path, false);
+	_drf_direct_cntrl(rtwdev, path, false);
+
+	_dpk_kip_pwr_clk_on(rtwdev, path);
+	_dpk_kip_set_txagc(rtwdev, phy, path, txagc);
+	_dpk_rf_setting(rtwdev, gain, path, kidx);
+	_dpk_rx_dck(rtwdev, phy, path);
+	_dpk_kip_preset(rtwdev, phy, path, kidx);
+	_dpk_kip_set_rxagc(rtwdev, phy, path);
+	_dpk_table_select(rtwdev, path, kidx, gain);
+
+	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false);
+
+	_rfk_get_thermal(rtwdev, kidx, path);
+
+	if (txagc == 0xff) {
+		is_fail = true;
+		goto _error;
+	}
+
+	_dpk_idl_mpa(rtwdev, phy, path, kidx, gain);
+
+	rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASKMODE, RF_RX);
+	_dpk_fill_result(rtwdev, phy, path, kidx, gain, txagc);
+
+_error:
+	if (!is_fail)
+		dpk->bp[path][kidx].path_ok = 1;
+	else
+		dpk->bp[path][kidx].path_ok = 0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s\n", path, kidx,
+		    is_fail ? "Check" : "Success");
+
+	_dpk_onoff(rtwdev, path, is_fail);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s\n", path, kidx,
+		    is_fail ? "Check" : "Success");
+
+	return is_fail;
+}
+
+static void _dpk_cal_select(struct rtw89_dev *rtwdev,
+			    enum rtw89_phy_idx phy, u8 kpath)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u32 backup_kip_val[BACKUP_KIP_REGS_NR];
+	u32 backup_bb_val[BACKUP_BB_REGS_NR];
+	u32 backup_rf_val[RTW8852BT_SS][BACKUP_RF_REGS_NR];
+	bool reloaded[2] = {false};
+	u8 path;
+
+	for (path = 0; path < DPK_RF_PATH_MAX_8852BT; path++) {
+		reloaded[path] = _dpk_reload_check(rtwdev, phy, path);
+		if (!reloaded[path] && dpk->bp[path][0].ch != 0)
+			dpk->cur_idx[path] = !dpk->cur_idx[path];
+		else
+			_dpk_onoff(rtwdev, path, false);
+	}
+
+	_rfk_backup_bb_reg(rtwdev, backup_bb_val);
+	_rfk_backup_kip_reg(rtwdev, backup_kip_val);
+
+	for (path = 0; path < DPK_RF_PATH_MAX_8852BT; path++) {
+		_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
+		_dpk_information(rtwdev, phy, path);
+		if (rtwdev->is_tssi_mode[path])
+			_dpk_tssi_pause(rtwdev, path, true);
+	}
+
+	_rfk_bb_afe_setting(rtwdev, phy, path, kpath);
+
+	for (path = 0; path < DPK_RF_PATH_MAX_8852BT; path++)
+		_dpk_main(rtwdev, phy, path, 1);
+
+	_rfk_bb_afe_restore(rtwdev, phy, path, kpath);
+
+	_dpk_kip_restore(rtwdev, path);
+	_rfk_reload_bb_reg(rtwdev, backup_bb_val);
+	_rfk_reload_kip_reg(rtwdev, backup_kip_val);
+
+	for (path = 0; path < DPK_RF_PATH_MAX_8852BT; path++) {
+		_rfk_reload_rf_reg(rtwdev, backup_rf_val[path], path);
+		if (rtwdev->is_tssi_mode[path])
+			_dpk_tssi_pause(rtwdev, path, false);
+	}
+}
+
+static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_fem_info *fem = &rtwdev->fem;
+
+	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Skip DPK due to 2G_ext_PA exist!!\n");
+		return true;
+	} else if (fem->epa_5g && chan->band_type == RTW89_BAND_5G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Skip DPK due to 5G_ext_PA exist!!\n");
+		return true;
+	} else if (fem->epa_6g && chan->band_type == RTW89_BAND_6G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Skip DPK due to 6G_ext_PA exist!!\n");
+		return true;
+	}
+
+	return false;
+}
+
+static void _dpk_force_bypass(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u8 path, kpath;
+
+	kpath = _kpath(rtwdev, phy);
+
+	for (path = 0; path < RTW8852BT_SS; path++) {
+		if (kpath & BIT(path))
+			_dpk_onoff(rtwdev, path, true);
+	}
+}
+
+static void _dpk_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	s8 txagc_bb, txagc_bb_tp, ini_diff = 0, txagc_ofst;
+	s8 delta_ther[2] = {};
+	u8 trk_idx, txagc_rf;
+	u8 path, kidx;
+	u16 pwsf[2];
+	u8 cur_ther;
+	u32 tmp;
+
+	for (path = 0; path < RF_PATH_NUM_8852BT; path++) {
+		kidx = dpk->cur_idx[path];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] ================[S%d[%d] (CH %d)]================\n",
+			    path, kidx, dpk->bp[path][kidx].ch);
+
+		cur_ther = ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] thermal now = %d\n", cur_ther);
+
+		if (dpk->bp[path][kidx].ch && cur_ther)
+			delta_ther[path] = dpk->bp[path][kidx].ther_dpk - cur_ther;
+
+		if (dpk->bp[path][kidx].band == RTW89_BAND_2G)
+			delta_ther[path] = delta_ther[path] * 3 / 2;
+		else
+			delta_ther[path] = delta_ther[path] * 5 / 2;
+
+		txagc_rf = rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13),
+						 B_TXAGC_RF);
+
+		if (rtwdev->is_tssi_mode[path]) {
+			trk_idx = rtw89_read_rf(rtwdev, path, RR_TXA, RR_TXA_TRK);
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] txagc_RF / track_idx = 0x%x / %d\n",
+				    txagc_rf, trk_idx);
+
+			txagc_bb =
+				rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13),
+						      MASKBYTE2);
+			txagc_bb_tp =
+				rtw89_phy_read32_mask(rtwdev, R_TXAGC_TP + (path << 13),
+						      B_TXAGC_TP);
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] txagc_bb_tp / txagc_bb = 0x%x / 0x%x\n",
+				    txagc_bb_tp, txagc_bb);
+
+			txagc_ofst =
+				rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13),
+						      MASKBYTE3);
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] txagc_offset / delta_ther = %d / %d\n",
+				    txagc_ofst, delta_ther[path]);
+			tmp = rtw89_phy_read32_mask(rtwdev, R_DPD_COM + (path << 8),
+						    B_DPD_COM_OF);
+			if (tmp == 0x1) {
+				txagc_ofst = 0;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+					    "[DPK_TRK] HW txagc offset mode\n");
+			}
+
+			if (txagc_rf && cur_ther)
+				ini_diff = txagc_ofst + (delta_ther[path]);
+
+			tmp = rtw89_phy_read32_mask(rtwdev,
+						    R_P0_TXDPD + (path << 13),
+						    B_P0_TXDPD);
+			if (tmp == 0x0) {
+				pwsf[0] = dpk->bp[path][kidx].pwsf +
+					  txagc_bb_tp - txagc_bb + ini_diff;
+				pwsf[1] = dpk->bp[path][kidx].pwsf +
+					  txagc_bb_tp - txagc_bb + ini_diff;
+			} else {
+				pwsf[0] = dpk->bp[path][kidx].pwsf + ini_diff;
+				pwsf[1] = dpk->bp[path][kidx].pwsf + ini_diff;
+			}
+		} else {
+			pwsf[0] = (dpk->bp[path][kidx].pwsf + delta_ther[path]) & 0x1ff;
+			pwsf[1] = (dpk->bp[path][kidx].pwsf + delta_ther[path]) & 0x1ff;
+		}
+
+		tmp = rtw89_phy_read32_mask(rtwdev, R_DPK_TRK, B_DPK_TRK_DIS);
+		if (!tmp && txagc_rf) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] New pwsf[0] / pwsf[1] = 0x%x / 0x%x\n",
+				    pwsf[0], pwsf[1]);
+
+			rtw89_phy_write32_mask(rtwdev,
+					       R_DPD_BND + (path << 8) + (kidx << 2),
+					       B_DPD_BND_0, pwsf[0]);
+			rtw89_phy_write32_mask(rtwdev,
+					       R_DPD_BND + (path << 8) + (kidx << 2),
+					       B_DPD_BND_1, pwsf[1]);
+		}
+	}
+}
+
+static void _set_dpd_backoff(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 tx_scale, ofdm_bkof, path, kpath;
+
+	kpath = _kpath(rtwdev, phy);
+
+	ofdm_bkof = rtw89_phy_read32_mask(rtwdev, R_DPD_BF + (phy << 13), B_DPD_BF_OFDM);
+	tx_scale = rtw89_phy_read32_mask(rtwdev, R_DPD_BF + (phy << 13), B_DPD_BF_SCA);
+
+	if (ofdm_bkof + tx_scale >= 44) {
+		/* move dpd backoff to bb, and set dpd backoff to 0 */
+		dpk->dpk_gs[phy] = 0x7f;
+		for (path = 0; path < RF_PATH_NUM_8852BT; path++) {
+			if (!(kpath & BIT(path)))
+				continue;
+
+			rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8),
+					       B_DPD_CFG, 0x7f7f7f);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[RFK] Set S%d DPD backoff to 0dB\n", path);
+		}
+	} else {
+		dpk->dpk_gs[phy] = 0x5b;
+	}
+}
+
 static void _tssi_dpk_off(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A, BIT(24), 0x0);
@@ -1077,6 +2378,38 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		    tssi_info->tssi_alimk_time);
 }
 
+void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	u8 path;
+
+	for (path = 0; path < 2; path++) {
+		dpk->cur_idx[path] = 0;
+		dpk->max_dpk_txagc[path] = 0x3F;
+	}
+
+	dpk->is_dpk_enable = true;
+	dpk->is_dpk_reload_en = false;
+	_set_dpd_backoff(rtwdev, RTW89_PHY_0);
+}
+
+void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] ****** DPK Start (Ver: 0x%x) ******\n", RTW8852BT_DPK_VER);
+
+	if (_dpk_bypass_check(rtwdev, phy_idx))
+		_dpk_force_bypass(rtwdev, phy_idx);
+	else
+		_dpk_cal_select(rtwdev, phy_idx, RF_AB);
+}
+
+void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev)
+{
+	_dpk_track(rtwdev);
+}
+
 void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
 {
 	static const u32 reg[2] = {R_DPD_CH0A, R_DPD_CH0B};
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index 03fad3abe554..89640b42d4d0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -7,6 +7,9 @@
 
 #include "core.h"
 
+void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev);
+void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev);
 void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en);
 void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-- 
2.25.1


