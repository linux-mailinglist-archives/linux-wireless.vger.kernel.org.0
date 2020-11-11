Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CE22AF89F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 19:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKKS7I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 13:59:08 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:62538 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgKKS7I (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 13:59:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605121146; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=b1qq6GftP132mYGAoigZ6LeknGWu/8lRV+j3tScYzCQ=; b=Gpww6eIENTREo0vHpW7ON88+BAkTEAaQ0xBkHH5EBCZ6WLuzLyPg7CG7m7t+e94F+Jf3iyl8
 u9dyF3Y0EPHYUZstZLYODwgZQIiMxJENr8UPdWPpjrJt5X2tSWLxAOw//n/9oAbkuVa+ZpGM
 PvpSPzYJI4IQJeJvV6vXouSfHGs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fac3455cecc309dcb4bffa7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 18:58:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29927C433C8; Wed, 11 Nov 2020 18:58:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B227C433C8;
        Wed, 11 Nov 2020 18:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B227C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH RFT] ath11k: pci: support platforms with one MSI vector
Date:   Wed, 11 Nov 2020 20:58:22 +0200
Message-Id: <1605121102-14352-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Dell XPS 13 9310 has only one MSI vector available for QCA6390 device and ath11k fails with:

ath11k_pci 0000:56:00.0: failed to get 32 MSI vectors, only -28 available
ath11k_pci 0000:56:00.0: failed to enable msi: -28
ath11k_pci: probe of 0000:56:00.0 failed with error -28

This is a proof of concept patch for getting ath11k to work with QCA6390 using
only one MSI vector, not the final solution. Testing feedback more than
welcome. The patch applies to v5.10-rc2.

The idea here is to add a flag to indicate whether this ISR can be called
or not as all the ISR handlers are registered with IRQF_SHARED when ath11k can
only request 1 vector. This needs to be refined later.

In some scenarios, kernel crashed when the interrupt migration happens, so add
IRQF_NOBALANCING.

Also add debug messages to ath11k_qmi_respond_fw_mem_request() for helping to
debug mysterious firmware initialisation timeouts:

ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110

If that happens, one way to workaround the problem is to revert this commit:

7fef431be9c9 mm/page_alloc: place pages to tail in __free_pages_core()

Link: https://lore.kernel.org/linux-pci/87mtzxkus5.fsf@nanos.tec.linutronix.de/
Link: http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/bus/mhi/core/init.c            |   4 +-
 drivers/net/wireless/ath/ath11k/ce.c   |   6 +-
 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/dp.c   |   8 +-
 drivers/net/wireless/ath/ath11k/hif.h  |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  11 +-
 drivers/net/wireless/ath/ath11k/pci.c  | 178 +++++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/pci.h  |   1 +
 drivers/net/wireless/ath/ath11k/qmi.c  |   4 +
 9 files changed, 174 insertions(+), 40 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 0ffdebde8265..d182ffdbaf64 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -153,7 +153,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 	/* Setup BHI_INTVEC IRQ */
 	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handler,
 				   mhi_intvec_threaded_handler,
-				   IRQF_SHARED | IRQF_NO_SUSPEND,
+				   IRQF_SHARED | IRQF_NOBALANCING,
 				   "bhi", mhi_cntrl);
 	if (ret)
 		return ret;
