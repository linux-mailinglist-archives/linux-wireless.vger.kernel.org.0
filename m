Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA25425269E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 07:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHZF5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 01:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgHZF5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 01:57:05 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22494C061786
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 22:57:03 -0700 (PDT)
Received: from [149.224.157.14] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kAoQc-0004ao-N0; Wed, 26 Aug 2020 07:56:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 3/5] nl80211: add support for BSS coloring
Date:   Wed, 26 Aug 2020 07:56:48 +0200
Message-Id: <20200826055650.1101224-3-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826055650.1101224-1-john@phrozen.org>
References: <20200826055650.1101224-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for BSS color collisions to the wireless subsystem.
Add the required functionality to nl80211 that will notify about color
collisions, triggering the color change and notifying when it is completed.

Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in V4
* use NL80211_EXT_FEATURE_BSS_COLOR instead of WIPHY_FLAG_SUPPORTS_BSS_COLOR
* turn cfg80211_color_change_*_notify into static functions
* unify trace handlers
* properly check size and max value of NL80211_ATTR_CNTDWN_OFFS_BEACON
* more cca->color_change renames

 include/net/cfg80211.h       |  95 ++++++++++++++++++++++++
 include/uapi/linux/nl80211.h |  46 ++++++++++++
 net/wireless/nl80211.c       | 135 +++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  12 ++++
 net/wireless/trace.h         |  47 ++++++++++++
 5 files changed, 335 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d9e6b9fbd95b..69af20f0e675 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1172,6 +1172,27 @@ struct cfg80211_csa_settings {
 	u8 count;
 };
 
+/**
+ * struct cfg80211_color_change_settings - color change settings
+ *
+ * Used for color change
+ *
+ * @beacon_color_change: beacon data while performing the change
+ * @counter_offsets_beacon: offsets of the counters within the beacon (tail)
+ * @counter_offsets_presp: offsets of the counters within the probe response
+ * @beacon_after: beacon data to be used after the change
+ * @count: number of beacons until the change
+ * @color: the color that we will have after the change
+ */
+struct cfg80211_color_change_settings {
+	struct cfg80211_beacon_data beacon_color_change;
+	u16 counter_offset_beacon;
+	u16 counter_offset_presp;
+	struct cfg80211_beacon_data beacon_after;
+	u8 count;
+	u8 color;
+};
+
 #define CFG80211_MAX_NUM_DIFFERENT_CHANNELS 10
 
 /**
@@ -3822,6 +3843,7 @@ struct mgmt_frame_regs {
  *	This callback may sleep.
  * @reset_tid_config: Reset TID specific configuration for the peer, for the
  *	given TIDs. This callback may sleep.
+ * @color_change: initiate a color change (with color change).
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4150,6 +4172,9 @@ struct cfg80211_ops {
 				  struct cfg80211_tid_config *tid_conf);
 	int	(*reset_tid_config)(struct wiphy *wiphy, struct net_device *dev,
 				    const u8 *peer, u8 tids);
+	int	(*color_change)(struct wiphy *wiphy,
+				struct net_device *dev,
+				struct cfg80211_color_change_settings *params);
 };
 
 /*
@@ -7915,4 +7940,74 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
  */
 void cfg80211_bss_flush(struct wiphy *wiphy);
 
+
+/*
+ * cfg80211_bss_color_notify - notify about bss color event
+ * @dev: network device
+ * @gfp: allocation flags
+ * notif: the actual event we want to notify
+ * @count: the number of TBTTs until the color change happens
+ * @color_bitmap: representations of the colors that the local BSS is aware of
+ */
+void cfg80211_bss_color_notify(struct net_device *dev,
+			       gfp_t gfp, enum nl80211_commands notify,
+			       u8 count, u64 color_bitmap);
+
+/*
+ * cfg80211_obss_color_collision_notify - notify about bss color collisions
+ * @dev: network device
+ * @color_bitmap: representations of the colors that the local BSS is aware of
+ */
+static inline void cfg80211_obss_color_collision_notify(struct net_device *dev,
+							u64 color_bitmap)
+{
+	cfg80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_OBSS_COLOR_COLLISION,
+				 0, color_bitmap);
+}
+
+/*
+ * cfg80211_color_change_started_notify - notify color change start
+ * @dev: the device on which the color is switched
+ * @count: the number of TBTTs until the color change happens
+ *
+ * Inform the userspace about the color change that has just
+ * started.
+ */
+static inline void cfg80211_color_change_started_notify(struct net_device *dev,
+							u8 count)
+{
+	cfg80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_STARTED,
+				 count, 0);
+}
+
+/*
+ * cfg80211_color_change_aborted_notify - notify color change abort
+ * @dev: the device on which the color is switched
+ *
+ * Inform the userspace about the color change that has just
+ * started.
+ */
+static inline void cfg80211_color_change_aborted_notify(struct net_device *dev)
+{
+	cfg80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_ABORTED,
+				 0, 0);
+}
+
+/*
+ * cfg80211_color_change_notify - notify color change completion
+ * @dev: the device on which the color was switched
+ *
+ * Inform the userspace about the color change that has just
+ * completed.
+ */
+static inline void cfg80211_color_change_notify(struct net_device *dev)
+{
+	cfg80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_COMPLETED,
+				 0, 0);
+}
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bccd16f743b9..8ed8bb3169d7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1179,6 +1179,21 @@
  *	includes the contents of the frame. %NL80211_ATTR_ACK flag is included
  *	if the recipient acknowledged the frame.
  *
