Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CF47A38D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 03:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhLTCSX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 21:18:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46150 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237194AbhLTCSU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 21:18:20 -0500
X-UUID: 621c900875024e168dc83d9a03590e86-20211220
X-UUID: 621c900875024e168dc83d9a03590e86-20211220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 258923389; Mon, 20 Dec 2021 10:18:15 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 20 Dec 2021 10:18:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Dec
 2021 10:18:10 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Dec 2021 10:18:10 +0800
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
Subject: [PATCH v4 02/12] mt76: mt7915: refine register definition
Date:   Mon, 20 Dec 2021 10:17:54 +0800
Message-ID: <2fc932d269353243f0ddf0deaab40ff443db8a72.1639965732.git.Bo.Jiao@mediatek.com>
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

Add mt7915_reg_desc to differentiate chip generations.
This is an intermediate patch to introduce mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
v4:
- remove the mask/bit array and open-code the differences
  in the relevant functions.
- delete the register base array and open-code the differences.
- split {base, reg} tuple array into register and offset array.
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  20 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 149 +++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  10 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 108 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  24 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 404 ++++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  25 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 561 +++++++++++-------
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  59 +-
 9 files changed, 950 insertions(+), 410 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index e96d1c3..710f8ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -521,14 +521,14 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 DEFINE_SHOW_ATTRIBUTE(mt7915_tx_stats);
 
 static void
-mt7915_hw_queue_read(struct seq_file *s, u32 base, u32 size,
+mt7915_hw_queue_read(struct seq_file *s, u32 size,
 		     const struct hw_queue_map *map)
 {
 	struct mt7915_phy *phy = s->private;
 	struct mt7915_dev *dev = phy->dev;
 	u32 i, val;
 
-	val = mt76_rr(dev, base + MT_FL_Q_EMPTY);
+	val = mt76_rr(dev, MT_FL_Q_EMPTY);
 	for (i = 0; i < size; i++) {
 		u32 ctrl, head, tail, queued;
 
@@ -536,13 +536,13 @@ mt7915_hw_queue_read(struct seq_file *s, u32 base, u32 size,
 			continue;
 
 		ctrl = BIT(31) | (map[i].pid << 10) | (map[i].qid << 24);
-		mt76_wr(dev, base + MT_FL_Q0_CTRL, ctrl);
+		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl);
 
-		head = mt76_get_field(dev, base + MT_FL_Q2_CTRL,
+		head = mt76_get_field(dev, MT_FL_Q2_CTRL,
 				      GENMASK(11, 0));
-		tail = mt76_get_field(dev, base + MT_FL_Q2_CTRL,
+		tail = mt76_get_field(dev, MT_FL_Q2_CTRL,
 				      GENMASK(27, 16));
-		queued = mt76_get_field(dev, base + MT_FL_Q3_CTRL,
+		queued = mt76_get_field(dev, MT_FL_Q3_CTRL,
 					GENMASK(11, 0));
 
 		seq_printf(s, "\t%s: ", map[i].name);
@@ -570,8 +570,8 @@ mt7915_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 		if (val & BIT(offs))
 			continue;
 
-		mt76_wr(dev, MT_PLE_BASE + MT_FL_Q0_CTRL, ctrl | msta->wcid.idx);
-		qlen = mt76_get_field(dev, MT_PLE_BASE + MT_FL_Q3_CTRL,
+		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl | msta->wcid.idx);
+		qlen = mt76_get_field(dev, MT_FL_Q3_CTRL,
 				      GENMASK(11, 0));
 		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
 			   sta->addr, msta->wcid.idx,
@@ -633,7 +633,7 @@ mt7915_hw_queues_show(struct seq_file *file, void *data)
 		   val, head, tail);
 
 	seq_puts(file, "PLE non-empty queue info:\n");
-	mt7915_hw_queue_read(file, MT_PLE_BASE, ARRAY_SIZE(ple_queue_map),
+	mt7915_hw_queue_read(file, ARRAY_SIZE(ple_queue_map),
 			     &ple_queue_map[0]);
 
 	/* iterate per-sta ple queue */
@@ -641,7 +641,7 @@ mt7915_hw_queues_show(struct seq_file *file, void *data)
 					  mt7915_sta_hw_queue_read, file);
 	/* pse queue */
 	seq_puts(file, "PSE non-empty queue info:\n");
-	mt7915_hw_queue_read(file, MT_PSE_BASE, ARRAY_SIZE(pse_queue_map),
+	mt7915_hw_queue_read(file, ARRAY_SIZE(pse_queue_map),
 			     &pse_queue_map[0]);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 9182568..74377b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -5,11 +5,11 @@
 #include "../dma.h"
 #include "mac.h"
 
-int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc)
+int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base)
 {
 	int i, err;
 
-	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, MT_TX_RING_BASE);
+	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, ring_base);
 	if (err < 0)
 		return err;
 
@@ -40,41 +40,77 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
 	return 0;
 }
 
+static void mt7915_dma_config(struct mt7915_dev *dev)
+{
+#define Q_CONFIG(q, wfdma, int, id) do {		\
+		if (wfdma)				\
+			dev->wfdma_mask |= (1 << (q));	\
+		dev->q_int_mask[(q)] = int;		\
+		dev->q_id[(q)] = id;			\
+	} while (0)
+
+#define MCUQ_CONFIG(q, wfdma, int, id)	Q_CONFIG(q, (wfdma), (int), (id))
+#define RXQ_CONFIG(q, wfdma, int, id)	Q_CONFIG(__RXQ(q), (wfdma), (int), (id))
+#define TXQ_CONFIG(q, wfdma, int, id)	Q_CONFIG(__TXQ(q), (wfdma), (int), (id))
+
+	if (is_mt7915(&dev->mt76)) {
+		RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0, MT7915_RXQ_BAND0);
+		RXQ_CONFIG(MT_RXQ_MCU, WFDMA1, MT_INT_RX_DONE_WM, MT7915_RXQ_MCU_WM);
+		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA1, MT_INT_RX_DONE_WA, MT7915_RXQ_MCU_WA);
+		RXQ_CONFIG(MT_RXQ_EXT, WFDMA0, MT_INT_RX_DONE_BAND1, MT7915_RXQ_BAND1);
+		RXQ_CONFIG(MT_RXQ_EXT_WA, WFDMA1, MT_INT_RX_DONE_WA_EXT, MT7915_RXQ_MCU_WA_EXT);
+		TXQ_CONFIG(0, WFDMA1, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
+		TXQ_CONFIG(1, WFDMA1, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
+		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA1, MT_INT_TX_DONE_MCU_WM, MT7915_TXQ_MCU_WM);
+		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA1, MT_INT_TX_DONE_MCU_WA, MT7915_TXQ_MCU_WA);
+		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA1, MT_INT_TX_DONE_FWDL, MT7915_TXQ_FWDL);
+	} else {
+		RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0_MT7916, MT7916_RXQ_BAND0);
+		RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM, MT7916_RXQ_MCU_WM);
+		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7916_RXQ_MCU_WA);
+		RXQ_CONFIG(MT_RXQ_EXT, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916, MT7916_RXQ_BAND1);
+		RXQ_CONFIG(MT_RXQ_EXT_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT_MT7916, MT7916_RXQ_MCU_WA_EXT);
+		TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
+		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
+		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7915_TXQ_MCU_WM);
+		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA0, MT_INT_TX_DONE_MCU_WA_MT7916, MT7915_TXQ_MCU_WA);
+		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA0, MT_INT_TX_DONE_FWDL, MT7915_TXQ_FWDL);
+	}
+}
+
 static void __mt7915_dma_prefetch(struct mt7915_dev *dev, u32 ofs)
 {
-#define PREFETCH(base, depth)	((base) << 16 | (depth))
-
-	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL + ofs, PREFETCH(0x0, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL + ofs, PREFETCH(0x40, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL + ofs, PREFETCH(0x80, 0x0));
-
-	mt76_wr(dev, MT_WFDMA1_TX_RING0_EXT_CTRL + ofs, PREFETCH(0x80, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING1_EXT_CTRL + ofs, PREFETCH(0xc0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING2_EXT_CTRL + ofs, PREFETCH(0x100, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING3_EXT_CTRL + ofs, PREFETCH(0x140, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING4_EXT_CTRL + ofs, PREFETCH(0x180, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING5_EXT_CTRL + ofs, PREFETCH(0x1c0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING6_EXT_CTRL + ofs, PREFETCH(0x200, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING7_EXT_CTRL + ofs, PREFETCH(0x240, 0x4));
-
-	mt76_wr(dev, MT_WFDMA1_TX_RING16_EXT_CTRL + ofs, PREFETCH(0x280, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING17_EXT_CTRL + ofs, PREFETCH(0x2c0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING18_EXT_CTRL + ofs, PREFETCH(0x300, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING19_EXT_CTRL + ofs, PREFETCH(0x340, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING20_EXT_CTRL + ofs, PREFETCH(0x380, 0x4));
-	mt76_wr(dev, MT_WFDMA1_TX_RING21_EXT_CTRL + ofs, PREFETCH(0x3c0, 0x0));
-
-	mt76_wr(dev, MT_WFDMA1_RX_RING0_EXT_CTRL + ofs, PREFETCH(0x3c0, 0x4));
-	mt76_wr(dev, MT_WFDMA1_RX_RING1_EXT_CTRL + ofs, PREFETCH(0x400, 0x4));
-	mt76_wr(dev, MT_WFDMA1_RX_RING2_EXT_CTRL + ofs, PREFETCH(0x440, 0x4));
-	mt76_wr(dev, MT_WFDMA1_RX_RING3_EXT_CTRL + ofs, PREFETCH(0x480, 0x0));
+#define PREFETCH(_base, _depth)	((_base) << 16 | (_depth))
+
+	/* prefetch SRAM wrapping boundary for tx/rx ring. */
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(0x0, 0x4));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WM) + ofs, PREFETCH(0x40, 0x4));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(0) + ofs, PREFETCH(0x80, 0x4));
+	mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0xc0, 0x4));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x100, 0x4));
+
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x140, 0x4));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x180, 0x4));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x1c0, 0x4));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x200, 0x4));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x240, 0x4));
+
+	/* for mt7915, the ring which is next the last
+	 * used ring must be initialized.
+	 */
+	if (is_mt7915(&dev->mt76)) {
+		ofs += 0x4;
+		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x140, 0x0));
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT_WA) + ofs, PREFETCH(0x200, 0x0));
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_EXT) + ofs, PREFETCH(0x280, 0x0));
+	}
 }
 
 void mt7915_dma_prefetch(struct mt7915_dev *dev)
 {
 	__mt7915_dma_prefetch(dev, 0);
 	if (dev->hif2)
-		__mt7915_dma_prefetch(dev, MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE);
+		__mt7915_dma_prefetch(dev, MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0));
 }
 
 int mt7915_dma_init(struct mt7915_dev *dev)
