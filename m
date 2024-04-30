Return-Path: <linux-wireless+bounces-7025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1E8B6A07
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70F4B21F84
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 05:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E454B179BE;
	Tue, 30 Apr 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YId8Wkzd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2A17582
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456107; cv=none; b=DW+ac8d67Pz/8B6ExBj+zz0kbhAnEuGUYI/VxcjnJSfI7mYSrvkEI2yN/wuLdDis3ci3K07hduy/wAOYSwFWQb7ib26vXFZeqEN2sWIX/mS6g2Pb6OT9KY10VDlRZMbpQ1uf/l9oq0+z1ZkHNwH49gwefmhMGLzhStPEP+ajgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456107; c=relaxed/simple;
	bh=my6LAO4RjzmdboyaQcPegphlE3youw1X9oSCXeNdvKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx/hbCBdgFeL1ygEgTfHQGdQmwt9XXIDJo05bHw9M5w9nHLa8FG1BbuoB4WtFuIeT5XgP5wmO/Rxzn+fpf5ARbguh9xfNJkaEK57LRqG/Su0ecIrV5LgxDunmEkoO7TnU4l8h4ZPD5TWqX0taryTWBDg5i5E5CcSoKL8CffXSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YId8Wkzd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4043v029533;
	Tue, 30 Apr 2024 05:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=I2fat+875p+NuWF5RGzn9KXsQDTQfzrqKvqBLgWJ8FE=; b=YI
	d8Wkzd30UKY7WPS4gOV8bqZzlIjJbohBQrHqJAV2W6jMo9uvcVNtDPcMgDdS/k3j
	dIlINF1aHUktJjG0GKCg/B6kwXsNoo1/j3xEohYGabWRbGOURqgiHgTiWUNIGv8p
	rG/bnB3TamPgr4am36/HwE0MpeJanWX3GIo6+bq01VKnEbNIATKCVSj8qvaMWFlm
	duH6klvGIUJaahFut6XGhJ5zqs2e49Gz9YwJ+kdtYO4RlQXpWQkNHMnZ6zpBNZ+y
	7jeI5y69gVhNQsTyeRwhFh4nhDko3ixNVBYBwIb0YTp9Ni9QOCBMrED7oxeMm+l0
	pVqqiad+6VaGmkQLMKgw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtg51tdj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U5mGPu011714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:17 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 22:48:15 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/4] wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer manager
Date: Tue, 30 Apr 2024 11:17:56 +0530
Message-ID: <20240430054759.722620-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430054759.722620-1-quic_periyasa@quicinc.com>
References: <20240430054759.722620-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: rN4ex8c0xSWg6irKFOrI2vrwZPiuLlYg
X-Proofpoint-ORIG-GUID: rN4ex8c0xSWg6irKFOrI2vrwZPiuLlYg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 mlxlogscore=719 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300040

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


