Return-Path: <linux-wireless+bounces-18446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E017AA278D5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F6B188050E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D7216E29;
	Tue,  4 Feb 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdPig1WZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC42163AF
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691005; cv=none; b=LkrkeNdZvzaLsta1C/p7cSbd9RVa26/sPg+OQoXjv/vjf2mcDWpsK84FtTn3MA2Ew+g5xnY5VxKxR8J8C11zj0R/1zl1y8kf8SsTwCoLjdj4Dg2OqlbgFXaXMbqzF38HZ6YN7sMTj/8YtBKBVhlZSBzFOjnh46/49v0IhIkx1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691005; c=relaxed/simple;
	bh=t+deIdyCmvk1FEur4WeRssBNhqVH6PunIegI3E6mjo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdo675O5TH+a6hbL1x9+xPVybBVnt4wAA1S9yWjngkDsS16hqH+EdQPcC/trTwm9DxNx2fZV8/JG/+rjP7v2RgaqwG9WF0X7Br/NlGrx8yU3ElECWEKKBZSoOy4sGOD8txK0k1ch2g0XSKtRcqm9tFHwgEN1zJvE8h/G1oEkrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdPig1WZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691003; x=1770227003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+deIdyCmvk1FEur4WeRssBNhqVH6PunIegI3E6mjo8=;
  b=MdPig1WZKJjmyfyqIRf7cQVls5GKtKdb2LhqOQKQmkIZQLHPB2eJNwZi
   auaNZNlkg6gyWNJduMwlZ1NXjeMH3CE7daHyGcuasZXKh4aG8wM8TkMER
   pC5AUKTygX2rKGP57pZAxr/GH1jL4LV8n0axxu8fwUD434jncN6rYjh2k
   fJmpOtR1a0lbjmSPw7ry4NnLkNGY4ZGvi4CTVc3OVjhqms4urNit0KBZ+
   7QngoNYkpAT2Itu4GSVLPaZqVPkbVVodsAeWMrvQ0kZb8c93xKDGw+Mwu
   oV0mByWpl+yOS1dOHVArS5eLuUrKiSlOCnsQ73DluGJpfP5wMiPBkqIXs
   Q==;
X-CSE-ConnectionGUID: ryWsl1tjQgWa2gL2GTbpiw==
X-CSE-MsgGUID: CThwwXb8RTaQ3HsOGCriDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585395"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585395"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:44 -0800
X-CSE-ConnectionGUID: i6nsXv65Q2y1EeGdNfuaYQ==
X-CSE-MsgGUID: L7rjov1LSeSrSn/KP8yfwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696730"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 06/20] wifi: mac80211: fix MLE non-inheritance parsing
Date: Tue,  4 Feb 2025 19:42:03 +0200
Message-Id: <20250204193721.934e0a1e392e.If5b95dc3c80208e0c62d8895fb6152aa54b6620b@changeid>
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

The code is erroneously applying the non-inheritance element
to the inner elements rather than the outer, which is clearly
completely wrong. Fix it by finding the MLE basic element at
the beginning, and then applying the non-inheritance for the
outer parsing.

While at it, do some general cleanups such as not allowing
callers to try looking for a specific non-transmitted BSS
and link at the same time.

Fixes: 45ebac4f059b ("wifi: mac80211: Parse station profile from association response")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c  |   1 +
 net/mac80211/parse.c | 127 ++++++++++++++++++++++++++++---------------
 2 files changed, 83 insertions(+), 45 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 04e1ea43b2df..ca5eaa0bd6ed 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5052,6 +5052,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		parse_params.start = bss_ies->data;
 		parse_params.len = bss_ies->len;
 		parse_params.bss = cbss;
