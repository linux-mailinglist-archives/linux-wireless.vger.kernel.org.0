Return-Path: <linux-wireless+bounces-19552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04FA48896
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 20:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51574188BDB1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE9F26F443;
	Thu, 27 Feb 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ASvu0SGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B526E976;
	Thu, 27 Feb 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683478; cv=none; b=syBS3EVjiOX2PQstaqyMJLTeSitHKBMPfBWWQoUTDtzLEOS2Nl6MgOd/e+d3HAK5jAr6zYVyaf0ejH8jLDqolyw2Q7GQA6VgIvxrAvLNJ+WhqRSXWs3awT4We1DosSp9nRsARTpfyS7f06MxdWhLxchxqWE4CAqryT0yVOwRoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683478; c=relaxed/simple;
	bh=7Ky7CtAMlMehe61tbyl3+yZV6uwxPH5vtaqP/4LfWxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsGpGVSQuEvjb0e1aNGef8qRo9Msytww/czXSte9P7+tqd/vvBmCjb9NPDZ74LxcnHtGEc9cfjmolG7UCT7I4onxUWiI/eoMrU1cUtDj7epxxp16mgUN/i67ZaeRO/4IfAN1xRbjncPVwhIvybwWCx9mraN89hiUtGkWTznrNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ASvu0SGU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJ0AmR011930;
	Thu, 27 Feb 2025 19:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PrRWzYLmOKa47EDMkXBJ7b4YmQZcn1nRg06uVSpWQwc=; b=ASvu0SGUCY3l9/7E
	C1CJB0vFHb78BxGubXmp4FK2iWdghWZ7atuMqE81X10SHh5QbDs704ajmMA61miA
	shwzJ0GWz0ac3gV3LZzzMrgFEjqXpmTzlPPOBZykzM9IEKchs6cKtlDhlj5zGJNW
	aLbd1Uz1qv36xdRa5d75ZoGyNptTsfTbFY8jqKeKL3LKqgZuCBJ6avUpW8u4I9p3
	GhMWYxmsj4sE0yf5Qb5et8KcRwzl4BIkBvA3dWg40EkbtGyK2vnCIR7SA2pzZpfp
	z8yrqbLRZ3m9nsV7K7mtvdH9LhJnxWBE86LenMCfG5u60qh9k2/8101iRxtGkYVT
	nVPtjA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkesb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RJB641027745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:06 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 11:11:02 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v7 02/13] wifi: ath12k: fix incorrect CE addresses
Date: Fri, 28 Feb 2025 00:40:23 +0530
Message-ID: <20250227191034.1949954-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: scQ_RC_v7tyKplpgOxEco8PugC-VwFgl
X-Proofpoint-ORIG-GUID: scQ_RC_v7tyKplpgOxEco8PugC-VwFgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=898 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270142

From: Balamurugan S <quic_bselvara@quicinc.com>

In the current ath12k implementation, the CE addresses
CE_HOST_IE_ADDRESS and CE_HOST_IE_2_ADDRESS are incorrect. These
values were inherited from ath11k, but ath12k does not currently use
them.

However, the Ath12k AHB support relies on these addresses. Therefore,
correct the CE addresses for ath12k.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ce.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 1a14b9fb86b8..f85188af5de2 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CE_H
@@ -39,8 +39,8 @@
 #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
 
 /* CE address/mask */
-#define CE_HOST_IE_ADDRESS	0x00A1803C
-#define CE_HOST_IE_2_ADDRESS	0x00A18040
+#define CE_HOST_IE_ADDRESS	0x75804C
+#define CE_HOST_IE_2_ADDRESS	0x758050
 #define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
 
 #define CE_HOST_IE_3_SHIFT	0xC
-- 
2.34.1


