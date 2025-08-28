Return-Path: <linux-wireless+bounces-26820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E8B3A846
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906857B2AD5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6706338F2E;
	Thu, 28 Aug 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JQg3CiAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649C33A031
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402589; cv=none; b=g3EScgGzUPM7p1sby+vAq8UAxFNXNUqZO2N3XKT9160o5F2IGPXb3lYnyXUgbAYXJ3P0pwNNEizx42XdbxVvR7alt/Gc1hjAMoh+/n8wL3l7Zu8j2VFY8/3sIxTJXgxuq0QVaViS2nd+0c3IXhNteF/srHW0mvnj7tKnPLaFT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402589; c=relaxed/simple;
	bh=a9bbl4NRW/nWchb/c4cl2Bd1JTb0/CWL3KQYjDUwE7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXLlm12gjJBA3Nhmk9bi17K5aACdOAjf8Kj4AdXuMkvx+ImmIZyYnB8nD8iT6jHMtSPgeIVxefjj3bY6e1nGEtVfwzAU3UnhQISH+uAr1q2CehSFvdVZzAjzjVBWFP9FfgyPbQVdXFrbhQ2re1zGjk+pb7DnFHIUpGUgHngt5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JQg3CiAW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDZZEC031179;
	Thu, 28 Aug 2025 17:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	94xbHKFFuoYbQyp9IpEiWWeifcIwZc61dxry3W0cdgY=; b=JQg3CiAWhVyt5Wo1
	51acJQfsAesOVrYZElkR+g0vwlRmS0ibpZLVScBZ9mKPNYt9OFDzoMCNgRcIGG1Z
	F6KqEyfK/LHWHKjQIJDYAWcsSaWxMAFcYxrmh0XqTfw51/oVxiVIutyJJZNboZWt
	0Q7TjKUnj7b8tgKAoyAFkVk9zKj+D3X7UGK/H/3Xl4sHCycbm1IPTQtqvh/YzBB0
	969Mndv5Gnb5GmCo9KKTo52dQIksnvvTPUHMmvPwefVAeQpJm0cpdUgSZABzJUKc
	GSBEgvdU0XlSzxiZN+bilZkQsBEhB3QTtHYum9XfELVXH/roQW93WvTP5ae01Efd
	bhzWgA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615s2u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaMhZ019668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:22 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:21 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 08/20] wifi: ath12k: Move rxdma ring config functions to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:41 +0530
Message-ID: <20250828173553.3341351-9-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX+bcpFialdRSK
 pX2zWP/bSbDg9IS8BLsKm30c6qSNDssyHUsdvhce/bDcWxFSdzz6GZBxJjboZSQH6kSr1V+jwi8
 YqdtqtWiypedKAISkH2xVCuvzV+TbvLjXsr1+XDb2koRyUmx07O8Qtj1/+sQNB8pQuCvYOTaivL
 y5RDPyQ/zB7LmX/EsmaZgUeTIWr6iwD4eT7mb99eh12SE3pJyWao/AAmGxUjNmmEVlRFzkn6G+v
 uhrczkdHXIOBi3uVCH6iwpkFuhhumGfIpUFppedFW+EMcf8/NnQNxcZHq3yo69Sy2c/JoxTUcp/
 Wl+JVXdpsN5CNab8hKmkGAF1B2KIzDQDsumPtb2lxgdvzQ8kZhA3WeTTEc2dYMEOKGZWtojl0uP
 dnUnC+iJ
X-Proofpoint-GUID: TtfPBSNYQR45JLq9eNBw9AQ3iurAOPel
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b09397 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=sWm5FkctiS-8VSTsAEkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TtfPBSNYQR45JLq9eNBw9AQ3iurAOPel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move architecture specific RxDMA functions to wifi7 directory.

The moved APIs will be a part of dp_rx.c file inside wifi7 directory.
wifi7/dp_rx.c file will continue to be part of ath12k.ko temporarily
until the corresponding infra for movement to ath12k_wifi7.ko arrives
in upcoming patches.

Architecture specific APIs:
ath12k_dp_rxdma_ring_sel_config_qcn9274
ath12k_dp_rxdma_ring_sel_config_wcn7850

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 85 -------------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  3 -
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 85 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  2 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  4 +-
 5 files changed, 89 insertions(+), 90 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 3da3ed5844c7..4f666fd077fc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3765,91 +3765,6 @@ void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int mac_id)
 	ath12k_dp_rx_pdev_srng_free(ar);
 }
 
