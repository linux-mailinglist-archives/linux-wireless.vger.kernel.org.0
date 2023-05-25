Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4687114E9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjEYSlw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 14:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbjEYSl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 14:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C32D43;
        Thu, 25 May 2023 11:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D4E6422B;
        Thu, 25 May 2023 18:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F170C433D2;
        Thu, 25 May 2023 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039893;
        bh=/VWKJcaueCW+sM0cBUvFgOwzGVrfncdAZE1HSGzoJCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2ifmtBeLK6kV4ueapO+rtB9irvwzLm/do3Lqf3Kwu5PMkvb+uaz7Zy7c5SvVwmxJ
         f14PYKqqwwbaQwUXy1WtkHhikrDzGn2kIgl4aW5TSaYT5DTKl9t9mxNQoFmln9iAhT
         rTkJGhT4+b8svbiJKLe7QVanpJwFkqWo4bbx7ZpyRwg5v8fjaT/V4CkSClKB+yDiRo
         iKLCcrt5eUHupygYX/x3Bp2c0X70hyCyTzJ5ZefjGDoDLOcSGxMre8Z78KXw4IY7Gx
         aPELlC3bdmAPel5gmUx+9RlsA7ilmtFBaYXrZ5BQ+pqhFqpGSWfuh4IGYqbQAU4QK/
         uTMuaRhfslPfQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 40/57] wifi: mac80211: consider reserved chanctx for mindef
Date:   Thu, 25 May 2023 14:35:50 -0400
Message-Id: <20230525183607.1793983-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit b72a455a2409fd94d6d9b4eb51d659a88213243b ]

When a chanctx is reserved for a new vif and we recalculate
the minimal definition for it, we need to consider the new
interface it's being reserved for before we assign it, so it
can be used directly with the correct min channel width.

Fix the code to - optionally - consider that, and use that
option just before doing the reassignment.

Also, when considering channel context reservations, we
should only consider the one link we're currently working with.
Change the boolean argument to a link pointer to do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230504134511.828474-4-gregory.greenman@intel.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c        | 72 +++++++++++++++++++++++---------------
 net/mac80211/ieee80211_i.h |  3 +-
 net/mac80211/util.c        |  2 +-
 3 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 76c6decb0762c..c5d345e53056a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -258,7 +258,8 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
 
 static enum nl80211_chan_width
 ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
-					  struct ieee80211_chanctx_conf *conf)
+					  struct ieee80211_chanctx *ctx,
+					  struct ieee80211_link_data *rsvd_for)
 {
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct ieee80211_vif *vif = &sdata->vif;
@@ -267,13 +268,14 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 	rcu_read_lock();
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 		enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20_NOHT;
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference(sdata->vif.link_conf[link_id]);
+		struct ieee80211_link_data *link =
+			rcu_dereference(sdata->link[link_id]);
 
-		if (!link_conf)
+		if (!link)
 			continue;
 
-		if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
+		if (link != rsvd_for &&
+		    rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
 			continue;
 
 		switch (vif->type) {
@@ -287,7 +289,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 			 * point, so take the width from the chandef, but
 			 * account also for TDLS peers
 			 */
-			width = max(link_conf->chandef.width,
+			width = max(link->conf->chandef.width,
 				    ieee80211_get_max_required_bw(sdata, link_id));
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
@@ -296,7 +298,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
-			width = link_conf->chandef.width;
+			width = link->conf->chandef.width;
 			break;
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_UNSPECIFIED:
@@ -316,7 +318,8 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 
 static enum nl80211_chan_width
 ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
-				      struct ieee80211_chanctx_conf *conf)
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for)
 {
 	struct ieee80211_sub_if_data *sdata;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
@@ -328,7 +331,8 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		width = ieee80211_get_chanctx_vif_max_required_bw(sdata, conf);
+		width = ieee80211_get_chanctx_vif_max_required_bw(sdata, ctx,
+								  rsvd_for);
 
 		max_bw = max(max_bw, width);
 	}
@@ -336,8 +340,8 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 	/* use the configured bandwidth in case of monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
 	if (sdata &&
-	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == conf)
-		max_bw = max(max_bw, conf->def.width);
+	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == &ctx->conf)
+		max_bw = max(max_bw, ctx->conf.def.width);
 
 	rcu_read_unlock();
 
@@ -349,8 +353,10 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
  * the max of min required widths of all the interfaces bound to this
  * channel context.
  */
-static u32 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-					     struct ieee80211_chanctx *ctx)
+static u32
+_ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
+				  struct ieee80211_chanctx *ctx,
+				  struct ieee80211_link_data *rsvd_for)
 {
 	enum nl80211_chan_width max_bw;
 	struct cfg80211_chan_def min_def;
@@ -370,7 +376,7 @@ static u32 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 		return 0;
 	}
 
