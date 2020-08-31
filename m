Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB825792D
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgHaM01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgHaM0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E254C06123A
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HTBk4pB1isCPzFUCSAE0aANTISnsv4wbU6byxDLPRws=; b=bqLk4m9SfXLRWwuT/C9otpBGes
        gTVm99W1DxlYUWjVvUAKacK/WaXwF+g2MjtsoHtPPx6fbli8ideCr/a9Mo3CK2Ajm1/xQbGBiig3H
        41WC3mIkFpTl1cCAwd0PADqE1Z7EwB5lnQFD1Y6UzJlXuEXHuwQ0p+dncQi2a/00GSzw=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCisr-0000Ok-IK
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:01 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/9] mt76: usb: fix use of q->head and q->tail
Date:   Mon, 31 Aug 2020 14:25:50 +0200
Message-Id: <20200831122558.1388-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
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
 drivers/net/wireless/mediatek/mt76/usb.c | 30 ++++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index dcab5993763a..36e6cc3535fa 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -497,8 +497,8 @@ mt76u_get_next_rx_entry(struct mt76_queue *q)
 
 	spin_lock_irqsave(&q->lock, flags);
 	if (q->queued > 0) {
-		urb = q->entry[q->head].urb;
-		q->head = (q->head + 1) % q->ndesc;
+		urb = q->entry[q->tail].urb;
+		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 	}
 	spin_unlock_irqrestore(&q->lock, flags);
@@ -622,10 +622,10 @@ static void mt76u_complete_rx(struct urb *urb)
 	}
 
 	spin_lock_irqsave(&q->lock, flags);
-	if (WARN_ONCE(q->entry[q->tail].urb != urb, "rx urb mismatch"))
+	if (WARN_ONCE(q->entry[q->head].urb != urb, "rx urb mismatch"))
 		goto out;
 
-	q->tail = (q->tail + 1) % q->ndesc;
+	q->head = (q->head + 1) % q->ndesc;
 	q->queued++;
 	tasklet_schedule(&dev->usb.rx_tasklet);
 out:
@@ -808,17 +808,17 @@ static void mt76u_tx_tasklet(unsigned long data)
 		q = sq->q;
 
 		while (q->queued > n_dequeued) {
-			if (!q->entry[q->head].done)
+			if (!q->entry[q->tail].done)
 				break;
 
-			if (q->entry[q->head].schedule) {
-				q->entry[q->head].schedule = false;
+			if (q->entry[q->tail].schedule) {
+				q->entry[q->tail].schedule = false;
 				n_sw_dequeued++;
 			}
 
-			entry = q->entry[q->head];
-			q->entry[q->head].done = false;
-			q->head = (q->head + 1) % q->ndesc;
+			entry = q->entry[q->tail];
+			q->entry[q->tail].done = false;
+			q->tail = (q->tail + 1) % q->ndesc;
 			n_dequeued++;
 
 			dev->drv->tx_complete_skb(dev, i, &entry);
@@ -913,7 +913,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
-	u16 idx = q->tail;
+	u16 idx = q->head;
 	int err;
 
 	if (q->queued == q->ndesc)
@@ -932,7 +932,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 			    q->entry[idx].urb, mt76u_complete_tx,
 			    &q->entry[idx]);
 
-	q->tail = (q->tail + 1) % q->ndesc;
+	q->head = (q->head + 1) % q->ndesc;
 	q->entry[idx].skb = tx_info.skb;
 	q->queued++;
 
@@ -944,7 +944,7 @@ static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 	struct urb *urb;
 	int err;
 
-	while (q->first != q->tail) {
+	while (q->first != q->head) {
 		urb = q->entry[q->first].urb;
 
 		trace_submit_urb(dev, urb);
@@ -1071,8 +1071,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 			/* Assure we are in sync with killed tasklet. */
 			spin_lock_bh(&q->lock);
 			while (q->queued) {
-				entry = q->entry[q->head];
-				q->head = (q->head + 1) % q->ndesc;
+				entry = q->entry[q->tail];
+				q->tail = (q->tail + 1) % q->ndesc;
 				q->queued--;
 
 				dev->drv->tx_complete_skb(dev, i, &entry);
-- 
2.28.0

