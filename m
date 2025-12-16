Return-Path: <linux-wireless+bounces-29821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69ACC44B0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DE93089414
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12662BE7B2;
	Tue, 16 Dec 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hts5zqSa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D892BEFF1
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902277; cv=none; b=UvleEQvL7p+/vLx/lJQT2HnfROYBfOk2QytE+5lna/gY3asZ6H42dUBGfvx7wPpl6aFL+h0TV5nWlUtTT425XjX5Ha5JMcsW0kR13TaBGwXDihmWWGh+L7GqrwWo1tpiFtnMieviBP9MpbZqlZAETFgC2fY7txx5YDdruz9nn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902277; c=relaxed/simple;
	bh=ugO9ttChJiMErIgoiFXbbncnm3Yxj2MQ8us+1MKbRSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnKu5h/ULc+U37ORCoYC79TgsSSg+y2p2kNqCYRgpKmBIGiJ3BfXd+7I6GCa9L+oYFmU2gf3c96uRbpae2GLJaZPMXRgqC/JToRUoE8u0h+gpRlj4MIyGhoQepCb0FaC+mqga9RsLle0cHJm6LEkg6tkhKzBq9sQMR98WlXJ4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hts5zqSa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zefgNM2uJv5Os6gIXx5p0F3+b3c+0ZOhAzDknghzAsA=;
	t=1765902271; x=1767111871; b=hts5zqSaSCc5bR3JaH7gSHuBkX5ZcvmYm5hXPMaiRZir5j9
	WNZcZel7TDBZ2TTAj3byy0GdgMvlJVEYsf3pbBKk75Km6kKAHWAgz+8lC2QbEavh0sItprDy7bugG
	UTW0vUhh2BihQ6924gnNzD0UZxa0MiNibr7tvE4ZKgmfJ3wBZyUeVaq2hE+ugE9tz4TtZxhIvWanf
	Jyj5ORXLazkEhpzjfm3GM5v7amvnMawQuq0jsF2+Mcy1nMu2zVG0zMLfXmsdjWn9XSJlzvobXu3Lw
	YfN2TNCeuVS7+0Q97KUPpSx/y3qKtzvBUKwgB8G+1ycoSR30gPOPNRh+TxmDOpCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVXqd-0000000AaUr-3T7Z;
	Tue, 16 Dec 2025 17:24:28 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC v2 wireless-next 3/3] wifi: mac80211: add initial UHR support
