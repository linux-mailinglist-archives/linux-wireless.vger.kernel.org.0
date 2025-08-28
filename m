Return-Path: <linux-wireless+bounces-26816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080AB3A840
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B818C16DFC5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74933CEB6;
	Thu, 28 Aug 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IEm+eGRx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD23314BB
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402585; cv=none; b=WDNgJ6HNWv8muxSH4TaGhau0595KUpkkoyv1dRMGNgqnf3obfK7/otfoxZRJ1/j6P/WREkSjQMjQLiPKmR/k4RoFrYePmXRm6s7kmzA0oZNZnc2xMPHy186MdT+Cb8CElEpgs2/tOqYQuR9H3B7xY2vkoz8kR0F+fkcyjzY4WnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402585; c=relaxed/simple;
	bh=3eHfCIyeSSHhHek2ovs4HxplspV0ua+PRq9qBTB3NRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBAXa3Vxv+2/Tp8EY1VLPmkyC+TSKAHIXWFbl1+6U6TkRhMMKQUtUOHRtRoB5O+9JRfcB0z9n4bNidoTREF6JHU4lAX7JY5SQGkt9BIDdKqk0ovsENQutz/ZbSiP25jQAXDceDQkaL9A+LsrFRUHcxVKbP82L6BxYhiX5RV7dyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IEm+eGRx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SE9Y3d015824;
	Thu, 28 Aug 2025 17:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TjaCnC8ftiDmJku96nYc/o1LON+DGKgcQ3z3pqDuVJ4=; b=IEm+eGRxDUrUiVTu
	8TNccpdhK3brL8ncX/73GhecTkUPksOyCsJQ2zDqglK3oCcxHIOSyogDjDjLlDlX
	GUNtrqT3irAHfIe7M3HNEhB6+xTVZKQxTzlYEYCN7zAG8E2uXHp4g1G6FYUFMCxA
	sR53mnk2Pk1c6hVkZjZWEhY6wde1RG4JnCKM0gj0P/cuMP3hku0iISWv1Z1Y9L2C
	mcjA0oal8qBEt51NyG2NYsrZKCFNsqwv/yA88LjdU/wsQDwJ9ajinJKaSj6+YY6B
	OHiVXTGrinxfemaD3ljUu4r+BT3rD5KCDVqNAih9k4+uIKVsgDqKh6iQ0HSqhpgu
	5ZVs9Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf3e4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaJlY013828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:19 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:17 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 06/20] wifi: ath12k: Move hal_desc.h file to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:39 +0530
Message-ID: <20250828173553.3341351-7-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: CCUTD-hI8PD0sxwXxRgu5LJmt3wO6B8l
X-Proofpoint-ORIG-GUID: CCUTD-hI8PD0sxwXxRgu5LJmt3wO6B8l
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b09394 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=WjfyU6I75VFxz1pThT0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfXzTPl2r35bzW8
 XXLEd3BzFgjtd5UdGwzaZFVcHskvceNjdFmGmCfssjvXZ8mkhCb4MIATeQuSPYa4vp1ZHWtDHBX
 RuAViKnI+yUd86W/qKJrIprRJEYNg4y7LzhWDr38dqbXy6ZVzrv4tXYUvEBBd2NnXowzsaXwfoN
 TJ6R72/Iluys8n5U26O+1xYSlcN1yW151YeVi2OVXiq2tnHKdfX95xC+zmf91bGAeey0H4ZABo3
 IQX0e9J8HE5JFFRTCwvp1wtzHg0u153ewYiQyloRPUrOt+HafzUUVTazK2Fl91qb/bhhxc+8g03
 4rkV587EBcekj3517SGBq/xk/YUgFWma82wURapt5v7aVUc+ImpI5pCab+YhrXKaOQMXYIdWQ/K
 Ranay5/t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move wifi7 architecture specific file hal_desc.h to wifi7 directory,
and move the common part from it to hal.h file which is in the
common directory.

