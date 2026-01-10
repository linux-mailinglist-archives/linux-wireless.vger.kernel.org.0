Return-Path: <linux-wireless+bounces-30622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CCD0CD1F
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C6CF302CDD0
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3748258EFF;
	Sat, 10 Jan 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rZfc0aH7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308D2A1CF
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011665; cv=none; b=a8aYbrhW8Jbn9hdHayzXF5j7EGctZzh8egDoEFrrfRixfccnzWOsM9xtGKGGFBeRp+lwg/mUmKPAlANK00gLqZ8kOMaJj7CcDAq62ivKsFETA15puPxY/a74STfi4NnPTK2NdVEdzNSMwJKfN03AM6e+YGDc22WR4nbJvhrI9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011665; c=relaxed/simple;
	bh=Xi1yJtet+0XhUYsD7pV5nZPQQr49kmFWBtAAWfwflDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ny7UI+wCqNSzl8TYixODsfxQalMuM6VrsdL78T/kjTyBTcW426MzvN1dbwhlu2SqAKgyHXh8eFbiW1GJ7Dgzel0YbeSdV0n1NYuTJFrJllpNkeZ1vlMJtu1LpF+0uZ4QrkCC73Zn8DIbgqXmmrQQhkYOF18aFMMrpVYxdlxsETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rZfc0aH7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2L1CR0241759, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011661; bh=WVfwcwwRcHUd4LTBHyF+O68zp/9L+hIXB3BWTBIimAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rZfc0aH7qYrO88MfnqWi0+rQARNj+j5iud0e05OCP00OtmSERGX+6ZHtwN3f/46LC
	 KLw4wH7FOb8q8tsJ07yViSd+Uc95SurX5q0+JiFw+/iBCz38H+e3j5hlbKlw5qdhzz
	 VYxohgi81Vw6TT/ENbArlUMODD+BkBI+0iezrc1EEbMg3w9TKkHKAQRKblByPHyypI
	 MDM3GM/c1dhYUax3sHFeWXMz8AHWhaeqjTDdzEJpgfXWo2W2laThX6By0YVaOIaGth
	 Mpfa5/U845Ychh6gaFEkgMwpRcTohhKeV+B1UgkWmy4XeQX180Qm2/Kh/Uv8uOME6F
	 7mX75gtG15rQw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2L1CR0241759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:21:01 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:21:01 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:21:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 8/8] wifi: rtw89: pci: consider RTL8922D in PCI common flow
Date: Sat, 10 Jan 2026 10:20:19 +0800
Message-ID: <20260110022019.2254969-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Clear TX/RX ring index, PCI operating mode, SER setting, PCI LTR and
preinit settings.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h    |  31 +++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 125 +++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/reg.h    |  14 +++
 3 files changed, 151 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 16dfb0e79d77..7689395e51a1 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -55,6 +55,8 @@
 #define B_AX_CALIB_EN			BIT(13)
 #define B_AX_DIV			GENMASK(15, 14)
 #define RAC_SET_PPR_V1			0x31
+#define RAC_ANA41			0x41
+#define PHY_ERR_FLAG_EN		        BIT(6)
 
 #define R_AX_DBI_FLAG			0x1090
 #define B_AX_DBI_RFLAG			BIT(17)
@@ -145,6 +147,11 @@
 #define R_RAC_DIRECT_OFFSET_BE_LANE0_G2 0x3900
 #define R_RAC_DIRECT_OFFSET_BE_LANE1_G2 0x3980
 
+#define RAC_DIRECT_OFFESET_L0_G1 0x3800
+#define RAC_DIRECT_OFFESET_L1_G1 0x3900
+#define RAC_DIRECT_OFFESET_L0_G2 0x3A00
+#define RAC_DIRECT_OFFESET_L1_G2 0x3B00
+
 #define RTW89_PCI_WR_RETRY_CNT		20
 
 /* Interrupts */
