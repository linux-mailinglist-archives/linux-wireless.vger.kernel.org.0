Return-Path: <linux-wireless+bounces-34170-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAVSGpwgymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34170-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:05:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E20356332
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2823040A84
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B48382399;
	Mon, 30 Mar 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="C7dV0bOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09914286D73
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853983; cv=none; b=bYxCmeb3o3yd3cknfBEDM/N9/NfrQZlsKqwLvaKZ328EqJ8RAK4uzpTwA3AkjWfw8Yi12FrfF+Tzqo05C4AoQJ31M2zBZRtiEDw5ukFIRAL1NgafcMeAcD5ekJf7h1QMDSrlIx1I1ibV9wc5nGjOdaajTc5fu/ObtpIBrv75mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853983; c=relaxed/simple;
	bh=2A1pn7pXSM+609RToNL1OomlSXEaHuDjRcQB3Qf3V3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMUyBKWpVwfVF0aqbmBeFW5EvIjdmWJnnKpCqv9+b5bvwVh94VUhd+jP2ZSQB8GFoxJtma8K4v7CDrQjjZ7PlfpA6kNUpxBAbWbMsF8Ixjhoi3gQlyFhL2qf4kNFahYTKJx0NU06O/7AlEoX1RMyk38OQhS3ik98AjuAyjHYvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=C7dV0bOI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6xdDI3673884, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853979; bh=AVjwxO/BejHfxVf5dLDAa7+Ew1hI9piSkVULipFV4Rc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=C7dV0bOId4e8qMotDmi6INQNJEuevoKTrDTKHPevDKL+fgT8QH6NETUylkLjddyFl
	 l6VM2ow19SaXcBQYn7yKcJiiQWODCsSftS/ufMrZRB5XIYJLVjOsvzu84rbn5WJ9Jt
	 RR5Vbl6/6vVKbyf5fRdURTKydOBKlmetm9VDa4maS2wxpjou/iDHk/+1W0Cw9hGaf8
	 4gCbzj52T2lhx2BGmi2VunDrEk+zkYdw5A3GvzoRjAbeQFxi5K56YYDmNdbPng8YrT
	 rbGSD6ig0OwTFDFZY2jlMHL9Yx7XMhBQnJApgO6nhecL6OL2w6IViEsIhe53YPveuv
	 a9DwJMRioJc0g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6xdDI3673884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:59:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:39 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:59:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 9/9] wifi: rtw89: 8922d: add PCI ID of RTL8922DE and RTL8922DE-VS
Date: Mon, 30 Mar 2026 14:58:47 +0800
Message-ID: <20260330065847.48946-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260330065847.48946-1-pkshih@realtek.com>
References: <20260330065847.48946-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34170-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6E20356332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add PCI ID tables with RTL8922DE whose ID is 10EC:895D, and with
RTL8922DE-VS whose ID are 10EC:892D and 10EC:882D. Also, add pci_info
struct to describe the hardware capabilities and registers accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h      |   3 +
 .../net/wireless/realtek/rtw89/rtw8922de.c    | 119 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922de.c

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index c7cd34e99349..e7da37b9da7d 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1105,6 +1105,9 @@
 			    B_BE_CH6_BUSY | B_BE_CH7_BUSY | B_BE_CH8_BUSY | \
 			    B_BE_CH9_BUSY | B_BE_CH10_BUSY | B_BE_CH11_BUSY | \
 			    B_BE_CH12_BUSY | B_BE_CH13_BUSY | B_BE_CH14_BUSY)
+#define DMA_BUSY1_CHECK_BE_V1 (B_BE_CH0_BUSY | B_BE_CH2_BUSY | B_BE_CH4_BUSY | \
+			       B_BE_CH6_BUSY | B_BE_CH8_BUSY | B_BE_CH10_BUSY | \
+			       B_BE_CH12_BUSY)
 
 #define R_BE_HAXI_EXP_CTRL_V1 0xB020
 #define B_BE_R_NO_SEC_ACCESS BIT(31)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922de.c b/drivers/net/wireless/realtek/rtw89/rtw8922de.c
