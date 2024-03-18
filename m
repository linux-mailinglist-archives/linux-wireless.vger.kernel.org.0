Return-Path: <linux-wireless+bounces-4856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B087EE16
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C23E1C21EB7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3721555E5F;
	Mon, 18 Mar 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iF/tcWf6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66A55E70
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780855; cv=none; b=W90zKlzI19VqLI17QQWb2JVk9ix6QmFIROv9YqOASIdXI06AFm4uukPKJJTET9tK9PNP+1872S1zvIOZDc+Hbc4HKREymt/RWC7npYQ2Ce3c9JP8MFKQ8f4Uu2orPPFPI5K+z3ejgBLmMA5Ju7udeRte+facLq1gfjJxIcZyYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780855; c=relaxed/simple;
	bh=QTa63NQ0zE7Z0Q+ifkgcf6VTYvZKceKkkNTpXkbhnrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jo/5u5DXp/dL19O/qYN2Y5gag4Xm76/C05WOdP/1nMfLWCwS+jJDkDjBsavZTG1LgwT1R+dWXLzx6smHJS4pmIV5vPr82l46aqsGhNZMbpFOWQh2ynNYi/Kg+zUMzJdFkfK3o40LvhoeeDRguI6b6cOVSrZ4VD8iMRhx4vtDVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iF/tcWf6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780854; x=1742316854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTa63NQ0zE7Z0Q+ifkgcf6VTYvZKceKkkNTpXkbhnrg=;
  b=iF/tcWf6mRZBwPrhvzLFsgBAl8CAYydW+g/VMBFbRMo4Kmvms9dPCMSu
   PV62gihkPR3fipm0khDcyWXW+0DiPLtbV+mXsJNy0dgUIwYUmW4dIxJrv
   IuM4uBOaptojGeJSbhDD1caTLzRDQGzEwcjxn6nntKidmSojuA9mAG19G
   KP5/mZubIvcUNTq45JUDLN3vkZE2XfhQXWikX0QQ10h+6JTLXS0cU604b
   LY951gMcDGMFdAGx4LhXDbRGePrayvRroQzKwzF7//uX5YjHi3xAQSd9J
   StPOMmpfmsAnFuwvnZfW2RQlpmMvbF2i/3fS+7b0ZbTd3vWBefxCo99ot
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819473"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819473"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909939"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/15] wifi: cfg80211: ignore non-TX BSSs in per-STA profile
Date: Mon, 18 Mar 2024 18:53:29 +0200
Message-Id: <20240318184907.6a0babed655a.Iad447fea417c63f683da793556b97c31d07a4aab@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

If a non-TX BSS is included in a per-STA profile, then we cannot set
transmitted_bss for it. Even worse, if we do things properly we should
be configuring both bssid_index and max_bssid_indicator correctly. We do
not actually have both pieces of information (and, some APs currently
do not include either).

So, ignore any per-STA profile where the RNR says that the BSS is not
transmitted. Also fix transmitted_bss to never be set for per-STA
profiles.

This fixes issues where mac80211 was setting the reference BSSID to an
incorrect value.

Fixes: 2481b5da9c6b ("wifi: cfg80211: handle BSS data contained in ML probe responses")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 47 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 8ac2d19d8ede..127853877a0a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2211,12 +2211,16 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	tmp.pub.use_for = data->use_for;
 	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
 
