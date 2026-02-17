Return-Path: <linux-wireless+bounces-31946-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFjgMMdXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31946-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECED14BAD6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 779B5303A841
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2A3358C0;
	Tue, 17 Feb 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/KukgK+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27693358C4
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329409; cv=none; b=ABeRbMzsObons5Iu4e1EP7iDR/x0vAIWH566w6v/1s06h7vZjuP1Nt5Hmg7S7KNdR3PKXoSW6P2sLBlbq9f9/So1gVEuw+eI6AODISDbpe3nYu/5ON8sm1rI8oL/vtIRYYGC8QkO9DchJ7553MdlWv2OMKXsx5uFz41rTJTycrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329409; c=relaxed/simple;
	bh=4SZAMHPcjskXnr2tool6hAIM8DP5qxSRoilhDPGUbvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDh+3hMq/i8SJFA15hvZu93ufmBZvcDcN3mGbIBp8o6gN5nSjwCdf2U2Sk98OW0I2TmgBJ5ItzCBHpja6b40nefqMtttaU8a2tpTpR85aSvtPMqWff27L+u52p4EFyFO9rtLWwA+mdha0RphHzRMB1sqcrJbFwRCAJhDCMMYlok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/KukgK+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329408; x=1802865408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4SZAMHPcjskXnr2tool6hAIM8DP5qxSRoilhDPGUbvw=;
  b=X/KukgK+3QAxOdEbm3MY4xcVrrJCb0Glu+yWBdpaBp7buDHWa8wCZXcc
   US01jYKI+r8rWcco7TbAOKKqm0o/gikrGSUx5nHyikP2K8KgJVwwqSahy
   LImS2PMPh/7PoBEFLcqA2SwTTnr9na7kXa1I7WmG1Pa8uuuv6yMQqoatu
   Jkj1g56yzWc/HOfl303wi42ix4K0dheBZp7lSI0167/+1945sSZHN+OgR
   vKndgb3C9ppiyMahF7U++5IZol8F70UnI0EgkfJx68YmOndiP9BjdSBez
   oslXfPSKDfRbqp2IsITpxvqtCkht8Oer3IH9UhaTpMv3W45kI+EgUmeTG
   w==;
X-CSE-ConnectionGUID: cDQKcIKkQxCGtLn1tBiIsQ==
X-CSE-MsgGUID: L3oTz8CwSNexHdeLrPuV3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495882"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495882"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:48 -0800
X-CSE-ConnectionGUID: oA9eZzwXQbCSgLkHBQpzVg==
X-CSE-MsgGUID: W0Msuk0mR/qJy7Xk+xhdVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547165"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 wireless-next 15/15] wifi: nl80211: Add a notification to notify NAN channel evacuation
Date: Tue, 17 Feb 2026 13:56:18 +0200
Message-Id: <20260217134342.d1e4b5db853d.Iaaf5ef17e1ab7a38c19d60558e68fcf517e2b400@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31946-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ECED14BAD6
X-Rspamd-Action: no action

If all available channel resources are used for NAN channels, and one of
them is shared with another interface, and that interface needs to move
to a different channel (for example STA interface that needs to do a
channel or a link switch), then the driver can evacuate one of the NAN
channels (i.e. detach it from its channel resource and announce to the
peers that this channel is ULWed). In that case, the driver needs to
notify user space about the channel evacuation, so the user space can
adjust the local schedule accordingly.

Add a notification to let userspace know about it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 19 ++++++++++++++
 include/uapi/linux/nl80211.h | 27 +++++++++++++++-----
 net/wireless/nl80211.c       | 48 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 18 ++++++++++++++
 4 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f6143ef9e2d0..620869db2cc9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10586,6 +10586,25 @@ void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
 void cfg80211_nan_ulw_update(struct wireless_dev *wdev,
 			     const u8 *ulw, size_t ulw_len, gfp_t gfp);
 
+/**
+ * cfg80211_nan_channel_evac - Notify user space about NAN channel evacuation
+ * @wdev: Pointer to the wireless device structure
+ * @chandef: Pointer to the channel definition of the NAN channel that was
+ *	evacuated
+ * @gfp: Memory allocation flags
+ *
+ * This function is used by drivers to notify user space when a NAN
+ * channel has been evacuated (i.e. ULWed) due to channel resource conflicts
+ * with other interfaces.
+ * This can happen when another interface sharing the channel resource with NAN
+ * needs to move to a different channel (e.g. due to channel switch or link
+ * switch). User space may reconfigure the local schedule to exclude the
+ * evacuated channel.
+ */
+void cfg80211_nan_channel_evac(struct wireless_dev *wdev,
+			       const struct cfg80211_chan_def *chandef,
+			       gfp_t gfp);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 191bb2e9c7d9..d7baf3ca751c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1399,6 +1399,15 @@
  *	with the updated ULW blob of the device. User space can use this blob
  *	to attach to frames sent to peers. This notification contains
  *	%NL80211_ATTR_NAN_ULW with the ULW blob.
