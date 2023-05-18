Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C83707DDC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjERKRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 06:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjERKRJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 06:17:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759412D53
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 03:16:28 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9qOPo010799;
        Thu, 18 May 2023 10:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=cCseUZQop8PwiNVK+UDtmZNx/wf444keMfHfiwql4PQ=;
 b=J8FEi+5tg9dEdQzWJI5buKF3yCwUk6a+rK1U/az8jke5QjdIQonHr/FWAyPT7t1BxhvJ
 FA+NRzksAONnk7j356GG+YuPeqoD7wAWVioXrBjP+if7RpvS/8Qa7/0fD62usQPvI6Ei
 D2IQN6K7VnH6NTjRBj0DvgtpB25j1+dNvBN1iMQ/p8Yt39JdH0ax6UKZ/ZYW2CivsPdV
 ieqVtNogo3Nim3DnBqC8AJp9jU9ncPKmhpofg1f5txqMAeyqj0ZdsbDn+Hk2at1468Q3
 OR7M4jNfazquaRCrn9twmBGrC04aBw/hbkS8eyu7vuG0klyIR6l9qeshfN7lj0FUknXV /Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnbxqgprv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:16:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IAG80x024340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:16:08 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 03:16:07 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 1/2] wifi: ath11k: Add coredump support
Date:   Thu, 18 May 2023 15:45:45 +0530
Message-ID: <20230518101546.27998-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518101546.27998-1-quic_mpubbise@quicinc.com>
References: <20230518101546.27998-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XX43EaEApfU_0blfi5MyL1sVz5Mda_O0
X-Proofpoint-GUID: XX43EaEApfU_0blfi5MyL1sVz5Mda_O0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the event of firmware asserts, it is very useful to capture the
snapshot of the memory that firmware uses. This aids in debugging
firmware asserts. The snapshot of the DDR memory that firmware uses
can be dumped to user space by using kernel's devcoredump framework.

The design of coredump is taken from ath10k. The ABI looks more or
less similar to ath10k although some fields are removed/modified
to suite the design of ath11k.

coredump is disabled by default and can be controlled by a module
parameter called coredump_mask. Currently only RAMDUMPs are
supported and the interface can be easily extended in future.

RAMDUMPs can be enabled by using the following command:

modprobe ath11k coredump_mask=0x1

This patch adds the framework required to enable coredump in ath11k
but no hardware support is included. The next patch will add support
for WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig    |   1 +
 drivers/net/wireless/ath/ath11k/Makefile   |   1 +
 drivers/net/wireless/ath/ath11k/core.c     |  18 +-
 drivers/net/wireless/ath/ath11k/core.h     |  19 +-
 drivers/net/wireless/ath/ath11k/coredump.c | 209 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/coredump.h | 147 +++++++++++++++
 6 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index ad5cc6cac05b..96074f5edfd0 100644
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
index cc47e0114595..44f8039453d5 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -25,6 +25,7 @@ ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 ath11k-$(CONFIG_PM) += wow.o
+ath11k-$(CONFIG_DEV_COREDUMP) += coredump.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b1b90bd34d67..d666da5c746c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -16,6 +16,7 @@
 #include "debug.h"
 #include "hif.h"
 #include "wow.h"
+#include "coredump.h"
 
 unsigned int ath11k_debug_mask;
 EXPORT_SYMBOL(ath11k_debug_mask);
@@ -32,6 +33,10 @@ module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
 MODULE_PARM_DESC(frame_mode,
 		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
 
+unsigned long ath11k_coredump_mask;
+module_param_named(coredump_mask, ath11k_coredump_mask, ulong, 0444);
+MODULE_PARM_DESC(coredump_mask, "Bitfield of what to include in firmware crash file");
+
 static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.hw_rev = ATH11K_HW_IPQ8074,
@@ -1825,6 +1830,11 @@ static void ath11k_core_restart(struct work_struct *work)
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, restart_work);
 	int ret;
 
+	ret = ath11k_coredump_submit(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to send firmware crash dump via devcoredump: %d",
+			    ret);
+
 	ret = ath11k_core_reconfigure_on_crash(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to reconfigure driver on crash recovery\n");
@@ -1956,6 +1966,10 @@ int ath11k_core_init(struct ath11k_base *ab)
 		return ret;
 	}
 
+	ret = ath11k_coredump_create(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to create coredump memory: %d", ret);
+
 	return 0;
 }
 EXPORT_SYMBOL(ath11k_core_init);
