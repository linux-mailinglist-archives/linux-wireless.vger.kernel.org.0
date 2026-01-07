Return-Path: <linux-wireless+bounces-30493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC00CFF556
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A10BC35E68CE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2B342CA9;
	Wed,  7 Jan 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FeRP3KOY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39921342C99
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795844; cv=none; b=Pmvi4CsM0HCR4IAb4jK5AQ6T+ZW7IvP87p/5Q7nwzZXllx63uUIP+GU1incjT1vAKj5/LqvnF8XHXJ8taEvJiGPpG/+Eupe0trcP77qVxy5RSVtFsdFac1NaeMH6Css7yUboKTCggCdKVJClwmkJFq38eNRRrw/MqaO7ithpvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795844; c=relaxed/simple;
	bh=Z7c2eckiGpF9bkp9w7YPhM99bIycPE63q6GhHepPOUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jf4vrT1dyvv5XUg/A65/DCDDtQ7dkmmv7vG1lPc020nTu3n0QpmxMJJxVk5Ml0MqZhK9I6vro9hmPsS1Vd718BACaUMJPHKmVnVZ97A9HHMckL02P8E2+v2QUugGpRNATby6v6UXUVn3kzTup/kluibGfdYGaHMZRj+X3Jt7r4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FeRP3KOY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=flHFE8Lr+mypWW+GfC0sETkhzjfaMVPsOc2dMm455+g=;
	t=1767795842; x=1769005442; b=FeRP3KOYT2Z/7fTfFuaO6S2cYSpFT1/pa8tquGqOtGjzLcE
	ffVTqk/c4xk3qKEEJqx8JOazPbrXuIMtnZOprSfkNXdMUaA1zBM9ZvDZ57z3hv5dxCdlBg9mEKcfi
	o5DmwJu/bNy91gfr/BuC1x609ftN/8ygKoDXCSDQYcQ3WbxR30+xh8eazpLR2q19WdX7F8TQ7nnga
	rAuIRSIMo7mdsznQzX0tf5rqCd0HPl2fAwsLu9gOabaKSgtK6I4fX+HaZfiCLLwL2AChvpFnDGGUJ
	WWU1bfrt+8jrSK0hdNO7t/irwPWDtV+Dj+albJt4IIIaqQodBPb1LhBHe098z2og==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUS8-00000005agF-0t50;
	Wed, 07 Jan 2026 15:24:00 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 31/46] wifi: mac80211: support NAN stations
Date: Wed,  7 Jan 2026 15:22:30 +0100
Message-ID: <20260107152325.cfcd70fa7bdb.I7a7bd6e8e751cab49c329419485839afd209cfc6@changeid>
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

Add support for both NMI and NDI stations.

The NDI station will be linked to the NMI station of the NAN peer for
which the NDI station is added.

A peer can choose to reuse its NMI address as the NDI address.
Since different keys might be in use for NAN management and for data
frames, we will have 2 different stations, even if they'll have the same
address.

