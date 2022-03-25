Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4190A4E6E02
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358398AbiCYGDs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358389AbiCYGDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5F8C6822
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P620o24011020, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P620o24011020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:00 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:01:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 02/16] rtw89: pci: add pci attributes to configure operating mode
Date:   Fri, 25 Mar 2022 14:00:41 +0800
Message-ID: <20220325060055.58482-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Refine operating mode function to support variant chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 133 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.h      | 114 +++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  15 ++
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  15 ++
 4 files changed, 262 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 2395a29c176f5..e064d355250ce 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1917,6 +1917,33 @@ static void rtw89_pci_set_sic(struct rtw89_dev *rtwdev)
 			  B_AX_SIC_EN_FORCE_CLKREQ);
 }
 
+static void rtw89_pci_set_io_rcy(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 val32;
+
+	if (rtwdev->chip->chip_id != RTL8852C)
+		return;
+
+	if (info->io_rcy_en == MAC_AX_PCIE_ENABLE) {
+		val32 = FIELD_PREP(B_AX_PCIE_WDT_TIMER_M1_MASK,
+				   info->io_rcy_tmr);
+		rtw89_write32(rtwdev, R_AX_PCIE_WDT_TIMER_M1, val32);
+		rtw89_write32(rtwdev, R_AX_PCIE_WDT_TIMER_M2, val32);
+		rtw89_write32(rtwdev, R_AX_PCIE_WDT_TIMER_E0, val32);
+
+		rtw89_write32_set(rtwdev, R_AX_PCIE_IO_RCY_M1, B_AX_PCIE_IO_RCY_WDT_MODE_M1);
+		rtw89_write32_set(rtwdev, R_AX_PCIE_IO_RCY_M2, B_AX_PCIE_IO_RCY_WDT_MODE_M2);
+		rtw89_write32_set(rtwdev, R_AX_PCIE_IO_RCY_E0, B_AX_PCIE_IO_RCY_WDT_MODE_E0);
+	} else {
+		rtw89_write32_clr(rtwdev, R_AX_PCIE_IO_RCY_M1, B_AX_PCIE_IO_RCY_WDT_MODE_M1);
+		rtw89_write32_clr(rtwdev, R_AX_PCIE_IO_RCY_M2, B_AX_PCIE_IO_RCY_WDT_MODE_M2);
+		rtw89_write32_clr(rtwdev, R_AX_PCIE_IO_RCY_E0, B_AX_PCIE_IO_RCY_WDT_MODE_E0);
+	}
+
+	rtw89_write32_clr(rtwdev, R_AX_PCIE_IO_RCY_S1, B_AX_PCIE_IO_RCY_WDT_MODE_S1);
+}
+
 static void rtw89_pci_set_dbg(struct rtw89_dev *rtwdev)
 {
 	if (rtwdev->chip->chip_id == RTL8852C)
@@ -1952,6 +1979,95 @@ static void rtw89_pci_clr_idx_all(struct rtw89_dev *rtwdev)
 			  B_AX_CLR_RXQ_IDX | B_AX_CLR_RPQ_IDX);
 }
 
