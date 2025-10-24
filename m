Return-Path: <linux-wireless+bounces-28231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B3DC07B26
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DDB3A6816
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C3926AA93;
	Fri, 24 Oct 2025 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QMwuPMbC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF42580D1
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329780; cv=none; b=kRo84x+Q74/Cxm5R58FfMVqyr3K6u5UGPkI/Hf6OViRZz+DRSWMyP2wTLu6cgv0EZfDzacYD4ih9zUhe4ya0/YK4J+2rY3Zz/BEd6M8yP09c7wWh7Kn6XMqT6Kjx4KQmFzuSNBd2crgi3qp8VhlxiV2GYx8eCt+QXuSgGJRhRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329780; c=relaxed/simple;
	bh=YqgFT9Cq0BcaaRfMOSWbCORu7vm8oAQl5T8dq2lWjAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2EWK0uu0TDWoqaLi+0k3HsUxwDSU+OVVm3B+Hz6xNAOw9QoTQcmbQrZyx2OLtTMKYkpghEENfe7vZAGXrrSR8tBJ2MHjT7GtZxzkHwxt2XqiTfTm4Qrf4SQwU2eqcDPxN0zS2Ce4l4C+N/R3ZXCfPrD3cRoLEb9hGGkeae5Pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QMwuPMbC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9hWj021391;
	Fri, 24 Oct 2025 18:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lrNVdMZEe9ZbxEbZeIsPviD8koEZZCXa9IqCOSGaOjQ=; b=QMwuPMbCf1JhpL1H
	xOuIPJg+QI3J5jtuTugZ5DtNQ6mRHZY9/H/dprCEeUtmR6xpfU8u+RWwHroJgDMD
	L4qbQNe/AcIyQueKsAX+bgHSeRDY6krwrdAUZA4mi4J/Aj/1abMcSeT66Y8uo8ET
	zmUX9FBeJ8TGcj0Zaftm/FNMw67sRsVz2+kL8+UQ4+Z6cYm8RjK8qAvvnYpYMrlA
	lGBjDoBoT+f53cUfFo22dIskfIoRYrSgNqQQbaq45gjg2KhKpnLYP3EPZE+mB6PF
	EQfkQEH7S/PEh3jVVyakPAmV9DPV6DTRMtFz8PuJEQqtkTrI465LbSHvP7iwa1R4
	1/wLYg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pw4ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIG9PY009721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:09 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:07 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 2/9] wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
Date: Fri, 24 Oct 2025 23:45:41 +0530
Message-ID: <20251024181548.3255166-3-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
References: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX165Bvv6tCPTc
 58vVWXd0bEKBxGpWBSrKWNExQCWPgVdyR3WeJS+BwJ1BOQm89rTb0HqNOHMhtSzF+T3roxKS08a
 4ORTL2tKj8XqB9Vxkk3Bm0O+CRvQflTeIAm9CTOiPWJFunBN7AxCRXBP4rt1Xs7QaACl2YU7Gp3
 eJ3oX1oxI6maPPsKgJArrVkwuIbz+BioI09mFXMQqoVu2ApyQHprfokp7UezsXN8fuigDlho4BH
 dWtrkIKwJ+qB4EvdB5Jp7hkgmLINYwto3tADcqMVUPnBriQrlq6meFgxDpwOGNUTQ+ouSwc1b0M
 JItKOJ8A7jewBJIRhf4elo2ksdj3gLixvQ9wwSu7YVSAm4ESeceUhVgmI5gMRCwalN+Ewnw6M0m
 TViMym7ITnRn5AGws2BH4QIZWBBQSQ==
X-Proofpoint-GUID: lDcg2UFLsLx3CsxG7tHvVYkBWv2AmQ4A
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fbc26a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=Iwk81yimAAAA:8 a=vjkW6uPWAAAA:8 a=yRE9onPqaRuFeknre9EA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=PqBb7rsBcpu_OT3Qf5tX:22 a=FTqP262Ndm71lHIshRHN:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cLTQeHM41iufidK-p70C:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: lDcg2UFLsLx3CsxG7tHvVYkBWv2AmQ4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

Rename ath12k_peer to ath12k_dp_link_peer for all instances and rename the
following find APIs accordingly to reflect the API names as per the structural
name change.

