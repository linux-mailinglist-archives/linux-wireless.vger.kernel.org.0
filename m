Return-Path: <linux-wireless+bounces-19061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84456A37CEA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C929189407E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D51A4F12;
	Mon, 17 Feb 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="spMye8EL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA121A264A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780261; cv=none; b=MHayrVRnIc2Yv69vFhmjZZw0hfWF6n/c7h3i8cmeXRyfriAr1V4wBp8uvMkazAike8EkcpbEDy3OP9xd9VcqGJt5CP0GiL0NVrF6GvnVBhHjxAPjQ2jSb2VAaC7bOiedB3mgcUZ3bMIb6pFMWwmmXIaXrKFkceahuS4bHOnVCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780261; c=relaxed/simple;
	bh=XuG6Aeo93KtHa+LUIWCI/Wp9+HsZEPmhw4yoxnPKUqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm0hjw1IKhMBAfCeXX+sbaKe45nji6yOspKCHgOE56/FiILq7m48LPHi7ff0XcAZEJekZlGVAFZzyysC9t9dxm8jtDUF+dymU2qcn2Cqyh3djXWQvtxB2fS34sbEpb4Xgc5dlFvHhVduCjUxedKT4sNgScmbuoosAjITffHZpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=spMye8EL; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739780253;
	bh=XuG6Aeo93KtHa+LUIWCI/Wp9+HsZEPmhw4yoxnPKUqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=spMye8ELDMBVXc4XCiKRgd77grfGGVZCQG809sxc7MjfNJCxUf1vR4ZoO9PO90f2J
	 0DTgyOcjotBG3eHz+IiQ9f7GKC4AtktWvTQGDuH6XG4/heLxJWRE4TuNcpOU47/S/a
	 GK/+9YRepYTqNQ5xr+qTB5WjsjcWXM92V0Y1GsiM=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH v2 09/10] wifi: mac80211: Migrate TX to kthread
Date: Mon, 17 Feb 2025 09:17:20 +0100
Message-ID: <20250217081721.45110-10-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217081721.45110-1-Alexander@wetzel-home.de>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a per-phy kthread to handle all TX operations except
IEEE80211_TX_INTFL_NOQUEUE_TX.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
Changes compared to RFC v1:
 - using guard() in ac_has_active_txq
---
 net/mac80211/agg-tx.c      |  2 +-
 net/mac80211/driver-ops.h  |  7 ----
 net/mac80211/ieee80211_i.h |  9 ++---
 net/mac80211/main.c        |  8 ++--
 net/mac80211/sta_info.c    |  2 +-
 net/mac80211/tx.c          | 14 ++++++-
 net/mac80211/util.c        | 75 +++++++++++++++++++++++++++-----------
 7 files changed, 76 insertions(+), 41 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index e9168e8ba133..1646cb6b440f 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -180,7 +180,7 @@ ieee80211_agg_start_txq(struct sta_info *sta, int tid, bool enable)
 	clear_bit(IEEE80211_TXQ_STOP, &txqi->flags);
 	local_bh_disable();
 	rcu_read_lock();
-	schedule_and_wake_txq(sta->sdata->local, txqi);
+	ieee80211_schedule_txq(&sta->sdata->local->hw, &txqi->txq);
 	rcu_read_unlock();
 	local_bh_enable();
 }
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d5419eb06224..6d1489a39f99 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1384,13 +1384,6 @@ static inline void drv_wake_tx_queue(struct ieee80211_local *local,
 	local->ops->wake_tx_queue(&local->hw, &txq->txq);
 }
 
