Return-Path: <linux-wireless+bounces-33393-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMuYArqdumngZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33393-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:42:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C92BBACD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23376303FA2F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CD93D75B5;
	Wed, 18 Mar 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJrgWgCw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF73D6CC8
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837591; cv=none; b=YDPe/HLdl1moZ5MENNBRhhdS/1E3vddzhirLO5ZZf1glGy/QhXC/N64N5EzVwwyihylzY3NzVyWRZ0hFfXfPWA4X+6UK5myasP0XLaFQSAjdFZb34nTMnO1B4fiQLRzS6IpPD6EhZH++X6Di+utYsjXM5WaXwxHSMinjCsp5gKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837591; c=relaxed/simple;
	bh=XXl0+p4ptGP4SCEI2vbmU3ApsgVPwxQNlKtWOxxb8+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zm4MHI2Hzg05tHAh/gUvwnykAoGUiADjxmBPexHq7eYdFffhnJkZV/3tzOWwcNSx/DGUGsg3Nx+U/MVncY6B9a9FSRhqK2I3qwBWAeg8NVQDsWzoIF3Jsn2y3GZbIh9uh5vQAs5fiBJYZKCTVJO4nhALLgz7TanWXhI7gQGzXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJrgWgCw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837590; x=1805373590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXl0+p4ptGP4SCEI2vbmU3ApsgVPwxQNlKtWOxxb8+M=;
  b=NJrgWgCwvUvR5Y7ijyhcDz37l147b84RuRABPHjiVQ469OPUoS29ldw3
   Uv4n+dQV4iso04C9Oobkv0VU+j+WGwtXehNA/WsM1/9fvUj8iRUaAmOSg
   X2PwQQEJDYlDztx7v/EjBaqbf0iLrrKotCcbZISG4bfGF0VHe5LifdE+H
   XWv9Kw4wxNz/JGyn5yb3ZmkkxoCD5Urd9FJDGo4ft5ieBnzuTqlc57D4z
   Gc/UF6Ww0+KxZ/qTzggb4bjHUNTXMuQ6ZLtBw9caQTHXobL63fBs7ekyI
   Z0eLia2Tb8Y52Wh1JKwpHUF2edv+BsqVREDJef9w+GeaiEINKCV/uW+Ax
   w==;
X-CSE-ConnectionGUID: er/Ha1pdRHOxs5dJ4BQBLw==
X-CSE-MsgGUID: b6Gfib2hQ3agcR/7yPOlkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519281"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:50 -0700
X-CSE-ConnectionGUID: q0W/mA42TYOpwbfeC9RSKw==
X-CSE-MsgGUID: t15w6gMXQWWbPN9tdN1brA==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 wireless-next 10/12] wifi: nl80211: Add a notification to notify NAN channel evacuation
Date: Wed, 18 Mar 2026 14:39:24 +0200
Message-Id: <20260318123926.206536-11-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33393-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 003C92BBACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Link: https://patch.msgid.link/20260219114327.d5bebfd5ff73.Iaaf5ef17e1ab7a38c19d60558e68fcf517e2b400@changeid
---
 include/net/cfg80211.h       | 19 ++++++++++++++
 include/uapi/linux/nl80211.h | 27 +++++++++++++++-----
 net/wireless/nl80211.c       | 48 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 18 ++++++++++++++
 4 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ee173f69c417..9d3639ff9c28 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10588,6 +10588,25 @@ void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
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
index 947ec7079484..3d55bf4be36f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1406,6 +1406,15 @@
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
@@ -1678,6 +1687,9 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_SET_PEER_SCHED,
 
 	NL80211_CMD_NAN_ULW_UPDATE,
+
+	NL80211_CMD_NAN_CHANNEL_EVAC,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -3040,20 +3052,23 @@ enum nl80211_commands {
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
index bf9df11553ef..0c4d6e8b45b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22936,6 +22936,54 @@ void cfg80211_nan_ulw_update(struct wireless_dev *wdev,
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
index 061bb84f1a48..eb5bedf9c92a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4363,6 +4363,24 @@ TRACE_EVENT(cfg80211_nan_ulw_update,
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


