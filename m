Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A99B273A34
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgIVFhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:10 -0400
Received: from z5.mailgun.us ([104.130.96.5]:36929 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgIVFhK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600753028; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8BYKYO1OmnFwaCknxyyBgx4vRXE3rfGFmABh0dDm84Y=; b=tr0M/eaxcihzNCgiUOAz8rS8M3rI8IPoQHL9rFuzmkm58NEB9iNi4NQpMx+mOJlJcfvpx7Jw
 YBxSNnf2dlHZIkxLRrEnVwiwBfneBEIRUjoz0Cau4F0DHTSa3MveArfnuqS/c73DWNAy755L
 iS6CKhTPQJtVb4cqdXGuOd2FaXM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f698d83ea858627d56506d6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 05:37:07
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E09C8C433FF; Tue, 22 Sep 2020 05:37:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-station.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABDD1C433CA;
        Tue, 22 Sep 2020 05:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABDD1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org
Subject: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
Date:   Tue, 22 Sep 2020 13:36:56 +0800
Message-Id: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
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
8c 00 00 00 08 00 03 00 15 00 00 00 38 00 26 81
08 00 01 00 00 00 00 00 2c 00 02 80 14 00 01 80
05 00 02 00 00 00 00 00 05 00 01 00 38 00 00 00
14 00 02 80 05 00 02 00 01 00 00 00 05 00 01 00
48 00 00 00

NL80211_CMD_SET_SAR_SPECS:  0x8c
NL80211_ATTR_SAR_SPEC:  0x8126 (NLA_NESTED)
NL80211_SAR_ATTR_TYPE:  0x00 (NL80211_SAR_TYPE_POWER)
NL80211_SAR_ATTR_SPECS: 0x8002 (NLA_NESTED)
freq range 0 power: 0x38 in 0.25dbm unit (14dbm)
freq range 1 power: 0x48 in 0.25dbm unit (18dbm)

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 include/net/cfg80211.h       |  52 +++++++++++++
 include/net/mac80211.h       |   2 +
 include/uapi/linux/nl80211.h |  86 +++++++++++++++++++++
 net/mac80211/cfg.c           |  12 +++
 net/wireless/nl80211.c       | 173 +++++++++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  12 +++
 net/wireless/trace.h         |  19 +++++
 7 files changed, 356 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c9bce9b..94f09dd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1663,6 +1663,55 @@ struct station_info {
 	u8 connected_to_as;
 };
 
+/**
+ * struct cfg80211_sar_sub_specs - sub specs limit
+ * @power: value in 0.25dbm
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
+	struct cfg80211_sar_sub_specs *sub_specs;
+};
+
+
+/**
+ * @struct cfg80211_sar_chan_ranges - sar frequency ranges
+ * @index: the index of this range. It's used to specify
+ *	the frequency range when setting SAR power limitation
+ * @start_freq:  start channel frequency in kHZ. For example,
+ *	2.4G channel 1 is represented as 2412000
+ * @end_freq:    end channel frequency in kHZ
+ */
+struct cfg80211_sar_freq_ranges {
+	u8 index;
+	u32 start_freq;
+	u32 end_freq;
+};
+
+/**
+ * struct cfg80211_sar_capa - sar limit capability
+ * @type: it's set via power in 0.25dbm or other types
+ * @num_freq_ranges: number of frequency ranges
+ * @chan_ranges: memory to hold the channel ranges.
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
@@ -4153,6 +4202,7 @@ struct cfg80211_ops {
 				  struct cfg80211_tid_config *tid_conf);
 	int	(*reset_tid_config)(struct wiphy *wiphy, struct net_device *dev,
 				    const u8 *peer, u8 tids);
+	int	(*set_sar_specs)(struct wiphy *wiphy, struct cfg80211_sar_specs *sar);
 };
 
 /*
@@ -4919,6 +4969,8 @@ struct wiphy {
 
 	u8 max_data_retry_count;
 
+	const struct cfg80211_sar_capa *sar_capa;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ec148b3..df758ee 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4125,6 +4125,8 @@ struct ieee80211_ops {
 	int (*reset_tid_config)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta, u8 tids);
+	int (*set_sar_specs)(struct ieee80211_hw *hw,
+			     const struct cfg80211_sar_specs *sar);
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0584e0d..2dcfed4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1177,6 +1177,9 @@
  *	includes the contents of the frame. %NL80211_ATTR_ACK flag is included
  *	if the recipient acknowledged the frame.
  *
+ * @NL80211_CMD_SET_SAR_SPECS: SAR power limitation configuration is
+ *	passed using %NL80211_ATTR_SAR_SPEC.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1407,6 +1410,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
 
+	NL80211_CMD_SET_SAR_SPECS,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2513,6 +2518,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
  *
+ * @NL80211_ATTR_SAR_SPEC: SAR power limitation specification when
+ *	used with %NL80211_CMD_SET_SAR_SPECS. It contains array of
+ *	%nl80211_sar_specs_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2995,6 +3004,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_SAR_SPEC,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7004,4 +7015,79 @@ enum nl80211_iftype_akm_attributes {
 	NL80211_IFTYPE_AKM_ATTR_MAX = __NL80211_IFTYPE_AKM_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_sar_type - type of SAR specs
+ *
+ * @NL80211_SAR_TYPE_POWER: the value is specified in 0.25 dbm
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
+ * @NL80211_SAR_ATTR_TYPE: Type of SAR: power or index
+ *
+ * @NL80211_SAR_ATTR_SPECS: Nested array of SAR power
+ *	limit specifications. Each specification contains a set
+ *      of %nl80211_sar_specs_attrs
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
+#define NL80211_SAR_ALL_FREQ_RNAGES	0xff
+#define NUM_MAX_NL80211_SAR_FREQ_RANGES 0xfe
+
+/**
+ * nl80211_sar_specs_attrs - Attributes for SAR power limit specs
+ *
+ * @NL80211_SAR_ATTR_SPECS_POWER: Required (u32)value to specify the actual
+ *	power limit value in units of 0.25 dBm if type is
+ *	NL80211_SAR_TYPE_POWER. (i.e., a value of 44 represents 11 dBm)
+ *
+ * @NL80211_SAR_ATTR_SPECS_FREQ_RANGES_INDEX: optional (u32) value to specify the
+ *	index of exported freq ranges table. If this attribute is not present, then
+ *	the power is applied to all freq ranges, i.e, all bands
+ *
+ * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to specify the start
+ *	frequency of this range to register SAR capability to wihpy and the unit
+ *	is kHZ
+ *
+ * @NL80211_SAR_ATTR_SPECS_END_FREQ: Required (u32) value to specify the end frequency
+ *	of this range to register SAR capability to wiphy and the unit is kHZ
+ *
+ * @__NL80211_SAR_ATTR_SPECS_LAST: Internal
+ * @NL80211_SAR_ATTR_SPECS_MAX: highest sar specs attribute
+ */
+enum nl80211_sar_specs_attrs {
+	__NL80211_SAR_ATTR_SPECS_INVALID,
+
+	NL80211_SAR_ATTR_SPECS_POWER,
+	NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX,
+	NL80211_SAR_ATTR_SPECS_START_FREQ,
+	NL80211_SAR_ATTR_SPECS_END_FREQ,
+
+	__NL80211_SAR_ATTR_SPECS_LAST,
+	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4e39e3..cc74322 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3993,6 +3993,17 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 	return ret;
 }
 
+static int ieee80211_set_sar_specs(struct wiphy *wiphy,
+				   struct cfg80211_sar_specs *sar)
+{
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	if (!local->ops->set_sar_specs)
+		return -EOPNOTSUPP;
+
+	return local->ops->set_sar_specs(&local->hw, sar);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4096,4 +4107,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.probe_mesh_link = ieee80211_probe_mesh_link,
 	.set_tid_config = ieee80211_set_tid_config,
 	.reset_tid_config = ieee80211_reset_tid_config,
+	.set_sar_specs = ieee80211_set_sar_specs,
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 52a35e7..9318b3a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -367,6 +367,19 @@ nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
+static const struct nla_policy
+sar_specs_policy[NL80211_SAR_ATTR_SPECS_MAX + 1] = {
+		[NL80211_SAR_ATTR_SPECS_POWER] = { .type = NLA_U8 },
+		[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX] =
+			NLA_POLICY_MAX(NLA_U8, NUM_MAX_NL80211_SAR_FREQ_RANGES),
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
@@ -675,6 +688,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SCAN_FREQ_KHZ] = { .type = NLA_NESTED },
 	[NL80211_ATTR_HE_6GHZ_CAPABILITY] =
 		NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_he_6ghz_capa)),
