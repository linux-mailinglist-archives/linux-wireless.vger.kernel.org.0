Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4565D7215C1
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFDJMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjFDJM3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C949FD
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869939; x=1717405939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XB0scNeXszAYgXyaWfp+DMlNik5M0WnIq7ovFmcqBGE=;
  b=Zq4eOm6Pxnrtw/g9IqTo2hMCVoRgZLaxtpBVGTeNNcv55sj8W/M8WHyW
   mzWYYUMMwvYrHzDr5tEwQTIVjnq49cQjwM7eU096sgltnc9Kk05ydtDpx
   brQxAuh6D3lxlohuydrvsQV10fXVqR4QXN6hVz5YlBB6ks3h8UO24CxU5
   ZPLXtDo8OAUC3QhYMjA1oFv4g2DZFSbcNJ0snKnKcWqnkFyYu/OZaCXPk
   0CBZEwW/nkpkx1e4fvP4nqBLUUUEbXiiyb312IjXVixIMri9UY65nwtS4
   H2oyuD0LFPvNgUdceJBt4FHXlfglD85eB15popwUIxPVmuzbm2LtKzcqH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526551"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526551"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804806"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804806"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/16] wifi: mac80211: Modify type of "changed" variable.
Date:   Sun,  4 Jun 2023 12:11:26 +0300
Message-Id: <20230604120651.10354a05eaf1.If19359262fe2728dd523ea6d7c3aa7dc50940411@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Currently, enum ieee80211_bss_change has more than 32 flags.
Change the type of the corresponding variables from u32 to u64.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c         | 79 ++++++++++++++++++--------------------
 net/mac80211/chan.c        |  4 +-
 net/mac80211/ibss.c        | 16 ++++----
 net/mac80211/ieee80211_i.h | 14 ++++---
 net/mac80211/iface.c       |  4 +-
 net/mac80211/main.c        |  4 +-
 net/mac80211/mesh.c        | 30 ++++++++-------
 net/mac80211/mesh.h        | 19 ++++-----
 net/mac80211/mesh_plink.c  | 37 +++++++++---------
 net/mac80211/mesh_ps.c     |  7 ++--
 net/mac80211/mlme.c        | 12 +++---
 net/mac80211/ocb.c         |  4 +-
 12 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 49f5122189d3..c713233ee6d9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1101,18 +1101,20 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
 	return offset;
 }
 
-static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
-				   struct ieee80211_link_data *link,
-				   struct cfg80211_beacon_data *params,
-				   const struct ieee80211_csa_settings *csa,
-				   const struct ieee80211_color_change_settings *cca)
+static int
+ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
+			struct ieee80211_link_data *link,
+			struct cfg80211_beacon_data *params,
+			const struct ieee80211_csa_settings *csa,
+			const struct ieee80211_color_change_settings *cca,
+			u64 *changed)
 {
 	struct cfg80211_mbssid_elems *mbssid = NULL;
 	struct cfg80211_rnr_elems *rnr = NULL;
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
 	int size, err;
-	u32 changed = BSS_CHANGED_BEACON;
+	u64 _changed = BSS_CHANGED_BEACON;
 	struct ieee80211_bss_conf *link_conf = link->conf;
 
 	old = sdata_dereference(link->u.ap.beacon, sdata);
@@ -1219,7 +1221,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		return err;
 	}
 	if (err == 0)
-		changed |= BSS_CHANGED_AP_PROBE_RESP;
+		_changed |= BSS_CHANGED_AP_PROBE_RESP;
 
 	if (params->ftm_responder != -1) {
 		link_conf->ftm_responder = params->ftm_responder;
@@ -1235,7 +1237,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			return err;
 		}
 
-		changed |= BSS_CHANGED_FTM_RESPONDER;
+		_changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
 
 	rcu_assign_pointer(link->u.ap.beacon, new);
@@ -1244,7 +1246,8 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	if (old)
 		kfree_rcu(old, rcu_head);
 
