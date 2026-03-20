Return-Path: <linux-wireless+bounces-33577-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLu/CPsDvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33577-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:23:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 457062D727A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C76EF304530A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F051233134;
	Fri, 20 Mar 2026 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2X8ZKh4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B228469A
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994574; cv=none; b=nOdzePRsd5GzENeOC/dtfyPPrfF4xRjzCEGL6inb5x+IizHJV4NbIHnSxcBeR77EGXE1FtbfGe9/ATd5Se82DABK7NBa3qGQ91RxECuZZf+ziHEXEM4WjaObSTUmPdoLa4M5gMPjSUuF5ed0ZhTFgDnf77Nui39w4qEE0Xu9zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994574; c=relaxed/simple;
	bh=4cUxkVqIOB07Eq4k+1WRC9p/fcWjRk95CwzR2pPyEx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U1J3eNFrl3i7kmIARDbsk5/Q2XA9p1CSkMgMDe1sUtexfZjtqpZnbWR/E3cHl9soTN+dAP7dYYVTwpud3Ndxu+MPBIKJFBu8oL3fvGDzj/hUB+i/hiH/JkHuzETCTBVrX+WINKJ7BONhTRkj4ZylMfh/GqXAWJ1zeaa+e12yQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2X8ZKh4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994573; x=1805530573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4cUxkVqIOB07Eq4k+1WRC9p/fcWjRk95CwzR2pPyEx0=;
  b=Z2X8ZKh4RiKlMw7EQ2K2AaAGqNnk1fCC03tXdqGPwMkVQqH41MmH8mpc
   qZv8Jof1NZ73vboG/CnhBLSgWMSmDzyHDZDI5X2gssr7ffBSkaoSTni/P
   AaFORteIf/Ko837Jbj13ItYhDLW4LMXmAzWUGloC4XvSIQpncIfuqWRai
   vYgQS4vG74O9LGS0aCS2js45tuVDtozfUbeCv5nrtRIcfPDai79VBeT2Z
   QX5JoduHZIVvWoX70Vrxb5P7vGsmdTzJDaYhA6uMqkHNJtdZg7fA2loyF
   liSysDhPkotCK+MGJELJCirAP6dMOVFXMQS0Aw58h1tRHUT5OgsZdxgrN
   w==;
X-CSE-ConnectionGUID: RZseWjuVS2SDl8WeHsE/Kg==
X-CSE-MsgGUID: 9i/stsfXT4+3Ezohwu8oXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75109592"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75109592"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:16:13 -0700
X-CSE-ConnectionGUID: 4aAaU9e3R4uAWVrjTs5wIA==
X-CSE-MsgGUID: iSLI0dGvTMu7B23EIWwy6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="253717722"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:16:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: use for_each_chanctx_user_* in one more place
Date: Fri, 20 Mar 2026 10:16:01 +0200
Message-Id: <20260320101556.4691916c7877.I9660f3945f4dccdb6d41a06ec4e74161e5ac65a4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33577-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 457062D727A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

for_each_chanctx_user_* is an iterator that visits all types of chanctx
users, including the (to be added) NAN channels, and not only the link.

ieee80211_get_chanctx_max_required_bw wasn't changed to use this new
iterator, do it now.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c | 123 +++++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 52 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 2f0c93f3ace6..b7604118bf57 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -447,74 +447,93 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
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
2.34.1


