Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBE4E8DA4
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 07:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbiC1F71 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 01:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiC1F7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 01:59:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275D51588
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648447063; x=1679983063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EWeKY3C0oWZf0XV/zpMKhCvy/wOtQAanZ4IHjVXWjaE=;
  b=cyxAFVZ1JS52R40/H6TneRQ7PGG6xiEPRw2yfdTr+738Cyvo5tyrcScg
   Mvgezlvyzcqgi9FEjAqk7h0b4lh4EoMOd2f01gtRbyhhlwS7do90Ty/X/
   SjmY5cMUoCn7LfGqq5EiWZ1b2vQ14ulqvG4nrwOmtNgq7R+0mgvR3DDtp
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Mar 2022 22:57:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 22:57:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:42 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:40 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 2/5] ath11k: Refactor PCI code to support WCN6750
Date:   Mon, 28 Mar 2022 11:27:11 +0530
Message-ID: <20220328055714.6449-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328055714.6449-1-quic_mpubbise@quicinc.com>
References: <20220328055714.6449-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

WCN6750 needs both AHB and PCI APIs for it's operation, it uses
AHB APIs for device probe/boot and PCI APIs for device setup and
register accesses. Because of this nature, it is referred as a
hybrid bus device.

Refactor PCI code to support hybrid bus devices like WCN6750.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Makefile |   2 +-
 drivers/net/wireless/ath/ath11k/mhi.c    |  27 +-
 drivers/net/wireless/ath/ath11k/pci.c    | 816 ++---------------------
 drivers/net/wireless/ath/ath11k/pci.h    |  41 --
 drivers/net/wireless/ath/ath11k/pcic.c   | 747 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pcic.h   |  53 ++
 6 files changed, 856 insertions(+), 830 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/pcic.c
 create mode 100644 drivers/net/wireless/ath/ath11k/pcic.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 444c00c2bce2..0ebfe41d6143 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
 
 obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
-ath11k_pci-y += mhi.o pci.o
+ath11k_pci-y += mhi.o pci.o pcic.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 61d83be4841f..3724eebba4a2 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
-/* Copyright (c) 2020 The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
 #include <linux/msi.h>
 #include <linux/pci.h>
@@ -11,6 +14,7 @@
 #include "debug.h"
 #include "mhi.h"
 #include "pci.h"
+#include "pcic.h"
 
 #define MHI_TIMEOUT_DEFAULT_MS	90000
 #define RDDM_DUMP_SIZE	0x420000
@@ -205,7 +209,7 @@ void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab)
 {
 	u32 val;
 
-	val = ath11k_pci_read32(ab, MHISTATUS);
+	val = ath11k_pcic_read32(ab, MHISTATUS);
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "MHISTATUS 0x%x\n", val);
 
@@ -213,29 +217,29 @@ void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab)
 	 * has SYSERR bit set and thus need to set MHICTRL_RESET
 	 * to clear SYSERR.
 	 */
-	ath11k_pci_write32(ab, MHICTRL, MHICTRL_RESET_MASK);
+	ath11k_pcic_write32(ab, MHICTRL, MHICTRL_RESET_MASK);
 
 	mdelay(10);
 }
 
 static void ath11k_mhi_reset_txvecdb(struct ath11k_base *ab)
 {
-	ath11k_pci_write32(ab, PCIE_TXVECDB, 0);
+	ath11k_pcic_write32(ab, PCIE_TXVECDB, 0);
 }
 
 static void ath11k_mhi_reset_txvecstatus(struct ath11k_base *ab)
 {
-	ath11k_pci_write32(ab, PCIE_TXVECSTATUS, 0);
+	ath11k_pcic_write32(ab, PCIE_TXVECSTATUS, 0);
 }
 
 static void ath11k_mhi_reset_rxvecdb(struct ath11k_base *ab)
 {
-	ath11k_pci_write32(ab, PCIE_RXVECDB, 0);
+	ath11k_pcic_write32(ab, PCIE_RXVECDB, 0);
 }
 
 static void ath11k_mhi_reset_rxvecstatus(struct ath11k_base *ab)
 {
-	ath11k_pci_write32(ab, PCIE_RXVECSTATUS, 0);
+	ath11k_pcic_write32(ab, PCIE_RXVECSTATUS, 0);
 }
 
 void ath11k_mhi_clear_vector(struct ath11k_base *ab)
