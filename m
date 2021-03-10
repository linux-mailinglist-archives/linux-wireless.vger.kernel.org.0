Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA03346AB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 19:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhCJS0q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 13:26:46 -0500
Received: from z11.mailgun.us ([104.130.96.11]:55982 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhCJS0g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 13:26:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615400795; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BcKyRbhbuyBRNvNa8flbZJeO17P6+NvSlzwlw7Ujb5I=; b=S1bunLysOgrDiSGTkyVvCvDL9xwHVu3XPYbYIlSd7/NyPeK8xrsVsw5jgOOz6d52TMSTfXQ8
 CPSHkopbJ13MxZDJg1mFlKiphBJmqyYeOzFvv3xnYBy5TM2wySVRmG2JkKukjqQn0gR1Iz3k
 mvm3ArBfyaj4nrg8dFc0oG+Kl+A=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60490f49af1d9a68adb6eb2c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 18:26:17
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64691C43464; Wed, 10 Mar 2021 18:26:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C6B4C433CA;
        Wed, 10 Mar 2021 18:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C6B4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v9 1/4] nl80211: add basic multiple bssid support
Date:   Wed, 10 Mar 2021 10:26:01 -0800
Message-Id: <20210310182604.8858-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210310182604.8858-1-alokad@codeaurora.org>
References: <20210310182604.8858-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

This patch adds support for passing the multiple bssid config to the
kernel when an AP gets started. If the BSS is non-transmitting we need
to pass

* the ifidx of the transmitting parent
* the BSS index in the set
* the BSS count of the set
* flag indicating if we want to do EMA
* the multiple bssid elements as an array inside the beacon data

This allows use to generate multiple bssid beacons as well as EMA ones.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v9: Added check around kfree(params.acl)
    Corrected comment descriptions for NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP
	and max_profile_periodicity

v8: Addition of NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP,
    NL80211_EXT_FEATURE_EMA_AP and wiphy parameters max_num_vaps,
	max_profile_periodicity exposed to the application.

 include/net/cfg80211.h       |  47 ++++++
 include/uapi/linux/nl80211.h |  84 +++++++++++
 net/wireless/nl80211.c       | 280 ++++++++++++++++++++++++++++++-----
 3 files changed, 371 insertions(+), 40 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 911fae42b0c0..7755a04a6de6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -485,6 +485,21 @@ struct ieee80211_supported_band {
 	const struct ieee80211_sband_iftype_data *iftype_data;
 };
 
