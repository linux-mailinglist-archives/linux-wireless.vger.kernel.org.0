Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451872614CD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbgIHQh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbgIHQhO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:14 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA4FC0612EE
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2ulGxj0uRTY1f0oG2Ty3FWMRBbBxDkWKfyc6MCl+C0s=; b=WSd5ebioZTETdMenhJuCzcVUzQ
        eIGnRjPLtkds2vsIUbh/hMPKlVhORRGNllvtTp6cZrcvVq9KxyJ/9irDDNRIFW1p5yedQjVynJCL/
        LkdWsrYbVk1pbAzVh10hTBFxd5Il27jfrGZui3IuWLOEHj6RyZ1eyHXgGE+PW2cx9UsY=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrz-00050i-AO; Tue, 08 Sep 2020 14:37:07 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 14/14] mac80211: reorganize code to remove a forward declaration
Date:   Tue,  8 Sep 2020 14:37:02 +0200
Message-Id: <20200908123702.88454-15-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove the newly added ieee80211_set_vif_encap_ops declaration.
No further code changes

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/iface.c | 1626 +++++++++++++++++++++---------------------
 1 file changed, 812 insertions(+), 814 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 02bb94de7bde..7ac9af66f545 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -43,7 +43,6 @@
  */
 
 static void ieee80211_iface_work(struct work_struct *work);
-static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 {
@@ -349,968 +348,993 @@ static int ieee80211_check_queues(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static bool ieee80211_iftype_supports_encap_offload(enum nl80211_iftype iftype)
+static int ieee80211_open(struct net_device *dev)
 {
-	switch (iftype) {
-	/* P2P GO and client are mapped to AP/STATION types */
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_STATION:
-		return true;
-	default:
-		return false;
-	}
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	int err;
+
+	/* fail early if user set an invalid address */
+	if (!is_valid_ether_addr(dev->dev_addr))
+		return -EADDRNOTAVAIL;
+
+	err = ieee80211_check_concurrent_iface(sdata, sdata->vif.type);
+	if (err)
+		return err;
+
+	return ieee80211_do_open(&sdata->wdev, true);
 }
 
-static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdata)
+static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
+			      bool going_down)
 {
 	struct ieee80211_local *local = sdata->local;
-	u32 flags;
-
-	flags = sdata->vif.offload_flags;
+	unsigned long flags;
+	struct sk_buff *skb, *tmp;
+	u32 hw_reconf_flags = 0;
+	int i, flushed;
+	struct ps_data *ps;
+	struct cfg80211_chan_def chandef;
+	bool cancel_scan;
+	struct cfg80211_nan_func *func;
 
-	if (ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) &&
-	    ieee80211_iftype_supports_encap_offload(sdata->vif.type)) {
-		flags |= IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-		if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_FRAG) &&
-		    local->hw.wiphy->frag_threshold != (u32)-1)
-			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
+	if (cancel_scan)
+		ieee80211_scan_cancel(local);
 
-		if (local->monitors)
-			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
-	} else {
-		flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
-	}
+	/*
+	 * Stop TX on this interface first.
+	 */
+	if (sdata->dev)
+		netif_tx_stop_all_queues(sdata->dev);
 
-	if (sdata->vif.offload_flags == flags)
-		return false;
+	ieee80211_roc_purge(local, sdata);
 
-	sdata->vif.offload_flags = flags;
-	return true;
-}
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_STATION:
+		ieee80211_mgd_stop(sdata);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		ieee80211_ibss_stop(sdata);
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES)
+			break;
+		list_del_rcu(&sdata->u.mntr.list);
+		break;
+	default:
+		break;
+	}
 
+	/*
+	 * Remove all stations associated with this interface.
+	 *
+	 * This must be done before calling ops->remove_interface()
+	 * because otherwise we can later invoke ops->sta_notify()
+	 * whenever the STAs are removed, and that invalidates driver
+	 * assumptions about always getting a vif pointer that is valid
+	 * (because if we remove a STA after ops->remove_interface()
+	 * the driver will have removed the vif info already!)
+	 *
+	 * In WDS mode a station must exist here and be flushed, for
+	 * AP_VLANs stations may exist since there's nothing else that
+	 * would have removed them, but in other modes there shouldn't
+	 * be any stations.
+	 */
+	flushed = sta_info_flush(sdata);
+	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
+		     ((sdata->vif.type != NL80211_IFTYPE_WDS && flushed > 0) ||
+		      (sdata->vif.type == NL80211_IFTYPE_WDS && flushed != 1)));
 
-static void ieee80211_recalc_sdata_offload(struct ieee80211_sub_if_data *sdata)
-{
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_sub_if_data *vsdata;
+	/* don't count this interface for allmulti while it is down */
+	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
+		atomic_dec(&local->iff_allmultis);
 
-	if (ieee80211_set_sdata_offload_flags(sdata)) {
-		drv_update_vif_offload(local, sdata);
-		ieee80211_set_vif_encap_ops(sdata);
+	if (sdata->vif.type == NL80211_IFTYPE_AP) {
+		local->fif_pspoll--;
+		local->fif_probe_req--;
+	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
+		local->fif_probe_req--;
 	}
 
-	list_for_each_entry(vsdata, &local->interfaces, list) {
-		if (vsdata->vif.type != NL80211_IFTYPE_AP_VLAN ||
-		    vsdata->bss != &sdata->u.ap)
-			continue;
-
-		ieee80211_set_vif_encap_ops(vsdata);
+	if (sdata->dev) {
+		netif_addr_lock_bh(sdata->dev);
+		spin_lock_bh(&local->filter_lock);
+		__hw_addr_unsync(&local->mc_list, &sdata->dev->mc,
+				 sdata->dev->addr_len);
+		spin_unlock_bh(&local->filter_lock);
+		netif_addr_unlock_bh(sdata->dev);
 	}
-}
-
-void ieee80211_recalc_offload(struct ieee80211_local *local)
-{
-	struct ieee80211_sub_if_data *sdata;
-
-	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD))
-		return;
 
-	mutex_lock(&local->iflist_mtx);
-
-	list_for_each_entry(sdata, &local->interfaces, list) {
-		if (!ieee80211_sdata_running(sdata))
-			continue;
+	del_timer_sync(&local->dynamic_ps_timer);
+	cancel_work_sync(&local->dynamic_ps_enable_work);
 
-		ieee80211_recalc_sdata_offload(sdata);
+	cancel_work_sync(&sdata->recalc_smps);
+	sdata_lock(sdata);
+	mutex_lock(&local->mtx);
+	sdata->vif.csa_active = false;
+	if (sdata->vif.type == NL80211_IFTYPE_STATION)
+		sdata->u.mgd.csa_waiting_bcn = false;
+	if (sdata->csa_block_tx) {
+		ieee80211_wake_vif_queues(local, sdata,
+					  IEEE80211_QUEUE_STOP_REASON_CSA);
+		sdata->csa_block_tx = false;
 	}
+	mutex_unlock(&local->mtx);
+	sdata_unlock(sdata);
 
-	mutex_unlock(&local->iflist_mtx);
-}
-
-void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
-				    const int offset)
-{
-	struct ieee80211_local *local = sdata->local;
-	u32 flags = sdata->u.mntr.flags;
+	cancel_work_sync(&sdata->csa_finalize_work);
 
-#define ADJUST(_f, _s)	do {					\
-	if (flags & MONITOR_FLAG_##_f)				\
-		local->fif_##_s += offset;			\
-	} while (0)
+	cancel_delayed_work_sync(&sdata->dfs_cac_timer_work);
 
-	ADJUST(FCSFAIL, fcsfail);
-	ADJUST(PLCPFAIL, plcpfail);
-	ADJUST(CONTROL, control);
-	ADJUST(CONTROL, pspoll);
-	ADJUST(OTHER_BSS, other_bss);
+	if (sdata->wdev.cac_started) {
+		chandef = sdata->vif.bss_conf.chandef;
+		WARN_ON(local->suspended);
+		mutex_lock(&local->mtx);
+		ieee80211_vif_release_channel(sdata);
+		mutex_unlock(&local->mtx);
+		cfg80211_cac_event(sdata->dev, &chandef,
+				   NL80211_RADAR_CAC_ABORTED,
+				   GFP_KERNEL);
+	}
 
-#undef ADJUST
-}
+	/* APs need special treatment */
+	if (sdata->vif.type == NL80211_IFTYPE_AP) {
+		struct ieee80211_sub_if_data *vlan, *tmpsdata;
 
-static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
-{
-	struct ieee80211_local *local = sdata->local;
-	int i;
+		/* down all dependent devices, that is VLANs */
+		list_for_each_entry_safe(vlan, tmpsdata, &sdata->u.ap.vlans,
+					 u.vlan.list)
+			dev_close(vlan->dev);
+		WARN_ON(!list_empty(&sdata->u.ap.vlans));
+	} else if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		/* remove all packets in parent bc_buf pointing to this dev */
+		ps = &sdata->bss->ps;
 
-	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		if (ieee80211_hw_check(&local->hw, QUEUE_CONTROL))
-			sdata->vif.hw_queue[i] = IEEE80211_INVAL_HW_QUEUE;
-		else if (local->hw.queues >= IEEE80211_NUM_ACS)
-			sdata->vif.hw_queue[i] = i;
-		else
-			sdata->vif.hw_queue[i] = 0;
+		spin_lock_irqsave(&ps->bc_buf.lock, flags);
+		skb_queue_walk_safe(&ps->bc_buf, skb, tmp) {
+			if (skb->dev == sdata->dev) {
+				__skb_unlink(skb, &ps->bc_buf);
+				local->total_ps_buffered--;
+				ieee80211_free_txskb(&local->hw, skb);
+			}
+		}
+		spin_unlock_irqrestore(&ps->bc_buf.lock, flags);
 	}
