Return-Path: <linux-wireless+bounces-30463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E7CFECA7
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E3531785A6
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687F32E686;
	Wed,  7 Jan 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ldE/UUIQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1133290B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795819; cv=none; b=BYLwNGtimlvUoAdzKIC0pLkc8zGhUHavcka1QE2sK5bLoSEST1HyYEFO4odmoLPYzobCCOLs1LM03Z1cw6IhGb+QYfDX9wrXH2nu1TrQWH2v8jBl8Hv8B2oD9oBfWjmHstjiFDOyAxBcayUFa4rs8yRDCQZn9m+Sm9cJY4xSQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795819; c=relaxed/simple;
	bh=bWFl0YN+EDLcX9rfAsZMcNE4IQc1haN4fpbOH8wj4p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsPy96rVvhJ2Dfgcqhwj9B+seKThT/kMNKrNgC3AiO8kDtbiGvXEwtCjTNg64GX/TAU3Umj/nJVNB5lx/y4lAy0GMVrwdXRWoOuAapgpjbV39KzHcFx5koYb4Tsc8Mvu8AQUFw0jvofplleOBFl2rMBGWEjUvw/fKWo+5xTce9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ldE/UUIQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DnvoJ5aLp1IczPPAZrnzEzoK9pxc4DHZMmVj2P1JvBw=;
	t=1767795817; x=1769005417; b=ldE/UUIQXrLMMeZeQfPD8a+SsyRT5bHEhe4HruCydqQ3cvm
	A+0SfjtQkkaYCMjyhQxfqj3/ApBW6NOK8expiGUk7Ws3JwVQIqQZDMj0J5Khg6+F/ix5Dag/ob/hV
	BE/wQdkxUHMmENiFQyrIv8/nOOQxI0+cyuBML40jpzPzKSLV6lIIlnmCZJYm8q7mviF9P5WSswTwj
	Wvc5jy6RnvaoLE9VN/XJQoHS7Rz6NCOo7xOE16T/j1QOY8rmnrnNOTIc/yToU10B+yrHfYuldNUC7
	MucGMGrPcVSLZOAZt6AeXscmtGSpOMl+LI451Aw6CO9gTNFMreI5CxSGfAvj3gEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURi-00000005agF-2kPi;
	Wed, 07 Jan 2026 15:23:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 01/46] wifi: mac80211: use for_each_chanctx_user_* in one more place
Date: Wed,  7 Jan 2026 15:22:00 +0100
Message-ID: <20260107152324.1bb801889fb1.I62dce7e970616ffa8b9ac857c7d66c87fba99076@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

for_each_chanctx_user_* is an iterator that visits all types of chanctx
users, including the (to be added) NAN channels, and not only the link.

ieee80211_get_chanctx_max_required_bw wasn't changed to use this new
iterator, do it now.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 125 +++++++++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 53 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index b9f1b336609c..5059f52a7d9f 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -423,75 +423,94 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 	return max_bw;
 }
 
+static enum nl80211_chan_width
+ieee80211_get_width_of_link(struct ieee80211_link_data *link)
+{
+	struct ieee80211_local *local = link->sdata->local;
+
+	switch (link->sdata->vif.type) {
+	case NL80211_IFTYPE_STATION:
+		if (!link->sdata->vif.cfg.assoc) {
+			/*
+			 * The AP's sta->bandwidth may not yet be set
+			 * at this point (pre-association), so simply
+			 * take the width from the chandef. We cannot
+			 * have TDLS peers yet (only after association).
+			 */
+			return link->conf->chanreq.oper.width;
+		}
+		/*
+		 * otherwise just use min_def like in AP, depending on what
+		 * we currently think the AP STA (and possibly TDLS peers)
+		 * require(s)
+		 */
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_AP_VLAN:
+		return ieee80211_get_max_required_bw(link);
+	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_NAN:
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
+						 NO_VIRTUAL_MONITOR));
+		fallthrough;
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_OCB:
+		return link->conf->chanreq.oper.width;
+	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_UNSPECIFIED:
+	case NUM_NL80211_IFTYPES:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_NAN_DATA:
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	/* Take the lowest possible, so it won't change the max width */
+	return NL80211_CHAN_WIDTH_20_NOHT;
+}
+
 static enum nl80211_chan_width
 ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
 				      struct ieee80211_link_data *rsvd_for,
 				      bool check_reserved)
 {
-	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_link_data *link;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
+	struct ieee80211_chanctx_user_iter iter;
+	struct ieee80211_sub_if_data *sdata;
+	enum nl80211_chan_width width;
 
 	if (WARN_ON(check_reserved && rsvd_for))
 		return ctx->conf.def.width;
 
-	for_each_sdata_link(local, link) {
-		enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20_NOHT;
-
-		if (check_reserved) {
-			if (link->reserved_chanctx != ctx)
-				continue;
-		} else if (link != rsvd_for &&
-			   rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
-			continue;
-
-		switch (link->sdata->vif.type) {
-		case NL80211_IFTYPE_STATION:
-			if (!link->sdata->vif.cfg.assoc) {
-				/*
-				 * The AP's sta->bandwidth may not yet be set
-				 * at this point (pre-association), so simply
-				 * take the width from the chandef. We cannot
-				 * have TDLS peers yet (only after association).
-				 */
-				width = link->conf->chanreq.oper.width;
-				break;
-			}
-			/*
-			 * otherwise just use min_def like in AP, depending on what
-			 * we currently think the AP STA (and possibly TDLS peers)
-			 * require(s)
-			 */
-			fallthrough;
-		case NL80211_IFTYPE_AP:
-		case NL80211_IFTYPE_AP_VLAN:
-			width = ieee80211_get_max_required_bw(link);
-			break;
-		case NL80211_IFTYPE_P2P_DEVICE:
-		case NL80211_IFTYPE_NAN:
-			continue;
-		case NL80211_IFTYPE_MONITOR:
-			WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
-							 NO_VIRTUAL_MONITOR));
-			fallthrough;
-		case NL80211_IFTYPE_ADHOC:
-		case NL80211_IFTYPE_MESH_POINT:
-		case NL80211_IFTYPE_OCB:
-			width = link->conf->chanreq.oper.width;
-			break;
-		case NL80211_IFTYPE_WDS:
-		case NL80211_IFTYPE_UNSPECIFIED:
-		case NUM_NL80211_IFTYPES:
-		case NL80211_IFTYPE_P2P_CLIENT:
-		case NL80211_IFTYPE_P2P_GO:
-		case NL80211_IFTYPE_NAN_DATA:
-			WARN_ON_ONCE(1);
+	/* When this is true we only care about the reserving links */
+	if (check_reserved) {
+		for_each_chanctx_user_reserved(local, ctx, &iter) {
+			width = ieee80211_get_width_of_link(iter.link);
+			max_bw = max(max_bw, width);
 		}
+		goto check_monitor;
+	}
 
+	/* Consider all assigned links */
+	for_each_chanctx_user_assigned(local, ctx, &iter) {
+		width = ieee80211_get_width_of_link(iter.link);
 		max_bw = max(max_bw, width);
 	}
 
+	if (!rsvd_for ||
+	    rsvd_for->sdata == rcu_access_pointer(local->monitor_sdata))
+		goto check_monitor;
+
+	/* Consider the link for which this chanctx is reserved/going to be assigned */
+	width = ieee80211_get_width_of_link(rsvd_for);
+	max_bw = max(max_bw, width);
+
+check_monitor:
 	/* use the configured bandwidth in case of monitor interface */
 	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
 	if (sdata &&
-- 
2.52.0


