Return-Path: <linux-wireless+bounces-7061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7D8B7E0B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A516AB245F2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B33199EBB;
	Tue, 30 Apr 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SDpDRDjB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0A199EBC
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496315; cv=none; b=amgHC6NsPaeK4STqmxDhaw7feSftPUbtfMWY2NxU3n1RbkMRGe/zL7CZ4UXWZnLFqB36EDb2QPw1BFleYOgmV6Pt8YZvtTnlEDKKGytxeNn9adn5zC9dOjv+QVLw7JPxTU0RWPNMn+SqpdGfs744VngveeNKdHbH25n1SyRRiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496315; c=relaxed/simple;
	bh=my6LAO4RjzmdboyaQcPegphlE3youw1X9oSCXeNdvKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psnuIBtvAiAYf5l2/6sthsjHx96lfkhR6snIiwu8vzcSCPWTWCIV64ltSODvmuNcQnRLUHh+3u3/96wnH4SricCYIcokiYMhrwGJT7w4t5E4bWruhEFT2pnCfc6ANXmjsiGwyzyrbxSWxDeUE6Vb6Orxbv9i8ai7wLa9dyc+cck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SDpDRDjB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDm6HS024573;
	Tue, 30 Apr 2024 16:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=I2fat+875p+NuWF5RGzn9KXsQDTQfzrqKvqBLgWJ8FE=; b=SD
	pDRDjBG5my/eSsMBGxbUUI/uB0X7AcEaMb1i6xoGso+vehGf2pioE5PWaOHcr++5
	t0wPj5AIpchuGNmFG5h0eUxjPPD65zLqf0dpcx8xg2piNp0K5qKc+Mq5mMrVwDhf
	gfKHtXmqtw6Z47e13yEGPvAC+I/9QJgEotdRJ/9fXZbLFhEE9HHn5f3DVNiOnmVq
	AIPYiI5JyWy50CsQnu0mqALV8E6/GnyXbBsC6Jgnh8Sml1REy0k32ZJBH1s5gy/O
	HFqhfeoVKyYKLGOA7up45eScyiRMyFtx19NHtG+66btQ0hu/NaMz2VqfOpJA5m1c
	LN59w4b0EZmxV7EOY/UA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtvf7hd8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UGwUE6013191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:30 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 09:58:28 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 1/4] wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer manager
Date: Tue, 30 Apr 2024 22:28:08 +0530
Message-ID: <20240430165811.1377182-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aV4z3rtSRml0b3geg7me76twQ3vKiaS8
X-Proofpoint-ORIG-GUID: aV4z3rtSRml0b3geg7me76twQ3vKiaS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=719 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300121

Prefer the term "device" over "chip". Therefore, modify the relavant terms
in hal Rx return buffer manager to use "device" instead.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c |  4 ++--
 drivers/net/wireless/ath/ath12k/hal.h   | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 75df622f25d8..fc4b95324955 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3071,7 +3071,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 
 	ath12k_hal_rx_buf_addr_info_set(&reo_ent_ring->buf_addr_info, link_paddr,
 					cookie,
-					HAL_RX_BUF_RBM_WBM_CHIP0_IDLE_DESC_LIST);
+					HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST);
 
 	mpdu_info = u32_encode_bits(1, RX_MPDU_DESC_INFO0_MSDU_COUNT) |
 		    u32_encode_bits(0, RX_MPDU_DESC_INFO0_FRAG_FLAG) |
@@ -3451,7 +3451,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			       (paddr - link_desc_banks[desc_bank].paddr);
 		ath12k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
-		if (rbm != HAL_RX_BUF_RBM_WBM_CHIP0_IDLE_DESC_LIST &&
+		if (rbm != HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
 		    rbm != ab->hw_params->hal_params->rx_buf_rbm) {
 			ab->soc_stats.invalid_rbm++;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index dbb9205bfa10..f364b2938ef8 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -770,12 +770,12 @@ struct hal_srng_config {
  * enum hal_rx_buf_return_buf_manager - manager for returned rx buffers
  *
  * @HAL_RX_BUF_RBM_WBM_IDLE_BUF_LIST: Buffer returned to WBM idle buffer list
- * @HAL_RX_BUF_RBM_WBM_CHIP0_IDLE_DESC_LIST: Descriptor returned to WBM idle
- *	descriptor list, where the chip 0 WBM is chosen in case of a multi-chip config
- * @HAL_RX_BUF_RBM_WBM_CHIP1_IDLE_DESC_LIST: Descriptor returned to WBM idle
- *	descriptor list, where the chip 1 WBM is chosen in case of a multi-chip config
- * @HAL_RX_BUF_RBM_WBM_CHIP2_IDLE_DESC_LIST: Descriptor returned to WBM idle
- *	descriptor list, where the chip 2 WBM is chosen in case of a multi-chip config
+ * @HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST: Descriptor returned to WBM idle
+ *	descriptor list, where the device 0 WBM is chosen in case of a multi-device config
+ * @HAL_RX_BUF_RBM_WBM_DEV1_IDLE_DESC_LIST: Descriptor returned to WBM idle
+ *	descriptor list, where the device 1 WBM is chosen in case of a multi-device config
+ * @HAL_RX_BUF_RBM_WBM_DEV2_IDLE_DESC_LIST: Descriptor returned to WBM idle
+ *	descriptor list, where the device 2 WBM is chosen in case of a multi-device config
  * @HAL_RX_BUF_RBM_FW_BM: Buffer returned to FW
  * @HAL_RX_BUF_RBM_SW0_BM: For ring 0 -- returned to host
  * @HAL_RX_BUF_RBM_SW1_BM: For ring 1 -- returned to host
@@ -788,9 +788,9 @@ struct hal_srng_config {
 
 enum hal_rx_buf_return_buf_manager {
 	HAL_RX_BUF_RBM_WBM_IDLE_BUF_LIST,
-	HAL_RX_BUF_RBM_WBM_CHIP0_IDLE_DESC_LIST,
-	HAL_RX_BUF_RBM_WBM_CHIP1_IDLE_DESC_LIST,
-	HAL_RX_BUF_RBM_WBM_CHIP2_IDLE_DESC_LIST,
+	HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST,
+	HAL_RX_BUF_RBM_WBM_DEV1_IDLE_DESC_LIST,
+	HAL_RX_BUF_RBM_WBM_DEV2_IDLE_DESC_LIST,
 	HAL_RX_BUF_RBM_FW_BM,
 	HAL_RX_BUF_RBM_SW0_BM,
 	HAL_RX_BUF_RBM_SW1_BM,
-- 
2.34.1


