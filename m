Return-Path: <linux-wireless+bounces-16714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ED89FAA25
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D281165A75
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67561F95C;
	Mon, 23 Dec 2024 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rbn/oNHz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D25914C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933716; cv=none; b=e8Jqh5Jjf2xbGJqoCpE1faFUcCk3sqj9i+tcD47V729t7pb/vEExPfZP2dHtleXnk1f/t7Vd4CxxwetDt5GlntYKdKsJyeNwL5f756eQhnXuhrCBKAHYXSg3K/ZGiUL/ElR1URbNm9qtVH1EbFv2ooC2D1Sz4POC2Nzkex1G1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933716; c=relaxed/simple;
	bh=eDIteyLaj9jeqdIc8YElql1edFVWy/HMVvT8N/pIYow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiA9QLXcN1hNGwWBl/hIH1rzpMNOLbnIX+JgiRz/VWnw4xW0dC5dMJpiGot3sTvUiy/VQCzUTTQjyXSWPsrrrkqwzs7JTcHuGaHdG3SNYHPEZ8woWUa+dh2IQokSF51VbJ9d/GzbThFAy3Sk3NnrFUXITRqocpc80QTHEa3eSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rbn/oNHz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN2vYDC002394;
	Mon, 23 Dec 2024 06:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wFPH19U57bMJl0mHHRuV0xiYp+JLOwJFCA4VbCUHSyw=; b=Rbn/oNHz8BBzcFpN
	r0A26FEdBE/r8WDSclP4wR5VgZV5bpJQuRQ+zzcAbJiQ50DE3o/t8CTG+MxDIU2I
	t/Fyv0FKFCVn8AscvHAh+/DSswAQev1INXu8I2m88srDMLEo4ArRaCvqfPm66dw1
	91Ey9LCkzI2930eEJzN1nRzcp6vxBaJEqSgB8GCH3qe7Sbhk7fQLUfPZRNyypPu2
	f3Uulbi5OPjRmpT/eZXQCWmfvnCUdppzWebHKJHYRd4+OWn3uBg4RH16RVHRg+E7
	L6TVeVicWiAoY1G+JKEXKDBVhkQRWclQanLHFItg+IXeHmd2X+MPHebLvwpNRzTm
	GyhC2A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyhnrk0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN61q98018208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:01:52 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 22:01:50 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2 02/14] wifi: ath12k: Enable filter config for monitor destination ring
Date: Mon, 23 Dec 2024 11:31:20 +0530
Message-ID: <20241223060132.3506372-3-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
References: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-GUID: v0zTVlywHUEuFcSGiWk3lumA4uPUUvqq
X-Proofpoint-ORIG-GUID: v0zTVlywHUEuFcSGiWk3lumA4uPUUvqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230052

