Return-Path: <linux-wireless+bounces-27907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6831BC8B5F
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475443AEEC6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE242DFF19;
	Thu,  9 Oct 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="brxSpe5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D032DECB0
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008278; cv=none; b=S/QXqjliIEqo3z7inL2AGbTHDcDp5Vb4I3oli54M5Th8dE7//mrI2Gwq5OlyMtxaLKVp0+LzOAmLOfM4uRhr9n8wd1rBE5uzNlWYXm/oVQ3tdxZKh6u5dpKOdGlEl2BSTwi1ZYuujTHauM7iG60RMsWGkYe/xmQ1IT0BMVm8r6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008278; c=relaxed/simple;
	bh=T1Qt+fziPwtgdBVw3x+AkJYkcT1Ecqpdx3LbmrTbQYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKIXyUBX0RtzVMA+h1pEdzjuqU9utBaOvMK83aFkHLDX/9o7mUUv6Z+1q6BVdYD/Q21Ynd1Uzta5JCfwA2528JNBUR193wWOlRhya9dcABouPAvgxbIrIXBgBAAg1Tt0rwIG14oumBsvxE4GDYULqrsP0VdDzyAvM1MyCLgUJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=brxSpe5i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EIOa023272;
	Thu, 9 Oct 2025 11:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DaZTQDbyPhYqdPj0uE9jV9/q3R3AazeK3U/EekCBZSg=; b=brxSpe5ir9o4tUMw
	lG8Qq48vX/9HSkMnNb6NXSsAFLutkIgVueVyaqSr8YrJvxwXEGTMe0ur1AEWCUzd
	lqeSobo5BA1/D0j2btUE0c2RHCtSk0CVoDTdnMQginEbbhHcgIvKPdeA7QkNsyy9
	L3Cm1MkVAhFIUExlW4d11CLA5xGlDWwNvFzOlvY9C4BHj7Z4rTg4beha2Qzk+9vK
	pXsn/pgESBVWtqVXH2lx0cgWlh6KiMQjF/FCjKqujnF1h6nhKgbQgui8+l3z7+pN
	zgFSKLIAEmBaDoUn4OYLzBiG0Dn56XnmJBuKmnCCxlGdL9UjKDYJHTVYvKHV6WDr
	BkNKCg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m2hru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBCl6021650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:12 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:10 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 07/18] wifi: ath12k: Use hal handle instead of ab handle
Date: Thu, 9 Oct 2025 16:40:34 +0530
Message-ID: <20251009111045.1763001-8-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8KybtdMeNCPO
 IbRA9fqw0QnY2r+H/jX6Edy8QG+vVR6SEo1MoCEvbsYZnqXX39yGazR2pK5cBajvSnDBGVfKUs4
 87cUuSo9pLBtir+TJz0pl9aTxDYT/9pyhqqxdI0jD3MDEUBe6UtnW0F6OTaMhKzE6RS6480ywPF
 Qt+9cGBqUSNecApV6eP8ZlHyQ75R8YKHRET+iAqjjj1R1mLf1fBK17HgsOJf+7znU4dPOMngqys
 4hB5ZheLK8pTdweUctpS2Cg2Brcv7vz00ujfQOh/kSgPsQg73QJy45EUAJk4uCRoNJRr9b1hZFk
 57Rs4ruxQ7HOKOnU1kaa9OL4xGrd3LN4qcvDUQlkcjmzWe63FkY52gg+2G30MNo+EvLls8cJdM8
 499DYCT2xmQA9PinAk1gB2Lf/VLO+A==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e79850 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=E7lqYOSQawKBV9KZfVYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: w6mw-TKeCm6GD-15pMDUbw8Ml5aP-VEe
X-Proofpoint-ORIG-GUID: w6mw-TKeCm6GD-15pMDUbw8Ml5aP-VEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Use hal handle instead of ab handle in hal config APIs
and register access APIs, as this reduces the indirection.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c          |  22 +-
 drivers/net/wireless/ath/ath12k/hal.c         | 143 +++++-----
 drivers/net/wireless/ath/ath12k/hal.h         | 252 +++++++++---------
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  78 +++---
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  21 +-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  70 ++---
 6 files changed, 296 insertions(+), 290 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 600fa7803c59..6429ff72aa04 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1150,7 +1150,7 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	if (dp->reoq_lut.vaddr_unaligned) {
 		ath12k_hif_write32(ab,
 				   HAL_SEQ_WCSS_UMAC_REO_REG +
-				   HAL_REO1_QDESC_LUT_BASE0(ab), 0);
+				   HAL_REO1_QDESC_LUT_BASE0(dp->hal), 0);
 		dma_free_coherent(ab->dev, dp->reoq_lut.size,
 				  dp->reoq_lut.vaddr_unaligned,
 				  dp->reoq_lut.paddr_unaligned);
@@ -1160,7 +1160,7 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	if (dp->ml_reoq_lut.vaddr_unaligned) {
 		ath12k_hif_write32(ab,
 				   HAL_SEQ_WCSS_UMAC_REO_REG +
-				   HAL_REO1_QDESC_LUT_BASE1(ab), 0);
+				   HAL_REO1_QDESC_LUT_BASE1(dp->hal), 0);
 		dma_free_coherent(ab->dev, dp->ml_reoq_lut.size,
 				  dp->ml_reoq_lut.vaddr_unaligned,
 				  dp->ml_reoq_lut.paddr_unaligned);
@@ -1201,11 +1201,12 @@ void ath12k_dp_cc_config(struct ath12k_base *ab)
 	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
 	u32 wbm_base = HAL_SEQ_WCSS_UMAC_WBM_REG;
 	u32 val = 0;
+	struct ath12k_hal *hal = &ab->hal;
 
 	if (ath12k_ftm_mode)
 		return;
 
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG0(ab), cmem_base);
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG0(hal), cmem_base);
 
 	val |= u32_encode_bits(ATH12K_CMEM_ADDR_MSB,
 			       HAL_REO1_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB) |
