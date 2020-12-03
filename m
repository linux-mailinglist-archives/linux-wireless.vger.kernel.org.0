Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271FE2CD3D9
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 11:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbgLCKif (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 05:38:35 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:17050 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387772AbgLCKif (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 05:38:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606991895; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5/Ah/iP7izPxEWpPi1v/BACfa9o2r7ZcYFo4qUpUHkY=; b=GCKg5bBc/DtDt5yDHtmE1p8QavSe4ZS//WEMhWnRG+YUYPqeUiT8V/WjV0XMnRZnW3svYVLQ
 DAcAKsKKQEUirFCqdjP1qgLVpxzUry+BM42+bF+coOTwTKODqi2Um4VgOTxhBFTA6RBt4LOu
 Ww0Jh1y45fjbJrk1/E/NXmOnzq0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fc8bff42571f1091af83a4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Dec 2020 10:37:40
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D16D0C43463; Thu,  3 Dec 2020 10:37:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD7E4C43462;
        Thu,  3 Dec 2020 10:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD7E4C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org
Subject: [PATCH v4 1/3] nl80211: add common API to configure SAR power limitations.
Date:   Thu,  3 Dec 2020 05:37:26 -0500
Message-Id: <20201203103728.3034-2-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203103728.3034-1-cjhuang@codeaurora.org>
References: <20201203103728.3034-1-cjhuang@codeaurora.org>
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
8c 00 00 00 08 00 01 00 00 00 00 00 38 00 2b 81
08 00 01 00 00 00 00 00 2c 00 02 80 14 00 00 80
08 00 02 00 00 00 00 00 08 00 01 00 38 00 00 00
14 00 01 80 08 00 02 00 01 00 00 00 08 00 01 00
48 00 00 00

NL80211_CMD_SET_SAR_SPECS:  0x8c
NL80211_ATTR_WIPHY:     0x01(phy idx is 0)
NL80211_ATTR_SAR_SPEC:  0x812b (NLA_NESTED)
NL80211_SAR_ATTR_TYPE:  0x00 (NL80211_SAR_TYPE_POWER)
NL80211_SAR_ATTR_SPECS: 0x8002 (NLA_NESTED)
freq range 0 power: 0x38 in 0.25dbm unit (14dbm)
freq range 1 power: 0x48 in 0.25dbm unit (18dbm)

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Abhishek Kumar <kuabhs@chromium.org>
---
v4:
- add "Reviewed-by:" tag

v3:
- check index duplicates. Return error if index duplicates.

v2:
- rebased on ToT
- fix spelling errors and some comment styles
- use switch-case to process sar specs
- put power_type sar spec to a sub function
- change power to s32 and index to u32
- add error check in nl80211_put_sar_specs
- add a new case in nl80211_send_wiphy to send sar specs

 include/net/cfg80211.h       |  51 ++++++++++++
 include/uapi/linux/nl80211.h | 102 ++++++++++++++++++++++++
 net/wireless/nl80211.c       | 185 +++++++++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  12 +++
 net/wireless/trace.h         |  19 +++++
 5 files changed, 369 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 472b72a..4f8265b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1736,6 +1736,54 @@ struct station_info {
 	u8 connected_to_as;
 };
 
+/**
+ * struct cfg80211_sar_sub_specs - sub specs limit
+ * @power: power limitation in 0.25dbm
+ * @freq_range_index: index the power limitation applies to
+ */
+struct cfg80211_sar_sub_specs {
+	s32 power;
+	u32 freq_range_index;
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
+	u32 num_sub_specs;
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
+	u32 num_freq_ranges;
+	const struct cfg80211_sar_freq_ranges *freq_ranges;
+};
+
 #if IS_ENABLED(CONFIG_CFG80211)
 /**
  * cfg80211_get_station - retrieve information about a given station
@@ -4258,6 +4306,7 @@ struct cfg80211_ops {
 				  struct cfg80211_tid_config *tid_conf);
 	int	(*reset_tid_config)(struct wiphy *wiphy, struct net_device *dev,
 				    const u8 *peer, u8 tids);
+	int	(*set_sar_specs)(struct wiphy *wiphy, struct cfg80211_sar_specs *sar);
 };
 
 /*
@@ -5026,6 +5075,8 @@ struct wiphy {
 
 	u8 max_data_retry_count;
 
+	const struct cfg80211_sar_capa *sar_capa;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e1e5b3d..9ad6b13 100644
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
@@ -2532,6 +2538,10 @@ enum nl80211_commands {
  *	derivation in WPA3-Personal networks which are using SAE authentication.
  *	This is a u8 attribute that encapsulates one of the values from
  *	&enum nl80211_sae_pwe_mechanism.
+ * @NL80211_ATTR_SAR_SPEC: SAR power limitation specification when
+ *	used with %NL80211_CMD_SET_SAR_SPECS. The message contains fields
+ *	of %nl80211_sar_attrs which specifies the sar type and related
+ *	sar specs. Sar specs contains array of %nl80211_sar_specs_attrs.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3023,6 +3033,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_CAPABILITY_MASK,
 
 	NL80211_ATTR_SAE_PWE,
+	NL80211_ATTR_SAR_SPEC,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -7155,4 +7166,95 @@ enum nl80211_sae_pwe_mechanism {
 	NL80211_SAE_PWE_HASH_TO_ELEMENT,
 	NL80211_SAE_PWE_BOTH,
 };
+
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
+ * enum nl80211_sar_attrs - Attributes for SAR spec
+ *
+ * @NL80211_SAR_ATTR_TYPE: the SAR type and it's defined in &enum nl80211_sar_type.
+ *
+ * @NL80211_SAR_ATTR_SPECS: Nested array of SAR power
+ *	limit specifications. Each specification contains a set
+ *	of %nl80211_sar_specs_attrs.
+ *
+ *	For SET operation, it contains array of NL80211_SAR_ATTR_SPECS_POWER
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
+ * enum nl80211_sar_specs_attrs - Attributes for SAR power limit specs
+ *
+ * @NL80211_SAR_ATTR_SPECS_POWER: Required (s32)value to specify the actual
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
+ *	have SAR limitations, and they are same as setting the
+ *	%NL80211_SAR_ATTR_SPECS_POWER to any unreasonable high value because any
+ *	value higher than regulatory allowed value just means SAR power limitation
+ *	is removed, but it's required to set at least one range. It's not allowed
+ *	to set duplicated range in one SET operation.
+ *
+ *	Every SET operation overwrites previous SET operation.
+ *
+ * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to specify the start
+ *	frequency of this range edge when registering SAR capability to wiphy. It's
+ *	not a channel center frequency. The unit is kHz.
+ *
+ * @NL80211_SAR_ATTR_SPECS_END_FREQ: Required (u32) value to specify the end frequency
+ *	of this range edge when registering SAR capability to wiphy. It's not a channel
+ *	center frequency. The unit is kHz.
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
index ceea9ee..144a291 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -399,6 +399,18 @@ nl80211_unsol_bcast_probe_resp_policy[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX +
 						       .len = IEEE80211_MAX_DATA_LEN }
 };
 
+static const struct nla_policy
+sar_specs_policy[NL80211_SAR_ATTR_SPECS_MAX + 1] = {
+	[NL80211_SAR_ATTR_SPECS_POWER] = { .type = NLA_S32 },
+	[NL80211_SAR_ATTR_SPECS_RANGE_INDEX] = {.type = NLA_U32 },
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
@@ -718,6 +730,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SAE_PWE] =
 		NLA_POLICY_RANGE(NLA_U8, NL80211_SAE_PWE_HUNT_AND_PECK,
 				 NL80211_SAE_PWE_BOTH),
+	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 };
 
 /* policy for the key attributes */
@@ -2095,6 +2108,56 @@ nl80211_put_tid_config_support(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
+		      struct sk_buff *msg)
+{
+	struct nlattr *sar_capa, *specs, *sub_freq_range;
+	u8 num_freq_ranges;
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
+		if (!sub_freq_range)
+			goto fail;
+
+		if (nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_START_FREQ,
+				rdev->wiphy.sar_capa->freq_ranges[i].start_freq))
+			goto fail;
+
+		if (nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_END_FREQ,
+				rdev->wiphy.sar_capa->freq_ranges[i].end_freq))
+			goto fail;
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
@@ -2344,6 +2407,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			CMD(set_multicast_to_unicast, SET_MULTICAST_TO_UNICAST);
 			CMD(update_connect_params, UPDATE_CONNECT_PARAMS);
 			CMD(update_ft_ies, UPDATE_FT_IES);
+			CMD(set_sar_specs, SET_SAR_SPECS);
 		}
 #undef CMD
 
