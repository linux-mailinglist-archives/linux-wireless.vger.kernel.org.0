Return-Path: <linux-wireless+bounces-24323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20970AE32C8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 00:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F2E16EAEF
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1DF219E8C;
	Sun, 22 Jun 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1F4p4fv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDE6136
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631143; cv=none; b=uUl8TSwnII9ARdjw03xweWxri319Vukd8jNl5yyCpEbFHjN9F5jnltD4Rnctj9oTLPQavuEqjsZh1K2vCyV7k3eaBYY53IgKerQ/w0U/BWLsrVAomJNR+rwgweW4Z++WrlUvQzaO2icVQ+EM83xfj6R5bS9653TnkrfZx8HGi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631143; c=relaxed/simple;
	bh=O9xcSX1fGuJ/1JQTH8RqEJf21arbJJSeVL96gwjkBVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMp86belfCAQfL+xCwlaYQoOlhh19/va/n3cF/pWbQStrkp1voNyg/g1tgJ4EWbuTxnpzRluOv/N4POasEECiZU3clWkfXu+I0KTqZmW/PbzsOLnI8j+D7h6QLL8MQOCwEHZ9fB2Tgdmeyc+ndx2dpENE4JOcKbS3RpB7VFkGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1F4p4fv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750631142; x=1782167142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O9xcSX1fGuJ/1JQTH8RqEJf21arbJJSeVL96gwjkBVY=;
  b=O1F4p4fvcMPMTxPgXCR6xakpeB0F3zfR90PkIT0W5mxz2eMruAnO0rDu
   w3WNxGPkPvCe3CS5gdD83bbWSUWQquwDwO7g8gJqNPJLEuwcqsIN/14HQ
   0BeA6XdRqXOTDcjU5f+GiRw3bnOPjLiD02BRLrHn5f9kF5ovWUyBrrnnu
   O7G5pJrto7BtNgZAsDNtm6XIQ4z+OLoDcpRVUI0OwLvh6IO9d/CyMQxRf
   g+VJcaWZYb2vNveKDKWTJO/G4K+0AfffbUmG+zJOFENsreEzvZTJkuvH8
   UGQQ4e3W9jw5Kmm9feb6ts0lWjXZ7hjzlDIm3dHzthKibYNZvJ1u8SKWG
   Q==;
X-CSE-ConnectionGUID: 016KO40ES7uI72X1fjLe4A==
X-CSE-MsgGUID: q1YL8C7dS+SuCR6NAvv3Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52916075"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52916075"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:41 -0700
X-CSE-ConnectionGUID: 2o8dlnmXSNqV0XdmQUdOYA==
X-CSE-MsgGUID: deU7yTJtQIaRUKzuGT1Msw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="182295626"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.248.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:38 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN commands
Date: Mon, 23 Jun 2025 01:24:40 +0300
Message-ID: <20250622222444.356435-2-andrei.otcheretianski@intel.com>
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

Current NAN API's have only basic configuration for master
preference and operating bands. Add and parse additional parameters
which provide more control for NAN synchronization. The newly added
attributes allow to publish additional NAN attributes and vendor
elements in NAN beacons, control scan and discovery beacons
periodicity, enable/disable DW notifications etc.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/net/cfg80211.h       |  71 +++++++++
 include/uapi/linux/nl80211.h |  94 +++++++++++-
 net/wireless/nl80211.c       | 289 ++++++++++++++++++++++++++++++-----
 3 files changed, 415 insertions(+), 39 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 47b4235eea59..b3d3b039c913 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3758,6 +3758,30 @@ struct cfg80211_qos_map {
 	struct cfg80211_dscp_range up[8];
 };
 