-	sdata->vif.cab_queue = IEEE80211_INVAL_HW_QUEUE;
-}
 
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
-{
-	struct ieee80211_sub_if_data *sdata;
-	int ret;
-
-	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
-		return 0;
+	if (going_down)
+		local->open_count--;
 
-	ASSERT_RTNL();
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP_VLAN:
+		mutex_lock(&local->mtx);
+		list_del(&sdata->u.vlan.list);
+		mutex_unlock(&local->mtx);
+		RCU_INIT_POINTER(sdata->vif.chanctx_conf, NULL);
+		/* see comment in the default case below */
+		ieee80211_free_keys(sdata, true);
+		/* no need to tell driver */
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) {
+			local->cooked_mntrs--;
+			break;
+		}
 
-	if (local->monitor_sdata)
-		return 0;
+		local->monitors--;
+		if (local->monitors == 0) {
+			local->hw.conf.flags &= ~IEEE80211_CONF_MONITOR;
+			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
+		}
 
-	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
-	if (!sdata)
-		return -ENOMEM;
+		ieee80211_adjust_monitor_flags(sdata, -1);
+		break;
+	case NL80211_IFTYPE_NAN:
+		/* clean all the functions */
+		spin_lock_bh(&sdata->u.nan.func_lock);
 
-	/* set up data */
-	sdata->local = local;
-	sdata->vif.type = NL80211_IFTYPE_MONITOR;
-	snprintf(sdata->name, IFNAMSIZ, "%s-monitor",
-		 wiphy_name(local->hw.wiphy));
-	sdata->wdev.iftype = NL80211_IFTYPE_MONITOR;
-
-	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
-
-	ieee80211_set_default_queues(sdata);
+		idr_for_each_entry(&sdata->u.nan.function_inst_ids, func, i) {
+			idr_remove(&sdata->u.nan.function_inst_ids, i);
+			cfg80211_free_nan_func(func);
+		}
+		idr_destroy(&sdata->u.nan.function_inst_ids);
 
-	ret = drv_add_interface(local, sdata);
-	if (WARN_ON(ret)) {
-		/* ok .. stupid driver, it asked for this! */
-		kfree(sdata);
-		return ret;
+		spin_unlock_bh(&sdata->u.nan.func_lock);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		/* relies on synchronize_rcu() below */
+		RCU_INIT_POINTER(local->p2p_sdata, NULL);
+		fallthrough;
+	default:
+		cancel_work_sync(&sdata->work);
+		/*
+		 * When we get here, the interface is marked down.
+		 * Free the remaining keys, if there are any
+		 * (which can happen in AP mode if userspace sets
+		 * keys before the interface is operating, and maybe
+		 * also in WDS mode)
+		 *
+		 * Force the key freeing to always synchronize_net()
+		 * to wait for the RX path in case it is using this
+		 * interface enqueuing frames at this very time on
+		 * another CPU.
+		 */
+		ieee80211_free_keys(sdata, true);
+		skb_queue_purge(&sdata->skb_queue);
 	}
 
