Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165B44ADA9C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377242AbiBHN7j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 08:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358099AbiBHN7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 08:59:37 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39128C03FED0
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644328776; x=1675864776;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=M9ATjSJmEGTp42eun2RmlvHpcdlpPgizBFCj+tSH3d8=;
  b=WXPQ3ff7rdBMmKyu1DYt69pSGOA60Pv6gpO/mloVwDDim+YRcaHCN76a
   B+HqUqZfPgLrsha6AnKXUUwnRXsjcCVMYPPCfVAhnqjZ9PpLW8kuyYcdW
   MJ9Na1kNiwqE1r01QjbrwEPD+VAjTSXdUkDG7abprIXGCV+wxJNq0fj1M
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 05:59:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 05:59:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 05:59:35 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 05:59:33 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCHv3] mac80211: disable BSS color collision detection in case of no free colors
Date:   Tue, 8 Feb 2022 19:29:00 +0530
Message-ID: <1644328740-31938-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

From: Lavanya Suresh <lavaks@codeaurora.org>

AP may run out of BSS color after color collision
detection event from driver.
Disable BSS color collision detection if no free colors are
available based on bss color disabled bit sent as a part of
NL80211_ATTR_HE_BSS_COLOR attribute sent in
NL80211_CMD_SET_BEACON.

It can be reenabled once new color is available.

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
Changes since v1:
 - Moved the logic to ieee80211_change_beacon() to have this
   BSS color enabled unset only during set_beacon case based
   on NL80211_ATTR_HE_BSS_COLOR attribute sent by hostapd.
 - Removed the relocation and parsing changes done on v1 and moved
   he_bss_color to cfg80211_beacon_data and parsed
   NL80211_ATTR_HE_BSS_COLOR in nl80211_parse_beacon()

Changes since v1:
 - Relocated ap params to cfg80211_beacon_data and
   nl80211_calculate_ap_params() to nl80211_parse_beacon()
   to have them parsed for all (start_ap and change beacon) commands.
---
 include/net/cfg80211.h |  4 ++--
 net/mac80211/cfg.c     | 11 +++++++--
 net/wireless/nl80211.c | 62 ++++++++++++++++++++++++--------------------------
 3 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a887086..08b795d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1113,6 +1113,7 @@ struct cfg80211_mbssid_elems {
  *	Token (measurement type 11)
  * @lci_len: LCI data length
  * @civicloc_len: Civic location data length
+ * @he_bss_color: BSS Color settings
  */
 struct cfg80211_beacon_data {
 	const u8 *head, *tail;
@@ -1132,6 +1133,7 @@ struct cfg80211_beacon_data {
 	size_t probe_resp_len;
 	size_t lci_len;
 	size_t civicloc_len;
+	struct cfg80211_he_bss_color he_bss_color;
 };
 
 struct mac_address {
@@ -1233,7 +1235,6 @@ enum cfg80211_ap_settings_flags {
  * @sae_h2e_required: stations must support direct H2E technique in SAE
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
- * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
@@ -1267,7 +1268,6 @@ struct cfg80211_ap_settings {
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
-	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 26cc762..f54aaf1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1133,7 +1133,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 		changed |= BSS_CHANGED_HE_OBSS_PD;
 
-		if (params->he_bss_color.enabled)
+		if (params->beacon.he_bss_color.enabled)
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
@@ -1190,7 +1190,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.allow_p2p_go_ps = sdata->vif.p2p;
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
 	sdata->vif.bss_conf.he_obss_pd = params->he_obss_pd;
-	sdata->vif.bss_conf.he_bss_color = params->he_bss_color;
+	sdata->vif.bss_conf.he_bss_color = params->beacon.he_bss_color;
 	sdata->vif.bss_conf.s1g = params->chandef.chan->band ==
 				  NL80211_BAND_S1GHZ;
 
@@ -1272,6 +1272,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 				   struct cfg80211_beacon_data *params)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_bss_conf *bss_conf;
 	struct beacon_data *old;
 	int err;
 
@@ -1291,6 +1292,12 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	err = ieee80211_assign_beacon(sdata, params, NULL, NULL);
 	if (err < 0)
 		return err;
+
+	bss_conf = &sdata->vif.bss_conf;
+	if (params->he_bss_color.enabled != bss_conf->he_bss_color.enabled) {
+		bss_conf->he_bss_color.enabled = params->he_bss_color.enabled;
+		err |= BSS_CHANGED_HE_BSS_COLOR;
+	}
 	ieee80211_bss_info_change_notify(sdata, err);
 	return 0;
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bfa5d74..df609e4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5124,6 +5124,30 @@ nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
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
@@ -5204,6 +5228,12 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_HE_BSS_COLOR]) {
+		err = nl80211_parse_he_bss_color(attrs[NL80211_ATTR_HE_BSS_COLOR],
+						 &bcn->he_bss_color);
+		if (err)
+			return err;
+	}
 	if (attrs[NL80211_ATTR_MBSSID_ELEMS]) {
 		struct cfg80211_mbssid_elems *mbssid =
 			nl80211_parse_mbssid_elems(&rdev->wiphy,
@@ -5262,30 +5292,6 @@ static int nl80211_parse_he_obss_pd(struct nlattr *attrs,
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
@@ -5677,14 +5683,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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

