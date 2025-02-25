Return-Path: <linux-wireless+bounces-19400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E652A435B7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 07:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29F317CDD4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 06:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3C25B685;
	Tue, 25 Feb 2025 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QFV42P7+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5325B66A;
	Tue, 25 Feb 2025 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466185; cv=none; b=nXdOyp2Kthn26q7YXbjW24WtvqabzgAyumLEgrjja3aaOjNm7Yj20xxS+gapLaq4E7EFiS5itKl/m7KBN6KTwwan2K2tmY7S+sQ3RSRdFyc5u7fAIwPFIaUjyzz7BZg8JKA81tz6lcneDSzZvjmgaV2udSYsDuXP1o18T3BNI8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466185; c=relaxed/simple;
	bh=rYFgbwx0U0yLgoxIm9IpntcjfohcEO6edQrvuld+yJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivkexp0gUYjiSLyHG0WrY4TAmqaVeey0cfdPeezQ8zh+bx+7zSLzAehv3kY4J9n0PvHfFe9BscdCVhhsFhf1M2eI2NylE4eI1HST35KJwVWDoWmPRdYLzXV/svKHe3zNMK34v5DxhGGvXujv4y3dWDLrEyihgikHmTxY0TANG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QFV42P7+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOJU4013318;
	Tue, 25 Feb 2025 06:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hpf8v8rkdusIOUTQRWo4fqdOLKWWXPO2sa2q17KPJ6Q=; b=QFV42P7+aAWvsTJV
	m5aZRvOoi0LqWB12sbv+6cV4eMlxGKtg/zShXSiSi0MCXCy1CQdoge/xkTIYR4iZ
	TUhrjO9JNrkekdjvIvP9BaZhwFQG1tBSLqw+IhZehQMmYHEb/k1KDDgX6S60myBs
	XcqB4eomRnz3NQS3eyvsS2sGNZ+cCqz3DFcj9N6/7tibkoNNflQhOK3T1EuFIjam
	qi/0fFlJhz++AojGm8KSc+YrGFlafPOq8EeEwhzvyVdN0m8sbKv/PSKN4v8aDi1a
	MUKs2QNP+qkDDLe5z8guTYUqKvM4V8izjxbu8V2UjDSH18JNN9PbAt9By/NGYuX+
	l/tvSQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgqwa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 06:49:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P6nKRR022930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 06:49:20 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Feb 2025 22:49:16 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [PATCH v6 04/13] wifi: ath12k: add ath12k_hw_params for IPQ5332
Date: Tue, 25 Feb 2025 12:18:25 +0530
Message-ID: <20250225064834.2002499-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225064834.2002499-1-quic_rajkbhag@quicinc.com>
References: <20250225064834.2002499-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: NUQ4Re4QX8ElARJz2-BriUrsbSxDlaQi
X-Proofpoint-ORIG-GUID: NUQ4Re4QX8ElARJz2-BriUrsbSxDlaQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250043

From: Balamurugan S <quic_bselvara@quicinc.com>

Add ath12k_hw_params for new ath12k AHB based WiFi device IPQ5332.
Some hardware parameters like hw_ops, wmi_init & hal_ops are same
between IPQ5332 and QCN9274, hence use these same parameters for
IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ce.c   |  92 +++++-
 drivers/net/wireless/ath/ath12k/ce.h   |   1 +
 drivers/net/wireless/ath/ath12k/core.h |   3 +-
 drivers/net/wireless/ath/ath12k/hw.c   | 415 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/qmi.h  |   3 +-
 5 files changed, 511 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index be0d669d31fc..7a5656aceebe 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "dp_rx.h"
@@ -219,6 +219,96 @@ const struct ce_attr ath12k_host_ce_config_wcn7850[] = {
 
 };
 
