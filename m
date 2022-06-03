Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD85653CD65
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiFCQnN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 12:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344027AbiFCQnM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 12:43:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E568944A36
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BRKi6M+9QAraltOG8/O8HnUEPIgRZBuL/TDWX2ky/QA=; b=ejDoZKFcl5kvv1R+drndkSnz8L
        aAT+oym7tblYYnEellE4h7kwxqhX2LIJ6wmGBgMpDSdN6rK1ddXsx5WC5eqzmRTilZgnqddL6lyMV
        OFd8afTZ7e5LdmzCcAoWCfLsIcifH2XFCF4owpdxQ2WrrpnwEeAz8fcf84J7+mTTupXE=;
Received: from p200300daa70ef200855b9684f56ef019.dip0.t-ipconnect.de ([2003:da:a70e:f200:855b:9684:f56e:f019] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nxAOB-0001lB-Vt; Fri, 03 Jun 2022 18:43:08 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 2/2] mac80211: rework the airtime fairness implementation
Date:   Fri,  3 Jun 2022 18:43:07 +0200
Message-Id: <20220603164307.92189-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603164307.92189-1-nbd@nbd.name>
References: <20220603164307.92189-1-nbd@nbd.name>
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

The current ATF implementation has a number of issues which have shown up
during testing. Since it does not take into account the AQL budget of
pending packets, the implementation might queue up large amounts of packets
for a single txq until airtime gets reported after tx completion.
The same then happens to the next txq afterwards. While the end result could
still be considered fair, the bursty behavior introduces a large amount of
latency.
The current code also tries to avoid frequent re-sorting of txq entries in
order to avoid having to re-balance the rbtree often.

In order to fix these issues, introduce skip lists as a data structure, which
offer similar lookup/insert/delete times as rbtree, but avoids the need for
rebalacing by being probabilistic.
Use this to keep tx entries sorted by virtual time + pending AQL budget and
re-sort after each ieee80211_return_txq call.

Since multiple txqs share a single air_time struct with a virtual time value,
switch the active_txqs list to queue up air_time structs instead of queues.
This helps avoid imbalance between shared txqs by servicing them round robin.

ieee80211_next_txq now only dequeues the first element of active_txqs. To
make that work for non-AQL or non-ATF drivers as well, add estimated tx
airtime directly to air_info virtual time if either AQL or ATF is not
supported.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/linux/skiplist.h   | 250 +++++++++++++++++++++++++++++++++++++
 net/mac80211/cfg.c         |   5 -
 net/mac80211/ieee80211_i.h |  27 +++-
 net/mac80211/main.c        |   2 +-
 net/mac80211/sta_info.c    |   3 +-
 net/mac80211/sta_info.h    |   6 +-
 net/mac80211/tx.c          | 244 +++++++++++++++++-------------------
 7 files changed, 396 insertions(+), 141 deletions(-)
 create mode 100644 include/linux/skiplist.h

