Return-Path: <linux-wireless+bounces-26358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05063B2481B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE33B8823FD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F482F6570;
	Wed, 13 Aug 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnveBCG6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFA2F1FC1
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083525; cv=none; b=klhlV+SWBp/sPdk1YU/P8TjdATnPrbjMqu/HHwCB8M0BMHJYlp8TaovxmQDUHlksHeRu+MCvpCS1YpQaQCQUd8enLiVIBLVIrQUj2Gd5smsBib6Kblh24zkBQXjc5/S3pb8FFFUlWx28lnzWVSLcfqWLQbFWmFKnzDzDyK4EMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083525; c=relaxed/simple;
	bh=ZRQhY65XdbEoKjRU46Goc9zC9eCtkIrka6/AgRdYM0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWxY/guHxDPJjK3vm25m2GXgy2IpziZCHFeWUuYpdaCJxOnh6rucaNKSeQR7RhtbJktjPZP4B2KbUhyeJPRA9C9+FGr7AixImoXf5sTR10o3ayrvprKbM2uFJ7dQawaJeqqZbbme2/Ct6yKL1J2+SkEDritmRFoX4tfbGowPKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnveBCG6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755083524; x=1786619524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZRQhY65XdbEoKjRU46Goc9zC9eCtkIrka6/AgRdYM0k=;
  b=YnveBCG6Y5qnYH84c7gougpczszzaDKXJdu+g5+nDskUuRiwet4I3yYv
   Eblqdo3ZFTpwCGXNeFCOL6ZgGgWiVN1nzdiHNtCqLqQxf5iFTpjcQw0G6
   qZLRkDtJvd7kd0PIdj+a9au2aZ2lNV13Q4nOxSxEzruisJn4rCa+F/VXf
   /th4xY/u+8+2oKqf3uDpS8HcZHjcanQpzFNIO6bM2tYlPqxI8SVq0+MQ1
   qaYnY3zsXVV0nQIOCJ15qXiWj98lJsvKvB0b/gE67MdwOGYCfECGUZ2f4
   5AcseDsS2tjckbk0t80/CWY4yjyYNt12arcrTZbQhz+Q/TEFoh1Z0xNx5
   A==;
X-CSE-ConnectionGUID: 58x9Cc1tTIiYCNZGd7FrfA==
X-CSE-MsgGUID: Fc7T++/zQt2Sbc9aPGd4rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74951193"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74951193"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:12:04 -0700
X-CSE-ConnectionGUID: S0gG4Wc7Rc+XRQcRRgJ8Ow==
X-CSE-MsgGUID: SR3A2o4XReGeAncsF5ItHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165628942"
Received: from aotchere-mobl1.jer.intel.com ([10.13.73.232])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:12:01 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	maheshkkv@google.com,
	quic_vganneva@quicinc.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v3 2/4] wifi: nl80211: Add NAN Discovery Window (DW) notification
Date: Wed, 13 Aug 2025 17:10:46 +0300
Message-ID: <20250813141048.100884-3-andrei.otcheretianski@intel.com>
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

