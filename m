Return-Path: <linux-wireless+bounces-26357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FD0B24817
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E87B12C2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F22F658E;
	Wed, 13 Aug 2025 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvCOeYwf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C52F657C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083520; cv=none; b=c88zUNhRgXJjtV2YW8nqPDjtevvC9X79jTPJ+PduNGo2M92ZJEaoI1e0L5CZAxmbxEpqCi8xkC4+aQB2j1KVwVcnBc/u4TKEtjxI+l3xpuLi4TaoSu3E8fvQR7URD14W5lELs17H/x00jV1UCdXcISr0nv9EB8d552YAEYwC1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083520; c=relaxed/simple;
	bh=/Dm+qwX8wVyCpZ70oiC6m7CBQZZFJskkc3MekGmehnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMqe2gilkr2Ligk9ZZeOoyBx/omx4uY/1Qu6Fg1TBOQb3vOV3uPkkCo7Aks/uQhDmDIOfJ6HXQJll8A6fffoRK4dv8ZL3k1alveHN/iTzZ6WG6mo+jpqjPs7s2tGD2e9ZvDbZoLHI2WsyU2G/+O0qZDjSPtdHDGPUe7G74NTPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvCOeYwf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755083518; x=1786619518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Dm+qwX8wVyCpZ70oiC6m7CBQZZFJskkc3MekGmehnU=;
  b=YvCOeYwfqoI4L/mfjNFITYxFNzVkzGOwYXTEK7rMamCuZ4odwDLDvvzn
   oUHR53KJ+5LHDE4HQJvF1/yLy8i4vJc1IeifY7KVNOB4BjWePQKSlh7yM
   u271nksv0eK9phHxlh4bO7YVplkgkr9jT4yF3Vvfqaha8VL1AvVydQGPx
   we+IImjPB03yihFog6P3ieI84NVrNlXJgqMhsaQQ1VtaNDy8YrrT9GQM/
   C9xn5+YsYBUHxMWVYfMO0eDE57ccnzLDS0HPf0GBtt0vZiSeKSKsJhEHq
   UuoycOGOYbxs/5XQuyz7cKlbDU3DxpSlKq1U5eEixXU9kf6SIkPxPj5Zn
   A==;
X-CSE-ConnectionGUID: 0IQBATboQQ+KrMA5nkSE0w==
X-CSE-MsgGUID: OYNEi69VRVSYalqEZJSeqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74951181"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74951181"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:11:58 -0700
X-CSE-ConnectionGUID: KXnPdVHUSHGwdB6eyyGEPw==
X-CSE-MsgGUID: FhewV+MfTeKcPLkq4DTnGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165628923"
Received: from aotchere-mobl1.jer.intel.com ([10.13.73.232])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:11:55 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	maheshkkv@google.com,
	quic_vganneva@quicinc.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v3 1/4] wifi: nl80211: Add more configuration options for NAN commands
Date: Wed, 13 Aug 2025 17:10:45 +0300
Message-ID: <20250813141048.100884-2-andrei.otcheretianski@intel.com>
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

Current NAN APIs have only basic configuration for master
preference and operating bands. Add and parse additional parameters
which provide more control over NAN synchronization. The newly added
attributes allow to publish additional NAN attributes and vendor
elements in NAN beacons, control scan and discovery beacons
periodicity, enable/disable DW notifications etc.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/net/cfg80211.h       |  60 +++++++
 include/uapi/linux/nl80211.h | 111 ++++++++++++-
 net/wireless/nl80211.c       | 298 +++++++++++++++++++++++++++++++----
 3 files changed, 432 insertions(+), 37 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc8..e53a4ed48c58 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3886,6 +3886,38 @@ struct cfg80211_qos_map {
 	struct cfg80211_dscp_range up[8];
 };
 
