Return-Path: <linux-wireless+bounces-19023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9101A37516
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65ABC169C7A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00AF19ABDE;
	Sun, 16 Feb 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="eSVvXYjL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B26A33F
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719953; cv=none; b=lfgHmMUhUG/e6Yn28qayqBcm/+7dsEfiiX5zKYqPGO4N2wYAZNZQm/8nIp6yMP4e1dPUihpKqqp9yfC6wtlcRnFPRAHYYHO0iSnWDy1Rxd89uZ3BVNy4QefLOs/bpkMAQr6zj2WadSIwKPfTn6FXt5puILenv38aRy1Lb1ndiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719953; c=relaxed/simple;
	bh=cCphARG6SQk/XdJaYjvYVpaEwnrpC4HO4TxaXcUSHoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab4omzcts0RmmPaM45CqHrdS0kySRlESWlxT4b6v0sSg2OgUBvIeZGAL0MexjI1YovZFzZcqX0ALYZZlSiEUY5tCQ31GUTlQHnX2kp/BrzqZQdfVg6gp5YMcM9SZ+CKriIjV29vPLpwBKcqY84bE0Ovog7wdl6Z+Z5MkOgN2RE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=eSVvXYjL; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739719938;
	bh=cCphARG6SQk/XdJaYjvYVpaEwnrpC4HO4TxaXcUSHoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSVvXYjLdRtW0RmOuM1PIBR5DzFzZiKoOqRsJitCwD9t7DdxjfZ0sL0LLOWQOHsGX
	 VkiaGjUmcZs398qIx+uIg2Nf+qqKyB/v7i6j76wTSeimwqshdTRzJvxJuhfKQbkl8B
	 MFJPu7poTMqaQjmnSQTCS/zNG0y8zS/muDPNKHrI=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH 08/10] wifi: mac80211: Simplify AMPDU handling
Date: Sun, 16 Feb 2025 16:31:58 +0100
Message-ID: <20250216153200.1318604-9-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216153200.1318604-1-Alexander@wetzel-home.de>
References: <20250216153200.1318604-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Wetzel <alexander@wetzel-home.de>

With all drivers now using TXQ we can simplify the AMPDU handling
and avoid stopping the queues when enabling or disabling it.

Move AMPDU handling fully into ieee80211_tx_dequeue() and use the
flag %IEEE80211_TXQ_AMPDU to detect if AMPDU is operational.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 net/mac80211/agg-tx.c      | 127 ++-----------------------------
 net/mac80211/debugfs_sta.c |   2 -
 net/mac80211/ieee80211_i.h |   5 +-
 net/mac80211/main.c        |   1 -
 net/mac80211/mesh.c        |  13 +---
 net/mac80211/rx.c          |   9 +--
 net/mac80211/sta_info.c    |   3 -
 net/mac80211/sta_info.h    |  30 ++++----
 net/mac80211/tx.c          | 149 ++++---------------------------------
 9 files changed, 38 insertions(+), 301 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 63a5e48291ac..e9168e8ba133 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -138,45 +138,6 @@ void ieee80211_assign_tid_tx(struct sta_info *sta, int tid,
 	rcu_assign_pointer(sta->ampdu_mlme.tid_tx[tid], tid_tx);
 }
 
-/*
- * When multiple aggregation sessions on multiple stations
- * are being created/destroyed simultaneously, we need to
- * refcount the global queue stop caused by that in order
- * to not get into a situation where one of the aggregation
- * setup or teardown re-enables queues before the other is
- * ready to handle that.
- *
- * These two functions take care of this issue by keeping
- * a global "agg_queue_stop" refcount.
- */
-static void __acquires(agg_queue)
-ieee80211_stop_queue_agg(struct ieee80211_sub_if_data *sdata, int tid)
-{
-	int queue = sdata->vif.hw_queue[ieee80211_ac_from_tid(tid)];
-
-	/* we do refcounting here, so don't use the queue reason refcounting */
-
-	if (atomic_inc_return(&sdata->local->agg_queue_stop[queue]) == 1)
-		ieee80211_stop_queue_by_reason(
-			&sdata->local->hw, queue,
-			IEEE80211_QUEUE_STOP_REASON_AGGREGATION,
-			false);
-	__acquire(agg_queue);
-}
-
-static void __releases(agg_queue)
-ieee80211_wake_queue_agg(struct ieee80211_sub_if_data *sdata, int tid)
-{
-	int queue = sdata->vif.hw_queue[ieee80211_ac_from_tid(tid)];
-
-	if (atomic_dec_return(&sdata->local->agg_queue_stop[queue]) == 0)
-		ieee80211_wake_queue_by_reason(
-			&sdata->local->hw, queue,
-			IEEE80211_QUEUE_STOP_REASON_AGGREGATION,
-			false);
-	__release(agg_queue);
-}
-
 static void
 ieee80211_agg_stop_txq(struct sta_info *sta, int tid)
 {
@@ -224,40 +185,6 @@ ieee80211_agg_start_txq(struct sta_info *sta, int tid, bool enable)
 	local_bh_enable();
 }
 
