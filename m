Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F6245624
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgHPFcj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 01:32:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52995 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbgHPFci (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 01:32:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597555957; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wIQNI0xSeO/oUAAy7pzH4zlSD4j237vpDuq9RiEeDXw=; b=l8seEqR70CWmhNkDqcu4enTMurmHIq2yQ55bFNg19zi5cN/15NlPsvJGWm8pEAV/kF7Xw15x
 3diBDmSjiD88dVdgYEWzF2XMiCYupxQeSs3ZWGggbnv6buypiH0mgWyjbofobMO9WzKKu9eL
 dWlhCmivVXvR/sLPqLUxUg6qjXY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f38c4bb8567201751749731 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 05:31:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 690BAC43391; Sun, 16 Aug 2020 05:31:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 111F2C433CB;
        Sun, 16 Aug 2020 05:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 111F2C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/9] ath11k: enable DP interrupt setup for QCA6390
Date:   Sun, 16 Aug 2020 08:31:23 +0300
Message-Id: <1597555891-26112-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
References: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

QCA6390 uses MSI interrupt, so need to configure msi_add and
msi_data to dp srngs. As there are so many DP srngs, so need
to group them. Each group shares one MSI interrupt.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |   2 +-
 drivers/net/wireless/ath/ath11k/dp.c   | 108 ++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.c   |  37 +++++++
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 175 +++++++++++++++++++++++++++++++++
 5 files changed, 322 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b94630822d1e..45d16f7ad461 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -49,7 +49,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_radios = 3,
 		.bdf_addr = 0x4B0C0000,
 		.hw_ops = &qca6390_ops,
-		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
+		.ring_mask = &ath11k_hw_ring_mask_qca6390,
 		.internal_sleep_clock = true,
 		.regs = &qca6390_regs,
 		.host_ce_config = ath11k_host_ce_config_qca6390,
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index a3c4d36f850d..ac92f345a013 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -107,6 +107,113 @@ void ath11k_dp_srng_cleanup(struct ath11k_base *ab, struct dp_srng *ring)
 	ring->vaddr_unaligned = NULL;
 }
 
