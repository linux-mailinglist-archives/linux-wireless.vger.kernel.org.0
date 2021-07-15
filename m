Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4883C995F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhGOHK4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 03:10:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhGOHKz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 03:10:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626332882; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: To: From: Sender;
 bh=Cl2EFh73eAoxOOG41alMqUtv5sjLvpkiLLqvtRjsWto=; b=V8WbzD6rHk+PallssakHpNjzifhECiN5DRtmwz3SD7PZLDvptNmW08OsWk2L7ZX0GMB8aV6K
 11+E/inh9FTdS3eTpnb/SnfSutqCzdo5VbxKgHg/Cg7p0NZKYrOHtUFAIqqzpuDuMtjB9EGm
 Mb0rkb4v1ssU2HNzFpDZEZUYceI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60efdeca96a66e66b2881217 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Jul 2021 07:07:54
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D572C43217; Thu, 15 Jul 2021 07:07:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B72D4C4338A;
        Thu, 15 Jul 2021 07:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B72D4C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [PATCH v11 1/4] nl80211: MBSSID and EMA support in AP mode
Date:   Thu, 15 Jul 2021 00:07:42 -0700
Message-Id: <20210715070745.5033-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715070745.5033-1-alokad@codeaurora.org>
References: <20210715070745.5033-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

This commit adds new attributes to configure support for multiple BSSID
and advanced multi-BSSID advertisements (EMA) in AP mode.

- NL80211_ATTR_MBSSID_CONFIG used for per interface configuration.
- NL80211_ATTR_MBSSID_ELEMS used to passing MBSSID elements to be added in
beacons.

Memory for the elements is allocated dynamically. This change frees
the memory in existing functions which call nl80211_parse_beacon(),
a comment is added to indicate the new references to do the same.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v11: removed NL80211_MBSSID_CONFIG_ATTR_COUNT and
     NL80211_MBSSID_ELEMS_ATTR_COUNT, NL80211_EXT_FEATURE_MBSSID_AP,
     NL80211_EXT_FEATURE_EMA_AP.
     Cfg80211 passes passes pointer to the transitting interface
     to mac80211 instead of interface index.
     Renamed NL80211_MBSSID_CONFIG_ATTR_PARENT as
     NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX.
     
v10: Shorter variable names and more descriptive comments

 include/net/cfg80211.h       |  44 ++++++
 include/uapi/linux/nl80211.h |  76 +++++++++-
 net/wireless/nl80211.c       | 261 +++++++++++++++++++++++++++++------
 3 files changed, 341 insertions(+), 40 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 161cdf7df1a0..0d63c85a57ea 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1040,6 +1040,36 @@ struct cfg80211_crypto_settings {
 	enum nl80211_sae_pwe_mechanism sae_pwe;
 };
 
