Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1597E80A2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjKJSRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjKJSPD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEA9004
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 00:13:40 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7ffhf031309;
        Fri, 10 Nov 2023 08:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jsKBIPeB+zv6xw7F+DQv1GVYFhCGeONkf1dTuNcGQSQ=;
 b=dR86SOjtSRGm8sl/0Do9fak0lKx+wJ/WU6Q+/YMy6AIgmvETdzlvGUPOflGdgfzLPzwr
 Gm0jJG/BF2yXeEao0b+7jzdp2Kgwpl6MV1yDPtfGbdMY8q9mesnw8sTP8yZnPwHigNP+
 nt8E3sYhYjqL05QAyi97IzAc3r/nmIlXBynb41YDWrPgS7zVh0JvaEoq9nR2HaDGkwmW
 nYMeUUubP5IR2QoQImqNE2Q8dzs+duLa/1uLIAkiKqm76Jj8YH5HmyUw78J1HFFLygWz
 84eS0RDM63rxHEJf70Naot2v3Z95XdNsrvUmnac5MjViueNU+yCYNqt4elzkSHL6zmao Mg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9f3k088c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:13:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8DcF6021926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:13:38 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 00:13:36 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 2/4] wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
Date:   Fri, 10 Nov 2023 13:43:15 +0530
Message-ID: <20231110081317.19608-3-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VlcQEF84YrOoBgAPRPyDsJmWEraaV56_
X-Proofpoint-GUID: VlcQEF84YrOoBgAPRPyDsJmWEraaV56_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=9 lowpriorityscore=0
 spamscore=9 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=9
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=103
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently all Rxdma replenish callers pass the same return
buffer manager id argument, so make it implicitly. To
optimize the rx data path per packet, avoid the explicit
unnecessary argument in Rxdma replenish function.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    |  1 -
 drivers/net/wireless/ath/ath12k/dp_rx.c | 13 ++++---------
 drivers/net/wireless/ath/ath12k/dp_rx.h |  1 -
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index a00b4ff9f75d..f3c48aa9f62d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -962,7 +962,6 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 
 		ath12k_dp_rx_bufs_replenish(ab, rx_ring, 0,
-					    ab->hw_params->hal_params->rx_buf_rbm,
 					    true);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 4275eb8fa887..46fa8ee14b45 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -259,7 +259,6 @@ static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
 				int req_entries,
-				enum hal_rx_buf_return_buf_manager mgr,
 				bool hw_cc)
 {
 	struct ath12k_buffer_addr *desc;
@@ -272,6 +271,7 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	dma_addr_t paddr;
 	struct ath12k_dp *dp = &ab->dp;
 	struct ath12k_rx_desc_info *rx_desc;
+	enum hal_rx_buf_return_buf_manager mgr = ab->hw_params->hal_params->rx_buf_rbm;
 
 	req_entries = min(req_entries, rx_ring->bufs_max);
 
@@ -436,7 +436,6 @@ static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 		ath12k_dp_mon_buf_replenish(ab, rx_ring, num_entries);
 	else
 		ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_entries,
-					    ab->hw_params->hal_params->rx_buf_rbm,
 					    ringtype == HAL_RXDMA_BUF);
 	return 0;
 }
@@ -2709,9 +2708,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	if (!total_msdu_reaped)
 		goto exit;
 
-	/* TODO: Move to implicit BM? */
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped,
-				    ab->hw_params->hal_params->rx_buf_rbm, true);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped, true);
 
 	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
 					      ring_id);
@@ -3489,8 +3486,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	rx_ring = &dp->rx_refill_buf_ring;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, tot_n_bufs_reaped,
-				    ab->hw_params->hal_params->rx_buf_rbm, true);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, tot_n_bufs_reaped, true);
 
 	return tot_n_bufs_reaped;
 }
@@ -3803,8 +3799,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	if (!num_buffs_reaped)
 		goto done;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped,
-				    ab->hw_params->hal_params->rx_buf_rbm, true);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped, true);
 
 	rcu_read_lock();
 	for (i = 0; i <  ab->num_radios; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index eec561404530..14f20977c9de 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -119,7 +119,6 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
 				int req_entries,
-				enum hal_rx_buf_return_buf_manager mgr,
 				bool hw_cc);
 int ath12k_dp_rx_pdev_mon_attach(struct ath12k *ar);
 int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id);
-- 
2.17.1

