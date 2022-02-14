Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223B4B562D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356371AbiBNQaW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356376AbiBNQaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC7D60AAD
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8kR3mAIRUWqt0XDNr3OGoZOdl3BOhxnXRKFqW4Y/6BA=;
        t=1644856211; x=1646065811; b=idb2lyPIGeEcTAtD04OCtIK/z7XCy4RQ27g1nusGZ7fggpc
        7BDeJ1PWpvmHz24rM7JaaIbjZYPlk0v5wYeWfH2Br5CF4SzNh8NB0hZm4+h15ksRyLbKnYEH9vBrK
        u6ITWMziP2XsxxafKVkRYlJZLdDdjyAT5RppHfE+1SCrLHw+Iz/0hwL0cEpuluNvePx82HYhZ2fhH
        fwA5LuM98dOG0xMQFvSOvKka61pVmZsf46tbxPDpLgywgurH3nk/ZWAm5Q/fJo7gHIg/Am3RgX+cW
        IxAeszqezgDk6gNoK6LOQRNMDsU+l4MRbrscbu23iPOJkB54nd/3p5hrC+SIyUOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEr-0011mw-PM;
        Mon, 14 Feb 2022 17:30:09 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 06/19] cfg80211: Add data structures to capture EHT capabilities
Date:   Mon, 14 Feb 2022 17:29:53 +0100
Message-Id: <20220214173004.6fb70658529f.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
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
index 0bdd11abe815..2240af5fa695 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1740,6 +1740,7 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 			 const struct ieee80211_sband_iftype_data *iftdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &iftdata->he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap = &iftdata->eht_cap;
 
 	if (nl80211_put_iftypes(msg, NL80211_BAND_IFTYPE_ATTR_IFTYPES,
 				iftdata->types_mask))
@@ -1760,6 +1761,32 @@ nl80211_send_iftype_data(struct sk_buff *msg,
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

