Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D72621D2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgIHVST (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgIHVSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:18:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83099C061796
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XXxZBDhySO0WuRgLWpxJLdN3KEz/uNNbQLoP3xfQhlA=; b=jmGwG9BFNc3oKKpKASU3DsW1n/
        /5r3f/Lo84hFfEQDwuteop4h8g3s4T1N1D523v/D6f03dVTbl0TJ6GD0jB2C/m/VuuUFg5lgOpcBt
        ngCDNoZ6x8941R+OAI49Blguqi4nakaaC5EH+3uitwfQGbVTmg/ROS3SxBEUssRa7NQ0=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl03-0002Cx-8a
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:17:59 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/11] mt76: dma: cache dma map address/len in struct mt76_queue_entry
Date:   Tue,  8 Sep 2020 23:17:52 +0200
Message-Id: <20200908211756.15998-7-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908211756.15998-1-nbd@nbd.name>
References: <20200908211756.15998-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Accessing them from uncached memory can be expensive, so it's cheaper to
cache them

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 43 +++++++++++------------
 drivers/net/wireless/mediatek/mt76/mt76.h |  2 ++
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 7f669a2432a4..38cc40c99ba1 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -49,6 +49,7 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		 struct mt76_queue_buf *buf, int nbufs, u32 info,
 		 struct sk_buff *skb, void *txwi)
 {
+	struct mt76_queue_entry *entry;
 	struct mt76_desc *desc;
 	u32 ctrl;
 	int i, idx = -1;
@@ -61,16 +62,27 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	for (i = 0; i < nbufs; i += 2, buf += 2) {
 		u32 buf0 = buf[0].addr, buf1 = 0;
 
+		idx = q->head;
+		q->head = (q->head + 1) % q->ndesc;
+
+		desc = &q->desc[idx];
+		entry = &q->entry[idx];
+
 		if (buf[0].skip_unmap)
-			q->entry[q->head].skip_buf0 = true;
-		q->entry[q->head].skip_buf1 = i == nbufs - 1;
+			entry->skip_buf0 = true;
+		entry->skip_buf1 = i == nbufs - 1;
+
+		entry->dma_addr[0] = buf[0].addr;
+		entry->dma_len[0] = buf[0].len;
 
 		ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
 		if (i < nbufs - 1) {
+			entry->dma_addr[1] = buf[1].addr;
+			entry->dma_len[1] = buf[1].len;
 			buf1 = buf[1].addr;
 			ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
 			if (buf[1].skip_unmap)
-				q->entry[q->head].skip_buf1 = true;
+				entry->skip_buf1 = true;
 		}
 
 		if (i == nbufs - 1)
@@ -78,11 +90,6 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		else if (i == nbufs - 2)
 			ctrl |= MT_DMA_CTL_LAST_SEC1;
 
-		idx = q->head;
-		q->head = (q->head + 1) % q->ndesc;
-
-		desc = &q->desc[idx];
-
 		WRITE_ONCE(desc->buf0, cpu_to_le32(buf0));
 		WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
 		WRITE_ONCE(desc->info, cpu_to_le32(info));
@@ -102,24 +109,14 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 			struct mt76_queue_entry *prev_e)
 {
 	struct mt76_queue_entry *e = &q->entry[idx];
-	__le32 __ctrl = READ_ONCE(q->desc[idx].ctrl);
-	u32 ctrl = le32_to_cpu(__ctrl);
-
-	if (!e->skip_buf0) {
-		__le32 addr = READ_ONCE(q->desc[idx].buf0);
-		u32 len = FIELD_GET(MT_DMA_CTL_SD_LEN0, ctrl);
 
-		dma_unmap_single(dev->dev, le32_to_cpu(addr), len,
+	if (!e->skip_buf0)
+		dma_unmap_single(dev->dev, e->dma_addr[0], e->dma_len[0],
 				 DMA_TO_DEVICE);
-	}
-
-	if (!e->skip_buf1) {
-		__le32 addr = READ_ONCE(q->desc[idx].buf1);
-		u32 len = FIELD_GET(MT_DMA_CTL_SD_LEN1, ctrl);
 
-		dma_unmap_single(dev->dev, le32_to_cpu(addr), len,
+	if (!e->skip_buf1)
+		dma_unmap_single(dev->dev, e->dma_addr[1], e->dma_len[1],
 				 DMA_TO_DEVICE);
-	}
 
 	if (e->txwi == DMA_DUMMY_DATA)
 		e->txwi = NULL;
@@ -207,7 +204,7 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	void *buf = e->buf;
 	int buf_len = SKB_WITH_OVERHEAD(q->buf_size);
 
-	buf_addr = le32_to_cpu(READ_ONCE(desc->buf0));
+	buf_addr = e->dma_addr[0];
 	if (len) {
 		u32 ctl = le32_to_cpu(READ_ONCE(desc->ctrl));
 		*len = FIELD_GET(MT_DMA_CTL_SD_LEN0, ctl);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2d44fe522ade..9dbb7dd65d23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -102,6 +102,8 @@ struct mt76_queue_entry {
 		struct urb *urb;
 		int buf_sz;
 	};
+	u32 dma_addr[2];
+	u16 dma_len[2];
 	u16 wcid;
 	bool skip_buf0:1;
 	bool skip_buf1:1;
-- 
2.28.0

