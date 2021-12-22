Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5A47CEBB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbhLVJFo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:05:44 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34949 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239199AbhLVJFn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640163943; x=1671699943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=a50NXRWRzzVYUxVBgRjgm9A++qM8KC6+15UYVkPwD7A=;
  b=CRiUaT6oQsyzsCrvb+rxIzBVBYA6lwEWebvJ9KJ/WeD2r0uTCNuuD2Dl
   GukLuKxj46ctJa8tAIkdepMusiT0hw77LqjdMTOycQ507W6k4KpTxMx9u
   L1fyfBTnyJ5ST7by/KSAW4KvwUKBz+zh8nf8EvirobxJMHySmOemMsdUe
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Dec 2021 01:05:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:05:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:43 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:40 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
Subject: [PATCH 2/6] nl80211: add support to advertise driver's EHT capabilities
Date:   Wed, 22 Dec 2021 14:34:39 +0530
Message-ID: <1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com>
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

Add nl80211 support to advertise EHT capabilities to the userspace.

Add new attributes in enum nl80211_band_iftype_attr to indicate EHT MAC
capabilities, PHY capabilities, supported MCC-NSS set and PPE threshold
fields.

Signed-off-by: Vikram Kandukuri <quic_vikram@quicinc.com>
Co-authored-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-authored-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 56 ++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h | 12 ++++++++++
 net/wireless/nl80211.c       | 17 ++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d19e48f..df197c6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -361,6 +361,28 @@ struct ieee80211_sta_he_cap {
 };
 
 /**
+ * struct ieee80211_sta_eht_cap - STA's EHT capabilities
+ *
+ * This structure describes parameters needed to describe 802.11be EHT
+ * capabilities for a STA.
+ *
+ * @has_eht: true if EHT data is valid.
+ * @eht_cap_elem: Fixed portion of the EHT capabilities element.
+ * @mcs_nss: The supported NSS/MCS combinations.
+ * @mcs_nss_len: Length of NSS/MCS combinations data.
+ * @ppe_thres: Holds the PPE Thresholds data.
+ * @ppe_thres_len: Length PPE Thresholds data.
+ */
+struct ieee80211_sta_eht_cap {
+	bool has_eht;
+	struct ieee80211_eht_cap_elem eht_cap_elem;
+	u8 *mcs_nss;
+	u8 mcs_nss_len;
+	u8 *ppe_thres;
+	u8 ppe_thres_len;
+};
+
+/**
  * struct ieee80211_sband_iftype_data - sband data per interface type
  *
  * This structure encapsulates sband data that is relevant for the
@@ -374,6 +396,7 @@ struct ieee80211_sta_he_cap {
  * @vendor_elems: vendor element(s) to advertise
  * @vendor_elems.data: vendor element(s) data
  * @vendor_elems.len: vendor element(s) length
+ * @eht_cap: holds the EHT capabilities.
  */
 struct ieee80211_sband_iftype_data {
 	u16 types_mask;
@@ -383,6 +406,7 @@ struct ieee80211_sband_iftype_data {
 		const u8 *data;
 		unsigned int len;
 	} vendor_elems;
+	struct ieee80211_sta_eht_cap eht_cap;
 };
 
 /**
@@ -522,6 +546,38 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 }
 
 /**
+ * ieee80211_get_eht_iftype_cap - return EHT capabilities for an sband's iftype
+ * @sband: the sband to search for the iftype on
+ * @iftype: enum nl80211_iftype
+ *
+ * Return: pointer to the struct ieee80211_sta_eht_cap, or NULL is none found
+ */
+static inline const struct ieee80211_sta_eht_cap *
+ieee80211_get_eht_iftype_cap(const struct ieee80211_supported_band *sband,
+			     u8 iftype)
+{
+	const struct ieee80211_sband_iftype_data *data =
+		ieee80211_get_sband_iftype_data(sband, iftype);
+
+	if (data && data->eht_cap.has_eht)
+		return &data->eht_cap;
+
+	return NULL;
+}
+
+/**
+ * ieee80211_get_eht_sta_cap - return EHT capabilities for an sband's STA
+ * @sband: the sband to search for the STA on
+ *
+ * Return: pointer to the struct ieee80211_sta_eht_cap, or NULL is none found
+ */
+static inline const struct ieee80211_sta_eht_cap *
+ieee80211_get_eht_sta_cap(const struct ieee80211_supported_band *sband)
+{
+	return ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_STATION);
+}
+
+/**
  * ieee80211_get_he_iftype_cap - return HE capabilities for an sband's iftype
  * @sband: the sband to search for the iftype on
  * @iftype: enum nl80211_iftype
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f1a9d65..a709f5c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3766,6 +3766,14 @@ enum nl80211_mpath_info {
  *	given for all 6 GHz band channels
  * @NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS: vendor element capabilities that are
  *	advertised on this band/for this iftype (binary)
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC: EHT MAC capabilities as in EHT
+ *     capabilities IE
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY: EHT PHY capabilities as in EHT
+ *     capabilities IE
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET: EHT supported NSS/MCS as in EHT
+ *     capabilities IE
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE: EHT PPE thresholds information as
+ *     defined in EHT capabilities IE
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
  * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band attribute currently defined
  */
@@ -3779,6 +3787,10 @@ enum nl80211_band_iftype_attr {
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
 	NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA,
 	NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET,
+	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE,
 
 	/* keep last */
 	__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 578bff9..0ece4d3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1729,6 +1729,7 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 			 const struct ieee80211_sband_iftype_data *iftdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &iftdata->he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap = &iftdata->eht_cap;
 
 	if (nl80211_put_iftypes(msg, NL80211_BAND_IFTYPE_ATTR_IFTYPES,
 				iftdata->types_mask))
@@ -1755,6 +1756,22 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 		    &iftdata->he_6ghz_capa))
 		return -ENOBUFS;
 
+	if (eht_cap->has_eht) {
+		if (nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC,
+			    sizeof(eht_cap->eht_cap_elem.mac_cap_info),
+			    eht_cap->eht_cap_elem.mac_cap_info) ||
+		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY,
+			    sizeof(eht_cap->eht_cap_elem.phy_cap_info),
+			    eht_cap->eht_cap_elem.phy_cap_info) ||
+		    (eht_cap->mcs_nss_len &&
+		     nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET,
+			     eht_cap->mcs_nss_len, eht_cap->mcs_nss)) ||
+		    (eht_cap->ppe_thres_len &&
+		     nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE,
+			     eht_cap->ppe_thres_len, eht_cap->ppe_thres)))
+			return -ENOBUFS;
+	}
+
 	if (iftdata->vendor_elems.data && iftdata->vendor_elems.len &&
 	    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS,
 		    iftdata->vendor_elems.len, iftdata->vendor_elems.data))
-- 
2.7.4

