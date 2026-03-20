Return-Path: <linux-wireless+bounces-33589-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAB9JXc6vWkN7wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33589-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 13:15:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A22D9FD7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872D23037D7A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 12:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7903594F;
	Fri, 20 Mar 2026 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC3jwfx0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CE17A586
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008948; cv=none; b=AoF6nJldmrgkHIf7IGdUFgThoBnt2WjBkUN3dZmrKTz9b3yooDHUJcvZd+Eqc0uhCcCxdJwk3yhmGaDUUD+xg9c9QuNSJX4CSxHOJ6topx356xH7O7ctoIlYzoyOU6vyWXpprRKmH1CU2EA630cT36/Gc4WX1P+BuK6JrkgYgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008948; c=relaxed/simple;
	bh=iU2js5ML1n19sjoKUVOU36QxwFM2aV+OKu47XXAqUPc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NogRs9lVyXxDha+n9VCtuF9H3/96t3iY+k6YpcHJ6Ty18DK78TOGqPgD9ThK4B1AphTF4z5BOIJojiRKuw9fv0i7nbaJi2uqbKyl8YkGmXoelO06gM2YtoKRxRQ8X/ji/nY/8zvpIh8whXsFAkOVxQpmv5+PrpUWrRIc0pC1YPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC3jwfx0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774008947; x=1805544947;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iU2js5ML1n19sjoKUVOU36QxwFM2aV+OKu47XXAqUPc=;
  b=iC3jwfx0Z7/FFB9/Im54B0EA9I/TWoTdKfr15BZEnPd6MfzlkM8P/bkk
   Vc5NvMwExOLby3ZK6FNOLWZcZM7BoeZH5bKe6hVkJIXNNpHp3d521eqE9
   sOU8M069h7zgg/fg0tSqrCkLYcu9J0Kmjcrb4BDNnlhLqAM/RWjvVLICw
   h8KBueVLxPzG6v5VvKcatpx5VTXzWwt3PyNXyazAkAlWVeVadz0BJsBX7
   3kRZt5ogW6fp70L//kXOclEnM/tcoV8oAt26sgB2Re9s3xpuABM5LNMBR
   5C9xwFkXNWnwyFKN/aUaA7ZQcRA/ciGt5WTFelSS13UHQ30VKp8K8uYHE
   A==;
X-CSE-ConnectionGUID: WzAl3o+5RkO74pyih5qO6g==
X-CSE-MsgGUID: a+A9ANZjToySoVsqs7RYTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75001615"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75001615"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:15:46 -0700
X-CSE-ConnectionGUID: vpw3y11ER6+qvM6LHDnKWQ==
X-CSE-MsgGUID: 5F+XtRB8SEGlpqUTCrouUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218631300"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:15:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next] wifi: mac80211: don't consider the sband when processing capabilities
Date: Fri, 20 Mar 2026 14:15:32 +0200
Message-Id: <20260320141504.e42ef1f0eabb.If994d6346f00219437e22043e7bf2395b827b34a@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33589-lists,linux-wireless=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F28A22D9FD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In NAN, we have one set of (HT, VHT, HE) capabilities for all bands,
which means that we will need to process those capabilities without a
given sband.

To prepare for that, remove the sband argument from
ieee80211_ht_cap_ie_to_sta_ht_cap and ieee80211_he_cap_ie_to_sta_he_cap
and pass our own capabilities instead.

For ieee80211_vht_cap_ie_to_sta_vht_cap, make the sband argument
optional, since it is also used to check if there is at least one channel
that supports 80 MHz.
(Note that this check doesn't make much sense, but this can be handled in
 a different patch.)

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c         |  3 ++-
 net/mac80211/he.c          | 37 ++++++++++++++++++++++++-------------
 net/mac80211/ht.c          |  6 +++---
 net/mac80211/ibss.c        |  4 +++-
 net/mac80211/ieee80211_i.h |  9 ++++++++-
 net/mac80211/mesh_plink.c  |  3 ++-
 net/mac80211/mlme.c        |  3 ++-
 net/mac80211/vht.c         | 33 ++++++++++++++++++---------------
 8 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ee64ac8e0f61..9aa4ae0621be 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2140,12 +2140,13 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		return -EINVAL;
 
 	if (params->ht_capa)