@@ -171,7 +171,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 
 		ret = request_irq(mhi_cntrl->irq[mhi_event->irq],
 				  mhi_irq_handler,
-				  IRQF_SHARED | IRQF_NO_SUSPEND,
+				  IRQF_SHARED | IRQF_NOBALANCING,
 				  "mhi", mhi_event);
 		if (ret) {
 			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 9d730f8ac816..46c717a344c3 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -459,20 +459,22 @@ static void ath11k_ce_srng_msi_ring_params_setup(struct ath11k_base *ab, u32 ce_
 	u32 msi_irq_start;
 	u32 addr_lo;
 	u32 addr_hi;
+	u32 vectors_32_capability;
 	int ret;
 
 	ret = ath11k_get_user_msi_vector(ab, "CE",
 					 &msi_data_count, &msi_data_start,
 					 &msi_irq_start);
-
 	if (ret)
 		return;
+	vectors_32_capability = ab->hif.ops->is_32_vecs_support(ab);
 
 	ath11k_get_msi_address(ab, &addr_lo, &addr_hi);
 
 	ring_params->msi_addr = addr_lo;
 	ring_params->msi_addr |= (dma_addr_t)(((uint64_t)addr_hi) << 32);
-	ring_params->msi_data = (ce_id % msi_data_count) + msi_data_start;
+	ring_params->msi_data = vectors_32_capability ?
+		(ce_id % msi_data_count) + msi_data_start : msi_data_start;
 	ring_params->flags |= HAL_SRNG_FLAGS_MSI_INTR;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 18b97420f0d8..0de6b2cd8c75 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -683,6 +683,7 @@ struct ath11k_base {
 	bool wmi_ready;
 	u32 wlan_init_status;
 	int irq_num[ATH11K_IRQ_NUM_MAX];
+	int irq_enable_flag[ATH11K_IRQ_NUM_MAX];
 	struct ath11k_ext_irq_grp ext_irq_grp[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 	struct napi_struct *napi;
 	struct ath11k_targ_cap target_caps;
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 59dd185a0cfc..b7288dc47199 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -180,13 +180,15 @@ static void ath11k_dp_srng_msi_setup(struct ath11k_base *ab,
 {
 	int msi_group_number, msi_data_count;
 	u32 msi_data_start, msi_irq_start, addr_lo, addr_hi;
-	int ret;
+	u32 vectors_32_capability;
+	int ret = -EINVAL;
 
 	ret = ath11k_get_user_msi_vector(ab, "DP",
 					 &msi_data_count, &msi_data_start,
 					 &msi_irq_start);
 	if (ret)
 		return;
+	vectors_32_capability = ab->hif.ops->is_32_vecs_support(ab);
 
 	msi_group_number = ath11k_dp_srng_calculate_msi_group(ab, type,
 							      ring_num);
@@ -209,8 +211,8 @@ static void ath11k_dp_srng_msi_setup(struct ath11k_base *ab,
 
 	ring_params->msi_addr = addr_lo;
 	ring_params->msi_addr |= (dma_addr_t)(((uint64_t)addr_hi) << 32);
-	ring_params->msi_data = (msi_group_number % msi_data_count)
-		+ msi_data_start;
+	ring_params->msi_data = vectors_32_capability ?
+		(msi_group_number % msi_data_count) + msi_data_start : msi_data_start;
 	ring_params->flags |= HAL_SRNG_FLAGS_MSI_INTR;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index dbe5568916e8..b6bde194a390 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -24,6 +24,7 @@ struct ath11k_hif_ops {
 				   u32 *base_vector);
 	void (*get_msi_address)(struct ath11k_base *ab, u32 *msi_addr_lo,
 				u32 *msi_addr_hi);
+	int (*is_32_vecs_support)(struct ath11k_base *ab);
 };
 
 static inline int ath11k_hif_start(struct ath11k_base *sc)
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index aded9a719d51..80d7dd18034d 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -156,14 +156,17 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
 	u32 user_base_data, base_vector;
+	u32 vectors_32_capability;
 	int ret, num_vectors, i;
 	int *irq;
+	unsigned int msi_data;
 
 	ret = ath11k_pci_get_user_msi_assignment(ab_pci,
 						 "MHI", &num_vectors,
 						 &user_base_data, &base_vector);
 	if (ret)
 		return ret;
+	vectors_32_capability = ab_pci->vectors_32_capability;
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "Number of assigned MSI for MHI is %d, base vector is %d\n",
 		   num_vectors, base_vector);
@@ -172,9 +175,13 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	if (!irq)
 		return -ENOMEM;
 
-	for (i = 0; i < num_vectors; i++)
+	for (i = 0; i < num_vectors; i++) {
+		msi_data = vectors_32_capability ?
+			   i + base_vector : base_vector;
+
 		irq[i] = ath11k_pci_get_msi_irq(ab->dev,
-						base_vector + i);
+						msi_data);
+	}
 
 	ab_pci->mhi_ctrl->irq = irq;
 	ab_pci->mhi_ctrl->nr_irqs = num_vectors;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d7eb6b7160bb..a7a98bdc0c5f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -17,6 +17,7 @@
 #define ATH11K_PCI_DMA_MASK		32
 
 #define ATH11K_PCI_IRQ_CE0_OFFSET		3
+#define ATH11K_PCI_IRQ_DP_OFFSET		14
 
 #define WINDOW_ENABLE_BIT		0x40000000
 #define WINDOW_REG_ADDRESS		0x310c
@@ -265,12 +266,17 @@ static void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
 				       u32 *msi_addr_hi)
 {
 	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+	u16 is_64bits;
 
 	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
 			      msi_addr_lo);
+	pci_read_config_word(pci_dev, pci_dev->msi_cap + PCI_MSI_FLAGS, &is_64bits);
 
-	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
-			      msi_addr_hi);
+	if (is_64bits & PCI_MSI_FLAGS_64BIT)
+		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
+				      msi_addr_hi);
+	else
+		*msi_addr_hi = 0;
 }
 
 int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
