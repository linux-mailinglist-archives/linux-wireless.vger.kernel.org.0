Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D38B66DF85
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjAQNxz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 08:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjAQNxm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 08:53:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076EA4C3C
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 05:53:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8888361457
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 13:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B388C433EF;
        Tue, 17 Jan 2023 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673963620;
        bh=yo91fJ56cex3Rsh+FsAYVEaplo08NJfL5IohvcwzP/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trZW2NMqB3VPom0SE0UaNhjJsIXIUj7qJ08G06X4u0zX0hrsZHbzP32ITfpD8bQog
         i1lMuOu7m32NLzGDtGIFDC1fCc84AkK8r3MWzHCF0KHRmV+OED1Cl05QDem37igOzd
         NIcfwWLs1TedLTVdS2fnRSe6RVoYVZtguat4XwMcp8L1dPp1n5jx/+Rkj61UOQQLP5
         g7p9RZiG2B1o+MCD6/+Sg+CdiHRChFoREpOOzzagWUdeRTEMaikNXZBIE96q/gSBbS
         aqnLcoczGgJGkhH/U3/FyclsdT2XQiRF9kJZcnPkRGrSFbR+BiqwVq5t5LRVo5UyH1
         3LuKi/fI1w3dA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 2/4] wifi: mt76: switch to page_pool allocator
Date:   Tue, 17 Jan 2023 14:53:15 +0100
Message-Id: <64abb23f4867c075c19d704beaae5a0a2f8e8821.1673963374.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673963374.git.lorenzo@kernel.org>
References: <cover.1673963374.git.lorenzo@kernel.org>
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

In order to reduce possible memory allocation failures due to memory
fragmentation caused by page_frag_cache allocator, switch to page_pool
allocator for dma and usb mt76 drivers.
Remove per rx-queue page_frag_cache

Tested-by: Felix Fietkau <nbd@nbd.name>
Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |  1 +
 drivers/net/wireless/mediatek/mt76/dma.c      | 55 ++++++++++---------
 drivers/net/wireless/mediatek/mt76/mac80211.c | 36 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 23 +++++++-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 16 ++----
 drivers/net/wireless/mediatek/mt76/usb.c      | 42 +++++++-------
 6 files changed, 112 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index d7f90a0eb21e..18152c16c36f 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MT76_CORE
 	tristate
+	select PAGE_POOL
 
 config MT76_LEDS
 	bool
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 611769e445fa..7fd9aa9c3d9e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -173,7 +173,7 @@ mt76_free_pending_rxwi(struct mt76_dev *dev)
 	local_bh_disable();
 	while ((t = __mt76_get_rxwi(dev)) != NULL) {
 		if (t->ptr)
-			skb_free_frag(t->ptr);
+			mt76_put_page_pool_buf(t->ptr, false);
 		kfree(t);
 	}
 	local_bh_enable();
@@ -580,11 +580,11 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 }
 
 static int
-mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
+mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
+		 bool allow_direct)
 {
 	int len = SKB_WITH_OVERHEAD(q->buf_size);
-	int frames = 0, offset = q->buf_offset;
-	dma_addr_t addr;
+	int frames = 0;
 
 	if (!q->ndesc)
 		return 0;
@@ -593,25 +593,28 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 
 	while (q->queued < q->ndesc - 1) {
 		struct mt76_queue_buf qbuf;
-		void *buf = NULL;
+		dma_addr_t addr;
+		int offset;
+		void *buf;
 
-		buf = page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
+		buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
 		if (!buf)
 			break;
 
-		addr = dma_map_single(dev->dma_dev, buf, len, DMA_FROM_DEVICE);
+		addr = dma_map_single(dev->dma_dev, buf + offset, len,
+				      DMA_FROM_DEVICE);
 		if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
-			skb_free_frag(buf);
+			mt76_put_page_pool_buf(buf, allow_direct);
 			break;
 		}
 
-		qbuf.addr = addr + offset;
-		qbuf.len = len - offset;
+		qbuf.addr = addr + q->buf_offset;
+		qbuf.len = len - q->buf_offset;
 		qbuf.skip_unmap = false;
 		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
 			dma_unmap_single(dev->dma_dev, addr, len,
 					 DMA_FROM_DEVICE);
-			skb_free_frag(buf);
+			mt76_put_page_pool_buf(buf, allow_direct);
 			break;
 		}
 		frames++;