-static inline void schedule_and_wake_txq(struct ieee80211_local *local,
-					 struct txq_info *txqi)
-{
-	ieee80211_schedule_txq(&local->hw, &txqi->txq);
-	drv_wake_tx_queue(local, txqi);
-}
-
 static inline int drv_can_aggregate_in_amsdu(struct ieee80211_local *local,
 					     struct sk_buff *head,
 					     struct sk_buff *skb)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 37b81354f289..acfdc5089d0f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1358,9 +1358,7 @@ struct ieee80211_local {
 	spinlock_t active_txq_lock[IEEE80211_NUM_ACS];
 	struct list_head active_txqs[IEEE80211_NUM_ACS];
 	u16 schedule_round[IEEE80211_NUM_ACS];
-
-	/* serializes ieee80211_handle_wake_tx_queue */
-	spinlock_t handle_wake_tx_queue_lock;
+	bool txq_scheduler_used;
 
 	u16 airtime_flags;
 	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
@@ -1480,7 +1478,8 @@ struct ieee80211_local {
 
 	struct sk_buff_head pending[IEEE80211_MAX_QUEUES];
 	struct tasklet_struct tx_pending_tasklet;
-	struct tasklet_struct wake_txqs_tasklet;
+	struct task_struct *mac80211_tsk;
+	wait_queue_head_t mac80211_tsk_wq;
 
 	/* number of interfaces with allmulti RX */
 	atomic_t iff_allmultis;
@@ -2555,7 +2554,7 @@ void ieee80211_txq_remove_vlan(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata);
 void ieee80211_fill_txq_stats(struct cfg80211_txq_stats *txqstats,
 			      struct txq_info *txqi);
-void ieee80211_wake_txqs(struct tasklet_struct *t);
+int mac80211_thread(void *data);
 void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 			 u16 transaction, u16 auth_alg, u16 status,
 			 const u8 *extra, size_t extra_len, const u8 *bssid,
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 230c15dd3c4d..a08d97e6f50c 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -972,8 +972,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	local->aql_threshold = IEEE80211_AQL_THRESHOLD;
 	atomic_set(&local->aql_total_pending_airtime, 0);
 
-	spin_lock_init(&local->handle_wake_tx_queue_lock);
-
 	INIT_LIST_HEAD(&local->chanctx_list);
 
 	wiphy_delayed_work_init(&local->scan_work, ieee80211_scan_work);
@@ -1001,9 +999,12 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 		skb_queue_head_init(&local->pending[i]);
 	}
 	tasklet_setup(&local->tx_pending_tasklet, ieee80211_tx_pending);
-	tasklet_setup(&local->wake_txqs_tasklet, ieee80211_wake_txqs);
 	tasklet_setup(&local->tasklet, ieee80211_tasklet_handler);
 
+	init_waitqueue_head(&local->mac80211_tsk_wq);
+	local->mac80211_tsk = kthread_run(mac80211_thread, local,
+					  "mac80211-%s", wiphy_name(wiphy));
+
 	skb_queue_head_init(&local->skb_queue);
 	skb_queue_head_init(&local->skb_queue_unreliable);
 
@@ -1660,6 +1661,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
+	kthread_stop(local->mac80211_tsk);
 	tasklet_kill(&local->tx_pending_tasklet);
 	tasklet_kill(&local->tasklet);
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 2a3785cd7aae..60a154b0f8b9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1735,7 +1735,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 		if (!sta->sta.txq[i] || !txq_has_queue(sta->sta.txq[i]))
 			continue;
 
-		schedule_and_wake_txq(local, to_txq_info(sta->sta.txq[i]));
+		ieee80211_schedule_txq(&local->hw, sta->sta.txq[i]);
 	}
 
 	skb_queue_head_init(&pending);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e50a33918e37..4d5d641b2b6b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1569,7 +1569,7 @@ static struct txq_info *ieee80211_queue_skb(struct ieee80211_local *local,
 	ieee80211_txq_enqueue(local, txqi, skb);
 
 	if (likely(txqi->txq.tid != IEEE80211_TID_NOQUEUE))
-		schedule_and_wake_txq(local, txqi);
+		ieee80211_schedule_txq(&local->hw, &txqi->txq);
 
 	return txqi;
 }
@@ -3826,6 +3826,11 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 			found_eligible_txq = false;
 	}
 
+	if (test_bit(IEEE80211_TXQ_DIRTY, &txqi->flags)) {
+		list_del_init(&txqi->schedule_order);
+		goto begin;
+	}
+
 	if (!head)
 		head = txqi;
 
@@ -3892,8 +3897,9 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 				      &local->active_txqs[txq->ac]);
 		if (has_queue)
 			ieee80211_txq_set_active(txqi);
-	}
 
+		wake_up_interruptible(&local->mac80211_tsk_wq);
+	}
 	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
