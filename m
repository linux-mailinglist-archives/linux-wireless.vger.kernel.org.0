Return-Path: <linux-wireless+bounces-2717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C64841335
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8556B288971
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810D76040;
	Mon, 29 Jan 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kopgjHGm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D716F098
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556054; cv=none; b=HZSZZTWdIR3KdkNLYxpdV7EzOLKHa6MCzMTTsBqEl20RsQqDXp0gj1ySKCLNuhREFOVUAyO4OoaklLhersteTaJau+nMoBpuzQjFi55+QICIy8jBOQDQevvbOyU+dfvYNK/+1J5QlkHTGoNsFzL0vwCC6ZA0S+jvEKtzxqSb1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556054; c=relaxed/simple;
	bh=VcZ1IEgOoZ2IoHehjlLR1eIw9BIpgDrALusTmVNBfUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVcSShCKhaHUstifM6H+A3lDlGxqTxfI9SqkagMDeCMpHQnvs7rjHwz+t/evED1OLLGCQYUUcCfs1Sle+vdArxOYJVg4XNl/sYKJkyBS5+PCO94UxS8ctJAMlHPJ90XBsuOuv/txE5jjRLyeS8W0Zf5/SZixXw3rj4tETl2Ji1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kopgjHGm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7Wxgzr25Rw2aQH8NJgO3JZlTOUNed3iVjVsRt/T3PiY=;
	t=1706556052; x=1707765652; b=kopgjHGm8JIYom7rS2I8b6E9tBDYz+bYPR8t3vLZOlfmaHa
	IX6OWM3/iMjLip/tjFxNgQBXRHNArcYrtbVIiN0XT9hvKQlyIZ724bgD4mNmWviZLcSvkvLWux1wi
	xzYXB1KnKoUtC3vyFAKLZrSdBTX7KRP0Tkt95pN6rUSIbBz8y5XvlN5ACSthGI1Rkgei+hgJppawy
	lNxQSpbdLpiCS2bwJjNU4FpWBW6v0xPGeqcEyWERrsr1/JpisatBzUCqpxvHUVcfcwVqVmi8Xrl+9
	0BDDvy/D3zqVwpBy7JqTj7JAasZqbu7qLy42LVcU3q+9JS5+ukPLCEywI/QvrQ8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBZ-000000050Z6-3LuZ;
	Mon, 29 Jan 2024 20:20:50 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/10] wifi: mac80211: start building elements in SKBs
Date: Mon, 29 Jan 2024 20:19:33 +0100
Message-ID: <20240129202041.c3a8e3c2cc99.I9d9920858c30ae5154719783933de0d7bc2a2cb9@changeid>
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

The building of elements is really mess, and really the only
reason we're not doing it in SKBs in the first place is that
the scan code in ieee80211_build_preq_ies() doesn't.

Convert ieee80211_build_preq_ies() to use an SKB internally
so that we can gradually convert other things to ..._put_*()
style interfaces.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |   7 +-
 net/mac80211/scan.c        |  14 +-
 net/mac80211/util.c        | 357 +++++++++++++++++++------------------
 3 files changed, 191 insertions(+), 187 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b69f081e1c1f..fde8c0b67125 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2517,16 +2517,15 @@ void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb);
 void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
-u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap);
 
 /* element building in SKBs */
 int ieee80211_put_srates_elem(struct sk_buff *skb,
 			      const struct ieee80211_supported_band *sband,
 			      u32 basic_rates, u32 rate_flags, u32 masked_rates,
 			      u8 element_id);
-void ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum ieee80211_smps_mode smps_mode);
+int ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
+			      struct ieee80211_sub_if_data *sdata,
+			      enum ieee80211_smps_mode smps_mode);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 1fe66b332d8a..5197c6087c6a 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -394,6 +394,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 					 req->ie, req->ie_len,
 					 bands_used, req->rates, &chandef,
 					 flags);
+	if (ielen < 0)
+		return false;
 	local->hw_scan_req->req.ie_len = ielen;
 	local->hw_scan_req->req.no_cck = req->no_cck;
 	ether_addr_copy(local->hw_scan_req->req.mac_addr, req->mac_addr);
@@ -1316,10 +1318,12 @@ int __ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_prepare_scan_chandef(&chandef);
 
