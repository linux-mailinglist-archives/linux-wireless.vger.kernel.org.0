Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96867B60A7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfIRJr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 05:47:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfIRJr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 05:47:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0F6F61156; Wed, 18 Sep 2019 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800047;
        bh=npcTsSz2ULquZeFRKpR/cm1LF/MeKEkuAN+7pstqeNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3sSuhvoaVH/zE7ldboiAY2o3vUE13BCFNiLZsLOmsc4rgMF1wVsytvYawnrLI4Q5
         qIQwiBARyLqRhT6sTsRnkt422a0vnM1c/Az8i7auEhUK55cnyed+Cit/8aYNmZTxKy
         rYruGnwf7RQdLlFxuC2pHVyWkBY6+4rLEfCE3grQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1AAD461156;
        Wed, 18 Sep 2019 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800046;
        bh=npcTsSz2ULquZeFRKpR/cm1LF/MeKEkuAN+7pstqeNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APfoopLL/o7u2rho1mhHhka1B428lxT8FzMBwBpWDWxrWFIj1uyY4rlvynv661DFK
         BPgcejGnnWqob+b4V7Gi3l/wvaOvHOJp8kPwY0HY+iOPR6DBVtOlmFnqOWYLUZl/QH
         +cR45mmQEylsEX8Nwg5Gb0wTNe+/qf6i9jpfQPMw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AAD461156
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH V2 2/4] mac80211: defer txqs removal from rbtree
Date:   Wed, 18 Sep 2019 17:47:11 +0800
Message-Id: <1568800033-17297-2-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568800033-17297-1-git-send-email-yiboz@codeaurora.org>
References: <1568800033-17297-1-git-send-email-yiboz@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In a loop txqs dequeue scenario, if the first txq in the rbtree gets
removed from rbtree immediately in the ieee80211_return_txq(), the
loop will break soon in the ieee80211_next_txq() due to schedule_pos
not leading to the second txq in the rbtree. Thus, defering the
removal right before the end of this schedule round.

Co-developed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/mac80211.h     | 16 ++++++++++--
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/main.c        |  6 +++++
 net/mac80211/tx.c          | 63 +++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac2ed8e..ba5a345 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -925,6 +925,8 @@ struct ieee80211_tx_rate {
 
 #define IEEE80211_MAX_TX_RETRY		31
 
+#define IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS 100
+
 static inline void ieee80211_rate_set_vht(struct ieee80211_tx_rate *rate,
 					  u8 mcs, u8 nss)
 {
@@ -6232,7 +6234,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
  * @ac: AC number to return packets from.
  *
  * Should only be called between calls to ieee80211_txq_schedule_start()
- * and ieee80211_txq_schedule_end().
+ * and ieee80211_txq_schedule_end(). If the txq is empty, it will be added
+ * to a remove list and get removed later.
  * Returns the next txq if successful, %NULL if no queue is eligible. If a txq
  * is returned, it should be returned with ieee80211_return_txq() after the
  * driver has finished scheduling it.
@@ -6268,7 +6271,8 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @ac: AC number to acquire locks for
  *
- * Release locks previously acquired by ieee80211_txq_schedule_end().
+ * Release locks previously acquired by ieee80211_txq_schedule_end(). Check
+ * and remove the empty txq from rb-tree.
  */
 void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
 	__releases(txq_lock);
@@ -6287,6 +6291,14 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 	__acquires(txq_lock) __releases(txq_lock);
 
 /**
+ * ieee80211_txqs_check - Check txqs waiting for removal
+ *
+ * @tmr: pointer as obtained from local
+ *
+ */
+void ieee80211_txqs_check(struct timer_list *tmr);
+
+/**
  * ieee80211_txq_may_transmit - check whether TXQ is allowed to transmit
  *
  * This function is used to check whether given txq is allowed to transmit by
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a4556f9..49aa143e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -847,6 +847,7 @@ struct txq_info {
 	struct codel_stats cstats;
 	struct sk_buff_head frags;
 	struct rb_node schedule_order;
+	struct list_head candidate;
 	unsigned long flags;
 
 	/* keep last! */
@@ -1145,6 +1146,8 @@ struct ieee80211_local {
 	u64 airtime_v_t[IEEE80211_NUM_ACS];
 	u64 airtime_weight_sum[IEEE80211_NUM_ACS];
 
+	struct list_head remove_list[IEEE80211_NUM_ACS];
+	struct timer_list remove_timer;
 	u16 airtime_flags;
 
 	const struct ieee80211_ops *ops;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e9ffa8e..78fe24a 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -667,10 +667,15 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		local->active_txqs[i] = RB_ROOT_CACHED;
+		INIT_LIST_HEAD(&local->remove_list[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
 	}
 	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
 
+	timer_setup(&local->remove_timer, ieee80211_txqs_check, 0);
+	mod_timer(&local->remove_timer,
+		  jiffies + msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
+
 	INIT_LIST_HEAD(&local->chanctx_list);
 	mutex_init(&local->chanctx_mtx);
 
@@ -1305,6 +1310,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	tasklet_kill(&local->tx_pending_tasklet);
 	tasklet_kill(&local->tasklet);
 
+	del_timer_sync(&local->remove_timer);
 #ifdef CONFIG_INET
 	unregister_inetaddr_notifier(&local->ifa_notifier);
 #endif
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d00baaa..42ca010 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1450,6 +1450,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	codel_stats_init(&txqi->cstats);
 	__skb_queue_head_init(&txqi->frags);
 	RB_CLEAR_NODE(&txqi->schedule_order);
+	INIT_LIST_HEAD(&txqi->candidate);
 
 	txqi->txq.vif = &sdata->vif;
 
@@ -3724,6 +3725,9 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw,
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
+	if (!list_empty(&txqi->candidate))
+		list_del_init(&txqi->candidate);
+
 	if (!RB_EMPTY_NODE(&txqi->schedule_order))
 		goto out;
 
@@ -3783,6 +3787,20 @@ static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
 	RB_CLEAR_NODE(&txqi->schedule_order);
 }
 
+void ieee80211_remove_txq(struct ieee80211_hw *hw,
+			  struct ieee80211_txq *txq)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
+
+	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
+
+	if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
+		__ieee80211_unschedule_txq(hw, txq);
+		list_del_init(&txqi->candidate);
+	}
+}
+
 void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
 			      struct ieee80211_txq *txq)
 	__acquires(txq_lock) __releases(txq_lock)
@@ -3790,7 +3808,7 @@ void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	spin_lock_bh(&local->active_txq_lock[txq->ac]);
-	__ieee80211_unschedule_txq(hw, txq);
+	ieee80211_remove_txq(hw, txq);
 	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
 }
 
