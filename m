Return-Path: <linux-wireless+bounces-20957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E4A757E4
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 22:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927BB16B722
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2D1DD889;
	Sat, 29 Mar 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MWy0N8kv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12941DC994
	for <linux-wireless@vger.kernel.org>; Sat, 29 Mar 2025 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743282866; cv=none; b=ra0DaFJHMhEal9xK8f2tnhAE0HcTxL4AcP7TXNyaobFyVchrTkx/T3zm46a0P2U9UXZ5kD1YIrEKIWqCygeCAXIHHvvNC0Ztq7lurROXM8CBW7u3eIbFk9VhYtyHXMKpzIYg7eGwcdmMQsNY3YSnRxSr3KlmvOuIPr+Cfu0OMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743282866; c=relaxed/simple;
	bh=RUdWvHlN0Ct2qD5OlksIvIy8edcPUHRb8hgh013xeuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dgc7lGVi53H5giJ5kosbEi/OO+uOM79l9UmNstf016osPB1rB5t0bXyAW18JLN966JbwBYcDDOdqElL0a9k9HDuDZthL4xLEiHOO/SNmRBiSapWNhGKZ2MuO4nq2RtJ9RdTrOT92HlOwhoYgT5uR+LXBvGdTu1nZGxxDugRiIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MWy0N8kv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=zg+vbzYGsolPvoaqAGk9i4ijYKoau3H3Sps0TQUUIz0=; t=1743282864; x=1744492464; 
	b=MWy0N8kvdZLCNielH16NvFoJ4GidjSfVZlTDnmaQC+9WOkH1c+DnUJACEqFXjxYDgbKVvd9Tvmy
	ddRFwRl2X+TU71UsxCMW1iDFp0/qb06mRUhdA/CsHK3k2Rq3iO8/vZdbxYK7kp8B88OV1kjP1fM4t
	uc14enGezHJhZqJDY0cjr3GY20tjMhq5/bodf1+Tb+3GC3MuxStDIZhhgMEKSjC5i9jByOIqdaxkN
	XJ1p0eDGqOwE4HMGW8GWMIfu7NIw/f9wQSmr412MUgR1k7BBGdOxkxFNOPVfRoQ4+Bc9oOveGq+v8
	zgl+XGA80y7HInN4c1fQqGgwo20bYguvXKDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tydVV-00000009V8i-1dfN;
	Sat, 29 Mar 2025 22:14:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211/mac80211: remove more 5/10 MHz code
Date: Sat, 29 Mar 2025 22:14:20 +0100
Message-ID: <20250329221419.c31da7ae8c84.I1a3a4b6008134d66ca75a5bdfc004f4594da8145@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We still have ieee80211_chandef_rate_flags() and all that,
but all the users seem pretty much broken (deflink, etc.)
Remove all the code. It's been two years since last anyone
even vaguely entertained the notion of looking at this and
fixing it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h             | 37 ------------------------------
 net/mac80211/ibss.c                | 19 +--------------
 net/mac80211/ieee80211_i.h         |  2 +-
 net/mac80211/mesh.c                |  7 ++----
 net/mac80211/mesh_plink.c          | 10 +++-----
 net/mac80211/mlme.c                |  4 ++--
 net/mac80211/parse.c               |  3 ---
 net/mac80211/rate.c                | 10 ++------
 net/mac80211/rc80211_minstrel_ht.c | 13 +++--------
 net/mac80211/tdls.c                |  4 ++--
 net/mac80211/tx.c                  | 11 ---------
 net/mac80211/util.c                | 25 ++++----------------
 12 files changed, 21 insertions(+), 124 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 363d7dd2255a..0e9158bf0a05 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1082,43 +1082,6 @@ int cfg80211_chandef_primary(const struct cfg80211_chan_def *chandef,
  **/
 int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *chandef);
 