-	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
-	if (ret) {
-		kfree(sdata);
-		return ret;
+	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
+	for (i = 0; i < IEEE80211_MAX_QUEUES; i++) {
+		skb_queue_walk_safe(&local->pending[i], skb, tmp) {
+			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+			if (info->control.vif == &sdata->vif) {
+				__skb_unlink(skb, &local->pending[i]);
+				ieee80211_free_txskb(&local->hw, skb);
+			}
+		}
 	}
+	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
-	mutex_lock(&local->iflist_mtx);
-	rcu_assign_pointer(local->monitor_sdata, sdata);
-	mutex_unlock(&local->iflist_mtx);
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		ieee80211_txq_remove_vlan(local, sdata);
 
-	mutex_lock(&local->mtx);
-	ret = ieee80211_vif_use_channel(sdata, &local->monitor_chandef,
-					IEEE80211_CHANCTX_EXCLUSIVE);
-	mutex_unlock(&local->mtx);
-	if (ret) {
-		mutex_lock(&local->iflist_mtx);
-		RCU_INIT_POINTER(local->monitor_sdata, NULL);
-		mutex_unlock(&local->iflist_mtx);
-		synchronize_net();
-		drv_remove_interface(local, sdata);
-		kfree(sdata);
-		return ret;
+	sdata->bss = NULL;
+
+	if (local->open_count == 0)
+		ieee80211_clear_tx_pending(local);
+
+	sdata->vif.bss_conf.beacon_int = 0;
+
+	/*
+	 * If the interface goes down while suspended, presumably because
+	 * the device was unplugged and that happens before our resume,
+	 * then the driver is already unconfigured and the remainder of
+	 * this function isn't needed.
+	 * XXX: what about WoWLAN? If the device has software state, e.g.
+	 *	memory allocated, it might expect teardown commands from
+	 *	mac80211 here?
+	 */
+	if (local->suspended) {
+		WARN_ON(local->wowlan);
+		WARN_ON(rtnl_dereference(local->monitor_sdata));
+		return;
 	}
 
-	skb_queue_head_init(&sdata->skb_queue);
-	INIT_WORK(&sdata->work, ieee80211_iface_work);
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP_VLAN:
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (local->monitors == 0)
+			ieee80211_del_virtual_monitor(local);
 
-	return 0;
-}
+		mutex_lock(&local->mtx);
+		ieee80211_recalc_idle(local);
+		mutex_unlock(&local->mtx);
 
-void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
-{
-	struct ieee80211_sub_if_data *sdata;
+		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
+			break;
 
-	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
-		return;
+		fallthrough;
+	default:
+		if (going_down)
+			drv_remove_interface(local, sdata);
+	}
 
-	ASSERT_RTNL();
+	ieee80211_recalc_ps(local);
 
-	mutex_lock(&local->iflist_mtx);
+	if (cancel_scan)
+		flush_delayed_work(&local->scan_work);
 
-	sdata = rcu_dereference_protected(local->monitor_sdata,
-					  lockdep_is_held(&local->iflist_mtx));
-	if (!sdata) {
-		mutex_unlock(&local->iflist_mtx);
+	if (local->open_count == 0) {
+		ieee80211_stop_device(local);
+
+		/* no reconfiguring after stop! */
 		return;
 	}
 
-	RCU_INIT_POINTER(local->monitor_sdata, NULL);
-	mutex_unlock(&local->iflist_mtx);
+	/* do after stop to avoid reconfiguring when we stop anyway */
+	ieee80211_configure_filter(local);
+	ieee80211_hw_config(local, hw_reconf_flags);
 
-	synchronize_net();
+	if (local->monitors == local->open_count)
+		ieee80211_add_virtual_monitor(local);
+}
 
-	mutex_lock(&local->mtx);
-	ieee80211_vif_release_channel(sdata);
-	mutex_unlock(&local->mtx);
+static int ieee80211_stop(struct net_device *dev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
-	drv_remove_interface(local, sdata);
+	ieee80211_do_stop(sdata, true);
 
-	kfree(sdata);
+	return 0;
 }
 
-/*
- * NOTE: Be very careful when changing this function, it must NOT return
- * an error on interface type changes that have been pre-checked, so most
- * checks should be in ieee80211_check_concurrent_iface.
- */
-int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
+static void ieee80211_set_multicast_list(struct net_device *dev)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
-	struct net_device *dev = wdev->netdev;
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
-	u32 changed = 0;
-	int res;
-	u32 hw_reconf_flags = 0;
+	int allmulti, sdata_allmulti;
 
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_WDS:
-		if (!is_valid_ether_addr(sdata->u.wds.remote_addr))
-			return -ENOLINK;
-		break;
-	case NL80211_IFTYPE_AP_VLAN: {
-		struct ieee80211_sub_if_data *master;
+	allmulti = !!(dev->flags & IFF_ALLMULTI);
+	sdata_allmulti = !!(sdata->flags & IEEE80211_SDATA_ALLMULTI);
 
-		if (!sdata->bss)
-			return -ENOLINK;
+	if (allmulti != sdata_allmulti) {
+		if (dev->flags & IFF_ALLMULTI)
+			atomic_inc(&local->iff_allmultis);
+		else
+			atomic_dec(&local->iff_allmultis);
+		sdata->flags ^= IEEE80211_SDATA_ALLMULTI;
+	}
 
-		mutex_lock(&local->mtx);
-		list_add(&sdata->u.vlan.list, &sdata->bss->vlans);
-		mutex_unlock(&local->mtx);
+	spin_lock_bh(&local->filter_lock);
+	__hw_addr_sync(&local->mc_list, &dev->mc, dev->addr_len);
+	spin_unlock_bh(&local->filter_lock);
+	ieee80211_queue_work(&local->hw, &local->reconfig_filter);
+}
 
-		master = container_of(sdata->bss,
-				      struct ieee80211_sub_if_data, u.ap);
-		sdata->control_port_protocol =
-			master->control_port_protocol;
-		sdata->control_port_no_encrypt =
-			master->control_port_no_encrypt;
-		sdata->control_port_over_nl80211 =
-			master->control_port_over_nl80211;
-		sdata->control_port_no_preauth =
-			master->control_port_no_preauth;
-		sdata->vif.cab_queue = master->vif.cab_queue;
-		memcpy(sdata->vif.hw_queue, master->vif.hw_queue,
-		       sizeof(sdata->vif.hw_queue));
-		sdata->vif.bss_conf.chandef = master->vif.bss_conf.chandef;
+/*
+ * Called when the netdev is removed or, by the code below, before
+ * the interface type changes.
+ */
+static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
+{
+	int i;
 
-		mutex_lock(&local->key_mtx);
-		sdata->crypto_tx_tailroom_needed_cnt +=
-			master->crypto_tx_tailroom_needed_cnt;
-		mutex_unlock(&local->key_mtx);
+	/* free extra data */
+	ieee80211_free_keys(sdata, false);
 
-		break;
-		}
-	case NL80211_IFTYPE_AP:
-		sdata->bss = &sdata->u.ap;
-		break;
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_STATION:
-	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_OCB:
-	case NL80211_IFTYPE_NAN:
-		/* no special treatment */
-		break;
-	case NL80211_IFTYPE_UNSPECIFIED:
-	case NUM_NL80211_IFTYPES:
-	case NL80211_IFTYPE_P2P_CLIENT:
-	case NL80211_IFTYPE_P2P_GO:
-		/* cannot happen */
-		WARN_ON(1);
-		break;
-	}
+	ieee80211_debugfs_remove_netdev(sdata);
 
-	if (local->open_count == 0) {
-		res = drv_start(local);
-		if (res)
-			goto err_del_bss;
-		/* we're brought up, everything changes */
-		hw_reconf_flags = ~0;
-		ieee80211_led_radio(local, true);
-		ieee80211_mod_tpt_led_trig(local,
-					   IEEE80211_TPT_LEDTRIG_FL_RADIO, 0);
-	}
+	for (i = 0; i < IEEE80211_FRAGMENT_MAX; i++)
+		__skb_queue_purge(&sdata->fragments[i].skb_list);
+	sdata->fragment_next = 0;
 
-	/*
-	 * Copy the hopefully now-present MAC address to
-	 * this interface, if it has the special null one.
-	 */
-	if (dev && is_zero_ether_addr(dev->dev_addr)) {
-		memcpy(dev->dev_addr,
-		       local->hw.wiphy->perm_addr,
-		       ETH_ALEN);
-		memcpy(dev->perm_addr, dev->dev_addr, ETH_ALEN);
-
-		if (!is_valid_ether_addr(dev->dev_addr)) {
-			res = -EADDRNOTAVAIL;
-			goto err_stop;
-		}
-	}
-
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_AP_VLAN:
-		/* no need to tell driver, but set carrier and chanctx */
-		if (rtnl_dereference(sdata->bss->beacon)) {
-			ieee80211_vif_vlan_copy_chanctx(sdata);
-			netif_carrier_on(dev);
-			ieee80211_set_vif_encap_ops(sdata);
-		} else {
-			netif_carrier_off(dev);
-		}
-		break;
-	case NL80211_IFTYPE_MONITOR:
-		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) {
-			local->cooked_mntrs++;
-			break;
-		}
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		ieee80211_mesh_teardown_sdata(sdata);
+}
 
-		if (sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
-			res = drv_add_interface(local, sdata);
-			if (res)
-				goto err_stop;
-		} else if (local->monitors == 0 && local->open_count == 0) {
-			res = ieee80211_add_virtual_monitor(local);
-			if (res)
-				goto err_stop;
-		}
+static void ieee80211_uninit(struct net_device *dev)
+{
+	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
+}
 
-		/* must be before the call to ieee80211_configure_filter */
-		local->monitors++;
-		if (local->monitors == 1) {
-			local->hw.conf.flags |= IEEE80211_CONF_MONITOR;
-			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
-		}
+static u16 ieee80211_netdev_select_queue(struct net_device *dev,
+					 struct sk_buff *skb,
+					 struct net_device *sb_dev)
+{
+	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
+}
 
