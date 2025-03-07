Return-Path: <linux-wireless+bounces-19979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBECA55F39
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 05:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095803B35FB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 04:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC6192B77;
	Fri,  7 Mar 2025 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VSg8BI6D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBD188CB1;
	Fri,  7 Mar 2025 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320562; cv=none; b=ALpEP9lpD2m+sf8oO0P2k6t65hg6XXQpTndKKmdfTsISiclr/AeRdhdN0eu+DWTrsUAXszGezhb8jxiVTROhGBTbnvC3UlE8Gse0i6AdmU328q+i45YeFEFmWq/Hx0OmapZQvZHicHeS6tmrFp5u3iOaHVA6Z8nkXx6UVWyazjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320562; c=relaxed/simple;
	bh=cuKt24kcAjKveIAjgD+wLPLZB4CR5DPDJK7/xqFPahY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLhw+Vm17OeqlHDXOZrHGu+XY9I5YSG3ifi6gIPU2+Jib9PJqYUBTcqUIzd08yoZa2sz94rWFB6WKKYIpoXOhrWfKx3WU27Ru6gxB2Ewvtcr8ZeRfuz2X12yHLQEWbw8XuCTLC7R8QefSyoKs01M3565eihGzj1s8oGvJZaGCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VSg8BI6D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526KZUNI013728;
	Fri, 7 Mar 2025 04:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNe6MduAMikPyxEIVcb5geDLRDx+MJDGHts/3q8VcXE=; b=VSg8BI6DcxvI3vXM
	vl+gYfmz0QAyNJA6p/VNy4ibhxfffK+C36WRvuCiul2gIaKWlmiDV7jWhFtFXSit
	/q7AEwcOASWaTJl0IyEyyD3s0azwujVUybwpv1lMJZLw1U0nOylhV1RcSc10gFm9
	SvpL+IidUNuOAzoqkozw+UuX0SDWO58lCR91E+eMArekw4oGxBRsQKW6nhp5FD8f
	i1AP5Bad88cZhO1beBbsho2CHafiQJq/8oBZoAPW7zzLLJj4yN80j5w3VBkx/dVx
	05u8YwBe8MPU/KxMiSaOX2Ij7PSqEULHIEECj5fkVeDkFiTm+Ux3xs5HGpHR70zA
	2gVhTw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457jvdrxm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 04:09:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52749I87008564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 04:09:18 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Mar 2025 20:09:16 -0800
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH ath-next 2/2] wifi: ath11k: fix HTC rx insufficient length
Date: Fri, 7 Mar 2025 12:08:48 +0800
Message-ID: <20250307040848.3822788-3-quic_miaoqing@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=W8XCVQWk c=1 sm=1 tr=0 ts=67ca716e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=YcQLN9OU0fFkaZwozdwA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6PVMUoo7SUeJHmgDbEowjSsiwZhQh2Wv
X-Proofpoint-ORIG-GUID: 6PVMUoo7SUeJHmgDbEowjSsiwZhQh2Wv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070025

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


