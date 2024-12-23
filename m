Return-Path: <linux-wireless+bounces-16717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7649FAA26
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D816696C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395415B54C;
	Mon, 23 Dec 2024 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ncl0KM+w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B8185B5F
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933722; cv=none; b=hnYBhCeoux87QBVP9KjAzeyYzqTmz5OOjjmAPj/5BoGafzDNMGmSKgo8FWI+dLSO1wnvFuQaIyHTMmk3eyzG0PDDvhfhlLkMyjFPNFYgLBZgLhPBVOmK36+gtGQofd3Wwr63ZI8v79R8I8VXqI2sf8aQqihR2Rzv2aLTTS7y9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933722; c=relaxed/simple;
	bh=NtL1Smz3QFSFDgBMffMTo90KVwPvgNxqYO19rCBlFOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFSNeVqL9ZyLOePtsY34d2RqD1ENIeQZEsWRKb5wFzgACXcknbYPXJVmwNgbnLXVX+4QC03tpFGXR0vPVb5+s+0JYdg3AphmxIduzst3yUq+l2ZCzcUzv9C0gumOsoMKeI6mBi2QbtUOmt0tBsfIXQf8ruMMSKUekUzugTfzG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ncl0KM+w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN5aeI3030362;
	Mon, 23 Dec 2024 06:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oZCs3Pw3fj/n/ezD+6QTQS45nwypNvYHZzvAQC9crRY=; b=Ncl0KM+wsqeFfwb8
	Yl4rdNi1XR+vrX+OTZwjMrE39l9Pp6MkMqpCyrOo5GJIDbF0iut3tjzlvxCd6ZX7
	tX5aLE9BDDcYqAfU9NUl8afuzQmAd+PGADp+zqdyOB4fOz4m2L8yFLctV/yKS5aD
	l5wpYMKQ6BNQPunKt1fGTQEJv2dbiLQi+W7hsY1LmPzXsKtWXHucgJNM/k7HEnyZ
	CtpcjP79WiGQhCUN2Lnr/c08U6HxF6SxFJKpN6YgI0p3zaLCb42cHPWyiYFy2A31
	xHwJHcQfcTrDPrl0tootAKxtrsJrJUQ8ZLBRs3CLyAzy/TMInF8Chu16SfFp2QoV
	fpc5gw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q1v982mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN61vHp017451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:57 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 22:01:56 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2 05/14] wifi: ath12k: Restructure the code for monitor ring processing
Date: Mon, 23 Dec 2024 11:31:23 +0530
Message-ID: <20241223060132.3506372-6-quic_ppranees@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NaSoYKsiMsspO7CC-8oABYOitrAJ4Ocj
X-Proofpoint-GUID: NaSoYKsiMsspO7CC-8oABYOitrAJ4Ocj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230051

Currently, monitor ring reaping and processing occur in the same loop,
which requires holding ring locks until skb processing is complete.
However, only the ring reaping part requires the ring lock; the skb
processing part does not need it. This approach is problematic because it
unnecessarily extends the duration for which the ring locks are held,
leading to increased contention and potential backpressure issues.
Fix it by holding ring locks only during the reaping phase, as skb
processing does not require them. First, reap the monitor destination ring
with the ring lock and queue the skbs into an skb list. Then, process the
skbs in this list in a separate loop without holding the ring lock.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h     |   1 -
 drivers/net/wireless/ath/ath12k/dp_mon.c | 116 +++++++++++++----------
 2 files changed, 64 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 787e8e20658f..07bad88552c7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -125,7 +125,6 @@ struct ath12k_mon_data {
 	struct sk_buff_head rx_status_q;
 	struct dp_mon_mpdu *mon_mpdu;
 	struct list_head dp_rx_mon_mpdu_list;
-	struct sk_buff *dest_skb_q[DP_MON_MAX_STATUS_BUF];
 	struct dp_mon_tx_ppdu_info *tx_prot_ppdu_info;
 	struct dp_mon_tx_ppdu_info *tx_data_ppdu_info;
 };
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 08f92e74fede..f9fd28ce801a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1188,14 +1188,11 @@ static enum hal_rx_mon_status
 ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 			    struct sk_buff *skb)
 {
-	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	struct hal_tlv_64_hdr *tlv;
 	enum hal_rx_mon_status hal_status;
 	u16 tlv_tag, tlv_len;
 	u8 *ptr = skb->data;
 
-	memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info));
-
 	do {
 		tlv = (struct hal_tlv_64_hdr *)ptr;
 		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
@@ -2305,6 +2302,13 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k *ar,
 		ath12k_dp_mon_rx_update_user_stats(ar, ppdu_info, i);
 }
 
+static void
+ath12k_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	memset(ppdu_info, 0, sizeof(*ppdu_info));
+	ppdu_info->peer_id = HAL_INVALID_PEERID;
+}
+
 int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 			       struct napi_struct *napi)
 {
@@ -2322,13 +2326,13 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	struct ath12k_sta *ahsta = NULL;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_peer *peer;
+	struct sk_buff_head skb_list;
 	u64 cookie;
 	int num_buffs_reaped = 0, srng_id, buf_id;
-	u8 dest_idx = 0, i;
-	bool end_of_ppdu;
-	u32 hal_status;
+	u32 hal_status, end_offset, info0;
 	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, ar->pdev_idx);
 
