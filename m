Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725621391DE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 14:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMNL7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 08:11:59 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:35769 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbgAMNL6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 08:11:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578921117; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4/u0emAMv6t1ue50FQBiOiXqvjs98oiT2lrRD4B/obk=; b=Q2hh/cUm0H5PAHG2yHEzT0DTNQ7NQYmiT9ScENK6aHiD979b2uOJsEeldhVCV+1bstA9KcSb
 m44Xak6acM7rW5JCEsjnAdAUBCiL9IM3YfzWfzxEkPFIuNYX5hfVg3B3NA+KJdQSIVJWewOs
 ucmBSwYNESQIni6gSvQWt7XCDCs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c6c97.7fa1e486c6c0-smtp-out-n03;
 Mon, 13 Jan 2020 13:11:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B0B9C447A5; Mon, 13 Jan 2020 13:11:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA9F1C447A4;
        Mon, 13 Jan 2020 13:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA9F1C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv9 1/6] nl80211: Add NL command to support TID speicific configurations
Date:   Mon, 13 Jan 2020 18:41:25 +0530
Message-Id: <1578921090-9758-2-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
References: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

Add the new NL80211_CMD_SET_TID_CONFIG command to support
data TID specific configuration. Per TID configuration is
passed in the nested NL80211_ATTR_TID_CONFIG attribute.

This patch adds support to configure per TID noack policy
through the NL80211_TID_CONFIG_ATTR_NOACK attribute.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |   40 ++++++++++++
 include/uapi/linux/nl80211.h |   71 +++++++++++++++++++++
 net/wireless/nl80211.c       |  142 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |   24 +++++++
 net/wireless/trace.h         |   37 +++++++++++
 5 files changed, 314 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 059524b..c5d1eb1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -598,6 +598,38 @@ struct cfg80211_chan_def {
 	struct ieee80211_edmg edmg;
 };
 