-		ieee80211_adjust_monitor_flags(sdata, 1);
-		ieee80211_configure_filter(local);
-		ieee80211_recalc_offload(local);
-		mutex_lock(&local->mtx);
-		ieee80211_recalc_idle(local);
-		mutex_unlock(&local->mtx);
+static void
+ieee80211_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+{
+	int i;
 
-		netif_carrier_on(dev);
-		break;
-	default:
-		if (coming_up) {
-			ieee80211_del_virtual_monitor(local);
-			ieee80211_set_sdata_offload_flags(sdata);
+	for_each_possible_cpu(i) {
+		const struct pcpu_sw_netstats *tstats;
+		u64 rx_packets, rx_bytes, tx_packets, tx_bytes;
+		unsigned int start;
 
-			res = drv_add_interface(local, sdata);
-			if (res)
-				goto err_stop;
+		tstats = per_cpu_ptr(dev->tstats, i);
 
-			ieee80211_set_vif_encap_ops(sdata);
-			res = ieee80211_check_queues(sdata,
-				ieee80211_vif_type_p2p(&sdata->vif));
-			if (res)
-				goto err_del_interface;
-		}
+		do {
+			start = u64_stats_fetch_begin_irq(&tstats->syncp);
+			rx_packets = tstats->rx_packets;
+			tx_packets = tstats->tx_packets;
+			rx_bytes = tstats->rx_bytes;
+			tx_bytes = tstats->tx_bytes;
+		} while (u64_stats_fetch_retry_irq(&tstats->syncp, start));
 
-		if (sdata->vif.type == NL80211_IFTYPE_AP) {
-			local->fif_pspoll++;
-			local->fif_probe_req++;
+		stats->rx_packets += rx_packets;
+		stats->tx_packets += tx_packets;
+		stats->rx_bytes   += rx_bytes;
+		stats->tx_bytes   += tx_bytes;
+	}
+}
 
-			ieee80211_configure_filter(local);
-		} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
-			local->fif_probe_req++;
-		}
+static const struct net_device_ops ieee80211_dataif_ops = {
+	.ndo_open		= ieee80211_open,
+	.ndo_stop		= ieee80211_stop,
+	.ndo_uninit		= ieee80211_uninit,
+	.ndo_start_xmit		= ieee80211_subif_start_xmit,
+	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
+	.ndo_set_mac_address 	= ieee80211_change_mac,
+	.ndo_select_queue	= ieee80211_netdev_select_queue,
+	.ndo_get_stats64	= ieee80211_get_stats64,
+};
 
-		if (sdata->vif.probe_req_reg)
-			drv_config_iface_filter(local, sdata,
-						FIF_PROBE_REQ,
-						FIF_PROBE_REQ);
+static u16 ieee80211_monitor_select_queue(struct net_device *dev,
+					  struct sk_buff *skb,
+					  struct net_device *sb_dev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_hdr *hdr;
+	int len_rthdr;
 
-		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
-		    sdata->vif.type != NL80211_IFTYPE_NAN)
-			changed |= ieee80211_reset_erp_info(sdata);
-		ieee80211_bss_info_change_notify(sdata, changed);
+	if (local->hw.queues < IEEE80211_NUM_ACS)
+		return 0;
 
-		switch (sdata->vif.type) {
-		case NL80211_IFTYPE_STATION:
-		case NL80211_IFTYPE_ADHOC:
-		case NL80211_IFTYPE_AP:
-		case NL80211_IFTYPE_MESH_POINT:
-		case NL80211_IFTYPE_OCB:
-			netif_carrier_off(dev);
-			break;
-		case NL80211_IFTYPE_WDS:
-		case NL80211_IFTYPE_P2P_DEVICE:
-		case NL80211_IFTYPE_NAN:
-			break;
-		default:
-			/* not reached */
-			WARN_ON(1);
-		}
+	/* reset flags and info before parsing radiotap header */
+	memset(info, 0, sizeof(*info));
 
-		/*
-		 * Set default queue parameters so drivers don't
-		 * need to initialise the hardware if the hardware
-		 * doesn't start up with sane defaults.
-		 * Enable QoS for anything but station interfaces.
-		 */
-		ieee80211_set_wmm_default(sdata, true,
-			sdata->vif.type != NL80211_IFTYPE_STATION);
-	}
+	if (!ieee80211_parse_tx_radiotap(skb, dev))
+		return 0; /* doesn't matter, frame will be dropped */
 
-	set_bit(SDATA_STATE_RUNNING, &sdata->state);
+	len_rthdr = ieee80211_get_radiotap_len(skb->data);
+	hdr = (struct ieee80211_hdr *)(skb->data + len_rthdr);
+	if (skb->len < len_rthdr + 2 ||
+	    skb->len < len_rthdr + ieee80211_hdrlen(hdr->frame_control))
+		return 0; /* doesn't matter, frame will be dropped */
 
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_WDS:
-		/* Create STA entry for the WDS peer */
-		sta = sta_info_alloc(sdata, sdata->u.wds.remote_addr,
-				     GFP_KERNEL);
-		if (!sta) {
-			res = -ENOMEM;
-			goto err_del_interface;
-		}
+	return ieee80211_select_queue_80211(sdata, skb, hdr);
+}
 
-		sta_info_pre_move_state(sta, IEEE80211_STA_AUTH);
-		sta_info_pre_move_state(sta, IEEE80211_STA_ASSOC);
-		sta_info_pre_move_state(sta, IEEE80211_STA_AUTHORIZED);
+static const struct net_device_ops ieee80211_monitorif_ops = {
+	.ndo_open		= ieee80211_open,
+	.ndo_stop		= ieee80211_stop,
+	.ndo_uninit		= ieee80211_uninit,
+	.ndo_start_xmit		= ieee80211_monitor_start_xmit,
+	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
+	.ndo_set_mac_address 	= ieee80211_change_mac,
+	.ndo_select_queue	= ieee80211_monitor_select_queue,
+	.ndo_get_stats64	= ieee80211_get_stats64,
+};
 
-		res = sta_info_insert(sta);
-		if (res) {
-			/* STA has been freed */
-			goto err_del_interface;
-		}
+static const struct net_device_ops ieee80211_dataif_8023_ops = {
+	.ndo_open		= ieee80211_open,
+	.ndo_stop		= ieee80211_stop,
+	.ndo_uninit		= ieee80211_uninit,
+	.ndo_start_xmit		= ieee80211_subif_start_xmit_8023,
+	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
+	.ndo_set_mac_address	= ieee80211_change_mac,
+	.ndo_select_queue	= ieee80211_netdev_select_queue,
+	.ndo_get_stats64	= ieee80211_get_stats64,
+};
 
-		rate_control_rate_init(sta);
-		netif_carrier_on(dev);
-		break;
-	case NL80211_IFTYPE_P2P_DEVICE:
-		rcu_assign_pointer(local->p2p_sdata, sdata);
-		break;
-	case NL80211_IFTYPE_MONITOR:
-		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES)
-			break;
-		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
-		break;
+static bool ieee80211_iftype_supports_encap_offload(enum nl80211_iftype iftype)
+{
+	switch (iftype) {
+	/* P2P GO and client are mapped to AP/STATION types */
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_STATION:
+		return true;
 	default:
-		break;
+		return false;
 	}
+}
 
-	/*
-	 * set_multicast_list will be invoked by the networking core
-	 * which will check whether any increments here were done in
-	 * error and sync them down to the hardware as filter flags.
-	 */
-	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
-		atomic_inc(&local->iff_allmultis);
-
-	if (coming_up)
-		local->open_count++;
-
-	if (hw_reconf_flags)
-		ieee80211_hw_config(local, hw_reconf_flags);
-
-	ieee80211_recalc_ps(local);
+static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	u32 flags;
 
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
+	flags = sdata->vif.offload_flags;
 
