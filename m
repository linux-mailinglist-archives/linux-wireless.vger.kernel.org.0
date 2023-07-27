Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D796B765086
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjG0KEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjG0KEj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 06:04:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE66128
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 03:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A153A61E0B
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A55DC433CA;
        Thu, 27 Jul 2023 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690452277;
        bh=2zJV53vEqYaZy8heE2GHYfilelIs2GdhUniBqPT+mP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnvdA1vzuDd/KGMSTGU78FOli5AQ2AwUEpXvsXKRd0psJRaD5WsgMOMiuCAUTrH/Z
         GAnlPvvTRM4Z0xkMmejSbCr8Zu/u+8AaNb4gcxitKUmFuaxM7j1lrcyGmW+svozkDF
         LoOic0gTocekASpQsWMgxhdo/+JVc0FT8O4PcX66JZ7H4SJo3dXpzzanWdCHL9I/Da
         /dh65UXLMjA/BZDsFxWZI6Ge1q6J6YTYFd2HCuv6G+Jw1kE3mh0FLDc+Mx6TxnVUJ6
         pSC+cxv5OS3efag2odmTWyY5LDjjMHnWYzhROR3ePrRiNrLXomfyZiJjg1RSsR0NGy
         mkWTK9gIux7+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v4 3/3] wifi: ath11k: add firmware-2.bin support
Date:   Thu, 27 Jul 2023 13:04:30 +0300
Message-Id: <20230727100430.3603551-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727100430.3603551-1-kvalo@kernel.org>
References: <20230727100430.3603551-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <quic_akolli@quicinc.com>

Firmware IE containers can dynamically provide various information
what firmware supports. Also it can embed more than one image so
updating firmware is easy, user just needs to update one file in
/lib/firmware/.

The firmware API 2 or higher will use the IE container format, the
current API 1 will not use the new format but it still is supported
for some time. Firmware API 2 files are named as firmware-2.bin
(which contains both amss.bin and m3.bin images) and API 1 files are
amss.bin and m3.bin.

Currently ath11k PCI driver provides firmware binary (amss.bin) path to
MHI driver, MHI driver reads firmware from filesystem and boots it. Add
provision to read firmware files from ath11k driver and provide the amss.bin
firmware data and size to MHI using a pointer.

Currently enum ath11k_fw_features is empty, the patches adding features will
add the flags.

With AHB devices there's no amss.bin or m3.bin, so no changes in how AHB
firmware files are used. But AHB devices can use future additions to the meta
data, for example in enum ath11k_fw_features.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
Co-developed-by: Kalle Valo <quic_kvalo@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/core.c   |   8 ++
 drivers/net/wireless/ath/ath11k/core.h   |  15 +++
 drivers/net/wireless/ath/ath11k/fw.c     | 157 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/fw.h     |  27 ++++
 drivers/net/wireless/ath/ath11k/mhi.c    |  18 ++-
 drivers/net/wireless/ath/ath11k/qmi.c    |  36 ++++--
 7 files changed, 247 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index cc47e0114595..2c94d50ae36f 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -17,7 +17,8 @@ ath11k-y += core.o \
 	    peer.o \
 	    dbring.o \
 	    hw.o \
-	    pcic.o
+	    pcic.o \
+	    fw.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index bebfd342e28b..804625cebf80 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -16,6 +16,7 @@
 #include "debug.h"
 #include "hif.h"
 #include "wow.h"
+#include "fw.h"
 
 unsigned int ath11k_debug_mask;
 EXPORT_SYMBOL(ath11k_debug_mask);
@@ -1985,6 +1986,12 @@ int ath11k_core_pre_init(struct ath11k_base *ab)
 		return ret;
 	}
 
+	ret = ath11k_fw_pre_init(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to pre init firmware: %d", ret);
+		return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(ath11k_core_pre_init);
@@ -2015,6 +2022,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
+	ath11k_fw_destroy(ab);
 }
 EXPORT_SYMBOL(ath11k_core_deinit);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9d15b4390b9c..e803031cabaf 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -15,6 +15,8 @@
 #include <linux/ctype.h>
 #include <linux/rhashtable.h>
 #include <linux/average.h>
+#include <linux/firmware.h>
+
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -29,6 +31,7 @@
 #include "dbring.h"
 #include "spectral.h"
 #include "wow.h"
+#include "fw.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -984,6 +987,18 @@ struct ath11k_base {
 		const struct ath11k_pci_ops *ops;
 	} pci;
 
