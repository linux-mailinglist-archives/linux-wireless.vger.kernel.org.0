Return-Path: <linux-wireless+bounces-2681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A05F8412A0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A343B285EA1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E04159562;
	Mon, 29 Jan 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R145/60Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11017158D71
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553682; cv=none; b=Y7JYwK6ICfKswPKUgurqnbIT/uOcGkJW+uNPkVP2jCChEBizwMIP9wsJztmdrN5SqUBUthjWLVJVq/UIQL5qM8SiY/K0ISTRt3GsT1NdvlMFZh6hUrBMj8D4znp/K33HZTZnJh9az/yvYqCRKdlRCKRi48nybOwxcyR1kXy2R8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553682; c=relaxed/simple;
	bh=Cpy7rTg0y2841ylg5IxiyzAPHRF20MN6MMa5KFfOQJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbDUmYHXh4zLl3Rv37ApEKGlDKSO30jWTu+RCoxNi1todLbCmeimc694O392IBeQ2c+he8i3Qp6lplIlgkPXQgspKI4KPHQJMpMeJfLs9WdeVMC7w90Lc9uU6JWpKco1bQi393umnaNpj5YU0TFvvjUK7ES2ZnOxVjxWSq55KBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R145/60Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1eOzMZJxO6atKQDRDaQ09jzEGVrQTod8+bLsV56fcDI=;
	t=1706553679; x=1707763279; b=R145/60Z5tLvL0jsjXkQxiwvkoUYY4PDG3b2RiSoPAEDbXy
	yPhFNzZpStSoyo0jkjz5yc8qsfbU7zrU0sTLRqSdhd6LI/KR4ZDQ5oNrfhfA2yq2oCuVzoKybHF8X
	fgwVdO/WbEDs5eBpTwvIQBpbPgTIQ9WlL1KbZ3ANGYMl/ZUz5DN1xaRalFaYYen5lqdJHrPsWDVvb
	3p4AAtkhjTGvQipQJvyTD7ozSwAVRyw1ik2vpEb69VC1heKw8bKKJMcuG4iHVGd70U8jnqg+IhYwq
	FAnR8BMSa4tIP6jbktTcKM4HqEaIyx15NIqTCqJgGZ7s5n0DlVSCzdD5oJzW6cpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZI-00000004z9N-376s;
	Mon, 29 Jan 2024 19:41:16 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] wifi: mac80211: add and use a link iteration macro
Date: Mon, 29 Jan 2024 19:34:41 +0100
Message-ID: <20240129194108.7240829bd96d.I5ccbb8dd019cbcb5326c85d76121359225d6541a@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the channel context code we have quite a few instances
of nested loops iterating the interfaces and then links.
Add a new for_each_sdata_link() macro and use it. Also,
since it's easier, convert all the loops and a few other
places away from RCU as we now hold the wiphy mutex
everywhere anyway.

This does cause a little bit more work (such as checking
interface types for each link of an interface rather than
not iterating links in some cases), but that's not a huge
issue and seems like an acceptable trade-off, readability
is important too.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 246 ++++++++++++-------------------------
 net/mac80211/ieee80211_i.h |  13 ++
 2 files changed, 89 insertions(+), 170 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index f1cef332e4db..c84449bdc928 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -211,7 +211,7 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta,
 	enum ieee80211_sta_rx_bandwidth width;
 	struct link_sta_info *link_sta;
 
-	link_sta = rcu_dereference(sta->link[link_id]);
+	link_sta = wiphy_dereference(sta->local->hw.wiphy, sta->link[link_id]);
 
 	/* no effect if this STA has no presence on this link */
 	if (!link_sta)
@@ -249,9 +249,10 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta,
 }
 
 static enum nl80211_chan_width
-ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
-			      unsigned int link_id)
+ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
 
@@ -267,31 +268,25 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
 }
 
 static enum nl80211_chan_width
-ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
-					  struct ieee80211_chanctx *ctx,
-					  struct ieee80211_link_data *rsvd_for)
+ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for)
 {
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
-	struct ieee80211_vif *vif = &sdata->vif;
-	int link_id;
 
-	rcu_read_lock();
-	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+	for_each_sdata_link(local, link) {
 		enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20_NOHT;
-		struct ieee80211_link_data *link =
-			rcu_dereference(sdata->link[link_id]);
-
-		if (!link)
-			continue;
 
 		if (link != rsvd_for &&
 		    rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
 			continue;
 
-		switch (vif->type) {
+		switch (link->sdata->vif.type) {
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_AP_VLAN:
-			width = ieee80211_get_max_required_bw(sdata, link_id);
+			width = ieee80211_get_max_required_bw(link);
 			break;
 		case NL80211_IFTYPE_STATION:
 			/*
@@ -300,7 +295,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 			 * account also for TDLS peers
 			 */
 			width = max(link->conf->chanreq.oper.width,
-				    ieee80211_get_max_required_bw(sdata, link_id));
+				    ieee80211_get_max_required_bw(link));
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
@@ -321,40 +316,13 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 
 		max_bw = max(max_bw, width);
 	}
-	rcu_read_unlock();
-
-	return max_bw;
-}
-
-static enum nl80211_chan_width
-ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx,
-				      struct ieee80211_link_data *rsvd_for)
-{
-	struct ieee80211_sub_if_data *sdata;
-	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		enum nl80211_chan_width width;
-
-		if (!ieee80211_sdata_running(sdata))
-			continue;
-
-		width = ieee80211_get_chanctx_vif_max_required_bw(sdata, ctx,
-								  rsvd_for);
-
-		max_bw = max(max_bw, width);
-	}
 
 	/* use the configured bandwidth in case of monitor interface */
-	sdata = rcu_dereference(local->monitor_sdata);
+	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
 	if (sdata &&
 	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == &ctx->conf)
 		max_bw = max(max_bw, ctx->conf.def.width);
 
-	rcu_read_unlock();
-
 	return max_bw;
 }
 
@@ -582,26 +550,14 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 
 bool ieee80211_is_radar_required(struct ieee80211_local *local)
 {
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		unsigned int link_id;
-
-		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-			struct ieee80211_link_data *link;
-
-			link = rcu_dereference(sdata->link[link_id]);
-
-			if (link && link->radar_required) {
-				rcu_read_unlock();
-				return true;
-			}
-		}
+	for_each_sdata_link(local, link) {
+		if (link->radar_required)
+			return true;
 	}
-	rcu_read_unlock();
 
 	return false;
 }
@@ -611,38 +567,19 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 				 struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx_conf *conf = &ctx->conf;
-	struct ieee80211_sub_if_data *sdata;
-	bool required = false;
+	struct ieee80211_link_data *link;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		unsigned int link_id;
-
-		if (!ieee80211_sdata_running(sdata))
+	for_each_sdata_link(local, link) {
+		if (rcu_access_pointer(link->conf->chanctx_conf) != conf)
 			continue;
-		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-			struct ieee80211_link_data *link;
-
-			link = rcu_dereference(sdata->link[link_id]);
-			if (!link)
-				continue;
-
-			if (rcu_access_pointer(link->conf->chanctx_conf) != conf)
-				continue;
-			if (!link->radar_required)
-				continue;
-			required = true;
-			break;
-		}
-
-		if (required)
-			break;
+		if (!link->radar_required)
+			continue;
+		return true;
 	}
-	rcu_read_unlock();
 
-	return required;
+	return false;
 }
 
 static struct ieee80211_chanctx *
@@ -746,50 +683,38 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx_conf *conf = &ctx->conf;
-	struct ieee80211_sub_if_data *sdata;
 	const struct cfg80211_chan_def *compat = NULL;
+	struct ieee80211_link_data *link;
 	struct ieee80211_chan_req chanreq = {};
 	struct sta_info *sta;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		int link_id;
