Return-Path: <linux-wireless+bounces-3673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FA1857C27
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0937BB21C1E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37F78671;
	Fri, 16 Feb 2024 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG1ZBQyd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80477F3F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084501; cv=none; b=FDDY/4Tz1OgJnv7q9kSiIsEm2jOaWp6izOtUUMRmre46jYv9a5h0TVSghVgmv89MpwK/zgwISU+1fYcVyI6DQ09pPBhgnDZk4IVkQHvwqTae7Sv1UYV4T1VA262kCGF1SKVGZRbyrDu9YcAxmGjdgz8+J6qw1iL7LXWneQWo24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084501; c=relaxed/simple;
	bh=oU0kMhfMl708n20leEkeT9QNrTLv/EetNUIlektje2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJqqzANYA9u/SU5/chgfGbQ0576r3jTgd/PILSBrtUFafLqiI5/PRRMYWMMnem5lsIYxWtvrPvT48HfdFzw3TvYqKs3eqylmZs+36W7qpAX+0/SVnyT3eIux+vtpVT17W6eZw9eC2BQF1PZ8tyRdjTggrIvdDAvXRvA4jJI+6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG1ZBQyd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084500; x=1739620500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oU0kMhfMl708n20leEkeT9QNrTLv/EetNUIlektje2s=;
  b=oG1ZBQydwX0XgaCGBMFaAv+zRnbnsA2qBwbumSCZnxhZd2nj4H+6OIrK
   U9LxLFmdkT8kUreT/OP2iLANZinLt5sFNxJlnTqmjJVWIhwxs+wsvlea1
   Gl3NrFRV7EPYTQUpZnYMANH8LuKF193KnZc0SUrJOYlW2OXiln655FC4J
   ViEMMmefR3FiS/0yOjS47O+7mBC/cxGZQzfDD0P4u0Qwe70/5TK/97E50
   e4SdsuvWWBAUxuWBr/2uNRlTm8CrmJBwPuF6JtlMDHgTd+KRcNhpJr1fK
   pOS2UhQM85bxuzd0RXTzfGUMq5L8OyLR98pQU0vtr3ooEZmkaojV3q2Ba
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321929"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321929"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795605"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/7] wifi: cfg80211: use ML element parsing helpers
Date: Fri, 16 Feb 2024 13:54:32 +0200
Message-Id: <20240216135047.4da47b1f035b.I437a5570ac456449facb0b147851ef24a1e473c2@changeid>
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

Use the existing ML element parsing helpers and add a new
one for this (ieee80211_mle_get_mld_id).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 38 ++++++++++++++++++++++++++++++++++++
 net/wireless/scan.c       | 41 ++++++++-------------------------------
 2 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 303c75459897..3385a2cc5b09 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5115,6 +5115,44 @@ static inline u16 ieee80211_mle_get_mld_capa_op(const u8 *data)
 	return get_unaligned_le16(common);
 }
 
+/**
+ * ieee80211_mle_get_mld_id - returns the MLD ID
+ * @data: pointer to the multi link element
+ *
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ *
+ * If the MLD ID is not present, 0 will be returned.
+ */
+static inline u8 ieee80211_mle_get_mld_id(const u8 *data)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	/*
+	 * common points now at the beginning of
+	 * ieee80211_mle_basic_common_info
+	 */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_MLD_ID))
+		return 0;
+
+	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_EML_CAPA)
+		common += 2;
+	if (control & IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP)
+		common += 2;
+
+	return *common;
+}
+
 /**
  * ieee80211_mle_size_ok - validate multi-link element size
  * @data: pointer to the element data
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index e46dfc71c497..7cf36b8d3ae7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2833,17 +2833,16 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	struct cfg80211_bss *bss;
 	u8 mld_id, reporter_link_id, bss_change_count;
 	u16 seen_links = 0;
-	const u8 *pos;
 	u8 i;
 
-	if (!ieee80211_mle_size_ok(elem->data + 1, elem->datalen - 1))
+	if (!ieee80211_mle_type_ok(elem->data + 1,
+				   IEEE80211_ML_CONTROL_TYPE_BASIC,
+				   elem->datalen - 1))
 		return;
 
-	ml_elem = (void *)elem->data + 1;
+	ml_elem = (void *)(elem->data + 1);
 	control = le16_to_cpu(ml_elem->control);
-	if (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE) !=
-	    IEEE80211_ML_CONTROL_TYPE_BASIC)
-		return;
+	ml_common_len = ml_elem->variable[0];
 
 	/* Must be present when transmitted by an AP (in a probe response) */
 	if (!(control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT) ||
@@ -2851,24 +2850,8 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	    !(control & IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP))
 		return;
 
-	ml_common_len = ml_elem->variable[0];
-
-	/* length + MLD MAC address */
-	pos = ml_elem->variable + 1 + 6;
-
-	reporter_link_id = pos[0];
-	pos += 1;
-
-	bss_change_count = pos[0];
-	pos += 1;
-
-	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY))
-		pos += 2;
-	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_EML_CAPA))
-		pos += 2;
-
-	/* MLD capabilities and operations */
-	pos += 2;
+	reporter_link_id = ieee80211_mle_get_link_id(elem->data + 1);
+	bss_change_count = ieee80211_mle_get_bss_param_ch_cnt(elem->data + 1);
 
 	/*
 	 * The MLD ID of the reporting AP is always zero. It is set if the AP
@@ -2876,15 +2859,7 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	 * relating to a nontransmitted BSS (matching the Multi-BSSID Index,
 	 * Draft P802.11be_D3.2, 35.3.4.2)
 	 */
-	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_MLD_ID)) {
-		mld_id = *pos;
-		pos += 1;
-	} else {
-		mld_id = 0;
-	}
-
-	/* Extended MLD capabilities and operations */
-	pos += 2;
+	mld_id = ieee80211_mle_get_mld_id(elem->data + 1);
 
 	/* Fully defrag the ML element for sta information/profile iteration */
 	mle = cfg80211_defrag_mle(elem, tx_data->ie, tx_data->ielen, gfp);
-- 
2.34.1


