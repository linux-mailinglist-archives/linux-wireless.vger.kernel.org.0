Return-Path: <linux-wireless+bounces-4938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F118808E0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 02:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F73284A9B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 01:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE384522F;
	Wed, 20 Mar 2024 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ikhg9kGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6264C90
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896803; cv=none; b=tvMpvG1R56ZCxtAZKrVBbGhrnslzvzehQ2iAbCI5jYzyXJc7/K2wgkL+SUFKlmkqJBmvmxW8wmgJ97oKr1c4pmz1+eiJYzI6p/5a1vBztsgmbJaomcSg6oHQpbENuxUjaSbfN5tz1mG0hh1p2JCiqU+RQzO98Awj/ogeq7U78LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896803; c=relaxed/simple;
	bh=BswgVwet0J1iiomw+BzU2YYJCD31yL0733y/fU+Ptrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9IWSVvW14bSD9eRHPNOB3eZwcBUmgFkkTLSmdAfm4vzqN3ND8A5QVBsnhPAf2CUP7CNsnPDDrype9pjjXkg2Dq4fpNZuosjYK9gtWutHCgoz4RW8vdmcYGvbC+HUIJyvH99yf0oA80ZbaE+Pxltkx05KrCXhe2Gcaotjil3NvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ikhg9kGp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K0wwE0024144;
	Wed, 20 Mar 2024 01:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=t/h71+wlEHwsYZEPUlyMmXrPN2hMz8pUG7Chz3Ai/os=; b=Ik
	hg9kGpyhLOHYUXchOX87MI0ULCB9LsM2XWa3SB3tPXXhY7P9HKayyOQytMgsQ6H+
	allAsskeBHG2ZAp6stKth64rA3SeVvmyzdqTHIYcBEHO1LUaRKrmbHoFVKNy2pMl
	NTFkG5YGiMNvvJTBSwoPseEVtv4s5gNDY8Y02oxrNveOMYAop1SKrThuvG60gMkA
	X4PCLcHtbhRToL4DInwVWt0IfKymnw/dRZj8q2u9VhKk/JDZ3usTWgd4TuAPnZGS
	3USVU1xROHpOfWmKco2migH5cMibRGd7ME/XtZcR4jPGJO9BL2C7HiGqWhV+JmCe
	nej5F8Q+D2r4oegEBNig==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy9ee9u4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K16bQ1013151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:37 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 18:06:36 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 3/3] wifi: ath12k: Refactor error handler of Rxdma replenish
Date: Wed, 20 Mar 2024 06:36:15 +0530
Message-ID: <20240320010615.91331-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320010615.91331-1-quic_periyasa@quicinc.com>
References: <20240320010615.91331-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: c7EhqJqvGPmcKRB0I08AceHAHZ5PcGCB
X-Proofpoint-ORIG-GUID: c7EhqJqvGPmcKRB0I08AceHAHZ5PcGCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=874 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200006

The Rxdma replenish handler currently contains redundant code in both the
success and error cases. To avoid the redundant code, implement a
conditional jump mechanism by placing a goto statement to prevent
unnecessary execution of the error handling code when the operation is
successful. This change streamline the code readability and enhance its
efficiency.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 2a0e4faadcf1..a593beecdd12 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -337,7 +337,7 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	num_remain = req_entries;
 
 	if (!num_remain)
-		goto skip_replenish;
+		goto out;
 
 	/* Get the descriptor from free list */
 	if (list_empty(used_list)) {
@@ -389,22 +389,14 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 		ath12k_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
 	}
 
-skip_replenish:
-	ath12k_hal_srng_access_end(ab, srng);
-
-	if (!list_empty(used_list))
-		ath12k_dp_rx_enqueue_free(dp, used_list);
-
-	spin_unlock_bh(&srng->lock);
-
-	return req_entries - num_remain;
+	goto out;
 
 fail_dma_unmap:
 	dma_unmap_single(ab->dev, paddr, skb->len + skb_tailroom(skb),
 			 DMA_FROM_DEVICE);
 fail_free_skb:
 	dev_kfree_skb_any(skb);
-
+out:
 	ath12k_hal_srng_access_end(ab, srng);
 
 	if (!list_empty(used_list))
-- 
2.34.1