@@ -82,10 +118,12 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	u32 hif1_ofs = 0;
 	int ret;
 
+	mt7915_dma_config(dev);
+
 	mt76_dma_attach(&dev->mt76);
 
 	if (dev->hif2)
-		hif1_ofs = MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE;
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 
 	/* configure global setting */
 	mt76_set(dev, MT_WFDMA1_GLO_CFG,
@@ -116,64 +154,79 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	mt7915_dma_prefetch(dev);
 
 	/* init tx queue */
-	ret = mt7915_init_tx_queues(&dev->phy, MT7915_TXQ_BAND0,
-				    MT7915_TX_RING_SIZE);
+	ret = mt7915_init_tx_queues(&dev->phy,
+				    MT_TXQ_ID(0),
+				    MT7915_TX_RING_SIZE,
+				    MT_TXQ_RING_BASE(0));
 	if (ret)
 		return ret;
 
 	/* command to WM */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7915_TXQ_MCU_WM,
-				  MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM,
+				  MT_MCUQ_ID(MT_MCUQ_WM),
+				  MT7915_TX_MCU_RING_SIZE,
+				  MT_MCUQ_RING_BASE(MT_MCUQ_WM));
 	if (ret)
 		return ret;
 
 	/* command to WA */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WA, MT7915_TXQ_MCU_WA,
-				  MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WA,
+				  MT_MCUQ_ID(MT_MCUQ_WA),
+				  MT7915_TX_MCU_RING_SIZE,
+				  MT_MCUQ_RING_BASE(MT_MCUQ_WA));
 	if (ret)
 		return ret;
 
 	/* firmware download */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7915_TXQ_FWDL,
-				  MT7915_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL,
+				  MT_MCUQ_ID(MT_MCUQ_FWDL),
+				  MT7915_TX_FWDL_RING_SIZE,
+				  MT_MCUQ_RING_BASE(MT_MCUQ_FWDL));
 	if (ret)
 		return ret;
 
 	/* event from WM */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
-			       MT7915_RXQ_MCU_WM, MT7915_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
+			       MT_RXQ_ID(MT_RXQ_MCU),
+			       MT7915_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MCU));
 	if (ret)
 		return ret;
 
 	/* event from WA */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
-			       MT7915_RXQ_MCU_WA, MT7915_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
+			       MT_RXQ_ID(MT_RXQ_MCU_WA),
+			       MT7915_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MCU_WA));
 	if (ret)
 		return ret;
 
 	/* rx data queue */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
-			       MT7915_RXQ_BAND0, MT7915_RX_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
+			       MT_RXQ_ID(MT_RXQ_MAIN),
+			       MT7915_RX_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RXQ_RING_BASE(MT_RXQ_MAIN));
 	if (ret)
 		return ret;
 
 	if (dev->dbdc_support) {
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT],
-				       MT7915_RXQ_BAND1, MT7915_RX_RING_SIZE,
+				       MT_RXQ_ID(MT_RXQ_EXT),
+				       MT7915_RX_RING_SIZE,
 				       MT_RX_BUF_SIZE,
-				       MT_RX_DATA_RING_BASE + hif1_ofs);
+				       MT_RXQ_RING_BASE(MT_RXQ_EXT) + hif1_ofs);
 		if (ret)
 			return ret;
 
 		/* event from WA */
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT_WA],
-				       MT7915_RXQ_MCU_WA_EXT,
+				       MT_RXQ_ID(MT_RXQ_EXT_WA),
 				       MT7915_RX_MCU_RING_SIZE,
 				       MT_RX_BUF_SIZE,
-				       MT_RX_EVENT_RING_BASE + hif1_ofs);
+				       MT_RXQ_RING_BASE(MT_RXQ_EXT_WA) + hif1_ofs);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 4b56358..5aa3117 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -464,8 +464,9 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	       ETH_ALEN);
 	mt76_eeprom_override(mphy);
 
-	ret = mt7915_init_tx_queues(phy, MT7915_TXQ_BAND1,
-				    MT7915_TX_RING_SIZE);
+	ret = mt7915_init_tx_queues(phy, MT_TXQ_ID(1),
+				    MT7915_TX_RING_SIZE,
+				    MT_TXQ_RING_BASE(1));
 	if (ret)
 		goto error;
 
@@ -564,7 +565,10 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	 * force firmware operation mode into normal state,
 	 * which should be set before firmware download stage.
 	 */
-	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+	if (is_mt7915(&dev->mt76))
+		mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+	else
+		mt76_wr(dev, MT_SWDEF_MODE_MT7916, MT_SWDEF_NORMAL_MODE);
 
 	ret = mt7915_mcu_init(dev);
 	if (ret) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 48f1155..b44b2b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1891,7 +1891,7 @@ static void
 mt7915_dma_reset(struct mt7915_dev *dev)
 {
 	struct mt76_phy *mphy_ext = dev->mt76.phy2;
-	u32 hif1_ofs = MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE;
+	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 	int i;
 
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
@@ -2052,9 +2052,11 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	struct mib_stats *mib = &phy->mib;
 	bool ext_phy = phy != &dev->phy;
 	int i, aggr0, aggr1, cnt;
+	u32 val;
 
-	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
-					   MT_MIB_SDR3_FCS_ERR_MASK);
+	cnt = mt76_rr(dev, MT_MIB_SDR3(ext_phy));
+	mib->fcs_err_cnt += is_mt7915(&dev->mt76) ? FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR4(ext_phy));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
@@ -2081,10 +2083,14 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->tx_stop_q_empty_cnt += FIELD_GET(MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR14(ext_phy));
-	mib->tx_mpdu_attempts_cnt += FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK, cnt);
+	mib->tx_mpdu_attempts_cnt += is_mt7915(&dev->mt76) ?
+		FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK_MT7916, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR15(ext_phy));
-	mib->tx_mpdu_success_cnt += FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK, cnt);
+	mib->tx_mpdu_success_cnt += is_mt7915(&dev->mt76) ?
+		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK_MT7916, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR22(ext_phy));
 	mib->rx_ampdu_cnt += cnt;
@@ -2093,7 +2099,9 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->rx_ampdu_bytes_cnt += cnt;
 
 	cnt = mt76_rr(dev, MT_MIB_SDR24(ext_phy));
-	mib->rx_ampdu_valid_subframe_cnt += FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK, cnt);
+	mib->rx_ampdu_valid_subframe_cnt += is_mt7915(&dev->mt76) ?
+		FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK_MT7916, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR25(ext_phy));
 	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
@@ -2105,11 +2113,14 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->tx_rwp_need_cnt += FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR29(ext_phy));
-	mib->rx_pfdrop_cnt += FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK, cnt);
+	mib->rx_pfdrop_cnt += is_mt7915(&dev->mt76) ?
+		FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR30(ext_phy));
-	mib->rx_vec_queue_overflow_drop_cnt +=
-		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK, cnt);
+	cnt = mt76_rr(dev, MT_MIB_SDRVEC(ext_phy));
+	mib->rx_vec_queue_overflow_drop_cnt += is_mt7915(&dev->mt76) ?
+		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK_MT7916, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR31(ext_phy));
 	mib->rx_ba_cnt += cnt;
@@ -2117,10 +2128,13 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	cnt = mt76_rr(dev, MT_MIB_SDR32(ext_phy));
 	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
-	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK, cnt);
+	if (is_mt7915(&dev->mt76))
+		cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
+	mib->tx_pkt_ibf_cnt += is_mt7915(&dev->mt76) ?
+		       FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK, cnt) :
+		       FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDRMUBF(ext_phy));
 	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
@@ -2158,26 +2172,54 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	}
 
 	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
-	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
-		u32 val;
-
-		val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, i));
-		mib->ba_miss_cnt += FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
-		mib->ack_fail_cnt +=
-			FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
-
-		val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, i));
-		mib->rts_cnt += FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
-		mib->rts_retries_cnt +=
-			FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
-
-		val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
-		dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
-		dev->mt76.aggr_stats[aggr0++] += val >> 16;
-
-		val = mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
-		dev->mt76.aggr_stats[aggr1++] += val & 0xffff;
-		dev->mt76.aggr_stats[aggr1++] += val >> 16;
+	if (is_mt7915(&dev->mt76)) {
+		for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
+			val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, (i << 4)));
+			mib->ba_miss_cnt += FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
+			mib->ack_fail_cnt +=
+				FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
+
+			val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, (i << 4)));
+			mib->rts_cnt += FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
+			mib->rts_retries_cnt +=
+				FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
+
+			val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
+			dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
+			dev->mt76.aggr_stats[aggr0++] += val >> 16;
+
+			val = mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
+			dev->mt76.aggr_stats[aggr1++] += val & 0xffff;
+			dev->mt76.aggr_stats[aggr1++] += val >> 16;
+		}
+	} else {
+		for (i = 0; i < 2; i++) {
+			/* rts count */
+			val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, (i << 2)));
+			mib->rts_cnt += FIELD_GET(GENMASK(15, 0), val);
+			mib->rts_cnt += FIELD_GET(GENMASK(31, 16), val);
+
+			/* rts retry count */
+			val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, (i << 2)));
+			mib->rts_retries_cnt += FIELD_GET(GENMASK(15, 0), val);
+			mib->rts_retries_cnt += FIELD_GET(GENMASK(31, 16), val);
+
+			/* ba miss count */
+			val = mt76_rr(dev, MT_MIB_MB_SDR2(ext_phy, (i << 2)));
+			mib->ba_miss_cnt += FIELD_GET(GENMASK(15, 0), val);
+			mib->ba_miss_cnt += FIELD_GET(GENMASK(31, 16), val);
+
+			/* ack fail count */
+			val = mt76_rr(dev, MT_MIB_MB_BFTF(ext_phy, (i << 2)));
+			mib->ack_fail_cnt += FIELD_GET(GENMASK(15, 0), val);
+			mib->ack_fail_cnt += FIELD_GET(GENMASK(31, 16), val);
+		}
+
+		for (i = 0; i < 8; i++) {
+			val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
+			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(15, 0), val);
+			dev->mt76.aggr_stats[aggr0++] += FIELD_GET(GENMASK(31, 16), val);
+		}
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8ac6f59..8302fae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -861,8 +861,12 @@ u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif)
 	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
 					       : mvif->mt76.omac_idx;
 	/* TSF software read */
-	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
-		 MT_LPON_TCR_SW_READ);
+	if (is_mt7915(&dev->mt76))
+		mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
+			 MT_LPON_TCR_SW_READ);
+	else
+		mt76_rmw(dev, MT_LPON_TCR_MT7916(band, n), MT_LPON_TCR_SW_MODE,
+			 MT_LPON_TCR_SW_READ);
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(band));
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(band));
 
@@ -904,8 +908,12 @@ mt7915_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
 	/* TSF software overwrite */
