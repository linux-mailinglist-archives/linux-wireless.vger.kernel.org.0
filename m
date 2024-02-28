Return-Path: <linux-wireless+bounces-4152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B417986AA6D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436581F24170
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D933CC2;
	Wed, 28 Feb 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TqMN7+1U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D52E85A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110154; cv=none; b=qECkWDsDeeG0E9rG3SYkwxoXDAz0YDWwfKHKrkjHwAv7KsgrsR+84LzRyChx6PPjOjAthspbxE1JP1eFFacvCGGU38XKrrJ3smyAlAq0GRBkrlR5CrxZsEDsOLFunLh7rDKLMEqvko0QVSccV41p5Ze91mk0EZKqzUH5qEWD74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110154; c=relaxed/simple;
	bh=w5OJ7SG6m+y+ja+YxEgUDb3vB1FygnVhTTn9pf54x8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTRDQ1gZk6gWcfwm4L4uCthBo3m0egQgXkXseU/kDfr3bhUu9x9mRfM5KGBTl4/xweLQWoqTyo0QGbfFKb4UNKWXtp5xenPi9QVk6rXgEEfLuzU9Jq020FXm7QWt1T/XXeQIPt7ofvH/3dtk1B0Lh9eU1QO17Tz3OvxJbBwHDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TqMN7+1U; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fKy7hk9Gzp/aoBu5vFcT58jI969LD0613pV0ktQXC7Y=;
	t=1709110152; x=1710319752; b=TqMN7+1UaiwhEYl8dB3k7yS0RYNRA7+rZcIWY0DgPa339D/
	bvHDf2037/xvtJ1B5SgRsjGNeKm9nJy90NnOePASu4GFbA8bvzp2J4f1O4hdAUnbSYMEhet0ZdgVC
	wZVbIVs2ejx5PL8Mu2t0Rv33uj7PAxoydaLZuDIa4De9RxnaOTAZ0PN3mQGTzl/3r4RvEpQ1Sb/gl
	J2UcT1bK8ccmoa1naZCRNN16JlIse52ndn+4Gs9fc6cOx39G8sLQIhqevN9mSxjR9Txr3+kaPafBK
	2xq6+IwY4wxxuMIRryobuq8eapVDDiE9NCDWRPe71YFSc5Q8Z6xMREo9FD9MEKQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFck-0000000C0BC-1QK0;
	Wed, 28 Feb 2024 09:49:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 8/8] wifi: mac80211: hide element parsing internals
