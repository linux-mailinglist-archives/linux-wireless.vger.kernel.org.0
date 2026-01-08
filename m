Return-Path: <linux-wireless+bounces-30526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A1D038E0
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 15:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A0A330128EB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F636E484;
	Thu,  8 Jan 2026 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E37gQG5N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71840366DC9
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861375; cv=none; b=nvnctm3RRerZycC2mlh7KW2FNJcBsOh55JW+CZgz4DIeGH3G4OcD0HcwQjO/ndT9/eFH8+dmdK2Bjh+wC25gD9yGy4f1KhtfLsGIs0HnBpGg98nLskehlc0m2XoW39Qubm6qUDF5Hkm7J8ID24MuQL7fvVd5tIS7HEJGiXVihM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861375; c=relaxed/simple;
	bh=kmefvFXAYusu+xsRtK+95V0gQoeMjLcYCdTXyqNN1js=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mpi65rfeU3+4GEUxKw9zpLqgsND+405bGhis2VzLsoZ3W9UH+nH44GBOGVofFe8zyGrZiAQOZ26GaijtZf2k0s9K44uLQn8F/1NKIqEm2n/6zIW5xL5SaZMtSVXpfywpGwOWH0jD0gr01xdYQ1NSolys8pBpHFmgw/5H45T3gZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E37gQG5N; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861372; x=1799397372;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kmefvFXAYusu+xsRtK+95V0gQoeMjLcYCdTXyqNN1js=;
  b=E37gQG5NAG/SdKL+HqcMbb3lDc3kW+u4Hn3Ymx/XRTmiZBsstts1rDZy
   QRVy/bCYQ7TvlSMa92EVSBJCSkTdpns4DLe0iDfu8pZfRmjV5HGk2kp2C
   L1MfgXVVzV33pgneOXOKfIVYmfKYyjAHMl3B2GzCkU+zxcKX56YrP4HZw
   SGRvyzMh7q/WP4wwa+osAYPQcC31XgRYfKeiYWUdBtZ/6udIix9/EdPVZ
   YXJBOPhmVPMDcO0q/GJIALKny03e+UiFHX4dPafr8ifenhhaarA1qmhkd
   tkpzUhV7oDFhzzgiRCbHd5prksQx6vyz3vMpUXPBHva8SZKyhRf73G4LA
   w==;
