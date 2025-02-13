Return-Path: <linux-wireless+bounces-18940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EDA34C1E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED493A77A8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45C213A3EC;
	Thu, 13 Feb 2025 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mduyTPtv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D12222B4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467961; cv=none; b=PbbefV3OF7zGBDhHIMcLfjpcvFx1slkO/TH6ZkwMW5cMoX2p3+yTr/Tv2wjPCg60vy9iXMGHsEyusMXqJ5jQyn+MtHP3+YHsmgALcDtbXNqj0xlG4FfImhZaT/aa7SlYXov11gpcd8zzFNqNHj9IHjcROow6B1p1kkcmA/MnuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467961; c=relaxed/simple;
	bh=cBiaaFxf1+OPIC2rIFX6uIcuktj+im+zcwSMUVsDuwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cm2uAmgnG0ZjvnXqd3syVQD+jmSQQdB0aJA9YNk7FQ87oV6HjFPtuZQzTVKrhd/un2NjiTQ93/Qf0aX0FCxZKPmgEZNYkU6QRlY0rmygdze5K/VMlviOwOO2wRVlrjcGIK+4ZYRwIksbJSa8Swob8Fw4SJTO6rbnz4C+j0lGfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mduyTPtv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHCZcY032656;
	Thu, 13 Feb 2025 17:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yJAsljRBUnwJI8r3I3v7Bmf6l83CiG2+K3dfYK9hBLA=; b=mduyTPtvE8UI4MwP
	4Ikloxbo+21Vv+X4vVpdkMTKPYjgBmfZwAjetJv6GsJ1a7jfbrY8vl7S+lqm1cBW
	9DZdOCE4mUm4v8JysG12DB+D6+07N/vKKUsRrEH1ysjboIWStP3u0EU4hNInPuam
	/a87cGOOb96uHhVoGuiAuZEW08++Qeb0WeWhYNT4JG1T+kW6CHyqwU7gnotgkK/3
	yc1AqV00YJDr+wKiVtblN0wDtwFGKwkp+wwW7KprZDH4aS0r1lKarwbfwj3b5Kyc
	ErSjtRwNLSZHky2hEp0Z2V7/QjW4wikDONrZdT8cSepo0+jEwwOF96Ari+Na16aA
	A0v2ew==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sc7b9m11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:32:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHWXcZ029502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:32:33 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:32:31 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH v2 2/5] wifi: ath12k: add link support for multi-link in arsta
Date: Thu, 13 Feb 2025 23:02:03 +0530
Message-ID: <20250213173206.1665731-3-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213173206.1665731-1-quic_sarishar@quicinc.com>
References: <20250213173206.1665731-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uv24OT_8KAhZCOAV71ypiabwzyX3osRO
X-Proofpoint-GUID: uv24OT_8KAhZCOAV71ypiabwzyX3osRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=921
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130125

Currently, statistics in arsta are updated at deflink for both non-ML
and multi-link(ML) station. Link statistics are not updated for
multi-link operation(MLO).

Hence, add support to correctly obtain the link ID if the peer is ML,
fetch the arsta from the appropriate link ID, and update the
statistics in the corresponding arsta.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 23 ++++++++++++++------
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  9 +++++---
 drivers/net/wireless/ath/ath12k/peer.h   | 27 +++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d22800e89485..aecc4612c777 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3106,7 +3106,6 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
 				   u32 uid)
 {
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_rx_peer_stats *rx_stats = NULL;
 	struct hal_rx_user_status *user_stats = &ppdu_info->userstats[uid];
@@ -3124,10 +3123,14 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 		return;
 	}
 
-	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	arsta = &ahsta->deflink;
-	rx_stats = arsta->rx_stats;
+	arsta = ath12k_peer_get_link_sta(ar->ab, peer);
+	if (!arsta) {
+		ath12k_warn(ar->ab, "link sta not found on peer %pM id %d\n",
+			    peer->addr, peer->peer_id);
+		return;
+	}
 
+	rx_stats = arsta->rx_stats;
 	if (!rx_stats)
 		return;
 
@@ -3240,7 +3243,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	struct dp_srng *mon_dst_ring;
 	struct hal_srng *srng;
 	struct dp_rxdma_mon_ring *buf_ring;
-	struct ath12k_sta *ahsta = NULL;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_peer *peer;
 	struct sk_buff_head skb_list;
@@ -3367,8 +3369,15 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		}
 
 		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-			ahsta = ath12k_sta_to_ahsta(peer->sta);
-			arsta = &ahsta->deflink;
+			arsta = ath12k_peer_get_link_sta(ar->ab, peer);
+			if (!arsta) {
+				ath12k_warn(ar->ab, "link sta not found on peer %pM id %d\n",
+					    peer->addr, peer->peer_id);
+				spin_unlock_bh(&ab->base_lock);
+				rcu_read_unlock();
+				dev_kfree_skb_any(skb);
+				continue;
+			}
 			ath12k_dp_mon_rx_update_peer_su_stats(ar, arsta,
 							      ppdu_info);
 		} else if ((ppdu_info->fc_valid) &&
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 95c9056642cf..1fa7cf044afe 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1362,7 +1362,6 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
 	struct ieee80211_sta *sta;
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
 	struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
@@ -1444,8 +1443,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	}
 
 	sta = peer->sta;
-	ahsta = ath12k_sta_to_ahsta(sta);
-	arsta = &ahsta->deflink;
+	arsta = ath12k_peer_get_link_sta(ab, peer);
+	if (!arsta) {
+		spin_unlock_bh(&ab->base_lock);
+		rcu_read_unlock();
+		return;
+	}
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 5870ee11a8c7..7474053f54b0 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_PEER_H
@@ -90,5 +90,30 @@ struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash
 int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
+static inline
+struct ath12k_link_sta *ath12k_peer_get_link_sta(struct ath12k_base *ab,
+						 struct ath12k_peer *peer)
+{
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
+
+	if (!peer->sta)
+		return NULL;
+
+	ahsta = ath12k_sta_to_ahsta(peer->sta);
+	if (peer->ml_id & ATH12K_PEER_ML_ID_VALID) {
+		if (!(ahsta->links_map & BIT(peer->link_id))) {
+			ath12k_warn(ab, "peer %pM id %d link_id %d can't found in STA link_map 0x%x\n",
+				    peer->addr, peer->peer_id, peer->link_id, ahsta->links_map);
+			return NULL;
+		}
+		arsta = rcu_dereference(ahsta->link[peer->link_id]);
+		if (!arsta)
+			return NULL;
+	} else {
+		arsta =  &ahsta->deflink;
+	}
+	return arsta;
+}
 
 #endif /* _PEER_H_ */
-- 
2.34.1


