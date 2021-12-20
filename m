Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFD47A38B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 03:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhLTCSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 21:18:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46188 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233055AbhLTCST (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 21:18:19 -0500
X-UUID: 93914c08d522462e969d665000470e13-20211220
X-UUID: 93914c08d522462e969d665000470e13-20211220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1641407423; Mon, 20 Dec 2021 10:18:15 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 20 Dec 2021 10:18:14 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Dec
 2021 10:18:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Dec 2021 10:18:11 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v4 04/12] mt76: mt7915: rework dma.c to adapt mt7916 changes
Date:   Mon, 20 Dec 2021 10:17:56 +0800
Message-ID: <0b4d69e017c4df5727dcf6a483d1b9cd8723925b.1639965732.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1639965732.git.Bo.Jiao@mediatek.com>
References: <cover.1639965732.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

The RXQ of mt7916 are separated to MT_RXQ_MAIN_WA and MT_RXQ_MCU_WA,
so, add initialization and preftech setting for the queue MT_RXQ_MAIN_WA.

This is an intermediate patch to add mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
v4:
- add wfpdma_mask/q_int_mask/q_id for rx/tx queues that indicates wpdma type,
  interrput bit and queue index. This will be used in queue allocation, prefetch
  configuration and interruput handler.
---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 317 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   9 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   4 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   4 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  21 +-
 6 files changed, 259 insertions(+), 99 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 74377b8..4106d73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -59,6 +59,7 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA1, MT_INT_RX_DONE_WA, MT7915_RXQ_MCU_WA);
 		RXQ_CONFIG(MT_RXQ_EXT, WFDMA0, MT_INT_RX_DONE_BAND1, MT7915_RXQ_BAND1);
 		RXQ_CONFIG(MT_RXQ_EXT_WA, WFDMA1, MT_INT_RX_DONE_WA_EXT, MT7915_RXQ_MCU_WA_EXT);
+		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA1, MT_INT_RX_DONE_WA_MAIN, MT7915_RXQ_MCU_WA);
 		TXQ_CONFIG(0, WFDMA1, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
 		TXQ_CONFIG(1, WFDMA1, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
 		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA1, MT_INT_TX_DONE_MCU_WM, MT7915_TXQ_MCU_WM);
@@ -70,6 +71,7 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7916_RXQ_MCU_WA);
 		RXQ_CONFIG(MT_RXQ_EXT, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916, MT7916_RXQ_BAND1);
 		RXQ_CONFIG(MT_RXQ_EXT_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT_MT7916, MT7916_RXQ_MCU_WA_EXT);
+		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN_MT7916, MT7916_RXQ_MCU_WA_MAIN);
 		TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
 		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
 		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7915_TXQ_MCU_WM);
@@ -81,6 +83,7 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
 {
 #define PREFETCH(_base, _depth)	((_base) << 16 | (_depth))
+	u32 base;
 
 	/* prefetch SRAM wrapping boundary for tx/rx ring. */
 	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(0x0, 0x4));