-	ieee80211_build_preq_ies(sdata, ie, num_bands * iebufsz,
-				 &sched_scan_ies, req->ie,
-				 req->ie_len, bands_used, rate_masks, &chandef,
-				 flags);
+	ret = ieee80211_build_preq_ies(sdata, ie, num_bands * iebufsz,
+				       &sched_scan_ies, req->ie,
+				       req->ie_len, bands_used, rate_masks,
+				       &chandef, flags);
+	if (ret < 0)
+		goto error;
 
 	ret = drv_sched_scan_start(local, sdata, req, &sched_scan_ies);
 	if (ret == 0) {
@@ -1327,8 +1331,8 @@ int __ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 		rcu_assign_pointer(local->sched_scan_req, req);
 	}
 
+error:
 	kfree(ie);
-
 out:
 	if (ret) {
 		/* Clean in case of failure after HW restart or upon resume. */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 3888ad3b052f..ea863d78061e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2035,37 +2035,36 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-static u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end)
+static int ieee80211_put_s1g_cap(struct sk_buff *skb,
+				 struct ieee80211_sta_s1g_cap *s1g_cap)
 {
-	if ((end - pos) < 5)
-		return pos;
+	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_s1g_cap))
+		return -ENOBUFS;
 
-	*pos++ = WLAN_EID_EXTENSION;
-	*pos++ = 1 + sizeof(cap);
-	*pos++ = WLAN_EID_EXT_HE_6GHZ_CAPA;
-	memcpy(pos, &cap, sizeof(cap));
+	skb_put_u8(skb, WLAN_EID_S1G_CAPABILITIES);
+	skb_put_u8(skb, sizeof(struct ieee80211_s1g_cap));
 
-	return pos + 2;
+	skb_put_data(skb, &s1g_cap->cap, sizeof(s1g_cap->cap));
+	skb_put_data(skb, &s1g_cap->nss_mcs, sizeof(s1g_cap->nss_mcs));
+
+	return 0;
 }
 
-static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
-					 u8 *buffer, size_t buffer_len,
-					 const u8 *ie, size_t ie_len,
-					 enum nl80211_band band,
-					 u32 rate_mask,
-					 struct cfg80211_chan_def *chandef,
-					 size_t *offset, u32 flags)
+static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
+				       struct ieee80211_sub_if_data *sdata,
+				       const u8 *ie, size_t ie_len,
+				       size_t *offset,
+				       enum nl80211_band band,
+				       u32 rate_mask,
+				       struct cfg80211_chan_def *chandef,
+				       u32 flags)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	const struct ieee80211_sta_he_cap *he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap;
-	u8 *pos = buffer, *end = buffer + buffer_len;
+	int i, err;
 	size_t noffset;
-	int supp_rates_len, i;
-	u8 rates[32];
-	int num_rates;
-	int ext_rates_len;
 	u32 rate_flags;
 	bool have_80mhz = false;
 
@@ -2078,32 +2077,13 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	rate_flags = ieee80211_chandef_rate_flags(chandef);
 
 	/* For direct scan add S1G IE and consider its override bits */
-	if (band == NL80211_BAND_S1GHZ) {
-		if (end - pos < 2 + sizeof(struct ieee80211_s1g_cap))
-			goto out_err;
-		pos = ieee80211_ie_build_s1g_cap(pos, &sband->s1g_cap);
-		goto done;
-	}
+	if (band == NL80211_BAND_S1GHZ)
+		return ieee80211_put_s1g_cap(skb, &sband->s1g_cap);
 
-	num_rates = 0;
-	for (i = 0; i < sband->n_bitrates; i++) {
-		if ((BIT(i) & rate_mask) == 0)
-			continue; /* skip rate */
-		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
-			continue;
-
-		rates[num_rates++] =
-			(u8) DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
-	}
-
-	supp_rates_len = min_t(int, num_rates, 8);
-
-	if (end - pos < 2 + supp_rates_len)
-		goto out_err;
-	*pos++ = WLAN_EID_SUPP_RATES;
-	*pos++ = supp_rates_len;
-	memcpy(pos, rates, supp_rates_len);
-	pos += supp_rates_len;
+	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags, 0,
+					WLAN_EID_SUPP_RATES);
+	if (err)
+		return err;
 
 	/* insert "request information" if in custom IEs */
 	if (ie && ie_len) {
@@ -2116,34 +2096,28 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 					     before_extrates,
 					     ARRAY_SIZE(before_extrates),
 					     *offset);
