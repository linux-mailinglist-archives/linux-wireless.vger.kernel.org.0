Return-Path: <linux-wireless+bounces-19194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825FA3D73D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 11:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B3019C0D86
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD47A1F150B;
	Thu, 20 Feb 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="SZzvq0jq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9F51F3FE3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048287; cv=none; b=Ub2NdtdKZvr8LpnbRiPxIxy3rxl6szg9R9Y2jcJAJaqt+VWKpCgJviJ1oVYucwwOjIFDD+4hlVhsep9/iQOqdxBMd+Jm28t0Dzp7wDUTqXMo5NIDPLw0GyLRl0RtoSlHUk1wPSrrYe3fBP0a/9fRH515Cp8IkZL9GXxXlp6RTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048287; c=relaxed/simple;
	bh=/ST1L7KynLDKnQIvcOzi89BPdE+dRC0jZ9khzuginuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAtuD5Oy+PjUs2z9wmnDrkNjTGWHjPjk3NsaWTmh8lLFT4uNGw9Ku3FAhMobDuow+r/N2uqZYQ9w9GYkgxpJhPhu4dROOAW91O2UNTYJbYvJuifdotGslCjOXVESTpmrlW9kE7AO9rHWO4zWlQb85b4c062PrxlyuGkglthhEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=SZzvq0jq; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740048281;
	bh=/ST1L7KynLDKnQIvcOzi89BPdE+dRC0jZ9khzuginuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZzvq0jqKArYyPutx/wvKP+y8El6Bpa+oMJI0y+zyF5F1bAaLB6gf8vmwxcxWpobm
	 Y2PPl9Zu9u4Ovo/qOaPBMEUL/Hag8VKgc8jd1f9KuSVapM+uFD+Y4KdawiYsOL8tRv
	 R7yL3xvCoWUVEGw2ZS16CilQTJILcQx5FZBPY8XQ=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH v3 10/10] wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
Date: Thu, 20 Feb 2025 11:44:26 +0100
Message-ID: <20250220104426.82011-11-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220104426.82011-1-Alexander@wetzel-home.de>
References: <20250220104426.82011-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_wake_txq() and ieee80211_wake_txqs() are not used.
Rename:
	_ieee80211_wake_txqs()  -> ieee80211_wake_txqs()
	__ieee80211_wake_txqs() -> _ieee80211_wake_txqs()
	__ieee80211_wake_txq()  -> ieee80211_wake_txq()

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
 net/mac80211/iface.c |  2 +-
 net/mac80211/util.c  | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 5cebe38af44f..a78dcbc4c1ab 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -467,7 +467,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
-	synchronize_rcu(); /* flush _ieee80211_wake_txqs() */
+	synchronize_rcu(); /* flush ieee80211_wake_txqs() */
 
 	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
 	if (cancel_scan)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 98a05b4d9dcd..cce7c3794a90 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -320,8 +320,8 @@ EXPORT_SYMBOL(ieee80211_handle_wake_tx_queue);
 
 __releases(&local->fq->lock)
 __acquires(&local->fq->lock)
-static void __ieee80211_wake_txq(struct ieee80211_local *local,
-				 struct ieee80211_txq *txq)
+static void ieee80211_wake_txq(struct ieee80211_local *local,
+			       struct ieee80211_txq *txq)
 {
 	struct txq_info *txqi = to_txq_info(txq);
 	struct fq *fq = &local->fq;
@@ -334,7 +334,7 @@ static void __ieee80211_wake_txq(struct ieee80211_local *local,
 	}
 }
 
-static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
+static void _ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct fq *fq = &local->fq;
@@ -365,11 +365,11 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 	 */
 
 	if (ac == txq_fb->ac)
-		__ieee80211_wake_txq(local, txq_fb);
+		ieee80211_wake_txq(local, txq_fb);
 
 	if (txq_mc && ac == txq_mc->ac &&
 	    (!ps || !atomic_read(&ps->num_sta_ps)))
-		__ieee80211_wake_txq(local, txq_mc);
+		ieee80211_wake_txq(local, txq_mc);
 
 	/* STA TXQs */
 	list_for_each_entry_rcu(sta, &local->sta_list, list) {
@@ -390,7 +390,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 				continue;
 
 			/* releases and retakes fq->lock */
-			__ieee80211_wake_txq(local, txq);
+			ieee80211_wake_txq(local, txq);
 		}
 	}
 out:
@@ -401,7 +401,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 static void
 __releases(&local->queue_stop_reason_lock)
 __acquires(&local->queue_stop_reason_lock)
-_ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
+ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int n_acs = IEEE80211_NUM_ACS;
@@ -428,7 +428,7 @@ _ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
 
 				if (ac_queue == i ||
 				    sdata->vif.cab_queue == i)
-					__ieee80211_wake_txqs(sdata, ac);
+					_ieee80211_wake_txqs(sdata, ac);
 			}
 		}
 		spin_lock_irqsave(&local->queue_stop_reason_lock, *flags);
@@ -472,13 +472,13 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 		tasklet_schedule(&local->tx_pending_tasklet);
 
 	/*
-	 * Calling _ieee80211_wake_txqs here can be a problem because it may
+	 * Calling ieee80211_wake_txqs here can be a problem because it may
 	 * release queue_stop_reason_lock which has been taken by
 	 * __ieee80211_wake_queue's caller. It is certainly not very nice to
 	 * release someone's lock, but it is fine because all the callers of
 	 * __ieee80211_wake_queue call it right before releasing the lock.
 	 */
-	_ieee80211_wake_txqs(local, flags);
+	ieee80211_wake_txqs(local, flags);
 }
 
 static int ac_has_active_txq(struct ieee80211_local *local)
-- 
2.48.1


