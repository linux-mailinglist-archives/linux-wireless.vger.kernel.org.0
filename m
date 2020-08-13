Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC624371D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMJEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:04:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:63560 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgHMJEs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:04:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597309487; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=8l7PihmuVAVu4HbcjvJ6CHvXutImpyQOzvP44dG8CPg=; b=KKocF9fXcd8fnuV73PEpsssWc7cjh6L3jJq8e9XHDD3j0IGC+tJqVFhIeC3zMiilnYHX4Zwt
 nMAwlyXswUnfTxvVGkWJVUMQRYplEVcY2lFQu8zaZDdaLVpxDeGJz83XaxCyvdIblrVNt3tY
 zi7DCgL0IdMtSamyNgXyNiQW2t4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f35022c2b87d66049dae060 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:04:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9561AC433C6; Thu, 13 Aug 2020 09:04:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01897C4339C;
        Thu, 13 Aug 2020 09:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01897C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/10] ath11k: register MHI controller device for QCA6390
Date:   Thu, 13 Aug 2020 12:04:24 +0300
Message-Id: <1597309466-19688-9-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
References: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

Modem Host Interface (MHI) is a communication protocol to communicate with
external Qualcomm modems and Wi-Fi chipsets over high speed peripheral buses.
Even though MHI doesn’t dictate underlying physical layer, protocol and MHI
stack is structured for PCI based devices.

Register directly with MHI subsystem as a MHI device driver for firmware
download to QCA6390.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Kconfig  |   3 +
 drivers/net/wireless/ath/ath11k/Makefile |   2 +-
 drivers/net/wireless/ath/ath11k/hw.h     |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c    | 423 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.h    |  28 ++
 drivers/net/wireless/ath/ath11k/pci.c    |  77 ++++++
 drivers/net/wireless/ath/ath11k/pci.h    |  14 +
 7 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.c
 create mode 100644 drivers/net/wireless/ath/ath11k/mhi.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 2a792ddd6fea..7e5094e0e7bb 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -21,6 +21,9 @@ config ATH11K_AHB
 config ATH11K_PCI
 	tristate "Atheros ath11k PCI support"
 	depends on ATH11K && PCI
+	select MHI_BUS
+	select QRTR
+	select QRTR_MHI
 	help
 	  This module adds support for PCIE bus
 
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 4d1807f52d92..bc4911f0339d 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
 
 obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
-ath11k_pci-y += pci.o
+ath11k_pci-y += mhi.o pci.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index a8cdf4d08be4..c02fd02839d4 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -72,6 +72,7 @@
 #define ATH11K_BOARD_API2_FILE		"board-2.bin"
 #define ATH11K_DEFAULT_BOARD_FILE	"board.bin"
 #define ATH11K_DEFAULT_CAL_FILE		"caldata.bin"
+#define ATH11K_AMSS_FILE		"amss.bin"
 
 enum ath11k_hw_rate_cck {
 	ATH11K_HW_RATE_CCK_LP_11M = 0,
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
new file mode 100644
index 000000000000..62d39ef6741f
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/* Copyright (c) 2020 The Linux Foundation. All rights reserved. */
+
+#include <linux/msi.h>
+#include <linux/pci.h>
+
+#include "core.h"
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
+		.data_type = MHI_ER_CTRL,
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
+static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
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
+		irq[i] = ath11k_pci_get_msi_irq(ab->dev,
+						base_vector + i);
+
+	ab_pci->mhi_ctrl->irq = irq;
+	ab_pci->mhi_ctrl->nr_irqs = num_vectors;
+
+	return 0;
+}
+
+static int ath11k_mhi_op_runtime_get(struct mhi_controller *mhi_cntrl)
+{
+	return 0;
+}
+
+static void ath11k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
+				    enum mhi_callback cb)
+{
+}
+
+static int ath11k_mhi_op_read_reg(struct mhi_controller *mhi_cntrl,
+				  void __iomem *addr,
+				  u32 *out)
+{
+	*out = readl(addr);
+
+	return 0;
+}
+
+static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
+				    void __iomem *addr,
+				    u32 val)
+{
+	writel(val, addr);
+}
+
+int ath11k_mhi_register(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	struct mhi_controller *mhi_ctrl;
+	int ret;
+
+	mhi_ctrl = kzalloc(sizeof(*mhi_ctrl), GFP_KERNEL);
+	if (!mhi_ctrl)
+		return PTR_ERR(mhi_ctrl);
+
+	ath11k_core_create_firmware_path(ab, ATH11K_AMSS_FILE,
+					 ab_pci->amss_path,
+					 sizeof(ab_pci->amss_path));
+
+	ab_pci->mhi_ctrl = mhi_ctrl;
+	mhi_ctrl->cntrl_dev = ab->dev;
+	mhi_ctrl->fw_image = ab_pci->amss_path;
+	mhi_ctrl->regs = ab->mem;
+
+	ret = ath11k_mhi_get_msi(ab_pci);
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
+	mhi_ctrl->runtime_get = ath11k_mhi_op_runtime_get;
+	mhi_ctrl->runtime_put = ath11k_mhi_op_runtime_put;
+	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
+	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
+	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
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
+void ath11k_mhi_unregister(struct ath11k_pci *ab_pci)
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
+static void ath11k_mhi_set_state_bit(struct ath11k_pci *ab_pci,
+				     enum ath11k_mhi_state mhi_state)
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
+static int ath11k_mhi_check_state_bit(struct ath11k_pci *ab_pci,
+				      enum ath11k_mhi_state mhi_state)
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
+static int ath11k_mhi_set_state(struct ath11k_pci *ab_pci,
+				enum ath11k_mhi_state mhi_state)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	int ret;
+
+	ret = ath11k_mhi_check_state_bit(ab_pci, mhi_state);
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
+	ath11k_mhi_set_state_bit(ab_pci, mhi_state);
+
+	return 0;
+
+out:
+	ath11k_err(ab, "failed to set mhi state: %s(%d)\n",
+		   ath11k_mhi_state_to_str(mhi_state), mhi_state);
+	return ret;
+}
+
+int ath11k_mhi_start(struct ath11k_pci *ab_pci)
+{
+	int ret;
+
+	ab_pci->mhi_ctrl->timeout_ms = MHI_TIMEOUT_DEFAULT_MS;
+
+	ret = ath11k_mhi_set_state(ab_pci, ATH11K_MHI_INIT);
+	if (ret)
+		goto out;
+
+	ret = ath11k_mhi_set_state(ab_pci, ATH11K_MHI_POWER_ON);
+	if (ret)
+		goto out;
+
+	return 0;
+
+out:
+	return ret;
+}
+
+void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
+{
+	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_RESUME);
+	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_POWER_OFF);
+	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_DEINIT);
+}
+
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
new file mode 100644
index 000000000000..3c91881b4fbd
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
+int ath11k_mhi_start(struct ath11k_pci *ar_pci);
+void ath11k_mhi_stop(struct ath11k_pci *ar_pci);
+int ath11k_mhi_register(struct ath11k_pci *ar_pci);
+void ath11k_mhi_unregister(struct ath11k_pci *ar_pci);
+
+#endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index ff401d2871f3..6f7789fa23d6 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -9,6 +9,8 @@
 
 #include "pci.h"
 #include "core.h"
