Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634197D0D2C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376874AbjJTKbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjJTKbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:31:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5ED46
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:31:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7348C433C8;
        Fri, 20 Oct 2023 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797907;
        bh=T6qzb2yXI4dbQOR9ul/7XHJh87gJghJL+h5cFHHLxio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsIvGi7nonWtscoVmTYlEJDU/edlmEKuDimloQGshjQrTjMFii6gFCUtLVBtRWKaZ
         GBoKV4dNpM+h99FO2cNw3nhvNGznFhJYwxds6GOIVBKC01JTOgrywWgfaalZEQrRi5
         A4IiynaPCPzdcQ31GI1GbapsBHzdI/j0OA0hEIT5gItHvUncgp5DI5AekCaC2AwMGy
         Kc8R8pa2iXM1NPIdZ6+jzaUqDapF6gfTqDxq12Qd7AucJCTX2GB68QwWiFgP9Yld8K
         4Hnn0KVluVDQc8MU5BWMT/k7SWu9xL1eTYzB7V5wxjy2ZR3SbJIQA81gpC4ZpJx+Og
         c94ulKUbNPN6g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 07/13] wifi: mt76: mt7996: add wed tx support
Date:   Fri, 20 Oct 2023 12:30:54 +0200
Message-ID: <3acb1c6d71291e141f8de83c2ca1a88131e81054.1697797423.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697797422.git.lorenzo@kernel.org>
References: <cover.1697797422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

Similar to MT7915, enable Wireless Ethernet Ditpatcher for MT7996
to offload traffic received from the LAN nic and transmitted on the
WLAN one

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |   9 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  11 ++
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  76 ++++++--
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  30 ++-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  31 +++-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  42 +++++
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 172 ++++++++++++++++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  12 +-
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  61 +++++--
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |   5 +
 10 files changed, 383 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index d779ec57b95e..64027572a5e6 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -988,10 +988,13 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 		page_pool_destroy(q->page_pool);
 	}
 
-	mt76_free_pending_txwi(dev);
-	mt76_free_pending_rxwi(dev);
-
 	if (mtk_wed_device_active(&dev->mmio.wed))
 		mtk_wed_device_detach(&dev->mmio.wed);
+
+	if (mtk_wed_device_active(&dev->mmio.wed_hif2))
+		mtk_wed_device_detach(&dev->mmio.wed_hif2);
+
+	mt76_free_pending_txwi(dev);
+	mt76_free_pending_rxwi(dev);
 }
 EXPORT_SYMBOL_GPL(mt76_dma_cleanup);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fa33ecfbf72d..6fbcdfa187be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -107,6 +107,16 @@ enum mt76_rxq_id {
 	MT_RXQ_MAIN_WA,
 	MT_RXQ_BAND2,
 	MT_RXQ_BAND2_WA,
+	MT_RXQ_RRO_BAND0,
+	MT_RXQ_RRO_BAND1,
+	MT_RXQ_RRO_BAND2,
+	MT_RXQ_MSDU_PAGE_BAND0,
+	MT_RXQ_MSDU_PAGE_BAND1,
+	MT_RXQ_MSDU_PAGE_BAND2,
+	MT_RXQ_TXFREE_BAND0,
+	MT_RXQ_TXFREE_BAND1,
+	MT_RXQ_TXFREE_BAND2,
+	MT_RXQ_RRO_IND,
 	__MT_RXQ_MAX
 };
 
@@ -604,6 +614,7 @@ struct mt76_mmio {
 	u32 irqmask;
 
 	struct mtk_wed_device wed;
+	struct mtk_wed_device wed_hif2;
 	struct completion wed_reset;
 	struct completion wed_reset_complete;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index b33346360075..72912f376bc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -7,6 +7,26 @@
 #include "../dma.h"
 #include "mac.h"
 
+int mt7996_init_tx_queues(struct mt7996_phy *phy, int idx, int n_desc,
+			  int ring_base, struct mtk_wed_device *wed)
+{
+	struct mt7996_dev *dev = phy->dev;
+	u32 flags = 0;
+
+	if (mtk_wed_device_active(wed)) {
+		ring_base += MT_TXQ_ID(0) * MT_RING_SIZE;
+		idx -= MT_TXQ_ID(0);
+
+		if (phy->mt76->band_idx == MT_BAND2)
+			flags = MT_WED_Q_TX(0);
+		else
+			flags = MT_WED_Q_TX(idx);
+	}
+
+	return mt76_connac_init_tx_queues(phy->mt76, idx, n_desc,
+					  ring_base, wed, flags);
+}
+
 static int mt7996_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct mt7996_dev *dev;
@@ -128,7 +148,7 @@ static void mt7996_dma_disable(struct mt7996_dev *dev, bool reset)
 	}
 }
 
