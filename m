Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF55ED82D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiI1Ir6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiI1IrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1DE73BC4B
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:44:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28S8iCW51013429, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28S8iCW51013429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Sep 2022 16:44:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Sep 2022 16:44:37 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 28 Sep
 2022 16:44:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 9/9] wifi: rtw89: 8852be: add 8852BE PCI entry
Date:   Wed, 28 Sep 2022 16:43:36 +0800
Message-ID: <20220928084336.34981-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928084336.34981-1-pkshih@realtek.com>
References: <20220928084336.34981-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/28/2022 08:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjggpFekyCAwNzowMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852BE has two variants with different ID. One is 10ec:b852 that is a main
model with 2x2 antenna, and the other is 10ec:b85b that is a 1x1 model.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |  2 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    | 64 +++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.h b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
index 578fe55b66957..bc0a383c4a390 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
@@ -85,4 +85,6 @@ struct rtw8852b_efuse {
 	};
 } __packed;
 
+extern const struct rtw89_chip_info rtw8852b_chip_info;
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 7bf95c38d3eb2..0ef2ca8efeb0e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -7,18 +7,82 @@
 
 #include "pci.h"
 #include "reg.h"
+#include "rtw8852b.h"
 
 static const struct rtw89_pci_info rtw8852b_pci_info = {
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
+	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
+	.txhci_en_bit		= B_AX_TXHCI_EN,
+	.rxhci_en_bit		= B_AX_RXHCI_EN,
+	.rxbd_mode_bit		= B_AX_RXBD_MODE,
+	.exp_ctrl_reg		= R_AX_PCIE_EXP_CTRL,
+	.max_tag_num_mask	= B_AX_MAX_TAG_NUM,
+	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR,
+	.txbd_rwptr_clr2_reg	= 0,
 	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK_V1},
 	.dma_stop2		= {0},
 	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK_V1},
 	.dma_busy2_reg		= 0,
 	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
 
+	.rpwm_addr		= R_AX_PCIE_HRPWM,
+	.cpwm_addr		= R_AX_CPWM,
 	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
 				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
 				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
+	.bd_idx_addr_low_power	= NULL,
+	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
+
+	.ltr_set		= rtw89_pci_ltr_set,
+	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.config_intr_mask	= rtw89_pci_config_intr_mask,
+	.enable_intr		= rtw89_pci_enable_intr,
+	.disable_intr		= rtw89_pci_disable_intr,
+	.recognize_intrs	= rtw89_pci_recognize_intrs,
+};
+
+static const struct rtw89_driver_info rtw89_8852be_info = {
+	.chip = &rtw8852b_chip_info,
+	.bus = {
+		.pci = &rtw8852b_pci_info,
+	},
+};
+
+static const struct pci_device_id rtw89_8852be_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xb852),
+		.driver_data = (kernel_ulong_t)&rtw89_8852be_info,
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xb85b),
+		.driver_data = (kernel_ulong_t)&rtw89_8852be_info,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(pci, rtw89_8852be_id_table);
+
+static struct pci_driver rtw89_8852be_driver = {
+	.name		= "rtw89_8852be",
+	.id_table	= rtw89_8852be_id_table,
+	.probe		= rtw89_pci_probe,
+	.remove		= rtw89_pci_remove,
+	.driver.pm	= &rtw89_pm_ops,
 };
+module_pci_driver(rtw89_8852be_driver);
 
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852BE driver");
-- 
2.25.1