+	struct {
+		u32 api_version;
+
+		const struct firmware *fw;
+		const u8 *amss_data;
+		size_t amss_len;
+		const u8 *m3_data;
+		size_t m3_len;
+
+		DECLARE_BITMAP(fw_features, ATH11K_FW_FEATURE_COUNT);
+	} fw;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 data_pos;
diff --git a/drivers/net/wireless/ath/ath11k/fw.c b/drivers/net/wireless/ath/ath11k/fw.c
new file mode 100644
index 000000000000..5423c0be63fa
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/fw.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "core.h"
+
+#include "debug.h"
+
+static int ath11k_fw_request_firmware_api_n(struct ath11k_base *ab,
+					    const char *name)
+{
+	size_t magic_len, len, ie_len;
+	int ie_id, i, index, bit, ret;
+	struct ath11k_fw_ie *hdr;
+	const u8 *data;
+	__le32 *timestamp;
+
+	ab->fw.fw = ath11k_core_firmware_request(ab, name);
+	if (IS_ERR(ab->fw.fw)) {
+		ret = PTR_ERR(ab->fw.fw);
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "failed to load %s: %d\n", name, ret);
+		ab->fw.fw = NULL;
+		return ret;
+	}
+
+	data = ab->fw.fw->data;
+	len = ab->fw.fw->size;
+
+	/* magic also includes the null byte, check that as well */
+	magic_len = strlen(ATH11K_FIRMWARE_MAGIC) + 1;
+
+	if (len < magic_len) {
+		ath11k_err(ab, "firmware image too small to contain magic: %zu\n",
+			   len);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (memcmp(data, ATH11K_FIRMWARE_MAGIC, magic_len) != 0) {
+		ath11k_err(ab, "Invalid firmware magic\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* jump over the padding */
+	magic_len = ALIGN(magic_len, 4);
+
+	len -= magic_len;
+	data += magic_len;
+
+	/* loop elements */
+	while (len > sizeof(struct ath11k_fw_ie)) {
+		hdr = (struct ath11k_fw_ie *)data;
+
+		ie_id = le32_to_cpu(hdr->id);
+		ie_len = le32_to_cpu(hdr->len);
+
+		len -= sizeof(*hdr);
+		data += sizeof(*hdr);
+
+		if (len < ie_len) {
+			ath11k_err(ab, "Invalid length for FW IE %d (%zu < %zu)\n",
+				   ie_id, len, ie_len);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		switch (ie_id) {
+		case ATH11K_FW_IE_TIMESTAMP:
+			if (ie_len != sizeof(u32))
+				break;
+
+			timestamp = (__le32 *)data;
+
+			ath11k_dbg(ab, ATH11K_DBG_BOOT, "found fw timestamp %d\n",
+				   le32_to_cpup(timestamp));
+			break;
+		case ATH11K_FW_IE_FEATURES:
+			ath11k_dbg(ab, ATH11K_DBG_BOOT,
+				   "found firmware features ie (%zd B)\n",
+				   ie_len);
+
+			for (i = 0; i < ATH11K_FW_FEATURE_COUNT; i++) {
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
+			ath11k_dbg_dump(ab, ATH11K_DBG_BOOT, "features", "",
+					ab->fw.fw_features,
+					sizeof(ab->fw.fw_features));
+			break;
+		case ATH11K_FW_IE_AMSS_IMAGE:
+			ath11k_dbg(ab, ATH11K_DBG_BOOT,
+				   "found fw image ie (%zd B)\n",
+				   ie_len);
+
+			ab->fw.amss_data = data;
+			ab->fw.amss_len = ie_len;
+			break;
+		case ATH11K_FW_IE_M3_IMAGE:
+			ath11k_dbg(ab, ATH11K_DBG_BOOT,
+				   "found m3 image ie (%zd B)\n",
+				   ie_len);
+
+			ab->fw.m3_data = data;
+			ab->fw.m3_len = ie_len;
+			break;
+		default:
+			ath11k_warn(ab, "Unknown FW IE: %u\n", ie_id);
+			break;
+		}
+
+		/* jump over the padding */
+		ie_len = ALIGN(ie_len, 4);
+
+		len -= ie_len;
+		data += ie_len;
+	};
+
+	return 0;
+
+err:
+	release_firmware(ab->fw.fw);
+	ab->fw.fw = NULL;
+	return ret;
+}
+
+int ath11k_fw_pre_init(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_fw_request_firmware_api_n(ab, ATH11K_FW_API2_FILE);
+	if (ret == 0) {
+		ab->fw.api_version = 2;
+		goto out;
+	}
+
+	ab->fw.api_version = 1;
+
+out:
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "using fw api %d\n",
+		   ab->fw.api_version);
+
+	return 0;
+}
+
+void ath11k_fw_destroy(struct ath11k_base *ab)
+{
+	release_firmware(ab->fw.fw);
+}
diff --git a/drivers/net/wireless/ath/ath11k/fw.h b/drivers/net/wireless/ath/ath11k/fw.h
new file mode 100644
index 000000000000..e33b0f78b571
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/fw.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH11K_FW_H
+#define ATH11K_FW_H
+
+#define ATH11K_FW_API2_FILE		"firmware-2.bin"
+#define ATH11K_FIRMWARE_MAGIC		"QCOM-ATH11K-FW"
+
+enum ath11k_fw_ie_type {
+	ATH11K_FW_IE_TIMESTAMP = 0,
+	ATH11K_FW_IE_FEATURES = 1,
+	ATH11K_FW_IE_AMSS_IMAGE = 2,
+	ATH11K_FW_IE_M3_IMAGE = 3,
+};
+
+enum ath11k_fw_features {
+	/* keep last */
+	ATH11K_FW_FEATURE_COUNT,
+};
+
+int ath11k_fw_pre_init(struct ath11k_base *ab);
+void ath11k_fw_destroy(struct ath11k_base *ab);
+
+#endif /* ATH11K_FW_H */
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 3ac689f1def4..83bc277b836c 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -6,6 +6,7 @@
 
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/firmware.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/ioport.h>
@@ -389,16 +390,23 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	if (!mhi_ctrl)
 		return -ENOMEM;
 
-	ath11k_core_create_firmware_path(ab, ATH11K_AMSS_FILE,
-					 ab_pci->amss_path,
-					 sizeof(ab_pci->amss_path));
-
 	ab_pci->mhi_ctrl = mhi_ctrl;
 	mhi_ctrl->cntrl_dev = ab->dev;
-	mhi_ctrl->fw_image = ab_pci->amss_path;
 	mhi_ctrl->regs = ab->mem;
 	mhi_ctrl->reg_len = ab->mem_len;
 
+	if (ab->fw.amss_data && ab->fw.amss_len > 0) {
+		/* use MHI firmware file from firmware-N.bin */
+		mhi_ctrl->fw_data = ab->fw.amss_data;
+		mhi_ctrl->fw_sz = ab->fw.amss_len;
+	} else {
+		/* use the old separate mhi.bin MHI firmware file */
+		ath11k_core_create_firmware_path(ab, ATH11K_AMSS_FILE,
+						 ab_pci->amss_path,
+						 sizeof(ab_pci->amss_path));
+		mhi_ctrl->fw_image = ab_pci->amss_path;
+	}
+
 	ret = ath11k_mhi_get_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to get msi for mhi\n");
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 9b13628fa3c7..0a35e7d126a9 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2502,25 +2502,39 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
 static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
-	const struct firmware *fw;
+	const struct firmware *fw = NULL;
+	const void *m3_data;
 	char path[100];
+	size_t m3_len;
 	int ret;
 
 	if (m3_mem->vaddr)
 		/* m3 firmware buffer is already available in the DMA buffer */
 		return 0;
 
-	fw = ath11k_core_firmware_request(ab, ATH11K_M3_FILE);
-	if (IS_ERR(fw)) {
-		ret = PTR_ERR(fw);
-		ath11k_core_create_firmware_path(ab, ATH11K_M3_FILE,
-						 path, sizeof(path));
-		ath11k_err(ab, "failed to load %s: %d\n", path, ret);
-		return ret;
+	if (ab->fw.m3_data && ab->fw.m3_len > 0) {
+		/* firmware-N.bin had a m3 firmware file so use that */
+		m3_data = ab->fw.m3_data;
+		m3_len = ab->fw.m3_len;
+	} else {
+		/* No m3 file in firmware-N.bin so try to request old
+		 * separate m3.bin.
+		 */
+		fw = ath11k_core_firmware_request(ab, ATH11K_M3_FILE);
+		if (IS_ERR(fw)) {
+			ret = PTR_ERR(fw);
+			ath11k_core_create_firmware_path(ab, ATH11K_M3_FILE,
+							 path, sizeof(path));
+			ath11k_err(ab, "failed to load %s: %d\n", path, ret);
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
 		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
@@ -2529,8 +2543,8 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 		goto out;
 	}
 
-	memcpy(m3_mem->vaddr, fw->data, fw->size);
-	m3_mem->size = fw->size;
+	memcpy(m3_mem->vaddr, m3_data, m3_len);
+	m3_mem->size = m3_len;
 
 	ret = 0;
 
-- 
2.39.2

