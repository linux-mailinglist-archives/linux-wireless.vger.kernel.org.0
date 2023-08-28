Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5B78AF7E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjH1MFl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjH1MF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3BF124
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SXtLs+t64i1AZ3knU9VTOC+DO4gtHDaMn74inbRwfwA=;
        t=1693224326; x=1694433926; b=uPnG/dfjRhOP77iOjjeVhIrsIr0vKBh6MfzSjvtVeEN4nK8
        VqLRwg+ul0qgDnpXGA316vXQSzosvrntQTVWL5+VnBR5ejCxmYH3IMRYuR2ESoyeP8mfIbTBw/w4u
        5YpIPkE3B6eqWgB6G+r/xijrU4b+twEMxfw0QkVfPiJt8nqqnZxeRO7bzauo8t7F40jbRy9lnzFta
        sfr+0S1EYz15BzGUETbKoemhZB3L8ymAewrpeCXu1aOOZiOvIkhHQ5bGssbu+7FE3evc4f0Nd4DRX
        3FINK06VmBeeSDRVIREGpsL1kY/og8kiYclHehkLM6+GnDFpsutGjNc4CuSrTfXg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazk-00Gjgt-04;
        Mon, 28 Aug 2023 14:05:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 09/40] wifi: mac80211: move DFS CAC work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:37 +0200
Message-ID: <20230828135927.a9c110ef1f3e.I1f9981043d28fc80e96de07db97e6b1e337fb5bb@changeid>
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

Move the DFS CAC work over to hold the wiphy lock
there without worry about work cancellation.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 10 +++++-----
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/iface.c       |  3 ++-
 net/mac80211/link.c        |  4 ++--
 net/mac80211/mlme.c        |  7 +++----
 net/mac80211/util.c        |  3 ++-
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a2d0820e5e3c..e81e712448b2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1643,7 +1643,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	if (sdata->wdev.cac_started) {
 		chandef = link_conf->chandef;
-		cancel_delayed_work_sync(&link->dfs_cac_timer_work);
+		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
 				   GFP_KERNEL);
@@ -3421,9 +3421,8 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	if (err)
 		goto out_unlock;
 
-	ieee80211_queue_delayed_work(&sdata->local->hw,
-				     &sdata->deflink.dfs_cac_timer_work,
-				     msecs_to_jiffies(cac_time_ms));
+	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
+				 msecs_to_jiffies(cac_time_ms));
 
  out_unlock:
 	mutex_unlock(&local->mtx);
@@ -3442,7 +3441,8 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 		 * by the time it gets it, sdata->wdev.cac_started
 		 * will no longer be true
 		 */
-		cancel_delayed_work(&sdata->deflink.dfs_cac_timer_work);
+		wiphy_delayed_work_cancel(wiphy,
+					  &sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			ieee80211_link_release_channel(&sdata->deflink);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7604e43a441c..0d9aff6a4fc8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1014,7 +1014,7 @@ struct ieee80211_link_data {
 	int ap_power_level; /* in dBm */
 
 	bool radar_required;
-	struct delayed_work dfs_cac_timer_work;
+	struct wiphy_delayed_work dfs_cac_timer_work;
 
 	union {
 		struct ieee80211_link_data_managed mgd;
@@ -2569,7 +2569,7 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				      struct ieee80211_link_data *rsvd_for);
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
-void ieee80211_dfs_cac_timer_work(struct work_struct *work);
+void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work);
 void ieee80211_dfs_cac_cancel(struct ieee80211_local *local);
 void ieee80211_dfs_radar_detected_work(struct work_struct *work);
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4beab027e0f9..a8c08424c015 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -538,7 +538,8 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	cancel_work_sync(&sdata->deflink.csa_finalize_work);
 	cancel_work_sync(&sdata->deflink.color_change_finalize_work);
 
-	cancel_delayed_work_sync(&sdata->deflink.dfs_cac_timer_work);
+	wiphy_delayed_work_cancel(local->hw.wiphy,
+				  &sdata->deflink.dfs_cac_timer_work);
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chandef;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 6148208b320e..748d222e8d3d 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -45,8 +45,8 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			  ieee80211_color_collision_detection_work);
 	INIT_LIST_HEAD(&link->assigned_chanctx_list);
 	INIT_LIST_HEAD(&link->reserved_chanctx_list);
-	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
-			  ieee80211_dfs_cac_timer_work);
+	wiphy_delayed_work_init(&link->dfs_cac_timer_work,
+				ieee80211_dfs_cac_timer_work);
 
 	if (!deflink) {
 		switch (sdata->vif.type) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 65d3e167132c..5644e25ec5fe 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2401,12 +2401,11 @@ void ieee80211_dynamic_ps_timer(struct timer_list *t)
 	ieee80211_queue_work(&local->hw, &local->dynamic_ps_enable_work);
 }
 
-void ieee80211_dfs_cac_timer_work(struct work_struct *work)
+void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
-	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct ieee80211_link_data *link =
-		container_of(delayed_work, struct ieee80211_link_data,
-			     dfs_cac_timer_work);
+		container_of(work, struct ieee80211_link_data,
+			     dfs_cac_timer_work.work);
 	struct cfg80211_chan_def chandef = link->conf->chandef;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 6d8b73796dc5..ff99aee46656 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4343,7 +4343,8 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 		 * by the time it gets it, sdata->wdev.cac_started
 		 * will no longer be true
 		 */
-		cancel_delayed_work(&sdata->deflink.dfs_cac_timer_work);
+		wiphy_delayed_work_cancel(local->hw.wiphy,
+					  &sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			chandef = sdata->vif.bss_conf.chandef;
-- 
2.41.0