+/**
+ * struct cfg80211_mbssid_config - AP settings for multi bssid
+ *
+ * @tx_dev: pointer to the transmitted interface in the MBSSID set
+ * @index: index of this AP in the multi bssid group.
+ * @ema: set to true if the beacons should be sent out in EMA mode.
+ */
+struct cfg80211_mbssid_config {
+	struct wireless_dev *tx_dev;
+	u8 index;
+	bool ema;
+};
+
+/**
+ * struct cfg80211_mbssid_elems - Multiple BSSID elements
+ *
+ * @cnt: Number of elements in array %elems.
+ *
+ * @elem: Array of multiple BSSID element(s) to be added into Beacon frames.
+ * @elem.data: Data for multiple BSSID elements.
+ * @elem.len: Length of data.
+ */
+struct cfg80211_mbssid_elems {
+	u8 cnt;
+	struct {
+		u8 *data;
+		size_t len;
+	} elem[];
+};
+
 /**
  * struct cfg80211_beacon_data - beacon data
  * @head: head portion of beacon (before TIM IE)
@@ -1058,6 +1088,7 @@ struct cfg80211_crypto_settings {
  * @assocresp_ies_len: length of assocresp_ies in octets
  * @probe_resp_len: length of probe response template (@probe_resp)
  * @probe_resp: probe response template (AP mode only)
+ * @mbssid_ies: multiple BSSID elements
  * @ftm_responder: enable FTM responder functionality; -1 for no change
  *	(which also implies no change in LCI/civic location data)
  * @lci: Measurement Report element content, starting with Measurement Token
@@ -1075,6 +1106,7 @@ struct cfg80211_beacon_data {
 	const u8 *probe_resp;
 	const u8 *lci;
 	const u8 *civicloc;
+	struct cfg80211_mbssid_elems *mbssid_ies;
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
@@ -1189,6 +1221,7 @@ enum cfg80211_ap_settings_flags {
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @mbssid_config: AP settings for multiple bssid
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1221,6 +1254,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
+	struct cfg80211_mbssid_config mbssid_config;
 };
 
 /**
@@ -4955,6 +4989,13 @@ struct wiphy_iftype_akm_suites {
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
  * @sar_capa: SAR control capabilities
  * @rfkill: a pointer to the rfkill structure
+ *
+ * @mbssid_max_interfaces: maximum number of interfaces supported by the driver
+ *	in a multiple BSSID set. This field must be set to a non-zero value
+ *	by the driver to advertise MBSSID support.
+ * @mbssid_max_ema_profile_periodicity: maximum profile periodicity supported by
+ *	the driver. Setting this field to a non-zero value indicates that the
+ *	driver supports enhanced multi-BSSID advertisements (EMA AP).
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5099,6 +5140,9 @@ struct wiphy {
 
 	struct rfkill *rfkill;
 
+	u8 mbssid_max_interfaces;
+	u8 ema_max_profile_periodicity;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index db474994fa73..bed067957447 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -337,7 +337,10 @@
  * @NL80211_CMD_DEL_INTERFACE: Virtual interface was deleted, has attributes
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_WIPHY. Can also be sent from
  *	userspace to request deletion of a virtual interface, then requires
- *	attribute %NL80211_ATTR_IFINDEX.
+ *	attribute %NL80211_ATTR_IFINDEX. If multiple BSSID advertisements are
+ *	enabled using %NL80211_ATTR_MBSSID_CONFIG, %NL80211_ATTR_MBSSID_ELEMS,
+ *	and if this command is used for the transmitting interface, then all
+ *	the non-transmitting interfaces are deleted as well.
  *
  * @NL80211_CMD_GET_KEY: Get sequence counter information for a key specified
  *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC.
@@ -2560,6 +2563,18 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_MBSSID_CONFIG: Nested attribute for multiple BSSID
+ *	advertisements (MBSSID) parameters in AP mode.
+ *	Kernel uses this attribute to indicate the driver's support for MBSSID
+ *	and enhanced multi-BSSID advertisements (EMA AP) to the userspace.
+ *	Userspace should use this attribute to configure per interface MBSSID
+ *	parameters.
+ *	See &enum nl80211_mbssid_config_attributes for details.
+ *
+ * @NL80211_ATTR_MBSSID_ELEMS: Nested parameter to pass multiple BSSID elements.
+ *	Mandatory parameter for the transmitting interface to enable MBSSID.
+ *	Optional for the non-transmitting interfaces.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3057,6 +3072,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_MBSSID_CONFIG,
+	NL80211_ATTR_MBSSID_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7306,4 +7324,60 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_mbssid_config_attributes - multiple BSSID (MBSSID) and enhanced
+ * multi-BSSID advertisements (EMA) in AP mode.
+ * Kernel uses some of these attributes to advertise driver's support for
+ * MBSSID and EMA.
+ * Remaining attributes should be used by the userspace to configure the
+ * features.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES: Used by the kernel to advertise
+ *	the maximum number of MBSSID interfaces supported by the driver.
+ *	Driver should indicate MBSSID support by setting
+ *	wiphy->mbssid_max_interfaces to a value more than or equal to 2.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY: Used by the kernel
+ *	to advertise the maximum profile periodicity supported by the driver
+ *	if EMA is enabled. Driver should indicate EMA support to the userspace
+ *	by setting wiphy->mbssid_max_ema_profile_periodicity to
+ *	a non-zero value.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_INDEX: Mandatory parameter to pass the index of
+ *	this BSS (u8) in the multiple BSSID set.
+ *	Value must be set to 0 for the transmitting interface and non-zero for
+ *	all non-transmitting interfaces. The userspace will be responsible
+ *	for using unique indices for the interfaces.
+ *	Range: 0 to wiphy->mbssid_max_interfaces-1.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX: Mandatory parameter for
+ *	a non-transmitted profile which provides the interface index (u32) of
+ *	the transmitted profile. The value must match one of the interface
+ *	indices advertised by the kernel. Optional if the interface being set up
+ *	is the transmitting one, however, if provided then the value must match
+ *	the interface index of the same.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_EMA: Flag used to enable EMA AP feature.
+ *	Setting this flag is permitted only if the driver advertises EMA support
+ *	by setting wiphy->mbssid_max_ema_profile_periodicity to non-zero.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
+ */
+enum nl80211_mbssid_config_attributes {
+	__NL80211_MBSSID_CONFIG_ATTR_INVALID,
+
+	NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES,
+	NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY,
+	NL80211_MBSSID_CONFIG_ATTR_INDEX,
+	NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX,
+	NL80211_MBSSID_CONFIG_ATTR_EMA,
+
+	/* keep last */
+	__NL80211_MBSSID_CONFIG_ATTR_LAST,
+	NL80211_MBSSID_CONFIG_ATTR_MAX = __NL80211_MBSSID_CONFIG_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 50eb405b0690..0aff8745d5e3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -437,6 +437,16 @@ sar_policy[NL80211_SAR_ATTR_MAX + 1] = {
 	[NL80211_SAR_ATTR_SPECS] = NLA_POLICY_NESTED_ARRAY(sar_specs_policy),
 };
 
+static const struct nla_policy
+nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
+	[NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES] = NLA_POLICY_MIN(NLA_U8, 2),
+	[NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY] =
+						NLA_POLICY_MIN(NLA_U8, 1),
+	[NL80211_MBSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
+	[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX] = { .type = NLA_U32 },
+	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -759,6 +769,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_MBSSID_CONFIG] =
+				NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
+	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -2203,6 +2216,35 @@ nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
+static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
+{
+	struct nlattr *config;
+
+	if (!wiphy->mbssid_max_interfaces)
+		return 0;
+
+	config = nla_nest_start(msg, NL80211_ATTR_MBSSID_CONFIG);
+	if (!config)
+		return -ENOBUFS;
+
+	if (nla_put_u8(msg, NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES,
+		       wiphy->mbssid_max_interfaces))
+		goto fail;
+
+	if (wiphy->ema_max_profile_periodicity &&
+	    nla_put_u8(msg,
+		       NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY,
+		       wiphy->ema_max_profile_periodicity))
+		goto fail;
+
+	nla_nest_end(msg, config);
+	return 0;
+
+fail:
+	nla_nest_cancel(msg, config);
+	return -ENOBUFS;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2785,6 +2827,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_sar_specs(rdev, msg))
 			goto nla_put_failure;
 
+		if (nl80211_put_mbssid_support(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -4974,6 +5019,88 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
+				       struct net_device *dev,
+				       struct nlattr *attrs,
+				       struct cfg80211_mbssid_config *config,
+				       u8 num_elems)
+{
+	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
+	struct net_device *tx_dev = dev;
+	u32 tx_ifindex;
+
+	if (!wiphy->mbssid_max_interfaces)
+		return -EOPNOTSUPP;
+
+	if (nla_parse_nested(tb, NL80211_MBSSID_CONFIG_ATTR_MAX, attrs, NULL,
+			     NULL) ||
+	    !tb[NL80211_MBSSID_CONFIG_ATTR_INDEX])
+		return -EINVAL;
+
+	config->index = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_INDEX]);
+	if (config->index >= wiphy->mbssid_max_interfaces)
+		return -EINVAL;
+
+	/* MBSSID elements are mandatory for the transmitting interface */
+	if (!config->index && !num_elems)
+		return -EINVAL;
+
+	if (tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]) {
+		tx_ifindex =
+			nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]);
+
+		if (!config->index && tx_ifindex != dev->ifindex)
+			return -EINVAL;
+
+		tx_dev = __dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
+		if (!tx_dev || !tx_dev->ieee80211_ptr ||
+		    tx_dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP)
+			return -EINVAL;
+	} else if (config->index &&
+		   !tb[NL80211_MBSSID_CONFIG_ATTR_TRANSMITTING_IFINDEX]) {
+		return -EINVAL;
+	}
+
+	config->tx_dev = tx_dev->ieee80211_ptr;
+	config->ema = nla_get_flag(tb[NL80211_MBSSID_CONFIG_ATTR_EMA]);
+	if (config->ema) {
+		if (!wiphy->ema_max_profile_periodicity)
+			return -EOPNOTSUPP;
+
+		if (num_elems > wiphy->ema_max_profile_periodicity)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct cfg80211_mbssid_elems *
+nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
+{
+	struct nlattr *nl_elems;
+	struct cfg80211_mbssid_elems *elems = NULL;
+	int rem_elems;
+	u8 i = 0, num_elems = 0;
+
+	if (!wiphy->mbssid_max_interfaces)
+		return NULL;
+
+	nla_for_each_nested(nl_elems, attrs, rem_elems)
+		num_elems++;
+
+	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
+	if (!elems)
+		return NULL;
+
+	nla_for_each_nested(nl_elems, attrs, rem_elems) {
+		elems->elem[i].data = nla_data(nl_elems);
+		elems->elem[i].len = nla_len(nl_elems);
+		i++;
+	}
+	elems->cnt = num_elems;
+	return elems;
+}
+
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn)
@@ -5054,6 +5181,16 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_MBSSID_ELEMS]) {
+		bcn->mbssid_ies =
+			nl80211_parse_mbssid_elems(&rdev->wiphy,
+						   attrs[NL80211_ATTR_MBSSID_ELEMS]);
+		if (!bcn->mbssid_ies)
+			return -EINVAL;
+
+		/* Caller must free bcn->mbssid_ies in case of error */
+	}
+
 	return 0;
 }
 
