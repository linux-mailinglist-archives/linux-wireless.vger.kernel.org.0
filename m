Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9FD47CEBC
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhLVJFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:05:47 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15816 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232940AbhLVJFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640163946; x=1671699946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JQWk4qmhrE5bJfduF1Yzj6Lqav4r9hLGdSjNxk5G45k=;
  b=HkpH2ikIlTf4fWSDd1cxgcgpNJ8sTxklZIU/hnCQnRVAbwEowGTse0r3
   HYIZqTEu4sD4oD9aSR4bV1G5svX/ZXsia2aFsK41tvhnUjM3cabre1oP4
   sj4VFZmnOhJBV2j3KSpkAzDIzIf3RjqDrR6nLbVKCBuo3Bw8quwo4Nu5t
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Dec 2021 01:05:46 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:05:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:45 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:43 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
Subject: [PATCH 3/6] nl80211: add support to send EHT capabilities from userspace
Date:   Wed, 22 Dec 2021 14:34:40 +0530
Message-ID: <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vikram Kandukuri <quic_vikram@quicinc.com>

Add support to process EHT capabilities element passed by the userspace
in beacon template and store the pointer in struct cfg80211_ap_settings.

Add new attribute NL80211_ATTR_EHT_CAPABILITY to be used by the
userspace to pass EHT capabilities of a station trying to associate.

Signed-off-by: Vikram Kandukuri <quic_vikram@quicinc.com>
Co-authored-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-authored-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 29 ++++++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index df197c6..ce34dd7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1271,6 +1271,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @ht_cap: HT capabilities (or %NULL if HT isn't enabled)
  * @vht_cap: VHT capabilities (or %NULL if VHT isn't enabled)
  * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
+ * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
@@ -1308,6 +1309,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_vht_cap *vht_cap;
 	const struct ieee80211_he_cap_elem *he_cap;
 	const struct ieee80211_he_operation *he_oper;
+	const struct ieee80211_eht_cap_elem *eht_cap;
 	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
@@ -1473,6 +1475,8 @@ struct sta_txpwr {
  * @airtime_weight: airtime scheduler weight for this station
  * @txpwr: transmit power for an associated station
  * @he_6ghz_capa: HE 6 GHz Band capabilities of station
+ * @eht_capa: EHT capabilities of station
+ * @eht_capa_len: the length of the EHT capabilities
  */
 struct station_parameters {
 	const u8 *supported_rates;
@@ -1506,6 +1510,8 @@ struct station_parameters {
 	u16 airtime_weight;
 	struct sta_txpwr txpwr;
 	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
+	const struct ieee80211_eht_cap_elem *eht_capa;
+	u8 eht_capa_len;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a709f5c..c221322 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2659,6 +2659,8 @@ enum nl80211_commands {
  *	enumerated in &enum nl80211_ap_settings_flags. This attribute shall be
  *	used with %NL80211_CMD_START_AP request.
  *
+ * @NL80211_ATTR_EHT_CAPABILITY: EHT Capability information element.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3169,6 +3171,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_AP_SETTINGS_FLAGS,
 
+	NL80211_ATTR_EHT_CAPABILITY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3225,6 +3229,9 @@ enum nl80211_attrs {
 #define NL80211_MAX_NR_CIPHER_SUITES		5
 #define NL80211_MAX_NR_AKM_SUITES		2
 
+#define NL80211_EHT_MIN_CAPABILITY_LEN           10
+#define NL80211_EHT_MAX_CAPABILITY_LEN           81
+
 #define NL80211_MIN_REMAIN_ON_CHANNEL_TIME	10
 
 /* default RSSI threshold for scan results if none specified. */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0ece4d3..dba4002 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -778,6 +778,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_RADAR_BACKGROUND] = { .type = NLA_FLAG },
 	[NL80211_ATTR_AP_SETTINGS_FLAGS] = { .type = NLA_U32 },
+	[NL80211_ATTR_EHT_CAPABILITY] =
+		NLA_POLICY_RANGE(NLA_BINARY,
+				 NL80211_EHT_MIN_CAPABILITY_LEN,
+				 NL80211_EHT_MAX_CAPABILITY_LEN),
 };
 
 /* policy for the key attributes */
@@ -5414,6 +5418,9 @@ static void nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
 	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1)
 		params->he_oper = (void *)(cap->data + 1);
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*params->eht_cap) + 1)
+		params->eht_cap = (void *)(cap->data + 1);
 }
 
 static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,
@@ -6382,7 +6389,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		if (params->supported_rates)
 			return -EINVAL;
 		if (params->ext_capab || params->ht_capa || params->vht_capa ||
-		    params->he_capa)
+		    params->he_capa || params->eht_capa)
 			return -EINVAL;
 	}
 
@@ -6567,6 +6574,17 @@ static int nl80211_parse_sta_channel_info(struct genl_info *info,
 	return 0;
 }
 
+static void nl80211_parse_sta_eht_capa(struct genl_info *info,
+				       struct station_parameters *params)
+{
+	if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
+		params->eht_capa =
+			nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+		params->eht_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+	}
+}
+
 static int nl80211_set_station_tdls(struct genl_info *info,
 				    struct station_parameters *params)
 {
@@ -6587,6 +6605,8 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
 	}
 
+	nl80211_parse_sta_eht_capa(info, params);
+
 	err = nl80211_parse_sta_channel_info(info, params);
 	if (err)
 		return err;
@@ -6848,6 +6868,8 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		params.he_6ghz_capa =
 			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
 
+	nl80211_parse_sta_eht_capa(info, &params);
+
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
 		params.opmode_notif_used = true;
 		params.opmode_notif =
@@ -6891,8 +6913,9 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		params.ht_capa = NULL;
 		params.vht_capa = NULL;
 
-		/* HE requires WME */
-		if (params.he_capa_len || params.he_6ghz_capa)
+		/* HE and EHT requires WME */
+		if (params.he_capa_len || params.he_6ghz_capa ||
+		    params.eht_capa_len)
 			return -EINVAL;
 	}
 
-- 
2.7.4

