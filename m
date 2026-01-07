Return-Path: <linux-wireless+bounces-30456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD6CFE229
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B73730E2BAE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE632AAC2;
	Wed,  7 Jan 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wjtd6JRW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF632A3FB
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792032; cv=none; b=hrSph+e+gOGvGeLGuhKLuuvapyaeT9M0o2vL6m+FUa2uDaFQGLBAjq96xg6IYUNK2qMQaXgoEO88mppa90OOOOFGJg52N+a/rjgm7LF7b7mUJC+zfZsklTTFM5Ac8UOJxRBLfVwVCX6shVLGVSmhjZWRSNNSAH7kra+F7yFIKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792032; c=relaxed/simple;
	bh=tciIBYOGqOA37zLzioElNiwJVGvDeY1045lg1UCPx8c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzxUgbH7wKkb2TEEvwaFPpmcEqeYujq76Y1xVQHOOGcrzf/73t/H5nGmyiIKLzzwPvnCkl/8j+ki6C6lrIsCZ9ywikwegsKI7M4s1/5NX+46WMQWyAAApjfaEbjSeRmYXyazYtCkT0HkRnzTo/w2bOcGXiR0Vy1zZcZ0rBi7m5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wjtd6JRW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792027; x=1799328027;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tciIBYOGqOA37zLzioElNiwJVGvDeY1045lg1UCPx8c=;
  b=Wjtd6JRWi+D1CbrHRrLQvbF5skewLLKYm1laPQVvWogbQpqeDDNDaZmB
   zFPpBINGYnda7LfVig689puvMHUqnoViSVzKTVF4ucAp0U31XyVi1M4/l
   vpOEylEuu0sUHNhEYu5Hi9iV8Z8N0nHh+O6ifcgk3udiDLs8+shDCMt8C
   vd137eT/RQdo5E+cAkCHuhkMCOMLQqp7EfflrT14zYoA/fROhEu/JGMzZ
   Ks3L/hag1QEBJNW0OR8Lv2gVuJQx6ppJmbs6+B6iWN1WilTfiq7/sbjnS
   qTTNTNmiTYD8R3hFpStjxjiLnurB8BaMCi2lD6JKrInvABEyqs9J6RCHC
   Q==;
X-CSE-ConnectionGUID: 70QONceKQtm2BmUo756TDA==
X-CSE-MsgGUID: E/4ZxxTiRy+iYoDWGS4TLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576869"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576869"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:27 -0800
X-CSE-ConnectionGUID: wjxW04TYSHGNLtNGOT8LeA==
X-CSE-MsgGUID: nztn8XYaQ7OlUHF/2kqs/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185783"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 11/15] wifi: nl80211: define an API for configuring the NAN peer's schedule
Date: Wed,  7 Jan 2026 15:19:59 +0200
Message-Id: <20260107150057.dfbbdff3208b.If0e214ff5b52c9666e985fefa3f7be0ad14d93fb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add an NL80211 command to configure the NAN schedule of a NAN peer.
Such a schedule contains a list of NAN channels, and a mapping from each
time slots to the corresponding channel (or unscheduled).
Also contains more information about the schedule, such as sequence ID
and map ID.

Not all of the restrictions are validated in this patch. In particular,
comparison of two maps of the same peer requires storing/retrieving each
map of each peer, only for validation.
Therefore, it is the responsibilty of the driver to check that.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  58 ++++++
 include/uapi/linux/nl80211.h |  79 ++++++-
 net/wireless/nl80211.c       | 393 ++++++++++++++++++++++++++++++++---
 net/wireless/rdev-ops.h      |  16 ++
 net/wireless/trace.h         |  28 +++
 5 files changed, 542 insertions(+), 32 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 197b53c9726e..9495c5e57ace 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4109,6 +4109,54 @@ struct cfg80211_nan_local_sched {
 	struct cfg80211_nan_channel nan_channels[] __counted_by(n_channels);
 };
 
