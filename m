Return-Path: <linux-wireless+bounces-10704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F331942437
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 03:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48278284C94
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5234F747F;
	Wed, 31 Jul 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WwMzJgDR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6EC8FF
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390093; cv=none; b=dnkHTLdXd4z4v5Zgt11mXSO7CL7zIhP4P9qMEMN5Vqf+rWJn09hw74sCpk0XdbFRFEmMJ+HHKikYA/vFjrtyp2yIPKElQHyO6T17wBp2nFdKIDPWwhIUixGu4G2P7tp1NntmXXo5bh9PRhKJPhwPP5AEdMzs8pZwzIN5wcSQNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390093; c=relaxed/simple;
	bh=LkcEv5bSQBrFJAzOogYzReyTgevaJlQ3MPiiSf019rI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDJiXZN5nadMe7Xi/EXxtfZK7oeyZWTP+QsXrFZ5/vWJEI1RBWb7l9qIOfsmc4fOMJJWkYKFSTQL0wE0m/7t3bJi0+imBRPwbCOJDDFRpGIUWzI332SJhtmaG7hY2DTgo6lzy5zD9B53Ltpzba408EM9zI1LhsgDzSuPtDqFGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WwMzJgDR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFgqxc030643;
	Wed, 31 Jul 2024 01:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PpQ1KDvIvUAWyuzwg3b53CwfxMXZUUGCecTiu0q4kvM=; b=WwMzJgDRWZFilWFg
	b4ova8gKCYL2NbhyXTPOVCfR/p5N3ezj66iaZznzcRKEAh4icsncJk/YenYrPxWv
	XCPvE3EosWw0MzBrZS7iqJpzafJvEUXrsdLJYuz8licMnTBeH+sbFAJw7XumNtb+
	wLvA5lWHi1u3tRJk0YArpJRjLBuLsq7HJm/AawHWPN5HRQtCJLfJWZrkTNUoLO5g
	CmplFMvRcMAS+FaDGpXbvhmt1M75HUumW2tLrhgQ0O74vKNVR2VWmKdn8pjB+wWi
	m7uelaGEIcgnQAZcZqUjBTNWrchzoK+s7VX8jnDftJPf2Yg58LRegAiaZlaV5PxX
	lB1krA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms96smjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 01:41:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46V1fLZ0007486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 01:41:21 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 18:41:16 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH v5 2/2] wifi: ath11k: Add firmware coredump collection support
Date: Wed, 31 Jul 2024 09:41:04 +0800
Message-ID: <20240731014104.798028-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731014104.798028-1-quic_miaoqing@quicinc.com>
References: <20240731014104.798028-1-quic_miaoqing@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ocmVee8bTf_jslVDeFRB-9guXWJb_Igd
X-Proofpoint-GUID: ocmVee8bTf_jslVDeFRB-9guXWJb_Igd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_21,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310010

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
v3: fix vmalloc-out-of-bounds and remove CONFIG_ATH11K_COREDUMP.
v4: put QMI changes to a separate patch. 
v5: use an anonymous union for iaddr and vaddr in target_mem_chunk.
---
 drivers/net/wireless/ath/ath11k/Makefile   |   1 +
 drivers/net/wireless/ath/ath11k/core.c     |   2 +
 drivers/net/wireless/ath/ath11k/core.h     |   5 +
 drivers/net/wireless/ath/ath11k/coredump.c |  52 ++++++
 drivers/net/wireless/ath/ath11k/coredump.h |  79 +++++++++
 drivers/net/wireless/ath/ath11k/hif.h      |   7 +
 drivers/net/wireless/ath/ath11k/mhi.c      |   5 +
 drivers/net/wireless/ath/ath11k/mhi.h      |   1 +
 drivers/net/wireless/ath/ath11k/pci.c      | 188 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.h      |   1 +
 10 files changed, 341 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 43d2d8ddcdc0..d9092414b362 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -27,6 +27,7 @@ ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 ath11k-$(CONFIG_PM) += wow.o
+ath11k-$(CONFIG_DEV_COREDUMP) += coredump.o
 
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
index 7122176dd91e..b0e55e78b5ff 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -32,6 +32,7 @@
 #include "spectral.h"
 #include "wow.h"
 #include "fw.h"
+#include "coredump.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -896,6 +897,10 @@ struct ath11k_base {
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
index 000000000000..3960d9385261
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
+#ifdef CONFIG_DEV_COREDUMP
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
index 8d63b84d1261..9a7ea6356607 100644
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
@@ -610,6 +612,187 @@ static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 						   PCI_EXP_LNKCTL_ASPMC);
 }
 
+#ifdef CONFIG_DEV_COREDUMP
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
+		if (!ab->qmi.target_mem[i].anyaddr)
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
+		for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+			mem_type = ath11k_coredump_get_dump_type
+						(ab->qmi.target_mem[i].type);
+
+			if (mem_type != mem_idx)
+				continue;
+
+			if (!ab->qmi.target_mem[i].anyaddr) {
+				ath11k_dbg(ab, ATH11K_DBG_PCI,
+					   "Skipping mem region type %d",
+					   ab->qmi.target_mem[i].type);
+				continue;
+			}
+
+			dump_tlv = buf;
+			dump_tlv->type = cpu_to_le32(mem_idx);
+			dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[mem_idx]);
+			buf += COREDUMP_TLV_HDR_SIZE;
+
+			memcpy_fromio(buf, ab->qmi.target_mem[i].iaddr,
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
@@ -713,6 +896,9 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+#ifdef CONFIG_DEV_COREDUMP
+	.coredump_download = ath11k_pci_coredump_download,
+#endif
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
@@ -978,6 +1164,8 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 
+	cancel_work_sync(&ab->reset_work);
+	cancel_work_sync(&ab->dump_work);
 	ath11k_core_deinit(ab);
 
 qmi_fail:
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index fdf9b5f8c19f..7968ab122b65 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -157,6 +157,7 @@ struct ath11k_qmi {
 #define BDF_MEM_REGION_TYPE				0x2
 #define M3_DUMP_REGION_TYPE				0x3
 #define CALDB_MEM_REGION_TYPE				0x4
+#define PAGEABLE_MEM_REGION_TYPE			0x9
 
 struct qmi_wlanfw_host_cap_req_msg_v01 {
 	u8 num_clients_valid;
-- 
2.25.1


