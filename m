Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C04E8DA2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbiC1F7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 01:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiC1F7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 01:59:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF2651584
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648447061; x=1679983061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yBRbPBV6q70JuCRaU8AuqBEsdc4l78of4BmcMYgvEFM=;
  b=hMsYZ1rQMHrvYZTAo1xWXV4M8zJHysCQtHEDkdBjFJayiVGMqW0I1m93
   6giwzTRa+aZrzw1d6djCTAoVzbnCrqoVIU/Q/UV/9P+AjSGcuMQBjcQOe
   tX+HaSI2TYOCnVh55ES1LVZ25jVO4+aMLyj3+HnW/zRctNwvdDqYoQ1G5
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Mar 2022 22:57:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 22:57:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:40 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:38 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 1/5] ath11k: PCI changes to support WCN6750
Date:   Mon, 28 Mar 2022 11:27:10 +0530
Message-ID: <20220328055714.6449-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328055714.6449-1-quic_mpubbise@quicinc.com>
References: <20220328055714.6449-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to add the support for WCN6750 in ATH11K , it is
required to move certain PCI definitions to the header file.
As a result, add ATH11K_PCI_* prefix to these definitions.

Also, change the scope of certain PCI APIs that are required
to enable WCN6750 from static to global.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 110 ++++++++++++--------------
 drivers/net/wireless/ath/ath11k/pci.h |  35 ++++++++
 2 files changed, 84 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 8a3ff12057e8..5e71eafdf9a3 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -17,25 +18,10 @@
 #define ATH11K_PCI_BAR_NUM		0
 #define ATH11K_PCI_DMA_MASK		32
 
-#define ATH11K_PCI_IRQ_CE0_OFFSET	3
-#define ATH11K_PCI_IRQ_DP_OFFSET	14
-
-#define WINDOW_ENABLE_BIT		0x40000000
-#define WINDOW_REG_ADDRESS		0x310c
-#define WINDOW_VALUE_MASK		GENMASK(24, 19)
-#define WINDOW_START			0x80000
-#define WINDOW_RANGE_MASK		GENMASK(18, 0)
-
 #define TCSR_SOC_HW_VERSION		0x0224
 #define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(11, 8)
 #define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 0)
 
-/* BAR0 + 4k is always accessible, and no
- * need to force wakeup.
- * 4K - 32 = 0xFE0
- */
-#define ACCESS_ALWAYS_OFF 0xFE0
-
 #define QCA6390_DEVICE_ID		0x1101
 #define QCN9074_DEVICE_ID		0x1104
 #define WCN6855_DEVICE_ID		0x1103
@@ -147,27 +133,30 @@ static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offse
 {
 	struct ath11k_base *ab = ab_pci->ab;
 
-	u32 window = FIELD_GET(WINDOW_VALUE_MASK, offset);
+	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
 
 	lockdep_assert_held(&ab_pci->window_lock);
 
 	if (window != ab_pci->register_window) {
-		iowrite32(WINDOW_ENABLE_BIT | window,
-			  ab->mem + WINDOW_REG_ADDRESS);
-		ioread32(ab->mem + WINDOW_REG_ADDRESS);
+		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
+			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
 		ab_pci->register_window = window;
 	}
 }
 
 static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
 {
-	u32 umac_window = FIELD_GET(WINDOW_VALUE_MASK, HAL_SEQ_WCSS_UMAC_OFFSET);
-	u32 ce_window = FIELD_GET(WINDOW_VALUE_MASK, HAL_CE_WFSS_CE_REG_BASE);
+	u32 umac_window;
+	u32 ce_window;
 	u32 window;
 
+	umac_window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, HAL_SEQ_WCSS_UMAC_OFFSET);
+	ce_window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, HAL_CE_WFSS_CE_REG_BASE);
 	window = (umac_window << 12) | (ce_window << 6);
 
-	iowrite32(WINDOW_ENABLE_BIT | window, ab_pci->ab->mem + WINDOW_REG_ADDRESS);
+	iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
+		  ab_pci->ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
 }
 
 static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
@@ -176,13 +165,13 @@ static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
 	u32 window_start;
 
 	/* If offset lies within DP register range, use 3rd window */
