Return-Path: <linux-wireless+bounces-14996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51A9BF012
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 15:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7AF6B24D25
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A772022FA;
	Wed,  6 Nov 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7vfYvuY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14756202639
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903185; cv=none; b=tZvjxGNAWtWUtfx08/Ujl2/2QD4fBFt+Z3/AQT4hh1E/ULWAekVoOqoQQ6wdnCizbB40aXjAFfcbPQfUX35Fnvc1mdyCodQypoXyzS0XNfToVVp/94yLklddEtwp3Yf9jybyaEEzPxH16m5bQWZWaQ59BMkn8H4Hv2gyngO8n20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903185; c=relaxed/simple;
	bh=VACgx+G/bp1jOBCuoOkHFXBpPQlq6QlnppHJFdZKiIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7gkDff9/h0wMFORoSKjI378Me9oDUD9kRmXCX483c5hjFDY7QJOJoO+hhcqYFD2WLByzsDcI5cZ8gNvf0W+739dGBvxga184mc3LZDZSFhqmnSVuaSJbmWvaDuC45Mpvmg6Yn7eqkKADfxc4KzD6Ndf27qqBkkfSgjNd2/dXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7vfYvuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F4AC4CECD;
	Wed,  6 Nov 2024 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903184;
	bh=VACgx+G/bp1jOBCuoOkHFXBpPQlq6QlnppHJFdZKiIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7vfYvuYtDWq/a1w1lDEFLlNqXOMiE89hx6k3XoeM2fsW6zNxtHi7x7iGRmxkSkOa
	 tLfBtuhlhIj0r323cvzyvmAFP4ToGjAaC0Z/V3aJlq3A+ojsetUKuw5NpWQNNnhMEQ
	 m1TGLXP7SyccYCaVi3v+3AD2QKpPSOiba1MKDLkLvpW1b1xuaREy2PpH7QsdtWtP0f
	 SICQztsj+O4FsVTCum6Gqau0e6b1FuHA1UveHkVeq12j78aB1ELNrHuXQJOsbarqG2
	 6LeJEWGDrBxfqnxsDTXe6K8x+Sj6WQ8lvpWtzJ+BO70b7qrfUslsG7WO35EOisc/Ke
	 3oRfp+FEb+SOw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] wifi: ath12k: use arsta instead of sta
Date: Wed,  6 Nov 2024 16:26:13 +0200
Message-Id: <20241106142617.660901-5-kvalo@kernel.org>
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

Currently, struct ieee80211_sta (sta) is used for many WMI and mac80211 ops but
for multi link station, driver should use struct ath12k_link_sta (arsta)
instead of sta. Add changes to use arsta object for WMI commands and other
mac80211 ops.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 144 ++++++++++++++------------
 1 file changed, 77 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c0cc4e51a4d1..e45fe7949257 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1774,7 +1774,7 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 	else
 		aid = sta->aid;
 
-	ether_addr_copy(arg->peer_mac, sta->addr);
+	ether_addr_copy(arg->peer_mac, arsta->addr);
 	arg->vdev_id = arvif->vdev_id;
 	arg->peer_associd = aid;
 	arg->auth_flag = true;
@@ -2166,7 +2166,7 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	arg->tx_max_mcs_nss = 0xFF;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vht peer %pM max_mpdu %d flags 0x%x\n",
-		   sta->addr, arg->peer_max_mpdu, arg->peer_flags);
+		   arsta->addr, arg->peer_max_mpdu, arg->peer_flags);
 
 	/* TODO: rxnss_override */
 }
@@ -2462,7 +2462,7 @@ static void ath12k_peer_assoc_h_qos(struct ath12k *ar,
 	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac peer %pM qos %d\n",
-		   sta->addr, arg->qos_flag);
+		   arsta->addr, arg->qos_flag);
 }
 
 static int ath12k_peer_assoc_qos_ap(struct ath12k *ar,
@@ -2502,26 +2502,26 @@ static int ath12k_peer_assoc_qos_ap(struct ath12k *ar,
 
 	arg.param = WMI_AP_PS_PEER_PARAM_UAPSD;
 	arg.value = uapsd;
-	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, sta->addr, &arg);
+	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, arsta->addr, &arg);
 	if (ret)
 		goto err;
 
 	arg.param = WMI_AP_PS_PEER_PARAM_MAX_SP;
 	arg.value = max_sp;