@@ -91,9 +94,13 @@ static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
 
 	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x140, 0x4));
 	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x180, 0x4));
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x1c0, 0x4));
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x200, 0x4));
-	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x240, 0x4));
+	if (!is_mt7915(&dev->mt76)) {
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x1c0, 0x4));
+		base = 0x40;
+	}
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x1c0 + base, 0x4));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x200 + base, 0x4));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x240 + base, 0x4));
 
 	/* for mt7915, the ring which is next the last
 	 * used ring must be initialized.
@@ -101,8 +108,8 @@ static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
 	if (is_mt7915(&dev->mt76)) {
 		ofs += 0x4;
 		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x140, 0x0));
-		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x200, 0x0));
-		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x280, 0x0));
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x200 + base, 0x0));
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x280 + base, 0x0));
 	}
 }
 
@@ -113,45 +120,221 @@ void mt7915_dma_prefetch(struct mt7915_dev *dev)
 		__mt7915_dma_prefetch(dev, MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0));
 }
 
-int mt7915_dma_init(struct mt7915_dev *dev)
+static void mt7915_dma_disable(struct mt7915_dev *dev, bool rst)
 {
+	struct mt76_dev *mdev = &dev->mt76;
 	u32 hif1_ofs = 0;
-	int ret;
 
-	mt7915_dma_config(dev);
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 
-	mt76_dma_attach(&dev->mt76);
+	/* reset */
+	if (rst) {
+		mt76_clear(dev, MT_WFDMA0_RST,
+			   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			   MT_WFDMA0_RST_LOGIC_RST);
+
+		mt76_set(dev, MT_WFDMA0_RST,
+			 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			 MT_WFDMA0_RST_LOGIC_RST);
+
+		if (is_mt7915(mdev)) {
+			mt76_clear(dev, MT_WFDMA1_RST,
+				   MT_WFDMA1_RST_DMASHDL_ALL_RST |
+				   MT_WFDMA1_RST_LOGIC_RST);
+
+			mt76_set(dev, MT_WFDMA1_RST,
+				 MT_WFDMA1_RST_DMASHDL_ALL_RST |
+				 MT_WFDMA1_RST_LOGIC_RST);
+		}
+
+		if (dev->hif2) {
+			mt76_clear(dev, MT_WFDMA0_RST + hif1_ofs,
+				   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+				   MT_WFDMA0_RST_LOGIC_RST);
+
+			mt76_set(dev, MT_WFDMA0_RST + hif1_ofs,
+				 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+				 MT_WFDMA0_RST_LOGIC_RST);
+
+			if (is_mt7915(mdev)) {
+				mt76_clear(dev, MT_WFDMA1_RST + hif1_ofs,
+					   MT_WFDMA1_RST_DMASHDL_ALL_RST |
+					   MT_WFDMA1_RST_LOGIC_RST);
+
+				mt76_set(dev, MT_WFDMA1_RST + hif1_ofs,
+					 MT_WFDMA1_RST_DMASHDL_ALL_RST |
+					 MT_WFDMA1_RST_LOGIC_RST);
+			}
+		}
+	}
+
+	/* disable */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (is_mt7915(mdev))
+		mt76_clear(dev, MT_WFDMA1_GLO_CFG,
+			   MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+			   MT_WFDMA1_GLO_CFG_RX_DMA_EN |
+			   MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+			   MT_WFDMA1_GLO_CFG_OMIT_RX_INFO |
+			   MT_WFDMA1_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (dev->hif2) {
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+			   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+		if (is_mt7915(mdev))
+			mt76_clear(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+				   MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+				   MT_WFDMA1_GLO_CFG_RX_DMA_EN |
+				   MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+				   MT_WFDMA1_GLO_CFG_OMIT_RX_INFO |
+				   MT_WFDMA1_GLO_CFG_OMIT_RX_INFO_PFET2);
+	}
+}
+
+static int mt7915_dma_enable(struct mt7915_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 hif1_ofs = 0;
+	u32 irq_mask;
 
 	if (dev->hif2)
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 
-	/* configure global setting */
-	mt76_set(dev, MT_WFDMA1_GLO_CFG,
-		 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
-		 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
-
 	/* reset dma idx */
 	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
-	mt76_wr(dev, MT_WFDMA1_RST_DTX_PTR, ~0);
+	if (is_mt7915(mdev))
+		mt76_wr(dev, MT_WFDMA1_RST_DTX_PTR, ~0);
+	if (dev->hif2) {
+		mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR + hif1_ofs, ~0);
+		if (is_mt7915(mdev))
+			mt76_wr(dev, MT_WFDMA1_RST_DTX_PTR + hif1_ofs, ~0);
+	}
 
-	/* configure delay interrupt */
+	/* configure delay interrupt off */
 	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
-	mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0, 0);
+	if (is_mt7915(mdev)) {
+		mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0, 0);
+	} else {
+		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG1, 0);
+		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG2, 0);
+	}
 
 	if (dev->hif2) {
-		mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0 + hif1_ofs, 0);
+		if (is_mt7915(mdev)) {
+			mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0 +
+				hif1_ofs, 0);
+		} else {
+			mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG1 +
+				hif1_ofs, 0);
+			mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG2 +
+				hif1_ofs, 0);
+		}
+	}
+
+	/* configure perfetch settings */
+	mt7915_dma_prefetch(dev);
+
+	/* hif wait WFDMA idle */
+	mt76_set(dev, MT_WFDMA0_BUSY_ENA,
+		 MT_WFDMA0_BUSY_ENA_TX_FIFO0 |
+		 MT_WFDMA0_BUSY_ENA_TX_FIFO1 |
+		 MT_WFDMA0_BUSY_ENA_RX_FIFO);
+
+	if (is_mt7915(mdev))
+		mt76_set(dev, MT_WFDMA1_BUSY_ENA,
+			 MT_WFDMA1_BUSY_ENA_TX_FIFO0 |
+			 MT_WFDMA1_BUSY_ENA_TX_FIFO1 |
+			 MT_WFDMA1_BUSY_ENA_RX_FIFO);
+
+	if (dev->hif2) {
+		mt76_set(dev, MT_WFDMA0_BUSY_ENA + hif1_ofs,
+			 MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0 |
+			 MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1 |
+			 MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO);
+
+		if (is_mt7915(mdev))
+			mt76_set(dev, MT_WFDMA1_BUSY_ENA + hif1_ofs,
+				 MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO0 |
+				 MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO1 |
+				 MT_WFDMA1_PCIE1_BUSY_ENA_RX_FIFO);
+	}
+
+	mt76_poll(dev, MT_WFDMA_EXT_CSR_HIF_MISC,
+		  MT_WFDMA_EXT_CSR_HIF_MISC_BUSY, 0, 1000);
+
+	/* set WFDMA Tx/Rx */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (is_mt7915(mdev))
+		mt76_set(dev, MT_WFDMA1_GLO_CFG,
+			 MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA1_GLO_CFG_RX_DMA_EN |
 			 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
 			 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
 
-		mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR + hif1_ofs, ~0);
-		mt76_wr(dev, MT_WFDMA1_RST_DTX_PTR + hif1_ofs, ~0);
+	if (dev->hif2) {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+		if (is_mt7915(mdev))
+			mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+				 MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+				 MT_WFDMA1_GLO_CFG_RX_DMA_EN |
+				 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+				 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
 
-		mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0 + hif1_ofs, 0);
-		mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0 + hif1_ofs, 0);
+		mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+			 MT_WFDMA_HOST_CONFIG_PDMA_BAND);
 	}
 
