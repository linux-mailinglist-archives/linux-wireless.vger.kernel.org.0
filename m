Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693A44E6DFF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352275AbiCYGDp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358388AbiCYGDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94EEC6821
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P622sK4011027, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P622sK4011027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 14:02:02 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 03/16] rtw89: pci: refine pci pre_init function
Date:   Fri, 25 Mar 2022 14:00:42 +0800
Message-ID: <20220325060055.58482-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chia-Yuan Li <leo.li@realtek.com>

The pre_init is used to initialize partial PCI function during PCI probe.
It doesn't need to initialize all functions, so probe can be faster.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 158 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h      |  16 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  31 ++++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   3 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   3 +
 5 files changed, 180 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index e064d355250ce..43bb4490380d8 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1437,12 +1437,19 @@ static void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable)
 					  B_AX_STOP_PCIEIO);
 		rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
 				  txhci_en | rxhci_en);
+		if (chip_id == RTL8852C)
+			rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
+					  B_AX_STOP_AXI_MST);
 	} else {
 		if (chip_id != RTL8852C)
 			rtw89_write32_set(rtwdev, info->dma_stop1_reg,
 					  B_AX_STOP_PCIEIO);
-		rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
-				  txhci_en | rxhci_en);
+		else
+			rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
+					  B_AX_STOP_AXI_MST);
+		if (chip_id == RTL8852C)
+			rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
+					  B_AX_STOP_AXI_MST);
 	}
 }
 
@@ -1865,13 +1872,16 @@ static void rtw89_pci_aphy_pwrcut(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_hci_ldo(struct rtw89_dev *rtwdev)
 {
-	if (rtwdev->chip->chip_id != RTL8852A)
-		return;
-
-	rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
-			  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
-			  B_AX_PCIE_DIS_WLSUS_AFT_PDN);
+	if (rtwdev->chip->chip_id == RTL8852A ||
+	    rtwdev->chip->chip_id == RTL8852B) {
+		rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
+				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
+				  B_AX_PCIE_DIS_WLSUS_AFT_PDN);
+	} else if (rtwdev->chip->chip_id == RTL8852C) {
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
+				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
+	}
 }
 
 static int rtw89_pci_dphy_delay(struct rtw89_dev *rtwdev)
@@ -1902,12 +1912,24 @@ static void rtw89_pci_autoload_hang(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_l12_vmain(struct rtw89_dev *rtwdev)
 {
-	if (rtwdev->chip->chip_id != RTL8852C && rtwdev->hal.cv == CHIP_CAV)
+	if (!(rtwdev->chip->chip_id == RTL8852C && rtwdev->hal.cv == CHIP_CAV))
 		return;
 
 	rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_FORCE_PWR_NGAT);
 }
 
+static void rtw89_pci_gen2_force_ib(struct rtw89_dev *rtwdev)
+{
+	if (!(rtwdev->chip->chip_id == RTL8852C && rtwdev->hal.cv == CHIP_CAV))
+		return;
+
+	rtw89_write32_set(rtwdev, R_AX_PMC_DBG_CTRL2,
+			  B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+	rtw89_write32_set(rtwdev, R_AX_HCI_BG_CTRL, B_AX_BG_CLR_ASYNC_M3);
+	rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2,
+			  B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+}
+
 static void rtw89_pci_set_sic(struct rtw89_dev *rtwdev)
 {
 	if (rtwdev->chip->chip_id == RTL8852C)
@@ -1917,6 +1939,25 @@ static void rtw89_pci_set_sic(struct rtw89_dev *rtwdev)
 			  B_AX_SIC_EN_FORCE_CLKREQ);
 }
 
+static void rtw89_pci_set_lbc(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 lbc;
+
+	if (rtwdev->chip->chip_id == RTL8852C)
+		return;
+
+	lbc = rtw89_read32(rtwdev, R_AX_LBC_WATCHDOG);
+	if (info->lbc_en == MAC_AX_PCIE_ENABLE) {
+		lbc = u32_replace_bits(lbc, info->lbc_tmr, B_AX_LBC_TIMER);
+		lbc |= B_AX_LBC_FLAG | B_AX_LBC_EN;
+		rtw89_write32(rtwdev, R_AX_LBC_WATCHDOG, lbc);
+	} else {
+		lbc &= ~B_AX_LBC_EN;
+	}
+	rtw89_write32_set(rtwdev, R_AX_LBC_WATCHDOG, lbc);
+}
+
 static void rtw89_pci_set_io_rcy(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -1957,6 +1998,15 @@ static void rtw89_pci_set_dbg(struct rtw89_dev *rtwdev)
 				  B_AX_EN_CHKDSC_NO_RX_STUCK);
 }
 
+static void rtw89_pci_set_keep_reg(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->chip->chip_id == RTL8852C)
+		return;
+
+	rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
+			  B_AX_PCIE_TXRST_KEEP_REG | B_AX_PCIE_RXRST_KEEP_REG);
+}
+
 static void rtw89_pci_clr_idx_all(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -1979,6 +2029,68 @@ static void rtw89_pci_clr_idx_all(struct rtw89_dev *rtwdev)
 			  B_AX_CLR_RXQ_IDX | B_AX_CLR_RPQ_IDX);
 }
 
