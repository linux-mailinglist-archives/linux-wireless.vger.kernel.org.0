Return-Path: <linux-wireless+bounces-16962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7F9FF2DD
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32573A05D2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9686318027;
	Wed,  1 Jan 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrzzcKXF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD6F9F8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707972; cv=none; b=qMpSTTUytuubnTf83pU/c351RlBS5GKBtPaSEgI94Bm3GoR5qiqdX595pQ9ZVFdUkURa8sO/5WdDrY7hbQoNwtn0iFgF4Wf9Cm+oHOqvG6p4/aPrGzYQ2ySZ3ULEV/sBgOB4KyLtIFXH9MlIFE7YxhchnP2GmMVoBpX1/bhK3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707972; c=relaxed/simple;
	bh=bslx3stSd5R4Bo9T2uwL/vRKYgk8OquxXs4GMzVi+8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDyU3ISHuKaYw2UfQU1MlBx/E9FDMsFcCVUSJtS0QZggzVLAV+CwKJJN+0nUnUx6vKrDKaiuQbpA4CoSf7Q2gWPdVg4tP3i1VsLYQpMxlfeZh9q8e3GxrfNJCXYQ0iY5gux7GUhaIoS2BRGChwTmbn1ujTRAZbVU9PN8OyiLW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrzzcKXF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707971; x=1767243971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bslx3stSd5R4Bo9T2uwL/vRKYgk8OquxXs4GMzVi+8I=;
  b=jrzzcKXFKfQCnZJzuY2SqN9Ml1gTbZ2Nl7Agd8UVebaZpX5lYrTpySVA
   bY8mnzClMlpQ4uwtRIKCnnLAACmsDpfz71xsRH85YYUsBYwN4VLUMwW5Y
   8dz84a4SitWv0T634gFgeJtNbE6UfWBkjOF9dhwb+kb601d62veDi5nBT
   /jaO3Np0zCWVb8xgf7IaKbW80gDrWKeXFubY74ulmDjB2N3DCBYg9T4dD
   Fu40J7WF4W284YKKDYMSWtB0oKhkBW/OgZc63GqNFLrjOk9fJr3BEYLj9
   7+erKChwkaITN6zt0yU/Iyygk6OGul2voBl0dwuDX9IVu7bSzuUh4VVCO
   g==;
X-CSE-ConnectionGUID: T5CKHAW5Qse7xOv4FyNzMw==
X-CSE-MsgGUID: fqsHwNuKT6aHlZnjofjZYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194431"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194431"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:11 -0800
X-CSE-ConnectionGUID: vgG4NZRYT06H3EjM47U1BA==
X-CSE-MsgGUID: Onlxud2BRPiK5UO1yUZT4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618926"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/19] wifi: mac80211: add HT and VHT basic set verification
Date: Wed,  1 Jan 2025 07:05:32 +0200
Message-Id: <20250101070249.6d5444ee6255.I66bcf6c2de3b9d3325e4ffd9f573f4cd26ce5685@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

So far we did not verify the HT and VHT basic MCS set. However, in
P802.11REVme/D7.0 (6.5.4.2.4) says that the MLME-JOIN.request shall
return an error if the VHT and HT basic set requirements are not met.

Also extend the tests a bit, and for that change the test sdata
registration to only have four spatial streams.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 124 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2547e0c9e77f..061d20ace29c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -342,6 +342,110 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	return IEEE80211_CONN_MODE_EHT;
 }
 
