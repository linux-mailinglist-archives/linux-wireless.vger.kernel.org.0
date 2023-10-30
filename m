Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002E97DC273
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjJ3W2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjJ3W2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:28:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90FFD
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:28:01 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UM9RYf028985;
        Mon, 30 Oct 2023 22:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rxht5yadChDdqb7J+sMDoQcYoWxTtTZi72Msl6BB6bY=;
 b=DHaqvOSaKAt06pSpOo8VFrr5LRIaXAWN5NAIVWFMbg77IPyHIHQIyXbVUNAPcTvrQ8Rc
 F96LuczNH5lJBM537bTDJVWhCkCaHJD5g0l/tmHOngd09oYpkoUtUgM/EeRTZU4i7xZy
 cOQN5bAjDNuxEY4ctXqsb8RIdN92osleEFKLwDjr9ksQ/H5coDlMP7yxpw+EfVLCMd9h
 7rXHX/fEVdTvW/J3iDGk5QCqJcHP7c38U2DMBzVl2jwzsPzKXdd9ZGjAI2T7wEmJ0dNY
 1MHS4v7KHnLAtcHoddcwgfbP23WBFpTo0u/CCDjHoxVRB3srMppkRUlaaGQp6oUw0L6b 1A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u29fesr2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRvwT032592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:57 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:55 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 11/13] wifi: ath12k: add MAC id support in WBM error path
Date:   Tue, 31 Oct 2023 03:56:58 +0530
Message-ID: <20231030222700.18914-12-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u49CA8OKy0Hp-3BFgQEW2GtbOtdkhwYk
X-Proofpoint-ORIG-GUID: u49CA8OKy0Hp-3BFgQEW2GtbOtdkhwYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=694 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

When more than one pdev is supported in the chip/SoC, the packet
belonging to second pdev is given to first pdev due to not identifying
the MAC id in the WBM error path. So ping fails.

In WBM error path, src link id information not available in the
descriptor. So get this information from the msdu_end 64bit tag. It
is necessary to get the src link id to identify the MAC id in the
given chip. Then only we can pass the skb to the corresponding pdev.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 42 ++++++++++++-----------
 drivers/net/wireless/ath/ath12k/hal.c     | 20 +++++++++++
 drivers/net/wireless/ath/ath12k/hal.h     |  1 +
 drivers/net/wireless/ath/ath12k/rx_desc.h |  2 ++
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e865cc180..99bf76525 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -234,6 +234,12 @@ static u16 ath12k_dp_rxdesc_get_mpdu_frame_ctrl(struct ath12k_base *ab,
 	return ab->hal_rx_ops->rx_desc_get_mpdu_frame_ctl(desc);
 }
 
+static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
+						struct hal_rx_desc *desc)
+{
+	return ab->hal_rx_ops->rx_desc_get_msdu_src_link_id(desc);
+}
+
 static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
 {
 	int i, reaped = 0;
@@ -3719,16 +3725,15 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	struct hal_rx_wbm_rel_info err_info;
 	struct hal_srng *srng;
 	struct sk_buff *msdu;
-	struct sk_buff_head msdu_list[MAX_RADIOS];
+	struct sk_buff_head msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
 	void *rx_desc;
-	int mac_id;
+	u8 mac_id;
 	int num_buffs_reaped = 0;
 	struct ath12k_rx_desc_info *desc_info;
-	int ret, i;
+	int ret, pdev_id;
 
-	for (i = 0; i < ab->num_radios; i++)
-		__skb_queue_head_init(&msdu_list[i]);
+	__skb_queue_head_init(&msdu_list);
 
 	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
 	rx_ring = &dp->rx_refill_buf_ring;
@@ -3761,11 +3766,6 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			}
 		}
 
-		/* FIXME: Extract mac id correctly. Since descs are not tied
-		 * to mac, we can extract from vdev id in ring desc.
-		 */
-		mac_id = 0;
-
 		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
 			ath12k_warn(ab, "WBM RX err, Check HW CC implementation");
 
@@ -3795,7 +3795,8 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		rxcb->err_rel_src = err_info.err_rel_src;
 		rxcb->err_code = err_info.err_code;
 		rxcb->rx_desc = (struct hal_rx_desc *)msdu->data;
-		__skb_queue_tail(&msdu_list[mac_id], msdu);
+
+		__skb_queue_tail(&msdu_list, msdu);
 
 		rxcb->is_first_msdu = err_info.first_msdu;
 		rxcb->is_last_msdu = err_info.last_msdu;
