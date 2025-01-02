Return-Path: <linux-wireless+bounces-16985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F1E9FFA60
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFEA1883BC6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174311B4258;
	Thu,  2 Jan 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo+dvk+G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9F1B2188
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827636; cv=none; b=eSBFUNCQwnlKaQ+8DwEftzlNc+4cfsK/0xmzhYCzyW4UZOqR6AtF+Qj01Nx0l/MNt4vR5mo3SEVOMUHVKjKxk1LTWZCKi5cWV7dGaMZId5+uBwWCfndLSrgFVq6yZHViY2rmvkBSS0k/7Bgu1QiBr5XWrwgYSCGqjSkxV+k1y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827636; c=relaxed/simple;
	bh=tkkSXh2Nh9GZyk0MIj87JqN7OpJgyj/pUNbdqdhuZTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrxlZhFNx9TBdFUCGOPtkzgcG0HbdAfs1peDxCkALaAYWcT4HkWQwQzq9R84enLc+dASepUqC63gNMhYGAEu0C1Q/OI0rqWzNuexxA6F88z71wJVFPGg+rBMdZ8+d2M1b5FPlg9y6BC9LrP7fkJdlTeN6xqEYbQD2kOmLH0xozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo+dvk+G; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827634; x=1767363634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkkSXh2Nh9GZyk0MIj87JqN7OpJgyj/pUNbdqdhuZTc=;
  b=Fo+dvk+GM/LcWqloZ/CfWByknkpYzt925XsdV7+K1mUEYycMUOgYUxjx
   kPbSNFjPdYfp2Tyf5EXXAjT/JiFdo1gBLhpuDtQ2nkrEuUxibGxMFoOh4
   5UvVBOeZFgYs1qb0YBYzEhuzj9V7Ab+asSXnSkB1LdUofn7EtZ9UbRnTu
   4q2a8e73EpNb0A56DAtc40YJkGDCiHaTKk6jHF+VUvDCbUXfNdFCy+u3v
   Ppb6FYRP0mFPZcQl7pyf2hSdT02Qglc6ytdDrT51TsfWGPL3Njy+hkk1I
   YQ1SiQZMOvBW7lHzy6SiLAcl4rlny7YarxLrkoyULez/hn39Zppt6EdHQ
   A==;
