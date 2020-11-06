Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03C32A93AB
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKFKHX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:07:23 -0500
Received: from z5.mailgun.us ([104.130.96.5]:44563 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgKFKHW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:07:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604657241; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UJizg9qX2//t/3M5Mup2W5E2uLuCa036x9b1nlpGg34=; b=ATrlPcoyN7BD2iqxM0QWBujUaNNeFBDfzZ25QBT7K45PoIIajY5aTXkhGL3QnU7qLLoL2PhP
 sO+GIy8gXXqY4uI4Df2u7uGX038dnubJFw3R1PeHFJTrvH2/zBN5xbb0kznISUYI1/Y6PcSh
 7teeu82AohnCIC8kPvFi1taWfAo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fa520581f7506a997171a39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 10:07:20
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECEF1C43382; Fri,  6 Nov 2020 10:07:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3D15C433FE;
        Fri,  6 Nov 2020 10:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3D15C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org, kuabhs@google.com
Subject: [PATCH 1/3] nl80211: add common API to configure SAR power limitations.
Date:   Fri,  6 Nov 2020 05:07:06 -0500
Message-Id: <20201106100708.4609-2-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106100708.4609-1-cjhuang@codeaurora.org>
References: <20201106100708.4609-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NL80211_CMD_SET_SAR_SPECS is added to configure SAR from
user space. NL80211_ATTR_SAR_SPEC is used to pass the SAR
power specification when used with NL80211_CMD_SET_SAR_SPECS.

Wireless driver needs to register SAR type, supported frequency
ranges to wiphy, so user space can query it. The index in
frequency range is used to specify which sub band the power
limitation applies to. The SAR type is for compatibility, so later
other SAR mechanism can be implemented without breaking the user
space SAR applications.

Normal process is user space quries the SAR capability, and
gets the index of supported frequency ranges and associates the
power limitation with this index and sends to kernel.

Here is an example of message send to kernel:
8c 00 00 00 08 00 01 00 00 00 00 00 38 00 26 81
08 00 01 00 00 00 00 00 2c 00 02 80 14 00 00 80
05 00 02 00 00 00 00 00 05 00 01 00 38 00 00 00
14 00 01 80 05 00 02 00 01 00 00 00 05 00 01 00
48 00 00 00

NL80211_CMD_SET_SAR_SPECS:  0x8c
NL80211_ATTR_WIPHY:     0x01(phy idx is 0)
NL80211_ATTR_SAR_SPEC:  0x8126 (NLA_NESTED)
NL80211_SAR_ATTR_TYPE:  0x00 (NL80211_SAR_TYPE_POWER)
NL80211_SAR_ATTR_SPECS: 0x8002 (NLA_NESTED)
freq range 0 power: 0x38 in 0.25dbm unit (14dbm)
freq range 1 power: 0x48 in 0.25dbm unit (18dbm)

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 include/net/cfg80211.h       |  51 +++++++++++++++
 include/uapi/linux/nl80211.h | 101 +++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 150 +++++++++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  12 ++++
 net/wireless/trace.h         |  19 ++++++
 5 files changed, 333 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c9bce9b..07e44d5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1663,6 +1663,54 @@ struct station_info {
 	u8 connected_to_as;
 };
 
+/**
+ * struct cfg80211_sar_sub_specs - sub specs limit
+ * @power: power limitation in 0.25dbm
+ * @freq_range_index: index the power limitation applies to
+ */
+struct cfg80211_sar_sub_specs {
+	u8 power;
+	u8 freq_range_index;
+};
+
+/**
+ * struct cfg80211_sar_specs - sar limit specs
+ * @type: it's set with power in 0.25dbm or other types
+ * @num_sub_specs: number of sar sub specs
+ * @sub_specs: memory to hold the sar sub specs
+ */
+struct cfg80211_sar_specs {
+	enum nl80211_sar_type type;
+	u16 num_sub_specs;
+	struct cfg80211_sar_sub_specs sub_specs[];
+};
+
+
+/**
+ * @struct cfg80211_sar_chan_ranges - sar frequency ranges
+ * @start_freq:  start range edge frequency
+ * @end_freq:    end range edge frequency
+ */
+struct cfg80211_sar_freq_ranges {
+	u32 start_freq;
+	u32 end_freq;
+};
+
+/**
+ * struct cfg80211_sar_capa - sar limit capability
+ * @type: it's set via power in 0.25dbm or other types
+ * @num_freq_ranges: number of frequency ranges
+ * @freq_ranges: memory to hold the freq ranges.
+ *
+ * Note: WLAN driver may append new ranges or split an existing
+ * range to small ones and then append them.
+ */
+struct cfg80211_sar_capa {
+	enum nl80211_sar_type type;
+	u8 num_freq_ranges;
+	const struct cfg80211_sar_freq_ranges *freq_ranges;
+};
+
 #if IS_ENABLED(CONFIG_CFG80211)
 /**
  * cfg80211_get_station - retrieve information about a given station
@@ -4153,6 +4201,7 @@ struct cfg80211_ops {
 				  struct cfg80211_tid_config *tid_conf);
 	int	(*reset_tid_config)(struct wiphy *wiphy, struct net_device *dev,
 				    const u8 *peer, u8 tids);
+	int	(*set_sar_specs)(struct wiphy *wiphy, struct cfg80211_sar_specs *sar);
 };
 
 /*
@@ -4919,6 +4968,8 @@ struct wiphy {
 
 	u8 max_data_retry_count;
 
+	const struct cfg80211_sar_capa *sar_capa;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0584e0d..a8fd18a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1177,6 +1177,10 @@
  *	includes the contents of the frame. %NL80211_ATTR_ACK flag is included
  *	if the recipient acknowledged the frame.
  *
+ * @NL80211_CMD_SET_SAR_SPECS: SAR power limitation configuration is
+ *	passed using %NL80211_ATTR_SAR_SPEC. %NL80211_ATTR_WIPHY is used to
+ *	specify the wiphy index to be applied to.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1407,6 +1411,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
 
+	NL80211_CMD_SET_SAR_SPECS,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2513,6 +2519,11 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
  *
+ * @NL80211_ATTR_SAR_SPEC: SAR power limitation specification when
+ *	used with %NL80211_CMD_SET_SAR_SPECS. The message contains fileds
+ *	of %nl80211_sar_attrs which specifies the sar type and related
+ *	sar specs. Sar specs contains array of %nl80211_sar_specs_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2995,6 +3006,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_SAR_SPEC,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7004,4 +7017,92 @@ enum nl80211_iftype_akm_attributes {
 	NL80211_IFTYPE_AKM_ATTR_MAX = __NL80211_IFTYPE_AKM_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_sar_type - type of SAR specs
+ *
+ * @NL80211_SAR_TYPE_POWER: power limitation specified in 0.25dbm unit
+ *
+ */
+enum nl80211_sar_type {
+	NL80211_SAR_TYPE_POWER,
+
+	/* add new type here */
+
+	/* Keep last */
+	NUM_NL80211_SAR_TYPE,
+};
+
+/**
+ * nl80211_sar_attrs - Attributes for SAR spec
+ *
+ * @NL80211_SAR_ATTR_TYPE: the SAR type and it's defined in %nl80211_sar_type.
+ *
+ * @NL80211_SAR_ATTR_SPECS: Nested array of SAR power
+ *	limit specifications. Each specification contains a set
+ *      of %nl80211_sar_specs_attrs.
+ *
+ *      For SET operation, it contains array of NL80211_SAR_ATTR_SPECS_POWER
+ *	and NL80211_SAR_ATTR_SPECS_RANGE_INDEX.
+ *
+ *	For sar_capa dump, it contains array of NL80211_SAR_ATTR_SPECS_START_FREQ
+ *	and NL80211_SAR_ATTR_SPECS_END_FREQ.
+ *
+ * @__NL80211_SAR_ATTR_LAST: Internal
+ * @NL80211_SAR_ATTR_MAX: highest sar attribute
+ *
+ * These attributes are used with %NL80211_CMD_SET_SAR_SPEC
+ */
+enum nl80211_sar_attrs {
+	__NL80211_SAR_ATTR_INVALID,
+
+	NL80211_SAR_ATTR_TYPE,
+	NL80211_SAR_ATTR_SPECS,
+
+	__NL80211_SAR_ATTR_LAST,
+	NL80211_SAR_ATTR_MAX = __NL80211_SAR_ATTR_LAST - 1,
+};
+
+/**
+ * nl80211_sar_specs_attrs - Attributes for SAR power limit specs
+ *
+ * @NL80211_SAR_ATTR_SPECS_POWER: Required (u32)value to specify the actual
+ *	power limit value in units of 0.25 dBm if type is
+ *	NL80211_SAR_TYPE_POWER. (i.e., a value of 44 represents 11 dBm).
+ *	0 means userspace doesn't have SAR limitation on this associated range.
+ *
+ * @NL80211_SAR_ATTR_SPECS_RANGE_INDEX: Required (u32) value to specify the
+ *	index of exported freq range table and the associated power limitation
+ *	is applied to this range.
+ *
+ *	Userspace isn't required to set all the ranges advertised by WLAN driver,
+ *	and userspace can skip some certain ranges. These skipped ranges don't
+ *	have SAR limitations, and these are same as setting the
+ *	%NL80211_SAR_ATTR_SPECS_POWER to 0. But it's required to set at least one range,
+ *	no matter the power limiation is 0 or not.
+ *
+ *	Every SET operation overwrites previous SET operation.
+ *
+ * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to specify the start
+ *	frequency of this range edge when registering SAR capability to wiphy. It's
+ *	not a channel center frequency. The unit is KHz.
+ *
+ * @NL80211_SAR_ATTR_SPECS_END_FREQ: Required (u32) value to specify the end frequency
+ *	of this range edge when registering SAR capability to wiphy. It's not a channel
+ *	center frequency. The unit is KHz.
+ *
+ * @__NL80211_SAR_ATTR_SPECS_LAST: Internal
+ * @NL80211_SAR_ATTR_SPECS_MAX: highest sar specs attribute
+ */
+enum nl80211_sar_specs_attrs {
+	__NL80211_SAR_ATTR_SPECS_INVALID,
+
+	NL80211_SAR_ATTR_SPECS_POWER,
+	NL80211_SAR_ATTR_SPECS_RANGE_INDEX,
+	NL80211_SAR_ATTR_SPECS_START_FREQ,
+	NL80211_SAR_ATTR_SPECS_END_FREQ,
+
+	__NL80211_SAR_ATTR_SPECS_LAST,
+	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 262b04d..c278e0d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -367,6 +367,18 @@ nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
+static const struct nla_policy
+sar_specs_policy[NL80211_SAR_ATTR_SPECS_MAX + 1] = {
+	[NL80211_SAR_ATTR_SPECS_POWER] = { .type = NLA_U8 },
+	[NL80211_SAR_ATTR_SPECS_RANGE_INDEX] = {.type = NLA_U8 },
+};
+
+static const struct nla_policy
+sar_policy[NL80211_SAR_ATTR_MAX + 1] = {
+	[NL80211_SAR_ATTR_TYPE] = NLA_POLICY_MAX(NLA_U32, NUM_NL80211_SAR_TYPE),
+	[NL80211_SAR_ATTR_SPECS] = NLA_POLICY_NESTED_ARRAY(sar_specs_policy),
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -675,6 +687,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SCAN_FREQ_KHZ] = { .type = NLA_NESTED },
 	[NL80211_ATTR_HE_6GHZ_CAPABILITY] =
 		NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_he_6ghz_capa)),
