Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7096B1EB313
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 03:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgFBBjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 21:39:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46639 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgFBBjS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 21:39:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591061957; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4zXBhDflwRoBoTj0aZwM/raft6g73OxKckE/uNXKmBE=; b=iuRhtKBZYafI3lE21XtV2ossDGrk8HbzyGWFWXO28up5wUewkzZupY2Xle1Qt6dbrQ35m9WS
 FqeZXe8oYTBF+567RZAkMUxxh7eEd1fIYtg3Sn8ef+JvCMDa2k9x46HZ1heETNK2mOdf5clj
 S3HcWPn54RvnmQ62lZX8O7mMvys=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ed5adaeb65440fdbae6f6f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 01:38:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5AE27C43391; Tue,  2 Jun 2020 01:38:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CD45C433CB;
        Tue,  2 Jun 2020 01:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CD45C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v3 1/2] nl80211: Add FILS discovery support
Date:   Mon,  1 Jun 2020 18:38:43 -0700
Message-Id: <20200602013844.26275-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200602013844.26275-1-alokad@codeaurora.org>
References: <20200602013844.26275-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds new attributes to support FILS discovery transmission.

FILS discovery attribute, NL80211_ATTR_FILS_DISCOVERY, is nested which
supports following parameters (IEEE Std 802.11ai-2016, Annex C.3 MIB
detail):
(1) NL80211_FILS_DISCOVERY_INT_MIN - Minimum packet interval
(2) NL80211_FILS_DISCOVERY_INT_MAX - Maximum packet interval
(3) NL80211_FILS_DISCOVERY_BCN_RESP_WIN - Beacon response window
(4) NL80211_FILS_DISCOVERY_OMIT_REPLICATE_PROBE_RESP - Send single
broadcast probe response for multiple probe requests.
(5) NL80211_FILS_DISCOVERY_TMPL - Template data (optional)

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v3: Only FILS discovery related implementation

v2: FILS discovery and bcast probe resp support

 include/net/cfg80211.h       | 25 ++++++++++++++++
 include/uapi/linux/nl80211.h | 46 +++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 57 ++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b58ad1a3f695..8993bb9f93b3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1047,6 +1047,29 @@ struct cfg80211_acl_data {
 	struct mac_address mac_addrs[];
 };
 
