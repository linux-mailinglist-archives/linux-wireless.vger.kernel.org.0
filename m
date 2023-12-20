Return-Path: <linux-wireless+bounces-978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B4818397
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A6B1F250AC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F2B12B87;
	Tue, 19 Dec 2023 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pp8G+L+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5412B60
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975122; x=1734511122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HIWR4TU2Raxx4XmJILPgztifnKlVqFNDr9+NcSsGij8=;
  b=Pp8G+L+HDMvnNPRCJVIxt6E1qj+PI4sns2tUdr3FfolX6cVqw06985XB
   P0kTEXZnM7dH11/7xgC7AhAWGyUFy+njiBVbhLYKEIjB/H+SSlK9NV1T9
   XmY9p/Da0tNF2vhDm2jI2EbJCGaoz8/s9Z4dWP0r6JZysJwv7pOX1kByv
   CwmZqkrYiKVdCnBimy9IPym8u8W28KpJw3XlPxRWZjdmevPK2c8gKD2p5
   BcUPjHF07eObig60Fk0lT61kvcv+VLOgmmxmocLFGhwPSJAeCrOyplKcQ
   35/5OZie03YdFEQ9ptjRHRVm6/5qT4UuZO7VtjkBMfKCkVJ3YCfb291eC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969322"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969322"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266571"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266571"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: mac80211: add a driver callback to check active_links
Date: Wed, 20 Dec 2023 04:38:02 +0200
Message-Id: <20231220043149.2ef12ba4c905.I79708619be76b8ecd4ef3975205b8f903e24a2cd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

During ieee80211_set_active_links() we do (among the others):
1. Call drv_change_vif_links() with both old_active and new_active
2. Unassign the chanctx for the removed link(s) (if any)
3. Assign chanctx to the added link(s) (if any)
4. Call drv_change_vif_links() with the new_active links bitmap

The problem here is that during step #1 the driver doesn't know whether
we will activate multiple links simultaneously or are just doing a link
switch, so it can't check there if multiple links are supported/enabled.
(Some of the drivers might enable/disable this option dynamically)

And during step #3, in which the driver already knows that,
returning an error code (for example when multiple links are not
supported or disabled), will cause a warning, and we will still complete
the transition to the new_active links.
(It is hard to undo things in that stage, since we released channels etc.)

Therefore add a driver callback to check if the desired new_active links
will be supported by the driver or not. This callback will be called
in the beginning of ieee80211_set_active_links() so we won't do anything
before we are sure it is supported.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
---
 include/net/mac80211.h    |  5 +++++
 net/mac80211/driver-ops.h | 20 ++++++++++++++++++++
 net/mac80211/link.c       |  3 +++
 net/mac80211/trace.h      | 25 +++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 58328d0c1cf5..7cb60a5a7904 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4281,6 +4281,8 @@ struct ieee80211_prep_tx_info {
  *	disable background CAC/radar detection.
  * @net_fill_forward_path: Called from .ndo_fill_forward_path in order to
  *	resolve a path for hardware flow offloading
+ * @can_activate_links: Checks if a specific active_links bitmap is
+ *	supported by the driver.
  * @change_vif_links: Change the valid links on an interface, note that while
  *	removing the old link information is still valid (link_conf pointer),
  *	but may immediately disappear after the function returns. The old or
@@ -4661,6 +4663,9 @@ struct ieee80211_ops {
 				     struct ieee80211_sta *sta,
 				     struct net_device_path_ctx *ctx,
 				     struct net_device_path *path);
+	bool (*can_activate_links)(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   u16 active_links);
 	int (*change_vif_links)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				u16 old_links, u16 new_links,
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index fecf92f06da7..39ac2c0d6190 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1661,6 +1661,26 @@ static inline int drv_net_setup_tc(struct ieee80211_local *local,
 	return ret;
 }
 
+static inline bool drv_can_activate_links(struct ieee80211_local *local,
+					  struct ieee80211_sub_if_data *sdata,
+					  u16 active_links)
+{
+	bool ret = true;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (!check_sdata_in_driver(sdata))
+		return false;
+
+	trace_drv_can_activate_links(local, sdata, active_links);
+	if (local->ops->can_activate_links)
+		ret = local->ops->can_activate_links(&local->hw, &sdata->vif,
+						     active_links);
+	trace_drv_return_bool(local, ret);
+
+	return ret;
+}
+
 int drv_change_vif_links(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata,
 			 u16 old_links, u16 new_links,
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index bf7bd880d062..d4f86955afa6 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -444,6 +444,9 @@ int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (!drv_can_activate_links(local, sdata, active_links))
+		return -EINVAL;
+
 	old_active = sdata->vif.active_links;
 	if (old_active & active_links) {
 		/*
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 032718d5b298..06835ed4c44f 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2512,6 +2512,31 @@ TRACE_EVENT(drv_net_setup_tc,
 	)
 );
 
+TRACE_EVENT(drv_can_activate_links,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 u16 active_links),
+
+	TP_ARGS(local, sdata, active_links),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		__field(u16, active_links)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		__entry->active_links = active_links;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT VIF_PR_FMT " requested active_links:0x%04x\n",
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->active_links
+	)
+);
+
 TRACE_EVENT(drv_change_vif_links,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


