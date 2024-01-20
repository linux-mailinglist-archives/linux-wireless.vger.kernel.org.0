Return-Path: <linux-wireless+bounces-2284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBE8331DE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 01:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1877B21F3B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC5ECB;
	Sat, 20 Jan 2024 00:39:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAADCEC9
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711157; cv=none; b=DyKsUfyQlnbU3rTyQ6U3KdHPk1bNfqQb0Nl+e3flEltkLP9UNnfRHhSenlXGxkWW11hLnr8QgjGZNObksRM/MU4Ke+1sWHbtouExHxLEfozE4Rk+i1Mi8HxLkOGT9JrEa+3y/Bfk8kxhgTlOEiWYLRdySeJ4GsKcFrwWkq1AZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711157; c=relaxed/simple;
	bh=nyWZPvZWZBxR102eTcmtHvJC0XRNYBV4LTH7SBy1rNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzP5bQlDEcwzBiIxEvt2Lc0wN4b3YpBkp8F02vJP4PNVfTGIVw80xhAjbzoFCTzNiOJyxzK5wKIWpHgepHN45jge66iYJmUlNzcs7MguLq/WbQImlTaDgDn9BOkEfQCPzpmMNPhGQhoqJHWcxe7dvP7LVUUL2gGSm31zQPOULWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40K0d87f92596471, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40K0d87f92596471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 08:39:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 20 Jan 2024 08:39:08 +0800
Received: from [127.0.1.1] (172.16.16.202) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jan
 2024 08:39:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 3/6] wifi: rtw89: 8922a: add chip_ops related to BB init
Date: Sat, 20 Jan 2024 08:38:28 +0800
Message-ID: <20240120003831.7014-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240120003831.7014-1-pkshih@realtek.com>
References: <20240120003831.7014-1-pkshih@realtek.com>
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

The chip_ops::bb_preinit and ::bb_postinit are called before and after
loading BB parameters from tables of firmware file. The ::bb_reset is
used to reset hardware state, and currently it is not needed by 8922AE so
leave it as empty. The ::bb_sethw is to implement conditional parameters.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: modify rtw8922a_ctrl_mlo() to consider AFE DAC settings
---
 drivers/net/wireless/realtek/rtw89/core.c     |   1 +
 drivers/net/wireless/realtek/rtw89/core.h     |  15 ++
 drivers/net/wireless/realtek/rtw89/phy.c      |   1 +
 drivers/net/wireless/realtek/rtw89/phy.h      |  10 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  73 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 194 ++++++++++++++++++
 10 files changed, 298 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b1fcd284a6b8..aefb5a078d1a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4074,6 +4074,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_phy_init_bb_reg(rtwdev);
