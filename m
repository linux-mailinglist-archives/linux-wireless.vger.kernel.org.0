Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C511545ABB4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbhKWSyk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:54:40 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53743 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbhKWSyj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693491; x=1669229491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VYVBPUAaMBkqS0PGy5op1MsseVmvUv9w5iv7yKfUkpk=;
  b=pLWwkybxfh8HYCdV6Qz9Ff1UH5hQ7yynxMk+LSsRk505wwQnwdIHcrce
   W1aI6z87QkoctlMF7L09D8xqKMzMxolLWWhFwUieV0iF/gHy0lowiqp/J
   T4+JSzy8DNX2Yccx4rxjatpBVzsfeXh149AcZcTnNs0PLg8jI1r9/6g8T
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Nov 2021 10:51:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:51:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:28 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:26 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 05/19] ath11k: Remove core PCI references from PCI common code
Date:   Wed, 24 Nov 2021 00:20:20 +0530
Message-ID: <1637693434-15462-6-git-send-email-quic_mpubbise@quicinc.com>
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

Remove core PCI and ath11k PCI references(struct ath11k_pci)
from PCI common code. Since, PCI common code will be used
by hybrid bus devices, this code should be independent
from ATH11K PCI references and Linux core PCI references
like struct pci_dev.

Since this change introduces function callbacks for bus wakeup
and bus release operations, wakeup_mhi HW param is no longer
needed and hence it is removed completely. Alternatively, bus
wakeup/release ops for QCA9074 are initialized to NULL as
QCA9704 does not need bus wakeup/release for register accesses.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c    |   5 -
 drivers/net/wireless/ath/ath11k/core.h    |   9 ++
 drivers/net/wireless/ath/ath11k/hw.h      |   1 -
 drivers/net/wireless/ath/ath11k/mhi.c     |   7 +-
 drivers/net/wireless/ath/ath11k/pci.c     | 130 ++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/pci.h     |   5 +-
 drivers/net/wireless/ath/ath11k/pci_cmn.c | 174 +++++++++++-------------------
 drivers/net/wireless/ath/ath11k/pci_cmn.h |   6 +-
 8 files changed, 200 insertions(+), 137 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a3a9bfe..6e3d4aa 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -89,7 +89,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
-		.wakeup_mhi = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -143,7 +142,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
-		.wakeup_mhi = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -196,7 +194,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
-		.wakeup_mhi = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -249,7 +246,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = true,
 		.alloc_cacheable_memory = true,
-		.wakeup_mhi = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -302,7 +298,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
-		.wakeup_mhi = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index ec841d5..70324ee 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -202,6 +202,8 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_HTC_SUSPEND_COMPLETE,
 	ATH11K_FLAG_CE_IRQ_ENABLED,
 	ATH11K_FLAG_EXT_IRQ_ENABLED,
