Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9D5B5545
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 09:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiILHVQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 03:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiILHUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 03:20:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54D5832075
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 00:17:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28C7HMUZ0019203, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28C7HMUZ0019203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 12 Sep 2022 15:17:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 12 Sep 2022 15:17:43 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 12 Sep
 2022 15:17:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: pci: concentrate control function of TX DMA channel
Date:   Mon, 12 Sep 2022 15:17:06 +0800
Message-ID: <20220912071706.13619-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912071706.13619-1-pkshih@realtek.com>
References: <20220912071706.13619-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/12/2022 06:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTIgpFekyCAwMjozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Different chips use different register and mask for
tx dma channels, so concentrate them.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 31 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/pci.h      | 14 +++++++--
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  4 +--
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  4 +--
 4 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 7f348bcf640c8..ff33962747fa0 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -169,6 +169,23 @@ static int rtw89_pci_rxbd_info_update(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void rtw89_pci_ctrl_txdma_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_reg_def *dma_stop1 = &info->dma_stop1;
+	const struct rtw89_reg_def *dma_stop2 = &info->dma_stop2;
+
+	if (enable) {
+		rtw89_write32_clr(rtwdev, dma_stop1->addr, dma_stop1->mask);
+		if (dma_stop2->addr)
+			rtw89_write32_clr(rtwdev, dma_stop2->addr, dma_stop2->mask);
+	} else {
+		rtw89_write32_set(rtwdev, dma_stop1->addr, dma_stop1->mask);
+		if (dma_stop2->addr)
+			rtw89_write32_set(rtwdev, dma_stop2->addr, dma_stop2->mask);
+	}
+}
+
 static bool
 rtw89_skb_put_rx_data(struct rtw89_dev *rtwdev, bool fs, bool ls,
 		      struct sk_buff *new,
@@ -2443,7 +2460,7 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	rtw89_pci_set_dbg(rtwdev);
 	rtw89_pci_set_keep_reg(rtwdev);
 
-	rtw89_write32_set(rtwdev, info->dma_stop1_reg, B_AX_STOP_WPDMA);
+	rtw89_write32_set(rtwdev, info->dma_stop1.addr, B_AX_STOP_WPDMA);
 
 	/* stop DMA activities */
 	rtw89_pci_ctrl_dma_all(rtwdev, false);
@@ -2466,10 +2483,9 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	/* enable FW CMD queue to download firmware */
-	rtw89_write32_set(rtwdev, info->dma_stop1_reg, B_AX_TX_STOP1_ALL);
-	rtw89_write32_clr(rtwdev, info->dma_stop1_reg, B_AX_STOP_CH12);
-	rtw89_write32_set(rtwdev, info->dma_stop2_reg, B_AX_TX_STOP2_ALL);
+	/* disable all channels except to FW CMD channel to download firmware */
+	rtw89_pci_ctrl_txdma_ch_pcie(rtwdev, false);
+	rtw89_write32_clr(rtwdev, info->dma_stop1.addr, B_AX_STOP_CH12);
 
 	/* start DMA activities */
 	rtw89_pci_ctrl_dma_all(rtwdev, true);
@@ -2582,11 +2598,10 @@ static int rtw89_pci_ops_mac_post_init(struct rtw89_dev *rtwdev)
 	}
 
 	/* enable DMA for all queues */
-	rtw89_write32_clr(rtwdev, info->dma_stop1_reg, B_AX_TX_STOP1_ALL);
-	rtw89_write32_clr(rtwdev, info->dma_stop2_reg, B_AX_TX_STOP2_ALL);
+	rtw89_pci_ctrl_txdma_ch_pcie(rtwdev, true);
 
 	/* Release PCI IO */
-	rtw89_write32_clr(rtwdev, info->dma_stop1_reg,
+	rtw89_write32_clr(rtwdev, info->dma_stop1.addr,
 			  B_AX_STOP_WPDMA | B_AX_STOP_PCIEIO);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 1365bbb547989..af6f6d5c47706 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -410,6 +410,16 @@
 #define B_AX_STOP_RPQ			BIT(1)
 #define B_AX_STOP_RXQ			BIT(0)
 #define B_AX_TX_STOP1_ALL		GENMASK(18, 8)
+#define B_AX_TX_STOP1_MASK		(B_AX_STOP_ACH0 | B_AX_STOP_ACH1 | \
+					 B_AX_STOP_ACH2 | B_AX_STOP_ACH3 | \
+					 B_AX_STOP_ACH4 | B_AX_STOP_ACH5 | \
+					 B_AX_STOP_ACH6 | B_AX_STOP_ACH7 | \
+					 B_AX_STOP_CH8 | B_AX_STOP_CH9 | \
+					 B_AX_STOP_CH12)
+#define B_AX_TX_STOP1_MASK_V1		(B_AX_STOP_ACH0 | B_AX_STOP_ACH1 | \
+					 B_AX_STOP_ACH2 | B_AX_STOP_ACH3 | \
+					 B_AX_STOP_CH8 | B_AX_STOP_CH9 | \
+					 B_AX_STOP_CH12)
 
 #define R_AX_PCIE_DMA_STOP2	0x1310
 #define B_AX_STOP_CH11			BIT(1)
@@ -742,8 +752,8 @@ struct rtw89_pci_info {
 	u32 max_tag_num_mask;
 	u32 rxbd_rwptr_clr_reg;
 	u32 txbd_rwptr_clr2_reg;
-	u32 dma_stop1_reg;
-	u32 dma_stop2_reg;
+	struct rtw89_reg_def dma_stop1;
+	struct rtw89_reg_def dma_stop2;
 	u32 dma_busy1_reg;
 	u32 dma_busy2_reg;
 	u32 dma_busy3_reg;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 190c4aefb02e3..d600100db9eb4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -33,8 +33,8 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.max_tag_num_mask	= B_AX_MAX_TAG_NUM,
 	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR,
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2,
-	.dma_stop1_reg		= R_AX_PCIE_DMA_STOP1,
-	.dma_stop2_reg		= R_AX_PCIE_DMA_STOP2,
+	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK},
+	.dma_stop2		= {R_AX_PCIE_DMA_STOP2, B_AX_TX_STOP2_ALL},
 	.dma_busy1_reg		= R_AX_PCIE_DMA_BUSY1,
 	.dma_busy2_reg		= R_AX_PCIE_DMA_BUSY2,
 	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index fc03944940130..be6b4e4d64914 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -42,8 +42,8 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.max_tag_num_mask	= B_AX_MAX_TAG_NUM_V1_MASK,
 	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR_V1,
 	.txbd_rwptr_clr2_reg	= R_AX_TXBD_RWPTR_CLR2_V1,
-	.dma_stop1_reg		= R_AX_HAXI_DMA_STOP1,
-	.dma_stop2_reg		= R_AX_HAXI_DMA_STOP2,
+	.dma_stop1		= {R_AX_HAXI_DMA_STOP1, B_AX_TX_STOP1_MASK},
+	.dma_stop2		= {R_AX_HAXI_DMA_STOP2, B_AX_TX_STOP2_ALL},
 	.dma_busy1_reg		= R_AX_HAXI_DMA_BUSY1,
 	.dma_busy2_reg		= R_AX_HAXI_DMA_BUSY2,
 	.dma_busy3_reg		= R_AX_HAXI_DMA_BUSY3,
-- 
2.25.1

