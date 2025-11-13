Return-Path: <linux-wireless+bounces-28903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91251C56A4F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95CA3BD957
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F73321A4;
	Thu, 13 Nov 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCd2GQ3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E533123C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026392; cv=none; b=W7Zec0wQMKNrYpA3XL/e8D+MRexSGbDyIBrM/PCNwX/wSUbCJQptOjQxJrwD2/BEhb5ESv9/XBkKO9HSMkAFrLm2D4N0W8DZ10nLbdSmDffd8zFGNgj2vkA1+ySeVW4j4mjUvB5uy0vVlzw+sI/YKeVuvapbzUDHLcNSH1hkvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026392; c=relaxed/simple;
	bh=IlcLt3d/OWHaS4ilwnn2je8Rdn9B82v3UpyBL7sWGZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNXGu6qKt6BCkG7YBlCUGESvusL5ZNI/NMhZwlixaIbvZshK+cxjW7njyFJCZ4I/2r0I1NIJniByIO1wbwelSLRg7YQ5qSc3B5HDp98VLM5LnPZ/8bg3+wijFaGZuC3UFYzLcN4g+Jqxn9SkiYJYLhCV+GfZ0XzqDSAIclG+/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCd2GQ3D; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763026391; x=1794562391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlcLt3d/OWHaS4ilwnn2je8Rdn9B82v3UpyBL7sWGZo=;
  b=gCd2GQ3DFf3HghLJve33/k4yfgruSuwypnmyZnG6CVzuiN8xZxG5uOpU
   /O8sxZYDIW/6UCZrwmewfmG8Yo5rKWJ7FsMYvkMpg/zTwzaR6d7hl2lYN
   M0Wc1yMqeKTKyl+ehNJp8eAiWun3ZYpka6JaJR33Dfi7d3c8RD9ShMlsy
   Gj0RmKOAGPqM9u0KO7KiFNezJ0TGmcozN3tkidYpwIcabmvMaZCfyhBKc
   i5xdqe/Opphk9uqc2KHWSRbZPJgvwvQA32X95fUc5jA3fHVsy2PFICfTK
   ExEDEaM32ZMuY08jphUWtIPTf6mkCAww3BdDH/OA0dUBPaHOw6+dshrBn
   g==;
X-CSE-ConnectionGUID: fGHFZ+1gSMulfJX784HOxQ==
X-CSE-MsgGUID: WgHDrv5eT0aZ8mFWPH1Zog==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65028279"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65028279"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:11 -0800
X-CSE-ConnectionGUID: TVu4eS2DS1q2+Fiij1p94g==
X-CSE-MsgGUID: crWbD7g1TbS1Xranu5TrqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="188737149"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 3/3] wifi: cfg80211: Add an API to configure local NAN schedule
Date: Thu, 13 Nov 2025 11:32:59 +0200
Message-Id: <20251113112845.774547c6efec.Ic977ab08b4ed5cf9b849e55d3a59b01ad3fbd08e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113093259.3576302-1-miriam.rachel.korenblit@intel.com>
References: <20251113093259.3576302-1-miriam.rachel.korenblit@intel.com>
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
 include/net/cfg80211.h       |  41 +++++++++++-
 include/uapi/linux/nl80211.h |  35 +++++++++-
 net/wireless/nl80211.c       | 124 +++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  16 +++++
 net/wireless/trace.h         |  21 ++++++
 5 files changed, 235 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3d3ed1932262..dcd50e204e72 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3996,6 +3996,39 @@ struct cfg80211_nan_conf {
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
+ */
+struct cfg80211_nan_channel {
+	struct cfg80211_chan_def chandef;
+	const u8 *channel_entry;
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
@@ -4769,6 +4802,10 @@ struct mgmt_frame_regs {
  * @nan_change_conf: changes NAN configuration. The changed parameters must
  *	be specified in @changes (using &enum cfg80211_nan_conf_changes);
  *	All other parameters must be ignored.
+ * @nan_set_local_sched: configure the local schedule for NAN. The schedule
+ *	consists of an array of %cfg80211_nan_channel and the schedule itself,
+ *	in which each entry maps each time slot to the a channel on which the
+ *	radio should operate on.
  *
  * @set_multicast_to_unicast: configure multicast to unicast conversion for BSS
  *
@@ -5146,7 +5183,9 @@ struct cfg80211_ops {
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
index 8134f10e4e6c..3e130ea3b241 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1360,7 +1360,11 @@
  * @NL80211_CMD_NAN_CLUSTER_JOINED: This command is used to notify
  *	user space that the NAN new cluster has been joined. The cluster ID is
  *	indicated by %NL80211_ATTR_MAC.
- *
+ * @NL80211_CMD_SET_LOCAL_NAN_SCHED: Set the local NAN schedule. NAN must be
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
 
+	NL80211_CMD_SET_LOCAL_NAN_SCHED,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2973,6 +2979,27 @@ enum nl80211_commands {
  *	primary channel is 2 MHz wide, and the control channel designates
  *	the 1 MHz primary subchannel within that 2 MHz primary.
  *
+ * @NL80211_ATTR_NAN_CHANNEL: This is a nested attribute. There can be multiple
+ *	attributes of this type, each one represents a channel definition and
+ *	consists of top-level attributes like %NL80211_ATTR_WIPHY_FREQ. Must
+ *	contain %NL80211_ATTR_NAN_CHANNEL_ENTRY.
+ *	This attribute is used with %NL80211_CMD_SET_LOCAL_NAN_SCHED to specify
+ *	the channel definitions on which the radio needs to operate during
+ *	specific time slots. All of the channel definitions should be mutually
+ *	incompatible. The number of channels should fit the current
+ *	configuration of channels and the possible interface combinations.
+ * @NL80211_ATTR_NAN_CHANNEL_ENTRY: a byte array of 6 bytes. contains the
+ *	Channel Entry as defined in Wi-Fi Aware (TM) 4.0 specification Table
+ *	100 (Channel Entry format for the NAN Availability attribute).
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
@@ -3541,6 +3568,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
+	NL80211_ATTR_NAN_CHANNEL,
+	NL80211_ATTR_NAN_CHANNEL_ENTRY,
+	NL80211_ATTR_NAN_TIME_SLOTS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8432,4 +8463,6 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
 };
 
+#define NL80211_NAN_SCHED_NOT_AVAIL_SLOT 0xff
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c95e64813d35..6efc190cb096 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -932,6 +932,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
+	[NL80211_ATTR_NAN_CHANNEL] = NLA_POLICY_NESTED(nl80211_policy),
+	[NL80211_ATTR_NAN_CHANNEL_ENTRY] = NLA_POLICY_EXACT_LEN(6),
+	[NL80211_ATTR_NAN_TIME_SLOTS] =
+		NLA_POLICY_EXACT_LEN(CFG80211_NAN_SCHED_NUM_TIME_SLOTS),
 };
 
 /* policy for the key attributes */
@@ -16243,6 +16247,120 @@ void cfg80211_nan_func_terminated(struct wireless_dev *wdev,
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
+	ret = _nl80211_parse_chandef(rdev, info->extack, channel_parsed,
+				     NL80211_IFTYPE_NAN, &chandef);
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
@@ -19037,6 +19155,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_SET_LOCAL_NAN_SCHED,
+		.doit = nl80211_nan_set_local_sched,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ac6884bacf3f..f4c06282b2e1 100644
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
index 2b71f1d867a0..6502ae53e944 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2393,6 +2393,27 @@ TRACE_EVENT(rdev_del_nan_func,
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