@@ -5339,7 +5476,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
 	if (err)
-		return err;
+		goto out;
 
 	params.beacon_interval =
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
@@ -5349,7 +5486,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params.beacon_interval);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * In theory, some of these attributes should be required here
@@ -5362,8 +5499,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params.ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
 		params.ssid_len =
 			nla_len(info->attrs[NL80211_ATTR_SSID]);
-		if (params.ssid_len == 0)
-			return -EINVAL;
+		if (params.ssid_len == 0) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_HIDDEN_SSID])
@@ -5376,57 +5515,74 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params.auth_type = nla_get_u32(
 			info->attrs[NL80211_ATTR_AUTH_TYPE]);
 		if (!nl80211_valid_auth_type(rdev, params.auth_type,
-					     NL80211_CMD_START_AP))
-			return -EINVAL;
+					     NL80211_CMD_START_AP)) {
+			err = -EINVAL;
+			goto out;
+		}
 	} else
 		params.auth_type = NL80211_AUTHTYPE_AUTOMATIC;
 
 	err = nl80211_crypto_settings(rdev, info, &params.crypto,
 				      NL80211_MAX_NR_CIPHER_SUITES);
 	if (err)
-		return err;
+		goto out;
 
 	if (info->attrs[NL80211_ATTR_INACTIVITY_TIMEOUT]) {
-		if (!(rdev->wiphy.features & NL80211_FEATURE_INACTIVITY_TIMER))
-			return -EOPNOTSUPP;
+		if (!(rdev->wiphy.features &
+		      NL80211_FEATURE_INACTIVITY_TIMER)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
 		params.inactivity_timeout = nla_get_u16(
 			info->attrs[NL80211_ATTR_INACTIVITY_TIMEOUT]);
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_CTWINDOW]) {
-		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
-			return -EINVAL;
+		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
+			err = -EINVAL;
+			goto out;
+		}
 		params.p2p_ctwindow =
 			nla_get_u8(info->attrs[NL80211_ATTR_P2P_CTWINDOW]);
 		if (params.p2p_ctwindow != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN))
