Return-Path: <linux-wireless+bounces-26832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0EB3A853
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F49A1BA5521
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B3342C8C;
	Thu, 28 Aug 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AyF185HS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8BC338F36
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402607; cv=none; b=U3NAUkFYbOFKZTVroHvSmcumlgKVOIM9nsTti0ac3JJ4VV4Av6f/Tjkmcm/7NCcCgg2ov4uKKWp7guMPl2L5+Me2gIT8ByY3KcIC+TXryXXOzvBT8rp5DM3red2gJnrzTziZmkFAmcijZpg3MBRWAftvQJel2WnuhxmoVT55es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402607; c=relaxed/simple;
	bh=k53/bN4W7P+GK4USswOpUi/CZAEWFXgWpzaHumUvK7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaWk//vqW8WA0TMGtF2TH88JvQuaoNwIARHUabz/bqsvvgyjLRiqBWCnK0iKQIvoLL+PBezQhIFOk2dcbz7etMF6M4LZz7Hen6dJCs0b+2gLpTPugjkDLx+tOgl0oF2ekqiELLs3hA1ThkF83XPjuEXuvbsWdZQfWNwyMJProm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AyF185HS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SF3wb5014817;
	Thu, 28 Aug 2025 17:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qzF9Mk2c/twbxa1WfF4vWNStPn6SWQ/+EgS4WUIQpgc=; b=AyF185HStjw3CdkD
	0CgCQMvoLi2S+HieQxDlJ7OSnCTFK5EWi10HRv6O/SjMXZbPP0eo++z3bnRK4P55
	1Ne4zPSTJXeN4z4qOWQ1XBz0tVCXTX+Thhk3baWH59ZFnqbkSnvm041dah6/zMBt
	s6+vRp4XM8bDkBxOZjur5dlboV+iz5jih0WXUXIBtBEcwWUUMftMruM5WQEbuMRG
	u8op6Dyjs922D5xGEf6eDHsadAfnhAGljh7B/nunE0/RXxI2EUjdASPPfeZ0P9ZM
	z8Eo/7/6NZLKVGQXt3Bw3ebvTtGXmHFIXJy1KSPwUM3LM2OQxlR9JoJwrFJrQQkW
	e1uwYQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we8usr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHadrW014416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:39 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:37 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 19/20] wifi: ath12k: Move HTT Tx specific code to newly introduced files
Date: Thu, 28 Aug 2025 23:05:52 +0530
Message-ID: <20250828173553.3341351-20-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: PDZ7CPVMJ3lao8Lut7orM-O2qLOpIn9b
X-Proofpoint-ORIG-GUID: PDZ7CPVMJ3lao8Lut7orM-O2qLOpIn9b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3Js+N5vdMt0M
 JwWSHKsDLVnGNf4iskcdrsWQE8kU+D6SFTUEQifIaHiAN2j4FcR0QEC3t8EiZTAXVQtD9s27ZZ9
 b3fO9HcPsxKnEZy19t95sbpEa+xItLM2kR1i70h/JJs/MvQg73ROtFqBejyAFa2c5RqWgAufd7+
 cwD5PexRswSwUI/PoE4Z50Pmh505CGeJfwg59mKxC9CX8xUQ1Gx+Hns6DABxmDV1jqQad6B3eLh
 ujvFuGJ+iMsNZdqwdjF8VbQqMU+AfyTb2C6Gn2O7BCt/7tcpERbvRdE8JMRo93kfu3gr4E36RYG
 noclhWs5Zh8PfRs7gVOrdvXAwEuZ7J7GR/aMAB7H3HpMfkoLQubrnCcKGX0M9oq9OK4W35xcXKz
 a9v9QhuV
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b093a8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=BwPTALo8mlevupKbmjwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

WLAN Host driver interacts with the Firmware and vice versa using
Host-To-Target (HTT) interface.

Relocate HTT specific code from dp_tx.c to dp_htt.c introduced for
HTT interface. These code is compiled as part of the common module
ath12k.ko.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h     |   2 -
 drivers/net/wireless/ath/ath12k/dp_htt.c | 683 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h |  24 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 682 ----------------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  18 -
 5 files changed, 705 insertions(+), 704 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 45d569e19534..ad93e63e3344 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -441,8 +441,6 @@ void ath12k_dp_partner_cc_init(struct ath12k_base *ab);
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab);
 void ath12k_dp_pdev_pre_alloc(struct ath12k *ar);
 void ath12k_dp_pdev_free(struct ath12k_base *ab);
-int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
-				int mac_id, enum hal_ring_type ring_type);
 int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr);
 void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr);
 void ath12k_dp_srng_cleanup(struct ath12k_base *ab, struct dp_srng *ring);
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 00847d579b95..45aa8ae86a14 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -9,6 +9,7 @@
 #include "htc.h"
 #include "dp_htt.h"
 #include "debugfs_htt_stats.h"
+#include "debugfs.h"
 
 static int ath12k_get_ppdu_user_index(struct htt_ppdu_stats *ppdu_stats,
 				      u16 peer_id)
@@ -642,3 +643,685 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 	dev_kfree_skb_any(skb);
 }
 EXPORT_SYMBOL(ath12k_dp_htt_htc_t2h_msg_handler);
