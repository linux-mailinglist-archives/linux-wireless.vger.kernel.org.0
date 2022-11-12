Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8719626A4C
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiKLPlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiKLPlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36D81ADB4
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D6460919
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B98C433D6;
        Sat, 12 Nov 2022 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267667;
        bh=2W8dB4G4rj+P3Odb2j4AHt3Q5R66DR0+LP9A5vYp4is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMrCfwiScu8m1cUq3HBdvcaU7iupg4kwe/y2Ds+r35XUMEbb06bb9I3QbScz4TDPc
         KvvZJnCVIXEylVH/CQIAswYpD740KiGbCvUOjJqQYr6ujA0nMwtMzIICsgLx7qYCji
         x+PkZ1yofPu9hwSFy3azJ6pnOLqM9Oon8w3Ts0QiukeqH3w1QgBefCA4954WhkwR8O
         +q/7t42oiKDl9AAl2u4tT2JVRAqB6O7WoVzmdvF0/gfR9M8yYXTxmMooMqlXFWMJFS
         kibGmNSvoeZMbmERCZbKidwptTc+b1m3UzyTzBzQOa2HWa3ddkkbo3xfsxYdH2S+tO
         BdtPFG2oo0waQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 1/8] wifi: mt76: introduce rxwi and rx token utility routines
Date:   Sat, 12 Nov 2022 16:40:34 +0100
Message-Id: <730e835d387107911b93a40c578ac5c6583c580b.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668267241.git.lorenzo@kernel.org>
References: <cover.1668267241.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

This is a preliminary patch to introduce WED RX support for mt7915.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 68 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/dma.h      |  8 +++
 drivers/net/wireless/mediatek/mt76/mac80211.c |  5 ++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 16 ++++-
 drivers/net/wireless/mediatek/mt76/tx.c       | 30 ++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 7378c4d1e156..d316bde01c6b 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -59,6 +59,19 @@ mt76_alloc_txwi(struct mt76_dev *dev)
 	return t;
 }
 
+static struct mt76_txwi_cache *
+mt76_alloc_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+
+	t = kzalloc(L1_CACHE_ALIGN(sizeof(*t)), GFP_ATOMIC);
+	if (!t)
+		return NULL;
+
+	t->ptr = NULL;
+	return t;
+}
+
 static struct mt76_txwi_cache *
 __mt76_get_txwi(struct mt76_dev *dev)
 {
@@ -75,6 +88,22 @@ __mt76_get_txwi(struct mt76_dev *dev)
 	return t;
 }
 
+static struct mt76_txwi_cache *
+__mt76_get_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = NULL;
+
+	spin_lock(&dev->wed_lock);
+	if (!list_empty(&dev->rxwi_cache)) {
+		t = list_first_entry(&dev->rxwi_cache, struct mt76_txwi_cache,
+				     list);
+		list_del(&t->list);
+	}
+	spin_unlock(&dev->wed_lock);
+
+	return t;
+}
+
 static struct mt76_txwi_cache *
 mt76_get_txwi(struct mt76_dev *dev)
 {
@@ -86,6 +115,18 @@ mt76_get_txwi(struct mt76_dev *dev)
 	return mt76_alloc_txwi(dev);
 }
 
+struct mt76_txwi_cache *
+mt76_get_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = __mt76_get_rxwi(dev);
+
+	if (t)
+		return t;
+
+	return mt76_alloc_rxwi(dev);
+}
+EXPORT_SYMBOL_GPL(mt76_get_rxwi);
+
 void
 mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
@@ -98,6 +139,18 @@ mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 }
 EXPORT_SYMBOL_GPL(mt76_put_txwi);
 
+void
+mt76_put_rxwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	if (!t)
+		return;
+
+	spin_lock(&dev->wed_lock);
+	list_add(&t->list, &dev->rxwi_cache);
+	spin_unlock(&dev->wed_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_put_rxwi);
+
 static void
 mt76_free_pending_txwi(struct mt76_dev *dev)
 {
@@ -112,6 +165,20 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 	local_bh_enable();
 }
 
+static void
+mt76_free_pending_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+
+	local_bh_disable();
+	while ((t = __mt76_get_rxwi(dev)) != NULL) {
+		if (t->ptr)
+			skb_free_frag(t->ptr);
+		kfree(t);
+	}
+	local_bh_enable();
+}
+
 static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
@@ -808,6 +875,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	}
 
 	mt76_free_pending_txwi(dev);
+	mt76_free_pending_rxwi(dev);
 
 	if (mtk_wed_device_active(&dev->mmio.wed))
 		mtk_wed_device_detach(&dev->mmio.wed);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index fdf786f975ea..53c6ce2528b2 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -15,6 +15,14 @@
 #define MT_DMA_CTL_SD_LEN0		GENMASK(29, 16)
 #define MT_DMA_CTL_LAST_SEC0		BIT(30)
 #define MT_DMA_CTL_DMA_DONE		BIT(31)