Even though there are no links in NAN, sta->deflink will still be used
to store the one set of capabilities and SMPS mode.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h  | 13 +++++-
 net/mac80211/cfg.c      | 97 ++++++++++++++++++++++++++++++++++++-----
 net/mac80211/he.c       |  7 ++-
 net/mac80211/ht.c       | 19 ++++++--
 net/mac80211/iface.c    | 10 +++--
 net/mac80211/sta_info.c | 21 ++++++++-
 net/mac80211/sta_info.h |  3 +-
 net/mac80211/util.c     | 41 +++++++++++++++++
 net/mac80211/vht.c      | 16 ++++++-
 9 files changed, 202 insertions(+), 25 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 13eefe64b76e..5f2c9e646942 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2469,11 +2469,15 @@ struct ieee80211_sta_aggregates {
  * @eht_cap: EHT capabilities of this STA
  * @s1g_cap: S1G capabilities of this STA
  * @agg: per-link data for multi-link aggregation
- * @bandwidth: current bandwidth the station can receive with
+ * @bandwidth: current bandwidth the station can receive with.
+ *	This is the minimum between the peer's capabilities and our own
+ *	operating channel width; Invalid for NAN since that is operating on
+ *	multiple channels.
  * @rx_nss: in HT/VHT, the maximum number of spatial streams the
  *	station can receive at the moment, changed by operating mode
  *	notifications and capabilities. The value is only valid after
- *	the station moves to associated state.
+ *	the station moves to associated state. Invalid for NAN since it
+ *	operates on multiple configurations of rx_nss.
  * @txpwr: the station tx power configuration
  *
  */
@@ -2553,6 +2557,7 @@ struct ieee80211_link_sta {
  *	by the AP.
  * @valid_links: bitmap of valid links, or 0 for non-MLO
  * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
+ * @nmi: For NDI stations, pointer to the NMI station of the peer.
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2580,6 +2585,8 @@ struct ieee80211_sta {
 	struct ieee80211_link_sta deflink;
 	struct ieee80211_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
+	struct ieee80211_sta __rcu *nmi;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -2813,6 +2820,8 @@ struct ieee80211_txq {
  *	station has a unique address, i.e. each station entry can be identified
  *	by just its MAC address; this prevents, for example, the same station
  *	from connecting to two virtual AP interfaces at the same time.
+ *	Note that this doesn't apply for NAN, in which the peer's NMI address
+ *	can be equal to its NDI address.
  *
  * @IEEE80211_HW_SUPPORTS_REORDERING_BUFFER: Hardware (or driver) manages the
  *	reordering buffer internally, guaranteeing mac80211 receives frames in
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7eb9f651c03b..a735212e322a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2070,7 +2070,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 				     enum sta_link_apply_mode mode,
 				     struct link_station_parameters *params)
 {
-	struct ieee80211_supported_band *sband;
+	struct ieee80211_supported_band *sband = NULL;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	u32 link_id = params->link_id < 0 ? 0 : params->link_id;
 	struct ieee80211_link_data *link =
@@ -2078,6 +2078,9 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	struct link_sta_info *link_sta =
 		rcu_dereference_protected(sta->link[link_id],
 					  lockdep_is_held(&local->hw.wiphy->mtx));
+	const struct ieee80211_sta_ht_cap *own_ht_cap;
+	const struct ieee80211_sta_vht_cap *own_vht_cap;
+	const struct ieee80211_sta_he_cap *own_he_cap;
 	bool changes = params->link_mac ||
 		       params->txpwr_set ||
 		       params->supported_rates_len ||
@@ -2106,9 +2109,20 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	if (!link || !link_sta)
 		return -EINVAL;
 
-	sband = ieee80211_get_link_sband(link);
-	if (!sband)
-		return -EINVAL;
+	if (sdata->vif.type == NL80211_IFTYPE_NAN ||
+	    sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+		own_ht_cap = &local->hw.wiphy->nan_capa.phy.ht;
+		own_vht_cap = &local->hw.wiphy->nan_capa.phy.vht;
+		own_he_cap = &local->hw.wiphy->nan_capa.phy.he;
+	} else {
+		sband = ieee80211_get_link_sband(link);
+		if (!sband)
+			return -EINVAL;
+
+		own_ht_cap = &sband->ht_cap;
+		own_vht_cap = &sband->vht_cap;
+		own_he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	}
 
 	if (params->link_mac) {
 		if (mode == STA_LINK_MODE_NEW) {
@@ -2131,6 +2145,28 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 			return ret;
 	}
 
+	if (sdata->vif.type == NL80211_IFTYPE_NAN ||
+	    sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+		static const u8 all_ofdm_rates[] = {
+			0x0c, 0x12, 0x18, 0x24, 0x30, 0x48, 0x60, 0x6c
+		};
+
+		/* Set the same supported_rates for all bands */
+		for (int i = 0; i < NUM_NL80211_BANDS; i++) {
+			struct ieee80211_supported_band *tmp =
+				sdata->local->hw.wiphy->bands[i];
+
+			if ((i != NL80211_BAND_2GHZ && i != NL80211_BAND_5GHZ) ||
+			    !tmp)
+				continue;
+
+			if (!ieee80211_parse_bitrates(tmp, all_ofdm_rates,
+						      sizeof(all_ofdm_rates),
+						      &link_sta->pub->supp_rates[i]))
+				return -EINVAL;
+		}
+	}
+
 	if (params->supported_rates &&
 	    params->supported_rates_len &&
 	    !ieee80211_parse_bitrates(sband, params->supported_rates,
@@ -2139,22 +2175,24 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		return -EINVAL;
 
 	if (params->ht_capa)
-		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, &sband->ht_cap,
+		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, own_ht_cap,
 						  params->ht_capa, link_sta);
 
 	/* VHT can override some HT caps such as the A-MSDU max length */
 	if (params->vht_capa)
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-						    &sband->vht_cap,
+						    own_vht_cap,
 						    params->vht_capa, NULL,
 						    link_sta);
 
 	if (params->he_capa)
-		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
-						  (void *)params->he_capa,
-						  params->he_capa_len,
-						  (void *)params->he_6ghz_capa,
-						  link_sta);
+		_ieee80211_he_cap_ie_to_sta_he_cap(sdata,
+						   own_he_cap,
+						   (void *)params->he_capa,
+						   params->he_capa_len,
+						   (sband && sband->band == NL80211_BAND_6GHZ) ?
+						   (void *)params->he_6ghz_capa : NULL,
+						   link_sta);
 
 	if (params->he_capa && params->eht_capa)
 		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
@@ -2332,6 +2370,29 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->airtime_weight)
 		sta->airtime_weight = params->airtime_weight;
 
+	if (params->nmi_mac) {
+		struct ieee80211_sub_if_data *nmi =
+			rcu_dereference_wiphy(local->hw.wiphy,
+					      sdata->u.nan_data.nmi);
+		struct sta_info *nmi_sta;
+
+		if (WARN_ON(!nmi))
+			return -EINVAL;
+
+		nmi_sta = sta_info_get(nmi, params->nmi_mac);
+		if (!nmi_sta)
+			return -ENOENT;
+		rcu_assign_pointer(sta->sta.nmi, &nmi_sta->sta);
+
+		/* For NAN_DATA stations, copy capabilities from the NMI station */
+		if (!nmi_sta->deflink.pub->ht_cap.ht_supported)
+			return -EINVAL;
+
+		sta->deflink.pub->ht_cap = nmi_sta->deflink.pub->ht_cap;
+		sta->deflink.pub->vht_cap = nmi_sta->deflink.pub->vht_cap;
+		sta->deflink.pub->he_cap = nmi_sta->deflink.pub->he_cap;
+	}
+
 	/* set the STA state after all sta info from usermode has been set */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) ||
 	    set & BIT(NL80211_STA_FLAG_ASSOCIATED)) {
@@ -2477,6 +2538,12 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		else
 			statype = CFG80211_STA_AP_CLIENT_UNASSOC;
 		break;
+	case NL80211_IFTYPE_NAN:
+		statype = CFG80211_STA_NAN_MGMT;
+		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		statype = CFG80211_STA_NAN_DATA;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2515,6 +2582,14 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		}
 	}
 
