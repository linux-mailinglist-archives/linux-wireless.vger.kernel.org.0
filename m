Return-Path: <linux-wireless+bounces-19195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0484A3D73E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 11:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E5219C0E29
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46DB1F4262;
	Thu, 20 Feb 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="S/vliHBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C901F3FC3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048287; cv=none; b=BH1WkOl4bgu8TZNvizukVX+kWQgnaOmoMRSAK2wRCPf5UvXfmTGgu6fmBMjsUrJ9W5NMJYywjvjh4hWP12Uiidg1qYsqNbowhsBU4EFea7d35TJSI9eKl7fSbwTSP7/jj9KEUrkGl/r9iE84F4BqeWRmELe/Q29ss6NLA+A0sPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048287; c=relaxed/simple;
	bh=kkSAL3lTHxfyDnuymjjfF/mIcjwZcj0msVVRurYX3Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAaqstRJYH3e0rX2f/ejQkCh6ir0rAdqOokE5+fmsbIc/fdzPUQCmTVi5uH4O2aQI0J5hcuQWoUFHvL0FuCc7dNB+fgfh5EVvWzTRh1DCTo9WkrNX16Y7lffg8jsloRb9KstHbXYSs3gJp0IaVsm04ILdUo/d/lZSuUJiwlTjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=S/vliHBj; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740048280;
	bh=kkSAL3lTHxfyDnuymjjfF/mIcjwZcj0msVVRurYX3Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/vliHBj4EX+Kf60uuTZibzfCLjF2n0T7+lSf7kyFgu3Ga7BrdteIHQME++aWkJtO
	 iViBEPyHT0wqdRXabJ2lXmhoqFIndNpzPJrltwcQFTXbOnulGzb1UFDf5HPy5zBseO
	 KthdvlQ2bmwbGIzHYXxQZWwKamAMrHm7UUAS7ak0=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v3 05/10] wifi: mac80211: Stop using legacy TX path
Date: Thu, 20 Feb 2025 11:44:21 +0100
Message-ID: <20250220104426.82011-6-Alexander@wetzel-home.de>
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

From: Alexander Wetzel <alexander@wetzel-home.de>

Stop using the legacy TX path within mac80211 and start using TXQs to
handle the not queueable offchannel, disassoc and null-func PS frames.

ieee80211_tx() will queue these frames into either the per-vif or
per-sta helper TXQ. But instead of scheduling a queue run the frame will
immediately be dequeued again and handed over to the driver.

With that functionality mac80211 is now only using TXQs to send frames.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
Changes compared to v1:
 - Use WARN_ON_ONE() instead WARN() in ieee80211_tx()
---
 net/mac80211/tx.c   | 307 +++++++-------------------------------------
 net/mac80211/util.c |  12 +-
 2 files changed, 55 insertions(+), 264 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 600c34fe10ad..db66deae69a4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1301,9 +1301,13 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_txq *txq = NULL;
 
