Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35737509F52
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383297AbiDUMNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383249AbiDUMM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759625C57
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9O0j8028952, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9O0j8028952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:09:24 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/14] rtw89: pci: add variant IMR/ISR and configure functions
Date:   Thu, 21 Apr 2022 20:08:50 +0800
Message-ID: <20220421120903.73715-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421120903.73715-1-pkshih@realtek.com>
References: <20220421120903.73715-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852CE uses different but similar IMR/ISR registers, and its masks are also
different in various states, so add config_intr_mask ops to configure masks
according to under_recovery or low_power states.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 168 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h      | 123 +++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   4 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   4 +
 4 files changed, 270 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index ecb419010f0c2..0d9cd8033c778 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -612,9 +612,9 @@ static void rtw89_pci_isr_rxd_unavail(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
-				      struct rtw89_pci *rtwpci,
-				      struct rtw89_pci_isrs *isrs)
+void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
+			       struct rtw89_pci *rtwpci,
+			       struct rtw89_pci_isrs *isrs)
 {
 	isrs->halt_c2h_isrs = rtw89_read32(rtwdev, R_AX_HISR0) & rtwpci->halt_c2h_intrs;
 	isrs->isrs[0] = rtw89_read32(rtwdev, R_AX_PCIE_HISR00) & rtwpci->intrs[0];
@@ -624,6 +624,28 @@ static void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
 	rtw89_write32(rtwdev, R_AX_PCIE_HISR00, isrs->isrs[0]);
 	rtw89_write32(rtwdev, R_AX_PCIE_HISR10, isrs->isrs[1]);
 }
+EXPORT_SYMBOL(rtw89_pci_recognize_intrs);
+
+void rtw89_pci_recognize_intrs_v1(struct rtw89_dev *rtwdev,
+				  struct rtw89_pci *rtwpci,
+				  struct rtw89_pci_isrs *isrs)
+{
+	isrs->ind_isrs = rtw89_read32(rtwdev, R_AX_PCIE_HISR00_V1) & rtwpci->ind_intrs;
+	isrs->halt_c2h_isrs = isrs->ind_isrs & B_AX_HS0ISR_IND_INT_EN ?
+			      rtw89_read32(rtwdev, R_AX_HISR0) & rtwpci->halt_c2h_intrs : 0;
+	isrs->isrs[0] = isrs->ind_isrs & B_AX_HCI_AXIDMA_INT_EN ?
+			rtw89_read32(rtwdev, R_AX_HAXI_HISR00) & rtwpci->intrs[0] : 0;
+	isrs->isrs[1] = isrs->ind_isrs & B_AX_HS1ISR_IND_INT_EN ?
+			rtw89_read32(rtwdev, R_AX_HISR1) & rtwpci->intrs[1] : 0;
+
+	if (isrs->halt_c2h_isrs)
+		rtw89_write32(rtwdev, R_AX_HISR0, isrs->halt_c2h_isrs);
+	if (isrs->isrs[0])
+		rtw89_write32(rtwdev, R_AX_HAXI_HISR00, isrs->isrs[0]);
+	if (isrs->isrs[1])
+		rtw89_write32(rtwdev, R_AX_HISR1, isrs->isrs[1]);
+}
+EXPORT_SYMBOL(rtw89_pci_recognize_intrs_v1);
 
 static void rtw89_pci_clear_isr0(struct rtw89_dev *rtwdev, u32 isr00)
 {
@@ -631,21 +653,39 @@ static void rtw89_pci_clear_isr0(struct rtw89_dev *rtwdev, u32 isr00)
 	rtw89_write32(rtwdev, R_AX_PCIE_HISR00, isr00);
 }
 
-static void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev,
-				  struct rtw89_pci *rtwpci)
+void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
 {
 	rtw89_write32(rtwdev, R_AX_HIMR0, rtwpci->halt_c2h_intrs);
 	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, rtwpci->intrs[0]);
 	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, rtwpci->intrs[1]);
 }
+EXPORT_SYMBOL(rtw89_pci_enable_intr);
 
-static void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev,
-				   struct rtw89_pci *rtwpci)
+void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
 {
 	rtw89_write32(rtwdev, R_AX_HIMR0, 0);
 	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, 0);
 	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, 0);
 }
