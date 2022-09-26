Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41C5EADA7
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIZRIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiIZRIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 13:08:25 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E243BF40
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 09:15:07 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1664208904;
        bh=mtHj3+B+5onUJn58/XUVvOpeW8V1xFntl9b7uwAndwY=;
        h=From:To:Cc:Subject:Date;
        b=Du6jMt6neGJqR/JWJYIuhSLqKj8i5sWfMuRPVrtfmaqB1Bjk4L13Dh4UZcxShHABr
         douxZRREmjU6xyAuGFmtRTQ6I/ZBEWAkOHYgjhZ/teZh1lyn/xVF3UzHL6glTBVH8C
         dqePxrE14XLC4o+F9krwVFbfhNz+yr10ETlB4IRY=
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
Date:   Mon, 26 Sep 2022 18:13:03 +0200
Message-Id: <20220926161303.13035-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.37.3
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

Align TX handling and use mac80211 internal TX queues (iTXQs) for
drivers not implementing the optional .wake_tx_queue operation.

mac80211 will handle the iTXQs and push frames via the drv_tx operation
when a driver is not implementing .wake_tx_queue.

As a side effect this converts all netdev interfaces created by mac80211
to be non-queuing (using qdisc noqueue).

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

This is the fleshed out and tested version of the RFC
https://patchwork.kernel.org/project/linux-wireless/patch/20220707143230.21686-1-alexander@wetzel-home.de/

The patch here depends on the following - so far not merged - standalone fixes:

- mac80211: Ensure vif queues are operational after start
  https://patchwork.kernel.org/project/linux-wireless/patch/20220915130946.302803-1-alexander@wetzel-home.de/

- mac80211: Fix deadlock: Don't start TX while holding fq->lock
  https://patchwork.kernel.org/project/linux-wireless/patch/20220915124120.301918-1-alexander@wetzel-home.de/

- wifi: mac80211: netdev compatible TX stop for iTXQ drivers
  https://patchwork.kernel.org/project/linux-wireless/patch/20220920155541.2942-1-alexander@wetzel-home.de/

Especially the first patch is crucial. (According to my tests it's
basically unusable without it.) hwsim is also badly affected by that
bug and many hostapd and lkp tests will fail without it.

The second patch is less critical. But without it some hostap
tests will trigger a deadlock frequent enough to prevent a full run to
run through.

The last patch finally should only cause a simple to solve merge
conflict when not applied.

I did test this patch with the hostapd hwsim tests and to a lesser
extend also with the lkp-tests.
I'm also using it for some weeks now on my main workstation with iwldvm
and confirmed it works with a rt2x00usb stick.

A short look at the in-tree drivers seems to confirm, that mac80211
drivers are indeed not directly calling netif_stop_queue(). Which is no
longer undesired but outright wrong after this patch.
So I *think* we should be fine on that front, too.

I did not try very hard to identify now obsolete code fragments and kept
this as simple as possible.

I've also have a rough draft to move PS (multicast and unicast) to iTXQ
we should look at later. That seems to be way more invasive than what we
do here. But once PS also has been sorted out moving everything to iTXQ
should be straight forward.

