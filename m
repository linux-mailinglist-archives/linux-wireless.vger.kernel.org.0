Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0870E49DA21
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiA0FZo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:25:44 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6584 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiA0FZn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261144; x=1674797144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rmykqMjVL3X/SvNYggdXjCvrV9IVFsUb2QHBnNy1LvA=;
  b=SSljX1fo7y18k6mbtBWhp8qeCmDcuI4OBNiqkp5rEadRm9g0+prwLp1A
   9uFapMKbCdvLSHOKDzEK8Vrm14Z+zaplnHvIcw0TzC24Yzi/TbeU2+yoM
   YaEreNQTchH+v3rYLkfFYZtnEzaMyriXCCKP0Ihxxf0fRw4pFvsBgO4M2
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Jan 2022 21:25:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:25:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:25:25 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:25:23 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 2/2] ath11k: Add WoW support for WCN6750
Date:   Thu, 27 Jan 2022 10:54:53 +0530
Message-ID: <1643261093-12400-3-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261093-12400-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261093-12400-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for WoW on WCN6750 chipset.

Unlike other chips where WoW exit happens after sending WoW wakeup
WMI command, exit from WoW suspend in the case of WCN6750 happens
upon sending a WoW exit SMP2P (Shared memory point to point) message
to the firmware.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c     | 121 +++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h     |  15 +++-
 drivers/net/wireless/ath/ath11k/core.c    |   9 ++-
 drivers/net/wireless/ath/ath11k/hw.h      |   3 +-
 drivers/net/wireless/ath/ath11k/pci_cmn.c |  34 ++++++++-
 drivers/net/wireless/ath/ath11k/pci_cmn.h |   6 +-
 drivers/net/wireless/ath/ath11k/wow.c     |   8 ++
 7 files changed, 189 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 7cb13a0..df905b8 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -16,6 +16,8 @@
 #include "hif.h"
 #include <linux/remoteproc.h>
 #include "pci_cmn.h"
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/smem_state.h>
 
 static const struct of_device_id ath11k_ahb_of_match[] = {
 	/* TODO: Should we change the compatible string to something similar
@@ -655,6 +657,80 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	return 0;
 }
 
+static int ath11k_ahb_hif_suspend(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	u32 wake_irq;
+	u32 value;
+	int ret;
+
+	if (!device_may_wakeup(ab->dev))
+		return -EPERM;
+
+	wake_irq = ab->irq_num[ATH11K_PCI_IRQ_CE0_OFFSET + ATH11K_PCI_CE_WAKE_IRQ];
+
+	ret = enable_irq_wake(wake_irq);
+	if (ret) {
+		ath11k_err(ab, "failed to enable wakeup irq :%d\n", ret);
+		return ret;
+	}
+
+	value = ab_ahb->smp2p_info.seq_no++;
+	value <<= ATH11K_AHB_SMP2P_SMEM_SEQ_NO_POS;
+	value |= ATH11K_AHB_POWER_SAVE_ENTER;
+	ret = qcom_smem_state_update_bits(ab_ahb->smp2p_info.smem_state,
+					  ATH11K_AHB_SMP2P_SMEM_VALUE_MASK, value);
+	if (ret) {
+		ath11k_err(ab, "failed to send smp2p power save enter cmd :%d\n", ret);
+		return ret;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "ahb device suspended\n");
+
+	return ret;
+}
+
+static int ath11k_ahb_hif_resume(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	u32 wake_irq;
+	u32 value;
+	int ret;
+
+	if (!device_may_wakeup(ab->dev))
+		return -EPERM;
+
+	wake_irq = ab->irq_num[ATH11K_PCI_IRQ_CE0_OFFSET + ATH11K_PCI_CE_WAKE_IRQ];
+
+	ret = disable_irq_wake(wake_irq);
+	if (ret) {
+		ath11k_err(ab, "failed to disable wakeup irq: %d\n", ret);
+		return ret;
+	}
+
+	reinit_completion(&ab->wow.wakeup_completed);
+
+	value = ab_ahb->smp2p_info.seq_no++;
+	value <<= ATH11K_AHB_SMP2P_SMEM_SEQ_NO_POS;
+	value |= ATH11K_AHB_POWER_SAVE_EXIT;
+	ret = qcom_smem_state_update_bits(ab_ahb->smp2p_info.smem_state,
+					  ATH11K_AHB_SMP2P_SMEM_VALUE_MASK, value);
+	if (ret) {
+		ath11k_err(ab, "failed to send smp2p power save enter cmd :%d\n", ret);
+		return ret;
+	}
+
+	ret = wait_for_completion_timeout(&ab->wow.wakeup_completed, 3 * HZ);
+	if (ret == 0) {
+		ath11k_warn(ab, "timed out while waiting for wow wakeup completion\n");
+		return -ETIMEDOUT;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "ahb device resumed\n");
+
+	return 0;
+}
+
 static const struct ath11k_hif_ops hif_ops_ipq8074 = {
 	.start = ath11k_ahb_start,
 	.stop = ath11k_ahb_stop,
@@ -679,6 +755,10 @@ static const struct ath11k_hif_ops hif_ops_wcn6750 = {
 	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.suspend = ath11k_ahb_hif_suspend,
+	.resume = ath11k_ahb_hif_resume,
+	.ce_irq_enable = ath11k_pci_enable_ce_irqs_except_wake_irq,
+	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
 };
 
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
@@ -753,6 +833,35 @@ static int ath11k_ahb_setup_msi_resources(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_ahb_setup_smp2p_handle(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+
+	if (!ab->hw_params.smp2p_wow_exit)
+		return 0;
+
+	ab_ahb->smp2p_info.smem_state =
+		qcom_smem_state_get(ab->dev, "wlan-smp2p-out",
+				    &ab_ahb->smp2p_info.smem_bit);
+	if (IS_ERR(ab_ahb->smp2p_info.smem_state)) {
+		ath11k_err(ab, "failed to fetch smem state: %ld\n",
+			   PTR_ERR(ab_ahb->smp2p_info.smem_state));
+		return PTR_ERR(ab_ahb->smp2p_info.smem_state);
+	}
+
+	return 0;
+}
+
+static void ath11k_ahb_release_smp2p_handle(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+
+	if (!ab->hw_params.smp2p_wow_exit)
+		return;
+
+	qcom_smem_state_put(ab_ahb->smp2p_info.smem_state);
+}
+
 static int ath11k_ahb_setup_resources(struct ath11k_base *ab)
 {
 	struct platform_device *pdev = ab->pdev;
@@ -996,10 +1105,14 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fw_deinit;
 
-	ret = ath11k_hal_srng_init(ab);
+	ret = ath11k_ahb_setup_smp2p_handle(ab);
 	if (ret)
 		goto err_fw_deinit;
 
+	ret = ath11k_hal_srng_init(ab);
+	if (ret)
+		goto err_release_smp2p_handle;
+
 	ret = ath11k_ce_alloc_pipes(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to allocate ce pipes: %d\n", ret);
@@ -1036,6 +1149,9 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 err_hal_srng_deinit:
 	ath11k_hal_srng_deinit(ab);
 
+err_release_smp2p_handle:
+	ath11k_ahb_release_smp2p_handle(ab);
+
 err_fw_deinit:
 	ath11k_ahb_fw_resource_deinit(ab);
 
@@ -1074,6 +1190,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 qmi_fail:
 	ath11k_ahb_free_irq(ab);
 	ath11k_hal_srng_deinit(ab);
+	ath11k_ahb_release_smp2p_handle(ab);
 	ath11k_ahb_fw_resource_deinit(ab);
 	ath11k_ce_free_pipes(ab);
 	ath11k_core_free(ab);
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index 4c7872d..31fcb7c 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH11K_AHB_H
 #define ATH11K_AHB_H
@@ -9,6 +9,14 @@
 #include "core.h"
 
 #define ATH11K_AHB_RECOVERY_TIMEOUT (3 * HZ)
+#define ATH11K_AHB_SMP2P_SMEM_SEQ_NO_POS	16
+#define ATH11K_AHB_SMP2P_SMEM_VALUE_MASK	0xFFFFFFFF
+
+enum ath11k_ahb_smp2p_msg_id {
+	ATH11K_AHB_POWER_SAVE_ENTER = 1,
+	ATH11K_AHB_POWER_SAVE_EXIT,
+};
+
 struct ath11k_base;
 
 struct ath11k_ahb {
@@ -22,6 +30,11 @@ struct ath11k_ahb {
 		u32 ce_size;
 		bool use_tz;
 	} fw;
+	struct {
+		unsigned short seq_no;
+		unsigned int smem_bit;
+		struct qcom_smem_state *smem_state;
+	} smp2p_info;
 };
 
 static inline struct ath11k_ahb *ath11k_ahb_priv(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a56d0c9..3a10e22 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -97,6 +97,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = true,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -160,6 +161,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = true,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -222,6 +224,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -284,6 +287,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = true,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -346,6 +350,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -407,6 +412,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -468,6 +474,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = false,
+		.smp2p_wow_exit = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index a220c9a..4a5013e 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HW_H
@@ -192,6 +192,7 @@ struct ath11k_hw_params {
 	bool alloc_cacheable_memory;
 	bool supports_rssi_stats;
 	bool fw_wmi_diag_event;
+	bool smp2p_wow_exit;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.c b/drivers/net/wireless/ath/ath11k/pci_cmn.c
index 047fcd7..9616973 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.c
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -724,3 +724,35 @@ int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 
 	return 0;
 }
+
+void ath11k_pci_enable_ce_irqs_except_wake_irq(struct ath11k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR ||
+		    i == ATH11K_PCI_CE_WAKE_IRQ)
+			continue;
+		ath11k_pci_ce_irq_enable(ab, i);
+	}
+}
+
+void ath11k_pci_disable_ce_irqs_except_wake_irq(struct ath11k_base *ab)
+{
+	int i;
+	int irq_idx;
+	struct ath11k_ce_pipe *ce_pipe;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		ce_pipe = &ab->ce.ce_pipe[i];
+		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
+
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR ||
+		    i == ATH11K_PCI_CE_WAKE_IRQ)
+			continue;
+
+		disable_irq_nosync(ab->irq_num[irq_idx]);
+		synchronize_irq(ab->irq_num[irq_idx]);
+		tasklet_kill(&ce_pipe->intr_tq);
+	}
+}
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.h b/drivers/net/wireless/ath/ath11k/pci_cmn.h
index 8f99be7..dbd7e24 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.h
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH11K_PCI_CMN_H
@@ -13,6 +13,8 @@
 #define ATH11K_PCI_IRQ_CE0_OFFSET	3
 #define ATH11K_PCI_IRQ_DP_OFFSET	14
 
+#define ATH11K_PCI_CE_WAKE_IRQ	2
+
 #define ATH11K_PCI_WINDOW_ENABLE_BIT		0x40000000
 #define ATH11K_PCI_WINDOW_REG_ADDRESS		0x310c
 #define ATH11K_PCI_WINDOW_VALUE_MASK		GENMASK(24, 19)
@@ -44,4 +46,6 @@ int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab);
 void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab);
 int ath11k_pci_get_msi_config(struct ath11k_base *ab);
+void ath11k_pci_enable_ce_irqs_except_wake_irq(struct ath11k_base *ab);
+void ath11k_pci_disable_ce_irqs_except_wake_irq(struct ath11k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index cdb154f..0788c9b 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -67,6 +68,13 @@ int ath11k_wow_wakeup(struct ath11k_base *ab)
 	struct ath11k *ar = ath11k_ab_to_ar(ab, 0);
 	int ret;
 
+	/* In the case of WCN6750, WoW wakeup is done
+	 * by sending SMP2P power save exit message
+	 * to the target processor.
+	 */
+	if (ab->hw_params.smp2p_wow_exit)
+		return 0;
+
 	reinit_completion(&ab->wow.wakeup_completed);
 
 	ret = ath11k_wmi_wow_host_wakeup_ind(ar);
-- 
2.7.4

