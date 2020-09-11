Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D988265611
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 02:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgIKAdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 20:33:05 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:40032
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgIKAdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 20:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599784380;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=C7J1TX16AhbK0MBXtvTK6x9x7h5XapwLNjQCHcsN7HI=;
        b=C84siGVG2H1bgmfQuCfW5h41jFheNDG9nKQeWNDmL9dHGO8S+njCNpQKhJ0oVJ+T
        2bJmbEc+o8OCCf1yFyjcMp0bZV/WdfXcv61GwAFYLeOtRCYHoM1vRUArDdgtvRq1Vpv
        GpqQ78xHemjMDpEgpnPLzZGdaxOmqmvIyjnfiBIE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599784380;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=C7J1TX16AhbK0MBXtvTK6x9x7h5XapwLNjQCHcsN7HI=;
        b=mLxKF5M2/yBF04r3cDXvdVodsdUnO2afR5fIJ8gvRzcaPrW7YN8mAmkB10xSqPMK
        smC61KqlHBa3G2HaRIBvx1y4X9Z6bExdd3YqPBegUNtGLkzx/e/7HYFgxhrgIBdHbjS
        xp6DVwhsU1X/YN/r3TGoM429Gvf91/YGZzVZS7gw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F03E9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v5 1/2] nl80211: Unsolicited broadcast probe response support
Date:   Fri, 11 Sep 2020 00:33:00 +0000
Message-ID: <010101747a946698-aac263ae-2ed3-4dab-9590-0bc7131214e1-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200911003251.7686-1-alokad@codeaurora.org>
References: <20200911003251.7686-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.11-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds new attributes to support unsolicited broadcast
probe response transmission used for in-band
discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior for
fast passive scanning).
The new attribute, NL80211_ATTR_UNSOL_BCAST_PROBE_RESP, is nested which
supports following parameters:
(1) NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT - Packet interval
(2) NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL - Template data

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 include/net/cfg80211.h       | 18 ++++++++++++++
 include/uapi/linux/nl80211.h | 36 +++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2011b2434baf..e550f91450d0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1084,6 +1084,22 @@ struct cfg80211_fils_discovery {
 	const u8 *tmpl;
 };
 
+/**
+ * struct cfg80211_unsol_bcast_probe_resp - Unsolicited broadcast probe
+ *	response parameters in 6GHz.
+ *
+ * @interval: Packet interval in TUs. Maximum allowed is 20 TU, as mentioned
+ *	in IEEE P802.11ax/D6.0 26.17.2.3.2 - AP behavior for fast passive
+ *	scanning
+ * @tmpl_len: Template length
+ * @tmpl: Template data for probe response
+ */
+struct cfg80211_unsol_bcast_probe_resp {
+	u32 interval;
+	size_t tmpl_len;
+	const u8 *tmpl;
+};
+
 /**
  * enum cfg80211_ap_settings_flags - AP settings flags
  *
@@ -1132,6 +1148,7 @@ enum cfg80211_ap_settings_flags {
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1163,6 +1180,7 @@ struct cfg80211_ap_settings {
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d6b6c5103387..0c7b56eb5ce2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2517,6 +2517,10 @@ enum nl80211_commands {
  *	discovery. It is a nested attribute, see
  *	&enum nl80211_fils_discovery_attributes.
  *
+ * @NL80211_ATTR_UNSOL_BCAST_PROBE_RESP: Optional parameter to configure
+ *	unsolicited broadcast probe response. It is a nested attribute, see
+ *	&enum nl80211_unsol_bcast_probe_resp_attributes.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3001,6 +3005,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_FILS_DISCOVERY,
 
+	NL80211_ATTR_UNSOL_BCAST_PROBE_RESP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5861,6 +5867,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_FILS_DISCOVERY: Driver/device supports FILS discovery
  *	frames transmission
  *
+ * @NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP: Driver/device supports
+ *	unsolicited broadcast probe response transmission
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5920,6 +5929,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD_AP,
 	NL80211_EXT_FEATURE_FILS_DISCOVERY,
+	NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -7048,4 +7058,30 @@ enum nl80211_fils_discovery_attributes {
  */
 #define NL80211_FILS_DISCOVERY_TMPL_MIN_LEN 42
 
+/**
+ * enum nl80211_unsol_bcast_probe_resp_attributes - Unsolicited broadcast probe
+ *	response configuration. Applicable only in 6GHz.
+ *
+ * @__NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INVALID: Invalid
+ *
+ * @NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT: Maximum packet interval (u32, TU).
+ *	Allowed range: 0..20 (TU = Time Unit). IEEE P802.11ax/D6.0
+ *	26.17.2.3.2 (AP behavior for fast passive scanning).
+ * @NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL: Unsolicited broadcast probe response
+ *	frame template (binary).
+ *
+ * @__NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_LAST: Internal
+ * @NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX: highest attribute
+ */
+enum nl80211_unsol_bcast_probe_resp_attributes {
+	__NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INVALID,
+
+	NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT,
+	NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL,
+
+	/* keep last */
+	__NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_LAST,
+	NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX =
+		__NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_LAST - 1
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c6dcd81fd643..333ba0b6df68 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -376,6 +376,13 @@ nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
 			 IEEE80211_MAX_DATA_LEN),
 };
 
+static const struct nla_policy
+nl80211_unsol_bcast_probe_resp_policy[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX + 1] = {
+	[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT] = NLA_POLICY_MAX(NLA_U32, 20),
+	[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL] = { .type = NLA_BINARY,
+						       .len = IEEE80211_MAX_DATA_LEN }
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -686,6 +693,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_he_6ghz_capa)),
 	[NL80211_ATTR_FILS_DISCOVERY] =
 		NLA_POLICY_NESTED(nl80211_fils_discovery_policy),
+	[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP] =
+		NLA_POLICY_NESTED(nl80211_unsol_bcast_probe_resp_policy),
 };
 
 /* policy for the key attributes */
@@ -4892,6 +4901,36 @@ static int nl80211_parse_fils_discovery(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int
+nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
+				     struct nlattr *attrs,
+				     struct cfg80211_ap_settings *params)
+{
+	struct nlattr *tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX + 1];
+	int ret;
+	struct cfg80211_unsol_bcast_probe_resp *presp =
+					&params->unsol_bcast_probe_resp;
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP)) {
+		return -EINVAL;
+	}
+
+	ret = nla_parse_nested(tb, NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX,
+			       attrs, NULL, NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT] ||
+	    !tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL])
+		return -EINVAL;
+
+	presp->tmpl = nla_data(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
+	presp->tmpl_len = nla_len(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
+	presp->interval = nla_get_u32(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT]);
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -5208,6 +5247,15 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev,
+			info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params);
+		if (err)
+			return err;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.25.0

