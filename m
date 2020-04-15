Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B31AAFC8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411261AbgDORcW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 13:32:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62220 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411255AbgDORcS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 13:32:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586971937; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3TgMcCrZpFyQ+7T1SVyjTcHt6LJCINnBs6bbMh+5HH4=; b=bHdD/sr0J8VFcDH94ywMXCwacisD80ySVX/AQ0TvGr770Msa+NUifsToFEPR9hNfBBLEoR4g
 UtCVViR7XmuQt1wtbxWABREtsQ7ffjTZBUzKS794vb4dqWDUZULuaWeTmMObVT6rZfWxVBRo
 J19aAe1mszM08THPbzMnoLID1DI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e974511.7f9515088458-smtp-out-n02;
 Wed, 15 Apr 2020 17:32:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CF97C44793; Wed, 15 Apr 2020 17:32:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7F79C44788;
        Wed, 15 Apr 2020 17:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7F79C44788
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v3 3/3] ath10k: Add support for targets without trustzone
Date:   Wed, 15 Apr 2020 23:01:46 +0530
Message-Id: <1586971906-20985-4-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586971906-20985-1-git-send-email-pillair@codeaurora.org>
References: <1586971906-20985-1-git-send-email-pillair@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the support to attach and map iommu
domain for targets which do not have the
support of TrustZone.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 118 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/snoc.h |   7 ++
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 3633ea5..7a7e79b 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -12,6 +12,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of_address.h>
+#include <linux/iommu.h>
 
 #include "ce.h"
 #include "coredump.h"
@@ -1499,6 +1500,111 @@ static int ath10k_setup_msa_resources(struct ath10k *ar, u32 msa_size)
 	return 0;
 }
 
+static int ath10k_fw_init(struct ath10k *ar)
+{
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	struct device *host_dev = &ar_snoc->dev->dev;
+	struct platform_device_info info;
+	struct iommu_domain *iommu_dom;
+	struct platform_device *pdev;
+	struct device_node *node;
+	int ret;
+
+	node = of_get_child_by_name(host_dev->of_node, "wifi-firmware");
+	if (!node) {
+		ar_snoc->use_tz = true;
+		return 0;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.fwnode = &node->fwnode;
+	info.parent = host_dev;
+	info.name = node->name;
+	info.dma_mask = DMA_BIT_MASK(32);
+
+	pdev = platform_device_register_full(&info);
+	if (IS_ERR(pdev)) {
+		of_node_put(node);
+		return PTR_ERR(pdev);
+	}
+
+	pdev->dev.of_node = node;
+
+	ret = of_dma_configure(&pdev->dev, node, true);
+	if (ret) {
+		ath10k_err(ar, "dma configure fail: %d\n", ret);
+		goto err_unregister;
+	}
+
+	ar_snoc->fw.dev = &pdev->dev;
+
+	iommu_dom = iommu_domain_alloc(&platform_bus_type);
+	if (!iommu_dom) {
+		ath10k_err(ar, "failed to allocate iommu domain\n");
+		ret = -ENOMEM;
+		goto err_unregister;
+	}
+
+	ret = iommu_attach_device(iommu_dom, ar_snoc->fw.dev);
+	if (ret) {
+		ath10k_err(ar, "could not attach device: %d\n", ret);
+		goto err_iommu_free;
+	}
+
+	ar_snoc->fw.iommu_domain = iommu_dom;
+	ar_snoc->fw.fw_start_addr = ar->msa.paddr;
+
+	ret = iommu_map(iommu_dom, ar_snoc->fw.fw_start_addr,
+			ar->msa.paddr, ar->msa.mem_size,
+			IOMMU_READ | IOMMU_WRITE);
+	if (ret) {
+		ath10k_err(ar, "failed to map firmware region: %d\n", ret);
+		goto err_iommu_detach;
+	}
+
+	of_node_put(node);
+
+	return 0;
+
+err_iommu_detach:
+	iommu_detach_device(iommu_dom, ar_snoc->fw.dev);
+
+err_iommu_free:
+	iommu_domain_free(iommu_dom);
+
+err_unregister:
+	platform_device_unregister(pdev);
+	of_node_put(node);
+
+	return ret;
+}
+
+static int ath10k_fw_deinit(struct ath10k *ar)
+{
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	const size_t mapped_size = ar_snoc->fw.mapped_mem_size;
+	struct iommu_domain *iommu;
+	size_t unmapped_size;
+
+	if (ar_snoc->use_tz)
+		return 0;
+
+	iommu = ar_snoc->fw.iommu_domain;
+
+	unmapped_size = iommu_unmap(iommu, ar_snoc->fw.fw_start_addr,
+				    mapped_size);
+	if (unmapped_size != mapped_size)
+		ath10k_err(ar, "failed to unmap firmware: %zu\n",
+			   unmapped_size);
+
+	iommu_detach_device(iommu, ar_snoc->fw.dev);
+	iommu_domain_free(iommu);
+
+	platform_device_unregister(to_platform_device(ar_snoc->fw.dev));
+
+	return 0;
+}
+
 static const struct of_device_id ath10k_snoc_dt_match[] = {
 	{ .compatible = "qcom,wcn3990-wifi",
 	 .data = &drv_priv,
@@ -1607,16 +1713,25 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_power_off;
 	}
 
+	ret = ath10k_fw_init(ar);
+	if (ret) {
+		ath10k_err(ar, "failed to initialize firmware: %d\n", ret);
+		goto err_power_off;
+	}
+
 	ret = ath10k_qmi_init(ar, msa_size);
 	if (ret) {
 		ath10k_warn(ar, "failed to register wlfw qmi client: %d\n", ret);
-		goto err_power_off;
+		goto err_fw_deinit;
 	}
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "snoc probe\n");
 
 	return 0;
 
+err_fw_deinit:
+	ath10k_fw_deinit(ar);
+
 err_power_off:
 	ath10k_hw_power_off(ar);
 
@@ -1648,6 +1763,7 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
 
 	ath10k_core_unregister(ar);
 	ath10k_hw_power_off(ar);
+	ath10k_fw_deinit(ar);
 	ath10k_snoc_free_irq(ar);
 	ath10k_snoc_release_resource(ar);
 	ath10k_qmi_deinit(ar);
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index c05df45..a3dd06f 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -55,6 +55,13 @@ struct regulator_bulk_data;
 struct ath10k_snoc {
 	struct platform_device *dev;
 	struct ath10k *ar;
+	unsigned int use_tz;
+	struct ath10k_firmware {
+		struct device *dev;
+		dma_addr_t fw_start_addr;
+		struct iommu_domain *iommu_domain;
+		size_t mapped_mem_size;
+	} fw;
 	void __iomem *mem;
 	dma_addr_t mem_pa;
 	struct ath10k_snoc_target_info target_info;
-- 
2.7.4
