Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15D4719C0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Dec 2021 12:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhLLLL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Dec 2021 06:11:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38106 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhLLLLz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Dec 2021 06:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639307515; x=1670843515;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=jHaY9LjC9B2Vc0MzXoJfKnWsc4mjAXv7uC/sl1d6CY8=;
  b=EgCiokqAT2O54VRCGb5RMLbRmd0WfdemJjJ7Vt9VaxnP+6acZZylNaZs
   RTgq0BSKHiRMHWlV2veFN22HWSaJhh357cuwNqLdPn0HfLRyIUhnEe0aK
   2TSxUv/jlhh34iKwccgFPn5CirU1h5YDqBA2rx19tcoxIgp43Ixz4teXc
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Dec 2021 03:11:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 03:11:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 12 Dec 2021 03:11:54 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 12 Dec 2021 03:11:52 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2] mac80211: disable BSS color collision detection in case of no free colors
Date:   Sun, 12 Dec 2021 16:41:23 +0530
Message-ID: <1639307483-8055-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lavanya Suresh <lavaks@codeaurora.org>

AP may run out of BSS color after color collision
detection event from driver.
Disable BSS color collision detection if no free colors are available
based on bss color disabled bit of he_oper_params in beacon.
It can be reenabled once new color is available.

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
Changes since v1:
 - Relocated ap params to cfg80211_beacon_data and 
   nl80211_calculate_ap_params() to nl80211_parse_beacon()
   to have them parsed for all (start_ap and change beacon) commands.