+enum ieee80211_tid_conf_mask {
+	IEEE80211_TID_CONF_NOACK	= BIT(NL80211_TID_CONFIG_ATTR_NOACK),
+};
+
+/**
+ * struct ieee80211_tid_cfg - TID specific configuration
+ * @config_override: Flag to notify driver to reset TID configuration
+ *	of the peer.
+ * @tid: TID number
+ * @tid_conf_mask: bitmap indicating which parameter changed
+ *	see &enum ieee80211_tid_conf_mask
+ * @noack: noack configuration value for the TID
+ */
+struct ieee80211_tid_cfg {
+	bool config_override;
+	u8 tid;
+	u32 tid_conf_mask;
+	enum nl80211_tid_config noack;
+};
+
+/**
+ * struct ieee80211_tid_config - TID configuration
+ * @peer: Station's MAC address
+ * @n_tid_conf: Number of TID specific configurations to be applied
+ * @tid_conf: Configuration change info
+ */
+struct ieee80211_tid_config {
+	const u8 *peer;
+	u32 n_tid_conf;
+	struct ieee80211_tid_cfg tid_conf[];
+};
+
 /**
  * cfg80211_get_chandef_type - return old channel type from chandef
  * @chandef: the channel definition
@@ -3636,6 +3668,10 @@ struct cfg80211_update_owe_info {
  *
  * @probe_mesh_link: Probe direct Mesh peer's link quality by sending data frame
  *	and overrule HWMP path selection algorithm.
+ * @set_tid_config: TID specific configuration, this can be peer or BSS specific
+ *	This callback may sleep.
+ * @reset_tid_config: Reset TID specific configuration for the peer.
+ *	This callback may sleep.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -3954,6 +3990,10 @@ struct cfg80211_ops {
 				   struct cfg80211_update_owe_info *owe_info);
 	int	(*probe_mesh_link)(struct wiphy *wiphy, struct net_device *dev,
 				   const u8 *buf, size_t len);
+	int     (*set_tid_config)(struct wiphy *wiphy, struct net_device *dev,
+				  struct ieee80211_tid_config *tid_conf);
+	int	(*reset_tid_config)(struct wiphy *wiphy, struct net_device *dev,
+				    const u8 *peer, u8 tid);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 341e0e8..df1ebdc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -265,6 +265,26 @@
  */
 
 /**
+ * DOC: TID configuration
+ *
+ * TID configuration support can be advertised by drivers by setting
+ * @NL80211_EXT_FEATURE_PER_TID_* and/or @NL80211_EXT_FEATURE_PER_STA_* config
+ * mentioned in &enum nl80211_tid_config_attr.
+ * Needed configuration parameters are mentioned &enum nl80211_tid_config_attr
+ * and it will be passed using %NL80211_CMD_SET_TID_CONFIG through
+ * %NL80211_ATTR_TID_CONFIG. If the configuration needs to be applied for
+ * specific peer then MAC address of the peer needs to be passed in
+ * %NL80211_ATT_MAC, otherwise the configuration will be applied for all the
+ * connected peers in the vif except the peer which has peer specific
+ * configuration for the TID. And the peer specific configuration will be
+ * override if %NL80211_TID_CONFIG_ATTR_OVERRIDE flag is set.
+ * All this configurations are valid only for STA's current connection
+ * i.e. the configurations will be reset to default when the STA connects back
+ * after disconnectiion/roaming, and this configuration will be cleared when
+ * the interface goes down.
+ */
+
+/**
  * enum nl80211_commands - supported nl80211 commands
  *
  * @NL80211_CMD_UNSPEC: unspecified command to catch errors
@@ -1125,6 +1145,9 @@
  *	peer MAC address and %NL80211_ATTR_FRAME is used to specify the frame
  *	content. The frame is ethernet data.
  *
+ * @NL80211_CMD_SET_TID_CONFIG: Data frame TID specific configuration
+ *	is passed using %NL80211_ATTR_TID_CONFIG attribute.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1349,6 +1372,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_PROBE_MESH_LINK,
 
+	NL80211_CMD_SET_TID_CONFIG,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2400,6 +2425,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
  *	(u16).
  *
+ * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
+ *	nested attribute with &enum nl80211_tid_config_attr sub-attributes.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2864,6 +2892,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_VLAN_ID,
 
+	NL80211_ATTR_TID_CONFIG,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4703,6 +4733,40 @@ enum nl80211_tx_power_setting {
 };
 
 /**
+ * enum nl80211_tid_config - TID config state
+ * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
+ * @NL80211_TID_CONFIG_DISABLE: Disable config for the TID
+ */
+enum nl80211_tid_config {
+	NL80211_TID_CONFIG_ENABLE,
+	NL80211_TID_CONFIG_DISABLE,
+};
+
+/* enum nl80211_tid_config_attr - TID specific configuration.
+ * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribue, if no peer
+ *	is selected, if set indicates that the new configuration overrides
+ *	all previous peer configurations, otherwise previous peer specific
+ *	configurations should be left untouched. If peer is selected then
+ *	it will reset particular TID configuration of that peer and it will
+ *	not accept other TID config attributes along with peer.
+ * @NL80211_TID_CONFIG_ATTR_TIDS: a bitmask value of TIDs(bit 0 to 7)
+ *	Its type is u8.
+ * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
+ *	specified in %NL80211_TID_CONFIG_ATTR_TID. see %enum nl80211_tid_config.
+ *	Its type is u8.
+ */
+enum nl80211_tid_config_attr {
+	__NL80211_TID_CONFIG_ATTR_INVALID,
+	NL80211_TID_CONFIG_ATTR_OVERRIDE,
+	NL80211_TID_CONFIG_ATTR_TIDS,
+	NL80211_TID_CONFIG_ATTR_NOACK,
+
+	/* keep last */
+	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
+	NL80211_TID_CONFIG_ATTR_MAX = __NL80211_TID_CONFIG_ATTR_AFTER_LAST - 1
+};
+
+/**
  * enum nl80211_packet_pattern_attr - packet pattern attribute
  * @__NL80211_PKTPAT_INVALID: invalid number for nested attribute
  * @NL80211_PKTPAT_PATTERN: the pattern, values where the mask has
@@ -5516,6 +5580,11 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_VLAN_OFFLOAD: The driver supports a single netdev
  *	with VLAN tagged frames and separate VLAN-specific netdevs added using
  *	vconfig similarly to the Ethernet case.
+ * @NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG: Driver supports per TID NoAck
+ *	policy functionality.
+ * @NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG: Driver supports STA specific NoAck
+ *	policy functionality.
+ *
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5563,6 +5632,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
+	NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fa35265..d20c832 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -321,6 +321,14 @@ static int validate_ie_attr(const struct nlattr *attr,
 		NLA_POLICY_RANGE(NLA_U8, 1, 20),
 };
 
+static const struct nla_policy
+nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
+	[NL80211_TID_CONFIG_ATTR_OVERRIDE] = { .type = NLA_FLAG },
+	[NL80211_TID_CONFIG_ATTR_TIDS] = { .type = NLA_U8 },
+	[NL80211_TID_CONFIG_ATTR_NOACK] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+};
+
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -625,6 +633,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
 	[NL80211_ATTR_VLAN_ID] = NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
+	[NL80211_ATTR_TID_CONFIG] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_tid_config_attr_policy),
 };
 
 /* policy for the key attributes */
