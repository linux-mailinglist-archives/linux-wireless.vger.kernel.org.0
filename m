Return-Path: <linux-wireless+bounces-26334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388D6B22EB5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688B616D245
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C232FDC49;
	Tue, 12 Aug 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F8fdkRDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26FA2FD1CA
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018770; cv=none; b=eUTtyrr+P+RxzJEY31TaB2jTzQ7NZmEooUsOYVL+29KfKt6tMjWj3ZhwyvHdxezJxngCABKEucoST6UvY7QANZ6eXMqKhWfiBeoR7xfD/XlLOHYJitKkiNjSzYWPiPcGdGZf7lu6xRJqaAJRYUDH8SP+GOKAmLH2MMYW5XPrgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018770; c=relaxed/simple;
	bh=p+uYAIb+VW/G4ODyZNHYPJmNBBzrwJKkXzbpnaaUyMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e0FDGFzlbcQCa88IR075bW5lWfcU9Rr2tp7WmUh9ERK1CeLxuraJPVBSIJ2mhv1Sewy/tFQc26G4f+ZrhsP6zYs/LmUkLqN6z2q8aR2KnK9VAoDfvsqzYmydZZHLE6zCivQSuDGFcN3AFfLCkrkhXpaWhRJt+XPO7V4QE2qZpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F8fdkRDx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CCLPd4029015;
	Tue, 12 Aug 2025 17:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D6J3sJkKlxM21DeWCF4i4/FatyXLz57A6IszoXbWmJo=; b=F8fdkRDxnkHa1sqm
	/VcnsVjSqrdEPNZf9rB6RdbsRWrMz4PgPUicenMwcJABMQbgPLCr5MWhvV5krk0l
	t2YFMRgMVBbBT9Ad/Itc4hBr3WlHOdIm2sM6jtrHQXF7vpQN93iFbMmGAu6sSKEa
	2sMgREwxGDxTRGH/OBuP5tWfSkyKor3EXdYeT4ZhSHhf8DuNQPD1q/YXnzI8/HGJ
	666D0VoQvkzxdv/qP/HmnzceuguJvlstD3WqN4FdGLdrt9UR5pyQ/hTCc6NEnPJ8
	K5J3hd/e6ZTQOfR14Y1HmASxcm19BvcIeFB1olMrzfqE+ymsd+CacHnGsHE5z+n7
	BFhKgA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hm8vbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHChNh008060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:43 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:42 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:33 +0530
Subject: [PATCH ath12k-ng 07/13] wifi: ath12k: Restructure ahb.c into
 common and Wi-Fi 7 specific modules
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-7-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX37kC020k5jDE
 I0b/9ANV/jBj+8F27BV+9ck1jfOsxFi71IVMdHjhtNFHCoWMHDgCNC4LU1Yh/mw3QxXCft6Ar3h
 6DyTxrYfEN9YuT1aZou64BauO8y7MScKi1KYOH5NSFPu8GEx9yMlPjBrCyNo3duPsbkncXWNQcR
 eVRlABCIJdep6rbYic8WNBh9ibbVaOntL8vYwLEIwkPHAtQUhKWsC4dgn04lw/BZWXtnmt6m2nc
 qiCBShVdcL5jnrwqvBoeHfwXCus+8aMD0Wy7pT3sWx0WCDQmN9E3f2eDdgqw1WlE5Dm7nNzYJ9E
 F1fOBGWOfk7oRTMDWaYMaCF2zxdGTMfe+SjFsKBxkRKkyuwblo/RsDLoLqgDJxGuLnTXPvgo2yh
 RSKoFICC
X-Proofpoint-GUID: siy5AXFdhqD4VWl1t2aTXH3NOc723I1F
X-Proofpoint-ORIG-GUID: siy5AXFdhqD4VWl1t2aTXH3NOc723I1F
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689b760c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=iUYTLldr4w8bxq9Ft7IA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

