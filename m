Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16092DC7E1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 21:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgLPUoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgLPUoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 15:44:02 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3EC06138C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wcjRepbM0xTx7i0fWN8RFxb9ih+nnKz5+/MEg3UZrM8=; b=bLtFKCkqQY3u1axRisAE3dOUt6
        8zx51IC3lj9G6q9w/vPe0xJXokgr7yE6H9jK+Hb7uxbzbSh7NJ9B5pSXlSpnJVShhjxTosFtR1n1C
        cuLHbzJtbITGsKH2Pu09o6X648nCwmikAlfefyknIqQE3sxlsDEJsJGWyz5OSAByVBpA=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpddm-0002eR-KC; Wed, 16 Dec 2020 21:43:18 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 4/7] net/fq_impl: do not maintain a backlog-sorted list of flows
Date:   Wed, 16 Dec 2020 21:43:13 +0100
Message-Id: <20201216204316.44498-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201216204316.44498-1-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A sorted flow list is only needed to drop packets in the biggest flow when
hitting the overmemory condition.
By scanning flows only when needed, we can avoid paying the cost of
maintaining the list under normal conditions
In order to avoid scanning lots of empty flows and touching too many cold
cache lines, a bitmap of flows with backlog is maintained

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/fq.h      |  10 ++--
 include/net/fq_impl.h | 127 +++++++++++++++++++++++++++---------------
 net/mac80211/tx.c     |   2 -
 3 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/include/net/fq.h b/include/net/fq.h
index 5df100b77099..4c6efb1e8952 100644
--- a/include/net/fq.h
+++ b/include/net/fq.h
@@ -19,8 +19,6 @@ struct fq_tin;
  * @flowchain: can be linked to fq_tin's new_flows or old_flows. Used for DRR++
  *	(deficit round robin) based round robin queuing similar to the one
  *	found in net/sched/sch_fq_codel.c
- * @backlogchain: can be linked to other fq_flow and fq. Used to keep track of
- *	fat flows and efficient head-dropping if packet limit is reached
  * @queue: sk_buff queue to hold packets
  * @backlog: number of bytes pending in the queue. The number of packets can be
  *	found in @queue.qlen