+	/* NAN capabilties should not change */
+	if (statype == CFG80211_STA_NAN_DATA &&
+	    sta->deflink.pub->ht_cap.ht_supported &&
+	    (params->link_sta_params.ht_capa ||
+	     params->link_sta_params.vht_capa ||
+	     params->link_sta_params.he_capa))
+		return -EINVAL;
+
 	err = sta_apply_parameters(local, sta, params);
 	if (err)
 		return err;
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 93e0342cff4f..a3e16a5bec22 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -127,6 +127,10 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	if (!he_cap_ie || !own_he_cap_ptr || !own_he_cap_ptr->has_he)
 		return;
 
+	/* NDI station are using the capabilities from the NMI station */
+	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_NAN_DATA))
+		return;
+
 	own_he_cap = *own_he_cap_ptr;
 
 	/* Make sure size is OK */
@@ -156,7 +160,8 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	he_cap->has_he = true;
 
 	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
-	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
+	if (sdata->vif.type != NL80211_IFTYPE_NAN)
+		link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	if (he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, link_sta);
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 6da2b05be9ee..a5b37a0b0b59 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -154,6 +154,10 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 	if (!ht_cap_ie || !own_cap_ptr->ht_supported)
 		goto apply;
 
+	/* NDI station are using the capabilities from the NMI station */
+	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_NAN_DATA))
+		return 0;
+
 	ht_cap.ht_supported = true;
 
 	own_cap = *own_cap_ptr;
