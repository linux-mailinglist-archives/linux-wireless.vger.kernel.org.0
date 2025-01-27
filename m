Return-Path: <linux-wireless+bounces-18034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB873A1DA8E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CB51888CC7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFCE1581E0;
	Mon, 27 Jan 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="J4rBDNgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BED157493
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995310; cv=none; b=f5nap2bayhxoUCwzrDo1ZpgwIYn4Y1THhsODW3rKarA1LRIDqSYLxIShO++SPP9/CzDhKH3xvzPteUeDfW72NyJwld5+1Q+4W+qP//R7NaDxjaMTslkEBaeDbD4CMUwV8rIz88FS5xM7QGJ5LyL0aOlGXfFpZrynuOiq+G0P3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995310; c=relaxed/simple;
	bh=yNGmMPQsNAIKQisDkqd0Xdu1EpRz+A2n4k3y9qo0380=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/hNnEYNKT0lWaZGcp1FyP3P1f+fR9lu2Xd5Vszyf4nUYaVOKb0a8RxfWfv6z9RsDBbb81disA9/7+pm1YTpxvd1fPsZ84vn3yKQZrRxjR9kKp/mPnqWTf5fXh/3m58RJs1hRVWuQ+DdoD3hj1hQ+7k6UjUOXPLTKgB8H6lLuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=J4rBDNgw; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995298;
	bh=yNGmMPQsNAIKQisDkqd0Xdu1EpRz+A2n4k3y9qo0380=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4rBDNgwXHKSYUKB1oLobUBaSCm1KV76Gd3dqFneR9/AuECaDu3gIh/9OQaaDZeVR
	 T3hbule4y6Cv2CvQ5w+ObFyJ+6sLww43WSvs/0Qw2a0IPRnREa1f0OhJQspfY+odXZ
	 QVyCNLAPwu3SHpSkgsDSrCmEwnr/NQGFTzFjToL0=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [RFC PATCH 13/13] wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
Date: Mon, 27 Jan 2025 17:26:25 +0100
Message-ID: <20250127162625.20747-14-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
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
 net/mac80211/util.c  | 26 ++++++++++++--------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9b2d0b3ae132..c650bc3df986 100644
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
index 0513a1da2b51..985644949d7e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -318,8 +318,8 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_handle_wake_tx_queue);
 
-static void __ieee80211_wake_txq(struct ieee80211_local *local,
-				 struct ieee80211_txq *txq)
+static void ieee80211_wake_txq(struct ieee80211_local *local,
+			       struct ieee80211_txq *txq)
 {
 	struct txq_info *txqi = to_txq_info(txq);
 	struct fq *fq = &local->fq;
@@ -331,7 +331,7 @@ static void __ieee80211_wake_txq(struct ieee80211_local *local,
 	}
 }
 
-static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
+static void _ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct fq *fq = &local->fq;
@@ -354,15 +354,13 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 
 	/* %IEEE80211_VIF_TXQ_NOQUEUE must be ignored here */
 
-	if (ac == IEEE80211_AC_VO) {
-		__ieee80211_wake_txq(local,
-				     vif->txq[IEEE80211_VIF_TXQ_FALLBACK]);
-	}
+	if (ac == IEEE80211_AC_VO)
+		ieee80211_wake_txq(local, vif->txq[IEEE80211_VIF_TXQ_FALLBACK]);
 
 	if (ac == IEEE80211_AC_BE && vif->txq[IEEE80211_VIF_TXQ_MULTICAST] &&
 	    (!ps || !atomic_read(&ps->num_sta_ps)))
-		__ieee80211_wake_txq(local,
-				     vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
+		ieee80211_wake_txq(local,
+				   vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 	list_for_each_entry_rcu(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata)
@@ -378,7 +376,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 			if (ac != txq->ac)
 				continue;
 
-			__ieee80211_wake_txq(local, txq);
+			ieee80211_wake_txq(local, txq);
 		}
 	}
 out:
@@ -389,7 +387,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 static void
 __releases(&local->queue_stop_reason_lock)
 __acquires(&local->queue_stop_reason_lock)
-_ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
+ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int n_acs = IEEE80211_NUM_ACS;
@@ -416,7 +414,7 @@ _ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
 
 				if (ac_queue == i ||
 				    sdata->vif.cab_queue == i)
-					__ieee80211_wake_txqs(sdata, ac);
+					_ieee80211_wake_txqs(sdata, ac);
 			}
 		}
 		spin_lock_irqsave(&local->queue_stop_reason_lock, *flags);
@@ -459,13 +457,13 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
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


