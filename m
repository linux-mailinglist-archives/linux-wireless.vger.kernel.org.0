Return-Path: <linux-wireless+bounces-17214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF8A06CED
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 05:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507BC1889B7B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659661885A1;
	Thu,  9 Jan 2025 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BNy0Bfb/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19717C224;
	Thu,  9 Jan 2025 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736396753; cv=none; b=tKJqI9HprFpWKRuvxuIwdsegZAOuGx3vGS910bRbcYLPuANE+PgEp3QZgmvN1uHZ7gaMApiYNtmr8vXh6/kofh0c9L6bxwiCi8YceLs1PIsWq7TyuDE+3OC72yjeW+uvaubtttFThFxFh892aKl1AWCmij3SWi5Wfw9w+Le+CaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736396753; c=relaxed/simple;
	bh=eiGOYUBrcOrVqGreJYIAHMEDgClI1/p0MELl3925zUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dE5mWmGVkXE1NjO8NZturqbEtMuyuDw5vxfedTINYSaiq2sThR+Jm+p4UMNyMSV6lXeuzAyDfPNeDVLZiyXGUezOz+2nUygXqHSUlnRotkCARaBqMdjhWkOo4KWNyYCHvZ3TJPW8oeg96ql9JHhWbrYVyJoqyeDdg1O1HEdcx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BNy0Bfb/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5091GmWA018515;
	Thu, 9 Jan 2025 04:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iDYcwSDrmAR8Qr9qR10RIYQUb3fY6vJfdz7ElvTzG5g=; b=BNy0Bfb/vPgxwkq5
	isSa3e26IjN+09gvgX3v7IYC0DzjsW3yyPCT9YF5vYKU3PO9W64fD5zbhiBHE7Sv
	YnkD99xIrzKlv1/41Ux5L1j9D8pb+Uv9L1DfDcCoNE0ETON+pkBIw+Nm0DLswKOj
	khBovbwt8b/+K+5pEYYqn1WGn/WHYBpFSr090uSVYV18iEXKdG4iDhxeRvD/8FOW
	/EgSWu2DkHGF7l1zmNxoAm9sRH44A3KD8m9yz5FTfQfvBFA0OFfXu7JehJUkAa3v
	rkNBCqCG/A7OXNgGWvH5x6qcMSDN3Cugoo6YHhkNdTcg+6K6ItIjR7KKfMNp2fgq
	OpKzCQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441yxbryw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 04:25:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5094Pl6C019391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 04:25:47 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 20:25:43 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Thu, 9 Jan 2025 09:55:30 +0530
Subject: [PATCH 02/10] wifi: ath12k: add reference counting for core
 attachment to hardware group
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-fix_reboot_issues_with_hw_grouping-v1-2-fb39ec03451e@quicinc.com>
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<quic_kvalo@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Aditya Kumar
 Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e2TtCNRmuonXr4ZaXVqX11x1reHa95pN
X-Proofpoint-ORIG-GUID: e2TtCNRmuonXr4ZaXVqX11x1reHa95pN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090033

Currently, driver does not manage reference counting for attaching and
detaching cores to/from hardware groups. This can lead to issues when
multiple cores are involved. Or with same core, attach/detach is called
multiple times back to back.

Fix this issue by using reference counting.

With that, it is now ensured that the core is properly attached or detached
from the hardware group and even back to back calls will not alter the
count.

Additionally, add some debug logs during the attachment and detachment
events for better debugging and tracking.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 47 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h | 17 ++----------
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 514494dd56ad206a72c52492774d3387dae82f70..299d7686616b78752164d9cb064c1805af9a1155 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -603,9 +603,49 @@ u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
 	return TARGET_NUM_TIDS(SINGLE);
 }
 
+static inline
+void ath12k_core_to_group_ref_get(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (ab->hw_group_ref) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "core already attached to group %d\n",
+			   ag->id);
+		return;
+	}
+
+	ab->hw_group_ref = true;
+	ag->num_started++;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "core attached to group %d, num_started %d\n",
+		   ag->id, ag->num_started);
+}
+
+static inline
+void ath12k_core_to_group_ref_put(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (!ab->hw_group_ref) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "core already de-attached from group %d\n",
+			   ag->id);
+		return;
+	}
+
+	ab->hw_group_ref = false;
+	ag->num_started--;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "core de-attached from group %d, num_started %d\n",
+		   ag->id, ag->num_started);
+}
+
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
-	ath12k_core_stopped(ab);
+	ath12k_core_to_group_ref_put(ab);
 
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath12k_qmi_firmware_stop(ab);
@@ -841,9 +881,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		/* ACPI is optional so continue in case of an error */
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
 
-	if (!test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
-		/* Indicate the core start in the appropriate group */
-		ath12k_core_started(ab);
+	/* Indicate the core start in the appropriate group */
+	ath12k_core_to_group_ref_get(ab);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3dd01ad100c56d2b9330d9a963acba021e4d571b..58ebc56991af99de08e8ed783e98f742a687eddf 100644
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
@@ -1052,6 +1052,7 @@ struct ath12k_base {
 
 	struct ath12k_hw_group *ag;
 	struct ath12k_wsi_info wsi_info;
+	bool hw_group_ref;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -1215,20 +1216,6 @@ static inline struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
 	return ab->ag;
 }
 
-static inline void ath12k_core_started(struct ath12k_base *ab)
-{
-	lockdep_assert_held(&ab->ag->mutex);
-
-	ab->ag->num_started++;
-}
-
-static inline void ath12k_core_stopped(struct ath12k_base *ab)
-{
-	lockdep_assert_held(&ab->ag->mutex);
-
-	ab->ag->num_started--;
-}
-
 static inline struct ath12k_base *ath12k_ag_to_ab(struct ath12k_hw_group *ag,
 						  u8 device_id)
 {

-- 
2.34.1


