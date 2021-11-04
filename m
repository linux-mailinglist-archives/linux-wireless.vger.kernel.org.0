Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD46544583D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Nov 2021 18:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhKDR0p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Nov 2021 13:26:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62320 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234974AbhKDR0e (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Nov 2021 13:26:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636046636; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1YiPpl4J7vIbbdhFQnykPuh2To04wA5uo1959Oq7Vlw=; b=qSimEce9S3uMl3yeSyWlWOHhiGqCjVJ4FqrWwvuyhFu4UzMMCKvxB8ai97PGQxmfPmULHfLR
 01fqCam4lyGgShxE+FJoprEgroODkp1eFvLw4RSLWk6WLUxcuCb2Y9tHeIFCTljnl/nk4Q73
 Yq5OXBK9SxsGRqNbqDciBDXyprQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61841727aea46563ff46446c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Nov 2021 17:23:51
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D374C4360D; Thu,  4 Nov 2021 17:23:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4274C4338F;
        Thu,  4 Nov 2021 17:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C4274C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH v3] nl80211: Add HE UL MU settings used in UL Trigger
Date:   Thu,  4 Nov 2021 10:23:40 -0700
Message-Id: <1636046620-9663-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds nl80211 definitions, policies and parsing code required
to pass HE uplink MU fixed rate settings utiliized in UL trigger.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
v3:
 - restructured flow of passing uplink MU transmission settings. No
   longer utilizing existing bitrate structures and attributes, new
   ones are created for uplink MU transmission.
 - added HE LTF/GI/LDPC/STBC along with HE fixed rate setting for
   uplink MU transmissions, which are part of the UL Trigger.
 - modified commit message from "nl80211: Add HE UL MU fixed rate
   setting" in order to include all the rate settings related to UL
   Trigger.
---
 include/net/cfg80211.h       | 17 ++++++++
 include/uapi/linux/nl80211.h | 45 +++++++++++++++++++++
 net/wireless/nl80211.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 12 ++++++
 net/wireless/trace.h         | 18 +++++++++
 5 files changed, 188 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 362da9f6bf39..a05ecd067e08 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -697,6 +697,18 @@ struct cfg80211_bitrate_mask {
 	} control[NUM_NL80211_BANDS];
 };
 
