Return-Path: <linux-wireless+bounces-31906-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMVrM02Sk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31906-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B6147D2A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F1BC300C022
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCBB2C11F0;
	Mon, 16 Feb 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhKONPxw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB22D7DF2
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278913; cv=none; b=Bnja9IpNCnwRdkxMyL93NpkpQ44bC7zS78pRIb/qqefgN8SmljP0A30mj0Xt2wdwtx2idVNAlYYy8n7cZrBHmchtntuSPmoWJQ14KJMIkO59eWXtpm6o2vObdwljrOT3O8mQ3dBaJJuuefVGKkyFUI6u4Ckk/01avnyVgiwoxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278913; c=relaxed/simple;
	bh=KsasdFiJgv2fbPcOCThNA4VPFpxgK+qzm5FxaosRMtA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpCFukVdbMo4Dophm61kPgDjAUipGz4cW1m9xLQ82XL3/xiAwa92TKp9Qu7KoxjTIuwzklwW48bnySSpKwnsPV/mYR7kp10VBTI4MAhLUmNOIEh74+sofct7ZW92fphkL7ADW9qpFAvNyv+QDvTdu1IpF1UcMlMOCz91YmNOKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhKONPxw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278912; x=1802814912;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KsasdFiJgv2fbPcOCThNA4VPFpxgK+qzm5FxaosRMtA=;
  b=JhKONPxwuIBHBegYzZzzQFGwIKKyU6rJBfapyrVYGd60byMSCG5HQfYJ
   Lcv1Qad2OSJ/JTG949LD/DrUbbUrABBheeHt1acXEANIF0D3hBs1YpE2q
   N3vUS933cCRKBHMieumC21XLdT8A/wQVG0vQfit02OBgUX1dJGo60S0fP
   GPDbjIOs2IAIbebA6ByP9STObgvBeqU3VSGbM1BjcjFszSAGn4GW+ukUH
   U1AZf69KMCExLaxnRKZ4TmSAajxr+T/pKUWVFucSsXjH2hgabVxpKQhTH
   d/Ti27F0kmtCA5QuyTS+HHtjzCSGhoQp1E7/877v6Ym6+wukc8FSonP5o
   g==;
X-CSE-ConnectionGUID: YRvuPx3wQsm7rxBeumEB3g==
X-CSE-MsgGUID: xlbrn60OQQu892OQr16ITQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980289"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980289"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:12 -0800
X-CSE-ConnectionGUID: WukfwXorQjSLvJlRY1cZvA==
X-CSE-MsgGUID: TMNbUTw4SJmYhgjpmxmR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547307"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 06/15] wifi: cfg80211: Add an API to configure local NAN schedule
Date: Mon, 16 Feb 2026 23:54:43 +0200
Message-Id: <20260216234830.ecca178a2de0.Ic977ab08b4ed5cf9b849e55d3a59b01ad3fbd08e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31906-lists,linux-wireless=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B77B6147D2A
X-Rspamd-Action: no action

Add an nl80211 API to allow user space to configure the local NAN
schedule.
The local schedule consists of a list of channel definitions and a schedule
map, in which each element covers a time slot and indicates on what
channel the device should be in that time slot.

Channels can be added to schedule even without being scheduled, for
reservation purposes.

A schedule can be configured either immedietally or be deferred, in case
there are already connected peers.
When the deferred flag is set, the command is a request from the device
to perform an announced schedule update: send the updated NAN
Availability - as set in this command - to the peers, and do the
actual switch to the new schedule on the right time (i.e. at the end of
the slot after the slot in which the update was sent to the peers).
In addition, a notification will be sent to indicate a deferred update
completion.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  73 ++++++++++-
 include/uapi/linux/nl80211.h |  77 +++++++++++-
 net/wireless/core.c          |  54 +++++++-
 net/wireless/core.h          |   4 +
 net/wireless/nl80211.c       | 235 +++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  16 +++
 net/wireless/trace.h         |  38 ++++++
 7 files changed, 494 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6284e354186d..ea04afa72fa4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4048,6 +4048,54 @@ struct cfg80211_nan_conf {
 	u16 vendor_elems_len;
 };
 
