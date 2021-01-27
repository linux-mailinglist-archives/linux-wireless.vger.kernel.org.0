Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAA7306121
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhA0QiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhA0Qgz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 11:36:55 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443FDC061574
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jan 2021 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ebBHIWWfiNb6dq/D4ukZsfMkaGHsydhDZjwKvexbCfM=; b=Q+cEcdbwyZpeNu333TxNEGumc9
        27G+uWVN90NL4Zgkv8twopsBeAlzsx8EyfUzOptpI4/APbCqgygfpitQfIC+MKrnBwf2IEOkJm3iS
        AQI7ffApYDovitRv4GDuiAu4gQRkYHmte5suaKu8CQlKDI6HL1aHXaqJ57IkT3HU/vjY=;
Received: from p54ae9023.dip0.t-ipconnect.de ([84.174.144.35] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4nnh-0004rt-Rt
        for linux-wireless@vger.kernel.org; Wed, 27 Jan 2021 17:36:14 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/3] mt76: mt7915: add support for using a secondary PCIe link for gen1
Date:   Wed, 27 Jan 2021 17:36:12 +0100
Message-Id: <20210127163612.91040-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210119164943.99223-3-nbd@nbd.name>
References: <20210119164943.99223-3-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For performance reasons, mt7915 supports using 2 PCIE gen1 links on
platforms that don't support gen2.
Add support for using this to move traffic for a second DBDC band onto
a dedicated link

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: prevent writes to irq mask and recognition id register when gen1 is not in use
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  96 +++++++---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  17 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  25 ++-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 173 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  18 ++
 5 files changed, 290 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index d47d8f4376c6..bf51304a770b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -73,34 +73,41 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
 	return 0;
 }
 