-	if (data->bss_source != BSS_SOURCE_DIRECT) {
+	switch (data->bss_source) {
+	case BSS_SOURCE_MBSSID:
 		tmp.pub.transmitted_bss = data->source_bss;
+		fallthrough;
+	case BSS_SOURCE_STA_PROFILE:
 		ts = bss_from_pub(data->source_bss)->ts;
 		tmp.pub.bssid_index = data->bssid_index;
 		tmp.pub.max_bssid_indicator = data->max_bssid_indicator;
-	} else {
+		break;
+	case BSS_SOURCE_DIRECT:
 		ts = jiffies;
 
 		if (channel->band == NL80211_BAND_60GHZ) {
@@ -2231,6 +2235,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 				regulatory_hint_found_beacon(wiphy, channel,
 							     gfp);
 		}
+		break;
 	}
 
 	/*
@@ -2660,6 +2665,7 @@ struct tbtt_info_iter_data {
 	u8 param_ch_count;
 	u32 use_for;
 	u8 mld_id, link_id;
+	bool non_tx;
 };
 
 static enum cfg80211_rnr_iter_ret
@@ -2670,14 +2676,20 @@ cfg802121_mld_ap_rnr_iter(void *_data, u8 type,
 	const struct ieee80211_rnr_mld_params *mld_params;
 	struct tbtt_info_iter_data *data = _data;
 	u8 link_id;
+	bool non_tx = false;
 
 	if (type == IEEE80211_TBTT_INFO_TYPE_TBTT &&
 	    tbtt_info_len >= offsetofend(struct ieee80211_tbtt_info_ge_11,
-					 mld_params))
-		mld_params = (void *)(tbtt_info +
-				      offsetof(struct ieee80211_tbtt_info_ge_11,
-					       mld_params));
-	else if (type == IEEE80211_TBTT_INFO_TYPE_MLD &&
+					 mld_params)) {
+		const struct ieee80211_tbtt_info_ge_11 *tbtt_info_ge_11 =
+			(void *)tbtt_info;
+
+		non_tx = (tbtt_info_ge_11->bss_params &
+			  (IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID |
+			   IEEE80211_RNR_TBTT_PARAMS_TRANSMITTED_BSSID)) ==
+			 IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID;
+		mld_params = &tbtt_info_ge_11->mld_params;
+	} else if (type == IEEE80211_TBTT_INFO_TYPE_MLD &&
 		 tbtt_info_len >= sizeof(struct ieee80211_rnr_mld_params))
 		mld_params = (void *)tbtt_info;
 	else
@@ -2696,6 +2708,7 @@ cfg802121_mld_ap_rnr_iter(void *_data, u8 type,
 	data->param_ch_count =
 		le16_get_bits(mld_params->params,
 			      IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
+	data->non_tx = non_tx;
 
 	if (type == IEEE80211_TBTT_INFO_TYPE_TBTT)
 		data->use_for = NL80211_BSS_USE_FOR_ALL;
@@ -2707,7 +2720,7 @@ cfg802121_mld_ap_rnr_iter(void *_data, u8 type,
 static u8
 cfg80211_rnr_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 			     const struct ieee80211_neighbor_ap_info **ap_info,
-			     u8 *param_ch_count)
+			     u8 *param_ch_count, bool *non_tx)
 {
 	struct tbtt_info_iter_data data = {
 		.mld_id = mld_id,
@@ -2718,6 +2731,7 @@ cfg80211_rnr_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 
 	*ap_info = data.ap_info;
 	*param_ch_count = data.param_ch_count;
+	*non_tx = data.non_tx;
 
 	return data.use_for;
 }
@@ -2897,6 +2911,7 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		ssize_t profile_len;
 		u8 param_ch_count;
 		u8 link_id, use_for;
+		bool non_tx;
 
 		if (!ieee80211_mle_basic_sta_prof_size_ok((u8 *)mle->sta_prof[i],
 							  mle->sta_prof_len[i]))
@@ -2942,10 +2957,24 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 						       tx_data->ielen,
 						       mld_id, link_id,
 						       &ap_info,
-						       &param_ch_count);
+						       &param_ch_count,
+						       &non_tx);
 		if (!use_for)
 			continue;
 
+		/*
+		 * As of 802.11be_D5.0, the specification does not give us any
+		 * way of discovering both the MaxBSSID and the Multiple-BSSID
+		 * Index. It does seem like the Multiple-BSSID Index element
+		 * may be provided, but section 9.4.2.45 explicitly forbids
+		 * including a Multiple-BSSID Element (in this case without any
+		 * subelements).
+		 * Without both pieces of information we cannot calculate the
+		 * reference BSSID, so simply ignore the BSS.
+		 */
+		if (non_tx)
+			continue;
+
 		/* We could sanity check the BSSID is included */
 
 		if (!ieee80211_operating_class_to_band(ap_info->op_class,
-- 
2.34.1