-void mt7996_dma_start(struct mt7996_dev *dev, bool reset)
+void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 {
 	u32 hif1_ofs = 0;
 	u32 irq_mask;
@@ -153,11 +173,7 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset)
 	}
 
 	/* enable interrupts for TX/RX rings */
-	irq_mask = MT_INT_MCU_CMD;
-	if (reset)
-		goto done;
-
-	irq_mask = MT_INT_RX_DONE_MCU | MT_INT_TX_DONE_MCU;
+	irq_mask = MT_INT_MCU_CMD | MT_INT_RX_DONE_MCU | MT_INT_TX_DONE_MCU;
 
 	if (!dev->mphy.band_idx)
 		irq_mask |= MT_INT_BAND0_RX_DONE;
@@ -168,7 +184,16 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset)
 	if (dev->tbtc_support)
 		irq_mask |= MT_INT_BAND2_RX_DONE;
 
-done:
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && wed_reset) {
+		u32 wed_irq_mask = irq_mask;
+
+		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
+		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
+		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
+	}
+
+	irq_mask = reset ? MT_INT_MCU_CMD : irq_mask;
+
 	mt7996_irq_enable(dev, irq_mask);
 	mt7996_irq_disable(dev, 0);
 }
@@ -243,15 +268,16 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 		 */
 		mt76_set(dev, MT_WFDMA0_RX_INT_PCIE_SEL,
 			 MT_WFDMA0_RX_INT_SEL_RING3);
-
-		/* TODO: redirect rx ring6 interrupt to pcie0 for wed function */
 	}
 
-	mt7996_dma_start(dev, reset);
+	mt7996_dma_start(dev, reset, true);
 }
 
 int mt7996_dma_init(struct mt7996_dev *dev)
 {
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	struct mtk_wed_device *wed_hif2 = &dev->mt76.mmio.wed_hif2;
+	u32 rx_base;
 	u32 hif1_ofs = 0;
 	int ret;
 
@@ -265,10 +291,11 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	mt7996_dma_disable(dev, true);
 
 	/* init tx queue */
-	ret = mt76_connac_init_tx_queues(dev->phy.mt76,
-					 MT_TXQ_ID(dev->mphy.band_idx),
-					 MT7996_TX_RING_SIZE,
-					 MT_TXQ_RING_BASE(0), NULL, 0);
+	ret = mt7996_init_tx_queues(&dev->phy,
+				    MT_TXQ_ID(dev->mphy.band_idx),
+				    MT7996_TX_RING_SIZE,
+				    MT_TXQ_RING_BASE(0),
+				    wed);
 	if (ret)
 		return ret;
 
@@ -315,6 +342,11 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		return ret;
 
 	/* rx data queue for band0 and band1 */
+	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed)) {
+		dev->mt76.q_rx[MT_RXQ_MAIN].flags = MT_WED_Q_RX(0);
+		dev->mt76.q_rx[MT_RXQ_MAIN].wed = wed;
+	}
+
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
 			       MT_RXQ_ID(MT_RXQ_MAIN),
 			       MT7996_RX_RING_SIZE,
@@ -324,6 +356,11 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		return ret;
 
 	/* tx free notify event from WA for band0 */
+	if (mtk_wed_device_active(wed)) {
+		dev->mt76.q_rx[MT_RXQ_MAIN_WA].flags = MT_WED_Q_TXFREE;
+		dev->mt76.q_rx[MT_RXQ_MAIN_WA].wed = wed;
+	}
+
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN_WA],
 			       MT_RXQ_ID(MT_RXQ_MAIN_WA),
 			       MT7996_RX_MCU_RING_SIZE,
@@ -334,17 +371,26 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 
 	if (dev->tbtc_support || dev->mphy.band_idx == MT_BAND2) {
 		/* rx data queue for band2 */
+		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND2) + hif1_ofs;
+		if (mtk_wed_device_active(wed))
+			rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND2);
+
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND2],
 				       MT_RXQ_ID(MT_RXQ_BAND2),
 				       MT7996_RX_RING_SIZE,
 				       MT_RX_BUF_SIZE,