+/**
+ * struct cfg80211_nan_band_config - NAN band specific configuration
+ *
+ * @chan: Pointer to the IEEE 802.11 channel structure. The channel to be used
+ *	for NAN operations on this band. For 2.4 GHz band, this is always
+ *	channel 6. For 5 GHz band, the channel is either 44 or 149, according
+ *	to the regulatory constraints.
+ * @rssi_close: RSSI close threshold used for NAN master selection. If not
+ *	specified (set to 0), default device value is used. The value should
+ *	be greater than -60 dBm (unsigned).
+ * @rssi_middle: RSSI middle threshold used for NAN master selection. If not
+ *	specified (set to 0), default device value is used. The value should be
+ *	greater than -75 dBm and less than rssi_close.
+ * @awake_dw_interval: Committed DW interval. Valid values range: 0-5. 0
+ *	indicates no wakeup for DW and can't be used on 2.4GHz band, otherwise
+ *	2^(n-1).
+ */
+struct cfg80211_nan_band_config {
+	struct ieee80211_channel *chan;
+	u8 rssi_close;
+	u8 rssi_middle;
+	u8 awake_dw_interval;
+};
+
 /**
  * struct cfg80211_nan_conf - NAN configuration
  *
@@ -3767,10 +3791,35 @@ struct cfg80211_qos_map {
  * @bands: operating bands, a bitmap of &enum nl80211_band values.
  *	For instance, for NL80211_BAND_2GHZ, bit 0 would be set
  *	(i.e. BIT(NL80211_BAND_2GHZ)).
+ * @cluster_id: cluster ID used for NAN synchronization
+ * @scan_period: period (in seconds) between NAN scans.
+ * @scan_dwell_time: dwell time (in milliseconds) for NAN scans.
+ * @discovery_beacon_interval: interval (in TUs) for discovery beacons.
+ * @enable_dw_notification: flag to enable/disable discovery window
+ *	notifications.
+ * @low_band_cfg: configuration for the low band.
+ * @high_band_cfg: configuration for the high band.
+ * @enable_scan: Flag to enable or disable scanning on 5 GHz band.
+ * @extra_nan_attrs: pointer to additional NAN attributes.
+ * @extra_nan_attrs_len: length of the additional NAN attributes.
+ * @vendor_elems: pointer to vendor-specific elements.
+ * @vendor_elems_len: length of the vendor-specific elements.
  */
 struct cfg80211_nan_conf {
 	u8 master_pref;
 	u8 bands;
+	u16 cluster_id;
+	u16 scan_period;
+	u16 scan_dwell_time;
+	u16 discovery_beacon_interval;
+	bool enable_dw_notification;
+	struct cfg80211_nan_band_config low_band_cfg;
+	struct cfg80211_nan_band_config high_band_cfg;
+	bool enable_hb_scan;
+	u8 *extra_nan_attrs;
+	size_t extra_nan_attrs_len;
+	u8 *vendor_elems;
+	size_t vendor_elems_len;
 };
 
 /**
@@ -3779,10 +3828,32 @@ struct cfg80211_nan_conf {
  *
  * @CFG80211_NAN_CONF_CHANGED_PREF: master preference
  * @CFG80211_NAN_CONF_CHANGED_BANDS: operating bands
+ * @CFG80211_NAN_CONF_CHANGED_CLUSTER_ID: cluster ID
+ * @CFG80211_NAN_CONF_CHANGED_SCAN_PERIOD: scan period
+ * @CFG80211_NAN_CONF_CHANGED_SCAN_DWELL_TIME: scan dwell time
+ * @CFG80211_NAN_CONF_CHANGED_DISCOVERY_BEACON_INTERVAL: discovery beacon
+ *	interval
+ * @CFG80211_NAN_CONF_CHANGED_ENABLE_DW_NOTIFICATION: enable DW notification
+ * @CFG80211_NAN_CONF_CHANGED_AWAKE_DW_INTERVALs: awake DW intervals (both
+ *	bands)
+ * @CFG80211_NAN_CONF_CHANGED_RSSI_THOLDS: RSSI thresholds (both bands)
+ * @CFG80211_NAN_CONF_CHANGED_ENABLE_HB_SCAN: enable high band scan
+ * @CFG80211_NAN_CONF_CHANGED_EXTRA_ATTRS: extra attributes
+ * @CFG80211_NAN_CONF_CHANGED_VENDOR_ELEMS: vendor elements
  */
 enum cfg80211_nan_conf_changes {
 	CFG80211_NAN_CONF_CHANGED_PREF = BIT(0),
 	CFG80211_NAN_CONF_CHANGED_BANDS = BIT(1),
+	CFG80211_NAN_CONF_CHANGED_CLUSTER_ID = BIT(2),
+	CFG80211_NAN_CONF_CHANGED_SCAN_PERIOD = BIT(3),
+	CFG80211_NAN_CONF_CHANGED_SCAN_DWELL_TIME = BIT(4),
+	CFG80211_NAN_CONF_CHANGED_DISCOVERY_BEACON_INTERVAL = BIT(5),
+	CFG80211_NAN_CONF_CHANGED_ENABLE_DW_NOTIFICATION = BIT(6),
+	CFG80211_NAN_CONF_CHANGED_AWAKE_DW_INTERVALS = BIT(7),
+	CFG80211_NAN_CONF_CHANGED_RSSI_THOLDS = BIT(8),
+	CFG80211_NAN_CONF_CHANGED_ENABLE_HB_SCAN = BIT(9),
+	CFG80211_NAN_CONF_CHANGED_EXTRA_ATTRS = BIT(10),
+	CFG80211_NAN_CONF_CHANGED_VENDOR_ELEMS = BIT(11),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a289014abe37..a68c486e2083 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1085,8 +1085,9 @@
  *	%NL80211_ATTR_NAN_MASTER_PREF attribute and optional
  *	%NL80211_ATTR_BANDS attributes.  If %NL80211_ATTR_BANDS is
  *	omitted or set to 0, it means don't-care and the device will
- *	decide what to use.  After this command NAN functions can be
- *	added.
+ *	decide what to use. Additional cluster configuration may be
+ *	optionally provided with %NL80211_ATTR_NAN_CONFIG.
+ *	After this command NAN functions can be added.
  * @NL80211_CMD_STOP_NAN: Stop the NAN operation, identified by
  *	its %NL80211_ATTR_WDEV interface.
  * @NL80211_CMD_ADD_NAN_FUNCTION: Add a NAN function. The function is defined
@@ -1115,6 +1116,8 @@
  *	current configuration is not changed.  If it is present but
  *	set to zero, the configuration is changed to don't-care
  *	(i.e. the device can decide what to do).
+ * 	Additional parameters may be provided with
+ *	%NL80211_ATTR_NAN_CONFIG.
  * @NL80211_CMD_NAN_MATCH: Notification sent when a match is reported.
  *	This will contain a %NL80211_ATTR_NAN_MATCH nested attribute and
  *	%NL80211_ATTR_COOKIE.
@@ -2907,6 +2910,12 @@ enum nl80211_commands {
  *	APs Support". Drivers may set additional flags that they support
  *	in the kernel or device.
  *
+ * @NL80211_ATTR_NAN_CONFIG: Nested attribute for
+ *	extended NAN cluster configuration. This is used with
+ *	%NL80211_CMD_START_NAN and %NL80211_CMD_CHANGE_NAN_CONFIG.
+ *	See &enum nl80211_nan_conf_attributes for details.
+ *	This attribute is optional.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3464,6 +3473,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
 
+	NL80211_ATTR_NAN_CONFIG,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7252,6 +7262,86 @@ enum nl80211_nan_match_attributes {
 	NL80211_NAN_MATCH_ATTR_MAX = NUM_NL80211_NAN_MATCH_ATTR - 1
 };
 
+/**
+ * enum nl80211_nan_band_conf_attributes - NAN band configuration attributes
+ * @__NL80211_NAN_BAND_CONF_INVALID: Invalid.
+ * @NL80211_NAN_BAND_CONF_CHAN: Discovery channel. Ignored on 2.4GHz band.
+ *	Either 44 or 149 for 5 GHz band.
+ * @NL80211_NAN_BAND_CONF_RSSI_CLOSE: RSSI close for NAN cluster state changes.
+ *	This is unsigned 8-bit value in dBm (absolute value).
+ * @NL80211_NAN_BAND_CONF_RSSI_MIDDLE: RSSI middle for NAN cluster state
+ * 	changes. This is unsigned 8-bit value in dBm (absolute value).
+ * @NL80211_NAN_BAND_CONF_WAKE_DW: Committed DW information (values 0-5).
+ * 	Value 0 means that the device will not wake up during the
+ * 	discovery window. Values 1-5 mean that the device will wake up
+ * 	during each 2^(n - 1) discovery window, where n is the value of
+ *	this attribute. Setting this attribute to 0 is not allowed on
+ *	2.4 GHz band.
+ * @NUM_NL80211_NAN_BAND_CONF_ATTR: Internal.
+ * @NL80211_NAN_BAND_CONF_ATTR_MAX: Highest NAN band configuration attribute.
+ *
+ * These attributes are used to configure NAN band-specific parameters. Note,
+ * that both RSSI attributes should be configured (or both left unset), while
+ * RSSI close should be higher than (>) -65 dBm and RSSI middle should be
+ * below the RSSI close value but not lower than (>=) -75 dBm.
+ */
+enum nl80211_nan_band_conf_attributes {
+	__NL80211_NAN_BAND_CONF_INVALID,
+	NL80211_NAN_BAND_CONF_CHAN,
+	NL80211_NAN_BAND_CONF_RSSI_CLOSE,
+	NL80211_NAN_BAND_CONF_RSSI_MIDDLE,
+	NL80211_NAN_BAND_CONF_WAKE_DW,
+
+	/* keep last */
+	NUM_NL80211_NAN_BAND_CONF_ATTR,
+	NL80211_NAN_BAND_CONF_ATTR_MAX = NUM_NL80211_NAN_BAND_CONF_ATTR - 1,
+};
+
+/**
+ * enum nl80211_nan_conf_attributes - NAN configuration attributes
+ * @__NL80211_NAN_CONF_INVALID: Invalid attribute, used for validation.
+ * @NL80211_NAN_CONF_CLUSTER_ID: ID for the NAN cluster.
+ * @NL80211_NAN_CONF_EXTRA_ATTRS: Additional NAN attributes to be
+ *	published in the beacons. (optional)
+ * @NL80211_NAN_CONF_VENDOR_ELEMS: Vendor-specific elements that will
+ *	be published in the beacons. (optional)
+ * @NL80211_NAN_CONF_2GHZ_CONFIG: Configuration for the 2.4 GHz band.
+ * @NL80211_NAN_CONF_5GHZ_CONFIG: Configuration for the 5 GHz band.
+ * @NL80211_NAN_CONF_SCAN_PERIOD: Scan period in seconds.
+ *	Zero value will disable scanning.
+ * @NL80211_NAN_CONF_SCAN_DWELL_TIME: Scan dwell time in TUs per channel.
+ *	Only non-zero values are valid. The optimal value depends on the
+ *	the discovery beacon interval of other devices in the cluster.
+ * @NL80211_NAN_CONF_ENABLE_HB_SCAN: If set, the device will enable scan on
+ *	5 GHz.
+ * @NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL: Discovery beacon interval
+ *	in TUs. Valid range is 50-200 TUs.
+ * @NL80211_NAN_CONF_NOTIFY_DW: If set, the driver will notify userspace about
+ *	the upcoming discovery window with
+ *	%NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.
+ * @NUM_NL80211_NAN_CONF_ATTR: Internal.
+ * @NL80211_NAN_CONF_ATTR_MAX: Highest NAN configuration attribute.
+ *
+ * These attributes are used to configure NAN-specific parameters.
+ */
+enum nl80211_nan_conf_attributes {
+	__NL80211_NAN_CONF_INVALID,
+	NL80211_NAN_CONF_CLUSTER_ID,
+	NL80211_NAN_CONF_EXTRA_ATTRS,
+	NL80211_NAN_CONF_VENDOR_ELEMS,
+	NL80211_NAN_CONF_2GHZ_CONFIG,
+	NL80211_NAN_CONF_5GHZ_CONFIG,
+	NL80211_NAN_CONF_SCAN_PERIOD,
+	NL80211_NAN_CONF_SCAN_DWELL_TIME,
+	NL80211_NAN_CONF_ENABLE_HB_SCAN,
+	NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL,
+	NL80211_NAN_CONF_NOTIFY_DW,
+
+	/* keep last */
+	NUM_NL80211_NAN_CONF_ATTR,
+	NL80211_NAN_CONF_ATTR_MAX = NUM_NL80211_NAN_CONF_ATTR - 1,
+};
+
 /**
  * enum nl80211_external_auth_action - Action to perform with external
  *     authentication request. Used by NL80211_ATTR_EXTERNAL_AUTH_ACTION.
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 85f139016da2..6727580c0a50 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -479,6 +479,28 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
 };
 
+static const struct nla_policy
+nl80211_nan_band_conf_policy[NL80211_NAN_BAND_CONF_ATTR_MAX + 1] = {
+	[NL80211_NAN_BAND_CONF_CHAN] = { .type = NLA_U8 },
+	[NL80211_NAN_BAND_CONF_RSSI_CLOSE] = { .type = NLA_U8 },
+	[NL80211_NAN_BAND_CONF_RSSI_MIDDLE] = { .type = NLA_U8 },
+	[NL80211_NAN_BAND_CONF_WAKE_DW] = { .type = NLA_U8},
+};
+
+static const struct nla_policy
+nl80211_nan_conf_policy[NL80211_NAN_CONF_ATTR_MAX + 1] = {
+	[NL80211_NAN_CONF_CLUSTER_ID] = NLA_POLICY_MIN(NLA_U16, 1),
+	[NL80211_NAN_CONF_EXTRA_ATTRS] = { .type = NLA_BINARY },
+	[NL80211_NAN_CONF_VENDOR_ELEMS] = { .type = NLA_BINARY },
+	[NL80211_NAN_CONF_2GHZ_CONFIG] = NLA_POLICY_NESTED(nl80211_nan_band_conf_policy),
+	[NL80211_NAN_CONF_5GHZ_CONFIG] = NLA_POLICY_NESTED(nl80211_nan_band_conf_policy),
+	[NL80211_NAN_CONF_SCAN_PERIOD] = { .type = NLA_U16 },
+	[NL80211_NAN_CONF_SCAN_DWELL_TIME] = NLA_POLICY_RANGE(NLA_U16, 50, 512),
+	[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL] = NLA_POLICY_RANGE(NLA_U16, 50, 200),
+	[NL80211_NAN_CONF_NOTIFY_DW] = { .type = NLA_FLAG },
+	[NL80211_NAN_CONF_ENABLE_HB_SCAN] = { .type = NLA_FLAG },
+};
+
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
@@ -748,6 +770,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MU_MIMO_FOLLOW_MAC_ADDR] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
 	[NL80211_ATTR_NAN_MASTER_PREF] = NLA_POLICY_MIN(NLA_U8, 1),
 	[NL80211_ATTR_BANDS] = { .type = NLA_U32 },
+	[NL80211_ATTR_NAN_CONFIG] = NLA_POLICY_NESTED(nl80211_nan_conf_policy),
 	[NL80211_ATTR_NAN_FUNC] = { .type = NLA_NESTED },
 	[NL80211_ATTR_FILS_KEK] = { .type = NLA_BINARY,
 				    .len = FILS_MAX_KEK_LEN },
@@ -14483,40 +14506,249 @@ static int nl80211_stop_p2p_device(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int nl80211_start_nan(struct sk_buff *skb, struct genl_info *info)
+static bool nl80211_valid_nan_freq(struct wiphy *wiphy, int freq)
 {
-	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct wireless_dev *wdev = info->user_ptr[1];
-	struct cfg80211_nan_conf conf = {};
+	struct ieee80211_channel *chan;
+	struct cfg80211_chan_def def;
+
+	/* Check if the frequency is valid for NAN */
+	if (freq != 2437 && freq != 5220 && freq != 5745)
+		return false;
+
+	chan = ieee80211_get_channel(wiphy, freq);
+	if (!chan)
+		return false;
+
+	cfg80211_chandef_create(&def, chan, NL80211_CHAN_NO_HT);
+
+	/* Check if the channel is allowed */
+	if (!cfg80211_reg_can_beacon(wiphy, &def, NL80211_IFTYPE_NAN))
+		return false;
+
+	return true;
+}
+
+static int nl80211_parse_nan_band_config(struct wiphy *wiphy,
+					 struct nlattr *attr,
+					 struct cfg80211_nan_band_config *cfg,
+					 u32 *changed, struct genl_info *info,
+					 enum nl80211_band band)
+{
+	struct nlattr *tb[NL80211_NAN_BAND_CONF_ATTR_MAX + 1];
 	int err;
 
-	if (wdev->iftype != NL80211_IFTYPE_NAN)
-		return -EOPNOTSUPP;
+	err = nla_parse_nested(tb, NL80211_NAN_BAND_CONF_ATTR_MAX, attr, NULL,
+			       info->extack);
+	if (err)
+		return err;
 
-	if (wdev_running(wdev))
-		return -EEXIST;
+	if (tb[NL80211_NAN_BAND_CONF_CHAN]) {
+		u8 ch = nla_get_u8(tb[NL80211_NAN_BAND_CONF_CHAN]);
+		int freq = ieee80211_channel_to_frequency(ch, band);
 
-	if (rfkill_blocked(rdev->wiphy.rfkill))
-		return -ERFKILL;
+		if (!nl80211_valid_nan_freq(wiphy, freq))
+			return -EINVAL;
 
-	if (!info->attrs[NL80211_ATTR_NAN_MASTER_PREF])
-		return -EINVAL;
+		cfg->chan = ieee80211_get_channel(wiphy, freq);
+	}
 
-	conf.master_pref =
-		nla_get_u8(info->attrs[NL80211_ATTR_NAN_MASTER_PREF]);
+	if (tb[NL80211_NAN_BAND_CONF_RSSI_CLOSE]) {
+		cfg->rssi_close =
+			nla_get_u8(tb[NL80211_NAN_BAND_CONF_RSSI_CLOSE]);
+		if (cfg->rssi_close > 60 ||
+		    !tb[NL80211_NAN_BAND_CONF_RSSI_MIDDLE])
+			return -EINVAL;
+
+		*changed |= CFG80211_NAN_CONF_CHANGED_RSSI_THOLDS;
+	}
+
+	if (tb[NL80211_NAN_BAND_CONF_RSSI_MIDDLE]) {
+		cfg->rssi_middle =
+			nla_get_u8(tb[NL80211_NAN_BAND_CONF_RSSI_MIDDLE]);
+		if (!cfg->rssi_close || cfg->rssi_middle > 75 ||
+		    cfg->rssi_middle <= cfg->rssi_close)
+			return -EINVAL;
+
+		*changed |= CFG80211_NAN_CONF_CHANGED_RSSI_THOLDS;
+	}
+
+	if (tb[NL80211_NAN_BAND_CONF_WAKE_DW]) {
+		cfg->awake_dw_interval =
+			nla_get_u8(tb[NL80211_NAN_BAND_CONF_WAKE_DW]);
+		if (cfg->awake_dw_interval > 5)
+			return -EINVAL;
+
+		if (band == NL80211_BAND_2GHZ && cfg->awake_dw_interval == 0)
+			return -EINVAL;
+
+		*changed |= CFG80211_NAN_CONF_CHANGED_AWAKE_DW_INTERVALS;
+	}
+
+	return 0;
+}
+
+static int nl80211_parse_nan_conf(struct wiphy *wiphy,
+				  struct genl_info *info,
+				  struct cfg80211_nan_conf *conf,
+				  u32 *changed)
+{
+	struct nlattr *attrs[NL80211_NAN_CONF_ATTR_MAX + 1];
+	int err;
+
+	if (info->attrs[NL80211_ATTR_NAN_MASTER_PREF]) {
+		conf->master_pref =
+			nla_get_u8(info->attrs[NL80211_ATTR_NAN_MASTER_PREF]);
+
+		*changed |= CFG80211_NAN_CONF_CHANGED_PREF;
+	}
 
 	if (info->attrs[NL80211_ATTR_BANDS]) {
 		u32 bands = nla_get_u32(info->attrs[NL80211_ATTR_BANDS]);
 
-		if (bands & ~(u32)wdev->wiphy->nan_supported_bands)
+		if (bands & ~(u32)wiphy->nan_supported_bands)
 			return -EOPNOTSUPP;
 
 		if (bands && !(bands & BIT(NL80211_BAND_2GHZ)))
 			return -EINVAL;
 
-		conf.bands = bands;
+		conf->bands = bands;
+		*changed |= CFG80211_NAN_CONF_CHANGED_BANDS;
+	}
+
+	if (!info->attrs[NL80211_ATTR_NAN_CONFIG])
+		return 0;
+
+	err = nla_parse_nested(attrs, NL80211_NAN_CONF_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_NAN_CONFIG], NULL,
+			       info->extack);
+	if (err)
+		return err;
+
+	if (attrs[NL80211_NAN_CONF_CLUSTER_ID]) {
+		conf->cluster_id =
+			nla_get_u8(attrs[NL80211_NAN_CONF_CLUSTER_ID]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_CLUSTER_ID;
+	}
+
+	if (attrs[NL80211_NAN_CONF_EXTRA_ATTRS]) {
+		conf->extra_nan_attrs =
+			nla_data(attrs[NL80211_NAN_CONF_EXTRA_ATTRS]);
+		conf->extra_nan_attrs_len =
+			nla_len(attrs[NL80211_NAN_CONF_EXTRA_ATTRS]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_EXTRA_ATTRS;
+	}
+
+	if (attrs[NL80211_NAN_CONF_VENDOR_ELEMS]) {
+		conf->vendor_elems =
+			nla_data(attrs[NL80211_NAN_CONF_VENDOR_ELEMS]);
+		conf->vendor_elems_len =
+			nla_len(attrs[NL80211_NAN_CONF_VENDOR_ELEMS]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_VENDOR_ELEMS;
+	}
+
+	conf->low_band_cfg.awake_dw_interval = 1;
+
+	if (conf->bands & BIT(NL80211_BAND_5GHZ))
+		conf->high_band_cfg.awake_dw_interval = 1;
+
+	if (attrs[NL80211_NAN_CONF_2GHZ_CONFIG]) {
+		err = nl80211_parse_nan_band_config(wiphy,
+						    attrs[NL80211_NAN_CONF_2GHZ_CONFIG],
+						    &conf->low_band_cfg,
+						    changed, info,
+						    NL80211_BAND_2GHZ);
+		if (err)
+			return err;
+	}
+
+	if (!conf->low_band_cfg.chan) {
+		/* If no 2GHz channel is specified, use the default */
+		conf->low_band_cfg.chan =
+			ieee80211_get_channel(wiphy, 2437);
+		if (!conf->low_band_cfg.chan ||
+			!nl80211_valid_nan_freq(wiphy, 2437))
+			return -EINVAL;
+	}
+
+	/* If the user configured 5 GHz channel use it or fail */
+	if (attrs[NL80211_NAN_CONF_5GHZ_CONFIG]) {
+		err = nl80211_parse_nan_band_config(wiphy,
+						    attrs[NL80211_NAN_CONF_5GHZ_CONFIG],
+						    &conf->high_band_cfg,
+						    changed, info,
+						    NL80211_BAND_5GHZ);
+		if (err)
+			return err;
+	}
+
+	if (!conf->high_band_cfg.chan) {
+		/* If no 5GHz channel is specified use default, if possible */
+		if (nl80211_valid_nan_freq(wiphy, 5745)) {
+			conf->high_band_cfg.chan =
+				ieee80211_get_channel(wiphy, 5745);
+		} else if (nl80211_valid_nan_freq(wiphy, 5220)) {
+			conf->high_band_cfg.chan =
+				ieee80211_get_channel(wiphy, 5220);
+		} else {
+			/* Disable 5GHZ */
+			conf->bands &= ~BIT(NL80211_BAND_5GHZ);
+		}
 	}
 
+	if (attrs[NL80211_NAN_CONF_SCAN_PERIOD]) {
+		conf->scan_period =
+			nla_get_u16(attrs[NL80211_NAN_CONF_SCAN_PERIOD]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_SCAN_PERIOD;
+	}
+
+	if (attrs[NL80211_NAN_CONF_SCAN_DWELL_TIME]) {
+		conf->scan_dwell_time =
+			nla_get_u16(attrs[NL80211_NAN_CONF_SCAN_DWELL_TIME]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_SCAN_DWELL_TIME;
+	}
+
+	if (attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL]) {
+		conf->discovery_beacon_interval =
+			nla_get_u16(attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_DISCOVERY_BEACON_INTERVAL;
+	}
+
+	if (attrs[NL80211_NAN_CONF_NOTIFY_DW]) {
+		conf->enable_dw_notification =
+			nla_get_flag(attrs[NL80211_NAN_CONF_NOTIFY_DW]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_ENABLE_DW_NOTIFICATION;
+	}
+
+	if (attrs[NL80211_NAN_CONF_ENABLE_HB_SCAN]) {
+		conf->enable_hb_scan =
+			nla_get_flag(attrs[NL80211_NAN_CONF_ENABLE_HB_SCAN]);
+		*changed |= CFG80211_NAN_CONF_CHANGED_ENABLE_HB_SCAN;
+	}
+
+	return 0;
+}
+
+static int nl80211_start_nan(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = info->user_ptr[1];
+	struct cfg80211_nan_conf conf = {};
+	int err;
+	u32 changed = 0;
+
+	if (wdev->iftype != NL80211_IFTYPE_NAN)
+		return -EOPNOTSUPP;
+
+	if (wdev_running(wdev))
+		return -EEXIST;
+
+	if (rfkill_blocked(rdev->wiphy.rfkill))
+		return -ERFKILL;
+
+	err = nl80211_parse_nan_conf(&rdev->wiphy, info, &conf, &changed);
+	if (err)
+		return err;
+
 	err = rdev_start_nan(rdev, wdev, &conf);
 	if (err)
 		return err;
@@ -14871,6 +15103,7 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_nan_conf conf = {};
 	u32 changed = 0;
+	int err;
 
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
@@ -14878,27 +15111,9 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
 	if (!wdev_running(wdev))
 		return -ENOTCONN;
 
-	if (info->attrs[NL80211_ATTR_NAN_MASTER_PREF]) {
-		conf.master_pref =
-			nla_get_u8(info->attrs[NL80211_ATTR_NAN_MASTER_PREF]);
-		if (conf.master_pref <= 1 || conf.master_pref == 255)
-			return -EINVAL;
-
-		changed |= CFG80211_NAN_CONF_CHANGED_PREF;
-	}
-
-	if (info->attrs[NL80211_ATTR_BANDS]) {
-		u32 bands = nla_get_u32(info->attrs[NL80211_ATTR_BANDS]);
-
-		if (bands & ~(u32)wdev->wiphy->nan_supported_bands)
-			return -EOPNOTSUPP;
-
-		if (bands && !(bands & BIT(NL80211_BAND_2GHZ)))
-			return -EINVAL;
-
-		conf.bands = bands;
-		changed |= CFG80211_NAN_CONF_CHANGED_BANDS;
-	}
+	err = nl80211_parse_nan_conf(&rdev->wiphy, info, &conf, &changed);
+	if (err)
+		return err;
 
 	if (!changed)
 		return -EINVAL;
-- 
2.49.0