+EXPORT_SYMBOL(rtw89_pci_disable_intr);
+
+void rtw89_pci_enable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00_V1, rtwpci->ind_intrs);
+	rtw89_write32(rtwdev, R_AX_HIMR0, rtwpci->halt_c2h_intrs);
+	rtw89_write32(rtwdev, R_AX_HAXI_HIMR00, rtwpci->intrs[0]);
+	rtw89_write32(rtwdev, R_AX_HIMR1, rtwpci->intrs[1]);
+}
+EXPORT_SYMBOL(rtw89_pci_enable_intr_v1);
+
+void rtw89_pci_disable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00_V1, 0);
+	rtw89_write32(rtwdev, R_AX_HIMR0, 0);
+	rtw89_write32(rtwdev, R_AX_HAXI_HIMR00, 0);
+	rtw89_write32(rtwdev, R_AX_HIMR1, 0);
+}
+EXPORT_SYMBOL(rtw89_pci_disable_intr_v1);
 
 static void rtw89_pci_ops_recovery_start(struct rtw89_dev *rtwdev)
 {
@@ -653,9 +693,9 @@ static void rtw89_pci_ops_recovery_start(struct rtw89_dev *rtwdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtwpci->irq_lock, flags);
-	rtwpci->under_recovery = true;
-	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, 0);
-	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, 0);
+	rtw89_chip_disable_intr(rtwdev, rtwpci);
+	rtw89_chip_config_intr_mask(rtwdev, RTW89_PCI_INTR_MASK_RECOVERY_START);
+	rtw89_chip_enable_intr(rtwdev, rtwpci);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 }
 
@@ -665,8 +705,9 @@ static void rtw89_pci_ops_recovery_complete(struct rtw89_dev *rtwdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtwpci->irq_lock, flags);
-	rtwpci->under_recovery = false;
-	rtw89_pci_enable_intr(rtwdev, rtwpci);
+	rtw89_chip_disable_intr(rtwdev, rtwpci);
+	rtw89_chip_config_intr_mask(rtwdev, RTW89_PCI_INTR_MASK_RECOVERY_COMPLETE);
+	rtw89_chip_enable_intr(rtwdev, rtwpci);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 }
 
@@ -678,7 +719,7 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtwpci->irq_lock, flags);
-	rtw89_pci_recognize_intrs(rtwdev, rtwpci, &isrs);
+	rtw89_chip_recognize_intrs(rtwdev, rtwpci, &isrs);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 
 	if (unlikely(isrs.isrs[0] & B_AX_RDU_INT))
@@ -716,7 +757,7 @@ static irqreturn_t rtw89_pci_interrupt_handler(int irq, void *dev)
 		goto exit;
 	}
 
-	rtw89_pci_disable_intr(rtwdev, rtwpci);
+	rtw89_chip_disable_intr(rtwdev, rtwpci);
 exit:
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 
@@ -1313,32 +1354,42 @@ static void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev)
 	spin_unlock_bh(&rtwpci->trx_lock);
 }
 
-static int rtw89_pci_ops_start(struct rtw89_dev *rtwdev)
+static void rtw89_pci_enable_intr_lock(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	unsigned long flags;
 
-	rtw89_core_napi_start(rtwdev);
-
 	spin_lock_irqsave(&rtwpci->irq_lock, flags);
 	rtwpci->running = true;
-	rtw89_pci_enable_intr(rtwdev, rtwpci);
+	rtw89_chip_enable_intr(rtwdev, rtwpci);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
-
-	return 0;
 }
 
-static void rtw89_pci_ops_stop(struct rtw89_dev *rtwdev)
+static void rtw89_pci_disable_intr_lock(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-	struct pci_dev *pdev = rtwpci->pdev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtwpci->irq_lock, flags);
 	rtwpci->running = false;
-	rtw89_pci_disable_intr(rtwdev, rtwpci);
+	rtw89_chip_disable_intr(rtwdev, rtwpci);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+}
+
+static int rtw89_pci_ops_start(struct rtw89_dev *rtwdev)
+{
+	rtw89_core_napi_start(rtwdev);
+	rtw89_pci_enable_intr_lock(rtwdev);
+
+	return 0;
+}
 
+static void rtw89_pci_ops_stop(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+
+	rtw89_pci_disable_intr_lock(rtwdev);
 	synchronize_irq(pdev->irq);
 	rtw89_core_napi_stop(rtwdev);
 }
@@ -2924,22 +2975,81 @@ static void rtw89_pci_clear_resource(struct rtw89_dev *rtwdev,
 				skb_queue_len(&rtwpci->h2c_queue), true);
 }
 
-static void rtw89_pci_default_intr_mask(struct rtw89_dev *rtwdev)
+void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 
 	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN | 0;
