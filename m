Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29812EFD62
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 13:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbfKEMl4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 07:41:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbfKEMl4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 07:41:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3CE4B61476; Tue,  5 Nov 2019 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957715;
        bh=elL78LjMUAPsxSHRIcUyiBCA0Qvz+QupAdqQ6/MWQ5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2XWFLQvad5VOdwKzmWjFOwQpO3f1q0YlzC5etRiq6/KKo0QqTvp2fYQI41ZDLEzP
         uCDH1mB5E/uzjzTytlTGaRyjqQP7kgmj3rom822o1bp+jNLS6Br0BInbHjpEwQmLdF
         UWxCXwyQt3GBeanrlgnQNQaqgf0mwXx3eUA2cp3Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23EF561436;
        Tue,  5 Nov 2019 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957713;
        bh=elL78LjMUAPsxSHRIcUyiBCA0Qvz+QupAdqQ6/MWQ5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsSqizS6pyePInskfdnNOEwT5tSFBnNRF491g+zLWxcchAeQwKb5fPboXAbuNCNyc
         Hmkvx0QW+5JoaAS7C7Sb+j7HPKKQbH5o2owm8izoYcngrJN97fHkEELnZfoJwbdqow
         cauOwLsLIoAsbJGFnOJFoCX3gKRaks4qjdySl6nw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23EF561436
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv8 1/6] nl80211: New netlink command for TID specific configuration
Date:   Tue,  5 Nov 2019 18:11:49 +0530
Message-Id: <1572957714-16085-2-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new NL command, NL80211_CMD_SET_TID_CONFIG to support
data TID specific configuration. This per TID configurations
are passed in NL80211_TID_CONFIG_ATTR_TID which is a nested
attribute. This patch adds support to configure per TID
noack policy through NL80211_TID_CONFIG_ATTR_NOACK attribute.
Data TID value for this configuration will be passed through
NL80211_TID_CONFIG_ATTR_TID attribute. When the user-space wants
this configuration peer specific rather than being applied for
all the connected stations, MAC address of the peer can be passed
in NL80211_ATTR_MAC attribute. This patch introduced
enum ieee80211_tid_conf_mask to notify the driver that which
configuration modified.
Driver supporting data TID specific noack policy configuration
should be advertise through NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG
and supporting per STA data TID noack policy configuration
should be advertise through NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |   35 ++++++++++++
 include/uapi/linux/nl80211.h |   59 ++++++++++++++++++++
 net/wireless/nl80211.c       |  122 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |   12 +++++
 net/wireless/trace.h         |   17 ++++++
 5 files changed, 245 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ab2c49..58e956d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -596,6 +596,35 @@ struct cfg80211_chan_def {
 	struct ieee80211_edmg edmg;
 };
 
