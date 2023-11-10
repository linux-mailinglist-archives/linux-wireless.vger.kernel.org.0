Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5B57E767D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjKJBY2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345535AbjKJBY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:26 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5544A4
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:24 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1OFSp81890534, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1OFSp81890534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Nov 2023 09:24:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw89: 8922ae: add v2 interrupt handlers for 8922AE
Date:   Fri, 10 Nov 2023 09:23:17 +0800
Message-ID: <20231110012319.12727-6-pkshih@realtek.com>
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

The handlers include three parts -- 1) configure interrupt mask;
2) enable/disable interrupt; 3) recognize (read) interrupt status.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      |  86 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      | 102 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  27 +++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |   4 +
 4 files changed, 219 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 71c73adfcf59..9c6d55af8c8e 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -696,6 +696,27 @@ void rtw89_pci_recognize_intrs_v1(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_pci_recognize_intrs_v1);
 
+void rtw89_pci_recognize_intrs_v2(struct rtw89_dev *rtwdev,
+				  struct rtw89_pci *rtwpci,
+				  struct rtw89_pci_isrs *isrs)
+{
+	isrs->ind_isrs = rtw89_read32(rtwdev, R_BE_PCIE_HISR) & rtwpci->ind_intrs;
+	isrs->halt_c2h_isrs = isrs->ind_isrs & B_BE_HS0ISR_IND_INT ?
+			      rtw89_read32(rtwdev, R_BE_HISR0) & rtwpci->halt_c2h_intrs : 0;
+	isrs->isrs[0] = isrs->ind_isrs & B_BE_HCI_AXIDMA_INT ?
+			rtw89_read32(rtwdev, R_BE_HAXI_HISR00) & rtwpci->intrs[0] : 0;
+	isrs->isrs[1] = rtw89_read32(rtwdev, R_BE_PCIE_DMA_ISR);
+
+	if (isrs->halt_c2h_isrs)
+		rtw89_write32(rtwdev, R_BE_HISR0, isrs->halt_c2h_isrs);
+	if (isrs->isrs[0])
+		rtw89_write32(rtwdev, R_BE_HAXI_HISR00, isrs->isrs[0]);
+	if (isrs->isrs[1])
+		rtw89_write32(rtwdev, R_BE_PCIE_DMA_ISR, isrs->isrs[1]);
+	rtw89_write32(rtwdev, R_BE_PCIE_HISR, isrs->ind_isrs);
+}
+EXPORT_SYMBOL(rtw89_pci_recognize_intrs_v2);
+
 void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
 {
 	rtw89_write32(rtwdev, R_AX_HIMR0, rtwpci->halt_c2h_intrs);
@@ -727,6 +748,22 @@ void rtw89_pci_disable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpc
 }
 EXPORT_SYMBOL(rtw89_pci_disable_intr_v1);
 
+void rtw89_pci_enable_intr_v2(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	rtw89_write32(rtwdev, R_BE_HIMR0, rtwpci->halt_c2h_intrs);
+	rtw89_write32(rtwdev, R_BE_HAXI_HIMR00, rtwpci->intrs[0]);
+	rtw89_write32(rtwdev, R_BE_PCIE_DMA_IMR_0_V1, rtwpci->intrs[1]);
+	rtw89_write32(rtwdev, R_BE_PCIE_HIMR0, rtwpci->ind_intrs);
+}
+EXPORT_SYMBOL(rtw89_pci_enable_intr_v2);
+
+void rtw89_pci_disable_intr_v2(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	rtw89_write32(rtwdev, R_BE_PCIE_HIMR0, 0);
+	rtw89_write32(rtwdev, R_BE_PCIE_DMA_IMR_0_V1, 0);
+}
+EXPORT_SYMBOL(rtw89_pci_disable_intr_v2);
+
 static void rtw89_pci_ops_recovery_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
@@ -3343,6 +3380,55 @@ void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_pci_config_intr_mask_v1);
 
