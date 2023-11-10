Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BACA7E81DB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjKJSfh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbjKJSfC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:35:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08469005
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 00:13:42 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7iJxD016329;
        Fri, 10 Nov 2023 08:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6SwtnFo/CZ8Zi8axnPpg6znmsZnRXrE3zcZOY3F4IFM=;
 b=hu98IKQUdZw7aA5lY+p9nVUNw2aIbE56aQc0mZP7gqWS1MAq9SkJ58Lpq1EUt/U71JUP
 geWA6FtxpL1Mr7Pefz3a4g5XYbh55hHPfoaJQRiV1akfwYboVpeHHPMGLXlNSZC/N2S8
 wUNUJKS/1TmzzdIeCAioppW3gqfOJ4sO3VohaKG10/DEaCwWq0ABDJ/SJ5Q5XfINa3bF
 HOmMUeQ8FJll2fl5m/IdFkJfi73ZUL/U293Cz8DSzEhG84pCyQPdPgxfPsmKrRpA4/R5
 QdjpaAheTzPXyUTucdAzuLCUf5WF0vD34vyZtas5TOssT22GHu/GsYH0jDDBYTUtOxPC /w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93tq9kr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:13:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8DeGF021942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:13:40 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 00:13:38 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 3/4] wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
Date:   Fri, 10 Nov 2023 13:43:16 +0530
Message-ID: <20231110081317.19608-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231110081317.19608-1-quic_periyasa@quicinc.com>
References: <20231110081317.19608-1-quic_periyasa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IYtxxfztZTZuPnzvypb1SongWzCg-45d
X-Proofpoint-ORIG-GUID: IYtxxfztZTZuPnzvypb1SongWzCg-45d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=58 lowpriorityscore=0 mlxscore=58
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=-13
 spamscore=58 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently Rxdma replenish require HW conversion argument which is
unnecessary argument since ath12k driver configures the Rxdma only
in HW conversion. To optimize the rx data path per packet, avoid
the explicit unnecessary argument and condition check in the rx
replenish.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    |  3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 78 +++++++++----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h |  3 +-
 3 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index f3c48aa9f62d..26be6818f4ed 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -961,8 +961,7 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 		struct ath12k_dp *dp = &ab->dp;
 		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring, 0,
-					    true);
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring, 0);
 	}
 
 	/* TODO: Implement handler for other interrupts */
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 46fa8ee14b45..0c47a242cdd8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -258,15 +258,13 @@ static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
 /* Returns number of Rx buffers replenished */
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
-				int req_entries,
-				bool hw_cc)
+				int req_entries)
 {
 	struct ath12k_buffer_addr *desc;
 	struct hal_srng *srng;
 	struct sk_buff *skb;
 	int num_free;
 	int num_remain;
-	int buf_id;
 	u32 cookie;
 	dma_addr_t paddr;
 	struct ath12k_dp *dp = &ab->dp;
@@ -307,40 +305,29 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 		if (dma_mapping_error(ab->dev, paddr))
 			goto fail_free_skb;
 
-		if (hw_cc) {
-			spin_lock_bh(&dp->rx_desc_lock);
-
-			/* Get desc from free list and store in used list
-			 * for cleanup purposes
-			 *
-			 * TODO: pass the removed descs rather than
-			 * add/read to optimize
-			 */
-			rx_desc = list_first_entry_or_null(&dp->rx_desc_free_list,
-							   struct ath12k_rx_desc_info,
-							   list);
-			if (!rx_desc) {
-				spin_unlock_bh(&dp->rx_desc_lock);
-				goto fail_dma_unmap;
-			}
-
-			rx_desc->skb = skb;
-			cookie = rx_desc->cookie;
-			list_del(&rx_desc->list);
-			list_add_tail(&rx_desc->list, &dp->rx_desc_used_list);
+		spin_lock_bh(&dp->rx_desc_lock);
 
+		/* Get desc from free list and store in used list
+		 * for cleanup purposes
+		 *
+		 * TODO: pass the removed descs rather than
+		 * add/read to optimize
+		 */
+		rx_desc = list_first_entry_or_null(&dp->rx_desc_free_list,
+						   struct ath12k_rx_desc_info,
+						   list);
+		if (!rx_desc) {
 			spin_unlock_bh(&dp->rx_desc_lock);
-		} else {
-			spin_lock_bh(&rx_ring->idr_lock);
-			buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 0,
-					   rx_ring->bufs_max * 3, GFP_ATOMIC);
-			spin_unlock_bh(&rx_ring->idr_lock);
-			if (buf_id < 0)
-				goto fail_dma_unmap;
-			cookie = u32_encode_bits(buf_id,
-						 DP_RXDMA_BUF_COOKIE_BUF_ID);
+			goto fail_dma_unmap;
 		}
 
+		rx_desc->skb = skb;
+		cookie = rx_desc->cookie;
+		list_del(&rx_desc->list);
+		list_add_tail(&rx_desc->list, &dp->rx_desc_used_list);
+
+		spin_unlock_bh(&dp->rx_desc_lock);
+
 		desc = ath12k_hal_srng_src_get_next_entry(ab, srng);
 		if (!desc)
 			goto fail_buf_unassign;
@@ -359,17 +346,11 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	return req_entries - num_remain;
 
 fail_buf_unassign:
-	if (hw_cc) {
-		spin_lock_bh(&dp->rx_desc_lock);
-		list_del(&rx_desc->list);
-		list_add_tail(&rx_desc->list, &dp->rx_desc_free_list);
-		rx_desc->skb = NULL;
-		spin_unlock_bh(&dp->rx_desc_lock);
-	} else {
-		spin_lock_bh(&rx_ring->idr_lock);
-		idr_remove(&rx_ring->bufs_idr, buf_id);
-		spin_unlock_bh(&rx_ring->idr_lock);
-	}
+	spin_lock_bh(&dp->rx_desc_lock);
+	list_del(&rx_desc->list);
+	list_add_tail(&rx_desc->list, &dp->rx_desc_free_list);
+	rx_desc->skb = NULL;
+	spin_unlock_bh(&dp->rx_desc_lock);
 fail_dma_unmap:
 	dma_unmap_single(ab->dev, paddr, skb->len + skb_tailroom(skb),
 			 DMA_FROM_DEVICE);
@@ -435,8 +416,7 @@ static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 	if ((ringtype == HAL_RXDMA_MONITOR_BUF) || (ringtype == HAL_TX_MONITOR_BUF))
 		ath12k_dp_mon_buf_replenish(ab, rx_ring, num_entries);
 	else
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_entries,
-					    ringtype == HAL_RXDMA_BUF);
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_entries);
 	return 0;
 }
 
@@ -2708,7 +2688,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	if (!total_msdu_reaped)
 		goto exit;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped, true);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped);
 
 	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
 					      ring_id);
@@ -3486,7 +3466,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	rx_ring = &dp->rx_refill_buf_ring;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, tot_n_bufs_reaped, true);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, tot_n_bufs_reaped);
 
 	return tot_n_bufs_reaped;
 }
@@ -3799,7 +3779,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	if (!num_buffs_reaped)
 		goto done;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped, true);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped);
 
 	rcu_read_lock();
 	for (i = 0; i <  ab->num_radios; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 14f20977c9de..b0c5352ac6e6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -118,8 +118,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
 			 int budget);
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
-				int req_entries,
-				bool hw_cc);
+				int req_entries);
 int ath12k_dp_rx_pdev_mon_attach(struct ath12k *ar);
 int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id);
 
-- 
2.17.1