Date: Tue, 16 Dec 2025 17:23:37 +0100
Message-ID: <20251216172421.6b2e221c1cd6.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216162421.40066-5-johannes@sipsolutions.net>
References: <20251216162421.40066-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add support for making UHR connections and accepting AP
stations with UHR support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  33 +++++++++-
 net/mac80211/Makefile      |   2 +-
 net/mac80211/cfg.c         |  14 ++++
 net/mac80211/ieee80211_i.h |  17 ++++-
 net/mac80211/main.c        |  13 +++-
 net/mac80211/mlme.c        | 131 ++++++++++++++++++++++++++++++++++---
 net/mac80211/parse.c       |  20 ++++++
 net/mac80211/rx.c          |  21 ++++++
 net/mac80211/sta_info.c    |  11 ++++
 net/mac80211/sta_info.h    |  80 ++++++++++++++++------
 net/mac80211/uhr.c         |  29 ++++++++
 net/mac80211/util.c        |  33 ++++++++++
 12 files changed, 372 insertions(+), 32 deletions(-)
 create mode 100644 net/mac80211/uhr.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c2e49542626c..826b19109958 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -706,6 +706,7 @@ struct ieee80211_parsed_tpe {
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
  * @epcs_support: does this BSS support EPCS
+ * @uhr_support: does this BSS support UHR
  * @csa_active: marks whether a channel switch is going on.
  * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
@@ -832,6 +833,8 @@ struct ieee80211_bss_conf {
 	u8 pwr_reduction;
 	bool eht_support;
 	bool epcs_support;
+	bool uhr_support;
+
 	bool csa_active;
 
 	bool mu_mimo_owner;
@@ -1598,6 +1601,7 @@ enum mac80211_rx_encoding {
 	RX_ENC_VHT,
 	RX_ENC_HE,
 	RX_ENC_EHT,
+	RX_ENC_UHR,
 };
 
 /**
@@ -1631,7 +1635,7 @@ enum mac80211_rx_encoding {
  * @antenna: antenna used
  * @rate_idx: index of data rate into band's supported rates or MCS index if
  *	HT or VHT is used (%RX_FLAG_HT/%RX_FLAG_VHT)
- * @nss: number of streams (VHT, HE and EHT only)
+ * @nss: number of streams (VHT, HE, EHT and UHR only)
  * @flag: %RX_FLAG_\*
  * @encoding: &enum mac80211_rx_encoding
  * @bw: &enum rate_info_bw
@@ -1642,6 +1646,11 @@ enum mac80211_rx_encoding {
  * @eht: EHT specific rate information
  * @eht.ru: EHT RU, from &enum nl80211_eht_ru_alloc
  * @eht.gi: EHT GI, from &enum nl80211_eht_gi
+ * @uhr: UHR specific rate information
+ * @uhr.ru: UHR RU, from &enum nl80211_eht_ru_alloc
+ * @uhr.gi: UHR GI, from &enum nl80211_eht_gi
+ * @uhr.elr: UHR ELR MCS was used
+ * @uhr.im: UHR interference mitigation was used
  * @rx_flags: internal RX flags for mac80211
  * @ampdu_reference: A-MPDU reference number, must be a different value for
  *	each A-MPDU but the same for each subframe within one A-MPDU
@@ -1673,6 +1682,12 @@ struct ieee80211_rx_status {
 			u8 ru:4;
 			u8 gi:2;
 		} eht;
+		struct {
+			u8 ru:4;
+			u8 gi:2;
+			u8 elr:1;
+			u8 im:1;
+		} uhr;
 	};
 	u8 rate_idx;
 	u8 nss;
@@ -2434,6 +2449,7 @@ struct ieee80211_sta_aggregates {
  * @he_cap: HE capabilities of this STA
  * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
  * @eht_cap: EHT capabilities of this STA
+ * @uhr_cap: UHR capabilities of this STA
  * @s1g_cap: S1G capabilities of this STA
  * @agg: per-link data for multi-link aggregation
  * @bandwidth: current bandwidth the station can receive with
@@ -2457,6 +2473,7 @@ struct ieee80211_link_sta {
 	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_he_6ghz_capa he_6ghz_capa;
 	struct ieee80211_sta_eht_cap eht_cap;
+	struct ieee80211_sta_uhr_cap uhr_cap;
 	struct ieee80211_sta_s1g_cap s1g_cap;
 
 	struct ieee80211_sta_aggregates agg;
@@ -7236,6 +7253,20 @@ ieee80211_get_eht_iftype_cap_vif(const struct ieee80211_supported_band *sband,
 	return ieee80211_get_eht_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
 }
 
+/**
+ * ieee80211_get_uhr_iftype_cap_vif - return UHR capabilities for sband/vif
+ * @sband: the sband to search for the iftype on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: pointer to the struct ieee80211_sta_uhr_cap, or %NULL is none found
+ */
+static inline const struct ieee80211_sta_uhr_cap *
+ieee80211_get_uhr_iftype_cap_vif(const struct ieee80211_supported_band *sband,
+				 struct ieee80211_vif *vif)
+{
+	return ieee80211_get_uhr_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
+}
+
 /**
  * ieee80211_update_mu_groups - set the VHT MU-MIMO groud data
  *
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index a33884967f21..b0e392eb7753 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -36,7 +36,7 @@ mac80211-y := \
 	tdls.o \
 	ocb.o \
 	airtime.o \
-	eht.o
+	eht.o uhr.o
 
 mac80211-$(CONFIG_MAC80211_LEDS) += led.o
 mac80211-$(CONFIG_MAC80211_DEBUGFS) += \
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b51c2c8584ae..c6eae57832d3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1610,6 +1610,13 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		link_conf->eht_mu_beamformer = false;
 	}
 
+	if (params->uhr_capa) {
+		if (!link_conf->eht_support)
+			return -EOPNOTSUPP;
+
+		link_conf->uhr_support = true;
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
@@ -2087,6 +2094,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		       params->vht_capa ||
 		       params->he_capa ||
 		       params->eht_capa ||
+		       params->uhr_capa ||
 		       params->s1g_capa ||
 		       params->opmode_notif_used;
 
@@ -2166,6 +2174,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 						    params->eht_capa_len,
 						    link_sta);
 
+	if (params->uhr_capa)
+		ieee80211_uhr_cap_ie_to_sta_uhr_cap(sdata, sband,
+						    params->uhr_capa,
+						    params->uhr_capa_len,
+						    link_sta);
+
 	if (params->s1g_capa)
 		ieee80211_s1g_cap_to_sta_s1g_cap(sdata, params->s1g_capa,
 						 link_sta);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9d9313eee59f..4a3b92c241f7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -394,9 +394,10 @@ enum ieee80211_conn_mode {
 	IEEE80211_CONN_MODE_VHT,
 	IEEE80211_CONN_MODE_HE,
 	IEEE80211_CONN_MODE_EHT,
+	IEEE80211_CONN_MODE_UHR,
 };
 
-#define IEEE80211_CONN_MODE_HIGHEST	IEEE80211_CONN_MODE_EHT
+#define IEEE80211_CONN_MODE_HIGHEST	IEEE80211_CONN_MODE_UHR
 
 enum ieee80211_conn_bw_limit {
 	IEEE80211_CONN_BW_LIMIT_20,
@@ -1826,6 +1827,8 @@ struct ieee802_11_elems {
 	const struct ieee80211_multi_link_elem *ml_epcs;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
+	const struct ieee80211_uhr_capa *uhr_capa;
+	const struct ieee80211_uhr_oper *uhr_oper;
 
 	/* not the order in the psd values is per element, not per chandef */
 	struct ieee80211_parsed_tpe tpe;
@@ -1850,6 +1853,8 @@ struct ieee802_11_elems {
 	u8 country_elem_len;
 	u8 bssid_index_len;
 	u8 eht_cap_len;
+	u8 uhr_capa_len;
+	u8 uhr_oper_len;
 
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t ml_basic_len;
@@ -2686,6 +2691,9 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 			  struct ieee80211_sub_if_data *sdata,
 			  const struct ieee80211_supported_band *sband,
 			  const struct ieee80211_conn_settings *conn);
+int ieee80211_put_uhr_cap(struct sk_buff *skb,
+			  struct ieee80211_sub_if_data *sdata,
+			  const struct ieee80211_supported_band *sband);
 int ieee80211_put_reg_conn(struct sk_buff *skb,
 			   enum ieee80211_channel_flags flags);
 
@@ -2861,6 +2869,13 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_mgmt *mgmt, size_t len);
 void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata);
 
