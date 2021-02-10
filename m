Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC50316166
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBJIrm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:42 -0500
Received: from so15.mailgun.net ([198.61.254.15]:20318 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhBJInj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946594; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=iWJxyWRGfWKCwlmSm2xDWDIqPph8aobepFVNHV1INQQ=; b=LEzQ3o2pzQO0AebPxyu7kv1goe/IIi/wshiCrCf7X3CzEQzFlBF+X5EUPurumljJA6VLZCwM
 f+lD9905pryRFVUhOLd1dkYtQzTaf98n8MPa7tG5NaRqLWfup5UxDntnbv4SvSceVsnoryCY
 DAmfI9oOa3T9NIaZLgVIu35rZL4=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60239c84830f898bacf21570 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:44
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFFC0C4346E; Wed, 10 Feb 2021 08:42:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BDE5C4346E;
        Wed, 10 Feb 2021 08:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BDE5C4346E
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH 10/11] ath11k: add extended interrupt support for QCN9074
Date:   Wed, 10 Feb 2021 14:12:09 +0530
Message-Id: <1612946530-28504-11-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Update the specific hw ring mask for QCN9074. Update the timestamp
information while processing DP and CE interrupts.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  |  1 +
 drivers/net/wireless/ath/ath11k/dp_tx.c |  4 ++--
 drivers/net/wireless/ath/ath11k/hw.c    | 41 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 drivers/net/wireless/ath/ath11k/pci.c   | 13 +++++++++--
 5 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 82b5e8c41f8f..ddedc331edef 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -162,6 +162,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.single_pdev_only = false,
 		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9074,
 		.hw_ops = &qcn9074_ops,
+		.ring_mask = &ath11k_hw_ring_mask_qcn9074,
 		.internal_sleep_clock = false,
 		.regs = &qcn9074_regs,
 		.host_ce_config = ath11k_host_ce_config_qcn9074,
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index f5c277977e08..8bba5234f81f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -792,8 +792,8 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 	cmd->ring_tail_off32_remote_addr_hi = (u64)tp_addr >>
 					      HAL_ADDR_MSB_REG_SHIFT;
 
-	cmd->ring_msi_addr_lo = params.msi_addr & 0xffffffff;
-	cmd->ring_msi_addr_hi = ((uint64_t)(params.msi_addr) >> 32) & 0xffffffff;
+	cmd->ring_msi_addr_lo = lower_32_bits(params.msi_addr);
+	cmd->ring_msi_addr_hi = upper_32_bits(params.msi_addr);
 	cmd->msi_data = params.msi_data;
 
 	cmd->intr_info = FIELD_PREP(
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index c943e34c3721..377ae8d5b58f 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1435,6 +1435,47 @@ const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qcn9074[] = {
 	},
 };
 
+const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074 = {
+	.tx  = {
+		ATH11K_TX_RING_MASK_0,
+		ATH11K_TX_RING_MASK_1,
+		ATH11K_TX_RING_MASK_2,
+	},
+	.rx_mon_status = {
+		0, 0, 0,
+		ATH11K_RX_MON_STATUS_RING_MASK_0,
+		ATH11K_RX_MON_STATUS_RING_MASK_1,
+		ATH11K_RX_MON_STATUS_RING_MASK_2,
+	},
+	.rx = {
+		0, 0, 0, 0,
+		ATH11K_RX_RING_MASK_0,
+		ATH11K_RX_RING_MASK_1,
+		ATH11K_RX_RING_MASK_2,
+		ATH11K_RX_RING_MASK_3,
+	},
+	.rx_err = {
+		0, 0, 0,
+		ATH11K_RX_ERR_RING_MASK_0,
+	},
+	.rx_wbm_rel = {
+		0, 0, 0,
+		ATH11K_RX_WBM_REL_RING_MASK_0,
+	},
+	.reo_status = {
+		0, 0, 0,
+		ATH11K_REO_STATUS_RING_MASK_0,
+	},
+	.rxdma2host = {
+		0, 0, 0,
+		ATH11K_RXDMA2HOST_RING_MASK_0,
+	},
+	.host2rxdma = {
+		0, 0, 0,
+		ATH11K_HOST2RXDMA_RING_MASK_0,
+	},
+};
+
 const struct ath11k_hw_regs ipq8074_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_base_lsb = 0x00000510,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 54b7edfc4f88..c81a6328361d 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -208,6 +208,7 @@ extern const struct ath11k_hw_ops qcn9074_ops;
 
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
+extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074;
 
 static inline
 int ath11k_hw_get_mac_from_pdev_id(struct ath11k_hw_params *hw,
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index fd6bbbc102ba..70dcb80475b1 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -592,6 +592,9 @@ static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ce_pipe *ce_pipe = arg;
 
+	/* last interrupt received for this CE */
+	ce_pipe->timestamp = jiffies;
+
 	ath11k_pci_ce_irq_disable(ce_pipe->ab, ce_pipe->pipe_num);
 	tasklet_schedule(&ce_pipe->intr_tq);
 
@@ -686,6 +689,9 @@ static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 
 	ath11k_dbg(irq_grp->ab, ATH11K_DBG_PCI, "ext irq:%d\n", irq);
 
+	/* last interrupt received for this group */
+	irq_grp->timestamp = jiffies;
+
 	ath11k_pci_ext_grp_disable(irq_grp);
 
 	napi_schedule(&irq_grp->napi);
@@ -696,8 +702,9 @@ static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 {
 	int i, j, ret, num_vectors = 0;
-	u32 user_base_data = 0, base_vector = 0;
+	u32 user_base_data = 0, base_vector = 0, base_idx;
 
+	base_idx = ATH11K_PCI_IRQ_CE0_OFFSET + CE_COUNT_MAX;
 	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
 						 &num_vectors,
 						 &user_base_data,
@@ -727,7 +734,7 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 		}
 
 		irq_grp->num_irq = num_irq;
-		irq_grp->irqs[0] = base_vector + i;
+		irq_grp->irqs[0] = base_idx + i;
 
 		for (j = 0; j < irq_grp->num_irq; j++) {
 			int irq_idx = irq_grp->irqs[j];
@@ -738,6 +745,8 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 
 			ath11k_dbg(ab, ATH11K_DBG_PCI,
 				   "irq:%d group:%d\n", irq, i);
+
+			irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
 			ret = request_irq(irq, ath11k_pci_ext_interrupt_handler,
 					  IRQF_SHARED,
 					  "DP_EXT_IRQ", irq_grp);
-- 
2.7.4