+
+	if (rtwpci->under_recovery) {
+		rtwpci->intrs[0] = 0;
+		rtwpci->intrs[1] = 0;
+	} else {
+		rtwpci->intrs[0] = B_AX_TXDMA_STUCK_INT_EN |
+				   B_AX_RXDMA_INT_EN |
+				   B_AX_RXP1DMA_INT_EN |
+				   B_AX_RPQDMA_INT_EN |
+				   B_AX_RXDMA_STUCK_INT_EN |
+				   B_AX_RDU_INT_EN |
+				   B_AX_RPQBD_FULL_INT_EN |
+				   B_AX_HS0ISR_IND_INT_EN;
+
+		rtwpci->intrs[1] = B_AX_HC10ISR_IND_INT_EN;
+	}
+}
+EXPORT_SYMBOL(rtw89_pci_config_intr_mask);
+
+static void rtw89_pci_recovery_intr_mask_v1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_AX_HS0ISR_IND_INT_EN;
+	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN;
+	rtwpci->intrs[0] = 0;
+	rtwpci->intrs[1] = 0;
+}
+
+static void rtw89_pci_default_intr_mask_v1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_AX_HCI_AXIDMA_INT_EN |
+			    B_AX_HS1ISR_IND_INT_EN |
+			    B_AX_HS0ISR_IND_INT_EN;
+	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN;
 	rtwpci->intrs[0] = B_AX_TXDMA_STUCK_INT_EN |
 			   B_AX_RXDMA_INT_EN |
 			   B_AX_RXP1DMA_INT_EN |
 			   B_AX_RPQDMA_INT_EN |
 			   B_AX_RXDMA_STUCK_INT_EN |
 			   B_AX_RDU_INT_EN |
-			   B_AX_RPQBD_FULL_INT_EN |
-			   B_AX_HS0ISR_IND_INT_EN;
+			   B_AX_RPQBD_FULL_INT_EN;
+	rtwpci->intrs[1] = B_AX_GPIO18_INT_EN;
+}
+
+static void rtw89_pci_low_power_intr_mask_v1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_AX_HS1ISR_IND_INT_EN |
+			    B_AX_HS0ISR_IND_INT_EN;
+	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN;
+	rtwpci->intrs[0] = 0;
+	rtwpci->intrs[1] = B_AX_GPIO18_INT_EN;
+}
 
-	rtwpci->intrs[1] = B_AX_HC10ISR_IND_INT_EN;
+void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	if (rtwpci->under_recovery)
+		rtw89_pci_recovery_intr_mask_v1(rtwdev);
+	else if (rtwpci->low_power)
+		rtw89_pci_low_power_intr_mask_v1(rtwdev);
+	else
+		rtw89_pci_default_intr_mask_v1(rtwdev);
 }
+EXPORT_SYMBOL(rtw89_pci_config_intr_mask_v1);
 
 static int rtw89_pci_request_irq(struct rtw89_dev *rtwdev,
 				 struct pci_dev *pdev)
@@ -2963,7 +3073,7 @@ static int rtw89_pci_request_irq(struct rtw89_dev *rtwdev,
 		goto err_free_vector;
 	}
 
-	rtw89_pci_default_intr_mask(rtwdev);
+	rtw89_chip_config_intr_mask(rtwdev, RTW89_PCI_INTR_MASK_RESET);
 
 	return 0;
 
@@ -3285,7 +3395,7 @@ static int rtw89_pci_napi_poll(struct napi_struct *napi, int budget)
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		spin_lock_irqsave(&rtwpci->irq_lock, flags);
 		if (likely(rtwpci->running))
-			rtw89_pci_enable_intr(rtwdev, rtwpci);
+			rtw89_chip_enable_intr(rtwdev, rtwpci);
 		spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index a085d1f27a120..aa804b577df27 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -97,6 +97,16 @@
 #define B_AX_HALT_C2H_INT_EN BIT(21)
 #define R_AX_HISR0 0x01A4
 
+#define R_AX_HIMR1 0x01A8
+#define B_AX_GPIO18_INT_EN BIT(2)
+#define B_AX_GPIO17_INT_EN BIT(1)
+#define B_AX_GPIO16_INT_EN BIT(0)
+
+#define R_AX_HISR1 0x01AC
+#define B_AX_GPIO18_INT BIT(2)
+#define B_AX_GPIO17_INT BIT(1)
+#define B_AX_GPIO16_INT BIT(0)
+
 #define R_AX_MDIO_CFG			0x10A0
 #define B_AX_MDIO_PHY_ADDR_MASK		GENMASK(13, 12)
 #define B_AX_MDIO_RFLAG			BIT(9)