APIs renamed:
  ath12k_peer_find()
  ath12k_peer_find_by_pdev_idx()
  ath12k_peer_find_by_addr()
  ath12k_peer_find_by_ml_id()
  ath12k_peer_find_by_id()
  ath12k_peer_find_by_ast()
  ath12k_peer_exist_by_vdev_id()
  ath12k_peer_get_link_sta()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c          |  8 +--
 drivers/net/wireless/ath/ath12k/dp.h          |  2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.c      | 28 ++++----
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 16 ++---
 drivers/net/wireless/ath/ath12k/dp_peer.c     | 64 ++++++++++---------
 drivers/net/wireless/ath/ath12k/dp_peer.h     | 34 +++++-----
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 35 +++++-----
 drivers/net/wireless/ath/ath12k/dp_rx.h       | 10 +--
 drivers/net/wireless/ath/ath12k/mac.c         | 48 ++++++++------
 drivers/net/wireless/ath/ath12k/peer.c        | 22 ++++---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 18 +++---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  4 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 12 ++--
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  4 +-
 15 files changed, 163 insertions(+), 144 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 98a1c879605a..945e4965a437 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -23,12 +23,12 @@ enum ath12k_dp_desc_type {
 void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	/* TODO: Any other peer specific DP cleanup */
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find(ab, vdev_id, addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, addr);
 	if (!peer) {
 		ath12k_warn(ab, "failed to lookup peer %pM on vdev %d\n",
 			    addr, vdev_id);
@@ -50,7 +50,7 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	u32 reo_dest;
 	int ret = 0, tid;
 
@@ -89,7 +89,7 @@ int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
 peer_clean:
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find(ab, vdev_id, addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, addr);
 	if (!peer) {
 		ath12k_warn(ab, "failed to find the peer to del rx tid\n");
 		spin_unlock_bh(&ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 8e7e4a7b582b..5cedc6603e74 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -14,7 +14,7 @@
 #define MAX_RXDMA_PER_PDEV     2
 
 struct ath12k_base;
-struct ath12k_peer;
+struct ath12k_dp_link_peer;
 struct ath12k_dp;
 struct ath12k_vif;
 struct ath12k_link_vif;
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 1a0d3e4ac8bb..cae5a90c1c65 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -188,7 +188,7 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_link_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
 	struct ath12k_per_peer_tx_stats *peer_stats = &dp_pdev->peer_tx_stats;
@@ -273,7 +273,7 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 
 	rcu_read_lock();
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, usr_stats->peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(ab, usr_stats->peer_id);
 
 	if (!peer || !peer->sta) {
 		spin_unlock_bh(&ab->base_lock);
@@ -281,7 +281,7 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 		return;
 	}
 
-	arsta = ath12k_peer_get_link_sta(ab, peer);
+	arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
 	if (!arsta) {
 		spin_unlock_bh(&ab->base_lock);
 		rcu_read_unlock();
@@ -403,7 +403,7 @@ struct htt_ppdu_stats_info *ath12k_dp_htt_get_ppdu_desc(struct ath12k_pdev_dp *d
 	return ppdu_info;
 }
 
-static void ath12k_copy_to_delay_stats(struct ath12k_peer *peer,
+static void ath12k_copy_to_delay_stats(struct ath12k_dp_link_peer *peer,
 				       struct htt_ppdu_user_stats *usr_stats)
 {
 	peer->ppdu_stats_delayba.sw_peer_id = le16_to_cpu(usr_stats->rate.sw_peer_id);
@@ -418,7 +418,7 @@ static void ath12k_copy_to_delay_stats(struct ath12k_peer *peer,
 	peer->delayba_flag = true;
 }
 
-static void ath12k_copy_to_bar(struct ath12k_peer *peer,
+static void ath12k_copy_to_bar(struct ath12k_dp_link_peer *peer,
 			       struct htt_ppdu_user_stats *usr_stats)
 {
 	usr_stats->rate.sw_peer_id = cpu_to_le16(peer->ppdu_stats_delayba.sw_peer_id);
@@ -439,7 +439,7 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_htt_ppdu_stats_msg *msg;
 	struct htt_ppdu_stats_info *ppdu_info;
-	struct ath12k_peer *peer = NULL;
+	struct ath12k_dp_link_peer *peer = NULL;
 	struct htt_ppdu_user_stats *usr_stats = NULL;
 	u32 peer_id = 0;
 	struct ath12k_pdev_dp *dp_pdev;
@@ -508,7 +508,7 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 		for (i = 0; i < ppdu_info->ppdu_stats.common.num_users; i++) {
 			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
 			spin_lock_bh(&ab->base_lock);
-			peer = ath12k_peer_find_by_id(ab, peer_id);
+			peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
 			if (!peer) {
 				spin_unlock_bh(&ab->base_lock);
 				continue;
@@ -527,7 +527,7 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 		for (i = 0; i < ppdu_info->bar_num_users; i++) {
 			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
 			spin_lock_bh(&ab->base_lock);
-			peer = ath12k_peer_find_by_id(ab, peer_id);
+			peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
 			if (!peer) {
 				spin_unlock_bh(&ab->base_lock);
 				continue;
@@ -623,7 +623,7 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
 		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
 				       peer_mac_h16, mac_addr);
-		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, 0, 0);
+		ath12k_dp_link_peer_map_event(ab, vdev_id, peer_id, mac_addr, 0, 0);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_MAP2:
 		vdev_id = le32_get_bits(resp->peer_map_ev.info,
@@ -638,8 +638,8 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 					 HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL);
 		hw_peer_id = le32_get_bits(resp->peer_map_ev.info1,
 					   HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID);
-		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
-				      hw_peer_id);
+		ath12k_dp_link_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
+					      hw_peer_id);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_MAP3:
 		vdev_id = le32_get_bits(resp->peer_map_ev.info,
@@ -654,14 +654,14 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 					 HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL);
 		hw_peer_id = le32_get_bits(resp->peer_map_ev.info2,
 					   HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID);
-		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
-				      hw_peer_id);
+		ath12k_dp_link_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
+					      hw_peer_id);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_UNMAP:
 	case HTT_T2H_MSG_TYPE_PEER_UNMAP2:
 		peer_id = le32_get_bits(resp->peer_unmap_ev.info,
 					HTT_T2H_PEER_UNMAP_INFO_PEER_ID);
-		ath12k_peer_unmap_event(ab, peer_id);
+		ath12k_dp_link_peer_unmap_event(ab, peer_id);
 		break;
 	case HTT_T2H_MSG_TYPE_PPDU_STATS_IND:
 		ath12k_htt_pull_ppdu_stats(ab, skb);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index aa45550301ed..9da9fc403315 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2269,7 +2269,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_radiotap_he *he = NULL;
 	struct ieee80211_sta *pubsta = NULL;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct hal_rx_desc_data rx_info;
 	bool is_mcbc = rxcb->is_mcbc;
@@ -2289,7 +2289,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 
 	spin_lock_bh(&ab->base_lock);
 	rx_info.addr2_present = false;
-	peer = ath12k_dp_rx_h_find_peer(ab, msdu, &rx_info);
+	peer = ath12k_dp_rx_h_find_link_peer(ab, msdu, &rx_info);
 	if (peer && peer->sta) {
 		pubsta = peer->sta;
 		if (pubsta->valid_links) {
@@ -3637,13 +3637,13 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 	struct ath12k_link_sta *arsta;
 	struct ath12k_rx_peer_stats *rx_stats = NULL;
 	struct hal_rx_user_status *user_stats = &ppdu_info->userstats[uid];
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	u32 num_msdu;
 
 	if (user_stats->ast_index == 0 || user_stats->ast_index == 0xFFFF)
 		return;
 
-	peer = ath12k_peer_find_by_ast(ab, user_stats->ast_index);
+	peer = ath12k_dp_link_peer_find_by_ast(ab, user_stats->ast_index);
 
 	if (!peer) {
 		ath12k_warn(ab, "peer ast idx %d can't be found\n",
@@ -3651,7 +3651,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 		return;
 	}
 
-	arsta = ath12k_peer_get_link_sta(ab, peer);
+	arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
 	if (!arsta) {
 		ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
 			    peer->addr, peer->peer_id);
@@ -3770,7 +3770,7 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 	struct hal_srng *srng;
 	struct dp_rxdma_mon_ring *buf_ring;
 	struct ath12k_link_sta *arsta;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct sk_buff_head skb_list;
 	u64 cookie;
 	int num_buffs_reaped = 0, srng_id, buf_id;
@@ -3885,7 +3885,7 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 
 		rcu_read_lock();
 		spin_lock_bh(&ab->base_lock);
-		peer = ath12k_peer_find_by_id(ab, ppdu_info->peer_id);
+		peer = ath12k_dp_link_peer_find_by_id(ab, ppdu_info->peer_id);
 		if (!peer || !peer->sta) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "failed to find the peer with monitor peer_id %d\n",
@@ -3894,7 +3894,7 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 		}
 
 		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-			arsta = ath12k_peer_get_link_sta(ab, peer);
+			arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
 			if (!arsta) {
 				ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
 					    peer->addr, peer->peer_id);
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index e32d3ea76a6f..843369a00d3e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -8,10 +8,11 @@
 #include "dp_peer.h"
 #include "debug.h"
 
-struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
-				     const u8 *addr)
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_base *ab,
+					  int vdev_id, const u8 *addr)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
@@ -27,10 +28,11 @@ struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
 	return NULL;
 }
 
-struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
-						 u8 pdev_idx, const u8 *addr)
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_base *ab, u8 pdev_idx,
+					  const u8 *addr)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
@@ -46,10 +48,10 @@ struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
 	return NULL;
 }
 
-struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
-					     const u8 *addr)
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_addr(struct ath12k_base *ab, const u8 *addr)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
@@ -62,12 +64,12 @@ struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
 
 	return NULL;
 }
-EXPORT_SYMBOL(ath12k_peer_find_by_addr);
+EXPORT_SYMBOL(ath12k_dp_link_peer_find_by_addr);
 
-static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
-						     int ml_peer_id)
+static struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_ml_id(struct ath12k_base *ab, int ml_peer_id)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
@@ -78,10 +80,10 @@ static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
 	return NULL;
 }
 
-struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
-					   int peer_id)
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_id(struct ath12k_base *ab, int peer_id)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
@@ -89,7 +91,7 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 		return NULL;
 
 	if (peer_id & ATH12K_PEER_ML_ID_VALID)
-		return ath12k_peer_find_by_ml_id(ab, peer_id);
+		return ath12k_dp_link_peer_find_by_ml_id(ab, peer_id);
 
 	list_for_each_entry(peer, &ab->peers, list)
 		if (peer_id == peer->peer_id)
@@ -98,9 +100,9 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 	return NULL;
 }
 
-bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id)
+bool ath12k_dp_link_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	spin_lock_bh(&ab->base_lock);
 
@@ -114,10 +116,10 @@ bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id)
 	return false;
 }
 
-struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab,
-					    int ast_hash)
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_ast(struct ath12k_base *ab, int ast_hash)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
@@ -128,13 +130,13 @@ struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab,
 	return NULL;
 }
 
-void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
+void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find_by_id(ab, peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
 	if (!peer) {
 		ath12k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
 			    peer_id);
@@ -152,13 +154,13 @@ void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 	spin_unlock_bh(&ab->base_lock);
 }
 
-void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
-			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id)
+void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
+				   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find(ab, vdev_id, mac_addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, mac_addr);
 	if (!peer) {
 		peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
 		if (!peer)
@@ -180,8 +182,8 @@ void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
 	spin_unlock_bh(&ab->base_lock);
 }
 
