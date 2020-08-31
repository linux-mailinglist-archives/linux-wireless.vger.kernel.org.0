Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7176E257929
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHaM0P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgHaM0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:10 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C6C061573
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mgx2CW1VkZjs2BvvQsDWO8dqcWvGdv6GGaak9dcFGcg=; b=R23xz+h8EfIBmg39fEnwiU2NlH
        TBPwsaBd5/FJEuzbNTEkTKALGp4cWapzo/WFlKULkffUuAisyZdFeK2FIsE59nX+efO3cP5QlUl7g
        ntRoK8Ju1W656TfxAFjqSxxlvWAYcJR17K+gnsDvgiftgHdrDSMSkowvwU8yMEbj9ug8=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCisr-0000Ok-OJ
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:01 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/9] mt76: sdio: fix use of q->head and q->tail
Date:   Mon, 31 Aug 2020 14:25:51 +0200
Message-Id: <20200831122558.1388-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Their use is reversed compared to DMA. The order for DMA makes more sense,
so let's use that

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c |  6 ++--
 drivers/net/wireless/mediatek/mt76/sdio.c     | 30 +++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 79e02157da4d..8863c3a230d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -97,7 +97,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	}
 
 	for (i = 0; i < intr->rx.num[qid]; i++) {
-		int index = (q->tail + i) % q->ndesc;
+		int index = (q->head + i) % q->ndesc;
 		struct mt76_queue_entry *e = &q->entry[index];
 
 		len = intr->rx.len[qid][i];
@@ -112,7 +112,7 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	__free_pages(page, order);
 
 	spin_lock_bh(&q->lock);
-	q->tail = (q->tail + i) % q->ndesc;
+	q->head = (q->head + i) % q->ndesc;
 	q->queued += i;
 	spin_unlock_bh(&q->lock);
 
@@ -166,7 +166,7 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	struct mt76_sdio *sdio = &dev->sdio;
 	int nframes = 0;
 
-	while (q->first != q->tail) {
+	while (q->first != q->head) {
 		struct mt76_queue_entry *e = &q->entry[q->first];
 		int err, len = e->skb->len;
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 40fd752d1234..6c6d4cea2203 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -98,8 +98,8 @@ mt76s_get_next_rx_entry(struct mt76_queue *q)
 
 	spin_lock_bh(&q->lock);
 	if (q->queued > 0) {
-		e = &q->entry[q->head];
-		q->head = (q->head + 1) % q->ndesc;
+		e = &q->entry[q->tail];
+		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 	}
 	spin_unlock_bh(&q->lock);
@@ -142,17 +142,17 @@ static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	bool wake;
 
 	while (q->queued > n_dequeued) {
-		if (!q->entry[q->head].done)
+		if (!q->entry[q->tail].done)
 			break;
 
-		if (q->entry[q->head].schedule) {
-			q->entry[q->head].schedule = false;
+		if (q->entry[q->tail].schedule) {
+			q->entry[q->tail].schedule = false;
 			n_sw_dequeued++;
 		}
 
-		entry = q->entry[q->head];
-		q->entry[q->head].done = false;
-		q->head = (q->head + 1) % q->ndesc;
+		entry = q->entry[q->tail];
+		q->entry[q->tail].done = false;
+		q->tail = (q->tail + 1) % q->ndesc;
 		n_dequeued++;
 
 		if (qid == MT_TXQ_MCU)
@@ -222,7 +222,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		.skb = skb,
 	};
 	int err, len = skb->len;
-	u16 idx = q->tail;
+	u16 idx = q->head;
 
 	if (q->queued == q->ndesc)
 		return -ENOSPC;
@@ -232,9 +232,9 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 	if (err < 0)
 		return err;
 
-	q->entry[q->tail].skb = tx_info.skb;
-	q->entry[q->tail].buf_sz = len;
-	q->tail = (q->tail + 1) % q->ndesc;
+	q->entry[q->head].skb = tx_info.skb;
+	q->entry[q->head].buf_sz = len;
+	q->head = (q->head + 1) % q->ndesc;
 	q->queued++;
 
 	return idx;
@@ -256,9 +256,9 @@ mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 
 	spin_lock_bh(&q->lock);
 
-	q->entry[q->tail].buf_sz = len;
-	q->entry[q->tail].skb = skb;
-	q->tail = (q->tail + 1) % q->ndesc;
+	q->entry[q->head].buf_sz = len;
+	q->entry[q->head].skb = skb;
+	q->head = (q->head + 1) % q->ndesc;
 	q->queued++;
 
 	spin_unlock_bh(&q->lock);
-- 
2.28.0