+#define MT_DMA_CTL_TO_HOST		BIT(8)
+#define MT_DMA_CTL_TO_HOST_A		BIT(12)
+#define MT_DMA_CTL_DROP			BIT(14)
+#define MT_DMA_CTL_TOKEN		GENMASK(31, 16)
+
+#define MT_DMA_PPE_CPU_REASON		GENMASK(15, 11)
+#define MT_DMA_PPE_ENTRY		GENMASK(30, 16)
+#define MT_DMA_INFO_PPE_VLD		BIT(31)
 
 #define MT_DMA_HDR_LEN			4
 #define MT_RX_INFO_LEN			4
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index c59d12004459..3cd37a013dcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -572,6 +572,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	spin_lock_init(&dev->lock);
 	spin_lock_init(&dev->cc_lock);
 	spin_lock_init(&dev->status_lock);
+	spin_lock_init(&dev->wed_lock);
 	mutex_init(&dev->mutex);
 	init_waitqueue_head(&dev->tx_wait);
 
@@ -594,9 +595,13 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
+	spin_lock_init(&dev->rx_token_lock);
+	idr_init(&dev->rx_token);
+
 	INIT_LIST_HEAD(&dev->wcid_list);
 
 	INIT_LIST_HEAD(&dev->txwi_cache);
+	INIT_LIST_HEAD(&dev->rxwi_cache);
 	dev->token_size = dev->drv->token_size;
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a2bccf6b6c54..149dc6eb7eb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -339,7 +339,10 @@ struct mt76_txwi_cache {
 	struct list_head list;
 	dma_addr_t dma_addr;
 
-	struct sk_buff *skb;
+	union {
+		struct sk_buff *skb;
+		void *ptr;
+	};
 };
 
 struct mt76_rx_tid {
@@ -728,6 +731,7 @@ struct mt76_dev {
 
 	struct ieee80211_hw *hw;
 
+	spinlock_t wed_lock;
 	spinlock_t lock;
 	spinlock_t cc_lock;
 
@@ -754,6 +758,7 @@ struct mt76_dev {
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
 
 	struct list_head txwi_cache;
+	struct list_head rxwi_cache;
 	struct mt76_queue *q_mcu[__MT_MCUQ_MAX];
 	struct mt76_queue q_rx[__MT_RXQ_MAX];
 	const struct mt76_queue_ops *queue_ops;
@@ -768,6 +773,10 @@ struct mt76_dev {
 	u16 token_count;
 	u16 token_size;
 
+	spinlock_t rx_token_lock;
+	struct idr rx_token;
+	u16 rx_token_size;
+
 	wait_queue_head_t tx_wait;
 	/* spinclock used to protect wcid pktid linked list */
 	spinlock_t status_lock;
@@ -1247,6 +1256,8 @@ mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
 }
 
 void mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
+void mt76_put_rxwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
+struct mt76_txwi_cache *mt76_get_rxwi(struct mt76_dev *dev);
 void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 		      struct napi_struct *napi);
 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
@@ -1391,6 +1402,9 @@ struct mt76_txwi_cache *
 mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
 int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
 void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked);
+struct mt76_txwi_cache *mt76_rx_token_release(struct mt76_dev *dev, int token);
+int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
+			  struct mt76_txwi_cache *r, dma_addr_t phys);
 
 static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6c054850363f..24568b98ed9d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -756,6 +756,23 @@ int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 }
 EXPORT_SYMBOL_GPL(mt76_token_consume);
 
+int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
+			  struct mt76_txwi_cache *t, dma_addr_t phys)
+{
+	int token;
+
+	spin_lock_bh(&dev->rx_token_lock);
+	token = idr_alloc(&dev->rx_token, t, 0, dev->rx_token_size,
+			  GFP_ATOMIC);
+	spin_unlock_bh(&dev->rx_token_lock);
+
+	t->ptr = ptr;
+	t->dma_addr = phys;
+
+	return token;
+}
+EXPORT_SYMBOL_GPL(mt76_rx_token_consume);
+
 struct mt76_txwi_cache *
 mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
 {
@@ -784,3 +801,16 @@ mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
 	return txwi;
 }
 EXPORT_SYMBOL_GPL(mt76_token_release);
+
+struct mt76_txwi_cache *
+mt76_rx_token_release(struct mt76_dev *dev, int token)
+{
+	struct mt76_txwi_cache *t;
+
+	spin_lock_bh(&dev->rx_token_lock);
+	t = idr_remove(&dev->rx_token, token);
+	spin_unlock_bh(&dev->rx_token_lock);
+
+	return t;
+}
+EXPORT_SYMBOL_GPL(mt76_rx_token_release);
-- 
2.38.1

