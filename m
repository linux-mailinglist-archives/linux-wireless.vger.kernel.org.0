Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89524573344
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiGMJpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiGMJpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC13F4223
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=VoqGlLR7ZgBlz3cz0BA8jK5Al/m9zBJbZH26cQn7aik=;
        t=1657705513; x=1658915113; b=jrJcUXAwc1ku7Qf9BG3YHV+oNmqF3svLtcz6DwW9O7RSQKT
        A80iDoSbKPbP+JSA45p+iiJ7abdoyRzVIlQTt+j84Hkb7SrpJOk3Sf+UO1OzMVIVf6cpAHUwDyijh
        xpdx7TIvLy8fWrJWAuf1odBT6JxpCKI7qFOXJTAXdcEEdFcQmRlp+yAw7AMbuAH+jWVbJeHcybKRA
        Gu1ZmXBQZWQkc5KnwsRkRF0dTqucFuyBOx+a+pC6/3hsIFTIuQ8dZBdkeWzKWqSsPgluv7hM/t5xm
        qbpR3jUxQJGRvtehsLtH3stilNqmJK3L1kaiOuFIZxsNQ6ghEHtBPoKvAQh3jIzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvf-00EgvB-Qf;
        Wed, 13 Jul 2022 11:45:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 25/76] wifi: mac80211: set up/tear down client vif links properly
Date:   Wed, 13 Jul 2022 11:44:11 +0200
Message-Id: <20220713114425.70b95740f779.I992e1fd211b441d2e624ceaa63d2404eadaa4a2f@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In station/client mode, the link data needs a bit more
initialization and destruction than just zero-init and
kfree() respectively, implement that.

This required some shuffling of the link data handling
in general, as we should set it up in setup and do the
teardown in teardown, otherwise we're asymmetric in
case of interface type changes.

Also stop using kfree_rcu(), we cannot guarantee that
nothing is scheduling things that live within the link
(e.g. the u.mgd.request_smps_work) until we're sure it
cannot be referenced anymore, therefore synchronize
instead. This isn't very efficient, but we can always
optimize it later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |   2 +
 net/mac80211/iface.c       | 346 ++++++++++++++++++++++---------------
 net/mac80211/mlme.c        |  35 ++--
 3 files changed, 232 insertions(+), 151 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8c14274c9aaf..05996df627ea 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1772,6 +1772,8 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
 				   u8 reason, bool tx);
+void ieee80211_mgd_setup_link(struct ieee80211_link_data *link);
+void ieee80211_mgd_stop_link(struct ieee80211_link_data *link);
 
 /* IBSS code */
 void ieee80211_ibss_notify_scan_completed(struct ieee80211_local *local);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 12789a62366c..3e1d46119f7a 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -368,6 +368,208 @@ static int ieee80211_open(struct net_device *dev)
 	return err;
 }
 
