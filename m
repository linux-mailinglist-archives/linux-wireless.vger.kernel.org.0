Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B64445ABAE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhKWSyc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:54:32 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:21971 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhKWSya (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693482; x=1669229482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5vNZj5GDE3mJ9qFjAmhVGeSJYE2aPQiajMVuJBowif8=;
  b=ByOdahpVALB9jvEM+CzS9ilnMffq5jWwKb+ms2hie3KUIs3/WYbfO+D4
   rSUK3szWnOwpC3VoSlkP3WngRBx/sqFfMB3TJ4V4uqrnHE6zwxMOaNzJJ
   8t9ouNZVoIEEgwQL9wrvwRXI+qBGtSlDWqsEVcix/WKxsjr1ZEZrGy1YC
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Nov 2021 10:51:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:51:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:21 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:19 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 02/19] ath11k: Refactor PCI code to support hybrid bus devices
Date:   Wed, 24 Nov 2021 00:20:17 +0530
Message-ID: <1637693434-15462-3-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlike other ATH11K PCIe devices which are enumerated by APSS
processor (Application Processor SubSystem), WCN6750 gets
enumerated by the WPSS Q6 processor (Wireless Processor SubSystem);
In simple terms, though WCN6750 is PCIe device, it is not attached
to the APSS processor, APSS will not know of such a device being
present in the system and therefore WCN6750 will be registered as
a platform device to the kernel core like other supported AHB
devices.

WCN6750 uses both AHB and PCI APIs for it's operation, it uses
AHB APIs for device probe/boot and PCI APIs for device setup
and register accesses; Because of this nature, it is referred
as a hybrid bus device.

Refactor PCI code to support hybrid bus devices like WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Makefile  |   2 +-
 drivers/net/wireless/ath/ath11k/mhi.c     |   6 +-
 drivers/net/wireless/ath/ath11k/pci.c     | 728 +----------------------------
 drivers/net/wireless/ath/ath11k/pci.h     |  41 --
 drivers/net/wireless/ath/ath11k/pci_cmn.c | 737 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci_cmn.h |  53 +++
 6 files changed, 797 insertions(+), 770 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/pci_cmn.c
 create mode 100644 drivers/net/wireless/ath/ath11k/pci_cmn.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index c1fce41..71376da 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
 
 obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
