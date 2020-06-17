Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E401FD034
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFQPAb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgFQPA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 11:00:29 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE8C061755
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2020 08:00:29 -0700 (PDT)
Received: from [134.101.215.41] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jlZY9-0004hN-TB; Wed, 17 Jun 2020 17:00:25 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/3] nl80211: add support for BSS coloring
Date:   Wed, 17 Jun 2020 17:00:19 +0200
Message-Id: <20200617150021.4183253-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the required functionality to nl80211 that we require to notify about
color collisions, triggering the color change and notifying when it is
completed.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       |  64 ++++++++++++++
 include/uapi/linux/nl80211.h |  43 +++++++++
 net/wireless/nl80211.c       | 164 +++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  12 +++
 net/wireless/trace.h         |  60 +++++++++++++
 5 files changed, 343 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b58ad1a3f695..0bf5bb6b65fc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1155,6 +1155,27 @@ struct cfg80211_csa_settings {
 	u8 count;
 };
 
+/**
+ * struct cfg80211_cca_settings - color change settings
+ *
+ * Used for color change
+ *
+ * @beacon_cca: beacon data while performing the change
+ * @counter_offsets_beacon: offsets of the counters within the beacon (tail)
+ * @counter_offsets_presp: offsets of the counters within the probe response
+ * @beacon_after: beacon data to be used after the change
+ * @count: number of beacons until the change
+ * @color: the color that we will have after th change
+ */
+struct cfg80211_cca_settings {
+	struct cfg80211_beacon_data beacon_cca;
+	u16 counter_offset_beacon;
+	u16 counter_offset_presp;
+	struct cfg80211_beacon_data beacon_after;
+	u8 count;
+	u8 color;
+};
+
 #define CFG80211_MAX_NUM_DIFFERENT_CHANNELS 10
 
 /**
@@ -3795,6 +3816,7 @@ struct mgmt_frame_regs {
  *	This callback may sleep.
  * @reset_tid_config: Reset TID specific configuration for the peer, for the
  *	given TIDs. This callback may sleep.
+ * @color_change: initiate a color change (with CCA).
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4123,6 +4145,9 @@ struct cfg80211_ops {
 				  struct cfg80211_tid_config *tid_conf);
 	int	(*reset_tid_config)(struct wiphy *wiphy, struct net_device *dev,
 				    const u8 *peer, u8 tids);
+	int	(*color_change)(struct wiphy *wiphy,
+				struct net_device *dev,
+				struct cfg80211_cca_settings *params);
 };
 
 /*
@@ -4172,6 +4197,7 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_HAS_STATIC_WEP: The device supports static WEP key installation
  *	before connection.
  * @WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK: The device supports bigger kek and kck keys
+ * @WIPHY_FLAG_SUPPORTS_BSS_COLOR: Device supports BSS coloring
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -4198,6 +4224,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_HAS_STATIC_WEP		= BIT(24),
+	WIPHY_FLAG_SUPPORTS_BSS_COLOR		= BIT(25),
 };
 
 /**
@@ -7881,4 +7908,41 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 				    struct cfg80211_update_owe_info *owe_info,
 				    gfp_t gfp);
 
+/**
+ * cfg80211_obss_color_collision_notify - notify about bss color collisions
+ * @dev: network device
+ * @color_bitmap: representations of the colors that the local BSS is aware of
+ */
+void cfg80211_obss_color_collision_notify(struct net_device *dev,
+					  u64 color_bitmap);
+
+/*
+ * cfg80211_color_change_started_notify - notify color change start
+ * @dev: the device on which the color is switched
+ * @count: the number of TBTTs until the color change happens
+ *
+ * Inform the userspace about the color change that has just
+ * started.
+ */
+void cfg80211_color_change_started_notify(struct net_device *dev,
+					  u8 count);
+
+/*
+ * cfg80211_color_change_aborted_notify - notify color change abort
+ * @dev: the device on which the color is switched
+ *
+ * Inform the userspace about the color change that has just
+ * started.
+ */
+void cfg80211_color_change_aborted_notify(struct net_device *dev);
+
+/*
+ * cfg80211_color_change_notify - notify color change completion
+ * @dev: the device on which the color was switched
+ *
+ * Inform the userspace about the color change that has just
+ * completed.
+ */
+void cfg80211_color_change_notify(struct net_device *dev);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dad8c8f8581f..e76b4a8df675 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1170,6 +1170,20 @@
  *	includes the contents of the frame. %NL80211_ATTR_ACK flag is included
  *	if the recipient acknowledged the frame.
  *