-		if (end - pos < noffset - *offset)
-			goto out_err;
-		memcpy(pos, ie + *offset, noffset - *offset);
-		pos += noffset - *offset;
+		if (skb_tailroom(skb) < noffset - *offset)
+			return -ENOBUFS;
+		skb_put_data(skb, ie + *offset, noffset - *offset);
 		*offset = noffset;
 	}
 
-	ext_rates_len = num_rates - supp_rates_len;
-	if (ext_rates_len > 0) {
-		if (end - pos < 2 + ext_rates_len)
-			goto out_err;
-		*pos++ = WLAN_EID_EXT_SUPP_RATES;
-		*pos++ = ext_rates_len;
-		memcpy(pos, rates + supp_rates_len, ext_rates_len);
-		pos += ext_rates_len;
-	}
+	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags, 0,
+					WLAN_EID_EXT_SUPP_RATES);
+	if (err)
+		return err;
 
 	if (chandef->chan && sband->band == NL80211_BAND_2GHZ) {
-		if (end - pos < 3)
-			goto out_err;
-		*pos++ = WLAN_EID_DS_PARAMS;
-		*pos++ = 1;
-		*pos++ = ieee80211_frequency_to_channel(
-				chandef->chan->center_freq);
+		if (skb_tailroom(skb) < 3)
+			return -ENOBUFS;
+		skb_put_u8(skb, WLAN_EID_DS_PARAMS);
+		skb_put_u8(skb, 1);
+		skb_put_u8(skb,
+			   ieee80211_frequency_to_channel(chandef->chan->center_freq));
 	}
 
 	if (flags & IEEE80211_PROBE_FLAG_MIN_CONTENT)
-		goto done;
+		return 0;
 
 	/* insert custom IEs that go before HT */
 	if (ie && ie_len) {
@@ -2158,18 +2132,21 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		noffset = ieee80211_ie_split(ie, ie_len,
 					     before_ht, ARRAY_SIZE(before_ht),
 					     *offset);
-		if (end - pos < noffset - *offset)
-			goto out_err;
-		memcpy(pos, ie + *offset, noffset - *offset);
-		pos += noffset - *offset;
+		if (skb_tailroom(skb) < noffset - *offset)
+			return -ENOBUFS;
+		skb_put_data(skb, ie + *offset, noffset - *offset);
 		*offset = noffset;
 	}
 
 	if (sband->ht_cap.ht_supported) {
-		if (end - pos < 2 + sizeof(struct ieee80211_ht_cap))
-			goto out_err;
-		pos = ieee80211_ie_build_ht_cap(pos, &sband->ht_cap,
-						sband->ht_cap.cap);
+		u8 *pos;
+
+		if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_ht_cap))
+			return -ENOBUFS;
+
+		pos = skb_put(skb, 2 + sizeof(struct ieee80211_ht_cap));
+		ieee80211_ie_build_ht_cap(pos, &sband->ht_cap,
+					  sband->ht_cap.cap);
 	}
 
 	/* insert custom IEs that go before VHT */
@@ -2190,10 +2167,9 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		noffset = ieee80211_ie_split(ie, ie_len,
 					     before_vht, ARRAY_SIZE(before_vht),
 					     *offset);
-		if (end - pos < noffset - *offset)
-			goto out_err;
-		memcpy(pos, ie + *offset, noffset - *offset);
-		pos += noffset - *offset;
+		if (skb_tailroom(skb) < noffset - *offset)
+			return -ENOBUFS;
+		skb_put_data(skb, ie + *offset, noffset - *offset);
 		*offset = noffset;
 	}
 
@@ -2208,10 +2184,14 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (sband->vht_cap.vht_supported && have_80mhz) {
-		if (end - pos < 2 + sizeof(struct ieee80211_vht_cap))
-			goto out_err;
-		pos = ieee80211_ie_build_vht_cap(pos, &sband->vht_cap,
-						 sband->vht_cap.cap);
+		u8 *pos;
+
+		if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_vht_cap))
+			return -ENOBUFS;
+
+		pos = skb_put(skb, 2 + sizeof(struct ieee80211_vht_cap));
+		ieee80211_ie_build_vht_cap(pos, &sband->vht_cap,
+					   sband->vht_cap.cap);
 	}
 
 	/* insert custom IEs that go before HE */
