Return-Path: <linux-wireless+bounces-27903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A213BC8B50
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41DC3ACD9B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C62DE715;
	Thu,  9 Oct 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dt/XCzJL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303D2DFF33
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008273; cv=none; b=kvVEEnihNNfEYgNo5UYOiDNcBVLDSWq8Ra/r1dI3PoIH54c9k/AfqbDReUgdxqsrYBJdYLtwm8FRPxf1ly+ePNRLJdLxH+P7grloG5+ABeB+wzDzTc/luATjPIG9Np6n/qHJUSufvkE/wy8cqDV7RNoNx17MRfJX0UjNXk0zYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008273; c=relaxed/simple;
	bh=d3ia7dF2FtH6LxknVOmydIOJzof0C8ow+V1ohcw9yxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIBJz03dpBU4x7ZORagIeMxkDks7m9sp8gvqH/GrNFG9tcw9LMVDVOYYvjG9vQUFf7HGzIlj0PckwC+gzDp/Fhop2IoEymmAyCbZVhtjw+EVDCvUEWUmruN/BIXRvlLpNk1yYKh0TYf8eBNrjvu1PUt2rqDqFva4zx3/MgYRTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dt/XCzJL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EW0g022397;
	Thu, 9 Oct 2025 11:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Mwv3bPauVMvd/Z3VqFGO9zkISjCoiQw96Qw+h0efNw=; b=Dt/XCzJLNqJRgt4R
	D86IggYSBrN6i2sZ/7vC/Rj1gS9GUVRrNwEuIwdHDP1Hd5zOcaPJm0161yxwMHTR
	vcRxIYfU/XyFUdL1XdW5JTtVRYmyJ70TVD74DNVXvtrkoTVbZv1TCwqq1acGxJo4
	8PWe8WTuwDBR1QwrnjvhcjqWSrsTko8Xp4iyfI+a75e3xLt9jw3SFaq3ecWMGNT+
	Q8IUreLrB5v5SaiJWCB3UFYJofkaORBE+UiOqCM2Um3YejFgiHwTcbl7xAHaAzp3
	pHG3gNwiMOnjKhCyp702qK9d/mVq/2HqNfWIK1c/a1CBLr7PCiw5oGrxgalguW0f
	/W6mgw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4sjgqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BB3DG024460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:03 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:01 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 01/18] wifi: ath12k: Move srng config and hal_ops to hw specific hal files
Date: Thu, 9 Oct 2025 16:40:28 +0530
Message-ID: <20251009111045.1763001-2-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: HJPDUQsXIs_r0JNVH-FDd1RK-b6ixf3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6hvINGlDCXJ1
 ZEpbyACCLmGIHtYF7IBvxcEkKc3H5nTGshrvcrX5MXAoqTYUpBo3C+WrO5YsE/Czb+jjkARtZqq
 6KGEzBnWsSjhScrMNtUz/wFZgTEaoJpSWFgusociHupsFfBPByc8MkCZLirIn/4cC+L0maiH+mB
 xeb8l58snum/KSKmQEWuikNyxw+Qyoy5r2Fo6l/L+9FtVSSkXELxGy7WcePXz3cLkV7e69uBauj
 vMzzzt7sxshg3F7dlD8YPH7zF6oYbUgdi9T01yzxVLG2tamQyq+rr2+FSmC8k8jjhK9QFx/Q4rV
 ozRCUxFpEIrxJe/92dnY/lFjc8EvTkUWC734RwiGxvjUZdDb+3CkcDkdNUJon2Rp8jYrawgslmj
 Cid4eI4y1AfmqxiopOsaoIlB5CfE0Q==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e79848 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=MZz_AWUFgOkbOCpWNt8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HJPDUQsXIs_r0JNVH-FDd1RK-b6ixf3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move srng config and hal_ops from common hal file to
hw specific hal files, since these implementations are
specific and configurable for each hardware

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c         | 474 +-----------------
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 329 ++++++++++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   3 +
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 344 +++++++++++++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |   3 +
 5 files changed, 681 insertions(+), 472 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a14a7d8dc69f..4ff906854970 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -12,210 +12,7 @@
 #include "wifi7/hal_qcn9274.h"
 #include "wifi7/hal_wcn7850.h"
 