+static int rtw89_pci_mode_op(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	enum mac_ax_bd_trunc_mode txbd_trunc_mode = info->txbd_trunc_mode;
+	enum mac_ax_bd_trunc_mode rxbd_trunc_mode = info->rxbd_trunc_mode;
+	enum mac_ax_rxbd_mode rxbd_mode = info->rxbd_mode;
+	enum mac_ax_tag_mode tag_mode = info->tag_mode;
+	enum mac_ax_wd_dma_intvl wd_dma_idle_intvl = info->wd_dma_idle_intvl;
+	enum mac_ax_wd_dma_intvl wd_dma_act_intvl = info->wd_dma_act_intvl;
+	enum mac_ax_tx_burst tx_burst = info->tx_burst;
+	enum mac_ax_rx_burst rx_burst = info->rx_burst;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u8 cv = rtwdev->hal.cv;
+	u32 val32;
+
+	if (txbd_trunc_mode == MAC_AX_BD_TRUNC) {
+		if (chip_id == RTL8852A && cv == CHIP_CBV)
+			rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_TX_TRUNC_MODE);
+	} else if (txbd_trunc_mode == MAC_AX_BD_NORM) {
+		if (chip_id == RTL8852A || chip_id == RTL8852B)
+			rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_TX_TRUNC_MODE);
+	}
+
+	if (rxbd_trunc_mode == MAC_AX_BD_TRUNC) {
+		if (chip_id == RTL8852A && cv == CHIP_CBV)
+			rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_RX_TRUNC_MODE);
+	} else if (rxbd_trunc_mode == MAC_AX_BD_NORM) {
+		if (chip_id == RTL8852A || chip_id == RTL8852B)
+			rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_RX_TRUNC_MODE);
+	}
+
+	if (rxbd_mode == MAC_AX_RXBD_PKT) {
+		rtw89_write32_clr(rtwdev, info->init_cfg_reg, info->rxbd_mode_bit);
+	} else if (rxbd_mode == MAC_AX_RXBD_SEP) {
+		rtw89_write32_set(rtwdev, info->init_cfg_reg, info->rxbd_mode_bit);
+
+		if (chip_id == RTL8852A || chip_id == RTL8852B)
+			rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG2,
+					   B_AX_PCIE_RX_APPLEN_MASK, 0);
+	}
+
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_PCIE_MAX_TXDMA_MASK, tx_burst);
+		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_PCIE_MAX_RXDMA_MASK, rx_burst);
+	} else if (chip_id == RTL8852C) {
+		rtw89_write32_mask(rtwdev, R_AX_HAXI_INIT_CFG1, B_AX_HAXI_MAX_TXDMA_MASK, tx_burst);
+		rtw89_write32_mask(rtwdev, R_AX_HAXI_INIT_CFG1, B_AX_HAXI_MAX_RXDMA_MASK, rx_burst);
+	}
+
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		if (tag_mode == MAC_AX_TAG_SGL) {
+			val32 = rtw89_read32(rtwdev, R_AX_PCIE_INIT_CFG1) &
+					    ~B_AX_LATENCY_CONTROL;
+			rtw89_write32(rtwdev, R_AX_PCIE_INIT_CFG1, val32);
+		} else if (tag_mode == MAC_AX_TAG_MULTI) {
+			val32 = rtw89_read32(rtwdev, R_AX_PCIE_INIT_CFG1) |
+					    B_AX_LATENCY_CONTROL;
+			rtw89_write32(rtwdev, R_AX_PCIE_INIT_CFG1, val32);
+		}
+	}
+
+	rtw89_write32_mask(rtwdev, info->exp_ctrl_reg, info->max_tag_num_mask,
+			   info->multi_tag_num);
+
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG2, B_AX_WD_ITVL_IDLE,
+				   wd_dma_idle_intvl);
+		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG2, B_AX_WD_ITVL_ACT,
+				   wd_dma_act_intvl);
+	} else if (chip_id == RTL8852C) {
+		rtw89_write32_mask(rtwdev, R_AX_HAXI_INIT_CFG1, B_AX_WD_ITVL_IDLE_V1_MASK,
+				   wd_dma_idle_intvl);
+		rtw89_write32_mask(rtwdev, R_AX_HAXI_INIT_CFG1, B_AX_WD_ITVL_ACT_V1_MASK,
+				   wd_dma_act_intvl);
+	}
+
+	if (txbd_trunc_mode == MAC_AX_BD_TRUNC) {
+		rtw89_write32_set(rtwdev, R_AX_TX_ADDRESS_INFO_MODE_SETTING,
+				  B_AX_HOST_ADDR_INFO_8B_SEL);
+		rtw89_write32_clr(rtwdev, R_AX_PKTIN_SETTING, B_AX_WD_ADDR_INFO_LENGTH);
+	} else if (txbd_trunc_mode == MAC_AX_BD_NORM) {
+		rtw89_write32_clr(rtwdev, R_AX_TX_ADDRESS_INFO_MODE_SETTING,
+				  B_AX_HOST_ADDR_INFO_8B_SEL);
+		rtw89_write32_set(rtwdev, R_AX_PKTIN_SETTING, B_AX_WD_ADDR_INFO_LENGTH);
+	}
+
+	return 0;
+}
+
 static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
 	if (rtwdev->chip->chip_id == RTL8852A) {
@@ -1995,6 +2111,7 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	rtw89_pci_autoload_hang(rtwdev);
 	rtw89_pci_l12_vmain(rtwdev);
 	rtw89_pci_set_sic(rtwdev);
+	rtw89_pci_set_io_rcy(rtwdev);
 	rtw89_pci_set_dbg(rtwdev);
 
 	if (rtwdev->chip->chip_id == RTL8852A) {
@@ -2025,21 +2142,7 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	}
 
 	rtw89_pci_clr_idx_all(rtwdev);
-
-	/* configure TX/RX op modes */
-	rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_TX_TRUNC_MODE |
-						       B_AX_RX_TRUNC_MODE);
-	rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_RXBD_MODE);
-	rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_PCIE_MAX_TXDMA_MASK, 7);
-	rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_PCIE_MAX_RXDMA_MASK, 3);
-	/* multi-tag mode */
-	rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_LATENCY_CONTROL);
-	rtw89_write32_mask(rtwdev, R_AX_PCIE_EXP_CTRL, B_AX_MAX_TAG_NUM,
-			   RTW89_MAC_TAG_NUM_8);
-	rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG2, B_AX_WD_ITVL_IDLE,
-			   RTW89_MAC_WD_DMA_INTVL_256NS);
-	rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG2, B_AX_WD_ITVL_ACT,
-			   RTW89_MAC_WD_DMA_INTVL_256NS);
+	rtw89_pci_mode_op(rtwdev);
 
 	/* fill TRX BD indexes */
 	rtw89_pci_ops_reset(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 8eabeaeec045f..8d49033fa270e 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -490,6 +490,105 @@ enum rtw89_pcie_clkdly_hw {
 	PCIE_CLKDLY_HW_200US = 0x5,
 };
 
+enum mac_ax_bd_trunc_mode {
+	MAC_AX_BD_NORM,
+	MAC_AX_BD_TRUNC,
+	MAC_AX_BD_DEF = 0xFE
+};
+
+enum mac_ax_rxbd_mode {
+	MAC_AX_RXBD_PKT,
+	MAC_AX_RXBD_SEP,
+	MAC_AX_RXBD_DEF = 0xFE
+};
+
+enum mac_ax_tag_mode {
+	MAC_AX_TAG_SGL,
+	MAC_AX_TAG_MULTI,
+	MAC_AX_TAG_DEF = 0xFE
+};
+
+enum mac_ax_tx_burst {
+	MAC_AX_TX_BURST_16B = 0,
+	MAC_AX_TX_BURST_32B = 1,
+	MAC_AX_TX_BURST_64B = 2,
+	MAC_AX_TX_BURST_V1_64B = 0,
+	MAC_AX_TX_BURST_128B = 3,
+	MAC_AX_TX_BURST_V1_128B = 1,
+	MAC_AX_TX_BURST_256B = 4,
+	MAC_AX_TX_BURST_V1_256B = 2,
+	MAC_AX_TX_BURST_512B = 5,
+	MAC_AX_TX_BURST_1024B = 6,
+	MAC_AX_TX_BURST_2048B = 7,
+	MAC_AX_TX_BURST_DEF = 0xFE
+};
+
+enum mac_ax_rx_burst {
+	MAC_AX_RX_BURST_16B = 0,
+	MAC_AX_RX_BURST_32B = 1,
+	MAC_AX_RX_BURST_64B = 2,
+	MAC_AX_RX_BURST_V1_64B = 0,
+	MAC_AX_RX_BURST_128B = 3,
+	MAC_AX_RX_BURST_V1_128B = 1,
+	MAC_AX_RX_BURST_V1_256B = 0,
+	MAC_AX_RX_BURST_DEF = 0xFE
+};
+
+enum mac_ax_wd_dma_intvl {
+	MAC_AX_WD_DMA_INTVL_0S,
+	MAC_AX_WD_DMA_INTVL_256NS,
+	MAC_AX_WD_DMA_INTVL_512NS,
+	MAC_AX_WD_DMA_INTVL_768NS,
+	MAC_AX_WD_DMA_INTVL_1US,
+	MAC_AX_WD_DMA_INTVL_1_5US,
+	MAC_AX_WD_DMA_INTVL_2US,
+	MAC_AX_WD_DMA_INTVL_4US,
+	MAC_AX_WD_DMA_INTVL_8US,
+	MAC_AX_WD_DMA_INTVL_16US,
+	MAC_AX_WD_DMA_INTVL_DEF = 0xFE
+};
+
+enum mac_ax_multi_tag_num {
+	MAC_AX_TAG_NUM_1,
+	MAC_AX_TAG_NUM_2,
+	MAC_AX_TAG_NUM_3,
+	MAC_AX_TAG_NUM_4,
+	MAC_AX_TAG_NUM_5,
+	MAC_AX_TAG_NUM_6,
+	MAC_AX_TAG_NUM_7,
+	MAC_AX_TAG_NUM_8,
+	MAC_AX_TAG_NUM_DEF = 0xFE
+};
+
+enum mac_ax_lbc_tmr {
+	MAC_AX_LBC_TMR_8US = 0,
+	MAC_AX_LBC_TMR_16US,
+	MAC_AX_LBC_TMR_32US,
+	MAC_AX_LBC_TMR_64US,
+	MAC_AX_LBC_TMR_128US,
+	MAC_AX_LBC_TMR_256US,
+	MAC_AX_LBC_TMR_512US,
+	MAC_AX_LBC_TMR_1MS,
+	MAC_AX_LBC_TMR_2MS,
+	MAC_AX_LBC_TMR_4MS,
+	MAC_AX_LBC_TMR_8MS,
+	MAC_AX_LBC_TMR_DEF = 0xFE
+};
+
+enum mac_ax_pcie_func_ctrl {
+	MAC_AX_PCIE_DISABLE = 0,
+	MAC_AX_PCIE_ENABLE = 1,
+	MAC_AX_PCIE_DEFAULT = 0xFE,
+	MAC_AX_PCIE_IGNORE = 0xFF
+};
+
+enum mac_ax_io_rcy_tmr {
+	MAC_AX_IO_RCY_ANA_TMR_2MS = 24000,
+	MAC_AX_IO_RCY_ANA_TMR_4MS = 48000,
+	MAC_AX_IO_RCY_ANA_TMR_6MS = 72000,
+	MAC_AX_IO_RCY_ANA_TMR_DEF = 0xFE
+};
+
 struct rtw89_pci_ch_dma_addr {
 	u32 num;
 	u32 idx;
@@ -504,6 +603,21 @@ struct rtw89_pci_ch_dma_addr_set {
 };
 
 struct rtw89_pci_info {
+	enum mac_ax_bd_trunc_mode txbd_trunc_mode;
+	enum mac_ax_bd_trunc_mode rxbd_trunc_mode;
+	enum mac_ax_rxbd_mode rxbd_mode;
+	enum mac_ax_tag_mode tag_mode;
+	enum mac_ax_tx_burst tx_burst;
+	enum mac_ax_rx_burst rx_burst;
+	enum mac_ax_wd_dma_intvl wd_dma_idle_intvl;
+	enum mac_ax_wd_dma_intvl wd_dma_act_intvl;
+	enum mac_ax_multi_tag_num multi_tag_num;
+	enum mac_ax_pcie_func_ctrl lbc_en;
+	enum mac_ax_lbc_tmr lbc_tmr;
+	enum mac_ax_pcie_func_ctrl autok_en;
+	enum mac_ax_pcie_func_ctrl io_rcy_en;
+	enum mac_ax_io_rcy_tmr io_rcy_tmr;
+
 	u32 init_cfg_reg;
 	u32 txhci_en_bit;
 	u32 rxhci_en_bit;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index b9047ac6b86db..42dfafb3d7f58 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -9,6 +9,21 @@
 #include "rtw8852a.h"
 
 static const struct rtw89_pci_info rtw8852a_pci_info = {
+	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
+	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
+	.rxbd_mode		= MAC_AX_RXBD_PKT,
+	.tag_mode		= MAC_AX_TAG_MULTI,
+	.tx_burst		= MAC_AX_TX_BURST_2048B,
+	.rx_burst		= MAC_AX_RX_BURST_128B,
+	.wd_dma_idle_intvl	= MAC_AX_WD_DMA_INTVL_256NS,
+	.wd_dma_act_intvl	= MAC_AX_WD_DMA_INTVL_256NS,
+	.multi_tag_num		= MAC_AX_TAG_NUM_8,
+	.lbc_en			= MAC_AX_PCIE_ENABLE,
+	.lbc_tmr		= MAC_AX_LBC_TMR_2MS,
+	.autok_en		= MAC_AX_PCIE_DISABLE,
+	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
+	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+
 	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN,
 	.rxhci_en_bit		= B_AX_RXHCI_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 33e69e34e385c..621918465c47f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -10,6 +10,21 @@
 #include "rtw8852c.h"
 
 static const struct rtw89_pci_info rtw8852c_pci_info = {
+	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
+	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
+	.rxbd_mode		= MAC_AX_RXBD_PKT,
+	.tag_mode		= MAC_AX_TAG_MULTI,
+	.tx_burst		= MAC_AX_TX_BURST_V1_256B,
+	.rx_burst		= MAC_AX_RX_BURST_V1_128B,
+	.wd_dma_idle_intvl	= MAC_AX_WD_DMA_INTVL_256NS,
+	.wd_dma_act_intvl	= MAC_AX_WD_DMA_INTVL_256NS,
+	.multi_tag_num		= MAC_AX_TAG_NUM_8,
+	.lbc_en			= MAC_AX_PCIE_ENABLE,
+	.lbc_tmr		= MAC_AX_LBC_TMR_2MS,
+	.autok_en		= MAC_AX_PCIE_DISABLE,
+	.io_rcy_en		= MAC_AX_PCIE_ENABLE,
+	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+
 	.init_cfg_reg		= R_AX_HAXI_INIT_CFG1,
 	.txhci_en_bit		= B_AX_TXHCI_EN_V1,
 	.rxhci_en_bit		= B_AX_RXHCI_EN_V1,
-- 
2.25.1