-	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, sta->addr, &arg);
+	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, arsta->addr, &arg);
 	if (ret)
 		goto err;
 
 	/* TODO: revisit during testing */
 	arg.param = WMI_AP_PS_PEER_PARAM_SIFS_RESP_FRMTYPE;
 	arg.value = DISABLE_SIFS_RESPONSE_TRIGGER;
-	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, sta->addr, &arg);
+	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, arsta->addr, &arg);
 	if (ret)
 		goto err;
 
 	arg.param = WMI_AP_PS_PEER_PARAM_SIFS_RESP_UAPSD;
 	arg.value = DISABLE_SIFS_RESPONSE_TRIGGER;
-	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, sta->addr, &arg);
+	ret = ath12k_wmi_send_set_ap_ps_param_cmd(ar, arsta->addr, &arg);
 	if (ret)
 		goto err;
 
@@ -2708,7 +2708,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac peer %pM phymode %s\n",
-		   sta->addr, ath12k_mac_phymode_str(phymode));
+		   arsta->addr, ath12k_mac_phymode_str(phymode));
 
 	arg->peer_phymode = phymode;
 	WARN_ON(phymode == MODE_UNKNOWN);
@@ -4298,7 +4298,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		return 1;
 
 	if (sta)
-		peer_addr = sta->addr;
+		peer_addr = arsta->addr;
 	else if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
 		peer_addr = vif->bss_conf.bssid;
 	else
@@ -4529,7 +4529,6 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 				   const struct cfg80211_bitrate_mask *mask,
 				   enum nl80211_band band)
 {
-	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ath12k *ar = arvif->ar;
 	u8 vht_rate, nss;
 	u32 rate_code;
@@ -4548,24 +4547,24 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 
 	if (!nss) {
 		ath12k_warn(ar->ab, "No single VHT Fixed rate found to set for %pM",
-			    sta->addr);
+			    arsta->addr);
 		return -EINVAL;
 	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "Setting Fixed VHT Rate for peer %pM. Device will not switch to any other selected rates",
-		   sta->addr);
+		   arsta->addr);
 
 	rate_code = ATH12K_HW_RATE_CODE(vht_rate, nss - 1,
 					WMI_RATE_PREAMBLE_VHT);
-	ret = ath12k_wmi_set_peer_param(ar, sta->addr,
+	ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
 					arvif->vdev_id,
 					WMI_PEER_PARAM_FIXED_RATE,
 					rate_code);
 	if (ret)
 		ath12k_warn(ar->ab,
 			    "failed to update STA %pM Fixed Rate %d: %d\n",
-			     sta->addr, rate_code, ret);
+			     arsta->addr, rate_code, ret);
 
 	return ret;
 }
@@ -4583,12 +4582,16 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	enum nl80211_band band;
 	struct cfg80211_bitrate_mask *mask;
 	u8 num_vht_rates;
+	u8 link_id = arvif->link_id;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return -EPERM;
 
+	if (WARN_ON(!rcu_access_pointer(sta->link[link_id])))
+		return -EINVAL;
+
 	band = def.chan->band;
 	mask = &arvif->bitrate_mask;
 
@@ -4602,13 +4605,13 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-			    sta->addr, arvif->vdev_id, ret);
+			    arsta->addr, arvif->vdev_id, ret);
 		return ret;
 	}
 
 	if (!wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ)) {
 		ath12k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
-			    sta->addr, arvif->vdev_id);
+			    arsta->addr, arvif->vdev_id);
 		return -ETIMEDOUT;
 	}
 
@@ -4632,7 +4635,7 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	if (reassoc)
 		return 0;
 
