Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFB1EB3BF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 05:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgFBDUa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 23:20:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49898 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgFBDUa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 23:20:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591068029; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cVXRWaJb5ucFL5x8vT2qqsUlSumztisFUDHor+5IPwg=; b=t+3tYh6cw9RMH9HDawp03dsevGMJ8Ts4Wcfy845WKXNLJ0Unjki2GrUCj/ace87HPa5CRywW
 Lrty5LzsRFlXLfdLC9xo4kqcRq6c76g2Tf72IrDfkg0Aij5iAsE3iBiix+xZRilIfOF5j5qt
 qYcCFZhHv1rEZMDTaHtimJFHOAc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ed5c5693131442d95e0d75f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 03:20:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD457C433C6; Tue,  2 Jun 2020 03:20:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F83EC433CB;
        Tue,  2 Jun 2020 03:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F83EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 1/2] nl80211: Unsolicited bcast probe resp support
Date:   Mon,  1 Jun 2020 20:20:00 -0700
Message-Id: <20200602032001.21142-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200602032001.21142-1-alokad@codeaurora.org>
References: <20200602032001.21142-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds new attributes to support FILS unsolicited broadcast
probe response transmission used for in-band
discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior for
fast passive scanning).
The new attribute, NL80211_ATTR_UNSOL_BCAST_PROBE_RESP, is nested which
supports following parameters:
(1) NL80211_UNSOL_BCAST_PROBE_RESP_INT - Packet interval
(2) NL80211_UNSOL_BCAST_PROBE_RESP_TMPL - Template data

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 include/net/cfg80211.h       | 21 +++++++++++++++
 include/uapi/linux/nl80211.h | 32 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 52 ++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b58ad1a3f695..53c92af48ccd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1047,6 +1047,25 @@ struct cfg80211_acl_data {
 	struct mac_address mac_addrs[];
 };
 
+/**
+ * struct cfg80211_unsol_bcast_probe_resp - Unsolicited broadcast probe
+ *	response parameters in 6GHz.
+ *
+ * @enabled: Set to true if unsolicited broadcast probe response transmission
+ *	is enabled
+ * @interval: Packet interval in TUs. Maximum allowed is 20 TU, as mentioned
+ *	in IEEE P802.11ax/D6.0 26.17.2.3.2 - AP behavior for fast passive
+ *	scanning
+ * @tmpl_len: Template length
+ * @tmpl: Template data for probe response
+ */
+struct cfg80211_unsol_bcast_probe_resp {
+	bool enabled;
+	u32 interval;
+	size_t tmpl_len;
+	const u8 *tmpl;
+};
+
 /**
  * enum cfg80211_ap_settings_flags - AP settings flags
  *
@@ -1094,6 +1113,7 @@ enum cfg80211_ap_settings_flags {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1124,6 +1144,7 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dad8c8f8581f..73478f74475b 100644
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
+ * @__NL80211_FILS_DISC_BCAST_PRESP_INVALID: Invalid
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
index 263ae395ad44..1e65638ac10f 100644
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
@@ -4721,6 +4731,40 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
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
+	if (params->chandef.center_freq1 <= 5940 ||
+	    params->chandef.center_freq1 >= 7105)
+		return -EOPNOTSUPP;
+
+	ret = nla_parse_nested(tb, NL80211_UNSOL_BCAST_PROBE_RESP_MAX, attrs,
+			       unsol_bcast_probe_resp_policy, NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_UNSOL_BCAST_PROBE_RESP_INT])
+		return -EINVAL;
+
+	presp->enabled = true;
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
@@ -5027,6 +5071,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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

