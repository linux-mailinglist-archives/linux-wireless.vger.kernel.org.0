Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EABA55ACC0
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jun 2022 23:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiFYVYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jun 2022 17:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiFYVYU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jun 2022 17:24:20 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B59EE3C
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jun 2022 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=klCY+4H42FCPTiArFwUSJ2BNbtHjGvak81X/dUuwAdo=; b=psBfJp1sCVWEJ52xzGMdjforl5
        Axug4mrCdZSjHNVM4hMvaHY5v+FqLa/yO9p7E7YC0Ez33GbkRzUG0LPsF9kHwNMHAcor9q2qlflaG
        yHCFbIDxCCs+kDJyMZkhYx4mZwuBCrC8P/oCBFvsVfvDxp02oRCsNaE9mzba91/fbl1U=;
Received: from p200300daa733bc000d99dad39793d523.dip0.t-ipconnect.de ([2003:da:a733:bc00:d99:dad3:9793:d523] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o5DGG-0003Vi-Tq; Sat, 25 Jun 2022 23:24:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@kernel.org, johannes@sipsolutions.net
Subject: [PATCH 1/7] mac80211: switch airtime fairness back to deficit round-robin scheduling
Date:   Sat, 25 Jun 2022 23:24:05 +0200
Message-Id: <20220625212411.36675-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
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

This reverts commits 6a789ba679d652587532cec2a0e0274fda172f3b and
2433647bc8d983a543e7d31b41ca2de1c7e2c198.

The virtual time scheduler code has a number of issues:
- queues slowed down by hardware/firmware powersave handling were not properly
  handled.
- on ath10k in push-pull mode, tx queues that the driver tries to pull from
  were starved, causing excessive latency
- delay between tx enqueue and reported airtime use were causing excessively
  bursty tx behavior

The bursty behavior may also be present on the round-robin scheduler, but there
it is much easier to fix without introducing additional regressions

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h        |  17 +-
 net/mac80211/cfg.c            |  35 +---
 net/mac80211/debugfs.c        |  70 ++-----
 net/mac80211/debugfs_netdev.c |  32 +--
 net/mac80211/debugfs_sta.c    |  24 +--
 net/mac80211/ieee80211_i.h    | 182 ++---------------
 net/mac80211/iface.c          |   4 -
 net/mac80211/main.c           |  11 +-
 net/mac80211/rx.c             |   6 +-
 net/mac80211/sta_info.c       |  67 ++-----
 net/mac80211/sta_info.h       |  11 +-
 net/mac80211/status.c         |  19 --
 net/mac80211/tx.c             | 366 ++++++++++------------------------
 13 files changed, 193 insertions(+), 651 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 27f24ac0426d..48d167c5a726 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6832,6 +6832,9 @@ static inline void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
 {
 }
 
+void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq, bool force);
+
 /**
  * ieee80211_schedule_txq - schedule a TXQ for transmission
  *
@@ -6844,7 +6847,11 @@ static inline void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
  * The driver may call this function if it has buffered packets for
  * this TXQ internally.
  */
-void ieee80211_schedule_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
+static inline void
+ieee80211_schedule_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
+{
+	__ieee80211_schedule_txq(hw, txq, true);
+}
 
 /**
  * ieee80211_return_txq - return a TXQ previously acquired by ieee80211_next_txq()
@@ -6856,8 +6863,12 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
  * The driver may set force=true if it has buffered packets for this TXQ
  * internally.
  */
-void ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
-			  bool force);
+static inline void
+ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
+		     bool force)
+{
+	__ieee80211_schedule_txq(hw, txq, force);
+}
 
 /**
  * ieee80211_txq_may_transmit - check whether TXQ is allowed to transmit
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b387f5f4fef0..fd6c4291c971 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1581,38 +1581,6 @@ static void sta_apply_mesh_params(struct ieee80211_local *local,
 #endif
 }
 
-static void sta_apply_airtime_params(struct ieee80211_local *local,
-				     struct sta_info *sta,
-				     struct station_parameters *params)
-{
-	u8 ac;
-
-	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct airtime_sched_info *air_sched = &local->airtime[ac];
-		struct airtime_info *air_info = &sta->airtime[ac];
-		struct txq_info *txqi;
-		u8 tid;
-
-		spin_lock_bh(&air_sched->lock);
-		for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
-			if (air_info->weight == params->airtime_weight ||
-			    !sta->sta.txq[tid] ||
-			    ac != ieee80211_ac_from_tid(tid))
-				continue;
-
-			airtime_weight_set(air_info, params->airtime_weight);
-
-			txqi = to_txq_info(sta->sta.txq[tid]);
-			if (RB_EMPTY_NODE(&txqi->schedule_order))
-				continue;
-
-			ieee80211_update_airtime_weight(local, air_sched,
-							0, true);
-		}
-		spin_unlock_bh(&air_sched->lock);
-	}
-}
-
 static int sta_apply_parameters(struct ieee80211_local *local,
 				struct sta_info *sta,
 				struct station_parameters *params)
@@ -1811,8 +1779,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 		sta_apply_mesh_params(local, sta, params);
 
 	if (params->airtime_weight)
-		sta_apply_airtime_params(local, sta, params);
-
+		sta->airtime_weight = params->airtime_weight;
 
 	/* set the STA state after all sta info from usermode has been set */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) ||
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 1fe43b264d75..0c748b1eb023 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -216,14 +216,14 @@ static ssize_t aql_txq_limit_read(struct file *file,
 			"VI	%u		%u\n"
 			"BE	%u		%u\n"
 			"BK	%u		%u\n",
-			local->airtime[IEEE80211_AC_VO].aql_txq_limit_low,
-			local->airtime[IEEE80211_AC_VO].aql_txq_limit_high,
-			local->airtime[IEEE80211_AC_VI].aql_txq_limit_low,
-			local->airtime[IEEE80211_AC_VI].aql_txq_limit_high,
-			local->airtime[IEEE80211_AC_BE].aql_txq_limit_low,
-			local->airtime[IEEE80211_AC_BE].aql_txq_limit_high,
-			local->airtime[IEEE80211_AC_BK].aql_txq_limit_low,
-			local->airtime[IEEE80211_AC_BK].aql_txq_limit_high);
+			local->aql_txq_limit_low[IEEE80211_AC_VO],
+			local->aql_txq_limit_high[IEEE80211_AC_VO],
+			local->aql_txq_limit_low[IEEE80211_AC_VI],
+			local->aql_txq_limit_high[IEEE80211_AC_VI],
+			local->aql_txq_limit_low[IEEE80211_AC_BE],
+			local->aql_txq_limit_high[IEEE80211_AC_BE],
+			local->aql_txq_limit_low[IEEE80211_AC_BK],
+			local->aql_txq_limit_high[IEEE80211_AC_BK]);
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
 }
