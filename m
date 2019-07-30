Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5327AE1F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfG3QhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 12:37:25 -0400
Received: from nbd.name ([46.4.11.11]:51042 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfG3QhO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 12:37:14 -0400
Received: from pd95fd7d7.dip0.t-ipconnect.de ([217.95.215.215] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hsV7f-0002JK-6F; Tue, 30 Jul 2019 18:37:11 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V3 1/2] cfg80211: add support for parsing OBBS_PD attributes
Date:   Tue, 30 Jul 2019 18:37:00 +0200
Message-Id: <20190730163701.18836-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730163701.18836-1-john@phrozen.org>
References: <20190730163701.18836-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the data structure, policy and parsing code allowing userland to send
the OBSS PD information into the kernel.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       | 15 ++++++++++++
 include/uapi/linux/nl80211.h | 27 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 45 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 45850a8391d9..35ec1f0a2bf9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -246,6 +246,19 @@ struct ieee80211_rate {
 	u16 hw_value, hw_value_short;
 };
 
+/**
+ * struct ieee80211_he_obss_pd - AP settings for spatial reuse
+ *
+ * @enable: is the feature enabled.
+ * @min_offset: minimal tx power offset an associated station shall use
+ * @max_offset: maximum tx power offset an associated station shall use
+ */
+struct ieee80211_he_obss_pd {
+	bool enable;
+	u8 min_offset;
+	u8 max_offset;
+};
+
 /**
  * struct ieee80211_sta_ht_cap - STA's HT capabilities
  *
@@ -896,6 +909,7 @@ enum cfg80211_ap_settings_flags {
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
+ * @he_obss_pd: OBSS Packet Detection settings
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -923,6 +937,7 @@ struct cfg80211_ap_settings {
 	bool ht_required, vht_required;
 	bool twt_responder;
 	u32 flags;
+	struct ieee80211_he_obss_pd he_obss_pd;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c45587c2cf44..822851d369ab 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2358,6 +2358,9 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_TWT_RESPONDER: Enable target wait time responder support.
  *
+ * @NL80211_ATTR_HE_OBSS_PD: nested attribute for OBSS Packet Detection
+ *	functionality.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2815,6 +2818,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_TWT_RESPONDER,
 
+	NL80211_ATTR_HE_OBSS_PD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6490,4 +6495,26 @@ enum nl80211_peer_measurement_ftm_resp {
 	NL80211_PMSR_FTM_RESP_ATTR_MAX = NUM_NL80211_PMSR_FTM_RESP_ATTR - 1
 };
 
+/**
+ * enum nl80211_obss_pd_attributes - OBSS packet detection attributes
+ * @__NL80211_HE_OBSS_PD_ATTR_INVALID: Invalid
+ *
+ * @NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET: the OBSS PD minimum tx power offset.
+ * @NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET: the OBSS PD maximum tx power offset.
+ *
+ * @__NL80211_HE_OBSS_PD_ATTR_LAST: Internal
+ * @NL80211_HE_OBSS_PD_ATTR_MAX: highest OBSS PD attribute.
+ */
+enum nl80211_obss_pd_attributes {
+	__NL80211_HE_OBSS_PD_ATTR_INVALID,
+
+	NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET,
+	NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET,
+
+	/* keep last */
+	__NL80211_HE_OBSS_PD_ATTR_LAST,
+	NL80211_HE_OBSS_PD_ATTR_MAX = __NL80211_HE_OBSS_PD_ATTR_LAST - 1,
+};
+
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 08a66c1bcb83..488d89c773d7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -281,6 +281,14 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 		NLA_POLICY_NESTED_ARRAY(nl80211_psmr_peer_attr_policy),
 };
 
+static const struct nla_policy
+he_obss_pd_policy[NL80211_HE_OBSS_PD_ATTR_MAX + 1] = {
+	[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET] =
+		NLA_POLICY_RANGE(NLA_U8, 1, 20),
+	[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET] =
+		NLA_POLICY_RANGE(NLA_U8, 1, 20),
+};
+
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
 	[NL80211_ATTR_WIPHY_NAME] = { .type = NLA_NUL_STRING,
@@ -574,6 +582,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SAE_PASSWORD] = { .type = NLA_BINARY,
 					.len = SAE_PASSWORD_MAX_LEN },
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
+	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
 };
 
 /* policy for the key attributes */
@@ -4385,6 +4394,34 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int nl80211_parse_he_obss_pd(struct nlattr *attrs,
+				    struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct nlattr *tb[NL80211_HE_OBSS_PD_ATTR_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, NL80211_HE_OBSS_PD_ATTR_MAX, attrs,
+			       he_obss_pd_policy, NULL);
+	if (err)
+		return err;
+
+	if (!tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET] ||
+	    !tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET])
+		return -EINVAL;
+
+	he_obss_pd->min_offset =
+		nla_get_u32(tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET]);
+	he_obss_pd->max_offset =
+		nla_get_u32(tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET]);
+
+	if (he_obss_pd->min_offset >= he_obss_pd->max_offset)
+		return -EINVAL;
+
+	he_obss_pd->enable = true;
+
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -4669,6 +4706,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	params.twt_responder =
 		    nla_get_flag(info->attrs[NL80211_ATTR_TWT_RESPONDER]);
 
+	if (info->attrs[NL80211_ATTR_HE_OBSS_PD]) {
+		err = nl80211_parse_he_obss_pd(
+					info->attrs[NL80211_ATTR_HE_OBSS_PD],
+					&params.he_obss_pd);
+		if (err)
+			return err;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.20.1

