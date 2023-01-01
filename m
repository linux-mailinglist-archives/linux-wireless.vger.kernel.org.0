Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B389865A9E6
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjAAMAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 07:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjAAMAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 07:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F45C26DF
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 04:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A24760DC1
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 12:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D3C433EF;
        Sun,  1 Jan 2023 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574415;
        bh=3+jYWPrA54QtaZ4aweVvXqDlAkz42vn8mXF/RN/qKTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnBfCfyCllPXB7gSaBUUy/rY57fBZZR8tIF4f6HkcAEHrS+rxTAFpG+Y4zvoofT+U
         pNt6auDmDPyBL3mRjSuJx/H6aipbwLxO6acrJnFY7H1ElzT5hlGkGXQBB52Y/gmg46
         4+fFd+HlrVOa14GeuNy/P97HEm1bNwK/qTA9R4wE546HsQjqBc4vbkJ7EUC18JuJAx
         E/x8sGL0YzUwCKsDcvT42tYaEk2H4JUqlrd5ocU5qBr56SvGLuVvuQsDHSY1tB/Wz6
         n+EZYEdQbn8gBtqqt3n4wfTKX9/YlFMx8p8IgDOl723nUlM/E9Yf+HM/EhwgDmi9xa
         YIUeXAzE/qr6A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] wifi: mt76: dma: keep rx pages DMA mapped
Date:   Sun,  1 Jan 2023 12:59:58 +0100
Message-Id: <36edaadfa36577f58611fb4b946acb1a4cd1151a.1672574310.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672574310.git.lorenzo@kernel.org>
References: <cover.1672574310.git.lorenzo@kernel.org>
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

For mmio devices rely on page_pool capability to keep rx buffers DMA
mapped and just sync rx buffers before accessing them.

Tested-by: Felix Fietkau <nbd@nbd.name>
Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 34 +++++++++++--------
 drivers/net/wireless/mediatek/mt76/mac80211.c |  8 +++++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  5 +--
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 4f5b4068d35e..2284ce4fd7cb 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -406,9 +406,14 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 		if (!t)
 			return NULL;
 
-		dma_unmap_single(dev->dma_dev, t->dma_addr,
-				 SKB_WITH_OVERHEAD(q->buf_size),
-				 DMA_FROM_DEVICE);
+		if (mt76_is_page_from_pp(t->ptr))
+			dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr,
+					SKB_WITH_OVERHEAD(q->buf_size),
+					page_pool_get_dma_dir(q->page_pool));
+		else
+			dma_unmap_single(dev->dma_dev, t->dma_addr,
+					 SKB_WITH_OVERHEAD(q->buf_size),
+					 DMA_FROM_DEVICE);
 
 		buf = t->ptr;
 		t->dma_addr = 0;
@@ -425,9 +430,14 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	} else {
 		buf = e->buf;
 		e->buf = NULL;
-		dma_unmap_single(dev->dma_dev, e->dma_addr[0],
-				 SKB_WITH_OVERHEAD(q->buf_size),
-				 DMA_FROM_DEVICE);
+		if (mt76_is_page_from_pp(buf))
+			dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
+					SKB_WITH_OVERHEAD(q->buf_size),
+					page_pool_get_dma_dir(q->page_pool));
+		else
+			dma_unmap_single(dev->dma_dev, e->dma_addr[0],
+					 SKB_WITH_OVERHEAD(q->buf_size),
+					 DMA_FROM_DEVICE);
 	}
 
 	return buf;
@@ -591,6 +601,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 	spin_lock_bh(&q->lock);
 
 	while (q->queued < q->ndesc - 1) {
+		enum dma_data_direction dir;
 		struct mt76_queue_buf qbuf;
 		dma_addr_t addr;
 		int offset;
@@ -600,19 +611,14 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 		if (!buf)
 			break;
 
-		addr = dma_map_single(dev->dma_dev, buf + offset, len,
-				      DMA_FROM_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
-			mt76_put_page_pool_buf(buf, allow_direct);
-			break;
-		}
+		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
+		dir = page_pool_get_dma_dir(q->page_pool);
+		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
 
 		qbuf.addr = addr + q->buf_offset;
 		qbuf.len = len - q->buf_offset;
 		qbuf.skip_unmap = false;
 		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
-			dma_unmap_single(dev->dma_dev, addr, len,
-					 DMA_FROM_DEVICE);
 			mt76_put_page_pool_buf(buf, allow_direct);
 			break;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9fefb441e4d4..3d6b6f12ffde 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -567,6 +567,14 @@ int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 		.dev = dev->dma_dev,
 	};
 
+	if (mt76_is_mmio(dev)) {
+		/* rely on page_pool for DMA mapping */
+		pp_params.flags |= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+		pp_params.max_len = PAGE_SIZE;
+		pp_params.offset = 0;
+	}
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 30ec490b47b6..757c2e25c25f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -604,8 +604,9 @@ static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 		if (!t || !t->ptr)
 			continue;
 
-		dma_unmap_single(dev->mt76.dma_dev, t->dma_addr,
-				 wed->wlan.rx_size, DMA_FROM_DEVICE);
+		if (!mt76_is_page_from_pp(t->ptr))
+			dma_unmap_single(dev->mt76.dma_dev, t->dma_addr,
+					 wed->wlan.rx_size, DMA_FROM_DEVICE);
 		mt76_put_page_pool_buf(t->ptr, false);
 		t->ptr = NULL;
 
-- 
2.38.1