+static void rtw89_pci_recovery_intr_mask_v2(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0;
+	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
+	rtwpci->intrs[0] = 0;
+	rtwpci->intrs[1] = B_BE_PCIE_RX_RX0P2_IMR0_V1 |
+			   B_BE_PCIE_RX_RPQ0_IMR0_V1;
+}
+
+static void rtw89_pci_default_intr_mask_v2(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_BE_HCI_AXIDMA_INT_EN0 |
+			    B_BE_HS0_IND_INT_EN0;
+	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
+	rtwpci->intrs[0] = B_BE_RDU_CH1_INT_IMR_V1 |
+			   B_BE_RDU_CH0_INT_IMR_V1;
+	rtwpci->intrs[1] = B_BE_PCIE_RX_RX0P2_IMR0_V1 |
+			   B_BE_PCIE_RX_RPQ0_IMR0_V1;
+}
+
+static void rtw89_pci_low_power_intr_mask_v2(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0 |
+			    B_BE_HS1_IND_INT_EN0;
+	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
+	rtwpci->intrs[0] = 0;
+	rtwpci->intrs[1] = B_BE_PCIE_RX_RX0P2_IMR0_V1 |
+			   B_BE_PCIE_RX_RPQ0_IMR0_V1;
+}
+
+void rtw89_pci_config_intr_mask_v2(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	if (rtwpci->under_recovery)
+		rtw89_pci_recovery_intr_mask_v2(rtwdev);
+	else if (rtwpci->low_power)
+		rtw89_pci_low_power_intr_mask_v2(rtwdev);
+	else
+		rtw89_pci_default_intr_mask_v2(rtwdev);
+}
+EXPORT_SYMBOL(rtw89_pci_config_intr_mask_v2);
+
 static int rtw89_pci_request_irq(struct rtw89_dev *rtwdev,
 				 struct pci_dev *pdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index cb95ad653419..d2a0a9aa4da3 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -290,6 +290,69 @@
 #define B_BE_RTK_LDO_BIAS_LATENCY_MASK GENMASK(9, 8)
 #define B_BE_CLK_REQ_LAT_MASK GENMASK(7, 4)
 
+#define R_BE_PCIE_HIMR0 0x30B0
+#define B_BE_PCIE_HB1_IND_INTA_IMR BIT(31)
+#define B_BE_PCIE_HB0_IND_INTA_IMR BIT(30)
+#define B_BE_HCI_AXIDMA_INTA_IMR BIT(29)
+#define B_BE_HC0_IND_INTA_IMR BIT(28)
+#define B_BE_HD1_IND_INTA_IMR BIT(27)
+#define B_BE_HD0_IND_INTA_IMR BIT(26)
+#define B_BE_HS1_IND_INTA_IMR BIT(25)
+#define B_BE_HS0_IND_INTA_IMR BIT(24)
+#define B_BE_PCIE_HOTRST_INT_EN BIT(16)
+#define B_BE_PCIE_FLR_INT_EN BIT(15)
+#define B_BE_PCIE_PERST_INT_EN BIT(14)
+#define B_BE_PCIE_DBG_STE_INT_EN BIT(13)
+#define B_BE_HB1_IND_INT_EN0 BIT(9)
+#define B_BE_HB0_IND_INT_EN0 BIT(8)
+#define B_BE_HC1_IND_INT_EN0 BIT(7)
+#define B_BE_HCI_AXIDMA_INT_EN0 BIT(5)
+#define B_BE_HC0_IND_INT_EN0 BIT(4)
+#define B_BE_HD1_IND_INT_EN0 BIT(3)
+#define B_BE_HD0_IND_INT_EN0 BIT(2)
+#define B_BE_HS1_IND_INT_EN0 BIT(1)
+#define B_BE_HS0_IND_INT_EN0 BIT(0)
+
+#define R_BE_PCIE_HISR 0x30B4
+#define B_BE_PCIE_HOTRST_INT BIT(16)
+#define B_BE_PCIE_FLR_INT BIT(15)
+#define B_BE_PCIE_PERST_INT BIT(14)
+#define B_BE_PCIE_DBG_STE_INT BIT(13)
+#define B_BE_HB1IMR_IND BIT(9)
+#define B_BE_HB0IMR_IND BIT(8)
+#define B_BE_HC1ISR_IND_INT BIT(7)
+#define B_BE_HCI_AXIDMA_INT BIT(5)
+#define B_BE_HC0ISR_IND_INT BIT(4)
+#define B_BE_HD1ISR_IND_INT BIT(3)
+#define B_BE_HD0ISR_IND_INT BIT(2)
+#define B_BE_HS1ISR_IND_INT BIT(1)
+#define B_BE_HS0ISR_IND_INT BIT(0)
+
+#define R_BE_PCIE_DMA_IMR_0_V1 0x30B8
+#define B_BE_PCIE_RX_RX1P1_IMR0_V1 BIT(23)
+#define B_BE_PCIE_RX_RX0P1_IMR0_V1 BIT(22)
+#define B_BE_PCIE_RX_ROQ1_IMR0_V1 BIT(21)
+#define B_BE_PCIE_RX_RPQ1_IMR0_V1 BIT(20)
+#define B_BE_PCIE_RX_RX1P2_IMR0_V1 BIT(19)
+#define B_BE_PCIE_RX_ROQ0_IMR0_V1 BIT(18)
+#define B_BE_PCIE_RX_RPQ0_IMR0_V1 BIT(17)
+#define B_BE_PCIE_RX_RX0P2_IMR0_V1 BIT(16)
+#define B_BE_PCIE_TX_CH14_IMR0 BIT(14)
+#define B_BE_PCIE_TX_CH13_IMR0 BIT(13)
+#define B_BE_PCIE_TX_CH12_IMR0 BIT(12)
+#define B_BE_PCIE_TX_CH11_IMR0 BIT(11)
+#define B_BE_PCIE_TX_CH10_IMR0 BIT(10)
+#define B_BE_PCIE_TX_CH9_IMR0 BIT(9)
+#define B_BE_PCIE_TX_CH8_IMR0 BIT(8)
+#define B_BE_PCIE_TX_CH7_IMR0 BIT(7)
+#define B_BE_PCIE_TX_CH6_IMR0 BIT(6)
+#define B_BE_PCIE_TX_CH5_IMR0 BIT(5)
+#define B_BE_PCIE_TX_CH4_IMR0 BIT(4)
+#define B_BE_PCIE_TX_CH3_IMR0 BIT(3)
+#define B_BE_PCIE_TX_CH2_IMR0 BIT(2)
+#define B_BE_PCIE_TX_CH1_IMR0 BIT(1)
+#define B_BE_PCIE_TX_CH0_IMR0 BIT(0)
+
 #define R_BE_PCIE_DMA_ISR 0x30BC
 #define B_BE_PCIE_RX_RX1P1_ISR_V1 BIT(23)
 #define B_BE_PCIE_RX_RX0P1_ISR_V1 BIT(22)
@@ -315,6 +378,39 @@
 #define B_BE_PCIE_TX_CH1_ISR BIT(1)
 #define B_BE_PCIE_TX_CH0_ISR BIT(0)
 
+#define R_BE_HAXI_HIMR00 0xB0B0
+#define B_BE_RDU_CH5_INT_IMR_V1 BIT(30)
+#define B_BE_RDU_CH4_INT_IMR_V1 BIT(29)
+#define B_BE_RDU_CH3_INT_IMR_V1 BIT(28)
+#define B_BE_RDU_CH2_INT_IMR_V1 BIT(27)
+#define B_BE_RDU_CH1_INT_IMR_V1 BIT(26)
+#define B_BE_RDU_CH0_INT_IMR_V1 BIT(25)
+#define B_BE_RXDMA_STUCK_INT_EN_V1 BIT(24)
+#define B_BE_TXDMA_STUCK_INT_EN_V1 BIT(23)
+#define B_BE_TXDMA_CH14_INT_EN_V1 BIT(22)
+#define B_BE_TXDMA_CH13_INT_EN_V1 BIT(21)
+#define B_BE_TXDMA_CH12_INT_EN_V1 BIT(20)
+#define B_BE_TXDMA_CH11_INT_EN_V1 BIT(19)
+#define B_BE_TXDMA_CH10_INT_EN_V1 BIT(18)
+#define B_BE_TXDMA_CH9_INT_EN_V1 BIT(17)
+#define B_BE_TXDMA_CH8_INT_EN_V1 BIT(16)
+#define B_BE_TXDMA_CH7_INT_EN_V1 BIT(15)
+#define B_BE_TXDMA_CH6_INT_EN_V1 BIT(14)
+#define B_BE_TXDMA_CH5_INT_EN_V1 BIT(13)
+#define B_BE_TXDMA_CH4_INT_EN_V1 BIT(12)
+#define B_BE_TXDMA_CH3_INT_EN_V1 BIT(11)
+#define B_BE_TXDMA_CH2_INT_EN_V1 BIT(10)
+#define B_BE_TXDMA_CH1_INT_EN_V1 BIT(9)
+#define B_BE_TXDMA_CH0_INT_EN_V1 BIT(8)
+#define B_BE_RX1P1DMA_INT_EN_V1 BIT(7)
+#define B_BE_RX0P1DMA_INT_EN_V1 BIT(6)
+#define B_BE_RO1DMA_INT_EN BIT(5)
+#define B_BE_RP1DMA_INT_EN BIT(4)
+#define B_BE_RX1DMA_INT_EN BIT(3)
+#define B_BE_RO0DMA_INT_EN BIT(2)
+#define B_BE_RP0DMA_INT_EN BIT(1)
+#define B_BE_RX0DMA_INT_EN BIT(0)
+
 #define R_BE_HAXI_HISR00 0xB0B4
 #define B_BE_RDU_CH6_INT BIT(28)
 #define B_BE_RDU_CH5_INT BIT(27)
@@ -1438,16 +1534,22 @@ u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
 void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev);
 void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev);
