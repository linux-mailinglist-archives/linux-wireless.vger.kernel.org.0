Return-Path: <linux-wireless+bounces-2720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9AA841338
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B4A1C24233
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A36335B5;
	Mon, 29 Jan 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TkqF7Xln"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D276041
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556058; cv=none; b=mpMaj1jWZn2L1Q8zMOU7MgHEiC3GUgGgQjk6Q0xYyqsPaJa/2z6tdf/POYcGqLWdMWs7B+j5HUxG2YOD/6aAFs98eow2BYNkyBWU1dCGG0XBhPnkCUxAWcFhSwumoWm/7FT1QwquJaNpwXmsr+T2ELPNe/8+80HxnFNgDYg+V0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556058; c=relaxed/simple;
	bh=gl1jTBoMkGV2RYyuS6xBMWAjZZESOL8VVhzuWeOEst4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InbVC9CHK5IorkNnidfCzIubncg4PZeT3VDhwHzDIDrQRoqwQfxkCzu6dJnyYu5fkbyWtHeZDBWUlRjksS5qKmjMANxn+IetLsp048RjHZqmC/WZrwfFFo3etKAAKbOjqIYimSO3DUOUQm1pj7IjbUA47Db7UtVtpFPINk7Ci/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TkqF7Xln; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lvMJp5VjFgNg3MPlf8CU3aRA4r78px1Wh0LhQUEGNMI=;
	t=1706556055; x=1707765655; b=TkqF7XlnZJ6hMO/MOC34nruNzVaaRF2dDzZ2F9iSGxEiuT0
	eyqOvgvbdvHQ8j+wRj+JTM2B/PF6ufP3QK+qvw3aEd6/1IdFj3+URwijv+3O46k4z4nCKtDWJe7zx
	E1grY+Ff2cMD4VGZJmodD2lPwYCnzqjrK2ipD2f/AXwxzM/xpVJR04Cnc3wNSv35W83SkDLVw6r4j
	aUzLeCzvD/8U31asb7FFlQjC5ha4ofM1Do1V2fakIyvlCDj5cKmuOiDTTydIeg11YdmmqG0r7yeX9
	ldejQzSJDeSGkEVDVJ1osMXw9Yjy7WU0dmiOAhO74jIbkjmGuev7OcQ4Gn0YKFFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBc-000000050Z6-1sv2;
	Mon, 29 Jan 2024 20:20:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/10] wifi: mac80211: convert ieee80211_ie_build_eht_cap() to SKB use
Date: Mon, 29 Jan 2024 20:19:36 +0100
Message-ID: <20240129202041.ece9769e3c94.Ibd17bea6311f0c7ba56f6c1803fa3208abaaebb9@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192041.58481-12-johannes@sipsolutions.net>
References: <20240129192041.58481-12-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Convert ieee80211_ie_build_eht_cap() to the SKB-put function
style, renaming it to ieee80211_put_eht_cap().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 10 ++---
 net/mac80211/mesh.c        | 17 +--------
 net/mac80211/mlme.c        | 39 +-------------------
 net/mac80211/tdls.c        | 20 ++--------
 net/mac80211/util.c        | 75 +++++++++++++++-----------------------
 5 files changed, 42 insertions(+), 119 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index de0fdbd366c5..f3edb1a148a7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2527,6 +2527,10 @@ int ieee80211_put_he_cap(struct sk_buff *skb,
 int ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
 			      struct ieee80211_sub_if_data *sdata,
 			      enum ieee80211_smps_mode smps_mode);
+int ieee80211_put_eht_cap(struct sk_buff *skb,
+			  struct ieee80211_sub_if_data *sdata,
+			  const struct ieee80211_supported_band *sband,
+			  const struct ieee80211_conn_settings *conn);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
@@ -2651,12 +2655,6 @@ void ieee80211_init_frag_cache(struct ieee80211_fragment_cache *cache);
 void ieee80211_destroy_frag_cache(struct ieee80211_fragment_cache *cache);
 
 u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata);
