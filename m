Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A46B60A6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfIRJrZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 05:47:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58370 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfIRJrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 05:47:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7CB4C613A3; Wed, 18 Sep 2019 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800043;
        bh=N1/FCPeJHzQuYeEVyXwjYaJ9UWHutZ+Js8Xa50mX66A=;
        h=From:To:Cc:Subject:Date:From;
        b=E3oxKKsB3Fy23lGy51R8lMoANL80/GYtU5Ikql1uMh90Z3tFEQ5EwVvhycswlVv7g
         5sJ9xzLRtcr7MNXG+VXrWFbFOV8cIvmq+fOAglT1DQckfnjuQehL+kQy8QzX2DdtUV
         Xne/NmPGuURwQjCnhOCP5SFI2xooYG+bic9DAStg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4455160767;
        Wed, 18 Sep 2019 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568800042;
        bh=N1/FCPeJHzQuYeEVyXwjYaJ9UWHutZ+Js8Xa50mX66A=;
        h=From:To:Cc:Subject:Date:From;
        b=NVZC3nH7xYHO/J0ugC/5caqrZHM4TV4gxdB983wOUH3vmeEF7YjiTvBaqrUD3f/9D
         Pwx/CDcRtrA2WbaKznIRWM/jfOtVBY2aBMmUIC4SHsgWDSGYLiB7RrSL4vKXlfevKt
         GnC/JbPNkZHzGnkZJS4Oy5Zxr/RAKi9LhwNCABoM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4455160767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH V2 1/4] mac80211: Switch to a virtual time-based airtime scheduler
Date:   Wed, 18 Sep 2019 17:47:10 +0800
Message-Id: <1568800033-17297-1-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This switches the airtime scheduler in mac80211 to use a virtual time-based
scheduler instead of the round-robin scheduler used before. This has a
couple of advantages:

- No need to sync up the round-robin scheduler in firmware/hardware with
  the round-robin airtime scheduler.

- If several stations are eligible for transmission we can schedule both of
  them; no need to hard-block the scheduling rotation until the head of the
  queue has used up its quantum.

- The check of whether a station is eligible for transmission becomes
  simpler (in ieee80211_txq_may_transmit()).

The drawback is that scheduling becomes slightly more expensive, as we need
to maintain an rbtree of TXQs sorted by virtual time. This means that
ieee80211_register_airtime() becomes O(logN) in the number of currently
scheduled TXQs. However, hopefully this number rarely grows too big (it's
only TXQs currently backlogged, not all associated stations), so it
shouldn't be too big of an issue.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/mac80211/debugfs.c     |  48 +++++++++-
 net/mac80211/debugfs_sta.c |  16 ++--
 net/mac80211/ieee80211_i.h |  14 ++-
 net/mac80211/main.c        |   2 +-
 net/mac80211/sta_info.c    |  19 +++-
 net/mac80211/sta_info.h    |   3 +-
 net/mac80211/tx.c          | 217 +++++++++++++++++++++++++++++----------------
 7 files changed, 223 insertions(+), 96 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2d43bc1..4847168 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -150,6 +150,46 @@ static ssize_t aqm_write(struct file *file,
 	.llseek = default_llseek,
 };
 
