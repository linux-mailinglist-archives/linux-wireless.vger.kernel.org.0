Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0024371B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMJEl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:04:41 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54890 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbgHMJEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:04:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597309479; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=8nnYQh12DkiOpq7PkzLkKbGmvC7U3AD577Zs59SBgfU=; b=eReofHXQ62/IrPpqlijmhAfDkaxNiIeNX4IGqpHYHaRoYJyCt6uEvQj5lnivyzEDkgcCt7VE
 DzUpFBmBIJ1xgRkaz3LuehZYFcNNQd31oTzvqfYaTJ5lybPL2ZvqF0xDVZj0JAgqgg5lkc7R
 AYG4FgpSUTbM71Qj83UkifmsdYw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f350226cbcd42bdeee43de7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:04:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CC9FC433C9; Thu, 13 Aug 2020 09:04:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB7F9C433CB;
        Thu, 13 Aug 2020 09:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB7F9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/10] ath11k: pci: setup resources
Date:   Thu, 13 Aug 2020 12:04:21 +0300
Message-Id: <1597309466-19688-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
References: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

Add support for setting up pci region and dma mask.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 106 +++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/pci.h |  17 ++++++
 2 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/pci.h

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index a88536d2c64b..9b1baf53ac5a 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -6,9 +6,13 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "pci.h"
 #include "core.h"
 #include "debug.h"
 
+#define ATH11K_PCI_BAR_NUM		0
+#define ATH11K_PCI_DMA_MASK		32
+
 #define QCA6390_DEVICE_ID		0x1101
 
 static const struct pci_device_id ath11k_pci_id_table[] = {
@@ -18,11 +22,95 @@ static const struct pci_device_id ath11k_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 
+static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	u16 device_id;
+	int ret = 0;
+
+	pci_read_config_word(pdev, PCI_DEVICE_ID, &device_id);
+	if (device_id != ab_pci->dev_id)  {
+		ath11k_err(ab, "pci device id mismatch: 0x%x 0x%x\n",
+			   device_id, ab_pci->dev_id);
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = pci_assign_resource(pdev, ATH11K_PCI_BAR_NUM);
+	if (ret) {
+		ath11k_err(ab, "failed to assign pci resource: %d\n", ret);
+		goto out;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		ath11k_err(ab, "failed to enable pci device: %d\n", ret);
+		goto out;
+	}
+
+	ret = pci_request_region(pdev, ATH11K_PCI_BAR_NUM, "ath11k_pci");
+	if (ret) {
+		ath11k_err(ab, "failed to request pci region: %d\n", ret);
+		goto disable_device;
+	}
+
+	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(ATH11K_PCI_DMA_MASK));
+	if (ret) {
+		ath11k_err(ab, "failed to set pci dma mask to %d: %d\n",
+			   ATH11K_PCI_DMA_MASK, ret);
+		goto release_region;
+	}
+
+	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(ATH11K_PCI_DMA_MASK));
+	if (ret) {
+		ath11k_err(ab, "failed to set pci consistent dma mask to %d: %d\n",
+			   ATH11K_PCI_DMA_MASK, ret);
+		goto release_region;
+	}
+
+	pci_set_master(pdev);
+
+	ab->mem_len = pci_resource_len(pdev, ATH11K_PCI_BAR_NUM);
+	ab->mem = pci_iomap(pdev, ATH11K_PCI_BAR_NUM, 0);
+	if (!ab->mem) {
+		ath11k_err(ab, "failed to map pci bar %d\n", ATH11K_PCI_BAR_NUM);
+		ret = -EIO;
+		goto clear_master;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot pci_mem 0x%pK\n", ab->mem);
+	return 0;
+
+clear_master:
+	pci_clear_master(pdev);
+release_region:
+	pci_release_region(pdev, ATH11K_PCI_BAR_NUM);
+disable_device:
+	pci_disable_device(pdev);
+out:
+	return ret;
+}
+
+static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+	struct pci_dev *pci_dev = ab_pci->pdev;
+
+	pci_iounmap(pci_dev, ab->mem);
+	ab->mem = NULL;
+	pci_clear_master(pci_dev);
+	pci_release_region(pci_dev, ATH11K_PCI_BAR_NUM);
+	if (pci_is_enabled(pci_dev))
+		pci_disable_device(pci_dev);
+}
+
 static int ath11k_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *pci_dev)
 {
 	struct ath11k_base *ab;
+	struct ath11k_pci *ab_pci;
 	enum ath11k_hw_rev hw_rev;
+	int ret;
 
 	dev_warn(&pdev->dev, "WARNING: ath11k PCI support is experimental!\n");
 
@@ -36,7 +124,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		return -ENOTSUPP;
 	}
 
-	ab = ath11k_core_alloc(&pdev->dev, 0, ATH11K_BUS_PCI);
+	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
@@ -45,15 +133,31 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ab->dev = &pdev->dev;
 	ab->hw_rev = hw_rev;
 	pci_set_drvdata(pdev, ab);
+	ab_pci = ath11k_pci_priv(ab);
+	ab_pci->dev_id = pci_dev->device;
+	ab_pci->ab = ab;
+	pci_set_drvdata(pdev, ab);
+
+	ret = ath11k_pci_claim(ab_pci, pdev);
+	if (ret) {
+		ath11k_err(ab, "failed to claim device: %d\n", ret);
+		goto err_free_core;
+	}
 
 	return 0;
+
+err_free_core:
+	ath11k_core_free(ab);
+	return ret;
 }
 
 static void ath11k_pci_remove(struct pci_dev *pdev)
 {
 	struct ath11k_base *ab = pci_get_drvdata(pdev);
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	ath11k_pci_free_region(ab_pci);
 	ath11k_core_free(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
new file mode 100644
index 000000000000..dfd30ec09818
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include "core.h"
+
+struct ath11k_pci {
+	struct pci_dev *pdev;
+	struct ath11k_base *ab;
+	u16 dev_id;
+};
+
+static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
+{
+	return (struct ath11k_pci *)ab->drv_priv;
+}
-- 
2.7.4

