Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA09C78AFA1
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjH1MGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjH1MFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB7120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FZCNdz1MuLnWVsp73yWAWWUnyvwkN1OSDZqfor4nOx0=;
        t=1693224348; x=1694433948; b=tANfwaD9MfdBviUlfB/RmvLIjYPXiRQeaXV8Jrj/N3eQo39
        pTKBvmcVjUIJ+dVc9PjOmHKkIe3bpMEuu+O+kDv8yQyGUAcoGYmU7HcVkoYhnOjnq6lvjGK2qVHGH
        4FuwrXAPlYw71MWPIranidweHWq4O/Ly3PHTQPxAObBY2MCvi8TRHjsIt0UOsfqCqc1i6P0gX05Ta
        d/81mIkd5UwggegSOgxvJYDl0a5EDvR9Z7ONMU0mLQHUr2TKqoYYshwffDjTkjLaWUjv2xrhrLFwR
        yX9rKo2Q+1CePFIIKSmYsmie7+TLh4m1E+4+/V91wO21Fm6phCJKlorc1Rmo/qqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab06-00Gjgt-1V;
        Mon, 28 Aug 2023 14:05:46 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 34/40] wifi: mac80211: remove key_mtx
Date:   Mon, 28 Aug 2023 14:00:02 +0200
Message-ID: <20230828135928.bc3cb4678562.I4097b04cc71620b0bacd72d0e185d55897b673a2@changeid>
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
needed the key_mtx, so we don't need this mutex any
more. Remove it.

Most of this change was done automatically with spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  34 +++------
 net/mac80211/debugfs_key.c |  20 +++---
 net/mac80211/ieee80211_i.h |   6 --
 net/mac80211/iface.c       |   4 +-
 net/mac80211/key.c         | 144 +++++++++++++++++--------------------
 net/mac80211/key.h         |   6 --
 net/mac80211/link.c        |   3 +-
 net/mac80211/main.c        |   1 -
 net/mac80211/util.c        |   4 +-
 9 files changed, 90 insertions(+), 132 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 94f99d3d73dc..889145328754 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -452,13 +452,11 @@ static int ieee80211_set_tx(struct ieee80211_sub_if_data *sdata,
 	if (sta->ptk_idx == key_idx)
 		return 0;
 
-	mutex_lock(&local->key_mtx);
-	key = key_mtx_dereference(local, sta->ptk[key_idx]);
+	key = wiphy_dereference(local->hw.wiphy, sta->ptk[key_idx]);
 
 	if (key && key->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX)
 		ret = ieee80211_set_tx_key(key);
 
-	mutex_unlock(&local->key_mtx);
 	return ret;
 }
 
@@ -599,30 +597,29 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata, int link_id,
 		}
 
 		if (pairwise && key_idx < NUM_DEFAULT_KEYS)
-			return rcu_dereference_check_key_mtx(local,
-							     sta->ptk[key_idx]);
+			return wiphy_dereference(local->hw.wiphy,
+						 sta->ptk[key_idx]);
 
 		if (!pairwise &&
 		    key_idx < NUM_DEFAULT_KEYS +
 			      NUM_DEFAULT_MGMT_KEYS +
 			      NUM_DEFAULT_BEACON_KEYS)
-			return rcu_dereference_check_key_mtx(local,
-							     link_sta->gtk[key_idx]);
+			return wiphy_dereference(local->hw.wiphy,
+						 link_sta->gtk[key_idx]);
 
 		return NULL;
 	}
 
 	if (pairwise && key_idx < NUM_DEFAULT_KEYS)
-		return rcu_dereference_check_key_mtx(local,
-						     sdata->keys[key_idx]);
+		return wiphy_dereference(local->hw.wiphy, sdata->keys[key_idx]);
 
-	key = rcu_dereference_check_key_mtx(local, link->gtk[key_idx]);
+	key = wiphy_dereference(local->hw.wiphy, link->gtk[key_idx]);
 	if (key)
 		return key;
 
 	/* or maybe it was a WEP key */
 	if (key_idx < NUM_DEFAULT_KEYS)
