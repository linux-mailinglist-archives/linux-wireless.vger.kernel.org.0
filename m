Return-Path: <linux-wireless+bounces-16983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31379FFA5E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254477A202A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D61B424A;
	Thu,  2 Jan 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2BBgqmC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17F1B4233
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827632; cv=none; b=I2pMbAsau6FQMDzK8xBcEE/ArLmF73LhONyDgtp8Ojgqquwy+F6iff/ag3CEB7YVrYQkhvu1iexY80t/dDi26ZoZNd0nyf7JBK0u9HKZUUzmCqO7+MEsFO6QrPcx9eYJ+nAcsKj5lS/ToH0NNsrR4HBkFk4b62RC/zvDXJv1UrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827632; c=relaxed/simple;
	bh=+zNhoZ9QtSqC+/2DxO6GtoDNitjMjDHgzqgTWGKXVEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgbAzcjVz7bg3SEcxegO9N7TCoHRORgbQnYHyjG6X2L/E1asNO2Tb9r3fsbxC1lxwHU3R96nYUp11UEIb52ik/rPlVNTgiemlITZUxombdEkKKrwizSVn+ZRv69hNpGtb2P1bnYfaHe4PiUTmyLfiLpF1w7S2eE5ALQbP+lXhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2BBgqmC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827631; x=1767363631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zNhoZ9QtSqC+/2DxO6GtoDNitjMjDHgzqgTWGKXVEY=;
  b=C2BBgqmCEylizH0OGWFGpK2Xl9xoleyY+eXi6+qzEPqY+K02jazsze1D
   ECUUPlZOCZDQgiqa2dDFx+PqGgNsxyM07zmPsaC+NtoDopSj2FZ7xdvl/
   SsZkavpwEPUHppAqXT2VrsLuEHll5vk6NG8/BLVoJapV8xu+GXSCdnbVD
   fdICHDf7AM1fRHenniq5vhiDLDrGfIVaTanR3l6Z3xTPtY4ynHOhB0Ybu
   vJlFCKOcJ1XxNexrUa8yUDua3aTfQh3SL87h9+gAV0BVENWAOcwjUhUE9
   Vmb/A2HbcDHpWCql9XyM8xei4Dx/6XEUM9eDQri4Is1yxhQlegA4VbRUC
   A==;
X-CSE-ConnectionGUID: jghjRh2aRe+o2JB4/Ke5vQ==
X-CSE-MsgGUID: hlgRh0e9RS6iSUhFhuaeGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735106"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735106"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:31 -0800
X-CSE-ConnectionGUID: ST+lrMtESKWxJzr61s4JRA==
X-CSE-MsgGUID: bITWBi1jTpOtcASN1TyFeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357390"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/17] wifi: mac80211: Pull link space calculation to a function
Date: Thu,  2 Jan 2025 16:19:57 +0200
Message-Id: <20250102161730.ac16adfa39d4.I9e28c2fcd5ca252341c817fc03ea8df7b807fcbf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Pull the calculation of the size needed for a link in an association
request frame to a function, so it could also be used during the
construction of other frames as well, e.g., ML link configuration
request frame.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 84 ++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 50bbe4532ac1..390d4d994c6a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1989,6 +1989,55 @@ ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 	ieee80211_fragment_element(skb, ml_elem_len, WLAN_EID_FRAGMENT);
 }
 
+static int
+ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
+				 enum nl80211_iftype iftype,
+				 struct cfg80211_bss *cbss,
+				 size_t elems_len)
+{
+	struct ieee80211_local *local = sdata->local;
+	const struct ieee80211_sband_iftype_data *iftd;
+	struct ieee80211_supported_band *sband;
+	size_t size = 0;
+
+	if (!cbss)
+		return size;
+
+	sband = local->hw.wiphy->bands[cbss->channel->band];
+
+	/* add STA profile elements length */
+	size += elems_len;
+
+	/* and supported rates length */
+	size += 4 + sband->n_bitrates;
+
+	/* supported channels */
+	size += 2 + 2 * sband->n_channels;
+
+	iftd = ieee80211_get_sband_iftype_data(sband, iftype);
+	if (iftd)
+		size += iftd->vendor_elems.len;
+
+	/* power capability */
+	size += 4;
+
+	/* HT, VHT, HE, EHT */
+	size += 2 + sizeof(struct ieee80211_ht_cap);
+	size += 2 + sizeof(struct ieee80211_vht_cap);
+	size += 2 + 1 + sizeof(struct ieee80211_he_cap_elem) +
+		sizeof(struct ieee80211_he_mcs_nss_supp) +
+		IEEE80211_HE_PPE_THRES_MAX_LEN;
+
+	if (sband->band == NL80211_BAND_6GHZ)
+		size += 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);
+
+	size += 2 + 1 + sizeof(struct ieee80211_eht_cap_elem) +
+		sizeof(struct ieee80211_eht_mcs_nss_supp) +
+		IEEE80211_EHT_PPE_THRES_MAX_LEN;
+
+	return size;
+}
+
 static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -2027,42 +2076,15 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
-		const struct ieee80211_sband_iftype_data *iftd;
-		struct ieee80211_supported_band *sband;
+		size_t elems_len = assoc_data->link[link_id].elems_len;
 
 		if (!cbss)
 			continue;
 
-		sband = local->hw.wiphy->bands[cbss->channel->band];
-
 		n_links++;
-		/* add STA profile elements length */
-		size += assoc_data->link[link_id].elems_len;
-		/* and supported rates length */
-		size += 4 + sband->n_bitrates;
-		/* supported channels */
-		size += 2 + 2 * sband->n_channels;
-
-		iftd = ieee80211_get_sband_iftype_data(sband, iftype);
-		if (iftd)
-			size += iftd->vendor_elems.len;
-
-		/* power capability */
-		size += 4;
-
-		/* HT, VHT, HE, EHT */
-		size += 2 + sizeof(struct ieee80211_ht_cap);
-		size += 2 + sizeof(struct ieee80211_vht_cap);
-		size += 2 + 1 + sizeof(struct ieee80211_he_cap_elem) +
-			sizeof(struct ieee80211_he_mcs_nss_supp) +
-			IEEE80211_HE_PPE_THRES_MAX_LEN;
-
-		if (sband->band == NL80211_BAND_6GHZ)
-			size += 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);
-
-		size += 2 + 1 + sizeof(struct ieee80211_eht_cap_elem) +
-			sizeof(struct ieee80211_eht_mcs_nss_supp) +
-			IEEE80211_EHT_PPE_THRES_MAX_LEN;
+
+		size += ieee80211_link_common_elems_size(sdata, iftype, cbss,
+							 elems_len);
 
 		/* non-inheritance element */
 		size += 2 + 2 + PRESENT_ELEMS_MAX;
-- 
2.34.1


