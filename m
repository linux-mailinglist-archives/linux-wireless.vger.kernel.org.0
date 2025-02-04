Return-Path: <linux-wireless+bounces-18450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04FA278D9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DF0165922
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E4217659;
	Tue,  4 Feb 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCFVK9ex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4A21639B
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691012; cv=none; b=ZdqLDa8nYaoTQhqbJXmmHFY+x9PMkJQ4pvihgNjU49F9Gj2ZWM92N2nygo97HNPLR5lEpVxj3ns8iZM21QFy1ky9fdCwUmxgtV7Uvx9lYQyJuTfZogDRTexCX3MMP2u9Qljyq7tLFiOMRKTQhCRO5VbfDqKvXsGDDaUG3Gm/P+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691012; c=relaxed/simple;
	bh=2I8PgqOLhaIULXgMGm/Vt7DNJLhqjYNXMagjVfL3+8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bA0saHBTrP0G/5X/+NjdCsPbASkHE9WNKwlK3GRIeGhDTcLgNetTKmpSSK+DcIxuG1+J20BQT8QfJVCh7OfGBD7BtMQmn4n/S4vnTdhvEspPDhPyYsBbYHuQfNM13b7f6pNyOOnOS0nV7dfuQ2QI5uti/tIVAlbWFEU2uMQdh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCFVK9ex; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691010; x=1770227010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2I8PgqOLhaIULXgMGm/Vt7DNJLhqjYNXMagjVfL3+8I=;
  b=WCFVK9exNaccvLP6f5Q0nDiR5IFtiXOTBF6qeP8bbESaHJAIOLFpHbw3
   9TB5ei2yhTrUua85PBcS5LvcCombNECHhOs+IxLRSWUI6ilcK7y2s8K8e
   5dDNwwLnZIbW9iNAYcCzsT812fKjf5Hf+cYnX9EdNbT3Z0LAiGKtISmwm
   gKI+MmewQxrZPpT949JjOMj4FLL5TTkprkFacRRFvfQ5oG/NqH2boXPPV
   ZYxLQAQxp2Ztqr3RNWuOoxj2yyV4B35F+wAWnXhliNfQiTDoOBby0spmx
   l/md2txr/jqN9oSGhPjxrqCrF6Ttg2yKuscl2PjoKUVuPQlpAjZxNHSCJ
   w==;
X-CSE-ConnectionGUID: dkhgPvZiThiW5TDv3sFsTQ==
X-CSE-MsgGUID: oGkbdtPWSZe9iO/9/89vSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585421"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585421"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:50 -0800
X-CSE-ConnectionGUID: lo+r6nvGTZmydXrowRgQYw==
X-CSE-MsgGUID: bjBOI58uQlaUh2oJ6x9LNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696766"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/20] wifi: mac80211: add HT and VHT basic set verification
Date: Tue,  4 Feb 2025 19:42:07 +0200
Message-Id: <20250204193721.7dfdeb1235bb.I66bcf6c2de3b9d3325e4ffd9f573f4cd26ce5685@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
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
 net/mac80211/mlme.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 704fb0369cde..72d1a2724e78 100644
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