-ath11k_pci-y += mhi.o pci.o
+ath11k_pci-y += mhi.o pci.o pci_cmn.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index d0f94a7..7872cda 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
-/* Copyright (c) 2020 The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
 #include <linux/msi.h>
 #include <linux/pci.h>
@@ -8,6 +11,7 @@
 #include "debug.h"
 #include "mhi.h"
 #include "pci.h"
+#include "pci_cmn.h"
 
 #define MHI_TIMEOUT_DEFAULT_MS	90000
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index a95616f..d1f62cf 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -13,6 +13,7 @@
 #include "hif.h"
 #include "mhi.h"
 #include "debug.h"
+#include "pci_cmn.h"
 
 #define ATH11K_PCI_BAR_NUM		0
 #define ATH11K_PCI_DMA_MASK		32
@@ -75,76 +76,6 @@ static const struct ath11k_msi_config msi_config_one_msi = {
 	},
 };
 
-static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
-	"bhi",
-	"mhi-er0",
-	"mhi-er1",
-	"ce0",
-	"ce1",
-	"ce2",
-	"ce3",
-	"ce4",
-	"ce5",
-	"ce6",
-	"ce7",
-	"ce8",
-	"ce9",
-	"ce10",
-	"ce11",
-	"host2wbm-desc-feed",
-	"host2reo-re-injection",
-	"host2reo-command",
-	"host2rxdma-monitor-ring3",
-	"host2rxdma-monitor-ring2",
-	"host2rxdma-monitor-ring1",
-	"reo2ost-exception",
-	"wbm2host-rx-release",
-	"reo2host-status",
-	"reo2host-destination-ring4",
-	"reo2host-destination-ring3",
-	"reo2host-destination-ring2",
-	"reo2host-destination-ring1",
-	"rxdma2host-monitor-destination-mac3",
-	"rxdma2host-monitor-destination-mac2",
-	"rxdma2host-monitor-destination-mac1",
-	"ppdu-end-interrupts-mac3",
-	"ppdu-end-interrupts-mac2",
-	"ppdu-end-interrupts-mac1",
-	"rxdma2host-monitor-status-ring-mac3",
-	"rxdma2host-monitor-status-ring-mac2",
-	"rxdma2host-monitor-status-ring-mac1",
-	"host2rxdma-host-buf-ring-mac3",
-	"host2rxdma-host-buf-ring-mac2",
-	"host2rxdma-host-buf-ring-mac1",
-	"rxdma2host-destination-ring-mac3",
-	"rxdma2host-destination-ring-mac2",
-	"rxdma2host-destination-ring-mac1",
-	"host2tcl-input-ring4",
-	"host2tcl-input-ring3",
-	"host2tcl-input-ring2",
-	"host2tcl-input-ring1",
-	"wbm2host-tx-completions-ring3",
-	"wbm2host-tx-completions-ring2",
-	"wbm2host-tx-completions-ring1",
-	"tcl2host-status-ring",
-};
-
-static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
-{
-	struct ath11k_base *ab = ab_pci->ab;
-
-	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
-
-	lockdep_assert_held(&ab_pci->window_lock);
-
-	if (window != ab_pci->register_window) {
-		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
-			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
-		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
-		ab_pci->register_window = window;
-	}
-}
-
 static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
 {
 	u32 umac_window;
@@ -159,103 +90,6 @@ static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
 		  ab_pci->ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
 }
 
-static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
-					      u32 offset)
-{
-	u32 window_start;
-
-	/* If offset lies within DP register range, use 3rd window */
-	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = 3 * ATH11K_PCI_WINDOW_START;
-	/* If offset lies within CE register range, use 2nd window */
-	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = 2 * ATH11K_PCI_WINDOW_START;
-	else
-		window_start = ATH11K_PCI_WINDOW_START;
-
-	return window_start;
-}
-
-void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 window_start;
-
-	/* for offset beyond BAR + 4K - 32, may
-	 * need to wakeup MHI to access.
-	 */
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
-
-	if (offset < ATH11K_PCI_WINDOW_START) {
-		iowrite32(value, ab->mem  + offset);
-	} else {
-		if (ab->bus_params.static_window_map)
-			window_start = ath11k_pci_get_window_start(ab, offset);
-		else
-			window_start = ATH11K_PCI_WINDOW_START;
-
-		if (window_start == ATH11K_PCI_WINDOW_START) {
-			spin_lock_bh(&ab_pci->window_lock);
-			ath11k_pci_select_window(ab_pci, offset);
-			iowrite32(value, ab->mem + window_start +
-				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-			spin_unlock_bh(&ab_pci->window_lock);
-		} else {
-			iowrite32(value, ab->mem + window_start +
-				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-		}
-	}
-
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
-}
-
-u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 val, window_start;
-
-	/* for offset beyond BAR + 4K - 32, may
-	 * need to wakeup MHI to access.
-	 */
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
-
-	if (offset < ATH11K_PCI_WINDOW_START) {
-		val = ioread32(ab->mem + offset);
-	} else {
-		if (ab->bus_params.static_window_map)
-			window_start = ath11k_pci_get_window_start(ab, offset);
-		else
-			window_start = ATH11K_PCI_WINDOW_START;
-
-		if (window_start == ATH11K_PCI_WINDOW_START) {
-			spin_lock_bh(&ab_pci->window_lock);
-			ath11k_pci_select_window(ab_pci, offset);
-			val = ioread32(ab->mem + window_start +
-				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-			spin_unlock_bh(&ab_pci->window_lock);
-		} else {
-			val = ioread32(ab->mem + window_start +
-				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-		}
-	}
-
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
-
-	return val;
-}
-
 static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 {
 	u32 val, delay;
@@ -452,456 +286,6 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	ath11k_mhi_set_mhictrl_reset(ab);
 }
 
-int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-
-	return pci_irq_vector(pci_dev, vector);
-}
-
-void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
-				u32 *msi_addr_hi)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
-
-	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
-			      msi_addr_lo);
-
-	if (test_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags)) {
-		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
-				      msi_addr_hi);
-	} else {
-		*msi_addr_hi = 0;
-	}
-}
-
-int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
-				       int *num_vectors, u32 *user_base_data,
-				       u32 *base_vector)
-{
-	struct ath11k_base *ab = ab_pci->ab;
-	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
-	int idx;
-
-	for (idx = 0; idx < msi_config->total_users; idx++) {
-		if (strcmp(user_name, msi_config->users[idx].name) == 0) {
-			*num_vectors = msi_config->users[idx].num_vectors;
-			*base_vector =  msi_config->users[idx].base_vector;
-			*user_base_data = *base_vector + ab_pci->msi_ep_base_data;
-
-			ath11k_dbg(ab, ATH11K_DBG_PCI,
-				   "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
-				   user_name, *num_vectors, *user_base_data,
-				   *base_vector);
-
-			return 0;
-		}
-	}
-
-	ath11k_err(ab, "Failed to find MSI assignment for %s!\n", user_name);
-
-	return -EINVAL;
-}
-
-void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
-{
-	u32 i, msi_data_idx;
-
-	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
-		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-			continue;
-
-		if (ce_id == i)
-			break;
-
-		msi_data_idx++;
-	}
-	*msi_idx = msi_data_idx;
-}
-
-int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
-				   int *num_vectors, u32 *user_base_data,
-				   u32 *base_vector)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-
-	return ath11k_pci_get_user_msi_assignment(ab_pci, user_name,
-						  num_vectors, user_base_data,
-						  base_vector);
-}
-
-static void ath11k_pci_free_ext_irq(struct ath11k_base *ab)
-{
-	int i, j;
-
-	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
-
-		for (j = 0; j < irq_grp->num_irq; j++)
-			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
-
-		netif_napi_del(&irq_grp->napi);
-	}
-}
-
-void ath11k_pci_free_irq(struct ath11k_base *ab)
-{
-	int i, irq_idx;
-
-	for (i = 0; i < ab->hw_params.ce_count; i++) {
-		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-			continue;
-		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
-		free_irq(ab->irq_num[irq_idx], &ab->ce.ce_pipe[i]);
-	}
-
-	ath11k_pci_free_ext_irq(ab);
-}
-
-static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 irq_idx;
-
-	/* In case of one MSI vector, we handle irq enable/disable in a
-	 * uniform way since we only have one irq
-	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		return;
-
-	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
-	enable_irq(ab->irq_num[irq_idx]);
-}
-
-static void ath11k_pci_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 irq_idx;
-
-	/* In case of one MSI vector, we handle irq enable/disable in a
-	 * uniform way since we only have one irq
-	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		return;
-
-	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
-	disable_irq_nosync(ab->irq_num[irq_idx]);
-}
-
-static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
-{
-	int i;
-
-	clear_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
-
-	for (i = 0; i < ab->hw_params.ce_count; i++) {
-		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-			continue;
-		ath11k_pci_ce_irq_disable(ab, i);
-	}
-}
-
-static void ath11k_pci_sync_ce_irqs(struct ath11k_base *ab)
-{
-	int i;
-	int irq_idx;
-
-	for (i = 0; i < ab->hw_params.ce_count; i++) {
-		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-			continue;
-
-		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
-		synchronize_irq(ab->irq_num[irq_idx]);
-	}
-}
-
-static void ath11k_pci_ce_tasklet(struct tasklet_struct *t)
-{
-	struct ath11k_ce_pipe *ce_pipe = from_tasklet(ce_pipe, t, intr_tq);
-	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
-
-	ath11k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
-
-	enable_irq(ce_pipe->ab->irq_num[irq_idx]);
-}
-
-static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
-{
-	struct ath11k_ce_pipe *ce_pipe = arg;
-	struct ath11k_base *ab = ce_pipe->ab;
-	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
-
-	if (!test_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags))
-		return IRQ_HANDLED;
-
-	/* last interrupt received for this CE */
-	ce_pipe->timestamp = jiffies;
-
-	disable_irq_nosync(ab->irq_num[irq_idx]);
-
-	tasklet_schedule(&ce_pipe->intr_tq);
-
-	return IRQ_HANDLED;
-}
-
-static void ath11k_pci_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
-	int i;
-
-	/* In case of one MSI vector, we handle irq enable/disable
-	 * in a uniform way since we only have one irq
-	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		return;
-
-	for (i = 0; i < irq_grp->num_irq; i++)
-		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
-}
-
-static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
-{
-	int i;
-
-	clear_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &sc->dev_flags);
-
-	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &sc->ext_irq_grp[i];
-
-		ath11k_pci_ext_grp_disable(irq_grp);
-
-		napi_synchronize(&irq_grp->napi);
-		napi_disable(&irq_grp->napi);
-	}
-}
-
-static void ath11k_pci_ext_grp_enable(struct ath11k_ext_irq_grp *irq_grp)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
-	int i;
-
-	/* In case of one MSI vector, we handle irq enable/disable in a
-	 * uniform way since we only have one irq
-	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		return;
-
-	for (i = 0; i < irq_grp->num_irq; i++)
-		enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
-}
-
-void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
-{
-	int i;
-
-	set_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
-
-	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
-
-		napi_enable(&irq_grp->napi);
-		ath11k_pci_ext_grp_enable(irq_grp);
-	}
-}
-
-static void ath11k_pci_sync_ext_irqs(struct ath11k_base *ab)
-{
-	int i, j, irq_idx;
-
-	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
-
-		for (j = 0; j < irq_grp->num_irq; j++) {
-			irq_idx = irq_grp->irqs[j];
-			synchronize_irq(ab->irq_num[irq_idx]);
-		}
-	}
-}
-
-void ath11k_pci_ext_irq_disable(struct ath11k_base *ab)
-{
-	__ath11k_pci_ext_irq_disable(ab);
-	ath11k_pci_sync_ext_irqs(ab);
-}
-
-static int ath11k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
-{
-	struct ath11k_ext_irq_grp *irq_grp = container_of(napi,
-						struct ath11k_ext_irq_grp,
-						napi);
-	struct ath11k_base *ab = irq_grp->ab;
-	int work_done;
-	int i;
-
-	work_done = ath11k_dp_service_srng(ab, irq_grp, budget);
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
-		for (i = 0; i < irq_grp->num_irq; i++)
-			enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
-	}
-
-	if (work_done > budget)
-		work_done = budget;
-
-	return work_done;
-}
-
-static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
-{
-	struct ath11k_ext_irq_grp *irq_grp = arg;
-	struct ath11k_base *ab = irq_grp->ab;
-	int i;
-
-	if (!test_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
-		return IRQ_HANDLED;
-
-	ath11k_dbg(irq_grp->ab, ATH11K_DBG_PCI, "ext irq:%d\n", irq);
-
-	/* last interrupt received for this group */
-	irq_grp->timestamp = jiffies;
-
-	for (i = 0; i < irq_grp->num_irq; i++)
-		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
-
-	napi_schedule(&irq_grp->napi);
-
-	return IRQ_HANDLED;
-}
-
-static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	int i, j, ret, num_vectors = 0;
-	u32 user_base_data = 0, base_vector = 0;
-
-	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
-						 &num_vectors,
-						 &user_base_data,
-						 &base_vector);
-	if (ret < 0)
-		return ret;
-
-	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
-		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
-		u32 num_irq = 0;
-
-		irq_grp->ab = ab;
-		irq_grp->grp_id = i;
-		init_dummy_netdev(&irq_grp->napi_ndev);
-		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
-			       ath11k_pci_ext_grp_napi_poll, NAPI_POLL_WEIGHT);
-
-		if (ab->hw_params.ring_mask->tx[i] ||
-		    ab->hw_params.ring_mask->rx[i] ||
-		    ab->hw_params.ring_mask->rx_err[i] ||
-		    ab->hw_params.ring_mask->rx_wbm_rel[i] ||
-		    ab->hw_params.ring_mask->reo_status[i] ||
-		    ab->hw_params.ring_mask->rxdma2host[i] ||
-		    ab->hw_params.ring_mask->host2rxdma[i] ||
-		    ab->hw_params.ring_mask->rx_mon_status[i]) {
-			num_irq = 1;
-		}
-
-		irq_grp->num_irq = num_irq;
-		irq_grp->irqs[0] = ATH11K_PCI_IRQ_DP_OFFSET + i;
-
-		for (j = 0; j < irq_grp->num_irq; j++) {
-			int irq_idx = irq_grp->irqs[j];
-			int vector = (i % num_vectors) + base_vector;
-			int irq = ath11k_pci_get_msi_irq(ab->dev, vector);
-
-			ab->irq_num[irq_idx] = irq;
-
-			ath11k_dbg(ab, ATH11K_DBG_PCI,
-				   "irq:%d group:%d\n", irq, i);
-
-			irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
-			ret = request_irq(irq, ath11k_pci_ext_interrupt_handler,
-					  ab_pci->irq_flags,
-					  "DP_EXT_IRQ", irq_grp);
-			if (ret) {
-				ath11k_err(ab, "failed request irq %d: %d\n",
-					   vector, ret);
-				return ret;
-			}
-		}
-		ath11k_pci_ext_grp_disable(irq_grp);
-	}
-
-	return 0;
-}
-
-int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
-				     const struct cpumask *m)
-{
-	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		return 0;
-
-	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
-}
-
-int ath11k_pci_config_irq(struct ath11k_base *ab)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	struct ath11k_ce_pipe *ce_pipe;
-	u32 msi_data_start;
-	u32 msi_data_count, msi_data_idx;
-	u32 msi_irq_start;
-	unsigned int msi_data;
-	int irq, i, ret, irq_idx;
-
-	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab),
-						 "CE", &msi_data_count,
-						 &msi_data_start, &msi_irq_start);
-	if (ret)
-		return ret;
-
-	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
-	if (ret) {
-		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
-		return ret;
-	}
-
-	/* Configure CE irqs */
-	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
-		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-			continue;
-
-		msi_data = (msi_data_idx % msi_data_count) + msi_irq_start;
-		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
-		ce_pipe = &ab->ce.ce_pipe[i];
-
-		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
-
-		tasklet_setup(&ce_pipe->intr_tq, ath11k_pci_ce_tasklet);
-
-		ret = request_irq(irq, ath11k_pci_ce_interrupt_handler,
-				  ab_pci->irq_flags, irq_name[irq_idx],
-				  ce_pipe);
-		if (ret) {
-			ath11k_err(ab, "failed to request irq %d: %d\n",
-				   irq_idx, ret);
-			goto err_irq_affinity_cleanup;
-		}
-
-		ab->irq_num[irq_idx] = irq;
-		msi_data_idx++;
-
-		ath11k_pci_ce_irq_disable(ab, i);
-	}
-
-	ret = ath11k_pci_ext_irq_config(ab);
-	if (ret)
-		goto err_irq_affinity_cleanup;
-
-	return 0;
-
-err_irq_affinity_cleanup:
-	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	return ret;
-}
-
 static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 {
 	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
@@ -917,19 +301,6 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 				    &cfg->shadow_reg_v2_len);
 }
 