Alexander
---
 include/net/mac80211.h        |  30 ++++-----
 net/mac80211/cfg.c            |   3 -
 net/mac80211/debugfs.c        |   4 +-
 net/mac80211/debugfs_netdev.c |   3 +-
 net/mac80211/debugfs_sta.c    |   6 +-
 net/mac80211/driver-ops.h     |  14 +----
 net/mac80211/ieee80211_i.h    |   2 +-
 net/mac80211/iface.c          |  69 +-------------------
 net/mac80211/main.c           |   9 +--
 net/mac80211/sta_info.c       |  28 ++++-----
 net/mac80211/tdls.c           |   1 -
 net/mac80211/trace.h          |  62 +++++++++---------
 net/mac80211/tx.c             |  27 ++------
 net/mac80211/util.c           | 115 +++++++++++++++++++---------------
 net/mac80211/wme.c            |  57 +----------------
 net/mac80211/wme.h            |   4 +-
 16 files changed, 142 insertions(+), 292 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac2bad57933f..22828aecc7aa 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -89,15 +89,17 @@
 /**
  * DOC: mac80211 software tx queueing
  *
- * mac80211 provides an optional intermediate queueing implementation designed
- * to allow the driver to keep hardware queues short and provide some fairness
- * between different stations/interfaces.
- * In this model, the driver pulls data frames from the mac80211 queue instead
- * of letting mac80211 push them via drv_tx().
- * Other frames (e.g. control or management) are still pushed using drv_tx().
+ * mac80211 uses an intermediate queueing implementation, designed to allow the
+ * driver to keep hardware queues short and to provide some fairness between
+ * different stations/interfaces.
  *
- * Drivers indicate that they use this model by implementing the .wake_tx_queue
- * driver operation.
+ * mac80211 is not yet using the intermediate queues consequently. Especially
+ * some non-data frames are often bypassing them and are directly pushed via
+ * drv_tx().
+ *
+ * Drivers can directly work with the mac80211 queues by implementing the
+ * optional .wake_tx_queue driver operation or let mac80211 manage the queues
+ * and simply transmit the frames mac80211 hands over via drv_tx().
  *
  * Intermediate queues (struct ieee80211_txq) are kept per-sta per-tid, with
  * another per-sta for non-data/non-mgmt and bufferable management frames, and
@@ -1826,7 +1828,7 @@ struct ieee80211_vif_cfg {
  *	for this interface.
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void \*).
- * @txq: the multicast data TX queue (if driver uses the TXQ abstraction)
+ * @txq: the multicast data TX queue
  * @txqs_stopped: per AC flag to indicate that intermediate TXQs are stopped,
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
@@ -5691,7 +5693,7 @@ void ieee80211_key_replay(struct ieee80211_key_conf *keyconf);
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  * @queue: queue number (counted from zero).
  *
- * Drivers should use this function instead of netif_wake_queue.
+ * Drivers must use this function instead of netif_wake_queue.
  */
 void ieee80211_wake_queue(struct ieee80211_hw *hw, int queue);
 
@@ -5700,7 +5702,7 @@ void ieee80211_wake_queue(struct ieee80211_hw *hw, int queue);
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  * @queue: queue number (counted from zero).
  *
- * Drivers should use this function instead of netif_stop_queue.
+ * Drivers must use this function instead of netif_stop_queue.
  */
 void ieee80211_stop_queue(struct ieee80211_hw *hw, int queue);
 
@@ -5709,7 +5711,7 @@ void ieee80211_stop_queue(struct ieee80211_hw *hw, int queue);
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  * @queue: queue number (counted from zero).
  *
- * Drivers should use this function instead of netif_stop_queue.
+ * Drivers must use this function instead of netif_stop_queue.
  *
  * Return: %true if the queue is stopped. %false otherwise.
  */
@@ -5720,7 +5722,7 @@ int ieee80211_queue_stopped(struct ieee80211_hw *hw, int queue);
  * ieee80211_stop_queues - stop all queues
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  *
- * Drivers should use this function instead of netif_stop_queue.
+ * Drivers must use this function instead of netif_stop_queue.
  */
 void ieee80211_stop_queues(struct ieee80211_hw *hw);
 