Split ahb.c into a common module (ahb.c) and a Wi-Fi 7 specific module
(ahb_wifi7.c). Retain shared logic-such as probe and initialization
sequences-in ahb.c to support reuse across hardware families.
Move Wi-Fi 7 specific initialization and configuration routines to
ahb_wifi7.c and register them via callbacks.
This modular approach improves code organization and prepares the
driver for scalable support of additional hardware families.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile    |   2 +-
 drivers/net/wireless/ath/ath12k/ahb.c       | 128 +++++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/ahb.h       |  27 +++---
 drivers/net/wireless/ath/ath12k/ahb_wifi7.c |  63 ++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb_wifi7.h |  20 +++++
 drivers/net/wireless/ath/ath12k/core.c      |   5 +-
 6 files changed, 190 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index f1105d7adafff957b8a6ee3231e03a7f6ea47ed2..5c044e39633057651f80c3039f1340e791e419b4 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -27,7 +27,7 @@ ath12k-y += core.o \
 	    fw.o \
 	    p2p.o
 
-ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
+ath12k-$(CONFIG_ATH12K_AHB) += ahb.o ahb_wifi7.o
 ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index f512854e82e4f32328dc49eac2472027c7369dfd..fc986e669bdea85cdf3dcc3d60c1f2cc9216d3e0 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -16,18 +16,11 @@
 #include "debug.h"
 #include "hif.h"
 
-static const struct of_device_id ath12k_ahb_of_match[] = {
-	{ .compatible = "qcom,ipq5332-wifi",
-	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
-	},
-	{ }
-};
-
-MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);
-
 #define ATH12K_IRQ_CE0_OFFSET 4
 #define ATH12K_MAX_UPDS 1
 #define ATH12K_UPD_IRQ_WRD_LEN  18
+
+static struct ath12k_ahb_driver *ath12k_ahb_family_drivers[ATH12K_DEVICE_FAMILY_MAX];
 static const char ath12k_userpd_irq[][9] = {"spawn",
 				     "ready",
 				     "stop-ack"};
@@ -988,13 +981,34 @@ static void ath12k_ahb_resource_deinit(struct ath12k_base *ab)
 	ab_ahb->xo_clk = NULL;
 }
 