@@ -13798,6 +13808,131 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 	return rdev_probe_mesh_link(rdev, dev, dest, buf, len);
 }
 
+static int
+__nl80211_check_tid_conf_support(struct cfg80211_registered_device *rdev,
+				 struct netlink_ext_ack *extack,
+				 const u8 *peer, struct nlattr *attrs[],
+				 struct ieee80211_tid_cfg *tid_conf,
+				 enum nl80211_tid_config_attr attr,
+				 enum nl80211_ext_feature_index per_tid_config,
+				 enum nl80211_ext_feature_index per_sta_config)
+{
+	if (!wiphy_ext_feature_isset(&rdev->wiphy, per_tid_config)) {
+		NL_SET_ERR_MSG_ATTR(extack, attrs[attr],
+				    "TID specific configuration not supported");
+		return -ENOTSUPP;
+	}
+
+	if (peer && !wiphy_ext_feature_isset(&rdev->wiphy, per_sta_config)) {
+		NL_SET_ERR_MSG_ATTR(extack, attrs[attr],
+				    "peer specific TID configuration not supported");
+		return -ENOTSUPP;
+	}
+
+	tid_conf->tid_conf_mask |= BIT(attr);
+	return 0;
+}
+
+#define nl80211_check_tid_config_support(rdev, extack, peer, attrs, tid_conf, \
+					 conf)	\
+	__nl80211_check_tid_conf_support(rdev, extack, peer, attrs, tid_conf, \
+				 NL80211_TID_CONFIG_ATTR_##conf,	\
+				 NL80211_EXT_FEATURE_PER_TID_##conf##_CONFIG, \
+				 NL80211_EXT_FEATURE_PER_STA_##conf##_CONFIG)
+
+static int parse_tid_conf(struct cfg80211_registered_device *rdev,
+			  struct nlattr *attrs[], struct net_device *dev,
+			  struct ieee80211_tid_cfg *tid_conf,
+			  struct genl_info *info, const u8 *peer)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	int err;
+
+	if (!attrs[NL80211_TID_CONFIG_ATTR_TIDS])
+		return -EINVAL;
+
+	tid_conf->config_override =
+			nla_get_flag(attrs[NL80211_TID_CONFIG_ATTR_OVERRIDE]);
+	tid_conf->tid = nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_TIDS]);
+
+	if (peer && tid_conf->config_override) {
+		if (rdev->ops->reset_tid_config)
+			return rdev_reset_tid_config(rdev, dev, peer,
+						     tid_conf->tid);
+		else
+			return -EINVAL;
+	}
+
+	if (attrs[NL80211_TID_CONFIG_ATTR_NOACK]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+						       attrs, tid_conf,
+						       NOACK);
+		if (err)
+			return err;
+
+		tid_conf->noack =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_NOACK]);
+	}
+
+	return 0;
+}
+
+static int nl80211_set_tid_config(struct sk_buff *skb,
+				  struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct nlattr *attrs[NL80211_TID_CONFIG_ATTR_MAX + 1];
+	struct net_device *dev = info->user_ptr[1];
+	struct ieee80211_tid_config *tid_config;
+	struct nlattr *tid;
+	int conf_idx = 0, rem_conf;
+	int ret = -EINVAL;
+	u32 num_conf = 0;
+
+	if (!info->attrs[NL80211_ATTR_TID_CONFIG])
+		return -EINVAL;
+
+	if (!rdev->ops->set_tid_config)
+		return -EOPNOTSUPP;
+
+	nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
+			    rem_conf)
+		num_conf++;
+
+	tid_config = kzalloc(struct_size(tid_config, tid_conf, num_conf),
+			     GFP_KERNEL);
+	if (!tid_config)
+		return -ENOMEM;
+
+	tid_config->n_tid_conf = num_conf;
+
+	if (info->attrs[NL80211_ATTR_MAC])
+		tid_config->peer = nla_data(info->attrs[NL80211_ATTR_MAC]);
+
+	nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
+			    rem_conf) {
+		ret = nla_parse_nested(attrs, NL80211_TID_CONFIG_ATTR_MAX,
+				       tid, NULL, NULL);
+
+		if (ret)
+			goto bad_tid_conf;
+
+		ret = parse_tid_conf(rdev, attrs, dev,
+				     &tid_config->tid_conf[conf_idx],
+				     info, tid_config->peer);
+		if (ret)
+			goto bad_tid_conf;
+
+		conf_idx++;
+	}
+
+	ret = rdev_set_tid_config(rdev, dev, tid_config);
+
+bad_tid_conf:
+	kfree(tid_config);
+	return ret;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -14752,6 +14887,13 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_SET_TID_CONFIG,
+		.doit = nl80211_set_tid_config,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV |
+				  NL80211_FLAG_NEED_RTNL,
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index e853a4f..582a617 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1299,4 +1299,28 @@ static inline int rdev_update_owe_info(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_set_tid_config(struct cfg80211_registered_device *rdev,
+				      struct net_device *dev,
+				      struct ieee80211_tid_config *tid_conf)
+{
+	int ret;
+
+	trace_rdev_set_tid_config(&rdev->wiphy, dev, tid_conf);
+	ret = rdev->ops->set_tid_config(&rdev->wiphy, dev, tid_conf);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
+static inline int rdev_reset_tid_config(struct cfg80211_registered_device *rdev,
+					struct net_device *dev, const u8 *peer,
+					u8 tid)
+{
+	int ret;
+
+	trace_rdev_reset_tid_config(&rdev->wiphy, dev, peer, tid);
+	ret = rdev->ops->reset_tid_config(&rdev->wiphy, dev, peer, tid);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index d98ad2b..c2c188c 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3458,6 +3458,43 @@
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dest))
 );
 
+TRACE_EVENT(rdev_set_tid_config,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct ieee80211_tid_config *tid_conf),
+	TP_ARGS(wiphy, netdev, tid_conf),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		MAC_ENTRY(peer)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		MAC_ASSIGN(peer, tid_conf->peer);
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
+);
+
+TRACE_EVENT(rdev_reset_tid_config,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 const u8 *peer, u8 tid),
+	TP_ARGS(wiphy, netdev, peer, tid),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		MAC_ENTRY(peer)
+		__field(u8, tid)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		MAC_ASSIGN(peer, peer);
+		__entry->tid = tid;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT ", tid: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->tid)
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
1.7.9.5
