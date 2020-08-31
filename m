Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F8257933
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHaM0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgHaM0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FF8C06123D
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mrA7EY/5Uh4JJpV+qZKmt0dUc16LscMgn87loyYsOzo=; b=Zl5kzwZYloW1TWSB1JarOBcvUD
        3kIpHVs71Ltw35qIjYkcWyTG4uEG5W96s+OOd5elH2yPJu1TgCaLdWf01BFAhIhAh7zfxn25zya/j
        snIQNNiE8aLTPpDdHCQ/tFhv70MgET+g3iN3nBbO7yfY6RqcIJ40LcyO5c9ox38yKw/o=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCisr-0000Ok-U8
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] mt76: unify queue tx cleanup code
Date:   Mon, 31 Aug 2020 14:25:52 +0200
Message-Id: <20200831122558.1388-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cleanup and preparation for changing tx scheduling behavior

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 17 +-----------
 drivers/net/wireless/mediatek/mt76/mt76.h |  2 ++
 drivers/net/wireless/mediatek/mt76/sdio.c | 33 ++++++----------------
 drivers/net/wireless/mediatek/mt76/tx.c   | 22 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/usb.c  | 34 +++++------------------
 5 files changed, 41 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 24ff21eedbd0..cab8422d8a83 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -165,16 +165,8 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 		last = readl(&q->regs->dma_idx);
 
 	while (q->queued > 0 && q->tail != last) {
-		int swq_qid = -1;
-
 		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
-		if (entry.schedule)
-			swq_qid = entry.qid;
-
-		q->tail = (q->tail + 1) % q->ndesc;
-
-		if (entry.skb)
-			dev->drv->tx_complete_skb(dev, qid, &entry);
+		mt76_queue_tx_complete(dev, q, &entry);
 
 		if (entry.txwi) {
 			if (!(dev->drv->drv_flags & MT_DRV_TXWI_NO_FREE))
@@ -185,13 +177,6 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 		if (!flush && q->tail == last)
 			last = readl(&q->regs->dma_idx);
 
-		spin_lock_bh(&q->lock);
-		if (swq_qid >= 4)
-			dev->q_tx[__MT_TXQ_MAX + swq_qid - 4].swq_queued--;
-		else if (swq_qid >= 0)
-			dev->q_tx[swq_qid].swq_queued--;
-		q->queued--;
-		spin_unlock_bh(&q->lock);
 	}
 
 	if (flush) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 80f4ba998383..23e8d63677da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1017,6 +1017,8 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 			   struct napi_struct *napi);
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
 void mt76_testmode_tx_pending(struct mt76_dev *dev);
+void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
+			    struct mt76_queue_entry *e);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 6c6d4cea2203..326d9c59e8b5 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -133,38 +133,28 @@ mt76s_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	return nframes;
 }
 
-static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
+static void mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 {
 	struct mt76_sw_queue *sq = &dev->q_tx[qid];
-	u32 n_dequeued = 0, n_sw_dequeued = 0;
 	struct mt76_queue_entry entry;
 	struct mt76_queue *q = sq->q;
 	bool wake;
 
-	while (q->queued > n_dequeued) {
+	while (q->queued > 0) {
 		if (!q->entry[q->tail].done)
 			break;
 
-		if (q->entry[q->tail].schedule) {
-			q->entry[q->tail].schedule = false;
-			n_sw_dequeued++;
-		}
-
 		entry = q->entry[q->tail];
 		q->entry[q->tail].done = false;
-		q->tail = (q->tail + 1) % q->ndesc;
-		n_dequeued++;
+		q->entry[q->tail].schedule = false;
 
-		if (qid == MT_TXQ_MCU)
+		if (qid == MT_TXQ_MCU) {
 			dev_kfree_skb(entry.skb);
-		else
-			dev->drv->tx_complete_skb(dev, qid, &entry);
-	}
-
-	spin_lock_bh(&q->lock);
+			entry.skb = NULL;
+		}
 
-	sq->swq_queued -= n_sw_dequeued;
-	q->queued -= n_dequeued;
+		mt76_queue_tx_complete(dev, q, &entry);
+	}
 
 	wake = q->stopped && q->queued < q->ndesc - 8;
 	if (wake)
@@ -173,18 +163,13 @@ static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	if (!q->queued)
 		wake_up(&dev->tx_wait);
 
-	spin_unlock_bh(&q->lock);
-
 	if (qid == MT_TXQ_MCU)
-		goto out;
+		return;
 
 	mt76_txq_schedule(&dev->phy, qid);
 
 	if (wake)
 		ieee80211_wake_queue(dev->hw, qid);
-
-out:
-	return n_dequeued;
 }
 
 static void mt76s_tx_status_data(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index d8252e28bacd..1a2f2163c6c3 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -696,3 +696,25 @@ int mt76_skb_adjust_pad(struct sk_buff *skb)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_skb_adjust_pad);