-	/* configure perfetch settings */
-	mt7915_dma_prefetch(dev);
+	/* enable interrupts for TX/RX rings */
+	irq_mask = MT_INT_RX_DONE_MCU |
+		   MT_INT_TX_DONE_MCU |
+		   MT_INT_MCU_CMD |
+		   MT_INT_BAND0_RX_DONE;
+
+	if (dev->dbdc_support)
+		irq_mask |= MT_INT_BAND1_RX_DONE;
+
+	mt7915_irq_enable(dev, irq_mask);
+
+	return 0;
+}
+
+int mt7915_dma_init(struct mt7915_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 hif1_ofs = 0;
+	int ret;
+
+	mt7915_dma_config(dev);
+
+	mt76_dma_attach(&dev->mt76);
+
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	mt7915_dma_disable(dev, true);
 
 	/* init tx queue */
 	ret = mt7915_init_tx_queues(&dev->phy,
@@ -203,7 +386,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	/* rx data queue */
+	/* rx data queue for band0 */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
 			       MT_RXQ_ID(MT_RXQ_MAIN),
 			       MT7915_RX_RING_SIZE,
@@ -212,7 +395,19 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	/* tx free notify event from WA for band0 */
+	if (!is_mt7915(mdev)) {
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN_WA],
+				       MT_RXQ_ID(MT_RXQ_MAIN_WA),
+				       MT7915_RX_MCU_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA));
+		if (ret)
+			return ret;
+	}
+
 	if (dev->dbdc_support) {
+		/* rx data queue for band1 */
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT],
 				       MT_RXQ_ID(MT_RXQ_EXT),
 				       MT7915_RX_RING_SIZE,
@@ -221,7 +416,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		if (ret)
 			return ret;
 
-		/* event from WA */
+		/* tx free notify event from WA for band1 */
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT_WA],
 				       MT_RXQ_ID(MT_RXQ_EXT_WA),
 				       MT7915_RX_MCU_RING_SIZE,
@@ -239,80 +434,14 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 			  mt7915_poll_tx, NAPI_POLL_WEIGHT);
 	napi_enable(&dev->mt76.tx_napi);
 
