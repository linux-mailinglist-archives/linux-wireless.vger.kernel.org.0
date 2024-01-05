Return-Path: <linux-wireless+bounces-1524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3B82587D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F32C1C2364D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711E31A81;
	Fri,  5 Jan 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xfeb4Lje"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7F31A89
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405Dp8Wu030955;
	Fri, 5 Jan 2024 16:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=RRR4Caa
	PcSfYtpKtzcPAxG4NrrYcFYsbSmuyJ1F8upQ=; b=Xfeb4Lje8luBDzqnxB2v0cc
	Gtntj7btu4zvs35Czwrm9n8+QiCHMIGee3duiJZjP06M63DrumgA3EJjWa+Gqofn
	t5tI5P19ArrcIgJKtOmyTa5EEL3MTgWZw4GKnNdtK/KrISmXPDZ1ak/fSZfbadVX
	OrmTkK0OUYu7Eg8o+jur6/DD5vx0WBZfft2Vv5Jv+uj55Yxymvelgxa+ZsbwyQsR
	VE2wKGMmKs6MJxYhRto4VAeXhtu8yLUfQ0Xcm7v6U7zsyeaoVk9k/RKq6CFNtPrt
	ZQyMrQjQAPsiIrKYq7s+2HPF/69Bw7r/u16GJ0rWbLI4dijsdlbP/f2qfjUr5mw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve96wshq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 16:42:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405GgSXf010617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 16:42:28 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 08:42:27 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH] wifi: ath12k: add firmware-2.bin support
Date: Fri, 5 Jan 2024 22:12:07 +0530
Message-ID: <20240105164207.2906093-1-quic_rajkbhag@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YayC-nKI7pT6WADF2t5fdrSNkHXjHu0o
X-Proofpoint-ORIG-GUID: YayC-nKI7pT6WADF2t5fdrSNkHXjHu0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050138

Firmware IE containers can dynamically provide various information
what firmware supports. Also it can embed more than one image so
updating firmware is easy, user just needs to update one file in
/lib/firmware/.

The firmware API 2 or higher will use the IE container format, the
current API 1 will not use the new format but it still is supported
for some time. Firmware API 2 files are named as firmware-2.bin
(which contains both amss.bin and m3.bin images) and API 1 files are
amss.bin and m3.bin.

Currently ath12k PCI driver provides firmware binary (amss.bin) path to
MHI driver, MHI driver reads firmware from filesystem and boots it. Add
provision to read firmware files from ath12k driver and provide the amss.bin
firmware data and size to MHI using a pointer.

Currently enum ath12k_fw_features is empty, the patches adding features will
add the flags.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile |   3 +-
 drivers/net/wireless/ath/ath12k/core.c   |  10 +-
 drivers/net/wireless/ath/ath12k/core.h   |  16 ++-
 drivers/net/wireless/ath/ath12k/fw.c     | 165 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/fw.h     |  27 ++++
 drivers/net/wireless/ath/ath12k/mhi.c    |  20 ++-
 drivers/net/wireless/ath/ath12k/qmi.c    |  51 ++++---
 7 files changed, 267 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 62c52e733b5e..0d723e85cf6b 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -19,7 +19,8 @@ ath12k-y += core.o \
 	    hw.o \
 	    mhi.o \
 	    pci.o \
-	    dp_mon.o
+	    dp_mon.o \
+	    fw.o
 
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index d73e2d33a41e..609f5173e070 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -14,6 +14,7 @@
 #include "dp_rx.h"
 #include "debug.h"
 #include "hif.h"
+#include "fw.h"
 
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
@@ -1101,6 +1102,12 @@ int ath12k_core_pre_init(struct ath12k_base *ab)
 		return ret;
 	}
 
+	ret = ath12k_fw_map(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to map firmware: %d", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1129,6 +1136,7 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 	ath12k_hif_power_down(ab);
 	ath12k_mac_destroy(ab);
 	ath12k_core_soc_destroy(ab);
+	ath12k_fw_unmap(ab);
 }
 
 void ath12k_core_free(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ba0a30f1ea29..5ae8a931716b 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CORE_H
@@ -13,6 +13,7 @@
 #include <linux/bitfield.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
+#include <linux/firmware.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -24,6 +25,7 @@
 #include "hal_rx.h"
 #include "reg.h"
 #include "dbring.h"
+#include "fw.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -806,6 +808,18 @@ struct ath12k_base {
 		u32 subsystem_device;
 	} id;
 
