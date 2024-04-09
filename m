Return-Path: <linux-wireless+bounces-6034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32089DEA2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729991F2C5AE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B913C9C7;
	Tue,  9 Apr 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kkZWqkAH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA713C9B0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675683; cv=none; b=QdHbQkWTUz+iTaApjFrRt8yTwoG+7JcsKw2jT2EYb7ETeB3Lq0XGGTmhPMrY+A4Nz/yGxery3AeC6IJJg+IhvMhMNB15iXPCLri9OGo6fIJ5od6kliwv1Q5UjzTtt+EuCV5H9REkPx5741pyOtIQ/qEgGi9cReT9Yb0LwivvE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675683; c=relaxed/simple;
	bh=ABVVtPXelo3C1hXFCPKZVAjsVVhKje81uYgegw6c/T4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkgyPxBH4kQKeB0zvuyHAY9Y899+sF0PSRDhIAXSlfHkdWxzmdA26u5UjDm2EACs0aTvQbaq2C1GcJHXwdMKmnZHak23LRG7LFyhXMvRqPK9Uutcz5k6X5xZivpS53JxtOVZwCSjnGrfaYgYPUcyxHAd0Bp5RTKud7xQBDPhpcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kkZWqkAH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439BT2p7023221;
	Tue, 9 Apr 2024 15:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=y1BaqKe+fpBZZjueUZML72uSDI770oFeWhEgODwfWts=; b=kk
	ZWqkAHh4hiJZ1fy6R1yCVB7oardjHei35rU6W315Y37Hg72eSdi1r83YiUyP3mVV
	H6kIQivTwkBw+8Uzd1sJWdLPDNQwqov5tfXtq+dskWU7wpofGPO85lxOGI+B008+
	iDa73GuFJ9a/EDoOjQRdBFX7nw62Qx2fEN6txkeNHGr4cWRCuwVqJb9FJ8jwRMZZ
	liWbrqjlyHNTLcVZxn649HEeZgJ5nOJtesYK4+2VDMrdUY/sz6lYFEz/aUixjVaL
	xDKIZYHF2Ty0KoAhP95Fx6VLyUfurvg1JYUrH0hTKboTBho2tddFj4kwYaqq0C5z
	gFfQKyiSiTUYB3iu33eQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd4uerg2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:14:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439FEcqL002845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 15:14:38 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 08:14:37 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 4/4] wifi: ath12k: Refactor data path cmem init
Date: Tue, 9 Apr 2024 20:44:15 +0530
Message-ID: <20240409151415.1226109-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409151415.1226109-1-quic_periyasa@quicinc.com>
References: <20240409151415.1226109-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7mqyjsxeI2EYk7kf7fD1cQ49VwLekGD4
X-Proofpoint-ORIG-GUID: 7mqyjsxeI2EYk7kf7fD1cQ49VwLekGD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=904 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090100

Move the data path Tx and Rx descriptor primary page table CMEM
configuration into a helper function. This will make the code more
scalable for configuring partner device in support of multi-device MLO.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 44 +++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index c8b2eb80b160..11d44e180b54 100644
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
@@ -1455,11 +1460,39 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 	return 0;
 }
 
+static void ath12k_dp_cmem_init(struct ath12k_base *ab,
+				struct ath12k_dp *dp,
+				enum ath12k_dp_desc_type type)
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
+		return;
+	}
+
+	/* Write to PPT in CMEM */
+	for (i = start; i < end; i++)
+		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
+				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
+}
+
 static int ath12k_dp_cc_init(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
 	int i, ret = 0;
-	u32 cmem_base;
 
 	INIT_LIST_HEAD(&dp->rx_desc_free_list);
 	spin_lock_init(&dp->rx_desc_lock);
@@ -1482,8 +1515,6 @@ static int ath12k_dp_cc_init(struct ath12k_base *ab)
 		return -ENOMEM;
 	}
 
-	cmem_base = ab->qmi.dev_mem[ATH12K_QMI_DEVMEM_CMEM_INDEX].start;
-
 	for (i = 0; i < dp->num_spt_pages; i++) {
 		dp->spt_info[i].vaddr = dma_alloc_coherent(ab->dev,
 							   ATH12K_PAGE_SIZE,
@@ -1500,12 +1531,11 @@ static int ath12k_dp_cc_init(struct ath12k_base *ab)
 			ret = -EINVAL;
 			goto free;
 		}
-
-		/* Write to PPT in CMEM */
-		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
-				   dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
 	}
 
+	ath12k_dp_cmem_init(ab, dp, ATH12K_DP_TX_DESC);
+	ath12k_dp_cmem_init(ab, dp, ATH12K_DP_RX_DESC);
+
 	ret = ath12k_dp_cc_desc_init(ab);
 	if (ret) {
 		ath12k_warn(ab, "HW CC desc init failed %d", ret);
-- 
2.34.1