+const struct ce_attr ath12k_host_ce_config_ipq5332[] = {
+	/* CE0: host->target HTC control and raw streams */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 16,
+		.src_sz_max = 2048,
+		.dest_nentries = 0,
+	},
+	/* CE1: target->host HTT + HTC control */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 512,
+		.recv_cb = ath12k_htc_rx_completion_handler,
+	},
+	/* CE2: target->host WMI */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 128,
+		.recv_cb = ath12k_htc_rx_completion_handler,
+	},
+	/* CE3: host->target WMI */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 32,
+		.src_sz_max = 2048,
+		.dest_nentries = 0,
+	},
+	/* CE4: host->target HTT */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 2048,
+		.src_sz_max = 256,
+		.dest_nentries = 0,
+	},
+	/* CE5: target -> host PKTLOG */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 512,
+		.recv_cb = ath12k_dp_htt_htc_t2h_msg_handler,
+	},
+	/* CE6: Target autonomous HIF_memcpy */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 0,
+		.src_sz_max = 0,
+		.dest_nentries = 0,
+	},
+	/* CE7: CV Prefetch */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 0,
+		.src_sz_max = 0,
+		.dest_nentries = 0,
+	},
+	/* CE8: Target HIF memcpy (Generic HIF memcypy) */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 0,
+		.src_sz_max = 0,
+		.dest_nentries = 0,
+	},
+	/* CE9: WMI logging/CFR/Spectral/Radar */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 128,
+	},
+	/* CE10: Unused */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 0,
+		.src_sz_max = 0,
+		.dest_nentries = 0,
+	},
+	/* CE11: Unused */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 0,
+		.src_sz_max = 0,
+		.dest_nentries = 0,
+	},
+};
+
 static int ath12k_ce_rx_buf_enqueue_pipe(struct ath12k_ce_pipe *pipe,
 					 struct sk_buff *skb, dma_addr_t paddr)
 {
diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index f85188af5de2..8007a94cec5d 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -164,6 +164,7 @@ struct ath12k_ce {
 
 extern const struct ce_attr ath12k_host_ce_config_qcn9274[];
 extern const struct ce_attr ath12k_host_ce_config_wcn7850[];
+extern const struct ce_attr ath12k_host_ce_config_ipq5332[];
 
 void ath12k_ce_cleanup_pipes(struct ath12k_base *ab);
 void ath12k_ce_rx_replenish_retry(struct timer_list *t);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3fac4f00d383..553965f12fcd 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -147,7 +147,8 @@ struct ath12k_skb_rxcb {
 enum ath12k_hw_rev {
 	ATH12K_HW_QCN9274_HW10,
 	ATH12K_HW_QCN9274_HW20,
-	ATH12K_HW_WCN7850_HW20
+	ATH12K_HW_WCN7850_HW20,
+	ATH12K_HW_IPQ5332_HW10,
 };
 
 enum ath12k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 4c9d6c42fbb9..86c4ce143169 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -535,6 +535,217 @@ static const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_wcn7850
 	},
 };
 
+static const struct ce_pipe_config ath12k_target_ce_config_wlan_ipq5332[] = {
+	/* host->target HTC control and raw streams */
+	{
+		.pipenum = __cpu_to_le32(0),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* target->host HTT */
+	{
+		.pipenum = __cpu_to_le32(1),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* target->host WMI  + HTC control */
+	{
+		.pipenum = __cpu_to_le32(2),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* host->target WMI */
+	{
+		.pipenum = __cpu_to_le32(3),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* host->target HTT */
+	{
+		.pipenum = __cpu_to_le32(4),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(256),
+		.nbytes_max = __cpu_to_le32(256),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS | CE_ATTR_DIS_INTR),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* Target -> host PKTLOG */
+	{
+		.pipenum = __cpu_to_le32(5),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* Reserved for target autonomous HIF_memcpy */
+	{
+		.pipenum = __cpu_to_le32(6),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(16384),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* CE7 Reserved for CV Prefetch */
+	{
+		.pipenum = __cpu_to_le32(7),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* CE8 Reserved for target generic HIF memcpy */
+	{
+		.pipenum = __cpu_to_le32(8),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(16384),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* CE9 WMI logging/CFR/Spectral/Radar/ */
+	{
+		.pipenum = __cpu_to_le32(9),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* Unused TBD */
+	{
+		.pipenum = __cpu_to_le32(10),
+		.pipedir = __cpu_to_le32(PIPEDIR_NONE),
+		.nentries = __cpu_to_le32(0),
+		.nbytes_max = __cpu_to_le32(0),
+		.flags = __cpu_to_le32(0),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* Unused TBD */
+	{
+		.pipenum = __cpu_to_le32(11),
+		.pipedir = __cpu_to_le32(PIPEDIR_NONE),
+		.nentries = __cpu_to_le32(0),
+		.nbytes_max = __cpu_to_le32(0),
+		.flags = __cpu_to_le32(0),
+		.reserved = __cpu_to_le32(0),
+	},
+};
+
+static const struct service_to_pipe ath12k_target_service_to_ce_map_wlan_ipq5332[] = {
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_VO),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_VO),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_BK),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_BK),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_BE),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_BE),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_VI),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_DATA_VI),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_CONTROL),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_CONTROL),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_RSVD_CTRL),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(0),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_RSVD_CTRL),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(1),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(0),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(1),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_HTT_DATA_MSG),
+		__cpu_to_le32(PIPEDIR_OUT),
+		__cpu_to_le32(4),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_HTT_DATA_MSG),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(1),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_PKT_LOG),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(5),
+	},
+	{
+		__cpu_to_le32(ATH12K_HTC_SVC_ID_WMI_CONTROL_DIAG),
+		__cpu_to_le32(PIPEDIR_IN),
+		__cpu_to_le32(9),
+	},
+	/* (Additions here) */
+
+	{ /* must be last */
+		__cpu_to_le32(0),
+		__cpu_to_le32(0),
+		__cpu_to_le32(0),
+	},
+};
+
 static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
 	.tx  = {
 		ATH12K_TX_RING_MASK_0,
@@ -577,6 +788,46 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
 	},
 };
 