-		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, &sband->ht_cap,
 						  params->ht_capa, link_sta);
 
 	/* VHT can override some HT caps such as the A-MSDU max length */
 	if (params->vht_capa)
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+						    &sband->vht_cap,
 						    params->vht_capa, NULL,
 						    link_sta);
 
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index f7b05e59374c..93e0342cff4f 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -108,14 +108,13 @@ static void ieee80211_he_mcs_intersection(__le16 *he_own_rx, __le16 *he_peer_rx,
 }
 
 void
-ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
-				  struct ieee80211_supported_band *sband,
-				  const u8 *he_cap_ie, u8 he_cap_len,
-				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
-				  struct link_sta_info *link_sta)
+_ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
+				   const struct ieee80211_sta_he_cap *own_he_cap_ptr,
+				   const u8 *he_cap_ie, u8 he_cap_len,
+				   const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
+				   struct link_sta_info *link_sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
-	const struct ieee80211_sta_he_cap *own_he_cap_ptr;
 	struct ieee80211_sta_he_cap own_he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
@@ -125,12 +124,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	memset(he_cap, 0, sizeof(*he_cap));
 
-	if (!he_cap_ie)
-		return;
-
-	own_he_cap_ptr =
-		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
-	if (!own_he_cap_ptr)
+	if (!he_cap_ie || !own_he_cap_ptr || !own_he_cap_ptr->has_he)
 		return;
 
 	own_he_cap = *own_he_cap_ptr;
@@ -164,7 +158,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
-	if (sband->band == NL80211_BAND_6GHZ && he_6ghz_capa)
+	if (he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, link_sta);
 
 	ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80,
@@ -207,6 +201,23 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
+void
+ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
+				  struct ieee80211_supported_band *sband,
+				  const u8 *he_cap_ie, u8 he_cap_len,
+				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
+				  struct link_sta_info *link_sta)
+{
+	const struct ieee80211_sta_he_cap *own_he_cap =
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+
+	_ieee80211_he_cap_ie_to_sta_he_cap(sdata, own_he_cap, he_cap_ie,
+					   he_cap_len,
+					   (sband->band == NL80211_BAND_6GHZ) ?
+						he_6ghz_capa : NULL,
+					   link_sta);
+}
+
 void
 ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
 			const struct ieee80211_he_operation *he_op_ie)
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 33f1e1b235e9..410e2354f33a 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -136,7 +136,7 @@ void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
 
 
 bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
-				       struct ieee80211_supported_band *sband,
+				       const struct ieee80211_sta_ht_cap *own_cap_ptr,
 				       const struct ieee80211_ht_cap *ht_cap_ie,
 				       struct link_sta_info *link_sta)
 {
@@ -151,12 +151,12 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 
 	memset(&ht_cap, 0, sizeof(ht_cap));
 
-	if (!ht_cap_ie || !sband->ht_cap.ht_supported)
+	if (!ht_cap_ie || !own_cap_ptr->ht_supported)
 		goto apply;
 
 	ht_cap.ht_supported = true;
 
-	own_cap = sband->ht_cap;
+	own_cap = *own_cap_ptr;
 
 	/*
 	 * If user has specified capability over-rides, take care
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 0298272c37ec..1e1ab25d9d8d 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1014,7 +1014,8 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		ieee80211_chandef_ht_oper(elems->ht_operation, &chandef);
 
 		memcpy(&htcap_ie, elems->ht_cap_elem, sizeof(htcap_ie));
-		rates_updated |= ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+		rates_updated |= ieee80211_ht_cap_ie_to_sta_ht_cap(sdata,
+								   &sband->ht_cap,
 								   &htcap_ie,
 								   &sta->deflink);
 
@@ -1033,6 +1034,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 						   &chandef);
 			memcpy(&cap_ie, elems->vht_cap_elem, sizeof(cap_ie));
 			ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+							    &sband->vht_cap,
 							    &cap_ie, NULL,
 							    &sta->deflink);
 			if (memcmp(&cap, &sta->sta.deflink.vht_cap, sizeof(cap)))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fe53812eca95..bacb49ad2817 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2188,7 +2188,7 @@ void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_sta_ht_cap *ht_cap);
 bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
-				       struct ieee80211_supported_band *sband,
+				       const struct ieee80211_sta_ht_cap *own_cap,
 				       const struct ieee80211_ht_cap *ht_cap_ie,
 				       struct link_sta_info *link_sta);
 void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
@@ -2273,6 +2273,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_sta_vht_cap *own_vht_cap,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
 				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta);
@@ -2313,6 +2314,12 @@ ieee80211_sta_rx_bw_to_chan_width(struct link_sta_info *sta);
 
 /* HE */
 void
+_ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
+				   const struct ieee80211_sta_he_cap *own_he_cap,
+				   const u8 *he_cap_ie, u8 he_cap_len,
+				   const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
+				   struct link_sta_info *link_sta);
+void
 ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 7d823a55636f..803106fc3134 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -450,12 +450,13 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 		changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	sta->sta.deflink.supp_rates[sband->band] = rates;
 
