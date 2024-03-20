Return-Path: <linux-wireless+bounces-4999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF12881640
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DF9B23A0D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2664869DF4;
	Wed, 20 Mar 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gJiPj5/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECE69DEE
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954810; cv=none; b=uNJeCqYmQcNpW5lqbaHkEkUJovrD97e7FraWJol0VW/ppgwAsmCcKzPCfENSN2BBYP68PZQ9BGj0zsvmgPEZCI8RunF4pXjwgWBhgY20sV6prf/BU5SK94DbJqyn0GYE3+7L8smn6l7vfPPP5m32z6KGrodc8XM5/a7IZhp1AgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954810; c=relaxed/simple;
	bh=YCD1EqxBKgRZ/6yl0eosNTtQ66NCr9Rh/gFGUuZDgbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/aGK3sDpXAOQ57UhFG8+0RDWvqXFKWOhsezb/JcqysSpE9adpnaFzie2savamy1mCWrc87/YZnp91DCxNqW5q6HxCHoU0I4xVHlNEsx1vtGMdcx0/U6F6iKlNh5PMKqwb4rsgEBNXZ/xQihKkuaSt5QHxXKybi7SxaK4kF04V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gJiPj5/q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjWYc026326;
	Wed, 20 Mar 2024 17:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=5T9oYVY
	vOCgxIu4vpZnQOc8fsBgOH2MERErk/9jI54Y=; b=gJiPj5/qpIozS2gRNQbWwnZ
	kSHfMT4wHnq+cdem19TIIQkvEmBjWnYxBFfL5DPayztipNtcRTrm+Sji3p5zxqZw
	FbHp/3XGES0T1K+SPCXJmHdCHiMqDyXDA2DDsI0wQ6qjOZPyTFfFJdpmLGPkQO9O
	cKxxLUhcJLGpmP+lOvIplEtaRp/5avI3Lfo6QtyyZLMjzSx2WbW6zxMi2szaavQ8
	AMBLbJnZlSH5Q4TIIYucOdczMtyO8HVY+61wR2NbEt7Ah+EiCPolC+WTn8izR6Op
	tA25ighnChc/RT35bhyfQlKQNaSgh9J+wDiy+/wRrmj2l0aE6T5eJf64h1GCjUg=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyrp79mme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42KHDL9G028211;
	Wed, 20 Mar 2024 17:13:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ww4gm7nun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KHDKN5028196;
	Wed, 20 Mar 2024 17:13:20 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 42KHDKEi028194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:13:20 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 0FAFC41111; Wed, 20 Mar 2024 22:43:20 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: Add initial debugfs support in ath12k
Date: Wed, 20 Mar 2024 22:43:04 +0530
Message-Id: <20240320171305.655288-2-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320171305.655288-1-quic_rgnanase@quicinc.com>
References: <20240320171305.655288-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tUoKEQOnGRzUQf6scYbf6uY3HbgwLFA0
X-Proofpoint-GUID: tUoKEQOnGRzUQf6scYbf6uY3HbgwLFA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200138

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

The initial debugfs infra bringup in ath12k driver and create the ath12k debugfs
and soc-specific directories in /sys/kernel/debug/

For each ath12k device, directory will be created in <bus>-<devname>
schema under ath12k root directory.

Example with one ath12k device:
/sys/kernel/debug/ath12k/pci-0000:06:00.0

