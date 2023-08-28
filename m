Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1008B78AFA5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjH1MG1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjH1MFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F11124
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6wdlIn9ENEH4GRQYo9pzj6GJmoO0hEGgemYsQSWzOBA=;
        t=1693224349; x=1694433949; b=ldwyLQyhQ+SP1VfHPXn8xHtxrLRoYjkR2Z1MOqdF43O3kof
        BqUgzVDnjqG8WFIyRkX/7hKT3SMt4lZuUafj/6QFjkx9EwQJigYNMs9OgkPrl5rWlL54yfHQHasGG
        qCsQoRKntn3sYGlfnGZPyVLst+hlA30jifJzTXWr8VLY1gJeKIDFwVnW85ys8zfsfLmj3Xyc/K12k
        q5s+DNRIWUPaKf5Mu4cbp0SG+kttHYJ1bswBABOpa5cqkIj/z7vwibWUvVorTyu5798zapEf7i4jg
        iSizgIaCp3YjHIJT6lfxFEgJg1SKpaeSqq2uhtS1OO58Y5TV9MhE2E462esEOdNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab07-00Gjgt-0x;
        Mon, 28 Aug 2023 14:05:47 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 35/40] wifi: mac80211: remove chanctx_mtx
Date:   Mon, 28 Aug 2023 14:00:03 +0200
Message-ID: <20230828135928.73d0e656f433.Ida8a388cd3cdd6ff350b6182bec7a53d2c799e9b@changeid>
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
needed the chanctx_mtx, so we don't need this mutex any
more. Remove it.

Most of this change was done automatically with spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  18 +++--
 net/mac80211/chan.c        | 131 ++++++++++++++++---------------------
 net/mac80211/ibss.c        |   4 +-
 net/mac80211/ieee80211_i.h |   7 +-
 net/mac80211/iface.c       |   7 +-
 net/mac80211/main.c        |   1 -
 net/mac80211/mlme.c        |  22 +++----
 net/mac80211/tdls.c        |  19 +++---
 net/mac80211/util.c        |  46 ++++++-------
 9 files changed, 113 insertions(+), 142 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 889145328754..a90a6f8475de 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -261,9 +261,9 @@ static int ieee80211_start_p2p_device(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	int ret;
 
-	mutex_lock(&sdata->local->chanctx_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
-	mutex_unlock(&sdata->local->chanctx_mtx);
 	if (ret < 0)
 		return ret;
 
@@ -283,9 +283,9 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	int ret;
 
-	mutex_lock(&sdata->local->chanctx_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
-	mutex_unlock(&sdata->local->chanctx_mtx);
 	if (ret < 0)
 		return ret;
 
@@ -3616,7 +3616,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 
 	sdata_assert_lock(sdata);
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/*
 	 * using reservation isn't immediate as it may be deferred until later
@@ -3689,7 +3689,7 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	sdata_lock(sdata);
 	mutex_lock(&local->mtx);
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* AP might have been stopped while waiting for the lock. */
 	if (!sdata->vif.bss_conf.csa_active)
@@ -3701,7 +3701,6 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 	ieee80211_csa_finalize(sdata);
 
 unlock:
-	mutex_unlock(&local->chanctx_mtx);
 	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 }
@@ -3861,6 +3860,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	sdata_assert_lock(sdata);
 	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!list_empty(&local->roc_list) || local->scanning)
 		return -EBUSY;
@@ -3876,9 +3876,8 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->vif.bss_conf.csa_active)
 		return -EBUSY;
 
-	mutex_lock(&local->chanctx_mtx);
 	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (!conf) {
 		err = -EBUSY;
 		goto out;
@@ -3952,7 +3951,6 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 out:
-	mutex_unlock(&local->chanctx_mtx);
 	return err;
 }
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index f967ed9d2a3a..31720c654b83 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -18,7 +18,7 @@ static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
 	struct ieee80211_link_data *link;
 	int num = 0;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list)
 		num++;
@@ -32,7 +32,7 @@ static int ieee80211_chanctx_num_reserved(struct ieee80211_local *local,
 	struct ieee80211_link_data *link;
 	int num = 0;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list)
 		num++;