@@ -255,11 +255,11 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	if (ac >= IEEE80211_NUM_ACS)
 		return -EINVAL;
 
-	q_limit_low_old = local->airtime[ac].aql_txq_limit_low;
-	q_limit_high_old = local->airtime[ac].aql_txq_limit_high;
+	q_limit_low_old = local->aql_txq_limit_low[ac];
+	q_limit_high_old = local->aql_txq_limit_high[ac];
 
-	local->airtime[ac].aql_txq_limit_low = q_limit_low;
-	local->airtime[ac].aql_txq_limit_high = q_limit_high;
+	local->aql_txq_limit_low[ac] = q_limit_low;
+	local->aql_txq_limit_high[ac] = q_limit_high;
 
 	mutex_lock(&local->sta_mtx);
 	list_for_each_entry(sta, &local->sta_list, list) {
@@ -382,46 +382,6 @@ static const struct file_operations force_tx_status_ops = {
 	.llseek = default_llseek,
 };
 
-static ssize_t airtime_read(struct file *file,
-			    char __user *user_buf,
-			    size_t count,
-			    loff_t *ppos)
-{
-	struct ieee80211_local *local = file->private_data;
-	char buf[200];
-	u64 v_t[IEEE80211_NUM_ACS];
-	u64 wt[IEEE80211_NUM_ACS];
-	int len = 0, ac;
-
-	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->airtime[ac].lock);
-		v_t[ac] = local->airtime[ac].v_t;
-		wt[ac] = local->airtime[ac].weight_sum;
-		spin_unlock_bh(&local->airtime[ac].lock);
-	}
-	len = scnprintf(buf, sizeof(buf),
-			"\tVO         VI         BE         BK\n"
-			"Virt-t\t%-10llu %-10llu %-10llu %-10llu\n"
-			"Weight\t%-10llu %-10llu %-10llu %-10llu\n",
-			v_t[0],
-			v_t[1],
-			v_t[2],
-			v_t[3],
-			wt[0],
-			wt[1],
-			wt[2],
-			wt[3]);
-
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       buf, len);
-}
-
-static const struct file_operations airtime_ops = {
-	.read = airtime_read,
-	.open = simple_open,
-	.llseek = default_llseek,
-};
-
 #ifdef CONFIG_PM
 static ssize_t reset_write(struct file *file, const char __user *user_buf,
 			   size_t count, loff_t *ppos)
@@ -675,11 +635,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	if (local->ops->wake_tx_queue)
 		DEBUGFS_ADD_MODE(aqm, 0600);
 
-	if (wiphy_ext_feature_isset(local->hw.wiphy,
-				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS)) {
-		DEBUGFS_ADD_MODE(airtime, 0600);
-		DEBUGFS_ADD_MODE(airtime_flags, 0600);
-	}
+	DEBUGFS_ADD_MODE(airtime_flags, 0600);
 
 	DEBUGFS_ADD(aql_txq_limit);
 	debugfs_create_u32("aql_threshold", 0600,
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index dfb194e15018..ead917501d6c 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -510,34 +510,6 @@ static ssize_t ieee80211_if_fmt_aqm(
 }
 IEEE80211_IF_FILE_R(aqm);
 
-static ssize_t ieee80211_if_fmt_airtime(
-	const struct ieee80211_sub_if_data *sdata, char *buf, int buflen)
-{
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_txq *txq = sdata->vif.txq;
-	struct airtime_info *air_info;
-	int len;
-
-	if (!txq)
-		return 0;
-
-	spin_lock_bh(&local->airtime[txq->ac].lock);
-	air_info = to_airtime_info(txq);
-	len = scnprintf(buf,
-			buflen,
-			"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-			"Virt-T: %lld us\n",
-			air_info->rx_airtime,
-			air_info->tx_airtime,
-			air_info->weight,
-			air_info->v_t);
-	spin_unlock_bh(&local->airtime[txq->ac].lock);
-
-	return len;
-}
-
-IEEE80211_IF_FILE_R(airtime);
-
 IEEE80211_IF_FILE(multicast_to_unicast, u.ap.multicast_to_unicast, HEX);
 
 /* IBSS attributes */
@@ -683,10 +655,8 @@ static void add_common_files(struct ieee80211_sub_if_data *sdata)
 
 	if (sdata->local->ops->wake_tx_queue &&
 	    sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
-	    sdata->vif.type != NL80211_IFTYPE_NAN) {
+	    sdata->vif.type != NL80211_IFTYPE_NAN)
 		DEBUGFS_ADD(aqm);
-		DEBUGFS_ADD(airtime);
-	}
 }
 
 static void add_sta_files(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 182094be9001..1dc238fc24f0 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -202,7 +202,7 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	size_t bufsz = 400;
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
 	u64 rx_airtime = 0, tx_airtime = 0;
-	u64 v_t[IEEE80211_NUM_ACS];
+	s64 deficit[IEEE80211_NUM_ACS];
 	ssize_t rv;
 	int ac;
 
@@ -210,18 +210,18 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 		return -ENOMEM;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->airtime[ac].lock);
+		spin_lock_bh(&local->active_txq_lock[ac]);
 		rx_airtime += sta->airtime[ac].rx_airtime;
 		tx_airtime += sta->airtime[ac].tx_airtime;
