Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7A626A4E
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiKLPlU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiKLPlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933FB1AF23
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F1DCB80939
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDFEC433C1;
        Sat, 12 Nov 2022 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267672;
        bh=Fihg4p2BFTjsqbeeU15jY7smfP+B7WaXMpa+VG00LQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cW+iUruVx4hvuqM2XDmxQufyaWEnDB+4fGLowdwYUygX/Wzeye7Gyg/jSHd+8y+Bs
         Xm4/9fbDZYLkIpRGW/9XzVy/5KFLq6JvBZhdRF/q6yCbRPeAGfa4bzxhHZZD8zyArd
         eQs/EvoQASdCyotVs0eCGazqtOwNruaMECc3B4dUdWYdlJSUYhOFmwmQQ+aTD6mwwK
         RXxJcs50CHcFDghrTk3w92hOgctwxmBxAu3n08C3r21n6WkOaNfFqm9Hjr8nmLQ0rl
         Md+ZfJmw4CwiEhKp0LdX/j7mH49nQSpGxbaU5RCdf3U831pvPpOw1VzAu9V1Y7CjRM
         s+8PftYSD8u4w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 2/8] wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf
Date:   Sat, 12 Nov 2022 16:40:35 +0100
Message-Id: <8d45b937b799d37ae5f306320212070388548999.1668267241.git.lorenzo@kernel.org>
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

Introduce the capability to configure RX WED in mt76_dma_{add,get}_buf
utility routines.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 125 +++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt76.h |   2 +
 2 files changed, 88 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index d316bde01c6b..4239adde4cca 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -215,11 +215,6 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	u32 ctrl;
 	int i, idx = -1;
 
-	if (txwi) {
-		q->entry[q->head].txwi = DMA_DUMMY_DATA;
-		q->entry[q->head].skip_buf0 = true;
-	}
-
 	for (i = 0; i < nbufs; i += 2, buf += 2) {
 		u32 buf0 = buf[0].addr, buf1 = 0;
 
@@ -229,28 +224,48 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		desc = &q->desc[idx];
 		entry = &q->entry[idx];
 
-		if (buf[0].skip_unmap)
-			entry->skip_buf0 = true;
-		entry->skip_buf1 = i == nbufs - 1;
-
-		entry->dma_addr[0] = buf[0].addr;
-		entry->dma_len[0] = buf[0].len;
-
-		ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
-		if (i < nbufs - 1) {
-			entry->dma_addr[1] = buf[1].addr;
-			entry->dma_len[1] = buf[1].len;
-			buf1 = buf[1].addr;
-			ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
-			if (buf[1].skip_unmap)
-				entry->skip_buf1 = true;
+		if ((q->flags & MT_QFLAG_WED) &&
+		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
+			struct mt76_txwi_cache *t = txwi;
+			int rx_token;
+
+			if (!t)
+				return -ENOMEM;
+
+			rx_token = mt76_rx_token_consume(dev, (void *)skb, t,
+							 buf[0].addr);
+			buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
+			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
+			       MT_DMA_CTL_TO_HOST;
+		} else {
+			if (txwi) {
+				q->entry[q->head].txwi = DMA_DUMMY_DATA;
+				q->entry[q->head].skip_buf0 = true;
+			}
+
+			if (buf[0].skip_unmap)
+				entry->skip_buf0 = true;
+			entry->skip_buf1 = i == nbufs - 1;
+
+			entry->dma_addr[0] = buf[0].addr;
+			entry->dma_len[0] = buf[0].len;
+
+			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+			if (i < nbufs - 1) {
+				entry->dma_addr[1] = buf[1].addr;
+				entry->dma_len[1] = buf[1].len;
+				buf1 = buf[1].addr;
+				ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
+				if (buf[1].skip_unmap)
+					entry->skip_buf1 = true;
+			}
+
+			if (i == nbufs - 1)
+				ctrl |= MT_DMA_CTL_LAST_SEC0;
+			else if (i == nbufs - 2)
+				ctrl |= MT_DMA_CTL_LAST_SEC1;
 		}
 
-		if (i == nbufs - 1)
-			ctrl |= MT_DMA_CTL_LAST_SEC0;
-		else if (i == nbufs - 2)
-			ctrl |= MT_DMA_CTL_LAST_SEC1;
-
 		WRITE_ONCE(desc->buf0, cpu_to_le32(buf0));
 		WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
 		WRITE_ONCE(desc->info, cpu_to_le32(info));
@@ -339,33 +354,60 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 
 static void *
 mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
-		 int *len, u32 *info, bool *more)
+		 int *len, u32 *info, bool *more, bool *drop)
 {
 	struct mt76_queue_entry *e = &q->entry[idx];
 	struct mt76_desc *desc = &q->desc[idx];
-	dma_addr_t buf_addr;
-	void *buf = e->buf;
-	int buf_len = SKB_WITH_OVERHEAD(q->buf_size);
+	void *buf;
 
-	buf_addr = e->dma_addr[0];
 	if (len) {
-		u32 ctl = le32_to_cpu(READ_ONCE(desc->ctrl));
-		*len = FIELD_GET(MT_DMA_CTL_SD_LEN0, ctl);
-		*more = !(ctl & MT_DMA_CTL_LAST_SEC0);
+		u32 ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
+		*len = FIELD_GET(MT_DMA_CTL_SD_LEN0, ctrl);
+		*more = !(ctrl & MT_DMA_CTL_LAST_SEC0);
 	}
 
 	if (info)
 		*info = le32_to_cpu(desc->info);
 
-	dma_unmap_single(dev->dma_dev, buf_addr, buf_len, DMA_FROM_DEVICE);
-	e->buf = NULL;
+	if ((q->flags & MT_QFLAG_WED) &&
+	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
+		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN,
+				      le32_to_cpu(desc->buf1));
+		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
+
+		if (!t)
+			return NULL;
+
+		dma_unmap_single(dev->dma_dev, t->dma_addr,
+				 SKB_WITH_OVERHEAD(q->buf_size),
+				 DMA_FROM_DEVICE);
+
+		buf = t->ptr;
+		t->dma_addr = 0;
+		t->ptr = NULL;
+
+		mt76_put_rxwi(dev, t);
+
+		if (drop) {
+			u32 ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
+
+			*drop = !!(ctrl & (MT_DMA_CTL_TO_HOST_A |
+					   MT_DMA_CTL_DROP));
+		}
+	} else {
+		buf = e->buf;
+		e->buf = NULL;
+		dma_unmap_single(dev->dma_dev, e->dma_addr[0],
+				 SKB_WITH_OVERHEAD(q->buf_size),
+				 DMA_FROM_DEVICE);
+	}
 
 	return buf;
 }
 
 static void *
 mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
