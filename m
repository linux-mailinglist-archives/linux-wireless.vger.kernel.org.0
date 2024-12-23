Return-Path: <linux-wireless+bounces-16716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E09FAA1F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4141B18853A6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3F14EC7E;
	Mon, 23 Dec 2024 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C/Oy0aPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E61148FF9
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933720; cv=none; b=F16z122hJDn9gWd1QuYq3CDV+zB7M9mhWUAp2lDa2Xk1Cgv8z0mmnb8nodwI0HHgcqA1J9L+tb4vhlh3OOmvmq5pm47MfkR/It+dqVp4Ww6Mb7dCrIHobHf9l/kNCN2q3GSh5KGCa4Vw97MBjaM8VZR1LWM6xWN2C2nnrzXgUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933720; c=relaxed/simple;
	bh=984xzupa2H14mu4EuKSZmHhypmyR1tqa9KxriesvLu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9AB4ndcKqHyvxEqyMZyLmfsjQw+Qj2sT0P5usb30NKoq1zX0MeUnfWTb7M5jVpalPPZXuIgju33fTyEvo3wqQwy1kXJdjzDltDY3QMk4xNippqqt2dUrJTl91DtbsfMwbE/hx7ZtqrM4AucdDFSZ2f32zJUK+ji07UsSrH/6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C/Oy0aPI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BMMPBHS028828;
	Mon, 23 Dec 2024 06:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cAIrZT8g9syoizujVZE6+SeJPZZ9GwhI3SiYpOPIZV0=; b=C/Oy0aPIwtYVYPm3
	yx7uGi5ldJT7eKrz1fffpMNmICXoBTtGh6VOf1J8vTxgnT9obDLjbJ95ujaEkT+A
	j/Nk8AonRLLGa8tFgpWbwjnQv/oXpYt6bf7+BCalSHY8ZQIHXP7EJEb0r8azZ/JR
	o4XdfokHQ3drSiwPrgtrFPEDaKTYhLXYa4LF54pzl4gtIgIBxiM6JsbqXRC2K7ZV
	mfkaFJBd69dW/i6gA0qXbiWBH3x7Px40UycNZnV6+8B5TvX0l8fZvCU3vFlXINhp
	Y+2N8BeNVVmHtYPgA6JSqtmesRMisf1aeazMTLyOlztgMTNX6AS7WHGMMIJIpOPM
	Mp6Q9w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ptdnh9db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN61tNF023860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:56 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 22:01:54 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2 04/14] wifi: ath12k: Avoid code duplication in monitor ring processing
Date: Mon, 23 Dec 2024 11:31:22 +0530
Message-ID: <20241223060132.3506372-5-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
References: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-GUID: 75F2ZWyHIykvQ3-SdKnyjn1gM4JLhSj1
X-Proofpoint-ORIG-GUID: 75F2ZWyHIykvQ3-SdKnyjn1gM4JLhSj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=835 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230052

The current implementation processes the monitor destination ring using
two separate functions, ath12k_dp_mon_srng_process() for standalone
monitor mode and ath12k_dp_mon_rx_process_stats() for statistics.
However, both functions contain same code which performs monitor ring
reaping and skb data processing. To eliminate redundancy, remove the
duplicate code and use a single function to handle both the cases.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 126 ++---------------------
 drivers/net/wireless/ath/ath12k/dp_mon.h |   6 +-
 2 files changed, 9 insertions(+), 123 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 53f8e8f8959a..08f92e74fede 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2000,116 +2000,6 @@ ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
 	return tlv_status;
 }
 
