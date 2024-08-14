Return-Path: <linux-wireless+bounces-11414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5B9517FB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C1C1C21EFC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB6F16BE06;
	Wed, 14 Aug 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e7IngNcX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3116B3AC
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628693; cv=none; b=hbZVZnNfi2Shb+0ooL9uZhFi3USkCJywr2mFZOPTEdKuqmocTptfIQi/eMMD4qiGXk12gSaMRcY9p7wCbGdLAkYQOqXDe2DlAuMHSJ+TXNR2wO7fnimC39RsNTIVJogS2O9TNBCgr+3jws+jSqfhsMZz3XNVze/Hs5n2OoPudWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628693; c=relaxed/simple;
	bh=XiSu6qqhcDzaIqTNLHqQNS8jxki3SDobkTKFvBM4USA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LceG47CdsIRA+iWMplnuor094DddyX/dSW7dMmjfB8pPYE9oaSn5eDOYHzQjqea2Ts4GwDddVHbjtJE6FqgTuFTkUe0QZu5wbaTwhbGz9akGVaFOfs2BQZoamiDAXAJwX053TnOPFlp5KqWhO7anauS7YipkyL8XIZjvE7o6cVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e7IngNcX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E0PlkL017638;
	Wed, 14 Aug 2024 09:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2rq1uY0TTFNKtUp7GWJQm0zsidPTyjoWXKbx3x5wfSU=; b=e7IngNcXk72fbj1m
	6kpjiIfpVG8AEGuGTNE7LGZ7Ng2wRUHc3aAA727v/P/bzlXXSuwVKAD61tw+ia5n
	RN8dAUTGMWrX4wYc58AnP/9yJyEit05OUyd+9jnWJcnmduX28aVY+Uh2kosRkyLb
	WW0oXRUyUCt8249xvnh0z2+X9Ny4u1dudhPgD0ZLH+op4LHgb4PALt4wt0VmF9lg
	Jc888l51aVI6CEDrlQDp3Qtqfk6STYn1XhHDxVB0I3/WIhafau5G4xxW6IAlJ+oc
	AnYjpDvLJoVARrlq8aE6Ha/MNPgVSRadb4Tjjo9EiO/REl2Vvxat8Mnvg2NaqDUD
	ob99wA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410j1j9785-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9imXn017443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:48 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:46 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 13/18] wifi: ath12k: remap CE register space for IPQ5332
Date: Wed, 14 Aug 2024 15:13:18 +0530
Message-ID: <20240814094323.3927603-14-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 7t3WhobLQV7g9Xv_lz1vS6PstP35jzSq
X-Proofpoint-GUID: 7t3WhobLQV7g9Xv_lz1vS6PstP35jzSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

From: Balamurugan S <quic_bselvara@quicinc.com>

For IPQ5332 CE register space is moved out of WCSS region and the
space is not contiguous. Hence, add hardware params (ce_ie_addr &
ce_remap) for IPQ5332. These parameters would be used by Ath12k
AHB driver to remap the CE registers to a new space for accessing
them.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ce.h   | 11 +++++++++++
 drivers/net/wireless/ath/ath12k/core.h |  4 ++++
 drivers/net/wireless/ath/ath12k/hal.h  |  4 ++++
 drivers/net/wireless/ath/ath12k/hw.c   | 19 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hw.h   |  2 ++
 5 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 46fd1f49ec4a..9dd71056e1c5 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -76,6 +76,17 @@ struct ce_pipe_config {
 	__le32 reserved;
 };
 
+struct ce_ie_addr {
+	u32 ie1_reg_addr;
+	u32 ie2_reg_addr;
+	u32 ie3_reg_addr;
+};
+
+struct ce_remap {
+	u32 base;
+	u32 size;
+};
+
 struct ce_attr {
 	/* CE_ATTR_* values */
 	unsigned int flags;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0493c0c522e3..46c33a6a553f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -791,6 +791,10 @@ struct ath12k_base {
 
 	void __iomem *mem_cmem;
 
+	void __iomem *mem_ce;
+	u32 ce_remap_base_addr;
+	bool ce_remap;
+
 	struct {
 		enum ath12k_bus bus;
 		const struct ath12k_hif_ops *ops;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 2184da129966..90756af4c4c2 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -11,6 +11,7 @@
 #include "rx_desc.h"
 
 struct ath12k_base;
+#define HAL_CE_REMAP_REG_BASE	(ab->ce_remap_base_addr)
 
 #define HAL_LINK_DESC_SIZE			(32 << 2)
 #define HAL_LINK_DESC_ALIGN			128
@@ -376,6 +377,9 @@ struct ath12k_base;
 #define HAL_IPQ5332_CMEM_SIZE		0x40000
 #define HAL_IPQ5332_CMEM_BASE		0x100000
 
+#define HAL_IPQ5332_CE_WFSS_REG_BASE	0x740000
+#define HAL_IPQ5332_CE_SIZE		0x200000
+
 enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_REO2SW0 = 0,
 	HAL_SRNG_RING_ID_REO2SW1,
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 6be0d15d87ae..83dc98891166 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1228,6 +1228,17 @@ static const struct cmem_remap ath12k_cmem_remap_ipq5332 = {
 	.size = HAL_IPQ5332_CMEM_SIZE,
 };
 
+static const struct ce_ie_addr ath12k_ce_ie_addr_ipq5332 = {
+	.ie1_reg_addr = CE_HOST_IE_ADDRESS,
+	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS,
+	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS,
+};
+
+static const struct ce_remap ath12k_ce_remap_ipq5332 = {
+	.base = HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.size = HAL_IPQ5332_CE_SIZE,
+};
+
 static const struct ath12k_hw_params ath12k_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -1306,6 +1317,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.m3_fw_support = true,
 		.cmem_remap = NULL,
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1388,6 +1401,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.m3_fw_support = true,
 		.cmem_remap = NULL,
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1466,6 +1481,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.m3_fw_support = true,
 		.cmem_remap = NULL,
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1540,6 +1557,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.m3_fw_support = false,
 		.cmem_remap = &ath12k_cmem_remap_ipq5332,
+		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5332,
+		.ce_remap = &ath12k_ce_remap_ipq5332,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e30bec688b74..580c7be109e0 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -223,6 +223,8 @@ struct ath12k_hw_params {
 
 	bool m3_fw_support;
 	const struct cmem_remap *cmem_remap;
+	const struct ce_ie_addr *ce_ie_addr;
+	const struct ce_remap *ce_remap;
 };
 
 struct ath12k_hw_ops {
-- 
2.34.1