-		v_t[ac] = sta->airtime[ac].v_t;
-		spin_unlock_bh(&local->airtime[ac].lock);
+		deficit[ac] = sta->airtime[ac].deficit;
+		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
 
 	p += scnprintf(p, bufsz + buf - p,
 		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-		"Virt-T: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
-		rx_airtime, tx_airtime, sta->airtime[0].weight,
-		v_t[0], v_t[1], v_t[2], v_t[3]);
+		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
+		rx_airtime, tx_airtime, sta->airtime_weight,
+		deficit[0], deficit[1], deficit[2], deficit[3]);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 	kfree(buf);
@@ -236,11 +236,11 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 	int ac;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->airtime[ac].lock);
+		spin_lock_bh(&local->active_txq_lock[ac]);
 		sta->airtime[ac].rx_airtime = 0;
 		sta->airtime[ac].tx_airtime = 0;
-		sta->airtime[ac].v_t = 0;
-		spin_unlock_bh(&local->airtime[ac].lock);
+		sta->airtime[ac].deficit = sta->airtime_weight;
+		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
 
 	return count;
@@ -263,10 +263,10 @@ static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
 		return -ENOMEM;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->airtime[ac].lock);
+		spin_lock_bh(&local->active_txq_lock[ac]);
 		q_limit_l[ac] = sta->airtime[ac].aql_limit_low;
 		q_limit_h[ac] = sta->airtime[ac].aql_limit_high;