+static void ieee80211_link_setup(struct ieee80211_link_data *link)
+{
+	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
+		ieee80211_mgd_setup_link(link);
+}
+
+static void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
+				int link_id,
+				struct ieee80211_link_data *link,
+				struct ieee80211_bss_conf *link_conf)
+{
+	bool deflink = link_id < 0;
+
+	if (link_id < 0)
+		link_id = 0;
+
+	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
+	rcu_assign_pointer(sdata->link[link_id], link);
+
+	link->sdata = sdata;
+	link->link_id = link_id;
+	link->conf = link_conf;
+
+	INIT_WORK(&link->csa_finalize_work,
+		  ieee80211_csa_finalize_work);
+	INIT_WORK(&link->color_change_finalize_work,
+		  ieee80211_color_change_finalize_work);
+	INIT_LIST_HEAD(&link->assigned_chanctx_list);
+	INIT_LIST_HEAD(&link->reserved_chanctx_list);
+	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
+			  ieee80211_dfs_cac_timer_work);
+
+	if (!deflink) {
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_AP:
+			ether_addr_copy(link_conf->addr,
+					sdata->wdev.links[link_id].addr);
+			WARN_ON(!(sdata->wdev.valid_links & BIT(link_id)));
+			break;
+		case NL80211_IFTYPE_STATION:
+			eth_random_addr(link_conf->addr);
+			ether_addr_copy(sdata->wdev.links[link_id].addr,
+					link_conf->addr);
+			break;
+		default:
+			WARN_ON(1);
+		}
+	}
+}
+
+static void ieee80211_link_stop(struct ieee80211_link_data *link)
+{
+	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
+		ieee80211_mgd_stop_link(link);
+}
+
+struct link_container {
+	struct ieee80211_link_data data;
+	struct ieee80211_bss_conf conf;
+};
+
+static void ieee80211_free_links(struct ieee80211_sub_if_data *sdata,
+				 struct link_container **links)
+{
+	unsigned int link_id;
+
+	synchronize_rcu();
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		if (!links[link_id])
+			continue;
+		ieee80211_link_stop(&links[link_id]->data);
+		kfree(links[link_id]);
+	}
+}
+
+static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
+				      struct link_container **to_free,
+				      u16 new_links)
+{
+	u16 old_links = sdata->vif.valid_links;
+	unsigned long add = new_links & ~old_links;
+	unsigned long rem = old_links & ~new_links;
+	unsigned int link_id;
+	int ret;
+	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *link;
+	struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
+	bool use_deflink = old_links == 0; /* set for error case */
+
+	sdata_assert_lock(sdata);
+
+	memset(to_free, 0, sizeof(links));
+
+	if (old_links == new_links)
+		return 0;
+
+	/* allocate new link structures first */
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		link = kzalloc(sizeof(*link), GFP_KERNEL);
+		if (!link) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		links[link_id] = link;
+	}
+
+	/* keep track of the old pointers for the driver */
+	BUILD_BUG_ON(sizeof(old) != sizeof(sdata->vif.link_conf));
+	memcpy(old, sdata->vif.link_conf, sizeof(old));
+	/* and for us in error cases */
+	BUILD_BUG_ON(sizeof(old_data) != sizeof(sdata->link));
+	memcpy(old_data, sdata->link, sizeof(old_data));
+
+	/* link them into data structures */
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		WARN_ON(!use_deflink &&
+			rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink);
+
+		link = links[link_id];
+		ieee80211_link_init(sdata, link_id, &link->data, &link->conf);
+		ieee80211_link_setup(&link->data);
+	}
+
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		RCU_INIT_POINTER(sdata->link[link_id], NULL);
+		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
+	}
+
+	sdata->vif.valid_links = new_links;
+
+	/* tell the driver */
+	ret = drv_change_vif_links(sdata->local, sdata,
+				   old_links, new_links,
+				   old);
+	if (ret) {
+		/* restore config */
+		memcpy(sdata->link, old_data, sizeof(old_data));
+		memcpy(sdata->vif.link_conf, old, sizeof(old));
+		sdata->vif.valid_links = old_links;
+		/* and free the newly allocated links */
+		goto deinit;
+	}
+
+	/* use deflink/bss_conf again if and only if there are no more links */
+	use_deflink = new_links == 0;
+
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink)
+			continue;
+		/*
+		 * we must have allocated the data through this path so
+		 * we know we can free both at the same time
+		 */
+		to_free[link_id] = container_of(rcu_access_pointer(sdata->link[link_id]),
+						typeof(*links[link_id]),
+						data);
+	}
+
+	goto deinit;
+free:
+	/* if we failed during allocation, only free all */
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		kfree(links[link_id]);
+		links[link_id] = NULL;
+	}
+deinit:
+	if (use_deflink)
+		ieee80211_link_init(sdata, -1, &sdata->deflink,
+				    &sdata->vif.bss_conf);
+	return ret;
+}
+
+int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
+			    u16 new_links)
+{
+	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
+	int ret;
+
+	ret = ieee80211_vif_update_links(sdata, links, new_links);
+	ieee80211_free_links(sdata, links);
+
+	return ret;
+}
+
+static void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
+{
+	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	/*
+	 * The locking here is different because when we free links
+	 * in the station case we need to be able to cancel_work_sync()
+	 * something that also takes the lock.
+	 */
+
+	sdata_lock(sdata);
+	ieee80211_vif_update_links(sdata, links, 0);
+	sdata_unlock(sdata);
+
+	ieee80211_free_links(sdata, links);
+}
+
 static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_down)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -727,6 +929,9 @@ static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		ieee80211_mesh_teardown_sdata(sdata);
