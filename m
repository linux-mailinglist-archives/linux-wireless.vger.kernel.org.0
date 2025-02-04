Return-Path: <linux-wireless+bounces-18454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC0A278E2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539773A4AC6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3194217704;
	Tue,  4 Feb 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJkTKsLd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FF217677
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691031; cv=none; b=AHNfGAPy7hW+1U56ntTDDd0rM6PGP/dff8gTpnxIPJqsZIgTpShqL01pwNNFCyqPw+Wpr2JyMY9+oJvmtkAznCIbXf+OKzQM8QZcZ7vxRRoIJuP5ANIluY8hp9vyWM3g5xeAtGKL4iKLmimwSImCT5peIMdjP3ieO9L/7m+v1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691031; c=relaxed/simple;
	bh=Ad6SyXDH/D3yCAQiRWTQAt0njUH0qdg/79CSYbOmnMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NPBQaEMUdctuizkdXihQ4cVT2lUc5O9OVuv759M193bR6m7zHJjq1vIuwmNbg/FYhRpaq9MfKfPa1Y1XBICecn+841VrbWZLgj9A7dm6AerDsjDG4yCXabOS06jY9XTGhvZ+6sb3tQ8T9LKyHwAYEOqXnmH12xbvrtOOBDWX/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJkTKsLd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691029; x=1770227029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ad6SyXDH/D3yCAQiRWTQAt0njUH0qdg/79CSYbOmnMA=;
  b=OJkTKsLdyoDRalzeillXLKtu05bpRdCOPcESs8tTNTHDGiPspNuIrC8f
   Ph8yALTHp0tTgMfT922/fVL2cuCIOqnoFiYytSPR1fJ2nYb6xP8f5+lZF
   NWsh+8shkXDQpKoOuDTltHw1zrIpVs2UmxVv2gpZfRmghMdN0mRyoRfu6
   571HIKUcq/vGuTHoqOe+iGWpKyaz7LAW6mEw3U5tyoiEDn0s4dkJU6kAm
   ecspUcwTq84qOJt+FGgXboi2sSTQ2giVEkggpNOMzz+Ygjfni36bOLZkD
   8VePTtW2VnjveXyAss4Z5hdKbxKW28ZruIl+XI8sTdqiFGeJ7mUrCRmRA
   Q==;
X-CSE-ConnectionGUID: WwzwgdAURF68/kiubm/bIA==
X-CSE-MsgGUID: 8LyTI7aJRa+N9gthtpVB1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585458"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585458"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:00 -0800
X-CSE-ConnectionGUID: uf4E1xhlQmKkBDU/ircW/A==
X-CSE-MsgGUID: Kd9xuKGGSKy72KoONK+cHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696828"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/20] wifi: mac80211: aggregation: remove deflink accesses for MLO
Date: Tue,  4 Feb 2025 19:42:13 +0200
Message-Id: <20250204193721.c7da116d8a15.Id2c2dfbbe7451cc900ed88c5a81b33c55b4ab1cf@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

If a station has connected with MLO (as indicated by valid_links
being non-zero, even if that may have just a single bit set), it
necessarily supports EHT/aggregation, so we don't need to check
the deflink for those cases.

Add conditions so we can support removing the link it/we used to
associate on.