-void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
-{
-	int i;
-
-	set_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
-
-	for (i = 0; i < ab->hw_params.ce_count; i++) {
-		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-			continue;
-		ath11k_pci_ce_irq_enable(ab, i);
-	}
-}
-
 static void ath11k_pci_msi_config(struct ath11k_pci *ab_pci, bool enable)
 {
 	struct pci_dev *dev = ab_pci->pdev;
@@ -1129,13 +500,6 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
 
-void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
-{
-	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-					   ab_pci->link_ctl);
-}
-
 static int ath11k_pci_power_up(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
@@ -1198,53 +562,6 @@ static int ath11k_pci_hif_resume(struct ath11k_base *ab)
 	return 0;
 }
 
-static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
-{
-	int i;
-
-	for (i = 0; i < ab->hw_params.ce_count; i++) {
-		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
-
-		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-			continue;
-
-		tasklet_kill(&ce_pipe->intr_tq);
-	}
-}
-
-void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab)
-{
-	ath11k_pci_ce_irqs_disable(ab);
-	ath11k_pci_sync_ce_irqs(ab);
-	ath11k_pci_kill_tasklets(ab);
-}
-
-void ath11k_pci_stop(struct ath11k_base *ab)
-{
-	ath11k_pci_ce_irq_disable_sync(ab);
-	ath11k_ce_cleanup_pipes(ab);
-}
-
-int ath11k_pci_start(struct ath11k_base *ab)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-
-	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
-
-	/* TODO: for now don't restore ASPM in case of single MSI
-	 * vector as MHI register reading in M2 causes system hang.
-	 */
-	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		ath11k_pci_aspm_restore(ab_pci);
-	else
-		ath11k_info(ab, "leaving PCI ASPM disabled to avoid MHI M2 problems\n");
-
-	ath11k_pci_ce_irqs_enable(ab);
-	ath11k_ce_rx_post_buf(ab);
-
-	return 0;
-}
-
 static void ath11k_pci_hif_ce_irq_enable(struct ath11k_base *ab)
 {
 	ath11k_pci_ce_irqs_enable(ab);
@@ -1255,49 +572,6 @@ static void ath11k_pci_hif_ce_irq_disable(struct ath11k_base *ab)
 	ath11k_pci_ce_irq_disable_sync(ab);
 }
 