+void
+ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_uhr_capa *uhr_capa,
+				    u8 uhr_capa_len,
+				    struct link_sta_info *link_sta);
+
 #if IS_ENABLED(CONFIG_MAC80211_KUNIT_TEST)
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
 #define VISIBLE_IF_MAC80211_KUNIT
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7f17..b209e865a657 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1123,7 +1123,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	int result, i;
 	enum nl80211_band band;
 	int channels, max_bitrates;
-	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g;
+	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g, supp_uhr;
 	struct cfg80211_chan_def dflt_chandef = {};
 
 	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
@@ -1237,6 +1237,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	supp_he = false;
 	supp_eht = false;
 	supp_s1g = false;
+	supp_uhr = false;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		const struct ieee80211_sband_iftype_data *iftd;
 		struct ieee80211_supported_band *sband;
@@ -1293,6 +1294,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 			supp_he = supp_he || iftd->he_cap.has_he;
 			supp_eht = supp_eht || iftd->eht_cap.has_eht;
+			supp_uhr = supp_uhr || iftd->uhr_cap.has_uhr;
 
 			if (band == NL80211_BAND_2GHZ)
 				he_40_mhz_cap =
@@ -1325,6 +1327,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		if (WARN_ON(supp_eht && !supp_he))
 			return -EINVAL;
 
+		/* UHR requires EHT support */
+		if (WARN_ON(supp_uhr && !supp_eht))
+			return -EINVAL;
+
 		if (!sband->ht_cap.ht_supported)
 			continue;
 
@@ -1437,6 +1443,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				IEEE80211_EHT_PPE_THRES_MAX_LEN;
 	}
 
