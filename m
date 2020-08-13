Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9355724371E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMJEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:04:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62235 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgHMJEu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:04:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597309490; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kp4/19vyjzYJgb/bUPkUqF8v9G4e+BMdIOj6eJh6yS8=; b=s3FdQ1OmSnqJ1Faw9vrbK1FfAYR8E8j3yGsC/9k+DeQ4K4qgw/8eTeTZ6VhiLNxCxn9HNmmF
 /PaD91dgbNjGzoakJcTyw662JYlAI/JF9pbTeqZL+PqcN4H4dG7YjMoRTwa4jMsnbjDDFe3B
 NDtfcu3moCk+8nhkrsE8IlyHutg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f350228cbcd42bdeee440c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:04:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92FD3C43391; Thu, 13 Aug 2020 09:04:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44F92C433CB;
        Thu, 13 Aug 2020 09:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44F92C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/10] ath11k: pci: add MSI config initialisation
Date:   Thu, 13 Aug 2020 12:04:22 +0300
Message-Id: <1597309466-19688-7-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
References: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

QCA6390 uses PCI MSI for CE/MHI/DP interrupt.  Add MSI vector mapping and MSI
enable/disable operations.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.h |  1 +
 drivers/net/wireless/ath/ath11k/pci.c   | 69 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h   | 13 +++++++
 3 files changed, 83 insertions(+)

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
index 9b1baf53ac5a..5ebbdbde81ef 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 #include "pci.h"
@@ -22,6 +23,62 @@ static const struct pci_device_id ath11k_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 
+static const struct ath11k_msi_config msi_config = {
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
+static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	struct msi_desc *msi_desc;
+	int num_vectors;
+	int ret;
+
+	num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
+					    msi_config.total_vectors,
+					    msi_config.total_vectors,
+					    PCI_IRQ_MSI);
+	if (num_vectors != msi_config.total_vectors) {
+		ath11k_err(ab, "failed to get %d MSI vectors, only %d available",
+			   msi_config.total_vectors, num_vectors);
+
+		if (num_vectors >= 0)
+			return -EINVAL;
+		else
+			return num_vectors;
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
+
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
 	struct ath11k_base *ab = ab_pci->ab;
@@ -136,6 +193,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ab_pci = ath11k_pci_priv(ab);
 	ab_pci->dev_id = pci_dev->device;
 	ab_pci->ab = ab;
+	ab_pci->pdev = pdev;
 	pci_set_drvdata(pdev, ab);
 
 	ret = ath11k_pci_claim(ab_pci, pdev);
@@ -144,10 +202,20 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_free_core;
 	}
 
+	ret = ath11k_pci_enable_msi(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to enable msi: %d\n", ret);
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
 
@@ -157,6 +225,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	ath11k_pci_disable_msi(ab_pci);
 	ath11k_pci_free_region(ab_pci);
 	ath11k_core_free(ab);
 }
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index dfd30ec09818..db75eae26f71 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -5,10 +5,23 @@
 
 #include "core.h"
 
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
 	struct ath11k_base *ab;
 	u16 dev_id;
+	u32 msi_ep_base_data;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
-- 
2.7.4