@@ -52,7 +52,7 @@ static int ieee80211_num_chanctx(struct ieee80211_local *local)
 	struct ieee80211_chanctx *ctx;
 	int num = 0;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(ctx, &local->chanctx_list, list)
 		num++;
@@ -62,7 +62,8 @@ static int ieee80211_num_chanctx(struct ieee80211_local *local)
 
 static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
 {
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	return ieee80211_num_chanctx(local) < ieee80211_max_num_channels(local);
 }
 
@@ -73,7 +74,7 @@ ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
 	struct ieee80211_chanctx_conf *conf;
 
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (!conf)
 		return NULL;
 
@@ -87,7 +88,7 @@ ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
 {
 	struct ieee80211_link_data *link;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(link, &ctx->reserved_links,
 			    reserved_chanctx_list) {
@@ -110,7 +111,7 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 {
 	struct ieee80211_link_data *link;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(link, &ctx->assigned_links,
 			    assigned_chanctx_list) {
@@ -136,7 +137,7 @@ ieee80211_chanctx_combined_chandef(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *ctx,
 				   const struct cfg80211_chan_def *compat)
 {
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	compat = ieee80211_chanctx_reserved_chandef(local, ctx, compat);
 	if (!compat)
@@ -154,7 +155,7 @@ ieee80211_chanctx_can_reserve_chandef(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
 				      const struct cfg80211_chan_def *def)
 {
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (ieee80211_chanctx_combined_chandef(local, ctx, def))
 		return true;
@@ -173,7 +174,7 @@ ieee80211_find_reservation_chanctx(struct ieee80211_local *local,
 {
 	struct ieee80211_chanctx *ctx;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (mode == IEEE80211_CHANCTX_EXCLUSIVE)
 		return NULL;
@@ -361,7 +362,7 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	enum nl80211_chan_width max_bw;
 	struct cfg80211_chan_def min_def;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* don't optimize non-20MHz based and radar_enabled confs */
 	if (ctx->conf.def.width == NL80211_CHAN_WIDTH_5 ||
@@ -537,7 +538,7 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 {
 	struct ieee80211_chanctx *ctx;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (mode == IEEE80211_CHANCTX_EXCLUSIVE)
 		return NULL;
@@ -602,7 +603,7 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 	struct ieee80211_sub_if_data *sdata;
 	bool required = false;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	lockdep_assert_held(&local->mtx);
 
 	rcu_read_lock();
@@ -641,7 +642,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 {
 	struct ieee80211_chanctx *ctx;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	ctx = kzalloc(sizeof(*ctx) + local->hw.chanctx_data_size, GFP_KERNEL);
 	if (!ctx)
@@ -666,7 +667,7 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 	int err;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->use_chanctx)
 		local->hw.conf.radar_enabled = ctx->conf.radar_enabled;
@@ -699,7 +700,7 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 	int err;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	ctx = ieee80211_alloc_chanctx(local, chandef, mode);
 	if (!ctx)
@@ -718,7 +719,7 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 static void ieee80211_del_chanctx(struct ieee80211_local *local,
 				  struct ieee80211_chanctx *ctx)
 {
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->use_chanctx) {
 		struct cfg80211_chan_def *chandef = &local->_oper_chandef;
@@ -753,7 +754,7 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 static void ieee80211_free_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *ctx)
 {
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	WARN_ON_ONCE(ieee80211_chanctx_refcount(local, ctx) != 0);
 
@@ -770,7 +771,7 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 	const struct cfg80211_chan_def *compat = NULL;
 	struct sta_info *sta;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
@@ -833,7 +834,7 @@ static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
 {
 	bool radar_enabled;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	/* for ieee80211_is_radar_required */
 	lockdep_assert_held(&local->mtx);
 
@@ -865,7 +866,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		return -ENOTSUPP;
 
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 
 	if (conf) {
 		curr_ctx = container_of(conf, struct ieee80211_chanctx, conf);
@@ -920,7 +921,7 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 	struct ieee80211_sub_if_data *sdata;
 	u8 rx_chains_static, rx_chains_dynamic;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rx_chains_static = 1;
 	rx_chains_dynamic = 1;
@@ -1032,7 +1033,7 @@ __ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 	 * to a channel context that has already been freed.
 	 */
 	conf = rcu_dereference_protected(link_conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	WARN_ON(!conf);
 
 	if (clear)
@@ -1056,11 +1057,9 @@ void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 {
 	struct ieee80211_local *local = link->sdata->local;
 
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	__ieee80211_link_copy_chanctx_to_vlans(link, clear);
-
-	mutex_unlock(&local->chanctx_mtx);
 }
 
 int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
@@ -1068,7 +1067,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *ctx = link->reserved_chanctx;
 
-	lockdep_assert_held(&sdata->local->chanctx_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (WARN_ON(!ctx))
 		return -EINVAL;
@@ -1108,7 +1107,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *new_ctx, *curr_ctx, *ctx;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	curr_ctx = ieee80211_link_get_chanctx(link);
 	if (curr_ctx && local->use_chanctx && !local->ops->switch_vif_chanctx)
@@ -1266,7 +1265,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	int err;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
@@ -1390,7 +1389,7 @@ ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 
-	lockdep_assert_held(&sdata->local->chanctx_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
@@ -1416,7 +1415,7 @@ static int ieee80211_chsw_switch_hwconf(struct ieee80211_local *local,
 	const struct cfg80211_chan_def *chandef;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	chandef = ieee80211_chanctx_reserved_chandef(local, new_ctx, NULL);
 	if (WARN_ON(!chandef))
@@ -1438,7 +1437,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 	int i, err;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	vif_chsw = kcalloc(n_vifs, sizeof(vif_chsw[0]), GFP_KERNEL);
 	if (!vif_chsw)
@@ -1483,7 +1482,7 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 	int err;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
@@ -1524,7 +1523,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	int n_ctx = 0, n_vifs_switch = 0, n_vifs_assign = 0, n_vifs_ctxless = 0;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/*
 	 * If there are 2 independent pairs of channel contexts performing
@@ -1783,10 +1782,10 @@ static void __ieee80211_link_release_channel(struct ieee80211_link_data *link)
 	struct ieee80211_chanctx *ctx;
 	bool use_reserved_switch = false;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	conf = rcu_dereference_protected(link_conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (!conf)
 		return;
 
@@ -1829,7 +1828,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 		return 0;
 	}
 
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	ret = cfg80211_chandef_dfs_required(local->hw.wiphy,
 					    chandef,
@@ -1872,7 +1871,6 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (ret)
 		link->radar_required = false;
 
-	mutex_unlock(&local->chanctx_mtx);
 	return ret;
 }
 
@@ -1885,7 +1883,7 @@ int ieee80211_link_use_reserved_context(struct ieee80211_link_data *link)
 	int err;
 
 	lockdep_assert_held(&local->mtx);
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	new_ctx = link->reserved_chanctx;
 	old_ctx = ieee80211_link_get_chanctx(link);
@@ -1948,51 +1946,40 @@ int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
 	const struct cfg80211_chan_def *compat;
-	int ret;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!cfg80211_chandef_usable(sdata->local->hw.wiphy, chandef,
 				     IEEE80211_CHAN_DISABLED))
 		return -EINVAL;
 
-	mutex_lock(&local->chanctx_mtx);
-	if (cfg80211_chandef_identical(chandef, &link_conf->chandef)) {
-		ret = 0;
-		goto out;
-	}
+	if (cfg80211_chandef_identical(chandef, &link_conf->chandef))
+		return 0;
 
 	if (chandef->width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    link_conf->chandef.width == NL80211_CHAN_WIDTH_20_NOHT) {
-		ret = -EINVAL;
-		goto out;
-	}
+	    link_conf->chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
+		return -EINVAL;
 
 	conf = rcu_dereference_protected(link_conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
-	if (!conf) {
-		ret = -EINVAL;
-		goto out;
-	}
+					 lockdep_is_held(&local->hw.wiphy->mtx));
+	if (!conf)
+		return -EINVAL;
 
 	ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
 	compat = cfg80211_chandef_compatible(&conf->def, chandef);
-	if (!compat) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!compat)
+		return -EINVAL;
 
 	switch (ctx->replace_state) {
 	case IEEE80211_CHANCTX_REPLACE_NONE:
-		if (!ieee80211_chanctx_reserved_chandef(local, ctx, compat)) {
-			ret = -EBUSY;
-			goto out;
-		}
+		if (!ieee80211_chanctx_reserved_chandef(local, ctx, compat))
+			return -EBUSY;
 		break;
 	case IEEE80211_CHANCTX_WILL_BE_REPLACED:
 		/* TODO: Perhaps the bandwidth change could be treated as a
 		 * reservation itself? */
-		ret = -EBUSY;
-		goto out;
+		return -EBUSY;
 	case IEEE80211_CHANCTX_REPLACES_OTHER:
 		/* channel context that is going to replace another channel
 		 * context doesn't really exist and shouldn't be assigned
@@ -2006,22 +1993,19 @@ int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
 	ieee80211_recalc_chanctx_chantype(local, ctx);
 
 	*changed |= BSS_CHANGED_BANDWIDTH;
-	ret = 0;
- out:
-	mutex_unlock(&local->chanctx_mtx);
-	return ret;
+	return 0;
 }
 
 void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
-	mutex_lock(&sdata->local->chanctx_mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	if (rcu_access_pointer(link->conf->chanctx_conf)) {
 		lockdep_assert_held(&sdata->local->mtx);
 		__ieee80211_link_release_channel(link);
 	}
-	mutex_unlock(&sdata->local->chanctx_mtx);
 }
 
 void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
@@ -2034,20 +2018,19 @@ void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
 	struct ieee80211_sub_if_data *ap;
 	struct ieee80211_chanctx_conf *conf;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_AP_VLAN || !sdata->bss))
 		return;
 
 	ap = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
 
-	mutex_lock(&local->chanctx_mtx);
-
 	rcu_read_lock();
 	ap_conf = rcu_dereference(ap->vif.link_conf[link_id]);
 	conf = rcu_dereference_protected(ap_conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	rcu_assign_pointer(link_conf->chanctx_conf, conf);
 	rcu_read_unlock();
-	mutex_unlock(&local->chanctx_mtx);
 }
 
 void ieee80211_iter_chan_contexts_atomic(
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index d68650cbd5ff..bbda2764fa02 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1765,6 +1765,8 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	int i;
 	int ret;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (params->chandef.chan->freq_offset) {
 		/* this may work, but is untested */
 		return -EOPNOTSUPP;
@@ -1785,10 +1787,8 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	chanmode = (params->channel_fixed && !ret) ?
 		IEEE80211_CHANCTX_SHARED : IEEE80211_CHANCTX_EXCLUSIVE;
 
-	mutex_lock(&local->chanctx_mtx);
 	ret = ieee80211_check_combinations(sdata, &params->chandef, chanmode,
 					   radar_detect_width);
-	mutex_unlock(&local->chanctx_mtx);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a0bbd7070974..cc671b471542 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -979,8 +979,8 @@ struct ieee80211_link_data {
 	struct ieee80211_sub_if_data *sdata;
 	unsigned int link_id;
 
-	struct list_head assigned_chanctx_list; /* protected by chanctx_mtx */
-	struct list_head reserved_chanctx_list; /* protected by chanctx_mtx */
+	struct list_head assigned_chanctx_list; /* protected by wiphy mutex */
+	struct list_head reserved_chanctx_list; /* protected by wiphy mutex */
 
 	/* multicast keys only */
 	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
@@ -1001,7 +1001,7 @@ struct ieee80211_link_data {
 	struct delayed_work color_collision_detect_work;
 	u64 color_bitmap;
 
-	/* context reservation -- protected with chanctx_mtx */
+	/* context reservation -- protected with wiphy mutex */
 	struct ieee80211_chanctx *reserved_chanctx;
 	struct cfg80211_chan_def reserved_chandef;
 	bool reserved_radar_required;
@@ -1499,7 +1499,6 @@ struct ieee80211_local {
 
 	/* channel contexts */
 	struct list_head chanctx_list;
-	struct mutex chanctx_mtx;
 
 #ifdef CONFIG_MAC80211_LEDS
 	struct led_trigger tx_led, rx_led, assoc_led, radio_led;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 385513315f8b..97733520d6b3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -324,9 +324,9 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *nsdata;
-	int ret;
 
 	ASSERT_RTNL();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* we hold the RTNL here so can safely walk the list */
 	list_for_each_entry(nsdata, &local->interfaces, list) {
@@ -391,10 +391,7 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	mutex_lock(&local->chanctx_mtx);
-	ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
-	mutex_unlock(&local->chanctx_mtx);
-	return ret;
+	return ieee80211_check_combinations(sdata, NULL, 0, 0);
 }
 
 static int ieee80211_check_queues(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a30eb5ca6369..0f38b5df53b3 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -826,7 +826,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	spin_lock_init(&local->handle_wake_tx_queue_lock);
 
 	INIT_LIST_HEAD(&local->chanctx_list);
-	mutex_init(&local->chanctx_mtx);
 
 	wiphy_delayed_work_init(&local->scan_work, ieee80211_scan_work);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4296168877e8..605407e4b67f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1691,7 +1691,7 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 
 	sdata_lock(sdata);
 	mutex_lock(&local->mtx);
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ifmgd->associated)
 		goto out;
@@ -1743,7 +1743,6 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 	ieee80211_sta_reset_conn_monitor(sdata);
 
 out:
-	mutex_unlock(&local->chanctx_mtx);
 	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 }
@@ -1813,14 +1812,14 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!local->ops->abort_channel_switch)
 		return;
 
 	mutex_lock(&local->mtx);
 
-	mutex_lock(&local->chanctx_mtx);
 	ieee80211_link_unreserve_chanctx(link);
-	mutex_unlock(&local->chanctx_mtx);
 
 	if (link->csa_block_tx)
 		ieee80211_wake_vif_queues(local, sdata,
@@ -1854,6 +1853,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	int res;
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!cbss)
 		return;
@@ -1936,9 +1936,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	ieee80211_teardown_tdls_peers(sdata);
 
 	mutex_lock(&local->mtx);
-	mutex_lock(&local->chanctx_mtx);
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (!conf) {
 		sdata_info(sdata,
 			   "no channel context assigned to vif?, disconnecting\n");
@@ -1968,7 +1967,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 			   res);
 		goto drop_connection;
 	}
-	mutex_unlock(&local->chanctx_mtx);
 
 	link->conf->csa_active = true;
 	link->csa_chandef = csa_ie.chandef;
@@ -2000,7 +1998,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	return;
  lock_and_drop_connection:
 	mutex_lock(&local->mtx);
-	mutex_lock(&local->chanctx_mtx);
  drop_connection:
 	/*
 	 * This is just so that the disconnect flow will know that
@@ -2014,7 +2011,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
 			 &ifmgd->csa_connection_drop_work);
-	mutex_unlock(&local->chanctx_mtx);
 	mutex_unlock(&local->mtx);
 }
 
@@ -3186,6 +3182,8 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
 		return;
 
@@ -3207,7 +3205,6 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	ifmgd->probe_send_count++;
 
 	if (dst) {
-		lockdep_assert_wiphy(sdata->local->hw.wiphy);
 		sta = sta_info_get(sdata, dst);
 		if (!WARN_ON(!sta))
 			ieee80211_check_fast_rx(sta);
@@ -3629,6 +3626,8 @@ static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
 	const u8 *ap_addr = ifmgd->auth_data->ap_addr;
 	struct sta_info *sta;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	sdata_info(sdata, "authenticated\n");
 	ifmgd->auth_data->done = true;
 	ifmgd->auth_data->timeout = jiffies + IEEE80211_AUTH_WAIT_ASSOC;
@@ -3636,7 +3635,6 @@ static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
 	run_again(sdata, ifmgd->auth_data->timeout);
 
 	/* move station state to auth */
-	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 	sta = sta_info_get(sdata, ap_addr);
 	if (!sta) {
 		WARN_ONCE(1, "%s: STA %pM not found", sdata->name, ap_addr);
@@ -5899,6 +5897,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	};
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* Process beacon from the current BSS */
 	bssid = ieee80211_get_bssid(hdr, len, sdata->vif.type);
@@ -6133,7 +6132,6 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				le16_to_cpu(mgmt->u.beacon.capab_info),
 				erp_valid, erp_value);
 
-	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 	if (WARN_ON(!sta)) {
 		goto free;
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index e7bf25e3be07..d6d3123f4e3a 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1354,9 +1354,10 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_chan_width width;
 	struct ieee80211_supported_band *sband;
 
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (conf) {
 		width = conf->def.width;
 		sband = local->hw.wiphy->bands[conf->def.chan->band];
@@ -1384,7 +1385,6 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 		}
 
 	}
-	mutex_unlock(&local->chanctx_mtx);
 }
 
 static int iee80211_tdls_have_ht_peers(struct ieee80211_sub_if_data *sdata)
@@ -1447,6 +1447,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	int ret;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!(wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS))
 		return -ENOTSUPP;
 
@@ -1479,7 +1481,6 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			break;
 		}
 
-		lockdep_assert_wiphy(local->hw.wiphy);
 		sta = sta_info_get(sdata, peer);
 		if (!sta) {
 			ret = -ENOLINK;
@@ -1512,7 +1513,6 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 		ret = sta_info_destroy_addr(sdata, peer);
 
-		lockdep_assert_wiphy(local->hw.wiphy);
 		iee80211_tdls_recalc_ht_protection(sdata, NULL);
 
 		iee80211_tdls_recalc_chanctx(sdata, NULL);
@@ -1667,11 +1667,12 @@ ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	u32 ch_sw_tm_ie;
 	int ret;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (chandef->chan->freq_offset)
 		/* this may work, but is untested */
 		return -EOPNOTSUPP;
 
-	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, addr);
 	if (!sta) {
 		tdls_dbg(sdata,
@@ -1793,6 +1794,8 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tdls_ch_sw_params params = {};
 	int ret;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	params.action_code = WLAN_TDLS_CHANNEL_SWITCH_RESPONSE;
 	params.timestamp = rx_status->device_timestamp;
 
@@ -1802,7 +1805,6 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, tf->sa);
 	if (!sta || !test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH)) {
 		tdls_dbg(sdata, "TDLS chan switch from non-peer sta %pM\n",
@@ -1890,6 +1892,8 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tdls_ch_sw_params params = {};
 	int ret = 0;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	params.action_code = WLAN_TDLS_CHANNEL_SWITCH_REQUEST;
 	params.timestamp = rx_status->device_timestamp;
 
@@ -1978,7 +1982,6 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 		goto free;
 	}
 
-	lockdep_assert_wiphy(local->hw.wiphy);
 	sta = sta_info_get(sdata, tf->sa);
 	if (!sta || !test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH)) {
 		tdls_dbg(sdata, "TDLS chan switch from non-peer sta %pM\n",
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 279a65198885..dce8c2043096 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2351,6 +2351,8 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_chanctx *ctx;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/*
 	 * We get here if during resume the device can't be restarted properly.
 	 * We might also get here if this happens during HW reset, which is a
@@ -2379,10 +2381,8 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 	/* Mark channel contexts as not being in the driver any more to avoid
 	 * removing them from the driver during the shutdown process...
 	 */
-	mutex_lock(&local->chanctx_mtx);
 	list_for_each_entry(ctx, &local->chanctx_list, list)
 		ctx->driver_present = false;
-	mutex_unlock(&local->chanctx_mtx);
 }
 
 static void ieee80211_assign_chanctx(struct ieee80211_local *local,
@@ -2392,17 +2392,17 @@ static void ieee80211_assign_chanctx(struct ieee80211_local *local,
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!local->use_chanctx)
 		return;
 
-	mutex_lock(&local->chanctx_mtx);
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
-					 lockdep_is_held(&local->chanctx_mtx));
+					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (conf) {
 		ctx = container_of(conf, struct ieee80211_chanctx, conf);
 		drv_assign_vif_chanctx(local, sdata, link->conf, ctx);
 	}
-	mutex_unlock(&local->chanctx_mtx);
 }
 
 static void ieee80211_reconfig_stations(struct ieee80211_sub_if_data *sdata)
@@ -2410,8 +2410,9 @@ static void ieee80211_reconfig_stations(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/* add STAs back */
-	lockdep_assert_wiphy(local->hw.wiphy);
 	list_for_each_entry(sta, &local->sta_list, list) {
 		enum ieee80211_sta_state state;
 
@@ -2509,6 +2510,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	bool suspended = local->suspended;
 	bool in_reconfig = false;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/* nothing to do if HW shouldn't run */
 	if (!local->open_count)
 		goto wake_up;
@@ -2624,12 +2627,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 	/* add channel contexts */
 	if (local->use_chanctx) {
-		mutex_lock(&local->chanctx_mtx);
 		list_for_each_entry(ctx, &local->chanctx_list, list)
 			if (ctx->replace_state !=
 			    IEEE80211_CHANCTX_REPLACES_OTHER)
 				WARN_ON(drv_add_chanctx(local, ctx));
-		mutex_unlock(&local->chanctx_mtx);
 
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
@@ -2901,8 +2902,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	 * are active. This is really a workaround though.
 	 */
 	if (ieee80211_hw_check(hw, AMPDU_AGGREGATION)) {
-		lockdep_assert_wiphy(local->hw.wiphy);
-
 		list_for_each_entry(sta, &local->sta_list, list) {
 			if (!local->resuming)
 				ieee80211_sta_tear_down_BA_sessions(
@@ -3025,10 +3024,10 @@ void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_chanctx *chanctx;
 
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	chanctx_conf = rcu_dereference_protected(link->conf->chanctx_conf,
-						 lockdep_is_held(&local->chanctx_mtx));
+						 lockdep_is_held(&local->hw.wiphy->mtx));
 
 	/*
 	 * This function can be called from a work, thus it may be possible
@@ -3037,12 +3036,10 @@ void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
 	 * So nothing should be done in such case.
 	 */
 	if (!chanctx_conf)
-		goto unlock;
+		return;
 
 	chanctx = container_of(chanctx_conf, struct ieee80211_chanctx, conf);
 	ieee80211_recalc_smps_chanctx(local, chanctx);
- unlock:
-	mutex_unlock(&local->chanctx_mtx);
 }
 
 void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
@@ -3053,7 +3050,7 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_chanctx *chanctx;
 	int i;
 
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	for (i = 0; i < ARRAY_SIZE(sdata->vif.link_conf); i++) {
 		struct ieee80211_bss_conf *bss_conf;
@@ -3069,9 +3066,9 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 		}
 
 		chanctx_conf = rcu_dereference_protected(bss_conf->chanctx_conf,
-							 lockdep_is_held(&local->chanctx_mtx));
+							 lockdep_is_held(&local->hw.wiphy->mtx));
 		/*
-		 * Since we hold the chanctx_mtx (checked above)
+		 * Since we hold the wiphy mutex (checked above)
 		 * we can take the chanctx_conf pointer out of the
 		 * RCU critical section, it cannot go away without
 		 * the mutex. Just the way we reached it could - in
@@ -3081,14 +3078,12 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 		rcu_read_unlock();
 
 		if (!chanctx_conf)
-			goto unlock;
+			return;
 
 		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
 				       conf);
 		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL);
 	}
- unlock:
-	mutex_unlock(&local->chanctx_mtx);
 }
 
 size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset)
@@ -4364,7 +4359,7 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 	struct ieee80211_chanctx *ctx;
 	int num_chanctx = 0;
 
-	mutex_lock(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
@@ -4372,7 +4367,6 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 		num_chanctx++;
 		chandef = ctx->conf.def;
 	}
-	mutex_unlock(&local->chanctx_mtx);
 
 	ieee80211_dfs_cac_cancel(local);
 
@@ -4773,7 +4767,7 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	struct ieee80211_link_data *link;
 	u8 radar_detect = 0;
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED))
 		return 0;
@@ -4814,7 +4808,7 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 		.radar_detect = radar_detect,
 	};
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(hweight32(radar_detect) > 1))
 		return -EINVAL;
@@ -4904,7 +4898,7 @@ int ieee80211_max_num_channels(struct ieee80211_local *local)
 	int err;
 	struct iface_combination_params params = {0};
 
-	lockdep_assert_held(&local->chanctx_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
-- 
2.41.0

