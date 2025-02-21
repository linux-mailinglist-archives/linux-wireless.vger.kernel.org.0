Return-Path: <linux-wireless+bounces-19256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4BA3F1EC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 11:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4BC3B52BC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA82010EE;
	Fri, 21 Feb 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NynsG0nl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA25204C0F
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133504; cv=none; b=H2DV3gPnfWA7eruQAmb0zPOz5qE7dfqjYz5d7XH3w/6Qchvp1U1/p5EUZ0xWK6bxZV2kUP/fmcyvFsaAxBowXufx3yAK0ozbRLrZd6CEc/olPskfG30g6i7fzS3lq74e0m4LdNQfgEJcuGhyQNLY2LA2gCnWGs1NpdJ/JMJ+DDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133504; c=relaxed/simple;
	bh=MBSlFCmOw33umDkhVBn/2irtz5pIk5Lp2bfyGRDPkD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GwoKqwp1QQVdzYw4ZQeGsCwsp2AvlW2qe/72N6ZG+/7ayooN4yTn4Bodj5fcqRvBW5accWyvnnPjRcikh/Qo3bDfC/HATnlb8djLkZRGFVKja1bHQlEBNTOn8YXv4N2jLlTL1mL/B6Bfoxs7ixFFLuKVDIvV0BZ13Tm+2XgiRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NynsG0nl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=vZ1AgvTvKr0FfIrmSzvhe0N3Tf7HA/2g5lNUDjnBwGk=; t=1740133502; x=1741343102; 
	b=NynsG0nlpX2DQTISFz2HE3KQLF/wgFEv/VflGEhG+giCg7i3O44fCB6qrerfmqh3iEz6WxlswGr
	ZophlRVRssBn4tZS9XzY+YZaYoPqcNy4aajTp7XU/B0xXYT0wotk1bh2tJM3FG3wAuNoUbWg8ydD/
	sWN+2EI01oPJuE/yyR01yRZ0nIhKmOg9XEMhb94AliL+bCRpiafYgqEqeP8aCA5fMzWBH7D21eQei
	ApcQ1Fh9MZvM38TYvRnjxFOljvQakHbFPX1DAq1cnvLZT2LE4elMNLUdMVMWClYK9GoGdIMf9gy35
	qn074lpOQbQvdaT8h2o7eXcl/yBJFcn90Bgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tlQDG-00000005Cok-1Ilw;
	Fri, 21 Feb 2025 11:24:54 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 1/2] wifi: mac80211: fix MLE non-inheritance parsing
Date: Fri, 21 Feb 2025 11:24:50 +0100
Message-ID: <20250221112451.b46d42f45b66.If5b95dc3c80208e0c62d8895fb6152aa54b6620b@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c  |   1 +
 net/mac80211/parse.c | 127 ++++++++++++++++++++++++++++---------------
 2 files changed, 83 insertions(+), 45 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f8d52b3b0d0e..36a9be9a66c8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4959,6 +4959,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
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
2.48.1


