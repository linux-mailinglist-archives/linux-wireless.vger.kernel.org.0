Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781354F7F7B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiDGMxa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbiDGMxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 08:53:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DE21D06B
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649335890; x=1680871890;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WR6aoBqbHKLr34zkkqx0rIVWC5/nF7DKrz/UNbeh7Cw=;
  b=vo2P6hBNKVIlOeJQ+9rrxsxtfHuo4aLgE2OJPVCf1pE8RUm2xnxqd8Gb
   c4I/daVpUN/r1EUl2Ex5DAL0tJfLamUeRAPSuR81wKcthi+cX3HT7gxvy
   Xn4xFGSBeezTqOQ1yV02M66iXChBeyBcYcTpwIsiaYzWvDf0oX/R2HIAu
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Apr 2022 05:51:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 05:51:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 05:51:28 -0700
Received: from paulz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 05:51:27 -0700
From:   Paul Zhang <quic_paulz@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v1] cfg80211: parse RNR IE about MLD params for MBSSID feature
Date:   Thu, 7 Apr 2022 20:51:11 +0800
Message-ID: <1649335871-9173-1-git-send-email-quic_paulz@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reconstruct frame for MBSSID feature, per the description of
the Reduced Neighbor Report(RNR) element about MLD parameters subfield in
section 9.4.2.170 of Draft P802.11be_D1.4, the RNR IE is modified:
1\ If the reported AP is affiliated with the same MLD of the reporting AP,
the TBTT information is skipped;
2\ If the reported AP is affiliated with the same MLD of the nontransmitted
BSSID, the TBTT information is copied and the MLD ID is changed to 0.

Signed-off-by: Paul Zhang <quic_paulz@quicinc.com>
---
 include/linux/ieee80211.h |  11 ++++
 net/wireless/scan.c       | 142 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 559b6c6..f15fd2a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3996,6 +3996,17 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		9
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	13
 
+/*
+ * TBTT Information field, based on Draft P802.11be_D1.4
+ * section 9.4.2.170.2
+ */
+#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD		13
+#define IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD_MLD_PARAM	16
+#define IEEE80211_TBTT_TYPE_MASK	0xC0
+#define IEEE80211_TBTT_COUNT_MASK	0x0F
+/* TBTT infomation header(2) + Operating class(1) + Channel number(1) */
+#define IEEE80211_NBR_AP_INFO_LEN	4
+
 #define IEEE80211_RNR_TBTT_PARAMS_OCT_RECOMMENDED		0x01
 #define IEEE80211_RNR_TBTT_PARAMS_SAME_SSID			0x02
 #define IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID			0x04
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b888522..af0bd04 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -268,9 +268,136 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 }
 EXPORT_SYMBOL(cfg80211_is_element_inherited);
 
+/**
+ * cfg80211_handle_rnr_ie_for_mbssid() - parse and modify RNR IE for MBSSID
+ *                                       feature
+ * @elem: The pointer to RNR IE
+ * @bssid_index: BSSID index from MBSSID index IE
+ * @pos: The buffer pointer to save the transformed RNR IE, caller is expected
+ *       to supply a buffer that is at least as big as @elem
+ *
+ * Per the description about Neighbor AP Information field about MLD
+ * parameters subfield in section 9.4.2.170.2 of Draft P802.11be_D1.4.
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
+	 * current RNR IE.
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
+	while (data < rnr_end) {
+		tbtt_type = u8_get_bits(data[0], IEEE80211_TBTT_TYPE_MASK);
+		tbtt_count = u8_get_bits(data[0], IEEE80211_TBTT_COUNT_MASK);
+		tbtt_len = data[1];
+
+		copy_len = tbtt_len * (tbtt_count + 1) +
+			   IEEE80211_NBR_AP_INFO_LEN;
+		if (data + copy_len > rnr_end)
+			return 0;
+
+		if (tbtt_len >=
+		    IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD_MLD_PARAM)
+			mld_pos =
+			    IEEE80211_TBTT_INFO_BSSID_SSID_BSS_PARAM_PSD;
+		else
+			mld_pos = 0;
+		/* If MLD params do not exist, copy this neighbor AP
+		 * information field.
+		 * Draft P802.11be_D1.4, tbtt_type value 1, 2 and 3
+		 * are reserved.
+		 */
+		if (mld_pos == 0 || tbtt_type != 0) {
+			memcpy(pos, data, copy_len);
+			pos += copy_len;
+			data += copy_len;
+			continue;
+		}
+
+		memcpy(pos, data, IEEE80211_NBR_AP_INFO_LEN);
+		tbtt_info_field = pos;
+		pos += IEEE80211_NBR_AP_INFO_LEN;
+		data += IEEE80211_NBR_AP_INFO_LEN;
+
+		tbtt_info_field_count = 0;
+		for (i = 0; i < tbtt_count + 1; i++) {
+			mld_id = data[mld_pos];
+			/* Refer to Draft P802.11be_D1.4
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
+				memcpy(pos, data, tbtt_len);
+				data += tbtt_len;
+				pos += tbtt_len;
+			}
+		}
+		if (tbtt_info_field_count == (tbtt_count + 1)) {
+			/* If all the TBTT informations are skipped, then also
+			 * revert the neighbor AP info which has been copied.
+			 */
+			pos -= IEEE80211_NBR_AP_INFO_LEN;
+			tbtt_info_field_len += IEEE80211_NBR_AP_INFO_LEN;
+		} else {
+			u8p_replace_bits(&tbtt_info_field[0],
+					 tbtt_count - tbtt_info_field_count,
+					 IEEE80211_TBTT_COUNT_MASK);
+		}
+	}
+
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
@@ -321,8 +448,13 @@ static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 			const struct element *old_elem = (void *)tmp_old;
 
 			/* ie in old ie but not in subelement */
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
@@ -2112,6 +2244,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 	u64 seen_indices = 0;
 	u16 capability;
 	struct cfg80211_bss *bss;
+	u8 bssid_index;
 
 	if (!non_tx_data)
 		return;
@@ -2178,6 +2311,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 
 			non_tx_data->bssid_index = mbssid_index_ie[2];
 			non_tx_data->max_bssid_indicator = elem->data[0];
+			bssid_index = non_tx_data->bssid_index;
 
 			cfg80211_gen_new_bssid(bssid,
 					       non_tx_data->max_bssid_indicator,
@@ -2187,7 +2321,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 			new_ie_len = cfg80211_gen_new_ie(ie, ielen,
 							 profile,
 							 profile_len, new_ie,
-							 gfp);
+							 bssid_index, gfp);
 			if (!new_ie_len)
 				continue;
 
-- 
2.7.4

