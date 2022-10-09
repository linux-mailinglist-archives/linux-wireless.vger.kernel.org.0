Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788375F8C54
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJIQa6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJIQa4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 12:30:56 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3DCB22295
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 09:30:52 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1665333049;
        bh=b+tMDKKIzccczs3r5izk7FGksaCZP2kPUHlteCNcLzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=by4XWLUY5XG3qA+K9P17QozFA+HN/O+C4LM1pQpkiJPr/BcTkA1LuWRO23f6lkEdt
         uL5DHW6Wr5sBS0PCWk5JhBnTSfy+61JYx1s2IBqAcC1FAvL5AuK3rp49XQzBgCg9tR
         K72pyvEKGuEiIoJL6HKgO7SeP3j5isFfwrV9qpe8=
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v2 3/3] wifi: mac80211: Drop support for TX push path
Date:   Sun,  9 Oct 2022 18:30:40 +0200
Message-Id: <20221009163040.25637-3-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009163040.25637-1-alexander@wetzel-home.de>
References: <20221009163040.25637-1-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All drivers are now using mac80211 internal queues (iTXQs).
Drop mac80211 internal support for the old push path.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 net/mac80211/cfg.c            |  3 --
 net/mac80211/debugfs.c        |  4 +-
 net/mac80211/debugfs_netdev.c |  3 +-
 net/mac80211/debugfs_sta.c    |  6 +--
 net/mac80211/ieee80211_i.h    |  1 -
 net/mac80211/iface.c          | 69 ++---------------------------------
 net/mac80211/main.c           | 11 ++----
 net/mac80211/rx.c             |  3 --
 net/mac80211/sta_info.c       | 51 ++++++++++----------------
 net/mac80211/tdls.c           |  1 -
 net/mac80211/tx.c             | 28 ++------------
 net/mac80211/util.c           | 53 +++------------------------
 net/mac80211/wme.c            | 63 ++++----------------------------
 net/mac80211/wme.h            |  4 +-
 14 files changed, 48 insertions(+), 252 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 687b4c878d4a..a1e7d3a9b9fb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4338,9 +4338,6 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata;
 	int ret = 0;
 
-	if (!local->ops->wake_tx_queue)
-		return 1;
-
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 78c7d60e8667..dfb9f55e2685 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -663,9 +663,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD_MODE(force_tx_status, 0600);
 	DEBUGFS_ADD_MODE(aql_enable, 0600);
 	DEBUGFS_ADD(aql_pending);
