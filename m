Return-Path: <linux-wireless+bounces-3671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A902857C25
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503601F22750
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40C77F3C;
	Fri, 16 Feb 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1n/F9u4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDD78691
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084497; cv=none; b=ErVfKCTv/ne/EhFvrG23xQI/SoSaZ2J+t5hfDQ7ERB6DOHyze4VbR5tJ/58EXCNUmCPTuZkattS0xpLnda2NTaVjxrck2w7CJOJYTER6waTRCIn12pIeE9FXZ2045sZqqhBKwo/3Ue32woNfoZ7kQuc5bEeZvKCQ0Utk3SEDjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084497; c=relaxed/simple;
	bh=qJMbBa6LYVbPqHUIDD6bmyY3aKkis/CiIB8rR83nvXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZifX/hxt+xUfpslBkQGsUoa3qwArv8OUJlJyUDkViB5niDHqHYSfqWcpmIV5ol8HGmy8xgUB+mezKJNyATxscnvaGiRvjywS1Tnn/s9Ljw8cBRNX9M4EyjRzFCZmF/gd8gUSz6QX2NDqoVWtKu5s0ZcYbUbti6ZlAgmEnERsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1n/F9u4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084495; x=1739620495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJMbBa6LYVbPqHUIDD6bmyY3aKkis/CiIB8rR83nvXY=;
  b=O1n/F9u4pJA3Pi52zXnEV3vcBGRJeoE1iNtPIs1O/0Fdxbh9hBO5yX+F
   +8hEBXfFCM7pLfV2D1+1S1nnmQS/qU16rVFm2cXHWIJ0c4DipvD7uFw16
   fx680oarMm33XEOdczdWTVjs013TN2RBeZMxJsXn/KWTjcQobb0P529+Q
   fBiTr4uFpyPhN3DqLCbhDLykjGFlGbwVx9rSFCIg65G7ZZ9gDWqZ65Ozn
   HPn93sOUmY5LL8yKbFfGwtLtVfPfOu5f0Oc4fzL1puWult9lkLHmfpima
   2ZI06Z+Vt3k1epNVhClxVNbMytBJ0pLZ3BQko6dPgyAnuDz8tjl8xHxoL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321919"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321919"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795598"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 4/7] wifi: cfg80211: refactor RNR parsing
Date: Fri, 16 Feb 2024 13:54:30 +0200
Message-Id: <20240216135047.cfff14b692fc.Ibe25be88a769eab29ebb17b9d19af666df6a2227@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
References: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We'll need more parsing of the reduced neighbor report element,
and we already have two places doing pretty much the same.
Combine by refactoring the parsing into a separate function
with a callback for each item found.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 306 ++++++++++++++++++++++++--------------------
 1 file changed, 169 insertions(+), 137 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index c2d85fa4b75d..e46dfc71c497 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -611,104 +611,144 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 	return 0;
 }
 
