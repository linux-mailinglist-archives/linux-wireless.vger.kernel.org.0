Return-Path: <linux-wireless+bounces-26616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C9AB357AC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61204175AC6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8E2FE065;
	Tue, 26 Aug 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KhVyDgZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549A2FF145
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198390; cv=none; b=AZ6y43o9dItR1L3MpVNKsOJuHWHe8XJFDzfgw+bXRLwAJMN3TFCDdHVco4dw9zS70OEH1d286sEfDtFyxv4c8zcNQajGwF3Fsd7Kr/YXyjEEwaJlm+kcKtWoJ6p8y5oxhdyeX5VOMvzzX0JdztI6mONAngSHDzCqEGjl1ppCDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198390; c=relaxed/simple;
	bh=MCxK7vkJ/2zAnOA6YkIo0RmU4vE1FC+rHsgqfi20g+U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hb/so5+KyYkiPIlC55/Qg/JX/6pfAyWzZX9EpZyOhXJa0U38xOOIh9uVPAG2DRZMhHXJuVlBI6LU6XDLPUIkXwAHSbVipXVDloZZsOUWvK/Z4gG+MW5DTsBNfV36IFyTelVyaYo4dTKC9MRmNKZZKo6SCp4F8bj2E4G/zZME7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KhVyDgZB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8r4I211261944, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198385; bh=PJ0scRzS9YidLRea3twanunIY/zxlaWy6T0EICMlqYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KhVyDgZBgrZzlYNqIY6HR8MOHySHTDURNZ7o3C2mwqpVdE/6U9BfyOt1jvCw2NvdO
	 2HDn7ne0CtCoEgJZq9/VlilG2hve7g+0XREuWZfCHukJc+B63dl7TDrXBg5ZRR3ggX
	 QIoGJ51Q3m3rkCZRi91jdFi75mVbAiGnrlA7+ofQUYr6JLeUUr5E91d0jynpqxFhDw
	 AFMzTWRZ+pVKY820WIleUXPiVAAagV8qiwFsj3dLT9PZAhZ0JN0hLukI/37JRsup0M
	 08L1gMkwUWqM3ARjfXDRjcEmx1oz5KyQqTt4S85AzDRuK+AbidQ97HsL3xlUPGg1eI
	 9Knvhg0ekA/cA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8r4I211261944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:53:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:53:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:53:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 02/10] wifi: rtw89: pci: prepare interrupt related registers and functions for 8922DE
Date: Tue, 26 Aug 2025 16:51:44 +0800
Message-ID: <20250826085152.28164-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826085152.28164-1-pkshih@realtek.com>
References: <20250826085152.28164-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

The 8922DE is very similar to 8922AE except to RDU (RX desc unavailable)
registers. The following patch will adjust to read this status from
another register to reduce one reading IO, so create a set of functions
ahead.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 85 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h    | 15 ++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  9 +++
 3 files changed, 109 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 162075882fa4..0153977d4cf2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -797,6 +797,27 @@ void rtw89_pci_recognize_intrs_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_pci_recognize_intrs_v2);
 