+/**
+ * struct cfg80211_nan_peer_map - NAN peer schedule map
+ *
+ * This struct defines a single NAN peer schedule map
+ *
+ * @map_id: map ID of this schedule map
+ * @schedule: a mapping of time slots to chandef indexes in the schedule's
+ *	@nan_channels. Each slot lasts 16TUs. An unscheduled slot will be
+ *	set to %NL80211_NAN_SCHED_NOT_AVAIL_SLOT.
+ */
+struct cfg80211_nan_peer_map {
+	u8 map_id;
+	u8 schedule[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
+};
+
+#define CFG80211_NAN_MAX_PEER_MAPS 2
+#define CFG80211_NAN_INVALID_MAP_ID 0xff
+
+/**
+ * struct cfg80211_nan_peer_sched - NAN peer schedule
+ *
+ * This struct defines NAN peer schedule parameters for a peer.
+ *
+ * @peer_addr: MAC address of the peer (NMI address)
+ * @seq_id: sequence ID of the peer schedule.
+ * @committed_dw: committed DW as published by the peer.
+ *	See %NL80211_ATTR_NAN_COMMITTED_DW
+ * @max_chan_switch: maximum channel switch time in microseconds as published
+ *	by the peer. See %NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME.
+ * @init_ulw: initial ULWs as published by the peer.
+ * @ulw_size: number of bytes in @init_ulw.
+ * @n_channels: number of channel definitions in @nan_channels.
+ * @nan_channels: array of NAN channel definitions for this schedule.
+ * @maps: array of peer schedule maps. Unused entries have
+ *	map_id = %CFG80211_NAN_INVALID_MAP_ID.
+ */
+struct cfg80211_nan_peer_sched {
+	const u8 *peer_addr;
+	u8 seq_id;
+	u16 committed_dw;
+	u16 max_chan_switch;
+	const u8 *init_ulw;
+	u16 ulw_size;
+	u8 n_channels;
+	struct cfg80211_nan_channel *nan_channels;
+	struct cfg80211_nan_peer_map maps[CFG80211_NAN_MAX_PEER_MAPS];
+};
+
 /**
  * enum cfg80211_nan_conf_changes - indicates changed fields in NAN
  * configuration
@@ -4888,6 +4936,13 @@ struct mgmt_frame_regs {
  *	radio should operate on. If the chandef of a NAN channel is not
  *	changed, the channel entry must also remain unchanged. It is the
  *	driver's responsibility to verify this.
+ * @nan_set_peer_sched: configure the peer schedule for NAN. The schedule
+ *	consists of an array of %cfg80211_nan_channel and the schedule itself,
+ *	in which each entry maps each time slot to a channel on which the
+ *	radio should operate on. In addition, it contains more peer's schedule
+ *	information such as committed DW, etc. When updating an existing peer
+ *	schedule, the full new schedule is provided - partial updates are not
+ *	supported, and the new schedule completely replaces the previous one.
  *
  * @set_multicast_to_unicast: configure multicast to unicast conversion for BSS
  *
@@ -5268,6 +5323,9 @@ struct cfg80211_ops {
 	int	(*nan_set_local_sched)(struct wiphy *wiphy,
 				       struct wireless_dev *wdev,
 				       struct cfg80211_nan_local_sched *sched);
+	int	(*nan_set_peer_sched)(struct wiphy *wiphy,
+				      struct wireless_dev *wdev,
+				      struct cfg80211_nan_peer_sched *sched);
 	int	(*set_multicast_to_unicast)(struct wiphy *wiphy,
 					    struct net_device *dev,
 					    const bool enabled);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6f921168e6a2..8c8ed55d357f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1365,6 +1365,26 @@
  *	%NL80211_ATTR_NAN_TIME_SLOTS, but %NL80211_ATTR_NAN_CHANNEL is optional.
  *	(for example in case of a channel removal, that channel won't be
  *	provided).
+ * @NL80211_CMD_NAN_SET_PEER_SCHED: Set the peer NAN schedule. NAN
+ *	must be operational (%NL80211_CMD_START_NAN was executed).
+ *	Required attributes: %NL80211_ATTR_MAC (peer NMI address) and
+ *	%NL80211_ATTR_NAN_COMMITTED_DW.
+ *	Optionally, the full schedule can be provided by including all of:
+ *	%NL80211_ATTR_NAN_SEQ_ID, %NL80211_ATTR_NAN_CHANNEL (one or more), and
+ *	%NL80211_ATTR_NAN_PEER_MAPS (see &enum nl80211_nan_peer_map_attrs).
+ *	If any of these three optional attributes is provided, all three must
+ *	be provided.
+ *	Each peer channel must be compatible with at least one local channel
+ *	set by %NL80211_CMD_SET_LOCAL_NAN_SCHED. Different maps must not
+ *	contain compatible channels.
+ *	For single-radio devices (n_radio <= 1), different maps must not
+ *	schedule the same time slot, as the device cannot operate on multiple
+ *	channels simultaneously.
+ *	When updating an existing peer schedule, the full new schedule must be
+ *	provided - partial updates are not supported. The new schedule will
+ *	completely replace the previous one.
+ *	The peer schedule is automatically removed when the NMI station is
+ *	removed.
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1629,6 +1649,7 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_CLUSTER_JOINED,
 
 	NL80211_CMD_NAN_SET_LOCAL_SCHED,
+	NL80211_CMD_NAN_SET_PEER_SCHED,
 
 	/* add new commands above here */
 
@@ -2988,8 +3009,12 @@ enum nl80211_commands {
  *	This attribute is used with %NL80211_CMD_NAN_SET_LOCAL_SCHED to specify
  *	the channel definitions on which the radio needs to operate during
  *	specific time slots. All of the channel definitions should be mutually
- *	incompatible. The number of channels should fit the current
- *	configuration of channels and the possible interface combinations.
+ *	incompatible.
+ *	This is also used with %NL80211_CMD_NAN_SET_PEER_SCHED to configure the
+ *	peer NAN channels. In that case, the channel definitions can be
+ *	compatible to each other, or even identical just with different RX NSS.
+ *	The number of channels should fit the current configuration of channels
+ *	and the possible interface combinations.
  *	If an existing NAN channel is changed but the chandef isn't, the
  *	channel entry must also remain unchanged.
  * @NL80211_ATTR_NAN_CHANNEL_ENTRY: a byte array of 6 bytes. contains the
@@ -3009,6 +3034,24 @@ enum nl80211_commands {
  * @NL80211_ATTR_NAN_NMI_MAC: The address of the NMI station to which this NDI
  *	station belongs. Used with %NL80211_CMD_NEW_STATION when adding an NDI
  *	station.
+ * @NL80211_ATTR_NAN_INIT_ULW: (Binary) The initial ULW(s) as published by the
+ *	peer, as defined in the Wi-Fi Aware (TM) 4.0 specification Table 109
+ *	(Unaligned Schedule attribute format). Used to configure the device
+ *	with the initial ULW(s) of a peer, before the device starts tracking it.
+ * @NL80211_ATTR_NAN_COMMITTED_DW: (u16) The committed DW as published by the
+ *	peer, as defined in the Wi-Fi Aware (TM) 4.0 specification Table 80
+ *	(Committed DW Information field format).
+ * @NL80211_ATTR_NAN_SEQ_ID: (u8) The sequence ID of the peer schedule that
+ *	%NL80211_CMD_NAN_SET_PEER_SCHED defines. The device follows the
+ *	sequence ID in the frames to identify newer schedules. Once a schedule
+ *	with a higher sequence ID is received, the device may stop communicating
+ *	with that peer until a new peer schedule with a matching sequence ID is
+ *	received.
+ * @NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME: (u16) The maximum channel switch
+ *	time, in microseconds.
+ * @NL80211_ATTR_NAN_PEER_MAPS: Nested array of peer schedule maps.
+ *	Used with %NL80211_CMD_NAN_SET_PEER_SCHED. Contains up to 2 entries,
+ *	each containing nested attributes from &enum nl80211_nan_peer_map_attrs.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3585,6 +3628,12 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_NAN_NMI_MAC,
 
+	NL80211_ATTR_NAN_INIT_ULW,
+	NL80211_ATTR_NAN_COMMITTED_DW,
+	NL80211_ATTR_NAN_SEQ_ID,
+	NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME,
+	NL80211_ATTR_NAN_PEER_MAPS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8523,6 +8572,32 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
 };
 
+/**
+ * enum nl80211_nan_peer_map_attrs - NAN peer schedule map attributes
+ *
+ * Nested attributes used within %NL80211_ATTR_NAN_PEER_MAPS to define
+ * individual peer schedule maps.
+ *
+ * @__NL80211_NAN_PEER_MAP_ATTR_INVALID: Invalid
+ * @NL80211_NAN_PEER_MAP_ATTR_MAP_ID: (u8) The map ID for this schedule map.
+ * @NL80211_NAN_PEER_MAP_ATTR_TIME_SLOTS: An array of u8 values with 32 cells.
+ *	Each value maps a time slot to a channel index within the schedule's
+ *	channel list (%NL80211_ATTR_NAN_CHANNEL attributes).
+ *	%NL80211_NAN_SCHED_NOT_AVAIL_SLOT indicates unscheduled.
+ * @__NL80211_NAN_PEER_MAP_ATTR_LAST: Internal
+ * @NL80211_NAN_PEER_MAP_ATTR_MAX: Highest peer map attribute
+ */
+enum nl80211_nan_peer_map_attrs {
+	__NL80211_NAN_PEER_MAP_ATTR_INVALID,
+
+	NL80211_NAN_PEER_MAP_ATTR_MAP_ID,
+	NL80211_NAN_PEER_MAP_ATTR_TIME_SLOTS,
+
+	/* keep last */
+	__NL80211_NAN_PEER_MAP_ATTR_LAST,
+	NL80211_NAN_PEER_MAP_ATTR_MAX = __NL80211_NAN_PEER_MAP_ATTR_LAST - 1,
+};
+
 #define NL80211_NAN_SCHED_NOT_AVAIL_SLOT 0xff
 
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 176e33407c94..8f73d26b02a7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -332,6 +332,61 @@ static int validate_nan_cluster_id(const struct nlattr *attr,
 	return 0;
 }
 
+static int validate_nan_init_ulw(const struct nlattr *attr,
+				 struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+	unsigned int pos = 0;
+
+	while (pos < len) {
+		u16 attr_len;
+
+		/* Need at least: Attr ID (1) + Length (2) */
+		if (pos + 3 > len) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "ULW: Incomplete header (need 3 bytes, have %u)",
+					   len - pos);
+			return -EINVAL;
+		}
+
+		if (data[pos] != 0x17) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "ULW: Invalid Attribute ID 0x%02x (expected 0x17)",
+					   data[pos]);
+			return -EINVAL;
+		}
+		pos++;
+
+		/* Length is in little-endian format */
+		attr_len = get_unaligned_le16(&data[pos]);
+		pos += 2;
+
+		/*
+		 * Check if length is one of the valid values: 16 (no
+		 * channel/band entry included), 19 (band entry included), or 26
+		 * (channel entry included)
+		 */
+		if (attr_len != 16 && attr_len != 19 && attr_len != 26) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "ULW: Invalid length %u (must be 16, 19, or 26)",
+					   attr_len);
+			return -EINVAL;
+		}
+
+		if (pos + attr_len > len) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "ULW: Length field (%u) exceeds remaining data (%u)",
+					   attr_len, len - pos);
+			return -EINVAL;
+		}
+
+		pos += attr_len;
+	}
+
+	return 0;
+}
+
 /* policy for the attributes */
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
 
