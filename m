Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36828221833
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGOXF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 19:05:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64626 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgGOXF2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 19:05:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594854327; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=fVm5bhZrXZ3cqvDPhcIHbSekphBXcIX4s/OyZPjhb5E=; b=AOJnCstKqHcbtQER5FO3UoZ+tEEemwW02367WWlWdwDIl59WdCJJ1sAWoCUnRPfgkC4m0dyd
 X5sePHhWI3LrkncaIIZLoqMYJeLQpawJ0XyMhdc1LRYgfSXpSIULFCUVjI9OJQDPx0I8DXpi
 rtKSMn+r04MnyyLP/uqfKY1j/To=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f0f8bb12991e765cdde6e13 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 23:05:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54FFDC433C9; Wed, 15 Jul 2020 23:05:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BF2BC433CA;
        Wed, 15 Jul 2020 23:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BF2BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v3 1/2] nl80211: Unsolicited broadcast probe response support
Date:   Wed, 15 Jul 2020 16:05:13 -0700
Message-Id: <20200715230514.26792-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200715230514.26792-1-alokad@codeaurora.org>
References: <20200715230514.26792-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
(1) NL80211_UNSOL_BCAST_PROBE_RESP_INT - Packet interval
(2) NL80211_UNSOL_BCAST_PROBE_RESP_TMPL - Template data

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 include/net/cfg80211.h       | 18 ++++++++++++++
 include/uapi/linux/nl80211.h | 32 ++++++++++++++++++++++++
 net/wireless/nl80211.c       | 47 ++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc7e8807838d..884050bf5c74 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1047,6 +1047,22 @@ struct cfg80211_acl_data {
 	struct mac_address mac_addrs[];
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
@@ -1094,6 +1110,7 @@ enum cfg80211_ap_settings_flags {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1124,6 +1141,7 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4e6339ab1fce..f3e6a37f0df8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2505,6 +2505,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
  *
+ * @NL80211_ATTR_UNSOL_BCAST_PROBE_RESP: Optional parameter to configure
+ *	unsolicited broadcast probe response. It is a nested attribute, see
+ *	&enum nl80211_unsol_bcast_probe_resp_attributes.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2987,6 +2991,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_UNSOL_BCAST_PROBE_RESP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6922,4 +6928,30 @@ enum nl80211_iftype_akm_attributes {
 	NL80211_IFTYPE_AKM_ATTR_MAX = __NL80211_IFTYPE_AKM_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_unsol_bcast_probe_resp_attributes - Unsolicited broadcast probe
+ *	response configuration. Applicable only in 6GHz.
+ *
+ * @__NL80211_UNSOL_BCAST_PROBE_RESP_INVALID: Invalid
+ *
+ * @NL80211_UNSOL_BCAST_PROBE_RESP_INT: Maximum packet interval (u32, TU).
+ *	Allowed range: 0..20 (TU = Time Unit). IEEE P802.11ax/D6.0
+ *	26.17.2.3.2 (AP behavior for fast passive scanning.
+ * @NL80211_UNSOL_BCAST_PROBE_RESP_TMPL: Unsolicited broadcast probe response
+ *	frame template (binary).
+ *
+ * @__NL80211_UNSOL_BCAST_PROBE_RESP_LAST: Internal
+ * @NL80211_UNSOL_BCAST_PROBE_RESP_MAX: highest attribute
+ */
+enum nl80211_unsol_bcast_probe_resp_attributes {
+	__NL80211_UNSOL_BCAST_PROBE_RESP_INVALID,
+
+	NL80211_UNSOL_BCAST_PROBE_RESP_INT,
+	NL80211_UNSOL_BCAST_PROBE_RESP_TMPL,
+
+	/* keep last */
+	__NL80211_UNSOL_BCAST_PROBE_RESP_LAST,
+	NL80211_UNSOL_BCAST_PROBE_RESP_MAX =
+		__NL80211_UNSOL_BCAST_PROBE_RESP_LAST - 1
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263ae395ad44..d42056421e55 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -338,6 +338,13 @@ static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
 	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
 };
 
+static const struct nla_policy
+unsol_bcast_probe_resp_policy[NL80211_UNSOL_BCAST_PROBE_RESP_MAX + 1] = {
+	[NL80211_UNSOL_BCAST_PROBE_RESP_INT] = NLA_POLICY_MAX(NLA_U32, 20),
+	[NL80211_UNSOL_BCAST_PROBE_RESP_TMPL] = { .type = NLA_BINARY,
+						  .len = IEEE80211_MAX_DATA_LEN }
+};
+
 static const struct nla_policy
 nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_TID_CONFIG_ATTR_VIF_SUPP] = { .type = NLA_U64 },
@@ -658,6 +665,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		.type = NLA_EXACT_LEN,
 		.len = sizeof(struct ieee80211_he_6ghz_capa),
 	},
+
+	[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP] =
+		NLA_POLICY_NESTED(unsol_bcast_probe_resp_policy),
 };
 
 /* policy for the key attributes */
@@ -4721,6 +4731,35 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 	return 0;
 }
 
+static int
+nl80211_parse_unsol_bcast_probe_resp(struct nlattr *attrs,
+				     struct cfg80211_ap_settings *params)
+{
+	struct nlattr *tmpl;
+	struct nlattr *tb[NL80211_UNSOL_BCAST_PROBE_RESP_MAX + 1];
+	int ret;
+	struct cfg80211_unsol_bcast_probe_resp *presp =
+					&params->unsol_bcast_probe_resp;
+
+	ret = nla_parse_nested(tb, NL80211_UNSOL_BCAST_PROBE_RESP_MAX, attrs,
+			       unsol_bcast_probe_resp_policy, NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_UNSOL_BCAST_PROBE_RESP_INT])
+		return -EINVAL;
+
+	presp->interval = nla_get_u32(tb[NL80211_UNSOL_BCAST_PROBE_RESP_INT]);
+
+	tmpl = tb[NL80211_UNSOL_BCAST_PROBE_RESP_TMPL];
+	if (tmpl) {
+		presp->tmpl = nla_data(tmpl);
+		presp->tmpl_len = nla_len(tmpl);
+	}
+
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -5027,6 +5066,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
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