-	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
-		 MT_LPON_TCR_SW_WRITE);
+	if (is_mt7915(&dev->mt76))
+		mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
+			 MT_LPON_TCR_SW_WRITE);
+	else
+		mt76_rmw(dev, MT_LPON_TCR_MT7916(band, n), MT_LPON_TCR_SW_MODE,
+			 MT_LPON_TCR_SW_WRITE);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -931,8 +939,12 @@ mt7915_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
 	/* TSF software adjust*/
-	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
-		 MT_LPON_TCR_SW_ADJUST);
+	if (is_mt7915(&dev->mt76))
+		mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
+			 MT_LPON_TCR_SW_ADJUST);
+	else
+		mt76_rmw(dev, MT_LPON_TCR_MT7916(band, n), MT_LPON_TCR_SW_MODE,
+			 MT_LPON_TCR_SW_ADJUST);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 8e06b94..de25cd9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -10,99 +10,335 @@
 #include "mac.h"
 #include "../trace.h"
 
+static const u32 mt7915_reg[] = {
+	[INT_SOURCE_CSR]	= 0xd7010,
+	[INT_MASK_CSR]		= 0xd7014,
+	[INT1_SOURCE_CSR]	= 0xd7088,
+	[INT1_MASK_CSR]		= 0xd708c,
+	[INT_MCU_CMD_SOURCE]	= 0xd51f0,
+	[INT_MCU_CMD_EVENT]	= 0x3108,
+};
+
+static const u32 mt7916_reg[] = {
+	[INT_SOURCE_CSR]	= 0xd4200,
+	[INT_MASK_CSR]		= 0xd4204,
+	[INT1_SOURCE_CSR]	= 0xd8200,
+	[INT1_MASK_CSR]		= 0xd8204,
+	[INT_MCU_CMD_SOURCE]	= 0xd41f0,
+	[INT_MCU_CMD_EVENT]	= 0x2108,
+};
+
+static const u32 mt7915_offs[] = {
+	[TMAC_CDTR]		= 0x090,
+	[TMAC_ODTR]		= 0x094,
+	[TMAC_ATCR]		= 0x098,
+	[TMAC_TRCR0]		= 0x09c,
+	[TMAC_ICR0]		= 0x0a4,
+	[TMAC_ICR1]		= 0x0b4,
+	[TMAC_CTCR0]		= 0x0f4,
+	[TMAC_TFCR0]		= 0x1e0,
+	[MDP_BNRCFR0]		= 0x070,
+	[MDP_BNRCFR1]		= 0x074,
+	[ARB_DRNGR0]		= 0x194,
+	[ARB_SCR]		= 0x080,
+	[RMAC_MIB_AIRTIME14]	= 0x3b8,
+	[AGG_AWSCR0]		= 0x05c,
+	[AGG_PCR0]		= 0x06c,
+	[AGG_ACR0]		= 0x084,
+	[AGG_MRCR]		= 0x098,
+	[AGG_ATCR1]		= 0x0f0,
+	[AGG_ATCR3]		= 0x0f4,
+	[LPON_UTTR0]		= 0x080,
+	[LPON_UTTR1]		= 0x084,
+	[MIB_SDR3]		= 0x014,
+	[MIB_SDR4]		= 0x018,
+	[MIB_SDR5]		= 0x01c,
+	[MIB_SDR7]		= 0x024,
+	[MIB_SDR8]		= 0x028,
+	[MIB_SDR9]		= 0x02c,
+	[MIB_SDR10]		= 0x030,
+	[MIB_SDR11]		= 0x034,
+	[MIB_SDR12]		= 0x038,
+	[MIB_SDR13]		= 0x03c,
+	[MIB_SDR14]		= 0x040,
+	[MIB_SDR15]		= 0x044,
+	[MIB_SDR16]		= 0x048,
+	[MIB_SDR17]		= 0x04c,
+	[MIB_SDR18]		= 0x050,
+	[MIB_SDR19]		= 0x054,
+	[MIB_SDR20]		= 0x058,
+	[MIB_SDR21]		= 0x05c,
+	[MIB_SDR22]		= 0x060,
+	[MIB_SDR23]		= 0x064,
+	[MIB_SDR24]		= 0x068,
+	[MIB_SDR25]		= 0x06c,
+	[MIB_SDR27]		= 0x074,
+	[MIB_SDR28]		= 0x078,
+	[MIB_SDR29]		= 0x07c,
+	[MIB_SDRVEC]		= 0x080,
+	[MIB_SDR31]		= 0x084,
+	[MIB_SDR32]		= 0x088,
+	[MIB_SDRMUBF]		= 0x090,
+	[MIB_DR8]		= 0x0c0,
+	[MIB_DR9]		= 0x0c4,
+	[MIB_DR11]		= 0x0cc,
+	[MIB_MB_SDR0]		= 0x100,
+	[MIB_MB_SDR1]		= 0x104,
+	[TX_AGG_CNT]		= 0x0a8,
+	[TX_AGG_CNT2]		= 0x164,
+	[MIB_ARNG]		= 0x4b8,
+	[WTBLON_TOP_WDUCR]	= 0x0,
+	[WTBL_UPDATE]		= 0x030,
+	[PLE_FL_Q_EMPTY]	= 0x0b0,
+	[PLE_FL_Q_CTRL]		= 0x1b0,
+	[PLE_AC_QEMPTY]		= 0x500,
+	[PLE_FREEPG_CNT]	= 0x100,
+	[PLE_FREEPG_HEAD_TAIL]	= 0x104,
+	[PLE_PG_HIF_GROUP]	= 0x110,
+	[PLE_HIF_PG_INFO]	= 0x114,
+	[AC_OFFSET]		= 0x040,
+};
+
+static const u32 mt7916_offs[] = {
+	[TMAC_CDTR]		= 0x0c8,
+	[TMAC_ODTR]		= 0x0cc,
+	[TMAC_ATCR]		= 0x00c,
+	[TMAC_TRCR0]		= 0x010,
+	[TMAC_ICR0]		= 0x014,
+	[TMAC_ICR1]		= 0x018,
+	[TMAC_CTCR0]		= 0x114,
+	[TMAC_TFCR0]		= 0x0e4,
+	[MDP_BNRCFR0]		= 0x090,
+	[MDP_BNRCFR1]		= 0x094,
+	[ARB_DRNGR0]		= 0x1e0,
+	[ARB_SCR]		= 0x000,
+	[RMAC_MIB_AIRTIME14]	= 0x0398,
+	[AGG_AWSCR0]		= 0x030,
+	[AGG_PCR0]		= 0x040,
+	[AGG_ACR0]		= 0x054,
+	[AGG_MRCR]		= 0x068,
+	[AGG_ATCR1]		= 0x1a8,
+	[AGG_ATCR3]		= 0x080,
+	[LPON_UTTR0]		= 0x360,
+	[LPON_UTTR1]		= 0x364,
+	[MIB_SDR3]		= 0x698,
+	[MIB_SDR4]		= 0x788,
+	[MIB_SDR5]		= 0x780,
+	[MIB_SDR7]		= 0x5a8,
+	[MIB_SDR8]		= 0x78c,
+	[MIB_SDR9]		= 0x024,
+	[MIB_SDR10]		= 0x76c,
+	[MIB_SDR11]		= 0x790,
+	[MIB_SDR12]		= 0x558,
+	[MIB_SDR13]		= 0x560,
+	[MIB_SDR14]		= 0x564,
+	[MIB_SDR15]		= 0x568,
+	[MIB_SDR16]		= 0x7fc,
+	[MIB_SDR17]		= 0x800,
+	[MIB_SDR18]		= 0x030,
+	[MIB_SDR19]		= 0x5ac,
+	[MIB_SDR20]		= 0x5b0,
+	[MIB_SDR21]		= 0x5b4,
+	[MIB_SDR22]		= 0x770,
+	[MIB_SDR23]		= 0x774,
+	[MIB_SDR24]		= 0x778,
+	[MIB_SDR25]		= 0x77c,
+	[MIB_SDR27]		= 0x080,
+	[MIB_SDR28]		= 0x084,
+	[MIB_SDR29]		= 0x650,
+	[MIB_SDRVEC]		= 0x5a8,
+	[MIB_SDR31]		= 0x55c,
+	[MIB_SDR32]		= 0x7a8,
+	[MIB_SDRMUBF]		= 0x7ac,
+	[MIB_DR8]		= 0x56c,
+	[MIB_DR9]		= 0x570,
+	[MIB_DR11]		= 0x574,
+	[MIB_MB_SDR0]		= 0x688,
+	[MIB_MB_SDR1]		= 0x690,
+	[TX_AGG_CNT]		= 0x7dc,
+	[TX_AGG_CNT2]		= 0x7ec,
+	[MIB_ARNG]		= 0x0b0,
+	[WTBLON_TOP_WDUCR]	= 0x200,
+	[WTBL_UPDATE]		= 0x230,
+	[PLE_FL_Q_EMPTY]	= 0x360,
+	[PLE_FL_Q_CTRL]		= 0x3e0,
+	[PLE_AC_QEMPTY]		= 0x600,
+	[PLE_FREEPG_CNT]	= 0x380,
+	[PLE_FREEPG_HEAD_TAIL]	= 0x384,
+	[PLE_PG_HIF_GROUP]	= 0x00c,
+	[PLE_HIF_PG_INFO]	= 0x388,
+	[AC_OFFSET]		= 0x080,
+};
+
+static const struct __map mt7915_reg_map[] = {
+	{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
+	{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
+	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
+	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
+	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+	{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+	{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
+	{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
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
+	{ 0x0, 0x0, 0x0 }, /* imply end of search */
+};
+
+static const struct __map mt7916_reg_map[] = {
+	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
+	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
+	{ 0x56000000, 0x04000, 0x1000 }, /* WFDMA_2 (Reserved) */
+	{ 0x57000000, 0x05000, 0x1000 }, /* WFDMA_3 (MCU wrap CR) */
+	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
+	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
+	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
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
+	{ 0x820d0000, 0x30000, 0x10000}, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x90000, 0x10000}, /* WF_MCU_SYSRAM (configure cr) */
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
+	{ 0x820c4000, 0xa8000, 0x1000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
+	{ 0x820b0000, 0xae000, 0x1000 }, /* [APB2] WFSYS_ON */
+	{ 0x80020000, 0xb0000, 0x10000}, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0xc0000, 0x10000}, /* WF_TOP_MISC_ON */
+	{ 0x0, 0x0, 0x0 }, /* imply end of search */
+};
+
 static u32 mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
 {
 	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
 	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+	u32 l1_remap = is_mt7915(&dev->mt76) ?
+			MT_HIF_REMAP_L1 : MT_HIF_REMAP_L1_MT7916;
 
-	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	dev->bus_ops->rmw(&dev->mt76, l1_remap,
+			  MT_HIF_REMAP_L1_MASK,
+		FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
 	/* use read to push write */
-	mt76_rr(dev, MT_HIF_REMAP_L1);
+	dev->bus_ops->rr(&dev->mt76, l1_remap);
 
 	return MT_HIF_REMAP_BASE_L1 + offset;
 }
 
 static u32 mt7915_reg_map_l2(struct mt7915_dev *dev, u32 addr)
 {
-	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
-	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+	u32 offset, base;
 
-	mt76_rmw_field(dev, MT_HIF_REMAP_L2, MT_HIF_REMAP_L2_MASK, base);
-	/* use read to push write */
-	mt76_rr(dev, MT_HIF_REMAP_L2);
+	if (is_mt7915(&dev->mt76)) {
+		offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
+		base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+
+		dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2,
+				  MT_HIF_REMAP_L2_MASK,
+				  FIELD_PREP(MT_HIF_REMAP_L2_MASK, base));
+
+		/* use read to push write */
+		dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
+	} else {
+		offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET_MT7916, addr);
+		base = FIELD_GET(MT_HIF_REMAP_L2_BASE_MT7916, addr);
+
+		dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2_MT7916,
+				  MT_HIF_REMAP_L2_MASK_MT7916,
+				  FIELD_PREP(MT_HIF_REMAP_L2_MASK_MT7916, base));
+
+		/* use read to push write */
+		dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2_MT7916);
+
+		offset += MT_HIF_REMAP_BASE_L2_MT7916;
+	}
 
-	return MT_HIF_REMAP_BASE_L2 + offset;
+	return offset;
 }
 
 static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 {
-	static const struct {
-		u32 phys;
-		u32 mapped;
-		u32 size;
-	} fixed_map[] = {
-		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
-		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
-		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
-		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
-		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
-		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
-		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
-		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
-		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
-		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
-		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
-		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
-		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
-		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
-		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
-		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
-		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
-		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
-		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
-		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
-		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
-		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
-		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
-		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
-		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
-		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
-		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
-		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
-		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
-		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
-		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
-		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
-		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
-		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
-	};
 	int i;
 
 	if (addr < 0x100000)
 		return addr;
 
-	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
+	if (!dev->reg.map) {
+		dev_err(dev->mt76.dev, "err: reg_map is null\n");
+		return addr;
+	}
+
+	for (i = 0; i < dev->reg.map_size; i++) {
 		u32 ofs;
 
-		if (addr < fixed_map[i].phys)
+		if (addr < dev->reg.map[i].phys)
 			continue;
 
-		ofs = addr - fixed_map[i].phys;
-		if (ofs > fixed_map[i].size)
+		ofs = addr - dev->reg.map[i].phys;
+		if (ofs > dev->reg.map[i].size)
 			continue;
 
-		return fixed_map[i].mapped + ofs;
+		return dev->reg.map[i].maps + ofs;
 	}
 
-	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
-	    (addr >= 0x70000000 && addr < 0x78000000))
+	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
+	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
+	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END) ||
+	    (addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
+	    (addr >= MT_CBTOP2_PHY_START && addr <= MT_CBTOP2_PHY_END))
 		return mt7915_reg_map_l1(dev, addr);
 
 	return mt7915_reg_map_l2(dev, addr);
