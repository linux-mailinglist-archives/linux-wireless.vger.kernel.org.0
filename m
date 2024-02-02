Return-Path: <linux-wireless+bounces-2992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC8846666
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4671B1F27DB2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159012E63;
	Fri,  2 Feb 2024 03:08:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D10125A9
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843290; cv=none; b=r260TuSGWoxHAN+kdjTmw25MyDzdirDsxRTN/jkwfK6gzAVViBwTuOddZsPADUdJ6YwITMKXbzFxWPQfG3VIascdrY3tK41sVVp1QswwyQa09Ow4R0zXcIXUGZ0hnVVu9yo4ok0CnutRkaYNTmkLmZEp20DgvM30iXC6ckKR1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843290; c=relaxed/simple;
	bh=1WtpECXvQtCLrfaONn7+pCNw7P4wp3OjGGMKvz1DQIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahjhIS1UNwp08jbGDYsS2sZXEQ63LH4xheOtklA6Y9IGHJ/KzYAhbF6/KmE8893BwoPwZsKiChWCob9bv6vC0+hkN2YuYWDvRcO55SVFRdBVMjAv8leA+hxyiNLN3aZ6oFI2Jyp/rbyml3OkyknbGhxyi+tBix8LErWH44zXnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 412382Vo81863197, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 412382Vo81863197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:08:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 2 Feb 2024 11:08:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:08:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 11/11] wifi: rtw89: 8922a: add chip_ops::rfk_hw_init
Date: Fri, 2 Feb 2024 11:06:42 +0800
Message-ID: <20240202030642.108385-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202030642.108385-1-pkshih@realtek.com>
References: <20240202030642.108385-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Add a chip_ops for WiFi 7 chips to set additional RF configurations
including MLO and PLL settings.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   9 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   6 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 202 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.h |   1 +
 11 files changed, 226 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 270403f6c3d5..22255e98ab6b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3156,6 +3156,7 @@ struct rtw89_chip_ops {
 	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
 	void (*fem_setup)(struct rtw89_dev *rtwdev);
 	void (*rfe_gpio)(struct rtw89_dev *rtwdev);
+	void (*rfk_hw_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_init_late)(struct rtw89_dev *rtwdev);
 	void (*rfk_channel)(struct rtw89_dev *rtwdev);
@@ -5604,6 +5605,14 @@ static inline void rtw89_chip_rfe_gpio(struct rtw89_dev *rtwdev)
 		chip->ops->rfe_gpio(rtwdev);
 }
 
