Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB01CA6A6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgEHI7D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 04:59:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42235 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgEHI7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 04:59:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588928342; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cbAfdFtdw68iyKQIFwQsTXIlSXeN1lbfLBBAPZDF5KQ=; b=kPKqEduuq7atdTDV34CRiVZm8gJaE/wxBzlIbUuIIGfMuY92JcqSTvij+qpN8qDjEoLAmQuX
 ebL6QPz0J+reV3TBAEdphNPNuS0xesU5IWgZmsRjCFCfYriEJlQ4xBvja+BQgzuNSmJ6WO9s
 ExASelZPmUvvwbsaYksit/V8GLQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb51f54.7f01ed10ff10-smtp-out-n03;
 Fri, 08 May 2020 08:59:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D92EFC432C2; Fri,  8 May 2020 08:58:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE706C433F2;
        Fri,  8 May 2020 08:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE706C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 2/4] ath11k: setup pci resource for QCA6390 target
Date:   Fri,  8 May 2020 14:28:48 +0530
Message-Id: <20200508085850.23363-3-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200508085850.23363-1-govinds@codeaurora.org>
References: <20200508085850.23363-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for setting up pci region and dma mask
for QCA6390 target.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 109 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/pci.h  |  12 +++
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8d07a2bb31bb..4c3f5a9d0d8a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -14,6 +14,7 @@
 #include "hif.h"
 
 unsigned int ath11k_debug_mask;
+EXPORT_SYMBOL(ath11k_debug_mask);
 module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 582e7cd3c56e..6ab9e25c4ff9 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "ahb.h"
 #include "core.h"
 #include "pci.h"
 #include "debug.h"
@@ -18,10 +19,98 @@ static const struct pci_device_id ath11k_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 
+static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
+{
+	return (struct ath11k_pci *)ab->drv_priv;
+}
+
+static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
+{
+	u32 pci_dma_mask = PCI_DMA_MASK_32_BIT;
+	struct ath11k_base *ab = ab_pci->ab;
+	u16 device_id;
+	int ret = 0;
+
+	pci_read_config_word(pdev, PCI_DEVICE_ID, &device_id);
+	if (device_id != ab_pci->dev_id)  {
+		ath11k_err(ab, "pci device id mismatch, config ID: 0x%x, probe ID: 0x%x\n",
+			   device_id, ab_pci->dev_id);
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = pci_assign_resource(pdev, PCI_BAR_NUM);
+	if (ret) {
+		ath11k_err(ab, "failed to assign pci resource, err = %d\n", ret);
+		goto out;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		ath11k_err(ab, "failed to enable pci device, err = %d\n", ret);
+		goto out;
+	}
+
+	ret = pci_request_region(pdev, PCI_BAR_NUM, "ath11k_pci");
+	if (ret) {
+		ath11k_err(ab, "failed to request pci region, err = %d\n", ret);
+		goto disable_device;
+	}
+
+	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(pci_dma_mask));
+	if (ret) {
+		ath11k_err(ab, "failed to set pci dma mask (%d), err = %d\n",
+			   ret, pci_dma_mask);
+		goto release_region;
+	}
+
+	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(pci_dma_mask));
+	if (ret) {
+		ath11k_err(ab, "failed to set pci consistent dma mask (%d), err = %d\n",
+			   ret, pci_dma_mask);
+		goto release_region;
+	}
+
+	pci_set_master(pdev);
+
+	ab_pci->mem_len = pci_resource_len(pdev, PCI_BAR_NUM);
+	ab_pci->mem = pci_iomap(pdev, PCI_BAR_NUM, 0);
+	if (!ab_pci->mem) {
+		ath11k_err(ab, "failed to map pci bar, bar = %d\n", PCI_BAR_NUM);
+		ret = -EIO;
+		goto clear_master;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot pci_mem 0x%pK\n", ab_pci->mem);
+	return 0;
+
+clear_master:
+	pci_clear_master(pdev);
+release_region:
+	pci_release_region(pdev, PCI_BAR_NUM);
+disable_device:
+	pci_disable_device(pdev);
+out:
+	return ret;
+}
+
+static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
+{
+	struct pci_dev *pci_dev = ab_pci->pdev;
+
+	pci_iounmap(pci_dev, ab_pci->mem);
+	ab_pci->mem = NULL;
+	pci_clear_master(pci_dev);
+	pci_release_region(pci_dev, PCI_BAR_NUM);
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
 	int ret;
 
@@ -38,24 +127,42 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		return -ENOTSUPP;
 	}
 
-	ab = ath11k_core_alloc(&pdev->dev, 0, ATH11K_BUS_PCI);
+	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
 	}
 
+	ab->dev = &pdev->dev;
+	ab->hw_rev = hw_rev;
+	pci_set_drvdata(pdev, ab);
+	ab_pci = ath11k_pci_priv(ab);
+	ab_pci->dev_id = pci_dev->device;
+	ab_pci->ab = ab;
 	ab->dev = &pdev->dev;
 	ab->hw_rev = hw_rev;
 	pci_set_drvdata(pdev, ab);
 
+	ret = ath11k_pci_claim(ab_pci, pdev);
+	if (ret) {
+		ath11k_err(ab, "failed to claim device: %d\n", ret);
+		goto err_free_core;
+	}
+
+	return 0;
+
+err_free_core:
+	ath11k_core_free(ab);
 	return ret;
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
index 790b8993d225..5e6f2b5059a8 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -7,4 +7,16 @@
 #define QCA6290_DEVICE_ID		0x1100
 #define QCA6390_VENDOR_ID		0x17CB
 #define QCA6390_DEVICE_ID		0x1101
+#define PCI_BAR_NUM			0
+#define PCI_DMA_MASK_64_BIT		64
+#define PCI_DMA_MASK_32_BIT		32
 
+struct ath11k_pci {
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct ath11k_base *ab;
+	void __iomem *mem;
+	size_t mem_len;
+	u16 dev_id;
+	u32 chip_id;
+};
-- 
2.22.0
