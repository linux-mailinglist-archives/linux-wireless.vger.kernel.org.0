Return-Path: <linux-wireless+bounces-6163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70318A0F53
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 12:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CA01F271E4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4F7146A94;
	Thu, 11 Apr 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aGJ29woB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5211465BE
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830974; cv=none; b=mEtz4VpxtKro/MvlaCw5cr+FhGUKmt8OKZOvRMrcl6R6qTA6mYV5eBdhjvoG+WbeE1/ReR2n2NVUAXTFEyYQrjNb2QyQ/FLF8ysOuhPm3iKO4JnTZUXYTgGesbEfxld5QKI9X+69ZJW+bCxB7vmv+yt3FOOEYJHhx5T0G0HcNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830974; c=relaxed/simple;
	bh=W4FBnA5PORrONlXYN/IDW/Xe5p9JpwrKXFx/eI7e7eE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgEpsdNOB8Y7Ei3VvXJ0RAABc8gxSChLrTQcpfVS9E9f7deUKJ/aWfuiTPNTE2n0yBpDOht2QatkNuAa3+sVdDBqr7RD1lZzkDAE4dKNTqyyYKymQC2whcztJSANOqvZm+TpcshrnS0e0IXrnap7gLtj1B2L1WsrzAEDIc15+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aGJ29woB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B6xKjJ028335;
	Thu, 11 Apr 2024 10:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=BTat1aGhrTMsPxIa4P5iCvAo8M35yIrsp4enyOWUkwA=; b=aG
	J29woBvt33R2DOQKh7bYwiq/SafclMDcv3d0Br4uKm0zlLNi/hQYwCe2cLlHaEnf
	xmxNnBL69FKgXUz9EBdEMpgpmFxT7c7VyzqzQLGcCuaFoOn87Ge0s+BUumy+nV/w
	/xenLy9T9vbNTYL+Mm6gClUEJOaetvs55nz5gpDj7/9LkW/uX8Lh+xlFcm8BycAl
	9WFUkkOAJQo0hTqqe2akB8HwcDqFUI2yifws5M7kyLlYt/UaQNaBdWRMG9E+bii/
	B+kHnu3Q0lycyUvFK9+7CDTDHEF3HsUpcRKpCD8yz+Pkw2oS72UOkRofE1Ecy4Cj
	HtFf6yfK457YFt2GyFaw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeb2rgwnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:22:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BAMkAN005705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:22:46 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 03:22:43 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 2/4] wifi: ath12k: Refactor the hardware cookie conversion init
Date: Thu, 11 Apr 2024 15:52:24 +0530
Message-ID: <20240411102226.4045323-3-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LHifg9K-D_-8XTefbJsQSDBRZJpos2zC
X-Proofpoint-GUID: LHifg9K-D_-8XTefbJsQSDBRZJpos2zC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110074

Currently, the Rx descriptor is placed before the Tx descriptor in the
primary page table of the hardware cookie conversion configuration. The
Tx and Rx descriptor offsets are implicitly hardcoded. To allow for easy
displacement of Tx and Rx descriptors, introduce Tx and Rx offset based
cookie conversion initializationi. Additionally, should consider
validating the respective offset ranges while retrieving the Tx and Rx
descriptors. This change will be utilize by the next patch in the series.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 25 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h |  3 +++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 796c757c0f58..c8b2eb80b160 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1344,12 +1344,16 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie)
 {
 	struct ath12k_rx_desc_info **desc_addr_ptr;
-	u16 ppt_idx, spt_idx;
+	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
 
-	if (ppt_idx > ATH12K_NUM_RX_SPT_PAGES ||
+	start_ppt_idx = ATH12K_RX_SPT_PAGE_OFFSET;
+	end_ppt_idx = start_ppt_idx + ATH12K_NUM_RX_SPT_PAGES;
+
+	if (ppt_idx < start_ppt_idx ||
+	    ppt_idx >= end_ppt_idx ||
 	    spt_idx > ATH12K_MAX_SPT_ENTRIES)
 		return NULL;
 
@@ -1362,13 +1366,17 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 cookie)
 {
 	struct ath12k_tx_desc_info **desc_addr_ptr;
-	u16 ppt_idx, spt_idx;
+	u16 start_ppt_idx, end_ppt_idx, ppt_idx, spt_idx;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
 	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
 
-	if (ppt_idx < ATH12K_NUM_RX_SPT_PAGES ||
-	    ppt_idx > ab->dp.num_spt_pages ||
+	start_ppt_idx = ATH12K_TX_SPT_PAGE_OFFSET;
+	end_ppt_idx = start_ppt_idx +
+		      (ATH12K_TX_SPT_PAGES_PER_POOL * ATH12K_HW_MAX_QUEUES);
+
+	if (ppt_idx < start_ppt_idx ||
+	    ppt_idx >= end_ppt_idx ||
 	    spt_idx > ATH12K_MAX_SPT_ENTRIES)
 		return NULL;
 
@@ -1397,15 +1405,16 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			return -ENOMEM;
 		}
 
+		ppt_idx = ATH12K_RX_SPT_PAGE_OFFSET + i;
 		dp->spt_info->rxbaddr[i] = &rx_descs[0];
 
 		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
-			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(i, j);
+			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(ppt_idx, j);
 			rx_descs[j].magic = ATH12K_DP_RX_DESC_MAGIC;
 			list_add_tail(&rx_descs[j].list, &dp->rx_desc_free_list);
 
 			/* Update descriptor VA in SPT */
-			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(ab, i, j);
+			rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(ab, ppt_idx, j);
 			*rx_desc_addr = &rx_descs[j];
 		}
 	}
@@ -1425,7 +1434,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			}
 
 			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
-			ppt_idx = ATH12K_NUM_RX_SPT_PAGES + tx_spt_page;
+			ppt_idx = ATH12K_TX_SPT_PAGE_OFFSET + tx_spt_page;
 
 			dp->spt_info->txbaddr[tx_spt_page] = &tx_descs[0];
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 4939aa41dd87..57aba97cbdce 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -223,6 +223,9 @@ struct ath12k_pdev_dp {
 #define ATH12K_NUM_TX_SPT_PAGES	(ATH12K_TX_SPT_PAGES_PER_POOL * ATH12K_HW_MAX_QUEUES)
 #define ATH12K_NUM_SPT_PAGES	(ATH12K_NUM_RX_SPT_PAGES + ATH12K_NUM_TX_SPT_PAGES)
 
+#define ATH12K_TX_SPT_PAGE_OFFSET ATH12K_NUM_RX_SPT_PAGES
+#define ATH12K_RX_SPT_PAGE_OFFSET 0
+
 /* The SPT pages are divided for RX and TX, first block for RX
  * and remaining for TX
  */
-- 
2.34.1


