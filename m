Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102461CA6A7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 10:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgEHI7H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 04:59:07 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42235 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgEHI7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 04:59:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588928345; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=sIgGgnZXhNnAAr8Mjqcxp18lvWdeKu3HGg4JCh593eI=; b=oZkQeEzqpl3iSv2FCD4DzpyYLeTb5JtZDWLTCkfL3Hz9hWMv1WD/QB/UGyHCbNGZ+IGmkoiX
 raGfdP/JItrk8ReuDK7RoyheKNSS5mhPEL/rifVav+XuLHDTgCZAWvcvTlqnjmZEVTPHJqd1
 hgw148BKIlInJ+7LpOX1lctgKnA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb51f59.7f721a613f80-smtp-out-n03;
 Fri, 08 May 2020 08:59:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B8C2C433F2; Fri,  8 May 2020 08:59:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6832C44793;
        Fri,  8 May 2020 08:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6832C44793
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 4/4] ath11k: Register mhi controller device for qca6390
Date:   Fri,  8 May 2020 14:28:50 +0530
Message-Id: <20200508085850.23363-5-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200508085850.23363-1-govinds@codeaurora.org>
References: <20200508085850.23363-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MHI is a communication protocol to communicate with external
Qualcomm modems and Wi-Fi chipsets over high speed peripheral buses. Even
though MHI doesn’t dictate underlying physical layer, protocol and mhi stack
is structured for PCIe based devices.

Register directly with mhi core layer as a mhi device driver for
firmware download.

Tested QCA6390 on X86 platform.
Tested firmware WLAN.HST.1.0.1.c1-00440-QCAHSTSWPLZ_V2_TO_X86-1.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Kconfig  |   5 +-
 drivers/net/wireless/ath/ath11k/Makefile |   2 +-
 drivers/net/wireless/ath/ath11k/mhi.c    | 379 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.h    |  28 ++
 drivers/net/wireless/ath/ath11k/pci.c    |  97 ++++++
 drivers/net/wireless/ath/ath11k/pci.h    |  13 +
 6 files changed, 520 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.c
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 320b3b151bce..bd48796742bb 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -2,7 +2,6 @@
 config ATH11K
 	tristate "Qualcomm Technologies 802.11ax chipset support"
 	depends on MAC80211 && HAS_DMA
-	depends on REMOTEPROC
 	depends on CRYPTO_MICHAEL_MIC
 	depends on ARCH_QCOM || COMPILE_TEST
 	select ATH_COMMON
@@ -15,13 +14,13 @@ config ATH11K
 
 config ATH11K_AHB
 	tristate "Qualcomm Technologies 802.11ax chipset AHB support"
-	depends on ATH11K
+	depends on ATH11K && REMOTEPROC
 	---help---
 	  This module adds support for AHB bus
 
 config ATH11K_PCI
 	tristate "Qualcomm Technologies 802.11ax chipset PCI support"
-	depends on ATH11K && PCI
+	depends on ATH11K && PCI && MHI_BUS
 	---help---
 	  This module adds support for PCIE bus
 
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 933fcb2fd55d..8343c7dfaae3 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
 
 obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
