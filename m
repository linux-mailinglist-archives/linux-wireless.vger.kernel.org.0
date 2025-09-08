Return-Path: <linux-wireless+bounces-27085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0432B48BE0
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D990C3B457F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42D2FC87A;
	Mon,  8 Sep 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gm/n3QbZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2762FAC0B
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330023; cv=none; b=UHYUi1Fvoh49N+scSOdulvI715eq0fkBKTjIrUYnzJiW1y5SqT6BDCczAbfQ4iOGxLfu6Jff/m86Yph9QRjGyK5kLvrk9cOhrqfkYCETbw7qwQp7BoYmHjQnSFA0mmyLuKR99S+bFfzShaQv7wErEgf12kxaG2qCPbOnzb5K524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330023; c=relaxed/simple;
	bh=GSqszsVfKIniue9DevnMXSm9sGC0UaVus5iPOJAIVGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SuYR2fcYb8H+2vABaxwpO6BxAOSR5Qpy1RisPcHWuRvOvDh/CRKAJC4LxMqsj1i182s3379WePBKL487FCp1orBD0oHxBoTnc/DOGR3QWP8EnHtRBS7O6QBAALNVu7iXIY45YwE31RUuWczpOP/TD+w7jY0LipIxyL5tVN4IM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gm/n3QbZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330022; x=1788866022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSqszsVfKIniue9DevnMXSm9sGC0UaVus5iPOJAIVGU=;
  b=gm/n3QbZnU5aaiEd0T9Or+sBcL9P8GmTP43ruujyzm1VHDEyD3Eag4Ja
   TAgfsX6tlLd4fim9xBxKDqp/3kq/2y0i81ZewAWty6TyVgIThVlm1i2XJ
   xrt+HU5rGvEX73GwU0VTEjHKw1Jx5vKahlf6E764hs6As18tASfoWliUu
   3e/DoTy9lyGuB652a1SHiRApp66IK7iF3HNhTVZtj7P6D9Qd7xac8xzm/
   +8dUyahLtEyp9AAyU2LqxsCIJwjodCtyq2T8IjPtQVqoqxZI0QWuuW0U3
   IzcSquXJcRVhLp4dKN99hlHzzcxGtxbDz+FqDuL44Ow5AuhEaXGc+XD9I
   A==;
X-CSE-ConnectionGUID: aEZHZDjFS/GYW3R7BnSlEQ==
X-CSE-MsgGUID: UlKNGULzSCORvW/jFn8iFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037882"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037882"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:41 -0700
X-CSE-ConnectionGUID: JB5Lt22xQaC7I6gm88z7oQ==
X-CSE-MsgGUID: x+bRMKKtTLivB0pwOF4Xtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126565"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH wireless-next 03/14] wifi: cfg80211: Add cluster joined notification APIs
Date: Mon,  8 Sep 2025 14:12:57 +0300
Message-Id: <20250908140015.ad27b7b6e4d9.I70b213a2a49f18d1ba2ad325e67e8eff51cc7a1f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

The drivers should notify upper layers and user space when a NAN device
joins a cluster. This is needed, for example, to set the correct addr3
in SDF frames. Add API to report cluster join event.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 14 ++++++++++++
 include/uapi/linux/nl80211.h |  8 +++++++
 net/wireless/nl80211.c       | 41 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 19 +++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0c1311d254be..1b10bd31bdd6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10074,6 +10074,20 @@ void cfg80211_epcs_changed(struct net_device *netdev, bool enabled);
 void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
 				struct ieee80211_channel *chan, gfp_t gfp);
 
+/**
+ * cfg80211_nan_cluster_joined - Notify about NAN cluster join
+ * @wdev: Pointer to the wireless device structure
+ * @cluster_id: Cluster ID of the NAN cluster that was joined or started
+ * @new_cluster: Indicates if this is a new cluster or an existing one
+ * @gfp: Memory allocation flags
+ *
+ * This function is used to notify user space when a NAN cluster has been
+ * joined, providing the cluster ID and a flag whether it is a new cluster.
+ */
+void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
+				 const u8 *cluster_id, bool new_cluster,
+				 gfp_t gfp);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d674608e2635..c5a7658b7297 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1357,6 +1357,9 @@
  *	the device/driver shall take care of the actual transmission timing.
  *	This notification is only sent to the NAN interface owning socket
  *	(see %NL80211_ATTR_SOCKET_OWNER flag).
+ * @NL80211_CMD_NAN_CLUSTER_JOINED: This command is used to notify
+ *	user space that the NAN new cluster has been joined. The cluster ID is
+ *	indicated by %NL80211_ATTR_MAC.
  *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
@@ -1619,6 +1622,7 @@ enum nl80211_commands {
 	NL80211_CMD_EPCS_CFG,
 
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
+	NL80211_CMD_NAN_CLUSTER_JOINED,
 
 	/* add new commands above here */
 
@@ -2957,6 +2961,9 @@ enum nl80211_commands {
  *	%NL80211_CMD_START_NAN and %NL80211_CMD_CHANGE_NAN_CONFIG.
  *	See &enum nl80211_nan_conf_attributes for details.
  *	This attribute is optional.
+ * @NL80211_ATTR_NAN_NEW_CLUSTER: Flag attribute indicating that a new
+ *	NAN cluster has been created. This is used with
+ *	%NL80211_CMD_NAN_CLUSTER_JOINED
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3521,6 +3528,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_SHORT_BEACON,
 	NL80211_ATTR_BSS_PARAM,
 	NL80211_ATTR_NAN_CONFIG,
+	NL80211_ATTR_NAN_NEW_CLUSTER,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 553d7426ee2b..2f93454de1da 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21808,6 +21808,47 @@ void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
 }
 EXPORT_SYMBOL(cfg80211_next_nan_dw_notif);
 
+void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
+				 const u8 *cluster_id, bool new_cluster,
+				 gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_nan_cluster_joined(wdev, cluster_id, new_cluster);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_NAN_CLUSTER_JOINED);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, cluster_id) ||
+	    (new_cluster && nla_put_flag(msg, NL80211_ATTR_NAN_NEW_CLUSTER)))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	if (!wdev->owner_nlportid)
+		genlmsg_multicast_netns(&nl80211_fam, wiphy_net(wiphy),
+					msg, 0, NL80211_MCGRP_NAN, gfp);
+	else
+		genlmsg_unicast(wiphy_net(wiphy), msg,
+				wdev->owner_nlportid);
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_nan_cluster_joined);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index ff47e9bffd4f..8a4c34112eb5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4182,6 +4182,25 @@ TRACE_EVENT(cfg80211_next_nan_dw_notif,
 		  WDEV_PR_ARG, CHAN_PR_ARG)
 );
 
+TRACE_EVENT(cfg80211_nan_cluster_joined,
+	TP_PROTO(struct wireless_dev *wdev,
+		 const u8 *cluster_id,
+		 bool new_cluster),
+	TP_ARGS(wdev, cluster_id, new_cluster),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		MAC_ENTRY(cluster_id)
+		__field(bool, new_cluster)
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		MAC_ASSIGN(cluster_id, cluster_id);
+		__entry->new_cluster = new_cluster;
+	),
+	TP_printk(WDEV_PR_FMT " cluster_id %pMF%s",
+		  WDEV_PR_ARG, __entry->cluster_id,
+		  __entry->new_cluster ? " [new]" : "")
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