-			return -EINVAL;
+		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN)) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_OPPPS]) {
 		u8 tmp;
 
-		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
-			return -EINVAL;
+		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
+			err = -EINVAL;
+			goto out;
+		}
 		tmp = nla_get_u8(info->attrs[NL80211_ATTR_P2P_OPPPS]);
 		params.p2p_opp_ps = tmp;
 		if (params.p2p_opp_ps != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS))
-			return -EINVAL;
+		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS)) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info, &params.chandef);
 		if (err)
-			return err;
+			goto out;
 	} else if (wdev->preset_chandef.chan) {
 		params.chandef = wdev->preset_chandef;
-	} else if (!nl80211_get_ap_channel(rdev, &params))
-		return -EINVAL;
+	} else if (!nl80211_get_ap_channel(rdev, &params)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params.chandef,
-					   wdev->iftype))
-		return -EINVAL;
+					   wdev->iftype)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
@@ -5434,12 +5590,12 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 						    &params.beacon_rate,
 						    dev, false);
 		if (err)
-			return err;
+			goto out;
 
 		err = validate_beacon_tx_rate(rdev, params.chandef.chan->band,
 					      &params.beacon_rate);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_SMPS_MODE]) {
@@ -5450,29 +5606,38 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			break;
 		case NL80211_SMPS_STATIC:
 			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_STATIC_SMPS))