-u8 *ieee80211_ie_build_eht_cap(const struct ieee80211_conn_settings *conn,
-			       u8 *pos,
-			       const struct ieee80211_sta_he_cap *he_cap,
-			       const struct ieee80211_sta_eht_cap *eht_cap,
-			       u8 *end,
-			       bool for_ap);
 
 void
 ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index cb217657c42e..49f79512c144 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -636,31 +636,18 @@ int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
 int mesh_add_eht_cap_ie(struct ieee80211_sub_if_data *sdata,
 			struct sk_buff *skb, u8 ie_len)
 {
-	const struct ieee80211_sta_he_cap *he_cap;
-	const struct ieee80211_sta_eht_cap *eht_cap;
 	struct ieee80211_supported_band *sband;
-	u8 *pos;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
 		return -EINVAL;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
-	eht_cap = ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
-	if (!he_cap || !eht_cap ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	if (sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
 	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
-	if (skb_tailroom(skb) < ie_len)
-		return -ENOMEM;
-
-	pos = skb_put(skb, ie_len);
-	ieee80211_ie_build_eht_cap(NULL, pos, he_cap, eht_cap, pos + ie_len,
-				   false);
-
-	return 0;
+	return ieee80211_put_eht_cap(skb, sdata, sband, NULL);
 }
 
 int mesh_add_eht_oper_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *skb)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fcef7ef68389..c21dbc5fed13 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1038,41 +1038,6 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	return mu_mimo_owner;
 }
 
-static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
-				 struct sk_buff *skb,
-				 struct ieee80211_supported_band *sband,
-				 const struct ieee80211_conn_settings *conn)
-{
-	u8 *pos, *pre_eht_pos;
-	const struct ieee80211_sta_he_cap *he_cap;
-	const struct ieee80211_sta_eht_cap *eht_cap;
-	u8 eht_cap_size;
-
-	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
-	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
-
-	/*
-	 * EHT capabilities element is only added if the HE capabilities element
-	 * was added so assume that 'he_cap' is valid and don't check it.
-	 */
-	if (WARN_ON(!he_cap || !eht_cap))
-		return;
-
-	eht_cap_size =
-		2 + 1 + sizeof(eht_cap->eht_cap_elem) +
-		ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
-					   &eht_cap->eht_cap_elem,
-					   false) +
-		ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
-				       eht_cap->eht_cap_elem.phy_cap_info);
-	pos = skb_put(skb, eht_cap_size);
-	pre_eht_pos = pos;
-	pos = ieee80211_ie_build_eht_cap(conn, pos, he_cap, eht_cap,
-					 pos + eht_cap_size, false);
-	/* trim excess if any */
-	skb_trim(skb, skb->len - (pre_eht_pos + eht_cap_size - pos));
-}
-
 static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 				      enum nl80211_chan_width width,
 				      struct ieee80211_supported_band *sband,
@@ -1393,8 +1358,8 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 	present_elems = NULL;
 
 	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_EHT)
-		ieee80211_add_eht_ie(sdata, skb, sband,
-				     &assoc_data->link[link_id].conn);
+		ieee80211_put_eht_cap(skb, sdata, sband,
+				      &assoc_data->link[link_id].conn);
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		ieee80211_add_aid_request_ie(sdata, skb);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 3f9c2b2771c6..42d9c06cbb84 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -575,22 +575,10 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	}
 
 	/* build the EHT-cap from sband */
-	if (he_cap && eht_cap &&
-	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
-	     action_code == WLAN_TDLS_SETUP_RESPONSE ||
-	     action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES)) {
-		u8 cap_size;
-
-		cap_size =
-			2 + 1 + sizeof(eht_cap->eht_cap_elem) +
-			ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
-						   &eht_cap->eht_cap_elem, false) +
-			ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
-					       eht_cap->eht_cap_elem.phy_cap_info);
-		pos = skb_put(skb, cap_size);
-		ieee80211_ie_build_eht_cap(NULL, pos, he_cap, eht_cap,
-					   pos + cap_size, false);
-	}
+	if (action_code == WLAN_TDLS_SETUP_REQUEST ||
+	    action_code == WLAN_TDLS_SETUP_RESPONSE ||
+	    action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES)
+		ieee80211_put_eht_cap(skb, sdata, sband, NULL);
 
 	/* add any remaining IEs */
 	if (extra_ies_len) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4dcb62e9d4c6..627bd5a8bda5 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1199,8 +1199,6 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
-	const struct ieee80211_sta_he_cap *he_cap;
-	const struct ieee80211_sta_eht_cap *eht_cap;
 	int i, err;
 	size_t noffset;
 	u32 rate_flags;
@@ -1359,22 +1357,12 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 			return err;
 	}
 
-	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
-	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
-
-	if (eht_cap &&
-	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
+	if (cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE |
 					 IEEE80211_CHAN_NO_EHT)) {
-		u8 *pos = skb_tail_pointer(skb);
-		u8 *end = pos + skb_tailroom(skb);
-
-		pos = ieee80211_ie_build_eht_cap(NULL, pos, he_cap, eht_cap,
-						 end,
-						 sdata->vif.type == NL80211_IFTYPE_AP);
-		if (!pos)
-			return -ENOBUFS;
-		skb_put(skb, pos - skb_tail_pointer(skb));
+		err = ieee80211_put_eht_cap(skb, sdata, sband, NULL);
+		if (err)
+			return err;
 	}
 
 	err = ieee80211_put_he_6ghz_cap(skb, sdata, IEEE80211_SMPS_OFF);