@@ -1217,7 +1218,7 @@ void ath12k_dp_cc_config(struct ath12k_base *ab)
 		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_ENABLE) |
 		u32_encode_bits(1, HAL_REO1_SW_COOKIE_CFG_GLOBAL_ENABLE);
 
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG1(ab), val);
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG1(hal), val);
 
 	/* Enable HW CC for WBM */
 	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CFG0, cmem_base);
@@ -1243,7 +1244,7 @@ void ath12k_dp_cc_config(struct ath12k_base *ab)
 	/* Enable Cookie conversion for WBM2SW Rings */
 	val = ath12k_hif_read32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG);
 	val |= u32_encode_bits(1, HAL_WBM_SW_COOKIE_CONV_CFG_GLOBAL_EN) |
-	       ab->hal.hal_params->wbm2sw_cc_enable;
+	       hal->hal_params->wbm2sw_cc_enable;
 
 	ath12k_hif_write32(ab, wbm_base + HAL_WBM_SW_COOKIE_CONVERT_CFG, val);
 }
@@ -1537,6 +1538,7 @@ static int ath12k_dp_alloc_reoq_lut(struct ath12k_base *ab,
 static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_hal *hal = dp->hal;
 	u32 val;
 	int ret;
 
@@ -1565,18 +1567,18 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 	 * register only
 	 */
 
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab),
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(hal),
 			   dp->reoq_lut.paddr >> 8);
 
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE1(ab),
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE1(hal),
 			   dp->ml_reoq_lut.paddr >> 8);
 
-	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab));
+	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(hal));
 
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab),
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(hal),
 			   val | HAL_REO_QDESC_ADDR_READ_LUT_ENABLE);
 
-	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_MAX_PEERID(ab),
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_MAX_PEERID(hal),
 			   HAL_REO_QDESC_MAX_PEERID);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index d1dfbe2f9a65..fb369f464b2d 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -12,58 +12,57 @@
 #include "wifi7/hal_qcn9274.h"
 #include "wifi7/hal_wcn7850.h"
 
-static unsigned int ath12k_hal_reo1_ring_id_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_id_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_ID(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_ID(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_msi1_base_lsb_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_msi1_base_lsb_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_MSI1_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_MSI1_BASE_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_msi1_base_msb_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_msi1_base_msb_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_MSI1_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_MSI1_BASE_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_msi1_data_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_msi1_data_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_MSI1_DATA(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_MSI1_DATA(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_base_msb_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_base_msb_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_BASE_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_producer_int_setup_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_producer_int_setup_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_PRODUCER_INT_SETUP(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_PRODUCER_INT_SETUP(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_hp_addr_lsb_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_hp_addr_lsb_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_HP_ADDR_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_HP_ADDR_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_hp_addr_msb_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_hp_addr_msb_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_HP_ADDR_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_HP_ADDR_MSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static unsigned int ath12k_hal_reo1_ring_misc_offset(struct ath12k_base *ab)
+static unsigned int ath12k_hal_reo1_ring_misc_offset(struct ath12k_hal *hal)
 {
-	return HAL_REO1_RING_MISC(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	return HAL_REO1_RING_MISC(hal) - HAL_REO1_RING_BASE_LSB(hal);
 }
 
-static int ath12k_hal_alloc_cont_rdp(struct ath12k_base *ab)
+static int ath12k_hal_alloc_cont_rdp(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	size_t size;
 
 	size = sizeof(u32) * HAL_SRNG_RING_ID_MAX;
-	hal->rdp.vaddr = dma_alloc_coherent(ab->dev, size, &hal->rdp.paddr,
+	hal->rdp.vaddr = dma_alloc_coherent(hal->dev, size, &hal->rdp.paddr,
 					    GFP_KERNEL);
 	if (!hal->rdp.vaddr)
 		return -ENOMEM;
@@ -71,27 +70,25 @@ static int ath12k_hal_alloc_cont_rdp(struct ath12k_base *ab)
 	return 0;
 }
 
-static void ath12k_hal_free_cont_rdp(struct ath12k_base *ab)
+static void ath12k_hal_free_cont_rdp(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	size_t size;
 
 	if (!hal->rdp.vaddr)
 		return;
 
 	size = sizeof(u32) * HAL_SRNG_RING_ID_MAX;
-	dma_free_coherent(ab->dev, size,
+	dma_free_coherent(hal->dev, size,
 			  hal->rdp.vaddr, hal->rdp.paddr);
 	hal->rdp.vaddr = NULL;
 }
 
-static int ath12k_hal_alloc_cont_wrp(struct ath12k_base *ab)
+static int ath12k_hal_alloc_cont_wrp(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	size_t size;
 
 	size = sizeof(u32) * (HAL_SRNG_NUM_PMAC_RINGS + HAL_SRNG_NUM_DMAC_RINGS);
-	hal->wrp.vaddr = dma_alloc_coherent(ab->dev, size, &hal->wrp.paddr,
+	hal->wrp.vaddr = dma_alloc_coherent(hal->dev, size, &hal->wrp.paddr,
 					    GFP_KERNEL);
 	if (!hal->wrp.vaddr)
 		return -ENOMEM;
@@ -99,16 +96,15 @@ static int ath12k_hal_alloc_cont_wrp(struct ath12k_base *ab)
 	return 0;
 }
 
-static void ath12k_hal_free_cont_wrp(struct ath12k_base *ab)
+static void ath12k_hal_free_cont_wrp(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	size_t size;
 
 	if (!hal->wrp.vaddr)
 		return;
 
 	size = sizeof(u32) * (HAL_SRNG_NUM_PMAC_RINGS + HAL_SRNG_NUM_DMAC_RINGS);
-	dma_free_coherent(ab->dev, size,
+	dma_free_coherent(hal->dev, size,
 			  hal->wrp.vaddr, hal->wrp.paddr);
 	hal->wrp.vaddr = NULL;
 }
@@ -143,17 +139,17 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath12k_hif_write32(ab, reg_base +
-				   ath12k_hal_reo1_ring_msi1_base_lsb_offset(ab),
+				   ath12k_hal_reo1_ring_msi1_base_lsb_offset(hal),
 				   srng->msi_addr);
 
 		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
 				      HAL_REO1_RING_MSI1_BASE_MSB_ADDR) |
 				      HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
 		ath12k_hif_write32(ab, reg_base +
-				   ath12k_hal_reo1_ring_msi1_base_msb_offset(ab), val);
+				   ath12k_hal_reo1_ring_msi1_base_msb_offset(hal), val);
 
 		ath12k_hif_write32(ab,
-				   reg_base + ath12k_hal_reo1_ring_msi1_data_offset(ab),
+				   reg_base + ath12k_hal_reo1_ring_msi1_data_offset(hal),
 				   srng->msi_data);
 	}
 
@@ -163,11 +159,11 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 			      HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
 	      u32_encode_bits((srng->entry_size * srng->num_entries),
 			      HAL_REO1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_base_msb_offset(ab), val);
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_base_msb_offset(hal), val);
 
 	val = u32_encode_bits(srng->ring_id, HAL_REO1_RING_ID_RING_ID) |
 	      u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_id_offset(ab), val);
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_id_offset(hal), val);
 
 	/* interrupt setup */
 	val = u32_encode_bits((srng->intr_timer_thres_us >> 3),
@@ -177,15 +173,15 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 				HAL_REO1_RING_PRDR_INT_SETUP_BATCH_COUNTER_THOLD);
 
 	ath12k_hif_write32(ab,
-			   reg_base + ath12k_hal_reo1_ring_producer_int_setup_offset(ab),
+			   reg_base + ath12k_hal_reo1_ring_producer_int_setup_offset(hal),
 			   val);
 
 	hp_addr = hal->rdp.paddr +
 		  ((unsigned long)srng->u.dst_ring.hp_addr -
 		   (unsigned long)hal->rdp.vaddr);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_lsb_offset(ab),
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_lsb_offset(hal),
 			   hp_addr & HAL_ADDR_LSB_REG_MASK);
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_msb_offset(ab),
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_msb_offset(hal),
 			   hp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 
 	/* Initialize head and tail pointers to indicate ring is empty */
@@ -204,7 +200,7 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 		val |= HAL_REO1_RING_MISC_MSI_SWAP;
 	val |= HAL_REO1_RING_MISC_SRNG_ENABLE;
 
-	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_misc_offset(ab), val);
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_misc_offset(hal), val);
 }
 
 static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
@@ -219,18 +215,18 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath12k_hif_write32(ab, reg_base +
-				   HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab),
+				   HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(hal),
 				   srng->msi_addr);
 
 		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
 				      HAL_TCL1_RING_MSI1_BASE_MSB_ADDR) |
 				      HAL_TCL1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
 		ath12k_hif_write32(ab, reg_base +
-				       HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab),
+				       HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(hal),
 				   val);
 
 		ath12k_hif_write32(ab, reg_base +
-				       HAL_TCL1_RING_MSI1_DATA_OFFSET(ab),
+				       HAL_TCL1_RING_MSI1_DATA_OFFSET(hal),
 				   srng->msi_data);
 	}
 
