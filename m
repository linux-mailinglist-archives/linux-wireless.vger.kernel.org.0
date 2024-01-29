Return-Path: <linux-wireless+bounces-2715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D5A84132F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B79F1C21B90
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A14C61F;
	Mon, 29 Jan 2024 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FpS9tc9m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63B605A1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556053; cv=none; b=oijED0GACMfu8e/QRJNBRT/ruI3zh6a3TwpRGpHL/YdqofDOh4nMDE7tPFyV0PPjI5aRmco5Y8WX0aucRnYdD5mHMy/EgZWqCbwCfbKvuQs4lmjy0ja5IjrSXdsJqeDFhD17CvU26iFNNtxhZrXAZZo4/vBRPAV/DU6UzXjmumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556053; c=relaxed/simple;
	bh=xuQEgMlHi1TRFjOQreg53aEDjTAjDrkIQOmlUukOQAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4TEaQuMCka0vS70kcTmfIr0UZxw4urJNgjSi9Ko/1KLqsHU54OgZbKdpl7+ilggGVaeROwbMaPgv+2bLh0gq0/6xtkIP1tFb1ujUye6ygQTWpAENdL9dYNliE8+o5IEbULFIR8Es9h+MnNNp0sHwiw1oj8O43+ngnk0/Vz0K2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FpS9tc9m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QfeyQKsA3nPKSx6LLM++7qDF/H2WD3QRy98+PUEkjgs=;
	t=1706556051; x=1707765651; b=FpS9tc9mEGhjxDm5IdKSnn6EHRg6dXhb38TRobksrUXXKCX
	zC5djazXypk0JL5Wlvnxklxf233exXmnWqyOqxSt0lIq2F/iCzhvWQta+NoDHyu9DRxd87/69MA2/
	4YGWrjhlL5jJne6mhq6l0TXTqajW6a2ER7Tym84cZM9ngx+IcSFGB1tEGnwUS2VMbMsXjVWfENv4P
	EUVjk07n9th0Z275BhrMNfIUtt4T4vetAzOq+M4XVzyh1YGZ3DXgY/TdI5mmPFKEozs6VSdOxfKxJ
	0vwPcyER2Ul8T/RRw80/6TY/r2qhKNL/BRAy8Am/af2e3M5Y2IVAbwCKThukUHJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBY-000000050Z6-27ed;
	Mon, 29 Jan 2024 20:20:48 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/10] wifi: mac80211: simplify adding supported rates
Date: Mon, 29 Jan 2024 20:19:32 +0100
Message-ID: <20240129202041.f604a03bd728.I8c798ea45b8479ac9982e77d0378af11a09ccdaf@changeid>
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

Make this a new-style "put" function, and change the
parameters to pass more information directly, this
makes it usable also for the MLME code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  10 ++--
 net/mac80211/mesh.c        |  20 ++++---
 net/mac80211/mesh_plink.c  |  16 ++++--
 net/mac80211/mlme.c        |  53 ++++--------------
 net/mac80211/tdls.c        |   4 +-
 net/mac80211/util.c        | 107 +++++++++++++------------------------
 6 files changed, 78 insertions(+), 132 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f7b2381878a9..b69f081e1c1f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2511,12 +2511,6 @@ u8 *ieee80211_ie_build_eht_oper(u8 *pos, struct cfg80211_chan_def *chandef,
 int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
-int ieee80211_add_srates_ie(struct ieee80211_sub_if_data *sdata,
-			    struct sk_buff *skb, bool need_basic,
-			    enum nl80211_band band);
-int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
-				struct sk_buff *skb, bool need_basic,
-				enum nl80211_band band);
 u8 *ieee80211_add_wmm_info_ie(u8 *buf, u8 qosinfo);
 void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 				struct ieee80211_sta_s1g_cap *caps,
@@ -2526,6 +2520,10 @@ void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap);
 
 /* element building in SKBs */
+int ieee80211_put_srates_elem(struct sk_buff *skb,
+			      const struct ieee80211_supported_band *sband,
+			      u32 basic_rates, u32 rate_flags, u32 masked_rates,
+			      u8 element_id);
 void ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
 			       struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps_mode);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 10c7d7714ffe..7e860486c6bc 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -968,19 +968,19 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	int head_len, tail_len;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
-	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct mesh_csa_settings *csa;
-	enum nl80211_band band;
+	const struct ieee80211_supported_band *sband;
 	u8 ie_len_he_cap, ie_len_eht_cap;
 	u8 *pos;
 	struct ieee80211_sub_if_data *sdata;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.beacon);
+	u32 rate_flags;
 
 	sdata = container_of(ifmsh, struct ieee80211_sub_if_data, u.mesh);
-	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-	band = chanctx_conf->def.chan->band;
-	rcu_read_unlock();
+
+	sband = ieee80211_get_sband(sdata);
+	rate_flags =
+		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
 
 	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
 	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata);