+/**
+ * struct cfg80211_nan_band_config - NAN band specific configuration
+ *
+ * @chan: Pointer to the IEEE 802.11 channel structure. The channel to be used
+ *	for NAN operations on this band. For 2.4 GHz band, this is always
+ *	channel 6. For 5 GHz band, the channel is either 44 or 149, according
+ *	to the regulatory constraints. If chan pointer is NULL the entire band
+ *	configuration entry is considered invalid and should not be used.
+ * @rssi_close: RSSI close threshold used for NAN state transition algorithm
+ *	as described in chapters 3.3.6 and 3.3.7 "NAN Device Role and State
+ *	Transition" of Wi-Fi Aware Specification v4.0. If not
+ *	specified (set to 0), default device value is used. The value should
+ *	be greater than -60 dBm.
+ * @rssi_middle: RSSI middle threshold used for NAN state transition algorithm.
+ *	as described in chapters 3.3.6 and 3.3.7 "NAN Device Role and State
+ *	Transition" of Wi-Fi Aware Specification v4.0. If not
+ *	specified (set to 0), default device value is used. The value should be
+ *	greater than -75 dBm and less than rssi_close.
+ * @awake_dw_interval: Committed DW interval. Valid values range: 0-5. 0
+ *	indicates no wakeup for DW and can't be used on 2.4GHz band, otherwise
+ *	2^(n-1).
+ * @disable_scan: If true, the device will not scan this band for cluster
+ *	 merge. Disabling scan on 2.4 GHz band is not allowed.
+ */
+struct cfg80211_nan_band_config {
+	struct ieee80211_channel *chan;
+	s8 rssi_close;
+	s8 rssi_middle;
+	u8 awake_dw_interval;
+	bool disable_scan;
+};
+
 /**
  * struct cfg80211_nan_conf - NAN configuration
  *
@@ -3895,10 +3927,31 @@ struct cfg80211_qos_map {
  * @bands: operating bands, a bitmap of &enum nl80211_band values.
  *	For instance, for NL80211_BAND_2GHZ, bit 0 would be set
  *	(i.e. BIT(NL80211_BAND_2GHZ)).
+ * @cluster_id: cluster ID used for NAN synchronization. This is a MAC address
+ *	that can take a value from 50-6F-9A-01-00-00 to 50-6F-9A-01-FF-FF.
+ *	If NULL, the device will pick a random Cluster ID.
+ * @scan_period: period (in seconds) between NAN scans.
+ * @scan_dwell_time: dwell time (in milliseconds) for NAN scans.
+ * @discovery_beacon_interval: interval (in TUs) for discovery beacons.
+ * @band_cfgs: array of band specific configurations, indexed by
+ *	&enum nl80211_band values.
+ * @extra_nan_attrs: pointer to additional NAN attributes.
+ * @extra_nan_attrs_len: length of the additional NAN attributes.
+ * @vendor_elems: pointer to vendor-specific elements.
+ * @vendor_elems_len: length of the vendor-specific elements.
  */
 struct cfg80211_nan_conf {
 	u8 master_pref;
 	u8 bands;
+	const u8 *cluster_id;
+	u16 scan_period;
+	u16 scan_dwell_time;
+	u8 discovery_beacon_interval;
+	struct cfg80211_nan_band_config band_cfgs[NUM_NL80211_BANDS];
+	const u8 *extra_nan_attrs;
+	u16 extra_nan_attrs_len;
+	const u8 *vendor_elems;
+	u16 vendor_elems_len;
 };
 
 /**
@@ -3907,10 +3960,17 @@ struct cfg80211_nan_conf {
  *
  * @CFG80211_NAN_CONF_CHANGED_PREF: master preference
  * @CFG80211_NAN_CONF_CHANGED_BANDS: operating bands
+ * @CFG80211_NAN_CONF_CHANGED_CONFIG: changed additional configuration.
+ *	When this flag is set, it indicates that some additional attribute(s)
+ *	(other then master_pref and bands) have been changed. In this case,
+ *	all the unchanged attributes will be properly configured to their
+ *	previous values. The driver doesn't need to store any
+ *	previous configuration besides master_pref and bands.
  */
 enum cfg80211_nan_conf_changes {
 	CFG80211_NAN_CONF_CHANGED_PREF = BIT(0),
 	CFG80211_NAN_CONF_CHANGED_BANDS = BIT(1),
+	CFG80211_NAN_CONF_CHANGED_CONFIG = BIT(2),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d1a14f2892d9..9c84f44deadd 100644
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
@@ -1115,6 +1116,10 @@
  *	current configuration is not changed.  If it is present but
  *	set to zero, the configuration is changed to don't-care
  *	(i.e. the device can decide what to do).
+ *	Additional parameters may be provided with
+ *	%NL80211_ATTR_NAN_CONFIG. User space should provide all previously
+ *	configured nested attributes under %NL80211_ATTR_NAN_CONFIG, even if
+ *	only a subset was changed.
  * @NL80211_CMD_NAN_MATCH: Notification sent when a match is reported.
  *	This will contain a %NL80211_ATTR_NAN_MATCH nested attribute and
  *	%NL80211_ATTR_COOKIE.
@@ -2928,6 +2933,12 @@ enum nl80211_commands {
  *	required alongside this attribute. Refer to
  *	@enum nl80211_s1g_short_beacon_attrs for the attribute definitions.
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
@@ -3490,6 +3501,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_LONG_BEACON_PERIOD,
 	NL80211_ATTR_S1G_SHORT_BEACON,
 
+	NL80211_ATTR_NAN_CONFIG,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7278,6 +7291,100 @@ enum nl80211_nan_match_attributes {
 	NL80211_NAN_MATCH_ATTR_MAX = NUM_NL80211_NAN_MATCH_ATTR - 1
 };
 
+/**
+ * enum nl80211_nan_band_conf_attributes - NAN band configuration attributes
+ * @__NL80211_NAN_BAND_CONF_INVALID: Invalid.
+ * @NL80211_NAN_BAND_CONF_BAND: Band for which the configuration is
+ *	being set. The value is according to &enum nl80211_band (u8).
+ * @NL80211_NAN_BAND_CONF_FREQ: Discovery frequency. This attribute shall not
+ *	be present on 2.4 GHZ band. On 5 GHz band its presence is optional.
+ *	The allowed values are 5220 (channel 44) or 5745 (channel 149).
+ *	If not present, channel 149 is used if allowed, otherwise channel 44
+ *	will be selected. The value is in MHz (u16).
+ * @NL80211_NAN_BAND_CONF_RSSI_CLOSE: RSSI close threshold used for NAN state
+ *	transition algorithm as described in chapters 3.3.6 and 3.3.7 "NAN
+ *	Device Role and State Transition" of Wi-Fi Aware (TM) Specification
+ *	v4.0. If not specified, default device value is used. The value should
+ *	be greater than -60 dBm (s8).
+ * @NL80211_NAN_BAND_CONF_RSSI_MIDDLE: RSSI middle threshold used for NAN state
+ *	transition algorithm as described in chapters 3.3.6 and 3.3.7 "NAN
+ *	Device Role and State Transition" of Wi-Fi Aware (TM) Specification
+ *	v4.0. If not present, default device value is used. The value should be
+ *	greater than -75 dBm and less than %NL80211_NAN_BAND_CONF_RSSI_CLOSE
+ *	(s8).
+ * @NL80211_NAN_BAND_CONF_WAKE_DW: Committed DW information (values 0-5).
+ *	Value 0 means that the device will not wake up during the
+ *	discovery window. Values 1-5 mean that the device will wake up
+ *	during each 2^(n - 1) discovery window, where n is the value of
+ *	this attribute. Setting this attribute to 0 is not allowed on
+ *	2.4 GHz band (u8). This is an optional parameter (default is 1).
+ * @NL80211_NAN_BAND_CONF_DISABLE_SCAN: Optional flag attribute to disable
+ *	scanning (for cluster merge) on the band. If set, the device will not
+ *	scan on this band anymore. Disabling scanning on 2.4 GHz band is not
+ *	allowed.
+ * @NUM_NL80211_NAN_BAND_CONF_ATTR: Internal.
+ * @NL80211_NAN_BAND_CONF_ATTR_MAX: Highest NAN band configuration attribute.
+ *
+ * These attributes are used to configure NAN band-specific parameters. Note,
+ * that both RSSI attributes should be configured (or both left unset).
+ */
+enum nl80211_nan_band_conf_attributes {
+	__NL80211_NAN_BAND_CONF_INVALID,
+	NL80211_NAN_BAND_CONF_BAND,
+	NL80211_NAN_BAND_CONF_FREQ,
+	NL80211_NAN_BAND_CONF_RSSI_CLOSE,
+	NL80211_NAN_BAND_CONF_RSSI_MIDDLE,
+	NL80211_NAN_BAND_CONF_WAKE_DW,
+	NL80211_NAN_BAND_CONF_DISABLE_SCAN,
+
+	/* keep last */
+	NUM_NL80211_NAN_BAND_CONF_ATTR,
+	NL80211_NAN_BAND_CONF_ATTR_MAX = NUM_NL80211_NAN_BAND_CONF_ATTR - 1,
+};
+
+/**
+ * enum nl80211_nan_conf_attributes - NAN configuration attributes
+ * @__NL80211_NAN_CONF_INVALID: Invalid attribute, used for validation.
+ * @NL80211_NAN_CONF_CLUSTER_ID: ID for the NAN cluster. This is a MAC
+ *	address that can take values from 50-6F-9A-01-00-00 to
+ *	50-6F-9A-01-FF-FF. This attribute is optional. If not present,
+ *	a random Cluster ID will be chosen.
+ * @NL80211_NAN_CONF_EXTRA_ATTRS: Additional NAN attributes to be
+ *	published in the beacons. This is an optional byte array.
+ * @NL80211_NAN_CONF_VENDOR_ELEMS: Vendor-specific elements that will
+ *	be published in the beacons. This is an optional byte array.
+ * @NL80211_NAN_CONF_BAND_CONFIGS: This is a nested array attribute,
+ *	containing multiple entries for each supported band. Each band
+ *	configuration consists of &enum nl80211_nan_band_conf_attributes.
+ * @NL80211_NAN_CONF_SCAN_PERIOD: Scan period in seconds. If not configured,
+ *	device default is used. Zero value will disable scanning.
+ *	This is u16 (optional).
+ * @NL80211_NAN_CONF_SCAN_DWELL_TIME: Scan dwell time in TUs per channel.
+ *	Only non-zero values are valid. If not configured the device default
+ *	value is used. This is u16 (optional)
+ * @NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL: Discovery beacon interval
+ *	in TUs. Valid range is 50-200 TUs. If not configured the device default
+ *	value is used. This is u8 (optional)
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
+	NL80211_NAN_CONF_BAND_CONFIGS,
+	NL80211_NAN_CONF_SCAN_PERIOD,
+	NL80211_NAN_CONF_SCAN_DWELL_TIME,
+	NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL,
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
index 89519aa52893..0c79fd6f101d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -312,6 +312,26 @@ static int validate_supported_selectors(const struct nlattr *attr,
 	return 0;
 }
 
+static int validate_nan_cluster_id(const struct nlattr *attr,
+				   struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+	static const u8 cluster_id_prefix[4] = {0x50, 0x6f, 0x9a, 0x1};
+
+	if (len != ETH_ALEN) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "bad cluster id length");
+		return -EINVAL;
+	}
+
+	if (memcmp(data, cluster_id_prefix, sizeof(cluster_id_prefix))) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "invalid cluster id prefix");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* policy for the attributes */
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
 
@@ -492,6 +512,35 @@ nl80211_s1g_short_beacon[NL80211_S1G_SHORT_BEACON_ATTR_MAX + 1] = {
 				       IEEE80211_MAX_DATA_LEN),
 };
 
+static const struct nla_policy
+nl80211_nan_band_conf_policy[NL80211_NAN_BAND_CONF_ATTR_MAX + 1] = {
+	[NL80211_NAN_BAND_CONF_BAND] = NLA_POLICY_MAX(NLA_U8,
+						      NUM_NL80211_BANDS - 1),
+	[NL80211_NAN_BAND_CONF_FREQ] = { .type = NLA_U16 },
+	[NL80211_NAN_BAND_CONF_RSSI_CLOSE] = NLA_POLICY_MIN(NLA_S8, -59),
+	[NL80211_NAN_BAND_CONF_RSSI_MIDDLE] = NLA_POLICY_MIN(NLA_S8, -74),
+	[NL80211_NAN_BAND_CONF_WAKE_DW] = NLA_POLICY_MAX(NLA_U8, 5),
+	[NL80211_NAN_BAND_CONF_DISABLE_SCAN] = { .type = NLA_FLAG },
+};
+
+static const struct nla_policy
+nl80211_nan_conf_policy[NL80211_NAN_CONF_ATTR_MAX + 1] = {
+	[NL80211_NAN_CONF_CLUSTER_ID] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_nan_cluster_id,
+				       ETH_ALEN),
+	[NL80211_NAN_CONF_EXTRA_ATTRS] = { .type = NLA_BINARY,
+					   .len = IEEE80211_MAX_DATA_LEN},
+	[NL80211_NAN_CONF_VENDOR_ELEMS] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
+				       IEEE80211_MAX_DATA_LEN),
+	[NL80211_NAN_CONF_BAND_CONFIGS] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_nan_band_conf_policy),
+	[NL80211_NAN_CONF_SCAN_PERIOD] = { .type = NLA_U16 },
+	[NL80211_NAN_CONF_SCAN_DWELL_TIME] = NLA_POLICY_RANGE(NLA_U16, 50, 512),
+	[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL] =
+		NLA_POLICY_RANGE(NLA_U8, 50, 200),
+};
+
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
@@ -761,6 +810,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MU_MIMO_FOLLOW_MAC_ADDR] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
 	[NL80211_ATTR_NAN_MASTER_PREF] = NLA_POLICY_MIN(NLA_U8, 1),
 	[NL80211_ATTR_BANDS] = { .type = NLA_U32 },
