Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5C4B1629
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbiBJTU1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:20:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343892AbiBJTUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57775115A
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9rnbyTQijG1mfvn6lDu1sv2VoX658cbxQFen4t9eaB4=;
        t=1644520822; x=1645730422; b=rjsBaU7SvjANeGfzumgzLMhq1H/L28OSHTxdpAHjQBgUtla
        NaWCwMnbr+obyW8eNjUX7a7oY1iP9ZRc+vsDNVsXtVYAWQTdmeUicRIuDFizdp+3vTNtQlihJB5Rk
        GrisKqJP+K0nafJQKwagn1lNua5/GTxGlUOfeyr35ipfYFO1fCnPlULTlVGbTFWjllAF5EpN7LuVJ
        LBnvdo+sMxxO8x7JgpJV9ODy+8lBwx5RAxLfFFejF/A2jd5z7QN/Ves0e0RzCOtU7m6Th1zJKQn1f
        zsIdmw1Rm7AMdIjDZwaHNGAWGlqHBMt/ILg5VFhLP/pmYEABQ9P/TvcZ6cpJMzig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEzL-00HC2X-Va;
        Thu, 10 Feb 2022 20:20:20 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com
Subject: [PATCH v2 06/19] cfg80211: Add data structures to capture EHT capabilities
Date:   Thu, 10 Feb 2022 20:19:55 +0100
Message-Id: <20220210201853.c40044dc90e9.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210192008.188166-1-johannes@sipsolutions.net>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

And advertise EHT capabilities to user space when supported.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       | 63 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h | 12 +++++++
 net/wireless/nl80211.c       | 27 ++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f6db085ff3df..7bec15f605be 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -360,6 +360,48 @@ struct ieee80211_sta_he_cap {
 	u8 ppe_thres[IEEE80211_HE_PPE_THRES_MAX_LEN];
 };
 
+/**
+ * struct ieee80211_eht_mcs_nss_supp - EHT max supported NSS per MCS
+ *
+ * See P802.11be_D1.3 Table 9-401k - "Subfields of the Supported EHT-MCS
+ * and NSS Set field"
+ *
+ * @only_20mhz: MCS/NSS support for 20 MHz-only STA.
+ * @bw._80: MCS/NSS support for BW <= 80 MHz
+ * @bw._160: MCS/NSS support for BW = 160 MHz
+ * @bw._320: MCS/NSS support for BW = 320 MHz
+ */
+struct ieee80211_eht_mcs_nss_supp {
+	union {
+		struct ieee80211_eht_mcs_nss_supp_20mhz_only only_20mhz;
+		struct {
+			struct ieee80211_eht_mcs_nss_supp_bw _80;
+			struct ieee80211_eht_mcs_nss_supp_bw _160;
+			struct ieee80211_eht_mcs_nss_supp_bw _320;
+		} __packed bw;
+	} __packed;
+} __packed;
+
+#define IEEE80211_EHT_PPE_THRES_MAX_LEN		32
+
+/**
+ * struct ieee80211_sta_eht_cap - STA's EHT capabilities
+ *
+ * This structure describes most essential parameters needed
+ * to describe 802.11be EHT capabilities for a STA.
+ *
+ * @has_eht: true iff EHT data is valid.
+ * @eht_cap_elem: Fixed portion of the eht capabilities element.
+ * @eht_mcs_nss_supp: The supported NSS/MCS combinations.
+ * @eht_ppe_thres: Holds the PPE Thresholds data.
+ */
+struct ieee80211_sta_eht_cap {
+	bool has_eht;
+	struct ieee80211_eht_cap_elem_fixed eht_cap_elem;
+	struct ieee80211_eht_mcs_nss_supp eht_mcs_nss_supp;
+	u8 eht_ppe_thres[IEEE80211_EHT_PPE_THRES_MAX_LEN];
+};
+
 /**
  * struct ieee80211_sband_iftype_data - sband data per interface type
  *
@@ -379,6 +421,7 @@ struct ieee80211_sband_iftype_data {
 	u16 types_mask;
 	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_he_6ghz_capa he_6ghz_capa;
+	struct ieee80211_sta_eht_cap eht_cap;
 	struct {
 		const u8 *data;
 		unsigned int len;
@@ -561,6 +604,26 @@ ieee80211_get_he_6ghz_capa(const struct ieee80211_supported_band *sband,
 	return data->he_6ghz_capa.capa;
 }
 
+/**
+ * ieee80211_get_eht_iftype_cap - return ETH capabilities for an sband's iftype
+ * @sband: the sband to search for the iftype on
+ * @iftype: enum nl80211_iftype
+ *
+ * Return: pointer to the struct ieee80211_sta_eht_cap, or NULL is none found
+ */
+static inline const struct ieee80211_sta_eht_cap *
+ieee80211_get_eht_iftype_cap(const struct ieee80211_supported_band *sband,
+			     enum nl80211_iftype iftype)
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
 /**
  * wiphy_read_of_freq_limits - read frequency limits from device tree
  *
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 195a238a322e..d305a8b8c536 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3766,6 +3766,14 @@ enum nl80211_mpath_info {
  *	given for all 6 GHz band channels
  * @NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS: vendor element capabilities that are
  *	advertised on this band/for this iftype (binary)
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC: EHT MAC capabilities as in EHT
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY: EHT PHY capabilities as in EHT
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET: EHT supported NSS/MCS as in EHT
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE: EHT PPE thresholds information as
+ *	defined in EHT capabilities element
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
index 19b74a5ca300..b05a77eb16be 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1729,6 +1729,7 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 			 const struct ieee80211_sband_iftype_data *iftdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &iftdata->he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap = &iftdata->eht_cap;
 
 	if (nl80211_put_iftypes(msg, NL80211_BAND_IFTYPE_ATTR_IFTYPES,
 				iftdata->types_mask))
@@ -1749,6 +1750,32 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 			return -ENOBUFS;
 	}
 
+	if (eht_cap->has_eht && he_cap->has_he) {
+		u8 mcs_nss_size, ppe_thresh_size;
+		u16 ppe_thres_hdr;
+
+		mcs_nss_size =
+			ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+						   &eht_cap->eht_cap_elem);
+
+		ppe_thres_hdr = get_unaligned_le16(&eht_cap->eht_ppe_thres[0]);
+		ppe_thresh_size =
+			ieee80211_eht_ppe_size(ppe_thres_hdr,
+					       eht_cap->eht_cap_elem.phy_cap_info);
+
+		if (nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC,
+			    sizeof(eht_cap->eht_cap_elem.mac_cap_info),
+			    eht_cap->eht_cap_elem.mac_cap_info) ||
+		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY,
+			    sizeof(eht_cap->eht_cap_elem.phy_cap_info),
+			    eht_cap->eht_cap_elem.phy_cap_info) ||
+		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET,
+			    mcs_nss_size, &eht_cap->eht_mcs_nss_supp) ||
+		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE,
+			    ppe_thresh_size, eht_cap->eht_ppe_thres))
+			return -ENOBUFS;
+	}
+
 	if (sband->band == NL80211_BAND_6GHZ &&
 	    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA,
 		    sizeof(iftdata->he_6ghz_capa),
-- 
2.34.1