+static ssize_t airtime_read(struct file *file,
+			    char __user *user_buf,
+			    size_t count,
+			    loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[200];
+	u64 v_t[IEEE80211_NUM_ACS];
+	u64 wt[IEEE80211_NUM_ACS];
+	int len = 0, ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		spin_lock_bh(&local->active_txq_lock[ac]);
+		v_t[ac] = local->airtime_v_t[ac];
+		wt[ac] = local->airtime_weight_sum[ac];
+		spin_unlock_bh(&local->active_txq_lock[ac]);
+	}
+	len = scnprintf(buf, sizeof(buf),
+			"\tVO         VI         BE         BK\n"
+			"Virt-t\t%-10llu %-10llu %-10llu %-10llu\n"
+			"Weight\t%-10llu %-10llu %-10llu %-10llu\n",
+			v_t[0],
+			v_t[1],
+			v_t[2],
+			v_t[3],
+			wt[0],
+			wt[1],
+			wt[2],
+			wt[3]);
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       buf, len);
+}
+
+static const struct file_operations airtime_ops = {
+	.read = airtime_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 #ifdef CONFIG_PM
 static ssize_t reset_write(struct file *file, const char __user *user_buf,
 			   size_t count, loff_t *ppos)
@@ -386,8 +426,12 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	if (local->ops->wake_tx_queue)
 		DEBUGFS_ADD_MODE(aqm, 0600);
 
-	debugfs_create_u16("airtime_flags", 0600,
-			   phyd, &local->airtime_flags);
+	if (wiphy_ext_feature_isset(local->hw.wiphy,
+				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS)) {
+		DEBUGFS_ADD_MODE(airtime, 0600);
+		debugfs_create_u16("airtime_flags", 0600,
+				   phyd, &local->airtime_flags);
+	}
 
 	statsd = debugfs_create_dir("statistics", phyd);
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 3aa618d..80028da 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -203,7 +203,7 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	size_t bufsz = 200;
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
 	u64 rx_airtime = 0, tx_airtime = 0;
-	s64 deficit[IEEE80211_NUM_ACS];
+	u64 v_t[IEEE80211_NUM_ACS];
 	ssize_t rv;
 	int ac;
 
@@ -214,20 +214,20 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 		spin_lock_bh(&local->active_txq_lock[ac]);
 		rx_airtime += sta->airtime[ac].rx_airtime;
 		tx_airtime += sta->airtime[ac].tx_airtime;
-		deficit[ac] = sta->airtime[ac].deficit;
+		v_t[ac] = sta->airtime[ac].v_t;
 		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
 
 	p += scnprintf(p, bufsz + buf - p,
 		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
+		"Virt-T: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
 		rx_airtime,
 		tx_airtime,
 		sta->airtime_weight,
-		deficit[0],
-		deficit[1],
-		deficit[2],
-		deficit[3]);
+		v_t[0],
+		v_t[1],
+		v_t[2],
+		v_t[3]);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 	kfree(buf);
@@ -245,7 +245,7 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 		spin_lock_bh(&local->active_txq_lock[ac]);
 		sta->airtime[ac].rx_airtime = 0;
 		sta->airtime[ac].tx_airtime = 0;
-		sta->airtime[ac].deficit = sta->airtime_weight;
+		sta->airtime[ac].v_t = 0;
 		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e170f98..a4556f9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -846,8 +846,7 @@ struct txq_info {
 	struct codel_vars def_cvars;
 	struct codel_stats cstats;
 	struct sk_buff_head frags;
-	struct list_head schedule_order;
-	u16 schedule_round;
+	struct rb_node schedule_order;
 	unsigned long flags;
 
 	/* keep last! */
@@ -1141,8 +1140,10 @@ struct ieee80211_local {
 
 	/* protects active_txqs and txqi->schedule_order */
 	spinlock_t active_txq_lock[IEEE80211_NUM_ACS];
-	struct list_head active_txqs[IEEE80211_NUM_ACS];
-	u16 schedule_round[IEEE80211_NUM_ACS];
+	struct rb_root_cached active_txqs[IEEE80211_NUM_ACS];
+	struct rb_node *schedule_pos[IEEE80211_NUM_ACS];
+	u64 airtime_v_t[IEEE80211_NUM_ACS];
+	u64 airtime_weight_sum[IEEE80211_NUM_ACS];
 
 	u16 airtime_flags;
 
@@ -1779,6 +1780,11 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted);
 
+void ieee80211_resort_txq(struct ieee80211_hw *hw,
+			  struct ieee80211_txq *txq);
+void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq);
+
 /* HT */
 void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_sta_ht_cap *ht_cap);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 5055aeb..e9ffa8e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -666,7 +666,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	spin_lock_init(&local->queue_stop_reason_lock);
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		INIT_LIST_HEAD(&local->active_txqs[i]);
+		local->active_txqs[i] = RB_ROOT_CACHED;
 		spin_lock_init(&local->active_txq_lock[i]);
 	}
 	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 11f0589..9d01fdd 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -389,7 +389,6 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