+ * @NL80211_CMD_OBSS_COLOR_COLLISION: This notification is sent out whenever a
+ *	mac detects a bss color collision.
+ *
+ * @NL80211_CMD_COLOR_CHANGE: This command is used to indicate that we want to
+ *	change the BSS color.
+ *
+ * @NL80211_CMD_CCA_STARTED_NOTIFY: Notify userland, that we color change has
+ *	started
+ *
+ * @NL80211_CMD_CCA_ABORTED_NOTIFY: Notify userland, that we color change has
+ *	been aborted
+ *
+ * @NL80211_CMD_CCA_NOTIFY: Notify userland, that we color change has completed
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1400,6 +1414,13 @@ enum nl80211_commands {
 
 	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
 
+	NL80211_CMD_OBSS_COLOR_COLLISION,
+
+	NL80211_CMD_COLOR_CHANGE,
+	NL80211_CMD_CCA_STARTED_NOTIFY,
+	NL80211_CMD_CCA_ABORTED_NOTIFY,
+	NL80211_CMD_CCA_NOTIFY,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2505,6 +2526,20 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
  *
+ * @NL80211_ATTR_OBSS_COLOR_BITMAP: bitmap of the 64 BSS colors for the
+ *	%NL80211_CMD_OBSS_COLOR_COLLISION command.
+ *
+ * @NL80211_ATTR_CCA_COUNT: u8 attribute specifying the number of TBTT's
+ *	until the color switch event.
+ * @NL80211_ATTR_CCA_COLOR: u8 attribute specifying the color that we are
+ *	switching to
+ * @NL80211_ATTR_CCA_IES: Nested set of attributes containing the IE information
+ *	for the time while performing a color switch.
+ * @NL80211_ATTR_CCA_C_OFF_BEACON: An array of offsets (u16) to the color
+ *	switch counters in the beacons tail (%NL80211_ATTR_BEACON_TAIL).
+ * @NL80211_ATTR_CCA_C_OFF_PRESP: An array of offsets (u16) to the color
+ *	switch counters in the probe response (%NL80211_ATTR_PROBE_RESP).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2987,6 +3022,14 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_OBSS_COLOR_BITMAP,
+
+	NL80211_ATTR_CCA_COUNT,
+	NL80211_ATTR_CCA_COLOR,
+	NL80211_ATTR_CCA_IES,
+	NL80211_ATTR_CCA_C_OFF_BEACON,
+	NL80211_ATTR_CCA_C_OFF_PRESP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263ae395ad44..3529795bbffd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -658,6 +658,12 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		.type = NLA_EXACT_LEN,
 		.len = sizeof(struct ieee80211_he_6ghz_capa),
 	},
+	[NL80211_ATTR_OBSS_COLOR_BITMAP] = { .type = NLA_U64 },
+	[NL80211_ATTR_CCA_COUNT] = { .type = NLA_U8 },
+	[NL80211_ATTR_CCA_COLOR] = { .type = NLA_U8 },
+	[NL80211_ATTR_CCA_IES] = { .type = NLA_NESTED },
+	[NL80211_ATTR_CCA_C_OFF_BEACON] = { .type = NLA_U16 },
+	[NL80211_ATTR_CCA_C_OFF_PRESP] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -14274,6 +14280,76 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 	return ret;
 }
 