@@ -142,6 +378,23 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
 	dev = container_of(mdev, struct mt7915_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
 
+	switch (device_id) {
+	case 0x7915:
+		dev->reg.reg_rev = mt7915_reg;
+		dev->reg.offs_rev = mt7915_offs;
+		dev->reg.map = mt7915_reg_map;
+		dev->reg.map_size = ARRAY_SIZE(mt7915_reg_map);
+		break;
+	case 0x7906:
+		dev->reg.reg_rev = mt7916_reg;
+		dev->reg.offs_rev = mt7916_offs;
+		dev->reg.map = mt7916_reg_map;
+		dev->reg.map_size = ARRAY_SIZE(mt7916_reg_map);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	dev->bus_ops = dev->mt76.bus;
 	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
 			       GFP_KERNEL);
@@ -184,15 +437,8 @@ static void mt7915_rx_poll_complete(struct mt76_dev *mdev,
 				    enum mt76_rxq_id q)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	static const u32 rx_irq_mask[] = {
-		[MT_RXQ_MAIN] = MT_INT_RX_DONE_DATA0,
-		[MT_RXQ_EXT] = MT_INT_RX_DONE_DATA1,
-		[MT_RXQ_MCU] = MT_INT_RX_DONE_WM,
-		[MT_RXQ_MCU_WA] = MT_INT_RX_DONE_WA,
-		[MT_RXQ_EXT_WA] = MT_INT_RX_DONE_WA_EXT,
-	};
 
-	mt7915_irq_enable(dev, rx_irq_mask[q]);
+	mt7915_irq_enable(dev, MT_INT_RX(q));
 }
 
 /* TODO: support 2/4/6/8 MSI-X vectors */
@@ -228,19 +474,19 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 	if (intr & MT_INT_TX_DONE_MCU)
 		napi_schedule(&dev->mt76.tx_napi);
 
-	if (intr & MT_INT_RX_DONE_DATA0)
+	if (intr & MT_INT_RX(MT_RXQ_MAIN))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
 
-	if (intr & MT_INT_RX_DONE_DATA1)
+	if (intr & MT_INT_RX(MT_RXQ_EXT))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT]);
 
-	if (intr & MT_INT_RX_DONE_WM)
+	if (intr & MT_INT_RX(MT_RXQ_MCU))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
 
-	if (intr & MT_INT_RX_DONE_WA)
+	if (intr & MT_INT_RX(MT_RXQ_MCU_WA))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
 
-	if (intr & MT_INT_RX_DONE_WA_EXT)
+	if (intr & MT_INT_RX(MT_RXQ_EXT_WA))
 		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT_WA]);
 
 	if (intr & MT_INT_MCU_CMD) {
@@ -330,8 +576,12 @@ int mt7915_mmio_probe(struct device *pdev,
 
 		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
 		/* master switch of PCIe tnterrupt enable */
-		if (dev_is_pci(pdev))
-			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+		if (dev_is_pci(pdev)) {
+			if (is_mt7915(mdev))
+				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+			else
+				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE_MT7916, 0xff);
+		}
 
 		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
 				       mt7915_irq_handler, IRQF_SHARED,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 5301690..778f405 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -13,7 +13,7 @@
 #define MT7915_MAX_WMM_SETS		4
 #define MT7915_WTBL_SIZE		288
 #define MT7915_WTBL_RESERVED		(MT7915_WTBL_SIZE - 1)
-#define MT7915_WTBL_STA			(MT7915_WTBL_RESERVED - \
+#define MT7915_WTBL_STA			(MT7915_WTBL_RESERVED -	\
 					 MT7915_MAX_INTERFACES)
 
 #define MT7915_WATCHDOG_TIME		(HZ / 10)
@@ -46,6 +46,7 @@
 
 #define MT7915_MAX_TWT_AGRT		16
 #define MT7915_MAX_STA_TWT_AGRT		8
+#define MT7915_MAX_QUEUE		(__MT_RXQ_MAX + __MT_MCUQ_MAX + 2)
 
 struct mt7915_vif;
 struct mt7915_sta;
@@ -68,6 +69,14 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_MCU_WA_EXT,
 };
 
+enum mt7916_rxq_id {
+	MT7916_RXQ_MCU_WM = 0,
+	MT7916_RXQ_MCU_WA,
+	MT7916_RXQ_MCU_WA_EXT = 3,
+	MT7916_RXQ_BAND0,
+	MT7916_RXQ_BAND1,
+};
+
 struct mt7915_sta_key_conf {
 	s8 keyidx;
 	u8 key[16];
@@ -247,6 +256,10 @@ struct mt7915_dev {
 	};
 
 	struct mt7915_hif *hif2;
+	struct mt7915_reg_desc reg;
+	u8 q_id[MT7915_MAX_QUEUE];
+	u32 q_int_mask[MT7915_MAX_QUEUE];
+	u32 wfdma_mask;
 
 	const struct mt76_bus_ops *bus_ops;
 	struct tasklet_struct irq_tasklet;
@@ -283,6 +296,13 @@ struct mt7915_dev {
 	} twt;
 };
 
+enum {
+	WFDMA0 = 0x0,
+	WFDMA1,
+	WFDMA_EXT,
+	__MT_WFDMA_MAX,
+};
+
 enum {
 	MT_CTX0,
 	MT_HIF0 = 0x0,
@@ -360,7 +380,6 @@ int mt7915_mmio_probe(struct device *pdev,
 		      void __iomem *mem_base,
 		      u32 device_id,
 		      int irq, struct mt7915_hif *hif2);
-u32 mt7915_reg_map(struct mt7915_dev *dev, u32 addr);
 u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
@@ -505,7 +524,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct mt76_tx_info *tx_info);
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7915_tx_token_put(struct mt7915_dev *dev);
-int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc);
+int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index ff71f56..372b7f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -4,41 +4,145 @@
 #ifndef __MT7915_REGS_H
 #define __MT7915_REGS_H
 
+struct __map {
+	u32 phys;
+	u32 maps;
+	u32 size;
+};
+
+/* used to differentiate between generations */
+struct mt7915_reg_desc {
+	const u32 *reg_rev;
+	const u32 *offs_rev;
+	const struct __map *map;
+	u32 map_size;
+};
+
+enum reg_rev {
+	INT_SOURCE_CSR,
+	INT_MASK_CSR,
+	INT1_SOURCE_CSR,
+	INT1_MASK_CSR,
+	INT_MCU_CMD_SOURCE,
+	INT_MCU_CMD_EVENT,
+	__MT_REG_MAX,
+};
+
+enum offs_rev {
+	TMAC_CDTR,
+	TMAC_ODTR,
+	TMAC_ATCR,
+	TMAC_TRCR0,
+	TMAC_ICR0,
+	TMAC_ICR1,
+	TMAC_CTCR0,
+	TMAC_TFCR0,
+	MDP_BNRCFR0,
+	MDP_BNRCFR1,
+	ARB_DRNGR0,
+	ARB_SCR,
+	RMAC_MIB_AIRTIME14,
+	AGG_AWSCR0,
+	AGG_PCR0,
+	AGG_ACR0,
+	AGG_MRCR,
+	AGG_ATCR1,
+	AGG_ATCR3,
+	LPON_UTTR0,
+	LPON_UTTR1,
+	MIB_SDR3,
+	MIB_SDR4,
+	MIB_SDR5,
+	MIB_SDR7,
+	MIB_SDR8,
+	MIB_SDR9,
+	MIB_SDR10,
+	MIB_SDR11,
+	MIB_SDR12,
+	MIB_SDR13,
+	MIB_SDR14,
+	MIB_SDR15,
+	MIB_SDR16,
+	MIB_SDR17,
+	MIB_SDR18,
+	MIB_SDR19,
+	MIB_SDR20,
+	MIB_SDR21,
+	MIB_SDR22,
+	MIB_SDR23,
+	MIB_SDR24,
+	MIB_SDR25,
+	MIB_SDR27,
+	MIB_SDR28,
+	MIB_SDR29,
+	MIB_SDRVEC,
+	MIB_SDR31,
+	MIB_SDR32,
+	MIB_SDRMUBF,
+	MIB_DR8,
+	MIB_DR9,
+	MIB_DR11,
+	MIB_MB_SDR0,
+	MIB_MB_SDR1,
+	TX_AGG_CNT,
+	TX_AGG_CNT2,
+	MIB_ARNG,
+	WTBLON_TOP_WDUCR,
+	WTBL_UPDATE,
+	PLE_FL_Q_EMPTY,
+	PLE_FL_Q_CTRL,
+	PLE_AC_QEMPTY,
+	PLE_FREEPG_CNT,
+	PLE_FREEPG_HEAD_TAIL,
+	PLE_PG_HIF_GROUP,
+	PLE_HIF_PG_INFO,
+	AC_OFFSET,
+	__MT_OFFS_MAX,
+};
+
+#define __REG(id)			(dev->reg.reg_rev[(id)])
+#define __OFFS(id)			(dev->reg.offs_rev[(id)])
+
 /* MCU WFDMA0 */
 #define MT_MCU_WFDMA0_BASE		0x2000
 #define MT_MCU_WFDMA0(ofs)		(MT_MCU_WFDMA0_BASE + (ofs))