-/*
- * splice packets from the STA's pending to the local pending,
- * requires a call to ieee80211_agg_splice_finish later
- */
-static void __acquires(agg_queue)
-ieee80211_agg_splice_packets(struct ieee80211_sub_if_data *sdata,
-			     struct tid_ampdu_tx *tid_tx, u16 tid)
-{
-	struct ieee80211_local *local = sdata->local;
-	int queue = sdata->vif.hw_queue[ieee80211_ac_from_tid(tid)];
-	unsigned long flags;
-
-	ieee80211_stop_queue_agg(sdata, tid);
-
-	if (WARN(!tid_tx,
-		 "TID %d gone but expected when splicing aggregates from the pending queue\n",
-		 tid))
-		return;
-
-	if (!skb_queue_empty(&tid_tx->pending)) {
-		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-		/* copy over remaining packets */
-		skb_queue_splice_tail_init(&tid_tx->pending,
-					   &local->pending[queue]);
-		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
-	}
-}
-
-static void __releases(agg_queue)
-ieee80211_agg_splice_finish(struct ieee80211_sub_if_data *sdata, u16 tid)
-{
-	ieee80211_wake_queue_agg(sdata, tid);
-}
-
 static void ieee80211_remove_tid_tx(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
@@ -267,23 +194,8 @@ static void ieee80211_remove_tid_tx(struct sta_info *sta, int tid)
 
 	tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
 
-	/*
-	 * When we get here, the TX path will not be lockless any more wrt.
-	 * aggregation, since the OPERATIONAL bit has long been cleared.
-	 * Thus it will block on getting the lock, if it occurs. So if we
-	 * stop the queue now, we will not get any more packets, and any
-	 * that might be being processed will wait for us here, thereby
-	 * guaranteeing that no packets go to the tid_tx pending queue any
-	 * more.
-	 */
-
-	ieee80211_agg_splice_packets(sta->sdata, tid_tx, tid);
-
 	/* future packets must not find the tid_tx struct any more */
 	ieee80211_assign_tid_tx(sta, tid, NULL);
-
-	ieee80211_agg_splice_finish(sta->sdata, tid);
-
 	kfree_rcu(tid_tx, rcu_head);
 }
 
@@ -355,6 +267,10 @@ int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 
 	set_bit(HT_AGG_STATE_STOPPING, &tid_tx->state);
 
+	/*
+	 * After this packets are no longer handed through
+	 * to the driver
+	 */
 	ieee80211_agg_stop_txq(sta, tid);
 
 	spin_unlock_bh(&sta->lock);
@@ -365,13 +281,6 @@ int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 	del_timer_sync(&tid_tx->addba_resp_timer);
 	del_timer_sync(&tid_tx->session_timer);
 
-	/*
-	 * After this packets are no longer handed right through
-	 * to the driver but are put onto tid_tx->pending instead,
-	 * with locking to ensure proper access.
-	 */
-	clear_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state);
-
 	/*
 	 * There might be a few packets being processed right now (on
 	 * another CPU) that have already gotten past the aggregation
@@ -395,12 +304,7 @@ int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 	ret = drv_ampdu_action(local, sta->sdata, &params);
 
 	/* HW shall not deny going back to legacy */