@@ -296,6 +303,10 @@
 #define B_BE_PCIE_EN_AUX_CLK BIT(0)
 
 #define R_BE_PCIE_PS_CTRL 0x3008
+#define B_BE_ASPM_L11_EN BIT(19)
+#define B_BE_ASPM_L12_EN BIT(18)
+#define B_BE_PCIPM_L11_EN BIT(17)
+#define B_BE_PCIPM_L12_EN BIT(16)
 #define B_BE_RSM_L0S_EN BIT(8)
 #define B_BE_CMAC_EXIT_L1_EN BIT(7)
 #define B_BE_DMAC0_EXIT_L1_EN BIT(6)
@@ -974,6 +985,12 @@
 #define R_BE_PCIE_CRPWM 0x30C4
 
 #define R_BE_L1_2_CTRL_HCILDO 0x3110
+#define B_BE_PM_CLKREQ_EXT_RB BIT(11)
+#define B_BE_PCIE_DIS_RTK_PRST_N_L1_2 BIT(10)
+#define B_BE_PCIE_PRST_IN_L1_2_RB BIT(9)
+#define B_BE_PCIE_PRST_SEL_RB_V1 BIT(8)
+#define B_BE_PCIE_DIS_L2_CTRL_APHY_SUSB BIT(7)
+#define B_BE_PCIE_DIS_L1_2_CTRL_APHY_SUSB BIT(6)
 #define B_BE_PCIE_DIS_L1_2_CTRL_HCILDO BIT(0)
 
 #define R_BE_PL1_DBG_INFO 0x3120
@@ -1023,9 +1040,11 @@
 #define B_BE_PL1_SER_PL1_EN BIT(31)
 #define B_BE_PL1_IGNORE_HOT_RST BIT(30)
 #define B_BE_PL1_TIMER_UNIT_MASK GENMASK(19, 17)
+#define PCIE_SER_TIMER_UNIT 0x2
 #define B_BE_PL1_TIMER_CLEAR BIT(0)
 
 #define R_BE_REG_PL1_MASK 0x34B0
+#define B_BE_SER_LTSSM_UNSTABLE_MASK BIT(6)
 #define B_BE_SER_PCLKREQ_ACK_MASK BIT(5)
 #define B_BE_SER_PM_CLK_MASK BIT(4)
 #define B_BE_SER_LTSSM_IMR BIT(3)
@@ -1055,6 +1074,18 @@
 #define B_BE_CLR_CH2_IDX BIT(2)
 #define B_BE_CLR_CH1_IDX BIT(1)
 #define B_BE_CLR_CH0_IDX BIT(0)
