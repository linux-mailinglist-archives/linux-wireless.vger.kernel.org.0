Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC72655F1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 02:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKAFl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 20:05:41 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:35394
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgIKAFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 20:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599782730;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=uNmK8blDv+s/EPBNyeeSA/wiIldr8S8L4AuPXFV9Kfc=;
        b=CniJAdG9/pozDCQeV8q2dyyj0rY0NFQhjZF+Oy9Nd6R3rgg8cD27kcheEq5b3V4m
        iYOCOrxM1d6JsztjEhNxHV3V/ehIB4QLmBcNKTwwB/QdL60iqdMujDluV9lTU4CQBHI
        q063KjfRlgZHN95AUrjURndLrWfBinaAam1bQ4s4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599782730;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=uNmK8blDv+s/EPBNyeeSA/wiIldr8S8L4AuPXFV9Kfc=;
        b=ffNY253UDs8NWGALLwiBQWm0qX0F7LRRMvX5S1/ucVCw0L3gdFCCtpwQahy7y75Z
        PLwC400OKOvBzJ3aA43fd/ey/aaU6t3mvosb6HygvYiTbOsIjYhO5oRBE76ghz9oG0i
        tS9e6Dv5zR5+DpuFB6yKU+dI8NUYGUPaUE77W+9U=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 063B1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <alokad@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v6 1/2] nl80211: Add FILS discovery support
Date:   Fri, 11 Sep 2020 00:05:29 +0000
Message-ID: <010101747a7b38a8-306f06b2-9061-4baf-81c1-054a42a18e22-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200911000514.24242-1-alokad@codeaurora.org>
References: <20200911000514.24242-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.11-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery attribute, NL80211_ATTR_FILS_DISCOVERY, is nested which
supports following parameters as given in IEEE Std 802.11ai-2016,
Annex C.3 MIB detail:
(1) NL80211_FILS_DISCOVERY_ATTR_INT_MIN - Minimum packet interval
(2) NL80211_FILS_DISCOVERY_ATTR_INT_MAX - Maximum packet interval
(3) NL80211_FILS_DISCOVERY_ATTR_TMPL - Template data

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Link:
https://lore.kernel.org/r/20200805011838.28166-2-alokad@codeaurora.org
[fix attribute and other names, use NLA_RANGE(), use policy only once]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       | 19 ++++++++++++++
 include/uapi/linux/nl80211.h | 44 +++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c9bce9bba511..2011b2434baf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1067,6 +1067,23 @@ struct cfg80211_acl_data {
 	struct mac_address mac_addrs[];
 };
 
