Return-Path: <linux-wireless+bounces-31945-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJXrLclXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31945-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:58:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06ED14BADD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E543300C6DE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A4F1C8634;
	Tue, 17 Feb 2026 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2KkkOwK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF753358CE
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329408; cv=none; b=lKfX1XI7lAu28LhvCBSaj6XR6n7O2KuN+S8uVwjGSEM7OFFo7dfGUfkoEMkAjFoC0tBxgBEaJVh79IPyy2WWJi213tTuUFBWqvUSxNyuj5JAu6tRB+CyeNrQCabMPchjTznU40x/tSpy3RiMTjOhZgYmR61PE5Pl+CZ5bgQIlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329408; c=relaxed/simple;
	bh=u3IVnLU2iWPQbIvbeGz20OD5/S9f+iARu+cvl3mI8wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKsPQFNVIl9wC0T4rFZlp217jRLh01O/FnuWI4VWrzjsiXo/jdsCqVIUHfmc90foXOXpxn89pMn0bysRqnquA8XxVQhxWg5njYN1vRvkfoLjoFfnpcSmpaQdp/VPhBgtcDlrjWNj/ToY9Snc2XIDZ1+l33E1XEI58+t8b3tnm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2KkkOwK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329407; x=1802865407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3IVnLU2iWPQbIvbeGz20OD5/S9f+iARu+cvl3mI8wo=;
  b=n2KkkOwKTxEfoD20O53lP15x2HL1kFgvKNsdOOGgQskqqd7pQRZ8fAbT
   LFbTy9efQ8ld1D+fn/AAW/FIh3m83tG1fqV0Ks3u8pPozE7KJCQsZPju6
   qxcJH9QFTqIzbLTJl+VWg0e7cFjRL+BAz2XLyyMztmHKhkA9rWnsTDmR4
   nqZtMvjDx7XboR/J7+KDG1cOsg1rGI/1xU5kc0DSV6wH8xvzX8ZIJA/zR
   WPzvQyONpCygPdK4IMWcmqFv77P+sx5W4pzGEYfCRbU5idkT9qApiVanM
   Ti8YJ/QeVmw1Pf7UGm9CuQdfMsOzZHykFSg9Y2oHEa19S67gsei20pekC
   A==;
X-CSE-ConnectionGUID: LL/K4fUPTlaVQ+ZrB28qLw==
X-CSE-MsgGUID: srBvxGWQQfOJPDqrmh9+7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495881"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495881"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:47 -0800
X-CSE-ConnectionGUID: HFJqi3VGSNi8F21Xzp4HWQ==
X-CSE-MsgGUID: Zx7scyZaQEKyL6FAd9E90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547160"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 wireless-next 14/15] wifi: nl80211: add NL80211_CMD_NAN_ULW_UPDATE notification
Date: Tue, 17 Feb 2026 13:56:17 +0200
Message-Id: <20260217134342.04128b1a58da.Ibdb6e33941afd94abf77245245f87e4338d729d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31945-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: E06ED14BADD
X-Rspamd-Action: no action

Add a new notification command that allows drivers to notify user space
when the device's ULW (Unaligned Schedule) blob has been updated. This
enables user space to attach the updated ULW blob to frames sent to NAN
peers.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 14 ++++++++++++
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       | 43 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 21 ++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0dee775ddbbc..f6143ef9e2d0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10572,6 +10572,20 @@ void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
 				 const u8 *cluster_id, bool new_cluster,
 				 gfp_t gfp);
 
+/**
+ * cfg80211_nan_ulw_update - Notify user space about ULW update
+ * @wdev: Pointer to the wireless device structure
+ * @ulw: Pointer to the ULW blob data
+ * @ulw_len: Length of the ULW blob in bytes
+ * @gfp: Memory allocation flags
+ *
+ * This function is used by drivers to notify user space when the device's
+ * ULW (Unaligned Schedule) blob has been updated. User space can use this
+ * blob to attach to frames sent to peers.
+ */
+void cfg80211_nan_ulw_update(struct wireless_dev *wdev,
+			     const u8 *ulw, size_t ulw_len, gfp_t gfp);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 838edc27e666..191bb2e9c7d9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1395,6 +1395,10 @@
  *	completely replace the previous one.
  *	The peer schedule is automatically removed when the NMI station is
  *	removed.
+ * @NL80211_CMD_NAN_ULW_UPDATE: Notification from the driver to user space
+ *	with the updated ULW blob of the device. User space can use this blob
+ *	to attach to frames sent to peers. This notification contains
+ *	%NL80211_ATTR_NAN_ULW with the ULW blob.
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1664,6 +1668,7 @@ enum nl80211_commands {
 
 	NL80211_CMD_NAN_SET_PEER_SCHED,
 
+	NL80211_CMD_NAN_ULW_UPDATE,
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7a22980aa7f0..1c885d9c578d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22780,6 +22780,49 @@ void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
 }
 EXPORT_SYMBOL(cfg80211_nan_cluster_joined);
 
+void cfg80211_nan_ulw_update(struct wireless_dev *wdev,
+			     const u8 *ulw, size_t ulw_len, gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_nan_ulw_update(wiphy, wdev, ulw, ulw_len);
+
+	if (!wdev->owner_nlportid)
+		return;
+
+	/* 32 for the wiphy idx, 64 for the wdev id, 100 for padding */
+	msg = nlmsg_new(nla_total_size(sizeof(u32)) +
+			nla_total_size(ulw_len) +
+			nla_total_size(sizeof(u64)) + 100,
+			gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_NAN_ULW_UPDATE);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    (ulw && ulw_len &&
+	     nla_put(msg, NL80211_ATTR_NAN_ULW, ulw_len, ulw)))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_unicast(wiphy_net(wiphy), msg, wdev->owner_nlportid);
+
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_nan_ulw_update);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 55db53fb4c5d..5ed551412119 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4323,6 +4323,27 @@ TRACE_EVENT(cfg80211_nan_sched_update_done,
 	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT " success=%d",
 		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->success)
 );
+
+TRACE_EVENT(cfg80211_nan_ulw_update,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 const u8 *ulw, size_t ulw_len),
+	TP_ARGS(wiphy, wdev, ulw, ulw_len),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__dynamic_array(u8, ulw, ulw_len)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		if (ulw && ulw_len)
+			memcpy(__get_dynamic_array(ulw), ulw, ulw_len);
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT " ulw: %s",
+		  WIPHY_PR_ARG, WDEV_PR_ARG,
+		  __print_array(__get_dynamic_array(ulw),
+				__get_dynamic_array_len(ulw), 1))
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