Note that we still use the statistics in the deflink, but that's
a whole different story we will need to address separately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/agg-rx.c | 22 +++++++++++++---------
 net/mac80211/agg-tx.c |  6 ++++--
 net/mac80211/tx.c     |  3 ++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index f3fbe5a4395e..aeb99d102c6e 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 /**
@@ -206,17 +206,19 @@ u8 ieee80211_retrieve_addba_ext_data(struct sta_info *sta,
 
 	elems = ieee802_11_parse_elems(elem_data, elem_len, true, NULL);
 
-	if (elems && !elems->parse_error && elems->addba_ext_ie) {
-		data = elems->addba_ext_ie->data;
+	if (!elems || elems->parse_error || !elems->addba_ext_ie)
+		goto free;
 
-		if (!sta->sta.deflink.eht_cap.has_eht || !buf_size)
-			goto free;
+	data = elems->addba_ext_ie->data;
 
+	if (buf_size &&
+	    (sta->sta.valid_links || sta->sta.deflink.eht_cap.has_eht)) {
 		buf_size_1k = u8_get_bits(elems->addba_ext_ie->data,
 					  IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
 		*buf_size |= (u16)buf_size_1k <<
 			     IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT;
 	}
+
 free:
 	kfree(elems);
 
@@ -258,7 +260,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	mgmt->u.action.u.addba_resp.timeout = cpu_to_le16(timeout);
 	mgmt->u.action.u.addba_resp.status = cpu_to_le16(status);
 
-	if (sta->sta.deflink.he_cap.has_he)
+	if (sta->sta.valid_links || sta->sta.deflink.he_cap.has_he)
 		ieee80211_add_addbaext(skb, req_addba_ext_data, buf_size);
 
 	ieee80211_tx_skb(sdata, skb);
@@ -293,7 +295,8 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (!sta->sta.deflink.ht_cap.ht_supported &&
+	if (!sta->sta.valid_links &&
+	    !sta->sta.deflink.ht_cap.ht_supported &&
 	    !sta->sta.deflink.he_cap.has_he) {
 		ht_dbg(sta->sdata,
 		       "STA %pM erroneously requests BA session on tid %d w/o HT\n",
@@ -309,7 +312,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (sta->sta.deflink.eht_cap.has_eht)
+	if (sta->sta.valid_links || sta->sta.deflink.eht_cap.has_eht)
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_EHT;
 	else if (sta->sta.deflink.he_cap.has_he)
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HE;
@@ -321,7 +324,8 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	 * and if buffer size does not exceeds max value */
 	/* XXX: check own ht delayed BA capability?? */
 	if (((ba_policy != 1) &&
-	     (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
+	     (sta->sta.valid_links ||
+	      !(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
 	    (buf_size > max_buf_size)) {
 		status = WLAN_STATUS_INVALID_QOS_PARAM;
 		ht_dbg_ratelimited(sta->sdata,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 92120f905149..63a5e48291ac 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -464,7 +464,8 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	sta->ampdu_mlme.addba_req_num[tid]++;
 	spin_unlock_bh(&sta->lock);
 
-	if (sta->sta.deflink.eht_cap.has_eht ||
+	if (sta->sta.valid_links ||
+	    sta->sta.deflink.eht_cap.has_eht ||
 	    ieee80211_hw_check(&local->hw, STRICT)) {
 		buf_size = local->hw.max_tx_aggregation_subframes;
 	} else if (sta->sta.deflink.he_cap.has_he) {
@@ -609,7 +610,8 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		 "Requested to start BA session on reserved tid=%d", tid))
 		return -EINVAL;
 
-	if (!pubsta->deflink.ht_cap.ht_supported &&
+	if (!pubsta->valid_links &&
+	    !pubsta->deflink.ht_cap.ht_supported &&
 	    !pubsta->deflink.vht_cap.vht_supported &&
 	    !pubsta->deflink.he_cap.has_he &&
 	    !pubsta->deflink.eht_cap.has_eht)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..b6962f799ce4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1182,7 +1182,8 @@ void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 	if (!ref || !(ref->ops->capa & RATE_CTRL_CAPA_AMPDU_TRIGGER))
 		return;
 
-	if (!sta || !sta->sta.deflink.ht_cap.ht_supported ||
+	if (!sta ||
+	    (!sta->sta.valid_links && !sta->sta.deflink.ht_cap.ht_supported) ||
 	    !sta->sta.wme || skb_get_queue_mapping(skb) == IEEE80211_AC_VO ||
 	    skb->protocol == sdata->control_port_protocol)
 		return;
-- 
2.34.1


