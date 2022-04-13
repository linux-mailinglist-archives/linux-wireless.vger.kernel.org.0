Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0124FFB4F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiDMQc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Apr 2022 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiDMQcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Apr 2022 12:32:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C975F4FD
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649867401; x=1681403401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3d7sSqXR+lKNTkwjhyeVnUgM+xlm7UeO9cMwPl8bQ4w=;
  b=CWSPkKL0H3cLrJLVbNU7AFPxhH3GmMRzQvY0vuOgOmFvMbrHT2fFrZwf
   nHCyST0gxEWQ09wdWCUSrM26iyQYdAt5jkf8B+aax/q+E5Yx932bJ2Yst
   1q+x+o0MNKsJZgd0Yuu41vk9LDp50bWWcecvCpfFWJqFtUt/asM/LS5Sf
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 09:30:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:30:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:30:00 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 09:29:58 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v5 1/2] nl80211: Parse NL80211_ATTR_HE_BSS_COLOR as a part of  nl80211_parse_beacon
Date:   Wed, 13 Apr 2022 21:58:14 +0530
Message-ID: <1649867295-7204-2-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649867295-7204-1-git-send-email-quic_ramess@quicinc.com>
References: <1649867295-7204-1-git-send-email-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NL80211_ATTR_HE_BSS_COLOR attribute can be included in both
NL80211_CMD_START_AP and NL80211_CMD_SET_BEACON commands.

Move he_bss_color from cfg80211_ap_settings to cfg80211_beacon_data
and parse NL80211_ATTR_HE_BSS_COLOR as a part of nl80211_parse_beacon()
to have bss color settings parsed for both start ap and set beacon
commands.
Add a new flag he_bss_color_valid to indicate whether
NL80211_ATTR_HE_BSS_COLOR attribute is included.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/net/cfg80211.h |  7 ++++--
 net/wireless/nl80211.c | 64 +++++++++++++++++++++++++-------------------------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d19e48f..8f058b6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1113,6 +1113,9 @@ struct cfg80211_mbssid_elems {
  *	Token (measurement type 11)
  * @lci_len: LCI data length
  * @civicloc_len: Civic location data length
+ * @he_bss_color: BSS Color settings
+ * @he_bss_color_valid: indicates whether bss color
+	attribute is present in beacon data or not.
  */
 struct cfg80211_beacon_data {
 	const u8 *head, *tail;
@@ -1132,6 +1135,8 @@ struct cfg80211_beacon_data {
 	size_t probe_resp_len;
 	size_t lci_len;
 	size_t civicloc_len;
+	struct cfg80211_he_bss_color he_bss_color;
+	bool he_bss_color_valid;
 };
 
 struct mac_address {
@@ -1222,7 +1227,6 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @sae_h2e_required: stations must support direct H2E technique in SAE
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
- * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
@@ -1256,7 +1260,6 @@ struct cfg80211_ap_settings {
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
-	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 578bff9..f5b891f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5125,6 +5125,30 @@ nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
 	return elems;
 }
 
+static int nl80211_parse_he_bss_color(struct nlattr *attrs,
+				      struct cfg80211_he_bss_color *he_bss_color)
+{
+	struct nlattr *tb[NL80211_HE_BSS_COLOR_ATTR_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, NL80211_HE_BSS_COLOR_ATTR_MAX, attrs,
+			       he_bss_color_policy, NULL);
+	if (err)
+		return err;
+
+	if (!tb[NL80211_HE_BSS_COLOR_ATTR_COLOR])
+		return -EINVAL;
+
+	he_bss_color->color =
+		nla_get_u8(tb[NL80211_HE_BSS_COLOR_ATTR_COLOR]);
+	he_bss_color->enabled =
+		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
+	he_bss_color->partial =
+		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
+
+	return 0;
+}
+
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn)
@@ -5205,6 +5229,14 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_HE_BSS_COLOR]) {
+		err = nl80211_parse_he_bss_color(attrs[NL80211_ATTR_HE_BSS_COLOR],
+						 &bcn->he_bss_color);
+		if (err)
+			return err;
+		bcn->he_bss_color_valid = true;
+	}
+
 	if (attrs[NL80211_ATTR_MBSSID_ELEMS]) {
 		struct cfg80211_mbssid_elems *mbssid =
 			nl80211_parse_mbssid_elems(&rdev->wiphy,
@@ -5263,30 +5295,6 @@ static int nl80211_parse_he_obss_pd(struct nlattr *attrs,
 	return 0;
 }
 
-static int nl80211_parse_he_bss_color(struct nlattr *attrs,
-				      struct cfg80211_he_bss_color *he_bss_color)
-{
-	struct nlattr *tb[NL80211_HE_BSS_COLOR_ATTR_MAX + 1];
-	int err;
-
-	err = nla_parse_nested(tb, NL80211_HE_BSS_COLOR_ATTR_MAX, attrs,
-			       he_bss_color_policy, NULL);
-	if (err)
-		return err;
-
-	if (!tb[NL80211_HE_BSS_COLOR_ATTR_COLOR])
-		return -EINVAL;
-
-	he_bss_color->color =
-		nla_get_u8(tb[NL80211_HE_BSS_COLOR_ATTR_COLOR]);
-	he_bss_color->enabled =
-		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
-	he_bss_color->partial =
-		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
-
-	return 0;
-}
-
 static int nl80211_parse_fils_discovery(struct cfg80211_registered_device *rdev,
 					struct nlattr *attrs,
 					struct cfg80211_ap_settings *params)
@@ -5678,14 +5686,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	if (info->attrs[NL80211_ATTR_HE_BSS_COLOR]) {
-		err = nl80211_parse_he_bss_color(
-					info->attrs[NL80211_ATTR_HE_BSS_COLOR],
-					&params->he_bss_color);
-		if (err)
-			goto out;
-	}
-
 	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
 		err = nl80211_parse_fils_discovery(rdev,
 						   info->attrs[NL80211_ATTR_FILS_DISCOVERY],
-- 
2.7.4

