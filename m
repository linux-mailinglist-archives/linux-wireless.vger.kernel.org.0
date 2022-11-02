Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CA5616CB4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 19:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKBSm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiKBSm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 14:42:58 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF2191F2E9
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 11:42:54 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1667414571;
        bh=RbH3ElTXwQOYJsrnhI6HVhcwX9FDurD9328ecb/usCw=;
        h=From:To:Cc:Subject:Date;
        b=e8qxROE9JiXopAaUGcUYHSj5h5SN/cTI72W4iErEno24df5SC/A4KGxrTaCjVZH/b
         6QDpiAGFYlwNR+E24e4U9rFQqHsvAETWRGna8+4qgtLC5ga2I+nHsmEXO5eEGSVQAu
         9/ko+rcTcErX5nBfNUvfDBFNmcuXiD9TYjBnouuM=
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v2] wifi: mac80211: integrate PS buffering into iTXQ
Date:   Wed,  2 Nov 2022 19:40:05 +0100
Message-Id: <20221102184005.10649-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.38.1
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

Drop ps->bc_buf and use the mac80211 internal TX queues (iTXQs) to
buffer the frames.

New core concept is, to never wake a buffering iTXQ.
Buffering sta iTXQs get the new flag IEEE80211_TXQ_STOP_PS assigned to
suppress the normal queue wake.
The MC iTXQ is using the num_sta_ps variable to detect if it's buffering
or not. (IEEE80211_TXQ_STOP_PS is also set for the MC queue but only to
avoid - without preventing all - useless queue wakes.)

The biggest known impact this patch has is to PS debugging:
It outright drops PS debug messages and variables which simple don't
make much sense after transition PS to iTXQ.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

I found a more serious issue, so here is now v2 for "wifi: mac80211:
convert PS buffering into iTXQ",
https://patchwork.kernel.org/project/linux-wireless/patch/20221031211815.6666-1-alexander@wetzel-home.de/

V2 also changes the subject, hopefully giving a better summary what
this is all about.

Besides that, the changes compared to v1 are:
- dropped useless info->hw_queue assignment in ieee80211_tx_dequeue()
- fixed a race condition when clearing sta->txq_buffered_tids
---
 net/mac80211/cfg.c            |   4 -
 net/mac80211/debugfs.c        |   3 -
 net/mac80211/debugfs_netdev.c |   6 +-
 net/mac80211/debugfs_sta.c    |  17 ---
 net/mac80211/ieee80211_i.h    |  13 +-
 net/mac80211/iface.c          |  19 ---
 net/mac80211/mesh.c           |   5 -
 net/mac80211/mesh_ps.c        |  15 +-
 net/mac80211/rx.c             |  24 +++-
 net/mac80211/sta_info.c       | 163 +++++++++++-----------
 net/mac80211/sta_info.h       |   5 -
 net/mac80211/tx.c             | 252 ++++------------------------------
 net/mac80211/util.c           |   5 +
 13 files changed, 146 insertions(+), 385 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c848fe04dd44..0a50341c1f1f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1531,10 +1531,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	drv_stop_ap(sdata->local, sdata, link_conf);
 
-	/* free all potentially still buffered bcast frames */
-	local->total_ps_buffered -= skb_queue_len(&sdata->u.ap.ps.bc_buf);
-	ieee80211_purge_tx_queue(&local->hw, &sdata->u.ap.ps.bc_buf);
-
 	mutex_lock(&local->mtx);
 	ieee80211_link_copy_chanctx_to_vlans(link, true);
 	ieee80211_link_release_channel(link);
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index dfb9f55e2685..b15594f36e8d 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -65,8 +65,6 @@ DEBUGFS_READONLY_FILE(user_power, "%d",
 		      local->user_power_level);
 DEBUGFS_READONLY_FILE(power, "%d",
 		      local->hw.conf.power_level);