-	ret = ath12k_setup_peer_smps(ar, arvif, sta->addr,
+	ret = ath12k_setup_peer_smps(ar, arvif, arsta->addr,
 				     &sta->deflink.ht_cap,
 				     &sta->deflink.he_6ghz_capa);
 	if (ret) {
@@ -4652,7 +4655,7 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 		ret = ath12k_peer_assoc_qos_ap(ar, arvif, arsta);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to set qos params for STA %pM for vdev %i: %d\n",
-				    sta->addr, arvif->vdev_id, ret);
+				    arsta->addr, arvif->vdev_id, ret);
 			return ret;
 		}
 	}
@@ -4735,65 +4738,65 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			 * WMI_PEER_CHWIDTH
 			 */
 			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac bandwidth upgrade for sta %pM new %d old %d\n",
-				   sta->addr, bw, bw_prev);
-			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+				   arsta->addr, bw, bw_prev);
+			err = ath12k_wmi_set_peer_param(ar, arsta->addr,
 							arvif->vdev_id, WMI_PEER_PHYMODE,
 							peer_phymode);
 			if (err) {
 				ath12k_warn(ar->ab, "failed to update STA %pM to peer phymode %d: %d\n",
-					    sta->addr, peer_phymode, err);
+					    arsta->addr, peer_phymode, err);
 				return;
 			}
-			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+			err = ath12k_wmi_set_peer_param(ar, arsta->addr,
 							arvif->vdev_id, WMI_PEER_CHWIDTH,
 							bw);
 			if (err)
 				ath12k_warn(ar->ab, "failed to update STA %pM to peer bandwidth %d: %d\n",
-					    sta->addr, bw, err);
+					    arsta->addr, bw, err);
 		} else {
 			/* When we downgrade bandwidth this will conflict with phymode
 			 * and cause to trigger firmware crash. In this case we send
 			 * WMI_PEER_CHWIDTH followed by WMI_PEER_PHYMODE
 			 */
 			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac bandwidth downgrade for sta %pM new %d old %d\n",
-				   sta->addr, bw, bw_prev);
-			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+				   arsta->addr, bw, bw_prev);
+			err = ath12k_wmi_set_peer_param(ar, arsta->addr,
 							arvif->vdev_id, WMI_PEER_CHWIDTH,
 							bw);
 			if (err) {
 				ath12k_warn(ar->ab, "failed to update STA %pM peer to bandwidth %d: %d\n",
-					    sta->addr, bw, err);
+					    arsta->addr, bw, err);
 				return;
 			}
-			err = ath12k_wmi_set_peer_param(ar, sta->addr,
+			err = ath12k_wmi_set_peer_param(ar, arsta->addr,
 							arvif->vdev_id, WMI_PEER_PHYMODE,
 							peer_phymode);
 			if (err)
 				ath12k_warn(ar->ab, "failed to update STA %pM to peer phymode %d: %d\n",
-					    sta->addr, peer_phymode, err);
+					    arsta->addr, peer_phymode, err);
 		}
 	}
 
 	if (changed & IEEE80211_RC_NSS_CHANGED) {
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac update sta %pM nss %d\n",
-			   sta->addr, nss);
+			   arsta->addr, nss);
 
-		err = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+		err = ath12k_wmi_set_peer_param(ar, arsta->addr, arvif->vdev_id,
 						WMI_PEER_NSS, nss);
 		if (err)
 			ath12k_warn(ar->ab, "failed to update STA %pM nss %d: %d\n",
-				    sta->addr, nss, err);
+				    arsta->addr, nss, err);
 	}
 
 	if (changed & IEEE80211_RC_SMPS_CHANGED) {
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac update sta %pM smps %d\n",
-			   sta->addr, smps);
+			   arsta->addr, smps);
 
-		err = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+		err = ath12k_wmi_set_peer_param(ar, arsta->addr, arvif->vdev_id,
 						WMI_PEER_MIMO_PS_STATE, smps);
 		if (err)
 			ath12k_warn(ar->ab, "failed to update STA %pM smps %d: %d\n",
-				    sta->addr, smps, err);
+				    arsta->addr, smps, err);
 	}
 
 	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED) {
@@ -4826,11 +4829,11 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			err = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 			if (err)
 				ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-					    sta->addr, arvif->vdev_id, err);
