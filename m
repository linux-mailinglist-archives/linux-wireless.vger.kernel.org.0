Return-Path: <linux-wireless+bounces-2643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A13283FEC0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603A71F22579
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BE51C43;
	Mon, 29 Jan 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wa9/gUMR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680351C40
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511492; cv=none; b=JiDXQYrWJAFAT5D35Zww4ijIHls4qXMXj3FJ0T9NLbiHO3ipvv1FVnGL+MSawFjrxzpYap5iv0ggL8fMUoxNw4k/yNiomCP9YUwNwTSJDy6KMHeAgvle6kB4TbVmWO+WOYwl0YH4VJ2JUcF7wZVzp6btGGjqmsAET9fSoM6/Oto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511492; c=relaxed/simple;
	bh=WRdjkDtBNk9GTsqBtBfUp3GDs2zeOvs+/rZRH5lN5ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qR9JX1IiwDauFgKXwIzTGuJmPBXpoxqjA5ODkBJPXsDwKfwEEwU6DaURL+CwRiph7sajAYlTjJGUkAPJyZG+euSLiqmI3kJ2jRtlsdlTr+HAxyedDPxscfZW21KocGOyr0lVxNDBIJB1dTC+79bBKVMUEzqmuCiMh0ZV3XncRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wa9/gUMR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T49P7g026804;
	Mon, 29 Jan 2024 06:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rqE60UKsRbR+XdI8PUnqwTcEyuIK/24p/Aku1JUzhzc=; b=Wa
	9/gUMRxJH6ghTZMMicdKZJdJabym0se/py255WYsK4Fs/7bwdpYjZeTBLNCvMpU6
	BP0B67dms6RaoyRRyNsJ4QWSNLINGL5xN6Uvnu1yZqWqi4Uoef8HPGHiYYLmNc3O
	9yt6UQJSa+8zl5g3a9kI+FKZELukVQKFsQDOqjE2L/WRfZ6LF4aq9Yc+4GOb1iuN
	fQUg8IPTubJPqvh0WKDBmoGb3FG4h9LhD2wNPPsjk7Wh0PIUmAR6OwmTk1qXJrNR
	aWkBQSK0cHQ2QJu1UZ+hFqcL9uKqPLDhdDu+9fmEuXgiKiHVHN1o4RhNonJwu20O
	psu1C0k22VJyIp03dgiA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvt272yub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:58:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6w563009018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:58:05 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:58:03 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 09/13] wifi: ath12k: subscribe required word mask from rx tlv
Date: Mon, 29 Jan 2024 12:27:20 +0530
Message-ID: <20240129065724.2310207-10-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OJ9Bkdng24gLqxIfupeUNA5I1ZRkmuuV
X-Proofpoint-ORIG-GUID: OJ9Bkdng24gLqxIfupeUNA5I1ZRkmuuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>

Most of the RX descriptors fields are currently not used in the
ath12k driver. Hence add support to selectively subscribe to the
required quad words (64 bits) within msdu_end and mpdu_start of
rx_desc.

Add compact rx_desc structures and configure the bit mask for Rx TLVs
(msdu_end, mpdu_start, mpdu_end) via registers. With these registers
SW can configure to DMA the partial TLV struct to Rx buffer.

Each TLV type has its own register to configure the mask value.
The mask value configured in register will indicate if a particular
QWORD has to be written to rx buffer or not i.e., if Nth bit is enabled
in the mask Nth QWORD will be written and it will not be written if the
bit is disabled in mask. While 0th bit indicates whether TLV tag will be
written or not.

Advantages of Qword subscription of TLVs
- Avoid multiple cache-line misses as the all the required fields
of the TLV are within 128 bytes.
- Memory optimization as TLVs + DATA + SHINFO can fit in 2k buffer
even for 64 bit kernel.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c      |  17 +
 drivers/net/wireless/ath/ath12k/dp.h      |  14 +
 drivers/net/wireless/ath/ath12k/dp_rx.c   |  14 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c   |  20 ++
 drivers/net/wireless/ath/ath12k/hal.c     | 359 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hal.h     |   4 +
 drivers/net/wireless/ath/ath12k/rx_desc.h | 114 ++++++-
 drivers/net/wireless/ath/ath12k/wmi.h     |   2 +
 8 files changed, 535 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index af800d60f3a2..c8e1b244b69e 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -997,8 +997,25 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k_base *ab)
 	}
 }
 
