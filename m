Return-Path: <linux-wireless+bounces-13586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE2B992AEB
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5731F2343A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C81D1F7B;
	Mon,  7 Oct 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAabVkKq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5391AA7B4
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302476; cv=none; b=oLE3M8kPQVeZPxpZun3YC5BfC0og1j6q0j1rq61vBFBpJb2IRBqxIoUsXKVBklKk9KAcl/POXYxlehoMrrS7EiefWmwLrgH3bQ+iES+16JeRbubc9srQfF4obJr2crR533Co4SC5PyRJu8BtHD36D9I1eX2gsAD8/Cbtcpq7UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302476; c=relaxed/simple;
	bh=8KceWwUds778BALn+IZ1Eo2KWDvU/ZYUX2F1Luvelq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkO5itWD2Ceco6WPiXtvQy/w0OVuqOitJrjXhamz/+42EX8TOsL1xR5Qd03/3C6+SCehIeUaR9fcq9IP+x9YPGoJrQj94QihH6WKFqpSZsrmUdFdeSuO98quhiYJXl39ti4gK6qtEYDO0Oc9zwEspk50wOw+k4n6nM7jvc7ziJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAabVkKq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302474; x=1759838474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KceWwUds778BALn+IZ1Eo2KWDvU/ZYUX2F1Luvelq8=;
  b=mAabVkKqd3RxyFy2SaqyQYM7lU7FaJBduuwoW0WlYQfwpCz1ZPOs7cso
   3A4zExzSCdYAvZtOr30WWBOAr5vQaSCJHt79AVj6wwgl2/+kGZnRR/Ol7
   XlDTRBo/Y5pwZkgVwhhtNWPQXhhOJ5wPEXvxSOhs169PFnUKt+9JouYmZ
   hsyy1FJwL4Osq4R/4s2et1hYKCEGsTn3bJHC7pvxCDEU4WHcWCWL5tmWE
   RMD+Nu9zP3PjHoFRREirzJKm3XHQ5Px6U7oLOcpwl5nQBEwQ+mx5PP7uk
   +uqzOHv3SWJKEJN63TJkTj/Z73PnxvYEPkwK8M5tRnD2CN9nHJm/G8FKL
   w==;
X-CSE-ConnectionGUID: MCKQoU3AT16nS2DNth/hUw==
X-CSE-MsgGUID: lKma1yHSR+6HaUBagnfMxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099366"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099366"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:14 -0700
X-CSE-ConnectionGUID: IgdMnebLT8u9vcLSXTPmhA==
X-CSE-MsgGUID: BeXcJkPoQleda4piVtr7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019229"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/14] wifi: mac80211: Add support to indicate that a new interface is to be added
Date: Mon,  7 Oct 2024 15:00:45 +0300
Message-Id: <20241007144851.e0e8563e1c30.Ifccc96a46a347eb15752caefc9f4eff31f75ed47@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support to indicate to the driver that an interface is about to be
added so that the driver could prepare its resources early if it needs
so.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h    |  8 ++++++++
 net/mac80211/cfg.c        | 18 ++++++++++++++++++
 net/mac80211/driver-ops.h | 12 ++++++++++++
 net/mac80211/trace.h      | 19 +++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 954dff901b69..479b61fdfb96 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4444,6 +4444,12 @@ struct ieee80211_prep_tx_info {
  *	if the requested TID-To-Link mapping can be accepted or not.
  *	If it's not accepted the driver may suggest a preferred mapping and
  *	modify @ttlm parameter with the suggested TID-to-Link mapping.
+ * @prep_add_interface: prepare for interface addition. This can be used by
+ *      drivers to prepare for the addition of a new interface, e.g., allocate
+ *      the needed resources etc. This callback doesn't guarantee that an
+ *      interface with the specified type would be added, and thus drivers that
+ *      implement this callback need to handle such cases. The type is the full
+ *      &enum nl80211_iftype.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4828,6 +4834,8 @@ struct ieee80211_ops {
 	enum ieee80211_neg_ttlm_res
 	(*can_neg_ttlm)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct ieee80211_neg_ttlm *ttlm);
+	void (*prep_add_interface)(struct ieee80211_hw *hw,
+				   enum nl80211_iftype type);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 847304a3a29a..ce9558cd1576 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -194,6 +194,24 @@ static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 		}
 	}
 
+	/* Let the driver know that an interface is going to be added.
+	 * Indicate so only for interface types that will be added to the
+	 * driver.
+	 */
+	switch (type) {
+	case NL80211_IFTYPE_AP_VLAN:
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) ||
+		    !(params->flags & MONITOR_FLAG_ACTIVE))
+			break;
+		fallthrough;
+	default:
+		drv_prep_add_interface(local,
+				       ieee80211_vif_type_p2p(&sdata->vif));
+		break;
+	}
+
 	return wdev;
 }
 
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d382d9729e85..48bc2da728c0 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1728,4 +1728,16 @@ drv_can_neg_ttlm(struct ieee80211_local *local,
 
 	return res;
 }
+
+static inline void
+drv_prep_add_interface(struct ieee80211_local *local,
+		       enum nl80211_iftype type)
+{
+	trace_drv_prep_add_interface(local, type);
+	if (local->ops->prep_add_interface)
+		local->ops->prep_add_interface(&local->hw, type);
+
+	trace_drv_return_void(local);
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index dc498cd8cd91..e6f0ce8e5d43 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3154,6 +3154,25 @@ TRACE_EVENT(drv_neg_ttlm_res,
 		  LOCAL_PR_ARG, VIF_PR_ARG, __entry->res
 	)
 );
+
+TRACE_EVENT(drv_prep_add_interface,
+	    TP_PROTO(struct ieee80211_local *local,
+		     enum nl80211_iftype type),
+
+	TP_ARGS(local, type),
+	TP_STRUCT__entry(LOCAL_ENTRY
+			 __field(u32, type)
+	),
+
+	TP_fast_assign(LOCAL_ASSIGN;
+		       __entry->type = type;
+	),
+
+	TP_printk(LOCAL_PR_FMT  " type: %u\n ",
+		  LOCAL_PR_ARG, __entry->type
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