@@ -278,14 +284,15 @@ int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_nam
 				       u32 *base_vector)
 {
 	struct ath11k_base *ab = ab_pci->ab;
+	u32 msi_32_cap = ab_pci->vectors_32_capability;
 	int idx;
 
 	for (idx = 0; idx < msi_config.total_users; idx++) {
 		if (strcmp(user_name, msi_config.users[idx].name) == 0) {
 			*num_vectors = msi_config.users[idx].num_vectors;
-			*user_base_data = msi_config.users[idx].base_vector
-				+ ab_pci->msi_ep_base_data;
-			*base_vector = msi_config.users[idx].base_vector;
+			*base_vector = msi_32_cap ?
+				  msi_config.users[idx].base_vector : 0;
+			*user_base_data = *base_vector + ab_pci->msi_ep_base_data;
 
 			ath11k_dbg(ab, ATH11K_DBG_PCI, "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
 				   user_name, *num_vectors, *user_base_data,
@@ -339,20 +346,38 @@ static void ath11k_pci_free_irq(struct ath11k_base *ab)
 	ath11k_pci_free_ext_irq(ab);
 }
 
+static void ath11k_pci_set_irq_enable_flag(struct ath11k_base *ab, u32 irq_idx, int flag)
+{
+	ab->irq_enable_flag[irq_idx] = flag;
+}
+
 static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 {
 	u32 irq_idx;
+	u32 vecs_32_cap;
 
-	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
-	enable_irq(ab->irq_num[irq_idx]);
+	vecs_32_cap = ath11k_pci_priv(ab)->vectors_32_capability;
+	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET  + ce_id;
+
+	if (vecs_32_cap)
+		enable_irq(ab->irq_num[irq_idx]);
+
+	ath11k_pci_set_irq_enable_flag(ab, irq_idx, 1);
 }
 
 static void ath11k_pci_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
 {
 	u32 irq_idx;
+	u32 vecs_32_cap;
 
+	vecs_32_cap = ath11k_pci_priv(ab)->vectors_32_capability;
 	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
-	disable_irq_nosync(ab->irq_num[irq_idx]);
+
+	/* Cannot disable the irq when using one msi interrupt */
+	if (vecs_32_cap)
+		disable_irq_nosync(ab->irq_num[irq_idx]);
+
+	ath11k_pci_set_irq_enable_flag(ab, irq_idx, 0);
 }
 
 static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
@@ -382,18 +407,28 @@ static void ath11k_pci_sync_ce_irqs(struct ath11k_base *ab)
 
 static void ath11k_pci_ce_tasklet(unsigned long data)
 {
+
 	struct ath11k_ce_pipe *ce_pipe = (struct ath11k_ce_pipe *)data;
+	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
 
 	ath11k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
 
-	ath11k_pci_ce_irq_enable(ce_pipe->ab, ce_pipe->pipe_num);
+	enable_irq(ce_pipe->ab->irq_num[irq_idx]);
 }
 
 static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ce_pipe *ce_pipe = arg;
+	struct ath11k_base *ab = ce_pipe->ab;
+	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
+
+	disable_irq_nosync(ab->irq_num[irq_idx]);
+
+	if (!ab->irq_enable_flag[irq_idx]) {
+		enable_irq(ab->irq_num[irq_idx]);
+		return IRQ_HANDLED;
+	}
 
-	ath11k_pci_ce_irq_disable(ce_pipe->ab, ce_pipe->pipe_num);
 	tasklet_schedule(&ce_pipe->intr_tq);
 
 	return IRQ_HANDLED;
@@ -402,9 +437,16 @@ static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 static void ath11k_pci_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
 {
 	int i;
+	u32 vecs_32_cap;
 
-	for (i = 0; i < irq_grp->num_irq; i++)
-		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+	vecs_32_cap = ath11k_pci_priv(irq_grp->ab)->vectors_32_capability;
+
+	for (i = 0; i < irq_grp->num_irq; i++) {
+		if (vecs_32_cap)
+			disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+
+		ath11k_pci_set_irq_enable_flag(irq_grp->ab, irq_grp->irqs[i], 0);
+	}
 }
 
 static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
@@ -424,9 +466,15 @@ static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
 static void ath11k_pci_ext_grp_enable(struct ath11k_ext_irq_grp *irq_grp)
 {
 	int i;
+	u32 vecs_32_cap;
 
-	for (i = 0; i < irq_grp->num_irq; i++)
-		enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+	vecs_32_cap = ath11k_pci_priv(irq_grp->ab)->vectors_32_capability;
+
+	for (i = 0; i < irq_grp->num_irq; i++) {
+		if (vecs_32_cap)
+			enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+		ath11k_pci_set_irq_enable_flag(irq_grp->ab, irq_grp->irqs[i], 1);
+	}
 }
 
 static void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
@@ -468,11 +516,13 @@ static int ath11k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 						napi);
 	struct ath11k_base *ab = irq_grp->ab;
 	int work_done;
+	int i;
 
 	work_done = ath11k_dp_service_srng(ab, irq_grp, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
-		ath11k_pci_ext_grp_enable(irq_grp);
+		for (i = 0; i < irq_grp->num_irq; i++)
+			enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
 	}
 
 	if (work_done > budget)
@@ -484,10 +534,16 @@ static int ath11k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ext_irq_grp *irq_grp = arg;
+	int i;
 
-	ath11k_dbg(irq_grp->ab, ATH11K_DBG_PCI, "ext irq:%d\n", irq);
+	for (i = 0; i < irq_grp->num_irq; i++)
+		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
 
-	ath11k_pci_ext_grp_disable(irq_grp);
+	if (!irq_grp->ab->irq_enable_flag[irq_grp->irqs[0]]) {
+		for (i = 0; i < irq_grp->num_irq; i++)
+			enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+		return IRQ_HANDLED;
+	}
 
 	napi_schedule(&irq_grp->napi);
 
@@ -498,6 +554,7 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 {
 	int i, j, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
+	u32 vecs_32_cap;
 
 	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
 						 &num_vectors,
@@ -506,6 +563,8 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 	if (ret < 0)
 		return ret;
 
+	vecs_32_cap = ath11k_pci_priv(ab)->vectors_32_capability;
+
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 		u32 num_irq = 0;
@@ -528,11 +587,12 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 		}
 
 		irq_grp->num_irq = num_irq;
-		irq_grp->irqs[0] = base_vector + i;
+		irq_grp->irqs[0] = ATH11K_PCI_IRQ_DP_OFFSET + i;
 
 		for (j = 0; j < irq_grp->num_irq; j++) {
 			int irq_idx = irq_grp->irqs[j];
-			int vector = (i % num_vectors) + base_vector;
+			int vector = vecs_32_cap ?
+				(i % num_vectors) + base_vector : base_vector;
 			int irq = ath11k_pci_get_msi_irq(ab->dev, vector);
 
 			ab->irq_num[irq_idx] = irq;
@@ -540,7 +600,7 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 			ath11k_dbg(ab, ATH11K_DBG_PCI,
 				   "irq:%d group:%d\n", irq, i);
 			ret = request_irq(irq, ath11k_pci_ext_interrupt_handler,
-					  IRQF_SHARED,
+					  IRQF_SHARED | IRQF_NOBALANCING,
 					  "DP_EXT_IRQ", irq_grp);
 			if (ret) {
 				ath11k_err(ab, "failed request irq %d: %d\n",
@@ -548,7 +608,11 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 				return ret;
 			}
 
-			disable_irq_nosync(ab->irq_num[irq_idx]);
+			/* balance irq_enable */
+			if (vecs_32_cap)
+				disable_irq_nosync(ab->irq_num[irq_idx]);
+
+			ath11k_pci_set_irq_enable_flag(ab, irq_idx, 0);
 		}
 	}
 
@@ -561,6 +625,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 	u32 msi_data_start;
 	u32 msi_data_count;
 	u32 msi_irq_start;
+	u32 vecs_32_cap;
 	unsigned int msi_data;
 	int irq, i, ret, irq_idx;
 
@@ -570,9 +635,13 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
+	vecs_32_cap = ath11k_pci_priv(ab)->vectors_32_capability;
+
 	/* Configure CE irqs */
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
-		msi_data = (i % msi_data_count) + msi_irq_start;
+		msi_data = vecs_32_cap ?
+			   (i % msi_data_count) + msi_irq_start : msi_irq_start;
+
 		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
 		ce_pipe = &ab->ce.ce_pipe[i];
 
@@ -585,7 +654,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 			     (unsigned long)ce_pipe);
 
 		ret = request_irq(irq, ath11k_pci_ce_interrupt_handler,
-				  IRQF_SHARED, irq_name[irq_idx],
+				  IRQF_SHARED | IRQF_NOBALANCING, irq_name[irq_idx],
 				  ce_pipe);
 		if (ret) {
 			ath11k_err(ab, "failed to request irq %d: %d\n",
@@ -641,14 +710,19 @@ static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 					    msi_config.total_vectors,
 					    msi_config.total_vectors,
 					    PCI_IRQ_MSI);
-	if (num_vectors != msi_config.total_vectors) {
-		ath11k_err(ab, "failed to get %d MSI vectors, only %d available",
-			   msi_config.total_vectors, num_vectors);
-
-		if (num_vectors >= 0)
-			return -EINVAL;
-		else
-			return num_vectors;
+
+	if (num_vectors == msi_config.total_vectors) {
+		ab_pci->vectors_32_capability = 1;
+	} else {
+		ab_pci->vectors_32_capability = 0;
+		num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
+						    1,
+						    1,
+						    PCI_IRQ_MSI);
+		if (num_vectors < 0) {
+			ret = -EINVAL;
+			goto reset_msi_config;
+		}
 	}
 
 	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
@@ -658,6 +732,8 @@ static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 		goto free_msi_vector;
 	}
 
+	ath11k_info(ab, "MSI vectors: %d", num_vectors);
+
 	ab_pci->msi_ep_base_data = msi_desc->msg.data;
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab_pci->msi_ep_base_data);
@@ -667,6 +743,7 @@ static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 free_msi_vector:
 	pci_free_irq_vectors(ab_pci->pdev);
 
