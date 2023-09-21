Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A057AA112
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjIUU57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjIUU5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:57:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A9F7EA27
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F458C3279D;
        Thu, 21 Sep 2023 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293028;
        bh=6cIXfOe0K6ze7eTH40ZzlFmMUg+Xi64dGsArrarMuzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSMzYtZ712Ol+/dvMxb39eaHDRpAg6hsDvcn58xe2C668qhN30wmwvOxD9NxLcI9w
         2YuODyh1ZSerpwRf+kTG302uTb/9RobpEpxIUOSovYGEItNz5k0HngUf+0/WmejG8I
         NF34AIAbdBuw6WoIV9UJrJsmp0FD/mOMfDOXeYYRZvCHq+4Jlwp/IECZ1LqSOLT+s4
         nNmm/hUG0cRt3MzF5prSr4Rrq4UANFeGWuF49NtM4Fb/nW+EvRplXW9D3j7VeYy0rK
         eeuOFYWlQe8Fz9lpvGwpDoxAf6hPopPIRCZfZeNtlkLHhJHse02QgKjIR559/waMzn
         /OmsJabX1NhHQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/9] wifi: mt76: mmio: move mt76_mmio_wed_{init,release}_rx_buf in common code
Date:   Thu, 21 Sep 2023 12:43:30 +0200
Message-ID: <b6fceff5fee5d6b418767d6b121379b42c5aea6f.1695292502.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695292502.git.lorenzo@kernel.org>
References: <cover.1695292502.git.lorenzo@kernel.org>
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

Move mt76_mmio_wed_init_rx_buf and mt76_mmio_wed_release_rx_buf routines
in common code.
This is a preliminary patch to introduce WED support for mt7996

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mmio.c     | 75 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 ++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 78 +------------------
 3 files changed, 82 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 86e3d2ac4d0d..350650a0fce2 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -4,6 +4,7 @@
  */
 
 #include "mt76.h"
+#include "dma.h"
 #include "trace.h"
 
 static u32 mt76_mmio_rr(struct mt76_dev *dev, u32 offset)
@@ -84,6 +85,80 @@ void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr,
 }
 EXPORT_SYMBOL_GPL(mt76_set_irq_mask);
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+void mt76_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
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
+EXPORT_SYMBOL_GPL(mt76_mmio_wed_release_rx_buf);
+
+u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
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
+	mt76_mmio_wed_release_rx_buf(wed);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(mt76_mmio_wed_init_rx_buf);
+#endif /*CONFIG_NET_MEDIATEK_SOC_WED */
+
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs)
 {
 	static const struct mt76_bus_ops mt76_mmio_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fede40cf86b7..7e43a800d378 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1057,6 +1057,11 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 	return dev->rev & 0xffff;
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
+void mt76_mmio_wed_release_rx_buf(struct mtk_wed_device *wed);
+#endif /*CONFIG_NET_MEDIATEK_SOC_WED */
+
 #define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
 #define mt76xx_rev(dev) mt76_rev(&((dev)->mt76))
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index e7d8e03f826f..1621a8150798 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -567,80 +567,6 @@ static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 	spin_unlock_bh(&dev->mt76.token_lock);
 }
 
-static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
-{
-	struct mt7915_dev *dev;
-	int i;
-
-	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-	for (i = 0; i < dev->mt76.rx_token_size; i++) {
-		struct mt76_txwi_cache *t;
-
-		t = mt76_rx_token_release(&dev->mt76, i);
-		if (!t || !t->ptr)
-			continue;
-
-		mt76_put_page_pool_buf(t->ptr, false);
-		t->ptr = NULL;
-
-		mt76_put_rxwi(&dev->mt76, t);
-	}
-
-	mt76_free_pending_rxwi(&dev->mt76);
-}
-
-static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
-{
-	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
-	struct mt76_txwi_cache *t = NULL;
-	struct mt7915_dev *dev;
-	struct mt76_queue *q;
-	int i, len;
-
-	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-	q = &dev->mt76.q_rx[MT_RXQ_MAIN];
-	len = SKB_WITH_OVERHEAD(q->buf_size);
-
-	for (i = 0; i < size; i++) {
-		enum dma_data_direction dir;
-		dma_addr_t addr;
-		u32 offset;
-		int token;
-		void *buf;
-
-		t = mt76_get_rxwi(&dev->mt76);
-		if (!t)
-			goto unmap;
-
-		buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
-		if (!buf)
-			goto unmap;
-
-		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
-		dir = page_pool_get_dma_dir(q->page_pool);
-		dma_sync_single_for_device(dev->mt76.dma_dev, addr, len, dir);
-
-		desc->buf0 = cpu_to_le32(addr);
-		token = mt76_rx_token_consume(&dev->mt76, buf, t, addr);
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
-		mt76_put_rxwi(&dev->mt76, t);
-	mt7915_mmio_wed_release_rx_buf(wed);
-	return -ENOMEM;
-}
-
 static void mt7915_mmio_wed_update_rx_stats(struct mtk_wed_device *wed,
 					    struct mtk_wed_wo_rx_stats *stats)
 {
@@ -780,8 +706,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.init_buf = mt7915_wed_init_buf;
 	wed->wlan.offload_enable = mt7915_mmio_wed_offload_enable;
 	wed->wlan.offload_disable = mt7915_mmio_wed_offload_disable;
-	wed->wlan.init_rx_buf = mt7915_mmio_wed_init_rx_buf;
-	wed->wlan.release_rx_buf = mt7915_mmio_wed_release_rx_buf;
+	wed->wlan.init_rx_buf = mt76_mmio_wed_init_rx_buf;
+	wed->wlan.release_rx_buf = mt76_mmio_wed_release_rx_buf;
 	wed->wlan.update_wo_rx_stats = mt7915_mmio_wed_update_rx_stats;
 	wed->wlan.reset = mt7915_mmio_wed_reset;
 	wed->wlan.reset_complete = mt7915_mmio_wed_reset_complete;
-- 
2.41.0

