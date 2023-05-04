Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA106F6D23
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjEDNph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEDNpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B907DAC
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207933; x=1714743933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EawxLMNrDa5u4l5cYhw+fZt6Xxo4nTXA3IxTFkS47kk=;
  b=NtTrSSYwb3xP1qifqB/ebYMNMkU1/3DtU1vQ77shhLi2jn7NoGWCuBhr
   KcERq6iEl0fcwltdEK2BklIg/OUErnivsBgt2gJ8DKQF2yxzi70XOUNlB
   pWvasqhhTWF5fzJCdFJZzQp0RWX94FKSrgRVKIq7/371P8weDuVNl0z4I
   ITTJwYxNv46xxuDTYlYrz9AgP3RjYnfLj92oD7xtLjGhv98jgv6XGwKYA
   nni1oJmy/zC5Ez4v3ndFk9Ercx2kumFdGVFTFuKSTPJ+VNNLzqOpLpMkn
   +p5amWJnJ+GN6DxnawN6+0a3NZv4v6W7Yx+Hl6Gd6VL+jVDXdAuWqvUhK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242603"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242603"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591696"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591696"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/11] wifi: mac80211: consider reserved chanctx for mindef
Date:   Thu,  4 May 2023 16:45:03 +0300
Message-Id: <20230504134511.828474-4-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504134511.828474-1-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

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
---
 net/mac80211/chan.c        | 72 +++++++++++++++++++++++---------------
 net/mac80211/ieee80211_i.h |  3 +-
 net/mac80211/util.c        |  2 +-
 3 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index d23d1a7b4cc3..1b182cf9d661 100644
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
index a0a7839cb961..b0372e76f373 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2537,7 +2537,8 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *chanctx);
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx);
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for);
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
 void ieee80211_dfs_cac_timer(unsigned long data);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1527d6aafc14..4bf76150925d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3015,7 +3015,7 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 
 		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
 				       conf);
-		ieee80211_recalc_chanctx_min_def(local, chanctx);
+		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL);
 	}
  unlock:
 	mutex_unlock(&local->chanctx_mtx);
-- 
2.38.1