@@ -4175,7 +4163,7 @@ u16 ieee80211_encode_usf(int listen_interval)
 	return (u16) listen_interval;
 }
 
-/* this may return more than ieee80211_ie_build_eht_cap() will need */
+/* this may return more than ieee80211_put_eht_cap() will need */
 u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap;
@@ -4205,25 +4193,28 @@ u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata)
 	return 0;
 }
 
-u8 *ieee80211_ie_build_eht_cap(const struct ieee80211_conn_settings *conn,
-			       u8 *pos,
-			       const struct ieee80211_sta_he_cap *he_cap,
-			       const struct ieee80211_sta_eht_cap *eht_cap,
-			       u8 *end, bool for_ap)
+int ieee80211_put_eht_cap(struct sk_buff *skb,
+			  struct ieee80211_sub_if_data *sdata,
+			  const struct ieee80211_supported_band *sband,
+			  const struct ieee80211_conn_settings *conn)
 {
-	struct ieee80211_eht_cap_elem_fixed fixed, *out;
+	const struct ieee80211_sta_he_cap *he_cap =
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	const struct ieee80211_sta_eht_cap *eht_cap =
+		ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
+	bool for_ap = sdata->vif.type == NL80211_IFTYPE_AP;
+	struct ieee80211_eht_cap_elem_fixed fixed;
 	struct ieee80211_he_cap_elem he;
 	u8 mcs_nss_len, ppet_len;
 	u8 orig_mcs_nss_len;
 	u8 ie_len;
-	u8 *orig_pos = pos;
 
 	if (!conn)
 		conn = &ieee80211_conn_settings_unlimited;
 
 	/* Make sure we have place for the IE */
 	if (!he_cap || !eht_cap)
-		return orig_pos;
+		return 0;
 
 	orig_mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
 						      &eht_cap->eht_cap_elem,
@@ -4266,16 +4257,13 @@ u8 *ieee80211_ie_build_eht_cap(const struct ieee80211_conn_settings *conn,
 					  fixed.phy_cap_info);
 
 	ie_len = 2 + 1 + sizeof(eht_cap->eht_cap_elem) + mcs_nss_len + ppet_len;
-	if ((end - pos) < ie_len)
-		return orig_pos;
+	if (skb_tailroom(skb) < ie_len)
+		return -ENOBUFS;
 
-	*pos++ = WLAN_EID_EXTENSION;
-	*pos++ = ie_len - 2;
-	*pos++ = WLAN_EID_EXT_EHT_CAPABILITY;
-
-	out = (void *)pos;
-	*out = fixed;
-	pos += sizeof(*out);
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	skb_put_u8(skb, ie_len - 2);
+	skb_put_u8(skb, WLAN_EID_EXT_EHT_CAPABILITY);
+	skb_put_data(skb, &fixed, sizeof(fixed));
 
 	if (mcs_nss_len == 4 && orig_mcs_nss_len != 4) {
 		/*
@@ -4284,21 +4272,18 @@ u8 *ieee80211_ie_build_eht_cap(const struct ieee80211_conn_settings *conn,
 		 * the groups 0-7, 8-9, 10-11, 12-13 rather than just 0-9,
 		 * 10-11, 12-13. Thus, use 0-9 for 0-7 and 8-9.
 		 */
-		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs9_max_nss;
-		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs9_max_nss;
-		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs11_max_nss;
-		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs13_max_nss;
+		skb_put_u8(skb, eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs9_max_nss);
+		skb_put_u8(skb, eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs9_max_nss);
+		skb_put_u8(skb, eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs11_max_nss);
+		skb_put_u8(skb, eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs13_max_nss);
 	} else {
-		memcpy(pos, &eht_cap->eht_mcs_nss_supp, mcs_nss_len);
-		pos += mcs_nss_len;
+		skb_put_data(skb, &eht_cap->eht_mcs_nss_supp, mcs_nss_len);
 	}
 
-	if (ppet_len) {
-		memcpy(pos, &eht_cap->eht_ppe_thres, ppet_len);
-		pos += ppet_len;
-	}
+	if (ppet_len)
+		skb_put_data(skb, &eht_cap->eht_ppe_thres, ppet_len);
 
-	return pos;
+	return 0;
 }
 
 const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
-- 
2.43.0


