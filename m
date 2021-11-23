Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC3545ABD2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhKWSz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:55:27 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15084 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237791AbhKWSzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693532; x=1669229532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wtySvvNCeLuCH76Kv/tQldg550M/QBW2MiCv7doVQdo=;
  b=w6FtxUB86WZdNdvkY1sKcqnPwnYU83xJiG8F6E6JtYG++ZTyWUKDYnRw
   TGttPDS1q2iVzivZYxTkGTtzcUoZR+o17TbRb1/RYYu8qCbTdkvLtOFtk
   RF/+jAeSBuraDZXJNV1gOLXiFFeNxNZm3et3tHzg3HZhPSJKnCutc8Ryf
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 10:52:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:52:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:59 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:57 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 18/19] ath11k: Add support for targets without trustzone
Date:   Wed, 24 Nov 2021 00:20:33 +0530
Message-ID: <1637693434-15462-19-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the support to attach WCN6750 and map iommu domain
for targets which do not have the support of TrustZone.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 174 +++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h |   9 ++
 2 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 9e6e2be..48e7550 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -9,6 +9,8 @@
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/dma-mapping.h>
+#include <linux/of_address.h>
+#include <linux/iommu.h>
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
@@ -766,6 +768,166 @@ static int ath11k_ahb_setup_resources(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	struct device *dev = ab->dev;
+	struct device_node *node;
+	struct resource r;
+	int ret;
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!node)
+		return -ENOENT;
+
+	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
+	if (ret) {
+		dev_err(dev, "failed to resolve msa fixed region\n");
+		return ret;
+	}
+
+	ab_ahb->fw.msa_paddr = r.start;
+	ab_ahb->fw.msa_size = resource_size(&r);
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 1);
+	if (!node)
+		return -ENOENT;
+
+	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
+	if (ret) {
+		dev_err(dev, "failed to resolve ce fixed region\n");
+		return ret;
+	}
+
+	ab_ahb->fw.ce_paddr = r.start;
+	ab_ahb->fw.ce_size = resource_size(&r);
+
+	return 0;
+}
+
+static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	struct device *host_dev = ab->dev;
+	struct platform_device_info info = {0};
+	struct iommu_domain *iommu_dom;
+	struct platform_device *pdev;
+	struct device_node *node;
+	int ret;
+
+	node = of_get_child_by_name(host_dev->of_node, "wifi-firmware");
+	if (!node) {
+		ab_ahb->fw.use_tz = true;
+		return 0;
+	}
+
+	ret = ath11k_ahb_setup_msa_resources(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to setup msa resources\n");
+		return ret;
+	}
+
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
+	ret = of_dma_configure(&pdev->dev, node, true);
+	if (ret) {
+		ath11k_err(ab, "dma configure fail: %d\n", ret);
+		goto err_unregister;
+	}
+
+	ab_ahb->fw.dev = &pdev->dev;
+
+	iommu_dom = iommu_domain_alloc(&platform_bus_type);
+	if (!iommu_dom) {
+		ath11k_err(ab, "failed to allocate iommu domain\n");
+		ret = -ENOMEM;
+		goto err_unregister;
+	}
+
+	ret = iommu_attach_device(iommu_dom, ab_ahb->fw.dev);
+	if (ret) {
+		ath11k_err(ab, "could not attach device: %d\n", ret);
+		goto err_iommu_free;
+	}
+
+	ret = iommu_map(iommu_dom, ab_ahb->fw.msa_paddr,
+			ab_ahb->fw.msa_paddr, ab_ahb->fw.msa_size,
+			IOMMU_READ | IOMMU_WRITE);
+	if (ret) {
+		ath11k_err(ab, "failed to map firmware region: %d\n", ret);
+		goto err_iommu_detach;
+	}
+
+	ret = iommu_map(iommu_dom, ab_ahb->fw.ce_paddr,
+			ab_ahb->fw.ce_paddr, ab_ahb->fw.ce_size,
+			IOMMU_READ | IOMMU_WRITE);
+	if (ret) {
+		ath11k_err(ab, "failed to map firmware CE region: %d\n", ret);
+		goto err_iommu_unmap;
+	}
+
+	ab_ahb->fw.use_tz = false;
+	ab_ahb->fw.iommu_domain = iommu_dom;
+	of_node_put(node);
+
+	return 0;
+
+err_iommu_unmap:
+	iommu_unmap(iommu_dom, ab_ahb->fw.msa_paddr, ab_ahb->fw.msa_size);
+
+err_iommu_detach:
+	iommu_detach_device(iommu_dom, ab_ahb->fw.dev);
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
+static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	struct iommu_domain *iommu;
+	size_t unmapped_size;
+
+	if (ab_ahb->fw.use_tz)
+		return 0;
+
+	iommu = ab_ahb->fw.iommu_domain;
+
+	unmapped_size = iommu_unmap(iommu, ab_ahb->fw.msa_paddr, ab_ahb->fw.msa_size);
+	if (unmapped_size != ab_ahb->fw.msa_size)
+		ath11k_err(ab, "failed to unmap firmware: %zu\n",
+			   unmapped_size);
+
+	unmapped_size = iommu_unmap(iommu, ab_ahb->fw.ce_paddr, ab_ahb->fw.ce_size);
+	if (unmapped_size != ab_ahb->fw.ce_size)
+		ath11k_err(ab, "failed to unmap firmware CE memory: %zu\n",
+			   unmapped_size);
+
+	iommu_detach_device(iommu, ab_ahb->fw.dev);
+	iommu_domain_free(iommu);
+
+	platform_device_unregister(to_platform_device(ab_ahb->fw.dev));
+
+	return 0;
+}
+
 static int ath11k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath11k_base *ab;
@@ -820,13 +982,17 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_free;
 
-	ret = ath11k_core_pre_init(ab);
+	ret = ath11k_ahb_fw_resources_init(ab);
 	if (ret)
 		goto err_core_free;
 
+	ret = ath11k_core_pre_init(ab);
+	if (ret)
+		goto err_fw_deinit;
+
 	ret = ath11k_hal_srng_init(ab);
 	if (ret)
-		goto err_core_free;
+		goto err_fw_deinit;
 
 	ret = ath11k_ce_alloc_pipes(ab);
 	if (ret) {
@@ -864,6 +1030,9 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 err_hal_srng_deinit:
 	ath11k_hal_srng_deinit(ab);
 
+err_fw_deinit:
+	ath11k_ahb_fw_resource_deinit(ab);
+
 err_core_free:
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
@@ -899,6 +1068,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 qmi_fail:
 	ath11k_ahb_free_irq(ab);
 	ath11k_hal_srng_deinit(ab);
+	ath11k_ahb_fw_resource_deinit(ab);
 	ath11k_ce_free_pipes(ab);
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index 1ae038e..4c7872d 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -13,6 +13,15 @@ struct ath11k_base;
 
 struct ath11k_ahb {
 	struct rproc *tgt_rproc;
+	struct {
+		struct device *dev;
+		struct iommu_domain *iommu_domain;
+		dma_addr_t msa_paddr;
+		u32 msa_size;
+		dma_addr_t ce_paddr;
+		u32 ce_size;
+		bool use_tz;
+	} fw;
 };
 
 static inline struct ath11k_ahb *ath11k_ahb_priv(struct ath11k_base *ab)
-- 
2.7.4