+#define CFG80211_NAN_SCHED_NUM_TIME_SLOTS 32
+
+/**
+ * struct cfg80211_nan_channel - NAN channel configuration
+ *
+ * This struct defines a NAN channel configuration
+ *
+ * @chandef: the channel definition
+ * @channel_entry: pointer to the Channel Entry blob as defined in Wi-Fi Aware
+ *	(TM) 4.0 specification Table 100 (Channel Entry format for the NAN
+ *	Availability attribute).
+ * @rx_nss: number of spatial streams supported on this channel
+ */
+struct cfg80211_nan_channel {
+	struct cfg80211_chan_def chandef;
+	const u8 *channel_entry;
+	u8 rx_nss;
+};
+
+/**
+ * struct cfg80211_nan_local_sched - NAN local schedule
+ *
+ * This struct defines NAN local schedule parameters
+ *
+ * @schedule: a mapping of time slots to chandef indexes in %nan_channels.
+ *	An unscheduled slot will be set to %NL80211_NAN_SCHED_NOT_AVAIL_SLOT.
+ * @n_channels: number of channel definitions in %nan_channels.
+ * @nan_avail_blob: pointer to NAN Availability attribute blob.
+ *	See %NL80211_ATTR_NAN_AVAIL_BLOB for more details.
+ * @nan_avail_blob_len: length of the @nan_avail_blob in bytes.
+ * @deferred: if true, the command containing this schedule configuration is a
+ *	request from the device to perform an announced schedule update. This
+ *	means that it needs to send the updated NAN availability to the peers,
+ *	and do the actual switch on the right time (i.e. at the end of the slot
+ *	after the slot in which the updated NAN Availability was sent).
+ *	See %NL80211_ATTR_NAN_SCHED_DEFERRED for more details.
+ *	If false, the schedule is applied immediately.
+ * @nan_channels: array of NAN channel definitions that can be scheduled.
+ */
+struct cfg80211_nan_local_sched {
+	u8 schedule[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
+	u8 n_channels;
+	const u8 *nan_avail_blob;
+	u16 nan_avail_blob_len;
+	bool deferred;
+	struct cfg80211_nan_channel nan_channels[] __counted_by(n_channels);
+};
+
 /**
  * enum cfg80211_nan_conf_changes - indicates changed fields in NAN
  * configuration
@@ -4828,6 +4876,12 @@ struct mgmt_frame_regs {
  * @nan_change_conf: changes NAN configuration. The changed parameters must
  *	be specified in @changes (using &enum cfg80211_nan_conf_changes);
  *	All other parameters must be ignored.
+ * @nan_set_local_sched: configure the local schedule for NAN. The schedule
+ *	consists of an array of %cfg80211_nan_channel and the schedule itself,
+ *	in which each entry maps each time slot to the channel on which the
+ *	radio should operate on. If the chandef of a NAN channel is not
+ *	changed, the channel entry must also remain unchanged. It is the
+ *	driver's responsibility to verify this.
  *
  * @set_multicast_to_unicast: configure multicast to unicast conversion for BSS
  *
@@ -5205,7 +5259,9 @@ struct cfg80211_ops {
 				   struct wireless_dev *wdev,
 				   struct cfg80211_nan_conf *conf,
 				   u32 changes);
-
+	int	(*nan_set_local_sched)(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       struct cfg80211_nan_local_sched *sched);
 	int	(*set_multicast_to_unicast)(struct wiphy *wiphy,
 					    struct net_device *dev,
 					    const bool enabled);
@@ -6857,6 +6913,9 @@ struct wireless_dev {
 		} ocb;
 		struct {
 			u8 cluster_id[ETH_ALEN] __aligned(2);
+			u8 n_channels;
+			struct cfg80211_chan_def *chandefs;
+			bool sched_update_pending;
 		} nan;
 	} u;
 
@@ -10014,6 +10073,18 @@ void cfg80211_nan_func_terminated(struct wireless_dev *wdev,
 				  enum nl80211_nan_func_term_reason reason,
 				  u64 cookie, gfp_t gfp);
 
+/**
+ * cfg80211_nan_sched_update_done - notify deferred schedule update completion
+ * @wdev: the wireless device reporting the event
+ * @success: whether or not the schedule update was successful
+ * @gfp: allocation flags
+ *
+ * This function notifies user space that a deferred local NAN schedule update
+ * (requested with %NL80211_ATTR_NAN_SCHED_DEFERRED) has been completed.
+ */
+void cfg80211_nan_sched_update_done(struct wireless_dev *wdev, bool success,
+				    gfp_t gfp);
+
 /* ethtool helper */
 void cfg80211_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info);
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b63f71850906..4edc6eb9c467 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1360,7 +1360,20 @@
  * @NL80211_CMD_NAN_CLUSTER_JOINED: This command is used to notify
  *	user space that the NAN new cluster has been joined. The cluster ID is
  *	indicated by %NL80211_ATTR_MAC.