@@ -240,10 +236,10 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 			      HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
 	      u32_encode_bits((srng->entry_size * srng->num_entries),
 			      HAL_TCL1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(ab), val);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(hal), val);
 
 	val = u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(ab), val);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(hal), val);
 
 	val = u32_encode_bits(srng->intr_timer_thres_us,
 			      HAL_TCL1_RING_CONSR_INT_SETUP_IX0_INTR_TMR_THOLD);
@@ -252,7 +248,7 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 			       HAL_TCL1_RING_CONSR_INT_SETUP_IX0_BATCH_COUNTER_THOLD);
 
 	ath12k_hif_write32(ab,
-			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab),
+			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(hal),
 			   val);
 
 	val = 0;
@@ -261,7 +257,7 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 				       HAL_TCL1_RING_CONSR_INT_SETUP_IX1_LOW_THOLD);
 	}
 	ath12k_hif_write32(ab,
-			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab),
+			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(hal),
 			   val);
 
 	if (srng->ring_id != HAL_SRNG_RING_ID_WBM_IDLE_LINK) {
@@ -269,10 +265,10 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 			  ((unsigned long)srng->u.src_ring.tp_addr -
 			   (unsigned long)hal->rdp.vaddr);
 		ath12k_hif_write32(ab,
-				   reg_base + HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab),
+				   reg_base + HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(hal),
 				   tp_addr & HAL_ADDR_LSB_REG_MASK);
 		ath12k_hif_write32(ab,
-				   reg_base + HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab),
+				   reg_base + HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(hal),
 				   tp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 	}
 
@@ -299,7 +295,7 @@ static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 	if (srng->ring_id == HAL_SRNG_RING_ID_WBM_IDLE_LINK)
 		val |= HAL_TCL1_RING_MISC_MSI_RING_ID_DISABLE;
 
-	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET(ab), val);
+	ath12k_hif_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET(hal), val);
 }
 
 static void ath12k_hal_srng_hw_init(struct ath12k_base *ab,
@@ -719,6 +715,7 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 				     u32 nsbufs, u32 tot_link_desc,
 				     u32 end_offset)
 {
+	struct ath12k_hal *hal = &ab->hal;
 	struct ath12k_buffer_addr *link_addr;
 	int i;
 	u32 reg_scatter_buf_sz = HAL_WBM_IDLE_SCATTER_BUF_SIZE / 64;
@@ -744,20 +741,21 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(ab),
+			   HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(hal),
 			   val);
 
 	val = u32_encode_bits(reg_scatter_buf_sz * nsbufs,
 			      HAL_WBM_SCATTER_RING_SIZE_OF_IDLE_LINK_DESC_LIST);
 	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(ab),