@@ -2669,6 +2733,11 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 
 		if (nl80211_put_tid_config_support(rdev, msg))
 			goto nla_put_failure;
+		state->split_start++;
+		break;
+	case 16:
+		if (nl80211_put_sar_specs(rdev, msg))
+			goto nla_put_failure;
 
 		/* done */
 		state->split_start = 0;
@@ -14693,6 +14762,114 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	}
 }
 
+static int nl80211_set_sar_sub_specs(struct cfg80211_registered_device *rdev,
+				     struct cfg80211_sar_specs *sar_specs,
+				     struct nlattr *spec[], int index)
+{
+	u32 range_index, i;
+
+	if (!sar_specs || !spec)
+		return -EINVAL;
+
+	if (!spec[NL80211_SAR_ATTR_SPECS_POWER] ||
+	    !spec[NL80211_SAR_ATTR_SPECS_RANGE_INDEX])
+		return -EINVAL;
+
+	range_index = nla_get_u32(spec[NL80211_SAR_ATTR_SPECS_RANGE_INDEX]);
+
+	/* check if range_index exceeds num_freq_ranges */
+	if (range_index >= rdev->wiphy.sar_capa->num_freq_ranges)
+		return -EINVAL;
+
+	/* check if range_index duplicates */
+	for (i = 0; i < index; i++) {
+		if (sar_specs->sub_specs[i].freq_range_index == range_index)
+			return -EINVAL;
+	}
+
+	sar_specs->sub_specs[index].power =
+		nla_get_s32(spec[NL80211_SAR_ATTR_SPECS_POWER]);
+
+	sar_specs->sub_specs[index].freq_range_index = range_index;
+
+	return 0;
+}
+
+static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct nlattr *spec[NL80211_SAR_ATTR_SPECS_MAX + 1];
+	struct nlattr *tb[NL80211_SAR_ATTR_MAX + 1];
+	struct cfg80211_sar_specs *sar_spec;
+	enum nl80211_sar_type type;
+	struct nlattr *spec_list;
+	u32 specs;
+	int rem, err;
+
+	if (!rdev->wiphy.sar_capa || !rdev->ops->set_sar_specs)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_SAR_SPEC])
+		return -EINVAL;
+
+	nla_parse_nested(tb, NL80211_SAR_ATTR_MAX, info->attrs[NL80211_ATTR_SAR_SPEC],
+			 sar_policy, NULL);
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
+	if (specs > rdev->wiphy.sar_capa->num_freq_ranges)
+		return -EINVAL;
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
+		nla_parse(spec,
+			  NL80211_SAR_ATTR_SPECS_MAX,
+			  nla_data(spec_list),
+			  nla_len(spec_list),
+			  sar_specs_policy,
+			  NULL);
+
+		switch (type) {
+		case NL80211_SAR_TYPE_POWER:
+			if (nl80211_set_sar_sub_specs(rdev, sar_spec, spec, specs)) {
+				err = -EINVAL;
+				goto error;
+			}
+			break;
+
+		default:
+			err = -EINVAL;
+			goto error;
+		}
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
@@ -15554,6 +15731,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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

