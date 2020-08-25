Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E1251182
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHYF3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgHYF3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD24C061796
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XOwdHT1y0DdvcLP02NShNpxqbyii12ZCmDzCiI4VM8E=; b=O+f1AH8M3A+c0YXri9mK/gQGAd
        Yb0juthhMRcaSowIqkAdOHg9z9lS5sln+7PAfBATjMb6l0kpZUo4FMKG3Vii5HGvcI/YmF6+PXObV
        UPsdXP/l8Cb/9f8uKRWD8VgHqYCZ27ndxaEG1fjor70quOKvR7rMpt33F7VHq19cYmXI=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWB-0006jr-JL
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:11 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] mt76: dma: update q->queued immediately on cleanup
Date:   Tue, 25 Aug 2020 07:29:03 +0200
Message-Id: <20200825052909.36955-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825052909.36955-1-nbd@nbd.name>
References: <20200825052909.36955-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tx cleanup and tx enqueuing can run in parallel. In order to avoid queue
starvation issues under load, update q->queued immediately.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 39 +++++++++---------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index ade2d58b8da9..7545b552db25 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -152,10 +152,8 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 	struct mt76_sw_queue *sq = &dev->q_tx[qid];
 	struct mt76_queue *q = sq->q;
 	struct mt76_queue_entry entry;
-	unsigned int n_swq_queued[8] = {};
-	unsigned int n_queued = 0;
 	bool wake = false;
-	int i, last;
+	int last;
 
 	if (!q)
 		return;
@@ -165,13 +163,14 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 	else
 		last = readl(&q->regs->dma_idx);
 
-	while ((q->queued > n_queued) && q->tail != last) {
+	while (q->queued > 0 && q->tail != last) {
+		int swq_qid = -1;
+
 		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
 		if (entry.schedule)
-			n_swq_queued[entry.qid]++;
+			swq_qid = entry.qid;
 
 		q->tail = (q->tail + 1) % q->ndesc;
-		n_queued++;
 
 		if (entry.skb)
 			dev->drv->tx_complete_skb(dev, qid, &entry);
@@ -184,29 +183,21 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 
 		if (!flush && q->tail == last)
 			last = readl(&q->regs->dma_idx);
-	}
-
-	spin_lock_bh(&q->lock);
-
-	q->queued -= n_queued;
-	for (i = 0; i < 4; i++) {
-		if (!n_swq_queued[i])
-			continue;
 
-		dev->q_tx[i].swq_queued -= n_swq_queued[i];
-	}
-
-	/* ext PHY */
-	for (i = 0; i < 4; i++) {
-		if (!n_swq_queued[i])
-			continue;
-
-		dev->q_tx[__MT_TXQ_MAX + i].swq_queued -= n_swq_queued[4 + i];
+		spin_lock_bh(&q->lock);
+		if (swq_qid >= 4)
+			dev->q_tx[__MT_TXQ_MAX + swq_qid - 4].swq_queued--;
+		else if (swq_qid >= 0)
+			dev->q_tx[swq_qid].swq_queued--;
+		q->queued--;
+		spin_unlock_bh(&q->lock);
 	}
 
 	if (flush) {
+		spin_lock_bh(&q->lock);
 		mt76_dma_sync_idx(dev, q);
 		mt76_dma_kick_queue(dev, q);
+		spin_unlock_bh(&q->lock);
 	}
 
 	wake = wake && q->stopped &&
@@ -217,8 +208,6 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 	if (!q->queued)
 		wake_up(&dev->tx_wait);
 
-	spin_unlock_bh(&q->lock);
-
 	if (wake)
 		ieee80211_wake_queue(dev->hw, qid);
 }
-- 
2.28.0

