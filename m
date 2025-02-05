Return-Path: <linux-wireless+bounces-18502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4346A286CB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983C916746E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0F22A7E4;
	Wed,  5 Feb 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ke0H3kCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DA22ACF7
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748400; cv=none; b=VHgCzFGwHL5HazZcShkvVEeyfR/BXumA9HOUaWhjgm6iWLKxlezBzzjMxydQzCiFDkOJAVU3QpBbviNB93eRxxTN6j24AK7xD4oAMBOC/WBYi+NfTCBFm+pgN8pvDFrna4Wm9wOJHuv2LKTnLOJddEOM1g5p+58AYc+uQe2BKPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748400; c=relaxed/simple;
	bh=FqtZyAC2D3Xah3lzXOyckJ4x2XzFNFCOT0x7bsBFqiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABMYHJwQ21NLFot6WvrImepMxHLdj+8nM5nw7r9blkSI5woX7z5IdmatuXU+30OqH1r0ZwirihP0Ry44C8EfTJ0wv3qglfLEojEAEEFFiv2TCAeuZrAtsk3xUBUnQ6fMZNafwP0MnJLv0XkE06A6FWylIfQmKgZLO1aZ5fAVVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ke0H3kCs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748398; x=1770284398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqtZyAC2D3Xah3lzXOyckJ4x2XzFNFCOT0x7bsBFqiM=;
  b=Ke0H3kCs0ATfzV6PcnvmzftPpyE/chCU2YbsXHL1D5Qn1+PAWLBy+aLq
   ikXtzr+itbPqne6ls9A8L0GLBZx/N6Fos06PzzZwORgpn9RUgCFPA4shv
   rS8fXkh5qx0ulb5tFTYIQww3RvUSi63Hz75Kr4kvlqOIUqg3ck9AwxYYP
   1or9FuHrld1kFHzLLcStknTzE+Zquj4i+MSo3JMDnK8Mbq+DPQ405lZ1O
   GYHk2WTlTJEJrtm5nA5xJ+T/fm9iDuaks1BsnQmRkmAXPRIMONd8z35yQ
   Jpr8A4JywKk+CiqtIhG4WoLsTHs5bApvAa8nrmY3wYfGquY8N4M5toTS+
   Q==;
X-CSE-ConnectionGUID: Z7QFzQk5TiqZteklGm/K4A==
X-CSE-MsgGUID: Ru7sylZeQumSiKkn1Y2XYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225229"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225229"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:58 -0800
X-CSE-ConnectionGUID: 6+wJUgAXQvaF4U2ahUhFrA==
X-CSE-MsgGUID: 4JObvzlwRAqMtJGVskP8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845295"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/17] wifi: mac80211: add HT and VHT basic set verification
Date: Wed,  5 Feb 2025 11:39:18 +0200
Message-Id: <20250205110958.e2d8d4095f6b.I66bcf6c2de3b9d3325e4ffd9f573f4cd26ce5685@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
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

Given broken APs, apply VHT basic MCS/NSS set checks only in
strict mode.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a963e020a249..3749b3e23bb7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -345,6 +345,115 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
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
+	 * they don't really mean it that way.
+	 * Some other APs are incorrectly advertising 3 spatial streams
+	 * with MCS 0-7 are required, but don't really mean it that way
+	 * and we'll connect only with HT, rather than even HE.
+	 * As a result, unfortunately the VHT basic MCS/NSS set cannot
+	 * be used at all, so check it only in strict mode.
+	 */
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT))
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
@@ -1042,6 +1151,26 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
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