+			   HAL_SEQ_WCSS_UMAC_WBM_REG +
+			   HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(hal),
 			   val);
 
 	val = u32_encode_bits(sbuf[0].paddr & HAL_ADDR_LSB_REG_MASK,
 			      BUFFER_ADDR_INFO0_ADDR);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_RING_BASE_LSB(ab),
+			   HAL_WBM_SCATTERED_RING_BASE_LSB(hal),
 			   val);
 
 	val = u32_encode_bits(BASE_ADDR_MATCH_TAG_VAL,
@@ -766,14 +764,14 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 			      HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_RING_BASE_MSB(ab),
+			   HAL_WBM_SCATTERED_RING_BASE_MSB(hal),
 			   val);
 
 	/* Setup head and tail pointers for the idle list */
 	val = u32_encode_bits(sbuf[nsbufs - 1].paddr, BUFFER_ADDR_INFO0_ADDR);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(ab),
+			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal),
 			   val);
 
 	val = u32_encode_bits(((u64)sbuf[nsbufs - 1].paddr >> HAL_ADDR_MSB_REG_SHIFT),
@@ -782,19 +780,19 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 			       HAL_WBM_SCATTERED_DESC_HEAD_P_OFFSET_IX1);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(ab),
+			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(hal),
 			   val);
 
 	val = u32_encode_bits(sbuf[0].paddr, BUFFER_ADDR_INFO0_ADDR);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(ab),
+			   HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal),
 			   val);
 
 	val = u32_encode_bits(sbuf[0].paddr, BUFFER_ADDR_INFO0_ADDR);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(ab),
+			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(hal),
 			   val);
 
 	val = u32_encode_bits(((u64)sbuf[0].paddr >> HAL_ADDR_MSB_REG_SHIFT),
@@ -802,13 +800,13 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 	      u32_encode_bits(0, HAL_WBM_SCATTERED_DESC_TAIL_P_OFFSET_IX1);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(ab),
+			   HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(hal),
 			   val);
 
 	val = 2 * tot_link_desc;
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(ab),
+			   HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(hal),
 			   val);
 
 	/* Enable the SRNG */
@@ -816,7 +814,7 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 	      u32_encode_bits(1, HAL_WBM_IDLE_LINK_RING_MISC_RIND_ID_DISABLE);
 	ath12k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_IDLE_LINK_RING_MISC_ADDR(ab),
+			   HAL_WBM_IDLE_LINK_RING_MISC_ADDR(hal),
 			   val);
 }
 
@@ -1047,18 +1045,16 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
 		ath12k_hal_srng_access_end(ab, srng);
 }
 
-static void ath12k_hal_register_srng_lock_keys(struct ath12k_base *ab)
+static void ath12k_hal_register_srng_lock_keys(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	u32 ring_id;
 
 	for (ring_id = 0; ring_id < HAL_SRNG_RING_ID_MAX; ring_id++)
 		lockdep_register_key(&hal->srng_list[ring_id].lock_key);
 }
 