@@ -652,7 +655,7 @@ mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
 		/* WED txfree queue needs ring to be initialized before setup */
 		q->flags = 0;
 		mt76_dma_queue_reset(dev, q);
-		mt76_dma_rx_fill(dev, q);
+		mt76_dma_rx_fill(dev, q, false);
 		q->flags = flags;
 
 		ret = mtk_wed_device_txfree_ring_setup(wed, q->regs);
@@ -699,6 +702,10 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (!q->entry)
 		return -ENOMEM;
 
+	ret = mt76_create_page_pool(dev, q);
+	if (ret)
+		return ret;
+
 	ret = mt76_dma_wed_setup(dev, q);
 	if (ret)
 		return ret;
@@ -712,7 +719,6 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 static void
 mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	struct page *page;
 	void *buf;
 	bool more;
 
@@ -726,7 +732,7 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!buf)
 			break;
 
-		skb_free_frag(buf);
+		mt76_put_page_pool_buf(buf, false);
 	} while (1);
 
 	if (q->rx_head) {
@@ -735,13 +741,6 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 	}
 
 	spin_unlock_bh(&q->lock);
-
-	if (!q->rx_page.va)
-		return;
-
-	page = virt_to_page(q->rx_page.va);
-	__page_frag_cache_drain(page, q->rx_page.pagecnt_bias);
-	memset(&q->rx_page, 0, sizeof(q->rx_page));
 }
 
 static void
@@ -758,7 +757,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 	mt76_dma_rx_cleanup(dev, q);
 	mt76_dma_sync_idx(dev, q);
-	mt76_dma_rx_fill(dev, q);
+	mt76_dma_rx_fill(dev, q, false);
 }
 
 static void
@@ -775,7 +774,7 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 
 		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
 	} else {
-		skb_free_frag(data);
+		mt76_put_page_pool_buf(data, true);
 	}
 
 	if (more)
@@ -848,6 +847,8 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 			goto free_frag;
 
 		skb_reserve(skb, q->buf_offset);
+		if (mt76_is_page_from_pp(data))
+			skb_mark_for_recycle(skb);
 
 		*(u32 *)skb->cb = info;
 
@@ -863,10 +864,10 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		continue;
 
 free_frag:
-		skb_free_frag(data);
+		mt76_put_page_pool_buf(data, true);
 	}
 
-	mt76_dma_rx_fill(dev, q);
+	mt76_dma_rx_fill(dev, q, true);
 	return done;
 }
 
@@ -909,7 +910,7 @@ mt76_dma_init(struct mt76_dev *dev,
 
 	mt76_for_each_q_rx(dev, i) {
 		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll);
-		mt76_dma_rx_fill(dev, &dev->q_rx[i]);
+		mt76_dma_rx_fill(dev, &dev->q_rx[i], false);
 		napi_enable(&dev->napi[i]);
 	}
 
@@ -960,6 +961,8 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 
 		netif_napi_del(&dev->napi[i]);
 		mt76_dma_rx_cleanup(dev, q);
