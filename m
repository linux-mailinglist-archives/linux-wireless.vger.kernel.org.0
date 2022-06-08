Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3554283B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiFHHWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbiFHGaj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 02:30:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4576FE0EB
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654669837; x=1686205837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5JcpZETODBWympzpcRZTTJz2MJowTFI/a2s7zImUc1I=;
  b=HDMoalvJ2uc2eLhba4Rool13KxwXiGUW1AaYt+eE//hGtEu5PCZBTvvU
   2TFMUypYJsqFcYWb1bnHgmzDOap3+GAT8rVQlh+GoLG4W4u/AM6rtrv+O
   2khIZN6VuwIULoP5mXEJwUqwDsgEXuMd6eJuaTNP/GmqoD5tliwW92wga
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 23:30:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:30:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 23:30:36 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 23:30:33 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] ath11k: Fix register write failure on QCN9074
Date:   Wed, 8 Jun 2022 11:59:54 +0530
Message-ID: <20220608062954.27792-1-quic_mpubbise@quicinc.com>
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

Commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
regressed QCN9074. With the above mentioned commit, writes are failing
for some registers on QCN9074 although the device seems to work
normally.

ath11k_pci 0000:03:00.0: failed to set pcie link register0x01e0e0a8: 0xffffffff != 0x00000010
ath11k_pci 0000:03:00.0: failed to set sysclk: -110

PCIe devices in ath11k (QCA6390, WCN6855, QCN9074, WCN6750) use window
concept for register accesses. There are two schemes, dynamic & static
window.

In dynamic window scheme, a single window(region in the BAR) is mapped
either to CE or DP register windows at any give time. QCA6390 & WCN6855
follow this scheme for register accesses.

In static window scheme, CE & DP register windows are statically mapped
to separate regions with in the BAR so that there is no switching of
register windows between CE & DP register accesses. QCN9074 & WCN6750
follow this scheme although the window start offsets are different for
QCN9074 & WCN6750.

QCN9074 uses 3rd & 2nd window for DP & CE register accesses respectively
whereas WCN6750 uses 1st & 2nd window for DP & CE. In QCN9074, along with
2nd & 3rd windows, 1st window is also used for certain configurations
which commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
did not account for and hence the regression.

Fix this by going back to the original way of accessing the registers on
QCN9074. Since this diverges from WCN6750 way of accessing registers, it
is required to register window_read32/window_write32() pci_ops for WCN6750.
We can also get rid of dp_window_idx & ce_window_idx members in hw_params,
so remove them.

Also add a new API ath11k_pcic_register_pci_ops() for registering pci_ops
to the ath11k core. This API checks for mandatory pci_ops() and reports
error if those are missing. Also initialize unused pci_ops to NULL.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1

Fixes: 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
Reported-by: Maxime Bizon <mbizon@freebox.fr>
Tested-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 52 +++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.c | 14 -----
 drivers/net/wireless/ath/ath11k/hw.h   |  2 -
 drivers/net/wireless/ath/ath11k/pci.c  | 74 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/pcic.c | 57 ++++++++------------
 drivers/net/wireless/ath/ath11k/pcic.h |  2 +
 6 files changed, 134 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index d7d33d5cdfc5..c47414710138 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -140,8 +140,53 @@ ath11k_ahb_get_msi_irq_wcn6750(struct ath11k_base *ab, unsigned int vector)
 	return ab->pci.msi.irqs[vector];
 }
 
+static inline u32
+ath11k_ahb_get_window_start_wcn6750(struct ath11k_base *ab, u32 offset)
+{
+	u32 window_start = 0;
+
+	/* If offset lies within DP register range, use 1st window */
+	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = ATH11K_PCI_WINDOW_START;
+	/* If offset lies within CE register range, use 2nd window */
+	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
+		 ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = 2 * ATH11K_PCI_WINDOW_START;
+
+	return window_start;
+}
+
+static void
+ath11k_ahb_window_write32_wcn6750(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	u32 window_start;
+
+	/* WCN6750 uses static window based register access*/
+	window_start = ath11k_ahb_get_window_start_wcn6750(ab, offset);
+
+	iowrite32(value, ab->mem + window_start +
+		  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+}
+
+static u32 ath11k_ahb_window_read32_wcn6750(struct ath11k_base *ab, u32 offset)
+{
+	u32 window_start;
+	u32 val;
+
+	/* WCN6750 uses static window based register access */
+	window_start = ath11k_ahb_get_window_start_wcn6750(ab, offset);
+
+	val = ioread32(ab->mem + window_start +
+		       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	return val;
+}
+
 static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
+	.wakeup = NULL,
+	.release = NULL,
 	.get_msi_irq = ath11k_ahb_get_msi_irq_wcn6750,
+	.window_write32 = ath11k_ahb_window_write32_wcn6750,
+	.window_read32 = ath11k_ahb_window_read32_wcn6750,
 };
 
 static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
@@ -971,11 +1016,16 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	}
 
 	ab->hif.ops = hif_ops;
-	ab->pci.ops = pci_ops;
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
 
