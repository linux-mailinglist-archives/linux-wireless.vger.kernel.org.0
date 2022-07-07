Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91956A59E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jul 2022 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiGGOii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jul 2022 10:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiGGOif (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jul 2022 10:38:35 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 07:38:31 PDT
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11DE812609
        for <linux-wireless@vger.kernel.org>; Thu,  7 Jul 2022 07:38:29 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1657204372;
        bh=PUBygPeNFW3dTOVZs63UIAxEagJkQth/zUFpwHgnhsA=;
        h=From:To:Cc:Subject:Date;
        b=s15yfhcR+PGTKvUvz+yA7v7uOd1KIwht06BvCQqfyeJfEzAHgUfLsCpZer19GQRba
         fYRSyZI8ANytmyu9ep6j6YUfh4nrIjFzka5sB26MQCsdsQ6SHA42aEN69OkbldhRAW
         fLENy5HbIQITOHSiu7sCRUQ+nFEqDL0dBOCJz/q0=
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [RFC] mac80211: Switch all drivers over to iTXQs
Date:   Thu,  7 Jul 2022 16:32:30 +0200
Message-Id: <20220707143230.21686-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a generic wake_tx_queue handler for iTXQs in mac80211 and use it
for drivers without native iTXQ support.
This allows us to drop support for the push API in mac80211 and reduce
the complexity.
Drivers with qdisc queues will lose those.

Some drivers may encounter issues due to the changed traffic pattern
from using iTXQs.

The logic for the mac80211 wake_tx_queue call is based on the ath9k
wake_tx_queue handler.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
--

I finally looked into the generic mac80211 iTXQ support. Looks quite
simple, just hard to predict how all the drivers will react to it.

This patch is working for at least iwldvm. It exposes what seems to
be an existing iwldvm driver bug, though. Driver and card continues
to work, making that a minor side show for now. (I started to look into
that a bit, maybe more about that in another mail later.)
Initial tests are indicating comparable speeds in my setup for iwldvm,
maybe trending to be a bit slower.

For now I'm interested what I may have missed or what should be done
differently, so we dare to merge it. I'll planning to run some more
tests and use iwldvm with this patch on my main workstation for some
days at least.

Alexander
---
 net/mac80211/cfg.c            |  3 --
 net/mac80211/debugfs.c        |  4 +--
 net/mac80211/debugfs_netdev.c |  3 +-
 net/mac80211/debugfs_sta.c    |  6 ++--
 net/mac80211/driver-ops.h     | 14 +-------
 net/mac80211/ieee80211_i.h    |  1 +
 net/mac80211/iface.c          | 29 ++++------------
 net/mac80211/main.c           |  9 ++---
 net/mac80211/sta_info.c       | 28 +++++++---------
 net/mac80211/trace.h          | 62 +++++++++++++++++------------------
 net/mac80211/tx.c             | 22 ++-----------
 net/mac80211/util.c           | 38 +++++++++++++++++++--
 net/mac80211/wme.c            | 52 +++--------------------------
 13 files changed, 102 insertions(+), 169 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 64801ab545c1..62b0e31ef304 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4176,9 +4176,6 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata;
 	int ret = 0;
 
-	if (!local->ops->wake_tx_queue)
-		return 1;
-
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 4d4341249759..432ed1985bb8 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -662,9 +662,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD_MODE(force_tx_status, 0600);
 	DEBUGFS_ADD_MODE(aql_enable, 0600);
 	DEBUGFS_ADD(aql_pending);
-
-	if (local->ops->wake_tx_queue)
-		DEBUGFS_ADD_MODE(aqm, 0600);
+	DEBUGFS_ADD_MODE(aqm, 0600);
 
 	DEBUGFS_ADD_MODE(airtime_flags, 0600);
 
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index ead917501d6c..e713a3f08872 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -653,8 +653,7 @@ static void add_common_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD(rc_rateidx_vht_mcs_mask_5ghz);
 	DEBUGFS_ADD(hw_queues);
 
-	if (sdata->local->ops->wake_tx_queue &&
-	    sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
+	if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
 	    sdata->vif.type != NL80211_IFTYPE_NAN)
 		DEBUGFS_ADD(aqm);
 }
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index d3397c1248d3..53005b09f632 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1056,10 +1056,8 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 	DEBUGFS_ADD_COUNTER(rx_fragments, deflink.rx_stats.fragments);
 	DEBUGFS_ADD_COUNTER(tx_filtered, deflink.status_stats.filtered);
 
