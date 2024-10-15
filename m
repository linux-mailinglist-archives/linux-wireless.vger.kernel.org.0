Return-Path: <linux-wireless+bounces-13985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FAC99F548
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946AFB21752
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91822913B;
	Tue, 15 Oct 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZC+Q5g6h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701E229126;
	Tue, 15 Oct 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016863; cv=none; b=W3Febg9mNyQRe4osLWEPNV9sdnDwgOj9Zy7Hpex/h/JsWvVY6jPTfGjuvfUAd3yY23H1FcyMOTPhBIsv8AfGVXm4v53vYJaz/rYJNbGw7IQFaKAdTsUf3kBSwJg6Yv+V9ZjWgAy8SQpnGwy0Ay4UHoH/csWn86mZArIlvVFJY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016863; c=relaxed/simple;
	bh=16CgJTdkkxHyDw7zfCBnlZHL8BJK0CdBQjTBOku6mVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6Y4uBhNgoDC0797xxHOTliMVet3eykqE1/d+hfoP1XHcnTJcw6by5J0p0WCuA2bCGmcAkyRMGganxJP1M2CJax3Hwit5xjG+dfhWm+RY8zHkZT9HzAJrDh2Lf3EDp8uOr+dP1+wqqzPMjJXSQ4PcCVGq6j0p0dhDK70LSYpGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZC+Q5g6h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FG0sf7022433;
	Tue, 15 Oct 2024 18:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gDAJOB6eY5UsXxzVE60+4YZEEY2ikHHvYPUjl6bPW24=; b=ZC+Q5g6h6g/j9qtx
	yfFMJzXU/pFEr34yHpZ+ZhQO4BQR87BoLMrI71BkWoYVwCHFvzT+kcQsSWRhFB0Q
	nQPSlR3a5Pz6Ov+Qv1DS16M0+xgP3nKX8Y8olpOfLg4zGx26XmXPbQlTTe7H8rZn
	XPKMDtIQlc7SE0wwxA4ZeAE9Pp1W4nCbfhC1lSAGacwnyl6GZrYhhb4ditbH8t3b
	/RCSQAVDTtOFnO2yqWoShaMXW1DeuqjuLNmf2Ug/0g7tFPi6HC3pq/YhK9ldD5TF
	GpwTKBJACa/q2Rk5Wqs3Gql2k+BMZzYmRpPOgpM46MMIQQ8QCRIpxBLoJzfzlQl8
	5F0gKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429jrfa2sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:27:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FIRX1s007101
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:27:33 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:27:29 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 04/22] wifi: ath12k: refactor ath12k_hw_regs structure
Date: Tue, 15 Oct 2024 23:56:19 +0530
Message-ID: <20241015182637.955753-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3XrPbQ6HQzqLAHWPiTBdfRPL9Xl2feWL
X-Proofpoint-ORIG-GUID: 3XrPbQ6HQzqLAHWPiTBdfRPL9Xl2feWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

From: P Praneesh <quic_ppranees@quicinc.com>

IPQ5332 device have different register address values for the below
registers:

HAL_TCL1_RING_BASE_LSB
HAL_TCL1_RING_BASE_MSB
HAL_TCL2_RING_BASE_LSB

HAL_SEQ_WCSS_UMAC_CE0_SRC_REG
HAL_SEQ_WCSS_UMAC_CE0_DST_REG
HAL_SEQ_WCSS_UMAC_CE1_SRC_REG
HAL_SEQ_WCSS_UMAC_CE1_DST_REG

Hence, refactor ath12k_hw_regs structure to accommodate these changes
in IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Co-developed-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 82 +++++++++++++--------------
 drivers/net/wireless/ath/ath12k/hal.h | 61 +++++++++++---------
 drivers/net/wireless/ath/ath12k/hw.c  | 27 +++++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  8 +++
 4 files changed, 110 insertions(+), 68 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index ca04bfae8bdc..d2ad0224fdfe 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -552,9 +552,9 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
 
 	s = &hal->srng_config[HAL_TCL_DATA];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB - HAL_TCL1_RING_BASE_LSB;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_CMD];
@@ -566,29 +566,29 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
 
 	s = &hal->srng_config[HAL_CE_SRC];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG +
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
 		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
@@ -1371,9 +1371,9 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 
 	s = &hal->srng_config[HAL_TCL_DATA];
 	s->max_rings = 5;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB - HAL_TCL1_RING_BASE_LSB;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_CMD];
@@ -1386,31 +1386,31 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 
 	s = &hal->srng_config[HAL_CE_SRC];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST_STATUS];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG +
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
 		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 
 	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
@@ -1756,7 +1756,7 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 			      HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
 	      u32_encode_bits((srng->entry_size * srng->num_entries),
 			      HAL_TCL1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET, val);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(ab), val);
 
 	val = u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
 	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(ab), val);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 8a78bb9a10bc..69579f118b81 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -44,10 +44,14 @@ struct ath12k_base;
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
-#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG		0x01b80000
-#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG		0x01b81000
-#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG		0x01b82000
-#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG		0x01b83000
+#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce0_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce0_dest_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce1_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) \
+	((ab)->hw_params->regs->hal_umac_ce1_dest_reg_base)
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
 #define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