-	return changed;
+	*changed |= _changed;
+	return 0;
 }
 
 static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
@@ -1446,10 +1449,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
 		link_conf->beacon_tx_rate = params->beacon_rate;
 
-	err = ieee80211_assign_beacon(sdata, link, &params->beacon, NULL, NULL);
+	err = ieee80211_assign_beacon(sdata, link, &params->beacon, NULL, NULL,
+				      &changed);
 	if (err < 0)
 		goto error;
-	changed |= err;
 
 	if (params->fils_discovery.max_interval) {
 		err = ieee80211_set_fils_discovery(sdata,
@@ -1506,6 +1509,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	struct beacon_data *old;
 	int err;
 	struct ieee80211_bss_conf *link_conf;
+	u64 changed = 0;
 
 	sdata_assert_lock(sdata);
 
@@ -1525,17 +1529,18 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, link, params, NULL, NULL);
+	err = ieee80211_assign_beacon(sdata, link, params, NULL, NULL,
+				      &changed);
 	if (err < 0)
 		return err;
 
 	if (params->he_bss_color_valid &&
 	    params->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
 		link_conf->he_bss_color.enabled = params->he_bss_color.enabled;
-		err |= BSS_CHANGED_HE_BSS_COLOR;
+		changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-	ieee80211_link_info_change_notify(sdata, link, err);
+	ieee80211_link_info_change_notify(sdata, link, changed);
 	return 0;
 }
 
@@ -1717,7 +1722,7 @@ static void sta_apply_mesh_params(struct ieee80211_local *local,
 {
 #ifdef CONFIG_MAC80211_MESH
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	u32 changed = 0;
+	u64 changed = 0;
 
 	if (params->sta_modify_mask & STATION_PARAM_APPLY_PLINK_STATE) {
 		switch (params->plink_state) {
@@ -2664,7 +2669,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_link_data *link;
 	struct ieee80211_supported_band *sband;
-	u32 changed = 0;
+	u64 changed = 0;
 
 	link = ieee80211_link_or_deflink(sdata, params->link_id, true);
 	if (IS_ERR(link))
@@ -3589,7 +3594,7 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 EXPORT_SYMBOL(ieee80211_channel_switch_disconnect);
 
 static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
-					  u32 *changed)
+					  u64 *changed)
 {
 	int err;
 
@@ -3600,25 +3605,22 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
 					      sdata->deflink.u.ap.next_beacon,
-					      NULL, NULL);
+					      NULL, NULL, changed);
 		ieee80211_free_next_beacon(&sdata->deflink);
 
 		if (err < 0)
 			return err;
-		*changed |= err;
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		err = ieee80211_ibss_finish_csa(sdata);
+		err = ieee80211_ibss_finish_csa(sdata, changed);
 		if (err < 0)
 			return err;
-		*changed |= err;
 		break;
 #ifdef CONFIG_MAC80211_MESH
 	case NL80211_IFTYPE_MESH_POINT:
-		err = ieee80211_mesh_finish_csa(sdata);
+		err = ieee80211_mesh_finish_csa(sdata, changed);
 		if (err < 0)
 			return err;
-		*changed |= err;
 		break;
 #endif
 	default:
@@ -3632,7 +3634,7 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
-	u32 changed = 0;
+	u64 changed = 0;
 	int err;
 
 	sdata_assert_lock(sdata);
@@ -3729,7 +3731,7 @@ void ieee80211_csa_finalize_work(struct work_struct *work)
 
 static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_csa_settings *params,
-				    u32 *changed)
+				    u64 *changed)
 {
 	struct ieee80211_csa_settings csa = {};
 	int err;
@@ -3776,12 +3778,11 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
 					      &params->beacon_csa, &csa,
-					      NULL);
+					      NULL, changed);
 		if (err < 0) {
 			ieee80211_free_next_beacon(&sdata->deflink);
 			return err;
 		}
-		*changed |= err;
 
 		break;
 	case NL80211_IFTYPE_ADHOC:
@@ -3813,10 +3814,9 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		/* see comments in the NL80211_IFTYPE_AP block */
 		if (params->count > 1) {
-			err = ieee80211_ibss_csa_beacon(sdata, params);
+			err = ieee80211_ibss_csa_beacon(sdata, params, changed);
 			if (err < 0)
 				return err;
-			*changed |= err;
 		}
 
 		ieee80211_send_action_csa(sdata, params);
@@ -3841,12 +3841,11 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		/* see comments in the NL80211_IFTYPE_AP block */
 		if (params->count > 1) {
-			err = ieee80211_mesh_csa_beacon(sdata, params);
+			err = ieee80211_mesh_csa_beacon(sdata, params, changed);
 			if (err < 0) {
 				ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
 				return err;
 			}
-			*changed |= err;
 		}
 
 		if (ifmsh->csa_role == IEEE80211_MESH_CSA_ROLE_INIT)
@@ -3880,7 +3879,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_channel_switch ch_switch;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
-	u32 changed = 0;
+	u64 changed = 0;
 	int err;
 
 	sdata_assert_lock(sdata);
@@ -4613,7 +4612,7 @@ static int ieee80211_set_sar_specs(struct wiphy *wiphy,
 
 static int
 ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
-					u32 *changed)
+					u64 *changed)
 {
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP: {
@@ -4624,13 +4623,12 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 
 		ret = ieee80211_assign_beacon(sdata, &sdata->deflink,
 					      sdata->deflink.u.ap.next_beacon,
-					      NULL, NULL);
+					      NULL, NULL, changed);
 		ieee80211_free_next_beacon(&sdata->deflink);
 
 		if (ret < 0)
 			return ret;
 
-		*changed |= ret;
 		break;
 	}
 	default:
@@ -4644,7 +4642,7 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 static int
 ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_color_change_settings *params,
-				  u32 *changed)
+				  u64 *changed)
 {
 	struct ieee80211_color_change_settings color_change = {};
 	int err;
@@ -4667,12 +4665,11 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 
 		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
 					      &params->beacon_color_change,
-					      NULL, &color_change);
+					      NULL, &color_change, changed);
 		if (err < 0) {
 			ieee80211_free_next_beacon(&sdata->deflink);
 			return err;
 		}
-		*changed |= err;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -4683,7 +4680,7 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 
 static void
 ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
-					 u8 color, int enable, u32 changed)
+					 u8 color, int enable, u64 changed)
 {
 	sdata->vif.bss_conf.he_bss_color.color = color;
 	sdata->vif.bss_conf.he_bss_color.enabled = enable;
@@ -4711,7 +4708,7 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
-	u32 changed = 0;
+	u64 changed = 0;
 	int err;
 
 	sdata_assert_lock(sdata);
@@ -4808,7 +4805,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
-	u32 changed = 0;
+	u64 changed = 0;
 	int err;
 
 	sdata_assert_lock(sdata);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a7e204de5d54..97b944b97d17 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1257,7 +1257,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	struct ieee80211_vif_chanctx_switch vif_chsw[1] = {};
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 	const struct cfg80211_chan_def *chandef;
-	u32 changed = 0;
+	u64 changed = 0;
 	int err;
 
 	lockdep_assert_held(&local->mtx);
@@ -1653,7 +1653,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				    reserved_chanctx_list) {
 			struct ieee80211_sub_if_data *sdata = link->sdata;
 			struct ieee80211_bss_conf *link_conf = link->conf;
-			u32 changed = 0;
+			u64 changed = 0;
 
 			if (!ieee80211_link_has_in_place_reservation(link))
 				continue;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 9dffc3079588..faa01ee11d32 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -9,7 +9,7 @@
  * Copyright 2009, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright(c) 2018-2022 Intel Corporation
+ * Copyright(c) 2018-2023 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -226,7 +226,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
 	struct cfg80211_bss *bss;
-	u32 bss_change;
+	u64 bss_change;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *chan;
 	struct beacon_data *presp;
@@ -478,7 +478,8 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 }
 
 int ieee80211_ibss_csa_beacon(struct ieee80211_sub_if_data *sdata,
-			      struct cfg80211_csa_settings *csa_settings)
+			      struct cfg80211_csa_settings *csa_settings,
+			      u64 *changed)
 {
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	struct beacon_data *presp, *old_presp;
@@ -520,10 +521,11 @@ int ieee80211_ibss_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	if (old_presp)
 		kfree_rcu(old_presp, rcu_head);
 
-	return BSS_CHANGED_BEACON;
+	*changed |= BSS_CHANGED_BEACON;
+	return 0;
 }
 