-		spin_unlock_bh(&local->airtime[ac].lock);
+		spin_unlock_bh(&local->active_txq_lock[ac]);
 		q_depth[ac] = atomic_read(&sta->airtime[ac].aql_tx_pending);
 	}
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2190d08f4e34..8ef27e0f9371 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -818,16 +818,20 @@ enum txq_info_flags {
  * @def_flow: used as a fallback flow when a packet destined to @tin hashes to
  *	a fq_flow which is already owned by a different tin
  * @def_cvars: codel vars for @def_flow
- * @schedule_order: used with ieee80211_local->active_txqs
  * @frags: used to keep fragments created after dequeue
+ * @schedule_order: used with ieee80211_local->active_txqs
+ * @schedule_round: counter to prevent infinite loops on TXQ scheduling
  */
 struct txq_info {
 	struct fq_tin tin;
 	struct codel_vars def_cvars;
 	struct codel_stats cstats;
-	struct rb_node schedule_order;
+
+	u16 schedule_round;
+	struct list_head schedule_order;
 
 	struct sk_buff_head frags;
+
 	unsigned long flags;
 
 	/* keep last! */
@@ -923,8 +927,6 @@ struct ieee80211_link_data {
 	struct ieee80211_key __rcu *default_mgmt_key;
 	struct ieee80211_key __rcu *default_beacon_key;
 
-	struct airtime_info airtime[IEEE80211_NUM_ACS];
-
 	struct work_struct csa_finalize_work;
 	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
 	struct cfg80211_chan_def csa_chandef;
@@ -1208,44 +1210,6 @@ enum mac80211_scan_state {
 	SCAN_ABORT,
 };
 
-/**
- * struct airtime_sched_info - state used for airtime scheduling and AQL
- *
- * @lock: spinlock that protects all the fields in this struct
- * @active_txqs: rbtree of currently backlogged queues, sorted by virtual time
- * @schedule_pos: the current position maintained while a driver walks the tree
- *                with ieee80211_next_txq()
- * @active_list: list of struct airtime_info structs that were active within
- *               the last AIRTIME_ACTIVE_DURATION (100 ms), used to compute
- *               weight_sum
- * @last_weight_update: used for rate limiting walking active_list
- * @last_schedule_time: tracks the last time a transmission was scheduled; used
- *                      for catching up v_t if no stations are eligible for
- *                      transmission.
- * @v_t: global virtual time; queues with v_t < this are eligible for
- *       transmission
- * @weight_sum: total sum of all active stations used for dividing airtime
- * @weight_sum_reciprocal: reciprocal of weight_sum (to avoid divisions in fast
- *                         path - see comment above
- *                         IEEE80211_RECIPROCAL_DIVISOR_64)
- * @aql_txq_limit_low: AQL limit when total outstanding airtime
- *                     is < IEEE80211_AQL_THRESHOLD
- * @aql_txq_limit_high: AQL limit when total outstanding airtime
- *                      is > IEEE80211_AQL_THRESHOLD
- */
-struct airtime_sched_info {
-	spinlock_t lock;
-	struct rb_root_cached active_txqs;
-	struct rb_node *schedule_pos;
-	struct list_head active_list;
-	u64 last_weight_update;
-	u64 last_schedule_activity;
-	u64 v_t;
-	u64 weight_sum;
-	u64 weight_sum_reciprocal;
-	u32 aql_txq_limit_low;
-	u32 aql_txq_limit_high;
-};
 DECLARE_STATIC_KEY_FALSE(aql_disable);
 
 struct ieee80211_local {
@@ -1259,8 +1223,13 @@ struct ieee80211_local {
 	struct codel_params cparams;
 
 	/* protects active_txqs and txqi->schedule_order */
-	struct airtime_sched_info airtime[IEEE80211_NUM_ACS];
+	spinlock_t active_txq_lock[IEEE80211_NUM_ACS];
+	struct list_head active_txqs[IEEE80211_NUM_ACS];
+	u16 schedule_round[IEEE80211_NUM_ACS];
+
 	u16 airtime_flags;
+	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
+	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
 	u32 aql_threshold;
 	atomic_t aql_total_pending_airtime;
 
@@ -1683,123 +1652,10 @@ static inline bool txq_has_queue(struct ieee80211_txq *txq)
 	return !(skb_queue_empty(&txqi->frags) && !txqi->tin.backlog_packets);
 }
 
-static inline struct airtime_info *to_airtime_info(struct ieee80211_txq *txq)
-{
-	struct ieee80211_sub_if_data *sdata;
-	struct sta_info *sta;
-
-	if (txq->sta) {
-		sta = container_of(txq->sta, struct sta_info, sta);
-		return &sta->airtime[txq->ac];
-	}
-
-	sdata = vif_to_sdata(txq->vif);
-	return &sdata->deflink.airtime[txq->ac];
-}
-
-/* To avoid divisions in the fast path, we keep pre-computed reciprocals for
- * airtime weight calculations. There are two different weights to keep track
- * of: The per-station weight and the sum of weights per phy.
- *
- * For the per-station weights (kept in airtime_info below), we use 32-bit
- * reciprocals with a devisor of 2^19. This lets us keep the multiplications and
- * divisions for the station weights as 32-bit operations at the cost of a bit
- * of rounding error for high weights; but the choice of divisor keeps rounding
- * errors <10% for weights <2^15, assuming no more than 8ms of airtime is
- * reported at a time.
- *
- * For the per-phy sum of weights the values can get higher, so we use 64-bit
- * operations for those with a 32-bit divisor, which should avoid any
- * significant rounding errors.
- */
-#define IEEE80211_RECIPROCAL_DIVISOR_64 0x100000000ULL
-#define IEEE80211_RECIPROCAL_SHIFT_64 32
-#define IEEE80211_RECIPROCAL_DIVISOR_32 0x80000U
-#define IEEE80211_RECIPROCAL_SHIFT_32 19
-
-static inline void airtime_weight_set(struct airtime_info *air_info, u16 weight)
-{
-	if (air_info->weight == weight)
-		return;
-
-	air_info->weight = weight;
-	if (weight) {
-		air_info->weight_reciprocal =
-			IEEE80211_RECIPROCAL_DIVISOR_32 / weight;
-	} else {
-		air_info->weight_reciprocal = 0;
-	}
-}
-
-static inline void airtime_weight_sum_set(struct airtime_sched_info *air_sched,
-					  int weight_sum)
-{
-	if (air_sched->weight_sum == weight_sum)
-		return;
-
-	air_sched->weight_sum = weight_sum;
-	if (air_sched->weight_sum) {
-		air_sched->weight_sum_reciprocal = IEEE80211_RECIPROCAL_DIVISOR_64;
-		do_div(air_sched->weight_sum_reciprocal, air_sched->weight_sum);
-	} else {
-		air_sched->weight_sum_reciprocal = 0;
-	}
-}
-
-/* A problem when trying to enforce airtime fairness is that we want to divide
- * the airtime between the currently *active* stations. However, basing this on
- * the instantaneous queue state of stations doesn't work, as queues tend to
- * oscillate very quickly between empty and occupied, leading to the scheduler
- * thinking only a single station is active when deciding whether to allow
- * transmission (and thus not throttling correctly).
- *
- * To fix this we use a timer-based notion of activity: a station is considered
- * active if it has been scheduled within the last 100 ms; we keep a separate
- * list of all the stations considered active in this manner, and lazily update
- * the total weight of active stations from this list (filtering the stations in
- * the list by their 'last active' time).
- *
- * We add one additional safeguard to guard against stations that manage to get
- * scheduled every 100 ms but don't transmit a lot of data, and thus don't use
- * up any airtime. Such stations would be able to get priority for an extended
- * period of time if they do start transmitting at full capacity again, and so
- * we add an explicit maximum for how far behind a station is allowed to fall in
- * the virtual airtime domain. This limit is set to a relatively high value of
- * 20 ms because the main mechanism for catching up idle stations is the active
- * state as described above; i.e., the hard limit should only be hit in
- * pathological cases.
- */
-#define AIRTIME_ACTIVE_DURATION (100 * NSEC_PER_MSEC)
-#define AIRTIME_MAX_BEHIND 20000 /* 20 ms */
-
-static inline bool airtime_is_active(struct airtime_info *air_info, u64 now)
-{
-	return air_info->last_scheduled >= now - AIRTIME_ACTIVE_DURATION;
-}
-
-static inline void airtime_set_active(struct airtime_sched_info *air_sched,
-				      struct airtime_info *air_info, u64 now)
-{
-	air_info->last_scheduled = now;
-	air_sched->last_schedule_activity = now;
-	list_move_tail(&air_info->list, &air_sched->active_list);
-}
-
-static inline bool airtime_catchup_v_t(struct airtime_sched_info *air_sched,
-				       u64 v_t, u64 now)
-{
-	air_sched->v_t = v_t;
-	return true;
-}
-
-static inline void init_airtime_info(struct airtime_info *air_info,
-				     struct airtime_sched_info *air_sched)
+static inline int ieee80211_bssid_match(const u8 *raddr, const u8 *addr)
 {
-	atomic_set(&air_info->aql_tx_pending, 0);
-	air_info->aql_limit_low = air_sched->aql_txq_limit_low;
-	air_info->aql_limit_high = air_sched->aql_txq_limit_high;
-	airtime_weight_set(air_info, IEEE80211_DEFAULT_AIRTIME_WEIGHT);
-	INIT_LIST_HEAD(&air_info->list);
+	return ether_addr_equal(raddr, addr) ||
+	       is_broadcast_ether_addr(raddr);
 }
 
 static inline bool
@@ -2047,14 +1903,6 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      u64 *cookie);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
-void ieee80211_resort_txq(struct ieee80211_hw *hw,
-			  struct ieee80211_txq *txq);
-void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
-			      struct ieee80211_txq *txq,
-			      bool purge);
-void ieee80211_update_airtime_weight(struct ieee80211_local *local,
-				     struct airtime_sched_info *air_sched,
-				     u64 now, bool force);
 
 /* HT */
 void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 0cf5a395d925..56dd831fe45f 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2176,10 +2176,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		}
 	}
 
-	for (i = 0; i < IEEE80211_NUM_ACS; i++)
-		init_airtime_info(&sdata->deflink.airtime[i],
-				  &local->airtime[i]);
-
 	ieee80211_set_default_queues(sdata);
 
 	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 08f153b82a23..e6c1cafbe9e5 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -784,13 +784,10 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	spin_lock_init(&local->queue_stop_reason_lock);
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		struct airtime_sched_info *air_sched = &local->airtime[i];
-
-		air_sched->active_txqs = RB_ROOT_CACHED;
-		INIT_LIST_HEAD(&air_sched->active_list);
-		spin_lock_init(&air_sched->lock);
-		air_sched->aql_txq_limit_low = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
-		air_sched->aql_txq_limit_high =
+		INIT_LIST_HEAD(&local->active_txqs[i]);
+		spin_lock_init(&local->active_txq_lock[i]);
+		local->aql_txq_limit_low[i] = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
+		local->aql_txq_limit_high[i] =
 			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d017ad14d7db..834d2171f344 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1565,8 +1565,12 @@ static void sta_ps_start(struct sta_info *sta)
 
 	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
 		struct ieee80211_txq *txq = sta->sta.txq[tid];