+void rtw89_pci_config_intr_mask_v2(struct rtw89_dev *rtwdev);
 void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_enable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_disable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_enable_intr_v2(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_disable_intr_v2(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
 			       struct rtw89_pci *rtwpci,
 			       struct rtw89_pci_isrs *isrs);
 void rtw89_pci_recognize_intrs_v1(struct rtw89_dev *rtwdev,
 				  struct rtw89_pci *rtwpci,
 				  struct rtw89_pci_isrs *isrs);
+void rtw89_pci_recognize_intrs_v2(struct rtw89_dev *rtwdev,
+				  struct rtw89_pci *rtwpci,
+				  struct rtw89_pci_isrs *isrs);
 
 static inline
 u32 rtw89_chip_fill_txaddr_info(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 51a0394eee3c..080db70b87d2 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3826,6 +3826,33 @@
 #define B_BE_FS_GPIO17_INT_EN BIT(1)
 #define B_BE_FS_GPIO16_INT_EN BIT(0)
 
+#define R_BE_HIMR0 0x01A0
+#define B_BE_WDT_DATACPU_TIMEOUT_INT_EN BIT(25)
+#define B_BE_HALT_D2H_INT_EN BIT(24)
+#define B_BE_WDT_TIMEOUT_INT_EN BIT(22)
+#define B_BE_HALT_C2H_INT_EN BIT(21)
+#define B_BE_RON_INT_EN BIT(20)
+#define B_BE_PDNINT_EN BIT(19)
+#define B_BE_SPSANA_OCP_INT_EN BIT(18)
+#define B_BE_SPS_OCP_INT_EN BIT(17)
+#define B_BE_BTON_STS_UPDATE_INT_EN BIT(16)
+#define B_BE_GPIOF_INT_EN BIT(15)
+#define B_BE_GPIOE_INT_EN BIT(14)
+#define B_BE_GPIOD_INT_EN BIT(13)
+#define B_BE_GPIOC_INT_EN BIT(12)
+#define B_BE_GPIOB_INT_EN BIT(11)
+#define B_BE_GPIOA_INT_EN BIT(10)
+#define B_BE_GPIO9_INT_EN BIT(9)
+#define B_BE_GPIO8_INT_EN BIT(8)
+#define B_BE_GPIO7_INT_EN BIT(7)
+#define B_BE_GPIO6_INT_EN BIT(6)
+#define B_BE_GPIO5_INT_EN BIT(5)
+#define B_BE_GPIO4_INT_EN BIT(4)
+#define B_BE_GPIO3_INT_EN BIT(3)
+#define B_BE_GPIO2_INT_EN BIT(2)
+#define B_BE_GPIO1_INT_EN BIT(1)
+#define B_BE_GPIO0_INT_EN BIT(0)
+
 #define R_BE_HISR0 0x01A4
 #define B_BE_WDT_DATACPU_TIMEOUT_INT BIT(25)
 #define B_BE_HALT_D2H_INT BIT(24)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 944337c60191..2a9ad5a254d8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -50,6 +50,10 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set_v2,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
+	.config_intr_mask	= rtw89_pci_config_intr_mask_v2,
+	.enable_intr		= rtw89_pci_enable_intr_v2,
+	.disable_intr		= rtw89_pci_disable_intr_v2,
+	.recognize_intrs	= rtw89_pci_recognize_intrs_v2,
 };
 
 static const struct rtw89_driver_info rtw89_8922ae_info = {
-- 
2.25.1