+
 #define MT_MCU_WFDMA0_DUMMY_CR		MT_MCU_WFDMA0(0x120)
 
 /* MCU WFDMA1 */
 #define MT_MCU_WFDMA1_BASE		0x3000
 #define MT_MCU_WFDMA1(ofs)		(MT_MCU_WFDMA1_BASE + (ofs))
 
-#define MT_MCU_INT_EVENT		MT_MCU_WFDMA1(0x108)
+#define MT_MCU_INT_EVENT		__REG(INT_MCU_CMD_EVENT)
 #define MT_MCU_INT_EVENT_DMA_STOPPED	BIT(0)
 #define MT_MCU_INT_EVENT_DMA_INIT	BIT(1)
 #define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
 #define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
 
-#define MT_PLE_BASE			0x8000
+/* PLE */
+#define MT_PLE_BASE			0x820c0000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
-#define MT_FL_Q_EMPTY			0x0b0
-#define MT_FL_Q0_CTRL			0x1b0
-#define MT_FL_Q2_CTRL			0x1b8
-#define MT_FL_Q3_CTRL			0x1bc
-
-#define MT_PLE_FREEPG_CNT		MT_PLE(0x100)
-#define MT_PLE_FREEPG_HEAD_TAIL		MT_PLE(0x104)
-#define MT_PLE_PG_HIF_GROUP		MT_PLE(0x110)
-#define MT_PLE_HIF_PG_INFO		MT_PLE(0x114)
-#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x500 + 0x40 * (ac) + \
-					       ((n) << 2))
+#define MT_FL_Q_EMPTY			MT_PLE(__OFFS(PLE_FL_Q_EMPTY))
+#define MT_FL_Q0_CTRL			MT_PLE(__OFFS(PLE_FL_Q_CTRL))
+#define MT_FL_Q2_CTRL			MT_PLE(__OFFS(PLE_FL_Q_CTRL) + 0x8)
+#define MT_FL_Q3_CTRL			MT_PLE(__OFFS(PLE_FL_Q_CTRL) + 0xc)
+
+#define MT_PLE_FREEPG_CNT		MT_PLE(__OFFS(PLE_FREEPG_CNT))
+#define MT_PLE_FREEPG_HEAD_TAIL		MT_PLE(__OFFS(PLE_FREEPG_HEAD_TAIL))
+#define MT_PLE_PG_HIF_GROUP		MT_PLE(__OFFS(PLE_PG_HIF_GROUP))
+#define MT_PLE_HIF_PG_INFO		MT_PLE(__OFFS(PLE_HIF_PG_INFO))
+
+#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(__OFFS(PLE_AC_QEMPTY) +	\
+					       __OFFS(AC_OFFSET) *	\
+					       (ac) + ((n) << 2))
 #define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
 
-#define MT_PSE_BASE			0xc000
+#define MT_PSE_BASE			0x820c8000
 #define MT_PSE(ofs)			(MT_PSE_BASE + (ofs))
 
-#define MT_MDP_BASE			0xf000
+/* WF MDP TOP */
+#define MT_MDP_BASE			0x820cd000
 #define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
 
 #define MT_MDP_DCR0			MT_MDP(0x000)
@@ -47,63 +151,66 @@
 #define MT_MDP_DCR1			MT_MDP(0x004)
 #define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
 
-#define MT_MDP_BNRCFR0(_band)		MT_MDP(0x070 + ((_band) << 8))
+#define MT_MDP_BNRCFR0(_band)		MT_MDP(__OFFS(MDP_BNRCFR0) + \
+					       ((_band) << 8))
 #define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
 #define MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR	GENMASK(7, 6)
 #define MT_MDP_RCFR0_MCU_RX_CTL_BAR	GENMASK(9, 8)
 
-#define MT_MDP_BNRCFR1(_band)		MT_MDP(0x074 + ((_band) << 8))
+#define MT_MDP_BNRCFR1(_band)		MT_MDP(__OFFS(MDP_BNRCFR1) + \
+					       ((_band) << 8))
 #define MT_MDP_RCFR1_MCU_RX_BYPASS	GENMASK(23, 22)
 #define MT_MDP_RCFR1_RX_DROPPED_UCAST	GENMASK(28, 27)
 #define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
 #define MT_MDP_TO_HIF			0
 #define MT_MDP_TO_WM			1
 
-/* TMAC: band 0(0x21000), band 1(0xa1000) */
-#define MT_WF_TMAC_BASE(_band)		((_band) ? 0xa1000 : 0x21000)
+/* TMAC: band 0(0x820e4000), band 1(0x820f4000) */
+#define MT_WF_TMAC_BASE(_band)		((_band) ? 0x820f4000 : 0x820e4000)
 #define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
 
 #define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
 #define MT_TMAC_TCR0_TX_BLINK		GENMASK(7, 6)
 #define MT_TMAC_TCR0_TBTT_STOP_CTRL	BIT(25)
 
-#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, 0x090)
-#define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, 0x094)
+#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_CDTR))
+ #define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_ODTR))
 #define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
 #define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
 
-#define MT_TMAC_ATCR(_band)		MT_WF_TMAC(_band, 0x098)
+#define MT_TMAC_ATCR(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_ATCR))
 #define MT_TMAC_ATCR_TXV_TOUT		GENMASK(7, 0)
 
-#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
+#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_TRCR0))
 #define MT_TMAC_TRCR0_TR2T_CHK		GENMASK(8, 0)
 #define MT_TMAC_TRCR0_I2T_CHK		GENMASK(24, 16)
 
-#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
-#define MT_IFS_EIFS_OFDM			GENMASK(8, 0)
+#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_ICR0))
+#define MT_IFS_EIFS_OFDM		GENMASK(8, 0)
 #define MT_IFS_RIFS			GENMASK(14, 10)
 #define MT_IFS_SIFS			GENMASK(22, 16)
 #define MT_IFS_SLOT			GENMASK(30, 24)
 
-#define MT_TMAC_ICR1(_band)		MT_WF_TMAC(_band, 0x0b4)
+#define MT_TMAC_ICR1(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_ICR1))
 #define MT_IFS_EIFS_CCK			GENMASK(8, 0)
 
-#define MT_TMAC_CTCR0(_band)			MT_WF_TMAC(_band, 0x0f4)
+#define MT_TMAC_CTCR0(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_CTCR0))
 #define MT_TMAC_CTCR0_INS_DDLMT_REFTIME		GENMASK(5, 0)
 #define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
 #define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
 
-#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
+#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, __OFFS(TMAC_TFCR0))
 
-#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
+/* WF DMA TOP: band 0(0x820e7000),band 1(0x820f7000) */
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0x820f7000 : 0x820e7000)
 #define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
 
 #define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
 #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
 #define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
 
-/* ETBF: band 0(0x24000), band 1(0xa4000) */
-#define MT_WF_ETBF_BASE(_band)		((_band) ? 0xa4000 : 0x24000)
+/* ETBF: band 0(0x820ea000), band 1(0x820fa000) */
+#define MT_WF_ETBF_BASE(_band)		((_band) ? 0x820fa000 : 0x820ea000)
 #define MT_WF_ETBF(_band, ofs)		(MT_WF_ETBF_BASE(_band) + (ofs))
 
 #define MT_ETBF_TX_NDP_BFRP(_band)	MT_WF_ETBF(_band, 0x040)
@@ -125,174 +232,195 @@
 #define MT_ETBF_RX_FB_VHT		GENMASK(15, 8)
 #define MT_ETBF_RX_FB_HT		GENMASK(7, 0)
 
-/* LPON: band 0(0x24200), band 1(0xa4200) */
-#define MT_WF_LPON_BASE(_band)		((_band) ? 0xa4200 : 0x24200)
+/* LPON: band 0(0x820eb000), band 1(0x820fb000) */
+#define MT_WF_LPON_BASE(_band)		((_band) ? 0x820fb000 : 0x820eb000)
 #define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
 
-#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
-#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, 0x084)
+#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, __OFFS(LPON_UTTR0))
+#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, __OFFS(LPON_UTTR1))
 
-#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
+#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 +	\
+						   (((n) * 4) << 1))
+#define MT_LPON_TCR_MT7916(_band, n)	MT_WF_LPON(_band, 0x0a8 +	\
+						   (((n) * 4) << 4))
 #define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
 #define MT_LPON_TCR_SW_WRITE		BIT(0)
 #define MT_LPON_TCR_SW_ADJUST		BIT(1)
 #define MT_LPON_TCR_SW_READ		GENMASK(1, 0)
 
-/* MIB: band 0(0x24800), band 1(0xa4800) */
+/* MIB: band 0(0x820ed000), band 1(0x820fd000) */
 /* These counters are (mostly?) clear-on-read.  So, some should not
  * be read at all in case firmware is already reading them.  These
  * are commented with 'DNR' below.  The DNR stats will be read by querying
  * the firmware API for the appropriate message.  For counters the driver
  * does read, the driver should accumulate the counters.
  */
-#define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
+#define MT_WF_MIB_BASE(_band)		((_band) ? 0x820fd000 : 0x820ed000)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
 
 #define MT_MIB_SDR0(_band)		MT_WF_MIB(_band, 0x010)
 #define MT_MIB_SDR0_BERACON_TX_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR3))
 #define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR3_FCS_ERR_MASK_MT7916	GENMASK(31, 16)
 
-#define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, 0x018)
+#define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR4))
 #define MT_MIB_SDR4_RX_FIFO_FULL_MASK	GENMASK(15, 0)
 
 /* rx mpdu counter, full 32 bits */
-#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x01c)
+#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR5))
 
 #define MT_MIB_SDR6(_band)		MT_WF_MIB(_band, 0x020)
 #define MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR7(_band)		MT_WF_MIB(_band, 0x024)
+#define MT_MIB_SDR7(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR7))
 #define MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR8(_band)		MT_WF_MIB(_band, 0x028)