+static int ath11k_dp_srng_find_ring_in_mask(int ring_num, const u8 *grp_mask)
+{
+	int ext_group_num;
+	u8 mask = 1 << ring_num;
+
+	for (ext_group_num = 0; ext_group_num < ATH11K_EXT_IRQ_GRP_NUM_MAX;
+	     ext_group_num++) {
+		if (mask & grp_mask[ext_group_num])
+			return ext_group_num;
+	}
+
+	return -ENOENT;
+}
+
+static int ath11k_dp_srng_calculate_msi_group(struct ath11k_base *ab,
+					      enum hal_ring_type type, int ring_num)
+{
+	const u8 *grp_mask;
+
+	switch (type) {
+	case HAL_WBM2SW_RELEASE:
+		if (ring_num < 3) {
+			grp_mask = &ab->hw_params.ring_mask->tx[0];
+		} else if (ring_num == 3) {
+			grp_mask = &ab->hw_params.ring_mask->rx_wbm_rel[0];
+			ring_num = 0;
+		} else {
+			return -ENOENT;
+		}
+		break;
+	case HAL_REO_EXCEPTION:
+		grp_mask = &ab->hw_params.ring_mask->rx_err[0];
+		break;
+	case HAL_REO_DST:
+		grp_mask = &ab->hw_params.ring_mask->rx[0];
+		break;
+	case HAL_REO_STATUS:
+		grp_mask = &ab->hw_params.ring_mask->reo_status[0];
+		break;
+	case HAL_RXDMA_MONITOR_STATUS:
+	case HAL_RXDMA_MONITOR_DST:
+		grp_mask = &ab->hw_params.ring_mask->rx_mon_status[0];
+		break;
+	case HAL_RXDMA_DST:
+		grp_mask = &ab->hw_params.ring_mask->rxdma2host[0];
+		break;
+	case HAL_RXDMA_BUF:
+		grp_mask = &ab->hw_params.ring_mask->host2rxdma[0];
+		break;
+	case HAL_RXDMA_MONITOR_BUF:
+	case HAL_TCL_DATA:
+	case HAL_TCL_CMD:
+	case HAL_REO_CMD:
+	case HAL_SW2WBM_RELEASE:
+	case HAL_WBM_IDLE_LINK:
+	case HAL_TCL_STATUS:
+	case HAL_REO_REINJECT:
+	case HAL_CE_SRC:
+	case HAL_CE_DST:
+	case HAL_CE_DST_STATUS:
+	default:
+		return -ENOENT;
+	}
+
+	return ath11k_dp_srng_find_ring_in_mask(ring_num, grp_mask);
+}
+
+static void ath11k_dp_srng_msi_setup(struct ath11k_base *ab,
+				     struct hal_srng_params *ring_params,
+				     enum hal_ring_type type, int ring_num)
+{
+	int msi_group_number, msi_data_count;
+	u32 msi_data_start, msi_irq_start, addr_lo, addr_hi;
+	int ret;
+
+	ret = ath11k_get_user_msi_vector(ab, "DP",
+					 &msi_data_count, &msi_data_start,
+					 &msi_irq_start);
+	if (ret)
+		return;
+
+	msi_group_number = ath11k_dp_srng_calculate_msi_group(ab, type,
+							      ring_num);
+	if (msi_group_number < 0) {
+		ath11k_dbg(ab, ATH11K_DBG_PCI,
+			   "ring not part of an ext_group; ring_type: %d,ring_num %d",
+			   type, ring_num);
+		ring_params->msi_addr = 0;
+		ring_params->msi_data = 0;
+		return;
+	}
+
+	if (msi_group_number > msi_data_count) {
+		ath11k_dbg(ab, ATH11K_DBG_PCI,
+			   "multiple msi_groups share one msi, msi_group_num %d",
+			   msi_group_number);
+	}
+
+	ath11k_get_msi_address(ab, &addr_lo, &addr_hi);
+
+	ring_params->msi_addr = addr_lo;
+	ring_params->msi_addr |= (dma_addr_t)(((uint64_t)addr_hi) << 32);
+	ring_params->msi_data = (msi_group_number % msi_data_count)
+		+ msi_data_start;
+	ring_params->flags |= HAL_SRNG_FLAGS_MSI_INTR;
+}
+
 int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 			 enum hal_ring_type type, int ring_num,
 			 int mac_id, int num_entries)
@@ -136,6 +243,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 	params.ring_base_vaddr = ring->vaddr;
 	params.ring_base_paddr = ring->paddr;
 	params.num_entries = num_entries;
+	ath11k_dp_srng_msi_setup(ab, &params, type, ring_num + mac_id);
 
 	switch (type) {
 	case HAL_REO_DST:
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 338b784b0e84..9737b9f5e1b5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -208,6 +208,43 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074 = {
 	},
 };
 
