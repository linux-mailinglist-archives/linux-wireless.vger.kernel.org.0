Return-Path: <linux-wireless+bounces-11412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B6B9517F9
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC481F23346
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF1166F38;
	Wed, 14 Aug 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EjA4RRqj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50B16C694
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628688; cv=none; b=Cr5CDntNsCQ6qiq4LUs4oKSk0hprjFZ04bKpj7RaptJ6wlZX3AQZCJPUS6IiP0qOFz6DhBF31EvJH40/s/A20a3e67wifUhlJKTXh9Vw10W59BatL6bhdxaR3rsXFtDWKiNBvPOHFKtbviCcUyBIrWMt/2z1WVUnhTGx509fbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628688; c=relaxed/simple;
	bh=i03POL4OL4Ke6Ou/oAwBGi46wDnE5c2gfaBjDBQkpE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUjt9Qgn5IMvii6BpTz0hn/WlqW+9s/W9fp+3Yn6uqcJyUF7rkLyj7aWt0kXobdSFndQj3cY0QQHf5OIxPUvpJApOVlp29VVG8k38qMXLIIb4CAlWGVVhX9v6yTQ1DKixcHLFaSqGhqUW1qAM34ssd4amlCfp5M3ERDJ2F2yYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EjA4RRqj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNFaeB031044;
	Wed, 14 Aug 2024 09:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ruobBHAS8VjEFB/idSuc+6IADdPnXTQMBprjGttCPHw=; b=EjA4RRqjBafFqiCC
	st86fJ1dRyqseTzNv7Mx2y5gJVOzMbJ/VED/iE05DQ70sUMKCcyYe/6/BNcfHFFV
	GuXhjj5IAwZaDb4WPp/vIyBJmwmvjefoltcJv1ZkdVXVV6MCO8hjyDiNQvXxF+s0
	rJY02e42CQGkwC5+Y+pwIrrdtl5RGGX5l5A8Ux9yuYf2et7Myh5+VQOQysCzNWrG
	OpsNCrXw9cDJrydo3yw3vBysYyVNgnjaDNW6gcf2ovOq6MMBBdTY+kqY7xliBHa0
	TWkDYgagolKvcGYmT5C1UrXcny/W+eUIKQJS1AE1i+gGwFyvkbo5mpKdCbrnkBc+
	rLZt5g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws3ujg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9iifP000785
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:44 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:42 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 11/18] wifi: ath12k: remap CMEM register space for IPQ5332
Date: Wed, 14 Aug 2024 15:13:16 +0530
Message-ID: <20240814094323.3927603-12-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: T6jWspMdOoJ6s2kpxJYv4UGbvK_QRM8n
X-Proofpoint-ORIG-GUID: T6jWspMdOoJ6s2kpxJYv4UGbvK_QRM8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

From: Balamurugan S <quic_bselvara@quicinc.com>

In IPQ5332 CMEM region is outside of WCSS register block. Hence, add
hardware param cmem_remap for IPQ5332. This parameter would be used
by Ath12k AHB driver to remap the CMEM registers to a new space for
accessing them.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 7 +++++++
 drivers/net/wireless/ath/ath12k/hal.h  | 4 ++++
 drivers/net/wireless/ath/ath12k/hw.c   | 9 +++++++++
 drivers/net/wireless/ath/ath12k/hw.h   | 1 +
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 6fa13165149d..0493c0c522e3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -719,6 +719,11 @@ struct ath12k_pdev {
 	struct mlo_timestamp timestamp;
 };
 
+struct cmem_remap {
+	u32 base;
+	u32 size;
+};
+
 struct ath12k_fw_pdev {
 	u32 pdev_id;
 	u32 phy_id;
@@ -784,6 +789,8 @@ struct ath12k_base {
 	void __iomem *mem;
 	unsigned long mem_len;
 
+	void __iomem *mem_cmem;
+
 	struct {
 		enum ath12k_bus bus;
 		const struct ath12k_hif_ops *ops;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 69579f118b81..2184da129966 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -372,6 +372,10 @@ struct ath12k_base;
  * ath12k_hal_rx_desc_get_err().
  */
 
+#define HAL_IPQ5332_CMEM_REG_BASE	0xC100000
+#define HAL_IPQ5332_CMEM_SIZE		0x40000
+#define HAL_IPQ5332_CMEM_BASE		0x100000
+
 enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_REO2SW0 = 0,
 	HAL_SRNG_RING_ID_REO2SW1,
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 58ffdef3efcb..6be0d15d87ae 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1223,6 +1223,11 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
+static const struct cmem_remap ath12k_cmem_remap_ipq5332 = {
+	.base = HAL_IPQ5332_CMEM_REG_BASE,
+	.size = HAL_IPQ5332_CMEM_SIZE,
+};
+
 static const struct ath12k_hw_params ath12k_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -1300,6 +1305,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = false,
 
 		.m3_fw_support = true,
+		.cmem_remap = NULL,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1381,6 +1387,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = true,
 
 		.m3_fw_support = true,
+		.cmem_remap = NULL,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1458,6 +1465,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = false,
 
 		.m3_fw_support = true,
+		.cmem_remap = NULL,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1531,6 +1539,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_aspm = false,
 
 		.m3_fw_support = false,
+		.cmem_remap = &ath12k_cmem_remap_ipq5332,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 22bd0a91b3e9..e30bec688b74 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -222,6 +222,7 @@ struct ath12k_hw_params {
 	u32 iova_mask;
 
 	bool m3_fw_support;
+	const struct cmem_remap *cmem_remap;
 };
 
 struct ath12k_hw_ops {
-- 
2.34.1


