Return-Path: <linux-wireless+bounces-26812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B56B3A83C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D887B1F7D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F53314BB;
	Thu, 28 Aug 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jMrUhu+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1521B9F1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402578; cv=none; b=FiB/x/dKWQ4/r5ga0hvv+DtiCmfzyLRweH/JwFCIXIy7dC/f70ONx3XaPr55OHBsNfLJ4CNnccqZvhjQbr3mc/g0ZzRRsO1rzkTmWFLgJZV9vdJFowpoXsj/PQssWw+K5IGhA/iXDzVHV24IXH0fpifoEec01TrQAew4NQWCgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402578; c=relaxed/simple;
	bh=9LuELti2ydHiQFz4oo4hykPSZa0pMbV0naIYPNy3gaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD2v44E3pMzhiU4/YSRy1UQBcKbmzONXHM9t7AiuMoB5qJe2ap4sSzoUmrm0PKUyAnRmFDe9rIeVejGR1yLnLM7TS7k0I37wCISNCULJDlixYbh2bX8gfSJaeOtJPSepmSl8EVXXwIZ2vvKAswhUrButYjGok5l8gFwfZrCleuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jMrUhu+l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SERbBm027503;
	Thu, 28 Aug 2025 17:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MxZQL8egaO+cIlc8kUFJopTiPy8eppVHu75dQyHfOq8=; b=jMrUhu+lqM7ui8DY
	K0xuJEYuZzJ0AvFWcVFP1YhAGKGQNBteVUBk4f2NA3KsJFQ4vIXZ5wsPjLTYy1J5
	z+8yRisib7q/l+QYTedgPCu/lvXDE5uum9SBGh9ichO57xwIr9zLidbDYJNqy+//
	Hz3sjGBYy52+WoUPrc4mxjc3+VV9fZDObVwRDjGgnQTa9Jblt/g0bbmVv7bLYRkE
	o/KLlMblHekCs+ZCND6al1EOLKKVS3Lc009IoKEywmKMNeIWaWGnpiQWkTdzE6GT
	iDqh61Xp5kTbLGtnA9ucqyYUpqRhDJDYpuI864Y2hdCkNfhCaDtBveln0RHklCUh
	mO4BpQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se17050k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaBS3003501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:11 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:10 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 01/20] wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:34 +0530
Message-ID: <20250828173553.3341351-2-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: SD7LXPj9becZvN7F0Y6RnYLIO3AFMQx9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfXzE1sdDagwJ9c
 RfXHDNIpTnodCQ8j+hIZ5x2mrsMNk+6Xt+iefCn4AUCLO9elTEJvz4T4+EZR/97s00Baz126K+2
 cN3M5/O6Dl2ssJ/I8rNN4qGOK5RV2gvgmUqvARIPI6EGLIRh8bl7NlZx9Vk23AmudiyNIYxT9DX
 AwyZ21B8IhlgJho6OVIQvN65nZpclJ2orA0GAkxIfuKYTRTZi4oQbi49T6ZRwd9CpP5DFYc+db+
 OQ9xdal98TCKEFooOAv3kjw+VrXqSTPtPnGV5Lyer8KhZIpIgnJntl6z1F7WeyQmRymnasL2jmJ
 gd6xUOPNd8nhr+b5drxlY6oqJKsZnq4JK6x1EP6mz0LjSSaZVEQzzpgm2BMah3k6craPHsoBVEI
 TnGph02u
X-Proofpoint-ORIG-GUID: SD7LXPj9becZvN7F0Y6RnYLIO3AFMQx9
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68b0938c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=88aliKi4RoGy_8v3A6YA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move architecture-specific files hal_rx.c and hal_tx.c into the wifi7
directory as part of a broader effort to separate common and hardware
-specific code into distinct modules. This modularization enables reuse
of the common driver components across multiple hardware architectures.

The relocated files remain part of ath12k.ko temporarily, until the
corresponding infra for movement to the ath12k_wifi7.ko arrives in
upcoming patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile           |  5 +++--
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c   | 14 +++++++-------
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c   | 10 +++++-----
 3 files changed, 15 insertions(+), 14 deletions(-)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c (99%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c (96%)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 8dd77729f52f..b34cf83a24eb 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -2,8 +2,6 @@
 obj-$(CONFIG_ATH12K) += ath12k.o
 ath12k-y += core.o \
 	    hal.o \
-	    hal_tx.o \
-	    hal_rx.o \
 	    wmi.o \
 	    mac.o \
 	    reg.o \
@@ -24,6 +22,9 @@ ath12k-y += core.o \
 
 ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
 
+ath12k-y += wifi7/hal_tx.o \
+	    wifi7/hal_rx.o \
+
 obj-$(CONFIG_ATH12K) += wifi7/
 
 ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
similarity index 99%
rename from drivers/net/wireless/ath/ath12k/hal_rx.c
rename to drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 48aa48c48606..a25b21740e08 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include "debug.h"
-#include "hal.h"
-#include "hal_tx.h"
-#include "hal_rx.h"
-#include "hal_desc.h"
-#include "hif.h"
+#include "../debug.h"
+#include "../hal.h"
+#include "../hif.h"
+#include "../hal_tx.h"
+#include "../hal_rx.h"
+#include "../hal_desc.h"
 
 static void ath12k_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
 					u8 owner, u8 buffer_type, u32 magic)
diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
similarity index 96%
rename from drivers/net/wireless/ath/ath12k/hal_tx.c
rename to drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
index 869e07e406fe..f58da63a1b02 100644
--- a/drivers/net/wireless/ath/ath12k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include "hal_desc.h"
-#include "hal.h"
-#include "hal_tx.h"
-#include "hif.h"
+#include "../hal_desc.h"
+#include "../hal.h"
+#include "../hal_tx.h"
+#include "../hif.h"
 
 #define DSCP_TID_MAP_TBL_ENTRY_SIZE 64
 
-- 
2.34.1


