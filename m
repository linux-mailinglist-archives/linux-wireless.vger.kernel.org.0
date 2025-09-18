Return-Path: <linux-wireless+bounces-26829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E07B3A84F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8638A203B71
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479833EB10;
	Thu, 28 Aug 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="csNcILRg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06533CEBA
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402605; cv=none; b=nNQvUi1CeAskJoBKhn0Q/ghjxgJZY63tYN5WQsBloFPFM9PMnOrMNu0Xzrk7BOTnWOfCzbv6yhXaNQvO1Bzxu1+RhOYrHAe9frkS/K0d7wXUpHhvmWAiLf0Cubc5bZ60WkZYa64okNC2KhdsW7Cb01c2JJTYRB3QBsyfxm5USKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402605; c=relaxed/simple;
	bh=CiWShjLpk4YB5Hj47Ns8oztDkN4v3o1IBRpOW4bCE1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJLSAutgA9fheVad/IKTUK0ZFFn7HDG8rg1IQWEWgafE8D1CwXLwW/hBaoYRnNt4lzP73BJzbfDLjXkzfh9Oj1FjMsfsYylLhf1cETA/VyUKDd13p7cch4FHha9h2aFonLMRUEs/D19AJVTCJiPqjC2BYeFPOy1jaIyccuYuJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=csNcILRg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAE5eO007251;
	Thu, 28 Aug 2025 17:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGkxOPv1lyN1AiDDRN7tEm36cz5aOOtE85/h87h7C+4=; b=csNcILRgf0GI95QJ
	e3JHcAqlGW+ax2iaNd4Mb80PfVUB++oYalair9/1XlPWC7WN34TRsr3APOP+Hd/p
	Zmwk+96cxrnMR+PuIoT8d/AeH8aYJtf9Xy9mgoeoDf6G8U3+iGWpmTUmt+ZBKH0z
	dBJMW3ptumNoJ1uvN37LZtf8B0PPqSUO1qsQnkdFf5EjV8yF+2BA3F2nxxqmBb+g
	UmW+fRTQ9/UNblt1mb53uXrgcU/LYbbwYyScRJFoDINkFHvTLUAf2as7+aTBlP7L
	kSG5fu3ynBKsk0b0eIk83xTMl60S1UPmloyiYvdr7bUtbCR069BJVu5AZXeO4WVf
	1WuvrQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67h9gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaabk009086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:36 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:34 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 17/20] wifi: ath12k: Move HTT code in dp.h to newly introduced files
Date: Thu, 28 Aug 2025 23:05:50 +0530
Message-ID: <20250828173553.3341351-18-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX781SsXcA8MMH
 IvuscV3GEU0DC5fJfW6TLjRaVMmcdfFdBMV2ENaFy4k1q5UH/kOuHghYl30oOBMX3p+PEqa8yBv
 ehlGFIPyDVAzqZ14hD36PPgrK6qujAKdSc6WyW2oJnQR5T7SvqhiqxTKvC5MEa1gTFMYyfH/y4N
 EgLF+1lAgNP2Sgmz0VLXJonw3Dpji6YwzlCI2YFi2U9LS3ydA8E6ojgTBjkPIdm/ZDGlElHnSHL
 l0IVlDTmGKIJYJS9BF4dmnQjzfvcMBidPP++QTWj5Nb1o266x2k5dKCtd3qzGv20bbw9E8d4pl8
 /dUjPD114jEunzu2YoG66dYhqRRLFeqTxTSwDp2dyjiVya+R/kRL7mjikbJpODvq1/11KL3wJHL
 9cM+gVw0
X-Proofpoint-GUID: LjQ0X54nLh0b8z16cMkddMQQF1dL0rO7
X-Proofpoint-ORIG-GUID: LjQ0X54nLh0b8z16cMkddMQQF1dL0rO7
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b093a5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Pb086SuNfz8WLnvVRPEA:9
 a=HgshiVJ_uS1X4sdq:21 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

WLAN Host driver interacts with the Firmware and vice versa using
Host-To-Target (HTT) interface.

HTT interface code is spread across multiple files (ex dp_tx.c,
dp_rx.c, dp.h etc) and this interface is independent of the underlying
architecture Tx and Rx.

Relocate HTT specific code from dp.h to newly introduced file dp_htt.h
for HTT interface.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |    4 +-
 drivers/net/wireless/ath/ath12k/dp.h          | 1506 +---------------
 drivers/net/wireless/ath/ath12k/dp_htt.h      | 1517 +++++++++++++++++
 3 files changed, 1521 insertions(+), 1506 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.h

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 9bd3a632b002..8008658371aa 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef DEBUG_HTT_STATS_H
 #define DEBUG_HTT_STATS_H
 
+#include "dp_htt.h"
+
 #define ATH12K_HTT_STATS_BUF_SIZE		(1024 * 512)
 #define ATH12K_HTT_STATS_COOKIE_LSB		GENMASK_ULL(31, 0)
 #define ATH12K_HTT_STATS_COOKIE_MSB		GENMASK_ULL(63, 32)
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 51af354ee769..45d569e19534 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -10,6 +10,7 @@
 #include "wifi7/hal_desc.h"
 #include "wifi7/hal_rx.h"
 #include "hw.h"
+#include "dp_htt.h"
 
 #define MAX_RXDMA_PER_PDEV     2
 
@@ -425,1511 +426,6 @@ struct ath12k_dp {
 	struct ath12k_reo_q_addr_lut ml_reoq_lut;
 };
 
