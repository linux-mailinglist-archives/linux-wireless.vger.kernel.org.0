Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7E78AF9F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjH1MGW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjH1MFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0297123
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=brjvyO7RwIzw6F9iB7337shgkS+gROWjJdelYrvJkCk=;
        t=1693224347; x=1694433947; b=CK+5mhs+olf7XlLWQtC35UIgvB1NOhhuRKYWwmtzAmg5/e/
        sh2I3SEvzOKUzGGOhC694HvrVsGVSMz5n1WaZ1+B2UXlZ0+6PNrYV9BUPTxhFDbwT7iDUwaayfiI8
        WJ9Axb5RjdhH/4+EfoFkv1ubCeJJ0gWFWILI4iqNwDuER0IDTGPgz2wbo5ptQ3vaOc71na79Iopzk
        clJEA9wM+CdccvLtZlL0rBz2HHLW+36J7wtrXZy5RSWgVNypHs3h/g74b709cNIDE0A40k4R0D92r
        xrych00GpyrgAgSC811asAOeZBNE5AbUU1SmL50SBiXY6IGFFGuKakC5V2zl/A3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab05-00Gjgt-1b;
        Mon, 28 Aug 2023 14:05:45 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 33/40] wifi: mac80211: remove sta_mtx
Date:   Mon, 28 Aug 2023 14:00:01 +0200
Message-ID: <20230828135928.917909b5954f.I81a21aafae702b20349aef8ecb73538f394c3b72@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We now hold the wiphy mutex everywhere that we use or
needed the sta_mtx, so we don't need this mutex any
more. Remove it.

Most of this change was done automatically with spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 112 ++++++++++++-------------------------
 net/mac80211/debugfs.c     |   5 +-
 net/mac80211/driver-ops.c  |   4 +-
 net/mac80211/ethtool.c     |   3 -
 net/mac80211/ibss.c        |   4 +-
 net/mac80211/ieee80211_i.h |   5 +-
 net/mac80211/iface.c       |   8 +--
 net/mac80211/key.c         |   4 +-
 net/mac80211/link.c        |   3 +-
 net/mac80211/mlme.c        |  31 +++-------
 net/mac80211/pm.c          |   6 +-
 net/mac80211/rx.c          |   6 +-
 net/mac80211/s1g.c         |  15 ++---
 net/mac80211/sta_info.c    |  81 ++++++++++-----------------
 net/mac80211/sta_info.h    |   2 +-
 net/mac80211/tdls.c        |  26 +++------
 net/mac80211/tx.c          |   4 +-
 net/mac80211/util.c        |   7 +--
 18 files changed, 112 insertions(+), 214 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d3fc6a2d1454..94f99d3d73dc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -214,6 +214,8 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 	struct sta_info *sta;
 	int ret;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	ret = ieee80211_if_change_type(sdata, type);
 	if (ret)
 		return ret;
@@ -235,12 +237,10 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 		if (!ifmgd->associated)
 			return 0;
 
-		mutex_lock(&local->sta_mtx);
 		sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 		if (sta)
 			drv_sta_set_4addr(local, sdata, &sta->sta,
 					  params->use_4addr);
-		mutex_unlock(&local->sta_mtx);
 
 		if (params->use_4addr)
 			ieee80211_send_4addr_nullfunc(local, sdata);
@@ -472,7 +472,8 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta = NULL;
 	struct ieee80211_key *key;
-	int err;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ieee80211_sdata_running(sdata))
 		return -ENETDOWN;
@@ -510,8 +511,6 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	if (params->mode == NL80211_KEY_NO_TX)
 		key->conf.flags |= IEEE80211_KEY_FLAG_NO_AUTO_TX;
 
-	mutex_lock(&local->sta_mtx);
-
 	if (mac_addr) {
 		sta = sta_info_get_bss(sdata, mac_addr);
 		/*
@@ -526,8 +525,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		 */
 		if (!sta || !test_sta_flag(sta, WLAN_STA_ASSOC)) {
 			ieee80211_key_free_unused(key);
-			err = -ENOENT;
-			goto out_unlock;
+			return -ENOENT;
 		}
 	}
 
@@ -565,12 +563,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		break;
 	}
 
-	err = ieee80211_key_link(key, link, sta);
-
- out_unlock:
-	mutex_unlock(&local->sta_mtx);
-
-	return err;
+	return ieee80211_key_link(key, link, sta);
 }
 
 static struct ieee80211_key *
@@ -598,7 +591,7 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata, int link_id,
 
 		if (link_id >= 0) {
 			link_sta = rcu_dereference_check(sta->link[link_id],
-							 lockdep_is_held(&local->sta_mtx));
+							 lockdep_is_held(&local->hw.wiphy->mtx));
 			if (!link_sta)
 				return NULL;
 		} else {
@@ -643,7 +636,8 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_key *key;
 	int ret;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	mutex_lock(&local->key_mtx);
 
 	key = ieee80211_lookup_key(sdata, link_id, key_idx, pairwise, mac_addr);
@@ -657,7 +651,6 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 	ret = 0;
  out_unlock:
 	mutex_unlock(&local->key_mtx);
-	mutex_unlock(&local->sta_mtx);
 
 	return ret;
 }