-int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
-				   u8 *ul_pipe, u8 *dl_pipe)
-{
-	const struct service_to_pipe *entry;
-	bool ul_set = false, dl_set = false;
-	int i;
-
-	for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
-		entry = &ab->hw_params.svc_to_ce_map[i];
-
-		if (__le32_to_cpu(entry->service_id) != service_id)
-			continue;
-
-		switch (__le32_to_cpu(entry->pipedir)) {
-		case PIPEDIR_NONE:
-			break;
-		case PIPEDIR_IN:
-			WARN_ON(dl_set);
-			*dl_pipe = __le32_to_cpu(entry->pipenum);
-			dl_set = true;
-			break;
-		case PIPEDIR_OUT:
-			WARN_ON(ul_set);
-			*ul_pipe = __le32_to_cpu(entry->pipenum);
-			ul_set = true;
-			break;
-		case PIPEDIR_INOUT:
-			WARN_ON(dl_set);
-			WARN_ON(ul_set);
-			*dl_pipe = __le32_to_cpu(entry->pipenum);
-			*ul_pipe = __le32_to_cpu(entry->pipenum);
-			dl_set = true;
-			ul_set = true;
-			break;
-		}
-	}
-
-	if (WARN_ON(!ul_set || !dl_set))
-		return -ENOENT;
-
-	return 0;
-}
-
 static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.start = ath11k_pci_start,
 	.stop = ath11k_pci_stop,
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 4869384..35c8152 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -53,21 +53,6 @@
 #define WLAON_QFPROM_PWR_CTRL_REG		0x01f8031c
 #define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
 
