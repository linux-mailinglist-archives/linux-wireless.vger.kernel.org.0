Return-Path: <linux-wireless+bounces-2359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F7F8385D9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 03:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F9F1C29DA3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250A1869;
	Tue, 23 Jan 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MgZnPwe+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D51102
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978644; cv=none; b=k6P8/5SwaxefAfWE41Q1DS0XxOoQXjnS8EXVNqfwhAC01E9ZQxpz8YycfziyDzrmzQ8VGN/+HlGQG+ScDWBsETXTPYXrMSEQNO847KR8fSludV1iFANoSjYnSxQE3W4E3ZCXGYo3Am1cKJ2Xd904b6wUy7DvB/gpmKTyhg75cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978644; c=relaxed/simple;
	bh=ooPx4U++yhtq23HW1AQIcJ+NjKouc7q4iuGpcE9qGiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRGyNroiPgikE90Nl8idR4LdjdIvgsweT50K45t3oqUhU3G5OmgdxOYkFcK4XpIWIJfXsg5fJqCBWvx4p06PqVF+0mD+Z5vvM+xD9RqvLGeYkDCbanKEjCtzjxkh5MtR49ASLwRgV3lmNvli3Wmy+fJmsAijhA3qNPda9rsqf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MgZnPwe+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N2SMMi017146;
	Tue, 23 Jan 2024 02:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ovdm9NceXjLBQ/DXBqFx3tF7LAzy3RJ33GTHTgq9Spc=; b=Mg
	ZnPwe+SjlyAsaaIq7dXyJr8Ujl828dbNPDzE60C8sPMcqfIF0MWwsWYGMuPT0NEK
	jcwWUM60pFlRJP1vRsjYGXxrRIxbnCVBoLN+ax7japQSWxPjSzXbVBeFJL4oWBGA
	oFpecGCzo069EqwJNKeAH0/vIIWCbP3RJ3+0kDNBT7tPQazaRRkYMVSsCI445ssc
	7yEN3RHVcqvjeWu1NS2XzEvpm6upAiSOAQpf4UvJDuBzVLCBvMnrNBQcME+XeZAc
	GdSIoee/aWS/KfTpXRUqvYG0Wbl6d/8oUYFjhwFr7u3bjuf0/K1bds8mmLx8qidv
	7JBzMErjEoADNBzQykBQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vst8w9h4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N2vFBU001263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:15 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 18:57:13 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 3/4] wifi: ath11k: avoid forward declaration of ath11k_mac_start_vdev_delay()
Date: Tue, 23 Jan 2024 10:56:59 +0800
Message-ID: <20240123025700.2929-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123025700.2929-1-quic_bqiang@quicinc.com>
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IbDJ6Wl0CoMAS2MpXvD8ZtSirPVZH30R
X-Proofpoint-ORIG-GUID: IbDJ6Wl0CoMAS2MpXvD8ZtSirPVZH30R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230019

Currently ath11k_mac_start_vdev_delay() needs a forward declaration because
it is defined after where it is called. Avoid this by re-arranging
ath11k_mac_station_add() and ath11k_mac_op_sta_state().

No functional changes. Compile tested only.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 459 +++++++++++++-------------
 1 file changed, 228 insertions(+), 231 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9c732fc22711..8aa2b4fae79b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -255,9 +255,6 @@ static const u32 ath11k_smps_map[] = {
 	[WLAN_HT_CAP_SM_PS_DISABLED] = WMI_PEER_SMPS_PS_NONE,
 };
 