-DEBUGFS_READONLY_FILE(total_ps_buffered, "%d",
-		      local->total_ps_buffered);
 DEBUGFS_READONLY_FILE(wep_iv, "%#08x",
 		      local->wep_iv & 0xffffff);
 DEBUGFS_READONLY_FILE(rate_ctrl_alg, "%s",
@@ -648,7 +646,6 @@ void debugfs_hw_add(struct ieee80211_local *local)
 
 	local->debugfs.keys = debugfs_create_dir("keys", phyd);
 
-	DEBUGFS_ADD(total_ps_buffered);
 	DEBUGFS_ADD(wep_iv);
 	DEBUGFS_ADD(rate_ctrl_alg);
 	DEBUGFS_ADD(queues);
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index c87e1137e5da..1f43e48c392e 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -468,8 +468,10 @@ IEEE80211_IF_FILE(num_mcast_sta_vlan, u.vlan.num_mcast_sta, ATOMIC);
 static ssize_t ieee80211_if_fmt_num_buffered_multicast(
 	const struct ieee80211_sub_if_data *sdata, char *buf, int buflen)
 {
-	return scnprintf(buf, buflen, "%u\n",
-			 skb_queue_len(&sdata->u.ap.ps.bc_buf));
+	unsigned long frames;
+
+	ieee80211_txq_get_depth(sdata->vif.txq, &frames, NULL);
+	return scnprintf(buf, buflen, "%lu\n", frames);
 }
 IEEE80211_IF_FILE_R(num_buffered_multicast);
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 7a3d7893e19d..2db132ba89cd 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -103,22 +103,6 @@ static ssize_t sta_flags_read(struct file *file, char __user *userbuf,
 }
 STA_OPS(flags);
 
-static ssize_t sta_num_ps_buf_frames_read(struct file *file,
-					  char __user *userbuf,
-					  size_t count, loff_t *ppos)
-{
-	struct sta_info *sta = file->private_data;
-	char buf[17*IEEE80211_NUM_ACS], *p = buf;
-	int ac;
-
-	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-		p += scnprintf(p, sizeof(buf)+buf-p, "AC%d: %d\n", ac,
-			       skb_queue_len(&sta->ps_tx_buf[ac]) +
-			       skb_queue_len(&sta->tx_filtered[ac]));
-	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
-}
-STA_OPS(num_ps_buf_frames);
-
 static ssize_t sta_last_seq_ctrl_read(struct file *file, char __user *userbuf,
 				      size_t count, loff_t *ppos)
 {
@@ -1066,7 +1050,6 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 
 	DEBUGFS_ADD(flags);
 	DEBUGFS_ADD(aid);
-	DEBUGFS_ADD(num_ps_buf_frames);
 	DEBUGFS_ADD(last_seq_ctrl);
 	DEBUGFS_ADD(agg_status);
 	/* FIXME: Kept here as the statistics are only done on the deflink */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 63ff0d2524b6..9f278533dc6c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -42,11 +42,6 @@ struct ieee80211_local;
  * associated stations are using power saving. */
 #define AP_MAX_BC_BUFFER 128
 
-/* Maximum number of frames buffered to all STAs, including multicast frames.
- * Note: increasing this limit increases the potential memory requirement. Each
- * frame can be up to about 2 kB long. */
-#define TOTAL_MAX_TX_BUFFER 512
-
 /* Required encryption head and tailroom */
 #define IEEE80211_ENCRYPT_HEADROOM 8
 #define IEEE80211_ENCRYPT_TAILROOM 18
@@ -155,7 +150,6 @@ typedef unsigned __bitwise ieee80211_tx_result;
 #define TX_QUEUED	((__force ieee80211_tx_result) 2u)
 
 #define IEEE80211_TX_UNICAST		BIT(1)
-#define IEEE80211_TX_PS_BUFFERED	BIT(2)
 
 struct ieee80211_tx_data {
 	struct sk_buff *skb;
@@ -297,7 +291,6 @@ struct ps_data {
 	 * NB: don't touch this bitmap, use sta_info_{set,clear}_tim_bit */
 	u8 tim[sizeof(unsigned long) * BITS_TO_LONGS(IEEE80211_MAX_AID + 1)]
 			__aligned(__alignof__(unsigned long));
-	struct sk_buff_head bc_buf;
 	atomic_t num_sta_ps; /* number of stations in PS mode */
 	int dtim_count;
 	bool dtim_bc_mc;
@@ -839,6 +832,7 @@ enum txq_info_flags {
 	IEEE80211_TXQ_AMPDU,
 	IEEE80211_TXQ_NO_AMSDU,
 	IEEE80211_TXQ_STOP_NETIF_TX,
+	IEEE80211_TXQ_STOP_PS,
 };
 
 /**
@@ -1498,11 +1492,6 @@ struct ieee80211_local {
 #define I802_DEBUG_INC(c) do { } while (0)
 #endif /* CONFIG_MAC80211_DEBUG_COUNTERS */
 
-
-	int total_ps_buffered; /* total number of all buffered unicast and
-				* multicast packets for power saving stations
-				*/
-
 	bool pspolling;
 	/*
 	 * PS can only be enabled when we have exactly one managed
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7c4ce716c939..274a7c082c2e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -446,7 +446,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	struct sk_buff *skb, *tmp;
 	u32 hw_reconf_flags = 0;
 	int i, flushed;
-	struct ps_data *ps;
 	struct cfg80211_chan_def chandef;
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
@@ -551,23 +550,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 				   GFP_KERNEL);
 	}
 
-	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		WARN_ON(!list_empty(&sdata->u.ap.vlans));
-	} else if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-		/* remove all packets in parent bc_buf pointing to this dev */
-		ps = &sdata->bss->ps;
-
-		spin_lock_irqsave(&ps->bc_buf.lock, flags);
-		skb_queue_walk_safe(&ps->bc_buf, skb, tmp) {
-			if (skb->dev == sdata->dev) {
-				__skb_unlink(skb, &ps->bc_buf);
-				local->total_ps_buffered--;
-				ieee80211_free_txskb(&local->hw, skb);
-			}
-		}
-		spin_unlock_irqrestore(&ps->bc_buf.lock, flags);
-	}
-
 	if (going_down)
 		local->open_count--;
 
@@ -1732,7 +1714,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.p2p = true;
 		fallthrough;
 	case NL80211_IFTYPE_AP:
-		skb_queue_head_init(&sdata->u.ap.ps.bc_buf);
 		INIT_LIST_HEAD(&sdata->u.ap.vlans);
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5a99b8f6e465..c807bcfee5d7 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1088,10 +1088,6 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	RCU_INIT_POINTER(ifmsh->beacon, NULL);
 	kfree_rcu(bcn, rcu_head);
 
-	/* free all potentially still buffered group-addressed frames */
-	local->total_ps_buffered -= skb_queue_len(&ifmsh->ps.bc_buf);
-	skb_queue_purge(&ifmsh->ps.bc_buf);
-
 	del_timer_sync(&sdata->u.mesh.housekeeping_timer);
 	del_timer_sync(&sdata->u.mesh.mesh_path_root_timer);
 	del_timer_sync(&sdata->u.mesh.mesh_path_timer);
@@ -1635,7 +1631,6 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifmsh->mesh_path_root_timer,
 		    ieee80211_mesh_path_root_timer, 0);
 	INIT_LIST_HEAD(&ifmsh->preq_queue.list);
-	skb_queue_head_init(&ifmsh->ps.bc_buf);
 	spin_lock_init(&ifmsh->mesh_preq_queue_lock);
 	spin_lock_init(&ifmsh->sync_offset_lock);
 	RCU_INIT_POINTER(ifmsh->beacon, NULL);
diff --git a/net/mac80211/mesh_ps.c b/net/mac80211/mesh_ps.c
index 3fbd0b9ff913..c2eb6f2600ea 100644
--- a/net/mac80211/mesh_ps.c
+++ b/net/mac80211/mesh_ps.c
@@ -451,6 +451,7 @@ static void mpsp_qos_null_append(struct sta_info *sta,
 static void mps_frame_deliver(struct sta_info *sta, int n_frames)
 {
 	struct ieee80211_local *local = sta->sdata->local;
+	struct ieee80211_hw *hw = &local->hw;
 	int ac;
 	struct sk_buff_head frames;
 	struct sk_buff *skb;
@@ -462,12 +463,9 @@ static void mps_frame_deliver(struct sta_info *sta, int n_frames)
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		while (n_frames != 0) {
 			skb = skb_dequeue(&sta->tx_filtered[ac]);
-			if (!skb) {
-				skb = skb_dequeue(
-					&sta->ps_tx_buf[ac]);
-				if (skb)
-					local->total_ps_buffered--;
-			}
+			if (!skb)
+				skb = ieee80211_tx_dequeue(hw,
+							   sta->sta.txq[ac]);
 			if (!skb)
 				break;
 			n_frames--;
@@ -475,7 +473,7 @@ static void mps_frame_deliver(struct sta_info *sta, int n_frames)
 		}
 
 		if (!skb_queue_empty(&sta->tx_filtered[ac]) ||
-		    !skb_queue_empty(&sta->ps_tx_buf[ac]))
+		    txq_has_queue(sta->sta.txq[ac]))
 			more_data = true;
 	}
 
@@ -594,8 +592,7 @@ void ieee80211_mps_frame_release(struct sta_info *sta,
 
 	if (!test_sta_flag(sta, WLAN_STA_MPSP_OWNER))
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			buffer_local += skb_queue_len(&sta->ps_tx_buf[ac]) +
-					skb_queue_len(&sta->tx_filtered[ac]);
+			buffer_local += skb_queue_len(&sta->tx_filtered[ac]);
 
 	if (!has_buffered && !buffer_local)
 		return;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c28c6fbf786e..7b9933f66daa 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1554,15 +1554,29 @@ static void sta_ps_start(struct sta_info *sta)
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ps_data *ps;
+	struct txq_info *txqi;
 	int tid;
 
-	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
-	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+	if (sdata->vif.type == NL80211_IFTYPE_AP ||
+	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ps = &sdata->bss->ps;
 	else
 		return;
 
-	atomic_inc(&ps->num_sta_ps);
+	if ((atomic_inc_return(&ps->num_sta_ps) == 1) &&
+	    ieee80211_hw_check(&local->hw, HOST_BROADCAST_PS_BUFFERING)) {
+		struct ieee80211_sub_if_data *ap;
+
+		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+			ap = container_of(sdata->bss,
+					  struct ieee80211_sub_if_data, u.ap);
+		else
+			ap = sdata;
+
+		txqi = to_txq_info(ap->vif.txq);
+		set_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags);
+	}
+
 	set_sta_flag(sta, WLAN_STA_PS_STA);
 	if (!ieee80211_hw_check(&local->hw, AP_LINK_PS))
 		drv_sta_notify(local, sdata, STA_NOTIFY_SLEEP, &sta->sta);
@@ -1573,7 +1587,9 @@ static void sta_ps_start(struct sta_info *sta)
 
 	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
 		struct ieee80211_txq *txq = sta->sta.txq[tid];
-		struct txq_info *txqi = to_txq_info(txq);
+
+		txqi = to_txq_info(txq);
+		set_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags);
 
 		spin_lock(&local->active_txq_lock[txq->ac]);
 		if (!list_empty(&txqi->schedule_order))
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 04e0f132b1d9..dad3a7b6b8cb 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -114,6 +114,28 @@ static int link_sta_info_hash_del(struct ieee80211_local *local,
 			       link_sta_rht_params);
 }
 
+static void num_sta_ps_dec_for_mc_txq(struct ieee80211_sub_if_data *sdata,
+				      atomic_t *num_sta_ps)
+{
+	if (!ieee80211_hw_check(&sdata->local->hw,
+				HOST_BROADCAST_PS_BUFFERING) ||
+	    ieee80211_vif_is_mesh(&sdata->vif)) {
+		atomic_dec(num_sta_ps);
+		return;
+	}
+
+	/* We may have to stop buffering on MC txq */
+	if (atomic_dec_and_test(num_sta_ps)) {
+		struct txq_info *txqi;
+
+		txqi = to_txq_info(sdata->vif.txq);
+		clear_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags);
+
+		if (txq_has_queue(sdata->vif.txq))
+			schedule_and_wake_txq(sdata->local, txqi);
+	}
+}
+
 static void __cleanup_single_sta(struct sta_info *sta)
 {
 	int ac, i;
@@ -137,7 +159,14 @@ static void __cleanup_single_sta(struct sta_info *sta)
 		clear_sta_flag(sta, WLAN_STA_PS_DRIVER);
 		clear_sta_flag(sta, WLAN_STA_PS_DELIVER);
 
-		atomic_dec(&ps->num_sta_ps);
+		local_bh_disable();
+		rcu_read_lock();
+
+		/* can call wake_tx_queue for vif.txq */
+		num_sta_ps_dec_for_mc_txq(sdata, &ps->num_sta_ps);
+
+		rcu_read_unlock();
+		local_bh_enable();
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
@@ -151,11 +180,8 @@ static void __cleanup_single_sta(struct sta_info *sta)
 		ieee80211_txq_purge(local, txqi);
 	}
 
