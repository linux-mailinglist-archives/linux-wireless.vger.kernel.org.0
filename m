Return-Path: <linux-wireless+bounces-8872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24408905291
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54EBAB228EB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1E170835;
	Wed, 12 Jun 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UxT/gn6Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216E16FF55
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195669; cv=none; b=s66/D22WROzihTX8C/61MbLGRhLNKz3z/DFd4PsrstMroQOtyPJ1KjmFsf3mvrSZDw8QudAl9vRY/BTsomrX/1BTL/JrozS64plctssHY4nAZqvF1TSbtSbXE+VN7oml4xqIjD4XWHW1GUZCRAwoEqjxVcX14Ag2fZiwzoIoPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195669; c=relaxed/simple;
	bh=/ukZ/NuiexVZ/wc7X1BMLYaqhvSNaDFLtycBxFWTaLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8J4DC9lmtU9hFVWa1edkpKF1OWLSa8dPPBXMaCbkDB+HcSjyfiSr8jpT/UMLvDJ7/p4y2WkUy8l7ink4P0j2vF0NMsF9m2DgLmJCeHJ7hR4/dFFZ55nppMxXF+4v/8nETDMZGA771p8/G6Iy9OevYFacX26Ju6ae7tSGht4+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UxT/gn6Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wmg28WGCyKZC+uOkyqUtR3o61JzXl3oX3gTs0ya0CdA=;
	t=1718195667; x=1719405267; b=UxT/gn6YwbpVBMPzyICVSj1/MTEES2DPR2J1OAduBs/a9Ly
	zalaiGKkdq2sGHWU/7a+TKhDjp7Lh71ZNmGwFuDgFttOh6Uk5545WmmXfvARDR9SFhCSzNTfwHZYI
	DKMixlOmxEkor7368ahY3sCL0UQ6bXN3zBfcy45IzHm6aG85v3hVN+W2fHR9nkUbmjBQlzLcy4KOb
	1pH814QEMh6iYnZ00yLqLl/3s9JVX3XCcszLQOQoqCj7PDnEGmnn7lxmwe0fh/F7Px4clHwrzAHYh
	ZY1eiwhQWHddcZHH552g1byeXxBLTWUGG+C3Okf5I+HnIk1JJtAtvfq+870L277g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNBH-0000000AGkC-3hos;
	Wed, 12 Jun 2024 14:34:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 4/4] wifi: mac80211: update STA/chandef width during switch
Date: Wed, 12 Jun 2024 14:32:06 +0200
Message-ID: <20240612143418.0bc3d28231b3.I51e76df86212057ca0469e235ba9bf4461cbee75@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123418.37295-6-johannes@sipsolutions.net>
References: <20240612123418.37295-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In channel switch without an additional channel context,
where the reassign logic kicks in, we also need to update
the station bandwidth and chandef minimum width correctly
to avoid having station rate control configured to wider
bandwidth than the channel context. Do that now.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 67 +++++++++++++++++++++++++++++---------
 net/mac80211/ieee80211_i.h |  3 +-
 net/mac80211/util.c        |  2 +-
 3 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a42ab3179d99..942c882f1a1d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -295,17 +295,24 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 static enum nl80211_chan_width
 ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
-				      struct ieee80211_link_data *rsvd_for)
+				      struct ieee80211_link_data *rsvd_for,
+				      bool check_reserved)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_link_data *link;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 
+	if (WARN_ON(check_reserved && rsvd_for))
+		return ctx->conf.def.width;
+
 	for_each_sdata_link(local, link) {
 		enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20_NOHT;
 
-		if (link != rsvd_for &&
-		    rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
+		if (check_reserved) {
+			if (link->reserved_chanctx != ctx)
+				continue;
+		} else if (link != rsvd_for &&
+			   rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
 			continue;
 
 		switch (link->sdata->vif.type) {
@@ -359,7 +366,8 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 static u32
 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				  struct ieee80211_chanctx *ctx,
-				  struct ieee80211_link_data *rsvd_for)
+				  struct ieee80211_link_data *rsvd_for,
+				  bool check_reserved)
 {
 	enum nl80211_chan_width max_bw;
 	struct cfg80211_chan_def min_def;
@@ -379,7 +387,8 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 		return 0;
 	}
 
-	max_bw = ieee80211_get_chanctx_max_required_bw(local, ctx, rsvd_for);
+	max_bw = ieee80211_get_chanctx_max_required_bw(local, ctx, rsvd_for,
+						       check_reserved);
 
 	/* downgrade chandef up to max_bw */
 	min_def = ctx->conf.def;
@@ -465,9 +474,11 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
  */
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
-				      struct ieee80211_link_data *rsvd_for)
+				      struct ieee80211_link_data *rsvd_for,
+				      bool check_reserved)
 {
-	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
+	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
+							check_reserved);
 
 	if (!changed)
 		return;
