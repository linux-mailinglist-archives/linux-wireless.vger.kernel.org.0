Return-Path: <linux-wireless+bounces-8664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD98FFCC8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F98B1C26BBE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 07:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6C155C8F;
	Fri,  7 Jun 2024 07:07:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4515572E
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744053; cv=none; b=XcaZ7SbL0Q6LPa6wPsgjz10x3R0wYs6EehPJW00/CLavZNtXwh7hJyBKzdYAm+fdFT1ES93Bu5jBxIyOO8dZjtK/kW/xIvI/ggh4TolFbSNugbSC0XcccFjcEJgDU76rSlKUuX19SfeavQ7Zynr/dcaBKE9QOrRW0mksnFhjoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744053; c=relaxed/simple;
	bh=ojVRcgQZ9XHUDatlrdIGtVkYG00yBH01/7rHBYz+reE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF9b1fk1N8qVnZHr+6eOocMU00S8wkeGM6FE/fnqgbx/Jed4vSz+u1DXbtq+lMchcuwTn3gvTFm55hu6YAIbF0z71G7F9QSZ7I9hv/kxC5MDwzlO46ZO1vK50jpBLF+8BPq3cNxeyImJx2PkLPGwccaUDaIqc3pKnOUvbkOVPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45777S4C03728585, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45777S4C03728585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 7 Jun 2024 15:07:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 15:07:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 15:07:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: 8852bx: add extra handles for 8852BT in 8852b_common
Date: Fri, 7 Jun 2024 15:06:58 +0800
Message-ID: <20240607070659.80263-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607070659.80263-1-pkshih@realtek.com>
References: <20240607070659.80263-1-pkshih@realtek.com>
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

The channel configuration of 8852BT is very similar but a little different
to 8852B, so use chip ID as condition to add extra handles including
external loss compensation, ADC configurations, spur settings and so on.

Don't affect existing 8852BE.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Makefile   |   3 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/phy.h      |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   6 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 195 +++++++++++++++++-
 .../wireless/realtek/rtw89/rtw8852b_common.h  |   7 +
 drivers/net/wireless/realtek/rtw89/util.c     | 106 ++++++++++
 drivers/net/wireless/realtek/rtw89/util.h     |   5 +
 8 files changed, 315 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.c

diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 688847ce7084..1f1050a7a89d 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -17,7 +17,8 @@ rtw89_core-y += core.o \
 		ps.o \
 		chan.o \
 		ser.o \
