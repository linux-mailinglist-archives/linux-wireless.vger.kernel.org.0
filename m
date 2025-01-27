Return-Path: <linux-wireless+bounces-18035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3CA1DA8F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F86163016
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604861714CF;
	Mon, 27 Jan 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="aTM4vmVX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A027DA62
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995311; cv=none; b=LbHa2qG4bbTVXUxju2l6SuYKD8XgGhBCZbvOI1x2RVN3EI+g+hTqx7veZAQO4Eit2PAKhOk5o9DXb3Jzq5of6DsVM5k4fHq4AHETOk06jOQz6PYEZk3C0uB/wFEHCDTyRpsuQLdwFydJ6rrplFZuFgDguHf/lbi1TSAwUS97WLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995311; c=relaxed/simple;
	bh=CIJcatO2YxJXDSy+Ezf1UHFFgl3uxKNj4mY1sYn4kFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDdPofiM5H9yvUlK3yILziFpS5+MPsJNxCliOXmVmsr7PuxzansF4lvjBiG3vOiPAAc/rYbWEVzsiTuQU5SmsrgrOGuiNyYLUxE3wqU0mTQYPehndnDL1vJgn+maYcHUKTMqSfa6Si5V90OqKd6vSbF2zP5Ob9ZRo/+bLclosLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=aTM4vmVX; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995298;
	bh=CIJcatO2YxJXDSy+Ezf1UHFFgl3uxKNj4mY1sYn4kFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTM4vmVX+kaxEGMTtmDLy6PAVLZnBCySLgw9aBH16qCJKmhgNw+6rFMvrb4g9hfoe
	 CGmUljqErq0mlm/U/sTHMtUBW619y2UwCr5zViPG+cXZdgvG2/HLrlh+JUaUobdlgb
	 BsV1MjDOp+dEhTkewUq9JkGeiN3kQQkYK6vkajxo=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [RFC PATCH 11/13] wifi: mac80211: Migrate TX to kthread