-void mt7915_dma_prefetch(struct mt7915_dev *dev)
+static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
 {
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
 
-	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL, PREFETCH(0x40, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x80, 0x0));
-
-	mt76_wr(dev, MT_WFDMA1_TX_RING0_EXT_CTRL, PREFETCH(0x80, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING1_EXT_CTRL, PREFETCH(0xc0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING2_EXT_CTRL, PREFETCH(0x100, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING3_EXT_CTRL, PREFETCH(0x140, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING4_EXT_CTRL, PREFETCH(0x180, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING5_EXT_CTRL, PREFETCH(0x1c0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING6_EXT_CTRL, PREFETCH(0x200, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING7_EXT_CTRL, PREFETCH(0x240, 0x4));
-
-	mt76_wr(dev, MT_WFDMA1_TX_RING16_EXT_CTRL, PREFETCH(0x280, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING17_EXT_CTRL, PREFETCH(0x2c0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING18_EXT_CTRL, PREFETCH(0x300, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING19_EXT_CTRL, PREFETCH(0x340, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING20_EXT_CTRL, PREFETCH(0x380, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING21_EXT_CTRL, PREFETCH(0x3c0, 0x0));
-
-	mt76_wr(dev, MT_WFDMA1_RX_RING0_EXT_CTRL, PREFETCH(0x3c0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_RX_RING1_EXT_CTRL, PREFETCH(0x400, 0x4));
-	mt76_wr(dev, MT_WFDMA1_RX_RING2_EXT_CTRL, PREFETCH(0x440, 0x4));
-	mt76_wr(dev, MT_WFDMA1_RX_RING3_EXT_CTRL, PREFETCH(0x480, 0x0));
+	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL + ofs, PREFETCH(0x0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL + ofs, PREFETCH(0x40, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL + ofs, PREFETCH(0x80, 0x0));
+
+	mt76_wr(dev, MT_WFDMA1_TX_RING0_EXT_CTRL + ofs, PREFETCH(0x80, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING1_EXT_CTRL + ofs, PREFETCH(0xc0, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING2_EXT_CTRL + ofs, PREFETCH(0x100, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING3_EXT_CTRL + ofs, PREFETCH(0x140, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING4_EXT_CTRL + ofs, PREFETCH(0x180, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING5_EXT_CTRL + ofs, PREFETCH(0x1c0, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING6_EXT_CTRL + ofs, PREFETCH(0x200, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING7_EXT_CTRL + ofs, PREFETCH(0x240, 0x4));
+
+	mt76_wr(dev, MT_WFDMA1_TX_RING16_EXT_CTRL + ofs, PREFETCH(0x280, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING17_EXT_CTRL + ofs, PREFETCH(0x2c0, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING18_EXT_CTRL + ofs, PREFETCH(0x300, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING19_EXT_CTRL + ofs, PREFETCH(0x340, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING20_EXT_CTRL + ofs, PREFETCH(0x380, 0x4));
+	mt76_wr(dev, MT_WFDMA1_TX_RING21_EXT_CTRL + ofs, PREFETCH(0x3c0, 0x0));
+
+	mt76_wr(dev, MT_WFDMA1_RX_RING0_EXT_CTRL + ofs, PREFETCH(0x3c0, 0x4));
+	mt76_wr(dev, MT_WFDMA1_RX_RING1_EXT_CTRL + ofs, PREFETCH(0x400, 0x4));
+	mt76_wr(dev, MT_WFDMA1_RX_RING2_EXT_CTRL + ofs, PREFETCH(0x440, 0x4));
+	mt76_wr(dev, MT_WFDMA1_RX_RING3_EXT_CTRL + ofs, PREFETCH(0x480, 0x0));
+}
+
+void mt7915_dma_prefetch(struct mt7915_dev *dev)
+{
+	__mt7915_dma_prefetch(dev, 0);
+	if (dev->hif2)
+		__mt7915_dma_prefetch(dev, MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE);
 }
 
 static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
@@ -204,6 +211,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	/* Increase buffer size to receive large VHT/HE MPDUs */
 	struct mt76_bus_ops *bus_ops;
 	int rx_buf_size = MT_RX_BUF_SIZE * 2;
+	u32 hif1_ofs = 0;
 	int ret;
 
 	dev->bus_ops = dev->mt76.bus;
@@ -219,14 +227,14 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 
 	mt76_dma_attach(&dev->mt76);
 
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE;
+
 	/* configure global setting */
 	mt76_set(dev, MT_WFDMA1_GLO_CFG,
 		 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
 		 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
 
-	/* configure perfetch settings */
-	mt7915_dma_prefetch(dev);
-
 	/* reset dma idx */
 	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
 	mt76_wr(dev, MT_WFDMA1_RST_DTX_PTR, ~0);
@@ -235,6 +243,21 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
 	mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0, 0);
 
+	if (dev->hif2) {
+		mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+			 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+			 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
+
+		mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR + hif1_ofs, ~0);
+		mt76_wr(dev, MT_WFDMA1_RST_DTX_PTR + hif1_ofs, ~0);
+
+		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0 + hif1_ofs, 0);
+		mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0 + hif1_ofs, 0);
+	}
+
+	/* configure perfetch settings */
+	mt7915_dma_prefetch(dev);
+
 	/* init tx queue */
 	ret = mt7915_init_tx_queues(&dev->phy, MT7915_TXQ_BAND0,
 				    MT7915_TX_RING_SIZE);
@@ -283,7 +306,8 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	if (dev->dbdc_support) {
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT],
 				       MT7915_RXQ_BAND1, MT7915_RX_RING_SIZE,
-				       rx_buf_size, MT_RX_DATA_RING_BASE);
+				       rx_buf_size,
+				       MT_RX_DATA_RING_BASE + hif1_ofs);
 		if (ret)
 			return ret;
 
@@ -291,7 +315,8 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT_WA],
 				       MT7915_RXQ_MCU_WA_EXT,
 				       MT7915_RX_MCU_RING_SIZE,
-				       rx_buf_size, MT_RX_EVENT_RING_BASE);
+				       rx_buf_size,
+				       MT_RX_EVENT_RING_BASE + hif1_ofs);
 		if (ret)
 			return ret;
 	}
@@ -334,6 +359,17 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	mt76_set(dev, MT_WFDMA1_GLO_CFG,
 		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
 
+	if (dev->hif2) {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			 (MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			  MT_WFDMA0_GLO_CFG_RX_DMA_EN));
+		mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+			 (MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+			  MT_WFDMA1_GLO_CFG_RX_DMA_EN));
+		mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+			 MT_WFDMA_HOST_CONFIG_PDMA_BAND);
+	}
+
 	/* enable interrupts for TX/RX rings */
 	mt7915_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_MCU |
 			  MT_INT_MCU_CMD);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 8de965d1b03b..eb889f8d6fea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1474,12 +1474,21 @@ mt7915_dma_reset(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy_ext = dev->mt76.phy2;
+	u32 hif1_ofs = MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE;
 	int i;
 
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
 		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 	mt76_clear(dev, MT_WFDMA1_GLO_CFG,
 		   MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
+	if (dev->hif2) {
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			   (MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			    MT_WFDMA0_GLO_CFG_RX_DMA_EN));
+		mt76_clear(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+			   (MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+			    MT_WFDMA1_GLO_CFG_RX_DMA_EN));
+	}
 	usleep_range(1000, 2000);
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], true);
@@ -1500,6 +1509,14 @@ mt7915_dma_reset(struct mt7915_phy *phy)
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 	mt76_set(dev, MT_WFDMA1_GLO_CFG,
 		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
+	if (dev->hif2) {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			(MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_RX_DMA_EN));
+		mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+			(MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA1_GLO_CFG_RX_DMA_EN));
+	}
 }
 
 void mt7915_tx_token_put(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a5882faa62ce..5c7eefdf2013 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -115,6 +115,14 @@ struct mib_stats {
 	u16 ba_miss_cnt;
 };
 
+struct mt7915_hif {
+	struct list_head list;
+
+	struct device *dev;
+	void __iomem *regs;
+	int irq;
+};
+
 struct mt7915_phy {
 	struct mt76_phy *mt76;
 	struct mt7915_dev *dev;
@@ -163,10 +171,13 @@ struct mt7915_dev {
 		struct mt76_phy mphy;
 	};
 
+	struct mt7915_hif *hif2;
+
 	const struct mt76_bus_ops *bus_ops;
 	struct mt7915_phy phy;
 
 	u16 chainmask;
+	u32 hif_idx;
 
 	struct work_struct init_work;
 	struct work_struct rc_work;
@@ -278,7 +289,6 @@ static inline u8 mt7915_lmac_mapping(struct mt7915_dev *dev, u8 ac)
 }
 
 extern const struct ieee80211_ops mt7915_ops;
-extern struct pci_driver mt7915_pci_driver;
 extern const struct mt76_testmode_ops mt7915_testmode_ops;
 
 u32 mt7915_reg_map(struct mt7915_dev *dev, u32 addr);
@@ -365,14 +375,23 @@ static inline bool is_mt7915(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7915;
 }
 
+void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev, bool write_reg,
+				  u32 clear, u32 set);
+
 static inline void mt7915_irq_enable(struct mt7915_dev *dev, u32 mask)
 {
-	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
+	if (dev->hif2)
+		mt7915_dual_hif_set_irq_mask(dev, true, 0, mask);
+	else
+		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
 }
 
 static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
 {
-	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
+	if (dev->hif2)
+		mt7915_dual_hif_set_irq_mask(dev, true, mask, 0);
+	else
+		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
 static inline u32
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 99f11588601d..13880cc9c9e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -12,11 +12,72 @@
 #include "mac.h"
 #include "../trace.h"
 
+static LIST_HEAD(hif_list);
+static DEFINE_SPINLOCK(hif_lock);
+static u32 hif_idx;
+
 static const struct pci_device_id mt7915_pci_device_table[] = {
-	{ PCI_DEVICE(0x14c3, 0x7915) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7915) },
 	{ },
 };
 
+static const struct pci_device_id mt7915_hif_device_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7916) },
+	{ },
+};
+
+void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev, bool write_reg,
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
+static struct mt7915_hif *
+mt7915_pci_get_hif2(struct mt7915_dev *dev)
+{
+	struct mt7915_hif *hif;
+	u32 val;
+
+	spin_lock_bh(&hif_lock);
+
+	list_for_each_entry(hif, &hif_list, list) {
+		val = readl(hif->regs + MT_PCIE_RECOG_ID);
+		val &= MT_PCIE_RECOG_ID_MASK;
+		if (val != dev->hif_idx)
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
+static void mt7915_put_hif2(struct mt7915_hif *hif)
+{
+	if (!hif)
+		return;
+
+	put_device(hif->dev);
+}
+
 static void
 mt7915_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
@@ -36,12 +97,20 @@ mt7915_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 {
 	struct mt7915_dev *dev = dev_instance;
-	u32 intr, mask;
+	u32 intr, intr1, mask;
 
 	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
 	intr &= dev->mt76.mmio.irqmask;
 	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
 
+	if (dev->hif2) {
+		intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
+		intr1 &= dev->mt76.mmio.irqmask;
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, intr1);
+
+		intr |= intr1;
+	}
+
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
@@ -107,6 +176,53 @@ mt7915_alloc_device(struct pci_dev *pdev, struct mt7915_dev *dev)
 	return 0;
 }
 
+static void mt7915_pci_init_hif2(struct mt7915_dev *dev)
+{
+	struct mt7915_hif *hif;
+
+	dev->hif_idx = ++hif_idx;
+	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7916, NULL))
+		return;
+
+	mt76_wr(dev, MT_PCIE_RECOG_ID, dev->hif_idx | MT_PCIE_RECOG_ID_SEM);
+
+	hif = mt7915_pci_get_hif2(dev);
+	if (!hif)
+		return;
+
+	dev->hif2 = hif;
+
+	mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+	if (devm_request_irq(dev->mt76.dev, hif->irq, mt7915_irq_handler,
+			     IRQF_SHARED, KBUILD_MODNAME "-hif", dev)) {
+		mt7915_put_hif2(hif);
+		hif = NULL;
+	}
+
+	/* master switch of PCIe tnterrupt enable */
+	mt7915_l1_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+}
+
+static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
+{
+	struct mt7915_hif *hif;
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
 static int mt7915_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -145,6 +261,9 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	if (id->device == 0x7916)
+		return mt7915_pci_hif2_probe(pdev);
+
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7915_ops,
 				 &drv_ops);
 	if (!mdev)
@@ -170,6 +289,8 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto error;
 
+	mt7915_pci_init_hif2(dev);
+
 	ret = mt7915_register_device(dev);
 	if (ret)
 		goto error;
@@ -181,24 +302,64 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	return ret;
 }
 
+static void mt7915_hif_remove(struct pci_dev *pdev)
+{
+	struct mt7915_hif *hif = pci_get_drvdata(pdev);
+
+	list_del(&hif->list);
+}
+
 static void mt7915_pci_remove(struct pci_dev *pdev)
 {
-	struct mt76_dev *mdev = pci_get_drvdata(pdev);
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	struct mt76_dev *mdev;
+	struct mt7915_dev *dev;
 
+	mdev = pci_get_drvdata(pdev);
+	dev = container_of(mdev, struct mt7915_dev, mt76);
+	mt7915_put_hif2(dev->hif2);
 	mt7915_unregister_device(dev);
 }
 
-struct pci_driver mt7915_pci_driver = {
+static struct pci_driver mt7915_hif_driver = {
+	.name		= KBUILD_MODNAME "_hif",
+	.id_table	= mt7915_hif_device_table,
+	.probe		= mt7915_pci_probe,
+	.remove		= mt7915_hif_remove,
+};
+
+static struct pci_driver mt7915_pci_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= mt7915_pci_device_table,
 	.probe		= mt7915_pci_probe,
 	.remove		= mt7915_pci_remove,
 };
 
-module_pci_driver(mt7915_pci_driver);
+static int __init mt7915_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&mt7915_hif_driver);
+	if (ret)
+		return ret;
+
+	ret = pci_register_driver(&mt7915_pci_driver);
+	if (ret)
+		pci_unregister_driver(&mt7915_hif_driver);
+
+	return ret;
+}
+
+static void __exit mt7915_exit(void)
+{
+    pci_unregister_driver(&mt7915_pci_driver);
+    pci_unregister_driver(&mt7915_hif_driver);
+}
+
+module_init(mt7915_init);
+module_exit(mt7915_exit);
 
 MODULE_DEVICE_TABLE(pci, mt7915_pci_device_table);
+MODULE_DEVICE_TABLE(pci, mt7915_hif_device_table);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WA);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7915_ROM_PATCH);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 77402eb13b9c..ed0c9a24bb53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -355,15 +355,29 @@
 #define MT_INT_TX_DONE_MCU_WM		BIT(27)
 #define MT_INT_TX_DONE_BAND0		BIT(30)
 #define MT_INT_TX_DONE_BAND1		BIT(31)