-ath11k_pci-y += pci.o
+ath11k_pci-y += mhi.o pci.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
new file mode 100644
index 000000000000..1ca43243e265
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/* Copyright (c) 2020 The Linux Foundation. All rights reserved. */
+
+#include <linux/msi.h>
+#include <linux/pci.h>
+
+#include "debug.h"
+#include "mhi.h"
+
+#define MHI_TIMEOUT_DEFAULT_MS	90000
+
+static struct mhi_channel_config ath11k_mhi_channels[] = {
+	{
+		.num = 0,
+		.name = "LOOPBACK",
+		.num_elements = 32,
+		.event_ring = 0,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = 0x4,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = false,
+		.auto_start = false,
+	},
+	{
+		.num = 1,
+		.name = "LOOPBACK",
+		.num_elements = 32,
+		.event_ring = 0,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = 0x4,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = false,
+		.auto_start = false,
+	},
+	{
+		.num = 20,
+		.name = "IPCR",
+		.num_elements = 64,
+		.event_ring = 1,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = 0x4,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = false,
+		.auto_start = true,
+	},
+	{
+		.num = 21,
+		.name = "IPCR",
+		.num_elements = 64,
+		.event_ring = 1,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = 0x4,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = true,
+		.auto_start = true,
+	},
+};
+
+static struct mhi_event_config ath11k_mhi_events[] = {
+	{
+		.num_elements = 32,
+		.irq_moderation_ms = 0,
+		.irq = 1,
+		.mode = MHI_DB_BRST_DISABLE,
+		.hardware_event = false,
+		.client_managed = false,
+		.offload_channel = false,
+	},
+	{
+		.num_elements = 256,
+		.irq_moderation_ms = 1,
+		.irq = 2,
+		.mode = MHI_DB_BRST_DISABLE,
+		.priority = 1,
+		.hardware_event = false,
+		.client_managed = false,
+		.offload_channel = false,
+	},
+};
+
+static struct mhi_controller_config ath11k_mhi_config = {
+	.max_channels = 128,
+	.timeout_ms = 2000,
+	.use_bounce_buf = false,
+	.buf_len = 0,
+	.num_channels = ARRAY_SIZE(ath11k_mhi_channels),
+	.ch_cfg = ath11k_mhi_channels,
+	.num_events = ARRAY_SIZE(ath11k_mhi_events),
+	.event_cfg = ath11k_mhi_events,
+};
+
+static int ath11k_pci_get_mhi_msi(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	u32 user_base_data, base_vector;
+	int ret, num_vectors, i;
+	int *irq;
+
+	ret = ath11k_pci_get_user_msi_assignment(ab_pci,
+						 "MHI", &num_vectors,
+						 &user_base_data, &base_vector);
+	if (ret)
+		return ret;
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "Number of assigned MSI for MHI is %d, base vector is %d\n",
+		   num_vectors, base_vector);
+
+	irq = kcalloc(num_vectors, sizeof(int), GFP_KERNEL);
+	if (!irq)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vectors; i++)
+		irq[i] = ath11k_pci_get_msi_irq(ab_pci->dev,
+						base_vector + i);
+
+	ab_pci->mhi_ctrl->irq = irq;
+	ab_pci->mhi_ctrl->nr_irqs = num_vectors;
+
+	return 0;
+}
+
+int ath11k_pci_register_mhi(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	struct mhi_controller *mhi_ctrl;
+	int ret;
+
+	mhi_ctrl = kzalloc(sizeof(*mhi_ctrl), GFP_KERNEL);
+	if (!mhi_ctrl)
+		return PTR_ERR(mhi_ctrl);
+
+	ab_pci->mhi_ctrl = mhi_ctrl;
+	mhi_ctrl->fw_image = ATH11K_PCI_FW_FILE_NAME;
+	mhi_ctrl->regs = ab_pci->mem;
+
+	ret = ath11k_pci_get_mhi_msi(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to get msi for mhi\n");
+		kfree(mhi_ctrl);
+		return ret;
+	}
+
+	mhi_ctrl->iova_start = 0;
+	mhi_ctrl->iova_stop = 0xffffffff;
+	mhi_ctrl->sbl_size = SZ_512K;
+	mhi_ctrl->seg_len = SZ_512K;
+	mhi_ctrl->fbc_download = true;
+
+	ret = mhi_register_controller(mhi_ctrl, &ath11k_mhi_config);
+	if (ret) {
+		ath11k_err(ab, "failed to register to mhi bus, err = %d\n", ret);
+		kfree(mhi_ctrl);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ath11k_pci_unregister_mhi(struct ath11k_pci *ab_pci)
+{
+	struct mhi_controller *mhi_ctrl = ab_pci->mhi_ctrl;
+
+	mhi_unregister_controller(mhi_ctrl);
+	kfree(mhi_ctrl->irq);
+}
+
+static char *ath11k_mhi_state_to_str(enum ath11k_mhi_state mhi_state)
+{
+	switch (mhi_state) {
+	case ATH11K_MHI_INIT:
+		return "INIT";
+	case ATH11K_MHI_DEINIT:
+		return "DEINIT";
+	case ATH11K_MHI_POWER_ON:
+		return "POWER_ON";
+	case ATH11K_MHI_POWER_OFF:
+		return "POWER_OFF";
+	case ATH11K_MHI_FORCE_POWER_OFF:
+		return "FORCE_POWER_OFF";
+	case ATH11K_MHI_SUSPEND:
+		return "SUSPEND";
+	case ATH11K_MHI_RESUME:
+		return "RESUME";
+	case ATH11K_MHI_TRIGGER_RDDM:
+		return "TRIGGER_RDDM";
+	case ATH11K_MHI_RDDM_DONE:
+		return "RDDM_DONE";
+	default:
+		return "UNKNOWN";
+	}
+};
+
+static void ath11k_pci_set_mhi_state_bit(struct ath11k_pci *ab_pci,
+					 enum ath11k_mhi_state mhi_state)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+
+	switch (mhi_state) {
+	case ATH11K_MHI_INIT:
+		set_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state);
+		break;
+	case ATH11K_MHI_DEINIT:
+		clear_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state);
+		break;
+	case ATH11K_MHI_POWER_ON:
+		set_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state);
+		break;
+	case ATH11K_MHI_POWER_OFF:
+	case ATH11K_MHI_FORCE_POWER_OFF:
+		clear_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state);
+		clear_bit(ATH11K_MHI_TRIGGER_RDDM, &ab_pci->mhi_state);
+		clear_bit(ATH11K_MHI_RDDM_DONE, &ab_pci->mhi_state);
+		break;
+	case ATH11K_MHI_SUSPEND:
+		set_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state);
+		break;
+	case ATH11K_MHI_RESUME:
+		clear_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state);
+		break;
+	case ATH11K_MHI_TRIGGER_RDDM:
+		set_bit(ATH11K_MHI_TRIGGER_RDDM, &ab_pci->mhi_state);
+		break;
+	case ATH11K_MHI_RDDM_DONE:
+		set_bit(ATH11K_MHI_RDDM_DONE, &ab_pci->mhi_state);
+		break;
+	default:
+		ath11k_err(ab, "unhandled mhi state (%d)\n", mhi_state);
+	}
+}
+
+static int ath11k_pci_check_mhi_state_bit(struct ath11k_pci *ab_pci,
+					  enum ath11k_mhi_state mhi_state)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+
+	switch (mhi_state) {
+	case ATH11K_MHI_INIT:
+		if (!test_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state))
+			return 0;
+		break;
+	case ATH11K_MHI_DEINIT:
+	case ATH11K_MHI_POWER_ON:
+		if (test_bit(ATH11K_MHI_INIT, &ab_pci->mhi_state) &&
+		    !test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state))
+			return 0;
+		break;
+	case ATH11K_MHI_FORCE_POWER_OFF:
+		if (test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state))
+			return 0;
+		break;
+	case ATH11K_MHI_POWER_OFF:
+	case ATH11K_MHI_SUSPEND:
+		if (test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state) &&
+		    !test_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state))
+			return 0;
+		break;
+	case ATH11K_MHI_RESUME:
+		if (test_bit(ATH11K_MHI_SUSPEND, &ab_pci->mhi_state))
+			return 0;
+		break;
+	case ATH11K_MHI_TRIGGER_RDDM:
+		if (test_bit(ATH11K_MHI_POWER_ON, &ab_pci->mhi_state) &&
+		    !test_bit(ATH11K_MHI_TRIGGER_RDDM, &ab_pci->mhi_state))
+			return 0;
+		break;
+	case ATH11K_MHI_RDDM_DONE:
+		return 0;
+	default:
+		ath11k_err(ab, "unhandled mhi state: %s(%d)\n",
+			   ath11k_mhi_state_to_str(mhi_state), mhi_state);
+	}
+
+	ath11k_err(ab, "failed to set mhi state %s(%d) in current mhi state (0x%lx)\n",
+		   ath11k_mhi_state_to_str(mhi_state), mhi_state,
+		   ab_pci->mhi_state);
+
+	return -EINVAL;
+}
+
+static int ath11k_pci_set_mhi_state(struct ath11k_pci *ab_pci,
+				    enum ath11k_mhi_state mhi_state)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	int ret;
+
+	ret = ath11k_pci_check_mhi_state_bit(ab_pci, mhi_state);
+	if (ret)
+		goto out;
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "setting mhi state: %s(%d)\n",
+		   ath11k_mhi_state_to_str(mhi_state), mhi_state);
+
+	switch (mhi_state) {
+	case ATH11K_MHI_INIT:
+		ret = mhi_prepare_for_power_up(ab_pci->mhi_ctrl);
+		break;
+	case ATH11K_MHI_DEINIT:
+		mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
+		ret = 0;
+		break;
+	case ATH11K_MHI_POWER_ON:
+		ret = mhi_async_power_up(ab_pci->mhi_ctrl);
+		break;
+	case ATH11K_MHI_POWER_OFF:
+		mhi_power_down(ab_pci->mhi_ctrl, true);
+		ret = 0;
+		break;
+	case ATH11K_MHI_FORCE_POWER_OFF:
+		mhi_power_down(ab_pci->mhi_ctrl, false);
+		ret = 0;
+		break;
+	case ATH11K_MHI_SUSPEND:
+		break;
+	case ATH11K_MHI_RESUME:
+		break;
+	case ATH11K_MHI_TRIGGER_RDDM:
+		ret = mhi_force_rddm_mode(ab_pci->mhi_ctrl);
+		break;
+	case ATH11K_MHI_RDDM_DONE:
+		break;
+	default:
+		ath11k_err(ab, "unhandled MHI state (%d)\n", mhi_state);
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto out;
+
+	ath11k_pci_set_mhi_state_bit(ab_pci, mhi_state);
+
+	return 0;
+
+out:
+	ath11k_err(ab, "failed to set mhi state: %s(%d)\n",
+		   ath11k_mhi_state_to_str(mhi_state), mhi_state);
+	return ret;
+}
+
+int ath11k_pci_start_mhi(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	int ret;
+
+	ab_pci->mhi_ctrl->timeout_ms = MHI_TIMEOUT_DEFAULT_MS;
+
+	ret = ath11k_pci_set_mhi_state(ab_pci, ATH11K_MHI_INIT);
+	if (ret)
+		ath11k_err(ab, "failed to set mhi init state: %d\n", ret);
+
+	ret = ath11k_pci_set_mhi_state(ab_pci, ATH11K_MHI_POWER_ON);
+	if (ret)
+		ath11k_err(ab, "failed to set mhi power on state: %d\n", ret);
+
+	return ret;
+}
+
+void ath11k_pci_stop_mhi(struct ath11k_pci *ab_pci)
+{
+	ath11k_pci_set_mhi_state(ab_pci, ATH11K_MHI_RESUME);
+	ath11k_pci_set_mhi_state(ab_pci, ATH11K_MHI_POWER_OFF);
+	ath11k_pci_set_mhi_state(ab_pci, ATH11K_MHI_DEINIT);
+}
+
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
new file mode 100644
index 000000000000..355de5a2c241
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+#ifndef _ATH11K_MHI_H
+#define _ATH11K_MHI_H
+
+#include "pci.h"
+#define ATH11K_PCI_FW_FILE_NAME		"amss.bin"
+
+enum ath11k_mhi_state {
+	ATH11K_MHI_INIT,
+	ATH11K_MHI_DEINIT,
+	ATH11K_MHI_POWER_ON,
+	ATH11K_MHI_POWER_OFF,
+	ATH11K_MHI_FORCE_POWER_OFF,
+	ATH11K_MHI_SUSPEND,
+	ATH11K_MHI_RESUME,
+	ATH11K_MHI_TRIGGER_RDDM,
+	ATH11K_MHI_RDDM,
+	ATH11K_MHI_RDDM_DONE,
+};
+
+int ath11k_pci_start_mhi(struct ath11k_pci *ar_pci);
+void ath11k_pci_stop_mhi(struct ath11k_pci *ar_pci);
+int ath11k_pci_register_mhi(struct ath11k_pci *ar_pci);
+void ath11k_pci_unregister_mhi(struct ath11k_pci *ar_pci);
+#endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d89dcb5fe81e..938078ee8d80 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -9,6 +9,8 @@
 
 #include "ahb.h"
 #include "core.h"
