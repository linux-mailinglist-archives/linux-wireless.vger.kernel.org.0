Return-Path: <linux-wireless+bounces-3899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B39B85F194
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 07:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA561B23B83
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABD17995;
	Thu, 22 Feb 2024 06:44:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532A12E40
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584244; cv=none; b=FObuVUDN/hxtEmoSSqX3YpGOpxMntlQ9uXZseYWmv14QK9dn/r13mHdPFc6WeYneJR+RVRqQwM4bRYKJ7jPiDvMSPGXFxGDAtvFOuOIHWyTlmuhGbCtuaGVZ7zvcwELq6vT1SBwMsFiU93tC+iFvBoFVR8FCpNzuhJHGyaUagEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584244; c=relaxed/simple;
	bh=LsD778on7rh9+Qtr/y/cV/CSq/20+IlfzzKHRuRh6QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMmKGLmGoVjjjwJmWeNX7Z+XQDVZBef+8im74DRkoKdgcive0LlDzoXigmrPDoF0aZA1lm0FqYTyIQxoNvHXhw4DtAOkR9KAjQHocOr9fU4MaJusa/raG22GZWbvvlP0XTQxZNOaEt5uwl4vlFUdZEEvvmEkSX/LaaHuSVZQSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41M6huJiB1486355, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41M6huJiB1486355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:43:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 22 Feb 2024 14:43:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 14:43:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: pci: implement PCI CLK/ASPM/L1SS for WiFi 7 chips
Date: Thu, 22 Feb 2024 14:42:58 +0800
Message-ID: <20240222064258.59782-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222064258.59782-1-pkshih@realtek.com>
References: <20240222064258.59782-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

PCI CLK/ASPM/L1SS is power management mechanism used to reduce power
consumption of PCI chip. The registers for setting of these features
in WiFi 7 Chip are different from WiFi 6 chip, so separate them
in generation information.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 50 ++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h    | 30 ++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 52 +++++++++++++++++++++
 3 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 67d7294e488a..d4c8799d6f2e 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3652,12 +3652,20 @@ static int rtw89_pci_filter_out(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_clkreq_set(struct rtw89_dev *rtwdev, bool enable)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
-	int ret;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
 
 	if (rtw89_pci_disable_clkreq)
 		return;
 
+	gen_def->clkreq_set(rtwdev, enable);
+}
+
+static void rtw89_pci_clkreq_set_ax(struct rtw89_dev *rtwdev, bool enable)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	int ret;
+
 	ret = rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_CLK_CTRL,
 					  PCIE_CLKDLY_HW_30US);
 	if (ret)
@@ -3689,24 +3697,31 @@ static void rtw89_pci_clkreq_set(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
-	u8 value = 0;
-	int ret;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
 
 	if (rtw89_pci_disable_aspm_l1)
 		return;
 
+	gen_def->aspm_set(rtwdev, enable);
+}
+
+static void rtw89_pci_aspm_set_ax(struct rtw89_dev *rtwdev, bool enable)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u8 value = 0;
+	int ret;
+
 	ret = rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_ASPM_CTRL, &value);
 	if (ret)
-		rtw89_err(rtwdev, "failed to read ASPM Delay\n");
+		rtw89_warn(rtwdev, "failed to read ASPM Delay\n");
 
-	value &= ~(RTW89_L1DLY_MASK | RTW89_L0DLY_MASK);
-	value |= FIELD_PREP(RTW89_L1DLY_MASK, PCIE_L1DLY_16US) |
-		 FIELD_PREP(RTW89_L0DLY_MASK, PCIE_L0SDLY_4US);
+	u8p_replace_bits(&value, PCIE_L1DLY_16US, RTW89_L1DLY_MASK);
+	u8p_replace_bits(&value, PCIE_L0SDLY_4US, RTW89_L0DLY_MASK);
 
 	ret = rtw89_pci_write_config_byte(rtwdev, RTW89_PCIE_ASPM_CTRL, value);
 	if (ret)
-		rtw89_err(rtwdev, "failed to read ASPM Delay\n");
+		rtw89_warn(rtwdev, "failed to read ASPM Delay\n");
 
 	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
 		if (enable)
@@ -3792,6 +3807,17 @@ static void rtw89_pci_link_cfg(struct rtw89_dev *rtwdev)
 }
 
 static void rtw89_pci_l1ss_set(struct rtw89_dev *rtwdev, bool enable)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	if (rtw89_pci_disable_l1ss)
+		return;
+
+	gen_def->l1ss_set(rtwdev, enable);
+}
+
+static void rtw89_pci_l1ss_set_ax(struct rtw89_dev *rtwdev, bool enable)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
@@ -4066,6 +4092,10 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 
 	.lv1rst_stop_dma = rtw89_pci_lv1rst_stop_dma_ax,
 	.lv1rst_start_dma = rtw89_pci_lv1rst_start_dma_ax,
+
+	.aspm_set = rtw89_pci_aspm_set_ax,
+	.clkreq_set = rtw89_pci_clkreq_set_ax,
+	.l1ss_set = rtw89_pci_l1ss_set_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 532f78eaf6df..c1954cb12030 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -282,6 +282,21 @@
 #define B_BE_PCIE_EN_SWENT_L23 BIT(1)
 #define B_BE_SEL_REQ_EXIT_L1 BIT(0)
 