+reset_msi_config:
 	return ret;
 }
 
@@ -675,6 +752,32 @@ static void ath11k_pci_disable_msi(struct ath11k_pci *ab_pci)
 	pci_free_irq_vectors(ab_pci->pdev);
 }
 
+static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
+{
+	struct msi_desc *msi_desc;
+	int ret;
+
+	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
+
+	if (!msi_desc) {
+		ath11k_err(ab_pci->ab, "msi_desc is NULL!\n");
+		ret = -EINVAL;
+		goto free_msi_vector;
+	}
+
+	ab_pci->msi_ep_base_data = msi_desc->msg.data;
+
+	ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "msi base data is %d\n",
+		   ab_pci->msi_ep_base_data);
+
+	return 0;
+
+ free_msi_vector:
+	pci_free_irq_vectors(ab_pci->pdev);
+
+	return ret;
+}
+
 static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 {
 	struct ath11k_base *ab = ab_pci->ab;
@@ -862,6 +965,11 @@ static int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	return 0;
 }
 
+static int ath11k_pci_is_32_vectors_support(struct ath11k_base *ab)
+{
+	return ath11k_pci_priv(ab)->vectors_32_capability;
+}
+
 static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.start = ath11k_pci_start,
 	.stop = ath11k_pci_stop,
@@ -874,6 +982,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.get_msi_address =  ath11k_pci_get_msi_address,
 	.get_user_msi_vector = ath11k_get_user_msi_assignment,
 	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
