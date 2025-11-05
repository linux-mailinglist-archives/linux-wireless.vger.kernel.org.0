Return-Path: <linux-wireless+bounces-28621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E6C36453
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A67C624B50
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B132E13D;
	Wed,  5 Nov 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aQ+5GknP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039032E6B0
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355082; cv=none; b=h5quVwmi2zxR/bm5jUDmlctpCkl3IbLS7r4PjwvIOXe8W3maiVNjkWtKDEmCTjNVpjBQKN5IQdl5S4IN74eT6/j27+62W8MEOSGkMfgEw25mBDCiQHLRykfpzUEU+0J5R7t6lJFTo9Kqwb2oadzKlBTlZwfDCvsbrskt3tZUoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355082; c=relaxed/simple;
	bh=obxQRvFCYw/mA44QlrAIK7BTv5qQrFwRgxwZES/2GZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMheI0Q1i1YGvFytS/MsKMqVKBL7vNFFsceGYIbYG5HL2wU/UOqP4WTDB43zbcuffHznHNmGsA3+VuqUpndjOGlAdk55Z1o7FxCVoHxuLyX3U5Xo6cRottwFVLVwhZFw7yaoroo/4s7vnFI1PaAiFSsXhVcufij07dzfp+pMmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aQ+5GknP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ty9mJt6a7hsQmgBuyzWUKjRMXLkNB2IWeTPx/NqwQ2Q=;
	t=1762355080; x=1763564680; b=aQ+5GknPZr4h448q7L9RcT3vjNaMBN4yFK0LVMza3jdM0Eo
	mHsQ8f+/R+9pklaK4un1ewmv5Bzf/vUFUpkZ+gwgnzlVr93q/o/BfdJ0QrCOZHVpYxByDmYgpXTp5
	NgXcG40ifz/MN+/3AtctMplUC0Ga6TRIA1HUb9cASPDquN+3MIZCpCCGMIHcBkkzVUzdFreYhkSJt
	4GaqnEL4Fb1xhgO2KAXQvCVaPX5tFiob2dkfzELCOQcpohVWkMzdtjuMBMZ5X/F3usxJzBzOfdO4C
	ac9fhnqskxpYyzWDPupSyV7eEuZrTxNylNiyR4/4rSCGgnbt2/iocgGL5641ahDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf3t-0000000FGVb-37JR;
	Wed, 05 Nov 2025 16:04:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 4/4] wifi: mac80211: add and use chanctx usage iteration
Date: Wed,  5 Nov 2025 16:03:45 +0100
Message-ID: <20251105160431.5aaccc2f127d.I2b7fd0858a263916f43abab49c6d3cc0b5aa16ec@changeid>
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

In preparation for NAN interfaces using multiple channel
contexts, add an iterator macro that iterates all users
of a given channel context.

The logic during reserved assign/reassign handling the
bandwidth in ieee80211_get_chanctx_max_required_bw() is
a bit more complicated and should be cleaned up, so it
isn't yet converted.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 342 +++++++++++++++++++++++++-------------------
 1 file changed, 195 insertions(+), 147 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e4f765d1e879..e3081e2fa772 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -12,18 +12,132 @@
 #include "driver-ops.h"
 #include "rate.h"
 
