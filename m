Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B13C73D2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 18:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhGMQKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jul 2021 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhGMQKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jul 2021 12:10:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52FC0613EE;
        Tue, 13 Jul 2021 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=joNkWmn5qVMu9KtQ2EOffOtK6v9TM5gMwo+EaCtDiIQ=; b=XM7J6H5a2Zb+DYwp1pfshmukqY
        1p9Asd/6R1H+ApyRm6I2o47rvVWz6r5rWISBOY9Ot9JfsCASipqQvYftlXKYjWvJyh6zy+Tqri67l
        52CWDOd5w4kPDrdL9/hrjDz+9JExBh7xCq/co3SNCoo81sGlKOVfJmzxkE/03EqFSFm8=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1m3Kwm-0008TX-F9; Tue, 13 Jul 2021 18:07:48 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, pablo@netfilter.org, ryder.lee@mediatek.com
Subject: [RFC 2/7] net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)
Date:   Tue, 13 Jul 2021 18:07:40 +0200
Message-Id: <20210713160745.59707-3-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210713160745.59707-1-nbd@nbd.name>
References: <20210713160745.59707-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Wireless Ethernet Dispatch subsystem on the MT7622 SoC can be configured
to intercept and handle access to the DMA queues and PCIe interrupts for a
MT7615/MT7915 wireless card.
It can manage the internal WDMA (Wireless DMA) controller, which allows
ethernet packets to be passed from the packet switch engine (PSE) to the
wireless card, bypassing the CPU entirely.
This can be used to implement hardware flow offloading from ethernet to WLAN.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |  22 +
 drivers/net/ethernet/mediatek/Kconfig         |   4 +
 drivers/net/ethernet/mediatek/Makefile        |   5 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  23 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |   3 +
 drivers/net/ethernet/mediatek/mtk_wed.c       | 837 ++++++++++++++++++
 drivers/net/ethernet/mediatek/mtk_wed.h       | 123 +++
 .../net/ethernet/mediatek/mtk_wed_debugfs.c   | 175 ++++
 drivers/net/ethernet/mediatek/mtk_wed_ops.c   |   8 +
 drivers/net/ethernet/mediatek/mtk_wed_regs.h  | 248 ++++++
 include/linux/soc/mediatek/mtk_wed.h          | 127 +++
 11 files changed, 1575 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/mtk_wed.c
 create mode 100644 drivers/net/ethernet/mediatek/mtk_wed.h
 create mode 100644 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
 create mode 100644 drivers/net/ethernet/mediatek/mtk_wed_ops.c
 create mode 100644 drivers/net/ethernet/mediatek/mtk_wed_regs.h
 create mode 100644 include/linux/soc/mediatek/mtk_wed.h

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 890a942ec608..a5232a15bc98 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -911,6 +911,26 @@ hsdma: dma-controller@1b007000 {
 		#dma-cells = <1>;
 	};
 