+	ret = ath11k_pcic_register_pci_ops(ab, pci_ops);
+	if (ret) {
+		ath11k_err(ab, "failed to register PCI ops: %d\n", ret);
+		goto err_core_free;
+	}
+
 	ret = ath11k_core_pre_init(ab);
 	if (ret)
 		goto err_core_free;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c8e0bc935838..6ddc698f4a2d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -107,8 +107,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = true,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
-		.dp_window_idx = 0,
-		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
 	},
@@ -183,8 +181,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = true,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
-		.dp_window_idx = 0,
-		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
 	},
@@ -258,8 +254,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
-		.dp_window_idx = 0,
-		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
 	},
@@ -333,8 +327,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = true,
 		.hybrid_bus_type = false,
-		.dp_window_idx = 3,
-		.ce_window_idx = 2,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
 	},
@@ -408,8 +400,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
-		.dp_window_idx = 0,
-		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
 	},
@@ -482,8 +472,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
-		.dp_window_idx = 0,
-		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
 	},
@@ -556,8 +544,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = true,
 		.hybrid_bus_type = true,
-		.dp_window_idx = 1,
-		.ce_window_idx = 2,
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
 	},
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 77dc5c851c9b..84c284fab5db 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -201,8 +201,6 @@ struct ath11k_hw_params {
 	bool fixed_mem_region;
 	bool static_window_map;
 	bool hybrid_bus_type;
-	u8 dp_window_idx;
-	u8 ce_window_idx;
 	bool fixed_fw_mem;
 	bool support_off_channel_tx;
 };
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 487a303b3077..aec91d7414d5 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -50,6 +50,23 @@ static void ath11k_pci_bus_release(struct ath11k_base *ab)
 	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
 