@@ -104,6 +114,7 @@
 #define B_AX_MDIO_ADDR_MASK		GENMASK(4, 0)
 
 #define R_AX_PCIE_HIMR00	0x10B0
+#define R_AX_HAXI_HIMR00 0x10B0
 #define B_AX_HC00ISR_IND_INT_EN		BIT(27)
 #define B_AX_HD1ISR_IND_INT_EN		BIT(26)
 #define B_AX_HD0ISR_IND_INT_EN		BIT(25)
@@ -132,6 +143,7 @@
 #define B_AX_RXDMA_INT_EN		BIT(0)
 
 #define R_AX_PCIE_HISR00	0x10B4
+#define R_AX_HAXI_HISR00 0x10B4
 #define B_AX_HC00ISR_IND_INT		BIT(27)
 #define B_AX_HD1ISR_IND_INT		BIT(26)
 #define B_AX_HD0ISR_IND_INT		BIT(25)
@@ -159,6 +171,10 @@
 #define B_AX_RXP1DMA_INT		BIT(1)
 #define B_AX_RXDMA_INT			BIT(0)
 
+#define R_AX_HAXI_HIMR10 0x11E0
+#define B_AX_TXDMA_CH11_INT_EN_V1 BIT(1)
+#define B_AX_TXDMA_CH10_INT_EN_V1 BIT(0)
+
 #define R_AX_PCIE_HIMR10	0x13B0
 #define B_AX_HC10ISR_IND_INT_EN		BIT(28)
 #define B_AX_TXDMA_CH11_INT_EN		BIT(12)
@@ -169,6 +185,22 @@
 #define B_AX_TXDMA_CH11_INT		BIT(12)
 #define B_AX_TXDMA_CH10_INT		BIT(11)
 
+#define R_AX_PCIE_HIMR00_V1 0x30B0
+#define B_AX_HCI_AXIDMA_INT_EN BIT(29)
+#define B_AX_HC00ISR_IND_INT_EN_V1 BIT(28)
+#define B_AX_HD1ISR_IND_INT_EN_V1 BIT(27)
+#define B_AX_HD0ISR_IND_INT_EN_V1 BIT(26)
+#define B_AX_HS1ISR_IND_INT_EN BIT(25)
+#define B_AX_PCIE_DBG_STE_INT_EN BIT(13)
+
+#define R_AX_PCIE_HISR00_V1 0x30B4
+#define B_AX_HCI_AXIDMA_INT BIT(29)
+#define B_AX_HC00ISR_IND_INT_V1 BIT(28)
+#define B_AX_HD1ISR_IND_INT_V1 BIT(27)
+#define B_AX_HD0ISR_IND_INT_V1 BIT(26)
+#define B_AX_HS1ISR_IND_INT BIT(25)
+#define B_AX_PCIE_DBG_STE_INT BIT(13)
+
 /* TX/RX */
 #define R_AX_RXQ_RXBD_IDX	0x1050
 #define R_AX_RPQ_RXBD_IDX	0x1054
@@ -612,6 +644,17 @@ enum mac_ax_io_rcy_tmr {
 	MAC_AX_IO_RCY_ANA_TMR_DEF = 0xFE
 };
 
