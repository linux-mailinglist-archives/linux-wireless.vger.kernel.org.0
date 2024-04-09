Return-Path: <linux-wireless+bounces-6032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8689DEA0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F58296A27
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA92413C9B5;
	Tue,  9 Apr 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cz5cHZY6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4313C9AE
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675681; cv=none; b=Ky2oeVgMLqQA7QPx/VJLGAyW6vRvTSGf7lYU1VIUCx1dgOA22H9h+4jXLZuU0TmY2qST2gH5Gn945d3JdJ9oc45BbTL/9fQ8VYo0GuJE8mV9wYHrtVKVD2xdcKyvjX/E5LjQ3+kYmJ5zQlmZIyVAoZTxleGu+cXJ6P2wsIh8YDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675681; c=relaxed/simple;
	bh=EdDcJQciTr3DLmKA8gtqzFL6k+XHCxZZxYOVpjxezNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tuhj0pzGNL0QEitsYYs9h4uQC3HIx/5EDp3aNfZqubnKx3XOJ98AdOXxWfIFUTat9cK0+oB8k/1Nfwn8VH2BLEbTT8RgPo0vmVvDFAILOwBFx7aDmZxsW0wSrW1RYspyV+/eQT8q4vED/63svG1xWgTMTXmcwIt9IC6Vy7o3Gv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cz5cHZY6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439BmNvL009235;
	Tue, 9 Apr 2024 15:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cMoVr4OS8CjyWfHtQ8yP5yFWNLbgdfgMWtKfF3lm2Kk=; b=Cz
	5cHZY609xNifYG7ufHReqC2jMKE4i8runOBSDyIwUy83ZPg6Wu3ry3boA4+OD074
	mD6mnR2tKA4KKmCTYx9kvnO4WeDVNZC/LR6h15Lng6xTTCYrGkyEA0gcGu6Jt1qe
	RkL5ZV1JBgpinlqf57MXWZZuM3LzwMSVbg6Dd9V+YNl0cZJaqtghVq1nvNgCK6Sn
	mutVZEy/Y+w1hZkl7HG8mI6gnRsbZZlKEbX55Fr48smk8LM9XknpgyScK5IIzD+6
	FoqQV6VfOW4i5jPY1sgLz8ISB3046kbThzUtWtzoVSDKwaRFB2BxVoM31z/ug2UM
	7QWWgWMCXTa6+5mxJBEA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd39q0nng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:14:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439FEaru002977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 15:14:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 08:14:34 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 3/4] wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion table
Date: Tue, 9 Apr 2024 20:44:14 +0530
Message-ID: <20240409151415.1226109-4-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: QEct4f4V5wJ60yHwA4c_bEKpPInN1B-d
X-Proofpoint-ORIG-GUID: QEct4f4V5wJ60yHwA4c_bEKpPInN1B-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=602 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090100

In the hardware cookie conversion table configuration, place the Rx
descriptor at the end. This will allow for easier addition of partner
device Rx descriptors in the future to support multi-device MLO.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 57aba97cbdce..5cf0d21ef184 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -223,8 +223,8 @@ struct ath12k_pdev_dp {
 #define ATH12K_NUM_TX_SPT_PAGES	(ATH12K_TX_SPT_PAGES_PER_POOL * ATH12K_HW_MAX_QUEUES)
 #define ATH12K_NUM_SPT_PAGES	(ATH12K_NUM_RX_SPT_PAGES + ATH12K_NUM_TX_SPT_PAGES)
 
-#define ATH12K_TX_SPT_PAGE_OFFSET ATH12K_NUM_RX_SPT_PAGES
-#define ATH12K_RX_SPT_PAGE_OFFSET 0
+#define ATH12K_TX_SPT_PAGE_OFFSET 0
+#define ATH12K_RX_SPT_PAGE_OFFSET ATH12K_NUM_TX_SPT_PAGES
 
 /* The SPT pages are divided for RX and TX, first block for RX
  * and remaining for TX
-- 
2.34.1