It is as part of a broader effort to separate common and hardware-specific
code into distinct modules. This modularization enables reuse of the common
driver components across multiple hardware architectures.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h          |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |   2 +-
 drivers/net/wireless/ath/ath12k/hal.c         |   2 +-
 drivers/net/wireless/ath/ath12k/hal.h         | 149 +++++++++++++++++-
 .../ath/ath12k/{ => wifi7}/hal_desc.h         | 149 +-----------------
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   2 +-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   2 +-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   2 +-
 8 files changed, 156 insertions(+), 154 deletions(-)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h (95%)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index faab444744b3..6ab74d773261 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -7,7 +7,7 @@
 #ifndef ATH12K_DP_H
 #define ATH12K_DP_H
 
-#include "hal_desc.h"
+#include "wifi7/hal_desc.h"
 #include "wifi7/hal_rx.h"
 #include "hw.h"
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 453310080182..3da3ed5844c7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -10,7 +10,7 @@
 #include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
-#include "hal_desc.h"
+#include "wifi7/hal_desc.h"
 #include "hw.h"
 #include "dp_rx.h"
 #include "wifi7/hal_rx.h"
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index f9ce60d22cc1..144c26586b79 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -7,7 +7,7 @@
 #include "wifi7/hal_tx.h"
 #include "wifi7/hal_rx.h"
 #include "debug.h"