-	if (ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+	if (ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, &sband->ht_cap,
 					      elems->ht_cap_elem,
 					      &sta->deflink))
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+					    &sband->vht_cap,
 					    elems->vht_cap_elem, NULL,
 					    &sta->deflink);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d40b7d43b14d..7fc5616cb244 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5586,7 +5586,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 
 	/* Set up internal HT/VHT capabilities */
 	if (elems->ht_cap_elem && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT)
-		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, &sband->ht_cap,
 						  elems->ht_cap_elem,
 						  link_sta);
 
@@ -5622,6 +5622,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		}
 
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+						    &sband->vht_cap,
 						    elems->vht_cap_elem,
 						    bss_vht_cap, link_sta);
 		rcu_read_unlock();
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 80120f9f17b6..a6570781740a 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018-2026 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -115,6 +115,7 @@ void ieee80211_apply_vhtcap_overrides(struct ieee80211_sub_if_data *sdata,
 void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_sta_vht_cap *own_vht_cap,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
 				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta)
@@ -122,7 +123,6 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->pub->vht_cap;
 	struct ieee80211_sta_vht_cap own_cap;
 	u32 cap_info, i;
-	bool have_80mhz;
 	u32 mpdu_len;
 
 	memset(vht_cap, 0, sizeof(*vht_cap));
@@ -130,22 +130,25 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	if (!link_sta->pub->ht_cap.ht_supported)
 		return;
 
-	if (!vht_cap_ie || !sband->vht_cap.vht_supported)
+	if (!vht_cap_ie || !own_vht_cap->vht_supported)
 		return;
 
-	/* Allow VHT if at least one channel on the sband supports 80 MHz */
-	have_80mhz = false;
-	for (i = 0; i < sband->n_channels; i++) {
-		if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
-						IEEE80211_CHAN_NO_80MHZ))
-			continue;
+	if (sband) {
+		/* Allow VHT if at least one channel on the sband supports 80 MHz */
+		bool have_80mhz = false;
 
-		have_80mhz = true;
-		break;
-	}
+		for (i = 0; i < sband->n_channels; i++) {
+			if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
+							IEEE80211_CHAN_NO_80MHZ))
+				continue;
 
-	if (!have_80mhz)
-		return;
+			have_80mhz = true;
+			break;
+		}
+
+		if (!have_80mhz)
+			return;
+	}
 
 	/*
 	 * A VHT STA must support 40 MHz, but if we verify that here
@@ -156,7 +159,7 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 
 	vht_cap->vht_supported = true;
 
-	own_cap = sband->vht_cap;
+	own_cap = *own_vht_cap;
 	/*
 	 * If user has specified capability overrides, take care
 	 * of that if the station we're setting up is the AP that
-- 
2.34.1