+
+#define MT_INT_BAND1_MASK		(MT_INT_RX_DONE_WA_EXT |	\
+					 MT_INT_TX_DONE_BAND1)
+
 #define MT_INT_MCU_CMD			BIT(29)
 
 #define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WA |	\
 					 MT_INT_TX_DONE_MCU_WM |	\
 					 MT_INT_TX_DONE_FWDL)
 
+#define MT_WFDMA_HOST_CONFIG		MT_WFDMA_EXT_CSR(0x30)
+#define MT_WFDMA_HOST_CONFIG_PDMA_BAND	BIT(0)
+
 #define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
 
+#define MT_INT1_SOURCE_CSR		MT_WFDMA_EXT_CSR(0x88)
+#define MT_INT1_MASK_CSR		MT_WFDMA_EXT_CSR(0x8c)
+
+#define MT_PCIE_RECOG_ID		MT_WFDMA_EXT_CSR(0x90)
+#define MT_PCIE_RECOG_ID_MASK		GENMASK(30, 0)
+#define MT_PCIE_RECOG_ID_SEM		BIT(31)
+
 /* WFDMA0 PCIE1 */
 #define MT_WFDMA0_PCIE1_BASE			0xd8000
 #define MT_WFDMA0_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
@@ -418,6 +432,10 @@
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
 
+#define MT_PCIE1_MAC_BASE		0x74020000
+#define MT_PCIE1_MAC(ofs)		(MT_PCIE1_MAC_BASE + (ofs))
+#define MT_PCIE1_MAC_INT_ENABLE		MT_PCIE1_MAC(0x188)
+
 #define MT_PCIE_MAC_BASE		0x74030000
 #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
 #define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
-- 
2.28.0

