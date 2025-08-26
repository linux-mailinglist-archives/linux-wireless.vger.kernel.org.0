Return-Path: <linux-wireless+bounces-26617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E0B357AD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B14934E3EFC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5F1BC3F;
	Tue, 26 Aug 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pe4Nqx9x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776CA1B6D08
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198396; cv=none; b=g7huQWkeHEkHpSPRobP2HwqLQnalvUCiSVP82y5Z4k3hITaJ+E1pRo9AHCL5PgjhrB+QhfMUuPxDknNV5mxhylrF0ei5Duabs0XDlEhpQBQ4FCFUbqEGWTw3wrQFNkvDDGFhXauKmyVXxA9R+NLQcUfFhxfZ9o+NIVi9gYWLfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198396; c=relaxed/simple;
	bh=+37raBK0nSA/Xhlw/E9XBvf2DRgrEPeoSHHCo9IfkQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8C25fuRVuuj+IIYmpXAFdLqIuDg4y8vKe9OifeXoWNrZRZi5t3td+BkAz7TNRLsRrCMu6b79Y5J3AOB+ZbbASUK06zSWXmZdmL4t5aND106lT+r3n01YJYGOv4n2bARx5RyNq8AGZP4nAYpOwZ4Djlj+xm5RERPAldG2kaDt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pe4Nqx9x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8rBq651261956, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198392; bh=TLGJ5m3AxHrth9jacVedbx7mwHNxFO5fk+slPcXcR+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pe4Nqx9xswuD1ElLhANBbc13zlzEzfL56ceQg6xlGPbahl6DXDAvPa2S4g9Lf/h5I
	 qAsL5r1I9UFLRqOwTaPFFt1o+7piyihAJaxlwPJ84Kdc5q3+li0e8nSu5Ad7aT34X6
	 5K3o4dHRn3aDAROsNve07yUQDZADAXcgRskVWt7wKL76b5wBZgpK3ODVhkV2Ky5p3U
	 FyLODHQP8SykKkv5gvfD+amP5bflJqDTk6K/0K6+w216LDCCmpcXbGqUo9J6a3gPEo
	 7dqSf7DkpR4nUGRG5noZNAPQuV6HY0j9oq1NEeud9z49XTugmuSDWz6XYsUdxb6pMH
	 ooTguqTh+KMJA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8rBq651261956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:53:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:53:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:53:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 03/10] wifi: rtw89: pci: use RDU status of R_BE_PCIE_DMA_IMR_0_V1 instead for 8922DE
Date: Tue, 26 Aug 2025 16:51:45 +0800
Message-ID: <20250826085152.28164-4-pkshih@realtek.com>
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

The original RDU status of R_BE_HAXI_HIMR00 needs additional IO to get
the status. The new WiFi 7 8922DE add the status to R_BE_PCIE_DMA_IMR_0_V1
which is read already, so we can reduce one reading IO.