+enum ieee80211_tid_conf_mask {
+	IEEE80211_TID_CONF_NOACK	= BIT(0),
+};
+
+/**
+ * struct ieee80211_tid_cfg - TID specific configuration
+ * @tid: TID number
+ * @tid_conf_mask: bitmap indicating which parameter changed
+ *	see %enum ieee80211_tid_conf_mask
+ * @noack: noack configuration value for the TID
+ */
+struct ieee80211_tid_cfg {
+	u8 tid;
+	u32 tid_conf_mask;
+	u8 noack;
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
@@ -3625,6 +3654,10 @@ struct cfg80211_update_owe_info {
  *
  * @probe_mesh_link: Probe direct Mesh peer's link quality by sending data frame
  *	and overrule HWMP path selection algorithm.
+ * @set_tid_config: TID specific configuration. Apply this configuration for
+ *	all the connected stations in the BSS if peer is %NULL. Otherwise
+ *	apply this configuration to the specific station.
+ *	This callback may sleep.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -3943,6 +3976,8 @@ struct cfg80211_ops {
 				   struct cfg80211_update_owe_info *owe_info);
 	int	(*probe_mesh_link)(struct wiphy *wiphy, struct net_device *dev,
 				   const u8 *buf, size_t len);
+	int     (*set_tid_config)(struct wiphy *wiphy, struct net_device *dev,
+				  struct ieee80211_tid_config *tid_conf);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 64135ab..c0b43da 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1109,6 +1109,10 @@
  *	peer MAC address and %NL80211_ATTR_FRAME is used to specify the frame
  *	content. The frame is ethernet data.
  *
+ * @NL80211_CMD_SET_TID_CONFIG: Data frame TID specific configuration
+ *	is passed through this command using %NL80211_ATTR_TID_CONFIG
+ *	nested attributes.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1333,6 +1337,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_PROBE_MESH_LINK,
 
+	NL80211_CMD_SET_TID_CONFIG,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2381,6 +2387,9 @@ enum nl80211_commands {
  *	the allowed channel bandwidth configurations. (u8 attribute)
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
  *
+ * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
+ *	nested attribute with %NL80211_TID_CONFIG_ATTR_* sub-attributes.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2843,6 +2852,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_WIPHY_EDMG_CHANNELS,
 	NL80211_ATTR_WIPHY_EDMG_BW_CONFIG,
 
+	NL80211_ATTR_TID_CONFIG,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4682,6 +4693,47 @@ enum nl80211_tx_power_setting {
 };
 
 /**
+ * enum nl80211_tid_config - TID config state
+ * @NL80211_TID_CONFIG_DEFAULT: Default config for the TID. This is to
+ *	notify driver to reset the previous config and use vif specific
+ *	default config
+ * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
+ * NL80211_TID_CONFIG_DISABLE: Disable config for the TID
+ */
+enum nl80211_tid_config {
+	NL80211_TID_CONFIG_DEFAULT,
+	NL80211_TID_CONFIG_ENABLE,
+	NL80211_TID_CONFIG_DISABLE,
+};
+
+/* enum nl80211_tid_config_attr - TID specific configuration.
+ * @NL80211_TID_CONFIG_ATTR_TID: a TID value (u8 attribute).
+ * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
+ *	specified in %NL80211_TID_CONFIG_ATTR_TID. see %enum nl80211_tid_config.
+ *	Its type is u8, if the peer MAC address is passed in %NL80211_ATTR_MAC,
+ *	then the noack configuration is applied to the data frame for the tid
+ *	to that connected station. This configuration is valid only for STA's
+ *	current connection. i.e. the configuration will be reset to default when
+ *	the station connects back after disconnection/roaming.
+ *	when user-space does not include %NL80211_ATTR_MAC, then this
+ *	configuration should be treated as per-netdev configuration.
+ *	This configuration will be cleared when the interface goes down and on
+ *	the disconnection from a BSS. Driver supporting this feature should
+ *	advertise NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG and
+ *	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG for supporting  per sta
+ *	configuration.
+ */
+enum nl80211_tid_config_attr {
+	__NL80211_TID_CONFIG_ATTR_INVALID,
+	NL80211_TID_CONFIG_ATTR_TID,
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
@@ -5492,6 +5544,11 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
  *	station mode (SAE password is passed as part of the connect command).
  *
+ * @NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG: Driver supports per TID NoAck
+ *	policy functionality.
+ * @NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG: Driver supports STA specific NoAck
+ *	policy functionality.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5537,6 +5594,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d1451e7..c5c3af5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -321,6 +321,13 @@ static int validate_ie_attr(const struct nlattr *attr,
 		NLA_POLICY_RANGE(NLA_U8, 1, 20),
 };
 
+static const struct nla_policy
+nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
+	[NL80211_TID_CONFIG_ATTR_TID] = { .type = NLA_U8 },
+	[NL80211_TID_CONFIG_ATTR_NOACK] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+};
+
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -624,6 +631,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 					.len = SAE_PASSWORD_MAX_LEN },
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
+	[NL80211_ATTR_TID_CONFIG] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_tid_config_attr_policy),
 };
 
 /* policy for the key attributes */
@@ -13788,6 +13797,112 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 	return rdev_probe_mesh_link(rdev, dev, dest, buf, len);
 }
 
+static int
+nl80211_check_tid_config_support(struct cfg80211_registered_device *rdev,
+				 struct netlink_ext_ack *extack,
+				 const u8 *peer, struct nlattr *attr,
+				 enum nl80211_ext_feature_index per_tid_config,
+				 enum nl80211_ext_feature_index per_sta_config)
+{
+	if (!wiphy_ext_feature_isset(&rdev->wiphy, per_tid_config)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "TID specific configuration not supported");
+		return -ENOTSUPP;
+	}
+	
+	if (peer && !wiphy_ext_feature_isset(&rdev->wiphy, per_sta_config)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "peer specific TID configuration not supported");
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+static int parse_tid_conf(struct cfg80211_registered_device *rdev,
+			  struct nlattr *attrs[],
+			  struct ieee80211_tid_cfg *tid_conf,
+			  struct genl_info *info, const u8 *peer)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	int err;
+
+	tid_conf->tid = nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_TID]);
+	if (attrs[NL80211_TID_CONFIG_ATTR_NOACK]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+				attrs[NL80211_TID_CONFIG_ATTR_NOACK],
+				NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
+				NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG);
+		if (err)
+			return err;
+
+		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_NOACK;
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
+		if (!attrs[NL80211_TID_CONFIG_ATTR_TID]) {
+			ret = -EINVAL;
+			goto bad_tid_conf;
+		}
+
+		ret = parse_tid_conf(rdev, attrs,
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
@@ -14742,6 +14857,13 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
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
index e853a4f..887cda2 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1299,4 +1299,16 @@ static inline int rdev_update_owe_info(struct cfg80211_registered_device *rdev,
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
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index d98ad2b..522da8d 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3458,6 +3458,23 @@
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
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
1.7.9.5