@@ -860,7 +853,7 @@ static int ieee80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
 	struct sta_info *sta;
 	int ret = -ENOENT;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sta = sta_info_get_by_idx(sdata, idx);
 	if (sta) {
@@ -869,8 +862,6 @@ static int ieee80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
 		sta_set_sinfo(sta, sinfo, true);
 	}
 
-	mutex_unlock(&local->sta_mtx);
-
 	return ret;
 }
 
@@ -890,7 +881,7 @@ static int ieee80211_get_station(struct wiphy *wiphy, struct net_device *dev,
 	struct sta_info *sta;
 	int ret = -ENOENT;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sta = sta_info_get_bss(sdata, mac);
 	if (sta) {
@@ -898,8 +889,6 @@ static int ieee80211_get_station(struct wiphy *wiphy, struct net_device *dev,
 		sta_set_sinfo(sta, sinfo, true);
 	}
 
-	mutex_unlock(&local->sta_mtx);
-
 	return ret;
 }
 
@@ -1800,7 +1789,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		sdata_dereference(sdata->link[link_id], sdata);
 	struct link_sta_info *link_sta =
 		rcu_dereference_protected(sta->link[link_id],
-					  lockdep_is_held(&local->sta_mtx));
+					  lockdep_is_held(&local->hw.wiphy->mtx));
 
 	/*
 	 * If there are no changes, then accept a link that doesn't exist,
@@ -2034,6 +2023,8 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_sub_if_data *sdata;
 	int err;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (params->vlan) {
 		sdata = IEEE80211_DEV_TO_SUB_IF(params->vlan);
 
@@ -2077,9 +2068,7 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	 * visible yet), sta_apply_parameters (and inner functions) require
 	 * the mutex due to other paths.
 	 */
-	mutex_lock(&local->sta_mtx);
 	err = sta_apply_parameters(local, sta, params);
-	mutex_unlock(&local->sta_mtx);
 	if (err) {
 		sta_info_free(local, sta);
 		return err;
@@ -2122,13 +2111,11 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 	enum cfg80211_station_type statype;
 	int err;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sta = sta_info_get_bss(sdata, mac);
-	if (!sta) {
-		err = -ENOENT;
-		goto out_err;
-	}
+	if (!sta)
+		return -ENOENT;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_MESH_POINT:
@@ -2158,22 +2145,19 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 			statype = CFG80211_STA_AP_CLIENT_UNASSOC;
 		break;
 	default:
-		err = -EOPNOTSUPP;
-		goto out_err;
+		return -EOPNOTSUPP;
 	}
 
 	err = cfg80211_check_station_change(wiphy, params, statype);
 	if (err)
-		goto out_err;
+		return err;
 
 	if (params->vlan && params->vlan != sta->sdata->dev) {
 		vlansdata = IEEE80211_DEV_TO_SUB_IF(params->vlan);
 
 		if (params->vlan->ieee80211_ptr->use_4addr) {
-			if (vlansdata->u.vlan.sta) {
-				err = -EBUSY;
-				goto out_err;
-			}
+			if (vlansdata->u.vlan.sta)
+				return -EBUSY;
 
 			rcu_assign_pointer(vlansdata->u.vlan.sta, sta);
 			__ieee80211_check_fast_rx_iface(vlansdata);
@@ -2208,9 +2192,7 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		err = sta_apply_parameters(local, sta, params);
 	}
 	if (err)
-		goto out_err;
-
-	mutex_unlock(&local->sta_mtx);
+		return err;
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
 	    params->sta_flags_mask & BIT(NL80211_STA_FLAG_AUTHORIZED)) {
@@ -2219,9 +2201,6 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 	}
 
 	return 0;
-out_err:
-	mutex_unlock(&local->sta_mtx);
-	return err;
 }
 
 #ifdef CONFIG_MAC80211_MESH