@@ -531,6 +586,13 @@ nl80211_nan_band_conf_policy[NL80211_NAN_BAND_CONF_ATTR_MAX + 1] = {
 	[NL80211_NAN_BAND_CONF_DISABLE_SCAN] = { .type = NLA_FLAG },
 };
 
+static const struct nla_policy
+nl80211_nan_peer_map_policy[NL80211_NAN_PEER_MAP_ATTR_MAX + 1] = {
+	[NL80211_NAN_PEER_MAP_ATTR_MAP_ID] = NLA_POLICY_MAX(NLA_U8, 15),
+	[NL80211_NAN_PEER_MAP_ATTR_TIME_SLOTS] =
+		NLA_POLICY_EXACT_LEN(CFG80211_NAN_SCHED_NUM_TIME_SLOTS),
+};
+
 static const struct nla_policy
 nl80211_nan_conf_policy[NL80211_NAN_CONF_ATTR_MAX + 1] = {
 	[NL80211_NAN_CONF_CLUSTER_ID] =
@@ -938,6 +1000,13 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NAN_TIME_SLOTS] =
 		NLA_POLICY_EXACT_LEN(CFG80211_NAN_SCHED_NUM_TIME_SLOTS),
 	[NL80211_ATTR_NAN_NMI_MAC] = NLA_POLICY_ETH_ADDR,
