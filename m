Return-Path: <linux-wireless+bounces-15561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E169D5040
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF1E1F23251
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7C1A0BF1;
	Thu, 21 Nov 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baD9WWv6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FE1A0BD7
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204697; cv=none; b=mICZbVKTOjRGkIhGRNqARx2I/LgmMVO8xPUJ3XEBWbMcajqxiMKAepoU+XwuYADNxxyjvTyoJFZ8OcZrOEk5q2M7av96XLvvS/3eUDmRlRt5h1HXkn/BUnjgwWdjBUV/MtNdpaoTB3/Lmh5nkglL9Hh9T3m7LT1/ZO4rw6eTgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204697; c=relaxed/simple;
	bh=7Ql0xvDm5a92kHRwPT5YsirPmnuClmjg7fHf2IquaWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYbfRirldgzToc3jwZwenXWLcdt4D6RApIS2YqK8722UHWvzgidlHmalsHvvxqTY1zxdeoWrHS3FvXpXDbo8WQhEYUBbcwPLQzsPl1D4QUEFgxbGzlV4qP6yOxyimyMIs4VZQEDX9z7pcuZgxJG6jC2dmrr/E2Dgl2dP7ZAOACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baD9WWv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1B1C4CECD;
	Thu, 21 Nov 2024 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732204696;
	bh=7Ql0xvDm5a92kHRwPT5YsirPmnuClmjg7fHf2IquaWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baD9WWv6Mzz1IJfw5PTY4z7NPosB6tsUtrgofw7QWvzGDiFCgJt1hc3SoTjdwu26G
	 mQY3GOiB0rBuQtfNgI5RvvUjK96NTaPXBJdnKrlr+jgCu+AWVDr/V0VbamyOXRNzvF
	 mzhR4JwM6QyWk/a7NEqaix+sZsbts3hlh7yqjuXA/tDCQ7TReo9uR0GQOsX8AZyAFT
	 vtJP3cTPKV5pdYkIoj/QXI7nGvFVdwl3A0HnDlPnlqYz8eVvziWja7kTS91B9bOmHt
	 5Pw+SJIi1LVh+SetQzTkg27DT8ttgexnUPrgN2lfmXKuWxFkCsIoATNj4WTFh1BTT7
	 UWJ62ObmUUKBw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 8/8] wifi: ath12k: Use mac80211 sta's link_sta instead of deflink
Date: Thu, 21 Nov 2024 17:58:06 +0200
Message-Id: <20241121155806.1862733-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121155806.1862733-1-kvalo@kernel.org>
References: <20241121155806.1862733-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Currently mac80211's struct ieee80211_sta deflink is used to fetch any sta
related configurations in driver. With MLO multiple link sta's (struct
ieee80211_link_sta) are affiliated to an ML sta and corresponding link configs
are present in sta->link[]. Fetch link sta of corresponding link from ML sta
and use the same for configurations.

Add ath12k_get_link_sta() helper to fetch ieee80211_link_sta from arsta. But as
ath12k_mac_op_sta_rc_update() is called in atomic context the helper cannot be
used and instead rcu_dereference() has to be called directly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 292 ++++++++++++++++++--------
 1 file changed, 209 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 827a1700e8ba..60702bf07141 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -519,6 +519,23 @@ ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif)
 	return link_conf;
 }
 
