Return-Path: <linux-wireless+bounces-26817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21DB3A841
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820967C8328
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0533CEBA;
	Thu, 28 Aug 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dXU8dM7p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB633CEA9
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402585; cv=none; b=q73WweAK7hxIvY6w98TcdcippYMCXEhtzAWLWBMNHgWrj2VoEjXpdyHBgc2lTPCeWv9xk9Z1/GajHEduTYxDe5gfSmMwtp2li9niAmPLWmZilDTxEXoKhdVCojw31uVcdO8hAJ1MlUuNWathuQ7LefeI1cQ8Fsxun/1dzxfeR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402585; c=relaxed/simple;
	bh=HHZpb44xb7ADqWpPEuS+epOW6xgRS8LVMVxw+jvR93E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVWbxOb/WhzOy0Abtn5o/d7fvj0MsDCwsqAEZFqPCEOFz7t+prBgW9MVmD5Q7t/k7nbKToupVbevI4UynfP2QSOFGyCtB/d+XKtLb39HFKLAxlXRcBAA2xO0pxv6Rw31oJgq0RcvOZc8NgPdcPktGIZrpUtZ2LFP9AN6UYqn4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dXU8dM7p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAsA0J005504;
	Thu, 28 Aug 2025 17:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lQ1vpm0x0Ifb/6G/tn/pDuPHfhOobN/JqmIkVilaiVE=; b=dXU8dM7p1Ma5TPKQ
	U/5LMdc3eFsU96O3mf5M4vUrnpglus2rIHi8zj5NasPavvCa3Apd2kGfmjP7MNWr
	Q+syOCkP2o7sDgiLNWV31zv1X9ZDH4fIa/E5IZo6v+OnBcDuvvw0TedVzQ6dCPHA
	eThegKw10Z71NrUcVaQe2MrCexrcuVqnoXjbeg2dILLeJ7P9xq5+s9dTOL99QLzw
	sSnloaNUi/iRqEQtniI0k7/nEMIyeHbV3826zsjOgebP2ifkCNIyMo625N9WxyS3
	+RB0TeBx9TVijoCsTW9Qz7tEd0DYrIZh7E3RRR2OAMhvcP+VAw+Sae7C8pj/rXlo
	+zqbIA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up1028-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaERi003533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:14 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:13 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 03/20] wifi: ath12k: Move hal_rx.h file to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:36 +0530
Message-ID: <20250828173553.3341351-4-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: Exdz2JEEN1JrRfJhyl-xQ1DLbVZ_WBQ3
X-Proofpoint-ORIG-GUID: Exdz2JEEN1JrRfJhyl-xQ1DLbVZ_WBQ3
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b0938f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Wle9IplyhgK_uykXmkMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXz5Zq6FA5Od56
 a2trJO21uXQ3av0qDkvq2FyFzTH7ZQUlaADEV3xDLgQa+Jqq+Dj+3Srg7akzytzXTAMmnjfn1iE
 izyvs8/gPdpFWY763VMjCwgxUS4wj8A0nuRUrh/DMgZSPd8B5W7EBn79QUUeJa941vvGrcb4Ie9
 Qk4ImmKZTXF3e9X0k6tkjVWdM/mJTyDxToaGp/+YremVUOiag4PTtk3Ytz0kREf6d6y0dw0c91D
 gnJ7iK7Ydzv+e0poQ8LlcCugfKYI+SxR68G4eIjhjV5e11RTQmRf0ujO4b4WMBdC+zSXEriFzgI
 uECA9MV5WIkt0KPn4t0r97EjIVL+9ysP079lhMPYIi4MKcH1vXbCKTzsJBLNlyPpwXNzz8Xr4Ju
 HQv52lyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move wifi7 architecture specific file hal_rx.h to wifi7 directory, and move
the common part from it to hal.h file which is in the common directory.

It is as part of a broader effort to separate common and hardware-specific
code into distinct modules. This modularization enables reuse of the common
driver components across multiple hardware architectures.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |   4 +-
 drivers/net/wireless/ath/ath12k/dp.h          |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |   4 +-
 drivers/net/wireless/ath/ath12k/hal.c         |   2 +-
 drivers/net/wireless/ath/ath12k/hal.h         | 295 +++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   2 +-
 .../wireless/ath/ath12k/{ => wifi7}/hal_rx.h  | 299 +-----------------
 7 files changed, 304 insertions(+), 306 deletions(-)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h (83%)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3c4a8f834b70..b68f063283fe 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_CORE_H