+	ATH11K_FLAG_DEVICE_INIT_DONE,
+	ATH11K_FLAG_MULTI_MSI_VECTORS,
 };
 
 enum ath11k_monitor_flags {
@@ -635,6 +637,13 @@ struct ath11k_bus_params {
 	bool fixed_bdf_addr;
 	bool fixed_mem_region;
 	bool static_window_map;
+	struct {
+		void (*wakeup)(struct ath11k_base *ab);
+		void (*release)(struct ath11k_base *ab);
+		int (*get_msi_irq)(struct ath11k_base *ab, unsigned int vector);
+		void (*window_write32)(struct ath11k_base *ab, u32 offset, u32 value);
+		u32 (*window_read32)(struct ath11k_base *ab, u32 offset);
+	} ops;
 };
 
 /* IPQ8074 HW channel counters frequency value in hertz */
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 2c9d232..dd2202f 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -180,7 +180,6 @@ struct ath11k_hw_params {
 	const struct ath11k_hw_hal_params *hal_params;
 	bool supports_dynamic_smps_6ghz;
 	bool alloc_cacheable_memory;
-	bool wakeup_mhi;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 9a22b44..9a94989 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -269,11 +269,10 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	for (i = 0; i < num_vectors; i++) {
 		msi_data = base_vector;
 
-		if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		if (test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
 			msi_data += i;
 
-		irq[i] = ath11k_pci_get_msi_irq(ab->dev,
-						msi_data);
+		irq[i] = ath11k_pci_get_msi_irq(ab, msi_data);
 	}
 
 	ab_pci->mhi_ctrl->irq = irq;
@@ -349,7 +348,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		return ret;
 	}
 
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+	if (!test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
 		mhi_ctrl->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
 
 	mhi_ctrl->iova_start = 0;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 699f4df..d85894e 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -36,11 +36,83 @@ static const struct pci_device_id ath11k_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 
+static void ath11k_pci_bus_wake_up(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+static void ath11k_pci_bus_release(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+
+	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
+
+	lockdep_assert_held(&ab_pci->window_lock);
+
+	if (window != ab_pci->register_window) {
+		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
+			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+		ab_pci->register_window = window;
+	}
+}
+
+static void
+ath11k_pci_window_write32(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 window_start = ATH11K_PCI_WINDOW_START;
+
+	spin_lock_bh(&ab_pci->window_lock);
+	ath11k_pci_select_window(ab_pci, offset);
+	iowrite32(value, ab->mem + window_start +
+		  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	spin_unlock_bh(&ab_pci->window_lock);
+}
+
+static u32 ath11k_pci_window_read32(struct ath11k_base *ab, u32 offset)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 window_start = ATH11K_PCI_WINDOW_START;
+	u32 val;
+
+	spin_lock_bh(&ab_pci->window_lock);
+	ath11k_pci_select_window(ab_pci, offset);
+	val = ioread32(ab->mem + window_start +
+		       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	spin_unlock_bh(&ab_pci->window_lock);
+
+	return val;
+}
+
+int ath11k_pci_get_msi_irq(struct ath11k_base *ab, unsigned int vector)
+{
+	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+
+	return pci_irq_vector(pci_dev, vector);
+}
+
 static const struct ath11k_bus_params ath11k_pci_bus_params = {
 	.mhi_support = true,
 	.m3_fw_support = true,
 	.fixed_bdf_addr = false,
 	.fixed_mem_region = false,
+	.ops = {
+		.wakeup = ath11k_pci_bus_wake_up,
+		.release = ath11k_pci_bus_release,
+		.get_msi_irq = ath11k_pci_get_msi_irq,
+		.window_write32 = ath11k_pci_window_write32,
+		.window_read32 = ath11k_pci_window_read32,
+	},
 };
 
 static const struct ath11k_msi_config msi_config_one_msi = {
@@ -318,8 +390,7 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 					    msi_config->total_vectors,
 					    PCI_IRQ_MSI);
 	if (num_vectors == msi_config->total_vectors) {
-		set_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
-		ab_pci->irq_flags = IRQF_SHARED;
+		set_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags);
 	} else {
 		num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
 						    1,
@@ -329,9 +400,8 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 			ret = -EINVAL;
 			goto reset_msi_config;
 		}
-		clear_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
+		clear_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags);
 		ab->msi.msi_config = &msi_config_one_msi;
-		ab_pci->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
 		ath11k_dbg(ab, ATH11K_DBG_PCI, "request MSI one vector\n");
 	}
 	ath11k_info(ab, "MSI vectors: %d\n", num_vectors);
@@ -487,13 +557,20 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
 
+static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
+{
+	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
+		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+					   ab_pci->link_ctl);
+}
+
 static int ath11k_pci_power_up(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	int ret;
 
 	ab_pci->register_window = 0;
-	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
+	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, true);
 
 	/* Disable ASPM during firmware download due to problems switching
@@ -527,7 +604,7 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 	ath11k_pci_msi_disable(ab_pci);
 
 	ath11k_mhi_stop(ab_pci);
-	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
+	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
 
@@ -559,6 +636,23 @@ static void ath11k_pci_hif_ce_irq_disable(struct ath11k_base *ab)
 	ath11k_pci_ce_irq_disable_sync(ab);
 }
 
+static int ath11k_pci_start(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	/* TODO: for now don't restore ASPM in case of single MSI
+	 * vector as MHI register reading in M2 causes system hang.
+	 */
+	if (test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
+		ath11k_pci_aspm_restore(ab_pci);
+	else
+		ath11k_info(ab, "leaving PCI ASPM disabled to avoid MHI M2 problems\n");
+
+	ath11k_pci_start_cmn(ab);
+
+	return 0;
+}
+
 static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.start = ath11k_pci_start,
 	.stop = ath11k_pci_stop,
@@ -592,6 +686,15 @@ static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *
 		   *major, *minor);
 }
 