-#define ATH11K_PCI_IRQ_CE0_OFFSET	3
-#define ATH11K_PCI_IRQ_DP_OFFSET	14
-
-#define ATH11K_PCI_WINDOW_ENABLE_BIT		0x40000000
-#define ATH11K_PCI_WINDOW_REG_ADDRESS		0x310c
-#define ATH11K_PCI_WINDOW_VALUE_MASK		GENMASK(24, 19)
-#define ATH11K_PCI_WINDOW_START			0x80000
-#define ATH11K_PCI_WINDOW_RANGE_MASK		GENMASK(18, 0)
-
-/* BAR0 + 4k is always accessible, and no
- * need to force wakeup.
- * 4K - 32 = 0xFE0
- */
-#define ATH11K_PCI_ACCESS_ALWAYS_OFF 0xFE0
-
 struct ath11k_msi_user {
 	char *name;
 	int num_vectors;
@@ -113,30 +98,4 @@ static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
 	return (struct ath11k_pci *)ab->drv_priv;
 }
 
-int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_name,
-				       int *num_vectors, u32 *user_base_data,
-				       u32 *base_vector);
-int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector);
-void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value);
-u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset);
-void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
-				u32 *msi_addr_hi);
-void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
-void ath11k_pci_free_irq(struct ath11k_base *ab);
-int ath11k_pci_config_irq(struct ath11k_base *ab);
-void ath11k_pci_ext_irq_enable(struct ath11k_base *ab);
-void ath11k_pci_ext_irq_disable(struct ath11k_base *ab);
-void ath11k_pci_stop(struct ath11k_base *ab);
-int ath11k_pci_start(struct ath11k_base *ab);
-int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
-				   u8 *ul_pipe, u8 *dl_pipe);
-void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab);
-void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab);
-int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
-				   int *num_vectors, u32 *user_base_data,
-				   u32 *base_vector);
-void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci);
-int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
-				     const struct cpumask *m);
-
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.c b/drivers/net/wireless/ath/ath11k/pci_cmn.c
new file mode 100644
index 0000000..976b676
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
@@ -0,0 +1,737 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/pci.h>
+#include "core.h"
+#include "pci_cmn.h"
+#include "debug.h"
+
+static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
+	"bhi",
+	"mhi-er0",
+	"mhi-er1",
+	"ce0",
+	"ce1",
+	"ce2",
+	"ce3",
+	"ce4",
+	"ce5",
+	"ce6",
+	"ce7",
+	"ce8",
+	"ce9",
+	"ce10",
+	"ce11",
+	"host2wbm-desc-feed",
+	"host2reo-re-injection",
+	"host2reo-command",
+	"host2rxdma-monitor-ring3",
+	"host2rxdma-monitor-ring2",
+	"host2rxdma-monitor-ring1",
+	"reo2ost-exception",
+	"wbm2host-rx-release",
+	"reo2host-status",
+	"reo2host-destination-ring4",
+	"reo2host-destination-ring3",
+	"reo2host-destination-ring2",
+	"reo2host-destination-ring1",
+	"rxdma2host-monitor-destination-mac3",
+	"rxdma2host-monitor-destination-mac2",
+	"rxdma2host-monitor-destination-mac1",
+	"ppdu-end-interrupts-mac3",
+	"ppdu-end-interrupts-mac2",
+	"ppdu-end-interrupts-mac1",
+	"rxdma2host-monitor-status-ring-mac3",
+	"rxdma2host-monitor-status-ring-mac2",
+	"rxdma2host-monitor-status-ring-mac1",
+	"host2rxdma-host-buf-ring-mac3",
+	"host2rxdma-host-buf-ring-mac2",
+	"host2rxdma-host-buf-ring-mac1",
+	"rxdma2host-destination-ring-mac3",
+	"rxdma2host-destination-ring-mac2",
+	"rxdma2host-destination-ring-mac1",
+	"host2tcl-input-ring4",
+	"host2tcl-input-ring3",
+	"host2tcl-input-ring2",
+	"host2tcl-input-ring1",
+	"wbm2host-tx-completions-ring3",
+	"wbm2host-tx-completions-ring2",
+	"wbm2host-tx-completions-ring1",
+	"tcl2host-status-ring",
+};
+
+void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
+{
+	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
+		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+					   ab_pci->link_ctl);
+}
+
+static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+
+	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
+
+	lockdep_assert_held(&ab_pci->window_lock);
+
+	if (window != ab_pci->register_window) {
+		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
+			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+		ab_pci->register_window = window;
+	}
+}
+
+static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
+					      u32 offset)
+{
+	u32 window_start;
+
+	/* If offset lies within DP register range, use 3rd window */
+	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = 3 * ATH11K_PCI_WINDOW_START;
+	/* If offset lies within CE register range, use 2nd window */
+	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = 2 * ATH11K_PCI_WINDOW_START;
+	else
+		window_start = ATH11K_PCI_WINDOW_START;
+
+	return window_start;
+}
+
+void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 window_start;
+
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
+		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
+	if (offset < ATH11K_PCI_WINDOW_START) {
+		iowrite32(value, ab->mem  + offset);
+	} else {
+		if (ab->bus_params.static_window_map)
+			window_start = ath11k_pci_get_window_start(ab, offset);
+		else
+			window_start = ATH11K_PCI_WINDOW_START;
+
+		if (window_start == ATH11K_PCI_WINDOW_START) {
+			spin_lock_bh(&ab_pci->window_lock);
+			ath11k_pci_select_window(ab_pci, offset);
+			iowrite32(value, ab->mem + window_start +
+				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+			spin_unlock_bh(&ab_pci->window_lock);
+		} else {
+			iowrite32(value, ab->mem + window_start +
+				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		}
+	}
+
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 val, window_start;
+
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
+		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
+	if (offset < ATH11K_PCI_WINDOW_START) {
+		val = ioread32(ab->mem + offset);
+	} else {
+		if (ab->bus_params.static_window_map)
+			window_start = ath11k_pci_get_window_start(ab, offset);
+		else
+			window_start = ATH11K_PCI_WINDOW_START;
+
+		if (window_start == ATH11K_PCI_WINDOW_START) {
+			spin_lock_bh(&ab_pci->window_lock);
+			ath11k_pci_select_window(ab_pci, offset);
+			val = ioread32(ab->mem + window_start +
+				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+			spin_unlock_bh(&ab_pci->window_lock);
+		} else {
+			val = ioread32(ab->mem + window_start +
+				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		}
+	}
+
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+
+	return val;
+}
+
+int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return pci_irq_vector(pci_dev, vector);
+}
+
+void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+				u32 *msi_addr_hi)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+
+	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
+			      msi_addr_lo);
+
+	if (test_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags)) {
+		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
+				      msi_addr_hi);
+	} else {
+		*msi_addr_hi = 0;
+	}
+}
+
+int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
+				       int *num_vectors, u32 *user_base_data,
+				       u32 *base_vector)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
+	int idx;
+
+	for (idx = 0; idx < msi_config->total_users; idx++) {
+		if (strcmp(user_name, msi_config->users[idx].name) == 0) {
+			*num_vectors = msi_config->users[idx].num_vectors;
+			*base_vector =  msi_config->users[idx].base_vector;
+			*user_base_data = *base_vector + ab_pci->msi_ep_base_data;
+
+			ath11k_dbg(ab, ATH11K_DBG_PCI,
+				   "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
+				   user_name, *num_vectors, *user_base_data,
+				   *base_vector);
+
+			return 0;
+		}
+	}
+
+	ath11k_err(ab, "Failed to find MSI assignment for %s!\n", user_name);
+
+	return -EINVAL;
+}
+
+void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
+{
+	u32 i, msi_data_idx;
+
+	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		if (ce_id == i)
+			break;
+
+		msi_data_idx++;
+	}
+	*msi_idx = msi_data_idx;
+}
+
+int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
+				   int *num_vectors, u32 *user_base_data,
+				   u32 *base_vector)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	return ath11k_pci_get_user_msi_assignment(ab_pci, user_name,
+						  num_vectors, user_base_data,
+						  base_vector);
+}
+
+static void ath11k_pci_free_ext_irq(struct ath11k_base *ab)
+{
+	int i, j;
+
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+
+		for (j = 0; j < irq_grp->num_irq; j++)
+			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
+
+		netif_napi_del(&irq_grp->napi);
+	}
+}
+
+void ath11k_pci_free_irq(struct ath11k_base *ab)
+{
+	int i, irq_idx;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
+		free_irq(ab->irq_num[irq_idx], &ab->ce.ce_pipe[i]);
+	}
+
+	ath11k_pci_free_ext_irq(ab);
+}
+
+static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 irq_idx;
+
+	/* In case of one MSI vector, we handle irq enable/disable in a
+	 * uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
+	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
+	enable_irq(ab->irq_num[irq_idx]);
+}
+
+static void ath11k_pci_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 irq_idx;
+
+	/* In case of one MSI vector, we handle irq enable/disable in a
+	 * uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
+	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
+	disable_irq_nosync(ab->irq_num[irq_idx]);
+}
+
+static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
+{
+	int i;
+
+	clear_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		ath11k_pci_ce_irq_disable(ab, i);
+	}
+}
+
+static void ath11k_pci_sync_ce_irqs(struct ath11k_base *ab)
+{
+	int i;
+	int irq_idx;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
+		synchronize_irq(ab->irq_num[irq_idx]);
+	}
+}
+
+static void ath11k_pci_ce_tasklet(struct tasklet_struct *t)
+{
+	struct ath11k_ce_pipe *ce_pipe = from_tasklet(ce_pipe, t, intr_tq);
+	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
+
+	ath11k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
+
+	enable_irq(ce_pipe->ab->irq_num[irq_idx]);
+}
+
+static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
+{
+	struct ath11k_ce_pipe *ce_pipe = arg;
+	struct ath11k_base *ab = ce_pipe->ab;
+	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
+
+	if (!test_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags))
+		return IRQ_HANDLED;
+
+	/* last interrupt received for this CE */
+	ce_pipe->timestamp = jiffies;
+
+	disable_irq_nosync(ab->irq_num[irq_idx]);
+
+	tasklet_schedule(&ce_pipe->intr_tq);
+
+	return IRQ_HANDLED;
+}
+
+static void ath11k_pci_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
+	int i;
+
+	/* In case of one MSI vector, we handle irq enable/disable
+	 * in a uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
+	for (i = 0; i < irq_grp->num_irq; i++)
+		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+}
+
+static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
+{
+	int i;
+
+	clear_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &sc->dev_flags);
+
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath11k_ext_irq_grp *irq_grp = &sc->ext_irq_grp[i];
+
+		ath11k_pci_ext_grp_disable(irq_grp);
+
+		napi_synchronize(&irq_grp->napi);
+		napi_disable(&irq_grp->napi);
+	}
+}
+
+static void ath11k_pci_ext_grp_enable(struct ath11k_ext_irq_grp *irq_grp)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
+	int i;
+
+	/* In case of one MSI vector, we handle irq enable/disable in a
+	 * uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
+	for (i = 0; i < irq_grp->num_irq; i++)
+		enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+}
+
+void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
+{
+	int i;
+
+	set_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
+
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+
+		napi_enable(&irq_grp->napi);
+		ath11k_pci_ext_grp_enable(irq_grp);
+	}
+}
+
+static void ath11k_pci_sync_ext_irqs(struct ath11k_base *ab)
+{
+	int i, j, irq_idx;
+
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+
+		for (j = 0; j < irq_grp->num_irq; j++) {
+			irq_idx = irq_grp->irqs[j];
+			synchronize_irq(ab->irq_num[irq_idx]);
+		}
+	}
+}
+
+void ath11k_pci_ext_irq_disable(struct ath11k_base *ab)
+{
+	__ath11k_pci_ext_irq_disable(ab);
+	ath11k_pci_sync_ext_irqs(ab);
+}
+
+static int ath11k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct ath11k_ext_irq_grp *irq_grp = container_of(napi,
+						struct ath11k_ext_irq_grp,
+						napi);
+	struct ath11k_base *ab = irq_grp->ab;
+	int work_done;
+	int i;
+
+	work_done = ath11k_dp_service_srng(ab, irq_grp, budget);
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		for (i = 0; i < irq_grp->num_irq; i++)
+			enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+	}
+
+	if (work_done > budget)
+		work_done = budget;
+
+	return work_done;
+}
+
+static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
+{
+	struct ath11k_ext_irq_grp *irq_grp = arg;
+	struct ath11k_base *ab = irq_grp->ab;
+	int i;
+
+	if (!test_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
+		return IRQ_HANDLED;
+
+	ath11k_dbg(irq_grp->ab, ATH11K_DBG_PCI, "ext irq:%d\n", irq);
+
+	/* last interrupt received for this group */
+	irq_grp->timestamp = jiffies;
+
+	for (i = 0; i < irq_grp->num_irq; i++)
+		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+
+	napi_schedule(&irq_grp->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	int i, j, ret, num_vectors = 0;
+	u32 user_base_data = 0, base_vector = 0;
+
+	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
+						 &num_vectors,
+						 &user_base_data,
+						 &base_vector);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+		u32 num_irq = 0;
+
+		irq_grp->ab = ab;
+		irq_grp->grp_id = i;
+		init_dummy_netdev(&irq_grp->napi_ndev);
+		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
+			       ath11k_pci_ext_grp_napi_poll, NAPI_POLL_WEIGHT);
+
+		if (ab->hw_params.ring_mask->tx[i] ||
+		    ab->hw_params.ring_mask->rx[i] ||
+		    ab->hw_params.ring_mask->rx_err[i] ||
+		    ab->hw_params.ring_mask->rx_wbm_rel[i] ||
+		    ab->hw_params.ring_mask->reo_status[i] ||
+		    ab->hw_params.ring_mask->rxdma2host[i] ||
+		    ab->hw_params.ring_mask->host2rxdma[i] ||
+		    ab->hw_params.ring_mask->rx_mon_status[i]) {
+			num_irq = 1;
+		}
+
+		irq_grp->num_irq = num_irq;
+		irq_grp->irqs[0] = ATH11K_PCI_IRQ_DP_OFFSET + i;
+
+		for (j = 0; j < irq_grp->num_irq; j++) {
+			int irq_idx = irq_grp->irqs[j];
+			int vector = (i % num_vectors) + base_vector;
+			int irq = ath11k_pci_get_msi_irq(ab->dev, vector);
+
+			ab->irq_num[irq_idx] = irq;
+
+			ath11k_dbg(ab, ATH11K_DBG_PCI,
+				   "irq:%d group:%d\n", irq, i);
+
+			irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
+			ret = request_irq(irq, ath11k_pci_ext_interrupt_handler,
+					  ab_pci->irq_flags,
+					  "DP_EXT_IRQ", irq_grp);
+			if (ret) {
+				ath11k_err(ab, "failed request irq %d: %d\n",
+					   vector, ret);
+				return ret;
+			}
+		}
+		ath11k_pci_ext_grp_disable(irq_grp);
+	}
+
+	return 0;
+}
+
+int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
+				     const struct cpumask *m)
+{
+	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return 0;
+
+	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+}
+
+int ath11k_pci_config_irq(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	struct ath11k_ce_pipe *ce_pipe;
+	u32 msi_data_start;
+	u32 msi_data_count, msi_data_idx;
+	u32 msi_irq_start;
+	unsigned int msi_data;
+	int irq, i, ret, irq_idx;
+
+	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab),
+						 "CE", &msi_data_count,
+						 &msi_data_start, &msi_irq_start);
+	if (ret)
+		return ret;
+
+	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
+		return ret;
+	}
+
+	/* Configure CE irqs */
+	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		msi_data = (msi_data_idx % msi_data_count) + msi_irq_start;
+		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
+		ce_pipe = &ab->ce.ce_pipe[i];
+
+		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
+
+		tasklet_setup(&ce_pipe->intr_tq, ath11k_pci_ce_tasklet);
+
+		ret = request_irq(irq, ath11k_pci_ce_interrupt_handler,
+				  ab_pci->irq_flags, irq_name[irq_idx],
+				  ce_pipe);
+		if (ret) {
+			ath11k_err(ab, "failed to request irq %d: %d\n",
+				   irq_idx, ret);
+			goto err_irq_affinity_cleanup;
+		}
+
+		ab->irq_num[irq_idx] = irq;
+		msi_data_idx++;
+
+		ath11k_pci_ce_irq_disable(ab, i);
+	}
+
+	ret = ath11k_pci_ext_irq_config(ab);
+	if (ret)
+		goto err_irq_affinity_cleanup;
+
+	return 0;
+
+err_irq_affinity_cleanup:
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+	return ret;
+}
+
+void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
+{
+	int i;
+
+	set_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		ath11k_pci_ce_irq_enable(ab, i);
+	}
+}
+
+static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
+
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		tasklet_kill(&ce_pipe->intr_tq);
+	}
+}
+
+void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab)
+{
+	ath11k_pci_ce_irqs_disable(ab);
+	ath11k_pci_sync_ce_irqs(ab);
+	ath11k_pci_kill_tasklets(ab);
+}
+
+void ath11k_pci_stop(struct ath11k_base *ab)
+{
+	ath11k_pci_ce_irq_disable_sync(ab);
+	ath11k_ce_cleanup_pipes(ab);
+}
+
+int ath11k_pci_start(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
+
+	/* TODO: for now don't restore ASPM in case of single MSI
+	 * vector as MHI register reading in M2 causes system hang.
+	 */
+	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		ath11k_pci_aspm_restore(ab_pci);
+	else
+		ath11k_info(ab, "leaving PCI ASPM disabled to avoid MHI M2 problems\n");
+
+	ath11k_pci_ce_irqs_enable(ab);
+	ath11k_ce_rx_post_buf(ab);
+
+	return 0;
+}
+
+int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				   u8 *ul_pipe, u8 *dl_pipe)
+{
+	const struct service_to_pipe *entry;
+	bool ul_set = false, dl_set = false;
+	int i;
+
+	for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
+		entry = &ab->hw_params.svc_to_ce_map[i];
+
+		if (__le32_to_cpu(entry->service_id) != service_id)
+			continue;
+
+		switch (__le32_to_cpu(entry->pipedir)) {
+		case PIPEDIR_NONE:
+			break;
+		case PIPEDIR_IN:
+			WARN_ON(dl_set);
+			*dl_pipe = __le32_to_cpu(entry->pipenum);
+			dl_set = true;
+			break;
+		case PIPEDIR_OUT:
+			WARN_ON(ul_set);
+			*ul_pipe = __le32_to_cpu(entry->pipenum);
+			ul_set = true;
+			break;
+		case PIPEDIR_INOUT:
+			WARN_ON(dl_set);
+			WARN_ON(ul_set);
+			*dl_pipe = __le32_to_cpu(entry->pipenum);
+			*ul_pipe = __le32_to_cpu(entry->pipenum);
+			dl_set = true;
+			ul_set = true;
+			break;
+		}
+	}
+
+	if (WARN_ON(!ul_set || !dl_set))
+		return -ENOENT;
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.h b/drivers/net/wireless/ath/ath11k/pci_cmn.h
new file mode 100644
index 0000000..5fb1cf1
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _ATH11K_PCI_CMN_H
+#define _ATH11K_PCI_CMN_H
+
+#include "core.h"
+#include "pci.h"
+
+#define ATH11K_PCI_IRQ_CE0_OFFSET	3
+#define ATH11K_PCI_IRQ_DP_OFFSET	14
+
+#define ATH11K_PCI_WINDOW_ENABLE_BIT		0x40000000
+#define ATH11K_PCI_WINDOW_REG_ADDRESS		0x310c
+#define ATH11K_PCI_WINDOW_VALUE_MASK		GENMASK(24, 19)
+#define ATH11K_PCI_WINDOW_START			0x80000
+#define ATH11K_PCI_WINDOW_RANGE_MASK		GENMASK(18, 0)
+
+/* BAR0 + 4k is always accessible, and no
+ * need to force wakeup.
+ * 4K - 32 = 0xFE0
+ */
+#define ATH11K_PCI_ACCESS_ALWAYS_OFF 0xFE0
+
+int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_name,
+				       int *num_vectors, u32 *user_base_data,
+				       u32 *base_vector);
+int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector);
+void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value);
+u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset);
+void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+				u32 *msi_addr_hi);
+void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
+void ath11k_pci_free_irq(struct ath11k_base *ab);
+int ath11k_pci_config_irq(struct ath11k_base *ab);
+void ath11k_pci_ext_irq_enable(struct ath11k_base *ab);
+void ath11k_pci_ext_irq_disable(struct ath11k_base *ab);
+void ath11k_pci_stop(struct ath11k_base *ab);
+int ath11k_pci_start(struct ath11k_base *ab);
+int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				   u8 *ul_pipe, u8 *dl_pipe);
+void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab);
+void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab);
+int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
+				   int *num_vectors, u32 *user_base_data,
+				   u32 *base_vector);
+void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci);
+int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
+				     const struct cpumask *m);
+#endif
-- 
2.7.4

