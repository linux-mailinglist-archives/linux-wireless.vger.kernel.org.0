Return-Path: <linux-wireless+bounces-6943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BE08B471C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427EF282518
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA62224D1;
	Sat, 27 Apr 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UhuIdZ9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B61E521
	for <linux-wireless@vger.kernel.org>; Sat, 27 Apr 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714235235; cv=none; b=Uom5BLJtfp346V1i46PiwyLd7GqrS8pEtmQpA4RwULVb2lY8MS8Zw+KVLEO/i4gG3O7m+7RAS11N/xjJ3lCpY3YoHQNDNyMOmSzIkpU8aKNUDsY0wKcVuK/DFCGs/G5R+Awqxb8NHjf0or8nWNC0R+e5YZmyOauySYvgciUq4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714235235; c=relaxed/simple;
	bh=+rcsPMOFnXMh8zTI8UVjS0IHriISX1ADKisFdmalMtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6rOIIHDuFPFhirwNvzanH4Yn0dhJO6YLLDtKNJt1gF/9J09pZRXB082GO4cHCAZrPh4hdTFbMzkYopHfK0FNOPJbf+4YRseg6Df0I5jcqAuybvhFb4DVGidk3Y9rQnPgAI5bP622w1+M99x1ZfKIOzSfOuaKRfvLeHkxBjFgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UhuIdZ9+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43RGR6jG027565;
	Sat, 27 Apr 2024 16:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cAEv4E5uWobac9rUW6g3pE131QXvissN59LGzUwtkZU=; b=Uh
	uIdZ9+RWWM65Dnl5UVc6E5urrswLpZ8FY6GHKkTTlpiFsCyVagKk5LMkd3M0A06D
	EaOJNHaX9HHEbrE/DBoE1AYqjq0mhSWtI0CmDHArQRkPoHpCcxCzfRG10IHvy7Q6
	z2XZDdO1ITCp08o5OPQr8BKH6MC3BtHXvf78K5WFxodwaZscs53EBPcm/SSS2BY2
	Sw9DrSWg3DTsL/t1HZwybASPRtB1RG6p1vRk+jQklzi/24VJAybEkz7kRLGQpKMi
	e2NNJT8edIhxkRYrHgC9nWc0NtoSt/EODT4x+du7nSQNSJN6GY4Uv/L6UgMYT4d8
	zhZXvtFBEC7keMTjyjlg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrtht8ksc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:27:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43RGR5Oh016987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:27:05 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 27 Apr 2024 09:27:03 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv2 2/3] wifi: ath12k: Remove unsupported tx monitor handling
Date: Sat, 27 Apr 2024 21:56:43 +0530
Message-ID: <20240427162644.2470886-3-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
References: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2HUTMirwy9H1WAQdvWWm_LNLhTOOlhal
X-Proofpoint-GUID: 2HUTMirwy9H1WAQdvWWm_LNLhTOOlhal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404270120

Currently tx monitor is not supported in driver.So remove
the tx monitor ring configuration, allocation and handling.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ------------------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 42 ------------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
 4 files changed, 1 insertion(+), 138 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 6b0b72477540..5c6749bc4039 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1903,43 +1903,6 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	}
 
-	case HAL_MON_BUF_ADDR: {
-		struct dp_rxdma_mon_ring *buf_ring = &ab->dp.tx_mon_buf_ring;
-		struct dp_mon_packet_info *packet_info =
-			(struct dp_mon_packet_info *)tlv_data;
-		int buf_id = u32_get_bits(packet_info->cookie,
-					  DP_RXDMA_BUF_COOKIE_BUF_ID);
-		struct sk_buff *msdu;
-		struct dp_mon_mpdu *mon_mpdu = tx_ppdu_info->tx_mon_mpdu;
-		struct ath12k_skb_rxcb *rxcb;
-
-		spin_lock_bh(&buf_ring->idr_lock);
-		msdu = idr_remove(&buf_ring->bufs_idr, buf_id);
-		spin_unlock_bh(&buf_ring->idr_lock);
-
-		if (unlikely(!msdu)) {
-			ath12k_warn(ab, "monitor destination with invalid buf_id %d\n",
-				    buf_id);
-			return DP_MON_TX_STATUS_PPDU_NOT_DONE;
-		}
-
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(ab->dev, rxcb->paddr,
-				 msdu->len + skb_tailroom(msdu),
-				 DMA_FROM_DEVICE);
-
-		if (!mon_mpdu->head)
-			mon_mpdu->head = msdu;
-		else if (mon_mpdu->tail)
-			mon_mpdu->tail->next = msdu;
-
-		mon_mpdu->tail = msdu;
-
-		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-		status = DP_MON_TX_BUFFER_ADDR;
-		break;
-	}
-
 	case HAL_TX_MPDU_END:
 		list_add_tail(&tx_ppdu_info->tx_mon_mpdu->list,
 			      &tx_ppdu_info->dp_tx_mon_mpdu_list);
