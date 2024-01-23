Return-Path: <linux-wireless+bounces-2358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F58385D8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 03:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4ED291451
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 02:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E11A47;
	Tue, 23 Jan 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EP+D/vb+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BB812
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978642; cv=none; b=bF9ldIua4Ex+ImI4RvoH1Hnp7YEMmfmhuMToG1OLe21uyK2fkffo2yDBqQHzWrRTnhOIK6JGhD9M6ukUQxhR6akERXEUyNRGFqDfaMY7oDO7krnqMhbrV2UHqYjWnev2Qi/U2h6QFF+PkQPCiN6oaq0NK+iieHMoDIngDx3YCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978642; c=relaxed/simple;
	bh=6nuRF5AyiKAxT+Dd1Bet1vIqUSV7F/SqY+iJqsOwaDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oR4Pb9AfYPsGVFJVSpXXpLQs2aC9rdJNWTLDq6wiSxxhHo5qn88Ya3Tz0MeUqGiWH7yZmC6FW6U8jB8JOThrRM2xwcdk9sjUWh1TdVHYiE6RNqHY0Y5ZK8t3TNpsxJ8Hqr6djlzCKiswgTe5JKdBFX8+KNQlNjbQsVU4qbeNgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EP+D/vb+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N2RFcF014750;
	Tue, 23 Jan 2024 02:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7JbpltriaTuF83ZfC7cp752TABuiStiadXNCOmLsryk=; b=EP
	+D/vb+ovB3xlUJ7nnMxvVU+wxGl8XaxeoV6LADtR/euMlnhhfZLikNugw5+LTOVj
	+iUPzXt0qgatGuDoJNsZakjfrKetwdGUo9erGGVvxSz8a64UtpR9jzPTZ9QcpA5S
	kRdRwqjPEGtDdLwN1fZrsCeZ2UDXGWvB43OYpXEhcaSN+9/Ax0Xwjm+zO5fk9rQl
	+MBNp1M2mG3MKBHtbmJhshReEeBO8dVdlQ9z+gcag66yHysPsq5HKPlJvZIBsJD8
	6UdG7/W2uh1BwUVRN2zWs65bVbvZzlGw7wf47GwsB6YqwQULaaCyL0zEzTkmllFE
	2vCw8ybFFVD9Kdi7OjwQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vst8w9h4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N2vGNg001268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:16 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 18:57:15 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 4/4] wifi: ath11k: fix connection failure due to unexpected peer delete
Date: Tue, 23 Jan 2024 10:57:00 +0800
Message-ID: <20240123025700.2929-5-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: z3rZjI5VfFb5jXVJzU0WzxV5dtu55XCl
X-Proofpoint-ORIG-GUID: z3rZjI5VfFb5jXVJzU0WzxV5dtu55XCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230019

Currently ath11k_mac_op_unassign_vif_chanctx() deletes peer but
ath11k_mac_op_assign_vif_chanctx() doesn't create it. This results in
connection failure if MAC80211 calls drv_unassign_vif_chanctx() and
drv_assign_vif_chanctx() during AUTH and ASSOC, see below log:

[  102.372431] wlan0: authenticated
[  102.372585] ath11k_pci 0000:01:00.0: wlan0: disabling HT/VHT/HE as WMM/QoS is not supported by the AP
[  102.372593] ath11k_pci 0000:01:00.0: mac chanctx unassign ptr ffff895084638598 vdev_id 0
[  102.372808] ath11k_pci 0000:01:00.0: WMI vdev stop id 0x0
[  102.383114] ath11k_pci 0000:01:00.0: vdev stopped for vdev id 0
[  102.384689] ath11k_pci 0000:01:00.0: WMI peer delete vdev_id 0 peer_addr 20:e5:2a:21:c4:51
[  102.396676] ath11k_pci 0000:01:00.0: htt peer unmap vdev 0 peer 20:e5:2a:21:c4:51 id 3
[  102.396711] ath11k_pci 0000:01:00.0: peer delete resp for vdev id 0 addr 20:e5:2a:21:c4:51
[  102.396722] ath11k_pci 0000:01:00.0: mac removed peer 20:e5:2a:21:c4:51  vdev 0 after vdev stop
[  102.396780] ath11k_pci 0000:01:00.0: mac chanctx assign ptr ffff895084639c18 vdev_id 0
[  102.400628] wlan0: associate with 20:e5:2a:21:c4:51 (try 1/3)
[  102.508864] wlan0: associate with 20:e5:2a:21:c4:51 (try 2/3)
[  102.612815] wlan0: associate with 20:e5:2a:21:c4:51 (try 3/3)
[  102.720846] wlan0: association with 20:e5:2a:21:c4:51 timed out

