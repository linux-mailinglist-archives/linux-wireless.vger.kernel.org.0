Return-Path: <linux-wireless+bounces-28620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824AC3645F
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E1C6244D0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257232E6B6;
	Wed,  5 Nov 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RaPzJWK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E532E155
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355081; cv=none; b=HT67VHQ+4iIDt9zxPlc0B7b0DUETTwY8rwGl4VmSimtp8hQksnHzTRO5af6eUE+n0U28BfPayhuJM8KaL4luWW7iNV2ZBo1k+W2T3pKbs9xgsiLEllGJT4TObTYU3H50uaTg8l25b812SL+0Mzcqkq96yX21hf+WJtILGwh7n4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355081; c=relaxed/simple;
	bh=vqSEBtK2yFrruak8MiQg0eXxiUohw93FMoM1X3LcKh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOskpsj16eutvbXmFPfppzXVB3+++g8npChvvvp3K0q+ksza7TZGT/U+ypXG0O9IAPRsHY8Q+IHDV4J+2O28xF6wl+TLYO3ZsdCxbYHh6ZNsrLCvRpLGZBJ7l8UGrYijGLnPIFCcimHZ0sl5I+auK56GTUQyMUmpCYdStlBFNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RaPzJWK8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Tj1m6xr72Qe8ILEkpD9jjpWAanzBLQ31nmTiYMVxDek=;
	t=1762355079; x=1763564679; b=RaPzJWK8kjG1tGwutOU8D3gSiuX3dwLbBvh2B0G748kovZW
	3wSkSDPZywTPDVNgAEuYW726Jio6owvngwPk0B+3jI6AyBE2PGANGTXQ6fHORza8Rf2FKHCAHqG7A
	lnzhLxRG5jTzs7UzXhr9KGrVqgjwNj67ZuzLyvXngzyHF9nmiJmONP8BmmokboZv0+bBpwxzPL7Zm
	zlWYr8MdEhyFVXt9WzT2W3TL1hUh2iS57n5WxjNn9EEfmJMyisPjefEY/eGRZVLM5aNCjpaeSs0/Z
	40/XURfqwAUiB/6aMowLo11CeOoIIAHP4ZlNdeoRvhgcc2i91zyfCq6pHtJrC3Ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf3s-0000000FGVb-2AA8;
	Wed, 05 Nov 2025 16:04:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/4] wifi: mac80211: remove chanctx to link back-references
Date: Wed,  5 Nov 2025 16:03:43 +0100
Message-ID: <20251105160431.dbeea1c42e76.I8d273c407274e1c05a4778aa20b56a9f326e87a7@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105150431.49595-6-johannes@sipsolutions.net>
References: <20251105150431.49595-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Each link can currently use a chanctx and have another one
reserved, and both of these are also tracked backwards in
the assigned_links and reserved_links lists. If we consider
that there aren't *that* many links, this duplicate book-
keeping isn't necessary.
(I think it used to be necessary before the wiphy locking
changes, when chanctx_mtx existed, because we couldn't do
any interface iterations while holding only chanctx_mtx.)

Additionally, for NAN, we're going to want to track which
chanctxs are in use by the (group of) NAN interfaces. For
those, links don't really make sense as such, so chanctxs
need to be assigned to a different data structure.

Thus, as a first step, remove those back-lists of users
(right now only links) of each channel context. This is a
very basic conversion, ieee80211_vif_use_reserved_switch()
should made to iterate smarter.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 127 +++++++++++++++++++++----------------
 net/mac80211/ieee80211_i.h |   6 --
 net/mac80211/link.c        |   2 -
 net/mac80211/util.c        |  32 +++++-----
 4 files changed, 88 insertions(+), 79 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 57065714cf8c..b73b5a0f6e60 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -20,8 +20,10 @@ static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list)
-		num++;
+	for_each_sdata_link(local, link) {
+		if (rcu_access_pointer(link->conf->chanctx_conf) == &ctx->conf)
+			num++;
+	}
 
 	return num;
 }
@@ -34,8 +36,10 @@ static int ieee80211_chanctx_num_reserved(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list)
-		num++;
+	for_each_sdata_link(local, link) {
+		if (link->reserved_chanctx == ctx)
+			num++;
+	}
 
 	return num;
 }