-struct ath12k_link_sta *ath12k_peer_get_link_sta(struct ath12k_base *ab,
-						 struct ath12k_peer *peer)
+struct ath12k_link_sta *ath12k_dp_link_peer_to_link_sta(struct ath12k_base *ab,
+							struct ath12k_dp_link_peer *peer)
 {
 	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index 19f01d69e5d3..aec73d8e35ce 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -21,7 +21,7 @@ struct ppdu_user_delayba {
 
 #define ATH12K_PEER_ML_ID_VALID         BIT(13)
 
-struct ath12k_peer {
+struct ath12k_dp_link_peer {
 	struct list_head list;
 	struct ieee80211_sta *sta;
 	int vdev_id;
@@ -65,18 +65,22 @@ struct ath12k_peer {
 	bool ucast_ra_only;
 };
 
-void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
-void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
-			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
-struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
-				     const u8 *addr);
-struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
-					     const u8 *addr);
-struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab, int peer_id);
-bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
-struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
-struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
-						 u8 pdev_idx, const u8 *addr);
-struct ath12k_link_sta *ath12k_peer_get_link_sta(struct ath12k_base *ab,
-						 struct ath12k_peer *peer);
+void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
+void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
+				   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_base *ab,
+					  int vdev_id, const u8 *addr);
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_addr(struct ath12k_base *ab, const u8 *addr);
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_id(struct ath12k_base *ab, int peer_id);
+bool ath12k_dp_link_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_base *ab, u8 pdev_idx,
+					  const u8 *addr);
+struct ath12k_link_sta *ath12k_dp_link_peer_to_link_sta(struct ath12k_base *ab,
+							struct ath12k_dp_link_peer *peer);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 8e342ad4d678..f6d800c1ebf9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -471,7 +471,7 @@ void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 	__skb_queue_purge(&rx_tid->rx_frags);
 }
 