-				       MT_RXQ_RING_BASE(MT_RXQ_BAND2) + hif1_ofs);
+				       rx_base);
 		if (ret)
 			return ret;
 
 		/* tx free notify event from WA for band2
 		 * use pcie0's rx ring3, but, redirect pcie0 rx ring3 interrupt to pcie1
 		 */
+		if (mtk_wed_device_active(wed_hif2)) {
+			dev->mt76.q_rx[MT_RXQ_BAND2_WA].flags = MT_WED_Q_TXFREE;
+			dev->mt76.q_rx[MT_RXQ_BAND2_WA].wed = wed_hif2;
+		}
+
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND2_WA],
 				       MT_RXQ_ID(MT_RXQ_BAND2_WA),
 				       MT7996_RX_MCU_RING_SIZE,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index b09ae6cc6eb4..e19c8fb71609 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -156,7 +156,7 @@ mt7996_regd_notifier(struct wiphy *wiphy,
 }
 
 static void
-mt7996_init_wiphy(struct ieee80211_hw *hw)
+mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 {
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt76_dev *mdev = &phy->dev->mt76;
@@ -168,6 +168,8 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 	hw->max_rx_aggregation_subframes = max_subframes;
 	hw->max_tx_aggregation_subframes = max_subframes;
 	hw->netdev_features = NETIF_F_RXCSUM;
+	if (mtk_wed_device_active(wed))
+		hw->netdev_features |= NETIF_F_HW_TC;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
@@ -356,6 +358,7 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	struct mt76_phy *mphy;
 	u32 mac_ofs, hif1_ofs = 0;
 	int ret;
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 
 	if (band != MT_BAND1 && band != MT_BAND2)
 		return 0;
@@ -367,8 +370,10 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	if (phy)
 		return 0;
 
-	if (band == MT_BAND2 && dev->hif2)
+	if (band == MT_BAND2 && dev->hif2) {
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+		wed = &dev->mt76.mmio.wed_hif2;
+	}
 
 	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7996_ops, band);
 	if (!mphy)
@@ -401,12 +406,12 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	mt76_eeprom_override(mphy);
 
 	/* init wiphy according to mphy and phy */
-	mt7996_init_wiphy(mphy->hw);
-	ret = mt76_connac_init_tx_queues(phy->mt76,
-					 MT_TXQ_ID(band),
-					 MT7996_TX_RING_SIZE,
-					 MT_TXQ_RING_BASE(band) + hif1_ofs,
-					 NULL, 0);
+	mt7996_init_wiphy(mphy->hw, wed);
+	ret = mt7996_init_tx_queues(mphy->priv,
+				    MT_TXQ_ID(band),
+				    MT7996_TX_RING_SIZE,
+				    MT_TXQ_RING_BASE(band) + hif1_ofs,
+				    wed);
 	if (ret)
 		goto error;
 
@@ -419,6 +424,13 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	if (ret)
 		goto error;
 
+	if (wed == &dev->mt76.mmio.wed_hif2 && mtk_wed_device_active(wed)) {
+		u32 irq_mask = dev->mt76.mmio.irqmask | MT_INT_TX_DONE_BAND2;
+
+		mt76_wr(dev, MT_INT1_MASK_CSR, irq_mask);
+		mtk_wed_device_start(&dev->mt76.mmio.wed_hif2, irq_mask);
+	}
+
 	return 0;
 
 error:
@@ -890,7 +902,7 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	mt7996_init_wiphy(hw);
+	mt7996_init_wiphy(hw, &dev->mt76.mmio.wed);
 
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 04540833485f..fd0f48d7cb91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -996,6 +996,29 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
+u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
+{
+	struct mt76_connac_fw_txp *txp = ptr + MT_TXD_SIZE;
+	__le32 *txwi = ptr;
+	u32 val;
+
+	memset(ptr, 0, MT_TXD_SIZE + sizeof(*txp));
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, MT_TXD_SIZE) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CT);
+	txwi[0] = cpu_to_le32(val);
+
+	val = BIT(31) |
+	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3);
+	txwi[1] = cpu_to_le32(val);
+
+	txp->token = cpu_to_le16(token_id);
+	txp->nbuf = 1;
+	txp->buf[0] = cpu_to_le32(phys + MT_TXD_SIZE + sizeof(*txp));
+
+	return MT_TXD_SIZE + sizeof(*txp);
+}
+
 static void
 mt7996_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
 {
@@ -1403,6 +1426,12 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed_hif2) &&
+		    q == MT_RXQ_TXFREE_BAND2) {
+			dev_kfree_skb(skb);
+			break;
+		}
+
 		mt7996_mac_tx_free(dev, skb->data, skb->len);
 		napi_consume_skb(skb, 1);
 		break;
