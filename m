Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32F97E8940
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 05:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjKKEkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 23:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345579AbjKKEkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 23:40:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9AD3C30
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 20:40:04 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB2rUDW003722;
        Sat, 11 Nov 2023 04:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8tt4lqpXqeViQVx1HmAutfpjWnPUKUKwoVcGZ/sarYM=;
 b=Xq2sOkLB3rVloPdhf9A0BrHoj0rrI4/k7E9fOhr5xxU/Dc5YbQtfds8TaOZ8KxnIzW3F
 Ty5kWmGzLPW5onEuUMnUol61XWQ5RldeF9rxXyN54RyIUUMyS1RFNGx0fWxyunQsfbtx
 YIkC5NM3QcYlJSi/80ehQjOQ8vw2SVqnuj+lE+973yLik4YMe1LUVj2G6AdUUt42GkbJ
 UDKtnyBmt40jK1Lj7EBEIMQcHaRy2I1le+DBkgcl7Fett23RSo+DwIMl1AWGMvJzGuhg
 8LIF30fPUDo3EhElRnGwSYu281S6CMbL9sOt9WEcwn8waqSZezRWjI0l5glW8Tj4TG8l lA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua1778460-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 04:40:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AB4e0D1007785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 04:40:00 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 20:39:58 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v2 4/4] wifi: ath12k: refactor DP Rxdma ring structure
Date:   Sat, 11 Nov 2023 10:09:34 +0530
Message-ID: <20231111043934.20485-5-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SqaiqYzXe4qlByw0pf8cbuavoKrDbVRQ
X-Proofpoint-GUID: SqaiqYzXe4qlByw0pf8cbuavoKrDbVRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=673 classifier=spam adjust=0 reason=mlx scancount=1
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

Currently data path Rxdma ring structure store the IDR buffer and lock.
These IDR handling is needed only for SW cookie conversion and not
needed for HW cookie conversion. REO Rxdma ring use the HW cookie
conversion and monitor Rxdma ring use the SW cookie conversion.
Since idr not needed for REO Rxdma ring, remove the IDR data entity
from the data path Rxdma ring structure. Introduce the new data path ring
structure for monitor rxmda rings since it need IDR data entity.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h     | 13 ++++--
 drivers/net/wireless/ath/ath12k/dp_mon.c | 12 ++---
 drivers/net/wireless/ath/ath12k/dp_mon.h |  4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ++++++++++++------------
 4 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 61f765432516..1df3cdd46140 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_H
@@ -31,7 +31,7 @@ struct dp_srng {
 	u32 ring_id;
 };
 