-/**
- * ieee80211_chanwidth_rate_flags - return rate flags for channel width
- * @width: the channel width of the channel
- *
- * In some channel types, not all rates may be used - for example CCK
- * rates may not be used in 5/10 MHz channels.
- *
- * Returns: rate flags which apply for this channel width
- */
-static inline enum ieee80211_rate_flags
-ieee80211_chanwidth_rate_flags(enum nl80211_chan_width width)
-{
-	switch (width) {
-	case NL80211_CHAN_WIDTH_5:
-		return IEEE80211_RATE_SUPPORTS_5MHZ;
-	case NL80211_CHAN_WIDTH_10:
-		return IEEE80211_RATE_SUPPORTS_10MHZ;
-	default:
-		break;
-	}
-	return 0;
-}
-
-/**
- * ieee80211_chandef_rate_flags - returns rate flags for a channel
- * @chandef: channel definition for the channel
- *
- * See ieee80211_chanwidth_rate_flags().
- *
- * Returns: rate flags which apply for this channel
- */
-static inline enum ieee80211_rate_flags
-ieee80211_chandef_rate_flags(struct cfg80211_chan_def *chandef)
-{
-	return ieee80211_chanwidth_rate_flags(chandef->width);
-}
-
 /**
  * ieee80211_chandef_max_power - maximum transmission power for the chandef
  *
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 05a945df3259..566a002dd538 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -48,7 +48,7 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt;
 	u8 *pos;
 	struct ieee80211_supported_band *sband;
-	u32 rate_flags, rates = 0, rates_added = 0;
+	u32 rates = 0, rates_added = 0;
 	struct beacon_data *presp;
 	int frame_len;
 
@@ -90,14 +90,11 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 	pos += ifibss->ssid_len;
 
 	sband = local->hw.wiphy->bands[chandef->chan->band];
-	rate_flags = ieee80211_chandef_rate_flags(chandef);
 	rates_n = 0;
 	if (have_higher_than_11mbit)
 		*have_higher_than_11mbit = false;
 
 	for (i = 0; i < sband->n_bitrates; i++) {
-		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
-			continue;
 		if (sband->bitrates[i].bitrate > 110 &&
 		    have_higher_than_11mbit)
 			*have_higher_than_11mbit = true;
@@ -395,7 +392,6 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	const struct cfg80211_bss_ies *ies;
 	enum nl80211_channel_type chan_type;
 	u64 tsf;
-	u32 rate_flags;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -429,7 +425,6 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sband = sdata->local->hw.wiphy->bands[cbss->channel->band];
-	rate_flags = ieee80211_chandef_rate_flags(&sdata->u.ibss.chandef);
 
 	basic_rates = 0;
 
@@ -439,9 +434,6 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 
 		for (j = 0; j < sband->n_bitrates; j++) {
 			int brate;
-			if ((rate_flags & sband->bitrates[j].flags)
-			    != rate_flags)
-				continue;
 
 			brate = DIV_ROUND_UP(sband->bitrates[j].bitrate, 5);
 			if (brate == rate) {
@@ -1717,12 +1709,9 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_ibss_params *params)
 {
 	u64 changed = 0;
-	u32 rate_flags;
-	struct ieee80211_supported_band *sband;
 	enum ieee80211_chanctx_mode chanmode;
 	struct ieee80211_local *local = sdata->local;
 	int radar_detect_width = 0;
-	int i;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1765,12 +1754,6 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	sdata->u.ibss.last_scan_completed = jiffies;
 
 	/* fix basic_rates if channel does not support these rates */
-	rate_flags = ieee80211_chandef_rate_flags(&params->chandef);
-	sband = local->hw.wiphy->bands[params->chandef.chan->band];
-	for (i = 0; i < sband->n_bitrates; i++) {
-		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
-			sdata->u.ibss.basic_rates &= ~BIT(i);
-	}
 	memcpy(sdata->vif.bss_conf.mcast_rate, params->mcast_rate,
 	       sizeof(params->mcast_rate));
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e7dc3f0cfc9a..ec1cfe80fd4e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2608,7 +2608,7 @@ void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 /* element building in SKBs */
 int ieee80211_put_srates_elem(struct sk_buff *skb,
 			      const struct ieee80211_supported_band *sband,
-			      u32 basic_rates, u32 rate_flags, u32 masked_rates,
+			      u32 basic_rates, u32 masked_rates,
 			      u8 element_id);
 int ieee80211_put_he_cap(struct sk_buff *skb,
 			 struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 974081324aa4..0701d5081058 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -956,13 +956,10 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	u8 *pos;
 	struct ieee80211_sub_if_data *sdata;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.beacon);