-	if (unlikely(info->flags & IEEE80211_TX_INTFL_OFFCHAN_TX_OK))
-		/* Offchannel queue can't be used, yet */
-		return NULL;
+	if (unlikely(info->flags & IEEE80211_TX_INTFL_OFFCHAN_TX_OK)) {
+		if (sta)
+			txq = sta->sta.txq[IEEE80211_TID_NOQUEUE];
+		else
+			txq = vif->txq[IEEE80211_VIF_TXQ_NOQUEUE];
+		goto out;
+	}
 
 	if (unlikely(vif->type == NL80211_IFTYPE_MONITOR ||
 		     info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM ||
@@ -1643,10 +1647,10 @@ void ieee80211_txq_teardown_flows(struct ieee80211_local *local)
 	spin_unlock_bh(&fq->lock);
 }
 
-static bool ieee80211_queue_skb(struct ieee80211_local *local,
-				struct ieee80211_sub_if_data *sdata,
-				struct sta_info *sta,
-				struct sk_buff *skb)
+static struct txq_info *ieee80211_queue_skb(struct ieee80211_local *local,
+					    struct ieee80211_sub_if_data *sdata,
+					    struct sta_info *sta,
+					    struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = &sdata->vif;
@@ -1658,143 +1662,12 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
 	vif = &sdata->vif;
 	txqi = ieee80211_get_txq(local, vif, sta, skb);
 
-	if (!txqi)
-		return false;
-
 	ieee80211_txq_enqueue(local, txqi, skb);
 
-	schedule_and_wake_txq(local, txqi);
-
-	return true;
-}
-
-static bool ieee80211_tx_frags(struct ieee80211_local *local,
-			       struct ieee80211_vif *vif,
-			       struct sta_info *sta,
-			       struct sk_buff_head *skbs,
-			       bool txpending)
-{
-	struct ieee80211_tx_control control = {};
-	struct sk_buff *skb, *tmp;
-	unsigned long flags;
-
-	skb_queue_walk_safe(skbs, skb, tmp) {
-		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-		int q = info->hw_queue;
-
-#ifdef CONFIG_MAC80211_VERBOSE_DEBUG
-		if (WARN_ON_ONCE(q >= local->hw.queues)) {
-			__skb_unlink(skb, skbs);
-			ieee80211_free_txskb(&local->hw, skb);
-			continue;
-		}
-#endif
-
-		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-		if (local->queue_stop_reasons[q] ||
-		    (!txpending && !skb_queue_empty(&local->pending[q]))) {
-			if (unlikely(info->flags &
-				     IEEE80211_TX_INTFL_OFFCHAN_TX_OK)) {
-				if (local->queue_stop_reasons[q] &
-				    ~BIT(IEEE80211_QUEUE_STOP_REASON_OFFCHANNEL)) {
-					/*
-					 * Drop off-channel frames if queues
-					 * are stopped for any reason other
-					 * than off-channel operation. Never
-					 * queue them.
-					 */
-					spin_unlock_irqrestore(
-						&local->queue_stop_reason_lock,
-						flags);
-					ieee80211_purge_tx_queue(&local->hw,
-								 skbs);
-					return true;
-				}
-			} else {
-
-				/*
-				 * Since queue is stopped, queue up frames for
-				 * later transmission from the tx-pending
-				 * tasklet when the queue is woken again.
-				 */
-				if (txpending)
-					skb_queue_splice_init(skbs,
-							      &local->pending[q]);
-				else
-					skb_queue_splice_tail_init(skbs,
-								   &local->pending[q]);
-
-				spin_unlock_irqrestore(&local->queue_stop_reason_lock,
-						       flags);
-				return false;
-			}
-		}
-		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
-
-		info->control.vif = vif;
-		control.sta = sta ? &sta->sta : NULL;
-
-		__skb_unlink(skb, skbs);
-		drv_tx(local, &control, skb);
-	}
-
-	return true;
-}
-
-/*
- * Returns false if the frame couldn't be transmitted but was queued instead.
- */
-static bool __ieee80211_tx(struct ieee80211_local *local,
-			   struct sk_buff_head *skbs, struct sta_info *sta,
-			   bool txpending)
-{
-	struct ieee80211_tx_info *info;
-	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_vif *vif;
-	struct sk_buff *skb;
-	bool result;
-
-	if (WARN_ON(skb_queue_empty(skbs)))
-		return true;
-
-	skb = skb_peek(skbs);
-	info = IEEE80211_SKB_CB(skb);
-	sdata = vif_to_sdata(info->control.vif);
-	if (sta && !sta->uploaded)
-		sta = NULL;
-
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_MONITOR:
-		if ((sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) ||
-		    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
-			vif = &sdata->vif;
-			break;
-		}
-		sdata = rcu_dereference(local->monitor_sdata);
-		if (sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
-			vif = &sdata->vif;
-			info->hw_queue =
-				vif->hw_queue[skb_get_queue_mapping(skb)];
-		} else if (ieee80211_hw_check(&local->hw, QUEUE_CONTROL)) {
-			ieee80211_purge_tx_queue(&local->hw, skbs);
-			return true;
-		} else
-			vif = NULL;
-		break;
-	case NL80211_IFTYPE_AP_VLAN:
-		sdata = container_of(sdata->bss,
-				     struct ieee80211_sub_if_data, u.ap);
-		fallthrough;
-	default:
-		vif = &sdata->vif;
-		break;
-	}
-
-	result = ieee80211_tx_frags(local, vif, sta, skbs, txpending);
-
-	WARN_ON_ONCE(!skb_queue_empty(skbs));
+	if (likely(txqi->txq.tid != IEEE80211_TID_NOQUEUE))
+		schedule_and_wake_txq(local, txqi);
 
-	return result;
+	return txqi;
 }
 
 /*
@@ -1929,22 +1802,20 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_prepare_skb);
 
-/*
- * Returns false if the frame couldn't be transmitted but was queued instead.
- */
-static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
-			 struct sta_info *sta, struct sk_buff *skb,
-			 bool txpending)
+static void ieee80211_tx(struct ieee80211_sub_if_data *sdata,
+			 struct sta_info *sta, struct sk_buff *skb)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_data tx;
 	ieee80211_tx_result res_prepare;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool result = true;