- *
+ * @NL80211_CMD_NAN_SET_LOCAL_SCHED: Set the local NAN schedule. NAN must be
+ *	operational (%NL80211_CMD_START_NAN was executed). Must contain
+ *	%NL80211_ATTR_NAN_TIME_SLOTS and %NL80211_ATTR_NAN_AVAIL_BLOB, but
+ *	%NL80211_ATTR_NAN_CHANNEL is optional (for example in case of a channel
+ *	removal, that channel won't be provided).
+ *	If %NL80211_ATTR_NAN_SCHED_DEFERRED is set, the command is a request
+ *	from the device to perform an announced schedule update. See
+ *	%NL80211_ATTR_NAN_SCHED_DEFERRED for more details.
+ *	If not set, the schedule should be applied immediately.
+ * @NL80211_CMD_NAN_SCHED_UPDATE_DONE: Event sent to user space to notify that
+ *	a deferred local NAN schedule update (requested with
+ *	%NL80211_CMD_NAN_SET_LOCAL_SCHED and %NL80211_ATTR_NAN_SCHED_DEFERRED)
+ *	has been completed. The presence of %NL80211_ATTR_NAN_SCHED_UPDATE_SUCCESS
+ *	indicates that the update was successful.
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1624,6 +1637,10 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
 	NL80211_CMD_NAN_CLUSTER_JOINED,
 
+	NL80211_CMD_NAN_SET_LOCAL_SCHED,
+
+	NL80211_CMD_NAN_SCHED_UPDATE_DONE,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2983,6 +3000,54 @@ enum nl80211_commands {
  * @NL80211_ATTR_DISABLE_UHR: Force UHR capable interfaces to disable
  *	this feature during association. This is a flag attribute.
  *	Currently only supported in mac80211 drivers.
+ * @NL80211_ATTR_NAN_CHANNEL: This is a nested attribute. There can be multiple
+ *	attributes of this type, each one represents a channel definition and
+ *	consists of top-level attributes like %NL80211_ATTR_WIPHY_FREQ. Must
+ *	contain %NL80211_ATTR_NAN_CHANNEL_ENTRY and
+ *	%NL80211_ATTR_NAN_RX_NSS.
+ *	This attribute is used with %NL80211_CMD_NAN_SET_LOCAL_SCHED to specify
+ *	the channel definitions on which the radio needs to operate during
+ *	specific time slots. All of the channel definitions should be mutually
+ *	incompatible. The number of channels should fit the current
+ *	configuration of channels and the possible interface combinations.
+ *	If an existing NAN channel is changed but the chandef isn't, the
+ *	channel entry must also remain unchanged.
+ * @NL80211_ATTR_NAN_CHANNEL_ENTRY: a byte array of 6 bytes. contains the
+ *	Channel Entry as defined in Wi-Fi Aware (TM) 4.0 specification Table
+ *	100 (Channel Entry format for the NAN Availability attribute).
+ * @NL80211_ATTR_NAN_RX_NSS: (u8) RX NSS used for a NAN channel. This is
+ *	used with %NL80211_ATTR_NAN_CHANNEL when configuring NAN channels with
+ *	%NL80211_CMD_NAN_SET_LOCAL_SCHED.
+ * @NL80211_ATTR_NAN_TIME_SLOTS: an array of u8 values and 32 cells. each value
+ *	maps a time slot to the chandef on which the radio should operate on in
+ *	that time. %NL80211_NAN_SCHED_NOT_AVAIL_SLOT indicates unscheduled.
+ *	The chandef is represented using its index, where the index is the
+ *	sequential number of the %NL80211_ATTR_NAN_CHANNEL attribute within all
+ *	the attributes of this type.
+ *	Each slots spans over 16TUs, hence the entire schedule spans over
+ *	512TUs. Other slot durations and periods are currently not supported.
+ * @NL80211_ATTR_NAN_AVAIL_BLOB: (Binary) The NAN Availability attribute blob,
+ *	including the attribute header, as defined in Wi-Fi Aware (TM) 4.0
+ *	specification Table 93 (NAN Availability attribute format). Required with
+ *	%NL80211_CMD_NAN_SET_LOCAL_SCHED to provide the raw NAN Availability
+ *	attribute. Used by the device to publish Schedule Update NAFs.
+ * @NL80211_ATTR_NAN_SCHED_DEFERRED: Flag attribute used with
+ *	%NL80211_CMD_NAN_SET_LOCAL_SCHED. When present, the command is a
+ *	request from the device to perform an announced schedule update. This
+ *	means that it needs to send the updated NAN availability to the peers,
+ *	and do the actual switch on the right time (i.e. at the end of the slot
+ *	after the slot in which the updated NAN Availability was sent). Since
+ *	the slots management is done in the device, the update to the peers
+ *	needs to be sent by the device, so it knows the actual switch time.
+ *	If the flag is not set, the schedule should be applied immediately.
+ *	When this flag is set, the total number of NAN channels from both the
+ *	old and new schedules must not exceed the allowed number of local NAN
+ *	channels, because with deferred scheduling the old channels cannot be
+ *	removed before adding the new ones to free up space.
+ * @NL80211_ATTR_NAN_SCHED_UPDATE_SUCCESS: flag attribute used with
+ *	%NL80211_CMD_NAN_SCHED_UPDATE_DONE to indicate that the deferred
+ *	schedule update completed successfully. If this flag is not present,
+ *	the update failed.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3557,6 +3622,14 @@ enum nl80211_attrs {
 	NL80211_ATTR_UHR_CAPABILITY,
 	NL80211_ATTR_DISABLE_UHR,
 
+	NL80211_ATTR_NAN_CHANNEL,
+	NL80211_ATTR_NAN_CHANNEL_ENTRY,
+	NL80211_ATTR_NAN_TIME_SLOTS,
+	NL80211_ATTR_NAN_RX_NSS,
+	NL80211_ATTR_NAN_AVAIL_BLOB,
+	NL80211_ATTR_NAN_SCHED_DEFERRED,
+	NL80211_ATTR_NAN_SCHED_UPDATE_SUCCESS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8534,4 +8607,6 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
 };
 
+#define NL80211_NAN_SCHED_NOT_AVAIL_SLOT 0xff
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 328d3036d21f..e86c404b0cfa 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -254,6 +254,8 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev)
 {
+	struct cfg80211_nan_local_sched empty_sched = {};
+
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_NAN))
@@ -262,6 +264,15 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	if (!wdev_running(wdev))
 		return;
 