+bool ath12k_dp_wmask_compaction_rx_tlv_supported(struct ath12k_base *ab)
+{
+	if (test_bit(WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS, ab->wmi_ab.svc_map) &&
+	    ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start &&
+	    ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end &&
+	    ab->hw_params->hal_ops->get_hal_rx_compact_ops) {
+		return true;
+	}
+	return false;
+}
+
 void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
 {
+	if (ath12k_dp_wmask_compaction_rx_tlv_supported(ab)) {
+		/* RX TLVS compaction is supported, hence change the hal_rx_ops
+		 * to compact hal_rx_ops.
+		 */
+		ab->hal_rx_ops = ab->hw_params->hal_ops->get_hal_rx_compact_ops();
+	}
 	ab->hal.hal_desc_sz =
 		ab->hal_rx_ops->rx_desc_get_desc_size();
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 226b95bd5ab0..eb2dd408e081 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -766,6 +766,11 @@ enum htt_stats_internal_ppdu_frametype {
 #define HTT_RX_RING_SELECTION_CFG_RX_MSDU_START_OFFSET  GENMASK(31, 16)
 #define HTT_RX_RING_SELECTION_CFG_RX_ATTENTION_OFFSET   GENMASK(15, 0)
 
+#define HTT_RX_RING_SELECTION_CFG_WORD_MASK_COMPACT_SET	BIT(23)
+#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_MASK	GENMASK(15, 0)
+#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_MASK	GENMASK(18, 16)
+#define HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_MASK	GENMASK(16, 0)
+
 enum htt_rx_filter_tlv_flags {
 	HTT_RX_FILTER_TLV_FLAGS_MPDU_START		= BIT(0),
 	HTT_RX_FILTER_TLV_FLAGS_MSDU_START		= BIT(1),
@@ -1089,6 +1094,11 @@ struct htt_rx_ring_selection_cfg_cmd {
 	__le32 rx_mpdu_offset;
 	__le32 rx_msdu_offset;
 	__le32 rx_attn_offset;
+	__le32 info2;
+	__le32 reserved[2];
+	__le32 rx_mpdu_start_end_mask;
+	__le32 rx_msdu_end_word_mask;
+	__le32 info3;
 } __packed;
 
 struct htt_rx_ring_tlv_filter {
@@ -1105,6 +1115,9 @@ struct htt_rx_ring_tlv_filter {
 	u16 rx_msdu_end_offset;
 	u16 rx_msdu_start_offset;
 	u16 rx_attn_offset;
+	u16 rx_mpdu_start_wmask;
+	u16 rx_mpdu_end_wmask;
+	u32 rx_msdu_end_wmask;
 };
 
 #define HTT_STATS_FRAME_CTRL_TYPE_MGMT  0x0
@@ -1821,5 +1834,6 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie);
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 desc_id);
+bool ath12k_dp_wmask_compaction_rx_tlv_supported(struct ath12k_base *ab);
 void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 10ea33fafff4..5c2316e40019 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3939,10 +3939,16 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 	tlv_filter.rx_msdu_end_offset =
 		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
 
-	/* TODO: Selectively subscribe to required qwords within msdu_end
-	 * and mpdu_start and setup the mask in below msg
-	 * and modify the rx_desc struct
-	 */
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
 	ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, 0,
 					       HAL_RXDMA_BUF,
 					       DP_RXDMA_REFILL_RING_SIZE,
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index d4db94112deb..572b87153647 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -964,6 +964,26 @@ int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
 					 HTT_RX_RING_SELECTION_CFG_RX_ATTENTION_OFFSET);
 	}
 
