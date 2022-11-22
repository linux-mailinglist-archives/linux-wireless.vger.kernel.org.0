Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F99F633780
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 09:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKVIwM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 03:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKVIwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 03:52:07 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7B2F001
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 00:52:02 -0800 (PST)
X-UUID: e647aba51f6a4b02962bda133b95cd10-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7KRus8a0sPkdhHLB95OaEiuSaKtwjRsVE5VHoGPgTWU=;
        b=KEioQTmEsH0a7uZvPk0StiVN3bw8I5OxlZs5Uwvj+a/li68XsyiXpyuT+/25c4r8r3zJ9QmGZnTCGmDcox9faeUbb+9hVSZ2FkneNED4XbTp7oLJCKc8BoX16KqR6wr24f1S8ISBcY4+lqLUUS3/N+Z58/FMST3R7I1GWlfQeOk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:29862489-e3c8-45ac-ae5d-5a4a0b4364a5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:29862489-e3c8-45ac-ae5d-5a4a0b4364a5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:15e0e5db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:2211221651599OV16OQG,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e647aba51f6a4b02962bda133b95cd10-20221122
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 483654717; Tue, 22 Nov 2022 16:51:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 16:51:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 16:51:57 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/9] wifi: mt76: mt7996: add PCI support
Date:   Tue, 22 Nov 2022 16:45:46 +0800
Message-ID: <20221122084554.9494-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221122084554.9494-1-shayne.chen@mediatek.com>
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Split the big patch into smaller intermediate patches by functionality
for easier review. Refer to the cover letter for more info.)

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 385 +++++++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 516 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   | 222 ++++++++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  | 533 ++++++++++++++++++
 4 files changed, 1656 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/regs.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