+#define B_BE_CLR_ALL_IDX_MASK (B_BE_CLR_CH0_IDX | B_BE_CLR_CH1_IDX | \
+			       B_BE_CLR_CH2_IDX | B_BE_CLR_CH3_IDX | \
+			       B_BE_CLR_CH4_IDX | B_BE_CLR_CH5_IDX | \
+			       B_BE_CLR_CH6_IDX | B_BE_CLR_CH7_IDX | \
+			       B_BE_CLR_CH8_IDX | B_BE_CLR_CH9_IDX | \
+			       B_BE_CLR_CH10_IDX | B_BE_CLR_CH11_IDX | \
+			       B_BE_CLR_CH12_IDX | B_BE_CLR_CH13_IDX | \
+			       B_BE_CLR_CH14_IDX)
+#define B_BE_CLR_ALL_IDX_MASK_V1 (B_BE_CLR_CH0_IDX | B_BE_CLR_CH2_IDX | \
+				  B_BE_CLR_CH4_IDX | B_BE_CLR_CH6_IDX | \
+				  B_BE_CLR_CH8_IDX | B_BE_CLR_CH10_IDX | \
+				  B_BE_CLR_CH12_IDX)
 
 #define R_BE_RXBD_RWPTR_CLR1_V1 0xB018
 #define B_BE_CLR_ROQ1_IDX_V1 BIT(5)
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 95efb1094b6c..d538c80b96d2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -46,6 +46,14 @@ static void rtw89_pci_aspm_set_be(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_pci_l1ss_set_be(struct rtw89_dev *rtwdev, bool enable)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (enable && chip_id == RTL8922D && hal->cid == RTL8922D_CID7090)
+		rtw89_write32_set(rtwdev, R_BE_PCIE_PS_CTRL,
+				  B_BE_ASPM_L11_EN | B_BE_ASPM_L12_EN |
+				  B_BE_PCIPM_L11_EN | B_BE_PCIPM_L12_EN);
+
 	if (enable)
 		rtw89_write32_set(rtwdev, R_BE_PCIE_MIX_CFG,
 				  B_BE_L1SUB_ENABLE);
@@ -154,7 +162,7 @@ static void rtw89_pci_ctrl_trxdma_pcie_be(struct rtw89_dev *rtwdev,
 
 	rtw89_write32(rtwdev, R_BE_HAXI_INIT_CFG1, val);
 
-	if (io_en == MAC_AX_PCIE_ENABLE)
+	if (io_en == MAC_AX_PCIE_ENABLE && rtwdev->chip->chip_id == RTL8922A)
 		rtw89_write32_mask(rtwdev, R_BE_HAXI_MST_WDT_TIMEOUT_SEL_V1,
 				   B_BE_HAXI_MST_WDT_TIMEOUT_SEL_MASK, 4);
 }
@@ -162,14 +170,15 @@ static void rtw89_pci_ctrl_trxdma_pcie_be(struct rtw89_dev *rtwdev,
 static void rtw89_pci_clr_idx_all_be(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_pci_rx_ring *rx_ring;
 	u32 val;
 
-	val = B_BE_CLR_CH0_IDX | B_BE_CLR_CH1_IDX | B_BE_CLR_CH2_IDX |
-	      B_BE_CLR_CH3_IDX | B_BE_CLR_CH4_IDX | B_BE_CLR_CH5_IDX |
-	      B_BE_CLR_CH6_IDX | B_BE_CLR_CH7_IDX | B_BE_CLR_CH8_IDX |
-	      B_BE_CLR_CH9_IDX | B_BE_CLR_CH10_IDX | B_BE_CLR_CH11_IDX |
-	      B_BE_CLR_CH12_IDX | B_BE_CLR_CH13_IDX | B_BE_CLR_CH14_IDX;
+	if (chip->chip_id == RTL8922A)
+		val = B_BE_CLR_ALL_IDX_MASK;
+	else
+		val = B_BE_CLR_ALL_IDX_MASK_V1;
+
 	rtw89_write32(rtwdev, R_BE_TXBD_RWPTR_CLR1, val);
 
 	rtw89_write32(rtwdev, R_BE_RXBD_RWPTR_CLR1_V1,
@@ -226,20 +235,24 @@ static int rtw89_pci_poll_dma_all_idle_be(struct rtw89_dev *rtwdev)
 static void rtw89_pci_mode_op_be(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val32_init1, val32_rxapp, val32_exp;
 
 	val32_init1 = rtw89_read32(rtwdev, R_BE_HAXI_INIT_CFG1);
-	val32_rxapp = rtw89_read32(rtwdev, R_BE_RX_APPEND_MODE);
+	if (chip->chip_id == RTL8922A)
+		val32_rxapp = rtw89_read32(rtwdev, R_BE_RX_APPEND_MODE);
 	val32_exp = rtw89_read32(rtwdev, R_BE_HAXI_EXP_CTRL_V1);
 
-	if (info->rxbd_mode == MAC_AX_RXBD_PKT) {
-		val32_init1 = u32_replace_bits(val32_init1, PCIE_RXBD_NORM,
-					       B_BE_RXQ_RXBD_MODE_MASK);
-	} else if (info->rxbd_mode == MAC_AX_RXBD_SEP) {
-		val32_init1 = u32_replace_bits(val32_init1, PCIE_RXBD_SEP,
-					       B_BE_RXQ_RXBD_MODE_MASK);
-		val32_rxapp = u32_replace_bits(val32_rxapp, 0,
-					       B_BE_APPEND_LEN_MASK);
+	if (chip->chip_id == RTL8922A) {
+		if (info->rxbd_mode == MAC_AX_RXBD_PKT) {
+			val32_init1 = u32_replace_bits(val32_init1, PCIE_RXBD_NORM,
+						       B_BE_RXQ_RXBD_MODE_MASK);
+		} else if (info->rxbd_mode == MAC_AX_RXBD_SEP) {
+			val32_init1 = u32_replace_bits(val32_init1, PCIE_RXBD_SEP,
+						       B_BE_RXQ_RXBD_MODE_MASK);
+			val32_rxapp = u32_replace_bits(val32_rxapp, 0,
+						       B_BE_APPEND_LEN_MASK);
+		}
 	}
 
 	val32_init1 = u32_replace_bits(val32_init1, info->tx_burst,
@@ -254,7 +267,8 @@ static void rtw89_pci_mode_op_be(struct rtw89_dev *rtwdev)
 				       B_BE_CFG_WD_PERIOD_ACTIVE_MASK);
 
 	rtw89_write32(rtwdev, R_BE_HAXI_INIT_CFG1, val32_init1);
-	rtw89_write32(rtwdev, R_BE_RX_APPEND_MODE, val32_rxapp);
+	if (chip->chip_id == RTL8922A)
+		rtw89_write32(rtwdev, R_BE_RX_APPEND_MODE, val32_rxapp);
 	rtw89_write32(rtwdev, R_BE_HAXI_EXP_CTRL_V1, val32_exp);
 }
 
@@ -280,6 +294,10 @@ static void rtw89_pci_debounce_be(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_ldo_low_pwr_be(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 clr;
+
 	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_PSUS_OFF_CAPC_EN);
 	rtw89_write32_set(rtwdev, R_BE_SYS_PAGE_CLK_GATED,
 			  B_BE_SOP_OFFPOOBS_PC | B_BE_CPHY_AUXCLK_OP |
@@ -287,7 +305,16 @@ static void rtw89_pci_ldo_low_pwr_be(struct rtw89_dev *rtwdev)
 	rtw89_write32_clr(rtwdev, R_BE_SYS_SDIO_CTRL, B_BE_PCIE_FORCE_IBX_EN |
 						      B_BE_PCIE_DIS_L2_RTK_PERST |
 						      B_BE_PCIE_DIS_L2__CTRL_LDO_HCI);
-	rtw89_write32_clr(rtwdev, R_BE_L1_2_CTRL_HCILDO, B_BE_PCIE_DIS_L1_2_CTRL_HCILDO);
+
+	if (chip_id == RTL8922D && hal->cid == RTL8922D_CID7090)
+		clr = B_BE_PCIE_DIS_L1_2_CTRL_HCILDO |
+		      B_BE_PCIE_DIS_L1_2_CTRL_APHY_SUSB |
+		      B_BE_PCIE_DIS_RTK_PRST_N_L1_2 |
+		      B_BE_PCIE_DIS_L2_CTRL_APHY_SUSB;
+	else
+		clr = B_BE_PCIE_DIS_L1_2_CTRL_HCILDO;
+
+	rtw89_write32_clr(rtwdev, R_BE_L1_2_CTRL_HCILDO, clr);
 }
 
 static void rtw89_pci_pcie_setting_be(struct rtw89_dev *rtwdev)
@@ -303,11 +330,25 @@ static void rtw89_pci_pcie_setting_be(struct rtw89_dev *rtwdev)
 
 	rtw89_write32_set(rtwdev, R_BE_EFUSE_CTRL_2_V1, B_BE_R_SYM_AUTOLOAD_WITH_PMC_SEL);
 	rtw89_write32_set(rtwdev, R_BE_PCIE_LAT_CTRL, B_BE_SYM_AUX_CLK_SEL);
+
+	if (chip->chip_id != RTL8922D)
+		return;
+
+	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_R_SYM_PRST_CPHY_RST);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_USUS_OFFCAPC_EN);
 }
 
 static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	u32 val32;
+	int ret;
+
+	if (chip_id == RTL8922D)
+		goto be2_chips;
+	else if (chip_id != RTL8922A)
+		return;
 
 	rtw89_write32(rtwdev, R_BE_PL1_DBG_INFO, 0x0);
 	rtw89_write32_set(rtwdev, R_BE_FWS1IMR, B_BE_PCIE_SER_TIMEOUT_INDIC_EN);
@@ -318,6 +359,43 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 	val32 |= B_BE_SER_PMU_IMR | B_BE_SER_L1SUB_IMR | B_BE_SER_PM_MASTER_IMR |
 		 B_BE_SER_LTSSM_IMR | B_BE_SER_PM_CLK_MASK | B_BE_SER_PCLKREQ_ACK_MASK;
 	rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
+
+	return;
+
+be2_chips:
+	rtw89_write32_clr(rtwdev, R_BE_PCIE_SER_DBG, B_BE_PCIE_SER_FLUSH_RSTB);
+	rtw89_write32_set(rtwdev, R_BE_PCIE_SER_DBG, B_BE_PCIE_SER_FLUSH_RSTB);
+
+	rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
+				  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+	rtw89_write16_clr(rtwdev, RAC_DIRECT_OFFESET_L0_G2 +
+				  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+	rtw89_write16_set(rtwdev, RAC_DIRECT_OFFESET_L0_G1 +
+				  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+	rtw89_write16_set(rtwdev, RAC_DIRECT_OFFESET_L0_G2 +
+				  RAC_ANA41 * RAC_MULT, PHY_ERR_FLAG_EN);
+
+	val32 = rtw89_read32(rtwdev, R_BE_SER_PL1_CTRL);
+	val32 &= ~B_BE_PL1_SER_PL1_EN;
+	rtw89_write32(rtwdev, R_BE_SER_PL1_CTRL, val32);
+
+	ret = read_poll_timeout_atomic(rtw89_read32, val32, !val32,
+				       1, 1000, false, rtwdev, R_BE_REG_PL1_ISR);
+	if (ret)
+		rtw89_warn(rtwdev, "[ERR] PCIE SER clear poll fail\n");
+
+	val32 = rtw89_read32(rtwdev, R_BE_REG_PL1_MASK);
+	val32 |= B_BE_SER_PMU_IMR | B_BE_SER_L1SUB_IMR | B_BE_SER_PM_MASTER_IMR |
+		 B_BE_SER_LTSSM_IMR | B_BE_SER_PM_CLK_MASK | B_BE_SER_PCLKREQ_ACK_MASK |
+		 B_BE_SER_LTSSM_UNSTABLE_MASK;
+	rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
+
+	rtw89_write32_mask(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_TIMER_UNIT_MASK,
+			   PCIE_SER_TIMER_UNIT);
+	rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+
+	if (hal->cid == RTL8922D_CID7090)
+		rtw89_write32_set(rtwdev, R_BE_SYS_SDIO_CTRL, B_BE_SER_DETECT_EN);
 }
 
 static void rtw89_pci_ctrl_txdma_ch_be(struct rtw89_dev *rtwdev, bool enable)
@@ -412,6 +490,7 @@ static int rtw89_pci_ops_mac_pre_deinit_be(struct rtw89_dev *rtwdev)
 int rtw89_pci_ltr_set_v2(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 ctrl0, cfg0, cfg1, dec_ctrl, idle_ltcy, act_ltcy, dis_ltcy;
+	u32 ltr_idle_lat_ctrl, ltr_act_lat_ctrl;
 
 	ctrl0 = rtw89_read32(rtwdev, R_BE_LTR_CTRL_0);
 	if (rtw89_pci_ltr_is_err_reg_val(ctrl0))
@@ -454,8 +533,16 @@ int rtw89_pci_ltr_set_v2(struct rtw89_dev *rtwdev, bool en)
 	cfg0 = u32_replace_bits(cfg0, 3, B_BE_LTR_IDX_IDLE_MASK);
 	dec_ctrl = u32_replace_bits(dec_ctrl, 0, B_BE_LTR_IDX_DISABLE_V1_MASK);
 
-	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX3_V1, 0x90039003);
-	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX1_V1, 0x880b880b);
+	if (rtwdev->chip->chip_id == RTL8922A) {
+		ltr_idle_lat_ctrl = 0x90039003;
+		ltr_act_lat_ctrl = 0x880b880b;
+	} else {
+		ltr_idle_lat_ctrl = 0x90019001;
+		ltr_act_lat_ctrl = 0x88018801;
+	}
+
+	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX3_V1, ltr_idle_lat_ctrl);
+	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX1_V1, ltr_act_lat_ctrl);
 	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX0_V1, 0);
 	rtw89_write32(rtwdev, R_BE_LTR_DECISION_CTRL_V1, dec_ctrl);
 	rtw89_write32(rtwdev, R_BE_LTR_CFG_0, cfg0);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2fe44fb86ad6..0f8eea3195c9 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3831,6 +3831,7 @@
 #define B_BE_EN_WLON BIT(16)
 #define B_BE_APDM_HPDN BIT(15)
 #define B_BE_PSUS_OFF_CAPC_EN BIT(14)
