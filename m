Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F535661CE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jul 2022 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiGEDUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 23:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiGEDUu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 23:20:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39E1276E
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 20:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656991249; x=1688527249;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Q8aCBPQ1BggGUFsBYUusPqpF+s14Gzo9bAHSOXIPyRw=;
  b=wYVT+nBuHQTjcYmcwiFoUpax0n2pfryXkPgjBNXMG/8sN6qE3Id32DK0
   Z4at5OMf1at2ohAn0dCBHZck1YiLwAFcFkW+PbyCYkttknoNQoOSVwUIw
   sMu96vRzQYWRibh6fwfBG7Aysv+NUxr/U7FpPDjDwVkMtN27r+fwrdMtb
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 04 Jul 2022 20:20:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 20:20:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 20:20:48 -0700
Received: from paulz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 20:20:46 -0700
From:   Paul Zhang <quic_paulz@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] cfg80211: modify MLD ID params about RNR element
Date:   Tue, 5 Jul 2022 11:19:29 +0800
Message-ID: <1656991169-25910-1-git-send-email-quic_paulz@quicinc.com>
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

In order to reconstruct frame for MBSSID feature, per the description of
the Reduced Neighbor Report(RNR) element about MLD parameters subfield in
section 9.4.2.170 of Draft P802.11be_D2.0, the RNR element is modified:
1\ If the reported AP is affiliated with the same MLD of the reporting AP,
the TBTT information is skipped;
2\ If the reported AP is affiliated with the same MLD of the nontransmitted
BSSID, the TBTT information is copied and the MLD ID is changed to 0.

Signed-off-by: Paul Zhang <quic_paulz@quicinc.com>
---
 include/linux/ieee80211.h |   9 +++
 net/wireless/scan.c       | 159 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 559b6c6..0e547b5 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3996,6 +3996,15 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		9
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	13
 
+/*
+ * TBTT Information field, based on Draft P802.11be_D2.0
+ * section 9.4.2.170.2
+ */
+#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD		13
+#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD_MLD_PARAM	16
+/* TBTT information header(2) + Operating class(1) + Channel number(1) */
+#define IEEE80211_NBR_AP_INFO_LEN	4
+
 #define IEEE80211_RNR_TBTT_PARAMS_OCT_RECOMMENDED		0x01
 #define IEEE80211_RNR_TBTT_PARAMS_SAME_SSID			0x02
 #define IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID			0x04
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b888522..e50011f 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -268,9 +268,151 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 }
 EXPORT_SYMBOL(cfg80211_is_element_inherited);
 
