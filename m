Return-Path: <linux-wireless+bounces-27909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46512BC8B62
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26E3D4E657F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB52E03F0;
	Thu,  9 Oct 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iRcg7O3N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB52E0914
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008280; cv=none; b=Wouyw2N1yuhoDqqrOT7rPjNbLMdu3OvAyoAEEEWnx974ZMbjyxIymJ9wB8Egeebqwcvl8ndZ0NuhES6m9ZfoE4hVyaOD9ffXmQP2dEHBJI5m+gXiORt5a55n6tIs4VJP+pTLg7N0Ijnf93YOkNTUk9O7Zmw4WZHAMn6l3HwDf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008280; c=relaxed/simple;
	bh=vErxTcLT6qrz30fYNjmFmFMUKBSe/5Fi2ymPzn3rAS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VznsTp0JNoyORRr5WewQjKf5MIoWhNVJHSe9dqMxz3ev9zHc1Y9+gRe9f+vdvb8cFU1An2okc13yNZviuYqLn9qOH3cEouIZSwSQ1SIzIXLt/GaJ40WVW2DaSYaqfjGwXQcnf6AJXhhYDhTAw4VV9yJMI9ty7JxzfKykkkHLZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iRcg7O3N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EHxc029049;
	Thu, 9 Oct 2025 11:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SPFYSXVfmf2xRnEO8GFieJFZRqbs39pzrhh2errXkHU=; b=iRcg7O3NuDVt/VGj
	HxcBbSQMtcNVkpBqbvIz26CxzMrgn0czYLnBcEBriMWk6Pzx+KFdbZnE+ILp8KX0
	G5BBKGrinUAO5UruJWInUMqn7xMsGBqdJ21YHDAL6PhKwVl0Um87Sid4LXSUOtHM
	i/g3WmeZKcWBDdlZ/q6xMPoiv2CyDxDBXqBb8QELzw4xmXGgAaJRefT4gG4ws1Rw
	6MjJmziKrqxbJkll7qiF2/QoQy8JVRlTxif8ciP38Uwa2tbBe1OqFZCHQ5tLkoPl
	cDN8RXn0PE6+rfDoHK+G+uLmwpcZo5SVAjtFUrCylkxQOVPIxMG1Y8RyG+I4djM5
	70Wa9Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kthbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBGQJ011095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:16 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:15 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 10/18] wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
Date: Thu, 9 Oct 2025 16:40:37 +0530
Message-ID: <20251009111045.1763001-11-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXx2Jlf5gDOapd
 tZZ4Fnu/nwsAnoKn7JIDog1VWVLKJItJ7ApnazOamCcVj+TQRea4GrfslXrPAjmNtTMJd68xGAl
 BGQZ1QbubuRFVGZYN62T0NrGAlLWVn85tay73LpcLk3sX3J17bW5r1HHB1LOhZXcKCEzHKqrwxN
 Hl70dLavw2B5nhK0LOD+Z4PzrcL4Bgv0pNeD2eSfwoZIZ5+Z1tO0RL1NzCK3SkJRtExLkey4eVR
 D4IwVVkjG0qfB2RcehdEaZBl6AvLS2iFjKUyNikmsMvWg4pxtKRZ7BGQ3u9wGxgKz/j+yqpiXz+
 V0/BTYA7CSHfNTM0Znjme7WJCPlEwHQoCHWvbq3SFhW8V5SZmpiSJZGdGuDGc3Qp3McWFT/kNJe
 iBCxBapXBhNcpnn1bpM6wa5dT/9IAg==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e79855 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=vY2i2-dV-__wzEwJVzcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ABUkCjkvvoEozyWHetjuF0yYRUUgHnSn
X-Proofpoint-ORIG-GUID: ABUkCjkvvoEozyWHetjuF0yYRUUgHnSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move the hardware specific HAL APIs to hal.c file
inside wifi7 directory. These APIs will be called
through the hal_ops mechanism, which are registered
separately by qcn and wcn