+static int rtw89_poll_txdma_ch_idle_pcie(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 ret, check, dma_busy;
+	u32 dma_busy1 = info->dma_busy1_reg;
+	u32 dma_busy2 = info->dma_busy2_reg;
+
+	check = B_AX_ACH0_BUSY | B_AX_ACH1_BUSY | B_AX_ACH2_BUSY |
+		B_AX_ACH3_BUSY | B_AX_ACH4_BUSY | B_AX_ACH5_BUSY |
+		B_AX_ACH6_BUSY | B_AX_ACH7_BUSY | B_AX_CH8_BUSY |
+		B_AX_CH9_BUSY | B_AX_CH12_BUSY;
+
+	ret = read_poll_timeout(rtw89_read32, dma_busy, (dma_busy & check) == 0,
+				10, 100, false, rtwdev, dma_busy1);
+	if (ret)
+		return ret;
+
+	check = B_AX_CH10_BUSY | B_AX_CH11_BUSY;
+
+	ret = read_poll_timeout(rtw89_read32, dma_busy, (dma_busy & check) == 0,
+				10, 100, false, rtwdev, dma_busy2);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rtw89_poll_rxdma_ch_idle_pcie(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 ret, check, dma_busy;
+	u32 dma_busy3 = info->dma_busy3_reg;
+
+	check = B_AX_RXQ_BUSY | B_AX_RPQ_BUSY;
+
+	ret = read_poll_timeout(rtw89_read32, dma_busy, (dma_busy & check) == 0,
+				10, 100, false, rtwdev, dma_busy3);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rtw89_pci_poll_dma_all_idle(struct rtw89_dev *rtwdev)
+{
+	u32 ret;
+
+	ret = rtw89_poll_txdma_ch_idle_pcie(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "txdma ch busy\n");
+		return ret;
+	}
+
+	ret = rtw89_poll_rxdma_ch_idle_pcie(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "rxdma ch busy\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtw89_pci_mode_op(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
@@ -2083,9 +2195,6 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
-	u32 dma_busy;
-	u32 check;
-	u32 lbc;
 	int ret;
 
 	rtw89_pci_rxdma_prefth(rtwdev);
@@ -2110,34 +2219,21 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	rtw89_pci_power_wake(rtwdev, true);
 	rtw89_pci_autoload_hang(rtwdev);
 	rtw89_pci_l12_vmain(rtwdev);
+	rtw89_pci_gen2_force_ib(rtwdev);
 	rtw89_pci_set_sic(rtwdev);
+	rtw89_pci_set_lbc(rtwdev);
 	rtw89_pci_set_io_rcy(rtwdev);
 	rtw89_pci_set_dbg(rtwdev);
-
-	if (rtwdev->chip->chip_id == RTL8852A) {
-		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
-				  B_AX_PCIE_AUXCLK_GATE);
-
-		lbc = rtw89_read32(rtwdev, R_AX_LBC_WATCHDOG);
-		lbc = u32_replace_bits(lbc, RTW89_MAC_LBC_TMR_128US, B_AX_LBC_TIMER);
-		lbc |= B_AX_LBC_FLAG | B_AX_LBC_EN;
-		rtw89_write32(rtwdev, R_AX_LBC_WATCHDOG, lbc);
-
-		rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
-				  B_AX_PCIE_TXRST_KEEP_REG | B_AX_PCIE_RXRST_KEEP_REG);
-	}
+	rtw89_pci_set_keep_reg(rtwdev);
 
 	rtw89_write32_set(rtwdev, info->dma_stop1_reg, B_AX_STOP_WPDMA);
 
 	/* stop DMA activities */
 	rtw89_pci_ctrl_dma_all(rtwdev, false);
 
-	/* check PCI at idle state */
-	check = B_AX_PCIEIO_BUSY | B_AX_PCIEIO_TX_BUSY | B_AX_PCIEIO_RX_BUSY;
-	ret = read_poll_timeout(rtw89_read32, dma_busy, (dma_busy & check) == 0,
-				100, 3000, false, rtwdev, R_AX_PCIE_DMA_BUSY1);
+	ret = rtw89_pci_poll_dma_all_idle(rtwdev);
 	if (ret) {
-		rtw89_err(rtwdev, "failed to poll io busy\n");
+		rtw89_err(rtwdev, "[ERR] poll pcie dma all idle\n");
 		return ret;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 8d49033fa270e..2e8695208fccb 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -366,6 +366,19 @@
 #define B_AX_PCIEIO_TX_BUSY		BIT(21)
 #define B_AX_PCIEIO_BUSY		BIT(20)
 #define B_AX_WPDMA_BUSY			BIT(19)
+#define B_AX_CH12_BUSY			BIT(18)
+#define B_AX_CH9_BUSY			BIT(17)
+#define B_AX_CH8_BUSY			BIT(16)
+#define B_AX_ACH7_BUSY			BIT(15)
+#define B_AX_ACH6_BUSY			BIT(14)
+#define B_AX_ACH5_BUSY			BIT(13)
+#define B_AX_ACH4_BUSY			BIT(12)
+#define B_AX_ACH3_BUSY			BIT(11)
+#define B_AX_ACH2_BUSY			BIT(10)
+#define B_AX_ACH1_BUSY			BIT(9)
+#define B_AX_ACH0_BUSY			BIT(8)
+#define B_AX_RPQ_BUSY			BIT(1)
+#define B_AX_RXQ_BUSY			BIT(0)
 
 #define R_AX_PCIE_DMA_BUSY2	0x131C
 #define B_AX_CH11_BUSY			BIT(1)
@@ -628,6 +641,9 @@ struct rtw89_pci_info {
 	u32 txbd_rwptr_clr2_reg;
 	u32 dma_stop1_reg;
 	u32 dma_stop2_reg;
+	u32 dma_busy1_reg;
+	u32 dma_busy2_reg;
+	u32 dma_busy3_reg;
 
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index f67584efeea9a..6cda6dcb5d867 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -111,6 +111,14 @@
 #define R_AX_HCI_OPT_CTRL 0x0074
 #define BIT_WAKE_CTRL BIT(5)
 
+#define R_AX_HCI_BG_CTRL 0x0078
+#define B_AX_IBX_EN_VALUE BIT(15)
+#define B_AX_IB_EN_VALUE BIT(14)
+#define B_AX_FORCED_IB_EN BIT(4)
+#define B_AX_EN_REGBG BIT(3)
+#define B_AX_R_AX_BG_LPF BIT(2)
+#define B_AX_R_AX_BG GENMASK(1, 0)
+
 #define R_AX_PLATFORM_ENABLE 0x0088
 #define B_AX_WCPU_EN BIT(1)
 #define B_AX_PLATFORM_EN BIT(0)
@@ -256,6 +264,21 @@
 #define B_AX_STOP_ACH1 BIT(9)
 #define B_AX_STOP_ACH0 BIT(8)
 
+#define R_AX_HAXI_DMA_BUSY1 0x101C
+#define B_AX_HAXIIO_BUSY BIT(20)
+#define B_AX_WPDMA_BUSY BIT(19)
+#define B_AX_CH12_BUSY BIT(18)
+#define B_AX_CH9_BUSY BIT(17)
+#define B_AX_CH8_BUSY BIT(16)
+#define B_AX_ACH7_BUSY BIT(15)
+#define B_AX_ACH6_BUSY BIT(14)
+#define B_AX_ACH5_BUSY BIT(13)
+#define B_AX_ACH4_BUSY BIT(12)
+#define B_AX_ACH3_BUSY BIT(11)
+#define B_AX_ACH2_BUSY BIT(10)
+#define B_AX_ACH1_BUSY BIT(9)
+#define B_AX_ACH0_BUSY BIT(8)
+
 #define R_AX_PCIE_DBG_CTRL 0x11C0
 #define B_AX_DBG_DUMMY_MASK GENMASK(23, 16)
 #define B_AX_DBG_SEL_MASK GENMASK(15, 13)
@@ -268,6 +291,14 @@
 #define B_AX_STOP_CH11 BIT(1)
 #define B_AX_STOP_CH10 BIT(0)
 
+#define R_AX_HAXI_DMA_BUSY2 0x11C8
+#define B_AX_CH11_BUSY BIT(1)
+#define B_AX_CH10_BUSY BIT(0)
+
+#define R_AX_HAXI_DMA_BUSY3 0x1208
+#define B_AX_RPQ_BUSY BIT(1)
+#define B_AX_RXQ_BUSY BIT(0)
+
 #define R_AX_HCI_FC_CTRL_V1 0x1700
 #define R_AX_CH_PAGE_CTRL_V1 0x1704
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 42dfafb3d7f58..6055e8b9887f5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -34,6 +34,9 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2,
 	.dma_stop1_reg		= R_AX_PCIE_DMA_STOP1,
 	.dma_stop2_reg		= R_AX_PCIE_DMA_STOP2,
+	.dma_busy1_reg		= R_AX_PCIE_DMA_BUSY1,
+	.dma_busy2_reg		= R_AX_PCIE_DMA_BUSY2,
+	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
 
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 621918465c47f..dca023e791016 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -35,6 +35,9 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2_V1,
 	.dma_stop1_reg		= R_AX_HAXI_DMA_STOP1,
 	.dma_stop2_reg		= R_AX_HAXI_DMA_STOP2,
+	.dma_busy1_reg		= R_AX_HAXI_DMA_BUSY1,
+	.dma_busy2_reg		= R_AX_HAXI_DMA_BUSY2,
+	.dma_busy3_reg		= R_AX_HAXI_DMA_BUSY3,
 
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
 
-- 
2.25.1

