Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783B70C58C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEVSuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjEVSuE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 14:50:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC008FE
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 11:50:02 -0700 (PDT)
X-UUID: 7203c1faf8d111ed9cb5633481061a41-20230523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ef4qPoGVGq/NhWkYARZ3jmn0yyOwovNGtHBzI2nE50g=;
        b=dD9vTBD8NIyAg+NWryp0Rdh7T6rIPO7jZjSNNQsIE/eAPU+sYvVjJ4rp6woJ9W+8v+MZrQf0T3yH7nZueYS6XLMueuRCl7g3LBQffOg/TPsSi5DDPzai2DlaEOMIVN6LR8MtZsIXXF+le7zqN9eUiAfNq6SlFueVOc6wPbiN/is=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:732f6947-1654-4e81-b44d-a7c56f15ede1,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:adddaac1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 7203c1faf8d111ed9cb5633481061a41-20230523
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1275099113; Tue, 23 May 2023 02:49:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 02:49:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 May 2023 02:49:55 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] wifi: mt76: mt7915: disable WFDMA Tx/Rx during SER recovery
Date:   Tue, 23 May 2023 02:49:53 +0800
Message-ID: <eee863c057264ccc09690626cae80cc147fce3ae.1684781217.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Stop WFDMA transaction to avoid potential unexpected issue while doing
system recovery.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - add missing MT_PCIE1_MAC_INT_ENABLE_MT7916
---
 drivers/net/wireless/mediatek/mt76/dma.c      |   6 +
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 148 ++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  25 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   1 +
 4 files changed, 107 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 465190ebaf1c..05d9ab3ce819 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -466,6 +466,9 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 	struct mt76_queue_buf buf = {};
 	dma_addr_t addr;
 
+	if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+		goto error;
+
 	if (q->queued + 1 >= q->ndesc - 1)
 		goto error;
 
@@ -507,6 +510,9 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	dma_addr_t addr;
 	u8 *txwi;
 
+	if (test_bit(MT76_RESET, &dev->phy.state))
+		goto free_skb;
+
 	t = mt76_get_txwi(dev);
 	if (!t)
 		goto free_skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 43a5456d4b97..f2b410b46eea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -250,12 +250,90 @@ static void mt7915_dma_disable(struct mt7915_dev *dev, bool rst)
 	}
 }
 
-static int mt7915_dma_enable(struct mt7915_dev *dev)
+int mt7915_dma_start(struct mt7915_dev *dev, bool reset, bool wed_reset)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	u32 hif1_ofs = 0;
 	u32 irq_mask;
 
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	/* enable wpdma tx/rx */
+	if (!reset) {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG,
+			MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+			MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+		if (is_mt7915(mdev))
+			mt76_set(dev, MT_WFDMA1_GLO_CFG,
+				MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+				MT_WFDMA1_GLO_CFG_RX_DMA_EN |
+				MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+				MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
+
+		if (dev->hif2) {
+			mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+				MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+				MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+				MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+				MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+			if (is_mt7915(mdev))
+				mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
+					MT_WFDMA1_GLO_CFG_TX_DMA_EN |
+					MT_WFDMA1_GLO_CFG_RX_DMA_EN |
+					MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+					MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
+
+			mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+				MT_WFDMA_HOST_CONFIG_PDMA_BAND);
+		}
+	}
+
+	/* enable interrupts for TX/RX rings */
+	irq_mask = MT_INT_RX_DONE_MCU |
+		   MT_INT_TX_DONE_MCU |
+		   MT_INT_MCU_CMD;
+
+	if (!dev->phy.mt76->band_idx)
+		irq_mask |= MT_INT_BAND0_RX_DONE;
+
+	if (dev->dbdc_support || dev->phy.mt76->band_idx)
+		irq_mask |= MT_INT_BAND1_RX_DONE;
+
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && wed_reset) {
+		u32 wed_irq_mask = irq_mask;
+		int ret;
+
+		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
+		if (!is_mt7986(&dev->mt76))
+			mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
+		else
+			mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
+
+		ret = mt7915_mcu_wed_enable_rx_stats(dev);
+		if (ret)
+			return ret;
+
+		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
+	}
+
+	irq_mask = reset ? MT_INT_MCU_CMD : irq_mask;
+
+	mt7915_irq_enable(dev, irq_mask);
+	mt7915_irq_disable(dev, 0);
+
+	return 0;
+}
+
+static int mt7915_dma_enable(struct mt7915_dev *dev, bool reset)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 hif1_ofs = 0;
+
 	if (dev->hif2)
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 
@@ -322,69 +400,7 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 	mt76_poll(dev, MT_WFDMA_EXT_CSR_HIF_MISC,
 		  MT_WFDMA_EXT_CSR_HIF_MISC_BUSY, 0, 1000);
 
