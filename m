Return-Path: <linux-wireless+bounces-2712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557A84132C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4060FB22006
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA94CB3D;
	Mon, 29 Jan 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QxvtZpAT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360A4C615
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556050; cv=none; b=YR+/7uvsyPKhJMDx56r861ecNY+TGrKjilpbq3iQAJ8wWgJJXy4g84Vi4XSkX0hkA2s+M7SDJiubtRQ2yM6GyM1d080nwfLkmLvpk0mkt41WjRkSDtkOayODoWv6eMxKC8KmXy4EPCY3fTs0kfIKDkDKysEjmWJZ7WkTDDibzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556050; c=relaxed/simple;
	bh=/G8/0qzSYQUF3L7SJ1hhKxEQR6tJPbXcMVVJc7wfGN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwftsXJWHuGLJ6j4/BxU3DzuteucTTQS6HpXKDUB5MtjSDCOv8SgHHRPdkC3+zsDDGTy0P7XSsPArbsWh8VWgY/sxzDQEm4MAJQ7FBh7Z7VahoqSu18td0QeQeic/0BTa7Kvw4UgygSNMTzaiOqZllQUVkGbkcSlZEYozARV6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QxvtZpAT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tsl5jyT9XgrawMaFK99lvsU8HwQGEwqcN5jLDJr8a7s=;
	t=1706556048; x=1707765648; b=QxvtZpATK77moI0rEx5IxTROv/SE/+fUMUi7d38w7itB37K
	JW8bPSeScOn4JbCakAGj/KDmwtvuOAvuqtqVK/S0u7AXgZrXdY4/OoFSLun/hI2FB+wJ7XJZN/F+i
	jFfsFQoEtUH63BHjoBOT+jPGciQoWNoav2JnDc0HVSiZNI0qrF5gG4zFYXoE70B/pepVQVVZgfxEo
	WFRiCKDvFTnpg26l56GBY6cFvVe5PoSGVCE+6Gt3uCixz62JH1tgQwfLw4JtFrtcjrXD+RZAvj31E
	KFFmHo/3N16V0Cb8aJAnfmPSLENTOa/+wuvSdpvB3G4TKaIpIjbPehryaERINLWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBV-000000050Z6-0b6M;
	Mon, 29 Jan 2024 20:20:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/10] wifi: mac80211: adjust EHT capa when lowering bandwidth
Date: Mon, 29 Jan 2024 20:19:28 +0100
Message-ID: <20240129202041.b5f6df108c77.I0d8ea04079c61cb3744cc88625eeaf0d4776dc2b@changeid>
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

If intending to associate with a lower bandwidth, remove capabilities
related to 320 MHz from the EHT capabilities element. Also change the
EHT MCS-NSS set accordingly: if just reducing 320->160 or similar the
format doesn't change, just cut off the last bytes. If changing from
higher bandwidth to 20 MHz only EHT STA, adjust the format.

Note that this also requires adjusting the caller in mlme.c since the
data written can now be shorter than it determined. We need to clean
all that up. Since the other callers pass NULL for the conn limit, we
don't need to change things there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h  |   3 +
 net/mac80211/ieee80211_i.h |   3 +-
 net/mac80211/mesh.c        |   3 +-
 net/mac80211/mlme.c        |  15 +++--
 net/mac80211/tdls.c        |   5 +-
 net/mac80211/util.c        | 128 +++++++++++++++++++++++++++----------
 6 files changed, 113 insertions(+), 44 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index e9078143b822..e4322238f273 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3060,6 +3060,9 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF		0x40
 #define IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK	0x07
 
+#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_80MHZ			0x08
+#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ		0x30
+#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ		0x40
 #define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK			0x78
 #define IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP		0x80
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 44400ce9a0b1..43c55ea6349c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2652,7 +2652,8 @@ void ieee80211_init_frag_cache(struct ieee80211_fragment_cache *cache);
 void ieee80211_destroy_frag_cache(struct ieee80211_fragment_cache *cache);
 
 u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata);
