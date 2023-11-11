Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067757E8941
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 05:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjKKEkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 23:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjKKEkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 23:40:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607A3C30
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 20:39:58 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB4JZJr031658;
        Sat, 11 Nov 2023 04:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eg8BM1HRSBKwR46+lv3et/pE4PuwJYGvWLPiSAegW/4=;
 b=krk/dxIEf2pps5k+8QjLXYq6NPRHG7o0uP+zHclrZGYcqYMd4QQpKxasP1lHPOvEwQkt
 FwPeJG9W/l6AvL3maznN1AwXRnk54xEwMEK8OLmFnUn1PItoAng6OFGit1qnO/TyI+N5
 z8Ryw5H041QOcLOrEKCyHYGN8BEHujshk4JL4xR7GE79j7P0LssLWfU8RDf6OVcPz2tQ
 pABoWHoRl4d0LSOQi9v961nF06O3sSTGAjN9Ch/LEokeliCkoGkl9SkHbkU4OpiDkmtL
 7HKhbCOwxx8SxGotuyC2s7QHQAyJ1KBRRl9V8ILU7uiBCeWu7k4cV5Vsz/epe/RJjdmb SA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua177845t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 04:39:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AB4drkm001969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 04:39:53 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 20:39:51 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v2 1/4] wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
Date:   Sat, 11 Nov 2023 10:09:31 +0530
Message-ID: <20231111043934.20485-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231111043934.20485-1-quic_periyasa@quicinc.com>
References: <20231111043934.20485-1-quic_periyasa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qd2TTDyWEr-caAwW_fUacRsvWs06uh5f
X-Proofpoint-GUID: qd2TTDyWEr-caAwW_fUacRsvWs06uh5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=88 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=88 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=88
 mlxlogscore=-87 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311110036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently all Rxdma replenish callers pass zero for the mac id
argument, so make it as zero implicitly. To optimize the rx
data path per packet, avoid the explicit unnecessary argument
in Rxdma replenish function.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    |  4 ++--
 drivers/net/wireless/ath/ath12k/dp_rx.c | 16 +++++++---------
 drivers/net/wireless/ath/ath12k/dp_rx.h |  4 ++--
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 6893466f61f0..0eae4e89e07c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -961,7 +961,7 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 		struct ath12k_dp *dp = &ab->dp;
 		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 
-		ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, 0,
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring, 0,
 					    ab->hw_params->hal_params->rx_buf_rbm,
 					    true);
 	}
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9f831e3971f9..c7fc89af05c0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/ieee80211.h>
@@ -256,7 +256,7 @@ static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
 }
 
 /* Returns number of Rx buffers replenished */
-int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab, int mac_id,
+int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
 				int req_entries,
 				enum hal_rx_buf_return_buf_manager mgr,
@@ -337,9 +337,7 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab, int mac_id,
 			spin_unlock_bh(&rx_ring->idr_lock);
 			if (buf_id < 0)
 				goto fail_dma_unmap;
-			cookie = u32_encode_bits(mac_id,
-						 DP_RXDMA_BUF_COOKIE_PDEV_ID) |
-				 u32_encode_bits(buf_id,
+			cookie = u32_encode_bits(buf_id,
 						 DP_RXDMA_BUF_COOKIE_BUF_ID);
 		}
 
@@ -437,7 +435,7 @@ static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 	if ((ringtype == HAL_RXDMA_MONITOR_BUF) || (ringtype == HAL_TX_MONITOR_BUF))
 		ath12k_dp_mon_buf_replenish(ab, rx_ring, num_entries);
 	else
-		ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, num_entries,
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_entries,
 					    ab->hw_params->hal_params->rx_buf_rbm,
 					    ringtype == HAL_RXDMA_BUF);
 	return 0;
@@ -2712,7 +2710,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		goto exit;
 
 	/* TODO: Move to implicit BM? */
-	ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, num_buffs_reaped,
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped,
 				    ab->hw_params->hal_params->rx_buf_rbm, true);
 
 	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
@@ -3491,7 +3489,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	rx_ring = &dp->rx_refill_buf_ring;
 
-	ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, tot_n_bufs_reaped,
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, tot_n_bufs_reaped,
 				    ab->hw_params->hal_params->rx_buf_rbm, true);
 
 	return tot_n_bufs_reaped;
@@ -3805,7 +3803,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	if (!num_buffs_reaped)
 		goto done;
 
-	ath12k_dp_rx_bufs_replenish(ab, 0, rx_ring, num_buffs_reaped,
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped,
 				    ab->hw_params->hal_params->rx_buf_rbm, true);
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index c955b5c859d1..ef1b172e685c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH12K_DP_RX_H
 #define ATH12K_DP_RX_H
@@ -116,7 +116,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
 			 struct napi_struct *napi,
 			 int budget);
-int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab, int mac_id,
+int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
 				int req_entries,
 				enum hal_rx_buf_return_buf_manager mgr,
-- 
2.17.1

