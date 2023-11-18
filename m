Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F837F00CA
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Nov 2023 16:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjKRP64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Nov 2023 10:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjKRP6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Nov 2023 10:58:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E34558B
        for <linux-wireless@vger.kernel.org>; Sat, 18 Nov 2023 07:55:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE086C433CB;
        Sat, 18 Nov 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700322885;
        bh=9h69eiJyTeljYrcPEHlFBC/iUH1MeieMiGGvIU5851g=;
        h=From:To:Cc:Subject:Date:From;
        b=SWvRvzpSprAQJN46Y7/MShZh+rI/VbERwvkLXcwuD/HhQXygkfBnX7XNrZCSmT3HN
         tdBWU43Dv5qVVJLcR+TTHUAjz6u37ah2Sf5wyrZgTCsJ1JxBSIKP+Q0UDjlFZHhdnK
         i0VZUyxhzstyHN/61ggP2VTqhRuiR2ORmc94i0TCRW+C8ocGPfmLjMbAGj+BT4nwki
         ThpAyDL/7MdGdi9sGR1BoM+dYddhnjoB5fCvrakK+jLd0RFh51YOlp/8CAsug2AD6A
         ncpBxu8ILrho+GtN7LfoS6lpDoxVsKzGvIv3a9TJLLo6GCLbSnkBwMJgbPzHbOwngV
         jl/dbuHzl7yew==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: move wed common utilities in wed.c
Date:   Sat, 18 Nov 2023 16:54:34 +0100
Message-ID: <9c2b24076b0f48bf4de4806640e537fd27688045.1700322806.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce wed.c in order to collect mt76 wed common codebase used by
mt7915 and mt7996 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c      | 106 +--------
 drivers/net/wireless/mediatek/mt76/dma.h      |   9 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  16 --
 drivers/net/wireless/mediatek/mt76/mmio.c     | 104 ---------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  39 +++-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  10 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  10 +-
 drivers/net/wireless/mediatek/mt76/wed.c      | 210 ++++++++++++++++++
 13 files changed, 265 insertions(+), 249 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/wed.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index d6575fe18c6b..f7f2d9a8ab0f 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_MT792x_USB) += mt792x-usb.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
-	tx.o agg-rx.o mcu.o
+	tx.o agg-rx.o mcu.o wed.o
 
 mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 439cdfab6f67..d7525675f038 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -197,9 +197,8 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 	q->tail = q->head;
 }
 
-static void
-__mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
-		       bool reset_idx)
+void __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
+			    bool reset_idx)
 {
 	if (!q || !q->ndesc)
 		return;
@@ -219,8 +218,7 @@ __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 	mt76_dma_sync_idx(dev, q);
 }
 
-static void
-mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
+void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	__mt76_dma_queue_reset(dev, q, true);
 }
@@ -622,9 +620,8 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	return ret;
 }
 
-static int
-mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
-		 bool allow_direct)
+int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
+		     bool allow_direct)
 {
 	int len = SKB_WITH_OVERHEAD(q->buf_size);
 	int frames = 0;
@@ -671,81 +668,6 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 	return frames;
 }
 