+struct ieee80211_chanctx_user_iter {
+	struct ieee80211_chan_req *chanreq;
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
+	enum nl80211_iftype iftype;
+	bool reserved, radar_required, done;
+	enum {
+		CHANCTX_ITER_POS_ASSIGNED,
+		CHANCTX_ITER_POS_RESERVED,
+		CHANCTX_ITER_POS_DONE,
+	} per_link;
+};
+
+enum ieee80211_chanctx_iter_type {
+	CHANCTX_ITER_ALL,
+	CHANCTX_ITER_RESERVED,
+	CHANCTX_ITER_ASSIGNED,
+};
+
+static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
+					     struct ieee80211_chanctx *ctx,
+					     struct ieee80211_chanctx_user_iter *iter,
+					     enum ieee80211_chanctx_iter_type type,
+					     bool start)
+{
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (start) {
+		memset(iter, 0, sizeof(*iter));
+		goto next_interface;
+	}
+
+next_link:
+	for (int link_id = iter->link ? iter->link->link_id : 0;
+	     link_id < ARRAY_SIZE(iter->sdata->link);
+	     link_id++) {
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(iter->sdata->link[link_id],
+					 iter->sdata);
+		if (!link)
+			continue;
+
+		switch (iter->per_link) {
+		case CHANCTX_ITER_POS_ASSIGNED:
+			iter->per_link = CHANCTX_ITER_POS_RESERVED;
+			if (type != CHANCTX_ITER_RESERVED &&
+			    rcu_access_pointer(link->conf->chanctx_conf) == &ctx->conf) {
+				iter->link = link;
+				iter->reserved = false;
+				iter->radar_required = link->radar_required;
+				iter->chanreq = &link->conf->chanreq;
+				return;
+			}
+			fallthrough;
+		case CHANCTX_ITER_POS_RESERVED:
+			iter->per_link = CHANCTX_ITER_POS_DONE;
+			if (type != CHANCTX_ITER_ASSIGNED &&
+			    link->reserved_chanctx == ctx) {
+				iter->link = link;
+				iter->reserved = true;
+				iter->radar_required =
+					link->reserved_radar_required;
+
+				iter->chanreq = &link->reserved;
+				return;
+			}
+			fallthrough;
+		case CHANCTX_ITER_POS_DONE:
+			iter->per_link = CHANCTX_ITER_POS_ASSIGNED;
+			continue;
+		}
+	}
+
+next_interface:
+	/* next (or first) interface */
+	iter->sdata = list_prepare_entry(iter->sdata, &local->interfaces, list);
+	list_for_each_entry_continue(iter->sdata, &local->interfaces, list) {
+		/* AP_VLAN has a chanctx pointer but follows AP */
+		if (iter->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+			continue;
+
+		iter->link = NULL;
+		iter->per_link = CHANCTX_ITER_POS_ASSIGNED;
+		iter->iftype = iter->sdata->vif.type;
+		goto next_link;
+	}
+
+	iter->done = true;
+}
+
+#define for_each_chanctx_user_assigned(local, ctx, iter)		\
+	for (ieee80211_chanctx_user_iter_next(local, ctx, iter,		\
+					      CHANCTX_ITER_ASSIGNED,	\
+					      true);			\
+	     !((iter)->done);						\
+	     ieee80211_chanctx_user_iter_next(local, ctx, iter,		\
+					      CHANCTX_ITER_ASSIGNED,	\
+					      false))
+
+#define for_each_chanctx_user_reserved(local, ctx, iter)		\
+	for (ieee80211_chanctx_user_iter_next(local, ctx, iter,		\
+					      CHANCTX_ITER_RESERVED,	\
+					      true);			\
+	     !((iter)->done);						\
+	     ieee80211_chanctx_user_iter_next(local, ctx, iter,		\
+					      CHANCTX_ITER_RESERVED,	\
+					      false))
+
+#define for_each_chanctx_user_all(local, ctx, iter)			\
+	for (ieee80211_chanctx_user_iter_next(local, ctx, iter,		\
+					      CHANCTX_ITER_ALL,		\
+					      true);			\
+	     !((iter)->done);						\
+	     ieee80211_chanctx_user_iter_next(local, ctx, iter,		\
+					      CHANCTX_ITER_ALL,		\
+					      false))
+
 static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
 					  struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_link_data *link;
+	struct ieee80211_chanctx_user_iter iter;
 	int num = 0;
 
-	lockdep_assert_wiphy(local->hw.wiphy);
-
-	for_each_sdata_link(local, link) {
-		if (rcu_access_pointer(link->conf->chanctx_conf) == &ctx->conf)
-			num++;
-	}
+	for_each_chanctx_user_assigned(local, ctx, &iter)
+		num++;
 
 	return num;
 }
@@ -31,15 +145,11 @@ static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
 static int ieee80211_chanctx_num_reserved(struct ieee80211_local *local,
 					  struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_link_data *link;
+	struct ieee80211_chanctx_user_iter iter;
 	int num = 0;
 
-	lockdep_assert_wiphy(local->hw.wiphy);
-
-	for_each_sdata_link(local, link) {
-		if (link->reserved_chanctx == ctx)
-			num++;
-	}
+	for_each_chanctx_user_reserved(local, ctx, &iter)
+		num++;
 
 	return num;
 }
@@ -47,17 +157,11 @@ static int ieee80211_chanctx_num_reserved(struct ieee80211_local *local,
 int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 			       struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_link_data *link;
+	struct ieee80211_chanctx_user_iter iter;
 	int num = 0;
 
-	lockdep_assert_wiphy(local->hw.wiphy);
-
-	for_each_sdata_link(local, link) {
-		if (rcu_access_pointer(link->conf->chanctx_conf) == &ctx->conf)
-			num++;
-		if (link->reserved_chanctx == ctx)
-			num++;
-	}
+	for_each_chanctx_user_all(local, ctx, &iter)
+		num++;
 
 	return num;
 }