-		acpi.o
+		acpi.o \
+		util.o
 
 rtw89_core-$(CONFIG_PM) += wow.o
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 68221f0b156e..874119b5007d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -132,6 +132,7 @@ enum rtw89_hci_type {
 enum rtw89_core_chip_id {
 	RTL8852A,
 	RTL8852B,
+	RTL8852BT,
 	RTL8852C,
 	RTL8851B,
 	RTL8922A,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 082231ebbee5..6e53ac9140fb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -129,6 +129,7 @@
 #define EDCCA_HL_DIFF_NORMAL 8
 #define RSSI_UNIT_CONVER 110
 #define EDCCA_UNIT_CONVER 128
+#define EDCCA_PWROFST_DEFAULT 18
 
 enum rtw89_phy_c2h_ra_func {
 	RTW89_PHY_C2H_FUNC_STS_RPT,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 01cbd0312102..dc78ffc39ae7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7872,6 +7872,7 @@
 #define B_UPD_CLK_ADC_ON BIT(24)
 #define B_ENABLE_CCK BIT(5)
 #define R_RSTB_ASYNC 0x0704
+#define B_RSTB_ASYNC_BW80 GENMASK(9, 8)
 #define B_RSTB_ASYNC_ALL BIT(1)
 #define R_P0_ANT_SW 0x0728
 #define B_P0_HW_ANTSW_DIS_BY_GNT_BT BIT(12)
@@ -8379,6 +8380,7 @@
 #define B_CDD_EVM_CHK_EN BIT(0)
 #define R_PATH0_BAND_SEL_V1 0x4738
 #define B_PATH0_BAND_SEL_MSK_V1 BIT(17)
+#define B_PATH0_BAND_NRBW_EN_V1 BIT(16)
 #define R_PATH0_BT_SHARE_V1 0x4738
 #define B_PATH0_BT_SHARE_V1 BIT(19)
 #define R_PATH0_BTG_PATH_V1 0x4738
@@ -8422,6 +8424,7 @@
 #define B_PATH1_G_TIA1_LNA6_OP1DB_V1 GENMASK(15, 8)
 #define R_PATH1_BAND_SEL_V1 0x4AA4
 #define B_PATH1_BAND_SEL_MSK_V1 BIT(17)
+#define B_PATH1_BAND_NRBW_EN_V1 BIT(16)
 #define R_PATH1_BT_SHARE_V1 0x4AA4
 #define B_PATH1_BT_SHARE_V1 BIT(19)
 #define R_PATH1_BTG_PATH_V1 0x4AA4
@@ -8442,6 +8445,8 @@
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1 BIT(30)
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK BIT(29)
 #define B_SEG0R_PD_LOWER_BOUND_MSK GENMASK(10, 6)
+#define R_PWOFST 0x488C
+#define B_PWOFST GENMASK(21, 17)
 #define R_2P4G_BAND 0x4970
 #define B_2P4G_BAND_SEL BIT(1)
 #define R_FC0_BW 0x4974
@@ -9095,6 +9100,7 @@
 #define R_ADCMOD 0xC0E8
 #define B_ADCMOD_LP GENMASK(31, 16)
 #define R_DCIM 0xC0EC
+#define B_DCIM_RC GENMASK(23, 16)
 #define B_DCIM_FR GENMASK(14, 13)
 #define R_ADDCK0D 0xC0F0
 #define B_ADDCK0D_VAL2 GENMASK(31, 26)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 0826d257ddba..60e9bd5b1376 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -7,6 +7,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852b_common.h"
+#include "util.h"
 
 static const struct rtw89_reg3_def rtw8852bx_pmac_ht20_mcs7_tbl[] = {
 	{0x4580, 0x0000ffff, 0x0},
@@ -609,6 +610,27 @@ static void rtw8852bx_set_gain_error(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8852bt_ext_loss_avg_update(struct rtw89_dev *rtwdev,
+					  s8 ext_loss_a, s8 ext_loss_b)
+{
+	s8 ext_loss_avg;
+	u64 linear;
+	u8 pwrofst;
+
+	if (ext_loss_a == ext_loss_b) {
+		ext_loss_avg = ext_loss_a;
+	} else {
+		linear = rtw89_db_2_linear(abs(ext_loss_a - ext_loss_b)) + 1;
+		linear = DIV_ROUND_CLOSEST_ULL(linear / 2, 1 << RTW89_LINEAR_FRAC_BITS);
+		ext_loss_avg = rtw89_linear_2_db(linear);
+		ext_loss_avg += min(ext_loss_a, ext_loss_b);
+	}
+
+	pwrofst = max(DIV_ROUND_CLOSEST(ext_loss_avg, 4) + 16, EDCCA_PWROFST_DEFAULT);
+
+	rtw89_phy_write32_mask(rtwdev, R_PWOFST, B_PWOFST, pwrofst);
+}
+
 static void rtw8852bx_set_gain_offset(struct rtw89_dev *rtwdev,
 				      enum rtw89_subband subband,
 				      enum rtw89_phy_idx phy_idx)
@@ -619,6 +641,7 @@ static void rtw8852bx_set_gain_offset(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_phy_efuse_gain *efuse_gain = &rtwdev->efuse_gain;
 	enum rtw89_gain_offset gain_ofdm_band;
+	s8 ext_loss_a = 0, ext_loss_b = 0;
 	s32 offset_a, offset_b;
 	s32 offset_ofdm, offset_cck;
 	s32 tmp;
@@ -635,7 +658,7 @@ static void rtw8852bx_set_gain_offset(struct rtw89_dev *rtwdev,
 
 next:
 	if (!efuse_gain->offset_valid)
-		return;
+		goto ext_loss;
 
 	gain_ofdm_band = rtw89_subband_to_gain_offset_band_of_ofdm(subband);
 
@@ -672,6 +695,13 @@ static void rtw8852bx_set_gain_offset(struct rtw89_dev *rtwdev,
 		rtw89_phy_write32_mask(rtwdev, R_RX_RPL_OFST,
 				       B_RX_RPL_OFST_CCK_MASK, tmp);
 	}
+
+	ext_loss_a = (offset_a << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2);
+	ext_loss_b = (offset_b << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2);
+
+ext_loss:
+	if (rtwdev->chip->chip_id == RTL8852BT)
+		rtw8852bt_ext_loss_avg_update(rtwdev, ext_loss_a, ext_loss_b);
 }
 
 static
@@ -804,10 +834,79 @@ static void rtw8852b_bw_setting(struct rtw89_dev *rtwdev, u8 bw, u8 path)
 	}
 }
 
+static
+void rtw8852bt_adc_cfg(struct rtw89_dev *rtwdev, u8 bw, u8 path)
+{
+	static const u32 rck_reset_count[2] = {0xC0E8, 0xC1E8};
+	static const u32 adc_op5_bw_sel[2] = {0xC0D8, 0xC1D8};
+	static const u32 adc_sample_td[2] = {0xC0D4, 0xC1D4};
+	static const u32 adc_rst_cycle[2] = {0xC0EC, 0xC1EC};
+	static const u32 decim_filter[2] = {0xC0EC, 0xC1EC};
+	static const u32 rck_offset[2] = {0xC0C4, 0xC1C4};
+	static const u32 rx_adc_clk[2] = {0x12A0, 0x32A0};
+	static const u32 wbadc_sel[2] = {0xC0E4, 0xC1E4};
+	static const u32 idac2_1[2] = {0xC0D4, 0xC1D4};
+	static const u32 idac2[2] = {0xC0D4, 0xC1D4};
+	static const u32 upd_clk_adc = {0x704};
+
+	if (rtwdev->chip->chip_id != RTL8852BT)
+		return;
+
+	rtw89_phy_write32_mask(rtwdev, idac2[path], B_P0_CFCH_CTL, 0x8);
+	rtw89_phy_write32_mask(rtwdev, rck_reset_count[path], B_ADCMOD_LP, 0x9);
+	rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], B_WDADC_SEL, 0x2);
+	rtw89_phy_write32_mask(rtwdev, rx_adc_clk[path], B_P0_RXCK_ADJ, 0x49);
+	rtw89_phy_write32_mask(rtwdev, decim_filter[path], B_DCIM_FR, 0x0);
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+	case RTW89_CHANNEL_WIDTH_10:
+	case RTW89_CHANNEL_WIDTH_20:
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_mask(rtwdev, idac2_1[path], B_P0_CFCH_EN, 0x2);
+		rtw89_phy_write32_mask(rtwdev, adc_sample_td[path], B_P0_CFCH_BW0, 0x3);
+		rtw89_phy_write32_mask(rtwdev, adc_op5_bw_sel[path], B_P0_CFCH_BW1, 0xf);
+		rtw89_phy_write32_mask(rtwdev, rck_offset[path], B_DRCK_MUL, 0x0);
+		/* Tx TSSI ADC update */
+		rtw89_phy_write32_mask(rtwdev, upd_clk_adc, B_RSTB_ASYNC_BW80, 0);
+
+		if (rtwdev->efuse.rfe_type >= 51)
+			rtw89_phy_write32_mask(rtwdev, adc_rst_cycle[path], B_DCIM_RC, 0x2);
+		else
+			rtw89_phy_write32_mask(rtwdev, adc_rst_cycle[path], B_DCIM_RC, 0x3);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_mask(rtwdev, idac2_1[path], B_P0_CFCH_EN, 0x2);
+		rtw89_phy_write32_mask(rtwdev, adc_sample_td[path], B_P0_CFCH_BW0, 0x2);
+		rtw89_phy_write32_mask(rtwdev, adc_op5_bw_sel[path], B_P0_CFCH_BW1, 0x8);
+		rtw89_phy_write32_mask(rtwdev, rck_offset[path], B_DRCK_MUL, 0x0);
+		rtw89_phy_write32_mask(rtwdev, adc_rst_cycle[path], B_DCIM_RC, 0x3);
+		/* Tx TSSI ADC update */
+		rtw89_phy_write32_mask(rtwdev, upd_clk_adc, B_RSTB_ASYNC_BW80, 1);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rtw89_phy_write32_mask(rtwdev, idac2_1[path], B_P0_CFCH_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, adc_sample_td[path], B_P0_CFCH_BW0, 0x2);
+		rtw89_phy_write32_mask(rtwdev, adc_op5_bw_sel[path], B_P0_CFCH_BW1, 0x4);
+		rtw89_phy_write32_mask(rtwdev, rck_offset[path], B_DRCK_MUL, 0x6);
+		rtw89_phy_write32_mask(rtwdev, adc_rst_cycle[path], B_DCIM_RC, 0x3);
+		/* Tx TSSI ADC update */
+		rtw89_phy_write32_mask(rtwdev, upd_clk_adc, B_RSTB_ASYNC_BW80, 2);
+		break;
+	default:
+		rtw89_warn(rtwdev, "Fail to set ADC\n");
+		break;
+	}
+}
+
 static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
 			      enum rtw89_phy_idx phy_idx)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 rx_path_0;