-int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
-{
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-	int ret = 0, type, ring;
-	u16 flags;
-
-	if (!q || !q->ndesc)
-		return -EINVAL;
-
-	flags = q->flags;
-	if (!q->wed || !mtk_wed_device_active(q->wed))
-		q->flags &= ~MT_QFLAG_WED;
-
-	if (!(q->flags & MT_QFLAG_WED))
-		return 0;
-
-	type = FIELD_GET(MT_QFLAG_WED_TYPE, q->flags);
-	ring = FIELD_GET(MT_QFLAG_WED_RING, q->flags);
-
-	switch (type) {
-	case MT76_WED_Q_TX:
-		ret = mtk_wed_device_tx_ring_setup(q->wed, ring, q->regs,
-						   reset);
-		if (!ret)
-			q->wed_regs = q->wed->tx_ring[ring].reg_base;
-		break;
-	case MT76_WED_Q_TXFREE:
-		/* WED txfree queue needs ring to be initialized before setup */
-		q->flags = 0;
-		mt76_dma_queue_reset(dev, q);
-		mt76_dma_rx_fill(dev, q, false);
-
-		ret = mtk_wed_device_txfree_ring_setup(q->wed, q->regs);
-		if (!ret)
-			q->wed_regs = q->wed->txfree_ring.reg_base;
-		break;
-	case MT76_WED_Q_RX:
-		ret = mtk_wed_device_rx_ring_setup(q->wed, ring, q->regs,
-						   reset);
-		if (!ret)
-			q->wed_regs = q->wed->rx_ring[ring].reg_base;
-		break;
-	case MT76_WED_RRO_Q_DATA:
-		q->flags &= ~MT_QFLAG_WED;
-		__mt76_dma_queue_reset(dev, q, false);
-		mtk_wed_device_rro_rx_ring_setup(q->wed, ring, q->regs);
-		q->head = q->ndesc - 1;
-		q->queued = q->head;
-		break;
-	case MT76_WED_RRO_Q_MSDU_PG:
-		q->flags &= ~MT_QFLAG_WED;
-		__mt76_dma_queue_reset(dev, q, false);
-		mtk_wed_device_msdu_pg_rx_ring_setup(q->wed, ring, q->regs);
-		q->head = q->ndesc - 1;
-		q->queued = q->head;
-		break;
-	case MT76_WED_RRO_Q_IND:
-		q->flags &= ~MT_QFLAG_WED;
-		mt76_dma_queue_reset(dev, q);
-		mt76_dma_rx_fill(dev, q, false);
-		mtk_wed_device_ind_rx_ring_setup(q->wed, q->regs);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-	q->flags = flags;
-
-	return ret;
-#else
-	return 0;
-#endif
-}
-EXPORT_SYMBOL_GPL(mt76_dma_wed_setup);
-
 static int
 mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 		     int idx, int n_desc, int bufsize,
@@ -790,7 +712,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (ret)
 		return ret;
 
-	ret = mt76_dma_wed_setup(dev, q, false);
+	ret = mt76_wed_dma_setup(dev, q, false);
 	if (ret)
 		return ret;
 
@@ -853,7 +775,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	mt76_dma_rx_cleanup(dev, q);
 
 	/* reset WED rx queues */
-	mt76_dma_wed_setup(dev, q, true);
+	mt76_wed_dma_setup(dev, q, true);
 
 	if (mt76_queue_is_wed_tx_free(q))
 		return;
@@ -1042,20 +964,6 @@ void mt76_dma_attach(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_dma_attach);
 
-void mt76_dma_wed_reset(struct mt76_dev *dev)
-{
-	struct mt76_mmio *mmio = &dev->mmio;
-
-	if (!test_bit(MT76_STATE_WED_RESET, &dev->phy.state))
-		return;
-
-	complete(&mmio->wed_reset);
-
-	if (!wait_for_completion_timeout(&mmio->wed_reset_complete, 3 * HZ))
-		dev_err(dev->dev, "wed reset complete timeout\n");
-}
-EXPORT_SYMBOL_GPL(mt76_dma_wed_reset);
-
 void mt76_dma_cleanup(struct mt76_dev *dev)
 {
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index c60dfb817227..8321d3427fc1 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -77,15 +77,18 @@ enum mt76_dma_wed_ind_reason {
 int mt76_dma_rx_poll(struct napi_struct *napi, int budget);
 void mt76_dma_attach(struct mt76_dev *dev);
 void mt76_dma_cleanup(struct mt76_dev *dev);
-int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset);
-void mt76_dma_wed_reset(struct mt76_dev *dev);
+int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
+		     bool allow_direct);
+void __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
+			    bool reset_idx);
+void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q);
 
 static inline void
 mt76_dma_reset_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	dev->queue_ops->reset_q(dev, q);
 	if (mtk_wed_device_active(&dev->mmio.wed))