-		if (local->hw.queues < IEEE80211_NUM_ACS)
-			n_acs = 1;
+	if (ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) &&
+	    ieee80211_iftype_supports_encap_offload(sdata->vif.type)) {
+		flags |= IEEE80211_OFFLOAD_ENCAP_ENABLED;
 
-		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-		if (sdata->vif.cab_queue == IEEE80211_INVAL_HW_QUEUE ||
-		    (local->queue_stop_reasons[sdata->vif.cab_queue] == 0 &&
-		     skb_queue_empty(&local->pending[sdata->vif.cab_queue]))) {
-			for (ac = 0; ac < n_acs; ac++) {
-				int ac_queue = sdata->vif.hw_queue[ac];
+		if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_FRAG) &&
+		    local->hw.wiphy->frag_threshold != (u32)-1)
+			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 
-				if (local->queue_stop_reasons[ac_queue] == 0 &&
-				    skb_queue_empty(&local->pending[ac_queue]))
-					netif_start_subqueue(dev, ac);
-			}
-		}
-		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
+		if (local->monitors)
+			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	} else {
+		flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 	}
 
-	return 0;
- err_del_interface:
-	drv_remove_interface(local, sdata);
- err_stop:
-	if (!local->open_count)
-		drv_stop(local);
- err_del_bss:
-	sdata->bss = NULL;
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-		mutex_lock(&local->mtx);
-		list_del(&sdata->u.vlan.list);
-		mutex_unlock(&local->mtx);
-	}
-	/* might already be clear but that doesn't matter */
-	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
-	return res;
+	if (sdata->vif.offload_flags == flags)
+		return false;
+
+	sdata->vif.offload_flags = flags;
+	return true;
 }
 
-static int ieee80211_open(struct net_device *dev)
+static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	int err;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *bss = sdata;
+	bool enabled;
 
-	/* fail early if user set an invalid address */
-	if (!is_valid_ether_addr(dev->dev_addr))
-		return -EADDRNOTAVAIL;
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		if (!sdata->bss)
+			return;
 
-	err = ieee80211_check_concurrent_iface(sdata, sdata->vif.type);
-	if (err)
-		return err;
+		bss = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
+	}
 
-	return ieee80211_do_open(&sdata->wdev, true);
-}
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) ||
+	    !ieee80211_iftype_supports_encap_offload(bss->vif.type))
+		return;
 
-static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
-			      bool going_down)
-{
-	struct ieee80211_local *local = sdata->local;
-	unsigned long flags;
-	struct sk_buff *skb, *tmp;
-	u32 hw_reconf_flags = 0;
-	int i, flushed;
-	struct ps_data *ps;
-	struct cfg80211_chan_def chandef;
-	bool cancel_scan;
-	struct cfg80211_nan_func *func;
+	enabled = bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	if (sdata->wdev.use_4addr &&
+	    !(bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_4ADDR))
+		enabled = false;
 
-	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
+	sdata->dev->netdev_ops = enabled ? &ieee80211_dataif_8023_ops :
+					   &ieee80211_dataif_ops;
+}
 
-	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
-	if (cancel_scan)
-		ieee80211_scan_cancel(local);
+static void ieee80211_recalc_sdata_offload(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *vsdata;
 
-	/*
-	 * Stop TX on this interface first.
-	 */
-	if (sdata->dev)
-		netif_tx_stop_all_queues(sdata->dev);
+	if (ieee80211_set_sdata_offload_flags(sdata)) {
+		drv_update_vif_offload(local, sdata);
+		ieee80211_set_vif_encap_ops(sdata);
+	}
 
-	ieee80211_roc_purge(local, sdata);
+	list_for_each_entry(vsdata, &local->interfaces, list) {
+		if (vsdata->vif.type != NL80211_IFTYPE_AP_VLAN ||
+		    vsdata->bss != &sdata->u.ap)
+			continue;
 
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_STATION:
-		ieee80211_mgd_stop(sdata);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		ieee80211_ibss_stop(sdata);
-		break;
-	case NL80211_IFTYPE_MONITOR:
-		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES)
-			break;
-		list_del_rcu(&sdata->u.mntr.list);
-		break;
-	default:
-		break;
+		ieee80211_set_vif_encap_ops(vsdata);
 	}
+}
 
-	/*
-	 * Remove all stations associated with this interface.
-	 *
-	 * This must be done before calling ops->remove_interface()
-	 * because otherwise we can later invoke ops->sta_notify()
-	 * whenever the STAs are removed, and that invalidates driver
-	 * assumptions about always getting a vif pointer that is valid
-	 * (because if we remove a STA after ops->remove_interface()
-	 * the driver will have removed the vif info already!)
-	 *
-	 * In WDS mode a station must exist here and be flushed, for
-	 * AP_VLANs stations may exist since there's nothing else that
-	 * would have removed them, but in other modes there shouldn't
-	 * be any stations.
-	 */
-	flushed = sta_info_flush(sdata);
-	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
-		     ((sdata->vif.type != NL80211_IFTYPE_WDS && flushed > 0) ||
-		      (sdata->vif.type == NL80211_IFTYPE_WDS && flushed != 1)));
+void ieee80211_recalc_offload(struct ieee80211_local *local)
+{
+	struct ieee80211_sub_if_data *sdata;
 
-	/* don't count this interface for allmulti while it is down */
-	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
-		atomic_dec(&local->iff_allmultis);
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD))
+		return;
 
-	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		local->fif_pspoll--;
-		local->fif_probe_req--;
-	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
-		local->fif_probe_req--;
-	}
+	mutex_lock(&local->iflist_mtx);
 
-	if (sdata->dev) {
-		netif_addr_lock_bh(sdata->dev);
-		spin_lock_bh(&local->filter_lock);
-		__hw_addr_unsync(&local->mc_list, &sdata->dev->mc,
-				 sdata->dev->addr_len);
-		spin_unlock_bh(&local->filter_lock);
-		netif_addr_unlock_bh(sdata->dev);
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (!ieee80211_sdata_running(sdata))
+			continue;
+
+		ieee80211_recalc_sdata_offload(sdata);
 	}
 
-	del_timer_sync(&local->dynamic_ps_timer);
-	cancel_work_sync(&local->dynamic_ps_enable_work);
+	mutex_unlock(&local->iflist_mtx);
+}
 
-	cancel_work_sync(&sdata->recalc_smps);
-	sdata_lock(sdata);
-	mutex_lock(&local->mtx);
-	sdata->vif.csa_active = false;
-	if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		sdata->u.mgd.csa_waiting_bcn = false;
-	if (sdata->csa_block_tx) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_block_tx = false;
-	}
-	mutex_unlock(&local->mtx);
-	sdata_unlock(sdata);
+void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
+				    const int offset)
+{
+	struct ieee80211_local *local = sdata->local;
+	u32 flags = sdata->u.mntr.flags;
 
-	cancel_work_sync(&sdata->csa_finalize_work);
+#define ADJUST(_f, _s)	do {					\
+	if (flags & MONITOR_FLAG_##_f)				\
+		local->fif_##_s += offset;			\
+	} while (0)
 
-	cancel_delayed_work_sync(&sdata->dfs_cac_timer_work);
+	ADJUST(FCSFAIL, fcsfail);
+	ADJUST(PLCPFAIL, plcpfail);
+	ADJUST(CONTROL, control);
+	ADJUST(CONTROL, pspoll);
+	ADJUST(OTHER_BSS, other_bss);
 
-	if (sdata->wdev.cac_started) {
-		chandef = sdata->vif.bss_conf.chandef;
-		WARN_ON(local->suspended);
-		mutex_lock(&local->mtx);
-		ieee80211_vif_release_channel(sdata);
-		mutex_unlock(&local->mtx);
-		cfg80211_cac_event(sdata->dev, &chandef,
-				   NL80211_RADAR_CAC_ABORTED,
-				   GFP_KERNEL);
+#undef ADJUST
+}
+
+static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	int i;
+
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		if (ieee80211_hw_check(&local->hw, QUEUE_CONTROL))
+			sdata->vif.hw_queue[i] = IEEE80211_INVAL_HW_QUEUE;
+		else if (local->hw.queues >= IEEE80211_NUM_ACS)
+			sdata->vif.hw_queue[i] = i;
+		else
+			sdata->vif.hw_queue[i] = 0;
 	}