+	u32 val;
+
+	rx_path_0 = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, phy_idx);
 
 	switch (bw) {
 	case RTW89_CHANNEL_WIDTH_5:
@@ -820,6 +919,12 @@ static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
 				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
 				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		if (chip_id == RTL8852BT) {
+			rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
+					      B_PATH0_BAND_NRBW_EN_V1, 0x0, phy_idx);
+			rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
+					      B_PATH1_BAND_NRBW_EN_V1, 0x0, phy_idx);
+		}
 		break;
 	case RTW89_CHANNEL_WIDTH_10:
 		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
@@ -831,6 +936,12 @@ static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
 				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
 				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		if (chip_id == RTL8852BT) {
+			rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
+					      B_PATH0_BAND_NRBW_EN_V1, 0x0, phy_idx);
+			rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
+					      B_PATH1_BAND_NRBW_EN_V1, 0x0, phy_idx);
+		}
 		break;
 	case RTW89_CHANNEL_WIDTH_20:
 		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
@@ -842,6 +953,12 @@ static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
 				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
 				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		if (chip_id == RTL8852BT) {
+			rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
+					      B_PATH0_BAND_NRBW_EN_V1, 0x1, phy_idx);
+			rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
+					      B_PATH1_BAND_NRBW_EN_V1, 0x1, phy_idx);
+		}
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
 		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x1, phy_idx);
