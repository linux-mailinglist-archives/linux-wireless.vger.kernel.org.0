Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5BD43AB12
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 06:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJZETu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 00:19:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42774 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhJZETt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 00:19:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635221846; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=bUWtId3Iel6vcfARZsIUr/x5bwkblm7P1+6zBMnRRWU=; b=cUNeVbV7CsvIzk/+Gui2WZbOAt1DE+FJmMjjNHWn1ZmzpY9iKdtb9NXijw3bQ3StZgqMgP6N
 B5r5hjr4CyyIOGxeSoGSjE69GhYMFfT34zNIdIgTtHrvSSEV+Uoqu+hTNC0LWgMR1LpnPkbh
 3+SDAcqJFK920Glr1C8dZtiwfjo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6177814fe29a872c21ac2023 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 04:17:19
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18CDAC4360C; Tue, 26 Oct 2021 04:17:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from bqiang-Celadon-RN.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF4E4C4338F;
        Tue, 26 Oct 2021 04:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BF4E4C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] ath11k: supports one MSI vector
Date:   Tue, 26 Oct 2021 12:17:14 +0800
Message-Id: <20211026041714.5219-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

On some platforms it's not possible to allocate 32 MSI vectors for various
reasons, be it kernel configuration, VT-d disabled, buggy BIOS etc. So
ath11k was not able to use QCA6390 PCI devices on those platforms. Add
support for one MSI vector to solve that.

In case of one MSI vector, interrupt migration needs to be disabled.  This
is because when interrupt migration happens, the msi_data may change.
However, msi_data is already programmed to rings during initial phase and
ath11k has no way to know that msi_data is changed during run time and
reprogram again.

In case of one MSI vector, MHI subsystem should not use IRQF_NO_SUSPEND
as QCA6390 doesn't set this flag too. Ath11k doesn't need to leave
IRQ enabled in suspend state.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 14 ++++++--
 drivers/net/wireless/ath/ath11k/pci.c | 52 ++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 26c7ae242db6..d0f94a785a59 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -248,6 +248,7 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	u32 user_base_data, base_vector;
 	int ret, num_vectors, i;
 	int *irq;
+	unsigned int msi_data;
 
 	ret = ath11k_pci_get_user_msi_assignment(ab_pci,
 						 "MHI", &num_vectors,
@@ -262,9 +263,15 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	if (!irq)
 		return -ENOMEM;
 
-	for (i = 0; i < num_vectors; i++)
+	for (i = 0; i < num_vectors; i++) {
+		msi_data = base_vector;
+
+		if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+			msi_data += i;
+
 		irq[i] = ath11k_pci_get_msi_irq(ab->dev,
-						base_vector + i);
+						msi_data);
+	}
 
 	ab_pci->mhi_ctrl->irq = irq;
 	ab_pci->mhi_ctrl->nr_irqs = num_vectors;
@@ -339,6 +346,9 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		return ret;
 	}
 
+	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		mhi_ctrl->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
+
 	mhi_ctrl->iova_start = 0;
 	mhi_ctrl->iova_stop = 0xffffffff;
 	mhi_ctrl->sbl_size = SZ_512K;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index c4d726f492dc..0a87d00a3a23 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -77,6 +77,17 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 	},
 };
 
+static const struct ath11k_msi_config msi_config_one_msi = {
+	.total_vectors = 1,
+	.total_users = 4,
+	.users = (struct ath11k_msi_user[]) {
+		{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+		{ .name = "CE", .num_vectors = 1, .base_vector = 0 },
+		{ .name = "WAKE", .num_vectors = 1, .base_vector = 0 },
+		{ .name = "DP", .num_vectors = 1, .base_vector = 0 },
+	},
+};
+
 static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
 	"bhi",
 	"mhi-er0",
@@ -615,16 +626,18 @@ static void ath11k_pci_sync_ce_irqs(struct ath11k_base *ab)
 static void ath11k_pci_ce_tasklet(struct tasklet_struct *t)
 {
 	struct ath11k_ce_pipe *ce_pipe = from_tasklet(ce_pipe, t, intr_tq);
+	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
 
 	ath11k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
 
-	ath11k_pci_ce_irq_enable(ce_pipe->ab, ce_pipe->pipe_num);
+	enable_irq(ce_pipe->ab->irq_num[irq_idx]);
 }
 
 static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ce_pipe *ce_pipe = arg;
 	struct ath11k_base *ab = ce_pipe->ab;
+	int irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_pipe->pipe_num;
 
 	if (!test_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags))
 		return IRQ_HANDLED;
@@ -632,7 +645,8 @@ static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 	/* last interrupt received for this CE */
 	ce_pipe->timestamp = jiffies;
 
-	ath11k_pci_ce_irq_disable(ce_pipe->ab, ce_pipe->pipe_num);
+	disable_irq_nosync(ab->irq_num[irq_idx]);
+
 	tasklet_schedule(&ce_pipe->intr_tq);
 
 	return IRQ_HANDLED;
@@ -725,11 +739,13 @@ static int ath11k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
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
@@ -742,6 +758,7 @@ static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ext_irq_grp *irq_grp = arg;
 	struct ath11k_base *ab = irq_grp->ab;
+	int i;
 
 	if (!test_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
 		return IRQ_HANDLED;
@@ -751,7 +768,8 @@ static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 	/* last interrupt received for this group */
 	irq_grp->timestamp = jiffies;
 
-	ath11k_pci_ext_grp_disable(irq_grp);
+	for (i = 0; i < irq_grp->num_irq; i++)
+		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
 
 	napi_schedule(&irq_grp->napi);
 
@@ -938,18 +956,25 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 					    msi_config->total_vectors,
 					    msi_config->total_vectors,
 					    PCI_IRQ_MSI);
-	if (num_vectors != msi_config->total_vectors) {
-		ath11k_err(ab, "failed to get %d MSI vectors, only %d available",
-			   msi_config->total_vectors, num_vectors);
-
-		if (num_vectors >= 0)
-			return -EINVAL;
-		else
-			return num_vectors;
-	} else {
+	if (num_vectors == msi_config->total_vectors) {
 		set_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
 		ab_pci->irq_flags = IRQF_SHARED;
+	} else {
+		num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
+						    1,
+						    1,
+						    PCI_IRQ_MSI);
+		if (num_vectors < 0) {
+			ret = -EINVAL;
+			goto reset_msi_config;
+		}
+		clear_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
+		ab_pci->msi_config = &msi_config_one_msi;
+		ab_pci->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
+		ath11k_dbg(ab, ATH11K_DBG_PCI, "request MSI one vector\n");
 	}
+	ath11k_info(ab, "MSI vectors: %d\n", num_vectors);
+
 	ath11k_pci_msi_disable(ab_pci);
 
 	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
@@ -970,6 +995,7 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 free_msi_vector:
 	pci_free_irq_vectors(ab_pci->pdev);
 
+reset_msi_config:
 	return ret;
 }
 
-- 
2.25.1

