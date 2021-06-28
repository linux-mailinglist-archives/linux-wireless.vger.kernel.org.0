Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94F43B5B34
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhF1J3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 05:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232483AbhF1J3C (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 05:29:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DF8A61C49;
        Mon, 28 Jun 2021 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624872397;
        bh=bwuDlvsuyrfB7Jj2f2ow5QJ0J6lNprm1bQuOAh8pK0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTeTJFl3pMSnTYqb7hdM5slnvlec3F0iGjOpPrkOxn6Ut/xlKPsuR4pGZaW8OQmuO
         0sso7YUwEqOqEg2HmrvpzXobg9ymVECUD7tf95GI3Vnd9VMpg27VMOeJN5KV3qsqSi
         /Fiy+Wj/nQLyzR1S9UrTfpWYblo239n5jgxdTFbZm6YpjIHkRin3pFtlxPsdhmxPzs
         nzfOpPIc1vnGoDvvRhQ1nnI7pjDbsaPHmMsTCK81aANK88j5w2+1N1KGB6cD4NCdie
         dS+AAO8aldEPbkOfaB0SrDnnXF2Z26b5DDvZTS80U4wPM15sfD7Uz6V+LMbW/Nt0Yl
         lMfk9CdojFUTw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     john@phrozen.org, nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v8 mac80211-next 1/3] nl80211: add support for BSS coloring
Date:   Mon, 28 Jun 2021 11:26:20 +0200
Message-Id: <ce7d1196a7cd50102b390751818e50843c12d8d3.1624872141.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624872141.git.lorenzo@kernel.org>
References: <cover.1624872141.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

This patch adds support for BSS color collisions to the wireless subsystem.
Add the required functionality to nl80211 that will notify about color
collisions, triggering the color change and notifying when it is completed.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       |  92 ++++++++++++++++++++
 include/uapi/linux/nl80211.h |  43 ++++++++++
 net/wireless/nl80211.c       | 157 +++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  13 +++
 net/wireless/trace.h         |  46 ++++++++++
 5 files changed, 351 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c93a2cd77920..35363d46fd49 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1252,6 +1252,27 @@ struct cfg80211_csa_settings {
 	u8 count;
 };
 
+/**
+ * struct cfg80211_color_change_settings - color change settings
+ *
+ * Used for bss color change
+ *
+ * @beacon_color_change: beacon data while performing the color countdown
+ * @counter_offsets_beacon: offsets of the counters within the beacon (tail)
+ * @counter_offsets_presp: offsets of the counters within the probe response
+ * @beacon_next: beacon data to be used after the color change
+ * @count: number of beacons until the color change
+ * @color: the color used after the change
+ */
+struct cfg80211_color_change_settings {
+	struct cfg80211_beacon_data beacon_color_change;
+	u16 counter_offset_beacon;
+	u16 counter_offset_presp;
+	struct cfg80211_beacon_data beacon_next;
+	u8 count;
+	u8 color;
+};
+
 /**
  * struct iface_combination_params - input parameters for interface combinations
  *
@@ -3995,6 +4016,8 @@ struct mgmt_frame_regs {
  *	given TIDs. This callback may sleep.
  *
  * @set_sar_specs: Update the SAR (TX power) settings.
+ *
+ * @color_change: Initiate a color change.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4322,6 +4345,9 @@ struct cfg80211_ops {
 				    const u8 *peer, u8 tids);
 	int	(*set_sar_specs)(struct wiphy *wiphy,
 				 struct cfg80211_sar_specs *sar);
+	int	(*color_change)(struct wiphy *wiphy,
+				struct net_device *dev,
+				struct cfg80211_color_change_settings *params);
 };
 
 /*
@@ -8216,4 +8242,70 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
  */
 void cfg80211_bss_flush(struct wiphy *wiphy);
 