@@ -1877,7 +1906,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	mt7996_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
 
 	/* enable DMA Tx/Tx and interrupt */
-	mt7996_dma_start(dev, false);
+	mt7996_dma_start(dev, false, false);
 
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_RESET, &dev->mphy.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 09c7a28a3d51..f074616c7007 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1388,6 +1388,44 @@ mt7996_set_radar_background(struct ieee80211_hw *hw,
 	return ret;
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+static int
+mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     struct net_device_path_ctx *ctx,
+			     struct net_device_path *path)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+
+	if (phy != &dev->phy && phy->mt76->band_idx == MT_BAND2)
+		wed = &dev->mt76.mmio.wed_hif2;
+
+	if (!mtk_wed_device_active(wed))
+		return -ENODEV;
+
+	if (msta->wcid.idx > MT7996_WTBL_STA)
+		return -EIO;
+
+	path->type = DEV_PATH_MTK_WDMA;
+	path->dev = ctx->dev;
+	path->mtk_wdma.wdma_idx = wed->wdma_idx;
+	path->mtk_wdma.bss = mvif->mt76.idx;
+	path->mtk_wdma.queue = 0;
+	path->mtk_wdma.wcid = msta->wcid.idx;
+
+	path->mtk_wdma.amsdu = mtk_wed_is_amsdu_supported(wed);
+	ctx->dev = NULL;
+
+	return 0;
+}
+
+#endif
+
 const struct ieee80211_ops mt7996_ops = {
 	.tx = mt7996_tx,
 	.start = mt7996_start,
@@ -1432,4 +1470,8 @@ const struct ieee80211_ops mt7996_ops = {
 	.sta_add_debugfs = mt7996_sta_add_debugfs,
 #endif
 	.set_radar_background = mt7996_set_radar_background,
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	.net_fill_forward_path = mt7996_net_fill_forward_path,
+	.net_setup_tc = mt76_net_setup_tc,
+#endif
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 3a591a7b47ae..ae029ae9969d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -10,6 +10,10 @@
 #include "mt7996.h"
 #include "mac.h"
 #include "../trace.h"
+#include "../dma.h"
+
+static bool wed_enable;
+module_param(wed_enable, bool, 0644);
 
 static const struct __base mt7996_reg_base[] = {
 	[WF_AGG_BASE]		= { { 0x820e2000, 0x820f2000, 0x830e2000 } },
@@ -191,6 +195,106 @@ static u32 mt7996_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, __mt7996_reg_addr(dev, offset), mask, val);
 }
 
+int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
+			 bool hif2, int *irq)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	struct pci_dev *pci_dev = pdev_ptr;
+	u32 hif1_ofs = 0;
+	int ret;
+
+	if (!wed_enable)
+		return 0;
+
+	hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	if (hif2)
+		wed = &dev->mt76.mmio.wed_hif2;
+
+	wed->wlan.pci_dev = pci_dev;
+	wed->wlan.bus_type = MTK_WED_BUS_PCIE;
+
+	wed->wlan.base = devm_ioremap(dev->mt76.dev,
+				      pci_resource_start(pci_dev, 0),
+				      pci_resource_len(pci_dev, 0));
+	wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
+
+	if (hif2) {
+		wed->wlan.wpdma_int = wed->wlan.phy_base +
+				      MT_INT_PCIE1_SOURCE_CSR_EXT;
+		wed->wlan.wpdma_mask = wed->wlan.phy_base +
+				       MT_INT_PCIE1_MASK_CSR;
+		wed->wlan.wpdma_tx = wed->wlan.phy_base + hif1_ofs +
+					     MT_TXQ_RING_BASE(0) +
+					     MT7996_TXQ_BAND2 * MT_RING_SIZE;
+		wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
+					 MT_RXQ_RING_BASE(0) +
+					 MT7996_RXQ_MCU_WA_TRI * MT_RING_SIZE;
+		wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_TRI) - 1;
+
+		wed->wlan.id = 0x7991;
+		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND2) - 1;
+	} else {
+		wed->wlan.wpdma_int = wed->wlan.phy_base + MT_INT_SOURCE_CSR;
+		wed->wlan.wpdma_mask = wed->wlan.phy_base + MT_INT_MASK_CSR;
+		wed->wlan.wpdma_tx = wed->wlan.phy_base + MT_TXQ_RING_BASE(0) +
+				     MT7996_TXQ_BAND0 * MT_RING_SIZE;
+
+		wed->wlan.wpdma_rx_glo = wed->wlan.phy_base + MT_WFDMA0_GLO_CFG;
+
+		wed->wlan.wpdma_rx = wed->wlan.phy_base +
+				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
+				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
+
+		wed->wlan.rx_nbuf = 65536;
+		wed->wlan.rx_npkt = dev->hif2 ? 32768 : 24576;
+		wed->wlan.rx_size = SKB_WITH_OVERHEAD(MT_RX_BUF_SIZE);
+
+		wed->wlan.rx_tbit[0] = ffs(MT_INT_RX_DONE_BAND0) - 1;
+		wed->wlan.rx_tbit[1] = ffs(MT_INT_RX_DONE_BAND2) - 1;
+
+		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND0) - 1;
+		wed->wlan.tx_tbit[1] = ffs(MT_INT_TX_DONE_BAND1) - 1;
+		wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_MAIN) - 1;
+		wed->wlan.wpdma_txfree = wed->wlan.phy_base + MT_RXQ_RING_BASE(0) +
+					  MT7996_RXQ_MCU_WA_MAIN * MT_RING_SIZE;
+	}
+
+	wed->wlan.nbuf = MT7996_HW_TOKEN_SIZE;
+	wed->wlan.token_start = MT7996_TOKEN_SIZE - wed->wlan.nbuf;
+
+	wed->wlan.amsdu_max_subframes = 8;
+	wed->wlan.amsdu_max_len = 1536;
+
+	wed->wlan.init_buf = mt7996_wed_init_buf;
+	wed->wlan.init_rx_buf = mt76_mmio_wed_init_rx_buf;
+	wed->wlan.release_rx_buf = mt76_mmio_wed_release_rx_buf;
+	wed->wlan.offload_enable = mt76_mmio_wed_offload_enable;
+	wed->wlan.offload_disable = mt76_mmio_wed_offload_disable;
+
+	dev->mt76.rx_token_size += wed->wlan.rx_npkt;
+
+	if (mtk_wed_device_attach(wed))
+		return 0;
+
+	*irq = wed->irq;
+	dev->mt76.dma_dev = wed->dev;
+
+	ret = dma_set_mask(wed->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	ret = dma_set_coherent_mask(wed->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 static int mt7996_mmio_init(struct mt76_dev *mdev,
 			    void __iomem *mem_base,
 			    u32 device_id)
@@ -241,8 +345,17 @@ void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
 	mdev->mmio.irqmask |= set;
 
 	if (write_reg) {
-		mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
-		mt76_wr(dev, MT_INT1_MASK_CSR, mdev->mmio.irqmask);
+		if (mtk_wed_device_active(&mdev->mmio.wed)) {
+			mtk_wed_device_irq_set_mask(&mdev->mmio.wed,
+						    mdev->mmio.irqmask);
+			if (mtk_wed_device_active(&mdev->mmio.wed_hif2)) {
+				mtk_wed_device_irq_set_mask(&mdev->mmio.wed_hif2,
+							    mdev->mmio.irqmask);
+			}
+		} else {
+			mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
+			mt76_wr(dev, MT_INT1_MASK_CSR, mdev->mmio.irqmask);
+		}
 	}
 
 	spin_unlock_irqrestore(&mdev->mmio.irq_lock, flags);
@@ -260,22 +373,36 @@ static void mt7996_rx_poll_complete(struct mt76_dev *mdev,
 static void mt7996_irq_tasklet(struct tasklet_struct *t)
 {
 	struct mt7996_dev *dev = from_tasklet(dev, t, mt76.irq_tasklet);
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	struct mtk_wed_device *wed_hif2 = &dev->mt76.mmio.wed_hif2;
 	u32 i, intr, mask, intr1;
 
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	if (dev->hif2)
-		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
-
-	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
-	intr &= dev->mt76.mmio.irqmask;
-	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
-
-	if (dev->hif2) {
-		intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
-		intr1 &= dev->mt76.mmio.irqmask;
-		mt76_wr(dev, MT_INT1_SOURCE_CSR, intr1);
+	if (dev->hif2 && mtk_wed_device_active(wed_hif2)) {
+		mtk_wed_device_irq_set_mask(wed_hif2, 0);
+		intr1 = mtk_wed_device_irq_get(wed_hif2,
+					       dev->mt76.mmio.irqmask);
+		if (intr1 & MT_INT_RX_TXFREE_EXT)
+			napi_schedule(&dev->mt76.napi[MT_RXQ_TXFREE_BAND2]);
+	}
 
-		intr |= intr1;
+	if (mtk_wed_device_active(wed)) {
+		mtk_wed_device_irq_set_mask(wed, 0);
+		intr = mtk_wed_device_irq_get(wed, dev->mt76.mmio.irqmask);
+		intr |= (intr1 & ~MT_INT_RX_TXFREE_EXT);
+	} else {
+		mt76_wr(dev, MT_INT_MASK_CSR, 0);
+		if (dev->hif2)
+			mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+		intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+		intr &= dev->mt76.mmio.irqmask;
+		mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+		if (dev->hif2) {
+			intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
+			intr1 &= dev->mt76.mmio.irqmask;
+			mt76_wr(dev, MT_INT1_SOURCE_CSR, intr1);
+			intr |= intr1;
+		}
 	}
 
 	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
@@ -307,10 +434,19 @@ static void mt7996_irq_tasklet(struct tasklet_struct *t)
 irqreturn_t mt7996_irq_handler(int irq, void *dev_instance)
 {
 	struct mt7996_dev *dev = dev_instance;
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	if (dev->hif2)
-		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+	if (mtk_wed_device_active(wed))
+		mtk_wed_device_irq_set_mask(wed, 0);
+	else
+		mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
+	if (dev->hif2) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed_hif2))
+			mtk_wed_device_irq_set_mask(&dev->mt76.mmio.wed_hif2, 0);
+		else
+			mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+	}
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index e53cf6a3704c..ccb6c5763956 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -37,6 +37,7 @@
 #define MT7996_EEPROM_SIZE		7680
 #define MT7996_EEPROM_BLOCK_SIZE	16
 #define MT7996_TOKEN_SIZE		16384
+#define MT7996_HW_TOKEN_SIZE		8192
 
 #define MT7996_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7996_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
@@ -334,7 +335,9 @@ int mt7996_dma_init(struct mt7996_dev *dev);
 void mt7996_dma_reset(struct mt7996_dev *dev, bool force);
 void mt7996_dma_prefetch(struct mt7996_dev *dev);
 void mt7996_dma_cleanup(struct mt7996_dev *dev);
-void mt7996_dma_start(struct mt7996_dev *dev, bool reset);
+void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset);
+int mt7996_init_tx_queues(struct mt7996_phy *phy, int idx,
+			  int n_desc, int ring_base, struct mtk_wed_device *wed);
 void mt7996_init_txpower(struct mt7996_dev *dev,
 			 struct ieee80211_supported_band *sband);
 int mt7996_txbf_init(struct mt7996_dev *dev);
@@ -495,5 +498,12 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
 #endif
+int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
+			 bool hif2, int *irq);
+u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id);
+
+#ifdef CONFIG_MTK_DEBUG
+int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
+#endif
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index c5301050ff8b..93ecc9a8dde0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -92,10 +92,10 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
 	struct pci_dev *hif2_dev;
