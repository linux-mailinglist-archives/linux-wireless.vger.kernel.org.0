Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9474E8E0D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 08:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiC1GWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiC1GWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 02:22:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB2751E5C
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648448449; x=1679984449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=faayt7ozzTRD9Dfm+jf0t9rBdx0tUGIsoEg0vZwF3ho=;
  b=MPVMo2qBsbnF3dlRrfoUn9IIDqCxdl+RfhFOI9Jnxi3zMzQpeAdNOFua
   9+yTem88ZfhG/QV+jjeBuaw6qYKy3UCKLNS6gYdjEVCFl6VYOYd+xirAp
   YAxlKjh/9/tI9cHAIGEYQ9/uiqny5Ikt6xtwcRAPqBv8O5li4yLFiUM6W
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Mar 2022 23:20:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 23:20:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 23:20:48 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 23:20:47 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3] ath11k: Add support for targets without trustzone
Date:   Mon, 28 Mar 2022 11:50:32 +0530
Message-ID: <20220328062032.28881-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Note:
*	Dependent on Series "add support for WCN6750"
	Link: https://patchwork.kernel.org/project/linux-wireless/cover/20220328060937.16738-1-quic_mpubbise@quicinc.com/

V3:
 - Rebased on ToT SHAID: 7316a74e54318d0cd648242b18ea83cdef6dda96
 - Initialise MSA resources based on HW param "fixed_fw_mem" defined only for WCN6750

V2:
 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/ahb.c | 178 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h |   9 ++
 2 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 4fa5aba286ff..082cfec29d87 100644
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
@@ -775,6 +777,172 @@ static int ath11k_ahb_setup_resources(struct ath11k_base *ab)
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
+	/* Chipsets not requiring MSA need not initialize
+	 * MSA resources, return success in such cases.
+	 */
+	if (!ab->hw_params.fixed_fw_mem)
+		return 0;
+
+	ret = ath11k_ahb_setup_msa_resources(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to setup msa resources\n");
+		return ret;
+	}
+
+	node = of_get_child_by_name(host_dev->of_node, "wifi-firmware");
+	if (!node) {
+		ab_ahb->fw.use_tz = true;
+		return 0;
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
@@ -837,10 +1005,14 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_free;
 
-	ret = ath11k_hal_srng_init(ab);
+	ret = ath11k_ahb_fw_resources_init(ab);
 	if (ret)
 		goto err_core_free;
 
+	ret = ath11k_hal_srng_init(ab);
+	if (ret)
+		goto err_fw_deinit;
+
 	ret = ath11k_ce_alloc_pipes(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to allocate ce pipes: %d\n", ret);
@@ -877,6 +1049,9 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 err_hal_srng_deinit:
 	ath11k_hal_srng_deinit(ab);
 
+err_fw_deinit:
+	ath11k_ahb_fw_resource_deinit(ab);
+
 err_core_free:
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
@@ -912,6 +1087,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 qmi_fail:
 	ath11k_ahb_free_irq(ab);
 	ath11k_hal_srng_deinit(ab);
+	ath11k_ahb_fw_resource_deinit(ab);
 	ath11k_ce_free_pipes(ab);
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index eeb1feed2c81..c3e055a55e7e 100644
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
2.35.1