-	if (local->ops->wake_tx_queue) {
-		DEBUGFS_ADD(aqm);
-		DEBUGFS_ADD(airtime);
-	}
+	DEBUGFS_ADD(aqm);
+	DEBUGFS_ADD(airtime);
 
 	if (wiphy_ext_feature_isset(local->hw.wiphy,
 				    NL80211_EXT_FEATURE_AQL))
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index db38c8cc9d8f..d97b52b4cfc7 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1245,18 +1245,6 @@ drv_tdls_recv_channel_switch(struct ieee80211_local *local,
 static inline void drv_wake_tx_queue(struct ieee80211_local *local,
 				     struct txq_info *txq)
 {
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->txq.vif);
-
-	/* In reconfig don't transmit now, but mark for waking later */
-	if (local->in_reconfig) {
-		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txq->flags);
-		return;
-	}
-
-	if (!check_sdata_in_driver(sdata))
-		return;
-
-	trace_drv_wake_tx_queue(local, sdata, txq);
 	local->ops->wake_tx_queue(&local->hw, &txq->txq);
 }
 
@@ -1264,7 +1252,7 @@ static inline void schedule_and_wake_txq(struct ieee80211_local *local,
 					 struct txq_info *txqi)
 {
 	ieee80211_schedule_txq(&local->hw, &txqi->txq);
-	drv_wake_tx_queue(local, txqi);
+	wake_tx_queue(local, txqi);
 }
 
 static inline int drv_can_aggregate_in_amsdu(struct ieee80211_local *local,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f08060a36ef2..33b7a4275915 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2220,6 +2220,7 @@ void ieee80211_txq_remove_vlan(struct ieee80211_local *local,
 void ieee80211_fill_txq_stats(struct cfg80211_txq_stats *txqstats,
 			      struct txq_info *txqi);
 void ieee80211_wake_txqs(struct tasklet_struct *t);
+void wake_tx_queue(struct ieee80211_local *local, struct txq_info *txq);
 void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 			 u16 transaction, u16 auth_alg, u16 status,
 			 const u8 *extra, size_t extra_len, const u8 *bssid,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d5e904bff624..1a96b6d6a1a9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1411,8 +1411,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	ieee80211_recalc_ps(local);
 
 	if (sdata->vif.type == NL80211_IFTYPE_MONITOR ||
-	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-	    local->ops->wake_tx_queue) {
+	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
 		/* XXX: for AP_VLAN, actually track AP queues */
 		if (dev)
 			netif_tx_start_all_queues(dev);
@@ -1466,17 +1465,12 @@ static void ieee80211_if_setup(struct net_device *dev)
 {
 	ether_setup(dev);
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->netdev_ops = &ieee80211_dataif_ops;
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = ieee80211_if_free;
 }
 
-static void ieee80211_if_setup_no_queue(struct net_device *dev)
-{
-	ieee80211_if_setup(dev);
-	dev->priv_flags |= IFF_NO_QUEUE;
-}
-
 static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 					struct ieee80211_sub_if_data *sdata,
 					struct sk_buff *skb)
@@ -2047,7 +2041,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	struct net_device *ndev = NULL;
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct txq_info *txqi;
-	void (*if_setup)(struct net_device *dev);
 	int ret, i;
 	int txqs = 1;
 
@@ -2072,30 +2065,22 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 				 sizeof(void *));
 		int txq_size = 0;
 
-		if (local->ops->wake_tx_queue &&
-		    type != NL80211_IFTYPE_AP_VLAN &&
+		if (type != NL80211_IFTYPE_AP_VLAN &&
 		    (type != NL80211_IFTYPE_MONITOR ||
 		     (params->flags & MONITOR_FLAG_ACTIVE)))
 			txq_size += sizeof(struct txq_info) +
 				    local->hw.txq_data_size;
 
-		if (local->ops->wake_tx_queue) {
-			if_setup = ieee80211_if_setup_no_queue;
-		} else {
-			if_setup = ieee80211_if_setup;
-			if (local->hw.queues >= IEEE80211_NUM_ACS)
-				txqs = IEEE80211_NUM_ACS;
-		}
+		if (!local->ops->wake_tx_queue &&
+		    local->hw.queues >= IEEE80211_NUM_ACS)
+			txqs = IEEE80211_NUM_ACS;
 
 		ndev = alloc_netdev_mqs(size + txq_size,
 					name, name_assign_type,
-					if_setup, txqs, 1);
+					ieee80211_if_setup, txqs, 1);
 		if (!ndev)
 			return -ENOMEM;
 
-		if (!local->ops->wake_tx_queue && local->hw.wiphy->tx_queue_len)
-			ndev->tx_queue_len = local->hw.wiphy->tx_queue_len;
-
 		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
 
 		ndev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index c34f06039dda..94ab3178741b 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -714,9 +714,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	if (!ops->set_key)
 		wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 
-	if (ops->wake_tx_queue)
-		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_TXQS);
-
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_TXQS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_RRM);
 
 	wiphy->bss_priv_size = sizeof(struct ieee80211_bss);