@@ -254,9 +258,9 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	int *irq;
 	unsigned int msi_data;
 
-	ret = ath11k_pci_get_user_msi_assignment(ab_pci,
-						 "MHI", &num_vectors,
-						 &user_base_data, &base_vector);
+	ret = ath11k_pcic_get_user_msi_assignment(ab_pci,
+						  "MHI", &num_vectors,
+						  &user_base_data, &base_vector);
 	if (ret)
 		return ret;
 
@@ -273,8 +277,7 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 		if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
 			msi_data += i;
 
-		irq[i] = ath11k_pci_get_msi_irq(ab->dev,
-						msi_data);
+		irq[i] = ath11k_pcic_get_msi_irq(ab->dev, msi_data);
 	}
 
 	ab_pci->mhi_ctrl->irq = irq;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5e71eafdf9a3..bffbcace63ae 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -14,6 +14,7 @@
 #include "hif.h"
 #include "mhi.h"
 #include "debug.h"
+#include "pcic.h"
 
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
@@ -159,116 +90,15 @@ static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
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
-	int ret = 0;
-
-	/* for offset beyond BAR + 4K - 32, may
-	 * need to wakeup MHI to access.
-	 */
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
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
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
-	    !ret)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
-}
-
-u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 val, window_start;
-	int ret = 0;
-
-	/* for offset beyond BAR + 4K - 32, may
-	 * need to wakeup MHI to access.
-	 */
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
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
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
-	    !ret)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
-
-	return val;
-}
-
 static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 {
 	u32 val, delay;
 
-	val = ath11k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
+	val = ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
 
 	val |= PCIE_SOC_GLOBAL_RESET_V;
 
-	ath11k_pci_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
+	ath11k_pcic_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
 
 	/* TODO: exact time to sleep is uncertain */
 	delay = 10;
@@ -277,11 +107,11 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 	/* Need to toggle V bit back otherwise stuck in reset status */
 	val &= ~PCIE_SOC_GLOBAL_RESET_V;
 
-	ath11k_pci_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
+	ath11k_pcic_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
 
 	mdelay(delay);
 
-	val = ath11k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
+	val = ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
 	if (val == 0xffffffff)
 		ath11k_warn(ab, "link down error during global reset\n");
 }
@@ -291,10 +121,10 @@ static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
 	u32 val;
 
 	/* read cookie */
-	val = ath11k_pci_read32(ab, PCIE_Q6_COOKIE_ADDR);
+	val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "cookie:0x%x\n", val);
 
-	val = ath11k_pci_read32(ab, WLAON_WARM_SW_ENTRY);
+	val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "WLAON_WARM_SW_ENTRY 0x%x\n", val);
 
 	/* TODO: exact time to sleep is uncertain */
@@ -303,16 +133,16 @@ static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
 	/* write 0 to WLAON_WARM_SW_ENTRY to prevent Q6 from
 	 * continuing warm path and entering dead loop.
 	 */
-	ath11k_pci_write32(ab, WLAON_WARM_SW_ENTRY, 0);
+	ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
 	mdelay(10);
 
-	val = ath11k_pci_read32(ab, WLAON_WARM_SW_ENTRY);
+	val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "WLAON_WARM_SW_ENTRY 0x%x\n", val);
 
 	/* A read clear register. clear the register to prevent
 	 * Q6 from entering wrong code path.
 	 */
-	val = ath11k_pci_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
+	val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause:%d\n", val);
 }
 
@@ -322,14 +152,14 @@ static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
 	u32 v;
 	int i;
 
