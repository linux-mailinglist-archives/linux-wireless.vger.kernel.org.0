Return-Path: <linux-wireless+bounces-27225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA5B5200F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 20:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA051C83D7A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7433CEA5;
	Wed, 10 Sep 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JE4M2mRb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114333CE9D
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528081; cv=none; b=YcDxVv1n4fifcARZMSHZ0kXmybLwGH7tToJeR+rBJKK+vFwGAYNYjwfhBrw7Wmn+kHk3LhS16v1AiqSuPKnbONloRZcCryg9pxOBBqcgrVmC2Y+rq2ca49NrojJLG0JY+Cyt/9O/idalAkkodHQVA755n2jaf+eF1fK6y8PTShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528081; c=relaxed/simple;
	bh=htwTQarcJReiG8Q48YkT3hQWonJk8sbTZWIBDTLQG9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZGvjE6N8pYkcvEwHhxuIcUKd7xtEWSIvZZv7pUR01VQX5hWE8/jzHQJGI9aEcoOfj2Sm7MLso7Tds9ANhl5e8zRJcK/AgPAPzRJYcy+0qkoDCnFWa5HYh/rdh7E4foT2MP25AcTf//XSLhvyNmUdgM7dA9Fb26YflyD4uM/FvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JE4M2mRb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACghMk004095;
	Wed, 10 Sep 2025 18:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gxx90UgQ3jUFfwg1fXcOYDnp1YM1qsW2Fmsa4gdQm5o=; b=JE4M2mRbo61B5OPx
	LjYspU52nbBqBwTCA1wsJFJmOXeUXvBNOxfAvb9w6Z8llm1AjzrGxJwDobh0f+FU
	EfCbksjm8t6AKVFxxDxTJH3IuSphvU9CyDDk8Yc0+9/5bWYqbuSuIMJEVmNipsbp
	a4oM3DFkjyunhkZ6kpof1OmhrFsVx1kjZWeLDB6IrVAuKzUq6my3h69dvKxKG/HY
	vnyCjSHTtx67kEuBlNmSyF3LiWe5aoFocO/3Rup8elc0y1E2tVZegscRiu7sDVwg
	EvEyGM0w15d2ij3RXgEzcpINX+qmMVrzoziQP9P2uJu4dxdLPD7mlrNdTYsyHKwD
	N+cMOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsd079-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:14:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58AIEbLL000323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:14:37 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 10 Sep 2025 11:14:35 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v2 4/8] wifi: ath12k: Replace ops with direct calls for rxdma ring mask
Date: Wed, 10 Sep 2025 23:44:10 +0530
Message-ID: <20250910181414.2062280-5-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
References: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eQM4Z-omgdnZTDbjhNWjL4zI9Nluo1l4
X-Proofpoint-GUID: eQM4Z-omgdnZTDbjhNWjL4zI9Nluo1l4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX61blJsCxe5nQ
 rut7GBIDfe9fwHFJ4aTpSjTXgBBECVktEqKFA3tTpz4Mc2jek3h6vDgfDSMLD2IBiDHd4elAuCn
 fV9OhgLimhA77I8lBktQLlUCujvzKey0Bmng/ObdPCC9dIg/oglGAAjck6FnXWje4t0Gd6xZiP6
 wNzAs4f44cMNl/CglO9VWz0yfxUgAL4k9oYc1QR57wM5+TtVQjpLKFOYoLC9eptQEQOtAmzPw7+
 uiOtYbhOErRyR4lE4mNgC4Xw1xs3ymSDoebFeFhzQifubySpy6L6E90Mo+cQWTGddvVP87mK+fC
 3mj+K1mGkRwK9t6pHHPj1oE3rgnK90ghhm6T2aiiJeInH+GdBKC9IwFUEjuBh7ATgFIaSHjTYQD
 hzwKAJo7
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c1c00d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=ZgI4rRAJh95qit-5N8cA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Replace following ops with direct function calls

rxdma_ring_wmask_rx_mpdu_start
rxdma_ring_wmask_rx_msdu_end
rx_desc_get_mpdu_start_offset
rx_desc_get_msdu_end_offset