+static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_ipq5332 = {
+	.tx  = {
+		ATH12K_TX_RING_MASK_0,
+		ATH12K_TX_RING_MASK_1,
+		ATH12K_TX_RING_MASK_2,
+		ATH12K_TX_RING_MASK_3,
+	},
+	.rx_mon_dest = {
+		0, 0, 0, 0, 0, 0, 0, 0,
+		ATH12K_RX_MON_RING_MASK_0,
+	},
+	.rx = {
+		0, 0, 0, 0,
+		ATH12K_RX_RING_MASK_0,
+		ATH12K_RX_RING_MASK_1,
+		ATH12K_RX_RING_MASK_2,
+		ATH12K_RX_RING_MASK_3,
+	},
+	.rx_err = {
+		0, 0, 0,
+		ATH12K_RX_ERR_RING_MASK_0,
+	},
+	.rx_wbm_rel = {
+		0, 0, 0,
+		ATH12K_RX_WBM_REL_RING_MASK_0,
+	},
+	.reo_status = {
+		0, 0, 0,
+		ATH12K_REO_STATUS_RING_MASK_0,
+	},
+	.host2rxdma = {
+		0, 0, 0,
+		ATH12K_HOST2RXDMA_RING_MASK_0,
+	},
+	.tx_mon_dest = {
+		ATH12K_TX_MON_RING_MASK_0,
+		ATH12K_TX_MON_RING_MASK_1,
+	},
+};
+
 static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_wcn7850 = {
 	.tx  = {
 		ATH12K_TX_RING_MASK_0,
@@ -781,6 +1032,90 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_umac_ce1_dest_reg_base = 0x01b83000,
 };
 
+static const struct ath12k_hw_regs ipq5332_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_id = 0x00000918,
+	.hal_tcl1_ring_misc = 0x00000920,
+	.hal_tcl1_ring_tp_addr_lsb = 0x0000092c,
+	.hal_tcl1_ring_tp_addr_msb = 0x00000930,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000940,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000944,
+	.hal_tcl1_ring_msi1_base_lsb = 0x00000958,
+	.hal_tcl1_ring_msi1_base_msb = 0x0000095c,
+	.hal_tcl1_ring_base_lsb = 0x00000910,
+	.hal_tcl1_ring_base_msb = 0x00000914,
+	.hal_tcl1_ring_msi1_data = 0x00000960,
+	.hal_tcl2_ring_base_lsb = 0x00000988,
+	.hal_tcl_ring_base_lsb = 0x00000b68,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x00000d48,
+
+	/* REO DEST ring address */
+	.hal_reo2_ring_base = 0x00000578,
+	.hal_reo1_misc_ctrl_addr = 0x00000b9c,
+	.hal_reo1_sw_cookie_cfg0 = 0x0000006c,
+	.hal_reo1_sw_cookie_cfg1 = 0x00000070,
+	.hal_reo1_qdesc_lut_base0 = 0x00000074,
+	.hal_reo1_qdesc_lut_base1 = 0x00000078,
+	.hal_reo1_ring_base_lsb = 0x00000500,
+	.hal_reo1_ring_base_msb = 0x00000504,
+	.hal_reo1_ring_id = 0x00000508,
+	.hal_reo1_ring_misc = 0x00000510,
+	.hal_reo1_ring_hp_addr_lsb = 0x00000514,
+	.hal_reo1_ring_hp_addr_msb = 0x00000518,
+	.hal_reo1_ring_producer_int_setup = 0x00000524,
+	.hal_reo1_ring_msi1_base_lsb = 0x00000548,
+	.hal_reo1_ring_msi1_base_msb = 0x0000054C,
+	.hal_reo1_ring_msi1_data = 0x00000550,
+	.hal_reo1_aging_thres_ix0 = 0x00000B28,
+	.hal_reo1_aging_thres_ix1 = 0x00000B2C,
+	.hal_reo1_aging_thres_ix2 = 0x00000B30,
+	.hal_reo1_aging_thres_ix3 = 0x00000B34,
+
+	/* REO Exception ring address */
+	.hal_reo2_sw0_ring_base = 0x000008c0,
+
+	/* REO Reinject ring address */
+	.hal_sw2reo_ring_base = 0x00000320,
+	.hal_sw2reo1_ring_base = 0x00000398,
+
+	/* REO cmd ring address */
+	.hal_reo_cmd_ring_base = 0x000002A8,
+
+	/* REO status ring address */
+	.hal_reo_status_ring_base = 0x00000aa0,
+
+	/* WBM idle link ring address */
+	.hal_wbm_idle_ring_base_lsb = 0x00000d3c,
+	.hal_wbm_idle_ring_misc_addr = 0x00000d4c,
+	.hal_wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.hal_wbm_r0_idle_list_size_addr = 0x00000244,
+	.hal_wbm_scattered_ring_base_lsb = 0x00000250,
+	.hal_wbm_scattered_ring_base_msb = 0x00000254,
+	.hal_wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.hal_wbm_scattered_desc_head_info_ix1   = 0x00000264,
+	.hal_wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.hal_wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.hal_wbm_scattered_desc_ptr_hp_addr = 0x0000027c,
+
+	/* SW2WBM release ring address */
+	.hal_wbm_sw_release_ring_base_lsb = 0x0000037c,
+
+	/* WBM2SW release ring address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000e08,
+	.hal_wbm1_release_ring_base_lsb = 0x00000e80,
+
+	/* PPE release ring address */
+	.hal_ppe_rel_ring_base = 0x0000046c,
+
+	/* CE address */
+	.hal_umac_ce0_src_reg_base = 0x00740000,
+	.hal_umac_ce0_dest_reg_base = 0x00741000,
+	.hal_umac_ce1_src_reg_base = 0x00742000,
+	.hal_umac_ce1_dest_reg_base = 0x00743000,
+};
+
 static const struct ath12k_hw_regs wcn7850_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_id = 0x00000908,
