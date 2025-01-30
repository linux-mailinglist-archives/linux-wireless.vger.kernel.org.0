Return-Path: <linux-wireless+bounces-18195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C29A22878
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 06:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897B83A4547
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 05:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55922198E84;
	Thu, 30 Jan 2025 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fnV/aQwH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29901714B7;
	Thu, 30 Jan 2025 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214392; cv=none; b=t3BBaz24DQmS09YQrPwgjZkTb8tUiVIurj3Bmcil7cKBK7j/SuALLuKdGLwYcQQ+efHmbbhDEEKNKRi1lZtJicpd51xXXoMTJxilf0MDwXrmISovBPEUWKYjDvOWpCeC92LnMk2kwcrPHGGWW0n2Q7nCNcUQpwDY09cQ2WO+u7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214392; c=relaxed/simple;
	bh=bBgWTnEk9cZwNLWK4rmWgcBU7aFidJvxxeTZh1xCNGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9fkWavV3A66zDxASMv5k31FRZYOzHE8m07gdOApphU180JSqwys9ATrwpIGo2MvxDnoSu9muVeE7GRDUYn+WeBsW9RFG4fryuL7MkiNAb9S21Pm5sVTSiX8fPkj0Iij/9GBCUm1y8ck1QKL5h7PzrEtyhc/XK/wT8Quq6yMn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fnV/aQwH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TIlYGw000787;
	Thu, 30 Jan 2025 05:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CFNW+leIUFl9qV76TH6Y9vWDF0xeVh88AHXoNGr7RXA=; b=fnV/aQwHdEaWlvHd
	fk4RzpBItUl9o9QcoDsniBqgqzTzUXPhF6SBgKJok/H3cEua9ymrb7ONSD6Oi3GF
	YcgFo5AeBaq7th68SSuOY/ZhSLOBuC2/5cIKHKTqq8u3fbdjk6E3+qKCyu+A/BUy
	TOA0YaaQuFk1kabf5KMjeyjyNt30ulwk9Q/J5KBOwVqppxhVU9+xFeGyypAliLim
	bF+Zxj3i4LFQckTU0ScbgYLLXLoc6kLloPxfdOrv11nbSVbqEk9dxrSxjT2X2aWV
	74G60TNxJi0yvz1ilRX+GrSnYfYZhfwDMScv9hs5oGggOPTCsk4i5TZytPL1lnDj
	Auax+g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fswys461-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 05:19:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U5Jk3O001572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 05:19:46 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 21:19:42 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Saravanakumar
 Duraisamy" <quic_saradura@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 4/5] wifi: ath12k: Add CE remap hardware parameters for IPQ5424
Date: Thu, 30 Jan 2025 10:48:37 +0530
Message-ID: <20250130051838.1924079-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wGDFz_5vY3nrQlJ49PWkujsPCEO8hlhK
X-Proofpoint-GUID: wGDFz_5vY3nrQlJ49PWkujsPCEO8hlhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=854 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300039

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add CE remap hardware parameters for new Ath12k AHB device IPQ5424.

Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.5-01053-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c |  2 +-
 drivers/net/wireless/ath/ath12k/ce.h  | 13 +++++++++----
 drivers/net/wireless/ath/ath12k/hw.c  | 21 ++++++++++++++++-----
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 0dbee14fbe90..d502b59a78d8 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -977,7 +977,7 @@ static int ath12k_ahb_resource_init(struct ath12k_base *ab)
 			goto err_mem_unmap;
 		}
 		ab->ce_remap = true;
-		ab->ce_remap_base_addr = HAL_IPQ5332_CE_WFSS_REG_BASE;
+		ab->ce_remap_base_addr = ce_remap->base;
 	}
 
 	ret = ath12k_ahb_clock_init(ab);
diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 57f75899ee03..3ac7f28d2c92 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -38,10 +38,15 @@
 #define PIPEDIR_INOUT		3 /* bidirectional */
 #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
 
-/* CE address/mask */
-#define CE_HOST_IE_ADDRESS	0x75804C
-#define CE_HOST_IE_2_ADDRESS	0x758050
-#define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
+/* IPQ5332 CE address/mask */
+#define CE_HOST_IPQ5332_IE_ADDRESS	0x75804C
+#define CE_HOST_IPQ5332_IE_2_ADDRESS	0x758050
+#define CE_HOST_IPQ5332_IE_3_ADDRESS	CE_HOST_IPQ5332_IE_ADDRESS
+
+/* IPQ5424 CE address/mask */
+#define CE_HOST_IPQ5424_IE_ADDRESS	0x21804C
+#define CE_HOST_IPQ5424_IE_2_ADDRESS	0x218050
+#define CE_HOST_IPQ5424_IE_3_ADDRESS	CE_HOST_IPQ5424_IE_ADDRESS
 
 #define CE_HOST_IE_3_SHIFT	0xC
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 7ee21a03fcac..00da2d5a0378 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1317,9 +1317,15 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
 };
 
 static const struct ce_ie_addr ath12k_ce_ie_addr_ipq5332 = {
-	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie1_reg_addr = CE_HOST_IPQ5332_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5332_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5332_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+};
+
+static const struct ce_ie_addr ath12k_ce_ie_addr_ipq5424 = {
+	.ie1_reg_addr = CE_HOST_IPQ5424_IE_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5424_IE_2_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5424_IE_3_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
 };
 
 static const struct ce_remap ath12k_ce_remap_ipq5332 = {
@@ -1327,6 +1333,11 @@ static const struct ce_remap ath12k_ce_remap_ipq5332 = {
 	.size = HAL_IPQ5332_CE_SIZE,
 };
 
+static const struct ce_remap ath12k_ce_remap_ipq5424 = {
+	.base = HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.size = HAL_IPQ5424_CE_SIZE,
+};
+
 static const struct ath12k_hw_params ath12k_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -1723,8 +1734,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.iova_mask = 0,
 		.supports_aspm = false,
 
-		.ce_ie_addr = NULL,
-		.ce_remap = NULL,
+		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5424,
+		.ce_remap = &ath12k_ce_remap_ipq5424,
 		.bdf_addr_offset = 0x940000,
 	},
 };
-- 
2.34.1