@@ -2228,10 +2208,9 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		noffset = ieee80211_ie_split(ie, ie_len,
 					     before_he, ARRAY_SIZE(before_he),
 					     *offset);
-		if (end - pos < noffset - *offset)
-			goto out_err;
-		memcpy(pos, ie + *offset, noffset - *offset);
-		pos += noffset - *offset;
+		if (skb_tailroom(skb) < noffset - *offset)
+			return -ENOBUFS;
+		skb_put_data(skb, ie + *offset, noffset - *offset);
 		*offset = noffset;
 	}
 
@@ -2239,9 +2218,13 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	if (he_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE)) {
+		u8 *pos = skb_tail_pointer(skb);
+		u8 *end = pos + skb_tailroom(skb);
+
 		pos = ieee80211_ie_build_he_cap(NULL, he_cap, pos, end);
 		if (!pos)
-			goto out_err;
+			return -ENOBUFS;
+		skb_put(skb, pos - skb_tail_pointer(skb));
 	}
 
 	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
@@ -2250,42 +2233,72 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE |
 					 IEEE80211_CHAN_NO_EHT)) {
+		u8 *pos = skb_tail_pointer(skb);
+		u8 *end = pos + skb_tailroom(skb);
+
 		pos = ieee80211_ie_build_eht_cap(NULL, pos, he_cap, eht_cap,
 						 end,
 						 sdata->vif.type == NL80211_IFTYPE_AP);
 		if (!pos)
-			goto out_err;
+			return -ENOBUFS;
+		skb_put(skb, pos - skb_tail_pointer(skb));
 	}
 
-	if (cfg80211_any_usable_channels(local->hw.wiphy,
-					 BIT(NL80211_BAND_6GHZ),
-					 IEEE80211_CHAN_NO_HE)) {
-		struct ieee80211_supported_band *sband6;
-
-		sband6 = local->hw.wiphy->bands[NL80211_BAND_6GHZ];
-		he_cap = ieee80211_get_he_iftype_cap_vif(sband6, &sdata->vif);
-
-		if (he_cap) {
-			enum nl80211_iftype iftype =
-				ieee80211_vif_type_p2p(&sdata->vif);
-			__le16 cap = ieee80211_get_he_6ghz_capa(sband6, iftype);
-
-			pos = ieee80211_write_he_6ghz_cap(pos, cap, end);
-		}
-	}
+	err = ieee80211_put_he_6ghz_cap(skb, sdata, IEEE80211_SMPS_OFF);
+	if (err)
+		return err;
 
 	/*
 	 * If adding more here, adjust code in main.c
 	 * that calculates local->scan_ies_len.
 	 */
 
-	return pos - buffer;
- out_err:
-	WARN_ONCE(1, "not enough space for preq IEs\n");
- done:
-	return pos - buffer;
+	return 0;
 }
 