-	v = ath11k_pci_read32(ab, offset);
+	v = ath11k_pcic_read32(ab, offset);
 	if ((v & mask) == value)
 		return 0;
 
 	for (i = 0; i < 10; i++) {
-		ath11k_pci_write32(ab, offset, (v & ~mask) | value);
+		ath11k_pcic_write32(ab, offset, (v & ~mask) | value);
 
-		v = ath11k_pci_read32(ab, offset);
+		v = ath11k_pcic_read32(ab, offset);
 		if ((v & mask) == value)
 			return 0;
 
@@ -390,23 +220,23 @@ static void ath11k_pci_enable_ltssm(struct ath11k_base *ab)
 	u32 val;
 	int i;
 
-	val = ath11k_pci_read32(ab, PCIE_PCIE_PARF_LTSSM);
+	val = ath11k_pcic_read32(ab, PCIE_PCIE_PARF_LTSSM);
 
 	/* PCIE link seems very unstable after the Hot Reset*/
 	for (i = 0; val != PARM_LTSSM_VALUE && i < 5; i++) {
 		if (val == 0xffffffff)
 			mdelay(5);
 
-		ath11k_pci_write32(ab, PCIE_PCIE_PARF_LTSSM, PARM_LTSSM_VALUE);
-		val = ath11k_pci_read32(ab, PCIE_PCIE_PARF_LTSSM);
+		ath11k_pcic_write32(ab, PCIE_PCIE_PARF_LTSSM, PARM_LTSSM_VALUE);
+		val = ath11k_pcic_read32(ab, PCIE_PCIE_PARF_LTSSM);
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci ltssm 0x%x\n", val);
 
-	val = ath11k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+	val = ath11k_pcic_read32(ab, GCC_GCC_PCIE_HOT_RST);
 	val |= GCC_GCC_PCIE_HOT_RST_VAL;
-	ath11k_pci_write32(ab, GCC_GCC_PCIE_HOT_RST, val);
-	val = ath11k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+	ath11k_pcic_write32(ab, GCC_GCC_PCIE_HOT_RST, val);
+	val = ath11k_pcic_read32(ab, GCC_GCC_PCIE_HOT_RST);
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci pcie_hot_rst 0x%x\n", val);
 
@@ -420,21 +250,21 @@ static void ath11k_pci_clear_all_intrs(struct ath11k_base *ab)
 	 * So when download SBL again, SBL will open Interrupt and
 	 * receive it, and crash immediately.
 	 */
-	ath11k_pci_write32(ab, PCIE_PCIE_INT_ALL_CLEAR, PCIE_INT_CLEAR_ALL);
+	ath11k_pcic_write32(ab, PCIE_PCIE_INT_ALL_CLEAR, PCIE_INT_CLEAR_ALL);
 }
 
 static void ath11k_pci_set_wlaon_pwr_ctrl(struct ath11k_base *ab)
 {
 	u32 val;
 
-	val = ath11k_pci_read32(ab, WLAON_QFPROM_PWR_CTRL_REG);
+	val = ath11k_pcic_read32(ab, WLAON_QFPROM_PWR_CTRL_REG);
 	val &= ~QFPROM_PWR_CTRL_VDD4BLOW_MASK;
-	ath11k_pci_write32(ab, WLAON_QFPROM_PWR_CTRL_REG, val);
+	ath11k_pcic_write32(ab, WLAON_QFPROM_PWR_CTRL_REG, val);
 }
 
 static void ath11k_pci_force_wake(struct ath11k_base *ab)
 {
-	ath11k_pci_write32(ab, PCIE_SOC_WAKE_PCIE_LOCAL_REG, 1);
+	ath11k_pcic_write32(ab, PCIE_SOC_WAKE_PCIE_LOCAL_REG, 1);
 	mdelay(5);
 }
 
@@ -456,462 +286,6 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
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
-		if (irq_grp->napi_enabled) {
-			napi_synchronize(&irq_grp->napi);
-			napi_disable(&irq_grp->napi);
-			irq_grp->napi_enabled = false;
-		}
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
-		if (!irq_grp->napi_enabled) {
-			napi_enable(&irq_grp->napi);
-			irq_grp->napi_enabled = true;
-		}
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
@@ -927,19 +301,6 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
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
@@ -1139,13 +500,6 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
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
@@ -1179,7 +533,7 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	/* restore aspm in case firmware bootup fails */
-	ath11k_pci_aspm_restore(ab_pci);
+	ath11k_pcic_aspm_restore(ab_pci);
 
 	ath11k_pci_force_wake(ab_pci->ab);
 
@@ -1208,130 +562,40 @@ static int ath11k_pci_hif_resume(struct ath11k_base *ab)
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
-	ath11k_pci_ce_irqs_enable(ab);
+	ath11k_pcic_ce_irqs_enable(ab);
 }
 
 static void ath11k_pci_hif_ce_irq_disable(struct ath11k_base *ab)
 {
-	ath11k_pci_ce_irq_disable_sync(ab);
-}
-
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
+	ath11k_pcic_ce_irq_disable_sync(ab);
 }
 
 static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
