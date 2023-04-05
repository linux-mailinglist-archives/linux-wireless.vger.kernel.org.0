Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E46D73A4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 07:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjDEFL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 01:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbjDEFLx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 01:11:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776EC3A9C
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 22:11:52 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3352wEKw007289;
        Wed, 5 Apr 2023 05:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AB+z0URD0riXHcS0QP5ubnKR1ADzFmz/s+D+yKQShME=;
 b=LZa6z/w/fkkk7QdA1YO35wC2e0LfU5QAoT/IMBi4gz8i+pzFaXrAW4BQK4zpbjkLSWxz
 V07+HoPcaYBq8mhkQl/SiwmZTC1VkCYa/yoXbOL+eMfsH+XTQrgXR/nmq84g37dWIPfA
 3SvHqN4g2aWeTm1cSpx50i2GXfzhYux5ZeVYqRDJ6Hgo7Nvh+uBy3rzIZcW8SLZsMYpk
 3b8d2KpE7mmirgDSvsyTJTLk4t3csMSIci9j67phFLXHH48Cv/nq5Jwn9sE356C/1E7h
 PgKTK6aAUoPUUObTpTp/w7I12+qtveKKecW8Ll8syaWcP2xnvixJwDeQu6Kj7L9jRAF6 rQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prppuhn9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 05:11:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3355Bjcp021063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 05:11:45 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 22:11:43 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] wifi: ath11k: Do not use WBM2SW4 as tx completion ring on WCN6750
Date:   Wed, 5 Apr 2023 10:41:27 +0530
Message-ID: <20230405051127.14651-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dhytGw7gX7CoZ3AddldDC8zRQCdi7nu-
X-Proofpoint-ORIG-GUID: dhytGw7gX7CoZ3AddldDC8zRQCdi7nu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_02,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050047
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On WCN6750, ageout flush on WBM2SW4 SRNG does not happen if there is only
one TX completion pending in the FIFO and all other WBM2SW release SRNGs
are idle. Due to this limitation, TX completion for the lone packet in
WBM2SW4 SRNG will never reach the driver. This is a case where the TX
packet has been acked in the air but the completion status has not been
reported to the driver. In turn, the pending TX completions will prevent
the device from entering suspend. The following error logs gets printed
during suspend and the suspend fails.

Failure log:
ath11k 17a10040.wifi: failed to flush transmit queue, data pkts pending 1

Fix this by not using WBM2SW4 SRNG for TX completions on WCN6750 and
instead reuse WBM2SW0.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp.c    | 59 +++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/dp.h    |  3 ++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 36 ++++++++-------
 drivers/net/wireless/ath/ath11k/hw.c    |  6 +--
 drivers/net/wireless/ath/ath11k/hw.h    |  2 +
 5 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f5156a7fbdd7..3eadbadefb75 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -408,13 +408,17 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 			goto err;
 		}
 
-		ret = ath11k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_comp_ring,
-					   HAL_WBM2SW_RELEASE, wbm_num, 0,
-					   DP_TX_COMP_RING_SIZE);
-		if (ret) {
-			ath11k_warn(ab, "failed to set up tcl_comp ring (%d) :%d\n",
-				    i, ret);
-			goto err;
+		if (wbm_num != ATH11K_HW_INVALID_WBM_RING_NUM) {
+			ret = ath11k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_comp_ring,
+						   HAL_WBM2SW_RELEASE, wbm_num, 0,
+						   DP_TX_COMP_RING_SIZE);
+			if (ret) {
+				ath11k_warn(ab, "failed to set up tcl_comp ring (%d) :%d\n",
+					    i, ret);
+				goto err;
+			}
+		} else {
+			dp->wbm2sw_txring_reuse = true;
 		}
 
 		srng = &ab->hal.srng_list[dp->tx_ring[i].tcl_data_ring.ring_id];