+	if (supp_uhr)
+		local->scan_ies_len +=
+			3 + sizeof(struct ieee80211_uhr_capa) +
+			sizeof(struct ieee80211_uhr_capa_phy);
+
 	if (!local->ops->hw_scan) {
 		/* For hw_scan, driver needs to set these up. */
 		local->hw.wiphy->max_scan_ssids = 4;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e56ad4b9330f..c03c6f164df7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -149,6 +149,28 @@ static int ecw2cw(int ecw)
 	return (1 << ecw) - 1;
 }
 
+static int ieee80211_prim_chan_index(const struct cfg80211_chan_def *chandef)
+{
+	u32 start;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		return 0;
+	case NL80211_CHAN_WIDTH_40:
+	case NL80211_CHAN_WIDTH_80:
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_320:
+		start = chandef->center_freq1 -
+			cfg80211_chandef_get_width(chandef) / 2;
+		return (chandef->chan->center_freq - start - 10) / 20;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
 static enum ieee80211_conn_mode
 ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_channel *channel,
@@ -162,6 +184,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
 	const struct ieee80211_he_operation *he_oper = elems->he_operation;
 	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
+	const struct ieee80211_uhr_oper *uhr_oper = elems->uhr_oper;
 	struct ieee80211_supported_band *sband =
 		sdata->local->hw.wiphy->bands[channel->band];
 	struct cfg80211_chan_def vht_chandef;
@@ -192,7 +215,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 
 	/* get special 6 GHz case out of the way */
 	if (sband->band == NL80211_BAND_6GHZ) {
-		enum ieee80211_conn_mode mode = IEEE80211_CONN_MODE_EHT;
+		enum ieee80211_conn_mode mode = IEEE80211_CONN_MODE_HIGHEST;
 
 		/* this is an error */
 		if (conn->mode < IEEE80211_CONN_MODE_HE)
@@ -215,7 +238,9 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 			return IEEE80211_CONN_MODE_LEGACY;
 		}
 
-		return mode;
+		if (mode <= IEEE80211_CONN_MODE_EHT)
+			return mode;
+		goto check_uhr;
 	}
 
 	/* now we have the progression HT, VHT, ... */
@@ -340,7 +365,57 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		*chandef = eht_chandef;
 	}
 
-	return IEEE80211_CONN_MODE_EHT;
+check_uhr:
+	if (conn->mode < IEEE80211_CONN_MODE_UHR || !uhr_oper)
+		return IEEE80211_CONN_MODE_EHT;
+
+	/*
+	 * In beacons we don't have all the data - but we know the size was OK,
+	 * so if the size is valid as a non-beacon case, we have more data and
+	 * can validate the NPCA parameters.
+	 */
+	if (ieee80211_uhr_oper_size_ok((const void *)uhr_oper,
+				       elems->uhr_oper_len,
+				       false)) {
+		struct cfg80211_chan_def npca_chandef = *chandef;
+		const struct ieee80211_uhr_npca_info *npca;
+		const __le16 *dis_subch_bmap;
+		u16 punct = chandef->punctured, npca_punct;
+
+		npca = ieee80211_uhr_npca_info(uhr_oper);
+		if (npca) {
+			u8 ch = le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN);
+
+			if (20 * ch >= cfg80211_chandef_get_width(chandef) ||
+			    ch == ieee80211_prim_chan_index(chandef)) {
+				sdata_info(sdata,
+					   "AP UHR NPCA primary channel invalid, disabling UHR\n");
+				return IEEE80211_CONN_MODE_EHT;
+			}
+		}
+
+		dis_subch_bmap = ieee80211_uhr_npca_dis_subch_bitmap(uhr_oper);
+
+		if (dis_subch_bmap) {
+			npca_punct = get_unaligned_le16(dis_subch_bmap);
+			npca_chandef.punctured = npca_punct;
+		}
+
+		/*
+		 * must be a valid puncturing pattern for this channel as
+		 * well as puncturing all subchannels that are already in
+		 * the disabled subchannel bitmap on the primary channel
+		 */
+		if (!cfg80211_chandef_valid(&npca_chandef) ||
+		    ((punct & npca_punct) != punct)) {
+			sdata_info(sdata,
+				   "AP UHR NPCA disabled subchannel bitmap invalid, disabling UHR\n");
+			return IEEE80211_CONN_MODE_EHT;
+		}
+	}
+
+	return IEEE80211_CONN_MODE_UHR;
 }
 
 static bool
@@ -1091,6 +1166,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 				       IEEE80211_CONN_BW_LIMIT_160);
 		break;
 	case IEEE80211_CONN_MODE_EHT:
+	case IEEE80211_CONN_MODE_UHR:
 		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
 				       conn->bw_limit,
 				       IEEE80211_CONN_BW_LIMIT_320);
@@ -1108,6 +1184,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		set_bit(BSS_MEMBERSHIP_SELECTOR_HE_PHY, sta_selectors);
 	if (conn->mode >= IEEE80211_CONN_MODE_EHT)
 		set_bit(BSS_MEMBERSHIP_SELECTOR_EHT_PHY, sta_selectors);
+	if (conn->mode >= IEEE80211_CONN_MODE_UHR)
+		set_bit(BSS_MEMBERSHIP_SELECTOR_UHR_PHY, sta_selectors);
 
 	/*
 	 * We do not support EPD or GLK so never add them.
@@ -1152,6 +1230,11 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 				       IEEE80211_CONN_BW_LIMIT_160);
 	}
 
+	if (conn->mode >= IEEE80211_CONN_MODE_UHR &&
+	    !cfg80211_chandef_usable(sdata->wdev.wiphy, &chanreq->oper,
+				     IEEE80211_CHAN_NO_UHR))
+		conn->mode = IEEE80211_CONN_MODE_EHT;
+
 	if (chanreq->oper.width != ap_chandef->width || ap_mode != conn->mode)
 		link_id_info(sdata, link_id,
 			     "regulatory prevented using AP config, downgraded\n");
@@ -1881,11 +1964,13 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 
 	/*
 	 * careful - need to know about all the present elems before
-	 * calling ieee80211_assoc_add_ml_elem(), so add this one if
-	 * we're going to put it after the ML element
+	 * calling ieee80211_assoc_add_ml_elem(), so add these if
+	 * we're going to put them after the ML element
 	 */
 	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_EHT)
 		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_EHT_CAPABILITY);
+	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_UHR)
+		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_UHR_CAPA);
 
 	if (link_id == assoc_data->assoc_link_id)
 		ieee80211_assoc_add_ml_elem(sdata, skb, orig_capab, ext_capa,
@@ -1898,6 +1983,9 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 		ieee80211_put_eht_cap(skb, sdata, sband,
 				      &assoc_data->link[link_id].conn);
 
+	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_UHR)
+		ieee80211_put_uhr_cap(skb, sdata, sband);
+
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		ieee80211_add_aid_request_ie(sdata, skb);
 		ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap, skb);
@@ -2132,6 +2220,9 @@ ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
 		sizeof(struct ieee80211_eht_mcs_nss_supp) +
 		IEEE80211_EHT_PPE_THRES_MAX_LEN;
 
+	size += 2 + 1 + sizeof(struct ieee80211_uhr_capa) +
+		sizeof(struct ieee80211_uhr_capa_phy);
+
 	return size;
 }
 
@@ -5517,6 +5608,18 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		bss_conf->epcs_support = false;
 	}
 
+	if (elems->uhr_oper && elems->uhr_capa &&
+	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_UHR) {
+		ieee80211_uhr_cap_ie_to_sta_uhr_cap(sdata, sband,
+						    elems->uhr_capa,
+						    elems->uhr_capa_len,
+						    link_sta);
+
+		bss_conf->uhr_support = link_sta->pub->uhr_cap.has_uhr;
+	} else {
+		bss_conf->uhr_support = false;
+	}
+
 	if (elems->s1g_oper &&
 	    link->u.mgd.conn.mode == IEEE80211_CONN_MODE_S1G &&
 	    elems->s1g_capab)
@@ -5807,6 +5910,7 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
 	bool is_6ghz = sband->band == NL80211_BAND_6GHZ;
 	const struct ieee80211_sta_he_cap *he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap;
+	const struct ieee80211_sta_uhr_cap *uhr_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
@@ -5982,9 +6086,6 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
 				 "no EHT support, limiting to HE\n");
 		goto out;
 	}
-
-	/* we have EHT */
-
 	conn->mode = IEEE80211_CONN_MODE_EHT;
 
 	/* check bandwidth */
@@ -5995,6 +6096,20 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
 		mlme_link_id_dbg(sdata, link_id,
 				 "no EHT 320 MHz cap in 6 GHz, limiting to 160 MHz\n");
 