-	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < WINDOW_RANGE_MASK)
-		window_start = 3 * WINDOW_START;
+	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = 3 * ATH11K_PCI_WINDOW_START;
 	/* If offset lies within CE register range, use 2nd window */
-	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < WINDOW_RANGE_MASK)
-		window_start = 2 * WINDOW_START;
+	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = 2 * ATH11K_PCI_WINDOW_START;
 	else
-		window_start = WINDOW_START;
+		window_start = ATH11K_PCI_WINDOW_START;
 
 	return window_start;
 }
@@ -198,32 +187,32 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	 */
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
 		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
 
-	if (offset < WINDOW_START) {
+	if (offset < ATH11K_PCI_WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
 	} else {
 		if (ab->bus_params.static_window_map)
 			window_start = ath11k_pci_get_window_start(ab, offset);
 		else
-			window_start = WINDOW_START;
+			window_start = ATH11K_PCI_WINDOW_START;
 
-		if (window_start == WINDOW_START) {
+		if (window_start == ATH11K_PCI_WINDOW_START) {
 			spin_lock_bh(&ab_pci->window_lock);
 			ath11k_pci_select_window(ab_pci, offset);
 			iowrite32(value, ab->mem + window_start +
-				  (offset & WINDOW_RANGE_MASK));
+				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 			spin_unlock_bh(&ab_pci->window_lock);
 		} else {
 			iowrite32(value, ab->mem + window_start +
-				  (offset & WINDOW_RANGE_MASK));
+				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 		}
 	}
 
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
 	    !ret)
 		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
@@ -239,32 +228,32 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 	 */
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
 		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
 
-	if (offset < WINDOW_START) {
+	if (offset < ATH11K_PCI_WINDOW_START) {
 		val = ioread32(ab->mem + offset);
 	} else {
 		if (ab->bus_params.static_window_map)
 			window_start = ath11k_pci_get_window_start(ab, offset);
 		else
-			window_start = WINDOW_START;
+			window_start = ATH11K_PCI_WINDOW_START;
 
-		if (window_start == WINDOW_START) {
+		if (window_start == ATH11K_PCI_WINDOW_START) {
 			spin_lock_bh(&ab_pci->window_lock);
 			ath11k_pci_select_window(ab_pci, offset);
 			val = ioread32(ab->mem + window_start +
-				       (offset & WINDOW_RANGE_MASK));
+				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 			spin_unlock_bh(&ab_pci->window_lock);
 		} else {
 			val = ioread32(ab->mem + window_start +
-				       (offset & WINDOW_RANGE_MASK));
+				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 		}
 	}
 
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
 	    !ret)
 		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 
@@ -474,8 +463,8 @@ int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
 	return pci_irq_vector(pci_dev, vector);
 }
 
-static void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
-				       u32 *msi_addr_hi)
+void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+				u32 *msi_addr_hi)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
@@ -519,8 +508,7 @@ int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_nam
 	return -EINVAL;
 }
 
-static void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
-				      u32 *msi_idx)
+void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
 {
 	u32 i, msi_data_idx;
 
@@ -536,9 +524,9 @@ static void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
 	*msi_idx = msi_data_idx;
 }
 
-static int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
-					  int *num_vectors, u32 *user_base_data,
-					  u32 *base_vector)
+int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
+				   int *num_vectors, u32 *user_base_data,
+				   u32 *base_vector)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
@@ -561,7 +549,7 @@ static void ath11k_pci_free_ext_irq(struct ath11k_base *ab)
 	}
 }
 
-static void ath11k_pci_free_irq(struct ath11k_base *ab)
+void ath11k_pci_free_irq(struct ath11k_base *ab)
 {
 	int i, irq_idx;
 
@@ -710,7 +698,7 @@ static void ath11k_pci_ext_grp_enable(struct ath11k_ext_irq_grp *irq_grp)
 		enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
 }
 
-static void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
+void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
 {
 	int i;
 
@@ -741,7 +729,7 @@ static void ath11k_pci_sync_ext_irqs(struct ath11k_base *ab)
 	}
 }
 