@@ -4009,6 +4015,8 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
+	local->txq_scheduler_used = true;
+
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
 	if (ieee80211_txq_schedule_airtime_check(local, ac)) {
@@ -4035,6 +4043,8 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	struct sk_buff *next;
 	int len = skb->len;
 
+	skb->dev = dev;
+
 	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
 		return;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ecbc79d3015e..7125a5004776 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -307,16 +307,14 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->vif);
 	struct ieee80211_txq *queue;
 
-	spin_lock(&local->handle_wake_tx_queue_lock);
-
 	/* Use ieee80211_next_txq() for airtime fairness accounting */
 	ieee80211_txq_schedule_start(hw, txq->ac);
-	while ((queue = ieee80211_next_txq(hw, txq->ac))) {
+	queue = ieee80211_next_txq(hw, txq->ac);
+	if (queue) {
 		wake_tx_push_queue(local, sdata, queue);
 		ieee80211_return_txq(hw, queue, false);
 	}
 	ieee80211_txq_schedule_end(hw, txq->ac);
-	spin_unlock(&local->handle_wake_tx_queue_lock);
 }
 EXPORT_SYMBOL(ieee80211_handle_wake_tx_queue);
 
@@ -328,12 +326,10 @@ static void __ieee80211_wake_txq(struct ieee80211_local *local,
 	struct txq_info *txqi = to_txq_info(txq);
 	struct fq *fq = &local->fq;
 
-	if (WARN_ON(!txq))
-		return;
 	if (test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags)) {
 		/* ieee80211_tx_dequeue() also takes fq->lock */
 		spin_unlock(&fq->lock);
-		drv_wake_tx_queue(local, txqi);
+		ieee80211_schedule_txq(&local->hw, txq);
 		spin_lock(&fq->lock);
 	}
 }
@@ -441,17 +437,6 @@ _ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
 	rcu_read_unlock();
 }
 
-void ieee80211_wake_txqs(struct tasklet_struct *t)
-{
-	struct ieee80211_local *local = from_tasklet(local, t,
-						     wake_txqs_tasklet);
-	unsigned long flags;
-
-	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-	_ieee80211_wake_txqs(local, &flags);
-	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
-}
-
 static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 				   enum queue_stop_reason reason,
 				   bool refcounted,
@@ -493,10 +478,56 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 	 * release someone's lock, but it is fine because all the callers of
 	 * __ieee80211_wake_queue call it right before releasing the lock.
 	 */
-	if (reason == IEEE80211_QUEUE_STOP_REASON_DRIVER)
-		tasklet_schedule(&local->wake_txqs_tasklet);
-	else
-		_ieee80211_wake_txqs(local, flags);
+	_ieee80211_wake_txqs(local, flags);
+}
+
+static int ac_has_active_txq(struct ieee80211_local *local)
+{
+	for (int ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		guard(spinlock)(&local->active_txq_lock[ac]);
+
+		if (!list_empty(&local->active_txqs[ac]))
+			return ac;
+	}
+	return IEEE80211_NUM_ACS;
+}
+
+int mac80211_thread(void *data)
+{
+	struct ieee80211_local *local = data;
+	struct txq_info *txqi, *tmp;
+	unsigned int ac = IEEE80211_NUM_ACS;
+
+	while (1) {
+		wait_event_interruptible(local->mac80211_tsk_wq,
+					 (ac = ac_has_active_txq(local))
+					 != IEEE80211_NUM_ACS);
+		if (kthread_should_stop())
+			break;
+
+		rcu_read_lock();
+
+		list_for_each_entry_safe(txqi, tmp,
+					 &local->active_txqs[ac],
+					 schedule_order) {
+			local->txq_scheduler_used = false;
+			local_bh_disable();
+			drv_wake_tx_queue(local, txqi);
+			local_bh_enable();
+			if (!local->txq_scheduler_used) {
+				/* Driver is not using
+				 * ieee80211_txq_schedule_start().
+				 * Take over cleaning up the schedule.
+				 */
+				spin_lock_bh(&local->active_txq_lock[ac]);
+				list_del_init(&txqi->schedule_order);
+				spin_unlock_bh(&local->active_txq_lock[ac]);
+			}
+		}
+
+		rcu_read_unlock();
+	}
+	return 0;
 }
 
 void ieee80211_wake_queue_by_reason(struct ieee80211_hw *hw, int queue,
-- 
2.48.1