+	pcie_mirror: pcie-mirror@10000400 {
+		compatible = "mediatek,mt7622-pcie-mirror",
+			     "syscon";
+		reg = <0 0x10000400 0 0x10>;
+	};
+
+	wed0: wed@1020a000 {
+		compatible = "mediatek,mt7622-wed",
+			     "syscon";
+		reg = <0 0x1020a000 0 0x1000>;
+		interrupts = <GIC_SPI 214 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	wed1: wed@1020b000 {
+		compatible = "mediatek,mt7622-wed",
+			     "syscon";
+		reg = <0 0x1020b000 0 0x1000>;
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	eth: ethernet@1b100000 {
 		compatible = "mediatek,mt7622-eth",
 			     "mediatek,mt2701-eth",
@@ -937,6 +957,8 @@ eth: ethernet@1b100000 {
 		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
 		mediatek,ethsys = <&ethsys>;
 		mediatek,sgmiisys = <&sgmiisys>;
+		mediatek,wed = <&wed0>, <&wed1>;
+		mediatek,pcie-mirror = <&pcie_mirror>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index c357c193378e..03173b69b128 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -7,6 +7,10 @@ config NET_VENDOR_MEDIATEK
 
 if NET_VENDOR_MEDIATEK
 
+config NET_MEDIATEK_SOC_WED
+	depends on ARCH_MEDIATEK
+	def_tristate NET_MEDIATEK_SOC
+
 config NET_MEDIATEK_SOC
 	tristate "MediaTek SoC Gigabit Ethernet support"
 	depends on NET_DSA || !NET_DSA
diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
index 79d4cdbbcbf5..45ba0970504a 100644
--- a/drivers/net/ethernet/mediatek/Makefile
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -5,4 +5,9 @@
 
 obj-$(CONFIG_NET_MEDIATEK_SOC) += mtk_eth.o
 mtk_eth-y := mtk_eth_soc.o mtk_sgmii.o mtk_eth_path.o mtk_ppe.o mtk_ppe_debugfs.o mtk_ppe_offload.o
+mtk_eth-$(CONFIG_NET_MEDIATEK_SOC_WED) += mtk_wed.o
+ifdef CONFIG_DEBUG_FS
+mtk_eth-$(CONFIG_NET_MEDIATEK_SOC_WED) += mtk_wed_debugfs.o
+endif
+obj-$(CONFIG_NET_MEDIATEK_SOC_WED) += mtk_wed_ops.o
 obj-$(CONFIG_NET_MEDIATEK_STAR_EMAC) += mtk_star_emac.o
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 64adfd24e134..337ae6268fae 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -23,6 +23,7 @@
 #include <net/dsa.h>
 
 #include "mtk_eth_soc.h"
+#include "mtk_wed.h"
 
 static int mtk_msg_level = -1;
 module_param_named(msg_level, mtk_msg_level, int, 0);
@@ -3132,6 +3133,28 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0;; i++) {
+		struct device_node *np = of_parse_phandle(pdev->dev.of_node,
+							  "mediatek,wed", i);
+		static const u32 wdma_regs[] = {
+			MTK_WDMA0_BASE,
+			MTK_WDMA1_BASE
+		};
+		struct regmap *mirror;
+		void __iomem *wdma;
+
+		if (!np || i >= ARRAY_SIZE(wdma_regs))
+			break;
+
+		mirror = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							 "mediatek,pcie-mirror");
+		if (IS_ERR(mirror))
+			break;
+
+		wdma = eth->base + wdma_regs[i];
+		mtk_wed_add_hw(np, wdma, mirror, i);
+	}
+
 	for (i = 0; i < 3; i++) {
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
 			eth->irq[i] = eth->irq[0];
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 5ef70dd8b49c..1bde9aa219ba 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -295,6 +295,9 @@
 #define MTK_GDM1_TX_GPCNT	0x2438
 #define MTK_STAT_OFFSET		0x40
 
+#define MTK_WDMA0_BASE		0x2800
+#define MTK_WDMA1_BASE		0x2c00
+
 /* QDMA descriptor txd4 */
 #define TX_DMA_CHKSUM		(0x7 << 29)
 #define TX_DMA_TSO		BIT(28)
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
new file mode 100644
index 000000000000..402afeb7e4c2
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -0,0 +1,837 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2021 Felix Fietkau <nbd@nbd.name> */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/skbuff.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
+#include <linux/debugfs.h>
+#include <linux/soc/mediatek/mtk_wed.h>
+#include "mtk_wed_regs.h"
+#include "mtk_wed.h"
+#include "mtk_ppe.h"
+
+#define MTK_PCIE_BASE(n)		(0x1a143000 + (n) * 0x2000)
+
+#define MTK_WED_PKT_SIZE		1900
+#define MTK_WED_BUF_SIZE		2048
+#define MTK_WED_BUF_PER_PAGE		(PAGE_SIZE / 2048)
+
+#define MTK_WED_TX_RING_SIZE		2048
+#define MTK_WED_WDMA_RING_SIZE		1024
+
+static struct mtk_wed_hw *hw_list[2];
+static DEFINE_MUTEX(hw_lock);
+
+static inline void
+wed_m32(struct mtk_wed_device *dev, u32 reg, u32 mask, u32 val)
+{
+	regmap_update_bits(dev->hw->regs, reg, mask | val, val);
+}
+
+static inline void
+wed_set(struct mtk_wed_device *dev, u32 reg, u32 mask)
+{
+	return wed_m32(dev, reg, 0, mask);
+}
+
+static inline void
+wed_clr(struct mtk_wed_device *dev, u32 reg, u32 mask)
+{
+	return wed_m32(dev, reg, mask, 0);
+}
+
+static inline void
+wdma_m32(struct mtk_wed_device *dev, u32 reg, u32 mask, u32 val)
+{
+	wdma_w32(dev, reg, (wdma_r32(dev, reg) & ~mask) | val);
+}
+
+static inline void
+wdma_clr(struct mtk_wed_device *dev, u32 reg, u32 mask)
+{
+	wdma_m32(dev, reg, mask, 0);
+}
+
+static inline void
+wdma_set(struct mtk_wed_device *dev, u32 reg, u32 mask)
+{
+	wdma_m32(dev, reg, 0, mask);
+}
+
+static void
+mtk_wed_reset(struct mtk_wed_device *dev, u32 mask)
+{
+	int i;
+
+	wed_w32(dev, MTK_WED_RESET, mask);
+	for (i = 0; i < 100; i++) {
+		if (wed_r32(dev, MTK_WED_RESET) & mask)
+			continue;
+
+		return;
+	}
+
+	WARN_ON_ONCE(1);
+}
+
+static struct mtk_wed_hw *
+mtk_wed_assign(struct mtk_wed_device *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
+		struct mtk_wed_hw *hw = hw_list[i];
+
+		if (!hw || hw->wed_dev)
+			continue;
+
+		hw->wed_dev = dev;
+		return hw;
+	}
+
+	return NULL;
+}
+
+static int
+mtk_wed_buffer_alloc(struct mtk_wed_device *dev)
+{
+	struct mtk_wdma_desc *desc;
+	dma_addr_t desc_phys;
+	void **page_list;
+	int token = dev->wlan.token_start;
+	int ring_size;
+	int n_pages;
+	int i, page_idx;
+
+	ring_size = dev->wlan.nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
+	n_pages = ring_size / MTK_WED_BUF_PER_PAGE;
+
+	page_list = kcalloc(n_pages, sizeof(*page_list), GFP_KERNEL);
+	if (!page_list)
+		return -ENOMEM;
+
+	dev->buf_ring.size = ring_size;
+	dev->buf_ring.pages = page_list;
+
+	desc = dma_alloc_coherent(dev->hw->dev, ring_size * sizeof(*desc),
+				  &desc_phys, GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	dev->buf_ring.desc = desc;
+	dev->buf_ring.desc_phys = desc_phys;
+
+	for (i = 0, page_idx = 0; i < ring_size; i += MTK_WED_BUF_PER_PAGE) {
+		dma_addr_t page_phys, buf_phys;
+		struct page *page;
+		void *buf;
+		int s;
+
+		page = __dev_alloc_pages(GFP_KERNEL, 0);
+		if (!page)
+			return -ENOMEM;
+
+		page_phys = dma_map_page(dev->hw->dev, page, 0, PAGE_SIZE,
+					 DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev->hw->dev, page_phys)) {
+			__free_page(page);
+			return -ENOMEM;
+		}
+
+		page_list[page_idx++] = page;
+		dma_sync_single_for_cpu(dev->hw->dev, page_phys, PAGE_SIZE,
+					DMA_BIDIRECTIONAL);
+
+		buf = page_to_virt(page);
+		buf_phys = page_phys;
+
+		for (s = 0; s < MTK_WED_BUF_PER_PAGE; s++) {
+			u32 txd_size;
+
+			txd_size = dev->wlan.init_buf(buf, buf_phys, token++);
+
+			desc->buf0 = buf_phys;
+			desc->buf1 = buf_phys + txd_size;
+			desc->ctrl = FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN0,
+						txd_size) |
+				     FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN1,
+						MTK_WED_BUF_SIZE - txd_size) |
+				     MTK_WDMA_DESC_CTRL_LAST_SEG1;
+			desc->info = 0;
+			desc++;
+
+			buf += MTK_WED_BUF_SIZE;
+			buf_phys += MTK_WED_BUF_SIZE;
+		}
+
+		dma_sync_single_for_device(dev->hw->dev, page_phys, PAGE_SIZE,
+					   DMA_BIDIRECTIONAL);
+	}
+
+	return 0;
+}
+
+static void
+mtk_wed_free_buffer(struct mtk_wed_device *dev)
+{
+	struct mtk_wdma_desc *desc = dev->buf_ring.desc;
+	void **page_list = dev->buf_ring.pages;
+	int page_idx;
+	int i;
+
+	if (!page_list)
+		return;
+
+	if (!desc)
+		goto free_pagelist;
+
+	for (i = 0, page_idx = 0; i < dev->buf_ring.size; i += MTK_WED_BUF_PER_PAGE) {
+		void *page = page_list[page_idx++];
+
+		if (!page)
+			break;
+
+		dma_unmap_page(dev->hw->dev, desc[i].buf0,
+			       PAGE_SIZE, DMA_BIDIRECTIONAL);
+		__free_page(page);
+	}
+
+	dma_free_coherent(dev->hw->dev, dev->buf_ring.size * sizeof(*desc),
+			  desc, dev->buf_ring.desc_phys);
+
+free_pagelist:
+	kfree(page_list);
+}
+
+static void
+mtk_wed_free_ring(struct mtk_wed_device *dev, struct mtk_wed_ring *ring)
+{
+	if (!ring->desc)
+		return;
+
+	dma_free_coherent(dev->hw->dev, ring->size * sizeof(*ring->desc),
+			  ring->desc, ring->desc_phys);
+}
+
+static void
+mtk_wed_free_tx_rings(struct mtk_wed_device *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
+		mtk_wed_free_ring(dev, &dev->tx_ring[i]);
+	for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
+		mtk_wed_free_ring(dev, &dev->tx_wdma[i]);
+}
+
+static void
+mtk_wed_set_ext_int(struct mtk_wed_device *dev, bool en)
+{
+	wed_w32(dev, MTK_WED_EXT_INT_MASK,
+		en ? MTK_WED_EXT_INT_STATUS_ERROR_MASK : 0);
+	wed_r32(dev, MTK_WED_EXT_INT_MASK);
+}
+
+static void
+mtk_wed_stop(struct mtk_wed_device *dev)
+{
+	int pcie_idx = !!pci_domain_nr(dev->wlan.pci_dev->bus);
+
+	regmap_write(dev->hw->mirror, pcie_idx * 4, 0);
+	mtk_wed_set_ext_int(dev, false);
+
+	wed_clr(dev, MTK_WED_CTRL,
+		MTK_WED_CTRL_WDMA_INT_AGENT_EN |
+		MTK_WED_CTRL_WPDMA_INT_AGENT_EN |
+		MTK_WED_CTRL_WED_TX_BM_EN |
+		MTK_WED_CTRL_WED_TX_FREE_AGENT_EN);
+	wed_w32(dev, MTK_WED_WPDMA_INT_TRIGGER, 0);
+	wed_w32(dev, MTK_WED_WDMA_INT_TRIGGER, 0);
+	wdma_w32(dev, MTK_WDMA_INT_MASK, 0);
+	wdma_w32(dev, MTK_WDMA_INT_GRP2, 0);
+	wed_w32(dev, MTK_WED_WPDMA_INT_MASK, 0);
+
+	wed_clr(dev, MTK_WED_GLO_CFG,
+		MTK_WED_GLO_CFG_TX_DMA_EN |
+		MTK_WED_GLO_CFG_RX_DMA_EN);
+	wed_clr(dev, MTK_WED_WPDMA_GLO_CFG,
+		MTK_WED_WPDMA_GLO_CFG_TX_DRV_EN |
+		MTK_WED_WPDMA_GLO_CFG_RX_DRV_EN);
+	wed_clr(dev, MTK_WED_WDMA_GLO_CFG,
+		MTK_WED_WDMA_GLO_CFG_RX_DRV_EN);
+}
+
+static void
+mtk_wed_detach(struct mtk_wed_device *dev)
+{
+	struct mtk_wed_hw *hw = dev->hw;
+
+	mutex_lock(&hw_lock);
+
+	mtk_wed_stop(dev);
+
+	wdma_w32(dev, MTK_WDMA_RESET_IDX, MTK_WDMA_RESET_IDX_RX);
+	wdma_w32(dev, MTK_WDMA_RESET_IDX, 0);
+
+	mtk_wed_reset(dev, MTK_WED_RESET_WED);
+
+	mtk_wed_free_buffer(dev);
+	mtk_wed_free_tx_rings(dev);
+
+	memset(dev, 0, sizeof(*dev));
+	module_put(THIS_MODULE);
+
+	hw->wed_dev = NULL;
+	mutex_unlock(&hw_lock);
+}
+
+static void
+mtk_wed_hw_init_early(struct mtk_wed_device *dev)
+{
+	int pcie_idx = !!pci_domain_nr(dev->wlan.pci_dev->bus);
+	u32 mask, set;
+	u32 offset;
+
+	mtk_wed_stop(dev);
+	mtk_wed_reset(dev, MTK_WED_RESET_WED);
+
+	mask = MTK_WED_WDMA_GLO_CFG_BT_SIZE |
+	       MTK_WED_WDMA_GLO_CFG_DYNAMIC_DMAD_RECYCLE |
+	       MTK_WED_WDMA_GLO_CFG_RX_DIS_FSM_AUTO_IDLE;
+	set = FIELD_PREP(MTK_WED_WDMA_GLO_CFG_BT_SIZE, 2) |
+	      MTK_WED_WDMA_GLO_CFG_DYNAMIC_SKIP_DMAD_PREP |
+	      MTK_WED_WDMA_GLO_CFG_IDLE_DMAD_SUPPLY;
+	wed_m32(dev, MTK_WED_WDMA_GLO_CFG, mask, set);
+
+	wdma_set(dev, MTK_WDMA_GLO_CFG, MTK_WDMA_GLO_CFG_RX_INFO_PRERES);
+
+	offset = dev->hw->index ? 0x04000400 : 0;
+	wed_w32(dev, MTK_WED_WDMA_OFFSET0, 0x2a042a20 + offset);
+	wed_w32(dev, MTK_WED_WDMA_OFFSET1, 0x29002800 + offset);
+
+	wed_w32(dev, MTK_WED_PCIE_CFG_BASE, MTK_PCIE_BASE(pcie_idx));
+	wed_w32(dev, MTK_WED_WPDMA_CFG_BASE, dev->wlan.wpdma_phys);
+}
+
+static void
+mtk_wed_hw_init(struct mtk_wed_device *dev)
+{
+	if (dev->init_done)
+		return;
+
+	dev->init_done = true;
+	mtk_wed_set_ext_int(dev, false);
+	wed_w32(dev, MTK_WED_TX_BM_CTRL,
+		MTK_WED_TX_BM_CTRL_PAUSE |
+		FIELD_PREP(MTK_WED_TX_BM_CTRL_VLD_GRP_NUM,
+			   dev->buf_ring.size / 128) |
+		FIELD_PREP(MTK_WED_TX_BM_CTRL_RSV_GRP_NUM,
+			   MTK_WED_TX_RING_SIZE / 256));
+
+	wed_w32(dev, MTK_WED_TX_BM_BASE, dev->buf_ring.desc_phys);
+
+	wed_w32(dev, MTK_WED_TX_BM_TKID,
+		FIELD_PREP(MTK_WED_TX_BM_TKID_START,
+			   dev->wlan.token_start) |
+		FIELD_PREP(MTK_WED_TX_BM_TKID_END,
+			   dev->wlan.token_start + dev->wlan.nbuf));
+
+	wed_w32(dev, MTK_WED_TX_BM_BUF_LEN, MTK_WED_PKT_SIZE);
+
+	wed_w32(dev, MTK_WED_TX_BM_DYN_THR,
+		FIELD_PREP(MTK_WED_TX_BM_DYN_THR_LO, 1) |
+		MTK_WED_TX_BM_DYN_THR_HI);
+
+	mtk_wed_reset(dev, MTK_WED_RESET_TX_BM);
+
+	wed_set(dev, MTK_WED_CTRL,
+		MTK_WED_CTRL_WED_TX_BM_EN |
+		MTK_WED_CTRL_WED_TX_FREE_AGENT_EN);
+
+	wed_clr(dev, MTK_WED_TX_BM_CTRL, MTK_WED_TX_BM_CTRL_PAUSE);
+}
+
+static void
+mtk_wed_ring_reset(struct mtk_wdma_desc *desc, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		desc[i].buf0 = 0;
+		desc[i].ctrl = cpu_to_le32(MTK_WDMA_DESC_CTRL_DMA_DONE);
+		desc[i].buf1 = 0;
+		desc[i].info = 0;
+	}
+}
+
+static u32
+mtk_wed_check_busy(struct mtk_wed_device *dev)
+{
+	if (wed_r32(dev, MTK_WED_GLO_CFG) & MTK_WED_GLO_CFG_TX_DMA_BUSY)
+		return true;
+
+	if (wed_r32(dev, MTK_WED_WPDMA_GLO_CFG) &
+	    MTK_WED_WPDMA_GLO_CFG_TX_DRV_BUSY)
+		return true;
+
+	if (wed_r32(dev, MTK_WED_CTRL) & MTK_WED_CTRL_WDMA_INT_AGENT_BUSY)
+		return true;
+
+	if (wed_r32(dev, MTK_WED_WDMA_GLO_CFG) &
+	    MTK_WED_WDMA_GLO_CFG_RX_DRV_BUSY)
+		return true;
+
+	if (wdma_r32(dev, MTK_WDMA_GLO_CFG) &
+	    MTK_WED_WDMA_GLO_CFG_RX_DRV_BUSY)
+		return true;
+
+	if (wed_r32(dev, MTK_WED_CTRL) &
+	    (MTK_WED_CTRL_WED_TX_BM_BUSY | MTK_WED_CTRL_WED_TX_FREE_AGENT_BUSY))
+		return true;
+
+	return false;
+}
+
+static int
+mtk_wed_poll_busy(struct mtk_wed_device *dev)
+{
+	int sleep = 15000;
+	int timeout = 100 * sleep;
+	u32 val;
+
+	return read_poll_timeout(mtk_wed_check_busy, val, !val, sleep,
+				 timeout, false, dev);
+}
+
+static void
+mtk_wed_reset_dma(struct mtk_wed_device *dev)
+{
+	bool busy = false;
+	u32 val;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++) {
+		struct mtk_wdma_desc *desc = dev->tx_ring[i].desc;
+
+		if (!desc)
+			continue;
+
+		mtk_wed_ring_reset(desc, MTK_WED_TX_RING_SIZE);
+	}
+
+	if (mtk_wed_poll_busy(dev))
+		busy = mtk_wed_check_busy(dev);
+
+	if (busy) {
+		mtk_wed_reset(dev, MTK_WED_RESET_WED_TX_DMA);
+	} else {
+		wed_w32(dev, MTK_WED_RESET_IDX,
+			MTK_WED_RESET_IDX_TX |
+			MTK_WED_RESET_IDX_RX);
+		wed_w32(dev, MTK_WED_RESET_IDX, 0);
+	}
+
+	wdma_w32(dev, MTK_WDMA_RESET_IDX, MTK_WDMA_RESET_IDX_RX);
+	wdma_w32(dev, MTK_WDMA_RESET_IDX, 0);
+
+	if (busy) {
+		mtk_wed_reset(dev, MTK_WED_RESET_WDMA_INT_AGENT);
+		mtk_wed_reset(dev, MTK_WED_RESET_WDMA_RX_DRV);
+	} else {
+		wed_w32(dev, MTK_WED_WDMA_RESET_IDX,
+			MTK_WED_WDMA_RESET_IDX_RX | MTK_WED_WDMA_RESET_IDX_DRV);
+		wed_w32(dev, MTK_WED_WDMA_RESET_IDX, 0);
+
+		wed_set(dev, MTK_WED_WDMA_GLO_CFG,
+			MTK_WED_WDMA_GLO_CFG_RST_INIT_COMPLETE);
+
+		wed_clr(dev, MTK_WED_WDMA_GLO_CFG,
+			MTK_WED_WDMA_GLO_CFG_RST_INIT_COMPLETE);
+	}
+
+	for (i = 0; i < 100; i++) {
+		val = wed_r32(dev, MTK_WED_TX_BM_INTF);
+		if (FIELD_GET(MTK_WED_TX_BM_INTF_TKFIFO_FDEP, val) == 0x40)
+			break;
+	}
+
+	mtk_wed_reset(dev, MTK_WED_RESET_TX_FREE_AGENT);
+	mtk_wed_reset(dev, MTK_WED_RESET_TX_BM);
+
+	if (busy) {
+		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_INT_AGENT);
+		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_TX_DRV);
+		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_RX_DRV);
+	} else {
+		wed_w32(dev, MTK_WED_WPDMA_RESET_IDX,
+			MTK_WED_WPDMA_RESET_IDX_TX |
+			MTK_WED_WPDMA_RESET_IDX_RX);
+		wed_w32(dev, MTK_WED_WPDMA_RESET_IDX, 0);
+	}
+
+}
+
+static int
+mtk_wed_ring_alloc(struct mtk_wed_device *dev, struct mtk_wed_ring *ring,
+		   int size)
+{
+	ring->desc = dma_alloc_coherent(dev->hw->dev,
+					size * sizeof(*ring->desc),
+					&ring->desc_phys, GFP_KERNEL);
+	if (!ring->desc)
+		return -ENOMEM;
+
+	ring->size = size;
+	mtk_wed_ring_reset(ring->desc, size);
+
+	return 0;
+}
+
+static int
+mtk_wed_wdma_ring_setup(struct mtk_wed_device *dev, int idx, int size)
+{
+	struct mtk_wed_ring *wdma = &dev->tx_wdma[idx];
+
+	if (mtk_wed_ring_alloc(dev, wdma, MTK_WED_WDMA_RING_SIZE))
+		return -ENOMEM;
+
+	wdma_w32(dev, MTK_WDMA_RING_RX(idx) + MTK_WED_RING_OFS_BASE,
+		 wdma->desc_phys);
+	wdma_w32(dev, MTK_WDMA_RING_RX(idx) + MTK_WED_RING_OFS_COUNT,
+		 size);
+	wdma_w32(dev, MTK_WDMA_RING_RX(idx) + MTK_WED_RING_OFS_CPU_IDX, 0);
+
+	wed_w32(dev, MTK_WED_WDMA_RING_RX(idx) + MTK_WED_RING_OFS_BASE,
+		wdma->desc_phys);
+	wed_w32(dev, MTK_WED_WDMA_RING_RX(idx) + MTK_WED_RING_OFS_COUNT,
+		size);
+
+	return 0;
+}
+
+static void
+mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
+{
+	int pcie_idx = !!pci_domain_nr(dev->wlan.pci_dev->bus);
+	u32 wdma_mask;
+	u32 val;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
+		if (!dev->tx_wdma[i].desc)
+			mtk_wed_wdma_ring_setup(dev, i, 16);
+
+	wdma_mask = FIELD_PREP(MTK_WDMA_INT_MASK_RX_DONE, GENMASK(1, 0));
+
+	mtk_wed_hw_init(dev);
+
+	wed_set(dev, MTK_WED_CTRL,
+		MTK_WED_CTRL_WDMA_INT_AGENT_EN |
+		MTK_WED_CTRL_WPDMA_INT_AGENT_EN |
+		MTK_WED_CTRL_WED_TX_BM_EN |
+		MTK_WED_CTRL_WED_TX_FREE_AGENT_EN);
+
+	wed_w32(dev, MTK_WED_PCIE_INT_TRIGGER, MTK_WED_PCIE_INT_TRIGGER_STATUS);
+
+	wed_w32(dev, MTK_WED_WPDMA_INT_TRIGGER,
+		MTK_WED_WPDMA_INT_TRIGGER_RX_DONE |
+		MTK_WED_WPDMA_INT_TRIGGER_TX_DONE);
+
+	wed_set(dev, MTK_WED_WPDMA_INT_CTRL,
+		MTK_WED_WPDMA_INT_CTRL_SUBRT_ADV);
+
+	wed_w32(dev, MTK_WED_WDMA_INT_TRIGGER, wdma_mask);
+	wed_clr(dev, MTK_WED_WDMA_INT_CTRL, wdma_mask);
+
+	wdma_w32(dev, MTK_WDMA_INT_MASK, wdma_mask);
+	wdma_w32(dev, MTK_WDMA_INT_GRP2, wdma_mask);
+
+	wed_w32(dev, MTK_WED_WPDMA_INT_MASK, irq_mask);
+	wed_w32(dev, MTK_WED_INT_MASK, irq_mask);
+
+	wed_set(dev, MTK_WED_GLO_CFG,
+		MTK_WED_GLO_CFG_TX_DMA_EN |
+		MTK_WED_GLO_CFG_RX_DMA_EN);
+	wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
+		MTK_WED_WPDMA_GLO_CFG_TX_DRV_EN |
+		MTK_WED_WPDMA_GLO_CFG_RX_DRV_EN);
+	wed_set(dev, MTK_WED_WDMA_GLO_CFG,
+		MTK_WED_WDMA_GLO_CFG_RX_DRV_EN);
+
+	mtk_wed_set_ext_int(dev, true);
+	val = dev->wlan.wpdma_phys |
+	      MTK_PCIE_MIRROR_MAP_EN |
+	      FIELD_PREP(MTK_PCIE_MIRROR_MAP_WED_ID, dev->hw->index);
+
+	if (dev->hw->index)
+		val |= BIT(1);
+	val |= BIT(0);
+	regmap_write(dev->hw->mirror, pcie_idx * 4, val);
+
+	dev->running = true;
+}
+
+static int
+mtk_wed_attach(struct mtk_wed_device *dev)
+{
+	struct mtk_wed_hw *hw;
+	int ret = 0;
+
+	if (pci_domain_nr(dev->wlan.pci_dev->bus) > 1)
+		return -ENODEV;
+
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	mutex_lock(&hw_lock);
+
+	hw = mtk_wed_assign(dev);
+	if (!hw) {
+		module_put(THIS_MODULE);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	dev->hw = hw;
+	dev->irq = hw->irq;
+	dev->wdma_idx = hw->index;
+
+	ret = mtk_wed_buffer_alloc(dev);
+	if (ret) {
+		mtk_wed_detach(dev);
+		goto out;
+	}
+
+	mtk_wed_hw_init_early(dev);
+
+out:
+	mutex_unlock(&hw_lock);
+
+	return ret;
+}
+
+static int
+mtk_wed_tx_ring_setup(struct mtk_wed_device *dev, int idx, void __iomem *regs)
+{
+	struct mtk_wed_ring *ring = &dev->tx_ring[idx];
+
+	/*
+	 * Tx ring redirection:
+	 * Instead of configuring the WLAN PDMA TX ring directly, the WLAN
+	 * driver allocated DMA ring gets configured into WED MTK_WED_RING_TX(n)
+	 * registers.
+	 *
+	 * WED driver posts its own DMA ring as WLAN PDMA TX and configures it
+	 * into MTK_WED_WPDMA_RING_TX(n) registers.
+	 * It gets filled with packets picked up from WED TX ring and from
+	 * WDMA RX.
+	 */
+
+	BUG_ON(idx > ARRAY_SIZE(dev->tx_ring));
+
+	if (mtk_wed_ring_alloc(dev, ring, MTK_WED_TX_RING_SIZE))
+		return -ENOMEM;
+
+	if (mtk_wed_wdma_ring_setup(dev, idx, MTK_WED_WDMA_RING_SIZE))
+		return -ENOMEM;
+
+	ring->reg_base = MTK_WED_RING_TX(idx);
+	ring->wpdma = regs;
+
+	/* WED -> WPDMA */
+	wpdma_tx_w32(dev, idx, MTK_WED_RING_OFS_BASE, ring->desc_phys);
+	wpdma_tx_w32(dev, idx, MTK_WED_RING_OFS_COUNT, MTK_WED_TX_RING_SIZE);
+	wpdma_tx_w32(dev, idx, MTK_WED_RING_OFS_CPU_IDX, 0);
+
+	wed_w32(dev, MTK_WED_WPDMA_RING_TX(idx) + MTK_WED_RING_OFS_BASE,
+		ring->desc_phys);
+	wed_w32(dev, MTK_WED_WPDMA_RING_TX(idx) + MTK_WED_RING_OFS_COUNT,
+		MTK_WED_TX_RING_SIZE);
+	wed_w32(dev, MTK_WED_WPDMA_RING_TX(idx) + MTK_WED_RING_OFS_CPU_IDX, 0);
+
+	return 0;
+}
+
+static int
+mtk_wed_txfree_ring_setup(struct mtk_wed_device *dev, void __iomem *regs)
+{
+	struct mtk_wed_ring *ring = &dev->txfree_ring;
+	int i;
+
+	/*
+	 * For txfree event handling, the same DMA ring is shared between WED
+	 * and WLAN. The WLAN driver accesses the ring index registers through
+	 * WED
+	 */
+	ring->reg_base = MTK_WED_RING_RX(1);
+	ring->wpdma = regs;
+
+	for (i = 0; i < 12; i += 4) {
+		u32 val = readl(regs + i);
+
+		wed_w32(dev, MTK_WED_RING_RX(1) + i, val);
+		wed_w32(dev, MTK_WED_WPDMA_RING_RX(1) + i, val);
+	}
+
+	return 0;
+}
+
+static u32
+mtk_wed_irq_get(struct mtk_wed_device *dev, u32 mask)
+{
+	u32 val;
+
+	val = wed_r32(dev, MTK_WED_EXT_INT_STATUS);
+	wed_w32(dev, MTK_WED_EXT_INT_STATUS, val);
+	val &= MTK_WED_EXT_INT_STATUS_ERROR_MASK;
+	WARN_RATELIMIT(val, "mtk_wed%d: error status=%08x\n",
+		       dev->hw->index, val);
+
+	val = wed_r32(dev, MTK_WED_INT_STATUS);
+	val &= mask;
+	wed_w32(dev, MTK_WED_INT_STATUS, val); /* ACK */
+
+	return val;
+}
+
+static void
+mtk_wed_irq_set_mask(struct mtk_wed_device *dev, u32 mask)
+{
+	if (!dev->running)
+		return;
+
+	mtk_wed_set_ext_int(dev, !!mask);
+	wed_w32(dev, MTK_WED_INT_MASK, mask);
+}
+
+int mtk_wed_flow_add(int index)
+{
+	struct mtk_wed_hw *hw = hw_list[index];
+	int ret;
+
+	if (!hw || !hw->wed_dev)
+		return -ENODEV;
+
+	if (hw->num_flows) {
+		hw->num_flows++;
+		return 0;
+	}
+
+	mutex_lock(&hw_lock);
+	if (!hw->wed_dev)
+		ret = -ENODEV;
+	else
+		ret = hw->wed_dev->wlan.offload_enable(hw->wed_dev);
+	if (!ret)
+		hw->num_flows++;
+	mutex_unlock(&hw_lock);
+
+	return ret;
+}
+
+void mtk_wed_flow_remove(int index)
+{
+	struct mtk_wed_hw *hw = hw_list[index];
+
+	if (!hw)
+		return;
+
+	if (--hw->num_flows)
+		return;
+
+	mutex_lock(&hw_lock);
+	if (hw->wed_dev)
+		hw->wed_dev->wlan.offload_disable(hw->wed_dev);
+	mutex_unlock(&hw_lock);
+}
+
+void mtk_wed_add_hw(struct device_node *np, void __iomem *wdma,
+		    void __iomem *mirror, int index)
+{
+	static const struct mtk_wed_ops wed_ops = {
+		.attach = mtk_wed_attach,
+		.tx_ring_setup = mtk_wed_tx_ring_setup,
+		.txfree_ring_setup = mtk_wed_txfree_ring_setup,
+		.start = mtk_wed_start,
+		.stop = mtk_wed_stop,
+		.reset_dma = mtk_wed_reset_dma,
+		.reg_read = wed_r32,
+		.reg_write = wed_w32,
+		.irq_get = mtk_wed_irq_get,
+		.irq_set_mask = mtk_wed_irq_set_mask,
+		.detach = mtk_wed_detach,
+	};
+	struct platform_device *pdev;
+	struct mtk_wed_hw *hw;
+	struct regmap *regs;
+	int irq;
+
+	if (!np)
+		return;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return;
+
+	get_device(&pdev->dev);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return;
+
+	regs = syscon_regmap_lookup_by_phandle(np, NULL);
+	if (!regs)
+		return;
+
+	rcu_assign_pointer(mtk_soc_wed_ops, &wed_ops);
+
+	mutex_lock(&hw_lock);
+
+	if (WARN_ON(hw_list[index]))
+		goto unlock;
+
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	hw->node = np;
+	hw->regs = regs;
+	hw->dev = &pdev->dev;
+	hw->wdma = wdma;
+	hw->index = index;
+	hw->irq = irq;
+	hw->mirror = mirror;
+	if (!index) {
+		regmap_write(mirror, 0, 0);
+		regmap_write(mirror, 4, 0);
+	}
+	mtk_wed_hw_add_debugfs(hw);
+
+	hw_list[index] = hw;
+
+unlock:
+	mutex_unlock(&hw_lock);
+}
+
+void mtk_wed_exit(void)
+{
+	int i;
+
+	rcu_assign_pointer(mtk_soc_wed_ops, NULL);
+
+	synchronize_rcu();
+
+	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
+		struct mtk_wed_hw *hw;
+
+		hw = hw_list[i];
+		if (!hw)
+			continue;
+
+		hw_list[i] = NULL;
+		debugfs_remove(hw->debugfs_dir);
+		put_device(hw->dev);
+		kfree(hw);
+	}
+}
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.h b/drivers/net/ethernet/mediatek/mtk_wed.h
new file mode 100644
index 000000000000..6a424dc4c249
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mtk_wed.h
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2021 Felix Fietkau <nbd@nbd.name> */
+
+#ifndef __MTK_WED_PRIV_H
+#define __MTK_WED_PRIV_H
+
+#include <linux/soc/mediatek/mtk_wed.h>
+#include <linux/debugfs.h>
+#include <linux/regmap.h>
+
+struct mtk_wed_hw {
+	struct device_node *node;
+	struct regmap *regs;
+	struct device *dev;
+	void __iomem *wdma;
+	struct regmap *mirror;
+	struct dentry *debugfs_dir;
+	struct mtk_wed_device *wed_dev;
+	u32 debugfs_reg;
+	u32 num_flows;
+	char dirname[5];
+	int irq;
+	int index;
+};
+
+static inline void
+wed_w32(struct mtk_wed_device *dev, u32 reg, u32 val)
+{
+	regmap_write(dev->hw->regs, reg, val);
+}
+
+static inline u32
+wed_r32(struct mtk_wed_device *dev, u32 reg)
+{
+	unsigned int val;
+
+	regmap_read(dev->hw->regs, reg, &val);
+
+	return val;
+}
+
+static inline void
+wdma_w32(struct mtk_wed_device *dev, u32 reg, u32 val)
+{
+	writel(val, dev->hw->wdma + reg);
+}
+
+static inline u32
+wdma_r32(struct mtk_wed_device *dev, u32 reg)
+{
+	return readl(dev->hw->wdma + reg);
+}
+
+static inline u32
+wpdma_tx_r32(struct mtk_wed_device *dev, int ring, u32 reg)
+{
+	if (!dev->tx_ring[ring].wpdma)
+		return 0;
+
+	return readl(dev->tx_ring[ring].wpdma + reg);
+}
+
+static inline void
+wpdma_tx_w32(struct mtk_wed_device *dev, int ring, u32 reg, u32 val)
+{
+	if (!dev->tx_ring[ring].wpdma)
+		return;
+
+	writel(val, dev->tx_ring[ring].wpdma + reg);
+}
+
+static inline u32
+wpdma_txfree_r32(struct mtk_wed_device *dev, u32 reg)
+{
+	if (!dev->txfree_ring.wpdma)
+		return 0;
+
+	return readl(dev->txfree_ring.wpdma + reg);
+}
+
+static inline void
+wpdma_txfree_w32(struct mtk_wed_device *dev, u32 reg, u32 val)
+{
+	if (!dev->txfree_ring.wpdma)
+		return;
+
+	writel(val, dev->txfree_ring.wpdma + reg);
+}
+
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+void mtk_wed_add_hw(struct device_node *np, void __iomem *wdma,
+		    void __iomem *mirror, int index);
+void mtk_wed_exit(void);
+int mtk_wed_flow_add(int index);
+void mtk_wed_flow_remove(int index);
+#else
+static inline void
+mtk_wed_add_hw(struct device_node *np, void __iomem *wdma,
+	       void __iomem *mirror, int index)
+{
+}
+static inline void
+mtk_wed_exit(void)
+{
+}
+static inline int mtk_wed_flow_add(int index)
+{
+	return -EINVAL;
+}
+static inline void mtk_wed_flow_remove(int index)
+{
+}
+#endif
+
+#ifdef CONFIG_DEBUG_FS
+void mtk_wed_hw_add_debugfs(struct mtk_wed_hw *hw);
+#else
+static inline void mtk_wed_hw_add_debugfs(struct mtk_wed_hw *hw)
+{
+}
+#endif
+
+#endif
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
new file mode 100644
index 000000000000..a81d3fd1a439
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2021 Felix Fietkau <nbd@nbd.name> */
+
+#include <linux/seq_file.h>
+#include "mtk_wed.h"
+#include "mtk_wed_regs.h"
+
+struct reg_dump {
+	const char *name;
+	u16 offset;
+	u8 type;
+	u8 base;
+};
+
+enum {
+	DUMP_TYPE_STRING,
+	DUMP_TYPE_WED,
+	DUMP_TYPE_WDMA,
+	DUMP_TYPE_WPDMA_TX,
+	DUMP_TYPE_WPDMA_TXFREE,
+};
+
+#define DUMP_STR(_str) { _str, 0, DUMP_TYPE_STRING }
+#define DUMP_REG(_reg, ...) { #_reg, MTK_##_reg, __VA_ARGS__ }
+#define DUMP_RING(_prefix, _base, ...)				\
+	{ _prefix " BASE", _base, __VA_ARGS__ },		\
+	{ _prefix " CNT",  _base + 0x4, __VA_ARGS__ },	\
+	{ _prefix " CIDX", _base + 0x8, __VA_ARGS__ },	\
+	{ _prefix " DIDX", _base + 0xc, __VA_ARGS__ }
+
+#define DUMP_WED(_reg) DUMP_REG(_reg, DUMP_TYPE_WED)
+#define DUMP_WED_RING(_base) DUMP_RING(#_base, MTK_##_base, DUMP_TYPE_WED)
+
+#define DUMP_WDMA(_reg) DUMP_REG(_reg, DUMP_TYPE_WDMA)
+#define DUMP_WDMA_RING(_base) DUMP_RING(#_base, MTK_##_base, DUMP_TYPE_WDMA)
+
+#define DUMP_WPDMA_TX_RING(_n) DUMP_RING("WPDMA_TX" #_n, 0, DUMP_TYPE_WPDMA_TX, _n)
+#define DUMP_WPDMA_TXFREE_RING DUMP_RING("WPDMA_RX1", 0, DUMP_TYPE_WPDMA_TXFREE)
+
+static void
+print_reg_val(struct seq_file *s, const char *name, u32 val)
+{
+	seq_printf(s, "%-32s %08x\n", name, val);
+}
+
+static void
+dump_wed_regs(struct seq_file *s, struct mtk_wed_device *dev,
+	      const struct reg_dump *regs, int n_regs)
+{
+	const struct reg_dump *cur;
+	u32 val;
+
+	for (cur = regs; cur < &regs[n_regs]; cur++) {
+		switch (cur->type) {
+		case DUMP_TYPE_STRING:
+			seq_printf(s, "%s======== %s:\n",
+				   cur > regs ? "\n" : "",
+				   cur->name);
+			continue;
+		case DUMP_TYPE_WED:
+			val = wed_r32(dev, cur->offset);
+			break;
+		case DUMP_TYPE_WDMA:
+			val = wdma_r32(dev, cur->offset);
+			break;
+		case DUMP_TYPE_WPDMA_TX:
+			val = wpdma_tx_r32(dev, cur->base, cur->offset);
+			break;
+		case DUMP_TYPE_WPDMA_TXFREE:
+			val = wpdma_txfree_r32(dev, cur->offset);
+			break;
+		}
+		print_reg_val(s, cur->name, val);
+	}
+}
+
+
+static int
+wed_txinfo_show(struct seq_file *s, void *data)
+{
+	static const struct reg_dump regs[] = {
+		DUMP_STR("WED TX"),
+		DUMP_WED(WED_TX_MIB(0)),
+		DUMP_WED_RING(WED_RING_TX(0)),
+
+		DUMP_WED(WED_TX_MIB(1)),
+		DUMP_WED_RING(WED_RING_TX(1)),
+
+		DUMP_STR("WPDMA TX"),
+		DUMP_WED(WED_WPDMA_TX_MIB(0)),
+		DUMP_WED_RING(WED_WPDMA_RING_TX(0)),
+		DUMP_WED(WED_WPDMA_TX_COHERENT_MIB(0)),
+
+		DUMP_WED(WED_WPDMA_TX_MIB(1)),
+		DUMP_WED_RING(WED_WPDMA_RING_TX(1)),
+		DUMP_WED(WED_WPDMA_TX_COHERENT_MIB(1)),
+
+		DUMP_STR("WPDMA TX"),
+		DUMP_WPDMA_TX_RING(0),
+		DUMP_WPDMA_TX_RING(1),
+
+		DUMP_STR("WED WDMA RX"),
+		DUMP_WED(WED_WDMA_RX_MIB(0)),
+		DUMP_WED_RING(WED_WDMA_RING_RX(0)),
+		DUMP_WED(WED_WDMA_RX_THRES(0)),
+		DUMP_WED(WED_WDMA_RX_RECYCLE_MIB(0)),
+		DUMP_WED(WED_WDMA_RX_PROCESSED_MIB(0)),
+
+		DUMP_WED(WED_WDMA_RX_MIB(1)),
+		DUMP_WED_RING(WED_WDMA_RING_RX(1)),
+		DUMP_WED(WED_WDMA_RX_THRES(1)),
+		DUMP_WED(WED_WDMA_RX_RECYCLE_MIB(1)),
+		DUMP_WED(WED_WDMA_RX_PROCESSED_MIB(1)),
+
+		DUMP_STR("WDMA RX"),
+		DUMP_WDMA(WDMA_GLO_CFG),
+		DUMP_WDMA_RING(WDMA_RING_RX(0)),
+		DUMP_WDMA_RING(WDMA_RING_RX(1)),
+	};
+	struct mtk_wed_hw *hw = s->private;
+	struct mtk_wed_device *dev = hw->wed_dev;
+
+	if (!dev)
+		return 0;
+
+	dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(wed_txinfo);
+
+
+static int
+mtk_wed_reg_set(void *data, u64 val)
+{
+	struct mtk_wed_hw *hw = data;
+
+	regmap_write(hw->regs, hw->debugfs_reg, val);
+
+	return 0;
+}
+
+static int
+mtk_wed_reg_get(void *data, u64 *val)
+{
+	struct mtk_wed_hw *hw = data;
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(hw->regs, hw->debugfs_reg, &regval);
+	if (ret)
+		return ret;
+
+	*val = regval;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mtk_wed_reg_get, mtk_wed_reg_set,
+             "0x%08llx\n");
+
+void mtk_wed_hw_add_debugfs(struct mtk_wed_hw *hw)
+{
+	struct dentry *dir;
+
+	snprintf(hw->dirname, sizeof(hw->dirname), "wed%d", hw->index);
+	dir = debugfs_create_dir(hw->dirname, NULL);
+	if (!dir)
+		return;
+
+	hw->debugfs_dir = dir;
+	debugfs_create_u32("regidx", 0600, dir, &hw->debugfs_reg);
+	debugfs_create_file_unsafe("regval", 0600, dir, hw, &fops_regval);
+	debugfs_create_file_unsafe("txinfo", 0400, dir, hw, &wed_txinfo_fops);
+}
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_ops.c b/drivers/net/ethernet/mediatek/mtk_wed_ops.c
new file mode 100644
index 000000000000..a5d9d8a5bce2
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mtk_wed_ops.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
+
+#include <linux/kernel.h>
+#include <linux/soc/mediatek/mtk_wed.h>
+
+const struct mtk_wed_ops __rcu *mtk_soc_wed_ops;
+EXPORT_SYMBOL_GPL(mtk_soc_wed_ops);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
new file mode 100644
index 000000000000..cbeaa0876ff4
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
+
+#ifndef __MTK_WED_REGS_H
+#define __MTK_WED_REGS_H
+
+#define MTK_WDMA_DESC_CTRL_LEN1			GENMASK(14, 0)
+#define MTK_WDMA_DESC_CTRL_LAST_SEG1		BIT(15)
+#define MTK_WDMA_DESC_CTRL_BURST		BIT(16)
+#define MTK_WDMA_DESC_CTRL_LEN0			GENMASK(29, 16)
+#define MTK_WDMA_DESC_CTRL_LAST_SEG0		BIT(30)
+#define MTK_WDMA_DESC_CTRL_DMA_DONE		BIT(31)
+
+struct mtk_wdma_desc {
+	__le32 buf0;
+	__le32 ctrl;
+	__le32 buf1;
+	__le32 info;
+} __packed __aligned(4);
+
+#define MTK_WED_RESET					0x008
+#define MTK_WED_RESET_TX_BM				BIT(0)
+#define MTK_WED_RESET_TX_FREE_AGENT			BIT(4)
+#define MTK_WED_RESET_WPDMA_TX_DRV			BIT(8)
+#define MTK_WED_RESET_WPDMA_RX_DRV			BIT(9)
+#define MTK_WED_RESET_WPDMA_INT_AGENT			BIT(11)
+#define MTK_WED_RESET_WED_TX_DMA			BIT(12)
+#define MTK_WED_RESET_WDMA_RX_DRV			BIT(17)
+#define MTK_WED_RESET_WDMA_INT_AGENT			BIT(19)
+#define MTK_WED_RESET_WED				BIT(31)
+
+#define MTK_WED_CTRL					0x00c
+#define MTK_WED_CTRL_WPDMA_INT_AGENT_EN			BIT(0)
+#define MTK_WED_CTRL_WPDMA_INT_AGENT_BUSY		BIT(1)
+#define MTK_WED_CTRL_WDMA_INT_AGENT_EN			BIT(2)
+#define MTK_WED_CTRL_WDMA_INT_AGENT_BUSY		BIT(3)
+#define MTK_WED_CTRL_WED_TX_BM_EN			BIT(8)
+#define MTK_WED_CTRL_WED_TX_BM_BUSY			BIT(9)
+#define MTK_WED_CTRL_WED_TX_FREE_AGENT_EN		BIT(10)
+#define MTK_WED_CTRL_WED_TX_FREE_AGENT_BUSY		BIT(11)
+#define MTK_WED_CTRL_RESERVE_EN				BIT(12)
+#define MTK_WED_CTRL_RESERVE_BUSY			BIT(13)
+#define MTK_WED_CTRL_FINAL_DIDX_READ			BIT(24)
+#define MTK_WED_CTRL_MIB_READ_CLEAR			BIT(28)
+
+#define MTK_WED_EXT_INT_STATUS				0x020
+#define MTK_WED_EXT_INT_STATUS_TF_LEN_ERR		BIT(0)
+#define MTK_WED_EXT_INT_STATUS_TKID_WO_PYLD		BIT(1)
+#define MTK_WED_EXT_INT_STATUS_TKID_TITO_INVALID	BIT(4)
+#define MTK_WED_EXT_INT_STATUS_TX_FBUF_LO_TH		BIT(8)
+#define MTK_WED_EXT_INT_STATUS_TX_FBUF_HI_TH		BIT(9)
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(12)
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(13)
+#define MTK_WED_EXT_INT_STATUS_RX_DRV_R_RESP_ERR	BIT(16)
+#define MTK_WED_EXT_INT_STATUS_RX_DRV_W_RESP_ERR	BIT(17)
+#define MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT		BIT(18)
+#define MTK_WED_EXT_INT_STATUS_RX_DRV_INIT_WDMA_EN	BIT(19)
+#define MTK_WED_EXT_INT_STATUS_RX_DRV_BM_DMAD_COHERENT	BIT(20)
+#define MTK_WED_EXT_INT_STATUS_TX_DRV_R_RESP_ERR	BIT(21)
+#define MTK_WED_EXT_INT_STATUS_TX_DRV_W_RESP_ERR	BIT(22)
+#define MTK_WED_EXT_INT_STATUS_RX_DRV_DMA_RECYCLE	BIT(24)
+#define MTK_WED_EXT_INT_STATUS_ERROR_MASK		(MTK_WED_EXT_INT_STATUS_TF_LEN_ERR | \
+							 MTK_WED_EXT_INT_STATUS_TKID_WO_PYLD | \
+							 MTK_WED_EXT_INT_STATUS_TKID_TITO_INVALID | \
+							 MTK_WED_EXT_INT_STATUS_RX_DRV_R_RESP_ERR | \
+							 MTK_WED_EXT_INT_STATUS_RX_DRV_W_RESP_ERR | \
+							 MTK_WED_EXT_INT_STATUS_RX_DRV_INIT_WDMA_EN | \
+							 MTK_WED_EXT_INT_STATUS_TX_DRV_R_RESP_ERR | \
+							 MTK_WED_EXT_INT_STATUS_TX_DRV_W_RESP_ERR)
+
+#define MTK_WED_EXT_INT_MASK				0x028
+
+#define MTK_WED_STATUS					0x060
+#define MTK_WED_STATUS_TX				GENMASK(15, 8)
+
+#define MTK_WED_TX_BM_CTRL				0x080
+#define MTK_WED_TX_BM_CTRL_VLD_GRP_NUM			GENMASK(6, 0)
+#define MTK_WED_TX_BM_CTRL_RSV_GRP_NUM			GENMASK(22, 16)
+#define MTK_WED_TX_BM_CTRL_PAUSE			BIT(28)
+
+#define MTK_WED_TX_BM_BASE				0x084
+
+#define MTK_WED_TX_BM_TKID				0x088
+#define MTK_WED_TX_BM_TKID_START			GENMASK(15, 0)
+#define MTK_WED_TX_BM_TKID_END				GENMASK(31, 16)
+
+#define MTK_WED_TX_BM_BUF_LEN				0x08c
+
+#define MTK_WED_TX_BM_INTF				0x09c
+#define MTK_WED_TX_BM_INTF_TKID				GENMASK(15, 0)
+#define MTK_WED_TX_BM_INTF_TKFIFO_FDEP			GENMASK(23, 16)
+#define MTK_WED_TX_BM_INTF_TKID_VALID			BIT(28)
+#define MTK_WED_TX_BM_INTF_TKID_READ			BIT(29)
+
+#define MTK_WED_TX_BM_DYN_THR				0x0a0
+#define MTK_WED_TX_BM_DYN_THR_LO			GENMASK(6, 0)
+#define MTK_WED_TX_BM_DYN_THR_HI			GENMASK(22, 16)
+
+#define MTK_WED_INT_STATUS				0x200
+#define MTK_WED_INT_MASK				0x204
+
+#define MTK_WED_GLO_CFG					0x208
+#define MTK_WED_GLO_CFG_TX_DMA_EN			BIT(0)
+#define MTK_WED_GLO_CFG_TX_DMA_BUSY			BIT(1)
+#define MTK_WED_GLO_CFG_RX_DMA_EN			BIT(2)
+#define MTK_WED_GLO_CFG_RX_DMA_BUSY			BIT(3)
+#define MTK_WED_GLO_CFG_RX_BT_SIZE			GENMASK(5, 4)
+#define MTK_WED_GLO_CFG_TX_WB_DDONE			BIT(6)
+#define MTK_WED_GLO_CFG_BIG_ENDIAN			BIT(7)
+#define MTK_WED_GLO_CFG_DIS_BT_SIZE_ALIGN		BIT(8)
+#define MTK_WED_GLO_CFG_TX_BT_SIZE_LO			BIT(9)
+#define MTK_WED_GLO_CFG_MULTI_DMA_EN			GENMASK(11, 10)
+#define MTK_WED_GLO_CFG_FIFO_LITTLE_ENDIAN		BIT(12)
+#define MTK_WED_GLO_CFG_MI_DEPTH_RD			GENMASK(21, 13)
+#define MTK_WED_GLO_CFG_TX_BT_SIZE_HI			GENMASK(23, 22)
+#define MTK_WED_GLO_CFG_SW_RESET			BIT(24)
+#define MTK_WED_GLO_CFG_FIRST_TOKEN_ONLY		BIT(26)
+#define MTK_WED_GLO_CFG_OMIT_RX_INFO			BIT(27)
+#define MTK_WED_GLO_CFG_OMIT_TX_INFO			BIT(28)
+#define MTK_WED_GLO_CFG_BYTE_SWAP			BIT(29)
+#define MTK_WED_GLO_CFG_RX_2B_OFFSET			BIT(31)
+
+#define MTK_WED_RESET_IDX				0x20c
+#define MTK_WED_RESET_IDX_TX				GENMASK(3, 0)
+#define MTK_WED_RESET_IDX_RX				GENMASK(17, 16)
+
+#define MTK_WED_TX_MIB(_n)				(0x2a0 + (_n) * 4)
+
+#define MTK_WED_RING_TX(_n)				(0x300 + (_n) * 0x10)
+
+#define MTK_WED_RING_RX(_n)				(0x400 + (_n) * 0x10)
+
+#define MTK_WED_WPDMA_INT_TRIGGER			0x504
+#define MTK_WED_WPDMA_INT_TRIGGER_RX_DONE		BIT(1)
+#define MTK_WED_WPDMA_INT_TRIGGER_TX_DONE		GENMASK(5, 4)
+
+#define MTK_WED_WPDMA_GLO_CFG				0x508
+#define MTK_WED_WPDMA_GLO_CFG_TX_DRV_EN			BIT(0)
+#define MTK_WED_WPDMA_GLO_CFG_TX_DRV_BUSY		BIT(1)
+#define MTK_WED_WPDMA_GLO_CFG_RX_DRV_EN			BIT(2)
+#define MTK_WED_WPDMA_GLO_CFG_RX_DRV_BUSY		BIT(3)
+#define MTK_WED_WPDMA_GLO_CFG_RX_BT_SIZE		GENMASK(5, 4)
+#define MTK_WED_WPDMA_GLO_CFG_TX_WB_DDONE		BIT(6)
+#define MTK_WED_WPDMA_GLO_CFG_BIG_ENDIAN		BIT(7)
+#define MTK_WED_WPDMA_GLO_CFG_DIS_BT_SIZE_ALIGN		BIT(8)
+#define MTK_WED_WPDMA_GLO_CFG_TX_BT_SIZE_LO		BIT(9)
+#define MTK_WED_WPDMA_GLO_CFG_MULTI_DMA_EN		GENMASK(11, 10)
+#define MTK_WED_WPDMA_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
+#define MTK_WED_WPDMA_GLO_CFG_MI_DEPTH_RD		GENMASK(21, 13)
+#define MTK_WED_WPDMA_GLO_CFG_TX_BT_SIZE_HI		GENMASK(23, 22)
+#define MTK_WED_WPDMA_GLO_CFG_SW_RESET			BIT(24)
+#define MTK_WED_WPDMA_GLO_CFG_FIRST_TOKEN_ONLY		BIT(26)
+#define MTK_WED_WPDMA_GLO_CFG_OMIT_RX_INFO		BIT(27)
+#define MTK_WED_WPDMA_GLO_CFG_OMIT_TX_INFO		BIT(28)
+#define MTK_WED_WPDMA_GLO_CFG_BYTE_SWAP			BIT(29)
+#define MTK_WED_WPDMA_GLO_CFG_RX_2B_OFFSET		BIT(31)
+
+#define MTK_WED_WPDMA_RESET_IDX				0x50c
+#define MTK_WED_WPDMA_RESET_IDX_TX			GENMASK(3, 0)
+#define MTK_WED_WPDMA_RESET_IDX_RX			GENMASK(17, 16)
+
+#define MTK_WED_WPDMA_INT_CTRL				0x520
+#define MTK_WED_WPDMA_INT_CTRL_SUBRT_ADV		BIT(21)
+
+#define MTK_WED_WPDMA_INT_MASK				0x524
+
+#define MTK_WED_PCIE_CFG_BASE				0x560
+
+#define MTK_WED_PCIE_INT_TRIGGER			0x570
+#define MTK_WED_PCIE_INT_TRIGGER_STATUS			BIT(16)
+
+#define MTK_WED_WPDMA_CFG_BASE				0x580
+
+#define MTK_WED_WPDMA_TX_MIB(_n)			(0x5a0 + (_n) * 4)
+#define MTK_WED_WPDMA_TX_COHERENT_MIB(_n)		(0x5d0 + (_n) * 4)
+
+#define MTK_WED_WPDMA_RING_TX(_n)			(0x600 + (_n) * 0x10)
+#define MTK_WED_WPDMA_RING_RX(_n)			(0x700 + (_n) * 0x10)
+#define MTK_WED_WDMA_RING_RX(_n)			(0x900 + (_n) * 0x10)
+#define MTK_WED_WDMA_RX_THRES(_n)			(0x940 + (_n) * 0x4)
+
+#define MTK_WED_WDMA_GLO_CFG				0xa04
+#define MTK_WED_WDMA_GLO_CFG_TX_DRV_EN			BIT(0)
+#define MTK_WED_WDMA_GLO_CFG_RX_DRV_EN			BIT(2)
+#define MTK_WED_WDMA_GLO_CFG_RX_DRV_BUSY		BIT(3)
+#define MTK_WED_WDMA_GLO_CFG_BT_SIZE			GENMASK(5, 4)
+#define MTK_WED_WDMA_GLO_CFG_TX_WB_DDONE		BIT(6)
+#define MTK_WED_WDMA_GLO_CFG_RX_DIS_FSM_AUTO_IDLE	BIT(13)
+#define MTK_WED_WDMA_GLO_CFG_WCOMPLETE_SEL		BIT(16)
+#define MTK_WED_WDMA_GLO_CFG_INIT_PHASE_RXDMA_BYPASS	BIT(17)
+#define MTK_WED_WDMA_GLO_CFG_INIT_PHASE_BYPASS		BIT(18)
+#define MTK_WED_WDMA_GLO_CFG_FSM_RETURN_IDLE		BIT(19)
+#define MTK_WED_WDMA_GLO_CFG_WAIT_COHERENT		BIT(20)
+#define MTK_WED_WDMA_GLO_CFG_AXI_W_AFTER_AW		BIT(21)
+#define MTK_WED_WDMA_GLO_CFG_IDLE_DMAD_SUPPLY_SINGLE_W	BIT(22)
+#define MTK_WED_WDMA_GLO_CFG_IDLE_DMAD_SUPPLY		BIT(23)
+#define MTK_WED_WDMA_GLO_CFG_DYNAMIC_SKIP_DMAD_PREP	BIT(24)
+#define MTK_WED_WDMA_GLO_CFG_DYNAMIC_DMAD_RECYCLE	BIT(25)
+#define MTK_WED_WDMA_GLO_CFG_RST_INIT_COMPLETE		BIT(26)
+#define MTK_WED_WDMA_GLO_CFG_RXDRV_CLKGATE_BYPASS	BIT(30)
+
+#define MTK_WED_WDMA_RESET_IDX				0xa08
+#define MTK_WED_WDMA_RESET_IDX_RX			GENMASK(17, 16)
+#define MTK_WED_WDMA_RESET_IDX_DRV			GENMASK(25, 24)
+
+#define MTK_WED_WDMA_INT_TRIGGER			0xa28
+#define MTK_WED_WDMA_INT_TRIGGER_RX_DONE		GENMASK(17, 16)
+
+#define MTK_WED_WDMA_INT_CTRL				0xa2c
+#define MTK_WED_WDMA_INT_CTRL_POLL_SRC_SEL		GENMASK(17, 16)
+
+#define MTK_WED_WDMA_OFFSET0				0xaa4
+#define MTK_WED_WDMA_OFFSET1				0xaa8
+
+#define MTK_WED_WDMA_RX_MIB(_n)				(0xae0 + (_n) * 4)
+#define MTK_WED_WDMA_RX_RECYCLE_MIB(_n)			(0xae8 + (_n) * 4)
+#define MTK_WED_WDMA_RX_PROCESSED_MIB(_n)		(0xaf0 + (_n) * 4)
+
+#define MTK_WED_RING_OFS_BASE				0x00
+#define MTK_WED_RING_OFS_COUNT				0x04
+#define MTK_WED_RING_OFS_CPU_IDX			0x08
+#define MTK_WED_RING_OFS_DMA_IDX			0x0c
+
+#define MTK_WDMA_RING_RX(_n)				(0x100 + (_n) * 0x10)
+
+#define MTK_WDMA_GLO_CFG				0x204
+#define MTK_WDMA_GLO_CFG_RX_INFO_PRERES			GENMASK(28, 26)
+
+#define MTK_WDMA_RESET_IDX				0x208
+#define MTK_WDMA_RESET_IDX_TX				GENMASK(3, 0)
+#define MTK_WDMA_RESET_IDX_RX				GENMASK(17, 16)
+
+#define MTK_WDMA_INT_MASK				0x228
+#define MTK_WDMA_INT_MASK_TX_DONE			GENMASK(3, 0)
+#define MTK_WDMA_INT_MASK_RX_DONE			GENMASK(17, 16)
+#define MTK_WDMA_INT_MASK_TX_DELAY			BIT(28)
+#define MTK_WDMA_INT_MASK_TX_COHERENT			BIT(29)
+#define MTK_WDMA_INT_MASK_RX_DELAY			BIT(30)
+#define MTK_WDMA_INT_MASK_RX_COHERENT			BIT(31)
+
+#define MTK_WDMA_INT_GRP1				0x250
+#define MTK_WDMA_INT_GRP2				0x254
+
+#define MTK_PCIE_MIRROR_MAP(n)				((n) ? 0x4 : 0x0)
+#define MTK_PCIE_MIRROR_MAP_EN				BIT(0)
+#define MTK_PCIE_MIRROR_MAP_WED_ID			BIT(1)
+
+#endif
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
new file mode 100644
index 000000000000..96689861630a
--- /dev/null
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -0,0 +1,127 @@
+#ifndef __MTK_WED_H
+#define __MTK_WED_H
+
+#include <linux/kernel.h>
+#include <linux/rcupdate.h>
+#include <linux/regmap.h>
+#include <linux/pci.h>
+
+#define MTK_WED_TX_QUEUES		2
+
+struct mtk_wed_hw;
+struct mtk_wdma_desc;
+
+struct mtk_wed_ring {
+	struct mtk_wdma_desc *desc;
+	dma_addr_t desc_phys;
+	int size;
+
+	u32 reg_base;
+	void __iomem *wpdma;
+};
+
+struct mtk_wed_device {
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	const struct mtk_wed_ops *ops;
+	struct mtk_wed_hw *hw;
+	bool init_done, running;
+	int wdma_idx;
+	int irq;
+
+	struct mtk_wed_ring tx_ring[MTK_WED_TX_QUEUES];
+	struct mtk_wed_ring txfree_ring;
+	struct mtk_wed_ring tx_wdma[MTK_WED_TX_QUEUES];
+
+	struct {
+		int size;
+		void **pages;
+		struct mtk_wdma_desc *desc;
+		dma_addr_t desc_phys;
+	} buf_ring;
+
+	/* filled by driver: */
+	struct {
+		struct pci_dev *pci_dev;
+
+		u32 wpdma_phys;
+
+		u16 token_start;
+		unsigned int nbuf;
+
+		u32 (*init_buf)(void *ptr, dma_addr_t phys, int token_id);
+		int (*offload_enable)(struct mtk_wed_device *wed);
+		void (*offload_disable)(struct mtk_wed_device *wed);
+	} wlan;
+#endif
+};
+
+struct mtk_wed_ops {
+	int (*attach)(struct mtk_wed_device *dev);
+	int (*tx_ring_setup)(struct mtk_wed_device *dev, int ring,
+			     void __iomem *regs);
+	int (*txfree_ring_setup)(struct mtk_wed_device *dev,
+				 void __iomem *regs);
+	void (*detach)(struct mtk_wed_device *dev);
+
+	void (*stop)(struct mtk_wed_device *dev);
+	void (*start)(struct mtk_wed_device *dev, u32 irq_mask);
+	void (*reset_dma)(struct mtk_wed_device *dev);
+
+	u32 (*reg_read)(struct mtk_wed_device *dev, u32 reg);
+	void (*reg_write)(struct mtk_wed_device *dev, u32 reg, u32 val);
+
+	u32 (*irq_get)(struct mtk_wed_device *dev, u32 mask);
+	void (*irq_set_mask)(struct mtk_wed_device *dev, u32 mask);
+};
+
+extern const struct mtk_wed_ops __rcu *mtk_soc_wed_ops;
+
+static inline int
+mtk_wed_device_attach(struct mtk_wed_device *dev)
+{
+	int ret = -ENODEV;
+
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	rcu_read_lock();
+	dev->ops = rcu_dereference(mtk_soc_wed_ops);
+	if (dev->ops)
+		ret = dev->ops->attach(dev);
+	rcu_read_unlock();
+
+	if (ret)
+		dev->ops = NULL;
+#endif
+
+	return ret;
+}
+
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+#define mtk_wed_device_active(_dev) !!(_dev)->ops
+#define mtk_wed_device_detach(_dev) (_dev)->ops->detach(_dev)
+#define mtk_wed_device_start(_dev, _mask) (_dev)->ops->start(_dev, _mask)
+#define mtk_wed_device_tx_ring_setup(_dev, _ring, _regs) \
+	(_dev)->ops->tx_ring_setup(_dev, _ring, _regs)
+#define mtk_wed_device_txfree_ring_setup(_dev, _regs) \
+	(_dev)->ops->txfree_ring_setup(_dev, _regs)
+#define mtk_wed_device_reg_read(_dev, _reg) \
+	(_dev)->ops->reg_read(_dev, _reg)
+#define mtk_wed_device_reg_write(_dev, _reg, _val) \
+	(_dev)->ops->reg_write(_dev, _reg, _val)
+#define mtk_wed_device_irq_get(_dev, _mask) \
+	(_dev)->ops->irq_get(_dev, _mask)
+#define mtk_wed_device_irq_set_mask(_dev, _mask) \
+	(_dev)->ops->irq_set_mask(_dev, _mask)
+#else
+#define mtk_wed_device_active(_dev) false
+#define mtk_wed_device_attach(_dev) -ENODEV
+#define mtk_wed_device_detach(_dev) do {} while (0)
+#define mtk_wed_device_start(_dev, _mask) do {} while (0)
+#define mtk_wed_device_tx_ring_setup(_dev, _ring, _regs) -ENODEV
+#define mtk_wed_device_txfree_ring_setup(_dev, _ring, _regs) -ENODEV
+#define mtk_wed_device_reg_read(_dev, _reg) 0
+#define mtk_wed_device_reg_write(_dev, _reg, _val) do {} while (0)
+#define mtk_wed_device_irq_get(_dev, _mask) 0
+#define mtk_wed_device_irq_set_mask(_dev, _mask) do {} while (0)
+#endif
+
+#endif
-- 
2.30.1