@@ -254,10 +258,17 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 
 	rcu_read_lock();
 	link_conf = rcu_dereference(sdata->vif.link_conf[link_sta->link_id]);
-	if (WARN_ON(!link_conf))
+	if (WARN_ON(!link_conf)) {
 		width = NL80211_CHAN_WIDTH_20_NOHT;
-	else
+	} else if (sdata->vif.type == NL80211_IFTYPE_NAN ||
+		   sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+		/* In NAN, link_sta->bandwidth is invalid since NAN operates on
+		 * multiple channels. Just take the maximum.
+		 */
+		width = NL80211_CHAN_WIDTH_320;
+	} else {
 		width = link_conf->chanreq.oper.width;
+	}
 
 	switch (width) {
 	default:
@@ -285,7 +296,9 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 
 	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
-	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
+	    sta->sdata->vif.type == NL80211_IFTYPE_NAN ||
+	    sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
 		enum ieee80211_smps_mode smps_mode;
 
 		switch ((ht_cap.cap & IEEE80211_HT_CAP_SM_PS)
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f0b973952b6c..5ed5193ff6b1 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -531,12 +531,14 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	 * (because if we remove a STA after ops->remove_interface()
 	 * the driver will have removed the vif info already!)
 	 *
-	 * For AP_VLANs stations may exist since there's nothing else that
-	 * would have removed them, but in other modes there shouldn't
-	 * be any stations.
+	 * For AP_VLANs, NAN and NAN_DATA stations may exist since there's
+	 * nothing else that would have removed them, but in other modes there
+	 * shouldn't be any stations.
 	 */
 	flushed = sta_info_flush(sdata, -1);
-	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN && flushed > 0);
+	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
+		     sdata->vif.type != NL80211_IFTYPE_NAN &&
+		     sdata->vif.type != NL80211_IFTYPE_NAN_DATA && flushed > 0);
 
 	/* don't count this interface for allmulti while it is down */
 	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f9526c0a37cb..28577d03e3fb 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -783,6 +783,7 @@ struct sta_info *sta_info_alloc_with_link(struct ieee80211_sub_if_data *sdata,
 static int sta_info_insert_check(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_sta *same_addr_sta;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -798,13 +799,18 @@ static int sta_info_insert_check(struct sta_info *sta)
 		    !is_valid_ether_addr(sta->sta.addr)))
 		return -EINVAL;
 
+	if (!ieee80211_hw_check(&sdata->local->hw, NEEDS_UNIQUE_STA_ADDR))
+		return 0;
+
 	/* The RCU read lock is required by rhashtable due to
 	 * asynchronous resize/rehash.  We also require the mutex
 	 * for correctness.
 	 */
 	rcu_read_lock();
