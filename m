Return-Path: <linux-wireless+bounces-4828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1887E36E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 07:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65711F21C25
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 06:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929F22325;
	Mon, 18 Mar 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fCSYvldL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA702231A
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741836; cv=none; b=ryfjP0PNk9a/pGw03h8qpcuiKJauoiLtA2aoFCB6pKm6IWgsfC/pDB7965tu2lmgM6gI1faljMoK9YGEqBccv4BZulIVdzfACAIbnbx8A7ar/7zbsEW7xT/GwXv2FUfl68m2qiIAr2pa4w/8sRJLqXiBksvmSRlMKGJb5GmyZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741836; c=relaxed/simple;
	bh=q50w2GrqmysRVPe12kGnFFJV4aNp8qg3UC9dbT3nAsY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LVeapQYOLc4MlZDdlyW924EbBK4eKhymnhoKxPZsXqdUesCM30+OwoUUe9iS4Gpzqa0Aa3yWfsG+L2RBsIKaMie5LtUk3r0wcTuWjJ9gt2v1U/uawkvGPbdEfxfkUTGJS8x/6tyxCxVXAifFTI+tbAYOXmoF0ArkNbJ/pRkajmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fCSYvldL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I5QSDM027737;
	Mon, 18 Mar 2024 06:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=TYzvRGg
	kxSfBIeQQqyIJrdZnDaAL9pTH1w615rmtkpU=; b=fCSYvldLmxBOzQxqEnETMHo
	6LTR4po6vro7bLGfOX4fij115wkmMTiZ+z3U5asWtouEyuEgasTk3XtgYFkUgO+p
	YUfrdfBRYrdM7w2jF4IkU11RDzJZipDQbBQSl84QlQbuSG+YW/NO/icfymXcxYZ4
	P+tL08kIUFAAawciFmCKuFvx0lHKpmaMbxDVLHzEzbVxTS84i69knN6JEmS+cmND
	OI5Iz1WUroTH2dTcYgPHX+OinhAkQ2F+o6+ChwCNNqCPemaiwGmf0l+xAyWZEJB7
	ihN9UY6gp79xWuuM4w41HFq7Demp0Eb/Tx6oCxFKEaHiAcoZ7QSFOVkElAw3lYA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxtb166j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 06:03:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42I63kwf004805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 06:03:47 GMT
Received: from hu-ssreeela-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Mar 2024 23:03:45 -0700
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
Subject: [PATCH] wifi: ath12k: Add firmware coredump collection support
Date: Mon, 18 Mar 2024 11:32:49 +0530
Message-ID: <20240318060249.1023837-1-quic_ssreeela@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gnyBBBaW4oVp6D9LtLlGR9HeyYTq2C5c
X-Proofpoint-ORIG-GUID: gnyBBBaW4oVp6D9LtLlGR9HeyYTq2C5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180043

In case of firmware assert snapshot of firmware memory is essential for
debugging. Add firmware coredump collection support for PCI bus.
Collect RDDM and firmware paging dumps from MHI and pack them in TLV
format and also pack various memory shared during QMI phase in separate
TLVs.  Add necessary header and share the dumps to user space using dev
coredump framework. Coredump collection is disabled by default and can
be enabled using menuconfig. Dump collected for a radio is 55MB
approximately.

Tested-on: qcn9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig    |  11 ++
 drivers/net/wireless/ath/ath12k/Makefile   |   1 +
 drivers/net/wireless/ath/ath12k/core.c     |   2 +
 drivers/net/wireless/ath/ath12k/core.h     |   4 +
 drivers/net/wireless/ath/ath12k/coredump.c |  50 ++++++
 drivers/net/wireless/ath/ath12k/coredump.h |  79 +++++++++
 drivers/net/wireless/ath/ath12k/hif.h      |   9 +-
 drivers/net/wireless/ath/ath12k/hw.c       |   4 +-
 drivers/net/wireless/ath/ath12k/mhi.c      |   6 +
 drivers/net/wireless/ath/ath12k/mhi.h      |   4 +-
 drivers/net/wireless/ath/ath12k/pci.c      | 180 +++++++++++++++++++++
 11 files changed, 345 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath12k/coredump.h

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index e135d2b1b61d..fb6416162286 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -32,3 +32,14 @@ config ATH12K_TRACING
 
 	  If unsure, say Y to make it easier to debug problems. But if
 	  you want optimal performance choose N.
