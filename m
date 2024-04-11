Return-Path: <linux-wireless+bounces-6164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620698A0F54
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E63F287381
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60C146D50;
	Thu, 11 Apr 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ezOhkFyJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42236146A70
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830974; cv=none; b=VWUvD/Vy8p3g/okardrkG1YtT4vs4bmQNl36GoO6aV2dwdSQAPCkLO9eRFd6KyMtd4ckWH23QLQsrzHaaMOqykfgUHT1Rzczf0GHY09Z/01b5Rh9NxNuOJ5d0M4Hi/zVVV9+j8eMMPY5o0Cm5Llngl0eP4j0kQ9GFkTiyvLiJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830974; c=relaxed/simple;
	bh=3JSj1ZQUcky+r0R0tPTJonky34Rq7QlZkYMJKJVazi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeYWcPNlqqfGt+vV0h74VZXpVqMAVgLtlyTKKJqW4ZqqHYl4q+H+crUcLwzkXu1z93HT7uXHbHx2y3+s76OsTI2eyDpsNo8eYy9CCW7l/AE7wTqwA+IqEuL5v+DTUmnccdT0cXLs7CAY4JfnkaFc8XTrbR1iAVHZZX9yH0edBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ezOhkFyJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B8JwUF012163;
	Thu, 11 Apr 2024 10:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=4zqgAADdq11bMznFte8Qkx/mFI4DOW4+6QekiXcWGSQ=; b=ez
	OhkFyJn5oyYKaGMZKMDhcQfaUSB1kie27dy+TtYC9/U4Qj4SvSwwpK9b5NkTkg4e
	TXLJUnkDVZAeeakNUddumyGDgzgCSzWr5jRtyYNCPvfz1O97HuEcmVvBg9b/y2yf
	3IzG7NhrveUTVsUPUfWcW8D28LjLjhdO5BCRZbmFdeATS3NOz73mDuEO73w7/jg/
	R/4RJOj9bJychbW0Jl99UwvIqfYuVOcnjx5cxh49z/xa0uCvIP9MF3EIXKCRa431
	50VgBFJ8aHFiCeOX6J2+vtpRY/NdKOUmjqfu0/Ud5eFY/6HHeK06QXarc13Ll6Bx
	or2jGVMSu436cIetKmmw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeb628ut6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:22:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BAMoF1010386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:22:50 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 03:22:48 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 4/4] wifi: ath12k: Refactor data path cmem init
Date: Thu, 11 Apr 2024 15:52:26 +0530
Message-ID: <20240411102226.4045323-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411102226.4045323-1-quic_periyasa@quicinc.com>
References: <20240411102226.4045323-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qE5ljJvKnFEBArFDK6W3Qd7PXXqNDFRx
X-Proofpoint-GUID: qE5ljJvKnFEBArFDK6W3Qd7PXXqNDFRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=904
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110074

Move the data path Tx and Rx descriptor primary page table CMEM
configuration into a helper function. This will make the code more
scalable for configuring partner device in support of multi-device MLO.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 53 ++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index c8b2eb80b160..963b9ad4dc82 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -14,6 +14,11 @@
 #include "peer.h"
 #include "dp_mon.h"
 
+enum ath12k_dp_desc_type {
+	ATH12K_DP_TX_DESC,
+	ATH12K_DP_RX_DESC,
+};
+
 static void ath12k_dp_htt_htc_tx_complete(struct ath12k_base *ab,
 					  struct sk_buff *skb)
 {
@@ -1455,11 +1460,41 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 	return 0;
 }
 
+static int ath12k_dp_cmem_init(struct ath12k_base *ab,
+			       struct ath12k_dp *dp,
+			       enum ath12k_dp_desc_type type)
+{
+	u32 cmem_base;
+	int i, start, end;
+
+	cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
+
+	switch (type) {
+	case ATH12K_DP_TX_DESC:
+		start = ATH12K_TX_SPT_PAGE_OFFSET;
+		end = start + ATH12K_NUM_TX_SPT_PAGES;
+		break;
+	case ATH12K_DP_RX_DESC:
+		start = ATH12K_RX_SPT_PAGE_OFFSET;
+		end = start + ATH12K_NUM_RX_SPT_PAGES;
+		break;
+	default:
+		ath12k_err(ab, "invalid descriptor type %d in cmem init\n", type);
+		return -EINVAL;
+	}
+
+	/* Write to PPT in CMEM */
+	for (i = start; i < end; i++)
+		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
+				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
+
+	return 0;
+}
+
 static int ath12k_dp_cc_init(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
 	int i, ret = 0;
-	u32 cmem_base;
 
 	INIT_LIST_HEAD(&dp->rx_desc_free_list);
 	spin_lock_init(&dp->rx_desc_lock);
@@ -1482,8 +1517,6 @@ static int ath12k_dp_cc_init(struct ath12k_base *ab)
 		return -ENOMEM;
 	}
 
-	cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
-
 	for (i = 0; i < dp->num_spt_pages; i++) {
 		dp->spt_info[i].vaddr = dma_alloc_coherent(ab->dev,
 							   ATH12K_PAGE_SIZE,
@@ -1500,10 +1533,18 @@ static int ath12k_dp_cc_init(struct ath12k_base *ab)
 			ret = -EINVAL;
 			goto free;
 		}
+	}
 
-		/* Write to PPT in CMEM */
-		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
-				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
+	ret = ath12k_dp_cmem_init(ab, dp, ATH12K_DP_TX_DESC);
+	if (ret) {
+		ath12k_warn(ab, "HW CC Tx cmem init failed %d", ret);
+		goto free;
+	}
+
+	ret = ath12k_dp_cmem_init(ab, dp, ATH12K_DP_RX_DESC);
+	if (ret) {
+		ath12k_warn(ab, "HW CC Rx cmem init failed %d", ret);
+		goto free;
 	}
 
 	ret = ath12k_dp_cc_desc_init(ab);
-- 
2.34.1