-static void ath12k_hal_unregister_srng_lock_keys(struct ath12k_base *ab)
+static void ath12k_hal_unregister_srng_lock_keys(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	u32 ring_id;
 
 	for (ring_id = 0; ring_id < HAL_SRNG_RING_ID_MAX; ring_id++)
@@ -1067,26 +1063,29 @@ static void ath12k_hal_unregister_srng_lock_keys(struct ath12k_base *ab)
 
 int ath12k_hal_srng_init(struct ath12k_base *ab)
 {
+	struct ath12k_hal *hal = &ab->hal;
 	int ret;
 
-	ret = ab->hal.hal_ops->create_srng_config(ab);
+	ret = hal->hal_ops->create_srng_config(hal);
 	if (ret)
 		goto err_hal;
 
-	ret = ath12k_hal_alloc_cont_rdp(ab);
+	hal->dev = ab->dev;
+
+	ret = ath12k_hal_alloc_cont_rdp(hal);
 	if (ret)
 		goto err_hal;
 
-	ret = ath12k_hal_alloc_cont_wrp(ab);
+	ret = ath12k_hal_alloc_cont_wrp(hal);
 	if (ret)
 		goto err_free_cont_rdp;
 
-	ath12k_hal_register_srng_lock_keys(ab);
+	ath12k_hal_register_srng_lock_keys(hal);
 
 	return 0;
 
 err_free_cont_rdp:
-	ath12k_hal_free_cont_rdp(ab);
+	ath12k_hal_free_cont_rdp(hal);
 
 err_hal:
 	return ret;
@@ -1096,9 +1095,9 @@ void ath12k_hal_srng_deinit(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
 
-	ath12k_hal_unregister_srng_lock_keys(ab);
-	ath12k_hal_free_cont_rdp(ab);
-	ath12k_hal_free_cont_wrp(ab);
+	ath12k_hal_unregister_srng_lock_keys(hal);
+	ath12k_hal_free_cont_rdp(hal);
+	ath12k_hal_free_cont_wrp(hal);
 	kfree(hal->srng_config);
 	hal->srng_config = NULL;
 }
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index fb36367b538e..087e9a08f628 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -72,14 +72,14 @@ struct ath12k_base;
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
-#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) \
-	((ab)->hal.regs->hal_umac_ce0_src_reg_base)
-#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) \
-	((ab)->hal.regs->hal_umac_ce0_dest_reg_base)
-#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) \
-	((ab)->hal.regs->hal_umac_ce1_src_reg_base)
-#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) \
-	((ab)->hal.regs->hal_umac_ce1_dest_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) \
+	((hal)->regs->hal_umac_ce0_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) \
+	((hal)->regs->hal_umac_ce0_dest_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) \
+	((hal)->regs->hal_umac_ce1_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) \
+	((hal)->regs->hal_umac_ce1_dest_reg_base)
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
 #define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
@@ -89,52 +89,53 @@ struct ath12k_base;
 /* SW2TCL(x) R0 ring configuration address */
 #define HAL_TCL1_RING_CMN_CTRL_REG		0x00000020
 #define HAL_TCL1_RING_DSCP_TID_MAP		0x00000240
-#define HAL_TCL1_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_base_lsb)
-#define HAL_TCL1_RING_BASE_MSB(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_base_msb)
-#define HAL_TCL1_RING_ID(ab)		((ab)->hal.regs->hal_tcl1_ring_id)
-#define HAL_TCL1_RING_MISC(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_misc)
-#define HAL_TCL1_RING_TP_ADDR_LSB(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_tp_addr_lsb)
-#define HAL_TCL1_RING_TP_ADDR_MSB(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_tp_addr_msb)
-#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_consumer_int_setup_ix0)
-#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_consumer_int_setup_ix1)
-#define HAL_TCL1_RING_MSI1_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_msi1_base_lsb)
-#define HAL_TCL1_RING_MSI1_BASE_MSB(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_msi1_base_msb)
-#define HAL_TCL1_RING_MSI1_DATA(ab) \
-	((ab)->hal.regs->hal_tcl1_ring_msi1_data)
-#define HAL_TCL2_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_tcl2_ring_base_lsb)
-#define HAL_TCL_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_tcl_ring_base_lsb)
-
-#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_MSI1_BASE_LSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab)	({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_MSI1_BASE_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_MSI1_DATA_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_MSI1_DATA(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_BASE_MSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_BASE_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_ID_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_ID(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_TP_ADDR_LSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_TP_ADDR_MSB(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
-#define HAL_TCL1_RING_MISC_OFFSET(ab) ({ typeof(ab) _ab = (ab); \
-	(HAL_TCL1_RING_MISC(_ab) - HAL_TCL1_RING_BASE_LSB(_ab)); })
+
+#define HAL_TCL1_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl1_ring_base_lsb)
+#define HAL_TCL1_RING_BASE_MSB(hal) \
+	((hal)->regs->hal_tcl1_ring_base_msb)
+#define HAL_TCL1_RING_ID(hal)		((hal)->regs->hal_tcl1_ring_id)
+#define HAL_TCL1_RING_MISC(hal) \
+	((hal)->regs->hal_tcl1_ring_misc)
+#define HAL_TCL1_RING_TP_ADDR_LSB(hal) \
+	((hal)->regs->hal_tcl1_ring_tp_addr_lsb)
+#define HAL_TCL1_RING_TP_ADDR_MSB(hal) \
+	((hal)->regs->hal_tcl1_ring_tp_addr_msb)
+#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(hal) \
+	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix0)
+#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(hal) \
+	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix1)
+#define HAL_TCL1_RING_MSI1_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl1_ring_msi1_base_lsb)
+#define HAL_TCL1_RING_MSI1_BASE_MSB(hal) \
+	((hal)->regs->hal_tcl1_ring_msi1_base_msb)
+#define HAL_TCL1_RING_MSI1_DATA(hal) \
+	((hal)->regs->hal_tcl1_ring_msi1_data)
+#define HAL_TCL2_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl2_ring_base_lsb)
+#define HAL_TCL_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl_ring_base_lsb)
+
+#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MSI1_BASE_LSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(hal)	({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MSI1_BASE_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_MSI1_DATA_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MSI1_DATA(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_BASE_MSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_BASE_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_ID_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_ID(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_TP_ADDR_LSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_TP_ADDR_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_MISC_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MISC(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
 
 /* SW2TCL(x) R2 ring pointers (head/tail) address */
 #define HAL_TCL1_RING_HP			0x00002000
@@ -146,8 +147,8 @@ struct ath12k_base;
 		(HAL_TCL1_RING_TP - HAL_TCL1_RING_HP)
 
 /* TCL STATUS ring address */
-#define HAL_TCL_STATUS_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_tcl_status_ring_base_lsb)
+#define HAL_TCL_STATUS_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl_status_ring_base_lsb)
 #define HAL_TCL_STATUS_RING_HP			0x00002048
 
 /* PPE2TCL1 Ring address */
@@ -155,42 +156,42 @@ struct ath12k_base;
 #define HAL_TCL_PPE2TCL1_RING_HP		0x00002038
 
 /* WBM PPE Release Ring address */
-#define HAL_WBM_PPE_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_ppe_rel_ring_base)
+#define HAL_WBM_PPE_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_ppe_rel_ring_base)
 #define HAL_WBM_PPE_RELEASE_RING_HP		0x00003020
 
 /* REO2SW(x) R0 ring configuration address */
 #define HAL_REO1_GEN_ENABLE			0x00000000
