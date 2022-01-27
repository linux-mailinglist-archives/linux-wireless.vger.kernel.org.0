Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224E349DA41
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiA0FeC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:34:02 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2556 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236295AbiA0FeA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261640; x=1674797640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=C9hybfjz3O5SrsNPjxfvX3x7M20YzPYpPTsIwWwHwLQ=;
  b=Agh0k5NqoIcoKScBYBc4JG0TeYY1oD9v/i3Y2DIG5aMYSDaCiOIja7vM
   9oPwzrmY7elpym+iVg6xbBpNGMcIL+z67qssKuT5WSDo3QSLVerupReaI
   Jv7M2wxMMDUfjSyEMiBCvlPR+IRbDmdsD6VLwW/DwrSyOUmd7FyRP9CKo
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 21:34:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:34:00 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:34:00 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:57 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH RFC 8/8] ath11k: Add Coredump support of MSA region for WCN6750
Date:   Thu, 27 Jan 2022 11:03:29 +0530
Message-ID: <1643261609-13500-9-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the context of WCN6750, MSA is a 12MB reserved memory region
entirely used by WCN6750 firmware for it's operation. This memory
carries useful information required to debug firmware/hardware
issues. Therefore add coredump support to dump MSA region during
FW assert for WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig    |  1 +
 drivers/net/wireless/ath/ath11k/Makefile   |  1 +
 drivers/net/wireless/ath/ath11k/ahb.c      | 85 ++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h      |  8 ++-
 drivers/net/wireless/ath/ath11k/coredump.c | 87 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/coredump.h | 71 ++++++++++++++++++++++++
 6 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index ad5cc6c..96074f5 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -5,6 +5,7 @@ config ATH11K
 	depends on CRYPTO_MICHAEL_MIC
 	select ATH_COMMON
 	select QCOM_QMI_HELPERS
+	select WANT_DEV_COREDUMP
 	help
 	  This module adds support for Qualcomm Technologies 802.11ax family of
 	  chipsets.
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index e3ea6a2..ec3c394 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -24,6 +24,7 @@ ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
+ath11k-$(CONFIG_DEV_COREDUMP) += coredump.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o pci_cmn.o
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index fd3bb43..83b1da8 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -15,7 +15,9 @@
 #include "debug.h"
 #include "hif.h"
 #include <linux/remoteproc.h>
+#include <linux/remoteproc/qcom_rproc.h>
 #include "pci_cmn.h"
