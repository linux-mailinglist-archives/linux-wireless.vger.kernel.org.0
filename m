Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFCC11E729
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfLMP6O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from nbd.name ([46.4.11.11]:56206 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbfLMP6N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:58:13 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifnKT-00073u-Mc; Fri, 13 Dec 2019 16:58:09 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 2/7] nl80211: add handling for BSS color
Date:   Fri, 13 Dec 2019 16:57:57 +0100
Message-Id: <20191213155802.25491-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213155802.25491-1-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds the attributes, policy and parsing code to allow userland
to send the info about the BSS coloring settings to the kernel.

Signed-off-by: John Crispin <john@phrozen.org>

Changes in V2
* fix a copy paste error
---
 include/uapi/linux/nl80211.h | 27 ++++++++++++++++++++++++
 net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 822851d369ab..12a97d2c43b8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2361,6 +2361,8 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_OBSS_PD: nested attribute for OBSS Packet Detection
  *	functionality.
  *
+ * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2820,6 +2822,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_OBSS_PD,
 
+	NL80211_ATTR_HE_BSS_COLOR,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6516,5 +6520,28 @@ enum nl80211_obss_pd_attributes {
 	NL80211_HE_OBSS_PD_ATTR_MAX = __NL80211_HE_OBSS_PD_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_bss_color_attributes - BSS Color attributes
+ * @__NL80211_HE_BSS_COLOR_ATTR_INVALID: Invalid
+ *
+ * @NL80211_HE_BSS_COLOR: the current BSS Color.
+ * @NL80211_HE_BSS_COLOR_DISABLED: is BSS coloring disabled.
+ * @NL80211_HE_BSS_COLOR_PARTIAL: the AID equation to be used..
+ *
+ * @__NL80211_HE_BSS_COLOR_ATTR_LAST: Internal
+ * @NL80211_HE_BSS_COLOR_ATTR_MAX: highest BSS Color attribute.
+ */
+enum nl80211_bss_color_attributes {
+	__NL80211_HE_BSS_COLOR_ATTR_INVALID,
+
+	NL80211_HE_BSS_COLOR,
+	NL80211_HE_BSS_COLOR_DISABLED,
+	NL80211_HE_BSS_COLOR_PARTIAL,
+
+	/* keep last */
+	__NL80211_HE_BSS_COLOR_ATTR_LAST,
+	NL80211_HE_BSS_COLOR_ATTR_MAX = __NL80211_HE_BSS_COLOR_ATTR_LAST - 1,
+};
+
 
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 92e06482563c..46040083abe8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -289,6 +289,13 @@ he_obss_pd_policy[NL80211_HE_OBSS_PD_ATTR_MAX + 1] = {
 		NLA_POLICY_RANGE(NLA_U8, 1, 20),
 };
 
+static const struct nla_policy
+he_bss_color_policy[NL80211_HE_BSS_COLOR_ATTR_MAX + 1] = {
+	[NL80211_HE_BSS_COLOR] = NLA_POLICY_RANGE(NLA_U8, 1, 63),
+	[NL80211_HE_BSS_COLOR_DISABLED] = { .type = NLA_FLAG },
+	[NL80211_HE_BSS_COLOR_PARTIAL] = { .type = NLA_FLAG },
+};
+
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -584,6 +591,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 					.len = SAE_PASSWORD_MAX_LEN },
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
+	[NL80211_ATTR_HE_BSS_COLOR] = NLA_POLICY_NESTED(he_bss_color_policy),
 };
 
 /* policy for the key attributes */
@@ -4441,6 +4449,30 @@ static int nl80211_parse_he_obss_pd(struct nlattr *attrs,
 	return 0;
 }
 
+static int nl80211_parse_he_bss_color(struct nlattr *attrs,
+				      struct ieee80211_he_bss_color *he_bss_color)
+{
+	struct nlattr *tb[NL80211_HE_BSS_COLOR_ATTR_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, NL80211_HE_BSS_COLOR_ATTR_MAX, attrs,
+			       he_bss_color_policy, NULL);
+	if (err)
+		return err;
+
+	if (!tb[NL80211_HE_BSS_COLOR])
+		return -EINVAL;
+
+	he_bss_color->color =
+		nla_get_u8(tb[NL80211_HE_BSS_COLOR]);
+	he_bss_color->disabled =
+		nla_get_flag(tb[NL80211_HE_BSS_COLOR_DISABLED]);
+	he_bss_color->partial =
+		nla_get_flag(tb[NL80211_HE_BSS_COLOR_PARTIAL]);
+
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -4733,6 +4765,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_BSS_COLOR]) {
+		err = nl80211_parse_he_bss_color(
+					info->attrs[NL80211_ATTR_HE_BSS_COLOR],
+					&params.he_bss_color);
+		if (err)
+			return err;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.20.1