+static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
+					    const struct cpumask *m)
+{
+	if (test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab_pci->ab->dev_flags))
+		return 0;
+
+	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+}
+
 static int ath11k_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *pci_dev)
 {
@@ -649,6 +752,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		break;
 	case QCN9074_DEVICE_ID:
 		ab->bus_params.static_window_map = true;
+		ab->bus_params.ops.wakeup = NULL;
+		ab->bus_params.ops.release = NULL;
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
 	case WCN6855_DEVICE_ID:
@@ -713,6 +818,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
+	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
+		goto err_free_irq;
+	}
+
 	/* kernel may allocate a dummy vector before request_irq and
 	 * then allocate a real vector when request_irq is called.
 	 * So get msi_data here again to avoid spurious interrupt
@@ -721,16 +832,19 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ret = ath11k_pci_config_msi_data(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 
 	ret = ath11k_core_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init core: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 	return 0;
 
+err_irq_affinity_cleanup:
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 err_free_irq:
 	ath11k_pci_free_irq(ab);
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 694fcb4..aec4609 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -54,9 +54,7 @@
 #define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
 
 enum ath11k_pci_flags {
-	ATH11K_PCI_FLAG_INIT_DONE,
 	ATH11K_PCI_ASPM_RESTORE,
-	ATH11K_PCI_FLAG_MULTI_MSI_VECTORS,
 };
 
 struct ath11k_pci {
@@ -74,8 +72,6 @@ struct ath11k_pci {
 	/* enum ath11k_pci_flags */
 	unsigned long flags;
 	u16 link_ctl;
-
-	unsigned long irq_flags;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
@@ -83,4 +79,5 @@ static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
 	return (struct ath11k_pci *)ab->drv_priv;
 }
 
+int ath11k_pci_get_msi_irq(struct ath11k_base *ab, unsigned int vector);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.c b/drivers/net/wireless/ath/ath11k/pci_cmn.c
index cd1d08d..9aad314 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.c
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <linux/pci.h>
 #include "core.h"
 #include "pci_cmn.h"
 #include "debug.h"
@@ -120,29 +119,6 @@ int ath11k_pci_get_msi_config(struct ath11k_base *ab)
 	return 0;
 }
 
-void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
-{
-	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-					   ab_pci->link_ctl);
-}
-
-static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
-{
-	struct ath11k_base *ab = ab_pci->ab;
-
-	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
-
-	lockdep_assert_held(&ab_pci->window_lock);
-
-	if (window != ab_pci->register_window) {
-		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
-			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
-		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
-		ab_pci->register_window = window;
-	}
-}
-
 static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
 					      u32 offset)
 {
@@ -162,16 +138,15 @@ static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
 
 void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 window_start;
 
 	/* for offset beyond BAR + 4K - 32, may
-	 * need to wakeup MHI to access.
+	 * need to wakeup the device to access.
 	 */
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
+	    ab->bus_params.ops.wakeup)
+		ab->bus_params.ops.wakeup(ab);
 
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
@@ -181,36 +156,32 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 		else
 			window_start = ATH11K_PCI_WINDOW_START;
 
-		if (window_start == ATH11K_PCI_WINDOW_START) {
-			spin_lock_bh(&ab_pci->window_lock);
-			ath11k_pci_select_window(ab_pci, offset);
-			iowrite32(value, ab->mem + window_start +
-				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-			spin_unlock_bh(&ab_pci->window_lock);
+		if (window_start == ATH11K_PCI_WINDOW_START &&
+		    ab->bus_params.ops.window_write32) {
+			ab->bus_params.ops.window_write32(ab, offset, value);
 		} else {
 			iowrite32(value, ab->mem + window_start +
 				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 		}
 	}
 
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
+	    ab->bus_params.ops.release)
+		ab->bus_params.ops.release(ab);
 }
 
 u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 val, window_start;
 
 	/* for offset beyond BAR + 4K - 32, may
-	 * need to wakeup MHI to access.
+	 * need to wakeup the device to access.
 	 */
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
+	    ab->bus_params.ops.wakeup)
+		ab->bus_params.ops.wakeup(ab);
 
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		val = ioread32(ab->mem + offset);
@@ -220,33 +191,23 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 		else
 			window_start = ATH11K_PCI_WINDOW_START;
 
