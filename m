Return-Path: <linux-wireless+bounces-3670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C0A857C24
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9112844B6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9A77F32;
	Fri, 16 Feb 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYOdC3g8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F07867E
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084494; cv=none; b=TvW/gf9keAFPWSRZ9GWmrqMsQEdlX9f6SMNUlgqYAktf7s6UAtTeR8k0nElObhWfGxihMWKgJXAfQpDLct9dYuwZOmUq1qQBdKErORVZPIAZ5ylGrLHPnpSUT+aKC1VhCQJ+scljDKp3p9QpM39MfO1oQ82JIQpqo0EcehTeOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084494; c=relaxed/simple;
	bh=yfQujVR5rVP+exuWqjFoFBM/6o8hMUBp0nzrtG1UsCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/Ex46Z2f0LuR6tgXP20BVIlOchYGrikLrBgEaEPvWg97UW/IZZfZoYSM7oaGh8uao+ERxhEVA8TlyRiA8DPqZ/Fc31Dgs4uX2YoGuAbR67XsUKFX8IBQd6NeGhqFbrlLvxnskC3RggcPTbtNJGU+jHXV69ybO2ROBPoBHgdqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYOdC3g8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084492; x=1739620492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yfQujVR5rVP+exuWqjFoFBM/6o8hMUBp0nzrtG1UsCI=;
  b=WYOdC3g8lSGw9/FZuV9+j/nLMoiIp1ehXZ0wlFses8mi2FRy/Go68KHB
   XG0/51V85xPxwtYs4rpCZB8WqcTB74pmz2Y5JLU4rHvfUUlFXGcTW9pwO
   dp5GlO3wJLqrEE2w/orp7n2OOCuZ8Lhs1CTDe8eM1HEHo3KQCHxEGSt+S
   sCFNn0YEn8QG1HxCYVGw8ACiYkEnaO/cKW8ouxE/tD1+1wZCI+nZCJsWy
   8OuJRQicJe5p6RiW5Jtr/2Guwe9PduLmzloniPGWMknxb/4AroR25RvOi
   tKK/Nul6hySjeyKu2YNjY9H6f207gymfAOyxs0/uE7eXz/22UEt4WaR/E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321915"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321915"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795595"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/7] wifi: cfg80211: clean up cfg80211_inform_bss_frame_data()
Date: Fri, 16 Feb 2024 13:54:29 +0200
Message-Id: <20240216135047.874aed1eff5f.Ib7d88d126eec50c64763251a78cb432bb5df14df@changeid>
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

