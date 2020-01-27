Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE89014A9B2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 19:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA0SSB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 13:18:01 -0500
Received: from nbd.name ([46.4.11.11]:48210 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbgA0SR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JbYyoO3rivGUAtL9BlROcTesawaWNKeIr03/mn5nGnI=; b=iwT7BlFojv5pJkV66zhNM+ExDJ
        TuZIkNAi5Z3M4QjsT3WWTzdWrL6lvc53VB3H/EEMHwI9jyogZ/6HWfoDU3L5/Vtz/XsmxGKB+wxHZ
        JVoY/bWEFXTV8+9Ie8IJyZmgA1Kg4WOGapsXaGWyGlAK/Sa5HofSLgOUHFs5wC5XteCY=;
Received: from [178.162.209.132] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iw8xP-0007dd-KD
        for linux-wireless@vger.kernel.org; Mon, 27 Jan 2020 19:17:55 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 20C017A566E5; Mon, 27 Jan 2020 19:17:54 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/5] mt76: dma: do not write cpu_idx on rx queue reset until after refill
Date:   Mon, 27 Jan 2020 19:17:52 +0100
Message-Id: <20200127181754.2810-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127181754.2810-1-nbd@nbd.name>
References: <20200127181754.2810-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware should only start processing the ring after at least one
buffer has been added

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index bcb11bb9aeeb..e5dd7080e88e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -132,6 +132,11 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 	writel(q->ndesc, &q->regs->ring_size);
 	q->head = readl(&q->regs->dma_idx);
 	q->tail = q->head;
+}
+
+static void
+mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
 	writel(q->head, &q->regs->cpu_idx);
 }
 
@@ -193,8 +198,10 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 		dev->q_tx[__MT_TXQ_MAX + i].swq_queued -= n_swq_queued[4 + i];
 	}
 
-	if (flush)
+	if (flush) {
 		mt76_dma_sync_idx(dev, q);
+		mt76_dma_kick_queue(dev, q);
+	}
 
 	wake = wake && q->stopped &&
 	       qid < IEEE80211_NUM_ACS && q->queued < q->ndesc - 8;
@@ -257,12 +264,6 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 	return mt76_dma_get_buf(dev, q, idx, len, info, more);
 }
 
-static void
-mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
-{
-	writel(q->head, &q->regs->cpu_idx);
-}
-
 static int
 mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 			  struct sk_buff *skb, u32 tx_info)
-- 
2.24.0

