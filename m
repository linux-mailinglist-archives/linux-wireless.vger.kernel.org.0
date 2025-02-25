Return-Path: <linux-wireless+bounces-19398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C23A435AC
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 07:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878E07A6878
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C4625A35D;
	Tue, 25 Feb 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mAVqN589"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E925A32D;
	Tue, 25 Feb 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466177; cv=none; b=iog0NV5ogjwZfMyGd2JJf1LWpD1lcS+cJTfwQAnnQEPoMnlvVQBX1DTYTM1ZnQFUd8GwcYrTRSy5ZDJziB0r31mlqlyYf4FyPK2SIVVKhOgHAhQX/sCrwown+UQsqo5hw1agokgZB1sjw1FVAl/MWag8u2nnXgI7FuFioWJJOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466177; c=relaxed/simple;
	bh=xDHgLyGvuYtlEUikeTB8R0RQr87nOTnxzlHmGP+OLZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcenafMtT+FUQwmT5TDP5CxLyUK58pEcGSLZTDdEo4BpmLyRetFnud4VEhK6E2QvElj51gA+yG4dySe571E3vT3G/BWW57fD1I84Gqm7OFTxj0Bl3Axvsj85uLJdyGtisRXbRqkdYlX3vv/iL5CQpu7pOB73w2cFjhXfD+4HvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mAVqN589; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOWZP009201;
	Tue, 25 Feb 2025 06:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nej0K6uSVbQcMiQPF4xc9XZMsNYpA2EFne8SESoOK9U=; b=mAVqN589WiBtlebh
	Ted2+i+9HsrbDGcQph6DnUAqB9c8Z+qq/cUJ6aTJrqR+qF6aOzfSuhuoqz8n7Zob
	agRZudwVf1i30/dhTHAwyV0cym/eK7HzF0l6MwpBCVh6Jpif4WHaWuVVbJK32rYR
	vg896h+J261K9hpnLeUGAL5Go52mc/Y/0UWdcfqLg53IyeHiveAbRBqu+EfZKqn3
	Tnvf07BWa4Ul89uwrajOaNfsFLATAaIq8NgQ9bMKnL/i4DtKgQ/24Q7mdbS+9sTr
	NYoz7c3DJhVFBqNRwaXIsJWSoDMfU0Rgt0i8PMw5mINOHXSeHryhb8N1Las6OsY/
	yfcjMQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6y6qtqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 06:49:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P6nGuP016251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 06:49:16 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Feb 2025 22:49:12 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        P Praneesh
	<quic_ppranees@quicinc.com>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [PATCH v6 03/13] wifi: ath12k: refactor ath12k_hw_regs structure
Date: Tue, 25 Feb 2025 12:18:24 +0530
Message-ID: <20250225064834.2002499-4-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZiSc9804rRYxpSVKXEaIigGRBoQiqDxs
X-Proofpoint-GUID: ZiSc9804rRYxpSVKXEaIigGRBoQiqDxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250043

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
 drivers/net/wireless/ath/ath12k/hal.c | 84 +++++++++++++--------------
 drivers/net/wireless/ath/ath12k/hal.h | 63 +++++++++++---------
 drivers/net/wireless/ath/ath12k/hw.c  | 29 ++++++++-
 drivers/net/wireless/ath/ath12k/hw.h  | 10 +++-
 4 files changed, 114 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index cd59ff8e6c7b..031f76d88bef 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
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
index 94e2e8735958..1ce97f9a92ac 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_H
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
index a106ebed7870..4c9d6c42fbb9 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -619,6 +619,9 @@ static const struct ath12k_hw_regs qcn9274_v1_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -681,6 +684,12 @@ static const struct ath12k_hw_regs qcn9274_v1_regs = {
 
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
@@ -695,6 +704,9 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -761,6 +773,12 @@ static const struct ath12k_hw_regs qcn9274_v2_regs = {
 
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
@@ -775,6 +793,9 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 	.hal_tcl1_ring_msi1_base_msb = 0x0000094c,
 	.hal_tcl1_ring_msi1_data = 0x00000950,
 	.hal_tcl_ring_base_lsb = 0x00000b58,
+	.hal_tcl1_ring_base_lsb = 0x00000900,
+	.hal_tcl1_ring_base_msb = 0x00000904,
+	.hal_tcl2_ring_base_lsb = 0x00000978,
 
 	/* TCL STATUS ring address */
 	.hal_tcl_status_ring_base_lsb = 0x00000d38,
@@ -837,6 +858,12 @@ static const struct ath12k_hw_regs wcn7850_regs = {
 
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
index 8d52182e28ae..acb81b5798ac 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HW_H
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