Make cfg80211_inform_bss_frame_data() call the existing
cfg80211_inform_bss_data() after parsing the frame in the
appropriate way, so we have less code duplication. This
required introducing a new CFG80211_BSS_FTYPE_S1G_BEACON,
but that can be used by other drivers as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h |  2 ++
 net/wireless/scan.c    | 71 +++++++++++++++++++-----------------------
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 57c2298af35b..f9eada2a26ec 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7175,11 +7175,13 @@ size_t cfg80211_merge_profile(const u8 *ie, size_t ielen,
  *	from a beacon or probe response
  * @CFG80211_BSS_FTYPE_BEACON: data comes from a beacon
  * @CFG80211_BSS_FTYPE_PRESP: data comes from a probe response
+ * @CFG80211_BSS_FTYPE_S1G_BEACON: data comes from an S1G beacon
  */
 enum cfg80211_bss_frame_type {
 	CFG80211_BSS_FTYPE_UNKNOWN,
 	CFG80211_BSS_FTYPE_BEACON,
 	CFG80211_BSS_FTYPE_PRESP,
+	CFG80211_BSS_FTYPE_S1G_BEACON,
 };
 
 /**
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 754138168646..c2d85fa4b75d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2213,6 +2213,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 
 	switch (data->ftype) {
 	case CFG80211_BSS_FTYPE_BEACON:
+	case CFG80211_BSS_FTYPE_S1G_BEACON:
 		ies->from_beacon = true;
 		fallthrough;
 	case CFG80211_BSS_FTYPE_UNKNOWN:
@@ -3057,6 +3058,10 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 	if (!res)
 		return NULL;
 
+	/* don't do any further MBSSID/ML handling for S1G */
+	if (ftype == CFG80211_BSS_FTYPE_S1G_BEACON)
+		return res;
+
 	cfg80211_parse_mbssid_data(wiphy, &inform_data, res, gfp);
 
 	cfg80211_parse_ml_sta_data(wiphy, &inform_data, res, gfp);
@@ -3071,17 +3076,16 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 			       struct ieee80211_mgmt *mgmt, size_t len,
 			       gfp_t gfp)
 {
-	struct cfg80211_inform_single_bss_data inform_data = {
-		.drv_data = data,
-		.use_for = data->restrict_use ?
-				data->use_for :
-				NL80211_BSS_USE_FOR_ALL,
-		.cannot_use_reasons = data->cannot_use_reasons,
-	};
 	size_t min_hdr_len = offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
 	struct ieee80211_ext *ext = NULL;
-	struct cfg80211_bss *res;
+	enum cfg80211_bss_frame_type ftype;
+	u16 beacon_interval;
+	const u8 *bssid;
+	u16 capability;
+	const u8 *ie;
+	size_t ielen;
+	u64 tsf;
 
 	if (WARN_ON(!mgmt))
 		return NULL;
@@ -3105,56 +3109,45 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	if (WARN_ON(len < min_hdr_len))
 		return NULL;
 
-	inform_data.ielen = len - min_hdr_len;
-	inform_data.ie = mgmt->u.probe_resp.variable;
+	ielen = len - min_hdr_len;
+	ie = mgmt->u.probe_resp.variable;
 	if (ext) {
 		const struct ieee80211_s1g_bcn_compat_ie *compat;
 		const struct element *elem;
 
 		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			inform_data.ie = ext->u.s1g_short_beacon.variable;
+			ie = ext->u.s1g_short_beacon.variable;
 		else
-			inform_data.ie = ext->u.s1g_beacon.variable;
+			ie = ext->u.s1g_beacon.variable;
 
-		elem = cfg80211_find_elem(WLAN_EID_S1G_BCN_COMPAT,
-					  inform_data.ie, inform_data.ielen);
+		elem = cfg80211_find_elem(WLAN_EID_S1G_BCN_COMPAT, ie, ielen);
 		if (!elem)
 			return NULL;
 		if (elem->datalen < sizeof(*compat))
 			return NULL;
 		compat = (void *)elem->data;
-		memcpy(inform_data.bssid, ext->u.s1g_beacon.sa, ETH_ALEN);
-		inform_data.capability = le16_to_cpu(compat->compat_info);
-		inform_data.beacon_interval = le16_to_cpu(compat->beacon_int);
+		bssid = ext->u.s1g_beacon.sa;
+		capability = le16_to_cpu(compat->compat_info);
+		beacon_interval = le16_to_cpu(compat->beacon_int);
 	} else {
-		memcpy(inform_data.bssid, mgmt->bssid, ETH_ALEN);
-		inform_data.beacon_interval =
-			le16_to_cpu(mgmt->u.probe_resp.beacon_int);
-		inform_data.capability =
-			le16_to_cpu(mgmt->u.probe_resp.capab_info);
+		bssid = mgmt->bssid;
+		beacon_interval = le16_to_cpu(mgmt->u.probe_resp.beacon_int);
+		capability = le16_to_cpu(mgmt->u.probe_resp.capab_info);
 	}
 
-	inform_data.tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
+	tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
 
 	if (ieee80211_is_probe_resp(mgmt->frame_control))
-		inform_data.ftype = CFG80211_BSS_FTYPE_PRESP;
+		ftype = CFG80211_BSS_FTYPE_PRESP;
+	else if (ext)
+		ftype = CFG80211_BSS_FTYPE_S1G_BEACON;
 	else
-		inform_data.ftype = CFG80211_BSS_FTYPE_BEACON;
-
-	res = cfg80211_inform_single_bss_data(wiphy, &inform_data, gfp);
-	if (!res)
-		return NULL;
-
-	/* don't do any further MBSSID/ML handling for S1G */
-	if (ext)
-		return res;
-
-	/* process each non-transmitting bss */
-	cfg80211_parse_mbssid_data(wiphy, &inform_data, res, gfp);
+		ftype = CFG80211_BSS_FTYPE_BEACON;
 
-	cfg80211_parse_ml_sta_data(wiphy, &inform_data, res, gfp);
-
-	return res;
+	return cfg80211_inform_bss_data(wiphy, data, ftype,
+					bssid, tsf, capability,
+					beacon_interval, ie, ielen,
+					gfp);
 }
 EXPORT_SYMBOL(cfg80211_inform_bss_frame_data);
 
-- 
2.34.1