+#include "hif.h"
+#include "mhi.h"
 #include "debug.h"
 
 #define ATH11K_PCI_BAR_NUM		0
@@ -34,6 +36,40 @@ static const struct ath11k_msi_config msi_config = {
 	},
 };
 
+int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return pci_irq_vector(pci_dev, vector);
+}
+
+int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
+				       int *num_vectors, u32 *user_base_data,
+				       u32 *base_vector)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	int idx;
+
+	for (idx = 0; idx < msi_config.total_users; idx++) {
+		if (strcmp(user_name, msi_config.users[idx].name) == 0) {
+			*num_vectors = msi_config.users[idx].num_vectors;
+			*user_base_data = msi_config.users[idx].base_vector
+				+ ab_pci->msi_ep_base_data;
+			*base_vector = msi_config.users[idx].base_vector;
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
 static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
@@ -161,6 +197,32 @@ static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
 		pci_disable_device(pci_dev);
 }
 
+static int ath11k_pci_power_up(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	int ret;
+
+	ret = ath11k_mhi_start(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to start mhi: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ath11k_pci_power_down(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	ath11k_mhi_stop(ab_pci);
+}
+
+static __maybe_unused const struct ath11k_hif_ops ath11k_pci_hif_ops = {
+	.power_down = ath11k_pci_power_down,
+	.power_up = ath11k_pci_power_up,
+};
+
 static int ath11k_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *pci_dev)
 {
@@ -212,6 +274,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_pci_disable_msi;
 
+	ret = ath11k_mhi_register(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to register mhi: %d\n", ret);
+		goto err_pci_disable_msi;
+	}
+
 	return 0;
 
 err_pci_disable_msi:
@@ -232,16 +300,25 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	ath11k_mhi_unregister(ab_pci);
 	ath11k_pci_disable_msi(ab_pci);
 	ath11k_pci_free_region(ab_pci);
 	ath11k_core_free(ab);
 }
 
+static void ath11k_pci_shutdown(struct pci_dev *pdev)
+{
+	struct ath11k_base *ab = pci_get_drvdata(pdev);
+
+	ath11k_pci_power_down(ab);
+}
+
 static struct pci_driver ath11k_pci_driver = {
 	.name = "ath11k_pci",
 	.id_table = ath11k_pci_id_table,
 	.probe = ath11k_pci_probe,
 	.remove = ath11k_pci_remove,
+	.shutdown = ath11k_pci_shutdown,
 };
 
 static int ath11k_pci_init(void)
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index db75eae26f71..85e033069d7a 100644
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
 
 #include "core.h"
 
@@ -21,10 +25,20 @@ struct ath11k_pci {
 	struct pci_dev *pdev;
 	struct ath11k_base *ab;
 	u16 dev_id;
+	char amss_path[100];
 	u32 msi_ep_base_data;
+	struct mhi_controller *mhi_ctrl;
+	unsigned long mhi_state;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
 {
 	return (struct ath11k_pci *)ab->drv_priv;
 }
+
+int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_name,
+				       int *num_vectors, u32 *user_base_data,
+				       u32 *base_vector);
+int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector);
+
+#endif
-- 
2.7.4

