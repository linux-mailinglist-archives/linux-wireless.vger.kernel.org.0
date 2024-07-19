Return-Path: <linux-wireless+bounces-10383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B94937404
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 08:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CA71C21ED0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 06:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB229CE6;
	Fri, 19 Jul 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sHA9VnHD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF761B86E7
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370313; cv=none; b=Gf4L+eMKWf7cBPf6uz5DpJY66316gz11xKx0C7zM8aYRucd4I9ngIjT0pdjNjRMsy6+1k1AItWId/i8h+PfgaFtxD5eXO+BMkrhshKMmDiYpTKW781UIDzVgFu/K+fooa1x1xgPQBgqRFRRItuTC0Q7g75IFrLugXp2FM/zvPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370313; c=relaxed/simple;
	bh=d6pMlTA9yjGn1T2ywD4NSfyV9zy9pIq1HHbNF6GO9uU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlCjmPYPipdYTQKANTzIuKjzeAx15Z0k7Bi2JDkPSw29M2qiJHExpteJQFPbJSsZc+A6BTN6298+uewIdpWwkzbo8PMkqPZV1xaYujWaVlWJNFEPlyYEGuqJeHeWXPVASbW8gjQ3mZ0UB7ZIpW76M3k5zigaiLVsIk4rWgH2Nxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sHA9VnHD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J6P9Lq8182659, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721370309; bh=d6pMlTA9yjGn1T2ywD4NSfyV9zy9pIq1HHbNF6GO9uU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sHA9VnHDtVRkDpzmJfg5e2YXvUR/DyC/Wrvx39An9yhm2QG+F/Jm+nXGa1pM/Sa6H
	 D9c9uWyGDRxJmS2bWmtsYj6STvLC8L29OCBiH9HVXcrywAlqXIpxwuhNRdZXsnBARR
	 BQtnSc53L17m/JcOK+bgI+E0GJDomnbmaSEL50MVwIuFd+Lbg2mAuqvVp+gUbaVnaU
	 w5oqOm5f2DjlwXhhuPwtx9STFvovsoQmJNI8O9GEZtC9E/f50rquCpwzGJH4MTUIgK
	 +T0d9hZH34axYrhYZRVLRSGlvNFWT9StGJq3HAFykDOHft924DiqgOhi0DDyCUmy8P
	 hVzTEzOX01IcQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J6P9Lq8182659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 14:25:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 14:25:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 14:25:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/6] wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
Date: Fri, 19 Jul 2024 14:24:13 +0800
Message-ID: <20240719062414.21953-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719062414.21953-1-pkshih@realtek.com>
References: <20240719062414.21953-1-pkshih@realtek.com>
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

PCI device ID 10ec:b520 of RTL8852BE-VT is added as PCI entry, and define
chip capabilities for driver common routines.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 .../net/wireless/realtek/rtw89/rtw8852bte.c   | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bte.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
new file mode 100644
index 000000000000..702948119646
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "reg.h"
+#include "rtw8852bt.h"
+
+static const struct rtw89_pci_info rtw8852bt_pci_info = {
+	.gen_def		= &rtw89_pci_gen_ax,
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
+	.rx_ring_eq_is_full	= false,
+	.check_rx_tag		= false,
+
+	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
+	.txhci_en_bit		= B_AX_TXHCI_EN,
+	.rxhci_en_bit		= B_AX_RXHCI_EN,
+	.rxbd_mode_bit		= B_AX_RXBD_MODE,
+	.exp_ctrl_reg		= R_AX_PCIE_EXP_CTRL,
+	.max_tag_num_mask	= B_AX_MAX_TAG_NUM,
+	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR,
+	.txbd_rwptr_clr2_reg	= 0,
+	.dma_io_stop		= {R_AX_PCIE_DMA_STOP1, B_AX_STOP_PCIEIO},
+	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK_V1},
+	.dma_stop2		= {0},
+	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK_V1},
+	.dma_busy2_reg		= 0,
+	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
+
+	.rpwm_addr		= R_AX_PCIE_HRPWM,
+	.cpwm_addr		= R_AX_CPWM,
+	.mit_addr		= R_AX_INT_MIT_RX,
+	.wp_sel_addr		= 0,
+	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
+				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
+				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
+	.bd_idx_addr_low_power	= NULL,
+	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
+	.bd_ram_table		= &rtw89_bd_ram_table_single,
+
+	.ltr_set		= rtw89_pci_ltr_set,
+	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.config_intr_mask	= rtw89_pci_config_intr_mask,
+	.enable_intr		= rtw89_pci_enable_intr,
+	.disable_intr		= rtw89_pci_disable_intr,
+	.recognize_intrs	= rtw89_pci_recognize_intrs,
+};
+
+static const struct rtw89_driver_info rtw89_8852bte_info = {
+	.chip = &rtw8852bt_chip_info,
+	.quirks = NULL,
+	.bus = {
+		.pci = &rtw8852bt_pci_info,
+	},
+};
+
+static const struct pci_device_id rtw89_8852bte_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xb520),
+		.driver_data = (kernel_ulong_t)&rtw89_8852bte_info,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(pci, rtw89_8852bte_id_table);
+
+static struct pci_driver rtw89_8852bte_driver = {
+	.name		= "rtw89_8852bte",
+	.id_table	= rtw89_8852bte_id_table,
+	.probe		= rtw89_pci_probe,
+	.remove		= rtw89_pci_remove,
+	.driver.pm	= &rtw89_pm_ops,
+};
+module_pci_driver(rtw89_8852bte_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852BE-VT driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1