+	if (tlv_filter->rx_mpdu_start_wmask > 0 &&
+	    tlv_filter->rx_msdu_end_wmask > 0) {
+		cmd->info2 |=
+			le32_encode_bits(true,
+					 HTT_RX_RING_SELECTION_CFG_WORD_MASK_COMPACT_SET);
+		cmd->rx_mpdu_start_end_mask =
+			le32_encode_bits(tlv_filter->rx_mpdu_start_wmask,
+					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_MASK);
+		/* mpdu_end is not used for any hardwares so far
+		 * please assign it in future if any chip is
+		 * using through hal ops
+		 */
+		cmd->rx_mpdu_start_end_mask |=
+			le32_encode_bits(tlv_filter->rx_mpdu_end_wmask,
+					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_MASK);
+		cmd->rx_msdu_end_word_mask =
+			le32_encode_bits(tlv_filter->rx_msdu_end_wmask,
+					 HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_MASK);
+	}
+
 	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
 	if (ret)
 		goto err_free;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index fa1bfb5256d0..cb540251acf8 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -626,6 +626,21 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	return 0;
 }
 
+static u16 ath12k_hal_qcn9274_rx_mpdu_start_wmask_get(void)
+{
+	return QCN9274_MPDU_START_WMASK;
+}
+
+static u32 ath12k_hal_qcn9274_rx_msdu_end_wmask_get(void)
+{
+	return QCN9274_MSDU_END_WMASK;
+}
+
+static const struct hal_rx_ops *ath12k_hal_qcn9274_get_hal_rx_compact_ops(void)
+{
+	return &hal_rx_qcn9274_compact_ops;
+}
+
 static bool ath12k_hw_qcn9274_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274.msdu_end.info14,
@@ -725,9 +740,350 @@ const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_get_desc_size = ath12k_hw_qcn9274_get_rx_desc_size,
 };
 