@@ -1107,7 +1107,9 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	}
 	rcu_read_unlock();
 
-	if (ieee80211_add_srates_ie(sdata, skb, true, band) ||
+	if (ieee80211_put_srates_elem(skb, sband,
+				      sdata->vif.bss_conf.basic_rates,
+				      rate_flags, 0, WLAN_EID_SUPP_RATES) ||
 	    mesh_add_ds_params_ie(sdata, skb))
 		goto out_free;
 
@@ -1118,7 +1120,9 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	skb_trim(skb, 0);
 	bcn->tail = bcn->head + bcn->head_len;
 
-	if (ieee80211_add_ext_srates_ie(sdata, skb, true, band) ||
+	if (ieee80211_put_srates_elem(skb, sband,
+				      sdata->vif.bss_conf.basic_rates,
+				      rate_flags, 0, WLAN_EID_EXT_SUPP_RATES) ||
 	    mesh_add_rsn_ie(sdata, skb) ||
 	    mesh_add_ht_cap_ie(sdata, skb) ||
 	    mesh_add_ht_oper_ie(sdata, skb) ||
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 7ba0f01805a4..8f2b492a9fe9 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -264,14 +264,13 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 
 	if (action != WLAN_SP_MESH_PEERING_CLOSE) {
 		struct ieee80211_supported_band *sband;
-		enum nl80211_band band;
+		u32 rate_flags, basic_rates;
 
 		sband = ieee80211_get_sband(sdata);
 		if (!sband) {
 			err = -EINVAL;
 			goto free;
 		}
-		band = sband->band;
 
 		/* capability info */
 		pos = skb_put_zero(skb, 2);
@@ -280,8 +279,17 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			pos = skb_put(skb, 2);
 			put_unaligned_le16(sta->sta.aid, pos);
 		}
-		if (ieee80211_add_srates_ie(sdata, skb, true, band) ||
-		    ieee80211_add_ext_srates_ie(sdata, skb, true, band) ||
+
+		rate_flags =
+			ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
+		basic_rates = sdata->vif.bss_conf.basic_rates;
+
+		if (ieee80211_put_srates_elem(skb, sband, basic_rates,
+					      rate_flags, 0,
+					      WLAN_EID_SUPP_RATES) ||
+		    ieee80211_put_srates_elem(skb, sband, basic_rates,
+					      rate_flags, 0,
+					      WLAN_EID_EXT_SUPP_RATES) ||
 		    mesh_add_rsn_ie(sdata, skb) ||
 		    mesh_add_meshid_ie(sdata, skb) ||
 		    mesh_add_meshconf_ie(sdata, skb))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ff386f8a1bf3..ac949e75affc 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1110,10 +1110,7 @@ static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 				      struct ieee80211_supported_band *sband,
 				      struct ieee80211_mgd_assoc_data *assoc_data)
 {
-	unsigned int rates_len, supp_rates_len;
-	u32 rates = 0;
-	int i, count;
-	u8 *pos;
+	u32 rates;
 
 	if (assoc_data->supp_rates_len) {
 		/*
@@ -1122,53 +1119,23 @@ static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 		 * in the association request (e.g. D-Link DAP 1353 in
 		 * b-only mode)...
 		 */
-		rates_len = ieee80211_parse_bitrates(width, sband,
-						     assoc_data->supp_rates,
-						     assoc_data->supp_rates_len,
-						     &rates);
+		ieee80211_parse_bitrates(width, sband,
+					 assoc_data->supp_rates,
+					 assoc_data->supp_rates_len,
+					 &rates);
 	} else {
 		/*
 		 * In case AP not provide any supported rates information
 		 * before association, we send information element(s) with
 		 * all rates that we support.
 		 */
-		rates_len = sband->n_bitrates;
-		for (i = 0; i < sband->n_bitrates; i++)
-			rates |= BIT(i);
+		rates = ~0;
 	}
 
-	supp_rates_len = rates_len;
-	if (supp_rates_len > 8)
-		supp_rates_len = 8;
-
-	pos = skb_put(skb, supp_rates_len + 2);
-	*pos++ = WLAN_EID_SUPP_RATES;
-	*pos++ = supp_rates_len;
-
-	count = 0;
-	for (i = 0; i < sband->n_bitrates; i++) {
-		if (BIT(i) & rates) {
-			int rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
-			*pos++ = (u8)rate;
-			if (++count == 8)
-				break;
-		}
-	}
-
-	if (rates_len > count) {
-		pos = skb_put(skb, rates_len - count + 2);
-		*pos++ = WLAN_EID_EXT_SUPP_RATES;
-		*pos++ = rates_len - count;
-
-		for (i++; i < sband->n_bitrates; i++) {
-			if (BIT(i) & rates) {
-				int rate;
-
-				rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
-				*pos++ = (u8)rate;
-			}
-		}
-	}
+	ieee80211_put_srates_elem(skb, sband, 0, 0, ~rates,
+				  WLAN_EID_SUPP_RATES);
+	ieee80211_put_srates_elem(skb, sband, 0, 0, ~rates,
+				  WLAN_EID_EXT_SUPP_RATES);
 }
 
 static size_t ieee80211_add_before_ht_elems(struct sk_buff *skb,
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index e6808b7660ff..edbd3fd8a737 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -382,8 +382,8 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	if (WARN_ON_ONCE(!sband))
 		return;
 
-	ieee80211_add_srates_ie(sdata, skb, false, sband->band);
-	ieee80211_add_ext_srates_ie(sdata, skb, false, sband->band);
+	ieee80211_put_srates_elem(skb, sband, 0, 0, 0, WLAN_EID_SUPP_RATES);
+	ieee80211_put_srates_elem(skb, sband, 0, 0, 0, WLAN_EID_EXT_SUPP_RATES);
 	ieee80211_tdls_add_supp_channels(sdata, skb);
 
 	/* add any custom IEs that go before Extended Capabilities */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c90f338b229c..3888ad3b052f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4091,93 +4091,62 @@ int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 	return count;
 }
 
-int ieee80211_add_srates_ie(struct ieee80211_sub_if_data *sdata,
-			    struct sk_buff *skb, bool need_basic,
-			    enum nl80211_band band)
+int ieee80211_put_srates_elem(struct sk_buff *skb,
+			      const struct ieee80211_supported_band *sband,
+			      u32 basic_rates, u32 rate_flags, u32 masked_rates,
+			      u8 element_id)
 {
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_supported_band *sband;
-	int rate;
-	u8 i, rates, *pos;
-	u32 basic_rates = sdata->vif.bss_conf.basic_rates;
-	u32 rate_flags;
+	u8 i, rates, skip;
 
-	rate_flags =
-		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
-	sband = local->hw.wiphy->bands[band];
 	rates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
 		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
 			continue;
+		if (masked_rates & BIT(i))
+			continue;
 		rates++;
 	}
-	if (rates > 8)
-		rates = 8;
+
+	if (element_id == WLAN_EID_SUPP_RATES) {
+		rates = min_t(u8, rates, 8);
+		skip = 0;
+	} else {
+		skip = 8;
+		if (rates <= skip)
+			return 0;
+		rates -= skip;
+	}
 
 	if (skb_tailroom(skb) < rates + 2)
-		return -ENOMEM;
+		return -ENOBUFS;
+
+	skb_put_u8(skb, element_id);
+	skb_put_u8(skb, rates);
+
+	for (i = 0; i < sband->n_bitrates && rates; i++) {
+		int rate;
+		u8 basic;
 
-	pos = skb_put(skb, rates + 2);
-	*pos++ = WLAN_EID_SUPP_RATES;
-	*pos++ = rates;
-	for (i = 0; i < rates; i++) {
-		u8 basic = 0;
 		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
 			continue;
+		if (masked_rates & BIT(i))
+			continue;
+
+		if (skip > 0) {
+			skip--;
+			continue;
+		}
+
+		basic = basic_rates & BIT(i) ? 0x80 : 0;
 
-		if (need_basic && basic_rates & BIT(i))
-			basic = 0x80;
 		rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
-		*pos++ = basic | (u8) rate;
+		skb_put_u8(skb, basic | (u8)rate);
+		rates--;
 	}
 
-	return 0;
-}
+	WARN(rates > 0, "rates confused: rates:%d, element:%d\n",
+	     rates, element_id);
 
-int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
-				struct sk_buff *skb, bool need_basic,
-				enum nl80211_band band)
-{
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_supported_band *sband;
-	int rate;
-	u8 i, exrates, *pos;
-	u32 basic_rates = sdata->vif.bss_conf.basic_rates;
-	u32 rate_flags;
-
-	rate_flags =
-		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
-	sband = local->hw.wiphy->bands[band];
-	exrates = 0;
-	for (i = 0; i < sband->n_bitrates; i++) {
-		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
-			continue;
-		exrates++;
-	}
-
-	if (exrates > 8)
-		exrates -= 8;
-	else
-		exrates = 0;
-
-	if (skb_tailroom(skb) < exrates + 2)
-		return -ENOMEM;
-
-	if (exrates) {
-		pos = skb_put(skb, exrates + 2);
-		*pos++ = WLAN_EID_EXT_SUPP_RATES;
-		*pos++ = exrates;
-		for (i = 8; i < sband->n_bitrates; i++) {
-			u8 basic = 0;
-			if ((rate_flags & sband->bitrates[i].flags)
-			    != rate_flags)
-				continue;
-			if (need_basic && basic_rates & BIT(i))
-				basic = 0x80;
-			rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
-			*pos++ = basic | (u8) rate;
-		}
-	}
 	return 0;
 }
 
-- 
2.43.0