+	struct {
+		u32 api_version;
+
+		const struct firmware *fw;
+		const u8 *amss_data;
+		size_t amss_len;
+		const u8 *m3_data;
+		size_t m3_len;
+
+		DECLARE_BITMAP(fw_features, ATH12K_FW_FEATURE_COUNT);
+	} fw;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/fw.c b/drivers/net/wireless/ath/ath12k/fw.c
new file mode 100644
index 000000000000..85caa1074499
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/fw.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "core.h"
+
+#include "debug.h"
+
+static int ath12k_fw_request_firmware_api_n(struct ath12k_base *ab,
+					    const char *name)
+{
+	size_t magic_len, len, ie_len;
+	int ie_id, i, index, bit, ret;
+	struct ath12k_fw_ie *hdr;
+	const u8 *data;
+	__le32 *timestamp;
+
+	ab->fw.fw = ath12k_core_firmware_request(ab, name);
+	if (IS_ERR(ab->fw.fw)) {
+		ret = PTR_ERR(ab->fw.fw);
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "failed to load %s: %d\n", name, ret);
+		ab->fw.fw = NULL;
+		return ret;
+	}
+
+	data = ab->fw.fw->data;
+	len = ab->fw.fw->size;
+
+	/* magic also includes the null byte, check that as well */
+	magic_len = strlen(ATH12K_FIRMWARE_MAGIC) + 1;
+
+	if (len < magic_len) {
+		ath12k_err(ab, "firmware image too small to contain magic: %zu\n",
+			   len);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (memcmp(data, ATH12K_FIRMWARE_MAGIC, magic_len) != 0) {
+		ath12k_err(ab, "Invalid firmware magic\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* jump over the padding */
+	magic_len = ALIGN(magic_len, 4);
+
+	/* make sure there's space for padding */
+	if (magic_len > len) {
+		ath12k_err(ab, "No space for padding after magic\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	len -= magic_len;
+	data += magic_len;
+
+	/* loop elements */
+	while (len > sizeof(struct ath12k_fw_ie)) {
+		hdr = (struct ath12k_fw_ie *)data;
+
+		ie_id = le32_to_cpu(hdr->id);
+		ie_len = le32_to_cpu(hdr->len);
+
+		len -= sizeof(*hdr);
+		data += sizeof(*hdr);
+
+		if (len < ie_len) {
+			ath12k_err(ab, "Invalid length for FW IE %d (%zu < %zu)\n",
+				   ie_id, len, ie_len);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		switch (ie_id) {
+		case ATH12K_FW_IE_TIMESTAMP:
+			if (ie_len != sizeof(u32))
+				break;
+
+			timestamp = (__le32 *)data;
+
+			ath12k_dbg(ab, ATH12K_DBG_BOOT, "found fw timestamp %d\n",
+				   le32_to_cpup(timestamp));
+			break;
+		case ATH12K_FW_IE_FEATURES:
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "found firmware features ie (%zd B)\n",
+				   ie_len);
+
+			for (i = 0; i < ATH12K_FW_FEATURE_COUNT; i++) {
+				index = i / 8;
+				bit = i % 8;
+
+				if (index == ie_len)
+					break;
+
+				if (data[index] & (1 << bit))
+					__set_bit(i, ab->fw.fw_features);
+			}
+
+			ath12k_dbg_dump(ab, ATH12K_DBG_BOOT, "features", "",
+					ab->fw.fw_features,
+					sizeof(ab->fw.fw_features));
+			break;
+		case ATH12K_FW_IE_AMSS_IMAGE:
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "found fw image ie (%zd B)\n",
+				   ie_len);
+
+			ab->fw.amss_data = data;
+			ab->fw.amss_len = ie_len;
+			break;
+		case ATH12K_FW_IE_M3_IMAGE:
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "found m3 image ie (%zd B)\n",
+				   ie_len);
+
+			ab->fw.m3_data = data;
+			ab->fw.m3_len = ie_len;
+			break;
+		default:
+			ath12k_warn(ab, "Unknown FW IE: %u\n", ie_id);
+			break;
+		}
+
+		/* jump over the padding */
+		ie_len = ALIGN(ie_len, 4);
+
+		/* make sure there's space for padding */
+		if (ie_len > len)
+			break;
+
+		len -= ie_len;
+		data += ie_len;
+	}
+
+	return 0;
+
+err:
+	release_firmware(ab->fw.fw);
+	ab->fw.fw = NULL;
+	return ret;
+}
+
+int ath12k_fw_map(struct ath12k_base *ab)
+{
+	int ret;
+
+	ret = ath12k_fw_request_firmware_api_n(ab, ATH12K_FW_API2_FILE);
+	if (ret == 0)
+		ab->fw.api_version = 2;
+	else
+		ab->fw.api_version = 1;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "using fw api %d\n",
+		   ab->fw.api_version);
+
+	return 0;
+}
+
+void ath12k_fw_unmap(struct ath12k_base *ab)
+{
+	release_firmware(ab->fw.fw);
+}
diff --git a/drivers/net/wireless/ath/ath12k/fw.h b/drivers/net/wireless/ath/ath12k/fw.h
new file mode 100644
index 000000000000..ee0a3b68b3e1
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/fw.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_FW_H
+#define ATH12K_FW_H
+
+#define ATH12K_FW_API2_FILE		"firmware-2.bin"
+#define ATH12K_FIRMWARE_MAGIC		"QCOM-ATH12K-FW"
+
+enum ath12k_fw_ie_type {
+	ATH12K_FW_IE_TIMESTAMP = 0,
+	ATH12K_FW_IE_FEATURES = 1,
+	ATH12K_FW_IE_AMSS_IMAGE = 2,
+	ATH12K_FW_IE_M3_IMAGE = 3,
+};
+
+enum ath12k_fw_features {
+	/* keep last */
+	ATH12K_FW_FEATURE_COUNT,
+};
+
+int ath12k_fw_map(struct ath12k_base *ab);
+void ath12k_fw_unmap(struct ath12k_base *ab);
+
+#endif /* ATH12K_FW_H */
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index d5441ddb374b..b7b31978a434 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/firmware.h>
 
 #include "core.h"
 #include "debug.h"
@@ -364,17 +365,24 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	if (!mhi_ctrl)
 		return -ENOMEM;
 
-	ath12k_core_create_firmware_path(ab, ATH12K_AMSS_FILE,
-					 ab_pci->amss_path,
-					 sizeof(ab_pci->amss_path));
-
 	ab_pci->mhi_ctrl = mhi_ctrl;
 	mhi_ctrl->cntrl_dev = ab->dev;
-	mhi_ctrl->fw_image = ab_pci->amss_path;
 	mhi_ctrl->regs = ab->mem;
 	mhi_ctrl->reg_len = ab->mem_len;
 	mhi_ctrl->rddm_size = ab->hw_params->rddm_size;
 
+	if (ab->fw.amss_data && ab->fw.amss_len > 0) {
+		/* use MHI firmware file from firmware-N.bin */
+		mhi_ctrl->fw_data = ab->fw.amss_data;
+		mhi_ctrl->fw_sz = ab->fw.amss_len;
+	} else {
+		/* use the old separate mhi.bin MHI firmware file */
+		ath12k_core_create_firmware_path(ab, ATH12K_AMSS_FILE,
+						 ab_pci->amss_path,
+						 sizeof(ab_pci->amss_path));
+		mhi_ctrl->fw_image = ab_pci->amss_path;
+	}
+
 	ret = ath12k_mhi_get_msi(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to get msi for mhi\n");
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 536856234f3b..3c78117341a9 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -2496,37 +2496,56 @@ static int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
 static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
-	const struct firmware *fw;
+	const struct firmware *fw = NULL;
+	const void *m3_data;
 	char path[100];
+	size_t m3_len;
 	int ret;
 
-	if (m3_mem->vaddr || m3_mem->size)
+	if (m3_mem->vaddr)
+		/* m3 firmware buffer is already available in the DMA buffer */
 		return 0;
 
-	fw = ath12k_core_firmware_request(ab, ATH12K_M3_FILE);
-	if (IS_ERR(fw)) {
-		ret = PTR_ERR(fw);
-		ath12k_core_create_firmware_path(ab, ATH12K_M3_FILE,
-						 path, sizeof(path));
-		ath12k_err(ab, "failed to load %s: %d\n", path, ret);
-		return ret;
+	if (ab->fw.m3_data && ab->fw.m3_len > 0) {
+		/* firmware-N.bin had a m3 firmware file so use that */
+		m3_data = ab->fw.m3_data;
+		m3_len = ab->fw.m3_len;
+	} else {
+		/* No m3 file in firmware-N.bin so try to request old
+		 * separate m3.bin.
+		 */
+		fw = ath12k_core_firmware_request(ab, ATH12K_M3_FILE);
+		if (IS_ERR(fw)) {
+			ret = PTR_ERR(fw);
+			ath12k_core_create_firmware_path(ab, ATH12K_M3_FILE,
+							 path, sizeof(path));
+			ath12k_err(ab, "failed to load %s: %d\n", path, ret);
+			return ret;
+		}
+
+		m3_data = fw->data;
+		m3_len = fw->size;
 	}
 
 	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
-					   fw->size, &m3_mem->paddr,
+					   m3_len, &m3_mem->paddr,
 					   GFP_KERNEL);
 	if (!m3_mem->vaddr) {
 		ath12k_err(ab, "failed to allocate memory for M3 with size %zu\n",
 			   fw->size);
-		release_firmware(fw);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
-	memcpy(m3_mem->vaddr, fw->data, fw->size);
-	m3_mem->size = fw->size;
+	memcpy(m3_mem->vaddr, m3_data, m3_len);
+	m3_mem->size = m3_len;
+
+	ret = 0;
+
+out:
 	release_firmware(fw);
 
-	return 0;
+	return ret;
 }
 
 static void ath12k_qmi_m3_free(struct ath12k_base *ab)

base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9
-- 
2.34.1