+	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 };
 
 /* policy for the key attributes */
@@ -1856,6 +1870,8 @@ static int nl80211_add_commands_unsplit(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	CMD(set_sar_specs, SET_SAR_SPECS);
+
 	return i;
  nla_put_failure:
 	return -ENOBUFS;
@@ -2034,6 +2050,55 @@ nl80211_put_tid_config_support(struct cfg80211_registered_device *rdev,
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
+	if (nla_put_u16(msg, NL80211_SAR_ATTR_TYPE, rdev->wiphy.sar_capa->type))
+		goto fail;
+
+	specs = nla_nest_start_noflag(msg, NL80211_SAR_ATTR_SPECS);
+	if (!specs)
+		goto fail;
+
+	/* report supported freq_ranges */
+	for (i = 0; i < num_freq_ranges; i++) {
+		sub_freq_range = nla_nest_start_noflag(msg, i + 1);
+
+		nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_START_FREQ,
+			    rdev->wiphy.sar_capa->freq_ranges[i].start_freq);
+
+		nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_END_FREQ,
+			    rdev->wiphy.sar_capa->freq_ranges[i].end_freq);
+
+		nla_put_u8(msg, NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX,
+			   rdev->wiphy.sar_capa->freq_ranges[i].index);
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
@@ -2598,6 +2663,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_tid_config_support(rdev, msg))
 			goto nla_put_failure;
 
