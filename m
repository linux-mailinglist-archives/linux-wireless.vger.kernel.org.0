Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14FF7E7681
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbjKJBYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjKJBY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224C444B9
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1ODYI01890528, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1ODYI01890528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Nov 2023 09:24:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: pci: add pre_deinit to be called after probe complete
Date:   Fri, 10 Nov 2023 09:23:15 +0800
Message-ID: <20231110012319.12727-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110012319.12727-1-pkshih@realtek.com>
References: <20231110012319.12727-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At probe stage, we only do partial initialization to enable ability to
download firmware and read capabilities. After that, we use this pre_deinit
to disable HCI to save power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c   |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h   |  6 ++++++
 drivers/net/wireless/realtek/rtw89/pci.c    |  2 ++
 drivers/net/wireless/realtek/rtw89/pci.h    | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  9 +++++++++
 6 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c689fc2b2d49..b18f54b16f9a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4236,6 +4236,8 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 
 	rtw89_core_setup_phycap(rtwdev);
 
+	rtw89_hci_mac_pre_deinit(rtwdev);
+
 	rtw89_mac_pwr_off(rtwdev);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index da8181539d1a..07b529a76396 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3064,6 +3064,7 @@ struct rtw89_hci_ops {
 	void (*write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
 
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
+	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
 	int (*deinit)(struct rtw89_dev *rtwdev);
 
@@ -4803,6 +4804,11 @@ static inline void rtw89_hci_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 	return rtwdev->hci.ops->tx_kick_off(rtwdev, txch);
 }
 
+static inline int rtw89_hci_mac_pre_deinit(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->hci.ops->mac_pre_deinit(rtwdev);
+}
+
 static inline void rtw89_hci_flush_queues(struct rtw89_dev *rtwdev, u32 queues,
 					  bool drop)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 822b914cf935..013588a572c5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3837,6 +3837,7 @@ EXPORT_SYMBOL(rtw89_pm_ops);
 
 const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
+	.mac_pre_deinit = NULL,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
@@ -3866,6 +3867,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.write32	= rtw89_pci_ops_write32,
 
 	.mac_pre_init	= rtw89_pci_ops_mac_pre_init,
+	.mac_pre_deinit	= rtw89_pci_ops_mac_pre_deinit,
 	.mac_post_init	= rtw89_pci_ops_mac_post_init,
 	.deinit		= rtw89_pci_ops_deinit,
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 30ab9d41e0ee..426f9d28650b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1038,6 +1038,7 @@ struct rtw89_pci_bd_ram {
 
 struct rtw89_pci_gen_def {
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
+	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
 
 	void (*clr_idx_all)(struct rtw89_dev *rtwdev);
@@ -1464,6 +1465,17 @@ static inline int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	return gen_def->mac_pre_init(rtwdev);
 }
 
+static inline int rtw89_pci_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	if (!gen_def->mac_pre_deinit)
+		return 0;
+
+	return gen_def->mac_pre_deinit(rtwdev);
+}
+
 static inline int rtw89_pci_ops_mac_post_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 01d72cde48a3..4f76395e243a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -329,6 +329,23 @@ static int rtw89_pci_ops_mac_pre_init_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_ops_mac_pre_deinit_be(struct rtw89_dev *rtwdev)
+{
+	u32 val;
+
+	_patch_pcie_power_wake_be(rtwdev, false);
+
+	val = rtw89_read32_mask(rtwdev, R_BE_IC_PWR_STATE, B_BE_WLMAC_PWR_STE_MASK);
+	if (val == 0)
+		return 0;
+
+	rtw89_pci_ctrl_trxdma_pcie_be(rtwdev, MAC_AX_PCIE_DISABLE,
+				      MAC_AX_PCIE_DISABLE, MAC_AX_PCIE_DISABLE);
+	rtw89_pci_clr_idx_all_be(rtwdev);
+
+	return 0;
+}
+
 int rtw89_pci_ltr_set_v2(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 ctrl0, cfg0, cfg1, dec_ctrl, idle_ltcy, act_ltcy, dis_ltcy;
@@ -474,6 +491,7 @@ static int rtw89_pci_lv1rst_start_dma_be(struct rtw89_dev *rtwdev)
 
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
+	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_be,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_be,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 68a5d8ff6a70..470302e6de11 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3871,6 +3871,15 @@
 #define R_BE_UDM2 0x01F8
 #define B_BE_UDM2_EPC_RA_MASK GENMASK(31, 0)
 
+#define R_BE_IC_PWR_STATE 0x03F0
+#define B_BE_WHOLE_SYS_PWR_STE_MASK GENMASK(25, 16)
+#define MAC_AX_SYS_ACT 0x220
+#define B_BE_WLMAC_PWR_STE_MASK GENMASK(9, 8)
+#define B_BE_UART_HCISYS_PWR_STE_MASK GENMASK(7, 6)
+#define B_BE_SDIO_HCISYS_PWR_STE_MASK GENMASK(5, 4)
+#define B_BE_USB_HCISYS_PWR_STE_MASK GENMASK(3, 2)
+#define B_BE_PCIE_HCISYS_PWR_STE_MASK GENMASK(1, 0)
+
 #define R_BE_DCPU_PLATFORM_ENABLE 0x0888
 #define B_BE_DCPU_SYM_DPLT_MEM_MUX_EN BIT(10)
 #define B_BE_DCPU_WARM_EN BIT(9)
-- 
2.25.1

