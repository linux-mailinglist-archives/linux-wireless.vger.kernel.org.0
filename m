Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30E145ABD1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhKWSz0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:55:26 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15076 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237663AbhKWSzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693532; x=1669229532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uUDgTawbze1vPhGWcUHR3rKU/86DUGjk3yuf4+24s1Q=;
  b=Y2/U2yFberBuq79VUR7534wfyXXrSw1tY48ERyJeNQcwwdTM49DZ4p/O
   79rJEbWfpHpVcGiBI6w/iA2WwDPOCl4IGYkA9GEdeys6o8tLX0r1QUTcP
   Bwl8mRJ0bVxcQ1m3NwMYcj28YmlG2Yr7jEdlyILpwuOvrJicBo+W3ojFr
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 10:52:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:52:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:57 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:55 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 17/19] ath11k: Add support for WCN6750 device
Date:   Wed, 24 Nov 2021 00:20:32 +0530
Message-ID: <1637693434-15462-18-git-send-email-quic_mpubbise@quicinc.com>
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

WCN6750 is non-DBS 2x2 11AX chipset. Unlike QCA6390 which is a
DBS (dual band simultaneous) solution (2 LMACs), WCN6750 has a
single LMAC supporting 2G, 5G and 6G bands but will operate only
on one band at any given point.

WCN6750 is a PCIe based solution, but it is attached to the WPSS
(Wireless Processor SubSystem) Q6 processor, hence it is enumerated
by the Q6 processor. It is registered to the APSS processor
(Application Processor SubSystem) as a platform device(AHB) and
remoteproc APIs are used to boot up or shutdown the device like
other AHB devices.

Also, Device information like BAR and it's size is not known to the
APSS processor as the chip is enumerated by WPSS Q6. These details
are fetched over QMI.

STA and AP modes are supported. Verified basic connectivity and ping
in both the modes.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Makefile  |   2 +-
 drivers/net/wireless/ath/ath11k/ahb.c     | 147 +++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/ahb.h     |   1 -
 drivers/net/wireless/ath/ath11k/core.h    |   1 +
 drivers/net/wireless/ath/ath11k/pci_cmn.c |   9 ++
 5 files changed, 143 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 71376da..e3ea6a2 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -26,7 +26,7 @@ ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
-ath11k_ahb-y += ahb.o
+ath11k_ahb-y += ahb.o pci_cmn.o
 
 obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
 ath11k_pci-y += mhi.o pci.o pci_cmn.o
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 3185a5a..9e6e2be 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "hif.h"
 #include <linux/remoteproc.h>
+#include "pci_cmn.h"
 
 static const struct of_device_id ath11k_ahb_of_match[] = {
 	/* TODO: Should we change the compatible string to something similar
@@ -24,19 +25,28 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq6018-wifi",
 	  .data = (void *)ATH11K_HW_IPQ6018_HW10,
 	},
+	{ .compatible = "qcom,wcn6750-wifi",
+	  .data = (void *)ATH11K_HW_WCN6750_HW10,
+	},
 	{ }
 };
 
 MODULE_DEVICE_TABLE(of, ath11k_ahb_of_match);
 
-static const struct ath11k_bus_params ath11k_ahb_bus_params = {
+static const struct ath11k_bus_params bus_params_ipq8074 = {
 	.mhi_support = false,
 	.m3_fw_support = false,
 	.fixed_bdf_addr = true,
 	.fixed_mem_region = true,
 };
 
-const struct ath11k_bus_params ath11k_hybrid_bus_params = {
+static int
+ath11k_ahb_get_msi_irq_wcn6750(struct ath11k_base *ab, unsigned int vector)
+{
+	return ab->msi.irqs[vector];
+}
+
+static const struct ath11k_bus_params bus_params_wcn6750 = {
 	.mhi_support = false,
 	.m3_fw_support = false,
 	.fixed_bdf_addr = false,
@@ -45,6 +55,9 @@ const struct ath11k_bus_params ath11k_hybrid_bus_params = {
 	.static_window_map = true,
 	.dp_window_idx = 1,
 	.ce_window_idx = 2,
+	.ops = {
+		.get_msi_irq = ath11k_ahb_get_msi_irq_wcn6750,
+	},
 };
 
 #define ATH11K_IRQ_CE0_OFFSET 4
@@ -405,6 +418,9 @@ static void ath11k_ahb_free_irq(struct ath11k_base *ab)
 	int irq_idx;
 	int i;
 
+	if (ab->bus_params.hybrid_bus_type)
+		return ath11k_pci_free_irq(ab);
+
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
@@ -559,6 +575,9 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 	int irq, irq_idx, i;
 	int ret;
 
+	if (ab->bus_params.hybrid_bus_type)
+		return ath11k_pci_config_irq(ab);
+
 	/* Configure CE irqs */
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
@@ -628,7 +647,7 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	return 0;
 }
 