-static int ath11k_mac_start_vdev_delay(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif);
-
 enum nl80211_he_ru_alloc ath11k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy)
 {
 	enum nl80211_he_ru_alloc ret;
@@ -4917,100 +4914,6 @@ static void ath11k_mac_dec_num_stations(struct ath11k_vif *arvif,
 	ar->num_stations--;
 }
 
-static int ath11k_mac_station_add(struct ath11k *ar,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta)
-{
-	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
-	struct peer_create_params peer_param;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	ret = ath11k_mac_inc_num_stations(arvif, sta);
-	if (ret) {
-		ath11k_warn(ab, "refusing to associate station: too many connected already (%d)\n",
-			    ar->max_num_stations);
-		goto exit;
-	}
-
-	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
-	if (!arsta->rx_stats) {
-		ret = -ENOMEM;
-		goto dec_num_station;
-	}
-
-	peer_param.vdev_id = arvif->vdev_id;
-	peer_param.peer_addr = sta->addr;
-	peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
-
-	ret = ath11k_peer_create(ar, arvif, sta, &peer_param);
-	if (ret) {
-		ath11k_warn(ab, "Failed to add peer: %pM for VDEV: %d\n",
-			    sta->addr, arvif->vdev_id);
-		goto free_rx_stats;
-	}
-
-	ath11k_dbg(ab, ATH11K_DBG_MAC, "Added peer: %pM for VDEV: %d\n",
-		   sta->addr, arvif->vdev_id);
-
-	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar)) {
-		arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats), GFP_KERNEL);
-		if (!arsta->tx_stats) {
-			ret = -ENOMEM;
-			goto free_peer;
-		}
-	}
-
-	if (ieee80211_vif_is_mesh(vif)) {
-		ath11k_dbg(ab, ATH11K_DBG_MAC,
-			   "setting USE_4ADDR for mesh STA %pM\n", sta->addr);
-		ret = ath11k_wmi_set_peer_param(ar, sta->addr,
-						arvif->vdev_id,
-						WMI_PEER_USE_4ADDR, 1);
-		if (ret) {
-			ath11k_warn(ab, "failed to set mesh STA %pM 4addr capability: %d\n",
-				    sta->addr, ret);
-			goto free_tx_stats;
-		}
-	}
-
-	ret = ath11k_dp_peer_setup(ar, arvif->vdev_id, sta->addr);
-	if (ret) {
-		ath11k_warn(ab, "failed to setup dp for peer %pM on vdev %i (%d)\n",
-			    sta->addr, arvif->vdev_id, ret);
-		goto free_tx_stats;
-	}
-
-	if (ab->hw_params.vdev_start_delay &&
-	    !arvif->is_started &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
-		ret = ath11k_mac_start_vdev_delay(ar->hw, vif);
-		if (ret) {
-			ath11k_warn(ab, "failed to delay vdev start: %d\n", ret);
-			goto free_tx_stats;
-		}
-	}
-
-	ewma_avg_rssi_init(&arsta->avg_rssi);
-	return 0;
-
-free_tx_stats:
-	kfree(arsta->tx_stats);
-	arsta->tx_stats = NULL;
-free_peer:
-	ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
-free_rx_stats:
-	kfree(arsta->rx_stats);
-	arsta->rx_stats = NULL;
-dec_num_station:
-	ath11k_mac_dec_num_stations(arvif, sta);
-exit:
-	return ret;
-}
-
 static u32 ath11k_mac_ieee80211_sta_bw_to_wmi(struct ath11k *ar,
 					      struct ieee80211_sta *sta)
 {
@@ -5039,140 +4942,6 @@ static u32 ath11k_mac_ieee80211_sta_bw_to_wmi(struct ath11k *ar,
 	return bw;
 }
 
-static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta,
-				   enum ieee80211_sta_state old_state,
-				   enum ieee80211_sta_state new_state)
-{
-	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
-	struct ath11k_peer *peer;
-	int ret = 0;
-
-	/* cancel must be done outside the mutex to avoid deadlock */
-	if ((old_state == IEEE80211_STA_NONE &&
-	     new_state == IEEE80211_STA_NOTEXIST)) {
-		cancel_work_sync(&arsta->update_wk);
-		cancel_work_sync(&arsta->set_4addr_wk);
-	}
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (old_state == IEEE80211_STA_NOTEXIST &&
-	    new_state == IEEE80211_STA_NONE) {
-		memset(arsta, 0, sizeof(*arsta));
-		arsta->arvif = arvif;
-		arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
-		INIT_WORK(&arsta->update_wk, ath11k_sta_rc_update_wk);
-		INIT_WORK(&arsta->set_4addr_wk, ath11k_sta_set_4addr_wk);
-
-		ret = ath11k_mac_station_add(ar, vif, sta);
-		if (ret)
-			ath11k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
-				    sta->addr, arvif->vdev_id);
-	} else if ((old_state == IEEE80211_STA_NONE &&
-		    new_state == IEEE80211_STA_NOTEXIST)) {
-		bool skip_peer_delete = ar->ab->hw_params.vdev_start_delay &&
-			vif->type == NL80211_IFTYPE_STATION;
-
-		ath11k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
-
-		if (!skip_peer_delete) {
-			ret = ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
-			if (ret)
-				ath11k_warn(ar->ab,
-					    "Failed to delete peer: %pM for VDEV: %d\n",
-					    sta->addr, arvif->vdev_id);
-			else
-				ath11k_dbg(ar->ab,
-					   ATH11K_DBG_MAC,
-					   "Removed peer: %pM for VDEV: %d\n",
-					   sta->addr, arvif->vdev_id);
-		}
-
-		ath11k_mac_dec_num_stations(arvif, sta);
-		mutex_lock(&ar->ab->tbl_mtx_lock);
-		spin_lock_bh(&ar->ab->base_lock);
-		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
-		if (skip_peer_delete && peer) {
-			peer->sta = NULL;
-		} else if (peer && peer->sta == sta) {
-			ath11k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
-				    vif->addr, arvif->vdev_id);
-			ath11k_peer_rhash_delete(ar->ab, peer);
-			peer->sta = NULL;
-			list_del(&peer->list);
-			kfree(peer);
-			ar->num_peers--;
-		}
-		spin_unlock_bh(&ar->ab->base_lock);
-		mutex_unlock(&ar->ab->tbl_mtx_lock);
-
-		kfree(arsta->tx_stats);
-		arsta->tx_stats = NULL;
-
-		kfree(arsta->rx_stats);
-		arsta->rx_stats = NULL;
-	} else if (old_state == IEEE80211_STA_AUTH &&
-		   new_state == IEEE80211_STA_ASSOC &&
-		   (vif->type == NL80211_IFTYPE_AP ||
-		    vif->type == NL80211_IFTYPE_MESH_POINT ||
-		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath11k_station_assoc(ar, vif, sta, false);
-		if (ret)
-			ath11k_warn(ar->ab, "Failed to associate station: %pM\n",
-				    sta->addr);
-
-		spin_lock_bh(&ar->data_lock);
-		/* Set arsta bw and prev bw */
-		arsta->bw = ath11k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
-		arsta->bw_prev = arsta->bw;
-		spin_unlock_bh(&ar->data_lock);
-	} else if (old_state == IEEE80211_STA_ASSOC &&
-		   new_state == IEEE80211_STA_AUTHORIZED) {
-		spin_lock_bh(&ar->ab->base_lock);
-
-		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
-		if (peer)
-			peer->is_authorized = true;
-
-		spin_unlock_bh(&ar->ab->base_lock);
-
-		if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
-			ret = ath11k_wmi_set_peer_param(ar, sta->addr,
-							arvif->vdev_id,
-							WMI_PEER_AUTHORIZE,
-							1);
-			if (ret)
-				ath11k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
-					    sta->addr, arvif->vdev_id, ret);
-		}
-	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
-		   new_state == IEEE80211_STA_ASSOC) {
-		spin_lock_bh(&ar->ab->base_lock);
-
-		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
-		if (peer)
-			peer->is_authorized = false;
-
-		spin_unlock_bh(&ar->ab->base_lock);
-	} else if (old_state == IEEE80211_STA_ASSOC &&
-		   new_state == IEEE80211_STA_AUTH &&
-		   (vif->type == NL80211_IFTYPE_AP ||
-		    vif->type == NL80211_IFTYPE_MESH_POINT ||
-		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath11k_station_disassoc(ar, vif, sta);
-		if (ret)
-			ath11k_warn(ar->ab, "Failed to disassociate station: %pM\n",
-				    sta->addr);
-	}
-
-	mutex_unlock(&ar->conf_mutex);
-	return ret;
-}
-
 static int ath11k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
