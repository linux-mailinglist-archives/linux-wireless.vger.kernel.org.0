Return-Path: <linux-wireless+bounces-8507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF95E8FC24E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 05:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A87283DE9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 03:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAB637;
	Wed,  5 Jun 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvjA+xis"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FF7345E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559237; cv=none; b=O5Yv/9O3yQiztbTRYpsTOjZsYo8VPVWn2REjnemH1cwXG8E2E6LiCKSO+z9otkBAu/IXalI7Qyk0B8l4f4Apg/ErstoiDdJMrfX/W3Zo5rbkjyN6g6CpYEJBlUNa1CcFyd5qmzXq0qD+K690QkAm1bPEWDfLtkuyxT0cqQ8JcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559237; c=relaxed/simple;
	bh=pOsxQNS+tLMHBOcOG1vM5GFLkIT15mncwaQGCp1eiYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y8Kcxuc1cI6fKZQ2IyltfK9Nd8RCzU+q7QJaxXwRT9Yd1K0hx9d/48Y9Bg5d4vz8NnBwhb53Ciz0onvNgxn6rpq/tu1kdmFnWxuNcChkCwvXmEDcy0Ta6Fkfhns3UmO9+fq/aZ4xbPm5HxC9uo0CjhRHhj7wARl+NpYbqfRvX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pvjA+xis; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454IIAuL006633;
	Wed, 5 Jun 2024 03:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mRe6qDwQUyb6ARzWiaWLFM
	k2YpHxaI5n5AhOXxygJpc=; b=pvjA+xishnHwtRGzOMCxJI7/QJfVWvCVtlcsqS
	SxaKpWeUyx8QYEqAwhdKbRbuMuM5yBbo/QhAJ66YBf8vB618qQPV1gOGB64Wvzoc
	jp3xX4b9+5z7fQkAkkI6A4ggH9gsk7a9qE4+X+4Yt1ioEOA7mIC7vT5vkmXulefq
	+JN2S/mWQYFaK5bMu41+WD9nEnAslwiFiknpOigrA/ibdPiTWy5378Nu3Dfyx2Eh
	93UzaJ4XJjruORsfhqKrQ/m/v1PkiqkF5Ptkj+1urJKRleYbH8eTyiMWz9Sn4sYM
	S6Evzb6R+CP+EhkQ0wZWE2lEOHqetzV6r9L1sVSZsk1RlTrw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj8300x8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 03:47:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4553kx1v030413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 03:46:59 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Jun 2024 20:46:57 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH v2] wifi: ath11k: Add firmware coredump collection support
Date: Wed, 5 Jun 2024 11:46:39 +0800
Message-ID: <20240605034639.3942219-1-quic_miaoqing@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hlgSpu3XyJkeWfudk6JjTWORodA8jPj7
X-Proofpoint-ORIG-GUID: hlgSpu3XyJkeWfudk6JjTWORodA8jPj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406050028

In case of firmware assert snapshot of firmware memory is essential for
debugging. Add firmware coredump collection support for PCI bus.
Collect RDDM and firmware paging dumps from MHI and pack them in TLV
format and also pack various memory shared during QMI phase in separate
TLVs.  Add necessary header and share the dumps to user space using dev
coredump framework. Coredump collection is disabled by default and can
be enabled using menuconfig. Dump collected for a radio is 55 MB
approximately.

The changeset is mostly copied from:
https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
v2: fix implicit declaration of function 'vzalloc'.

 drivers/net/wireless/ath/ath11k/Kconfig    |  11 ++
 drivers/net/wireless/ath/ath11k/Makefile   |   1 +
 drivers/net/wireless/ath/ath11k/core.c     |   2 +
 drivers/net/wireless/ath/ath11k/core.h     |   5 +
 drivers/net/wireless/ath/ath11k/coredump.c |  52 ++++++
 drivers/net/wireless/ath/ath11k/coredump.h |  79 +++++++++
 drivers/net/wireless/ath/ath11k/hif.h      |   7 +
 drivers/net/wireless/ath/ath11k/mhi.c      |   5 +
 drivers/net/wireless/ath/ath11k/mhi.h      |   1 +
 drivers/net/wireless/ath/ath11k/pci.c      | 191 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.c      |  45 ++---
 drivers/net/wireless/ath/ath11k/qmi.h      |   9 +-
 12 files changed, 384 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 27f0523bf967..bb91da0098b4 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -57,3 +57,14 @@ config ATH11K_SPECTRAL
 	  Enable ath11k spectral scan support
 
 	  Say Y to enable access to the FFT/spectral data via debugfs.