@@ -26,7 +26,7 @@
 #include "ce.h"
 #include "mac.h"
 #include "hw.h"
-#include "hal_rx.h"
+#include "wifi7/hal_rx.h"
 #include "reg.h"
 #include "dbring.h"
 #include "fw.h"
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7baa48b86f7a..faab444744b3 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1,14 +1,14 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_DP_H
 #define ATH12K_DP_H
 
 #include "hal_desc.h"
-#include "hal_rx.h"
+#include "wifi7/hal_rx.h"
 #include "hw.h"
 
 #define MAX_RXDMA_PER_PDEV     2
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1b1ac82871f4..4f6b71a18dc4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/ieee80211.h>
@@ -13,7 +13,7 @@
 #include "hal_desc.h"
 #include "hw.h"
 #include "dp_rx.h"
-#include "hal_rx.h"
+#include "wifi7/hal_rx.h"
 #include "dp_tx.h"
 #include "peer.h"
 #include "dp_mon.h"
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index dbbdb6f3f8cf..f9ce60d22cc1 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -5,7 +5,7 @@
  */
 #include <linux/dma-mapping.h>
 #include "wifi7/hal_tx.h"
-#include "hal_rx.h"
+#include "wifi7/hal_rx.h"
 #include "debug.h"
 #include "hal_desc.h"
 #include "hif.h"
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index b3aa13ad5196..d02d27f28cc1 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -12,12 +12,22 @@
 
 struct ath12k_base;
 
+#define HAL_INVALID_PEERID	0x3fff
+#define VHT_SIG_SU_NSS_MASK	0x7
+
 #define HAL_TX_ADDRX_EN			1
 #define HAL_TX_ADDRY_EN			2
 
 #define HAL_TX_ADDR_SEARCH_DEFAULT	0
 #define HAL_TX_ADDR_SEARCH_INDEX	1
 
+#define HAL_RX_MAX_MPDU		256
+#define HAL_RX_NUM_WORDS_PER_PPDU_BITMAP	(HAL_RX_MAX_MPDU >> 5)
+
+#define EHT_MAX_USER_INFO	4
+#define HAL_RX_MON_MAX_AGGR_SIZE	128
+#define HAL_MAX_UL_MU_USERS	37
+
 #define HAL_CE_REMAP_REG_BASE	(ab->ce_remap_base_addr)
 
 #define HAL_LINK_DESC_SIZE			(32 << 2)
@@ -532,6 +542,64 @@ enum hal_srng_ring_id {
 #define HAL_SRNG_RING_ID_MAX    (HAL_SRNG_RING_ID_DMAC_CMN_ID_END + \
 				 HAL_SRNG_NUM_PMAC_RINGS)
 