The peer delete logic in ath11k_mac_op_unassign_vif_chanctx() is
introduced by commit b4a0f54156ac ("ath11k: move peer delete after
vdev stop of station for QCA6390 and WCN6855") to fix firmware
crash issue caused by unexpected vdev stop/peer delete sequence.

Actually for a STA interface peer should be deleted in
ath11k_mac_op_sta_state() when STA's state changes from
IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST, which also coincides
with current peer creation design that peer is created during
IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE transition. So move
peer delete back to ath11k_mac_op_sta_state(), also stop vdev before
deleting peer to fix the firmware crash issue mentioned there. In
this way the connection failure mentioned here is also fixed.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: b4a0f54156ac ("ath11k: move peer delete after vdev stop of station for QCA6390 and WCN6855")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 139 ++++++++++++++++----------
 1 file changed, 85 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8aa2b4fae79b..14f2947600dc 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7386,6 +7386,30 @@ static int ath11k_mac_start_vdev_delay(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int ath11k_mac_stop_vdev_early(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	int ret;
+
+	if (WARN_ON(!arvif->is_started))
+		return -EBUSY;
+
+	ret = ath11k_mac_vdev_stop(arvif);
+	if (ret) {
+		ath11k_warn(ab, "failed to stop vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	arvif->is_started = false;
+
+	/* TODO: Setup ps and cts/rts protection */
+	return 0;
+}
+
 static u8 ath11k_mac_get_tpe_count(u8 txpwr_intrprt, u8 txpwr_cnt)
 {
 	switch (txpwr_intrprt) {
@@ -7920,15 +7944,17 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	ret = ath11k_mac_vdev_start(arvif, ctx);
-	if (ret) {
-		ath11k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
-			    arvif->vdev_id, vif->addr,
-			    ctx->def.chan->center_freq, ret);
-		goto out;
-	}
+	if (!arvif->is_started) {
+		ret = ath11k_mac_vdev_start(arvif, ctx);
+		if (ret) {
+			ath11k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
+				    arvif->vdev_id, vif->addr,
+				    ctx->def.chan->center_freq, ret);
+			goto out;
+		}
 
-	arvif->is_started = true;
+		arvif->is_started = true;
+	}
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    test_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags)) {
@@ -7968,8 +7994,6 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		   "chanctx unassign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
-	WARN_ON(!arvif->is_started);
-
 	if (ab->hw_params.vdev_start_delay &&
 	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		spin_lock_bh(&ab->base_lock);
@@ -7993,24 +8017,13 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		return;
 	}
 
-	ret = ath11k_mac_vdev_stop(arvif);
-	if (ret)
-		ath11k_warn(ab, "failed to stop vdev %i: %d\n",
-			    arvif->vdev_id, ret);
-
-	arvif->is_started = false;
-
-	if (ab->hw_params.vdev_start_delay &&
-	    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
-		ret = ath11k_peer_delete(ar, arvif->vdev_id, arvif->bssid);
+	if (arvif->is_started) {
+		ret = ath11k_mac_vdev_stop(arvif);
 		if (ret)
-			ath11k_warn(ar->ab,
-				    "failed to delete peer %pM for vdev %d: %d\n",
-				    arvif->bssid, arvif->vdev_id, ret);
-		else
-			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-				   "removed peer %pM  vdev %d after vdev stop\n",
-				   arvif->bssid, arvif->vdev_id);
+			ath11k_warn(ab, "failed to stop vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+
+		arvif->is_started = false;
 	}
 
 	if (ab->hw_params.vdev_start_delay &&
@@ -9462,6 +9475,46 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	return ret;
 }
 
+static int ath11k_mac_station_remove(struct ath11k *ar,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
+	int ret;
+
+	if (ab->hw_params.vdev_start_delay &&
+	    arvif->is_started &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
+		ret = ath11k_mac_stop_vdev_early(ar->hw, vif);
+		if (ret) {
+			ath11k_warn(ab, "failed to do early vdev stop: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ath11k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
+
+	ret = ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
+	if (ret)
+		ath11k_warn(ab, "Failed to delete peer: %pM for VDEV: %d\n",
+			    sta->addr, arvif->vdev_id);
+	else
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
+			   sta->addr, arvif->vdev_id);
+
+	ath11k_mac_dec_num_stations(arvif, sta);
+
+	kfree(arsta->tx_stats);
+	arsta->tx_stats = NULL;
+
+	kfree(arsta->rx_stats);
+	arsta->rx_stats = NULL;
+
+	return ret;
+}
+
 static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -9497,31 +9550,15 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				    sta->addr, arvif->vdev_id);
 	} else if ((old_state == IEEE80211_STA_NONE &&
 		    new_state == IEEE80211_STA_NOTEXIST)) {
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
+		ret = ath11k_mac_station_remove(ar, vif, sta);
+		if (ret)
+			ath11k_warn(ar->ab, "Failed to remove station: %pM for VDEV: %d\n",
+				    sta->addr, arvif->vdev_id);
 
-		ath11k_mac_dec_num_stations(arvif, sta);
 		mutex_lock(&ar->ab->tbl_mtx_lock);
 		spin_lock_bh(&ar->ab->base_lock);
 		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
-		if (skip_peer_delete && peer) {
-			peer->sta = NULL;
-		} else if (peer && peer->sta == sta) {
+		if (peer && peer->sta == sta) {
 			ath11k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
 				    vif->addr, arvif->vdev_id);
 			ath11k_peer_rhash_delete(ar->ab, peer);
@@ -9532,12 +9569,6 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		}
 		spin_unlock_bh(&ar->ab->base_lock);
 		mutex_unlock(&ar->ab->tbl_mtx_lock);
-
-		kfree(arsta->tx_stats);
-		arsta->tx_stats = NULL;
-
-		kfree(arsta->rx_stats);
-		arsta->rx_stats = NULL;
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC &&
 		   (vif->type == NL80211_IFTYPE_AP ||
-- 
2.25.1