-void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_peer *peer)
+void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_dp_link_peer *peer)
 {
 	struct ath12k_dp_rx_tid *rx_tid;
 	int i;
@@ -496,7 +496,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_sta *ahsta;
 	struct ath12k_dp_rx_tid *rx_tid;
 	dma_addr_t paddr_aligned;
@@ -504,7 +504,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find(ab, vdev_id, peer_mac);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, peer_mac);
 	if (!peer) {
 		spin_unlock_bh(&ab->base_lock);
 		ath12k_warn(ab, "failed to find the peer to set up rx tid\n");
@@ -626,7 +626,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 			    u8 link_id)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(params->sta);
 	struct ath12k_link_sta *arsta;
 	int vdev_id;
@@ -644,7 +644,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find(ab, vdev_id, arsta->addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, arsta->addr);
 	if (!peer) {
 		spin_unlock_bh(&ab->base_lock);
 		ath12k_warn(ab, "failed to find the peer to stop rx aggregation\n");
@@ -677,7 +677,7 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hal_reo_cmd cmd = {};
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	u8 tid;
 	int ret = 0;
@@ -691,7 +691,8 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find(ab, arvif->vdev_id, peer_addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id,
+							 peer_addr);
 	if (!peer) {
 		spin_unlock_bh(&ab->base_lock);
 		ath12k_warn(ab, "failed to find the peer %pM to configure pn replay detection\n",
@@ -1036,23 +1037,23 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 	}
 }
 
-struct ath12k_peer *
-ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
-			 struct hal_rx_desc_data *rx_info)
+struct ath12k_dp_link_peer *
+ath12k_dp_rx_h_find_link_peer(struct ath12k_base *ab, struct sk_buff *msdu,
+			      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct ath12k_peer *peer = NULL;
+	struct ath12k_dp_link_peer *peer = NULL;
 
 	lockdep_assert_held(&ab->base_lock);
 
 	if (rxcb->peer_id)
-		peer = ath12k_peer_find_by_id(ab, rxcb->peer_id);
+		peer = ath12k_dp_link_peer_find_by_id(ab, rxcb->peer_id);
 
 	if (peer)
 		return peer;
 
 	if (rx_info->addr2_present)
-		peer = ath12k_peer_find_by_addr(ab, rx_info->addr2);
+		peer = ath12k_dp_link_peer_find_by_addr(ab, rx_info->addr2);
 
 	return peer;
 }
@@ -1195,7 +1196,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	struct ath12k_base *ab = dp->ab;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_sta *pubsta;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status *status = rx_info->rx_status;
 	u8 decap = rx_info->decap_type;
@@ -1203,7 +1204,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	bool is_eapol = rxcb->is_eapol;
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_rx_h_find_peer(ab, msdu, rx_info);
+	peer = ath12k_dp_rx_h_find_link_peer(ab, msdu, rx_info);
 
 	pubsta = peer ? peer->sta : NULL;
 
@@ -1324,7 +1325,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 {
 	struct ath12k_base *ab = ar->ab;
 	struct crypto_shash *tfm;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	int i;
 
@@ -1334,7 +1335,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find(ab, vdev_id, peer_mac);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, peer_mac);
 	if (!peer) {
 		spin_unlock_bh(&ab->base_lock);
 		crypto_free_shash(tfm);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 27062109a3f3..b45097855620 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -206,9 +206,9 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 				       const u8 *peer_addr,
 				       enum set_key_cmd key_cmd,
 				       struct ieee80211_key_conf *key);
-void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_peer *peer);
+void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_dp_link_peer *peer);
 void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
-				  struct ath12k_peer *peer, u8 tid);
+				  struct ath12k_dp_link_peer *peer, u8 tid);
 int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
 				u8 tid, u32 ba_win_sz, u16 ssn,
 				enum hal_pn_type pn_type);
@@ -229,9 +229,9 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 
 u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 			struct hal_rx_desc *desc);