+	[NL80211_ATTR_NAN_CONFIG] = NLA_POLICY_NESTED(nl80211_nan_conf_policy),
 	[NL80211_ATTR_NAN_FUNC] = { .type = NLA_NESTED },
 	[NL80211_ATTR_FILS_KEK] = { .type = NLA_BINARY,
 				    .len = FILS_MAX_KEK_LEN },
@@ -15105,6 +15155,211 @@ static int nl80211_stop_p2p_device(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static struct ieee80211_channel *nl80211_get_nan_channel(struct wiphy *wiphy,
+							 int freq)
+{
+	struct ieee80211_channel *chan;
+	struct cfg80211_chan_def def;
+
+	/* Check if the frequency is valid for NAN */
+	if (freq != 5220 && freq != 5745 && freq != 2437)
+		return NULL;
+
+	chan = ieee80211_get_channel(wiphy, freq);
+	if (!chan)
+		return NULL;
+
+	cfg80211_chandef_create(&def, chan, NL80211_CHAN_NO_HT);
+
+	/* Check if the channel is allowed */
+	if (cfg80211_reg_can_beacon(wiphy, &def, NL80211_IFTYPE_NAN))
+		return chan;
+
+	return NULL;
+}
+
+static int nl80211_parse_nan_band_config(struct wiphy *wiphy,
+					 struct nlattr **tb,
+					 struct cfg80211_nan_band_config *cfg,
+					 enum nl80211_band band)
+{
+	if (BIT(band) & ~(u32)wiphy->nan_supported_bands)
+		return -EINVAL;
+
+	if (tb[NL80211_NAN_BAND_CONF_FREQ]) {
+		u16 freq = nla_get_u16(tb[NL80211_NAN_BAND_CONF_FREQ]);
+
+		if (band != NL80211_BAND_5GHZ)
+			return -EINVAL;
+
+		cfg->chan = nl80211_get_nan_channel(wiphy, freq);
+		if (!cfg->chan)
+			return -EINVAL;
+	}
+
+	if (tb[NL80211_NAN_BAND_CONF_RSSI_CLOSE]) {
+		cfg->rssi_close =
+			nla_get_s8(tb[NL80211_NAN_BAND_CONF_RSSI_CLOSE]);
+		if (!tb[NL80211_NAN_BAND_CONF_RSSI_MIDDLE])
+			return -EINVAL;
+	}
+
+	if (tb[NL80211_NAN_BAND_CONF_RSSI_MIDDLE]) {
+		cfg->rssi_middle =
+			nla_get_s8(tb[NL80211_NAN_BAND_CONF_RSSI_MIDDLE]);
+		if (!cfg->rssi_close || cfg->rssi_middle >= cfg->rssi_close)
+			return -EINVAL;
+	}
+
+	if (tb[NL80211_NAN_BAND_CONF_WAKE_DW]) {
+		cfg->awake_dw_interval =
+			nla_get_u8(tb[NL80211_NAN_BAND_CONF_WAKE_DW]);
+
+		if (band == NL80211_BAND_2GHZ && cfg->awake_dw_interval == 0)
+			return -EINVAL;
+	}
+
+	cfg->disable_scan =
+		nla_get_flag(tb[NL80211_NAN_BAND_CONF_DISABLE_SCAN]);
+	return 0;
+}
+
+static int nl80211_parse_nan_conf(struct wiphy *wiphy,
+				  struct genl_info *info,
+				  struct cfg80211_nan_conf *conf,
+				  u32 *changed_flags)
+{
+	struct nlattr *attrs[NL80211_NAN_CONF_ATTR_MAX + 1];
+	int err, rem;
+	u32 changed = 0;
+	struct nlattr *band_config;
+
+	if (info->attrs[NL80211_ATTR_NAN_MASTER_PREF]) {
+		conf->master_pref =
+			nla_get_u8(info->attrs[NL80211_ATTR_NAN_MASTER_PREF]);
+
+		changed |= CFG80211_NAN_CONF_CHANGED_PREF;
+	}
+
+	if (info->attrs[NL80211_ATTR_BANDS]) {
+		u32 bands = nla_get_u32(info->attrs[NL80211_ATTR_BANDS]);
+
+		if (bands & ~(u32)wiphy->nan_supported_bands)
+			return -EOPNOTSUPP;
+
+		if (bands && !(bands & BIT(NL80211_BAND_2GHZ)))
+			return -EINVAL;
+
+		conf->bands = bands;
+		changed |= CFG80211_NAN_CONF_CHANGED_BANDS;
+	}
+
+	conf->band_cfgs[NL80211_BAND_2GHZ].awake_dw_interval = 1;
+	if (conf->bands & BIT(NL80211_BAND_5GHZ) || !conf->bands)
+		conf->band_cfgs[NL80211_BAND_5GHZ].awake_dw_interval = 1;
+
+	/* On 2.4 GHz band use channel 6 */
+	conf->band_cfgs[NL80211_BAND_2GHZ].chan =
+		nl80211_get_nan_channel(wiphy, 2437);
+	if (!conf->band_cfgs[NL80211_BAND_2GHZ].chan)
+		return -EINVAL;
+
+	if (!info->attrs[NL80211_ATTR_NAN_CONFIG])
+		goto out;
+
+	err = nla_parse_nested(attrs, NL80211_NAN_CONF_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_NAN_CONFIG], NULL,
+			       info->extack);
+	if (err)
+		return err;
+
+	changed |= CFG80211_NAN_CONF_CHANGED_CONFIG;
+	if (attrs[NL80211_NAN_CONF_CLUSTER_ID])
+		conf->cluster_id =
+			nla_data(attrs[NL80211_NAN_CONF_CLUSTER_ID]);
+
+	if (attrs[NL80211_NAN_CONF_EXTRA_ATTRS]) {
+		conf->extra_nan_attrs =
+			nla_data(attrs[NL80211_NAN_CONF_EXTRA_ATTRS]);
+		conf->extra_nan_attrs_len =
+			nla_len(attrs[NL80211_NAN_CONF_EXTRA_ATTRS]);
+	}
+
+	if (attrs[NL80211_NAN_CONF_VENDOR_ELEMS]) {
+		conf->vendor_elems =
+			nla_data(attrs[NL80211_NAN_CONF_VENDOR_ELEMS]);
+		conf->vendor_elems_len =
+			nla_len(attrs[NL80211_NAN_CONF_VENDOR_ELEMS]);
+	}
+
+	if (attrs[NL80211_NAN_CONF_BAND_CONFIGS]) {
+		nla_for_each_nested(band_config,
+				    attrs[NL80211_NAN_CONF_BAND_CONFIGS],
+				    rem) {
+			enum nl80211_band band;
+			struct cfg80211_nan_band_config *cfg;
+			struct nlattr *tb[NL80211_NAN_BAND_CONF_ATTR_MAX + 1];
+
+			err = nla_parse_nested(tb,
+					       NL80211_NAN_BAND_CONF_ATTR_MAX,
+					       band_config, NULL,
+					       info->extack);
+			if (err)
+				return err;
+
+			if (!tb[NL80211_NAN_BAND_CONF_BAND])
+				return -EINVAL;
+
+			band = nla_get_u8(tb[NL80211_NAN_BAND_CONF_BAND]);
+			if (conf->bands && !(conf->bands & BIT(band)))
+				return -EINVAL;
+
+			cfg = &conf->band_cfgs[band];
+
+			err = nl80211_parse_nan_band_config(wiphy, tb, cfg,
+							    band);
+			if (err)
+				return err;
+		}
+	}
+
+	if (attrs[NL80211_NAN_CONF_SCAN_PERIOD])
+		conf->scan_period =
+			nla_get_u16(attrs[NL80211_NAN_CONF_SCAN_PERIOD]);
+
+	if (attrs[NL80211_NAN_CONF_SCAN_DWELL_TIME])
+		conf->scan_dwell_time =
+			nla_get_u16(attrs[NL80211_NAN_CONF_SCAN_DWELL_TIME]);
+
+	if (attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL])
+		conf->discovery_beacon_interval =
+			nla_get_u8(attrs[NL80211_NAN_CONF_DISCOVERY_BEACON_INTERVAL]);
+out:
+	if (!conf->band_cfgs[NL80211_BAND_5GHZ].chan &&
+	    (!conf->bands || conf->bands & BIT(NL80211_BAND_5GHZ))) {
+		/* If no 5GHz channel is specified use default, if possible */
+		conf->band_cfgs[NL80211_BAND_5GHZ].chan =
+				nl80211_get_nan_channel(wiphy, 5745);
+		if (!conf->band_cfgs[NL80211_BAND_5GHZ].chan)
+			conf->band_cfgs[NL80211_BAND_5GHZ].chan =
+					nl80211_get_nan_channel(wiphy, 5220);
+
+		/* Return error if user space asked explicitly for 5 GHz */
+		if (!conf->band_cfgs[NL80211_BAND_5GHZ].chan &&
+		    conf->bands & BIT(NL80211_BAND_5GHZ)) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    info->attrs[NL80211_ATTR_BANDS],
+					    "5 GHz band operation is not allowed");
+			return -EINVAL;
+		}
+	}
+
+	if (changed_flags)
+		*changed_flags = changed;
+
+	return 0;
+}
+
 static int nl80211_start_nan(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -15121,23 +15376,13 @@ static int nl80211_start_nan(struct sk_buff *skb, struct genl_info *info)
 	if (rfkill_blocked(rdev->wiphy.rfkill))
 		return -ERFKILL;
 
+	/* Master preference is mandatory for START_NAN */
 	if (!info->attrs[NL80211_ATTR_NAN_MASTER_PREF])
 		return -EINVAL;
 
-	conf.master_pref =
-		nla_get_u8(info->attrs[NL80211_ATTR_NAN_MASTER_PREF]);
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
-	}
+	err = nl80211_parse_nan_conf(&rdev->wiphy, info, &conf, NULL);
+	if (err)
+		return err;
 
 	err = rdev_start_nan(rdev, wdev, &conf);
 	if (err)
@@ -15493,6 +15738,7 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_nan_conf conf = {};
 	u32 changed = 0;
+	int err;
 
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
@@ -15500,27 +15746,9 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
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
2.47.1