-	if (WARN_ON(ret)) {
-		/*
-		 * We may have pending packets get stuck in this case...
-		 * Not bothering with a workaround for now.
-		 */
-	}
+	WARN_ON(ret);
 
 	/*
 	 * In the case of AGG_STOP_DESTROY_STA, the driver won't
@@ -537,9 +441,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
 		spin_lock_bh(&sta->lock);
-		ieee80211_agg_splice_packets(sdata, tid_tx, tid);
 		ieee80211_assign_tid_tx(sta, tid, NULL);
-		ieee80211_agg_splice_finish(sdata, tid);
 		spin_unlock_bh(&sta->lock);
 
 		ieee80211_agg_start_txq(sta, tid, false);
@@ -713,7 +615,6 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		goto err_unlock_sta;
 	}
 
-	skb_queue_head_init(&tid_tx->pending);
 	__set_bit(HT_AGG_STATE_WANT_START, &tid_tx->state);
 
 	tid_tx->timeout = timeout;
@@ -768,24 +669,6 @@ static void ieee80211_agg_tx_operational(struct ieee80211_local *local,
 	       sta->sta.addr, tid);
 
 	drv_ampdu_action(local, sta->sdata, &params);
-
-	/*
-	 * synchronize with TX path, while splicing the TX path
-	 * should block so it won't put more packets onto pending.
-	 */
-	spin_lock_bh(&sta->lock);
-
-	ieee80211_agg_splice_packets(sta->sdata, tid_tx, tid);
-	/*
-	 * Now mark as operational. This will be visible
-	 * in the TX path, and lets it go lock-free in
-	 * the common case.
-	 */
-	set_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state);
-	ieee80211_agg_splice_finish(sta->sdata, tid);
-
-	spin_unlock_bh(&sta->lock);
-
 	ieee80211_agg_start_txq(sta, tid, true);
 }
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d316008..890c01d848e5 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -343,8 +343,6 @@ static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, struct file *file,
 		p += scnprintf(p, bufsz + buf - p, "\t\t%x", !!tid_tx);
 		p += scnprintf(p, bufsz + buf - p, "\t%#.2x",
 				tid_tx ? tid_tx->dialog_token : 0);
-		p += scnprintf(p, bufsz + buf - p, "\t%03d",
-				tid_tx ? skb_queue_len(&tid_tx->pending) : 0);
 		p += scnprintf(p, bufsz + buf - p, "\n");
 	}
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index feda302d3a4c..37b81354f289 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1265,7 +1265,6 @@ enum queue_stop_reason {
 	IEEE80211_QUEUE_STOP_REASON_DRIVER,
 	IEEE80211_QUEUE_STOP_REASON_PS,
 	IEEE80211_QUEUE_STOP_REASON_CSA,
-	IEEE80211_QUEUE_STOP_REASON_AGGREGATION,
 	IEEE80211_QUEUE_STOP_REASON_SUSPEND,
 	IEEE80211_QUEUE_STOP_REASON_SKB_ADD,
 	IEEE80211_QUEUE_STOP_REASON_OFFCHANNEL,
@@ -1483,8 +1482,6 @@ struct ieee80211_local {
 	struct tasklet_struct tx_pending_tasklet;
 	struct tasklet_struct wake_txqs_tasklet;
 
-	atomic_t agg_queue_stop[IEEE80211_MAX_QUEUES];
-
 	/* number of interfaces with allmulti RX */
 	atomic_t iff_allmultis;
 
@@ -2127,7 +2124,7 @@ int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 			   struct sta_info *sta,
 			   struct ieee80211_fast_tx *fast_tx,
-			   struct sk_buff *skb, bool ampdu,
+			   struct sk_buff *skb,
 			   const u8 *da, const u8 *sa);
 void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 			  struct sta_info *sta, struct sk_buff *skb);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 741e6c7edcb7..230c15dd3c4d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -999,7 +999,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	for (i = 0; i < IEEE80211_MAX_QUEUES; i++) {
 		skb_queue_head_init(&local->pending[i]);
-		atomic_set(&local->agg_queue_stop[i], 0);
 	}
 	tasklet_setup(&local->tx_pending_tasklet, ieee80211_tx_pending);
 	tasklet_setup(&local->wake_txqs_tasklet, ieee80211_wake_txqs);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 974081324aa4..4fc91fe743c6 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -753,11 +753,9 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mesh_fast_tx *entry;
 	struct ieee80211s_hdr *meshhdr;
 	u8 sa[ETH_ALEN] __aligned(2);
-	struct tid_ampdu_tx *tid_tx;
 	struct sta_info *sta;
 	bool copy_sa = false;
 	u16 ethertype;
-	u8 tid;
 
 	if (ctrl_flags & IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP)
 		return false;
@@ -799,15 +797,6 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (!sta)
 		return false;
 
-	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-	if (tid_tx) {
-		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
-			return false;
-		if (tid_tx->timeout)
-			tid_tx->last_tx = jiffies;
-	}
-
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
 		return true;