@@ -158,18 +262,15 @@ ieee80211_chanctx_reserved_chanreq(struct ieee80211_local *local,
 				   const struct ieee80211_chan_req *req,
 				   struct ieee80211_chan_req *tmp)
 {
-	struct ieee80211_link_data *link;
+	struct ieee80211_chanctx_user_iter iter;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(!req))
 		return NULL;
 
-	for_each_sdata_link(local, link) {
-		if (link->reserved_chanctx != ctx)
-			continue;
-
-		req = ieee80211_chanreq_compatible(&link->reserved, req, tmp);
+	for_each_chanctx_user_reserved(local, ctx, &iter) {
+		req = ieee80211_chanreq_compatible(iter.chanreq, req, tmp);
 		if (!req)
 			break;
 	}
@@ -183,21 +284,16 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 				       const struct ieee80211_chan_req *compat,
 				       struct ieee80211_chan_req *tmp)
 {
-	struct ieee80211_link_data *link;
 	const struct ieee80211_chan_req *comp_def = compat;
+	struct ieee80211_chanctx_user_iter iter;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	for_each_sdata_link(local, link) {
-		struct ieee80211_bss_conf *link_conf = link->conf;
-
-		if (rcu_access_pointer(link_conf->chanctx_conf) != &ctx->conf)
+	for_each_chanctx_user_assigned(local, ctx, &iter) {
+		if (iter.link->reserved_chanctx)
 			continue;
 
-		if (link->reserved_chanctx)
-			continue;
-
-		comp_def = ieee80211_chanreq_compatible(&link_conf->chanreq,
+		comp_def = ieee80211_chanreq_compatible(iter.chanreq,
 							comp_def, tmp);
 		if (!comp_def)
 			break;
@@ -702,17 +798,13 @@ static bool
 ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 				 struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_chanctx_conf *conf = &ctx->conf;
-	struct ieee80211_link_data *link;
+	struct ieee80211_chanctx_user_iter iter;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	for_each_sdata_link(local, link) {
-		if (rcu_access_pointer(link->conf->chanctx_conf) != conf)
-			continue;
-		if (!link->radar_required)
-			continue;
-		return true;
+	for_each_chanctx_user_assigned(local, ctx, &iter) {
+		if (iter.radar_required)
+			return true;
 	}
 
 	return false;
@@ -829,27 +921,17 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 {
 	struct ieee80211_chanctx_conf *conf = &ctx->conf;
 	const struct ieee80211_chan_req *compat = NULL;
-	struct ieee80211_link_data *link;
+	struct ieee80211_chanctx_user_iter iter;
 	struct ieee80211_chan_req tmp;
 	struct sta_info *sta;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	for_each_sdata_link(local, link) {
-		struct ieee80211_bss_conf *link_conf;
-
-		if (link->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
-			continue;
-
-		link_conf = link->conf;
-
-		if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
-			continue;
-
+	for_each_chanctx_user_assigned(local, ctx, &iter) {
 		if (!compat)
-			compat = &link_conf->chanreq;
+			compat = iter.chanreq;
 
-		compat = ieee80211_chanreq_compatible(&link_conf->chanreq,
+		compat = ieee80211_chanreq_compatible(iter.chanreq,
 						      compat, &tmp);
 		if (WARN_ON_ONCE(!compat))
 			return;
@@ -862,6 +944,7 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 	list_for_each_entry(sta, &local->sta_list, list) {
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
 		struct ieee80211_chan_req tdls_chanreq = {};
+		struct ieee80211_link_data *link;
 		int tdls_link_id;
 
 		if (!sta->uploaded ||
@@ -992,21 +1075,21 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *chanctx)
 {
+	struct ieee80211_chanctx_user_iter iter;
 	struct ieee80211_sub_if_data *sdata;
 	u8 rx_chains_static, rx_chains_dynamic;
-	struct ieee80211_link_data *link;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rx_chains_static = 1;
 	rx_chains_dynamic = 1;
 
-	for_each_sdata_link(local, link) {
+	for_each_chanctx_user_assigned(local, chanctx, &iter) {
 		u8 needed_static, needed_dynamic;
 
-		switch (link->sdata->vif.type) {
+		switch (iter.iftype) {
 		case NL80211_IFTYPE_STATION:
-			if (!link->sdata->u.mgd.associated)
+			if (!iter.sdata->u.mgd.associated)
 				continue;
 			break;
 		case NL80211_IFTYPE_MONITOR:
@@ -1022,26 +1105,23 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 			continue;
 		}
 
-		if (rcu_access_pointer(link->conf->chanctx_conf) != &chanctx->conf)
-			continue;
-
-		if (link->sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+		if (iter.iftype == NL80211_IFTYPE_MONITOR) {
 			rx_chains_dynamic = rx_chains_static = local->rx_chains;
 			break;
 		}
 
-		switch (link->smps_mode) {
+		switch (iter.link->smps_mode) {
 		default:
 			WARN_ONCE(1, "Invalid SMPS mode %d\n",
-				  link->smps_mode);
+				  iter.link->smps_mode);
 			fallthrough;
 		case IEEE80211_SMPS_OFF:
-			needed_static = link->needed_rx_chains;
-			needed_dynamic = link->needed_rx_chains;
+			needed_static = iter.link->needed_rx_chains;
+			needed_dynamic = iter.link->needed_rx_chains;
 			break;
 		case IEEE80211_SMPS_DYNAMIC:
 			needed_static = 1;
-			needed_dynamic = link->needed_rx_chains;
+			needed_dynamic = iter.link->needed_rx_chains;
 			break;
 		case IEEE80211_SMPS_STATIC:
 			needed_static = 1;
@@ -1513,7 +1593,6 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 				      int n_vifs)
 {
 	struct ieee80211_vif_chanctx_switch *vif_chsw;
-	struct ieee80211_link_data *link;
 	struct ieee80211_chanctx *ctx, *old_ctx;
 	int i, err;
 
@@ -1525,6 +1604,8 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 
 	i = 0;
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		struct ieee80211_chanctx_user_iter iter;
+
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
@@ -1533,18 +1614,15 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 			goto out;
 		}
 
-		for_each_sdata_link(local, link) {
-			if (link->reserved_chanctx != ctx)
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			if (!ieee80211_link_has_in_place_reservation(iter.link))
 				continue;
 
-			if (!ieee80211_link_has_in_place_reservation(link))
-				continue;
-
-			old_ctx = ieee80211_link_get_chanctx(link);
-			vif_chsw[i].vif = &link->sdata->vif;
+			old_ctx = ieee80211_link_get_chanctx(iter.link);
+			vif_chsw[i].vif = &iter.sdata->vif;
 			vif_chsw[i].old_ctx = &old_ctx->conf;
 			vif_chsw[i].new_ctx = &ctx->conf;
-			vif_chsw[i].link_conf = link->conf;
+			vif_chsw[i].link_conf = iter.link->conf;
 
 			i++;
 		}
@@ -1621,7 +1699,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	 */
 
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		struct ieee80211_link_data *link;
+		struct ieee80211_chanctx_user_iter iter;
 
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
@@ -1637,14 +1715,11 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		n_reserved = 0;
 		n_ready = 0;
 
-		for_each_sdata_link(local, link) {
-			if (rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
-				continue;
-
+		for_each_chanctx_user_assigned(local, ctx, &iter) {
 			n_assigned++;
-			if (link->reserved_chanctx) {
+			if (iter.link->reserved_chanctx) {
 				n_reserved++;
-				if (link->reserved_ready)
+				if (iter.link->reserved_ready)
 					n_ready++;
 			}
 		}
@@ -1661,15 +1736,12 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		}
 
 		ctx->conf.radar_enabled = false;
-		for_each_sdata_link(local, link) {
-			if (link->reserved_chanctx != ctx)
-				continue;
-
-			if (ieee80211_link_has_in_place_reservation(link) &&
-			    !link->reserved_ready)
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			if (ieee80211_link_has_in_place_reservation(iter.link) &&
+			    !iter.link->reserved_ready)
 				return -EAGAIN;
 
-			old_ctx = ieee80211_link_get_chanctx(link);
+			old_ctx = ieee80211_link_get_chanctx(iter.link);
 			if (old_ctx) {
 				if (old_ctx->replace_state ==
 				    IEEE80211_CHANCTX_WILL_BE_REPLACED)
@@ -1680,7 +1752,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				n_vifs_ctxless++;
 			}
 
-			if (link->reserved_radar_required)
+			if (iter.radar_required)
 				ctx->conf.radar_enabled = true;
 		}
 	}
@@ -1695,7 +1767,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 	/* update station rate control and min width before switch */
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		struct ieee80211_link_data *link;
+		struct ieee80211_chanctx_user_iter iter;
 
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
@@ -1705,15 +1777,12 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			goto err;
 		}
 
-		for_each_sdata_link(local, link) {
-			if (link->reserved_chanctx != ctx)
-				continue;
-
-			if (!ieee80211_link_has_in_place_reservation(link))
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			if (!ieee80211_link_has_in_place_reservation(iter.link))
 				continue;
 
 			ieee80211_chan_bw_change(local,
-						 ieee80211_link_get_chanctx(link),
+						 ieee80211_link_get_chanctx(iter.link),
 						 true, true);
 		}
 
@@ -1742,7 +1811,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	 * context(s).
 	 */
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		struct ieee80211_link_data *link;
+		struct ieee80211_chanctx_user_iter iter;
 
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
@@ -1752,14 +1821,12 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			goto err;
 		}
 
-		for_each_sdata_link(local, link) {
-			struct ieee80211_sub_if_data *sdata = link->sdata;
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			struct ieee80211_link_data *link = iter.link;
+			struct ieee80211_sub_if_data *sdata = iter.sdata;
 			struct ieee80211_bss_conf *link_conf = link->conf;
 			u64 changed = 0;
 
-			if (link->reserved_chanctx != ctx)
-				continue;
-
 			if (!ieee80211_link_has_in_place_reservation(link))
 				continue;
 
@@ -1772,9 +1839,9 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 			ieee80211_check_fast_xmit_iface(sdata);
 
-			link->radar_required = link->reserved_radar_required;
+			link->radar_required = iter.radar_required;
 
-			if (link_conf->chanreq.oper.width != link->reserved.oper.width)
+			if (link_conf->chanreq.oper.width != iter.chanreq->oper.width)
 				changed = BSS_CHANGED_BANDWIDTH;
 
 			ieee80211_link_update_chanreq(link, &link->reserved);
@@ -1791,16 +1858,13 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_radar_chanctx(local, ctx);
 		ieee80211_recalc_chanctx_min_def(local, ctx);
 
-		for_each_sdata_link(local, link) {
-			if (link->reserved_chanctx != ctx)
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			if (ieee80211_link_get_chanctx(iter.link) != ctx)
 				continue;
 
-			if (ieee80211_link_get_chanctx(link) != ctx)
-				continue;
+			iter.link->reserved_chanctx = NULL;
 
-			link->reserved_chanctx = NULL;
-
-			ieee80211_link_chanctx_reservation_complete(link);
+			ieee80211_link_chanctx_reservation_complete(iter.link);
 			ieee80211_chan_bw_change(local, ctx, false, false);
 		}
 
@@ -1811,9 +1875,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		 * reservation for originally requested interface has already
 		 * succeeded at this point.
 		 */
-		for_each_sdata_link(local, link) {
-			if (link->reserved_chanctx != ctx)
-				continue;
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			struct ieee80211_link_data *link = iter.link;
 
 			if (WARN_ON(ieee80211_link_has_in_place_reservation(link)))
 				continue;
@@ -1858,17 +1921,14 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 err:
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		struct ieee80211_link_data *link;
+		struct ieee80211_chanctx_user_iter iter;
 
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		for_each_sdata_link(local, link) {
-			if (link->reserved_chanctx != ctx)
-				continue;
-
-			ieee80211_link_unreserve_chanctx(link);
-			ieee80211_link_chanctx_reservation_complete(link);
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			ieee80211_link_unreserve_chanctx(iter.link);
+			ieee80211_link_chanctx_reservation_complete(iter.link);
 		}
 	}
 
@@ -2071,29 +2131,17 @@ ieee80211_chanctx_recheck(struct ieee80211_local *local,
 			  struct ieee80211_chan_req *tmp)
 {
 	const struct ieee80211_chan_req *ret = req;
-	struct ieee80211_link_data *link;
+	struct ieee80211_chanctx_user_iter iter;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	for_each_sdata_link(local, link) {
-		if (link == skip_link)
+	for_each_chanctx_user_all(local, ctx, &iter) {
+		if (iter.link == skip_link)
 			continue;
 
-		if (rcu_access_pointer(link->conf->chanctx_conf) == &ctx->conf) {
-			ret = ieee80211_chanreq_compatible(ret,
-							   &link->conf->chanreq,
-							   tmp);
-			if (!ret)
-				return NULL;
-		}
-
-		if (link->reserved_chanctx == ctx) {
-			ret = ieee80211_chanreq_compatible(ret,
-							   &link->reserved,
-							   tmp);
-			if (!ret)
-				return NULL;
-		}
+		ret = ieee80211_chanreq_compatible(ret, iter.chanreq, tmp);
+		if (!ret)
+			return NULL;
 	}
 
 	*tmp = *ret;
-- 
2.51.1