+static struct ieee80211_link_sta *ath12k_mac_get_link_sta(struct ath12k_link_sta *arsta)
+{
+	struct ath12k_sta *ahsta = arsta->ahsta;
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
+	struct ieee80211_link_sta *link_sta;
+
+	lockdep_assert_wiphy(ahsta->ahvif->ah->hw->wiphy);
+
+	if (arsta->link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return NULL;
+
+	link_sta = wiphy_dereference(ahsta->ahvif->ah->hw->wiphy,
+				     sta->link[arsta->link_id]);
+
+	return link_sta;
+}
+
 static bool ath12k_mac_bitrate_is_cck(int bitrate)
 {
 	switch (bitrate) {
@@ -1902,6 +1919,7 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
+	struct ieee80211_link_sta *link_sta;
 	struct cfg80211_chan_def def;
 	const struct ieee80211_supported_band *sband;
 	const struct ieee80211_rate *rates;
@@ -1916,9 +1934,16 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc rates for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
 	band = def.chan->band;
 	sband = hw->wiphy->bands[band];
-	ratemask = sta->deflink.supp_rates[band];
+	ratemask = link_sta->supp_rates[band];
 	ratemask &= arvif->bitrate_mask.control[band].legacy;
 	rates = sband->bitrates;
 
@@ -1965,7 +1990,8 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
+	const struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_link_sta *link_sta;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -1978,6 +2004,14 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc ht for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
+	ht_cap = &link_sta->ht_cap;
 	if (!ht_cap->ht_supported)
 		return;
 
@@ -2001,7 +2035,7 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 	if (ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING)
 		arg->ldpc_flag = true;
 
-	if (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40) {
+	if (link_sta->bandwidth >= IEEE80211_STA_RX_BW_40) {
 		arg->bw_40 = true;
 		arg->peer_rate_caps |= WMI_HOST_RC_CW40_FLAG;
 	}
@@ -2051,7 +2085,7 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 			arg->peer_ht_rates.rates[i] = i;
 	} else {
 		arg->peer_ht_rates.num_rates = n;
-		arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
+		arg->peer_nss = min(link_sta->rx_nss, max_nss);
 	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac ht peer %pM mcs cnt %d nss %d\n",
@@ -2127,7 +2161,8 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap;
+	struct ieee80211_link_sta *link_sta;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u16 *vht_mcs_mask;
@@ -2141,6 +2176,14 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc vht for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
+	vht_cap = &link_sta->vht_cap;
 	if (!vht_cap->vht_supported)
 		return;
 
@@ -2173,10 +2216,10 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 				 (1U << (IEEE80211_HT_MAX_AMPDU_FACTOR +
 					ampdu_factor)) - 1);
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
 		arg->bw_80 = true;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160)
 		arg->bw_160 = true;
 
 	/* Calculate peer NSS capability from VHT capabilities if STA
@@ -2190,7 +2233,7 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 		    vht_mcs_mask[i])
 			max_nss = i + 1;
 	}
-	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
+	arg->peer_nss = min(link_sta->rx_nss, max_nss);
 	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
 	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
 	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
@@ -2225,8 +2268,9 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_sta *link_sta;
 	int i;
 	u8 ampdu_factor, max_nss;
 	u8 rx_mcs_80 = IEEE80211_HE_MCS_NOT_SUPPORTED;
@@ -2242,6 +2286,14 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 		return;
 	}
 
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc he for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
+	he_cap = &link_sta->he_cap;
 	if (!he_cap->has_he)
 		return;
 
@@ -2279,7 +2331,7 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	else
 		max_nss = rx_mcs_80;
 
-	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
+	arg->peer_nss = min(link_sta->rx_nss, max_nss);
 
 	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
 	       sizeof(he_cap->he_cap_elem.mac_cap_info));
@@ -2306,10 +2358,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 				   IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
 
 	if (ampdu_factor) {
-		if (sta->deflink.vht_cap.vht_supported)
+		if (link_sta->vht_cap.vht_supported)
 			arg->peer_max_mpdu = (1 << (IEEE80211_HE_VHT_MAX_AMPDU_FACTOR +
 						    ampdu_factor)) - 1;
-		else if (sta->deflink.ht_cap.ht_supported)
+		else if (link_sta->ht_cap.ht_supported)
 			arg->peer_max_mpdu = (1 << (IEEE80211_HE_HT_MAX_AMPDU_FACTOR +
 						    ampdu_factor)) - 1;
 	}
@@ -2350,7 +2402,7 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_REQ)
 		arg->twt_requester = true;
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		if (he_cap->he_cap_elem.phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
@@ -2390,7 +2442,8 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_link_sta *link_sta;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	u8 ampdu_factor, mpdu_density;
@@ -2400,22 +2453,31 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
 
 	band = def.chan->band;
 
-	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !sta->deflink.he_6ghz_capa.capa)
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc he 6ghz for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
+	he_cap = &link_sta->he_cap;
+
+	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !link_sta->he_6ghz_capa.capa)
 		return;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 		arg->bw_40 = true;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
 		arg->bw_80 = true;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160)
 		arg->bw_160 = true;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_320)
 		arg->bw_320 = true;
 
-	arg->peer_he_caps_6ghz = le16_to_cpu(sta->deflink.he_6ghz_capa.capa);
+	arg->peer_he_caps_6ghz = le16_to_cpu(link_sta->he_6ghz_capa.capa);
 
 	mpdu_density = u32_get_bits(arg->peer_he_caps_6ghz,
 				    IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
@@ -2459,10 +2521,23 @@ static void ath12k_peer_assoc_h_smps(struct ath12k_link_sta *arsta,
 				     struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	const struct ieee80211_he_6ghz_capa *he_6ghz_capa = &sta->deflink.he_6ghz_capa;
-	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
+	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
+	struct ath12k_link_vif *arvif = arsta->arvif;
+	const struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_link_sta *link_sta;
+	struct ath12k *ar = arvif->ar;
 	int smps;
 
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc he for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
+	he_6ghz_capa = &link_sta->he_6ghz_capa;
+	ht_cap = &link_sta->ht_cap;
+
 	if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
 		return;
 
@@ -2588,17 +2663,17 @@ static int ath12k_peer_assoc_qos_ap(struct ath12k *ar,
 	return ret;
 }
 
-static bool ath12k_mac_sta_has_ofdm_only(struct ieee80211_sta *sta)
+static bool ath12k_mac_sta_has_ofdm_only(struct ieee80211_link_sta *sta)
 {
-	return sta->deflink.supp_rates[NL80211_BAND_2GHZ] >>
+	return sta->supp_rates[NL80211_BAND_2GHZ] >>
 	       ATH12K_MAC_FIRST_OFDM_RATE_IDX;
 }
 
 static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
-						    struct ieee80211_sta *sta)
+						    struct ieee80211_link_sta *link_sta)
 {
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160) {
-		switch (sta->deflink.vht_cap.cap &
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
+		switch (link_sta->vht_cap.cap &
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
 			return MODE_11AC_VHT160;
@@ -2610,74 +2685,74 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
 		}
 	}
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
 		return MODE_11AC_VHT80;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 		return MODE_11AC_VHT40;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
 		return MODE_11AC_VHT20;
 
 	return MODE_UNKNOWN;
 }
 
 static enum wmi_phy_mode ath12k_mac_get_phymode_he(struct ath12k *ar,
-						   struct ieee80211_sta *sta)
+						   struct ieee80211_link_sta *link_sta)
 {
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160) {
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
+		if (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 			return MODE_11AX_HE160;
-		else if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+		else if (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
 			return MODE_11AX_HE80_80;
 		/* not sure if this is a valid case? */
 		return MODE_11AX_HE160;
 	}
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
 		return MODE_11AX_HE80;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 		return MODE_11AX_HE40;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
 		return MODE_11AX_HE20;
 
 	return MODE_UNKNOWN;
 }
 
 static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
