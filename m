Return-Path: <linux-wireless+bounces-5965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8908389B6B3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 06:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91F7B21FB1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 04:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89EBE6F;
	Mon,  8 Apr 2024 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NbsrotYq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00DB67F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549174; cv=none; b=l3bX3oivLx/HItbDEb899TqiOucx9K6c7z76R6Ts3yogDGvMGiGf3sK4wQLcZyHaxhoHGTIoFerA3mQ54gFOFxYRfDxAFuuNxyO4St92pdzDpNA+bGuf+NgewbflpjpHZtq5HnD7lWNuvdbKtH5r0jLl0D/mvJ58JsHgX6JtfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549174; c=relaxed/simple;
	bh=uMAMAzZdMfbNVV7DLQh3d8xsIFUpjOQCYyTLinNxKfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z782LaNKbyzIGP05qxK+gRKE+jj+T+vQVqA/qqLOoB43xYL8wJSnSU6HH5f/IOmpMEIKnKbdeepbZXk1VC9GXsYzhaAn8YaXSTBc6t5E/yznsq9J7t/hjesZ8nzR7P5JYOWx/BYh0ckz+x8G8Z0S0Ay9D6BNXxxufPDkdVIpL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NbsrotYq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4381xPvi020272;
	Mon, 8 Apr 2024 04:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=qsJAqhXSweEBPBg9HK1r7+yGuF+eJzjANpxcUyWZmLw=; b=Nb
	srotYqWmGLLZTX4tOuIgK7BDwvs3FP3KvYD+8solJeuL9vtxxV4CJHaqEkYyXKh+
	xAF8c85xkYXInqXs6oM/2dg2aQllmNP7m5G9XR3KtgI52orywi+tMVbbNS+jT/lZ
	d7augtmiM89q0tGIIB8R8er+qODumxHGAmrdXgU8rqxZ0isDLbYfyQwE0vcll6WZ
	DW1MoFiLYD3yLmQOs6krsGNlFOfr+XOPsMu07HFJY3IUDh0qoLCAikzSwAxqnLLm
	1lHEVRGseKNJ0qGcnQcesMbs1CcttOsVOvudRsY8B3+dXcvlDxyPwtmN4//aUl9y
	LYGp8xO3rUU4C7KWiFqA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaypdajuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 04:06:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43846A5x026306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 04:06:10 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Apr 2024 21:06:08 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: Refactor data path cmem init
Date: Mon, 8 Apr 2024 09:35:47 +0530
Message-ID: <20240408040547.837639-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408040547.837639-1-quic_periyasa@quicinc.com>
References: <20240408040547.837639-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: e9EJzXP75Mi-HTQ3sUQ7CsNb6w00O9Pz
X-Proofpoint-ORIG-GUID: e9EJzXP75Mi-HTQ3sUQ7CsNb6w00O9Pz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=895
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080029

Move the data path Tx and Rx descriptor primary page table CMEM
configuration into a helper function. This will make the code more
scalable for configuring partner device in support of multi-device MLO.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
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