+	rtw89_chip_bb_postinit(rtwdev);
 	rtw89_phy_init_rf_reg(rtwdev, false);
 
 	rtw89_btc_ntfy_init(rtwdev, BTC_MODE_NORMAL);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 34e52f7c3bba..f56a5d423eb0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3133,6 +3133,7 @@ struct rtw89_chip_ops {
 	int (*enable_bb_rf)(struct rtw89_dev *rtwdev);
 	int (*disable_bb_rf)(struct rtw89_dev *rtwdev);
 	void (*bb_preinit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+	void (*bb_postinit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 	void (*bb_reset)(struct rtw89_dev *rtwdev,
 			 enum rtw89_phy_idx phy_idx);
 	void (*bb_sethw)(struct rtw89_dev *rtwdev);
@@ -5546,6 +5547,20 @@ void rtw89_chip_bb_preinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 		chip->ops->bb_preinit(rtwdev, phy_idx);
 }
 
+static inline
+void rtw89_chip_bb_postinit(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!chip->ops->bb_postinit)
+		return;
+
+	chip->ops->bb_postinit(rtwdev, RTW89_PHY_0);
+
+	if (rtwdev->dbcc_en)
+		chip->ops->bb_postinit(rtwdev, RTW89_PHY_1);
+}
+
 static inline void rtw89_chip_bb_sethw(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 926a4459ea4f..7880fbaee092 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1570,6 +1570,7 @@ void rtw89_phy_set_phy_regs(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 
 	rtw89_phy_write32_idx(rtwdev, addr, mask, val, RTW89_PHY_1);
 }
+EXPORT_SYMBOL(rtw89_phy_set_phy_regs);
 
 void rtw89_phy_write_reg3_tbl(struct rtw89_dev *rtwdev,
 			      const struct rtw89_phy_reg3_tbl *tbl)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index a16bff77661f..c05f724a84ce 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+#define RTW89_BBMCU_ADDR_OFFSET	0x30000
 #define RTW89_RF_ADDR_ADSEL_MASK  BIT(16)
 
 #define get_phy_headline(addr)		FIELD_GET(GENMASK(31, 28), addr)
@@ -611,6 +612,15 @@ static inline u32 rtw89_phy_read32_mask(struct rtw89_dev *rtwdev,
 	return rtw89_read32_mask(rtwdev, addr + phy->cr_base, mask);
 }
 
+static inline void rtw89_bbmcu_write32(struct rtw89_dev *rtwdev,
+				       u32 addr, u32 data, enum rtw89_phy_idx phy_idx)
+{
+	if (phy_idx && addr < 0x10000)
+		addr += 0x20000;
+
+	rtw89_write32(rtwdev, addr + RTW89_BBMCU_ADDR_OFFSET, data);
+}
+
 static inline
 enum rtw89_gain_offset rtw89_subband_to_gain_offset_band_of_ofdm(enum rtw89_subband subband)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c4a9ddeb38e0..c4c886fd1941 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4033,6 +4033,30 @@
 #define B_BE_SYSON_DIS_PMCR_BE_WRMSK BIT(2)
 #define B_BE_SYSON_R_BE_ARB_MASK GENMASK(1, 0)
 
+#define R_BE_MEM_PWR_CTRL 0x00D0
+#define B_BE_DMEM5_WLMCU_DS BIT(31)
+#define B_BE_DMEM4_WLMCU_DS BIT(30)
+#define B_BE_DMEM3_WLMCU_DS BIT(29)
+#define B_BE_DMEM2_WLMCU_DS BIT(28)
+#define B_BE_DMEM1_WLMCU_DS BIT(27)
+#define B_BE_DMEM0_WLMCU_DS BIT(26)
+#define B_BE_IMEM5_WLMCU_DS BIT(25)
+#define B_BE_IMEM4_WLMCU_DS BIT(24)
+#define B_BE_IMEM3_WLMCU_DS BIT(23)
+#define B_BE_IMEM2_WLMCU_DS BIT(22)
+#define B_BE_IMEM1_WLMCU_DS BIT(21)
+#define B_BE_IMEM0_WLMCU_DS BIT(20)
+#define B_BE_MEM_BBMCU1_DS BIT(19)
+#define B_BE_MEM_BBMCU0_DS_V1 BIT(17)
+#define B_BE_MEM_BT_DS BIT(10)
+#define B_BE_MEM_SDIO_LS BIT(9)
+#define B_BE_MEM_SDIO_DS BIT(8)
+#define B_BE_MEM_USB_LS BIT(7)
+#define B_BE_MEM_USB_DS BIT(6)
+#define B_BE_MEM_PCI_LS BIT(5)
+#define B_BE_MEM_PCI_DS BIT(4)
+#define B_BE_MEM_WLMAC_LS BIT(3)
+
 #define R_BE_PCIE_MIO_INTF 0x00E4
 #define B_BE_AON_MIO_EPHY_1K_SEL_MASK GENMASK(29, 24)
 #define B_BE_PCIE_MIO_ADDR_PAGE_V1_MASK GENMASK(20, 16)
@@ -7542,10 +7566,14 @@
 #define RR_RFC_CKEN BIT(1)
 
 #define R_UPD_P0 0x0000
+#define R_BBCLK 0x0000
+#define B_CLK_640M BIT(2)
 #define R_RSTB_WATCH_DOG 0x000C
 #define B_P0_RSTB_WATCH_DOG BIT(0)
 #define B_P1_RSTB_WATCH_DOG BIT(1)
 #define B_UPD_P0_EN BIT(31)
+#define R_EMLSR 0x0044
+#define B_EMLSR_PARM GENMASK(27, 12)
 #define R_SPOOF_CG 0x00B4
 #define B_SPOOF_CG_EN BIT(17)
 #define R_CHINFO_SEG 0x00B4
@@ -7585,6 +7613,9 @@
 #define B_SWSI_READ_ADDR_ADDR_V1 GENMASK(7, 0)
 #define B_SWSI_READ_ADDR_PATH_V1 GENMASK(10, 8)
 #define B_SWSI_READ_ADDR_V1 GENMASK(10, 0)
+#define R_EN_SND_WO_NDP 0x047c
+#define R_EN_SND_WO_NDP_C1 0x147c
+#define B_EN_SND_WO_NDP BIT(1)
 #define R_UPD_CLK_ADC 0x0700
 #define B_UPD_CLK_ADC_VAL GENMASK(26, 25)
 #define B_UPD_CLK_ADC_ON BIT(24)
@@ -7696,6 +7727,8 @@
 #define B_SNDCCA_A1_EN GENMASK(19, 12)
 #define R_SNDCCA_A2 0x0CA0
 #define B_SNDCCA_A2_VAL GENMASK(19, 12)
+#define R_UDP_COEEF 0x0CBC
+#define B_UDP_COEEF BIT(19)
 #define R_TX_COLLISION_T2R_ST_BE 0x0CC8
 #define B_TX_COLLISION_T2R_ST_BE_M GENMASK(13, 8)
 #define R_RXHT_MCS_LIMIT 0x0D18
@@ -7868,6 +7901,10 @@
 #define B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY0 BIT(13)
 #define R_DBCC_80P80_SEL_EVM_RPT2 0x2A10
 #define B_DBCC_80P80_SEL_EVM_RPT2_EN BIT(0)
+#define R_AFEDAC0 0x2A5C
+#define B_AFEDAC0 GENMASK(31, 27)
+#define R_AFEDAC1 0x2A60
+#define B_AFEDAC1 GENMASK(2, 0)
 #define R_IQKDPK_HC 0x2AB8
 #define B_IQKDPK_HC BIT(28)
 #define R_P1_EN_SOUND_WO_NDP 0x2D7C
@@ -8350,12 +8387,48 @@
 #define B_DCFO_WEIGHT_MSK_V1 GENMASK(31, 28)
 #define R_DCFO_OPT_V1 0x6260
 #define B_DCFO_OPT_EN_V1 BIT(17)
+#define R_TXFCTR 0x627C
+#define B_TXFCTR_THD GENMASK(19, 10)
+#define R_TXSCALE 0x6284
+#define B_TXFCTR_EN BIT(19)
 #define R_SEG0R_EDCCA_LVL_BE 0x69EC
 #define R_SEG0R_PPDU_LVL_BE 0x69F0
 #define R_SEGSND 0x6A14
 #define B_SEGSND_EN BIT(31)
+#define R_DBCC 0x6B48
+#define B_DBCC_EN BIT(0)
+#define R_SLOPE 0x6B6C
+#define B_EHT_RATE_TH GENMASK(31, 28)
+#define B_SLOPE_B GENMASK(27, 14)
+#define B_SLOPE_A GENMASK(13, 0)
+#define R_SC_CORNER 0x6B70
+#define B_SC_CORNER GENMASK(10, 0)
+#define R_MAG_A 0x6BF4
+#define B_MGA_AEND GENMASK(31, 24)
+#define R_MAG_AB 0x6BF8
+#define B_BY_SLOPE GENMASK(31, 24)
+#define B_MAG_AB GENMASK(23, 0)
+#define R_BEDGE 0x6BFC
+#define B_EHT_MCS14 BIT(31)
+#define B_HE_RATE_TH GENMASK(30, 27)
+#define R_BEDGE2 0x6C00
+#define B_EHT_MCS15 BIT(31)
+#define B_HT_VHT_TH GENMASK(11, 0)
+#define R_BEDGE3 0x6C04
+#define B_TB_EN BIT(23)
+#define B_HEMU_EN BIT(21)
+#define B_HEERSU_EN BIT(19)
+#define B_EHTTB_EN BIT(15)
+#define B_BEDGE_CFG GENMASK(1, 0)
+#define R_SU_PUNC 0x6C08
+#define B_SU_PUNC_EN BIT(1)
+#define R_BEDGE5 0x6C10
+#define B_HWGEN_EN BIT(25)
+#define B_PWROFST_COMP BIT(20)
 #define R_RPL_BIAS_COMP1 0x6DF0
 #define B_RPL_BIAS_COMP1_MASK GENMASK(7, 0)
+#define R_DBCC_FA 0x703C
+#define B_DBCC_FA BIT(12)
 #define R_P1_TSSI_ALIM1 0x7630
 #define B_P1_TSSI_ALIM1 GENMASK(29, 0)
 #define B_P1_TSSI_ALIM11 GENMASK(29, 20)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 40020d0ebbdf..09b23c56aa8e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2299,6 +2299,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.enable_bb_rf		= rtw8851b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8851b_mac_disable_bb_rf,
 	.bb_preinit		= NULL,
+	.bb_postinit		= NULL,
 	.bb_reset		= rtw8851b_bb_reset,
 	.bb_sethw		= rtw8851b_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 726b08ca5897..c28f05bbdccf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2043,6 +2043,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.enable_bb_rf		= rtw89_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw89_mac_disable_bb_rf,
 	.bb_preinit		= NULL,
+	.bb_postinit		= NULL,
 	.bb_reset		= rtw8852a_bb_reset,
 	.bb_sethw		= rtw8852a_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b3ad84cfad95..18ed372ed5cd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2468,6 +2468,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
 	.bb_preinit		= NULL,
+	.bb_postinit		= NULL,
 	.bb_reset		= rtw8852b_bb_reset,
 	.bb_sethw		= rtw8852b_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cbc896a29fb4..431acfaba89b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2813,6 +2813,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.enable_bb_rf		= rtw8852c_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852c_mac_disable_bb_rf,
 	.bb_preinit		= NULL,
+	.bb_postinit		= NULL,
 	.bb_reset		= rtw8852c_bb_reset,
 	.bb_sethw		= rtw8852c_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 1ccaea3af4ae..1a070d6e1c16 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -792,6 +792,196 @@ static void rtw8922a_ctrl_ch(struct rtw89_dev *rtwdev,
 	rtw8922a_set_gain(rtwdev, chan, RF_PATH_B, phy_idx);
 }
 
+static void rtw8922a_ctrl_afe_dac(struct rtw89_dev *rtwdev, enum rtw89_bandwidth bw,
+				  enum rtw89_rf_path path)
+{
+	u32 cr_ofst = 0x0;
+
+	if (path == RF_PATH_B)
+		cr_ofst = 0x100;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+	case RTW89_CHANNEL_WIDTH_10:
+	case RTW89_CHANNEL_WIDTH_20:
+	case RTW89_CHANNEL_WIDTH_40:
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_mask(rtwdev, R_AFEDAC0 + cr_ofst, B_AFEDAC0, 0xE);
+		rtw89_phy_write32_mask(rtwdev, R_AFEDAC1 + cr_ofst, B_AFEDAC1, 0x7);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rtw89_phy_write32_mask(rtwdev, R_AFEDAC0 + cr_ofst, B_AFEDAC0, 0xD);
+		rtw89_phy_write32_mask(rtwdev, R_AFEDAC1 + cr_ofst, B_AFEDAC1, 0x6);
+		break;
+	default:
+		break;
+	}
+}
+
+static const struct rtw89_reg2_def bb_mcu0_init_reg[] = {
+	{0x6990, 0x00000000},
+	{0x6994, 0x00000000},
+	{0x6998, 0x00000000},
+	{0x6820, 0xFFFFFFFE},
+	{0x6800, 0xC0000FFE},
+	{0x6808, 0x76543210},
+	{0x6814, 0xBFBFB000},
+	{0x6818, 0x0478C009},
+	{0x6800, 0xC0000FFF},
+	{0x6820, 0xFFFFFFFF},
+};
+
+static const struct rtw89_reg2_def bb_mcu1_init_reg[] = {
+	{0x6990, 0x00000000},
+	{0x6994, 0x00000000},
+	{0x6998, 0x00000000},
+	{0x6820, 0xFFFFFFFE},
+	{0x6800, 0xC0000FFE},
+	{0x6808, 0x76543210},
+	{0x6814, 0xBFBFB000},
+	{0x6818, 0x0478C009},
+	{0x6800, 0xC0000FFF},
+	{0x6820, 0xFFFFFFFF},
+};
+
+static void rtw8922a_bbmcu_cr_init(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_reg2_def *reg;
+	int size;
+	int i;
+
+	if (phy_idx == RTW89_PHY_0) {
+		reg = bb_mcu0_init_reg;
+		size = ARRAY_SIZE(bb_mcu0_init_reg);
+	} else {
+		reg = bb_mcu1_init_reg;
+		size = ARRAY_SIZE(bb_mcu1_init_reg);
+	}
+
+	for (i = 0; i < size; i++, reg++)
+		rtw89_bbmcu_write32(rtwdev, reg->addr, reg->data, phy_idx);
+}
+
+static const u32 dmac_sys_mask[2] = {B_BE_DMAC_BB_PHY0_MASK, B_BE_DMAC_BB_PHY1_MASK};
+static const u32 bbrst_mask[2] = {B_BE_FEN_BBPLAT_RSTB, B_BE_FEN_BB1PLAT_RSTB};
+static const u32 glbrst_mask[2] = {B_BE_FEN_BB_IP_RSTN, B_BE_FEN_BB1_IP_RSTN};
+static const u32 mcu_bootrdy_mask[2] = {B_BE_BOOT_RDY0, B_BE_BOOT_RDY1};
+
+static void rtw8922a_bb_preinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u32 rdy = 0;
+
+	if (phy_idx == RTW89_PHY_1)
+		rdy = 1;
+
+	rtw89_write32_mask(rtwdev, R_BE_DMAC_SYS_CR32B, dmac_sys_mask[phy_idx], 0x7FF9);
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, glbrst_mask[phy_idx], 0x0);
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, bbrst_mask[phy_idx], 0x0);
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, glbrst_mask[phy_idx], 0x1);
+	rtw89_write32_mask(rtwdev, R_BE_FEN_RST_ENABLE, mcu_bootrdy_mask[phy_idx], rdy);
+	rtw89_write32_mask(rtwdev, R_BE_MEM_PWR_CTRL, B_BE_MEM_BBMCU0_DS_V1, 0);
+
+	fsleep(1);
+	rtw8922a_bbmcu_cr_init(rtwdev, phy_idx);
+}
+
+static void rtw8922a_bb_postinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	if (phy_idx == RTW89_PHY_0)
+		rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, mcu_bootrdy_mask[phy_idx]);
+	rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, bbrst_mask[phy_idx]);
+
+	rtw89_phy_write32_set(rtwdev, R_BBCLK, B_CLK_640M);
+	rtw89_phy_write32_clr(rtwdev, R_TXSCALE, B_TXFCTR_EN);
+	rtw89_phy_set_phy_regs(rtwdev, R_TXFCTR, B_TXFCTR_THD, 0x200);
+	rtw89_phy_set_phy_regs(rtwdev, R_SLOPE, B_EHT_RATE_TH, 0xA);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE, B_HE_RATE_TH, 0xA);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE2, B_HT_VHT_TH, 0xAAA);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE, B_EHT_MCS14, 0x1);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE2, B_EHT_MCS15, 0x1);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE3, B_EHTTB_EN, 0x0);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE3, B_HEERSU_EN, 0x0);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE3, B_HEMU_EN, 0x0);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE3, B_TB_EN, 0x0);
+	rtw89_phy_set_phy_regs(rtwdev, R_SU_PUNC, B_SU_PUNC_EN, 0x1);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE5, B_HWGEN_EN, 0x1);
+	rtw89_phy_set_phy_regs(rtwdev, R_BEDGE5, B_PWROFST_COMP, 0x1);
+	rtw89_phy_set_phy_regs(rtwdev, R_MAG_AB, B_BY_SLOPE, 0x1);
+	rtw89_phy_set_phy_regs(rtwdev, R_MAG_A, B_MGA_AEND, 0xe0);
+	rtw89_phy_set_phy_regs(rtwdev, R_MAG_AB, B_MAG_AB, 0xe0c000);
+	rtw89_phy_set_phy_regs(rtwdev, R_SLOPE, B_SLOPE_A, 0x3FE0);
+	rtw89_phy_set_phy_regs(rtwdev, R_SLOPE, B_SLOPE_B, 0x3FE0);
+	rtw89_phy_set_phy_regs(rtwdev, R_SC_CORNER, B_SC_CORNER, 0x200);
+	rtw89_phy_write32_idx(rtwdev, R_UDP_COEEF, B_UDP_COEEF, 0x0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_UDP_COEEF, B_UDP_COEEF, 0x1, phy_idx);
+}
+
+static void rtw8922a_bb_reset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+}
+
+static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	if (mode == MLO_1_PLUS_1_1RF || mode == DBCC_LEGACY) {
+		rtw89_phy_write32_mask(rtwdev, R_DBCC, B_DBCC_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_DBCC_FA, B_DBCC_FA, 0x0);
+	} else if (mode == MLO_2_PLUS_0_1RF || mode == MLO_0_PLUS_2_1RF ||
+		   mode == MLO_DBCC_NOT_SUPPORT) {
+		rtw89_phy_write32_mask(rtwdev, R_DBCC, B_DBCC_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_DBCC_FA, B_DBCC_FA, 0x1);
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	if (mode == MLO_2_PLUS_0_1RF) {
+		rtw8922a_ctrl_afe_dac(rtwdev, chan->band_width, RF_PATH_A);
+		rtw8922a_ctrl_afe_dac(rtwdev, chan->band_width, RF_PATH_B);
+	} else {
+		rtw89_warn(rtwdev, "unsupported MLO mode %d\n", mode);
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x6180);
+
+	if (mode == MLO_2_PLUS_0_1RF) {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xBBAB);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xABA9);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEBA9);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEAA9);
+	} else if (mode == MLO_0_PLUS_2_1RF) {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xBBAB);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xAFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEEFF);
+	} else if ((mode == MLO_1_PLUS_1_1RF) || (mode == DBCC_LEGACY)) {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x7BAB);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x3BAB);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x3AAB);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x180);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x0);
+	}
+
+	return 0;
+}
+
+static void rtw8922a_bb_sethw(struct rtw89_dev *rtwdev)
+{
+	u32 reg;
+
+	rtw89_phy_write32_clr(rtwdev, R_EN_SND_WO_NDP, B_EN_SND_WO_NDP);
+	rtw89_phy_write32_clr(rtwdev, R_EN_SND_WO_NDP_C1, B_EN_SND_WO_NDP);
+
+	rtw89_write32_mask(rtwdev, R_BE_PWR_BOOST, B_BE_PWR_CTRL_SEL, 0);
+	if (rtwdev->dbcc_en) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_BOOST, RTW89_MAC_1);
+		rtw89_write32_mask(rtwdev, reg, B_BE_PWR_CTRL_SEL, 0);
+	}
+
+	rtw8922a_ctrl_mlo(rtwdev, rtwdev->mlo_dbcc_mode);
+}
+
 static void rtw8922a_set_channel_bb(struct rtw89_dev *rtwdev,
 				    const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
@@ -836,6 +1026,10 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.enable_bb_rf		= rtw8922a_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8922a_mac_disable_bb_rf,
+	.bb_preinit		= rtw8922a_bb_preinit,
+	.bb_postinit		= rtw8922a_bb_postinit,
+	.bb_reset		= rtw8922a_bb_reset,
+	.bb_sethw		= rtw8922a_bb_sethw,
 	.set_channel		= rtw8922a_set_channel,
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
-- 
2.25.1