-	max_bw = ieee80211_get_chanctx_max_required_bw(local, &ctx->conf);
+	max_bw = ieee80211_get_chanctx_max_required_bw(local, ctx, rsvd_for);
 
 	/* downgrade chandef up to max_bw */
 	min_def = ctx->conf.def;
@@ -448,9 +454,10 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
  * channel context.
  */
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx)
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for)
 {
-	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx);
+	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 
 	if (!changed)
 		return;
@@ -464,10 +471,11 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, ctx, false);
 }
 
-static void ieee80211_change_chanctx(struct ieee80211_local *local,
-				     struct ieee80211_chanctx *ctx,
-				     struct ieee80211_chanctx *old_ctx,
-				     const struct cfg80211_chan_def *chandef)
+static void _ieee80211_change_chanctx(struct ieee80211_local *local,
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_chanctx *old_ctx,
+				      const struct cfg80211_chan_def *chandef,
+				      struct ieee80211_link_data *rsvd_for)
 {
 	u32 changed;
 
@@ -492,7 +500,7 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, old_ctx, true);
 
 	if (cfg80211_chandef_identical(&ctx->conf.def, chandef)) {
-		ieee80211_recalc_chanctx_min_def(local, ctx);
+		ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 		return;
 	}
 
@@ -502,7 +510,7 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 
 	/* check if min chanctx also changed */
 	changed = IEEE80211_CHANCTX_CHANGE_WIDTH |
-		  _ieee80211_recalc_chanctx_min_def(local, ctx);
+		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 	drv_change_chanctx(local, ctx, changed);
 
 	if (!local->use_chanctx) {
@@ -514,6 +522,14 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, old_ctx, false);
 }
 
+static void ieee80211_change_chanctx(struct ieee80211_local *local,
+				     struct ieee80211_chanctx *ctx,
+				     struct ieee80211_chanctx *old_ctx,
+				     const struct cfg80211_chan_def *chandef)
+{
+	_ieee80211_change_chanctx(local, ctx, old_ctx, chandef, NULL);
+}
+
 static struct ieee80211_chanctx *
 ieee80211_find_chanctx(struct ieee80211_local *local,
 		       const struct cfg80211_chan_def *chandef,
@@ -638,7 +654,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
-	_ieee80211_recalc_chanctx_min_def(local, ctx);
+	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
 
 	return ctx;
 }
@@ -873,12 +889,12 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_chantype(local, curr_ctx);
 		ieee80211_recalc_smps_chanctx(local, curr_ctx);
 		ieee80211_recalc_radar_chanctx(local, curr_ctx);
-		ieee80211_recalc_chanctx_min_def(local, curr_ctx);
+		ieee80211_recalc_chanctx_min_def(local, curr_ctx, NULL);
 	}
 
 	if (new_ctx && ieee80211_chanctx_num_assigned(local, new_ctx) > 0) {
 		ieee80211_recalc_txpower(sdata, false);
-		ieee80211_recalc_chanctx_min_def(local, new_ctx);
+		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
 	}
 
 	if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
@@ -1270,7 +1286,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 
 	ieee80211_link_update_chandef(link, &link->reserved_chandef);
 
-	ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef);
+	_ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef, link);
 
 	vif_chsw[0].vif = &sdata->vif;
 	vif_chsw[0].old_ctx = &old_ctx->conf;
@@ -1300,7 +1316,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
 		ieee80211_free_chanctx(local, old_ctx);
 
-	ieee80211_recalc_chanctx_min_def(local, new_ctx);
+	ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
 	ieee80211_recalc_smps_chanctx(local, new_ctx);
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
 
@@ -1665,7 +1681,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_chanctx_chantype(local, ctx);
 		ieee80211_recalc_smps_chanctx(local, ctx);
 		ieee80211_recalc_radar_chanctx(local, ctx);
-		ieee80211_recalc_chanctx_min_def(local, ctx);
+		ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
 
 		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
 					 reserved_chanctx_list) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e57001e00a3d0..27479bbb093ac 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2475,7 +2475,8 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *chanctx);
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx);
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for);
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
 void ieee80211_dfs_cac_timer(unsigned long data);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0785d9393e718..784b9ba61581e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2899,7 +2899,7 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 
 		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
 				       conf);
-		ieee80211_recalc_chanctx_min_def(local, chanctx);
+		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL);
 	}
  unlock:
 	mutex_unlock(&local->chanctx_mtx);
-- 
2.39.2