-		return rcu_dereference_check_key_mtx(local, sdata->keys[key_idx]);
+		return wiphy_dereference(local->hw.wiphy, sdata->keys[key_idx]);
 
 	return NULL;
 }
@@ -634,25 +631,16 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_key *key;
-	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	mutex_lock(&local->key_mtx);
-
 	key = ieee80211_lookup_key(sdata, link_id, key_idx, pairwise, mac_addr);
-	if (!key) {
-		ret = -ENOENT;
-		goto out_unlock;
-	}
+	if (!key)
+		return -ENOENT;
 
 	ieee80211_key_free(key, sdata->vif.type == NL80211_IFTYPE_STATION);
 
-	ret = 0;
- out_unlock:
-	mutex_unlock(&local->key_mtx);
-
-	return ret;
+	return 0;
 }
 
 static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index 16a04330e7dc..7e54da508765 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright (C) 2015	Intel Deutschland GmbH
- * Copyright (C) 2021-2022   Intel Corporation
+ * Copyright (C) 2021-2023   Intel Corporation
  */
 
 #include <linux/kobject.h>
@@ -378,14 +378,14 @@ void ieee80211_debugfs_key_update_default(struct ieee80211_sub_if_data *sdata)
 	if (!sdata->vif.debugfs_dir)
 		return;
 