@@ -2088,8 +2051,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
 		mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
 		buf_ring = &dp->rxdma_mon_buf_ring;
 	} else {
-		mon_dst_ring = &pdev_dp->tx_mon_dst_ring[srng_id];
-		buf_ring = &dp->tx_mon_buf_ring;
+		return 0;
 	}
 
 	srng = &ab->hal.srng_list[mon_dst_ring->ring_id];
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 75df622f25d8..ada7bc8719b7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -422,8 +422,6 @@ static int ath12k_dp_rxdma_buf_free(struct ath12k_base *ab)
 
 	ath12k_dp_rxdma_mon_buf_ring_free(ab, &dp->rxdma_mon_buf_ring);
 
-	ath12k_dp_rxdma_mon_buf_ring_free(ab, &dp->tx_mon_buf_ring);
-
 	return 0;
 }
 
@@ -476,15 +474,6 @@ static int ath12k_dp_rxdma_buf_setup(struct ath12k_base *ab)
 				    "failed to setup HAL_RXDMA_MONITOR_BUF\n");
 			return ret;
 		}
-
-		ret = ath12k_dp_rxdma_mon_ring_buf_setup(ab,
-							 &dp->tx_mon_buf_ring,
-							 HAL_TX_MONITOR_BUF);
-		if (ret) {
-			ath12k_warn(ab,
-				    "failed to setup HAL_TX_MONITOR_BUF\n");
-			return ret;
-		}
 	}
 
 	return 0;
@@ -498,7 +487,6 @@ static void ath12k_dp_rx_pdev_srng_free(struct ath12k *ar)
 
 	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
 		ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_dst_ring[i]);
-		ath12k_dp_srng_cleanup(ab, &dp->tx_mon_dst_ring[i]);
 	}
 }
 
@@ -554,17 +542,6 @@ static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
 				    "failed to setup HAL_RXDMA_MONITOR_DST\n");
 			return ret;
 		}
-
-		ret = ath12k_dp_srng_setup(ar->ab,
-					   &dp->tx_mon_dst_ring[i],
-					   HAL_TX_MONITOR_DST,
-					   0, mac_id + i,
-					   DP_TX_MONITOR_DEST_RING_SIZE);
-		if (ret) {
-			ath12k_warn(ar->ab,
-				    "failed to setup HAL_TX_MONITOR_DST\n");
-			return ret;
-		}
 	}
 
 	return 0;
@@ -3970,7 +3947,6 @@ void ath12k_dp_rx_free(struct ath12k_base *ab)
 		ath12k_dp_srng_cleanup(ab, &dp->rxdma_err_dst_ring[i]);
 
 	ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_buf_ring.refill_buf_ring);
-	ath12k_dp_srng_cleanup(ab, &dp->tx_mon_buf_ring.refill_buf_ring);
 
 	ath12k_dp_rxdma_buf_free(ab);
 }
@@ -4113,15 +4089,6 @@ int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 				    ret);
 			return ret;
 		}
-
-		ring_id = dp->tx_mon_buf_ring.refill_buf_ring.ring_id;
-		ret = ath12k_dp_tx_htt_srng_setup(ab, ring_id,
-						  0, HAL_TX_MONITOR_BUF);
-		if (ret) {
-			ath12k_warn(ab, "failed to configure rxdma_mon_buf_ring %d\n",
-				    ret);
-			return ret;
-		}
 	}
 
 	ret = ab->hw_params->hw_ops->rxdma_ring_sel_config(ab);
@@ -4141,9 +4108,6 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 	idr_init(&dp->rxdma_mon_buf_ring.bufs_idr);
 	spin_lock_init(&dp->rxdma_mon_buf_ring.idr_lock);
 