-		sta->airtime[i].deficit = sta->airtime_weight;
 	}
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1831,18 +1830,32 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 {
 	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
 	struct ieee80211_local *local = sta->sdata->local;
+	struct ieee80211_txq *txq = sta->sta.txq[tid];
 	u8 ac = ieee80211_ac_from_tid(tid);
-	u32 airtime = 0;
+	u64 airtime = 0, weight_sum;
+
+	if (!txq)
+		return;
 
 	if (sta->local->airtime_flags & AIRTIME_USE_TX)
 		airtime += tx_airtime;
 	if (sta->local->airtime_flags & AIRTIME_USE_RX)
 		airtime += rx_airtime;
 
+	/* Weights scale so the unit weight is 256 */
+	airtime <<= 8;
+
 	spin_lock_bh(&local->active_txq_lock[ac]);
+
 	sta->airtime[ac].tx_airtime += tx_airtime;
 	sta->airtime[ac].rx_airtime += rx_airtime;
-	sta->airtime[ac].deficit -= airtime;
+
+	weight_sum = local->airtime_weight_sum[ac] ?: sta->airtime_weight;
+
+	local->airtime_v_t[ac] += airtime / weight_sum;
+	sta->airtime[ac].v_t += airtime / sta->airtime_weight;
+	ieee80211_resort_txq(&local->hw, txq);
+
 	spin_unlock_bh(&local->active_txq_lock[ac]);
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 71f7e49..5c1cac9 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -130,11 +130,12 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
+#define AIRTIME_GRACE 500 /* usec of grace period before reset */
 
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
-	s64 deficit;
+	u64 v_t;
 };
 
 struct sta_info;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 61c7ea9..d00baaa 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1449,7 +1449,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	codel_vars_init(&txqi->def_cvars);
 	codel_stats_init(&txqi->cstats);
 	__skb_queue_head_init(&txqi->frags);
-	INIT_LIST_HEAD(&txqi->schedule_order);
+	RB_CLEAR_NODE(&txqi->schedule_order);
 
 	txqi->txq.vif = &sdata->vif;
 
@@ -1493,9 +1493,7 @@ void ieee80211_txq_purge(struct ieee80211_local *local,
 	ieee80211_purge_tx_queue(&local->hw, &txqi->frags);
 	spin_unlock_bh(&fq->lock);
 
-	spin_lock_bh(&local->active_txq_lock[txqi->txq.ac]);
-	list_del_init(&txqi->schedule_order);
-	spin_unlock_bh(&local->active_txq_lock[txqi->txq.ac]);
+	ieee80211_unschedule_txq(&local->hw, &txqi->txq);
 }
 
 void ieee80211_txq_set_params(struct ieee80211_local *local)
@@ -3640,126 +3638,191 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct rb_node *node = local->schedule_pos[ac];
 	struct txq_info *txqi = NULL;
+	bool first = false;
 
 	lockdep_assert_held(&local->active_txq_lock[ac]);
 
- begin:
-	txqi = list_first_entry_or_null(&local->active_txqs[ac],
-					struct txq_info,
-					schedule_order);
-	if (!txqi)
+	if (!node) {
+		node = rb_first_cached(&local->active_txqs[ac]);
+		first = true;
+	} else {
+		node = rb_next(node);
+	}
+
+	if (!node)
 		return NULL;
 
