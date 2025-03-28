Return-Path: <linux-wireless+bounces-20909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CDDA74361
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57914189E2E7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D9211464;
	Fri, 28 Mar 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PnEnHYaN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F0192B89;
	Fri, 28 Mar 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139982; cv=none; b=UN+vCNPZkmolpFaIALuSmZ5IuX+Ap27pS07vhHbQsIANw4ZDoDj7UQK832P25Zt4ax0YSd0YJy7KoCGEMAh1YkBE4AnNcr4uae2miSmw43ZxV1txcN+HOiCm8nUXkaQ6Xu+cDG5jKJoO1HqariQGJGk3BsyUfvgNaM05t0byjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139982; c=relaxed/simple;
	bh=5kf6InNhSrQ8AsjK7dUZkY5s00h8ePulVYOcAEgrS2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WbhGbNTj4dgG8Qr6IK1TGYoWTHy63qlTTwIblO65l7GuA7ZrJ/3yz63gu2BcM5EKswstjJmsOpE9qnXjxKQCP4ZisZ/17b5iSkqq2reGSkIz+o1dKbY5a6TC56YOi9OeidtV4Co7QkEMqx/MTBG2oOJBrQbJ+rekal9Ew54moPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PnEnHYaN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S4xEX1022995;
	Fri, 28 Mar 2025 05:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KRtjDo6Azgqa/CfPuzGAYdL/9WlT06dCHi1DCxpEXP0=; b=PnEnHYaNfsJkID/O
	YAzAdA1EDpyEm21SumRgrR4gx6771pHAiDcVfHQZBZHafkx5JlpAon1psx2nsGH+
	gU0RsgBKUyrrhQKkbtCyTP69H+t6gUviwLhks89A+V2xNv1JHAcIq45b3hzDIrGP
	ncL1AeOphZQSGH9mkko/BA5ONYXFXD27zAsMGP2xyMMV8gZc6R8ihGvRTcnFtWDs
	C6MHn1NUte8+1/HZLtLP+zMNHzigSc0kkwuoYJE0u3cQ5MEi9ljAzqNVMELVWwbE
	r/PrSOszs5kFZZyj0/Ts8bIElbe7+TpUovpY9sDmExsOuHBnoEW75CLb7agdYhHs
	I00lsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9my0su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52S5WgLH030858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:42 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 22:32:40 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 28 Mar 2025 13:32:28 +0800
Subject: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy for
 hibernation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
In-Reply-To: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>, Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e6347b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=6EVBoUctZwMGb3abvEYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xhpS7-89lx4bmjSdoWs6Oye9UEKwHvN-
X-Proofpoint-ORIG-GUID: xhpS7-89lx4bmjSdoWs6Oye9UEKwHvN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280036

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

Tested-by: Takashi Iwai <tiwai@suse.de>
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