-int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
-{
-	struct ath12k_dp *dp = &ab->dp;
-	struct htt_rx_ring_tlv_filter tlv_filter = {};
-	u32 ring_id;
-	int ret;
-	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
-
-	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
-
-	tlv_filter.rx_filter = HTT_RX_TLV_FLAGS_RXDMA_RING;
-	tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR;
-	tlv_filter.pkt_filter_flags3 = HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST |
-					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST |
-					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA;
-	tlv_filter.offset_valid = true;
-	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
-
-	tlv_filter.rx_mpdu_start_offset =
-		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
-	tlv_filter.rx_msdu_end_offset =
-		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
-
-	if (ath12k_dp_wmask_compaction_rx_tlv_supported(ab)) {
-		tlv_filter.rx_mpdu_start_wmask =
-			ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start();
-		tlv_filter.rx_msdu_end_wmask =
-			ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end();
-		ath12k_dbg(ab, ATH12K_DBG_DATA,
-			   "Configuring compact tlv masks rx_mpdu_start_wmask 0x%x rx_msdu_end_wmask 0x%x\n",
-			   tlv_filter.rx_mpdu_start_wmask, tlv_filter.rx_msdu_end_wmask);
-	}
-
-	ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, 0,
-					       HAL_RXDMA_BUF,
-					       DP_RXDMA_REFILL_RING_SIZE,
-					       &tlv_filter);
-
-	return ret;
-}
-EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_qcn9274);
-
-int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
-{
-	struct ath12k_dp *dp = &ab->dp;
-	struct htt_rx_ring_tlv_filter tlv_filter = {};
-	u32 ring_id;
-	int ret = 0;
-	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
-	int i;
-
-	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
-
-	tlv_filter.rx_filter = HTT_RX_TLV_FLAGS_RXDMA_RING;
-	tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR;
-	tlv_filter.pkt_filter_flags3 = HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST |
-					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST |
-					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA;
-	tlv_filter.offset_valid = true;
-	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
-
-	tlv_filter.rx_header_offset = offsetof(struct hal_rx_desc_wcn7850, pkt_hdr_tlv);
-
-	tlv_filter.rx_mpdu_start_offset =
-		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
-	tlv_filter.rx_msdu_end_offset =
-		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
-
-	/* TODO: Selectively subscribe to required qwords within msdu_end
-	 * and mpdu_start and setup the mask in below msg
-	 * and modify the rx_desc struct
-	 */
-
-	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
-		ring_id = dp->rx_mac_buf_ring[i].ring_id;
-		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, i,
-						       HAL_RXDMA_BUF,
-						       DP_RXDMA_REFILL_RING_SIZE,
-						       &tlv_filter);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_wcn7850);
-
 int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index caff92bffb84..542f08efe0cd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -402,9 +402,6 @@ u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc);
-int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
-int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
-
 int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
 				       const void *ptr, void *data),
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 26539a4d4b30..a002e3839fff 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -348,3 +348,88 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 done:
 	return total_num_buffs_reaped;
 }
+
+int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
+{
+	struct ath12k_dp *dp = &ab->dp;
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
+	u32 ring_id;
+	int ret;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
+
+	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
+
+	tlv_filter.rx_filter = HTT_RX_TLV_FLAGS_RXDMA_RING;
+	tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR;
+	tlv_filter.pkt_filter_flags3 = HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST |
+					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST |
+					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA;
+	tlv_filter.offset_valid = true;
+	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
+
+	tlv_filter.rx_mpdu_start_offset =
+		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
+	tlv_filter.rx_msdu_end_offset =
+		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
+
+	if (ath12k_dp_wmask_compaction_rx_tlv_supported(ab)) {
+		tlv_filter.rx_mpdu_start_wmask =
+			ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start();
+		tlv_filter.rx_msdu_end_wmask =
+			ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end();
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
+			   "Configuring compact tlv masks rx_mpdu_start_wmask 0x%x rx_msdu_end_wmask 0x%x\n",
+			   tlv_filter.rx_mpdu_start_wmask, tlv_filter.rx_msdu_end_wmask);
+	}
+
+	ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, 0,
+					       HAL_RXDMA_BUF,
+					       DP_RXDMA_REFILL_RING_SIZE,
+					       &tlv_filter);
+
+	return ret;
+}
+EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_qcn9274);
+
+int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
+{
+	struct ath12k_dp *dp = &ab->dp;
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
+	u32 ring_id;
+	int ret = 0;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	int i;
+
+	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
+
+	tlv_filter.rx_filter = HTT_RX_TLV_FLAGS_RXDMA_RING;
+	tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR;
+	tlv_filter.pkt_filter_flags3 = HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST |
+					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST |
+					HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA;
+	tlv_filter.offset_valid = true;
+	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
+
+	tlv_filter.rx_header_offset = offsetof(struct hal_rx_desc_wcn7850, pkt_hdr_tlv);
+
+	tlv_filter.rx_mpdu_start_offset =
+		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
+	tlv_filter.rx_msdu_end_offset =
+		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
+
+	/* TODO: Selectively subscribe to required qwords within msdu_end
+	 * and mpdu_start and setup the mask in below msg
+	 * and modify the rx_desc struct
+	 */
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+		ring_id = dp->rx_mac_buf_ring[i].ring_id;
+		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, i,
+						       HAL_RXDMA_BUF,
+						       DP_RXDMA_REFILL_RING_SIZE,
+						       &tlv_filter);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_wcn7850);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index a6da98962345..154018c221da 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -11,4 +11,6 @@
 
 int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				 struct napi_struct *napi, int budget);
+int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
+int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 82b4f5b9f570..909f7311619c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/types.h>
@@ -16,7 +16,7 @@
 #include "hw.h"
 #include "../mhi.h"
 #include "mhi.h"
-#include "../dp_rx.h"
+#include "dp_rx.h"
 #include "../peer.h"
 #include "wmi.h"
 
-- 
2.34.1


