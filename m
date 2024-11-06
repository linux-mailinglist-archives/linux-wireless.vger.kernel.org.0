Return-Path: <linux-wireless+bounces-14999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E89BF015
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 15:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46961C22404
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0420111C;
	Wed,  6 Nov 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUSnQk1c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E56202F8C
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903188; cv=none; b=AWB0xcVOzRCp8YPYxlo0cLLNyBDJF3mO7O9cMHLc4qAb4fn5lXlZnum/dbRVm6oJorPSdm50o3RnvLGZ4TbMzVSlQkkGogCNpQdTh85IUuS2KdcwYaYCUy1dUKexT216UVAOFkG/G/AD69h+0wDuWPKJbNSozzz5znnYFSG2S+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903188; c=relaxed/simple;
	bh=Es4uOi2nTKI4URq2qGVoHzwBc8jzqPlEzSRtjS7pPtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGvE6rQ9rdSf9mdudmUv35ZcaNpWRCYwyV6UrzHbIqfsjKR7GUPDJSTpoNfEk4uEqnI6/W0x1gpRFtV5iftikKNSb23BuLqeh3Xem/I6gIbsU6f1tVABeAYzJn0i1cbKuFp4zF3KG0oXNDzXwTXQHfsnAOKqXvrIuSj2pWZnDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUSnQk1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A924C4CEC6;
	Wed,  6 Nov 2024 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903188;
	bh=Es4uOi2nTKI4URq2qGVoHzwBc8jzqPlEzSRtjS7pPtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUSnQk1cYwHu04wizkMcgfFhRGWpzutQ267IwAAvKZXqixF7lGPgMPfL7jYJyN3/u
	 XyErd2NwN1NobiHlV6od22XF46UX1dSKaxsfdPlUpqBi/rHJRoWVMKum+q7Wv1L+FR
	 r5095iTEDC/Mpf46p1Pjm01itnaStzOqYnpd9GhiuqhkRaTs90KE3ZXk4L/sMgYcUU
	 zvx16Ihr43ij2jtOYl4kODXYZ8+TS4CYL2WBaicBhalG99qcXimhqg/9qsrYz2tDVy
	 ha6jNUVR5I3nIRl6Sq5whM6yKzBxAZkARojtIRlsqliH+A/Ub3PSTfkDVJtj3Tq00z
	 Ew4j4PwNHE+0Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 7/8] wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf
Date: Wed,  6 Nov 2024 16:26:16 +0200
Message-Id: <20241106142617.660901-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106142617.660901-1-kvalo@kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Currently mac80211 vif's bss_conf is used to fetch any vif related
configurations in driver but with MLO multiple links are affiliated to a vif
and corresponding link configs are present in vif->link_conf[]. Fetch
link_conf for corresponding link from vif and use the same for configurations.

Add ath12k_mac_get_link_bss_conf() helper to fetch link_conf from arvif.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 149 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.c |  16 ++-
 2 files changed, 141 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d810a5d74181..5d25543258a3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -504,6 +504,24 @@ static int ath12k_mac_vif_link_chan(struct ieee80211_vif *vif, u8 link_id,
 	return 0;
 }
 