diff --git a/include/linux/skiplist.h b/include/linux/skiplist.h
new file mode 100644
index 000000000000..2312ed87cfe9
--- /dev/null
+++ b/include/linux/skiplist.h
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * A skip list is a probabilistic alternative to balanced trees. Unlike the
+ * red-black tree, it does not require rebalancing.
+ *
+ * This implementation uses only unidirectional next pointers and is optimized
+ * for use in a priority queue where elements are mostly deleted from the front
+ * of the queue.
+ *
+ * When storing up to 2^n elements in a n-level skiplist. lookup and deletion
+ * for the first element happens in O(1) time, other than that, insertion and
+ * deletion takes O(log n) time, assuming that the number of elements for an
+ * n-level list does not exceed 2^n.
+ *
+ * Usage:
+ * DECLARE_SKIPLIST_TYPE(foo, 5) will define the data types for a 5-level list:
+ * struct foo_list: the list data type
+ * struct foo_node: the node data for an element in the list
+ *
+ * DECLARE_SKIPLIST_IMPL(foo, foo_cmp_fn)
+ *
+ * Adds the skip list implementation. It depends on a provided function:
+ * int foo_cmp_fn(struct foo_list *list, struct foo_node *n1, struct foo_node *n2)
+ * This compares two elements given by their node pointers, returning values <0
+ * if n1 is less than n2, =0 and >0 for equal or bigger than respectively.
+ *
+ * This macro implements the following functions:
+ *
+ * void foo_list_init(struct foo_list *list)
+ *	initializes the skip list
+ *
+ * void foo_node_init(struct foo_node *node)
+ *	initializes a node. must be called before adding the node to the list
+ *
+ * struct foo_node *foo_node_next(struct foo_node *node)
+ *	gets the node directly after the provided node, or NULL if it was the last
+ *	element in the list.
+ *
+ * bool foo_is_queued(struct foo_node *node)
+ *	returns true if the node is on a list
+ *
+ * struct foo_node *foo_dequeue(struct foo_list *list)
+ *	deletes and returns the first element of the list (or returns NULL if empty)
+ *
+ * struct foo_node *foo_peek(struct foo_list *list)
+ *	returns the first element of the list
+ *
+ * void foo_insert(struct foo_list *list, struct foo_node *node)
+ *	inserts the node into the list. the node must be initialized and not on a
+ *	list already.
+ *
+ * void foo_delete(struct foo_list *list, struct foo_node *node)
+ *	deletes the node from the list, or does nothing if it's not on the list
+ */
+#ifndef __SKIPLIST_H
+#define __SKIPLIST_H
+
+#include <linux/bits.h>
+#include <linux/minmax.h>
+#include <linux/bug.h>
+#include <linux/prandom.h>
+
+#define SKIPLIST_POISON ((void *)1)
+
+#define DECLARE_SKIPLIST_TYPE(name, levels)				\
+struct name##_node {							\
+	struct name##_node *next[levels];				\
+};									\
+struct name##_list {							\
+	struct name##_node head;					\
+	unsigned int max_level;						\
+	unsigned int count;						\
+};
+
+#define DECLARE_SKIPLIST_IMPL(name, cmp_fn)				\
+static inline void							\
+name##_list_init(struct name##_list *list)				\
+{									\
+	memset(list, 0, sizeof(*list));					\
+}									\
+static inline void							\
+name##_node_init(struct name##_node *node)				\
+{									\
+	node->next[0] = SKIPLIST_POISON;				\
+}									\
+static inline struct name##_node *					\
+name##_node_next(struct name##_node *node)				\
+{									\
+	return node->next[0];						\
+}									\
+static inline bool							\
+name##_is_queued(struct name##_node *node)				\
+{									\
+	return node->next[0] != SKIPLIST_POISON;			\
+}									\
+static inline int							\
+__skiplist_##name##_cmp_impl(void *head, void *n1, void *n2)		\
+{									\
+	return cmp_fn(head, n1, n2);					\
+}									\
+static inline void							\
+__##name##_delete(struct name##_list *list)				\
+{									\
+	list->count--;							\
+	while (list->max_level &&					\
+	       !list->head.next[list->max_level])			\
+		list->max_level--;					\
+}									\
+static inline struct name##_node *					\
+name##_dequeue(struct name##_list *list)				\
+{									\
+	struct name##_node *ret;					\
+	unsigned int max_level = ARRAY_SIZE(list->head.next) - 1;	\
+	ret = (void *)__skiplist_dequeue((void **)&list->head,		\
+					 max_level);			\
+	if (!ret)							\
+		return NULL;						\
+	__##name##_delete(list);					\
+	return ret;							\
+}									\
+static inline struct name##_node *					\
+name##_peek(struct name##_list *list)					\
+{									\
+	return list->head.next[0];					\
+}									\
+static inline void							\
+name##_insert(struct name##_list *list, struct name##_node *node)	\
+{									\
+	int level = __skiplist_level(ARRAY_SIZE(list->head.next) - 1,	\
+				     list->count, prandom_u32());	\
+	level = min_t(int, level, list->max_level + 1);			\
+	__skiplist_insert((void *)&list->head, (void *)node, level,	\
+			  __skiplist_##name##_cmp_impl);		\
+	if (level > list->max_level)					\
+		list->max_level = level;				\
+	list->count++;							\
+}									\
+static inline void							\
+name##_delete(struct name##_list *list, struct name##_node *node)	\
+{									\
+	if (node->next[0] == SKIPLIST_POISON)				\
+	    return;							\
+	__skiplist_delete((void *)&list->head, (void *)node,		\
+			  ARRAY_SIZE(list->head.next) - 1,		\
+			  __skiplist_##name##_cmp_impl);		\
+	__##name##_delete(list);					\
+}
+
+
+typedef int (*__skiplist_cmp_t)(void *head, void *n1, void *n2);
+
+#define __skiplist_cmp(cmp, head, cur, node)				\
+	({								\
+		int cmp_val = cmp(head, cur, node);			\
+		if (!cmp_val)						\
+			cmp_val = (unsigned long)(cur) -		\
+				  (unsigned long)(node);		\
+		cmp_val;						\
+	})
+
+static inline void *
+__skiplist_dequeue(void **list, int max_level)
+{
+	void **node = list[0];
+	unsigned int i;
+
+	if (!node)
+		return NULL;
+
+	list[0] = node[0];
+	for (i = 1; i <= max_level; i++) {
+		if (list[i] != node)
+			break;
+
+		list[i] = node[i];
+	}
+	node[0] = SKIPLIST_POISON;
+
+	return node;
+}
+
+static inline void
+__skiplist_insert(void **list, void **node, int level, __skiplist_cmp_t cmp)
+{
+	void **head = list;
+
+	if (WARN(node[0] != SKIPLIST_POISON, "Insert on already inserted or uninitialized node"))
+	    return;
+	for (; level >= 0; level--) {
+		while (list[level] &&
+		       __skiplist_cmp(cmp, head, list[level], node) < 0)
+			list = list[level];
+
+		node[level] = list[level];
+		list[level] = node;
+	}
+}
+
+
+static inline void
+__skiplist_delete(void **list, void **node, int max_level, __skiplist_cmp_t cmp)
+{
+	void *head = list;
+	int i;
+
+	for (i = max_level; i >= 0; i--) {
+		while (list[i] && list[i] != node &&
+		       __skiplist_cmp(cmp, head, list[i], node) <= 0)
+			list = list[i];
+
+		if (list[i] != node)
+			continue;
+
+		list[i] = node[i];
+	}
+	node[0] = SKIPLIST_POISON;
+}
+
+static inline unsigned int
+__skiplist_level(unsigned int max_level, unsigned int count, unsigned int seed)
+{
+	unsigned int level = 0;
+
+	if (max_level >= 16 && !(seed & GENMASK(15, 0))) {
+		level += 16;
+		seed >>= 16;
+	}
+
+	if (max_level >= 8 && !(seed & GENMASK(7, 0))) {
+		level += 8;
+		seed >>= 8;
+	}
+
+	if (max_level >= 4 && !(seed & GENMASK(3, 0))) {
+		level += 4;
+		seed >>= 4;
+	}
+
+	if (!(seed & GENMASK(1, 0))) {
+		level += 2;
+		seed >>= 2;
+	}
+
+	if (!(seed & BIT(0)))
+		level++;
+
+	return min(level, max_level);
+}
+
+#endif
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7896f257e1b..90968636ddfb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1580,7 +1580,6 @@ static void sta_apply_airtime_params(struct ieee80211_local *local,
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		struct airtime_sched_info *air_sched = &local->airtime[ac];
 		struct airtime_info *air_info = &sta->airtime[ac];
-		struct txq_info *txqi;
 		u8 tid;
 
 		spin_lock_bh(&air_sched->lock);
@@ -1592,10 +1591,6 @@ static void sta_apply_airtime_params(struct ieee80211_local *local,
 
 			airtime_weight_set(air_info, params->airtime_weight);
 
-			txqi = to_txq_info(sta->sta.txq[tid]);
-			if (RB_EMPTY_NODE(&txqi->schedule_order))
-				continue;
-
 			ieee80211_update_airtime_weight(local, air_sched,
 							0, true);
 		}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5ca4c2c6aa3c..1a6f9d119bdc 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -25,7 +25,8 @@
 #include <linux/leds.h>
 #include <linux/idr.h>
 #include <linux/rhashtable.h>
-#include <linux/rbtree.h>
+#include <linux/prandom.h>
+#include <linux/skiplist.h>
 #include <net/ieee80211_radiotap.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
@@ -855,6 +856,7 @@ enum txq_info_flags {
 	IEEE80211_TXQ_AMPDU,
 	IEEE80211_TXQ_NO_AMSDU,
 	IEEE80211_TXQ_STOP_NETIF_TX,
+	IEEE80211_TXQ_FORCE_ACTIVE,
 };
 
 /**
@@ -871,7 +873,6 @@ struct txq_info {
 	struct fq_tin tin;
 	struct codel_vars def_cvars;
 	struct codel_stats cstats;
-	struct rb_node schedule_order;
 
 	struct sk_buff_head frags;
 	unsigned long flags;
@@ -1191,8 +1192,7 @@ enum mac80211_scan_state {
  *
  * @lock: spinlock that protects all the fields in this struct
  * @active_txqs: rbtree of currently backlogged queues, sorted by virtual time
- * @schedule_pos: the current position maintained while a driver walks the tree
- *                with ieee80211_next_txq()
+ * @schedule_pos: last used airtime_info node while a driver walks the tree
  * @active_list: list of struct airtime_info structs that were active within
  *               the last AIRTIME_ACTIVE_DURATION (100 ms), used to compute
  *               weight_sum
@@ -1213,8 +1213,8 @@ enum mac80211_scan_state {
  */
 struct airtime_sched_info {
 	spinlock_t lock;
-	struct rb_root_cached active_txqs;
-	struct rb_node *schedule_pos;
+	struct airtime_sched_list active_txqs;
+	struct airtime_sched_node *schedule_pos;
 	struct list_head active_list;
 	u64 last_weight_update;
 	u64 last_schedule_activity;
@@ -1674,6 +1674,20 @@ static inline struct airtime_info *to_airtime_info(struct ieee80211_txq *txq)
 	return &sdata->airtime[txq->ac];
 }
 
+static inline int
+airtime_sched_cmp(struct airtime_sched_list *list,
+		  struct airtime_sched_node *n1, struct airtime_sched_node *n2)
+{
+	struct airtime_info *a1, *a2;
+
+	a1 = container_of(n1, struct airtime_info, schedule_order);
+	a2 = container_of(n2, struct airtime_info, schedule_order);
+
+	return a1->v_t_cur - a2->v_t_cur;
+}
+
+DECLARE_SKIPLIST_IMPL(airtime_sched, airtime_sched_cmp);
+
 /* To avoid divisions in the fast path, we keep pre-computed reciprocals for
  * airtime weight calculations. There are two different weights to keep track
  * of: The per-station weight and the sum of weights per phy.
@@ -1761,6 +1775,7 @@ static inline void init_airtime_info(struct airtime_info *air_info,
 	air_info->aql_limit_high = air_sched->aql_txq_limit_high;
 	airtime_weight_set(air_info, IEEE80211_DEFAULT_AIRTIME_WEIGHT);
 	INIT_LIST_HEAD(&air_info->list);
+	airtime_sched_node_init(&air_info->schedule_order);
 }
 
 static inline int ieee80211_bssid_match(const u8 *raddr, const u8 *addr)
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 5a385d4146b9..7d855167cafb 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -709,7 +709,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		struct airtime_sched_info *air_sched = &local->airtime[i];
 
-		air_sched->active_txqs = RB_ROOT_CACHED;
+		airtime_sched_list_init(&air_sched->active_txqs);
 		INIT_LIST_HEAD(&air_sched->active_list);
 		spin_lock_init(&air_sched->lock);
 		air_sched->aql_txq_limit_low = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 2f1cf9d4e68d..9481a6ab1405 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1914,8 +1914,7 @@ void ieee80211_register_airtime(struct ieee80211_txq *txq,
 	air_sched = &local->airtime[txq->ac];
 	air_info = to_airtime_info(txq);
 
-	if (local->airtime_flags & AIRTIME_USE_TX)
-		airtime += tx_airtime;
+	airtime += tx_airtime;
 	if (local->airtime_flags & AIRTIME_USE_RX)
 		airtime += rx_airtime;
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 35c390bedfba..9b8774e889f5 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -135,11 +135,14 @@ enum ieee80211_agg_stop_reason {
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
 
+DECLARE_SKIPLIST_TYPE(airtime_sched, 5);
 
 struct airtime_info {
+	struct airtime_sched_node schedule_order;
+	struct ieee80211_txq *txq[3];
 	u64 rx_airtime;
 	u64 tx_airtime;
-	u64 v_t;
+	u64 v_t, v_t_cur;
 	u64 last_scheduled;
 	struct list_head list;
 	atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
@@ -147,6 +150,7 @@ struct airtime_info {
 	u32 aql_limit_high;
 	u32 weight_reciprocal;
 	u16 weight;
+	u8 txq_idx;
 };
 
 void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0e4efc08c762..3a81829d2a7a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -19,6 +19,7 @@
 #include <linux/rcupdate.h>
 #include <linux/export.h>
 #include <linux/timekeeping.h>
+#include <linux/prandom.h>
 #include <net/net_namespace.h>
 #include <net/ieee80211_radiotap.h>
 #include <net/cfg80211.h>
@@ -1477,11 +1478,12 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 			struct sta_info *sta,
 			struct txq_info *txqi, int tid)
 {
+	struct airtime_info *air_info;
+
 	fq_tin_init(&txqi->tin);
 	codel_vars_init(&txqi->def_cvars);
 	codel_stats_init(&txqi->cstats);
 	__skb_queue_head_init(&txqi->frags);
-	RB_CLEAR_NODE(&txqi->schedule_order);
 
 	txqi->txq.vif = &sdata->vif;
 
@@ -1490,7 +1492,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 		txqi->txq.tid = 0;
 		txqi->txq.ac = IEEE80211_AC_BE;
 
-		return;
+		goto out;
 	}
 
 	if (tid == IEEE80211_NUM_TIDS) {
@@ -1512,6 +1514,12 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	txqi->txq.sta = &sta->sta;
 	txqi->txq.tid = tid;
 	sta->sta.txq[tid] = &txqi->txq;
+
+out:
+	air_info = to_airtime_info(&txqi->txq);
+	air_info->txq[air_info->txq_idx++] = &txqi->txq;
+	if (air_info->txq_idx == ARRAY_SIZE(air_info->txq))
+		air_info->txq_idx--;
 }
 
 void ieee80211_txq_purge(struct ieee80211_local *local,
@@ -3632,6 +3640,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	struct ieee80211_tx_data tx;
 	ieee80211_tx_result r;
 	struct ieee80211_vif *vif = txq->vif;
+	u32 airtime;
+	bool ampdu;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -3790,21 +3800,26 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 encap_out:
 	IEEE80211_SKB_CB(skb)->control.vif = vif;
 
-	if (vif &&
-	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
-		bool ampdu = txq->ac != IEEE80211_AC_VO;
-		u32 airtime;
-
-		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
-							     skb->len, ampdu);
-		if (airtime) {
-			airtime = ieee80211_info_set_tx_time_est(info, airtime);
-			ieee80211_sta_update_pending_airtime(local, tx.sta,
-							     txq->ac,
-							     airtime,
-							     false);
-		}
-	}
+	if (!vif)
+		return skb;
+
+	ampdu = txq->ac != IEEE80211_AC_VO;
+	airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
+						     skb->len, ampdu);
+	if (!airtime)
+		return skb;
+
+	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL) ||
+	    !wiphy_ext_feature_isset(local->hw.wiphy,
+				     NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
+		ieee80211_register_airtime(txq, airtime, 0);
+
+	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
+		return skb;
+
+	airtime = ieee80211_info_set_tx_time_est(info, airtime);
+	ieee80211_sta_update_pending_airtime(local, tx.sta, txq->ac,
+					     airtime, false);
 
 	return skb;
 
@@ -3815,85 +3830,95 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_dequeue);
 
+static void
+airtime_info_next_txq_idx(struct airtime_info *air_info)
+{
+	air_info->txq_idx++;
+	if (air_info->txq_idx >= ARRAY_SIZE(air_info->txq) ||
+	    !air_info->txq[air_info->txq_idx])
+		air_info->txq_idx = 0;
+}
+
 struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct airtime_sched_info *air_sched;
 	u64 now = ktime_get_coarse_boottime_ns();
-	struct ieee80211_txq *ret = NULL;
+	struct airtime_sched_node *node = NULL;
+	struct ieee80211_txq *txq;
 	struct airtime_info *air_info;
 	struct txq_info *txqi = NULL;
-	struct rb_node *node;
-	bool first = false;
+	u8 txq_idx;
 
 	air_sched = &local->airtime[ac];
 	spin_lock_bh(&air_sched->lock);
 
-	node = air_sched->schedule_pos;
-
 begin:
-	if (!node) {
-		node = rb_first_cached(&air_sched->active_txqs);
-		first = true;
-	} else {
-		node = rb_next(node);
-	}
+	txq = NULL;
+	if (airtime_sched_peek(&air_sched->active_txqs) ==
+	    air_sched->schedule_pos)
+		goto out;
 
+	node = airtime_sched_dequeue(&air_sched->active_txqs);
 	if (!node)
 		goto out;
 
-	txqi = container_of(node, struct txq_info, schedule_order);
-	air_info = to_airtime_info(&txqi->txq);
+	air_info = container_of(node, struct airtime_info, schedule_order);
 
-	if (air_info->v_t > air_sched->v_t &&
-	    (!first || !airtime_catchup_v_t(air_sched, air_info->v_t, now)))
-		goto out;
-
-	if (!ieee80211_txq_airtime_check(hw, &txqi->txq)) {
-		first = false;
+	airtime_info_next_txq_idx(air_info);
+	txq_idx = air_info->txq_idx;
+	txq = air_info->txq[txq_idx];
+	if (!txq || !ieee80211_txq_airtime_check(hw, txq))
 		goto begin;
+
+	while (1) {
+		txqi = to_txq_info(txq);
+		if (test_and_clear_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags))
+			break;
+
+		if (txq_has_queue(txq))
+			break;
+
+		airtime_info_next_txq_idx(air_info);
+		txq = air_info->txq[air_info->txq_idx];
+		if (txq_idx == air_info->txq_idx)
+			goto begin;
+	}
+
+	if (air_info->v_t_cur > air_sched->v_t) {
+		if (node == airtime_sched_peek(&air_sched->active_txqs))
+			airtime_catchup_v_t(air_sched, air_info->v_t_cur, now);
 	}
 
 	air_sched->schedule_pos = node;
 	air_sched->last_schedule_activity = now;
-	ret = &txqi->txq;
 out:
 	spin_unlock_bh(&air_sched->lock);
-	return ret;
+	return txq;
 }
 EXPORT_SYMBOL(ieee80211_next_txq);
 
-static void __ieee80211_insert_txq(struct rb_root_cached *root,
+static void __ieee80211_insert_txq(struct ieee80211_local *local,
+				   struct airtime_sched_info *air_sched,
 				   struct txq_info *txqi)
 {
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
+	struct airtime_info *air_info = to_airtime_info(&txqi->txq);
+	u32 aql_time = 0;
+
+	if (wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
+	    aql_time = atomic_read(&air_info->aql_tx_pending);
+	    aql_time *= air_info->weight_reciprocal;
+	    aql_time >>= IEEE80211_RECIPROCAL_SHIFT_STA - IEEE80211_WEIGHT_SHIFT;
 	}
 
-	rb_link_node(&txqi->schedule_order, parent, new);
-	rb_insert_color_cached(&txqi->schedule_order, root, leftmost);
+	airtime_sched_delete(&air_sched->active_txqs, &air_info->schedule_order);
+	air_info->v_t_cur = air_info->v_t + aql_time;
+	airtime_sched_insert(&air_sched->active_txqs, &air_info->schedule_order);
 }
 
 void ieee80211_resort_txq(struct ieee80211_hw *hw,
 			  struct ieee80211_txq *txq)
 {
-	struct airtime_info *air_info = to_airtime_info(txq);
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = to_txq_info(txq);
 	struct airtime_sched_info *air_sched;
@@ -3901,41 +3926,7 @@ void ieee80211_resort_txq(struct ieee80211_hw *hw,
 	air_sched = &local->airtime[txq->ac];
 
 	lockdep_assert_held(&air_sched->lock);
-
-	if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
-		struct airtime_info *a_prev = NULL, *a_next = NULL;
-		struct txq_info *t_prev, *t_next;
-		struct rb_node *n_prev, *n_next;
-
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
-
-		if ((n_next = rb_next(&txqi->schedule_order)) != NULL) {
-			t_next = container_of(n_next, struct txq_info,
-					      schedule_order);
-			a_next = to_airtime_info(&t_next->txq);
-		}
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
-	}
+	__ieee80211_insert_txq(local, air_sched, txqi);
 }
 
 void ieee80211_update_airtime_weight(struct ieee80211_local *local,
@@ -3984,7 +3975,7 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw,
 	was_active = airtime_is_active(air_info, now);
 	airtime_set_active(air_sched, air_info, now);
 
-	if (!RB_EMPTY_NODE(&txqi->schedule_order))
+	if (airtime_sched_is_queued(&air_info->schedule_order))
 		goto out;
 
 	/* If the station has been inactive for a while, catch up its v_t so it
@@ -3996,7 +3987,7 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw,
 		air_info->v_t = air_sched->v_t;
 
 	ieee80211_update_airtime_weight(local, air_sched, now, !was_active);
-	__ieee80211_insert_txq(&air_sched->active_txqs, txqi);
+	__ieee80211_insert_txq(local, air_sched, txqi);
 
 out:
 	spin_unlock_bh(&air_sched->lock);
@@ -4022,19 +4013,10 @@ static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
 		ieee80211_update_airtime_weight(local, air_sched, 0, true);
 	}
 
-	if (RB_EMPTY_NODE(&txqi->schedule_order))
-		return;
-
-	if (air_sched->schedule_pos == &txqi->schedule_order)
-		air_sched->schedule_pos = rb_prev(&txqi->schedule_order);
-
+	airtime_sched_delete(&air_sched->active_txqs, &air_info->schedule_order);
 	if (!purge)
 		airtime_set_active(air_sched, air_info,
 				   ktime_get_coarse_boottime_ns());
-
-	rb_erase_cached(&txqi->schedule_order,
-			&air_sched->active_txqs);
-	RB_CLEAR_NODE(&txqi->schedule_order);
 }
 
 void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
@@ -4054,14 +4036,24 @@ void ieee80211_return_txq(struct ieee80211_hw *hw,
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = to_txq_info(txq);
+	struct airtime_sched_info *air_sched;
+	struct airtime_info *air_info;
 
-	spin_lock_bh(&local->airtime[txq->ac].lock);
+	air_sched = &local->airtime[txq->ac];
+	air_info = to_airtime_info(&txqi->txq);
 
-	if (!RB_EMPTY_NODE(&txqi->schedule_order) && !force &&
-	    !txq_has_queue(txq))
-		__ieee80211_unschedule_txq(hw, txq, false);
+	if (force)
+		set_bit(IEEE80211_TXQ_FORCE_ACTIVE, &txqi->flags);
 
-	spin_unlock_bh(&local->airtime[txq->ac].lock);
+	spin_lock_bh(&air_sched->lock);
+	if (!ieee80211_txq_airtime_check(hw, &txqi->txq))
+	    airtime_sched_delete(&air_sched->active_txqs,
+				 &air_info->schedule_order);
+	else if (txq_has_queue(txq) || force)
+		__ieee80211_insert_txq(local, air_sched, txqi);
+	else
+		__ieee80211_unschedule_txq(hw, txq, false);
+	spin_unlock_bh(&air_sched->lock);
 }
 EXPORT_SYMBOL(ieee80211_return_txq);
 
@@ -4100,46 +4092,48 @@ EXPORT_SYMBOL(ieee80211_txq_airtime_check);
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
-	struct txq_info *first_txqi = NULL, *txqi = to_txq_info(txq);
+	struct txq_info *txqi = to_txq_info(txq);
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct airtime_sched_info *air_sched;
+	struct airtime_sched_node *node = NULL;
 	struct airtime_info *air_info;
-	struct rb_node *node = NULL;
 	bool ret = false;
+	u32 aql_slack;
 	u64 now;
 
-
 	if (!ieee80211_txq_airtime_check(hw, txq))
 		return false;
 
 	air_sched = &local->airtime[txq->ac];
 	spin_lock_bh(&air_sched->lock);
 
-	if (RB_EMPTY_NODE(&txqi->schedule_order))
-		goto out;
-
 	now = ktime_get_coarse_boottime_ns();
 
 	/* Like in ieee80211_next_txq(), make sure the first station in the
 	 * scheduling order is eligible for transmission to avoid starvation.
 	 */
-	node = rb_first_cached(&air_sched->active_txqs);
+	node = airtime_sched_peek(&air_sched->active_txqs);
 	if (node) {
-		first_txqi = container_of(node, struct txq_info,
-					  schedule_order);
-		air_info = to_airtime_info(&first_txqi->txq);
+		air_info = container_of(node, struct airtime_info,
+					schedule_order);
 
 		if (air_sched->v_t < air_info->v_t)
 			airtime_catchup_v_t(air_sched, air_info->v_t, now);
 	}
 
 	air_info = to_airtime_info(&txqi->txq);
-	if (air_info->v_t <= air_sched->v_t) {
+	aql_slack = air_info->aql_limit_low;
+	aql_slack *= air_info->weight_reciprocal;
+	aql_slack >>= IEEE80211_RECIPROCAL_SHIFT_STA - IEEE80211_WEIGHT_SHIFT;
+	/*
+	 * add extra slack of aql_limit_low in order to avoid queue
+	 * starvation when bypassing normal scheduling order
+	 */
+	if (air_info->v_t <= air_sched->v_t + aql_slack) {
 		air_sched->last_schedule_activity = now;
 		ret = true;
 	}
 
-out:
 	spin_unlock_bh(&air_sched->lock);
 	return ret;
 }
@@ -4150,9 +4144,7 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct airtime_sched_info *air_sched = &local->airtime[ac];
 
-	spin_lock_bh(&air_sched->lock);
 	air_sched->schedule_pos = NULL;
-	spin_unlock_bh(&air_sched->lock);
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
-- 
2.36.1

