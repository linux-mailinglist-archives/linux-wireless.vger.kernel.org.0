Return-Path: <linux-wireless+bounces-20821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F60A70E7F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1ED170A57
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 01:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A95154C0D;
	Wed, 26 Mar 2025 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U/JeQDSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5B1537DA;
	Wed, 26 Mar 2025 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952831; cv=none; b=dURdl3E43LoROQyIiHteEXd2WFK+HZKIHkdEFu/4nMuZmFvnk9Kv4qqfIOeB1jJYdTuiAF1mJjEhlai3rFpMuV/MeoySfpo2DhH7HrjXqVj8GPEmQSrkf7WSpvP8iAOdU0XmBT3+78rD3g13tQTgDy+PKVXiRCzLwjX9K2Je1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952831; c=relaxed/simple;
	bh=buFGPxJKp5LPASl+LcUcd/b9TzJcoIM9bS0v1EyFV6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R2ONVCV/lTMqUPUPrO4OlVqBj85IcsVY7uFd6aDJGbgdlsxoNA0VRg3yMci87F0qrIPBq2Led9lV3XOaPSWeARDzmGtO8EMUEbxzp+TZxSLd+wyqvsFYF5ccv501zt4CKPVSYEHfzBIzn7GgBuzyFr7uM6v3F8+YRmRm4SclriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U/JeQDSL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGb4OK021037;
	Wed, 26 Mar 2025 01:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8hvYKPYZ7HWG8jt/69M/6WOMgGMtEuuwT5NnWmrVDvk=; b=U/JeQDSLiPzRgOBh
	Cmjr9OHhl1pLJnDbETK6f4DpWmZ7qxSxuuc1gLd2wuS7uQ4I5/plo1WJhMKJb5tm
	pLUc4UcoiHiidOd+vhglsEVwXLa3uWsPNBDDATyueLQsxy8/VZsXf1oFYxh2Txew
	9Wgwuofqn03cEE1nOdQF+YxWDHqrKfTTaYDeQdjXznC4kgDbynvylfklsrUf1c5j
	ZTWkcqzTsH+ykTag/UuEPW3S7eb3WpMGxewL+2/flRfdhm0bk9DAbZuzTnewaFmF
	Qh0eXzNRoM3bZ0ajp0R+fL6yub972I3zhMoV804NF1Q6iREKWu2ZcGfP8E4rHGIu
	SFc1aw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd4ka2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q1XeId007615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:40 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Mar
 2025 18:33:39 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 26 Mar 2025 09:33:09 +0800
Subject: [PATCH ath-next v2 5/6] wifi: ath11l: choose default PM policy for
 hibernation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250326-ath11k-bring-hibernation-back-v2-5-87fdc2d6428f@quicinc.com>
References: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
In-Reply-To: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NQTXGZAOnceWyxykwH4Je48Sg8lAdHBC
X-Proofpoint-GUID: NQTXGZAOnceWyxykwH4Je48Sg8lAdHBC
X-Authority-Analysis: v=2.4 cv=QLZoRhLL c=1 sm=1 tr=0 ts=67e35975 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=6EVBoUctZwMGb3abvEYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260008

Now WoWLAN mode is chosen for those machines listed in the quirk table.
This works for suspend (S3) but breaks for hibernation (S4), because
WoWLAN mode requires WLAN power to be sustained, which is not the case
during hibernation. For hibernation, the default mode should be used.

Register a PM notifier with which kernel can notify us of the actual PM
operation: if system is going to suspend, the original PM policy is
honored; while if it is hibernation, overwrite it with default policy.

To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
non-WoWLAN mode is chosen for all.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 52 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.h |  5 ++++
 drivers/net/wireless/ath/ath11k/pci.c  |  1 +
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index e1c0eca773fc0243aa4d159dd8671f6a4084b29a..cde009c3bdaf1e7a4f64a10df61029ef83408cd0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1136,7 +1136,7 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 	if (ret <= 0)
 		return ret;
 
-	if (ab->pm_policy == ATH11K_PM_WOW)
+	if (ab->actual_pm_policy == ATH11K_PM_WOW)
 		return ath11k_core_suspend_wow(ab);
 
 	return ath11k_core_suspend_default(ab);