+	/*
+	 * If there is a scheduled update pending, mark it as canceled, so the
+	 * empty schedule will be accepted
+	 */
+	wdev->u.nan.sched_update_pending = false;
+
+	/* Unschedule all */
+	cfg80211_nan_set_local_schedule(rdev, wdev, &empty_sched);
+
 	rdev_stop_nan(rdev, wdev);
 	wdev->is_running = false;
 
@@ -270,6 +281,47 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	rdev->opencount--;
 }
 
+int cfg80211_nan_set_local_schedule(struct cfg80211_registered_device *rdev,
+				    struct wireless_dev *wdev,
+				    struct cfg80211_nan_local_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (wdev->iftype != NL80211_IFTYPE_NAN || !wdev_running(wdev))
+		return -EINVAL;
+
+	if (wdev->u.nan.sched_update_pending)
+		return -EBUSY;
+
+	ret = rdev_nan_set_local_sched(rdev, wdev, sched);
+	if (ret)
+		return ret;
+
+	wdev->u.nan.sched_update_pending = sched->deferred;
+
+	kfree(wdev->u.nan.chandefs);
+	wdev->u.nan.chandefs = NULL;
+	wdev->u.nan.n_channels = 0;
+
+	if (!sched->n_channels)
+		return 0;
+
+	wdev->u.nan.chandefs = kcalloc(sched->n_channels,
+				       sizeof(*wdev->u.nan.chandefs),
+				       GFP_KERNEL);
+	if (!wdev->u.nan.chandefs)
+		return -ENOMEM;
+
+	for (int i = 0; i < sched->n_channels; i++)
+		wdev->u.nan.chandefs[i] = sched->nan_channels[i].chandef;
+
+	wdev->u.nan.n_channels = sched->n_channels;
+
+	return 0;
+}
+
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 6ac57b7b2615..cd8e18a33e79 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -547,6 +547,10 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
 
