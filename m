Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DCA2CEEB8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgLDNSi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 08:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgLDNSh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 08:18:37 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA7C061A4F
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 05:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t8pBDJi0dyYUTKOnPVNaknc1WMsZPzCmuNMZgL6xdnQ=; b=ct2lJSgEuMuKjvie8j/9jUsIXU
        ZjmSsf1TRkOclVEFsRCJqbGXN89gM2RPod8Hio5+ya7JlPykzHrKCiby3DzxVEEExmkdFAett32Ap
        lQmxindhEM588+nVO2djubFMEY7Z2b9ZY4llbO4KikWX08ZuPxseJuQlHD9iPcfpBCfE=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1klAxu-00033k-A2
        for linux-wireless@vger.kernel.org; Fri, 04 Dec 2020 14:17:38 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/3] mt76: improve tx queue stop/wake
Date:   Fri,  4 Dec 2020 14:17:35 +0100
Message-Id: <20201204131737.41086-1-nbd@nbd.name>
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
 drivers/net/wireless/mediatek/mt76/dma.c  | 10 ----------
 drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c   | 23 ++++++++++++-----------
 3 files changed, 13 insertions(+), 21 deletions(-)

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
index 65360067b8fa..4026e5f4f3f3 100644
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
@@ -381,6 +375,13 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 }
 EXPORT_SYMBOL_GPL(mt76_release_buffered_frames);
 
+static bool
+mt76_txq_stopped(struct mt76_queue *q)
+{
+	return q->stopped || q->blocked ||
+	       q->queued + MT_TXQ_FREE_THR >= q->ndesc;
+}
+
 static int
 mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		    struct mt76_txq *mtxq)
@@ -419,10 +420,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		    test_bit(MT76_RESET, &phy->state))
 			return -EBUSY;
 
-		if (stop)
-			break;
-
-		if (q->queued + MT_TXQ_FREE_THR >= q->ndesc)
+		if (stop || mt76_txq_stopped(q))
 			break;
 
 		skb = mt76_txq_dequeue(phy, mtxq);
@@ -463,7 +461,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 			break;
 		}
 
-		if (q->queued + MT_TXQ_FREE_THR >= q->ndesc)
+		if (mt76_txq_stopped(q))
 			break;
 
 		txq = ieee80211_next_txq(phy->hw, qid);
@@ -498,11 +496,14 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
+	struct mt76_queue *q;
 	int len;
 
 	if (qid >= 4)
 		return;
 
+	q = phy->q_tx[qid];
+
 	rcu_read_lock();
 
 	do {
-- 
2.28.0