new file mode 100644
index 000000000000..0d097cda4da7
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mt7996.h"
+#include "mac.h"
+#include "../trace.h"
+
+static const struct __base mt7996_reg_base[] = {
+	[WF_AGG_BASE]	= { { 0x820e2000, 0x820f2000, 0x830e2000 } },
+	[WF_MIB_BASE]	= { { 0x820ed000, 0x820fd000, 0x830ed000 } },
+	[WF_TMAC_BASE]	= { { 0x820e4000, 0x820f4000, 0x830e4000 } },
+	[WF_RMAC_BASE]	= { { 0x820e5000, 0x820f5000, 0x830e5000 } },
+	[WF_ARB_BASE]	= { { 0x820e3000, 0x820f3000, 0x830e3000 } },
+	[WF_LPON_BASE]	= { { 0x820eb000, 0x820fb000, 0x830eb000 } },
+	[WF_ETBF_BASE]	= { { 0x820ea000, 0x820fa000, 0x830ea000 } },
+	[WF_DMA_BASE]	= { { 0x820e7000, 0x820f7000, 0x830e7000 } },
+};
+
+static const struct __map mt7996_reg_map[] = {
+	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
+	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
+	{ 0x56000000, 0x04000, 0x1000 }, /* WFDMA reserved */
+	{ 0x57000000, 0x05000, 0x1000 }, /* WFDMA MCU wrap CR */
+	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x74030000, 0x10000, 0x1000 }, /* PCIe MAC */
+	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{ 0x820ca000, 0x26000, 0x2000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
+	{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
+	{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure register) */
+	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{ 0x820cc000, 0xa5000, 0x2000 }, /* WF_LMAC_TOP BN1 (WF_MUCOP) */
+	{ 0x820c4000, 0xa8000, 0x4000 }, /* WF_LMAC_TOP BN1 (WF_MUCOP) */
+	{ 0x820b0000, 0xae000, 0x1000 }, /* [APB2] WFSYS_ON */
+	{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+	{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, wfdma */
+	{ 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_host_csr_top */
+	{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+	{ 0x0, 0x0, 0x0 }, /* imply end of search */
+};
+
+static u32 mt7996_reg_map_l1(struct mt7996_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	dev->reg_l1_backup = dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L1);
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L1,
+			  MT_HIF_REMAP_L1_MASK,
+			  FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
+	/* use read to push write */
+	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static u32 mt7996_reg_map_l2(struct mt7996_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+
+	dev->reg_l2_backup = dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2,
+			  MT_HIF_REMAP_L2_MASK,
+			  FIELD_PREP(MT_HIF_REMAP_L2_MASK, base));
+	/* use read to push write */
+	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
+
+	return MT_HIF_REMAP_BASE_L2 + offset;
+}
+
+static void mt7996_reg_remap_restore(struct mt7996_dev *dev)
+{
+	/* remap to ori status */
+	if (unlikely(dev->reg_l1_backup)) {
+		dev->bus_ops->wr(&dev->mt76, MT_HIF_REMAP_L1, dev->reg_l1_backup);
+		dev->reg_l1_backup = 0;
+	}
+
+	if (dev->reg_l2_backup) {
+		dev->bus_ops->wr(&dev->mt76, MT_HIF_REMAP_L2, dev->reg_l2_backup);
+		dev->reg_l2_backup = 0;
+	}
+}
+
+static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
+{
+	int i;
+
+	mt7996_reg_remap_restore(dev);
+
+	if (addr < 0x100000)
+		return addr;
+
+	for (i = 0; i < dev->reg.map_size; i++) {
+		u32 ofs;
+
+		if (addr < dev->reg.map[i].phys)
+			continue;
+
+		ofs = addr - dev->reg.map[i].phys;
+		if (ofs > dev->reg.map[i].size)
+			continue;
+
+		return dev->reg.map[i].mapped + ofs;
+	}
+
+	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
+	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
+	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
+		return mt7996_reg_map_l1(dev, addr);
+
+	if (dev_is_pci(dev->mt76.dev) &&
+	    ((addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
+	     (addr >= MT_CBTOP2_PHY_START && addr <= MT_CBTOP2_PHY_END)))
+		return mt7996_reg_map_l1(dev, addr);
+
+	/* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
+	if (addr >= MT_INFRA_MCU_START && addr <= MT_INFRA_MCU_END) {
+		addr = addr - MT_INFRA_MCU_START + MT_INFRA_BASE;
+		return mt7996_reg_map_l1(dev, addr);
+	}
+
+	return mt7996_reg_map_l2(dev, addr);
+}
+
+static u32 mt7996_rr(struct mt76_dev *mdev, u32 offset)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	return dev->bus_ops->rr(mdev, __mt7996_reg_addr(dev, offset));
+}
+
+static void mt7996_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	dev->bus_ops->wr(mdev, __mt7996_reg_addr(dev, offset), val);
+}
+
+static u32 mt7996_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	return dev->bus_ops->rmw(mdev, __mt7996_reg_addr(dev, offset), mask, val);
+}
+
+static int mt7996_mmio_init(struct mt76_dev *mdev,
+			    void __iomem *mem_base,
+			    u32 device_id)
+{
+	struct mt76_bus_ops *bus_ops;
+	struct mt7996_dev *dev;
+
+	dev = container_of(mdev, struct mt7996_dev, mt76);
+	mt76_mmio_init(&dev->mt76, mem_base);
+
+	switch (device_id) {
+	case 0x7990:
+		dev->reg.base = mt7996_reg_base;
+		dev->reg.map = mt7996_reg_map;
+		dev->reg.map_size = ARRAY_SIZE(mt7996_reg_map);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev->bus_ops = dev->mt76.bus;
+	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
+			       GFP_KERNEL);
+	if (!bus_ops)
+		return -ENOMEM;
+
+	bus_ops->rr = mt7996_rr;
+	bus_ops->wr = mt7996_wr;
+	bus_ops->rmw = mt7996_rmw;
+	dev->mt76.bus = bus_ops;
+
+	mdev->rev = (device_id << 16) | (mt76_rr(dev, MT_HW_REV) & 0xff);
+
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	return 0;
+}
+
+void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
+				  u32 clear, u32 set)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mdev->mmio.irq_lock, flags);
+
+	mdev->mmio.irqmask &= ~clear;
+	mdev->mmio.irqmask |= set;
+
+	if (write_reg) {
+		mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
+		mt76_wr(dev, MT_INT1_MASK_CSR, mdev->mmio.irqmask);
+	}
+
+	spin_unlock_irqrestore(&mdev->mmio.irq_lock, flags);
+}
+
+static void mt7996_rx_poll_complete(struct mt76_dev *mdev,
+				    enum mt76_rxq_id q)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	mt7996_irq_enable(dev, MT_INT_RX(q));
+}
+
+/* TODO: support 2/4/6/8 MSI-X vectors */
+static void mt7996_irq_tasklet(struct tasklet_struct *t)
+{
+	struct mt7996_dev *dev = from_tasklet(dev, t, irq_tasklet);
+	u32 i, intr, mask, intr1;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+	intr &= dev->mt76.mmio.irqmask;
+	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+
+	if (dev->hif2) {
+		intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
+		intr1 &= dev->mt76.mmio.irqmask;
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, intr1);
+
+		intr |= intr1;
+	}
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	mask = intr & MT_INT_RX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_MCU)
+		mask |= MT_INT_TX_DONE_MCU;
+	mt7996_irq_disable(dev, mask);
+
+	if (intr & MT_INT_TX_DONE_MCU)
+		napi_schedule(&dev->mt76.tx_napi);
+
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		if ((intr & MT_INT_RX(i)))
+			napi_schedule(&dev->mt76.napi[i]);
+	}
+
+	if (intr & MT_INT_MCU_CMD) {
+		u32 val = mt76_rr(dev, MT_MCU_CMD);
+
+		mt76_wr(dev, MT_MCU_CMD, val);
+		if (val & MT_MCU_CMD_ERROR_MASK) {
+			dev->reset_state = val;
+			ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
+			wake_up(&dev->reset_wait);
+		}
+	}
+}
+
+irqreturn_t mt7996_irq_handler(int irq, void *dev_instance)
+{
+	struct mt7996_dev *dev = dev_instance;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	tasklet_schedule(&dev->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
+				     void __iomem *mem_base, u32 device_id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7996_txp),
+		.drv_flags = MT_DRV_TXWI_NO_FREE |
+			     MT_DRV_HW_MGMT_TXQ,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7996_TOKEN_SIZE,
+		.tx_prepare_skb = mt7996_tx_prepare_skb,
+		.tx_complete_skb = mt7996_tx_complete_skb,
+		.rx_skb = mt7996_queue_rx_skb,
+		.rx_check = mt7996_rx_check,
+		.rx_poll_complete = mt7996_rx_poll_complete,
+		.sta_ps = mt7996_sta_ps,
+		.sta_add = mt7996_mac_sta_add,
+		.sta_remove = mt7996_mac_sta_remove,
+		.update_survey = mt7996_update_channel,
+	};
+	struct mt7996_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	mdev = mt76_alloc_device(pdev, sizeof(*dev), &mt7996_ops, &drv_ops);
+	if (!mdev)
+		return ERR_PTR(-ENOMEM);
+
+	dev = container_of(mdev, struct mt7996_dev, mt76);
+
+	ret = mt7996_mmio_init(mdev, mem_base, device_id);
+	if (ret)
+		goto error;
+
+	tasklet_setup(&dev->irq_tasklet, mt7996_irq_tasklet);
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
+	return dev;
+
+error:
+	mt76_free_device(&dev->mt76);
+
+	return ERR_PTR(ret);
+}
+
+static int __init mt7996_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&mt7996_hif_driver);
+	if (ret)
+		return ret;
+
+	ret = pci_register_driver(&mt7996_pci_driver);
+	if (ret)
+		pci_unregister_driver(&mt7996_hif_driver);
+
+	return ret;
+}
+
+static void __exit mt7996_exit(void)
+{
+	pci_unregister_driver(&mt7996_pci_driver);
+	pci_unregister_driver(&mt7996_hif_driver);
+}
+
+module_init(mt7996_init);
+module_exit(mt7996_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
new file mode 100644
index 000000000000..371195e4597d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -0,0 +1,516 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_H
+#define __MT7996_H
+
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include "../mt76_connac.h"
+#include "regs.h"
+
+#define MT7996_MAX_INTERFACES		19
+#define MT7996_MAX_WMM_SETS		4
+#define MT7996_WTBL_SIZE		544
+#define MT7996_WTBL_RESERVED		(MT7996_WTBL_SIZE - 1)
+#define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
+					 MT7996_MAX_INTERFACES)
+
+#define MT7996_WATCHDOG_TIME		(HZ / 10)
+#define MT7996_RESET_TIMEOUT		(30 * HZ)
+
+#define MT7996_TX_RING_SIZE		2048
+#define MT7996_TX_MCU_RING_SIZE		256
+#define MT7996_TX_FWDL_RING_SIZE	128
+
+#define MT7996_RX_RING_SIZE		1536
+#define MT7996_RX_MCU_RING_SIZE		512
+
+#define MT7996_FIRMWARE_WA		"mediatek/mt7996/mt7996_wa.bin"
+#define MT7996_FIRMWARE_WM		"mediatek/mt7996/mt7996_wm.bin"
+#define MT7996_ROM_PATCH		"mediatek/mt7996/mt7996_rom_patch.bin"
+
+#define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
+#define MT7996_EEPROM_SIZE		7680
+#define MT7996_EEPROM_BLOCK_SIZE	16
+#define MT7996_TOKEN_SIZE		8192
+
+#define MT7996_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT7996_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+
+#define MT7996_MAX_TWT_AGRT		16
+#define MT7996_MAX_STA_TWT_AGRT		8
+#define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
+
+struct mt7996_vif;
+struct mt7996_sta;
+struct mt7996_dfs_pulse;
+struct mt7996_dfs_pattern;
+
+enum mt7996_txq_id {
+	MT7996_TXQ_FWDL = 16,
+	MT7996_TXQ_MCU_WM,
+	MT7996_TXQ_BAND0,
+	MT7996_TXQ_BAND1,
+	MT7996_TXQ_MCU_WA,
+	MT7996_TXQ_BAND2,
+};
+
+enum mt7996_rxq_id {
+	MT7996_RXQ_MCU_WM = 0,
+	MT7996_RXQ_MCU_WA,
+	MT7996_RXQ_MCU_WA_MAIN = 2,
+	MT7996_RXQ_MCU_WA_EXT = 2,/* unused */
+	MT7996_RXQ_MCU_WA_TRI = 3,
+	MT7996_RXQ_BAND0 = 4,
+	MT7996_RXQ_BAND1 = 4,/* unused */
+	MT7996_RXQ_BAND2 = 5,
+};
+
+struct mt7996_twt_flow {
+	struct list_head list;
+	u64 start_tsf;
+	u64 tsf;
+	u32 duration;
+	u16 wcid;
+	__le16 mantissa;
+	u8 exp;
+	u8 table_id;
+	u8 id;
+	u8 protection:1;
+	u8 flowtype:1;
+	u8 trigger:1;
+	u8 sched:1;
+};
+
+struct mt7996_sta {
+	struct mt76_wcid wcid; /* must be first */
+
+	struct mt7996_vif *vif;
+
+	struct list_head poll_list;
+	struct list_head rc_list;
+	u32 airtime_ac[8];
+
+	unsigned long changed;
+	unsigned long jiffies;
+	unsigned long ampdu_state;
+
+	struct mt76_sta_stats stats;
+
+	struct mt76_connac_sta_key_conf bip;
+
+	struct {
+		u8 flowid_mask;
+		struct mt7996_twt_flow flow[MT7996_MAX_STA_TWT_AGRT];
+	} twt;
+};
+
+struct mt7996_vif_cap {
+	bool ht_ldpc:1;
+	bool vht_ldpc:1;
+	bool he_ldpc:1;
+	bool vht_su_ebfer:1;
+	bool vht_su_ebfee:1;
+	bool vht_mu_ebfer:1;
+	bool vht_mu_ebfee:1;
+	bool he_su_ebfer:1;
+	bool he_su_ebfee:1;
+	bool he_mu_ebfer:1;
+};
+
+struct mt7996_vif {
+	struct mt76_vif mt76; /* must be first */
+
+	struct mt7996_vif_cap cap;
+	struct mt7996_sta sta;
+	struct mt7996_phy *phy;
+
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	struct cfg80211_bitrate_mask bitrate_mask;
+};
+
+/* per-phy stats.  */
+struct mib_stats {
+	u32 ack_fail_cnt;
+	u32 fcs_err_cnt;
+	u32 rts_cnt;
+	u32 rts_retries_cnt;
+	u32 ba_miss_cnt;
+	u32 tx_mu_bf_cnt;
+	u32 tx_mu_mpdu_cnt;
+	u32 tx_mu_acked_mpdu_cnt;
+	u32 tx_su_acked_mpdu_cnt;
+	u32 tx_bf_ibf_ppdu_cnt;
+	u32 tx_bf_ebf_ppdu_cnt;
+
+	u32 tx_bf_rx_fb_all_cnt;
+	u32 tx_bf_rx_fb_eht_cnt;
+	u32 tx_bf_rx_fb_he_cnt;
+	u32 tx_bf_rx_fb_vht_cnt;
+	u32 tx_bf_rx_fb_ht_cnt;
+
+	u32 tx_bf_rx_fb_bw; /* value of last sample, not cumulative */
+	u32 tx_bf_rx_fb_nc_cnt;
+	u32 tx_bf_rx_fb_nr_cnt;
+	u32 tx_bf_fb_cpl_cnt;
+	u32 tx_bf_fb_trig_cnt;
+
+	u32 tx_ampdu_cnt;
+	u32 tx_stop_q_empty_cnt;
+	u32 tx_mpdu_attempts_cnt;
+	u32 tx_mpdu_success_cnt;
+	/* BF counter is PPDU-based, so remove MPDU-based BF counter */
+
+	u32 tx_rwp_fail_cnt;
+	u32 tx_rwp_need_cnt;
+
+	/* rx stats */
+	u32 rx_fifo_full_cnt;
+	u32 channel_idle_cnt;
+	u32 rx_vector_mismatch_cnt;
+	u32 rx_delimiter_fail_cnt;
+	u32 rx_len_mismatch_cnt;
+	u32 rx_mpdu_cnt;
+	u32 rx_ampdu_cnt;
+	u32 rx_ampdu_bytes_cnt;
+	u32 rx_ampdu_valid_subframe_cnt;
+	u32 rx_ampdu_valid_subframe_bytes_cnt;
+	u32 rx_pfdrop_cnt;
+	u32 rx_vec_queue_overflow_drop_cnt;
+	u32 rx_ba_cnt;
+
+	u32 tx_amsdu[8];
+	u32 tx_amsdu_cnt;
+};
+
+struct mt7996_hif {
+	struct list_head list;
+
+	struct device *dev;
+	void __iomem *regs;
+	int irq;
+};
+
+struct mt7996_phy {
+	struct mt76_phy *mt76;
+	struct mt7996_dev *dev;
+
+	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
+
+	struct ieee80211_vif *monitor_vif;
+
+	u32 rxfilter;
+	u64 omac_mask;
+
+	u16 noise;
+
+	s16 coverage_class;
+	u8 slottime;
+
+	u8 rdd_state;
+
+	u32 rx_ampdu_ts;
+	u32 ampdu_ref;
+
+	struct mib_stats mib;
+	struct mt76_channel_state state_ts;
+};
+
+struct mt7996_dev {
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
+	struct mt7996_hif *hif2;
+	struct mt7996_reg_desc reg;
+	u8 q_id[MT7996_MAX_QUEUE];
+	u32 q_int_mask[MT7996_MAX_QUEUE];
+	u32 q_wfdma_mask;
+
+	const struct mt76_bus_ops *bus_ops;
+	struct tasklet_struct irq_tasklet;
+	struct mt7996_phy phy;
+
+	/* monitor rx chain configured channel */
+	struct cfg80211_chan_def rdd2_chandef;
+	struct mt7996_phy *rdd2_phy;
+
+	u16 chainmask;
+	u8 chainshift[__MT_MAX_BAND];
+	u32 hif_idx;
+
+	struct work_struct init_work;
+	struct work_struct rc_work;
+	struct work_struct reset_work;
+	wait_queue_head_t reset_wait;
+	u32 reset_state;
+
+	struct list_head sta_rc_list;
+	struct list_head sta_poll_list;
+	struct list_head twt_list;
+	spinlock_t sta_poll_lock;
+
+	u32 hw_pattern;
+
+	bool dbdc_support:1;
+	bool tbtc_support:1;
+	bool flash_mode:1;
+
+	bool ibf;
+	u8 fw_debug_wm;
+	u8 fw_debug_wa;
+	u8 fw_debug_bin;
+	u16 fw_debug_seq;
+
+	struct dentry *debugfs_dir;
+	struct rchan *relay_fwlog;
+
+	struct {
+		u8 table_mask;
+		u8 n_agrt;
+	} twt;
+
+	u32 reg_l1_backup;
+	u32 reg_l2_backup;
+};
+
+enum {
+	WFDMA0 = 0x0,
+	WFDMA1,
+	WFDMA_EXT,
+	__MT_WFDMA_MAX,
+};
+
+enum {
+	MT_CTX0,
+	MT_HIF0 = 0x0,
+
+	MT_LMAC_AC00 = 0x0,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+	MT_LMAC_PSMP0,
+};
+
+enum {
+	MT_RX_SEL0,
+	MT_RX_SEL1,
+	MT_RX_SEL2, /* monitor chain */
+};
+
+enum mt7996_rdd_cmd {
+	RDD_STOP,
+	RDD_START,
+	RDD_DET_MODE,
+	RDD_RADAR_EMULATE,
+	RDD_START_TXQ = 20,
+	RDD_CAC_START = 50,
+	RDD_CAC_END,
+	RDD_NORMAL_START,
+	RDD_DISABLE_DFS_CAL,
+	RDD_PULSE_DBG,
+	RDD_READ_PULSE,
+	RDD_RESUME_BF,
+	RDD_IRQ_OFF,
+};
+
+static inline struct mt7996_phy *
+mt7996_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
+static inline struct mt7996_dev *
+mt7996_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt7996_dev, mt76);
+}
+
+static inline struct mt7996_phy *
+__mt7996_phy(struct mt7996_dev *dev, enum mt76_band_id band)
+{
+	struct mt76_phy *phy = dev->mt76.phys[band];
+
+	if (!phy)
+		return NULL;
+
+	return phy->priv;
+}
+
+static inline struct mt7996_phy *
+mt7996_phy2(struct mt7996_dev *dev)
+{
+	return __mt7996_phy(dev, MT_BAND1);
+}
+
+static inline struct mt7996_phy *
+mt7996_phy3(struct mt7996_dev *dev)
+{
+	return __mt7996_phy(dev, MT_BAND2);
+}
+
+extern const struct ieee80211_ops mt7996_ops;
+extern struct pci_driver mt7996_pci_driver;
+extern struct pci_driver mt7996_hif_driver;
+
+struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
+				     void __iomem *mem_base, u32 device_id);
+void mt7996_wfsys_reset(struct mt7996_dev *dev);
+irqreturn_t mt7996_irq_handler(int irq, void *dev_instance);
+u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif);
+int mt7996_register_device(struct mt7996_dev *dev);
+void mt7996_unregister_device(struct mt7996_dev *dev);
+int mt7996_eeprom_init(struct mt7996_dev *dev);
+int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy);
+int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
+				   struct ieee80211_channel *chan);
+s8 mt7996_eeprom_get_power_delta(struct mt7996_dev *dev, int band);
+int mt7996_dma_init(struct mt7996_dev *dev);
+void mt7996_dma_prefetch(struct mt7996_dev *dev);
+void mt7996_dma_cleanup(struct mt7996_dev *dev);
+int mt7996_mcu_init(struct mt7996_dev *dev);
+int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
+			       struct mt7996_vif *mvif,
+			       struct mt7996_twt_flow *flow,
+			       int cmd);
+int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
+			    struct ieee80211_vif *vif, bool enable);
+int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
+			    struct ieee80211_vif *vif, int enable);
+int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable);
+int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool add);
+int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool add);
+int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+				struct cfg80211_he_bss_color *he_bss_color);
+int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  int enable);
+int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
+				    struct ieee80211_vif *vif, u32 changed);
+int mt7996_mcu_add_obss_spr(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			    bool enable);
+int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta, bool changed);
+int mt7996_set_channel(struct mt7996_phy *phy);
+int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
+int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif);
+int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
+				   void *data, u16 version);
+int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
+int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset);
+int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);
+int mt7996_mcu_set_ser(struct mt7996_dev *dev, u8 action, u8 set, u8 band);
+int mt7996_mcu_set_txbf(struct mt7996_dev *dev, u8 action);
+int mt7996_mcu_set_fcc5_lpn(struct mt7996_dev *dev, int val);
+int mt7996_mcu_set_pulse_th(struct mt7996_dev *dev,
+			    const struct mt7996_dfs_pulse *pulse);
+int mt7996_mcu_set_radar_th(struct mt7996_dev *dev, int index,
+			    const struct mt7996_dfs_pattern *pattern);
+int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable);
+void mt7996_mcu_set_pm(void *priv, u8 *mac, struct ieee80211_vif *vif);
+int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val);
+int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
+int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
+		       u8 rx_sel, u8 val);
+int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
+				     struct cfg80211_chan_def *chandef);
+int mt7996_mcu_rf_regval(struct mt7996_dev *dev, u32 regidx, u32 *val, bool set);
+int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans);
+int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val);
+int mt7996_mcu_wa_cmd(struct mt7996_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
+int mt7996_mcu_fw_log_2_host(struct mt7996_dev *dev, u8 type, u8 ctrl);
+int mt7996_mcu_fw_dbg_ctrl(struct mt7996_dev *dev, u32 module, u8 level);
+void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
+void mt7996_mcu_exit(struct mt7996_dev *dev);
+
+void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
+				  u32 clear, u32 set);
+
+static inline void mt7996_irq_enable(struct mt7996_dev *dev, u32 mask)
+{
+	if (dev->hif2)
+		mt7996_dual_hif_set_irq_mask(dev, false, 0, mask);
+	else
+		mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
+
+	tasklet_schedule(&dev->irq_tasklet);
+}
+
+static inline void mt7996_irq_disable(struct mt7996_dev *dev, u32 mask)
+{
+	if (dev->hif2)
+		mt7996_dual_hif_set_irq_mask(dev, true, mask, 0);
+	else
+		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
+}
+
+u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw);
+bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
+void mt7996_mac_reset_counters(struct mt7996_phy *phy);
+void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy);
+void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
+void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
+			   struct ieee80211_key_conf *key, u32 changed);
+void mt7996_mac_set_timing(struct mt7996_phy *phy);
+int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7996_mac_work(struct work_struct *work);
+void mt7996_mac_reset_work(struct work_struct *work);
+void mt7996_mac_sta_rc_work(struct work_struct *work);
+void mt7996_mac_update_stats(struct mt7996_phy *phy);
+void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
+				  struct mt7996_sta *msta,
+				  u8 flowid);
+void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_setup *twt);
+int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info);
+void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+void mt7996_tx_token_put(struct mt7996_dev *dev);
+void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb);
+bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len);
+void mt7996_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
+void mt7996_stats_work(struct work_struct *work);
+int mt76_dfs_start_rdd(struct mt7996_dev *dev, bool force);
+int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy);
+void mt7996_set_stream_he_caps(struct mt7996_phy *phy);
+void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy);
+void mt7996_update_channel(struct mt76_phy *mphy);
+int mt7996_init_debugfs(struct mt7996_phy *phy);
+void mt7996_debugfs_rx_fw_monitor(struct mt7996_dev *dev, const void *data, int len);
+bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len);
+int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		       struct mt76_connac_sta_key_conf *sta_key_conf,
+		       struct ieee80211_key_conf *key, int mcu_cmd,
+		       struct mt76_wcid *wcid, enum set_key_cmd cmd);
+int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta);
+#ifdef CONFIG_MAC80211_DEBUGFS
+void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, struct dentry *dir);
+#endif
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
new file mode 100644
index 000000000000..64aee3fb5445
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mt7996.h"
+#include "mac.h"
+#include "../trace.h"
+
+static LIST_HEAD(hif_list);
+static DEFINE_SPINLOCK(hif_lock);
+static u32 hif_idx;
+
+static const struct pci_device_id mt7996_pci_device_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7990) },
+	{ },
+};
+
+static const struct pci_device_id mt7996_hif_device_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7991) },
+	{ },
+};
+
+static struct mt7996_hif *mt7996_pci_get_hif2(u32 idx)
+{
+	struct mt7996_hif *hif;
+	u32 val;
+
+	spin_lock_bh(&hif_lock);
+
+	list_for_each_entry(hif, &hif_list, list) {
+		val = readl(hif->regs + MT_PCIE_RECOG_ID);
+		val &= MT_PCIE_RECOG_ID_MASK;
+		if (val != idx)
+			continue;
+
+		get_device(hif->dev);
+		goto out;
+	}
+	hif = NULL;
+
+out:
+	spin_unlock_bh(&hif_lock);
+
+	return hif;
+}
+
+static void mt7996_put_hif2(struct mt7996_hif *hif)
+{
+	if (!hif)
+		return;
+
+	put_device(hif->dev);
+}
+
+static struct mt7996_hif *mt7996_pci_init_hif2(struct pci_dev *pdev)
+{
+	hif_idx++;
+	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7991, NULL))
+		return NULL;
+
+	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
+	       pcim_iomap_table(pdev)[0] + MT_PCIE_RECOG_ID);
+
+	return mt7996_pci_get_hif2(hif_idx);
+}
+
+static int mt7996_pci_hif2_probe(struct pci_dev *pdev)
+{
+	struct mt7996_hif *hif;
+
+	hif = devm_kzalloc(&pdev->dev, sizeof(*hif), GFP_KERNEL);
+	if (!hif)
+		return -ENOMEM;
+
+	hif->dev = &pdev->dev;
+	hif->regs = pcim_iomap_table(pdev)[0];
+	hif->irq = pdev->irq;
+	spin_lock_bh(&hif_lock);
+	list_add(&hif->list, &hif_list);
+	spin_unlock_bh(&hif_lock);
+	pci_set_drvdata(pdev, hif);
+
+	return 0;
+}
+
+static int mt7996_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct pci_dev *hif2_dev;
+	struct mt7996_dev *dev;
+	struct mt76_dev *mdev;
+	struct mt7996_hif *hif2;
+	int irq, ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	mt76_pci_disable_aspm(pdev);
+
+	if (id->device == 0x7991)
+		return mt7996_pci_hif2_probe(pdev);
+
+	dev = mt7996_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
+				id->device);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	mdev = &dev->mt76;
+	mt7996_wfsys_reset(dev);
+	hif2 = mt7996_pci_init_hif2(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		goto free_device;
+
+	irq = pdev->irq;
+	ret = devm_request_irq(mdev->dev, irq, mt7996_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto free_irq_vector;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	/* master switch of PCIe tnterrupt enable */
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	if (hif2) {
+		hif2_dev = container_of(hif2->dev, struct pci_dev, dev);
+		dev->hif2 = hif2;
+
+		ret = pci_alloc_irq_vectors(hif2_dev, 1, 1, PCI_IRQ_ALL_TYPES);
+		if (ret < 0)
+			goto free_hif2;
+
+		dev->hif2->irq = hif2_dev->irq;
+		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
+				       mt7996_irq_handler, IRQF_SHARED,
+				       KBUILD_MODNAME "-hif", dev);
+		if (ret)
+			goto free_hif2_irq_vector;
+
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+		/* master switch of PCIe tnterrupt enable */
+		mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+	}
+
+	ret = mt7996_register_device(dev);
+	if (ret)
+		goto free_hif2_irq;
+
+	return 0;
+
+free_hif2_irq:
+	if (dev->hif2)
+		devm_free_irq(mdev->dev, dev->hif2->irq, dev);
+free_hif2_irq_vector:
+	if (dev->hif2)
+		pci_free_irq_vectors(hif2_dev);
+free_hif2:
+	if (dev->hif2)
+		put_device(dev->hif2->dev);
+	devm_free_irq(mdev->dev, irq, dev);
+free_irq_vector:
+	pci_free_irq_vectors(pdev);
+free_device:
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+static void mt7996_hif_remove(struct pci_dev *pdev)
+{
+	struct mt7996_hif *hif = pci_get_drvdata(pdev);
+
+	list_del(&hif->list);
+}
+
+static void mt7996_pci_remove(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev;
+	struct mt7996_dev *dev;
+
+	mdev = pci_get_drvdata(pdev);
+	dev = container_of(mdev, struct mt7996_dev, mt76);
+	mt7996_put_hif2(dev->hif2);
+	mt7996_unregister_device(dev);
+}
+
+struct pci_driver mt7996_hif_driver = {
+	.name		= KBUILD_MODNAME "_hif",
+	.id_table	= mt7996_hif_device_table,
+	.probe		= mt7996_pci_probe,
+	.remove		= mt7996_hif_remove,
+};
+
+struct pci_driver mt7996_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7996_pci_device_table,
+	.probe		= mt7996_pci_probe,
+	.remove		= mt7996_pci_remove,
+};
+
+MODULE_DEVICE_TABLE(pci, mt7996_pci_device_table);
+MODULE_DEVICE_TABLE(pci, mt7996_hif_device_table);
+MODULE_FIRMWARE(MT7996_FIRMWARE_WA);
+MODULE_FIRMWARE(MT7996_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7996_ROM_PATCH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
new file mode 100644
index 000000000000..1d53611da4d8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -0,0 +1,533 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_REGS_H
+#define __MT7996_REGS_H
+
+struct __map {
+	u32 phys;
+	u32 mapped;
+	u32 size;
+};
+
+struct __base {
+	u32 band_base[__MT_MAX_BAND];
+};
+
+/* used to differentiate between generations */
+struct mt7996_reg_desc {
+	const struct __base *base;
+	const struct __map *map;
+	u32 map_size;
+};
+
+enum base_rev {
+	WF_AGG_BASE,
+	WF_MIB_BASE,
+	WF_TMAC_BASE,
+	WF_RMAC_BASE,
+	WF_ARB_BASE,
+	WF_LPON_BASE,
+	WF_ETBF_BASE,
+	WF_DMA_BASE,
+	__MT_REG_BASE_MAX,
+};
+
+#define __BASE(_id, _band)			(dev->reg.base[(_id)].band_base[(_band)])
+
+#define MT_MCU_INT_EVENT			0x2108
+#define MT_MCU_INT_EVENT_DMA_STOPPED		BIT(0)
+#define MT_MCU_INT_EVENT_DMA_INIT		BIT(1)
+#define MT_MCU_INT_EVENT_RESET_DONE		BIT(3)
+
+/* PLE */
+#define MT_PLE_BASE				0x820c0000
+#define MT_PLE(ofs)				(MT_PLE_BASE + (ofs))
+
+#define MT_FL_Q_EMPTY				MT_PLE(0x360)
+#define MT_FL_Q0_CTRL				MT_PLE(0x3e0)
+#define MT_FL_Q2_CTRL				MT_PLE(0x3e8)
+#define MT_FL_Q3_CTRL				MT_PLE(0x3ec)
+
+#define MT_PLE_FREEPG_CNT			MT_PLE(0x380)
+#define MT_PLE_FREEPG_HEAD_TAIL			MT_PLE(0x384)
+#define MT_PLE_PG_HIF_GROUP			MT_PLE(0x00c)
+#define MT_PLE_HIF_PG_INFO			MT_PLE(0x388)
+
+#define MT_PLE_AC_QEMPTY(ac, n)			MT_PLE(0x600 +	0x80 * (ac) + ((n) << 2))
+#define MT_PLE_AMSDU_PACK_MSDU_CNT(n)		MT_PLE(0x10e0 + ((n) << 2))
+
+/* WF MDP TOP */
+#define MT_MDP_BASE				0x820cc000
+#define MT_MDP(ofs)				(MT_MDP_BASE + (ofs))
+
+#define MT_MDP_DCR2				MT_MDP(0x8e8)
+#define MT_MDP_DCR2_RX_TRANS_SHORT		BIT(2)
+
+/* TMAC: band 0(0x820e4000), band 1(0x820f4000), band 2(0x830e4000) */
+#define MT_WF_TMAC_BASE(_band)			__BASE(WF_TMAC_BASE, (_band))
+#define MT_WF_TMAC(_band, ofs)			(MT_WF_TMAC_BASE(_band) + (ofs))
+
+#define MT_TMAC_TCR0(_band)			MT_WF_TMAC(_band, 0)
+#define MT_TMAC_TCR0_TX_BLINK			GENMASK(7, 6)
+
+#define MT_TMAC_CDTR(_band)			MT_WF_TMAC(_band, 0x0c8)
+#define MT_TMAC_ODTR(_band)			MT_WF_TMAC(_band, 0x0cc)
+#define MT_TIMEOUT_VAL_PLCP			GENMASK(15, 0)
+#define MT_TIMEOUT_VAL_CCA			GENMASK(31, 16)
+
+#define MT_TMAC_ICR0(_band)			MT_WF_TMAC(_band, 0x014)
+#define MT_IFS_EIFS_OFDM			GENMASK(8, 0)
+#define MT_IFS_RIFS				GENMASK(14, 10)
+#define MT_IFS_SIFS				GENMASK(22, 16)
+#define MT_IFS_SLOT				GENMASK(30, 24)
+
+#define MT_TMAC_ICR1(_band)			MT_WF_TMAC(_band, 0x018)
+#define MT_IFS_EIFS_CCK				GENMASK(8, 0)
+
+/* WF DMA TOP: band 0(0x820e7000), band 1(0x820f7000), band 2(0x830e7000) */
+#define MT_WF_DMA_BASE(_band)			__BASE(WF_DMA_BASE, (_band))
+#define MT_WF_DMA(_band, ofs)			(MT_WF_DMA_BASE(_band) + (ofs))
+
+#define MT_DMA_DCR0(_band)			MT_WF_DMA(_band, 0x000)
+#define MT_DMA_DCR0_RXD_G5_EN			BIT(23)
+
+#define MT_DMA_TCRF1(_band)			MT_WF_DMA(_band, 0x054)
+#define MT_DMA_TCRF1_QIDX			GENMASK(15, 13)
+
+/* ETBF: band 0(0x820ea000), band 1(0x820fa000), band 2(0x830ea000) */
+#define MT_WF_ETBF_BASE(_band)			__BASE(WF_ETBF_BASE, (_band))
+#define MT_WF_ETBF(_band, ofs)			(MT_WF_ETBF_BASE(_band) + (ofs))
+
+#define MT_ETBF_RX_FB_CONT(_band)		MT_WF_ETBF(_band, 0x100)
+#define MT_ETBF_RX_FB_BW			GENMASK(10, 8)
+#define MT_ETBF_RX_FB_NC			GENMASK(7, 4)
+#define MT_ETBF_RX_FB_NR			GENMASK(3, 0)
+
+/* LPON: band 0(0x820eb000), band 1(0x820fb000), band 2(0x830eb000) */
+#define MT_WF_LPON_BASE(_band)			__BASE(WF_LPON_BASE, (_band))
+#define MT_WF_LPON(_band, ofs)			(MT_WF_LPON_BASE(_band) + (ofs))
+
+#define MT_LPON_UTTR0(_band)			MT_WF_LPON(_band, 0x360)
+#define MT_LPON_UTTR1(_band)			MT_WF_LPON(_band, 0x364)
+#define MT_LPON_FRCR(_band)			MT_WF_LPON(_band, 0x37c)
+
+#define MT_LPON_TCR(_band, n)			MT_WF_LPON(_band, 0x0a8 + (((n) * 4) << 4))
+#define MT_LPON_TCR_SW_MODE			GENMASK(1, 0)
+#define MT_LPON_TCR_SW_WRITE			BIT(0)
+#define MT_LPON_TCR_SW_ADJUST			BIT(1)
+#define MT_LPON_TCR_SW_READ			GENMASK(1, 0)
+
+/* MIB: band 0(0x820ed000), band 1(0x820fd000), band 2(0x830ed000)*/
+/* These counters are (mostly?) clear-on-read.  So, some should not
+ * be read at all in case firmware is already reading them.  These
+ * are commented with 'DNR' below. The DNR stats will be read by querying
+ * the firmware API for the appropriate message.  For counters the driver
+ * does read, the driver should accumulate the counters.
+ */
+#define MT_WF_MIB_BASE(_band)			__BASE(WF_MIB_BASE, (_band))
+#define MT_WF_MIB(_band, ofs)			(MT_WF_MIB_BASE(_band) + (ofs))
+
+#define MT_MIB_BSCR0(_band)			MT_WF_MIB(_band, 0x9cc)
+#define MT_MIB_BSCR1(_band)			MT_WF_MIB(_band, 0x9d0)
+#define MT_MIB_BSCR2(_band)			MT_WF_MIB(_band, 0x9d4)
+#define MT_MIB_BSCR3(_band)			MT_WF_MIB(_band, 0x9d8)
+#define MT_MIB_BSCR4(_band)			MT_WF_MIB(_band, 0x9dc)
+#define MT_MIB_BSCR5(_band)			MT_WF_MIB(_band, 0x9e0)
+#define MT_MIB_BSCR6(_band)			MT_WF_MIB(_band, 0x9e4)
+#define MT_MIB_BSCR7(_band)			MT_WF_MIB(_band, 0x9e8)
+#define MT_MIB_BSCR17(_band)			MT_WF_MIB(_band, 0xa10)
+
+#define MT_MIB_TSCR5(_band)			MT_WF_MIB(_band, 0x6c4)
+#define MT_MIB_TSCR6(_band)			MT_WF_MIB(_band, 0x6c8)
+#define MT_MIB_TSCR7(_band)			MT_WF_MIB(_band, 0x6d0)
+
+#define MT_MIB_RSCR1(_band)			MT_WF_MIB(_band, 0x7ac)
+/* rx mpdu counter, full 32 bits */
+#define MT_MIB_RSCR31(_band)			MT_WF_MIB(_band, 0x964)
+#define MT_MIB_RSCR33(_band)			MT_WF_MIB(_band, 0x96c)
+
+#define MT_MIB_SDR6(_band)			MT_WF_MIB(_band, 0x020)
+#define MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK	GENMASK(15, 0)
+
+#define MT_MIB_RVSR0(_band)			MT_WF_MIB(_band, 0x720)
+
+#define MT_MIB_RSCR35(_band)			MT_WF_MIB(_band, 0x974)
+#define MT_MIB_RSCR36(_band)			MT_WF_MIB(_band, 0x978)
+
+/* tx ampdu cnt, full 32 bits */
+#define MT_MIB_TSCR0(_band)			MT_WF_MIB(_band, 0x6b0)
+#define MT_MIB_TSCR2(_band)			MT_WF_MIB(_band, 0x6b8)
+
+/* counts all mpdus in ampdu, regardless of success */
+#define MT_MIB_TSCR3(_band)			MT_WF_MIB(_band, 0x6bc)
+
+/* counts all successfully tx'd mpdus in ampdu */
+#define MT_MIB_TSCR4(_band)			MT_WF_MIB(_band, 0x6c0)
+
+/* rx ampdu count, 32-bit */
+#define MT_MIB_RSCR27(_band)			MT_WF_MIB(_band, 0x954)
+
+/* rx ampdu bytes count, 32-bit */
+#define MT_MIB_RSCR28(_band)			MT_WF_MIB(_band, 0x958)
+
+/* rx ampdu valid subframe count */
+#define MT_MIB_RSCR29(_band)			MT_WF_MIB(_band, 0x95c)
+
+/* rx ampdu valid subframe bytes count, 32bits */
+#define MT_MIB_RSCR30(_band)			MT_WF_MIB(_band, 0x960)
+
+/* remaining windows protected stats */
+#define MT_MIB_SDR27(_band)			MT_WF_MIB(_band, 0x080)
+#define MT_MIB_SDR27_TX_RWP_FAIL_CNT		GENMASK(15, 0)
+
+#define MT_MIB_SDR28(_band)			MT_WF_MIB(_band, 0x084)
+#define MT_MIB_SDR28_TX_RWP_NEED_CNT		GENMASK(15, 0)
+
+#define MT_MIB_RVSR1(_band)			MT_WF_MIB(_band, 0x724)
+
+/* rx blockack count, 32 bits */
+#define MT_MIB_TSCR1(_band)			MT_WF_MIB(_band, 0x6b4)
+
+#define MT_MIB_BTSCR0(_band)			MT_WF_MIB(_band, 0x5e0)
+#define MT_MIB_BTSCR5(_band)			MT_WF_MIB(_band, 0x788)
+#define MT_MIB_BTSCR6(_band)			MT_WF_MIB(_band, 0x798)
+
+#define MT_MIB_BFTFCR(_band)			MT_WF_MIB(_band, 0x5d0)
+
+#define MT_TX_AGG_CNT(_band, n)			MT_WF_MIB(_band, 0xa28 + ((n) << 2))
+#define MT_MIB_ARNG(_band, n)			MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
+#define MT_MIB_ARNCR_RANGE(val, n)		(((val) >> ((n) << 4)) & GENMASK(9, 0))
+
+/* UMIB */
+#define MT_WF_UMIB_BASE				0x820cd000
+#define MT_WF_UMIB(ofs)				(MT_WF_UMIB_BASE + (ofs))
+
+#define MT_UMIB_RPDCR(_band)			(MT_WF_UMIB(0x594) + (_band) * 0x164)
+
+/* WTBLON TOP */
+#define MT_WTBLON_TOP_BASE			0x820d4000
+#define MT_WTBLON_TOP(ofs)			(MT_WTBLON_TOP_BASE + (ofs))
+#define MT_WTBLON_TOP_WDUCR			MT_WTBLON_TOP(0x370)
+#define MT_WTBLON_TOP_WDUCR_GROUP		GENMASK(4, 0)
+
+#define MT_WTBL_UPDATE				MT_WTBLON_TOP(0x380)
+#define MT_WTBL_UPDATE_WLAN_IDX			GENMASK(11, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR		BIT(14)
+#define MT_WTBL_UPDATE_BUSY			BIT(31)
+
+/* WTBL */
+#define MT_WTBL_BASE				0x820d8000
+#define MT_WTBL_LMAC_ID				GENMASK(14, 8)
+#define MT_WTBL_LMAC_DW				GENMASK(7, 2)
+#define MT_WTBL_LMAC_OFFS(_id, _dw)		(MT_WTBL_BASE | \
+						 FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+						 FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+
+/* AGG: band 0(0x820e2000), band 1(0x820f2000), band 2(0x830e2000) */
+#define MT_WF_AGG_BASE(_band)			__BASE(WF_AGG_BASE, (_band))
+#define MT_WF_AGG(_band, ofs)			(MT_WF_AGG_BASE(_band) + (ofs))
+
+#define MT_AGG_ACR0(_band)			MT_WF_AGG(_band, 0x054)
+#define MT_AGG_ACR_CFEND_RATE			GENMASK(13, 0)
+
+/* ARB: band 0(0x820e3000), band 1(0x820f3000), band 2(0x830e3000) */
+#define MT_WF_ARB_BASE(_band)			__BASE(WF_ARB_BASE, (_band))
+#define MT_WF_ARB(_band, ofs)			(MT_WF_ARB_BASE(_band) + (ofs))
+
+#define MT_ARB_SCR(_band)			MT_WF_ARB(_band, 0x000)
+#define MT_ARB_SCR_TX_DISABLE			BIT(8)
+#define MT_ARB_SCR_RX_DISABLE			BIT(9)
+
+/* RMAC: band 0(0x820e5000), band 1(0x820f5000), band 2(0x830e5000), */
+#define MT_WF_RMAC_BASE(_band)			__BASE(WF_RMAC_BASE, (_band))
+#define MT_WF_RMAC(_band, ofs)			(MT_WF_RMAC_BASE(_band) + (ofs))
+
+#define MT_WF_RFCR(_band)			MT_WF_RMAC(_band, 0x000)
+#define MT_WF_RFCR_DROP_STBC_MULTI		BIT(0)
+#define MT_WF_RFCR_DROP_FCSFAIL			BIT(1)
+#define MT_WF_RFCR_DROP_PROBEREQ		BIT(4)
+#define MT_WF_RFCR_DROP_MCAST			BIT(5)
+#define MT_WF_RFCR_DROP_BCAST			BIT(6)
+#define MT_WF_RFCR_DROP_MCAST_FILTERED		BIT(7)
+#define MT_WF_RFCR_DROP_A3_MAC			BIT(8)
+#define MT_WF_RFCR_DROP_A3_BSSID		BIT(9)
+#define MT_WF_RFCR_DROP_A2_BSSID		BIT(10)
+#define MT_WF_RFCR_DROP_OTHER_BEACON		BIT(11)
+#define MT_WF_RFCR_DROP_FRAME_REPORT		BIT(12)
+#define MT_WF_RFCR_DROP_CTL_RSV			BIT(13)
+#define MT_WF_RFCR_DROP_CTS			BIT(14)
+#define MT_WF_RFCR_DROP_RTS			BIT(15)
+#define MT_WF_RFCR_DROP_DUPLICATE		BIT(16)
+#define MT_WF_RFCR_DROP_OTHER_BSS		BIT(17)
+#define MT_WF_RFCR_DROP_OTHER_UC		BIT(18)
+#define MT_WF_RFCR_DROP_OTHER_TIM		BIT(19)
+#define MT_WF_RFCR_DROP_NDPA			BIT(20)
+#define MT_WF_RFCR_DROP_UNWANTED_CTL		BIT(21)
+
+#define MT_WF_RFCR1(_band)			MT_WF_RMAC(_band, 0x004)
+#define MT_WF_RFCR1_DROP_ACK			BIT(4)
+#define MT_WF_RFCR1_DROP_BF_POLL		BIT(5)
+#define MT_WF_RFCR1_DROP_BA			BIT(6)
+#define MT_WF_RFCR1_DROP_CFEND			BIT(7)
+#define MT_WF_RFCR1_DROP_CFACK			BIT(8)
+
+#define MT_WF_RMAC_MIB_AIRTIME0(_band)		MT_WF_RMAC(_band, 0x0380)
+#define MT_WF_RMAC_MIB_RXTIME_CLR		BIT(31)
+#define MT_WF_RMAC_MIB_ED_OFFSET		GENMASK(20, 16)
+#define MT_WF_RMAC_MIB_OBSS_BACKOFF		GENMASK(15, 0)
+
+#define MT_WF_RMAC_MIB_AIRTIME1(_band)		MT_WF_RMAC(_band, 0x0384)
+#define MT_WF_RMAC_MIB_NONQOSD_BACKOFF		GENMASK(31, 16)
+
+#define MT_WF_RMAC_MIB_AIRTIME3(_band)		MT_WF_RMAC(_band, 0x038c)
+#define MT_WF_RMAC_MIB_QOS01_BACKOFF		GENMASK(31, 0)
+
+#define MT_WF_RMAC_MIB_AIRTIME4(_band)		MT_WF_RMAC(_band, 0x0390)
+#define MT_WF_RMAC_MIB_QOS23_BACKOFF		GENMASK(31, 0)
+
+#define MT_WF_RMAC_RSVD0(_band)			MT_WF_RMAC(_band, 0x03e0)
+#define MT_WF_RMAC_RSVD0_EIFS_CLR		BIT(21)
+
+/* WFDMA0 */
+#define MT_WFDMA0_BASE				0xd4000
+#define MT_WFDMA0(ofs)				(MT_WFDMA0_BASE + (ofs))
+
+#define MT_WFDMA0_RST				MT_WFDMA0(0x100)
+#define MT_WFDMA0_RST_LOGIC_RST			BIT(4)
+#define MT_WFDMA0_RST_DMASHDL_ALL_RST		BIT(5)
+
+#define MT_WFDMA0_BUSY_ENA			MT_WFDMA0(0x13c)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO0		BIT(0)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO1		BIT(1)
+#define MT_WFDMA0_BUSY_ENA_RX_FIFO		BIT(2)
+
+#define MT_WFDMA0_RX_INT_PCIE_SEL		MT_WFDMA0(0x154)
+#define MT_WFDMA0_RX_INT_SEL_RING3		BIT(3)
+
+#define MT_WFDMA0_GLO_CFG			MT_WFDMA0(0x208)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_EN		BIT(0)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_EN		BIT(2)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO		BIT(28)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO		BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+
+#define WF_WFDMA0_GLO_CFG_EXT0			MT_WFDMA0(0x2b0)
+#define WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD	BIT(18)
+#define WF_WFDMA0_GLO_CFG_EXT0_WED_MERGE_MODE	BIT(14)
+
+#define WF_WFDMA0_GLO_CFG_EXT1			MT_WFDMA0(0x2b4)
+#define WF_WFDMA0_GLO_CFG_EXT1_CALC_MODE	BIT(31)
+#define WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE	BIT(28)
+
+#define MT_WFDMA0_RST_DTX_PTR			MT_WFDMA0(0x20c)
+#define MT_WFDMA0_PRI_DLY_INT_CFG0		MT_WFDMA0(0x2f0)
+#define MT_WFDMA0_PRI_DLY_INT_CFG1		MT_WFDMA0(0x2f4)
+#define MT_WFDMA0_PRI_DLY_INT_CFG2		MT_WFDMA0(0x2f8)
+
+/* WFDMA1 */
+#define MT_WFDMA1_BASE				0xd5000
+
+/* WFDMA CSR */
+#define MT_WFDMA_EXT_CSR_BASE			0xd7000
+#define MT_WFDMA_EXT_CSR(ofs)			(MT_WFDMA_EXT_CSR_BASE + (ofs))
+
+#define MT_WFDMA_HOST_CONFIG			MT_WFDMA_EXT_CSR(0x30)
+#define MT_WFDMA_HOST_CONFIG_PDMA_BAND		BIT(0)
+
+#define MT_WFDMA_EXT_CSR_HIF_MISC		MT_WFDMA_EXT_CSR(0x44)
+#define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY		BIT(0)
+
+#define MT_PCIE_RECOG_ID			0xd7090
+#define MT_PCIE_RECOG_ID_MASK			GENMASK(30, 0)
+#define MT_PCIE_RECOG_ID_SEM			BIT(31)
+
+/* WFDMA0 PCIE1 */
+#define MT_WFDMA0_PCIE1_BASE			0xd8000
+#define MT_WFDMA0_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+
+#define MT_WFDMA0_PCIE1_BUSY_ENA		MT_WFDMA0_PCIE1(0x13c)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
+#define MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
+
+/* WFDMA COMMON */
+#define __RXQ(q)				((q) + __MT_MCUQ_MAX)
+#define __TXQ(q)				(__RXQ(q) + __MT_RXQ_MAX)
+
+#define MT_Q_ID(q)				(dev->q_id[(q)])
+#define MT_Q_BASE(q)				((dev->q_wfdma_mask >> (q)) & 0x1 ?	\
+						 MT_WFDMA1_BASE : MT_WFDMA0_BASE)
+
+#define MT_MCUQ_ID(q)				MT_Q_ID(q)
+#define MT_TXQ_ID(q)				MT_Q_ID(__TXQ(q))
+#define MT_RXQ_ID(q)				MT_Q_ID(__RXQ(q))
+
+#define MT_MCUQ_RING_BASE(q)			(MT_Q_BASE(q) + 0x300)
+#define MT_TXQ_RING_BASE(q)			(MT_Q_BASE(__TXQ(q)) + 0x300)
+#define MT_RXQ_RING_BASE(q)			(MT_Q_BASE(__RXQ(q)) + 0x500)
+
+#define MT_MCUQ_EXT_CTRL(q)			(MT_Q_BASE(q) +	0x600 +	\
+						 MT_MCUQ_ID(q) * 0x4)
+#define MT_RXQ_BAND1_CTRL(q)			(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
+						 MT_RXQ_ID(q) * 0x4)
+#define MT_TXQ_EXT_CTRL(q)			(MT_Q_BASE(__TXQ(q)) + 0x600 +	\
+						 MT_TXQ_ID(q) * 0x4)
+
+#define MT_INT_SOURCE_CSR			MT_WFDMA0(0x200)
+#define MT_INT_MASK_CSR				MT_WFDMA0(0x204)
+
+#define MT_INT1_SOURCE_CSR			MT_WFDMA0_PCIE1(0x200)
+#define MT_INT1_MASK_CSR			MT_WFDMA0_PCIE1(0x204)
+
+#define MT_INT_RX_DONE_BAND0			BIT(12)
+#define MT_INT_RX_DONE_BAND1			BIT(12)
+#define MT_INT_RX_DONE_BAND2			BIT(13)
+#define MT_INT_RX_DONE_WM			BIT(0)
+#define MT_INT_RX_DONE_WA			BIT(1)
+#define MT_INT_RX_DONE_WA_MAIN			BIT(2)
+#define MT_INT_RX_DONE_WA_EXT			BIT(2)
+#define MT_INT_RX_DONE_WA_TRI			BIT(3)
+#define MT_INT_RX_TXFREE_MAIN			BIT(17)
+#define MT_INT_RX_TXFREE_TRI			BIT(15)
+#define MT_INT_MCU_CMD				BIT(29)
+
+#define MT_INT_RX(q)				(dev->q_int_mask[__RXQ(q)])
+#define MT_INT_TX_MCU(q)			(dev->q_int_mask[(q)])
+
+#define MT_INT_RX_DONE_MCU			(MT_INT_RX(MT_RXQ_MCU) |	\
+						 MT_INT_RX(MT_RXQ_MCU_WA))
+
+#define MT_INT_BAND0_RX_DONE			(MT_INT_RX(MT_RXQ_MAIN) |	\
+						 MT_INT_RX(MT_RXQ_MAIN_WA))
+
+#define MT_INT_BAND1_RX_DONE			(MT_INT_RX(MT_RXQ_BAND1) |	\
+						 MT_INT_RX(MT_RXQ_BAND1_WA) |	\
+						 MT_INT_RX(MT_RXQ_MAIN_WA))
+
+#define MT_INT_BAND2_RX_DONE			(MT_INT_RX(MT_RXQ_BAND2) |	\
+						 MT_INT_RX(MT_RXQ_BAND2_WA) |	\
+						 MT_INT_RX(MT_RXQ_MAIN_WA))
+
+#define MT_INT_RX_DONE_ALL			(MT_INT_RX_DONE_MCU |		\
+						 MT_INT_BAND0_RX_DONE |		\
+						 MT_INT_BAND1_RX_DONE |		\
+						 MT_INT_BAND2_RX_DONE)
+
+#define MT_INT_TX_DONE_FWDL			BIT(26)
+#define MT_INT_TX_DONE_MCU_WM			BIT(27)
+#define MT_INT_TX_DONE_MCU_WA			BIT(22)
+#define MT_INT_TX_DONE_BAND0			BIT(30)
+#define MT_INT_TX_DONE_BAND1			BIT(31)
+#define MT_INT_TX_DONE_BAND2			BIT(15)
+
+#define MT_INT_TX_DONE_MCU			(MT_INT_TX_MCU(MT_MCUQ_WA) |	\
+						 MT_INT_TX_MCU(MT_MCUQ_WM) |	\
+						 MT_INT_TX_MCU(MT_MCUQ_FWDL))
+
+#define MT_MCU_CMD				MT_WFDMA0(0x1f0)
+#define MT_MCU_CMD_STOP_DMA			BIT(2)
+#define MT_MCU_CMD_RESET_DONE			BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE		BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE			BIT(5)
+#define MT_MCU_CMD_ERROR_MASK			GENMASK(5, 1)
+
+/* l1/l2 remap */
+#define MT_HIF_REMAP_L1				0x155024
+#define MT_HIF_REMAP_L1_MASK			GENMASK(31, 16)
+#define MT_HIF_REMAP_L1_OFFSET			GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_BASE			GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L1			0x130000
+
+#define MT_HIF_REMAP_L2				0x1b4
+#define MT_HIF_REMAP_L2_MASK			GENMASK(19, 0)
+#define MT_HIF_REMAP_L2_OFFSET			GENMASK(11, 0)
+#define MT_HIF_REMAP_L2_BASE			GENMASK(31, 12)
+#define MT_HIF_REMAP_BASE_L2			0x1000
+
+#define MT_INFRA_BASE				0x18000000
+#define MT_WFSYS0_PHY_START			0x18400000
+#define MT_WFSYS1_PHY_START			0x18800000
+#define MT_WFSYS1_PHY_END			0x18bfffff
+#define MT_CBTOP1_PHY_START			0x70000000
+#define MT_CBTOP1_PHY_END			0x77ffffff
+#define MT_CBTOP2_PHY_START			0xf0000000
+#define MT_CBTOP2_PHY_END			0xffffffff
+#define MT_INFRA_MCU_START			0x7c000000
+#define MT_INFRA_MCU_END			0x7c3fffff
+
+/* FW MODE SYNC */
+#define MT_SWDEF_MODE				0x9143c
+#define MT_SWDEF_NORMAL_MODE			0
+
+/* LED */
+#define MT_LED_TOP_BASE				0x18013000
+#define MT_LED_PHYS(_n)				(MT_LED_TOP_BASE + (_n))
+
+#define MT_LED_CTRL(_n)				MT_LED_PHYS(0x00 + ((_n) * 4))
+#define MT_LED_CTRL_KICK			BIT(7)
+#define MT_LED_CTRL_BLINK_MODE			BIT(2)
+#define MT_LED_CTRL_POLARITY			BIT(1)
+
+#define MT_LED_TX_BLINK(_n)			MT_LED_PHYS(0x10 + ((_n) * 4))
+#define MT_LED_TX_BLINK_ON_MASK			GENMASK(7, 0)
+#define MT_LED_TX_BLINK_OFF_MASK		GENMASK(15, 8)
+
+#define MT_LED_EN(_n)				MT_LED_PHYS(0x40 + ((_n) * 4))
+
+#define MT_LED_GPIO_MUX2			0x70005058 /* GPIO 18 */
+#define MT_LED_GPIO_MUX3			0x7000505C /* GPIO 26 */
+#define MT_LED_GPIO_SEL_MASK			GENMASK(11, 8)
+
+/* MT TOP */
+#define MT_TOP_BASE				0xe0000
+#define MT_TOP(ofs)				(MT_TOP_BASE + (ofs))
+
+#define MT_TOP_LPCR_HOST_BAND(_band)		MT_TOP(0x10 + ((_band) * 0x10))
+#define MT_TOP_LPCR_HOST_FW_OWN			BIT(0)
+#define MT_TOP_LPCR_HOST_DRV_OWN		BIT(1)
+#define MT_TOP_LPCR_HOST_FW_OWN_STAT		BIT(2)
+
+#define MT_TOP_LPCR_HOST_BAND_IRQ_STAT(_band)	MT_TOP(0x14 + ((_band) * 0x10))
+#define MT_TOP_LPCR_HOST_BAND_STAT		BIT(0)
+
+#define MT_TOP_MISC				MT_TOP(0xf0)
+#define MT_TOP_MISC_FW_STATE			GENMASK(2, 0)
+
+#define MT_HW_REV				0x70010204
+#define MT_WF_SUBSYS_RST			0x70002600
+
+/* PCIE MAC */
+#define MT_PCIE_MAC_BASE			0x74030000
+#define MT_PCIE_MAC(ofs)			(MT_PCIE_MAC_BASE + (ofs))
+#define MT_PCIE_MAC_INT_ENABLE			MT_PCIE_MAC(0x188)
+
+#define MT_PCIE1_MAC_BASE			0x74090000
+#define MT_PCIE1_MAC(ofs)			(MT_PCIE1_MAC_BASE + (ofs))
+
+#define MT_PCIE1_MAC_INT_ENABLE			MT_PCIE1_MAC(0x188)
+
+/* PHYRX CTRL */
+#define MT_WF_PHYRX_BAND_BASE			0x83080000
+#define MT_WF_PHYRX_BAND(_band, ofs)		(MT_WF_PHYRX_BAND_BASE + \
+						 ((_band) << 20) + (ofs))
+
+#define MT_WF_PHYRX_BAND_RX_CTRL1(_band)	MT_WF_PHYRX_BAND(_band, 0x2004)
+#define MT_WF_PHYRX_BAND_RX_CTRL1_IPI_EN	GENMASK(2, 0)
+#define MT_WF_PHYRX_BAND_RX_CTRL1_STSCNT_EN	GENMASK(11, 9)
+
+/* PHYRX CSD */
+#define MT_WF_PHYRX_CSD_BASE			0x83000000
+#define MT_WF_PHYRX_CSD(_band, _wf, ofs)	(MT_WF_PHYRX_CSD_BASE + \
+						 ((_band) << 20) + \
+						 ((_wf) << 16) + (ofs))
+#define MT_WF_PHYRX_CSD_IRPI(_band, _wf)	MT_WF_PHYRX_CSD(_band, _wf, 0x1000)
+
+/* PHYRX CSD BAND */
+#define MT_WF_PHYRX_CSD_BAND_RXTD12(_band)		MT_WF_PHYRX_BAND(_band, 0x8230)
+#define MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
+#define MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR		BIT(29)
+
+#endif
-- 
2.25.1