+enum hal_rx_su_mu_coding {
+	HAL_RX_SU_MU_CODING_BCC,
+	HAL_RX_SU_MU_CODING_LDPC,
+	HAL_RX_SU_MU_CODING_MAX,
+};
+
+enum hal_rx_gi {
+	HAL_RX_GI_0_8_US,
+	HAL_RX_GI_0_4_US,
+	HAL_RX_GI_1_6_US,
+	HAL_RX_GI_3_2_US,
+	HAL_RX_GI_MAX,
+};
+
+enum hal_rx_bw {
+	HAL_RX_BW_20MHZ,
+	HAL_RX_BW_40MHZ,
+	HAL_RX_BW_80MHZ,
+	HAL_RX_BW_160MHZ,
+	HAL_RX_BW_320MHZ,
+	HAL_RX_BW_MAX,
+};
+
+enum hal_rx_preamble {
+	HAL_RX_PREAMBLE_11A,
+	HAL_RX_PREAMBLE_11B,
+	HAL_RX_PREAMBLE_11N,
+	HAL_RX_PREAMBLE_11AC,
+	HAL_RX_PREAMBLE_11AX,
+	HAL_RX_PREAMBLE_11BA,
+	HAL_RX_PREAMBLE_11BE,
+	HAL_RX_PREAMBLE_MAX,
+};
+
+enum hal_rx_reception_type {
+	HAL_RX_RECEPTION_TYPE_SU,
+	HAL_RX_RECEPTION_TYPE_MU_MIMO,
+	HAL_RX_RECEPTION_TYPE_MU_OFDMA,
+	HAL_RX_RECEPTION_TYPE_MU_OFDMA_MIMO,
+	HAL_RX_RECEPTION_TYPE_MAX,
+};
+
+enum hal_rx_legacy_rate {
+	HAL_RX_LEGACY_RATE_1_MBPS,
+	HAL_RX_LEGACY_RATE_2_MBPS,
+	HAL_RX_LEGACY_RATE_5_5_MBPS,
+	HAL_RX_LEGACY_RATE_6_MBPS,
+	HAL_RX_LEGACY_RATE_9_MBPS,
+	HAL_RX_LEGACY_RATE_11_MBPS,
+	HAL_RX_LEGACY_RATE_12_MBPS,
+	HAL_RX_LEGACY_RATE_18_MBPS,
+	HAL_RX_LEGACY_RATE_24_MBPS,
+	HAL_RX_LEGACY_RATE_36_MBPS,
+	HAL_RX_LEGACY_RATE_48_MBPS,
+	HAL_RX_LEGACY_RATE_54_MBPS,
+	HAL_RX_LEGACY_RATE_INVALID,
+};
+
 enum hal_ring_type {
 	HAL_REO_DST,
 	HAL_REO_EXCEPTION,
@@ -632,6 +700,158 @@ enum hal_srng_dir {
 	HAL_SRNG_DIR_DST
 };
 
+struct hal_rx_user_status {
+	u32 mcs:4,
+	nss:3,
+	ofdma_info_valid:1,
+	ul_ofdma_ru_start_index:7,
+	ul_ofdma_ru_width:7,
+	ul_ofdma_ru_size:8;
+	u32 ul_ofdma_user_v0_word0;
+	u32 ul_ofdma_user_v0_word1;
+	u32 ast_index;
+	u32 tid;
+	u16 tcp_msdu_count;
+	u16 tcp_ack_msdu_count;
+	u16 udp_msdu_count;
+	u16 other_msdu_count;
+	u16 frame_control;
+	u8 frame_control_info_valid;
+	u8 data_sequence_control_info_valid;
+	u16 first_data_seq_ctrl;
+	u32 preamble_type;
+	u16 ht_flags;
+	u16 vht_flags;
+	u16 he_flags;
+	u8 rs_flags;
+	u8 ldpc;
+	u32 mpdu_cnt_fcs_ok;
+	u32 mpdu_cnt_fcs_err;
+	u32 mpdu_fcs_ok_bitmap[HAL_RX_NUM_WORDS_PER_PPDU_BITMAP];
+	u32 mpdu_ok_byte_count;
+	u32 mpdu_err_byte_count;
+	bool ampdu_present;
+	u16 ampdu_id;
+};
+
+struct hal_rx_u_sig_info {
+	bool ul_dl;
+	u8 bw;
+	u8 ppdu_type_comp_mode;
+	u8 eht_sig_mcs;
+	u8 num_eht_sig_sym;
+	struct ieee80211_radiotap_eht_usig usig;
+};
+
+struct hal_rx_tlv_aggr_info {
+	bool in_progress;
+	u16 cur_len;
+	u16 tlv_tag;
+	u8 buf[HAL_RX_MON_MAX_AGGR_SIZE];
+};
+
+struct hal_rx_radiotap_eht {
+	__le32 known;
+	__le32 data[9];
+};
+
+struct hal_rx_eht_info {
+	u8 num_user_info;
+	struct hal_rx_radiotap_eht eht;
+	u32 user_info[EHT_MAX_USER_INFO];
+};
+
+struct hal_rx_mon_ppdu_info {
+	u32 ppdu_id;
+	u32 last_ppdu_id;
+	u64 ppdu_ts;
+	u32 num_mpdu_fcs_ok;
+	u32 num_mpdu_fcs_err;
+	u32 preamble_type;
+	u32 mpdu_len;
+	u16 chan_num;
+	u16 freq;
+	u16 tcp_msdu_count;
+	u16 tcp_ack_msdu_count;
+	u16 udp_msdu_count;
+	u16 other_msdu_count;
+	u16 peer_id;
+	u8 rate;
+	u8 mcs;
+	u8 nss;
+	u8 bw;
+	u8 vht_flag_values1;
+	u8 vht_flag_values2;
+	u8 vht_flag_values3[4];
+	u8 vht_flag_values4;
+	u8 vht_flag_values5;
+	u16 vht_flag_values6;
+	u8 is_stbc;
+	u8 gi;
+	u8 sgi;
+	u8 ldpc;
+	u8 beamformed;
+	u8 rssi_comb;
+	u16 tid;
+	u8 fc_valid;
+	u16 ht_flags;
+	u16 vht_flags;
+	u16 he_flags;
+	u16 he_mu_flags;
+	u8 dcm;
+	u8 ru_alloc;
+	u8 reception_type;
+	u64 tsft;
+	u64 rx_duration;
+	u16 frame_control;
+	u32 ast_index;
+	u8 rs_fcs_err;
+	u8 rs_flags;
+	u8 cck_flag;
+	u8 ofdm_flag;
+	u8 ulofdma_flag;
+	u8 frame_control_info_valid;
+	u16 he_per_user_1;
+	u16 he_per_user_2;
+	u8 he_per_user_position;
+	u8 he_per_user_known;
+	u16 he_flags1;
+	u16 he_flags2;
+	u8 he_RU[4];
+	u16 he_data1;
+	u16 he_data2;
+	u16 he_data3;
+	u16 he_data4;
+	u16 he_data5;
+	u16 he_data6;
+	u32 ppdu_len;
+	u32 prev_ppdu_id;
+	u32 device_id;
+	u16 first_data_seq_ctrl;
+	u8 monitor_direct_used;
+	u8 data_sequence_control_info_valid;
+	u8 ltf_size;
+	u8 rxpcu_filter_pass;
+	s8 rssi_chain[8][8];
+	u32 num_users;
+	u32 mpdu_fcs_ok_bitmap[HAL_RX_NUM_WORDS_PER_PPDU_BITMAP];
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	u8 addr4[ETH_ALEN];
+	struct hal_rx_user_status userstats[HAL_MAX_UL_MU_USERS];
+	u8 userid;
+	bool first_msdu_in_mpdu;
+	bool is_ampdu;
+	u8 medium_prot_type;
+	bool ppdu_continuation;
+	bool eht_usig;
+	struct hal_rx_u_sig_info u_sig_info;
+	bool is_eht;
+	struct hal_rx_eht_info eht_info;
+	struct hal_rx_tlv_aggr_info tlv_aggr;
+};
+
 /* srng flags */
 #define HAL_SRNG_FLAGS_MSI_SWAP			0x00000008
 #define HAL_SRNG_FLAGS_RING_PTR_SWAP		0x00000010
@@ -1060,6 +1280,81 @@ struct ath12k_hal_tcl_to_wbm_rbm_map  {
 	u8 rbm_id;
 };
 
+#define RU_INVALID		0
+#define RU_26			1
+#define RU_52			2
+#define RU_106			4
+#define RU_242			9
+#define RU_484			18
+#define RU_996			37
+#define RU_2X996		74
+#define RU_3X996		111
+#define RU_4X996		148
+#define RU_52_26		(RU_52 + RU_26)
+#define RU_106_26		(RU_106 + RU_26)
+#define RU_484_242		(RU_484 + RU_242)
+#define RU_996_484		(RU_996 + RU_484)
+#define RU_996_484_242		(RU_996 + RU_484_242)
+#define RU_2X996_484		(RU_2X996 + RU_484)
+#define RU_3X996_484		(RU_3X996 + RU_484)
+
+enum ath12k_eht_ru_size {
+	ATH12K_EHT_RU_26,
+	ATH12K_EHT_RU_52,
+	ATH12K_EHT_RU_106,
+	ATH12K_EHT_RU_242,
+	ATH12K_EHT_RU_484,
+	ATH12K_EHT_RU_996,
+	ATH12K_EHT_RU_996x2,
+	ATH12K_EHT_RU_996x4,
+	ATH12K_EHT_RU_52_26,
+	ATH12K_EHT_RU_106_26,
+	ATH12K_EHT_RU_484_242,
+	ATH12K_EHT_RU_996_484,
+	ATH12K_EHT_RU_996_484_242,
+	ATH12K_EHT_RU_996x2_484,
+	ATH12K_EHT_RU_996x3,
+	ATH12K_EHT_RU_996x3_484,
+
+	/* Keep last */
+	ATH12K_EHT_RU_INVALID,
+};
+
+#define HAL_RX_RU_ALLOC_TYPE_MAX	ATH12K_EHT_RU_INVALID
+
+static inline
+enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
+{
+	enum nl80211_he_ru_alloc ret;
+
+	switch (ru_tones) {
+	case RU_52:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		break;
+	case RU_106:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		break;
+	case RU_242:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		break;
+	case RU_484:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		break;
+	case RU_996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case RU_2X996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	case RU_26:
+		fallthrough;
+	default:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	}
+	return ret;
+}
+
 struct hal_rx_ops {
 	bool (*rx_desc_get_first_msdu)(struct hal_rx_desc *desc);
 	bool (*rx_desc_get_last_msdu)(struct hal_rx_desc *desc);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 93727a55fc75..ee8e7b883c89 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -8,7 +8,7 @@
 #include "../hal.h"
 #include "../hif.h"
 #include "hal_tx.h"
-#include "../hal_rx.h"
+#include "hal_rx.h"
 #include "../hal_desc.h"
 
 static void ath12k_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
similarity index 83%
rename from drivers/net/wireless/ath/ath12k/hal_rx.h
rename to drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index a3ab588aae19..a4ecc65b8b5d 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_HAL_RX_H
@@ -19,9 +19,6 @@ struct hal_rx_wbm_rel_info {
 	bool hw_cc_done;
 };
 
-#define HAL_INVALID_PEERID	0x3fff
-#define VHT_SIG_SU_NSS_MASK 0x7
-
 #define HAL_RX_MPDU_INFO_PN_GET_BYTE1(__val) \
 	le32_get_bits((__val), GENMASK(7, 0))
 
@@ -39,64 +36,6 @@ struct hal_rx_mon_status_tlv_hdr {
 	u8 value[];
 };
 
-enum hal_rx_su_mu_coding {
-	HAL_RX_SU_MU_CODING_BCC,
-	HAL_RX_SU_MU_CODING_LDPC,
-	HAL_RX_SU_MU_CODING_MAX,
-};
-
-enum hal_rx_gi {
-	HAL_RX_GI_0_8_US,
-	HAL_RX_GI_0_4_US,
-	HAL_RX_GI_1_6_US,
-	HAL_RX_GI_3_2_US,
-	HAL_RX_GI_MAX,
-};
-
-enum hal_rx_bw {
-	HAL_RX_BW_20MHZ,
-	HAL_RX_BW_40MHZ,
-	HAL_RX_BW_80MHZ,
-	HAL_RX_BW_160MHZ,
-	HAL_RX_BW_320MHZ,
-	HAL_RX_BW_MAX,
-};
-
-enum hal_rx_preamble {
-	HAL_RX_PREAMBLE_11A,
-	HAL_RX_PREAMBLE_11B,
-	HAL_RX_PREAMBLE_11N,
-	HAL_RX_PREAMBLE_11AC,
-	HAL_RX_PREAMBLE_11AX,
-	HAL_RX_PREAMBLE_11BA,
-	HAL_RX_PREAMBLE_11BE,
-	HAL_RX_PREAMBLE_MAX,
-};
-
-enum hal_rx_reception_type {
-	HAL_RX_RECEPTION_TYPE_SU,
-	HAL_RX_RECEPTION_TYPE_MU_MIMO,
-	HAL_RX_RECEPTION_TYPE_MU_OFDMA,
-	HAL_RX_RECEPTION_TYPE_MU_OFDMA_MIMO,
-	HAL_RX_RECEPTION_TYPE_MAX,
-};
-
-enum hal_rx_legacy_rate {
-	HAL_RX_LEGACY_RATE_1_MBPS,
-	HAL_RX_LEGACY_RATE_2_MBPS,
-	HAL_RX_LEGACY_RATE_5_5_MBPS,
-	HAL_RX_LEGACY_RATE_6_MBPS,
-	HAL_RX_LEGACY_RATE_9_MBPS,
-	HAL_RX_LEGACY_RATE_11_MBPS,
-	HAL_RX_LEGACY_RATE_12_MBPS,
-	HAL_RX_LEGACY_RATE_18_MBPS,
-	HAL_RX_LEGACY_RATE_24_MBPS,
-	HAL_RX_LEGACY_RATE_36_MBPS,
-	HAL_RX_LEGACY_RATE_48_MBPS,
-	HAL_RX_LEGACY_RATE_54_MBPS,
-	HAL_RX_LEGACY_RATE_INVALID,
-};
-
 #define HAL_TLV_STATUS_PPDU_NOT_DONE            0
 #define HAL_TLV_STATUS_PPDU_DONE                1
 #define HAL_TLV_STATUS_BUF_DONE                 2
@@ -113,167 +52,6 @@ enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_MSDU_END,
 };
 
-#define HAL_RX_MAX_MPDU				1024
-#define HAL_RX_NUM_WORDS_PER_PPDU_BITMAP	(HAL_RX_MAX_MPDU >> 5)
-
-struct hal_rx_user_status {
-	u32 mcs:4,
-	nss:3,
-	ofdma_info_valid:1,
-	ul_ofdma_ru_start_index:7,
-	ul_ofdma_ru_width:7,
-	ul_ofdma_ru_size:8;
-	u32 ul_ofdma_user_v0_word0;
-	u32 ul_ofdma_user_v0_word1;
-	u32 ast_index;
-	u32 tid;
-	u16 tcp_msdu_count;
-	u16 tcp_ack_msdu_count;
-	u16 udp_msdu_count;
-	u16 other_msdu_count;
-	u16 frame_control;
-	u8 frame_control_info_valid;
-	u8 data_sequence_control_info_valid;
-	u16 first_data_seq_ctrl;
-	u32 preamble_type;
-	u16 ht_flags;
-	u16 vht_flags;
-	u16 he_flags;
-	u8 rs_flags;
-	u8 ldpc;
-	u32 mpdu_cnt_fcs_ok;
-	u32 mpdu_cnt_fcs_err;
-	u32 mpdu_fcs_ok_bitmap[HAL_RX_NUM_WORDS_PER_PPDU_BITMAP];
-	u32 mpdu_ok_byte_count;
-	u32 mpdu_err_byte_count;
-	bool ampdu_present;
-	u16 ampdu_id;
-};
-
-#define HAL_MAX_UL_MU_USERS	37
-
-struct hal_rx_u_sig_info {
-	bool ul_dl;
-	u8 bw;
-	u8 ppdu_type_comp_mode;
-	u8 eht_sig_mcs;
-	u8 num_eht_sig_sym;
-	struct ieee80211_radiotap_eht_usig usig;
-};
-
-#define HAL_RX_MON_MAX_AGGR_SIZE	128
-
-struct hal_rx_tlv_aggr_info {
-	bool in_progress;
-	u16 cur_len;
-	u16 tlv_tag;
-	u8 buf[HAL_RX_MON_MAX_AGGR_SIZE];
-};
-
-struct hal_rx_radiotap_eht {
-	__le32 known;
-	__le32 data[9];
-};
-
-#define EHT_MAX_USER_INFO	4
-
-struct hal_rx_eht_info {
-	u8 num_user_info;
-	struct hal_rx_radiotap_eht eht;
-	u32 user_info[EHT_MAX_USER_INFO];
-};
-
-struct hal_rx_mon_ppdu_info {
-	u32 ppdu_id;
-	u32 last_ppdu_id;
-	u64 ppdu_ts;
-	u32 num_mpdu_fcs_ok;
-	u32 num_mpdu_fcs_err;
-	u32 preamble_type;
-	u32 mpdu_len;
-	u16 chan_num;
-	u16 freq;
-	u16 tcp_msdu_count;
-	u16 tcp_ack_msdu_count;
-	u16 udp_msdu_count;
-	u16 other_msdu_count;
-	u16 peer_id;
-	u8 rate;
-	u8 mcs;
-	u8 nss;
-	u8 bw;
-	u8 vht_flag_values1;
-	u8 vht_flag_values2;
-	u8 vht_flag_values3[4];
-	u8 vht_flag_values4;
-	u8 vht_flag_values5;
-	u16 vht_flag_values6;
-	u8 is_stbc;
-	u8 gi;
-	u8 sgi;
-	u8 ldpc;
-	u8 beamformed;
-	u8 rssi_comb;
-	u16 tid;
-	u8 fc_valid;
-	u16 ht_flags;
-	u16 vht_flags;
-	u16 he_flags;
-	u16 he_mu_flags;
-	u8 dcm;
-	u8 ru_alloc;
-	u8 reception_type;
-	u64 tsft;
-	u64 rx_duration;
-	u16 frame_control;
-	u32 ast_index;
-	u8 rs_fcs_err;
-	u8 rs_flags;
-	u8 cck_flag;
-	u8 ofdm_flag;
-	u8 ulofdma_flag;
-	u8 frame_control_info_valid;
-	u16 he_per_user_1;
-	u16 he_per_user_2;
-	u8 he_per_user_position;
-	u8 he_per_user_known;
-	u16 he_flags1;
-	u16 he_flags2;
-	u8 he_RU[4];
-	u16 he_data1;
-	u16 he_data2;
-	u16 he_data3;
-	u16 he_data4;
-	u16 he_data5;
-	u16 he_data6;
-	u32 ppdu_len;
-	u32 prev_ppdu_id;
-	u32 device_id;
-	u16 first_data_seq_ctrl;
-	u8 monitor_direct_used;
-	u8 data_sequence_control_info_valid;
-	u8 ltf_size;
-	u8 rxpcu_filter_pass;
-	s8 rssi_chain[8][8];
-	u32 num_users;
-	u32 mpdu_fcs_ok_bitmap[HAL_RX_NUM_WORDS_PER_PPDU_BITMAP];
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	u8 addr4[ETH_ALEN];
-	struct hal_rx_user_status userstats[HAL_MAX_UL_MU_USERS];
-	u8 userid;
-	bool first_msdu_in_mpdu;
-	bool is_ampdu;
-	u8 medium_prot_type;
-	bool ppdu_continuation;
-	bool eht_usig;
-	struct hal_rx_u_sig_info u_sig_info;
-	bool is_eht;
-	struct hal_rx_eht_info eht_info;
-	struct hal_rx_tlv_aggr_info tlv_aggr;
-};
-
 #define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
 #define HAL_RX_PPDU_START_INFO1_CHAN_NUM		GENMASK(15, 0)
 #define HAL_RX_PPDU_START_INFO1_CHAN_FREQ		GENMASK(31, 16)
@@ -1042,81 +820,6 @@ enum hal_mon_reception_type {
 #define HAL_RU_PER80(ru_per80, num_80mhz, ru_idx_per80mhz) \
 			(HAL_RU(ru_per80, num_80mhz, ru_idx_per80mhz))
 
-#define RU_INVALID		0
-#define RU_26			1
-#define RU_52			2
-#define RU_106			4
-#define RU_242			9
-#define RU_484			18
-#define RU_996			37
-#define RU_2X996		74
-#define RU_3X996		111
-#define RU_4X996		148
-#define RU_52_26		(RU_52 + RU_26)
-#define RU_106_26		(RU_106 + RU_26)
-#define RU_484_242		(RU_484 + RU_242)
-#define RU_996_484		(RU_996 + RU_484)
-#define RU_996_484_242		(RU_996 + RU_484_242)
-#define RU_2X996_484		(RU_2X996 + RU_484)
-#define RU_3X996_484		(RU_3X996 + RU_484)
-
-enum ath12k_eht_ru_size {
-	ATH12K_EHT_RU_26,
-	ATH12K_EHT_RU_52,
-	ATH12K_EHT_RU_106,
-	ATH12K_EHT_RU_242,
-	ATH12K_EHT_RU_484,
-	ATH12K_EHT_RU_996,
-	ATH12K_EHT_RU_996x2,
-	ATH12K_EHT_RU_996x4,
-	ATH12K_EHT_RU_52_26,
-	ATH12K_EHT_RU_106_26,
-	ATH12K_EHT_RU_484_242,
-	ATH12K_EHT_RU_996_484,
-	ATH12K_EHT_RU_996_484_242,
-	ATH12K_EHT_RU_996x2_484,
-	ATH12K_EHT_RU_996x3,
-	ATH12K_EHT_RU_996x3_484,
-
-	/* Keep last */
-	ATH12K_EHT_RU_INVALID,
-};
-
-#define HAL_RX_RU_ALLOC_TYPE_MAX	ATH12K_EHT_RU_INVALID
-
-static inline
-enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
-{
-	enum nl80211_he_ru_alloc ret;
-
-	switch (ru_tones) {
-	case RU_52:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
-		break;
-	case RU_106:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
-		break;
-	case RU_242:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
-		break;
-	case RU_484:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
-		break;
-	case RU_996:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
-		break;
-	case RU_2X996:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
-		break;
-	case RU_26:
-		fallthrough;
-	default:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
-		break;
-	}
-	return ret;
-}
-
 void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab,
 				       struct hal_tlv_64_hdr *tlv,
 				       struct hal_reo_status *status);
-- 
2.34.1


