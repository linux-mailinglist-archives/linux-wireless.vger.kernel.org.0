Return-Path: <linux-wireless+bounces-26359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A404B2481C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D8C7B27FE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2F2F1FC1;
	Wed, 13 Aug 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwVpXf8l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E712F6591
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083529; cv=none; b=mbvM5jcs1/HsmmKsaHCEtCRruCG7mYHSVhS0yZSDxV8kO5d/ChmMqXIaaWkhwpYm7CxTawd8N8d2CdcNalhjoycEPSfanukULkm7fNNPbAHUC2m/rFjb3ryLcaqFyKNV2N0jl5fxcaS00KA7wQJLwYV3/3y+KUNfWAcVHfDfjw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083529; c=relaxed/simple;
	bh=r7ir2xlQBbDyJBjAvEDu8ctJzcAU/Wo/x2+m5Z8HYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IASQO8ETYdGEE/uOSITlLOiG8ZOri/cAjp2qPuhKg7YF6LEKHG9JWeCTcJq2vgU3DjNBte4nbYbRlp2HncT4q149YfRbBwtOsjGoH6bwvZmD0CPWP86EVY1NvLgaiAA+3YiEKQOGmiQ8BCOB7fFbpWoh0eB4gzkW15qUxC8yZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwVpXf8l; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755083528; x=1786619528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r7ir2xlQBbDyJBjAvEDu8ctJzcAU/Wo/x2+m5Z8HYMA=;
  b=LwVpXf8lpqV9uBW8UIjb53vClYxGgvsseXMODhPHZRYJdb2+1hDyDeIH
   /4y5pdTagtY/I0cngWdHnfCMcxa7f5oC+jIpj3FVRDwkpbhqKlTH5cwE2
   hrszJWw03bFYlR686VbZjdY5WqG1TAxysTVJ48g3zVKfwLCXMZFnwSr6W
   nEL8FsUDnar5/FH/kbJD2hxPHOPZDIBZnsltdjmkAsJhlWVA20D8QCREk
   kaysCNC/Eq/95mnTzKUdjz7wQqb6ryj5W6b3VaYjhx9eTlCF8DmeQh+7c
   2yuIMH8Pjkcv/BGGuW7aWOcuGi/toCqfAcDR/3JlKUmbWI5vEasij8ped
   w==;
X-CSE-ConnectionGUID: 5HcbbB/MQUK2bmHLipxvOA==
X-CSE-MsgGUID: 3CdAY1xeQtK0G601w5yUYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74951206"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74951206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:12:08 -0700
X-CSE-ConnectionGUID: h26EWaj2Qpa35w64BiURbg==
X-CSE-MsgGUID: TCvwUXevShGxIPH5OUvgug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165628952"
Received: from aotchere-mobl1.jer.intel.com ([10.13.73.232])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:12:05 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	maheshkkv@google.com,
	quic_vganneva@quicinc.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v3 3/4] wifi: cfg80211: Add cluster joined notification APIs
Date: Wed, 13 Aug 2025 17:10:47 +0300
Message-ID: <20250813141048.100884-4-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813141048.100884-1-andrei.otcheretianski@intel.com>
References: <20250813141048.100884-1-andrei.otcheretianski@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drivers should notify upper layers and user space when a NAN device
joins a cluster. This is needed, for example, to set the correct addr3
in SDF frames. Add API to report cluster join event.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/net/cfg80211.h       | 14 ++++++++++++
 include/uapi/linux/nl80211.h |  8 +++++++
 net/wireless/nl80211.c       | 41 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 19 +++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0556dd6718dc..2f054e8a1cc2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10047,6 +10047,20 @@ void cfg80211_epcs_changed(struct net_device *netdev, bool enabled);
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
index 3b9c9f2a7d27..0a5915b33705 100644
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
 
@@ -2949,6 +2953,9 @@ enum nl80211_commands {
  *	%NL80211_CMD_START_NAN and %NL80211_CMD_CHANGE_NAN_CONFIG.
  *	See &enum nl80211_nan_conf_attributes for details.
  *	This attribute is optional.
+ * @NL80211_ATTR_NAN_NEW_CLUSTER: Flag attribute indicating that a new
+ *	NAN cluster has been created. This is used with
+ *	%NL80211_CMD_NAN_CLUSTER_JOINED
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3513,6 +3520,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_SHORT_BEACON,
 
 	NL80211_ATTR_NAN_CONFIG,
+	NL80211_ATTR_NAN_NEW_CLUSTER,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6b77d9c7a901..2ffc3cd6edb9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21521,6 +21521,47 @@ void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
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
index 2ed1b090d519..2173741c9a62 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4238,6 +4238,25 @@ TRACE_EVENT(cfg80211_next_nan_dw_notif,
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
2.47.1