+
+		page_pool_destroy(q->page_pool);
 	}
 
 	mt76_free_pending_txwi(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7fe7f68acc24..9fefb441e4d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sched.h>
 #include <linux/of.h>
+#include <net/page_pool.h>
 #include "mt76.h"
 
 #define CHAN2G(_idx, _freq) {			\
@@ -556,6 +557,41 @@ void mt76_unregister_phy(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_unregister_phy);
 
+int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.pool_size = 256,
+		.flags = PP_FLAG_PAGE_FRAG,
+		.nid = NUMA_NO_NODE,
+		.dev = dev->dma_dev,
+	};
+
+	q->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(q->page_pool)) {
+		int err = PTR_ERR(q->page_pool);
+
+		q->page_pool = NULL;
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_create_page_pool);
+
+void mt76_put_page_pool_buf(void *buf, bool allow_direct)
+{
+	struct page *page = virt_to_head_page(buf);
+
+	if (!mt76_is_page_from_pp(buf)) {
+		skb_free_frag(buf);
+		return;
+	}
+
+	page_pool_put_full_page(page->pp, page, allow_direct);
+}
+EXPORT_SYMBOL_GPL(mt76_put_page_pool_buf);
+
 struct mt76_dev *
 mt76_alloc_device(struct device *pdev, unsigned int size,
 		  const struct ieee80211_ops *ops,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6ab5756b0c14..b195bb98f7ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -202,7 +202,7 @@ struct mt76_queue {
 
 	dma_addr_t desc_dma;
 	struct sk_buff *rx_head;
-	struct page_frag_cache rx_page;
+	struct page_pool *page_pool;
 };
 
 struct mt76_mcu_ops {
@@ -1402,6 +1402,13 @@ mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb, int cmd,
 	return mt76_mcu_skb_send_and_get_msg(dev, skb, cmd, wait_resp, NULL);
 }
 
+static inline bool mt76_is_page_from_pp(void *buf)
+{
+	struct page *page = virt_to_head_page(buf);
+
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
 void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr, u32 clear, u32 set);
 
 s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
@@ -1422,6 +1429,20 @@ void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked);
 struct mt76_txwi_cache *mt76_rx_token_release(struct mt76_dev *dev, int token);
 int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
 			  struct mt76_txwi_cache *r, dma_addr_t phys);
+int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q);
+void mt76_put_page_pool_buf(void *buf, bool allow_direct);
+
+static inline void *
+mt76_get_page_pool_buf(struct mt76_queue *q, u32 *offset, u32 size)
+{
+	struct page *page;
+
+	page = page_pool_dev_alloc_frag(q->page_pool, offset, size);
+	if (!page)
+		return NULL;
+
+	return page_address(page) + *offset;
+}
 
 static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 20efbf47110b..58213e590ac5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -594,13 +594,9 @@ static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
-	u32 length;
 	int i;
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-	length = SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
-				sizeof(struct skb_shared_info));
-
 	for (i = 0; i < dev->mt76.rx_token_size; i++) {
 		struct mt76_txwi_cache *t;
 
@@ -610,7 +606,7 @@ static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 
 		dma_unmap_single(dev->mt76.dma_dev, t->dma_addr,
 				 wed->wlan.rx_size, DMA_FROM_DEVICE);
-		__free_pages(virt_to_page(t->ptr), get_order(length));
+		mt76_put_page_pool_buf(t->ptr, false);
 		t->ptr = NULL;
 
 		mt76_put_rxwi(&dev->mt76, t);
@@ -623,13 +619,9 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 {
 	struct mtk_rxbm_desc *desc = wed->rx_buf_ring.desc;
 	struct mt7915_dev *dev;
-	u32 length;
 	int i;
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-	length = SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
-				sizeof(struct skb_shared_info));
-
 	for (i = 0; i < size; i++) {
 		struct mt76_txwi_cache *t = mt76_get_rxwi(&dev->mt76);
 		dma_addr_t phy_addr;
@@ -640,7 +632,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 		if (!t)
 			goto unmap;
 
-		page = __dev_alloc_pages(GFP_KERNEL, get_order(length));
+		page = __dev_alloc_page(GFP_KERNEL);
 		if (!page) {
 			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
@@ -651,7 +643,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 					  wed->wlan.rx_size,
 					  DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(dev->mt76.dev, phy_addr))) {
-			__free_pages(page, get_order(length));
+			__free_page(page);
 			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
 		}
@@ -661,7 +653,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 		if (token < 0) {
 			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
 					 wed->wlan.rx_size, DMA_TO_DEVICE);
-			__free_pages(page, get_order(length));
+			__free_page(page);
 			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 3e281715fcd4..b88959ef38aa 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -319,29 +319,27 @@ mt76u_set_endpoints(struct usb_interface *intf,
 
 static int
 mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
-		 int nsgs, gfp_t gfp)
+		 int nsgs)
 {
 	int i;
 
 	for (i = 0; i < nsgs; i++) {
-		struct page *page;
 		void *data;
 		int offset;
 
-		data = page_frag_alloc(&q->rx_page, q->buf_size, gfp);
+		data = mt76_get_page_pool_buf(q, &offset, q->buf_size);
 		if (!data)
 			break;
 
-		page = virt_to_head_page(data);
-		offset = data - page_address(page);
-		sg_set_page(&urb->sg[i], page, q->buf_size, offset);
+		sg_set_page(&urb->sg[i], virt_to_head_page(data), q->buf_size,
+			    offset);
 	}
 
 	if (i < nsgs) {
 		int j;
 
 		for (j = nsgs; j < urb->num_sgs; j++)
-			skb_free_frag(sg_virt(&urb->sg[j]));
+			mt76_put_page_pool_buf(sg_virt(&urb->sg[j]), false);
 		urb->num_sgs = i;
 	}
 
@@ -354,15 +352,16 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 
 static int
 mt76u_refill_rx(struct mt76_dev *dev, struct mt76_queue *q,
-		struct urb *urb, int nsgs, gfp_t gfp)
+		struct urb *urb, int nsgs)
 {
 	enum mt76_rxq_id qid = q - &dev->q_rx[MT_RXQ_MAIN];
+	int offset;
 
 	if (qid == MT_RXQ_MAIN && dev->usb.sg_en)
-		return mt76u_fill_rx_sg(dev, q, urb, nsgs, gfp);
+		return mt76u_fill_rx_sg(dev, q, urb, nsgs);
 
 	urb->transfer_buffer_length = q->buf_size;
-	urb->transfer_buffer = page_frag_alloc(&q->rx_page, q->buf_size, gfp);
+	urb->transfer_buffer = mt76_get_page_pool_buf(q, &offset, q->buf_size);
 
 	return urb->transfer_buffer ? 0 : -ENOMEM;
 }