+		struct txq_info *txqi = to_txq_info(txq);
 
-		ieee80211_unschedule_txq(&local->hw, txq, false);
+		spin_lock(&local->active_txq_lock[txq->ac]);
+		if (!list_empty(&txqi->schedule_order))
+			list_del_init(&txqi->schedule_order);
+		spin_unlock(&local->active_txq_lock[txq->ac]);
 
 		if (txq_has_queue(txq))
 			set_bit(tid, &sta->txq_buffered_tids);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 014032369994..a1a2118b4bf0 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -559,11 +559,15 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	if (sta_prepare_rate_control(local, sta, gfp))
 		goto free_txq;
 
+	sta->airtime_weight = IEEE80211_DEFAULT_AIRTIME_WEIGHT;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
-		init_airtime_info(&sta->airtime[i], &local->airtime[i]);
+		sta->airtime[i].deficit = sta->airtime_weight;
+		atomic_set(&sta->airtime[i].aql_tx_pending, 0);
+		sta->airtime[i].aql_limit_low = local->aql_txq_limit_low[i];
+		sta->airtime[i].aql_limit_high = local->aql_txq_limit_high[i];
 	}
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
@@ -2035,59 +2039,24 @@ void ieee80211_sta_set_buffered(struct ieee80211_sta *pubsta,
 }
 EXPORT_SYMBOL(ieee80211_sta_set_buffered);
 
-void ieee80211_register_airtime(struct ieee80211_txq *txq,
-				u32 tx_airtime, u32 rx_airtime)
+void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
+				    u32 tx_airtime, u32 rx_airtime)
 {
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->vif);
-	struct ieee80211_local *local = sdata->local;
-	u64 weight_sum, weight_sum_reciprocal;
-	struct airtime_sched_info *air_sched;
-	struct airtime_info *air_info;
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+	struct ieee80211_local *local = sta->sdata->local;
+	u8 ac = ieee80211_ac_from_tid(tid);
 	u32 airtime = 0;
 
-	air_sched = &local->airtime[txq->ac];
-	air_info = to_airtime_info(txq);
-
-	if (local->airtime_flags & AIRTIME_USE_TX)
+	if (sta->local->airtime_flags & AIRTIME_USE_TX)
 		airtime += tx_airtime;
-	if (local->airtime_flags & AIRTIME_USE_RX)
+	if (sta->local->airtime_flags & AIRTIME_USE_RX)
 		airtime += rx_airtime;
 
-	/* Weights scale so the unit weight is 256 */
-	airtime <<= 8;
-
-	spin_lock_bh(&air_sched->lock);
-
-	air_info->tx_airtime += tx_airtime;
-	air_info->rx_airtime += rx_airtime;
-
-	if (air_sched->weight_sum) {
-		weight_sum = air_sched->weight_sum;
-		weight_sum_reciprocal = air_sched->weight_sum_reciprocal;
-	} else {
-		weight_sum = air_info->weight;
-		weight_sum_reciprocal = air_info->weight_reciprocal;
-	}
-
-	/* Round the calculation of global vt */
-	air_sched->v_t += (u64)((airtime + (weight_sum >> 1)) *
-				weight_sum_reciprocal) >> IEEE80211_RECIPROCAL_SHIFT_64;
-	air_info->v_t += (u32)((airtime + (air_info->weight >> 1)) *
-			       air_info->weight_reciprocal) >> IEEE80211_RECIPROCAL_SHIFT_32;
-	ieee80211_resort_txq(&local->hw, txq);
-
-	spin_unlock_bh(&air_sched->lock);
-}
-
-void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
-				    u32 tx_airtime, u32 rx_airtime)
-{
-	struct ieee80211_txq *txq = pubsta->txq[tid];
-
-	if (!txq)
-		return;
-
-	ieee80211_register_airtime(txq, tx_airtime, rx_airtime);
+	spin_lock_bh(&local->active_txq_lock[ac]);
+	sta->airtime[ac].tx_airtime += tx_airtime;
+	sta->airtime[ac].rx_airtime += rx_airtime;
+	sta->airtime[ac].deficit -= airtime;
+	spin_unlock_bh(&local->active_txq_lock[ac]);
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
 
@@ -2501,7 +2470,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT))) {
-		sinfo->airtime_weight = sta->airtime[0].weight;
+		sinfo->airtime_weight = sta->airtime_weight;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
 	}
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 218430790660..4ba0c252da95 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -135,25 +135,18 @@ enum ieee80211_agg_stop_reason {
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
 
-
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
-	u64 v_t;
-	u64 last_scheduled;
-	struct list_head list;
+	s64 deficit;
 	atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
 	u32 aql_limit_low;
 	u32 aql_limit_high;
-	u32 weight_reciprocal;
-	u16 weight;
 };
 
 void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 					  struct sta_info *sta, u8 ac,
 					  u16 tx_airtime, bool tx_completed);
-void ieee80211_register_airtime(struct ieee80211_txq *txq,
-				u32 tx_airtime, u32 rx_airtime);
 
 struct sta_info;
 