This notification will be used by the device to inform user space
about upcoming DW. When received, user space will be able to prepare
multicast Service Discovery Frames (SDFs) to be transmitted during the
next DW using %NL80211_CMD_FRAME command on the NAN management interface.
The device/driver will take care to transmit the frames in the correct
timing. This allows to implement a synchronized Discovery Engine (DE)
in user space, if the device doesn't support DE offload.
Note that this notification can be sent before the actual DW starts as
long as the driver/device handles the actual timing of the SDF
transmission.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/net/cfg80211.h       | 17 ++++++++++++
 include/uapi/linux/nl80211.h | 23 +++++++++++++++++
 net/wireless/nl80211.c       | 50 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 16 ++++++++++++
 4 files changed, 106 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e53a4ed48c58..0556dd6718dc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3933,6 +3933,12 @@ struct cfg80211_nan_band_config {
  * @scan_period: period (in seconds) between NAN scans.
  * @scan_dwell_time: dwell time (in milliseconds) for NAN scans.
  * @discovery_beacon_interval: interval (in TUs) for discovery beacons.
+ * @enable_dw_notification: flag to enable/disable discovery window
+ *	notifications.
+ * @dw_lead_time: anticipated host processing time in TUs to process DW
+ *	notifications. This is an optional parameter, zero value means
+ *	'unknown'. The device may use this value to adjust DW notification
+ *	timing. Max allowed value is 496 TUs.
  * @band_cfgs: array of band specific configurations, indexed by
  *	&enum nl80211_band values.
  * @extra_nan_attrs: pointer to additional NAN attributes.
@@ -3947,6 +3953,8 @@ struct cfg80211_nan_conf {
 	u16 scan_period;
 	u16 scan_dwell_time;
 	u8 discovery_beacon_interval;
+	bool enable_dw_notification;
+	u16 dw_lead_time;
 	struct cfg80211_nan_band_config band_cfgs[NUM_NL80211_BANDS];
 	const u8 *extra_nan_attrs;
 	u16 extra_nan_attrs_len;
@@ -10030,6 +10038,15 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
  */
 void cfg80211_epcs_changed(struct net_device *netdev, bool enabled);
 
+/**
+ * cfg80211_next_nan_dw_notif - Notify about the next NAN Discovery Window (DW)
+ * @wdev: Pointer to the wireless device structure
+ * @chan: DW channel (6, 44 or 149)
+ * @gfp: Memory allocation flags
+ */
+void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
+				struct ieee80211_channel *chan, gfp_t gfp);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9c84f44deadd..3b9c9f2a7d27 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1349,6 +1349,15 @@
  *	control EPCS configuration. Used to notify userland on the current state
  *	of EPCS.
  *
+ * @NL80211_CMD_NAN_NEXT_DW_NOTIFICATION: This command is used to notify
+ *	user space about the next NAN Discovery Window (DW). User space may use
+ *	it to prepare frames to be sent in the next DW.
+ *	%NL80211_ATTR_WIPHY_FREQ is used to indicate the frequency of the next
+ *	DW. SDF transmission should be requested with %NL80211_CMD_FRAME and
+ *	the device/driver shall take care of the actual transmission timing.
+ *	This notification is only sent to the NAN interface owning socket
+ *	(see %NL80211_ATTR_SOCKET_OWNER flag).
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1609,6 +1618,8 @@ enum nl80211_commands {
 	NL80211_CMD_ASSOC_MLO_RECONF,
 	NL80211_CMD_EPCS_CFG,
 
+	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -7365,6 +7376,16 @@ enum nl80211_nan_band_conf_attributes {
  * @NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL: Discovery beacon interval
  *	in TUs. Valid range is 50-200 TUs. If not configured the device default
  *	value is used. This is u8 (optional)
+ * @NL80211_NAN_CONF_NOTIFY_DW: If set, the driver will notify userspace about
+ *	the upcoming discovery window with
+ *	%NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.
+ *	This is a flag attribute.
+ * @NL80211_NAN_CONF_DW_LEAD_TIME: Anticipated time in TUs it takes
+ *	the host to process %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.
+ *	The device may use this value to adjust the timing of the notification.
+ *	This is an optional u16 attribute. Maximum allowed value is 496 TUs.
+ *	If set to zero or the attriubute is not present, it means that such
+ *	information is not available.
  * @NUM_NL80211_NAN_CONF_ATTR: Internal.
  * @NL80211_NAN_CONF_ATTR_MAX: Highest NAN configuration attribute.
  *
@@ -7379,6 +7400,8 @@ enum nl80211_nan_conf_attributes {
 	NL80211_NAN_CONF_SCAN_PERIOD,
 	NL80211_NAN_CONF_SCAN_DWELL_TIME,
 	NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL,
+	NL80211_NAN_CONF_NOTIFY_DW,
+	NL80211_NAN_CONF_DW_LEAD_TIME,
 
 	/* keep last */
 	NUM_NL80211_NAN_CONF_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0c79fd6f101d..6b77d9c7a901 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -539,6 +539,8 @@ nl80211_nan_conf_policy[NL80211_NAN_CONF_ATTR_MAX + 1] = {
 	[NL80211_NAN_CONF_SCAN_DWELL_TIME] = NLA_POLICY_RANGE(NLA_U16, 50, 512),
 	[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL] =
 		NLA_POLICY_RANGE(NLA_U8, 50, 200),
+	[NL80211_NAN_CONF_NOTIFY_DW] = { .type = NLA_FLAG },
+	[NL80211_NAN_CONF_DW_LEAD_TIME] = NLA_POLICY_MAX(NLA_U16, 512),
 };
 
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
@@ -15334,6 +15336,15 @@ static int nl80211_parse_nan_conf(struct wiphy *wiphy,
 	if (attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL])
 		conf->discovery_beacon_interval =
 			nla_get_u8(attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL]);
+
+	if (attrs[NL80211_NAN_CONF_NOTIFY_DW])
+		conf->enable_dw_notification =
+			nla_get_flag(attrs[NL80211_NAN_CONF_NOTIFY_DW]);
+
+	if (attrs[NL80211_NAN_CONF_DW_LEAD_TIME])
+		conf->dw_lead_time =
+			nla_get_u16(attrs[NL80211_NAN_CONF_DW_LEAD_TIME]);
+
 out:
 	if (!conf->band_cfgs[NL80211_BAND_5GHZ].chan &&
 	    (!conf->bands || conf->bands & BIT(NL80211_BAND_5GHZ))) {
@@ -21471,6 +21482,45 @@ void cfg80211_epcs_changed(struct net_device *netdev, bool enabled)
 }
 EXPORT_SYMBOL(cfg80211_epcs_changed);
 
+void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
+				struct ieee80211_channel *chan, gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_next_nan_dw_notif(wdev, chan);
+
+	if (!wdev->owner_nlportid)
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0,
+			     NL80211_CMD_NAN_NEXT_DW_NOTIFICATION);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, chan->center_freq))
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
+EXPORT_SYMBOL(cfg80211_next_nan_dw_notif);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 34c584a215e5..2ed1b090d519 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4222,6 +4222,22 @@ TRACE_EVENT(cfg80211_epcs_changed,
 		  WDEV_PR_ARG, __entry->enabled)
 );
 
+TRACE_EVENT(cfg80211_next_nan_dw_notif,
+	TP_PROTO(struct wireless_dev *wdev,
+		 struct ieee80211_channel *chan),
+	TP_ARGS(wdev, chan),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		CHAN_ENTRY
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		CHAN_ASSIGN(chan);
+	),
+	TP_printk(WDEV_PR_FMT " " CHAN_PR_FMT,
+		  WDEV_PR_ARG, CHAN_PR_ARG)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.47.1