+static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_cca_settings params;
+	static struct nlattr *cca_attrs[NL80211_ATTR_MAX + 1];
+	int err;
+
+	if (!rdev->ops->color_change ||
+	    !(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_BSS_COLOR))
+		return -EOPNOTSUPP;
+
+	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP)
+		return -EOPNOTSUPP;
+
+	memset(&params, 0, sizeof(params));
+
+	if (!info->attrs[NL80211_ATTR_CCA_COUNT] ||
+	    !info->attrs[NL80211_ATTR_CCA_COLOR] ||
+	    !info->attrs[NL80211_ATTR_CCA_IES])
+		return -EINVAL;
+
+	params.count = nla_get_u8(info->attrs[NL80211_ATTR_CCA_COUNT]);
+	params.color = nla_get_u8(info->attrs[NL80211_ATTR_CCA_COLOR]);
+
+	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_after);
+	if (err)
+		return err;
+
+	err = nla_parse_nested_deprecated(cca_attrs, NL80211_ATTR_MAX,
+					  info->attrs[NL80211_ATTR_CCA_IES],
+					  nl80211_policy, info->extack);
+	if (err)
+		return err;
+
+	err = nl80211_parse_beacon(rdev, cca_attrs, &params.beacon_cca);
+	if (err)
+		return err;
+
+	if (!cca_attrs[NL80211_ATTR_CCA_C_OFF_BEACON])
+		return -EINVAL;
+
+	params.counter_offset_beacon =
+		nla_get_u16(cca_attrs[NL80211_ATTR_CCA_C_OFF_BEACON]);
+
+	if (params.counter_offset_beacon >= params.beacon_cca.tail_len)
+		return -EINVAL;
+
+	if (params.beacon_cca.tail[params.counter_offset_beacon] != params.count)
+		return -EINVAL;
+
+	if (cca_attrs[NL80211_ATTR_CCA_C_OFF_PRESP]) {
+		params.counter_offset_presp =
+			nla_get_u16(cca_attrs[NL80211_ATTR_CCA_C_OFF_PRESP]);
+
+		if (params.counter_offset_presp >= params.beacon_cca.probe_resp_len)
+			return -EINVAL;
+
+		if (params.beacon_cca.probe_resp[params.counter_offset_presp] != params.count)
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
@@ -15235,6 +15311,14 @@ static const struct genl_ops nl80211_ops[] = {
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
@@ -16848,6 +16932,86 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
+static void nl80211_bss_color_notify(struct net_device *netdev,
+				     gfp_t gfp, enum nl80211_commands notif,
+				     u8 count, u64 color_bitmap)
+{
+	struct wireless_dev *wdev = netdev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	ASSERT_WDEV_LOCK(wdev);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, notif);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex))
+		goto nla_put_failure;
+
+	if (notif == NL80211_CMD_CCA_STARTED_NOTIFY &&
+	    nla_put_u32(msg, NL80211_ATTR_CCA_COUNT, count))
+		goto nla_put_failure;
+
+	if (notif == NL80211_CMD_OBSS_COLOR_COLLISION &&
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
+
+void cfg80211_obss_color_collision_notify(struct net_device *dev,
+					  u64 color_bitmap)
+{
+	nl80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_OBSS_COLOR_COLLISION, 0,
+				 color_bitmap);
+}
+EXPORT_SYMBOL(cfg80211_obss_color_collision_notify);
+
+void cfg80211_color_change_notify(struct net_device *dev)
+{
+	trace_cfg80211_color_change_notify(dev);
+
+	nl80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_CCA_NOTIFY, 0, 0);
+}
+EXPORT_SYMBOL(cfg80211_color_change_notify);
+
+void cfg80211_color_change_started_notify(struct net_device *dev, u8 count)
+{
+	trace_cfg80211_color_change_started_notify(dev);
+
+	nl80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_CCA_STARTED_NOTIFY, count, 0);
+}
+EXPORT_SYMBOL(cfg80211_color_change_started_notify);
+
+void cfg80211_color_change_aborted_notify(struct net_device *dev)
+{
+	trace_cfg80211_color_change_aborted_notify(dev);
+
+	nl80211_bss_color_notify(dev, GFP_KERNEL,
+				 NL80211_CMD_CCA_ABORTED_NOTIFY, 0, 0);
+}
+EXPORT_SYMBOL(cfg80211_color_change_aborted_notify);
+
 void
 nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 		     const struct cfg80211_chan_def *chandef,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 950d57494168..70615aa1db0e 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1356,4 +1356,16 @@ static inline int rdev_reset_tid_config(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_color_change(struct cfg80211_registered_device *rdev,
+				    struct net_device *dev,
+				    struct cfg80211_cca_settings *params)
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
index b23cab016521..48b55289a234 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3545,6 +3545,66 @@ TRACE_EVENT(rdev_reset_tid_config,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT ", tids: 0x%x",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->tids)
 );
+
+TRACE_EVENT(rdev_color_change,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_cca_settings *params),
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
+TRACE_EVENT(cfg80211_color_change_started_notify,
+	TP_PROTO(struct net_device *netdev),
+	TP_ARGS(netdev),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+	),
+	TP_printk(NETDEV_PR_FMT ", ", NETDEV_PR_ARG)
+);
+
+TRACE_EVENT(cfg80211_color_change_notify,
+	TP_PROTO(struct net_device *netdev),
+	TP_ARGS(netdev),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+	),
+	TP_printk(NETDEV_PR_FMT ", ", NETDEV_PR_ARG)
+);
+
+TRACE_EVENT(cfg80211_color_change_aborted_notify,
+	TP_PROTO(struct net_device *netdev),
+	TP_ARGS(netdev),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+	),
+	TP_printk(NETDEV_PR_FMT ", ", NETDEV_PR_ARG)
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1