@@ -5728,7 +5730,7 @@ void ieee80211_stop_queues(struct ieee80211_hw *hw);
  * ieee80211_wake_queues - wake all queues
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  *
- * Drivers should use this function instead of netif_wake_queue.
+ * Drivers must use this function instead of netif_wake_queue.
  */
 void ieee80211_wake_queues(struct ieee80211_hw *hw);
 
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
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 81e40b0a3b16..27b1dcff91c2 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1179,18 +1179,6 @@ drv_tdls_recv_channel_switch(struct ieee80211_local *local,
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
 
@@ -1198,7 +1186,7 @@ static inline void schedule_and_wake_txq(struct ieee80211_local *local,
 					 struct txq_info *txqi)
 {
 	ieee80211_schedule_txq(&local->hw, &txqi->txq);
-	drv_wake_tx_queue(local, txqi);
+	wake_tx_queue(local, txqi);
 }
 
 static inline int drv_can_aggregate_in_amsdu(struct ieee80211_local *local,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4e1d4c339f2d..9bd43395e378 100644
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
@@ -2341,6 +2340,7 @@ void ieee80211_txq_remove_vlan(struct ieee80211_local *local,
 void ieee80211_fill_txq_stats(struct cfg80211_txq_stats *txqstats,
 			      struct txq_info *txqi);
 void ieee80211_wake_txqs(struct tasklet_struct *t);
+void wake_tx_queue(struct ieee80211_local *local, struct txq_info *txq);
 void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 			 u16 transaction, u16 auth_alg, u16 status,
 			 const u8 *extra, size_t extra_len, const u8 *bssid,
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
index 46f3eddc2388..fbf9f36a1106 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
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
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cebfd148bb40..004b23c0baba 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -527,6 +527,8 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_hw *hw = &local->hw;
 	struct sta_info *sta;
+	void *txq_data;
+	int size;
 	int i;
 
 	sta = kzalloc(sizeof(*sta) + hw->sta_data_size, gfp);
@@ -596,21 +598,18 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
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
@@ -2445,7 +2444,7 @@ static void sta_set_tidstats(struct sta_info *sta,
 		tidstats->tx_msdu_failed = sta->deflink.status_stats.msdu_failed[tid];
 	}
 
-	if (local->ops->wake_tx_queue && tid < IEEE80211_NUM_TIDS) {
+	if (tid < IEEE80211_NUM_TIDS) {
 		spin_lock_bh(&local->fq.lock);
 		rcu_read_lock();
 
@@ -2773,9 +2772,6 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 
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
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9f4377566c42..cde169038429 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2301,37 +2301,6 @@ TRACE_EVENT(drv_tdls_recv_channel_switch,
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
@@ -3026,6 +2995,37 @@ TRACE_EVENT(stop_queue,
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
index 48deda3570a7..f4dc1ddbe2ea 100644
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
 
@@ -5945,7 +5926,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (!IS_ERR(sta)) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
+		u16 queue = ieee80211_select_queue(sdata, sta, skb);
 
 		skb_set_queue_mapping(skb, queue);
 		skb_get_hash(skb);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bf7461c41bef..b2431fa5283b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -288,6 +288,64 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_ctstoself_duration);
 
+static void wake_tx_push_queue(struct ieee80211_local *local,
+			       struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_txq *queue)
+{
+	int q = sdata->vif.hw_queue[queue->ac];
+	struct ieee80211_tx_control control = {};
+	struct sk_buff *skb;
+	unsigned long flags;
+	bool q_stopped;
+
+	control.sta = queue->sta;
+
+	while (1) {
+		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
+		q_stopped = local->queue_stop_reasons[q];
+		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
+
+		if (q_stopped)
+			break;
+
+		skb = ieee80211_tx_dequeue(&local->hw, queue);
+		if (!skb)
+			break;
+
+		drv_tx(local, &control, skb);
+	}
+}
+
+void wake_tx_queue(struct ieee80211_local *local, struct txq_info *txq)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->txq.vif);
+	struct ieee80211_txq *queue;
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
+	while ((queue = ieee80211_next_txq(&local->hw, txq->txq.ac))) {
+		wake_tx_push_queue(local, sdata, queue);
+		ieee80211_return_txq(&local->hw, queue, false);
+	}
+	ieee80211_txq_schedule_end(&local->hw, txq->txq.ac);
+}
+
 static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -329,7 +387,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 				continue;
 
 			spin_unlock(&fq->lock);
-			drv_wake_tx_queue(local, txqi);
+			wake_tx_queue(local, txqi);
 			spin_lock(&fq->lock);
 		}
 	}
@@ -345,7 +403,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 
 	spin_unlock(&fq->lock);
 
-	drv_wake_tx_queue(local, txqi);
+	wake_tx_queue(local, txqi);
 	local_bh_enable();
 	return;
 out:
@@ -400,39 +458,6 @@ void ieee80211_wake_txqs(struct tasklet_struct *t)
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
@@ -463,11 +488,7 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
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
@@ -477,12 +498,10 @@ static void __ieee80211_wake_queue(struct ieee80211_hw *hw, int queue,
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
@@ -539,10 +558,6 @@ static void __ieee80211_stop_queue(struct ieee80211_hw *hw, int queue,
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
index ecc1de2e68a5..09a1fdd09a12 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -141,8 +141,8 @@ u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 	return ieee80211_downgrade_queue(sdata, NULL, skb);
 }
 
-u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
-			     struct sta_info *sta, struct sk_buff *skb)
+u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
+			   struct sta_info *sta, struct sk_buff *skb)
 {
 	struct mac80211_qos_map *qos_map;
 	bool qos;
@@ -176,59 +176,6 @@ u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
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