@@ -829,10 +827,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 		atomic_set(&local->agg_queue_stop[i], 0);
 	}
 	tasklet_setup(&local->tx_pending_tasklet, ieee80211_tx_pending);
-
-	if (ops->wake_tx_queue)
-		tasklet_setup(&local->wake_txqs_tasklet, ieee80211_wake_txqs);
-
+	tasklet_setup(&local->wake_txqs_tasklet, ieee80211_wake_txqs);
 	tasklet_setup(&local->tasklet, ieee80211_tasklet_handler);
 
 	skb_queue_head_init(&local->skb_queue);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index c9852f71e8e1..602f910aafce 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -472,6 +472,8 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_hw *hw = &local->hw;
 	struct sta_info *sta;
+	void *txq_data;
+	int size;
 	int i;
 
 	sta = kzalloc(sizeof(*sta) + hw->sta_data_size, gfp);
@@ -539,21 +541,18 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
 	sta->last_connected = ktime_get_seconds();
 
-	if (local->ops->wake_tx_queue) {
-		void *txq_data;
-		int size = sizeof(struct txq_info) +
-			   ALIGN(hw->txq_data_size, sizeof(void *));
+	size = sizeof(struct txq_info) +
+	       ALIGN(hw->txq_data_size, sizeof(void *));
 
-		txq_data = kcalloc(ARRAY_SIZE(sta->sta.txq), size, gfp);
-		if (!txq_data)
-			goto free;
+	txq_data = kcalloc(ARRAY_SIZE(sta->sta.txq), size, gfp);
+	if (!txq_data)
+		goto free;
 
-		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
-			struct txq_info *txq = txq_data + i * size;
+	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
+		struct txq_info *txq = txq_data + i * size;
 
-			/* might not do anything for the bufferable MMPDU TXQ */
-			ieee80211_txq_init(sdata, sta, txq, i);
-		}
+		/* might not do anything for the bufferable MMPDU TXQ */
+		ieee80211_txq_init(sdata, sta, txq, i);
 	}
 
 	if (sta_prepare_rate_control(local, sta, gfp))
@@ -2345,7 +2344,7 @@ static void sta_set_tidstats(struct sta_info *sta,
 		tidstats->tx_msdu_failed = sta->deflink.status_stats.msdu_failed[tid];
 	}
 
