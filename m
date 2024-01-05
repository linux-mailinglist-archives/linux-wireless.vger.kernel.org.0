Return-Path: <linux-wireless+bounces-1533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097D825B4A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7521F245CD
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AB5360B3;
	Fri,  5 Jan 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EySQ1WrG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF036091
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405IjLZI005240;
	Fri, 5 Jan 2024 19:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2cHj7zlMm6CNAmwoAthSo0F+dg+yHEIFtb9OGnKeShs=; b=Ey
	SQ1WrG//XnZwxbLzEpWXgWCBhKETFONOjaQzlidbhxonu3+4ugb0bVHBSLNRwQHd
	smYc2jvCQ026jV8ra9zlgh+rvZBMfn7qYg9Nh+PxzNIGSaaht4rmpW7e0qzFBkIp
	reOjJGB+lEXR4OPImnAQp9qRWrWf06ucYwy7yE2HW00L/HGfcScNooXUIFdJRCMB
	J7U09wOl7ToOxqTpcGcQsm9dy65uiikFl7xIMK5i/29S0+CzmybfkSzI6JjojBlY
	4IIxFmgCUR5CQE3BdjMI+U6LI82dVd7f75hodaE4VqKTCMI8Oo/HaLKxjm5LFYCp
	BeBC9J6nuQo+5Dl85GHg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve94ra72q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405JvJOZ008886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:57:19 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:57:17 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 10/12] wifi: ath12k: add MAC id support in WBM error path
Date: Sat, 6 Jan 2024 01:26:37 +0530
Message-ID: <20240105195639.3217739-11-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s7e5-J1kq-F16ZKZq3ChOyeP--ryPjcz
X-Proofpoint-GUID: s7e5-J1kq-F16ZKZq3ChOyeP--ryPjcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=721 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050161

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

When more than one pdev is supported in the chip/SoC, the packet
belonging to second pdev is given to first pdev due to not identifying
the MAC id in the WBM error path. So ping fails.

In WBM error path, src link id information not available in the
descriptor. So get this information from the msdu_end 64bit tag. It
is necessary to get the src link id to identify the MAC id in the
given chip. Then only we can pass the skb to the corresponding pdev.

The msdu_end 64bit tag is available only if compact Rx TLVs
descriptors are used. Thus, src link id is fetched correctly in WBM
error path when compact descriptors are in use.

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
index ee58c7dd796a..8652ac208703 100644
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
@@ -3696,16 +3702,15 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
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
@@ -3738,11 +3743,6 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			}
 		}
 
-		/* FIXME: Extract mac id correctly. Since descs are not tied
-		 * to mac, we can extract from vdev id in ring desc.
-		 */
-		mac_id = 0;
-
 		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
 			ath12k_warn(ab, "WBM RX err, Check HW CC implementation");
 
@@ -3772,7 +3772,8 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		rxcb->err_rel_src = err_info.err_rel_src;
 		rxcb->err_code = err_info.err_code;
 		rxcb->rx_desc = (struct hal_rx_desc *)msdu->data;
-		__skb_queue_tail(&msdu_list[mac_id], msdu);
+
+		__skb_queue_tail(&msdu_list, msdu);
 
 		rxcb->is_first_msdu = err_info.first_msdu;
 		rxcb->is_last_msdu = err_info.last_msdu;
@@ -3789,21 +3790,22 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped);
 
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
index cb540251acf8..78310da8cfe8 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -700,6 +700,11 @@ static u32 ath12k_hw_qcn9274_get_rx_desc_size(void)
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
@@ -738,6 +743,7 @@ const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_dp_rx_h_mpdu_err,
 	.rx_desc_get_desc_size = ath12k_hw_qcn9274_get_rx_desc_size,
+	.rx_desc_get_msdu_src_link_id = ath12k_hw_qcn9274_rx_desc_get_msdu_src_link,
 };
 
 static bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
@@ -1033,6 +1039,12 @@ static u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void)
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
@@ -1076,6 +1088,8 @@ const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err,
 	.rx_desc_get_desc_size = ath12k_hw_qcn9274_compact_get_rx_desc_size,
+	.rx_desc_get_msdu_src_link_id =
+		ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link,
 };
 
 const struct hal_ops hal_qcn9274_ops = {
@@ -1504,6 +1518,11 @@ static u32 ath12k_hw_wcn7850_get_rx_desc_size(void)
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
@@ -1543,6 +1562,7 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.dp_rx_h_is_decrypted = ath12k_hw_wcn7850_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_wcn7850_dp_rx_h_mpdu_err,
 	.rx_desc_get_desc_size = ath12k_hw_wcn7850_get_rx_desc_size,
+	.rx_desc_get_msdu_src_link_id = ath12k_hw_wcn7850_rx_desc_get_msdu_src_link,
 };
 
 const struct hal_ops hal_wcn7850_ops = {
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index b7d78ba2b801..107927d64bbb 100644
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
index d5fd3a3b6b4d..a0db6702a189 100644
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
2.34.1