+	[NL80211_ATTR_NAN_INIT_ULW] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_nan_init_ulw),
+	[NL80211_ATTR_NAN_COMMITTED_DW] = { .type = NLA_U16 },
+	[NL80211_ATTR_NAN_SEQ_ID] = { .type = NLA_U8 },
+	[NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME] = { .type = NLA_U16 },
+	[NL80211_ATTR_NAN_PEER_MAPS] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_nan_peer_map_policy),
 };
 
 /* policy for the key attributes */
@@ -16418,8 +16487,8 @@ EXPORT_SYMBOL(cfg80211_nan_func_terminated);
 static int nl80211_parse_nan_channel(struct cfg80211_registered_device *rdev,
 				     struct nlattr *channel,
 				     struct genl_info *info,
-				     struct cfg80211_nan_local_sched *sched,
-				     u8 index)
+				     struct cfg80211_nan_channel *nan_channels,
+				     u8 index, bool local)
 {
 	struct nlattr **channel_parsed __free(kfree) = NULL;
 	struct cfg80211_chan_def chandef;
@@ -16454,47 +16523,311 @@ static int nl80211_parse_nan_channel(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
-	for (int i = 0; i < index; i++) {
-		if (cfg80211_chandef_compatible(&sched->nan_channels[i].chandef,
-						&chandef)) {
-			NL_SET_ERR_MSG_ATTR(info->extack, channel,
-					    "Channels in NAN schedule must be mutually incompatible");
-			return -EINVAL;
+	if (local) {
+		for (int i = 0; i < index; i++) {
+			if (cfg80211_chandef_compatible(&nan_channels[i].chandef,
+							&chandef)) {
+				NL_SET_ERR_MSG_ATTR(info->extack, channel,
+						    "Channels in NAN schedule must be mutually incompatible");
+				return -EINVAL;
+			}
 		}
 	}
 
-	if (!channel_parsed[NL80211_ATTR_NAN_CHANNEL_ENTRY])
+	if (!channel_parsed[NL80211_ATTR_NAN_CHANNEL_ENTRY]) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Missing NAN channel entry attribute");
 		return -EINVAL;
+	}
 
-	sched->nan_channels[index].channel_entry =
+	nan_channels[index].channel_entry =
 		nla_data(channel_parsed[NL80211_ATTR_NAN_CHANNEL_ENTRY]);
 
-	if (!channel_parsed[NL80211_ATTR_NAN_RX_NSS])
+	if (!channel_parsed[NL80211_ATTR_NAN_RX_NSS]) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Missing NAN RX NSS attribute");
 		return -EINVAL;
+	}
 
-	sched->nan_channels[index].rx_nss =
+	nan_channels[index].rx_nss =
 		nla_get_u8(channel_parsed[NL80211_ATTR_NAN_RX_NSS]);
 
 	n_rx_nss = u8_get_bits(rdev->wiphy.nan_capa.n_antennas, 0x03);
-	if (sched->nan_channels[index].rx_nss > n_rx_nss ||
-	    !sched->nan_channels[index].rx_nss) {
+	if ((local && nan_channels[index].rx_nss > n_rx_nss) ||
+	    !nan_channels[index].rx_nss) {
 		NL_SET_ERR_MSG_ATTR(info->extack, channel,
 				    "Invalid RX NSS in NAN channel definition");
 		return -EINVAL;
 	}
 
-	sched->nan_channels[index].chandef = chandef;
+	nan_channels[index].chandef = chandef;
 
 	return 0;
 }
 
+static int
+nl80211_parse_nan_schedule(struct genl_info *info, struct nlattr *slots_attr,
+			   u8 schedule[CFG80211_NAN_SCHED_NUM_TIME_SLOTS],
+			   u8 n_channels)
+{
+	if (WARN_ON(nla_len(slots_attr) != CFG80211_NAN_SCHED_NUM_TIME_SLOTS))
+		return -EINVAL;
+
+	memcpy(schedule, nla_data(slots_attr), nla_len(slots_attr));
+
+	for (int slot = 0; slot < CFG80211_NAN_SCHED_NUM_TIME_SLOTS; slot++) {
+		if (schedule[slot] != NL80211_NAN_SCHED_NOT_AVAIL_SLOT &&
+		    schedule[slot] >= n_channels) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Invalid time slot: slot %d refers to channel index %d, n_channels=%d",
+					   slot, schedule[slot], n_channels);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int
+nl80211_parse_nan_peer_map(struct genl_info *info, struct nlattr *map_attr,
+			   struct cfg80211_nan_peer_map *map, u8 n_channels)
+{
+	struct nlattr *tb[NL80211_NAN_PEER_MAP_ATTR_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, NL80211_NAN_PEER_MAP_ATTR_MAX, map_attr,
+			       nl80211_nan_peer_map_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_NAN_PEER_MAP_ATTR_MAP_ID] ||
+	    !tb[NL80211_NAN_PEER_MAP_ATTR_TIME_SLOTS]) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Missing required peer map attributes");
+		return -EINVAL;
+	}
+
+	map->map_id = nla_get_u8(tb[NL80211_NAN_PEER_MAP_ATTR_MAP_ID]);
+
+	/* Parse schedule */
+	return nl80211_parse_nan_schedule(info,
+					  tb[NL80211_NAN_PEER_MAP_ATTR_TIME_SLOTS],
+					  map->schedule, n_channels);
+}
+
+static int nl80211_nan_validate_map_pair(struct wiphy *wiphy,
+					 struct genl_info *info,
+					 const struct cfg80211_nan_peer_map *map1,
+					 const struct cfg80211_nan_peer_map *map2,
+					 struct cfg80211_nan_channel *nan_channels)
+{
+	/* Check for duplicate map_id */
+	if (map1->map_id == map2->map_id) {
+		NL_SET_ERR_MSG_FMT(info->extack, "Duplicate map_id %u",
+				   map1->map_id);
+		return -EINVAL;
+	}
+
+	/* Check for compatible channels between maps */
+	for (int i = 0; i < ARRAY_SIZE(map1->schedule); i++) {
+		if (map1->schedule[i] == NL80211_NAN_SCHED_NOT_AVAIL_SLOT)
+			continue;
+
+		for (int j = 0; j < ARRAY_SIZE(map2->schedule); j++) {
+			u8 ch1 = map1->schedule[i];
+			u8 ch2 = map2->schedule[j];
+
+			if (ch2 == NL80211_NAN_SCHED_NOT_AVAIL_SLOT)
+				continue;
+
+			if (cfg80211_chandef_compatible(&nan_channels[ch1].chandef,
+							&nan_channels[ch2].chandef)) {
+				NL_SET_ERR_MSG_FMT(info->extack,
+						   "Maps %u and %u have compatible channels %d and %d",
+						   map1->map_id, map2->map_id,
+						   ch1, ch2);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/*
+	 * Check for conflicting time slots between maps.
+	 * Only check for single-radio devices (n_radio <= 1) which cannot
+	 * operate on multiple channels simultaneously.
+	 */
+	if (wiphy->n_radio > 1)
+		return 0;
+
+	for (int i = 0; i < ARRAY_SIZE(map1->schedule); i++) {
+		if (map1->schedule[i] != NL80211_NAN_SCHED_NOT_AVAIL_SLOT &&
+		    map2->schedule[i] != NL80211_NAN_SCHED_NOT_AVAIL_SLOT) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Maps %u and %u both schedule slot %d",
+					   map1->map_id, map2->map_id, i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int nl80211_nan_set_peer_sched(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_nan_channel *nan_channels __free(kfree) = NULL;
+	struct cfg80211_nan_peer_sched sched = {};
+	struct wireless_dev *wdev = info->user_ptr[1];
+	struct nlattr *map_attr, *channel;
+	int ret, n_maps = 0, n_channels = 0, i = 0, rem;
+
+	if (wdev->iftype != NL80211_IFTYPE_NAN)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_MAC] ||
+	    !info->attrs[NL80211_ATTR_NAN_COMMITTED_DW]) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Required NAN peer schedule attributes are missing");
+		return -EINVAL;
+	}
+
+	/* First count how many channel attributes we got */
+	nlmsg_for_each_attr_type(channel, NL80211_ATTR_NAN_CHANNEL,
+				 info->nlhdr, GENL_HDRLEN, rem)
+		n_channels++;
+
+	if (!((info->attrs[NL80211_ATTR_NAN_SEQ_ID] &&
+	       info->attrs[NL80211_ATTR_NAN_PEER_MAPS] && n_channels) ||
+	      ((!info->attrs[NL80211_ATTR_NAN_SEQ_ID] &&
+		!info->attrs[NL80211_ATTR_NAN_PEER_MAPS] && !n_channels)))) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Either provide all of: seq id, channels and maps, or none");
+		return -EINVAL;
+	}
+
+	/*
+	 * Limit the number of peer channels to:
+	 * local_channels * 4 (possible BWs) * 2 (possible NSS values)
+	 */
+	if (n_channels && n_channels > wdev->u.nan.n_channels * 4 * 2) {
+		NL_SET_ERR_MSG_FMT(info->extack,
+				   "Too many peer channels: %d (max %d)",
+				   n_channels,
+				   wdev->u.nan.n_channels * 4 * 2);
+		return -EINVAL;
+	}
+
+	if (n_channels) {
+		nan_channels = kcalloc(n_channels, sizeof(*nan_channels),
+				       GFP_KERNEL);
+		if (!nan_channels)
+			return -ENOMEM;
+	}
+
+	/* Parse peer channels */
+	nlmsg_for_each_attr_type(channel, NL80211_ATTR_NAN_CHANNEL,
+				 info->nlhdr, GENL_HDRLEN, rem) {
+		bool compatible = false;
+
+		ret = nl80211_parse_nan_channel(rdev, channel, info,
+						nan_channels, i, false);
+		if (ret)
+			return ret;
+
+		/* Verify channel is compatible with at least one local channel */
+		for (int j = 0; j < wdev->u.nan.n_channels; j++) {
+			if (cfg80211_chandef_compatible(&nan_channels[i].chandef,
+							&wdev->u.nan.chandefs[j])) {
+				compatible = true;
+				break;
+			}
+		}
+		if (!compatible) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Channel %d not compatible with any local channel",
+					   i);
+			return -EINVAL;
+		}
+		i++;
+	}
+
+	sched.n_channels = n_channels;
+	sched.nan_channels = nan_channels;
+	sched.peer_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+	sched.seq_id = nla_get_u8_default(info->attrs[NL80211_ATTR_NAN_SEQ_ID], 0);
+	sched.committed_dw = nla_get_u16(info->attrs[NL80211_ATTR_NAN_COMMITTED_DW]);
+	sched.max_chan_switch =
+		nla_get_u16_default(info->attrs[NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME], 0);
+
+	if (info->attrs[NL80211_ATTR_NAN_INIT_ULW]) {
+		sched.ulw_size = nla_len(info->attrs[NL80211_ATTR_NAN_INIT_ULW]);
+		sched.init_ulw = nla_data(info->attrs[NL80211_ATTR_NAN_INIT_ULW]);
+	}
+
+	/* Initialize all maps as invalid */
+	for (int j = 0; j < ARRAY_SIZE(sched.maps); j++)
+		sched.maps[j].map_id = CFG80211_NAN_INVALID_MAP_ID;
+
+	if (info->attrs[NL80211_ATTR_NAN_PEER_MAPS]) {
+		/* Parse each map */
+		nla_for_each_nested(map_attr, info->attrs[NL80211_ATTR_NAN_PEER_MAPS],
+				    rem) {
+			if (n_maps >= ARRAY_SIZE(sched.maps)) {
+				NL_SET_ERR_MSG(info->extack, "Too many peer maps");
+				return -EINVAL;
+			}
+
+			ret = nl80211_parse_nan_peer_map(info, map_attr,
+							 &sched.maps[n_maps],
+							 n_channels);
+			if (ret)
+				return ret;
+
+			/* Validate against previous maps */
+			for (int j = 0; j < n_maps; j++) {
+				ret = nl80211_nan_validate_map_pair(&rdev->wiphy, info,
+								    &sched.maps[j],
+								    &sched.maps[n_maps],
+								    nan_channels);
+				if (ret)
+					return ret;
+			}
+
+			n_maps++;
+		}
+	}
+
+	/* Verify each channel is scheduled at least once */
+	for (int ch = 0; ch < n_channels; ch++) {
+		bool scheduled = false;
+
+		for (int m = 0; m < n_maps && !scheduled; m++) {
+			for (int s = 0; s < ARRAY_SIZE(sched.maps[m].schedule); s++) {
+				if (sched.maps[m].schedule[s] == ch) {
+					scheduled = true;
+					break;
+				}
+			}
+		}
+		if (!scheduled) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Channel %d is not scheduled in any map",
+					   ch);
+			return -EINVAL;
+		}
+	}
+
+	return rdev_nan_set_peer_sched(rdev, wdev, &sched);
+}
+
 static int nl80211_nan_set_local_sched(struct sk_buff *skb,
 				       struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct cfg80211_nan_local_sched *sched __free(kfree) = NULL;
 	struct wireless_dev *wdev = info->user_ptr[1];
-	int rem, i = 0, n_channels = 0;
+	int rem, i = 0, n_channels = 0, ret;
 	struct nlattr *channel;
 
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
@@ -16520,26 +16853,20 @@ static int nl80211_nan_set_local_sched(struct sk_buff *skb,
 
 	nlmsg_for_each_attr_type(channel, NL80211_ATTR_NAN_CHANNEL,
 				 info->nlhdr, GENL_HDRLEN, rem) {
-		int ret = nl80211_parse_nan_channel(rdev, channel, info, sched,
-						    i);
+		ret = nl80211_parse_nan_channel(rdev, channel, info,
+						sched->nan_channels, i, true);
 
 		if (ret)
 			return ret;
 		i++;
 	}
 
-	memcpy(sched->schedule,
-	       nla_data(info->attrs[NL80211_ATTR_NAN_TIME_SLOTS]),
-	       nla_len(info->attrs[NL80211_ATTR_NAN_TIME_SLOTS]));
-
-	for (int slot = 0; slot < ARRAY_SIZE(sched->schedule); slot++) {
-		if (sched->schedule[slot] != NL80211_NAN_SCHED_NOT_AVAIL_SLOT &&
-		    sched->schedule[slot] >= sched->n_channels) {
-			NL_SET_ERR_MSG(info->extack,
-				       "Invalid time slot in NAN schedule");
-			return -EINVAL;
-		}
-	}
+	/* Parse and validate schedule */
+	ret = nl80211_parse_nan_schedule(info,
+					 info->attrs[NL80211_ATTR_NAN_TIME_SLOTS],
+					 sched->schedule, sched->n_channels);
+	if (ret)
+		return ret;
 
 	return cfg80211_nan_set_local_schedule(rdev, wdev, sched);
 }
@@ -19349,6 +19676,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_NAN_SET_PEER_SCHED,
+		.doit = nl80211_nan_set_peer_sched,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 31070551f3c1..ef5a2897c240 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1076,6 +1076,22 @@ rdev_nan_set_local_sched(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_nan_set_peer_sched(struct cfg80211_registered_device *rdev,
+			struct wireless_dev *wdev,
+			struct cfg80211_nan_peer_sched *sched)
+{
+	int ret;
+
+	trace_rdev_nan_set_peer_sched(&rdev->wiphy, wdev, sched);
+	if (rdev->ops->nan_set_peer_sched)
+		ret = rdev->ops->nan_set_peer_sched(&rdev->wiphy, wdev, sched);
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
index b030346c276a..458d6e895444 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2431,6 +2431,34 @@ TRACE_EVENT(rdev_nan_set_local_sched,
 				CFG80211_NAN_SCHED_NUM_TIME_SLOTS, 1))
 );
 
+TRACE_EVENT(rdev_nan_set_peer_sched,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 struct cfg80211_nan_peer_sched *sched),
+	TP_ARGS(wiphy, wdev, sched),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__array(u8, peer_addr, ETH_ALEN)
+		__field(u8, seq_id)
+		__field(u16, committed_dw)
+		__field(u16, max_chan_switch)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		memcpy(__entry->peer_addr, sched->peer_addr, ETH_ALEN);
+		__entry->seq_id = sched->seq_id;
+		__entry->committed_dw = sched->committed_dw;
+		__entry->max_chan_switch = sched->max_chan_switch;
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT
+		  ", peer: %pM, seq_id: %u, committed_dw: 0x%x, max_chan_switch: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->peer_addr,
+		  __entry->seq_id, __entry->committed_dw,
+		  __entry->max_chan_switch
+	)
+);
+
 TRACE_EVENT(rdev_set_mac_acl,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_acl_data *params),
-- 
2.34.1


