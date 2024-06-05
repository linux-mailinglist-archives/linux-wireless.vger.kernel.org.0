Return-Path: <linux-wireless+bounces-8533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0898FC98D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EE71C22CBF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9961192B8A;
	Wed,  5 Jun 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyiQcBQd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05ED192B87
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585060; cv=none; b=qe9e0MZgmUsmNm8JrAoS6y+qSM2T9350jLU+mY2EWuAFQm+E/bKkmFMd1gdLcGRq33bibjp8uDMKMUM1wIW3ob1/Dy5VMyxbXff1bczjJmgL3eIOqfsOrRJ/EIBsAySDdI973KJVwEO8NC/JKMuo9QfTftSu+Q6RAY/7lqBwgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585060; c=relaxed/simple;
	bh=SG3OxS/Jrm/vVcMinMy8x6zbXkjvoVXYuZCmHIT82YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OopfarPp/jCL5sJNakzJ7mfKjbceJCSWrItewyQtM4xrk4q3gdSSmptj0S6cziAeHe1gJc4T1Cs/zfgzsVL9W6qaJeTvJ4laPNxgc4whHs/zcW9slb1sDjZftyjgapUccA0PskPy9+gRP1OCBBaGOL1Im3aSq1oaivJVEK0nwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyiQcBQd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585059; x=1749121059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SG3OxS/Jrm/vVcMinMy8x6zbXkjvoVXYuZCmHIT82YU=;
  b=XyiQcBQd4JHkxiipU6+NBKRkiF0nb+AlwGHMWJE8QLe5+PbuZmSTHfv1
   FEUuRmpasWfAiG4gLMnoX2dx0Mj9MF/9twCTvCg/0e4HQRGiwSbSnsJgO
   GXTHhT5PmLK+Bc5WuS/hOYQYLOamSNZtkL8cZwFNeOpHiFEJkb4nWqwv5
   69Mc//k9LVFPWy3Q9S3wQZwj0ulFt7mMppoTF7IhUQM649NwAZXLPrJFC
   YVMW/29vZ7skNVt1mKhJx/8A/vGvTVMbxUjtgINDCrbdl7BGkta86YJ7W
   /N8qqIY7Jz6poPWEfvlX4SjlHNlomQQC3FkriytjF4sKo1vG30Je59Bsw
   g==;
X-CSE-ConnectionGUID: E7q2/1faR3erxCIah7Wrfw==
X-CSE-MsgGUID: DKDvEmUBTGiztLJ3WEXUyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919960"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919960"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:38 -0700
X-CSE-ConnectionGUID: k5HetlpzRRi/l8I0YsemWA==
X-CSE-MsgGUID: 8avh59+XRVK7Eb4KBV9uBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37563024"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Subject: [PATCH 6/7] wifi: cfg80211: Add support for interface usage notification
Date: Wed,  5 Jun 2024 13:57:21 +0300
Message-Id: <20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
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

In some cases, when an interface is added by user space, user space
might not know yet what is the intended type of the interface, e.g.,
before a P2P Group Ownership Negotiation (GON) an interface is added
but only at the end of the GON flow the final interface type is
determined. This doesn't allow the kernel drivers to prepare for the
actual interface type, e.g., make resources available for the
interface type etc.

Generally, adding an interface doesn't necessarily imply that it will
actually be used soon, and as described the interface might not be used
with the type it's added as.

This new API allows user space to indicate that it does indeed intend to
use the interface soon, along with the types (of which the interface
must be one) that may be selected for that usage. This will allow the
underlying driver to adjust resources accordingly.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Tested-by: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/wireless/nl80211.c       | 36 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 13 +++++++++++++
 net/wireless/trace.h         | 18 ++++++++++++++++++
 5 files changed, 95 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5da9bb0ac6a4..f2defbfd758e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4176,6 +4176,15 @@ struct mgmt_frame_regs {
 	u32 global_mcast_stypes, interface_mcast_stypes;
 };
 