@@ -515,7 +526,7 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, old_ctx, false, true);
 
 	if (ieee80211_chanreq_identical(&ctx_req, chanreq)) {
-		ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
+		ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for, false);
 		return;
 	}
 
@@ -536,7 +547,7 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	ctx->conf.ap = chanreq->ap;
 
 	/* check if min chanctx also changed */
-	changed |= _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
+	changed |= _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for, false);
 
 	ieee80211_add_wbrf(local, &ctx->conf.def);
 
@@ -663,7 +674,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
-	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
+	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 
 	return ctx;
 }
@@ -845,7 +856,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 
 	if (new_ctx) {
 		/* recalc considering the link we'll use it for now */
-		ieee80211_recalc_chanctx_min_def(local, new_ctx, link);
+		ieee80211_recalc_chanctx_min_def(local, new_ctx, link, false);
 
 		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
 		if (assign_on_failure || !ret) {
@@ -868,12 +879,12 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_chantype(local, curr_ctx);
 		ieee80211_recalc_smps_chanctx(local, curr_ctx);
 		ieee80211_recalc_radar_chanctx(local, curr_ctx);
-		ieee80211_recalc_chanctx_min_def(local, curr_ctx, NULL);
+		ieee80211_recalc_chanctx_min_def(local, curr_ctx, NULL, false);
 	}
 
 	if (new_ctx && ieee80211_chanctx_num_assigned(local, new_ctx) > 0) {
 		ieee80211_recalc_txpower(sdata, false);
-		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
+		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL, false);
 	}
 
 	if (conf) {
@@ -1286,7 +1297,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
 		ieee80211_free_chanctx(local, old_ctx, false);
 
-	ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
+	ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL, false);
 	ieee80211_recalc_smps_chanctx(local, new_ctx);
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
 
@@ -1552,6 +1563,31 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		goto err;
 	}
 
+	/* update station rate control and min width before switch */
+	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		struct ieee80211_link_data *link;
+
+		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
+			continue;
+
+		if (WARN_ON(!ctx->replace_ctx)) {
+			err = -EINVAL;
+			goto err;
+		}
+
+		list_for_each_entry(link, &ctx->reserved_links,
+				    reserved_chanctx_list) {
+			if (!ieee80211_link_has_in_place_reservation(link))
+				continue;
+
+			ieee80211_chan_bw_change(local,
+						 ieee80211_link_get_chanctx(link),
+						 true, true);
+		}
+
+		ieee80211_recalc_chanctx_min_def(local, ctx, NULL, true);
+	}
+
 	/*
 	 * All necessary vifs are ready. Perform the switch now depending on
 	 * reservations and driver capabilities.
@@ -1619,7 +1655,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_chanctx_chantype(local, ctx);
 		ieee80211_recalc_smps_chanctx(local, ctx);
 		ieee80211_recalc_radar_chanctx(local, ctx);
-		ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
+		ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 
 		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
 					 reserved_chanctx_list) {
@@ -1632,6 +1668,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			link->reserved_chanctx = NULL;
 
 			ieee80211_link_chanctx_reservation_complete(link);
+			ieee80211_chan_bw_change(local, ctx, false, false);
 		}
 
 		/*
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8318a729d90f..78a898fd3e3a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2619,7 +2619,8 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *chanctx);
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
-				      struct ieee80211_link_data *rsvd_for);
+				      struct ieee80211_link_data *rsvd_for,
+				      bool check_reserved);
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c73ff7dfbdba..b3b8873a107b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2334,7 +2334,7 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 
 		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
 				       conf);
-		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL);
+		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL, false);
 	}
 }
 
-- 
2.45.2