+/**
+ * cfg80211_bss_color_notify - notify about bss color event
+ * @dev: network device
+ * @gfp: allocation flags
+ * @cmd: the actual event we want to notify
+ * @count: the number of TBTTs until the color change happens
+ * @color_bitmap: representations of the colors that the local BSS is aware of
+ */
+int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
+			      enum nl80211_commands cmd, u8 count,
+			      u64 color_bitmap);
+
+/**
+ * cfg80211_obss_color_collision_notify - notify about bss color collision
+ * @dev: network device
+ * @color_bitmap: representations of the colors that the local BSS is aware of
+ */
+static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
+						       u64 color_bitmap)
+{
+	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
+					 NL80211_CMD_OBSS_COLOR_COLLISION,
+					 0, color_bitmap);
+}
+
+/**
+ * cfg80211_color_change_started_notify - notify color change start
+ * @dev: the device on which the color is switched
+ * @count: the number of TBTTs until the color change happens
+ *
+ * Inform the userspace about the color change that has started.
+ */
+static inline int cfg80211_color_change_started_notify(struct net_device *dev,
+						       u8 count)
+{
+	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
+					 NL80211_CMD_COLOR_CHANGE_STARTED,
+					 count, 0);
+}
+
+/**
+ * cfg80211_color_change_aborted_notify - notify color change abort
+ * @dev: the device on which the color is switched
+ *
+ * Inform the userspace about the color change that has aborted.
+ */
+static inline int cfg80211_color_change_aborted_notify(struct net_device *dev)
+{
+	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
+					 NL80211_CMD_COLOR_CHANGE_ABORTED,
+					 0, 0);
+}
+
+/**
+ * cfg80211_color_change_notify - notify color change completion
+ * @dev: the device on which the color was switched
+ *
+ * Inform the userspace about the color change that has completed.
+ */
+static inline int cfg80211_color_change_notify(struct net_device *dev)
+{
+	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
+					 NL80211_CMD_COLOR_CHANGE_COMPLETED,
+					 0, 0);
+}
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index db474994fa73..c2efea98e060 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1185,6 +1185,21 @@
  *	passed using %NL80211_ATTR_SAR_SPEC. %NL80211_ATTR_WIPHY is used to
  *	specify the wiphy index to be applied to.
  *
+ * @NL80211_CMD_OBSS_COLOR_COLLISION: This notification is sent out whenever
+ *	mac80211/drv detects a bss color collision.
+ *
+ * @NL80211_CMD_COLOR_CHANGE_REQUEST: This command is used to indicate that
+ *	userspace wants to change the BSS color.
+ *
+ * @NL80211_CMD_COLOR_CHANGE_STARTED: Notify userland, that a color change has
+ *	started
+ *
+ * @NL80211_CMD_COLOR_CHANGE_ABORTED: Notify userland, that the color change has
+ *	been aborted
+ *
+ * @NL80211_CMD_COLOR_CHANGE_COMPLETED: Notify userland that the color change
+ *	has completed
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1417,6 +1432,14 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_SAR_SPECS,
 
+	NL80211_CMD_OBSS_COLOR_COLLISION,
+
+	NL80211_CMD_COLOR_CHANGE_REQUEST,
+
+	NL80211_CMD_COLOR_CHANGE_STARTED,
+	NL80211_CMD_COLOR_CHANGE_ABORTED,
+	NL80211_CMD_COLOR_CHANGE_COMPLETED,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2560,6 +2583,16 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_OBSS_COLOR_BITMAP: bitmap of the u64 BSS colors for the
+ *	%NL80211_CMD_OBSS_COLOR_COLLISION event.
+ *
+ * @NL80211_ATTR_COLOR_CHANGE_COUNT: u8 attribute specifying the number of TBTT's
+ *	until the color switch event.
+ * @NL80211_ATTR_COLOR_CHANGE_COLOR: u8 attribute specifying the color that we are
+ *	switching to
+ * @NL80211_ATTR_COLOR_CHANGE_ELEMS: Nested set of attributes containing the IE
+ *	information for the time while performing a color switch.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3057,6 +3090,12 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_OBSS_COLOR_BITMAP,
+
+	NL80211_ATTR_COLOR_CHANGE_COUNT,
+	NL80211_ATTR_COLOR_CHANGE_COLOR,
+	NL80211_ATTR_COLOR_CHANGE_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5953,6 +5992,9 @@ enum nl80211_feature_flags {
  *      frame protection for all management frames exchanged during the
  *      negotiation and range measurement procedure.
  *
+ * @NL80211_EXT_FEATURE_BSS_COLOR: The driver supports BSS color collision
+ *	detection and change announcemnts.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6017,6 +6059,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SECURE_LTF,
 	NL80211_EXT_FEATURE_SECURE_RTT,
 	NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE,
+	NL80211_EXT_FEATURE_BSS_COLOR,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 50eb405b0690..6422542bad7d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -759,6 +759,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_OBSS_COLOR_BITMAP] = { .type = NLA_U64 },
+	[NL80211_ATTR_COLOR_CHANGE_COUNT] = { .type = NLA_U8 },
+	[NL80211_ATTR_COLOR_CHANGE_COLOR] = { .type = NLA_U8 },
+	[NL80211_ATTR_COLOR_CHANGE_ELEMS] = NLA_POLICY_NESTED(nl80211_policy),
 };
 
 /* policy for the key attributes */