-						    struct ieee80211_sta *sta)
+						    struct ieee80211_link_sta *link_sta)
 {
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
-		if (sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[0] &
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_320)
+		if (link_sta->eht_cap.eht_cap_elem.phy_cap_info[0] &
 		    IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
 			return MODE_11BE_EHT320;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160) {
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
+		if (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 			return MODE_11BE_EHT160;
 
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+		if (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 			 IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
 			return MODE_11BE_EHT80_80;
 
 		ath12k_warn(ar->ab, "invalid EHT PHY capability info for 160 Mhz: %d\n",
-			    sta->deflink.he_cap.he_cap_elem.phy_cap_info[0]);
+			    link_sta->he_cap.he_cap_elem.phy_cap_info[0]);
 
 		return MODE_11BE_EHT160;
 	}
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
 		return MODE_11BE_EHT80;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 		return MODE_11BE_EHT40;
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
 		return MODE_11BE_EHT20;
 
 	return MODE_UNKNOWN;
@@ -2688,6 +2763,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 					struct ath12k_link_sta *arsta,
 					struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ieee80211_link_sta *link_sta;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
@@ -2706,33 +2782,40 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
 
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc he for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
 	switch (band) {
 	case NL80211_BAND_2GHZ:
-		if (sta->deflink.eht_cap.has_eht) {
-			if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+		if (link_sta->eht_cap.has_eht) {
+			if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11BE_EHT40_2G;
 			else
 				phymode = MODE_11BE_EHT20_2G;
-		} else if (sta->deflink.he_cap.has_he) {
-			if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
+		} else if (link_sta->he_cap.has_he) {
+			if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
 				phymode = MODE_11AX_HE80_2G;
-			else if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+			else if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11AX_HE40_2G;
 			else
 				phymode = MODE_11AX_HE20_2G;
-		} else if (sta->deflink.vht_cap.vht_supported &&
+		} else if (link_sta->vht_cap.vht_supported &&
 		    !ath12k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
-			if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+			if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11AC_VHT40;
 			else
 				phymode = MODE_11AC_VHT20;
-		} else if (sta->deflink.ht_cap.ht_supported &&
+		} else if (link_sta->ht_cap.ht_supported &&
 			   !ath12k_peer_assoc_h_ht_masked(ht_mcs_mask)) {
-			if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
+			if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11NG_HT40;
 			else
 				phymode = MODE_11NG_HT20;
-		} else if (ath12k_mac_sta_has_ofdm_only(sta)) {
+		} else if (ath12k_mac_sta_has_ofdm_only(link_sta)) {
 			phymode = MODE_11G;
 		} else {
 			phymode = MODE_11B;
@@ -2741,16 +2824,16 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	case NL80211_BAND_5GHZ:
 	case NL80211_BAND_6GHZ:
 		/* Check EHT first */
-		if (sta->deflink.eht_cap.has_eht) {
-			phymode = ath12k_mac_get_phymode_eht(ar, sta);
-		} else if (sta->deflink.he_cap.has_he) {
-			phymode = ath12k_mac_get_phymode_he(ar, sta);
-		} else if (sta->deflink.vht_cap.vht_supported &&
+		if (link_sta->eht_cap.has_eht) {
+			phymode = ath12k_mac_get_phymode_eht(ar, link_sta);
+		} else if (link_sta->he_cap.has_he) {
+			phymode = ath12k_mac_get_phymode_he(ar, link_sta);
+		} else if (link_sta->vht_cap.vht_supported &&
 		    !ath12k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
-			phymode = ath12k_mac_get_phymode_vht(ar, sta);
-		} else if (sta->deflink.ht_cap.ht_supported &&
+			phymode = ath12k_mac_get_phymode_vht(ar, link_sta);
+		} else if (link_sta->ht_cap.ht_supported &&
 			   !ath12k_peer_assoc_h_ht_masked(ht_mcs_mask)) {
-			if (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40)
+			if (link_sta->bandwidth >= IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11NA_HT40;
 			else
 				phymode = MODE_11NA_HT20;
@@ -2838,15 +2921,25 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	const struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
-	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20;
 	const struct ieee80211_eht_mcs_nss_supp_bw *bw;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_link_sta *link_sta;
 	u32 *rx_mcs, *tx_mcs;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	if (!sta->deflink.he_cap.has_he || !eht_cap->has_eht)
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in peer assoc eht for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
+	eht_cap = &link_sta->eht_cap;
+	he_cap = &link_sta->he_cap;
+	if (!he_cap->has_he || !eht_cap->has_eht)
 		return;
 
 	arg->eht_flag = true;
@@ -2865,7 +2958,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	rx_mcs = arg->peer_eht_rx_mcs_set;
 	tx_mcs = arg->peer_eht_tx_mcs_set;
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_320:
 		bw = &eht_cap->eht_mcs_nss_supp.bw._320;
 		ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
@@ -4662,6 +4755,7 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
+	struct ieee80211_link_sta *link_sta;
 	int ret;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
@@ -4707,7 +4801,13 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	 * fixed param.
 	 * Note that all other rates and NSS will be disabled for this peer.
 	 */
-	if (sta->deflink.vht_cap.vht_supported && num_vht_rates == 1) {
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (!link_sta) {
+		ath12k_warn(ar->ab, "unable to access link sta in station assoc\n");
+		return -EINVAL;
+	}
+
+	if (link_sta->vht_cap.vht_supported && num_vht_rates == 1) {
 		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask,
 							 band);
 		if (ret)
@@ -4721,8 +4821,7 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 		return 0;
 
 	ret = ath12k_setup_peer_smps(ar, arvif, arsta->addr,
-				     &sta->deflink.ht_cap,
-				     &sta->deflink.he_6ghz_capa);
+				     &link_sta->ht_cap, &link_sta->he_6ghz_capa);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -4766,6 +4865,7 @@ static int ath12k_mac_station_disassoc(struct ath12k *ar,
 
 static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 {
+	struct ieee80211_link_sta *link_sta;
 	struct ath12k *ar;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -4900,7 +5000,14 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 		 * TODO: Check RATEMASK_CMDID to support auto rates selection
 		 * across HT/VHT and for multiple VHT MCS support.
 		 */
-		if (sta->deflink.vht_cap.vht_supported && num_vht_rates == 1) {
+		link_sta = ath12k_mac_get_link_sta(arsta);
+		if (!link_sta) {
+			ath12k_warn(ar->ab, "unable to access link sta in peer assoc he for sta %pM link %u\n",
+				    sta->addr, arsta->link_id);
+			return;
+		}
+
+		if (link_sta->vht_cap.vht_supported && num_vht_rates == 1) {
 			ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask,
 							   band);
 		} else {
@@ -5603,10 +5710,23 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 
 	spin_unlock_bh(&ar->ab->base_lock);
 
+	if (arsta->link_id >= IEEE80211_MLD_MAX_NUM_LINKS) {
+		rcu_read_unlock();
+		return;
+	}
+
+	link_sta = rcu_dereference(sta->link[arsta->link_id]);
+	if (!link_sta) {
+		rcu_read_unlock();
+		ath12k_warn(ar->ab, "unable to access link sta in rc update for sta %pM link %u\n",
+			    sta->addr, arsta->link_id);
+		return;
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "mac sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
-		   arsta->addr, changed, sta->deflink.bandwidth, sta->deflink.rx_nss,
-		   sta->deflink.smps_mode);
+		   arsta->addr, changed, link_sta->bandwidth, link_sta->rx_nss,
+		   link_sta->smps_mode);
 
 	spin_lock_bh(&ar->data_lock);
 
@@ -5617,12 +5737,12 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	}
 
 	if (changed & IEEE80211_RC_NSS_CHANGED)
-		arsta->nss = sta->deflink.rx_nss;
+		arsta->nss = link_sta->rx_nss;
 
 	if (changed & IEEE80211_RC_SMPS_CHANGED) {
 		smps = WMI_PEER_SMPS_PS_NONE;
 
-		switch (sta->deflink.smps_mode) {
+		switch (link_sta->smps_mode) {
 		case IEEE80211_SMPS_AUTOMATIC:
 		case IEEE80211_SMPS_OFF:
 			smps = WMI_PEER_SMPS_PS_NONE;
@@ -5634,8 +5754,8 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 			smps = WMI_PEER_SMPS_DYNAMIC;
 			break;
 		default:
-			ath12k_warn(ar->ab, "Invalid smps %d in sta rc update for %pM\n",
-				    sta->deflink.smps_mode, arsta->addr);
+			ath12k_warn(ar->ab, "Invalid smps %d in sta rc update for %pM link %u\n",
+				    link_sta->smps_mode, arsta->addr, link_sta->link_id);
 			smps = WMI_PEER_SMPS_PS_NONE;
 			break;
 		}
@@ -9241,10 +9361,11 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 {
 	struct ath12k_link_vif *arvif = data;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
-	struct ath12k_link_sta *arsta = &ahsta->deflink;
+	struct ath12k_link_sta *arsta;
 	struct ath12k *ar = arvif->ar;
 
-	if (arsta->arvif != arvif)
+	arsta = rcu_dereference(ahsta->link[arvif->link_id]);
+	if (!arsta || arsta->arvif != arvif)
 		return;
 
 	spin_lock_bh(&ar->data_lock);
@@ -9259,11 +9380,16 @@ static void ath12k_mac_disable_peer_fixed_rate(void *data,
 {
 	struct ath12k_link_vif *arvif = data;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
-	struct ath12k_link_sta *arsta = &ahsta->deflink;
+	struct ath12k_link_sta *arsta;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
-	if (arsta->arvif != arvif)
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
+				  ahsta->link[arvif->link_id]);
+
+	if (!arsta || arsta->arvif != arvif)
 		return;
 
 	ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
-- 
2.39.5


