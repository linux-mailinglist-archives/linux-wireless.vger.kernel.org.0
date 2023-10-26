Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C37D8227
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjJZMBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjJZMBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 08:01:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB539B9
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 05:01:36 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39QC1KlS42779275, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39QC1KlS42779275
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:01:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 26 Oct 2023 20:01:20 +0800
Received: from [127.0.1.1] (172.16.17.48) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 26 Oct
 2023 20:01:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: 8922ae: add 8922AE PCI entry and basic info
Date:   Thu, 26 Oct 2023 20:00:46 +0800
Message-ID: <20231026120049.9187-2-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

8922AE is a PCIE 802.11be wireless adapter with PID 0x8922. We add basic
configurations including PCI DMA mode, PCI parameters, register address to
control TX/RX rings and etc.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h      | 91 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 22 +++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    | 76 ++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922ae.c

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 2f3d1ad3b0f7..907478db83ef 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -496,6 +496,31 @@
 #define B_AX_CH11_BUSY			BIT(1)
 #define B_AX_CH10_BUSY			BIT(0)
 
+#define R_BE_HAXI_DMA_STOP1 0xB010
+#define B_BE_STOP_WPDMA BIT(31)
+#define B_BE_STOP_CH14 BIT(14)
+#define B_BE_STOP_CH13 BIT(13)
+#define B_BE_STOP_CH12 BIT(12)
+#define B_BE_STOP_CH11 BIT(11)
+#define B_BE_STOP_CH10 BIT(10)
+#define B_BE_STOP_CH9 BIT(9)
+#define B_BE_STOP_CH8 BIT(8)
+#define B_BE_STOP_CH7 BIT(7)
+#define B_BE_STOP_CH6 BIT(6)
+#define B_BE_STOP_CH5 BIT(5)
+#define B_BE_STOP_CH4 BIT(4)
+#define B_BE_STOP_CH3 BIT(3)
+#define B_BE_STOP_CH2 BIT(2)
+#define B_BE_STOP_CH1 BIT(1)
+#define B_BE_STOP_CH0 BIT(0)
+#define B_BE_TX_STOP1_MASK (B_BE_STOP_CH0 | B_BE_STOP_CH1 | \
+			    B_BE_STOP_CH2 | B_BE_STOP_CH3 | \
+			    B_BE_STOP_CH4 | B_BE_STOP_CH5 | \
+			    B_BE_STOP_CH6 | B_BE_STOP_CH7 | \
+			    B_BE_STOP_CH8 | B_BE_STOP_CH9 | \
+			    B_BE_STOP_CH10 | B_BE_STOP_CH11 | \
+			    B_BE_STOP_CH12)
+
 /* Configure */
 #define R_AX_PCIE_INIT_CFG2		0x1004
 #define B_AX_WD_ITVL_IDLE		GENMASK(27, 24)
@@ -554,6 +579,72 @@
 #define R_AX_PCIE_HRPWM_V1		0x30C0
 #define R_AX_PCIE_CRPWM			0x30C4
 