+
+	ieee80211_vif_clear_links(sdata);
+	ieee80211_link_stop(&sdata->deflink);
 }
 
 static void ieee80211_uninit(struct net_device *dev)
@@ -1019,50 +1224,6 @@ static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.cab_queue = IEEE80211_INVAL_HW_QUEUE;
 }
 
-static void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
-				int link_id,
-				struct ieee80211_link_data *link,
-				struct ieee80211_bss_conf *link_conf)
-{
-	bool deflink = link_id < 0;
-
-	if (link_id < 0)
-		link_id = 0;
-
-	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
-	rcu_assign_pointer(sdata->link[link_id], link);
-
-	link->sdata = sdata;
-	link->link_id = link_id;
-	link->conf = link_conf;
-
-	INIT_WORK(&link->csa_finalize_work,
-		  ieee80211_csa_finalize_work);
-	INIT_WORK(&link->color_change_finalize_work,
-		  ieee80211_color_change_finalize_work);
-	INIT_LIST_HEAD(&link->assigned_chanctx_list);
-	INIT_LIST_HEAD(&link->reserved_chanctx_list);
-	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
-			  ieee80211_dfs_cac_timer_work);
-
-	if (!deflink) {
-		switch (sdata->vif.type) {
-		case NL80211_IFTYPE_AP:
-			ether_addr_copy(link_conf->addr,
-					sdata->wdev.links[link_id].addr);
-			WARN_ON(!(sdata->wdev.valid_links & BIT(link_id)));
-			break;
-		case NL80211_IFTYPE_STATION:
-			eth_random_addr(link_conf->addr);
-			ether_addr_copy(sdata->wdev.links[link_id].addr,
-					link_conf->addr);
-			break;
-		default:
-			WARN_ON(1);
-		}
-	}
-}
-
 static void ieee80211_sdata_init(struct ieee80211_local *local,
 				 struct ieee80211_sub_if_data *sdata)
 {
@@ -1785,6 +1946,9 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
+	/* need to do this after the switch so vif.type is correct */
+	ieee80211_link_setup(&sdata->deflink);
+
 	ieee80211_debugfs_add_netdev(sdata);
 }
 
@@ -2353,97 +2517,3 @@ void ieee80211_vif_dec_num_mcast(struct ieee80211_sub_if_data *sdata)
 	else if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		atomic_dec(&sdata->u.vlan.num_mcast_sta);
 }