-		if (window_start == ATH11K_PCI_WINDOW_START) {
-			spin_lock_bh(&ab_pci->window_lock);
-			ath11k_pci_select_window(ab_pci, offset);
-			val = ioread32(ab->mem + window_start +
-				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-			spin_unlock_bh(&ab_pci->window_lock);
+		if (window_start == ATH11K_PCI_WINDOW_START &&
+		    ab->bus_params.ops.window_read32) {
+			val = ab->bus_params.ops.window_read32(ab, offset);
 		} else {
 			val = ioread32(ab->mem + window_start +
 				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 		}
 	}
 
-	if (ab->hw_params.wakeup_mhi &&
-	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
+	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
+	    ab->bus_params.ops.release)
+		ab->bus_params.ops.release(ab);
 
 	return val;
 }
 
-int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-
-	return pci_irq_vector(pci_dev, vector);
-}
-
 void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
 				u32 *msi_addr_hi)
 {
@@ -327,13 +288,12 @@ void ath11k_pci_free_irq(struct ath11k_base *ab)
 
 static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 irq_idx;
 
 	/* In case of one MSI vector, we handle irq enable/disable in a
 	 * uniform way since we only have one irq
 	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+	if (!test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
 		return;
 
 	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
@@ -342,13 +302,12 @@ static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 
 static void ath11k_pci_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 irq_idx;
 
 	/* In case of one MSI vector, we handle irq enable/disable in a
 	 * uniform way since we only have one irq
 	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+	if (!test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
 		return;
 
 	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
@@ -413,13 +372,13 @@ static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 
 static void ath11k_pci_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
+	struct ath11k_base *ab = irq_grp->ab;
 	int i;
 
 	/* In case of one MSI vector, we handle irq enable/disable
 	 * in a uniform way since we only have one irq
 	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+	if (!test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
 		return;
 
 	for (i = 0; i < irq_grp->num_irq; i++)
@@ -444,13 +403,13 @@ static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
 
 static void ath11k_pci_ext_grp_enable(struct ath11k_ext_irq_grp *irq_grp)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(irq_grp->ab);
+	struct ath11k_base *ab = irq_grp->ab;
 	int i;
 
 	/* In case of one MSI vector, we handle irq enable/disable in a
 	 * uniform way since we only have one irq
 	 */
-	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+	if (!test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
 		return;
 
 	for (i = 0; i < irq_grp->num_irq; i++)
@@ -535,11 +494,22 @@ static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int
+ath11k_pci_get_msi_irq_cmn(struct ath11k_base *ab, unsigned int vector)
+{
+	if (!ab->bus_params.ops.get_msi_irq) {
+		WARN_ONCE(1, "get_msi_irq bus op not defined");
+		return -EOPNOTSUPP;
+	}
+
+	return ab->bus_params.ops.get_msi_irq(ab, vector);
+}
+
 static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	int i, j, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
+	unsigned long irq_flags;
 
 	ret = ath11k_pci_get_user_msi_assignment(ab, "DP", &num_vectors,
 						 &user_base_data,
@@ -547,6 +517,10 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 	if (ret < 0)
 		return ret;
 
+	irq_flags = IRQF_SHARED;
+	if (!test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
+		irq_flags |= IRQF_NOBALANCING;
+
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 		u32 num_irq = 0;
@@ -574,7 +548,10 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 		for (j = 0; j < irq_grp->num_irq; j++) {
 			int irq_idx = irq_grp->irqs[j];
 			int vector = (i % num_vectors) + base_vector;
-			int irq = ath11k_pci_get_msi_irq(ab->dev, vector);
+			int irq = ath11k_pci_get_msi_irq_cmn(ab, vector);
+
+			if (irq < 0)
+				return irq;
 
 			ab->irq_num[irq_idx] = irq;
 
@@ -583,8 +560,7 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 
 			irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
 			ret = request_irq(irq, ath11k_pci_ext_interrupt_handler,
-					  ab_pci->irq_flags,
-					  "DP_EXT_IRQ", irq_grp);
+					  irq_flags, "DP_EXT_IRQ", irq_grp);
 			if (ret) {
 				ath11k_err(ab, "failed request irq %d: %d\n",
 					   vector, ret);
@@ -597,35 +573,24 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 	return 0;
 }
 
-int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
-				     const struct cpumask *m)
-{
-	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		return 0;
-
-	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
-}
-
 int ath11k_pci_config_irq(struct ath11k_base *ab)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	struct ath11k_ce_pipe *ce_pipe;
 	u32 msi_data_start;
 	u32 msi_data_count, msi_data_idx;
 	u32 msi_irq_start;
 	unsigned int msi_data;
 	int irq, i, ret, irq_idx;
+	unsigned long irq_flags;
 
 	ret = ath11k_pci_get_user_msi_assignment(ab, "CE", &msi_data_count,
 						 &msi_data_start, &msi_irq_start);
 	if (ret)
 		return ret;
 
-	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
-	if (ret) {
-		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
-		return ret;
-	}
+	irq_flags = IRQF_SHARED;
+	if (!test_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags))
+		irq_flags |= IRQF_NOBALANCING;
 
 	/* Configure CE irqs */
 	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
@@ -633,7 +598,10 @@ int ath11k_pci_config_irq(struct ath11k_base *ab)
 			continue;
 
 		msi_data = (msi_data_idx % msi_data_count) + msi_irq_start;
-		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
+		irq = ath11k_pci_get_msi_irq_cmn(ab, msi_data);
+		if (irq < 0)
+			return irq;
+
 		ce_pipe = &ab->ce.ce_pipe[i];
 
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
@@ -641,12 +609,12 @@ int ath11k_pci_config_irq(struct ath11k_base *ab)
 		tasklet_setup(&ce_pipe->intr_tq, ath11k_pci_ce_tasklet);
 
 		ret = request_irq(irq, ath11k_pci_ce_interrupt_handler,
-				  ab_pci->irq_flags, irq_name[irq_idx],
+				  irq_flags, irq_name[irq_idx],
 				  ce_pipe);
 		if (ret) {
 			ath11k_err(ab, "failed to request irq %d: %d\n",
 				   irq_idx, ret);
-			goto err_irq_affinity_cleanup;
+			return ret;
 		}
 
 		ab->irq_num[irq_idx] = irq;
@@ -657,13 +625,9 @@ int ath11k_pci_config_irq(struct ath11k_base *ab)
 
 	ret = ath11k_pci_ext_irq_config(ab);
 	if (ret)
-		goto err_irq_affinity_cleanup;
+		return ret;
 
 	return 0;
-
-err_irq_affinity_cleanup:
-	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	return ret;
 }
 
 void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
@@ -706,19 +670,9 @@ void ath11k_pci_stop(struct ath11k_base *ab)
 	ath11k_ce_cleanup_pipes(ab);
 }
 