new file mode 100644
index 000000000000..f144e7fc76de
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922de.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2026  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "reg.h"
+#include "rtw8922d.h"
+
+static const struct rtw89_pci_info rtw8922d_pci_info = {
+	.gen_def		= &rtw89_pci_gen_be,
+	.isr_def		= &rtw89_pci_isr_be_v1,
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
+	.rx_ring_eq_is_full	= true,
+	.check_rx_tag		= true,
+	.no_rxbd_fs		= true,
+	.group_bd_addr		= true,
+	.rpp_fmt_size		= sizeof(struct rtw89_pci_rpp_fmt_v1),
+
+	.init_cfg_reg		= R_BE_HAXI_INIT_CFG1,
+	.txhci_en_bit		= B_BE_TXDMA_EN,
+	.rxhci_en_bit		= B_BE_RXDMA_EN,
+	.rxbd_mode_bit		= B_BE_RXQ_RXBD_MODE_MASK,
+	.exp_ctrl_reg		= R_BE_HAXI_EXP_CTRL_V1,
+	.max_tag_num_mask	= B_BE_MAX_TAG_NUM_MASK,
+	.rxbd_rwptr_clr_reg	= R_BE_RXBD_RWPTR_CLR1_V1,
+	.txbd_rwptr_clr2_reg	= R_BE_TXBD_RWPTR_CLR1,
+	.dma_io_stop		= {R_BE_HAXI_INIT_CFG1, B_BE_STOP_AXI_MST},
+	.dma_stop1		= {R_BE_HAXI_DMA_STOP1, B_BE_TX_STOP1_MASK_V1},
+	.dma_stop2		= {0},
+	.dma_busy1		= {R_BE_HAXI_DMA_BUSY1, DMA_BUSY1_CHECK_BE_V1},
+	.dma_busy2_reg		= 0,
+	.dma_busy3_reg		= R_BE_HAXI_DMA_BUSY1,
+
+	.rpwm_addr		= R_BE_PCIE_HRPWM,
+	.cpwm_addr		= R_BE_PCIE_CRPWM,
+	.mit_addr		= R_BE_PCIE_MIT_CH_EN,
+	.wp_sel_addr		= R_BE_WP_ADDR_H_SEL0_3_V1,
+	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH1) | BIT(RTW89_TXCH_ACH3) |
+				  BIT(RTW89_TXCH_ACH5) | BIT(RTW89_TXCH_ACH7) |
+				  BIT(RTW89_TXCH_CH9) | BIT(RTW89_TXCH_CH11),
+	.bd_idx_addr_low_power	= NULL,
+	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_be_v1,
+	.bd_ram_table		= NULL,
+
+	.ltr_set		= rtw89_pci_ltr_set_v2,
+	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
+	.parse_rpp		= rtw89_pci_parse_rpp_v1,
+	.config_intr_mask	= rtw89_pci_config_intr_mask_v3,
+	.enable_intr		= rtw89_pci_enable_intr_v3,
+	.disable_intr		= rtw89_pci_disable_intr_v3,
+	.recognize_intrs	= rtw89_pci_recognize_intrs_v3,
+
+	.ssid_quirks		= NULL,
+};
+
+static const struct rtw89_driver_info rtw89_8922de_vs_info = {
+	.chip = &rtw8922d_chip_info,
+	.variant = &rtw8922de_vs_variant,
+	.quirks = NULL,
+	.bus = {
+		.pci = &rtw8922d_pci_info,
+	},
+};
+
+static const struct rtw89_driver_info rtw89_8922de_info = {
+	.chip = &rtw8922d_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+	.bus = {
+		.pci = &rtw8922d_pci_info,
+	},
+};
+
+static const struct pci_device_id rtw89_8922de_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x892D),
+		.driver_data = (kernel_ulong_t)&rtw89_8922de_vs_info,
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x882D),
+		.driver_data = (kernel_ulong_t)&rtw89_8922de_vs_info,
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x895D),
+		.driver_data = (kernel_ulong_t)&rtw89_8922de_info,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(pci, rtw89_8922de_id_table);
+
+static struct pci_driver rtw89_8922de_driver = {
+	.name		= "rtw89_8922de",
+	.id_table	= rtw89_8922de_id_table,
+	.probe		= rtw89_pci_probe,
+	.remove		= rtw89_pci_remove,
+	.driver.pm	= &rtw89_pm_ops_be,
+	.err_handler    = &rtw89_pci_err_handler,
+};
+module_pci_driver(rtw89_8922de_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11be wireless 8922DE/8922DE-VS driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1