-	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		local->total_ps_buffered -= skb_queue_len(&sta->ps_tx_buf[ac]);
-		ieee80211_purge_tx_queue(&local->hw, &sta->ps_tx_buf[ac]);
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
 		ieee80211_purge_tx_queue(&local->hw, &sta->tx_filtered[ac]);
-	}
 
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_sta_cleanup(sta);
@@ -553,7 +579,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta->sta.cur = &sta->sta.deflink.agg;
 
 	spin_lock_init(&sta->lock);
-	spin_lock_init(&sta->ps_lock);
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
 	INIT_WORK(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
 	mutex_init(&sta->ampdu_mlme.mtx);
@@ -619,7 +644,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta->airtime_weight = IEEE80211_DEFAULT_AIRTIME_WEIGHT;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
 		sta->airtime[i].deficit = sta->airtime_weight;
 		atomic_set(&sta->airtime[i].aql_tx_pending, 0);
@@ -1046,8 +1070,8 @@ static void __sta_info_recalc_tim(struct sta_info *sta, bool ignore_pending)
 		if (ignore_for_tim & ieee80211_ac_to_qos_mask[ac])
 			continue;
 
-		indicate_tim |= !skb_queue_empty(&sta->tx_filtered[ac]) ||
-				!skb_queue_empty(&sta->ps_tx_buf[ac]);
+		indicate_tim |= !skb_queue_empty(&sta->tx_filtered[ac]);
+
 		if (indicate_tim)
 			break;
 
@@ -1105,18 +1129,17 @@ static bool sta_info_buffer_expired(struct sta_info *sta, struct sk_buff *skb)
 }
 
 