+	__skb_queue_head_init(&skb_list);
 	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, pdev_idx);
 	mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
 	buf_ring = &dp->rxdma_mon_buf_ring;
@@ -2342,6 +2346,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
 		if (unlikely(!mon_dst_desc))
 			break;
+
 		cookie = le32_to_cpu(mon_dst_desc->cookie);
 		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
@@ -2359,55 +2364,19 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		dma_unmap_single(ab->dev, rxcb->paddr,
 				 skb->len + skb_tailroom(skb),
 				 DMA_FROM_DEVICE);
-		pmon->dest_skb_q[dest_idx] = skb;
-		dest_idx++;
-		end_of_ppdu = le32_get_bits(mon_dst_desc->info0,
-					    HAL_MON_DEST_INFO0_END_OF_PPDU);
-		if (!end_of_ppdu)
-			continue;
-
-		for (i = 0; i < dest_idx; i++) {
-			skb = pmon->dest_skb_q[i];
-			hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
-
-			if (ppdu_info->peer_id == HAL_INVALID_PEERID ||
-			    hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
-				dev_kfree_skb_any(skb);
-				continue;
-			}
-
-			rcu_read_lock();
-			spin_lock_bh(&ab->base_lock);
-			peer = ath12k_peer_find_by_id(ab, ppdu_info->peer_id);
-			if (!peer || !peer->sta) {
-				ath12k_dbg(ab, ATH12K_DBG_DATA,
-					   "failed to find the peer with peer_id %d\n",
-					   ppdu_info->peer_id);
-				spin_unlock_bh(&ab->base_lock);
-				rcu_read_unlock();
-				dev_kfree_skb_any(skb);
-				continue;
-			}
-
-			if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-				ahsta = ath12k_sta_to_ahsta(peer->sta);
-				arsta = &ahsta->deflink;
-				ath12k_dp_mon_rx_update_peer_su_stats(ar, arsta,
-								      ppdu_info);
-			} else if ((ppdu_info->fc_valid) &&
-				   (ppdu_info->ast_index != HAL_AST_IDX_INVALID)) {
-				ath12k_dp_mon_rx_process_ulofdma(ppdu_info);
-				ath12k_dp_mon_rx_update_peer_mu_stats(ar, ppdu_info);
-			}
 
-			spin_unlock_bh(&ab->base_lock);
-			rcu_read_unlock();
-			dev_kfree_skb_any(skb);
-			memset(ppdu_info, 0, sizeof(*ppdu_info));
-			ppdu_info->peer_id = HAL_INVALID_PEERID;
+		end_offset = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_OFFSET);
+		if (likely(end_offset <= DP_RX_BUFFER_SIZE)) {
+			skb_put(skb, end_offset);
+		} else {
+			ath12k_warn(ab,
+				    "invalid offset on mon stats destination %u\n",
+				    end_offset);
+			skb_put(skb, DP_RX_BUFFER_SIZE);
 		}
 
-		dest_idx = 0;
+		__skb_queue_tail(&skb_list, skb);
+
 move_next:
 		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
 		ath12k_hal_srng_src_get_next_entry(ab, srng);
@@ -2416,6 +2385,49 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 
 	ath12k_hal_srng_access_end(ab, srng);
 	spin_unlock_bh(&srng->lock);
+
+	if (!num_buffs_reaped)
+		return 0;
+
+	while ((skb = __skb_dequeue(&skb_list))) {
+		hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
+		if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
+			dev_kfree_skb_any(skb);
+			continue;
+		}
+
+		if (ppdu_info->peer_id == HAL_INVALID_PEERID)
+			goto free_skb;
+
+		rcu_read_lock();
+		spin_lock_bh(&ab->base_lock);
+		peer = ath12k_peer_find_by_id(ab, ppdu_info->peer_id);
+		if (!peer || !peer->sta) {
+			ath12k_dbg(ab, ATH12K_DBG_DATA,
+				   "failed to find the peer with monitor peer_id %d\n",
+				   ppdu_info->peer_id);
+			goto next_skb;
+		}
+
+		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
+			ahsta = ath12k_sta_to_ahsta(peer->sta);
+			arsta = &ahsta->deflink;
+			ath12k_dp_mon_rx_update_peer_su_stats(ar, arsta,
+							      ppdu_info);
+		} else if ((ppdu_info->fc_valid) &&
+			   (ppdu_info->ast_index != HAL_AST_IDX_INVALID)) {
+			ath12k_dp_mon_rx_process_ulofdma(ppdu_info);
+			ath12k_dp_mon_rx_update_peer_mu_stats(ar, ppdu_info);
+		}
+
+next_skb:
+		spin_unlock_bh(&ab->base_lock);
+		rcu_read_unlock();
+free_skb:
+		dev_kfree_skb_any(skb);
+		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
+	}
+
 	return num_buffs_reaped;
 }
 
-- 
2.34.1