@@ -14800,6 +14804,106 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 	return ret;
 }
 
+static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_color_change_settings params = {};
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct nlattr **tb = NULL;
+	u16 offset;
+	int err;
+
+	if (!rdev->ops->color_change)
+		return -EOPNOTSUPP;
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_BSS_COLOR))
+		return -EOPNOTSUPP;
+
+	if (wdev->iftype != NL80211_IFTYPE_AP)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_COLOR_CHANGE_COUNT] ||
+	    !info->attrs[NL80211_ATTR_COLOR_CHANGE_COLOR] ||
+	    !info->attrs[NL80211_ATTR_COLOR_CHANGE_ELEMS])
+		return -EINVAL;
+
+	params.count = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_COUNT]);
+	params.color = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_COLOR]);
+
+	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_next);
+	if (err)
+		return err;
+
+	tb = kcalloc(NL80211_ATTR_MAX + 1, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
+	err = nla_parse_nested(tb, NL80211_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_COLOR_CHANGE_ELEMS],
+			       nl80211_policy, info->extack);
+	if (err)
+		goto out;
+
+	err = nl80211_parse_beacon(rdev, tb, &params.beacon_color_change);
+	if (err)
+		goto out;
+
+	if (!tb[NL80211_ATTR_CNTDWN_OFFS_BEACON]) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (nla_len(tb[NL80211_ATTR_CNTDWN_OFFS_BEACON]) != sizeof(u16)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	offset = nla_get_u16(tb[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
+	if (offset >= params.beacon_color_change.tail_len) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (params.beacon_color_change.tail[offset] != params.count) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	params.counter_offset_beacon = offset;
+
+	if (tb[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
+		if (nla_len(tb[NL80211_ATTR_CNTDWN_OFFS_PRESP]) !=
+		    sizeof(u16)) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		offset = nla_get_u16(tb[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
+		if (offset >= params.beacon_color_change.probe_resp_len) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (params.beacon_color_change.probe_resp[offset] !=
+		    params.count) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		params.counter_offset_presp = offset;
+	}
+
+	wdev_lock(wdev);
+	err = rdev_color_change(rdev, dev, &params);
+	wdev_unlock(wdev);
+
+out:
+	kfree(tb);
+	return err;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -15798,6 +15902,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_WIPHY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_COLOR_CHANGE_REQUEST,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_color_change,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_NEED_RTNL,
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
@@ -17427,6 +17539,51 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
+int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
+			      enum nl80211_commands cmd, u8 count,
+			      u64 color_bitmap)
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
+		return -ENOMEM;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, cmd);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex))
+		goto nla_put_failure;
+
+	if (cmd == NL80211_CMD_COLOR_CHANGE_STARTED &&
+	    nla_put_u32(msg, NL80211_ATTR_COLOR_CHANGE_COUNT, count))
+		goto nla_put_failure;
+
+	if (cmd == NL80211_CMD_OBSS_COLOR_COLLISION &&
+	    nla_put_u64_64bit(msg, NL80211_ATTR_OBSS_COLOR_BITMAP,
+			      color_bitmap, NL80211_ATTR_PAD))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy),
+				       msg, 0, NL80211_MCGRP_MLME, gfp);
+
+nla_put_failure:
+	nlmsg_free(msg);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(cfg80211_bss_color_notify);
+
 void
 nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 		     const struct cfg80211_chan_def *chandef,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index b1d37f582dc6..ce6bf218a1a3 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1368,4 +1368,17 @@ static inline int rdev_set_sar_specs(struct cfg80211_registered_device *rdev,
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
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 440bce5f0274..911bb3b8969e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3597,6 +3597,52 @@ TRACE_EVENT(rdev_set_sar_specs,
 		  WIPHY_PR_ARG, __entry->type, __entry->num)
 );
 
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
2.31.1

