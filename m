Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67DE36B988
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbhDZS7C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 14:59:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14346 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbhDZS7A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 14:59:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619463498; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dL2JyoTUSP8gWe9+2pkxkDpRMhumZ+hnxK8zqOfFlFE=; b=qDQxPpnqmXPQeqa1M23WTjtTZ4AMhRjH9mo26oC6mwR8SF1M3JbTtqmTyG4it5ep+qI3Uqy1
 EcbFpVkjXyhSm0hg8ncRCcx3gG3g6z0WOEolp9ijlBTCTKbPlaY/DnZmI4tPwKzae5dOMCIc
 bzh+K0Dlon2TM8vLdoHcXuIkTT0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60870d43febcffa80fffe4d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 18:58:11
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0159C43217; Mon, 26 Apr 2021 18:58:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF6A0C43460;
        Mon, 26 Apr 2021 18:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF6A0C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 1/4] nl80211: multiple bssid and EMA support in AP mode
Date:   Mon, 26 Apr 2021 11:57:53 -0700
Message-Id: <20210426185756.10924-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426185756.10924-1-alokad@codeaurora.org>
References: <20210426185756.10924-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

This commit adds new attributes to configure support for multiple BSSID
and advanced multi-BSSID advertisements (EMA) in AP mode.

New nested attributes:
(1) NL80211_ATTR_MBSSID_CONFIG: Per interface settings.
(2) NL80211_ATTR_MBSSID_ELEMS: MBSSID elements to be added in beacons.
Both are required from the userspace for successful configuration.

Configuration options:
(1) NL80211_MBSSID_CONFIG_ATTR_PARENT: Index of the transmitting interface
	as advertised by the kernel
(2) NL80211_MBSSID_CONFIG_ATTR_COUNT: Total number of interfaces in the set
(3) NL80211_MBSSID_CONFIG_ATTR_INDEX: Index of the interfaces getting set
	up in MBSSID set. Range: 1 to NL80211_MBSSID_CONFIG_ATTR_COUNT-1.
(4) NL80211_MBSSID_CONFIG_ATTR_EMA: Set to 1 if enhanced multi-BSSID
	advertisements should be enabled.

Elements data:
(1) NL80211_MBSSID_ELEMS_ATTR_COUNT: Number of MBSSID elements
(2) NL80211_MBSSID_ELEMS_ATTR_DATA: Elements data. If EMA is enabled, these
	elements will be added in separate beacon templates.

Memory for the elements is allocated dynamically. While this change frees
the memory in existing functions which call nl80211_parse_beacon(),
a comment is added to indicate the new references to do the same.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v10: Shorter variable names and more descriptive comments

 include/net/cfg80211.h       |  51 +++++++
 include/uapi/linux/nl80211.h | 101 ++++++++++++-
 net/wireless/nl80211.c       | 280 ++++++++++++++++++++++++++++++-----
 3 files changed, 392 insertions(+), 40 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5224f885a99a..8709a4b8d944 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1033,6 +1033,38 @@ struct cfg80211_crypto_settings {
 	enum nl80211_sae_pwe_mechanism sae_pwe;
 };
 