---
 include/net/cfg80211.h |  28 +++++++------
 net/mac80211/cfg.c     |  16 ++++++--
 net/wireless/nl80211.c | 109 ++++++++++++++++++++++++-------------------------
 3 files changed, 82 insertions(+), 71 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a887086..fc17c9d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1113,7 +1113,16 @@ struct cfg80211_mbssid_elems {
  *	Token (measurement type 11)
  * @lci_len: LCI data length
  * @civicloc_len: Civic location data length
+ * @ht_cap: HT capabilities (or %NULL if HT isn't enabled)
+ * @vht_cap: VHT capabilities (or %NULL if VHT isn't enabled)
+ * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
+ * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @ht_required: stations must support HT
+ * @vht_required: stations must support VHT
+ * @he_required: stations must support HE
+ * @sae_h2e_required: stations must support direct H2E technique in SAE
  */
+
 struct cfg80211_beacon_data {
 	const u8 *head, *tail;
 	const u8 *beacon_ies;
@@ -1132,6 +1141,12 @@ struct cfg80211_beacon_data {
 	size_t probe_resp_len;
 	size_t lci_len;
 	size_t civicloc_len;
+
+	const struct ieee80211_ht_cap *ht_cap;
+	const struct ieee80211_vht_cap *vht_cap;
+	const struct ieee80211_he_cap_elem *he_cap;
+	const struct ieee80211_he_operation *he_oper;
+	bool ht_required, vht_required, he_required, sae_h2e_required;
 };
 
 struct mac_address {
@@ -1223,18 +1238,10 @@ enum cfg80211_ap_settings_flags {
  * @pbss: If set, start as a PCP instead of AP. Relevant for DMG
  *	networks.
  * @beacon_rate: bitrate to be used for beacons
- * @ht_cap: HT capabilities (or %NULL if HT isn't enabled)
- * @vht_cap: VHT capabilities (or %NULL if VHT isn't enabled)
- * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
- * @ht_required: stations must support HT
- * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
- * @he_required: stations must support HE
- * @sae_h2e_required: stations must support direct H2E technique in SAE
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
- * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
@@ -1259,11 +1266,6 @@ struct cfg80211_ap_settings {
 	bool pbss;
 	struct cfg80211_bitrate_mask beacon_rate;
 
-	const struct ieee80211_ht_cap *ht_cap;
-	const struct ieee80211_vht_cap *vht_cap;
-	const struct ieee80211_he_cap_elem *he_cap;
-	const struct ieee80211_he_operation *he_oper;
-	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 26cc762..bc99be0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -997,6 +997,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
 	int size, err;
+	bool bss_clr_enabled;
 	u32 changed = BSS_CHANGED_BEACON;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1084,6 +1085,15 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
 
+	if (params->he_cap && params->he_oper) {
+		bss_clr_enabled = !le32_get_bits(params->he_oper->he_oper_params,
+						 IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+		if (sdata->vif.bss_conf.he_bss_color.enabled != bss_clr_enabled) {
+			sdata->vif.bss_conf.he_bss_color.enabled = bss_clr_enabled;
+			changed |= BSS_CHANGED_HE_BSS_COLOR;
+		}
+	}
+
 	rcu_assign_pointer(sdata->u.ap.beacon, new);
 
 	if (old)
@@ -1123,13 +1133,13 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	prev_beacon_int = sdata->vif.bss_conf.beacon_int;
 	sdata->vif.bss_conf.beacon_int = params->beacon_interval;
 
-	if (params->he_cap && params->he_oper) {
+	if (params->beacon.he_cap && params->beacon.he_oper) {
 		sdata->vif.bss_conf.he_support = true;
 		sdata->vif.bss_conf.htc_trig_based_pkt_ext =
-			le32_get_bits(params->he_oper->he_oper_params,
+			le32_get_bits(params->beacon.he_oper->he_oper_params,
 			      IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK);
 		sdata->vif.bss_conf.frame_time_rts_th =
-			le32_get_bits(params->he_oper->he_oper_params,
+			le32_get_bits(params->beacon.he_oper->he_oper_params,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 		changed |= BSS_CHANGED_HE_OBSS_PD;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bfa5d74..3881219 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5124,6 +5124,58 @@ nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
 	return elems;
 }
 
+static void nl80211_check_ap_rate_selectors(struct cfg80211_beacon_data *bcn,
+					    const struct element *rates)
+{
+	int i;
+
+	if (!rates)
+		return;
+
+	for (i = 0; i < rates->datalen; i++) {
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HT_PHY)
+			bcn->ht_required = true;
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
+			bcn->vht_required = true;
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
+			bcn->he_required = true;
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
+			bcn->sae_h2e_required = true;
+	}
+}
+
+/*
+ * Since the nl80211 API didn't include, from the beginning, attributes about
+ * HT/VHT requirements/capabilities, we parse them out of the IEs for the
+ * benefit of drivers that rebuild IEs in the firmware.
+ */
+static void nl80211_calculate_ap_params(struct cfg80211_beacon_data *bcn)
+{
+	size_t ies_len = bcn->tail_len;
+	const u8 *ies = bcn->tail;
+	const struct element *rates;
+	const struct element *cap;
+
+	rates = cfg80211_find_elem(WLAN_EID_SUPP_RATES, ies, ies_len);
+	nl80211_check_ap_rate_selectors(bcn, rates);
+
+	rates = cfg80211_find_elem(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
+	nl80211_check_ap_rate_selectors(bcn, rates);
+
+	cap = cfg80211_find_elem(WLAN_EID_HT_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*bcn->ht_cap))
+		bcn->ht_cap = (void *)cap->data;
+	cap = cfg80211_find_elem(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*bcn->vht_cap))
+		bcn->vht_cap = (void *)cap->data;
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*bcn->he_cap) + 1)
+		bcn->he_cap = (void *)(cap->data + 1);
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*bcn->he_oper) + 1)
+		bcn->he_oper = (void *)(cap->data + 1);
+}
+
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn)
@@ -5215,6 +5267,8 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->mbssid_ies = mbssid;
 	}
 
+	nl80211_calculate_ap_params(bcn);
+
 	return 0;
 }
 
@@ -5345,59 +5399,6 @@ nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
-static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
-					    const struct element *rates)
-{
-	int i;
-
-	if (!rates)
-		return;
-
-	for (i = 0; i < rates->datalen; i++) {
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HT_PHY)
-			params->ht_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
-			params->vht_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
-			params->he_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
-			params->sae_h2e_required = true;
-	}
-}
-
-/*
- * Since the nl80211 API didn't include, from the beginning, attributes about
- * HT/VHT requirements/capabilities, we parse them out of the IEs for the
- * benefit of drivers that rebuild IEs in the firmware.
- */
-static void nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
-{
-	const struct cfg80211_beacon_data *bcn = &params->beacon;
-	size_t ies_len = bcn->tail_len;
-	const u8 *ies = bcn->tail;
-	const struct element *rates;
-	const struct element *cap;
-
-	rates = cfg80211_find_elem(WLAN_EID_SUPP_RATES, ies, ies_len);
-	nl80211_check_ap_rate_selectors(params, rates);
-
-	rates = cfg80211_find_elem(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
-	nl80211_check_ap_rate_selectors(params, rates);
-
-	cap = cfg80211_find_elem(WLAN_EID_HT_CAPABILITY, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->ht_cap))
-		params->ht_cap = (void *)cap->data;
-	cap = cfg80211_find_elem(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->vht_cap))
-		params->vht_cap = (void *)cap->data;
-	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->he_cap) + 1)
-		params->he_cap = (void *)(cap->data + 1);
-	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1)
-		params->he_oper = (void *)(cap->data + 1);
-}
-
 static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,
 				   struct cfg80211_ap_settings *params)
 {
@@ -5712,8 +5713,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	nl80211_calculate_ap_params(params);
-
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
 		params->flags |= AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
 
-- 
2.7.4