-	.start = ath11k_pci_start,
-	.stop = ath11k_pci_stop,
-	.read32 = ath11k_pci_read32,
-	.write32 = ath11k_pci_write32,
+	.start = ath11k_pcic_start,
+	.stop = ath11k_pcic_stop,
+	.read32 = ath11k_pcic_read32,
+	.write32 = ath11k_pcic_write32,
 	.power_down = ath11k_pci_power_down,
 	.power_up = ath11k_pci_power_up,
 	.suspend = ath11k_pci_hif_suspend,
 	.resume = ath11k_pci_hif_resume,
-	.irq_enable = ath11k_pci_ext_irq_enable,
-	.irq_disable = ath11k_pci_ext_irq_disable,
-	.get_msi_address =  ath11k_pci_get_msi_address,
+	.irq_enable = ath11k_pcic_ext_irq_enable,
+	.irq_disable = ath11k_pcic_ext_irq_disable,
+	.get_msi_address =  ath11k_pcic_get_msi_address,
 	.get_user_msi_vector = ath11k_get_user_msi_assignment,
-	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
+	.map_service_to_pipe = ath11k_pcic_map_service_to_pipe,
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
-	.get_ce_msi_idx = ath11k_pci_get_ce_msi_idx,
+	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
 {
 	u32 soc_hw_version;
 
-	soc_hw_version = ath11k_pci_read32(ab, TCSR_SOC_HW_VERSION);
+	soc_hw_version = ath11k_pcic_read32(ab, TCSR_SOC_HW_VERSION);
 	*major = FIELD_GET(TCSR_SOC_HW_VERSION_MAJOR_MASK,
 			   soc_hw_version);
 	*minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
@@ -1473,7 +737,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 
 	ath11k_pci_init_qmi_ce_config(ab);
 
-	ret = ath11k_pci_config_irq(ab);
+	ret = ath11k_pcic_config_irq(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to config irq: %d\n", ret);
 		goto err_ce_free;
@@ -1498,7 +762,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
-	ath11k_pci_free_irq(ab);
+	ath11k_pcic_free_irq(ab);
 
 err_ce_free:
 	ath11k_ce_free_pipes(ab);
@@ -1526,7 +790,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_base *ab = pci_get_drvdata(pdev);
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
-	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+	ath11k_pcic_set_irq_affinity_hint(ab_pci, NULL);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
 		ath11k_pci_power_down(ab);
@@ -1542,7 +806,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 qmi_fail:
 	ath11k_mhi_unregister(ab_pci);
 
-	ath11k_pci_free_irq(ab);
+	ath11k_pcic_free_irq(ab);
 	ath11k_pci_free_msi(ab_pci);
 	ath11k_pci_free_region(ab_pci);
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 31ee843c1cab..038e4152987c 100644
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
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
new file mode 100644
index 000000000000..391c308455e5
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -0,0 +1,747 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/pci.h>
+#include "core.h"
+#include "pcic.h"
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
+void ath11k_pcic_aspm_restore(struct ath11k_pci *ab_pci)
+{
+	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
+		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+					   ab_pci->link_ctl);
+}
+
+static inline void ath11k_pcic_select_window(struct ath11k_pci *ab_pci, u32 offset)
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
+static inline u32 ath11k_pcic_get_window_start(struct ath11k_base *ab,
+					       u32 offset)
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
+void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 window_start;
+	int ret = 0;
+
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
+		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
+	if (offset < ATH11K_PCI_WINDOW_START) {
+		iowrite32(value, ab->mem  + offset);
+	} else {
+		if (ab->bus_params.static_window_map)
+			window_start = ath11k_pcic_get_window_start(ab, offset);
+		else
+			window_start = ATH11K_PCI_WINDOW_START;
+
+		if (window_start == ATH11K_PCI_WINDOW_START) {
+			spin_lock_bh(&ab_pci->window_lock);
+			ath11k_pcic_select_window(ab_pci, offset);
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
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
+	    !ret)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 val, window_start;
+	int ret = 0;
+
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
+		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
+	if (offset < ATH11K_PCI_WINDOW_START) {
+		val = ioread32(ab->mem + offset);
+	} else {
+		if (ab->bus_params.static_window_map)
+			window_start = ath11k_pcic_get_window_start(ab, offset);
+		else
+			window_start = ATH11K_PCI_WINDOW_START;
+
+		if (window_start == ATH11K_PCI_WINDOW_START) {
+			spin_lock_bh(&ab_pci->window_lock);
+			ath11k_pcic_select_window(ab_pci, offset);
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
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
+	    !ret)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+
+	return val;
+}
+
+int ath11k_pcic_get_msi_irq(struct device *dev, unsigned int vector)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return pci_irq_vector(pci_dev, vector);
+}
+
+void ath11k_pcic_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+				 u32 *msi_addr_hi)
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
+int ath11k_pcic_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
+					int *num_vectors, u32 *user_base_data,
+					u32 *base_vector)
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
+void ath11k_pcic_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
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
+	return ath11k_pcic_get_user_msi_assignment(ab_pci, user_name,
+						   num_vectors, user_base_data,
+						   base_vector);
+}
+
+static void ath11k_pcic_free_ext_irq(struct ath11k_base *ab)
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
+void ath11k_pcic_free_irq(struct ath11k_base *ab)
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
+	ath11k_pcic_free_ext_irq(ab);
+}
+
+static void ath11k_pcic_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
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
+static void ath11k_pcic_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
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
+static void ath11k_pcic_ce_irqs_disable(struct ath11k_base *ab)
+{
+	int i;
+
+	clear_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		ath11k_pcic_ce_irq_disable(ab, i);
+	}
+}
+
+static void ath11k_pcic_sync_ce_irqs(struct ath11k_base *ab)
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
+static void ath11k_pcic_ce_tasklet(struct tasklet_struct *t)
+{
+	struct ath11k_ce_pipe *ce_pipe = from_tasklet(ce_pipe, t, intr_tq);
+	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
+
+	ath11k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
+
+	enable_irq(ce_pipe->ab->irq_num[irq_idx]);
+}
+
+static irqreturn_t ath11k_pcic_ce_interrupt_handler(int irq, void *arg)
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
+static void ath11k_pcic_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
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
+static void __ath11k_pcic_ext_irq_disable(struct ath11k_base *sc)
+{
+	int i;
+
+	clear_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &sc->dev_flags);
+
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath11k_ext_irq_grp *irq_grp = &sc->ext_irq_grp[i];
+
+		ath11k_pcic_ext_grp_disable(irq_grp);
+
+		if (irq_grp->napi_enabled) {
+			napi_synchronize(&irq_grp->napi);
+			napi_disable(&irq_grp->napi);
+			irq_grp->napi_enabled = false;
+		}
+	}
+}
+
+static void ath11k_pcic_ext_grp_enable(struct ath11k_ext_irq_grp *irq_grp)
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
+void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
+{
+	int i;
+
+	set_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
+
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+
+		if (!irq_grp->napi_enabled) {
+			napi_enable(&irq_grp->napi);
+			irq_grp->napi_enabled = true;
+		}
+		ath11k_pcic_ext_grp_enable(irq_grp);
+	}
+}
+
+static void ath11k_pcic_sync_ext_irqs(struct ath11k_base *ab)
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
+void ath11k_pcic_ext_irq_disable(struct ath11k_base *ab)
+{
+	__ath11k_pcic_ext_irq_disable(ab);
+	ath11k_pcic_sync_ext_irqs(ab);
+}
+
+static int ath11k_pcic_ext_grp_napi_poll(struct napi_struct *napi, int budget)
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
+static irqreturn_t ath11k_pcic_ext_interrupt_handler(int irq, void *arg)
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
+static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	int i, j, ret, num_vectors = 0;
+	u32 user_base_data = 0, base_vector = 0;
+
+	ret = ath11k_pcic_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
+						  &num_vectors,
+						  &user_base_data,
+						  &base_vector);
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
+			       ath11k_pcic_ext_grp_napi_poll, NAPI_POLL_WEIGHT);
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
+			int irq = ath11k_pcic_get_msi_irq(ab->dev, vector);
+
+			ab->irq_num[irq_idx] = irq;
+
+			ath11k_dbg(ab, ATH11K_DBG_PCI,
+				   "irq:%d group:%d\n", irq, i);
+
+			irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
+			ret = request_irq(irq, ath11k_pcic_ext_interrupt_handler,
+					  ab_pci->irq_flags,
+					  "DP_EXT_IRQ", irq_grp);
+			if (ret) {
+				ath11k_err(ab, "failed request irq %d: %d\n",
+					   vector, ret);
+				return ret;
+			}
+		}
+		ath11k_pcic_ext_grp_disable(irq_grp);
+	}
+
+	return 0;
+}
+
+int ath11k_pcic_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
+				      const struct cpumask *m)
+{
+	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return 0;
+
+	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+}
+
+int ath11k_pcic_config_irq(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	struct ath11k_ce_pipe *ce_pipe;
+	u32 msi_data_start;
+	u32 msi_data_count, msi_data_idx;
+	u32 msi_irq_start;
+	unsigned int msi_data;
+	int irq, i, ret, irq_idx;
+
+	ret = ath11k_pcic_get_user_msi_assignment(ath11k_pci_priv(ab),
+						  "CE", &msi_data_count,
+						  &msi_data_start, &msi_irq_start);
+	if (ret)
+		return ret;
+
+	ret = ath11k_pcic_set_irq_affinity_hint(ab_pci, cpumask_of(0));
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
+		irq = ath11k_pcic_get_msi_irq(ab->dev, msi_data);
+		ce_pipe = &ab->ce.ce_pipe[i];
+
+		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
+
+		tasklet_setup(&ce_pipe->intr_tq, ath11k_pcic_ce_tasklet);
+
+		ret = request_irq(irq, ath11k_pcic_ce_interrupt_handler,
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
+		ath11k_pcic_ce_irq_disable(ab, i);
+	}
+
+	ret = ath11k_pcic_ext_irq_config(ab);
+	if (ret)
+		goto err_irq_affinity_cleanup;
+
+	return 0;
+
+err_irq_affinity_cleanup:
+	ath11k_pcic_set_irq_affinity_hint(ab_pci, NULL);
+	return ret;
+}
+
+void ath11k_pcic_ce_irqs_enable(struct ath11k_base *ab)
+{
+	int i;
+
+	set_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		ath11k_pcic_ce_irq_enable(ab, i);
+	}
+}
+
+static void ath11k_pcic_kill_tasklets(struct ath11k_base *ab)
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
+void ath11k_pcic_ce_irq_disable_sync(struct ath11k_base *ab)
+{
+	ath11k_pcic_ce_irqs_disable(ab);
+	ath11k_pcic_sync_ce_irqs(ab);
+	ath11k_pcic_kill_tasklets(ab);
+}
+
+void ath11k_pcic_stop(struct ath11k_base *ab)
+{
+	ath11k_pcic_ce_irq_disable_sync(ab);
+	ath11k_ce_cleanup_pipes(ab);
+}
+
+int ath11k_pcic_start(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
+
+	/* TODO: for now don't restore ASPM in case of single MSI
+	 * vector as MHI register reading in M2 causes system hang.
+	 */
+	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		ath11k_pcic_aspm_restore(ab_pci);
+	else
+		ath11k_info(ab, "leaving PCI ASPM disabled to avoid MHI M2 problems\n");
+
+	ath11k_pcic_ce_irqs_enable(ab);
+	ath11k_ce_rx_post_buf(ab);
+
+	return 0;
+}
+
+int ath11k_pcic_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				    u8 *ul_pipe, u8 *dl_pipe)
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
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
new file mode 100644
index 000000000000..6780f7e8bc64
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
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
+int ath11k_pcic_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_name,
+					int *num_vectors, u32 *user_base_data,
+					u32 *base_vector);
+int ath11k_pcic_get_msi_irq(struct device *dev, unsigned int vector);
+void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value);
+u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset);
+void ath11k_pcic_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+				 u32 *msi_addr_hi);
+void ath11k_pcic_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
+void ath11k_pcic_free_irq(struct ath11k_base *ab);
+int ath11k_pcic_config_irq(struct ath11k_base *ab);
+void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab);
+void ath11k_pcic_ext_irq_disable(struct ath11k_base *ab);
+void ath11k_pcic_stop(struct ath11k_base *ab);
+int ath11k_pcic_start(struct ath11k_base *ab);
+int ath11k_pcic_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				    u8 *ul_pipe, u8 *dl_pipe);
+void ath11k_pcic_ce_irqs_enable(struct ath11k_base *ab);
+void ath11k_pcic_ce_irq_disable_sync(struct ath11k_base *ab);
+int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
+				   int *num_vectors, u32 *user_base_data,
+				   u32 *base_vector);
+void ath11k_pcic_aspm_restore(struct ath11k_pci *ab_pci);
+int ath11k_pcic_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
+				      const struct cpumask *m);
+#endif
-- 
2.35.1