X-CSE-ConnectionGUID: 057sntnbS0CSWXGkWsZCSg==
X-CSE-MsgGUID: oSvzf3xJTE6c/qHR0JXtuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084790"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084790"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:59 -0800
X-CSE-ConnectionGUID: WsjdFSuUR9ykm8NAjWrzmw==
X-CSE-MsgGUID: Wd5Vo46LS/25oxLQDNUUkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847474"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v2 06/14] wifi: cfg80211: Add an API to configure local NAN schedule
Date: Thu,  8 Jan 2026 10:35:32 +0200
Message-Id: <20260108102921.231b2778d79e.Ic977ab08b4ed5cf9b849e55d3a59b01ad3fbd08e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add an nl80211 API to allow user space to configure the local NAN
schedule.
The API consists of a list of channel definitions,
and a schedule map, in which each element covers a time slot and
indicates on what channel the device should be in that time slot.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  45 ++++++++++-
 include/uapi/linux/nl80211.h |  42 ++++++++++-
 net/wireless/nl80211.c       | 140 +++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  16 ++++
 net/wireless/trace.h         |  21 ++++++
 5 files changed, 262 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7f269574c9a0..640a63395e84 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3997,6 +3997,41 @@ struct cfg80211_nan_conf {
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
+ * @nan_channels: array of NAN channel definitions that can be scheduled.
+ */
+struct cfg80211_nan_local_sched {
+	u8 schedule[CFG80211_NAN_SCHED_NUM_TIME_SLOTS];
+	u8 n_channels;
+	struct cfg80211_nan_channel nan_channels[] __counted_by(n_channels);
+};
+
 /**
  * enum cfg80211_nan_conf_changes - indicates changed fields in NAN
  * configuration
@@ -4770,6 +4805,12 @@ struct mgmt_frame_regs {
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
@@ -5147,7 +5188,9 @@ struct cfg80211_ops {
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
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..005521d22d29 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1360,7 +1360,11 @@
  * @NL80211_CMD_NAN_CLUSTER_JOINED: This command is used to notify
  *	user space that the NAN new cluster has been joined. The cluster ID is
  *	indicated by %NL80211_ATTR_MAC.
- *
+ * @NL80211_CMD_NAN_SET_LOCAL_SCHED: Set the local NAN schedule. NAN must be
+ *	operational (%NL80211_CMD_START_NAN was executed). Must contain both of
+ *	%NL80211_ATTR_NAN_TIME_SLOTS, but %NL80211_ATTR_NAN_CHANNEL is optional.
+ *	(for example in case of a channel removal, that channel won't be
+ *	provided).
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1624,6 +1628,8 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
 	NL80211_CMD_NAN_CLUSTER_JOINED,
 
+	NL80211_CMD_NAN_SET_LOCAL_SCHED,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2973,6 +2979,33 @@ enum nl80211_commands {
  *	primary channel is 2 MHz wide, and the control channel designates
  *	the 1 MHz primary subchannel within that 2 MHz primary.
  *
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
+ * @NL80211_ATTR_NAN_RX_NSS: (u8) RX NSS used for a peer NAN channel. This is
+ *	used with %NL80211_ATTR_NAN_CHANNEL when configuring
+ *	peer NAN channels with %NL80211_CMD_NAN_SET_PEER_SCHED.
+ * @NL80211_ATTR_NAN_TIME_SLOTS: an array of u8 values and 32 cells. each value
+ *	maps a time slot to the chandef on which the radio should operate on in
+ *	that time. %NL80211_NAN_SCHED_NOT_AVAIL_SLOT indicates unscheduled.
+ *	The chandef is represented using its index, where the index is the
+ *	sequential number of the %NL80211_ATTR_NAN_CHANNEL attribute within all
+ *	the attributes of this type.
+ *	Each slots spans over 16TUs, hence the entire schedule spans over
+ *	512TUs. Other slot durations and periods are currently not supported.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3541,6 +3574,11 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
+	NL80211_ATTR_NAN_CHANNEL,
+	NL80211_ATTR_NAN_CHANNEL_ENTRY,
+	NL80211_ATTR_NAN_TIME_SLOTS,
+	NL80211_ATTR_NAN_RX_NSS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8432,4 +8470,6 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
 };
 
+#define NL80211_NAN_SCHED_NOT_AVAIL_SLOT 0xff
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1467322d43a4..0f9e0e931b5f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -932,6 +932,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
+	[NL80211_ATTR_NAN_CHANNEL] = NLA_POLICY_NESTED(nl80211_policy),
+	[NL80211_ATTR_NAN_CHANNEL_ENTRY] = NLA_POLICY_EXACT_LEN(6),
+	[NL80211_ATTR_NAN_RX_NSS] = { .type = NLA_U8 },
+	[NL80211_ATTR_NAN_TIME_SLOTS] =
+		NLA_POLICY_EXACT_LEN(CFG80211_NAN_SCHED_NUM_TIME_SLOTS),
 };
 
 /* policy for the key attributes */
@@ -16262,6 +16267,135 @@ void cfg80211_nan_func_terminated(struct wireless_dev *wdev,
 }
 EXPORT_SYMBOL(cfg80211_nan_func_terminated);
 
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
+	return rdev_nan_set_local_sched(rdev, wdev, sched);
+}
+
 static int nl80211_get_protocol_features(struct sk_buff *skb,
 					 struct genl_info *info)
 {
@@ -19056,6 +19190,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
index a5b94ad7a79a..b030346c276a 100644
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
-- 
2.34.1


