Return-Path: <linux-wireless+bounces-3668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DC857C22
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75E81C21445
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51141BC57;
	Fri, 16 Feb 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUS7UuS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13977F39
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084488; cv=none; b=hcurv4iOdfZ7+heseDRihUVsbZc6A/YoqK/VE8bnQQ3nWCu8RUeFz6RiF8DcFW3He7nBEfe91/e1KyFttMpo6kjpViDYjA0u5RVcW8QKgfbGLZ1TeGjwCVvkwvilR6d0gazR45/BGjtiVPD8+K3expxTbyx2Uhpzu+ku/4aKg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084488; c=relaxed/simple;
	bh=An5IbM/rzTccK9cdGmFfqS+w+56mMigA5TUhHt1SkmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3GTGBAaYgYezqU/chs55rDO9aSP39mFWErtdnBQ8QigQoVM42NlMc+OvFGxsZoyCYwh0wA+EMVan9P3qN60bH6zy4I2G70xkzkJYU6/D/xNHVzjK1bElwdXVpp/vMKzIR1PlVVbso0D3bhKTScQJ56a3h+UjJEneb+1aSXPen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUS7UuS6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084487; x=1739620487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=An5IbM/rzTccK9cdGmFfqS+w+56mMigA5TUhHt1SkmE=;
  b=aUS7UuS6I8h+jPKsgBW9vdVLn5emUY892Btvtsy52IZjcf+CKWrX1M/8
   iLgbpyQPE3nA87p5t/RgHSs3sniVx9GkEHP7sAwqN3Gu5mWJrZzm8v3Tl
   wcvo1uTwkqBUQXfg7JhfEjFrlr57kUYUKL6COIg9sY7dDZd+9y1jg2jxu
   gf4XVUdV4TFhLI2Ya+JSWBTWviZs4eROUEBGnku/ZW4VCEldtkgdNUvD/
   B3hbKJVnYHRIMJxOvO3j7CoaU7aHX+Qo0dUYxXX4QHQnY2W+zeeyFZnAo
   pKsfkbMNAO1ucOTZ34yMdfi6Dr9dstiZu0HCh7VNIdYimJquDBjleMzil
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321905"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795589"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/7] wifi: cfg80211: set correct param change count in ML element
Date: Fri, 16 Feb 2024 13:54:27 +0200
Message-Id: <20240216135047.f2a507634692.I06b122c7a319a38b4e970f5e0bd3d3ef9cac4cbe@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The ML element generation code to create a BSS entry from a per-STA
profile was not overwriting the BSS parameter change count. This meant
that the incorrect parameter change count would be reported within the
multi-link element.

Fix this by returning the BSS parameter change count from the function
and placing it into the ML element. The returned tbtt info was never
used, so just drop that to simplify the code.

Fixes: 5f478adf1f99 ("wifi: cfg80211: generate an ML element for per-STA profiles")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 88e8b25c073a..0907a72231ee 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2567,9 +2567,9 @@ cfg80211_defrag_mle(const struct element *mle, const u8 *ie, size_t ielen,
 }
 
 static u8
-cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
-			      const struct ieee80211_neighbor_ap_info **ap_info,
-			      const u8 **tbtt_info)
+cfg80211_rnr_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
+			     const struct ieee80211_neighbor_ap_info **ap_info,
+			     u8 *param_ch_count)
 {
 	const struct ieee80211_neighbor_ap_info *info;
 	const struct element *rnr;
@@ -2626,7 +2626,9 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 				if (mld_id == mld_params->mld_id &&
 				    link_id == lid) {
 					*ap_info = info;
-					*tbtt_info = pos;
+					*param_ch_count =
+						le16_get_bits(mld_params->params,
+							      IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
 
 					return use_for;
 				}
@@ -2836,8 +2838,8 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		enum nl80211_band band;
 		u32 freq;
 		const u8 *profile;
-		const u8 *tbtt_info;
 		ssize_t profile_len;
+		u8 param_ch_count;
 		u8 link_id, use_for;
 
 		if (!ieee80211_mle_basic_sta_prof_size_ok((u8 *)mle->sta_prof[i],
@@ -2880,10 +2882,11 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		profile_len -= 2;
 
 		/* Find in RNR to look up channel information */
-		use_for = cfg80211_tbtt_info_for_mld_ap(tx_data->ie,
-							tx_data->ielen,
-							mld_id, link_id,
-							&ap_info, &tbtt_info);
+		use_for = cfg80211_rnr_info_for_mld_ap(tx_data->ie,
+						       tx_data->ielen,
+						       mld_id, link_id,
+						       &ap_info,
+						       &param_ch_count);
 		if (!use_for)
 			continue;
 
@@ -2926,7 +2929,8 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 			continue;
 
 		/* Copy the Basic Multi-Link element including the common
-		 * information, and then fix up the link ID.
+		 * information, and then fix up the link ID and BSS param
+		 * change count.
 		 * Note that the ML element length has been verified and we
 		 * also checked that it contains the link ID.
 		 */
@@ -2937,6 +2941,8 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		       sizeof(*ml_elem) + ml_common_len);
 
 		new_ie[data.ielen + sizeof(*ml_elem) + 1 + ETH_ALEN] = link_id;
+		new_ie[data.ielen + sizeof(*ml_elem) + 1 + ETH_ALEN + 1] =
+			param_ch_count;
 
 		data.ielen += sizeof(*ml_elem) + ml_common_len;
 
-- 
2.34.1


