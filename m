Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036A72BC116
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgKURdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Nov 2020 12:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgKURdb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Nov 2020 12:33:31 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729DC061A4A
        for <linux-wireless@vger.kernel.org>; Sat, 21 Nov 2020 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nbCUfvN5ft11fmRZsaowNdVAEC71Y6OYgMj7d9tHn6M=; b=Lldu8Unpqaf7xisbRcfY0tQ0Ro
        5NaqTYlytuogFFmYsWC4MjGKSE6ZY2mihNTlIubLAmE8DmUNMe4fMQT9HVH04jlbB62U2S51l5Ntw
        2WgGTvO/uq2fVuNtgVRpgR6hiGvccTUfSGrkiwmOLT454Id811hUwR3ZCPxJObrTPOtg=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kgWlM-0004bc-28
        for linux-wireless@vger.kernel.org; Sat, 21 Nov 2020 18:33:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: improve tx queue stop/wake
Date:   Sat, 21 Nov 2020 18:33:24 +0100
Message-Id: <20201121173326.88208-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of stopping and waking only a single queue, handle all phy tx queues
mapped ot the same hardware queue.
Also allow the driver to block tx queues

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 10 ----
 drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c   | 60 ++++++++++++++++++++---
 3 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index bab961ebdf1c..6255f4f0a455 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -220,7 +220,6 @@ static void
 mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 {
 	struct mt76_queue_entry entry;
-	bool wake = false;
 	int last;
 
 	if (!q)
@@ -238,7 +237,6 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 		if (entry.txwi) {
 			if (!(dev->drv->drv_flags & MT_DRV_TXWI_NO_FREE))
 				mt76_put_txwi(dev, entry.txwi);
-			wake = !flush;
 		}
 
 		if (!flush && q->tail == last)
@@ -253,16 +251,8 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 		spin_unlock_bh(&q->lock);
 	}
 
-	wake = wake && q->stopped &&
-	       q->qid < IEEE80211_NUM_ACS && q->queued < q->ndesc - 8;
-	if (wake)
-		q->stopped = false;
-
 	if (!q->queued)
 		wake_up(&dev->tx_wait);
-
-	if (wake)
-		ieee80211_wake_queue(dev->hw, q->qid);
 }
 
 static void *
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 15d52af24d12..ea80ae188dd6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -136,6 +136,7 @@ struct mt76_queue {
 	int queued;
 	int buf_size;
 	bool stopped;
+	bool blocked;
 
 	u8 buf_offset;
 	u8 hw_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 65360067b8fa..41dd0a8064cf 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -291,12 +291,6 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	spin_lock_bh(&q->lock);
 	__mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);
 	dev->queue_ops->kick(dev, q);
-
-	if (q->queued > q->ndesc - 8 && !q->stopped) {
-		ieee80211_stop_queue(phy->hw, skb_get_queue_mapping(skb));
-		q->stopped = true;
-	}
-
 	spin_unlock_bh(&q->lock);
 }
 EXPORT_SYMBOL_GPL(mt76_tx);
@@ -463,6 +457,9 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 			break;
 		}
 
+		if (q->stopped || q->blocked)
+			break;
+
 		if (q->queued + MT_TXQ_FREE_THR >= q->ndesc)
 			break;
 
@@ -496,13 +493,60 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 	return ret;
 }
 
+
+static void
+__mt76_tx_check_hwq_stop(struct mt76_phy *phy, struct mt76_queue *q,
+			 bool stopped)
+{
+	int i;
+
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		if (phy->q_tx[i] != q)
+			continue;
+
+		if (stopped)
+			ieee80211_stop_queue(phy->hw, i);
+		else
+			ieee80211_wake_queue(phy->hw, i);
+	}
+}
+
+static bool
+mt76_tx_check_hwq_stop(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	 return q->blocked || q->queued >= q->ndesc - MT_TXQ_FREE_THR;
+}
+
+static void
+mt76_tx_update_hwq_stop(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	bool stopped, prev_stopped;
+
+	stopped = mt76_tx_check_hwq_stop(dev, q);
+	prev_stopped = q->stopped;
+	q->stopped = stopped;
+
+	if (stopped == prev_stopped)
+		return;
+
+	__mt76_tx_check_hwq_stop(&dev->phy, q, stopped);
+	if (dev->phy2)
+		__mt76_tx_check_hwq_stop(dev->phy2, q, stopped);
+}
+
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
+	struct mt76_queue *q;
 	int len;
 
 	if (qid >= 4)
 		return;
 
+	q = phy->q_tx[qid];
+	spin_lock_bh(&q->lock);
+	mt76_tx_update_hwq_stop(phy->dev, q);
+	spin_unlock_bh(&q->lock);
+
 	rcu_read_lock();
 
 	do {
@@ -623,6 +667,10 @@ void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 	spin_lock_bh(&q->lock);
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued--;
+
+	if (q->stopped && !mt76_tx_check_hwq_stop(dev, q))
+		mt76_worker_schedule(&dev->tx_worker);
+
 	spin_unlock_bh(&q->lock);
 }
 EXPORT_SYMBOL_GPL(mt76_queue_tx_complete);
-- 
2.28.0