@@ -57,8 +61,10 @@ struct ath12k_base;
 /* SW2TCL(x) R0 ring configuration address */
 #define HAL_TCL1_RING_CMN_CTRL_REG		0x00000020
 #define HAL_TCL1_RING_DSCP_TID_MAP		0x00000240
-#define HAL_TCL1_RING_BASE_LSB			0x00000900
-#define HAL_TCL1_RING_BASE_MSB			0x00000904
+#define HAL_TCL1_RING_BASE_LSB(ab) \
+	((ab)->hw_params->regs->hal_tcl1_ring_base_lsb)
+#define HAL_TCL1_RING_BASE_MSB(ab) \
+	((ab)->hw_params->regs->hal_tcl1_ring_base_msb)
 #define HAL_TCL1_RING_ID(ab)			((ab)->hw_params->regs->hal_tcl1_ring_id)
 #define HAL_TCL1_RING_MISC(ab) \
 	((ab)->hw_params->regs->hal_tcl1_ring_misc)
@@ -76,30 +82,31 @@ struct ath12k_base;
 	((ab)->hw_params->regs->hal_tcl1_ring_msi1_base_msb)
 #define HAL_TCL1_RING_MSI1_DATA(ab) \
 	((ab)->hw_params->regs->hal_tcl1_ring_msi1_data)
-#define HAL_TCL2_RING_BASE_LSB			0x00000978
+#define HAL_TCL2_RING_BASE_LSB(ab) \
+	((ab)->hw_params->regs->hal_tcl2_ring_base_lsb)
 #define HAL_TCL_RING_BASE_LSB(ab) \
 	((ab)->hw_params->regs->hal_tcl_ring_base_lsb)
 
-#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab)				\
-	(HAL_TCL1_RING_MSI1_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab)				\
-	(HAL_TCL1_RING_MSI1_BASE_MSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MSI1_DATA_OFFSET(ab)				\
-	(HAL_TCL1_RING_MSI1_DATA(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_BASE_MSB_OFFSET				\
-	(HAL_TCL1_RING_BASE_MSB - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_ID_OFFSET(ab)				\
-	(HAL_TCL1_RING_ID(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab)			\
-	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab) \
-		(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab) \
-		(HAL_TCL1_RING_TP_ADDR_LSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab) \
-		(HAL_TCL1_RING_TP_ADDR_MSB(ab) - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MISC_OFFSET(ab) \
-		(HAL_TCL1_RING_MISC(ab) - HAL_TCL1_RING_BASE_LSB)
+#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MSI1_BASE_LSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab)	({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MSI1_BASE_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_MSI1_DATA_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MSI1_DATA(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_BASE_MSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_BASE_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_ID_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_ID(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_TP_ADDR_LSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_TP_ADDR_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+#define HAL_TCL1_RING_MISC_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
+	(HAL_TCL1_RING_MISC(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
 
 /* SW2TCL(x) R2 ring pointers (head/tail) address */
 #define HAL_TCL1_RING_HP			0x00002000
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 7ca6ec99fd6e..c755cadb3d4d 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -615,6 +615,9 @@ static const struct ath12k_hw_regs qcn9274_v1_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -677,6 +680,12 @@ static const struct ath12k_hw_regs qcn9274_v1_regs = {
 
 	/* REO status ring address */
 	.hal_reo_status_ring_base = 0x00000a84,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
 };
 
 static const struct ath12k_hw_regs qcn9274_v2_regs = {
@@ -691,6 +700,9 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -757,6 +769,12 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 
 	/* REO status ring address */
 	.hal_reo_status_ring_base = 0x00000aa0,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
 };
 
 static const struct ath12k_hw_regs wcn7850_regs = {
@@ -771,6 +789,9 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -833,6 +854,12 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 
 	/* REO status ring address */
 	.hal_reo_status_ring_base = 0x00000a84,
+
+	/* CE base address */
+	.hal_umac_ce0_src_reg_base = 0x01b80000,
+	.hal_umac_ce0_dest_reg_base = 0x01b81000,
+	.hal_umac_ce1_src_reg_base = 0x01b82000,
+	.hal_umac_ce1_dest_reg_base = 0x01b83000,
 };
 
 static const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274 = {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 8d52182e28ae..36bec99e9e4d 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -293,6 +293,9 @@ struct ath12k_hw_regs {
 	u32 hal_tcl1_ring_msi1_base_msb;
 	u32 hal_tcl1_ring_msi1_data;
 	u32 hal_tcl_ring_base_lsb;
+	u32 hal_tcl1_ring_base_lsb;
+	u32 hal_tcl1_ring_base_msb;
+	u32 hal_tcl2_ring_base_lsb;
 
 	u32 hal_tcl_status_ring_base_lsb;
 
@@ -316,6 +319,11 @@ struct ath12k_hw_regs {
 	u32 pcie_qserdes_sysclk_en_sel;
 	u32 pcie_pcs_osc_dtct_config_base;
 
+	u32 hal_umac_ce0_src_reg_base;
+	u32 hal_umac_ce0_dest_reg_base;
+	u32 hal_umac_ce1_src_reg_base;
+	u32 hal_umac_ce1_dest_reg_base;
+
 	u32 hal_ppe_rel_ring_base;
 
 	u32 hal_reo2_ring_base;
-- 
2.34.1