-struct ath12k_peer *
-ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
-			 struct hal_rx_desc_data *rx_info);
+struct ath12k_dp_link_peer *
+ath12k_dp_rx_h_find_link_peer(struct ath12k_base *ab, struct sk_buff *msdu,
+			      struct hal_rx_desc_data *rx_info);
 u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ebe7aba92ecc..64609fffa7ce 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1147,7 +1147,7 @@ static int ath12k_mac_set_kickout(struct ath12k_link_vif *arvif)
 
 void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 {
-	struct ath12k_peer *peer, *tmp;
+	struct ath12k_dp_link_peer *peer, *tmp;
 	struct ath12k_base *ab = ar->ab;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -3610,7 +3610,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	struct ath12k_link_sta *arsta;
 	struct ieee80211_sta *ap_sta;
 	struct ath12k_sta *ahsta;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	bool is_auth = false;
 	u32 hemode = 0;
 	int ret;
@@ -3727,7 +3727,8 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arvif->bssid);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+							 arvif->bssid);
 	if (peer && peer->is_authorized)
 		is_auth = true;
 
@@ -5436,7 +5437,7 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	int first_errno = 0;
 	int ret;
 	int i;
@@ -5445,7 +5446,7 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find(ab, arvif->vdev_id, addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id, addr);
 	spin_unlock_bh(&ab->base_lock);
 
 	if (!peer)
@@ -5480,7 +5481,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 {
 	struct ieee80211_sta *sta = NULL;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_sta *ahsta;
 	const u8 *peer_addr;
 	int ret;
@@ -5505,7 +5506,8 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	 * we already hold wiphy lock. we just make sure its there now.
 	 */
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find(ab, arvif->vdev_id, peer_addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id,
+							 peer_addr);
 	spin_unlock_bh(&ab->base_lock);
 
 	if (!peer) {
@@ -5539,7 +5541,8 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	}
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find(ab, arvif->vdev_id, peer_addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id,
+							 peer_addr);
 	if (peer && cmd == SET_KEY) {
 		peer->keys[key->keyidx] = key;
 		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
@@ -6246,7 +6249,7 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -6254,7 +6257,8 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+							 arsta->addr);
 	if (peer && peer->sta == sta) {
 		ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
 			    vif->addr, arvif->vdev_id);
@@ -6274,14 +6278,15 @@ static int ath12k_mac_station_unauthorize(struct ath12k *ar,
 					  struct ath12k_link_vif *arvif,
 					  struct ath12k_link_sta *arsta)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+							 arsta->addr);
 	if (peer)
 		peer->is_authorized = false;
 
