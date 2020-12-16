Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE92DC7DF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 21:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgLPUoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgLPUoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 15:44:02 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D73C0617A6
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nKrc8IrBNCiTyW6Q6NZhXDrSTi/z4rKj7AvocY20IMA=; b=bLfxnPUEyPziegXlGNb7ThtCRi
        WZILATXpcl7iXX98Ql09TUNBQLE+jvbigdYjs7P2Tu6JaaT0DPlNmNjs1MWUWaqpTHuFZ3+rSdLwb
        hwSGHQETRhJO8LQzrAyBd/HfbzAPkTCCdIj7FG4syVWkv6DQy5E0Kx8v6yMnDJBtGtdo=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpddm-0002eR-DA; Wed, 16 Dec 2020 21:43:18 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 3/7] net/fq_impl: drop get_default_func, move default flow to fq_tin
Date:   Wed, 16 Dec 2020 21:43:12 +0100
Message-Id: <20201216204316.44498-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201216204316.44498-1-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplifies the code and prepares for a rework of scanning for flows on
overmemory drop.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/fq.h           |  1 +
 include/net/fq_impl.h      | 11 +++++------
 net/mac80211/ieee80211_i.h |  1 -
 net/mac80211/tx.c          | 22 ++++------------------
 4 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/net/fq.h b/include/net/fq.h
index e39f3f8d5f8a..5df100b77099 100644
--- a/include/net/fq.h
+++ b/include/net/fq.h
@@ -47,6 +47,7 @@ struct fq_flow {
 struct fq_tin {
 	struct list_head new_flows;
 	struct list_head old_flows;
+	struct fq_flow default_flow;
 	u32 backlog_bytes;
 	u32 backlog_packets;
 	u32 overlimit;
diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index 06d2a79233c9..dd374c7f0fe5 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -151,8 +151,7 @@ static u32 fq_flow_idx(struct fq *fq, struct sk_buff *skb)
 
 static struct fq_flow *fq_flow_classify(struct fq *fq,
 					struct fq_tin *tin, u32 idx,
-					struct sk_buff *skb,
-					fq_flow_get_default_t get_default_func)
+					struct sk_buff *skb)
 {
 	struct fq_flow *flow;
 
@@ -160,7 +159,7 @@ static struct fq_flow *fq_flow_classify(struct fq *fq,
 
 	flow = &fq->flows[idx];
 	if (flow->tin && flow->tin != tin) {
-		flow = get_default_func(fq, tin, idx, skb);
+		flow = &tin->default_flow;
 		tin->collisions++;
 		fq->collisions++;
 	}
@@ -192,15 +191,14 @@ static void fq_recalc_backlog(struct fq *fq,
 static void fq_tin_enqueue(struct fq *fq,
 			   struct fq_tin *tin, u32 idx,
 			   struct sk_buff *skb,
-			   fq_skb_free_t free_func,
-			   fq_flow_get_default_t get_default_func)
+			   fq_skb_free_t free_func)
 {
 	struct fq_flow *flow;
 	bool oom;
 
 	lockdep_assert_held(&fq->lock);
 
-	flow = fq_flow_classify(fq, tin, idx, skb, get_default_func);
+	flow = fq_flow_classify(fq, tin, idx, skb);
 
 	flow->tin = tin;
 	flow->backlog += skb->len;
@@ -331,6 +329,7 @@ static void fq_tin_init(struct fq_tin *tin)
 {
 	INIT_LIST_HEAD(&tin->new_flows);
 	INIT_LIST_HEAD(&tin->old_flows);
+	fq_flow_init(&tin->default_flow);
 }
 
 static int fq_init(struct fq *fq, int flows_cnt)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8bf9c0e974d6..c0f6168fdeed 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -848,7 +848,6 @@ enum txq_info_flags {
  */
 struct txq_info {
 	struct fq_tin tin;
-	struct fq_flow def_flow;
 	struct codel_vars def_cvars;
 	struct codel_stats cstats;
 	struct sk_buff_head frags;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f1c934f21d7e..50b4e92fd766 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1309,7 +1309,7 @@ static struct sk_buff *codel_dequeue_func(struct codel_vars *cvars,
 	fq = &local->fq;
 
 	if (cvars == &txqi->def_cvars)
-		flow = &txqi->def_flow;
+		flow = &txqi->tin.default_flow;
 	else
 		flow = &fq->flows[cvars - local->cvars];
 
@@ -1352,7 +1352,7 @@ static struct sk_buff *fq_tin_dequeue_func(struct fq *fq,
 		cparams = &local->cparams;
 	}
 
-	if (flow == &txqi->def_flow)
+	if (flow == &tin->default_flow)
 		cvars = &txqi->def_cvars;
 	else
 		cvars = &local->cvars[flow - fq->flows];
@@ -1379,17 +1379,6 @@ static void fq_skb_free_func(struct fq *fq,
 	ieee80211_free_txskb(&local->hw, skb);
 }
 
-static struct fq_flow *fq_flow_get_default_func(struct fq *fq,
-						struct fq_tin *tin,
-						int idx,
-						struct sk_buff *skb)
-{
-	struct txq_info *txqi;
-
-	txqi = container_of(tin, struct txq_info, tin);
-	return &txqi->def_flow;
-}
-
 static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 				  struct txq_info *txqi,
 				  struct sk_buff *skb)
@@ -1402,8 +1391,7 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 
 	spin_lock_bh(&fq->lock);
 	fq_tin_enqueue(fq, tin, flow_idx, skb,
-		       fq_skb_free_func,
-		       fq_flow_get_default_func);
+		       fq_skb_free_func);
 	spin_unlock_bh(&fq->lock);
 }
 
@@ -1446,7 +1434,6 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 			struct txq_info *txqi, int tid)
 {
 	fq_tin_init(&txqi->tin);
-	fq_flow_init(&txqi->def_flow);
 	codel_vars_init(&txqi->def_cvars);
 	codel_stats_init(&txqi->cstats);
 	__skb_queue_head_init(&txqi->frags);
@@ -3283,8 +3270,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	 */
 
 	tin = &txqi->tin;
-	flow = fq_flow_classify(fq, tin, flow_idx, skb,
-				fq_flow_get_default_func);
+	flow = fq_flow_classify(fq, tin, flow_idx, skb);
 	head = skb_peek_tail(&flow->queue);
 	if (!head || skb_is_gso(head))
 		goto out;
-- 
2.28.0