-static const struct hal_srng_config hw_srng_config_template[] = {
-	/* TODO: max_rings can populated by querying HW capabilities */
-	[HAL_REO_DST] = {
-		.start_ring_id = HAL_SRNG_RING_ID_REO2SW1,
-		.max_rings = 8,
-		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_REO_REO2SW1_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_REO_EXCEPTION] = {
-		/* Designating REO2SW0 ring as exception ring.
-		 * Any of theREO2SW rings can be used as exception ring.
-		 */
-		.start_ring_id = HAL_SRNG_RING_ID_REO2SW0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_REO_REO2SW0_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_REO_REINJECT] = {
-		.start_ring_id = HAL_SRNG_RING_ID_SW2REO,
-		.max_rings = 4,
-		.entry_size = sizeof(struct hal_reo_entrance_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_REO_SW2REO_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_REO_CMD] = {
-		.start_ring_id = HAL_SRNG_RING_ID_REO_CMD,
-		.max_rings = 1,
-		.entry_size = (sizeof(struct hal_tlv_64_hdr) +
-			sizeof(struct hal_reo_get_queue_stats)) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_REO_CMD_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_REO_STATUS] = {
-		.start_ring_id = HAL_SRNG_RING_ID_REO_STATUS,
-		.max_rings = 1,
-		.entry_size = (sizeof(struct hal_tlv_64_hdr) +
-			sizeof(struct hal_reo_get_queue_stats_status)) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_REO_STATUS_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_TCL_DATA] = {
-		.start_ring_id = HAL_SRNG_RING_ID_SW2TCL1,
-		.max_rings = 6,
-		.entry_size = sizeof(struct hal_tcl_data_cmd) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_TCL_CMD] = {
-		.start_ring_id = HAL_SRNG_RING_ID_SW2TCL_CMD,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_tcl_gse_cmd) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_SW2TCL1_CMD_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_TCL_STATUS] = {
-		.start_ring_id = HAL_SRNG_RING_ID_TCL_STATUS,
-		.max_rings = 1,
-		.entry_size = (sizeof(struct hal_tlv_hdr) +
-			     sizeof(struct hal_tcl_status_ring)) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_TCL_STATUS_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_CE_SRC] = {
-		.start_ring_id = HAL_SRNG_RING_ID_CE0_SRC,
-		.max_rings = 16,
-		.entry_size = sizeof(struct hal_ce_srng_src_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_CE_SRC_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_CE_DST] = {
-		.start_ring_id = HAL_SRNG_RING_ID_CE0_DST,
-		.max_rings = 16,
-		.entry_size = sizeof(struct hal_ce_srng_dest_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_CE_DST_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_CE_DST_STATUS] = {
-		.start_ring_id = HAL_SRNG_RING_ID_CE0_DST_STATUS,
-		.max_rings = 16,
-		.entry_size = sizeof(struct hal_ce_srng_dst_status_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_CE_DST_STATUS_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_WBM_IDLE_LINK] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WBM_IDLE_LINK,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_wbm_link_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_WBM_IDLE_LINK_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_SW2WBM_RELEASE] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WBM_SW0_RELEASE,
-		.max_rings = 2,
-		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_SW2WBM_RELEASE_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_WBM2SW_RELEASE] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WBM2SW0_RELEASE,
-		.max_rings = 8,
-		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_UMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_RXDMA_BUF] = {
-		.start_ring_id = HAL_SRNG_SW2RXDMA_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_wbm_buffer_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_DMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_RXDMA_DST] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_RXDMA2SW0,
-		.max_rings = 0,
-		.entry_size = 0,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_RXDMA_MONITOR_BUF] = {
-		.start_ring_id = HAL_SRNG_SW2RXMON_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_RXDMA_MONITOR_STATUS] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_STATBUF,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_wbm_buffer_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_RXDMA_MONITOR_DESC] = { 0, },
-	[HAL_RXDMA_DIR_BUF] = {
-		.start_ring_id = HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
-		.max_rings = 2,
-		.entry_size = 8 >> 2, /* TODO: Define the struct */
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_PPE2TCL] = {
-		.start_ring_id = HAL_SRNG_RING_ID_PPE2TCL1,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_tcl_entrance_from_ppe_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_PPE_RELEASE] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WBM_PPE_RELEASE,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_WBM2PPE_RELEASE_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_TX_MONITOR_BUF] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_RXDMA_MONITOR_DST] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXMON_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_TX_MONITOR_DST] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_TXMON2SW0_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	}
-};
-
-static const struct ath12k_hal_tcl_to_wbm_rbm_map
+const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_qcn9274_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX] = {
 	{
 		.wbm_ring_num = 0,
@@ -235,7 +32,7 @@ ath12k_hal_qcn9274_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX] = {
 	}
 };
 
