Return-Path: <linux-wireless+bounces-26814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B490DB3A83E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E67188E0AE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAD21B9F1;
	Thu, 28 Aug 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ErSjSoQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0A32C301
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402579; cv=none; b=T4EelFmzukbptf2BJlvDU8Zr66PQI0MhbddpwIDmN8NdtVklcOBojUek7orhLXjFLWR/FrHNRwkzmPpMVGsZV6jbOb97dATTH7HDx2eGyoCrsYVhk3XaGolxuE8NdvgUfv/wz4EuOYFDcXLEjsCKg/NCUyXBNsbW9Xg6E/WeJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402579; c=relaxed/simple;
	bh=cw72hePrfeP3vtpztfQtAZgM+g64I7tDu/omOk/StCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHMCq97/XbplLSE8CxuIpvyYrHgzCrnmdOrMkH8aRlItj1B7i8R/ebG+U3RArGfqCaGMXMQRY8thiYXrLlVhquzYlIG67vughuy5JMBsUWiBS1nweFiQ+tnd2JknQMSvGgkQO+21w+QPwC0HqljrtrT5/yWnZF7Oe37OivQyMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ErSjSoQY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEea66014879;
	Thu, 28 Aug 2025 17:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fTJWdJq6LTV2ryEo+OHaHS3XMzVwWJ8j55UfFPv1sE0=; b=ErSjSoQYwmMqMlTz
	hMAsCnD2cYlZaxbp/nTlEiRvxKdsQXaMDSgugSJZyLCJYungC1/iYYnDLHXZtAOq
	8I+hHT+YtUVpKRxIi98wDBDKiMbOOB4KVXArsZvObTzNpW8rQnvkRPTd/ayG81E4
	eL4fy30SLiRcaEJ0kEpeWWKKUXLpe9G0A4+MwDO6r9/4k8sg1l2rSTXIN+B106jh
	mScwa07vJLnpe/g+0J3CNLje4Q2cG3chFggY4gQF101SoM3yLn9bO2B9ig7WH/nY
	A82x5Xiz9W3V4BtR9ptrT2MJ43gytOyLNdbfLTUJVt50F1SVPWypxfpyZfQF4IGM
	NDW7rA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we8uqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaCg3015571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:12 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:11 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 02/20] wifi: ath12k: Move hal_tx.h file to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:35 +0530
Message-ID: <20250828173553.3341351-3-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: R2NZ1pzr6wfeQfEXl8ks970cMXXOYfRs
X-Proofpoint-ORIG-GUID: R2NZ1pzr6wfeQfEXl8ks970cMXXOYfRs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX18rMkma6nJXu
 pFafX2/VE8OrTtUmoKVuniaIEXD1TXu6Q/dhx8z7+9Fox8bJ1DHGb9AvihNGj3d3qqeAEYW3PJk
 jQbx7TUO+xAuPOk3KhQ+Qpy/UVB0B/iMZV9GkvMdS+jVH5aRAdV4bc8WQXUU4Nbo69OytejjmNt
 m1vdVsXjWKbUjjUKyJW4ngz0vDGShKpvl//GDVq6nZuG8PZmXTh0OA+MWHWqTTOQy3DA24FcFvc
 h7vhTDUZ7LAUbh4up+hzvOXC0P/psgX8b4obwSphyOGaCeERlEJ0m/Ho8RoVhOrbgh6RVvqdUsb
 MKhq5iQMgupOUIGLN4a/0EVA1t43V6rHgU1/VTWU/Gip53PPcLgacA6e4TFN248ZKmAz0aKV34L
 W1NK8S/B
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b0938d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=wbzX8aGHn4GJgQcjPRYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move wifi7 architecture specific file hal_tx.h to wifi7 directory, and move
the common part from it to hal.h file which is in the common directory.

It is as part of a broader effort to separate common and hardware-specific
code into distinct modules. This modularization enables reuse of the common
driver components across multiple hardware architectures.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c                |  4 ++--
 drivers/net/wireless/ath/ath12k/dp_tx.h             |  4 ++--
 drivers/net/wireless/ath/ath12k/hal.c               |  4 ++--
 drivers/net/wireless/ath/ath12k/hal.h               |  9 ++++++++-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c      |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c      |  2 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h    | 13 +++----------
 7 files changed, 19 insertions(+), 19 deletions(-)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h (95%)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index f893fce6d9bd..a3170e02d4c7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <crypto/hash.h>
 #include "core.h"
 #include "dp_tx.h"
-#include "hal_tx.h"
+#include "wifi7/hal_tx.h"
 #include "hif.h"
 #include "debug.h"
 #include "dp_rx.h"
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 10acdcf1fa8f..aa2f6397bc83 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -1,14 +1,14 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_DP_TX_H
 #define ATH12K_DP_TX_H
 
 #include "core.h"
-#include "hal_tx.h"
+#include "wifi7/hal_tx.h"
 
 struct ath12k_dp_htt_wbm_tx_status {
 	bool acked;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 022eea9515ef..dbbdb6f3f8cf 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/dma-mapping.h>
-#include "hal_tx.h"
+#include "wifi7/hal_tx.h"
 #include "hal_rx.h"
 #include "debug.h"
 #include "hal_desc.h"
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index c1750b5dc03c..b3aa13ad5196 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_HAL_H
@@ -11,6 +11,13 @@
 #include "rx_desc.h"
 
 struct ath12k_base;
+
+#define HAL_TX_ADDRX_EN			1
+#define HAL_TX_ADDRY_EN			2
+
+#define HAL_TX_ADDR_SEARCH_DEFAULT	0
+#define HAL_TX_ADDR_SEARCH_INDEX	1
+
 #define HAL_CE_REMAP_REG_BASE	(ab->ce_remap_base_addr)
 
 #define HAL_LINK_DESC_SIZE			(32 << 2)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index a25b21740e08..93727a55fc75 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -7,7 +7,7 @@
 #include "../debug.h"
 #include "../hal.h"
 #include "../hif.h"
-#include "../hal_tx.h"
+#include "hal_tx.h"
 #include "../hal_rx.h"
 #include "../hal_desc.h"
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
index f58da63a1b02..87c1312c4f46 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
@@ -6,7 +6,7 @@
 
 #include "../hal_desc.h"
 #include "../hal.h"
-#include "../hal_tx.h"
+#include "hal_tx.h"
 #include "../hif.h"
 
 #define DSCP_TID_MAP_TBL_ENTRY_SIZE 64
diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
similarity index 95%
rename from drivers/net/wireless/ath/ath12k/hal_tx.h
rename to drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
index eb065a79f6c6..b179320569ff 100644
--- a/drivers/net/wireless/ath/ath12k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
@@ -1,21 +1,14 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc.
- * All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_HAL_TX_H
 #define ATH12K_HAL_TX_H
 
-#include "hal_desc.h"
-#include "core.h"
-
-#define HAL_TX_ADDRX_EN			1
-#define HAL_TX_ADDRY_EN			2
-
-#define HAL_TX_ADDR_SEARCH_DEFAULT	0
-#define HAL_TX_ADDR_SEARCH_INDEX	1
+#include "../hal_desc.h"
+#include "../core.h"
 
 /* TODO: check all these data can be managed with struct ath12k_tx_desc_info for perf */
 struct hal_tx_info {
-- 
2.34.1