+int cfg80211_nan_set_local_schedule(struct cfg80211_registered_device *rdev,
+				    struct wireless_dev *wdev,
+				    struct cfg80211_nan_local_sched *sched);
+
 struct cfg80211_internal_bss *
 cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		    struct cfg80211_internal_bss *tmp,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1f5f28fee427..ffc7e4a8a391 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -332,6 +332,40 @@ static int validate_nan_cluster_id(const struct nlattr *attr,
 	return 0;
 }
 
+static int validate_nan_avail_blob(const struct nlattr *attr,
+				   struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+	u16 attr_len;
+
+	/* Need at least: Attr ID (1) + Length (2) */
+	if (len < 3) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "NAN Availability: Too short (need at least 3 bytes, have %u)",
+				   len);
+		return -EINVAL;
+	}
+
+	if (data[0] != 0x12) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "NAN Availability: Invalid Attribute ID 0x%02x (expected 0x12)",
+				   data[0]);
+		return -EINVAL;
+	}
+
+	attr_len = get_unaligned_le16(&data[1]);
+
+	if (attr_len != len - 3) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "NAN Availability: Length field (%u) doesn't match data length (%u)",
+				   attr_len, len - 3);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int validate_uhr_capa(const struct nlattr *attr,
 			     struct netlink_ext_ack *extack)
 {
@@ -946,6 +980,14 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_UHR_CAPABILITY] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_capa, 255),
 	[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
+	[NL80211_ATTR_NAN_CHANNEL] = NLA_POLICY_NESTED(nl80211_policy),
+	[NL80211_ATTR_NAN_CHANNEL_ENTRY] = NLA_POLICY_EXACT_LEN(6),
+	[NL80211_ATTR_NAN_RX_NSS] = { .type = NLA_U8 },
+	[NL80211_ATTR_NAN_TIME_SLOTS] =
+		NLA_POLICY_EXACT_LEN(CFG80211_NAN_SCHED_NUM_TIME_SLOTS),
+	[NL80211_ATTR_NAN_AVAIL_BLOB] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_nan_avail_blob),
+	[NL80211_ATTR_NAN_SCHED_DEFERRED] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -16390,6 +16432,193 @@ void cfg80211_nan_func_terminated(struct wireless_dev *wdev,
 }
 EXPORT_SYMBOL(cfg80211_nan_func_terminated);
 