+
+config ATH12K_COREDUMP
+	bool "ath12k coredump"
+	depends on ATH12K
+	select WANT_DEV_COREDUMP
+	help
+	  Enable ath12k coredump collection
+
+	  If unsure, say Y to make it easier to debug problems. But if
+	  you want optimal performance choose N.
+
diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 71669f94ff75..41c584acc582 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -24,6 +24,7 @@ ath12k-y += core.o \
 	    p2p.o
 
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
+ath12k-$(CONFIG_ATH12K_COREDUMP) += coredump.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 391b6fb2bd42..f0cc4959faf5 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1121,6 +1121,7 @@ static void ath12k_core_reset(struct work_struct *work)
 	reinit_completion(&ab->recovery_start);
 	atomic_set(&ab->recovery_count, 0);
 
+	ath12k_coredump_collect(ab);
 	ath12k_core_pre_reconfigure_recovery(ab);
 
 	reinit_completion(&ab->reconfigure_complete);
@@ -1220,6 +1221,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->restart_work, ath12k_core_restart);
 	INIT_WORK(&ab->reset_work, ath12k_core_reset);
 	INIT_WORK(&ab->rfkill_work, ath12k_rfkill_work);
+	INIT_WORK(&ab->dump_work, ath12k_coredump_upload);
 
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..be3e8e8c1933 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -26,6 +26,7 @@
 #include "reg.h"
 #include "dbring.h"
 #include "fw.h"
+#include "coredump.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -700,6 +701,9 @@ struct ath12k_base {
 	/* HW channel counters frequency value in hertz common to all MACs */
 	u32 cc_freq_hz;
 
+	struct ath12k_dump_file_data *dump_data;
+	struct work_struct dump_work;
+
 	struct ath12k_htc htc;
 
 	struct ath12k_dp dp;
