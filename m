Return-Path: <linux-wireless+bounces-10328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1783934682
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B6D1F2209D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878424B4A;
	Thu, 18 Jul 2024 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="u6GSnVtm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921413717F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721271158; cv=none; b=IlmSTLKaJTmWig64k3vS507acWoX7OWmQaH7XT+ieT10T0JlPSyzxowee2S/RiB6aJBbUjx0siqghecCUmZveTm1aVA1pWrR+zoXgjIdAclkiPQNcQPERX5ldQBPai1CC7mqQolBV1WQRb/8QOXYspoCUvgKCdfb3OKJ3gtc/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721271158; c=relaxed/simple;
	bh=OeVA3XHjCo22u6H6HwStlTDYDv3yUWtkG6fnaVl4fzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j21q8Ef+FA3TguSGpKmhZocnIJisYCFm8paZOX+MQKqAA523iEwUbiMGXdenu1dkJzsrd8fwzu/Pbv14MGZw/+qwBMwQHftKzq+nbDzXnl8X6HeqneW/0otQuu3AUpiEMWDGiGvC46vx9wfXkYBngiuaN/K6Om0fOfb6UVYokTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=u6GSnVtm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I2qYrF52860488, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721271154; bh=OeVA3XHjCo22u6H6HwStlTDYDv3yUWtkG6fnaVl4fzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=u6GSnVtmvzhXIjRg5MIXNREpYABokf2wG7YCsU81m7jEkh/9dpNOKTCMy3oFkLWYW
	 CXHEuigF3sMkYiRiseI11goTTiqL1QXeBq3o8Fyu541wKhpAVRxXlVNkJdWVIQIyCi
	 wvKdlsx9uJFp7+O9unEqi8zSrlsf1+jVWJw4bRaKgtAsS1j/f8ZzSccNh4rPzT/hXr
	 Nl7hPkabUdFw85oSF75JFRT7VMOmwmz2OKt+8Cl5eyiuvL07B4WCvIdGUtXnxQrbkN
	 jnK5+7EWV21ypzCMHl/0dAnEonjhYXfPyeVjowI0hRUmMI12IuOfBq1QcqhetIgN8s
	 Qc/Bg1fUPr76g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I2qYrF52860488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 10:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:52:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 10:52:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
Date: Thu, 18 Jul 2024 10:51:37 +0800
Message-ID: <20240718025138.18777-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718025138.18777-1-pkshih@realtek.com>
References: <20240718025138.18777-1-pkshih@realtek.com>
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