+/*
+ * cfg80211_ul_bitrate_mask - masks for MU uplink bitrate control
+ */
+struct cfg80211_ul_bitrate_mask {
+	struct {
+		u16 he_ul_mcs[NL80211_HE_NSS_MAX];
+		enum nl80211_he_gi he_ul_gi;
+		enum nl80211_he_ltf he_ul_ltf;
+		bool he_ul_ldpc;
+		bool he_ul_stbc;
+	} control[NUM_NL80211_BANDS];
+};
 
 /**
  * struct cfg80211_tid_cfg - TID specific configuration
@@ -4233,6 +4245,11 @@ struct cfg80211_ops {
 				    const u8 *peer,
 				    const struct cfg80211_bitrate_mask *mask);
 
+	int	(*set_ul_bitrate_mask)(struct wiphy *wiphy,
+				       struct net_device *dev,
+				       const u8 *peer,
+				       const struct cfg80211_ul_bitrate_mask *mask);
+
 	int	(*dump_survey)(struct wiphy *wiphy, struct net_device *netdev,
 			int idx, struct survey_info *info);
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e734826792f..288e53903498 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1232,6 +1232,10 @@
  *	&NL80211_ATTR_FILS_NONCES - for FILS Nonces
  *		(STA Nonce 16 bytes followed by AP Nonce 16 bytes)
  *
+ * @NL80211_CMD_SET_UL_BITRATE_MASK: Set the mask of rates to be used in MU
+ *	uplink rate selection. %NL80211_ATTR_IFINDEX is used to specify the
+ *	interface and @NL80211_ATTR_UL_RATES the set of allowed rates.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1474,6 +1478,7 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_FILS_AAD,
 
+	NL80211_CMD_SET_UL_BITRATE_MASK,
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2646,6 +2651,13 @@ enum nl80211_commands {
  *	switching on a different channel during CAC detection on the selected
  *	radar channel.
  *
+ * @NL80211_ATTR_UL_RATES: Nested set of attributes
+ *	(enum nl80211_ul_rate_attributes) describing MU uplink rates per
+ *	specified band.	The enum nl80211_band value is used as the index
+ *	nla_type() of the nested data. This attribute is used with
+ *	%NL80211_CMD_SET_UL_BITRATE_MASK and it must specify just a single
+ *	bitrate, which is to be used for MU uplink transmission.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3154,6 +3166,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_RADAR_OFFCHAN,
 
+	NL80211_ATTR_UL_RATES,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4981,6 +4994,38 @@ enum nl80211_txrate_gi {
 };
 
 /**
+ * enum nl80211_ul_rate_attributes - MU uplink rate set attributes
+ * @NL80211_UL_RATE_HE: HE MU UL MCS rates for MU uplink traffic,
+ *	see &struct nl80211_ul_rate_he
+ * @NL80211_UL_RATE_HE_GI: configure HE UL GI, 0.8us, 1.6us and 3.2us.
+ * @NL80211_UL_RATE_HE_LTF: configure HE UL LTF, 1XLTF, 2XLTF and 4XLTF.
+ * @NL80211_UL_RATE_HE_LDPC: configure HE UL LDPC, enable and disable.
+ * @NL80211_UL_RATE_HE_STBC: configure HE UL STBC, enable and disable.
+ * @__NL80211_TXRATE_AFTER_LAST: internal
+ * @NL80211_TXRATE_MAX: highest TX rate attribute
+ */
+enum nl80211_ul_rate_attributes {
+	NL80211_UL_RATE_HE,
+	NL80211_UL_RATE_HE_GI,
+	NL80211_UL_RATE_HE_LTF,
+	NL80211_UL_RATE_HE_LDPC,
+	NL80211_UL_RATE_HE_STBC,
+
+	/* keep last */
+	__NL80211_UL_RATE_AFTER_LAST,
+	NL80211_UL_RATE_MAX = __NL80211_UL_RATE_AFTER_LAST - 1
+};
+
+/**
+ * struct nl80211_ul_rate_he - Uplink HE MCS/NSS rate bitmap for MU
+ *	transmission.
+ * @mcs: MCS bitmap table for each NSS (array index 0 for 1 stream, etc.)
+ */
+struct nl80211_ul_rate_he {
+	__u16 mcs[NL80211_HE_NSS_MAX];
+};
+
+/**
  * enum nl80211_band - Frequency band
  * @NL80211_BAND_2GHZ: 2.4 GHz ISM band
  * @NL80211_BAND_5GHZ: around 5 GHz band (4.9 - 5.7 GHz)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 25ee16558dfa..daaa6c98ea1e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -386,6 +386,18 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 						   NL80211_RATE_INFO_HE_4XLTF),
 };
 
+static const struct nla_policy nl80211_ul_rate_attr_policy[NL80211_UL_RATE_MAX + 1] = {
+	[NL80211_UL_RATE_HE] = NLA_POLICY_EXACT_LEN(sizeof(struct nl80211_ul_rate_he)),
+	[NL80211_UL_RATE_HE_GI] =  NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_HE_GI_0_8,
+						   NL80211_RATE_INFO_HE_GI_3_2),
+	[NL80211_UL_RATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
+						   NL80211_RATE_INFO_HE_1XLTF,
+						   NL80211_RATE_INFO_HE_4XLTF),
+	[NL80211_UL_RATE_HE_LDPC] = { .type = NLA_FLAG },
+	[NL80211_UL_RATE_HE_STBC] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy
 nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_TID_CONFIG_ATTR_VIF_SUPP] = { .type = NLA_U64 },
@@ -4954,6 +4966,63 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	return 0;
 }
 
+static int nl80211_parse_ul_bitrate_mask(struct genl_info *info,
+					 struct nlattr *attrs[],
+					 enum nl80211_attrs attr,
+					 struct cfg80211_ul_bitrate_mask *mask,
+					 struct net_device *dev,
+					 bool default_all_enabled)
+{
+	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	int rem;
+	struct nlattr *tx_rates;
+	struct ieee80211_supported_band *sband;
+
+	memset(mask, 0, sizeof(*mask));
+
+	/* The nested attribute uses enum nl80211_band as the index. This maps
+	 * directly to the enum nl80211_band values used in cfg80211.
+	 */
+	nla_for_each_nested(tx_rates, attrs[attr], rem) {
+		enum nl80211_band band = nla_type(tx_rates);
+		int err;
+
+		if (band < 0 || band >= NUM_NL80211_BANDS)
+			return -EINVAL;
+		sband = rdev->wiphy.bands[band];
+		if (!sband)
+			return -EINVAL;
+		err = nla_parse_nested_deprecated(tb, NL80211_UL_RATE_MAX,
+						  tx_rates,
+						  nl80211_ul_rate_attr_policy,
+						  info->extack);
+		if (err)
+			return err;
+		if (tb[NL80211_UL_RATE_HE] &&
+		    !he_set_mcs_mask(info, wdev, sband,
+				     nla_data(tb[NL80211_UL_RATE_HE]),
+				     mask->control[band].he_ul_mcs))
+			return -EINVAL;
+
+		if (tb[NL80211_UL_RATE_HE_GI])
+			mask->control[band].he_ul_gi =
+				nla_get_u8(tb[NL80211_UL_RATE_HE_GI]);
+		if (tb[NL80211_UL_RATE_HE_LTF])
+			mask->control[band].he_ul_ltf =
+				nla_get_u8(tb[NL80211_UL_RATE_HE_LTF]);
+		if (tb[NL80211_UL_RATE_HE_LDPC])
+			mask->control[band].he_ul_ldpc =
+				!nla_get_flag(tb[NL80211_UL_RATE_HE_LDPC]);
+		if (tb[NL80211_UL_RATE_HE_STBC])
+			mask->control[band].he_ul_stbc =
+				!nla_get_flag(tb[NL80211_UL_RATE_HE_STBC]);
+	}
+
+	return 0;
+}
+
 static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 				   enum nl80211_band band,
 				   struct cfg80211_bitrate_mask *beacon_rate)