+
+static int
+ath12k_dp_tx_get_ring_id_type(struct ath12k_base *ab,
+			      int mac_id, u32 ring_id,
+			      enum hal_ring_type ring_type,
+			      enum htt_srng_ring_type *htt_ring_type,
+			      enum htt_srng_ring_id *htt_ring_id)
+{
+	int ret = 0;
+
+	switch (ring_type) {
+	case HAL_RXDMA_BUF:
+		/* for some targets, host fills rx buffer to fw and fw fills to
+		 * rxbuf ring for each rxdma
+		 */
+		if (!ab->hw_params->rx_mac_buf_ring) {
+			if (!(ring_id == HAL_SRNG_SW2RXDMA_BUF0 ||
+			      ring_id == HAL_SRNG_SW2RXDMA_BUF1)) {
+				ret = -EINVAL;
+			}
+			*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
+			*htt_ring_type = HTT_SW_TO_HW_RING;
+		} else {
+			if (ring_id == HAL_SRNG_SW2RXDMA_BUF0) {
+				*htt_ring_id = HTT_HOST1_TO_FW_RXBUF_RING;
+				*htt_ring_type = HTT_SW_TO_SW_RING;
+			} else {
+				*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
+				*htt_ring_type = HTT_SW_TO_HW_RING;
+			}
+		}
+		break;
+	case HAL_RXDMA_DST:
+		*htt_ring_id = HTT_RXDMA_NON_MONITOR_DEST_RING;
+		*htt_ring_type = HTT_HW_TO_SW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_BUF:
+		*htt_ring_id = HTT_RX_MON_HOST2MON_BUF_RING;
+		*htt_ring_type = HTT_SW_TO_HW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_STATUS:
+		*htt_ring_id = HTT_RXDMA_MONITOR_STATUS_RING;
+		*htt_ring_type = HTT_SW_TO_HW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_DST:
+		*htt_ring_id = HTT_RX_MON_MON2HOST_DEST_RING;
+		*htt_ring_type = HTT_HW_TO_SW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_DESC:
+		*htt_ring_id = HTT_RXDMA_MONITOR_DESC_RING;
+		*htt_ring_type = HTT_SW_TO_HW_RING;
+		break;
+	default:
+		ath12k_warn(ab, "Unsupported ring type in DP :%d\n", ring_type);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
+				int mac_id, enum hal_ring_type ring_type)
+{
+	struct htt_srng_setup_cmd *cmd;
+	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
+	struct hal_srng_params params;
+	struct sk_buff *skb;
+	u32 ring_entry_sz;
+	int len = sizeof(*cmd);
+	dma_addr_t hp_addr, tp_addr;
+	enum htt_srng_ring_type htt_ring_type;
+	enum htt_srng_ring_id htt_ring_id;
+	int ret;
+
+	skb = ath12k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	memset(&params, 0, sizeof(params));
+	ath12k_hal_srng_get_params(ab, srng, &params);
+
+	hp_addr = ath12k_hal_srng_get_hp_addr(ab, srng);
+	tp_addr = ath12k_hal_srng_get_tp_addr(ab, srng);
+
+	ret = ath12k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
+					    ring_type, &htt_ring_type,
+					    &htt_ring_id);
+	if (ret)
+		goto err_free;
+
+	skb_put(skb, len);
+	cmd = (struct htt_srng_setup_cmd *)skb->data;
+	cmd->info0 = le32_encode_bits(HTT_H2T_MSG_TYPE_SRING_SETUP,
+				      HTT_SRNG_SETUP_CMD_INFO0_MSG_TYPE);
+	if (htt_ring_type == HTT_SW_TO_HW_RING ||
+	    htt_ring_type == HTT_HW_TO_SW_RING)
+		cmd->info0 |= le32_encode_bits(DP_SW2HW_MACID(mac_id),
+					       HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID);
+	else
+		cmd->info0 |= le32_encode_bits(mac_id,
+					       HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID);
+	cmd->info0 |= le32_encode_bits(htt_ring_type,
+				       HTT_SRNG_SETUP_CMD_INFO0_RING_TYPE);
+	cmd->info0 |= le32_encode_bits(htt_ring_id,
+				       HTT_SRNG_SETUP_CMD_INFO0_RING_ID);
+
+	cmd->ring_base_addr_lo = cpu_to_le32(params.ring_base_paddr &
+					     HAL_ADDR_LSB_REG_MASK);
+
+	cmd->ring_base_addr_hi = cpu_to_le32((u64)params.ring_base_paddr >>
+					     HAL_ADDR_MSB_REG_SHIFT);
+
+	ret = ath12k_hal_srng_get_entrysize(ab, ring_type);
+	if (ret < 0)
+		goto err_free;
+
+	ring_entry_sz = ret;
+
+	ring_entry_sz >>= 2;
+	cmd->info1 = le32_encode_bits(ring_entry_sz,
+				      HTT_SRNG_SETUP_CMD_INFO1_RING_ENTRY_SIZE);
+	cmd->info1 |= le32_encode_bits(params.num_entries * ring_entry_sz,
+				       HTT_SRNG_SETUP_CMD_INFO1_RING_SIZE);
+	cmd->info1 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP),
+				       HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP);
+	cmd->info1 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP),
+				       HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_TLV_SWAP);
+	cmd->info1 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_RING_PTR_SWAP),
+				       HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_HOST_FW_SWAP);
+	if (htt_ring_type == HTT_SW_TO_HW_RING)
+		cmd->info1 |= cpu_to_le32(HTT_SRNG_SETUP_CMD_INFO1_RING_LOOP_CNT_DIS);
+
+	cmd->ring_head_off32_remote_addr_lo = cpu_to_le32(lower_32_bits(hp_addr));
+	cmd->ring_head_off32_remote_addr_hi = cpu_to_le32(upper_32_bits(hp_addr));
+
+	cmd->ring_tail_off32_remote_addr_lo = cpu_to_le32(lower_32_bits(tp_addr));
+	cmd->ring_tail_off32_remote_addr_hi = cpu_to_le32(upper_32_bits(tp_addr));
+
+	cmd->ring_msi_addr_lo = cpu_to_le32(lower_32_bits(params.msi_addr));
+	cmd->ring_msi_addr_hi = cpu_to_le32(upper_32_bits(params.msi_addr));
+	cmd->msi_data = cpu_to_le32(params.msi_data);
+
+	cmd->intr_info =
+		le32_encode_bits(params.intr_batch_cntr_thres_entries * ring_entry_sz,
+				 HTT_SRNG_SETUP_CMD_INTR_INFO_BATCH_COUNTER_THRESH);
+	cmd->intr_info |=
+		le32_encode_bits(params.intr_timer_thres_us >> 3,
+				 HTT_SRNG_SETUP_CMD_INTR_INFO_INTR_TIMER_THRESH);
+
+	cmd->info2 = 0;
+	if (params.flags & HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN) {
+		cmd->info2 = le32_encode_bits(params.low_threshold,
+					      HTT_SRNG_SETUP_CMD_INFO2_INTR_LOW_THRESH);
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_HAL,
+		   "%s msi_addr_lo:0x%x, msi_addr_hi:0x%x, msi_data:0x%x\n",
+		   __func__, cmd->ring_msi_addr_lo, cmd->ring_msi_addr_hi,
+		   cmd->msi_data);
+
+	ath12k_dbg(ab, ATH12K_DBG_HAL,
+		   "ring_id:%d, ring_type:%d, intr_info:0x%x, flags:0x%x\n",
+		   ring_id, ring_type, cmd->intr_info, cmd->info2);
+
+	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+#define HTT_TARGET_VERSION_TIMEOUT_HZ (3 * HZ)
+
+int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
+{
+	struct ath12k_dp *dp = &ab->dp;
+	struct sk_buff *skb;
+	struct htt_ver_req_cmd *cmd;
+	int len = sizeof(*cmd);
+	u32 metadata_version;
+	int ret;
+
+	init_completion(&dp->htt_tgt_version_received);
+
+	skb = ath12k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, len);
+	cmd = (struct htt_ver_req_cmd *)skb->data;
+	cmd->ver_reg_info = le32_encode_bits(HTT_H2T_MSG_TYPE_VERSION_REQ,
+					     HTT_OPTION_TAG);
+	metadata_version = ath12k_ftm_mode ? HTT_OPTION_TCL_METADATA_VER_V1 :
+			   HTT_OPTION_TCL_METADATA_VER_V2;
+
+	cmd->tcl_metadata_version = le32_encode_bits(HTT_TAG_TCL_METADATA_VERSION,
+						     HTT_OPTION_TAG) |
+				    le32_encode_bits(HTT_TCL_METADATA_VER_SZ,
+						     HTT_OPTION_LEN) |
+				    le32_encode_bits(metadata_version,
+						     HTT_OPTION_VALUE);
+
+	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
+	if (ret) {
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	ret = wait_for_completion_timeout(&dp->htt_tgt_version_received,
+					  HTT_TARGET_VERSION_TIMEOUT_HZ);
+	if (ret == 0) {
+		ath12k_warn(ab, "htt target version request timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	if (dp->htt_tgt_ver_major != HTT_TARGET_VERSION_MAJOR) {
+		ath12k_err(ab, "unsupported htt major version %d supported version is %d\n",
+			   dp->htt_tgt_ver_major, HTT_TARGET_VERSION_MAJOR);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = &ab->dp;
+	struct sk_buff *skb;
+	struct htt_ppdu_stats_cfg_cmd *cmd;
+	int len = sizeof(*cmd);
+	u8 pdev_mask;
+	int ret;
+	int i;
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+		skb = ath12k_htc_alloc_skb(ab, len);
+		if (!skb)
+			return -ENOMEM;
+
+		skb_put(skb, len);
+		cmd = (struct htt_ppdu_stats_cfg_cmd *)skb->data;
+		cmd->msg = le32_encode_bits(HTT_H2T_MSG_TYPE_PPDU_STATS_CFG,
+					    HTT_PPDU_STATS_CFG_MSG_TYPE);
+
+		pdev_mask = 1 << (i + ar->pdev_idx);
+		cmd->msg |= le32_encode_bits(pdev_mask, HTT_PPDU_STATS_CFG_PDEV_ID);
+		cmd->msg |= le32_encode_bits(mask, HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK);
+
+		ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
+		if (ret) {
+			dev_kfree_skb_any(skb);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int rx_buf_size,
+				     struct htt_rx_ring_tlv_filter *tlv_filter)
+{
+	struct htt_rx_ring_selection_cfg_cmd *cmd;
+	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
+	struct hal_srng_params params;
+	struct sk_buff *skb;
+	int len = sizeof(*cmd);
+	enum htt_srng_ring_type htt_ring_type;
+	enum htt_srng_ring_id htt_ring_id;
+	int ret;
+
+	skb = ath12k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	memset(&params, 0, sizeof(params));
+	ath12k_hal_srng_get_params(ab, srng, &params);
+
+	ret = ath12k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
+					    ring_type, &htt_ring_type,
+					    &htt_ring_id);
+	if (ret)
+		goto err_free;
+
+	skb_put(skb, len);
+	cmd = (struct htt_rx_ring_selection_cfg_cmd *)skb->data;
+	cmd->info0 = le32_encode_bits(HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG,
+				      HTT_RX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE);
+	if (htt_ring_type == HTT_SW_TO_HW_RING ||
+	    htt_ring_type == HTT_HW_TO_SW_RING)
+		cmd->info0 |=
+			le32_encode_bits(DP_SW2HW_MACID(mac_id),
+					 HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
+	else
+		cmd->info0 |=
+			le32_encode_bits(mac_id,
+					 HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
+	cmd->info0 |= le32_encode_bits(htt_ring_id,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_RING_ID);
+	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP),
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_SS);
+	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP),
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PS);
+	cmd->info0 |= le32_encode_bits(tlv_filter->offset_valid,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_OFFSET_VALID);
+	cmd->info0 |=
+		le32_encode_bits(tlv_filter->drop_threshold_valid,
+				 HTT_RX_RING_SELECTION_CFG_CMD_INFO0_DROP_THRES_VAL);
+	cmd->info0 |= le32_encode_bits(!tlv_filter->rxmon_disable,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_EN_RXMON);
+
+	cmd->info1 = le32_encode_bits(rx_buf_size,
+				      HTT_RX_RING_SELECTION_CFG_CMD_INFO1_BUF_SIZE);
+	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_mgmt,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT);
+	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_ctrl,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL);
+	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_data,
+				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA);
+	cmd->pkt_type_en_flags0 = cpu_to_le32(tlv_filter->pkt_filter_flags0);
+	cmd->pkt_type_en_flags1 = cpu_to_le32(tlv_filter->pkt_filter_flags1);
+	cmd->pkt_type_en_flags2 = cpu_to_le32(tlv_filter->pkt_filter_flags2);
+	cmd->pkt_type_en_flags3 = cpu_to_le32(tlv_filter->pkt_filter_flags3);
+	cmd->rx_filter_tlv = cpu_to_le32(tlv_filter->rx_filter);
+
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
+	if (tlv_filter->offset_valid) {
+		cmd->rx_packet_offset =
+			le32_encode_bits(tlv_filter->rx_packet_offset,
+					 HTT_RX_RING_SELECTION_CFG_RX_PACKET_OFFSET);
+
+		cmd->rx_packet_offset |=
+			le32_encode_bits(tlv_filter->rx_header_offset,
+					 HTT_RX_RING_SELECTION_CFG_RX_HEADER_OFFSET);
+
+		cmd->rx_mpdu_offset =
+			le32_encode_bits(tlv_filter->rx_mpdu_end_offset,
+					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_OFFSET);
+
+		cmd->rx_mpdu_offset |=
+			le32_encode_bits(tlv_filter->rx_mpdu_start_offset,
+					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_OFFSET);
+
+		cmd->rx_msdu_offset =
+			le32_encode_bits(tlv_filter->rx_msdu_end_offset,
+					 HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_OFFSET);
+
+		cmd->rx_msdu_offset |=
+			le32_encode_bits(tlv_filter->rx_msdu_start_offset,
+					 HTT_RX_RING_SELECTION_CFG_RX_MSDU_START_OFFSET);
+
+		cmd->rx_attn_offset =
+			le32_encode_bits(tlv_filter->rx_attn_offset,
+					 HTT_RX_RING_SELECTION_CFG_RX_ATTENTION_OFFSET);
+	}
+
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
+	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int
+ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
+				   struct htt_ext_stats_cfg_params *cfg_params,
+				   u64 cookie)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = &ab->dp;
+	struct sk_buff *skb;
+	struct htt_ext_stats_cfg_cmd *cmd;
+	int len = sizeof(*cmd);
+	int ret;
+	u32 pdev_id;
+
+	skb = ath12k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, len);
+
+	cmd = (struct htt_ext_stats_cfg_cmd *)skb->data;
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
+
+	pdev_id = ath12k_mac_get_target_pdev_id(ar);
+	cmd->hdr.pdev_mask = 1 << pdev_id;
+
+	cmd->hdr.stats_type = type;
+	cmd->cfg_param0 = cpu_to_le32(cfg_params->cfg0);
+	cmd->cfg_param1 = cpu_to_le32(cfg_params->cfg1);
+	cmd->cfg_param2 = cpu_to_le32(cfg_params->cfg2);
+	cmd->cfg_param3 = cpu_to_le32(cfg_params->cfg3);
+	cmd->cookie_lsb = cpu_to_le32(lower_32_bits(cookie));
+	cmd->cookie_msb = cpu_to_le32(upper_32_bits(cookie));
+
+	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
+	if (ret) {
+		ath12k_warn(ab, "failed to send htt type stats request: %d",
+			    ret);
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
+{
+	struct ath12k_base *ab = ar->ab;
+	int ret;
+
+	ret = ath12k_dp_tx_htt_rx_monitor_mode_ring_config(ar, reset);
+	if (ret) {
+		ath12k_err(ab, "failed to setup rx monitor filter %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
+	int ret, ring_id, i;
+
+	tlv_filter.offset_valid = false;
+
+	if (!reset) {
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
+		tlv_filter.pkt_filter_flags0 =
+					HTT_RX_MON_FP_MGMT_FILTER_FLAGS0 |
+					HTT_RX_MON_MO_MGMT_FILTER_FLAGS0;
+		tlv_filter.pkt_filter_flags1 =
+					HTT_RX_MON_FP_MGMT_FILTER_FLAGS1 |
+					HTT_RX_MON_MO_MGMT_FILTER_FLAGS1;
+		tlv_filter.pkt_filter_flags2 =
+					HTT_RX_MON_FP_CTRL_FILTER_FLASG2 |
+					HTT_RX_MON_MO_CTRL_FILTER_FLASG2;
+		tlv_filter.pkt_filter_flags3 =
+					HTT_RX_MON_FP_CTRL_FILTER_FLASG3 |
+					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
+					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
+					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
+	} else {
+		tlv_filter = ath12k_mac_mon_status_filter_default;
+
+		if (ath12k_debugfs_is_extd_rx_stats_enabled(ar))
+			tlv_filter.rx_filter = ath12k_debugfs_rx_filter(ar);
+	}
+
+	if (ab->hw_params->rxdma1_enable) {
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
+		}
+		return 0;
+	}
+
+	if (!reset) {
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+			ring_id = ab->dp.rx_mac_buf_ring[i].ring_id;
+			ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
+							       i,
+							       HAL_RXDMA_BUF,
+							       DP_RXDMA_REFILL_RING_SIZE,
+							       &tlv_filter);
+			if (ret) {
+				ath12k_err(ab,
+					   "failed to setup filter for mon rx buf %d\n",
+					   ret);
+				return ret;
+			}
+		}
+	}
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+		ring_id = ab->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		if (!reset) {
+			tlv_filter.rx_filter =
+				HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
+		}
+
+		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id,
+						       i,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       RX_MON_STATUS_BUF_SIZE,
+						       &tlv_filter);
+		if (ret) {
+			ath12k_err(ab,
+				   "failed to setup filter for mon status buf %d\n",
+				   ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int tx_buf_size,
+				     struct htt_tx_ring_tlv_filter *htt_tlv_filter)
+{
+	struct htt_tx_ring_selection_cfg_cmd *cmd;
+	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
+	struct hal_srng_params params;
+	struct sk_buff *skb;
+	int len = sizeof(*cmd);
+	enum htt_srng_ring_type htt_ring_type;
+	enum htt_srng_ring_id htt_ring_id;
+	int ret;
+
+	skb = ath12k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	memset(&params, 0, sizeof(params));
+	ath12k_hal_srng_get_params(ab, srng, &params);
+
+	ret = ath12k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
+					    ring_type, &htt_ring_type,
+					    &htt_ring_id);
+
+	if (ret)
+		goto err_free;
+
+	skb_put(skb, len);
+	cmd = (struct htt_tx_ring_selection_cfg_cmd *)skb->data;
+	cmd->info0 = le32_encode_bits(HTT_H2T_MSG_TYPE_TX_MONITOR_CFG,
+				      HTT_TX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE);
+	if (htt_ring_type == HTT_SW_TO_HW_RING ||
+	    htt_ring_type == HTT_HW_TO_SW_RING)
+		cmd->info0 |=
+			le32_encode_bits(DP_SW2HW_MACID(mac_id),
+					 HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
+	else
+		cmd->info0 |=
+			le32_encode_bits(mac_id,
+					 HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
+	cmd->info0 |= le32_encode_bits(htt_ring_id,
+				       HTT_TX_RING_SELECTION_CFG_CMD_INFO0_RING_ID);
+	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP),
+				       HTT_TX_RING_SELECTION_CFG_CMD_INFO0_SS);
+	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP),
+				       HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PS);
+
+	cmd->info1 |=
+		le32_encode_bits(tx_buf_size,
+				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_RING_BUFF_SIZE);
+
+	if (htt_tlv_filter->tx_mon_mgmt_filter) {
+		cmd->info1 |=
+			le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_MGMT,
+					 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE);
+		cmd->info1 |=
+		le32_encode_bits(htt_tlv_filter->tx_mon_pkt_dma_len,
+				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT);
+		cmd->info2 |=
+		le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_MGMT,
+				 HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG);
+	}
+
+	if (htt_tlv_filter->tx_mon_data_filter) {
+		cmd->info1 |=
+			le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_CTRL,
+					 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE);
+		cmd->info1 |=
+		le32_encode_bits(htt_tlv_filter->tx_mon_pkt_dma_len,
+				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL);
+		cmd->info2 |=
+		le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_CTRL,
+				 HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG);
+	}
+
+	if (htt_tlv_filter->tx_mon_ctrl_filter) {
+		cmd->info1 |=
+			le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_DATA,
+					 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE);
+		cmd->info1 |=
+		le32_encode_bits(htt_tlv_filter->tx_mon_pkt_dma_len,
+				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA);
+		cmd->info2 |=
+		le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_DATA,
+				 HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG);
+	}
+
+	cmd->tlv_filter_mask_in0 =
+		cpu_to_le32(htt_tlv_filter->tx_mon_downstream_tlv_flags);
+	cmd->tlv_filter_mask_in1 =
+		cpu_to_le32(htt_tlv_filter->tx_mon_upstream_tlv_flags0);
+	cmd->tlv_filter_mask_in2 =
+		cpu_to_le32(htt_tlv_filter->tx_mon_upstream_tlv_flags1);
+	cmd->tlv_filter_mask_in3 =
+		cpu_to_le32(htt_tlv_filter->tx_mon_upstream_tlv_flags2);
+
+	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dev_kfree_skb_any(skb);
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.h b/drivers/net/wireless/ath/ath12k/dp_htt.h
index 9ae3a750f608..b13af1c69253 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.h
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.h
@@ -1514,10 +1514,30 @@ struct htt_mac_addr {
 	__le32 mac_addr_h16;
 } __packed;
 