+#define MT_MIB_SDR8(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR8))
 #define MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK	GENMASK(15, 0)
 
 /* aka CCA_NAV_TX_TIME */
-#define MT_MIB_SDR9_DNR(_band)		MT_WF_MIB(_band, 0x02c)
-#define MT_MIB_SDR9_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR9_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR9))
+#define MT_MIB_SDR9_CCA_BUSY_TIME_MASK		GENMASK(23, 0)
 
-#define MT_MIB_SDR10_DNR(_band)		MT_WF_MIB(_band, 0x030)
-#define MT_MIB_SDR10_MRDY_COUNT_MASK	GENMASK(25, 0)
+#define MT_MIB_SDR10_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR10))
+#define MT_MIB_SDR10_MRDY_COUNT_MASK		GENMASK(25, 0)
+#define MT_MIB_SDR10_MRDY_COUNT_MASK_MT7916	GENMASK(31, 0)
 
-#define MT_MIB_SDR11(_band)		MT_WF_MIB(_band, 0x034)
+#define MT_MIB_SDR11(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR11))
 #define MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK	GENMASK(15, 0)
 
 /* tx ampdu cnt, full 32 bits */
-#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, 0x038)
+#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR12))
 
-#define MT_MIB_SDR13(_band)		MT_WF_MIB(_band, 0x03c)
+#define MT_MIB_SDR13(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR13))
 #define MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK	GENMASK(15, 0)
 
 /* counts all mpdus in ampdu, regardless of success */
-#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, 0x040)
+#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR14))
 #define MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK_MT7916	GENMASK(31, 0)
 
 /* counts all successfully tx'd mpdus in ampdu */
-#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, 0x044)
+#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR15))
 #define MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK_MT7916	GENMASK(31, 0)
 
 /* in units of 'us' */
-#define MT_MIB_SDR16_DNR(_band)		MT_WF_MIB(_band, 0x048)
+#define MT_MIB_SDR16_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR16))
 #define MT_MIB_SDR16_PRIMARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR17_DNR(_band)		MT_WF_MIB(_band, 0x04c)
+#define MT_MIB_SDR17_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR17))
 #define MT_MIB_SDR17_SECONDARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR18(_band)		MT_WF_MIB(_band, 0x050)
+#define MT_MIB_SDR18(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR18))
 #define MT_MIB_SDR18_PRIMARY_ENERGY_DETECT_TIME_MASK	GENMASK(23, 0)
 
 /* units are us */
-#define MT_MIB_SDR19_DNR(_band)		MT_WF_MIB(_band, 0x054)
+#define MT_MIB_SDR19_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR19))
 #define MT_MIB_SDR19_CCK_MDRDY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR20_DNR(_band)		MT_WF_MIB(_band, 0x058)
+#define MT_MIB_SDR20_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR20))
 #define MT_MIB_SDR20_OFDM_VHT_MDRDY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR21_DNR(_band)		MT_WF_MIB(_band, 0x05c)
+#define MT_MIB_SDR21_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR21))
 #define MT_MIB_SDR20_GREEN_MDRDY_TIME_MASK	GENMASK(23, 0)
 
 /* rx ampdu count, 32-bit */
-#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, 0x060)
+#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR22))
 
 /* rx ampdu bytes count, 32-bit */
-#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, 0x064)
+#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR23))
 
 /* rx ampdu valid subframe count */
-#define MT_MIB_SDR24(_band)		MT_WF_MIB(_band, 0x068)
+#define MT_MIB_SDR24(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR24))
 #define MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK_MT7916	GENMASK(31, 0)
 
 /* rx ampdu valid subframe bytes count, 32bits */
-#define MT_MIB_SDR25(_band)		MT_WF_MIB(_band, 0x06c)
+#define MT_MIB_SDR25(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR25))
 
 /* remaining windows protected stats */
-#define MT_MIB_SDR27(_band)		MT_WF_MIB(_band, 0x074)
+#define MT_MIB_SDR27(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR27))
 #define MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR28(_band)		MT_WF_MIB(_band, 0x078)
+#define MT_MIB_SDR28(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR28))
 #define MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR29(_band)		MT_WF_MIB(_band, 0x07c)
-#define MT_MIB_SDR29_RX_PFDROP_CNT_MASK	GENMASK(7, 0)
+#define MT_MIB_SDR29(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR29))
+#define MT_MIB_SDR29_RX_PFDROP_CNT_MASK		GENMASK(7, 0)
+#define MT_MIB_SDR29_RX_PFDROP_CNT_MASK_MT7916	GENMASK(15, 0)
 
-#define MT_MIB_SDR30(_band)		MT_WF_MIB(_band, 0x080)
+#define MT_MIB_SDRVEC(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDRVEC))
 #define MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK_MT7916	GENMASK(31, 16)
 
 /* rx blockack count, 32 bits */
-#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, 0x084)
+#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR31))
 
-#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x088)
+#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR32))
 #define MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x08c)
-#define MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x088)
+#define MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK_MT7916	GENMASK(31, 16)
 
-#define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
+#define MT_MIB_SDRMUBF(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDRMUBF))
 #define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
 
 /* 36, 37 both DNR */
 
-#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
-#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
-#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
+#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, __OFFS(MIB_DR8))
+#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, __OFFS(MIB_DR9))
+#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, __OFFS(MIB_DR11))
 
-#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, 0x100 + ((n) << 4))
+#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, __OFFS(MIB_MB_SDR0) + (n))
 #define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
 #define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
 
-#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, 0x104 + ((n) << 4))
+#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, __OFFS(MIB_MB_SDR1) + (n))
 #define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
 #define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
 
-#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x0a8 + ((n) << 2))
-#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x164 + ((n) << 2))
-#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
+#define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x518 + (n))
+#define MT_MIB_MB_BFTF(_band, n)	MT_WF_MIB(_band, 0x510 + (n))
+
+#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, __OFFS(TX_AGG_CNT) +	\
+						  ((n) << 2))
+#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, __OFFS(TX_AGG_CNT2) +	\
+						  ((n) << 2))
+#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, __OFFS(MIB_ARNG) +	\
+						  ((n) << 2))
 #define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
 
-#define MT_WTBLON_TOP_BASE		0x34000
+/* WTBLON TOP */
+#define MT_WTBLON_TOP_BASE		0x820d4000
 #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
-#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x0)
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(__OFFS(WTBLON_TOP_WDUCR))
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
 
-#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x030)
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(__OFFS(WTBL_UPDATE))
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
 #define MT_WTBL_UPDATE_BUSY		BIT(31)
 
-#define MT_WTBL_BASE			0x38000
+/* WTBL */
+#define MT_WTBL_BASE			0x820d8000
 #define MT_WTBL_LMAC_ID			GENMASK(14, 8)
 #define MT_WTBL_LMAC_DW			GENMASK(7, 2)
 #define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
-					FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
-					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+					 FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+					 FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
 
-/* AGG: band 0(0x20800), band 1(0xa0800) */
-#define MT_WF_AGG_BASE(_band)		((_band) ? 0xa0800 : 0x20800)
+/* AGG: band 0(0x820e2000), band 1(0x820f2000) */
+#define MT_WF_AGG_BASE(_band)		((_band) ? 0x820f2000 : 0x820e2000)
 #define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
 
-#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
-#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, 0x06c + (_n) * 4)
+#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, (__OFFS(AGG_AWSCR0) +	\
+							  (_n) * 4))
+#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, (__OFFS(AGG_PCR0) +	\
+							  (_n) * 4))
 #define MT_AGG_PCR0_MM_PROT		BIT(0)
 #define MT_AGG_PCR0_GF_PROT		BIT(1)
 #define MT_AGG_PCR0_BW20_PROT		BIT(2)
@@ -305,31 +433,32 @@
 #define MT_AGG_PCR1_RTS0_NUM_THRES	GENMASK(31, 23)
 #define MT_AGG_PCR1_RTS0_LEN_THRES	GENMASK(19, 0)
 
-#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, 0x084)
+#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, __OFFS(AGG_ACR0))
 #define MT_AGG_ACR_CFEND_RATE		GENMASK(13, 0)
 #define MT_AGG_ACR_BAR_RATE		GENMASK(29, 16)
 
-#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, 0x098)
-#define MT_AGG_MRCR_BAR_CNT_LIMIT	GENMASK(15, 12)
-#define MT_AGG_MRCR_LAST_RTS_CTS_RN	BIT(6)
-#define MT_AGG_MRCR_RTS_FAIL_LIMIT	GENMASK(11, 7)
+#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, __OFFS(AGG_MRCR))
+#define MT_AGG_MRCR_BAR_CNT_LIMIT		GENMASK(15, 12)
+#define MT_AGG_MRCR_LAST_RTS_CTS_RN		BIT(6)
+#define MT_AGG_MRCR_RTS_FAIL_LIMIT		GENMASK(11, 7)
 #define MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT	GENMASK(28, 24)
 
-#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, 0x0f0)
-#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
+#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, __OFFS(AGG_ATCR1))
+#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, __OFFS(AGG_ATCR3))
 
-/* ARB: band 0(0x20c00), band 1(0xa0c00) */
-#define MT_WF_ARB_BASE(_band)		((_band) ? 0xa0c00 : 0x20c00)
+/* ARB: band 0(0x820e3000), band 1(0x820f3000) */
+#define MT_WF_ARB_BASE(_band)		((_band) ? 0x820f3000 : 0x820e3000)
 #define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
 
-#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
+#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, __OFFS(ARB_SCR))
 #define MT_ARB_SCR_TX_DISABLE		BIT(8)
 #define MT_ARB_SCR_RX_DISABLE		BIT(9)
 
-#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
+#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, (__OFFS(ARB_DRNGR0) +	\
+							  (_n) * 4))
 
-/* RMAC: band 0(0x21400), band 1(0xa1400) */
-#define MT_WF_RMAC_BASE(_band)		((_band) ? 0xa1400 : 0x21400)
+/* RMAC: band 0(0x820e5000), band 1(0x820f5000) */
+#define MT_WF_RMAC_BASE(_band)		((_band) ? 0x820f5000 : 0x820e5000)
 #define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
 
 #define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
@@ -385,12 +514,6 @@
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
 #define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
 
-#define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x500)
-
-#define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
-#define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
-#define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
-
 /* WFDMA1 */
 #define MT_WFDMA1_BASE			0xd5000
 #define MT_WFDMA1(ofs)			(MT_WFDMA1_BASE + (ofs))
@@ -404,14 +527,6 @@
 #define MT_WFDMA1_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA1_BUSY_ENA_RX_FIFO	BIT(2)
 
-#define MT_MCU_CMD			MT_WFDMA1(0x1f0)
-#define MT_MCU_CMD_STOP_DMA_FW_RELOAD	BIT(1)
-#define MT_MCU_CMD_STOP_DMA		BIT(2)
-#define MT_MCU_CMD_RESET_DONE		BIT(3)
-#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
-#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
-#define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
-
 #define MT_WFDMA1_GLO_CFG		MT_WFDMA1(0x208)
 #define MT_WFDMA1_GLO_CFG_TX_DMA_EN	BIT(0)
 #define MT_WFDMA1_GLO_CFG_RX_DMA_EN	BIT(2)