+		if (nl80211_put_sar_specs(rdev, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -14473,6 +14541,103 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	}
 }
 
+static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct nlattr *spec[NL80211_SAR_ATTR_SPECS_MAX + 1];
+	struct nlattr *tb[NL80211_SAR_ATTR_MAX + 1];
+	struct cfg80211_sar_specs *sar_spec;
+	u8 type, power, index, specs;
+	struct nlattr *spec_list;
+	int rem, err;
+
+	if (!rdev->wiphy.sar_capa)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_SAR_SPEC])
+		return -EINVAL;
+
+	nla_parse_nested(tb, NL80211_SAR_ATTR_MAX, info->attrs[NL80211_ATTR_SAR_SPEC],
+			 sar_policy, info->extack);
+
+	if (!tb[NL80211_SAR_ATTR_TYPE])
+		return -EINVAL;
+
+	type = nla_get_u32(tb[NL80211_SAR_ATTR_TYPE]);
+
+	if (!tb[NL80211_SAR_ATTR_SPECS])
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
+	sar_spec->sub_specs = (struct cfg80211_sar_sub_specs *)
+			((char *)sar_spec + sizeof(*sar_spec));
+	specs = 0;
+	sar_spec->type = type;
+
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
+		/* for power type, power value must be presented */
+		if (!spec[NL80211_SAR_ATTR_SPECS_POWER] &&
+		    type == NL80211_SAR_TYPE_POWER) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		power = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_POWER]);
+		sar_spec->sub_specs[specs].power = power;
+
+		/* if NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX isn't present,
+		 * then the power applies to all bands. But it's only valid
+		 * for the first entry.
+		 */
+		if (!spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]) {
+			if (specs) {
+				err = -EINVAL;
+				goto error;
+			} else {
+				sar_spec->sub_specs[specs].freq_range_index =
+					NL80211_SAR_ALL_FREQ_RNAGES;
+				specs++;
+				break;
+			}
+		}
+
+		index = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]);
+		sar_spec->sub_specs[specs].freq_range_index = index;
+		specs++;
+	}
+
+	sar_spec->num_sub_specs = specs;
+
+	rdev->cur_cmd_info = info;
+	if (rdev->ops->set_sar_specs)
+		err = rdev_set_sar_specs(rdev, sar_spec);
+	else
+		err = -EOPNOTSUPP;
+	rdev->cur_cmd_info = NULL;
+error:
+	kfree(sar_spec);
+	return err;
+}
+
 static const struct genl_ops nl80211_ops[] = {
 	{
 		.cmd = NL80211_CMD_GET_WIPHY,
@@ -15331,6 +15496,14 @@ static const struct genl_ops nl80211_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_NETDEV |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_SET_SAR_SPECS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_sar_specs,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
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