Date: Mon, 27 Jan 2025 17:26:23 +0100
Message-ID: <20250127162625.20747-12-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
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
 net/mac80211/agg-tx.c      |  2 +-
 net/mac80211/driver-ops.h  |  7 -----
 net/mac80211/ieee80211_i.h |  7 +++--
 net/mac80211/main.c        |  7 +++--
 net/mac80211/sta_info.c    |  2 +-
 net/mac80211/tx.c          | 14 +++++++--
 net/mac80211/util.c        | 64 +++++++++++++++++++++++++++++++++-----
 7 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 69663e51d2bb..ec00e5730f1c 100644
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
index 3a7980b5a00a..0ddfa16bca7b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1388,13 +1388,6 @@ static inline void drv_wake_tx_queue(struct ieee80211_local *local,
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
index 9c00c4e60cfc..8bd1e4f0e5fd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1341,9 +1341,7 @@ struct ieee80211_local {
 	spinlock_t active_txq_lock[IEEE80211_NUM_ACS];
 	struct list_head active_txqs[IEEE80211_NUM_ACS];
 	u16 schedule_round[IEEE80211_NUM_ACS];
-
-	/* serializes ieee80211_handle_wake_tx_queue */
-	spinlock_t handle_wake_tx_queue_lock;
+	bool txq_scheduler_used;
 
 	u16 airtime_flags;
 	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
@@ -1464,6 +1462,8 @@ struct ieee80211_local {
 	struct sk_buff_head pending[IEEE80211_MAX_QUEUES];
 	struct tasklet_struct tx_pending_tasklet;
 	struct tasklet_struct wake_txqs_tasklet;
+	struct task_struct *mac80211_tsk;
+	wait_queue_head_t mac80211_tsk_wq;
 
 	/* number of interfaces with allmulti RX */
 	atomic_t iff_allmultis;
@@ -2541,6 +2541,7 @@ void ieee80211_txq_remove_vlan(struct ieee80211_local *local,
 void ieee80211_fill_txq_stats(struct cfg80211_txq_stats *txqstats,
 			      struct txq_info *txqi);
 void ieee80211_wake_txqs(struct tasklet_struct *t);
+int mac80211_thread(void *data);
 void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 			 u16 transaction, u16 auth_alg, u16 status,
 			 const u8 *extra, size_t extra_len, const u8 *bssid,
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0416ab7e1ca7..25d5a57a74ca 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -972,8 +972,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	local->aql_threshold = IEEE80211_AQL_THRESHOLD;
 	atomic_set(&local->aql_total_pending_airtime, 0);
 
-	spin_lock_init(&local->handle_wake_tx_queue_lock);
-
 	INIT_LIST_HEAD(&local->chanctx_list);
 
 	wiphy_delayed_work_init(&local->scan_work, ieee80211_scan_work);
@@ -1004,6 +1002,10 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	tasklet_setup(&local->wake_txqs_tasklet, ieee80211_wake_txqs);
 	tasklet_setup(&local->tasklet, ieee80211_tasklet_handler);
 
+	init_waitqueue_head(&local->mac80211_tsk_wq);
+	local->mac80211_tsk = kthread_run(mac80211_thread, local,
+					  "mac80211-%s", wiphy_name(wiphy));
+
 	skb_queue_head_init(&local->skb_queue);
 	skb_queue_head_init(&local->skb_queue_unreliable);
 
@@ -1655,6 +1657,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
+	kthread_stop(local->mac80211_tsk);
 	tasklet_kill(&local->tx_pending_tasklet);
 	tasklet_kill(&local->tasklet);
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 46695bcac4a7..7342f9466299 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1714,7 +1714,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 		if (!sta->sta.txq[i] || !txq_has_queue(sta->sta.txq[i]))
 			continue;
 
-		schedule_and_wake_txq(local, to_txq_info(sta->sta.txq[i]));
+		ieee80211_schedule_txq(&local->hw, sta->sta.txq[i]);
 	}
 
 	skb_queue_head_init(&pending);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d7cd27320df2..bd2f3c183e49 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1567,7 +1567,7 @@ static struct txq_info *ieee80211_queue_skb(struct ieee80211_local *local,
 
 	ieee80211_txq_enqueue(local, txqi, skb);
 	if (likely(txqi->txq.tid != IEEE80211_TXQ_NOQUEUE))
-		schedule_and_wake_txq(local, txqi);
+		ieee80211_schedule_txq(&local->hw, &txqi->txq);
 
 	return txqi;
 }
@@ -3823,6 +3823,11 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 			found_eligible_txq = false;
 	}
 
+	if (test_bit(IEEE80211_TXQ_DIRTY, &txqi->flags)) {
+		list_del_init(&txqi->schedule_order);
+		goto begin;
+	}
+
 	if (!head)
 		head = txqi;
 
@@ -3889,8 +3894,9 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 				      &local->active_txqs[txq->ac]);
 		if (has_queue)
 			ieee80211_txq_set_active(txqi);
-	}
 
+		wake_up_interruptible(&local->mac80211_tsk_wq);
+	}
 	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
@@ -4006,6 +4012,8 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
+	local->txq_scheduler_used = true;
+
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
 	if (ieee80211_txq_schedule_airtime_check(local, ac)) {
@@ -4032,6 +4040,8 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	struct sk_buff *next;
 	int len = skb->len;
 
+	skb->dev = dev;
+
 	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
 		return;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ef7d482d1984..1f84b83b0ea4 100644
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
 
@@ -326,11 +324,9 @@ static void __ieee80211_wake_txq(struct ieee80211_local *local,
 	struct txq_info *txqi = to_txq_info(txq);
 	struct fq *fq = &local->fq;
 
-	if (WARN_ON(!txq))
-		return;
 	if (test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags)) {
 		spin_unlock(&fq->lock);
-		drv_wake_tx_queue(local, txqi);
+		ieee80211_schedule_txq(&local->hw, txq);
 		spin_lock(&fq->lock);
 	}
 }
@@ -486,6 +482,60 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 		_ieee80211_wake_txqs(local, flags);
 }
 
+static int ac_has_active_txq(struct ieee80211_local *local)
+{
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		spin_lock_bh(&local->active_txq_lock[ac]);
+		if (!list_empty(&local->active_txqs[ac]))
+			goto out;
+		spin_unlock_bh(&local->active_txq_lock[ac]);
+	}
+	return IEEE80211_NUM_ACS;
+out:
+	spin_unlock_bh(&local->active_txq_lock[ac]);
+	return ac;
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
+}
+
 void ieee80211_wake_queue_by_reason(struct ieee80211_hw *hw, int queue,
 				    enum queue_stop_reason reason,
 				    bool refcounted)
-- 
2.48.1


