Return-Path: <linux-wireless+bounces-20368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC0FA60900
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 07:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48A916D8F8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 06:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E61624DF;
	Fri, 14 Mar 2025 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NeamgjWy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128DA15B984;
	Fri, 14 Mar 2025 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932856; cv=none; b=kwjaHZVv0hU/+4AQ43X92CQD8KWiPxq9i1kTTg0ZC5pN4xAeZ8qMgRG3f0pKz4qT01+ipVaywJOHhex0p0/h7QACJYMupRW19nMUFKv891e6KESeYwI3msl/ZyhfrvbASyUUA8r4sthXf8W+PHVMv/wFtGXDDNq0KQm53SCqlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932856; c=relaxed/simple;
	bh=NEUKRURqlOXudhH45CurTjmBjowD5nSr4daAUMFShT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQaFK+833xnywDVKBCIGxQNzLDloYxXgJeaiOOCOhblCCJ/rxzMvYW9AaXKDU2taMfYiYjSLLzyG4CKvzhRHG5vOToiTXVvPBLMfbJK74EYCQeSge8EnYmB3PoNAfOXwiowodTk7zNo0Le6EpyCilpcw+pKLBRzZiEkE8pzDV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NeamgjWy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DH0xi6019804;
	Fri, 14 Mar 2025 06:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2QvSlH6lLhBq8ArBnm2OoQX6qj1Joe9BeHBufNukyAY=; b=NeamgjWy0T3CG7+A
	DISZiav142qSC1B/sI2z2Cm4XDeEnqv/8I/lIoDE9Q+ezL6qvObTdGsTgvIL6Q3w
	72KURfpZiFUdl2fSZduFcz1xKuw/iyFvggYfMdGxFC6rTvUY+r2jIaeYZ3+QvBUq
	Ly/Q38ZkTzi/+Lja9LHBEr6qELsWEzAJhBTzee0fbpwCLd1l5WJ8X8/97AxLfMdU
	Ho1TwA2JOMIlqp3rx6SOnvh6SpMzCjgJoZmjVukHGOtNnFe/8HATMc6z7pJT0IXK
	nQKtc5o/i7GdRvz6w0APovcD6H+KEvb7hwUzIjh0XG4FbuAXIusbr6BWu9nEi9AQ
	zX8/VA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bts0k9vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 06:14:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52E6E8NM017695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 06:14:08 GMT
Received: from localhost.localdomain (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 23:14:06 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan+linaro@kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v3 ath-next 1/2] wifi: ath11k: add function to get next srng desc
Date: Fri, 14 Mar 2025 14:13:52 +0800
Message-ID: <20250314061353.106194-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314061353.106194-1-quic_miaoqing@quicinc.com>
References: <20250314061353.106194-1-quic_miaoqing@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4Pu8OtvrwuKBVLIeazYZ76yCQ6o_FK8a
X-Authority-Analysis: v=2.4 cv=DNSP4zNb c=1 sm=1 tr=0 ts=67d3c931 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=wFPo1YcO-awHL2IpnCwA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4Pu8OtvrwuKBVLIeazYZ76yCQ6o_FK8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=994
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

Adding the ath11k_hal_srng_dst_next() function allows for the
separate invocation of ath11k_hal_srng_dst_peek() and
ath11k_hal_srng_dst_next() in certain situations, instead of
calling the ath11k_hal_srng_dst_get_next_entry() function alone.

Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.c | 17 ++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hal.h |  3 ++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 61f4b6dd5380..211c085921b6 100644
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
@@ -656,6 +656,21 @@ static void ath11k_hal_srng_prefetch_desc(struct ath11k_base *ab,
 	}
 }
 
+void ath11k_hal_srng_dst_next(struct ath11k_base *ab, struct hal_srng *srng)
+{
+	lockdep_assert_held(&srng->lock);
+
+	srng->u.dst_ring.tp += srng->entry_size;
+
+	/* wrap around to start of ring*/
+	if (srng->u.dst_ring.tp == srng->ring_size)
+		srng->u.dst_ring.tp = 0;
+
+	/* Try to prefetch the next descriptor in the ring */
+	if (srng->flags & HAL_SRNG_FLAGS_CACHED)
+		ath11k_hal_srng_prefetch_desc(ab, srng);
+}
+
 u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
 					struct hal_srng *srng)
 {
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