-#define HAL_REO1_MISC_CTRL_ADDR(ab) \
-	((ab)->hal.regs->hal_reo1_misc_ctrl_addr)
+#define HAL_REO1_MISC_CTRL_ADDR(hal) \
+	((hal)->regs->hal_reo1_misc_ctrl_addr)
 #define HAL_REO1_DEST_RING_CTRL_IX_0		0x00000004
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
-#define HAL_REO1_QDESC_ADDR(ab)		((ab)->hal.regs->hal_reo1_qdesc_addr)
-#define HAL_REO1_QDESC_MAX_PEERID(ab)	((ab)->hal.regs->hal_reo1_qdesc_max_peerid)
-#define HAL_REO1_SW_COOKIE_CFG0(ab)	((ab)->hal.regs->hal_reo1_sw_cookie_cfg0)
-#define HAL_REO1_SW_COOKIE_CFG1(ab)	((ab)->hal.regs->hal_reo1_sw_cookie_cfg1)
-#define HAL_REO1_QDESC_LUT_BASE0(ab)	((ab)->hal.regs->hal_reo1_qdesc_lut_base0)
-#define HAL_REO1_QDESC_LUT_BASE1(ab)	((ab)->hal.regs->hal_reo1_qdesc_lut_base1)
-#define HAL_REO1_RING_BASE_LSB(ab)	((ab)->hal.regs->hal_reo1_ring_base_lsb)
-#define HAL_REO1_RING_BASE_MSB(ab)	((ab)->hal.regs->hal_reo1_ring_base_msb)
-#define HAL_REO1_RING_ID(ab)		((ab)->hal.regs->hal_reo1_ring_id)
-#define HAL_REO1_RING_MISC(ab)		((ab)->hal.regs->hal_reo1_ring_misc)
-#define HAL_REO1_RING_HP_ADDR_LSB(ab)	((ab)->hal.regs->hal_reo1_ring_hp_addr_lsb)
-#define HAL_REO1_RING_HP_ADDR_MSB(ab)	((ab)->hal.regs->hal_reo1_ring_hp_addr_msb)
-#define HAL_REO1_RING_PRODUCER_INT_SETUP(ab) \
-	((ab)->hal.regs->hal_reo1_ring_producer_int_setup)
-#define HAL_REO1_RING_MSI1_BASE_LSB(ab)	\
-	((ab)->hal.regs->hal_reo1_ring_msi1_base_lsb)
-#define HAL_REO1_RING_MSI1_BASE_MSB(ab)	\
-	((ab)->hal.regs->hal_reo1_ring_msi1_base_msb)
-#define HAL_REO1_RING_MSI1_DATA(ab)	((ab)->hal.regs->hal_reo1_ring_msi1_data)
-#define HAL_REO2_RING_BASE_LSB(ab)	((ab)->hal.regs->hal_reo2_ring_base)
-#define HAL_REO1_AGING_THRESH_IX_0(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix0)
-#define HAL_REO1_AGING_THRESH_IX_1(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix1)
-#define HAL_REO1_AGING_THRESH_IX_2(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix2)
-#define HAL_REO1_AGING_THRESH_IX_3(ab)	((ab)->hal.regs->hal_reo1_aging_thres_ix3)
+#define HAL_REO1_QDESC_ADDR(hal)		((hal)->regs->hal_reo1_qdesc_addr)
+#define HAL_REO1_QDESC_MAX_PEERID(hal)	((hal)->regs->hal_reo1_qdesc_max_peerid)
+#define HAL_REO1_SW_COOKIE_CFG0(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg0)
+#define HAL_REO1_SW_COOKIE_CFG1(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg1)
+#define HAL_REO1_QDESC_LUT_BASE0(hal)	((hal)->regs->hal_reo1_qdesc_lut_base0)
+#define HAL_REO1_QDESC_LUT_BASE1(hal)	((hal)->regs->hal_reo1_qdesc_lut_base1)
+#define HAL_REO1_RING_BASE_LSB(hal)	((hal)->regs->hal_reo1_ring_base_lsb)
+#define HAL_REO1_RING_BASE_MSB(hal)	((hal)->regs->hal_reo1_ring_base_msb)
+#define HAL_REO1_RING_ID(hal)		((hal)->regs->hal_reo1_ring_id)
+#define HAL_REO1_RING_MISC(hal)		((hal)->regs->hal_reo1_ring_misc)
+#define HAL_REO1_RING_HP_ADDR_LSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_lsb)
+#define HAL_REO1_RING_HP_ADDR_MSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_msb)
+#define HAL_REO1_RING_PRODUCER_INT_SETUP(hal) \
+	((hal)->regs->hal_reo1_ring_producer_int_setup)
+#define HAL_REO1_RING_MSI1_BASE_LSB(hal)	\
+	((hal)->regs->hal_reo1_ring_msi1_base_lsb)
+#define HAL_REO1_RING_MSI1_BASE_MSB(hal)	\
+	((hal)->regs->hal_reo1_ring_msi1_base_msb)
+#define HAL_REO1_RING_MSI1_DATA(hal)	((hal)->regs->hal_reo1_ring_msi1_data)
+#define HAL_REO2_RING_BASE_LSB(hal)	((hal)->regs->hal_reo2_ring_base)
+#define HAL_REO1_AGING_THRESH_IX_0(hal)	((hal)->regs->hal_reo1_aging_thres_ix0)
+#define HAL_REO1_AGING_THRESH_IX_1(hal)	((hal)->regs->hal_reo1_aging_thres_ix1)
+#define HAL_REO1_AGING_THRESH_IX_2(hal)	((hal)->regs->hal_reo1_aging_thres_ix2)
+#define HAL_REO1_AGING_THRESH_IX_3(hal)	((hal)->regs->hal_reo1_aging_thres_ix3)
 
 /* REO2SW(x) R2 ring pointers (head/tail) address */
 #define HAL_REO1_RING_HP			0x00003048
@@ -200,24 +201,24 @@ struct ath12k_base;
 #define HAL_REO1_RING_TP_OFFSET			(HAL_REO1_RING_TP - HAL_REO1_RING_HP)
 
 /* REO2SW0 ring configuration address */
-#define HAL_REO_SW0_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_reo2_sw0_ring_base)
+#define HAL_REO_SW0_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_reo2_sw0_ring_base)
 
 /* REO2SW0 R2 ring pointer (head/tail) address */
 #define HAL_REO_SW0_RING_HP			0x00003088
 
 /* REO CMD R0 address */
-#define HAL_REO_CMD_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_reo_cmd_ring_base)
+#define HAL_REO_CMD_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_reo_cmd_ring_base)
 
 /* REO CMD R2 address */
 #define HAL_REO_CMD_HP				0x00003020
 
 /* SW2REO R0 address */