-	if (local->ops->wake_tx_queue && tid < IEEE80211_NUM_TIDS) {
+	if (tid < IEEE80211_NUM_TIDS) {
 		spin_lock_bh(&local->fq.lock);
 		rcu_read_lock();
 
@@ -2671,9 +2670,6 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 
 static void sta_update_codel_params(struct sta_info *sta, u32 thr)
 {
-	if (!sta->sdata->local->ops->wake_tx_queue)
-		return;
-
 	if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {
 		sta->cparams.target = MS2TIME(50);
 		sta->cparams.interval = MS2TIME(300);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index f96e7cdca4c2..0a22321ce067 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2300,37 +2300,6 @@ TRACE_EVENT(drv_tdls_recv_channel_switch,
 	)
 );
 
-TRACE_EVENT(drv_wake_tx_queue,
-	TP_PROTO(struct ieee80211_local *local,
-		 struct ieee80211_sub_if_data *sdata,
-		 struct txq_info *txq),
-
-	TP_ARGS(local, sdata, txq),
-
-	TP_STRUCT__entry(
-		LOCAL_ENTRY
-		VIF_ENTRY
-		STA_ENTRY
-		__field(u8, ac)
-		__field(u8, tid)
-	),
-
-	TP_fast_assign(
-		struct ieee80211_sta *sta = txq->txq.sta;
-
-		LOCAL_ASSIGN;
-		VIF_ASSIGN;
-		STA_ASSIGN;
-		__entry->ac = txq->txq.ac;
-		__entry->tid = txq->txq.tid;
-	),
-
-	TP_printk(
-		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " ac:%d tid:%d",
-		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->ac, __entry->tid
-	)
-);
-
 TRACE_EVENT(drv_get_ftm_responder_stats,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
@@ -3025,6 +2994,37 @@ TRACE_EVENT(stop_queue,
 	)
 );
 
+TRACE_EVENT(wake_tx_queue,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct txq_info *txq),
+
+	TP_ARGS(local, sdata, txq),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__field(u8, ac)
+		__field(u8, tid)
+	),
+
+	TP_fast_assign(
+		struct ieee80211_sta *sta = txq->txq.sta;
+
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_ASSIGN;
+		__entry->ac = txq->txq.ac;
+		__entry->tid = txq->txq.tid;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " ac:%d tid:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->ac, __entry->tid
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b58c85abcb1b..ae320d4ac4e6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1553,9 +1553,6 @@ int ieee80211_txq_setup_flows(struct ieee80211_local *local)
 	bool supp_vht = false;
 	enum nl80211_band band;
 
-	if (!local->ops->wake_tx_queue)
-		return 0;
-
 	ret = fq_init(fq, 4096);
 	if (ret)
 		return ret;
@@ -1603,9 +1600,6 @@ void ieee80211_txq_teardown_flows(struct ieee80211_local *local)
 {
 	struct fq *fq = &local->fq;
 
-	if (!local->ops->wake_tx_queue)
-		return;
-
 	kfree(local->cvars);
 	local->cvars = NULL;
 
@@ -1622,8 +1616,7 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
 	struct ieee80211_vif *vif;
 	struct txq_info *txqi;
 
-	if (!local->ops->wake_tx_queue ||
-	    sdata->vif.type == NL80211_IFTYPE_MONITOR)
+	if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
 		return false;
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
@@ -4070,12 +4063,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	if (IS_ERR(sta))
 		sta = NULL;
 
-	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
-
+	skb_set_queue_mapping(skb, __ieee80211_select_queue(sdata, sta, skb));
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
@@ -4331,11 +4319,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
-	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
+	skb_set_queue_mapping(skb, __ieee80211_select_queue(sdata, sta, skb));
 
 	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
 	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index edd11ad892b7..8df2da148f4f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -288,6 +288,40 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_ctstoself_duration);
 
+void wake_tx_queue(struct ieee80211_local *local, struct txq_info *txq)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->txq.vif);
+	struct ieee80211_tx_control control = {};
+	struct ieee80211_txq *queue;
+	struct sk_buff *skb;
+
+	/* In reconfig don't transmit now, but mark for waking later */
+	if (local->in_reconfig) {
+		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txq->flags);
+		return;
+	}
+
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	trace_wake_tx_queue(local, sdata, txq);
+
+	if (local->ops->wake_tx_queue) {
+		drv_wake_tx_queue(local, txq);
+		return;
+	}
+
+	/* Driver has no native support for iTXQ, handle the queues */
+	ieee80211_txq_schedule_start(&local->hw, txq->txq.ac);
+	while ((queue = ieee80211_next_txq(&local->hw, txq->txq.ac)) != NULL) {
+		control.sta = queue->sta;
+		while ((skb = ieee80211_tx_dequeue(&local->hw, queue)))
+			drv_tx(local, &control, skb);
+		ieee80211_return_txq(&local->hw, queue, false);
+	}
+	ieee80211_txq_schedule_end(&local->hw, txq->txq.ac);
+}
+
 static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -329,7 +363,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 				continue;
 
 			spin_unlock(&fq->lock);
-			drv_wake_tx_queue(local, txqi);
+			wake_tx_queue(local, txqi);
 			spin_lock(&fq->lock);
 		}
 	}
@@ -345,7 +379,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 
 	spin_unlock(&fq->lock);
 
-	drv_wake_tx_queue(local, txqi);
+	wake_tx_queue(local, txqi);
 	local_bh_enable();
 	return;
 out:
diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index fc36c8e9d1d2..97cd7d56dc21 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -177,56 +177,14 @@ u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 }
 
 
-/* Indicate which queue to use. */
 u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 			   struct sk_buff *skb)
 {
-	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta = NULL;
-	const u8 *ra = NULL;
-	u16 ret;
-
-	/* when using iTXQ, we can do this later */
-	if (local->ops->wake_tx_queue)
-		return 0;
-
-	if (local->hw.queues < IEEE80211_NUM_ACS || skb->len < 6) {
-		skb->priority = 0; /* required for correct WPA/11i MIC */
-		return 0;
-	}
-
-	rcu_read_lock();
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_AP_VLAN:
-		sta = rcu_dereference(sdata->u.vlan.sta);
-		if (sta)
-			break;
-		fallthrough;
-	case NL80211_IFTYPE_AP:
-		ra = skb->data;
-		break;
-	case NL80211_IFTYPE_STATION:
-		/* might be a TDLS station */
-		sta = sta_info_get(sdata, skb->data);
-		if (sta)
-			break;
-
-		ra = sdata->deflink.u.mgd.bssid;
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		ra = skb->data;
-		break;
-	default:
-		break;
-	}
-
-	if (!sta && ra && !is_multicast_ether_addr(ra))
-		sta = sta_info_get(sdata, ra);
-
-	ret = __ieee80211_select_queue(sdata, sta, skb);
-
-	rcu_read_unlock();
-	return ret;
+	/* mac80211 only supports iTXQ nowadays. Only calculate the hash while
+	 * the skb is still hot in the CPU cache
+	 */
+	skb_get_hash(skb);
+	return 0;
 }
 
 /**
-- 
2.35.1