@@ -868,21 +985,25 @@ static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
 				      pri_ch, phy_idx);
 
 		/*Set RF mode at A */
+		val = chip_id == RTL8852BT ? 0x333 : 0xaaa;
 		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
+				      B_P0_RFMODE_ORI_RX_ALL, val, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
+				      B_P1_RFMODE_ORI_RX_ALL, val, phy_idx);
 		break;
 	default:
 		rtw89_warn(rtwdev, "Fail to switch bw (bw:%d, pri ch:%d)\n", bw,
 			   pri_ch);
 	}
 
-	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_A);
-	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_B);
+	if (chip_id == RTL8852B) {
+		rtw8852b_bw_setting(rtwdev, bw, RF_PATH_A);
+		rtw8852b_bw_setting(rtwdev, bw, RF_PATH_B);
+	} else if (chip_id == RTL8852BT) {
+		rtw8852bt_adc_cfg(rtwdev, bw, RF_PATH_A);
+		rtw8852bt_adc_cfg(rtwdev, bw, RF_PATH_B);
+	}
 
-	rx_path_0 = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0,
-					 phy_idx);
 	if (rx_path_0 == 0x1)
 		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
 				      B_P1_RFMODE_ORI_RX_ALL, 0x111, phy_idx);
@@ -1001,10 +1122,56 @@ static void rtw8852bx_bb_set_pop(struct rtw89_dev *rtwdev)
 		rtw89_phy_write32_clr(rtwdev, R_PKT_CTRL, B_PKT_POP_EN);
 }
 