@@ -3813,21 +3814,22 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				    ab->hw_params->hal_params->rx_buf_rbm, true);
 
 	rcu_read_lock();
-	for (i = 0; i <  ab->num_radios; i++) {
-		if (!rcu_dereference(ab->pdevs_active[i])) {
-			__skb_queue_purge(&msdu_list[i]);
+	while ((msdu = __skb_dequeue(&msdu_list))) {
+		mac_id = ath12k_dp_rx_get_msdu_src_link(ab,
+							(struct hal_rx_desc *)msdu->data);
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		ar = ab->pdevs[pdev_id].ar;
+
+		if (!ar || !rcu_dereference(ar->ab->pdevs_active[mac_id])) {
+			dev_kfree_skb_any(msdu);
 			continue;
 		}
 
-		ar = ab->pdevs[i].ar;
-
 		if (test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) {
-			__skb_queue_purge(&msdu_list[i]);
+			dev_kfree_skb_any(msdu);
 			continue;
 		}
-
-		while ((msdu = __skb_dequeue(&msdu_list[i])) != NULL)
-			ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list[i]);
+		ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
 	}
 	rcu_read_unlock();
 done:
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 4c2468a7f..030e1dbfd 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -695,6 +695,11 @@ static u32 ath12k_hw_qcn9274_get_rx_desc_size(void)
 	return sizeof(struct hal_rx_desc_qcn9274);
 }
 
+static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
+{
+	return 0;
+}
+
 const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_rx_desc_get_last_msdu,
@@ -733,6 +738,7 @@ const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_dp_rx_h_mpdu_err,
 	.rx_desc_get_desc_size = ath12k_hw_qcn9274_get_rx_desc_size,
+	.rx_desc_get_msdu_src_link_id = ath12k_hw_qcn9274_rx_desc_get_msdu_src_link,
 };
 
 static bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
@@ -1028,6 +1034,12 @@ static u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void)
 	return sizeof(struct hal_rx_desc_qcn9274_compact);
 }
 
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
+{
+	return le64_get_bits(desc->u.qcn9274_compact.msdu_end.msdu_end_tag,
+			     RX_MSDU_END_64_TLV_SRC_LINK_ID);
+}
+
 const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu,
@@ -1071,6 +1083,8 @@ const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err,
 	.rx_desc_get_desc_size = ath12k_hw_qcn9274_compact_get_rx_desc_size,
+	.rx_desc_get_msdu_src_link_id =
+		ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link,
 };
 
 const struct hal_ops hal_qcn9274_ops = {
@@ -1498,6 +1512,11 @@ static u32 ath12k_hw_wcn7850_get_rx_desc_size(void)
 	return sizeof(struct hal_rx_desc_wcn7850);
 }
 
+static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
+{
+	return 0;
+}
+
 const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_wcn7850_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_wcn7850_rx_desc_get_last_msdu,
@@ -1537,6 +1556,7 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.dp_rx_h_is_decrypted = ath12k_hw_wcn7850_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_wcn7850_dp_rx_h_mpdu_err,
 	.rx_desc_get_desc_size = ath12k_hw_wcn7850_get_rx_desc_size,
+	.rx_desc_get_msdu_src_link_id = ath12k_hw_wcn7850_rx_desc_get_msdu_src_link,
 };
 
 const struct hal_ops hal_wcn7850_ops = {
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 0deaf3a71..57f9aac5d 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1078,6 +1078,7 @@ struct hal_rx_ops {
 	bool (*dp_rx_h_is_decrypted)(struct hal_rx_desc *desc);
 	u32 (*dp_rx_h_mpdu_err)(struct hal_rx_desc *desc);
 	u32 (*rx_desc_get_desc_size)(void);
+	u8 (*rx_desc_get_msdu_src_link_id)(struct hal_rx_desc *desc);
 };
 
 struct hal_ops {
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index 2dd9a793d..669f3f085 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -663,6 +663,8 @@ enum rx_msdu_start_reception_type {
 	RX_MSDU_START_RECEPTION_TYPE_UL_MU_OFDMA_MIMO,
 };
 
+#define RX_MSDU_END_64_TLV_SRC_LINK_ID		GENMASK(24, 22)
+
 #define RX_MSDU_END_INFO0_RXPCU_MPDU_FITLER	GENMASK(1, 0)
 #define RX_MSDU_END_INFO0_SW_FRAME_GRP_ID	GENMASK(8, 2)
 
-- 
2.17.1

