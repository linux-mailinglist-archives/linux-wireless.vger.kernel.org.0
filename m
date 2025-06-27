Return-Path: <linux-wireless+bounces-24601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2246AEAD97
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72D41C21C10
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EED199FD0;
	Fri, 27 Jun 2025 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QHJFG3cg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF52AD2D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996443; cv=none; b=e4muvMCJmSPD3/EeAaEl6qYZLq7JqZXpu3M3RRvJlUCzQ5AqWvBV1HuKtIIPNbkYaQ5QH3ezHnwgWQdmTKVkJQaF29rbr/aecSYBasaKJziY0QEYAOR3oUBtLzZM0m4sKd42ir0ZuVLYXY04KqasKlcogyz3lFzOCPYokX+/8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996443; c=relaxed/simple;
	bh=CQ0ATUgj1sWgtZ9sgW4cxX6hd+gFejG71rcm9aF3CRg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC4jQ81TxzaLPPaKZK7TFUjU6ZmDjbVT3ecYkApzfZgAz4Zl2cR8AldVDJgIQEGakKkw+kyv9OMhG/AH/cRLFcYIdqFFfiKc8kqaVA62Pop7Z2c1wVwXwYL4wpzMY98IBRHTc5yEYw4YIcdb/NadfZriEVYpt0jLNuyRc3w37+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QHJFG3cg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55R3rxWV32041962, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750996439; bh=EM4fJekiP89brGyyyjY/GaVC3B5gQ5wCeCQApWWoPqE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QHJFG3cgYJuUJSIjsz++Q375uvUxfhOLoej5zx9f6QCX7/UNePw9ggbKJZxKeyhtC
	 9uH1gDXvaZZ+wbOqJbsSNEd2RqDLJBHLtDlFkpezdMpB5K+lF2vpDJS9xNN/DlvWhz
	 LIbpe4YztDjUZFV+mF/e1JgXYr+YJu13EeAZarge8t5htKO3Twr33Fp7XTSH6xbWFd
	 T+/6XEc5XvlQVOtURInixgfTMpkOszsPw+N2Fxr2MY5QhCBYyNjWwOlzBYJFFrnR0J
	 JTOIcuiNli8hKlqWx7jKsqZUITVa34rWN3uy+8ycVshYvyomKlATPOn+xRsQtp1Hlm
	 w1s2A2M1mgaBA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55R3rxWV32041962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 11:53:59 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Jun 2025 11:54:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Jun
 2025 11:54:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 5/6] wifi: rtw89: 8851b: rfk: update DPK to 0x11
Date: Fri, 27 Jun 2025 11:53:28 +0800
Message-ID: <20250627035328.16577-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627035201.16416-1-pkshih@realtek.com>
References: <20250627035201.16416-1-pkshih@realtek.com>
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

Update DPK with TX/RX clock to 960MHz and 1920MHz, which improve
performance on certain chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   3 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 109 +++++++++++++++---
 .../realtek/rtw89/rtw8851b_rfk_table.c        |  25 ----
 .../realtek/rtw89/rtw8851b_rfk_table.h        |   1 -
 4 files changed, 98 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 4a65b0c9c2d1..90625d692b4d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8775,6 +8775,8 @@
 #define B_P0_TSSI_RFC GENMASK(28, 27)
 #define B_P0_TSSI_OFT_EN BIT(28)
 #define B_P0_TSSI_OFT GENMASK(7, 0)
+#define R_P0_TSSI_SLOPE_CAL 0x581c
+#define B_P0_TSSI_SLOPE_CAL_EN BIT(20)
 #define R_P0_TSSI_AVG 0x5820
 #define B_P0_TSSI_EN BIT(31)
 #define B_P0_TSSI_AVG GENMASK(15, 12)
@@ -9268,6 +9270,7 @@
 #define B_WDADC_SEL GENMASK(5, 4)
 #define R_ADCMOD 0xC0E8
 #define B_ADCMOD_LP GENMASK(31, 16)
+#define B_ADCMOD_AUTO_RST BIT(6)
 #define R_DCIM 0xC0EC
 #define B_DCIM_RC GENMASK(23, 16)
 #define B_DCIM_FR GENMASK(14, 13)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index f72b3ac6f149..907ce6d3c1b1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -12,8 +12,8 @@
 #include "rtw8851b_rfk_table.h"
 #include "rtw8851b_table.h"
 