+enum rtw89_pci_intr_mask_cfg {
+	RTW89_PCI_INTR_MASK_RESET,
+	RTW89_PCI_INTR_MASK_NORMAL,
+	RTW89_PCI_INTR_MASK_LOW_POWER,
+	RTW89_PCI_INTR_MASK_RECOVERY_START,
+	RTW89_PCI_INTR_MASK_RECOVERY_COMPLETE,
+};
+
+struct rtw89_pci_isrs;
+struct rtw89_pci;
+
 struct rtw89_pci_ch_dma_addr {
 	u32 num;
 	u32 idx;
@@ -661,6 +704,12 @@ struct rtw89_pci_info {
 	u32 (*fill_txaddr_info)(struct rtw89_dev *rtwdev,
 				void *txaddr_info_addr, u32 total_len,
 				dma_addr_t dma, u8 *add_info_nr);
+	void (*config_intr_mask)(struct rtw89_dev *rtwdev);
+	void (*enable_intr)(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+	void (*disable_intr)(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+	void (*recognize_intrs)(struct rtw89_dev *rtwdev,
+				struct rtw89_pci *rtwpci,
+				struct rtw89_pci_isrs *isrs);
 };
 
 struct rtw89_pci_bd_ram {
@@ -807,6 +856,7 @@ struct rtw89_pci_rx_ring {
 };
 
 struct rtw89_pci_isrs {
+	u32 ind_isrs;
 	u32 halt_c2h_isrs;
 	u32 isrs[2];
 };
@@ -819,12 +869,14 @@ struct rtw89_pci {
 	/* protect TRX resources (exclude RXQ) */
 	spinlock_t trx_lock;
 	bool running;
+	bool low_power;
 	bool under_recovery;
 	struct rtw89_pci_tx_ring tx_rings[RTW89_TXCH_NUM];
 	struct rtw89_pci_rx_ring rx_rings[RTW89_RXCH_NUM];
 	struct sk_buff_head h2c_queue;
 	struct sk_buff_head h2c_release_queue;
 
+	u32 ind_intrs;
 	u32 halt_c2h_intrs;
 	u32 intrs[2];
 	void __iomem *mmap;
@@ -931,6 +983,18 @@ u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
 u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
 				  void *txaddr_info_addr, u32 total_len,
 				  dma_addr_t dma, u8 *add_info_nr);
+void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev);
+void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev);
+void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_enable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_disable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
+			       struct rtw89_pci *rtwpci,
+			       struct rtw89_pci_isrs *isrs);
+void rtw89_pci_recognize_intrs_v1(struct rtw89_dev *rtwdev,
+				  struct rtw89_pci *rtwpci,
+				  struct rtw89_pci_isrs *isrs);
 
 static inline
 u32 rtw89_chip_fill_txaddr_info(struct rtw89_dev *rtwdev,
@@ -943,4 +1007,63 @@ u32 rtw89_chip_fill_txaddr_info(struct rtw89_dev *rtwdev,
 				      dma, add_info_nr);
 }
 
+static inline void rtw89_chip_config_intr_mask(struct rtw89_dev *rtwdev,
+					       enum rtw89_pci_intr_mask_cfg cfg)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+
+	switch (cfg) {
+	default:
+	case RTW89_PCI_INTR_MASK_RESET:
+		rtwpci->low_power = false;
+		rtwpci->under_recovery = false;
+		break;
+	case RTW89_PCI_INTR_MASK_NORMAL:
+		rtwpci->low_power = false;
+		break;
+	case RTW89_PCI_INTR_MASK_LOW_POWER:
+		rtwpci->low_power = true;
+		break;
+	case RTW89_PCI_INTR_MASK_RECOVERY_START:
+		rtwpci->under_recovery = true;
+		break;
+	case RTW89_PCI_INTR_MASK_RECOVERY_COMPLETE:
+		rtwpci->under_recovery = false;
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_HCI,
+		    "Configure PCI interrupt mask mode low_power=%d under_recovery=%d\n",
+		    rtwpci->low_power, rtwpci->under_recovery);
+
+	info->config_intr_mask(rtwdev);
+}
+
+static inline
+void rtw89_chip_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+
+	info->enable_intr(rtwdev, rtwpci);
+}
+
+static inline
+void rtw89_chip_disable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+
+	info->disable_intr(rtwdev, rtwpci);
+}
+
+static inline
+void rtw89_chip_recognize_intrs(struct rtw89_dev *rtwdev,
+				struct rtw89_pci *rtwpci,
+				struct rtw89_pci_isrs *isrs)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+
+	info->recognize_intrs(rtwdev, rtwpci, isrs);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 61a1693535d8a..73b5dd05235aa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -42,6 +42,10 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.config_intr_mask	= rtw89_pci_config_intr_mask,
+	.enable_intr		= rtw89_pci_enable_intr,
+	.disable_intr		= rtw89_pci_disable_intr,
+	.recognize_intrs	= rtw89_pci_recognize_intrs,
 };
 
 static const struct rtw89_driver_info rtw89_8852ae_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index aeafac553f404..4021a56a82bc5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -43,6 +43,10 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 
 	.ltr_set		= rtw89_pci_ltr_set_v1,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
+	.config_intr_mask	= rtw89_pci_config_intr_mask_v1,
+	.enable_intr		= rtw89_pci_enable_intr_v1,
+	.disable_intr		= rtw89_pci_disable_intr_v1,
+	.recognize_intrs	= rtw89_pci_recognize_intrs_v1,
 };
 
 static const struct rtw89_driver_info rtw89_8852ce_info = {
-- 
2.25.1