-u8 *ieee80211_ie_build_eht_cap(u8 *pos,
+u8 *ieee80211_ie_build_eht_cap(const struct ieee80211_conn_settings *conn,
+			       u8 *pos,
 			       const struct ieee80211_sta_he_cap *he_cap,
 			       const struct ieee80211_sta_eht_cap *eht_cap,
 			       u8 *end,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 9fd209e4ca19..000fa9484b4e 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -668,7 +668,8 @@ int mesh_add_eht_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return -ENOMEM;
 
 	pos = skb_put(skb, ie_len);
-	ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + ie_len, false);
+	ieee80211_ie_build_eht_cap(NULL, pos, he_cap, eht_cap, pos + ie_len,
+				   false);
 
 	return 0;
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f110566a496b..a97483071e90 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1072,9 +1072,10 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 
 static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb,
-				 struct ieee80211_supported_band *sband)
+				 struct ieee80211_supported_band *sband,
+				 const struct ieee80211_conn_settings *conn)
 {
-	u8 *pos;
+	u8 *pos, *pre_eht_pos;
 	const struct ieee80211_sta_he_cap *he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	u8 eht_cap_size;
@@ -1097,8 +1098,11 @@ static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 		ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
 				       eht_cap->eht_cap_elem.phy_cap_info);
 	pos = skb_put(skb, eht_cap_size);
-	ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + eht_cap_size,
-				   false);
+	pre_eht_pos = pos;
+	pos = ieee80211_ie_build_eht_cap(conn, pos, he_cap, eht_cap,
+					 pos + eht_cap_size, false);
+	/* trim excess if any */
+	skb_trim(skb, skb->len - (pre_eht_pos + eht_cap_size - pos));
 }
 
 static void ieee80211_assoc_add_rates(struct sk_buff *skb,
@@ -1453,7 +1457,8 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 	present_elems = NULL;
 
 	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_EHT)
-		ieee80211_add_eht_ie(sdata, skb, sband);
+		ieee80211_add_eht_ie(sdata, skb, sband,
+				     &assoc_data->link[link_id].conn);
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		ieee80211_add_aid_request_ie(sdata, skb);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 0f4aa42e070f..57673f27daf4 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -6,7 +6,7 @@
  * Copyright 2014, Intel Corporation
  * Copyright 2014  Intel Mobile Communications GmbH
  * Copyright 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2019, 2021-2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -604,7 +604,8 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 			ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
 					       eht_cap->eht_cap_elem.phy_cap_info);
 		pos = skb_put(skb, cap_size);
-		ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + cap_size, false);
+		ieee80211_ie_build_eht_cap(NULL, pos, he_cap, eht_cap,
+					   pos + cap_size, false);
 	}
 
 	/* add any remaining IEs */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e9a7978d47d4..5224c22b1afc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2250,7 +2250,8 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE |
 					 IEEE80211_CHAN_NO_EHT)) {
-		pos = ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, end,
+		pos = ieee80211_ie_build_eht_cap(NULL, pos, he_cap, eht_cap,
+						 end,
 						 sdata->vif.type == NL80211_IFTYPE_AP);
 		if (!pos)
 			goto out_err;
@@ -3294,38 +3295,42 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata)
 				     he_cap->he_cap_elem.phy_cap_info);
 }
 
-u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
+static void
+ieee80211_get_adjusted_he_cap(const struct ieee80211_conn_settings *conn,
 			      const struct ieee80211_sta_he_cap *he_cap,
-			      u8 *pos, u8 *end)
+			      struct ieee80211_he_cap_elem *elem)
 {
-	struct ieee80211_he_cap_elem elem;
-	u8 n;
-	u8 ie_len;
-	u8 *orig_pos = pos;
-
-	if (!conn)
-		conn = &ieee80211_conn_settings_unlimited;
-
-	/* Make sure we have place for the IE */
-	/*
-	 * TODO: the 1 added is because this temporarily is under the EXTENSION
-	 * IE. Get rid of it when it moves.
-	 */
-	if (!he_cap)
-		return orig_pos;
-
-	/* modify on stack first to calculate 'n' and 'ie_len' correctly */
-	elem = he_cap->he_cap_elem;
+	*elem = he_cap->he_cap_elem;
 
 	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_40)
-		elem.phy_cap_info[0] &=
+		elem->phy_cap_info[0] &=
 			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G);
 
 	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_160)
-		elem.phy_cap_info[0] &=
+		elem->phy_cap_info[0] &=
 			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
 			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G);