+/**
+ * cfg80211_handle_rnr_ie_for_mbssid() - parse and modify RNR element for MBSSID
+ *                                       feature
+ * @elem: The pointer to RNR element
+ * @bssid_index: BSSID index from MBSSID index element
+ * @pos: The buffer pointer to save the transformed RNR element, caller is
+ * expected to supply a buffer that is at least as big as @elem
+ *
+ * Per the description about Neighbor AP Information field about MLD
+ * parameters subfield in section 9.4.2.170.2 of Draft P802.11be_D2.0.
+ * If the reported AP is affiliated with the same MLD of the reporting AP,
+ * the TBTT information is skipped; If the reported AP is affiliated with
+ * the same MLD of the nontransmitted BSSID, the TBTT information is copied
+ * and the MLD ID is changed to 0.
+ *
+ * Return: Length of the element written to @pos
+ */
+static size_t cfg80211_handle_rnr_ie_for_mbssid(const struct element *elem,
+						u8 bssid_index, u8 *pos)
+{
+	size_t rnr_len;
+	const u8 *rnr, *data, *rnr_end;
+	u8 *rnr_new, *tbtt_info_field;
+	u8 tbtt_type, tbtt_len, tbtt_count;
+	u8 mld_pos, mld_id;
+	u32 i, copy_len;
+	/* The count of TBTT info field whose MLD ID equals to 0 in a neighbor
+	 * AP information field.
+	 */
+	u32 tbtt_info_field_count;
+	/* The total bytes of TBTT info fields whose MLD ID equals to 0 in
+	 * current RNR element.
+	 */
+	u32 tbtt_info_field_len = 0;
+
+	rnr_new = pos;
+	rnr = (u8 *)elem;
+	rnr_len = elem->datalen;
+	rnr_end = rnr + rnr_len + 2;
+
+	memcpy(pos, rnr, 2);
+	pos += 2;
+	data = elem->data;
+	while (data + IEEE80211_NBR_AP_INFO_LEN <= rnr_end) {
+		tbtt_type = u8_get_bits(data[0],
+					IEEE80211_AP_INFO_TBTT_HDR_TYPE);
+		tbtt_count = u8_get_bits(data[0],
+					 IEEE80211_AP_INFO_TBTT_HDR_COUNT);
+		tbtt_len = data[1];
+
+		copy_len = tbtt_len * (tbtt_count + 1) +
+			   IEEE80211_NBR_AP_INFO_LEN;
+		if (data + copy_len > rnr_end)
+			break;
+
+		if (tbtt_len >=
+		    IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD_MLD_PARAM)
+			mld_pos =
+			    IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD;
+		else
+			mld_pos = 0;
+		/* If MLD params do not exist, copy this neighbor AP
+		 * information field.
+		 * Draft P802.11be_D2.0, tbtt_type value 1, 2 and 3
+		 * are reserved.
+		 */
+		if (mld_pos == 0 || tbtt_type != 0) {
+			memcpy(pos, data, copy_len);
+			pos += copy_len;
+			data += copy_len;
+			continue;
+		}
+		/* If MLD params exists, copy the 4 bytes fixed field.
+		 * tbtt_info_field is used to modify the tbtt_count field later.
+		 */
+		memcpy(pos, data, IEEE80211_NBR_AP_INFO_LEN);
+		tbtt_info_field = pos;
+		pos += IEEE80211_NBR_AP_INFO_LEN;
+		data += IEEE80211_NBR_AP_INFO_LEN;
+
+		tbtt_info_field_count = 0;
+		for (i = 0; i < tbtt_count + 1; i++) {
+			mld_id = data[mld_pos];
+			/* Refer to Draft P802.11be_D2.0
+			 * 9.4.2.170.2 Neighbor AP Information field about
+			 * MLD parameters subfield
+			 */
+			if (mld_id == 0) {
+				/* Skip this TBTT information since this
+				 * reported AP is affiliated with the same MLD
+				 * of the reporting AP who sending the frame
+				 * carrying this element.
+				 */
+				tbtt_info_field_len += tbtt_len;
+				data += tbtt_len;
+				tbtt_info_field_count++;
+			} else if (mld_id == bssid_index) {
+				/* Copy this TBTT information and change MLD
+				 * to 0 as this reported AP is affiliated with
+				 * the same MLD of the nontransmitted BSSID.
+				 */
+				memcpy(pos, data, tbtt_len);
+				pos[mld_pos] = 0;
+				data += tbtt_len;
+				pos += tbtt_len;
+			} else {
+				/* Just copy this TBTT information */
+				memcpy(pos, data, tbtt_len);
+				data += tbtt_len;
+				pos += tbtt_len;
+			}
+		}
+		if (tbtt_info_field_count == (tbtt_count + 1)) {
+			/* If all the TBTT informations are skipped, then also
+			 * revert the 4 bytes fixed field which has been copied.
+			 */
+			pos -= IEEE80211_NBR_AP_INFO_LEN;
+			tbtt_info_field_len += IEEE80211_NBR_AP_INFO_LEN;
+		} else {
+			/* Modify the tbtt_count field if some TBTT informations
+			 * are skipped.
+			 */
+			u8p_replace_bits(&tbtt_info_field[0],
+					 tbtt_count - tbtt_info_field_count,
+					 IEEE80211_AP_INFO_TBTT_HDR_COUNT);
+		}
+	}
+
+	/* Sanity check if any parsing issue happens */
+	if (data != rnr_end)
+		return 0;
+
+	/* Count the new rnr length.
+	 * tbtt_info_field_len saves the total skipped length.
+	 */
+	rnr_new[1] = rnr_len - tbtt_info_field_len;
+	if (rnr_new[1] == 0)
+		pos = rnr_new;
+
+	return pos - rnr_new;
+}
+
 static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 				  const u8 *subelement, size_t subie_len,
-				  u8 *new_ie, gfp_t gfp)
+				  u8 *new_ie, u8 bssid_index, gfp_t gfp)
 {
 	u8 *pos, *tmp;
 	const u8 *tmp_old, *tmp_new;
@@ -319,10 +461,13 @@ static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 
 		if (!tmp) {
 			const struct element *old_elem = (void *)tmp_old;
-
-			/* ie in old ie but not in subelement */
-			if (cfg80211_is_element_inherited(old_elem,
-							  non_inherit_elem)) {
+			if (tmp_old[0] == WLAN_EID_REDUCED_NEIGHBOR_REPORT) {
+				pos +=
+				  cfg80211_handle_rnr_ie_for_mbssid(old_elem,
+								    bssid_index,
+								    pos);
+			} else if (cfg80211_is_element_inherited(old_elem,
+								 non_inherit_elem)) {
 				memcpy(pos, tmp_old, tmp_old[1] + 2);
 				pos += tmp_old[1] + 2;
 			}
@@ -2112,6 +2257,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 	u64 seen_indices = 0;
 	u16 capability;
 	struct cfg80211_bss *bss;
+	u8 bssid_index;
 
 	if (!non_tx_data)
 		return;
@@ -2178,6 +2324,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 
 			non_tx_data->bssid_index = mbssid_index_ie[2];
 			non_tx_data->max_bssid_indicator = elem->data[0];
+			bssid_index = non_tx_data->bssid_index;
 
 			cfg80211_gen_new_bssid(bssid,
 					       non_tx_data->max_bssid_indicator,
@@ -2187,7 +2334,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 			new_ie_len = cfg80211_gen_new_ie(ie, ielen,
 							 profile,
 							 profile_len, new_ie,
-							 gfp);
+							 bssid_index, gfp);
 			if (!new_ie_len)
 				continue;
 
-- 
2.7.4