+	bool noqueue = info->flags & IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
+	struct ieee80211_tx_control control;
+	struct txq_info *txqi;
 
 	if (unlikely(skb->len < 10)) {
 		dev_kfree_skb(skb);
-		return true;
+		return;
 	}
 
 	/* initialises tx */
@@ -1952,9 +1823,9 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 
 	if (unlikely(res_prepare == TX_DROP)) {
 		ieee80211_free_txskb(&local->hw, skb);
-		return true;
+		return;
 	} else if (unlikely(res_prepare == TX_QUEUED)) {
-		return true;
+		return;
 	}
 
 	/* set up hw_queue value early */
@@ -1964,15 +1835,23 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 			sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	if (invoke_tx_handlers_early(&tx))
-		return true;
+		return;
 
-	if (ieee80211_queue_skb(local, sdata, tx.sta, tx.skb))
-		return true;
+	txqi = ieee80211_queue_skb(local, sdata, tx.sta, tx.skb);
+
+	if (likely(!noqueue))
+		return;
 
-	if (!invoke_tx_handlers_late(&tx))
-		result = __ieee80211_tx(local, &tx.skbs, tx.sta, txpending);
+	/* Noqueue frames bypass the normal TX and go out immediately */
 
-	return result;
+	if (sta && sta->uploaded)
+		control.sta = txqi->txq.sta;
+	else
+		control.sta = NULL;
+
+	skb = ieee80211_tx_dequeue(&local->hw, &txqi->txq);
+	if (!WARN_ON_ONCE(!skb))
+		drv_tx(local, &control, skb);
 }
 
 /* device xmit handlers */
@@ -2062,7 +1941,7 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 	}
 
 	ieee80211_set_qos_hdr(sdata, skb);
-	ieee80211_tx(sdata, sta, skb, false);
+	ieee80211_tx(sdata, sta, skb);
 }
 
 static bool ieee80211_validate_radiotap_len(struct sk_buff *skb)
@@ -3676,7 +3555,6 @@ void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_hdr *hdr = (void *)fast_tx->hdr;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_tx_data tx;
-	ieee80211_tx_result r;
 	int hw_headroom = sdata->local->hw.extra_tx_headroom;
 	int extra_head = fast_tx->hdr_len - (ETH_HLEN - 2);
 
@@ -3732,22 +3610,7 @@ void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	tx.sta = sta;
 	tx.key = fast_tx->key;
 
-	if (ieee80211_queue_skb(local, sdata, sta, skb))
-		return;
-
-	tx.skb = skb;
-	r = ieee80211_xmit_fast_finish(sdata, sta, fast_tx->pn_offs,
-				       fast_tx->key, &tx);
-	tx.skb = NULL;
-	if (r == TX_DROP)
-		goto free;
-
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
-		sdata = container_of(sdata->bss,
-				     struct ieee80211_sub_if_data, u.ap);
-
-	__skb_queue_tail(&tx.skbs, skb);
-	ieee80211_tx_frags(local, &sdata->vif, sta, &tx.skbs, false);
+	ieee80211_queue_skb(local, sdata, sta, skb);
 	return;
 
 free:
@@ -4522,65 +4385,6 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-
-
-static bool __ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
-				struct sk_buff *skb, struct sta_info *sta,
-				bool txpending)
-{
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_tx_control control = {};
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_sta *pubsta = NULL;
-	unsigned long flags;
-	int q = info->hw_queue;
-
-	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-
-	if (local->queue_stop_reasons[q] ||
-	    (!txpending && !skb_queue_empty(&local->pending[q]))) {
-		if (txpending)
-			skb_queue_head(&local->pending[q], skb);
-		else
-			skb_queue_tail(&local->pending[q], skb);
-
-		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
-
-		return false;
-	}
-
-	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
-
-	if (sta && sta->uploaded)
-		pubsta = &sta->sta;
-
-	control.sta = pubsta;
-
-	drv_tx(local, &control, skb);
-
-	return true;
-}
-
-static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
-			      struct sk_buff *skb, struct sta_info *sta,
-			      bool txpending)
-{
-	struct ieee80211_local *local = sdata->local;
-	struct sk_buff *next;
-	bool ret = true;
-
-	if (ieee80211_queue_skb(local, sdata, sta, skb))
-		return true;
-
-	skb_list_walk_safe(skb, skb, next) {
-		skb_mark_not_on_list(skb);
-		if (!__ieee80211_tx_8023(sdata, skb, sta, txpending))
-			ret = false;
-	}
-
-	return ret;
-}
-
 static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				struct net_device *dev, struct sta_info *sta,
 				struct ieee80211_key *key, struct sk_buff *skb)
