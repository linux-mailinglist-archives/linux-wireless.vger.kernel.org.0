Return-Path: <linux-wireless+bounces-2718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB69841336
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5872EB23180
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6276055;
	Mon, 29 Jan 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MqdCIVlY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DC76029
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556056; cv=none; b=suzMwRxZhcOJzAr1Ue2pHGxJdTpGv0i3fb1/6mW8nUoSzfKh03i2GPCww2W3JTYT71/vjzkeupTH0zlllvb92xHBtuFoI89FXkN+vSEmsAqxmAgjHZTonxJiDzoh9iDx2GPYHvKVjaR+27mrv6aW3QHlhx1IOPuOUXsNLsrA0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556056; c=relaxed/simple;
	bh=3iOyKU0U3F3akpnYkkQ6zHIL00ZzGb6ye4EY1RwQzvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slnYjDFsz/wD+GcJbEMGoADWPse9wQK3wCvR/PKblqkC4qlZ4WFyg8oMmKMzqRkEJ/hfnL3mH58o3Lvm15yZ33ohG9ga9AYxvt1aDsJVgw41jkaw/2F+mpDpCZQCeeFeivw8iipFkYQAf1sL/goo2LMsZfWCXxaq5N5+F8+A8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MqdCIVlY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wZ/FslQPVzDzMH/dWQ6+SS1CLSe2pH+v4Cw/Oj0V5eQ=;
	t=1706556054; x=1707765654; b=MqdCIVlYsWIHTWj29gKrTIgo9IMLzsfW29xP0Mdon1nH++0
	ZsFXE6J3sL10X4g9d6XG7WjFlUa22hUfGxUt+eec6heiagi3CtMJ+eyED9ydgchQxWirpGyNvaV0E
	o9DWx3RchunfHWoZjzg8XBNZA4rkMgDLI4vGxYlb0OW/4u9abcAJSkgO6BM6KvuUZwVxHXAVugu1u
	o9TyQeFCoumM+ia2sxM18pgBipfRDgoA8H7o6Nv4SiKJ47TQthfP0QPraL6HZeb2cXOfrRav35owS
	ttQiMFuMCan5O8rKXueEG4YXBTat3blwthyDAi57YO70Mggez5eYaDDuRhJpaxGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBb-000000050Z6-2uoU;
	Mon, 29 Jan 2024 20:20:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/10] wifi: mac80211: convert ieee80211_ie_build_he_cap() to SKB use
Date: Mon, 29 Jan 2024 20:19:35 +0100
Message-ID: <20240129202041.e6ef888980d9.Ied9e014314b5d27611e693e3d4cb63bdc8d7de17@changeid>
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

Convert ieee80211_ie_build_he_cap() to the SKB-put function
style, renaming it to ieee80211_put_he_cap().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  7 ++---
 net/mac80211/mesh.c        | 15 ++---------
 net/mac80211/mlme.c        | 37 +++-----------------------
 net/mac80211/tdls.c        | 17 +++---------
 net/mac80211/util.c        | 54 +++++++++++++++++---------------------
 5 files changed, 37 insertions(+), 93 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fde8c0b67125..de0fdbd366c5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2502,9 +2502,6 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
 u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata);
-u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
-			      const struct ieee80211_sta_he_cap *he_cap,
-			      u8 *pos, u8 *end);
 u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
 u8 *ieee80211_ie_build_eht_oper(u8 *pos, struct cfg80211_chan_def *chandef,
 				const struct ieee80211_sta_eht_cap *eht_cap);
@@ -2523,6 +2520,10 @@ int ieee80211_put_srates_elem(struct sk_buff *skb,
 			      const struct ieee80211_supported_band *sband,
 			      u32 basic_rates, u32 rate_flags, u32 masked_rates,
 			      u8 element_id);
+int ieee80211_put_he_cap(struct sk_buff *skb,
+			 struct ieee80211_sub_if_data *sdata,
+			 const struct ieee80211_supported_band *sband,
+			 const struct ieee80211_conn_settings *conn);
 int ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
 			      struct ieee80211_sub_if_data *sdata,
 			      enum ieee80211_smps_mode smps_mode);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 7e860486c6bc..cb217657c42e 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -567,29 +567,18 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 		       struct sk_buff *skb, u8 ie_len)
 {
-	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_supported_band *sband;
-	u8 *pos;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
 		return -EINVAL;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
-
-	if (!he_cap ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	if (sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
 	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
-	if (skb_tailroom(skb) < ie_len)
-		return -ENOMEM;
-
-	pos = skb_put(skb, ie_len);
-	ieee80211_ie_build_he_cap(NULL, he_cap, pos, pos + ie_len);
-
-	return 0;
+	return ieee80211_put_he_cap(skb, sdata, sband, NULL);
 }
 
 int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac949e75affc..fcef7ef68389 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1038,38 +1038,6 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	return mu_mimo_owner;
 }
 
-/* This function determines HE capability flags for the association
- * and builds the IE.
- */
-static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
-				struct sk_buff *skb,
-				struct ieee80211_supported_band *sband,
-				enum ieee80211_smps_mode smps_mode,
-				const struct ieee80211_conn_settings *conn)
-{
-	u8 *pos, *pre_he_pos;
-	const struct ieee80211_sta_he_cap *he_cap;
-	u8 he_cap_size;
-
-	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
-	if (WARN_ON(!he_cap))
-		return;
-
-	/* get a max size estimate */
-	he_cap_size =
-		2 + 1 + sizeof(he_cap->he_cap_elem) +
-		ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem) +
-		ieee80211_he_ppe_size(he_cap->ppe_thres[0],
-				      he_cap->he_cap_elem.phy_cap_info);
-	pos = skb_put(skb, he_cap_size);
-	pre_he_pos = pos;
-	pos = ieee80211_ie_build_he_cap(conn, he_cap, pos, pos + he_cap_size);
-	/* trim excess if any */
-	skb_trim(skb, skb->len - (pre_he_pos + he_cap_size - pos));
-
-	ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
-}
-
 static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb,
 				 struct ieee80211_supported_band *sband,