@@ -1971,6 +1985,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 
 	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
+	ath11k_coredump_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 }
 EXPORT_SYMBOL(ath11k_core_deinit);
@@ -2005,6 +2020,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 
 	mutex_init(&ab->core_lock);
 	mutex_init(&ab->tbl_mtx_lock);
+	mutex_init(&ab->dump_mutex);
 	spin_lock_init(&ab->base_lock);
 	mutex_init(&ab->vdev_id_11d_lock);
 	init_completion(&ab->reset_complete);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0830276e5028..82334bc0f514 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_CORE_H
@@ -52,6 +52,7 @@
 #define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
 
 extern unsigned int ath11k_frame_mode;
+extern unsigned long ath11k_coredump_mask;
 
 #define ATH11K_SCAN_TIMEOUT_HZ (20 * HZ)
 
@@ -589,6 +590,14 @@ struct ath11k_per_peer_tx_stats {
 #define ATH11K_FLUSH_TIMEOUT (5 * HZ)
 #define ATH11K_VDEV_DELETE_TIMEOUT_HZ (5 * HZ)
 
+/* used for crash-dump storage, protected by dump_lock */
+struct ath11k_fw_crash_data {
+	guid_t guid;
+	struct timespec64 timestamp;
+	u8 *ramdump_buf;
+	size_t ramdump_buf_len;
+};
+
 struct ath11k {
 	struct ath11k_base *ab;
 	struct ath11k_pdev *pdev;
@@ -978,6 +987,14 @@ struct ath11k_base {
 		const struct ath11k_pci_ops *ops;
 	} pci;
 
+#ifdef CONFIG_DEV_COREDUMP
+	struct {
+		struct ath11k_fw_crash_data *fw_crash_data;
+	} coredump;
+#endif
+	/* protects coredump data */
+	struct mutex dump_mutex;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/coredump.c b/drivers/net/wireless/ath/ath11k/coredump.c
new file mode 100644
index 000000000000..1e5a58ec673e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/coredump.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/devcoredump.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/utsname.h>
+
+#include "coredump.h"
+#include "debug.h"
+
+static const struct ath11k_hw_mem_layout hw_mem_layouts[] = {
+	/* HW memory layouts shall be defined here */
+};
+
+const struct ath11k_hw_mem_layout *
+ath11k_coredump_get_mem_layout(struct ath11k_base *ab)
+{
+	int i;
+
+	if (!test_bit(ATH11K_FW_CRASH_DUMP_RAM_DATA, &ath11k_coredump_mask))
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(hw_mem_layouts); i++) {
+		if (ab->hw_rev == hw_mem_layouts[i].hw_rev &&
+		    hw_mem_layouts[i].bus == ab->hif.bus)
+			return &hw_mem_layouts[i];
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ath11k_coredump_get_mem_layout);
+
+static u32 ath11k_coredump_get_ramdump_size(struct ath11k_base *ab)
+{
+	const struct ath11k_hw_mem_layout *hw;
+	const struct ath11k_mem_region *mem_region;
+	size_t size = 0;
+	int i;
+
+	hw = ath11k_coredump_get_mem_layout(ab);
+
+	if (!hw)
+		return 0;
+
+	mem_region = &hw->region_table.regions[0];
+
+	for (i = 0; i < hw->region_table.size; i++) {
+		size += mem_region->len;
+		mem_region++;
+	}
+
+	/* reserve space for the headers */
+	size += hw->region_table.size * sizeof(struct ath11k_ramdump_hdr);
+
+	/* make sure it is aligned 16 bytes for debug message print out */
+	size = ALIGN(size, 16);
+
+	return size;
+}
+
+struct ath11k_fw_crash_data *ath11k_coredump_new(struct ath11k_base *ab)
+{
+	struct ath11k_fw_crash_data *crash_data = ab->coredump.fw_crash_data;
+
+	lockdep_assert_held(&ab->dump_mutex);
+
+	if (ath11k_coredump_mask == 0 || !crash_data)
+		/* coredump disabled */
+		return NULL;
+
+	guid_gen(&crash_data->guid);
+	ktime_get_real_ts64(&crash_data->timestamp);
+
+	return crash_data;
+}
+EXPORT_SYMBOL(ath11k_coredump_new);
+
+static struct ath11k_dump_file_data *ath11k_coredump_build(struct ath11k_base *ab)
+{
+	struct ath11k_fw_crash_data *crash_data = ab->coredump.fw_crash_data;
+	struct ath11k_dump_file_data *dump_data;
+	struct ath11k_tlv_dump_data *dump_tlv;
+	size_t hdr_len = sizeof(*dump_data);
+	size_t len, sofar = 0;
+	unsigned char *buf;
+
+	len = hdr_len;
+
+	if (test_bit(ATH11K_FW_CRASH_DUMP_RAM_DATA, &ath11k_coredump_mask) &&
+	    crash_data->ramdump_buf)
+		len += sizeof(*dump_tlv) + crash_data->ramdump_buf_len;
+
+	sofar += hdr_len;
+
+	buf = vzalloc(len);
+	if (!buf)
+		return NULL;
+
+	mutex_lock(&ab->dump_mutex);
+
+	dump_data = (struct ath11k_dump_file_data *)(buf);
+
+	strscpy(dump_data->df_magic, "ATH11K-FW-DUMP",
+		sizeof(dump_data->df_magic));
+	dump_data->len = cpu_to_le32(len);
+
+	guid_copy(&dump_data->guid, &crash_data->guid);
+
+	dump_data->version = cpu_to_le32(ATH11K_FW_CRASH_DUMP_VERSION);
+	dump_data->hw_rev = cpu_to_le32(ab->hw_params.hw_rev);
+	dump_data->bus_type = cpu_to_le32(ab->hif.bus);
+
+	strscpy(dump_data->fw_ver, ab->qmi.target.fw_build_id,
+		sizeof(ab->qmi.target.fw_build_id));
+
+	dump_data->kernel_ver_code = 0;
+	strscpy(dump_data->kernel_ver, init_utsname()->release,
+		sizeof(dump_data->kernel_ver));
+
+	dump_data->tv_sec = cpu_to_le64(crash_data->timestamp.tv_sec);
+	dump_data->tv_nsec = cpu_to_le64(crash_data->timestamp.tv_nsec);
+
+	if (test_bit(ATH11K_FW_CRASH_DUMP_RAM_DATA, &ath11k_coredump_mask) &&
+	    crash_data->ramdump_buf) {
+		dump_tlv = (struct ath11k_tlv_dump_data *)(buf + sofar);
+		dump_tlv->type = cpu_to_le32(ATH11K_FW_CRASH_DUMP_RAM_DATA);
+		dump_tlv->tlv_len = cpu_to_le32(crash_data->ramdump_buf_len);
+		if (crash_data->ramdump_buf_len) {
+			memcpy(dump_tlv->tlv_data, crash_data->ramdump_buf,
+			       crash_data->ramdump_buf_len);
+			sofar += sizeof(*dump_tlv) + crash_data->ramdump_buf_len;
+		}
+	}
+
+	mutex_unlock(&ab->dump_mutex);
+
+	return dump_data;
+}
+
+int ath11k_coredump_submit(struct ath11k_base *ab)
+{
+	struct ath11k_dump_file_data *dump;
+
+	if (ath11k_coredump_mask == 0 || !ab->coredump.fw_crash_data)
+		/* coredump disabled */
+		return 0;
+
+	dump = ath11k_coredump_build(ab);
+	if (!dump) {
+		ath11k_warn(ab, "no crash dump data found for devcoredump");
+		return -ENODATA;
+	}
+
+	dev_coredumpv(ab->dev, dump, le32_to_cpu(dump->len), GFP_KERNEL);
+
+	return 0;
+}
+
+int ath11k_coredump_create(struct ath11k_base *ab)
+{
+	struct ath11k_fw_crash_data *crash_data;
+
+	if (ath11k_coredump_mask == 0)
+		/* coredump disabled */
+		return 0;
+
+	ab->coredump.fw_crash_data = vzalloc(sizeof(*ab->coredump.fw_crash_data));
+	if (!ab->coredump.fw_crash_data)
+		return -ENOMEM;
+
+	crash_data = ab->coredump.fw_crash_data;
+
+	if (test_bit(ATH11K_FW_CRASH_DUMP_RAM_DATA, &ath11k_coredump_mask)) {
+		crash_data->ramdump_buf_len = ath11k_coredump_get_ramdump_size(ab);
+
+		if (!crash_data->ramdump_buf_len)
+			return 0;
+
+		crash_data->ramdump_buf = vzalloc(crash_data->ramdump_buf_len);
+		if (!crash_data->ramdump_buf) {
+			ath11k_warn(ab, "failed to allocate ramdump buffer\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+void ath11k_coredump_destroy(struct ath11k_base *ab)
+{
+	struct ath11k_fw_crash_data *crash_data = ab->coredump.fw_crash_data;
+
+	if (ath11k_coredump_mask == 0)
+		/* coredump disabled */
+		return;
+
+	if (crash_data->ramdump_buf) {
+		vfree(crash_data->ramdump_buf);
+		crash_data->ramdump_buf = NULL;
+		crash_data->ramdump_buf_len = 0;
+	}
+
+	vfree(crash_data);
+	ab->coredump.fw_crash_data = NULL;
+}
diff --git a/drivers/net/wireless/ath/ath11k/coredump.h b/drivers/net/wireless/ath/ath11k/coredump.h
new file mode 100644
index 000000000000..47fe4b66cd25
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/coredump.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _COREDUMP_H_
+#define _COREDUMP_H_
+
+#include "core.h"
+
+#define ATH11K_FW_CRASH_DUMP_VERSION 1
+
+enum ath11k_fw_crash_dump_type {
+	/* contains multiple struct ath11k_ramdump_hdr */
+	ATH11K_FW_CRASH_DUMP_RAM_DATA = 0,
+	ATH11K_FW_CRASH_DUMP_MAX,
+};
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
+
+	__le32 len;
+
+	/* file dump version */
+	__le32 version;
+
+	/* some info we can get from ath11k_base struct that might help */
+
+	guid_t guid;
+
+	__le32 hw_rev;
+
+	__le32 bus_type;
+
+	/* firmware version string */
+	char fw_ver[ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01 + 1];
+
+	/* Kernel related information */
+
+	/* time-of-day stamp */
+	__le64 tv_sec;
+
+	/* time-of-day stamp, nano-seconds */
+	__le64 tv_nsec;
+
+	/* LINUX_VERSION_CODE */
+	__le32 kernel_ver_code;
+
+	/* VERMAGIC_STRING */
+	char kernel_ver[64];
+
+	/* room for growth w/out changing binary format */
+	u8 unused[128];
+
+	/* struct ath11k_tlv_dump_data + more */
+	u8 data[];
+} __packed;
+
+struct ath11k_ramdump_hdr {
+	/* enum ath11k_mem_region_type */
+	__le32 region_type;
+
+	__le64 start;
+
+	/* length of payload data, not including this header */
+	__le32 length;
+
+	u8 data[];
+};
+
+/* part of user space ABI */
+enum ath11k_mem_region_type {
+	ATH11K_MEM_REGION_TYPE_MSA = 1,
+};
+
+struct ath11k_mem_region {
+	enum ath11k_mem_region_type type;
+	u32 start;
+	u32 len;
+
+	const char *name;
+};
+
+/* Contains the memory layout of a hardware version identified with the
+ * hw_rev, split into regions.
+ */
+struct ath11k_hw_mem_layout {
+	u32 hw_rev;
+	enum ath11k_bus bus;
+
+	struct {
+		const struct ath11k_mem_region *regions;
+		int size;
+	} region_table;
+};
+
+#ifdef CONFIG_DEV_COREDUMP
+
+int ath11k_coredump_submit(struct  ath11k_base *ab);
+struct ath11k_fw_crash_data *ath11k_coredump_new(struct  ath11k_base *ab);
+int ath11k_coredump_create(struct  ath11k_base *ab);
+void ath11k_coredump_destroy(struct  ath11k_base *ab);
+const struct ath11k_hw_mem_layout *
+ath11k_coredump_get_mem_layout(struct  ath11k_base *ab);
+
+#else /* CONFIG_DEV_COREDUMP */
+
+static inline int ath11k_coredump_submit(struct  ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline struct ath11k_fw_crash_data *ath11k_coredump_new(struct  ath11k_base *ab)
+{
+	return NULL;
+}
+
+static inline int ath11k_coredump_create(struct  ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_coredump_destroy(struct  ath11k_base *ab)
+{
+}
+
+static inline const struct ath11k_hw_mem_layout *
+ath11k_coredump_get_mem_layout(struct  ath11k_base *ab)
+{
+	return NULL;
+}
+#endif /* CONFIG_DEV_COREDUMP */
+
+#endif /* _COREDUMP_H_ */
-- 
2.17.1