-static bool sta_info_cleanup_expire_buffered_ac(struct ieee80211_local *local,
+static bool sta_info_cleanup_expire_filtered_ac(struct ieee80211_local *local,
 						struct sta_info *sta, int ac)
 {
 	unsigned long flags;
 	struct sk_buff *skb;
 
 	/*
-	 * First check for frames that should expire on the filtered
+	 * Check for frames that should expire on the filtered
 	 * queue. Frames here were rejected by the driver and are on
 	 * a separate queue to avoid reordering with normal PS-buffered
-	 * frames. They also aren't accounted for right now in the
-	 * total_ps_buffered counter.
+	 * frames.
 	 */
 	for (;;) {
 		spin_lock_irqsave(&sta->tx_filtered[ac].lock, flags);
@@ -1139,51 +1162,21 @@ static bool sta_info_cleanup_expire_buffered_ac(struct ieee80211_local *local,
 	}
 
 	/*
-	 * Now also check the normal PS-buffered queue, this will
-	 * only find something if the filtered queue was emptied
-	 * since the filtered frames are all before the normal PS
-	 * buffered frames.
-	 */
-	for (;;) {
-		spin_lock_irqsave(&sta->ps_tx_buf[ac].lock, flags);
-		skb = skb_peek(&sta->ps_tx_buf[ac]);
-		if (sta_info_buffer_expired(sta, skb))
-			skb = __skb_dequeue(&sta->ps_tx_buf[ac]);
-		else
-			skb = NULL;
-		spin_unlock_irqrestore(&sta->ps_tx_buf[ac].lock, flags);
-
-		/*
-		 * frames are queued in order, so if this one
-		 * hasn't expired yet (or we reached the end of
-		 * the queue) we can stop testing
-		 */
-		if (!skb)
-			break;
-
-		local->total_ps_buffered--;
-		ps_dbg(sta->sdata, "Buffered frame expired (STA %pM)\n",
-		       sta->sta.addr);
-		ieee80211_free_txskb(&local->hw, skb);
-	}
-
-	/*
-	 * Finally, recalculate the TIM bit for this station -- it might
+	 * Recalculate the TIM bit for this station -- it might
 	 * now be clear because the station was too slow to retrieve its
 	 * frames.
 	 */
 	sta_info_recalc_tim(sta);
 
 	/*
-	 * Return whether there are any frames still buffered, this is
+	 * Return whether there are any filtered frames, this is
 	 * used to check whether the cleanup timer still needs to run,
 	 * if there are no frames we don't need to rearm the timer.
 	 */
-	return !(skb_queue_empty(&sta->ps_tx_buf[ac]) &&
-		 skb_queue_empty(&sta->tx_filtered[ac]));
+	return !(skb_queue_empty(&sta->tx_filtered[ac]));
 }
 
-static bool sta_info_cleanup_expire_buffered(struct ieee80211_local *local,
+static bool sta_info_cleanup_expire_filtered(struct ieee80211_local *local,
 					     struct sta_info *sta)
 {
 	bool have_buffered = false;
@@ -1196,7 +1189,7 @@ static bool sta_info_cleanup_expire_buffered(struct ieee80211_local *local,
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
 		have_buffered |=
-			sta_info_cleanup_expire_buffered_ac(local, sta, ac);
+			sta_info_cleanup_expire_filtered_ac(local, sta, ac);
 
 	return have_buffered;
 }
@@ -1379,7 +1372,7 @@ static void sta_info_cleanup(struct timer_list *t)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &local->sta_list, list)
-		if (sta_info_cleanup_expire_buffered(local, sta))
+		if (sta_info_cleanup_expire_filtered(local, sta))
 			timer_needed = true;
 	rcu_read_unlock();
 
@@ -1533,6 +1526,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct txq_info *txqi;
 	struct sk_buff_head pending;
 	int filtered = 0, buffered = 0, ac, i;
 	unsigned long flags;
@@ -1553,23 +1547,11 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 
 	BUILD_BUG_ON(BITS_TO_LONGS(IEEE80211_NUM_TIDS) > 1);
 	sta->driver_buffered_tids = 0;
-	sta->txq_buffered_tids = 0;
 
 	if (!ieee80211_hw_check(&local->hw, AP_LINK_PS))
 		drv_sta_notify(local, sdata, STA_NOTIFY_AWAKE, &sta->sta);
 
-	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
-		if (!sta->sta.txq[i] || !txq_has_queue(sta->sta.txq[i]))
-			continue;
-
-		schedule_and_wake_txq(local, to_txq_info(sta->sta.txq[i]));
-	}
-
-	skb_queue_head_init(&pending);
-
-	/* sync with ieee80211_tx_h_unicast_ps_buf */
-	spin_lock(&sta->ps_lock);
-	/* Send all buffered frames to the station */
+	/* Send all filtered frames to the station */
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		int count = skb_queue_len(&pending), tmp;
 
@@ -1579,16 +1561,39 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 		tmp = skb_queue_len(&pending);
 		filtered += tmp - count;
 		count = tmp;
-
-		spin_lock_irqsave(&sta->ps_tx_buf[ac].lock, flags);
-		skb_queue_splice_tail_init(&sta->ps_tx_buf[ac], &pending);
-		spin_unlock_irqrestore(&sta->ps_tx_buf[ac].lock, flags);
-		tmp = skb_queue_len(&pending);
-		buffered += tmp - count;
 	}
 
+	skb_queue_head_init(&pending);
 	ieee80211_add_pending_skbs(local, &pending);
 
+	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
+		if (!sta->sta.txq[i])
+			continue;
+
+		txqi = to_txq_info(sta->sta.txq[i]);
+		clear_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags);
+	}
+
+	/* Make sure TX path has stopped setting txq_buffered_tids */
+	synchronize_net();
+
+	for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
+		unsigned long tmp;
+
+		if (!sta->sta.txq[i])
+			continue;
+
+		if (!txq_has_queue(sta->sta.txq[i]))
+			continue;
+
+		ieee80211_txq_get_depth(sta->sta.txq[i], &tmp, NULL);
+		buffered += tmp;
+
+		schedule_and_wake_txq(local, txqi);
+	}
+
+	sta->txq_buffered_tids = 0;
+
 	/* now we're no longer in the deliver code */
 	clear_sta_flag(sta, WLAN_STA_PS_DELIVER);
 