@@ -832,7 +821,7 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	    ether_addr_copy(meshhdr->eaddr2, sa);
 
 	skb_push(skb, 2 * ETH_ALEN);
-	__ieee80211_xmit_fast(sdata, sta, &entry->fast_tx, skb, tid_tx,
+	__ieee80211_xmit_fast(sdata, sta, &entry->fast_tx, skb,
 			      entry->mpath->dst, sdata->vif.addr);
 
 	return true;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 042e12f08842..7cbd2409ca1a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2801,13 +2801,6 @@ ieee80211_rx_mesh_fast_forward(struct ieee80211_sub_if_data *sdata,
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-	if (tid_tx) {
-		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
-			return false;
-
-		if (tid_tx->timeout)
-			tid_tx->last_tx = jiffies;
-	}
 
 	ieee80211_aggr_check(sdata, sta, skb);
 
@@ -2821,7 +2814,7 @@ ieee80211_rx_mesh_fast_forward(struct ieee80211_sub_if_data *sdata,
 	skb->dev = sdata->dev;
 	memcpy(&eth, skb->data, ETH_HLEN - 2);
 	skb_pull(skb, 2);
-	__ieee80211_xmit_fast(sdata, sta, &entry->fast_tx, skb, tid_tx,
+	__ieee80211_xmit_fast(sdata, sta, &entry->fast_tx, skb,
 			      eth.h_dest, eth.h_source);
 	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_unicast);
 	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_frames);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 3ba03b6142cc..2a3785cd7aae 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -178,9 +178,6 @@ static void __cleanup_single_sta(struct sta_info *sta)
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
 		kfree(sta->ampdu_mlme.tid_start_tx[i]);
 		tid_tx = rcu_dereference_raw(sta->ampdu_mlme.tid_tx[i]);
-		if (!tid_tx)
-			continue;
-		ieee80211_purge_tx_queue(&local->hw, &tid_tx->pending);
 		kfree(tid_tx);
 	}
 }
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 07b7ec39a52f..01c07368e9ea 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -113,15 +113,17 @@ enum ieee80211_sta_info_flags {
 #define HT_AGG_BURST_RETRIES		3
 #define HT_AGG_RETRIES_PERIOD		(15 * HZ)
 
-#define HT_AGG_STATE_DRV_READY		0
-#define HT_AGG_STATE_RESPONSE_RECEIVED	1
-#define HT_AGG_STATE_OPERATIONAL	2
-#define HT_AGG_STATE_STOPPING		3
-#define HT_AGG_STATE_WANT_START		4
-#define HT_AGG_STATE_WANT_STOP		5
-#define HT_AGG_STATE_START_CB		6
-#define HT_AGG_STATE_STOP_CB		7
-#define HT_AGG_STATE_SENT_ADDBA		8
+/* TXQs using aggregation have %IEEE80211_TXQ_AMPDU set */
+enum ieee80211_ht_agg_state {
+	HT_AGG_STATE_DRV_READY,
+	HT_AGG_STATE_RESPONSE_RECEIVED,
+	HT_AGG_STATE_STOPPING,
+	HT_AGG_STATE_WANT_START,
+	HT_AGG_STATE_WANT_STOP,
+	HT_AGG_STATE_START_CB,
+	HT_AGG_STATE_STOP_CB,
+	HT_AGG_STATE_SENT_ADDBA,
+};
 
 DECLARE_EWMA(avg_signal, 10, 8)
 enum ieee80211_agg_stop_reason {
@@ -157,7 +159,6 @@ struct sta_info;
  * @rcu_head: rcu head for freeing structure
  * @session_timer: check if we keep Tx-ing on the TID (by timeout value)
  * @addba_resp_timer: timer for peer's response to addba request
- * @pending: pending frames queue -- use sta's spinlock to protect
  * @sta: station we are attached to
  * @dialog_token: dialog token for aggregation session
  * @timeout: session timeout value to be filled in ADDBA requests
@@ -176,16 +177,15 @@ struct sta_info;
  * the array holding it must hold the aggregation mutex.
  *
  * The TX path can access it under RCU lock-free if, and
- * only if, the state has the flag %HT_AGG_STATE_OPERATIONAL
- * set. Otherwise, the TX path must also acquire the spinlock
- * and re-check the state, see comments in the tx code
- * touching it.
+ * only if, the aggregation is operational (txq has the flag
+ * %IEEE80211_TXQ_AMPDU set). Otherwise, the TX path must also
+ * acquire the spinlock and re-check the state, see comments
+ * in the tx code touching it.
  */
 struct tid_ampdu_tx {
 	struct rcu_head rcu_head;
 	struct timer_list session_timer;
 	struct timer_list addba_resp_timer;
-	struct sk_buff_head pending;
 	struct sta_info *sta;
 	unsigned long state;
 	unsigned long last_tx;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 800e02bad7f6..89a28a3c457d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1102,77 +1102,6 @@ ieee80211_tx_h_calculate_duration(struct ieee80211_tx_data *tx)
 
 /* actual transmit path */
 
-static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
-				  struct sk_buff *skb,
-				  struct ieee80211_tx_info *info,
-				  struct tid_ampdu_tx *tid_tx,
-				  int tid)
-{
-	bool queued = false;
-	bool reset_agg_timer = false;
-	struct sk_buff *purge_skb = NULL;
-
-	if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
-		reset_agg_timer = true;
-	} else if (test_bit(HT_AGG_STATE_WANT_START, &tid_tx->state)) {
-		/*
-		 * nothing -- this aggregation session is being started
-		 * but that might still fail with the driver
-		 */
-	} else if (!tx->sta->sta.txq[tid]) {
-		spin_lock(&tx->sta->lock);
-		/*
-		 * Need to re-check now, because we may get here
-		 *
-		 *  1) in the window during which the setup is actually
-		 *     already done, but not marked yet because not all
-		 *     packets are spliced over to the driver pending
-		 *     queue yet -- if this happened we acquire the lock
-		 *     either before or after the splice happens, but
-		 *     need to recheck which of these cases happened.
-		 *
-		 *  2) during session teardown, if the OPERATIONAL bit
-		 *     was cleared due to the teardown but the pointer
-		 *     hasn't been assigned NULL yet (or we loaded it
-		 *     before it was assigned) -- in this case it may
-		 *     now be NULL which means we should just let the
-		 *     packet pass through because splicing the frames
-		 *     back is already done.
-		 */
-		tid_tx = rcu_dereference_protected_tid_tx(tx->sta, tid);
-
-		if (!tid_tx) {
-			/* do nothing, let packet pass through */
-		} else if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
-			reset_agg_timer = true;
-		} else {
-			queued = true;
-			if (info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER) {
-				clear_sta_flag(tx->sta, WLAN_STA_SP);
-				ps_dbg(tx->sta->sdata,
-				       "STA %pM aid %d: SP frame queued, close the SP w/o telling the peer\n",
-				       tx->sta->sta.addr, tx->sta->sta.aid);
-			}
-			info->control.vif = &tx->sdata->vif;
-			info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
-			info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
-			__skb_queue_tail(&tid_tx->pending, skb);
-			if (skb_queue_len(&tid_tx->pending) > STA_MAX_TX_BUFFER)
-				purge_skb = __skb_dequeue(&tid_tx->pending);
-		}
-		spin_unlock(&tx->sta->lock);
-
-		if (purge_skb)
-			ieee80211_free_txskb(&tx->local->hw, purge_skb);
-	}
-
-	/* reset session timer */
-	if (reset_agg_timer)
-		tid_tx->last_tx = jiffies;
-
-	return queued;
-}
-
 void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 			  struct sta_info *sta, struct sk_buff *skb)
 {
@@ -1209,7 +1138,6 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	bool aggr_check = false;
-	int tid;
 
 	memset(tx, 0, sizeof(*tx));
 	tx->skb = skb;
@@ -1243,30 +1171,6 @@ ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (tx->sta && ieee80211_is_data_qos(hdr->frame_control) &&
-	    !ieee80211_is_qos_nullfunc(hdr->frame_control) &&
-	    ieee80211_hw_check(&local->hw, AMPDU_AGGREGATION) &&
-	    !ieee80211_hw_check(&local->hw, TX_AMPDU_SETUP_IN_HW)) {
-		struct tid_ampdu_tx *tid_tx;
-
-		tid = ieee80211_get_tid(hdr);
-		tid_tx = rcu_dereference(tx->sta->ampdu_mlme.tid_tx[tid]);
-		if (!tid_tx && aggr_check) {
-			ieee80211_aggr_check(sdata, tx->sta, skb);
-			tid_tx = rcu_dereference(tx->sta->ampdu_mlme.tid_tx[tid]);
-		}
-
-		if (tid_tx) {
-			bool queued;
-
-			queued = ieee80211_tx_prep_agg(tx, skb, info,
-						       tid_tx, tid);
-
-			if (unlikely(queued))
-				return TX_QUEUED;
-		}
-	}
-
 	if (is_multicast_ether_addr(hdr->addr1)) {
 		tx->flags &= ~IEEE80211_TX_UNICAST;
 		info->flags |= IEEE80211_TX_CTL_NO_ACK;
@@ -3558,7 +3462,7 @@ ieee80211_tx_skb_fixup(struct sk_buff *skb, netdev_features_t features)
 void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 			   struct sta_info *sta,
 			   struct ieee80211_fast_tx *fast_tx,
-			   struct sk_buff *skb, bool ampdu,
+			   struct sk_buff *skb,
 			   const u8 *da, const u8 *sa)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -3633,11 +3537,8 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb)
 {
 	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
-	struct ieee80211_hdr *hdr = (void *)fast_tx->hdr;
-	struct tid_ampdu_tx *tid_tx = NULL;
 	struct sk_buff *next;
 	struct ethhdr eth;
-	u8 tid = IEEE80211_NUM_TIDS;
 
 	/* control port protocol needs a lot of special handling */
 	if (cpu_to_be16(ethertype) == sdata->control_port_protocol)
@@ -3651,17 +3552,6 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
 		return false;
 
-	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
-		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-		if (tid_tx) {
-			if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
-				return false;
-			if (tid_tx->timeout)
-				tid_tx->last_tx = jiffies;
-		}
-	}
-
 	memcpy(&eth, skb->data, ETH_HLEN - 2);
 
 	/* after this point (skb is modified) we cannot return false */
