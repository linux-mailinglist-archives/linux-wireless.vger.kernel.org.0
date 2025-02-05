Return-Path: <linux-wireless+bounces-18508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87AA286D1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39639166A28
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8D22ACD7;
	Wed,  5 Feb 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KB3YeRUc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AE22A7F3
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748416; cv=none; b=IVJceAAHcqL7JtkhbEhnC8IqOy0aZeHsi1pDLXJNnIG0p6sM6zvlrmrxSz5/rasMwaDqp3vaLt5tcTBssWLwQ1jVvzo5LPUTynDU2Qjn3jpATqedEPLb/fBhfXo0LP6qc3K7uOyiU2YjSxrIMmH3v1KMPh21l55L8ZOtZDA6h7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748416; c=relaxed/simple;
	bh=Ad6SyXDH/D3yCAQiRWTQAt0njUH0qdg/79CSYbOmnMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neKWJGRF+W3RwNDo1BNYNSwHi9BtJ93KwNncLLGjqeZiYLYd+WbqOc/1/lrHgUsfwBycdmN2EO5+lWtuBUtFL9gbUG3m7KILF8ncSZRL1W0kFbYAOiSTMhCm70jVhnzWLZYGQn1spZBHtyMnppvkGuaWHxDB2yNZQznNBbZXW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KB3YeRUc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748414; x=1770284414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ad6SyXDH/D3yCAQiRWTQAt0njUH0qdg/79CSYbOmnMA=;
  b=KB3YeRUcl9aUlexxWaSzo2zqfij9BcwQddiNjbGg/1whEc85LDdca6r3
   eG3wg+Bfct2ZzWto8DqwyVlyufilEd7ZmWUKxtv5PwIqGYn3ygAERd0l5
   +xT42sgFTDwabvnDgGFYXKR3JzIL5ofBE01Mfirl4c3yhCMOZaltK24Ks
   23P59T8hxsKL7u74ovrpG8KKpQ2/07i7XeMPdEULZWbe9VP2ZcSMZa2CR
   G+8V7/CK474w6SPhoOVPg1OZIetc8S5pYEvzh93zzbrCIyEh+S59DlceS
   8UacudzW3tChUtF54kxSZwlCom7hFx5YlxXSl4kW8iGCrGL/QzhDGRfk1
   A==;
X-CSE-ConnectionGUID: CJgPmNJQRUGA6lBl+4L0Vw==
X-CSE-MsgGUID: ttRSA0+ASKi4/uR6iwtNfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225257"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225257"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:08 -0800
X-CSE-ConnectionGUID: xphm9WdhQ6y/4a6OAeTVkA==
X-CSE-MsgGUID: YlL3DxZVQ/+7XP1tEfbbgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845330"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/17] wifi: mac80211: aggregation: remove deflink accesses for MLO
Date: Wed,  5 Feb 2025 11:39:24 +0200
Message-Id: <20250205110958.daf2a9e367f2.Id2c2dfbbe7451cc900ed88c5a81b33c55b4ab1cf@changeid>
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