@@ -1597,12 +1602,9 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	 */
 	clear_sta_flag(sta, WLAN_STA_PSPOLL);
 	clear_sta_flag(sta, WLAN_STA_UAPSD);
-	spin_unlock(&sta->ps_lock);
-
-	atomic_dec(&ps->num_sta_ps);
-
-	local->total_ps_buffered -= buffered;
 
+	/* can call wake_tx_queue for vif.txq */
+	num_sta_ps_dec_for_mc_txq(sdata, &ps->num_sta_ps);
 	sta_info_recalc_tim(sta);
 
 	ps_dbg(sdata,
@@ -1735,7 +1737,7 @@ ieee80211_sta_ps_more_data(struct sta_info *sta, u8 ignored_acs,
 			continue;
 
 		if (!skb_queue_empty(&sta->tx_filtered[ac]) ||
-		    !skb_queue_empty(&sta->ps_tx_buf[ac]))
+		    txq_has_queue(sta->sta.txq[ac]))
 			return true;
 	}
 
@@ -1748,8 +1750,7 @@ ieee80211_sta_ps_get_frames(struct sta_info *sta, int n_frames, u8 ignored_acs,
 			    struct sk_buff_head *frames,
 			    unsigned long *driver_release_tids)
 {
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_hw *hw = &sta->sdata->local->hw;
 	int ac;
 
 	/* Get response frame(s) and more data bit for the last one. */
@@ -1775,12 +1776,8 @@ ieee80211_sta_ps_get_frames(struct sta_info *sta, int n_frames, u8 ignored_acs,
 
 			while (n_frames > 0) {
 				skb = skb_dequeue(&sta->tx_filtered[ac]);
-				if (!skb) {
-					skb = skb_dequeue(
-						&sta->ps_tx_buf[ac]);
-					if (skb)
-						local->total_ps_buffered--;
-				}
+				if (!skb)
+					skb = ieee80211_tx_dequeue(hw, sta->sta.txq[ac]);
 				if (!skb)
 					break;
 				n_frames--;
@@ -1793,7 +1790,7 @@ ieee80211_sta_ps_get_frames(struct sta_info *sta, int n_frames, u8 ignored_acs,
 		 * the buffered frames from this.
 		 */
 		if (!skb_queue_empty(&sta->tx_filtered[ac]) ||
-		    !skb_queue_empty(&sta->ps_tx_buf[ac]))
+		    txq_has_queue(sta->sta.txq[ac]))
 			break;
 	}
 }
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 69820b551668..2d18bd0e4705 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -592,9 +592,6 @@ struct link_sta_info {
  * @drv_deliver_wk: used for delivering frames after driver PS unblocking
  * @listen_interval: listen interval of this station, when we're acting as AP
  * @_flags: STA flags, see &enum ieee80211_sta_info_flags, do not use directly
- * @ps_lock: used for powersave (when mac80211 is the AP) related locking
- * @ps_tx_buf: buffers (per AC) of frames to transmit to this station
- *	when it leaves power saving state or polls
  * @tx_filtered: buffers (per AC) of frames we already tried to
  *	transmit but were filtered by hardware due to STA having
  *	entered power saving state, these are also delivered to
@@ -678,8 +675,6 @@ struct sta_info {
 	unsigned long _flags;
 
 	/* STA powersave lock and frame queues */
-	spinlock_t ps_lock;
-	struct sk_buff_head ps_tx_buf[IEEE80211_NUM_ACS];
 	struct sk_buff_head tx_filtered[IEEE80211_NUM_ACS];
 	unsigned long driver_buffered_tids;
 	unsigned long txq_buffered_tids;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bb2e54610101..7aa4776a36d1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -310,9 +310,6 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 	if (tx->sdata->vif.type == NL80211_IFTYPE_OCB)
 		return TX_CONTINUE;
 
-	if (tx->flags & IEEE80211_TX_PS_BUFFERED)
-		return TX_CONTINUE;
-
 	if (tx->sta)
 		assoc = test_sta_flag(tx->sta, WLAN_STA_ASSOC);
 
@@ -339,122 +336,6 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 	return TX_CONTINUE;
 }
 
-/* This function is called whenever the AP is about to exceed the maximum limit
- * of buffered frames for power saving STAs. This situation should not really
- * happen often during normal operation, so dropping the oldest buffered packet
- * from each queue should be OK to make some room for new frames. */
-static void purge_old_ps_buffers(struct ieee80211_local *local)
-{
-	int total = 0, purged = 0;
-	struct sk_buff *skb;
-	struct ieee80211_sub_if_data *sdata;
-	struct sta_info *sta;
-
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		struct ps_data *ps;
-
-		if (sdata->vif.type == NL80211_IFTYPE_AP)
-			ps = &sdata->u.ap.ps;
-		else if (ieee80211_vif_is_mesh(&sdata->vif))
-			ps = &sdata->u.mesh.ps;
-		else
-			continue;
-
-		skb = skb_dequeue(&ps->bc_buf);
-		if (skb) {
-			purged++;
-			ieee80211_free_txskb(&local->hw, skb);
-		}
-		total += skb_queue_len(&ps->bc_buf);
-	}
-
-	/*
-	 * Drop one frame from each station from the lowest-priority
-	 * AC that has frames at all.
-	 */
-	list_for_each_entry_rcu(sta, &local->sta_list, list) {
-		int ac;
-
-		for (ac = IEEE80211_AC_BK; ac >= IEEE80211_AC_VO; ac--) {
-			skb = skb_dequeue(&sta->ps_tx_buf[ac]);
-			total += skb_queue_len(&sta->ps_tx_buf[ac]);
-			if (skb) {
-				purged++;
-				ieee80211_free_txskb(&local->hw, skb);
-				break;
-			}
-		}
-	}
-
-	local->total_ps_buffered = total;
-	ps_dbg_hw(&local->hw, "PS buffers full - purged %d frames\n", purged);
-}
-
-static ieee80211_tx_result
-ieee80211_tx_h_multicast_ps_buf(struct ieee80211_tx_data *tx)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
-	struct ps_data *ps;
-
-	/*
-	 * broadcast/multicast frame
-	 *
-	 * If any of the associated/peer stations is in power save mode,
-	 * the frame is buffered to be sent after DTIM beacon frame.
-	 * This is done either by the hardware or us.
-	 */
-
-	/* powersaving STAs currently only in AP/VLAN/mesh mode */
-	if (tx->sdata->vif.type == NL80211_IFTYPE_AP ||
-	    tx->sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-		if (!tx->sdata->bss)
-			return TX_CONTINUE;
-
-		ps = &tx->sdata->bss->ps;
-	} else if (ieee80211_vif_is_mesh(&tx->sdata->vif)) {
-		ps = &tx->sdata->u.mesh.ps;
-	} else {
-		return TX_CONTINUE;
-	}
-
-
-	/* no buffering for ordered frames */
-	if (ieee80211_has_order(hdr->frame_control))
-		return TX_CONTINUE;
-
-	if (ieee80211_is_probe_req(hdr->frame_control))
-		return TX_CONTINUE;
-
-	if (ieee80211_hw_check(&tx->local->hw, QUEUE_CONTROL))
-		info->hw_queue = tx->sdata->vif.cab_queue;
-
-	/* no stations in PS mode and no buffered packets */
-	if (!atomic_read(&ps->num_sta_ps) && skb_queue_empty(&ps->bc_buf))
-		return TX_CONTINUE;
-
-	info->flags |= IEEE80211_TX_CTL_SEND_AFTER_DTIM;
-
-	/* device releases frame after DTIM beacon */
-	if (!ieee80211_hw_check(&tx->local->hw, HOST_BROADCAST_PS_BUFFERING))
-		return TX_CONTINUE;
-
-	/* buffered in mac80211 */
-	if (tx->local->total_ps_buffered >= TOTAL_MAX_TX_BUFFER)
-		purge_old_ps_buffers(tx->local);
-
-	if (skb_queue_len(&ps->bc_buf) >= AP_MAX_BC_BUFFER) {
-		ps_dbg(tx->sdata,
-		       "BC TX buffer full - dropping the oldest frame\n");
-		ieee80211_free_txskb(&tx->local->hw, skb_dequeue(&ps->bc_buf));
-	} else
-		tx->local->total_ps_buffered++;
-
-	skb_queue_tail(&ps->bc_buf, tx->skb);
-
-	return TX_QUEUED;
-}
-
 static int ieee80211_use_mfp(__le16 fc, struct sta_info *sta,
 			     struct sk_buff *skb)
 {
@@ -470,97 +351,6 @@ static int ieee80211_use_mfp(__le16 fc, struct sta_info *sta,
 	return 1;
 }
 
-static ieee80211_tx_result
-ieee80211_tx_h_unicast_ps_buf(struct ieee80211_tx_data *tx)
-{
-	struct sta_info *sta = tx->sta;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
-	struct ieee80211_local *local = tx->local;
-
-	if (unlikely(!sta))
-		return TX_CONTINUE;
-
-	if (unlikely((test_sta_flag(sta, WLAN_STA_PS_STA) ||
-		      test_sta_flag(sta, WLAN_STA_PS_DRIVER) ||
-		      test_sta_flag(sta, WLAN_STA_PS_DELIVER)) &&
-		     !(info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER))) {
-		int ac = skb_get_queue_mapping(tx->skb);
-
-		if (ieee80211_is_mgmt(hdr->frame_control) &&
-		    !ieee80211_is_bufferable_mmpdu(hdr->frame_control)) {
-			info->flags |= IEEE80211_TX_CTL_NO_PS_BUFFER;
-			return TX_CONTINUE;
-		}
-
-		ps_dbg(sta->sdata, "STA %pM aid %d: PS buffer for AC %d\n",
-		       sta->sta.addr, sta->sta.aid, ac);
-		if (tx->local->total_ps_buffered >= TOTAL_MAX_TX_BUFFER)
-			purge_old_ps_buffers(tx->local);
-
-		/* sync with ieee80211_sta_ps_deliver_wakeup */
-		spin_lock(&sta->ps_lock);
-		/*
-		 * STA woke up the meantime and all the frames on ps_tx_buf have
-		 * been queued to pending queue. No reordering can happen, go
-		 * ahead and Tx the packet.
-		 */
-		if (!test_sta_flag(sta, WLAN_STA_PS_STA) &&
-		    !test_sta_flag(sta, WLAN_STA_PS_DRIVER) &&
-		    !test_sta_flag(sta, WLAN_STA_PS_DELIVER)) {
-			spin_unlock(&sta->ps_lock);
-			return TX_CONTINUE;
-		}
-
-		if (skb_queue_len(&sta->ps_tx_buf[ac]) >= STA_MAX_TX_BUFFER) {
-			struct sk_buff *old = skb_dequeue(&sta->ps_tx_buf[ac]);
-			ps_dbg(tx->sdata,
-			       "STA %pM TX buffer for AC %d full - dropping oldest frame\n",
-			       sta->sta.addr, ac);
-			ieee80211_free_txskb(&local->hw, old);
-		} else
-			tx->local->total_ps_buffered++;
-
-		info->control.jiffies = jiffies;
-		info->control.vif = &tx->sdata->vif;
-		info->control.flags |= IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
-		info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
-		skb_queue_tail(&sta->ps_tx_buf[ac], tx->skb);
-		spin_unlock(&sta->ps_lock);
-
-		if (!timer_pending(&local->sta_cleanup))
-			mod_timer(&local->sta_cleanup,
-				  round_jiffies(jiffies +
-						STA_INFO_CLEANUP_INTERVAL));
-
-		/*
-		 * We queued up some frames, so the TIM bit might
-		 * need to be set, recalculate it.
-		 */
-		sta_info_recalc_tim(sta);
-
-		return TX_QUEUED;
-	} else if (unlikely(test_sta_flag(sta, WLAN_STA_PS_STA))) {
-		ps_dbg(tx->sdata,
-		       "STA %pM in PS mode, but polling/in SP -> send frame\n",
-		       sta->sta.addr);
-	}
-
-	return TX_CONTINUE;
-}
-
-static ieee80211_tx_result debug_noinline
-ieee80211_tx_h_ps_buf(struct ieee80211_tx_data *tx)
-{
-	if (unlikely(tx->flags & IEEE80211_TX_PS_BUFFERED))
-		return TX_CONTINUE;
-
-	if (tx->flags & IEEE80211_TX_UNICAST)
-		return ieee80211_tx_h_unicast_ps_buf(tx);
-	else
-		return ieee80211_tx_h_multicast_ps_buf(tx);
-}
-
 static ieee80211_tx_result debug_noinline
 ieee80211_tx_h_check_control_port_protocol(struct ieee80211_tx_data *tx)
 {
@@ -1319,9 +1109,18 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_txq *txq = NULL;
-
-	if ((info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM) ||
-	    (info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE))
+	bool is_ap_or_mesh = (vif->type == NL80211_IFTYPE_AP ||
+			      ieee80211_vif_is_mesh(vif));
+
+	if (unlikely(is_ap_or_mesh &&
+		     ieee80211_is_mgmt(hdr->frame_control) &&
+		     !ieee80211_is_bufferable_mmpdu(hdr->frame_control)))
+		info->flags |= IEEE80211_TX_CTL_NO_PS_BUFFER;
+
+	if (unlikely((info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER) ||
+		     info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE ||
+		     ieee80211_has_order(hdr->frame_control) ||
+		     ieee80211_is_probe_req(hdr->frame_control)))
 		return NULL;
 
 	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
@@ -1344,6 +1143,9 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 
 		txq = sta->sta.txq[tid];
 	} else if (vif) {
+		if (is_ap_or_mesh &&
+		    ieee80211_hw_check(&local->hw, QUEUE_CONTROL))
+			info->hw_queue = vif->cab_queue;
 		txq = vif->txq;
 	}
 
@@ -1677,7 +1479,10 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
 
 	ieee80211_txq_enqueue(local, txqi, skb);
 
-	schedule_and_wake_txq(local, txqi);
+	if (likely(!test_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags)))
+		schedule_and_wake_txq(local, txqi);
+	else if (sta)
+		set_bit(txqi->txq.tid, &sta->txq_buffered_tids);
 
 	return true;
 }