-	u32 rate_flags;
 
 	sdata = container_of(ifmsh, struct ieee80211_sub_if_data, u.mesh);
 
 	sband = ieee80211_get_sband(sdata);
-	rate_flags =
-		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
 
 	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
 	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata);
@@ -1091,7 +1088,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 
 	if (ieee80211_put_srates_elem(skb, sband,
 				      sdata->vif.bss_conf.basic_rates,
-				      rate_flags, 0, WLAN_EID_SUPP_RATES) ||
+				      0, WLAN_EID_SUPP_RATES) ||
 	    mesh_add_ds_params_ie(sdata, skb))
 		goto out_free;
 
@@ -1104,7 +1101,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 
 	if (ieee80211_put_srates_elem(skb, sband,
 				      sdata->vif.bss_conf.basic_rates,
-				      rate_flags, 0, WLAN_EID_EXT_SUPP_RATES) ||
+				      0, WLAN_EID_EXT_SUPP_RATES) ||
 	    mesh_add_rsn_ie(sdata, skb) ||
 	    mesh_add_ht_cap_ie(sdata, skb) ||
 	    mesh_add_ht_oper_ie(sdata, skb) ||
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 5a0156e11c91..a197428de6e9 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -264,7 +264,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 
 	if (action != WLAN_SP_MESH_PEERING_CLOSE) {
 		struct ieee80211_supported_band *sband;
-		u32 rate_flags, basic_rates;
+		u32 basic_rates;
 
 		sband = ieee80211_get_sband(sdata);
 		if (!sband) {
@@ -280,16 +280,12 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			put_unaligned_le16(sta->sta.aid, pos);
 		}
 
-		rate_flags =
-			ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
 		basic_rates = sdata->vif.bss_conf.basic_rates;
 
 		if (ieee80211_put_srates_elem(skb, sband, basic_rates,
-					      rate_flags, 0,
-					      WLAN_EID_SUPP_RATES) ||
+					      0, WLAN_EID_SUPP_RATES) ||
 		    ieee80211_put_srates_elem(skb, sband, basic_rates,
-					      rate_flags, 0,
-					      WLAN_EID_EXT_SUPP_RATES) ||
+					      0, WLAN_EID_EXT_SUPP_RATES) ||
 		    mesh_add_rsn_ie(sdata, skb) ||
 		    mesh_add_meshid_ie(sdata, skb) ||
 		    mesh_add_meshconf_ie(sdata, skb))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 36a9be9a66c8..0e6eb20de691 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1388,9 +1388,9 @@ static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 		rates = ~0;
 	}
 