@@ -607,6 +600,7 @@ struct link_sta_info {
  * @tid_seq: per-TID sequence numbers for sending to this STA
  * @airtime: per-AC struct airtime_info describing airtime statistics for this
  *	station
+ * @airtime_weight: station weight for airtime fairness calculation purposes
  * @ampdu_mlme: A-MPDU state machine state
  * @mesh: mesh STA information
  * @debugfs_dir: debug filesystem directory dentry
@@ -691,6 +685,7 @@ struct sta_info {
 	u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
 
 	struct airtime_info airtime[IEEE80211_NUM_ACS];
+	u16 airtime_weight;
 
 	/*
 	 * Aggregation information, locked with lock.
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 5c2202a7ea1c..9bd4d336d444 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -998,25 +998,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
 			ieee80211_frame_acked(sta, skb);
 
-	} else if (wiphy_ext_feature_isset(local->hw.wiphy,
-					   NL80211_EXT_FEATURE_AIRTIME_FAIRNESS)) {
-		struct ieee80211_sub_if_data *sdata;
-		struct ieee80211_txq *txq;
-		u32 airtime;
-
-		/* Account airtime to multicast queue */
-		sdata = ieee80211_sdata_from_skb(local, skb);
-
-		if (sdata && (txq = sdata->vif.txq)) {
-			airtime = info->status.tx_time ?:
-				ieee80211_calc_expected_tx_airtime(hw,
-								   &sdata->vif,
-								   NULL,
-								   skb->len,
-								   false);
-
-			ieee80211_register_airtime(txq, airtime, 0);
-		}
 	}
 
 	/* SNMP counters
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c3e14ef20c05..fcee60ce2456 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -18,7 +18,6 @@
 #include <linux/bitmap.h>
 #include <linux/rcupdate.h>
 #include <linux/export.h>
-#include <linux/timekeeping.h>
 #include <net/net_namespace.h>
 #include <net/ieee80211_radiotap.h>
 #include <net/cfg80211.h>
@@ -1479,7 +1478,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	codel_vars_init(&txqi->def_cvars);
 	codel_stats_init(&txqi->cstats);
 	__skb_queue_head_init(&txqi->frags);
-	RB_CLEAR_NODE(&txqi->schedule_order);
+	INIT_LIST_HEAD(&txqi->schedule_order);
 
 	txqi->txq.vif = &sdata->vif;
 
@@ -1523,7 +1522,9 @@ void ieee80211_txq_purge(struct ieee80211_local *local,
 	ieee80211_purge_tx_queue(&local->hw, &txqi->frags);
 	spin_unlock_bh(&fq->lock);
 
-	ieee80211_unschedule_txq(&local->hw, &txqi->txq, true);
+	spin_lock_bh(&local->active_txq_lock[txqi->txq.ac]);
+	list_del_init(&txqi->schedule_order);
+	spin_unlock_bh(&local->active_txq_lock[txqi->txq.ac]);
 }
 
 void ieee80211_txq_set_params(struct ieee80211_local *local)
@@ -3802,259 +3803,102 @@ EXPORT_SYMBOL(ieee80211_tx_dequeue);
 struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct airtime_sched_info *air_sched;
-	u64 now = ktime_get_coarse_boottime_ns();
 	struct ieee80211_txq *ret = NULL;
-	struct airtime_info *air_info;
-	struct txq_info *txqi = NULL;
-	struct rb_node *node;
-	bool first = false;
+	struct txq_info *txqi = NULL, *head = NULL;
+	bool found_eligible_txq = false;
 
-	air_sched = &local->airtime[ac];
-	spin_lock_bh(&air_sched->lock);
+	spin_lock_bh(&local->active_txq_lock[ac]);
 
-	node = air_sched->schedule_pos;
-
-begin:
-	if (!node) {
-		node = rb_first_cached(&air_sched->active_txqs);
-		first = true;
-	} else {
-		node = rb_next(node);
-	}
-
-	if (!node)
-		goto out;
-
-	txqi = container_of(node, struct txq_info, schedule_order);
-	air_info = to_airtime_info(&txqi->txq);
-
-	if (air_info->v_t > air_sched->v_t &&
-	    (!first || !airtime_catchup_v_t(air_sched, air_info->v_t, now)))
+ begin:
+	txqi = list_first_entry_or_null(&local->active_txqs[ac],
+					struct txq_info,
+					schedule_order);
+	if (!txqi)
 		goto out;
 
-	if (!ieee80211_txq_airtime_check(hw, &txqi->txq)) {
-		first = false;
-		goto begin;
-	}
-
-	air_sched->schedule_pos = node;
-	air_sched->last_schedule_activity = now;
-	ret = &txqi->txq;
-out:
-	spin_unlock_bh(&air_sched->lock);
-	return ret;
-}
-EXPORT_SYMBOL(ieee80211_next_txq);
-
-static void __ieee80211_insert_txq(struct rb_root_cached *root,
-				   struct txq_info *txqi)
-{
-	struct rb_node **new = &root->rb_root.rb_node;
-	struct airtime_info *old_air, *new_air;
-	struct rb_node *parent = NULL;
-	struct txq_info *__txqi;
-	bool leftmost = true;
-
-	while (*new) {
-		parent = *new;
-		__txqi = rb_entry(parent, struct txq_info, schedule_order);
-		old_air = to_airtime_info(&__txqi->txq);
-		new_air = to_airtime_info(&txqi->txq);
-
-		if (new_air->v_t <= old_air->v_t) {
-			new = &parent->rb_left;
-		} else {
-			new = &parent->rb_right;
-			leftmost = false;
-		}
+	if (txqi == head) {
+		if (!found_eligible_txq)
+			goto out;
+		else
+			found_eligible_txq = false;
 	}
 
-	rb_link_node(&txqi->schedule_order, parent, new);
-	rb_insert_color_cached(&txqi->schedule_order, root, leftmost);
-}
+	if (!head)
+		head = txqi;
 
-void ieee80211_resort_txq(struct ieee80211_hw *hw,
-			  struct ieee80211_txq *txq)
-{
-	struct airtime_info *air_info = to_airtime_info(txq);
-	struct ieee80211_local *local = hw_to_local(hw);
-	struct txq_info *txqi = to_txq_info(txq);
-	struct airtime_sched_info *air_sched;
-
-	air_sched = &local->airtime[txq->ac];
-
-	lockdep_assert_held(&air_sched->lock);
+	if (txqi->txq.sta) {
+		struct sta_info *sta = container_of(txqi->txq.sta,
+						    struct sta_info, sta);
+		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
+		s64 deficit = sta->airtime[txqi->txq.ac].deficit;
 
-	if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
-		struct airtime_info *a_prev = NULL, *a_next = NULL;
-		struct txq_info *t_prev, *t_next;
-		struct rb_node *n_prev, *n_next;
+		if (aql_check)
+			found_eligible_txq = true;
 
-		/* Erasing a node can cause an expensive rebalancing operation,
-		 * so we check the previous and next nodes first and only remove
-		 * and re-insert if the current node is not already in the
-		 * correct position.
-		 */
-		if ((n_prev = rb_prev(&txqi->schedule_order)) != NULL) {
-			t_prev = container_of(n_prev, struct txq_info,
-					      schedule_order);
-			a_prev = to_airtime_info(&t_prev->txq);
-		}
+		if (deficit < 0)
+			sta->airtime[txqi->txq.ac].deficit +=
+				sta->airtime_weight;
 
-		if ((n_next = rb_next(&txqi->schedule_order)) != NULL) {
-			t_next = container_of(n_next, struct txq_info,
-					      schedule_order);
-			a_next = to_airtime_info(&t_next->txq);
+		if (deficit < 0 || !aql_check) {
+			list_move_tail(&txqi->schedule_order,
+				       &local->active_txqs[txqi->txq.ac]);
+			goto begin;
 		}
-
-		if ((!a_prev || a_prev->v_t <= air_info->v_t) &&
-		    (!a_next || a_next->v_t > air_info->v_t))
-			return;
-
-		if (air_sched->schedule_pos == &txqi->schedule_order)
-			air_sched->schedule_pos = n_prev;
-
-		rb_erase_cached(&txqi->schedule_order,
-				&air_sched->active_txqs);
-		RB_CLEAR_NODE(&txqi->schedule_order);
-		__ieee80211_insert_txq(&air_sched->active_txqs, txqi);
 	}
-}
 