+static int ieee80211_put_preq_ies(struct sk_buff *skb,
+				  struct ieee80211_sub_if_data *sdata,
+				  struct ieee80211_scan_ies *ie_desc,
+				  const u8 *ie, size_t ie_len,
+				  u8 bands_used, u32 *rate_masks,
+				  struct cfg80211_chan_def *chandef,
+				  u32 flags)
+{
+	size_t custom_ie_offset = 0;
+	int i, err;
+
+	memset(ie_desc, 0, sizeof(*ie_desc));
+
+	for (i = 0; i < NUM_NL80211_BANDS; i++) {
+		if (bands_used & BIT(i)) {
+			ie_desc->ies[i] = skb_tail_pointer(skb);
+			err = ieee80211_put_preq_ies_band(skb, sdata,
+							  ie, ie_len,
+							  &custom_ie_offset,
+							  i, rate_masks[i],
+							  chandef, flags);
+			if (err)
+				return err;
+			ie_desc->len[i] = skb_tail_pointer(skb) -
+					  ie_desc->ies[i];
+		}
+	}
+
+	/* add any remaining custom IEs */
+	if (ie && ie_len) {
+		if (WARN_ONCE(skb_tailroom(skb) < ie_len - custom_ie_offset,
+			      "not enough space for preq custom IEs\n"))
+			return -ENOBUFS;
+		ie_desc->common_ies = skb_tail_pointer(skb);
+		skb_put_data(skb, ie + custom_ie_offset,
+			     ie_len - custom_ie_offset);
+		ie_desc->common_ie_len = skb_tail_pointer(skb) -
+					 ie_desc->common_ies;
+	}
+
+	return 0;
+};
+
 int ieee80211_build_preq_ies(struct ieee80211_sub_if_data *sdata, u8 *buffer,
 			     size_t buffer_len,
 			     struct ieee80211_scan_ies *ie_desc,
@@ -2294,41 +2307,43 @@ int ieee80211_build_preq_ies(struct ieee80211_sub_if_data *sdata, u8 *buffer,
 			     struct cfg80211_chan_def *chandef,
 			     u32 flags)
 {
-	size_t pos = 0, old_pos = 0, custom_ie_offset = 0;
-	int i;
+	struct sk_buff *skb = alloc_skb(buffer_len, GFP_KERNEL);
+	uintptr_t offs;
+	int ret, i;
+	u8 *start;
 
-	memset(ie_desc, 0, sizeof(*ie_desc));
+	if (!skb)
+		return -ENOMEM;
 
+	start = skb_tail_pointer(skb);
+	memset(start, 0, skb_tailroom(skb));
+	ret = ieee80211_put_preq_ies(skb, sdata, ie_desc, ie, ie_len,
+				     bands_used, rate_masks, chandef,
+				     flags);
+	if (ret < 0) {
+		goto out;
+	}
+
+	if (skb->len > buffer_len) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+
+	memcpy(buffer, start, skb->len);
+
+	/* adjust ie_desc for copy */
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
-		if (bands_used & BIT(i)) {
-			pos += ieee80211_build_preq_ies_band(sdata,
-							     buffer + pos,
-							     buffer_len - pos,
-							     ie, ie_len, i,
-							     rate_masks[i],
-							     chandef,
-							     &custom_ie_offset,
-							     flags);
-			ie_desc->ies[i] = buffer + old_pos;
-			ie_desc->len[i] = pos - old_pos;
-			old_pos = pos;
-		}
+		offs = ie_desc->ies[i] - start;
+		ie_desc->ies[i] = buffer + offs;
 	}
+	offs = ie_desc->common_ies - start;
+	ie_desc->common_ies = buffer + offs;
 
-	/* add any remaining custom IEs */
-	if (ie && ie_len) {
-		if (WARN_ONCE(buffer_len - pos < ie_len - custom_ie_offset,
-			      "not enough space for preq custom IEs\n"))
-			return pos;
-		memcpy(buffer + pos, ie + custom_ie_offset,
-		       ie_len - custom_ie_offset);
-		ie_desc->common_ies = buffer + pos;
-		ie_desc->common_ie_len = ie_len - custom_ie_offset;
-		pos += ie_len - custom_ie_offset;
-	}
-
-	return pos;
-};
+	ret = skb->len;
+out:
+	consume_skb(skb);
+	return ret;
+}
 
 struct sk_buff *ieee80211_build_probe_req(struct ieee80211_sub_if_data *sdata,
 					  const u8 *src, const u8 *dst,
@@ -2342,7 +2357,6 @@ struct sk_buff *ieee80211_build_probe_req(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_chan_def chandef;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
-	int ies_len;
 	u32 rate_masks[NUM_NL80211_BANDS] = {};
 	struct ieee80211_scan_ies dummy_ie_desc;
 
@@ -2363,11 +2377,9 @@ struct sk_buff *ieee80211_build_probe_req(struct ieee80211_sub_if_data *sdata,
 		return NULL;
 
 	rate_masks[chan->band] = ratemask;
-	ies_len = ieee80211_build_preq_ies(sdata, skb_tail_pointer(skb),
-					   skb_tailroom(skb), &dummy_ie_desc,
-					   ie, ie_len, BIT(chan->band),
-					   rate_masks, &chandef, flags);
-	skb_put(skb, ies_len);
+	ieee80211_put_preq_ies(skb, sdata, &dummy_ie_desc,
+			       ie, ie_len, BIT(chan->band),
+			       rate_masks, &chandef, flags);
 
 	if (dst) {
 		mgmt = (struct ieee80211_mgmt *) skb->data;
@@ -3202,21 +3214,6 @@ size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset)
 	return pos;
 }
 
-u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap)
-{
-	*pos++ = WLAN_EID_S1G_CAPABILITIES;
-	*pos++ = sizeof(struct ieee80211_s1g_cap);
-	memset(pos, 0, sizeof(struct ieee80211_s1g_cap));
-
-	memcpy(pos, &s1g_cap->cap, sizeof(s1g_cap->cap));
-	pos += sizeof(s1g_cap->cap);
-
-	memcpy(pos, &s1g_cap->nss_mcs, sizeof(s1g_cap->nss_mcs));
-	pos += sizeof(s1g_cap->nss_mcs);
-
-	return pos;
-}
-
 u8 *ieee80211_ie_build_ht_cap(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
 			      u16 cap)
 {
@@ -3413,33 +3410,32 @@ u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 	return pos;
 }
 
-void ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum ieee80211_smps_mode smps_mode)
+int ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
+			      struct ieee80211_sub_if_data *sdata,
+			      enum ieee80211_smps_mode smps_mode)
 {
 	struct ieee80211_supported_band *sband;
 	const struct ieee80211_sband_iftype_data *iftd;
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
-	u8 *pos;
-	u16 cap;
+	__le16 cap;
 
 	if (!cfg80211_any_usable_channels(sdata->local->hw.wiphy,
 					  BIT(NL80211_BAND_6GHZ),
 					  IEEE80211_CHAN_NO_HE))
-		return;
+		return 0;
 
 	sband = sdata->local->hw.wiphy->bands[NL80211_BAND_6GHZ];
 
 	iftd = ieee80211_get_sband_iftype_data(sband, iftype);
 	if (!iftd)
-		return;
+		return 0;
 
 	/* Check for device HE 6 GHz capability before adding element */
 	if (!iftd->he_6ghz_capa.capa)
-		return;
+		return 0;
 
-	cap = le16_to_cpu(iftd->he_6ghz_capa.capa);
-	cap &= ~IEEE80211_HE_6GHZ_CAP_SM_PS;
+	cap = iftd->he_6ghz_capa.capa;
+	cap &= cpu_to_le16(~IEEE80211_HE_6GHZ_CAP_SM_PS);
 
 	switch (smps_mode) {
 	case IEEE80211_SMPS_AUTOMATIC:
@@ -3447,22 +3443,27 @@ void ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
 		WARN_ON(1);
 		fallthrough;
 	case IEEE80211_SMPS_OFF:
-		cap |= u16_encode_bits(WLAN_HT_CAP_SM_PS_DISABLED,
-				       IEEE80211_HE_6GHZ_CAP_SM_PS);
+		cap |= le16_encode_bits(WLAN_HT_CAP_SM_PS_DISABLED,
+					IEEE80211_HE_6GHZ_CAP_SM_PS);
 		break;
 	case IEEE80211_SMPS_STATIC:
-		cap |= u16_encode_bits(WLAN_HT_CAP_SM_PS_STATIC,
-				       IEEE80211_HE_6GHZ_CAP_SM_PS);
+		cap |= le16_encode_bits(WLAN_HT_CAP_SM_PS_STATIC,
+					IEEE80211_HE_6GHZ_CAP_SM_PS);
 		break;
 	case IEEE80211_SMPS_DYNAMIC:
-		cap |= u16_encode_bits(WLAN_HT_CAP_SM_PS_DYNAMIC,
-				       IEEE80211_HE_6GHZ_CAP_SM_PS);
+		cap |= le16_encode_bits(WLAN_HT_CAP_SM_PS_DYNAMIC,
+					IEEE80211_HE_6GHZ_CAP_SM_PS);
 		break;
 	}
 
-	pos = skb_put(skb, 2 + 1 + sizeof(cap));
-	ieee80211_write_he_6ghz_cap(pos, cpu_to_le16(cap),
-				    pos + 2 + 1 + sizeof(cap));
+	if (skb_tailroom(skb) < 2 + 1 + sizeof(cap))
+		return -ENOBUFS;
+
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	skb_put_u8(skb, 1 + sizeof(cap));
+	skb_put_u8(skb, WLAN_EID_EXT_HE_6GHZ_CAPA);
+	skb_put_data(skb, &cap, sizeof(cap));
+	return 0;
 }
 
 u8 *ieee80211_ie_build_ht_oper(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
-- 
2.43.0