+}
+
+u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
+			      const struct ieee80211_sta_he_cap *he_cap,
+			      u8 *pos, u8 *end)
+{
+	struct ieee80211_he_cap_elem elem;
+	u8 n;
+	u8 ie_len;
+	u8 *orig_pos = pos;
+
+	if (!conn)
+		conn = &ieee80211_conn_settings_unlimited;
+
+	/* Make sure we have place for the IE */
+	if (!he_cap)
+		return orig_pos;
+
+	/* modify on stack first to calculate 'n' and 'ie_len' correctly */
+	ieee80211_get_adjusted_he_cap(conn, he_cap, &elem);
 
 	n = ieee80211_he_mcs_nss_size(&elem);
 	ie_len = 2 + 1 +
@@ -5096,25 +5101,65 @@ u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata)
 	return 0;
 }
 
-u8 *ieee80211_ie_build_eht_cap(u8 *pos,
+u8 *ieee80211_ie_build_eht_cap(const struct ieee80211_conn_settings *conn,
+			       u8 *pos,
 			       const struct ieee80211_sta_he_cap *he_cap,
 			       const struct ieee80211_sta_eht_cap *eht_cap,
-			       u8 *end,
-			       bool for_ap)
+			       u8 *end, bool for_ap)
 {
+	struct ieee80211_eht_cap_elem_fixed fixed, *out;
+	struct ieee80211_he_cap_elem he;
 	u8 mcs_nss_len, ppet_len;
+	u8 orig_mcs_nss_len;
 	u8 ie_len;
 	u8 *orig_pos = pos;
 
+	if (!conn)
+		conn = &ieee80211_conn_settings_unlimited;
+
 	/* Make sure we have place for the IE */
 	if (!he_cap || !eht_cap)
 		return orig_pos;
 
-	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
-						 &eht_cap->eht_cap_elem,
-						 for_ap);
+	orig_mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+						      &eht_cap->eht_cap_elem,
+						      for_ap);
+
+	ieee80211_get_adjusted_he_cap(conn, he_cap, &he);
+
+	fixed = eht_cap->eht_cap_elem;
+
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_80)
+		fixed.phy_cap_info[6] &=
+			~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_80MHZ;
+
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_160) {
+		fixed.phy_cap_info[1] &=
+			~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK;
+		fixed.phy_cap_info[2] &=
+			~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK;
+		fixed.phy_cap_info[6] &=
+			~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ;
+	}
+
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320) {
+		fixed.phy_cap_info[0] &=
+			~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		fixed.phy_cap_info[1] &=
+			~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
+		fixed.phy_cap_info[2] &=
+			~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
+		fixed.phy_cap_info[6] &=
+			~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
+	}
+
+	if (conn->bw_limit == IEEE80211_CONN_BW_LIMIT_20)
+		fixed.phy_cap_info[0] &=
+			~IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ;
+
+	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he, &fixed, for_ap);
 	ppet_len = ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
-					  eht_cap->eht_cap_elem.phy_cap_info);
+					  fixed.phy_cap_info);
 
 	ie_len = 2 + 1 + sizeof(eht_cap->eht_cap_elem) + mcs_nss_len + ppet_len;
 	if ((end - pos) < ie_len)
@@ -5124,12 +5169,25 @@ u8 *ieee80211_ie_build_eht_cap(u8 *pos,
 	*pos++ = ie_len - 2;
 	*pos++ = WLAN_EID_EXT_EHT_CAPABILITY;
 
-	/* Fixed data */
-	memcpy(pos, &eht_cap->eht_cap_elem, sizeof(eht_cap->eht_cap_elem));
-	pos += sizeof(eht_cap->eht_cap_elem);
+	out = (void *)pos;
+	*out = fixed;
+	pos += sizeof(*out);
 
-	memcpy(pos, &eht_cap->eht_mcs_nss_supp, mcs_nss_len);
-	pos += mcs_nss_len;
+	if (mcs_nss_len == 4 && orig_mcs_nss_len != 4) {
+		/*
+		 * If the (non-AP) STA became 20 MHz only, then convert from
+		 * <=80 to 20-MHz-only format, where MCSes are indicated in
+		 * the groups 0-7, 8-9, 10-11, 12-13 rather than just 0-9,
+		 * 10-11, 12-13. Thus, use 0-9 for 0-7 and 8-9.
+		 */
+		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs9_max_nss;
+		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs9_max_nss;
+		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs11_max_nss;
+		*pos++ = eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_mcs13_max_nss;
+	} else {
+		memcpy(pos, &eht_cap->eht_mcs_nss_supp, mcs_nss_len);
+		pos += mcs_nss_len;
+	}
 
 	if (ppet_len) {
 		memcpy(pos, &eht_cap->eht_ppe_thres, ppet_len);
-- 
2.43.0