-		mt76_dma_wed_setup(dev, q, true);
+		mt76_wed_dma_setup(dev, q, true);
 }
 
 static inline void
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8a3a90d1bfac..5cc608d20619 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1854,19 +1854,3 @@ enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
 	return MT_DFS_STATE_ACTIVE;
 }
 EXPORT_SYMBOL_GPL(mt76_phy_dfs_state);
-
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-int mt76_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		      struct net_device *netdev, enum tc_setup_type type,
-		      void *type_data)
-{
-	struct mt76_phy *phy = hw->priv;
-	struct mtk_wed_device *wed = &phy->dev->mmio.wed;
-
-	if (!mtk_wed_device_active(wed))
-		return -EOPNOTSUPP;
-
-	return mtk_wed_device_setup_tc(wed, netdev, type, type_data);
-}
-EXPORT_SYMBOL_GPL(mt76_net_setup_tc);
-#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 4a006409a373..cd2e9737c3bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -85,110 +85,6 @@ void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr,
 }
 EXPORT_SYMBOL_GPL(mt76_set_irq_mask);
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-void mt76_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
-{
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
-	int i;
-
-	for (i = 0; i < dev->rx_token_size; i++) {
-		struct mt76_txwi_cache *t;
-
-		t = mt76_rx_token_release(dev, i);
-		if (!t || !t->ptr)
-			continue;
-
-		mt76_put_page_pool_buf(t->ptr, false);
-		t->ptr = NULL;
-
-		mt76_put_rxwi(dev, t);
-	}
-
-	mt76_free_pending_rxwi(dev);
-}
-EXPORT_SYMBOL_GPL(mt76_mmio_wed_release_rx_buf);
-
-u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
-{
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
-	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int i, len = SKB_WITH_OVERHEAD(q->buf_size);
-	struct mt76_txwi_cache *t = NULL;
-
-	for (i = 0; i < size; i++) {
-		enum dma_data_direction dir;
-		dma_addr_t addr;
-		u32 offset;
-		int token;
-		void *buf;
-
-		t = mt76_get_rxwi(dev);
-		if (!t)
-			goto unmap;
-
-		buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
-		if (!buf)
-			goto unmap;
-
-		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
-		dir = page_pool_get_dma_dir(q->page_pool);
-		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
-
-		desc->buf0 = cpu_to_le32(addr);
-		token = mt76_rx_token_consume(dev, buf, t, addr);
-		if (token < 0) {
-			mt76_put_page_pool_buf(buf, false);
-			goto unmap;
-		}
-
-		desc->token |= cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
-						      token));
-		desc++;
-	}
-
-	return 0;
-
-unmap:
-	if (t)
-		mt76_put_rxwi(dev, t);
-	mt76_mmio_wed_release_rx_buf(wed);
-
-	return -ENOMEM;
-}
-EXPORT_SYMBOL_GPL(mt76_mmio_wed_init_rx_buf);
-
-int mt76_mmio_wed_offload_enable(struct mtk_wed_device *wed)
-{
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
-
-	spin_lock_bh(&dev->token_lock);
-	dev->token_size = wed->wlan.token_start;
-	spin_unlock_bh(&dev->token_lock);
-
-	return !wait_event_timeout(dev->tx_wait, !dev->wed_token_count, HZ);
-}
-EXPORT_SYMBOL_GPL(mt76_mmio_wed_offload_enable);
-
-void mt76_mmio_wed_offload_disable(struct mtk_wed_device *wed)
-{
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
-
-	spin_lock_bh(&dev->token_lock);
-	dev->token_size = dev->drv->token_size;
-	spin_unlock_bh(&dev->token_lock);
-}
-EXPORT_SYMBOL_GPL(mt76_mmio_wed_offload_disable);
-
-void mt76_mmio_wed_reset_complete(struct mtk_wed_device *wed)
-{
-	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
-
-	complete(&dev->mmio.wed_reset_complete);
-}
-EXPORT_SYMBOL_GPL(mt76_mmio_wed_reset_complete);
-#endif /*CONFIG_NET_MEDIATEK_SOC_WED */
-
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs)
 {
 	static const struct mt76_bus_ops mt76_mmio_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b1d3f55d7034..045bb107ffaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1082,12 +1082,6 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs);
 void mt76_pci_disable_aspm(struct pci_dev *pdev);
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-int mt76_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		      struct net_device *netdev, enum tc_setup_type type,
-		      void *type_data);
-#endif /*CONFIG_NET_MEDIATEK_SOC_WED */
-
 static inline u16 mt76_chip(struct mt76_dev *dev)
 {
 	return dev->rev >> 16;
@@ -1098,13 +1092,34 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 	return dev->rev & 0xffff;
 }
 
