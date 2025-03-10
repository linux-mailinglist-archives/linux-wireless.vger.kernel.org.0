Return-Path: <linux-wireless+bounces-20098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827ECA589DB
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 02:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF5A169F1F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B335935976;
	Mon, 10 Mar 2025 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ohpoggXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659B14F6C;
	Mon, 10 Mar 2025 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568574; cv=none; b=pY7uYZqDoWSJlOQLMUiUn7WEABpDdnCsShWGje+oJaaE2Lg08NyEcbM58IMV3LINsGhjmRC+yI7qKBtov5yKYK0drJVUxdaizWCVGiJsWt1kB2GOpByIW/rXaXXWrAXH+lKxv6gHSS8E3MuRMh7ydGTm1529nqYJksgbVU7+80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568574; c=relaxed/simple;
	bh=u3Dqu0ugfjezZL9sksgaDDpAYysw1L8gQsi1MZZBcXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2NONIaTzSDUXnYePaEQfG/SsW2r1iR6ewiBd0PcxJ1twKxTr5v1faS5nVnO8HXTrYn7luI6Gy0NxTSLt7Udn6qJkd64R5BzlXW2AhnHszHrGWOk+Y2L9nlQg5X9qkQbXy5ELMpMBe7usMV5HaQ+7YLInvfXj1sd8NNHbgLU8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ohpoggXT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529Ko9Kd017510;
	Mon, 10 Mar 2025 01:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c+Bnz5MXFNxyk70QqOJh4tmnrisC9p1l21NoG0whgJw=; b=ohpoggXTgLWDaHDW
	xlDLn4AlNbXmmU3s2O5mCz890HI0h6ZzwgCsd27VLGpOUMx6rsPk2ABdxKJJa+K0
	XNrPsJ/6i/EWLSjDeTbIKZKw65fyECz/aHSQFH8K+poGheVNNzk4GnGGVoSJN12U
	Zc9pJ1Q7J4rB76CmMzS4u3lgUlNC5Uyo+Wlo5rU6UlkK06LrwnzdX768bDBN9oSs
	NkDyjaoDn9QeylxUQ0RmZ3HM8C6uOWkmYmks5eovLVn3g9PdOERCAupiEce88X/V
	zbY/Pr54QGlP5gc5DIcrSZx+nk+3wThvMA7MPiBEuOWudrIPDlKLXYdSdtEKzQbd
	a7MkgQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt31w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:02:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A12XPk017208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:02:33 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 9 Mar 2025 18:02:31 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan+linaro@kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient length
Date: Mon, 10 Mar 2025 09:02:17 +0800
Message-ID: <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0LH8pJNppikRHyfsPGizh3ulDdqu111o
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67ce3a2a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=oICLHHyMo7b6fcdoYYIA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0LH8pJNppikRHyfsPGizh3ulDdqu111o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_09,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100005

A relatively unusual race condition occurs between host software
and hardware, where the host sees the updated destination ring head
pointer before the hardware updates the corresponding descriptor.
When this situation occurs, the length of the descriptor returns 0.

The current error handling method is to increment descriptor tail
pointer by 1, but 'sw_index' is not updated, causing descriptor and
skb to not correspond one-to-one, resulting in the following error:

ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484

To address this problem, temporarily skip processing the current
descriptor and handle it again next time. However, to prevent this
descriptor from continuously returning 0, use skb cb to set a flag.
If the length returns 0 again, this descriptor will be discarded.

Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ce.c   | 32 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..2573f8c7a994 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "dp_rx.h"
@@ -387,18 +387,36 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
 
 	ath11k_hal_srng_access_begin(ab, srng);
 
-	desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
+	desc = ath11k_hal_srng_dst_peek(ab, srng);
 	if (!desc) {
 		ret = -EIO;
 		goto err;
 	}
 
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
-	if (*nbytes == 0) {
-		ret = -EIO;
-		goto err;
+	if (unlikely(*nbytes == 0)) {
+		struct ath11k_skb_rxcb *rxcb =
+			ATH11K_SKB_RXCB(pipe->dest_ring->skb[sw_index]);
+
+		/* A relatively unusual race condition occurs between host
+		 * software and hardware, where the host sees the updated
+		 * destination ring head pointer before the hardware updates
+		 * the corresponding descriptor.
+		 *
+		 * Temporarily skip processing the current descriptor and handle
+		 * it again next time. However, to prevent this descriptor from
+		 * continuously returning 0, set 'is_desc_len0' flag. If the
+		 * length returns 0 again, this descriptor will be discarded.
+		 */
+		if (!rxcb->is_desc_len0) {
+			rxcb->is_desc_len0 = true;
+			ret = -EIO;
+			goto err;
+		}
 	}
 
+	ath11k_hal_srng_dst_next(ab, srng);
+
 	*skb = pipe->dest_ring->skb[sw_index];
 	pipe->dest_ring->skb[sw_index] = NULL;
 
@@ -430,8 +448,8 @@ static void ath11k_ce_recv_process_cb(struct ath11k_ce_pipe *pipe)
 		dma_unmap_single(ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
 				 max_nbytes, DMA_FROM_DEVICE);
 
-		if (unlikely(max_nbytes < nbytes)) {
-			ath11k_warn(ab, "rxed more than expected (nbytes %d, max %d)",
+		if (unlikely(max_nbytes < nbytes || !nbytes)) {
+			ath11k_warn(ab, "rxed invalid length (nbytes %d, max %d)",
 				    nbytes, max_nbytes);
 			dev_kfree_skb_any(skb);
 			continue;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 1a3d0de4afde..c8614c5c6493 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -128,6 +128,7 @@ struct ath11k_skb_rxcb {
 	bool is_continuation;
 	bool is_mcbc;
 	bool is_eapol;
+	bool is_desc_len0;
 	struct hal_rx_desc *rx_desc;
 	u8 err_rel_src;
 	u8 err_code;
-- 
2.25.1