-	ieee80211_put_srates_elem(skb, sband, 0, 0, ~rates,
+	ieee80211_put_srates_elem(skb, sband, 0, ~rates,
 				  WLAN_EID_SUPP_RATES);
-	ieee80211_put_srates_elem(skb, sband, 0, 0, ~rates,
+	ieee80211_put_srates_elem(skb, sband, 0, ~rates,
 				  WLAN_EID_EXT_SUPP_RATES);
 }
 
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 6da39c864f45..96584b39215e 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -1101,7 +1101,6 @@ int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates)
 {
-	u32 rate_flags = ieee80211_chanwidth_rate_flags(width);
 	struct ieee80211_rate *br;
 	int brate, rate, i, j, count = 0;
 
@@ -1112,8 +1111,6 @@ int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 
 		for (j = 0; j < sband->n_bitrates; j++) {
 			br = &sband->bitrates[j];
-			if ((rate_flags & br->flags) != rate_flags)
-				continue;
 
 			brate = DIV_ROUND_UP(br->bitrate, 5);
 			if (brate == rate) {
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 0d056db9f81e..1b0667ca359e 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -368,9 +368,8 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 				    struct ieee80211_tx_info *info,
 				    u32 rate_mask)
 {
+	u32 rate_flags = 0;
 	int i;
-	u32 rate_flags =
-		ieee80211_chandef_rate_flags(&hw->conf.chandef);
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		info->control.rates[0].flags |= IEEE80211_TX_RC_S1G_MCS;
@@ -778,14 +777,9 @@ static bool rate_control_cap_mask(struct ieee80211_sub_if_data *sdata,
 				  u8 mcs_mask[IEEE80211_HT_MCS_MASK_LEN],
 				  u16 vht_mask[NL80211_VHT_NSS_MAX])
 {
-	u32 i, flags;
+	u32 i;
 
 	*mask = sdata->rc_rateidx_mask[sband->band];
-	flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
-	for (i = 0; i < sband->n_bitrates; i++) {
-		if ((flags & sband->bitrates[i].flags) != flags)
-			*mask &= ~BIT(i);
-	}
 
 	if (*mask == (1 << sband->n_bitrates) - 1 &&
 	    !sdata->rc_has_mcs_mask[sband->band] &&
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 706cbc99f718..f66910013218 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1873,16 +1873,13 @@ minstrel_ht_free_sta(void *priv, struct ieee80211_sta *sta, void *priv_sta)
 
 static void
 minstrel_ht_fill_rate_array(u8 *dest, struct ieee80211_supported_band *sband,
-			    const s16 *bitrates, int n_rates, u32 rate_flags)
+			    const s16 *bitrates, int n_rates)
 {
 	int i, j;
 
 	for (i = 0; i < sband->n_bitrates; i++) {
 		struct ieee80211_rate *rate = &sband->bitrates[i];
 
-		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
-			continue;
-
 		for (j = 0; j < n_rates; j++) {
 			if (rate->bitrate != bitrates[j])
 				continue;
@@ -1898,7 +1895,6 @@ minstrel_ht_init_cck_rates(struct minstrel_priv *mp)
 {
 	static const s16 bitrates[4] = { 10, 20, 55, 110 };
 	struct ieee80211_supported_band *sband;
-	u32 rate_flags = ieee80211_chandef_rate_flags(&mp->hw->conf.chandef);
 
 	memset(mp->cck_rates, 0xff, sizeof(mp->cck_rates));
 	sband = mp->hw->wiphy->bands[NL80211_BAND_2GHZ];
@@ -1908,8 +1904,7 @@ minstrel_ht_init_cck_rates(struct minstrel_priv *mp)
 	BUILD_BUG_ON(ARRAY_SIZE(mp->cck_rates) != ARRAY_SIZE(bitrates));
 	minstrel_ht_fill_rate_array(mp->cck_rates, sband,
 				    minstrel_cck_bitrates,
-				    ARRAY_SIZE(minstrel_cck_bitrates),
-				    rate_flags);
+				    ARRAY_SIZE(minstrel_cck_bitrates));
 }
 
 static void
@@ -1917,7 +1912,6 @@ minstrel_ht_init_ofdm_rates(struct minstrel_priv *mp, enum nl80211_band band)
 {
 	static const s16 bitrates[8] = { 60, 90, 120, 180, 240, 360, 480, 540 };
 	struct ieee80211_supported_band *sband;
-	u32 rate_flags = ieee80211_chandef_rate_flags(&mp->hw->conf.chandef);
 
 	memset(mp->ofdm_rates[band], 0xff, sizeof(mp->ofdm_rates[band]));
 	sband = mp->hw->wiphy->bands[band];
@@ -1927,8 +1921,7 @@ minstrel_ht_init_ofdm_rates(struct minstrel_priv *mp, enum nl80211_band band)
 	BUILD_BUG_ON(ARRAY_SIZE(mp->ofdm_rates[band]) != ARRAY_SIZE(bitrates));
 	minstrel_ht_fill_rate_array(mp->ofdm_rates[band], sband,
 				    minstrel_ofdm_bitrates,
-				    ARRAY_SIZE(minstrel_ofdm_bitrates),
-				    rate_flags);
+				    ARRAY_SIZE(minstrel_ofdm_bitrates));
 }
 
 static void *
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 2f92e7c7f203..94714f8ffd22 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -382,8 +382,8 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	if (WARN_ON_ONCE(!sband))
 		return;
 
-	ieee80211_put_srates_elem(skb, sband, 0, 0, 0, WLAN_EID_SUPP_RATES);
-	ieee80211_put_srates_elem(skb, sband, 0, 0, 0, WLAN_EID_EXT_SUPP_RATES);
+	ieee80211_put_srates_elem(skb, sband, 0, 0, WLAN_EID_SUPP_RATES);
+	ieee80211_put_srates_elem(skb, sband, 0, 0, WLAN_EID_EXT_SUPP_RATES);
 	ieee80211_tdls_add_supp_channels(sdata, skb);
 
 	/* add any custom IEs that go before Extended Capabilities */
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..e836ebda6df8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -49,19 +49,11 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_chanctx_conf *chanctx_conf;
-	u32 rate_flags = 0;
 
 	/* assume HW handles this */
 	if (tx->rate.flags & (IEEE80211_TX_RC_MCS | IEEE80211_TX_RC_VHT_MCS))
 		return 0;
 
-	rcu_read_lock();
-	chanctx_conf = rcu_dereference(tx->sdata->vif.bss_conf.chanctx_conf);
-	if (chanctx_conf)
-		rate_flags = ieee80211_chandef_rate_flags(&chanctx_conf->def);
-	rcu_read_unlock();
-
 	/* uh huh? */
 	if (WARN_ON_ONCE(tx->rate.idx < 0))
 		return 0;
@@ -138,9 +130,6 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 		if (r->bitrate > txrate->bitrate)
 			break;
 
-		if ((rate_flags & r->flags) != rate_flags)
-			continue;
-
 		if (tx->sdata->vif.bss_conf.basic_rates & BIT(i))
 			rate = r->bitrate;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index fdda14c08e2b..79caa2340210 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1204,7 +1204,6 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 	struct ieee80211_supported_band *sband;
 	int i, err;
 	size_t noffset;
-	u32 rate_flags;
 	bool have_80mhz = false;
 
 	*offset = 0;
@@ -1213,13 +1212,11 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 	if (WARN_ON_ONCE(!sband))
 		return 0;
 
-	rate_flags = ieee80211_chandef_rate_flags(chandef);
-
 	/* For direct scan add S1G IE and consider its override bits */
 	if (band == NL80211_BAND_S1GHZ)
 		return ieee80211_put_s1g_cap(skb, &sband->s1g_cap);
 
-	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags,
+	err = ieee80211_put_srates_elem(skb, sband, 0,
 					~rate_mask, WLAN_EID_SUPP_RATES);
 	if (err)
 		return err;
@@ -1241,7 +1238,7 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 		*offset = noffset;
 	}
 
-	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags,
+	err = ieee80211_put_srates_elem(skb, sband, 0,
 					~rate_mask, WLAN_EID_EXT_SUPP_RATES);
 	if (err)
 		return err;
@@ -1522,16 +1519,13 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_supported_band *sband;
 	size_t num_rates;
-	u32 supp_rates, rate_flags;
+	u32 supp_rates;
 	int i, j;
 
 	sband = sdata->local->hw.wiphy->bands[band];
 	if (WARN_ON(!sband))
 		return 1;
 
-	rate_flags =
-		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
-
 	num_rates = sband->n_bitrates;
 	supp_rates = 0;
 	for (i = 0; i < elems->supp_rates_len +
@@ -1551,12 +1545,7 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 			continue;
 
 		for (j = 0; j < num_rates; j++) {
-			int brate;
-			if ((rate_flags & sband->bitrates[j].flags)
-			    != rate_flags)
-				continue;
-
-			brate = sband->bitrates[j].bitrate;
+			int brate = sband->bitrates[j].bitrate;
 
 			if (brate == own_rate) {
 				supp_rates |= BIT(j);
@@ -3222,15 +3211,13 @@ bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 
 int ieee80211_put_srates_elem(struct sk_buff *skb,
 			      const struct ieee80211_supported_band *sband,
-			      u32 basic_rates, u32 rate_flags, u32 masked_rates,
+			      u32 basic_rates, u32 masked_rates,
 			      u8 element_id)
 {
 	u8 i, rates, skip;
 
 	rates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
-		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
-			continue;
 		if (masked_rates & BIT(i))
 			continue;
 		rates++;
@@ -3256,8 +3243,6 @@ int ieee80211_put_srates_elem(struct sk_buff *skb,
 		int rate;
 		u8 basic;
 
-		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
-			continue;
 		if (masked_rates & BIT(i))
 			continue;
 
-- 
2.49.0