+
+config ATH11K_COREDUMP
+	bool "ath11k coredump"
+	depends on ATH11K
+	select WANT_DEV_COREDUMP
+	help
+	  Enable ath11k coredump collection
+
+	  If unsure, say Y to make it easier to debug problems. But if
+	  dump collection not required choose N.
+
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 43d2d8ddcdc0..685341dd28fa 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -27,6 +27,7 @@ ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 ath11k-$(CONFIG_PM) += wow.o
+ath11k-$(CONFIG_ATH11K_COREDUMP) += coredump.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 03187df26000..56a7195bddef 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2177,6 +2177,7 @@ static void ath11k_core_reset(struct work_struct *work)
 	reinit_completion(&ab->recovery_start);
 	atomic_set(&ab->recovery_start_count, 0);
 
+	ath11k_coredump_collect(ab);
 	ath11k_core_pre_reconfigure_recovery(ab);
 
 	reinit_completion(&ab->reconfigure_complete);
@@ -2313,6 +2314,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	INIT_WORK(&ab->update_11d_work, ath11k_update_11d);
 	INIT_WORK(&ab->reset_work, ath11k_core_reset);
+	INIT_WORK(&ab->dump_work, ath11k_coredump_upload);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 205f40ee6b66..978ec9bdf868 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -32,6 +32,7 @@
 #include "spectral.h"
 #include "wow.h"
 #include "fw.h"
+#include "coredump.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -892,6 +893,10 @@ struct ath11k_base {
 	/* HW channel counters frequency value in hertz common to all MACs */
 	u32 cc_freq_hz;
 
+	struct ath11k_dump_file_data *dump_data;
+	size_t ath11k_coredump_len;
+	struct work_struct dump_work;
+
 	struct ath11k_htc htc;
 
 	struct ath11k_dp dp;
