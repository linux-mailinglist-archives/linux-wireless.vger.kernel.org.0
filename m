Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46C5E746B
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIWGyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 02:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIWGyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 02:54:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 565C712968A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 23:54:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28N6rWXF1020798, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28N6rWXF1020798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 23 Sep 2022 14:53:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 14:53:56 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 23 Sep
 2022 14:53:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/9] wifi: rtw89: add DMA busy checking bits to chip info
Date:   Fri, 23 Sep 2022 14:53:05 +0800
Message-ID: <20220923065311.123356-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923065311.123356-1-pkshih@realtek.com>
References: <20220923065311.123356-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/23/2022 06:38:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjMgpFekyCAwMzozMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

8852B has less DMA channels, so its checking bits are different from other
chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c       | 10 +++++-----
 drivers/net/wireless/realtek/rtw89/pci.h       |  9 ++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c |  6 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c |  2 +-
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 002d3ce0e35b2..957f4e550a7ef 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2272,19 +2272,19 @@ static int rtw89_poll_txdma_ch_idle_pcie(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	u32 ret, check, dma_busy;
-	u32 dma_busy1 = info->dma_busy1_reg;
+	u32 dma_busy1 = info->dma_busy1.addr;
 	u32 dma_busy2 = info->dma_busy2_reg;
 
-	check = B_AX_ACH0_BUSY | B_AX_ACH1_BUSY | B_AX_ACH2_BUSY |
-		B_AX_ACH3_BUSY | B_AX_ACH4_BUSY | B_AX_ACH5_BUSY |
-		B_AX_ACH6_BUSY | B_AX_ACH7_BUSY | B_AX_CH8_BUSY |
-		B_AX_CH9_BUSY | B_AX_CH12_BUSY;
+	check = info->dma_busy1.mask;
 
 	ret = read_poll_timeout(rtw89_read32, dma_busy, (dma_busy & check) == 0,
 				10, 100, false, rtwdev, dma_busy1);
 	if (ret)
 		return ret;
 
+	if (!dma_busy2)
+		return 0;
+
 	check = B_AX_CH10_BUSY | B_AX_CH11_BUSY;
 
 	ret = read_poll_timeout(rtw89_read32, dma_busy, (dma_busy & check) == 0,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 391058de47ec5..e49ffc9cf7903 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -468,6 +468,13 @@
 #define B_AX_ACH0_BUSY			BIT(8)
 #define B_AX_RPQ_BUSY			BIT(1)
 #define B_AX_RXQ_BUSY			BIT(0)
+#define DMA_BUSY1_CHECK		(B_AX_ACH0_BUSY | B_AX_ACH1_BUSY | B_AX_ACH2_BUSY | \
+				 B_AX_ACH3_BUSY | B_AX_ACH4_BUSY | B_AX_ACH5_BUSY | \
+				 B_AX_ACH6_BUSY | B_AX_ACH7_BUSY | B_AX_CH8_BUSY | \
+				 B_AX_CH9_BUSY | B_AX_CH12_BUSY)
+#define DMA_BUSY1_CHECK_V1	(B_AX_ACH0_BUSY | B_AX_ACH1_BUSY | B_AX_ACH2_BUSY | \
+				 B_AX_ACH3_BUSY | B_AX_CH8_BUSY | B_AX_CH9_BUSY | \
+				 B_AX_CH12_BUSY)
 
 #define R_AX_PCIE_DMA_BUSY2	0x131C
 #define B_AX_CH11_BUSY			BIT(1)
@@ -754,7 +761,7 @@ struct rtw89_pci_info {
 	u32 txbd_rwptr_clr2_reg;
 	struct rtw89_reg_def dma_stop1;
 	struct rtw89_reg_def dma_stop2;
-	u32 dma_busy1_reg;
+	struct rtw89_reg_def dma_busy1;
 	u32 dma_busy2_reg;
 	u32 dma_busy3_reg;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 48485bd9c149f..0cd8c0c44d19d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -35,7 +35,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2,
 	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK},
 	.dma_stop2		= {R_AX_PCIE_DMA_STOP2, B_AX_TX_STOP2_ALL},
-	.dma_busy1_reg		= R_AX_PCIE_DMA_BUSY1,
+	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK},
 	.dma_busy2_reg		= R_AX_PCIE_DMA_BUSY2,
 	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 4590535841be3..7bf95c38d3eb2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -9,6 +9,12 @@
 #include "reg.h"
 
 static const struct rtw89_pci_info rtw8852b_pci_info = {
+	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK_V1},
+	.dma_stop2		= {0},
+	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK_V1},
+	.dma_busy2_reg		= 0,
+	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
+
 	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
 				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
 				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index c7370f5df8b54..35901f64d17de 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -44,7 +44,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2_V1,
 	.dma_stop1		= {R_AX_HAXI_DMA_STOP1, B_AX_TX_STOP1_MASK},
 	.dma_stop2		= {R_AX_HAXI_DMA_STOP2, B_AX_TX_STOP2_ALL},
-	.dma_busy1_reg		= R_AX_HAXI_DMA_BUSY1,
+	.dma_busy1		= {R_AX_HAXI_DMA_BUSY1, DMA_BUSY1_CHECK},
 	.dma_busy2_reg		= R_AX_HAXI_DMA_BUSY2,
 	.dma_busy3_reg		= R_AX_HAXI_DMA_BUSY3,
 
-- 
2.25.1

