Return-Path: <linux-wireless+bounces-17027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE5A0042B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2221883E73
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB371B3724;
	Fri,  3 Jan 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hONHeVfw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B714A629
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885284; cv=none; b=kgBbFrhW4EwGU3NIzbXSWHh9M7cbZa3bbH33Hlm+KhXIUN3k4Zcl+yhn/kjaSX9aaQ0DrZIEyBciUeFmx8I78Ycl/KjLQHqnaUUQMtiMJRssaufQa/bTejabVDVQPaJIVS85Z9YNFgfoXZE7c4w6gcm4vcnWWLGzEBkMPHJS3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885284; c=relaxed/simple;
	bh=h9BZ33CrSIyEUfITXQjEUjad4sVqUy8142w3cs6DuL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuyrpZS6H/+7ediV4IDQFZhlgGcuKbFjB27LTaEaO+uqlZQaqcXPzeNBxYY1MjGb8tLDjq2s25NpkGkoYGF8Sv4xu7uduCuKYO8K+OddzFdk+Wwm2a7vhfEilwk4u2koQBYvHHPAKbpN7EnFburLqmcOQbgY+kAK6asfSc5Hoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hONHeVfw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502G1L4B001608;
	Fri, 3 Jan 2025 06:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O8m5ZpbUTmtk569rOSBRY5ZepEzLbInBLA182Wyaeao=; b=hONHeVfwZ5083l0F
	V3zRLseOFR7a5YUrusd+JYilg7huOFC0+9mA3518Qx/mFEsW5HAQ8HAk5qZAUN8V
	6QicrxsWmaRi3ZHpyOBD6KNZPtGMx0e9T2xGakDIU67Iy3SmyDAUoaiZwqA3JdgR
	65eEfCHWqUbek6A+YJzOU57MxSuKh9Qrpco37c/yiAGmDemo5/BIUdgDA1ZaEmnE
	UObYcJEdFn9myO9iX3E68bvl5SCFuJyC00SSyAq0K/yifZDoIaeE8iqVN9gx8dNB
	EQh77cOx3KMMDhRj9Cr0mIVKcJjEELFzgLbmfmnbfXZzxsGlZ+LAT47CBWrzeLMP
	JeDpOQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43wrefj8ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 06:21:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5036L9e7021445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 06:21:09 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 22:21:08 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 3/3] wifi: ath12k: delete mon reap timer
Date: Fri, 3 Jan 2025 14:20:41 +0800
Message-ID: <20250103062041.1857-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250103062041.1857-1-quic_kangyang@quicinc.com>
References: <20250103062041.1857-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lfUZrdRkHMEq62E5eLrkEDU-v2mwY9ZS
X-Proofpoint-ORIG-GUID: lfUZrdRkHMEq62E5eLrkEDU-v2mwY9ZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxlogscore=656 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030053

Currently mon reap timer is not used, and it is not needed anymore.

So remove related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 --
 drivers/net/wireless/ath/ath12k/dp.c   | 28 --------------------------
 2 files changed, 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index a7830e9c4374..fa4e6bdb446b 100644
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
index 9e5a4e75f2f6..08b8a419740e 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
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