-VISIBLE_IF_CFG80211_KUNIT int
-cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
-			    struct list_head *list)
+enum cfg80211_rnr_iter_ret {
+	RNR_ITER_CONTINUE,
+	RNR_ITER_BREAK,
+	RNR_ITER_ERROR,
+};
+
+static bool
+cfg80211_iter_rnr(const u8 *elems, size_t elems_len,
+		  enum cfg80211_rnr_iter_ret
+		  (*iter)(void *data, u8 type,
+			  const struct ieee80211_neighbor_ap_info *info,
+			  const u8 *tbtt_info, u8 tbtt_info_len),
+		  void *iter_data)
 {
-	struct ieee80211_neighbor_ap_info *ap_info;
-	const struct element *elem, *ssid_elem;
+	const struct element *rnr;
 	const u8 *pos, *end;
-	u32 s_ssid_tmp;
-	int n_coloc = 0, ret;
-	LIST_HEAD(ap_list);
 
-	ret = cfg80211_calc_short_ssid(ies, &ssid_elem, &s_ssid_tmp);
-	if (ret)
-		return 0;
+	for_each_element_id(rnr, WLAN_EID_REDUCED_NEIGHBOR_REPORT,
+			    elems, elems_len) {
+		const struct ieee80211_neighbor_ap_info *info;
 
-	for_each_element_id(elem, WLAN_EID_REDUCED_NEIGHBOR_REPORT,
-			    ies->data, ies->len) {
-		pos = elem->data;
-		end = elem->data + elem->datalen;
+		pos = rnr->data;
+		end = rnr->data + rnr->datalen;
 
 		/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
-		while (pos + sizeof(*ap_info) <= end) {
-			enum nl80211_band band;
-			int freq;
+		while (sizeof(*info) <= end - pos) {
 			u8 length, i, count;
+			u8 type;
 
-			ap_info = (void *)pos;
-			count = u8_get_bits(ap_info->tbtt_info_hdr,
-					    IEEE80211_AP_INFO_TBTT_HDR_COUNT) + 1;
-			length = ap_info->tbtt_info_len;
+			info = (void *)pos;
+			count = u8_get_bits(info->tbtt_info_hdr,
+					    IEEE80211_AP_INFO_TBTT_HDR_COUNT) +
+				1;
+			length = info->tbtt_info_len;
 
-			pos += sizeof(*ap_info);
+			pos += sizeof(*info);
 
-			if (!ieee80211_operating_class_to_band(ap_info->op_class,
-							       &band))
-				break;
+			if (count * length > end - pos)
+				return false;
 
-			freq = ieee80211_channel_to_frequency(ap_info->channel,
-							      band);
+			type = u8_get_bits(info->tbtt_info_hdr,
+					   IEEE80211_AP_INFO_TBTT_HDR_TYPE);
 
-			if (end - pos < count * length)
-				break;
+			for (i = 0; i < count; i++) {
+				switch (iter(iter_data, type, info,
+					     pos, length)) {
+				case RNR_ITER_CONTINUE:
+					break;
+				case RNR_ITER_BREAK:
+					return true;
+				case RNR_ITER_ERROR:
+					return false;
+				}
 
-			if (u8_get_bits(ap_info->tbtt_info_hdr,
-					IEEE80211_AP_INFO_TBTT_HDR_TYPE) !=
-			    IEEE80211_TBTT_INFO_TYPE_TBTT) {
-				pos += count * length;
-				continue;
+				pos += length;
 			}
+		}
 
-			/* TBTT info must include bss param + BSSID +
-			 * (short SSID or same_ssid bit to be set).
-			 * ignore other options, and move to the
-			 * next AP info
-			 */
-			if (band != NL80211_BAND_6GHZ ||
-			    !(length == offsetofend(struct ieee80211_tbtt_info_7_8_9,
-						    bss_params) ||
-			      length == sizeof(struct ieee80211_tbtt_info_7_8_9) ||
-			      length >= offsetofend(struct ieee80211_tbtt_info_ge_11,
-						    bss_params))) {
-				pos += count * length;
-				continue;
-			}
+		if (pos != end)
+			return false;
+	}
 
-			for (i = 0; i < count; i++) {
-				struct cfg80211_colocated_ap *entry;
+	return true;
+}
+
+struct colocated_ap_data {
+	const struct element *ssid_elem;
+	struct list_head ap_list;
+	u32 s_ssid_tmp;
+	int n_coloc;
+};
 
-				entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
-						GFP_ATOMIC);
+static enum cfg80211_rnr_iter_ret
+cfg80211_parse_colocated_ap_iter(void *_data, u8 type,
+				 const struct ieee80211_neighbor_ap_info *info,
+				 const u8 *tbtt_info, u8 tbtt_info_len)
+{
+	struct colocated_ap_data *data = _data;
+	struct cfg80211_colocated_ap *entry;
+	enum nl80211_band band;
 
-				if (!entry)
-					goto error;
+	if (type != IEEE80211_TBTT_INFO_TYPE_TBTT)
+		return RNR_ITER_CONTINUE;
 
-				entry->center_freq = freq;
+	if (!ieee80211_operating_class_to_band(info->op_class, &band))
+		return RNR_ITER_CONTINUE;
 
-				if (!cfg80211_parse_ap_info(entry, pos, length,
-							    ssid_elem,
-							    s_ssid_tmp)) {
-					n_coloc++;
-					list_add_tail(&entry->list, &ap_list);
-				} else {
-					kfree(entry);
-				}
+	/* TBTT info must include bss param + BSSID + (short SSID or
+	 * same_ssid bit to be set). Ignore other options, and move to
+	 * the next AP info
+	 */
+	if (band != NL80211_BAND_6GHZ ||
+	    !(tbtt_info_len == offsetofend(struct ieee80211_tbtt_info_7_8_9,
+					   bss_params) ||
+	      tbtt_info_len == sizeof(struct ieee80211_tbtt_info_7_8_9) ||
+	      tbtt_info_len >= offsetofend(struct ieee80211_tbtt_info_ge_11,
+					   bss_params)))
+		return RNR_ITER_CONTINUE;
+
+	entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN, GFP_ATOMIC);
+	if (!entry)
+		return RNR_ITER_ERROR;
+
+	entry->center_freq =
+		ieee80211_channel_to_frequency(info->channel, band);
+
+	if (!cfg80211_parse_ap_info(entry, tbtt_info, tbtt_info_len,
+				    data->ssid_elem, data->s_ssid_tmp)) {
+		data->n_coloc++;
+		list_add_tail(&entry->list, &data->ap_list);
+	} else {
+		kfree(entry);
+	}
 
-				pos += length;
-			}
-		}
+	return RNR_ITER_CONTINUE;
+}
 