@@ -11546,6 +11615,26 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 	return rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
 }
 
+static int nl80211_set_ul_bitrate_mask(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct cfg80211_ul_bitrate_mask mask;
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	int err;
+
+	if (!rdev->ops->set_bitrate_mask)
+		return -EOPNOTSUPP;
+
+	err = nl80211_parse_ul_bitrate_mask(info, info->attrs,
+					    NL80211_ATTR_UL_RATES, &mask,
+					    dev, true);
+	if (err)
+		return err;
+
+	return rdev_set_ul_bitrate_mask(rdev, dev, NULL, &mask);
+}
+
 static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -15740,6 +15829,13 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
+		.cmd = NL80211_CMD_SET_UL_BITRATE_MASK,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_ul_bitrate_mask,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
+	},
+	{
 		.cmd = NL80211_CMD_REGISTER_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_register_mgmt,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 8672b3ef99e4..418cb37c99a2 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -661,6 +661,18 @@ rdev_set_bitrate_mask(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_ul_bitrate_mask(struct cfg80211_registered_device *rdev,
+			 struct net_device *dev, const u8 *peer,
+			 const struct cfg80211_ul_bitrate_mask *mask)
+{
+	int ret;
+	trace_rdev_set_ul_bitrate_mask(&rdev->wiphy, dev, peer, mask);
+	ret = rdev->ops->set_ul_bitrate_mask(&rdev->wiphy, dev, peer, mask);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 static inline int rdev_dump_survey(struct cfg80211_registered_device *rdev,
 				   struct net_device *netdev, int idx,
 				   struct survey_info *info)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 0b27eaa14a18..eb9a6e2641a1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1635,6 +1635,24 @@ TRACE_EVENT(rdev_set_bitrate_mask,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
 );
 
+TRACE_EVENT(rdev_set_ul_bitrate_mask,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 const u8 *peer, const struct cfg80211_ul_bitrate_mask *mask),
+	TP_ARGS(wiphy, netdev, peer, mask),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		MAC_ENTRY(peer)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		MAC_ASSIGN(peer, peer);
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
+);
+
 TRACE_EVENT(rdev_update_mgmt_frame_registrations,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 struct mgmt_frame_regs *upd),
-- 
2.7.4