+static bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			       RX_MSDU_END_INFO5_FIRST_MSDU);
+}
+
+static bool ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			       RX_MSDU_END_INFO5_LAST_MSDU);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
+}
+
+static bool ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
+}
+
+static u32 ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info2,
+			     RX_MPDU_START_INFO2_ENC_TYPE);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
+			     RX_MSDU_END_INFO11_DECAP_FORMAT);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274.msdu_end.info11,
+			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
+}
+
+static bool
+ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
+}
+
+static bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
+}
+
+static u16
+ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
+}
+
+static u16 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info10,
+			     RX_MSDU_END_INFO10_MSDU_LENGTH);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_SGI);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RATE_MCS);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RECV_BW);
+}
+
+static u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.phy_meta_data);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_PKT_TYPE);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_QCN9274_INFO12_MIMO_SS_BITMAP);
+}
+
+static u8 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			     RX_MSDU_END_QCN9274_INFO5_TID);
+}
+
+static u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.sw_peer_id);
+}
+
+static void ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
+							   struct hal_rx_desc *ldesc)
+{
+	fdesc->u.qcn9274_compact.msdu_end = ldesc->u.qcn9274_compact.msdu_end;
+}
+
+static u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.phy_ppdu_id);
+}
+
+static void
+ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+{
+	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info10);
+
+	info = u32_replace_bits(info, len, RX_MSDU_END_INFO10_MSDU_LENGTH);
+	desc->u.qcn9274_compact.msdu_end.info10 = __cpu_to_le32(info);
+}
+
+static u8 *ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+{
+	return &desc->u.qcn9274_compact.msdu_payload[0];
+}
+
+static u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset(void)
+{
+	return offsetof(struct hal_rx_desc_qcn9274_compact, mpdu_start);
+}
+
+static u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset(void)
+{
+	return offsetof(struct hal_rx_desc_qcn9274_compact, msdu_end);
+}
+
+static bool ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
+			     RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
+}
+
+static u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+{
+	return desc->u.qcn9274_compact.mpdu_start.addr2;
+}
+
+static bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info6) &
+	       RX_MPDU_START_INFO6_MCAST_BCAST;
+}
+
+static void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
+							    struct ieee80211_hdr *hdr)
+{
+	hdr->frame_control = desc->u.qcn9274_compact.mpdu_start.frame_ctrl;
+	hdr->duration_id = desc->u.qcn9274_compact.mpdu_start.duration;
+	ether_addr_copy(hdr->addr1, desc->u.qcn9274_compact.mpdu_start.addr1);
+	ether_addr_copy(hdr->addr2, desc->u.qcn9274_compact.mpdu_start.addr2);
+	ether_addr_copy(hdr->addr3, desc->u.qcn9274_compact.mpdu_start.addr3);
+	if (__le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
+			RX_MPDU_START_INFO4_MAC_ADDR4_VALID) {
+		ether_addr_copy(hdr->addr4, desc->u.qcn9274_compact.mpdu_start.addr4);
+	}
+	hdr->seq_ctrl = desc->u.qcn9274_compact.mpdu_start.seq_ctrl;
+}
+
+static void
+ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
+						 u8 *crypto_hdr,
+						 enum hal_encrypt_type enctype)
+{
+	unsigned int key_id;
+
+	switch (enctype) {
+	case HAL_ENCRYPT_TYPE_OPEN:
+		return;
+	case HAL_ENCRYPT_TYPE_TKIP_NO_MIC:
+	case HAL_ENCRYPT_TYPE_TKIP_MIC:
+		crypto_hdr[0] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		crypto_hdr[1] = 0;
+		crypto_hdr[2] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		break;
+	case HAL_ENCRYPT_TYPE_CCMP_128:
+	case HAL_ENCRYPT_TYPE_CCMP_256:
+	case HAL_ENCRYPT_TYPE_GCMP_128:
+	case HAL_ENCRYPT_TYPE_AES_GCMP_256:
+		crypto_hdr[0] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		crypto_hdr[1] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		crypto_hdr[2] = 0;
+		break;
+	case HAL_ENCRYPT_TYPE_WEP_40:
+	case HAL_ENCRYPT_TYPE_WEP_104:
+	case HAL_ENCRYPT_TYPE_WEP_128:
+	case HAL_ENCRYPT_TYPE_WAPI_GCM_SM4:
+	case HAL_ENCRYPT_TYPE_WAPI:
+		return;
+	}
+	key_id = le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info5,
+			       RX_MPDU_START_INFO5_KEY_ID);
+	crypto_hdr[3] = 0x20 | (key_id << 6);
+	crypto_hdr[4] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE3(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+	crypto_hdr[5] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE4(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+	crypto_hdr[6] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[1]);
+	crypto_hdr[7] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[1]);
+}
+
+static u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_frame_ctl(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.frame_ctrl);
+}
+
+static bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
+			       RX_MSDU_END_INFO14_MSDU_DONE);
+}
+
+static bool ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
+			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
+}
+
+static bool ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
+			       RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
+}
+
+static bool ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
+{
+	return (le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
+			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
+			RX_DESC_DECRYPT_STATUS_CODE_OK);
+}
+
+static u32 ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
+{
+	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info13);
+	u32 errmap = 0;
+
+	if (info & RX_MSDU_END_INFO13_FCS_ERR)
+		errmap |= HAL_RX_MPDU_ERR_FCS;
+
+	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
+		errmap |= HAL_RX_MPDU_ERR_DECRYPT;
+
+	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
+		errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
+
+	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
+		errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
+
+	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
+		errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
+
+	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
+
+	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
+
+	return errmap;
+}
+
+static u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void)
+{
+	return sizeof(struct hal_rx_desc_qcn9274_compact);
+}
+
+const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
+	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu,
+	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu,
+	.rx_desc_get_l3_pad_bytes = ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes,
+	.rx_desc_encrypt_valid = ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid,
+	.rx_desc_get_encrypt_type = ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type,
+	.rx_desc_get_decap_type = ath12k_hw_qcn9274_compact_rx_desc_get_decap_type,
+	.rx_desc_get_mesh_ctl = ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl,
+	.rx_desc_get_mpdu_seq_ctl_vld =
+		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld,
+	.rx_desc_get_mpdu_fc_valid = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid,
+	.rx_desc_get_mpdu_start_seq_no =
+		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no,
+	.rx_desc_get_msdu_len = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len,
+	.rx_desc_get_msdu_sgi = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi,
+	.rx_desc_get_msdu_rate_mcs = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs,
+	.rx_desc_get_msdu_rx_bw = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw,
+	.rx_desc_get_msdu_freq = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq,
+	.rx_desc_get_msdu_pkt_type = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type,
+	.rx_desc_get_msdu_nss = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss,
+	.rx_desc_get_mpdu_tid = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid,
+	.rx_desc_get_mpdu_peer_id = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id,
+	.rx_desc_copy_end_tlv = ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id,
+	.rx_desc_set_msdu_len = ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len,
+	.rx_desc_get_msdu_payload = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload,
+	.rx_desc_get_mpdu_start_offset =
+		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset,
+	.rx_desc_get_msdu_end_offset =
+		ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset,
+	.rx_desc_mac_addr2_valid = ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2,
+	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc,
+	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr,
+	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr,
+	.rx_desc_get_mpdu_frame_ctl =
+		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_frame_ctl,
+	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done,
+	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail,
+	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail,
+	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted,
+	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err,
+	.rx_desc_get_desc_size = ath12k_hw_qcn9274_compact_get_rx_desc_size,
+};
+
 const struct hal_ops hal_qcn9274_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
 	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