+/**
+ * struct cfg80211_fils_discovery - FILS discovery parameters from
+ * IEEE Std 802.11ai-2016, Annex C.3 MIB detail.
+ *
+ * @min_interval: Minimum packet interval in TUs (0 - 10000)
+ * @max_interval: Maximum packet interval in TUs (0 - 10000)
+ * @tmpl_len: Template length
+ * @tmpl: Template data for FILS discovery frame including the action
+ *	frame headers.
+ */
+struct cfg80211_fils_discovery {
+	u32 min_interval;
+	u32 max_interval;
+	size_t tmpl_len;
+	const u8 *tmpl;
+};
+
 /**
  * enum cfg80211_ap_settings_flags - AP settings flags
  *
@@ -1114,6 +1131,7 @@ enum cfg80211_ap_settings_flags {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @fils_discovery: FILS discovery transmission parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1144,6 +1162,7 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct cfg80211_fils_discovery fils_discovery;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0584e0d349f0..d6b6c5103387 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2513,6 +2513,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
  *
+ * @NL80211_ATTR_FILS_DISCOVERY: Optional parameter to configure FILS
+ *	discovery. It is a nested attribute, see
+ *	&enum nl80211_fils_discovery_attributes.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2995,6 +2999,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_FILS_DISCOVERY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5852,6 +5858,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD_AP: Device wants to do SAE authentication
  *	in AP mode (SAE password is passed as part of the start AP command).
  *
+ * @NL80211_EXT_FEATURE_FILS_DISCOVERY: Driver/device supports FILS discovery
+ *	frames transmission
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5910,6 +5919,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_OPERATING_CHANNEL_VALIDATION,
 	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD_AP,
+	NL80211_EXT_FEATURE_FILS_DISCOVERY,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -7004,4 +7014,38 @@ enum nl80211_iftype_akm_attributes {
 	NL80211_IFTYPE_AKM_ATTR_MAX = __NL80211_IFTYPE_AKM_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_fils_discovery_attributes - FILS discovery configuration
+ * from IEEE Std 802.11ai-2016, Annex C.3 MIB detail.
+ *
+ * @__NL80211_FILS_DISCOVERY_ATTR_INVALID: Invalid
+ *
+ * @NL80211_FILS_DISCOVERY_ATTR_INT_MIN: Minimum packet interval (u32, TU).
+ *	Allowed range: 0..10000 (TU = Time Unit)
+ * @NL80211_FILS_DISCOVERY_ATTR_INT_MAX: Maximum packet interval (u32, TU).
+ *	Allowed range: 0..10000 (TU = Time Unit)
+ * @NL80211_FILS_DISCOVERY_ATTR_TMPL: Template data for FILS discovery action
+ *	frame including the headers.
+ *
+ * @__NL80211_FILS_DISCOVERY_ATTR_LAST: Internal
+ * @NL80211_FILS_DISCOVERY_ATTR_MAX: highest attribute
+ */
+enum nl80211_fils_discovery_attributes {
+	__NL80211_FILS_DISCOVERY_ATTR_INVALID,
+
+	NL80211_FILS_DISCOVERY_ATTR_INT_MIN,
+	NL80211_FILS_DISCOVERY_ATTR_INT_MAX,
+	NL80211_FILS_DISCOVERY_ATTR_TMPL,
+
+	/* keep last */
+	__NL80211_FILS_DISCOVERY_ATTR_LAST,
+	NL80211_FILS_DISCOVERY_ATTR_MAX = __NL80211_FILS_DISCOVERY_ATTR_LAST - 1
+};
+
+/*
+ * FILS discovery template minimum length with action frame headers and
+ * mandatory fields.
+ */
+#define NL80211_FILS_DISCOVERY_TMPL_MIN_LEN 42
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 52a35e788547..c6dcd81fd643 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -367,6 +367,15 @@ nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
+static const struct nla_policy
+nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
+	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
+	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
+	NLA_POLICY_RANGE(NLA_BINARY,
+			 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
+			 IEEE80211_MAX_DATA_LEN),
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -675,6 +684,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SCAN_FREQ_KHZ] = { .type = NLA_NESTED },
 	[NL80211_ATTR_HE_6GHZ_CAPABILITY] =
 		NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_he_6ghz_capa)),
+	[NL80211_ATTR_FILS_DISCOVERY] =
+		NLA_POLICY_NESTED(nl80211_fils_discovery_policy),
 };
 
 /* policy for the key attributes */
@@ -4850,6 +4861,37 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 	return 0;
 }
 
+static int nl80211_parse_fils_discovery(struct cfg80211_registered_device *rdev,
+					struct nlattr *attrs,
+					struct cfg80211_ap_settings *params)
+{
+	struct nlattr *tb[NL80211_FILS_DISCOVERY_ATTR_MAX + 1];
+	int ret;
+	struct cfg80211_fils_discovery *fd = &params->fils_discovery;
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_FILS_DISCOVERY)) {
+		return -EINVAL;
+	}
+
+	ret = nla_parse_nested(tb, NL80211_FILS_DISCOVERY_ATTR_MAX, attrs,
+			       NULL, NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] ||
+	    !tb[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] ||
+	    !tb[NL80211_FILS_DISCOVERY_ATTR_TMPL])
+		return -EINVAL;
+
+	fd->tmpl_len = nla_len(tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]);
+	fd->tmpl = nla_data(tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]);
+	fd->min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MIN]);
+	fd->max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MAX]);
+
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -5158,6 +5200,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
+		err = nl80211_parse_fils_discovery(rdev,
+						   info->attrs[NL80211_ATTR_FILS_DISCOVERY],
+						   &params);
+		if (err)
+			goto out;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.25.0

