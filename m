Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501782FC622
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 01:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbhATAwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 19:52:33 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:51375 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbhATAw3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 19:52:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611103928; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7Bjp9cr7MZ8j3HjFzWGHpyK/1RKlL8TzbyTJ5Al7el4=; b=kxZgqjHwHB9Y3TTDk817Aq8iKuep7PnZSQ0mbadyykAshBfNJulukykwsgaU1aJtTNkCUjgb
 zDpqPXAIa5gVBgEbOorMhRt6/viASVAW/VCHthQ+haIrWMWCnOf6RuZhJlXWLbcHgSMYpqg3
 8XWbHAZopZFbHOsHFGjL7GheFS0=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60077e9321210999ed8dc113 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 00:51:31
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94D54C433CA; Wed, 20 Jan 2021 00:51:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94C4DC433C6;
        Wed, 20 Jan 2021 00:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94C4DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V7 1/4] nl80211: add basic multiple bssid support
Date:   Tue, 19 Jan 2021 16:51:17 -0800
Message-Id: <20210120005120.32424-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210120005120.32424-1-alokad@codeaurora.org>
References: <20210120005120.32424-1-alokad@codeaurora.org>
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

This allows use to generate multiple bssid beacons aswell as EMA ones.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v7: Added missing calls to kfree() in error cases.
v6: Addressed V5 review comments such as,
Dynamic memory allocation for netlink structures,
Limits for variable array accepted from driver,
Used _ELEMS instead of _IE in netlink attribute and made it nested,
Used cfg80211_* instead of ieee80211_* for new struct,
Modified descritptions in comments.

 include/net/cfg80211.h       |  47 ++++++
 include/uapi/linux/nl80211.h |  66 ++++++++
 net/wireless/nl80211.c       | 282 +++++++++++++++++++++++++++--------
 3 files changed, 334 insertions(+), 61 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9a4bbccddc7f..0573626b61d4 100644
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
@@ -4929,6 +4966,11 @@ struct wiphy_iftype_akm_suites {
  * @max_data_retry_count: maximum supported per TID retry count for
  *	configuration through the %NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
+ *
+ * @multiple_bssid: Describes device's multiple BSSID config support
+ * @multiple_bssid.max_num_vaps: Maximum number of VAPS supported by the driver
+ * @multiple_bssid.max_num_elems: Maximum number of multiple BSSID elements
+ *	supported by the driver
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
@@ -5069,6 +5111,11 @@ struct wiphy {
 
 	const struct cfg80211_sar_capa *sar_capa;
 
+	struct {
+		u8 max_num_vaps;
+		u8 max_profile_periodicity;
+	} multiple_bssid;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 40832d13c2f1..02e6b4af7786 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2550,6 +2550,14 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_MULTIPLE_BSSID_CONFIG: Optional parameter to configure multiple
+ *	BSSID and enhanced multi-BSSID advertisements.
+ *	It is a nested attribute, see &enum nl80211_multiple_bssid_attributes.
+ *
+ * @NL80211_ATTR_MULTIPLE_BSSID_ELEMS: Optional parameter for multiple BSSID
+ *	elements. It is a nested attribute, see
+ *	&enum nl80211_multiple_bssid_elems_attributes.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3045,6 +3053,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SAR_SPEC,
 
+	NL80211_ATTR_MULTIPLE_BSSID_CONFIG,
+	NL80211_ATTR_MULTIPLE_BSSID_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7268,4 +7279,59 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_multiple_bssid_attributes - Attributes to configure
+ *	multiple BSSID and enhanced multi-BSSID advertisements.
+ *
+ * @__NL80211_MULTIPLE_BSSID_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MULTIPLE_BSSID_ATTR_PARENT: For a non-transmitted BSSID, this
+ *	attribute provides the interface index (u32) of the transmitted profile
+ *	in the multiple BSSID set.
+ *
+ * @NL80211_MULTIPLE_BSSID_ATTR_INDEX: The index of this BSS (u8) inside
+ *	multiple BSSID set.
+ *
+ * @NL80211_MULTIPLE_BSSID_ATTR_COUNT: Total number of BSSs (u8) in the
+ *	multiple BSSID set.
+ *
+ * @NL80211_MULTIPLE_BSSID_ATTR_EMA: Flag to indicate if enhanced multi-BSSID
+ *	advertisements (EMA) feature is enabled.
+ *	If set to 1, elements provided through attribute
+ *	%NL80211_ATTR_MULTIPLE_BSSID_ELEMS are split into multiple beacons.
+ *	Otherwise, all elements will be included in every beacon.
+ */
+enum nl80211_multiple_bssid_attributes {
+	__NL80211_MULTIPLE_BSSID_ATTR_INVALID,
+
+	NL80211_MULTIPLE_BSSID_ATTR_PARENT,
+	NL80211_MULTIPLE_BSSID_ATTR_INDEX,
+	NL80211_MULTIPLE_BSSID_ATTR_COUNT,
+	NL80211_MULTIPLE_BSSID_ATTR_EMA,
+
+	__NL80211_MULTIPLE_BSSID_ATTR_LAST,
+	NL80211_MULTIPLE_BSSID_ATTR_MAX = __NL80211_MULTIPLE_BSSID_ATTR_LAST - 1,
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
+	NL80211_MULTIPLE_BSSID_ELEMS_ATTR_MAX = __NL80211_MULTIPLE_BSSID_ELEMS_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 775d0c4d86c3..031f614c5ace 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -411,6 +411,20 @@ sar_policy[NL80211_SAR_ATTR_MAX + 1] = {
 	[NL80211_SAR_ATTR_SPECS] = NLA_POLICY_NESTED_ARRAY(sar_specs_policy),
 };
 
+static const struct nla_policy
+nl80211_multiple_bssid_elems_policy[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_MAX + 1] = {
+	[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_COUNT] = { .type = NLA_U8 },
+	[NL80211_MULTIPLE_BSSID_ELEMS_ATTR_DATA] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy
+nl80211_multiple_bssid_policy[NL80211_MULTIPLE_BSSID_ATTR_MAX + 1] = {
+	[NL80211_MULTIPLE_BSSID_ATTR_PARENT] = { .type = NLA_U32 },
+	[NL80211_MULTIPLE_BSSID_ATTR_INDEX] = { .type = NLA_U8 },
+	[NL80211_MULTIPLE_BSSID_ATTR_COUNT] = { .type = NLA_U8 },
+	[NL80211_MULTIPLE_BSSID_ATTR_EMA] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -732,6 +746,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				 NL80211_SAE_PWE_BOTH),
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
+	[NL80211_ATTR_MULTIPLE_BSSID_CONFIG] =
+			NLA_POLICY_NESTED(nl80211_multiple_bssid_policy),
+	[NL80211_ATTR_MULTIPLE_BSSID_ELEMS] =
+			NLA_POLICY_NESTED(nl80211_multiple_bssid_elems_policy),
 };
 
 /* policy for the key attributes */
@@ -4864,6 +4882,79 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int
+nl80211_parse_multiple_bssid_config(struct wiphy *wiphy,
+				    struct nlattr *attrs,
+				    struct cfg80211_ap_settings *params)
+{
+	struct nlattr *tb[NL80211_MULTIPLE_BSSID_ATTR_MAX + 1];
+	int ret;
+	struct cfg80211_multiple_bssid *config = &params->multiple_bssid;
+
+	ret = nla_parse_nested(tb, NL80211_MULTIPLE_BSSID_ATTR_MAX, attrs, NULL,
+			       NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_MULTIPLE_BSSID_ATTR_COUNT])
+		return -EINVAL;
+
+	config->count = nla_get_u8(tb[NL80211_MULTIPLE_BSSID_ATTR_COUNT]);
+	if (config->count > wiphy->multiple_bssid.max_num_vaps)
+		return -EINVAL;
+
+	if (tb[NL80211_MULTIPLE_BSSID_ATTR_PARENT])
+		config->parent = nla_get_u32(tb[NL80211_MULTIPLE_BSSID_ATTR_PARENT]);
+
+	if (tb[NL80211_MULTIPLE_BSSID_ATTR_INDEX])
+		config->index = nla_get_u8(tb[NL80211_MULTIPLE_BSSID_ATTR_INDEX]);
+
+	if (tb[NL80211_MULTIPLE_BSSID_ATTR_EMA]) {
+		config->ema = nla_get_flag(tb[NL80211_MULTIPLE_BSSID_ATTR_EMA]);
+		if (config->ema &&
+		    params->beacon.multiple_bssid->cnt >
+		    wiphy->multiple_bssid.max_profile_periodicity)
+			return -EINVAL;
+	}
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
@@ -4944,6 +5035,14 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_MULTIPLE_BSSID_ELEMS]) {
+		bcn->multiple_bssid =
+			nl80211_parse_multiple_bssid_elems(&rdev->wiphy,
+							   attrs[NL80211_ATTR_MULTIPLE_BSSID_ELEMS]);
+		if (!bcn->multiple_bssid)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -5229,7 +5328,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
 	if (err)
-		return err;
+		goto out;
 
 	params.beacon_interval =
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
@@ -5239,7 +5338,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params.beacon_interval);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * In theory, some of these attributes should be required here
@@ -5252,8 +5351,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5266,57 +5367,73 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
+		if (!(rdev->wiphy.features & NL80211_FEATURE_INACTIVITY_TIMER)) {
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
@@ -5324,12 +5441,12 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5340,29 +5457,38 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -5397,7 +5523,15 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
 			&params);
 		if (err)
-			return err;
+			goto out;
+	}
+
+	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_CONFIG]) {
+		err = nl80211_parse_multiple_bssid_config(&rdev->wiphy,
+							  info->attrs[NL80211_ATTR_MULTIPLE_BSSID_CONFIG],
+							  &params);
+		if (err)
+			goto out;
 	}
 
 	nl80211_calculate_ap_params(&params);