+	.rxdma_ring_wmask_rx_mpdu_start = ath12k_hal_qcn9274_rx_mpdu_start_wmask_get,
+	.rxdma_ring_wmask_rx_msdu_end = ath12k_hal_qcn9274_rx_msdu_end_wmask_get,
+	.get_hal_rx_compact_ops = ath12k_hal_qcn9274_get_hal_rx_compact_ops,
 };
 
 static bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
@@ -1192,6 +1548,9 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 const struct hal_ops hal_wcn7850_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
 	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
+	.rxdma_ring_wmask_rx_mpdu_start = NULL,
+	.rxdma_ring_wmask_rx_msdu_end = NULL,
+	.get_hal_rx_compact_ops = NULL,
 };
 
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 82517991510b..b7d78ba2b801 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1082,6 +1082,9 @@ struct hal_rx_ops {
 
 struct hal_ops {
 	int (*create_srng_config)(struct ath12k_base *ab);
+	u16 (*rxdma_ring_wmask_rx_mpdu_start)(void);
+	u32 (*rxdma_ring_wmask_rx_msdu_end)(void);
+	const struct hal_rx_ops *(*get_hal_rx_compact_ops)(void);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 };
 
@@ -1089,6 +1092,7 @@ extern const struct hal_ops hal_qcn9274_ops;
 extern const struct hal_ops hal_wcn7850_ops;
 
 extern const struct hal_rx_ops hal_rx_qcn9274_ops;
+extern const struct hal_rx_ops hal_rx_qcn9274_compact_ops;
 extern const struct hal_rx_ops hal_rx_wcn7850_ops;
 
 u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index 55f20c446ca9..d5fd3a3b6b4d 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH12K_RX_DESC_H
 #define ATH12K_RX_DESC_H
@@ -147,6 +147,61 @@ struct rx_mpdu_start_qcn9274 {
 	__le32 res1;
 } __packed;
 
+#define QCN9274_MPDU_START_SELECT_MPDU_START_TAG			BIT(0)
+#define QCN9274_MPDU_START_SELECT_INFO0_REO_QUEUE_DESC_LO		BIT(1)
+#define QCN9274_MPDU_START_SELECT_INFO1_PN_31_0				BIT(2)
+#define QCN9274_MPDU_START_SELECT_PN_95_32				BIT(3)
+#define QCN9274_MPDU_START_SELECT_PN_127_96_INFO2			BIT(4)
+#define QCN9274_MPDU_START_SELECT_PEER_MDATA_INFO3_PHY_PPDU_ID		BIT(5)
+#define QCN9274_MPDU_START_SELECT_AST_IDX_SW_PEER_ID_INFO4		BIT(6)
+#define QCN9274_MPDU_START_SELECT_INFO5_INFO6				BIT(7)
+#define QCN9274_MPDU_START_SELECT_FRAME_CTRL_DURATION_ADDR1_31_0	BIT(8)
+#define QCN9274_MPDU_START_SELECT_ADDR2_47_0_ADDR1_47_32		BIT(9)
+#define QCN9274_MPDU_START_SELECT_ADDR3_47_0_SEQ_CTRL			BIT(10)
+#define QCN9274_MPDU_START_SELECT_ADDR4_47_0_QOS_CTRL			BIT(11)
+#define QCN9274_MPDU_START_SELECT_HT_CTRL_INFO7				BIT(12)
+#define QCN9274_MPDU_START_SELECT_ML_ADDR1_47_0_ML_ADDR2_15_0		BIT(13)
+#define QCN9274_MPDU_START_SELECT_ML_ADDR2_47_16_INFO8			BIT(14)
+#define QCN9274_MPDU_START_SELECT_RES_0_RES_1				BIT(15)
+
+#define QCN9274_MPDU_START_WMASK (QCN9274_MPDU_START_SELECT_INFO1_PN_31_0 |	\
+		QCN9274_MPDU_START_SELECT_PN_95_32 |				\
+		QCN9274_MPDU_START_SELECT_PN_127_96_INFO2 |			\
+		QCN9274_MPDU_START_SELECT_PEER_MDATA_INFO3_PHY_PPDU_ID |	\
+		QCN9274_MPDU_START_SELECT_AST_IDX_SW_PEER_ID_INFO4 |		\
+		QCN9274_MPDU_START_SELECT_INFO5_INFO6 |				\
+		QCN9274_MPDU_START_SELECT_FRAME_CTRL_DURATION_ADDR1_31_0 |	\
+		QCN9274_MPDU_START_SELECT_ADDR2_47_0_ADDR1_47_32 |		\
+		QCN9274_MPDU_START_SELECT_ADDR3_47_0_SEQ_CTRL |			\
+		QCN9274_MPDU_START_SELECT_ADDR4_47_0_QOS_CTRL)
+
+/* The below rx_mpdu_start_qcn9274_compact structure is tied with the mask
+ * value QCN9274_MPDU_START_WMASK. If the mask value changes the structure
+ * will also change.
+ */
+
+struct rx_mpdu_start_qcn9274_compact {
+	__le32 info1;
+	__le32 pn[4];
+	__le32 info2;
+	__le32 peer_meta_data;
+	__le16 info3;
+	__le16 phy_ppdu_id;
+	__le16 ast_index;
+	__le16 sw_peer_id;
+	__le32 info4;
+	__le32 info5;
+	__le32 info6;
+	__le16 frame_ctrl;
+	__le16 duration;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	__le16 qos_ctrl;
+} __packed;
+
 /* rx_mpdu_start
  *
  * reo_destination_indication
@@ -786,6 +841,52 @@ struct rx_msdu_end_qcn9274 {
 	__le32 info14;
 } __packed;
 
+#define QCN9274_MSDU_END_SELECT_MSDU_END_TAG				BIT(0)
+#define QCN9274_MSDU_END_SELECT_INFO0_PHY_PPDUID_IP_HDR_CSUM_INFO1	BIT(1)
+#define QCN9274_MSDU_END_SELECT_INFO2_CUMULATIVE_CSUM_RULE_IND_0	BIT(2)
+#define QCN9274_MSDU_END_SELECT_IPV6_OP_CRC_INFO3_TYPE13		BIT(3)
+#define QCN9274_MSDU_END_SELECT_RULE_IND_1_TCP_SEQ_NUM			BIT(4)
+#define QCN9274_MSDU_END_SELECT_TCP_ACK_NUM_INFO4_WINDOW_SIZE		BIT(5)
+#define QCN9274_MSDU_END_SELECT_SA_SW_PER_ID_INFO5_SA_DA_ID		BIT(6)
+#define QCN9274_MSDU_END_SELECT_INFO6_FSE_METADATA			BIT(7)
+#define QCN9274_MSDU_END_SELECT_CCE_MDATA_TCP_UDP_CSUM_INFO7_IP_LEN	BIT(8)
+#define QCN9274_MSDU_END_SELECT_INFO8_INFO9				BIT(9)
+#define QCN9274_MSDU_END_SELECT_INFO10_INFO11				BIT(10)
+#define QCN9274_MSDU_END_SELECT_VLAN_CTAG_STAG_CI_PEER_MDATA		BIT(11)
+#define QCN9274_MSDU_END_SELECT_INFO12_AND_FLOW_ID_TOEPLITZ		BIT(12)
+#define QCN9274_MSDU_END_SELECT_PPDU_START_TS_63_32_PHY_MDATA		BIT(13)
+#define QCN9274_MSDU_END_SELECT_PPDU_START_TS_31_0_TOEPLITZ_HASH_2_4	BIT(14)
+#define QCN9274_MSDU_END_SELECT_RES0_SA_47_0				BIT(15)
+#define QCN9274_MSDU_END_SELECT_INFO13_INFO14				BIT(16)
+
+#define QCN9274_MSDU_END_WMASK (QCN9274_MSDU_END_SELECT_MSDU_END_TAG |	\
+		QCN9274_MSDU_END_SELECT_SA_SW_PER_ID_INFO5_SA_DA_ID |	\
+		QCN9274_MSDU_END_SELECT_INFO10_INFO11 |			\
+		QCN9274_MSDU_END_SELECT_INFO12_AND_FLOW_ID_TOEPLITZ |	\
+		QCN9274_MSDU_END_SELECT_PPDU_START_TS_63_32_PHY_MDATA |	\
+		QCN9274_MSDU_END_SELECT_INFO13_INFO14)
+
+/* The below rx_msdu_end_qcn9274_compact structure is tied with the mask value
+ * QCN9274_MSDU_END_WMASK. If the mask value changes the structure will also
+ * change.
+ */
+
+struct rx_msdu_end_qcn9274_compact {
+	__le64 msdu_end_tag;
+	__le16 sa_sw_peer_id;
+	__le16 info5;
+	__le16 sa_idx;
+	__le16 da_idx_or_sw_peer_id;
+	__le32 info10;
+	__le32 info11;
+	__le32 info12;
+	__le32 flow_id_toeplitz;
+	__le32 ppdu_start_timestamp_63_32;
+	__le32 phy_meta_data;
+	__le32 info13;
+	__le32 info14;
+} __packed;
+
 /* These macro definitions are only used for WCN7850 */
 #define RX_MSDU_END_WCN7850_INFO2_KEY_ID			BIT(7, 0)
 