+/**
+ * struct cfg80211_multiple_bssid - AP settings for multi bssid
+ *
+ * @index: the index of this AP in the multi bssid group.
+ * @count: the total number of multi bssid peer APs.
+ * @parent: non-transmitted BSSs transmitted parents index
+ * @ema: Shall the beacons be sent out in EMA mode.
+ */
+struct cfg80211_multiple_bssid {
+	u8 index;
+	u8 count;
+	u32 parent;
+	bool ema;
+};
+
 /**
  * ieee80211_get_sband_iftype_data - return sband data for a given iftype
  * @sband: the sband to search for the STA on
@@ -1032,6 +1047,23 @@ struct cfg80211_crypto_settings {
 	enum nl80211_sae_pwe_mechanism sae_pwe;
 };
 
+/**
+ * struct cfg80211_multiple_bssid_data - Multiple BSSID elements
+ *
+ * @cnt: Number of elements in array %elems.
+ *
+ * @elems: Array of multiple BSSID element(s) to be added into Beacon frames.
+ * @elems.data: Data for multiple BSSID elements.
+ * @elems.len: Length of data.
+ */
+struct cfg80211_multiple_bssid_data {
+	u8 cnt;
+	struct {
+		u8 *data;
+		size_t len;
+	} elems[];
+};
+
 /**
  * struct cfg80211_beacon_data - beacon data
  * @head: head portion of beacon (before TIM IE)
@@ -1058,6 +1090,7 @@ struct cfg80211_crypto_settings {
  *	Token (measurement type 11)
  * @lci_len: LCI data length
  * @civicloc_len: Civic location data length
+ * @multiple_bssid: multiple_bssid elements
  */
 struct cfg80211_beacon_data {
 	const u8 *head, *tail;
@@ -1076,6 +1109,8 @@ struct cfg80211_beacon_data {
 	size_t probe_resp_len;
 	size_t lci_len;
 	size_t civicloc_len;
+
+	struct cfg80211_multiple_bssid_data *multiple_bssid;
 };
 
 struct mac_address {
@@ -1181,6 +1216,7 @@ enum cfg80211_ap_settings_flags {
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @multiple_bssid: AP settings for multiple bssid.
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1213,6 +1249,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
+	struct cfg80211_multiple_bssid multiple_bssid;
 };
 
 /**
@@ -4941,6 +4978,11 @@ struct wiphy_iftype_akm_suites {
  *	configuration through the %NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
  * @sar_capa: SAR control capabilities
+ *
+ * @multiple_bssid: Describes device's multiple BSSID config support
+ * @multiple_bssid.max_num_vaps: Maximum number of VAPS supported by the driver
+ * @multiple_bssid.max_profile_periodicity: Maximum EMA profile periodicity
+ *	supported by the driver
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5083,6 +5125,11 @@ struct wiphy {
 
 	const struct cfg80211_sar_capa *sar_capa;
 
+	struct {
+		u8 max_num_vaps;
+		u8 max_profile_periodicity;
+	} multiple_bssid;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ac78da99fccd..740bae5369ac 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2557,6 +2557,19 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_MULTIPLE_BSSID_CONFIG: Optional parameter to configure
+ *	multiple BSSID and enhanced multi-BSSID advertisements.
+ *	This attribute is also used to advertise the maximum number of VAPs
+ *	supported by the driver to the application. It is a nested attribute,
+ *	see &enum nl80211_multiple_bssid_config_attributes.
+ *
+ * @NL80211_ATTR_MULTIPLE_BSSID_ELEMS: Optional parameter for multiple BSSID
+ *	elements data. This attribute is also used to advertise the maximum
+ *	profile periodicity supported by the driver to the application, if
+ *	enhanced multi-BSS advertisements (EMA) feature is enabled.
+ *	It is a nested attribute, see
+ *	&enum nl80211_multiple_bssid_elems_attributes.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3054,6 +3067,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_MULTIPLE_BSSID_CONFIG,
+	NL80211_ATTR_MULTIPLE_BSSID_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5937,6 +5953,11 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_BEACON_RATE_HE: Driver supports beacon rate
  *	configuration (AP/mesh) with HE rates.
  *
+ * @NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP: Driver/device supports multiple
+ *	BSSID advertisements.
+ * @NL80211_EXT_FEATURE_EMA_AP: Driver/device supports enhanced multiple BSSID
+ *	advertisements (EMA).
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5998,6 +6019,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_FILS_DISCOVERY,
 	NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP,
 	NL80211_EXT_FEATURE_BEACON_RATE_HE,
+	NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP,
+	NL80211_EXT_FEATURE_EMA_AP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -7277,4 +7300,65 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_multiple_bssid_config_attributes - Attributes to configure
+ *	multiple BSSID and enhanced multi-BSSID advertisements.
+ *
+ * @__NL80211_MULTIPLE_BSSID_CONFIG_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MULTIPLE_BSSID_CONFIG_ATTR_PARENT: For a non-transmitted BSSID, this
+ *	attribute provides the interface index (u32) of the transmitted profile
+ *	in the multiple BSSID set.
+ *
+ * @NL80211_MULTIPLE_BSSID_CONFIG_ATTR_INDEX: The index of this BSS (u8) inside
+ *	multiple BSSID set.
+ *
+ * @NL80211_MULTIPLE_BSSID_CONFIG_ATTR_COUNT: Total number of BSSs (u8) in the
+ *	multiple BSSID set.
+ *
+ * @NL80211_MULTIPLE_BSSID_CONFIG_ATTR_EMA: Flag to indicate if enhanced multi-BSSID
+ *	advertisements (EMA) feature is enabled.
+ *	If set to 1, elements provided through attribute
+ *	%NL80211_ATTR_MULTIPLE_BSSID_ELEMS are split into multiple beacons.
+ *	Otherwise, all elements will be included in every beacon.
+ *
+ * @__NL80211_MULTIPLE_BSSID_CONFIG_ATTR_LAST: Internal
+ * @NL80211_MULTIPLE_BSSID_CONFIG_ATTR_MAX: highest attribute
+ */
+enum nl80211_multiple_bssid_config_attributes {
+	__NL80211_MULTIPLE_BSSID_CONFIG_ATTR_INVALID,
+
+	NL80211_MULTIPLE_BSSID_CONFIG_ATTR_PARENT,
+	NL80211_MULTIPLE_BSSID_CONFIG_ATTR_INDEX,
+	NL80211_MULTIPLE_BSSID_CONFIG_ATTR_COUNT,
+	NL80211_MULTIPLE_BSSID_CONFIG_ATTR_EMA,
+
+	/* keep last */
+	__NL80211_MULTIPLE_BSSID_CONFIG_ATTR_LAST,
+	NL80211_MULTIPLE_BSSID_CONFIG_ATTR_MAX =
+		__NL80211_MULTIPLE_BSSID_CONFIG_ATTR_LAST - 1,
+};
+
+/**
+ * enum nl80211_multiple_bssid_elems_attributes - Attributes used to pass
+ *	multiple BSSID elements data.
+ *
+ * @__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT: Number of multiple BSSID
+ *	elements (u8).
+ *
+ * @NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA: Array of multiple BSSID elements.
+ */
+enum nl80211_multiple_bssid_elems_attributes {
+	__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_INVALID,
+
+	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT,
+	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA,
+
+	__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_LAST,
+	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_MAX =
+		__NL80211_MULTIPLE_BSSID_ELEMS_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 521d36bb0803..9ff33fc3967d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -431,6 +431,20 @@ sar_policy[NL80211_SAR_ATTR_MAX + 1] = {
 	[NL80211_SAR_ATTR_SPECS] = NLA_POLICY_NESTED_ARRAY(sar_specs_policy),
 };
 
+static const struct nla_policy
+nl80211_multiple_bssid_elems_policy[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_MAX + 1] = {
+	[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT] = { .type = NLA_U8 },
+	[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy
+nl80211_multiple_bssid_policy[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_MAX + 1] = {
+	[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_PARENT] = { .type = NLA_U32 },
+	[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
+	[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_COUNT] = { .type = NLA_U8 },
+	[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -753,6 +767,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_MULTIPLE_BSSID_CONFIG] =
+			NLA_POLICY_NESTED(nl80211_multiple_bssid_policy),
+	[NL80211_ATTR_MULTIPLE_BSSID_ELEMS] =
+			NLA_POLICY_NESTED(nl80211_multiple_bssid_elems_policy),
 };
 
 /* policy for the key attributes */
@@ -2192,6 +2210,49 @@ nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_multiple_bssid_support(struct wiphy *wiphy, struct sk_buff *msg)
+{
+	struct nlattr *config = NULL, *elems = NULL;
+
+	if (!wiphy_ext_feature_isset(wiphy,
+				     NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP))
+		return 0;
+
+	if (wiphy->multiple_bssid.max_num_vaps) {
+		config = nla_nest_start(msg,
+					NL80211_ATTR_MULTIPLE_BSSID_CONFIG);
+		if (!config)
+			return -ENOSPC;
+
+		if (nla_put_u8(msg, NL80211_MULTIPLE_BSSID_CONFIG_ATTR_COUNT,
+			       wiphy->multiple_bssid.max_num_vaps))
+			goto fail_config;
+
+		nla_nest_end(msg, config);
+	}
+
+	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_EMA_AP) &&
+	    wiphy->multiple_bssid.max_profile_periodicity) {
+		elems = nla_nest_start(msg, NL80211_ATTR_MULTIPLE_BSSID_ELEMS);
+		if (!elems)
+			goto fail_config;
+
+		if (nla_put_u8(msg, NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT,
+			       wiphy->multiple_bssid.max_profile_periodicity))
+			goto fail_elems;
+
+		nla_nest_end(msg, elems);
+	}
+	return 0;
+
+fail_elems:
+	nla_nest_cancel(msg, elems);
+fail_config:
+	nla_nest_cancel(msg, config);
+	return -ENOBUFS;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2774,6 +2835,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_sar_specs(rdev, msg))
 			goto nla_put_failure;
 
+		if (nl80211_put_multiple_bssid_support(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -4952,6 +5016,90 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int
+nl80211_parse_multiple_bssid_config(struct wiphy *wiphy,
+				    struct nlattr *attrs,
+				    struct cfg80211_ap_settings *params)
+{
+	struct nlattr *tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_MAX + 1];
+	int ret;
+	struct cfg80211_multiple_bssid *config = &params->multiple_bssid;
+
+	if (!wiphy_ext_feature_isset(wiphy,
+				     NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP))
+		return -EINVAL;
+
+	ret = nla_parse_nested(tb, NL80211_MULTIPLE_BSSID_CONFIG_ATTR_MAX, attrs, NULL,
+			       NULL);
+	if (ret)
+		return ret;
+
+	config->ema = nla_get_flag(tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_EMA]);
+	if (config->ema &&
+	    (!wiphy_ext_feature_isset(wiphy,
+				      NL80211_EXT_FEATURE_EMA_AP) ||
+	     (wiphy->multiple_bssid.max_profile_periodicity &&
+	      params->beacon.multiple_bssid->cnt >
+	      wiphy->multiple_bssid.max_profile_periodicity)))
+		return -EINVAL;
+
+	if (!tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_COUNT])
+		return -EINVAL;
+
+	config->count = nla_get_u8(tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_COUNT]);
+	if (config->count < 1 ||
+	    (wiphy->multiple_bssid.max_num_vaps &&
+	     config->count > wiphy->multiple_bssid.max_num_vaps))
+		return -EINVAL;
+
+	if (tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_PARENT])
+		config->parent = nla_get_u32(tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_PARENT]);
+
+	if (tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_INDEX])
+		config->index = nla_get_u8(tb[NL80211_MULTIPLE_BSSID_CONFIG_ATTR_INDEX]);
+
+	return 0;
+}
+
+static struct cfg80211_multiple_bssid_data *
+nl80211_parse_multiple_bssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
+{
+	struct cfg80211_multiple_bssid_data *multiple_bssid;
+	struct nlattr *nl_ie;
+	struct nlattr *tb[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_MAX + 1];
+	int rem_ie;
+	u8 i = 0, err, num_elems;
+
+	if (!wiphy_ext_feature_isset(wiphy,
+				     NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP))
+		return NULL;
+
+	err = nla_parse_nested(tb, NL80211_MULTIPLE_BSSID_ELEMS_ATTR_MAX,
+			       attrs, NULL, NULL);
+	if (err)
+		return NULL;
+
+	if (!tb[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT] ||
+	    !tb[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA])
+		return NULL;
+
+	num_elems = nla_get_u8(tb[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT]);
+	multiple_bssid = kzalloc(struct_size(multiple_bssid, elems, num_elems),
+				 GFP_KERNEL);
+	if (!multiple_bssid)
+		return NULL;
+
+	multiple_bssid->cnt = num_elems;
+	nla_for_each_nested(nl_ie, tb[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA],
+			    rem_ie) {
+		multiple_bssid->elems[i].data = nla_data(nl_ie);
+		multiple_bssid->elems[i].len = nla_len(nl_ie);
+		i++;
+	}
+
+	return multiple_bssid;
+}
+
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn)
@@ -5032,6 +5180,14 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_MULTIPLE_BSSID_ELEMS]) {
+		bcn->multiple_bssid = nl80211_parse_multiple_bssid_elems(
+				&rdev->wiphy,
+				attrs[NL80211_ATTR_MULTIPLE_BSSID_ELEMS]);
+		if (!bcn->multiple_bssid)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -5317,7 +5473,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
 	if (err)
-		return err;
+		goto out;
 
 	params.beacon_interval =
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
@@ -5327,7 +5483,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params.beacon_interval);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * In theory, some of these attributes should be required here
@@ -5340,8 +5496,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5354,57 +5512,74 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5412,12 +5587,12 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5428,29 +5603,38 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5485,7 +5669,16 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
 			&params);
 		if (err)
-			return err;
+			goto out;
+	}
+
+	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_CONFIG]) {
+		err = nl80211_parse_multiple_bssid_config(
+			&rdev->wiphy,
+			info->attrs[NL80211_ATTR_MULTIPLE_BSSID_CONFIG],
+			&params);
+		if (err)
+			goto out;
 	}
 
 	nl80211_calculate_ap_params(&params);
@@ -5508,8 +5701,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.acl);
-
+	if (!IS_ERR(params.acl))
+		kfree(params.acl);
+	kfree(params.beacon.multiple_bssid);
 	return err;
 }
 
@@ -5533,12 +5727,14 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params);
 	if (err)
-		return err;
+		goto out;
 
 	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, &params);
 	wdev_unlock(wdev);
 
+out:
+	kfree(params.multiple_bssid);
 	return err;
 }
 
@@ -9218,12 +9414,14 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -9341,6 +9539,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 free:
+	kfree(params.beacon_after.multiple_bssid);
+	kfree(params.beacon_csa.multiple_bssid);
 	kfree(csa_attrs);
 	return err;
 }
-- 
2.25.0