+static inline void rtw89_chip_rfk_hw_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->rfk_hw_init)
+		chip->ops->rfk_hw_init(rtwdev);
+}
+
 static inline
 void rtw89_chip_bb_preinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b3fe4cab6d3a..7aea57804e93 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1328,6 +1328,7 @@ enum rtw89_mac_xtal_si_offset {
 #define XTAL_SI_BIG_PWR_CUT	BIT(1)
 	XTAL_SI_XTAL_DRV = 0x15,
 #define XTAL_SI_DRV_LATCH	BIT(4)
+	XTAL_SI_XTAL_PLL = 0x16,
 	XTAL_SI_XTAL_XMD_2 = 0x24,
 #define XTAL_SI_LDO_LPS		GENMASK(6, 4)
 	XTAL_SI_XTAL_XMD_4 = 0x26,
@@ -1361,6 +1362,7 @@ enum rtw89_mac_xtal_si_offset {
 	XTAL_SI_SRAM_CTRL = 0xA1,
 #define XTAL_SI_SRAM_DIS	BIT(1)
 #define FULL_BIT_MASK		GENMASK(7, 0)
+	XTAL_SI_APBT = 0xD1,
 	XTAL_SI_PLL = 0xE0,
 	XTAL_SI_PLL_1 = 0xE1,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f02b365b0cec..9a8f5b764617 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5874,6 +5874,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_chip_rfe_gpio(rtwdev);
 	rtw89_phy_antdiv_set_ant(rtwdev);
 
+	rtw89_chip_rfk_hw_init(rtwdev);
 	rtw89_phy_init_rf_nctl(rtwdev);
 	rtw89_chip_rfk_init(rtwdev);
 	rtw89_chip_set_txpwr_ctrl(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9f209f068679..6368b2b32c0c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7402,6 +7402,7 @@
 #define RR_MOD_M_RXBB GENMASK(9, 5)
 #define RR_MOD_LO_SEL BIT(1)
 #define RR_MODOPT 0x01
+#define RR_TXG_SEL GENMASK(19, 17)
 #define RR_MODOPT_M_TXPWR GENMASK(5, 0)
 #define RR_WLSEL 0x02
 #define RR_WLSEL_AG GENMASK(18, 16)
@@ -7594,6 +7595,7 @@
 #define RR_MIXER_GN GENMASK(4, 3)
 #define RR_POW 0xa0
 #define RR_POW_SYN GENMASK(3, 2)
+#define RR_POW_SYN_V1 GENMASK(3, 0)
 #define RR_LOGEN 0xa3
 #define RR_LOGEN_RPT GENMASK(19, 16)
 #define RR_SX 0xaf
@@ -8734,6 +8736,8 @@
 #define B_COEF_SEL_IQC BIT(0)
 #define B_COEF_SEL_IQC_V1 GENMASK(1, 0)
 #define B_COEF_SEL_MDPD BIT(8)
+#define B_COEF_SEL_MDPD_V1 GENMASK(9, 8)
+#define B_COEF_SEL_EN BIT(31)
 #define R_CFIR_SYS 0x8120
 #define R_IQK_RES 0x8124
 #define B_IQK_RES_K BIT(28)
@@ -8755,8 +8759,10 @@
 #define B_RFGAIN_BND GENMASK(4, 0)
 #define R_CFIR_MAP 0x8150
 #define R_CFIR_LUT 0x8154
+#define R_CFIR_LUT_C1 0x8254
 #define B_CFIR_LUT_SEL BIT(8)
 #define B_CFIR_LUT_SET BIT(4)
+#define B_CFIR_LUT_G5 BIT(5)
 #define B_CFIR_LUT_G3 BIT(3)
 #define B_CFIR_LUT_G2 BIT(2)
 #define B_CFIR_LUT_GP_V1 GENMASK(2, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 09e38713bca7..83db0a686ee2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2310,6 +2310,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.read_phycap		= rtw8851b_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= rtw8851b_rfe_gpio,
+	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8851b_rfk_init,
 	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8851b_rfk_channel,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 01c249dddfb8..8e808ded5d52 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2054,6 +2054,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.read_phycap		= rtw8852a_read_phycap,
 	.fem_setup		= rtw8852a_fem_setup,
 	.rfe_gpio		= NULL,
+	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8852a_rfk_init,
 	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8852a_rfk_channel,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index fb6ad335a37a..19454766f3de 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2479,6 +2479,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.read_phycap		= rtw8852b_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
+	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8852b_rfk_init,
 	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8852b_rfk_channel,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 00861c328ca0..ca8547fbd70e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2824,6 +2824,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.read_phycap		= rtw8852c_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
+	.rfk_hw_init		= NULL,
 	.rfk_init		= rtw8852c_rfk_init,
 	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8852c_rfk_channel,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0cbe4780eb69..6dc051934b0f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1694,6 +1694,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_phycap		= rtw8922a_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
+	.rfk_hw_init		= rtw8922a_rfk_hw_init,
 	.rfk_init		= rtw8922a_rfk_init,
 	.rfk_init_late		= rtw8922a_rfk_init_late,
 	.rfk_channel		= rtw8922a_rfk_channel,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index e0e8048db739..d8ef986e7877 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -2,7 +2,9 @@
 /* Copyright(c) 2023  Realtek Corporation
  */
 
+#include "chan.h"
 #include "debug.h"
+#include "mac.h"
 #include "phy.h"
 #include "reg.h"
 #include "rtw8922a.h"
@@ -31,3 +33,203 @@ void rtw8922a_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
 		rtw8922a_tssi_cont_en(rtwdev, en, RF_PATH_B);
 	}
 }
+
+enum _rf_syn_pow {
+	RF_SYN_ON_OFF,
+	RF_SYN_OFF_ON,
+	RF_SYN_ALLON,
+	RF_SYN_ALLOFF,
+};
+
+static void rtw8922a_set_syn01_cav(struct rtw89_dev *rtwdev, enum _rf_syn_pow syn)
+{
+	if (syn == RF_SYN_ALLON) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x3);
+
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x3);
+	} else if (syn == RF_SYN_ON_OFF) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x3);
+
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x0);
+	} else if (syn == RF_SYN_OFF_ON) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x0);
+
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x3);
+	} else if (syn == RF_SYN_ALLOFF) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN, 0x0);
+	}
+}
+
+static void rtw8922a_set_syn01_cbv(struct rtw89_dev *rtwdev, enum _rf_syn_pow syn)
+{
+	if (syn == RF_SYN_ALLON) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0xf);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0xf);
+	} else if (syn == RF_SYN_ON_OFF) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0xf);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0x0);
+	} else if (syn == RF_SYN_OFF_ON) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0xf);
+	} else if (syn == RF_SYN_ALLOFF) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0x0);
+	}
+}
+
+static void rtw8922a_set_syn01(struct rtw89_dev *rtwdev, enum _rf_syn_pow syn)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "SYN config=%d\n", syn);
+
+	if (hal->cv == CHIP_CAV)
+		rtw8922a_set_syn01_cav(rtwdev, syn);
+	else
+		rtw8922a_set_syn01_cbv(rtwdev, syn);
+}
+
+static void rtw8922a_chlk_ktbl_sel(struct rtw89_dev *rtwdev, u8 kpath, u8 idx)
+{
+	u32 tmp;
+
+	if (idx > 2) {
+		rtw89_warn(rtwdev, "[DBCC][ERROR]indx is out of limit!! index(%d)", idx);
+		return;
+	}
+
+	if (kpath & RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL, B_COEF_SEL_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL, B_COEF_SEL_IQC_V1, idx);
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL, B_COEF_SEL_MDPD_V1, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RR_TXG_SEL, 0x4 | idx);
+
+		tmp = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL, BIT(0));
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, tmp);
+		tmp = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL, BIT(1));
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G5, tmp);
+	}
+
+	if (kpath & RF_B) {
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL_C1, B_COEF_SEL_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL_C1, B_COEF_SEL_IQC_V1, idx);
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL_C1, B_COEF_SEL_MDPD_V1, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RR_TXG_SEL, 0x4 | idx);
+
+		tmp = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL_C1, BIT(0));
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT_C1, B_CFIR_LUT_G3, tmp);
+		tmp = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL_C1, BIT(1));
+		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT_C1, B_CFIR_LUT_G5, tmp);
+	}
+}
+
+static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	enum rtw89_sub_entity_idx sub_entity_idx;
+	const struct rtw89_chan *chan;
+	enum rtw89_entity_mode mode;
+	u8 s0_tbl, s1_tbl;
+	u8 tbl_sel;
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		sub_entity_idx = RTW89_SUB_ENTITY_1;
+		tbl_sel = 1;
+		break;
+	default:
+		sub_entity_idx = RTW89_SUB_ENTITY_0;
+		tbl_sel = 0;
+		break;
+	}
+
+	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
+
+	rfk_mcc->ch[tbl_sel] = chan->channel;
+	rfk_mcc->band[tbl_sel] = chan->band_type;
+	rfk_mcc->bw[tbl_sel] = chan->band_width;
+	rfk_mcc->table_idx = tbl_sel;
+
+	s0_tbl = tbl_sel;
+	s1_tbl = tbl_sel;
+
+	rtw8922a_chlk_ktbl_sel(rtwdev, RF_A, s0_tbl);
+	rtw8922a_chlk_ktbl_sel(rtwdev, RF_B, s1_tbl);
+}
+
+static void rtw8922a_rfk_mlo_ctrl(struct rtw89_dev *rtwdev)
+{
+	enum _rf_syn_pow syn_pow;
+
+	if (!rtwdev->dbcc_en)
+		goto set_rfk_reload;
+
+	switch (rtwdev->mlo_dbcc_mode) {
+	case MLO_0_PLUS_2_1RF:
+		syn_pow = RF_SYN_OFF_ON;
+		break;
+	case MLO_0_PLUS_2_2RF:
+	case MLO_1_PLUS_1_2RF:
+	case MLO_2_PLUS_0_1RF:
+	case MLO_2_PLUS_0_2RF:
+	case MLO_2_PLUS_2_2RF:
+	case MLO_DBCC_NOT_SUPPORT:
+	default:
+		syn_pow = RF_SYN_ON_OFF;
+		break;
+	case MLO_1_PLUS_1_1RF:
+	case DBCC_LEGACY:
+		syn_pow = RF_SYN_ALLON;
+		break;
+	}
+
+	rtw8922a_set_syn01(rtwdev, syn_pow);
+
+set_rfk_reload:
+	rtw8922a_chlk_reload(rtwdev);
+}
+
+static void rtw8922a_rfk_pll_init(struct rtw89_dev *rtwdev)
+{
+	int ret;
+	u8 tmp;
+
+	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_PLL_1, &tmp);
+	if (ret)
+		return;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_PLL_1, tmp | 0xf8, 0xFF);
+	if (ret)
+		return;
+
+	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_APBT, &tmp);
+	if (ret)
+		return;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_APBT, tmp & ~0x60, 0xFF);
+	if (ret)
+		return;
+
+	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_XTAL_PLL, &tmp);
+	if (ret)
+		return;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_PLL, tmp | 0x38, 0xFF);
+	if (ret)
+		return;
+}
+
+void rtw8922a_rfk_hw_init(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->dbcc_en)
+		rtw8922a_rfk_mlo_ctrl(rtwdev);
+
+	rtw8922a_rfk_pll_init(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
index fbd22de269e2..de5fa6c74530 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
@@ -8,5 +8,6 @@
 #include "core.h"
 
 void rtw8922a_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
+void rtw8922a_rfk_hw_init(struct rtw89_dev *rtwdev);
 
 #endif
-- 
2.25.1