-void ieee80211_update_airtime_weight(struct ieee80211_local *local,
-				     struct airtime_sched_info *air_sched,
-				     u64 now, bool force)
-{
-	struct airtime_info *air_info, *tmp;
-	u64 weight_sum = 0;
-
-	if (unlikely(!now))
-		now = ktime_get_coarse_boottime_ns();
 
-	lockdep_assert_held(&air_sched->lock);
-
-	if (!force && (air_sched->last_weight_update <
-		       now - AIRTIME_ACTIVE_DURATION))
-		return;
-
-	list_for_each_entry_safe(air_info, tmp,
-				 &air_sched->active_list, list) {
-		if (airtime_is_active(air_info, now))
-			weight_sum += air_info->weight;
-		else
-			list_del_init(&air_info->list);
-	}
-	airtime_weight_sum_set(air_sched, weight_sum);
-	air_sched->last_weight_update = now;
-}
-
-void ieee80211_schedule_txq(struct ieee80211_hw *hw,
-			    struct ieee80211_txq *txq)
-	__acquires(txq_lock) __releases(txq_lock)
-{
-	struct ieee80211_local *local = hw_to_local(hw);
-	struct txq_info *txqi = to_txq_info(txq);
-	struct airtime_sched_info *air_sched;
-	u64 now = ktime_get_coarse_boottime_ns();
-	struct airtime_info *air_info;
-	u8 ac = txq->ac;
-	bool was_active;
-
-	air_sched = &local->airtime[ac];
-	air_info = to_airtime_info(txq);
-
-	spin_lock_bh(&air_sched->lock);
-	was_active = airtime_is_active(air_info, now);
-	airtime_set_active(air_sched, air_info, now);
-
-	if (!RB_EMPTY_NODE(&txqi->schedule_order))
+	if (txqi->schedule_round == local->schedule_round[ac])
 		goto out;
 
-	/* If the station has been inactive for a while, catch up its v_t so it
-	 * doesn't get indefinite priority; see comment above the definition of
-	 * AIRTIME_MAX_BEHIND.
-	 */
-	if ((!was_active && air_info->v_t < air_sched->v_t) ||
-	    air_info->v_t < air_sched->v_t - AIRTIME_MAX_BEHIND)
-		air_info->v_t = air_sched->v_t;
-
-	ieee80211_update_airtime_weight(local, air_sched, now, !was_active);
-	__ieee80211_insert_txq(&air_sched->active_txqs, txqi);
+	list_del_init(&txqi->schedule_order);
+	txqi->schedule_round = local->schedule_round[ac];
+	ret = &txqi->txq;
 
 out:
-	spin_unlock_bh(&air_sched->lock);
-}
-EXPORT_SYMBOL(ieee80211_schedule_txq);
-
-static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
-				       struct ieee80211_txq *txq,
-				       bool purge)
-{
-	struct ieee80211_local *local = hw_to_local(hw);
-	struct txq_info *txqi = to_txq_info(txq);
-	struct airtime_sched_info *air_sched;
-	struct airtime_info *air_info;
-
-	air_sched = &local->airtime[txq->ac];
-	air_info = to_airtime_info(&txqi->txq);
-
-	lockdep_assert_held(&air_sched->lock);
-
-	if (purge) {
-		list_del_init(&air_info->list);
-		ieee80211_update_airtime_weight(local, air_sched, 0, true);
-	}
-
-	if (RB_EMPTY_NODE(&txqi->schedule_order))
-		return;
-
-	if (air_sched->schedule_pos == &txqi->schedule_order)
-		air_sched->schedule_pos = rb_prev(&txqi->schedule_order);
-
-	if (!purge)
-		airtime_set_active(air_sched, air_info,
-				   ktime_get_coarse_boottime_ns());
-
-	rb_erase_cached(&txqi->schedule_order,
-			&air_sched->active_txqs);
-	RB_CLEAR_NODE(&txqi->schedule_order);
+	spin_unlock_bh(&local->active_txq_lock[ac]);
+	return ret;
 }
+EXPORT_SYMBOL(ieee80211_next_txq);
 
-void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
+void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 			      struct ieee80211_txq *txq,
-			      bool purge)
-	__acquires(txq_lock) __releases(txq_lock)
-{
-	struct ieee80211_local *local = hw_to_local(hw);
-
-	spin_lock_bh(&local->airtime[txq->ac].lock);
-	__ieee80211_unschedule_txq(hw, txq, purge);
-	spin_unlock_bh(&local->airtime[txq->ac].lock);
-}
-
-void ieee80211_return_txq(struct ieee80211_hw *hw,
-			  struct ieee80211_txq *txq, bool force)
+			      bool force)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = to_txq_info(txq);
 
