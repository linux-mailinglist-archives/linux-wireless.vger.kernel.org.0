Return-Path: <linux-wireless+bounces-18030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD3A1DA8B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11811888D50
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7502715CD78;
	Mon, 27 Jan 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="HFZqmdIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A77155382
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995310; cv=none; b=g3KnNREO9oxpzZRCEOdGp/8mfutMke5W2chSuP6yPKtos6ayZ19K526fjHyVj58CycOQAJNkx3yqiDmaVA5JWBPmeoyvld9/tDHYihc/17xTN9jWkNQW/7D1GKd5tevZR0MSpLrjuXi3UJ0iiTneKuvCH/nv5u0dJNJAinLDh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995310; c=relaxed/simple;
	bh=zALIxcHhdlrIeE0+Nh3VjnJG+JShCnkMPBwDDnFgZBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntwe44vJ2cduSaCuC4aYlW9NY4GQ0sZl5xhiorScKa4ZLJuyvwWvEF9YMq/EmM4IFfqy38CQbZjmXQQvlGHqeleIVfmWni8emEpZuxFgsmVHVM7NCnFOaJk5/syy3mi0x1GJn94JcdCCqAyPHa5/ddoIv76Z6p2PFkgpdoW4lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=HFZqmdIw; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995298;
	bh=zALIxcHhdlrIeE0+Nh3VjnJG+JShCnkMPBwDDnFgZBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HFZqmdIwJz762wcJfwbGG/8z3qa1/r/4Ew9g3VbRz+hlHCVllRu+kNOFksbiEQlNV
	 FGmq91zfZK0wwx/abfQdwoFq93ET9icxxroCXbw7UZgMAYbZ6HdGoelbR/Nb+gSIvG
	 6urBSaVHZZ2ocfusMlnXRIhJt4yP7VPJ37BTQsK0=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [RFC PATCH 12/13] wifi: mac80211: Drop wake_txqs_tasklet
Date: Mon, 27 Jan 2025 17:26:24 +0100
Message-ID: <20250127162625.20747-13-Alexander@wetzel-home.de>
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

_ieee80211_wake_txqs() is no longer handling TX, making the
wake_txqs_tasklet unnecessary.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/main.c        |  1 -
 net/mac80211/util.c        | 16 +---------------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8bd1e4f0e5fd..cecf2363fd85 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1461,7 +1461,6 @@ struct ieee80211_local {
 
 	struct sk_buff_head pending[IEEE80211_MAX_QUEUES];
 	struct tasklet_struct tx_pending_tasklet;
-	struct tasklet_struct wake_txqs_tasklet;
 	struct task_struct *mac80211_tsk;
 	wait_queue_head_t mac80211_tsk_wq;
 
@@ -2540,7 +2539,6 @@ void ieee80211_txq_remove_vlan(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata);
 void ieee80211_fill_txq_stats(struct cfg80211_txq_stats *txqstats,
 			      struct txq_info *txqi);
-void ieee80211_wake_txqs(struct tasklet_struct *t);
 int mac80211_thread(void *data);
 void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 			 u16 transaction, u16 auth_alg, u16 status,
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 25d5a57a74ca..c634a781970b 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -999,7 +999,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 		skb_queue_head_init(&local->pending[i]);
 	}
 	tasklet_setup(&local->tx_pending_tasklet, ieee80211_tx_pending);
-	tasklet_setup(&local->wake_txqs_tasklet, ieee80211_wake_txqs);
 	tasklet_setup(&local->tasklet, ieee80211_tasklet_handler);
 
 	init_waitqueue_head(&local->mac80211_tsk_wq);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1f84b83b0ea4..0513a1da2b51 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -425,17 +425,6 @@ _ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
 	rcu_read_unlock();
 }
 
-void ieee80211_wake_txqs(struct tasklet_struct *t)
-{
-	struct ieee80211_local *local = from_tasklet(local, t,
-						     wake_txqs_tasklet);
-	unsigned long flags;
-
-	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-	_ieee80211_wake_txqs(local, &flags);
-	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
-}
-
 static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 				   enum queue_stop_reason reason,
 				   bool refcounted,
@@ -476,10 +465,7 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 	 * release someone's lock, but it is fine because all the callers of
 	 * __ieee80211_wake_queue call it right before releasing the lock.
 	 */
-	if (reason == IEEE80211_QUEUE_STOP_REASON_DRIVER)
-		tasklet_schedule(&local->wake_txqs_tasklet);
-	else
-		_ieee80211_wake_txqs(local, flags);
+	_ieee80211_wake_txqs(local, flags);
 }
 
 static int ac_has_active_txq(struct ieee80211_local *local)
-- 
2.48.1