@@ -1831,7 +1636,6 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 
 	CALL_TXH(ieee80211_tx_h_dynamic_ps);
 	CALL_TXH(ieee80211_tx_h_check_assoc);
-	CALL_TXH(ieee80211_tx_h_ps_buf);
 	CALL_TXH(ieee80211_tx_h_check_control_port_protocol);
 	CALL_TXH(ieee80211_tx_h_select_key);
 
@@ -3773,6 +3577,10 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 			ieee80211_free_txskb(&local->hw, skb);
 			goto begin;
 		}
+	} else if (vif->txq == txq &&
+		   vif->type == NL80211_IFTYPE_AP &&
+		   atomic_read(&tx.sdata->bss->ps.num_sta_ps)) {
+		info->flags |= IEEE80211_TX_CTL_SEND_AFTER_DTIM;
 	}
 
 	/*
@@ -4775,7 +4583,11 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 	*pos++ = ps->dtim_count;
 	*pos++ = link_conf->dtim_period;
 
-	if (ps->dtim_count == 0 && !skb_queue_empty(&ps->bc_buf))
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		sdata = container_of(sdata->bss,
+				     struct ieee80211_sub_if_data, u.ap);
+
+	if (ps->dtim_count == 0 && txq_has_queue(sdata->vif.txq))
 		aid0 = 1;
 
 	ps->dtim_bc_mc = aid0 == 1;
@@ -5593,7 +5405,6 @@ struct sk_buff *
 ieee80211_get_buffered_bc(struct ieee80211_hw *hw,
 			  struct ieee80211_vif *vif)
 {
-	struct ieee80211_local *local = hw_to_local(hw);
 	struct sk_buff *skb = NULL;
 	struct ieee80211_tx_data tx;
 	struct ieee80211_sub_if_data *sdata;
@@ -5627,12 +5438,11 @@ ieee80211_get_buffered_bc(struct ieee80211_hw *hw,
 		goto out; /* send buffered bc/mc only after DTIM beacon */
 
 	while (1) {
-		skb = skb_dequeue(&ps->bc_buf);
+		skb = ieee80211_tx_dequeue(hw, vif->txq);
 		if (!skb)
 			goto out;
-		local->total_ps_buffered--;
 
-		if (!skb_queue_empty(&ps->bc_buf) && skb->len >= 2) {
+		if (txq_has_queue(vif->txq)) {
 			struct ieee80211_hdr *hdr =
 				(struct ieee80211_hdr *) skb->data;
 			/* more buffered multicast/broadcast frames ==> set
@@ -5650,8 +5460,6 @@ ieee80211_get_buffered_bc(struct ieee80211_hw *hw,
 	}
 
 	info = IEEE80211_SKB_CB(skb);
-
-	tx.flags |= IEEE80211_TX_PS_BUFFERED;
 	info->band = chanctx_conf->def.chan->band;
 
 	if (invoke_tx_handlers(&tx))
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 6f5407038459..33c50ea50dde 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -359,6 +359,11 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 		if (sdata != sta->sdata)
 			continue;
 
+		if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
+		    test_sta_flag(sta, WLAN_STA_PS_DRIVER) ||
+		    test_sta_flag(sta, WLAN_STA_PS_DELIVER))
+			continue;
+
 		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 			struct ieee80211_txq *txq = sta->sta.txq[i];
 
-- 
2.38.1

