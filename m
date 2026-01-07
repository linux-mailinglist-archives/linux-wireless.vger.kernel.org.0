Return-Path: <linux-wireless+bounces-30487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B521CCFE78A
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59E8B30AF559
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF1F34251C;
	Wed,  7 Jan 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fSaLcMYI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4992341ACA
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795840; cv=none; b=Gg2t21qtW+10OJcE70mvCP/iS5rK9NZQ6hH53T8d+7iXlWuzujQm/IfHunS/BMMGxmwfU7/Z4xlWV+Y6zVbdrrFm+auSvHDWKbZGn2TEuChGxUi2p5zMwpft1UnLpU5fzT0ejnUcrCHoKuUFulXkRElMfEldG0JyiJn74ADocqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795840; c=relaxed/simple;
	bh=4YW9+spz8ebbpiwz/Ju1ZKhPuPGZwxP4ePmWoy9eY5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBEPLZ4xjyKAobUl5uh8L3jCbjSsRkRRjCO9/mbjTn9flUFkMgI+J0+coj0NJn8w/CncQs0UgQrHv8n6vxMD1hw9/0CM7lUB2Wsga7dNDKcNxxFoFa28h1GcFzhqESLnCiIj2aElQU7+b+CowlEPnw3xgGbJCKyZHoSL6pH5zlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fSaLcMYI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X6Az7g7N7SpGDXP/uZdAFVZ1bMaRtq3NWLrJUKTzyeA=;
	t=1767795837; x=1769005437; b=fSaLcMYIDZyljjmARzqIYlUQcQutf8mIF0XiAKUjGPcL64L
	5Xaj/8snxy2JQAPUyHl+22xzKlHsTAZOrhDKdHHtXAEJ7meFgopB34cI3wYKxtxv8XhsHqm8eXxLw
	Q9XcrkvHXTYim34A4RDrqwpofzlpRefFqKgbqnP5AEur8oqdcq05A/5ovJbY3JuedcDS3z30NVnBk
	1q+AHCSHQ3340+m8kyGrd1GorRDf0nasZ+Ar1E9b88iGXg6oNoYuKkk8SyDbk0h93NgIJuah6HNQA
	P7gNM895sbOWNSwaGaQyl1K9aHusHMg6nLxeIXbCHRkcY8e2izmuW1i/xpdh85Vg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS3-00000005agF-2TYw;
	Wed, 07 Jan 2026 15:23:55 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 25/46] wifi: mac80211: don't consider the sband when processing capabilities
Date: Wed,  7 Jan 2026 15:22:24 +0100
Message-ID: <20260107152325.e9e54883718c.If994d6346f00219437e22043e7bf2395b827b34a@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
index 771f8433b3b9..90b94964102a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2133,12 +2133,13 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
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
index 1c82a28b03de..6da2b05be9ee 100644
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
index 3ce7412b4fcd..23ea3e39bdf8 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1022,7 +1022,8 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		ieee80211_chandef_ht_oper(elems->ht_operation, &chandef);
 
 		memcpy(&htcap_ie, elems->ht_cap_elem, sizeof(htcap_ie));
-		rates_updated |= ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+		rates_updated |= ieee80211_ht_cap_ie_to_sta_ht_cap(sdata,
+								   &sband->ht_cap,
 								   &htcap_ie,
 								   &sta->deflink);
 
@@ -1041,6 +1042,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 						   &chandef);
 			memcpy(&cap_ie, elems->vht_cap_elem, sizeof(cap_ie));
 			ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+							    &sband->vht_cap,
 							    &cap_ie, NULL,
 							    &sta->deflink);
 			if (memcmp(&cap, &sta->sta.deflink.vht_cap, sizeof(cap)))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 1e60597f032c..897550a07273 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2179,7 +2179,7 @@ void ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_sta_ht_cap *ht_cap);
 bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
-				       struct ieee80211_supported_band *sband,
+				       const struct ieee80211_sta_ht_cap *own_cap,
 				       const struct ieee80211_ht_cap *ht_cap_ie,
 				       struct link_sta_info *link_sta);
 void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
@@ -2262,6 +2262,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_sta_vht_cap *own_vht_cap,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
 				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta);
@@ -2302,6 +2303,12 @@ ieee80211_sta_rx_bw_to_chan_width(struct link_sta_info *sta);
 
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
index 04c931cd2063..1c4db6b86713 100644
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
index ddff090e7dce..588f89e7631d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5425,7 +5425,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 
 	/* Set up internal HT/VHT capabilities */
 	if (elems->ht_cap_elem && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT)
-		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, &sband->ht_cap,
 						  elems->ht_cap_elem,
 						  link_sta);
 
@@ -5461,6 +5461,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		}
 
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+						    &sband->vht_cap,
 						    elems->vht_cap_elem,
 						    bss_vht_cap, link_sta);
 		rcu_read_unlock();
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index b099d79e8fbb..d4fcb1c07313 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
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
@@ -130,23 +130,26 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
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
+		for (i = 0; i < sband->n_channels; i++) {
+			if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
+							IEEE80211_CHAN_NO_80MHZ))
+				continue;
+
+			have_80mhz = true;
+			break;
+		}
+
+		if (!have_80mhz)
+			return;
 	}
 
-	if (!have_80mhz)
-		return;
-
 	/*
 	 * A VHT STA must support 40 MHz, but if we verify that here
 	 * then we break a few things - some APs (e.g. Netgear R6300v2
@@ -156,7 +159,7 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 
 	vht_cap->vht_supported = true;
 
-	own_cap = sband->vht_cap;
+	own_cap = *own_vht_cap;
 	/*
 	 * If user has specified capability overrides, take care
 	 * of that if the station we're setting up is the AP that
-- 
2.52.0