-#define DPK_VER_8851B 0x5
-#define DPK_KIP_REG_NUM_8851B 7
+#define DPK_VER_8851B 0x11
+#define DPK_KIP_REG_NUM_8851B 8
 #define DPK_RF_REG_NUM_8851B 4
 #define DPK_KSET_NUM 4
 #define RTW8851B_RXK_GROUP_NR 4
@@ -85,6 +85,24 @@ enum rf_mode {
 	RF_RXK2 = 0x7,
 };
 
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
+
 static const u32 _tssi_de_cck_long[RF_PATH_NUM_8851B] = {0x5858};
 static const u32 _tssi_de_cck_short[RF_PATH_NUM_8851B] = {0x5860};
 static const u32 _tssi_de_mcs_20m[RF_PATH_NUM_8851B] = {0x5838};
@@ -116,7 +134,7 @@ static const u32 rtw8851b_backup_rf_regs[] = {
 #define BACKUP_RF_REGS_NR ARRAY_SIZE(rtw8851b_backup_rf_regs)
 
 static const u32 dpk_kip_reg[DPK_KIP_REG_NUM_8851B] = {
-	0x813c, 0x8124, 0xc0ec, 0xc0e8, 0xc0c4, 0xc0d4, 0xc0d8};
+	0x813c, 0x8124, 0xc0ec, 0xc0e8, 0xc0c4, 0xc0d4, 0xc0d8, 0x12a0};
 static const u32 dpk_rf_reg[DPK_RF_REG_NUM_8851B] = {0xde, 0x8f, 0x5, 0x10005};
 
 static void _set_ch(struct rtw89_dev *rtwdev, u32 val);
@@ -163,6 +181,51 @@ static void _rfk_drf_direct_cntrl(struct rtw89_dev *rtwdev,
 		rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x0);
 }
 
+static void _txck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			bool force, enum dac_ck ck)
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
+static void _rxck_force(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			bool force, enum adc_ck ck)
+{
+	static const u32 ck960_8851b[] = {0x8, 0x2, 0x2, 0x4, 0xf, 0xa, 0x93};
+	static const u32 ck1920_8851b[] = {0x9, 0x0, 0x0, 0x3, 0xf, 0xa, 0x49};
+	const u32 *data;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_ON, 0x0);
+	if (!force)
+		return;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_VAL, ck);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 13), B_P0_RXCK_ON, 0x1);
+
+	switch (ck) {
+	case ADC_960M:
+		data = ck960_8851b;
+		break;
+	case ADC_1920M:
+	default:
+		data = ck1920_8851b;
+		break;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_CTL, data[0]);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_EN, data[1]);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, data[2]);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, data[3]);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK | (path << 8), B_DRCK_MUL, data[4]);
+	rtw89_phy_write32_mask(rtwdev, R_ADCMOD | (path << 8), B_ADCMOD_LP, data[5]);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK | (path << 8), B_P0_RXCK_ADJ, data[6]);
+}
+
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 {
 	u32 rf_mode;
@@ -1794,7 +1857,21 @@ static void _dpk_bb_afe_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path pat
 	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, BIT(28 + path), 0x0);
 	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), MASKDWORD, 0xd801dffd);
 
-	rtw89_rfk_parser(rtwdev, &rtw8851b_iqk_bb_afe_defs_tbl);
+	_txck_force(rtwdev, path, true, DAC_960M);
+	_rxck_force(rtwdev, path, true, ADC_1920M);
+
+	rtw89_phy_write32_mask(rtwdev, R_DCIM, B_DCIM_FR, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADCMOD, B_ADCMOD_AUTO_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x1f);
+	udelay(10);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15, 0x13);
+	udelay(2);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0001);
+	udelay(2);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_15, 0x0041);
+	udelay(10);
 
 	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, BIT(20 + path), 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, BIT(28 + path), 0x1);
@@ -1827,6 +1904,17 @@ static void _dpk_tssi_pause(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 		    is_pause ? "pause" : "resume");
 }
 
+static
+void _dpk_tssi_slope_k_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			     bool is_on)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_SLOPE_CAL + (path << 13),
+			       B_P0_TSSI_SLOPE_CAL_EN, is_on);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d TSSI slpoe_k %s\n", path,
+		    str_on_off(is_on));
+}
+
 static void _dpk_tpg_sel(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
@@ -1874,9 +1962,6 @@ static void _dpk_kip_control_rfc(struct rtw89_dev *rtwdev,
 {
 	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13),
 			       B_IQK_RFC_ON, ctrl_by_kip);
-
-	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] RFC is controlled by %s\n",
-		    ctrl_by_kip ? "KIP" : "BB");
 }
 
 static void _dpk_kip_preset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