@@ -1151,7 +1151,7 @@ int ath11k_core_suspend_late(struct ath11k_base *ab)
 	if (ret <= 0)
 		return ret;
 
-	if (ab->pm_policy == ATH11K_PM_WOW)
+	if (ab->actual_pm_policy == ATH11K_PM_WOW)
 		return 0;
 
 	ath11k_hif_irq_disable(ab);
@@ -1171,7 +1171,7 @@ int ath11k_core_resume_early(struct ath11k_base *ab)
 	if (ret <= 0)
 		return ret;
 
-	if (ab->pm_policy == ATH11K_PM_WOW)
+	if (ab->actual_pm_policy == ATH11K_PM_WOW)
 		return 0;
 
 	reinit_completion(&ab->restart_completed);
@@ -1240,7 +1240,7 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	if (ret <= 0)
 		return ret;
 
-	if (ab->pm_policy == ATH11K_PM_WOW)
+	if (ab->actual_pm_policy == ATH11K_PM_WOW)
 		return ath11k_core_resume_wow(ab);
 
 	return ath11k_core_resume_default(ab);
@@ -2500,6 +2500,43 @@ int ath11k_core_pre_init(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_core_pre_init);
 
+static int ath11k_core_pm_notify(struct notifier_block *nb,
+				 unsigned long action, void *nouse)
+{
+	struct ath11k_base *ab = container_of(nb, struct ath11k_base,
+					      pm_nb);
+
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+		ab->actual_pm_policy = ab->pm_policy;
+		break;
+	case PM_HIBERNATION_PREPARE:
+		ab->actual_pm_policy = ATH11K_PM_DEFAULT;
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ath11k_core_pm_notifier_register(struct ath11k_base *ab)
+{
+	ab->pm_nb.notifier_call = ath11k_core_pm_notify;
+	return register_pm_notifier(&ab->pm_nb);
+}
+
+void ath11k_core_pm_notifier_unregister(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = unregister_pm_notifier(&ab->pm_nb);
+	if (ret)
+		/* just warn here, there is nothing can be done in fail case */
+		ath11k_warn(ab, "failed to unregister PM notifier %d\n", ret);
+}
+EXPORT_SYMBOL(ath11k_core_pm_notifier_unregister);
+
 int ath11k_core_init(struct ath11k_base *ab)
 {
 	const struct dmi_system_id *dmi_id;
@@ -2513,6 +2550,12 @@ int ath11k_core_init(struct ath11k_base *ab)
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n", ab->pm_policy);
 
+	ret = ath11k_core_pm_notifier_register(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to register PM notifier: %d\n", ret);
+		return ret;
+	}
+
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
@@ -2535,6 +2578,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	ath11k_hif_power_down(ab, false);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
+	ath11k_core_pm_notifier_unregister(ab);
 }
 EXPORT_SYMBOL(ath11k_core_deinit);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7a9354e0eadb58730028217960e5bbfe0056c2fb..339d4fca1ed5fbddd8f386589529f0febba98ecb 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -16,6 +16,7 @@
 #include <linux/rhashtable.h>
 #include <linux/average.h>
 #include <linux/firmware.h>
+#include <linux/suspend.h>
 
 #include "qmi.h"
 #include "htc.h"
@@ -1066,6 +1067,8 @@ struct ath11k_base {
 #endif
 
 	enum ath11k_pm_policy pm_policy;
+	enum ath11k_pm_policy actual_pm_policy;
+	struct notifier_block pm_nb;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -1333,4 +1336,6 @@ static inline const char *ath11k_bus_str(enum ath11k_bus bus)
 	return "unknown";
 }
 
+void ath11k_core_pm_notifier_unregister(struct ath11k_base *ab);
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 37f5ed7f74f2f6adb3a6b5e176ed8c0105d235c2..630df6b1d82dff357c8259475cc9b03e4580a1b9 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1164,6 +1164,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 		ath11k_pci_power_down(ab, false);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
+		ath11k_core_pm_notifier_unregister(ab);
 		goto qmi_fail;
 	}
 

-- 
2.34.1