-
-int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
-			    u16 new_links)
-{
-	u16 old_links = sdata->vif.valid_links;
-	unsigned long add = new_links & ~old_links;
-	unsigned long rem = old_links & ~new_links;
-	unsigned int link_id;
-	int ret;
-	struct {
-		struct ieee80211_link_data data;
-		struct ieee80211_bss_conf conf;
-		struct rcu_head rcu_head;
-	} *links[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *link;
-	struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS];
-	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
-	bool use_deflink = old_links == 0; /* set for error case */
-
-	sdata_assert_lock(sdata);
-
-	if (old_links == new_links)
-		return 0;
-
-	/* allocate new link structures first */
-	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		link = kzalloc(sizeof(*link), GFP_KERNEL);
-		if (!link) {
-			ret = -ENOMEM;
-			goto free;
-		}
-		links[link_id] = link;
-	}
-
-	/* keep track of the old pointers for the driver */
-	BUILD_BUG_ON(sizeof(old) != sizeof(sdata->vif.link_conf));
-	memcpy(old, sdata->vif.link_conf, sizeof(old));
-	/* and for us in error cases */
-	BUILD_BUG_ON(sizeof(old_data) != sizeof(sdata->link));
-	memcpy(old_data, sdata->link, sizeof(old_data));
-
-	/* link them into data structures */
-	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		WARN_ON(!use_deflink &&
-			rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink);
-
-		link = links[link_id];
-		ieee80211_link_init(sdata, link_id, &link->data, &link->conf);
-	}
-
-	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		RCU_INIT_POINTER(sdata->link[link_id], NULL);
-		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
-	}
-
-	sdata->vif.valid_links = new_links;
-
-	/* tell the driver */
-	ret = drv_change_vif_links(sdata->local, sdata,
-				   old_links, new_links,
-				   old);
-	if (ret) {
-		/* restore config */
-		memcpy(sdata->link, old_data, sizeof(old_data));
-		memcpy(sdata->vif.link_conf, old, sizeof(old));
-		sdata->vif.valid_links = old_links;
-		/* and free the newly allocated links */
-		goto free;
-	}
-
-	/* use deflink/bss_conf again if and only if there are no more links */
-	use_deflink = new_links == 0;
-
-	/* now use this to free the old links */
-	memset(links, 0, sizeof(links));
-	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		if (rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink)
-			continue;
-		/*
-		 * we must have allocated the data through this path so
-		 * we know we can free both at the same time
-		 */
-		links[link_id] = container_of(rcu_access_pointer(sdata->link[link_id]),
-					      typeof(*links[link_id]),
-					      data);
-	}
-
-free:
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
-		kfree_rcu(links[link_id], rcu_head);
-	if (use_deflink)
-		ieee80211_link_init(sdata, -1, &sdata->deflink,
-				    &sdata->vif.bss_conf);
-	return ret;
-}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 73742f1a88ff..f994945039cd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5032,17 +5032,14 @@ static void ieee80211_request_smps_mgd_work(struct work_struct *work)
 /* interface setup */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 {
-	struct ieee80211_if_managed *ifmgd;
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	ifmgd = &sdata->u.mgd;
 	INIT_WORK(&ifmgd->monitor_work, ieee80211_sta_monitor_work);
 	INIT_WORK(&ifmgd->chswitch_work, ieee80211_chswitch_work);
 	INIT_WORK(&ifmgd->beacon_connection_loss_work,
 		  ieee80211_beacon_connection_loss_work);
 	INIT_WORK(&ifmgd->csa_connection_drop_work,
 		  ieee80211_csa_connection_drop_work);
-	INIT_WORK(&sdata->deflink.u.mgd.request_smps_work,
-		  ieee80211_request_smps_mgd_work);
 	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
 			  ieee80211_tdls_peer_del_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
@@ -5056,20 +5053,28 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmgd->powersave = sdata->wdev.ps;
 	ifmgd->uapsd_queues = sdata->local->hw.uapsd_queues;
 	ifmgd->uapsd_max_sp_len = sdata->local->hw.uapsd_max_sp_len;
-	sdata->deflink.u.mgd.p2p_noa_index = -1;
-	sdata->deflink.u.mgd.conn_flags = 0;
-
-	if (sdata->local->hw.wiphy->features & NL80211_FEATURE_DYNAMIC_SMPS)
-		sdata->deflink.u.mgd.req_smps = IEEE80211_SMPS_AUTOMATIC;
-	else
-		sdata->deflink.u.mgd.req_smps = IEEE80211_SMPS_OFF;
-
 	/* Setup TDLS data */
 	spin_lock_init(&ifmgd->teardown_lock);
 	ifmgd->teardown_skb = NULL;
 	ifmgd->orig_teardown_skb = NULL;
 }
 
+void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
+{
+	struct ieee80211_local *local = link->sdata->local;
+
+	link->u.mgd.p2p_noa_index = -1;
+	link->u.mgd.conn_flags = 0;
+	link->conf->bssid = link->u.mgd.bssid;
+
+	INIT_WORK(&link->u.mgd.request_smps_work,
+		  ieee80211_request_smps_mgd_work);
+	if (local->hw.wiphy->features & NL80211_FEATURE_DYNAMIC_SMPS)
+		link->u.mgd.req_smps = IEEE80211_SMPS_AUTOMATIC;
+	else
+		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
+}
+
 /* scan finished notification */
 void ieee80211_mlme_notify_scan_completed(struct ieee80211_local *local)
 {
@@ -6382,6 +6387,11 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
+{
+	cancel_work_sync(&link->u.mgd.request_smps_work);
+}
+
 void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -6393,7 +6403,6 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	 */
 	cancel_work_sync(&ifmgd->monitor_work);
 	cancel_work_sync(&ifmgd->beacon_connection_loss_work);
-	cancel_work_sync(&sdata->deflink.u.mgd.request_smps_work);
 	cancel_work_sync(&ifmgd->csa_connection_drop_work);
 	cancel_work_sync(&ifmgd->chswitch_work);
 	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
-- 
2.36.1