-
-	if (local->ops->wake_tx_queue)
-		DEBUGFS_ADD_MODE(aqm, 0600);
+	DEBUGFS_ADD_MODE(aqm, 0600);
 
 	DEBUGFS_ADD_MODE(airtime_flags, 0600);
 
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 5b014786fd2d..c87e1137e5da 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -677,8 +677,7 @@ static void add_common_files(struct ieee80211_sub_if_data *sdata)
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
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4e1d4c339f2d..0f05f50e741b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2280,7 +2280,6 @@ void ieee80211_wake_queue_by_reason(struct ieee80211_hw *hw, int queue,
 void ieee80211_stop_queue_by_reason(struct ieee80211_hw *hw, int queue,
 				    enum queue_stop_reason reason,
 				    bool refcounted);
-void ieee80211_propagate_queue_wake(struct ieee80211_local *local, int queue);
 void ieee80211_add_pending_skb(struct ieee80211_local *local,
 			       struct sk_buff *skb);
 void ieee80211_add_pending_skbs(struct ieee80211_local *local,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 5d7f25ed7a0e..3920e30fe492 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -458,12 +458,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (cancel_scan)
 		ieee80211_scan_cancel(local);
 
-	/*
-	 * Stop TX on this interface first.
-	 */
-	if (!local->ops->wake_tx_queue && sdata->dev)
-		netif_tx_stop_all_queues(sdata->dev);
-
 	ieee80211_roc_purge(local, sdata);
 
 	switch (sdata->vif.type) {
@@ -811,13 +805,6 @@ static void ieee80211_uninit(struct net_device *dev)
 	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
 }
 
-static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-					 struct sk_buff *skb,
-					 struct net_device *sb_dev)
-{
-	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
-}
-
 static void
 ieee80211_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 {
@@ -831,7 +818,6 @@ static const struct net_device_ops ieee80211_dataif_ops = {
 	.ndo_start_xmit		= ieee80211_subif_start_xmit,
 	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
 	.ndo_set_mac_address 	= ieee80211_change_mac,
-	.ndo_select_queue	= ieee80211_netdev_select_queue,
 	.ndo_get_stats64	= ieee80211_get_stats64,
 };
 
@@ -939,7 +925,6 @@ static const struct net_device_ops ieee80211_dataif_8023_ops = {
 	.ndo_start_xmit		= ieee80211_subif_start_xmit_8023,
 	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
 	.ndo_set_mac_address	= ieee80211_change_mac,
-	.ndo_select_queue	= ieee80211_netdev_select_queue,
 	.ndo_get_stats64	= ieee80211_get_stats64,
 	.ndo_fill_forward_path	= ieee80211_netdev_fill_forward_path,
 };
@@ -1441,35 +1426,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 
 	ieee80211_recalc_ps(local);
 
-	if (sdata->vif.type == NL80211_IFTYPE_MONITOR ||
-	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-	    local->ops->wake_tx_queue) {
-		/* XXX: for AP_VLAN, actually track AP queues */
-		if (dev)
-			netif_tx_start_all_queues(dev);
-	} else if (dev) {
-		unsigned long flags;
-		int n_acs = IEEE80211_NUM_ACS;
-		int ac;
-
-		if (local->hw.queues < IEEE80211_NUM_ACS)
-			n_acs = 1;
-
-		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-		if (sdata->vif.cab_queue == IEEE80211_INVAL_HW_QUEUE ||
-		    (local->queue_stop_reasons[sdata->vif.cab_queue] == 0 &&
-		     skb_queue_empty(&local->pending[sdata->vif.cab_queue]))) {
-			for (ac = 0; ac < n_acs; ac++) {
-				int ac_queue = sdata->vif.hw_queue[ac];
-
-				if (local->queue_stop_reasons[ac_queue] == 0 &&
-				    skb_queue_empty(&local->pending[ac_queue]))
-					netif_start_subqueue(dev, ac);
-			}
-		}
-		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
-	}
-
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	return 0;
@@ -1499,17 +1455,12 @@ static void ieee80211_if_setup(struct net_device *dev)
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
@@ -2094,9 +2045,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	struct net_device *ndev = NULL;
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct txq_info *txqi;
-	void (*if_setup)(struct net_device *dev);
 	int ret, i;
-	int txqs = 1;
 
 	ASSERT_RTNL();
 
@@ -2119,30 +2068,18 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
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
-
 		ndev = alloc_netdev_mqs(size + txq_size,
 					name, name_assign_type,
-					if_setup, txqs, 1);
+					ieee80211_if_setup, 1, 1);
 		if (!ndev)
 			return -ENOMEM;
 
-		if (!local->ops->wake_tx_queue && local->hw.wiphy->tx_queue_len)
-			ndev->tx_queue_len = local->hw.wiphy->tx_queue_len;
-
 		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
 
 		ndev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 46f3eddc2388..58fe8d3b8fb0 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -630,7 +630,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	if (WARN_ON(!ops->tx || !ops->start || !ops->stop || !ops->config ||
 		    !ops->add_interface || !ops->remove_interface ||
-		    !ops->configure_filter))
+		    !ops->configure_filter || !ops->wake_tx_queue))
 		return NULL;
 
 	if (WARN_ON(ops->sta_state && (ops->sta_add || ops->sta_remove)))
@@ -719,9 +719,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	if (!ops->set_key)
 		wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 
-	if (ops->wake_tx_queue)
-		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_TXQS);
-
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_TXQS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_RRM);
 
 	wiphy->bss_priv_size = sizeof(struct ieee80211_bss);
@@ -834,10 +832,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
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
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bd215fe3c796..cd16e2a43ea9 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1571,9 +1571,6 @@ static void sta_ps_start(struct sta_info *sta)
 
 	ieee80211_clear_fast_xmit(sta);
 
-	if (!sta->sta.txq[0])
-		return;
-
 	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
 		struct ieee80211_txq *txq = sta->sta.txq[tid];
 		struct txq_info *txqi = to_txq_info(txq);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cebfd148bb40..58fd582f674f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -140,17 +140,15 @@ static void __cleanup_single_sta(struct sta_info *sta)
 		atomic_dec(&ps->num_sta_ps);
 	}
 
-	if (sta->sta.txq[0]) {
-		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
-			struct txq_info *txqi;
+	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
+		struct txq_info *txqi;
 
-			if (!sta->sta.txq[i])
-				continue;
+		if (!sta->sta.txq[i])
+			continue;
 
-			txqi = to_txq_info(sta->sta.txq[i]);
+		txqi = to_txq_info(sta->sta.txq[i]);
 
-			ieee80211_txq_purge(local, txqi);
-		}
+		ieee80211_txq_purge(local, txqi);
 	}
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
@@ -425,8 +423,7 @@ void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 
 	sta_dbg(sta->sdata, "Destroyed STA %pM\n", sta->sta.addr);
 