+void mt76_wed_release_rx_buf(struct mtk_wed_device *wed);
+void mt76_wed_offload_disable(struct mtk_wed_device *wed);
+void mt76_wed_reset_complete(struct mtk_wed_device *wed);
+void mt76_wed_dma_reset(struct mt76_dev *dev);
+int mt76_wed_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct net_device *netdev, enum tc_setup_type type,
+			  void *type_data);
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
-u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
-void mt76_mmio_wed_release_rx_buf(struct mtk_wed_device *wed);
-int mt76_mmio_wed_offload_enable(struct mtk_wed_device *wed);
-void mt76_mmio_wed_offload_disable(struct mtk_wed_device *wed);
-void mt76_mmio_wed_reset_complete(struct mtk_wed_device *wed);
-#endif /*CONFIG_NET_MEDIATEK_SOC_WED */
+u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
+int mt76_wed_offload_enable(struct mtk_wed_device *wed);
+int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset);
+#else
+static inline u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
+{
+	return 0;
+}
+
+static inline int mt76_wed_offload_enable(struct mtk_wed_device *wed)
+{
+	return 0;
+}
+
+static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
+				     bool reset)
+{
+	return 0;
+}
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
 
 #define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
 #define mt76xx_rev(dev) mt76_rev(&((dev)->mt76))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index c91a1c54027f..0baa82c8df5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -614,7 +614,7 @@ int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 		mtk_wed_device_dma_reset(wed);
 
 	mt7915_dma_disable(dev, force);
-	mt76_dma_wed_reset(&dev->mt76);
+	mt76_wed_dma_reset(&dev->mt76);
 
 	/* reset hw queues */
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index df2d4279790d..3709d18da0e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1708,6 +1708,6 @@ const struct ieee80211_ops mt7915_ops = {
 	.set_radar_background = mt7915_set_radar_background,
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_fill_forward_path = mt7915_net_fill_forward_path,
-	.net_setup_tc = mt76_net_setup_tc,
+	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index aff4f21e843d..fc38cd34c067 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -672,13 +672,13 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	}
 
 	wed->wlan.init_buf = mt7915_wed_init_buf;
-	wed->wlan.offload_enable = mt76_mmio_wed_offload_enable;
-	wed->wlan.offload_disable = mt76_mmio_wed_offload_disable;
-	wed->wlan.init_rx_buf = mt76_mmio_wed_init_rx_buf;
-	wed->wlan.release_rx_buf = mt76_mmio_wed_release_rx_buf;
+	wed->wlan.offload_enable = mt76_wed_offload_enable;
+	wed->wlan.offload_disable = mt76_wed_offload_disable;
+	wed->wlan.init_rx_buf = mt76_wed_init_rx_buf;
+	wed->wlan.release_rx_buf = mt76_wed_release_rx_buf;
 	wed->wlan.update_wo_rx_stats = mt7915_mmio_wed_update_rx_stats;
 	wed->wlan.reset = mt7915_mmio_wed_reset;
-	wed->wlan.reset_complete = mt76_mmio_wed_reset_complete;
+	wed->wlan.reset_complete = mt76_wed_reset_complete;
 
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 0bc4681fc18a..2ca79b64ad24 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -692,7 +692,7 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 		mtk_wed_device_dma_reset(&dev->mt76.mmio.wed);
 
 	mt7996_dma_disable(dev, force);