+	.is_32_vecs_support = ath11k_pci_is_32_vectors_support,
 };
 
 static int ath11k_pci_probe(struct pci_dev *pdev,
@@ -972,6 +1081,13 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
+	/* Get the correct msi_data after request_irq() to avoid spurious interrupt */
+	ret = ath11k_pci_config_msi_data(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
+		goto err_ce_free;
+	}
+
 	ret = ath11k_core_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init core: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 43562f774a37..e165e8f0029f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -46,6 +46,7 @@ struct ath11k_pci {
 	u16 dev_id;
 	char amss_path[100];
 	u32 msi_ep_base_data;
+	u32 vectors_32_capability;
 	struct mhi_controller *mhi_ctrl;
 	unsigned long mhi_state;
 	u32 register_window;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c2b165158225..5ac7e2685518 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1675,6 +1675,10 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 			req->mem_seg[i].addr = ab->qmi.target_mem[i].paddr;
 			req->mem_seg[i].size = ab->qmi.target_mem[i].size;
 			req->mem_seg[i].type = ab->qmi.target_mem[i].type;
+			ath11k_info(ab, "req mem_seg[%d] 0x%llx %u %u\n", i,
+				    ab->qmi.target_mem[i].paddr,
+				    ab->qmi.target_mem[i].size,
+				    ab->qmi.target_mem[i].type);
 		}
 	}
 
-- 
2.7.4

