Return-Path: <linux-wireless+bounces-24651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D756AED551
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F43189807B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92A21A43D;
	Mon, 30 Jun 2025 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oxbx+H6+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC8217704
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267546; cv=none; b=Kl2ARTE9/mdF+Z7o8wNGhJxj9vYniCJA45uZhbtX2dvixFgZSED6kIavSuoKN61FI9hhlUn6IJy+NNOQuy67PQgHWBAcIhCIG1/vk5bOVWfyfTt2/BDea2pqE+eNd9bHt2FNuWaPoA8YQGYUX2u04tRaWL4OOjTwroLLuav8FDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267546; c=relaxed/simple;
	bh=MpiDXGTrsitfwUzr6mWPARLmliAkEduXms/IPIrGtkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmA0HV0fHhZcmNFZmpyzPressGWacgbaQOle1OQiztR8PmHE/qRVnN0QNBRfAhQ5m6NItvx69dwj/YjMtgyVX/4kXbjspgeQWQwiH/XLkKTICE7e5A+Nc8ZEQLXTewv9DbMTDbNCDK3z8JPQq0XxG/F8XNc99fTIuVTfx7Zv0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oxbx+H6+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4qI2C016916;
	Mon, 30 Jun 2025 07:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CP9Zm00uVSvIvkZWn/5ZO632Mmn53kInxGa79TMQZ2w=; b=oxbx+H6+Dq16D2Wl
	k2WIx7pZzfb7fFMJoByRCxQXH899a3HeK1aBEz9LeQYkYLP25Oi0ZJrJ14iORJbs
	eqwpGTBTsKnN2DHdIksMPDhNMrXcBrrMzsRQLtxbzhJosyAh8417Y0Q7VSCha+E1
	vACacCEssEN+ltWH7229DoxEGKFsv+GYVoGzZqjVK24769o6SRub4pQizDWc5MKt
	ghsdsoJfZf61Y1s/aTlBcd14a0CLS+OmNsUD8GBC1yEnX0noSEcrUhfsJjep+4Y0
	7ZRcMFKoOeyCQA/SXyYQs9Xu/cP02qsWrCfRXMjqlioDNUgeaJ8NIzl4LviteR3F
	Rpgv/g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kkwrrabb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U7CL7s030453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:21 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 00:12:20 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v7 2/5] wifi: ath12k: add link support for multi-link in arsta
Date: Mon, 30 Jun 2025 12:41:11 +0530
Message-ID: <20250630071114.3474672-3-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
References: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=XeCJzJ55 c=1 sm=1 tr=0 ts=686238d6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=lHz-9wWWAAlisZ7QqxgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1OCBTYWx0ZWRfX3vTYYIqa5R8n
 PxBBPgdKbUjax+yni1XZb0IkmfIutc+dqbvVb/xydw9lD01llBcs7GgX8H98PjbXhPUS/4pK0tl
 UdqKJjA4VbBLcNJ5p9tCwdJjaEw3gp3RjhXiL8zO50Bqqat112FrqnKmJ00HFbnm1eD02wccG66
 FS1XQZQIIvQ2oHJP1kBXfb8lqDsQ/qhAZ8ftNbNtUvy7ssam2+mKwLAL3miNz4GL/7qIvInQdTv
 hlntqh3R4Q4b42ldAyLMI5AkB4qw9VdyIBUpDHFbPFHC4SWwQHlasWQhGN4jJ6AXLbETVcudnkR
 /Xzc1ho1oVB3BAGI2+0zQWX3EEVRvCMCSpxBFO50IpOlUpNEzMXHK+IbHTqoucznJ+B6osNZ8Ol
 ylo8Jqw07w1F5tISxy8HSUrJ2f55UCa9/ZmojTBG3qJmdOIP/mOd9HyW7NA7JeY+6QbN8fqe
X-Proofpoint-GUID: qX7sLjteAfauDGGvY31Iw56dlzkKXTXO
X-Proofpoint-ORIG-GUID: qX7sLjteAfauDGGvY31Iw56dlzkKXTXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=910
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300058

Currently, statistics in arsta are updated at deflink for both non-ML
and multi-link(ML) station. Link statistics are not updated for
multi-link operation(MLO).

Hence, add support to correctly obtain the link ID if the peer is ML,
fetch the arsta from the appropriate link ID, and update the
statistics in the corresponding arsta.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 22 ++++++++++++++------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 11 +++++-----
 drivers/net/wireless/ath/ath12k/peer.h   | 26 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index b408103fe9d4..8189e52ed007 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3615,7 +3615,6 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
 				   u32 uid)
 {
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_rx_peer_stats *rx_stats = NULL;
 	struct hal_rx_user_status *user_stats = &ppdu_info->userstats[uid];
@@ -3633,8 +3632,13 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 		return;
 	}
 
-	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	arsta = &ahsta->deflink;
+	arsta = ath12k_peer_get_link_sta(ar->ab, peer);
+	if (!arsta) {
+		ath12k_warn(ar->ab, "link sta not found on peer %pM id %d\n",
+			    peer->addr, peer->peer_id);
+		return;
+	}
+
 	arsta->rssi_comb = ppdu_info->rssi_comb;
 	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 	rx_stats = arsta->rx_stats;
@@ -3747,7 +3751,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	struct dp_srng *mon_dst_ring;
 	struct hal_srng *srng;
 	struct dp_rxdma_mon_ring *buf_ring;
-	struct ath12k_sta *ahsta = NULL;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_peer *peer;
 	struct sk_buff_head skb_list;
@@ -3873,8 +3876,15 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
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
index 420a9b161f4a..f0cfe03d74b6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1417,8 +1417,6 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
-	struct ieee80211_sta *sta;
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
 	struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
@@ -1499,9 +1497,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 		return;
 	}
 
-	sta = peer->sta;
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
index f3a5e054d2b5..92c4988df2f1 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -91,5 +91,31 @@ struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash
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
+				    peer->addr, peer->peer_id, peer->link_id,
+				    ahsta->links_map);
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