@@ -883,6 +1218,15 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_wcn7850 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
+static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
+	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
+};
+
 static const struct ath12k_hw_params ath12k_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -1116,6 +1460,77 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.supports_aspm = false,
 	},
+	{
+		.name = "ipq5332 hw1.0",
+		.hw_rev = ATH12K_HW_IPQ5332_HW10,
+		.fw = {
+			.dir = "IPQ5332/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+		},
+		.max_radios = 1,
+		.single_pdev_only = false,
+		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
+		.internal_sleep_clock = false,
+
+		.hw_ops = &qcn9274_ops,
+		.regs = &ipq5332_regs,
+		.ring_mask = &ath12k_hw_ring_mask_ipq5332,
+
+		.host_ce_config = ath12k_host_ce_config_ipq5332,
+		.ce_count = 12,
+		.target_ce_config = ath12k_target_ce_config_wlan_ipq5332,
+		.target_ce_count = 12,
+		.svc_to_ce_map = ath12k_target_service_to_ce_map_wlan_ipq5332,
+		.svc_to_ce_map_len = 18,
+
+		.hal_params = &ath12k_hw_hal_params_ipq5332,
+
+		.rxdma1_enable = false,
+		.num_rxdma_per_pdev = 1,
+		.num_rxdma_dst_ring = 0,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP) |
+				   BIT(NL80211_IFTYPE_MESH_POINT),
+		.supports_monitor = false,
+
+		.idle_ps = false,
+		.download_calib = true,
+		.supports_suspend = false,
+		.tcl_ring_retry = true,
+		.reoq_lut_support = false,
+		.supports_shadow_regs = false,
+
+		.num_tcl_banks = 48,
+		.max_tx_ring = 4,
+
+		.wmi_init = &ath12k_wmi_init_qcn9274,
+
+		.hal_ops = &hal_qcn9274_ops,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
+
+		.rddm_size = 0,
+
+		.def_num_link = 0,
+		.max_mlo_peer = 256,
+
+		.otp_board_id_register = 0,
+
+		.supports_sta_ps = false,
+
+		.acpi_guid = NULL,
+		.supports_dynamic_smps_6ghz = false,
+		.iova_mask = 0,
+		.supports_aspm = false,
+	},
 };
 
 int ath12k_hw_init(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 45d7c3fcafdd..7c44ced22c6f 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_QMI_H
@@ -21,6 +21,7 @@
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_WCN7850 0x1
 
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9274	0x07
+#define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332	0x2
 #define ATH12K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
 #define ATH12K_QMI_RESP_LEN_MAX			8192
 #define ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	52
-- 
2.34.1