Add provision to configure monitor filter for the destination
ring. These filters are used for requesting statistics or monitor mode
through the monitor destination ring.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h    | 49 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp_tx.c | 75 ++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 475c053faaa1..787e8e20658f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -770,8 +770,22 @@ enum htt_stats_internal_ppdu_frametype {
 #define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_RING_ID	GENMASK(23, 16)
 #define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_SS		BIT(24)
 #define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PS		BIT(25)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_BUF_SIZE	GENMASK(15, 0)
-#define HTT_RX_RING_SELECTION_CFG_CMD_OFFSET_VALID      BIT(26)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_OFFSET_VALID	BIT(26)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_DROP_THRES_VAL	BIT(27)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_EN_RXMON		BIT(28)
+
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_BUF_SIZE		GENMASK(15, 0)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT	GENMASK(18, 16)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL	GENMASK(21, 19)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA	GENMASK(24, 22)
+
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_DROP_THRESHOLD	GENMASK(9, 0)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_MGMT_TYPE	BIT(17)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_CTRL_TYPE	BIT(18)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_DATA_TYPE	BIT(19)
+
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO3_EN_TLV_PKT_OFFSET	BIT(0)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO3_PKT_TLV_OFFSET	GENMASK(14, 1)
 
 #define HTT_RX_RING_SELECTION_CFG_RX_PACKET_OFFSET      GENMASK(15, 0)
 #define HTT_RX_RING_SELECTION_CFG_RX_HEADER_OFFSET      GENMASK(31, 16)
@@ -800,6 +814,7 @@ enum htt_rx_filter_tlv_flags {
 	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS	= BIT(10),
 	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT	= BIT(11),
 	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE	= BIT(12),
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO	= BIT(13),
 };
 
 enum htt_rx_mgmt_pkt_filter_tlv_flags0 {
@@ -1088,6 +1103,21 @@ enum htt_rx_data_pkt_filter_tlv_flasg3 {
 		HTT_RX_FILTER_TLV_FLAGS_PER_MSDU_HEADER | \
 		HTT_RX_FILTER_TLV_FLAGS_ATTENTION)
 
+#define HTT_RX_MON_FILTER_TLV_FLAGS_MON_DEST_RING \
+	(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
+	HTT_RX_FILTER_TLV_FLAGS_MSDU_START | \
+	HTT_RX_FILTER_TLV_FLAGS_RX_PACKET | \
+	HTT_RX_FILTER_TLV_FLAGS_MSDU_END | \
+	HTT_RX_FILTER_TLV_FLAGS_MPDU_END | \
+	HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER | \
+	HTT_RX_FILTER_TLV_FLAGS_PER_MSDU_HEADER | \
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE | \
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO)
+
 /* msdu start. mpdu end, attention, rx hdr tlv's are not subscribed */
 #define HTT_RX_TLV_FLAGS_RXDMA_RING \
 		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
@@ -1116,6 +1146,10 @@ struct htt_rx_ring_selection_cfg_cmd {
 	__le32 info3;
 } __packed;
 
+#define HTT_RX_RING_TLV_DROP_THRESHOLD_VALUE	32
+#define HTT_RX_RING_DEFAULT_DMA_LENGTH		0x7
+#define HTT_RX_RING_PKT_TLV_OFFSET		0x1
+
 struct htt_rx_ring_tlv_filter {
 	u32 rx_filter; /* see htt_rx_filter_tlv_flags */
 	u32 pkt_filter_flags0; /* MGMT */
@@ -1133,6 +1167,17 @@ struct htt_rx_ring_tlv_filter {
 	u16 rx_mpdu_start_wmask;
 	u16 rx_mpdu_end_wmask;
 	u32 rx_msdu_end_wmask;
+	u32 conf_len_ctrl;
+	u32 conf_len_mgmt;
+	u32 conf_len_data;
+	u16 rx_drop_threshold;
+	bool enable_log_mgmt_type;
+	bool enable_log_ctrl_type;
+	bool enable_log_data_type;
+	bool enable_rx_tlv_offset;
+	u16 rx_tlv_offset;
+	bool drop_threshold_valid;
+	bool rxmon_disable;
 };
 
 #define HTT_STATS_FRAME_CTRL_TYPE_MGMT  0x0
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 13bc2d92e09c..b8f0df6f7a05 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1077,15 +1077,46 @@ int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP),
 				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PS);
 	cmd->info0 |= le32_encode_bits(tlv_filter->offset_valid,
-				       HTT_RX_RING_SELECTION_CFG_CMD_OFFSET_VALID);
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_OFFSET_VALID);
+	cmd->info0 |=
+		le32_encode_bits(tlv_filter->drop_threshold_valid,
+				 HTT_RX_RING_SELECTION_CFG_CMD_INFO0_DROP_THRES_VAL);
+	cmd->info0 |= le32_encode_bits(!tlv_filter->rxmon_disable,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_EN_RXMON);
+
 	cmd->info1 = le32_encode_bits(rx_buf_size,
 				      HTT_RX_RING_SELECTION_CFG_CMD_INFO1_BUF_SIZE);
+	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_mgmt,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT);
+	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_ctrl,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL);
+	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_data,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA);
 	cmd->pkt_type_en_flags0 = cpu_to_le32(tlv_filter->pkt_filter_flags0);
 	cmd->pkt_type_en_flags1 = cpu_to_le32(tlv_filter->pkt_filter_flags1);
 	cmd->pkt_type_en_flags2 = cpu_to_le32(tlv_filter->pkt_filter_flags2);
 	cmd->pkt_type_en_flags3 = cpu_to_le32(tlv_filter->pkt_filter_flags3);
 	cmd->rx_filter_tlv = cpu_to_le32(tlv_filter->rx_filter);
 