Date: Wed, 28 Feb 2024 09:48:16 +0100
Message-ID: <20240228094902.19c610b529e2.Ie7ea2dcb6713911590ace6583a4748f32dc37df2@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084901.18661-10-johannes@sipsolutions.net>
References: <20240228084901.18661-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Rework the data structures to hide element parsing internals
from the users.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  14 -----
 net/mac80211/parse.c       | 118 ++++++++++++++++++++++++-------------
 net/mac80211/tests/elems.c |   4 +-
 3 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 768f614731a7..a8ac238bd197 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1766,12 +1766,6 @@ struct ieee802_11_elems {
 	size_t ml_basic_len;
 	size_t ml_reconf_len;
 
-	/* The basic Multi-Link element in the original elements */
-	const struct element *ml_basic_elem;
-
-	/* The reconfiguration Multi-Link element in the original elements */
-	const struct element *ml_reconf_elem;
-
 	u8 ttlm_num;
 
 	/*
@@ -1784,14 +1778,6 @@ struct ieee802_11_elems {
 
 	/* whether/which parse error occurred while retrieving these elements */
 	u8 parse_error;
-
-	/*
-	 * scratch buffer that can be used for various element parsing related
-	 * tasks, e.g., element de-fragmentation etc.
-	 */
-	size_t scratch_len;
-	u8 *scratch_pos;
-	u8 scratch[] __counted_by(scratch_len);
 };
 
 static inline struct ieee80211_local *hw_to_local(
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 73e52504ed97..55e5497f8978 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -34,12 +34,32 @@
 #include "led.h"
 #include "wep.h"
 
+struct ieee80211_elems_parse {
+	/* must be first for kfree to work */
+	struct ieee802_11_elems elems;
+
+	/* The basic Multi-Link element in the original elements */
+	const struct element *ml_basic_elem;
+
+	/* The reconfiguration Multi-Link element in the original elements */
+	const struct element *ml_reconf_elem;
+
+	/*
+	 * scratch buffer that can be used for various element parsing related
+	 * tasks, e.g., element de-fragmentation etc.
+	 */
+	size_t scratch_len;
+	u8 *scratch_pos;
+	u8 scratch[] __counted_by(scratch_len);
+};
+
 static void
 ieee80211_parse_extension_element(u32 *crc,
 				  const struct element *elem,
-				  struct ieee802_11_elems *elems,
+				  struct ieee80211_elems_parse *elems_parse,
 				  struct ieee80211_elems_parse_params *params)
 {
+	struct ieee802_11_elems *elems = &elems_parse->elems;
 	const void *data = elem->data + 1;
 	bool calc_crc = false;
 	u8 len;
@@ -129,15 +149,15 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-				if (elems->ml_basic_elem) {
+				if (elems_parse->ml_basic_elem) {
 					elems->parse_error |=
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
 				}
-				elems->ml_basic_elem = (void *)elem;
+				elems_parse->ml_basic_elem = elem;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
-				elems->ml_reconf_elem = (void *)elem;
+				elems_parse->ml_reconf_elem = elem;
 				break;
 			default:
 				break;
@@ -169,9 +189,10 @@ ieee80211_parse_extension_element(u32 *crc,
 
 static u32
 _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
-			     struct ieee802_11_elems *elems,
+			     struct ieee80211_elems_parse *elems_parse,
 			     const struct element *check_inherit)
 {
+	struct ieee802_11_elems *elems = &elems_parse->elems;
 	const struct element *elem;
 	bool calc_crc = params->filter != 0;
 	DECLARE_BITMAP(seen_elems, 256);
@@ -586,7 +607,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 		case WLAN_EID_EXTENSION:
 			ieee80211_parse_extension_element(calc_crc ?
 								&crc : NULL,
-							  elem, elems, params);
+							  elem, elems_parse,
+							  params);
 			break;
 		case WLAN_EID_S1G_CAPABILITIES:
 			if (params->mode != IEEE80211_CONN_MODE_S1G)
@@ -709,9 +731,11 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 	return found ? profile_len : 0;
 }
 
-static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
-				       u8 link_id)
+static void
+ieee80211_mle_get_sta_prof(struct ieee80211_elems_parse *elems_parse,
+			   u8 link_id)
 {
+	struct ieee802_11_elems *elems = &elems_parse->elems;
 	const struct ieee80211_multi_link_elem *ml = elems->ml_basic;
 	ssize_t ml_len = elems->ml_basic_len;
 	const struct element *sub;
@@ -741,26 +765,27 @@ static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 		sta_prof_len =
 			cfg80211_defragment_element(sub,
 						    (u8 *)ml, ml_len,
-						    elems->scratch_pos,
-						    elems->scratch +
-							elems->scratch_len -
-							elems->scratch_pos,
+						    elems_parse->scratch_pos,
+						    elems_parse->scratch +
+							elems_parse->scratch_len -
+							elems_parse->scratch_pos,
 						    IEEE80211_MLE_SUBELEM_FRAGMENT);
 
 		if (sta_prof_len < 0)
 			return;
 
-		elems->prof = (void *)elems->scratch_pos;
+		elems->prof = (void *)elems_parse->scratch_pos;
 		elems->sta_prof_len = sta_prof_len;
-		elems->scratch_pos += sta_prof_len;
+		elems_parse->scratch_pos += sta_prof_len;
 
 		return;
 	}
 }
 
