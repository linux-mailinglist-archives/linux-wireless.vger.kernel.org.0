Return-Path: <linux-wireless+bounces-19021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2CAA37514
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F8D3A9C9C
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7B199FAB;
	Sun, 16 Feb 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="oLsgAzIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD419342E
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719952; cv=none; b=UeEjovKcqI+s+0Ts33Wca/UVhWBX8ZaAn3aTCYQDG3X9UzaWx98bORNHplwb78T+0CVh/AYb6rB2jfOPWK/1jxVixBHDeuNeoCjIc61Y46uwIC2/SMv98tPrGvdxGSQ4KOQe6ZJ+j+1qij/z73aL15DpjEhiqa7itJaMuud1kXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719952; c=relaxed/simple;
	bh=n6U23k8AFNA04V67wNs4lfznbuylpgi8vMsU7I1Ivq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKQ2rXWqYPLAYJtKCt14khYGnmz2RCH6HZEFAeYj7ZwMSxDrSlsM7ZfaerUnvJobHlYjmM4XYYBC580hAecHcJMz+dtrCo3grwd/7LHTFVqzdDsCu0FVI53bi1cIl3iW61uM2z5O64nHNVTbgQXeDqJ64jvjOMSmXNyL/9osfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=oLsgAzIp; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739719938;
	bh=n6U23k8AFNA04V67wNs4lfznbuylpgi8vMsU7I1Ivq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oLsgAzIp1lB17jlrO2zZy5fXYAfuea+urXRacBelD2YAxb9O2Xfc1Wicr5ML88id5
	 JNc3zMru18AluyvaZMxGBoG+E4BIfJ5jMHg1cyex0xRtk9MKfsIpiOfHplyjSU/Ir7
	 PEP3SCSEIDrmbWZ4tNEg0xnSDupcgBX4U6HdMvSA=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH 10/10] wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
Date: Sun, 16 Feb 2025 16:32:00 +0100
Message-ID: <20250216153200.1318604-11-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216153200.1318604-1-Alexander@wetzel-home.de>
References: <20250216153200.1318604-1-Alexander@wetzel-home.de>
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
index d1e2775e1abc..7070c2312dc4 100644
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