+	txqi = container_of(node, struct txq_info, schedule_order);
+
 	if (txqi->txq.sta) {
 		struct sta_info *sta = container_of(txqi->txq.sta,
 						struct sta_info, sta);
 
-		if (sta->airtime[txqi->txq.ac].deficit < 0) {
-			sta->airtime[txqi->txq.ac].deficit +=
-				sta->airtime_weight;
-			list_move_tail(&txqi->schedule_order,
-				       &local->active_txqs[txqi->txq.ac]);
-			goto begin;
+		if (sta->airtime[ac].v_t > local->airtime_v_t[ac]) {
+			if (first)
+				local->airtime_v_t[ac] = sta->airtime[ac].v_t;
+			else
+				return NULL;
 		}
 	}
 
 
-	if (txqi->schedule_round == local->schedule_round[ac])
-		return NULL;
-
-	list_del_init(&txqi->schedule_order);
-	txqi->schedule_round = local->schedule_round[ac];
+	local->schedule_pos[ac] = node;
 	return &txqi->txq;
 }
 EXPORT_SYMBOL(ieee80211_next_txq);
 
-void ieee80211_return_txq(struct ieee80211_hw *hw,
+static void __ieee80211_insert_txq(struct rb_root_cached *root,
+				   struct txq_info *txqi, u8 ac)
+{
+	struct rb_node **new = &root->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct txq_info *__txqi;
+	bool leftmost = true;
+
+	while (*new) {
+		parent = *new;
+		__txqi = rb_entry(parent, struct txq_info, schedule_order);
+
+		if (!txqi->txq.sta) {
+			/* new txqi has no sta - insert to the left */
+			new = &parent->rb_left;
+		} else if (!__txqi->txq.sta) {
+			/* existing txqi has no sta - insert to the right */
+			new = &parent->rb_right;
+			leftmost = false;
+		} else {
+			struct sta_info *old_sta = container_of(__txqi->txq.sta,
+								struct sta_info,
+								sta);
+			struct sta_info *new_sta = container_of(txqi->txq.sta,
+								struct sta_info,
+								sta);
+
+			if (new_sta->airtime[ac].v_t <= old_sta->airtime[ac].v_t) {
+				new = &parent->rb_left;
+			} else {
+				new = &parent->rb_right;
+				leftmost = false;
+			}
+		}
+	}
+
+	rb_link_node(&txqi->schedule_order, parent, new);
+	rb_insert_color_cached(&txqi->schedule_order, root, leftmost);
+}
+
+void ieee80211_schedule_txq(struct ieee80211_hw *hw,
+			    struct ieee80211_txq *txq)
+	__acquires(txq_lock) __releases(txq_lock)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
+	u8 ac = txq->ac;
+
+	spin_lock_bh(&local->active_txq_lock[ac]);
+
+	if (!RB_EMPTY_NODE(&txqi->schedule_order))
+		goto out;
+
+	if (txq->sta) {
+		struct sta_info *sta = container_of(txq->sta,
+						    struct sta_info, sta);
+
+		local->airtime_weight_sum[ac] += sta->airtime_weight;
+		if (local->airtime_v_t[ac] > AIRTIME_GRACE)
+			sta->airtime[ac].v_t = max(local->airtime_v_t[ac] - AIRTIME_GRACE,
+						   sta->airtime[ac].v_t);
+	}
+
+	__ieee80211_insert_txq(&local->active_txqs[ac], txqi, ac);
+
+ out:
+	spin_unlock_bh(&local->active_txq_lock[ac]);
+}
+EXPORT_SYMBOL(ieee80211_schedule_txq);
+
+void ieee80211_resort_txq(struct ieee80211_hw *hw,
 			  struct ieee80211_txq *txq)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = to_txq_info(txq);
+	u8 ac = txq->ac;
+
+	if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
+		rb_erase_cached(&txqi->schedule_order,
+				&local->active_txqs[ac]);
+		RB_CLEAR_NODE(&txqi->schedule_order);
+		__ieee80211_insert_txq(&local->active_txqs[ac], txqi, ac);
+	}
+}
+
+static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
+				       struct ieee80211_txq *txq)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
+	u8 ac = txq->ac;
 
 	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
 