-struct dp_rxdma_ring {
+struct dp_rxdma_mon_ring {
 	struct dp_srng refill_buf_ring;
 	struct idr bufs_idr;
 	/* Protects bufs_idr */
@@ -39,6 +39,11 @@ struct dp_rxdma_ring {
 	int bufs_max;
 };
 
+struct dp_rxdma_ring {
+	struct dp_srng refill_buf_ring;
+	int bufs_max;
+};
+
 #define ATH12K_TX_COMPL_NEXT(x)	(((x) + 1) % DP_TX_COMP_RING_SIZE)
 
 struct dp_tx_ring {
@@ -353,8 +358,8 @@ struct ath12k_dp {
 	struct dp_rxdma_ring rx_refill_buf_ring;
 	struct dp_srng rx_mac_buf_ring[MAX_RXDMA_PER_PDEV];
 	struct dp_srng rxdma_err_dst_ring[MAX_RXDMA_PER_PDEV];
-	struct dp_rxdma_ring rxdma_mon_buf_ring;
-	struct dp_rxdma_ring tx_mon_buf_ring;
+	struct dp_rxdma_mon_ring rxdma_mon_buf_ring;
+	struct dp_rxdma_mon_ring tx_mon_buf_ring;
 	struct ath12k_reo_q_addr_lut reoq_lut;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f44bc5494ce7..98d7c8e2c0eb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "dp_mon.h"
@@ -797,7 +797,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		/* TODO: add msdu start parsing logic */
 		break;
 	case HAL_MON_BUF_ADDR: {
-		struct dp_rxdma_ring *buf_ring = &ab->dp.rxdma_mon_buf_ring;
+		struct dp_rxdma_mon_ring *buf_ring = &ab->dp.rxdma_mon_buf_ring;
 		struct dp_mon_packet_info *packet_info =
 			(struct dp_mon_packet_info *)tlv_data;
 		int buf_id = u32_get_bits(packet_info->cookie,
@@ -1259,7 +1259,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 }
 
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
-				struct dp_rxdma_ring *buf_ring,
+				struct dp_rxdma_mon_ring *buf_ring,
 				int req_entries)
 {
 	struct hal_mon_buf_ring *mon_buf;
@@ -1902,7 +1902,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_MON_BUF_ADDR: {
-		struct dp_rxdma_ring *buf_ring = &ab->dp.tx_mon_buf_ring;
+		struct dp_rxdma_mon_ring *buf_ring = &ab->dp.tx_mon_buf_ring;
 		struct dp_mon_packet_info *packet_info =
 			(struct dp_mon_packet_info *)tlv_data;
 		int buf_id = u32_get_bits(packet_info->cookie,
@@ -2067,7 +2067,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
 	struct ath12k_skb_rxcb *rxcb;
 	struct dp_srng *mon_dst_ring;
 	struct hal_srng *srng;
-	struct dp_rxdma_ring *buf_ring;
+	struct dp_rxdma_mon_ring *buf_ring;
 	u64 cookie;
 	u32 ppdu_id;
 	int num_buffs_reaped = 0, srng_id, buf_id;
@@ -2480,7 +2480,7 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 	struct ath12k_skb_rxcb *rxcb;
 	struct dp_srng *mon_dst_ring;
 	struct hal_srng *srng;
-	struct dp_rxdma_ring *buf_ring;
+	struct dp_rxdma_mon_ring *buf_ring;
 	struct ath12k_sta *arsta = NULL;
 	struct ath12k_peer *peer;
 	u64 cookie;
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index c18c385798a1..fb9e9c176ce5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_MON_H
@@ -80,7 +80,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 				  int mac_id, struct sk_buff *skb,
 				  struct napi_struct *napi);
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
-				struct dp_rxdma_ring *buf_ring,
+				struct dp_rxdma_mon_ring *buf_ring,
 				int req_entries);
 int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id,
 			       int *budget, enum dp_monitor_mode monitor_mode,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 2098a5f8fb70..fb02238798d7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -364,8 +364,8 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	return req_entries - num_remain;
 }
 
-static int ath12k_dp_rxdma_buf_ring_free(struct ath12k_base *ab,
-					 struct dp_rxdma_ring *rx_ring)
+static int ath12k_dp_rxdma_mon_buf_ring_free(struct ath12k_base *ab,
+					     struct dp_rxdma_mon_ring *rx_ring)
 {
 	struct sk_buff *skb;
 	int buf_id;
@@ -390,44 +390,49 @@ static int ath12k_dp_rxdma_buf_ring_free(struct ath12k_base *ab,
 static int ath12k_dp_rxdma_buf_free(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
-	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 
-	ath12k_dp_rxdma_buf_ring_free(ab, rx_ring);
+	ath12k_dp_rxdma_mon_buf_ring_free(ab, &dp->rxdma_mon_buf_ring);
+
+	ath12k_dp_rxdma_mon_buf_ring_free(ab, &dp->tx_mon_buf_ring);
+
+	return 0;
+}
+
+static int ath12k_dp_rxdma_mon_ring_buf_setup(struct ath12k_base *ab,
+					      struct dp_rxdma_mon_ring *rx_ring,
+					      u32 ringtype)
+{
+	int num_entries;
 
-	rx_ring = &dp->rxdma_mon_buf_ring;
-	ath12k_dp_rxdma_buf_ring_free(ab, rx_ring);
+	num_entries = rx_ring->refill_buf_ring.size /
+		ath12k_hal_srng_get_entrysize(ab, ringtype);
 
-	rx_ring = &dp->tx_mon_buf_ring;
-	ath12k_dp_rxdma_buf_ring_free(ab, rx_ring);
+	rx_ring->bufs_max = num_entries;
+	ath12k_dp_mon_buf_replenish(ab, rx_ring, num_entries);
 
 	return 0;
 }
 
 static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
-					  struct dp_rxdma_ring *rx_ring,
-					  u32 ringtype)
+					  struct dp_rxdma_ring *rx_ring)
 {
 	int num_entries;
 
 	num_entries = rx_ring->refill_buf_ring.size /
-		ath12k_hal_srng_get_entrysize(ab, ringtype);
+		ath12k_hal_srng_get_entrysize(ab, HAL_RXDMA_BUF);
 
 	rx_ring->bufs_max = num_entries;
-	if ((ringtype == HAL_RXDMA_MONITOR_BUF) || (ringtype == HAL_TX_MONITOR_BUF))
-		ath12k_dp_mon_buf_replenish(ab, rx_ring, num_entries);
-	else
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_entries);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_entries);
+
 	return 0;
 }
 
 static int ath12k_dp_rxdma_buf_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
-	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 	int ret;
 
-	ret = ath12k_dp_rxdma_ring_buf_setup(ab, rx_ring,
-					     HAL_RXDMA_BUF);
+	ret = ath12k_dp_rxdma_ring_buf_setup(ab, &dp->rx_refill_buf_ring);
 	if (ret) {
 		ath12k_warn(ab,
 			    "failed to setup HAL_RXDMA_BUF\n");
@@ -435,18 +440,18 @@ static int ath12k_dp_rxdma_buf_setup(struct ath12k_base *ab)
 	}
 
 	if (ab->hw_params->rxdma1_enable) {
-		rx_ring = &dp->rxdma_mon_buf_ring;
-		ret = ath12k_dp_rxdma_ring_buf_setup(ab, rx_ring,
-						     HAL_RXDMA_MONITOR_BUF);
+		ret = ath12k_dp_rxdma_mon_ring_buf_setup(ab,
+							 &dp->rxdma_mon_buf_ring,
+							 HAL_RXDMA_MONITOR_BUF);
 		if (ret) {
 			ath12k_warn(ab,
 				    "failed to setup HAL_RXDMA_MONITOR_BUF\n");
 			return ret;
 		}
 
-		rx_ring = &dp->tx_mon_buf_ring;
-		ret = ath12k_dp_rxdma_ring_buf_setup(ab, rx_ring,
-						     HAL_TX_MONITOR_BUF);
+		ret = ath12k_dp_rxdma_mon_ring_buf_setup(ab,
+							 &dp->tx_mon_buf_ring,
+							 HAL_TX_MONITOR_BUF);
 		if (ret) {
 			ath12k_warn(ab,
 				    "failed to setup HAL_TX_MONITOR_BUF\n");
@@ -4060,9 +4065,6 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	int i, ret;
 
-	idr_init(&dp->rx_refill_buf_ring.bufs_idr);
-	spin_lock_init(&dp->rx_refill_buf_ring.idr_lock);
-
 	idr_init(&dp->rxdma_mon_buf_ring.bufs_idr);
 	spin_lock_init(&dp->rxdma_mon_buf_ring.idr_lock);
 
-- 
2.17.1