+static enum ath12k_device_family
+ath12k_ahb_get_device_family(const struct platform_device *pdev)
+{
+	enum ath12k_device_family device_family_id;
+	struct ath12k_ahb_driver *driver;
+	const struct of_device_id *of_id;
+
+	for (device_family_id = ATH12K_DEVICE_FAMILY_START;
+	     device_family_id < ATH12K_DEVICE_FAMILY_MAX; device_family_id++) {
+		driver = ath12k_ahb_family_drivers[device_family_id];
+		if (driver) {
+			of_id = of_match_device(driver->id_table, &pdev->dev);
+			if (of_id) {
+				/* Found the driver */
+				return device_family_id;
+			}
+		}
+	}
+
+	return ATH12K_DEVICE_FAMILY_MAX;
+}
+
 static int ath12k_ahb_probe(struct platform_device *pdev)
 {
-	struct ath12k_base *ab;
-	const struct ath12k_hif_ops *hif_ops;
+	enum ath12k_device_family device_id;
 	struct ath12k_ahb *ab_ahb;
-	enum ath12k_hw_rev hw_rev;
-	u32 addr, userpd_id;
+	struct ath12k_base *ab;
+	u32 addr;
 	int ret;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -1008,25 +1022,32 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	if (!ab)
 		return -ENOMEM;
 
-	hw_rev = (enum ath12k_hw_rev)(kernel_ulong_t)of_device_get_match_data(&pdev->dev);
-	switch (hw_rev) {
-	case ATH12K_HW_IPQ5332_HW10:
-		hif_ops = &ath12k_ahb_hif_ops;
-		userpd_id = ATH12K_IPQ5332_USERPD_ID;
-		break;
-	default:
-		ret = -EOPNOTSUPP;
+	ab_ahb = ath12k_ab_to_ahb(ab);
+	ab_ahb->ab = ab;
+	ab->hif.ops = &ath12k_ahb_hif_ops;
+	ab->pdev = pdev;
+	platform_set_drvdata(pdev, ab);
+
+	device_id = ath12k_ahb_get_device_family(pdev);
+	if (device_id >= ATH12K_DEVICE_FAMILY_MAX) {
+		ath12k_err(ab, "failed to get device family: %d\n", device_id);
+		ret = -EINVAL;
 		goto err_core_free;
 	}
 
-	ab->hif.ops = hif_ops;
-	ab->pdev = pdev;
-	ab->hw_rev = hw_rev;
-	ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
-	platform_set_drvdata(pdev, ab);
-	ab_ahb = ath12k_ab_to_ahb(ab);
-	ab_ahb->ab = ab;
-	ab_ahb->userpd_id = userpd_id;
+	ath12k_dbg(ab, ATH12K_DBG_AHB, "AHB device family id: %d\n", device_id);
+
+	ab_ahb->device_family_ops = &ath12k_ahb_family_drivers[device_id]->ops;
+
+	/* Call device specific probe. This is the callback that can
+	 * be used to override any ops in future
+	 * probe is validated for NULL during registration.
+	 */
+	ret = ab_ahb->device_family_ops->probe(pdev);
+	if (ret) {
+		ath12k_err(ab, "failed to probe device: %d\n", ret);
+		goto err_core_free;
+	}
 
 	/* Set fixed_mem_region to true for platforms that support fixed memory
 	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
@@ -1136,21 +1157,44 @@ static void ath12k_ahb_remove(struct platform_device *pdev)
 	ath12k_ahb_free_resources(ab);
 }
 
-static struct platform_driver ath12k_ahb_driver = {
-	.driver         = {
-		.name   = "ath12k_ahb",
-		.of_match_table = ath12k_ahb_of_match,
-	},
-	.probe  = ath12k_ahb_probe,
-	.remove = ath12k_ahb_remove,
-};
-
-int ath12k_ahb_init(void)
+int ath12k_ahb_register_driver(const enum ath12k_device_family device_id,
+			       struct ath12k_ahb_driver *driver)
 {
-	return platform_driver_register(&ath12k_ahb_driver);
+	struct platform_driver *ahb_driver;
+
+	if (device_id >= ATH12K_DEVICE_FAMILY_MAX)
+		return -EINVAL;
+
+	if (!driver || !driver->ops.probe)
+		return -EINVAL;
+
+	if (ath12k_ahb_family_drivers[device_id]) {
+		pr_err("Driver already registered for id %d\n", device_id);
+		return -EALREADY;
+	}
+
+	ath12k_ahb_family_drivers[device_id] = driver;
+
+	ahb_driver = &ath12k_ahb_family_drivers[device_id]->driver;
+	ahb_driver->driver.name = driver->name;
+	ahb_driver->driver.of_match_table = driver->id_table;
+	ahb_driver->probe  = ath12k_ahb_probe;
+	ahb_driver->remove = ath12k_ahb_remove;
+
+	return platform_driver_register(ahb_driver);
 }
 
-void ath12k_ahb_exit(void)
+void ath12k_ahb_unregister_driver(const enum ath12k_device_family device_id)
 {
-	platform_driver_unregister(&ath12k_ahb_driver);
+	struct platform_driver *ahb_driver;
+
+	if (device_id >= ATH12K_DEVICE_FAMILY_MAX)
+		return;
+
+	if (!ath12k_ahb_family_drivers[device_id])
+		return;
+
+	ahb_driver = &ath12k_ahb_family_drivers[device_id]->driver;
+	platform_driver_unregister(ahb_driver);
+	ath12k_ahb_family_drivers[device_id] = NULL;
 }
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index d56244b20a6a667cf3730dc1ce38a22b0e86ffca..fce02e3af5fb406a732eb52d6854a551f6d80012 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/remoteproc/qcom_rproc.h>
+#include <linux/platform_device.h>
 #include "core.h"
 
 #define ATH12K_AHB_RECOVERY_TIMEOUT (3 * HZ)
@@ -43,6 +44,10 @@ enum ath12k_ahb_userpd_irq {
 
 struct ath12k_base;
 
+struct ath12k_ahb_device_family_ops {
+	int (*probe)(struct platform_device *pdev);
+};
+
 struct ath12k_ahb {
 	struct ath12k_base *ab;
 	struct rproc *tgt_rproc;
@@ -59,6 +64,15 @@ struct ath12k_ahb {
 	u32 spawn_bit;
 	u32 stop_bit;
 	int userpd_irq_num[ATH12K_USERPD_MAX_IRQ];
+	const struct ath12k_ahb_ops *ahb_ops;
+	const struct ath12k_ahb_device_family_ops *device_family_ops;
+};
+
+struct ath12k_ahb_driver {
+	const char *name;
+	const struct of_device_id *id_table;
+	struct ath12k_ahb_device_family_ops ops;
+	struct platform_driver driver;
 };
 
 static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)
@@ -66,15 +80,8 @@ static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)
 	return (struct ath12k_ahb *)ab->drv_priv;
 }
 
-#ifdef CONFIG_ATH12K_AHB
-int ath12k_ahb_init(void);
-void ath12k_ahb_exit(void);
-#else
-static inline int ath12k_ahb_init(void)
-{
-	return 0;
-}
+int ath12k_ahb_register_driver(const enum ath12k_device_family device_id,
+			       struct ath12k_ahb_driver *driver);
+void ath12k_ahb_unregister_driver(const enum ath12k_device_family device_id);
 
-static inline void ath12k_ahb_exit(void) {};
-#endif
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/ahb_wifi7.c b/drivers/net/wireless/ath/ath12k/ahb_wifi7.c
new file mode 100644
index 0000000000000000000000000000000000000000..7a869722b77e639781fed45835872c38a50b8cfc
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/ahb_wifi7.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/mdt_loader.h>
+#include "ahb.h"
+#include "ahb_wifi7.h"
+#include "debug.h"
+#include "hif.h"
+
+static const struct of_device_id ath12k_wifi7_ahb_of_match[] = {
+	{ .compatible = "qcom,ipq5332-wifi",
+	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ath12k_wifi7_ahb_of_match);
+
+static int ath12k_wifi7_ahb_probe(struct platform_device *pdev)
+{
+	struct ath12k_ahb *ab_ahb;
+	enum ath12k_hw_rev hw_rev;
+	struct ath12k_base *ab;
+
+	ab = platform_get_drvdata(pdev);
+	ab_ahb = ath12k_ab_to_ahb(ab);
+
+	hw_rev = (enum ath12k_hw_rev)(kernel_ulong_t)of_device_get_match_data(&pdev->dev);
+	switch (hw_rev) {
+	case ATH12K_HW_IPQ5332_HW10:
+		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
+	ab->hw_rev = hw_rev;
+
+	return 0;
+}
+
+static struct ath12k_ahb_driver ath12k_wifi7_ahb_driver = {
+	.name = "ath12k_wifi7_ahb",
+	.id_table = ath12k_wifi7_ahb_of_match,
+	.ops.probe = ath12k_wifi7_ahb_probe,
+};
+
+int ath12k_wifi7_ahb_init(void)
+{
+	return ath12k_ahb_register_driver(ATH12K_DEVICE_FAMILY_WIFI7,
+					  &ath12k_wifi7_ahb_driver);
+}
+
+void ath12k_wifi7_ahb_exit(void)
+{
+	ath12k_ahb_unregister_driver(ATH12K_DEVICE_FAMILY_WIFI7);
+}
diff --git a/drivers/net/wireless/ath/ath12k/ahb_wifi7.h b/drivers/net/wireless/ath/ath12k/ahb_wifi7.h
new file mode 100644
index 0000000000000000000000000000000000000000..5974c7cad69aecc8763045a70fc291e9f1c5940d
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/ahb_wifi7.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef ATH12K_AHB_WIFI7_H
+#define ATH12K_AHB_WIFI7_H
+
+#ifdef CONFIG_ATH12K_AHB
+int ath12k_wifi7_ahb_init(void);
+void ath12k_wifi7_ahb_exit(void);
+#else
+static inline int ath12k_wifi7_ahb_init(void)
+{
+	return 0;
+}
+
+static inline void ath12k_wifi7_ahb_exit(void) {}
+#endif
+#endif /* ATH12K_AHB_WIFI7_H */
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index b723d7d28cdac48934d621338d6a623781c86b73..1333422724e4e873c8a36a53cf0faf4eda82c1a4 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -23,6 +23,7 @@
 #include "pci.h"
 #include "wow.h"
 #include "pci_wifi7.h"
+#include "ahb_wifi7.h"
 
 static int ahb_err, pci_err;
 unsigned int ath12k_debug_mask;
@@ -2284,7 +2285,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 
 static int ath12k_init(void)
 {
-	ahb_err = ath12k_ahb_init();
+	ahb_err = ath12k_wifi7_ahb_init();
 	if (ahb_err)
 		pr_warn("Failed to initialize ath12k AHB device: %d\n", ahb_err);
 
@@ -2302,7 +2303,7 @@ static void ath12k_exit(void)
 		ath12k_wifi7_pci_exit();
 
 	if (!ahb_err)
-		ath12k_ahb_exit();
+		ath12k_wifi7_ahb_exit();
 }
 
 module_init(ath12k_init);

-- 
2.34.1