+/**
+ * struct cfg80211_iface_usage - Notify about intended interface usage
+ *
+ * @types_mask: mask of interface types that are going to be used.
+ */
+struct cfg80211_iface_usage {
+	u32 types_mask;
+};
+
 /**
  * struct cfg80211_ops - backend description for wireless configuration
  *
@@ -4577,6 +4586,7 @@ struct mgmt_frame_regs {
  *
  * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
  * @set_ttlm: set the TID to link mapping.
+ * @iface_usage: notify about intended usage of added interfaces.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4938,6 +4948,8 @@ struct cfg80211_ops {
 				    struct cfg80211_set_hw_timestamp *hwts);
 	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ttlm_params *params);
+	void    (*iface_usage)(struct wiphy *wiphy, struct net_device *dev,
+			       struct cfg80211_iface_usage *usage);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f917bc6c9b6f..92dbbb0589f0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1329,6 +1329,15 @@
  *      %NL80211_ATTR_MLO_TTLM_ULINK attributes are used to specify the
  *      TID to Link mapping for downlink/uplink traffic.
  *
+ * @NL80211_CMD_IFACE_USAGE_NOTIF: Notify kernel about the expected interface
+ *      usage. Allows user space to indicate to the kernel that it intends to
+ *      use the interface soon and what is the expected usage of the interface
+ *      so resources could be prepared etc. This is useful in case an added
+ *      interface is not going to be used immediately but soon, and its type
+ *      might change. The %NL80211_ATTR_IFACE_USAGE_IFTYPES attribute is used to
+ *      provide the mask of intended interface types (the current type must be
+ *      included in the mask).
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1586,6 +1595,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_TID_TO_LINK_MAPPING,
 
+	NL80211_CMD_IFACE_USAGE_NOTIF,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2856,6 +2867,9 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_IFACE_USAGE_IFTYPES: a bitmask of interface types that might be
+ *      used with the interface.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3401,6 +3415,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_IFACE_USAGE_IFTYPES,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 296acd2a2a1b..04110b74547d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -825,6 +825,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
+
+	/* Set the limits to not allow NL80211_IFTYPE_UNSPECIFIED */
+	[NL80211_ATTR_IFACE_USAGE_IFTYPES] =
+		NLA_POLICY_RANGE(NLA_U32, BIT(NL80211_IFTYPE_UNSPECIFIED + 1),
+				 BIT(NUM_NL80211_IFTYPES) - 2),
 };
 
 /* policy for the key attributes */
@@ -16319,6 +16324,31 @@ nl80211_set_ttlm(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_ttlm(rdev, dev, &params);
 }
 
+static int
+nl80211_iface_usage(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_iface_usage iface_usage = {};
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+
+	/* once the interface is up and running its type can no longer change */
+	if (wdev_running(wdev))
+		return -EINVAL;
+
+	if (!info->attrs[NL80211_ATTR_IFACE_USAGE_IFTYPES])
+		return -EINVAL;
+
+	iface_usage.types_mask =
+		nla_get_u32(info->attrs[NL80211_ATTR_IFACE_USAGE_IFTYPES]);
+
+	if (!(BIT(wdev->iftype) & iface_usage.types_mask))
+		return -EINVAL;
+
+	rdev_iface_usage(rdev, dev, &iface_usage);
+	return 0;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -17511,6 +17541,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_IFACE_USAGE_NOTIF,
+		.doit = nl80211_iface_usage,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 43897a5269b6..0a13212d9c8d 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1542,4 +1542,17 @@ rdev_set_ttlm(struct cfg80211_registered_device *rdev,
 
 	return ret;
 }
+
+static inline void
+rdev_iface_usage(struct cfg80211_registered_device *rdev,
+		 struct net_device *dev,
+		 struct cfg80211_iface_usage *iface_usage)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+
+	trace_rdev_iface_usage(wiphy, dev, iface_usage);
+	if (rdev->ops->iface_usage)
+		rdev->ops->iface_usage(wiphy, dev, iface_usage);
+	trace_rdev_return_void(wiphy);
+}
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 14cfa0aba93a..2f5df52918cf 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3032,6 +3032,24 @@ TRACE_EVENT(rdev_set_ttlm,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG)
 );
 
+TRACE_EVENT(rdev_iface_usage,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_iface_usage *iface_usage),
+	TP_ARGS(wiphy, netdev, iface_usage),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(u32, types_mask)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->types_mask = iface_usage->types_mask;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", types_mask=0x%x",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->types_mask)
+);
+
 /*************************************************************
  *	     cfg80211 exported functions traces		     *
  *************************************************************/
-- 
2.34.1


