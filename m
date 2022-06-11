Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B542547767
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jun 2022 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiFKUBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jun 2022 16:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKUBP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jun 2022 16:01:15 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341BA5047A
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=M/fMUxMVKjwCK2B4V6jFaSZCK0amiplNIXCxzgZDsnw=; b=YuFZR5xBCwMUvpA6dr+b39IqIr
        uJ3Ii3KHaNRwcYcZnZ1SG+wGOBv8TouT2EUmqUTIgn3Q7phTib4TvPliyoyleFNnLObCVKhrBugSR
        Sy0n4KSqlEJkUTh/H+L6h90Uu9SOUqRslifvcoeUQjDTU1JZ3oTGsekuvFeCTwa8qDqM=;
Received: from p57a6f441.dip0.t-ipconnect.de ([87.166.244.65] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o07ID-0006oU-Cv; Sat, 11 Jun 2022 22:01:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, toke@kernel.org
Subject: [PATCH v2 3/4] mac80211: fix ieee80211_txq_may_transmit regression
Date:   Sat, 11 Jun 2022 22:01:05 +0200
Message-Id: <20220611200106.34319-3-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220611200106.34319-1-nbd@nbd.name>
References: <20220611200106.34319-1-nbd@nbd.name>
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

After switching to the virtual time based airtime scheduler, there were reports
that ath10k with tx queueing in push-pull mode was experiencing significant
latency for some stations.
The reason for it is the fact that queues from which the ath10k firmware wants
to pull are getting starved by airtime fairness constraints.
Theoretically the same issue should have been there before the switch to virtual
time, however it seems that in the old round-robin implementation it was simply
looping until the requested txq was considered eligible, which led to it pretty
much ignoring fairness constraints anyway.

In order to fix the immediate regression, let's make bypassing airtime fairness
explicit for now.
Also update the documentation for ieee80211_txq_may_transmit, which was still
referring to implementation details of the old round-robin scheduler

Fixes: 2433647bc8d9 ("mac80211: Switch to a virtual time-based airtime scheduler")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h | 21 +++++----------------
 net/mac80211/tx.c      | 17 +----------------
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d8c4d49bcc49..cb65abab8f36 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6821,22 +6821,11 @@ void ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
 /**
  * ieee80211_txq_may_transmit - check whether TXQ is allowed to transmit
  *
- * This function is used to check whether given txq is allowed to transmit by
- * the airtime scheduler, and can be used by drivers to access the airtime
- * fairness accounting without going using the scheduling order enfored by
- * next_txq().
- *
- * Returns %true if the airtime scheduler thinks the TXQ should be allowed to
- * transmit, and %false if it should be throttled. This function can also have
- * the side effect of rotating the TXQ in the scheduler rotation, which will
- * eventually bring the deficit to positive and allow the station to transmit
- * again.
- *
- * The API ieee80211_txq_may_transmit() also ensures that TXQ list will be
- * aligned against driver's own round-robin scheduler list. i.e it rotates
- * the TXQ list till it makes the requested node becomes the first entry
- * in TXQ list. Thus both the TXQ list and driver's list are in sync. If this
- * function returns %true, the driver is expected to schedule packets
+ * Returns %true if there is remaining AQL budget for the tx queue and %false
+ * if it should be throttled. It will also mark the queue as active for the
+ * airtime scheduler.
+ *
+ * If this function returns %true, the driver is expected to schedule packets
  * for transmission, and then return the TXQ through ieee80211_return_txq().
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ecb3975680bc..f844e9ed4c14 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4099,15 +4099,13 @@ EXPORT_SYMBOL(ieee80211_txq_airtime_check);
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
-	struct txq_info *first_txqi = NULL, *txqi = to_txq_info(txq);
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
 	struct airtime_sched_info *air_sched;
 	struct airtime_info *air_info;
-	struct rb_node *node = NULL;
 	bool ret = false;
 	u64 now;
 
-
 	if (!ieee80211_txq_airtime_check(hw, txq))
 		return false;
 
@@ -4119,19 +4117,6 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 
 	now = ktime_get_coarse_boottime_ns();
 
-	/* Like in ieee80211_next_txq(), make sure the first station in the
-	 * scheduling order is eligible for transmission to avoid starvation.
-	 */
-	node = rb_first_cached(&air_sched->active_txqs);
-	if (node) {
-		first_txqi = container_of(node, struct txq_info,
-					  schedule_order);
-		air_info = to_airtime_info(&first_txqi->txq);
-
-		if (air_sched->v_t < air_info->v_t)
-			airtime_catchup_v_t(air_sched, air_info->v_t, now);
-	}
-
 	air_info = to_airtime_info(&txqi->txq);
 	if (air_info->v_t <= air_sched->v_t) {
 		air_sched->last_schedule_activity = now;
-- 
2.36.1