+static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab, u32 offset)
+{
+	u32 window_start;
+
+	/* If offset lies within DP register range, use 3rd window */
+	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = 3 * ATH11K_PCI_WINDOW_START;
+	/* If offset lies within CE register range, use 2nd window */
+	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
+		 ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = 2 * ATH11K_PCI_WINDOW_START;
+	else
+		window_start = ATH11K_PCI_WINDOW_START;
+
+	return window_start;
+}
+
 static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
 {
 	struct ath11k_base *ab = ab_pci->ab;
@@ -70,13 +87,23 @@ static void
 ath11k_pci_window_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 window_start = ATH11K_PCI_WINDOW_START;
+	u32 window_start;
 
-	spin_lock_bh(&ab_pci->window_lock);
-	ath11k_pci_select_window(ab_pci, offset);
-	iowrite32(value, ab->mem + window_start +
-		  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-	spin_unlock_bh(&ab_pci->window_lock);
+	if (ab->hw_params.static_window_map)
+		window_start = ath11k_pci_get_window_start(ab, offset);
+	else
+		window_start = ATH11K_PCI_WINDOW_START;
+
+	if (window_start == ATH11K_PCI_WINDOW_START) {
+		spin_lock_bh(&ab_pci->window_lock);
+		ath11k_pci_select_window(ab_pci, offset);
+		iowrite32(value, ab->mem + window_start +
+			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		spin_unlock_bh(&ab_pci->window_lock);
+	} else {
+		iowrite32(value, ab->mem + window_start +
+			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	}
 }
 
 static u32 ath11k_pci_window_read32(struct ath11k_base *ab, u32 offset)
@@ -85,11 +112,21 @@ static u32 ath11k_pci_window_read32(struct ath11k_base *ab, u32 offset)
 	u32 window_start = ATH11K_PCI_WINDOW_START;
 	u32 val;
 
-	spin_lock_bh(&ab_pci->window_lock);
-	ath11k_pci_select_window(ab_pci, offset);
-	val = ioread32(ab->mem + window_start +
-		       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-	spin_unlock_bh(&ab_pci->window_lock);
+	if (ab->hw_params.static_window_map)
+		window_start = ath11k_pci_get_window_start(ab, offset);
+	else
+		window_start = ATH11K_PCI_WINDOW_START;
+
+	if (window_start == ATH11K_PCI_WINDOW_START) {
+		spin_lock_bh(&ab_pci->window_lock);
+		ath11k_pci_select_window(ab_pci, offset);
+		val = ioread32(ab->mem + window_start +
+			       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		spin_unlock_bh(&ab_pci->window_lock);
+	} else {
+		val = ioread32(ab->mem + window_start +
+			       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	}
 
 	return val;
 }
@@ -110,6 +147,8 @@ static const struct ath11k_pci_ops ath11k_pci_ops_qca6390 = {
 };
 
 static const struct ath11k_pci_ops ath11k_pci_ops_qcn9074 = {
+	.wakeup = NULL,
+	.release = NULL,
 	.get_msi_irq = ath11k_pci_get_msi_irq,
 	.window_write32 = ath11k_pci_window_write32,
 	.window_read32 = ath11k_pci_window_read32,
@@ -697,6 +736,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
 	u32 soc_hw_version_major, soc_hw_version_minor, addr;
+	const struct ath11k_pci_ops *pci_ops;
 	int ret;
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
@@ -754,10 +794,10 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			goto err_pci_free_region;
 		}
 
-		ab->pci.ops = &ath11k_pci_ops_qca6390;
+		pci_ops = &ath11k_pci_ops_qca6390;
 		break;
 	case QCN9074_DEVICE_ID:
-		ab->pci.ops = &ath11k_pci_ops_qcn9074;
+		pci_ops = &ath11k_pci_ops_qcn9074;
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
 	case WCN6855_DEVICE_ID:
@@ -787,7 +827,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			goto err_pci_free_region;
 		}
 
-		ab->pci.ops = &ath11k_pci_ops_qca6390;
+		pci_ops = &ath11k_pci_ops_qca6390;
 		break;
 	default:
 		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
@@ -796,6 +836,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_pci_free_region;
 	}
 
+	ret = ath11k_pcic_register_pci_ops(ab, pci_ops);
+	if (ret) {
+		ath11k_err(ab, "failed to register PCI ops: %d\n", ret);
+		goto err_pci_free_region;
+	}
+
 	ret = ath11k_pcic_init_msi_config(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init msi config: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index cf12b98c480d..1adf20ebef27 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -140,23 +140,8 @@ int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
 
-static inline u32 ath11k_pcic_get_window_start(struct ath11k_base *ab,
-					       u32 offset)
-{
-	u32 window_start = 0;
-
-	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = ab->hw_params.dp_window_idx * ATH11K_PCI_WINDOW_START;
-	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
-		 ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = ab->hw_params.ce_window_idx * ATH11K_PCI_WINDOW_START;
-
-	return window_start;
-}
-
 void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
-	u32 window_start;
 	int ret = 0;
 
 	/* for offset beyond BAR + 4K - 32, may
@@ -166,15 +151,10 @@ void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->wakeup)
 		ret = ab->pci.ops->wakeup(ab);
 
-	if (offset < ATH11K_PCI_WINDOW_START) {
+	if (offset < ATH11K_PCI_WINDOW_START)
 		iowrite32(value, ab->mem  + offset);
-	} else if (ab->hw_params.static_window_map) {
-		window_start = ath11k_pcic_get_window_start(ab, offset);
-		iowrite32(value, ab->mem + window_start +
-			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-	} else if (ab->pci.ops->window_write32) {
+	else
 		ab->pci.ops->window_write32(ab, offset, value);
-	}
 
 	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
 	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->release &&
@@ -185,9 +165,8 @@ EXPORT_SYMBOL(ath11k_pcic_write32);
 
 u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 {
-	u32 val = 0;
-	u32 window_start;
 	int ret = 0;
+	u32 val;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup the device to access.
@@ -196,15 +175,10 @@ u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->wakeup)
 		ret = ab->pci.ops->wakeup(ab);
 
-	if (offset < ATH11K_PCI_WINDOW_START) {
+	if (offset < ATH11K_PCI_WINDOW_START)
 		val = ioread32(ab->mem + offset);
-	} else if (ab->hw_params.static_window_map) {
-		window_start = ath11k_pcic_get_window_start(ab, offset);
-		val = ioread32(ab->mem + window_start +
-			       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-	} else if (ab->pci.ops->window_read32) {
+	else
 		val = ab->pci.ops->window_read32(ab, offset);
-	}
 
 	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
 	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->release &&
@@ -516,11 +490,6 @@ static irqreturn_t ath11k_pcic_ext_interrupt_handler(int irq, void *arg)
 static int
 ath11k_pcic_get_msi_irq(struct ath11k_base *ab, unsigned int vector)
 {
-	if (!ab->pci.ops->get_msi_irq) {
-		WARN_ONCE(1, "get_msi_irq pci op not defined");
-		return -EOPNOTSUPP;
-	}
-
 	return ab->pci.ops->get_msi_irq(ab, vector);
 }
 
@@ -746,3 +715,19 @@ int ath11k_pcic_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 	return 0;
 }
 EXPORT_SYMBOL(ath11k_pcic_map_service_to_pipe);
+
+int ath11k_pcic_register_pci_ops(struct ath11k_base *ab,
+				 const struct ath11k_pci_ops *pci_ops)
+{
+	if (!pci_ops)
+		return 0;
+
+	/* Return error if mandatory pci_ops callbacks are missing */
+	if (!pci_ops->get_msi_irq || !pci_ops->window_write32 ||
+	    !pci_ops->window_read32)
+		return -EINVAL;
+
+	ab->pci.ops = pci_ops;
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_pcic_register_pci_ops);
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
index c53d86289a8e..0afbb34510db 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.h
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -43,4 +43,6 @@ int ath11k_pcic_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 void ath11k_pcic_ce_irqs_enable(struct ath11k_base *ab);
 void ath11k_pcic_ce_irq_disable_sync(struct ath11k_base *ab);
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab);
+int ath11k_pcic_register_pci_ops(struct ath11k_base *ab,
+				 const struct ath11k_pci_ops *pci_ops);
 #endif
-- 
2.35.1