-	if (sta->sta.txq[0])
-		kfree(to_txq_info(sta->sta.txq[0]));
+	kfree(to_txq_info(sta->sta.txq[0]));
 	kfree(rcu_dereference_raw(sta->sta.rates));
 #ifdef CONFIG_MAC80211_MESH
 	kfree(sta->mesh);
@@ -527,6 +524,8 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_hw *hw = &local->hw;
 	struct sta_info *sta;
+	void *txq_data;
+	int size;
 	int i;
 
 	sta = kzalloc(sizeof(*sta) + hw->sta_data_size, gfp);
@@ -596,21 +595,18 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
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
+		/* might not do anything for the (bufferable) MMPDU TXQ */
+		ieee80211_txq_init(sdata, sta, txq, i);
 	}
 
 	if (sta_prepare_rate_control(local, sta, gfp))
@@ -684,8 +680,7 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	return sta;
 
 free_txq:
-	if (sta->sta.txq[0])
-		kfree(to_txq_info(sta->sta.txq[0]));
+	kfree(to_txq_info(sta->sta.txq[0]));
 free:
 	sta_info_free_link(&sta->deflink);
 #ifdef CONFIG_MAC80211_MESH
@@ -1958,9 +1953,6 @@ ieee80211_sta_ps_deliver_response(struct sta_info *sta,
 		 * TIM recalculation.
 		 */
 
-		if (!sta->sta.txq[0])
-			return;
-
 		for (tid = 0; tid < ARRAY_SIZE(sta->sta.txq); tid++) {
 			if (!sta->sta.txq[tid] ||
 			    !(driver_release_tids & BIT(tid)) ||
@@ -2445,7 +2437,7 @@ static void sta_set_tidstats(struct sta_info *sta,
 		tidstats->tx_msdu_failed = sta->deflink.status_stats.msdu_failed[tid];
 	}
 
-	if (local->ops->wake_tx_queue && tid < IEEE80211_NUM_TIDS) {
+	if (tid < IEEE80211_NUM_TIDS) {
 		spin_lock_bh(&local->fq.lock);
 		rcu_read_lock();
 
@@ -2773,9 +2765,6 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 
 static void sta_update_codel_params(struct sta_info *sta, u32 thr)
 {
-	if (!sta->sdata->local->ops->wake_tx_queue)
-		return;
-
 	if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {
 		sta->cparams.target = MS2TIME(50);
 		sta->cparams.interval = MS2TIME(300);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f4b4d25eef95..b255f3b5bf01 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1016,7 +1016,6 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 		skb->priority = 256 + 5;
 		break;
 	}
-	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb));
 
 	/*
 	 * Set the WLAN_TDLS_TEARDOWN flag to indicate a teardown in progress.
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a364148149f9..ec55159e47a5 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1599,9 +1599,6 @@ int ieee80211_txq_setup_flows(struct ieee80211_local *local)
 	bool supp_vht = false;
 	enum nl80211_band band;
 
-	if (!local->ops->wake_tx_queue)
-		return 0;
-
 	ret = fq_init(fq, 4096);
 	if (ret)
 		return ret;
@@ -1649,9 +1646,6 @@ void ieee80211_txq_teardown_flows(struct ieee80211_local *local)
 {
 	struct fq *fq = &local->fq;
 
-	if (!local->ops->wake_tx_queue)
-		return;
-
 	kfree(local->cvars);
 	local->cvars = NULL;
 
@@ -1668,8 +1662,7 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
 	struct ieee80211_vif *vif;
 	struct txq_info *txqi;
 
-	if (!local->ops->wake_tx_queue ||
-	    sdata->vif.type == NL80211_IFTYPE_MONITOR)
+	if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
 		return false;
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
@@ -4184,12 +4177,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	if (IS_ERR(sta))
 		sta = NULL;
 
-	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
-
+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
@@ -4495,11 +4483,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
-	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, sta, skb));
 
 	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
 	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
@@ -4753,9 +4737,6 @@ void ieee80211_tx_pending(struct tasklet_struct *t)
 			if (!txok)
 				break;
 		}
-
-		if (skb_queue_empty(&local->pending[i]))
-			ieee80211_propagate_queue_wake(local, i);
 	}
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
@@ -5948,10 +5929,9 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (!IS_ERR(sta)) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
+		u16 queue = ieee80211_select_queue(sdata, sta, skb);
 
 		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
 
 		/*
 		 * for MLO STA, the SA should be the AP MLD address, but
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a7f9a2b3e683..0dcf8f20c909 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -446,39 +446,6 @@ void ieee80211_wake_txqs(struct tasklet_struct *t)
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 }
 
-void ieee80211_propagate_queue_wake(struct ieee80211_local *local, int queue)
-{
-	struct ieee80211_sub_if_data *sdata;
-	int n_acs = IEEE80211_NUM_ACS;
-
-	if (local->ops->wake_tx_queue)
-		return;
-
-	if (local->hw.queues < IEEE80211_NUM_ACS)
-		n_acs = 1;
-
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		int ac;
-
-		if (!sdata->dev)
-			continue;
-
-		if (sdata->vif.cab_queue != IEEE80211_INVAL_HW_QUEUE &&
-		    local->queue_stop_reasons[sdata->vif.cab_queue] != 0)
-			continue;
-
-		for (ac = 0; ac < n_acs; ac++) {
-			int ac_queue = sdata->vif.hw_queue[ac];
-
-			if (ac_queue == queue ||
-			    (sdata->vif.cab_queue == queue &&
-			     local->queue_stop_reasons[ac_queue] == 0 &&
-			     skb_queue_empty(&local->pending[ac_queue])))
-				netif_wake_subqueue(sdata->dev, ac);
-		}
-	}
-}
-
 static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 				   enum queue_stop_reason reason,
 				   bool refcounted,
@@ -509,11 +476,7 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 		/* someone still has this queue stopped */
 		return;
 
-	if (skb_queue_empty(&local->pending[queue])) {
-		rcu_read_lock();
-		ieee80211_propagate_queue_wake(local, queue);
-		rcu_read_unlock();
-	} else
+	if (!skb_queue_empty(&local->pending[queue]))
 		tasklet_schedule(&local->tx_pending_tasklet);
 
 	/*
@@ -523,12 +486,10 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
 	 * release someone's lock, but it is fine because all the callers of
 	 * __ieee80211_wake_queue call it right before releasing the lock.
 	 */
-	if (local->ops->wake_tx_queue) {
-		if (reason == IEEE80211_QUEUE_STOP_REASON_DRIVER)
-			tasklet_schedule(&local->wake_txqs_tasklet);
-		else
-			_ieee80211_wake_txqs(local, flags);
-	}
+	if (reason == IEEE80211_QUEUE_STOP_REASON_DRIVER)
+		tasklet_schedule(&local->wake_txqs_tasklet);
+	else
+		_ieee80211_wake_txqs(local, flags);
 }
 
 void ieee80211_wake_queue_by_reason(struct ieee80211_hw *hw, int queue,
@@ -585,10 +546,6 @@ static void __ieee80211_stop_queue(struct ieee80211_hw *hw, int queue,
 		for (ac = 0; ac < n_acs; ac++) {
 			if (sdata->vif.hw_queue[ac] == queue ||
 			    sdata->vif.cab_queue == queue) {
-				if (!local->ops->wake_tx_queue) {
-					netif_stop_subqueue(sdata->dev, ac);
-					continue;
-				}
 				spin_lock(&local->fq.lock);
 				sdata->vif.txqs_stopped[ac] = true;
 				spin_unlock(&local->fq.lock);
diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index ecc1de2e68a5..a12c63638680 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -122,6 +122,9 @@ u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	u8 *p;
 
+	/* Ensure hash is set prior to potential SW encryption */
+	skb_get_hash(skb);
+
 	if ((info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER) ||
 	    local->hw.queues < IEEE80211_NUM_ACS)
 		return 0;
@@ -141,12 +144,15 @@ u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 	return ieee80211_downgrade_queue(sdata, NULL, skb);
 }
 
-u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
-			     struct sta_info *sta, struct sk_buff *skb)
+u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
+			   struct sta_info *sta, struct sk_buff *skb)
 {
 	struct mac80211_qos_map *qos_map;
 	bool qos;
 
+	/* Ensure hash is set prior to potential SW encryption */
+	skb_get_hash(skb);
+
 	/* all mesh/ocb stations are required to support WME */
 	if (sta && (sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
 		    sdata->vif.type == NL80211_IFTYPE_OCB))
@@ -176,59 +182,6 @@ u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 	return ieee80211_downgrade_queue(sdata, sta, skb);
 }
 
-
-/* Indicate which queue to use. */
-u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
-			   struct sk_buff *skb)
-{
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
-}
-
 /**
  * ieee80211_set_qos_hdr - Fill in the QoS header if there is one.
  *
diff --git a/net/mac80211/wme.h b/net/mac80211/wme.h
index 2e3dec0b6087..81f0039527a9 100644
--- a/net/mac80211/wme.h
+++ b/net/mac80211/wme.h
@@ -13,10 +13,8 @@
 u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb,
 				 struct ieee80211_hdr *hdr);
-u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
-			     struct sta_info *sta, struct sk_buff *skb);
 u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
-			   struct sk_buff *skb);
+			   struct sta_info *sta, struct sk_buff *skb);
 void ieee80211_set_qos_hdr(struct ieee80211_sub_if_data *sdata,
 			   struct sk_buff *skb);
 
-- 
2.37.3