+					    arsta->addr, arvif->vdev_id, err);
 
 			if (!wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ))
 				ath12k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
-					    sta->addr, arvif->vdev_id);
+					    arsta->addr, arvif->vdev_id);
 		}
 	}
 }
@@ -4882,7 +4885,7 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
 	if (peer && peer->sta == sta) {
 		ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
 			    vif->addr, arvif->vdev_id);
@@ -4937,27 +4940,26 @@ static int ath12k_mac_station_authorize(struct ath12k *ar,
 {
 	struct ath12k_peer *peer;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
-	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
 	if (peer)
 		peer->is_authorized = true;
 
 	spin_unlock_bh(&ar->ab->base_lock);
 
 	if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
-		ret = ath12k_wmi_set_peer_param(ar, sta->addr,
+		ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
 						arvif->vdev_id,
 						WMI_PEER_AUTHORIZE,
 						1);
 		if (ret) {
 			ath12k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
-				    sta->addr, arvif->vdev_id, ret);
+				    arsta->addr, arvif->vdev_id, ret);
 			return ret;
 		}
 	}
@@ -4985,15 +4987,15 @@ static int ath12k_mac_station_remove(struct ath12k *ar,
 				    arvif->vdev_id, ret);
 	}
 
-	ath12k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
+	ath12k_dp_peer_cleanup(ar, arvif->vdev_id, arsta->addr);
 
-	ret = ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
+	ret = ath12k_peer_delete(ar, arvif->vdev_id, arsta->addr);
 	if (ret)
 		ath12k_warn(ar->ab, "Failed to delete peer: %pM for VDEV: %d\n",
-			    sta->addr, arvif->vdev_id);
+			    arsta->addr, arvif->vdev_id);
 	else
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
-			   sta->addr, arvif->vdev_id);
+			   arsta->addr, arvif->vdev_id);
 
 	ath12k_mac_station_post_remove(ar, arvif, arsta);
 
@@ -5011,7 +5013,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	struct ath12k_wmi_peer_create_arg peer_param;
+	struct ath12k_wmi_peer_create_arg peer_param = {0};
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -5036,28 +5038,28 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	ret = ath12k_peer_create(ar, arvif, sta, &peer_param);
 	if (ret) {
 		ath12k_warn(ab, "Failed to add peer: %pM for VDEV: %d\n",
-			    sta->addr, arvif->vdev_id);
+			    arsta->addr, arvif->vdev_id);
 		goto free_peer;
 	}
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "Added peer: %pM for VDEV: %d\n",
-		   sta->addr, arvif->vdev_id);
+		   arsta->addr, arvif->vdev_id);
 
 	if (ieee80211_vif_is_mesh(vif)) {
-		ret = ath12k_wmi_set_peer_param(ar, sta->addr,
+		ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
 						arvif->vdev_id,
 						WMI_PEER_USE_4ADDR, 1);
 		if (ret) {
 			ath12k_warn(ab, "failed to STA %pM 4addr capability: %d\n",
-				    sta->addr, ret);
+				    arsta->addr, ret);
 			goto free_peer;
 		}
 	}
 
-	ret = ath12k_dp_peer_setup(ar, arvif->vdev_id, sta->addr);
+	ret = ath12k_dp_peer_setup(ar, arvif->vdev_id, arsta->addr);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup dp for peer %pM on vdev %i (%d)\n",
-			    sta->addr, arvif->vdev_id, ret);
+			    arsta->addr, arvif->vdev_id, ret);
 		goto free_peer;
 	}
 
@@ -5074,7 +5076,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	return 0;
 
 free_peer:
-	ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
+	ath12k_peer_delete(ar, arvif->vdev_id, arsta->addr);
 dec_num_station:
 	ath12k_mac_dec_num_stations(arvif, arsta);
 exit:
@@ -5147,6 +5149,8 @@ static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
 	arsta->arvif = arvif;
 	arsta->ahsta = ahsta;
 	arsta->state = IEEE80211_STA_NONE;
+	ahsta->ahvif = ahvif;
+
 	wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
 	rcu_assign_pointer(ahsta->link[link_id], arsta);
@@ -5266,7 +5270,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 		ret = ath12k_mac_station_add(ar, arvif, arsta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
-				    sta->addr, arvif->vdev_id);
+				    arsta->addr, arvif->vdev_id);
 
 	/* IEEE80211_STA_AUTH -> IEEE80211_STA_ASSOC: Send station assoc command for
 	 * peer associated to AP/Mesh/ADHOC vif type.
@@ -5279,7 +5283,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 		ret = ath12k_mac_station_assoc(ar, arvif, arsta, false);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
-				    sta->addr);
+				    arsta->addr);
 
 		spin_lock_bh(&ar->data_lock);
 
@@ -5296,7 +5300,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 		ret = ath12k_mac_station_authorize(ar, arvif, arsta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to authorize station: %pM\n",
-				    sta->addr);
+				    arsta->addr);
 
 	/* IEEE80211_STA_AUTHORIZED -> IEEE80211_STA_ASSOC: station may be in removal,
 	 * deauthorize it.
@@ -5316,7 +5320,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 		ret = ath12k_mac_station_disassoc(ar, arvif, arsta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to disassociate station: %pM\n",
-				    sta->addr);
+				    arsta->addr);
 	}
 
 exit:
@@ -5431,16 +5435,22 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k *ar;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta;
+	u8 link_id;
 	int ret;
 	s16 txpwr;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
+	/* TODO: use link id from mac80211 once that's implemented */
+	link_id = 0;
+
+	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+	arsta = wiphy_dereference(hw->wiphy, ahsta->link[link_id]);
 
 	if (sta->deflink.txpwr.type == NL80211_TX_POWER_AUTOMATIC) {
 		txpwr = 0;
@@ -5457,9 +5467,9 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = arvif->ar;
 
-	ret = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+	ret = ath12k_wmi_set_peer_param(ar, arsta->addr, arvif->vdev_id,
 					WMI_PEER_USE_FIXED_PWR, txpwr);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set tx power for station ret: %d\n",
@@ -5512,12 +5522,12 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	}
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
 	if (!peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
 		rcu_read_unlock();
 		ath12k_warn(ar->ab, "mac sta rc update failed to find peer %pM on vdev %i\n",
-			    sta->addr, arvif->vdev_id);
+			    arsta->addr, arvif->vdev_id);
 		return;
 	}
 
@@ -5525,7 +5535,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "mac sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
-		   sta->addr, changed, sta->deflink.bandwidth, sta->deflink.rx_nss,
+		   arsta->addr, changed, sta->deflink.bandwidth, sta->deflink.rx_nss,
 		   sta->deflink.smps_mode);
 
 	spin_lock_bh(&ar->data_lock);
@@ -5555,7 +5565,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 			break;
 		default:
 			ath12k_warn(ar->ab, "Invalid smps %d in sta rc update for %pM\n",
-				    sta->deflink.smps_mode, sta->addr);
+				    sta->deflink.smps_mode, arsta->addr);
 			smps = WMI_PEER_SMPS_PS_NONE;
 			break;
 		}
@@ -9139,14 +9149,14 @@ static void ath12k_mac_disable_peer_fixed_rate(void *data,
 	if (arsta->arvif != arvif)
 		return;
 
-	ret = ath12k_wmi_set_peer_param(ar, sta->addr,
+	ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
 					arvif->vdev_id,
 					WMI_PEER_PARAM_FIXED_RATE,
 					WMI_FIXED_RATE_NONE);
 	if (ret)
 		ath12k_warn(ar->ab,
 			    "failed to disable peer fixed rate for STA %pM ret %d\n",
-			    sta->addr, ret);
+			    arsta->addr, ret);
 }
 
 static int
-- 
2.39.5