-#define	HAL_SW2REO_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_sw2reo_ring_base)
-#define HAL_SW2REO1_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_sw2reo1_ring_base)
+#define	HAL_SW2REO_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_sw2reo_ring_base)
+#define HAL_SW2REO1_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_sw2reo1_ring_base)
 
 /* SW2REO R2 address */
 #define HAL_SW2REO_RING_HP			0x00003028
@@ -234,53 +235,53 @@ struct ath12k_base;
 #define HAL_CE_DST_STATUS_RING_HP		0x00000408
 
 /* REO status address */
-#define HAL_REO_STATUS_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_reo_status_ring_base)
+#define HAL_REO_STATUS_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_reo_status_ring_base)
 #define HAL_REO_STATUS_HP			0x000030a8
 
 /* WBM Idle R0 address */
-#define HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_wbm_idle_ring_base_lsb)
-#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(ab) \
-	((ab)->hal.regs->hal_wbm_idle_ring_misc_addr)
-#define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(ab) \
-	((ab)->hal.regs->hal_wbm_r0_idle_list_cntl_addr)
-#define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(ab) \
-	((ab)->hal.regs->hal_wbm_r0_idle_list_size_addr)
-#define HAL_WBM_SCATTERED_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_wbm_scattered_ring_base_lsb)
-#define HAL_WBM_SCATTERED_RING_BASE_MSB(ab) \
-	((ab)->hal.regs->hal_wbm_scattered_ring_base_msb)
-#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(ab) \
-	((ab)->hal.regs->hal_wbm_scattered_desc_head_info_ix0)
-#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(ab) \
-	((ab)->hal.regs->hal_wbm_scattered_desc_head_info_ix1)
-#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(ab) \
-	((ab)->hal.regs->hal_wbm_scattered_desc_tail_info_ix0)
-#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(ab) \
-	((ab)->hal.regs->hal_wbm_scattered_desc_tail_info_ix1)
-#define HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(ab) \
-	((ab)->hal.regs->hal_wbm_scattered_desc_ptr_hp_addr)
+#define HAL_WBM_IDLE_LINK_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_idle_ring_base_lsb)
+#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(hal) \
+	((hal)->regs->hal_wbm_idle_ring_misc_addr)
+#define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(hal) \
+	((hal)->regs->hal_wbm_r0_idle_list_cntl_addr)
+#define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(hal) \
+	((hal)->regs->hal_wbm_r0_idle_list_size_addr)
+#define HAL_WBM_SCATTERED_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_scattered_ring_base_lsb)
+#define HAL_WBM_SCATTERED_RING_BASE_MSB(hal) \
+	((hal)->regs->hal_wbm_scattered_ring_base_msb)
+#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_head_info_ix0)
+#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_head_info_ix1)
+#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix0)
+#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix1)
+#define HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_ptr_hp_addr)
 
 /* WBM Idle R2 address */
 #define HAL_WBM_IDLE_LINK_RING_HP		0x000030b8
 
 /* SW2WBM R0 release address */
-#define HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_wbm_sw_release_ring_base_lsb)
-#define HAL_WBM_SW1_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_wbm_sw1_release_ring_base_lsb)
+#define HAL_WBM_SW_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_sw_release_ring_base_lsb)
+#define HAL_WBM_SW1_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_sw1_release_ring_base_lsb)
 
 /* SW2WBM R2 release address */
 #define HAL_WBM_SW_RELEASE_RING_HP		0x00003010
 #define HAL_WBM_SW1_RELEASE_RING_HP		0x00003018
 
 /* WBM2SW R0 release address */
-#define HAL_WBM0_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_wbm0_release_ring_base_lsb)
+#define HAL_WBM0_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm0_release_ring_base_lsb)
 
-#define HAL_WBM1_RELEASE_RING_BASE_LSB(ab) \
-	((ab)->hal.regs->hal_wbm1_release_ring_base_lsb)
+#define HAL_WBM1_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm1_release_ring_base_lsb)
 
 /* WBM2SW R2 release address */
 #define HAL_WBM0_RELEASE_RING_HP		0x000030c8
@@ -1547,6 +1548,7 @@ struct ath12k_hal {
 		dma_addr_t paddr;
 	} wrp;
 
+	struct device *dev;
 	const struct hal_ops *hal_ops;
 	const struct ath12k_hw_regs *regs;
 	const struct ath12k_hw_hal_params *hal_params;
@@ -1677,7 +1679,7 @@ struct ath12k_hw_version_map {
 };
 
 struct hal_ops {
-	int (*create_srng_config)(struct ath12k_base *ab);
+	int (*create_srng_config)(struct ath12k_hal *hal);
 	void (*rx_desc_set_msdu_len)(struct hal_rx_desc *desc, u16 len);
 	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
 				      struct ieee80211_hdr *hdr);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 265e9f368858..592007f1cad6 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -859,9 +859,8 @@ const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