-int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata)
+int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata, u64 *changed)
 {
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	struct cfg80211_bss *cbss;
@@ -552,7 +554,7 @@ int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata)
 	ifibss->chandef = sdata->deflink.csa_chandef;
 
 	/* generate the beacon */
-	return ieee80211_ibss_csa_beacon(sdata, NULL);
+	return ieee80211_ibss_csa_beacon(sdata, NULL, changed);
 }
 
 void ieee80211_ibss_stop(struct ieee80211_sub_if_data *sdata)
@@ -1754,7 +1756,7 @@ void ieee80211_ibss_notify_scan_completed(struct ieee80211_local *local)
 int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_ibss_params *params)
 {
-	u32 changed = 0;
+	u64 changed = 0;
 	u32 rate_flags;
 	struct ieee80211_supported_band *sband;
 	enum ieee80211_chanctx_mode chanmode;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 886244d42f04..46adb1d9a589 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1827,7 +1827,7 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_link_data *link,
 				       u64 changed);
 void ieee80211_configure_filter(struct ieee80211_local *local);
-u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
+u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local);
 int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
@@ -1887,8 +1887,10 @@ void ieee80211_ibss_work(struct ieee80211_sub_if_data *sdata);
 void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				   struct sk_buff *skb);
 int ieee80211_ibss_csa_beacon(struct ieee80211_sub_if_data *sdata,
-			      struct cfg80211_csa_settings *csa_settings);
-int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata);
+			      struct cfg80211_csa_settings *csa_settings,
+			      u64 *changed);
+int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata,
+			      u64 *changed);
 void ieee80211_ibss_stop(struct ieee80211_sub_if_data *sdata);
 
 /* OCB code */
@@ -1905,8 +1907,10 @@ void ieee80211_mesh_work(struct ieee80211_sub_if_data *sdata);
 void ieee80211_mesh_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				   struct sk_buff *skb);
 int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
-			      struct cfg80211_csa_settings *csa_settings);
-int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata);
+			      struct cfg80211_csa_settings *csa_settings,
+			      u64 *changed);
+int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata,
+			      u64 *changed);
 
 /* scan/BSS handling */
 void ieee80211_scan_work(struct work_struct *work);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index bd2c48870add..f1e01f7a9b2e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -1221,7 +1221,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct net_device *dev = wdev->netdev;
 	struct ieee80211_local *local = sdata->local;
-	u32 changed = 0;
+	u64 changed = 0;
 	int res;
 	u32 hw_reconf_flags = 0;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 55cdfaef0f5d..3db178b1d50c 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2017     Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -291,7 +291,7 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	drv_link_info_changed(local, sdata, link->conf, link->link_id, changed);
 }
 