+
+void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
+			    struct mt76_queue_entry *e)
+{
+	enum mt76_txq_id qid = e->qid % 4;
+	bool ext_phy = e->qid >= 4;
+
+	if (e->skb)
+		dev->drv->tx_complete_skb(dev, qid, e);
+
+	spin_lock_bh(&q->lock);
+	q->tail = (q->tail + 1) % q->ndesc;
+	q->queued--;
+
+	if (ext_phy)
+		qid += __MT_TXQ_MAX;
+
+	if (e->schedule)
+		dev->q_tx[qid].swq_queued--;
+	spin_unlock_bh(&q->lock);
+}
+EXPORT_SYMBOL_GPL(mt76_queue_tx_complete);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 36e6cc3535fa..730d17393c3f 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -802,33 +802,20 @@ static void mt76u_tx_tasklet(unsigned long data)
 	int i;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		u32 n_dequeued = 0, n_sw_dequeued = 0;
-
 		sq = &dev->q_tx[i];
 		q = sq->q;
 
-		while (q->queued > n_dequeued) {
+		while (q->queued > 0) {
 			if (!q->entry[q->tail].done)
 				break;
 
-			if (q->entry[q->tail].schedule) {
-				q->entry[q->tail].schedule = false;
-				n_sw_dequeued++;
-			}
-
 			entry = q->entry[q->tail];
 			q->entry[q->tail].done = false;
-			q->tail = (q->tail + 1) % q->ndesc;
-			n_dequeued++;
+			q->entry[q->tail].schedule = false;
 
-			dev->drv->tx_complete_skb(dev, i, &entry);
+			mt76_queue_tx_complete(dev, q, &entry);
 		}
 
-		spin_lock_bh(&q->lock);
-
-		sq->swq_queued -= n_sw_dequeued;
-		q->queued -= n_dequeued;
-
 		wake = q->stopped && q->queued < q->ndesc - 8;
 		if (wake)
 			q->stopped = false;
@@ -836,8 +823,6 @@ static void mt76u_tx_tasklet(unsigned long data)
 		if (!q->queued)
 			wake_up(&dev->tx_wait);
 
-		spin_unlock_bh(&q->lock);
-
 		mt76_txq_schedule(&dev->phy, i);
 
 		if (dev->drv->tx_status_data &&
@@ -1068,16 +1053,11 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 			if (!q)
 				continue;
 
-			/* Assure we are in sync with killed tasklet. */
-			spin_lock_bh(&q->lock);
-			while (q->queued) {
-				entry = q->entry[q->tail];
-				q->tail = (q->tail + 1) % q->ndesc;
-				q->queued--;
+			entry = q->entry[q->tail];
+			q->entry[q->tail].done = false;
+			q->entry[q->tail].schedule = false;
 
-				dev->drv->tx_complete_skb(dev, i, &entry);
-			}
-			spin_unlock_bh(&q->lock);
+			mt76_queue_tx_complete(dev, q, &entry);
 		}
 	}
 
-- 
2.28.0