+	if (req && req->flags & ASSOC_REQ_DISABLE_UHR) {
+		mlme_link_id_dbg(sdata, link_id,
+				 "UHR disabled by flag, limiting to EHT\n");
+		goto out;
+	}
+
+	uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
+	if (!uhr_cap) {
+		mlme_link_id_dbg(sdata, link_id,
+				 "no UHR support, limiting to EHT\n");
+		goto out;
+	}
+	conn->mode = IEEE80211_CONN_MODE_UHR;
+
 out:
 	mlme_link_id_dbg(sdata, link_id,
 			 "determined local STA to be %s, BW limited to %d MHz\n",
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index bfc4ecb7a048..d66e1ce6f477 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -189,6 +189,26 @@ ieee80211_parse_extension_element(u32 *crc,
 			elems->ttlm_num++;
 		}
 		break;
+	case WLAN_EID_EXT_UHR_OPER:
+		if (params->mode < IEEE80211_CONN_MODE_UHR)
+			break;
+		calc_crc = true;
+		if (ieee80211_uhr_oper_size_ok(data, len,
+					       params->type == (IEEE80211_FTYPE_MGMT |
+								IEEE80211_STYPE_BEACON))) {
+			elems->uhr_oper = data;
+			elems->uhr_oper_len = len;
+		}
+		break;
+	case WLAN_EID_EXT_UHR_CAPA:
+		if (params->mode < IEEE80211_CONN_MODE_UHR)
+			break;
+		calc_crc = true;
+		if (ieee80211_uhr_capa_size_ok(data, len)) {
+			elems->uhr_capa = data;
+			elems->uhr_capa_len = len;
+		}
+		break;
 	}
 
 	if (crc && calc_crc)
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6a1899512d07..f5b61ae44177 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5503,6 +5503,27 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 				      status->rate_idx, status->nss, status->eht.gi))
 				goto drop;
 			break;
+		case RX_ENC_UHR:
+			if (WARN_ONCE(!(status->rate_idx <= 15 ||
+					status->rate_idx == 17 ||
+					status->rate_idx == 19 ||
+					status->rate_idx == 20 ||
+					status->rate_idx == 23) ||
+				      !status->nss ||
+				      status->nss > 8 ||
+				      status->uhr.gi > NL80211_RATE_INFO_EHT_GI_3_2,
+				      "Rate marked as a UHR rate but data is invalid: MCS:%d, NSS:%d, GI:%d\n",
+				      status->rate_idx, status->nss, status->uhr.gi))
+				goto drop;
+			if (WARN_ONCE(status->uhr.elr &&
+				      (status->nss != 1 || status->rate_idx > 1 ||
+				       status->uhr.gi != NL80211_RATE_INFO_EHT_GI_1_6 ||
+				       status->bw != RATE_INFO_BW_20 || status->uhr.im),
+				      "bad UHR ELR MCS MCS:%d, NCSS:%d, GI:%d, BW:%d, IM:%d\n",
+				      status->rate_idx, status->nss, status->uhr.gi,
+				      status->bw, status->uhr.im))
+				goto drop;
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			fallthrough;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f4d3b67fda06..1c209eab4c5e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2554,6 +2554,17 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
 		rinfo->eht_gi = STA_STATS_GET(EHT_GI, rate);
 		rinfo->eht_ru_alloc = STA_STATS_GET(EHT_RU, rate);
 		break;
+	case STA_STATS_RATE_TYPE_UHR:
+		rinfo->flags = RATE_INFO_FLAGS_UHR_MCS;
+		rinfo->mcs = STA_STATS_GET(UHR_MCS, rate);
+		rinfo->nss = STA_STATS_GET(UHR_NSS, rate);
+		rinfo->eht_gi = STA_STATS_GET(UHR_GI, rate);
+		rinfo->eht_ru_alloc = STA_STATS_GET(UHR_RU, rate);
+		if (STA_STATS_GET(UHR_ELR, rate))
+			rinfo->flags |= RATE_INFO_FLAGS_UHR_ELR_MCS;
+		if (STA_STATS_GET(UHR_IM, rate))
+			rinfo->flags |= RATE_INFO_FLAGS_UHR_IM;
+		break;
 	}
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5288d5286651..6ef66d3071d0 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -3,7 +3,7 @@
  * Copyright 2002-2005, Devicescape Software, Inc.
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright(c) 2020-2024 Intel Corporation
+ * Copyright(c) 2020-2025 Intel Corporation
  */
 
 #ifndef STA_INFO_H