@@ -4563,7 +4542,8 @@ static int ieee80211_set_tid_config(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct sta_info *sta;
-	int ret;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (!sdata->local->ops->set_tid_config)
 		return -EOPNOTSUPP;
@@ -4571,17 +4551,11 @@ static int ieee80211_set_tid_config(struct wiphy *wiphy,
 	if (!tid_conf->peer)
 		return drv_set_tid_config(sdata->local, sdata, NULL, tid_conf);
 
-	mutex_lock(&sdata->local->sta_mtx);
 	sta = sta_info_get_bss(sdata, tid_conf->peer);
-	if (!sta) {
-		mutex_unlock(&sdata->local->sta_mtx);
+	if (!sta)
 		return -ENOENT;
-	}
 
-	ret = drv_set_tid_config(sdata->local, sdata, &sta->sta, tid_conf);
-	mutex_unlock(&sdata->local->sta_mtx);
-
-	return ret;
+	return drv_set_tid_config(sdata->local, sdata, &sta->sta, tid_conf);
 }
 
 static int ieee80211_reset_tid_config(struct wiphy *wiphy,
@@ -4590,7 +4564,8 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct sta_info *sta;
-	int ret;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (!sdata->local->ops->reset_tid_config)
 		return -EOPNOTSUPP;
@@ -4598,17 +4573,11 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 	if (!peer)
 		return drv_reset_tid_config(sdata->local, sdata, NULL, tids);
 
-	mutex_lock(&sdata->local->sta_mtx);
 	sta = sta_info_get_bss(sdata, peer);
-	if (!sta) {
-		mutex_unlock(&sdata->local->sta_mtx);
+	if (!sta)
 		return -ENOENT;
-	}
 
-	ret = drv_reset_tid_config(sdata->local, sdata, &sta->sta, tids);
-	mutex_unlock(&sdata->local->sta_mtx);
-
-	return ret;
+	return drv_reset_tid_config(sdata->local, sdata, &sta->sta, tids);
 }
 
 static int ieee80211_set_sar_specs(struct wiphy *wiphy,
@@ -4934,13 +4903,10 @@ ieee80211_add_link_station(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = wiphy_priv(wiphy);
-	int ret;
 
-	mutex_lock(&sdata->local->sta_mtx);
-	ret = sta_add_link_station(local, sdata, params);
-	mutex_unlock(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	return ret;
+	return sta_add_link_station(local, sdata, params);
 }
 
 static int sta_mod_link_station(struct ieee80211_local *local,
@@ -4965,13 +4931,10 @@ ieee80211_mod_link_station(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = wiphy_priv(wiphy);
-	int ret;
 
-	mutex_lock(&sdata->local->sta_mtx);
-	ret = sta_mod_link_station(local, sdata, params);
-	mutex_unlock(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	return ret;
+	return sta_mod_link_station(local, sdata, params);
 }
 
 static int sta_del_link_station(struct ieee80211_sub_if_data *sdata,
@@ -5000,13 +4963,10 @@ ieee80211_del_link_station(struct wiphy *wiphy, struct net_device *dev,
 			   struct link_station_del_parameters *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	int ret;
 
-	mutex_lock(&sdata->local->sta_mtx);
-	ret = sta_del_link_station(sdata, params);
-	mutex_unlock(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	return ret;
+	return sta_del_link_station(sdata, params);
 }
 
 static int ieee80211_set_hw_timestamp(struct wiphy *wiphy,
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2efc6ccbfcf6..b575ae90e57f 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -288,10 +288,10 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	q_limit_low_old = local->aql_txq_limit_low[ac];
 	q_limit_high_old = local->aql_txq_limit_high[ac];
 
+	wiphy_lock(local->hw.wiphy);
 	local->aql_txq_limit_low[ac] = q_limit_low;
 	local->aql_txq_limit_high[ac] = q_limit_high;
 
-	mutex_lock(&local->sta_mtx);
 	list_for_each_entry(sta, &local->sta_list, list) {
 		/* If a sta has customized queue limits, keep it */
 		if (sta->airtime[ac].aql_limit_low == q_limit_low_old &&
@@ -300,7 +300,8 @@ static ssize_t aql_txq_limit_write(struct file *file,
 			sta->airtime[ac].aql_limit_high = q_limit_high;
 		}
 	}
-	mutex_unlock(&local->sta_mtx);
+	wiphy_unlock(local->hw.wiphy);
+
 	return count;
 }
 
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 97043d732f2e..9fc110264808 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -569,7 +569,7 @@ int drv_change_sta_links(struct ieee80211_local *local,
 
 	for_each_set_bit(link_id, &links_to_rem, IEEE80211_MLD_MAX_NUM_LINKS) {
 		link_sta = rcu_dereference_protected(info->link[link_id],
-						     lockdep_is_held(&local->sta_mtx));
+						     lockdep_is_held(&local->hw.wiphy->mtx));
 
 		ieee80211_link_sta_debugfs_drv_remove(link_sta);
 	}
@@ -585,7 +585,7 @@ int drv_change_sta_links(struct ieee80211_local *local,
 
 	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		link_sta = rcu_dereference_protected(info->link[link_id],
-						     lockdep_is_held(&local->sta_mtx));
+						     lockdep_is_held(&local->hw.wiphy->mtx));
 		ieee80211_link_sta_debugfs_drv_add(link_sta);
 	}
 
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index c53208321c8f..9894d2024470 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -103,7 +103,6 @@ static void ieee80211_get_stats(struct net_device *dev,
 	 */
 
 	wiphy_lock(local->hw.wiphy);
-	mutex_lock(&local->sta_mtx);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
 		sta = sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);
@@ -199,8 +198,6 @@ static void ieee80211_get_stats(struct net_device *dev,
 	else
 		data[i++] = -1LL;
 
-	mutex_unlock(&local->sta_mtx);
-
 	if (WARN_ON(i != STA_STATS_LEN)) {
 		wiphy_unlock(local->hw.wiphy);
 		return;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index e1900077bc4b..d68650cbd5ff 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1257,7 +1257,7 @@ static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 	unsigned long exp_time = IEEE80211_IBSS_INACTIVITY_LIMIT;
 	unsigned long exp_rsn = IEEE80211_IBSS_RSN_INACTIVITY_LIMIT;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
 		unsigned long last_active = ieee80211_sta_last_active(sta);
@@ -1282,8 +1282,6 @@ static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 			WARN_ON(__sta_info_destroy(sta));
 		}
 	}
-
-	mutex_unlock(&local->sta_mtx);
 }
 
 /*
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8d53ab9732f9..1bc921fcd52b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1435,10 +1435,9 @@ struct ieee80211_local {
 
 	/* Station data */
 	/*
-	 * The mutex only protects the list, hash table and
-	 * counter, reads are done with RCU.
+	 * The list, hash table and counter are protected
+	 * by the wiphy mutex, reads are done with RCU.
 	 */
-	struct mutex sta_mtx;
 	spinlock_t tim_lock;
 	unsigned long num_sta;
 	struct list_head sta_list;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 343343a7a3e2..eb93caf0be87 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1503,12 +1503,13 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 {
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (ieee80211_is_action(mgmt->frame_control) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK) {
 		struct sta_info *sta;
 		int len = skb->len;
 
-		mutex_lock(&local->sta_mtx);
 		sta = sta_info_get_bss(sdata, mgmt->sa);
 		if (sta) {
 			switch (mgmt->u.action.u.addba_req.action_code) {
@@ -1529,7 +1530,6 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				break;
 			}
 		}
-		mutex_unlock(&local->sta_mtx);
 	} else if (ieee80211_is_action(mgmt->frame_control) &&
 		   mgmt->u.action.category == WLAN_CATEGORY_VHT) {
 		switch (mgmt->u.action.u.vht_group_notif.action_code) {
@@ -1543,7 +1543,6 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 			band = status->band;
 			opmode = mgmt->u.action.u.vht_opmode_notif.operating_mode;
 
-			mutex_lock(&local->sta_mtx);
 			sta = sta_info_get_bss(sdata, mgmt->sa);
 
 			if (sta)
@@ -1551,7 +1550,6 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 							    &sta->deflink,
 							    opmode, band);
 
-			mutex_unlock(&local->sta_mtx);
 			break;
 		}
 		case WLAN_VHT_ACTION_GROUPID_MGMT:
@@ -1598,7 +1596,6 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		 * a block-ack session was active. That cannot be
 		 * right, so terminate the session.
 		 */
-		mutex_lock(&local->sta_mtx);
 		sta = sta_info_get_bss(sdata, mgmt->sa);
 		if (sta) {
 			u16 tid = ieee80211_get_tid(hdr);
@@ -1608,7 +1605,6 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				WLAN_REASON_QSTA_REQUIRE_SETUP,
 				true);
 		}
-		mutex_unlock(&local->sta_mtx);
 	} else switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
 		ieee80211_sta_rx_queued_mgmt(sdata, skb);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index fbd9f9a9001c..c5bbac4393ab 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -482,7 +482,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 
 		if (sta) {
 			link_sta = rcu_dereference_protected(sta->link[link_id],
-							     lockdep_is_held(&sta->local->sta_mtx));
+							     lockdep_is_held(&sta->local->hw.wiphy->mtx));
 			if (!link_sta)
 				return -ENOLINK;
 		}
@@ -877,7 +877,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 
 		if (link_id >= 0) {
 			link_sta = rcu_dereference_protected(sta->link[link_id],
-							     lockdep_is_held(&sta->local->sta_mtx));
+							     lockdep_is_held(&sta->local->hw.wiphy->mtx));
 			if (!link_sta) {
 				ret = -ENOLINK;
 				goto out;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 72b5000502a5..71815b8d44af 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -455,7 +455,7 @@ int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 	int ret;
 
 	sdata_assert_lock(sdata);
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	mutex_lock(&local->mtx);
 	mutex_lock(&local->key_mtx);
 	old_active = sdata->vif.active_links;
@@ -475,7 +475,6 @@ int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 	}
 	mutex_unlock(&local->key_mtx);
 	mutex_unlock(&local->mtx);
-	mutex_unlock(&local->sta_mtx);
 
 	return ret;
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a35769dac162..4296168877e8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3207,11 +3207,10 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	ifmgd->probe_send_count++;
 
 	if (dst) {
-		mutex_lock(&sdata->local->sta_mtx);
+		lockdep_assert_wiphy(sdata->local->hw.wiphy);
 		sta = sta_info_get(sdata, dst);
 		if (!WARN_ON(!sta))
 			ieee80211_check_fast_rx(sta);
-		mutex_unlock(&sdata->local->sta_mtx);
 	}
 
 	if (ieee80211_hw_check(&sdata->local->hw, REPORTS_TX_ACK_STATUS)) {
@@ -3629,7 +3628,6 @@ static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	const u8 *ap_addr = ifmgd->auth_data->ap_addr;
 	struct sta_info *sta;
-	bool result = true;
 
 	sdata_info(sdata, "authenticated\n");
 	ifmgd->auth_data->done = true;
@@ -3638,22 +3636,18 @@ static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
 	run_again(sdata, ifmgd->auth_data->timeout);
 
 	/* move station state to auth */
-	mutex_lock(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 	sta = sta_info_get(sdata, ap_addr);
 	if (!sta) {
 		WARN_ONCE(1, "%s: STA %pM not found", sdata->name, ap_addr);
-		result = false;
-		goto out;
+		return false;
 	}
 	if (sta_info_move_state(sta, IEEE80211_STA_AUTH)) {
 		sdata_info(sdata, "failed moving %pM to auth\n", ap_addr);
-		result = false;
-		goto out;
+		return false;
 	}
 
-out:
-	mutex_unlock(&sdata->local->sta_mtx);
-	return result;
+	return true;
 }
 
 static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
@@ -5099,7 +5093,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	u16 valid_links = 0, dormant_links = 0;
 	int err;
 
-	mutex_lock(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 	/*
 	 * station info was already allocated and inserted before
 	 * the association and should be available to us
@@ -5147,7 +5141,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 					" (assoc)" : "");
 
 		link_sta = rcu_dereference_protected(sta->link[link_id],
-						     lockdep_is_held(&local->sta_mtx));
+						     lockdep_is_held(&local->hw.wiphy->mtx));
 		if (WARN_ON(!link_sta))
 			goto out_err;
 
@@ -5234,8 +5228,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	if (sdata->wdev.use_4addr)
 		drv_sta_set_4addr(local, sdata, &sta->sta, true);
 
-	mutex_unlock(&sdata->local->sta_mtx);
-
 	ieee80211_set_associated(sdata, assoc_data, changed);
 
 	/*
@@ -5255,7 +5247,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	return true;
 out_err:
 	eth_zero_addr(sdata->vif.cfg.ap_addr);
-	mutex_unlock(&sdata->local->sta_mtx);
 	return false;
 }
 
@@ -6142,16 +6133,14 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				le16_to_cpu(mgmt->u.beacon.capab_info),
 				erp_valid, erp_value);
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 	if (WARN_ON(!sta)) {
-		mutex_unlock(&local->sta_mtx);
 		goto free;
 	}
 	link_sta = rcu_dereference_protected(sta->link[link->link_id],
-					     lockdep_is_held(&local->sta_mtx));
+					     lockdep_is_held(&local->hw.wiphy->mtx));
 	if (WARN_ON(!link_sta)) {
-		mutex_unlock(&local->sta_mtx);
 		goto free;
 	}
 
@@ -6167,7 +6156,6 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				elems->vht_operation, elems->he_operation,
 				elems->eht_operation,
 				elems->s1g_oper, bssid, &changed)) {
-		mutex_unlock(&local->sta_mtx);
 		sdata_info(sdata,
 			   "failed to follow AP %pM bandwidth change, disconnect\n",
 			   bssid);
@@ -6185,7 +6173,6 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		ieee80211_vht_handle_opmode(sdata, link_sta,
 					    *elems->opmode_notif,
 					    rx_status->band);
-	mutex_unlock(&local->sta_mtx);
 
 	changed |= ieee80211_handle_pwr_constr(link, chan, mgmt,
 					       elems->country_elem,
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index e52dbf7d14fb..c1fa26e09479 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -40,13 +40,12 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 
 	if (ieee80211_hw_check(hw, AMPDU_AGGREGATION) &&
 	    !(wowlan && wowlan->any)) {
-		mutex_lock(&local->sta_mtx);
+		lockdep_assert_wiphy(local->hw.wiphy);
 		list_for_each_entry(sta, &local->sta_list, list) {
 			set_sta_flag(sta, WLAN_STA_BLOCK_BA);
 			ieee80211_sta_tear_down_BA_sessions(
 					sta, AGG_STOP_LOCAL_REQUEST);
 		}
-		mutex_unlock(&local->sta_mtx);
 	}
 
 	/* keep sched_scan only in case of 'any' trigger */
@@ -119,12 +118,11 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 			local->quiescing = false;
 			local->wowlan = false;
 			if (ieee80211_hw_check(hw, AMPDU_AGGREGATION)) {
-				mutex_lock(&local->sta_mtx);
+				lockdep_assert_wiphy(local->hw.wiphy);
 				list_for_each_entry(sta,
 						    &local->sta_list, list) {
 					clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
 				}
-				mutex_unlock(&local->sta_mtx);
 			}
 			ieee80211_wake_queues_by_reason(hw,
 					IEEE80211_MAX_QUEUE_MAP,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e751cda5eef6..6fcd2a717922 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4669,7 +4669,7 @@ void __ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
-	lockdep_assert_held(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata &&
@@ -4683,9 +4683,9 @@ void ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	__ieee80211_check_fast_rx_iface(sdata);
-	mutex_unlock(&local->sta_mtx);
 }
 
 static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index c1f964e9991c..d4ed0c0a335c 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -2,6 +2,7 @@
 /*
  * S1G handling
  * Copyright(c) 2020 Adapt-IP
+ * Copyright (C) 2023 Intel Corporation
  */
 #include <linux/ieee80211.h>
 #include <net/mac80211.h>
@@ -153,11 +154,11 @@ void ieee80211_s1g_rx_twt_action(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sta = sta_info_get_bss(sdata, mgmt->sa);
 	if (!sta)
-		goto out;
+		return;
 
 	switch (mgmt->u.action.u.s1g.action_code) {
 	case WLAN_S1G_TWT_SETUP:
@@ -169,9 +170,6 @@ void ieee80211_s1g_rx_twt_action(struct ieee80211_sub_if_data *sdata,
 	default:
 		break;
 	}
-
-out:
-	mutex_unlock(&local->sta_mtx);
 }
 
 void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
@@ -181,11 +179,11 @@ void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sta = sta_info_get_bss(sdata, mgmt->da);
 	if (!sta)
-		goto out;
+		return;
 
 	switch (mgmt->u.action.u.s1g.action_code) {
 	case WLAN_S1G_TWT_SETUP:
@@ -195,7 +193,4 @@ void ieee80211_s1g_status_twt_action(struct ieee80211_sub_if_data *sdata,
 	default:
 		break;
 	}
-
-out:
-	mutex_unlock(&local->sta_mtx);
 }
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index b68bf77b05d0..eee541251c48 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -88,7 +88,6 @@ static const struct rhashtable_params link_sta_rht_params = {
 	.max_size = CONFIG_MAC80211_STA_HASH_MAX_SIZE,
 };
 
-/* Caller must hold local->sta_mtx */
 static int sta_info_hash_del(struct ieee80211_local *local,
 			     struct sta_info *sta)
 {
@@ -99,19 +98,19 @@ static int sta_info_hash_del(struct ieee80211_local *local,
 static int link_sta_info_hash_add(struct ieee80211_local *local,
 				  struct link_sta_info *link_sta)
 {
-	lockdep_assert_held(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	return rhltable_insert(&local->link_sta_hash,
-			       &link_sta->link_hash_node,
-			       link_sta_rht_params);
+			       &link_sta->link_hash_node, link_sta_rht_params);
 }
 
 static int link_sta_info_hash_del(struct ieee80211_local *local,
 				  struct link_sta_info *link_sta)
 {
-	lockdep_assert_held(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	return rhltable_remove(&local->link_sta_hash,
-			       &link_sta->link_hash_node,
-			       link_sta_rht_params);
+			       &link_sta->link_hash_node, link_sta_rht_params);
 }
 
 static void __cleanup_single_sta(struct sta_info *sta)
@@ -331,7 +330,7 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
 	int i = 0;
 
 	list_for_each_entry_rcu(sta, &local->sta_list, list,
-				lockdep_is_held(&local->sta_mtx)) {
+				lockdep_is_held(&local->hw.wiphy->mtx)) {
 		if (sdata != sta->sdata)
 			continue;
 		if (i < idx) {
@@ -355,10 +354,9 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 	struct sta_link_alloc *alloc = NULL;
 	struct link_sta_info *link_sta;
 
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
+
 	link_sta = rcu_access_pointer(sta->link[link_id]);
-	if (link_sta != &sta->deflink)
-		lockdep_assert_held(&sta->local->sta_mtx);
-
 	if (WARN_ON(!link_sta))
 		return;
 
@@ -437,7 +435,6 @@ void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 	kfree(sta);
 }
 
-/* Caller must hold local->sta_mtx */
 static int sta_info_hash_add(struct ieee80211_local *local,
 			     struct sta_info *sta)
 {
@@ -717,6 +714,8 @@ static int sta_info_insert_check(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	/*
 	 * Can't be a WARN_ON because it can be triggered through a race:
 	 * something inserts a STA (on one CPU) without holding the RTNL
@@ -734,7 +733,6 @@ static int sta_info_insert_check(struct sta_info *sta)
 	 * for correctness.
 	 */
 	rcu_read_lock();
-	lockdep_assert_held(&sdata->local->sta_mtx);
 	if (ieee80211_hw_check(&sdata->local->hw, NEEDS_UNIQUE_STA_ADDR) &&
 	    ieee80211_find_sta_by_ifaddr(&sdata->local->hw, sta->addr, NULL)) {
 		rcu_read_unlock();
@@ -808,11 +806,6 @@ ieee80211_recalc_p2p_go_ps_allowed(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
-/*
- * should be called with sta_mtx locked
- * this function replaces the mutex lock
- * with a RCU lock
- */
 static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 {
 	struct ieee80211_local *local = sta->local;
@@ -820,7 +813,7 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	struct station_info *sinfo = NULL;
 	int err = 0;
 
-	lockdep_assert_held(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* check if STA exists already */
 	if (sta_info_get_bss(sdata, sta->sta.addr)) {
@@ -884,7 +877,7 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 			struct link_sta_info *link_sta;
 
 			link_sta = rcu_dereference_protected(sta->link[i],
-							     lockdep_is_held(&local->sta_mtx));
+							     lockdep_is_held(&local->hw.wiphy->mtx));
 
 			if (!link_sta)
 				continue;
@@ -906,7 +899,6 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 
 	/* move reference to rcu-protected */
 	rcu_read_lock();
-	mutex_unlock(&local->sta_mtx);
 
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
@@ -922,7 +914,6 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	synchronize_net();
  out_cleanup:
 	cleanup_single_sta(sta);
-	mutex_unlock(&local->sta_mtx);
 	kfree(sinfo);
 	rcu_read_lock();
 	return err;
@@ -934,13 +925,11 @@ int sta_info_insert_rcu(struct sta_info *sta) __acquires(RCU)
 	int err;
 
 	might_sleep();
-
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	err = sta_info_insert_check(sta);
 	if (err) {
 		sta_info_free(local, sta);
-		mutex_unlock(&local->sta_mtx);
 		rcu_read_lock();
 		return err;
 	}
@@ -1219,7 +1208,7 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 	local = sta->local;
 	sdata = sta->sdata;
 
-	lockdep_assert_held(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/*
 	 * Before removing the station from the driver and
@@ -1244,7 +1233,7 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 			continue;
 
 		link_sta = rcu_dereference_protected(sta->link[i],
-						     lockdep_is_held(&local->sta_mtx));
+						     lockdep_is_held(&local->hw.wiphy->mtx));
 
 		link_sta_info_hash_del(local, link_sta);
 	}
@@ -1398,7 +1387,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 	 */
 
 	might_sleep();
-	lockdep_assert_held(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
 		ret = _sta_info_move_state(sta, IEEE80211_STA_ASSOC, recalc);
@@ -1474,28 +1463,22 @@ int __must_check __sta_info_destroy(struct sta_info *sta)
 int sta_info_destroy_addr(struct ieee80211_sub_if_data *sdata, const u8 *addr)
 {
 	struct sta_info *sta;
-	int ret;
 
-	mutex_lock(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	sta = sta_info_get(sdata, addr);
-	ret = __sta_info_destroy(sta);
-	mutex_unlock(&sdata->local->sta_mtx);
-
-	return ret;
+	return __sta_info_destroy(sta);
 }
 
 int sta_info_destroy_addr_bss(struct ieee80211_sub_if_data *sdata,
 			      const u8 *addr)
 {
 	struct sta_info *sta;
-	int ret;
 
-	mutex_lock(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	sta = sta_info_get_bss(sdata, addr);
-	ret = __sta_info_destroy(sta);
-	mutex_unlock(&sdata->local->sta_mtx);
-
-	return ret;
+	return __sta_info_destroy(sta);
 }
 
 static void sta_info_cleanup(struct timer_list *t)
@@ -1535,7 +1518,6 @@ int sta_info_init(struct ieee80211_local *local)
 	}
 
 	spin_lock_init(&local->tim_lock);
-	mutex_init(&local->sta_mtx);
 	INIT_LIST_HEAD(&local->sta_list);
 
 	timer_setup(&local->sta_cleanup, sta_info_cleanup, 0);
@@ -1558,11 +1540,11 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans)
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	WARN_ON(vlans && sdata->vif.type != NL80211_IFTYPE_AP);
 	WARN_ON(vlans && !sdata->bss);
 
-	mutex_lock(&local->sta_mtx);
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
 		if (sdata == sta->sdata ||
 		    (vlans && sdata->bss == sta->sdata->bss)) {
@@ -1586,7 +1568,6 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans)
 		if (!support_p2p_ps)
 			ieee80211_recalc_p2p_go_ps_allowed(sdata);
 	}
-	mutex_unlock(&local->sta_mtx);
 
 	return ret;
 }
@@ -1597,7 +1578,7 @@ void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta, *tmp;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
 		unsigned long last_active = ieee80211_sta_last_active(sta);
@@ -1616,8 +1597,6 @@ void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 			WARN_ON(__sta_info_destroy(sta));
 		}
 	}
-
-	mutex_unlock(&local->sta_mtx);
 }
 
 struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(struct ieee80211_hw *hw,
@@ -2872,7 +2851,7 @@ int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
 	struct sta_link_alloc *alloc;
 	int ret;
 
-	lockdep_assert_held(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	/* must represent an MLD from the start */
 	if (WARN_ON(!sta->sta.valid_links))
@@ -2901,7 +2880,7 @@ int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
 
 void ieee80211_sta_free_link(struct sta_info *sta, unsigned int link_id)
 {
-	lockdep_assert_held(&sta->sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sta->sdata->local->hw.wiphy);
 
 	sta_remove_link(sta, link_id, false);
 }
@@ -2915,7 +2894,7 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 	int ret;
 
 	link_sta = rcu_dereference_protected(sta->link[link_id],
-					     lockdep_is_held(&sdata->local->sta_mtx));
+					     lockdep_is_held(&sdata->local->hw.wiphy->mtx));
 
 	if (WARN_ON(old_links == new_links || !link_sta))
 		return -EINVAL;
@@ -2959,7 +2938,7 @@ void ieee80211_sta_remove_link(struct sta_info *sta, unsigned int link_id)
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	u16 old_links = sta->sta.valid_links;
 
-	lockdep_assert_held(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	sta->sta.valid_links &= ~BIT(link_id);
 
@@ -2998,7 +2977,7 @@ bool lockdep_sta_mutex_held(struct ieee80211_sta *pubsta)
 {
 	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
 
-	return lockdep_is_held(&sta->local->sta_mtx);
+	return lockdep_is_held(&sta->local->hw.wiphy->mtx);
 }
 EXPORT_SYMBOL(lockdep_sta_mutex_held);
 #endif
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 1deab7e33a7c..c3cce280bc0f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -827,7 +827,7 @@ struct sta_info *sta_info_get(struct ieee80211_sub_if_data *sdata,
 struct sta_info *sta_info_get_bss(struct ieee80211_sub_if_data *sdata,
 				  const u8 *addr);
 
-/* user must hold sta_mtx or be in RCU critical section */
+/* user must hold wiphy mutex or be in RCU critical section */
 struct sta_info *sta_info_get_by_addrs(struct ieee80211_local *local,
 				       const u8 *sta_addr, const u8 *vif_addr);
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index fafbcef49ec0..e7bf25e3be07 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1479,10 +1479,9 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			break;
 		}
 
-		mutex_lock(&local->sta_mtx);
+		lockdep_assert_wiphy(local->hw.wiphy);
 		sta = sta_info_get(sdata, peer);
 		if (!sta) {
-			mutex_unlock(&local->sta_mtx);
 			ret = -ENOLINK;
 			break;
 		}
@@ -1491,7 +1490,6 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 		iee80211_tdls_recalc_ht_protection(sdata, sta);
 
 		set_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH);
-		mutex_unlock(&local->sta_mtx);
 
 		WARN_ON_ONCE(is_zero_ether_addr(sdata->u.mgd.tdls_peer) ||
 			     !ether_addr_equal(sdata->u.mgd.tdls_peer, peer));
@@ -1514,9 +1512,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 		ret = sta_info_destroy_addr(sdata, peer);
 
-		mutex_lock(&local->sta_mtx);
+		lockdep_assert_wiphy(local->hw.wiphy);
 		iee80211_tdls_recalc_ht_protection(sdata, NULL);
-		mutex_unlock(&local->sta_mtx);
 
 		iee80211_tdls_recalc_chanctx(sdata, NULL);
 		break;
@@ -1674,7 +1671,7 @@ ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		/* this may work, but is untested */
 		return -EOPNOTSUPP;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, addr);
 	if (!sta) {
 		tdls_dbg(sdata,
@@ -1704,7 +1701,6 @@ ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		set_sta_flag(sta, WLAN_STA_TDLS_OFF_CHANNEL);
 
 out:
-	mutex_unlock(&local->sta_mtx);
 	dev_kfree_skb_any(skb);
 	return ret;
 }
@@ -1718,26 +1714,24 @@ ieee80211_tdls_cancel_channel_switch(struct wiphy *wiphy,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	sta = sta_info_get(sdata, addr);
 	if (!sta) {
 		tdls_dbg(sdata,
 			 "Invalid TDLS peer %pM for channel switch cancel\n",
 			 addr);
-		goto out;
+		return;
 	}
 
 	if (!test_sta_flag(sta, WLAN_STA_TDLS_OFF_CHANNEL)) {
 		tdls_dbg(sdata, "TDLS channel switch not initiated by %pM\n",
 			 addr);
-		goto out;
+		return;
 	}
 
 	drv_tdls_cancel_channel_switch(local, sdata, &sta->sta);
 	clear_sta_flag(sta, WLAN_STA_TDLS_OFF_CHANNEL);
-
-out:
-	mutex_unlock(&local->sta_mtx);
 }
 
 static struct sk_buff *
@@ -1808,7 +1802,7 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, tf->sa);
 	if (!sta || !test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH)) {
 		tdls_dbg(sdata, "TDLS chan switch from non-peer sta %pM\n",
@@ -1871,7 +1865,6 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 		 tf->sa, params.status);
 
 out:
-	mutex_unlock(&local->sta_mtx);
 	dev_kfree_skb_any(params.tmpl_skb);
 	kfree(elems);
 	return ret;
@@ -1985,7 +1978,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 		goto free;
 	}
 
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, tf->sa);
 	if (!sta || !test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH)) {
 		tdls_dbg(sdata, "TDLS chan switch from non-peer sta %pM\n",
@@ -2032,7 +2025,6 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 		 tf->sa, params.chandef->chan->center_freq,
 		 params.chandef->width);
 out:
-	mutex_unlock(&local->sta_mtx);
 	dev_kfree_skb_any(params.tmpl_skb);
 free:
 	kfree(elems);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 5cff936c6211..1ff7d2368c32 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5927,7 +5927,7 @@ int ieee80211_reserve_tid(struct ieee80211_sta *pubsta, u8 tid)
 	int ret;
 	u32 queues;
 
-	lockdep_assert_held(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* only some cases are supported right now */
 	switch (sdata->vif.type) {
@@ -5988,7 +5988,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *pubsta, u8 tid)
 	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 
-	lockdep_assert_held(&sdata->local->sta_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	/* only some cases are supported right now */
 	switch (sdata->vif.type) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bb4c7dd03758..6187cb54a876 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2411,7 +2411,7 @@ static void ieee80211_reconfig_stations(struct ieee80211_sub_if_data *sdata)
 	struct sta_info *sta;
 
 	/* add STAs back */
-	mutex_lock(&local->sta_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	list_for_each_entry(sta, &local->sta_list, list) {
 		enum ieee80211_sta_state state;
 
@@ -2423,7 +2423,6 @@ static void ieee80211_reconfig_stations(struct ieee80211_sub_if_data *sdata)
 			WARN_ON(drv_sta_state(local, sta->sdata, sta, state,
 					      state + 1));
 	}
-	mutex_unlock(&local->sta_mtx);
 }
 
 static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
@@ -2902,7 +2901,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	 * are active. This is really a workaround though.
 	 */
 	if (ieee80211_hw_check(hw, AMPDU_AGGREGATION)) {
-		mutex_lock(&local->sta_mtx);
+		lockdep_assert_wiphy(local->hw.wiphy);
 
 		list_for_each_entry(sta, &local->sta_list, list) {
 			if (!local->resuming)
@@ -2910,8 +2909,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 						sta, AGG_STOP_LOCAL_REQUEST);
 			clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
 		}
-
-		mutex_unlock(&local->sta_mtx);
 	}
 
 	/*
-- 
2.41.0

