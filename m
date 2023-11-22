Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C47F3E48
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjKVGkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjKVGkF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:40:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA71AC
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:40:01 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM60eRa019653;
        Wed, 22 Nov 2023 06:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JdunudyRW2xJ1sG3xusZYhtBJmoZL/ieQ7rQwh3QgyE=;
 b=NdHjvZRSND0kvuZQC+Dfp9XWJtuOPrFRBafrcjVM5mx2tnmXJT9gMxDrb7JTejEn1o5x
 GbZVGOAku/MTIs19QcRY77mRgzPY6ZqQ5bSSgXqwYkCmw6mv8ekGTd623f0erAlb41Bj
 UwTwcmIVa3+LzLAzyN202yZr3AJ6C2QgjIRyphWZiE6jolmV9YTY2Toy1HskSrKB4aU/
 X8YudYPwaUwgZ72cbs2r54ca64QBn+xFcVFOXHCDrZ5xNh2b2Hu4lejQ6iych3gqXdA6
 oMUlu26Mp6ubYc3PNIVYelgQWaQrrVU35RMYM6xe2FufX0l6fY0J0ZJLfyDKvSLxY7tH mQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh8mw8evr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM6duOm030422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:56 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 22:39:54 -0800
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: Remove unsupported tx monitor handling
Date:   Wed, 22 Nov 2023 12:09:31 +0530
Message-ID: <20231122063932.10321-3-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
References: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y8JGC6jxK3Hq_-SBvoQX0XIji9PJBvL-
X-Proofpoint-ORIG-GUID: y8JGC6jxK3Hq_-SBvoQX0XIji9PJBvL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently tx monitor is not supported in driver. So remove
the tx monitor ring configuration, allocation and handling.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 57 ------------------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 41 -----------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
 4 files changed, 1 insertion(+), 138 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f44bc5494ce7..bb898c8f17d2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1901,43 +1901,6 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	}
 
-	case HAL_MON_BUF_ADDR: {
-		struct dp_rxdma_ring *buf_ring = &ab->dp.tx_mon_buf_ring;
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
@@ -2086,8 +2049,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
 		mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
 		buf_ring = &dp->rxdma_mon_buf_ring;
 	} else {
-		mon_dst_ring = &pdev_dp->tx_mon_dst_ring[srng_id];
-		buf_ring = &dp->tx_mon_buf_ring;
+		return 0;
 	}
 
 	srng = &ab->hal.srng_list[mon_dst_ring->ring_id];
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9f831e3971f9..b4b156aea391 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -418,9 +418,6 @@ static int ath12k_dp_rxdma_buf_free(struct ath12k_base *ab)
 	rx_ring = &dp->rxdma_mon_buf_ring;
 	ath12k_dp_rxdma_buf_ring_free(ab, rx_ring);
 
-	rx_ring = &dp->tx_mon_buf_ring;
-	ath12k_dp_rxdma_buf_ring_free(ab, rx_ring);
-
 	return 0;
 }
 
@@ -466,15 +463,6 @@ static int ath12k_dp_rxdma_buf_setup(struct ath12k_base *ab)
 				    "failed to setup HAL_RXDMA_MONITOR_BUF\n");
 			return ret;
 		}
-
-		rx_ring = &dp->tx_mon_buf_ring;
-		ret = ath12k_dp_rxdma_ring_buf_setup(ab, rx_ring,
-						     HAL_TX_MONITOR_BUF);
-		if (ret) {
-			ath12k_warn(ab,
-				    "failed to setup HAL_TX_MONITOR_BUF\n");
-			return ret;
-		}
 	}
 
 	return 0;
@@ -488,7 +476,6 @@ static void ath12k_dp_rx_pdev_srng_free(struct ath12k *ar)
 
 	for (i = 0; i < ab->hw_params->num_rxmda_per_pdev; i++) {
 		ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_dst_ring[i]);
-		ath12k_dp_srng_cleanup(ab, &dp->tx_mon_dst_ring[i]);
 	}
 }
 
@@ -544,17 +531,6 @@ static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
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
@@ -3925,7 +3901,6 @@ void ath12k_dp_rx_free(struct ath12k_base *ab)
 		ath12k_dp_srng_cleanup(ab, &dp->rxdma_err_dst_ring[i]);
 
 	ath12k_dp_srng_cleanup(ab, &dp->rxdma_mon_buf_ring.refill_buf_ring);
-	ath12k_dp_srng_cleanup(ab, &dp->tx_mon_buf_ring.refill_buf_ring);
 
 	ath12k_dp_rxdma_buf_free(ab);
 }
@@ -4062,15 +4037,6 @@ int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
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
@@ -4093,9 +4059,6 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 	idr_init(&dp->rxdma_mon_buf_ring.bufs_idr);
 	spin_lock_init(&dp->rxdma_mon_buf_ring.idr_lock);
 
-	idr_init(&dp->tx_mon_buf_ring.bufs_idr);
-	spin_lock_init(&dp->tx_mon_buf_ring.idr_lock);
-
 	ret = ath12k_dp_srng_setup(ab,
 				   &dp->rx_refill_buf_ring.refill_buf_ring,
 				   HAL_RXDMA_BUF, 0, 0,
@@ -4138,15 +4101,6 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
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
@@ -4186,17 +4140,6 @@ int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int mac_id)
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
index 8b5ca90d4f17..71b8fce29d2c 100644
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
@@ -1024,12 +1016,6 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
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
@@ -1190,30 +1176,3 @@ int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 	return ret;
 }
 
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
2.17.1