+	cmd->info2 = le32_encode_bits(tlv_filter->rx_drop_threshold,
+				      HTT_RX_RING_SELECTION_CFG_CMD_INFO2_DROP_THRESHOLD);
+	cmd->info2 |=
+		le32_encode_bits(tlv_filter->enable_log_mgmt_type,
+				 HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_MGMT_TYPE);
+	cmd->info2 |=
+		le32_encode_bits(tlv_filter->enable_log_ctrl_type,
+				 HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_CTRL_TYPE);
+	cmd->info2 |=
+		le32_encode_bits(tlv_filter->enable_log_data_type,
+				 HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_DATA_TYPE);
+
+	cmd->info3 =
+		le32_encode_bits(tlv_filter->enable_rx_tlv_offset,
+				 HTT_RX_RING_SELECTION_CFG_CMD_INFO3_EN_TLV_PKT_OFFSET);
+	cmd->info3 |=
+		le32_encode_bits(tlv_filter->rx_tlv_offset,
+				 HTT_RX_RING_SELECTION_CFG_CMD_INFO3_PKT_TLV_OFFSET);
+
 	if (tlv_filter->offset_valid) {
 		cmd->rx_packet_offset =
 			le32_encode_bits(tlv_filter->rx_packet_offset,
@@ -1210,15 +1241,28 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
-	int ret, ring_id;
+	int ret, ring_id, i;
 
-	ring_id = dp->rxdma_mon_buf_ring.refill_buf_ring.ring_id;
 	tlv_filter.offset_valid = false;
 
 	if (!reset) {
-		tlv_filter.rx_filter = HTT_RX_MON_FILTER_TLV_FLAGS_MON_BUF_RING;
+		tlv_filter.rx_filter = HTT_RX_MON_FILTER_TLV_FLAGS_MON_DEST_RING;
+
+		tlv_filter.drop_threshold_valid = true;
+		tlv_filter.rx_drop_threshold = HTT_RX_RING_TLV_DROP_THRESHOLD_VALUE;
+
+		tlv_filter.enable_log_mgmt_type = true;
+		tlv_filter.enable_log_ctrl_type = true;
+		tlv_filter.enable_log_data_type = true;
+
+		tlv_filter.conf_len_ctrl = HTT_RX_RING_DEFAULT_DMA_LENGTH;
+		tlv_filter.conf_len_mgmt = HTT_RX_RING_DEFAULT_DMA_LENGTH;
+		tlv_filter.conf_len_data = HTT_RX_RING_DEFAULT_DMA_LENGTH;
+
+		tlv_filter.enable_rx_tlv_offset = true;
+		tlv_filter.rx_tlv_offset = HTT_RX_RING_PKT_TLV_OFFSET;
+
 		tlv_filter.pkt_filter_flags0 =
 					HTT_RX_MON_FP_MGMT_FILTER_FLAGS0 |
 					HTT_RX_MON_MO_MGMT_FILTER_FLAGS0;
@@ -1236,14 +1280,19 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 	}
 
 	if (ab->hw_params->rxdma1_enable) {
-		ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, 0,
-						       HAL_RXDMA_MONITOR_BUF,
-						       DP_RXDMA_REFILL_RING_SIZE,
-						       &tlv_filter);
-		if (ret) {
-			ath12k_err(ab,
-				   "failed to setup filter for monitor buf %d\n", ret);
-			return ret;
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+			ring_id = ar->dp.rxdma_mon_dst_ring[i].ring_id;
+			ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
+							       ar->dp.mac_id + i,
+							       HAL_RXDMA_MONITOR_DST,
+							       DP_RXDMA_REFILL_RING_SIZE,
+							       &tlv_filter);
+			if (ret) {
+				ath12k_err(ab,
+					   "failed to setup filter for monitor buf %d\n",
+					   ret);
+				return ret;
+			}
 		}
 	}
 
-- 
2.34.1