-	idr_init(&dp->tx_mon_buf_ring.bufs_idr);
-	spin_lock_init(&dp->tx_mon_buf_ring.idr_lock);
-
 	ret = ath12k_dp_srng_setup(ab,
 				   &dp->rx_refill_buf_ring.refill_buf_ring,
 				   HAL_RXDMA_BUF, 0, 0,
@@ -4186,15 +4150,6 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 			ath12k_warn(ab, "failed to setup HAL_RXDMA_MONITOR_BUF\n");
 			return ret;
 		}
-
-		ret = ath12k_dp_srng_setup(ab,
-					   &dp->tx_mon_buf_ring.refill_buf_ring,
-					   HAL_TX_MONITOR_BUF, 0, 0,
-					   DP_TX_MONITOR_BUF_RING_SIZE);
-		if (ret) {
-			ath12k_warn(ab, "failed to setup DP_TX_MONITOR_BUF_RING_SIZE\n");
-			return ret;
-		}
 	}
 
 	ret = ath12k_dp_rxdma_buf_setup(ab);
@@ -4234,17 +4189,6 @@ int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int mac_id)
 				    i, ret);
 			return ret;
 		}
-
-		ring_id = dp->tx_mon_dst_ring[i].ring_id;
-		ret = ath12k_dp_tx_htt_srng_setup(ab, ring_id,
-						  mac_id + i,
-						  HAL_TX_MONITOR_DST);
-		if (ret) {
-			ath12k_warn(ab,
-				    "failed to configure tx_mon_dst_ring %d %d\n",
-				    i, ret);
-			return ret;
-		}
 	}
 out:
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 2fb9fc42db11..a9534d31a8b4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -669,14 +669,6 @@ ath12k_dp_tx_get_ring_id_type(struct ath12k_base *ab,
 		*htt_ring_id = HTT_RXDMA_MONITOR_DESC_RING;
 		*htt_ring_type = HTT_SW_TO_HW_RING;
 		break;
-	case HAL_TX_MONITOR_BUF:
-		*htt_ring_id = HTT_TX_MON_HOST2MON_BUF_RING;
-		*htt_ring_type = HTT_SW_TO_HW_RING;
-		break;
-	case HAL_TX_MONITOR_DST:
-		*htt_ring_id = HTT_TX_MON_MON2HOST_DEST_RING;
-		*htt_ring_type = HTT_HW_TO_SW_RING;
-		break;
 	default:
 		ath12k_warn(ab, "Unsupported ring type in DP :%d\n", ring_type);
 		ret = -EINVAL;
@@ -1050,12 +1042,6 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 		return ret;
 	}
 
-	ret = ath12k_dp_tx_htt_tx_monitor_mode_ring_config(ar, reset);
-	if (ret) {
-		ath12k_err(ab, "failed to setup rx monitor filter %d\n", ret);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -1209,31 +1195,3 @@ int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 	dev_kfree_skb_any(skb);
 	return ret;
 }
-
-int ath12k_dp_tx_htt_tx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
-	struct htt_tx_ring_tlv_filter tlv_filter = {0};
-	int ret, ring_id;
-
-	ring_id = dp->tx_mon_buf_ring.refill_buf_ring.ring_id;
-
-	/* TODO: Need to set upstream/downstream tlv filters
-	 * here
-	 */
-
-	if (ab->hw_params->rxdma1_enable) {
-		ret = ath12k_dp_tx_htt_tx_filter_setup(ar->ab, ring_id, 0,
-						       HAL_TX_MONITOR_BUF,
-						       DP_RXDMA_REFILL_RING_SIZE,
-						       &tlv_filter);
-		if (ret) {
-			ath12k_err(ab,
-				   "failed to setup filter for monitor buf %d\n", ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 436d77e5e9ee..5f2fa3b69577 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -36,6 +36,5 @@ int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 				     int mac_id, enum hal_ring_type ring_type,
 				     int tx_buf_size,
 				     struct htt_tx_ring_tlv_filter *htt_tlv_filter);
-int ath12k_dp_tx_htt_tx_monitor_mode_ring_config(struct ath12k *ar, bool reset);
 int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset);
 #endif
-- 
2.34.1