-u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
+u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
 {
 	sdata->vif.bss_conf.use_cts_prot = false;
 	sdata->vif.bss_conf.use_short_preamble = false;
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f72333201903..a4d8764073bf 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
  */
@@ -133,10 +133,10 @@ bool mesh_peer_accepts_plinks(struct ieee802_11_elems *ie)
  *
  * Returns: beacon changed flag if the beacon content changed.
  */
-u32 mesh_accept_plinks_update(struct ieee80211_sub_if_data *sdata)
+u64 mesh_accept_plinks_update(struct ieee80211_sub_if_data *sdata)
 {
 	bool free_plinks;
-	u32 changed = 0;
+	u64 changed = 0;
 
 	/* In case mesh_plink_free_count > 0 and mesh_plinktbl_capacity == 0,
 	 * the mesh interface might be able to establish plinks with peers that
@@ -162,7 +162,7 @@ u32 mesh_accept_plinks_update(struct ieee80211_sub_if_data *sdata)
 void mesh_sta_cleanup(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	u32 changed = mesh_plink_deactivate(sta);
+	u64 changed = mesh_plink_deactivate(sta);
 
 	if (changed)
 		ieee80211_mbss_info_change_notify(sdata, changed);
@@ -923,7 +923,7 @@ unsigned int ieee80211_new_mesh_header(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_mesh_housekeeping(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	u32 changed;
+	u64 changed;
 
 	if (ifmsh->mshcfg.plink_timeout > 0)
 		ieee80211_sta_expire(sdata, ifmsh->mshcfg.plink_timeout * HZ);
@@ -1164,7 +1164,7 @@ ieee80211_mesh_rebuild_beacon(struct ieee80211_sub_if_data *sdata)
 }
 
 void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				       u32 changed)
+				       u64 changed)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	unsigned long bits = changed;
@@ -1184,7 +1184,7 @@ int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee80211_local *local = sdata->local;
-	u32 changed = BSS_CHANGED_BEACON |
+	u64 changed = BSS_CHANGED_BEACON |
 		      BSS_CHANGED_BEACON_ENABLED |
 		      BSS_CHANGED_HT |
 		      BSS_CHANGED_BASIC_RATES |
@@ -1525,12 +1525,11 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	kfree(elems);
 }
 
-int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
+int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata, u64 *changed)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct mesh_csa_settings *tmp_csa_settings;
 	int ret = 0;
-	int changed = 0;
 
 	/* Reset the TTL value and Initiator flag */
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
@@ -1545,15 +1544,16 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
 	if (ret)
 		return -EINVAL;
 
-	changed |= BSS_CHANGED_BEACON;
+	*changed |= BSS_CHANGED_BEACON;
 
 	mcsa_dbg(sdata, "complete switching to center freq %d MHz",
 		 sdata->vif.bss_conf.chandef.chan->center_freq);
-	return changed;
+	return 0;
 }
 
 int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
-			      struct cfg80211_csa_settings *csa_settings)
+			      struct cfg80211_csa_settings *csa_settings,
+			      u64 *changed)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct mesh_csa_settings *tmp_csa_settings;
@@ -1579,7 +1579,8 @@ int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		return ret;
 	}
 
