Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012681FEA98
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 07:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFRFEx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 01:04:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38321 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgFRFEw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 01:04:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592456691; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=p86uOtmgyzQXHZ2+Qvj7snJljAtpA9gqL2vl3z5VGOo=; b=uK77w1y3j7McHxAALqzymcYQhMawzEqtJqJ4vLRJyX0kyW4wPKJ77/h7DCmz86LiU+PwZsL4
 ROeOMql39GftfyVLjB2SMo04K0zVAcfVd/3zyV+5VJ7EfpHhwKNwThXwoNTmVkLtb1wwgvW9
 KH6AFC7YY68GQKMhZQ458QHHWVA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5eeaf5e3fe1db4db8948c221 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 05:04:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B69CAC433CB; Thu, 18 Jun 2020 05:04:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0AF6C433CA;
        Thu, 18 Jun 2020 05:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0AF6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v4 1/2] nl80211: Add FILS discovery support
Date:   Wed, 17 Jun 2020 22:04:26 -0700
Message-Id: <20200618050427.5891-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200618050427.5891-1-alokad@codeaurora.org>
References: <20200618050427.5891-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery attribute, NL80211_ATTR_FILS_DISCOVERY, is nested which
supports following parameters (IEEE Std 802.11ai-2016, Annex C.3 MIB
detail):
(1) NL80211_FILS_DISCOVERY_INT_MIN - Minimum packet interval
(2) NL80211_FILS_DISCOVERY_INT_MAX - Maximum packet interval
(3) NL0211_FILS_DISCOVERY_TMPL - Template data

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v4: Removed attributes unrelated to FILS discovery -
    NL80211_FILS_DISCOVERY_BCN_RESP_WIN, 
    NL80211_FILS_DISCOVERY_OMIT_REPLICATE_PROBE_RESP and
    member named enabled in struct cfg80211_fils_discovery.

 include/net/cfg80211.h       | 19 +++++++++++++++
 include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 46 ++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc7e8807838d..64d47463155a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1047,6 +1047,23 @@ struct cfg80211_acl_data {
 	struct mac_address mac_addrs[];
 };
 
+/**
+ * struct cfg80211_fils_discovery - FILS discovery parameters from
+ * IEEE Std 802.11ai-2016, Annex C.3 MIB detail.
+ *
+ * @min_interval: Minimum packet interval in TUs (0 - 10000)
+ * @max_interval: Maximum packet interval in TUs (0 - 10000)
+ * @tmpl_len: Template length
+ * @tmpl: Template data from IEEE Std 802.11ai-2016 9.6.8.36 FILS discovery
+ *	frame (Figure 9-687a).
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
@@ -1094,6 +1111,7 @@ enum cfg80211_ap_settings_flags {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @fils_discovery: FILS discovery transmission parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1124,6 +1142,7 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct cfg80211_fils_discovery fils_discovery;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4e6339ab1fce..adab79c0f907 100644
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
@@ -6922,4 +6928,34 @@ enum nl80211_iftype_akm_attributes {
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
+	NL80211_FILS_DISCOVERY_TMPL,
+
+	/* keep last */
+	__NL80211_FILS_DISCOVERY_LAST,
+	NL80211_FILS_DISCOVERY_MAX = __NL80211_FILS_DISCOVERY_LAST - 1
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263ae395ad44..89f787dc2421 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -360,6 +360,14 @@ nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
+static const struct nla_policy
+fils_discovery_policy[NL80211_FILS_DISCOVERY_MAX + 1] = {
+	[NL80211_FILS_DISCOVERY_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
+	[NL80211_FILS_DISCOVERY_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
+	[NL80211_FILS_DISCOVERY_TMPL] = { .type = NLA_BINARY,
+					  .len = IEEE80211_MAX_DATA_LEN }
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -658,6 +666,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		.type = NLA_EXACT_LEN,
 		.len = sizeof(struct ieee80211_he_6ghz_capa),
 	},
+	[NL80211_ATTR_FILS_DISCOVERY] =
+		NLA_POLICY_NESTED(fils_discovery_policy),
 };
 
 /* policy for the key attributes */
@@ -4721,6 +4731,35 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
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
+	    !tb[NL80211_FILS_DISCOVERY_INT_MAX])
+		return -EINVAL;
+
+	fd->min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MIN]);
+	fd->max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MAX]);
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
@@ -5027,6 +5066,13 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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

