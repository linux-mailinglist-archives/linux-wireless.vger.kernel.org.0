Return-Path: <linux-wireless+bounces-4944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E716880BC7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059DF1F2382C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2452BB18;
	Wed, 20 Mar 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9/1QvTR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FD23778
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918861; cv=none; b=bFLLIAVGVtmI6YrUlmNdk0/lpQN7DYj9LHc3sBjdiAET057Do5ANu1WCifUOal9hnks79RzXj28XkfchIba0kiupJ0k6dPxHCwatOskcK0T+2mMMmD2pAx6viSxxSD47dU9ZQCTNAGzuvfT3gjApl5skKp3huEI2ISYFgoP5Qag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918861; c=relaxed/simple;
	bh=DV6yRITVcZS2bjN0kFl77JZPjPEXGlJb8iFBXArNIco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCFbtcw2LLhqa0Xs7jnlommFxA9284IjepBwn62Kp/mqq4Hrc9r+g7x6xJ8S8xksEaqqWQ0UfhUNcSF/g4mg/ehXPqU+apkra97QgKgcxmIos9vSKSnsiJqOO23gR0MWu1/+yyUqN4JXEM8gclGk+jmU/OedeYtBig/5N6ayJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9/1QvTR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918859; x=1742454859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DV6yRITVcZS2bjN0kFl77JZPjPEXGlJb8iFBXArNIco=;
  b=k9/1QvTRZleA1aYzVL7JbFpmApEM+7nFihFjPI8QT4oq8v4tKIQbNNuN
   ptQPpePEqxtyuhEy3Otd+mTJhzsGbNiQMCLdQfMgs/bdJz6uJblizHOsi
   cnO2vbsRoB0hdjlqWYZYI0tLsnYm4J6zO9DSjExREgpb0AwntfEr0HQhR
   6iZhXgQ0TRY10fc/gQdtHaj8QEDR1JYJfEmrKKquF3fyoVb65LP88x8Da
   9G+Dim2BJgkgz1NK8TjrBpVDoO7CE/EWTRnGmQtX5YPGuHBo6CDU9g+7F
   bg7/Q3cmpWirkQMnSDL801Nbp8oZPUtGPaCZ+Pad0ahVpOhhyNl4062fU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763830"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763830"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477400"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/8] wifi: mac80211: don't enter idle during link switch
Date: Wed, 20 Mar 2024 09:13:59 +0200
Message-Id: <20240320091155.170328bac555.If4a522a9dd3133b91983854b909a4de13aa635da@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
References: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When doing link switch with a disjoint set of links before
and after the switch, we end up removing all channel contexts,
adding new ones later. This looks like 'idle' to the code now,
and we enter idle which also includes flushing queues. But we
can't actually flush since we don't have a link active (bound
to a channel context), and entering idle just to leave it again
is also wrong.

Fix this by passing through an indication that we shouldn't do
any idle checks in this case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c        | 34 +++++++++++++++++++---------------
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/link.c        |  2 +-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 80e4b9784131..5a7fb0e4f89d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -695,26 +695,29 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 }
 
 static void ieee80211_del_chanctx(struct ieee80211_local *local,
-				  struct ieee80211_chanctx *ctx)
+				  struct ieee80211_chanctx *ctx,
+				  bool skip_idle_recalc)
 {
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	drv_remove_chanctx(local, ctx);
 
-	ieee80211_recalc_idle(local);
+	if (!skip_idle_recalc)
+		ieee80211_recalc_idle(local);
 
 	ieee80211_remove_wbrf(local, &ctx->conf.def);
 }
 
 static void ieee80211_free_chanctx(struct ieee80211_local *local,
-				   struct ieee80211_chanctx *ctx)
+				   struct ieee80211_chanctx *ctx,
+				   bool skip_idle_recalc)
 {
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	WARN_ON_ONCE(ieee80211_chanctx_refcount(local, ctx) != 0);
 
 	list_del_rcu(&ctx->list);
-	ieee80211_del_chanctx(local, ctx);
+	ieee80211_del_chanctx(local, ctx, skip_idle_recalc);
 	kfree_rcu(ctx, rcu_head);
 }
 
