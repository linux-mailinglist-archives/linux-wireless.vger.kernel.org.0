Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8B7D8226
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjJZMBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjJZMBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 08:01:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75040E5
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 05:01:37 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39QC1N5g82779656, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39QC1N5g82779656
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:01:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Oct 2023 20:01:24 +0800
Received: from [127.0.1.1] (172.16.17.48) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 26 Oct
 2023 20:01:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: pci: generalize code of PCI control DMA IO for WiFi 7
Date:   Thu, 26 Oct 2023 20:00:49 +0800
Message-ID: <20231026120049.9187-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026120049.9187-1-pkshih@realtek.com>
References: <20231026120049.9187-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.48]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The register to enable/disable PCI DMA IO has many variants, so define
and use a field to control it accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c       | 16 ++++------------
 drivers/net/wireless/realtek/rtw89/pci.h       |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851be.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c |  1 +
 7 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 13775c36a46b..b2de5280d934 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1750,21 +1750,13 @@ static void rtw89_pci_ctrl_dma_trx(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_pci_ctrl_dma_io(struct rtw89_dev *rtwdev, bool enable)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
-	u32 reg, mask;
-
-	if (chip_id == RTL8852C) {
-		reg = R_AX_HAXI_INIT_CFG1;
-		mask = B_AX_STOP_AXI_MST;
-	} else {
-		reg = R_AX_PCIE_DMA_STOP1;
-		mask = B_AX_STOP_PCIEIO;
-	}
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_reg_def *reg = &info->dma_io_stop;
 
 	if (enable)
-		rtw89_write32_clr(rtwdev, reg, mask);
+		rtw89_write32_clr(rtwdev, reg->addr, reg->mask);
 	else
-		rtw89_write32_set(rtwdev, reg, mask);
+		rtw89_write32_set(rtwdev, reg->addr, reg->mask);
 }
 
 static void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index e16507a5ec5a..fe1019ae5e5b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -947,6 +947,7 @@ struct rtw89_pci_info {
 	u32 max_tag_num_mask;
 	u32 rxbd_rwptr_clr_reg;
 	u32 txbd_rwptr_clr2_reg;
+	struct rtw89_reg_def dma_io_stop;
 	struct rtw89_reg_def dma_stop1;
 	struct rtw89_reg_def dma_stop2;
 	struct rtw89_reg_def dma_busy1;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 0f7711c50bd1..3b299778119a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -33,6 +33,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.max_tag_num_mask	= B_AX_MAX_TAG_NUM,
 	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR,
 	.txbd_rwptr_clr2_reg	= 0,
+	.dma_io_stop		= {R_AX_PCIE_DMA_STOP1, B_AX_STOP_PCIEIO},
 	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK_V1},
 	.dma_stop2		= {0},
 	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK_V1},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 5895a7019375..a40e87405dc8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -34,6 +34,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.max_tag_num_mask	= B_AX_MAX_TAG_NUM,
 	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR,
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2,
+	.dma_io_stop		= {R_AX_PCIE_DMA_STOP1, B_AX_STOP_PCIEIO},
 	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK},
 	.dma_stop2		= {R_AX_PCIE_DMA_STOP2, B_AX_TX_STOP2_ALL},
 	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 626a00dcddb6..9500ff9bb4aa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -34,6 +34,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.max_tag_num_mask	= B_AX_MAX_TAG_NUM,
 	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR,
 	.txbd_rwptr_clr2_reg	= 0,
+	.dma_io_stop		= {R_AX_PCIE_DMA_STOP1, B_AX_STOP_PCIEIO},
 	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK_V1},
 	.dma_stop2		= {0},
 	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK_V1},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 5d34e56d9106..5c84589fd50e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -43,6 +43,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.max_tag_num_mask	= B_AX_MAX_TAG_NUM_V1_MASK,
 	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR_V1,
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2_V1,
+	.dma_io_stop		= {R_AX_HAXI_INIT_CFG1, B_AX_STOP_AXI_MST},
 	.dma_stop1		= {R_AX_HAXI_DMA_STOP1, B_AX_TX_STOP1_MASK},
 	.dma_stop2		= {R_AX_HAXI_DMA_STOP2, B_AX_TX_STOP2_ALL},
 	.dma_busy1		= {R_AX_HAXI_DMA_BUSY1, DMA_BUSY1_CHECK},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index c0c720daece1..e55f25bafc6e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -33,6 +33,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.max_tag_num_mask	= B_BE_MAX_TAG_NUM_MASK,
 	.rxbd_rwptr_clr_reg	= R_BE_RXBD_RWPTR_CLR1_V1,
 	.txbd_rwptr_clr2_reg	= R_BE_TXBD_RWPTR_CLR1,
+	.dma_io_stop		= {R_BE_HAXI_INIT_CFG1, B_BE_STOP_AXI_MST},
 	.dma_stop1		= {R_BE_HAXI_DMA_STOP1, B_BE_TX_STOP1_MASK},
 	.dma_stop2		= {0},
 	.dma_busy1		= {R_BE_HAXI_DMA_BUSY1, DMA_BUSY1_CHECK_BE},
-- 
2.25.1