+/**
+ * struct cfg80211_fils_discovery - FILS discovery parameters from
+ * IEEE Std 802.11ai-2016, Annex C.3 MIB detail.
+ *
+ * @enabled: Set to true if FILS discovery transmission is enabled
+ * @min_interval: Minimum packet interval in TUs (0 - 10000)
+ * @max_interval: Maximum packet interval in TUs (0 - 10000)
+ * @bcn_resp_win: Beacon response window in unit of 0.1 msec (0 - 1000000)
+ * @omit_replicate_probe_resp: Omit replicate_probe_response
+ * @tmpl_len: Template length
+ * @tmpl: Template data from IEEE Std 802.11ai-2016 9.6.8.36 FILS discovery
+ *	frame (Figure 9-687a).
+ */
+struct cfg80211_fils_discovery {
+	bool enabled;
+	u32 min_interval;
+	u32 max_interval;
+	u32 bcn_resp_win;
+	bool omit_replicate_probe_resp;
+	size_t tmpl_len;
+	const u8 *tmpl;
+};
+
 /**
  * enum cfg80211_ap_settings_flags - AP settings flags
  *
@@ -1094,6 +1117,7 @@ enum cfg80211_ap_settings_flags {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @fils_discovery: FILS discovery transmission parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1124,6 +1148,7 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct cfg80211_fils_discovery fils_discovery;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dad8c8f8581f..a5dad7a27acc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2505,6 +2505,10 @@ enum nl80211_commands {
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
@@ -2987,6 +2991,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_FILS_DISCOVERY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6922,4 +6928,44 @@ enum nl80211_iftype_akm_attributes {
 	NL80211_IFTYPE_AKM_ATTR_MAX = __NL80211_IFTYPE_AKM_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_fils_discovery_attributes - FILS discovery configuration
+ * from IEEE Std 802.11ai-2016, Annex C.3 MIB detail.
+ *
+ * @__NL80211_FILS_DISCOVERY_INVALID: Invalid
+ *
+ * @NL80211_FILS_DISCOVERY_INT_MIN: Minimum packet interval (u32, TU).
+ *	Allowed range: 0..10000 (TU = Time Unit)
+ * @NL80211_FILS_DISCOVERY_INT_MAX: Maximum packet interval (u32, TU).
+ *	Allowed range: 0..10000 (TU = Time Unit)
+ * @NL80211_FILS_DISCOVERY_BCN_RESP_WIN: Beacon response window (u32, 0.1 msec)
+ *	Allowed range: 0..1000000
+ *	Device doesn't respond to a probe request if the duration until next
+ *	TBTT is less than this value.
+ * @NL80211_FILS_DISCOVERY_OMIT_REPLICATE_PROBE_RESP: Omit replicated probe
+ *	responses (flag).
+ *	If set to true, the device may send a single broadcast probe response
+ *	for one or more probe requests instead of individual responses.
+ * @NL80211_FILS_DISCOVERY_TMPL: Optional FILS discovery template.
+ *	It has contents of IEEE Std 802.11ai-2016 9.6.8.36 FILS discovery frame
+ *	(Figure 9-687a).
+ *	It may include 6GHz specific data specified in IEEE P802.11ax/D6.0,
+ *	9.6.7.36 FILS Discovery frame format.
+ *
+ * @__NL80211_FILS_DISCOVERY_LAST: Internal
+ * @NL80211_FILS_DISCOVERY_MAX: highest attribute
+ */
+enum nl80211_fils_discovery_attributes {
+	__NL80211_FILS_DISCOVERY_INVALID,
+
+	NL80211_FILS_DISCOVERY_INT_MIN,
+	NL80211_FILS_DISCOVERY_INT_MAX,
+	NL80211_FILS_DISCOVERY_BCN_RESP_WIN,
+	NL80211_FILS_DISCOVERY_OMIT_REPLICATE_PROBE_RESP,
+	NL80211_FILS_DISCOVERY_TMPL,
+
+	/* keep last */
+	__NL80211_FILS_DISCOVERY_LAST,
+	NL80211_FILS_DISCOVERY_MAX = __NL80211_FILS_DISCOVERY_LAST - 1
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263ae395ad44..04f50ea67f25 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -360,6 +360,16 @@ nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
+static const struct nla_policy
+fils_discovery_policy[NL80211_FILS_DISCOVERY_MAX + 1] = {
+	[NL80211_FILS_DISCOVERY_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
+	[NL80211_FILS_DISCOVERY_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
+	[NL80211_FILS_DISCOVERY_BCN_RESP_WIN] = { .type = NLA_U32 },
+	[NL80211_FILS_DISCOVERY_OMIT_REPLICATE_PROBE_RESP] = { .type = NLA_FLAG },
+	[NL80211_FILS_DISCOVERY_TMPL] = { .type = NLA_BINARY,
+					  .len = IEEE80211_MAX_DATA_LEN }
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -658,6 +668,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		.type = NLA_EXACT_LEN,
 		.len = sizeof(struct ieee80211_he_6ghz_capa),
 	},
+	[NL80211_ATTR_FILS_DISCOVERY] =
+		NLA_POLICY_NESTED(fils_discovery_policy),
 };
 
 /* policy for the key attributes */
@@ -4721,6 +4733,44 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 	return 0;
 }
 
+static int nl80211_parse_fils_discovery(struct nlattr *attrs,
+					struct cfg80211_ap_settings *params)
+{
+	struct nlattr *tmpl;
+	struct nlattr *tb[NL80211_FILS_DISCOVERY_MAX + 1];
+	int ret;
+	struct cfg80211_fils_discovery *fd = &params->fils_discovery;
+
+	ret = nla_parse_nested(tb, NL80211_FILS_DISCOVERY_MAX, attrs,
+			       fils_discovery_policy, NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_FILS_DISCOVERY_INT_MIN] ||
+	    !tb[NL80211_FILS_DISCOVERY_INT_MAX] ||
+	    !tb[NL80211_FILS_DISCOVERY_BCN_RESP_WIN])
+		return -EINVAL;
+
+	fd->enabled = true;
+	fd->min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MIN]);
+	fd->max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MAX]);
+	fd->bcn_resp_win =
+		nla_get_u32(tb[NL80211_FILS_DISCOVERY_BCN_RESP_WIN]);
+	if (fd->bcn_resp_win > 1000000)
+		fd->bcn_resp_win = 1000000;
+
+	fd->omit_replicate_probe_resp =
+		nla_get_flag(tb[NL80211_FILS_DISCOVERY_OMIT_REPLICATE_PROBE_RESP]);
+
+	tmpl = tb[NL80211_FILS_DISCOVERY_TMPL];
+	if (tmpl) {
+		fd->tmpl = nla_data(tmpl);
+		fd->tmpl_len = nla_len(tmpl);
+	}
+
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -5027,6 +5077,13 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
+		err = nl80211_parse_fils_discovery(info->attrs[NL80211_ATTR_FILS_DISCOVERY],
+						   &params);
+		if (err)
+			return err;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.25.0

