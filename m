Return-Path: <linux-wireless+bounces-17879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C6A1AF7B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 05:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E916C5D2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 04:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959491DA10C;
	Fri, 24 Jan 2025 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KP1VH7wQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DD1D9A7D;
	Fri, 24 Jan 2025 04:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693720; cv=none; b=rRpQeiBePSAesM43USz4+hsGhJuGMegYxM7ozviOZPZrgY9rVxTUbg4nhxoktfzLDh7uzsfaE6GJOzeeHV93XnW2KhQiVHdxK22x2L4zn8+HqseS+wJhW8zSEStAJKc+wtGncLaKZwXGhVbnVxEXfhIiqvSaZ9x/R/gHaiUwHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693720; c=relaxed/simple;
	bh=d4qy58RrzzdlbZZBxbv9OeE3M5ETLSzV+Gophk/6iFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UaUIw0FF7/mpokXcM8mbt0wTPA+oqf7jaFVTEqo73iTsE4Eug0ChpgLS5jut4nU1Lsx/UrnlnE6RIKOoLYZyAaUysHDNO/MQN82zPJF+fuNU06NFd31b9NVB/aYXDlM4J3hgMYCEI4vBqDDt/C9tebGUfy25be7L4+nkbBC5CEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KP1VH7wQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O3rexi029827;
	Fri, 24 Jan 2025 04:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wj3x8Ni+2UDltk4UDr5S6YrgeNhQw3g0yFlN+FoE/0Y=; b=KP1VH7wQIb1M4Kda
	7veBWo5+gpDIdIoLMU4B3Gg7+F56RUn+kHY4knBNPpuKmkk7cMZoQl1SroOx3pB8
	6dgQiEolej5kfYCEtuEfdp2+VeMgFZtfgV3OUzA7hHzeuTOE6HKD2qAAc+4hC4B6
	Mx/thnSod9K9hQc1KSiKt/rpXFc2Zj52/P9HwyPW6UZ7XS2bgyg1Ljczr22mJoXt
	X2zbll0WL27dsA+2Gf2/sL49zhg7tk7GWZTHlOJPFGZkymCGGfSZ9Mtw1DKIIgMz
	6SvMeubLun+BZFjfmJyrHlYA69bofN8jok2sLRYZWzCSjAJu9nEB0XOVYrQaDU41
	9xJVlg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c3bxr2p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:41:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O4fqaC023296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:41:52 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 20:41:49 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 24 Jan 2025 10:11:25 +0530
Subject: [PATCH v3 02/10] wifi: ath12k: add reference counting for core
 attachment to hardware group
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250124-fix_reboot_issues_with_hw_grouping-v3-2-329030b18d9e@quicinc.com>
References: <20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com>
In-Reply-To: <20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com>
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
X-Proofpoint-ORIG-GUID: A9wRu17zUrRtvm87nyIA3LilBJUgCBKI
X-Proofpoint-GUID: A9wRu17zUrRtvm87nyIA3LilBJUgCBKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240032

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

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 47 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h | 15 +----------
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c392f94584ff21051fb05d7843d0d500b1712d69..37dbef78b1999fb998443a94f0ffb81b2a4d2281 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -607,9 +607,49 @@ u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
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
@@ -849,9 +889,8 @@ static int ath12k_core_start(struct ath12k_base *ab)
 		/* ACPI is optional so continue in case of an error */
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
 
-	if (!test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
-		/* Indicate the core start in the appropriate group */
-		ath12k_core_started(ab);
+	/* Indicate the core start in the appropriate group */
+	ath12k_core_to_group_ref_get(ab);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 86a1eeec64a6e173048fd92a53df6b1d2df153f2..e7eeff356430e566d3a4b8dd3cb7c2d0bb712388 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1063,6 +1063,7 @@ struct ath12k_base {
 	struct ath12k_wsi_info wsi_info;
 	enum ath12k_firmware_mode fw_mode;
 	struct ath12k_ftm_event_obj ftm_event_obj;
+	bool hw_group_ref;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -1221,20 +1222,6 @@ static inline struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
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