+#define R_BE_PCIE_MIX_CFG 0x300C
+#define B_BE_L1SS_TIMEOUT_CTRL BIT(18)
+#define B_BE_ASPM_CTRL_L1 BIT(17)
+#define B_BE_ASPM_CTRL_L0 BIT(16)
+#define B_BE_XFER_PENDING_FW BIT(11)
+#define B_BE_XFER_PENDING BIT(10)
+#define B_BE_REQ_EXIT_L1 BIT(9)
+#define B_BE_REQ_ENTR_L1 BIT(8)
+#define B_BE_L1SUB_ENABLE BIT(0)
+
+#define R_BE_L1_CLK_CTRL 0x3010
+#define B_BE_RAS_SD_HOLD_LTSSM BIT(12)
+#define B_BE_CLK_REQ_N BIT(1)
+#define B_BE_CLK_PM_EN BIT(0)
+
 #define R_BE_PCIE_LAT_CTRL 0x3044
 #define B_BE_ELBI_PHY_REMAP_MASK GENMASK(29, 24)
 #define B_BE_SYS_SUS_L12_EN BIT(17)
@@ -290,6 +305,8 @@
 #define B_BE_RTK_LDO_POWER_LATENCY_MASK GENMASK(11, 10)
 #define B_BE_RTK_LDO_BIAS_LATENCY_MASK GENMASK(9, 8)
 #define B_BE_CLK_REQ_LAT_MASK GENMASK(7, 4)
+#define B_BE_RTK_PM_SEL_OPT BIT(1)
+#define B_BE_CLK_REQ_SEL BIT(0)
 
 #define R_BE_PCIE_HIMR0 0x30B0
 #define B_BE_PCIE_HB1_IND_INTA_IMR BIT(31)
@@ -1066,6 +1083,15 @@ enum rtw89_pcie_clkdly_hw {
 	PCIE_CLKDLY_HW_200US = 0x5,
 };
 
+enum rtw89_pcie_clkdly_hw_v1 {
+	PCIE_CLKDLY_HW_V1_0 = 0,
+	PCIE_CLKDLY_HW_V1_16US = 0x1,
+	PCIE_CLKDLY_HW_V1_32US = 0x2,
+	PCIE_CLKDLY_HW_V1_64US = 0x3,
+	PCIE_CLKDLY_HW_V1_80US = 0x4,
+	PCIE_CLKDLY_HW_V1_96US = 0x5,
+};
+
 enum mac_ax_bd_trunc_mode {
 	MAC_AX_BD_NORM,
 	MAC_AX_BD_TRUNC,
@@ -1216,6 +1242,10 @@ struct rtw89_pci_gen_def {
 
 	int (*lv1rst_stop_dma)(struct rtw89_dev *rtwdev);
 	int (*lv1rst_start_dma)(struct rtw89_dev *rtwdev);
+
+	void (*aspm_set)(struct rtw89_dev *rtwdev, bool enable);
+	void (*clkreq_set)(struct rtw89_dev *rtwdev, bool enable);
+	void (*l1ss_set)(struct rtw89_dev *rtwdev, bool enable);
 };
 
 struct rtw89_pci_info {
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 5c9e39357773..0276d5d05925 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -19,6 +19,54 @@ enum pcie_rxbd_mode {
 #define PL0_TMR_MAC_1MS 0x27100
 #define PL0_TMR_AUX_1MS 0x1E848
 
+static void rtw89_pci_aspm_set_be(struct rtw89_dev *rtwdev, bool enable)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+	u8 value = 0;
+	int ret;
+
+	ret = pci_read_config_byte(pdev, RTW89_PCIE_ASPM_CTRL, &value);
+	if (ret)
+		rtw89_warn(rtwdev, "failed to read ASPM Delay\n");
+
+	u8p_replace_bits(&value, PCIE_L1DLY_16US, RTW89_L1DLY_MASK);
+
+	ret = pci_write_config_byte(pdev, RTW89_PCIE_ASPM_CTRL, value);
+	if (ret)
+		rtw89_warn(rtwdev, "failed to write ASPM Delay\n");
+
+	if (enable)
+		rtw89_write32_set(rtwdev, R_AX_PCIE_MIX_CFG_V1,
+				  B_BE_ASPM_CTRL_L1);
+	else
+		rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1,
+				  B_BE_ASPM_CTRL_L1);
+}
+
+static void rtw89_pci_l1ss_set_be(struct rtw89_dev *rtwdev, bool enable)
+{
+	if (enable)
+		rtw89_write32_set(rtwdev, R_BE_PCIE_MIX_CFG,
+				  B_BE_L1SUB_ENABLE);
+	else
+		rtw89_write32_clr(rtwdev, R_BE_PCIE_MIX_CFG,
+				  B_BE_L1SUB_ENABLE);
+}
+
+static void rtw89_pci_clkreq_set_be(struct rtw89_dev *rtwdev, bool enable)
+{
+	rtw89_write32_mask(rtwdev, R_BE_PCIE_LAT_CTRL, B_BE_CLK_REQ_LAT_MASK,
+			   PCIE_CLKDLY_HW_V1_0);
+
+	if (enable)
+		rtw89_write32_set(rtwdev, R_BE_L1_CLK_CTRL,
+				  B_BE_CLK_PM_EN);
+	else
+		rtw89_write32_clr(rtwdev, R_AX_L1_CLK_CTRL,
+				  B_BE_CLK_PM_EN);
+}
+
 static void _patch_pcie_power_wake_be(struct rtw89_dev *rtwdev, bool power_up)
 {
 	if (power_up)
@@ -510,5 +558,9 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 
 	.lv1rst_stop_dma = rtw89_pci_lv1rst_stop_dma_be,
 	.lv1rst_start_dma = rtw89_pci_lv1rst_start_dma_be,
+
+	.aspm_set = rtw89_pci_aspm_set_be,
+	.clkreq_set = rtw89_pci_clkreq_set_be,
+	.l1ss_set = rtw89_pci_l1ss_set_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
-- 
2.25.1


