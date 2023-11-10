Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6787E767B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjKJBY0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjKJBYZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657444A4
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1OEkO41890531, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1OEkO41890531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 10 Nov 2023 09:24:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: pci: generalize interrupt status bits of interrupt handlers
Date:   Fri, 10 Nov 2023 09:23:16 +0800
Message-ID: <20231110012319.12727-5-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For WiFi 7, interrupt status registers and their definitions are changed
a lot, but the logic is still the same, so define fields to reuse the code.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 27 +++++----
 drivers/net/wireless/realtek/rtw89/pci.h    | 62 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  6 ++
 drivers/net/wireless/realtek/rtw89/reg.h    | 27 +++++++++
 4 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 013588a572c5..71c73adfcf59 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -696,12 +696,6 @@ void rtw89_pci_recognize_intrs_v1(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_pci_recognize_intrs_v1);
 
-static void rtw89_pci_clear_isr0(struct rtw89_dev *rtwdev, u32 isr00)
-{
-	/* write 1 clear */
-	rtw89_write32(rtwdev, R_AX_PCIE_HISR00, isr00);
-}
-
 void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
 {
 	rtw89_write32(rtwdev, R_AX_HIMR0, rtwpci->halt_c2h_intrs);
@@ -773,6 +767,8 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 {
 	struct rtw89_dev *rtwdev = dev;
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
 	struct rtw89_pci_isrs isrs;
 	unsigned long flags;
 
@@ -780,13 +776,13 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	rtw89_chip_recognize_intrs(rtwdev, rtwpci, &isrs);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 
-	if (unlikely(isrs.isrs[0] & B_AX_RDU_INT))
+	if (unlikely(isrs.isrs[0] & gen_def->isr_rdu))
 		rtw89_pci_isr_rxd_unavail(rtwdev, rtwpci);
 
-	if (unlikely(isrs.halt_c2h_isrs & B_AX_HALT_C2H_INT_EN))
+	if (unlikely(isrs.halt_c2h_isrs & gen_def->isr_halt_c2h))
 		rtw89_ser_notify(rtwdev, rtw89_mac_get_err_status(rtwdev));
 
-	if (unlikely(isrs.halt_c2h_isrs & B_AX_WDT_TIMEOUT_INT_EN))
+	if (unlikely(isrs.halt_c2h_isrs & gen_def->isr_wdt_timeout))
 		rtw89_ser_notify(rtwdev, MAC_AX_ERR_L2_ERR_WDT_TIMEOUT_INT);
 
 	if (unlikely(rtwpci->under_recovery))
@@ -3748,17 +3744,19 @@ static int rtw89_pci_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct rtw89_dev *rtwdev = container_of(napi, struct rtw89_dev, napi);
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
 	unsigned long flags;
 	int work_done;
 
 	rtwdev->napi_budget_countdown = budget;
 
-	rtw89_pci_clear_isr0(rtwdev, B_AX_RPQDMA_INT | B_AX_RPQBD_FULL_INT);
+	rtw89_write32(rtwdev, gen_def->isr_clear_rpq.addr, gen_def->isr_clear_rpq.data);
 	work_done = rtw89_pci_poll_rpq_dma(rtwdev, rtwpci, rtwdev->napi_budget_countdown);
 	if (work_done == budget)
 		return budget;
 
-	rtw89_pci_clear_isr0(rtwdev, B_AX_RXP1DMA_INT | B_AX_RXDMA_INT | B_AX_RDU_INT);
+	rtw89_write32(rtwdev, gen_def->isr_clear_rxq.addr, gen_def->isr_clear_rxq.data);
 	work_done += rtw89_pci_poll_rxq_dma(rtwdev, rtwpci, rtwdev->napi_budget_countdown);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		spin_lock_irqsave(&rtwpci->irq_lock, flags);
@@ -3836,6 +3834,13 @@ SIMPLE_DEV_PM_OPS(rtw89_pm_ops, rtw89_pci_suspend, rtw89_pci_resume);
 EXPORT_SYMBOL(rtw89_pm_ops);
 
 const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
+	.isr_rdu = B_AX_RDU_INT,
+	.isr_halt_c2h = B_AX_HALT_C2H_INT_EN,
+	.isr_wdt_timeout = B_AX_WDT_TIMEOUT_INT_EN,
+	.isr_clear_rpq = {R_AX_PCIE_HISR00, B_AX_RPQDMA_INT | B_AX_RPQBD_FULL_INT},
+	.isr_clear_rxq = {R_AX_PCIE_HISR00, B_AX_RXP1DMA_INT | B_AX_RXDMA_INT |
+					    B_AX_RDU_INT},
+
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
 	.mac_pre_deinit = NULL,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 426f9d28650b..cb95ad653419 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -290,6 +290,62 @@
 #define B_BE_RTK_LDO_BIAS_LATENCY_MASK GENMASK(9, 8)
 #define B_BE_CLK_REQ_LAT_MASK GENMASK(7, 4)
 
+#define R_BE_PCIE_DMA_ISR 0x30BC
+#define B_BE_PCIE_RX_RX1P1_ISR_V1 BIT(23)
+#define B_BE_PCIE_RX_RX0P1_ISR_V1 BIT(22)
+#define B_BE_PCIE_RX_ROQ1_ISR_V1 BIT(21)
+#define B_BE_PCIE_RX_RPQ1_ISR_V1 BIT(20)
+#define B_BE_PCIE_RX_RX1P2_ISR_V1 BIT(19)
+#define B_BE_PCIE_RX_ROQ0_ISR_V1 BIT(18)
+#define B_BE_PCIE_RX_RPQ0_ISR_V1 BIT(17)
+#define B_BE_PCIE_RX_RX0P2_ISR_V1 BIT(16)
+#define B_BE_PCIE_TX_CH14_ISR BIT(14)
+#define B_BE_PCIE_TX_CH13_ISR BIT(13)
+#define B_BE_PCIE_TX_CH12_ISR BIT(12)
+#define B_BE_PCIE_TX_CH11_ISR BIT(11)
+#define B_BE_PCIE_TX_CH10_ISR BIT(10)
+#define B_BE_PCIE_TX_CH9_ISR BIT(9)
+#define B_BE_PCIE_TX_CH8_ISR BIT(8)
+#define B_BE_PCIE_TX_CH7_ISR BIT(7)
+#define B_BE_PCIE_TX_CH6_ISR BIT(6)
+#define B_BE_PCIE_TX_CH5_ISR BIT(5)
+#define B_BE_PCIE_TX_CH4_ISR BIT(4)
+#define B_BE_PCIE_TX_CH3_ISR BIT(3)
+#define B_BE_PCIE_TX_CH2_ISR BIT(2)
+#define B_BE_PCIE_TX_CH1_ISR BIT(1)
+#define B_BE_PCIE_TX_CH0_ISR BIT(0)
+
+#define R_BE_HAXI_HISR00 0xB0B4
+#define B_BE_RDU_CH6_INT BIT(28)
+#define B_BE_RDU_CH5_INT BIT(27)
+#define B_BE_RDU_CH4_INT BIT(26)
+#define B_BE_RDU_CH2_INT BIT(25)
+#define B_BE_RDU_CH1_INT BIT(24)
+#define B_BE_RDU_CH0_INT BIT(23)
+#define B_BE_RXDMA_STUCK_INT BIT(22)
+#define B_BE_TXDMA_STUCK_INT BIT(21)
+#define B_BE_TXDMA_CH14_INT BIT(20)
+#define B_BE_TXDMA_CH13_INT BIT(19)
+#define B_BE_TXDMA_CH12_INT BIT(18)
+#define B_BE_TXDMA_CH11_INT BIT(17)
+#define B_BE_TXDMA_CH10_INT BIT(16)
+#define B_BE_TXDMA_CH9_INT BIT(15)
+#define B_BE_TXDMA_CH8_INT BIT(14)
+#define B_BE_TXDMA_CH7_INT BIT(13)
+#define B_BE_TXDMA_CH6_INT BIT(12)
+#define B_BE_TXDMA_CH5_INT BIT(11)
+#define B_BE_TXDMA_CH4_INT BIT(10)
+#define B_BE_TXDMA_CH3_INT BIT(9)
+#define B_BE_TXDMA_CH2_INT BIT(8)
+#define B_BE_TXDMA_CH1_INT BIT(7)
+#define B_BE_TXDMA_CH0_INT BIT(6)
+#define B_BE_RPQ1DMA_INT BIT(5)
+#define B_BE_RX1P1DMA_INT BIT(4)
+#define B_BE_RX1DMA_INT BIT(3)
+#define B_BE_RPQ0DMA_INT BIT(2)
+#define B_BE_RX0P1DMA_INT BIT(1)
+#define B_BE_RX0DMA_INT BIT(0)
+
 /* TX/RX */
 #define R_AX_DRV_FW_HSK_0	0x01B0
 #define R_AX_DRV_FW_HSK_1	0x01B4
@@ -1037,6 +1093,12 @@ struct rtw89_pci_bd_ram {
 };
 
 struct rtw89_pci_gen_def {
+	u32 isr_rdu;
+	u32 isr_halt_c2h;
+	u32 isr_wdt_timeout;
+	struct rtw89_reg2_def isr_clear_rpq;
+	struct rtw89_reg2_def isr_clear_rxq;
+
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
 	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 4f76395e243a..629ffa4bee91 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -490,6 +490,12 @@ static int rtw89_pci_lv1rst_start_dma_be(struct rtw89_dev *rtwdev)
 }
 
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
+	.isr_rdu = B_BE_RDU_CH1_INT | B_BE_RDU_CH0_INT,
+	.isr_halt_c2h = B_BE_HALT_C2H_INT,
+	.isr_wdt_timeout = B_BE_WDT_TIMEOUT_INT,
+	.isr_clear_rpq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RPQ0_ISR_V1},
+	.isr_clear_rxq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RX0P2_ISR_V1},
+
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
 	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_be,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 470302e6de11..51a0394eee3c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3826,6 +3826,33 @@
 #define B_BE_FS_GPIO17_INT_EN BIT(1)
 #define B_BE_FS_GPIO16_INT_EN BIT(0)
 