@@ -2279,7 +2364,7 @@ static void _dpk_set_mdpd_para(struct rtw89_dev *rtwdev, u8 order)
 	case 0: /* (5,3,1) */
 		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_DPK_IDL, B_DPK_IDL_SEL, 0x2);
-		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_PN, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_PN, 0x3);
 		rtw89_phy_write32_mask(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_DMAN, 0x1);
 		break;
 	case 1: /* (5,3,0) */
@@ -2315,8 +2400,6 @@ static void _dpk_set_mdpd_para(struct rtw89_dev *rtwdev, u8 order)
 static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			 enum rtw89_rf_path path, u8 kidx)
 {
-	rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_MA, 0x1);
-
 	if (rtw89_phy_read32_mask(rtwdev, R_IDL_MPA, B_IDL_MD500) == 0x1)
 		_dpk_set_mdpd_para(rtwdev, 0x2);
 	else if (rtw89_phy_read32_mask(rtwdev, R_IDL_MPA, B_IDL_MD530) == 0x1)
@@ -2419,9 +2502,6 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 init_xdbm = 17;
 	bool is_fail;
 
-	if (dpk->bp[path][kidx].band != RTW89_BAND_2G)
-		init_xdbm = 15;
-
 	_dpk_kip_control_rfc(rtwdev, path, false);
 	_rfk_rf_direct_cntrl(rtwdev, path, false);
 	rtw89_write_rf(rtwdev, path, RR_BBDC, RFREG_MASK, 0x03ffd);
@@ -2485,6 +2565,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 			    "[DPK] ========= S%d[%d] DPK Start =========\n",
 			    path, dpk->cur_idx[path]);
 
+		_dpk_tssi_slope_k_onoff(rtwdev, path, false);
 		_dpk_rxagc_onoff(rtwdev, path, false);
 		_rfk_drf_direct_cntrl(rtwdev, path, false);
 		_dpk_bb_afe_setting(rtwdev, path);
@@ -2502,7 +2583,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 		_dpk_reload_rf(rtwdev, dpk_rf_reg, rf_bkup, path);
 		_dpk_bb_afe_restore(rtwdev, path);
 		_dpk_rxagc_onoff(rtwdev, path, true);
-
+		_dpk_tssi_slope_k_onoff(rtwdev, path, true);
 		if (rtwdev->is_tssi_mode[path])
 			_dpk_tssi_pause(rtwdev, path, false);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
index 0abf7978ccab..38ce03331069 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
@@ -182,31 +182,6 @@ static const struct rtw89_reg5_def rtw8851b_iqk_macbb_defs[] = {
 
 RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_macbb_defs);
 
-static const struct rtw89_reg5_def rtw8851b_iqk_bb_afe_defs[] = {
-	RTW89_DECL_RFK_WM(0x5670, 0x00004000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00008000, 0x1),
-	RTW89_DECL_RFK_WM(0x5670, 0x80000000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00007000, 0x7),
-	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
-	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x3),
-	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x2),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x9),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x1),
-	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x0),
-	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x3),
-	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xa),
-	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x0),
-	RTW89_DECL_RFK_WM(0xc0e8, 0x00000040, 0x1),
-	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
-	RTW89_DECL_RFK_WM(0x030c, MASKBYTE3, 0x1f),
-	RTW89_DECL_RFK_WM(0x030c, MASKBYTE3, 0x13),
-	RTW89_DECL_RFK_WM(0x032c, MASKHWORD, 0x0001),
-	RTW89_DECL_RFK_WM(0x032c, MASKHWORD, 0x0041),
-};
-
-RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_bb_afe_defs);
-
 static const struct rtw89_reg5_def rtw8851b_tssi_sys_defs[] = {
 	RTW89_DECL_RFK_WM(0x12bc, 0x000ffff0, 0xb5b5),
 	RTW89_DECL_RFK_WM(0x32bc, 0x000ffff0, 0xb5b5),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
index febfbecb691c..4fd81456109b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
@@ -17,7 +17,6 @@ extern const struct rtw89_rfk_tbl rtw8851b_iqk_rxclk_others_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_iqk_txk_2ghz_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_iqk_txk_5ghz_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_iqk_afebb_restore_defs_tbl;
-extern const struct rtw89_rfk_tbl rtw8851b_iqk_bb_afe_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_iqk_macbb_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_a_defs_2g_tbl;
-- 
2.25.1