@@ -1403,9 +1371,10 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 					       offset);
 
 	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_HE) {
-		ieee80211_add_he_ie(sdata, skb, sband, smps_mode,
-				    &assoc_data->link[link_id].conn);
+		ieee80211_put_he_cap(skb, sdata, sband,
+				     &assoc_data->link[link_id].conn);
 		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_HE_CAPABILITY);
+		ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
 	}
 
 	/*
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index edbd3fd8a737..3f9c2b2771c6 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -548,19 +548,10 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	}
 
 	/* build the HE-cap from sband */
-	if (he_cap &&
-	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
-	     action_code == WLAN_TDLS_SETUP_RESPONSE ||
-	     action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES)) {
-		u8 cap_size;
-
-		cap_size =
-			2 + 1 + sizeof(he_cap->he_cap_elem) +
-			ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem) +
-			ieee80211_he_ppe_size(he_cap->ppe_thres[0],
-					      he_cap->he_cap_elem.phy_cap_info);
-		pos = skb_put(skb, cap_size);
-		pos = ieee80211_ie_build_he_cap(NULL, he_cap, pos, pos + cap_size);
+	if (action_code == WLAN_TDLS_SETUP_REQUEST ||
+	    action_code == WLAN_TDLS_SETUP_RESPONSE ||
+	    action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
+		ieee80211_put_he_cap(skb, sdata, sband, NULL);
 
 		/* Build HE 6Ghz capa IE from sband */
 		if (sband->band == NL80211_BAND_6GHZ)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c675ac59d2bb..4dcb62e9d4c6 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1352,19 +1352,14 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 		*offset = noffset;
 	}
 
-	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
-	if (he_cap &&
-	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
+	if (cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE)) {
-		u8 *pos = skb_tail_pointer(skb);
-		u8 *end = pos + skb_tailroom(skb);
-
-		pos = ieee80211_ie_build_he_cap(NULL, he_cap, pos, end);
-		if (!pos)
-			return -ENOBUFS;
-		skb_put(skb, pos - skb_tail_pointer(skb));
+		err = ieee80211_put_he_cap(skb, sdata, sband, NULL);
+		if (err)
+			return err;
 	}
 
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
 
 	if (eht_cap &&
@@ -2408,7 +2403,7 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos;
 }
 
-/* this may return more than ieee80211_ie_build_he_cap() will need */
+/* this may return more than ieee80211_put_he_6ghz_cap() will need */
 u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap;
@@ -2479,21 +2474,23 @@ ieee80211_get_adjusted_he_cap(const struct ieee80211_conn_settings *conn,
 	}
 }
 
-u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
-			      const struct ieee80211_sta_he_cap *he_cap,
-			      u8 *pos, u8 *end)
+int ieee80211_put_he_cap(struct sk_buff *skb,
+			 struct ieee80211_sub_if_data *sdata,
+			 const struct ieee80211_supported_band *sband,
+			 const struct ieee80211_conn_settings *conn)
 {
+	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_he_cap_elem elem;
+	u8 *len;
 	u8 n;
 	u8 ie_len;
-	u8 *orig_pos = pos;
 
 	if (!conn)
 		conn = &ieee80211_conn_settings_unlimited;
 
-	/* Make sure we have place for the IE */
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (!he_cap)
-		return orig_pos;
+		return 0;
 
 	/* modify on stack first to calculate 'n' and 'ie_len' correctly */
 	ieee80211_get_adjusted_he_cap(conn, he_cap, &elem);
@@ -2504,19 +2501,17 @@ u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 		 ieee80211_he_ppe_size(he_cap->ppe_thres[0],
 				       he_cap->he_cap_elem.phy_cap_info);
 
-	if ((end - pos) < ie_len)
-		return orig_pos;
+	if (skb_tailroom(skb) < ie_len)
+		return -ENOBUFS;
 
-	*pos++ = WLAN_EID_EXTENSION;
-	pos++; /* We'll set the size later below */
-	*pos++ = WLAN_EID_EXT_HE_CAPABILITY;
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	len = skb_put(skb, 1); /* We'll set the size later below */
+	skb_put_u8(skb, WLAN_EID_EXT_HE_CAPABILITY);
 
 	/* Fixed data */
-	memcpy(pos, &elem, sizeof(elem));
-	pos += sizeof(elem);
+	skb_put_data(skb, &elem, sizeof(elem));
 
-	memcpy(pos, &he_cap->he_mcs_nss_supp, n);
-	pos += n;
+	skb_put_data(skb, &he_cap->he_mcs_nss_supp, n);
 
 	/* Check if PPE Threshold should be present */
 	if ((he_cap->he_cap_elem.phy_cap_info[6] &
@@ -2540,12 +2535,11 @@ u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 	n = DIV_ROUND_UP(n, 8);
 
 	/* Copy PPE Thresholds */
-	memcpy(pos, &he_cap->ppe_thres, n);
-	pos += n;
+	skb_put_data(skb, &he_cap->ppe_thres, n);
 
 end:
-	orig_pos[1] = (pos - orig_pos) - 2;
-	return pos;
+	*len = skb_tail_pointer(skb) - len - 1;
+	return 0;
 }
 
 int ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
-- 
2.43.0