-int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
-			       enum dp_monitor_mode monitor_mode,
-			       struct napi_struct *napi)
-{
-	struct hal_mon_dest_desc *mon_dst_desc;
-	struct ath12k_pdev_dp *pdev_dp = &ar->dp;
-	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&pdev_dp->mon_data;
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
-	struct sk_buff *skb;
-	struct ath12k_skb_rxcb *rxcb;
-	struct dp_srng *mon_dst_ring;
-	struct hal_srng *srng;
-	struct dp_rxdma_mon_ring *buf_ring;
-	u64 cookie;
-	u32 ppdu_id;
-	int num_buffs_reaped = 0, srng_id, buf_id;
-	u8 dest_idx = 0, i;
-	bool end_of_ppdu;
-	struct hal_rx_mon_ppdu_info *ppdu_info;
-	struct ath12k_peer *peer = NULL;
-	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, ar->pdev_idx);
-
-	ppdu_info = &pmon->mon_ppdu_info;
-	memset(ppdu_info, 0, sizeof(*ppdu_info));
-	ppdu_info->peer_id = HAL_INVALID_PEERID;
-
-	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, pdev_idx);
-
-	if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE) {
-		mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
-		buf_ring = &dp->rxdma_mon_buf_ring;
-	} else {
-		return 0;
-	}
-
-	srng = &ab->hal.srng_list[mon_dst_ring->ring_id];
-
-	spin_lock_bh(&srng->lock);
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	while (likely(*budget)) {
-		*budget -= 1;
-		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
-		if (unlikely(!mon_dst_desc))
-			break;
-
-		cookie = le32_to_cpu(mon_dst_desc->cookie);
-		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
-
-		spin_lock_bh(&buf_ring->idr_lock);
-		skb = idr_remove(&buf_ring->bufs_idr, buf_id);
-		spin_unlock_bh(&buf_ring->idr_lock);
-
-		if (unlikely(!skb)) {
-			ath12k_warn(ab, "monitor destination with invalid buf_id %d\n",
-				    buf_id);
-			goto move_next;
-		}
-
-		rxcb = ATH12K_SKB_RXCB(skb);
-		dma_unmap_single(ab->dev, rxcb->paddr,
-				 skb->len + skb_tailroom(skb),
-				 DMA_FROM_DEVICE);
-
-		pmon->dest_skb_q[dest_idx] = skb;
-		dest_idx++;
-		ppdu_id = le32_to_cpu(mon_dst_desc->ppdu_id);
-		end_of_ppdu = le32_get_bits(mon_dst_desc->info0,
-					    HAL_MON_DEST_INFO0_END_OF_PPDU);
-		if (!end_of_ppdu)
-			continue;
-
-		for (i = 0; i < dest_idx; i++) {
-			skb = pmon->dest_skb_q[i];
-
-			if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
-				ath12k_dp_mon_rx_parse_mon_status(ar, pmon,
-								  skb, napi);
-			else
-				ath12k_dp_mon_tx_parse_mon_status(ar, pmon,
-								  skb, napi, ppdu_id);
-
-			peer = ath12k_peer_find_by_id(ab, ppdu_info->peer_id);
-
-			if (!peer || !peer->sta) {
-				ath12k_dbg(ab, ATH12K_DBG_DATA,
-					   "failed to find the peer with peer_id %d\n",
-					   ppdu_info->peer_id);
-				dev_kfree_skb_any(skb);
-				continue;
-			}
-
-			dev_kfree_skb_any(skb);
-			pmon->dest_skb_q[i] = NULL;
-		}
-
-		dest_idx = 0;
-move_next:
-		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-		ath12k_hal_srng_src_get_next_entry(ab, srng);
-		num_buffs_reaped++;
-	}
-
-	ath12k_hal_srng_access_end(ab, srng);
-	spin_unlock_bh(&srng->lock);
-
-	return num_buffs_reaped;
-}
-
 static void
 ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_stats,
 					      struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -2415,8 +2305,8 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k *ar,
 		ath12k_dp_mon_rx_update_user_stats(ar, ppdu_info, i);
 }
 
-int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
-				   struct napi_struct *napi, int *budget)
+int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
+			       struct napi_struct *napi)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev_dp *pdev_dp = &ar->dp;
@@ -2437,8 +2327,9 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 	u8 dest_idx = 0, i;
 	bool end_of_ppdu;
 	u32 hal_status;
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, ar->pdev_idx);
 
-	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, mac_id);
+	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, pdev_idx);
 	mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
 	buf_ring = &dp->rxdma_mon_buf_ring;
 
@@ -2535,11 +2426,10 @@ int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 	struct ath12k *ar = ath12k_ab_to_ar(ab, mac_id);
 	int num_buffs_reaped = 0;
 
-	if (!ar->monitor_started)
-		ath12k_dp_mon_rx_process_stats(ar, mac_id, napi, &budget);
-	else
-		num_buffs_reaped = ath12k_dp_mon_srng_process(ar, &budget,
-							      monitor_mode, napi);
+	if (ab->hw_params->rxdma1_enable) {
+		if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
+			num_buffs_reaped = ath12k_dp_mon_srng_process(ar, &budget, napi);
+	}
 
 	return num_buffs_reaped;
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 64c959c36459..e4368eb42aca 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -82,9 +82,6 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_mon_ring *buf_ring,
 				int req_entries);
-int ath12k_dp_mon_srng_process(struct ath12k *ar,
-			       int *budget, enum dp_monitor_mode monitor_mode,
-			       struct napi_struct *napi);
 int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 			       struct napi_struct *napi, int budget,
 			       enum dp_monitor_mode monitor_mode);
@@ -100,6 +97,5 @@ ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
 				  struct napi_struct *napi,
 				  u32 ppdu_id);
 void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info);
-int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
-				   struct napi_struct *napi, int *budget);
+int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget, struct napi_struct *napi);
 #endif
-- 
2.34.1