-static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
+static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	struct hal_srng_config *s;
 
 	hal->srng_config = kmemdup(hw_srng_config_template,
@@ -871,85 +870,86 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 		return -ENOMEM;
 
 	s = &hal->srng_config[HAL_REO_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
-	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
 
 	s = &hal->srng_config[HAL_REO_EXCEPTION];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_HP;
 
 	s = &hal->srng_config[HAL_REO_REINJECT];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
-	s->reg_size[0] = HAL_SW2REO1_RING_BASE_LSB(ab) - HAL_SW2REO_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_SW2REO1_RING_BASE_LSB(hal) - HAL_SW2REO_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_SW2REO1_RING_HP - HAL_SW2REO_RING_HP;
 
 	s = &hal->srng_config[HAL_REO_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
 
 	s = &hal->srng_config[HAL_REO_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
 
 	s = &hal->srng_config[HAL_TCL_DATA];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(hal) - HAL_TCL1_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
 
 	s = &hal->srng_config[HAL_CE_SRC];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal);
 
 	s = &hal->srng_config[HAL_CE_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
 
 	s = &hal->srng_config[HAL_CE_DST_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) +
 		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
 
 	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
+	s->reg_start[0] =
+		HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP;
 
 	s = &hal->srng_config[HAL_SW2WBM_RELEASE];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
-		HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
+		HAL_WBM_SW_RELEASE_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_SW_RELEASE_RING_HP;
-	s->reg_size[0] = HAL_WBM_SW1_RELEASE_RING_BASE_LSB(ab) -
-			 HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_WBM_SW1_RELEASE_RING_BASE_LSB(hal) -
+			 HAL_WBM_SW_RELEASE_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_WBM_SW1_RELEASE_RING_HP - HAL_WBM_SW_RELEASE_RING_HP;
 
 	s = &hal->srng_config[HAL_WBM2SW_RELEASE];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP;
-	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(ab) -
-		HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(hal) -
+		HAL_WBM0_RELEASE_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP;
 
 	/* Some LMAC rings are not accessed from the host:
@@ -963,7 +963,7 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 
 	s = &hal->srng_config[HAL_PPE_RELEASE];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
-				HAL_WBM_PPE_RELEASE_RING_BASE_LSB(ab);
+				HAL_WBM_PPE_RELEASE_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_PPE_RELEASE_RING_HP;
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 240083a7c962..d035996657fe 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -915,6 +915,8 @@ void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
 
 void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 {
+	struct ath12k_hal *hal = &ab->hal;
+
 	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
 	u32 val;
 
@@ -924,7 +926,7 @@ void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 	       u32_encode_bits(1, HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE);
 	ath12k_hif_write32(ab, reo_base + HAL_REO1_GEN_ENABLE, val);
 
-	val = ath12k_hif_read32(ab, reo_base + HAL_REO1_MISC_CTRL_ADDR(ab));
+	val = ath12k_hif_read32(ab, reo_base + HAL_REO1_MISC_CTRL_ADDR(hal));
 
 	val &= ~(HAL_REO1_MISC_CTL_FRAG_DST_RING |
 		 HAL_REO1_MISC_CTL_BAR_DST_RING);
@@ -932,15 +934,15 @@ void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 			       HAL_REO1_MISC_CTL_FRAG_DST_RING);
 	val |= u32_encode_bits(HAL_SRNG_RING_ID_REO2SW0,
 			       HAL_REO1_MISC_CTL_BAR_DST_RING);
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_MISC_CTRL_ADDR(ab), val);
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_MISC_CTRL_ADDR(hal), val);
 
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0(ab),
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0(hal),
 			   HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC);
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_1(ab),
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_1(hal),
 			   HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC);
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_2(ab),
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_2(hal),
 			   HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC);
-	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3(ab),
+	ath12k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3(hal),
 			   HAL_DEFAULT_VO_REO_TIMEOUT_USEC);
 
 	ath12k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
@@ -952,16 +954,17 @@ void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 void ath12k_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab)
 {
 	u32 val;
+	struct ath12k_hal *hal = &ab->hal;
 
 	lockdep_assert_held(&ab->base_lock);
 	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
-				HAL_REO1_QDESC_ADDR(ab));
+				HAL_REO1_QDESC_ADDR(hal));
 
 	val |= u32_encode_bits(1, HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY);
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
-			   HAL_REO1_QDESC_ADDR(ab), val);
+			   HAL_REO1_QDESC_ADDR(hal), val);
 
 	val &= ~HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY;
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
-			   HAL_REO1_QDESC_ADDR(ab), val);
+			   HAL_REO1_QDESC_ADDR(hal), val);
 }
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index b3ed7c8d738d..8949b6fc833a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -655,9 +655,8 @@ void ath12k_hal_extract_rx_desc_data_wcn7850(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_wcn7850(rx_desc);
 }
 
-static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
+static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_hal *hal)
 {
-	struct ath12k_hal *hal = &ab->hal;
 	struct hal_srng_config *s;
 
 	hal->srng_config = kmemdup(hw_srng_config_template,
@@ -667,86 +666,87 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 		return -ENOMEM;
 
 	s = &hal->srng_config[HAL_REO_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
-	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(hal) - HAL_REO1_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
 
 	s = &hal->srng_config[HAL_REO_EXCEPTION];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_SW0_RING_HP;
 
 	s = &hal->srng_config[HAL_REO_REINJECT];
 	s->max_rings = 1;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
 
 	s = &hal->srng_config[HAL_REO_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
 
 	s = &hal->srng_config[HAL_REO_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
 
 	s = &hal->srng_config[HAL_TCL_DATA];
 	s->max_rings = 5;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(hal) - HAL_TCL1_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
 
 	s = &hal->srng_config[HAL_CE_SRC];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal);
 
 	s = &hal->srng_config[HAL_CE_DST];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
 
 	s = &hal->srng_config[HAL_CE_DST_STATUS];
 	s->max_rings = 12;
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) +
 		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
-	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
-	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
-		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) -
+		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal);
 
 	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
+	s->reg_start[0] =
+		HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP;
 
 	s = &hal->srng_config[HAL_SW2WBM_RELEASE];
 	s->max_rings = 1;
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG +
-		HAL_WBM_SW_RELEASE_RING_BASE_LSB(ab);
+		HAL_WBM_SW_RELEASE_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_SW_RELEASE_RING_HP;
 
 	s = &hal->srng_config[HAL_WBM2SW_RELEASE];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(hal);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP;
-	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(ab) -
-		HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(hal) -
+		HAL_WBM0_RELEASE_RING_BASE_LSB(hal);
 	s->reg_size[1] = HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP;
 
 	s = &hal->srng_config[HAL_RXDMA_BUF];
-- 
2.34.1