-		 int *len, u32 *info, bool *more)
+		 int *len, u32 *info, bool *more, bool *drop)
 {
 	int idx = q->tail;
 
@@ -381,7 +423,7 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued--;
 
-	return mt76_dma_get_buf(dev, q, idx, len, info, more);
+	return mt76_dma_get_buf(dev, q, idx, len, info, more, drop);
 }
 
 static int
@@ -641,7 +683,7 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 
 	spin_lock_bh(&q->lock);
 	do {
-		buf = mt76_dma_dequeue(dev, q, true, NULL, NULL, &more);
+		buf = mt76_dma_dequeue(dev, q, true, NULL, NULL, &more, NULL);
 		if (!buf)
 			break;
 
@@ -723,6 +765,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 	}
 
 	while (done < budget) {
+		bool drop = false;
 		u32 info;
 
 		if (check_ddone) {
@@ -733,10 +776,14 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 				break;
 		}
 
-		data = mt76_dma_dequeue(dev, q, false, &len, &info, &more);
+		data = mt76_dma_dequeue(dev, q, false, &len, &info, &more,
+					&drop);
 		if (!data)
 			break;
 
+		if (drop)
+			goto free_frag;
+
 		if (q->rx_head)
 			data_len = q->buf_size;
 		else
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 149dc6eb7eb9..738fb22d9198 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -35,6 +35,7 @@
 				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
 				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
 #define MT_WED_Q_TX(_n)		__MT_WED_Q(MT76_WED_Q_TX, _n)
+#define MT_WED_Q_RX(_n)		__MT_WED_Q(MT76_WED_Q_RX, _n)
 #define MT_WED_Q_TXFREE		__MT_WED_Q(MT76_WED_Q_TXFREE, 0)
 
 struct mt76_dev;
@@ -56,6 +57,7 @@ enum mt76_bus_type {
 enum mt76_wed_type {
 	MT76_WED_Q_TX,
 	MT76_WED_Q_TXFREE,
+	MT76_WED_Q_RX,
 };
 
 struct mt76_bus_ops {
-- 
2.38.1