+/**
+ * struct cfg80211_mbssid_config - AP settings for multi bssid
+ *
+ * @parent: interface index of the transmitted profile in the MBSSID set
+ * @index: index of this AP in the multi bssid group.
+ * @count: the total number of multi bssid peer APs.
+ * @ema: Shall the beacons be sent out in EMA mode.
+ */
+struct cfg80211_mbssid_config {
+	u32 parent;
+	u8 index;
+	u8 count;
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
@@ -1051,6 +1083,7 @@ struct cfg80211_crypto_settings {
  * @assocresp_ies_len: length of assocresp_ies in octets
  * @probe_resp_len: length of probe response template (@probe_resp)
  * @probe_resp: probe response template (AP mode only)
+ * @mbssid: multiple BSSID elements
  * @ftm_responder: enable FTM responder functionality; -1 for no change
  *	(which also implies no change in LCI/civic location data)
  * @lci: Measurement Report element content, starting with Measurement Token
@@ -1068,6 +1101,7 @@ struct cfg80211_beacon_data {
 	const u8 *probe_resp;
 	const u8 *lci;
 	const u8 *civicloc;
+	struct cfg80211_mbssid_elems *mbssid;
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
@@ -1182,6 +1216,7 @@ enum cfg80211_ap_settings_flags {
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @mbssid: AP settings for multiple bssid
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1214,6 +1249,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
+	struct cfg80211_mbssid_config mbssid;
 };
 
 /**
@@ -4945,6 +4981,16 @@ struct wiphy_iftype_akm_suites {
  *	configuration through the %NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
  * @sar_capa: SAR control capabilities
+ *
+ * @mbssid: Describes driver's multiple BSSID configuration support
+ * @mbssid.max_interfaces: maximum number of interfaces supported by the driver
+ *	in a multiple BSSID set that can ben configured using
+ *	%NL80211_MBSSID_CONFIG_ATTR_COUNT.
+ *	Kernel supports only one MBSSID per wiphy.
+ * @mbssid.max_periodicity: maximum profile periodicity supported by the driver
+ *	that can be configured using %NL80211_MBSSID_ELEMS_ATTR_COUNT.
+ *	This value is used only when enhanced multi-BSSID advertisements feature
+ *	is enabled through %NL80211_MBSSID_CONFIG_ATTR_EMA flag.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5087,6 +5133,11 @@ struct wiphy {
 
 	const struct cfg80211_sar_capa *sar_capa;
 
+	struct {
+		u8 max_interfaces;
+		u8 max_periodicity;
+	} mbssid;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f962c06e9818..e047393edeb1 100644
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
@@ -2560,6 +2563,21 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_MBSSID_CONFIG: Nested parameter to configure multiple BSSID
+ *	advertisements. It is also used to advertise the maximum number of
+ *	interfaces supported by the driver when multiple BSSID is enabled.
+ *	This attribute and %NL80211_ATTR_MBSSID_ELEMS are both required for
+ *	configuration. Current support is only for AP mode and drivers must
+ *	set NL80211_EXT_FEATURE_MBSSID_AP for this attribute to be used.
+ *	See &enum nl80211_mbssid_config_attributes for details.
+ *
+ * @NL80211_ATTR_MBSSID_ELEMS: Nested parameter to pass multiple BSSID elements
+ *	data. It is also used to advertise the maximum profile periodicity
+ *	supported by the driver when enhanced multi-BSSID advertisements (EMA)
+ *	are enabled. This attribute and %NL80211_ATTR_MBSSID_CONFIG are both
+ *	required for configuration. Current support is only for AP mode.
+ *	See &enum nl80211_mbssid_elems_attributes for details.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3057,6 +3075,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_MBSSID_CONFIG,
+	NL80211_ATTR_MBSSID_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5950,6 +5971,10 @@ enum nl80211_feature_flags {
  *      frame protection for all management frames exchanged during the
  *      negotiation and range measurement procedure.
  *
+ * @NL80211_EXT_FEATURE_MBSSID_AP: Device supports multiple BSSID advertisement
+ * @NL80211_EXT_FEATURE_EMA_AP: Device supports enhanced multiple BSSID
+ *	advertisements (EMA).
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6014,6 +6039,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SECURE_LTF,
 	NL80211_EXT_FEATURE_SECURE_RTT,
 	NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE,
+	NL80211_EXT_FEATURE_MBSSID_AP,
+	NL80211_EXT_FEATURE_EMA_AP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -7299,4 +7326,76 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_mbssid_config_attributes - Attributes to configure/advertise
+ *	multiple BSSID and enhanced multi-BSSID advertisements in AP mode.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_PARENT: For a non-transmitted BSSID, this
+ *	attribute provides the interface index (u32) of the transmitted profile.
+ *	Must match one of the interface indices advertised by the kernel.
+ *	Mandatory parameter for non-transmitting interfaces, ignored for the
+ *	transmitting interface.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_COUNT: Total number of BSSs (u8) in the
+ *	multiple BSSID set. Mandatory attribute with minimum value of 1.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_INDEX: The index of this BSS (u8) in the
+ *	multiple BSSID set. Mandatory parameter for non-transmitting interfaces,
+ *	ignored for the transmitting interface.
+ *	Range: 1 to %NL80211_MBSSID_CONFIG_ATTR_COUNT-1.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_EMA: Userspace and the drivers should use this
+ *	flag to indicate if enhanced multi-BSSID advertisements (EMA AP) feature
+ *	is supported/enabled. When set, beacons are generated as per EMA rules,
+ *	see %nl80211_mbssid_elems_attributes for details. Drivers must set
+ *	NL80211_EXT_FEATURE_EMA_AP for this flag to be used.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
+ */
+enum nl80211_mbssid_config_attributes {
+	__NL80211_MBSSID_CONFIG_ATTR_INVALID,
+
+	NL80211_MBSSID_CONFIG_ATTR_PARENT,
+	NL80211_MBSSID_CONFIG_ATTR_COUNT,
+	NL80211_MBSSID_CONFIG_ATTR_INDEX,
+	NL80211_MBSSID_CONFIG_ATTR_EMA,
+
+	/* keep last */
+	__NL80211_MBSSID_CONFIG_ATTR_LAST,
+	NL80211_MBSSID_CONFIG_ATTR_MAX = __NL80211_MBSSID_CONFIG_ATTR_LAST - 1,
+};
+
+/**
+ * enum nl80211_mbssid_elems_attributes - Attributes used to pass multiple BSSID
+ *	elements data. Current support is only for AP mode.
+ *	If enhanced multi-BSSID advertisements (EMA) are enabled with flag
+ *	%NL80211_MBSSID_CONFIG_ATTR_EMA, elements provided through this
+ *	attribute are split into multiple beacons. Otherwise all elements will
+ *	be included in every beacon for non-EMA AP.
+ *
+ * @__NL80211_MBSSID_ELEMS_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MBSSID_ELEMS_ATTR_COUNT: Number of multiple BSSID elements (u8).
+ *	This attribute is also used to advertise the maximum profile periodicity
+ *	supported by the driver if EMA is enabled.
+ *
+ * @NL80211_MBSSID_ELEMS_ATTR_DATA: Array of multiple BSSID elements.
+ *
+ * @__NL80211_MBSSID_ELEMS_ATTR_LAST: Internal
+ * @NL80211_MBSSID_ELEMS_ATTR_MAX: highest attribute
+ */
+enum nl80211_mbssid_elems_attributes {
+	__NL80211_MBSSID_ELEMS_ATTR_INVALID,
+
+	NL80211_MBSSID_ELEMS_ATTR_COUNT,
+	NL80211_MBSSID_ELEMS_ATTR_DATA,
+
+	/* keep last */
+	__NL80211_MBSSID_ELEMS_ATTR_LAST,
+	NL80211_MBSSID_ELEMS_ATTR_MAX = __NL80211_MBSSID_ELEMS_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7e811a3b0987..68cd33033488 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -437,6 +437,20 @@ sar_policy[NL80211_SAR_ATTR_MAX + 1] = {
 	[NL80211_SAR_ATTR_SPECS] = NLA_POLICY_NESTED_ARRAY(sar_specs_policy),
 };
 
+static const struct nla_policy
+nl80211_mbssid_elems_policy[NL80211_MBSSID_ELEMS_ATTR_MAX + 1] = {
+	[NL80211_MBSSID_ELEMS_ATTR_COUNT] = { .type = NLA_U8 },
+	[NL80211_MBSSID_ELEMS_ATTR_DATA] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy
+nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
+	[NL80211_MBSSID_CONFIG_ATTR_PARENT] = { .type = NLA_U32 },
+	[NL80211_MBSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
+	[NL80211_MBSSID_CONFIG_ATTR_COUNT] = { .type = NLA_U8 },
+	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -759,6 +773,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_MBSSID_CONFIG] =
+		NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
+	[NL80211_ATTR_MBSSID_ELEMS] =
+		NLA_POLICY_NESTED(nl80211_mbssid_elems_policy),
 };
 
 /* policy for the key attributes */
@@ -2198,6 +2216,48 @@ nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
+static int nl80211_put_mbssid_support(struct wiphy *wiphy,
+				      struct sk_buff *msg)
+{
+	struct nlattr *config = NULL, *elems = NULL;
+
+	if (!wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_MBSSID_AP))
+		return 0;
+
+	if (wiphy->mbssid.max_interfaces) {
+		config = nla_nest_start(msg, NL80211_ATTR_MBSSID_CONFIG);
+		if (!config)
+			goto fail;
+
+		if (nla_put_u8(msg, NL80211_MBSSID_CONFIG_ATTR_COUNT,
+			       wiphy->mbssid.max_interfaces))
+			goto fail;
+
+		nla_nest_end(msg, config);
+	}
+
+	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_EMA_AP) &&
+	    wiphy->mbssid.max_periodicity) {
+		elems = nla_nest_start(msg, NL80211_ATTR_MBSSID_ELEMS);
+		if (!elems)
+			goto fail;
+
+		if (nla_put_u8(msg, NL80211_MBSSID_ELEMS_ATTR_COUNT,
+			       wiphy->mbssid.max_periodicity))
+			goto fail;
+
+		nla_nest_end(msg, elems);
+	}
+	return 0;
+
+fail:
+	if (elems)
+		nla_nest_cancel(msg, elems);
+	if (config)
+		nla_nest_cancel(msg, config);
+	return -ENOBUFS;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2780,6 +2840,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_sar_specs(rdev, msg))
 			goto nla_put_failure;
 
+		if (nl80211_put_mbssid_support(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -4958,6 +5021,92 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
+				       struct net_device *dev,
+				       struct nlattr *attrs, u8 num_elems,
+				       struct cfg80211_mbssid_config *config)
+{
+	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
+	struct net_device *parent;
+
+	if (!wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_MBSSID_AP))
+		return -EOPNOTSUPP;
+
+	if (nla_parse_nested(tb, NL80211_MBSSID_CONFIG_ATTR_MAX, attrs, NULL,
+			     NULL) || !tb[NL80211_MBSSID_CONFIG_ATTR_COUNT])
+		return -EINVAL;
+
+	config->ema = nla_get_flag(tb[NL80211_MBSSID_CONFIG_ATTR_EMA]);
+	if (config->ema) {
+		if (!wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_EMA_AP))
+			return -EOPNOTSUPP;
+
+		/* nl80211_parse_mbssid_elems() sets this value */
+		if (!num_elems || (wiphy->mbssid.max_periodicity &&
+				   num_elems > wiphy->mbssid.max_periodicity))
+			return -EINVAL;
+	}
+
+	config->count = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_COUNT]);
+	if (!config->count || (wiphy->mbssid.max_interfaces &&
+			       config->count > wiphy->mbssid.max_interfaces))
+		return -EINVAL;
+
+	if (tb[NL80211_MBSSID_CONFIG_ATTR_PARENT]) {
+		config->parent = nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_PARENT]);
+		parent = __dev_get_by_index(wiphy_net(wiphy), config->parent);
+		if (!parent || !parent->ieee80211_ptr)
+			return -EINVAL;
+
+		if (parent == dev)
+			config->parent = 0;
+	}
+
+	if (tb[NL80211_MBSSID_CONFIG_ATTR_INDEX] && config->parent) {
+		config->index = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_INDEX]);
+		if (!config->index || config->index >= config->count)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct cfg80211_mbssid_elems *
+nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
+{
+	struct nlattr *nl_elems, *tb[NL80211_MBSSID_ELEMS_ATTR_MAX + 1];
+	struct cfg80211_mbssid_elems *elems = NULL;
+	int rem_elems;
+	u8 i = 0, num_elems;
+
+	if (!wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_MBSSID_AP))
+		return NULL;
+
+	if (nla_parse_nested(tb, NL80211_MBSSID_ELEMS_ATTR_MAX, attrs, NULL,
+			     NULL) ||
+	    !tb[NL80211_MBSSID_ELEMS_ATTR_COUNT] ||
+	    !tb[NL80211_MBSSID_ELEMS_ATTR_DATA])
+		return NULL;
+
+	num_elems = nla_get_u8(tb[NL80211_MBSSID_ELEMS_ATTR_COUNT]);
+	if (!num_elems)
+		return NULL;
+
+	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
+	if (!elems)
+		return NULL;
+
+	elems->cnt = num_elems;
+	nla_for_each_nested(nl_elems, tb[NL80211_MBSSID_ELEMS_ATTR_DATA],
+			    rem_elems) {
+		elems->elem[i].data = nla_data(nl_elems);
+		elems->elem[i].len = nla_len(nl_elems);
+		i++;
+	}
+
+	return elems;
+}
+
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn)
@@ -5038,6 +5187,15 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_MBSSID_ELEMS]) {
+		bcn->mbssid = nl80211_parse_mbssid_elems(&rdev->wiphy,
+							 attrs[NL80211_ATTR_MBSSID_ELEMS]);
+		if (!bcn->mbssid)
+			return -EINVAL;
+
+		/* Caller must free bcn->mbssid in case of error */
+	}
+
 	return 0;
 }
 
