Return-Path: <linux-wireless+bounces-19978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51430A55F37
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 05:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203221894DB4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 04:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB518FDD0;
	Fri,  7 Mar 2025 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NqaN565f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4021187346;
	Fri,  7 Mar 2025 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320562; cv=none; b=R0Rwa/NjNOo2TAvBDomXrLnJSVb7cWVhhAoesjixndtbkMDF10ftu5HY1pxfQSTmz9GqetuQWO1UGTbbJomvT31jImaRTsgVvM5dawHVFMT70EBf9/KxPPGeRGexfN94M36Lk/XpUpH20UTuDgv6OwNgz8Df9SKrXgnVpg2jK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320562; c=relaxed/simple;
	bh=c7XkqoD5QU4j0uOCCVKwxnmsXG1AHhYLP1VQm3TuoA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTvLtjZLNYgLYatte1LLMEZT/EkQEXBE6CdUKYl+4vXpRwsGmkva3oxCYjXmmfWM7oJOmMoI1p+hq7UrnUr9ot4GV/8I6IdsxMpnQWvbfdCeVv7apTH+2N+JAiEmfNlrk1uqL5tIrFiLjHZalRjALbnDpOpu7fnMSWeAVPutuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NqaN565f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526NodIj005915;
	Fri, 7 Mar 2025 04:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNXqOlaTgzq9RYoXM7r/deIbN8cB/W02WqtkLhrfZkQ=; b=NqaN565f7BhHgWCa
	K8oloYBzY+U8xlz6Iy9RzqOsP4NXbvuZotB7KEyVO3WUr0taee55mHD6pbR4Lu0s
	hhPWMR2lElx87fcRiTQ1yafhHiItikLyVVIhNOkPhWcYHWOKUqoStGOjWIRkOatX
	0CgsENVR3qGbcPvBDt+k06UDqYCqPiczjnhy8vXAXGpiBGUBRpLgcpf0KIOkRs58
	wzLIJwqFpWcw18R6Sxx4qcAD1q+JeJr8ITBPaU25NMMKNrF08fbMZIlxHhr9QKmb
	DMaAtYgRBxzZZ9VgWmDADXKtxrFLa4W/4U3P2JZ00pvCR9E9PSOnOPUok0Q3raqZ
	UOBgRw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4571sdc15s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 04:09:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52749Gnd030726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 04:09:16 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Mar 2025 20:09:14 -0800
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH ath-next 1/2] wifi: ath11k: add function to get next srng desc
Date: Fri, 7 Mar 2025 12:08:47 +0800
Message-ID: <20250307040848.3822788-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307040848.3822788-1-quic_miaoqing@quicinc.com>
References: <20250307040848.3822788-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ojUUaRqbJ4B4KFqTrBPhVf8baiWQxLUH
X-Authority-Analysis: v=2.4 cv=W6PCVQWk c=1 sm=1 tr=0 ts=67ca716c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=lKsAeyGH6LT-Y4EiwrIA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ojUUaRqbJ4B4KFqTrBPhVf8baiWQxLUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=892 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070025

Adding the ath11k_hal_srng_dst_next() function allows for the
separate invocation of ath11k_hal_srng_dst_peek() and
ath11k_hal_srng_dst_next() in certain situations, instead of
calling the ath11k_hal_srng_dst_get_next_entry() function alone.

Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.c | 24 ++++++++++++++----------
 drivers/net/wireless/ath/ath11k/hal.h |  3 ++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 61f4b6dd5380..2fc8409897be 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
@@ -656,18 +656,10 @@ static void ath11k_hal_srng_prefetch_desc(struct ath11k_base *ab,
 	}
 }
 
-u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
-					struct hal_srng *srng)
+void ath11k_hal_srng_dst_next(struct ath11k_base *ab, struct hal_srng *srng)
 {
-	u32 *desc;
-
 	lockdep_assert_held(&srng->lock);
 
-	if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
-		return NULL;
-
-	desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
-
 	srng->u.dst_ring.tp += srng->entry_size;
 
 	/* wrap around to start of ring*/
@@ -677,6 +669,18 @@ u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
 	/* Try to prefetch the next descriptor in the ring */
 	if (srng->flags & HAL_SRNG_FLAGS_CACHED)
 		ath11k_hal_srng_prefetch_desc(ab, srng);
+}
+
+u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
+					struct hal_srng *srng)
+{
+	u32 *desc;
+
+	lockdep_assert_held(&srng->lock);
+
+	desc = ath11k_hal_srng_dst_peek(ab, srng);
+	if (desc)
+		ath11k_hal_srng_dst_next(ab, srng);
 
 	return desc;
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 601542410c75..317b09ec6c35 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HAL_H
@@ -941,6 +941,7 @@ int ath11k_hal_srng_get_entrysize(struct ath11k_base *ab, u32 ring_type);
 int ath11k_hal_srng_get_max_entries(struct ath11k_base *ab, u32 ring_type);
 void ath11k_hal_srng_get_params(struct ath11k_base *ab, struct hal_srng *srng,
 				struct hal_srng_params *params);
+void ath11k_hal_srng_dst_next(struct ath11k_base *ab, struct hal_srng *srng);
 u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
 					struct hal_srng *srng);
 u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng);
-- 
2.25.1


