Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16A669502
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbjAMLKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 06:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241224AbjAMLJX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 06:09:23 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B337A3B3
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 02:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0NgcIivsf4RcoR1cBLc1R04qoCHt+GVGjqSHuvuxaBU=; b=dggbA8VbsnbE278nSe4xWnZMdE
        bzc0Y2812tikec39N7Yp22t8V+7l10gO38lhNhbmKE05sI+OPjFLcWu5NFqgsqV9zJuS6nm3sRvPm
        rT7NGo8TyXucDIds//wAICtwOHRK23eM90Q+71zwA/NCjv0H8F8qGxfz9y6D0jyiZ+eo=;
Received: from [37.59.164.104] (helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pGHm3-00GQpV-4k; Fri, 13 Jan 2023 11:59:03 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH wireless 3/3] wifi: mt76: dma: fix a regression in adding rx buffers
Date:   Fri, 13 Jan 2023 11:58:48 +0100
Message-Id: <20230113105848.34642-3-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113105848.34642-1-nbd@nbd.name>
References: <20230113105848.34642-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When adding WED support, mt76_dma_add_buf was accidentally changed to set
the skip_buf0 flag for tx buffers on the wrong queue descriptor entry.
Additionally, there is a rxwi leak when rx buffer allocation fails.

Fix this and make the code more readable by adding a separate function for
adding rx buffers.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Fixes: cd372b8c99c5 ("wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 124 +++++++++++++----------
 1 file changed, 72 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 61a8ab9e1db5..06161815c180 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -205,6 +205,52 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
 	mt76_dma_sync_idx(dev, q);
 }
 
+static int
+mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
+		    struct mt76_queue_buf *buf, void *data)
+{
+	struct mt76_desc *desc = &q->desc[q->head];
+	struct mt76_queue_entry *entry = &q->entry[q->head];
+	struct mt76_txwi_cache *txwi = NULL;
+	u32 buf1 = 0, ctrl;
+	int idx = q->head;
+	int rx_token;
+
+	ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+
+	if ((q->flags & MT_QFLAG_WED) &&
+	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
+		txwi = mt76_get_rxwi(dev);
+		if (!txwi)
+			return -ENOMEM;
+
+		rx_token = mt76_rx_token_consume(dev, data, txwi, buf->addr);
+		if (rx_token < 0) {
+			mt76_put_rxwi(dev, txwi);
+			return -ENOMEM;
+		}
+
+		buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
+		ctrl |= MT_DMA_CTL_TO_HOST;
+	}
+
+	WRITE_ONCE(desc->buf0, cpu_to_le32(buf->addr));
+	WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
+	WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
+	WRITE_ONCE(desc->info, 0);
+
+	entry->dma_addr[0] = buf->addr;
+	entry->dma_len[0] = buf->len;
+	entry->txwi = txwi;
+	entry->buf = data;
+	entry->wcid = 0xffff;
+	entry->skip_buf1 = true;
+	q->head = (q->head + 1) % q->ndesc;
+	q->queued++;
+
+	return idx;
+}
+
 static int
 mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		 struct mt76_queue_buf *buf, int nbufs, u32 info,
@@ -215,6 +261,11 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	int i, idx = -1;
 	u32 ctrl, next;
 
+	if (txwi) {
+		q->entry[q->head].txwi = DMA_DUMMY_DATA;
+		q->entry[q->head].skip_buf0 = true;
+	}
+
 	for (i = 0; i < nbufs; i += 2, buf += 2) {
 		u32 buf0 = buf[0].addr, buf1 = 0;
 
@@ -224,51 +275,28 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		desc = &q->desc[idx];
 		entry = &q->entry[idx];
 
-		if ((q->flags & MT_QFLAG_WED) &&
-		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
-			struct mt76_txwi_cache *t = txwi;
-			int rx_token;
-
-			if (!t)
-				return -ENOMEM;
-
-			rx_token = mt76_rx_token_consume(dev, (void *)skb, t,
-							 buf[0].addr);
-			if (rx_token < 0)
-				return -ENOMEM;
-
-			buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
-			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
-			       MT_DMA_CTL_TO_HOST;
-		} else {
-			if (txwi) {
-				q->entry[next].txwi = DMA_DUMMY_DATA;
-				q->entry[next].skip_buf0 = true;
-			}
-
-			if (buf[0].skip_unmap)
-				entry->skip_buf0 = true;
-			entry->skip_buf1 = i == nbufs - 1;
-
-			entry->dma_addr[0] = buf[0].addr;
-			entry->dma_len[0] = buf[0].len;
-
-			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
-			if (i < nbufs - 1) {
-				entry->dma_addr[1] = buf[1].addr;
-				entry->dma_len[1] = buf[1].len;
-				buf1 = buf[1].addr;
-				ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
-				if (buf[1].skip_unmap)
-					entry->skip_buf1 = true;
-			}
-
-			if (i == nbufs - 1)
-				ctrl |= MT_DMA_CTL_LAST_SEC0;
-			else if (i == nbufs - 2)
-				ctrl |= MT_DMA_CTL_LAST_SEC1;
+		if (buf[0].skip_unmap)
+			entry->skip_buf0 = true;
+		entry->skip_buf1 = i == nbufs - 1;
+
+		entry->dma_addr[0] = buf[0].addr;
+		entry->dma_len[0] = buf[0].len;
+
+		ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+		if (i < nbufs - 1) {
+			entry->dma_addr[1] = buf[1].addr;
+			entry->dma_len[1] = buf[1].len;
+			buf1 = buf[1].addr;
+			ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
+			if (buf[1].skip_unmap)
+				entry->skip_buf1 = true;
 		}
 
+		if (i == nbufs - 1)
+			ctrl |= MT_DMA_CTL_LAST_SEC0;
+		else if (i == nbufs - 2)
+			ctrl |= MT_DMA_CTL_LAST_SEC1;
+
 		WRITE_ONCE(desc->buf0, cpu_to_le32(buf0));
 		WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
 		WRITE_ONCE(desc->info, cpu_to_le32(info));
@@ -581,17 +609,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 	spin_lock_bh(&q->lock);
 
 	while (q->queued < q->ndesc - 1) {
-		struct mt76_txwi_cache *t = NULL;
 		struct mt76_queue_buf qbuf;
 		void *buf = NULL;
 
-		if ((q->flags & MT_QFLAG_WED) &&
-		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
-			t = mt76_get_rxwi(dev);
-			if (!t)
-				break;
-		}
-
 		buf = page_frag_alloc(rx_page, q->buf_size, GFP_ATOMIC);
 		if (!buf)
 			break;
@@ -605,7 +625,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 		qbuf.addr = addr + offset;
 		qbuf.len = len - offset;
 		qbuf.skip_unmap = false;
-		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
+		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
 			dma_unmap_single(dev->dma_dev, addr, len,
 					 DMA_FROM_DEVICE);
 			skb_free_frag(buf);
-- 
2.39.0