-static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
+static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 				     struct ieee80211_elems_parse_params *params)
 {
+	struct ieee802_11_elems *elems = &elems_parse->elems;
 	struct ieee80211_mle_per_sta_profile *prof;
 	struct ieee80211_elems_parse_params sub = {
 		.mode = params->mode,
@@ -772,26 +797,26 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 	const struct element *non_inherit = NULL;
 	const u8 *end;
 
-	ml_len = cfg80211_defragment_element(elems->ml_basic_elem,
+	ml_len = cfg80211_defragment_element(elems_parse->ml_basic_elem,
 					     elems->ie_start,
 					     elems->total_len,
-					     elems->scratch_pos,
-					     elems->scratch +
-						elems->scratch_len -
-						elems->scratch_pos,
+					     elems_parse->scratch_pos,
+					     elems_parse->scratch +
+						elems_parse->scratch_len -
+						elems_parse->scratch_pos,
 					     WLAN_EID_FRAGMENT);
 
 	if (ml_len < 0)
 		return;
 
-	elems->ml_basic = (const void *)elems->scratch_pos;
+	elems->ml_basic = (const void *)elems_parse->scratch_pos;
 	elems->ml_basic_len = ml_len;
-	elems->scratch_pos += ml_len;
+	elems_parse->scratch_pos += ml_len;
 
 	if (params->link_id == -1)
 		return;
 
-	ieee80211_mle_get_sta_prof(elems, params->link_id);
+	ieee80211_mle_get_sta_prof(elems_parse, params->link_id);
 	prof = elems->prof;
 
 	if (!prof)
@@ -816,57 +841,66 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 
 	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
 					     sub.start, sub.len);
-	_ieee802_11_parse_elems_full(&sub, elems, non_inherit);
+	_ieee802_11_parse_elems_full(&sub, elems_parse, non_inherit);
 }
 
 static void
-ieee80211_mle_defrag_reconf(struct ieee802_11_elems *elems)
+ieee80211_mle_defrag_reconf(struct ieee80211_elems_parse *elems_parse)
 {
+	struct ieee802_11_elems *elems = &elems_parse->elems;
 	ssize_t ml_len;
 
-	ml_len = cfg80211_defragment_element(elems->ml_reconf_elem,
+	ml_len = cfg80211_defragment_element(elems_parse->ml_reconf_elem,
 					     elems->ie_start,
 					     elems->total_len,
-					     elems->scratch_pos,
-					     elems->scratch +
-					     elems->scratch_len -
-					     elems->scratch_pos,
+					     elems_parse->scratch_pos,
+					     elems_parse->scratch +
+						elems_parse->scratch_len -
+						elems_parse->scratch_pos,
 					     WLAN_EID_FRAGMENT);
 	if (ml_len < 0)
 		return;
-	elems->ml_reconf = (void *)elems->scratch_pos;
+	elems->ml_reconf = (void *)elems_parse->scratch_pos;
 	elems->ml_reconf_len = ml_len;
-	elems->scratch_pos += ml_len;
+	elems_parse->scratch_pos += ml_len;
 }
 
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
+	struct ieee80211_elems_parse *elems_parse;
 	struct ieee802_11_elems *elems;
 	const struct element *non_inherit = NULL;
 	u8 *nontransmitted_profile;
 	int nontransmitted_profile_len = 0;
 	size_t scratch_len = 3 * params->len;
 
-	elems = kzalloc(struct_size(elems, scratch, scratch_len), GFP_ATOMIC);
-	if (!elems)
+	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
+
+	elems_parse = kzalloc(struct_size(elems_parse, scratch, scratch_len),
+			      GFP_ATOMIC);
+	if (!elems_parse)
 		return NULL;
+
+	elems_parse->scratch_len = scratch_len;
+	elems_parse->scratch_pos = elems_parse->scratch;
+
+	elems = &elems_parse->elems;
 	elems->ie_start = params->start;
 	elems->total_len = params->len;
-	elems->scratch_len = scratch_len;
-	elems->scratch_pos = elems->scratch;
 
-	nontransmitted_profile = elems->scratch_pos;
+	nontransmitted_profile = elems_parse->scratch_pos;
 	nontransmitted_profile_len =
 		ieee802_11_find_bssid_profile(params->start, params->len,
 					      elems, params->bss,
 					      nontransmitted_profile);
-	elems->scratch_pos += nontransmitted_profile_len;
+	elems_parse->scratch_pos += nontransmitted_profile_len;
 	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
 					     nontransmitted_profile,
 					     nontransmitted_profile_len);
 
-	elems->crc = _ieee802_11_parse_elems_full(params, elems, non_inherit);
+	elems->crc = _ieee802_11_parse_elems_full(params, elems_parse,
+						  non_inherit);
 
 	/* Override with nontransmitted profile, if found */
 	if (nontransmitted_profile_len) {
@@ -878,12 +912,12 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 			.link_id = params->link_id,
 		};
 
-		_ieee802_11_parse_elems_full(&sub, elems, NULL);
+		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-	ieee80211_mle_parse_link(elems, params);
+	ieee80211_mle_parse_link(elems_parse, params);
 
-	ieee80211_mle_defrag_reconf(elems);
+	ieee80211_mle_defrag_reconf(elems_parse);
 
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
diff --git a/net/mac80211/tests/elems.c b/net/mac80211/tests/elems.c
index 30fc0acb7ac2..a413ba29f759 100644
--- a/net/mac80211/tests/elems.c
+++ b/net/mac80211/tests/elems.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for element parsing
  *
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 #include <kunit/test.h>
 #include "../ieee80211_i.h"
@@ -69,7 +69,7 @@ static void mle_defrag(struct kunit *test)
 	if (IS_ERR_OR_NULL(parsed))
 		goto free_skb;
 
-	KUNIT_EXPECT_NOT_NULL(test, parsed->ml_basic_elem);
+	KUNIT_EXPECT_NOT_NULL(test, parsed->ml_basic);
 	KUNIT_EXPECT_EQ(test,
 			parsed->ml_basic_len,
 			2 /* control */ +
-- 
2.43.2


