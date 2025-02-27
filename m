Return-Path: <linux-wireless+bounces-19543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC236A47EE4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993B016646C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8FC22D4F4;
	Thu, 27 Feb 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rJEgUMM0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809B22171A
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662360; cv=none; b=LmOLyd4W9xLoOjH9r4Gv8v6blZxDOmQ7R1ent+qnywfyeabuH8ZkUuoOACz/0x5P+ai7cNIhDaFPVTFvGGGYQhVr1CaRlzgri9mipn5TUr90pFdWuGfRfGTtiTa2IUiMuYe7zIoB95O07kmJXpfcdmlBergTVOZa2O4wpf/vNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662360; c=relaxed/simple;
	bh=8iaANiQUcIrKmg8RSS5vK/SVRoIoax9oEZ8LsxQhRTw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ES8iZytbOdR3xEbH7LzvqgYoZmnE/KJVIW5Vt61NhqgMHfqFJAriiwTjCdy/WCth0AOGCTnpengEX65erGQPuEeqAdBfgxkYfe7zvOj6EKfANHCYdbzZKKyDkauhUlx/741vksfqdYYW3zr4POLO+biQxU8lgAHZM3gUeyQar8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rJEgUMM0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51RDJFHH02019264, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740662355; bh=8iaANiQUcIrKmg8RSS5vK/SVRoIoax9oEZ8LsxQhRTw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=rJEgUMM0QJ1VCVb8Vu1Jj6DdZFrXbXsmuaqosrqdL2qYo/+0166HbA5ozt/9Tn+x7
	 wjuxH/om1x05r81SkaPZp35zO2Fgry31nJC8wgyNC1ncU/3e3jqVHPl47p35uQPh2t
	 dFUh1N6/WSPzW1EDCJKA22PqlkC2ux7vqKZwn6QWEsLEXTZbIZfMJtc1qwWqx5CjaW
	 RFEmQaQ4TSivxm+waPJ2MtwANBgoPaoLNmdnSo6Gb9VPqL+IjwgGyZIxMo0xdGpW3c
	 cxRRhDoFvpr/h7OplBG2vKChkeYd5vn6e2WfuGR8uWjOChP4iZA2gwCuhpz9d6rVrx
	 vl01Rxdkmfqgw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51RDJFHH02019264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 21:19:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 21:19:13 +0800
Received: from [127.0.1.1] (172.16.24.143) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 21:19:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next] wifi: rtw89: pci: correct ISR RDU bit for 8922AE
Date: Thu, 27 Feb 2025 21:19:07 +0800
Message-ID: <20250227131907.9864-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

The interrupt status (ISR) bits of RX desc unavailable (RDU) for 8922AE
are B_BE_RDU_CH1_INT_V1 and B_BE_RDU_CH0_INT_V1. With wrong bits, if it
happens, driver can't recognize the situation and prompt a message.
Fix the definition accordingly.

Fixes: aa70f76120ee ("wifi: rtw89: pci: generalize interrupt status bits of interrupt handlers")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h    | 56 +++++++++++----------
 drivers/net/wireless/realtek/rtw89/pci_be.c |  2 +-
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 4d11c3dd60a5..79fef5f90140 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -455,34 +455,36 @@
 #define B_BE_RX0DMA_INT_EN BIT(0)
 
 #define R_BE_HAXI_HISR00 0xB0B4