-#include "hal_desc.h"
+#include "wifi7/hal_desc.h"
 #include "hif.h"
 
 static const struct hal_srng_config hw_srng_config_template[] = {
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index d02d27f28cc1..ec8a078f0739 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -7,11 +7,13 @@
 #ifndef ATH12K_HAL_H
 #define ATH12K_HAL_H
 
-#include "hal_desc.h"
+#include "wifi7/hal_desc.h"
 #include "rx_desc.h"
 
 struct ath12k_base;
 
+#define HAL_DESC_REO_NON_QOS_TID	16
+
 #define HAL_INVALID_PEERID	0x3fff
 #define VHT_SIG_SU_NSS_MASK	0x7
 
@@ -672,6 +674,128 @@ enum hal_reo_cmd_status {
 	HAL_REO_CMD_DRAIN		= 0xff,
 };
 
+enum hal_tcl_encap_type {
+	HAL_TCL_ENCAP_TYPE_RAW,
+	HAL_TCL_ENCAP_TYPE_NATIVE_WIFI,
+	HAL_TCL_ENCAP_TYPE_ETHERNET,
+	HAL_TCL_ENCAP_TYPE_802_3 = 3,
+	HAL_TCL_ENCAP_TYPE_MAX
+};
+
+enum hal_tcl_desc_type {
+	HAL_TCL_DESC_TYPE_BUFFER,
+	HAL_TCL_DESC_TYPE_EXT_DESC,
+	HAL_TCL_DESC_TYPE_MAX,
+};
+
+enum hal_reo_dest_ring_buffer_type {
+	HAL_REO_DEST_RING_BUFFER_TYPE_MSDU,
+	HAL_REO_DEST_RING_BUFFER_TYPE_LINK_DESC,
+};
+
+enum hal_reo_dest_ring_push_reason {
+	HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED,
+	HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION,
+};
+
+enum hal_reo_entr_rxdma_push_reason {
+	HAL_REO_ENTR_RING_RXDMA_PUSH_REASON_ERR_DETECTED,
+	HAL_REO_ENTR_RING_RXDMA_PUSH_REASON_ROUTING_INSTRUCTION,
+	HAL_REO_ENTR_RING_RXDMA_PUSH_REASON_RX_FLUSH,
+};
+
+enum hal_reo_dest_ring_error_code {
+	HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO,
+	HAL_REO_DEST_RING_ERROR_CODE_DESC_INVALID,
+	HAL_REO_DEST_RING_ERROR_CODE_AMPDU_IN_NON_BA,
+	HAL_REO_DEST_RING_ERROR_CODE_NON_BA_DUPLICATE,
+	HAL_REO_DEST_RING_ERROR_CODE_BA_DUPLICATE,
+	HAL_REO_DEST_RING_ERROR_CODE_FRAME_2K_JUMP,
+	HAL_REO_DEST_RING_ERROR_CODE_BAR_2K_JUMP,
+	HAL_REO_DEST_RING_ERROR_CODE_FRAME_OOR,
+	HAL_REO_DEST_RING_ERROR_CODE_BAR_OOR,
+	HAL_REO_DEST_RING_ERROR_CODE_NO_BA_SESSION,
+	HAL_REO_DEST_RING_ERROR_CODE_FRAME_SN_EQUALS_SSN,
+	HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED,
+	HAL_REO_DEST_RING_ERROR_CODE_2K_ERR_FLAG_SET,
+	HAL_REO_DEST_RING_ERROR_CODE_PN_ERR_FLAG_SET,
+	HAL_REO_DEST_RING_ERROR_CODE_DESC_BLOCKED,
+	HAL_REO_DEST_RING_ERROR_CODE_MAX,
+};
+
+enum hal_reo_entr_rxdma_ecode {
+	HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_FCS_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_UNECRYPTED_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LEN_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LIMIT_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_WIFI_PARSE_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_PARSE_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_SA_TIMEOUT_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_DA_TIMEOUT_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_FLOW_TIMEOUT_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_FRAG_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_MULTICAST_ECHO_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_MISMATCH_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_GRPCAST_AMSDU_WDS_ERR,
+	HAL_REO_ENTR_RING_RXDMA_ECODE_MAX,
+};
+
+enum hal_wbm_htt_tx_comp_status {
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_OK,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX,
+};
+
+enum hal_encrypt_type {
+	HAL_ENCRYPT_TYPE_WEP_40,
+	HAL_ENCRYPT_TYPE_WEP_104,
+	HAL_ENCRYPT_TYPE_TKIP_NO_MIC,
+	HAL_ENCRYPT_TYPE_WEP_128,
+	HAL_ENCRYPT_TYPE_TKIP_MIC,
+	HAL_ENCRYPT_TYPE_WAPI,
+	HAL_ENCRYPT_TYPE_CCMP_128,
+	HAL_ENCRYPT_TYPE_OPEN,
+	HAL_ENCRYPT_TYPE_CCMP_256,
+	HAL_ENCRYPT_TYPE_GCMP_128,
+	HAL_ENCRYPT_TYPE_AES_GCMP_256,
+	HAL_ENCRYPT_TYPE_WAPI_GCM_SM4,
+};
+
+enum hal_tx_rate_stats_bw {
+	HAL_TX_RATE_STATS_BW_20,
+	HAL_TX_RATE_STATS_BW_40,
+	HAL_TX_RATE_STATS_BW_80,
+	HAL_TX_RATE_STATS_BW_160,
+};
+
+enum hal_tx_rate_stats_pkt_type {
+	HAL_TX_RATE_STATS_PKT_TYPE_11A,
+	HAL_TX_RATE_STATS_PKT_TYPE_11B,
+	HAL_TX_RATE_STATS_PKT_TYPE_11N,
+	HAL_TX_RATE_STATS_PKT_TYPE_11AC,
+	HAL_TX_RATE_STATS_PKT_TYPE_11AX,
+	HAL_TX_RATE_STATS_PKT_TYPE_11BA,
+	HAL_TX_RATE_STATS_PKT_TYPE_11BE,
+};
+
+enum hal_tx_rate_stats_sgi {
+	HAL_TX_RATE_STATS_SGI_08US,
+	HAL_TX_RATE_STATS_SGI_04US,
+	HAL_TX_RATE_STATS_SGI_16US,
+	HAL_TX_RATE_STATS_SGI_32US,
+};
+
 struct hal_wbm_idle_scatter_list {
 	dma_addr_t paddr;
 	struct hal_wbm_link_desc *vaddr;
@@ -1280,6 +1404,29 @@ struct ath12k_hal_tcl_to_wbm_rbm_map  {
 	u8 rbm_id;
 };
 
+enum hal_wbm_rel_bm_act {
+	HAL_WBM_REL_BM_ACT_PUT_IN_IDLE,
+	HAL_WBM_REL_BM_ACT_REL_MSDU,
+};
+
+/* hal_wbm_rel_bm_act
+ *
+ * put_in_idle_list
+ *	Put the buffer or descriptor back in the idle list. In case of MSDU or
+ *	MDPU link descriptor, BM does not need to check to release any
+ *	individual MSDU buffers.
+ *
+ * release_msdu_list
+ *	This BM action can only be used in combination with desc_type being
+ *	msdu_link_descriptor. Field first_msdu_index points out which MSDU
+ *	pointer in the MSDU link descriptor is the first of an MPDU that is
+ *	released. BM shall release all the MSDU buffers linked to this first
+ *	MSDU buffer pointer. All related MSDU buffer pointer entries shall be
+ *	set to value 0, which represents the 'NULL' pointer. When all MSDU
+ *	buffer pointers in the MSDU link descriptor are 'NULL', the MSDU link
+ *	descriptor itself shall also be released.
+ */
+
 #define RU_INVALID		0
 #define RU_26			1
 #define RU_52			2
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
similarity index 95%
rename from drivers/net/wireless/ath/ath12k/hal_desc.h
rename to drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index 0173f731bfef..0e91410bdedf 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
-#include "core.h"
+#include "../core.h"
 
 #ifndef ATH12K_HAL_DESC_H
 #define ATH12K_HAL_DESC_H
@@ -820,35 +820,6 @@ struct rx_msdu_ext_desc {
  *		Set to the link ID of the PMAC that received the frame
  */
 
-enum hal_reo_dest_ring_buffer_type {
-	HAL_REO_DEST_RING_BUFFER_TYPE_MSDU,
-	HAL_REO_DEST_RING_BUFFER_TYPE_LINK_DESC,
-};
-
-enum hal_reo_dest_ring_push_reason {
-	HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED,
-	HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION,
-};
-
-enum hal_reo_dest_ring_error_code {
-	HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO,
-	HAL_REO_DEST_RING_ERROR_CODE_DESC_INVALID,
-	HAL_REO_DEST_RING_ERROR_CODE_AMPDU_IN_NON_BA,
-	HAL_REO_DEST_RING_ERROR_CODE_NON_BA_DUPLICATE,
-	HAL_REO_DEST_RING_ERROR_CODE_BA_DUPLICATE,
-	HAL_REO_DEST_RING_ERROR_CODE_FRAME_2K_JUMP,
-	HAL_REO_DEST_RING_ERROR_CODE_BAR_2K_JUMP,
-	HAL_REO_DEST_RING_ERROR_CODE_FRAME_OOR,
-	HAL_REO_DEST_RING_ERROR_CODE_BAR_OOR,
-	HAL_REO_DEST_RING_ERROR_CODE_NO_BA_SESSION,
-	HAL_REO_DEST_RING_ERROR_CODE_FRAME_SN_EQUALS_SSN,
-	HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED,
-	HAL_REO_DEST_RING_ERROR_CODE_2K_ERR_FLAG_SET,
-	HAL_REO_DEST_RING_ERROR_CODE_PN_ERR_FLAG_SET,
-	HAL_REO_DEST_RING_ERROR_CODE_DESC_BLOCKED,
-	HAL_REO_DEST_RING_ERROR_CODE_MAX,
-};
-
 #define HAL_REO_DEST_RING_INFO0_BUFFER_TYPE		BIT(0)
 #define HAL_REO_DEST_RING_INFO0_PUSH_REASON		GENMASK(2, 1)
 #define HAL_REO_DEST_RING_INFO0_ERROR_CODE		GENMASK(7, 3)
@@ -986,35 +957,6 @@ struct hal_reo_to_ppe_ring {
  *		More Segments followed
  */
 
-enum hal_reo_entr_rxdma_push_reason {
-	HAL_REO_ENTR_RING_RXDMA_PUSH_REASON_ERR_DETECTED,
-	HAL_REO_ENTR_RING_RXDMA_PUSH_REASON_ROUTING_INSTRUCTION,
-	HAL_REO_ENTR_RING_RXDMA_PUSH_REASON_RX_FLUSH,
-};
-
-enum hal_reo_entr_rxdma_ecode {
-	HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_FCS_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_UNECRYPTED_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LEN_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_MSDU_LIMIT_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_WIFI_PARSE_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_PARSE_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_SA_TIMEOUT_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_DA_TIMEOUT_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_FLOW_TIMEOUT_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_FRAG_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_MULTICAST_ECHO_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_AMSDU_MISMATCH_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_GRPCAST_AMSDU_WDS_ERR,
-	HAL_REO_ENTR_RING_RXDMA_ECODE_MAX,
-};
-
 enum hal_rx_reo_dest_ring {
 	HAL_RX_REO_DEST_RING_TCL,
 	HAL_RX_REO_DEST_RING_SW1,
@@ -1268,46 +1210,6 @@ struct hal_reo_flush_cache {
 #define HAL_TCL_DATA_CMD_INFO5_RING_ID			GENMASK(27, 20)
 #define HAL_TCL_DATA_CMD_INFO5_LOOPING_COUNT		GENMASK(31, 28)
 
-enum hal_encrypt_type {
-	HAL_ENCRYPT_TYPE_WEP_40,
-	HAL_ENCRYPT_TYPE_WEP_104,
-	HAL_ENCRYPT_TYPE_TKIP_NO_MIC,
-	HAL_ENCRYPT_TYPE_WEP_128,
-	HAL_ENCRYPT_TYPE_TKIP_MIC,
-	HAL_ENCRYPT_TYPE_WAPI,
-	HAL_ENCRYPT_TYPE_CCMP_128,
-	HAL_ENCRYPT_TYPE_OPEN,
-	HAL_ENCRYPT_TYPE_CCMP_256,
-	HAL_ENCRYPT_TYPE_GCMP_128,
-	HAL_ENCRYPT_TYPE_AES_GCMP_256,
-	HAL_ENCRYPT_TYPE_WAPI_GCM_SM4,
-};
-
-enum hal_tcl_encap_type {
-	HAL_TCL_ENCAP_TYPE_RAW,
-	HAL_TCL_ENCAP_TYPE_NATIVE_WIFI,
-	HAL_TCL_ENCAP_TYPE_ETHERNET,
-	HAL_TCL_ENCAP_TYPE_802_3 = 3,
-	HAL_TCL_ENCAP_TYPE_MAX
-};
-
-enum hal_tcl_desc_type {
-	HAL_TCL_DESC_TYPE_BUFFER,
-	HAL_TCL_DESC_TYPE_EXT_DESC,
-	HAL_TCL_DESC_TYPE_MAX,
-};
-
-enum hal_wbm_htt_tx_comp_status {
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_OK,
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP,
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL,
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ,
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT,
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY,
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH,
-	HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX,
-};
-
 struct hal_tcl_data_cmd {
 	struct ath12k_buffer_addr buf_addr_info;
 	__le32 info0;
@@ -1764,30 +1666,6 @@ struct hal_ce_srng_dst_status_desc {
 #define HAL_TX_RATE_STATS_INFO0_OFDMA_TX	BIT(16)
 #define HAL_TX_RATE_STATS_INFO0_TONES_IN_RU	GENMASK(28, 17)
 
-enum hal_tx_rate_stats_bw {
-	HAL_TX_RATE_STATS_BW_20,
-	HAL_TX_RATE_STATS_BW_40,
-	HAL_TX_RATE_STATS_BW_80,
-	HAL_TX_RATE_STATS_BW_160,
-};
-
-enum hal_tx_rate_stats_pkt_type {
-	HAL_TX_RATE_STATS_PKT_TYPE_11A,
-	HAL_TX_RATE_STATS_PKT_TYPE_11B,
-	HAL_TX_RATE_STATS_PKT_TYPE_11N,
-	HAL_TX_RATE_STATS_PKT_TYPE_11AC,
-	HAL_TX_RATE_STATS_PKT_TYPE_11AX,
-	HAL_TX_RATE_STATS_PKT_TYPE_11BA,
-	HAL_TX_RATE_STATS_PKT_TYPE_11BE,
-};
-
-enum hal_tx_rate_stats_sgi {
-	HAL_TX_RATE_STATS_SGI_08US,
-	HAL_TX_RATE_STATS_SGI_04US,
-	HAL_TX_RATE_STATS_SGI_16US,
-	HAL_TX_RATE_STATS_SGI_32US,
-};
-
 struct hal_tx_rate_stats {
 	__le32 info0;
 	__le32 tsf;
@@ -1843,28 +1721,6 @@ enum hal_wbm_rel_desc_type {
  *	treat this is the same way as a link descriptor.
  */
 
-enum hal_wbm_rel_bm_act {
-	HAL_WBM_REL_BM_ACT_PUT_IN_IDLE,
-	HAL_WBM_REL_BM_ACT_REL_MSDU,
-};
-
-/* hal_wbm_rel_bm_act
- *
- * put_in_idle_list
- *	Put the buffer or descriptor back in the idle list. In case of MSDU or
- *	MDPU link descriptor, BM does not need to check to release any
- *	individual MSDU buffers.
- *
- * release_msdu_list
- *	This BM action can only be used in combination with desc_type being
- *	msdu_link_descriptor. Field first_msdu_index points out which MSDU
- *	pointer in the MSDU link descriptor is the first of an MPDU that is
- *	released. BM shall release all the MSDU buffers linked to this first
- *	MSDU buffer pointer. All related MSDU buffer pointer entries shall be
- *	set to value 0, which represents the 'NULL' pointer. When all MSDU
- *	buffer pointers in the MSDU link descriptor are 'NULL', the MSDU link
- *	descriptor itself shall also be released.
- */
 #define HAL_WBM_COMPL_RX_INFO0_REL_SRC_MODULE		GENMASK(2, 0)
 #define HAL_WBM_COMPL_RX_INFO0_BM_ACTION		GENMASK(5, 3)
 #define HAL_WBM_COMPL_RX_INFO0_DESC_TYPE		GENMASK(8, 6)
@@ -2330,7 +2186,6 @@ enum hal_desc_buf_type {
 #define HAL_DESC_REO_OWNED		4
 #define HAL_DESC_REO_QUEUE_DESC		8
 #define HAL_DESC_REO_QUEUE_EXT_DESC	9
-#define HAL_DESC_REO_NON_QOS_TID	16
 
 #define HAL_DESC_HDR_INFO0_OWNER	GENMASK(3, 0)
 #define HAL_DESC_HDR_INFO0_BUF_TYPE	GENMASK(7, 4)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index ee8e7b883c89..801dde62e4ed 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -9,7 +9,7 @@
 #include "../hif.h"
 #include "hal_tx.h"
 #include "hal_rx.h"
-#include "../hal_desc.h"
+#include "hal_desc.h"
 
 static void ath12k_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
 					u8 owner, u8 buffer_type, u32 magic)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
index 87c1312c4f46..3a7d3163b1a5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
@@ -4,7 +4,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include "../hal_desc.h"
+#include "hal_desc.h"
 #include "../hal.h"
 #include "hal_tx.h"
 #include "../hif.h"
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
index b179320569ff..412fe1ba22dc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
@@ -7,7 +7,7 @@
 #ifndef ATH12K_HAL_TX_H
 #define ATH12K_HAL_TX_H
 
-#include "../hal_desc.h"
+#include "hal_desc.h"
 #include "../core.h"
 
 /* TODO: check all these data can be managed with struct ath12k_tx_desc_info for perf */
-- 
2.34.1