After the changes, interrupt behavior of RTL8922DE in low power mode is
the same as normal mode, so remove the configuration function for low
power mode.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 33 +++++++--------------
 drivers/net/wireless/realtek/rtw89/pci.h    | 16 ++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  2 +-
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0153977d4cf2..e3fbe43a95ea 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -804,14 +804,16 @@ void rtw89_pci_recognize_intrs_v3(struct rtw89_dev *rtwdev,
 	isrs->ind_isrs = rtw89_read32(rtwdev, R_BE_PCIE_HISR) & rtwpci->ind_intrs;
 	isrs->halt_c2h_isrs = isrs->ind_isrs & B_BE_HS0ISR_IND_INT ?
 			      rtw89_read32(rtwdev, R_BE_HISR0) & rtwpci->halt_c2h_intrs : 0;
-	isrs->isrs[0] = isrs->ind_isrs & B_BE_HCI_AXIDMA_INT ?
-			rtw89_read32(rtwdev, R_BE_HAXI_HISR00) & rtwpci->intrs[0] : 0;
 	isrs->isrs[1] = rtw89_read32(rtwdev, R_BE_PCIE_DMA_ISR) & rtwpci->intrs[1];
 
+	/* isrs[0] is not used, so borrow to store RDU status to share common
+	 * flow in rtw89_pci_interrupt_threadfn().
+	 */
+	isrs->isrs[0] = isrs->isrs[1] & (B_BE_PCIE_RDU_CH1_INT |
+					 B_BE_PCIE_RDU_CH0_INT);
+
 	if (isrs->halt_c2h_isrs)
 		rtw89_write32(rtwdev, R_BE_HISR0, isrs->halt_c2h_isrs);
-	if (isrs->isrs[0])
-		rtw89_write32(rtwdev, R_BE_HAXI_HISR00, isrs->isrs[0]);
 	if (isrs->isrs[1])
 		rtw89_write32(rtwdev, R_BE_PCIE_DMA_ISR, isrs->isrs[1]);
 	rtw89_write32(rtwdev, R_BE_PCIE_HISR, isrs->ind_isrs);
@@ -868,7 +870,6 @@ EXPORT_SYMBOL(rtw89_pci_disable_intr_v2);
 void rtw89_pci_enable_intr_v3(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci)
 {
 	rtw89_write32(rtwdev, R_BE_HIMR0, rtwpci->halt_c2h_intrs);
-	rtw89_write32(rtwdev, R_BE_HAXI_HIMR00, rtwpci->intrs[0]);
 	rtw89_write32(rtwdev, R_BE_PCIE_DMA_IMR_0_V1, rtwpci->intrs[1]);
 	rtw89_write32(rtwdev, R_BE_PCIE_HIMR0, rtwpci->ind_intrs);
 }
@@ -3827,24 +3828,12 @@ static void rtw89_pci_default_intr_mask_v3(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 
-	rtwpci->ind_intrs = B_BE_HCI_AXIDMA_INT_EN0 |
-			    B_BE_HS0_IND_INT_EN0;
-	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
-	rtwpci->intrs[0] = B_BE_RDU_CH1_INT_EN_V2 |
-			   B_BE_RDU_CH0_INT_EN_V2;
-	rtwpci->intrs[1] = B_BE_PCIE_RX_RX0P2_IMR0_V1 |
-			   B_BE_PCIE_RX_RPQ0_IMR0_V1;
-}
-
-static void rtw89_pci_low_power_intr_mask_v3(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
-
-	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0 |
-			    B_BE_HS1_IND_INT_EN0;
+	rtwpci->ind_intrs = B_BE_HS0_IND_INT_EN0;
 	rtwpci->halt_c2h_intrs = B_BE_HALT_C2H_INT_EN | B_BE_WDT_TIMEOUT_INT_EN;
 	rtwpci->intrs[0] = 0;
-	rtwpci->intrs[1] = B_BE_PCIE_RX_RX0P2_IMR0_V1 |
+	rtwpci->intrs[1] = B_BE_PCIE_RDU_CH1_IMR |
+			   B_BE_PCIE_RDU_CH0_IMR |
+			   B_BE_PCIE_RX_RX0P2_IMR0_V1 |
 			   B_BE_PCIE_RX_RPQ0_IMR0_V1;
 }
 
@@ -3854,8 +3843,6 @@ void rtw89_pci_config_intr_mask_v3(struct rtw89_dev *rtwdev)
 
 	if (rtwpci->under_recovery)
 		rtw89_pci_recovery_intr_mask_v3(rtwdev);
-	else if (rtwpci->low_power)
-		rtw89_pci_low_power_intr_mask_v3(rtwdev);
 	else
 		rtw89_pci_default_intr_mask_v3(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 95da43627608..6558f60ec914 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -372,6 +372,14 @@
 #define B_BE_HS0ISR_IND_INT BIT(0)
 
 #define R_BE_PCIE_DMA_IMR_0_V1 0x30B8
+#define B_BE_PCIE_RDU_CH7_IMR BIT(31)
+#define B_BE_PCIE_RDU_CH6_IMR BIT(30)
+#define B_BE_PCIE_RDU_CH5_IMR BIT(29)
+#define B_BE_PCIE_RDU_CH4_IMR BIT(28)
+#define B_BE_PCIE_RDU_CH3_IMR BIT(27)
+#define B_BE_PCIE_RDU_CH2_IMR BIT(26)
+#define B_BE_PCIE_RDU_CH1_IMR BIT(25)
+#define B_BE_PCIE_RDU_CH0_IMR BIT(24)
 #define B_BE_PCIE_RX_RX1P1_IMR0_V1 BIT(23)
 #define B_BE_PCIE_RX_RX0P1_IMR0_V1 BIT(22)
 #define B_BE_PCIE_RX_ROQ1_IMR0_V1 BIT(21)
@@ -397,6 +405,14 @@
 #define B_BE_PCIE_TX_CH0_IMR0 BIT(0)
 
 #define R_BE_PCIE_DMA_ISR 0x30BC
+#define B_BE_PCIE_RDU_CH7_INT BIT(31)
+#define B_BE_PCIE_RDU_CH6_INT BIT(30)
+#define B_BE_PCIE_RDU_CH5_INT BIT(29)
+#define B_BE_PCIE_RDU_CH4_INT BIT(28)
+#define B_BE_PCIE_RDU_CH3_INT BIT(27)
+#define B_BE_PCIE_RDU_CH2_INT BIT(26)
+#define B_BE_PCIE_RDU_CH1_INT BIT(25)
+#define B_BE_PCIE_RDU_CH0_INT BIT(24)
 #define B_BE_PCIE_RX_RX1P1_ISR_V1 BIT(23)
 #define B_BE_PCIE_RX_RX0P1_ISR_V1 BIT(22)
 #define B_BE_PCIE_RX_ROQ1_ISR_V1 BIT(21)
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index f4b9c98e4eb4..ecfe1b60e847 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -675,7 +675,7 @@ const struct rtw89_pci_isr_def rtw89_pci_isr_be = {
 EXPORT_SYMBOL(rtw89_pci_isr_be);
 
 const struct rtw89_pci_isr_def rtw89_pci_isr_be_v1 = {
-	.isr_rdu = B_BE_RDU_CH1_INT_V2 | B_BE_RDU_CH0_INT_V2,
+	.isr_rdu = B_BE_PCIE_RDU_CH1_INT | B_BE_PCIE_RDU_CH0_INT,
 	.isr_halt_c2h = B_BE_HALT_C2H_INT,
 	.isr_wdt_timeout = B_BE_WDT_TIMEOUT_INT,
 	.isr_clear_rpq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RPQ0_ISR_V1},
-- 
2.25.1


