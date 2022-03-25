Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13E4E7E04
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiCYVMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 17:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiCYVMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 17:12:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD20A197F92
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dt9Xv2m20NiTkWFwiQGjUcpjLEd0n0QYIZz3JT/8JZQ=; b=DwV/4BjV5S3R/EgeYPruN6fUEf
        2I7NlRa7zf/4Il6mApXDAlIf48Kz0xcmyY6891mfD0war1TYUZbQMQrEA3r+ZHAwNIKvH6Kc+LiE7
        +vxx6DSBMUPapjh0Y33lrap6QT7/lmnTOe2NAm3NKlCaZwG8LqsoubjSNSBLVdXufH6k=;
Received: from p200300daa70ef200dc11dea3d730df97.dip0.t-ipconnect.de ([2003:da:a70e:f200:dc11:dea3:d730:df97] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nXrCh-0001fW-IX
        for linux-wireless@vger.kernel.org; Fri, 25 Mar 2022 22:10:39 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/8] mt76: reduce tx queue lock hold time
Date:   Fri, 25 Mar 2022 22:10:26 +0100
Message-Id: <20220325211031.24171-3-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325211031.24171-1-nbd@nbd.name>
References: <20220325211031.24171-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- call txq dequeue without holding txq lock (locking handled by mac80211)
- disable bh around tx queue schedule

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6b8c9dc80542..830963a65b34 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -463,7 +463,9 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		ieee80211_get_tx_rates(txq->vif, txq->sta, skb,
 				       info->control.rates, 1);
 
+	spin_lock(&q->lock);
 	idx = __mt76_tx_queue_skb(phy, qid, skb, wcid, txq->sta, &stop);
+	spin_unlock(&q->lock);
 	if (idx < 0)
 		return idx;
 
@@ -483,14 +485,18 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 			ieee80211_get_tx_rates(txq->vif, txq->sta, skb,
 					       info->control.rates, 1);
 
+		spin_lock(&q->lock);
 		idx = __mt76_tx_queue_skb(phy, qid, skb, wcid, txq->sta, &stop);
+		spin_unlock(&q->lock);
 		if (idx < 0)
 			break;
 
 		n_frames++;
 	} while (1);
 
+	spin_lock(&q->lock);
 	dev->queue_ops->kick(dev, q);
+	spin_unlock(&q->lock);
 
 	return n_frames;
 }
@@ -525,8 +531,6 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 		if (wcid && test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 			continue;
 
-		spin_lock_bh(&q->lock);
-
 		if (mtxq->send_bar && mtxq->aggr) {
 			struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 			struct ieee80211_sta *sta = txq->sta;
@@ -535,16 +539,12 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 			u8 tid = txq->tid;
 
 			mtxq->send_bar = false;
-			spin_unlock_bh(&q->lock);
 			ieee80211_send_bar(vif, sta->addr, tid, agg_ssn);
-			spin_lock_bh(&q->lock);
 		}
 
 		if (!mt76_txq_stopped(q))
 			n_frames = mt76_txq_send_burst(phy, q, mtxq);
 
-		spin_unlock_bh(&q->lock);
-
 		ieee80211_return_txq(phy->hw, txq, false);
 
 		if (unlikely(n_frames < 0))
@@ -563,6 +563,7 @@ void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 	if (qid >= 4)
 		return;
 
+	local_bh_disable();
 	rcu_read_lock();
 
 	do {
@@ -572,6 +573,7 @@ void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 	} while (len > 0);
 
 	rcu_read_unlock();
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule);
 
-- 
2.35.1