-	/* set WFDMA Tx/Rx */
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	if (is_mt7915(mdev))
-		mt76_set(dev, MT_WFDMA1_GLO_CFG,
-			 MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA1_GLO_CFG_RX_DMA_EN |
-			 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
-			 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
-
-	if (dev->hif2) {
-		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-			 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-		if (is_mt7915(mdev))
-			mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
-				 MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-				 MT_WFDMA1_GLO_CFG_RX_DMA_EN |
-				 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
-				 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
-
-		mt76_set(dev, MT_WFDMA_HOST_CONFIG,
-			 MT_WFDMA_HOST_CONFIG_PDMA_BAND);
-	}
-
-	/* enable interrupts for TX/RX rings */
-	irq_mask = MT_INT_RX_DONE_MCU |
-		   MT_INT_TX_DONE_MCU |
-		   MT_INT_MCU_CMD;
-
-	if (!dev->phy.mt76->band_idx)
-		irq_mask |= MT_INT_BAND0_RX_DONE;
-
-	if (dev->dbdc_support || dev->phy.mt76->band_idx)
-		irq_mask |= MT_INT_BAND1_RX_DONE;
-
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
-		u32 wed_irq_mask = irq_mask;
-		int ret;
-
-		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
-		if (!is_mt7986(&dev->mt76))
-			mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
-		else
-			mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
-
-		ret = mt7915_mcu_wed_enable_rx_stats(dev);
-		if (ret)
-			return ret;
-
-		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
-	}
-
-	mt7915_irq_enable(dev, irq_mask);
-
-	return 0;
+	return mt7915_dma_start(dev, reset, true);
 }
 
 int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
@@ -560,7 +576,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 			  mt7915_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
-	mt7915_dma_enable(dev);
+	mt7915_dma_enable(dev, false);
 
 	return 0;
 }
@@ -642,7 +658,7 @@ int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 		mt76_rmw(dev, MT_WFDMA0_EXT0_CFG, MT_WFDMA0_EXT0_RXWB_KEEP,
 			 MT_WFDMA0_EXT0_RXWB_KEEP);
 
-	mt7915_dma_enable(dev);
+	mt7915_dma_enable(dev, !force);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9b2ccd99854e..4f9e5ec0cef8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1407,8 +1407,12 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 
 	if (dev_is_pci(mdev->dev)) {
 		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
-		if (dev->hif2)
-			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0x0);
+		if (dev->hif2) {
+			if (is_mt7915(mdev))
+				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0x0);
+			else
+				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE_MT7916, 0x0);
+		}
 	}
 
 	set_bit(MT76_RESET, &dev->mphy.state);
@@ -1458,8 +1462,12 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	}
 	if (dev_is_pci(mdev->dev)) {
 		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
-		if (dev->hif2)
-			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+		if (dev->hif2) {
+			if (is_mt7915(mdev))
+				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+			else
+				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE_MT7916, 0xff);
+		}
 	}
 
 	/* load firmware */
@@ -1629,6 +1637,12 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		mt7915_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
 	}
 
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7915_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	/* enable DMA Tx/Rx and interrupt */
+	mt7915_dma_start(dev, false, false);
+
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_RESET, &dev->mphy.state);
 	if (phy2)
@@ -1643,9 +1657,6 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	tasklet_schedule(&dev->mt76.irq_tasklet);
 
-	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
-	mt7915_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
-
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
 	local_bh_disable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3053f4abf7db..145f89a19443 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -466,6 +466,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
 int mt7915_dma_reset(struct mt7915_dev *dev, bool force);
+int mt7915_dma_start(struct mt7915_dev *dev, bool reset, bool wed_reset);
 int mt7915_txbf_init(struct mt7915_dev *dev);
 void mt7915_init_txpower(struct mt7915_dev *dev,
 			 struct ieee80211_supported_band *sband);
-- 
2.18.0