@@ -1450,16 +1551,18 @@ struct rx_msdu_end_wcn7850 {
  *
  */
 
-/* TODO: Move to compact TLV approach
- * By default these tlv's are not aligned to 128b boundary
- * Need to remove unused qwords and make them compact/aligned
- */
 struct hal_rx_desc_qcn9274 {
 	struct rx_msdu_end_qcn9274 msdu_end;
 	struct rx_mpdu_start_qcn9274 mpdu_start;
 	u8 msdu_payload[];
 } __packed;
 
+struct hal_rx_desc_qcn9274_compact {
+	struct rx_msdu_end_qcn9274_compact msdu_end;
+	struct rx_mpdu_start_qcn9274_compact mpdu_start;
+	u8 msdu_payload[];
+} __packed;
+
 #define RX_BE_PADDING0_BYTES 8
 #define RX_BE_PADDING1_BYTES 8
 
@@ -1484,6 +1587,7 @@ struct hal_rx_desc_wcn7850 {
 struct hal_rx_desc {
 	union {
 		struct hal_rx_desc_qcn9274 qcn9274;
+		struct hal_rx_desc_qcn9274_compact qcn9274_compact;
 		struct hal_rx_desc_wcn7850 wcn7850;
 	} u;
 } __packed;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 7443831d62d8..d740701809c2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2163,6 +2163,8 @@ enum wmi_tlv_service {
 
 	WMI_TLV_SERVICE_11BE = 289,
 
+	WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS = 361,
+
 	WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT = 365,
 
 	WMI_MAX_EXT2_SERVICE,
-- 
2.34.1