@@ -6307,7 +6312,7 @@ static int ath12k_mac_station_authorize(struct ath12k *ar,
 					struct ath12k_link_vif *arvif,
 					struct ath12k_link_sta *arsta)
 {
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	int ret;
 
@@ -6315,7 +6320,8 @@ static int ath12k_mac_station_authorize(struct ath12k *ar,
 
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+							 arsta->addr);
 	if (peer)
 		peer->is_authorized = true;
 
@@ -7184,7 +7190,7 @@ void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_link_sta *arsta;
 	struct ath12k_link_vif *arvif;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	u32 bw, smps;
 
 	rcu_read_lock();
@@ -7207,7 +7213,8 @@ void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 	}
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+							 arsta->addr);
 	if (!peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
 		rcu_read_unlock();
@@ -8835,7 +8842,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	struct sk_buff *msdu_copied;
 	struct ath12k *ar, *tmp_ar;
 	struct ath12k_pdev_dp *dp_pdev, *tmp_dp_pdev;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	unsigned long links_map;
 	bool is_mcast = false;
 	bool is_dvlan = false;
@@ -8970,7 +8977,8 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 				goto skip_peer_find;
 
 			spin_lock_bh(&tmp_ar->ab->base_lock);
-			peer = ath12k_peer_find_by_addr(tmp_ar->ab, tmp_arvif->bssid);
+			peer = ath12k_dp_link_peer_find_by_addr(tmp_ar->ab,
+								tmp_arvif->bssid);
 			if (!peer) {
 				spin_unlock_bh(&tmp_ar->ab->base_lock);
 				ath12k_warn(tmp_ar->ab,
@@ -11571,7 +11579,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	if (ab->hw_params->vdev_start_delay &&
 	    ahvif->vdev_type != WMI_VDEV_TYPE_AP &&
 	    ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
-	    !ath12k_peer_exist_by_vdev_id(ab, arvif->vdev_id)) {
+	    !ath12k_dp_link_peer_exist_by_vdev_id(ab, arvif->vdev_id)) {
 		ret = 0;
 		goto out;
 	}
@@ -12288,7 +12296,7 @@ ath12k_mac_validate_fixed_rate_settings(struct ath12k *ar, enum nl80211_band ban
 	bool he_fixed_rate = false, vht_fixed_rate = false;
 	const u16 *vht_mcs_mask, *he_mcs_mask;
 	struct ieee80211_link_sta *link_sta;
-	struct ath12k_peer *peer, *tmp;
+	struct ath12k_dp_link_peer *peer, *tmp;
 	u8 vht_nss, he_nss;
 	int ret = true;
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 1e2526bb1186..16f4a74712d8 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -25,8 +25,8 @@ struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr)
 }
 EXPORT_SYMBOL(ath12k_peer_ml_find);
 
-static int ath12k_wait_for_peer_common(struct ath12k_base *ab, int vdev_id,
-				       const u8 *addr, bool expect_mapped)
+static int ath12k_wait_for_dp_link_peer_common(struct ath12k_base *ab, int vdev_id,
+					       const u8 *addr, bool expect_mapped)
 {
 	int ret;
 
@@ -34,7 +34,9 @@ static int ath12k_wait_for_peer_common(struct ath12k_base *ab, int vdev_id,
 				bool mapped;
 
 				spin_lock_bh(&ab->base_lock);
-				mapped = !!ath12k_peer_find(ab, vdev_id, addr);
+				mapped = !!ath12k_dp_link_peer_find_by_vdev_and_addr(ab,
+										vdev_id,
+										addr);
 				spin_unlock_bh(&ab->base_lock);
 
 				(mapped == expect_mapped ||
@@ -49,7 +51,7 @@ static int ath12k_wait_for_peer_common(struct ath12k_base *ab, int vdev_id,
 
 void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id)
 {
-	struct ath12k_peer *peer, *tmp;
+	struct ath12k_dp_link_peer *peer, *tmp;
 	struct ath12k_base *ab = ar->ab;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -72,7 +74,7 @@ void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id)
 
 static int ath12k_wait_for_peer_deleted(struct ath12k *ar, int vdev_id, const u8 *addr)
 {
-	return ath12k_wait_for_peer_common(ar->ab, vdev_id, addr, false);
+	return ath12k_wait_for_dp_link_peer_common(ar->ab, vdev_id, addr, false);
 }
 
 int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
@@ -138,7 +140,7 @@ int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
 
 static int ath12k_wait_for_peer_created(struct ath12k *ar, int vdev_id, const u8 *addr)
 {
-	return ath12k_wait_for_peer_common(ar->ab, vdev_id, addr, true);
+	return ath12k_wait_for_dp_link_peer_common(ar->ab, vdev_id, addr, true);
 }
 
 int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
@@ -150,7 +152,7 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	struct ath12k_dp_link_vif *dp_link_vif;
 	struct ath12k_link_sta *arsta;
 	u8 link_id = arvif->link_id;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_sta *ahsta;
 	u16 ml_peer_id;
 	int ret;
@@ -166,7 +168,8 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	}
 
 	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath12k_peer_find_by_pdev_idx(ar->ab, ar->pdev_idx, arg->peer_addr);
+	peer = ath12k_dp_link_peer_find_by_pdev_and_addr(ar->ab, ar->pdev_idx,
+							 arg->peer_addr);
 	if (peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
 		return -EINVAL;
@@ -188,7 +191,8 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	spin_lock_bh(&ar->ab->base_lock);
 
-	peer = ath12k_peer_find(ar->ab, arg->vdev_id, arg->peer_addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arg->vdev_id,
+							 arg->peer_addr);
 	if (!peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
 		ath12k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index eef8d2558494..4180db504c31 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -68,7 +68,7 @@ static void ath12k_wifi7_peer_rx_tid_qref_reset(struct ath12k_base *ab,
 }
 
 void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
-					struct ath12k_peer *peer, u8 tid)
+					struct ath12k_dp_link_peer *peer, u8 tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
 	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
@@ -179,7 +179,7 @@ int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab,
 }
 
 int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k *ar,
-					struct ath12k_peer *peer,
+					struct ath12k_dp_link_peer *peer,
 					struct ath12k_dp_rx_tid *rx_tid,
 					u32 ba_win_sz, u16 ssn,
 					bool update_ssn)
@@ -321,7 +321,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
 	struct ieee80211_hdr *hdr;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	u32 err_bitmap = rx_info->err_bitmap;
 
@@ -333,7 +333,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 		rxcb->peer_id = rx_info->peer_id;
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_rx_h_find_peer(ab, msdu, rx_info);
+	peer = ath12k_dp_rx_h_find_link_peer(ab, msdu, rx_info);
 	if (peer) {
 		/* resetting mcbc bit because mcbc packets are unicast
 		 * packets only for AP as STA sends unicast packets.
@@ -964,7 +964,7 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 }
 
 static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
-						struct ath12k_peer *peer,
+						struct ath12k_dp_link_peer *peer,
 						enum hal_encrypt_type enctype,
 						struct sk_buff *msdu,
 						struct hal_rx_desc_data *rx_info)
@@ -1033,7 +1033,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 }
 
 static int ath12k_wifi7_dp_rx_h_defrag(struct ath12k_pdev_dp *dp_pdev,
-				       struct ath12k_peer *peer,
+				       struct ath12k_dp_link_peer *peer,
 				       struct ath12k_dp_rx_tid *rx_tid,
 				       struct sk_buff **defrag_skb,
 				       enum hal_encrypt_type enctype,
@@ -1107,7 +1107,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	struct sk_buff *defrag_skb = NULL;
 	u32 peer_id = rx_info->peer_id;
@@ -1134,7 +1134,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 		return -EINVAL;
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
 	if (!peer) {
 		ath12k_warn(ab, "failed to find the peer to de-fragment received fragment peer_id %d\n",
 			    peer_id);
@@ -1197,7 +1197,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	timer_delete_sync(&rx_tid->frag_timer);
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find_by_id(ab, peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
 	if (!peer)
 		goto err_frags_cleanup;
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index df25164e08f2..f75588519cff 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -34,7 +34,7 @@ int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
 void ath12k_wifi7_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
 					 dma_addr_t paddr);
 void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
-					struct ath12k_peer *peer, u8 tid);
+					struct ath12k_dp_link_peer *peer, u8 tid);
 int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
 				 enum hal_reo_cmd_type type,
 				 struct ath12k_hal_reo_cmd *cmd,
@@ -43,7 +43,7 @@ int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid
 void ath12k_wifi7_dp_reo_cache_flush(struct ath12k_base *ab,
 				     struct ath12k_dp_rx_tid *rx_tid);
 int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k *ar,
-					struct ath12k_peer *peer,
+					struct ath12k_dp_link_peer *peer,
 					struct ath12k_dp_rx_tid *rx_tid,
 					u32 ba_win_sz, u16 ssn,
 					bool update_ssn);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 2f523ed00ded..3d06987cfc0e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -395,7 +395,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	struct sk_buff *msdu = desc_params->skb;
 	s32 noise_floor;
 	struct ieee80211_tx_status status = {};
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
@@ -449,7 +449,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	}
 	rcu_read_lock();
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DATA,
 			   "dp_tx: failed to find the peer with peer_id %d\n", peer_id);
@@ -518,7 +518,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ieee80211_sta *sta;
 	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
@@ -528,7 +528,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 	int ret;
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(ab, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 			   "failed to find the peer by id %u\n", ts->peer_id);
@@ -649,7 +649,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 	s32 noise_floor;
 	struct ieee80211_tx_status status = {};
 	struct ieee80211_rate_status status_rate = {};
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_sta *ahsta;
 	struct rate_info rate;
@@ -747,7 +747,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 	ath12k_wifi7_dp_tx_update_txcompl(dp_pdev, ts);
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(ab, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_err(ab,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 01c859f35a93..a3ea42fc0933 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -119,7 +119,7 @@ ath12k_wifi7_is_frame_link_agnostic_wcn7850(struct ath12k_link_vif *arvif,
 	__le16 fc = mgmt->frame_control;
 
 	spin_lock_bh(&ab->base_lock);
-	if (!ath12k_peer_find_by_addr(ab, mgmt->da) &&
+	if (!ath12k_dp_link_peer_find_by_addr(ab, mgmt->da) &&
 	    !ath12k_peer_ml_find(ah, mgmt->da)) {
 		spin_unlock_bh(&ab->base_lock);
 		return false;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d84a3762ca95..817f1c917320 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7202,7 +7202,7 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 {
 	struct wmi_peer_sta_kickout_arg arg = {};
 	struct ieee80211_sta *sta;
-	struct ath12k_peer *peer;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k *ar;
 
 	if (ath12k_pull_peer_sta_kickout_ev(ab, skb, &arg) != 0) {
@@ -7214,7 +7214,7 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_peer_find_by_addr(ab, arg.mac_addr);
+	peer = ath12k_dp_link_peer_find_by_addr(ab, arg.mac_addr);
 
 	if (!peer) {
 		ath12k_warn(ab, "peer not found %pM\n",
-- 
2.34.1