@@ -1018,6 +1022,38 @@ static int ath11k_dp_tx_pending_cleanup(int buf_id, void *skb, void *ctx)
 	return 0;
 }
 
+static void ath11k_dp_tx_idr_resources_deinit(struct ath11k_base *ab, int ring_id)
+{
+	struct dp_tx_ring *tx_ring = &ab->dp.tx_ring[ring_id];
+
+	spin_lock_bh(&tx_ring->tx_idr_lock);
+	idr_for_each(&tx_ring->txbuf_idr,
+		     ath11k_dp_tx_pending_cleanup, ab);
+	idr_destroy(&tx_ring->txbuf_idr);
+	spin_unlock_bh(&tx_ring->tx_idr_lock);
+}
+
+static void ath11k_dp_tx_idr_resources_init(struct ath11k_base *ab, int ring_id)
+{
+	struct dp_tx_ring *tx_ring = &ab->dp.tx_ring[ring_id];
+	int idr_start;
+	int idr_end;
+
+	if (ab->dp.wbm2sw_txring_reuse) {
+		idr_start = ring_id * DP_TX_IDR_SIZE;
+		idr_end = idr_start + DP_TX_IDR_SIZE - 1;
+	} else {
+		idr_start = 0;
+		idr_end = DP_TX_IDR_SIZE - 1;
+	}
+
+	tx_ring->idr_start = idr_start;
+	tx_ring->idr_end = idr_end;
+
+	idr_init_base(&tx_ring->txbuf_idr, idr_start);
+	spin_lock_init(&tx_ring->tx_idr_lock);
+}
+
 void ath11k_dp_free(struct ath11k_base *ab)
 {
 	struct ath11k_dp *dp = &ab->dp;
@@ -1031,11 +1067,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
 	ath11k_dp_reo_cmd_list_cleanup(ab);
 
 	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
-		spin_lock_bh(&dp->tx_ring[i].tx_idr_lock);
-		idr_for_each(&dp->tx_ring[i].txbuf_idr,
-			     ath11k_dp_tx_pending_cleanup, ab);
-		idr_destroy(&dp->tx_ring[i].txbuf_idr);
-		spin_unlock_bh(&dp->tx_ring[i].tx_idr_lock);
+		ath11k_dp_tx_idr_resources_deinit(ab, i);
 		kfree(dp->tx_ring[i].tx_status);
 	}
 
@@ -1082,8 +1114,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 	size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
 
 	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
-		idr_init(&dp->tx_ring[i].txbuf_idr);
-		spin_lock_init(&dp->tx_ring[i].tx_idr_lock);
+		ath11k_dp_tx_idr_resources_init(ab, i);
 		dp->tx_ring[i].tcl_data_ring_id = i;
 
 		dp->tx_ring[i].tx_status_head = 0;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index be9eafc872b3..dd13e88a49ef 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -88,6 +88,8 @@ struct dp_tx_ring {
 	struct hal_wbm_release_ring *tx_status;
 	int tx_status_head;
 	int tx_status_tail;
+	int idr_start;
+	int idr_end;
 };
 
 enum dp_mon_status_buf_state {
@@ -286,6 +288,7 @@ struct ath11k_dp {
 	spinlock_t reo_cmd_lock;
 	struct ath11k_hp_update_timer reo_cmd_timer;
 	struct ath11k_hp_update_timer tx_ring_timer[DP_TCL_NUM_RING_MAX];
+	bool wbm2sw_txring_reuse;
 };
 
 /* HTT definitions */
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8afbba236935..3e18ff213e3e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -120,8 +120,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	tx_ring = &dp->tx_ring[ti.ring_id];
 
 	spin_lock_bh(&tx_ring->tx_idr_lock);
-	ret = idr_alloc(&tx_ring->txbuf_idr, skb, 0,
-			DP_TX_IDR_SIZE - 1, GFP_ATOMIC);
+	ret = idr_alloc(&tx_ring->txbuf_idr, skb, tx_ring->idr_start,
+			tx_ring->idr_end, GFP_ATOMIC);
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (unlikely(ret < 0)) {
@@ -283,6 +283,22 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	return ret;
 }
 
+static inline struct sk_buff*
+ath11k_dp_tx_fetch_msdu(struct ath11k_base *ab, struct dp_tx_ring *tx_ring,
+			int msdu_id)
+{
+	struct sk_buff *msdu;
+
+	if (ab->dp.wbm2sw_txring_reuse)
+		tx_ring = &ab->dp.tx_ring[msdu_id / DP_TX_IDR_SIZE];
+
+	spin_lock(&tx_ring->tx_idr_lock);
+	msdu = idr_remove(&tx_ring->txbuf_idr, msdu_id);
+	spin_unlock(&tx_ring->tx_idr_lock);
+
+	return msdu;
+}
+
 static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
 				    int msdu_id,
 				    struct dp_tx_ring *tx_ring)
