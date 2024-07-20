Return-Path: <linux-wireless+bounces-10412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C5937EBD
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 04:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553B2282102
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9267E1;
	Sat, 20 Jul 2024 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bCWswDqI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91DB661
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721441690; cv=none; b=KveilPlRC8O9fX6zUSDrfg0aXLD8oyTvXp7HWKOliHPxZC6GD1rHSWISMpQpWIbepvlH0E0PHr5Vb78K0TGZ0jbrGIojQpd5go2VuAXJ5fS1b1rzDwqN3EQXy0ukmPtexWPhAFFrArj33G3ehTr46f9+oX8xdc8r+Oi/TH/npeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721441690; c=relaxed/simple;
	bh=ngv0/G5jAfGVco9cd6PZ8LczLmgv3e3R6yxkCIJpgRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0R90AcxVXoa6L5OKRd5397TPJ9HgAhAx/cwwkmukcwsTCzruiBv/hx3vgOP/IVOtXLLsOpPs0EgWwYxOF73a8xtNbMvbIOuZlNSaQfVIa4LTbMkYN6RyHkmR+2I/VblPzU9IceGObTpKDftYtKlioyyZmYeLsYCWUiAoliGWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bCWswDqI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46K2Ek9721147878, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721441686; bh=ngv0/G5jAfGVco9cd6PZ8LczLmgv3e3R6yxkCIJpgRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bCWswDqIePGILOLxswNq75gQmOTIZtSobCIPpgfHWeSbyvDHKyShM5UiZ2lDhJhzm
	 3x/+e5jxPedGKNdUvh3WEAuvXgEkgb/tKPflSsctKL/yMOQ6Wn8HYI64rX2WPqphyD
	 5tCPpVwInmf3cz6nTS+io5J/R+FoUP9i/4yyMulXBdBbbr+If7UgirX5QnwUFtL5Y1
	 +QR2ZAU7fLaEABe33PMZqLvj4Aic9aaIooRpa0ef4PTkFmsGLxrfWGCQ8BRfwRwVmM
	 iDz0UcBy/29CXsXQ8eI/dUT8uF8F3UaZzvXvK19V7tvj1/2bkTuRDlEmF+Lwf/PEye
	 QWyEU5S3ACCeQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46K2Ek9721147878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 10:14:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 10:14:46 +0800
Received: from [127.0.1.1] (172.16.22.168) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jul
 2024 10:14:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 6/7] wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
Date: Sat, 20 Jul 2024 10:13:39 +0800
Message-ID: <20240720021340.12102-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240720021340.12102-1-pkshih@realtek.com>
References: <20240720021340.12102-1-pkshih@realtek.com>
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
v3: no change
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


