Return-Path: <linux-wireless+bounces-4148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBF486AA69
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9451F245BB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C62E657;
	Wed, 28 Feb 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oq2/VRqt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651B2DF9C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110152; cv=none; b=Hecm75qrdCJ4F7hAjQ5Yq5VTlbsUu4JEeUKrTtJJqNNopHHY6UvfGj/0mZbNPjlqmeSLJA/jGtT6F1MgqaEQ9jDHlKbIOOOzJT9uVKCgl57mRlb3stfXcFXsGAuiV5fjfBnVXHHQU52iyjt1fJu/KpseXP9vlWeHl8ih/7Lku0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110152; c=relaxed/simple;
	bh=rTb15V8rDc7LSAzYJ0GUzTKgUwcZMpOmZl5oHUesEJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVarmno/pLor4eV8kMaT2nyy9P/alRxhNTfQQ887O0tKJCaW2hXFnqB3O03JSxYYW1/j/xZOpGHeyc6hSm1uakKxeKy24tNJyFo5CuhljvZWBS+dTmA3pP1afmcZRqy0B8F9/Iznbt+tokXeigTkcmRobJZ62E9Y1iFexbvZrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oq2/VRqt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ajKgSRWet0ej2y15vhBrgm2GY6PdeKA0gehcuNwkqiM=;
	t=1709110150; x=1710319750; b=oq2/VRqtWsTvmX1UkIKuHgoHkIzSIT6fNvH2l3ndTg8Zb16
	68lmPtMfoqTeRk7mAs/k0oQrzNKdk4YhAJKJjPLkWc4Le/9QimC4ma4fWIYJxTVcfVoZi0W6FKs0M
	Pwxo5tJFzb4Vnp+9CTKgegE+Ar6H5KI7yUV4RqPJgBHbEgnHtG8n0e/PuCgmUbJRNOeQG33ifXEAB
	AsQfZQpByX6qzLEw0nqQLmKefss42dBxfw7o7tgDw6pGTMAF0c4v//e4kK4q4cRAW42Dpr7FK+Zpv
	Csfr6GrWO+a6iYIiLSWT44fCip97Szjv8MJ5lmeOE+iOyHDg6+JnNFQhALFqUsvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFch-0000000C0BC-46t8;
	Wed, 28 Feb 2024 09:49:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 5/8] wifi: mac80211: simplify multi-link element parsing
Date: Wed, 28 Feb 2024 09:48:13 +0100
Message-ID: <20240228094902.e0115da4d2a6.I89a80f7387eabef8df3955485d4a583ed024c5b1@changeid>
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

We shouldn't assign elems->ml_basic{,len} before defragmentation,
and we don't need elems->ml_reconf{,len} at all since we don't do
defragmentation. Clean that up a bit. This does require always
defragmention even when it may not be needed, but that's easier
to reason about.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  6 ++----
 net/mac80211/mlme.c        |  6 ++----
 net/mac80211/parse.c       | 12 ++++--------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4bec625a84d1..e8ca9ad12e62 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1736,7 +1736,6 @@ struct ieee802_11_elems {
 	const struct ieee80211_eht_cap_elem *eht_cap;
 	const struct ieee80211_eht_operation *eht_operation;
 	const struct ieee80211_multi_link_elem *ml_basic;
-	const struct ieee80211_multi_link_elem *ml_reconf;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
 
@@ -1764,12 +1763,11 @@ struct ieee802_11_elems {
 
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t ml_basic_len;
-	size_t ml_reconf_len;
 
-	/* The basic Multi-Link element in the original IEs */
+	/* The basic Multi-Link element in the original elements */
 	const struct element *ml_basic_elem;
 
-	/* The reconfiguration Multi-Link element in the original IEs */
+	/* The reconfiguration Multi-Link element in the original elements */
 	const struct element *ml_reconf_elem;
 
 	u8 ttlm_num;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d5678a817771..f4544f167005 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5760,7 +5760,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 	u8 link_id;
 	u32 delay;
 
-	if (!ieee80211_vif_is_mld(&sdata->vif) || !elems->ml_reconf)
+	if (!ieee80211_vif_is_mld(&sdata->vif) || !elems->ml_reconf_elem)
 		return;
 
 	ml_len = cfg80211_defragment_element(elems->ml_reconf_elem,
@@ -5773,9 +5773,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 	if (ml_len < 0)
 		return;
 
-	elems->ml_reconf = (const void *)elems->scratch_pos;
-	elems->ml_reconf_len = ml_len;
-	ml = elems->ml_reconf;
+	ml = (const void *)elems->scratch_pos;
 
 	/* Directly parse the sub elements as the common information doesn't
 	 * hold any useful information.
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index d231aaecc219..8bdf6e7efa58 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -129,19 +129,15 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-				if (elems->ml_basic) {
+				if (elems->ml_basic_elem) {
 					elems->parse_error |=
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
 				}
 				elems->ml_basic_elem = (void *)elem;
-				elems->ml_basic = data;
-				elems->ml_basic_len = len;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
 				elems->ml_reconf_elem = (void *)elem;
-				elems->ml_reconf = data;
-				elems->ml_reconf_len = len;
 				break;
 			default:
 				break;
@@ -776,9 +772,6 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 	const struct element *non_inherit = NULL;
 	const u8 *end;
 
-	if (params->link_id == -1)
-		return;
-
 	ml_len = cfg80211_defragment_element(elems->ml_basic_elem,
 					     elems->ie_start,
 					     elems->total_len,
@@ -795,6 +788,9 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 	elems->ml_basic_len = ml_len;
 	elems->scratch_pos += ml_len;
 
+	if (params->link_id == -1)
+		return;
+
 	ieee80211_mle_get_sta_prof(elems, params->link_id);
 	prof = elems->prof;
 
-- 
2.43.2