diff --git a/drivers/net/wireless/ath/ath11k/coredump.c b/drivers/net/wireless/ath/ath11k/coredump.c
new file mode 100644
index 000000000000..b8bad358cebe
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/coredump.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/devcoredump.h>
+#include "hif.h"
+#include "coredump.h"
+#include "debug.h"
+
+enum
+ath11k_fw_crash_dump_type ath11k_coredump_get_dump_type(int type)
+{
+	enum ath11k_fw_crash_dump_type dump_type;
+
+	switch (type) {
+	case HOST_DDR_REGION_TYPE:
+		dump_type = FW_CRASH_DUMP_REMOTE_MEM_DATA;
+		break;
+	case M3_DUMP_REGION_TYPE:
+		dump_type = FW_CRASH_DUMP_M3_DUMP;
+		break;
+	case PAGEABLE_MEM_REGION_TYPE:
+		dump_type = FW_CRASH_DUMP_PAGEABLE_DATA;
+		break;
+	case BDF_MEM_REGION_TYPE:
+	case CALDB_MEM_REGION_TYPE:
+		dump_type = FW_CRASH_DUMP_NONE;
+		break;
+	default:
+		dump_type = FW_CRASH_DUMP_TYPE_MAX;
+		break;
+	}
+
+	return dump_type;
+}
+EXPORT_SYMBOL(ath11k_coredump_get_dump_type);
+
+void ath11k_coredump_upload(struct work_struct *work)
+{
+	struct ath11k_base *ab = container_of(work, struct ath11k_base, dump_work);
+
+	ath11k_info(ab, "Uploading coredump\n");
+	/* dev_coredumpv() takes ownership of the buffer */
+	dev_coredumpv(ab->dev, ab->dump_data, ab->ath11k_coredump_len, GFP_KERNEL);
+	ab->dump_data = NULL;
+}
+
+void ath11k_coredump_collect(struct ath11k_base *ab)
+{
+	ath11k_hif_coredump_download(ab);
+}
diff --git a/drivers/net/wireless/ath/ath11k/coredump.h b/drivers/net/wireless/ath/ath11k/coredump.h
new file mode 100644
index 000000000000..b9ea5e4de939
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/coredump.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _ATH11K_COREDUMP_H_
+#define _ATH11K_COREDUMP_H_
+
+#define ATH11K_FW_CRASH_DUMP_V2      2
+
+enum ath11k_fw_crash_dump_type {
+	FW_CRASH_DUMP_PAGING_DATA,
+	FW_CRASH_DUMP_RDDM_DATA,
+	FW_CRASH_DUMP_REMOTE_MEM_DATA,
+	FW_CRASH_DUMP_PAGEABLE_DATA,
+	FW_CRASH_DUMP_M3_DUMP,
+	FW_CRASH_DUMP_NONE,
+
+	/* keep last */
+	FW_CRASH_DUMP_TYPE_MAX,
+};
+
+#define COREDUMP_TLV_HDR_SIZE 8
+
+struct ath11k_tlv_dump_data {
+	/* see ath11k_fw_crash_dump_type above */
+	__le32 type;
+
+	/* in bytes */
+	__le32 tlv_len;
+
+	/* pad to 32-bit boundaries as needed */
+	u8 tlv_data[];
+} __packed;
+
+struct ath11k_dump_file_data {
+	/* "ATH11K-FW-DUMP" */
+	char df_magic[16];
+	/* total dump len in bytes */
+	__le32 len;
+	/* file dump version */
+	__le32 version;
+	/* pci device id */
+	__le32 chip_id;
+	/* qrtr instance id */
+	__le32 qrtr_id;
+	/* pci domain id */
+	__le32 bus_id;
+	guid_t guid;
+	/* time-of-day stamp */
+	__le64 tv_sec;
+	/* time-of-day stamp, nano-seconds */
+	__le64 tv_nsec;
+	/* room for growth w/out changing binary format */
+	u8 unused[128];
+	u8 data[];
+} __packed;
+
+#ifdef CONFIG_ATH11K_COREDUMP
+enum ath11k_fw_crash_dump_type ath11k_coredump_get_dump_type(int type);
+void ath11k_coredump_upload(struct work_struct *work);
+void ath11k_coredump_collect(struct ath11k_base *ab);
+#else
+static inline enum
+ath11k_fw_crash_dump_type ath11k_coredump_get_dump_type(int type)
+{
+	return FW_CRASH_DUMP_TYPE_MAX;
+}
+
+static inline void ath11k_coredump_upload(struct work_struct *work)
+{
+}
+
+static inline void ath11k_coredump_collect(struct ath11k_base *ab)
+{
+}
+#endif
+
+#endif
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index c4c6cc09c7c1..762db7c95ad8 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -31,6 +31,7 @@ struct ath11k_hif_ops {
 	void (*ce_irq_enable)(struct ath11k_base *ab);
 	void (*ce_irq_disable)(struct ath11k_base *ab);
 	void (*get_ce_msi_idx)(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
+	void (*coredump_download)(struct ath11k_base *ab);
 };
 
 static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
@@ -152,4 +153,10 @@ static inline void ath11k_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
 		*msi_data_idx = ce_id;
 }
 
+static inline void ath11k_hif_coredump_download(struct ath11k_base *ab)
+{
+	if (ab->hif.ops->coredump_download)
+		ab->hif.ops->coredump_download(ab);
+}
+
 #endif /* _HIF_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index ab182690aed3..db23a82a0c0f 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -498,3 +498,8 @@ int ath11k_mhi_resume(struct ath11k_pci *ab_pci)
 
 	return 0;
 }
+
+void ath11k_mhi_coredump(struct mhi_controller *mhi_ctrl, bool in_panic)
+{
+	mhi_download_rddm_image(mhi_ctrl, in_panic);
+}
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index 2d567705e732..4a7e20da3c7d 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -26,4 +26,5 @@ void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 
 int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
 int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
+void ath11k_mhi_coredump(struct mhi_controller *mhi_ctrl, bool in_panic);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 8d63b84d1261..088669c59697 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -8,6 +8,8 @@
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/of.h>
+#include <linux/time.h>
+#include <linux/vmalloc.h>
 
 #include "pci.h"
 #include "core.h"
@@ -610,6 +612,190 @@ static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 						   PCI_EXP_LNKCTL_ASPMC);
 }
 