@@ -5421,7 +5555,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 out:
 	kfree(params.acl);
-
+	kfree(params.beacon.multiple_bssid);
 	return err;
 }
 
@@ -5445,12 +5579,14 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 
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
 
@@ -9122,24 +9258,30 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 					  info->attrs[NL80211_ATTR_CSA_IES],
 					  nl80211_policy, info->extack);
 	if (err)
-		return err;
+		goto out;
 
 	err = nl80211_parse_beacon(rdev, csa_attrs, &params.beacon_csa);
 	if (err)
-		return err;
+		goto out;
 
-	if (!csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON])
-		return -EINVAL;
+	if (!csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
-	if (!len || (len % sizeof(u16)))
-		return -EINVAL;
+	if (!len || (len % sizeof(u16))) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	params.n_counter_offsets_beacon = len / sizeof(u16);
 	if (rdev->wiphy.max_num_csa_counters &&
 	    (params.n_counter_offsets_beacon >
-	     rdev->wiphy.max_num_csa_counters))
-		return -EINVAL;
+	     rdev->wiphy.max_num_csa_counters)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	params.counter_offsets_beacon =
 		nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
@@ -9148,23 +9290,31 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	for (i = 0; i < params.n_counter_offsets_beacon; i++) {
 		u16 offset = params.counter_offsets_beacon[i];
 
-		if (offset >= params.beacon_csa.tail_len)
-			return -EINVAL;
+		if (offset >= params.beacon_csa.tail_len) {
+			err = -EINVAL;
+			goto out;
+		}
 
-		if (params.beacon_csa.tail[offset] != params.count)
-			return -EINVAL;
+		if (params.beacon_csa.tail[offset] != params.count) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
 		len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
-		if (!len || (len % sizeof(u16)))
-			return -EINVAL;
+		if (!len || (len % sizeof(u16))) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		params.n_counter_offsets_presp = len / sizeof(u16);
 		if (rdev->wiphy.max_num_csa_counters &&
 		    (params.n_counter_offsets_presp >
-		     rdev->wiphy.max_num_csa_counters))
-			return -EINVAL;
+		     rdev->wiphy.max_num_csa_counters)) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		params.counter_offsets_presp =
 			nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
