Return-Path: <linux-wireless+bounces-8243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574348D2AAE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CD31F22442
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033503611A;
	Wed, 29 May 2024 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="onDBc0W/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36022087
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948950; cv=none; b=FD9h2IP1Jl+HI42/irYrAR+WwazC5XRmlcBcx+e+e8CvKrbj7JIsrgZx7AsivYtzcLO8WiF7s577xx1fzuRGdfS8hRP4y7Ph7yP9wBqBEbJfNN2UPeJmEWWqgjb63uQfYLXyTtSuL1C2MsIDRDJCcevMlV1M+xJ2jpPVPz0odkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948950; c=relaxed/simple;
	bh=CFhxEXVv2HS1XIao5n0kLu2tQysKwyDNVpSEf/+Vnow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bFIkH2ZpuRCYgnVUyuTZzDHBApnsgLPII5nqEgDVFondOZxAHq8c31NWfQt2ZIH0h7RPTnu7GyDfxdEtIW63kio4pYBynMkbwl+kpCu/+zu9Vfog0gevBXefXslM03CU3oTRsjHFjtnmpnhQU/9WUZECVQxJOY/P+ZzyKViMQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=onDBc0W/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SLGgHx016293;
	Wed, 29 May 2024 02:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8rh1DS6E+AYvMZCyW+dBD2
	F1wkQNcLlVjCAWEkUWDHM=; b=onDBc0W/rSMAcumDoKcXfw59ysYr6CULIPRHJy
	IXHVLjWW+kMJSRLmbjil8mnav3rDk1HYag/F+Gyb/vTcDJU3b0uWoNyvkgvHu8cl
	kUQ55TD3dDVfcMlM+qbFLEld4TXSbG//O138PHiuoo/VZCr8/P0vKrHwDh9mKB4U
	ej3UiPFasgpbgaGMj9d80IGY7IL42IeYjOHBJa3I8zFfP53lF0Eea0F8ATVhpcyz
	6b3Tat+dbrE8zqCwTXaK3JXsHX/ALl8cg4TKh3XMxUUae0Yz+L26wT8FkQRDLIuf
	hpmWexS9aNvACrE5NVFN8W5JTYxmhCclyFR2zciem2TUB9nw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2myq7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 02:15:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T2Fhmh029700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 02:15:43 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 19:15:42 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: add panic handler
Date: Wed, 29 May 2024 10:15:33 +0800
Message-ID: <20240529021533.10861-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: dVhx3NzaKvgWqkJAtL3riZPsVckaeLqx
X-Proofpoint-ORIG-GUID: dVhx3NzaKvgWqkJAtL3riZPsVckaeLqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290013

Currently for ath12k PCI devices, firmware could be running in one of
several execution environments, e.g., PBL, SBL and mission mode etc. Among
which PBL is the only stage where PCIe link negotiation could happen. So
normally firmware runs in PBL in order to be enumerated during system reboot.

However it might not work in kernel crash scenario: ath12k target is not
found after warm reboot from kernel crash. This is because when kernel crashes,
ath12k host does nothing to firmware. And during warm reboot, WLAN power
is sustained. So firmware is likely to keep running in mission mode throughout
the bootup process. As a result PCIe link is not established and thus target
not enumerated.

So add a handler in panic notification list for ath12k. When kernel crashes,
this handler gets called and tries to reset target to PBL state. Then PCIe
link negotiation could happen and target gets enumerated.

This change applies to all PCI devices including WCN7850 and QCN9274.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 29 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/core.h |  3 +++
 drivers/net/wireless/ath/ath12k/hif.h  |  9 ++++++++
 drivers/net/wireless/ath/ath12k/pci.c  |  8 +++++++
 4 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index e7f628e935e4..4c3eab4686c2 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1188,6 +1188,29 @@ int ath12k_core_pre_init(struct ath12k_base *ab)
 	return 0;
 }
 
+static int ath12k_core_panic_handler(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct ath12k_base *ab = container_of(nb, struct ath12k_base,
+					      panic_nb);
+
+	return ath12k_hif_panic_handler(ab);
+}
+
+static int ath12k_core_panic_notifier_register(struct ath12k_base *ab)
+{
+	ab->panic_nb.notifier_call = ath12k_core_panic_handler;
+
+	return atomic_notifier_chain_register(&panic_notifier_list,
+					      &ab->panic_nb);
+}
+
+static void ath12k_core_panic_notifier_unregister(struct ath12k_base *ab)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &ab->panic_nb);
+}
+
 int ath12k_core_init(struct ath12k_base *ab)
 {
 	int ret;
@@ -1198,11 +1221,17 @@ int ath12k_core_init(struct ath12k_base *ab)
 		return ret;
 	}
 
+	ret = ath12k_core_panic_notifier_register(ab);
+	if (ret)
+		ath12k_warn(ab, "failed to register panic handler: %d\n", ret);
+
 	return 0;
 }
 
 void ath12k_core_deinit(struct ath12k_base *ab)
 {
+	ath12k_core_panic_notifier_unregister(ab);
+
 	mutex_lock(&ab->core_lock);
 
 	ath12k_core_pdev_destroy(ab);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7d20b09c52e6..44ca30b67fa2 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include <linux/ctype.h>
 #include <linux/firmware.h>
+#include <linux/panic_notifier.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -924,6 +925,8 @@ struct ath12k_base {
 
 #endif /* CONFIG_ACPI */
 
+	struct notifier_block panic_nb;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index 7f0926fe751d..0e53ec269fa4 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -30,6 +30,7 @@ struct ath12k_hif_ops {
 	void (*ce_irq_enable)(struct ath12k_base *ab);
 	void (*ce_irq_disable)(struct ath12k_base *ab);
 	void (*get_ce_msi_idx)(struct ath12k_base *ab, u32 ce_id, u32 *msi_idx);
+	int (*panic_handler)(struct ath12k_base *ab);
 };
 
 static inline int ath12k_hif_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
@@ -147,4 +148,12 @@ static inline void ath12k_hif_power_down(struct ath12k_base *ab, bool is_suspend
 	ab->hif.ops->power_down(ab, is_suspend);
 }
 
+static inline int ath12k_hif_panic_handler(struct ath12k_base *ab)
+{
+	if (!ab->hif.ops->panic_handler)
+		return NOTIFY_DONE;
+
+	return ab->hif.ops->panic_handler(ab);
+}
+
 #endif /* ATH12K_HIF_H */
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 11b95d037051..876c029f58f6 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1302,6 +1302,13 @@ void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend)
 	ath12k_pci_sw_reset(ab_pci->ab, false);
 }
 
+static int ath12k_pci_panic_handler(struct ath12k_base *ab)
+{
+	ath12k_pci_sw_reset(ab, false);
+
+	return NOTIFY_OK;
+}
+
 static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 	.start = ath12k_pci_start,
 	.stop = ath12k_pci_stop,
@@ -1319,6 +1326,7 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 	.ce_irq_enable = ath12k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath12k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath12k_pci_get_ce_msi_idx,
+	.panic_handler = ath12k_pci_panic_handler,
 };
 
 static

base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130
-- 
2.25.1