@@ -400,7 +399,7 @@ mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue *q,
 	if (err)
 		return err;
 
-	return mt76u_refill_rx(dev, q, e->urb, sg_size, GFP_KERNEL);
+	return mt76u_refill_rx(dev, q, e->urb, sg_size);
 }
 
 static void mt76u_urb_free(struct urb *urb)
@@ -408,10 +407,10 @@ static void mt76u_urb_free(struct urb *urb)
 	int i;
 
 	for (i = 0; i < urb->num_sgs; i++)
-		skb_free_frag(sg_virt(&urb->sg[i]));
+		mt76_put_page_pool_buf(sg_virt(&urb->sg[i]), false);
 
 	if (urb->transfer_buffer)
-		skb_free_frag(urb->transfer_buffer);
+		mt76_put_page_pool_buf(urb->transfer_buffer, false);
 
 	usb_free_urb(urb);
 }
@@ -547,6 +546,8 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
 		len -= data_len;
 		nsgs++;
 	}
+
+	skb_mark_for_recycle(skb);
 	dev->drv->rx_skb(dev, MT_RXQ_MAIN, skb, NULL);
 
 	return nsgs;
@@ -612,7 +613,7 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 		count = mt76u_process_rx_entry(dev, urb, q->buf_size);
 		if (count > 0) {
-			err = mt76u_refill_rx(dev, q, urb, count, GFP_ATOMIC);
+			err = mt76u_refill_rx(dev, q, urb, count);
 			if (err < 0)
 				break;
 		}
@@ -663,6 +664,10 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	struct mt76_queue *q = &dev->q_rx[qid];
 	int i, err;
 
+	err = mt76_create_page_pool(dev, q);
+	if (err)
+		return err;
+
 	spin_lock_init(&q->lock);
 	q->entry = devm_kcalloc(dev->dev,
 				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
@@ -691,7 +696,6 @@ EXPORT_SYMBOL_GPL(mt76u_alloc_mcu_queue);
 static void
 mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	struct page *page;
 	int i;
 
 	for (i = 0; i < q->ndesc; i++) {
@@ -701,13 +705,7 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		mt76u_urb_free(q->entry[i].urb);
 		q->entry[i].urb = NULL;
 	}
-
-	if (!q->rx_page.va)
-		return;
-
-	page = virt_to_page(q->rx_page.va);
-	__page_frag_cache_drain(page, q->rx_page.pagecnt_bias);
-	memset(&q->rx_page, 0, sizeof(q->rx_page));
+	page_pool_destroy(q->page_pool);
 }
 
 static void mt76u_free_rx(struct mt76_dev *dev)
-- 
2.39.0

