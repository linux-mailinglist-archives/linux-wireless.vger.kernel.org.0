Return-Path: <linux-wireless+bounces-20096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBCA589D7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 02:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BDA167294
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 01:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72D435976;
	Mon, 10 Mar 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ol9rPl2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC514F6C;
	Mon, 10 Mar 2025 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568565; cv=none; b=u9R3RBOPZNN8UMhjgod3aVEHONijQ6a0boDAU7jLzpF5SS30M/xNlf1bBDSoGZn8LRQm9GkNk91FbDUkAUtjjsrxDrKlPLaC6T7grI2btf8567aEkbNqkGEZgyfReoqNRBaVeksNmxTGYTgeDEjaPtDwvLgJxIFjLlofyF6rY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568565; c=relaxed/simple;
	bh=c7XkqoD5QU4j0uOCCVKwxnmsXG1AHhYLP1VQm3TuoA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcEvIMPvTMtT4dZwErYTtyPekAziOh6zslTCvaqfBgCSFsINFOmhhlL67lpJh5+o4eEnqgeqLWeFqs2SJDsazJ8apaWyC0c+V37CDz2akLhFmWJkq5ZdvTUDXszd/dwpEFl0eUUn5kGperVX1lYHSfKRoalhlPhZJwLvLxEY5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ol9rPl2K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529LXgvF009677;
	Mon, 10 Mar 2025 01:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNXqOlaTgzq9RYoXM7r/deIbN8cB/W02WqtkLhrfZkQ=; b=Ol9rPl2K6MAKJ87R
	T/HmAfc18mZLbY1YNRc94HkoEbzKf7A94Qzbf48Obby9QtLCnovt1lfD/OAtmpCE
	GYA44PQ2Iut5/uDske90n3l7MqFkfJNcz8AY2zjOXwxdWfJrYr1TPAGm52fe7Lu6
	p4PRKctW8jOw4CeoajZdFDjBNNDUR7rHi36TFPQg7RGLkY/EPZwE29chGXB35iCU
	QTBwcBCss8WD3V2cGE4Kxqj/XGSNaauAHB/mTecOhprB4zD2mI3j6IrfPQXVvuTf
	4c6NnI/M96YgD+Y4d0CyTX/BBP8ekYMvgqLJPNfRZC5cYlC92HwdSnXUK78Iv3rX
	JlJARA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eypb1th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:02:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A12VWO013908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:02:31 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 9 Mar 2025 18:02:29 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan+linaro@kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v2 ath-next 1/2] wifi: ath11k: add function to get next srng desc
Date: Mon, 10 Mar 2025 09:02:16 +0800
Message-ID: <20250310010217.3845141-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=A9yWP7WG c=1 sm=1 tr=0 ts=67ce3a2e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=lKsAeyGH6LT-Y4EiwrIA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OPv-YiVS16VLNrJGd0MEY-Xb7wjYu00g
X-Proofpoint-GUID: OPv-YiVS16VLNrJGd0MEY-Xb7wjYu00g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_09,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=907
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100006

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