-static const struct ath12k_hal_tcl_to_wbm_rbm_map
+const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_wcn7850_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX] = {
 	{
 		.wbm_ring_num = 0,
@@ -296,273 +93,6 @@ static unsigned int ath12k_hal_reo1_ring_misc_offset(struct ath12k_base *ab)
 	return HAL_REO1_RING_MISC(ab) - HAL_REO1_RING_BASE_LSB(ab);
 }
 
-static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
-{
-	struct ath12k_hal *hal = &ab->hal;
-	struct hal_srng_config *s;
-
-	hal->srng_config = kmemdup(hw_srng_config_template,
-				   sizeof(hw_srng_config_template),
-				   GFP_KERNEL);
-	if (!hal->srng_config)
-		return -ENOMEM;
-
-	s = &hal->srng_config[HAL_REO_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
-	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
-
-	s = &hal->srng_config[HAL_REO_EXCEPTION];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_HP;
-
-	s = &hal->srng_config[HAL_REO_REINJECT];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
-	s->reg_size[0] = HAL_SW2REO1_RING_BASE_LSB(ab) - HAL_SW2REO_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_SW2REO1_RING_HP - HAL_SW2REO_RING_HP;
-
-	s = &hal->srng_config[HAL_REO_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
-
-	s = &hal->srng_config[HAL_REO_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
-
-	s = &hal->srng_config[HAL_TCL_DATA];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
-
-	s = &hal->srng_config[HAL_TCL_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
-
-	s = &hal->srng_config[HAL_TCL_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
-
-	s = &hal->srng_config[HAL_CE_SRC];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
-
-	s = &hal->srng_config[HAL_CE_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-
-	s = &hal->srng_config[HAL_CE_DST_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
-		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-
-	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP;
-
-	s = &hal->srng_config[HAL_SW2WBM_RELEASE];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
-		HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_SW_RELEASE_RING_HP;
-	s->reg_size[0] = HAL_WBM_SW1_RELEASE_RING_BASE_LSB(ab) -
-			 HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_WBM_SW1_RELEASE_RING_HP - HAL_WBM_SW_RELEASE_RING_HP;
-
-	s = &hal->srng_config[HAL_WBM2SW_RELEASE];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP;
-	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(ab) -
-		HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP;
-
-	/* Some LMAC rings are not accessed from the host:
-	 * RXDMA_BUG, RXDMA_DST, RXDMA_MONITOR_BUF, RXDMA_MONITOR_STATUS,
-	 * RXDMA_MONITOR_DST, RXDMA_MONITOR_DESC, RXDMA_DIR_BUF_SRC,
-	 * RXDMA_RX_MONITOR_BUF, TX_MONITOR_BUF, TX_MONITOR_DST, SW2RXDMA
-	 */
-	s = &hal->srng_config[HAL_PPE2TCL];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_PPE2TCL1_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_PPE2TCL1_RING_HP;
-
-	s = &hal->srng_config[HAL_PPE_RELEASE];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
-				HAL_WBM_PPE_RELEASE_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_PPE_RELEASE_RING_HP;
-
-	return 0;
-}
-
-const struct hal_ops hal_qcn9274_ops = {
-	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
-	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
-	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcn9274,
-	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcn9274,
-	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcn9274,
-	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcn9274,
-	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
-	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcn9274,
-	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
-	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
-	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
-	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
-};
-EXPORT_SYMBOL(hal_qcn9274_ops);
-
-static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
-{
-	struct ath12k_hal *hal = &ab->hal;
-	struct hal_srng_config *s;
-
-	hal->srng_config = kmemdup(hw_srng_config_template,
-				   sizeof(hw_srng_config_template),
-				   GFP_KERNEL);
-	if (!hal->srng_config)
-		return -ENOMEM;
-
-	s = &hal->srng_config[HAL_REO_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
-	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
-
-	s = &hal->srng_config[HAL_REO_EXCEPTION];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_HP;
-
-	s = &hal->srng_config[HAL_REO_REINJECT];
-	s->max_rings = 1;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
-
-	s = &hal->srng_config[HAL_REO_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
-
-	s = &hal->srng_config[HAL_REO_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
-
-	s = &hal->srng_config[HAL_TCL_DATA];
-	s->max_rings = 5;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
-
-	s = &hal->srng_config[HAL_TCL_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
-
-	s = &hal->srng_config[HAL_TCL_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
-
-	s = &hal->srng_config[HAL_CE_SRC];
-	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
-
-	s = &hal->srng_config[HAL_CE_DST];
-	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-
-	s = &hal->srng_config[HAL_CE_DST_STATUS];
-	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
-		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-
-	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP;
-
-	s = &hal->srng_config[HAL_SW2WBM_RELEASE];
-	s->max_rings = 1;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
-		HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_SW_RELEASE_RING_HP;
-
-	s = &hal->srng_config[HAL_WBM2SW_RELEASE];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP;
-	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(ab) -
-		HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
-	s->reg_size[1] = HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP;
-
-	s = &hal->srng_config[HAL_RXDMA_BUF];
-	s->max_rings = 2;
-	s->mac_type = ATH12K_HAL_SRNG_PMAC;
-
-	s = &hal->srng_config[HAL_RXDMA_DST];
-	s->max_rings = 1;
-	s->entry_size = sizeof(struct hal_reo_entrance_ring) >> 2;
-
-	/* below rings are not used */
-	s = &hal->srng_config[HAL_RXDMA_DIR_BUF];
-	s->max_rings = 0;
-
-	s = &hal->srng_config[HAL_PPE2TCL];
-	s->max_rings = 0;
-
-	s = &hal->srng_config[HAL_PPE_RELEASE];
-	s->max_rings = 0;
-
-	s = &hal->srng_config[HAL_TX_MONITOR_BUF];
-	s->max_rings = 0;
-
-	s = &hal->srng_config[HAL_TX_MONITOR_DST];
-	s->max_rings = 0;
-
-	s = &hal->srng_config[HAL_PPE2TCL];
-	s->max_rings = 0;
-
-	return 0;
-}
-
-const struct hal_ops hal_wcn7850_ops = {
-	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
-	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
-	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
-	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_wcn7850,
-	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_wcn7850,
-	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_wcn7850,
-	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
-	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_wcn7850,
-	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
-	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
-	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
-	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
-	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
-};
-EXPORT_SYMBOL(hal_wcn7850_ops);
-
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 2e84c830d9b2..c98ffc991ad8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -6,6 +6,209 @@
 #include "hal_desc.h"
 #include "hal_qcn9274.h"
 
+static const struct hal_srng_config hw_srng_config_template[] = {
+	/* TODO: max_rings can populated by querying HW capabilities */
+	[HAL_REO_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_REO2SW1,
+		.max_rings = 8,
+		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_REO_REO2SW1_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_EXCEPTION] = {
+		/* Designating REO2SW0 ring as exception ring.
+		 * Any of theREO2SW rings can be used as exception ring.
+		 */
+		.start_ring_id = HAL_SRNG_RING_ID_REO2SW0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_REO_REO2SW0_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_REINJECT] = {
+		.start_ring_id = HAL_SRNG_RING_ID_SW2REO,
+		.max_rings = 4,
+		.entry_size = sizeof(struct hal_reo_entrance_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_REO_SW2REO_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_CMD] = {
+		.start_ring_id = HAL_SRNG_RING_ID_REO_CMD,
+		.max_rings = 1,
+		.entry_size = (sizeof(struct hal_tlv_64_hdr) +
+			sizeof(struct hal_reo_get_queue_stats)) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_REO_CMD_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_REO_STATUS,
+		.max_rings = 1,
+		.entry_size = (sizeof(struct hal_tlv_64_hdr) +
+			sizeof(struct hal_reo_get_queue_stats_status)) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_REO_STATUS_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TCL_DATA] = {
+		.start_ring_id = HAL_SRNG_RING_ID_SW2TCL1,
+		.max_rings = 6,
+		.entry_size = sizeof(struct hal_tcl_data_cmd) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TCL_CMD] = {
+		.start_ring_id = HAL_SRNG_RING_ID_SW2TCL_CMD,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_tcl_gse_cmd) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2TCL1_CMD_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TCL_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_TCL_STATUS,
+		.max_rings = 1,
+		.entry_size = (sizeof(struct hal_tlv_hdr) +
+			     sizeof(struct hal_tcl_status_ring)) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_TCL_STATUS_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_CE_SRC] = {
+		.start_ring_id = HAL_SRNG_RING_ID_CE0_SRC,
+		.max_rings = 16,
+		.entry_size = sizeof(struct hal_ce_srng_src_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_CE_SRC_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_CE_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_CE0_DST,
+		.max_rings = 16,
+		.entry_size = sizeof(struct hal_ce_srng_dest_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_CE_DST_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_CE_DST_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_CE0_DST_STATUS,
+		.max_rings = 16,
+		.entry_size = sizeof(struct hal_ce_srng_dst_status_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_CE_DST_STATUS_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_WBM_IDLE_LINK] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM_IDLE_LINK,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_link_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_WBM_IDLE_LINK_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_SW2WBM_RELEASE] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM_SW0_RELEASE,
+		.max_rings = 2,
+		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2WBM_RELEASE_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_WBM2SW_RELEASE] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM2SW0_RELEASE,
+		.max_rings = 8,
+		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_RXDMA_BUF] = {
+		.start_ring_id = HAL_SRNG_SW2RXDMA_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_buffer_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_DMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_RXDMA2SW0,
+		.max_rings = 0,
+		.entry_size = 0,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_BUF] = {
+		.start_ring_id = HAL_SRNG_SW2RXMON_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_STATBUF,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_buffer_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_DESC] = { 0, },
+	[HAL_RXDMA_DIR_BUF] = {
+		.start_ring_id = HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
+		.max_rings = 2,
+		.entry_size = 8 >> 2, /* TODO: Define the struct */
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_PPE2TCL] = {
+		.start_ring_id = HAL_SRNG_RING_ID_PPE2TCL1,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_tcl_entrance_from_ppe_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_PPE_RELEASE] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM_PPE_RELEASE,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_WBM2PPE_RELEASE_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TX_MONITOR_BUF] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXMON_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_TX_MONITOR_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_TXMON2SW0_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	}
+};
+
 static inline
 bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc)
 {
@@ -367,3 +570,129 @@ void ath12k_hal_extract_rx_desc_data_qcn9274(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->is_decrypted = ath12k_hal_rx_h_is_decrypted_qcn9274(rx_desc);
 	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_qcn9274(rx_desc);
 }
+
+static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
+{
+	struct ath12k_hal *hal = &ab->hal;
+	struct hal_srng_config *s;
+
+	hal->srng_config = kmemdup(hw_srng_config_template,
+				   sizeof(hw_srng_config_template),
+				   GFP_KERNEL);
+	if (!hal->srng_config)
+		return -ENOMEM;
+
+	s = &hal->srng_config[HAL_REO_DST];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
+	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_EXCEPTION];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_REINJECT];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
+	s->reg_size[0] = HAL_SW2REO1_RING_BASE_LSB(ab) - HAL_SW2REO_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_SW2REO1_RING_HP - HAL_SW2REO_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_CMD];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
+
+	s = &hal->srng_config[HAL_REO_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
+
+	s = &hal->srng_config[HAL_TCL_DATA];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
+
+	s = &hal->srng_config[HAL_TCL_CMD];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
+
+	s = &hal->srng_config[HAL_TCL_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
+
+	s = &hal->srng_config[HAL_CE_SRC];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+
+	s = &hal->srng_config[HAL_CE_DST];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+
+	s = &hal->srng_config[HAL_CE_DST_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
+		HAL_CE_DST_STATUS_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+
+	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP;
+
+	s = &hal->srng_config[HAL_SW2WBM_RELEASE];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
+		HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_SW_RELEASE_RING_HP;
+	s->reg_size[0] = HAL_WBM_SW1_RELEASE_RING_BASE_LSB(ab) -
+			 HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_WBM_SW1_RELEASE_RING_HP - HAL_WBM_SW_RELEASE_RING_HP;
+
+	s = &hal->srng_config[HAL_WBM2SW_RELEASE];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP;
+	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(ab) -
+		HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP;
+
+	/* Some LMAC rings are not accessed from the host:
+	 * RXDMA_BUG, RXDMA_DST, RXDMA_MONITOR_BUF, RXDMA_MONITOR_STATUS,
+	 * RXDMA_MONITOR_DST, RXDMA_MONITOR_DESC, RXDMA_DIR_BUF_SRC,
+	 * RXDMA_RX_MONITOR_BUF, TX_MONITOR_BUF, TX_MONITOR_DST, SW2RXDMA
+	 */
+	s = &hal->srng_config[HAL_PPE2TCL];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_PPE2TCL1_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_PPE2TCL1_RING_HP;
+
+	s = &hal->srng_config[HAL_PPE_RELEASE];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
+				HAL_WBM_PPE_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_PPE_RELEASE_RING_HP;
+
+	return 0;
+}
+
+const struct hal_ops hal_qcn9274_ops = {
+	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
+	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
+	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcn9274,
+	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcn9274,
+	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcn9274,
+	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcn9274,
+	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
+	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcn9274,
+	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
+	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
+	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
+};
+EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index 9a918824e093..1563854b5b6a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -12,6 +12,9 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
+extern const struct ath12k_hal_tcl_to_wbm_rbm_map
+ath12k_hal_qcn9274_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX];
+
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_qcn9274(struct hal_rx_desc *fdesc,
 					     struct hal_rx_desc *ldesc);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 0fa1d9fad2e1..2e88ac0ae797 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -7,6 +7,209 @@
 #include "hal_desc.h"
 #include "hal_wcn7850.h"
 
+static const struct hal_srng_config hw_srng_config_template[] = {
+	/* TODO: max_rings can populated by querying HW capabilities */
+	[HAL_REO_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_REO2SW1,
+		.max_rings = 8,
+		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_REO_REO2SW1_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_EXCEPTION] = {
+		/* Designating REO2SW0 ring as exception ring.
+		 * Any of theREO2SW rings can be used as exception ring.
+		 */
+		.start_ring_id = HAL_SRNG_RING_ID_REO2SW0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_REO_REO2SW0_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_REINJECT] = {
+		.start_ring_id = HAL_SRNG_RING_ID_SW2REO,
+		.max_rings = 4,
+		.entry_size = sizeof(struct hal_reo_entrance_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_REO_SW2REO_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_CMD] = {
+		.start_ring_id = HAL_SRNG_RING_ID_REO_CMD,
+		.max_rings = 1,
+		.entry_size = (sizeof(struct hal_tlv_64_hdr) +
+			sizeof(struct hal_reo_get_queue_stats)) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_REO_CMD_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_REO_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_REO_STATUS,
+		.max_rings = 1,
+		.entry_size = (sizeof(struct hal_tlv_64_hdr) +
+			sizeof(struct hal_reo_get_queue_stats_status)) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_REO_STATUS_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TCL_DATA] = {
+		.start_ring_id = HAL_SRNG_RING_ID_SW2TCL1,
+		.max_rings = 6,
+		.entry_size = sizeof(struct hal_tcl_data_cmd) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TCL_CMD] = {
+		.start_ring_id = HAL_SRNG_RING_ID_SW2TCL_CMD,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_tcl_gse_cmd) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2TCL1_CMD_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TCL_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_TCL_STATUS,
+		.max_rings = 1,
+		.entry_size = (sizeof(struct hal_tlv_hdr) +
+			     sizeof(struct hal_tcl_status_ring)) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_TCL_STATUS_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_CE_SRC] = {
+		.start_ring_id = HAL_SRNG_RING_ID_CE0_SRC,
+		.max_rings = 16,
+		.entry_size = sizeof(struct hal_ce_srng_src_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_CE_SRC_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_CE_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_CE0_DST,
+		.max_rings = 16,
+		.entry_size = sizeof(struct hal_ce_srng_dest_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_CE_DST_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_CE_DST_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_CE0_DST_STATUS,
+		.max_rings = 16,
+		.entry_size = sizeof(struct hal_ce_srng_dst_status_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_CE_DST_STATUS_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_WBM_IDLE_LINK] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM_IDLE_LINK,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_link_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_WBM_IDLE_LINK_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_SW2WBM_RELEASE] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM_SW0_RELEASE,
+		.max_rings = 2,
+		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2WBM_RELEASE_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_WBM2SW_RELEASE] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM2SW0_RELEASE,
+		.max_rings = 8,
+		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_UMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_RXDMA_BUF] = {
+		.start_ring_id = HAL_SRNG_SW2RXDMA_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_buffer_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_DMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_RXDMA2SW0,
+		.max_rings = 0,
+		.entry_size = 0,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_BUF] = {
+		.start_ring_id = HAL_SRNG_SW2RXMON_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_STATUS] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_STATBUF,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_buffer_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_DESC] = { 0, },
+	[HAL_RXDMA_DIR_BUF] = {
+		.start_ring_id = HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
+		.max_rings = 2,
+		.entry_size = 8 >> 2, /* TODO: Define the struct */
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_PPE2TCL] = {
+		.start_ring_id = HAL_SRNG_RING_ID_PPE2TCL1,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_tcl_entrance_from_ppe_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_PPE_RELEASE] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WBM_PPE_RELEASE,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_WBM2PPE_RELEASE_RING_BASE_MSB_RING_SIZE,
+	},
+	[HAL_TX_MONITOR_BUF] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_SRC,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_RXDMA_MONITOR_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXMON_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	},
+	[HAL_TX_MONITOR_DST] = {
+		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_TXMON2SW0_BUF0,
+		.max_rings = 1,
+		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
+		.mac_type = ATH12K_HAL_SRNG_PMAC,
+		.ring_dir = HAL_SRNG_DIR_DST,
+		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
+	}
+};
+
 static inline
 bool ath12k_hal_rx_desc_get_first_msdu_wcn7850(struct hal_rx_desc *desc)
 {
@@ -362,3 +565,144 @@ void ath12k_hal_extract_rx_desc_data_wcn7850(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->is_decrypted = ath12k_hal_rx_h_is_decrypted_wcn7850(rx_desc);
 	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_wcn7850(rx_desc);
 }
+
+static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
+{
+	struct ath12k_hal *hal = &ab->hal;
+	struct hal_srng_config *s;
+
+	hal->srng_config = kmemdup(hw_srng_config_template,
+				   sizeof(hw_srng_config_template),
+				   GFP_KERNEL);
+	if (!hal->srng_config)
+		return -ENOMEM;
+
+	s = &hal->srng_config[HAL_REO_DST];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
+	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_EXCEPTION];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_REINJECT];
+	s->max_rings = 1;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_CMD];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
+
+	s = &hal->srng_config[HAL_REO_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
+
+	s = &hal->srng_config[HAL_TCL_DATA];
+	s->max_rings = 5;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
+
+	s = &hal->srng_config[HAL_TCL_CMD];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
+
+	s = &hal->srng_config[HAL_TCL_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
+
+	s = &hal->srng_config[HAL_CE_SRC];
+	s->max_rings = 12;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+
+	s = &hal->srng_config[HAL_CE_DST];
+	s->max_rings = 12;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+
+	s = &hal->srng_config[HAL_CE_DST_STATUS];
+	s->max_rings = 12;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
+		HAL_CE_DST_STATUS_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+
+	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP;
+
+	s = &hal->srng_config[HAL_SW2WBM_RELEASE];
+	s->max_rings = 1;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
+		HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_SW_RELEASE_RING_HP;
+
+	s = &hal->srng_config[HAL_WBM2SW_RELEASE];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP;
+	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(ab) -
+		HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP;
+
+	s = &hal->srng_config[HAL_RXDMA_BUF];
+	s->max_rings = 2;
+	s->mac_type = ATH12K_HAL_SRNG_PMAC;
+
+	s = &hal->srng_config[HAL_RXDMA_DST];
+	s->max_rings = 1;
+	s->entry_size = sizeof(struct hal_reo_entrance_ring) >> 2;
+
+	/* below rings are not used */
+	s = &hal->srng_config[HAL_RXDMA_DIR_BUF];
+	s->max_rings = 0;
+
+	s = &hal->srng_config[HAL_PPE2TCL];
+	s->max_rings = 0;
+
+	s = &hal->srng_config[HAL_PPE_RELEASE];
+	s->max_rings = 0;
+
+	s = &hal->srng_config[HAL_TX_MONITOR_BUF];
+	s->max_rings = 0;
+
+	s = &hal->srng_config[HAL_TX_MONITOR_DST];
+	s->max_rings = 0;
+
+	s = &hal->srng_config[HAL_PPE2TCL];
+	s->max_rings = 0;
+
+	return 0;
+}
+
+const struct hal_ops hal_wcn7850_ops = {
+	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
+	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
+	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
+	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_wcn7850,
+	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_wcn7850,
+	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_wcn7850,
+	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
+	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_wcn7850,
+	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
+	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
+	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
+	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
+};
+EXPORT_SYMBOL(hal_wcn7850_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index a90978b2a454..80de7ea522b5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -10,6 +10,9 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
+extern const struct ath12k_hal_tcl_to_wbm_rbm_map
+ath12k_hal_wcn7850_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX];
+
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_wcn7850(struct hal_rx_desc *fdesc,
 					     struct hal_rx_desc *ldesc);
-- 
2.34.1


