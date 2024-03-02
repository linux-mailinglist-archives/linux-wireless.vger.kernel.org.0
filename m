Return-Path: <linux-wireless+bounces-4318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666986EDAD
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 02:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27D81F23D2B
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A38C15;
	Sat,  2 Mar 2024 00:59:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A68C11
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341197; cv=none; b=HB2zptZvtGN+JY9eCBpYJlb7+fixv68VUPwOVKcTGlxCaOkwuW0G7hF47AGWQHPA6yy3qIFkRAH0X3AJrClade7ejWsNNjHMyBykO0l55haA6wZak2sg5FxhnzDviRfC/OS88TTgucD0cJ6QddVRjLj3z0KrSUzXp6QjHPQChfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341197; c=relaxed/simple;
	bh=1aQ1NArrZkrgoNsRXU2rb9lKHBSSNDfU7/vX17S4nNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urO0sj+eOO1fCVe8qAGgALeVudK34E5S1/G9OC+ip9Q+CwseT/zFhmdUBzzgWV0a7msRDKx1b1/9Obg59oRWYh3iN3HU/sOXddP/65rbO1xzMpYWrEm5cUwJAHKBetX98rc1dlpDlgZW4gkUjQ2vZoq2JPHs+lOAKVgji9PCZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xnJnB2370294, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xnJnB2370294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 2 Mar 2024 08:59:50 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw89: update suspend/resume for different generation
Date: Sat, 2 Mar 2024 08:58:26 +0800
Message-ID: <20240302005828.13666-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240302005828.13666-1-pkshih@realtek.com>
References: <20240302005828.13666-1-pkshih@realtek.com>
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

The setting during suspend or resume is different between different
generation, so update it.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h      |  3 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c   | 40 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 13 ++++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  2 +-
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 4a817dd9822e..a63b6b7c9bfa 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -942,6 +942,8 @@
 #define B_BE_SER_L1SUB_IMR BIT(1)
 #define B_BE_SER_PMU_IMR BIT(0)
 
+#define R_BE_REG_PL1_ISR 0x34B4
+
 #define R_BE_RX_APPEND_MODE 0x8920
 #define B_BE_APPEND_OFFSET_MASK GENMASK(23, 16)
 #define B_BE_APPEND_LEN_MASK GENMASK(15, 0)
@@ -1558,6 +1560,7 @@ static inline bool rtw89_pci_ltr_is_err_reg_val(u32 val)
 }
 
 extern const struct dev_pm_ops rtw89_pm_ops;
+extern const struct dev_pm_ops rtw89_pm_ops_be;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be;
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 1a3f02c687f7..7cc328222965 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -550,6 +550,46 @@ static int rtw89_pci_lv1rst_start_dma_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int __maybe_unused rtw89_pci_suspend_be(struct device *dev)
+{
+	struct ieee80211_hw *hw = dev_get_drvdata(dev);
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
+	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_R_DIS_PRST);
+	rtw89_write32_clr(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
+	rtw89_write32_set(rtwdev, R_BE_PCIE_FRZ_CLK, B_BE_PCIE_FRZ_REG_RST);
+	rtw89_write32_clr(rtwdev, R_BE_REG_PL1_MASK, B_BE_SER_PM_MASTER_IMR);
+	return 0;
+}
+
+static int __maybe_unused rtw89_pci_resume_be(struct device *dev)
+{
+	struct ieee80211_hw *hw = dev_get_drvdata(dev);
+	struct rtw89_dev *rtwdev = hw->priv;
+	u32 polling;
+	int ret;
+
+	rtw89_write32_set(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
+	rtw89_write32_clr(rtwdev, R_BE_RSV_CTRL, B_BE_R_DIS_PRST);
+	rtw89_write32_clr(rtwdev, R_BE_RSV_CTRL, B_BE_WLOCK_1C_BIT6);
+	rtw89_write32_clr(rtwdev, R_BE_PCIE_FRZ_CLK, B_BE_PCIE_FRZ_REG_RST);
+	rtw89_write32_clr(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+
+	ret = read_poll_timeout_atomic(rtw89_read32, polling, !polling, 1, 1000,
+				       false, rtwdev, R_BE_REG_PL1_ISR);
+	if (ret)
+		rtw89_warn(rtwdev, "[ERR] PCIE SER clear polling fail\n");
+
+	rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+	rtw89_write32_set(rtwdev, R_BE_REG_PL1_MASK, B_BE_SER_PM_MASTER_IMR);
+
+	return 0;
+}
+
+SIMPLE_DEV_PM_OPS(rtw89_pm_ops_be, rtw89_pci_suspend_be, rtw89_pci_resume_be);
+EXPORT_SYMBOL(rtw89_pm_ops_be);
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.isr_rdu = B_BE_RDU_CH1_INT | B_BE_RDU_CH0_INT,
 	.isr_halt_c2h = B_BE_HALT_C2H_INT,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 1dca93d0401d..d9a580ebad37 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3759,6 +3759,19 @@
 #define B_BE_SYM_PADPDN_WL_RFC1_1P3 BIT(6)
 #define B_BE_SYM_PADPDN_WL_RFC0_1P3 BIT(5)
 
+#define R_BE_RSV_CTRL 0x001C
+#define B_BE_HR_BE_DBG GENMASK(23, 12)
+#define B_BE_R_SYM_DIS_PCIE_FLR BIT(9)
+#define B_BE_R_EN_HRST_PWRON BIT(8)
+#define B_BE_LOCK_ALL_EN BIT(7)
+#define B_BE_R_DIS_PRST BIT(6)
+#define B_BE_WLOCK_1C_BIT6 BIT(5)
+#define B_BE_WLOCK_40 BIT(4)
+#define B_BE_WLOCK_08 BIT(3)
+#define B_BE_WLOCK_04 BIT(2)
+#define B_BE_WLOCK_00 BIT(1)
+#define B_BE_WLOCK_ALL BIT(0)
+
 #define R_BE_AFE_LDO_CTRL 0x0020
 #define B_BE_FORCE_MACBBBT_PWR_ON BIT(31)
 #define B_BE_R_SYM_WLPOFF_P4_PC_EN BIT(28)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 9f46fb166105..4981b657bd7b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -80,7 +80,7 @@ static struct pci_driver rtw89_8922ae_driver = {
 	.id_table	= rtw89_8922ae_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
-	.driver.pm	= &rtw89_pm_ops,
+	.driver.pm	= &rtw89_pm_ops_be,
 };
 module_pci_driver(rtw89_8922ae_driver);
 
-- 
2.25.1


