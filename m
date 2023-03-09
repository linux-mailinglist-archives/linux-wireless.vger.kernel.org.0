Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9215F6B2B3F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 17:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCIQyo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 11:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCIQyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 11:54:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED38012848
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 08:44:47 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329C5utn027764;
        Thu, 9 Mar 2023 16:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=EAShPzONb0Brlo2Ny/sSxCn8fDGjSyCbwb1fOLzs3js=;
 b=QIKS5ltK4IBhYpnYvGhA5mWJCt723eyenWPsQfQDLza7i4J+9W3U7qoMzMWrSVnEj8/W
 R3s3gKYt2P10hlqqZNHiiq4T0DuXcR+QuKPCwYvw1UEJGQMgcPqG4cojHxYtgL+5y1hq
 LqT0ucMBL8CgiK4im71fFqugcULChzOarP9b8Kl/IAoZPJwLkPWJQg/oAgQbFXtGNVIy
 V0iNFDxXX2syTR2qLkTgClQZs17dfusIwWQdgqb17hdfKFz/WGLVdSnbaT56AAYDDj8O
 hi61K4/nm/w5JDnyiACqS//3N5GvVSEVPe0cS18781LjsgHyuA2ckSNontTVZ/GVNDNX 1w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7bvk1cur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 16:44:40 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 329GeM90010035;
        Thu, 9 Mar 2023 16:44:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 3p785p6u9f-1;
        Thu, 09 Mar 2023 16:44:39 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329GfEAL011094;
        Thu, 9 Mar 2023 16:44:39 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 329Gickh015003;
        Thu, 09 Mar 2023 16:44:39 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 49037B003A1; Thu,  9 Mar 2023 22:14:37 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix BUFFER_DONE read on monitor ring rx  buffer
Date:   Thu,  9 Mar 2023 22:14:34 +0530
Message-Id: <20230309164434.32660-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L99mi1qiUR3FvoGu847nKpU_eNBS2Aou
X-Proofpoint-ORIG-GUID: L99mi1qiUR3FvoGu847nKpU_eNBS2Aou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_08,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxlogscore=907 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090134
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Perform dma_sync_single_for_cpu() on monitor ring rx buffer before
reading BUFFER_DONE tag and do dma_unmap_single() only after device
had set BUFFER_DONE tag to the buffer.

Also when BUFFER_DONE tag is not set, allow the buffer to get read
next time without freeing skb.

This helps to fix AP+Monitor VAP with flood traffic scenario to see
monitor ring rx buffer overrun missing BUFFER_DONE tag to be set.

Also remove redundant rx dma buf free performed on DP
rx_mon_status_refill_ring.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 56 ++++++++++---------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index b65a84a88264..1d0739866a71 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -435,7 +435,6 @@ int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 static int ath11k_dp_rxdma_buf_ring_free(struct ath11k *ar,
 					 struct dp_rxdma_ring *rx_ring)
 {
-	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct sk_buff *skb;
 	int buf_id;
 
@@ -453,28 +452,6 @@ static int ath11k_dp_rxdma_buf_ring_free(struct ath11k *ar,
 	idr_destroy(&rx_ring->bufs_idr);
 	spin_unlock_bh(&rx_ring->idr_lock);
 
-	/* if rxdma1_enable is false, mon_status_refill_ring
-	 * isn't setup, so don't clean.
-	 */
-	if (!ar->ab->hw_params.rxdma1_enable)
-		return 0;
-
-	rx_ring = &dp->rx_mon_status_refill_ring[0];
-
-	spin_lock_bh(&rx_ring->idr_lock);
-	idr_for_each_entry(&rx_ring->bufs_idr, skb, buf_id) {
-		idr_remove(&rx_ring->bufs_idr, buf_id);
-		/* XXX: Understand where internal driver does this dma_unmap
-		 * of rxdma_buffer.
-		 */
-		dma_unmap_single(ar->ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
-				 skb->len + skb_tailroom(skb), DMA_BIDIRECTIONAL);
-		dev_kfree_skb_any(skb);
-	}
-
-	idr_destroy(&rx_ring->bufs_idr);
-	spin_unlock_bh(&rx_ring->idr_lock);
-
 	return 0;
 }
 
@@ -3029,39 +3006,52 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 
 			spin_lock_bh(&rx_ring->idr_lock);
 			skb = idr_find(&rx_ring->bufs_idr, buf_id);
+			spin_unlock_bh(&rx_ring->idr_lock);
+
 			if (!skb) {
 				ath11k_warn(ab, "rx monitor status with invalid buf_id %d\n",
 					    buf_id);
-				spin_unlock_bh(&rx_ring->idr_lock);
 				pmon->buf_state = DP_MON_STATUS_REPLINISH;
 				goto move_next;
 			}
 
-			idr_remove(&rx_ring->bufs_idr, buf_id);
-			spin_unlock_bh(&rx_ring->idr_lock);
 
 			rxcb = ATH11K_SKB_RXCB(skb);
 
-			dma_unmap_single(ab->dev, rxcb->paddr,
-					 skb->len + skb_tailroom(skb),
-					 DMA_FROM_DEVICE);
+			dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
+						skb->len + skb_tailroom(skb),
+						DMA_FROM_DEVICE);
 
 			tlv = (struct hal_tlv_hdr *)skb->data;
 			if (FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl) !=
 					HAL_RX_STATUS_BUFFER_DONE) {
-				ath11k_warn(ab, "mon status DONE not set %lx\n",
+				ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
 					    FIELD_GET(HAL_TLV_HDR_TAG,
-						      tlv->tl));
-				dev_kfree_skb_any(skb);
+						      tlv->tl), buf_id);
+				/* If done status is missing, hold onto status
+				 * ring until status is done for this status
+				 * ring buffer.
+				 * Keep HP in mon_status_ring unchanged,
+				 * and break from here.
+				 * Check status for same buffer for next time
+				 */
 				pmon->buf_state = DP_MON_STATUS_NO_DMA;
-				goto move_next;
+				break;
 			}
 
+			spin_lock_bh(&rx_ring->idr_lock);
+			idr_remove(&rx_ring->bufs_idr, buf_id);
+			spin_unlock_bh(&rx_ring->idr_lock);
 			if (ab->hw_params.full_monitor_mode) {
 				ath11k_dp_rx_mon_update_status_buf_state(pmon, tlv);
 				if (paddr == pmon->mon_status_paddr)
 					pmon->buf_state = DP_MON_STATUS_MATCH;
 			}
+
+			dma_unmap_single(ab->dev, rxcb->paddr,
+					 skb->len + skb_tailroom(skb),
+					 DMA_FROM_DEVICE);
+
 			__skb_queue_tail(skb_list, skb);
 		} else {
 			pmon->buf_state = DP_MON_STATUS_REPLINISH;
-- 
2.17.1

