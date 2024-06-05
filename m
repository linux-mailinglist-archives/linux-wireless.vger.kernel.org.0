Return-Path: <linux-wireless+bounces-8534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622668FC98E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10ED01F2199B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D142E192B87;
	Wed,  5 Jun 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6pC4gWG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786F1922F2
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585061; cv=none; b=SToeXT0FTtJydSBcs9HWNMVJgeAsY8rnyDZgvBbhd04UEXMGkO8FhigrIIvF1aZ4DLwCZ8Xn7FVbRce3L/B59iNK9PJxYxbCy7hlx6u59jWt1mz2JjZWSJFdaA+V4RdZZzeJlZg0fEFZQRld1F09M8hhADTEtMSf5+R+cI+kz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585061; c=relaxed/simple;
	bh=rCpk1LBT6PF7wSafOMG3Md14Uqhe/SYjj01iVYfA0iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHM8cyGHqE5a4fq56mVNEIAok6YirgX3+F9TpNKuK0DjHSuuEl0IIyZPcKk87hNstP3vlpFC/STSGX3O8X8CqxctS9C7RSuE67doba++bBfoZN27SVLDyxPInPhmMxS6qhAU1SwUj6Joek9/6zn8FJG41yU4qNt+NE2CeGSwByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6pC4gWG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585060; x=1749121060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rCpk1LBT6PF7wSafOMG3Md14Uqhe/SYjj01iVYfA0iY=;
  b=m6pC4gWG7M9k/rAS3myX1lpfoKDxiaZGoGKM8TFVHN1mdvDkpplTHB1H
   mhqp2rmJjPIJ7sL4TUBeXiD4T+gw8DQ3lA8tN4RDlV9uMdG/USaPSdGWV
   4SX1ra9f3Gh1Ob7MmKStaE6ubTSUGN+K78scfc5x68MpAB8WionIrgQ0Q
   x5ysEGjwC+A+JJf0Tv6Fd4VwseQD821H2KdME2hCKN88c1wqFywY15ZGN
   PVHjvcPm7PQp8/xIBdfZtvbcuikb7yjz8fnMx5CkZX0dKCfZ73ixv/trS
   iRSezvq8fhFLjatyWML9en4GWQpBd/s3pWEnFrKcPOvJ3GxxlHQjb1uA+
   Q==;
X-CSE-ConnectionGUID: k7j64ZbsTIehTdMMH0rQBQ==
X-CSE-MsgGUID: UnS1UbgWRleSAvw0kbkOgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919962"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919962"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:40 -0700
X-CSE-ConnectionGUID: LD5iPWggTgez6fRxMg61Dw==
X-CSE-MsgGUID: MxssnEzWSCusyvm5S/BEOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37563027"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 7/7] wifi: mac80211: Add support for interface usage notification
Date: Wed,  5 Jun 2024 13:57:22 +0300
Message-Id: <20240605135233.4d602acf0e65.I01fecab3b41961038f37ca6e0e3039c5fe9bb6bf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When user space indicates the intended usage of a network interface,
propagate the information to the driver.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h    |  4 ++++
 net/mac80211/cfg.c        | 12 ++++++++++++
 net/mac80211/driver-ops.h | 14 ++++++++++++++
 net/mac80211/trace.h      | 23 +++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ecfa65ade226..047dce69e79b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4438,6 +4438,7 @@ struct ieee80211_prep_tx_info {
  *	if the requested TID-To-Link mapping can be accepted or not.
  *	If it's not accepted the driver may suggest a preferred mapping and
  *	modify @ttlm parameter with the suggested TID-to-Link mapping.
+ * @iface_usage: notify about intended usage of added interfaces.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4822,6 +4823,9 @@ struct ieee80211_ops {
 	enum ieee80211_neg_ttlm_res
 	(*can_neg_ttlm)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct ieee80211_neg_ttlm *ttlm);
+
+	void (*iface_usage)(struct ieee80211_hw *hw,
+			    struct cfg80211_iface_usage *iface_usage);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 890590146fa4..b121fc65eb09 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5104,6 +5104,17 @@ ieee80211_set_ttlm(struct wiphy *wiphy, struct net_device *dev,
 	return ieee80211_req_neg_ttlm(sdata, params);
 }
 
+static void
+ieee80211_iface_usage(struct wiphy *wiphy, struct net_device *dev,
+		      struct cfg80211_iface_usage *iface_usage)
+{
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	lockdep_assert_wiphy(wiphy);
+
+	drv_iface_usage(local, iface_usage);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5217,4 +5228,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.del_link_station = ieee80211_del_link_station,
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
 	.set_ttlm = ieee80211_set_ttlm,
+	.iface_usage = ieee80211_iface_usage,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d4e73d3630e0..ccc697bd98ff 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1728,4 +1728,18 @@ drv_can_neg_ttlm(struct ieee80211_local *local,
 
 	return res;
 }
+
+static inline void drv_iface_usage(struct ieee80211_local *local,
+				   struct cfg80211_iface_usage *iface_usage)
+{
+	might_sleep();
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	trace_drv_iface_usage(local, iface_usage);
+	if (local->ops->iface_usage)
+		local->ops->iface_usage(&local->hw, iface_usage);
+
+	trace_drv_return_void(local);
+}
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 8e758b5074bd..b2f2588c7f82 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3145,6 +3145,29 @@ TRACE_EVENT(drv_neg_ttlm_res,
 		  LOCAL_PR_ARG, VIF_PR_ARG, __entry->res
 	)
 );
+
+TRACE_EVENT(drv_iface_usage,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct cfg80211_iface_usage *iface_usage),
+
+	TP_ARGS(local, iface_usage),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(u32, types_mask)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->types_mask = iface_usage->types_mask;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " types_mask=0x%x",
+		LOCAL_PR_ARG, __entry->types_mask
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