+#define B_BE_USUS_OFFCAPC_EN BIT(13)
 #define B_BE_AFSM_PCIE_SUS_EN BIT(12)
 #define B_BE_AFSM_WLSUS_EN BIT(11)
 #define B_BE_APFM_SWLPS BIT(10)
@@ -3899,6 +3900,8 @@
 #define B_BE_SYM_PADPDN_WL_RFC0_1P3 BIT(5)
 
 #define R_BE_RSV_CTRL 0x001C
+#define B_BE_R_SYM_PRST_CPHY_RST BIT(25)
+#define B_BE_R_SYM_PRST_PDN_EN BIT(24)
 #define B_BE_HR_BE_DBG GENMASK(23, 12)
 #define B_BE_R_SYM_DIS_PCIE_FLR BIT(9)
 #define B_BE_R_EN_HRST_PWRON BIT(8)
@@ -4033,6 +4036,7 @@
 
 #define R_BE_SYS_SDIO_CTRL 0x0070
 #define B_BE_MCM_FLASH_EN BIT(28)
+#define B_BE_SER_DETECT_EN BIT(26)
 #define B_BE_PCIE_SEC_LOAD BIT(26)
 #define B_BE_PCIE_SER_RSTB BIT(25)
 #define B_BE_PCIE_SEC_LOAD_CLR BIT(24)
@@ -4488,6 +4492,16 @@
 #define B_BE_WL_XTAL_SI_DATA_MASK GENMASK(15, 8)
 #define B_BE_WL_XTAL_SI_ADDR_MASK GENMASK(7, 0)
 
+#define R_BE_PCIE_SER_DBG 0x02FC
+#define B_BE_PCIE_SER_DBG_MASK GENMASK(31, 10)
+#define B_BE_PCIE_SER_PHY_PROTECT BIT(9)
+#define B_BE_PCIE_SER_MAC_PROTECT BIT(8)
+#define B_BE_PCIE_SER_FLUSH_RSTB BIT(4)
+#define B_BE_PCIE_AXI_BRG_FLUSH_EN BIT(3)
+#define B_BE_PCIE_SER_AUXCLK_RDY BIT(2)
+#define B_BE_PCIE_SER_FRZ_REG_RST BIT(1)
+#define B_BE_PCIE_SER_FRZ_CFG_SPC_RST BIT(0)
+
 #define R_BE_IC_PWR_STATE 0x03F0
 #define B_BE_WHOLE_SYS_PWR_STE_MASK GENMASK(25, 16)
 #define MAC_AX_SYS_ACT 0x220
-- 
2.25.1