+#ifdef CONFIG_ATH11K_COREDUMP
+static int ath11k_pci_coredump_calculate_size(struct ath11k_base *ab, u32 *dump_seg_sz)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	struct mhi_controller *mhi_ctrl = ab_pci->mhi_ctrl;
+	struct image_info *rddm_img, *fw_img;
+	struct ath11k_tlv_dump_data *dump_tlv;
+	enum ath11k_fw_crash_dump_type mem_type;
+	u32 len = 0, rddm_tlv_sz = 0, paging_tlv_sz = 0;
+	struct ath11k_dump_file_data *file_data;
+	int i;
+
+	rddm_img = mhi_ctrl->rddm_image;
+	if (!rddm_img) {
+		ath11k_err(ab, "No RDDM dump found\n");
+		return 0;
+	}
+
+	fw_img = mhi_ctrl->fbc_image;
+
+	for (i = 0; i < fw_img->entries ; i++) {
+		if (!fw_img->mhi_buf[i].buf)
+			continue;
+
+		paging_tlv_sz += fw_img->mhi_buf[i].len;
+	}
+	dump_seg_sz[FW_CRASH_DUMP_PAGING_DATA] = paging_tlv_sz;
+
+	for (i = 0; i < rddm_img->entries; i++) {
+		if (!rddm_img->mhi_buf[i].buf)
+			continue;
+
+		rddm_tlv_sz += rddm_img->mhi_buf[i].len;
+	}
+	dump_seg_sz[FW_CRASH_DUMP_RDDM_DATA] = rddm_tlv_sz;
+
+	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+		mem_type = ath11k_coredump_get_dump_type(ab->qmi.target_mem[i].type);
+
+		if (mem_type == FW_CRASH_DUMP_NONE)
+			continue;
+
+		if (mem_type == FW_CRASH_DUMP_TYPE_MAX) {
+			ath11k_dbg(ab, ATH11K_DBG_PCI,
+				   "target mem region type %d not supported",
+				   ab->qmi.target_mem[i].type);
+			continue;
+		}
+
+		if (!ab->qmi.target_mem[i].v.iaddr)
+			continue;
+
+		dump_seg_sz[mem_type] += ab->qmi.target_mem[i].size;
+	}
+
+	for (i = 0; i < FW_CRASH_DUMP_TYPE_MAX; i++) {
+		if (!dump_seg_sz[i])
+			continue;
+
+		len += sizeof(*dump_tlv) + dump_seg_sz[i];
+	}
+
+	if (len)
+		len += sizeof(*file_data);
+
+	return len;
+}
+
+static void ath11k_pci_coredump_download(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	struct mhi_controller *mhi_ctrl = ab_pci->mhi_ctrl;
+	struct image_info *rddm_img, *fw_img;
+	struct timespec64 timestamp;
+	int i, len, mem_idx;
+	enum ath11k_fw_crash_dump_type mem_type;
+	struct ath11k_dump_file_data *file_data;
+	struct ath11k_tlv_dump_data *dump_tlv;
+	size_t hdr_len = sizeof(*file_data);
+	void *buf;
+	u32 dump_seg_sz[FW_CRASH_DUMP_TYPE_MAX] = { 0 };
+
+	ath11k_mhi_coredump(mhi_ctrl, false);
+
+	len = ath11k_pci_coredump_calculate_size(ab, dump_seg_sz);
+	if (!len) {
+		ath11k_warn(ab, "No crash dump data found for devcoredump");
+		return;
+	}
+
+	rddm_img = mhi_ctrl->rddm_image;
+	fw_img = mhi_ctrl->fbc_image;
+
+	/* dev_coredumpv() requires vmalloc data */
+	buf = vzalloc(len);
+	if (!buf)
+		return;
+
+	ab->dump_data = buf;
+	ab->ath11k_coredump_len = len;
+	file_data = ab->dump_data;
+	strscpy(file_data->df_magic, "ATH11K-FW-DUMP", sizeof(file_data->df_magic));
+	file_data->len = cpu_to_le32(len);
+	file_data->version = cpu_to_le32(ATH11K_FW_CRASH_DUMP_V2);
+	file_data->chip_id = cpu_to_le32(ab_pci->dev_id);
+	file_data->qrtr_id = cpu_to_le32(ab_pci->ab->qmi.service_ins_id);
+	file_data->bus_id = cpu_to_le32(pci_domain_nr(ab_pci->pdev->bus));
+	guid_gen(&file_data->guid);
+	ktime_get_real_ts64(&timestamp);
+	file_data->tv_sec = cpu_to_le64(timestamp.tv_sec);
+	file_data->tv_nsec = cpu_to_le64(timestamp.tv_nsec);
+	buf += hdr_len;
+	dump_tlv = buf;
+	dump_tlv->type = cpu_to_le32(FW_CRASH_DUMP_PAGING_DATA);
+	dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[FW_CRASH_DUMP_PAGING_DATA]);
+	buf += COREDUMP_TLV_HDR_SIZE;
+
+	/* append all segments together as they are all part of a single contiguous
+	 * block of memory
+	 */
+	for (i = 0; i < fw_img->entries ; i++) {
+		if (!fw_img->mhi_buf[i].buf)
+			continue;
+
+		memcpy_fromio(buf, (void const __iomem *)fw_img->mhi_buf[i].buf,
+			      fw_img->mhi_buf[i].len);
+		buf += fw_img->mhi_buf[i].len;
+	}
+
+	dump_tlv = buf;
+	dump_tlv->type = cpu_to_le32(FW_CRASH_DUMP_RDDM_DATA);
+	dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[FW_CRASH_DUMP_RDDM_DATA]);
+	buf += COREDUMP_TLV_HDR_SIZE;
+
+	/* append all segments together as they are all part of a single contiguous
+	 * block of memory
+	 */
+	for (i = 0; i < rddm_img->entries; i++) {
+		if (!rddm_img->mhi_buf[i].buf)
+			continue;
+
+		memcpy_fromio(buf, (void const __iomem *)rddm_img->mhi_buf[i].buf,
+			      rddm_img->mhi_buf[i].len);
+		buf += rddm_img->mhi_buf[i].len;
+	}
+
+	mem_idx = FW_CRASH_DUMP_REMOTE_MEM_DATA;
+	for (; mem_idx < FW_CRASH_DUMP_TYPE_MAX; mem_idx++) {
+		if (mem_idx == FW_CRASH_DUMP_NONE)
+			continue;
+
+		dump_tlv = buf;
+		dump_tlv->type = cpu_to_le32(mem_idx);
+		dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[mem_idx]);
+		buf += COREDUMP_TLV_HDR_SIZE;
+
+		if (!dump_tlv->tlv_len)
+			continue;
+
+		for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+			mem_type = ath11k_coredump_get_dump_type
+						(ab->qmi.target_mem[i].type);
+
+			if (mem_type != mem_idx)
+				continue;
+
+			if (!ab->qmi.target_mem[i].v.iaddr) {
+				ath11k_dbg(ab, ATH11K_DBG_PCI,
+					   "Skipping mem region type %d",
+					   ab->qmi.target_mem[i].type);
+				continue;
+			}
+
+			memcpy_fromio(buf, ab->qmi.target_mem[i].v.iaddr,
+				      ab->qmi.target_mem[i].size);
+
+			buf += ab->qmi.target_mem[i].size;
+		}
+	}
+
+	queue_work(ab->workqueue, &ab->dump_work);
+}
+#endif
+
 static int ath11k_pci_power_up(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
@@ -713,6 +899,9 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+#ifdef CONFIG_ATH11K_COREDUMP
+	.coredump_download = ath11k_pci_coredump_download,
+#endif
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
@@ -978,6 +1167,8 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 
+	cancel_work_sync(&ab->reset_work);
+	cancel_work_sync(&ab->dump_work);
 	ath11k_core_deinit(ab);
 
 qmi_fail:
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index aa160e6fe24f..37619ba8502e 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1955,19 +1955,21 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
-		if ((ab->hw_params.fixed_mem_region ||
-		     test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
-		     ab->qmi.target_mem[i].iaddr)
-			iounmap(ab->qmi.target_mem[i].iaddr);
+		if (!ab->qmi.target_mem[i].v.iaddr)
+			continue;
 
-		if (!ab->qmi.target_mem[i].vaddr)
+		if (ab->hw_params.fixed_mem_region ||
+		    test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) {
+			iounmap(ab->qmi.target_mem[i].v.iaddr);
+			ab->qmi.target_mem[i].v.iaddr = NULL;
 			continue;
+		}
 
 		dma_free_coherent(ab->dev,
 				  ab->qmi.target_mem[i].prev_size,
-				  ab->qmi.target_mem[i].vaddr,
+				  ab->qmi.target_mem[i].v.vaddr,
 				  ab->qmi.target_mem[i].paddr);
-		ab->qmi.target_mem[i].vaddr = NULL;
+		ab->qmi.target_mem[i].v.vaddr = NULL;
 	}
 }
 