+	struct mt7996_hif *hif2;
 	struct mt7996_dev *dev;
+	int irq, hif2_irq, ret;
 	struct mt76_dev *mdev;
-	struct mt7996_hif *hif2;
-	int irq, ret;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -125,15 +125,22 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	mt7996_wfsys_reset(dev);
 	hif2 = mt7996_pci_init_hif2(pdev);
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = mt7996_mmio_wed_init(dev, pdev, false, &irq);
 	if (ret < 0)
-		goto free_device;
+		goto free_wed_or_irq_vector;
+
+	if (!ret) {
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+		if (ret < 0)
+			goto free_device;
+
+		irq = pdev->irq;
+	}
 
-	irq = pdev->irq;
 	ret = devm_request_irq(mdev->dev, irq, mt7996_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
-		goto free_irq_vector;
+		goto free_wed_or_irq_vector;
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 	/* master switch of PCIe tnterrupt enable */
@@ -143,16 +150,25 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 		hif2_dev = container_of(hif2->dev, struct pci_dev, dev);
 		dev->hif2 = hif2;
 
-		ret = pci_alloc_irq_vectors(hif2_dev, 1, 1, PCI_IRQ_ALL_TYPES);
+		ret = mt7996_mmio_wed_init(dev, hif2_dev, true, &hif2_irq);
 		if (ret < 0)
-			goto free_hif2;
+			goto free_hif2_wed_irq_vector;
+
+		if (!ret) {
+			ret = pci_alloc_irq_vectors(hif2_dev, 1, 1,
+						    PCI_IRQ_ALL_TYPES);
+			if (ret < 0)
+				goto free_hif2;
+
+			dev->hif2->irq = hif2_dev->irq;
+			hif2_irq = dev->hif2->irq;
+		}
 
-		dev->hif2->irq = hif2_dev->irq;
-		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
-				       mt7996_irq_handler, IRQF_SHARED,
-				       KBUILD_MODNAME "-hif", dev);
+		ret = devm_request_irq(mdev->dev, hif2_irq, mt7996_irq_handler,
+				       IRQF_SHARED, KBUILD_MODNAME "-hif",
+				       dev);
 		if (ret)
