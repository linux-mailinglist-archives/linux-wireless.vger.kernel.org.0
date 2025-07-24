Return-Path: <linux-wireless+bounces-25976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3FB10157
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A74D7B40C1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5577212E5B;
	Thu, 24 Jul 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k893Cx/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8282221736
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340898; cv=none; b=mT4MyL9ygmwA0NsQubvhNr8TP0Veq94dU/zh5EM+8YYxW7VimNuLezajh+Z6DHKCtzNfWML4kBjXQjkmvucdo6tUXSaUGneT1vnMIISYu7jkSxFON+DIq1lWkAS19+cX2Z3SFuE1qZ4B8wPRISCfdlT7gtnqTeo+6yUvmg8ddSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340898; c=relaxed/simple;
	bh=Qp1Fcebd3VrhL0mm4doDK1qeTKH+CE4Du1/OpafSjZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaHwaC3GjX45Em3SJY4a3IY/jUQ0h4xA+JowxL15bCjC+UiLv8rLlJ/xF7REDBqW6MxZD5alChwfvcTNo8yQHrQFcPGfeiorwLuXbRBnXejj2R5rMembCXFk3tNUS1r0C0InCkhToj1Gi6c7bGWbjefNEo/kmb8ysb8S5XMDl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k893Cx/3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753340897; x=1784876897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qp1Fcebd3VrhL0mm4doDK1qeTKH+CE4Du1/OpafSjZQ=;
  b=k893Cx/3pOPASEzV9ydZ4L7re1RiuoTpvOokPN1kqGCaDrW8TNvfOXx2
   Nv8NIAC7a2HuK7z+d1NvY0bQMiPZRQa0Bb1xVf85i4jktMmNYOhOSs2OU
   6tm2+aW5dMIltKb4WIcWv1AA1GSRtPQxVuoRro1VB8GyY4AAS+8pnIjCA
   ssBfEjmQ8LQW2nXbfpt6aWcZ0z/jum+azq2lDbtRRCKAn8vryrkKEAnQa
   yqofjSvHJ3IjgfCgRXUhzqgasK0YedxWN/+CFXKLCNkV6zY21O1tgAbks
   4ru6TzhkIBP0x/2p738MVuLzM8xo7k3sQq/DBkqNrD5xX1rqrx43PN625
   Q==;
X-CSE-ConnectionGUID: VirsPSPHQxGKzTOeL8CYSA==
X-CSE-MsgGUID: nMovuZnOSvqCD9oPFN6Ipg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55732693"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="55732693"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:08:16 -0700
X-CSE-ConnectionGUID: zCCPNwIyTKGkitqLcOITAQ==
X-CSE-MsgGUID: HxvYnq5OTlSDt/CilSSjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="165422681"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO aotchere-mobl1.intel.com) ([10.245.249.251])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:08:14 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	quic_vganneva@quicinc.com,
	maheshkkv@google.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v2 4/4] wifi: cfg80211: Add cluster joined notification API's
Date: Thu, 24 Jul 2025 13:04:57 +0300
Message-ID: <20250724100457.181825-5-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
References: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
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
 include/uapi/linux/nl80211.h |  9 +++++++-
 net/wireless/nl80211.c       | 43 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 18 +++++++++++++++
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 95edd5d3f205..800f4d9b166f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10036,6 +10036,20 @@ void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
 				struct ieee80211_channel *chan,
 				gfp_t gfp);
 
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
+				 u16 cluster_id, bool new_cluster,
+				 gfp_t gfp);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0bb7553ce293..f1ef3d284d38 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1356,6 +1356,9 @@
  *	Untransmitted multicast frames shall not be carried over to the next DW
  *	and should be dropped. This notification is only sent to the netlink
  *	socket owner (see %NL80211_ATTR_SOCKET_OWNER flag).
+ * @NL80211_CMD_NAN_CLUSTER_JOINED: This command is used to notify
+ *	userspace that the NAN new cluster has been joined. The cluster ID is
+ *	indicated by %NL80211_ATTR_MAC.
  *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
@@ -1618,7 +1621,7 @@ enum nl80211_commands {
 	NL80211_CMD_EPCS_CFG,
 
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
-
+	NL80211_CMD_NAN_CLUSTER_JOINED,
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2951,6 +2954,9 @@ enum nl80211_commands {
  *	This is used with %NL80211_CMD_GET_WIPHY to indicate the NAN
  *	capabilities supported by the driver. See &enum nl80211_nan_capabilities
  *	for details.
+ * @NL80211_ATTR_NAN_NEW_CLUSTER: Flag attribute indicating that a new
+ *	NAN cluster has been created. This is used with
+ *	%NL80211_CMD_NAN_CLUSTER_JOINED
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3516,6 +3522,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_NAN_CONFIG,
 	NL80211_ATTR_NAN_CAPABILITIES,
+	NL80211_ATTR_NAN_NEW_CLUSTER,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1af188f62788..aba1b4928a79 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21479,6 +21479,49 @@ void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
 }
 EXPORT_SYMBOL(cfg80211_next_nan_dw_notif);
 
+void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
+				 u16 cluster_id, bool new_cluster,
+				 gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+	u8 nan_cluster_addr[ETH_ALEN] = { 0x51, 0x6f, 0x9a, 0x01, 0x00, 0x00 };
+
+	nan_cluster_addr[5] = cluster_id & 0xff;
+	nan_cluster_addr[4] = (cluster_id >> 8) & 0xff;
+	trace_cfg80211_nan_cluster_joined(wdev, cluster_id, new_cluster);
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
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, nan_cluster_addr) ||
+	    (new_cluster && nla_put_flag(msg, NL80211_ATTR_NAN_NEW_CLUSTER)))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	if (!wdev->owner_nlportid)
+		genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy),
+					msg, 0, NL80211_MCGRP_NAN, gfp);
+	else
+		genlmsg_unicast(wiphy_net(&rdev->wiphy), msg,
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
index 2ed1b090d519..ef7c0d57ea29 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4238,6 +4238,24 @@ TRACE_EVENT(cfg80211_next_nan_dw_notif,
 		  WDEV_PR_ARG, CHAN_PR_ARG)
 );
 
+TRACE_EVENT(cfg80211_nan_cluster_joined,
+	TP_PROTO(struct wireless_dev *wdev,
+		 u16 cluster_id, bool new_cluster),
+	TP_ARGS(wdev, cluster_id, new_cluster),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		__field(u16, cluster_id)
+		__field(bool, new_cluster)
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		__entry->cluster_id = cluster_id;
+		__entry->new_cluster = new_cluster;
+	),
+	TP_printk(WDEV_PR_FMT " cluster_id 0x%04x %s",
+		  WDEV_PR_ARG, __entry->cluster_id,
+		  __entry->new_cluster ? "[new]" : "")
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.49.0


