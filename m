Return-Path: <linux-wireless+bounces-8994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE39083AD
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDDEB21279
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 06:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45C145A05;
	Fri, 14 Jun 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Alme2/fw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D219D894
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346860; cv=none; b=TiK73aEIpdh/GxEwcVWyZPgJpyhDF6nfqoxbIFz1vX5XVcmi5wdbL4erzjFRClK7WxKrVUVLuh3DIo6cTJJ/a1uJeoHLAh0ChWMWJnKfO0cRqwsHptlnhiVT8ct5zjt0i6c3oAAHQe0TI352tWI9ZS/U6FS7T/QFjpvafbc4Kjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346860; c=relaxed/simple;
	bh=dOxYdfoKJyzt/r0SmB6+GVc3IhmX1SEEOjZW66KxXNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrxM52ZF39RDwle/RsRDMxo4v6u4pWDM6AdNR34nZyX/oK4oukx87EqyEEuyr5D1P8cA8UtbZmHrsYMKch9SflUSjlOpT9pdhdBlyvrz0uB7VdxvLhAvglhx0NgqljH9MEuwf/K1TZtAU3xJQgZDR8HCfm5AVqp12Jg58dQYKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Alme2/fw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGKmB009894;
	Fri, 14 Jun 2024 06:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aCVkwJh2i6m
	iitBf7doUB6YjDi2pto4A3D3q6YQZCwA=; b=Alme2/fwh06cnED6c+qaKlOx19u
	K8/B58ufny5uZt848v4OoM4iBqp3UDNJQ36sT8hSj1vOBjvYLhkrcS/o4bUQz0aj
	tQB4jJy9HMEvR2sX8ac6a0b8odrbzO/qPOlx+XuY3oKfXV3klLzjQZ1mRNwN7/9P
	V0zYwCwr8RKPRFO+E3xaICoSei+/qCDXnaTrsS3o8OqwFqIyBGV5sXx4gGDwtVwU
	JrYgN9yv4hJwtXoH70FNK2aQUZQMDh7MMID1gkTKXFgL5kgeXBsXtowDtopfV49Y
	9V77i+eE+R4FnIG7N6KQHCveuT7vU+fe0c4NTZHGVvcPJPmdrD2WgtAzKMg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q3h669-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45E6YBMJ026766;
	Fri, 14 Jun 2024 06:34:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yn1s6n07b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:11 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45E6YBZG026761;
	Fri, 14 Jun 2024 06:34:11 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45E6YBPu026759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:11 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 577AA41133; Fri, 14 Jun 2024 12:04:10 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v5 1/4] wifi: ath12k: Add support to enable debugfs_htt_stats
Date: Fri, 14 Jun 2024 12:04:01 +0530
Message-Id: <20240614063404.2659089-2-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
References: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: _u5bO5n6ZYFT3zseAF66xlmcRi9CmFuP
X-Proofpoint-ORIG-GUID: _u5bO5n6ZYFT3zseAF66xlmcRi9CmFuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140043

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Create debugfs_htt_stats file when ath12k debugfs support is enabled.
Add basic ath12k_debugfs_htt_stats_register and handle htt_stats_type
file operations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |  2 +-
 drivers/net/wireless/ath/ath12k/core.h        |  7 ++
 drivers/net/wireless/ath/ath12k/debugfs.c     |  3 +
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 83 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 20 +++++
 5 files changed, 114 insertions(+), 1 deletion(-)
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
index b483899ca136..b56088043a43 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -28,6 +28,7 @@
 #include "dbring.h"
 #include "fw.h"
 #include "acpi.h"
+#include "debugfs_htt_stats.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -472,9 +473,15 @@ struct ath12k_fw_stats {
 	struct list_head bcn;
 };
 
+struct ath12k_dbg_htt_stats {
+	enum ath12k_dbg_htt_ext_stats_type type;
+	u32 cfg_param[4];
+};
+
 struct ath12k_debug {
 	struct dentry *debugfs_pdev;
 	struct dentry *debugfs_pdev_symlink;
+	struct ath12k_dbg_htt_stats htt_stats;
 };
 
 struct ath12k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 751a9b04386a..2a977c36af00 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -6,6 +6,7 @@
 
 #include "core.h"
 #include "debugfs.h"
+#include "debugfs_htt_stats.h"
 
 static ssize_t ath12k_write_simulate_radar(struct file *file,
 					   const char __user *user_buf,
@@ -89,6 +90,8 @@ void ath12k_debugfs_register(struct ath12k *ar)
 				    ar->debug.debugfs_pdev, ar,
 				    &fops_simulate_radar);
 	}
+
+	ath12k_debugfs_htt_stats_register(ar);
 }
 
 void ath12k_debugfs_unregister(struct ath12k *ar)
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
new file mode 100644
index 000000000000..3124ea345459
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -0,0 +1,83 @@
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
+	enum ath12k_dbg_htt_ext_stats_type type;
+	char buf[32];
+	size_t len;
+
+	mutex_lock(&ar->conf_mutex);
+	type = ar->debug.htt_stats.type;
+	mutex_unlock(&ar->conf_mutex);
+
+	len = scnprintf(buf, sizeof(buf), "%u\n", type);
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
+	const int size = 32;
+	int num_args;
+
+	char *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
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
+	mutex_lock(&ar->conf_mutex);
+
+	ar->debug.htt_stats.type = type;
+	ar->debug.htt_stats.cfg_param[0] = cfg_param[0];
+	ar->debug.htt_stats.cfg_param[1] = cfg_param[1];
+	ar->debug.htt_stats.cfg_param[2] = cfg_param[2];
+	ar->debug.htt_stats.cfg_param[3] = cfg_param[3];
+
+	mutex_unlock(&ar->conf_mutex);
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
+void ath12k_debugfs_htt_stats_register(struct ath12k *ar)
+{
+	debugfs_create_file("htt_stats_type", 0600, ar->debug.debugfs_pdev,
+			    ar, &fops_htt_stats_type);
+}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
new file mode 100644
index 000000000000..8610db89289a
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
+void ath12k_debugfs_htt_stats_register(struct ath12k *ar);
+
+/* htt_dbg_ext_stats_type */
+enum ath12k_dbg_htt_ext_stats_type {
+	ATH12K_DBG_HTT_EXT_STATS_RESET		= 0,
+
+	/* keep this last */
+	ATH12K_DBG_HTT_NUM_EXT_STATS,
+};
+
+#endif
-- 
2.34.1