@@ -421,112 +536,155 @@
 #define MT_WFDMA1_RST_DTX_PTR		MT_WFDMA1(0x20c)
 #define MT_WFDMA1_PRI_DLY_INT_CFG0	MT_WFDMA1(0x2f0)
 
-#define MT_TX_RING_BASE			MT_WFDMA1(0x300)
-#define MT_RX_EVENT_RING_BASE		MT_WFDMA1(0x500)
-
-#define MT_WFDMA1_TX_RING0_EXT_CTRL	MT_WFDMA1(0x600)
-#define MT_WFDMA1_TX_RING1_EXT_CTRL	MT_WFDMA1(0x604)
-#define MT_WFDMA1_TX_RING2_EXT_CTRL	MT_WFDMA1(0x608)
-#define MT_WFDMA1_TX_RING3_EXT_CTRL	MT_WFDMA1(0x60c)
-#define MT_WFDMA1_TX_RING4_EXT_CTRL	MT_WFDMA1(0x610)
-#define MT_WFDMA1_TX_RING5_EXT_CTRL	MT_WFDMA1(0x614)
-#define MT_WFDMA1_TX_RING6_EXT_CTRL	MT_WFDMA1(0x618)
-#define MT_WFDMA1_TX_RING7_EXT_CTRL	MT_WFDMA1(0x61c)
-
-#define MT_WFDMA1_TX_RING16_EXT_CTRL	MT_WFDMA1(0x640)
-#define MT_WFDMA1_TX_RING17_EXT_CTRL	MT_WFDMA1(0x644)
-#define MT_WFDMA1_TX_RING18_EXT_CTRL	MT_WFDMA1(0x648)
-#define MT_WFDMA1_TX_RING19_EXT_CTRL	MT_WFDMA1(0x64c)
-#define MT_WFDMA1_TX_RING20_EXT_CTRL	MT_WFDMA1(0x650)
-#define MT_WFDMA1_TX_RING21_EXT_CTRL	MT_WFDMA1(0x654)
-#define MT_WFDMA1_TX_RING22_EXT_CTRL	MT_WFDMA1(0x658)
-#define MT_WFDMA1_TX_RING23_EXT_CTRL	MT_WFDMA1(0x65c)
-
-#define MT_WFDMA1_RX_RING0_EXT_CTRL	MT_WFDMA1(0x680)
-#define MT_WFDMA1_RX_RING1_EXT_CTRL	MT_WFDMA1(0x684)
-#define MT_WFDMA1_RX_RING2_EXT_CTRL	MT_WFDMA1(0x688)
-#define MT_WFDMA1_RX_RING3_EXT_CTRL	MT_WFDMA1(0x68c)
-
 /* WFDMA CSR */
 #define MT_WFDMA_EXT_CSR_BASE		0xd7000
 #define MT_WFDMA_EXT_CSR(ofs)		(MT_WFDMA_EXT_CSR_BASE + (ofs))
 
-#define MT_INT_SOURCE_CSR		MT_WFDMA_EXT_CSR(0x10)
-#define MT_INT_MASK_CSR			MT_WFDMA_EXT_CSR(0x14)
-#define MT_INT_RX_DONE_DATA0		BIT(16)
-#define MT_INT_RX_DONE_DATA1		BIT(17)
-#define MT_INT_RX_DONE_WM		BIT(0)
-#define MT_INT_RX_DONE_WA		BIT(1)
-#define MT_INT_RX_DONE_WA_EXT		BIT(2)
-#define MT_INT_RX_DONE_ALL		(GENMASK(2, 0) | GENMASK(17, 16))
-#define MT_INT_TX_DONE_MCU_WA		BIT(15)
-#define MT_INT_TX_DONE_FWDL		BIT(26)
-#define MT_INT_TX_DONE_MCU_WM		BIT(27)
-#define MT_INT_TX_DONE_BAND0		BIT(30)
-#define MT_INT_TX_DONE_BAND1		BIT(31)
-
-#define MT_INT_BAND1_MASK		(MT_INT_RX_DONE_WA_EXT |	\
-					 MT_INT_TX_DONE_BAND1)
-
-#define MT_INT_MCU_CMD			BIT(29)
-
-#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WA |	\
-					 MT_INT_TX_DONE_MCU_WM |	\
-					 MT_INT_TX_DONE_FWDL)
-
 #define MT_WFDMA_HOST_CONFIG		MT_WFDMA_EXT_CSR(0x30)
 #define MT_WFDMA_HOST_CONFIG_PDMA_BAND	BIT(0)
 
 #define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
 
-#define MT_INT1_SOURCE_CSR		MT_WFDMA_EXT_CSR(0x88)
-#define MT_INT1_MASK_CSR		MT_WFDMA_EXT_CSR(0x8c)
-
-#define MT_PCIE_RECOG_ID		MT_WFDMA_EXT_CSR(0x90)
+#define MT_PCIE_RECOG_ID		0xd7090
 #define MT_PCIE_RECOG_ID_MASK		GENMASK(30, 0)
 #define MT_PCIE_RECOG_ID_SEM		BIT(31)
 
 /* WFDMA0 PCIE1 */
-#define MT_WFDMA0_PCIE1_BASE			0xd8000
-#define MT_WFDMA0_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+#define MT_WFDMA0_PCIE1_BASE		0xd8000
+#define MT_WFDMA0_PCIE1(ofs)		(MT_WFDMA0_PCIE1_BASE + (ofs))
 
-#define MT_WFDMA0_PCIE1_BUSY_ENA		MT_WFDMA0_PCIE1(0x13c)
+#define MT_WFDMA0_PCIE1_BUSY_ENA	MT_WFDMA0_PCIE1(0x13c)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
 
 /* WFDMA1 PCIE1 */
-#define MT_WFDMA1_PCIE1_BASE			0xd9000
-#define MT_WFDMA1_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+#define MT_WFDMA1_PCIE1_BASE		0xd9000
+#define MT_WFDMA1_PCIE1(ofs)		(MT_WFDMA1_PCIE1_BASE + (ofs))
 
-#define MT_WFDMA1_PCIE1_BUSY_ENA		MT_WFDMA1_PCIE1(0x13c)
+#define MT_WFDMA1_PCIE1_BUSY_ENA	MT_WFDMA1_PCIE1(0x13c)
 #define MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
 #define MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA1_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
 
-#define MT_TOP_RGU_BASE				0xf0000
-#define MT_TOP_PWR_CTRL				(MT_TOP_RGU_BASE + (0x0))
-#define MT_TOP_PWR_KEY				(0x5746 << 16)
-#define MT_TOP_PWR_SW_RST			BIT(0)
-#define MT_TOP_PWR_SW_PWR_ON			GENMASK(3, 2)
-#define MT_TOP_PWR_HW_CTRL			BIT(4)
-#define MT_TOP_PWR_PWR_ON			BIT(7)
+/* WFDMA COMMON */
+#define __RXQ(q)			((q) + __MT_MCUQ_MAX)
+#define __TXQ(q)			(__RXQ(q) + __MT_RXQ_MAX)
 
-#define MT_INFRA_CFG_BASE		0xf1000
-#define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
+#define MT_Q_ID(q)			(dev->q_id[(q)])
+#define MT_Q_BASE(q)			((dev->wfdma_mask >> (q)) & 0x1 ?	\
+					 MT_WFDMA1_BASE : MT_WFDMA0_BASE)
 
-#define MT_HIF_REMAP_L1			MT_INFRA(0x1ac)
+#define MT_MCUQ_ID(q)			MT_Q_ID(q)
+#define MT_TXQ_ID(q)			MT_Q_ID(__TXQ(q))
+#define MT_RXQ_ID(q)			MT_Q_ID(__RXQ(q))
+
+#define MT_MCUQ_RING_BASE(q)		(MT_Q_BASE(q) + 0x300)
+#define MT_TXQ_RING_BASE(q)		(MT_Q_BASE(__TXQ(q)) + 0x300)
+#define MT_RXQ_RING_BASE(q)		(MT_Q_BASE(__RXQ(q)) + 0x500)
+
+#define MT_MCUQ_EXT_CTRL(q)		(MT_Q_BASE(q) +	0x600 +	\
+					 MT_MCUQ_ID(q)* 0x4)
+#define MT_RXQ_EXT_CTRL(q)		(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
+					 MT_RXQ_ID(q)* 0x4)
+#define MT_TXQ_EXT_CTRL(q)		(MT_Q_BASE(__TXQ(q)) + 0x600 +	\
+					 MT_TXQ_ID(q)* 0x4)
+
+#define MT_INT_SOURCE_CSR		__REG(INT_SOURCE_CSR)
+#define MT_INT_MASK_CSR			__REG(INT_MASK_CSR)
+
+#define MT_INT1_SOURCE_CSR		__REG(INT1_SOURCE_CSR)
+#define MT_INT1_MASK_CSR		__REG(INT1_MASK_CSR)
+
+#define MT_INT_RX_DONE_BAND0		BIT(16)
+#define MT_INT_RX_DONE_BAND1		BIT(17)
+#define MT_INT_RX_DONE_WM		BIT(0)
+#define MT_INT_RX_DONE_WA		BIT(1)
+#define MT_INT_RX_DONE_WA_EXT		BIT(2)
+#define MT_INT_MCU_CMD			BIT(29)
+#define MT_INT_RX_DONE_BAND0_MT7916	BIT(22)
+#define MT_INT_RX_DONE_BAND1_MT7916	BIT(23)
+#define MT_INT_RX_DONE_WA_EXT_MT7916	BIT(3)
+
+#define MT_INT_RX(q)			(dev->q_int_mask[__RXQ(q)])
+#define MT_INT_TX_MCU(q)		(dev->q_int_mask[(q)])
+
+#define MT_INT_RX_DONE_MCU		(MT_INT_RX(MT_RXQ_MCU) |	\
+					 MT_INT_RX(MT_RXQ_MCU_WA))
+
+#define MT_INT_BAND0_RX_DONE		(MT_INT_RX(MT_RXQ_MAIN) |	\
+					 MT_INT_RX(MT_RXQ_MCU_WA))
+
+#define MT_INT_BAND1_RX_DONE		(MT_INT_RX(MT_RXQ_EXT) |	\
+					 MT_INT_RX(MT_RXQ_MCU_WA) |	\
+					 MT_INT_RX(MT_RXQ_EXT_WA))
+
+#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_MCU |		\
+					 MT_INT_BAND0_RX_DONE |		\
+					 MT_INT_BAND1_RX_DONE)
+
+#define MT_INT_TX_DONE_FWDL		BIT(26)
+#define MT_INT_TX_DONE_MCU_WM		BIT(27)
+#define MT_INT_TX_DONE_MCU_WA		BIT(15)
+#define MT_INT_TX_DONE_BAND0		BIT(30)
+#define MT_INT_TX_DONE_BAND1		BIT(31)
+#define MT_INT_TX_DONE_MCU_WA_MT7916	BIT(25)
+
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_MCU(MT_MCUQ_WA) |	\
+					 MT_INT_TX_MCU(MT_MCUQ_WM) |	\
+					 MT_INT_TX_MCU(MT_MCUQ_FWDL))
+
+#define MT_MCU_CMD			__REG(INT_MCU_CMD_SOURCE)
+#define MT_MCU_CMD_STOP_DMA_FW_RELOAD	BIT(1)
+#define MT_MCU_CMD_STOP_DMA		BIT(2)
+#define MT_MCU_CMD_RESET_DONE		BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
+#define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
+
+/* TOP RGU */
+#define MT_TOP_RGU_BASE			0x18000000
+#define MT_TOP_PWR_CTRL			(MT_TOP_RGU_BASE + (0x0))
+#define MT_TOP_PWR_KEY			(0x5746 << 16)
+#define MT_TOP_PWR_SW_RST		BIT(0)
+#define MT_TOP_PWR_SW_PWR_ON		GENMASK(3, 2)
+#define MT_TOP_PWR_HW_CTRL		BIT(4)
+#define MT_TOP_PWR_PWR_ON		BIT(7)
+
+/* l1/l2 remap */
+#define MT_HIF_REMAP_L1			0xf11ac
+#define MT_HIF_REMAP_L1_MT7916		0xfe260
 #define MT_HIF_REMAP_L1_MASK		GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
 #define MT_HIF_REMAP_BASE_L1		0xe0000
 