-				return -EINVAL;
+			      NL80211_FEATURE_STATIC_SMPS)) {
+				err = -EINVAL;
+				goto out;
+			}
 			break;
 		case NL80211_SMPS_DYNAMIC:
 			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_DYNAMIC_SMPS))
-				return -EINVAL;
+			      NL80211_FEATURE_DYNAMIC_SMPS)) {
+				err = -EINVAL;
+				goto out;
+			}
 			break;
 		default:
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 	} else {
 		params.smps_mode = NL80211_SMPS_OFF;
 	}
 
 	params.pbss = nla_get_flag(info->attrs[NL80211_ATTR_PBSS]);
-	if (params.pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ])
-		return -EOPNOTSUPP;
+	if (params.pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ]) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (info->attrs[NL80211_ATTR_ACL_POLICY]) {
 		params.acl = parse_acl_data(&rdev->wiphy, info);
-		if (IS_ERR(params.acl))
-			return PTR_ERR(params.acl);
+		if (IS_ERR(params.acl)) {
+			err = PTR_ERR(params.acl);
+			goto out;
+		}
 	}
 
 	params.twt_responder =
@@ -5510,6 +5675,17 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_MBSSID_CONFIG]) {
+		err = nl80211_parse_mbssid_config(&rdev->wiphy, dev,
+						  info->attrs[NL80211_ATTR_MBSSID_CONFIG],
+						  &params.mbssid_config,
+						  (params.beacon.mbssid_ies ?
+						   params.beacon.mbssid_ies->cnt :
+						   0));
+		if (err)
+			goto out;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
@@ -5530,8 +5706,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.acl);
-
+	if (!IS_ERR(params.acl))
+		kfree(params.acl);
+	kfree(params.beacon.mbssid_ies);
 	return err;
 }
 
@@ -5555,12 +5732,14 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params);
 	if (err)
-		return err;
+		goto out;
 
 	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, &params);
 	wdev_unlock(wdev);
 
+out:
+	kfree(params.mbssid_ies);
 	return err;
 }
 
@@ -9240,12 +9419,14 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_after);
 	if (err)
-		return err;
+		goto free;
 
 	csa_attrs = kcalloc(NL80211_ATTR_MAX + 1, sizeof(*csa_attrs),
 			    GFP_KERNEL);
-	if (!csa_attrs)
-		return -ENOMEM;
+	if (!csa_attrs) {
+		err = -ENOMEM;
+		goto free;
+	}
 
 	err = nla_parse_nested_deprecated(csa_attrs, NL80211_ATTR_MAX,
 					  info->attrs[NL80211_ATTR_CSA_IES],
@@ -9363,6 +9544,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 free:
+	kfree(params.beacon_after.mbssid_ies);
+	kfree(params.beacon_csa.mbssid_ies);
 	kfree(csa_attrs);
 	return err;
 }
-- 
2.31.1