@@ -5323,7 +5481,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
 	if (err)
-		return err;
+		goto out;
 
 	params.beacon_interval =
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
@@ -5333,7 +5491,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params.beacon_interval);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * In theory, some of these attributes should be required here
@@ -5346,8 +5504,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5360,57 +5520,74 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5418,12 +5595,12 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5434,29 +5611,38 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5494,6 +5680,15 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_MBSSID_CONFIG]) {
+		err = nl80211_parse_mbssid_config(&rdev->wiphy, dev,
+						  info->attrs[NL80211_ATTR_MBSSID_CONFIG],
+						  params.beacon.mbssid->cnt,
+						  &params.mbssid);
+		if (err)
+			goto out;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
@@ -5514,8 +5709,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.acl);
-
+	if (!IS_ERR(params.acl))
+		kfree(params.acl);
+	kfree(params.beacon.mbssid);
 	return err;
 }
 
@@ -5539,12 +5735,14 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params);
 	if (err)
-		return err;
+		goto out;
 
 	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, &params);
 	wdev_unlock(wdev);
 
+out:
+	kfree(params.mbssid);
 	return err;
 }
 
@@ -9224,12 +9422,14 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -9347,6 +9547,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 free:
+	kfree(params.beacon_after.mbssid);
+	kfree(params.beacon_csa.mbssid);
 	kfree(csa_attrs);
 	return err;
 }

base-commit: 5d869070569a23aa909c6e7e9d010fc438a492ef
-- 
2.31.1

