Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC08E51515B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379427AbiD2RJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379415AbiD2RJa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:09:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146482307;
        Fri, 29 Apr 2022 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651251971; x=1682787971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RMg0of5y/DJQJWWp2ZUv1xS0vkfZBaRA+FhBwGY+A+U=;
  b=VtIkGR/Q0/k4D9noOLtPsaPVRnL/+SHWQWaiwDidhqGMVs21bqQXiOl0
   B4++b2mZW2bnrCiJC+pZ8xpv/zIG3jy1t7RTQ1qJN+Z0bkXjNKjwHYpG7
   3QG8WuSOGlRWQwgdjCdHIrDXRvlOo51GNUDEe9WAkN/bGizL9gCl8Hb/c
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Apr 2022 10:06:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:06:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:51 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:48 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v7 9/9] ath11k: Add support for WCN6750 device
Date:   Fri, 29 Apr 2022 22:35:02 +0530
Message-ID: <20220429170502.20080-10-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
References: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

An important point to note is that though WCN6750 is a PCIe device,
it cannot be attached to any other platform except on Qualcomm
Snapdragon SoCs due to the aforementioned reasons.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Makefile |   5 +-
 drivers/net/wireless/ath/ath11k/ahb.c    | 142 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h   |   1 +
 drivers/net/wireless/ath/ath11k/pcic.c   |  23 ++++
 4 files changed, 158 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 0ebfe41d6143..cc47e0114595 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -16,7 +16,8 @@ ath11k-y += core.o \
 	    ce.o \
 	    peer.o \
 	    dbring.o \
-	    hw.o
+	    hw.o \
+	    pcic.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
@@ -29,7 +30,7 @@ obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
 
 obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
-ath11k_pci-y += mhi.o pci.o pcic.o
+ath11k_pci-y += mhi.o pci.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 49d79cfbf21c..050bda828966 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "hif.h"
 #include <linux/remoteproc.h>
+#include "pcic.h"
 
 static const struct of_device_id ath11k_ahb_of_match[] = {
 	/* TODO: Should we change the compatible string to something similar
@@ -24,6 +25,9 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq6018-wifi",
 	  .data = (void *)ATH11K_HW_IPQ6018_HW10,
 	},
+	{ .compatible = "qcom,wcn6750-wifi",
+	  .data = (void *)ATH11K_HW_WCN6750_HW10,
+	},
 	{ }
 };
 
@@ -128,6 +132,16 @@ enum ext_irq_num {
 	tcl2host_status_ring,
 };
 
+static int
+ath11k_ahb_get_msi_irq_wcn6750(struct ath11k_base *ab, unsigned int vector)
+{
+	return ab->pci.msi.irqs[vector];
+}
+
+static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
+	.get_msi_irq = ath11k_ahb_get_msi_irq_wcn6750,
+};
+
 static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
 {
 	return ioread32(ab->mem + offset);
@@ -395,6 +409,9 @@ static void ath11k_ahb_free_irq(struct ath11k_base *ab)
 	int irq_idx;
 	int i;
 
+	if (ab->hw_params.hybrid_bus_type)
+		return ath11k_pcic_free_irq(ab);
+
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
@@ -549,6 +566,9 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 	int irq, irq_idx, i;
 	int ret;
 
+	if (ab->hw_params.hybrid_bus_type)
+		return ath11k_pcic_config_irq(ab);
+
 	/* Configure CE irqs */
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
@@ -618,7 +638,7 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	return 0;
 }
 
-static const struct ath11k_hif_ops ath11k_ahb_hif_ops = {
+static const struct ath11k_hif_ops ath11k_ahb_hif_ops_ipq8074 = {
 	.start = ath11k_ahb_start,
 	.stop = ath11k_ahb_stop,
 	.read32 = ath11k_ahb_read32,
@@ -630,6 +650,20 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops = {
 	.power_up = ath11k_ahb_power_up,
 };
 
+static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
+	.start = ath11k_pcic_start,
+	.stop = ath11k_pcic_stop,
+	.read32 = ath11k_pcic_read32,
+	.write32 = ath11k_pcic_write32,
+	.irq_enable = ath11k_pcic_ext_irq_enable,
+	.irq_disable = ath11k_pcic_ext_irq_disable,
+	.get_msi_address =  ath11k_pcic_get_msi_address,
+	.get_user_msi_vector = ath11k_pcic_get_user_msi_assignment,
+	.map_service_to_pipe = ath11k_pcic_map_service_to_pipe,
+	.power_down = ath11k_ahb_power_down,
+	.power_up = ath11k_ahb_power_up,
+};
+
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
@@ -652,12 +686,84 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
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
+	ret = ath11k_pcic_init_msi_config(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init msi config: %d\n", ret);
+		return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
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
+	ab->pci.msi.addr_lo = lower_32_bits(msi_addr_iova);
+	ab->pci.msi.addr_hi = upper_32_bits(msi_addr_iova);
+
+	ret = of_property_read_u32_index(ab->dev->of_node, "interrupts", 1, &int_prop);
+	if (ret)
+		return ret;
+
+	ab->pci.msi.ep_base_data = int_prop + 32;
+
+	for (i = 0; i < ab->pci.msi.config->total_vectors; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		if (!res)
+			return -ENODEV;
+
+		ab->pci.msi.irqs[i] = res->start;
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
+	if (ab->hw_params.hybrid_bus_type)
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
+	const struct ath11k_hif_ops *hif_ops;
+	const struct ath11k_pci_ops *pci_ops;
+	enum ath11k_hw_rev hw_rev;
 	int ret;
 
 	of_id = of_match_device(ath11k_ahb_of_match, &pdev->dev);
@@ -666,10 +772,21 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
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
+		hif_ops = &ath11k_ahb_hif_ops_ipq8074;
+		pci_ops = NULL;
+		break;
+	case ATH11K_HW_WCN6750_HW10:
+		hif_ops = &ath11k_ahb_hif_ops_wcn6750;
+		pci_ops = &ath11k_ahb_pci_ops_wcn6750;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported device type %d\n", hw_rev);
+		return -EOPNOTSUPP;
 	}
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -685,13 +802,16 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ab->hif.ops = &ath11k_ahb_hif_ops;
+	ab->hif.ops = hif_ops;
+	ab->pci.ops = pci_ops;
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
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index fdea44627125..95bca0b078b1 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -950,6 +950,7 @@ struct ath11k_base {
 		struct {
 			const struct ath11k_msi_config *config;
 			u32 ep_base_data;
+			u32 irqs[32];
 			u32 addr_lo;
 			u32 addr_hi;
 		} msi;
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 46cf96d3e1d2..cf12b98c480d 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -106,6 +106,15 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 		},
 		.hw_rev = ATH11K_HW_WCN6855_HW21,
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
 
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
@@ -172,6 +181,7 @@ void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	    !ret)
 		ab->pci.ops->release(ab);
 }