+	sdata->vif.cab_queue = IEEE80211_INVAL_HW_QUEUE;
+}
 
-	/* APs need special treatment */
-	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		struct ieee80211_sub_if_data *vlan, *tmpsdata;
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
+{
+	struct ieee80211_sub_if_data *sdata;
+	int ret;
 
-		/* down all dependent devices, that is VLANs */
-		list_for_each_entry_safe(vlan, tmpsdata, &sdata->u.ap.vlans,
-					 u.vlan.list)
-			dev_close(vlan->dev);
-		WARN_ON(!list_empty(&sdata->u.ap.vlans));
-	} else if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-		/* remove all packets in parent bc_buf pointing to this dev */
-		ps = &sdata->bss->ps;
+	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		return 0;
 
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
+	ASSERT_RTNL();
 
-	if (going_down)
-		local->open_count--;
+	if (local->monitor_sdata)
+		return 0;
 
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_AP_VLAN:
-		mutex_lock(&local->mtx);
-		list_del(&sdata->u.vlan.list);
-		mutex_unlock(&local->mtx);
-		RCU_INIT_POINTER(sdata->vif.chanctx_conf, NULL);
-		/* see comment in the default case below */
-		ieee80211_free_keys(sdata, true);
-		/* no need to tell driver */
-		break;
-	case NL80211_IFTYPE_MONITOR:
-		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) {
-			local->cooked_mntrs--;
-			break;
-		}
+	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
+	if (!sdata)
+		return -ENOMEM;
 
-		local->monitors--;
-		if (local->monitors == 0) {
-			local->hw.conf.flags &= ~IEEE80211_CONF_MONITOR;
-			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
-		}
+	/* set up data */
+	sdata->local = local;
+	sdata->vif.type = NL80211_IFTYPE_MONITOR;
+	snprintf(sdata->name, IFNAMSIZ, "%s-monitor",
+		 wiphy_name(local->hw.wiphy));
+	sdata->wdev.iftype = NL80211_IFTYPE_MONITOR;
 
-		ieee80211_adjust_monitor_flags(sdata, -1);
-		break;
-	case NL80211_IFTYPE_NAN:
-		/* clean all the functions */
-		spin_lock_bh(&sdata->u.nan.func_lock);
+	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
 
-		idr_for_each_entry(&sdata->u.nan.function_inst_ids, func, i) {
-			idr_remove(&sdata->u.nan.function_inst_ids, i);
-			cfg80211_free_nan_func(func);
-		}
-		idr_destroy(&sdata->u.nan.function_inst_ids);
+	ieee80211_set_default_queues(sdata);
 
-		spin_unlock_bh(&sdata->u.nan.func_lock);
-		break;
-	case NL80211_IFTYPE_P2P_DEVICE:
-		/* relies on synchronize_rcu() below */
-		RCU_INIT_POINTER(local->p2p_sdata, NULL);
-		fallthrough;
-	default:
-		cancel_work_sync(&sdata->work);
-		/*
-		 * When we get here, the interface is marked down.
-		 * Free the remaining keys, if there are any
-		 * (which can happen in AP mode if userspace sets
-		 * keys before the interface is operating, and maybe
-		 * also in WDS mode)
-		 *
-		 * Force the key freeing to always synchronize_net()
-		 * to wait for the RX path in case it is using this
-		 * interface enqueuing frames at this very time on
-		 * another CPU.
-		 */
-		ieee80211_free_keys(sdata, true);
-		skb_queue_purge(&sdata->skb_queue);
+	ret = drv_add_interface(local, sdata);
+	if (WARN_ON(ret)) {
+		/* ok .. stupid driver, it asked for this! */
+		kfree(sdata);
+		return ret;
+	}
+
+	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
+	if (ret) {
+		kfree(sdata);
+		return ret;
 	}
 
-	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-	for (i = 0; i < IEEE80211_MAX_QUEUES; i++) {
-		skb_queue_walk_safe(&local->pending[i], skb, tmp) {
-			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-			if (info->control.vif == &sdata->vif) {
-				__skb_unlink(skb, &local->pending[i]);
-				ieee80211_free_txskb(&local->hw, skb);
-			}
-		}
+	mutex_lock(&local->iflist_mtx);
+	rcu_assign_pointer(local->monitor_sdata, sdata);
+	mutex_unlock(&local->iflist_mtx);
+
+	mutex_lock(&local->mtx);
+	ret = ieee80211_vif_use_channel(sdata, &local->monitor_chandef,
+					IEEE80211_CHANCTX_EXCLUSIVE);
+	mutex_unlock(&local->mtx);
+	if (ret) {
+		mutex_lock(&local->iflist_mtx);
+		RCU_INIT_POINTER(local->monitor_sdata, NULL);
+		mutex_unlock(&local->iflist_mtx);
+		synchronize_net();
+		drv_remove_interface(local, sdata);
+		kfree(sdata);
+		return ret;
 	}
-	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
-		ieee80211_txq_remove_vlan(local, sdata);
+	skb_queue_head_init(&sdata->skb_queue);
+	INIT_WORK(&sdata->work, ieee80211_iface_work);
 
-	sdata->bss = NULL;
+	return 0;
+}
 