@@ -1009,25 +1009,49 @@ enum sta_stats_type {
 	STA_STATS_RATE_TYPE_HE,
 	STA_STATS_RATE_TYPE_S1G,
 	STA_STATS_RATE_TYPE_EHT,
+	STA_STATS_RATE_TYPE_UHR,
 };
 
-#define STA_STATS_FIELD_HT_MCS		GENMASK( 7,  0)
-#define STA_STATS_FIELD_LEGACY_IDX	GENMASK( 3,  0)
-#define STA_STATS_FIELD_LEGACY_BAND	GENMASK( 7,  4)
-#define STA_STATS_FIELD_VHT_MCS		GENMASK( 3,  0)
-#define STA_STATS_FIELD_VHT_NSS		GENMASK( 7,  4)
-#define STA_STATS_FIELD_HE_MCS		GENMASK( 3,  0)
-#define STA_STATS_FIELD_HE_NSS		GENMASK( 7,  4)
-#define STA_STATS_FIELD_EHT_MCS		GENMASK( 3,  0)
-#define STA_STATS_FIELD_EHT_NSS		GENMASK( 7,  4)
-#define STA_STATS_FIELD_BW		GENMASK(12,  8)
-#define STA_STATS_FIELD_SGI		GENMASK(13, 13)
-#define STA_STATS_FIELD_TYPE		GENMASK(16, 14)
-#define STA_STATS_FIELD_HE_RU		GENMASK(19, 17)
-#define STA_STATS_FIELD_HE_GI		GENMASK(21, 20)
-#define STA_STATS_FIELD_HE_DCM		GENMASK(22, 22)
-#define STA_STATS_FIELD_EHT_RU		GENMASK(20, 17)
-#define STA_STATS_FIELD_EHT_GI		GENMASK(22, 21)
+/* common */
+#define STA_STATS_FIELD_TYPE		0x0000000F
+#define STA_STATS_FIELD_BW		0x000001F0
+#define STA_STATS_FIELD_RESERVED	0x00000E00
+
+/* STA_STATS_RATE_TYPE_LEGACY */
+#define STA_STATS_FIELD_LEGACY_IDX	0x0000F000
+#define STA_STATS_FIELD_LEGACY_BAND	0x000F0000
+
+/* STA_STATS_RATE_TYPE_HT */
+#define STA_STATS_FIELD_HT_MCS		0x000FF000
+
+/* STA_STATS_RATE_TYPE_VHT */
+#define STA_STATS_FIELD_VHT_MCS		0x0000F000
+#define STA_STATS_FIELD_VHT_NSS		0x000F0000
+
+/* HT & VHT */
+#define STA_STATS_FIELD_SGI		0x00100000
+
+/* STA_STATS_RATE_TYPE_HE */
+#define STA_STATS_FIELD_HE_MCS		0x0000F000
+#define STA_STATS_FIELD_HE_NSS		0x000F0000
+#define STA_STATS_FIELD_HE_RU		0x00700000
+#define STA_STATS_FIELD_HE_GI		0x01800000
+#define STA_STATS_FIELD_HE_DCM		0x02000000
+
+/* STA_STATS_RATE_TYPE_EHT */
+#define STA_STATS_FIELD_EHT_MCS		0x0000F000
+#define STA_STATS_FIELD_EHT_NSS		0x000F0000
+#define STA_STATS_FIELD_EHT_RU		0x00F00000
+#define STA_STATS_FIELD_EHT_GI		0x03000000
+
+/* STA_STATS_RATE_TYPE_UHR */
+#define STA_STATS_FIELD_UHR_MCS		0x0001F000
+#define STA_STATS_FIELD_UHR_NSS		0x001E0000
+#define STA_STATS_FIELD_UHR_RU		0x01E00000
+#define STA_STATS_FIELD_UHR_GI		0x06000000
+#define STA_STATS_FIELD_UHR_ELR		0x08000000
+#define STA_STATS_FIELD_UHR_IM		0x10000000
+
 
 #define STA_STATS_FIELD(_n, _v)		FIELD_PREP(STA_STATS_FIELD_ ## _n, _v)
 #define STA_STATS_GET(_n, _v)		FIELD_GET(STA_STATS_FIELD_ ## _n, _v)
