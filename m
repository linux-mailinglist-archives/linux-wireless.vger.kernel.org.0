Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A795D66DF81
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 14:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjAQNxx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 08:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjAQNxs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 08:53:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC49B44AC
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 05:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B644B8163C
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 13:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE06C433EF;
        Tue, 17 Jan 2023 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673963623;
        bh=H1eSKI8zTPmTQJTSjqikOvMN4PvdIW6wboQpg45mihE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzpZ04ixs152k4AcqPF3QaXDbWpls1B65O7w3o496EiL3ovnt3GZeP0iWHzecLn+c
         a7jJn45L/WTxElgPZR8PfX+m+iAT+uVbDhBj9/ljVvswogvCcVH45+T6xcoTNat9bo
         P9ERdOO9gI5v9JVNYpaXfjWM7z6J+RYnLiTybcEdQTB8hNFY6kp1eLAxVJ4dugmtPg
         5PZ3FUQLPNSYdGk/UrqVuE3XqZWubP6V/l9fMzxO3vNJwhr5nlvkAz1CWq0o/qKz+c
         G6hdiyCX+MsQvMyoMRz+muVTA19enwQYAfxBAEqMqkdrJXA+4HwJq4DEHObuiQ9ysH
         2WGUPbrXRDupg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 3/4] wifi: mt76: dma: keep rx pages DMA mapped
Date:   Tue, 17 Jan 2023 14:53:16 +0100
Message-Id: <68081e02cbe2afa2d35c8aa93194f0adddbd0f05.1673963374.git.lorenzo@kernel.org>
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
index 7fd9aa9c3d9e..33e47ea0368e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -407,9 +407,14 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
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
@@ -426,9 +431,14 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
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
@@ -592,6 +602,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 	spin_lock_bh(&q->lock);
 
 	while (q->queued < q->ndesc - 1) {
+		enum dma_data_direction dir;
 		struct mt76_queue_buf qbuf;
 		dma_addr_t addr;
 		int offset;
@@ -601,19 +612,14 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
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
index 58213e590ac5..3ab2e5bf7d45 100644
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
2.39.0