-#define MT_HIF_REMAP_L2			MT_INFRA(0x1b0)
+#define MT_HIF_REMAP_L2			0xf11b0
 #define MT_HIF_REMAP_L2_MASK		GENMASK(19, 0)
 #define MT_HIF_REMAP_L2_OFFSET		GENMASK(11, 0)
 #define MT_HIF_REMAP_L2_BASE		GENMASK(31, 12)
-#define MT_HIF_REMAP_BASE_L2		0x00000
+#define MT_HIF_REMAP_L2_MT7916		0x1b8
+#define MT_HIF_REMAP_L2_MASK_MT7916	GENMASK(31, 16)
+#define MT_HIF_REMAP_L2_OFFSET_MT7916	GENMASK(15, 0)
+#define MT_HIF_REMAP_L2_BASE_MT7916	GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L2_MT7916	0x40000
+
+#define MT_INFRA_BASE			0x18000000
+#define MT_WFSYS0_PHY_START		0x18400000
+#define MT_WFSYS1_PHY_START		0x18800000
+#define MT_WFSYS1_PHY_END		0x18bfffff
+#define MT_CBTOP1_PHY_START		0x70000000
+#define MT_CBTOP1_PHY_END		0x7fffffff
+#define MT_CBTOP2_PHY_START		0xf0000000
+#define MT_CBTOP2_PHY_END		0xffffffff
+
+/* FW MODE SYNC */
+#define MT_SWDEF_MODE			0x41f23c
+#define MT_SWDEF_MODE_MT7916		0x41143c
+#define MT_SWDEF_NORMAL_MODE		0
+#define MT_SWDEF_ICAP_MODE		1
+#define MT_SWDEF_SPECTRUM_MODE		2
 
 #define MT_DIC_CMD_REG_BASE		0x41f000
 #define MT_DIC_CMD_REG(ofs)		(MT_DIC_CMD_REG_BASE + (ofs))
@@ -540,13 +698,7 @@
 #define MT_CPU_UTIL_PEAK_IDLE_CNT	MT_CPU_UTIL(0x0c)
 #define MT_CPU_UTIL_CTRL		MT_CPU_UTIL(0x1c)
 
-#define MT_SWDEF_BASE			0x41f200
-#define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
-#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
-#define MT_SWDEF_NORMAL_MODE		0
-#define MT_SWDEF_ICAP_MODE		1
-#define MT_SWDEF_SPECTRUM_MODE		2
-
+/* LED */
 #define MT_LED_TOP_BASE			0x18013000
 #define MT_LED_PHYS(_n)			(MT_LED_TOP_BASE + (_n))
 
@@ -561,6 +713,11 @@
 
 #define MT_LED_EN(_n)			MT_LED_PHYS(0x40 + ((_n) * 4))
 
+#define MT_LED_GPIO_MUX2                0x70005058 /* GPIO 18 */
+#define MT_LED_GPIO_MUX3                0x7000505C /* GPIO 26 */
+#define MT_LED_GPIO_SEL_MASK            GENMASK(11, 8)
+
+/* MT TOP */
 #define MT_TOP_BASE			0x18060000
 #define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
 
@@ -572,22 +729,18 @@
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
 
-#define MT_LED_GPIO_MUX2                0x70005058 /* GPIO 18 */
-#define MT_LED_GPIO_MUX3                0x7000505C /* GPIO 26 */
-#define MT_LED_GPIO_SEL_MASK            GENMASK(11, 8)
-
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
 
-#define MT_PCIE1_MAC_BASE		0x74020000
-#define MT_PCIE1_MAC(ofs)		(MT_PCIE1_MAC_BASE + (ofs))
-#define MT_PCIE1_MAC_INT_ENABLE		MT_PCIE1_MAC(0x188)
-
+/* PCIE MAC */
 #define MT_PCIE_MAC_BASE		0x74030000
 #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
 #define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
 
+#define MT_PCIE1_MAC_INT_ENABLE		0x74020188
+#define MT_PCIE1_MAC_INT_ENABLE_MT7916	0x74090188
+
 #define MT_WF_IRPI_BASE			0x83006000
 #define MT_WF_IRPI(ofs)			(MT_WF_IRPI_BASE + ((ofs) << 16))
 
@@ -601,7 +754,7 @@
 
 #define MT_WF_PHY_RXTD12(_phy)		MT_WF_PHY(0x8230 + ((_phy) << 16))
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
-#define MT_WF_PHY_RXTD12_IRPI_SW_CLR	BIT(29)
+#define MT_WF_PHY_RXTD12_IRPI_SW_CLR		BIT(29)
 
 #define MT_MCU_WM_CIRQ_BASE			0x89010000
 #define MT_MCU_WM_CIRQ(ofs)			(MT_MCU_WM_CIRQ_BASE + (ofs))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index af80c2c..8300f26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -23,30 +23,16 @@ struct reg_band {
 	u32 band[2];
 };
 
-#define REG_BAND(_reg) \
-	{ .band[0] = MT_##_reg(0), .band[1] = MT_##_reg(1) }
-#define REG_BAND_IDX(_reg, _idx) \
-	{ .band[0] = MT_##_reg(0, _idx), .band[1] = MT_##_reg(1, _idx) }
-
-static const struct reg_band reg_backup_list[] = {
-	REG_BAND_IDX(AGG_PCR0, 0),
-	REG_BAND_IDX(AGG_PCR0, 1),
-	REG_BAND_IDX(AGG_AWSCR0, 0),
-	REG_BAND_IDX(AGG_AWSCR0, 1),
-	REG_BAND_IDX(AGG_AWSCR0, 2),
-	REG_BAND_IDX(AGG_AWSCR0, 3),
-	REG_BAND(AGG_MRCR),
-	REG_BAND(TMAC_TFCR0),
-	REG_BAND(TMAC_TCR0),
-	REG_BAND(AGG_ATCR1),
-	REG_BAND(AGG_ATCR3),
-	REG_BAND(TMAC_TRCR0),
-	REG_BAND(TMAC_ICR0),
-	REG_BAND_IDX(ARB_DRNGR0, 0),
-	REG_BAND_IDX(ARB_DRNGR0, 1),
-	REG_BAND(WF_RFCR),
-	REG_BAND(WF_RFCR1),
-};
+#define REG_BAND(_list, _reg) \
+		{ _list.band[0] = MT_##_reg(0);	\
+		  _list.band[1] = MT_##_reg(1); }
+#define REG_BAND_IDX(_list, _reg, _idx) \
+		{ _list.band[0] = MT_##_reg(0, _idx);	\
+		  _list.band[1] = MT_##_reg(1, _idx); }
+
+#define TM_REG_MAX_ID	17
+static struct reg_band reg_backup_list[TM_REG_MAX_ID];
+
 
 static int
 mt7915_tm_set_tx_power(struct mt7915_phy *phy)
@@ -355,6 +341,24 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 	u32 *b = phy->test.reg_backup;
 	int i;
 
+	REG_BAND_IDX(reg_backup_list[0], AGG_PCR0, 0);
+	REG_BAND_IDX(reg_backup_list[1], AGG_PCR0, 1);
+	REG_BAND_IDX(reg_backup_list[2], AGG_AWSCR0, 0);
+	REG_BAND_IDX(reg_backup_list[3], AGG_AWSCR0, 1);
+	REG_BAND_IDX(reg_backup_list[4], AGG_AWSCR0, 2);
+	REG_BAND_IDX(reg_backup_list[5], AGG_AWSCR0, 3);
+	REG_BAND(reg_backup_list[6], AGG_MRCR);
+	REG_BAND(reg_backup_list[7], TMAC_TFCR0);
+	REG_BAND(reg_backup_list[8], TMAC_TCR0);
+	REG_BAND(reg_backup_list[9], AGG_ATCR1);
+	REG_BAND(reg_backup_list[10], AGG_ATCR3);
+	REG_BAND(reg_backup_list[11], TMAC_TRCR0);
+	REG_BAND(reg_backup_list[12], TMAC_ICR0);
+	REG_BAND_IDX(reg_backup_list[13], ARB_DRNGR0, 0);
+	REG_BAND_IDX(reg_backup_list[14], ARB_DRNGR0, 1);
+	REG_BAND(reg_backup_list[15], WF_RFCR);
+	REG_BAND(reg_backup_list[16], WF_RFCR1);
+
 	if (phy->mt76->test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
 			mt76_wr(dev, reg_backup_list[i].band[ext_phy], b[i]);
@@ -725,6 +729,7 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	void *rx, *rssi;
 	u16 fcs_err;
 	int i;
+	u32 cnt;
 
 	rx = nla_nest_start(msg, MT76_TM_STATS_ATTR_LAST_RX);
 	if (!rx)
@@ -768,8 +773,10 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 
 	nla_nest_end(msg, rx);
 
-	fcs_err = mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
-				 MT_MIB_SDR3_FCS_ERR_MASK);
+	cnt = mt76_rr(dev, MT_MIB_SDR3(ext_phy));
+	fcs_err = is_mt7915(&dev->mt76) ? FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
+
 	q = ext_phy ? MT_RXQ_EXT : MT_RXQ_MAIN;
 	mphy->test.rx_stats.packets[q] += fcs_err;
 	mphy->test.rx_stats.fcs_error[q] += fcs_err;
-- 
2.18.0