-int ath11k_pci_start(struct ath11k_base *ab)
+int ath11k_pci_start_cmn(struct ath11k_base *ab)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-
-	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
-
-	/* TODO: for now don't restore ASPM in case of single MSI
-	 * vector as MHI register reading in M2 causes system hang.
-	 */
-	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
-		ath11k_pci_aspm_restore(ab_pci);
-	else
-		ath11k_info(ab, "leaving PCI ASPM disabled to avoid MHI M2 problems\n");
+	set_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 
 	ath11k_pci_ce_irqs_enable(ab);
 	ath11k_ce_rx_post_buf(ab);
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.h b/drivers/net/wireless/ath/ath11k/pci_cmn.h
index cc78c23..8f99be7 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.h
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.h
@@ -28,7 +28,6 @@
 int ath11k_pci_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 				       int *num_vectors, u32 *user_base_data,
 				       u32 *base_vector);
-int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector);
 void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value);
 u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset);
 void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
@@ -39,13 +38,10 @@ int ath11k_pci_config_irq(struct ath11k_base *ab);
 void ath11k_pci_ext_irq_enable(struct ath11k_base *ab);
 void ath11k_pci_ext_irq_disable(struct ath11k_base *ab);
 void ath11k_pci_stop(struct ath11k_base *ab);
-int ath11k_pci_start(struct ath11k_base *ab);
+int ath11k_pci_start_cmn(struct ath11k_base *ab);
 int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 				   u8 *ul_pipe, u8 *dl_pipe);
 void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab);
 void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab);
-void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci);
-int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
-				     const struct cpumask *m);
 int ath11k_pci_get_msi_config(struct ath11k_base *ab);
 #endif
-- 
2.7.4