+void rtw89_pci_recognize_intrs_v3(struct rtw89_dev *rtwdev,
+				  struct rtw89_pci *rtwpci,
+				  struct rtw89_pci_isrs *isrs)
+{
+	isrs->ind_isrs = rtw89_read32(rtwdev, R_BE_PCIE_HISR) & rtwpci->ind_intrs;
+	isrs->halt_c2h_isrs = isrs->ind_isrs & B_BE_HS0ISR_IND_INT ?
+			      rtw89_read32(rtwdev, R_BE_HISR0) & rtwpci->halt_c2h_intrs : 0;
+	isrs->isrs[0] = isrs->ind_isrs & B_BE_HCI_AXIDMA_INT ?
+			rtw89_read32(rtwdev, R_BE_HAXI_HISR00) & rtwpci->intrs[0] : 0;
+	isrs->isrs[1] = rtw89_read32(rtwdev, R_BE_PCIE_DMA_ISR) & rtwpci->intrs[1];
+
+	if (isrs->halt_c2h_isrs)
+		rtw89_write32(rtwdev, R_BE_HISR0, isrs->halt_c2h_isrs);
+	if (isrs->isrs[0])
+		rtw89_write32(rtwdev, R_BE_HAXI_HISR00, isrs->isrs[0]);
+	if (isrs->isrs[1])
+		rtw89_write32(rtwdev, R_BE_PCIE_DMA_ISR, isrs->isrs[1]);
+	rtw89_write32(rtwdev, R_BE_PCIE_HISR, isrs->ind_isrs);
+}
+EXPORT_SYMBOL(rtw89_pci_recognize_intrs_v3);
+
 void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
 {
 	rtw89_write32(rtwdev, R_AX_HIMR0, rtwpci->halt_c2h_intrs);
@@ -844,6 +865,22 @@ void rtw89_pci_disable_intr_v2(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpc
 }
 EXPORT_SYMBOL(rtw89_pci_disable_intr_v2);
 
+void rtw89_pci_enable_intr_v3(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	rtw89_write32(rtwdev, R_BE_HIMR0, rtwpci->halt_c2h_intrs);
+	rtw89_write32(rtwdev, R_BE_HAXI_HIMR00, rtwpci->intrs[0]);
+	rtw89_write32(rtwdev, R_BE_PCIE_DMA_IMR_0_V1, rtwpci->intrs[1]);
+	rtw89_write32(rtwdev, R_BE_PCIE_HIMR0, rtwpci->ind_intrs);
+}
+EXPORT_SYMBOL(rtw89_pci_enable_intr_v3);
+
+void rtw89_pci_disable_intr_v3(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
+{
+	rtw89_write32(rtwdev, R_BE_PCIE_HIMR0, 0);
+	rtw89_write32(rtwdev, R_BE_PCIE_DMA_IMR_0_V1, 0);
+}
+EXPORT_SYMBOL(rtw89_pci_disable_intr_v3);
+
 static void rtw89_pci_ops_recovery_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
@@ -3776,6 +3813,54 @@ void rtw89_pci_config_intr_mask_v2(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_pci_config_intr_mask_v2);
 
+static void rtw89_pci_recovery_intr_mask_v3(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0;
+	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
+	rtwpci->intrs[0] = 0;
+	rtwpci->intrs[1] = 0;
+}
+
+static void rtw89_pci_default_intr_mask_v3(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	rtwpci->ind_intrs = B_BE_HCI_AXIDMA_INT_EN0 |
+			    B_BE_HS0_IND_INT_EN0;
+	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
+	rtwpci->intrs[0] = B_BE_RDU_CH1_INT_EN_V2 |
+			   B_BE_RDU_CH0_INT_EN_V2;
+	rtwpci->intrs[1] = B_BE_PCIE_RX_RX0P2_IMR0_V1 |
+			   B_BE_PCIE_RX_RPQ0_IMR0_V1;
+}
+
+static void rtw89_pci_low_power_intr_mask_v3(struct rtw89_dev *rtwdev)
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
+void rtw89_pci_config_intr_mask_v3(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+
+	if (rtwpci->under_recovery)
+		rtw89_pci_recovery_intr_mask_v3(rtwdev);
+	else if (rtwpci->low_power)
+		rtw89_pci_low_power_intr_mask_v3(rtwdev);
+	else
+		rtw89_pci_default_intr_mask_v3(rtwdev);
+}
+EXPORT_SYMBOL(rtw89_pci_config_intr_mask_v3);
+
 static int rtw89_pci_request_irq(struct rtw89_dev *rtwdev,
 				 struct pci_dev *pdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 14b1d388d46b..95da43627608 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -426,9 +426,13 @@
 #define B_BE_RDU_CH4_INT_IMR_V1 BIT(29)
 #define B_BE_RDU_CH3_INT_IMR_V1 BIT(28)
 #define B_BE_RDU_CH2_INT_IMR_V1 BIT(27)
+#define B_BE_RDU_CH1_INT_EN_V2 BIT(27)
 #define B_BE_RDU_CH1_INT_IMR_V1 BIT(26)
+#define B_BE_RDU_CH0_INT_EN_V2 BIT(26)
 #define B_BE_RDU_CH0_INT_IMR_V1 BIT(25)
+#define B_BE_RXDMA_STUCK_INT_EN_V2 BIT(25)
 #define B_BE_RXDMA_STUCK_INT_EN_V1 BIT(24)
+#define B_BE_TXDMA_STUCK_INT_EN_V2 BIT(24)
 #define B_BE_TXDMA_STUCK_INT_EN_V1 BIT(23)
 #define B_BE_TXDMA_CH14_INT_EN_V1 BIT(22)
 #define B_BE_TXDMA_CH13_INT_EN_V1 BIT(21)
@@ -459,9 +463,13 @@
 #define B_BE_RDU_CH4_INT_V1 BIT(29)
 #define B_BE_RDU_CH3_INT_V1 BIT(28)
 #define B_BE_RDU_CH2_INT_V1 BIT(27)
+#define B_BE_RDU_CH1_INT_V2 BIT(27)
 #define B_BE_RDU_CH1_INT_V1 BIT(26)
+#define B_BE_RDU_CH0_INT_V2 BIT(26)
 #define B_BE_RDU_CH0_INT_V1 BIT(25)
+#define B_BE_RXDMA_STUCK_INT_V2 BIT(25)
 #define B_BE_RXDMA_STUCK_INT_V1 BIT(24)
+#define B_BE_TXDMA_STUCK_INT_V2 BIT(24)
 #define B_BE_TXDMA_STUCK_INT_V1 BIT(23)
 #define B_BE_TXDMA_CH14_INT_V1 BIT(22)
 #define B_BE_TXDMA_CH13_INT_V1 BIT(21)
@@ -1633,6 +1641,7 @@ extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_dual[RTW89_TXCH_NUM];
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM];
 extern const struct rtw89_pci_isr_def rtw89_pci_isr_ax;
 extern const struct rtw89_pci_isr_def rtw89_pci_isr_be;
+extern const struct rtw89_pci_isr_def rtw89_pci_isr_be_v1;
 extern const struct rtw89_pci_gen_def rtw89_pci_gen_ax;
 extern const struct rtw89_pci_gen_def rtw89_pci_gen_be;
 
@@ -1655,12 +1664,15 @@ void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev);
 void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev);
 void rtw89_pci_config_intr_mask_v2(struct rtw89_dev *rtwdev);
