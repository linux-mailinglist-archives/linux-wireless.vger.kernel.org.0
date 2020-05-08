Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5851CA6A8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEHI7M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 04:59:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:54212 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgEHI7M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 04:59:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588928350; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/8vSCbuceEiscwv1F4YX3mVe3cDsDqJ8LtMCtU+vnKg=; b=uyW6Z6okRcXrdwwytploa31eUDrCAjTabYXpZu9PtmnlEkwzRaIcQfGSGejaxJlzz/kp549t
 /LdugDlYIQ7vbXJ7LGAvasou+cJjHV9UmZI7YVNYDqRumOl39BihayJ6WkkwMKsQvLH5yYQH
 +IbKdcweHVCxGvZB481Sk0GIlvU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb51f56.7f9795b879d0-smtp-out-n01;
 Fri, 08 May 2020 08:59:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CBFDC43637; Fri,  8 May 2020 08:59:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9ADCC43636;
        Fri,  8 May 2020 08:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9ADCC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 3/4] ath11k: Add msi config init for QCA6390
Date:   Fri,  8 May 2020 14:28:49 +0530
Message-Id: <20200508085850.23363-4-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200508085850.23363-1-govinds@codeaurora.org>
References: <20200508085850.23363-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCA6390 uses PCI msi for CE/MHI/DP interrupt.
Add msi vector mapping and msi enable/disable ops.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.h |  1 +
 drivers/net/wireless/ath/ath11k/pci.c   | 91 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h   | 14 ++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index c30085406bfb..1cfe54859388 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -25,6 +25,7 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_REG		= 0x00000200,
 	ATH11K_DBG_TESTMODE	= 0x00000400,
 	ATH11k_DBG_HAL		= 0x00000800,
+	ATH11K_DBG_PCI		= 0x00001000,
 	ATH11K_DBG_ANY		= 0xffffffff,
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 6ab9e25c4ff9..d89dcb5fe81e 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 #include "ahb.h"
@@ -19,11 +20,88 @@ static const struct pci_device_id ath11k_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 
+static struct ath11k_msi_config msi_config = {
+	.total_vectors = 32,
+	.total_users = 4,
+	.users = (struct ath11k_msi_user[]) {
+		{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+		{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+		{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+		{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+	},
+};
+
+static int ath11k_pci_get_msi_assignment(struct ath11k_pci *ab_pci)
+{
+	ab_pci->msi_config = &msi_config;
+
+	return 0;
+}
+
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
 {
 	return (struct ath11k_pci *)ab->drv_priv;
 }
 
+static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	struct ath11k_msi_config *msi_config;
+	struct msi_desc *msi_desc;
+	int num_vectors;
+	int ret;
+
+	ret = ath11k_pci_get_msi_assignment(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to get MSI assignment, err = %d\n", ret);
+		goto out;
+	}
+
+	msi_config = ab_pci->msi_config;
+	if (!msi_config) {
+		ath11k_err(ab, "msi_config is NULL!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
+					    msi_config->total_vectors,
+					    msi_config->total_vectors,
+					    PCI_IRQ_MSI);
+	if (num_vectors != msi_config->total_vectors) {
+		ath11k_err(ab, "failed to get enough MSI vectors (%d), available vectors = %d",
+			   msi_config->total_vectors, num_vectors);
+		if (num_vectors >= 0)
+			ret = -EINVAL;
+		goto reset_msi_config;
+	}
+
+	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
+	if (!msi_desc) {
+		ath11k_err(ab, "msi_desc is NULL!\n");
+		ret = -EINVAL;
+		goto free_msi_vector;
+	}
+
+	ab_pci->msi_ep_base_data = msi_desc->msg.data;
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab_pci->msi_ep_base_data);
+
+	return 0;
+
+free_msi_vector:
+	pci_free_irq_vectors(ab_pci->pdev);
+reset_msi_config:
+	ab_pci->msi_config = NULL;
+out:
+	return ret;
+}
+
+static void ath11k_pci_disable_msi(struct ath11k_pci *ab_pci)
+{
+	pci_free_irq_vectors(ab_pci->pdev);
+}
+
 static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 {
 	u32 pci_dma_mask = PCI_DMA_MASK_32_BIT;
@@ -139,6 +217,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ab_pci = ath11k_pci_priv(ab);
 	ab_pci->dev_id = pci_dev->device;
 	ab_pci->ab = ab;
+	ab_pci->dev = &pdev->dev;
+	ab_pci->pdev = pdev;
 	ab->dev = &pdev->dev;
 	ab->hw_rev = hw_rev;
 	pci_set_drvdata(pdev, ab);
@@ -149,10 +229,20 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_free_core;
 	}
 
+	ret = ath11k_pci_enable_msi(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to enable  msi: %d\n", ret);
+		goto err_pci_free_region;
+	}
+
 	return 0;
 
+err_pci_free_region:
+	ath11k_pci_free_region(ab_pci);
+
 err_free_core:
 	ath11k_core_free(ab);
+
 	return ret;
 }
 
@@ -162,6 +252,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	ath11k_pci_disable_msi(ab_pci);
 	ath11k_pci_free_region(ab_pci);
 	ath11k_core_free(ab);
 }
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 5e6f2b5059a8..7c7fa1965aa6 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -11,6 +11,18 @@
 #define PCI_DMA_MASK_64_BIT		64
 #define PCI_DMA_MASK_32_BIT		32
 
+struct ath11k_msi_user {
+	char *name;
+	int num_vectors;
+	u32 base_vector;
+};
+
+struct ath11k_msi_config {
+	int total_vectors;
+	int total_users;
+	struct ath11k_msi_user *users;
+};
+
 struct ath11k_pci {
 	struct pci_dev *pdev;
 	struct device *dev;
@@ -19,4 +31,6 @@ struct ath11k_pci {
 	size_t mem_len;
 	u16 dev_id;
 	u32 chip_id;
+	struct ath11k_msi_config *msi_config;
+	u32 msi_ep_base_data;
 };
-- 
2.22.0