+int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
+				int mac_id, enum hal_ring_type ring_type);
+
+void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
+				       struct sk_buff *skb);
 int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
 				       const void *ptr, void *data),
 				       void *data);
-void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
-				       struct sk_buff *skb);
+int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
+int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask);
+int
+ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
+				   struct htt_ext_stats_cfg_params *cfg_params,
+				   u64 cookie);
+int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset);
+
+int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int rx_buf_size,
+				     struct htt_rx_ring_tlv_filter *tlv_filter);
+int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int tx_buf_size,
+				     struct htt_tx_ring_tlv_filter *htt_tlv_filter);
+int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index c7b0fc22c1a7..8d5e10781377 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -200,685 +200,3 @@ void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
 }
-
-static int
-ath12k_dp_tx_get_ring_id_type(struct ath12k_base *ab,
-			      int mac_id, u32 ring_id,
-			      enum hal_ring_type ring_type,
-			      enum htt_srng_ring_type *htt_ring_type,
-			      enum htt_srng_ring_id *htt_ring_id)
-{
-	int ret = 0;
-
-	switch (ring_type) {
-	case HAL_RXDMA_BUF:
-		/* for some targets, host fills rx buffer to fw and fw fills to
-		 * rxbuf ring for each rxdma
-		 */
-		if (!ab->hw_params->rx_mac_buf_ring) {
-			if (!(ring_id == HAL_SRNG_SW2RXDMA_BUF0 ||
-			      ring_id == HAL_SRNG_SW2RXDMA_BUF1)) {
-				ret = -EINVAL;
-			}
-			*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
-			*htt_ring_type = HTT_SW_TO_HW_RING;
-		} else {
-			if (ring_id == HAL_SRNG_SW2RXDMA_BUF0) {
-				*htt_ring_id = HTT_HOST1_TO_FW_RXBUF_RING;
-				*htt_ring_type = HTT_SW_TO_SW_RING;
-			} else {
-				*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
-				*htt_ring_type = HTT_SW_TO_HW_RING;
-			}
-		}
-		break;
-	case HAL_RXDMA_DST:
-		*htt_ring_id = HTT_RXDMA_NON_MONITOR_DEST_RING;
-		*htt_ring_type = HTT_HW_TO_SW_RING;
-		break;
-	case HAL_RXDMA_MONITOR_BUF:
-		*htt_ring_id = HTT_RX_MON_HOST2MON_BUF_RING;
-		*htt_ring_type = HTT_SW_TO_HW_RING;
-		break;
-	case HAL_RXDMA_MONITOR_STATUS:
-		*htt_ring_id = HTT_RXDMA_MONITOR_STATUS_RING;
-		*htt_ring_type = HTT_SW_TO_HW_RING;
-		break;
-	case HAL_RXDMA_MONITOR_DST:
-		*htt_ring_id = HTT_RX_MON_MON2HOST_DEST_RING;
-		*htt_ring_type = HTT_HW_TO_SW_RING;
-		break;
-	case HAL_RXDMA_MONITOR_DESC:
-		*htt_ring_id = HTT_RXDMA_MONITOR_DESC_RING;
-		*htt_ring_type = HTT_SW_TO_HW_RING;
-		break;
-	default:
-		ath12k_warn(ab, "Unsupported ring type in DP :%d\n", ring_type);
-		ret = -EINVAL;
-	}
-	return ret;
-}
-
-int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
-				int mac_id, enum hal_ring_type ring_type)
-{
-	struct htt_srng_setup_cmd *cmd;
-	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
-	struct hal_srng_params params;
-	struct sk_buff *skb;
-	u32 ring_entry_sz;
-	int len = sizeof(*cmd);
-	dma_addr_t hp_addr, tp_addr;
-	enum htt_srng_ring_type htt_ring_type;
-	enum htt_srng_ring_id htt_ring_id;
-	int ret;
-
-	skb = ath12k_htc_alloc_skb(ab, len);
-	if (!skb)
-		return -ENOMEM;
-
-	memset(&params, 0, sizeof(params));
-	ath12k_hal_srng_get_params(ab, srng, &params);
-
-	hp_addr = ath12k_hal_srng_get_hp_addr(ab, srng);
-	tp_addr = ath12k_hal_srng_get_tp_addr(ab, srng);
-
-	ret = ath12k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
-					    ring_type, &htt_ring_type,
-					    &htt_ring_id);
-	if (ret)
-		goto err_free;
-
-	skb_put(skb, len);
-	cmd = (struct htt_srng_setup_cmd *)skb->data;
-	cmd->info0 = le32_encode_bits(HTT_H2T_MSG_TYPE_SRING_SETUP,
-				      HTT_SRNG_SETUP_CMD_INFO0_MSG_TYPE);
-	if (htt_ring_type == HTT_SW_TO_HW_RING ||
-	    htt_ring_type == HTT_HW_TO_SW_RING)
-		cmd->info0 |= le32_encode_bits(DP_SW2HW_MACID(mac_id),
-					       HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID);
-	else
-		cmd->info0 |= le32_encode_bits(mac_id,
-					       HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID);
-	cmd->info0 |= le32_encode_bits(htt_ring_type,
-				       HTT_SRNG_SETUP_CMD_INFO0_RING_TYPE);
-	cmd->info0 |= le32_encode_bits(htt_ring_id,
-				       HTT_SRNG_SETUP_CMD_INFO0_RING_ID);
-
-	cmd->ring_base_addr_lo = cpu_to_le32(params.ring_base_paddr &
-					     HAL_ADDR_LSB_REG_MASK);
-
-	cmd->ring_base_addr_hi = cpu_to_le32((u64)params.ring_base_paddr >>
-					     HAL_ADDR_MSB_REG_SHIFT);
-
-	ret = ath12k_hal_srng_get_entrysize(ab, ring_type);
-	if (ret < 0)
-		goto err_free;
-
-	ring_entry_sz = ret;
-
-	ring_entry_sz >>= 2;
-	cmd->info1 = le32_encode_bits(ring_entry_sz,
-				      HTT_SRNG_SETUP_CMD_INFO1_RING_ENTRY_SIZE);
-	cmd->info1 |= le32_encode_bits(params.num_entries * ring_entry_sz,
-				       HTT_SRNG_SETUP_CMD_INFO1_RING_SIZE);
-	cmd->info1 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP),
-				       HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP);
-	cmd->info1 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP),
-				       HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_TLV_SWAP);
-	cmd->info1 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_RING_PTR_SWAP),
-				       HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_HOST_FW_SWAP);
-	if (htt_ring_type == HTT_SW_TO_HW_RING)
-		cmd->info1 |= cpu_to_le32(HTT_SRNG_SETUP_CMD_INFO1_RING_LOOP_CNT_DIS);
-
-	cmd->ring_head_off32_remote_addr_lo = cpu_to_le32(lower_32_bits(hp_addr));
-	cmd->ring_head_off32_remote_addr_hi = cpu_to_le32(upper_32_bits(hp_addr));
-
-	cmd->ring_tail_off32_remote_addr_lo = cpu_to_le32(lower_32_bits(tp_addr));
-	cmd->ring_tail_off32_remote_addr_hi = cpu_to_le32(upper_32_bits(tp_addr));
-
-	cmd->ring_msi_addr_lo = cpu_to_le32(lower_32_bits(params.msi_addr));
-	cmd->ring_msi_addr_hi = cpu_to_le32(upper_32_bits(params.msi_addr));
-	cmd->msi_data = cpu_to_le32(params.msi_data);
-
-	cmd->intr_info =
-		le32_encode_bits(params.intr_batch_cntr_thres_entries * ring_entry_sz,
-				 HTT_SRNG_SETUP_CMD_INTR_INFO_BATCH_COUNTER_THRESH);
-	cmd->intr_info |=
-		le32_encode_bits(params.intr_timer_thres_us >> 3,
-				 HTT_SRNG_SETUP_CMD_INTR_INFO_INTR_TIMER_THRESH);
-
-	cmd->info2 = 0;
-	if (params.flags & HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN) {
-		cmd->info2 = le32_encode_bits(params.low_threshold,
-					      HTT_SRNG_SETUP_CMD_INFO2_INTR_LOW_THRESH);
-	}
-
-	ath12k_dbg(ab, ATH12K_DBG_HAL,
-		   "%s msi_addr_lo:0x%x, msi_addr_hi:0x%x, msi_data:0x%x\n",
-		   __func__, cmd->ring_msi_addr_lo, cmd->ring_msi_addr_hi,
-		   cmd->msi_data);
-
-	ath12k_dbg(ab, ATH12K_DBG_HAL,
-		   "ring_id:%d, ring_type:%d, intr_info:0x%x, flags:0x%x\n",
-		   ring_id, ring_type, cmd->intr_info, cmd->info2);
-
-	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
-	if (ret)
-		goto err_free;
-
-	return 0;
-
-err_free:
-	dev_kfree_skb_any(skb);
-
-	return ret;
-}
-
-#define HTT_TARGET_VERSION_TIMEOUT_HZ (3 * HZ)
-
-int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
-{
-	struct ath12k_dp *dp = &ab->dp;
-	struct sk_buff *skb;
-	struct htt_ver_req_cmd *cmd;
-	int len = sizeof(*cmd);
-	u32 metadata_version;
-	int ret;
-
-	init_completion(&dp->htt_tgt_version_received);
-
-	skb = ath12k_htc_alloc_skb(ab, len);
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put(skb, len);
-	cmd = (struct htt_ver_req_cmd *)skb->data;
-	cmd->ver_reg_info = le32_encode_bits(HTT_H2T_MSG_TYPE_VERSION_REQ,
-					     HTT_OPTION_TAG);
-	metadata_version = ath12k_ftm_mode ? HTT_OPTION_TCL_METADATA_VER_V1 :
-			   HTT_OPTION_TCL_METADATA_VER_V2;
-
-	cmd->tcl_metadata_version = le32_encode_bits(HTT_TAG_TCL_METADATA_VERSION,
-						     HTT_OPTION_TAG) |
-				    le32_encode_bits(HTT_TCL_METADATA_VER_SZ,
-						     HTT_OPTION_LEN) |
-				    le32_encode_bits(metadata_version,
-						     HTT_OPTION_VALUE);
-
-	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
-	if (ret) {
-		dev_kfree_skb_any(skb);
-		return ret;
-	}
-
-	ret = wait_for_completion_timeout(&dp->htt_tgt_version_received,
-					  HTT_TARGET_VERSION_TIMEOUT_HZ);
-	if (ret == 0) {
-		ath12k_warn(ab, "htt target version request timed out\n");
-		return -ETIMEDOUT;
-	}
-
-	if (dp->htt_tgt_ver_major != HTT_TARGET_VERSION_MAJOR) {
-		ath12k_err(ab, "unsupported htt major version %d supported version is %d\n",
-			   dp->htt_tgt_ver_major, HTT_TARGET_VERSION_MAJOR);
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
-	struct sk_buff *skb;
-	struct htt_ppdu_stats_cfg_cmd *cmd;
-	int len = sizeof(*cmd);
-	u8 pdev_mask;
-	int ret;
-	int i;
-
-	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
-		skb = ath12k_htc_alloc_skb(ab, len);
-		if (!skb)
-			return -ENOMEM;
-
-		skb_put(skb, len);
-		cmd = (struct htt_ppdu_stats_cfg_cmd *)skb->data;
-		cmd->msg = le32_encode_bits(HTT_H2T_MSG_TYPE_PPDU_STATS_CFG,
-					    HTT_PPDU_STATS_CFG_MSG_TYPE);
-
-		pdev_mask = 1 << (i + ar->pdev_idx);
-		cmd->msg |= le32_encode_bits(pdev_mask, HTT_PPDU_STATS_CFG_PDEV_ID);
-		cmd->msg |= le32_encode_bits(mask, HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK);
-
-		ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
-		if (ret) {
-			dev_kfree_skb_any(skb);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
-				     int mac_id, enum hal_ring_type ring_type,
-				     int rx_buf_size,
-				     struct htt_rx_ring_tlv_filter *tlv_filter)
-{
-	struct htt_rx_ring_selection_cfg_cmd *cmd;
-	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
-	struct hal_srng_params params;
-	struct sk_buff *skb;
-	int len = sizeof(*cmd);
-	enum htt_srng_ring_type htt_ring_type;
-	enum htt_srng_ring_id htt_ring_id;
-	int ret;
-
-	skb = ath12k_htc_alloc_skb(ab, len);
-	if (!skb)
-		return -ENOMEM;
-
-	memset(&params, 0, sizeof(params));
-	ath12k_hal_srng_get_params(ab, srng, &params);
-
-	ret = ath12k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
-					    ring_type, &htt_ring_type,
-					    &htt_ring_id);
-	if (ret)
-		goto err_free;
-
-	skb_put(skb, len);
-	cmd = (struct htt_rx_ring_selection_cfg_cmd *)skb->data;
-	cmd->info0 = le32_encode_bits(HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG,
-				      HTT_RX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE);
-	if (htt_ring_type == HTT_SW_TO_HW_RING ||
-	    htt_ring_type == HTT_HW_TO_SW_RING)
-		cmd->info0 |=
-			le32_encode_bits(DP_SW2HW_MACID(mac_id),
-					 HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
-	else
-		cmd->info0 |=
-			le32_encode_bits(mac_id,
-					 HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
-	cmd->info0 |= le32_encode_bits(htt_ring_id,
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_RING_ID);
-	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP),
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_SS);
-	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP),
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PS);
-	cmd->info0 |= le32_encode_bits(tlv_filter->offset_valid,
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_OFFSET_VALID);
-	cmd->info0 |=
-		le32_encode_bits(tlv_filter->drop_threshold_valid,
-				 HTT_RX_RING_SELECTION_CFG_CMD_INFO0_DROP_THRES_VAL);
-	cmd->info0 |= le32_encode_bits(!tlv_filter->rxmon_disable,
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO0_EN_RXMON);
-
-	cmd->info1 = le32_encode_bits(rx_buf_size,
-				      HTT_RX_RING_SELECTION_CFG_CMD_INFO1_BUF_SIZE);
-	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_mgmt,
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT);
-	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_ctrl,
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL);
-	cmd->info1 |= le32_encode_bits(tlv_filter->conf_len_data,
-				       HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA);
-	cmd->pkt_type_en_flags0 = cpu_to_le32(tlv_filter->pkt_filter_flags0);
-	cmd->pkt_type_en_flags1 = cpu_to_le32(tlv_filter->pkt_filter_flags1);
-	cmd->pkt_type_en_flags2 = cpu_to_le32(tlv_filter->pkt_filter_flags2);
-	cmd->pkt_type_en_flags3 = cpu_to_le32(tlv_filter->pkt_filter_flags3);
-	cmd->rx_filter_tlv = cpu_to_le32(tlv_filter->rx_filter);
-
-	cmd->info2 = le32_encode_bits(tlv_filter->rx_drop_threshold,
-				      HTT_RX_RING_SELECTION_CFG_CMD_INFO2_DROP_THRESHOLD);
-	cmd->info2 |=
-		le32_encode_bits(tlv_filter->enable_log_mgmt_type,
-				 HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_MGMT_TYPE);
-	cmd->info2 |=
-		le32_encode_bits(tlv_filter->enable_log_ctrl_type,
-				 HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_CTRL_TYPE);
-	cmd->info2 |=
-		le32_encode_bits(tlv_filter->enable_log_data_type,
-				 HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_DATA_TYPE);
-
-	cmd->info3 =
-		le32_encode_bits(tlv_filter->enable_rx_tlv_offset,
-				 HTT_RX_RING_SELECTION_CFG_CMD_INFO3_EN_TLV_PKT_OFFSET);
-	cmd->info3 |=
-		le32_encode_bits(tlv_filter->rx_tlv_offset,
-				 HTT_RX_RING_SELECTION_CFG_CMD_INFO3_PKT_TLV_OFFSET);
-
-	if (tlv_filter->offset_valid) {
-		cmd->rx_packet_offset =
-			le32_encode_bits(tlv_filter->rx_packet_offset,
-					 HTT_RX_RING_SELECTION_CFG_RX_PACKET_OFFSET);
-
-		cmd->rx_packet_offset |=
-			le32_encode_bits(tlv_filter->rx_header_offset,
-					 HTT_RX_RING_SELECTION_CFG_RX_HEADER_OFFSET);
-
-		cmd->rx_mpdu_offset =
-			le32_encode_bits(tlv_filter->rx_mpdu_end_offset,
-					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_OFFSET);
-
-		cmd->rx_mpdu_offset |=
-			le32_encode_bits(tlv_filter->rx_mpdu_start_offset,
-					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_OFFSET);
-
-		cmd->rx_msdu_offset =
-			le32_encode_bits(tlv_filter->rx_msdu_end_offset,
-					 HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_OFFSET);
-
-		cmd->rx_msdu_offset |=
-			le32_encode_bits(tlv_filter->rx_msdu_start_offset,
-					 HTT_RX_RING_SELECTION_CFG_RX_MSDU_START_OFFSET);
-
-		cmd->rx_attn_offset =
-			le32_encode_bits(tlv_filter->rx_attn_offset,
-					 HTT_RX_RING_SELECTION_CFG_RX_ATTENTION_OFFSET);
-	}
-
-	if (tlv_filter->rx_mpdu_start_wmask > 0 &&
-	    tlv_filter->rx_msdu_end_wmask > 0) {
-		cmd->info2 |=
-			le32_encode_bits(true,
-					 HTT_RX_RING_SELECTION_CFG_WORD_MASK_COMPACT_SET);
-		cmd->rx_mpdu_start_end_mask =
-			le32_encode_bits(tlv_filter->rx_mpdu_start_wmask,
-					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_MASK);
-		/* mpdu_end is not used for any hardwares so far
-		 * please assign it in future if any chip is
-		 * using through hal ops
-		 */
-		cmd->rx_mpdu_start_end_mask |=
-			le32_encode_bits(tlv_filter->rx_mpdu_end_wmask,
-					 HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_MASK);
-		cmd->rx_msdu_end_word_mask =
-			le32_encode_bits(tlv_filter->rx_msdu_end_wmask,
-					 HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_MASK);
-	}
-
-	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
-	if (ret)
-		goto err_free;
-
-	return 0;
-
-err_free:
-	dev_kfree_skb_any(skb);
-
-	return ret;
-}
-
-int
-ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
-				   struct htt_ext_stats_cfg_params *cfg_params,
-				   u64 cookie)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
-	struct sk_buff *skb;
-	struct htt_ext_stats_cfg_cmd *cmd;
-	int len = sizeof(*cmd);
-	int ret;
-	u32 pdev_id;
-
-	skb = ath12k_htc_alloc_skb(ab, len);
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put(skb, len);
-
-	cmd = (struct htt_ext_stats_cfg_cmd *)skb->data;
-	memset(cmd, 0, sizeof(*cmd));
-	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
-
-	pdev_id = ath12k_mac_get_target_pdev_id(ar);
-	cmd->hdr.pdev_mask = 1 << pdev_id;
-
-	cmd->hdr.stats_type = type;
-	cmd->cfg_param0 = cpu_to_le32(cfg_params->cfg0);
-	cmd->cfg_param1 = cpu_to_le32(cfg_params->cfg1);
-	cmd->cfg_param2 = cpu_to_le32(cfg_params->cfg2);
-	cmd->cfg_param3 = cpu_to_le32(cfg_params->cfg3);
-	cmd->cookie_lsb = cpu_to_le32(lower_32_bits(cookie));
-	cmd->cookie_msb = cpu_to_le32(upper_32_bits(cookie));
-
-	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
-	if (ret) {
-		ath12k_warn(ab, "failed to send htt type stats request: %d",
-			    ret);
-		dev_kfree_skb_any(skb);
-		return ret;
-	}
-
-	return 0;
-}
-
-int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
-{
-	struct ath12k_base *ab = ar->ab;
-	int ret;
-
-	ret = ath12k_dp_tx_htt_rx_monitor_mode_ring_config(ar, reset);
-	if (ret) {
-		ath12k_err(ab, "failed to setup rx monitor filter %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {};
-	int ret, ring_id, i;
-
-	tlv_filter.offset_valid = false;
-
-	if (!reset) {
-		tlv_filter.rx_filter = HTT_RX_MON_FILTER_TLV_FLAGS_MON_DEST_RING;
-
-		tlv_filter.drop_threshold_valid = true;
-		tlv_filter.rx_drop_threshold = HTT_RX_RING_TLV_DROP_THRESHOLD_VALUE;
-
-		tlv_filter.enable_log_mgmt_type = true;
-		tlv_filter.enable_log_ctrl_type = true;
-		tlv_filter.enable_log_data_type = true;
-
-		tlv_filter.conf_len_ctrl = HTT_RX_RING_DEFAULT_DMA_LENGTH;
-		tlv_filter.conf_len_mgmt = HTT_RX_RING_DEFAULT_DMA_LENGTH;
-		tlv_filter.conf_len_data = HTT_RX_RING_DEFAULT_DMA_LENGTH;
-
-		tlv_filter.enable_rx_tlv_offset = true;
-		tlv_filter.rx_tlv_offset = HTT_RX_RING_PKT_TLV_OFFSET;
-
-		tlv_filter.pkt_filter_flags0 =
-					HTT_RX_MON_FP_MGMT_FILTER_FLAGS0 |
-					HTT_RX_MON_MO_MGMT_FILTER_FLAGS0;
-		tlv_filter.pkt_filter_flags1 =
-					HTT_RX_MON_FP_MGMT_FILTER_FLAGS1 |
-					HTT_RX_MON_MO_MGMT_FILTER_FLAGS1;
-		tlv_filter.pkt_filter_flags2 =
-					HTT_RX_MON_FP_CTRL_FILTER_FLASG2 |
-					HTT_RX_MON_MO_CTRL_FILTER_FLASG2;
-		tlv_filter.pkt_filter_flags3 =
-					HTT_RX_MON_FP_CTRL_FILTER_FLASG3 |
-					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
-					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
-					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
-	} else {
-		tlv_filter = ath12k_mac_mon_status_filter_default;
-
-		if (ath12k_debugfs_is_extd_rx_stats_enabled(ar))
-			tlv_filter.rx_filter = ath12k_debugfs_rx_filter(ar);
-	}
-
-	if (ab->hw_params->rxdma1_enable) {
-		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
-			ring_id = ar->dp.rxdma_mon_dst_ring[i].ring_id;
-			ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
-							       ar->dp.mac_id + i,
-							       HAL_RXDMA_MONITOR_DST,
-							       DP_RXDMA_REFILL_RING_SIZE,
-							       &tlv_filter);
-			if (ret) {
-				ath12k_err(ab,
-					   "failed to setup filter for monitor buf %d\n",
-					   ret);
-				return ret;
-			}
-		}
-		return 0;
-	}
-
-	if (!reset) {
-		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
-			ring_id = ab->dp.rx_mac_buf_ring[i].ring_id;
-			ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
-							       i,
-							       HAL_RXDMA_BUF,
-							       DP_RXDMA_REFILL_RING_SIZE,
-							       &tlv_filter);
-			if (ret) {
-				ath12k_err(ab,
-					   "failed to setup filter for mon rx buf %d\n",
-					   ret);
-				return ret;
-			}
-		}
-	}
-
-	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
-		ring_id = ab->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
-		if (!reset) {
-			tlv_filter.rx_filter =
-				HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
-		}
-
-		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id,
-						       i,
-						       HAL_RXDMA_MONITOR_STATUS,
-						       RX_MON_STATUS_BUF_SIZE,
-						       &tlv_filter);
-		if (ret) {
-			ath12k_err(ab,
-				   "failed to setup filter for mon status buf %d\n",
-				   ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
-				     int mac_id, enum hal_ring_type ring_type,
-				     int tx_buf_size,
-				     struct htt_tx_ring_tlv_filter *htt_tlv_filter)
-{
-	struct htt_tx_ring_selection_cfg_cmd *cmd;
-	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
-	struct hal_srng_params params;
-	struct sk_buff *skb;
-	int len = sizeof(*cmd);
-	enum htt_srng_ring_type htt_ring_type;
-	enum htt_srng_ring_id htt_ring_id;
-	int ret;
-
-	skb = ath12k_htc_alloc_skb(ab, len);
-	if (!skb)
-		return -ENOMEM;
-
-	memset(&params, 0, sizeof(params));
-	ath12k_hal_srng_get_params(ab, srng, &params);
-
-	ret = ath12k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
-					    ring_type, &htt_ring_type,
-					    &htt_ring_id);
-
-	if (ret)
-		goto err_free;
-
-	skb_put(skb, len);
-	cmd = (struct htt_tx_ring_selection_cfg_cmd *)skb->data;
-	cmd->info0 = le32_encode_bits(HTT_H2T_MSG_TYPE_TX_MONITOR_CFG,
-				      HTT_TX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE);
-	if (htt_ring_type == HTT_SW_TO_HW_RING ||
-	    htt_ring_type == HTT_HW_TO_SW_RING)
-		cmd->info0 |=
-			le32_encode_bits(DP_SW2HW_MACID(mac_id),
-					 HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
-	else
-		cmd->info0 |=
-			le32_encode_bits(mac_id,
-					 HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID);
-	cmd->info0 |= le32_encode_bits(htt_ring_id,
-				       HTT_TX_RING_SELECTION_CFG_CMD_INFO0_RING_ID);
-	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP),
-				       HTT_TX_RING_SELECTION_CFG_CMD_INFO0_SS);
-	cmd->info0 |= le32_encode_bits(!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP),
-				       HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PS);
-
-	cmd->info1 |=
-		le32_encode_bits(tx_buf_size,
-				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_RING_BUFF_SIZE);
-
-	if (htt_tlv_filter->tx_mon_mgmt_filter) {
-		cmd->info1 |=
-			le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_MGMT,
-					 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE);
-		cmd->info1 |=
-		le32_encode_bits(htt_tlv_filter->tx_mon_pkt_dma_len,
-				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT);
-		cmd->info2 |=
-		le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_MGMT,
-				 HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG);
-	}
-
-	if (htt_tlv_filter->tx_mon_data_filter) {
-		cmd->info1 |=
-			le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_CTRL,
-					 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE);
-		cmd->info1 |=
-		le32_encode_bits(htt_tlv_filter->tx_mon_pkt_dma_len,
-				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL);
-		cmd->info2 |=
-		le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_CTRL,
-				 HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG);
-	}
-
-	if (htt_tlv_filter->tx_mon_ctrl_filter) {
-		cmd->info1 |=
-			le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_DATA,
-					 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE);
-		cmd->info1 |=
-		le32_encode_bits(htt_tlv_filter->tx_mon_pkt_dma_len,
-				 HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA);
-		cmd->info2 |=
-		le32_encode_bits(HTT_STATS_FRAME_CTRL_TYPE_DATA,
-				 HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG);
-	}
-
-	cmd->tlv_filter_mask_in0 =
-		cpu_to_le32(htt_tlv_filter->tx_mon_downstream_tlv_flags);
-	cmd->tlv_filter_mask_in1 =
-		cpu_to_le32(htt_tlv_filter->tx_mon_upstream_tlv_flags0);
-	cmd->tlv_filter_mask_in2 =
-		cpu_to_le32(htt_tlv_filter->tx_mon_upstream_tlv_flags1);
-	cmd->tlv_filter_mask_in3 =
-		cpu_to_le32(htt_tlv_filter->tx_mon_upstream_tlv_flags2);
-
-	ret = ath12k_htc_send(&ab->htc, ab->dp.eid, skb);
-	if (ret)
-		goto err_free;
-
-	return 0;
-
-err_free:
-	dev_kfree_skb_any(skb);
-	return ret;
-}
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 8405a0baf95b..5b8fe280c32a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -15,25 +15,7 @@ struct ath12k_dp_htt_wbm_tx_status {
 	s8 ack_rssi;
 };
 
-int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
-int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask);
-int
-ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
-				   struct htt_ext_stats_cfg_params *cfg_params,
-				   u64 cookie);
-int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset);
-
-int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
-				     int mac_id, enum hal_ring_type ring_type,
-				     int rx_buf_size,
-				     struct htt_rx_ring_tlv_filter *tlv_filter);
 void ath12k_dp_tx_put_bank_profile(struct ath12k_dp *dp, u8 bank_id);
-int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
-				     int mac_id, enum hal_ring_type ring_type,
-				     int tx_buf_size,
-				     struct htt_tx_ring_tlv_filter *htt_tlv_filter);
-int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset);
-
 enum hal_tcl_encap_type
 ath12k_dp_tx_get_encap_type(struct ath12k_base *ab, struct sk_buff *skb);
 void ath12k_dp_tx_encap_nwifi(struct sk_buff *skb);
-- 
2.34.1