+#define R_BE_PCIE_HRPWM 0x30C0
+#define R_BE_PCIE_CRPWM 0x30C4
+
+#define R_BE_TXBD_RWPTR_CLR1 0xB014
+#define B_BE_CLR_CH14_IDX BIT(14)
+#define B_BE_CLR_CH13_IDX BIT(13)
+#define B_BE_CLR_CH12_IDX BIT(12)
+#define B_BE_CLR_CH11_IDX BIT(11)
+#define B_BE_CLR_CH10_IDX BIT(10)
+#define B_BE_CLR_CH9_IDX BIT(9)
+#define B_BE_CLR_CH8_IDX BIT(8)
+#define B_BE_CLR_CH7_IDX BIT(7)
+#define B_BE_CLR_CH6_IDX BIT(6)
+#define B_BE_CLR_CH5_IDX BIT(5)
+#define B_BE_CLR_CH4_IDX BIT(4)
+#define B_BE_CLR_CH3_IDX BIT(3)
+#define B_BE_CLR_CH2_IDX BIT(2)
+#define B_BE_CLR_CH1_IDX BIT(1)
+#define B_BE_CLR_CH0_IDX BIT(0)
+
+#define R_BE_RXBD_RWPTR_CLR1_V1 0xB018
+#define B_BE_CLR_ROQ1_IDX_V1 BIT(5)
+#define B_BE_CLR_RPQ1_IDX_V1 BIT(4)
+#define B_BE_CLR_RXQ1_IDX_V1 BIT(3)
+#define B_BE_CLR_ROQ0_IDX BIT(2)
+#define B_BE_CLR_RPQ0_IDX BIT(1)
+#define B_BE_CLR_RXQ0_IDX BIT(0)
+
+#define R_BE_HAXI_DMA_BUSY1 0xB01C
+#define B_BE_HAXI_MST_BUSY BIT(31)
+#define B_BE_HAXI_RX_IDLE BIT(25)
+#define B_BE_HAXI_TX_IDLE BIT(24)
+#define B_BE_ROQ1_BUSY_V1 BIT(21)
+#define B_BE_RPQ1_BUSY_V1 BIT(20)
+#define B_BE_RXQ1_BUSY_V1 BIT(19)
+#define B_BE_ROQ0_BUSY_V1 BIT(18)
+#define B_BE_RPQ0_BUSY_V1 BIT(17)
+#define B_BE_RXQ0_BUSY_V1 BIT(16)
+#define B_BE_WPDMA_BUSY BIT(15)
+#define B_BE_CH14_BUSY BIT(14)
+#define B_BE_CH13_BUSY BIT(13)
+#define B_BE_CH12_BUSY BIT(12)
+#define B_BE_CH11_BUSY BIT(11)
+#define B_BE_CH10_BUSY BIT(10)
+#define B_BE_CH9_BUSY BIT(9)
+#define B_BE_CH8_BUSY BIT(8)
+#define B_BE_CH7_BUSY BIT(7)
+#define B_BE_CH6_BUSY BIT(6)
+#define B_BE_CH5_BUSY BIT(5)
+#define B_BE_CH4_BUSY BIT(4)
+#define B_BE_CH3_BUSY BIT(3)
+#define B_BE_CH2_BUSY BIT(2)
+#define B_BE_CH1_BUSY BIT(1)
+#define B_BE_CH0_BUSY BIT(0)
+#define DMA_BUSY1_CHECK_BE (B_BE_CH0_BUSY | B_BE_CH1_BUSY | B_BE_CH2_BUSY | \
+			    B_BE_CH3_BUSY | B_BE_CH4_BUSY | B_BE_CH5_BUSY | \
+			    B_BE_CH6_BUSY | B_BE_CH7_BUSY | B_BE_CH8_BUSY | \
+			    B_BE_CH9_BUSY | B_BE_CH10_BUSY | B_BE_CH11_BUSY | \
+			    B_BE_CH12_BUSY | B_BE_CH13_BUSY | B_BE_CH14_BUSY)
+
+#define R_BE_HAXI_EXP_CTRL_V1 0xB020
+#define B_BE_R_NO_SEC_ACCESS BIT(31)
+#define B_BE_FORCE_EN_DMA_RX_GCLK BIT(5)
+#define B_BE_FORCE_EN_DMA_TX_GCLK BIT(4)
+#define B_BE_MAX_TAG_NUM_MASK GENMASK(3, 0)
+
 #define RTW89_PCI_TXBD_NUM_MAX		256
 #define RTW89_PCI_RXBD_NUM_MAX		256
 #define RTW89_PCI_TXWD_NUM_MAX		512
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ccd5481e8a3d..b509e9582ccf 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3740,6 +3740,28 @@
 #define R_BE_PLE_DBG_FUN_INTF_DATA 0x9114
 #define B_BE_PLE_DFI_DATA_MASK GENMASK(31, 0)
 
