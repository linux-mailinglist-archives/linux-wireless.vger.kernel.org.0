Return-Path: <linux-wireless+bounces-19064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F55A37CF3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A633B1C31
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694641A23B8;
	Mon, 17 Feb 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="xA33+qFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0119259D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780262; cv=none; b=qj6WPfS/9dcZ1G3SKnzmQtxGy0AJwFtrDoodomsD55N6ydhDvRVe5g4bGPz8ip9fRbbFDkLcvwp0SeEI6l5D1IEnjvR+ps/W0dYb2jK6kUU28JAqeWv+JLY7U76qZ2xOeTDfaG7Z8wM2wCe4C3QitMEpkLdc7ZQMywA/Du5bN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780262; c=relaxed/simple;
	bh=XcKPGs7W7qwnW4V6Ira6eRFtRXWI0MVldvJMmYfwXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQBUhtOAPwAN4YqBEWPUzhPEYorLw+LAA9PikRz2KDgGFrBw8q5GYTJo7BjKX4JFT6EmIZvg6qwCeOA2n+SvAjgUBO8OcvcBSFXGV9Op7T8AE6YQsV3Dxv+s3Y8vir1m2mCpZzAcsMu4FKWDIqkGH7wYFGiOkmKtNsUox107+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=xA33+qFz; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739780253;
	bh=XcKPGs7W7qwnW4V6Ira6eRFtRXWI0MVldvJMmYfwXYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xA33+qFzE+oDalTXp4AWmh00hesIEQLPAn92WyqlNRu43nj2wc14dxEIdVFV0aKRp
	 7tgrNfOiWFNjUoBUHBgtk44GS5dTySJySd/tKiStqtTRLFgwvVeYC6fHWM+qXxPVSc
	 vT919sNHT8C2R1QE9eh5PPKYb0CIv6ScqRKVBDaM=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH v2 10/10] wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
Date: Mon, 17 Feb 2025 09:17:21 +0100
Message-ID: <20250217081721.45110-11-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217081721.45110-1-Alexander@wetzel-home.de>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
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
index 0437e87ec8f2..2a2aaec68d58 100644
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
index 7125a5004776..e85ecbda9afa 100644
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


