Return-Path: <linux-wireless+bounces-33392-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFjoF2WdummHZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33392-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:41:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E146C2BBA5A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24DDA30185E0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE483D6CAF;
	Wed, 18 Mar 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imHIIPqF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68243D75A7
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837590; cv=none; b=O0+gPf9b+dV90Rs/6tgmfI7tUI6dVI46CCSafUL/7r9OA7sU90GnntSCjiqKjQ4Nx4lwEoFx3zIy5jOTiEnMIlsudeLa5i9oZe0EMAeK86PAOG8u45BKCs4tek1UsBN7BmW4+kOylq3GKSX+MnWAoIJ2BmFXjT1GyA0Qk7/6lCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837590; c=relaxed/simple;
	bh=C6D1fHLGTsMcVtNffGEGQLFC8ML7zs8Dcum6dBLqjTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9vPEotIKYybLSpSVXP9i1lymWGmwQm8B5+f5qVQhrWLhYyWM+lnOkMySHFU4mQf3kKqpCYnfx/60luwRlW6b4Qalh6RZNKHe8CDuKnCjdOCIkHiekwtRZizHEhhX21TCFXsxAEm1niu4FVFbKgQFHE74em+1MFtucPJgOJkf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imHIIPqF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837589; x=1805373589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C6D1fHLGTsMcVtNffGEGQLFC8ML7zs8Dcum6dBLqjTo=;
  b=imHIIPqFjiU7eFy0wsvhrPo/t7GD/hZXjHVy8RQ0xsRBfSB7BnYg1rO2
   slfym597kJPoNRt0mhtH4OIMOCLwCUQMKC4qM42Eoqlua5EtT+iTMKc7+
   s5wSbzxuGZgzd8lZHHfxeDoT/bg6K4Znc8gnXtOi+khzQJE4k7x/xIoSd
   QPxXtWXNGQCweAKSInQP1Yl2C4/HtYbG4fi/4BCGMBpZwOIzZyQrNKsLA
   61Irqy7XHmmKGIcDCF+sSa4KfpOdDtJAUw/79r+4YUxQOgmw/7N9zqPJD
   eAjU810SK0YtUvcbjMPKeRRyO5xWsWsdTQYb7btMfKF1IRSLeO01TDnQq
   g==;
X-CSE-ConnectionGUID: orqAqXODQbOnBAkQwvsg6g==
X-CSE-MsgGUID: qhQQVcKiRxqOXLwK3QU7Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519278"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519278"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:49 -0700
X-CSE-ConnectionGUID: fzs0xaNaQpGxs9CoC7BqqQ==
X-CSE-MsgGUID: +gS/JK2ZRuKphgJywQiVOQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 wireless-next 09/12] wifi: nl80211: add NL80211_CMD_NAN_ULW_UPDATE notification
Date: Wed, 18 Mar 2026 14:39:23 +0200
Message-Id: <20260318123926.206536-10-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
References: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33392-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E146C2BBA5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new notification command that allows drivers to notify user space
when the device's ULW (Unaligned Schedule) blob has been updated. This
enables user space to attach the updated ULW blob to frames sent to NAN
peers.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260219114327.32b715af4ebb.Ibdb6e33941afd94abf77245245f87e4338d729d3@changeid
---
 include/net/cfg80211.h       | 14 ++++++++++++
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       | 43 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 21 ++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0d19f34ea7ac..ee173f69c417 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10574,6 +10574,20 @@ void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
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
index cf6f1f6b9e36..947ec7079484 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1402,6 +1402,10 @@
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
@@ -1673,6 +1677,7 @@ enum nl80211_commands {
 
 	NL80211_CMD_NAN_SET_PEER_SCHED,
 
+	NL80211_CMD_NAN_ULW_UPDATE,
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e162b0a3c2a6..bf9df11553ef 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22893,6 +22893,49 @@ void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
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
index df639d97cc0c..061bb84f1a48 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4342,6 +4342,27 @@ TRACE_EVENT(cfg80211_nan_sched_update_done,
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