@@ -1040,8 +1064,15 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
 
 	r = STA_STATS_FIELD(BW, s->bw);
 
-	if (s->enc_flags & RX_ENC_FLAG_SHORT_GI)
-		r |= STA_STATS_FIELD(SGI, 1);
+	switch (s->encoding) {
+	case RX_ENC_HT:
+	case RX_ENC_VHT:
+		if (s->enc_flags & RX_ENC_FLAG_SHORT_GI)
+			r |= STA_STATS_FIELD(SGI, 1);
+		break;
+	default:
+		break;
+	}
 
 	switch (s->encoding) {
 	case RX_ENC_VHT:
@@ -1073,6 +1104,15 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
 		r |= STA_STATS_FIELD(EHT_GI, s->eht.gi);
 		r |= STA_STATS_FIELD(EHT_RU, s->eht.ru);
 		break;
+	case RX_ENC_UHR:
+		r |= STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_UHR);
+		r |= STA_STATS_FIELD(UHR_NSS, s->nss);
+		r |= STA_STATS_FIELD(UHR_MCS, s->rate_idx);
+		r |= STA_STATS_FIELD(UHR_GI, s->uhr.gi);
+		r |= STA_STATS_FIELD(UHR_RU, s->uhr.ru);
+		r |= STA_STATS_FIELD(UHR_ELR, s->uhr.elr);
+		r |= STA_STATS_FIELD(UHR_IM, s->uhr.im);
+		break;
 	default:
 		WARN_ON(1);
 		return STA_STATS_RATE_INVALID;
diff --git a/net/mac80211/uhr.c b/net/mac80211/uhr.c
new file mode 100644
index 000000000000..18029fa93f40
--- /dev/null
+++ b/net/mac80211/uhr.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UHR handling
+ *
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#include "ieee80211_i.h"
+
+void
+ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_uhr_capa *uhr_capa,
+				    u8 uhr_capa_len,
+				    struct link_sta_info *link_sta)
+{
+	struct ieee80211_sta_uhr_cap *uhr_cap = &link_sta->pub->uhr_cap;
+
+	memset(uhr_cap, 0, sizeof(*uhr_cap));
+
+	if (!uhr_capa ||
+	    !ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif))
+		return;
+
+	uhr_cap->has_uhr = true;
+
+	uhr_cap->mac = uhr_capa->mac;
+	uhr_cap->phy = *ieee80211_uhr_phy_cap(uhr_capa);
+}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..ce1c4e241f69 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1369,6 +1369,13 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
+					 IEEE80211_CHAN_NO_UHR)) {
+		err = ieee80211_put_uhr_cap(skb, sdata, sband);
+		if (err)
+			return err;
+	}
+
 	/*
 	 * If adding more here, adjust code in main.c
 	 * that calculates local->scan_ies_len.
@@ -4475,6 +4482,31 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 	return 0;
 }
 
+int ieee80211_put_uhr_cap(struct sk_buff *skb,
+			  struct ieee80211_sub_if_data *sdata,
+			  const struct ieee80211_supported_band *sband)
+{
+	const struct ieee80211_sta_uhr_cap *uhr_cap =
+		ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
+	int len;
+
+	if (!uhr_cap)
+		return 0;
+
+        len = 2 + 1 + sizeof(struct ieee80211_uhr_capa) +
+              sizeof(struct ieee80211_uhr_capa_phy);
+        if (skb_tailroom(skb) < len)
+                return -ENOBUFS;
+
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	skb_put_u8(skb, len - 2);
+	skb_put_u8(skb, WLAN_EID_EXT_UHR_CAPA);
+	skb_put_data(skb, &uhr_cap->mac, sizeof(uhr_cap->mac));
+	skb_put_data(skb, &uhr_cap->phy, sizeof(uhr_cap->phy));
+
+	return 0;
+}
+
 const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
 {
 	static const char * const modes[] = {
@@ -4484,6 +4516,7 @@ const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
 		[IEEE80211_CONN_MODE_VHT] = "VHT",
 		[IEEE80211_CONN_MODE_HE] = "HE",
 		[IEEE80211_CONN_MODE_EHT] = "EHT",
+		[IEEE80211_CONN_MODE_UHR] = "UHR",
 	};
 
 	if (WARN_ON(mode >= ARRAY_SIZE(modes)))
-- 
2.52.0