+const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390 = {
+	.tx  = {
+		ATH11K_TX_RING_MASK_0,
+		ATH11K_TX_RING_MASK_1,
+		ATH11K_TX_RING_MASK_2,
+	},
+	.rx_mon_status = {
+		0, 0, 0, 0,
+		ATH11K_RX_MON_STATUS_RING_MASK_0,
+		ATH11K_RX_MON_STATUS_RING_MASK_1,
+		ATH11K_RX_MON_STATUS_RING_MASK_2,
+	},
+	.rx = {
+		0, 0, 0, 0, 0, 0, 0,
+		ATH11K_RX_RING_MASK_0,
+		ATH11K_RX_RING_MASK_1,
+		ATH11K_RX_RING_MASK_2,
+		ATH11K_RX_RING_MASK_3,
+	},
+	.rx_err = {
+		ATH11K_RX_ERR_RING_MASK_0,
+	},
+	.rx_wbm_rel = {
+		ATH11K_RX_WBM_REL_RING_MASK_0,
+	},
+	.reo_status = {
+		ATH11K_REO_STATUS_RING_MASK_0,
+	},
+	.rxdma2host = {
+		ATH11K_RXDMA2HOST_RING_MASK_0,
+		ATH11K_RXDMA2HOST_RING_MASK_1,
+		ATH11K_RXDMA2HOST_RING_MASK_2,
+	},
+	.host2rxdma = {
+	},
+};
+
 const struct ath11k_hw_regs ipq8074_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_base_lsb = 0x00000510,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 8db9534b176b..1c9176273883 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -158,6 +158,7 @@ extern const struct ath11k_hw_ops ipq6018_ops;
 extern const struct ath11k_hw_ops qca6390_ops;
 
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
+extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
 
 static inline
 int ath11k_hw_get_mac_from_pdev_id(struct ath11k_hw_params *hw,
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 2b5a8d3162d0..6a1e74f0d1ac 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -389,6 +389,20 @@ static int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_nam
 						  base_vector);
 }
 
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
 static void ath11k_pci_free_irq(struct ath11k_base *ab)
 {
 	int i, irq_idx;
@@ -399,6 +413,8 @@ static void ath11k_pci_free_irq(struct ath11k_base *ab)
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
 		free_irq(ab->irq_num[irq_idx], &ab->ce.ce_pipe[i]);
 	}
+
+	ath11k_pci_free_ext_irq(ab);
 }
 
 static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
@@ -461,6 +477,159 @@ static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void ath11k_pci_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
+{
+	int i;
+
+	for (i = 0; i < irq_grp->num_irq; i++)
+		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+}
+
+static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
+{
+	int i;
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
+	int i;
+
+	for (i = 0; i < irq_grp->num_irq; i++)
+		enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+}
+
+static void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
+{
+	int i;
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
+static void ath11k_pci_ext_irq_disable(struct ath11k_base *ab)
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
+
+	work_done = ath11k_dp_service_srng(ab, irq_grp, budget);
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		ath11k_pci_ext_grp_enable(irq_grp);
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
+
+	ath11k_dbg(irq_grp->ab, ATH11K_DBG_PCI, "ext irq:%d\n", irq);
+
+	ath11k_pci_ext_grp_disable(irq_grp);
+
+	napi_schedule(&irq_grp->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
+{
+	int i, j, ret, num_vectors = 0;
+	u32 user_base_data = 0, base_vector = 0;
+
+	ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
+					   &num_vectors, &user_base_data,
+					   &base_vector);
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
+		irq_grp->irqs[0] = base_vector + i;
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
+			ret = request_irq(irq, ath11k_pci_ext_interrupt_handler,
+					  IRQF_SHARED,
+					  "DP_EXT_IRQ", irq_grp);
+			if (ret) {
+				ath11k_err(ab, "failed request irq %d: %d\n",
+					   vector, ret);
+				return ret;
+			}
+
+			disable_irq_nosync(ab->irq_num[irq_idx]);
+		}
+	}
+
+	return 0;
+}
+
 static int ath11k_pci_config_irq(struct ath11k_base *ab)
 {
 	struct ath11k_ce_pipe *ce_pipe;
@@ -503,6 +672,10 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 		ath11k_pci_ce_irq_disable(ab, i);
 	}
 
+	ret = ath11k_pci_ext_irq_config(ab);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -757,6 +930,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.write32 = ath11k_pci_write32,
 	.power_down = ath11k_pci_power_down,
 	.power_up = ath11k_pci_power_up,
+	.irq_enable = ath11k_pci_ext_irq_enable,
+	.irq_disable = ath11k_pci_ext_irq_disable,
 	.get_msi_address =  ath11k_pci_get_msi_address,
 	.get_user_msi_vector = ath11k_get_user_msi_assignment,
 	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
-- 
2.7.4