-#define B_BE_RDU_CH6_INT BIT(28)
-#define B_BE_RDU_CH5_INT BIT(27)
-#define B_BE_RDU_CH4_INT BIT(26)
-#define B_BE_RDU_CH2_INT BIT(25)
-#define B_BE_RDU_CH1_INT BIT(24)
-#define B_BE_RDU_CH0_INT BIT(23)
-#define B_BE_RXDMA_STUCK_INT BIT(22)
-#define B_BE_TXDMA_STUCK_INT BIT(21)
-#define B_BE_TXDMA_CH14_INT BIT(20)
-#define B_BE_TXDMA_CH13_INT BIT(19)
-#define B_BE_TXDMA_CH12_INT BIT(18)
-#define B_BE_TXDMA_CH11_INT BIT(17)
-#define B_BE_TXDMA_CH10_INT BIT(16)
-#define B_BE_TXDMA_CH9_INT BIT(15)
-#define B_BE_TXDMA_CH8_INT BIT(14)
-#define B_BE_TXDMA_CH7_INT BIT(13)
-#define B_BE_TXDMA_CH6_INT BIT(12)
-#define B_BE_TXDMA_CH5_INT BIT(11)
-#define B_BE_TXDMA_CH4_INT BIT(10)
-#define B_BE_TXDMA_CH3_INT BIT(9)
-#define B_BE_TXDMA_CH2_INT BIT(8)
-#define B_BE_TXDMA_CH1_INT BIT(7)
-#define B_BE_TXDMA_CH0_INT BIT(6)
-#define B_BE_RPQ1DMA_INT BIT(5)
-#define B_BE_RX1P1DMA_INT BIT(4)
+#define B_BE_RDU_CH5_INT_V1 BIT(30)
+#define B_BE_RDU_CH4_INT_V1 BIT(29)
+#define B_BE_RDU_CH3_INT_V1 BIT(28)
+#define B_BE_RDU_CH2_INT_V1 BIT(27)
+#define B_BE_RDU_CH1_INT_V1 BIT(26)
+#define B_BE_RDU_CH0_INT_V1 BIT(25)
+#define B_BE_RXDMA_STUCK_INT_V1 BIT(24)
+#define B_BE_TXDMA_STUCK_INT_V1 BIT(23)
+#define B_BE_TXDMA_CH14_INT_V1 BIT(22)
+#define B_BE_TXDMA_CH13_INT_V1 BIT(21)
+#define B_BE_TXDMA_CH12_INT_V1 BIT(20)
+#define B_BE_TXDMA_CH11_INT_V1 BIT(19)
+#define B_BE_TXDMA_CH10_INT_V1 BIT(18)
+#define B_BE_TXDMA_CH9_INT_V1 BIT(17)
+#define B_BE_TXDMA_CH8_INT_V1 BIT(16)
+#define B_BE_TXDMA_CH7_INT_V1 BIT(15)
+#define B_BE_TXDMA_CH6_INT_V1 BIT(14)
+#define B_BE_TXDMA_CH5_INT_V1 BIT(13)
+#define B_BE_TXDMA_CH4_INT_V1 BIT(12)
+#define B_BE_TXDMA_CH3_INT_V1 BIT(11)
+#define B_BE_TXDMA_CH2_INT_V1 BIT(10)
+#define B_BE_TXDMA_CH1_INT_V1 BIT(9)
+#define B_BE_TXDMA_CH0_INT_V1 BIT(8)
+#define B_BE_RX1P1DMA_INT_V1 BIT(7)
+#define B_BE_RX0P1DMA_INT_V1 BIT(6)
+#define B_BE_RO1DMA_INT BIT(5)
+#define B_BE_RP1DMA_INT BIT(4)
 #define B_BE_RX1DMA_INT BIT(3)
-#define B_BE_RPQ0DMA_INT BIT(2)
-#define B_BE_RX0P1DMA_INT BIT(1)
+#define B_BE_RO0DMA_INT BIT(2)
+#define B_BE_RP0DMA_INT BIT(1)
 #define B_BE_RX0DMA_INT BIT(0)
 
 /* TX/RX */
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index cd39eebe8186..12e6a0cbb889 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -666,7 +666,7 @@ SIMPLE_DEV_PM_OPS(rtw89_pm_ops_be, rtw89_pci_suspend_be, rtw89_pci_resume_be);
 EXPORT_SYMBOL(rtw89_pm_ops_be);
 
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
-	.isr_rdu = B_BE_RDU_CH1_INT | B_BE_RDU_CH0_INT,
+	.isr_rdu = B_BE_RDU_CH1_INT_V1 | B_BE_RDU_CH0_INT_V1,
 	.isr_halt_c2h = B_BE_HALT_C2H_INT,
 	.isr_wdt_timeout = B_BE_WDT_TIMEOUT_INT,
 	.isr_clear_rpq = {R_BE_PCIE_DMA_ISR, B_BE_PCIE_RX_RPQ0_ISR_V1},
-- 
2.25.1