@@ -9599,6 +9368,234 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int ath11k_mac_station_add(struct ath11k *ar,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
+	struct peer_create_params peer_param;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ret = ath11k_mac_inc_num_stations(arvif, sta);
+	if (ret) {
+		ath11k_warn(ab, "refusing to associate station: too many connected already (%d)\n",
+			    ar->max_num_stations);
+		goto exit;
+	}
+
+	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
+	if (!arsta->rx_stats) {
+		ret = -ENOMEM;
+		goto dec_num_station;
+	}
+
+	peer_param.vdev_id = arvif->vdev_id;
+	peer_param.peer_addr = sta->addr;
+	peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
+
+	ret = ath11k_peer_create(ar, arvif, sta, &peer_param);
+	if (ret) {
+		ath11k_warn(ab, "Failed to add peer: %pM for VDEV: %d\n",
+			    sta->addr, arvif->vdev_id);
+		goto free_rx_stats;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "Added peer: %pM for VDEV: %d\n",
+		   sta->addr, arvif->vdev_id);
+
+	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar)) {
+		arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats), GFP_KERNEL);
+		if (!arsta->tx_stats) {
+			ret = -ENOMEM;
+			goto free_peer;
+		}
+	}
+
+	if (ieee80211_vif_is_mesh(vif)) {
+		ath11k_dbg(ab, ATH11K_DBG_MAC,
+			   "setting USE_4ADDR for mesh STA %pM\n", sta->addr);
+		ret = ath11k_wmi_set_peer_param(ar, sta->addr,
+						arvif->vdev_id,
+						WMI_PEER_USE_4ADDR, 1);
+		if (ret) {
+			ath11k_warn(ab, "failed to set mesh STA %pM 4addr capability: %d\n",
+				    sta->addr, ret);
+			goto free_tx_stats;
+		}
+	}
+
+	ret = ath11k_dp_peer_setup(ar, arvif->vdev_id, sta->addr);
+	if (ret) {
+		ath11k_warn(ab, "failed to setup dp for peer %pM on vdev %i (%d)\n",
+			    sta->addr, arvif->vdev_id, ret);
+		goto free_tx_stats;
+	}
+
+	if (ab->hw_params.vdev_start_delay &&
+	    !arvif->is_started &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
+		ret = ath11k_mac_start_vdev_delay(ar->hw, vif);
+		if (ret) {
+			ath11k_warn(ab, "failed to delay vdev start: %d\n", ret);
+			goto free_tx_stats;
+		}
+	}
+
+	ewma_avg_rssi_init(&arsta->avg_rssi);
+	return 0;
+
+free_tx_stats:
+	kfree(arsta->tx_stats);
+	arsta->tx_stats = NULL;
+free_peer:
+	ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
+free_rx_stats:
+	kfree(arsta->rx_stats);
+	arsta->rx_stats = NULL;
+dec_num_station:
+	ath11k_mac_dec_num_stations(arvif, sta);
+exit:
+	return ret;
+}
+
+static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   enum ieee80211_sta_state old_state,
+				   enum ieee80211_sta_state new_state)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
+	struct ath11k_peer *peer;
+	int ret = 0;
+
+	/* cancel must be done outside the mutex to avoid deadlock */
+	if ((old_state == IEEE80211_STA_NONE &&
+	     new_state == IEEE80211_STA_NOTEXIST)) {
+		cancel_work_sync(&arsta->update_wk);
+		cancel_work_sync(&arsta->set_4addr_wk);
+	}
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (old_state == IEEE80211_STA_NOTEXIST &&
+	    new_state == IEEE80211_STA_NONE) {
+		memset(arsta, 0, sizeof(*arsta));
+		arsta->arvif = arvif;
+		arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
+		INIT_WORK(&arsta->update_wk, ath11k_sta_rc_update_wk);
+		INIT_WORK(&arsta->set_4addr_wk, ath11k_sta_set_4addr_wk);
+
+		ret = ath11k_mac_station_add(ar, vif, sta);
+		if (ret)
+			ath11k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
+				    sta->addr, arvif->vdev_id);
+	} else if ((old_state == IEEE80211_STA_NONE &&
+		    new_state == IEEE80211_STA_NOTEXIST)) {
+		bool skip_peer_delete = ar->ab->hw_params.vdev_start_delay &&
+			vif->type == NL80211_IFTYPE_STATION;
+
+		ath11k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
+
+		if (!skip_peer_delete) {
+			ret = ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
+			if (ret)
+				ath11k_warn(ar->ab,
+					    "Failed to delete peer: %pM for VDEV: %d\n",
+					    sta->addr, arvif->vdev_id);
+			else
+				ath11k_dbg(ar->ab,
+					   ATH11K_DBG_MAC,
+					   "Removed peer: %pM for VDEV: %d\n",
+					   sta->addr, arvif->vdev_id);
+		}
+
+		ath11k_mac_dec_num_stations(arvif, sta);
+		mutex_lock(&ar->ab->tbl_mtx_lock);
+		spin_lock_bh(&ar->ab->base_lock);
+		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+		if (skip_peer_delete && peer) {
+			peer->sta = NULL;
+		} else if (peer && peer->sta == sta) {
+			ath11k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
+				    vif->addr, arvif->vdev_id);
+			ath11k_peer_rhash_delete(ar->ab, peer);
+			peer->sta = NULL;
+			list_del(&peer->list);
+			kfree(peer);
+			ar->num_peers--;
+		}
+		spin_unlock_bh(&ar->ab->base_lock);
+		mutex_unlock(&ar->ab->tbl_mtx_lock);
+
+		kfree(arsta->tx_stats);
+		arsta->tx_stats = NULL;
+
+		kfree(arsta->rx_stats);
+		arsta->rx_stats = NULL;
+	} else if (old_state == IEEE80211_STA_AUTH &&
+		   new_state == IEEE80211_STA_ASSOC &&
+		   (vif->type == NL80211_IFTYPE_AP ||
+		    vif->type == NL80211_IFTYPE_MESH_POINT ||
+		    vif->type == NL80211_IFTYPE_ADHOC)) {
+		ret = ath11k_station_assoc(ar, vif, sta, false);
+		if (ret)
+			ath11k_warn(ar->ab, "Failed to associate station: %pM\n",
+				    sta->addr);
+
+		spin_lock_bh(&ar->data_lock);
+		/* Set arsta bw and prev bw */
+		arsta->bw = ath11k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
+		arsta->bw_prev = arsta->bw;
+		spin_unlock_bh(&ar->data_lock);
+	} else if (old_state == IEEE80211_STA_ASSOC &&
+		   new_state == IEEE80211_STA_AUTHORIZED) {
+		spin_lock_bh(&ar->ab->base_lock);
+
+		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+		if (peer)
+			peer->is_authorized = true;
+
+		spin_unlock_bh(&ar->ab->base_lock);
+
+		if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
+			ret = ath11k_wmi_set_peer_param(ar, sta->addr,
+							arvif->vdev_id,
+							WMI_PEER_AUTHORIZE,
+							1);
+			if (ret)
+				ath11k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
+					    sta->addr, arvif->vdev_id, ret);
+		}
+	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
+		   new_state == IEEE80211_STA_ASSOC) {
+		spin_lock_bh(&ar->ab->base_lock);
+
+		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+		if (peer)
+			peer->is_authorized = false;
+
+		spin_unlock_bh(&ar->ab->base_lock);
+	} else if (old_state == IEEE80211_STA_ASSOC &&
+		   new_state == IEEE80211_STA_AUTH &&
+		   (vif->type == NL80211_IFTYPE_AP ||
+		    vif->type == NL80211_IFTYPE_MESH_POINT ||
+		    vif->type == NL80211_IFTYPE_ADHOC)) {
+		ret = ath11k_station_disassoc(ar, vif, sta);
+		if (ret)
+			ath11k_warn(ar->ab, "Failed to disassociate station: %pM\n",
+				    sta->addr);
+	}
+
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
 	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
-- 
2.25.1