-/* HTT definitions */
-#define HTT_TAG_TCL_METADATA_VERSION		5
-
-#define HTT_TCL_META_DATA_TYPE			GENMASK(1, 0)
-#define HTT_TCL_META_DATA_VALID_HTT		BIT(2)
-
-/* vdev meta data */
-#define HTT_TCL_META_DATA_VDEV_ID		 GENMASK(10, 3)
-#define HTT_TCL_META_DATA_PDEV_ID		 GENMASK(12, 11)
-#define HTT_TCL_META_DATA_HOST_INSPECTED_MISSION BIT(13)
-
-/* peer meta data */
-#define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 3)
-
-/* Global sequence number */
-#define HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM		3
-#define HTT_TCL_META_DATA_GLOBAL_SEQ_HOST_INSPECTED	BIT(2)
-#define HTT_TCL_META_DATA_GLOBAL_SEQ_NUM		GENMASK(14, 3)
-#define HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID	128
-
-/* HTT tx completion is overlaid in wbm_release_ring */
-#define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(16, 13)
-#define HTT_TX_WBM_COMP_INFO1_REINJECT_REASON	GENMASK(3, 0)
-#define HTT_TX_WBM_COMP_INFO1_EXCEPTION_FRAME	BIT(4)
-
-#define HTT_TX_WBM_COMP_INFO2_ACK_RSSI		GENMASK(31, 24)
-
-struct htt_tx_wbm_completion {
-	__le32 rsvd0[2];
-	__le32 info0;
-	__le32 info1;
-	__le32 info2;
-	__le32 info3;
-	__le32 info4;
-	__le32 rsvd1;
-
-} __packed;
-
-enum htt_h2t_msg_type {
-	HTT_H2T_MSG_TYPE_VERSION_REQ		= 0,
-	HTT_H2T_MSG_TYPE_SRING_SETUP		= 0xb,
-	HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG	= 0xc,
-	HTT_H2T_MSG_TYPE_EXT_STATS_CFG		= 0x10,
-	HTT_H2T_MSG_TYPE_PPDU_STATS_CFG		= 0x11,
-	HTT_H2T_MSG_TYPE_VDEV_TXRX_STATS_CFG	= 0x1a,
-	HTT_H2T_MSG_TYPE_TX_MONITOR_CFG		= 0x1b,
-};
-
-#define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
-#define HTT_OPTION_TCL_METADATA_VER_V1	1
-#define HTT_OPTION_TCL_METADATA_VER_V2	2
-#define HTT_OPTION_TAG			GENMASK(7, 0)
-#define HTT_OPTION_LEN			GENMASK(15, 8)
-#define HTT_OPTION_VALUE		GENMASK(31, 16)
-#define HTT_TCL_METADATA_VER_SZ		4
-
-struct htt_ver_req_cmd {
-	__le32 ver_reg_info;
-	__le32 tcl_metadata_version;
-} __packed;
-
-enum htt_srng_ring_type {
-	HTT_HW_TO_SW_RING,
-	HTT_SW_TO_HW_RING,
-	HTT_SW_TO_SW_RING,
-};
-
-enum htt_srng_ring_id {
-	HTT_RXDMA_HOST_BUF_RING,
-	HTT_RXDMA_MONITOR_STATUS_RING,
-	HTT_RXDMA_MONITOR_BUF_RING,
-	HTT_RXDMA_MONITOR_DESC_RING,
-	HTT_RXDMA_MONITOR_DEST_RING,
-	HTT_HOST1_TO_FW_RXBUF_RING,
-	HTT_HOST2_TO_FW_RXBUF_RING,
-	HTT_RXDMA_NON_MONITOR_DEST_RING,
-	HTT_RXDMA_HOST_BUF_RING2,
-	HTT_TX_MON_HOST2MON_BUF_RING,
-	HTT_TX_MON_MON2HOST_DEST_RING,
-	HTT_RX_MON_HOST2MON_BUF_RING,
-	HTT_RX_MON_MON2HOST_DEST_RING,
-};
-
-/* host -> target  HTT_SRING_SETUP message
- *
- * After target is booted up, Host can send SRING setup message for
- * each host facing LMAC SRING. Target setups up HW registers based
- * on setup message and confirms back to Host if response_required is set.
- * Host should wait for confirmation message before sending new SRING
- * setup message
- *
- * The message would appear as follows:
- *
- * |31            24|23    20|19|18 16|15|14          8|7                0|
- * |--------------- +-----------------+----------------+------------------|
- * |    ring_type   |      ring_id    |    pdev_id     |     msg_type     |
- * |----------------------------------------------------------------------|
- * |                          ring_base_addr_lo                           |
- * |----------------------------------------------------------------------|
- * |                         ring_base_addr_hi                            |
- * |----------------------------------------------------------------------|
- * |ring_misc_cfg_flag|ring_entry_size|            ring_size              |
- * |----------------------------------------------------------------------|
- * |                         ring_head_offset32_remote_addr_lo            |
- * |----------------------------------------------------------------------|
- * |                         ring_head_offset32_remote_addr_hi            |
- * |----------------------------------------------------------------------|
- * |                         ring_tail_offset32_remote_addr_lo            |
- * |----------------------------------------------------------------------|
- * |                         ring_tail_offset32_remote_addr_hi            |
- * |----------------------------------------------------------------------|
- * |                          ring_msi_addr_lo                            |
- * |----------------------------------------------------------------------|
- * |                          ring_msi_addr_hi                            |
- * |----------------------------------------------------------------------|
- * |                          ring_msi_data                               |
- * |----------------------------------------------------------------------|
- * |         intr_timer_th            |IM|      intr_batch_counter_th     |
- * |----------------------------------------------------------------------|
- * |          reserved        |RR|PTCF|        intr_low_threshold         |
- * |----------------------------------------------------------------------|
- * Where
- *     IM = sw_intr_mode
- *     RR = response_required
- *     PTCF = prefetch_timer_cfg
- *
- * The message is interpreted as follows:
- * dword0  - b'0:7   - msg_type: This will be set to
- *                     HTT_H2T_MSG_TYPE_SRING_SETUP
- *           b'8:15  - pdev_id:
- *                     0 (for rings at SOC/UMAC level),
- *                     1/2/3 mac id (for rings at LMAC level)
- *           b'16:23 - ring_id: identify which ring is to setup,
- *                     more details can be got from enum htt_srng_ring_id
- *           b'24:31 - ring_type: identify type of host rings,
- *                     more details can be got from enum htt_srng_ring_type
- * dword1  - b'0:31  - ring_base_addr_lo: Lower 32bits of ring base address
- * dword2  - b'0:31  - ring_base_addr_hi: Upper 32bits of ring base address
- * dword3  - b'0:15  - ring_size: size of the ring in unit of 4-bytes words
- *           b'16:23 - ring_entry_size: Size of each entry in 4-byte word units
- *           b'24:31 - ring_misc_cfg_flag: Valid only for HW_TO_SW_RING and
- *                     SW_TO_HW_RING.
- *                     Refer to HTT_SRING_SETUP_RING_MISC_CFG_RING defs.
- * dword4  - b'0:31  - ring_head_off32_remote_addr_lo:
- *                     Lower 32 bits of memory address of the remote variable
- *                     storing the 4-byte word offset that identifies the head
- *                     element within the ring.
- *                     (The head offset variable has type u32.)
- *                     Valid for HW_TO_SW and SW_TO_SW rings.
- * dword5  - b'0:31  - ring_head_off32_remote_addr_hi:
- *                     Upper 32 bits of memory address of the remote variable
- *                     storing the 4-byte word offset that identifies the head
- *                     element within the ring.
- *                     (The head offset variable has type u32.)
- *                     Valid for HW_TO_SW and SW_TO_SW rings.
- * dword6  - b'0:31  - ring_tail_off32_remote_addr_lo:
- *                     Lower 32 bits of memory address of the remote variable
- *                     storing the 4-byte word offset that identifies the tail
- *                     element within the ring.
- *                     (The tail offset variable has type u32.)
- *                     Valid for HW_TO_SW and SW_TO_SW rings.
- * dword7  - b'0:31  - ring_tail_off32_remote_addr_hi:
- *                     Upper 32 bits of memory address of the remote variable
- *                     storing the 4-byte word offset that identifies the tail
- *                     element within the ring.
- *                     (The tail offset variable has type u32.)
- *                     Valid for HW_TO_SW and SW_TO_SW rings.
- * dword8  - b'0:31  - ring_msi_addr_lo: Lower 32bits of MSI cfg address
- *                     valid only for HW_TO_SW_RING and SW_TO_HW_RING
- * dword9  - b'0:31  - ring_msi_addr_hi: Upper 32bits of MSI cfg address
- *                     valid only for HW_TO_SW_RING and SW_TO_HW_RING
- * dword10 - b'0:31  - ring_msi_data: MSI data
- *                     Refer to HTT_SRING_SETUP_RING_MSC_CFG_xxx defs
- *                     valid only for HW_TO_SW_RING and SW_TO_HW_RING
- * dword11 - b'0:14  - intr_batch_counter_th:
- *                     batch counter threshold is in units of 4-byte words.
- *                     HW internally maintains and increments batch count.
- *                     (see SRING spec for detail description).
- *                     When batch count reaches threshold value, an interrupt
- *                     is generated by HW.
- *           b'15    - sw_intr_mode:
- *                     This configuration shall be static.
- *                     Only programmed at power up.
- *                     0: generate pulse style sw interrupts
- *                     1: generate level style sw interrupts
- *           b'16:31 - intr_timer_th:
- *                     The timer init value when timer is idle or is
- *                     initialized to start downcounting.
- *                     In 8us units (to cover a range of 0 to 524 ms)
- * dword12 - b'0:15  - intr_low_threshold:
- *                     Used only by Consumer ring to generate ring_sw_int_p.
- *                     Ring entries low threshold water mark, that is used
- *                     in combination with the interrupt timer as well as
- *                     the clearing of the level interrupt.
- *           b'16:18 - prefetch_timer_cfg:
- *                     Used only by Consumer ring to set timer mode to
- *                     support Application prefetch handling.
- *                     The external tail offset/pointer will be updated
- *                     at following intervals:
- *                     3'b000: (Prefetch feature disabled; used only for debug)
- *                     3'b001: 1 usec
- *                     3'b010: 4 usec
- *                     3'b011: 8 usec (default)
- *                     3'b100: 16 usec
- *                     Others: Reserved
- *           b'19    - response_required:
- *                     Host needs HTT_T2H_MSG_TYPE_SRING_SETUP_DONE as response
- *           b'20:31 - reserved:  reserved for future use
- */
-
-#define HTT_SRNG_SETUP_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
-#define HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
-#define HTT_SRNG_SETUP_CMD_INFO0_RING_ID	GENMASK(23, 16)
-#define HTT_SRNG_SETUP_CMD_INFO0_RING_TYPE	GENMASK(31, 24)
-
-#define HTT_SRNG_SETUP_CMD_INFO1_RING_SIZE			GENMASK(15, 0)
-#define HTT_SRNG_SETUP_CMD_INFO1_RING_ENTRY_SIZE		GENMASK(23, 16)
-#define HTT_SRNG_SETUP_CMD_INFO1_RING_LOOP_CNT_DIS		BIT(25)
-#define HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP		BIT(27)
-#define HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_HOST_FW_SWAP	BIT(28)
-#define HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_TLV_SWAP		BIT(29)
-
-#define HTT_SRNG_SETUP_CMD_INTR_INFO_BATCH_COUNTER_THRESH	GENMASK(14, 0)
-#define HTT_SRNG_SETUP_CMD_INTR_INFO_SW_INTR_MODE		BIT(15)
-#define HTT_SRNG_SETUP_CMD_INTR_INFO_INTR_TIMER_THRESH		GENMASK(31, 16)
-
-#define HTT_SRNG_SETUP_CMD_INFO2_INTR_LOW_THRESH	GENMASK(15, 0)
-#define HTT_SRNG_SETUP_CMD_INFO2_PRE_FETCH_TIMER_CFG	GENMASK(18, 16)
-#define HTT_SRNG_SETUP_CMD_INFO2_RESPONSE_REQUIRED	BIT(19)
-
-struct htt_srng_setup_cmd {
-	__le32 info0;
-	__le32 ring_base_addr_lo;
-	__le32 ring_base_addr_hi;
-	__le32 info1;
-	__le32 ring_head_off32_remote_addr_lo;
-	__le32 ring_head_off32_remote_addr_hi;
-	__le32 ring_tail_off32_remote_addr_lo;
-	__le32 ring_tail_off32_remote_addr_hi;
-	__le32 ring_msi_addr_lo;
-	__le32 ring_msi_addr_hi;
-	__le32 msi_data;
-	__le32 intr_info;
-	__le32 info2;
-} __packed;
-
-/* host -> target FW  PPDU_STATS config message
- *
- * @details
- * The following field definitions describe the format of the HTT host
- * to target FW for PPDU_STATS_CFG msg.
- * The message allows the host to configure the PPDU_STATS_IND messages
- * produced by the target.
- *
- * |31          24|23          16|15           8|7            0|
- * |-----------------------------------------------------------|
- * |    REQ bit mask             |   pdev_mask  |   msg type   |
- * |-----------------------------------------------------------|
- * Header fields:
- *  - MSG_TYPE
- *    Bits 7:0
- *    Purpose: identifies this is a req to configure ppdu_stats_ind from target
- *    Value: 0x11
- *  - PDEV_MASK
- *    Bits 8:15
- *    Purpose: identifies which pdevs this PPDU stats configuration applies to
- *    Value: This is a overloaded field, refer to usage and interpretation of
- *           PDEV in interface document.
- *           Bit   8    :  Reserved for SOC stats
- *           Bit 9 - 15 :  Indicates PDEV_MASK in DBDC
- *                         Indicates MACID_MASK in DBS
- *  - REQ_TLV_BIT_MASK
- *    Bits 16:31
- *    Purpose: each set bit indicates the corresponding PPDU stats TLV type
- *        needs to be included in the target's PPDU_STATS_IND messages.
- *    Value: refer htt_ppdu_stats_tlv_tag_t <<<???
- *
- */
-
-struct htt_ppdu_stats_cfg_cmd {
-	__le32 msg;
-} __packed;
-
-#define HTT_PPDU_STATS_CFG_MSG_TYPE		GENMASK(7, 0)
-#define HTT_PPDU_STATS_CFG_SOC_STATS		BIT(8)
-#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 9)
-#define HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK	GENMASK(31, 16)
-
-enum htt_ppdu_stats_tag_type {
-	HTT_PPDU_STATS_TAG_COMMON,
-	HTT_PPDU_STATS_TAG_USR_COMMON,
-	HTT_PPDU_STATS_TAG_USR_RATE,
-	HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_64,
-	HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_256,
-	HTT_PPDU_STATS_TAG_SCH_CMD_STATUS,
-	HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON,
-	HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_64,
-	HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_256,
-	HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS,
-	HTT_PPDU_STATS_TAG_USR_COMPLTN_FLUSH,
-	HTT_PPDU_STATS_TAG_USR_COMMON_ARRAY,
-	HTT_PPDU_STATS_TAG_INFO,
-	HTT_PPDU_STATS_TAG_TX_MGMTCTRL_PAYLOAD,
-
-	/* New TLV's are added above to this line */
-	HTT_PPDU_STATS_TAG_MAX,
-};
-
-#define HTT_PPDU_STATS_TAG_DEFAULT (BIT(HTT_PPDU_STATS_TAG_COMMON) \
-				   | BIT(HTT_PPDU_STATS_TAG_USR_COMMON) \
-				   | BIT(HTT_PPDU_STATS_TAG_USR_RATE) \
-				   | BIT(HTT_PPDU_STATS_TAG_SCH_CMD_STATUS) \
-				   | BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON) \
-				   | BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS) \
-				   | BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_FLUSH) \
-				   | BIT(HTT_PPDU_STATS_TAG_USR_COMMON_ARRAY))
-
-#define HTT_PPDU_STATS_TAG_PKTLOG  (BIT(HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_64) | \
-				    BIT(HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_256) | \
-				    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_64) | \
-				    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_256) | \
-				    BIT(HTT_PPDU_STATS_TAG_INFO) | \
-				    BIT(HTT_PPDU_STATS_TAG_TX_MGMTCTRL_PAYLOAD) | \
-				    HTT_PPDU_STATS_TAG_DEFAULT)
-
-enum htt_stats_internal_ppdu_frametype {
-	HTT_STATS_PPDU_FTYPE_CTRL,
-	HTT_STATS_PPDU_FTYPE_DATA,
-	HTT_STATS_PPDU_FTYPE_BAR,
-	HTT_STATS_PPDU_FTYPE_MAX
-};
-
-/* HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG Message
- *
- * details:
- *    HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG message is sent by host to
- *    configure RXDMA rings.
- *    The configuration is per ring based and includes both packet subtypes
- *    and PPDU/MPDU TLVs.
- *
- *    The message would appear as follows:
- *
- *    |31   29|28|27|26|25|24|23       16|15             8|7             0|
- *    |-------+--+--+--+--+--+-----------+----------------+---------------|
- *    | rsvd1 |ED|DT|OV|PS|SS|  ring_id  |     pdev_id    |    msg_type   |
- *    |-------------------------------------------------------------------|
- *    |              rsvd2               |           ring_buffer_size     |
- *    |-------------------------------------------------------------------|
- *    |                        packet_type_enable_flags_0                 |
- *    |-------------------------------------------------------------------|
- *    |                        packet_type_enable_flags_1                 |
- *    |-------------------------------------------------------------------|
- *    |                        packet_type_enable_flags_2                 |
- *    |-------------------------------------------------------------------|
- *    |                        packet_type_enable_flags_3                 |
- *    |-------------------------------------------------------------------|
- *    |                         tlv_filter_in_flags                       |
- *    |-------------------------------------------------------------------|
- * Where:
- *     PS = pkt_swap
- *     SS = status_swap
- * The message is interpreted as follows:
- * dword0 - b'0:7   - msg_type: This will be set to
- *                    HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
- *          b'8:15  - pdev_id:
- *                    0 (for rings at SOC/UMAC level),
- *                    1/2/3 mac id (for rings at LMAC level)
- *          b'16:23 - ring_id : Identify the ring to configure.
- *                    More details can be got from enum htt_srng_ring_id
- *          b'24    - status_swap: 1 is to swap status TLV
- *          b'25    - pkt_swap:  1 is to swap packet TLV
- *          b'26    - rx_offset_valid (OV): flag to indicate rx offsets
- *		      configuration fields are valid
- *          b'27    - drop_thresh_valid (DT): flag to indicate if the
- *		      rx_drop_threshold field is valid
- *          b'28    - rx_mon_global_en: Enable/Disable global register
- *		      configuration in Rx monitor module.
- *          b'29:31 - rsvd1:  reserved for future use
- * dword1 - b'0:16  - ring_buffer_size: size of buffers referenced by rx ring,
- *                    in byte units.
- *                    Valid only for HW_TO_SW_RING and SW_TO_HW_RING
- *        - b'16:31 - rsvd2: Reserved for future use
- * dword2 - b'0:31  - packet_type_enable_flags_0:
- *                    Enable MGMT packet from 0b0000 to 0b1001
- *                    bits from low to high: FP, MD, MO - 3 bits
- *                        FP: Filter_Pass
- *                        MD: Monitor_Direct
- *                        MO: Monitor_Other
- *                    10 mgmt subtypes * 3 bits -> 30 bits
- *                    Refer to PKT_TYPE_ENABLE_FLAG0_xxx_MGMT_xxx defs
- * dword3 - b'0:31  - packet_type_enable_flags_1:
- *                    Enable MGMT packet from 0b1010 to 0b1111
- *                    bits from low to high: FP, MD, MO - 3 bits
- *                    Refer to PKT_TYPE_ENABLE_FLAG1_xxx_MGMT_xxx defs
- * dword4 - b'0:31 -  packet_type_enable_flags_2:
- *                    Enable CTRL packet from 0b0000 to 0b1001
- *                    bits from low to high: FP, MD, MO - 3 bits
- *                    Refer to PKT_TYPE_ENABLE_FLAG2_xxx_CTRL_xxx defs
- * dword5 - b'0:31  - packet_type_enable_flags_3:
- *                    Enable CTRL packet from 0b1010 to 0b1111,
- *                    MCAST_DATA, UCAST_DATA, NULL_DATA
- *                    bits from low to high: FP, MD, MO - 3 bits
- *                    Refer to PKT_TYPE_ENABLE_FLAG3_xxx_CTRL_xxx defs
- * dword6 - b'0:31 -  tlv_filter_in_flags:
- *                    Filter in Attention/MPDU/PPDU/Header/User tlvs
- *                    Refer to CFG_TLV_FILTER_IN_FLAG defs
- */
-
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_RING_ID	GENMASK(23, 16)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_SS		BIT(24)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PS		BIT(25)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_OFFSET_VALID	BIT(26)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_DROP_THRES_VAL	BIT(27)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_EN_RXMON		BIT(28)
-
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_BUF_SIZE		GENMASK(15, 0)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT	GENMASK(18, 16)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL	GENMASK(21, 19)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA	GENMASK(24, 22)
-
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_DROP_THRESHOLD	GENMASK(9, 0)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_MGMT_TYPE	BIT(17)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_CTRL_TYPE	BIT(18)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO2_EN_LOG_DATA_TYPE	BIT(19)
-
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO3_EN_TLV_PKT_OFFSET	BIT(0)
-#define HTT_RX_RING_SELECTION_CFG_CMD_INFO3_PKT_TLV_OFFSET	GENMASK(14, 1)
-
-#define HTT_RX_RING_SELECTION_CFG_RX_PACKET_OFFSET      GENMASK(15, 0)
-#define HTT_RX_RING_SELECTION_CFG_RX_HEADER_OFFSET      GENMASK(31, 16)
-#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_OFFSET    GENMASK(15, 0)
-#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_OFFSET  GENMASK(31, 16)
-#define HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_OFFSET    GENMASK(15, 0)
-#define HTT_RX_RING_SELECTION_CFG_RX_MSDU_START_OFFSET  GENMASK(31, 16)
-#define HTT_RX_RING_SELECTION_CFG_RX_ATTENTION_OFFSET   GENMASK(15, 0)
-
-#define HTT_RX_RING_SELECTION_CFG_WORD_MASK_COMPACT_SET	BIT(23)
-#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_MASK	GENMASK(15, 0)
-#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_MASK	GENMASK(18, 16)
-#define HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_MASK	GENMASK(16, 0)
-
-enum htt_rx_filter_tlv_flags {
-	HTT_RX_FILTER_TLV_FLAGS_MPDU_START		= BIT(0),
-	HTT_RX_FILTER_TLV_FLAGS_MSDU_START		= BIT(1),
-	HTT_RX_FILTER_TLV_FLAGS_RX_PACKET		= BIT(2),
-	HTT_RX_FILTER_TLV_FLAGS_MSDU_END		= BIT(3),
-	HTT_RX_FILTER_TLV_FLAGS_MPDU_END		= BIT(4),
-	HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER		= BIT(5),
-	HTT_RX_FILTER_TLV_FLAGS_PER_MSDU_HEADER		= BIT(6),
-	HTT_RX_FILTER_TLV_FLAGS_ATTENTION		= BIT(7),
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_START		= BIT(8),
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END		= BIT(9),
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS	= BIT(10),
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT	= BIT(11),
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE	= BIT(12),
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO	= BIT(13),
-};
-
-enum htt_rx_mgmt_pkt_filter_tlv_flags0 {
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ		= BIT(0),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ		= BIT(1),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ		= BIT(2),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP		= BIT(3),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP		= BIT(4),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP		= BIT(5),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ	= BIT(6),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ	= BIT(7),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ	= BIT(8),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP	= BIT(9),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP	= BIT(10),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP	= BIT(11),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ		= BIT(12),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ		= BIT(13),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ		= BIT(14),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP		= BIT(15),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP		= BIT(16),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP		= BIT(17),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV	= BIT(18),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV	= BIT(19),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV	= BIT(20),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7		= BIT(21),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7		= BIT(22),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7		= BIT(23),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON		= BIT(24),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON		= BIT(25),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON		= BIT(26),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM		= BIT(27),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM		= BIT(28),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM		= BIT(29),
-};
-
-enum htt_rx_mgmt_pkt_filter_tlv_flags1 {
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC		= BIT(0),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC		= BIT(1),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC		= BIT(2),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH		= BIT(3),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH		= BIT(4),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH		= BIT(5),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH		= BIT(6),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH		= BIT(7),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH		= BIT(8),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION		= BIT(9),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION		= BIT(10),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION		= BIT(11),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK	= BIT(12),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK	= BIT(13),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK	= BIT(14),
-	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15	= BIT(15),
-	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15	= BIT(16),
-	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15	= BIT(17),
-};
-
-enum htt_rx_ctrl_pkt_filter_tlv_flags2 {
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1	= BIT(0),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1	= BIT(1),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1	= BIT(2),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2	= BIT(3),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2	= BIT(4),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2	= BIT(5),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER	= BIT(6),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER	= BIT(7),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER	= BIT(8),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4	= BIT(9),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4	= BIT(10),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4	= BIT(11),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL	= BIT(12),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL	= BIT(13),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL	= BIT(14),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP	= BIT(15),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP	= BIT(16),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP	= BIT(17),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT	= BIT(18),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT	= BIT(19),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT	= BIT(20),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER	= BIT(21),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER	= BIT(22),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER	= BIT(23),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR		= BIT(24),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BAR		= BIT(25),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BAR		= BIT(26),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BA			= BIT(27),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BA			= BIT(28),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BA			= BIT(29),
-};
-
-enum htt_rx_ctrl_pkt_filter_tlv_flags3 {
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL		= BIT(0),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL		= BIT(1),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL		= BIT(2),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_RTS		= BIT(3),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_RTS		= BIT(4),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_RTS		= BIT(5),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CTS		= BIT(6),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CTS		= BIT(7),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CTS		= BIT(8),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_ACK		= BIT(9),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_ACK		= BIT(10),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_ACK		= BIT(11),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND		= BIT(12),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND		= BIT(13),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND		= BIT(14),
-	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK		= BIT(15),
-	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK		= BIT(16),
-	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK		= BIT(17),
-};
-
-enum htt_rx_data_pkt_filter_tlv_flasg3 {
-	HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST	= BIT(18),
-	HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_MCAST	= BIT(19),
-	HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_MCAST	= BIT(20),
-	HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST	= BIT(21),
-	HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_UCAST	= BIT(22),
-	HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_UCAST	= BIT(23),
-	HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA	= BIT(24),
-	HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA	= BIT(25),
-	HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA	= BIT(26),
-};
-
-#define HTT_RX_FP_MGMT_FILTER_FLAGS0 \
-	(HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON \
-	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM)
-
-#define HTT_RX_MD_MGMT_FILTER_FLAGS0 \
-	(HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON \
-	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM)
-
-#define HTT_RX_MO_MGMT_FILTER_FLAGS0 \
-	(HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON \
-	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM)
-
-#define HTT_RX_FP_MGMT_FILTER_FLAGS1 (HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC \
-				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH \
-				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH \
-				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION \
-				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK)
-
-#define HTT_RX_MD_MGMT_FILTER_FLAGS1 (HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC \
-				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH \
-				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH \
-				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION \
-				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK)
-
-#define HTT_RX_MO_MGMT_FILTER_FLAGS1 (HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC \
-				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH \
-				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH \
-				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION \
-				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK)
-
-#define HTT_RX_FP_CTRL_FILTER_FLASG2 (HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER \
-				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR \
-				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BA)
-
-#define HTT_RX_MD_CTRL_FILTER_FLASG2 (HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER \
-				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BAR \
-				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BA)
-
-#define HTT_RX_MO_CTRL_FILTER_FLASG2 (HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER \
-				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BAR \
-				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BA)
-
-#define HTT_RX_FP_CTRL_FILTER_FLASG3 (HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL \
-				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_RTS \
-				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CTS \
-				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_ACK \
-				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND \
-				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK)
-
-#define HTT_RX_MD_CTRL_FILTER_FLASG3 (HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL \
-				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_RTS \
-				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CTS \
-				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_ACK \
-				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND \
-				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK)
-
-#define HTT_RX_MO_CTRL_FILTER_FLASG3 (HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL \
-				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_RTS \
-				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CTS \
-				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_ACK \
-				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND \
-				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK)
-
-#define HTT_RX_FP_DATA_FILTER_FLASG3 (HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST \
-				     | HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST \
-				     | HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA)
-
-#define HTT_RX_MD_DATA_FILTER_FLASG3 (HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_MCAST \
-				     | HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_UCAST \
-				     | HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA)
-
-#define HTT_RX_MO_DATA_FILTER_FLASG3 (HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_MCAST \
-				     | HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_UCAST \
-				     | HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA)
-
-#define HTT_RX_MON_FP_MGMT_FILTER_FLAGS0 \
-		(HTT_RX_FP_MGMT_FILTER_FLAGS0 | \
-		HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7)
-
-#define HTT_RX_MON_MO_MGMT_FILTER_FLAGS0 \
-		(HTT_RX_MO_MGMT_FILTER_FLAGS0 | \
-		HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7)
-
-#define HTT_RX_MON_FP_MGMT_FILTER_FLAGS1 \
-		(HTT_RX_FP_MGMT_FILTER_FLAGS1 | \
-		HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15)
-
-#define HTT_RX_MON_MO_MGMT_FILTER_FLAGS1 \
-		(HTT_RX_MO_MGMT_FILTER_FLAGS1 | \
-		HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15)
-
-#define HTT_RX_MON_FP_CTRL_FILTER_FLASG2 \
-		(HTT_RX_FP_CTRL_FILTER_FLASG2 | \
-		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1 | \
-		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2 | \
-		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER | \
-		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4 | \
-		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL | \
-		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP | \
-		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT)
-
-#define HTT_RX_MON_MO_CTRL_FILTER_FLASG2 \
-		(HTT_RX_MO_CTRL_FILTER_FLASG2 | \
-		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1 | \
-		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2 | \
-		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER | \
-		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4 | \
-		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL | \
-		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP | \
-		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT)
-
-#define HTT_RX_MON_FP_CTRL_FILTER_FLASG3 HTT_RX_FP_CTRL_FILTER_FLASG3
-
-#define HTT_RX_MON_MO_CTRL_FILTER_FLASG3 HTT_RX_MO_CTRL_FILTER_FLASG3
-
-#define HTT_RX_MON_FP_DATA_FILTER_FLASG3 HTT_RX_FP_DATA_FILTER_FLASG3
-
-#define HTT_RX_MON_MO_DATA_FILTER_FLASG3 HTT_RX_MO_DATA_FILTER_FLASG3
-
-#define HTT_RX_MON_FILTER_TLV_FLAGS \
-		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE)
-
-#define HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING \
-		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
-		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE)
-
-#define HTT_RX_MON_FILTER_TLV_FLAGS_MON_BUF_RING \
-		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
-		HTT_RX_FILTER_TLV_FLAGS_MSDU_START | \
-		HTT_RX_FILTER_TLV_FLAGS_RX_PACKET | \
-		HTT_RX_FILTER_TLV_FLAGS_MSDU_END | \
-		HTT_RX_FILTER_TLV_FLAGS_MPDU_END | \
-		HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER | \
-		HTT_RX_FILTER_TLV_FLAGS_PER_MSDU_HEADER | \
-		HTT_RX_FILTER_TLV_FLAGS_ATTENTION)
-
-#define HTT_RX_MON_FILTER_TLV_FLAGS_MON_DEST_RING \
-	(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
-	HTT_RX_FILTER_TLV_FLAGS_MSDU_START | \
-	HTT_RX_FILTER_TLV_FLAGS_RX_PACKET | \
-	HTT_RX_FILTER_TLV_FLAGS_MSDU_END | \
-	HTT_RX_FILTER_TLV_FLAGS_MPDU_END | \
-	HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER | \
-	HTT_RX_FILTER_TLV_FLAGS_PER_MSDU_HEADER | \
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE | \
-	HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO)
-
-/* msdu start. mpdu end, attention, rx hdr tlv's are not subscribed */
-#define HTT_RX_TLV_FLAGS_RXDMA_RING \
-		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
-		HTT_RX_FILTER_TLV_FLAGS_RX_PACKET | \
-		HTT_RX_FILTER_TLV_FLAGS_MSDU_END)
-
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
-
-struct htt_rx_ring_selection_cfg_cmd {
-	__le32 info0;
-	__le32 info1;
-	__le32 pkt_type_en_flags0;
-	__le32 pkt_type_en_flags1;
-	__le32 pkt_type_en_flags2;
-	__le32 pkt_type_en_flags3;
-	__le32 rx_filter_tlv;
-	__le32 rx_packet_offset;
-	__le32 rx_mpdu_offset;
-	__le32 rx_msdu_offset;
-	__le32 rx_attn_offset;
-	__le32 info2;
-	__le32 reserved[2];
-	__le32 rx_mpdu_start_end_mask;
-	__le32 rx_msdu_end_word_mask;
-	__le32 info3;
-} __packed;
-
-#define HTT_RX_RING_TLV_DROP_THRESHOLD_VALUE	32
-#define HTT_RX_RING_DEFAULT_DMA_LENGTH		0x7
-#define HTT_RX_RING_PKT_TLV_OFFSET		0x1
-
-struct htt_rx_ring_tlv_filter {
-	u32 rx_filter; /* see htt_rx_filter_tlv_flags */
-	u32 pkt_filter_flags0; /* MGMT */
-	u32 pkt_filter_flags1; /* MGMT */
-	u32 pkt_filter_flags2; /* CTRL */
-	u32 pkt_filter_flags3; /* DATA */
-	bool offset_valid;
-	u16 rx_packet_offset;
-	u16 rx_header_offset;
-	u16 rx_mpdu_end_offset;
-	u16 rx_mpdu_start_offset;
-	u16 rx_msdu_end_offset;
-	u16 rx_msdu_start_offset;
-	u16 rx_attn_offset;
-	u16 rx_mpdu_start_wmask;
-	u16 rx_mpdu_end_wmask;
-	u32 rx_msdu_end_wmask;
-	u32 conf_len_ctrl;
-	u32 conf_len_mgmt;
-	u32 conf_len_data;
-	u16 rx_drop_threshold;
-	bool enable_log_mgmt_type;
-	bool enable_log_ctrl_type;
-	bool enable_log_data_type;
-	bool enable_rx_tlv_offset;
-	u16 rx_tlv_offset;
-	bool drop_threshold_valid;
-	bool rxmon_disable;
-};
-
-#define HTT_STATS_FRAME_CTRL_TYPE_MGMT  0x0
-#define HTT_STATS_FRAME_CTRL_TYPE_CTRL  0x1
-#define HTT_STATS_FRAME_CTRL_TYPE_DATA  0x2
-#define HTT_STATS_FRAME_CTRL_TYPE_RESV  0x3
-
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_RING_ID	GENMASK(23, 16)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_SS		BIT(24)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PS		BIT(25)
-
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_RING_BUFF_SIZE	GENMASK(15, 0)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE		GENMASK(18, 16)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT	GENMASK(21, 19)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL	GENMASK(24, 22)
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA	GENMASK(27, 25)
-
-#define HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG	GENMASK(2, 0)
-
-struct htt_tx_ring_selection_cfg_cmd {
-	__le32 info0;
-	__le32 info1;
-	__le32 info2;
-	__le32 tlv_filter_mask_in0;
-	__le32 tlv_filter_mask_in1;
-	__le32 tlv_filter_mask_in2;
-	__le32 tlv_filter_mask_in3;
-	__le32 reserved[3];
-} __packed;
-
-#define HTT_TX_RING_TLV_FILTER_MGMT_DMA_LEN	GENMASK(3, 0)
-#define HTT_TX_RING_TLV_FILTER_CTRL_DMA_LEN	GENMASK(7, 4)
-#define HTT_TX_RING_TLV_FILTER_DATA_DMA_LEN	GENMASK(11, 8)
-
-#define HTT_TX_MON_FILTER_HYBRID_MODE \
-		(HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_START_STATUS | \
-		HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_END_STATUS | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_END | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PPDU | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_PPDU | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_ACK_OR_BA | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_1K_BA | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PROT | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_PROT | \
-		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_RESPONSE | \
-		HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO | \
-		HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO_PART2)
-
-struct htt_tx_ring_tlv_filter {
-	u32 tx_mon_downstream_tlv_flags;
-	u32 tx_mon_upstream_tlv_flags0;
-	u32 tx_mon_upstream_tlv_flags1;
-	u32 tx_mon_upstream_tlv_flags2;
-	bool tx_mon_mgmt_filter;
-	bool tx_mon_data_filter;
-	bool tx_mon_ctrl_filter;
-	u16 tx_mon_pkt_dma_len;
-} __packed;
-
-enum htt_tx_mon_upstream_tlv_flags0 {
-	HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_START_STATUS		= BIT(1),
-	HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_END_STATUS		= BIT(2),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START		= BIT(3),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_END		= BIT(4),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PPDU	= BIT(5),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_PPDU	= BIT(6),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_ACK_OR_BA	= BIT(7),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_1K_BA		= BIT(8),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PROT	= BIT(9),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_PROT		= BIT(10),
-	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_RESPONSE	= BIT(11),
-	HTT_TX_FILTER_TLV_FLAGS0_RX_FRAME_BITMAP_ACK		= BIT(12),
-	HTT_TX_FILTER_TLV_FLAGS0_RX_FRAME_1K_BITMAP_ACK		= BIT(13),
-	HTT_TX_FILTER_TLV_FLAGS0_COEX_TX_STATUS			= BIT(14),
-	HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO		= BIT(15),
-	HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO_PART2	= BIT(16),
-};
-
-#define HTT_TX_FILTER_TLV_FLAGS2_TXPCU_PHYTX_OTHER_TRANSMIT_INFO32	BIT(11)
-
-/* HTT message target->host */
-
-enum htt_t2h_msg_type {
-	HTT_T2H_MSG_TYPE_VERSION_CONF,
-	HTT_T2H_MSG_TYPE_PEER_MAP	= 0x3,
-	HTT_T2H_MSG_TYPE_PEER_UNMAP	= 0x4,
-	HTT_T2H_MSG_TYPE_RX_ADDBA	= 0x5,
-	HTT_T2H_MSG_TYPE_PKTLOG		= 0x8,
-	HTT_T2H_MSG_TYPE_SEC_IND	= 0xb,
-	HTT_T2H_MSG_TYPE_PEER_MAP2	= 0x1e,
-	HTT_T2H_MSG_TYPE_PEER_UNMAP2	= 0x1f,
-	HTT_T2H_MSG_TYPE_PPDU_STATS_IND = 0x1d,
-	HTT_T2H_MSG_TYPE_EXT_STATS_CONF = 0x1c,
-	HTT_T2H_MSG_TYPE_BKPRESSURE_EVENT_IND = 0x24,
-	HTT_T2H_MSG_TYPE_MLO_TIMESTAMP_OFFSET_IND = 0x28,
-	HTT_T2H_MSG_TYPE_PEER_MAP3	= 0x2b,
-	HTT_T2H_MSG_TYPE_VDEV_TXRX_STATS_PERIODIC_IND = 0x2c,
-};
-
-#define HTT_TARGET_VERSION_MAJOR 3
-
-#define HTT_T2H_MSG_TYPE		GENMASK(7, 0)
-#define HTT_T2H_VERSION_CONF_MINOR	GENMASK(15, 8)
-#define HTT_T2H_VERSION_CONF_MAJOR	GENMASK(23, 16)
-
-struct htt_t2h_version_conf_msg {
-	__le32 version;
-} __packed;
-
-#define HTT_T2H_PEER_MAP_INFO_VDEV_ID	GENMASK(15, 8)
-#define HTT_T2H_PEER_MAP_INFO_PEER_ID	GENMASK(31, 16)
-#define HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16	GENMASK(15, 0)
-#define HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID	GENMASK(31, 16)
-#define HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL	GENMASK(15, 0)
-#define HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID	GENMASK(15, 0)
-#define HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL	GENMASK(31, 16)
-#define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_M	BIT(16)
-#define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_S	16
-
-struct htt_t2h_peer_map_event {
-	__le32 info;
-	__le32 mac_addr_l32;
-	__le32 info1;
-	__le32 info2;
-} __packed;
-
-#define HTT_T2H_PEER_UNMAP_INFO_VDEV_ID	HTT_T2H_PEER_MAP_INFO_VDEV_ID
-#define HTT_T2H_PEER_UNMAP_INFO_PEER_ID	HTT_T2H_PEER_MAP_INFO_PEER_ID
-#define HTT_T2H_PEER_UNMAP_INFO1_MAC_ADDR_H16 \
-					HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16
-#define HTT_T2H_PEER_MAP_INFO1_NEXT_HOP_M HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_M
-#define HTT_T2H_PEER_MAP_INFO1_NEXT_HOP_S HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_S
-
-struct htt_t2h_peer_unmap_event {
-	__le32 info;
-	__le32 mac_addr_l32;
-	__le32 info1;
-} __packed;
-
-struct htt_resp_msg {
-	union {
-		struct htt_t2h_version_conf_msg version_msg;
-		struct htt_t2h_peer_map_event peer_map_ev;
-		struct htt_t2h_peer_unmap_event peer_unmap_ev;
-	};
-} __packed;
-
-#define HTT_VDEV_GET_STATS_U64(msg_l32, msg_u32)\
-	(((u64)__le32_to_cpu(msg_u32) << 32) | (__le32_to_cpu(msg_l32)))
-#define HTT_T2H_VDEV_STATS_PERIODIC_MSG_TYPE		GENMASK(7, 0)
-#define HTT_T2H_VDEV_STATS_PERIODIC_PDEV_ID		GENMASK(15, 8)
-#define HTT_T2H_VDEV_STATS_PERIODIC_NUM_VDEV		GENMASK(23, 16)
-#define HTT_T2H_VDEV_STATS_PERIODIC_PAYLOAD_BYTES	GENMASK(15, 0)
-#define HTT_VDEV_TXRX_STATS_COMMON_TLV		0
-#define HTT_VDEV_TXRX_STATS_HW_STATS_TLV	1
-
-struct htt_t2h_vdev_txrx_stats_ind {
-	__le32 vdev_id;
-	__le32 rx_msdu_byte_cnt_lo;
-	__le32 rx_msdu_byte_cnt_hi;
-	__le32 rx_msdu_cnt_lo;
-	__le32 rx_msdu_cnt_hi;
-	__le32 tx_msdu_byte_cnt_lo;
-	__le32 tx_msdu_byte_cnt_hi;
-	__le32 tx_msdu_cnt_lo;
-	__le32 tx_msdu_cnt_hi;
-	__le32 tx_retry_cnt_lo;
-	__le32 tx_retry_cnt_hi;
-	__le32 tx_retry_byte_cnt_lo;
-	__le32 tx_retry_byte_cnt_hi;
-	__le32 tx_drop_cnt_lo;
-	__le32 tx_drop_cnt_hi;
-	__le32 tx_drop_byte_cnt_lo;
-	__le32 tx_drop_byte_cnt_hi;
-	__le32 msdu_ttl_cnt_lo;
-	__le32 msdu_ttl_cnt_hi;
-	__le32 msdu_ttl_byte_cnt_lo;
-	__le32 msdu_ttl_byte_cnt_hi;
-} __packed;
-
-struct htt_t2h_vdev_common_stats_tlv {
-	__le32 soc_drop_count_lo;
-	__le32 soc_drop_count_hi;
-} __packed;
-
-/* ppdu stats
- *
- * @details
- * The following field definitions describe the format of the HTT target
- * to host ppdu stats indication message.
- *
- *
- * |31                         16|15   12|11   10|9      8|7            0 |
- * |----------------------------------------------------------------------|
- * |    payload_size             | rsvd  |pdev_id|mac_id  |    msg type   |
- * |----------------------------------------------------------------------|
- * |                          ppdu_id                                     |
- * |----------------------------------------------------------------------|
- * |                        Timestamp in us                               |
- * |----------------------------------------------------------------------|
- * |                          reserved                                    |
- * |----------------------------------------------------------------------|
- * |                    type-specific stats info                          |
- * |                     (see htt_ppdu_stats.h)                           |
- * |----------------------------------------------------------------------|
- * Header fields:
- *  - MSG_TYPE
- *    Bits 7:0
- *    Purpose: Identifies this is a PPDU STATS indication
- *             message.
- *    Value: 0x1d
- *  - mac_id
- *    Bits 9:8
- *    Purpose: mac_id of this ppdu_id
- *    Value: 0-3
- *  - pdev_id
- *    Bits 11:10
- *    Purpose: pdev_id of this ppdu_id
- *    Value: 0-3
- *     0 (for rings at SOC level),
- *     1/2/3 PDEV -> 0/1/2
- *  - payload_size
- *    Bits 31:16
- *    Purpose: total tlv size
- *    Value: payload_size in bytes
- */
-
-#define HTT_T2H_PPDU_STATS_INFO_PDEV_ID GENMASK(11, 10)
-#define HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE GENMASK(31, 16)
-
-struct ath12k_htt_ppdu_stats_msg {
-	__le32 info;
-	__le32 ppdu_id;
-	__le32 timestamp;
-	__le32 rsvd;
-	u8 data[];
-} __packed;
-
-struct htt_tlv {
-	__le32 header;
-	u8 value[];
-} __packed;
-
-#define HTT_TLV_TAG			GENMASK(11, 0)
-#define HTT_TLV_LEN			GENMASK(23, 12)
-
-enum HTT_PPDU_STATS_BW {
-	HTT_PPDU_STATS_BANDWIDTH_5MHZ   = 0,
-	HTT_PPDU_STATS_BANDWIDTH_10MHZ  = 1,
-	HTT_PPDU_STATS_BANDWIDTH_20MHZ  = 2,
-	HTT_PPDU_STATS_BANDWIDTH_40MHZ  = 3,
-	HTT_PPDU_STATS_BANDWIDTH_80MHZ  = 4,
-	HTT_PPDU_STATS_BANDWIDTH_160MHZ = 5, /* includes 80+80 */
-	HTT_PPDU_STATS_BANDWIDTH_DYN    = 6,
-};
-
-#define HTT_PPDU_STATS_CMN_FLAGS_FRAME_TYPE_M	GENMASK(7, 0)
-#define HTT_PPDU_STATS_CMN_FLAGS_QUEUE_TYPE_M	GENMASK(15, 8)
-/* bw - HTT_PPDU_STATS_BW */
-#define HTT_PPDU_STATS_CMN_FLAGS_BW_M		GENMASK(19, 16)
-
-struct htt_ppdu_stats_common {
-	__le32 ppdu_id;
-	__le16 sched_cmdid;
-	u8 ring_id;
-	u8 num_users;
-	__le32 flags; /* %HTT_PPDU_STATS_COMMON_FLAGS_*/
-	__le32 chain_mask;
-	__le32 fes_duration_us; /* frame exchange sequence */
-	__le32 ppdu_sch_eval_start_tstmp_us;
-	__le32 ppdu_sch_end_tstmp_us;
-	__le32 ppdu_start_tstmp_us;
-	/* BIT [15 :  0] - phy mode (WLAN_PHY_MODE) with which ppdu was transmitted
-	 * BIT [31 : 16] - bandwidth (in MHz) with which ppdu was transmitted
-	 */
-	__le16 phy_mode;
-	__le16 bw_mhz;
-} __packed;
-
-enum htt_ppdu_stats_gi {
-	HTT_PPDU_STATS_SGI_0_8_US,
-	HTT_PPDU_STATS_SGI_0_4_US,
-	HTT_PPDU_STATS_SGI_1_6_US,
-	HTT_PPDU_STATS_SGI_3_2_US,
-};
-
-#define HTT_PPDU_STATS_USER_RATE_INFO0_USER_POS_M	GENMASK(3, 0)
-#define HTT_PPDU_STATS_USER_RATE_INFO0_MU_GROUP_ID_M	GENMASK(11, 4)
-
-enum HTT_PPDU_STATS_PPDU_TYPE {
-	HTT_PPDU_STATS_PPDU_TYPE_SU,
-	HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO,
-	HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA,
-	HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA,
-	HTT_PPDU_STATS_PPDU_TYPE_UL_TRIG,
-	HTT_PPDU_STATS_PPDU_TYPE_BURST_BCN,
-	HTT_PPDU_STATS_PPDU_TYPE_UL_BSR_RESP,
-	HTT_PPDU_STATS_PPDU_TYPE_UL_BSR_TRIG,
-	HTT_PPDU_STATS_PPDU_TYPE_UL_RESP,
-	HTT_PPDU_STATS_PPDU_TYPE_MAX
-};
-
-#define HTT_PPDU_STATS_USER_RATE_INFO1_RESP_TYPE_VALD_M	BIT(0)
-#define HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M	GENMASK(5, 1)
-
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_LTF_SIZE_M	GENMASK(1, 0)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_STBC_M		BIT(2)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_HE_RE_M		BIT(3)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_TXBF_M		GENMASK(7, 4)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_BW_M		GENMASK(11, 8)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_NSS_M		GENMASK(15, 12)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_MCS_M		GENMASK(19, 16)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M	GENMASK(23, 20)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_GI_M		GENMASK(27, 24)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M		BIT(28)
-#define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M		BIT(29)
-
-#define HTT_USR_RATE_PPDU_TYPE(_val) \
-		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M)
-#define HTT_USR_RATE_PREAMBLE(_val) \
-		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M)
-#define HTT_USR_RATE_BW(_val) \
-		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_BW_M)
-#define HTT_USR_RATE_NSS(_val) \
-		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_NSS_M)
-#define HTT_USR_RATE_MCS(_val) \
-		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_MCS_M)
-#define HTT_USR_RATE_GI(_val) \
-		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_GI_M)
-#define HTT_USR_RATE_DCM(_val) \
-		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M)
-
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_LTF_SIZE_M		GENMASK(1, 0)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_STBC_M		BIT(2)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_HE_RE_M		BIT(3)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_TXBF_M		GENMASK(7, 4)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_BW_M		GENMASK(11, 8)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_NSS_M		GENMASK(15, 12)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_MCS_M		GENMASK(19, 16)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_PREAMBLE_M		GENMASK(23, 20)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_GI_M		GENMASK(27, 24)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_DCM_M		BIT(28)
-#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_LDPC_M		BIT(29)
-
-struct htt_ppdu_stats_user_rate {
-	u8 tid_num;
-	u8 reserved0;
-	__le16 sw_peer_id;
-	__le32 info0; /* %HTT_PPDU_STATS_USER_RATE_INFO0_*/
-	__le16 ru_end;
-	__le16 ru_start;
-	__le16 resp_ru_end;
-	__le16 resp_ru_start;
-	__le32 info1; /* %HTT_PPDU_STATS_USER_RATE_INFO1_ */
-	__le32 rate_flags; /* %HTT_PPDU_STATS_USER_RATE_FLAGS_ */
-	/* Note: resp_rate_info is only valid for if resp_type is UL */
-	__le32 resp_rate_flags; /* %HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_ */
-} __packed;
-
-#define HTT_PPDU_STATS_TX_INFO_FLAGS_RATECODE_M		GENMASK(7, 0)
-#define HTT_PPDU_STATS_TX_INFO_FLAGS_IS_AMPDU_M		BIT(8)
-#define HTT_PPDU_STATS_TX_INFO_FLAGS_BA_ACK_FAILED_M	GENMASK(10, 9)
-#define HTT_PPDU_STATS_TX_INFO_FLAGS_BW_M		GENMASK(13, 11)
-#define HTT_PPDU_STATS_TX_INFO_FLAGS_SGI_M		BIT(14)
-#define HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M		GENMASK(31, 16)
-
-#define HTT_TX_INFO_IS_AMSDU(_flags) \
-			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_IS_AMPDU_M)
-#define HTT_TX_INFO_BA_ACK_FAILED(_flags) \
-			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_BA_ACK_FAILED_M)
-#define HTT_TX_INFO_RATECODE(_flags) \
-			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_RATECODE_M)
-#define HTT_TX_INFO_PEERID(_flags) \
-			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M)
-
-enum  htt_ppdu_stats_usr_compln_status {
-	HTT_PPDU_STATS_USER_STATUS_OK,
-	HTT_PPDU_STATS_USER_STATUS_FILTERED,
-	HTT_PPDU_STATS_USER_STATUS_RESP_TIMEOUT,
-	HTT_PPDU_STATS_USER_STATUS_RESP_MISMATCH,
-	HTT_PPDU_STATS_USER_STATUS_ABORT,
-};
-
-#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_LONG_RETRY_M	GENMASK(3, 0)
-#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_SHORT_RETRY_M	GENMASK(7, 4)
-#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_IS_AMPDU_M		BIT(8)
-#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_RESP_TYPE_M		GENMASK(12, 9)
-
-#define HTT_USR_CMPLTN_IS_AMPDU(_val) \
-	    le32_get_bits(_val, HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_IS_AMPDU_M)
-#define HTT_USR_CMPLTN_LONG_RETRY(_val) \
-	    le32_get_bits(_val, HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_LONG_RETRY_M)
-#define HTT_USR_CMPLTN_SHORT_RETRY(_val) \
-	    le32_get_bits(_val, HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_SHORT_RETRY_M)
-
-struct htt_ppdu_stats_usr_cmpltn_cmn {
-	u8 status;
-	u8 tid_num;
-	__le16 sw_peer_id;
-	/* RSSI value of last ack packet (units = dB above noise floor) */
-	__le32 ack_rssi;
-	__le16 mpdu_tried;
-	__le16 mpdu_success;
-	__le32 flags; /* %HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_LONG_RETRIES*/
-} __packed;
-
-#define HTT_PPDU_STATS_ACK_BA_INFO_NUM_MPDU_M	GENMASK(8, 0)
-#define HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M	GENMASK(24, 9)
-#define HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM	GENMASK(31, 25)
-
-#define HTT_PPDU_STATS_NON_QOS_TID	16
-
-struct htt_ppdu_stats_usr_cmpltn_ack_ba_status {
-	__le32 ppdu_id;
-	__le16 sw_peer_id;
-	__le16 reserved0;
-	__le32 info; /* %HTT_PPDU_STATS_USR_CMPLTN_CMN_INFO_ */
-	__le16 current_seq;
-	__le16 start_seq;
-	__le32 success_bytes;
-} __packed;
-
-struct htt_ppdu_user_stats {
-	u16 peer_id;
-	u16 delay_ba;
-	u32 tlv_flags;
-	bool is_valid_peer_id;
-	struct htt_ppdu_stats_user_rate rate;
-	struct htt_ppdu_stats_usr_cmpltn_cmn cmpltn_cmn;
-	struct htt_ppdu_stats_usr_cmpltn_ack_ba_status ack_ba;
-};
-
-#define HTT_PPDU_STATS_MAX_USERS	8
-#define HTT_PPDU_DESC_MAX_DEPTH	16
-
-struct htt_ppdu_stats {
-	struct htt_ppdu_stats_common common;
-	struct htt_ppdu_user_stats user_stats[HTT_PPDU_STATS_MAX_USERS];
-};
-
-struct htt_ppdu_stats_info {
-	u32 tlv_bitmap;
-	u32 ppdu_id;
-	u32 frame_type;
-	u32 frame_ctrl;
-	u32 delay_ba;
-	u32 bar_num_users;
-	struct htt_ppdu_stats ppdu_stats;
-	struct list_head list;
-};
-
-/* @brief target -> host MLO offset indiciation message
- *
- * @details
- * The following field definitions describe the format of the HTT target
- * to host mlo offset indication message.
- *
- *
- * |31        29|28    |26|25  22|21 16|15  13|12     10 |9     8|7     0|
- * |---------------------------------------------------------------------|
- * |   rsvd1    | mac_freq                    |chip_id   |pdev_id|msgtype|
- * |---------------------------------------------------------------------|
- * |                           sync_timestamp_lo_us                      |
- * |---------------------------------------------------------------------|
- * |                           sync_timestamp_hi_us                      |
- * |---------------------------------------------------------------------|
- * |                           mlo_offset_lo                             |
- * |---------------------------------------------------------------------|
- * |                           mlo_offset_hi                             |
- * |---------------------------------------------------------------------|
- * |                           mlo_offset_clcks                          |
- * |---------------------------------------------------------------------|
- * |   rsvd2           | mlo_comp_clks |mlo_comp_us                      |
- * |---------------------------------------------------------------------|
- * |   rsvd3                   |mlo_comp_timer                           |
- * |---------------------------------------------------------------------|
- * Header fields
- *  - MSG_TYPE
- *    Bits 7:0
- *    Purpose: Identifies this is a MLO offset indication msg
- *  - PDEV_ID
- *    Bits 9:8
- *    Purpose: Pdev of this MLO offset
- *  - CHIP_ID
- *    Bits 12:10
- *    Purpose: chip_id of this MLO offset
- *  - MAC_FREQ
- *    Bits 28:13
- *  - SYNC_TIMESTAMP_LO_US
- *    Purpose: clock frequency of the mac HW block in MHz
- *    Bits: 31:0
- *    Purpose: lower 32 bits of the WLAN global time stamp at which
- *             last sync interrupt was received
- *  - SYNC_TIMESTAMP_HI_US
- *    Bits: 31:0
- *    Purpose: upper 32 bits of WLAN global time stamp at which
- *             last sync interrupt was received
- *  - MLO_OFFSET_LO
- *    Bits: 31:0
- *    Purpose: lower 32 bits of the MLO offset in us
- *  - MLO_OFFSET_HI
- *    Bits: 31:0
- *    Purpose: upper 32 bits of the MLO offset in us
- *  - MLO_COMP_US
- *    Bits: 15:0
- *    Purpose: MLO time stamp compensation applied in us
- *  - MLO_COMP_CLCKS
- *    Bits: 25:16
- *    Purpose: MLO time stamp compensation applied in clock ticks
- *  - MLO_COMP_TIMER
- *    Bits: 21:0
- *    Purpose: Periodic timer at which compensation is applied
- */
-
-#define HTT_T2H_MLO_OFFSET_INFO_MSG_TYPE        GENMASK(7, 0)
-#define HTT_T2H_MLO_OFFSET_INFO_PDEV_ID         GENMASK(9, 8)
-
-struct ath12k_htt_mlo_offset_msg {
-	__le32 info;
-	__le32 sync_timestamp_lo_us;
-	__le32 sync_timestamp_hi_us;
-	__le32 mlo_offset_hi;
-	__le32 mlo_offset_lo;
-	__le32 mlo_offset_clks;
-	__le32 mlo_comp_clks;
-	__le32 mlo_comp_timer;
-} __packed;
-
-/* @brief host -> target FW extended statistics retrieve
- *
- * @details
- * The following field definitions describe the format of the HTT host
- * to target FW extended stats retrieve message.
- * The message specifies the type of stats the host wants to retrieve.
- *
- * |31          24|23          16|15           8|7            0|
- * |-----------------------------------------------------------|
- * |   reserved   | stats type   |   pdev_mask  |   msg type   |
- * |-----------------------------------------------------------|
- * |                   config param [0]                        |
- * |-----------------------------------------------------------|
- * |                   config param [1]                        |
- * |-----------------------------------------------------------|
- * |                   config param [2]                        |
- * |-----------------------------------------------------------|
- * |                   config param [3]                        |
- * |-----------------------------------------------------------|
- * |                         reserved                          |
- * |-----------------------------------------------------------|
- * |                        cookie LSBs                        |
- * |-----------------------------------------------------------|
- * |                        cookie MSBs                        |
- * |-----------------------------------------------------------|
- * Header fields:
- *  - MSG_TYPE
- *    Bits 7:0
- *    Purpose: identifies this is a extended stats upload request message
- *    Value: 0x10
- *  - PDEV_MASK
- *    Bits 8:15
- *    Purpose: identifies the mask of PDEVs to retrieve stats from
- *    Value: This is a overloaded field, refer to usage and interpretation of
- *           PDEV in interface document.
- *           Bit   8    :  Reserved for SOC stats
- *           Bit 9 - 15 :  Indicates PDEV_MASK in DBDC
- *                         Indicates MACID_MASK in DBS
- *  - STATS_TYPE
- *    Bits 23:16
- *    Purpose: identifies which FW statistics to upload
- *    Value: Defined by htt_dbg_ext_stats_type (see htt_stats.h)
- *  - Reserved
- *    Bits 31:24
- *  - CONFIG_PARAM [0]
- *    Bits 31:0
- *    Purpose: give an opaque configuration value to the specified stats type
- *    Value: stats-type specific configuration value
- *           Refer to htt_stats.h for interpretation for each stats sub_type
- *  - CONFIG_PARAM [1]
- *    Bits 31:0
- *    Purpose: give an opaque configuration value to the specified stats type
- *    Value: stats-type specific configuration value
- *           Refer to htt_stats.h for interpretation for each stats sub_type
- *  - CONFIG_PARAM [2]
- *    Bits 31:0
- *    Purpose: give an opaque configuration value to the specified stats type
- *    Value: stats-type specific configuration value
- *           Refer to htt_stats.h for interpretation for each stats sub_type
- *  - CONFIG_PARAM [3]
- *    Bits 31:0
- *    Purpose: give an opaque configuration value to the specified stats type
- *    Value: stats-type specific configuration value
- *           Refer to htt_stats.h for interpretation for each stats sub_type
- *  - Reserved [31:0] for future use.
- *  - COOKIE_LSBS
- *    Bits 31:0
- *    Purpose: Provide a mechanism to match a target->host stats confirmation
- *        message with its preceding host->target stats request message.
- *    Value: LSBs of the opaque cookie specified by the host-side requestor
- *  - COOKIE_MSBS
- *    Bits 31:0
- *    Purpose: Provide a mechanism to match a target->host stats confirmation
- *        message with its preceding host->target stats request message.
- *    Value: MSBs of the opaque cookie specified by the host-side requestor
- */
-
-struct htt_ext_stats_cfg_hdr {
-	u8 msg_type;
-	u8 pdev_mask;
-	u8 stats_type;
-	u8 reserved;
-} __packed;
-
-struct htt_ext_stats_cfg_cmd {
-	struct htt_ext_stats_cfg_hdr hdr;
-	__le32 cfg_param0;
-	__le32 cfg_param1;
-	__le32 cfg_param2;
-	__le32 cfg_param3;
-	__le32 reserved;
-	__le32 cookie_lsb;
-	__le32 cookie_msb;
-} __packed;
-
-/* htt stats config default params */
-#define HTT_STAT_DEFAULT_RESET_START_OFFSET 0
-#define HTT_STAT_DEFAULT_CFG0_ALL_HWQS 0xffffffff
-#define HTT_STAT_DEFAULT_CFG0_ALL_TXQS 0xffffffff
-#define HTT_STAT_DEFAULT_CFG0_ALL_CMDQS 0xffff
-#define HTT_STAT_DEFAULT_CFG0_ALL_RINGS 0xffff
-#define HTT_STAT_DEFAULT_CFG0_ACTIVE_PEERS 0xff
-#define HTT_STAT_DEFAULT_CFG0_CCA_CUMULATIVE 0x00
-#define HTT_STAT_DEFAULT_CFG0_ACTIVE_VDEVS 0x00
-
-/* HTT_DBG_EXT_STATS_PEER_INFO
- * PARAMS:
- * @config_param0:
- *  [Bit0] - [0] for sw_peer_id, [1] for mac_addr based request
- *  [Bit15 : Bit 1] htt_peer_stats_req_mode_t
- *  [Bit31 : Bit16] sw_peer_id
- * @config_param1:
- *  peer_stats_req_type_mask:32 (enum htt_peer_stats_tlv_enum)
- *   0 bit htt_peer_stats_cmn_tlv
- *   1 bit htt_peer_details_tlv
- *   2 bit htt_tx_peer_rate_stats_tlv
- *   3 bit htt_rx_peer_rate_stats_tlv
- *   4 bit htt_tx_tid_stats_tlv/htt_tx_tid_stats_v1_tlv
- *   5 bit htt_rx_tid_stats_tlv
- *   6 bit htt_msdu_flow_stats_tlv
- * @config_param2: [Bit31 : Bit0] mac_addr31to0
- * @config_param3: [Bit15 : Bit0] mac_addr47to32
- *                [Bit31 : Bit16] reserved
- */
-#define HTT_STAT_PEER_INFO_MAC_ADDR BIT(0)
-#define HTT_STAT_DEFAULT_PEER_REQ_TYPE 0x7f
-
-/* Used to set different configs to the specified stats type.*/
-struct htt_ext_stats_cfg_params {
-	u32 cfg0;
-	u32 cfg1;
-	u32 cfg2;
-	u32 cfg3;
-};
-
-enum vdev_stats_offload_timer_duration {
-	ATH12K_STATS_TIMER_DUR_500MS = 1,
-	ATH12K_STATS_TIMER_DUR_1SEC = 2,
-	ATH12K_STATS_TIMER_DUR_2SEC = 3,
-};
-
-#define ATH12K_HTT_MAC_ADDR_L32_0	GENMASK(7, 0)
-#define ATH12K_HTT_MAC_ADDR_L32_1	GENMASK(15, 8)
-#define ATH12K_HTT_MAC_ADDR_L32_2	GENMASK(23, 16)
-#define ATH12K_HTT_MAC_ADDR_L32_3	GENMASK(31, 24)
-#define ATH12K_HTT_MAC_ADDR_H16_0	GENMASK(7, 0)
-#define ATH12K_HTT_MAC_ADDR_H16_1	GENMASK(15, 8)
-
-struct htt_mac_addr {
-	__le32 mac_addr_l32;
-	__le32 mac_addr_h16;
-} __packed;
-
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 {
 	memcpy(addr, &addr_l32, 4);
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.h b/drivers/net/wireless/ath/ath12k/dp_htt.h
new file mode 100644
index 000000000000..ce9064628d34
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.h
@@ -0,0 +1,1517 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_DP_HTT_H
+#define ATH12K_DP_HTT_H
+
+struct ath12k_dp;
+
+/* HTT definitions */
+#define HTT_TAG_TCL_METADATA_VERSION		5
+
+#define HTT_TCL_META_DATA_TYPE			GENMASK(1, 0)
+#define HTT_TCL_META_DATA_VALID_HTT		BIT(2)
+
+/* vdev meta data */
+#define HTT_TCL_META_DATA_VDEV_ID		 GENMASK(10, 3)
+#define HTT_TCL_META_DATA_PDEV_ID		 GENMASK(12, 11)
+#define HTT_TCL_META_DATA_HOST_INSPECTED_MISSION BIT(13)
+
+/* peer meta data */
+#define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 3)
+
+/* Global sequence number */
+#define HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM		3
+#define HTT_TCL_META_DATA_GLOBAL_SEQ_HOST_INSPECTED	BIT(2)
+#define HTT_TCL_META_DATA_GLOBAL_SEQ_NUM		GENMASK(14, 3)
+#define HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID	128
+
+/* HTT tx completion is overlaid in wbm_release_ring */
+#define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(16, 13)
+#define HTT_TX_WBM_COMP_INFO1_REINJECT_REASON	GENMASK(3, 0)
+#define HTT_TX_WBM_COMP_INFO1_EXCEPTION_FRAME	BIT(4)
+
+#define HTT_TX_WBM_COMP_INFO2_ACK_RSSI		GENMASK(31, 24)
+
+struct htt_tx_wbm_completion {
+	__le32 rsvd0[2];
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 info3;
+	__le32 info4;
+	__le32 rsvd1;
+
+} __packed;
+
+enum htt_h2t_msg_type {
+	HTT_H2T_MSG_TYPE_VERSION_REQ		= 0,
+	HTT_H2T_MSG_TYPE_SRING_SETUP		= 0xb,
+	HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG	= 0xc,
+	HTT_H2T_MSG_TYPE_EXT_STATS_CFG		= 0x10,
+	HTT_H2T_MSG_TYPE_PPDU_STATS_CFG		= 0x11,
+	HTT_H2T_MSG_TYPE_VDEV_TXRX_STATS_CFG	= 0x1a,
+	HTT_H2T_MSG_TYPE_TX_MONITOR_CFG		= 0x1b,
+};
+
+#define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
+#define HTT_OPTION_TCL_METADATA_VER_V1	1
+#define HTT_OPTION_TCL_METADATA_VER_V2	2
+#define HTT_OPTION_TAG			GENMASK(7, 0)
+#define HTT_OPTION_LEN			GENMASK(15, 8)
+#define HTT_OPTION_VALUE		GENMASK(31, 16)
+#define HTT_TCL_METADATA_VER_SZ		4
+
+struct htt_ver_req_cmd {
+	__le32 ver_reg_info;
+	__le32 tcl_metadata_version;
+} __packed;
+
+enum htt_srng_ring_type {
+	HTT_HW_TO_SW_RING,
+	HTT_SW_TO_HW_RING,
+	HTT_SW_TO_SW_RING,
+};
+
+enum htt_srng_ring_id {
+	HTT_RXDMA_HOST_BUF_RING,
+	HTT_RXDMA_MONITOR_STATUS_RING,
+	HTT_RXDMA_MONITOR_BUF_RING,
+	HTT_RXDMA_MONITOR_DESC_RING,
+	HTT_RXDMA_MONITOR_DEST_RING,
+	HTT_HOST1_TO_FW_RXBUF_RING,
+	HTT_HOST2_TO_FW_RXBUF_RING,
+	HTT_RXDMA_NON_MONITOR_DEST_RING,
+	HTT_RXDMA_HOST_BUF_RING2,
+	HTT_TX_MON_HOST2MON_BUF_RING,
+	HTT_TX_MON_MON2HOST_DEST_RING,
+	HTT_RX_MON_HOST2MON_BUF_RING,
+	HTT_RX_MON_MON2HOST_DEST_RING,
+};
+
+/* host -> target  HTT_SRING_SETUP message
+ *
+ * After target is booted up, Host can send SRING setup message for
+ * each host facing LMAC SRING. Target setups up HW registers based
+ * on setup message and confirms back to Host if response_required is set.
+ * Host should wait for confirmation message before sending new SRING
+ * setup message
+ *
+ * The message would appear as follows:
+ *
+ * |31            24|23    20|19|18 16|15|14          8|7                0|
+ * |--------------- +-----------------+----------------+------------------|
+ * |    ring_type   |      ring_id    |    pdev_id     |     msg_type     |
+ * |----------------------------------------------------------------------|
+ * |                          ring_base_addr_lo                           |
+ * |----------------------------------------------------------------------|
+ * |                         ring_base_addr_hi                            |
+ * |----------------------------------------------------------------------|
+ * |ring_misc_cfg_flag|ring_entry_size|            ring_size              |
+ * |----------------------------------------------------------------------|
+ * |                         ring_head_offset32_remote_addr_lo            |
+ * |----------------------------------------------------------------------|
+ * |                         ring_head_offset32_remote_addr_hi            |
+ * |----------------------------------------------------------------------|
+ * |                         ring_tail_offset32_remote_addr_lo            |
+ * |----------------------------------------------------------------------|
+ * |                         ring_tail_offset32_remote_addr_hi            |
+ * |----------------------------------------------------------------------|
+ * |                          ring_msi_addr_lo                            |
+ * |----------------------------------------------------------------------|
+ * |                          ring_msi_addr_hi                            |
+ * |----------------------------------------------------------------------|
+ * |                          ring_msi_data                               |
+ * |----------------------------------------------------------------------|
+ * |         intr_timer_th            |IM|      intr_batch_counter_th     |
+ * |----------------------------------------------------------------------|
+ * |          reserved        |RR|PTCF|        intr_low_threshold         |
+ * |----------------------------------------------------------------------|
+ * Where
+ *     IM = sw_intr_mode
+ *     RR = response_required
+ *     PTCF = prefetch_timer_cfg
+ *
+ * The message is interpreted as follows:
+ * dword0  - b'0:7   - msg_type: This will be set to
+ *                     HTT_H2T_MSG_TYPE_SRING_SETUP
+ *           b'8:15  - pdev_id:
+ *                     0 (for rings at SOC/UMAC level),
+ *                     1/2/3 mac id (for rings at LMAC level)
+ *           b'16:23 - ring_id: identify which ring is to setup,
+ *                     more details can be got from enum htt_srng_ring_id
+ *           b'24:31 - ring_type: identify type of host rings,
+ *                     more details can be got from enum htt_srng_ring_type
+ * dword1  - b'0:31  - ring_base_addr_lo: Lower 32bits of ring base address
+ * dword2  - b'0:31  - ring_base_addr_hi: Upper 32bits of ring base address
+ * dword3  - b'0:15  - ring_size: size of the ring in unit of 4-bytes words
+ *           b'16:23 - ring_entry_size: Size of each entry in 4-byte word units
+ *           b'24:31 - ring_misc_cfg_flag: Valid only for HW_TO_SW_RING and
+ *                     SW_TO_HW_RING.
+ *                     Refer to HTT_SRING_SETUP_RING_MISC_CFG_RING defs.
+ * dword4  - b'0:31  - ring_head_off32_remote_addr_lo:
+ *                     Lower 32 bits of memory address of the remote variable
+ *                     storing the 4-byte word offset that identifies the head
+ *                     element within the ring.
+ *                     (The head offset variable has type u32.)
+ *                     Valid for HW_TO_SW and SW_TO_SW rings.
+ * dword5  - b'0:31  - ring_head_off32_remote_addr_hi:
+ *                     Upper 32 bits of memory address of the remote variable
+ *                     storing the 4-byte word offset that identifies the head
+ *                     element within the ring.
+ *                     (The head offset variable has type u32.)
+ *                     Valid for HW_TO_SW and SW_TO_SW rings.
+ * dword6  - b'0:31  - ring_tail_off32_remote_addr_lo:
+ *                     Lower 32 bits of memory address of the remote variable
+ *                     storing the 4-byte word offset that identifies the tail
+ *                     element within the ring.
+ *                     (The tail offset variable has type u32.)
+ *                     Valid for HW_TO_SW and SW_TO_SW rings.
+ * dword7  - b'0:31  - ring_tail_off32_remote_addr_hi:
+ *                     Upper 32 bits of memory address of the remote variable
+ *                     storing the 4-byte word offset that identifies the tail
+ *                     element within the ring.
+ *                     (The tail offset variable has type u32.)
+ *                     Valid for HW_TO_SW and SW_TO_SW rings.
+ * dword8  - b'0:31  - ring_msi_addr_lo: Lower 32bits of MSI cfg address
+ *                     valid only for HW_TO_SW_RING and SW_TO_HW_RING
+ * dword9  - b'0:31  - ring_msi_addr_hi: Upper 32bits of MSI cfg address
+ *                     valid only for HW_TO_SW_RING and SW_TO_HW_RING
+ * dword10 - b'0:31  - ring_msi_data: MSI data
+ *                     Refer to HTT_SRING_SETUP_RING_MSC_CFG_xxx defs
+ *                     valid only for HW_TO_SW_RING and SW_TO_HW_RING
+ * dword11 - b'0:14  - intr_batch_counter_th:
+ *                     batch counter threshold is in units of 4-byte words.
+ *                     HW internally maintains and increments batch count.
+ *                     (see SRING spec for detail description).
+ *                     When batch count reaches threshold value, an interrupt
+ *                     is generated by HW.
+ *           b'15    - sw_intr_mode:
+ *                     This configuration shall be static.
+ *                     Only programmed at power up.
+ *                     0: generate pulse style sw interrupts
+ *                     1: generate level style sw interrupts
+ *           b'16:31 - intr_timer_th:
+ *                     The timer init value when timer is idle or is
+ *                     initialized to start downcounting.
+ *                     In 8us units (to cover a range of 0 to 524 ms)
+ * dword12 - b'0:15  - intr_low_threshold:
+ *                     Used only by Consumer ring to generate ring_sw_int_p.
+ *                     Ring entries low threshold water mark, that is used
+ *                     in combination with the interrupt timer as well as
+ *                     the clearing of the level interrupt.
+ *           b'16:18 - prefetch_timer_cfg:
+ *                     Used only by Consumer ring to set timer mode to
+ *                     support Application prefetch handling.
+ *                     The external tail offset/pointer will be updated
+ *                     at following intervals:
+ *                     3'b000: (Prefetch feature disabled; used only for debug)
+ *                     3'b001: 1 usec
+ *                     3'b010: 4 usec
+ *                     3'b011: 8 usec (default)
+ *                     3'b100: 16 usec
+ *                     Others: Reserved
+ *           b'19    - response_required:
+ *                     Host needs HTT_T2H_MSG_TYPE_SRING_SETUP_DONE as response
+ *           b'20:31 - reserved:  reserved for future use
+ */
+
+#define HTT_SRNG_SETUP_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
+#define HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
+#define HTT_SRNG_SETUP_CMD_INFO0_RING_ID	GENMASK(23, 16)
+#define HTT_SRNG_SETUP_CMD_INFO0_RING_TYPE	GENMASK(31, 24)
+
+#define HTT_SRNG_SETUP_CMD_INFO1_RING_SIZE			GENMASK(15, 0)
+#define HTT_SRNG_SETUP_CMD_INFO1_RING_ENTRY_SIZE		GENMASK(23, 16)
+#define HTT_SRNG_SETUP_CMD_INFO1_RING_LOOP_CNT_DIS		BIT(25)
+#define HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP		BIT(27)
+#define HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_HOST_FW_SWAP	BIT(28)
+#define HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_TLV_SWAP		BIT(29)
+
+#define HTT_SRNG_SETUP_CMD_INTR_INFO_BATCH_COUNTER_THRESH	GENMASK(14, 0)
+#define HTT_SRNG_SETUP_CMD_INTR_INFO_SW_INTR_MODE		BIT(15)
+#define HTT_SRNG_SETUP_CMD_INTR_INFO_INTR_TIMER_THRESH		GENMASK(31, 16)
+
+#define HTT_SRNG_SETUP_CMD_INFO2_INTR_LOW_THRESH	GENMASK(15, 0)
+#define HTT_SRNG_SETUP_CMD_INFO2_PRE_FETCH_TIMER_CFG	GENMASK(18, 16)
+#define HTT_SRNG_SETUP_CMD_INFO2_RESPONSE_REQUIRED	BIT(19)
+
+struct htt_srng_setup_cmd {
+	__le32 info0;
+	__le32 ring_base_addr_lo;
+	__le32 ring_base_addr_hi;
+	__le32 info1;
+	__le32 ring_head_off32_remote_addr_lo;
+	__le32 ring_head_off32_remote_addr_hi;
+	__le32 ring_tail_off32_remote_addr_lo;
+	__le32 ring_tail_off32_remote_addr_hi;
+	__le32 ring_msi_addr_lo;
+	__le32 ring_msi_addr_hi;
+	__le32 msi_data;
+	__le32 intr_info;
+	__le32 info2;
+} __packed;
+
+/* host -> target FW  PPDU_STATS config message
+ *
+ * @details
+ * The following field definitions describe the format of the HTT host
+ * to target FW for PPDU_STATS_CFG msg.
+ * The message allows the host to configure the PPDU_STATS_IND messages
+ * produced by the target.
+ *
+ * |31          24|23          16|15           8|7            0|
+ * |-----------------------------------------------------------|
+ * |    REQ bit mask             |   pdev_mask  |   msg type   |
+ * |-----------------------------------------------------------|
+ * Header fields:
+ *  - MSG_TYPE
+ *    Bits 7:0
+ *    Purpose: identifies this is a req to configure ppdu_stats_ind from target
+ *    Value: 0x11
+ *  - PDEV_MASK
+ *    Bits 8:15
+ *    Purpose: identifies which pdevs this PPDU stats configuration applies to
+ *    Value: This is a overloaded field, refer to usage and interpretation of
+ *           PDEV in interface document.
+ *           Bit   8    :  Reserved for SOC stats
+ *           Bit 9 - 15 :  Indicates PDEV_MASK in DBDC
+ *                         Indicates MACID_MASK in DBS
+ *  - REQ_TLV_BIT_MASK
+ *    Bits 16:31
+ *    Purpose: each set bit indicates the corresponding PPDU stats TLV type
+ *        needs to be included in the target's PPDU_STATS_IND messages.
+ *    Value: refer htt_ppdu_stats_tlv_tag_t <<<???
+ *
+ */
+
+struct htt_ppdu_stats_cfg_cmd {
+	__le32 msg;
+} __packed;
+
+#define HTT_PPDU_STATS_CFG_MSG_TYPE		GENMASK(7, 0)
+#define HTT_PPDU_STATS_CFG_SOC_STATS		BIT(8)
+#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 9)
+#define HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK	GENMASK(31, 16)
+
+enum htt_ppdu_stats_tag_type {
+	HTT_PPDU_STATS_TAG_COMMON,
+	HTT_PPDU_STATS_TAG_USR_COMMON,
+	HTT_PPDU_STATS_TAG_USR_RATE,
+	HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_64,
+	HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_256,
+	HTT_PPDU_STATS_TAG_SCH_CMD_STATUS,
+	HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON,
+	HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_64,
+	HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_256,
+	HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS,
+	HTT_PPDU_STATS_TAG_USR_COMPLTN_FLUSH,
+	HTT_PPDU_STATS_TAG_USR_COMMON_ARRAY,
+	HTT_PPDU_STATS_TAG_INFO,
+	HTT_PPDU_STATS_TAG_TX_MGMTCTRL_PAYLOAD,
+
+	/* New TLV's are added above to this line */
+	HTT_PPDU_STATS_TAG_MAX,
+};
+
+#define HTT_PPDU_STATS_TAG_DEFAULT (BIT(HTT_PPDU_STATS_TAG_COMMON) \
+				   | BIT(HTT_PPDU_STATS_TAG_USR_COMMON) \
+				   | BIT(HTT_PPDU_STATS_TAG_USR_RATE) \
+				   | BIT(HTT_PPDU_STATS_TAG_SCH_CMD_STATUS) \
+				   | BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON) \
+				   | BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS) \
+				   | BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_FLUSH) \
+				   | BIT(HTT_PPDU_STATS_TAG_USR_COMMON_ARRAY))
+
+#define HTT_PPDU_STATS_TAG_PKTLOG  (BIT(HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_64) | \
+				    BIT(HTT_PPDU_STATS_TAG_USR_MPDU_ENQ_BITMAP_256) | \
+				    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_64) | \
+				    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_BA_BITMAP_256) | \
+				    BIT(HTT_PPDU_STATS_TAG_INFO) | \
+				    BIT(HTT_PPDU_STATS_TAG_TX_MGMTCTRL_PAYLOAD) | \
+				    HTT_PPDU_STATS_TAG_DEFAULT)
+
+enum htt_stats_internal_ppdu_frametype {
+	HTT_STATS_PPDU_FTYPE_CTRL,
+	HTT_STATS_PPDU_FTYPE_DATA,
+	HTT_STATS_PPDU_FTYPE_BAR,
+	HTT_STATS_PPDU_FTYPE_MAX
+};
+
+/* HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG Message
+ *
+ * details:
+ *    HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG message is sent by host to
+ *    configure RXDMA rings.
+ *    The configuration is per ring based and includes both packet subtypes
+ *    and PPDU/MPDU TLVs.
+ *
+ *    The message would appear as follows:
+ *
+ *    |31   29|28|27|26|25|24|23       16|15             8|7             0|
+ *    |-------+--+--+--+--+--+-----------+----------------+---------------|
+ *    | rsvd1 |ED|DT|OV|PS|SS|  ring_id  |     pdev_id    |    msg_type   |
+ *    |-------------------------------------------------------------------|
+ *    |              rsvd2               |           ring_buffer_size     |
+ *    |-------------------------------------------------------------------|
+ *    |                        packet_type_enable_flags_0                 |
+ *    |-------------------------------------------------------------------|
+ *    |                        packet_type_enable_flags_1                 |
+ *    |-------------------------------------------------------------------|
+ *    |                        packet_type_enable_flags_2                 |
+ *    |-------------------------------------------------------------------|
+ *    |                        packet_type_enable_flags_3                 |
+ *    |-------------------------------------------------------------------|
+ *    |                         tlv_filter_in_flags                       |
+ *    |-------------------------------------------------------------------|
+ * Where:
+ *     PS = pkt_swap
+ *     SS = status_swap
+ * The message is interpreted as follows:
+ * dword0 - b'0:7   - msg_type: This will be set to
+ *                    HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
+ *          b'8:15  - pdev_id:
+ *                    0 (for rings at SOC/UMAC level),
+ *                    1/2/3 mac id (for rings at LMAC level)
+ *          b'16:23 - ring_id : Identify the ring to configure.
+ *                    More details can be got from enum htt_srng_ring_id
+ *          b'24    - status_swap: 1 is to swap status TLV
+ *          b'25    - pkt_swap:  1 is to swap packet TLV
+ *          b'26    - rx_offset_valid (OV): flag to indicate rx offsets
+ *		      configuration fields are valid
+ *          b'27    - drop_thresh_valid (DT): flag to indicate if the
+ *		      rx_drop_threshold field is valid
+ *          b'28    - rx_mon_global_en: Enable/Disable global register
+ *		      configuration in Rx monitor module.
+ *          b'29:31 - rsvd1:  reserved for future use
+ * dword1 - b'0:16  - ring_buffer_size: size of buffers referenced by rx ring,
+ *                    in byte units.
+ *                    Valid only for HW_TO_SW_RING and SW_TO_HW_RING
+ *        - b'16:31 - rsvd2: Reserved for future use
+ * dword2 - b'0:31  - packet_type_enable_flags_0:
+ *                    Enable MGMT packet from 0b0000 to 0b1001
+ *                    bits from low to high: FP, MD, MO - 3 bits
+ *                        FP: Filter_Pass
+ *                        MD: Monitor_Direct
+ *                        MO: Monitor_Other
+ *                    10 mgmt subtypes * 3 bits -> 30 bits
+ *                    Refer to PKT_TYPE_ENABLE_FLAG0_xxx_MGMT_xxx defs
+ * dword3 - b'0:31  - packet_type_enable_flags_1:
+ *                    Enable MGMT packet from 0b1010 to 0b1111
+ *                    bits from low to high: FP, MD, MO - 3 bits
+ *                    Refer to PKT_TYPE_ENABLE_FLAG1_xxx_MGMT_xxx defs
+ * dword4 - b'0:31 -  packet_type_enable_flags_2:
+ *                    Enable CTRL packet from 0b0000 to 0b1001
+ *                    bits from low to high: FP, MD, MO - 3 bits
+ *                    Refer to PKT_TYPE_ENABLE_FLAG2_xxx_CTRL_xxx defs
+ * dword5 - b'0:31  - packet_type_enable_flags_3:
+ *                    Enable CTRL packet from 0b1010 to 0b1111,
+ *                    MCAST_DATA, UCAST_DATA, NULL_DATA
+ *                    bits from low to high: FP, MD, MO - 3 bits
+ *                    Refer to PKT_TYPE_ENABLE_FLAG3_xxx_CTRL_xxx defs
+ * dword6 - b'0:31 -  tlv_filter_in_flags:
+ *                    Filter in Attention/MPDU/PPDU/Header/User tlvs
+ *                    Refer to CFG_TLV_FILTER_IN_FLAG defs
+ */
+
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_RING_ID	GENMASK(23, 16)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_SS		BIT(24)
+#define HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PS		BIT(25)
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
+
+#define HTT_RX_RING_SELECTION_CFG_RX_PACKET_OFFSET      GENMASK(15, 0)
+#define HTT_RX_RING_SELECTION_CFG_RX_HEADER_OFFSET      GENMASK(31, 16)
+#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_OFFSET    GENMASK(15, 0)
+#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_OFFSET  GENMASK(31, 16)
+#define HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_OFFSET    GENMASK(15, 0)
+#define HTT_RX_RING_SELECTION_CFG_RX_MSDU_START_OFFSET  GENMASK(31, 16)
+#define HTT_RX_RING_SELECTION_CFG_RX_ATTENTION_OFFSET   GENMASK(15, 0)
+
+#define HTT_RX_RING_SELECTION_CFG_WORD_MASK_COMPACT_SET	BIT(23)
+#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_START_MASK	GENMASK(15, 0)
+#define HTT_RX_RING_SELECTION_CFG_RX_MPDU_END_MASK	GENMASK(18, 16)
+#define HTT_RX_RING_SELECTION_CFG_RX_MSDU_END_MASK	GENMASK(16, 0)
+
+enum htt_rx_filter_tlv_flags {
+	HTT_RX_FILTER_TLV_FLAGS_MPDU_START		= BIT(0),
+	HTT_RX_FILTER_TLV_FLAGS_MSDU_START		= BIT(1),
+	HTT_RX_FILTER_TLV_FLAGS_RX_PACKET		= BIT(2),
+	HTT_RX_FILTER_TLV_FLAGS_MSDU_END		= BIT(3),
+	HTT_RX_FILTER_TLV_FLAGS_MPDU_END		= BIT(4),
+	HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER		= BIT(5),
+	HTT_RX_FILTER_TLV_FLAGS_PER_MSDU_HEADER		= BIT(6),
+	HTT_RX_FILTER_TLV_FLAGS_ATTENTION		= BIT(7),
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_START		= BIT(8),
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END		= BIT(9),
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS	= BIT(10),
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT	= BIT(11),
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE	= BIT(12),
+	HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO	= BIT(13),
+};
+
+enum htt_rx_mgmt_pkt_filter_tlv_flags0 {
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ		= BIT(0),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ		= BIT(1),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ		= BIT(2),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP		= BIT(3),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP		= BIT(4),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP		= BIT(5),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ	= BIT(6),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ	= BIT(7),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ	= BIT(8),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP	= BIT(9),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP	= BIT(10),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP	= BIT(11),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ		= BIT(12),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ		= BIT(13),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ		= BIT(14),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP		= BIT(15),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP		= BIT(16),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP		= BIT(17),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV	= BIT(18),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV	= BIT(19),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV	= BIT(20),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7		= BIT(21),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7		= BIT(22),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7		= BIT(23),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON		= BIT(24),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON		= BIT(25),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON		= BIT(26),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM		= BIT(27),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM		= BIT(28),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM		= BIT(29),
+};
+
+enum htt_rx_mgmt_pkt_filter_tlv_flags1 {
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC		= BIT(0),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC		= BIT(1),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC		= BIT(2),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH		= BIT(3),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH		= BIT(4),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH		= BIT(5),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH		= BIT(6),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH		= BIT(7),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH		= BIT(8),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION		= BIT(9),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION		= BIT(10),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION		= BIT(11),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK	= BIT(12),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK	= BIT(13),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK	= BIT(14),
+	HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15	= BIT(15),
+	HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15	= BIT(16),
+	HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15	= BIT(17),
+};
+
+enum htt_rx_ctrl_pkt_filter_tlv_flags2 {
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1	= BIT(0),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1	= BIT(1),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1	= BIT(2),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2	= BIT(3),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2	= BIT(4),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2	= BIT(5),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER	= BIT(6),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER	= BIT(7),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER	= BIT(8),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4	= BIT(9),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4	= BIT(10),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4	= BIT(11),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL	= BIT(12),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL	= BIT(13),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL	= BIT(14),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP	= BIT(15),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP	= BIT(16),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP	= BIT(17),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT	= BIT(18),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT	= BIT(19),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT	= BIT(20),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER	= BIT(21),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER	= BIT(22),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER	= BIT(23),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR		= BIT(24),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BAR		= BIT(25),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BAR		= BIT(26),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BA			= BIT(27),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BA			= BIT(28),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BA			= BIT(29),
+};
+
+enum htt_rx_ctrl_pkt_filter_tlv_flags3 {
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL		= BIT(0),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL		= BIT(1),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL		= BIT(2),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_RTS		= BIT(3),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_RTS		= BIT(4),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_RTS		= BIT(5),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CTS		= BIT(6),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CTS		= BIT(7),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CTS		= BIT(8),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_ACK		= BIT(9),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_ACK		= BIT(10),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_ACK		= BIT(11),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND		= BIT(12),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND		= BIT(13),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND		= BIT(14),
+	HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK		= BIT(15),
+	HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK		= BIT(16),
+	HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK		= BIT(17),
+};
+
+enum htt_rx_data_pkt_filter_tlv_flasg3 {
+	HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST	= BIT(18),
+	HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_MCAST	= BIT(19),
+	HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_MCAST	= BIT(20),
+	HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST	= BIT(21),
+	HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_UCAST	= BIT(22),
+	HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_UCAST	= BIT(23),
+	HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA	= BIT(24),
+	HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA	= BIT(25),
+	HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA	= BIT(26),
+};
+
+#define HTT_RX_FP_MGMT_FILTER_FLAGS0 \
+	(HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON \
+	| HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM)
+
+#define HTT_RX_MD_MGMT_FILTER_FLAGS0 \
+	(HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON \
+	| HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM)
+
+#define HTT_RX_MO_MGMT_FILTER_FLAGS0 \
+	(HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_REQ \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ASSOC_RESP \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_REQ \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_REASSOC_RESP \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_REQ \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_RESP \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_PROBE_TIMING_ADV \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_BEACON \
+	| HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_ATIM)
+
+#define HTT_RX_FP_MGMT_FILTER_FLAGS1 (HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC \
+				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH \
+				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH \
+				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION \
+				     | HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK)
+
+#define HTT_RX_MD_MGMT_FILTER_FLAGS1 (HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC \
+				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH \
+				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH \
+				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION \
+				     | HTT_RX_MD_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK)
+
+#define HTT_RX_MO_MGMT_FILTER_FLAGS1 (HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DISASSOC \
+				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_AUTH \
+				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_DEAUTH \
+				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION \
+				     | HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_ACTION_NOACK)
+
+#define HTT_RX_FP_CTRL_FILTER_FLASG2 (HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER \
+				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR \
+				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BA)
+
+#define HTT_RX_MD_CTRL_FILTER_FLASG2 (HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER \
+				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BAR \
+				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS2_BA)
+
+#define HTT_RX_MO_CTRL_FILTER_FLASG2 (HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_WRAPPER \
+				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BAR \
+				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_BA)
+
+#define HTT_RX_FP_CTRL_FILTER_FLASG3 (HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL \
+				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_RTS \
+				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CTS \
+				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_ACK \
+				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND \
+				     | HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK)
+
+#define HTT_RX_MD_CTRL_FILTER_FLASG3 (HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL \
+				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_RTS \
+				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CTS \
+				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_ACK \
+				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND \
+				     | HTT_RX_MD_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK)
+
+#define HTT_RX_MO_CTRL_FILTER_FLASG3 (HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_PSPOLL \
+				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_RTS \
+				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CTS \
+				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_ACK \
+				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND \
+				     | HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS3_CFEND_ACK)
+
+#define HTT_RX_FP_DATA_FILTER_FLASG3 (HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST \
+				     | HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST \
+				     | HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA)
+
+#define HTT_RX_MD_DATA_FILTER_FLASG3 (HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_MCAST \
+				     | HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_UCAST \
+				     | HTT_RX_MD_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA)
+
+#define HTT_RX_MO_DATA_FILTER_FLASG3 (HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_MCAST \
+				     | HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_UCAST \
+				     | HTT_RX_MO_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA)
+
+#define HTT_RX_MON_FP_MGMT_FILTER_FLAGS0 \
+		(HTT_RX_FP_MGMT_FILTER_FLAGS0 | \
+		HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7)
+
+#define HTT_RX_MON_MO_MGMT_FILTER_FLAGS0 \
+		(HTT_RX_MO_MGMT_FILTER_FLAGS0 | \
+		HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS0_RESERVED_7)
+
+#define HTT_RX_MON_FP_MGMT_FILTER_FLAGS1 \
+		(HTT_RX_FP_MGMT_FILTER_FLAGS1 | \
+		HTT_RX_FP_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15)
+
+#define HTT_RX_MON_MO_MGMT_FILTER_FLAGS1 \
+		(HTT_RX_MO_MGMT_FILTER_FLAGS1 | \
+		HTT_RX_MO_MGMT_PKT_FILTER_TLV_FLAGS1_RESERVED_15)
+
+#define HTT_RX_MON_FP_CTRL_FILTER_FLASG2 \
+		(HTT_RX_FP_CTRL_FILTER_FLASG2 | \
+		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1 | \
+		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2 | \
+		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER | \
+		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4 | \
+		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL | \
+		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP | \
+		HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT)
+
+#define HTT_RX_MON_MO_CTRL_FILTER_FLASG2 \
+		(HTT_RX_MO_CTRL_FILTER_FLASG2 | \
+		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_1 | \
+		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_2 | \
+		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_TRIGGER | \
+		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_RESERVED_4 | \
+		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_BF_REP_POLL | \
+		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_VHT_NDP | \
+		HTT_RX_MO_CTRL_PKT_FILTER_TLV_FLAGS2_CTRL_FRAME_EXT)
+
+#define HTT_RX_MON_FP_CTRL_FILTER_FLASG3 HTT_RX_FP_CTRL_FILTER_FLASG3
+
+#define HTT_RX_MON_MO_CTRL_FILTER_FLASG3 HTT_RX_MO_CTRL_FILTER_FLASG3
+
+#define HTT_RX_MON_FP_DATA_FILTER_FLASG3 HTT_RX_FP_DATA_FILTER_FLASG3
+
+#define HTT_RX_MON_MO_DATA_FILTER_FLASG3 HTT_RX_MO_DATA_FILTER_FLASG3
+
+#define HTT_RX_MON_FILTER_TLV_FLAGS \
+		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE)
+
+#define HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING \
+		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
+		HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE)
+
+#define HTT_RX_MON_FILTER_TLV_FLAGS_MON_BUF_RING \
+		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
+		HTT_RX_FILTER_TLV_FLAGS_MSDU_START | \
+		HTT_RX_FILTER_TLV_FLAGS_RX_PACKET | \
+		HTT_RX_FILTER_TLV_FLAGS_MSDU_END | \
+		HTT_RX_FILTER_TLV_FLAGS_MPDU_END | \
+		HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER | \
+		HTT_RX_FILTER_TLV_FLAGS_PER_MSDU_HEADER | \
+		HTT_RX_FILTER_TLV_FLAGS_ATTENTION)
+
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
+/* msdu start. mpdu end, attention, rx hdr tlv's are not subscribed */
+#define HTT_RX_TLV_FLAGS_RXDMA_RING \
+		(HTT_RX_FILTER_TLV_FLAGS_MPDU_START | \
+		HTT_RX_FILTER_TLV_FLAGS_RX_PACKET | \
+		HTT_RX_FILTER_TLV_FLAGS_MSDU_END)
+
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
+
+struct htt_rx_ring_selection_cfg_cmd {
+	__le32 info0;
+	__le32 info1;
+	__le32 pkt_type_en_flags0;
+	__le32 pkt_type_en_flags1;
+	__le32 pkt_type_en_flags2;
+	__le32 pkt_type_en_flags3;
+	__le32 rx_filter_tlv;
+	__le32 rx_packet_offset;
+	__le32 rx_mpdu_offset;
+	__le32 rx_msdu_offset;
+	__le32 rx_attn_offset;
+	__le32 info2;
+	__le32 reserved[2];
+	__le32 rx_mpdu_start_end_mask;
+	__le32 rx_msdu_end_word_mask;
+	__le32 info3;
+} __packed;
+
+#define HTT_RX_RING_TLV_DROP_THRESHOLD_VALUE	32
+#define HTT_RX_RING_DEFAULT_DMA_LENGTH		0x7
+#define HTT_RX_RING_PKT_TLV_OFFSET		0x1
+
+struct htt_rx_ring_tlv_filter {
+	u32 rx_filter; /* see htt_rx_filter_tlv_flags */
+	u32 pkt_filter_flags0; /* MGMT */
+	u32 pkt_filter_flags1; /* MGMT */
+	u32 pkt_filter_flags2; /* CTRL */
+	u32 pkt_filter_flags3; /* DATA */
+	bool offset_valid;
+	u16 rx_packet_offset;
+	u16 rx_header_offset;
+	u16 rx_mpdu_end_offset;
+	u16 rx_mpdu_start_offset;
+	u16 rx_msdu_end_offset;
+	u16 rx_msdu_start_offset;
+	u16 rx_attn_offset;
+	u16 rx_mpdu_start_wmask;
+	u16 rx_mpdu_end_wmask;
+	u32 rx_msdu_end_wmask;
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
+};
+
+#define HTT_STATS_FRAME_CTRL_TYPE_MGMT  0x0
+#define HTT_STATS_FRAME_CTRL_TYPE_CTRL  0x1
+#define HTT_STATS_FRAME_CTRL_TYPE_DATA  0x2
+#define HTT_STATS_FRAME_CTRL_TYPE_RESV  0x3
+
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_RING_ID	GENMASK(23, 16)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_SS		BIT(24)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO0_PS		BIT(25)
+
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_RING_BUFF_SIZE	GENMASK(15, 0)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_PKT_TYPE		GENMASK(18, 16)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_MGMT	GENMASK(21, 19)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_CTRL	GENMASK(24, 22)
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO1_CONF_LEN_DATA	GENMASK(27, 25)
+
+#define HTT_TX_RING_SELECTION_CFG_CMD_INFO2_PKT_TYPE_EN_FLAG	GENMASK(2, 0)
+
+struct htt_tx_ring_selection_cfg_cmd {
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 tlv_filter_mask_in0;
+	__le32 tlv_filter_mask_in1;
+	__le32 tlv_filter_mask_in2;
+	__le32 tlv_filter_mask_in3;
+	__le32 reserved[3];
+} __packed;
+
+#define HTT_TX_RING_TLV_FILTER_MGMT_DMA_LEN	GENMASK(3, 0)
+#define HTT_TX_RING_TLV_FILTER_CTRL_DMA_LEN	GENMASK(7, 4)
+#define HTT_TX_RING_TLV_FILTER_DATA_DMA_LEN	GENMASK(11, 8)
+
+#define HTT_TX_MON_FILTER_HYBRID_MODE \
+		(HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_START_STATUS | \
+		HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_END_STATUS | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_END | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PPDU | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_PPDU | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_ACK_OR_BA | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_1K_BA | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PROT | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_PROT | \
+		HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_RESPONSE | \
+		HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO | \
+		HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO_PART2)
+
+struct htt_tx_ring_tlv_filter {
+	u32 tx_mon_downstream_tlv_flags;
+	u32 tx_mon_upstream_tlv_flags0;
+	u32 tx_mon_upstream_tlv_flags1;
+	u32 tx_mon_upstream_tlv_flags2;
+	bool tx_mon_mgmt_filter;
+	bool tx_mon_data_filter;
+	bool tx_mon_ctrl_filter;
+	u16 tx_mon_pkt_dma_len;
+} __packed;
+
+enum htt_tx_mon_upstream_tlv_flags0 {
+	HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_START_STATUS		= BIT(1),
+	HTT_TX_FILTER_TLV_FLAGS0_RESPONSE_END_STATUS		= BIT(2),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START		= BIT(3),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_END		= BIT(4),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PPDU	= BIT(5),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_PPDU	= BIT(6),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_ACK_OR_BA	= BIT(7),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_1K_BA		= BIT(8),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_START_PROT	= BIT(9),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_PROT		= BIT(10),
+	HTT_TX_FILTER_TLV_FLAGS0_TX_FES_STATUS_USER_RESPONSE	= BIT(11),
+	HTT_TX_FILTER_TLV_FLAGS0_RX_FRAME_BITMAP_ACK		= BIT(12),
+	HTT_TX_FILTER_TLV_FLAGS0_RX_FRAME_1K_BITMAP_ACK		= BIT(13),
+	HTT_TX_FILTER_TLV_FLAGS0_COEX_TX_STATUS			= BIT(14),
+	HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO		= BIT(15),
+	HTT_TX_FILTER_TLV_FLAGS0_RECEIVED_RESPONSE_INFO_PART2	= BIT(16),
+};
+
+#define HTT_TX_FILTER_TLV_FLAGS2_TXPCU_PHYTX_OTHER_TRANSMIT_INFO32	BIT(11)
+
+/* HTT message target->host */
+
+enum htt_t2h_msg_type {
+	HTT_T2H_MSG_TYPE_VERSION_CONF,
+	HTT_T2H_MSG_TYPE_PEER_MAP	= 0x3,
+	HTT_T2H_MSG_TYPE_PEER_UNMAP	= 0x4,
+	HTT_T2H_MSG_TYPE_RX_ADDBA	= 0x5,
+	HTT_T2H_MSG_TYPE_PKTLOG		= 0x8,
+	HTT_T2H_MSG_TYPE_SEC_IND	= 0xb,
+	HTT_T2H_MSG_TYPE_PEER_MAP2	= 0x1e,
+	HTT_T2H_MSG_TYPE_PEER_UNMAP2	= 0x1f,
+	HTT_T2H_MSG_TYPE_PPDU_STATS_IND = 0x1d,
+	HTT_T2H_MSG_TYPE_EXT_STATS_CONF = 0x1c,
+	HTT_T2H_MSG_TYPE_BKPRESSURE_EVENT_IND = 0x24,
+	HTT_T2H_MSG_TYPE_MLO_TIMESTAMP_OFFSET_IND = 0x28,
+	HTT_T2H_MSG_TYPE_PEER_MAP3	= 0x2b,
+	HTT_T2H_MSG_TYPE_VDEV_TXRX_STATS_PERIODIC_IND = 0x2c,
+};
+
+#define HTT_TARGET_VERSION_MAJOR 3
+
+#define HTT_T2H_MSG_TYPE		GENMASK(7, 0)
+#define HTT_T2H_VERSION_CONF_MINOR	GENMASK(15, 8)
+#define HTT_T2H_VERSION_CONF_MAJOR	GENMASK(23, 16)
+
+struct htt_t2h_version_conf_msg {
+	__le32 version;
+} __packed;
+
+#define HTT_T2H_PEER_MAP_INFO_VDEV_ID	GENMASK(15, 8)
+#define HTT_T2H_PEER_MAP_INFO_PEER_ID	GENMASK(31, 16)
+#define HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16	GENMASK(15, 0)
+#define HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID	GENMASK(31, 16)
+#define HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL	GENMASK(15, 0)
+#define HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID	GENMASK(15, 0)
+#define HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL	GENMASK(31, 16)
+#define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_M	BIT(16)
+#define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_S	16
+
+struct htt_t2h_peer_map_event {
+	__le32 info;
+	__le32 mac_addr_l32;
+	__le32 info1;
+	__le32 info2;
+} __packed;
+
+#define HTT_T2H_PEER_UNMAP_INFO_VDEV_ID	HTT_T2H_PEER_MAP_INFO_VDEV_ID
+#define HTT_T2H_PEER_UNMAP_INFO_PEER_ID	HTT_T2H_PEER_MAP_INFO_PEER_ID
+#define HTT_T2H_PEER_UNMAP_INFO1_MAC_ADDR_H16 \
+					HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16
+#define HTT_T2H_PEER_MAP_INFO1_NEXT_HOP_M HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_M
+#define HTT_T2H_PEER_MAP_INFO1_NEXT_HOP_S HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_S
+
+struct htt_t2h_peer_unmap_event {
+	__le32 info;
+	__le32 mac_addr_l32;
+	__le32 info1;
+} __packed;
+
+struct htt_resp_msg {
+	union {
+		struct htt_t2h_version_conf_msg version_msg;
+		struct htt_t2h_peer_map_event peer_map_ev;
+		struct htt_t2h_peer_unmap_event peer_unmap_ev;
+	};
+} __packed;
+
+#define HTT_VDEV_GET_STATS_U64(msg_l32, msg_u32)\
+	(((u64)__le32_to_cpu(msg_u32) << 32) | (__le32_to_cpu(msg_l32)))
+#define HTT_T2H_VDEV_STATS_PERIODIC_MSG_TYPE		GENMASK(7, 0)
+#define HTT_T2H_VDEV_STATS_PERIODIC_PDEV_ID		GENMASK(15, 8)
+#define HTT_T2H_VDEV_STATS_PERIODIC_NUM_VDEV		GENMASK(23, 16)
+#define HTT_T2H_VDEV_STATS_PERIODIC_PAYLOAD_BYTES	GENMASK(15, 0)
+#define HTT_VDEV_TXRX_STATS_COMMON_TLV		0
+#define HTT_VDEV_TXRX_STATS_HW_STATS_TLV	1
+
+struct htt_t2h_vdev_txrx_stats_ind {
+	__le32 vdev_id;
+	__le32 rx_msdu_byte_cnt_lo;
+	__le32 rx_msdu_byte_cnt_hi;
+	__le32 rx_msdu_cnt_lo;
+	__le32 rx_msdu_cnt_hi;
+	__le32 tx_msdu_byte_cnt_lo;
+	__le32 tx_msdu_byte_cnt_hi;
+	__le32 tx_msdu_cnt_lo;
+	__le32 tx_msdu_cnt_hi;
+	__le32 tx_retry_cnt_lo;
+	__le32 tx_retry_cnt_hi;
+	__le32 tx_retry_byte_cnt_lo;
+	__le32 tx_retry_byte_cnt_hi;
+	__le32 tx_drop_cnt_lo;
+	__le32 tx_drop_cnt_hi;
+	__le32 tx_drop_byte_cnt_lo;
+	__le32 tx_drop_byte_cnt_hi;
+	__le32 msdu_ttl_cnt_lo;
+	__le32 msdu_ttl_cnt_hi;
+	__le32 msdu_ttl_byte_cnt_lo;
+	__le32 msdu_ttl_byte_cnt_hi;
+} __packed;
+
+struct htt_t2h_vdev_common_stats_tlv {
+	__le32 soc_drop_count_lo;
+	__le32 soc_drop_count_hi;
+} __packed;
+
+/* ppdu stats
+ *
+ * @details
+ * The following field definitions describe the format of the HTT target
+ * to host ppdu stats indication message.
+ *
+ *
+ * |31                         16|15   12|11   10|9      8|7            0 |
+ * |----------------------------------------------------------------------|
+ * |    payload_size             | rsvd  |pdev_id|mac_id  |    msg type   |
+ * |----------------------------------------------------------------------|
+ * |                          ppdu_id                                     |
+ * |----------------------------------------------------------------------|
+ * |                        Timestamp in us                               |
+ * |----------------------------------------------------------------------|
+ * |                          reserved                                    |
+ * |----------------------------------------------------------------------|
+ * |                    type-specific stats info                          |
+ * |                     (see htt_ppdu_stats.h)                           |
+ * |----------------------------------------------------------------------|
+ * Header fields:
+ *  - MSG_TYPE
+ *    Bits 7:0
+ *    Purpose: Identifies this is a PPDU STATS indication
+ *             message.
+ *    Value: 0x1d
+ *  - mac_id
+ *    Bits 9:8
+ *    Purpose: mac_id of this ppdu_id
+ *    Value: 0-3
+ *  - pdev_id
+ *    Bits 11:10
+ *    Purpose: pdev_id of this ppdu_id
+ *    Value: 0-3
+ *     0 (for rings at SOC level),
+ *     1/2/3 PDEV -> 0/1/2
+ *  - payload_size
+ *    Bits 31:16
+ *    Purpose: total tlv size
+ *    Value: payload_size in bytes
+ */
+
+#define HTT_T2H_PPDU_STATS_INFO_PDEV_ID GENMASK(11, 10)
+#define HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE GENMASK(31, 16)
+
+struct ath12k_htt_ppdu_stats_msg {
+	__le32 info;
+	__le32 ppdu_id;
+	__le32 timestamp;
+	__le32 rsvd;
+	u8 data[];
+} __packed;
+
+struct htt_tlv {
+	__le32 header;
+	u8 value[];
+} __packed;
+
+#define HTT_TLV_TAG			GENMASK(11, 0)
+#define HTT_TLV_LEN			GENMASK(23, 12)
+
+enum HTT_PPDU_STATS_BW {
+	HTT_PPDU_STATS_BANDWIDTH_5MHZ   = 0,
+	HTT_PPDU_STATS_BANDWIDTH_10MHZ  = 1,
+	HTT_PPDU_STATS_BANDWIDTH_20MHZ  = 2,
+	HTT_PPDU_STATS_BANDWIDTH_40MHZ  = 3,
+	HTT_PPDU_STATS_BANDWIDTH_80MHZ  = 4,
+	HTT_PPDU_STATS_BANDWIDTH_160MHZ = 5, /* includes 80+80 */
+	HTT_PPDU_STATS_BANDWIDTH_DYN    = 6,
+};
+
+#define HTT_PPDU_STATS_CMN_FLAGS_FRAME_TYPE_M	GENMASK(7, 0)
+#define HTT_PPDU_STATS_CMN_FLAGS_QUEUE_TYPE_M	GENMASK(15, 8)
+/* bw - HTT_PPDU_STATS_BW */
+#define HTT_PPDU_STATS_CMN_FLAGS_BW_M		GENMASK(19, 16)
+
+struct htt_ppdu_stats_common {
+	__le32 ppdu_id;
+	__le16 sched_cmdid;
+	u8 ring_id;
+	u8 num_users;
+	__le32 flags; /* %HTT_PPDU_STATS_COMMON_FLAGS_*/
+	__le32 chain_mask;
+	__le32 fes_duration_us; /* frame exchange sequence */
+	__le32 ppdu_sch_eval_start_tstmp_us;
+	__le32 ppdu_sch_end_tstmp_us;
+	__le32 ppdu_start_tstmp_us;
+	/* BIT [15 :  0] - phy mode (WLAN_PHY_MODE) with which ppdu was transmitted
+	 * BIT [31 : 16] - bandwidth (in MHz) with which ppdu was transmitted
+	 */
+	__le16 phy_mode;
+	__le16 bw_mhz;
+} __packed;
+
+enum htt_ppdu_stats_gi {
+	HTT_PPDU_STATS_SGI_0_8_US,
+	HTT_PPDU_STATS_SGI_0_4_US,
+	HTT_PPDU_STATS_SGI_1_6_US,
+	HTT_PPDU_STATS_SGI_3_2_US,
+};
+
+#define HTT_PPDU_STATS_USER_RATE_INFO0_USER_POS_M	GENMASK(3, 0)
+#define HTT_PPDU_STATS_USER_RATE_INFO0_MU_GROUP_ID_M	GENMASK(11, 4)
+
+enum HTT_PPDU_STATS_PPDU_TYPE {
+	HTT_PPDU_STATS_PPDU_TYPE_SU,
+	HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO,
+	HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA,
+	HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA,
+	HTT_PPDU_STATS_PPDU_TYPE_UL_TRIG,
+	HTT_PPDU_STATS_PPDU_TYPE_BURST_BCN,
+	HTT_PPDU_STATS_PPDU_TYPE_UL_BSR_RESP,
+	HTT_PPDU_STATS_PPDU_TYPE_UL_BSR_TRIG,
+	HTT_PPDU_STATS_PPDU_TYPE_UL_RESP,
+	HTT_PPDU_STATS_PPDU_TYPE_MAX
+};
+
+#define HTT_PPDU_STATS_USER_RATE_INFO1_RESP_TYPE_VALD_M	BIT(0)
+#define HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M	GENMASK(5, 1)
+
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_LTF_SIZE_M	GENMASK(1, 0)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_STBC_M		BIT(2)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_HE_RE_M		BIT(3)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_TXBF_M		GENMASK(7, 4)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_BW_M		GENMASK(11, 8)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_NSS_M		GENMASK(15, 12)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_MCS_M		GENMASK(19, 16)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M	GENMASK(23, 20)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_GI_M		GENMASK(27, 24)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M		BIT(28)
+#define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M		BIT(29)
+
+#define HTT_USR_RATE_PPDU_TYPE(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M)
+#define HTT_USR_RATE_PREAMBLE(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M)
+#define HTT_USR_RATE_BW(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_BW_M)
+#define HTT_USR_RATE_NSS(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_NSS_M)
+#define HTT_USR_RATE_MCS(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_MCS_M)
+#define HTT_USR_RATE_GI(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_GI_M)
+#define HTT_USR_RATE_DCM(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M)
+
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_LTF_SIZE_M		GENMASK(1, 0)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_STBC_M		BIT(2)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_HE_RE_M		BIT(3)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_TXBF_M		GENMASK(7, 4)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_BW_M		GENMASK(11, 8)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_NSS_M		GENMASK(15, 12)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_MCS_M		GENMASK(19, 16)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_PREAMBLE_M		GENMASK(23, 20)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_GI_M		GENMASK(27, 24)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_DCM_M		BIT(28)
+#define HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_LDPC_M		BIT(29)
+
+struct htt_ppdu_stats_user_rate {
+	u8 tid_num;
+	u8 reserved0;
+	__le16 sw_peer_id;
+	__le32 info0; /* %HTT_PPDU_STATS_USER_RATE_INFO0_*/
+	__le16 ru_end;
+	__le16 ru_start;
+	__le16 resp_ru_end;
+	__le16 resp_ru_start;
+	__le32 info1; /* %HTT_PPDU_STATS_USER_RATE_INFO1_ */
+	__le32 rate_flags; /* %HTT_PPDU_STATS_USER_RATE_FLAGS_ */
+	/* Note: resp_rate_info is only valid for if resp_type is UL */
+	__le32 resp_rate_flags; /* %HTT_PPDU_STATS_USER_RATE_RESP_FLAGS_ */
+} __packed;
+
+#define HTT_PPDU_STATS_TX_INFO_FLAGS_RATECODE_M		GENMASK(7, 0)
+#define HTT_PPDU_STATS_TX_INFO_FLAGS_IS_AMPDU_M		BIT(8)
+#define HTT_PPDU_STATS_TX_INFO_FLAGS_BA_ACK_FAILED_M	GENMASK(10, 9)
+#define HTT_PPDU_STATS_TX_INFO_FLAGS_BW_M		GENMASK(13, 11)
+#define HTT_PPDU_STATS_TX_INFO_FLAGS_SGI_M		BIT(14)
+#define HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M		GENMASK(31, 16)
+
+#define HTT_TX_INFO_IS_AMSDU(_flags) \
+			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_IS_AMPDU_M)
+#define HTT_TX_INFO_BA_ACK_FAILED(_flags) \
+			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_BA_ACK_FAILED_M)
+#define HTT_TX_INFO_RATECODE(_flags) \
+			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_RATECODE_M)
+#define HTT_TX_INFO_PEERID(_flags) \
+			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M)
+
+enum  htt_ppdu_stats_usr_compln_status {
+	HTT_PPDU_STATS_USER_STATUS_OK,
+	HTT_PPDU_STATS_USER_STATUS_FILTERED,
+	HTT_PPDU_STATS_USER_STATUS_RESP_TIMEOUT,
+	HTT_PPDU_STATS_USER_STATUS_RESP_MISMATCH,
+	HTT_PPDU_STATS_USER_STATUS_ABORT,
+};
+
+#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_LONG_RETRY_M	GENMASK(3, 0)
+#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_SHORT_RETRY_M	GENMASK(7, 4)
+#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_IS_AMPDU_M		BIT(8)
+#define HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_RESP_TYPE_M		GENMASK(12, 9)
+
+#define HTT_USR_CMPLTN_IS_AMPDU(_val) \
+	    le32_get_bits(_val, HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_IS_AMPDU_M)
+#define HTT_USR_CMPLTN_LONG_RETRY(_val) \
+	    le32_get_bits(_val, HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_LONG_RETRY_M)
+#define HTT_USR_CMPLTN_SHORT_RETRY(_val) \
+	    le32_get_bits(_val, HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_SHORT_RETRY_M)
+
+struct htt_ppdu_stats_usr_cmpltn_cmn {
+	u8 status;
+	u8 tid_num;
+	__le16 sw_peer_id;
+	/* RSSI value of last ack packet (units = dB above noise floor) */
+	__le32 ack_rssi;
+	__le16 mpdu_tried;
+	__le16 mpdu_success;
+	__le32 flags; /* %HTT_PPDU_STATS_USR_CMPLTN_CMN_FLAGS_LONG_RETRIES*/
+} __packed;
+
+#define HTT_PPDU_STATS_ACK_BA_INFO_NUM_MPDU_M	GENMASK(8, 0)
+#define HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M	GENMASK(24, 9)
+#define HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM	GENMASK(31, 25)
+
+#define HTT_PPDU_STATS_NON_QOS_TID	16
+
+struct htt_ppdu_stats_usr_cmpltn_ack_ba_status {
+	__le32 ppdu_id;
+	__le16 sw_peer_id;
+	__le16 reserved0;
+	__le32 info; /* %HTT_PPDU_STATS_USR_CMPLTN_CMN_INFO_ */
+	__le16 current_seq;
+	__le16 start_seq;
+	__le32 success_bytes;
+} __packed;
+
+struct htt_ppdu_user_stats {
+	u16 peer_id;
+	u16 delay_ba;
+	u32 tlv_flags;
+	bool is_valid_peer_id;
+	struct htt_ppdu_stats_user_rate rate;
+	struct htt_ppdu_stats_usr_cmpltn_cmn cmpltn_cmn;
+	struct htt_ppdu_stats_usr_cmpltn_ack_ba_status ack_ba;
+};
+
+#define HTT_PPDU_STATS_MAX_USERS	8
+#define HTT_PPDU_DESC_MAX_DEPTH	16
+
+struct htt_ppdu_stats {
+	struct htt_ppdu_stats_common common;
+	struct htt_ppdu_user_stats user_stats[HTT_PPDU_STATS_MAX_USERS];
+};
+
+struct htt_ppdu_stats_info {
+	u32 tlv_bitmap;
+	u32 ppdu_id;
+	u32 frame_type;
+	u32 frame_ctrl;
+	u32 delay_ba;
+	u32 bar_num_users;
+	struct htt_ppdu_stats ppdu_stats;
+	struct list_head list;
+};
+
+/* @brief target -> host MLO offset indiciation message
+ *
+ * @details
+ * The following field definitions describe the format of the HTT target
+ * to host mlo offset indication message.
+ *
+ *
+ * |31        29|28    |26|25  22|21 16|15  13|12     10 |9     8|7     0|
+ * |---------------------------------------------------------------------|
+ * |   rsvd1    | mac_freq                    |chip_id   |pdev_id|msgtype|
+ * |---------------------------------------------------------------------|
+ * |                           sync_timestamp_lo_us                      |
+ * |---------------------------------------------------------------------|
+ * |                           sync_timestamp_hi_us                      |
+ * |---------------------------------------------------------------------|
+ * |                           mlo_offset_lo                             |
+ * |---------------------------------------------------------------------|
+ * |                           mlo_offset_hi                             |
+ * |---------------------------------------------------------------------|
+ * |                           mlo_offset_clcks                          |
+ * |---------------------------------------------------------------------|
+ * |   rsvd2           | mlo_comp_clks |mlo_comp_us                      |
+ * |---------------------------------------------------------------------|
+ * |   rsvd3                   |mlo_comp_timer                           |
+ * |---------------------------------------------------------------------|
+ * Header fields
+ *  - MSG_TYPE
+ *    Bits 7:0
+ *    Purpose: Identifies this is a MLO offset indication msg
+ *  - PDEV_ID
+ *    Bits 9:8
+ *    Purpose: Pdev of this MLO offset
+ *  - CHIP_ID
+ *    Bits 12:10
+ *    Purpose: chip_id of this MLO offset
+ *  - MAC_FREQ
+ *    Bits 28:13
+ *  - SYNC_TIMESTAMP_LO_US
+ *    Purpose: clock frequency of the mac HW block in MHz
+ *    Bits: 31:0
+ *    Purpose: lower 32 bits of the WLAN global time stamp at which
+ *             last sync interrupt was received
+ *  - SYNC_TIMESTAMP_HI_US
+ *    Bits: 31:0
+ *    Purpose: upper 32 bits of WLAN global time stamp at which
+ *             last sync interrupt was received
+ *  - MLO_OFFSET_LO
+ *    Bits: 31:0
+ *    Purpose: lower 32 bits of the MLO offset in us
+ *  - MLO_OFFSET_HI
+ *    Bits: 31:0
+ *    Purpose: upper 32 bits of the MLO offset in us
+ *  - MLO_COMP_US
+ *    Bits: 15:0
+ *    Purpose: MLO time stamp compensation applied in us
+ *  - MLO_COMP_CLCKS
+ *    Bits: 25:16
+ *    Purpose: MLO time stamp compensation applied in clock ticks
+ *  - MLO_COMP_TIMER
+ *    Bits: 21:0
+ *    Purpose: Periodic timer at which compensation is applied
+ */
+
+#define HTT_T2H_MLO_OFFSET_INFO_MSG_TYPE        GENMASK(7, 0)
+#define HTT_T2H_MLO_OFFSET_INFO_PDEV_ID         GENMASK(9, 8)
+
+struct ath12k_htt_mlo_offset_msg {
+	__le32 info;
+	__le32 sync_timestamp_lo_us;
+	__le32 sync_timestamp_hi_us;
+	__le32 mlo_offset_hi;
+	__le32 mlo_offset_lo;
+	__le32 mlo_offset_clks;
+	__le32 mlo_comp_clks;
+	__le32 mlo_comp_timer;
+} __packed;
+
+/* @brief host -> target FW extended statistics retrieve
+ *
+ * @details
+ * The following field definitions describe the format of the HTT host
+ * to target FW extended stats retrieve message.
+ * The message specifies the type of stats the host wants to retrieve.
+ *
+ * |31          24|23          16|15           8|7            0|
+ * |-----------------------------------------------------------|
+ * |   reserved   | stats type   |   pdev_mask  |   msg type   |
+ * |-----------------------------------------------------------|
+ * |                   config param [0]                        |
+ * |-----------------------------------------------------------|
+ * |                   config param [1]                        |
+ * |-----------------------------------------------------------|
+ * |                   config param [2]                        |
+ * |-----------------------------------------------------------|
+ * |                   config param [3]                        |
+ * |-----------------------------------------------------------|
+ * |                         reserved                          |
+ * |-----------------------------------------------------------|
+ * |                        cookie LSBs                        |
+ * |-----------------------------------------------------------|
+ * |                        cookie MSBs                        |
+ * |-----------------------------------------------------------|
+ * Header fields:
+ *  - MSG_TYPE
+ *    Bits 7:0
+ *    Purpose: identifies this is a extended stats upload request message
+ *    Value: 0x10
+ *  - PDEV_MASK
+ *    Bits 8:15
+ *    Purpose: identifies the mask of PDEVs to retrieve stats from
+ *    Value: This is a overloaded field, refer to usage and interpretation of
+ *           PDEV in interface document.
+ *           Bit   8    :  Reserved for SOC stats
+ *           Bit 9 - 15 :  Indicates PDEV_MASK in DBDC
+ *                         Indicates MACID_MASK in DBS
+ *  - STATS_TYPE
+ *    Bits 23:16
+ *    Purpose: identifies which FW statistics to upload
+ *    Value: Defined by htt_dbg_ext_stats_type (see htt_stats.h)
+ *  - Reserved
+ *    Bits 31:24
+ *  - CONFIG_PARAM [0]
+ *    Bits 31:0
+ *    Purpose: give an opaque configuration value to the specified stats type
+ *    Value: stats-type specific configuration value
+ *           Refer to htt_stats.h for interpretation for each stats sub_type
+ *  - CONFIG_PARAM [1]
+ *    Bits 31:0
+ *    Purpose: give an opaque configuration value to the specified stats type
+ *    Value: stats-type specific configuration value
+ *           Refer to htt_stats.h for interpretation for each stats sub_type
+ *  - CONFIG_PARAM [2]
+ *    Bits 31:0
+ *    Purpose: give an opaque configuration value to the specified stats type
+ *    Value: stats-type specific configuration value
+ *           Refer to htt_stats.h for interpretation for each stats sub_type
+ *  - CONFIG_PARAM [3]
+ *    Bits 31:0
+ *    Purpose: give an opaque configuration value to the specified stats type
+ *    Value: stats-type specific configuration value
+ *           Refer to htt_stats.h for interpretation for each stats sub_type
+ *  - Reserved [31:0] for future use.
+ *  - COOKIE_LSBS
+ *    Bits 31:0
+ *    Purpose: Provide a mechanism to match a target->host stats confirmation
+ *        message with its preceding host->target stats request message.
+ *    Value: LSBs of the opaque cookie specified by the host-side requestor
+ *  - COOKIE_MSBS
+ *    Bits 31:0
+ *    Purpose: Provide a mechanism to match a target->host stats confirmation
+ *        message with its preceding host->target stats request message.
+ *    Value: MSBs of the opaque cookie specified by the host-side requestor
+ */
+
+struct htt_ext_stats_cfg_hdr {
+	u8 msg_type;
+	u8 pdev_mask;
+	u8 stats_type;
+	u8 reserved;
+} __packed;
+
+struct htt_ext_stats_cfg_cmd {
+	struct htt_ext_stats_cfg_hdr hdr;
+	__le32 cfg_param0;
+	__le32 cfg_param1;
+	__le32 cfg_param2;
+	__le32 cfg_param3;
+	__le32 reserved;
+	__le32 cookie_lsb;
+	__le32 cookie_msb;
+} __packed;
+
+/* htt stats config default params */
+#define HTT_STAT_DEFAULT_RESET_START_OFFSET 0
+#define HTT_STAT_DEFAULT_CFG0_ALL_HWQS 0xffffffff
+#define HTT_STAT_DEFAULT_CFG0_ALL_TXQS 0xffffffff
+#define HTT_STAT_DEFAULT_CFG0_ALL_CMDQS 0xffff
+#define HTT_STAT_DEFAULT_CFG0_ALL_RINGS 0xffff
+#define HTT_STAT_DEFAULT_CFG0_ACTIVE_PEERS 0xff
+#define HTT_STAT_DEFAULT_CFG0_CCA_CUMULATIVE 0x00
+#define HTT_STAT_DEFAULT_CFG0_ACTIVE_VDEVS 0x00
+
+/* HTT_DBG_EXT_STATS_PEER_INFO
+ * PARAMS:
+ * @config_param0:
+ *  [Bit0] - [0] for sw_peer_id, [1] for mac_addr based request
+ *  [Bit15 : Bit 1] htt_peer_stats_req_mode_t
+ *  [Bit31 : Bit16] sw_peer_id
+ * @config_param1:
+ *  peer_stats_req_type_mask:32 (enum htt_peer_stats_tlv_enum)
+ *   0 bit htt_peer_stats_cmn_tlv
+ *   1 bit htt_peer_details_tlv
+ *   2 bit htt_tx_peer_rate_stats_tlv
+ *   3 bit htt_rx_peer_rate_stats_tlv
+ *   4 bit htt_tx_tid_stats_tlv/htt_tx_tid_stats_v1_tlv
+ *   5 bit htt_rx_tid_stats_tlv
+ *   6 bit htt_msdu_flow_stats_tlv
+ * @config_param2: [Bit31 : Bit0] mac_addr31to0
+ * @config_param3: [Bit15 : Bit0] mac_addr47to32
+ *                [Bit31 : Bit16] reserved
+ */
+#define HTT_STAT_PEER_INFO_MAC_ADDR BIT(0)
+#define HTT_STAT_DEFAULT_PEER_REQ_TYPE 0x7f
+
+/* Used to set different configs to the specified stats type.*/
+struct htt_ext_stats_cfg_params {
+	u32 cfg0;
+	u32 cfg1;
+	u32 cfg2;
+	u32 cfg3;
+};
+
+enum vdev_stats_offload_timer_duration {
+	ATH12K_STATS_TIMER_DUR_500MS = 1,
+	ATH12K_STATS_TIMER_DUR_1SEC = 2,
+	ATH12K_STATS_TIMER_DUR_2SEC = 3,
+};
+
+#define ATH12K_HTT_MAC_ADDR_L32_0	GENMASK(7, 0)
+#define ATH12K_HTT_MAC_ADDR_L32_1	GENMASK(15, 8)
+#define ATH12K_HTT_MAC_ADDR_L32_2	GENMASK(23, 16)
+#define ATH12K_HTT_MAC_ADDR_L32_3	GENMASK(31, 24)
+#define ATH12K_HTT_MAC_ADDR_H16_0	GENMASK(7, 0)
+#define ATH12K_HTT_MAC_ADDR_H16_1	GENMASK(15, 8)
+
+struct htt_mac_addr {
+	__le32 mac_addr_l32;
+	__le32 mac_addr_h16;
+} __packed;
+
+#endif
-- 
2.34.1