@@ -4659,8 +4463,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	sta->deflink.tx_stats.bytes[queue] += len;
 
 	ieee80211_tpt_led_trig_tx(local, len);
-
-	ieee80211_tx_8023(sdata, skb, sta, false);
+	ieee80211_queue_skb(local, sdata, sta, skb);
 
 	return;
 
@@ -4767,19 +4570,13 @@ void ieee80211_clear_tx_pending(struct ieee80211_local *local)
 	}
 }
 
-/*
- * Returns false if the frame couldn't be transmitted but was queued instead,
- * which in this case means re-queued -- take as an indication to stop sending
- * more pending frames.
- */
-static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
+static void ieee80211_tx_pending_skb(struct ieee80211_local *local,
 				     struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_sub_if_data *sdata;
 	struct sta_info *sta;
 	struct ieee80211_hdr *hdr;
-	bool result;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
 	sdata = vif_to_sdata(info->control.vif);
@@ -4791,34 +4588,25 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 				rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 			if (unlikely(!chanctx_conf)) {
 				dev_kfree_skb(skb);
-				return true;
+				return;
 			}
 			info->band = chanctx_conf->def.chan->band;
 		}
-		result = ieee80211_tx(sdata, NULL, skb, true);
+		ieee80211_tx(sdata, NULL, skb);
 	} else if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
 		if (ieee80211_lookup_ra_sta(sdata, skb, &sta)) {
 			dev_kfree_skb(skb);
-			return true;
+			return;
 		}
 
 		if (IS_ERR(sta) || (sta && !sta->uploaded))
 			sta = NULL;
 
-		result = ieee80211_tx_8023(sdata, skb, sta, true);
+		ieee80211_queue_skb(local, sdata, sta, skb);
 	} else {
-		struct sk_buff_head skbs;
-
-		__skb_queue_head_init(&skbs);
-		__skb_queue_tail(&skbs, skb);
-
-		hdr = (struct ieee80211_hdr *)skb->data;
 		sta = sta_info_get(sdata, hdr->addr1);
-
-		result = __ieee80211_tx(local, &skbs, sta, true);
+		ieee80211_tx(sdata, sta, skb);
 	}
-
-	return result;
 }
 
 /*
@@ -4830,7 +4618,6 @@ void ieee80211_tx_pending(struct tasklet_struct *t)
 						     tx_pending_tasklet);
 	unsigned long flags;
 	int i;
-	bool txok;
 
 	rcu_read_lock();
 
@@ -4856,11 +4643,9 @@ void ieee80211_tx_pending(struct tasklet_struct *t)
 			spin_unlock_irqrestore(&local->queue_stop_reason_lock,
 						flags);
 
-			txok = ieee80211_tx_pending_skb(local, skb);
+			ieee80211_tx_pending_skb(local, skb);
 			spin_lock_irqsave(&local->queue_stop_reason_lock,
 					  flags);
-			if (!txok)
-				break;
 		}
 	}
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ef3a2ddd7bfe..28ea791ef41d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -353,8 +353,6 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 
 	if (WARN_ON(!sdata))
 		goto out;
-	if (!test_bit(SDATA_STATE_RUNNING, &sdata->state))
-		goto out;
 
 	sdata = ieee80211_get_tx_sdata(sdata);
 	vif = &sdata->vif;
@@ -429,6 +427,9 @@ _ieee80211_wake_txqs(struct ieee80211_local *local, unsigned long *flags)
 			for (ac = 0; ac < n_acs; ac++) {
 				int ac_queue = sdata->vif.hw_queue[ac];
 
+				if (unlikely(!ieee80211_sdata_running(sdata)))
+					continue;
+
 				if (ac_queue == i ||
 				    sdata->vif.cab_queue == i)
 					__ieee80211_wake_txqs(sdata, ac);
@@ -1190,8 +1191,13 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 
 		if (sdata->vif.type != NL80211_IFTYPE_STATION ||
 		    !(sdata->u.mgd.flags & IEEE80211_STA_MFP_ENABLED))
+			/*
+			 * Use offchannel txq and tx to avoid raceing
+			 * the frame with tearing down sta txq's
+			 */
 			IEEE80211_SKB_CB(skb)->flags |=
-				IEEE80211_TX_INTFL_DONT_ENCRYPT;
+				IEEE80211_TX_INTFL_DONT_ENCRYPT |
+				IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
 
 		ieee80211_tx_skb(sdata, skb);
 	}
-- 
2.48.1