Handling following APIs:
ath12k_wifi7_hal_ce_get_desc_size
ath12k_wifi7_hal_ce_src_set_desc
ath12k_wifi7_hal_ce_dst_set_desc

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ce.c          | 23 ++++++----
 drivers/net/wireless/ath/ath12k/hal.c         | 44 ++++++-------------
 drivers/net/wireless/ath/ath12k/hal.h         | 18 ++++++--
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   | 38 ++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   |  6 +++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  3 ++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  3 ++
 7 files changed, 92 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index 6e380b773f05..ae8fda8689ab 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "dp_rx.h"
@@ -40,7 +40,7 @@ static int ath12k_ce_rx_buf_enqueue_pipe(struct ath12k_ce_pipe *pipe,
 		goto exit;
 	}
 
-	ath12k_hal_ce_dst_set_desc(desc, paddr);
+	ath12k_hal_ce_dst_set_desc(&ab->hal, desc, paddr);
 
 	ring->skb[write_index] = skb;
 	write_index = CE_RING_IDX_INCR(nentries_mask, write_index);
@@ -364,6 +364,7 @@ ath12k_ce_alloc_ring(struct ath12k_base *ab, int nentries, int desc_sz)
 
 static int ath12k_ce_alloc_pipe(struct ath12k_base *ab, int ce_id)
 {
+	struct ath12k_hal *hal = &ab->hal;
 	struct ath12k_ce_pipe *pipe = &ab->ce.ce_pipe[ce_id];
 	const struct ce_attr *attr = &ab->hw_params->host_ce_config[ce_id];
 	struct ath12k_ce_ring *ring;
@@ -375,7 +376,7 @@ static int ath12k_ce_alloc_pipe(struct ath12k_base *ab, int ce_id)
 	if (attr->src_nentries) {
 		pipe->send_cb = ath12k_ce_send_done_cb;
 		nentries = roundup_pow_of_two(attr->src_nentries);
-		desc_sz = ath12k_hal_ce_get_desc_size(HAL_CE_DESC_SRC);
+		desc_sz = ath12k_hal_ce_get_desc_size(hal, HAL_CE_DESC_SRC);
 		ring = ath12k_ce_alloc_ring(ab, nentries, desc_sz);
 		if (IS_ERR(ring))
 			return PTR_ERR(ring);
@@ -385,13 +386,13 @@ static int ath12k_ce_alloc_pipe(struct ath12k_base *ab, int ce_id)
 	if (attr->dest_nentries) {
 		pipe->recv_cb = attr->recv_cb;
 		nentries = roundup_pow_of_two(attr->dest_nentries);
-		desc_sz = ath12k_hal_ce_get_desc_size(HAL_CE_DESC_DST);
+		desc_sz = ath12k_hal_ce_get_desc_size(hal, HAL_CE_DESC_DST);
 		ring = ath12k_ce_alloc_ring(ab, nentries, desc_sz);
 		if (IS_ERR(ring))
 			return PTR_ERR(ring);
 		pipe->dest_ring = ring;
 
-		desc_sz = ath12k_hal_ce_get_desc_size(HAL_CE_DESC_DST_STATUS);
+		desc_sz = ath12k_hal_ce_get_desc_size(hal, HAL_CE_DESC_DST_STATUS);
 		ring = ath12k_ce_alloc_ring(ab, nentries, desc_sz);
 		if (IS_ERR(ring))
 			return PTR_ERR(ring);
@@ -484,7 +485,7 @@ int ath12k_ce_send(struct ath12k_base *ab, struct sk_buff *skb, u8 pipe_id,
 	if (pipe->attr_flags & CE_ATTR_BYTE_SWAP_DATA)
 		byte_swap_data = 1;
 
-	ath12k_hal_ce_src_set_desc(desc, ATH12K_SKB_CB(skb)->paddr,
+	ath12k_hal_ce_src_set_desc(&ab->hal, desc, ATH12K_SKB_CB(skb)->paddr,
 				   skb->len, transfer_id, byte_swap_data);
 
 	pipe->src_ring->skb[write_index] = skb;
@@ -670,6 +671,7 @@ int ath12k_ce_init_pipes(struct ath12k_base *ab)
 
 void ath12k_ce_free_pipes(struct ath12k_base *ab)
 {
+	struct ath12k_hal *hal = &ab->hal;
 	struct ath12k_ce_pipe *pipe;
 	int desc_sz;
 	int i;
@@ -678,7 +680,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 		pipe = &ab->ce.ce_pipe[i];
 
 		if (pipe->src_ring) {
-			desc_sz = ath12k_hal_ce_get_desc_size(HAL_CE_DESC_SRC);
+			desc_sz = ath12k_hal_ce_get_desc_size(hal,
+							      HAL_CE_DESC_SRC);
 			dma_free_coherent(ab->dev,
 					  pipe->src_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
@@ -689,7 +692,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 		}
 
 		if (pipe->dest_ring) {
-			desc_sz = ath12k_hal_ce_get_desc_size(HAL_CE_DESC_DST);
+			desc_sz = ath12k_hal_ce_get_desc_size(hal,
+							      HAL_CE_DESC_DST);
 			dma_free_coherent(ab->dev,
 					  pipe->dest_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
@@ -701,7 +705,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
 
 		if (pipe->status_ring) {
 			desc_sz =
-			  ath12k_hal_ce_get_desc_size(HAL_CE_DESC_DST_STATUS);
+			  ath12k_hal_ce_get_desc_size(hal,
+						      HAL_CE_DESC_DST_STATUS);
 			dma_free_coherent(ab->dev,
 					  pipe->status_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index d4dd83d9e67f..490a483b8c30 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -51,6 +51,11 @@ int ath12k_hal_srng_update_shadow_config(struct ath12k_base *ab,
 							  ring_num);
 }
 
+u32 ath12k_hal_ce_get_desc_size(struct ath12k_hal *hal, enum hal_ce_desc type)
+{
+	return hal->hal_ops->ce_get_desc_size(type);
+}
+
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_hal *hal)
 {
 	size_t size;
@@ -185,40 +190,19 @@ dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 			(unsigned long)ab->hal.wrp.vaddr);
 }
 
-u32 ath12k_hal_ce_get_desc_size(enum hal_ce_desc type)
-{
-	switch (type) {
-	case HAL_CE_DESC_SRC:
-		return sizeof(struct hal_ce_srng_src_desc);
-	case HAL_CE_DESC_DST:
-		return sizeof(struct hal_ce_srng_dest_desc);
-	case HAL_CE_DESC_DST_STATUS:
-		return sizeof(struct hal_ce_srng_dst_status_desc);
-	}
-
-	return 0;
-}
-
-void ath12k_hal_ce_src_set_desc(struct hal_ce_srng_src_desc *desc, dma_addr_t paddr,
-				u32 len, u32 id, u8 byte_swap_data)
+void ath12k_hal_ce_src_set_desc(struct ath12k_hal *hal,
+				struct hal_ce_srng_src_desc *desc,
+				dma_addr_t paddr, u32 len, u32 id,
+				u8 byte_swap_data)
 {
-	desc->buffer_addr_low = cpu_to_le32(paddr & HAL_ADDR_LSB_REG_MASK);
-	desc->buffer_addr_info =
-		le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
-				 HAL_CE_SRC_DESC_ADDR_INFO_ADDR_HI) |
-		le32_encode_bits(byte_swap_data,
-				 HAL_CE_SRC_DESC_ADDR_INFO_BYTE_SWAP) |
-		le32_encode_bits(0, HAL_CE_SRC_DESC_ADDR_INFO_GATHER) |
-		le32_encode_bits(len, HAL_CE_SRC_DESC_ADDR_INFO_LEN);
-	desc->meta_info = le32_encode_bits(id, HAL_CE_SRC_DESC_META_INFO_DATA);
+	hal->hal_ops->ce_src_set_desc(desc, paddr, len, id, byte_swap_data);
 }
 
-void ath12k_hal_ce_dst_set_desc(struct hal_ce_srng_dest_desc *desc, dma_addr_t paddr)
+void ath12k_hal_ce_dst_set_desc(struct ath12k_hal *hal,
+				struct hal_ce_srng_dest_desc *desc,
+				dma_addr_t paddr)
 {
-	desc->buffer_addr_low = cpu_to_le32(paddr & HAL_ADDR_LSB_REG_MASK);
-	desc->buffer_addr_info =
-		le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
-				 HAL_CE_DEST_DESC_ADDR_INFO_ADDR_HI);
+	hal->hal_ops->ce_dst_set_desc(desc, paddr);
 }
 
 u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc)
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 774322f1f670..74f05aa1fc6d 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1707,6 +1707,12 @@ struct hal_ops {
 					 int ring_num);
 	int (*srng_get_ring_id)(struct ath12k_hal *hal, enum hal_ring_type type,
 				int ring_num, int mac_id);
+	u32 (*ce_get_desc_size)(enum hal_ce_desc type);
+	void (*ce_src_set_desc)(struct hal_ce_srng_src_desc *desc,
+				dma_addr_t paddr, u32 len, u32 id,
+				u8 byte_swap_data);
+	void (*ce_dst_set_desc)(struct hal_ce_srng_dest_desc *desc,
+				dma_addr_t paddr);
 };
 
 u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
@@ -1729,10 +1735,14 @@ dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
 void ath12k_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc, u32 cookie,
 				   dma_addr_t paddr,
 				   enum hal_rx_buf_return_buf_manager rbm);
-u32 ath12k_hal_ce_get_desc_size(enum hal_ce_desc type);
-void ath12k_hal_ce_src_set_desc(struct hal_ce_srng_src_desc *desc, dma_addr_t paddr,
-				u32 len, u32 id, u8 byte_swap_data);
-void ath12k_hal_ce_dst_set_desc(struct hal_ce_srng_dest_desc *desc, dma_addr_t paddr);
+u32 ath12k_hal_ce_get_desc_size(struct ath12k_hal *hal, enum hal_ce_desc type);
+void ath12k_hal_ce_dst_set_desc(struct ath12k_hal *hal,
+				struct hal_ce_srng_dest_desc *desc,
+				dma_addr_t paddr);
+void ath12k_hal_ce_src_set_desc(struct ath12k_hal *hal,
+				struct hal_ce_srng_src_desc *desc,
+				dma_addr_t paddr, u32 len, u32 id,
+				u8 byte_swap_data);
 u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc);
 int ath12k_hal_srng_get_entrysize(struct ath12k_base *ab, u32 ring_type);
 int ath12k_hal_srng_get_max_entries(struct ath12k_base *ab, u32 ring_type);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 565f43a30deb..06a6af8c9c8a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -382,6 +382,20 @@ void ath12k_wifi7_hal_srng_update_hp_tp_addr(struct ath12k_base *ab,
 						   (unsigned long)ab->mem);
 }
 
+u32 ath12k_wifi7_hal_ce_get_desc_size(enum hal_ce_desc type)
+{
+	switch (type) {
+	case HAL_CE_DESC_SRC:
+		return sizeof(struct hal_ce_srng_src_desc);
+	case HAL_CE_DESC_DST:
+		return sizeof(struct hal_ce_srng_dest_desc);
+	case HAL_CE_DESC_DST_STATUS:
+		return sizeof(struct hal_ce_srng_dst_status_desc);
+	}
+
+	return 0;
+}
+
 int ath12k_wifi7_hal_srng_update_shadow_config(struct ath12k_base *ab,
 					       enum hal_ring_type ring_type,
 					       int ring_num)
@@ -419,3 +433,27 @@ int ath12k_wifi7_hal_srng_update_shadow_config(struct ath12k_base *ab,
 
 	return 0;
 }
+
+void ath12k_wifi7_hal_ce_src_set_desc(struct hal_ce_srng_src_desc *desc,
+				      dma_addr_t paddr,
+				      u32 len, u32 id, u8 byte_swap_data)
+{
+	desc->buffer_addr_low = cpu_to_le32(paddr & HAL_ADDR_LSB_REG_MASK);
+	desc->buffer_addr_info =
+		le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
+				 HAL_CE_SRC_DESC_ADDR_INFO_ADDR_HI) |
+		le32_encode_bits(byte_swap_data,
+				 HAL_CE_SRC_DESC_ADDR_INFO_BYTE_SWAP) |
+		le32_encode_bits(0, HAL_CE_SRC_DESC_ADDR_INFO_GATHER) |
+		le32_encode_bits(len, HAL_CE_SRC_DESC_ADDR_INFO_LEN);
+	desc->meta_info = le32_encode_bits(id, HAL_CE_SRC_DESC_META_INFO_DATA);
+}
+
+void ath12k_wifi7_hal_ce_dst_set_desc(struct hal_ce_srng_dest_desc *desc,
+				      dma_addr_t paddr)
+{
+	desc->buffer_addr_low = cpu_to_le32(paddr & HAL_ADDR_LSB_REG_MASK);
+	desc->buffer_addr_info =
+		le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
+				 HAL_CE_DEST_DESC_ADDR_INFO_ADDR_HI);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 1ea7b025ed71..b0b591eb5a0a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -22,4 +22,10 @@ int ath12k_wifi7_hal_srng_update_shadow_config(struct ath12k_base *ab,
 int ath12k_wifi7_hal_srng_get_ring_id(struct ath12k_hal *hal,
 				      enum hal_ring_type type,
 				      int ring_num, int mac_id);
+u32 ath12k_wifi7_hal_ce_get_desc_size(enum hal_ce_desc type);
+void ath12k_wifi7_hal_ce_src_set_desc(struct hal_ce_srng_src_desc *desc,
+				      dma_addr_t paddr,
+				      u32 len, u32 id, u8 byte_swap_data);
+void ath12k_wifi7_hal_ce_dst_set_desc(struct hal_ce_srng_dest_desc *desc,
+				      dma_addr_t paddr);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 92769a525c6d..113a0424d5eb 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1006,5 +1006,8 @@ const struct hal_ops hal_qcn9274_ops = {
 	.set_umac_srng_ptr_addr = ath12k_wifi7_hal_set_umac_srng_ptr_addr,
 	.srng_update_shadow_config = ath12k_wifi7_hal_srng_update_shadow_config,
 	.srng_get_ring_id = ath12k_wifi7_hal_srng_get_ring_id,
+	.ce_get_desc_size = ath12k_wifi7_hal_ce_get_desc_size,
+	.ce_src_set_desc = ath12k_wifi7_hal_ce_src_set_desc,
+	.ce_dst_set_desc = ath12k_wifi7_hal_ce_dst_set_desc,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index a941bb4783ae..60a21137bd35 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -821,5 +821,8 @@ const struct hal_ops hal_wcn7850_ops = {
 	.set_umac_srng_ptr_addr = ath12k_wifi7_hal_set_umac_srng_ptr_addr,
 	.srng_update_shadow_config = ath12k_wifi7_hal_srng_update_shadow_config,
 	.srng_get_ring_id = ath12k_wifi7_hal_srng_get_ring_id,
+	.ce_get_desc_size = ath12k_wifi7_hal_ce_get_desc_size,
+	.ce_src_set_desc = ath12k_wifi7_hal_ce_src_set_desc,
+	.ce_dst_set_desc = ath12k_wifi7_hal_ce_dst_set_desc,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1


