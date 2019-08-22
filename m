Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E708398FFB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfHVJtZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 05:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732334AbfHVJtZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 05:49:25 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B06F233A2;
        Thu, 22 Aug 2019 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566467364;
        bh=1YSrWhmZK4wk5w9FA1q3MUer4g7bInuENrIvHXoRbfE=;
        h=From:To:Cc:Subject:Date:From;
        b=F9I2tyVjF+m7h8hhZnR0CAVzrhvg5QdYor6U79Pe+/qdEMm3OS2HB1G+K/tgsaDq4
         L535YBNZVb3LQOlLg3fnK/QCSBYfTTDPIME/xuEMbBt1i+IuWGrWs1FX5d7UcZZ3YF
         Cg57ooMRpsrQS6PwFMG+oUt8k0gMciNNp/K0q2kw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: remove empty flag in mt76_txq_schedule_list
Date:   Thu, 22 Aug 2019 11:49:10 +0200
Message-Id: <fb24ac317768ec71d16354ef6cd2a9c10931c75d.1566466668.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove empty flag in mt76_txq_schedule_list and mt76_txq_send_burst
since we just need retry_q length to notify mac80211 to reschedule the
current tx queue

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index d7982aa83c11..51d69329ed06 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -378,7 +378,7 @@ EXPORT_SYMBOL_GPL(mt76_release_buffered_frames);
 
 static int
 mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
-		    struct mt76_txq *mtxq, bool *empty)
+		    struct mt76_txq *mtxq)
 {
 	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 	enum mt76_txq_id qid = mt76_txq_get_qid(txq);
@@ -392,16 +392,12 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
 	bool probe;
 	int idx;
 
-	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags)) {
-		*empty = true;
+	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 		return 0;
-	}
 
 	skb = mt76_txq_dequeue(dev, mtxq, false);
-	if (!skb) {
-		*empty = true;
+	if (!skb)
 		return 0;
-	}
 
 	info = IEEE80211_SKB_CB(skb);
 	if (!(wcid->tx_info & MT_WCID_TX_INFO_SET))
@@ -432,10 +428,8 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
 			return -EBUSY;
 
 		skb = mt76_txq_dequeue(dev, mtxq, false);
-		if (!skb) {
-			*empty = true;
+		if (!skb)
 			break;
-		}
 
 		info = IEEE80211_SKB_CB(skb);
 		cur_ampdu = info->flags & IEEE80211_TX_CTL_AMPDU;
@@ -482,8 +476,6 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
 
 	spin_lock_bh(&hwq->lock);
 	while (1) {
-		bool empty = false;
-
 		if (sq->swq_queued >= 4)
 			break;
 
@@ -515,10 +507,9 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
 			spin_lock_bh(&hwq->lock);
 		}
 
-		ret += mt76_txq_send_burst(dev, sq, mtxq, &empty);
-		if (skb_queue_empty(&mtxq->retry_q))
-			empty = true;
-		ieee80211_return_txq(dev->hw, txq, !empty);
+		ret += mt76_txq_send_burst(dev, sq, mtxq);
+		ieee80211_return_txq(dev->hw, txq,
+				     !skb_queue_empty(&mtxq->retry_q));
 	}
 	spin_unlock_bh(&hwq->lock);
 
-- 
2.21.0