+#define R_BE_HISR0 0x01A4
+#define B_BE_WDT_DATACPU_TIMEOUT_INT BIT(25)
+#define B_BE_HALT_D2H_INT BIT(24)
+#define B_BE_WDT_TIMEOUT_INT BIT(22)
+#define B_BE_HALT_C2H_INT BIT(21)
+#define B_BE_RON_INT BIT(20)
+#define B_BE_PDNINT BIT(19)
+#define B_BE_SPSANA_OCP_INT BIT(18)
+#define B_BE_SPS_OCP_INT BIT(17)
+#define B_BE_BTON_STS_UPDATE_INT BIT(16)
+#define B_BE_GPIOF_INT BIT(15)
+#define B_BE_GPIOE_INT BIT(14)
+#define B_BE_GPIOD_INT BIT(13)
+#define B_BE_GPIOC_INT BIT(12)
+#define B_BE_GPIOB_INT BIT(11)
+#define B_BE_GPIOA_INT BIT(10)
+#define B_BE_GPIO9_INT BIT(9)
+#define B_BE_GPIO8_INT BIT(8)
+#define B_BE_GPIO7_INT BIT(7)
+#define B_BE_GPIO6_INT BIT(6)
+#define B_BE_GPIO5_INT BIT(5)
+#define B_BE_GPIO4_INT BIT(4)
+#define B_BE_GPIO3_INT BIT(3)
+#define B_BE_GPIO2_INT BIT(2)
+#define B_BE_GPIO1_INT BIT(1)
+#define B_BE_GPIO0_INT BIT(0)
+
 #define R_BE_WCPU_FW_CTRL 0x01E0
 #define B_BE_RUN_ENV_MASK GENMASK(31, 30)
 #define B_BE_WCPU_FWDL_STATUS_MASK GENMASK(29, 26)
-- 
2.25.1