+static struct ieee80211_bss_conf *
+ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif)
+{
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
+	struct ieee80211_bss_conf *link_conf;
+	struct ath12k *ar = arvif->ar;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (arvif->link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return NULL;
+
+	link_conf = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
+				      vif->link_conf[arvif->link_id]);
+
+	return link_conf;
+}
+
 static bool ath12k_mac_bitrate_is_cck(int bitrate)
 {
 	switch (bitrate) {
@@ -1501,7 +1519,7 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
 static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_bss_conf *bss_conf = &ahvif->vif->bss_conf;
+	struct ieee80211_bss_conf *bss_conf;
 	struct ath12k_wmi_bcn_tmpl_ema_arg ema_args;
 	struct ieee80211_ema_beacons *beacons;
 	struct ath12k_link_vif *tx_arvif;
@@ -1510,6 +1528,14 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 	int ret = 0;
 	u8 i;
 
+	bss_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!bss_conf) {
+		ath12k_warn(arvif->ar->ab,
+			    "failed to get link bss conf to update bcn tmpl for vif %pM link %u\n",
+			    ahvif->vif->addr, arvif->link_id);
+		return -ENOLINK;
+	}
+
 	tx_ahvif = ath12k_vif_to_ahvif(ahvif->vif->mbssid_tx_vif);
 	tx_arvif = &tx_ahvif->deflink;
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
@@ -1556,6 +1582,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_link_vif *tx_arvif = arvif;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
@@ -1568,13 +1595,20 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 	if (ahvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return 0;
 
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf to set bcn tmpl for vif %pM link %u\n",
+			    vif->addr, arvif->link_id);
+		return -ENOLINK;
+	}
+
 	if (vif->mbssid_tx_vif) {
 		tx_ahvif = ath12k_vif_to_ahvif(vif->mbssid_tx_vif);
 		tx_arvif = &tx_ahvif->deflink;
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
 
-		if (vif->bss_conf.ema_ap)
+		if (link_conf->ema_ap)
 			return ath12k_mac_setup_bcn_tmpl_ema(arvif);
 	}
 
@@ -1589,7 +1623,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 		ath12k_mac_set_arvif_ies(arvif, bcn, 0, NULL);
 	} else {
 		ath12k_mac_set_arvif_ies(arvif, bcn,
-					 ahvif->vif->bss_conf.bssid_index,
+					 link_conf->bssid_index,
 					 &nontx_profile_found);
 		if (!nontx_profile_found)
 			ath12k_warn(ab,
@@ -1765,6 +1799,7 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ieee80211_bss_conf *bss_conf;
 	u32 aid;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -1781,7 +1816,15 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 	/* TODO: STA WAR in ath10k for listen interval required? */
 	arg->peer_listen_intval = hw->conf.listen_interval;
 	arg->peer_nss = 1;
-	arg->peer_caps = vif->bss_conf.assoc_capability;
+
+	bss_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!bss_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in peer assoc for vif %pM link %u\n",
+			    vif->addr, arvif->link_id);
+		return;
+	}
+
+	arg->peer_caps = bss_conf->assoc_capability;
 }
 
 static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
@@ -1791,7 +1834,7 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	struct ieee80211_bss_conf *info = &vif->bss_conf;
+	struct ieee80211_bss_conf *info;
 	struct cfg80211_chan_def def;
 	struct cfg80211_bss *bss;
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
@@ -1800,6 +1843,13 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	info = ath12k_mac_get_link_bss_conf(arvif);
+	if (!info) {
+		ath12k_warn(ar->ab, "unable to access bss link conf for peer assoc crypto for vif %pM link %u\n",
+			    vif->addr, arvif->link_id);
+		return;
+	}
+
 	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
@@ -2179,6 +2229,7 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct ieee80211_bss_conf *link_conf;
 	int i;
 	u8 ampdu_factor, max_nss;
 	u8 rx_mcs_80 = IEEE80211_HE_MCS_NOT_SUPPORTED;
@@ -2187,6 +2238,13 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	bool support_160;
 	u16 v;
 
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in peer assoc he for vif %pM link %u",
+			    vif->addr, arvif->link_id);
+		return;
+	}
+
 	if (!he_cap->has_he)
 		return;
 
@@ -2230,7 +2288,7 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	       sizeof(he_cap->he_cap_elem.mac_cap_info));
 	memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
 	       sizeof(he_cap->he_cap_elem.phy_cap_info));
-	arg->peer_he_ops = vif->bss_conf.he_oper.params;
+	arg->peer_he_ops = link_conf->he_oper.params;
 
 	/* the top most byte is used to indicate BSS color info */
 	arg->peer_he_ops &= 0xffffff;
