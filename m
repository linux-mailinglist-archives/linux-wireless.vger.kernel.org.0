Return-Path: <linux-wireless+bounces-7036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E158B6DF9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 11:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229281F21FCB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C70127B5C;
	Tue, 30 Apr 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="prPl7owW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB9127E31
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468490; cv=none; b=Wb2yFJuN2ufLf2/TzUhD1IIDx0m9YQUUOPt4TxuNTIqnk2i8XVO66/x5DzwetwBikWdzy9AqiSvC1VmakkiDBLvRPJaWUiaZ2xdh5gJHs6qTBNh9R5P5bmcld9hfh0Eg0TmHata9RIPRGEF1YbAHhrOzgJl8ykYbnoDGxhl7OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468490; c=relaxed/simple;
	bh=PphCMz0gKBzcXrW4W1iFea404JV4xzUZq3pRglgYXa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOsjdnYV2/SUWfRewtD0P/Qwrnkac2KrI/l9uyqS2zcXLNAKn0VGqLKXiITOXfN26Z0oMYDni0z7wGdlsUCEzJBD3aVQvLiAguWrNyHzxcDtrVK3tvbEHjhzPAAAluLQig4cKOCXaq1vrh4lRed23KIYtkkEs92driVV9so39pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=prPl7owW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U698Pf000493;
	Tue, 30 Apr 2024 09:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=sXFj0drRKTRyFubfU0EANUuJWowbc6wj1djpe3GAVgM=; b=pr
	Pl7owWF79/ohzUqiXhXcNVhwOR8ZhbDm70bdcMXO65OKQcxn+S+6nGTWto4UJBU7
	CvK51yPt7lYbGAOA2ITS/sEhW/Ts8etGnQVrwUlRq8Lr+j88edhhtoqqWDqAWAOM
	d2T330uKci7TDcnZGnPLF+XpMugpxOymICiCpTz+543qOuSfsztTyLbq1QCsQMbY
	hQQXqqDzCb81sx1ai0uIjxnaVtEy6lNxw9aRvjZ4g10R0YTfYHDyeuQf+F5yo0o2
	lKcn2oAFftqWHg7HgaaGnJATFXmTDOZKShASzZEAVu1GtI2ht1VDb5dFqKu34GSx
	xsvaUYn+IU1vedRZYX3w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtd8kkygg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 09:14:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U9EYfY018960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 09:14:34 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 02:14:32 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv4 2/3] wifi: ath12k: Remove unsupported tx monitor handling
Date: Tue, 30 Apr 2024 14:44:13 +0530
Message-ID: <20240430091414.2486196-3-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430091414.2486196-1-quic_tamizhr@quicinc.com>
References: <20240430091414.2486196-1-quic_tamizhr@quicinc.com>
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
X-Proofpoint-GUID: vl1OZrqg6lvf5B94xntvy6VNW8o7gQft
X-Proofpoint-ORIG-GUID: vl1OZrqg6lvf5B94xntvy6VNW8o7gQft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300066

Currently tx monitor is not supported in driver.So remove
the tx monitor ring configuration, allocation and handling.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +---------------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 59 +-----------------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 42 -----------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  3 +-
 4 files changed, 3 insertions(+), 141 deletions(-)

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
index 75df622f25d8..a69520d11cb0 100644
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
@@ -496,10 +485,8 @@ static void ath12k_dp_rx_pdev_srng_free(struct ath12k *ar)
 	struct ath12k_base *ab = ar->ab;
 	int i;
 
-	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++)
 		ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_dst_ring[i]);
-		ath12k_dp_srng_cleanup(ab, &dp->tx_mon_dst_ring[i]);
-	}
 }
 
 void ath12k_dp_rx_pdev_reo_cleanup(struct ath12k_base *ab)
@@ -554,17 +541,6 @@ static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
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
@@ -3970,7 +3946,6 @@ void ath12k_dp_rx_free(struct ath12k_base *ab)
 		ath12k_dp_srng_cleanup(ab, &dp->rxdma_err_dst_ring[i]);
 
 	ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_buf_ring.refill_buf_ring);
-	ath12k_dp_srng_cleanup(ab, &dp->tx_mon_buf_ring.refill_buf_ring);
 
 	ath12k_dp_rxdma_buf_free(ab);
 }
@@ -4113,15 +4088,6 @@ int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
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
@@ -4141,9 +4107,6 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 	idr_init(&dp->rxdma_mon_buf_ring.bufs_idr);
 	spin_lock_init(&dp->rxdma_mon_buf_ring.idr_lock);
 
-	idr_init(&dp->tx_mon_buf_ring.bufs_idr);
-	spin_lock_init(&dp->tx_mon_buf_ring.idr_lock);
-
 	ret = ath12k_dp_srng_setup(ab,
 				   &dp->rx_refill_buf_ring.refill_buf_ring,
 				   HAL_RXDMA_BUF, 0, 0,
@@ -4186,15 +4149,6 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
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
@@ -4234,17 +4188,6 @@ int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int mac_id)
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
index d002de0fd5a1..c8393f002d8e 100644
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
@@ -1044,12 +1036,6 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 	struct ath12k_base *ab = ar->ab;
 	int ret;
 
-	ret = ath12k_dp_tx_htt_tx_monitor_mode_ring_config(ar, reset);
-	if (ret) {
-		ath12k_err(ab, "failed to setup tx monitor filter %d\n", ret);
-		return ret;
-	}
-
 	ret = ath12k_dp_tx_htt_rx_monitor_mode_ring_config(ar, reset);
 	if (ret) {
 		ath12k_err(ab, "failed to setup rx monitor filter %d\n", ret);
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
index 436d77e5e9ee..7faa81faf6a7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_TX_H
@@ -36,6 +36,5 @@ int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 				     int mac_id, enum hal_ring_type ring_type,
 				     int tx_buf_size,
 				     struct htt_tx_ring_tlv_filter *htt_tlv_filter);
-int ath12k_dp_tx_htt_tx_monitor_mode_ring_config(struct ath12k *ar, bool reset);
 int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset);
 #endif
-- 
2.34.1