-	spin_lock_bh(&local->airtime[txq->ac].lock);
-
-	if (!RB_EMPTY_NODE(&txqi->schedule_order) && !force &&
-	    !txq_has_queue(txq))
-		__ieee80211_unschedule_txq(hw, txq, false);
+	spin_lock_bh(&local->active_txq_lock[txq->ac]);
+
+	if (list_empty(&txqi->schedule_order) &&
+	    (force || !skb_queue_empty(&txqi->frags) ||
+	     txqi->tin.backlog_packets)) {
+		/* If airtime accounting is active, always enqueue STAs at the
+		 * head of the list to ensure that they only get moved to the
+		 * back by the airtime DRR scheduler once they have a negative
+		 * deficit. A station that already has a negative deficit will
+		 * get immediately moved to the back of the list on the next
+		 * call to ieee80211_next_txq().
+		 */
+		if (txqi->txq.sta && local->airtime_flags &&
+		    wiphy_ext_feature_isset(local->hw.wiphy,
+					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
+			list_add(&txqi->schedule_order,
+				 &local->active_txqs[txq->ac]);
+		else
+			list_add_tail(&txqi->schedule_order,
+				      &local->active_txqs[txq->ac]);
+	}
 
-	spin_unlock_bh(&local->airtime[txq->ac].lock);
+	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
 }
-EXPORT_SYMBOL(ieee80211_return_txq);
+EXPORT_SYMBOL(__ieee80211_schedule_txq);
 
 DEFINE_STATIC_KEY_FALSE(aql_disable);
 
 bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 				 struct ieee80211_txq *txq)
 {
-	struct airtime_info *air_info = to_airtime_info(txq);
+	struct sta_info *sta;
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
@@ -4069,12 +3913,15 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
 		return true;
 
-	if (atomic_read(&air_info->aql_tx_pending) < air_info->aql_limit_low)
+	sta = container_of(txq->sta, struct sta_info, sta);
+	if (atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
+	    sta->airtime[txq->ac].aql_limit_low)
 		return true;
 
 	if (atomic_read(&local->aql_total_pending_airtime) <
 	    local->aql_threshold &&
-	    atomic_read(&air_info->aql_tx_pending) < air_info->aql_limit_high)
+	    atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
+	    sta->airtime[txq->ac].aql_limit_high)
 		return true;
 
 	return false;
@@ -4084,59 +3931,60 @@ EXPORT_SYMBOL(ieee80211_txq_airtime_check);
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
-	struct txq_info *first_txqi = NULL, *txqi = to_txq_info(txq);
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct airtime_sched_info *air_sched;
-	struct airtime_info *air_info;
-	struct rb_node *node = NULL;
-	bool ret = false;
-	u64 now;
-
-
-	if (!ieee80211_txq_airtime_check(hw, txq))
-		return false;
+	struct txq_info *iter, *tmp, *txqi = to_txq_info(txq);
+	struct sta_info *sta;
+	u8 ac = txq->ac;
 
-	air_sched = &local->airtime[txq->ac];
-	spin_lock_bh(&air_sched->lock);
+	spin_lock_bh(&local->active_txq_lock[ac]);
 
-	if (RB_EMPTY_NODE(&txqi->schedule_order))
+	if (!txqi->txq.sta)
 		goto out;
 
-	now = ktime_get_coarse_boottime_ns();
+	if (list_empty(&txqi->schedule_order))
+		goto out;
 
-	/* Like in ieee80211_next_txq(), make sure the first station in the
-	 * scheduling order is eligible for transmission to avoid starvation.
-	 */
-	node = rb_first_cached(&air_sched->active_txqs);
-	if (node) {
-		first_txqi = container_of(node, struct txq_info,
-					  schedule_order);
-		air_info = to_airtime_info(&first_txqi->txq);
+	list_for_each_entry_safe(iter, tmp, &local->active_txqs[ac],
+				 schedule_order) {
+		if (iter == txqi)
+			break;
 
-		if (air_sched->v_t < air_info->v_t)
-			airtime_catchup_v_t(air_sched, air_info->v_t, now);
+		if (!iter->txq.sta) {
+			list_move_tail(&iter->schedule_order,
+				       &local->active_txqs[ac]);
+			continue;
+		}
+		sta = container_of(iter->txq.sta, struct sta_info, sta);
+		if (sta->airtime[ac].deficit < 0)
+			sta->airtime[ac].deficit += sta->airtime_weight;
+		list_move_tail(&iter->schedule_order, &local->active_txqs[ac]);
 	}
 
-	air_info = to_airtime_info(&txqi->txq);
-	if (air_info->v_t <= air_sched->v_t) {
-		air_sched->last_schedule_activity = now;
-		ret = true;
-	}
+	sta = container_of(txqi->txq.sta, struct sta_info, sta);
+	if (sta->airtime[ac].deficit >= 0)
+		goto out;
+
+	sta->airtime[ac].deficit += sta->airtime_weight;
+	list_move_tail(&txqi->schedule_order, &local->active_txqs[ac]);
+	spin_unlock_bh(&local->active_txq_lock[ac]);
 
+	return false;
 out:
-	spin_unlock_bh(&air_sched->lock);
-	return ret;
+	if (!list_empty(&txqi->schedule_order))
+		list_del_init(&txqi->schedule_order);
+	spin_unlock_bh(&local->active_txq_lock[ac]);
+
+	return true;
 }
 EXPORT_SYMBOL(ieee80211_txq_may_transmit);
 
 void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct airtime_sched_info *air_sched = &local->airtime[ac];
 
-	spin_lock_bh(&air_sched->lock);
-	air_sched->schedule_pos = NULL;
-	spin_unlock_bh(&air_sched->lock);
+	spin_lock_bh(&local->active_txq_lock[ac]);
+	local->schedule_round[ac]++;
+	spin_unlock_bh(&local->active_txq_lock[ac]);
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
-- 
2.36.1