-static void ath11k_pci_ext_irq_disable(struct ath11k_base *ab)
+void ath11k_pci_ext_irq_disable(struct ath11k_base *ab)
 {
 	__ath11k_pci_ext_irq_disable(ab);
 	ath11k_pci_sync_ext_irqs(ab);
@@ -854,8 +842,8 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 	return 0;
 }
 
-static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
-					    const struct cpumask *m)
+int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
+				     const struct cpumask *m)
 {
 	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
 		return 0;
@@ -863,7 +851,7 @@ static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
 	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
 }
 
-static int ath11k_pci_config_irq(struct ath11k_base *ab)
+int ath11k_pci_config_irq(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	struct ath11k_ce_pipe *ce_pipe;
@@ -939,7 +927,7 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 				    &cfg->shadow_reg_v2_len);
 }
 
-static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
+void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
 {
 	int i;
 
@@ -1151,7 +1139,7 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
 
-static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
+void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
 		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
@@ -1234,20 +1222,20 @@ static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
 	}
 }
 
-static void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab)
+void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab)
 {
 	ath11k_pci_ce_irqs_disable(ab);
 	ath11k_pci_sync_ce_irqs(ab);
 	ath11k_pci_kill_tasklets(ab);
 }
 
-static void ath11k_pci_stop(struct ath11k_base *ab)
+void ath11k_pci_stop(struct ath11k_base *ab)
 {
 	ath11k_pci_ce_irq_disable_sync(ab);
 	ath11k_ce_cleanup_pipes(ab);
 }
 
-static int ath11k_pci_start(struct ath11k_base *ab)
+int ath11k_pci_start(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
@@ -1277,8 +1265,8 @@ static void ath11k_pci_hif_ce_irq_disable(struct ath11k_base *ab)
 	ath11k_pci_ce_irq_disable_sync(ab);
 }
 
-static int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
-					  u8 *ul_pipe, u8 *dl_pipe)
+int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				   u8 *ul_pipe, u8 *dl_pipe)
 {
 	const struct service_to_pipe *entry;
 	bool ul_set = false, dl_set = false;
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 61d67b20a0eb..31ee843c1cab 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef _ATH11K_PCI_H
 #define _ATH11K_PCI_H
@@ -52,6 +53,21 @@
 #define WLAON_QFPROM_PWR_CTRL_REG		0x01f8031c
 #define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
 
+#define ATH11K_PCI_IRQ_CE0_OFFSET	3
+#define ATH11K_PCI_IRQ_DP_OFFSET	14
+
+#define ATH11K_PCI_WINDOW_ENABLE_BIT		0x40000000
+#define ATH11K_PCI_WINDOW_REG_ADDRESS		0x310c
+#define ATH11K_PCI_WINDOW_VALUE_MASK		GENMASK(24, 19)
+#define ATH11K_PCI_WINDOW_START			0x80000
+#define ATH11K_PCI_WINDOW_RANGE_MASK		GENMASK(18, 0)
+
+/* BAR0 + 4k is always accessible, and no
+ * need to force wakeup.
+ * 4K - 32 = 0xFE0
+ */
+#define ATH11K_PCI_ACCESS_ALWAYS_OFF 0xFE0
+
 struct ath11k_msi_user {
 	char *name;
 	int num_vectors;
@@ -103,5 +119,24 @@ int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_nam
 int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector);
 void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value);
 u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset);
+void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+				u32 *msi_addr_hi);
+void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
+void ath11k_pci_free_irq(struct ath11k_base *ab);
+int ath11k_pci_config_irq(struct ath11k_base *ab);
+void ath11k_pci_ext_irq_enable(struct ath11k_base *ab);
+void ath11k_pci_ext_irq_disable(struct ath11k_base *ab);
+void ath11k_pci_stop(struct ath11k_base *ab);
+int ath11k_pci_start(struct ath11k_base *ab);
+int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				   u8 *ul_pipe, u8 *dl_pipe);
+void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab);
+void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab);
+int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
+				   int *num_vectors, u32 *user_base_data,
+				   u32 *base_vector);
+void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci);
+int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
+				     const struct cpumask *m);
 
 #endif
-- 
2.35.1