-error:
-		if (pos != end) {
-			cfg80211_free_coloc_ap_list(&ap_list);
-			return 0;
-		}
+VISIBLE_IF_CFG80211_KUNIT int
+cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
+			    struct list_head *list)
+{
+	struct colocated_ap_data data = {};
+	int ret;
+
+	INIT_LIST_HEAD(&data.ap_list);
+
+	ret = cfg80211_calc_short_ssid(ies, &data.ssid_elem, &data.s_ssid_tmp);
+	if (ret)
+		return 0;
+
+	if (!cfg80211_iter_rnr(ies->data, ies->len,
+			       cfg80211_parse_colocated_ap_iter, &data)) {
+		cfg80211_free_coloc_ap_list(&data.ap_list);
+		return 0;
 	}
 
-	list_splice_tail(&ap_list, list);
-	return n_coloc;
+	list_splice_tail(&data.ap_list, list);
+	return data.n_coloc;
 }
 EXPORT_SYMBOL_IF_CFG80211_KUNIT(cfg80211_parse_colocated_ap);
 
@@ -2607,79 +2647,71 @@ cfg80211_defrag_mle(const struct element *mle, const u8 *ie, size_t ielen,
 	return NULL;
 }
 
-static u8
-cfg80211_rnr_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
-			     const struct ieee80211_neighbor_ap_info **ap_info,
-			     u8 *param_ch_count)
-{
-	const struct ieee80211_neighbor_ap_info *info;
-	const struct element *rnr;
-	const u8 *pos, *end;
-
-	for_each_element_id(rnr, WLAN_EID_REDUCED_NEIGHBOR_REPORT, ie, ielen) {
-		pos = rnr->data;
-		end = rnr->data + rnr->datalen;
-
-		/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
-		while (sizeof(*info) <= end - pos) {
-			const struct ieee80211_rnr_mld_params *mld_params;
-			u16 params;
-			u8 length, i, count, mld_params_offset;
-			u8 type, lid;
-			u32 use_for;
-
-			info = (void *)pos;
-			count = u8_get_bits(info->tbtt_info_hdr,
-					    IEEE80211_AP_INFO_TBTT_HDR_COUNT) + 1;
-			length = info->tbtt_info_len;
+struct tbtt_info_iter_data {
+	const struct ieee80211_neighbor_ap_info *ap_info;
+	u8 param_ch_count;
+	u32 use_for;
+	u8 mld_id, link_id;
+};
 
-			pos += sizeof(*info);
+static enum cfg80211_rnr_iter_ret
+cfg802121_mld_ap_rnr_iter(void *_data, u8 type,
+			  const struct ieee80211_neighbor_ap_info *info,
+			  const u8 *tbtt_info, u8 tbtt_info_len)
+{
+	const struct ieee80211_rnr_mld_params *mld_params;
+	struct tbtt_info_iter_data *data = _data;
+	u8 link_id;
+
+	if (type == IEEE80211_TBTT_INFO_TYPE_TBTT &&
+	    tbtt_info_len >= offsetofend(struct ieee80211_tbtt_info_ge_11,
+					 mld_params))
+		mld_params = (void *)(tbtt_info +
+				      offsetof(struct ieee80211_tbtt_info_ge_11,
+					       mld_params));
+	else if (type == IEEE80211_TBTT_INFO_TYPE_MLD &&
+		 tbtt_info_len >= sizeof(struct ieee80211_rnr_mld_params))
+		mld_params = (void *)tbtt_info;
+	else
+		return RNR_ITER_CONTINUE;
 
-			if (count * length > end - pos)
-				return 0;
+	link_id = le16_get_bits(mld_params->params,
+				IEEE80211_RNR_MLD_PARAMS_LINK_ID);
 
-			type = u8_get_bits(info->tbtt_info_hdr,
-					   IEEE80211_AP_INFO_TBTT_HDR_TYPE);
+	if (data->mld_id != mld_params->mld_id)
+		return RNR_ITER_CONTINUE;
 
-			if (type == IEEE80211_TBTT_INFO_TYPE_TBTT &&
-			    length >=
-			    offsetofend(struct ieee80211_tbtt_info_ge_11,
-					mld_params)) {
-				mld_params_offset =
-					offsetof(struct ieee80211_tbtt_info_ge_11, mld_params);
-				use_for = NL80211_BSS_USE_FOR_ALL;
-			} else if (type == IEEE80211_TBTT_INFO_TYPE_MLD &&
-				   length >= sizeof(struct ieee80211_rnr_mld_params)) {
-				mld_params_offset = 0;
-				use_for = NL80211_BSS_USE_FOR_MLD_LINK;
-			} else {
-				pos += count * length;
-				continue;
-			}
+	if (data->link_id != link_id)
+		return RNR_ITER_CONTINUE;
 
-			for (i = 0; i < count; i++) {
-				mld_params = (void *)pos + mld_params_offset;
-				params = le16_to_cpu(mld_params->params);
+	data->ap_info = info;
+	data->param_ch_count =
+		le16_get_bits(mld_params->params,
+			      IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
 
-				lid = u16_get_bits(params,
-						   IEEE80211_RNR_MLD_PARAMS_LINK_ID);
+	if (type == IEEE80211_TBTT_INFO_TYPE_TBTT)
+		data->use_for = NL80211_BSS_USE_FOR_ALL;
+	else
+		data->use_for = NL80211_BSS_USE_FOR_MLD_LINK;
+	return RNR_ITER_BREAK;
+}
 
-				if (mld_id == mld_params->mld_id &&
-				    link_id == lid) {
-					*ap_info = info;
-					*param_ch_count =
-						le16_get_bits(mld_params->params,
-							      IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
+static u8
+cfg80211_rnr_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
+			     const struct ieee80211_neighbor_ap_info **ap_info,
+			     u8 *param_ch_count)
+{
+	struct tbtt_info_iter_data data = {
+		.mld_id = mld_id,
+		.link_id = link_id,
+	};
 
-					return use_for;
-				}
+	cfg80211_iter_rnr(ie, ielen, cfg802121_mld_ap_rnr_iter, &data);
 
-				pos += length;
-			}
-		}
-	}
+	*ap_info = data.ap_info;
+	*param_ch_count = data.param_ch_count;
 
-	return 0;
+	return data.use_for;
 }
 
 static struct element *
-- 
2.34.1