@@ -3803,11 +3821,48 @@ void ieee80211_return_txq(struct ieee80211_hw *hw,
 	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
 
 	if (!RB_EMPTY_NODE(&txqi->schedule_order) &&
-	    (skb_queue_empty(&txqi->frags) && !txqi->tin.backlog_packets))
-		__ieee80211_unschedule_txq(hw, txq);
+		!txq_has_queue(&txqi->txq) &&
+		list_empty(&txqi->candidate))
+		list_add_tail(&txqi->candidate, &local->remove_list[txq->ac]);
+
 }
 EXPORT_SYMBOL(ieee80211_return_txq);
 
+void __ieee80211_check_txqs(struct ieee80211_local *local, int ac)
+{
+	struct txq_info *iter, *tmp;
+	struct sta_info *sta;
+
+	lockdep_assert_held(&local->active_txq_lock[ac]);
+
+	list_for_each_entry_safe(iter, tmp, &local->remove_list[ac],
+				 candidate) {
+		sta = container_of(iter->txq.sta, struct sta_info, sta);
+
+		if (txq_has_queue(&iter->txq))
+			list_del_init(&iter->candidate);
+		else
+			ieee80211_remove_txq(&local->hw, &iter->txq);
+	}
+}
+
+void ieee80211_txqs_check(struct timer_list *t)
+{
+	struct ieee80211_local *local = from_timer(local, t, remove_timer);
+	struct txq_info *iter, *tmp;
+	struct sta_info *sta;
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		spin_lock_bh(&local->active_txq_lock[ac]);
+		__ieee80211_check_txqs(local, ac);
+		spin_unlock_bh(&local->active_txq_lock[ac]);
+	}
+
+	mod_timer(&local->remove_timer,
+		  jiffies + msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
+}
+
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
@@ -3841,6 +3896,8 @@ void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	local->schedule_pos[ac] = NULL;
+	__ieee80211_check_txqs(local, ac);
+
 	spin_unlock_bh(&local->active_txq_lock[ac]);
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_end);
-- 
1.9.1

