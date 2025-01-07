Return-Path: <linux-wireless+bounces-17130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF7DA03596
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 03:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063F11881AAC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9CC14B95A;
	Tue,  7 Jan 2025 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ilLDSZEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEB195FEC
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218618; cv=none; b=Vc4yec1c/xVdLPDM8isDijrw2yn0HSKVTItMaqZGmSnFXerF9Xt8aa89L0Fo4yijDzFeJxAXTM4E5vX8efY12QrKhztJD8o2aodi3oB4jnWllV8OtG6oSSWVxVo9TU+Q6Pa55l1J2jLfqiLYxR0AzMJC6P0vIFZjhG8/ftRhLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218618; c=relaxed/simple;
	bh=+0I/+JHlvxi0GNxlB1P48E4FoZwFAH7dbhwJJmWBEf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeDUok9p5Xl7G74zK/VBazGjI46kLQ6rer1cOHXKcsdI1mB1QIcO7U9VrzMGK5p7oyYh/96LqOw7F4ls1K5Sk3pgfUhXezYR8qUBTWcaNSHqyteNYP6kVjXCy5ssXnf8sjrkDj7KHBT68DfkaOA59fzDTFnP0mJw76Rh+6NH7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ilLDSZEn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506HrmGJ012208;
	Tue, 7 Jan 2025 02:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMIsY5x3PoCXltmEjUuC7GTHfxDBdc/13Rku0xl3rQo=; b=ilLDSZEnnfTFmFjZ
	xBQ3ii3eMt07A3i6SjEMYMncy18yvuO+ZMQXmUH+8gsy98y8GQAq6bmratZKd/2C
	rNh2Qw4T31wcN9V79VWvABXyRXdRTALve9aAJfHAQw0IVFDLE399C1hHID0bDNi2
	sNvxs6dyNCvAy4lgM/yGoJBJFVZpB9/hLhd0QQYgTwbd0iW4T5lSSEo9jGyxbWdg
	s3I6fDsNQCiSQs9byXMqmydZ8RxbOQm8n0I8UNEit7fOuwBaoWORKOC9zAzxDF9J
	32lnAXEOueABOblJNsM1XBquvJDsyfwYKkiLWUOFh+lkSdOWIZgy1A7vHGr5flWv
	HvXTqg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440kyqh06h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:56:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5072unPR032235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 02:56:49 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 Jan 2025 18:56:47 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 3/3] wifi: ath12k: delete mon reap timer
Date: Tue, 7 Jan 2025 10:56:21 +0800
Message-ID: <20250107025621.1907-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250107025621.1907-1-quic_kangyang@quicinc.com>
References: <20250107025621.1907-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vjk7nOLhzmzMYqZEgnlFEYnyd17CFqUM
X-Proofpoint-GUID: Vjk7nOLhzmzMYqZEgnlFEYnyd17CFqUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=785 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070022

Currently mon reap timer is not used, and it is not needed anymore.

So remove related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 --
 drivers/net/wireless/ath/ath12k/dp.c   | 30 +-------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 41a51c7bad6c..ad2451fd7ce9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -992,8 +992,6 @@ struct ath12k_base {
 	struct ath12k_dbring_cap *db_caps;
 	u32 num_db_cap;
 
-	struct timer_list mon_reap_timer;
-
 	struct completion htc_suspend;
 
 	u64 fw_soc_drop_count;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9e5a4e75f2f6..f162f98e7b79 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -982,11 +982,6 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
 {
 	int i;
 
-	if (!ab->mon_reap_timer.function)
-		return;
-
-	del_timer_sync(&ab->mon_reap_timer);
-
 	for (i = 0; i < ab->num_radios; i++)
 		ath12k_dp_rx_pdev_free(ab, i);
 }
@@ -1024,27 +1019,6 @@ void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
 		ab->hal_rx_ops->rx_desc_get_desc_size();
 }
 
-static void ath12k_dp_service_mon_ring(struct timer_list *t)
-{
-	struct ath12k_base *ab = from_timer(ab, t, mon_reap_timer);
-	int i;
-
-	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++)
-		ath12k_dp_mon_process_ring(ab, i, NULL, DP_MON_SERVICE_BUDGET,
-					   ATH12K_DP_RX_MONITOR_MODE);
-
-	mod_timer(&ab->mon_reap_timer, jiffies +
-		  msecs_to_jiffies(ATH12K_MON_TIMER_INTERVAL));
-}
-
-static void ath12k_dp_mon_reap_timer_init(struct ath12k_base *ab)
-{
-	if (ab->hw_params->rxdma1_enable)
-		return;
-
-	timer_setup(&ab->mon_reap_timer, ath12k_dp_service_mon_ring, 0);
-}
-
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -1055,8 +1029,6 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 	if (ret)
 		goto out;
 
-	ath12k_dp_mon_reap_timer_init(ab);
-
 	/* TODO: Per-pdev rx ring unlike tx ring which is mapped to different AC's */
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
-- 
2.34.1


