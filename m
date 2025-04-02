Return-Path: <linux-wireless+bounces-21085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE25A7921B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0848C3B3C7F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142A23BCEE;
	Wed,  2 Apr 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oYA3Apez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633923A9BD
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607566; cv=none; b=XATJZHGX/NldMjkq71asB+0rfT13emy7HOu5FdH0+C1XU37ZYVSfU8Tfb1LcSWdpZvb8/IozDInqd6U9FiHIkmZyVft9goCbdrQzfeZl/NctXuDM5Hp3D5g7aAPnvGbD2bIjq0WHyMJqt6MvRZQlZrzpbkE52OJemulcG+GwJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607566; c=relaxed/simple;
	bh=c3xO7MppXJV4uqeEhELnFfEJmR+PCWKIZn41toNgbso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tR75lvklPupdZ00h/tppEJm5DVs673O6Vw3FWfAmKv1Yei9C9/COplC8XxImaK4d/mHThf6WaIwqv0oI19j2A0MksK8iiLKbYzreFrRYGkXbbmg2q5qlbGALg3YcKyC9S5DR1E+yRheKp2V9NnlWNgRRqkNXIz3vB/axCRO9x/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oYA3Apez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5329oBNs030905;
	Wed, 2 Apr 2025 15:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aJ48R6XKt7iRv19XHOvGz4od
	e5It7i0imaSEJbTnoVA=; b=oYA3Apezt8e5Cd76MDSZQihN9LQt88UNOyaVIID1
	7GWUtBuIPFN9npqSpt/pKLf03JMIIgIxgp/S3gOjTeNKDFcwzh0C13sghWspPR+8
	qNpbjw1umS8Q3tBxjas/DK14oZqY5jrOOFM86R8+ZV4Tao+c5fm9u1SulNvUv9Fv
	ak43LogynzUZW4KRkwa9PoS3bLKPqgeElgChRqLdjbdlfjjwKdcQ56/GZQPjW8A3
	p5iWKduwQukSxbbSDwo6oE9HUyTOqe/nbDXXU5rGSFY6VoZyVZLgwwt5l/JcE7j2
	nPVnjScngzUd92HC6YGT37CbI2cGXB/AMc87a0mjYTdrGw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45recpm8ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:26:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 532FPxH8027576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 15:25:59 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 2 Apr 2025 08:25:58 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH ath-next v4 2/3] wifi: ath12k: Add support to clear qdesc array in REO cache
Date: Wed, 2 Apr 2025 20:55:28 +0530
Message-ID: <20250402152529.1649402-3-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250402152529.1649402-1-quic_nithp@quicinc.com>
References: <20250402152529.1649402-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GKi-AQAet8-0GDxZO66zLuUDjzdE0Ag5
X-Proofpoint-ORIG-GUID: GKi-AQAet8-0GDxZO66zLuUDjzdE0Ag5
X-Authority-Analysis: v=2.4 cv=J4Sq7BnS c=1 sm=1 tr=0 ts=67ed5708 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=lEbe62fs0_Yq6iMSaFAA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxlogscore=883 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020098

From: Balamurugan S <quic_bselvara@quicinc.com>

Currently, the existing code lacks functionality to clear the qdesc
array in the REO cache. As a result, any updates in the LUT are not
reflected in the REO cache. To address this issue, add functionality
to clear the qdesc array in the REO cache during a peer TID update.
To do this, set the CLEAR_DESC_ARRAY field of
WCSS_UMAC_REO_R0_QDESC_ADDR_READ and then reset it.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  1 +
 drivers/net/wireless/ath/ath12k/hal.h    |  1 +
 drivers/net/wireless/ath/ath12k/hal_rx.c | 19 ++++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 81e036f1d70f..48d907a400b3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -762,6 +762,7 @@ static void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u
 	qref->info1 = u32_encode_bits(upper_32_bits(paddr),
 				      BUFFER_ADDR_INFO1_ADDR) |
 		      u32_encode_bits(tid, DP_REO_QREF_NUM);
+	ath12k_hal_reo_shared_qaddr_cache_clear(ab);
 }
 
 static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u16 tid)
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 76bb095c62e6..339812d38338 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1172,4 +1172,5 @@ int ath12k_hal_srng_update_shadow_config(struct ath12k_base *ab,
 void ath12k_hal_srng_shadow_config(struct ath12k_base *ab);
 void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
 					 struct hal_srng *srng);
+void ath12k_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index ac17d6223fa7..98eeccc68fcd 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "debug.h"
@@ -851,3 +851,20 @@ void ath12k_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 	ath12k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
 			   ring_hash_map);
 }
+
+void ath12k_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab)
+{
+	u32 val;
+
+	lockdep_assert_held(&ab->base_lock);
+	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
+				HAL_REO1_QDESC_ADDR(ab));
+
+	val |= u32_encode_bits(1, HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY);
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
+			   HAL_REO1_QDESC_ADDR(ab), val);
+
+	val &= ~HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY;
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
+			   HAL_REO1_QDESC_ADDR(ab), val);
+}
-- 
2.17.1