@@ -291,10 +307,7 @@ static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
 	struct sk_buff *msdu;
 	struct ath11k_skb_cb *skb_cb;
 
-	spin_lock(&tx_ring->tx_idr_lock);
-	msdu = idr_remove(&tx_ring->txbuf_idr, msdu_id);
-	spin_unlock(&tx_ring->tx_idr_lock);
-
+	msdu = ath11k_dp_tx_fetch_msdu(ab, tx_ring, msdu_id);
 	if (unlikely(!msdu)) {
 		ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
 			    msdu_id);
@@ -321,10 +334,7 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	struct ath11k_skb_cb *skb_cb;
 	struct ath11k *ar;
 
-	spin_lock(&tx_ring->tx_idr_lock);
-	msdu = idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
-	spin_unlock(&tx_ring->tx_idr_lock);
-
+	msdu = ath11k_dp_tx_fetch_msdu(ab, tx_ring, ts->msdu_id);
 	if (unlikely(!msdu)) {
 		ath11k_warn(ab, "htt tx completion for unknown msdu_id %d\n",
 			    ts->msdu_id);
@@ -703,17 +713,13 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 			continue;
 		}
 
-		spin_lock(&tx_ring->tx_idr_lock);
-		msdu = idr_remove(&tx_ring->txbuf_idr, msdu_id);
+		msdu = ath11k_dp_tx_fetch_msdu(ab, tx_ring, msdu_id);
 		if (unlikely(!msdu)) {
 			ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
 				    msdu_id);
-			spin_unlock(&tx_ring->tx_idr_lock);
 			continue;
 		}
 
-		spin_unlock(&tx_ring->tx_idr_lock);
-
 		ar = ab->pdevs[mac_id].ar;
 
 		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 60ac215e0678..fd3854293bb5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2025,8 +2025,6 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750 = {
 		ATH11K_TX_RING_MASK_0,
 		0,
 		ATH11K_TX_RING_MASK_2,
-		0,
-		ATH11K_TX_RING_MASK_4,
 	},
 	.rx_mon_status = {
 		0, 0, 0, 0, 0, 0,
@@ -2720,8 +2718,8 @@ static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_wcn6750[
 	},
 	{
 		.tcl_ring_num = 1,
-		.wbm_ring_num = 4,
-		.rbm_id = HAL_RX_BUF_RBM_SW4_BM,
+		.wbm_ring_num = ATH11K_HW_INVALID_WBM_RING_NUM,
+		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
 	},
 	{
 		.tcl_ring_num = 2,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 0be4e1232384..270a3b952ac6 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -80,6 +80,8 @@
 #define ATH11K_M3_FILE			"m3.bin"
 #define ATH11K_REGDB_FILE_NAME		"regdb.bin"
 
+#define ATH11K_HW_INVALID_WBM_RING_NUM	0xF
+
 #define ATH11K_CE_OFFSET(ab)	(ab->mem_ce - ab->mem)
 
 enum ath11k_hw_rate_cck {

base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.17.1