+ * @NL80211_CMD_OBSS_COLOR_COLLISION: This notification is sent out whenever a
+ *	mac detects a bss color collision.
+ *
+ * @NL80211_CMD_COLOR_CHANGE: This command is used to indicate that we want to
+ *	change the BSS color.
+ *
+ * @NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_STARTED: Notify userland, that we color change has
+ *	started
+ *
+ * @NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_ABORTED: Notify userland, that we color change has
+ *	been aborted
+ *
+ * @NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_COMPLETED: Notify userland that ithe color change
+ *	has completed
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1409,6 +1424,13 @@ enum nl80211_commands {
 
 	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
 
+	NL80211_CMD_OBSS_COLOR_COLLISION,
+
+	NL80211_CMD_COLOR_CHANGE,
+	NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_STARTED,
+	NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_ABORTED,
+	NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_COMPLETED,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2515,6 +2537,20 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
  *
+ * @NL80211_ATTR_OBSS_COLOR_BITMAP: bitmap of the u64 BSS colors for the
+ *	%NL80211_CMD_OBSS_COLOR_COLLISION event.
+ *
+ * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT: u8 attribute specifying the number of TBTT's
+ *	until the color switch event.
+ * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR: u8 attribute specifying the color that we are
+ *	switching to
+ * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES: Nested set of attributes containing the IE
+ *	information for the time while performing a color switch.
+ * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_C_OFF_BEACON: An array of offsets (u16) to the color
+ *	switch counters in the beacons tail (%NL80211_ATTR_BEACON_TAIL).
+ * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_C_OFF_PRESP: An array of offsets (u16) to the color
+ *	switch counters in the probe response (%NL80211_ATTR_PROBE_RESP).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2997,6 +3033,12 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_OBSS_COLOR_BITMAP,
+
+	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT,
+	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR,
+	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5823,6 +5865,9 @@ enum nl80211_feature_flags {
  *	handshake with PSK in AP mode (PSK is passed as part of the start AP
  *	command).
  *
+ * @NL80211_EXT_FEATURE_BSS_COLOR: The driver supports BSS color collision
+ *	detection and change announcemnts.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5880,6 +5925,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS,
 	NL80211_EXT_FEATURE_OPERATING_CHANNEL_VALIDATION,
 	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
+	NL80211_EXT_FEATURE_BSS_COLOR,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e41fcec7c306..680d232ba74b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -658,6 +658,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		.type = NLA_EXACT_LEN,
 		.len = sizeof(struct ieee80211_he_6ghz_capa),
 	},
+	[NL80211_ATTR_OBSS_COLOR_BITMAP] = { .type = NLA_U64 },
+	[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT] = { .type = NLA_U8 },
+	[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR] = { .type = NLA_U8 },
+	[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES] = NLA_POLICY_NESTED(nl80211_policy),
 };
 
 /* policy for the key attributes */
@@ -14280,6 +14284,82 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 	return ret;
 }
 