+#include "coredump.h"
 
 static const struct of_device_id ath11k_ahb_of_match[] = {
 	/* TODO: Should we change the compatible string to something similar
@@ -777,6 +779,74 @@ static int ath11k_ahb_setup_resources(struct ath11k_base *ab)
 	return 0;
 }
 
+static void ath11k_ahb_coredump_msa(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	struct ath11k_msa_dump msa_data;
+
+	msa_data.paddr = ab_ahb->fw.msa_paddr;
+	msa_data.vaddr = ab_ahb->fw.msa_vaddr;
+	msa_data.size = ab_ahb->fw.msa_size;
+
+	ath11k_coredump_msa(ab, &msa_data);
+}
+
+static int ath11k_ahb_ssr_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct ath11k_ahb *ab_ahb = container_of(nb, struct ath11k_ahb, nb);
+	struct ath11k_base *ab = ab_ahb->ab;
+	struct qcom_ssr_notify_data *notify_data = data;
+
+	switch (action) {
+	case QCOM_SSR_BEFORE_POWERUP:
+		break;
+	case QCOM_SSR_AFTER_POWERUP:
+		break;
+	case QCOM_SSR_BEFORE_SHUTDOWN:
+		if (notify_data->crashed)
+			ath11k_ahb_coredump_msa(ab);
+		break;
+	case QCOM_SSR_AFTER_SHUTDOWN:
+		break;
+	default:
+		ath11k_err(ab, "received unrecognized event %lu\n", action);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ath11k_ahb_register_ssr_notifier(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	void *notifier;
+	int ret;
+
+	ab_ahb->nb.notifier_call = ath11k_ahb_ssr_notifier;
+
+	notifier = qcom_register_ssr_notifier("wpss", &ab_ahb->nb);
+	if (IS_ERR(notifier)) {
+		ret = PTR_ERR(notifier);
+		ath11k_err(ab, "failed to initialize SSR notifier: %d\n", ret);
+		return ret;
+	}
+
+	ab_ahb->notifier = notifier;
+
+	return 0;
+}
+
+static void ath11k_ahb_unregister_ssr_notifier(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	int ret;
+
+	ret = qcom_unregister_ssr_notifier(ab_ahb->notifier, &ab_ahb->nb);
+	if (ret)
+		ath11k_err(ab, "error %d unregistering notifier\n", ret);
+}
+
 static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
@@ -798,6 +868,14 @@ static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 
 	ab_ahb->fw.msa_paddr = r.start;
 	ab_ahb->fw.msa_size = resource_size(&r);
+	ab_ahb->fw.msa_vaddr = devm_memremap(dev, ab_ahb->fw.msa_paddr,
+					     ab_ahb->fw.msa_size,
+					     MEMREMAP_WT);
+	if (IS_ERR(ab_ahb->fw.msa_vaddr)) {
+		dev_err(dev, "failed to map memory region: %pa\n",
+			&r.start);
+		return PTR_ERR(ab_ahb->fw.msa_vaddr);
+	}
 
 	node = of_parse_phandle(dev->of_node, "memory-region", 1);
 	if (!node)
@@ -813,7 +891,7 @@ static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 	ab_ahb->fw.ce_paddr = r.start;
 	ab_ahb->fw.ce_size = resource_size(&r);
 
-	return 0;
+	return ath11k_ahb_register_ssr_notifier(ab);
 }
 
 static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
@@ -917,6 +995,8 @@ static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
 	if (ab_ahb->fw.use_tz)
 		return 0;
 
+	ath11k_ahb_unregister_ssr_notifier(ab);
+
 	iommu = ab_ahb->fw.iommu_domain;
 
 	unmapped_size = iommu_unmap(iommu, ab_ahb->fw.msa_paddr, ab_ahb->fw.msa_size);
@@ -940,6 +1020,7 @@ static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
 static int ath11k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath11k_base *ab;
+	struct ath11k_ahb *ab_ahb;
 	const struct of_device_id *of_id;
 	const struct ath11k_bus_params *bus_params;
 	const struct ath11k_hif_ops *hif_ops;
@@ -986,6 +1067,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
+	ab_ahb = ath11k_ahb_priv(ab);
+	ab_ahb->ab = ab;
 
 	ret = ath11k_ahb_setup_resources(ab);
 	if (ret)
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index 4c7872d..efb72eb 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH11K_AHB_H
 #define ATH11K_AHB_H
 
+#include <linux/notifier.h>
 #include "core.h"
 
 #define ATH11K_AHB_RECOVERY_TIMEOUT (3 * HZ)
@@ -13,15 +14,20 @@ struct ath11k_base;
 
 struct ath11k_ahb {
 	struct rproc *tgt_rproc;
+	struct ath11k_base *ab;
 	struct {
 		struct device *dev;
 		struct iommu_domain *iommu_domain;
 		dma_addr_t msa_paddr;
 		u32 msa_size;
+		void *msa_vaddr;
 		dma_addr_t ce_paddr;
 		u32 ce_size;
 		bool use_tz;
 	} fw;
+
+	struct notifier_block nb;
+	void *notifier;
 };
 
 static inline struct ath11k_ahb *ath11k_ahb_priv(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/coredump.c b/drivers/net/wireless/ath/ath11k/coredump.c
new file mode 100644
index 0000000..247ac26
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/coredump.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/devcoredump.h>
+#include <linux/dma-direction.h>
+#include <linux/mm.h>
+#include <linux/uuid.h>
+#include <linux/time.h>
+#include "core.h"
+#include "coredump.h"
+#include "debug.h"
+
+static void ath11k_coredump_update_hdr(struct ath11k_base *ab,
+				       struct ath11k_dump_file_data *file_data,
+				       size_t header_size)
+{
+	struct timespec64 timestamp;
+
+	strscpy(file_data->df_magic, "ATH11K-FW-DUMP",
+		sizeof(file_data->df_magic));
+	file_data->len = cpu_to_le32(header_size);
+	file_data->version = cpu_to_le32(ATH11K_FW_CRASH_DUMP_VERSION);
+	guid_gen(&file_data->guid);
+	ktime_get_real_ts64(&timestamp);
+	file_data->tv_sec = cpu_to_le64(timestamp.tv_sec);
+	file_data->tv_nsec = cpu_to_le64(timestamp.tv_nsec);
+}
+
+void ath11k_coredump_msa(struct ath11k_base *ab,
+			 struct ath11k_msa_dump *msa_data)
+{
+	struct ath11k_dump_segment *segment;
+	struct ath11k_dump_file_data *file_data;
+	size_t header_size;
+	int ret;
+	u8 *buf, *dump;
+
+	segment = vzalloc(sizeof(*segment));
+	if (!segment)
+		return;
+
+	header_size = sizeof(struct ath11k_dump_file_data);
+	header_size += sizeof(*segment);
+	header_size = PAGE_ALIGN(header_size);
+	buf = vzalloc(header_size);
+	if (!buf) {
+		vfree(segment);
+		return;
+	}
+
+	file_data = (struct ath11k_dump_file_data *)buf;
+
+	ath11k_coredump_update_hdr(ab, file_data, header_size);
+
+	file_data->num_seg = cpu_to_le32(1);
+	file_data->seg_size = cpu_to_le32(sizeof(*segment));
+
+	/* copy segment details to file */
+	buf += offsetof(struct ath11k_dump_file_data, seg);
+	file_data->seg = (struct ath11k_dump_segment *)buf;
+
+	segment->addr = msa_data->paddr;
+	segment->vaddr = msa_data->vaddr;
+	segment->len = msa_data->size;
+	segment->type = ATH11K_FW_MSA_DUMP_DATA;
+
+	memcpy(file_data->seg, segment, sizeof(*segment));
+
+	dump = vzalloc(header_size + segment->len);
+	if (!dump) {
+		ret = -ENOMEM;
+		ath11k_err(ab, "failed to allocate memory for msa dump %d\n", ret);
+		goto err_alloc_fail;
+	}
+
+	memcpy(dump, (void *)file_data, header_size);
+	memcpy(dump + header_size, segment->vaddr, segment->len);
+
+	dev_coredumpv(ab->dev, dump, header_size + segment->len,
+		      GFP_KERNEL);
+err_alloc_fail:
+	vfree(file_data);
+	vfree(segment);
+}
+EXPORT_SYMBOL(ath11k_coredump_msa);
diff --git a/drivers/net/wireless/ath/ath11k/coredump.h b/drivers/net/wireless/ath/ath11k/coredump.h
new file mode 100644
index 0000000..ad7ecf2
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/coredump.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _COREDUMP_H_
+#define _COREDUMP_H_
+
+#define ATH11K_FW_CRASH_DUMP_VERSION 1
+
+enum ath11k_fw_crash_dump_type {
+	ATH11K_FW_MSA_DUMP_DATA,
+	ATH11K_FW_CRASH_DUMP_MAX,
+};
+
+struct ath11k_dump_segment {
+	unsigned long addr;
+	u32 *vaddr;
+	unsigned int len;
+	unsigned int type;
+};
+
+struct ath11k_dump_file_data {
+	/* "ATH11K-FW-DUMP" */
+	char df_magic[16];
+	__le32 len;
+	/* file dump version */
+	__le32 version;
+	/* pci device id */
+	__le32 chip_id;
+	guid_t guid;
+	/* time-of-day stamp */
+	__le64 tv_sec;
+	/* time-of-day stamp, nano-seconds */
+	__le64 tv_nsec;
+	/* room for growth w/out changing binary format */
+	u8 unused[8];
+	/* number of segments */
+	__le32 num_seg;
+	/* ath11k_dump_segment struct size */
+	__le32 seg_size;
+
+	struct ath11k_dump_segment *seg;
+	/* struct ath11k_dump_segment + more */
+
+	u8 data[];
+} __packed;
+
+struct ath11k_coredump_state {
+	struct ath11k_dump_file_data *header;
+	struct ath11k_dump_segment *segments;
+	u32 num_seg;
+};
+
+struct ath11k_msa_dump {
+	u64 paddr;
+	u32 *vaddr;
+	u64 size;
+};
+
+#ifdef CONFIG_DEV_COREDUMP
+void ath11k_coredump_msa(struct ath11k_base *ab,
+			 struct ath11k_msa_dump *msa_data);
+#else
+static inline void
+ath11k_coredump_msa(struct ath11k_base *ab,
+		    struct ath11k_msa_dump *msa_data)
+{
+}
+#endif /* CONFIG_DEV_COREDUMP */
+#endif /* _COREDUMP_H_ */
-- 
2.7.4