@@ -1984,22 +1986,22 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 		/* Firmware reloads in coldboot/firmware recovery.
 		 * in such case, no need to allocate memory for FW again.
 		 */
-		if (chunk->vaddr) {
+		if (chunk->v.vaddr) {
 			if (chunk->prev_type == chunk->type &&
 			    chunk->prev_size == chunk->size)
 				continue;
 
 			/* cannot reuse the existing chunk */
 			dma_free_coherent(ab->dev, chunk->prev_size,
-					  chunk->vaddr, chunk->paddr);
-			chunk->vaddr = NULL;
+					  chunk->v.vaddr, chunk->paddr);
+			chunk->v.vaddr = NULL;
 		}
 
-		chunk->vaddr = dma_alloc_coherent(ab->dev,
-						  chunk->size,
-						  &chunk->paddr,
-						  GFP_KERNEL | __GFP_NOWARN);
-		if (!chunk->vaddr) {
+		chunk->v.vaddr = dma_alloc_coherent(ab->dev,
+						    chunk->size,
+						    &chunk->paddr,
+						    GFP_KERNEL | __GFP_NOWARN);
+		if (!chunk->v.vaddr) {
 			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
 					   "dma allocation failed (%d B type %u), will try later with small size\n",
@@ -2055,10 +2057,10 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			ab->qmi.target_mem[idx].paddr = res.start;
-			ab->qmi.target_mem[idx].iaddr =
+			ab->qmi.target_mem[idx].v.iaddr =
 				ioremap(ab->qmi.target_mem[idx].paddr,
 					ab->qmi.target_mem[i].size);
-			if (!ab->qmi.target_mem[idx].iaddr)
+			if (!ab->qmi.target_mem[idx].v.iaddr)
 				return -EIO;
 
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
@@ -2068,7 +2070,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			break;
 		case BDF_MEM_REGION_TYPE:
 			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
-			ab->qmi.target_mem[idx].vaddr = NULL;
+			ab->qmi.target_mem[idx].v.vaddr = NULL;
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
 			idx++;
@@ -2083,18 +2085,19 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 				if (hremote_node) {
 					ab->qmi.target_mem[idx].paddr =
 							res.start + host_ddr_sz;
-					ab->qmi.target_mem[idx].iaddr =
+					ab->qmi.target_mem[idx].v.iaddr =
 						ioremap(ab->qmi.target_mem[idx].paddr,
 							ab->qmi.target_mem[i].size);
-					if (!ab->qmi.target_mem[idx].iaddr)
+					if (!ab->qmi.target_mem[idx].v.iaddr)
 						return -EIO;
 				} else {
 					ab->qmi.target_mem[idx].paddr =
 						ATH11K_QMI_CALDB_ADDRESS;
+					ab->qmi.target_mem[idx].v.vaddr = NULL;
 				}
 			} else {
 				ab->qmi.target_mem[idx].paddr = 0;
-				ab->qmi.target_mem[idx].vaddr = NULL;
+				ab->qmi.target_mem[idx].v.vaddr = NULL;
 			}
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 7e06d100af57..016e04f9e898 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_QMI_H
@@ -102,8 +102,10 @@ struct target_mem_chunk {
 	u32 prev_size;
 	u32 prev_type;
 	dma_addr_t paddr;
-	u32 *vaddr;
-	void __iomem *iaddr;
+	union {
+		u32 *vaddr;
+		void __iomem *iaddr;
+	} v;
 };
 
 struct target_info {
@@ -154,6 +156,7 @@ struct ath11k_qmi {
 #define BDF_MEM_REGION_TYPE				0x2
 #define M3_DUMP_REGION_TYPE				0x3
 #define CALDB_MEM_REGION_TYPE				0x4
+#define PAGEABLE_MEM_REGION_TYPE			0x9
 
 struct qmi_wlanfw_host_cap_req_msg_v01 {
 	u8 num_clients_valid;
-- 
2.25.1