+ * @NL80211_CMD_NAN_CHANNEL_EVAC: Notification to indicate that a NAN
+ *	channel has been evacuated due to resource conflicts with other
+ *	interfaces. This can happen when another interface sharing the channel
+ *	resource with NAN needs to move to a different channel (e.g., channel
+ *	switch or link switch on a BSS interface).
+ *	The notification contains %NL80211_ATTR_NAN_CHANNEL attribute
+ *	identifying the evacuated channel.
+ *	User space may reconfigure the local schedule in response to this
+ *	notification.
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1669,6 +1678,9 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_SET_PEER_SCHED,
 
 	NL80211_CMD_NAN_ULW_UPDATE,
+
+	NL80211_CMD_NAN_CHANNEL_EVAC,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -3031,20 +3043,23 @@ enum nl80211_commands {
  *	Currently only supported in mac80211 drivers.
  * @NL80211_ATTR_NAN_CHANNEL: This is a nested attribute. There can be multiple
  *	attributes of this type, each one represents a channel definition and
- *	consists of top-level attributes like %NL80211_ATTR_WIPHY_FREQ. Must
- *	contain %NL80211_ATTR_NAN_CHANNEL_ENTRY and
- *	%NL80211_ATTR_NAN_RX_NSS.
- *	This attribute is used with %NL80211_CMD_NAN_SET_LOCAL_SCHED to specify
+ *	consists of top-level attributes like %NL80211_ATTR_WIPHY_FREQ.
+ *	When used with %NL80211_CMD_NAN_SET_LOCAL_SCHED, it specifies
  *	the channel definitions on which the radio needs to operate during
  *	specific time slots. All of the channel definitions should be mutually
- *	incompatible.
- *	This is also used with %NL80211_CMD_NAN_SET_PEER_SCHED to configure the
+ *	incompatible. With this command, %NL80211_ATTR_NAN_CHANNEL_ENTRY and
+ *	%NL80211_ATTR_NAN_RX_NSS are mandatory.
+ *	When used with %NL80211_CMD_NAN_SET_PEER_SCHED, it configures the
  *	peer NAN channels. In that case, the channel definitions can be
  *	compatible to each other, or even identical just with different RX NSS.
+ *	With this command, %NL80211_ATTR_NAN_CHANNEL_ENTRY and
+ *	%NL80211_ATTR_NAN_RX_NSS are mandatory.
  *	The number of channels should fit the current configuration of channels
  *	and the possible interface combinations.
  *	If an existing NAN channel is changed but the chandef isn't, the
  *	channel entry must also remain unchanged.
+ *	When used with %NL80211_CMD_NAN_CHANNEL_EVAC, this identifies the
+ *	channels that were evacuated.
  * @NL80211_ATTR_NAN_CHANNEL_ENTRY: a byte array of 6 bytes. contains the
  *	Channel Entry as defined in Wi-Fi Aware (TM) 4.0 specification Table
  *	100 (Channel Entry format for the NAN Availability attribute).
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1c885d9c578d..b51f0676d7cc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22823,6 +22823,54 @@ void cfg80211_nan_ulw_update(struct wireless_dev *wdev,
 }
 EXPORT_SYMBOL(cfg80211_nan_ulw_update);
 
+void cfg80211_nan_channel_evac(struct wireless_dev *wdev,
+			       const struct cfg80211_chan_def *chandef,
+			       gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	struct nlattr *chan_attr;
+	void *hdr;
+
+	trace_cfg80211_nan_channel_evac(wiphy, wdev, chandef);
+
+	if (!wdev->owner_nlportid)
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_NAN_CHANNEL_EVAC);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD))
+		goto nla_put_failure;
+
+	chan_attr = nla_nest_start(msg, NL80211_ATTR_NAN_CHANNEL);
+	if (!chan_attr)
+		goto nla_put_failure;
+
+	if (nl80211_send_chandef(msg, chandef))
+		goto nla_put_failure;
+
+	nla_nest_end(msg, chan_attr);
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
+EXPORT_SYMBOL(cfg80211_nan_channel_evac);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 5ed551412119..0ff5779d2c7e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4344,6 +4344,24 @@ TRACE_EVENT(cfg80211_nan_ulw_update,
 		  __print_array(__get_dynamic_array(ulw),
 				__get_dynamic_array_len(ulw), 1))
 );
+
+TRACE_EVENT(cfg80211_nan_channel_evac,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 const struct cfg80211_chan_def *chandef),
+	TP_ARGS(wiphy, wdev, chandef),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		WIPHY_ENTRY
+		CHAN_DEF_ENTRY
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		WIPHY_ASSIGN;
+		CHAN_DEF_ASSIGN(chandef);
+	),
+	TP_printk(WDEV_PR_FMT ", " WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
+		  WDEV_PR_ARG, WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