+	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 };
 
 /* policy for the key attributes */
@@ -2034,6 +2047,52 @@ nl80211_put_tid_config_support(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
+		      struct sk_buff *msg)
+{
+	struct nlattr *sar_capa, *specs, *sub_freq_range;
+	u8  num_freq_ranges;
+	int i;
+
+	if (!rdev->wiphy.sar_capa)
+		return 0;
+
+	num_freq_ranges = rdev->wiphy.sar_capa->num_freq_ranges;
+
+	sar_capa = nla_nest_start(msg, NL80211_ATTR_SAR_SPEC);
+	if (!sar_capa)
+		return -ENOSPC;
+
+	if (nla_put_u32(msg, NL80211_SAR_ATTR_TYPE, rdev->wiphy.sar_capa->type))
+		goto fail;
+
+	specs = nla_nest_start(msg, NL80211_SAR_ATTR_SPECS);
+	if (!specs)
+		goto fail;
+
+	/* report supported freq_ranges */
+	for (i = 0; i < num_freq_ranges; i++) {
+		sub_freq_range = nla_nest_start(msg, i + 1);
+
+		nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_START_FREQ,
+			    rdev->wiphy.sar_capa->freq_ranges[i].start_freq);
+
+		nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_END_FREQ,
+			    rdev->wiphy.sar_capa->freq_ranges[i].end_freq);
+
+		nla_nest_end(msg, sub_freq_range);
+	}
+
+	nla_nest_end(msg, specs);
+	nla_nest_end(msg, sar_capa);
+
+	return 0;
+fail:
+	nla_nest_cancel(msg, sar_capa);
+	return -ENOBUFS;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2284,6 +2343,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			CMD(set_multicast_to_unicast, SET_MULTICAST_TO_UNICAST);
 			CMD(update_connect_params, UPDATE_CONNECT_PARAMS);
 			CMD(update_ft_ies, UPDATE_FT_IES);