@@ -43,8 +47,19 @@ static int ieee80211_chanctx_num_reserved(struct ieee80211_local *local,
 int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 			       struct ieee80211_chanctx *ctx)
 {
-	return ieee80211_chanctx_num_assigned(local, ctx) +
-	       ieee80211_chanctx_num_reserved(local, ctx);
+	struct ieee80211_link_data *link;
+	int num = 0;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	for_each_sdata_link(local, link) {
+		if (rcu_access_pointer(link->conf->chanctx_conf) == &ctx->conf)
+			num++;
+		if (link->reserved_chanctx == ctx)
+			num++;
+	}
+
+	return num;
 }
 
 static int ieee80211_num_chanctx(struct ieee80211_local *local, int radio_idx)
@@ -150,7 +165,10 @@ ieee80211_chanctx_reserved_chanreq(struct ieee80211_local *local,
 	if (WARN_ON(!req))
 		return NULL;
 
-	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list) {
+	for_each_sdata_link(local, link) {
+		if (link->reserved_chanctx != ctx)
+			continue;
+
 		req = ieee80211_chanreq_compatible(&link->reserved, req, tmp);
 		if (!req)
 			break;
@@ -170,9 +188,12 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list) {
+	for_each_sdata_link(local, link) {
 		struct ieee80211_bss_conf *link_conf = link->conf;
 
+		if (rcu_access_pointer(link_conf->chanctx_conf) != &ctx->conf)
+			continue;
+
 		if (link->reserved_chanctx)
 			continue;
 
@@ -200,7 +221,7 @@ ieee80211_chanctx_can_reserve(struct ieee80211_local *local,
 	if (!ieee80211_chanctx_non_reserved_chandef(local, ctx, req, &tmp))
 		return false;
 
-	if (!list_empty(&ctx->reserved_links) &&
+	if (ieee80211_chanctx_num_reserved(local, ctx) != 0 &&
 	    ieee80211_chanctx_reserved_chanreq(local, ctx, req, &tmp))
 		return true;
 
@@ -633,8 +654,6 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 		 * context to actually be removed.
 		 */
 		link->reserved_chanctx = ctx;
-		list_add(&link->reserved_chanctx_list,
-			 &ctx->reserved_links);
 
 		ieee80211_change_chanctx(local, ctx, ctx, compat);
 
@@ -705,8 +724,6 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	if (!ctx)
 		return NULL;
 
-	INIT_LIST_HEAD(&ctx->assigned_links);
-	INIT_LIST_HEAD(&ctx->reserved_links);
 	ctx->conf.def = chanreq->oper;
 	ctx->conf.ap = chanreq->ap;
 	ctx->conf.rx_chains_static = 1;
@@ -904,7 +921,6 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 
 		drv_unassign_vif_chanctx(local, sdata, link->conf, curr_ctx);
 		conf = NULL;
-		list_del(&link->assigned_chanctx_list);
 	}
 
 	if (new_ctx) {
@@ -919,9 +935,6 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 
 			/* succeeded, so commit it to the data structures */
 			conf = &new_ctx->conf;
-			if (!local->in_reconfig)
-				list_add(&link->assigned_chanctx_list,
-					 &new_ctx->assigned_links);
 		}
 	} else {
 		ret = 0;
@@ -1108,7 +1121,6 @@ void ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 	if (WARN_ON(!ctx))
 		return;
 
-	list_del(&link->reserved_chanctx_list);
 	link->reserved_chanctx = NULL;
 
 	if (ieee80211_chanctx_refcount(sdata->local, ctx) == 0) {
@@ -1142,9 +1154,9 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 	struct wiphy *wiphy = local->hw.wiphy;
 	const struct wiphy_radio *radio;
 
-	if (!curr_ctx || (curr_ctx->replace_state ==
-			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
-	    !list_empty(&curr_ctx->reserved_links)) {
+	if (!curr_ctx ||
+	    curr_ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED ||
+	    ieee80211_chanctx_num_reserved(local, curr_ctx) != 0) {
 		/*
 		 * Another link already requested this context for a
 		 * reservation. Find another one hoping all links assigned
@@ -1167,7 +1179,7 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 			    IEEE80211_CHANCTX_REPLACE_NONE)
 				continue;
 
-			if (!list_empty(&ctx->reserved_links))
+			if (ieee80211_chanctx_num_reserved(local, ctx) != 0)
 				continue;
 
 			if (ctx->conf.radio_idx >= 0) {
@@ -1185,9 +1197,9 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 	 * If that's true then all available contexts already have reservations
 	 * and cannot be used.
 	 */
-	if (!curr_ctx || (curr_ctx->replace_state ==
-			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
-	    !list_empty(&curr_ctx->reserved_links))
+	if (!curr_ctx ||
+	    curr_ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED ||
+	    ieee80211_chanctx_num_reserved(local, curr_ctx) != 0)
 		return ERR_PTR(-EBUSY);
 
 	new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
@@ -1267,7 +1279,6 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 			return PTR_ERR(new_ctx);
 	}
 
-	list_add(&link->reserved_chanctx_list, &new_ctx->reserved_links);
 	link->reserved_chanctx = new_ctx;
 	link->reserved = *chanreq;
 	link->reserved_radar_required = radar_required;
@@ -1381,7 +1392,6 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	vif_chsw[0].new_ctx = &new_ctx->conf;
 	vif_chsw[0].link_conf = link->conf;
 
-	list_del(&link->reserved_chanctx_list);
 	link->reserved_chanctx = NULL;
 
 	err = drv_switch_vif_chanctx(local, vif_chsw, 1,
@@ -1394,7 +1404,6 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	}
 
 	link->radar_required = link->reserved_radar_required;
-	list_move(&link->assigned_chanctx_list, &new_ctx->assigned_links);
 	rcu_assign_pointer(link_conf->chanctx_conf, &new_ctx->conf);
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
@@ -1451,7 +1460,6 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 
 	ieee80211_change_chanctx(local, new_ctx, new_ctx, chanreq);
 
-	list_del(&link->reserved_chanctx_list);
 	link->reserved_chanctx = NULL;
 
 	err = ieee80211_assign_link_chanctx(link, new_ctx, false);
@@ -1517,8 +1525,10 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 			goto out;
 		}
 
-		list_for_each_entry(link, &ctx->reserved_links,
-				    reserved_chanctx_list) {
+		for_each_sdata_link(local, link) {
+			if (link->reserved_chanctx != ctx)
+				continue;
+
 			if (!ieee80211_link_has_in_place_reservation(link))
 				continue;
 
@@ -1551,7 +1561,7 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		if (!list_empty(&ctx->replace_ctx->assigned_links))
+		if (ieee80211_chanctx_num_assigned(local, ctx) != 0)
 			continue;
 
 		ieee80211_del_chanctx(local, ctx->replace_ctx, false);
@@ -1568,7 +1578,7 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		if (!list_empty(&ctx->replace_ctx->assigned_links))
+		if (ieee80211_chanctx_num_assigned(local, ctx) != 0)
 			continue;
 
 		ieee80211_del_chanctx(local, ctx, false);
@@ -1619,8 +1629,10 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		n_reserved = 0;
 		n_ready = 0;
 
-		list_for_each_entry(link, &ctx->replace_ctx->assigned_links,
-				    assigned_chanctx_list) {
+		for_each_sdata_link(local, link) {
+			if (rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
+				continue;
+
 			n_assigned++;
 			if (link->reserved_chanctx) {
 				n_reserved++;
@@ -1641,8 +1653,10 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		}
 
 		ctx->conf.radar_enabled = false;
-		list_for_each_entry(link, &ctx->reserved_links,
-				    reserved_chanctx_list) {
+		for_each_sdata_link(local, link) {
+			if (link->reserved_chanctx != ctx)
+				continue;
+
 			if (ieee80211_link_has_in_place_reservation(link) &&
 			    !link->reserved_ready)
 				return -EAGAIN;
@@ -1683,8 +1697,10 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			goto err;
 		}
 
-		list_for_each_entry(link, &ctx->reserved_links,
-				    reserved_chanctx_list) {
+		for_each_sdata_link(local, link) {
+			if (link->reserved_chanctx != ctx)
+				continue;
+
 			if (!ieee80211_link_has_in_place_reservation(link))
 				continue;
 
@@ -1718,7 +1734,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	 * context(s).
 	 */
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		struct ieee80211_link_data *link, *link_tmp;
+		struct ieee80211_link_data *link;
 
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
@@ -1728,12 +1744,14 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			goto err;
 		}
 
-		list_for_each_entry(link, &ctx->reserved_links,
-				    reserved_chanctx_list) {
+		for_each_sdata_link(local, link) {
 			struct ieee80211_sub_if_data *sdata = link->sdata;
 			struct ieee80211_bss_conf *link_conf = link->conf;
 			u64 changed = 0;
 
+			if (link->reserved_chanctx != ctx)
+				continue;
+
 			if (!ieee80211_link_has_in_place_reservation(link))
 				continue;
 
@@ -1765,14 +1783,13 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_radar_chanctx(local, ctx);
 		ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 
-		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
-					 reserved_chanctx_list) {
+		for_each_sdata_link(local, link) {
+			if (link->reserved_chanctx != ctx)
+				continue;
+
 			if (ieee80211_link_get_chanctx(link) != ctx)
 				continue;
 
-			list_del(&link->reserved_chanctx_list);
-			list_move(&link->assigned_chanctx_list,
-				  &ctx->assigned_links);
 			link->reserved_chanctx = NULL;
 
 			ieee80211_link_chanctx_reservation_complete(link);
@@ -1786,12 +1803,11 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		 * reservation for originally requested interface has already
 		 * succeeded at this point.
 		 */
-		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
-					 reserved_chanctx_list) {
-			if (WARN_ON(ieee80211_link_has_in_place_reservation(link)))
+		for_each_sdata_link(local, link) {
+			if (link->reserved_chanctx != ctx)
 				continue;
 
-			if (WARN_ON(link->reserved_chanctx != ctx))
+			if (WARN_ON(ieee80211_link_has_in_place_reservation(link)))
 				continue;
 
 			if (!link->reserved_ready)
@@ -1834,13 +1850,15 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 err:
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		struct ieee80211_link_data *link, *link_tmp;
+		struct ieee80211_link_data *link;
 
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
-					 reserved_chanctx_list) {
+		for_each_sdata_link(local, link) {
+			if (link->reserved_chanctx != ctx)
+				continue;
+
 			ieee80211_link_unreserve_chanctx(link);
 			ieee80211_link_chanctx_reservation_complete(link);
 		}
@@ -1949,7 +1967,6 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 		/* remove reservation */
 		WARN_ON(link->reserved_chanctx != ctx);
 		link->reserved_chanctx = NULL;
-		list_del(&link->reserved_chanctx_list);
 	}
 
 	if (ret) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d8c7abf4bca5..3381e6d6cfd7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -916,9 +916,6 @@ struct ieee80211_chanctx {
 	struct list_head list;
 	struct rcu_head rcu_head;
 
-	struct list_head assigned_links;
-	struct list_head reserved_links;
-
 	enum ieee80211_chanctx_replace_state replace_state;
 	struct ieee80211_chanctx *replace_ctx;
 
@@ -1071,9 +1068,6 @@ struct ieee80211_link_data {
 	struct ieee80211_sub_if_data *sdata;
 	unsigned int link_id;
 
-	struct list_head assigned_chanctx_list; /* protected by wiphy mutex */
-	struct list_head reserved_chanctx_list; /* protected by wiphy mutex */
-
 	/* multicast keys only */
 	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
 					NUM_DEFAULT_MGMT_KEYS +
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d71eabe5abf8..c05d9c6aa8f2 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -119,8 +119,6 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			ieee80211_color_change_finalize_work);
 	wiphy_delayed_work_init(&link->color_collision_detect_work,
 				ieee80211_color_collision_detection_work);
-	INIT_LIST_HEAD(&link->assigned_chanctx_list);
-	INIT_LIST_HEAD(&link->reserved_chanctx_list);
 	wiphy_delayed_work_init(&link->dfs_cac_timer_work,
 				ieee80211_dfs_cac_timer_work);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c9931537f9d2..324d84d11cab 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4016,23 +4016,23 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	if (WARN_ON(ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED))
 		return 0;
 
-	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list)
-		if (link->reserved_radar_required)
+	for_each_sdata_link(local, link) {
+		if (rcu_access_pointer(link->conf->chanctx_conf) == &ctx->conf) {
+			/*
+			 * An in-place reservation context should not have any
+			 * assigned links until it replaces the other context.
+			 */
+			WARN_ON(ctx->replace_state ==
+				IEEE80211_CHANCTX_REPLACES_OTHER);
+
+			if (link->radar_required)
+				radar_detect |=
+					BIT(link->conf->chanreq.oper.width);
+		}
+
+		if (link->reserved_chanctx == ctx &&
+		    link->reserved_radar_required)
 			radar_detect |= BIT(link->reserved.oper.width);
-
-	/*
-	 * An in-place reservation context should not have any assigned vifs
-	 * until it replaces the other context.
-	 */
-	WARN_ON(ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER &&
-		!list_empty(&ctx->assigned_links));
-
-	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list) {
-		if (!link->radar_required)
-			continue;
-
-		radar_detect |=
-			BIT(link->conf->chanreq.oper.width);
 	}
 
 	return radar_detect;
-- 
2.51.1


