Return-Path: <linux-wireless+bounces-27084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6124B48BD5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6801A341A14
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AAD2FE04B;
	Mon,  8 Sep 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VS4Vuw5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923402FB08D
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330022; cv=none; b=XldAvLy9WFKgqFjTD4hhS1vR0dUnsqjo5t1QkIiCYc4uC7jbWkeA5tSbnsPMA1c6ayegfHzO/jqupbw231Iboh+smuLG5F7oyunLBRRy2PwSfjC0oi4WKcTZr+R5DhOnv/K8H6zi0DruYsMnVzwOv2NA9E589hYkCRzP6BwPzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330022; c=relaxed/simple;
	bh=oflNntotxnzKu1toh1qQ+7LoSWZS/8Tr6AJpy/+wuQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/tYsbviM1BGqjoWiuXQ05wtf0J2MgkrKTyBUonKfRp4GmCoeA2iIM4/V87EALw5qF0RIy3l5gaC07ghmHjSwda0wZ0Se8AglkLkzsQ4FCmsBJr/JiKda5qEeIIfvhgndzuF6fM2NNrEqR1yTKHafJuzYSl9FHzCSlJaQYJzNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VS4Vuw5b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330020; x=1788866020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oflNntotxnzKu1toh1qQ+7LoSWZS/8Tr6AJpy/+wuQA=;
  b=VS4Vuw5bk5dJuq3pa5ZnumryIWY9U3DcRmPup+/TELt2zp8+8F131bBi
   5wDRnOUy5nyO3y/zsFxZm5zok41B01WcEFq7DpruV/38AroNTX0TbXwVR
   DQSOOGN8iVhJ48GU3/GCMML9klfdmZhtVGtCXiPT+mZSfA1nygRYvg7OU
   8uc8JAGDHuyVg5Bi8fpcf5MB/6S8gYUlfTtv3Qmv8pQvXprd7o0sejMgo
   KcWrdDgSoe0B6KWP6ytFiudNZptDOVtidPr+Io0rGW3fa6scmWJMlR+cl
   miSw7+vbcY/IHMB1hc9zJundVYZ3cPCmrj/s5RsUXIf4FDBq8y3HPmtql
   g==;
X-CSE-ConnectionGUID: sNoM6ohaRQqk6g4tv2fl6w==
X-CSE-MsgGUID: M6J9ixn/Q3iD1j4vBEE51Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037880"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037880"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:40 -0700
X-CSE-ConnectionGUID: /vUq7NvYT8ibW2OOT95gRA==
X-CSE-MsgGUID: 1sA8MjPnQ9CvKzVXdHxC7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126562"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH wireless-next 02/14] wifi: nl80211: Add NAN Discovery Window (DW) notification
Date: Mon,  8 Sep 2025 14:12:56 +0300
Message-Id: <20250908140015.0e1d15031bab.I5b1721e61b63910452b3c5cdcdc1e94cb094d4c9@changeid>
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
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 12 ++++++++++
 include/uapi/linux/nl80211.h | 16 +++++++++++++
 net/wireless/nl80211.c       | 45 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 16 +++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e2f4ca500ea3..0c1311d254be 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3959,6 +3959,8 @@ struct cfg80211_nan_band_config {
  * @scan_period: period (in seconds) between NAN scans.
  * @scan_dwell_time: dwell time (in milliseconds) for NAN scans.
  * @discovery_beacon_interval: interval (in TUs) for discovery beacons.
+ * @enable_dw_notification: flag to enable/disable discovery window
+ *	notifications.
  * @band_cfgs: array of band specific configurations, indexed by
  *	&enum nl80211_band values.
  * @extra_nan_attrs: pointer to additional NAN attributes.
@@ -3973,6 +3975,7 @@ struct cfg80211_nan_conf {
 	u16 scan_period;
 	u16 scan_dwell_time;
 	u8 discovery_beacon_interval;
+	bool enable_dw_notification;
 	struct cfg80211_nan_band_config band_cfgs[NUM_NL80211_BANDS];
 	const u8 *extra_nan_attrs;
 	u16 extra_nan_attrs_len;
@@ -10062,6 +10065,15 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
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
index 20b8202a3d58..d674608e2635 100644
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
@@ -7409,6 +7420,10 @@ enum nl80211_nan_band_conf_attributes {
  * @NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL: Discovery beacon interval
  *	in TUs. Valid range is 50-200 TUs. If not configured the device default
  *	value is used. This is u8 (optional)
+ * @NL80211_NAN_CONF_NOTIFY_DW: If set, the driver will notify userspace about
+ *	the upcoming discovery window with
+ *	%NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.
+ *	This is a flag attribute.
  * @NUM_NL80211_NAN_CONF_ATTR: Internal.
  * @NL80211_NAN_CONF_ATTR_MAX: Highest NAN configuration attribute.
  *
@@ -7423,6 +7438,7 @@ enum nl80211_nan_conf_attributes {
 	NL80211_NAN_CONF_SCAN_PERIOD,
 	NL80211_NAN_CONF_SCAN_DWELL_TIME,
 	NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL,
+	NL80211_NAN_CONF_NOTIFY_DW,
 
 	/* keep last */
 	NUM_NL80211_NAN_CONF_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index da8bd3f19a79..553d7426ee2b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -547,6 +547,7 @@ nl80211_nan_conf_policy[NL80211_NAN_CONF_ATTR_MAX + 1] = {
 	[NL80211_NAN_CONF_SCAN_DWELL_TIME] = NLA_POLICY_RANGE(NLA_U16, 50, 512),
 	[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL] =
 		NLA_POLICY_RANGE(NLA_U8, 50, 200),
+	[NL80211_NAN_CONF_NOTIFY_DW] = { .type = NLA_FLAG },
 };
 
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
@@ -15626,6 +15627,11 @@ static int nl80211_parse_nan_conf(struct wiphy *wiphy,
 	if (attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL])
 		conf->discovery_beacon_interval =
 			nla_get_u8(attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL]);
+
+	if (attrs[NL80211_NAN_CONF_NOTIFY_DW])
+		conf->enable_dw_notification =
+			nla_get_flag(attrs[NL80211_NAN_CONF_NOTIFY_DW]);
+
 out:
 	if (!conf->band_cfgs[NL80211_BAND_5GHZ].chan &&
 	    (!conf->bands || conf->bands & BIT(NL80211_BAND_5GHZ))) {
@@ -21763,6 +21769,45 @@ void cfg80211_epcs_changed(struct net_device *netdev, bool enabled)
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
index 9b6074155d59..ff47e9bffd4f 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4166,6 +4166,22 @@ TRACE_EVENT(cfg80211_epcs_changed,
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
2.34.1