-	if (list_empty(&txqi->schedule_order) &&
-	    (!skb_queue_empty(&txqi->frags) || txqi->tin.backlog_packets)) {
-		/* If airtime accounting is active, always enqueue STAs at the
-		 * head of the list to ensure that they only get moved to the
-		 * back by the airtime DRR scheduler once they have a negative
-		 * deficit. A station that already has a negative deficit will
-		 * get immediately moved to the back of the list on the next
-		 * call to ieee80211_next_txq().
-		 */
-		if (txqi->txq.sta &&
-		    wiphy_ext_feature_isset(local->hw.wiphy,
-					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
-			list_add(&txqi->schedule_order,
-				 &local->active_txqs[txq->ac]);
-		else
-			list_add_tail(&txqi->schedule_order,
-				      &local->active_txqs[txq->ac]);
+	if (RB_EMPTY_NODE(&txqi->schedule_order))
+		return;
+
+	if (txq->sta) {
+		struct sta_info *sta = container_of(txq->sta,
+						    struct sta_info, sta);
+
+		local->airtime_weight_sum[ac] -= sta->airtime_weight;
 	}
+
+	rb_erase_cached(&txqi->schedule_order,
+			&local->active_txqs[txq->ac]);
+	RB_CLEAR_NODE(&txqi->schedule_order);
 }
-EXPORT_SYMBOL(ieee80211_return_txq);
 
-void ieee80211_schedule_txq(struct ieee80211_hw *hw,
-			    struct ieee80211_txq *txq)
+void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq)
 	__acquires(txq_lock) __releases(txq_lock)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	spin_lock_bh(&local->active_txq_lock[txq->ac]);
-	ieee80211_return_txq(hw, txq);
+	__ieee80211_unschedule_txq(hw, txq);
 	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
 }
-EXPORT_SYMBOL(ieee80211_schedule_txq);
+
+void ieee80211_return_txq(struct ieee80211_hw *hw,
+			  struct ieee80211_txq *txq)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
+
+	lockdep_assert_held(&local->active_txq_lock[txq->ac]);
+
+	if (!RB_EMPTY_NODE(&txqi->schedule_order) &&
+	    (skb_queue_empty(&txqi->frags) && !txqi->tin.backlog_packets))
+		__ieee80211_unschedule_txq(hw, txq);
+}
+EXPORT_SYMBOL(ieee80211_return_txq);
 
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct txq_info *iter, *tmp, *txqi = to_txq_info(txq);
+	struct txq_info *txqi = to_txq_info(txq);
 	struct sta_info *sta;
 	u8 ac = txq->ac;
 
 	lockdep_assert_held(&local->active_txq_lock[ac]);
 
 	if (!txqi->txq.sta)
-		goto out;
-
-	if (list_empty(&txqi->schedule_order))
-		goto out;
-
-	list_for_each_entry_safe(iter, tmp, &local->active_txqs[ac],
-				 schedule_order) {
-		if (iter == txqi)
-			break;
-
-		if (!iter->txq.sta) {
-			list_move_tail(&iter->schedule_order,
-				       &local->active_txqs[ac]);
-			continue;
-		}
-		sta = container_of(iter->txq.sta, struct sta_info, sta);
-		if (sta->airtime[ac].deficit < 0)
-			sta->airtime[ac].deficit += sta->airtime_weight;
-		list_move_tail(&iter->schedule_order, &local->active_txqs[ac]);
-	}
+		return true;
 
 	sta = container_of(txqi->txq.sta, struct sta_info, sta);
-	if (sta->airtime[ac].deficit >= 0)
-		goto out;
-
-	sta->airtime[ac].deficit += sta->airtime_weight;
-	list_move_tail(&txqi->schedule_order, &local->active_txqs[ac]);
-
-	return false;
-out:
-	if (!list_empty(&txqi->schedule_order))
-		list_del_init(&txqi->schedule_order);
-
-	return true;
+	return (sta->airtime[ac].v_t <= local->airtime_v_t[ac]);
 }
 EXPORT_SYMBOL(ieee80211_txq_may_transmit);
 
@@ -3769,7 +3832,6 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
-	local->schedule_round[ac]++;
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
@@ -3778,6 +3840,7 @@ void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
+	local->schedule_pos[ac] = NULL;
 	spin_unlock_bh(&local->active_txq_lock[ac]);
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_end);
-- 
1.9.1