@@ -9173,35 +9323,42 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		for (i = 0; i < params.n_counter_offsets_presp; i++) {
 			u16 offset = params.counter_offsets_presp[i];
 
-			if (offset >= params.beacon_csa.probe_resp_len)
-				return -EINVAL;
+			if (offset >= params.beacon_csa.probe_resp_len) {
+				err = -EINVAL;
+				goto out;
+			}
 
 			if (params.beacon_csa.probe_resp[offset] !=
-			    params.count)
-				return -EINVAL;
+			    params.count) {
+				err = -EINVAL;
+				goto out;
+			}
 		}
 	}
 
 skip_beacons:
 	err = nl80211_parse_chandef(rdev, info, &params.chandef);
 	if (err)
-		return err;
+		goto out;
 
 	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params.chandef,
-					   wdev->iftype))
-		return -EINVAL;
+					   wdev->iftype)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = cfg80211_chandef_dfs_required(wdev->wiphy,
 					    &params.chandef,
 					    wdev->iftype);
 	if (err < 0)
-		return err;
+		goto out;
 
 	if (err > 0) {
 		params.radar_required = true;
 		if (need_handle_dfs_flag &&
 		    !nla_get_flag(info->attrs[NL80211_ATTR_HANDLE_DFS])) {
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 	}
 
@@ -9212,6 +9369,9 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	err = rdev_channel_switch(rdev, dev, &params);
 	wdev_unlock(wdev);
 
+out:
+	kfree(params.beacon_after.multiple_bssid);
+	kfree(params.beacon_csa.multiple_bssid);
 	return err;
 }
 
-- 
2.25.0

