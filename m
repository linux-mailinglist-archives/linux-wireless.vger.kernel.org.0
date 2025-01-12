Return-Path: <linux-wireless+bounces-17375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B508A0A768
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8711888B8A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 07:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ECC148FF2;
	Sun, 12 Jan 2025 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GKlEjDNC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D8153BE8
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736666217; cv=none; b=U1vJkBHmqEPKsKkMlQ+VNlqY3yqkwNMl+B4hK+aZKJ0zWXBXXo8qaqEBb16WJoNCZjDlNPg8PA/fez9YCQ7IThNdek9dzZPNgyrih74S6/pi1KWGH2D88HKJz/ZXcORVkNOIal3NNrM++PkcDllY2nnGOat2a3vJFHSVqrin00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736666217; c=relaxed/simple;
	bh=2oKnkUT2S3LxuyiW8URHOtf12x1LEDysrBJEGk5t2IU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGE+8H4bbegRpzgrUUhH6vazpLR9kO//eBa4FCl4KH4gXGdeOEAIWaUWdUHm5n+cZ4AmOXq9i79Ge5esD/zh7SZQ9+HkTlVN0ky55b+QRcDM+gsj8s2lx62PGA389l2HT6NEGa3rq1mFe3smELVVZTy9cDFWoJRdrQCZ7CfyG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GKlEjDNC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C6eKsF007663;
	Sun, 12 Jan 2025 07:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yv/WDWX3TNq/1x964Dcs6WJnSxe9rFCaDEEGldBDJXU=; b=GKlEjDNCqR7nPF0b
	+ABOLyvHe4/GKXVOYG4+bWq8f+7Fz8NEJYgoaPcLy/hIiJoO0+D+ECPuFFsQJ79m
	Wpo1PjB+fnnJe6QyUCxQXH3r3AzKc+XlKYWH2IEfW3N0X8ckXiwNH13gPQ3B1ub0
	QJ4af76D9t1hVwtirUDRc6dPxmS9aqAJCB9QvPV7mlrJS38PGkxiFuCGARA/hYyY
	K9KvSEJ0VIkkDvFYWrgWq2O08eEP12GPj9bkGEpoZwAqZmlF0haLhtaWwdbw8Azr
	1dkFeGVk7l1MmP8gAwjsTvhAik8tQ2IOaNY2lNy5IA/DMBAu/Bq+7Tz5p5k/guUJ
	DaR/rg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443htgspf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C7GpcY022380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:51 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 23:16:49 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 3/4] wifi: ath12k: Remove ath12k_get_num_hw() helper function
Date: Sun, 12 Jan 2025 12:46:29 +0530
Message-ID: <20250112071630.4059410-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: hWF_VnBxZnNy4IJKyHd5XgG2h6s8l7cq
X-Proofpoint-ORIG-GUID: hWF_VnBxZnNy4IJKyHd5XgG2h6s8l7cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501120063

Currently, the ath12k_get_num_hw() helper function takes the device handle
as an argument. Here, the number of hardware is retrieved from the group
handle. Demanding the device handle from the caller is unnecessary since
in some cases the group handle is already available. Additionally, there
is no longer a need for multiple indirections to get the number of
hardware. Therefore, remove this helper function and directly use
ag->num_hw. This change also fixes the below Smatch static checker
warning.

Smatch warning:
ath12k_mac_destroy() error: we previously assumed 'ab' could be null

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 20 ++++++++++++--------
 drivers/net/wireless/ath/ath12k/core.h |  7 +------
 drivers/net/wireless/ath/ath12k/mac.c  |  8 ++++----
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index af49e7db4928..0606116d6b9c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1173,6 +1173,7 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
 static void ath12k_rfkill_work(struct work_struct *work)
 {
 	struct ath12k_base *ab = container_of(work, struct ath12k_base, rfkill_work);
+	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k *ar;
 	struct ath12k_hw *ah;
 	struct ieee80211_hw *hw;
@@ -1183,8 +1184,8 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	rfkill_radio_on = ab->rfkill_radio_on;
 	spin_unlock_bh(&ab->base_lock);
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ag_to_ah(ab->ag, i);
+	for (i = 0; i < ag->num_hw; i++) {
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -1224,6 +1225,7 @@ void ath12k_core_halt(struct ath12k *ar)
 
 static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 {
+	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k *ar;
 	struct ath12k_hw *ah;
 	int i, j;
@@ -1235,8 +1237,8 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	if (ab->is_reset)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ag_to_ah(ab->ag, i);
+	for (i = 0; i < ag->num_hw; i++) {
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1270,12 +1272,13 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 
 static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 {
+	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k_hw *ah;
 	struct ath12k *ar;
 	int i, j;
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ag_to_ah(ab->ag, i);
+	for (i = 0; i < ag->num_hw; i++) {
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1318,6 +1321,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 static void ath12k_core_restart(struct work_struct *work)
 {
 	struct ath12k_base *ab = container_of(work, struct ath12k_base, restart_work);
+	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k_hw *ah;
 	int ret, i;
 
@@ -1336,7 +1340,7 @@ static void ath12k_core_restart(struct work_struct *work)
 			ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset success\n");
 		}
 
-		for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+		for (i = 0; i < ag->num_hw; i++) {
 			ah = ath12k_ag_to_ah(ab->ag, i);
 			ieee80211_restart_hw(ah->hw);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4932bd1c2096..ee595794a7ae 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CORE_H
@@ -1205,11 +1205,6 @@ static inline void ath12k_ag_set_ah(struct ath12k_hw_group *ag, int idx,
 	ag->ah[idx] = ah;
 }
 
-static inline int ath12k_get_num_hw(struct ath12k_base *ab)
-{
-	return ab->ag->num_hw;
-}
-
 static inline struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
 {
 	return ab->ag;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 285bb88acb90..08f340afb970 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -11243,7 +11243,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 	int i;
 	int ret;
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	for (i = 0; i < ag->num_hw; i++) {
 		ah = ath12k_ag_to_ah(ag, i);
 
 		ret = ath12k_mac_hw_register(ah);
@@ -11275,7 +11275,7 @@ void ath12k_mac_unregister(struct ath12k_hw_group *ag)
 
 	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 
-	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
+	for (i = ag->num_hw - 1; i >= 0; i--) {
 		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
@@ -11356,7 +11356,7 @@ void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 		}
 	}
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	for (i = 0; i < ag->num_hw; i++) {
 		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
-- 
2.34.1