+void rtw89_pci_config_intr_mask_v3(struct rtw89_dev *rtwdev);
 void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_enable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_disable_intr_v1(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_enable_intr_v2(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_disable_intr_v2(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_enable_intr_v3(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
+void rtw89_pci_disable_intr_v3(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
 void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
 			       struct rtw89_pci *rtwpci,
 			       struct rtw89_pci_isrs *isrs);
@@ -1670,6 +1682,9 @@ void rtw89_pci_recognize_intrs_v1(struct rtw89_dev *rtwdev,
 void rtw89_pci_recognize_intrs_v2(struct rtw89_dev *rtwdev,
 				  struct rtw89_pci *rtwpci,
 				  struct rtw89_pci_isrs *isrs);
+void rtw89_pci_recognize_intrs_v3(struct rtw89_dev *rtwdev,
+				  struct rtw89_pci *rtwpci,
+				  struct rtw89_pci_isrs *isrs);
 
 static inline
 u32 rtw89_chip_fill_txaddr_info(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 29ca58b86085..f4b9c98e4eb4 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -674,6 +674,15 @@ const struct rtw89_pci_isr_def rtw89_pci_isr_be = {
 };
 EXPORT_SYMBOL(rtw89_pci_isr_be);
 
+const struct rtw89_pci_isr_def rtw89_pci_isr_be_v1 = {
+	.isr_rdu = B_BE_RDU_CH1_INT_V2 | B_BE_RDU_CH0_INT_V2,
+	.isr_halt_c2h = B_BE_HALT_C2H_INT,
+	.isr_wdt_timeout = B_BE_WDT_TIMEOUT_INT,
+	.isr_clear_rpq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RPQ0_ISR_V1},
+	.isr_clear_rxq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RX0P2_ISR_V1},
+};
+EXPORT_SYMBOL(rtw89_pci_isr_be_v1);
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
 	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_be,
-- 
2.25.1