Remove redundant ops entries following the switch to direct
function calls.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c         | 10 ----------
 drivers/net/wireless/ath/ath12k/hal.h         |  4 ----
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 16 ++++++++--------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 1fba023d0859..329c458d1fe2 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -432,10 +432,6 @@ const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcn9274,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
-	.rx_desc_get_mpdu_start_offset =
-		ath12k_hal_rx_desc_get_mpdu_start_offset_qcn9274,
-	.rx_desc_get_msdu_end_offset =
-		ath12k_hal_rx_desc_get_msdu_end_offset_qcn9274,
 	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_qcn9274,
 	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274,
 	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_qcn9274,
@@ -455,8 +451,6 @@ EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
 const struct hal_ops hal_qcn9274_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
 	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
-	.rxdma_ring_wmask_rx_mpdu_start = ath12k_hal_rx_mpdu_start_wmask_get_qcn9274,
-	.rxdma_ring_wmask_rx_msdu_end = ath12k_hal_rx_msdu_end_wmask_get_qcn9274,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
 
@@ -609,8 +603,6 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
-	.rx_desc_get_mpdu_start_offset = ath12k_hal_rx_desc_get_mpdu_start_offset_wcn7850,
-	.rx_desc_get_msdu_end_offset = ath12k_hal_rx_desc_get_msdu_end_offset_wcn7850,
 	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_wcn7850,
 	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850,
 	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_wcn7850,
@@ -629,8 +621,6 @@ EXPORT_SYMBOL(hal_rx_wcn7850_ops);
 const struct hal_ops hal_wcn7850_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
 	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
-	.rxdma_ring_wmask_rx_mpdu_start = NULL,
-	.rxdma_ring_wmask_rx_msdu_end = NULL,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index e4c46a9ad94e..ee0c22d65d2c 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1576,8 +1576,6 @@ struct hal_rx_ops {
 	void (*rx_desc_set_msdu_len)(struct hal_rx_desc *desc, u16 len);
 	struct rx_attention *(*rx_desc_get_attention)(struct hal_rx_desc *desc);
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
-	u32 (*rx_desc_get_mpdu_start_offset)(void);
-	u32 (*rx_desc_get_msdu_end_offset)(void);
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
 	bool (*rx_desc_is_da_mcbc)(struct hal_rx_desc *desc);
@@ -1597,8 +1595,6 @@ struct hal_rx_ops {
 
 struct hal_ops {
 	int (*create_srng_config)(struct ath12k_base *ab);
-	u16 (*rxdma_ring_wmask_rx_mpdu_start)(void);
-	u32 (*rxdma_ring_wmask_rx_msdu_end)(void);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 2105d9e94976..99ff56038452 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -7,6 +7,8 @@
 #include "dp_rx.h"
 #include "../dp_tx.h"
 #include "../peer.h"
+#include "hal_qcn9274.h"
+#include "hal_wcn7850.h"
 
 void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
 				   dma_addr_t paddr)
@@ -1897,14 +1899,12 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
 
 	tlv_filter.rx_mpdu_start_offset =
-		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
+		ath12k_hal_rx_desc_get_mpdu_start_offset_qcn9274();
 	tlv_filter.rx_msdu_end_offset =
-		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
+		ath12k_hal_rx_desc_get_msdu_end_offset_qcn9274();
 
-	tlv_filter.rx_mpdu_start_wmask =
-		ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start();
-	tlv_filter.rx_msdu_end_wmask =
-		ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end();
+	tlv_filter.rx_mpdu_start_wmask = ath12k_hal_rx_mpdu_start_wmask_get_qcn9274();
+	tlv_filter.rx_msdu_end_wmask = ath12k_hal_rx_msdu_end_wmask_get_qcn9274();
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
 		   "Configuring compact tlv masks rx_mpdu_start_wmask 0x%x rx_msdu_end_wmask 0x%x\n",
 		   tlv_filter.rx_mpdu_start_wmask, tlv_filter.rx_msdu_end_wmask);
@@ -1940,9 +1940,9 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	tlv_filter.rx_header_offset = offsetof(struct hal_rx_desc_wcn7850, pkt_hdr_tlv);
 
 	tlv_filter.rx_mpdu_start_offset =
-		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
+		ath12k_hal_rx_desc_get_mpdu_start_offset_wcn7850();
 	tlv_filter.rx_msdu_end_offset =
-		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
+		ath12k_hal_rx_desc_get_msdu_end_offset_wcn7850();
 
 	/* TODO: Selectively subscribe to required qwords within msdu_end
 	 * and mpdu_start and setup the mask in below msg
-- 
2.34.1


