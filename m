Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E014EBA4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAaLXc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:23:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55900 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaLXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:23:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEm-0002GC-Ax; Fri, 31 Jan 2020 13:13:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:56 +0200
Message-Id: <20200131111300.891737-20-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 19/23] mac80211: Remove support for changing AP SMPS mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The SMPS feature is defined in the specification only to be
used by non-AP stations and not by APs, so remove the support
for changing the AP's SMPS mode dynamically.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/cfg.c            | 101 ++--------------------------------
 net/mac80211/debugfs_netdev.c |  13 +----
 net/mac80211/ht.c             |  22 --------
 net/mac80211/ieee80211_i.h    |   7 +--
 net/mac80211/iface.c          |   8 +--
 net/mac80211/sta_info.c       |  16 +-----
 6 files changed, 10 insertions(+), 157 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7035df5dc21a..283422eba675 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -989,20 +989,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (old)
 		return -EALREADY;
 
-	switch (params->smps_mode) {
-	case NL80211_SMPS_OFF:
-		sdata->smps_mode = IEEE80211_SMPS_OFF;
-		break;
-	case NL80211_SMPS_STATIC:
-		sdata->smps_mode = IEEE80211_SMPS_STATIC;
-		break;
-	case NL80211_SMPS_DYNAMIC:
-		sdata->smps_mode = IEEE80211_SMPS_DYNAMIC;
-		break;
-	default:
-		return -EINVAL;
-	}
-	sdata->u.ap.req_smps = sdata->smps_mode;
+	if (params->smps_mode != NL80211_SMPS_OFF)
+		return -ENOTSUPP;
+
+	sdata->smps_mode = IEEE80211_SMPS_OFF;
 
 	sdata->needed_rx_chains = sdata->local->rx_chains;
 
@@ -1175,7 +1165,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
-	sdata->u.ap.driver_smps_mode = IEEE80211_SMPS_OFF;
 
 	kfree(sdata->vif.bss_conf.ftmr_params);
 	sdata->vif.bss_conf.ftmr_params = NULL;
@@ -1700,20 +1689,6 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 
 	mutex_unlock(&local->sta_mtx);
 
-	if ((sdata->vif.type == NL80211_IFTYPE_AP ||
-	     sdata->vif.type == NL80211_IFTYPE_AP_VLAN) &&
-	    sta->known_smps_mode != sta->sdata->bss->req_smps &&
-	    test_sta_flag(sta, WLAN_STA_AUTHORIZED) &&
-	    sta_info_tx_streams(sta) != 1) {
-		ht_dbg(sta->sdata,
-		       "%pM just authorized and MIMO capable - update SMPS\n",
-		       sta->sta.addr);
-		ieee80211_send_smps_action(sta->sdata,
-			sta->sdata->bss->req_smps,
-			sta->sta.addr,
-			sta->sdata->vif.bss_conf.bssid);
-	}
-
 	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
 	    params->sta_flags_mask & BIT(NL80211_STA_FLAG_AUTHORIZED)) {
 		ieee80211_recalc_ps(local);
@@ -2645,74 +2620,6 @@ static int ieee80211_testmode_dump(struct wiphy *wiphy,
 }
 #endif
 
-int __ieee80211_request_smps_ap(struct ieee80211_sub_if_data *sdata,
-				enum ieee80211_smps_mode smps_mode)
-{
-	struct sta_info *sta;
-	enum ieee80211_smps_mode old_req;
-
-	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP))
-		return -EINVAL;
-
-	if (sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
-		return 0;
-
-	old_req = sdata->u.ap.req_smps;
-	sdata->u.ap.req_smps = smps_mode;
-
-	/* AUTOMATIC doesn't mean much for AP - don't allow it */
-	if (old_req == smps_mode ||
-	    smps_mode == IEEE80211_SMPS_AUTOMATIC)
-		return 0;
-
-	ht_dbg(sdata,
-	       "SMPS %d requested in AP mode, sending Action frame to %d stations\n",
-	       smps_mode, atomic_read(&sdata->u.ap.num_mcast_sta));
-
-	mutex_lock(&sdata->local->sta_mtx);
-	list_for_each_entry(sta, &sdata->local->sta_list, list) {
-		/*
-		 * Only stations associated to our AP and
-		 * associated VLANs
-		 */
-		if (sta->sdata->bss != &sdata->u.ap)
-			continue;
-
-		/* This station doesn't support MIMO - skip it */
-		if (sta_info_tx_streams(sta) == 1)
-			continue;
-
-		/*
-		 * Don't wake up a STA just to send the action frame
-		 * unless we are getting more restrictive.
-		 */
-		if (test_sta_flag(sta, WLAN_STA_PS_STA) &&
-		    !ieee80211_smps_is_restrictive(sta->known_smps_mode,
-						   smps_mode)) {
-			ht_dbg(sdata, "Won't send SMPS to sleeping STA %pM\n",
-			       sta->sta.addr);
-			continue;
-		}
-
-		/*
-		 * If the STA is not authorized, wait until it gets
-		 * authorized and the action frame will be sent then.
-		 */
-		if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
-			continue;
-
-		ht_dbg(sdata, "Sending SMPS to %pM\n", sta->sta.addr);
-		ieee80211_send_smps_action(sdata, smps_mode, sta->sta.addr,
-					   sdata->vif.bss_conf.bssid);
-	}
-	mutex_unlock(&sdata->local->sta_mtx);
-
-	sdata->smps_mode = smps_mode;
-	ieee80211_queue_work(&sdata->local->hw, &sdata->recalc_smps);
-
-	return 0;
-}
-
 int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 				 enum ieee80211_smps_mode smps_mode)
 {
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 64b544ae9966..3dbe7c5cefd1 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2020 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -254,15 +255,11 @@ static int ieee80211_set_smps(struct ieee80211_sub_if_data *sdata,
 	     smps_mode == IEEE80211_SMPS_AUTOMATIC))
 		return -EINVAL;
 