+static bool
+ieee80211_verify_sta_ht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_ht_operation *ht_op)
+{
+	struct ieee80211_sta_ht_cap sta_ht_cap;
+	int i;
+
+	if (sband->band == NL80211_BAND_6GHZ)
+		return true;
+
+	if (!ht_op)
+		return false;
+
+	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
+	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+
+	/*
+	 * P802.11REVme/D7.0 - 6.5.4.2.4
+	 * ...
+	 * If the MLME of an HT STA receives an MLME-JOIN.request primitive
+	 * with the SelectedBSS parameter containing a Basic HT-MCS Set field
+	 * in the HT Operation parameter that contains any unsupported MCSs,
+	 * the MLME response in the resulting MLME-JOIN.confirm primitive shall
+	 * contain a ResultCode parameter that is not set to the value SUCCESS.
+	 * ...
+	 */
+
+	/* Simply check that all basic rates are in the STA RX mask */
+	for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++) {
+		if ((ht_op->basic_set[i] & sta_ht_cap.mcs.rx_mask[i]) !=
+		    ht_op->basic_set[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool
+ieee80211_verify_sta_vht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     int link_id,
+				     struct ieee80211_supported_band *sband,
+				     const struct ieee80211_vht_operation *vht_op)
+{
+	struct ieee80211_sta_vht_cap sta_vht_cap;
+	u16 ap_min_req_set, sta_rx_mcs_map, sta_tx_mcs_map;
+	int nss;
+
+	if (sband->band != NL80211_BAND_5GHZ)
+		return true;
+
+	if (!vht_op)
+		return false;
+
+	memcpy(&sta_vht_cap, &sband->vht_cap, sizeof(sta_vht_cap));
+	ieee80211_apply_vhtcap_overrides(sdata, &sta_vht_cap);
+
+	ap_min_req_set = le16_to_cpu(vht_op->basic_mcs_set);
+	sta_rx_mcs_map = le16_to_cpu(sta_vht_cap.vht_mcs.rx_mcs_map);
+	sta_tx_mcs_map = le16_to_cpu(sta_vht_cap.vht_mcs.tx_mcs_map);
+
+	/*
+	 * Many APs are incorrectly advertising an all-zero value here,
+	 * which really means MCS 0-7 are required for 1-8 streams, but
+	 * they don't really mean it that way. Ignore that.
+	 */
+	if (!ap_min_req_set)
+		return true;
+
+	/*
+	 * P802.11REVme/D7.0 - 6.5.4.2.4
+	 * ...
+	 * If the MLME of a VHT STA receives an MLME-JOIN.request primitive
+	 * with a SelectedBSS parameter containing a Basic VHT-MCS And NSS Set
+	 * field in the VHT Operation parameter that contains any unsupported
+	 * <VHT-MCS, NSS> tuple, the MLME response in the resulting
+	 * MLME-JOIN.confirm primitive shall contain a ResultCode parameter
+	 * that is not set to the value SUCCESS.
+	 * ...
+	 */
+	for (nss = 8; nss > 0; nss--) {
+		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+		u8 sta_rx_val;
+		u8 sta_tx_val;
+
+		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+			continue;
+
+		sta_rx_val = (sta_rx_mcs_map >> (2 * (nss - 1))) & 3;
+		sta_tx_val = (sta_tx_mcs_map >> (2 * (nss - 1))) & 3;
+
+		if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    sta_rx_val < ap_op_val || sta_tx_val < ap_op_val) {
+			link_id_info(sdata, link_id,
+				     "Missing mandatory rates for %d Nss, rx %d, tx %d oper %d, disable VHT\n",
+				     nss, sta_rx_val, sta_tx_val, ap_op_val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool
 ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 				     int link_id,
@@ -946,6 +1050,26 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		link_id_info(sdata, link_id,
 			     "regulatory prevented using AP config, downgraded\n");
 
+	if (conn->mode >= IEEE80211_CONN_MODE_HT &&
+	    !ieee80211_verify_sta_ht_mcs_support(sdata, sband,
+						 elems->ht_operation)) {
+		conn->mode = IEEE80211_CONN_MODE_LEGACY;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling HT\n");
+	}
+
+	if (conn->mode >= IEEE80211_CONN_MODE_VHT &&
+	    !ieee80211_verify_sta_vht_mcs_support(sdata, link_id, sband,
+						  elems->vht_operation)) {
+		conn->mode = IEEE80211_CONN_MODE_HT;
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_40);
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling VHT\n");
+	}
+
 	if (conn->mode >= IEEE80211_CONN_MODE_HE &&
 	    (!ieee80211_verify_peer_he_mcs_support(sdata, link_id,
 						   (void *)elems->he_cap,
-- 
2.34.1