@@ -3136,6 +3194,7 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	const struct ieee80211_supported_band *sband;
+	struct ieee80211_bss_conf *bss_conf;
 	u8 basic_rate_idx;
 	int hw_rate_code;
 	u32 vdev_param;
@@ -3144,8 +3203,15 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	bss_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!bss_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in mgmt rate calc for vif %pM link %u\n",
+			    vif->addr, arvif->link_id);
+		return;
+	}
+
 	sband = hw->wiphy->bands[def->chan->band];
-	basic_rate_idx = ffs(vif->bss_conf.basic_rates) - 1;
+	basic_rate_idx = ffs(bss_conf->basic_rates) - 1;
 	bitrate = sband->bitrates[basic_rate_idx].bitrate;
 
 	hw_rate_code = ath12k_mac_get_rate_hw_value(bitrate);
@@ -3229,6 +3295,7 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	unsigned long links = ahvif->links_map;
+	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
 	struct ath12k *ar;
 	u8 link_id;
@@ -3249,10 +3316,15 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 
 			ar = arvif->ar;
 
-			if (vif->cfg.assoc)
-				ath12k_bss_assoc(ar, arvif, &vif->bss_conf);
-			else
+			if (vif->cfg.assoc) {
+				info = ath12k_mac_get_link_bss_conf(arvif);
+				if (!info)
+					continue;
+
+				ath12k_bss_assoc(ar, arvif, info);
+			} else {
 				ath12k_bss_disassoc(ar, arvif);
+			}
 		}
 	}
 }
@@ -3263,6 +3335,7 @@ static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
 	struct ieee80211_vif *vif = arvif->ahvif->vif;
 	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
 	enum wmi_sta_powersave_param param;
+	struct ieee80211_bss_conf *info;
 	enum wmi_sta_ps_mode psmode;
 	int ret;
 	int timeout;
@@ -3280,8 +3353,15 @@ static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
 
 		timeout = conf->dynamic_ps_timeout;
 		if (timeout == 0) {
+			info = ath12k_mac_get_link_bss_conf(arvif);
+			if (!info) {
+				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
+					    vif->addr, arvif->link_id);
+				return;
+			}
+
 			/* firmware doesn't like 0 */
-			timeout = ieee80211_tu_to_usec(vif->bss_conf.beacon_int) / 1000;
+			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
 		}
 
 		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
@@ -3392,8 +3472,8 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		ath12k_control_beaconing(arvif, info);
 
-		if (arvif->is_up && vif->bss_conf.he_support &&
-		    vif->bss_conf.he_oper.params) {
+		if (arvif->is_up && info->he_support &&
+		    info->he_oper.params) {
 			/* TODO: Extend to support 1024 BA Bitmap size */
 			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 							    WMI_VDEV_PARAM_BA_MODE,
@@ -3404,7 +3484,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 					    arvif->vdev_id);
 
 			param_id = WMI_VDEV_PARAM_HEOPS_0_31;
-			param_value = vif->bss_conf.he_oper.params;
+			param_value = info->he_oper.params;
 			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 							    param_id, param_value);
 			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
@@ -3496,12 +3576,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	if (changed & BSS_CHANGED_MCAST_RATE &&
 	    !ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)) {
 		band = def.chan->band;
-		mcast_rate = vif->bss_conf.mcast_rate[band];
+		mcast_rate = info->mcast_rate[band];
 
 		if (mcast_rate > 0)
 			rateidx = mcast_rate - 1;
 		else
-			rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+			rateidx = ffs(info->basic_rates) - 1;
 
 		if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP)
 			rateidx += ATH12K_MAC_FIRST_OFDM_RATE_IDX;
@@ -4281,6 +4361,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_sta *sta = NULL;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
@@ -4297,12 +4378,19 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
 
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ab, "unable to access bss link conf in set key for vif %pM link %u\n",
+			    vif->addr, arvif->link_id);
+		return -ENOLINK;
+	}
+
 	if (sta)
 		peer_addr = arsta->addr;
 	else if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