-	if (local->open_count == 0)
-		ieee80211_clear_tx_pending(local);
+void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
+{
+	struct ieee80211_sub_if_data *sdata;
 
-	sdata->vif.bss_conf.beacon_int = 0;
+	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		return;
 
-	/*
-	 * If the interface goes down while suspended, presumably because
-	 * the device was unplugged and that happens before our resume,
-	 * then the driver is already unconfigured and the remainder of
-	 * this function isn't needed.
-	 * XXX: what about WoWLAN? If the device has software state, e.g.
-	 *	memory allocated, it might expect teardown commands from
-	 *	mac80211 here?
-	 */
-	if (local->suspended) {
-		WARN_ON(local->wowlan);
-		WARN_ON(rtnl_dereference(local->monitor_sdata));
+	ASSERT_RTNL();
+
+	mutex_lock(&local->iflist_mtx);
+
+	sdata = rcu_dereference_protected(local->monitor_sdata,
+					  lockdep_is_held(&local->iflist_mtx));
+	if (!sdata) {
+		mutex_unlock(&local->iflist_mtx);
 		return;
 	}
 
+	RCU_INIT_POINTER(local->monitor_sdata, NULL);
+	mutex_unlock(&local->iflist_mtx);
+
+	synchronize_net();
+
+	mutex_lock(&local->mtx);
+	ieee80211_vif_release_channel(sdata);
+	mutex_unlock(&local->mtx);
+
+	drv_remove_interface(local, sdata);
+
+	kfree(sdata);
+}
+
+/*
+ * NOTE: Be very careful when changing this function, it must NOT return
+ * an error on interface type changes that have been pre-checked, so most
+ * checks should be in ieee80211_check_concurrent_iface.
+ */
+int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	struct net_device *dev = wdev->netdev;
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+	u32 changed = 0;
+	int res;
+	u32 hw_reconf_flags = 0;
+
 	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_WDS:
+		if (!is_valid_ether_addr(sdata->u.wds.remote_addr))
+			return -ENOLINK;
 		break;
-	case NL80211_IFTYPE_MONITOR:
-		if (local->monitors == 0)
-			ieee80211_del_virtual_monitor(local);
+	case NL80211_IFTYPE_AP_VLAN: {
+		struct ieee80211_sub_if_data *master;
+
+		if (!sdata->bss)
+			return -ENOLINK;
 
 		mutex_lock(&local->mtx);
-		ieee80211_recalc_idle(local);
+		list_add(&sdata->u.vlan.list, &sdata->bss->vlans);
 		mutex_unlock(&local->mtx);
 
-		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
-			break;
-
-		fallthrough;
-	default:
-		if (going_down)
-			drv_remove_interface(local, sdata);
-	}
+		master = container_of(sdata->bss,
+				      struct ieee80211_sub_if_data, u.ap);
+		sdata->control_port_protocol =
+			master->control_port_protocol;
+		sdata->control_port_no_encrypt =
+			master->control_port_no_encrypt;
+		sdata->control_port_over_nl80211 =
+			master->control_port_over_nl80211;
+		sdata->control_port_no_preauth =
+			master->control_port_no_preauth;
+		sdata->vif.cab_queue = master->vif.cab_queue;
+		memcpy(sdata->vif.hw_queue, master->vif.hw_queue,
+		       sizeof(sdata->vif.hw_queue));
+		sdata->vif.bss_conf.chandef = master->vif.bss_conf.chandef;
 
-	ieee80211_recalc_ps(local);
+		mutex_lock(&local->key_mtx);
+		sdata->crypto_tx_tailroom_needed_cnt +=
+			master->crypto_tx_tailroom_needed_cnt;
+		mutex_unlock(&local->key_mtx);
 
-	if (cancel_scan)
-		flush_delayed_work(&local->scan_work);
+		break;
+		}
+	case NL80211_IFTYPE_AP:
+		sdata->bss = &sdata->u.ap;
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_OCB:
+	case NL80211_IFTYPE_NAN:
+		/* no special treatment */
+		break;
+	case NL80211_IFTYPE_UNSPECIFIED:
+	case NUM_NL80211_IFTYPES:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_P2P_GO:
+		/* cannot happen */
+		WARN_ON(1);
+		break;
+	}
 
 	if (local->open_count == 0) {
-		ieee80211_stop_device(local);
-
-		/* no reconfiguring after stop! */
-		return;
+		res = drv_start(local);
+		if (res)
+			goto err_del_bss;
+		/* we're brought up, everything changes */
+		hw_reconf_flags = ~0;
+		ieee80211_led_radio(local, true);
+		ieee80211_mod_tpt_led_trig(local,
+					   IEEE80211_TPT_LEDTRIG_FL_RADIO, 0);
 	}
 
-	/* do after stop to avoid reconfiguring when we stop anyway */
-	ieee80211_configure_filter(local);
-	ieee80211_hw_config(local, hw_reconf_flags);
-
-	if (local->monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
-}
+	/*
+	 * Copy the hopefully now-present MAC address to
+	 * this interface, if it has the special null one.
+	 */
+	if (dev && is_zero_ether_addr(dev->dev_addr)) {
+		memcpy(dev->dev_addr,
+		       local->hw.wiphy->perm_addr,
+		       ETH_ALEN);
+		memcpy(dev->perm_addr, dev->dev_addr, ETH_ALEN);
 
-static int ieee80211_stop(struct net_device *dev)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+		if (!is_valid_ether_addr(dev->dev_addr)) {
+			res = -EADDRNOTAVAIL;
+			goto err_stop;
+		}
+	}
 
-	ieee80211_do_stop(sdata, true);
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP_VLAN:
+		/* no need to tell driver, but set carrier and chanctx */
+		if (rtnl_dereference(sdata->bss->beacon)) {
+			ieee80211_vif_vlan_copy_chanctx(sdata);
+			netif_carrier_on(dev);
+			ieee80211_set_vif_encap_ops(sdata);
+		} else {
+			netif_carrier_off(dev);
+		}
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) {
+			local->cooked_mntrs++;
+			break;
+		}
 
-	return 0;
-}
+		if (sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
+			res = drv_add_interface(local, sdata);
+			if (res)
+				goto err_stop;
+		} else if (local->monitors == 0 && local->open_count == 0) {
+			res = ieee80211_add_virtual_monitor(local);
+			if (res)
+				goto err_stop;
+		}
 
-static void ieee80211_set_multicast_list(struct net_device *dev)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = sdata->local;
-	int allmulti, sdata_allmulti;
+		/* must be before the call to ieee80211_configure_filter */
+		local->monitors++;
+		if (local->monitors == 1) {
+			local->hw.conf.flags |= IEEE80211_CONF_MONITOR;
+			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
+		}
 
-	allmulti = !!(dev->flags & IFF_ALLMULTI);
-	sdata_allmulti = !!(sdata->flags & IEEE80211_SDATA_ALLMULTI);
+		ieee80211_adjust_monitor_flags(sdata, 1);
+		ieee80211_configure_filter(local);
+		ieee80211_recalc_offload(local);
+		mutex_lock(&local->mtx);
+		ieee80211_recalc_idle(local);
+		mutex_unlock(&local->mtx);
 
-	if (allmulti != sdata_allmulti) {
-		if (dev->flags & IFF_ALLMULTI)
-			atomic_inc(&local->iff_allmultis);
-		else
-			atomic_dec(&local->iff_allmultis);
-		sdata->flags ^= IEEE80211_SDATA_ALLMULTI;
-	}
+		netif_carrier_on(dev);
+		break;
+	default:
+		if (coming_up) {
+			ieee80211_del_virtual_monitor(local);
+			ieee80211_set_sdata_offload_flags(sdata);
 
-	spin_lock_bh(&local->filter_lock);
-	__hw_addr_sync(&local->mc_list, &dev->mc, dev->addr_len);
-	spin_unlock_bh(&local->filter_lock);
-	ieee80211_queue_work(&local->hw, &local->reconfig_filter);
-}
+			res = drv_add_interface(local, sdata);
+			if (res)
+				goto err_stop;
 
-/*
- * Called when the netdev is removed or, by the code below, before
- * the interface type changes.
- */
-static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
-{
-	int i;
+			ieee80211_set_vif_encap_ops(sdata);
+			res = ieee80211_check_queues(sdata,
+				ieee80211_vif_type_p2p(&sdata->vif));
+			if (res)
+				goto err_del_interface;
+		}
 
-	/* free extra data */
-	ieee80211_free_keys(sdata, false);
+		if (sdata->vif.type == NL80211_IFTYPE_AP) {
+			local->fif_pspoll++;
+			local->fif_probe_req++;
 
-	ieee80211_debugfs_remove_netdev(sdata);
+			ieee80211_configure_filter(local);
+		} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
+			local->fif_probe_req++;
+		}
 
-	for (i = 0; i < IEEE80211_FRAGMENT_MAX; i++)
-		__skb_queue_purge(&sdata->fragments[i].skb_list);
-	sdata->fragment_next = 0;
+		if (sdata->vif.probe_req_reg)
+			drv_config_iface_filter(local, sdata,
+						FIF_PROBE_REQ,
+						FIF_PROBE_REQ);
 
-	if (ieee80211_vif_is_mesh(&sdata->vif))
-		ieee80211_mesh_teardown_sdata(sdata);
-}
+		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
+		    sdata->vif.type != NL80211_IFTYPE_NAN)
+			changed |= ieee80211_reset_erp_info(sdata);
+		ieee80211_bss_info_change_notify(sdata, changed);
 
-static void ieee80211_uninit(struct net_device *dev)
-{
-	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
-}
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_ADHOC:
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_MESH_POINT:
+		case NL80211_IFTYPE_OCB:
+			netif_carrier_off(dev);
+			break;
+		case NL80211_IFTYPE_WDS:
+		case NL80211_IFTYPE_P2P_DEVICE:
+		case NL80211_IFTYPE_NAN:
+			break;
+		default:
+			/* not reached */
+			WARN_ON(1);
+		}
 