-			goto free_hif2_irq_vector;
+			goto free_hif2_wed_irq_vector;
 
 		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
 		/* master switch of PCIe tnterrupt enable */
@@ -167,16 +183,23 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 
 free_hif2_irq:
 	if (dev->hif2)
-		devm_free_irq(mdev->dev, dev->hif2->irq, dev);
-free_hif2_irq_vector:
-	if (dev->hif2)
-		pci_free_irq_vectors(hif2_dev);
+		devm_free_irq(mdev->dev, hif2_irq, dev);
+free_hif2_wed_irq_vector:
+	if (dev->hif2) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed_hif2))
+			mtk_wed_device_detach(&dev->mt76.mmio.wed_hif2);
+		else
+			pci_free_irq_vectors(hif2_dev);
+	}
 free_hif2:
 	if (dev->hif2)
 		put_device(dev->hif2->dev);
 	devm_free_irq(mdev->dev, irq, dev);
-free_irq_vector:
-	pci_free_irq_vectors(pdev);
+free_wed_or_irq_vector:
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mtk_wed_device_detach(&dev->mt76.mmio.wed);
+	else
+		pci_free_irq_vectors(pdev);
 free_device:
 	mt76_free_device(&dev->mt76);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 0086a7866657..b7d78adce11a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -330,6 +330,7 @@ enum base_rev {
 
 #define MT_WFDMA0_RX_INT_PCIE_SEL		MT_WFDMA0(0x154)
 #define MT_WFDMA0_RX_INT_SEL_RING3		BIT(3)
+#define MT_WFDMA0_RX_INT_SEL_RING6		BIT(6)
 
 #define MT_WFDMA0_MCU_HOST_INT_ENA		MT_WFDMA0(0x1f4)
 
@@ -374,6 +375,9 @@ enum base_rev {
 #define MT_WFDMA0_PCIE1_BASE			0xd8000
 #define MT_WFDMA0_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
 
+#define MT_INT_PCIE1_SOURCE_CSR_EXT		MT_WFDMA0_PCIE1(0x118)
+#define MT_INT_PCIE1_MASK_CSR			MT_WFDMA0_PCIE1(0x11c)
+
 #define MT_WFDMA0_PCIE1_BUSY_ENA		MT_WFDMA0_PCIE1(0x13c)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
@@ -419,6 +423,7 @@ enum base_rev {
 #define MT_INT_RX_TXFREE_MAIN			BIT(17)
 #define MT_INT_RX_TXFREE_TRI			BIT(15)
 #define MT_INT_MCU_CMD				BIT(29)
+#define MT_INT_RX_TXFREE_EXT			BIT(26)
 
 #define MT_INT_RX(q)				(dev->q_int_mask[__RXQ(q)])
 #define MT_INT_TX_MCU(q)			(dev->q_int_mask[(q)])
-- 
2.41.0