+static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_color_change_settings params;
+	static struct nlattr *color_change_attrs[NL80211_ATTR_MAX + 1];
+	int err, len;
+
+	if (!rdev->ops->color_change ||
+	    !(wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_BSS_COLOR)))
+		return -EOPNOTSUPP;
+
+	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP)
+		return -EOPNOTSUPP;
+
+	memset(&params, 0, sizeof(params));
+
+	if (!info->attrs[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT] ||
+	    !info->attrs[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR] ||
+	    !info->attrs[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES])
+		return -EINVAL;
+
+	params.count = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT]);
+	params.color = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR]);
+
+	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_after);
+	if (err)
+		return err;
+
+	err = nla_parse_nested(color_change_attrs, NL80211_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES],
+			       nl80211_policy, NULL);
+	if (err)
+		return err;
+
+	err = nl80211_parse_beacon(rdev, color_change_attrs, &params.beacon_color_change);
+	if (err)
+		return err;
+
+	if (!info->attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON])
+		return -EINVAL;
+
+	len = nla_len(info->attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
+	if (len != sizeof(u16))
+		return -EINVAL;
+
+	memcpy(&params.counter_offset_beacon,
+	       nla_data(info->attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]),
+	       sizeof(u16));
+
+	if (params.counter_offset_beacon >= params.beacon_color_change.tail_len)
+		return -EINVAL;
+
+	if (params.beacon_color_change.tail[params.counter_offset_beacon] != params.count)
+		return -EINVAL;
+
+	if (info->attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
+		params.counter_offset_presp =
+			nla_get_u16(info->attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
+
+		if (params.counter_offset_presp >= params.beacon_color_change.probe_resp_len)
+			return -EINVAL;
+
+		if (params.beacon_color_change.probe_resp[params.counter_offset_presp] !=
+		    params.count)
+			return -EINVAL;
+	}
+
+	wdev_lock(wdev);
+	err = rdev_color_change(rdev, dev, &params);
+	wdev_unlock(wdev);
+
+	return err;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -15241,6 +15321,14 @@ static const struct genl_ops nl80211_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_COLOR_CHANGE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_color_change,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_NEED_RTNL,
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
@@ -16854,6 +16942,53 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
+void cfg80211_bss_color_notify(struct net_device *dev,
+			       gfp_t gfp, enum nl80211_commands cmd,
+			       u8 count, u64 color_bitmap)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	ASSERT_WDEV_LOCK(wdev);
+
+	trace_cfg80211_bss_color_notify(dev, cmd, count, color_bitmap);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, cmd);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex))
+		goto nla_put_failure;
+
+	if (cmd == NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_STARTED &&
+	    nla_put_u32(msg, NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT, count))
+		goto nla_put_failure;
+
+	if (cmd == NL80211_CMD_OBSS_COLOR_COLLISION &&
+	    nla_put_u64_64bit(msg, NL80211_ATTR_OBSS_COLOR_BITMAP,
+			      color_bitmap, NL80211_ATTR_PAD))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, gfp);
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_bss_color_notify);
+
 void
 nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 		     const struct cfg80211_chan_def *chandef,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 950d57494168..752db69783ab 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1356,4 +1356,16 @@ static inline int rdev_reset_tid_config(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_color_change(struct cfg80211_registered_device *rdev,
+				    struct net_device *dev,
+				    struct cfg80211_color_change_settings *params)
+{
+	int ret;
+
+	trace_rdev_color_change(&rdev->wiphy, dev, params);
+	ret = rdev->ops->color_change(&rdev->wiphy, dev, params);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 6e218a0acd4e..36f9215f07ac 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3547,6 +3547,53 @@ TRACE_EVENT(rdev_reset_tid_config,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT ", tids: 0x%x",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->tids)
 );
+
+TRACE_EVENT(rdev_color_change,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_color_change_settings *params),
+	TP_ARGS(wiphy, netdev, params),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(u8, count)
+		__field(u16, bcn_ofs)
+		__field(u16, pres_ofs)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->count = params->count;
+		__entry->bcn_ofs = params->counter_offset_beacon;
+		__entry->pres_ofs = params->counter_offset_presp;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT
+		  ", count: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG,
+		  __entry->count)
+);
+
+TRACE_EVENT(cfg80211_bss_color_notify,
+	TP_PROTO(struct net_device *netdev,
+		 enum nl80211_commands cmd,
+		 u8 count, u64 color_bitmap),
+	TP_ARGS(netdev, cmd, count, color_bitmap),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+		__field(enum nl80211_bss_scan_width, cmd)
+		__field(u8, count)
+		__field(u64, color_bitmap)
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+		__entry->cmd = cmd;
+		__entry->count = count;
+		__entry->color_bitmap = color_bitmap;
+	),
+	TP_printk(NETDEV_PR_FMT ", cmd: %x, count: %u, bitmap: %llx",
+		  NETDEV_PR_ARG, __entry->cmd, __entry->count,
+		  __entry->color_bitmap)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1

