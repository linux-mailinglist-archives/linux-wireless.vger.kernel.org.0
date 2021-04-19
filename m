Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AB3645E7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhDSOVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 10:21:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54674 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239050AbhDSOVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 10:21:39 -0400
X-UUID: 927164bb07034f22b162b68cc5a75d08-20210419
X-UUID: 927164bb07034f22b162b68cc5a75d08-20210419
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1902725450; Mon, 19 Apr 2021 22:21:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 22:21:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 22:21:00 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 3/6] mt76: mt7921: introduce mt7921_dma_{enable,disable} utilities
Date:   Mon, 19 Apr 2021 22:20:56 +0800
Message-ID: <1618842059-8192-4-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618842059-8192-1-git-send-email-sean.wang@mediatek.com>
References: <1618842059-8192-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D313CF67F8EEFB128D56CE4EEE4ECAE5CBE9FEB55ED205ACA51F34D28659EEE02000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce mt7921_dma_enable and mt7921_dma_disable utilities routine in
order for code reusing between mt7921_dma_reset and mt7921_dma_init.
This is a preliminary patch to reset dma during device driver_own
request.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 108 ++++++------------
 1 file changed, 35 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index af4b6cf38929..fb7f98d92377 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -221,18 +221,8 @@ static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
 }
 
-static int mt7921_dmashdl_disabled(struct mt7921_dev *dev)
+static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
 {
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0, MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
-	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
-
-	return 0;
-}
-
-static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
-{
-	int i;
-
 	if (force) {
 		/* reset */
 		mt76_clear(dev, MT_WFDMA0_RST,
@@ -244,6 +234,11 @@ static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 			 MT_WFDMA0_RST_LOGIC_RST);
 	}
 
+	/* disable dmashdl */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
+		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
+	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+
 	/* disable WFDMA0 */
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
 		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
@@ -257,18 +252,11 @@ static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
 		return -ETIMEDOUT;
 
-	/* reset hw queues */
-	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
-
-	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
-
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
-
-	mt76_tx_status_check(&dev->mt76, NULL, true);
+	return 0;
+}
 
+static int mt7921_dma_enable(struct mt7921_dev *dev)
+{
 	/* configure perfetch settings */
 	mt7921_dma_prefetch(dev);
 
@@ -300,6 +288,29 @@ static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 	return 0;
 }
 
+static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
+{
+	int i, err;
+
+	err = mt7921_dma_disable(dev, force);
+	if (err)
+		return err;
+
+	/* reset hw queues */
+	for (i = 0; i < __MT_TXQ_MAX; i++)
+		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+
+	mt76_tx_status_check(&dev->mt76, NULL, true);
+
+	return mt7921_dma_enable(dev);
+}
+
 int mt7921_wfsys_reset(struct mt7921_dev *dev)
 {
 	mt76_set(dev, 0x70002600, BIT(0));
@@ -362,32 +373,10 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 
 	mt76_dma_attach(&dev->mt76);
 
-	/* reset */
-	mt76_clear(dev, MT_WFDMA0_RST,
-		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		   MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_set(dev, MT_WFDMA0_RST,
-		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		 MT_WFDMA0_RST_LOGIC_RST);
-
-	ret = mt7921_dmashdl_disabled(dev);
+	ret = mt7921_dma_disable(dev, true);
 	if (ret)
 		return ret;
 
-	/* disable WFDMA0 */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	mt76_poll(dev, MT_WFDMA0_GLO_CFG,
-		  MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-		  MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000);
-
 	/* init tx queue */
 	ret = mt7921_init_tx_queues(&dev->phy, MT7921_TXQ_BAND0,
 				    MT7921_TX_RING_SIZE);
@@ -439,34 +428,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 			  mt7921_poll_tx, NAPI_POLL_WEIGHT);
 	napi_enable(&dev->mt76.tx_napi);
 
-	/* configure perfetch settings */
-	mt7921_dma_prefetch(dev);
-
-	/* reset dma idx */
-	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
-
-	/* configure delay interrupt */
-	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
-
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_WB_DDONE |
-		 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
-		 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
-		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-
-	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
-
-	/* enable interrupts for TX/RX rings */
-	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-			  MT_INT_MCU_CMD);
-	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
-
-	return 0;
+	return mt7921_dma_enable(dev);
 }
 
 void mt7921_dma_cleanup(struct mt7921_dev *dev)
-- 
2.25.1