+EXPORT_SYMBOL(ath11k_pcic_write32);
 
 u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 {
@@ -203,6 +213,7 @@ u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 
 	return val;
 }
+EXPORT_SYMBOL(ath11k_pcic_read32);
 
 void ath11k_pcic_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
 				 u32 *msi_addr_hi)
@@ -210,6 +221,7 @@ void ath11k_pcic_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
 	*msi_addr_lo = ab->pci.msi.addr_lo;
 	*msi_addr_hi = ab->pci.msi.addr_hi;
 }
+EXPORT_SYMBOL(ath11k_pcic_get_msi_address);
 
 int ath11k_pcic_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 					int *num_vectors, u32 *user_base_data,
@@ -237,6 +249,7 @@ int ath11k_pcic_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL(ath11k_pcic_get_user_msi_assignment);
 
 void ath11k_pcic_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
 {
@@ -253,6 +266,7 @@ void ath11k_pcic_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
 	}
 	*msi_idx = msi_data_idx;
 }
+EXPORT_SYMBOL(ath11k_pcic_get_ce_msi_idx);
 
 static void ath11k_pcic_free_ext_irq(struct ath11k_base *ab)
 {
@@ -281,6 +295,7 @@ void ath11k_pcic_free_irq(struct ath11k_base *ab)
 
 	ath11k_pcic_free_ext_irq(ab);
 }
+EXPORT_SYMBOL(ath11k_pcic_free_irq);
 
 static void ath11k_pcic_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 {
@@ -431,6 +446,7 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
 		ath11k_pcic_ext_grp_enable(irq_grp);
 	}
 }
+EXPORT_SYMBOL(ath11k_pcic_ext_irq_enable);
 
 static void ath11k_pcic_sync_ext_irqs(struct ath11k_base *ab)
 {
@@ -451,6 +467,7 @@ void ath11k_pcic_ext_irq_disable(struct ath11k_base *ab)
 	__ath11k_pcic_ext_irq_disable(ab);
 	ath11k_pcic_sync_ext_irqs(ab);
 }
+EXPORT_SYMBOL(ath11k_pcic_ext_irq_disable);
 
 static int ath11k_pcic_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 {
@@ -630,6 +647,7 @@ int ath11k_pcic_config_irq(struct ath11k_base *ab)
 
 	return 0;
 }
+EXPORT_SYMBOL(ath11k_pcic_config_irq);
 
 void ath11k_pcic_ce_irqs_enable(struct ath11k_base *ab)
 {
@@ -643,6 +661,7 @@ void ath11k_pcic_ce_irqs_enable(struct ath11k_base *ab)
 		ath11k_pcic_ce_irq_enable(ab, i);
 	}
 }
+EXPORT_SYMBOL(ath11k_pcic_ce_irqs_enable);
 
 static void ath11k_pcic_kill_tasklets(struct ath11k_base *ab)
 {
@@ -664,12 +683,14 @@ void ath11k_pcic_ce_irq_disable_sync(struct ath11k_base *ab)
 	ath11k_pcic_sync_ce_irqs(ab);
 	ath11k_pcic_kill_tasklets(ab);
 }
+EXPORT_SYMBOL(ath11k_pcic_ce_irq_disable_sync);
 
 void ath11k_pcic_stop(struct ath11k_base *ab)
 {
 	ath11k_pcic_ce_irq_disable_sync(ab);
 	ath11k_ce_cleanup_pipes(ab);
 }
+EXPORT_SYMBOL(ath11k_pcic_stop);
 
 int ath11k_pcic_start(struct ath11k_base *ab)
 {
@@ -680,6 +701,7 @@ int ath11k_pcic_start(struct ath11k_base *ab)
 
 	return 0;
 }
+EXPORT_SYMBOL(ath11k_pcic_start);
 
 int ath11k_pcic_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 				    u8 *ul_pipe, u8 *dl_pipe)
@@ -723,3 +745,4 @@ int ath11k_pcic_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 
 	return 0;
 }
+EXPORT_SYMBOL(ath11k_pcic_map_service_to_pipe);
-- 
2.35.1