+static u32 rtw8852bt_spur_freq(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan)
+{
+	u8 center_chan = chan->channel;
+
+	switch (chan->band_type) {
+	case RTW89_BAND_5G:
+		if (center_chan == 151 || center_chan == 153 ||
+		    center_chan == 155 || center_chan == 163)
+			return 5760;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+#define CARRIER_SPACING_312_5 312500 /* 312.5 kHz */
+#define CARRIER_SPACING_78_125 78125 /* 78.125 kHz */
+#define MAX_TONE_NUM 2048
+
+static void rtw8852bt_set_csi_tone_idx(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan,
+				       enum rtw89_phy_idx phy_idx)
+{
+	s32 freq_diff, csi_idx, csi_tone_idx;
+	u32 spur_freq;
+
+	spur_freq = rtw8852bt_spur_freq(rtwdev, chan);
+	if (spur_freq == 0) {
+		rtw89_phy_write32_idx(rtwdev, R_SEG0CSI_EN_V1, B_SEG0CSI_EN,
+				      0, phy_idx);
+		return;
+	}
+
+	freq_diff = (spur_freq - chan->freq) * 1000000;
+	csi_idx = s32_div_u32_round_closest(freq_diff, CARRIER_SPACING_78_125);
+	s32_div_u32_round_down(csi_idx, MAX_TONE_NUM, &csi_tone_idx);
+
+	rtw89_phy_write32_idx(rtwdev, R_SEG0CSI_V1, B_SEG0CSI_IDX,
+			      csi_tone_idx, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_SEG0CSI_EN_V1, B_SEG0CSI_EN, 1, phy_idx);
+}
+
 static
 void __rtw8852bx_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
 				enum rtw89_phy_idx phy_idx)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	bool cck_en = chan->channel <= 14;
 	u8 pri_ch_idx = chan->pri_ch_idx;
 	u8 band = chan->band_type, chan_idx;
@@ -1015,7 +1182,9 @@ void __rtw8852bx_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_cha
 	rtw8852bx_ctrl_ch(rtwdev, chan, phy_idx);
 	rtw8852bx_ctrl_bw(rtwdev, pri_ch_idx, chan->band_width, phy_idx);
 	rtw8852bx_ctrl_cck_en(rtwdev, cck_en);
-	if (chan->band_type == RTW89_BAND_5G) {
+	if (chip_id == RTL8852BT)
+		rtw8852bt_set_csi_tone_idx(rtwdev, chan, phy_idx);
+	if (chip_id == RTL8852B && chan->band_type == RTW89_BAND_5G) {
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
 				       B_PATH0_BT_SHARE_V1, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
@@ -1614,6 +1783,8 @@ static void __rtw8852bx_query_ppdu(struct rtw89_dev *rtwdev,
 
 static int __rtw8852bx_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 val32;
 	int ret;
 
 	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
@@ -1623,6 +1794,13 @@ static int __rtw8852bx_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
 	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
 
+	if (chip_id == RTL8852BT) {
+		val32 = rtw89_read32(rtwdev, R_AX_AFE_OFF_CTRL1);
+		val32 = u32_replace_bits(val32, 0x1, B_AX_S0_LDO_VSEL_F_MASK);
+		val32 = u32_replace_bits(val32, 0x1, B_AX_S1_LDO_VSEL_F_MASK);
+		rtw89_write32(rtwdev, R_AX_AFE_OFF_CTRL1, val32);
+	}
+
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xC7,
 				      FULL_BIT_MASK);
 	if (ret)
@@ -1693,6 +1871,7 @@ const struct rtw8852bx_info rtw8852bx_info = {
 	.init_txpwr_unit = __rtw8852bx_init_txpwr_unit,
 	.set_txpwr_ul_tb_offset = __rtw8852bx_set_txpwr_ul_tb_offset,
 	.get_thermal = __rtw8852bx_get_thermal,
+	.adc_cfg = rtw8852bt_adc_cfg,
 };
 EXPORT_SYMBOL(rtw8852bx_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
index 2348a13545ac..b8e3f20ba189 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
@@ -158,6 +158,7 @@ struct rtw8852bx_info {
 	void (*set_txpwr_ul_tb_offset)(struct rtw89_dev *rtwdev,
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
 	u8 (*get_thermal)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path);
+	void (*adc_cfg)(struct rtw89_dev *rtwdev, u8 bw, u8 path);
 };
 
 extern const struct rtw8852bx_info rtw8852bx_info;
@@ -336,4 +337,10 @@ u8 rtw8852bx_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
 	return rtw8852bx_info.get_thermal(rtwdev, rf_path);
 }
 
+static inline
+void rtw8852bx_adc_cfg(struct rtw89_dev *rtwdev, u8 bw, u8 path)
+{
+	rtw8852bx_info.adc_cfg(rtwdev, bw, path);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/util.c b/drivers/net/wireless/realtek/rtw89/util.c
new file mode 100644
index 000000000000..e71956ce9853
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/util.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024  Realtek Corporation
+ */
+
+#include "util.h"
+
+#define FRAC_ROWS 3
+#define FRAC_ROW_MAX (FRAC_ROWS - 1)
+#define NORM_ROW_MIN FRAC_ROWS
+
+static const u32 db_invert_table[12][8] = {
+	/* rows 0~2 in unit of U(32,3) */
+	{10, 13, 16, 20, 25, 32, 40, 50},
+	{64, 80, 101, 128, 160, 201, 256, 318},
+	{401, 505, 635, 800, 1007, 1268, 1596, 2010},
+	/* rows 3~11 in unit of U(32,0) */
+	{316, 398, 501, 631, 794, 1000, 1259, 1585},
+	{1995, 2512, 3162, 3981, 5012, 6310, 7943, 10000},
+	{12589, 15849, 19953, 25119, 31623, 39811, 50119, 63098},
+	{79433, 100000, 125893, 158489, 199526, 251189, 316228, 398107},
+	{501187, 630957, 794328, 1000000, 1258925, 1584893, 1995262, 2511886},
+	{3162278, 3981072, 5011872, 6309573, 7943282, 1000000, 12589254,
+	 15848932},
+	{19952623, 25118864, 31622777, 39810717, 50118723, 63095734, 79432823,
+	 100000000},
+	{125892541, 158489319, 199526232, 251188643, 316227766, 398107171,
+	 501187234, 630957345},
+	{794328235, 1000000000, 1258925412, 1584893192, 1995262315, 2511886432U,
+	 3162277660U, 3981071706U},
+};
+
+u32 rtw89_linear_2_db(u64 val)
+{
+	u8 i, j;
+	u32 dB;
+
+	for (i = 0; i < 12; i++) {
+		for (j = 0; j < 8; j++) {
+			if (i <= FRAC_ROW_MAX &&
+			    (val << RTW89_LINEAR_FRAC_BITS) <= db_invert_table[i][j])
+				goto cnt;
+			else if (i > FRAC_ROW_MAX && val <= db_invert_table[i][j])
+				goto cnt;
+		}
+	}
+
+	return 96; /* maximum 96 dB */
+
+cnt:
+	/* special cases */
+	if (j == 0 && i == 0)
+		goto end;
+
+	if (i == NORM_ROW_MIN && j == 0) {
+		if (db_invert_table[NORM_ROW_MIN][0] - val >
+		    val - (db_invert_table[FRAC_ROW_MAX][7] >> RTW89_LINEAR_FRAC_BITS)) {
+			i = FRAC_ROW_MAX;
+			j = 7;
+		}
+		goto end;
+	}
+
+	if (i <= FRAC_ROW_MAX)
+		val <<= RTW89_LINEAR_FRAC_BITS;
+
+	/* compare difference to get precise dB */
+	if (j == 0) {
+		if (db_invert_table[i][j] - val >
+		    val - db_invert_table[i - 1][7]) {
+			i--;
+			j = 7;
+		}
+	} else {
+		if (db_invert_table[i][j] - val >
+		    val - db_invert_table[i][j - 1]) {
+			j--;
+		}
+	}
+end:
+	dB = (i << 3) + j + 1;
+
+	return dB;
+}
+EXPORT_SYMBOL(rtw89_linear_2_db);
+
+u64 rtw89_db_2_linear(u32 db)
+{
+	u64 linear;
+	u8 i, j;
+
+	if (db > 96)
+		db = 96;
+	else if (db < 1)
+		return 1;
+
+	i = (db - 1) >> 3;
+	j = (db - 1) & 0x7;
+
+	linear = db_invert_table[i][j];
+
+	if (i >= NORM_ROW_MIN)
+		linear = linear << RTW89_LINEAR_FRAC_BITS;
+
+	return linear;
+}
+EXPORT_SYMBOL(rtw89_db_2_linear);
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index e2ed4565025d..e82e7df052d8 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -6,6 +6,8 @@
 
 #include "core.h"
 
+#define RTW89_LINEAR_FRAC_BITS 3
+
 #define rtw89_iterate_vifs_bh(rtwdev, iterator, data)                          \
 	ieee80211_iterate_active_interfaces_atomic((rtwdev)->hw,               \
 			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
@@ -55,4 +57,7 @@ static inline void ether_addr_copy_mask(u8 *dst, const u8 *src, u8 mask)
 	}
 }
 
+u32 rtw89_linear_2_db(u64 linear);
+u64 rtw89_db_2_linear(u32 db);
+
 #endif
-- 
2.25.1