-	/* hif wait WFDMA idle */
-	mt76_set(dev, MT_WFDMA0_BUSY_ENA,
-		 MT_WFDMA0_BUSY_ENA_TX_FIFO0 |
-		 MT_WFDMA0_BUSY_ENA_TX_FIFO1 |
-		 MT_WFDMA0_BUSY_ENA_RX_FIFO);
-
-	mt76_set(dev, MT_WFDMA1_BUSY_ENA,
-		 MT_WFDMA1_BUSY_ENA_TX_FIFO0 |
-		 MT_WFDMA1_BUSY_ENA_TX_FIFO1 |
-		 MT_WFDMA1_BUSY_ENA_RX_FIFO);
-
-	mt76_set(dev, MT_WFDMA0_PCIE1_BUSY_ENA,
-		 MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0 |
-		 MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1 |
-		 MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO);
-
-	mt76_set(dev, MT_WFDMA1_PCIE1_BUSY_ENA,
-		 MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO0 |
-		 MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO1 |
-		 MT_WFDMA1_PCIE1_BUSY_ENA_RX_FIFO);
-
-	mt76_poll(dev, MT_WFDMA_EXT_CSR_HIF_MISC,
-		  MT_WFDMA_EXT_CSR_HIF_MISC_BUSY, 0, 1000);
-
-	/* set WFDMA Tx/Rx */
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-	mt76_set(dev, MT_WFDMA1_GLO_CFG,
-		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
-
-	if (dev->hif2) {
-		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-			 (MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			  MT_WFDMA0_GLO_CFG_RX_DMA_EN));
-		mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
-			 (MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-			  MT_WFDMA1_GLO_CFG_RX_DMA_EN));
-		mt76_set(dev, MT_WFDMA_HOST_CONFIG,
-			 MT_WFDMA_HOST_CONFIG_PDMA_BAND);
-	}
-
-	/* enable interrupts for TX/RX rings */
-	mt7915_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_MCU |
-			  MT_INT_MCU_CMD);
+	mt7915_dma_enable(dev);
 
 	return 0;
 }
 
 void mt7915_dma_cleanup(struct mt7915_dev *dev)
 {
-	/* disable */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-	mt76_clear(dev, MT_WFDMA1_GLO_CFG,
-		   MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA1_GLO_CFG_RX_DMA_EN);
-
-	/* reset */
-	mt76_clear(dev, MT_WFDMA1_RST,
-		   MT_WFDMA1_RST_DMASHDL_ALL_RST |
-		   MT_WFDMA1_RST_LOGIC_RST);
-
-	mt76_set(dev, MT_WFDMA1_RST,
-		 MT_WFDMA1_RST_DMASHDL_ALL_RST |
-		 MT_WFDMA1_RST_LOGIC_RST);
-
-	mt76_clear(dev, MT_WFDMA0_RST,
-		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		   MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_set(dev, MT_WFDMA0_RST,
-		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		 MT_WFDMA0_RST_LOGIC_RST);
+	mt7915_dma_disable(dev, true);
 
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5aa3117..2da342d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -397,8 +397,15 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 static void mt7915_mac_init(struct mt7915_dev *dev)
 {
 	int i;
+	u32 rx_len = is_mt7915(&dev->mt76) ? 0x400 : 0x680;
+
+	/* config pse qid6 wfdma port selection */
+	if (!is_mt7915(&dev->mt76) && dev->hif2)
+		mt76_rmw(dev, MT_WF_PP_TOP_RXQ_WFDMA_CF_5, 0,
+			 MT_WF_PP_TOP_RXQ_QID6_WFDMA_HIF_SEL_MASK);
+
+	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, rx_len);
 
-	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 0x400);
 	/* enable hardware de-agg */
 	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b44b2b2..80db7b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -801,6 +801,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
+	/* drop no data frame */
+	if (fc & cpu_to_le16(IEEE80211_STYPE_NULLFUNC))
+		return -EINVAL;
+
 	status->aggr = unicast &&
 		       !ieee80211_is_qos_nullfunc(fc);
 	status->qos_ctl = qos_ctl;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index de25cd9..dfc975e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -486,6 +486,10 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 	if (intr & MT_INT_RX(MT_RXQ_MCU_WA))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
 
+	if (!is_mt7915(&dev->mt76) &&
+	    (intr & MT_INT_RX(MT_RXQ_MAIN_WA)))
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN_WA]);
+
 	if (intr & MT_INT_RX(MT_RXQ_EXT_WA))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT_WA]);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 778f405..673c2d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -72,7 +72,8 @@ enum mt7915_rxq_id {
 enum mt7916_rxq_id {
 	MT7916_RXQ_MCU_WM = 0,
 	MT7916_RXQ_MCU_WA,
-	MT7916_RXQ_MCU_WA_EXT = 3,
+	MT7916_RXQ_MCU_WA_MAIN,
+	MT7916_RXQ_MCU_WA_EXT,
 	MT7916_RXQ_BAND0,
 	MT7916_RXQ_BAND1,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 372b7f6..a8e864a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -510,9 +510,14 @@ enum offs_rev {
 #define MT_WFDMA0_GLO_CFG		MT_WFDMA0(0x208)
 #define MT_WFDMA0_GLO_CFG_TX_DMA_EN	BIT(0)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
 
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
 #define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
+#define MT_WFDMA0_PRI_DLY_INT_CFG1	MT_WFDMA0(0x2f4)
+#define MT_WFDMA0_PRI_DLY_INT_CFG2	MT_WFDMA0(0x2f8)
 
 /* WFDMA1 */
 #define MT_WFDMA1_BASE			0xd5000
@@ -532,6 +537,7 @@ enum offs_rev {
 #define MT_WFDMA1_GLO_CFG_RX_DMA_EN	BIT(2)
 #define MT_WFDMA1_GLO_CFG_OMIT_TX_INFO	BIT(28)
 #define MT_WFDMA1_GLO_CFG_OMIT_RX_INFO	BIT(27)
+#define MT_WFDMA1_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
 
 #define MT_WFDMA1_RST_DTX_PTR		MT_WFDMA1(0x20c)
 #define MT_WFDMA1_PRI_DLY_INT_CFG0	MT_WFDMA1(0x2f0)
@@ -601,10 +607,12 @@ enum offs_rev {
 #define MT_INT_RX_DONE_BAND1		BIT(17)
 #define MT_INT_RX_DONE_WM		BIT(0)
 #define MT_INT_RX_DONE_WA		BIT(1)
+#define MT_INT_RX_DONE_WA_MAIN		BIT(1)
 #define MT_INT_RX_DONE_WA_EXT		BIT(2)
 #define MT_INT_MCU_CMD			BIT(29)
 #define MT_INT_RX_DONE_BAND0_MT7916	BIT(22)
 #define MT_INT_RX_DONE_BAND1_MT7916	BIT(23)
+#define MT_INT_RX_DONE_WA_MAIN_MT7916	BIT(2)
 #define MT_INT_RX_DONE_WA_EXT_MT7916	BIT(3)
 
 #define MT_INT_RX(q)			(dev->q_int_mask[__RXQ(q)])
@@ -614,11 +622,11 @@ enum offs_rev {
 					 MT_INT_RX(MT_RXQ_MCU_WA))
 
 #define MT_INT_BAND0_RX_DONE		(MT_INT_RX(MT_RXQ_MAIN) |	\
-					 MT_INT_RX(MT_RXQ_MCU_WA))
+					 MT_INT_RX(MT_RXQ_MAIN_WA))
 
 #define MT_INT_BAND1_RX_DONE		(MT_INT_RX(MT_RXQ_EXT) |	\
-					 MT_INT_RX(MT_RXQ_MCU_WA) |	\
-					 MT_INT_RX(MT_RXQ_EXT_WA))
+					 MT_INT_RX(MT_RXQ_EXT_WA) |	\
+					 MT_INT_RX(MT_RXQ_MAIN_WA))
 
 #define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_MCU |		\
 					 MT_INT_BAND0_RX_DONE |		\
@@ -741,6 +749,13 @@ enum offs_rev {
 #define MT_PCIE1_MAC_INT_ENABLE		0x74020188
 #define MT_PCIE1_MAC_INT_ENABLE_MT7916	0x74090188
 
+/* PP TOP */
+#define MT_WF_PP_TOP_BASE		0x820cc000
+#define MT_WF_PP_TOP(ofs)		(MT_WF_PP_TOP_BASE + (ofs))
+
+#define MT_WF_PP_TOP_RXQ_WFDMA_CF_5	MT_WF_PP_TOP(0x0e8)
+#define MT_WF_PP_TOP_RXQ_QID6_WFDMA_HIF_SEL_MASK	BIT(6)
+
 #define MT_WF_IRPI_BASE			0x83006000
 #define MT_WF_IRPI(ofs)			(MT_WF_IRPI_BASE + ((ofs) << 16))
 
-- 
2.18.0