-	if (ieee80211_hw_check(&sdata->local->hw, NEEDS_UNIQUE_STA_ADDR) &&
-	    ieee80211_find_sta_by_ifaddr(&sdata->local->hw, sta->addr, NULL)) {
+	same_addr_sta = ieee80211_find_sta_by_ifaddr(&sdata->local->hw,
+						     sta->addr, NULL);
+	/* For NAN, a peer can re-use */
+	if (same_addr_sta && same_addr_sta != rcu_access_pointer(sta->sta.nmi)) {
 		rcu_read_unlock();
 		return -ENOTUNIQ;
 	}
@@ -1282,6 +1288,17 @@ static int __must_check __sta_info_destroy_part1(struct sta_info *sta)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (sdata->vif.type == NL80211_IFTYPE_NAN) {
+		struct sta_info *sta_iter, *tmp;
+
+		/* Remove all NDI stations associated with this NMI STA */
+		list_for_each_entry_safe(sta_iter, tmp, &local->sta_list, list) {
+			if (rcu_access_pointer(sta_iter->sta.nmi) != &sta->sta)
+				continue;
+			sta_info_destroy_addr(sta_iter->sdata, sta_iter->addr);
+		}
+	}
+
 	/*
 	 * Before removing the station from the driver and
 	 * rate control, it might still start new aggregation
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5288d5286651..229a62c11528 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -503,7 +503,8 @@ struct ieee80211_fragment_cache {
  * @status_stats.ack_signal_filled: last ACK signal validity
  * @status_stats.avg_ack_signal: average ACK signal
  * @cur_max_bandwidth: maximum bandwidth to use for TX to the station,
- *	taken from HT/VHT capabilities or VHT operating mode notification
+ *	taken from HT/VHT capabilities or VHT operating mode notification.
+ *	Invalid for NAN since that is operating on multiple bands.
  * @rx_omi_bw_rx: RX OMI bandwidth restriction to apply for RX
  * @rx_omi_bw_tx: RX OMI bandwidth restriction to apply for TX
  * @rx_omi_bw_staging: RX OMI bandwidth restriction to apply later
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e623fd2b2cf4..6185b5346066 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1772,6 +1772,7 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *ndi_sdata;
+	struct sta_info *sta;
 	int res;
 
 	res = drv_start_nan(local, sdata, &sdata->u.nan.conf);
@@ -1792,6 +1793,42 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 		}
 	}
 
+	/* Add NMI stations (stations on the NAN interface) */
+	list_for_each_entry(sta, &local->sta_list, list) {
+		enum ieee80211_sta_state state;
+
+		if (!sta->uploaded || sta->sdata != sdata)
+			continue;
+
+		for (state = IEEE80211_STA_NOTEXIST; state < sta->sta_state;
+		     state++) {
+			res = drv_sta_state(local, sdata, sta, state,
+					    state + 1);
+			if (WARN_ON(res))
+				return res;
+		}
+	}
+
+	/* Add NDI stations (stations on NAN_DATA interfaces) */
+	list_for_each_entry(sta, &local->sta_list, list) {
+		enum ieee80211_sta_state state;
+
+		if (!sta->uploaded ||
+		    sta->sdata->vif.type != NL80211_IFTYPE_NAN_DATA)
+			continue;
+
+		if (WARN_ON(!sta->sta.nmi))
+			continue;
+
+		for (state = IEEE80211_STA_NOTEXIST; state < sta->sta_state;
+		     state++) {
+			res = drv_sta_state(local, sta->sdata, sta, state,
+					    state + 1);
+			if (WARN_ON(res))
+				return res;
+		}
+	}
+
 	return 0;
 }
 
@@ -2050,6 +2087,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 			break;
+		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_NAN_DATA:
+			/* NAN stations are handled later */
+			break;
 		case NL80211_IFTYPE_ADHOC:
 			if (sdata->vif.cfg.ibss_joined)
 				WARN_ON(drv_join_ibss(local, sdata));
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index d4fcb1c07313..8009bb4f4aeb 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -133,6 +133,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	if (!vht_cap_ie || !own_vht_cap->vht_supported)
 		return;
 
+	/* NDI station are using the capabilities from the NMI station */
+	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_NAN_DATA))
+		return;
+
 	if (sband) {
 		/* Allow VHT if at least one channel on the sband supports 80 MHz */
 		bool have_80mhz = false;
@@ -320,7 +324,8 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				IEEE80211_STA_RX_BW_160;
 	}
 
-	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
+	if (sdata->vif.type != NL80211_IFTYPE_NAN)
+		link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	/*
 	 * Work around the Cisco 9115 FW 17.3 bug by taking the min of
@@ -373,6 +378,10 @@ __ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 		} else {
 			struct ieee80211_bss_conf *link_conf;
 
+			if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_NAN_DATA ||
+					 sdata->vif.type == NL80211_IFTYPE_NAN))
+				return IEEE80211_STA_RX_BW_20;
+
 			rcu_read_lock();
 			link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
 			band = link_conf->chanreq.oper.chan->band;
@@ -518,6 +527,11 @@ _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
 	} else {
 		struct ieee80211_bss_conf *link_conf;
 
+		/* NAN operates on multiple channels so a chandef must be given */
+		if (WARN_ON_ONCE(sta->sdata->vif.type == NL80211_IFTYPE_NAN ||
+				 sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA))
+			return IEEE80211_STA_RX_BW_20;
+
 		rcu_read_lock();
 		link_conf = rcu_dereference(sta->sdata->vif.link_conf[link_sta->link_id]);
 		if (WARN_ON_ONCE(!link_conf)) {
-- 
2.52.0