@@ -1002,7 +1005,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 			list_del_rcu(&ctx->list);
 			kfree_rcu(ctx, rcu_head);
 		} else {
-			ieee80211_free_chanctx(sdata->local, ctx);
+			ieee80211_free_chanctx(sdata->local, ctx, false);
 		}
 	}
 
@@ -1218,7 +1221,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 				     CHANCTX_SWMODE_REASSIGN_VIF);
 	if (err) {
 		if (ieee80211_chanctx_refcount(local, new_ctx) == 0)
-			ieee80211_free_chanctx(local, new_ctx);
+			ieee80211_free_chanctx(local, new_ctx, false);
 
 		goto out;
 	}
@@ -1232,7 +1235,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	ieee80211_check_fast_xmit_iface(sdata);
 
 	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
-		ieee80211_free_chanctx(local, old_ctx);
+		ieee80211_free_chanctx(local, old_ctx, false);
 
 	ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
 	ieee80211_recalc_smps_chanctx(local, new_ctx);
@@ -1286,7 +1289,7 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 	err = ieee80211_assign_link_chanctx(link, new_ctx);
 	if (err) {
 		if (ieee80211_chanctx_refcount(local, new_ctx) == 0)
-			ieee80211_free_chanctx(local, new_ctx);
+			ieee80211_free_chanctx(local, new_ctx, false);
 
 		goto out;
 	}
@@ -1383,7 +1386,7 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 		if (!list_empty(&ctx->replace_ctx->assigned_links))
 			continue;
 
-		ieee80211_del_chanctx(local, ctx->replace_ctx);
+		ieee80211_del_chanctx(local, ctx->replace_ctx, false);
 		err = ieee80211_add_chanctx(local, ctx);
 		if (err)
 			goto err;
@@ -1400,7 +1403,7 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 		if (!list_empty(&ctx->replace_ctx->assigned_links))
 			continue;
 
-		ieee80211_del_chanctx(local, ctx);
+		ieee80211_del_chanctx(local, ctx, false);
 		WARN_ON(ieee80211_add_chanctx(local, ctx->replace_ctx));
 	}
 
@@ -1652,7 +1655,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	return err;
 }
 
-static void __ieee80211_link_release_channel(struct ieee80211_link_data *link)
+void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
+				      bool skip_idle_recalc)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_bss_conf *link_conf = link->conf;
@@ -1680,7 +1684,7 @@ static void __ieee80211_link_release_channel(struct ieee80211_link_data *link)
 
 	ieee80211_assign_link_chanctx(link, NULL);
 	if (ieee80211_chanctx_refcount(local, ctx) == 0)
-		ieee80211_free_chanctx(local, ctx);
+		ieee80211_free_chanctx(local, ctx, skip_idle_recalc);
 
 	link->radar_required = false;
 
@@ -1721,7 +1725,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (ret < 0)
 		goto out;
 
-	__ieee80211_link_release_channel(link);
+	__ieee80211_link_release_channel(link, false);
 
 	ctx = ieee80211_find_chanctx(local, chanreq, mode);
 	if (!ctx)
@@ -1737,7 +1741,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (ret) {
 		/* if assign fails refcount stays the same */
 		if (ieee80211_chanctx_refcount(local, ctx) == 0)
-			ieee80211_free_chanctx(local, ctx);
+			ieee80211_free_chanctx(local, ctx, false);
 		goto out;
 	}
 
@@ -1930,7 +1934,7 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (rcu_access_pointer(link->conf->chanctx_conf))
-		__ieee80211_link_release_channel(link);
+		__ieee80211_link_release_channel(link, false);
 }
 
 void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 925e875f9b96..c2212363dad3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2567,6 +2567,8 @@ int __must_check
 ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
 			      const struct ieee80211_chan_req *req,
 			      u64 *changed);
+void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
+				      bool skip_idle_recalc);
 void ieee80211_link_release_channel(struct ieee80211_link_data *link);
 void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link);
 void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 7f01462f84e9..503ec47bbc2a 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -358,7 +358,7 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 
 		ieee80211_teardown_tdls_peers(link);
 
-		ieee80211_link_release_channel(link);
+		__ieee80211_link_release_channel(link, true);
 	}
 
 	list_for_each_entry(sta, &local->sta_list, list) {
-- 
2.34.1