@@ -3671,7 +3561,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 
 	skb_list_walk_safe(skb, skb, next) {
 		skb_mark_not_on_list(skb);
-		__ieee80211_xmit_fast(sdata, sta, fast_tx, skb, tid_tx,
+		__ieee80211_xmit_fast(sdata, sta, fast_tx, skb,
 				      eth.h_dest, eth.h_source);
 	}
 
@@ -3786,9 +3676,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		goto begin;
 	}
 
-	if (test_bit(IEEE80211_TXQ_AMPDU, &txqi->flags))
-		info->flags |= (IEEE80211_TX_CTL_AMPDU |
-				IEEE80211_TX_CTL_DONTFRAG);
+	ieee80211_aggr_check(tx.sdata, tx.sta, skb);
+
+	if (test_bit(IEEE80211_TXQ_AMPDU, &txqi->flags)) {
+		struct tid_ampdu_tx *tid_tx;
+
+		tid_tx = rcu_dereference(tx.sta->ampdu_mlme.tid_tx[txq->tid]);
+		if (!WARN_ON_ONCE(!tid_tx)) {
+			tid_tx->last_tx = jiffies;
+
+			info->flags |= (IEEE80211_TX_CTL_AMPDU |
+					IEEE80211_TX_CTL_DONTFRAG);
+		}
+	}
 
 	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
 		if (!ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
@@ -4156,7 +4056,6 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 		sta = NULL;
 
 	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
-	ieee80211_aggr_check(sdata, sta, skb);
 
 	if (sta) {
 		struct ieee80211_fast_tx *fast_tx;
@@ -4401,11 +4300,9 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
-	struct tid_ampdu_tx *tid_tx;
 	struct sk_buff *seg, *next;
 	unsigned int skbs = 0, len = 0;
 	u16 queue;
-	u8 tid;
 
 	queue = ieee80211_select_queue(sdata, sta, skb);
 	skb_set_queue_mapping(skb, queue);
@@ -4419,22 +4316,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	ieee80211_aggr_check(sdata, sta, skb);
-
-	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-	if (tid_tx) {
-		if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
-			/* fall back to non-offload slow path */
-			__ieee80211_subif_start_xmit(skb, dev, 0,
-						     IEEE80211_TX_CTRL_MLO_LINK_UNSPEC,
-						     NULL);
-			return;
-		}
-
-		if (tid_tx->timeout)
-			tid_tx->last_tx = jiffies;
-	}
-
 	skb = ieee80211_tx_skb_fixup(skb, ieee80211_sdata_netdev_features(sdata));
 	if (!skb)
 		return;
-- 
2.48.1


