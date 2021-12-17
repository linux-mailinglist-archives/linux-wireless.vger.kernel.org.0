Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682FE478A43
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhLQLnK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 06:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhLQLnJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 06:43:09 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C532C061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 03:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Yt68lu28p8qhSLxKJdX2Rb74vLM2/5YjejiNJAHF6zk=; b=gOWtmWg8RC94xOwGpaIA/1lJ53
        /x85Ooz17cegyO5mJzgHrGwEFGqw4yoToph9uMF9e7ETs1VIfd5HTslwxOlvKaUKmUiX42qG7mO16
        0oK3zK4IsU3o13ckh565X3nVjprY1UQO0T+dOQtqQseYP0IXK5jQPnlm5q021CNyoN0o=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1myBdj-0007rY-L2; Fri, 17 Dec 2021 12:43:07 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, toke@redhat.com
Subject: [PATCH] mac80211: use coarse boottime for airtime fairness code
Date:   Fri, 17 Dec 2021 12:42:58 +0100
Message-Id: <20211217114258.14619-1-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The time values used by the airtime fairness code only need to be accurate
enough to cover station activity detection.
Using ktime_get_coarse_boottime_ns instead of ktime_get_boottime_ns will
drop the accuracy down to jiffies intervals, but at the same time saves
a lot of CPU cycles in a hot path

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 278945e3e08a..cbe7d1d00a50 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3821,7 +3821,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct airtime_sched_info *air_sched;
-	u64 now = ktime_get_boottime_ns();
+	u64 now = ktime_get_coarse_boottime_ns();
 	struct ieee80211_txq *ret = NULL;
 	struct airtime_info *air_info;
 	struct txq_info *txqi = NULL;
@@ -3948,7 +3948,7 @@ void ieee80211_update_airtime_weight(struct ieee80211_local *local,
 	u64 weight_sum = 0;
 
 	if (unlikely(!now))
-		now = ktime_get_boottime_ns();
+		now = ktime_get_coarse_boottime_ns();
 
 	lockdep_assert_held(&air_sched->lock);
 
@@ -3974,7 +3974,7 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = to_txq_info(txq);
 	struct airtime_sched_info *air_sched;
-	u64 now = ktime_get_boottime_ns();
+	u64 now = ktime_get_coarse_boottime_ns();
 	struct airtime_info *air_info;
 	u8 ac = txq->ac;
 	bool was_active;
@@ -4032,7 +4032,7 @@ static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
 
 	if (!purge)
 		airtime_set_active(air_sched, air_info,
-				   ktime_get_boottime_ns());
+				   ktime_get_coarse_boottime_ns());
 
 	rb_erase_cached(&txqi->schedule_order,
 			&air_sched->active_txqs);
@@ -4120,7 +4120,7 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 	if (RB_EMPTY_NODE(&txqi->schedule_order))
 		goto out;
 
-	now = ktime_get_boottime_ns();
+	now = ktime_get_coarse_boottime_ns();
 
 	/* Like in ieee80211_next_txq(), make sure the first station in the
 	 * scheduling order is eligible for transmission to avoid starvation.
-- 
2.34.1

