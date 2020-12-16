Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658072DC7E0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 21:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgLPUoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgLPUoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 15:44:02 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281DC0617B0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MjcN0NHRmwhpn7yXpFgAe04DEdgzuSbjkxScG5gnwKg=; b=CrstrhS8jf/qkBh8qim1Z7YBAI
        BnwgKJ7xXdRGwWM/ii3SZGV/ub5gSqMBcSCVuTENYKGVBALVdKqieeK9nMvQjfn7vj+IP9bED0ikM
        uECt6B2OvWNQm/Xt/LQrrkOXS9uknVphLTlA40JD5iKAhNxQpKcHfgVBKz7nrS7O90cs=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpddl-0002eR-W3; Wed, 16 Dec 2020 21:43:18 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/7] net/fq_impl: bulk-free packets from a flow on overmemory
Date:   Wed, 16 Dec 2020 21:43:10 +0100
Message-Id: <20201216204316.44498-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is similar to what sch_fq_codel does. It also amortizes the worst
case cost of a follow-up patch that changes the selection of the biggest
flow for dropping packets

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/fq_impl.h | 55 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index e73d74d2fabf..06d2a79233c9 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -11,17 +11,25 @@
 
 /* functions that are embedded into includer */
 
+
+static void
+__fq_adjust_removal(struct fq *fq, struct fq_flow *flow, unsigned int packets,
+		    unsigned int bytes, unsigned int truesize)
+{
+	struct fq_tin *tin = flow->tin;
+
+	tin->backlog_bytes -= bytes;
+	tin->backlog_packets -= packets;
+	flow->backlog -= bytes;
+	fq->backlog -= packets;
+	fq->memory_usage -= truesize;
+}
+
 static void fq_adjust_removal(struct fq *fq,
 			      struct fq_flow *flow,
 			      struct sk_buff *skb)
 {
-	struct fq_tin *tin = flow->tin;
-
-	tin->backlog_bytes -= skb->len;
-	tin->backlog_packets--;
-	flow->backlog -= skb->len;
-	fq->backlog--;
-	fq->memory_usage -= skb->truesize;
+	__fq_adjust_removal(fq, flow, 1, skb->len, skb->truesize);
 }
 
 static void fq_rejigger_backlog(struct fq *fq, struct fq_flow *flow)
@@ -59,6 +67,34 @@ static struct sk_buff *fq_flow_dequeue(struct fq *fq,
 	return skb;
 }
 
+static int fq_flow_drop(struct fq *fq, struct fq_flow *flow,
+			fq_skb_free_t free_func)
+{
+	unsigned int packets = 0, bytes = 0, truesize = 0;
+	struct fq_tin *tin = flow->tin;
+	struct sk_buff *skb;
+	int pending;
+
+	lockdep_assert_held(&fq->lock);
+
+	pending = min_t(int, 32, skb_queue_len(&flow->queue) / 2);
+	do {
+		skb = __skb_dequeue(&flow->queue);
+		if (!skb)
+			break;
+
+		packets++;
+		bytes += skb->len;
+		truesize += skb->truesize;
+		free_func(fq, tin, flow, skb);
+	} while (packets < pending);
+
+	__fq_adjust_removal(fq, flow, packets, bytes, truesize);
+	fq_rejigger_backlog(fq, flow);
+
+	return packets;
+}
+
 static struct sk_buff *fq_tin_dequeue(struct fq *fq,
 				      struct fq_tin *tin,
 				      fq_tin_dequeue_t dequeue_func)
@@ -190,12 +226,9 @@ static void fq_tin_enqueue(struct fq *fq,
 		if (!flow)
 			return;
 
-		skb = fq_flow_dequeue(fq, flow);
-		if (!skb)
+		if (!fq_flow_drop(fq, flow, free_func))
 			return;
 
-		free_func(fq, flow->tin, flow, skb);
-
 		flow->tin->overlimit++;
 		fq->overlimit++;
 		if (oom) {
-- 
2.28.0

