Return-Path: <linux-wireless+bounces-7422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF498C1D91
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 07:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8731C216DF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8344152795;
	Fri, 10 May 2024 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dIcYOsrv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DD13C3C1
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317705; cv=none; b=ObRlJFw4yde/VNROIiPs0q3nAMCJvGlnwyrYJD1BkF1Ei7kgaWjgS0mrl+BXsBRR1rZxSM6mDrF/v3JKj3J1ldQxJiKe/0HpnYcXjE4Atm0f+nKDtHNkdPahg7kRrR1V1USRhk9A07caxkZV2H89OibFNXFe3dQ0PeB8qao5KCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317705; c=relaxed/simple;
	bh=4LLwqmjXSIEgExL/K/uNLVkOUBXHECrHFTzU/ANSNUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1wz1NwlD89GAsVLDt71eOzp5swf4yWw/Ql2iaaElar+AQvkFodUAYD4C9iEMwmB5Xib0HZqN+zgo39ONwJQMt1CrtoFkf17ttMOwOVgn3hxEZTblKmezc8jbLTYFJ6OapnbYMTy0qAApaCm/QqNdVqP80ky/9JsUA8rwfCb3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dIcYOsrv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tgTg000730;
	Fri, 10 May 2024 05:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=hhj2/y9
	ymi3x+7ovkzLVeIPZCqETh8RGFXKNhKLDNxE=; b=dIcYOsrvOPBPyZGR2Egb4Pa
	0C3xXo9QjSBi7F+wh6ZG8zgiu0jkL2kyO0lMg3sa+gI3dbkQDbGo4HltUgh5l6VR
	KtASfqRutMdCGCkLblESNfNv743hy0hToxds1MR3qS5DvNaCdhH6PYRo7sZP2Cw3
	SK9kp+BPR0aJVdySRnApLzWKvzqEIeG0C9FObp6Q0qoVKCX5dPbxNrD88jl/5KQX
	VJnTe0MJFD/oWrU1aR9DRUMfLvHnNwetjrmWCWQ41rSOSkXRciwAI52NV2WUYx6S
	t7pFDSh6rSos3UJ3pJU/+cnqyphAVMULL3De6QIWjBaHwPLysbac4okHih4FzTQ=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0rkgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44A58A4g031839;
	Fri, 10 May 2024 05:08:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xwe3krc4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44A58Ai1031805;
	Fri, 10 May 2024 05:08:10 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44A58Aw0031799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:10 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 081DB4105C; Fri, 10 May 2024 10:38:09 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v2 1/5] wifi: ath12k: Add support to enable debugfs_htt_stats
Date: Fri, 10 May 2024 10:38:02 +0530
Message-Id: <20240510050806.514126-2-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QgIrbnudsTYFTVwHJth4q65Munv7WjD1
X-Proofpoint-ORIG-GUID: QgIrbnudsTYFTVwHJth4q65Munv7WjD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_03,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100034

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Create debugfs_htt_stats file when ath12k debugfs support is enabled.
Add basic ath12k_debugfs_htt_stats_init and handle htt_stats_type
file operations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |  2 +-
 drivers/net/wireless/ath/ath12k/core.h        |  9 +++
 drivers/net/wireless/ath/ath12k/debugfs.c     |  3 +
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 74 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 20 +++++
 5 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index d42480db7463..3491b8b8a1e2 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -23,7 +23,7 @@ ath12k-y += core.o \
 	    fw.o \
 	    p2p.o
 
-ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o
+ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o
 ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bb6c1b562baf..3919bc828620 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -27,6 +27,7 @@
 #include "dbring.h"
 #include "fw.h"
 #include "acpi.h"
+#include "debugfs_htt_stats.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -473,8 +474,16 @@ struct ath12k_fw_stats {
 	struct list_head bcn;
 };
 
+struct ath12k_dbg_htt_stats {
+	enum ath12k_dbg_htt_ext_stats_type type;
+	u32 cfg_param[4];
+	/* protects shared stats req buffer */
+	spinlock_t lock;
+};
+
 struct ath12k_debug {
 	struct dentry *debugfs_pdev;
+	struct ath12k_dbg_htt_stats htt_stats;
 };
 
 struct ath12k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 8d8ba951093b..30a80f04d824 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -6,6 +6,7 @@
 
 #include "core.h"
 #include "debugfs.h"
+#include "debugfs_htt_stats.h"
 
 static ssize_t ath12k_write_simulate_radar(struct file *file,
 					   const char __user *user_buf,
@@ -87,4 +88,6 @@ void ath12k_debugfs_register(struct ath12k *ar)
 				    ar->debug.debugfs_pdev, ar,
 				    &fops_simulate_radar);
 	}
+
+	ath12k_debugfs_htt_stats_init(ar);
 }
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
new file mode 100644
index 000000000000..4a58362bdaea
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/vmalloc.h>
+#include "core.h"
+#include "debug.h"
+#include "debugfs_htt_stats.h"
+
+static ssize_t ath12k_read_htt_stats_type(struct file *file,
+					  char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	char buf[32];
+	size_t len;
+
+	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.type);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t ath12k_write_htt_stats_type(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	enum ath12k_dbg_htt_ext_stats_type type;
+	unsigned int cfg_param[4] = {0};
+	int num_args;
+
+	char *buf __free(kfree) = kzalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	num_args = sscanf(buf, "%u %u %u %u %u\n", &type, &cfg_param[0],
+			  &cfg_param[1], &cfg_param[2], &cfg_param[3]);
+	if (!num_args || num_args > 5)
+		return -EINVAL;
+
+	if (type >= ATH12K_DBG_HTT_NUM_EXT_STATS)
+		return -E2BIG;
+
+	if (type == ATH12K_DBG_HTT_EXT_STATS_RESET)
+		return -EPERM;
+
+	ar->debug.htt_stats.type = type;
+	ar->debug.htt_stats.cfg_param[0] = cfg_param[0];
+	ar->debug.htt_stats.cfg_param[1] = cfg_param[1];
+	ar->debug.htt_stats.cfg_param[2] = cfg_param[2];
+	ar->debug.htt_stats.cfg_param[3] = cfg_param[3];
+
+	return count;
+}
+
+static const struct file_operations fops_htt_stats_type = {
+	.read = ath12k_read_htt_stats_type,
+	.write = ath12k_write_htt_stats_type,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+void ath12k_debugfs_htt_stats_init(struct ath12k *ar)
+{
+	spin_lock_init(&ar->debug.htt_stats.lock);
+	debugfs_create_file("htt_stats_type", 0600, ar->debug.debugfs_pdev,
+			    ar, &fops_htt_stats_type);
+}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
new file mode 100644
index 000000000000..6bd34d72b407
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef DEBUG_HTT_STATS_H
+#define DEBUG_HTT_STATS_H
+
+void ath12k_debugfs_htt_stats_init(struct ath12k *ar);
+
+/* htt_dbg_ext_stats_type */
+enum ath12k_dbg_htt_ext_stats_type {
+	ATH12K_DBG_HTT_EXT_STATS_RESET,
+
+	/* keep this last */
+	ATH12K_DBG_HTT_NUM_EXT_STATS,
+};
+
+#endif
-- 
2.34.1


