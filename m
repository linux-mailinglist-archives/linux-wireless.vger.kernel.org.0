Return-Path: <linux-wireless+bounces-16438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F759F416C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 04:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE3B16873B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 03:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CDC14831E;
	Tue, 17 Dec 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b0vGbafm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C11474B8
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407986; cv=none; b=qeezL667pbvadcgEQYL4ilrpbBeJ0lJXBiKfmTrV5KGO4JXUepzs1AHkkeNd6LOCpghRRv5KINLJ/JrxIpWNiY2p+3nGOBFjjCa+I/SwElAtpWFbaQadWRF/ocIngqrUuiHMGKgjhqQWXwW31SWlDRID0aBrbPQEg/hNgFAG+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407986; c=relaxed/simple;
	bh=d9DyEwb1XlQoWz6iUeSWPYX+hCAR0I6KrLhc3HY9ZaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4aXRHnZiHwcYb7K9VpJ226HkJL160CMWp8DQ3gfoxPyr4HljH4saq5iks3uy0//N0HaTccPM3U6zeX5PzsuQLPEZTW3l+87eq2Ykywr9kRFVjVdgK9luOs3OBnMp1gZvZlwTE1XqMYjP3qFeR9BoDLWAHWJxSXOBBt0DFHq5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b0vGbafm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGNsgWf003430;
	Tue, 17 Dec 2024 03:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d4JLGUyr5CV33G/wlyAkoW+IZ5o+c84y93aMiXGyJig=; b=b0vGbafmCsksgnBI
	6kLraPC4rn+DFIDr3cvKusWOf+4+rH7DD7OA0+WbMfaCScLPBcMBfS0HlfnFJaa+
	f7aaldLo/26FMS6xGUdb48z28bac22/TUVxkNMS7gOkJHTE8GxrzBFch6YLv42Ne
	mAablNT0qk/J43296CfSiqG7jok3TDPR8z4PcwPPQkzHIjoHQWUFNS0WXVsINC+Z
	Th1teZvrbRXTHgm8b/fio6uxV8Pw3ZSDq9t99RWVfFt8nWgjVJDMDrMtw5WCaI3a
	s1t6PLdhSLSMnwHUOqUGGC5Mkgafiwi8eeP1AvfZkI2zracSKhlCiIqSGgsTn3bw
	eafZyA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jx9ygfdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH3xe7M003840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:40 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 19:59:38 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/4] wifi: ath12k: Refactor the ath12k_hw get helper function argument
Date: Tue, 17 Dec 2024 09:29:18 +0530
Message-ID: <20241217035920.2683568-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 1qQGQMm5FhfpLMsKcBD2cmwQFPPIZz-S
X-Proofpoint-ORIG-GUID: 1qQGQMm5FhfpLMsKcBD2cmwQFPPIZz-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=975
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170030

Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
ath12k_hw get helper function takes the device handle and the index as
parameters. Here, the index parameter is specific to the group handle.
Therefore, change this helper function argument from the device handle
to the group handle.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  8 ++++----
 drivers/net/wireless/ath/ath12k/core.h |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c  | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0c6b35aac96e..af49e7db4928 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1184,7 +1184,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	spin_unlock_bh(&ab->base_lock);
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah)
 			continue;
 
@@ -1236,7 +1236,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1275,7 +1275,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	int i, j;
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1337,7 +1337,7 @@ static void ath12k_core_restart(struct work_struct *work)
 		}
 
 		for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-			ah = ath12k_ab_to_ah(ab, i);
+			ah = ath12k_ag_to_ah(ab->ag, i);
 			ieee80211_restart_hw(ah->hw);
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index efc273957b9c..6b31e053d6da 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1198,9 +1198,9 @@ static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 	for ((index) = 0; ((index) < (ah)->num_radio && \
 	     ((ar) = &(ah)->radio[(index)])); (index)++)
 
-static inline struct ath12k_hw *ath12k_ab_to_ah(struct ath12k_base *ab, int idx)
+static inline struct ath12k_hw *ath12k_ag_to_ah(struct ath12k_hw_group *ag, int idx)
 {
-	return ab->ag->ah[idx];
+	return ag->ah[idx];
 }
 
 static inline void ath12k_ag_set_ah(struct ath12k_hw_group *ag, int idx,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index cd22d4849ee6..99159663ecad 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11228,7 +11228,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 	int ret;
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 
 		ret = ath12k_mac_hw_register(ah);
 		if (ret)
@@ -11241,7 +11241,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -11260,7 +11260,7 @@ void ath12k_mac_unregister(struct ath12k_hw_group *ag)
 	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 
 	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -11341,7 +11341,7 @@ void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 	}
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -11422,7 +11422,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
-- 
2.34.1