diff --git a/drivers/net/wireless/ath/ath12k/coredump.c b/drivers/net/wireless/ath/ath12k/coredump.c
new file mode 100644
index 000000000000..4a846d7c66d2
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/coredump.c
@@ -0,0 +1,50 @@
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
+enum ath12k_fw_crash_dump_type ath12k_coredump_get_dump_type(enum ath12k_qmi_target_mem type)
+{
+	enum ath12k_fw_crash_dump_type dump_type;
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
+
+void ath12k_coredump_upload(struct work_struct *work)
+{
+	struct ath12k_base *ab = container_of(work, struct ath12k_base, dump_work);
+
+	ath12k_info(ab, "Uploading coredump\n");
+	/* dev_coredumpv() takes ownership of the buffer */
+	dev_coredumpv(ab->dev, ab->dump_data, ab->dump_data->len, GFP_KERNEL);
+	ab->dump_data = NULL;
+}
+
+void ath12k_coredump_collect(struct ath12k_base *ab)
+{
+	ath12k_hif_coredump_download(ab);
+}
diff --git a/drivers/net/wireless/ath/ath12k/coredump.h b/drivers/net/wireless/ath/ath12k/coredump.h
new file mode 100644
index 000000000000..1fbc69c35e58
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/coredump.h
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _ATH12K_COREDUMP_H_
+#define _ATH12K_COREDUMP_H_
+
+#define ATH12K_FW_CRASH_DUMP_V2      2
+
+enum ath12k_fw_crash_dump_type {
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
+struct ath12k_tlv_dump_data {
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
+struct ath12k_dump_file_data {
+	/* "ATH12K-FW-DUMP" */
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
+#ifdef CONFIG_ATH12K_COREDUMP
+enum ath12k_fw_crash_dump_type ath12k_coredump_get_dump_type(enum ath12k_qmi_target_mem type);
+void ath12k_coredump_upload(struct work_struct *work);
+void ath12k_coredump_collect(struct ath12k_base *ab);
+#else
+static inline enum ath12k_fw_crash_dump_type ath12k_coredump_get_dump_type
+							(enum ath12k_qmi_target_mem type)
+{
+	return FW_CRASH_DUMP_TYPE_MAX;
+}
+
+static inline void ath12k_coredump_upload(struct work_struct *work)
+{
+}
+
+static inline void ath12k_coredump_collect(struct ath12k_base *ab)
+{
+}
+#endif
+
+#endif
+
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index c653ca1f59b2..94fb8a9dbdf3 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HIF_H
@@ -30,6 +30,7 @@ struct ath12k_hif_ops {
 	void (*ce_irq_enable)(struct ath12k_base *ab);
 	void (*ce_irq_disable)(struct ath12k_base *ab);
 	void (*get_ce_msi_idx)(struct ath12k_base *ab, u32 ce_id, u32 *msi_idx);
+	void (*coredump_download)(struct ath12k_base *ab);
 };
 
 static inline int ath12k_hif_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
@@ -141,4 +142,10 @@ static inline void ath12k_hif_power_down(struct ath12k_base *ab)
 	ab->hif.ops->power_down(ab);
 }
 
+static inline void ath12k_hif_coredump_download(struct ath12k_base *ab)
+{
+	if (ab->hif.ops->coredump_download)
+		ab->hif.ops->coredump_download(ab);
+}
+
 #endif /* ATH12K_HIF_H */
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 0b17dfd47856..6be5ce39ff8f 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -912,7 +912,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_cfg = 0,
 		.rfkill_on_level = 0,
 
-		.rddm_size = 0,
+		.rddm_size = 0x600000,
 
 		.def_num_link = 0,
 		.max_mlo_peer = 256,
@@ -1053,7 +1053,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_cfg = 0,
 		.rfkill_on_level = 0,
 
-		.rddm_size = 0,
+		.rddm_size = 0x600000,
 
 		.def_num_link = 0,
 		.max_mlo_peer = 256,
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index adb8c3ec1950..9e5121bc6537 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -668,3 +668,9 @@ void ath12k_mhi_resume(struct ath12k_pci *ab_pci)
 {
 	ath12k_mhi_set_state(ab_pci, ATH12K_MHI_RESUME);
 }
+
+void ath12k_mhi_coredump(struct mhi_controller *mhi_ctrl, bool in_panic)
+{
+	mhi_download_rddm_image(mhi_ctrl, in_panic);
+}
+
diff --git a/drivers/net/wireless/ath/ath12k/mhi.h b/drivers/net/wireless/ath/ath12k/mhi.h
index ebc23640ce7a..3c9268824ca5 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.h
+++ b/drivers/net/wireless/ath/ath12k/mhi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef _ATH12K_MHI_H
 #define _ATH12K_MHI_H
@@ -42,5 +42,5 @@ void ath12k_mhi_clear_vector(struct ath12k_base *ab);
 
 void ath12k_mhi_suspend(struct ath12k_pci *ar_pci);
 void ath12k_mhi_resume(struct ath12k_pci *ar_pci);
-
+void ath12k_mhi_coredump(struct mhi_controller *mhi_ctrl, bool in_panic);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 14954bc05144..1575990a56b4 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/time.h>
 
 #include "pci.h"
 #include "core.h"
@@ -1240,6 +1241,181 @@ void ath12k_pci_write32(struct ath12k_base *ab, u32 offset, u32 value)
 		ab_pci->pci_ops->release(ab);
 }
 
+#ifdef CONFIG_ATH12K_COREDUMP
+static int ath12k_pci_coredump_calculate_size(struct ath12k_base *ab, u32 *dump_seg_sz)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+	struct mhi_controller *mhi_ctrl = ab_pci->mhi_ctrl;
+	struct image_info *rddm_img, *fw_img;
+	struct ath12k_tlv_dump_data *dump_tlv;
+	enum ath12k_fw_crash_dump_type mem_type;
+	u32 len = 0, rddm_tlv_sz = 0, paging_tlv_sz = 0;
+	struct ath12k_dump_file_data *file_data;
+	int i;
+
+	rddm_img = mhi_ctrl->rddm_image;
+	if (!rddm_img) {
+		ath12k_err(ab, "No RDDM dump found\n");
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
+		mem_type = ath12k_coredump_get_dump_type(ab->qmi.target_mem[i].type);
+
+		if (mem_type == FW_CRASH_DUMP_NONE)
+			continue;
+
+		if (mem_type == FW_CRASH_DUMP_TYPE_MAX) {
+			ath12k_dbg(ab, ATH12K_DBG_PCI, "target mem region type %d not supported",
+				   ab->qmi.target_mem[i].type);
+			continue;
+		}
+
+		if (!ab->qmi.target_mem[i].paddr)
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
+static void ath12k_pci_coredump_download(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+	struct mhi_controller *mhi_ctrl = ab_pci->mhi_ctrl;
+	struct image_info *rddm_img, *fw_img;
+	struct timespec64 timestamp;
+	int i, len, mem_idx;
+	enum ath12k_fw_crash_dump_type mem_type;
+	struct ath12k_dump_file_data *file_data;
+	struct ath12k_tlv_dump_data *dump_tlv;
+	size_t hdr_len = sizeof(*file_data);
+	void *buf;
+	u32 dump_seg_sz[FW_CRASH_DUMP_TYPE_MAX] = { 0 };
+
+	ath12k_mhi_coredump(mhi_ctrl, false);
+
+	len = ath12k_pci_coredump_calculate_size(ab, dump_seg_sz);
+	if (!len) {
+		ath12k_warn(ab, "No crash dump data found for devcoredump");
+		return;
+	}
+
+	rddm_img = mhi_ctrl->rddm_image;
+	fw_img = mhi_ctrl->fbc_image;
+
+	/* dev_coredumpv() requires vmalloc data */
+	buf = vzalloc(len);
+	if (!buf) {
+		ath12k_warn(ab, "Failed to allocate memory for coredump\n");
+		return;
+	}
+
+	ab->dump_data = buf;
+	file_data = ab->dump_data;
+	strscpy(file_data->df_magic, "ATH12K-FW-DUMP", sizeof(file_data->df_magic));
+	file_data->len = cpu_to_le32(len);
+	file_data->version = cpu_to_le32(ATH12K_FW_CRASH_DUMP_V2);
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
+		memcpy_fromio(buf, fw_img->mhi_buf[i].buf, fw_img->mhi_buf[i].len);
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
+		memcpy_fromio(buf, rddm_img->mhi_buf[i].buf, rddm_img->mhi_buf[i].len);
+		buf += rddm_img->mhi_buf[i].len;
+	}
+
+	for (mem_idx = FW_CRASH_DUMP_REMOTE_MEM_DATA; mem_idx < FW_CRASH_DUMP_TYPE_MAX; mem_idx++) {
+		if (mem_idx == FW_CRASH_DUMP_NONE)
+			continue;
+
+		dump_tlv = buf;
+		dump_tlv->type = cpu_to_le32(mem_idx);
+		dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[mem_idx]);
+		buf += COREDUMP_TLV_HDR_SIZE;
+
+		for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+			mem_type = ath12k_coredump_get_dump_type(ab->qmi.target_mem[i].type);
+
+			if (mem_type != mem_idx)
+				continue;
+
+			if (!ab->qmi.target_mem[i].paddr) {
+				ath12k_dbg(ab, ATH12K_DBG_PCI, "Skipping mem region type %d",
+					   ab->qmi.target_mem[i].type);
+				continue;
+			}
+
+			memcpy_fromio(buf, ab->qmi.target_mem[i].v.ioaddr,
+				      ab->qmi.target_mem[i].size);
+			buf += ab->qmi.target_mem[i].size;
+		}
+	}
+
+	queue_work(ab->workqueue, &ab->dump_work);
+}
+#endif
+
 int ath12k_pci_power_up(struct ath12k_base *ab)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
@@ -1302,6 +1478,9 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 	.ce_irq_enable = ath12k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath12k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath12k_pci_get_ce_msi_idx,
+#ifdef CONFIG_ATH12K_COREDUMP
+	.coredump_download = ath12k_pci_coredump_download,
+#endif
 };
 
 static
@@ -1511,6 +1690,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	set_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags);
 
 	cancel_work_sync(&ab->reset_work);
+	cancel_work_sync(&ab->dump_work);
 	ath12k_core_deinit(ab);
 
 qmi_fail:
-- 
2.34.1