+			CMD(set_sar_specs, SET_SAR_SPECS);
 		}
 #undef CMD
 
@@ -2597,6 +2657,11 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 
 		if (nl80211_put_tid_config_support(rdev, msg))
 			goto nla_put_failure;
+		state->split_start++;
+		break;
+	case 16:
+		if (nl80211_put_sar_specs(rdev, msg))
+			goto nla_put_failure;
 
 		/* done */
 		state->split_start = 0;
@@ -14477,6 +14542,83 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	}
 }
 
+static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct nlattr *spec[NL80211_SAR_ATTR_SPECS_MAX + 1];
+	struct nlattr *tb[NL80211_SAR_ATTR_MAX + 1];
+	struct cfg80211_sar_specs *sar_spec;
+	enum nl80211_sar_type type;
+	struct nlattr *spec_list;
+	u8 power, index, specs;
+	int rem, err;
+
+	if (!rdev->wiphy.sar_capa || !rdev->ops->set_sar_specs)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_SAR_SPEC])
+		return -EINVAL;
+
+	nla_parse_nested(tb, NL80211_SAR_ATTR_MAX, info->attrs[NL80211_ATTR_SAR_SPEC],
+			 sar_policy, info->extack);
+
+	if (!tb[NL80211_SAR_ATTR_TYPE] || !tb[NL80211_SAR_ATTR_SPECS])
+		return -EINVAL;
+
+	type = nla_get_u32(tb[NL80211_SAR_ATTR_TYPE]);
+	if (type != rdev->wiphy.sar_capa->type)
+		return -EINVAL;
+
+	specs = 0;
+	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem)
+		specs++;
+
+	sar_spec = kzalloc(sizeof(*sar_spec) +
+			   specs * sizeof(struct cfg80211_sar_sub_specs),
+			   GFP_KERNEL);
+	if (!sar_spec)
+		return -ENOMEM;
+
+	sar_spec->type = type;
+	specs = 0;
+	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
+		if (nla_parse(spec,
+			      NL80211_SAR_ATTR_SPECS_MAX,
+			      nla_data(spec_list),
+			      nla_len(spec_list),
+			      sar_specs_policy,
+			      NULL)) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		/* for power type, power value and index must be presented */
+		if ((!spec[NL80211_SAR_ATTR_SPECS_POWER] ||
+		     !spec[NL80211_SAR_ATTR_SPECS_RANGE_INDEX]) &&
+		    type == NL80211_SAR_TYPE_POWER) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		power = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_POWER]);
+		sar_spec->sub_specs[specs].power = power;
+
+		index = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_RANGE_INDEX]);
+		sar_spec->sub_specs[specs].freq_range_index = index;
+
+		specs++;
+	}
+
+	sar_spec->num_sub_specs = specs;
+
+	rdev->cur_cmd_info = info;
+	err = rdev_set_sar_specs(rdev, sar_spec);
+	rdev->cur_cmd_info = NULL;
+error:
+	kfree(sar_spec);
+	return err;
+}
+
 static const struct genl_ops nl80211_ops[] = {
 	{
 		.cmd = NL80211_CMD_GET_WIPHY,
@@ -15335,6 +15477,14 @@ static const struct genl_ops nl80211_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_SET_SAR_SPECS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_sar_specs,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY |
+				  NL80211_FLAG_NEED_RTNL,
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 950d574..d9931c5 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1356,4 +1356,16 @@ static inline int rdev_reset_tid_config(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_set_sar_specs(struct cfg80211_registered_device *rdev,
+				     struct cfg80211_sar_specs *sar)
+{
+	int ret;
+
+	trace_rdev_set_sar_specs(&rdev->wiphy, sar);
+	ret = rdev->ops->set_sar_specs(&rdev->wiphy, sar);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 6e218a0..116be64 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3547,6 +3547,25 @@ TRACE_EVENT(rdev_reset_tid_config,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT ", tids: 0x%x",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->tids)
 );
+
+TRACE_EVENT(rdev_set_sar_specs,
+	TP_PROTO(struct wiphy *wiphy, struct cfg80211_sar_specs *sar),
+	TP_ARGS(wiphy, sar),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(u16, type)
+		__field(u16, num)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->type = sar->type;
+		__entry->num = sar->num_sub_specs;
+
+	),
+	TP_printk(WIPHY_PR_FMT ", Set type:%d, num_specs:%d",
+		  WIPHY_PR_ARG, __entry->type, __entry->num)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.7.4