@@ -29,7 +27,6 @@ struct fq_tin;
 struct fq_flow {
 	struct fq_tin *tin;
 	struct list_head flowchain;
-	struct list_head backlogchain;
 	struct sk_buff_head queue;
 	u32 backlog;
 	int deficit;
@@ -47,6 +44,7 @@ struct fq_flow {
 struct fq_tin {
 	struct list_head new_flows;
 	struct list_head old_flows;
+	struct list_head tin_list;
 	struct fq_flow default_flow;
 	u32 backlog_bytes;
 	u32 backlog_packets;
@@ -60,14 +58,14 @@ struct fq_tin {
 /**
  * struct fq - main container for fair queuing purposes
  *
- * @backlogs: linked to fq_flows. Used to maintain fat flows for efficient
- *	head-dropping when @backlog reaches @limit
  * @limit: max number of packets that can be queued across all flows
  * @backlog: number of packets queued across all flows
  */
 struct fq {
 	struct fq_flow *flows;
-	struct list_head backlogs;
+	u32 *flows_bitmap;
+
+	struct list_head tin_backlog;
 	spinlock_t lock;
 	u32 flows_cnt;
 	u32 limit;
diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index dd374c7f0fe5..c3e053dce0f2 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -17,12 +17,24 @@ __fq_adjust_removal(struct fq *fq, struct fq_flow *flow, unsigned int packets,
 		    unsigned int bytes, unsigned int truesize)
 {
 	struct fq_tin *tin = flow->tin;
+	int idx;
 
 	tin->backlog_bytes -= bytes;
 	tin->backlog_packets -= packets;
 	flow->backlog -= bytes;
 	fq->backlog -= packets;
 	fq->memory_usage -= truesize;
+
+	if (flow->backlog)
+		return;
+
+	if (flow == &tin->default_flow) {
+		list_del_init(&tin->tin_list);
+		return;
+	}
+
+	idx = flow - fq->flows;
+	fq->flows_bitmap[idx / 32] &= ~BIT(idx % 32);
 }
 
 static void fq_adjust_removal(struct fq *fq,
@@ -32,24 +44,6 @@ static void fq_adjust_removal(struct fq *fq,
 	__fq_adjust_removal(fq, flow, 1, skb->len, skb->truesize);
 }
 
-static void fq_rejigger_backlog(struct fq *fq, struct fq_flow *flow)
-{
-	struct fq_flow *i;
-
-	if (flow->backlog == 0) {
-		list_del_init(&flow->backlogchain);
-	} else {
-		i = flow;
-
-		list_for_each_entry_continue(i, &fq->backlogs, backlogchain)
-			if (i->backlog < flow->backlog)
-				break;
-
-		list_move_tail(&flow->backlogchain,
-			       &i->backlogchain);
-	}
-}
-
 static struct sk_buff *fq_flow_dequeue(struct fq *fq,
 				       struct fq_flow *flow)
 {
@@ -62,7 +56,6 @@ static struct sk_buff *fq_flow_dequeue(struct fq *fq,
 		return NULL;
 
 	fq_adjust_removal(fq, flow, skb);
-	fq_rejigger_backlog(fq, flow);
 
 	return skb;
 }
@@ -90,7 +83,6 @@ static int fq_flow_drop(struct fq *fq, struct fq_flow *flow,
 	} while (packets < pending);
 
 	__fq_adjust_removal(fq, flow, packets, bytes, truesize);
-	fq_rejigger_backlog(fq, flow);
 
 	return packets;
 }
@@ -170,22 +162,50 @@ static struct fq_flow *fq_flow_classify(struct fq *fq,
 	return flow;
 }
 
-static void fq_recalc_backlog(struct fq *fq,
-			      struct fq_tin *tin,
-			      struct fq_flow *flow)
+static struct fq_flow *fq_find_fattest_flow(struct fq *fq)
 {
-	struct fq_flow *i;
+	struct fq_tin *tin;
+	struct fq_flow *flow = NULL;
+	u32 len = 0;
+	int base;
+
+	for (base = 0; base < fq->flows_cnt; base += 32) {
+		u32 mask = fq->flows_bitmap[base / 32];
+		unsigned int cur_len;
+		u8 i = 0;
+
+		while (mask) {
+			struct fq_flow *cur;
+			int first;
+
+			first = ffs(mask);
+			if (first < 32)
+				mask >>= first;
+			else
+				mask = 0;
+			i += first;
+
+			cur = &fq->flows[base + i - 1];
+			cur_len = cur->backlog;
+			if (cur_len <= len)
+				continue;
+
+			flow = cur;
+			len = cur_len;
+		}
+	}
 
-	if (list_empty(&flow->backlogchain))
-		list_add_tail(&flow->backlogchain, &fq->backlogs);
+	list_for_each_entry(tin, &fq->tin_backlog, tin_list) {
+		unsigned int cur_len = tin->default_flow.backlog;
 
-	i = flow;
-	list_for_each_entry_continue_reverse(i, &fq->backlogs,
-					     backlogchain)
-		if (i->backlog > flow->backlog)
-			break;
+		if (cur_len <= len)
+			continue;
 
-	list_move(&flow->backlogchain, &i->backlogchain);
+		flow = &tin->default_flow;
+		len = cur_len;
+	}
+
+	return flow;
 }
 
 static void fq_tin_enqueue(struct fq *fq,
@@ -200,6 +220,13 @@ static void fq_tin_enqueue(struct fq *fq,
 
 	flow = fq_flow_classify(fq, tin, idx, skb);
 
+	if (!flow->backlog) {
+		if (flow != &tin->default_flow)
+			fq->flows_bitmap[idx / 32] |= BIT(idx % 32);
+		else if (list_empty(&tin->tin_list))
+			list_add(&tin->tin_list, &fq->tin_backlog);
+	}
+
 	flow->tin = tin;
 	flow->backlog += skb->len;
 	tin->backlog_bytes += skb->len;
@@ -207,8 +234,6 @@ static void fq_tin_enqueue(struct fq *fq,
 	fq->memory_usage += skb->truesize;
 	fq->backlog++;
 
-	fq_recalc_backlog(fq, tin, flow);
-
 	if (list_empty(&flow->flowchain)) {
 		flow->deficit = fq->quantum;
 		list_add_tail(&flow->flowchain,
@@ -218,9 +243,7 @@ static void fq_tin_enqueue(struct fq *fq,
 	__skb_queue_tail(&flow->queue, skb);
 	oom = (fq->memory_usage > fq->memory_limit);
 	while (fq->backlog > fq->limit || oom) {
-		flow = list_first_entry_or_null(&fq->backlogs,
-						struct fq_flow,
-						backlogchain);
+		flow = fq_find_fattest_flow(fq);
 		if (!flow)
 			return;
 
@@ -255,8 +278,6 @@ static void fq_flow_filter(struct fq *fq,
 		fq_adjust_removal(fq, flow, skb);
 		free_func(fq, tin, flow, skb);
 	}
-
-	fq_rejigger_backlog(fq, flow);
 }
 
 static void fq_tin_filter(struct fq *fq,
@@ -279,16 +300,18 @@ static void fq_flow_reset(struct fq *fq,
 			  struct fq_flow *flow,
 			  fq_skb_free_t free_func)
 {
+	struct fq_tin *tin = flow->tin;
 	struct sk_buff *skb;
 
 	while ((skb = fq_flow_dequeue(fq, flow)))
-		free_func(fq, flow->tin, flow, skb);
+		free_func(fq, tin, flow, skb);
 
-	if (!list_empty(&flow->flowchain))
+	if (!list_empty(&flow->flowchain)) {
 		list_del_init(&flow->flowchain);
-
-	if (!list_empty(&flow->backlogchain))
-		list_del_init(&flow->backlogchain);
+		if (list_empty(&tin->new_flows) &&
+		    list_empty(&tin->old_flows))
+			list_del_init(&tin->tin_list);
+	}
 
 	flow->tin = NULL;
 
@@ -314,6 +337,7 @@ static void fq_tin_reset(struct fq *fq,
 		fq_flow_reset(fq, flow, free_func);
 	}
 
+	WARN_ON_ONCE(!list_empty(&tin->tin_list));
 	WARN_ON_ONCE(tin->backlog_bytes);
 	WARN_ON_ONCE(tin->backlog_packets);
 }
@@ -321,7 +345,6 @@ static void fq_tin_reset(struct fq *fq,
 static void fq_flow_init(struct fq_flow *flow)
 {
 	INIT_LIST_HEAD(&flow->flowchain);
-	INIT_LIST_HEAD(&flow->backlogchain);
 	__skb_queue_head_init(&flow->queue);
 }
 
@@ -329,6 +352,7 @@ static void fq_tin_init(struct fq_tin *tin)
 {
 	INIT_LIST_HEAD(&tin->new_flows);
 	INIT_LIST_HEAD(&tin->old_flows);
+	INIT_LIST_HEAD(&tin->tin_list);
 	fq_flow_init(&tin->default_flow);
 }
 
@@ -337,8 +361,8 @@ static int fq_init(struct fq *fq, int flows_cnt)
 	int i;
 
 	memset(fq, 0, sizeof(fq[0]));
-	INIT_LIST_HEAD(&fq->backlogs);
 	spin_lock_init(&fq->lock);
+	INIT_LIST_HEAD(&fq->tin_backlog);
 	fq->flows_cnt = max_t(u32, flows_cnt, 1);
 	fq->quantum = 300;
 	fq->limit = 8192;
@@ -348,6 +372,14 @@ static int fq_init(struct fq *fq, int flows_cnt)
 	if (!fq->flows)
 		return -ENOMEM;
 
+	fq->flows_bitmap = kcalloc(DIV_ROUND_UP(fq->flows_cnt, 32), sizeof(u32),
+				   GFP_KERNEL);
+	if (!fq->flows_bitmap) {
+		kvfree(fq->flows);
+		fq->flows = NULL;
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < fq->flows_cnt; i++)
 		fq_flow_init(&fq->flows[i]);
 
@@ -364,6 +396,9 @@ static void fq_reset(struct fq *fq,
 
 	kvfree(fq->flows);
 	fq->flows = NULL;
+
+	kfree(fq->flows_bitmap);
+	fq->flows_bitmap = NULL;
 }
 
 #endif
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 50b4e92fd766..cb3c2d6334b3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3337,8 +3337,6 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	if (head->len != orig_len) {
 		flow->backlog += head->len - orig_len;
 		tin->backlog_bytes += head->len - orig_len;
-
-		fq_recalc_backlog(fq, tin, flow);
 	}
 out:
 	spin_unlock_bh(&fq->lock);
-- 
2.28.0