+		parse_params.link_id = -1;
 		bss_elems = ieee802_11_parse_elems_full(&parse_params);
 		if (!bss_elems) {
 			ret = false;
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index cd318c1c67be..3d5d6658fe8d 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -47,6 +47,8 @@ struct ieee80211_elems_parse {
 	/* The EPCS Multi-Link element in the original elements */
 	const struct element *ml_epcs_elem;
 
+	bool multi_link_inner;
+
 	/*
 	 * scratch buffer that can be used for various element parsing related
 	 * tasks, e.g., element de-fragmentation etc.
@@ -152,12 +154,11 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-				if (elems_parse->ml_basic_elem) {
+				if (elems_parse->multi_link_inner) {
 					elems->parse_error |=
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
 				}
-				elems_parse->ml_basic_elem = elem;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
 				elems_parse->ml_reconf_elem = elem;
@@ -866,21 +867,36 @@ ieee80211_mle_get_sta_prof(struct ieee80211_elems_parse *elems_parse,
 	}
 }
 
-static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
-				     struct ieee80211_elems_parse_params *params)
+static const struct element *
+ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
+			      struct ieee80211_elems_parse_params *params,
+			      struct ieee80211_elems_parse_params *sub)
 {
 	struct ieee802_11_elems *elems = &elems_parse->elems;
 	struct ieee80211_mle_per_sta_profile *prof;
-	struct ieee80211_elems_parse_params sub = {
-		.mode = params->mode,
-		.action = params->action,
-		.from_ap = params->from_ap,
-		.link_id = -1,
-	};
-	ssize_t ml_len = elems->ml_basic_len;
-	const struct element *non_inherit = NULL;
+	const struct element *tmp;
+	ssize_t ml_len;
 	const u8 *end;
 
+	if (params->mode < IEEE80211_CONN_MODE_EHT)
+		return NULL;
+
+	for_each_element_extid(tmp, WLAN_EID_EXT_EHT_MULTI_LINK,
+			       elems->ie_start, elems->total_len) {
+		const struct ieee80211_multi_link_elem *mle =
+			(void *)tmp->data + 1;
+
+		if (!ieee80211_mle_size_ok(tmp->data + 1, tmp->datalen - 1))
+			continue;
+
+		if (le16_get_bits(mle->control, IEEE80211_ML_CONTROL_TYPE) !=
+		    IEEE80211_ML_CONTROL_TYPE_BASIC)
+			continue;
+
+		elems_parse->ml_basic_elem = tmp;
+		break;
+	}
+
 	ml_len = cfg80211_defragment_element(elems_parse->ml_basic_elem,
 					     elems->ie_start,
 					     elems->total_len,
@@ -891,26 +907,26 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 					     WLAN_EID_FRAGMENT);
 
 	if (ml_len < 0)
-		return;
+		return NULL;
 
 	elems->ml_basic = (const void *)elems_parse->scratch_pos;
 	elems->ml_basic_len = ml_len;
 	elems_parse->scratch_pos += ml_len;
 
 	if (params->link_id == -1)
-		return;
+		return NULL;
 
 	ieee80211_mle_get_sta_prof(elems_parse, params->link_id);
 	prof = elems->prof;
 
 	if (!prof)
-		return;
+		return NULL;
 
 	/* check if we have the 4 bytes for the fixed part in assoc response */
 	if (elems->sta_prof_len < sizeof(*prof) + prof->sta_info_len - 1 + 4) {
 		elems->prof = NULL;
 		elems->sta_prof_len = 0;
-		return;
+		return NULL;
 	}
 
 	/*
@@ -919,13 +935,17 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 	 * the -1 is because the 'sta_info_len' is accounted to as part of the
 	 * per-STA profile, but not part of the 'u8 variable[]' portion.
 	 */
-	sub.start = prof->variable + prof->sta_info_len - 1 + 4;
+	sub->start = prof->variable + prof->sta_info_len - 1 + 4;
 	end = (const u8 *)prof + elems->sta_prof_len;
-	sub.len = end - sub.start;
+	sub->len = end - sub->start;
 
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     sub.start, sub.len);
-	_ieee802_11_parse_elems_full(&sub, elems_parse, non_inherit);
+	sub->mode = params->mode;
+	sub->action = params->action;
+	sub->from_ap = params->from_ap;
+	sub->link_id = -1;
+
+	return cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+				      sub->start, sub->len);
 }
 
 static void
@@ -973,15 +993,19 @@ ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
+	struct ieee80211_elems_parse_params sub = {};
 	struct ieee80211_elems_parse *elems_parse;
-	struct ieee802_11_elems *elems;
 	const struct element *non_inherit = NULL;
-	u8 *nontransmitted_profile;
-	int nontransmitted_profile_len = 0;
+	struct ieee802_11_elems *elems;
 	size_t scratch_len = 3 * params->len;
+	bool multi_link_inner = false;
 
 	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
 
+	/* cannot parse for both a specific link and non-transmitted BSS */
+	if (WARN_ON(params->link_id >= 0 && params->bss))
+		return NULL;
+
 	elems_parse = kzalloc(struct_size(elems_parse, scratch, scratch_len),
 			      GFP_ATOMIC);
 	if (!elems_parse)
@@ -998,34 +1022,47 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	ieee80211_clear_tpe(&elems->tpe);
 	ieee80211_clear_tpe(&elems->csa_tpe);
 
-	nontransmitted_profile = elems_parse->scratch_pos;
-	nontransmitted_profile_len =
-		ieee802_11_find_bssid_profile(params->start, params->len,
-					      elems, params->bss,
-					      nontransmitted_profile);
-	elems_parse->scratch_pos += nontransmitted_profile_len;
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     nontransmitted_profile,
-					     nontransmitted_profile_len);
+	/*
+	 * If we're looking for a non-transmitted BSS then we cannot at
+	 * the same time be looking for a second link as the two can only
+	 * appear in the same frame carrying info for different BSSes.
+	 *
+	 * In any case, we only look for one at a time, as encoded by
+	 * the WARN_ON above.
+	 */
+	if (params->bss) {
+		int nontx_len =
+			ieee802_11_find_bssid_profile(params->start,
+						      params->len,
+						      elems, params->bss,
+						      elems_parse->scratch_pos);
+		sub.start = elems_parse->scratch_pos;
+		sub.mode = params->mode;
+		sub.len = nontx_len;
+		sub.action = params->action;
+		sub.link_id = params->link_id;
+
+		/* consume the space used for non-transmitted profile */
+		elems_parse->scratch_pos += nontx_len;
+
+		non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+						     sub.start, nontx_len);
+	} else {
+		/* must always parse to get elems_parse->ml_basic_elem */
+		non_inherit = ieee80211_prep_mle_link_parse(elems_parse, params,
+							    &sub);
+		multi_link_inner = true;
+	}
 
 	elems->crc = _ieee802_11_parse_elems_full(params, elems_parse,
 						  non_inherit);
 
-	/* Override with nontransmitted profile, if found */
-	if (nontransmitted_profile_len) {
-		struct ieee80211_elems_parse_params sub = {
-			.mode = params->mode,
-			.start = nontransmitted_profile,
-			.len = nontransmitted_profile_len,
-			.action = params->action,
-			.link_id = params->link_id,
-		};
-
+	/* Override with nontransmitted/per-STA profile if found */
+	if (sub.len) {
+		elems_parse->multi_link_inner = multi_link_inner;
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-	ieee80211_mle_parse_link(elems_parse, params);
-
 	ieee80211_mle_defrag_reconf(elems_parse);
 
 	ieee80211_mle_defrag_epcs(elems_parse);
-- 
2.34.1