X-CSE-ConnectionGUID: CL4CKHWxRty2Y/FH7BmZpw==
X-CSE-MsgGUID: zloitSc/Ra2y0nWnhBpP9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735112"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:34 -0800
X-CSE-ConnectionGUID: /0RINjqgQ0erM9nKBOCepw==
X-CSE-MsgGUID: aeF33shRSla06QIEYgMhiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357402"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/17] wifi: cfg80211: Add support for controlling EPCS
Date: Thu,  2 Jan 2025 16:19:59 +0200
Message-Id: <20250102161730.ea54ac94445c.I11d750188bc0871e13e86146a3b5cc048d853e69@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for configuring Emergency Preparedness Communication
Services (EPCS) for station mode.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 10 ++++++
 include/uapi/linux/nl80211.h |  9 ++++++
 net/wireless/nl80211.c       | 60 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 15 +++++++++
 net/wireless/trace.h         | 34 ++++++++++++++++++++
 5 files changed, 128 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d4b4cabac029..363d7dd2255a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4594,6 +4594,7 @@ struct mgmt_frame_regs {
  *
  * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
  * @set_ttlm: set the TID to link mapping.
+ * @set_epcs: Enable/Disable EPCS for station mode.
  * @get_radio_mask: get bitmask of radios in use.
  *	(invoked with the wiphy mutex held)
  * @assoc_ml_reconf: Request a non-AP MLO connection to perform ML
@@ -4971,6 +4972,8 @@ struct cfg80211_ops {
 	int     (*assoc_ml_reconf)(struct wiphy *wiphy, struct net_device *dev,
 				   struct cfg80211_assoc_link *add_links,
 				   u16 rem_links);
+	int	(*set_epcs)(struct wiphy *wiphy, struct net_device *dev,
+			    bool val);
 };
 
 /*
@@ -9771,6 +9774,13 @@ void cfg80211_mlo_reconf_add_done(struct net_device *dev,
  */
 void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
 
+/**
+ * cfg80211_epcs_changed - Notify about a change in EPCS state
+ * @netdev: the wireless device whose EPCS state changed
+ * @enabled: set to true if EPCS was enabled, otherwise set to false.
+ */
+void cfg80211_epcs_changed(struct net_device *netdev, bool enabled);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f900d7cc42bc..f6c1b181c886 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1332,6 +1332,10 @@
  * @NL80211_CMD_ASSOC_MLO_RECONF: For a non-AP MLD station, request to
  *      add/remove links to/from the association.
  *
+ * @NL80211_CMD_EPCS_CFG: EPCS configuration for a station. Used by userland to
+ *	control EPCS configuration. Used to notify userland on the current state
+ *	of EPCS.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1590,6 +1594,7 @@ enum nl80211_commands {
 	NL80211_CMD_SET_TID_TO_LINK_MAPPING,
 
 	NL80211_CMD_ASSOC_MLO_RECONF,
+	NL80211_CMD_EPCS_CFG,
 
 	/* add new commands above here */
 
@@ -2885,6 +2890,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_MLO_RECONF_REM_LINKS: (u16) A bitmask of the links requested
  *      to be removed from the MLO association.
  *
+ * @NL80211_ATTR_EPCS: Flag attribute indicating that EPCS is enabled for a
+ *	station interface.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3438,6 +3446,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_SUPPORTED_SELECTORS,
 
 	NL80211_ATTR_MLO_RECONF_REM_LINKS,
+	NL80211_ATTR_EPCS,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ea7eda9feabb..d073f14eb6ae 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -849,6 +849,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_supported_selectors,
 				       NL80211_MAX_SUPP_SELECTORS),
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
+	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -16536,6 +16537,26 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int
+nl80211_epcs_cfg(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	bool val;
+
+	if (wdev->iftype != NL80211_IFTYPE_STATION &&
+	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
+		return -EOPNOTSUPP;
+
+	if (!wdev->connected)
+		return -ENOLINK;
+
+	val = nla_get_flag(info->attrs[NL80211_ATTR_EPCS]);
+
+	return rdev_set_epcs(rdev, dev, val);
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -17734,6 +17755,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_EPCS_CFG,
+		.doit = nl80211_epcs_cfg,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
@@ -20479,6 +20506,39 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev)
 }
 EXPORT_SYMBOL(cfg80211_schedule_channels_check);
 
+void cfg80211_epcs_changed(struct net_device *netdev, bool enabled)
+{
+	struct wireless_dev *wdev = netdev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_epcs_changed(wdev, enabled);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_EPCS_CFG);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (enabled && nla_put_flag(msg, NL80211_ATTR_EPCS))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, GFP_KERNEL);
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_epcs_changed);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2393a25577ad..759da1623342 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1566,4 +1566,19 @@ rdev_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_epcs(struct cfg80211_registered_device *rdev,
+	      struct net_device *dev, bool val)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret = -EOPNOTSUPP;
+
+	trace_rdev_set_epcs(wiphy, dev, val);
+	if (rdev->ops->set_epcs)
+		ret = rdev->ops->set_epcs(wiphy, dev, val);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index d57e676cb5af..9aa8081ca454 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3049,6 +3049,24 @@ TRACE_EVENT(rdev_set_ttlm,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG)
 );
 
+TRACE_EVENT(rdev_set_epcs,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 bool val),
+	TP_ARGS(wiphy, netdev, val),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(bool, val)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->val = val;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", config=%u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->val)
+);
+
 /*************************************************************
  *	     cfg80211 exported functions traces		     *
  *************************************************************/
@@ -4148,6 +4166,22 @@ TRACE_EVENT(rdev_assoc_ml_reconf,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG,
 		  __entry->add_links, __entry->rem_links)
 );
+
+TRACE_EVENT(cfg80211_epcs_changed,
+	TP_PROTO(struct wireless_dev *wdev, bool enabled),
+	TP_ARGS(wdev, enabled),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		__field(u32, enabled)
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		__entry->enabled = enabled;
+	),
+	TP_printk(WDEV_PR_FMT ", enabled=%u",
+		  WDEV_PR_ARG, __entry->enabled)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