+	for_each_sdata_link(local, link) {
+		struct ieee80211_bss_conf *link_conf;
 
-		if (!ieee80211_sdata_running(sdata))
+		if (link->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
 
-		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
-			continue;
-
-		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-			struct ieee80211_bss_conf *link_conf =
-				rcu_dereference(sdata->vif.link_conf[link_id]);
+		link_conf = link->conf;
 
-			if (!link_conf)
-				continue;
-
-			if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
-				continue;
+		if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
+			continue;
 
-			if (!compat)
-				compat = &link_conf->chanreq.oper;
+		if (!compat)
+			compat = &link_conf->chanreq.oper;
 
-			compat = cfg80211_chandef_compatible(&link_conf->chanreq.oper,
-							     compat);
-			if (WARN_ON_ONCE(!compat))
-				break;
-		}
+		compat = cfg80211_chandef_compatible(&link_conf->chanreq.oper,
+						     compat);
+		if (WARN_ON_ONCE(!compat))
+			return;
 	}
 
-	if (WARN_ON_ONCE(!compat)) {
-		rcu_read_unlock();
+	if (WARN_ON_ONCE(!compat))
 		return;
-	}
 
 	/* TDLS peers can sometimes affect the chandef width */
-	list_for_each_entry_rcu(sta, &local->sta_list, list) {
+	list_for_each_entry(sta, &local->sta_list, list) {
 		if (!sta->uploaded ||
 		    !test_sta_flag(sta, WLAN_STA_TDLS_WIDER_BW) ||
 		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
@@ -799,9 +724,8 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 		compat = cfg80211_chandef_compatible(&sta->tdls_chandef,
 						     compat);
 		if (WARN_ON_ONCE(!compat))
-			break;
+			return;
 	}
-	rcu_read_unlock();
 
 	if (!compat)
 		return;
@@ -895,23 +819,19 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 {
 	struct ieee80211_sub_if_data *sdata;
 	u8 rx_chains_static, rx_chains_dynamic;
+	struct ieee80211_link_data *link;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rx_chains_static = 1;
 	rx_chains_dynamic = 1;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+	for_each_sdata_link(local, link) {
 		u8 needed_static, needed_dynamic;
-		unsigned int link_id;
 
-		if (!ieee80211_sdata_running(sdata))
-			continue;
-
-		switch (sdata->vif.type) {
+		switch (link->sdata->vif.type) {
 		case NL80211_IFTYPE_STATION:
-			if (!sdata->u.mgd.associated)
+			if (!link->sdata->u.mgd.associated)
 				continue;
 			break;
 		case NL80211_IFTYPE_AP:
@@ -923,49 +843,38 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 			continue;
 		}
 
-		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-			struct ieee80211_link_data *link;
+		if (rcu_access_pointer(link->conf->chanctx_conf) != &chanctx->conf)
+			continue;
 
-			link = rcu_dereference(sdata->link[link_id]);
-
-			if (!link)
-				continue;
-
-			if (rcu_access_pointer(link->conf->chanctx_conf) != &chanctx->conf)
-				continue;
-
-			switch (link->smps_mode) {
-			default:
-				WARN_ONCE(1, "Invalid SMPS mode %d\n",
-					  link->smps_mode);
-				fallthrough;
-			case IEEE80211_SMPS_OFF:
-				needed_static = link->needed_rx_chains;
-				needed_dynamic = link->needed_rx_chains;
-				break;
-			case IEEE80211_SMPS_DYNAMIC:
-				needed_static = 1;
-				needed_dynamic = link->needed_rx_chains;
-				break;
-			case IEEE80211_SMPS_STATIC:
-				needed_static = 1;
-				needed_dynamic = 1;
-				break;
-			}
-
-			rx_chains_static = max(rx_chains_static, needed_static);
-			rx_chains_dynamic = max(rx_chains_dynamic, needed_dynamic);
+		switch (link->smps_mode) {
+		default:
+			WARN_ONCE(1, "Invalid SMPS mode %d\n",
+				  link->smps_mode);
+			fallthrough;
+		case IEEE80211_SMPS_OFF:
+			needed_static = link->needed_rx_chains;
+			needed_dynamic = link->needed_rx_chains;
+			break;
+		case IEEE80211_SMPS_DYNAMIC:
+			needed_static = 1;
+			needed_dynamic = link->needed_rx_chains;
+			break;
+		case IEEE80211_SMPS_STATIC:
+			needed_static = 1;
+			needed_dynamic = 1;
+			break;
 		}
+
+		rx_chains_static = max(rx_chains_static, needed_static);
+		rx_chains_dynamic = max(rx_chains_dynamic, needed_dynamic);
 	}
 
 	/* Disable SMPS for the monitor interface */
-	sdata = rcu_dereference(local->monitor_sdata);
+	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
 	if (sdata &&
 	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == &chanctx->conf)
 		rx_chains_dynamic = rx_chains_static = local->rx_chains;
 
-	rcu_read_unlock();
-
 	if (rx_chains_static == chanctx->conf.rx_chains_static &&
 	    rx_chains_dynamic == chanctx->conf.rx_chains_dynamic)
 		return;
@@ -1004,17 +913,16 @@ __ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 	if (clear)
 		conf = NULL;
 
-	rcu_read_lock();
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		struct ieee80211_bss_conf *vlan_conf;
 
-		vlan_conf = rcu_dereference(vlan->vif.link_conf[link_id]);
+		vlan_conf = wiphy_dereference(local->hw.wiphy,
+					      vlan->vif.link_conf[link_id]);
 		if (WARN_ON(!vlan_conf))
 			continue;
 
 		rcu_assign_pointer(vlan_conf->chanctx_conf, conf);
 	}
-	rcu_read_unlock();
 }
 
 void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
@@ -1204,17 +1112,16 @@ ieee80211_link_update_chanreq(struct ieee80211_link_data *link,
 	if (sdata->vif.type != NL80211_IFTYPE_AP)
 		return;
 
-	rcu_read_lock();
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		struct ieee80211_bss_conf *vlan_conf;
 
-		vlan_conf = rcu_dereference(vlan->vif.link_conf[link_id]);
+		vlan_conf = wiphy_dereference(sdata->local->hw.wiphy,
+					      vlan->vif.link_conf[link_id]);
 		if (WARN_ON(!vlan_conf))
 			continue;
 
 		vlan_conf->chanreq = *chanreq;
 	}
-	rcu_read_unlock();
 }
 
 static int
@@ -1955,12 +1862,11 @@ void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
 
 	ap = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
 
-	rcu_read_lock();
-	ap_conf = rcu_dereference(ap->vif.link_conf[link_id]);
-	conf = rcu_dereference_protected(ap_conf->chanctx_conf,
-					 lockdep_is_held(&local->hw.wiphy->mtx));
+	ap_conf = wiphy_dereference(local->hw.wiphy,
+				    ap->vif.link_conf[link_id]);
+	conf = wiphy_dereference(local->hw.wiphy,
+				 ap_conf->chanctx_conf);
 	rcu_assign_pointer(link_conf->chanctx_conf, conf);
-	rcu_read_unlock();
 }
 
 void ieee80211_iter_chan_contexts_atomic(
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 70c48cad180a..601b889b6237 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1181,6 +1181,19 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 #define sdata_dereference(p, sdata) \
 	wiphy_dereference(sdata->local->hw.wiphy, p)
 
+#define for_each_sdata_link(_local, _link)				\
+	/* outer loop just to define the variables ... */		\
+	for (struct ieee80211_sub_if_data *___sdata = NULL;		\
+	     !___sdata;							\
+	     ___sdata = (void *)~0 /* always stop */)			\
+	list_for_each_entry(___sdata, &(_local)->interfaces, list)	\
+	if (ieee80211_sdata_running(___sdata))				\
+	for (int ___link_id = 0;					\
+	     ___link_id < ARRAY_SIZE(___sdata->link);			\
+	     ___link_id++)						\
+	if ((_link = wiphy_dereference((local)->hw.wiphy,		\
+				       ___sdata->link[___link_id])))
+
 static inline int
 ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems,
 				struct cfg80211_rnr_elems *rnr_elems,
-- 
2.43.0