-	mt76_dma_wed_reset(&dev->mt76);
+	mt76_wed_dma_reset(&dev->mt76);
 
 	/* reset hw queues */
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 51deea84b642..c019848d6e0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1495,6 +1495,6 @@ const struct ieee80211_ops mt7996_ops = {
 	.set_radar_background = mt7996_set_radar_background,
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_fill_forward_path = mt7996_net_fill_forward_path,
-	.net_setup_tc = mt76_net_setup_tc,
+	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index b1119f62c946..3f24a019d149 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -392,13 +392,13 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	wed->wlan.amsdu_max_len = 1536;
 
 	wed->wlan.init_buf = mt7996_wed_init_buf;
-	wed->wlan.init_rx_buf = mt76_mmio_wed_init_rx_buf;
-	wed->wlan.release_rx_buf = mt76_mmio_wed_release_rx_buf;
-	wed->wlan.offload_enable = mt76_mmio_wed_offload_enable;
-	wed->wlan.offload_disable = mt76_mmio_wed_offload_disable;
+	wed->wlan.init_rx_buf = mt76_wed_init_rx_buf;
+	wed->wlan.release_rx_buf = mt76_wed_release_rx_buf;
+	wed->wlan.offload_enable = mt76_wed_offload_enable;
+	wed->wlan.offload_disable = mt76_wed_offload_disable;
 	if (!hif2) {
 		wed->wlan.reset = mt7996_mmio_wed_reset;
-		wed->wlan.reset_complete = mt76_mmio_wed_reset_complete;
+		wed->wlan.reset_complete = mt76_wed_reset_complete;
 	}
 
 	if (mtk_wed_device_attach(wed))
diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
new file mode 100644
index 000000000000..8ea21a13c80b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2023 Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include "mt76.h"
+#include "dma.h"
+
+void mt76_wed_release_rx_buf(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	int i;
+
+	for (i = 0; i < dev->rx_token_size; i++) {
+		struct mt76_txwi_cache *t;
+
+		t = mt76_rx_token_release(dev, i);
+		if (!t || !t->ptr)
+			continue;
+
+		mt76_put_page_pool_buf(t->ptr, false);
+		t->ptr = NULL;
+
+		mt76_put_rxwi(dev, t);
+	}
+
+	mt76_free_pending_rxwi(dev);
+}
+EXPORT_SYMBOL_GPL(mt76_wed_release_rx_buf);
+
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
+	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+	int i, len = SKB_WITH_OVERHEAD(q->buf_size);
+	struct mt76_txwi_cache *t = NULL;
+
+	for (i = 0; i < size; i++) {
+		enum dma_data_direction dir;
+		dma_addr_t addr;
+		u32 offset;
+		int token;
+		void *buf;
+
+		t = mt76_get_rxwi(dev);
+		if (!t)
+			goto unmap;
+
+		buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
+		if (!buf)
+			goto unmap;
+
+		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
+		dir = page_pool_get_dma_dir(q->page_pool);
+		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
+
+		desc->buf0 = cpu_to_le32(addr);
+		token = mt76_rx_token_consume(dev, buf, t, addr);
+		if (token < 0) {
+			mt76_put_page_pool_buf(buf, false);
+			goto unmap;
+		}
+
+		desc->token |= cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
+						      token));
+		desc++;
+	}
+
+	return 0;
+
+unmap:
+	if (t)
+		mt76_put_rxwi(dev, t);
+	mt76_wed_release_rx_buf(wed);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(mt76_wed_init_rx_buf);
+
+int mt76_wed_offload_enable(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+
+	spin_lock_bh(&dev->token_lock);
+	dev->token_size = wed->wlan.token_start;
+	spin_unlock_bh(&dev->token_lock);
+
+	return !wait_event_timeout(dev->tx_wait, !dev->wed_token_count, HZ);
+}
+EXPORT_SYMBOL_GPL(mt76_wed_offload_enable);
+
+int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
+{
+	int ret = 0, type, ring;
+	u16 flags;
+
+	if (!q || !q->ndesc)
+		return -EINVAL;
+
+	flags = q->flags;
+	if (!q->wed || !mtk_wed_device_active(q->wed))
+		q->flags &= ~MT_QFLAG_WED;
+
+	if (!(q->flags & MT_QFLAG_WED))
+		return 0;
+
+	type = FIELD_GET(MT_QFLAG_WED_TYPE, q->flags);
+	ring = FIELD_GET(MT_QFLAG_WED_RING, q->flags);
+
+	switch (type) {
+	case MT76_WED_Q_TX:
+		ret = mtk_wed_device_tx_ring_setup(q->wed, ring, q->regs,
+						   reset);
+		if (!ret)
+			q->wed_regs = q->wed->tx_ring[ring].reg_base;
+		break;
+	case MT76_WED_Q_TXFREE:
+		/* WED txfree queue needs ring to be initialized before setup */
+		q->flags = 0;
+		mt76_dma_queue_reset(dev, q);
+		mt76_dma_rx_fill(dev, q, false);
+
+		ret = mtk_wed_device_txfree_ring_setup(q->wed, q->regs);
+		if (!ret)
+			q->wed_regs = q->wed->txfree_ring.reg_base;
+		break;
+	case MT76_WED_Q_RX:
+		ret = mtk_wed_device_rx_ring_setup(q->wed, ring, q->regs,
+						   reset);
+		if (!ret)
+			q->wed_regs = q->wed->rx_ring[ring].reg_base;
+		break;
+	case MT76_WED_RRO_Q_DATA:
+		q->flags &= ~MT_QFLAG_WED;
+		__mt76_dma_queue_reset(dev, q, false);
+		mtk_wed_device_rro_rx_ring_setup(q->wed, ring, q->regs);
+		q->head = q->ndesc - 1;
+		q->queued = q->head;
+		break;
+	case MT76_WED_RRO_Q_MSDU_PG:
+		q->flags &= ~MT_QFLAG_WED;
+		__mt76_dma_queue_reset(dev, q, false);
+		mtk_wed_device_msdu_pg_rx_ring_setup(q->wed, ring, q->regs);
+		q->head = q->ndesc - 1;
+		q->queued = q->head;
+		break;
+	case MT76_WED_RRO_Q_IND:
+		q->flags &= ~MT_QFLAG_WED;
+		mt76_dma_queue_reset(dev, q);
+		mt76_dma_rx_fill(dev, q, false);
+		mtk_wed_device_ind_rx_ring_setup(q->wed, q->regs);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	q->flags = flags;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_wed_dma_setup);
+#endif /*CONFIG_NET_MEDIATEK_SOC_WED */
+
+void mt76_wed_offload_disable(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+
+	spin_lock_bh(&dev->token_lock);
+	dev->token_size = dev->drv->token_size;
+	spin_unlock_bh(&dev->token_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_wed_offload_disable);
+
+void mt76_wed_reset_complete(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
+
+	complete(&dev->mmio.wed_reset_complete);
+}
+EXPORT_SYMBOL_GPL(mt76_wed_reset_complete);
+
+int mt76_wed_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct net_device *netdev, enum tc_setup_type type,
+			  void *type_data)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mtk_wed_device *wed = &phy->dev->mmio.wed;
+
+	if (!mtk_wed_device_active(wed))
+		return -EOPNOTSUPP;
+
+	return mtk_wed_device_setup_tc(wed, netdev, type, type_data);
+}
+EXPORT_SYMBOL_GPL(mt76_wed_net_setup_tc);
+
+void mt76_wed_dma_reset(struct mt76_dev *dev)
+{
+	struct mt76_mmio *mmio = &dev->mmio;
+
+	if (!test_bit(MT76_STATE_WED_RESET, &dev->phy.state))
+		return;
+
+	complete(&mmio->wed_reset);
+
+	if (!wait_for_completion_timeout(&mmio->wed_reset_complete, 3 * HZ))
+		dev_err(dev->dev, "wed reset complete timeout\n");
+}
+EXPORT_SYMBOL_GPL(mt76_wed_dma_reset);
-- 
2.42.0