-	lockdep_assert_held(&sdata->local->key_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	debugfs_remove(sdata->debugfs.default_unicast_key);
 	sdata->debugfs.default_unicast_key = NULL;
 
 	if (sdata->default_unicast_key) {
-		key = key_mtx_dereference(sdata->local,
-					  sdata->default_unicast_key);
+		key = wiphy_dereference(sdata->local->hw.wiphy,
+					sdata->default_unicast_key);
 		sprintf(buf, "../keys/%d", key->debugfs.cnt);
 		sdata->debugfs.default_unicast_key =
 			debugfs_create_symlink("default_unicast_key",
@@ -396,8 +396,8 @@ void ieee80211_debugfs_key_update_default(struct ieee80211_sub_if_data *sdata)
 	sdata->debugfs.default_multicast_key = NULL;
 
 	if (sdata->deflink.default_multicast_key) {
-		key = key_mtx_dereference(sdata->local,
-					  sdata->deflink.default_multicast_key);
+		key = wiphy_dereference(sdata->local->hw.wiphy,
+					sdata->deflink.default_multicast_key);
 		sprintf(buf, "../keys/%d", key->debugfs.cnt);
 		sdata->debugfs.default_multicast_key =
 			debugfs_create_symlink("default_multicast_key",
@@ -413,8 +413,8 @@ void ieee80211_debugfs_key_add_mgmt_default(struct ieee80211_sub_if_data *sdata)
 	if (!sdata->vif.debugfs_dir)
 		return;
 
-	key = key_mtx_dereference(sdata->local,
-				  sdata->deflink.default_mgmt_key);
+	key = wiphy_dereference(sdata->local->hw.wiphy,
+				sdata->deflink.default_mgmt_key);
 	if (key) {
 		sprintf(buf, "../keys/%d", key->debugfs.cnt);
 		sdata->debugfs.default_mgmt_key =
@@ -442,8 +442,8 @@ ieee80211_debugfs_key_add_beacon_default(struct ieee80211_sub_if_data *sdata)
 	if (!sdata->vif.debugfs_dir)
 		return;
 
-	key = key_mtx_dereference(sdata->local,
-				  sdata->deflink.default_beacon_key);
+	key = wiphy_dereference(sdata->local->hw.wiphy,
+				sdata->deflink.default_beacon_key);
 	if (key) {
 		sprintf(buf, "../keys/%d", key->debugfs.cnt);
 		sdata->debugfs.default_beacon_key =
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 1bc921fcd52b..a0bbd7070974 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1466,12 +1466,6 @@ struct ieee80211_local {
 	struct list_head mon_list; /* only that are IFF_UP && !cooked */
 	struct mutex iflist_mtx;
 
-	/*
-	 * Key mutex, protects sdata's key_list and sta_info's
-	 * key pointers and ptk_idx (write access, they're RCU.)
-	 */
-	struct mutex key_mtx;
-
 	/* mutex for scan and work locking */
 	struct mutex mtx;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index eb93caf0be87..385513315f8b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1245,6 +1245,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	int res;
 	u32 hw_reconf_flags = 0;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP_VLAN: {
 		struct ieee80211_sub_if_data *master;
@@ -1271,10 +1273,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		       sizeof(sdata->vif.hw_queue));
 		sdata->vif.bss_conf.chandef = master->vif.bss_conf.chandef;
 
-		mutex_lock(&local->key_mtx);
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
-		mutex_unlock(&local->key_mtx);
 
 		break;
 		}
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index c5bbac4393ab..44053951a1da 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -53,11 +53,6 @@
 
 static const u8 bcast_addr[ETH_ALEN] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
-static void assert_key_lock(struct ieee80211_local *local)
-{
-	lockdep_assert_held(&local->key_mtx);
-}
-
 static void
 update_vlan_tailroom_need_count(struct ieee80211_sub_if_data *sdata, int delta)
 {
@@ -67,7 +62,7 @@ update_vlan_tailroom_need_count(struct ieee80211_sub_if_data *sdata, int delta)
 		return;
 
 	/* crypto_tx_tailroom_needed_cnt is protected by this */
-	assert_key_lock(sdata->local);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	rcu_read_lock();
 
@@ -98,7 +93,7 @@ static void increment_tailroom_need_count(struct ieee80211_sub_if_data *sdata)
 	 * http://mid.gmane.org/1308590980.4322.19.camel@jlt3.sipsolutions.net
 	 */
 
-	assert_key_lock(sdata->local);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	update_vlan_tailroom_need_count(sdata, 1);
 
@@ -114,7 +109,7 @@ static void increment_tailroom_need_count(struct ieee80211_sub_if_data *sdata)
 static void decrease_tailroom_need_count(struct ieee80211_sub_if_data *sdata,
 					 int delta)
 {
-	assert_key_lock(sdata->local);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	WARN_ON_ONCE(sdata->crypto_tx_tailroom_needed_cnt < delta);
 
@@ -129,6 +124,7 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(key->local->hw.wiphy);
 
 	if (key->flags & KEY_FLAG_TAINTED) {
 		/* If we get here, it's during resume and the key is
@@ -151,8 +147,6 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 	if (!key->local->ops->set_key)
 		goto out_unsupported;
 
-	assert_key_lock(key->local);
-
 	sta = key->sta;
 
 	/*
@@ -242,14 +236,14 @@ static void ieee80211_key_disable_hw_accel(struct ieee80211_key *key)
 	if (!key || !key->local->ops->set_key)
 		return;
 
-	assert_key_lock(key->local);
-
 	if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
 		return;
 
 	sta = key->sta;
 	sdata = key->sdata;
 
+	lockdep_assert_wiphy(key->local->hw.wiphy);
+
 	if (key->conf.link_id >= 0 && sdata->vif.active_links &&
 	    !(sdata->vif.active_links & BIT(key->conf.link_id)))
 		return;
@@ -275,7 +269,7 @@ static int _ieee80211_set_tx_key(struct ieee80211_key *key, bool force)
 	struct sta_info *sta = key->sta;
 	struct ieee80211_local *local = key->local;
 
-	assert_key_lock(local);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	set_sta_flag(sta, WLAN_STA_USES_ENCRYPTION);
 
@@ -300,7 +294,7 @@ static void ieee80211_pairwise_rekey(struct ieee80211_key *old,
 	struct sta_info *sta = new->sta;
 	int i;
 
-	assert_key_lock(local);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX) {
 		/* Extended Key ID key install, initial one or rekey */
@@ -358,12 +352,14 @@ static void __ieee80211_set_default_key(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_key *key = NULL;
 
-	assert_key_lock(sdata->local);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (idx >= 0 && idx < NUM_DEFAULT_KEYS) {
-		key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
+		key = wiphy_dereference(sdata->local->hw.wiphy,
+					sdata->keys[idx]);
 		if (!key)
-			key = key_mtx_dereference(sdata->local, link->gtk[idx]);
+			key = wiphy_dereference(sdata->local->hw.wiphy,
+						link->gtk[idx]);
 	}
 
 	if (uni) {
@@ -382,9 +378,9 @@ static void __ieee80211_set_default_key(struct ieee80211_link_data *link,
 void ieee80211_set_default_key(struct ieee80211_link_data *link, int idx,
 			       bool uni, bool multi)
 {
-	mutex_lock(&link->sdata->local->key_mtx);
+	lockdep_assert_wiphy(link->sdata->local->hw.wiphy);
+
 	__ieee80211_set_default_key(link, idx, uni, multi);
-	mutex_unlock(&link->sdata->local->key_mtx);
 }
 
 static void
@@ -393,11 +389,12 @@ __ieee80211_set_default_mgmt_key(struct ieee80211_link_data *link, int idx)
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_key *key = NULL;
 
-	assert_key_lock(sdata->local);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (idx >= NUM_DEFAULT_KEYS &&
 	    idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS)
-		key = key_mtx_dereference(sdata->local, link->gtk[idx]);
+		key = wiphy_dereference(sdata->local->hw.wiphy,
+					link->gtk[idx]);
 
 	rcu_assign_pointer(link->default_mgmt_key, key);
 
@@ -407,9 +404,9 @@ __ieee80211_set_default_mgmt_key(struct ieee80211_link_data *link, int idx)
 void ieee80211_set_default_mgmt_key(struct ieee80211_link_data *link,
 				    int idx)
 {
-	mutex_lock(&link->sdata->local->key_mtx);
+	lockdep_assert_wiphy(link->sdata->local->hw.wiphy);
+
 	__ieee80211_set_default_mgmt_key(link, idx);
-	mutex_unlock(&link->sdata->local->key_mtx);
 }
 
 static void
@@ -418,12 +415,13 @@ __ieee80211_set_default_beacon_key(struct ieee80211_link_data *link, int idx)
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_key *key = NULL;
 
-	assert_key_lock(sdata->local);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (idx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS &&
 	    idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
 	    NUM_DEFAULT_BEACON_KEYS)
-		key = key_mtx_dereference(sdata->local, link->gtk[idx]);
+		key = wiphy_dereference(sdata->local->hw.wiphy,
+					link->gtk[idx]);
 
 	rcu_assign_pointer(link->default_beacon_key, key);
 
@@ -433,9 +431,9 @@ __ieee80211_set_default_beacon_key(struct ieee80211_link_data *link, int idx)
 void ieee80211_set_default_beacon_key(struct ieee80211_link_data *link,
 				      int idx)
 {
-	mutex_lock(&link->sdata->local->key_mtx);
+	lockdep_assert_wiphy(link->sdata->local->hw.wiphy);
+
 	__ieee80211_set_default_beacon_key(link, idx);
-	mutex_unlock(&link->sdata->local->key_mtx);
 }
 
 static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
@@ -452,6 +450,8 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 	bool defunikey, defmultikey, defmgmtkey, defbeaconkey;
 	bool is_wep;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	/* caller must provide at least one old/new */
 	if (WARN_ON(!new && !old))
 		return 0;
@@ -510,12 +510,10 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				ret = ieee80211_key_enable_hw_accel(new);
 		}
 	} else {
-		if (!new->local->wowlan) {
+		if (!new->local->wowlan)
 			ret = ieee80211_key_enable_hw_accel(new);
-		} else {
-			assert_key_lock(new->local);
+		else
 			new->flags |= KEY_FLAG_UPLOADED_TO_HARDWARE;
-		}
 	}
 
 	if (ret)
@@ -541,17 +539,17 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 			ieee80211_check_fast_rx(sta);
 	} else {
 		defunikey = old &&
-			old == key_mtx_dereference(sdata->local,
-						sdata->default_unicast_key);
+			old == wiphy_dereference(sdata->local->hw.wiphy,
+						 sdata->default_unicast_key);
 		defmultikey = old &&
-			old == key_mtx_dereference(sdata->local,
-						   link->default_multicast_key);
+			old == wiphy_dereference(sdata->local->hw.wiphy,
+						 link->default_multicast_key);
 		defmgmtkey = old &&
-			old == key_mtx_dereference(sdata->local,
-						   link->default_mgmt_key);
+			old == wiphy_dereference(sdata->local->hw.wiphy,
+						 link->default_mgmt_key);
 		defbeaconkey = old &&
-			old == key_mtx_dereference(sdata->local,
-						   link->default_beacon_key);
+			old == wiphy_dereference(sdata->local->hw.wiphy,
+						 link->default_beacon_key);
 
 		if (defunikey && !new)
 			__ieee80211_set_default_key(link, -1, true, false);
@@ -855,22 +853,24 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 * can cause warnings to appear.
 	 */
 	bool delay_tailroom = sdata->vif.type == NL80211_IFTYPE_STATION;
-	int ret = -EOPNOTSUPP;
+	int ret;
 
-	mutex_lock(&sdata->local->key_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (sta && pairwise) {
 		struct ieee80211_key *alt_key;
 
-		old_key = key_mtx_dereference(sdata->local, sta->ptk[idx]);
-		alt_key = key_mtx_dereference(sdata->local, sta->ptk[idx ^ 1]);
+		old_key = wiphy_dereference(sdata->local->hw.wiphy,
+					    sta->ptk[idx]);
+		alt_key = wiphy_dereference(sdata->local->hw.wiphy,
+					    sta->ptk[idx ^ 1]);
 
 		/* The rekey code assumes that the old and new key are using
 		 * the same cipher. Enforce the assumption for pairwise keys.
 		 */
 		if ((alt_key && alt_key->conf.cipher != key->conf.cipher) ||
 		    (old_key && old_key->conf.cipher != key->conf.cipher))
-			goto out;
+			return -EOPNOTSUPP;
 	} else if (sta) {
 		struct link_sta_info *link_sta = &sta->deflink;
 		int link_id = key->conf.link_id;
@@ -878,26 +878,25 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		if (link_id >= 0) {
 			link_sta = rcu_dereference_protected(sta->link[link_id],
 							     lockdep_is_held(&sta->local->hw.wiphy->mtx));
-			if (!link_sta) {
-				ret = -ENOLINK;
-				goto out;
-			}
+			if (!link_sta)
+				return -ENOLINK;
 		}
 
-		old_key = key_mtx_dereference(sdata->local, link_sta->gtk[idx]);
+		old_key = wiphy_dereference(sdata->local->hw.wiphy,
+					    link_sta->gtk[idx]);
 	} else {
 		if (idx < NUM_DEFAULT_KEYS)
-			old_key = key_mtx_dereference(sdata->local,
-						      sdata->keys[idx]);
+			old_key = wiphy_dereference(sdata->local->hw.wiphy,
+						    sdata->keys[idx]);
 		if (!old_key)
-			old_key = key_mtx_dereference(sdata->local,
-						      link->gtk[idx]);
+			old_key = wiphy_dereference(sdata->local->hw.wiphy,
+						    link->gtk[idx]);
 	}
 
 	/* Non-pairwise keys must also not switch the cipher on rekey */
 	if (!pairwise) {
 		if (old_key && old_key->conf.cipher != key->conf.cipher)
-			goto out;
+			return -EOPNOTSUPP;
 	}
 
 	/*
@@ -906,8 +905,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 */
 	if (ieee80211_key_identical(sdata, old_key, key)) {
 		ieee80211_key_free_unused(key);
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	key->local = sdata->local;
@@ -931,9 +929,6 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		ieee80211_key_free(key, delay_tailroom);
 	}
 
- out:
-	mutex_unlock(&sdata->local->key_mtx);
-
 	return ret;
 }
 
@@ -959,8 +954,6 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	mutex_lock(&sdata->local->key_mtx);
-
 	sdata->crypto_tx_tailroom_needed_cnt = 0;
 	sdata->crypto_tx_tailroom_pending_dec = 0;
 
@@ -977,8 +970,6 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 			ieee80211_key_enable_hw_accel(key);
 		}
 	}
-
-	mutex_unlock(&sdata->local->key_mtx);
 }
 
 void ieee80211_iter_keys(struct ieee80211_hw *hw,
@@ -996,7 +987,6 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	mutex_lock(&local->key_mtx);
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		list_for_each_entry_safe(key, tmp, &sdata->key_list, list)
@@ -1011,7 +1001,6 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
 				     key->sta ? &key->sta->sta : NULL,
 				     &key->conf, iter_data);
 	}
-	mutex_unlock(&local->key_mtx);
 }
 EXPORT_SYMBOL(ieee80211_iter_keys);
 
@@ -1091,7 +1080,8 @@ void ieee80211_remove_link_keys(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_key *key, *tmp;
 
-	mutex_lock(&local->key_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	list_for_each_entry_safe(key, tmp, &sdata->key_list, list) {
 		if (key->conf.link_id != link->link_id)
 			continue;
@@ -1100,7 +1090,6 @@ void ieee80211_remove_link_keys(struct ieee80211_link_data *link,
 				      key, NULL);
 		list_add_tail(&key->list, keys);
 	}
-	mutex_unlock(&local->key_mtx);
 }
 
 void ieee80211_free_key_list(struct ieee80211_local *local,
@@ -1108,10 +1097,10 @@ void ieee80211_free_key_list(struct ieee80211_local *local,
 {
 	struct ieee80211_key *key, *tmp;
 
-	mutex_lock(&local->key_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	list_for_each_entry_safe(key, tmp, keys, list)
 		__ieee80211_key_destroy(key, false);
-	mutex_unlock(&local->key_mtx);
 }
 
 void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
@@ -1126,7 +1115,7 @@ void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 	wiphy_delayed_work_cancel(local->hw.wiphy,
 				  &sdata->dec_tailroom_needed_wk);
 
-	mutex_lock(&local->key_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	ieee80211_free_keys_iface(sdata, &keys);
 
@@ -1159,8 +1148,6 @@ void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 			WARN_ON_ONCE(vlan->crypto_tx_tailroom_needed_cnt ||
 				     vlan->crypto_tx_tailroom_pending_dec);
 	}
-
-	mutex_unlock(&local->key_mtx);
 }
 
 void ieee80211_free_sta_keys(struct ieee80211_local *local,
@@ -1169,9 +1156,10 @@ void ieee80211_free_sta_keys(struct ieee80211_local *local,
 	struct ieee80211_key *key;
 	int i;
 
-	mutex_lock(&local->key_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	for (i = 0; i < ARRAY_SIZE(sta->deflink.gtk); i++) {
-		key = key_mtx_dereference(local, sta->deflink.gtk[i]);
+		key = wiphy_dereference(local->hw.wiphy, sta->deflink.gtk[i]);
 		if (!key)
 			continue;
 		ieee80211_key_replace(key->sdata, NULL, key->sta,
@@ -1182,7 +1170,7 @@ void ieee80211_free_sta_keys(struct ieee80211_local *local,
 	}
 
 	for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
-		key = key_mtx_dereference(local, sta->ptk[i]);
+		key = wiphy_dereference(local->hw.wiphy, sta->ptk[i]);
 		if (!key)
 			continue;
 		ieee80211_key_replace(key->sdata, NULL, key->sta,
@@ -1191,8 +1179,6 @@ void ieee80211_free_sta_keys(struct ieee80211_local *local,
 		__ieee80211_key_destroy(key, key->sdata->vif.type ==
 					NL80211_IFTYPE_STATION);
 	}
-
-	mutex_unlock(&local->key_mtx);
 }
 
 void ieee80211_delayed_tailroom_dec(struct wiphy *wiphy,
@@ -1219,11 +1205,9 @@ void ieee80211_delayed_tailroom_dec(struct wiphy *wiphy,
 	 * within an ESS this usually won't happen.
 	 */
 
-	mutex_lock(&sdata->local->key_mtx);
 	decrease_tailroom_need_count(sdata,
 				     sdata->crypto_tx_tailroom_pending_dec);
 	sdata->crypto_tx_tailroom_pending_dec = 0;
-	mutex_unlock(&sdata->local->key_mtx);
 }
 
 void ieee80211_gtk_rekey_notify(struct ieee80211_vif *vif, const u8 *bssid,
@@ -1352,7 +1336,7 @@ void ieee80211_remove_key(struct ieee80211_key_conf *keyconf)
 
 	key = container_of(keyconf, struct ieee80211_key, conf);
 
-	assert_key_lock(key->local);
+	lockdep_assert_wiphy(key->local->hw.wiphy);
 
 	/*
 	 * if key was uploaded, we assume the driver will/has remove(d)
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index 231a069d2975..1fa0f4f78962 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -168,12 +168,6 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata);
 int ieee80211_key_switch_links(struct ieee80211_sub_if_data *sdata,
 			       unsigned long del_links_mask,
 			       unsigned long add_links_mask);
-
-#define key_mtx_dereference(local, ref) \
-	rcu_dereference_protected(ref, lockdep_is_held(&((local)->key_mtx)))
-#define rcu_dereference_check_key_mtx(local, ref) \
-	rcu_dereference_check(ref, lockdep_is_held(&((local)->key_mtx)))
-
 void ieee80211_delayed_tailroom_dec(struct wiphy *wiphy,
 				    struct wiphy_work *wk);
 
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 71815b8d44af..226c852fd5ee 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -456,8 +456,8 @@ int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 
 	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
+
 	mutex_lock(&local->mtx);
-	mutex_lock(&local->key_mtx);
 	old_active = sdata->vif.active_links;
 	if (old_active & active_links) {
 		/*
@@ -473,7 +473,6 @@ int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 		/* otherwise switch directly */
 		ret = _ieee80211_set_active_links(sdata, active_links);
 	}
-	mutex_unlock(&local->key_mtx);
 	mutex_unlock(&local->mtx);
 
 	return ret;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 37714dcf9f06..a30eb5ca6369 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -806,7 +806,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	mutex_init(&local->iflist_mtx);
 	mutex_init(&local->mtx);
 
-	mutex_init(&local->key_mtx);
 	spin_lock_init(&local->filter_lock);
 	spin_lock_init(&local->rx_path_lock);
 	spin_lock_init(&local->queue_stop_reason_lock);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 6187cb54a876..279a65198885 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2987,6 +2987,8 @@ static void ieee80211_reconfig_disconnect(struct ieee80211_vif *vif, u8 flag)
 	sdata = vif_to_sdata(vif);
 	local = sdata->local;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (WARN_ON(flag & IEEE80211_SDATA_DISCONNECT_RESUME &&
 		    !local->resuming))
 		return;
@@ -3000,10 +3002,8 @@ static void ieee80211_reconfig_disconnect(struct ieee80211_vif *vif, u8 flag)
 
 	sdata->flags |= flag;
 
-	mutex_lock(&local->key_mtx);
 	list_for_each_entry(key, &sdata->key_list, list)
 		key->flags |= KEY_FLAG_TAINTED;
-	mutex_unlock(&local->key_mtx);
 }
 
 void ieee80211_hw_restart_disconnect(struct ieee80211_vif *vif)
-- 
2.41.0

