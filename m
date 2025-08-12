Return-Path: <linux-wireless+bounces-26332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED149B22EA9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270E57AD7A0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F832FD1DA;
	Tue, 12 Aug 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oRSjQ7pm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF42FD1CD
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018769; cv=none; b=rbG2IvsVXDaEEaVHxk/8uwlKY2zqf6w0tdnV2bj8bV6pj4XpU9+2WAM0DTgi/HiBD+qY9nKFyFo14ZqTS/UWbv0dk40WyPxMDiHUIAhGYtrFecDRqCibr/vOrCHvaIFwYQuX3RZ3gVamfW6ljGs0feyj3h326sPwEnvyDo/OjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018769; c=relaxed/simple;
	bh=A4oHDZ2yB4s+RwjgvnzQ2m5UBl64ZssHuLwkndE1Fmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IUJOUGpp2Nm43Uu0FMvTBBvS8GYEWbIt8Qx1HabJ05PNpVtCuW9UIdWQSiGy3q89vJyC6NZqPtXlBzsl0nGyz4zpQqngnE1REt6uN82oKjyT/HLPMYW9vA/GAafuQexjSSfN/J4/wT3gVtjQgI2qvyRfjY5aBGc2pbf45KmfTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oRSjQ7pm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvkMR029567;
	Tue, 12 Aug 2025 17:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RF7QkeOivGd9A5TJMyUTkSttDHZ4CJxxNKKLPHVW+Bc=; b=oRSjQ7pmjIizYfRT
	7ohoeTPyWt83UmBijmxYEnwV9z8zQSZUp5cHWeDWeNb+x1ghJRfCAMwa3Bhmf5Oc
	jkvOj2X6GbULaKRSogbGjhI+MW6FQ7bax8qcIMcLJiW4RwHlVoaK2H6vf++XHyCG
	BloL2pk0/4SImeWwjsoN1LeE9Wt8Nm0skzE24HOx7tGGH7szz12HXXFXTnuPff6b
	vys3r+7NbvzPAGzqzS3TITPTY88fBJBv7KMmCNQoi2qSDftKlDzmcH0/TSsof1B9
	QCsz04Ia9ZgllNeQ/tNvfJFIM6lJp0WXKOyVAQHzm8cnbFLkhiAeuakD3Jc3eCIF
	QZrSqQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g8x42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCien012378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:44 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:43 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:34 +0530
Subject: [PATCH ath12k-ng 08/13] wifi: ath12k: Move Wi-Fi 7 specific init
 routines to dedicated file
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-8-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b760d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=-qkzmB42osdL-UsmhmcA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX/orUTjM1snwY
 6sUE69Z3qXc0nGLtol0owAwOQy5seTotuHDhSQe7x2E8nG8YC1zRqGEw9eL84bOJcDkJ/ABeK8K
 mF3chlf5b233TGTxc03rG8Lw7ajW7BabwF2jOtxvkBaHmhT9bW+wc9vrv5Nn1DqtxdBO+MtRm58
 TTK1tppsdTL7oAMZRwoCn9tkcrRPMms5FUGdCmYVKkULj1ThYby/b7YGG2DhuI91KwjHb3Dwwjw
 oXTgHUL9RH6usP3u+4V/YMYfpHLSWj5TSkl03NA8bDrw53a/G7iqimvw5iMVcOPn0h08LaEvk7W
 c51zyC3uy4gC8tKgLqsswldoDT+UiM3QklU9ZbOvRoG4+YnDJn8+c75mdfUu6rxLVXsbPY1jDgs
 vsv6OjXW
X-Proofpoint-GUID: OC_-b08A3zaynh_SHEfPJtHNam-0m4Yl
X-Proofpoint-ORIG-GUID: OC_-b08A3zaynh_SHEfPJtHNam-0m4Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

Move Wi-Fi 7 specific module initialization and exit routines from core.c
to a new core_wifi7.c file. Decouple these routines from common module
entry points to improve modularity.

This restructuring is part of a broader effort to modularize the
ATH12K driver by separating common logic from hardware family-specific
implementations, improving maintainability and scalability.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile     |  1 +
 drivers/net/wireless/ath/ath12k/core.c       | 32 --------------------
 drivers/net/wireless/ath/ath12k/core_wifi7.c | 44 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 5c044e39633057651f80c3039f1340e791e419b4..9c7a32930ed60eafc36fa65aa0ac001d9237eaf8 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 obj-$(CONFIG_ATH12K) += ath12k.o
 ath12k-y += core.o \
+	    core_wifi7.o \
 	    hal.o \
 	    hal_tx.o \
 	    hal_rx.o \
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1333422724e4e873c8a36a53cf0faf4eda82c1a4..b1a26027de3f8d83a7823fba94cc0ef1df38c7b7 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -22,10 +22,7 @@
 #include "hif.h"
 #include "pci.h"
 #include "wow.h"
-#include "pci_wifi7.h"
-#include "ahb_wifi7.h"
 
-static int ahb_err, pci_err;
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
@@ -2282,32 +2279,3 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	kfree(ab);
 	return NULL;
 }
-
-static int ath12k_init(void)
-{
-	ahb_err = ath12k_wifi7_ahb_init();
-	if (ahb_err)
-		pr_warn("Failed to initialize ath12k AHB device: %d\n", ahb_err);
-
-	pci_err = ath12k_wifi7_pci_init();
-	if (pci_err)
-		pr_warn("Failed to initialize ath12k PCI device: %d\n", pci_err);
-
-	/* If both failed, return one of the failures (arbitrary) */
-	return ahb_err && pci_err ? ahb_err : 0;
-}
-
-static void ath12k_exit(void)
-{
-	if (!pci_err)
-		ath12k_wifi7_pci_exit();
-
-	if (!ahb_err)
-		ath12k_wifi7_ahb_exit();
-}
-
-module_init(ath12k_init);
-module_exit(ath12k_exit);
-
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11be WLAN devices");
-MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath12k/core_wifi7.c b/drivers/net/wireless/ath/ath12k/core_wifi7.c
new file mode 100644
index 0000000000000000000000000000000000000000..85ea8904672cbca03a77e8e9a70c5b397b5e08e2
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/core_wifi7.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/module.h>
+#include "ahb.h"
+#include "pci.h"
+#include "pci_wifi7.h"
+#include "ahb_wifi7.h"
+
+static int ahb_err, pci_err;
+
+static int ath12k_wifi7_init(void)
+{
+	ahb_err = ath12k_wifi7_ahb_init();
+	if (ahb_err)
+		pr_warn("Failed to initialize ath12k Wi-Fi 7 AHB device: %d\n",
+			ahb_err);
+
+	pci_err = ath12k_wifi7_pci_init();
+	if (pci_err)
+		pr_warn("Failed to initialize ath12k Wi-Fi 7 PCI device: %d\n",
+			pci_err);
+
+	/* If both failed, return one of the failures (arbitrary) */
+	return ahb_err && pci_err ? ahb_err : 0;
+}
+
+static void ath12k_wifi7_exit(void)
+{
+	if (!pci_err)
+		ath12k_wifi7_pci_exit();
+
+	if (!ahb_err)
+		ath12k_wifi7_ahb_exit();
+}
+
+module_init(ath12k_wifi7_init);
+module_exit(ath12k_wifi7_exit);
+
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11be WLAN devices");
+MODULE_LICENSE("Dual BSD/GPL");

-- 
2.34.1