ath12k
`-- pci-0000:06:00.0
    |-- mac0

To enable ath12k debugfs support (CONFIG_ATH12K_DEBUGFS=y)

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig   |  9 ++++
 drivers/net/wireless/ath/ath12k/Makefile  |  1 +
 drivers/net/wireless/ath/ath12k/core.c    |  5 ++
 drivers/net/wireless/ath/ath12k/core.h    | 10 ++++
 drivers/net/wireless/ath/ath12k/debugfs.c | 61 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h | 30 +++++++++++
 drivers/net/wireless/ath/ath12k/mac.c     |  3 ++
 7 files changed, 119 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.h

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index e135d2b1b61d..eceab9153e98 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -24,6 +24,15 @@ config ATH12K_DEBUG
 	  If unsure, say Y to make it easier to debug problems. But if
 	  you want optimal performance choose N.
 
+config ATH12K_DEBUGFS
+	bool "QTI ath12k debugfs support"
+	depends on ATH12K && MAC80211_DEBUGFS
+	help
+	  Enable ath12k debugfs support
+
+	  If unsure, say Y to make it easier to debug problems. But if
+	  you want optimal performance choose N.
+
 config ATH12K_TRACING
 	bool "ath12k tracing support"
 	depends on ATH12K && EVENT_TRACING
diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 71669f94ff75..7b8b3d7526c8 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -23,6 +23,7 @@ ath12k-y += core.o \
 	    fw.o \
 	    p2p.o
 
+ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 
 # for tracing framework to find trace.h
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 391b6fb2bd42..3ec67d831cbd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -15,6 +15,7 @@
 #include "debug.h"
 #include "hif.h"
 #include "fw.h"
+#include "debugfs.h"
 
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
@@ -628,6 +629,8 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 		return ret;
 	}
 
+	ath12k_debugfs_soc_create(ab);
+
 	ret = ath12k_hif_power_up(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to power up :%d\n", ret);
@@ -637,6 +640,7 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 	return 0;
 
 err_qmi_deinit:
+	ath12k_debugfs_soc_destroy(ab);
 	ath12k_qmi_deinit_service(ab);
 	return ret;
 }
@@ -645,6 +649,7 @@ static void ath12k_core_soc_destroy(struct ath12k_base *ab)
 {
 	ath12k_dp_free(ab);
 	ath12k_reg_free(ab);
+	ath12k_debugfs_soc_destroy(ab);
 	ath12k_qmi_deinit_service(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..ceb0451046bf 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -453,6 +453,10 @@ struct ath12k_fw_stats {
 	struct list_head bcn;
 };
 
+struct ath12k_debug {
+	struct dentry *debugfs_pdev;
+};
+
 struct ath12k_per_peer_tx_stats {
 	u32 succ_bytes;
 	u32 retry_bytes;
@@ -592,6 +596,9 @@ struct ath12k {
 	struct ath12k_per_peer_tx_stats cached_stats;
 	u32 last_ppdu_id;
 	u32 cached_ppdu_id;
+#ifdef CONFIG_ATH12K_DEBUGFS
+	struct ath12k_debug debug;
+#endif
 
 	bool dfs_block_radar_events;
 	bool monitor_conf_enabled;
@@ -782,6 +789,9 @@ struct ath12k_base {
 	/* Current DFS Regulatory */
 	enum ath12k_dfs_region dfs_region;
 	struct ath12k_soc_dp_stats soc_stats;
+#ifdef CONFIG_ATH12K_DEBUGFS
+	struct dentry *debugfs_soc;
+#endif
 
 	unsigned long dev_flags;
 	struct completion driver_recovery;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
new file mode 100644
index 000000000000..65f3c8bf3f10
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "core.h"
+#include "debugfs.h"
+
+void ath12k_debugfs_soc_create(struct ath12k_base *ab)
+{
+	bool dput_needed;
+	char soc_name[64] = { 0 };
+	struct dentry *debugfs_ath12k;
+
+	debugfs_ath12k = debugfs_lookup("ath12k", NULL);
+	if (debugfs_ath12k) {
+		/* a dentry from lookup() needs dput() after we don't use it */
+		dput_needed = true;
+	} else {
+		debugfs_ath12k = debugfs_create_dir("ath12k", NULL);
+		if (IS_ERR_OR_NULL(debugfs_ath12k))
+			return;
+		dput_needed = false;
+	}
+
+	scnprintf(soc_name, sizeof(soc_name), "%s-%s", ath12k_bus_str(ab->hif.bus),
+		  dev_name(ab->dev));
+
+	ab->debugfs_soc = debugfs_create_dir(soc_name, debugfs_ath12k);
+
+	if (dput_needed)
+		dput(debugfs_ath12k);
+}
+
+void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
+{
+	debugfs_remove_recursive(ab->debugfs_soc);
+	ab->debugfs_soc = NULL;
+	/* We are not removing ath12k directory on purpose, even if it
+	 * would be empty. This simplifies the directory handling and it's
+	 * a minor cosmetic issue to leave an empty ath12k directory to
+	 * debugfs.
+	 */
+}
+
+void ath12k_debugfs_register(struct ath12k *ar)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_hw *hw = ar->ah->hw;
+	char pdev_name[5];
+	char buf[100] = {0};
+
+	scnprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
+
+	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
+
+	/* Create a symlink under ieee80211/phy* */
+	scnprintf(buf, sizeof(buf), "../../ath12k/%pd2", ar->debug.debugfs_pdev);
+	debugfs_create_symlink("ath12k", hw->wiphy->debugfsdir, buf);
+}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
new file mode 100644
index 000000000000..a62f2a550b23
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _ATH12K_DEBUGFS_H_
+#define _ATH12K_DEBUGFS_H_
+
+#ifdef CONFIG_ATH12K_DEBUGFS
+void ath12k_debugfs_soc_create(struct ath12k_base *ab);
+void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
+void ath12k_debugfs_register(struct ath12k *ar);
+
+#else
+static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
+{
+}
+
+static inline void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
+{
+}
+
+static inline void ath12k_debugfs_register(struct ath12k *ar)
+{
+}
+
+#endif /* CONFIG_ATH12K_DEBUGFS */
+
+#endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 52a5fb8b03e9..2df966723c44 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14,6 +14,7 @@
 #include "dp_tx.h"
 #include "dp_rx.h"
 #include "peer.h"
+#include "debugfs.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -8105,6 +8106,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		goto err_unregister_hw;
 	}
 
+	ath12k_debugfs_register(ar);
+
 	return 0;
 
 err_unregister_hw:
-- 
2.17.1