+#define R_BE_HAXI_INIT_CFG1 0xB000
+#define B_BE_CFG_WD_PERIOD_IDLE_MASK GENMASK(31, 28)
+#define B_BE_CFG_WD_PERIOD_ACTIVE_MASK GENMASK(27, 24)
+#define B_BE_EN_RO_IDX_UPD_BY_IO BIT(19)
+#define B_BE_RST_KEEP_REG BIT(18)
+#define B_BE_FLUSH_HAXI_MST BIT(17)
+#define B_BE_SET_BDRAM_BOUND BIT(16)
+#define B_BE_ADDRINFO_ALIGN4B_EN BIT(15)
+#define B_BE_RXBD_DONE_MODE_MASK GENMASK(14, 13)
+#define B_BE_RXQ_RXBD_MODE_MASK GENMASK(12, 11)
+#define B_BE_DMA_MODE_MASK GENMASK(10, 8)
+#define S_BE_DMA_MOD_PCIE_NO_DATA_CPU 0x0
+#define S_BE_DMA_MOD_PCIE_DATA_CPU 0x1
+#define S_BE_DMA_MOD_USB 0x4
+#define S_BE_DMA_MOD_SDIO 0x6
+#define B_BE_STOP_AXI_MST BIT(7)
+#define B_BE_RXDMA_ALIGN64B_EN BIT(6)
+#define B_BE_RXDMA_EN BIT(5)
+#define B_BE_TXDMA_EN BIT(4)
+#define B_BE_MAX_RXDMA_MASK GENMASK(3, 2)
+#define B_BE_MAX_TXDMA_MASK GENMASK(1, 0)
+
 #define R_BE_CMAC_FUNC_EN 0x10000
 #define R_BE_CMAC_FUNC_EN_C1 0x14000
 #define B_BE_CMAC_CRPRT BIT(31)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
new file mode 100644
index 000000000000..948015a36a80
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "reg.h"
+
+static const struct rtw89_pci_info rtw8922a_pci_info = {
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
+	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_DEF,
+
+	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
+	.txhci_en_bit		= B_BE_TXDMA_EN,
+	.rxhci_en_bit		= B_BE_RXDMA_EN,
+	.rxbd_mode_bit		= B_BE_RXQ_RXBD_MODE_MASK,
+	.exp_ctrl_reg		= R_BE_HAXI_EXP_CTRL_V1,
+	.max_tag_num_mask	= B_BE_MAX_TAG_NUM_MASK,
+	.rxbd_rwptr_clr_reg	= R_BE_RXBD_RWPTR_CLR1_V1,
+	.txbd_rwptr_clr2_reg	= R_BE_TXBD_RWPTR_CLR1,
+	.dma_stop1		= {R_BE_HAXI_DMA_STOP1, B_BE_TX_STOP1_MASK},
+	.dma_stop2		= {0},
+	.dma_busy1		= {R_BE_HAXI_DMA_BUSY1, DMA_BUSY1_CHECK_BE},
+	.dma_busy2_reg		= 0,
+	.dma_busy3_reg		= R_BE_HAXI_DMA_BUSY1,
+
+	.rpwm_addr		= R_BE_PCIE_HRPWM,
+	.cpwm_addr		= R_BE_PCIE_CRPWM,
+	.tx_dma_ch_mask		= 0,
+	.bd_idx_addr_low_power	= NULL,
+	.bd_ram_table		= NULL,
+
+	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
+};
+
+static const struct rtw89_driver_info rtw89_8922ae_info = {
+	.bus = {
+		.pci = &rtw8922a_pci_info,
+	},
+};
+
+static const struct pci_device_id rtw89_8922ae_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8922),
+		.driver_data = (kernel_ulong_t)&rtw89_8922ae_info,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(pci, rtw89_8922ae_id_table);
+
+static struct pci_driver rtw89_8922ae_driver = {
+	.name		= "rtw89_8922ae",
+	.id_table	= rtw89_8922ae_id_table,
+	.probe		= rtw89_pci_probe,
+	.remove		= rtw89_pci_remove,
+	.driver.pm	= &rtw89_pm_ops,
+};
+module_pci_driver(rtw89_8922ae_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11be wireless 8922AE driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