-	if (sdata->vif.type != NL80211_IFTYPE_STATION &&
-	    sdata->vif.type != NL80211_IFTYPE_AP)
+	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
 	sdata_lock(sdata);
-	if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		err = __ieee80211_request_smps_mgd(sdata, smps_mode);
-	else
-		err = __ieee80211_request_smps_ap(sdata, smps_mode);
+	err = __ieee80211_request_smps_mgd(sdata, smps_mode);
 	sdata_unlock(sdata);
 
 	return err;
@@ -282,10 +279,6 @@ static ssize_t ieee80211_if_fmt_smps(const struct ieee80211_sub_if_data *sdata,
 		return snprintf(buf, buflen, "request: %s\nused: %s\n",
 				smps_modes[sdata->u.mgd.req_smps],
 				smps_modes[sdata->smps_mode]);
-	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		return snprintf(buf, buflen, "request: %s\nused: %s\n",
-				smps_modes[sdata->u.ap.req_smps],
-				smps_modes[sdata->smps_mode]);
 	return -EINVAL;
 }
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index a8e144fd02f1..e32906202575 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -550,19 +550,6 @@ void ieee80211_request_smps_mgd_work(struct work_struct *work)
 	sdata_unlock(sdata);
 }
 
-void ieee80211_request_smps_ap_work(struct work_struct *work)
-{
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data,
-			     u.ap.request_smps_work);
-
-	sdata_lock(sdata);
-	if (sdata_dereference(sdata->u.ap.beacon, sdata))
-		__ieee80211_request_smps_ap(sdata,
-					    sdata->u.ap.driver_smps_mode);
-	sdata_unlock(sdata);
-}
-
 void ieee80211_request_smps(struct ieee80211_vif *vif,
 			    enum ieee80211_smps_mode smps_mode)
 {
@@ -578,15 +565,6 @@ void ieee80211_request_smps(struct ieee80211_vif *vif,
 		sdata->u.mgd.driver_smps_mode = smps_mode;
 		ieee80211_queue_work(&sdata->local->hw,
 				     &sdata->u.mgd.request_smps_work);
-	} else {
-		/* AUTOMATIC is meaningless in AP mode */
-		if (WARN_ON_ONCE(smps_mode == IEEE80211_SMPS_AUTOMATIC))
-			return;
-		if (sdata->u.ap.driver_smps_mode == smps_mode)
-			return;
-		sdata->u.ap.driver_smps_mode = smps_mode;
-		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->u.ap.request_smps_work);
 	}
 }
 /* this might change ... don't want non-open drivers using it */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b89543269f51..7074af92b536 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 
 #ifndef IEEE80211_I_H
@@ -292,10 +292,7 @@ struct ieee80211_if_ap {
 
 	struct ps_data ps;
 	atomic_t num_mcast_sta; /* number of stations receiving multicast */
-	enum ieee80211_smps_mode req_smps, /* requested smps mode */
-			 driver_smps_mode; /* smps mode request */
 
-	struct work_struct request_smps_work;
 	bool multicast_to_unicast;
 };
 
@@ -2148,8 +2145,6 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 			    enum nl80211_band band, u32 *basic_rates);
 int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 				 enum ieee80211_smps_mode smps_mode);
-int __ieee80211_request_smps_ap(struct ieee80211_sub_if_data *sdata,
-				enum ieee80211_smps_mode smps_mode);
 void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata);
 void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 99d913a6e651..2fb26bc105f8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -824,9 +824,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_ADHOC:
 		ieee80211_ibss_stop(sdata);
 		break;
-	case NL80211_IFTYPE_AP:
-		cancel_work_sync(&sdata->u.ap.request_smps_work);
-		break;
 	case NL80211_IFTYPE_MONITOR:
 		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES)
 			break;
@@ -1494,10 +1491,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP:
 		skb_queue_head_init(&sdata->u.ap.ps.bc_buf);
 		INIT_LIST_HEAD(&sdata->u.ap.vlans);
-		INIT_WORK(&sdata->u.ap.request_smps_work,
-			  ieee80211_request_smps_ap_work);
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
-		sdata->u.ap.req_smps = IEEE80211_SMPS_OFF;
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
 		type = NL80211_IFTYPE_STATION;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0f5f40678885..f357156b86ee 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -1351,20 +1351,6 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 
 	atomic_dec(&ps->num_sta_ps);
 
-	/* This station just woke up and isn't aware of our SMPS state */
-	if (!ieee80211_vif_is_mesh(&sdata->vif) &&
-	    !ieee80211_smps_is_restrictive(sta->known_smps_mode,
-					   sdata->smps_mode) &&
-	    sta->known_smps_mode != sdata->bss->req_smps &&
-	    sta_info_tx_streams(sta) != 1) {
-		ht_dbg(sdata,
-		       "%pM just woke up and MIMO capable - update SMPS\n",
-		       sta->sta.addr);
-		ieee80211_send_smps_action(sdata, sdata->bss->req_smps,
-					   sta->sta.addr,
-					   sdata->vif.bss_conf.bssid);
-	}
-
 	local->total_ps_buffered -= buffered;
 
 	sta_info_recalc_tim(sta);
-- 
2.24.1