-	return BSS_CHANGED_BEACON;
+	*changed |= BSS_CHANGED_BEACON;
+	return 0;
 }
 
 static int mesh_fwd_csa_frame(struct ieee80211_sub_if_data *sdata,
@@ -1720,7 +1721,8 @@ void ieee80211_mesh_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 static void mesh_bss_info_changed(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	u32 bit, changed = 0;
+	u32 bit;
+	u64 changed = 0;
 
 	for_each_set_bit(bit, &ifmsh->mbss_changed,
 			 sizeof(changed) * BITS_PER_BYTE) {
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 022f41292a05..6c94222a9df5 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
+ * Copyright (C) 2023 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  *             Javier Cardona <javier@cozybit.com>
  */
@@ -252,11 +253,11 @@ void ieee80211_mesh_root_setup(struct ieee80211_if_mesh *ifmsh);
 const struct ieee80211_mesh_sync_ops *ieee80211_mesh_sync_ops_get(u8 method);
 /* wrapper for ieee80211_bss_info_change_notify() */
 void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				       u32 changed);
+				       u64 changed);
 
 /* mesh power save */
-u32 ieee80211_mps_local_status_update(struct ieee80211_sub_if_data *sdata);
-u32 ieee80211_mps_set_sta_local_pm(struct sta_info *sta,
+u64 ieee80211_mps_local_status_update(struct ieee80211_sub_if_data *sdata);
+u64 ieee80211_mps_set_sta_local_pm(struct sta_info *sta,
 				   enum nl80211_mesh_power_mode pm);
 void ieee80211_mps_set_frame_flags(struct ieee80211_sub_if_data *sdata,
 				   struct sta_info *sta,
@@ -303,12 +304,12 @@ void mesh_neighbour_update(struct ieee80211_sub_if_data *sdata,
 			   u8 *hw_addr, struct ieee802_11_elems *ie,
 			   struct ieee80211_rx_status *rx_status);
 bool mesh_peer_accepts_plinks(struct ieee802_11_elems *ie);
-u32 mesh_accept_plinks_update(struct ieee80211_sub_if_data *sdata);
+u64 mesh_accept_plinks_update(struct ieee80211_sub_if_data *sdata);
 void mesh_plink_timer(struct timer_list *t);
 void mesh_plink_broken(struct sta_info *sta);
-u32 mesh_plink_deactivate(struct sta_info *sta);
-u32 mesh_plink_open(struct sta_info *sta);
-u32 mesh_plink_block(struct sta_info *sta);
+u64 mesh_plink_deactivate(struct sta_info *sta);
+u64 mesh_plink_open(struct sta_info *sta);
+u64 mesh_plink_block(struct sta_info *sta);
 void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 			 struct ieee80211_mgmt *mgmt, size_t len,
 			 struct ieee80211_rx_status *rx_status);
@@ -349,14 +350,14 @@ void mesh_path_refresh(struct ieee80211_sub_if_data *sdata,
 
 #ifdef CONFIG_MAC80211_MESH
 static inline
-u32 mesh_plink_inc_estab_count(struct ieee80211_sub_if_data *sdata)
+u64 mesh_plink_inc_estab_count(struct ieee80211_sub_if_data *sdata)
 {
 	atomic_inc(&sdata->u.mesh.estab_plinks);
 	return mesh_accept_plinks_update(sdata) | BSS_CHANGED_BEACON;
 }
 
 static inline
-u32 mesh_plink_dec_estab_count(struct ieee80211_sub_if_data *sdata)
+u64 mesh_plink_dec_estab_count(struct ieee80211_sub_if_data *sdata)
 {
 	atomic_dec(&sdata->u.mesh.estab_plinks);
 	return mesh_accept_plinks_update(sdata) | BSS_CHANGED_BEACON;
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 8f168bc4e4b8..f3d5bb0a59f1 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021-2022 Intel Corporation
+ * Copyright (C) 2019, 2021-2023 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 #include <linux/gfp.h>
@@ -90,12 +90,13 @@ static inline void mesh_plink_fsm_restart(struct sta_info *sta)
  *
  * Returns BSS_CHANGED_ERP_SLOT or 0 for no change.
  */
-static u32 mesh_set_short_slot_time(struct ieee80211_sub_if_data *sdata)
+static u64 mesh_set_short_slot_time(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	struct sta_info *sta;
-	u32 erp_rates = 0, changed = 0;
+	u32 erp_rates = 0;
+	u64 changed = 0;
 	int i;
 	bool short_slot = false;
 
@@ -153,7 +154,7 @@ static u32 mesh_set_short_slot_time(struct ieee80211_sub_if_data *sdata)
  * is selected if all peers in our 20/40MHz MBSS support HT and at least one
  * HT20 peer is present. Otherwise no-protection mode is selected.
  */
-static u32 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
+static u64 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
@@ -365,10 +366,10 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
  *
  * Locking: the caller must hold sta->mesh->plink_lock
  */
-static u32 __mesh_plink_deactivate(struct sta_info *sta)
+static u64 __mesh_plink_deactivate(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	u32 changed = 0;
+	u64 changed = 0;
 
 	lockdep_assert_held(&sta->mesh->plink_lock);
 
@@ -390,10 +391,10 @@ static u32 __mesh_plink_deactivate(struct sta_info *sta)
  *
  * All mesh paths with this peer as next hop will be flushed
  */
-u32 mesh_plink_deactivate(struct sta_info *sta)
+u64 mesh_plink_deactivate(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	u32 changed;
+	u64 changed;
 
 	spin_lock_bh(&sta->mesh->plink_lock);
 	changed = __mesh_plink_deactivate(sta);
@@ -622,7 +623,7 @@ void mesh_neighbour_update(struct ieee80211_sub_if_data *sdata,
 			   struct ieee80211_rx_status *rx_status)
 {
 	struct sta_info *sta;
-	u32 changed = 0;
+	u64 changed = 0;
 
 	sta = mesh_sta_info_get(sdata, hw_addr, elems, rx_status);
 	if (!sta)
@@ -775,10 +776,10 @@ static u16 mesh_get_new_llid(struct ieee80211_sub_if_data *sdata)
 	return llid;
 }
 
-u32 mesh_plink_open(struct sta_info *sta)
+u64 mesh_plink_open(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	u32 changed;
+	u64 changed;
 
 	if (!test_sta_flag(sta, WLAN_STA_AUTH))
 		return 0;
@@ -805,9 +806,9 @@ u32 mesh_plink_open(struct sta_info *sta)
 	return changed;
 }
 
-u32 mesh_plink_block(struct sta_info *sta)
+u64 mesh_plink_block(struct sta_info *sta)
 {
-	u32 changed;
+	u64 changed;
 
 	spin_lock_bh(&sta->mesh->plink_lock);
 	changed = __mesh_plink_deactivate(sta);
@@ -831,11 +832,11 @@ static void mesh_plink_close(struct ieee80211_sub_if_data *sdata,
 	mod_plink_timer(sta, mshcfg->dot11MeshHoldingTimeout);
 }
 
-static u32 mesh_plink_establish(struct ieee80211_sub_if_data *sdata,
+static u64 mesh_plink_establish(struct ieee80211_sub_if_data *sdata,
 				struct sta_info *sta)
 {
 	struct mesh_config *mshcfg = &sdata->u.mesh.mshcfg;
-	u32 changed = 0;
+	u64 changed = 0;
 
 	del_timer(&sta->mesh->plink_timer);
 	sta->mesh->plink_state = NL80211_PLINK_ESTAB;
@@ -857,12 +858,12 @@ static u32 mesh_plink_establish(struct ieee80211_sub_if_data *sdata,
  *
  * Return: changed MBSS flags
  */
-static u32 mesh_plink_fsm(struct ieee80211_sub_if_data *sdata,
+static u64 mesh_plink_fsm(struct ieee80211_sub_if_data *sdata,
 			  struct sta_info *sta, enum plink_event event)
 {
 	struct mesh_config *mshcfg = &sdata->u.mesh.mshcfg;
 	enum ieee80211_self_protected_actioncode action = 0;
-	u32 changed = 0;
+	u64 changed = 0;
 	bool flush = false;
 
 	mpl_dbg(sdata, "peer %pM in state %s got event %s\n", sta->sta.addr,
@@ -1117,7 +1118,7 @@ mesh_process_plink_frame(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	enum plink_event event;
 	enum ieee80211_self_protected_actioncode ftype;
-	u32 changed = 0;
+	u64 changed = 0;
 	u8 ie_len = elems->peering_len;
 	u16 plid, llid = 0;
 
diff --git a/net/mac80211/mesh_ps.c b/net/mac80211/mesh_ps.c
index 3fbd0b9ff913..35eacca43e49 100644
--- a/net/mac80211/mesh_ps.c
+++ b/net/mac80211/mesh_ps.c
@@ -3,6 +3,7 @@
  * Copyright 2012-2013, Marco Porsch <marco.porsch@s2005.tu-chemnitz.de>
  * Copyright 2012-2013, cozybit Inc.
  * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2023 Intel Corporation
  */
 
 #include "mesh.h"
@@ -77,14 +78,14 @@ static void mps_qos_null_tx(struct sta_info *sta)
  * sets the non-peer power mode and triggers the driver PS (re-)configuration
  * Return BSS_CHANGED_BEACON if a beacon update is necessary.
  */
-u32 ieee80211_mps_local_status_update(struct ieee80211_sub_if_data *sdata)
+u64 ieee80211_mps_local_status_update(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct sta_info *sta;
 	bool peering = false;
 	int light_sleep_cnt = 0;
 	int deep_sleep_cnt = 0;
-	u32 changed = 0;
+	u64 changed = 0;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
 	rcu_read_lock();
@@ -148,7 +149,7 @@ u32 ieee80211_mps_local_status_update(struct ieee80211_sub_if_data *sdata)
  * @pm: the power mode to set
  * Return BSS_CHANGED_BEACON if a beacon update is in order.
  */
-u32 ieee80211_mps_set_sta_local_pm(struct sta_info *sta,
+u64 ieee80211_mps_set_sta_local_pm(struct sta_info *sta,
 				   enum nl80211_mesh_power_mode pm)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7d6248b8d280..68ee837cbbef 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2110,7 +2110,7 @@ static void ieee80211_find_cisco_dtpc(struct ieee80211_sub_if_data *sdata,
 	*pwr_level = (__s8)cisco_dtpc_ie[4];
 }
 
-static u32 ieee80211_handle_pwr_constr(struct ieee80211_link_data *link,
+static u64 ieee80211_handle_pwr_constr(struct ieee80211_link_data *link,
 				       struct ieee80211_channel *channel,
 				       struct ieee80211_mgmt *mgmt,
 				       const u8 *country_ie, u8 country_ie_len,
@@ -2700,12 +2700,12 @@ static void ieee80211_stop_poll(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&sdata->local->mtx);
 }
 
-static u32 ieee80211_handle_bss_capability(struct ieee80211_link_data *link,
+static u64 ieee80211_handle_bss_capability(struct ieee80211_link_data *link,
 					   u16 capab, bool erp_valid, u8 erp)
 {
 	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_supported_band *sband;
-	u32 changed = 0;
+	u64 changed = 0;
 	bool use_protection;
 	bool use_short_preamble;
 	bool use_short_slot;
@@ -2751,7 +2751,7 @@ static u64 ieee80211_link_set_associated(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_bss *bss = (void *)cbss->priv;
-	u32 changed = BSS_CHANGED_QOS;
+	u64 changed = BSS_CHANGED_QOS;
 
 	/* not really used in MLO */
 	sdata->u.mgd.beacon_timeout =
@@ -2889,7 +2889,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 	unsigned int link_id;
-	u32 changed = 0;
+	u64 changed = 0;
 	struct ieee80211_prep_tx_info info = {
 		.subtype = stype,
 	};
@@ -3959,7 +3959,7 @@ static bool ieee80211_twt_req_supported(struct ieee80211_sub_if_data *sdata,
 			IEEE80211_HE_MAC_CAP0_TWT_REQ);
 }
 
-static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
+static u64 ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    struct ieee80211_link_data *link,
 				    struct link_sta_info *link_sta,
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index a57dcbe99a0d..cf205762ab96 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -4,7 +4,7 @@
  *
  * Copyright: (c) 2014 Czech Technical University in Prague
  *            (c) 2014 Volkswagen Group Research
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022 - 2023 Intel Corporation
  * Author:    Rostislav Lisovy <rostislav.lisovy@fel.cvut.cz>
  * Funded by: Volkswagen Group Research
  */
@@ -175,7 +175,7 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_ocb *ifocb = &sdata->u.ocb;
-	u32 changed = BSS_CHANGED_OCB | BSS_CHANGED_BSSID;
+	u64 changed = BSS_CHANGED_OCB | BSS_CHANGED_BSSID;
 	int err;
 
 	if (ifocb->joined == true)
-- 
2.38.1