+#include "hif.h"
+#include "mhi.h"
 #include "pci.h"
 #include "debug.h"
 
@@ -31,6 +33,60 @@ static struct ath11k_msi_config msi_config = {
 	},
 };
 
+int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	int irq_num;
+
+	irq_num = pci_irq_vector(pci_dev, vector);
+
+	return irq_num;
+}
+
+int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
+				       int *num_vectors, u32 *user_base_data,
+				       u32 *base_vector)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	struct ath11k_msi_config *msi_config;
+	int idx;
+
+	msi_config = ab_pci->msi_config;
+	if (!msi_config) {
+		ath11k_err(ab, "MSI is not supported.\n");
+		return -EINVAL;
+	}
+
+	for (idx = 0; idx < msi_config->total_users; idx++) {
+		if (strcmp(user_name, msi_config->users[idx].name) == 0) {
+			*num_vectors = msi_config->users[idx].num_vectors;
+			*user_base_data = msi_config->users[idx].base_vector
+				+ ab_pci->msi_ep_base_data;
+			*base_vector = msi_config->users[idx].base_vector;
+
+			ath11k_dbg(ab, ATH11K_DBG_PCI, "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
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
+static int ath11k_pci_qca6x90_powerup(struct ath11k_pci *ab_pci)
+{
+	return ath11k_pci_start_mhi(ab_pci);
+}
+
+static void ath11k_pci_qca6x90_powerdown(struct ath11k_pci *ab_pci)
+{
+	ath11k_pci_stop_mhi(ab_pci);
+}
+
 static int ath11k_pci_get_msi_assignment(struct ath11k_pci *ab_pci)
 {
 	ab_pci->msi_config = &msi_config;
@@ -184,6 +240,34 @@ static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
 		pci_disable_device(pci_dev);
 }
 
+static int ath11k_pci_power_up(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci;
+	int ret;
+
+	ab_pci = ath11k_pci_priv(ab);
+	ret = ath11k_pci_qca6x90_powerup(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to power on  mhi: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ath11k_pci_power_down(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci;
+
+	ab_pci = ath11k_pci_priv(ab);
+	ath11k_pci_qca6x90_powerdown(ab_pci);
+}
+
+static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
+	.power_down = ath11k_pci_power_down,
+	.power_up = ath11k_pci_power_up,
+};
+
 static int ath11k_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *pci_dev)
 {
@@ -229,14 +313,26 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_free_core;
 	}
 
+	ab->mem = ab_pci->mem;
+	ab->mem_len = ab_pci->mem_len;
+
 	ret = ath11k_pci_enable_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to enable  msi: %d\n", ret);
 		goto err_pci_free_region;
 	}
 
+	ret = ath11k_pci_register_mhi(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to register  mhi: %d\n", ret);
+		goto err_pci_disable_msi;
+	}
+
 	return 0;
 
+err_pci_disable_msi:
+	ath11k_pci_disable_msi(ab_pci);
+
 err_pci_free_region:
 	ath11k_pci_free_region(ab_pci);
 
@@ -252,6 +348,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	ath11k_pci_unregister_mhi(ab_pci);
 	ath11k_pci_disable_msi(ab_pci);
 	ath11k_pci_free_region(ab_pci);
 	ath11k_core_free(ab);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 7c7fa1965aa6..83b485be6c50 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -2,6 +2,10 @@
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
  */
+#ifndef _ATH11K_PCI_H
+#define _ATH11K_PCI_H
+
+#include <linux/mhi.h>
 
 #define QCA6290_VENDOR_ID		0x17CB
 #define QCA6290_DEVICE_ID		0x1100
@@ -33,4 +37,13 @@ struct ath11k_pci {
 	u32 chip_id;
 	struct ath11k_msi_config *msi_config;
 	u32 msi_ep_base_data;
+	struct mhi_controller *mhi_ctrl;
+	unsigned long mhi_state;
 };
+
+int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_name,
+				       int *num_vectors, u32 *user_base_data,
+				       u32 *base_vector);
+
+int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector);
+#endif
-- 
2.22.0
