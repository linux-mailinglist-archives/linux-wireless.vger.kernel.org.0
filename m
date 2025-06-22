Return-Path: <linux-wireless+bounces-24327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F0AE32CC
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 00:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE283B0DF9
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5E219E8C;
	Sun, 22 Jun 2025 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7cve9zj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AD6136
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631163; cv=none; b=IOAvqvlAuHxV+pQeLPxF1iokEqw8U4sPkDOPEdGZJjcEY8mpYZtDt5Hz1w6Nx3YP0WtUZ/BFW9NDh9BELOxvPKWmL4tYvPR11TEtf0TyoHXV2n5SKaT8jRnoRBDMIYEMAjIZxQ8HtTks1+kK77f3+5aiOXtG+g04xwQ0QCFrn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631163; c=relaxed/simple;
	bh=SEoEqatTeW6Q36yIPcmWPbXVgCoYFMgUxZ1N2JQVdzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg0ROaO2xnbGTsQ10rvFjhKT6dQ+e69bUMAZx1cBWbQsnxvwJCzXx9Va/o29REzb1P0exQqRm968j0A2P7JMfBCjGDAxj51GxoCoVzXBAsK5u84fiVX8ZZvoO+bQYeJCwynNjnPONQkyK9ZjDFmAAupKBCLppzjcs+O/TFCJKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7cve9zj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750631163; x=1782167163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SEoEqatTeW6Q36yIPcmWPbXVgCoYFMgUxZ1N2JQVdzc=;
  b=H7cve9zj+0r652B3Jt13MW30iPCHGECBd1sWVwj+4p3y0aNB1j7Plebe
   pKO3ac2oxfZK+C1fWr/w0uhSv1Uy4iqRtVGh6Mvbtbe0+5hPx16DbXzoA
   jqQ15Lvkvha30LTWl5YrSqW4+kTv1/8WXX97lOcAgnAbbjET6Zl8I7rQ6
   Udcu09oreRTVhQ/UC+RXl7OzAoTbFnYk9hsfLAzeGjO2Gaa6o4PkZzEyx
   LAeET5CDJc1+OL2sGrRw8CQpNo5kBVx3BC9EpL5RZYAImRgUjhP4SvHyG
   YnTbencsua6Nss7JiYLvb/YDUh+fcxMab+g0gHt9CFK7l4Ovsc/MFDzas
   A==;
X-CSE-ConnectionGUID: 9hK6qrkmQ926EOB1tNa0uQ==
X-CSE-MsgGUID: DfxGWxrCTlGt5xUapWCQ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52916087"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52916087"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:26:02 -0700
X-CSE-ConnectionGUID: YrGxTH/aT7ihHxtsUlLaww==
X-CSE-MsgGUID: e0YNJct2SDatoZ4eBwpcEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="182295775"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.248.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:26:00 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC 5/5] wifi: cfg80211: Add cluster joined notification API's
Date: Mon, 23 Jun 2025 01:24:44 +0300
Message-ID: <20250622222444.356435-6-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
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
index 27a3b8795d9b..93516ea07f7c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9881,6 +9881,20 @@ void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
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
index 134cea046bd0..d883f4a639e8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1351,6 +1351,9 @@
  *	userspace about the next Discovery Window (DW). Userspace may use it
  *	to prepare frames to be sent in the next DW. %NL80211_ATTR_WIPHY_FREQ
  *	is used to indicate the frequency of the next DW.
+ * @NL80211_CMD_NAN_CLUSTER_JOINED: This command is used to notify
+ * 	userspace that the NAN new cluster has been joined. The cluster ID is
+ *	indicated by %NL80211_ATTR_MAC.
  *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
@@ -1613,7 +1616,7 @@ enum nl80211_commands {
 	NL80211_CMD_EPCS_CFG,
 
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
-
+	NL80211_CMD_NAN_CLUSTER_JOINED,
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2926,6 +2929,9 @@ enum nl80211_commands {
  *	This is used with %NL80211_CMD_GET_WIPHY to indicate the NAN
  *	capabilities supported by the driver. See &enum nl80211_nan_capabilities
  *	for details.
+ * @NL80211_ATTR_NAN_NEW_CLUSTER: Flag attribute indicating that a new
+ *	NAN cluster has been created. This is used with
+ *	%NL80211_CMD_NAN_CLUSTER_JOINED
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3486,6 +3492,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_NAN_CONFIG,
 	NL80211_ATTR_NAN_CAPABILITIES,
+	NL80211_ATTR_NAN_NEW_CLUSTER,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5936ec1557fe..f979fc1b504a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20864,6 +20864,49 @@ void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
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
+				NL80211_ATTR_PAD) ||
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
index bf84e6abaf69..deafd0b4f94c 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4203,6 +4203,24 @@ TRACE_EVENT(cfg80211_next_nan_dw_notif,
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