-		peer_addr = vif->bss_conf.bssid;
+		peer_addr = link_conf->bssid;
 	else
-		peer_addr = vif->addr;
+		peer_addr = link_conf->addr;
 
 	key->hw_key_idx = key->keyidx;
 
@@ -7104,6 +7192,7 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *tx_vif = ahvif->vif->mbssid_tx_vif;
+	struct ieee80211_bss_conf *link_conf;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_link_vif *tx_arvif;
 	struct ath12k_vif *tx_ahvif;
@@ -7111,10 +7200,17 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 	if (!tx_vif)
 		return 0;
 
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in set mbssid params for vif %pM link %u\n",
+			    ahvif->vif->addr, arvif->link_id);
+		return -ENOLINK;
+	}
+
 	tx_ahvif = ath12k_vif_to_ahvif(tx_vif);
 	tx_arvif = &tx_ahvif->deflink;
 
-	if (ahvif->vif->bss_conf.nontransmitted) {
+	if (link_conf->nontransmitted) {
 		if (ar->ah->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
 			return -EINVAL;
 
@@ -7126,7 +7222,7 @@ static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_link_vif *arvif,
 		return -EINVAL;
 	}
 
-	if (ahvif->vif->bss_conf.ema_ap)
+	if (link_conf->ema_ap)
 		*flags |= WMI_VDEV_MBSSID_FLAGS_EMA_MODE;
 
 	return 0;
@@ -7494,7 +7590,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		break;
 	}
 
-	arvif->txpower = vif->bss_conf.txpower;
+	arvif->txpower = link_conf->txpower;
 	ret = ath12k_mac_txpower_recalc(ar);
 	if (ret)
 		goto err_peer_del;
@@ -8183,11 +8279,18 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 	struct wmi_vdev_start_req_arg arg = {};
 	const struct cfg80211_chan_def *chandef = &ctx->def;
 	struct ath12k_vif *ahvif = arvif->ahvif;
-	int he_support = ahvif->vif->bss_conf.he_support;
+	struct ieee80211_bss_conf *link_conf;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in vdev start for vif %pM link %u\n",
+			    ahvif->vif->addr, arvif->link_id);
+		return -ENOLINK;
+	}
+
 	reinit_completion(&ar->vdev_setup_done);
 
 	arg.vdev_id = arvif->vdev_id;
@@ -8239,7 +8342,7 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 		spin_unlock_bh(&ab->base_lock);
 
 		/* TODO: Notify if secondary 80Mhz also needs radar detection */
-		if (he_support) {
+		if (link_conf->he_support) {
 			ret = ath12k_set_he_mu_sounding_mode(ar, arvif);
 			if (ret) {
 				ath12k_warn(ar->ab, "failed to set he mode vdev %i\n",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 50ed7e72f178..402ae477da61 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6854,6 +6854,7 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 					  const u32 *vdev_ids)
 {
 	int i;
+	struct ieee80211_bss_conf *conf;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_vif *ahvif;
 
@@ -6872,7 +6873,20 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 		}
 		ahvif = arvif->ahvif;
 
-		if (arvif->is_up && ahvif->vif->bss_conf.csa_active)
+		if (arvif->link_id > IEEE80211_MLD_MAX_NUM_LINKS) {
+			ath12k_warn(ab, "Invalid CSA switch count even link id: %d\n",
+				    arvif->link_id);
+			continue;
+		}
+
+		conf = rcu_dereference(ahvif->vif->link_conf[arvif->link_id]);
+		if (!conf) {
+			ath12k_warn(ab, "unable to access bss link conf in process csa for vif %pM link %u\n",
+				    ahvif->vif->addr, arvif->link_id);
+			continue;
+		}
+
+		if (arvif->is_up && conf->csa_active)
 			ieee80211_csa_finish(ahvif->vif, 0);
 	}
 	rcu_read_unlock();
-- 
2.39.5