-static const struct ath11k_hif_ops ath11k_ahb_hif_ops = {
+static const struct ath11k_hif_ops hif_ops_ipq8074 = {
 	.start = ath11k_ahb_start,
 	.stop = ath11k_ahb_stop,
 	.read32 = ath11k_ahb_read32,
@@ -640,6 +659,20 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops = {
 	.power_up = ath11k_ahb_power_up,
 };
 
+static const struct ath11k_hif_ops hif_ops_wcn6750 = {
+	.start = ath11k_pci_start_cmn,
+	.stop = ath11k_pci_stop,
+	.read32 = ath11k_pci_read32,
+	.write32 = ath11k_pci_write32,
+	.irq_enable = ath11k_pci_ext_irq_enable,
+	.irq_disable = ath11k_pci_ext_irq_disable,
+	.get_msi_address =  ath11k_pci_get_msi_address,
+	.get_user_msi_vector = ath11k_pci_get_user_msi_assignment,
+	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
+	.power_down = ath11k_ahb_power_down,
+	.power_up = ath11k_ahb_power_up,
+};
+
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
@@ -662,12 +695,84 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_ahb_setup_msi_resources(struct ath11k_base *ab)
+{
+	struct platform_device *pdev = ab->pdev;
+	phys_addr_t msi_addr_pa;
+	dma_addr_t msi_addr_iova;
+	struct resource *res;
+	int int_prop;
+	int ret;
+	int i;
+
+	ret = ath11k_pci_get_msi_config(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to fetch msi config: %d\n", ret);
+		return ret;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msi_addr");
+	if (!res) {
+		ath11k_err(ab, "failed to fetch msi_addr\n");
+		return -ENOENT;
+	}
+
+	msi_addr_pa = res->start;
+	msi_addr_iova = dma_map_resource(ab->dev, msi_addr_pa, PAGE_SIZE,
+					 DMA_FROM_DEVICE, 0);
+	if (dma_mapping_error(ab->dev, msi_addr_iova))
+		return -ENOMEM;
+
+	ab->msi.msi_addr_lo = lower_32_bits(msi_addr_iova);
+	ab->msi.msi_addr_hi = upper_32_bits(msi_addr_iova);
+
+	ret = of_property_read_u32_index(ab->dev->of_node, "interrupts", 1, &int_prop);
+	if (ret)
+		return ret;
+
+	ab->msi.msi_ep_base_data = int_prop + 32;
+
+	for (i = 0; i < ab->msi.msi_config->total_vectors; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		if (!res)
+			return -ENODEV;
+
+		ab->msi.irqs[i] = res->start;
+	}
+
+	set_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags);
+
+	return 0;
+}
+
+static int ath11k_ahb_setup_resources(struct ath11k_base *ab)
+{
+	struct platform_device *pdev = ab->pdev;
+	struct resource *mem_res;
+	void __iomem *mem;
+
+	if (ab->bus_params.hybrid_bus_type)
+		return ath11k_ahb_setup_msi_resources(ab);
+
+	mem = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
+	if (IS_ERR(mem)) {
+		dev_err(&pdev->dev, "ioremap error\n");
+		return PTR_ERR(mem);
+	}
+
+	ab->mem = mem;
+	ab->mem_len = resource_size(mem_res);
+
+	return 0;
+}
+
 static int ath11k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath11k_base *ab;
 	const struct of_device_id *of_id;
-	struct resource *mem_res;
-	void __iomem *mem;
+	const struct ath11k_bus_params *bus_params;
+	const struct ath11k_hif_ops *hif_ops;
+	enum ath11k_hw_rev hw_rev;
 	int ret;
 
 	of_id = of_match_device(ath11k_ahb_of_match, &pdev->dev);
@@ -676,10 +781,21 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	mem = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
-	if (IS_ERR(mem)) {
-		dev_err(&pdev->dev, "ioremap error\n");
-		return PTR_ERR(mem);
+	hw_rev = (enum ath11k_hw_rev)of_id->data;
+
+	switch (hw_rev) {
+	case ATH11K_HW_IPQ8074:
+	case ATH11K_HW_IPQ6018_HW10:
+		bus_params = &bus_params_ipq8074;
+		hif_ops = &hif_ops_ipq8074;
+		break;
+	case ATH11K_HW_WCN6750_HW10:
+		bus_params = &bus_params_wcn6750;
+		hif_ops = &hif_ops_wcn6750;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported device type %d\n", hw_rev);
+		return -EOPNOTSUPP;
 	}
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -689,20 +805,21 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	}
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(struct ath11k_ahb),
-			       ATH11K_BUS_AHB,
-			       &ath11k_ahb_bus_params);
+			       ATH11K_BUS_AHB, bus_params);
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
 	}
 
-	ab->hif.ops = &ath11k_ahb_hif_ops;
+	ab->hif.ops = hif_ops;
 	ab->pdev = pdev;
-	ab->hw_rev = (enum ath11k_hw_rev)of_id->data;
-	ab->mem = mem;
-	ab->mem_len = resource_size(mem_res);
+	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
 
+	ret = ath11k_ahb_setup_resources(ab);
+	if (ret)
+		goto err_core_free;
+
 	ret = ath11k_core_pre_init(ab);
 	if (ret)
 		goto err_core_free;
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index a97f2dd..1ae038e 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -10,7 +10,6 @@
 
 #define ATH11K_AHB_RECOVERY_TIMEOUT (3 * HZ)
 struct ath11k_base;
-extern const struct ath11k_bus_params ath11k_hybrid_bus_params;
 
 struct ath11k_ahb {
 	struct rproc *tgt_rproc;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a4b56df..fb3a7ef 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -812,6 +812,7 @@ struct ath11k_base {
 	struct {
 		const struct ath11k_msi_config *msi_config;
 		u32 msi_ep_base_data;
+		u32 irqs[32];
 		u32 msi_addr_lo;
 		u32 msi_addr_hi;
 	} msi;
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.c b/drivers/net/wireless/ath/ath11k/pci_cmn.c
index 76db5a6..233bf84 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.c
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
@@ -95,6 +95,15 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 		},
 		.hw_rev = ATH11K_HW_WCN6855_HW20,
 	},
+	{
+		.total_vectors = 28,
+		.total_users = 2,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "CE", .num_vectors = 10, .base_vector = 0 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 10 },
+		},
+		.hw_rev = ATH11K_HW_WCN6750_HW10,
+	},
 };
 
 int ath11k_pci_get_msi_config(struct ath11k_base *ab)
-- 
2.7.4