+void cfg80211_nan_sched_update_done(struct wireless_dev *wdev, bool success,
+				    gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_nan_sched_update_done(wiphy, wdev, success);
+
+	/* Can happen if we stopped NAN */
+	if (!wdev->u.nan.sched_update_pending)
+		return;
+
+	wdev->u.nan.sched_update_pending = false;
+
+	if (!wdev->owner_nlportid)
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_NAN_SCHED_UPDATE_DONE);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    (success &&
+	     nla_put_flag(msg, NL80211_ATTR_NAN_SCHED_UPDATE_SUCCESS)))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_unicast(wiphy_net(wiphy), msg, wdev->owner_nlportid);
+
+	return;
+
+nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_nan_sched_update_done);
+
+static int nl80211_parse_nan_channel(struct cfg80211_registered_device *rdev,
+				     struct nlattr *channel,
+				     struct genl_info *info,
+				     struct cfg80211_nan_local_sched *sched,
+				     u8 index)
+{
+	struct nlattr **channel_parsed __free(kfree) = NULL;
+	struct cfg80211_chan_def chandef;
+	u8 n_rx_nss;
+	int ret;
+
+	channel_parsed = kcalloc(NL80211_ATTR_MAX + 1, sizeof(*channel_parsed),
+				 GFP_KERNEL);
+	if (!channel_parsed)
+		return -ENOMEM;
+
+	ret = nla_parse_nested(channel_parsed, NL80211_ATTR_MAX, channel, NULL,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	ret = nl80211_parse_chandef(rdev, info->extack, channel_parsed,
+				    &chandef);
+	if (ret)
+		return ret;
+
+	if (chandef.chan->band == NL80211_BAND_6GHZ) {
+		NL_SET_ERR_MSG(info->extack,
+			       "6 GHz band is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!cfg80211_reg_can_beacon(&rdev->wiphy, &chandef,
+				     NL80211_IFTYPE_NAN)) {
+		NL_SET_ERR_MSG_ATTR(info->extack, channel,
+				    "Channel in NAN schedule is not allowed for NAN operation");
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < index; i++) {
+		if (cfg80211_chandef_compatible(&sched->nan_channels[i].chandef,
+						&chandef)) {
+			NL_SET_ERR_MSG_ATTR(info->extack, channel,
+					    "Channels in NAN schedule must be mutually incompatible");
+			return -EINVAL;
+		}
+	}
+
+	if (!channel_parsed[NL80211_ATTR_NAN_CHANNEL_ENTRY])
+		return -EINVAL;
+
+	sched->nan_channels[index].channel_entry =
+		nla_data(channel_parsed[NL80211_ATTR_NAN_CHANNEL_ENTRY]);
+
+	if (!channel_parsed[NL80211_ATTR_NAN_RX_NSS])
+		return -EINVAL;
+
+	sched->nan_channels[index].rx_nss =
+		nla_get_u8(channel_parsed[NL80211_ATTR_NAN_RX_NSS]);
+
+	n_rx_nss = u8_get_bits(rdev->wiphy.nan_capa.n_antennas, 0x03);
+	if (sched->nan_channels[index].rx_nss > n_rx_nss ||
+	    !sched->nan_channels[index].rx_nss) {
+		NL_SET_ERR_MSG_ATTR(info->extack, channel,
+				    "Invalid RX NSS in NAN channel definition");
+		return -EINVAL;
+	}
+
+	sched->nan_channels[index].chandef = chandef;
+
+	return 0;
+}
+
+static int nl80211_nan_set_local_sched(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_nan_local_sched *sched __free(kfree) = NULL;
+	struct wireless_dev *wdev = info->user_ptr[1];
+	int rem, i = 0, n_channels = 0;
+	struct nlattr *channel;
+
+	if (wdev->iftype != NL80211_IFTYPE_NAN)
+		return -EOPNOTSUPP;
+
+	if (!wdev_running(wdev))
+		return -ENOTCONN;
+
+	if (!info->attrs[NL80211_ATTR_NAN_TIME_SLOTS])
+		return -EINVAL;
+
+	/* First count how many channel attributes we got */
+	nlmsg_for_each_attr_type(channel, NL80211_ATTR_NAN_CHANNEL,
+				 info->nlhdr, GENL_HDRLEN, rem)
+		n_channels++;
+
+	sched = kzalloc(struct_size(sched, nan_channels, n_channels),
+			GFP_KERNEL);
+	if (!sched)
+		return -ENOMEM;
+
+	sched->n_channels = n_channels;
+
+	nlmsg_for_each_attr_type(channel, NL80211_ATTR_NAN_CHANNEL,
+				 info->nlhdr, GENL_HDRLEN, rem) {
+		int ret = nl80211_parse_nan_channel(rdev, channel, info, sched,
+						    i);
+
+		if (ret)
+			return ret;
+		i++;
+	}
+
+	memcpy(sched->schedule,
+	       nla_data(info->attrs[NL80211_ATTR_NAN_TIME_SLOTS]),
+	       nla_len(info->attrs[NL80211_ATTR_NAN_TIME_SLOTS]));
+
+	for (int slot = 0; slot < ARRAY_SIZE(sched->schedule); slot++) {
+		if (sched->schedule[slot] != NL80211_NAN_SCHED_NOT_AVAIL_SLOT &&
+		    sched->schedule[slot] >= sched->n_channels) {
+			NL_SET_ERR_MSG(info->extack,
+				       "Invalid time slot in NAN schedule");
+			return -EINVAL;
+		}
+	}
+
+	if (!info->attrs[NL80211_ATTR_NAN_AVAIL_BLOB]) {
+		NL_SET_ERR_MSG(info->extack,
+			       "NAN Availability blob attribute is required");
+		return -EINVAL;
+	}
+
+	sched->nan_avail_blob =
+		nla_data(info->attrs[NL80211_ATTR_NAN_AVAIL_BLOB]);
+	sched->nan_avail_blob_len =
+		nla_len(info->attrs[NL80211_ATTR_NAN_AVAIL_BLOB]);
+
+	sched->deferred = nla_get_flag(info->attrs[NL80211_ATTR_NAN_SCHED_DEFERRED]);
+
+	return cfg80211_nan_set_local_schedule(rdev, wdev, sched);
+}
+
 static int nl80211_get_protocol_features(struct sk_buff *skb,
 					 struct genl_info *info)
 {
@@ -19194,6 +19423,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_NAN_SET_LOCAL_SCHED,
+		.doit = nl80211_nan_set_local_sched,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index a8f1e7ddc0c0..31070551f3c1 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1060,6 +1060,22 @@ rdev_nan_change_conf(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_nan_set_local_sched(struct cfg80211_registered_device *rdev,
+			 struct wireless_dev *wdev,
+			 struct cfg80211_nan_local_sched *sched)
+{
+	int ret;
+
+	trace_rdev_nan_set_local_sched(&rdev->wiphy, wdev, sched);
+	if (rdev->ops->nan_set_local_sched)
+		ret = rdev->ops->nan_set_local_sched(&rdev->wiphy, wdev, sched);
+	else
+		ret = -EOPNOTSUPP;
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 static inline int rdev_set_mac_acl(struct cfg80211_registered_device *rdev,
 				   struct net_device *dev,
 				   struct cfg80211_acl_data *params)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a50583a5253b..4eba2677fe1a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2410,6 +2410,27 @@ TRACE_EVENT(rdev_del_nan_func,
 		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->cookie)
 );
 
+TRACE_EVENT(rdev_nan_set_local_sched,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 struct cfg80211_nan_local_sched *sched),
+	TP_ARGS(wiphy, wdev, sched),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__array(u8, schedule, CFG80211_NAN_SCHED_NUM_TIME_SLOTS)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		memcpy(__entry->schedule, sched->schedule,
+		       CFG80211_NAN_SCHED_NUM_TIME_SLOTS);
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", schedule: %s",
+		  WIPHY_PR_ARG, WDEV_PR_ARG,
+		  __print_array(__entry->schedule,
+				CFG80211_NAN_SCHED_NUM_TIME_SLOTS, 1))
+);
+
 TRACE_EVENT(rdev_set_mac_acl,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_acl_data *params),
@@ -4257,6 +4278,23 @@ TRACE_EVENT(cfg80211_nan_cluster_joined,
 		  WDEV_PR_ARG, __entry->cluster_id,
 		  __entry->new_cluster ? " [new]" : "")
 );
+
+TRACE_EVENT(cfg80211_nan_sched_update_done,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, bool success),
+	TP_ARGS(wiphy, wdev, success),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__field(bool, success)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		__entry->success = success;
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT " success=%d",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->success)
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


