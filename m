Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1731615A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhBJIqz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:46:55 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:11573 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhBJInf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946579; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+RD+gABO8boETdOgGmC4BfysfBIgpogreoFPG8mXf4M=; b=paRu2g+f9vFUk49KQagkTAJeSYtwsl7U/D8iAVh4efs4HUSpRo9ub1hb+Bdf6H4Bi67L0DBy
 ZXg1LBjc4dgKey4gKxikbJ/aGOhVe0JkuhliFQJglZf1vlumL44pnNcwHbb16ArnkA8cfNxB
 QSqyblY/PJCcO9KUcJKWn3/3ur8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60239c7a34db06ef79f40ae7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:34
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EAC4BC43462; Wed, 10 Feb 2021 08:42:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9790FC433C6;
        Wed, 10 Feb 2021 08:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9790FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 05/11] ath11k: Add qcn9074 mhi controller config
Date:   Wed, 10 Feb 2021 14:12:04 +0530
Message-Id: <1612946530-28504-6-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add MHI config for QCN9074 also populate ath11k_hw_params for QCN9074.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  12 ++++
 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c  | 116 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/qmi.h  |   1 +
 4 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 9ccc7231afa0..fa452de49457 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -147,6 +147,18 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = false,
 		.supports_suspend = true,
 	},
+	{
+		.name = "qcn9074 hw1.0",
+		.hw_rev = ATH11K_HW_QCN9074_HW10,
+		.fw = {
+			.dir = "QCN9074/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_size = 256 * 1024,
+		},
+		.max_radios = 1,
+		.single_pdev_only = false,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9074,
+	},
 };
 
 int ath11k_core_suspend(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 8d29845774df..9a8fb23577b0 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -105,6 +105,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_IPQ8074,
 	ATH11K_HW_QCA6390_HW20,
 	ATH11K_HW_IPQ6018_HW10,
+	ATH11K_HW_QCN9074_HW10,
 };
 
 enum ath11k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 09858e516903..626764da4d6f 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -7,10 +7,11 @@
 #include "core.h"
 #include "debug.h"
 #include "mhi.h"
+#include "pci.h"
 
 #define MHI_TIMEOUT_DEFAULT_MS	90000
 
-static struct mhi_channel_config ath11k_mhi_channels[] = {
+static struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 	{
 		.num = 0,
 		.name = "LOOPBACK",
@@ -69,7 +70,7 @@ static struct mhi_channel_config ath11k_mhi_channels[] = {
 	},
 };
 
-static struct mhi_event_config ath11k_mhi_events[] = {
+static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
 	{
 		.num_elements = 32,
 		.irq_moderation_ms = 0,
@@ -92,15 +93,108 @@ static struct mhi_event_config ath11k_mhi_events[] = {
 	},
 };
 
-static struct mhi_controller_config ath11k_mhi_config = {
+static struct mhi_controller_config ath11k_mhi_config_qca6390 = {
 	.max_channels = 128,
 	.timeout_ms = 2000,
 	.use_bounce_buf = false,
 	.buf_len = 0,
-	.num_channels = ARRAY_SIZE(ath11k_mhi_channels),
-	.ch_cfg = ath11k_mhi_channels,
-	.num_events = ARRAY_SIZE(ath11k_mhi_events),
-	.event_cfg = ath11k_mhi_events,
+	.num_channels = ARRAY_SIZE(ath11k_mhi_channels_qca6390),
+	.ch_cfg = ath11k_mhi_channels_qca6390,
+	.num_events = ARRAY_SIZE(ath11k_mhi_events_qca6390),
+	.event_cfg = ath11k_mhi_events_qca6390,
+};
+
+static struct mhi_channel_config ath11k_mhi_channels_qcn9074[] = {
+	{
+		.num = 0,
+		.name = "LOOPBACK",
+		.num_elements = 32,
+		.event_ring = 1,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = 0x14,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = false,
+	},
+	{
+		.num = 1,
+		.name = "LOOPBACK",
+		.num_elements = 32,
+		.event_ring = 1,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = 0x14,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = false,
+	},
+	{
+		.num = 20,
+		.name = "IPCR",
+		.num_elements = 32,
+		.event_ring = 1,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = 0x14,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = false,
+	},
+	{
+		.num = 21,
+		.name = "IPCR",
+		.num_elements = 32,
+		.event_ring = 1,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = 0x14,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.auto_queue = true,
+	},
+};
+
+static struct mhi_event_config ath11k_mhi_events_qcn9074[] = {
+	{
+		.num_elements = 32,
+		.irq_moderation_ms = 0,
+		.irq = 1,
+		.data_type = MHI_ER_CTRL,
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
+static struct mhi_controller_config ath11k_mhi_config_qcn9074 = {
+	.max_channels = 30,
+	.timeout_ms = 10000,
+	.use_bounce_buf = false,
+	.buf_len = 0,
+	.num_channels = ARRAY_SIZE(ath11k_mhi_channels_qcn9074),
+	.ch_cfg = ath11k_mhi_channels_qcn9074,
+	.num_events = ARRAY_SIZE(ath11k_mhi_events_qcn9074),
+	.event_cfg = ath11k_mhi_events_qcn9074,
 };
 
 void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab)
@@ -221,6 +315,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
 	struct mhi_controller *mhi_ctrl;
+	struct mhi_controller_config *ath11k_mhi_config;
 	int ret;
 
 	mhi_ctrl = mhi_alloc_controller();
@@ -254,7 +349,12 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
 
-	ret = mhi_register_controller(mhi_ctrl, &ath11k_mhi_config);
+	if (ab->hw_rev == ATH11K_HW_QCA6390_HW20)
+		ath11k_mhi_config = &ath11k_mhi_config_qca6390;
+	else if (ab->hw_rev == ATH11K_HW_QCN9074_HW10)
+		ath11k_mhi_config = &ath11k_mhi_config_qcn9074;
+
+	ret = mhi_register_controller(mhi_ctrl, ath11k_mhi_config);
 	if (ret) {
 		ath11k_err(ab, "failed to register to mhi bus, err = %d\n", ret);
 		mhi_free_controller(mhi_ctrl);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index a7d01c295e77..3d5930330703 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -21,6 +21,7 @@
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390	0x01
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074	0x02
+#define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9074	0x07
 #define ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
 #define ATH11K_QMI_RESP_LEN_MAX			8192
 #define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	52
-- 
2.7.4