-static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-					 struct sk_buff *skb,
-					 struct net_device *sb_dev)
-{
-	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
-}
+		/*
+		 * Set default queue parameters so drivers don't
+		 * need to initialise the hardware if the hardware
+		 * doesn't start up with sane defaults.
+		 * Enable QoS for anything but station interfaces.
+		 */
+		ieee80211_set_wmm_default(sdata, true,
+			sdata->vif.type != NL80211_IFTYPE_STATION);
+	}
 
-static void
-ieee80211_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
-{
-	int i;
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	for_each_possible_cpu(i) {
-		const struct pcpu_sw_netstats *tstats;
-		u64 rx_packets, rx_bytes, tx_packets, tx_bytes;
-		unsigned int start;
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_WDS:
+		/* Create STA entry for the WDS peer */
+		sta = sta_info_alloc(sdata, sdata->u.wds.remote_addr,
+				     GFP_KERNEL);
+		if (!sta) {
+			res = -ENOMEM;
+			goto err_del_interface;
+		}
 
-		tstats = per_cpu_ptr(dev->tstats, i);
+		sta_info_pre_move_state(sta, IEEE80211_STA_AUTH);
+		sta_info_pre_move_state(sta, IEEE80211_STA_ASSOC);
+		sta_info_pre_move_state(sta, IEEE80211_STA_AUTHORIZED);
 
-		do {
-			start = u64_stats_fetch_begin_irq(&tstats->syncp);
-			rx_packets = tstats->rx_packets;
-			tx_packets = tstats->tx_packets;
-			rx_bytes = tstats->rx_bytes;
-			tx_bytes = tstats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&tstats->syncp, start));
+		res = sta_info_insert(sta);
+		if (res) {
+			/* STA has been freed */
+			goto err_del_interface;
+		}
 
-		stats->rx_packets += rx_packets;
-		stats->tx_packets += tx_packets;
-		stats->rx_bytes   += rx_bytes;
-		stats->tx_bytes   += tx_bytes;
+		rate_control_rate_init(sta);
+		netif_carrier_on(dev);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		rcu_assign_pointer(local->p2p_sdata, sdata);
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES)
+			break;
+		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
+		break;
+	default:
+		break;
 	}
-}
 
-static const struct net_device_ops ieee80211_dataif_ops = {
-	.ndo_open		= ieee80211_open,
-	.ndo_stop		= ieee80211_stop,
-	.ndo_uninit		= ieee80211_uninit,
-	.ndo_start_xmit		= ieee80211_subif_start_xmit,
-	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
-	.ndo_set_mac_address 	= ieee80211_change_mac,
-	.ndo_select_queue	= ieee80211_netdev_select_queue,
-	.ndo_get_stats64	= ieee80211_get_stats64,
-};
+	/*
+	 * set_multicast_list will be invoked by the networking core
+	 * which will check whether any increments here were done in
+	 * error and sync them down to the hardware as filter flags.
+	 */
+	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
+		atomic_inc(&local->iff_allmultis);
 
-static u16 ieee80211_monitor_select_queue(struct net_device *dev,
-					  struct sk_buff *skb,
-					  struct net_device *sb_dev)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr;
-	int len_rthdr;
+	if (coming_up)
+		local->open_count++;
 
-	if (local->hw.queues < IEEE80211_NUM_ACS)
-		return 0;
+	if (hw_reconf_flags)
+		ieee80211_hw_config(local, hw_reconf_flags);
 
-	/* reset flags and info before parsing radiotap header */
-	memset(info, 0, sizeof(*info));
+	ieee80211_recalc_ps(local);
 
-	if (!ieee80211_parse_tx_radiotap(skb, dev))
-		return 0; /* doesn't matter, frame will be dropped */
+	if (sdata->vif.type == NL80211_IFTYPE_MONITOR ||
+	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
+	    local->ops->wake_tx_queue) {
+		/* XXX: for AP_VLAN, actually track AP queues */
+		if (dev)
+			netif_tx_start_all_queues(dev);
+	} else if (dev) {
+		unsigned long flags;
+		int n_acs = IEEE80211_NUM_ACS;
+		int ac;
 
-	len_rthdr = ieee80211_get_radiotap_len(skb->data);
-	hdr = (struct ieee80211_hdr *)(skb->data + len_rthdr);
-	if (skb->len < len_rthdr + 2 ||
-	    skb->len < len_rthdr + ieee80211_hdrlen(hdr->frame_control))
-		return 0; /* doesn't matter, frame will be dropped */
+		if (local->hw.queues < IEEE80211_NUM_ACS)
+			n_acs = 1;
 
-	return ieee80211_select_queue_80211(sdata, skb, hdr);
-}
+		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
+		if (sdata->vif.cab_queue == IEEE80211_INVAL_HW_QUEUE ||
+		    (local->queue_stop_reasons[sdata->vif.cab_queue] == 0 &&
+		     skb_queue_empty(&local->pending[sdata->vif.cab_queue]))) {
+			for (ac = 0; ac < n_acs; ac++) {
+				int ac_queue = sdata->vif.hw_queue[ac];
 
-static const struct net_device_ops ieee80211_monitorif_ops = {
-	.ndo_open		= ieee80211_open,
-	.ndo_stop		= ieee80211_stop,
-	.ndo_uninit		= ieee80211_uninit,
-	.ndo_start_xmit		= ieee80211_monitor_start_xmit,
-	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
-	.ndo_set_mac_address 	= ieee80211_change_mac,
-	.ndo_select_queue	= ieee80211_monitor_select_queue,
-	.ndo_get_stats64	= ieee80211_get_stats64,
-};
+				if (local->queue_stop_reasons[ac_queue] == 0 &&
+				    skb_queue_empty(&local->pending[ac_queue]))
+					netif_start_subqueue(dev, ac);
+			}
+		}
+		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
+	}
 
-static const struct net_device_ops ieee80211_dataif_8023_ops = {
-	.ndo_open		= ieee80211_open,
-	.ndo_stop		= ieee80211_stop,
-	.ndo_uninit		= ieee80211_uninit,
-	.ndo_start_xmit		= ieee80211_subif_start_xmit_8023,
-	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
-	.ndo_set_mac_address	= ieee80211_change_mac,
-	.ndo_select_queue	= ieee80211_netdev_select_queue,
-	.ndo_get_stats64	= ieee80211_get_stats64,
-};
+	return 0;
+ err_del_interface:
+	drv_remove_interface(local, sdata);
+ err_stop:
+	if (!local->open_count)
+		drv_stop(local);
+ err_del_bss:
+	sdata->bss = NULL;
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		mutex_lock(&local->mtx);
+		list_del(&sdata->u.vlan.list);
+		mutex_unlock(&local->mtx);
+	}
+	/* might already be clear but that doesn't matter */
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
+	return res;
+}
 
 static void ieee80211_if_free(struct net_device *dev)
 {
@@ -1332,32 +1356,6 @@ static void ieee80211_if_setup_no_queue(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 }
 
-static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata)
-{
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_sub_if_data *bss = sdata;
-	bool enabled;
-
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-		if (!sdata->bss)
-			return;
-
-		bss = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
-	}
-
-	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) ||
-	    !ieee80211_iftype_supports_encap_offload(bss->vif.type))
-		return;
-
-	enabled = bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED;
-	if (sdata->wdev.use_4addr &&
-	    !(bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_4ADDR))
-		enabled = false;
-
-	sdata->dev->netdev_ops = enabled ? &ieee80211_dataif_8023_ops :
-					   &ieee80211_dataif_ops;
-}
-
 static void ieee80211_iface_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
-- 
2.28.0

