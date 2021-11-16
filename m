Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E84453835
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 18:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhKPREM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 12:04:12 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:18858 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKPREM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 12:04:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637082074; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MrK9j2QZk1ZGDNZgY2wAkzH6DM7jjJ1uP/Qbz7v7jE0=; b=SNAtUK+Lr6Dmlbx2mBpdWMUn//t/qOrFm/dwL/N3sA8dg7oTHbJir/ZSQXeAAPtr3KtOD0it
 XoWNhFzhBEu5JEwX/o6G+setvosnZZdBztMyICvTOW7s6rn+fuY1yWELrOIeYz0y5HevcRkl
 4a8O+v0KWOcbdjBFE0SYjtdGFrI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6193e3d811cd6d4077c4a49d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Nov 2021 17:01:12
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF897C4360C; Tue, 16 Nov 2021 17:01:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EFA8C4360D;
        Tue, 16 Nov 2021 17:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5EFA8C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Tue, 16 Nov 2021 22:30:58 +0530
Message-Id: <1637082058-6398-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637082058-6398-1-git-send-email-akolli@codeaurora.org>
References: <1637082058-6398-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host DDR memory (contiguous 45 MB in mode-0 or 15 MB in mode-2)
is reserved through DT entries for firmware usage. Send the base
address and size from DT entries.

If DT entry is available, PCI devices work with
fixed_mem_region else host allocates multiple segments.

IPQ8074 on HK10 board supports multiple PCI devices.
IPQ8074 + QCN9074 is tested with this patch.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V2:
  - Use of_ API to read from dt node (Rob)

 drivers/net/wireless/ath/ath11k/mhi.c | 42 ++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/pci.c | 10 ++++-
 drivers/net/wireless/ath/ath11k/qmi.c | 75 +++++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/qmi.h |  1 +
 4 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 26c7ae242db6..0ea6ab7edeb9 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -3,6 +3,7 @@
 
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/of.h>
 
 #include "core.h"
 #include "debug.h"
@@ -316,7 +317,11 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	struct ath11k_base *ab = ab_pci->ab;
 	struct mhi_controller *mhi_ctrl;
 	struct mhi_controller_config *ath11k_mhi_config;
-	int ret;
+	struct device_node *np;
+	int ret, len, sw, aw;
+	u32 *reg, *reg_end;
+	unsigned long start, size;
+	bool no_dt_entry = 0;
 
 	mhi_ctrl = mhi_alloc_controller();
 	if (!mhi_ctrl)
@@ -339,8 +344,39 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		return ret;
 	}
 
-	mhi_ctrl->iova_start = 0;
-	mhi_ctrl->iova_stop = 0xffffffff;
+	np = of_find_node_by_type(NULL, "memory");
+	if (!np) {
+		no_dt_entry = 1;
+		goto no_dt_entry;
+	}
+
+	aw = of_n_addr_cells(np);
+	sw = of_n_size_cells(np);
+
+	reg = (unsigned int *)of_get_property(np, "reg", &len);
+	if (!reg) {
+		no_dt_entry = 1;
+		goto no_dt_entry;
+	}
+
+	reg_end = reg + len / (aw * sw);
+
+	do {
+		start = of_read_number(reg, aw);
+		reg += aw;
+		size = of_read_number(reg, sw);
+		reg += sw;
+	} while (reg < reg_end);
+
+no_dt_entry:
+	if (no_dt_entry) {
+		mhi_ctrl->iova_start = 0;
+		mhi_ctrl->iova_stop = 0xFFFFFFFF;
+	} else {
+		mhi_ctrl->iova_start = (dma_addr_t)(start + 0x1000000);
+		mhi_ctrl->iova_stop = (dma_addr_t)(start + size);
+	}
+
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 3d353e7c9d5c..21d0a511d9c7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/of.h>
 
 #include "pci.h"
 #include "core.h"
@@ -1225,7 +1226,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 {
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
-	u32 soc_hw_version_major, soc_hw_version_minor;
+	u32 soc_hw_version_major, soc_hw_version_minor, addr;
 	int ret;
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI,
@@ -1245,6 +1246,13 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, ab);
 	spin_lock_init(&ab_pci->window_lock);
 
+	/* Set fixed_mem_region to true for platforms support reserved memory
+	 * from DT. If memory is reserved from DT for FW, ath11k driver need not
+	 * allocate memory.
+	 */
+	if (!of_property_read_u32(ab->dev->of_node, "memory-region", &addr))
+		ab->bus_params.fixed_mem_region = true;
+
 	ret = ath11k_pci_claim(ab_pci, pdev);
 	if (ret) {
 		ath11k_err(ab, "failed to claim device: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index fa73118de6db..da58ce36b477 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1815,10 +1815,11 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
 {
 	int i;
 
-	if (ab->bus_params.fixed_mem_region)
-		return;
-
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+		if (ab->bus_params.fixed_mem_region &&
+		    ab->qmi.target_mem[i].iaddr)
+			iounmap(ab->qmi.target_mem[i].iaddr);
+
 		if (!ab->qmi.target_mem[i].vaddr)
 			continue;
 
@@ -1866,10 +1867,62 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 
 static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 {
-	int i, idx;
+	struct device *dev = ab->dev;
+	struct device_node *hremote_node = NULL;
+	phandle hremote_phandle;
+	int i, idx, len, sw, aw, host_ddr_sz;
+	u32 *reg, *reg_end;
+	u64 start, size;
 
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		switch (ab->qmi.target_mem[i].type) {
+		case HOST_DDR_REGION_TYPE:
+			if (of_property_read_u32(dev->of_node, "memory-region",
+						 &hremote_phandle)) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "qmi fail to get hremote phandle\n");
+				return 0;
+			}
+
+			hremote_node = of_find_node_by_phandle(hremote_phandle);
+			if (!hremote_node) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "qmi fail to get hremote_node\n");
+				return 0;
+			}
+
+			aw = of_n_addr_cells(hremote_node);
+			sw = of_n_size_cells(hremote_node);
+
+			reg = (unsigned int *)of_get_property(hremote_node, "reg", &len);
+			if (!reg) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "qmi fail to get reg from hremote\n");
+				return 0;
+			}
+
+			reg_end = reg + len / (aw * sw);
+
+			do {
+				start = of_read_number(reg, aw);
+				reg += aw;
+				size = of_read_number(reg, sw);
+				reg += sw;
+			} while (reg < reg_end);
+
+			ath11k_dbg(ab, ATH11K_DBG_QMI,
+				   "qmi ddr start addr is 0x%llx len is %lld\n",
+				   start, size);
+
+			ab->qmi.target_mem[idx].paddr = start;
+			ab->qmi.target_mem[idx].iaddr =
+				ioremap(ab->qmi.target_mem[idx].paddr,
+					ab->qmi.target_mem[i].size);
+			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
+			host_ddr_sz = ab->qmi.target_mem[i].size;
+			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			idx++;
+			break;
 		case BDF_MEM_REGION_TYPE:
 			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
 			ab->qmi.target_mem[idx].vaddr = NULL;
@@ -1884,10 +1937,16 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			if (ath11k_cold_boot_cal && ab->hw_params.cold_boot_calib) {
-				ab->qmi.target_mem[idx].paddr =
-						     ATH11K_QMI_CALDB_ADDRESS;
-				ab->qmi.target_mem[idx].vaddr =
-						     (void *)ATH11K_QMI_CALDB_ADDRESS;
+				if (hremote_node) {
+					ab->qmi.target_mem[idx].paddr =
+							start + host_ddr_sz;
+					ab->qmi.target_mem[idx].iaddr =
+						ioremap(ab->qmi.target_mem[idx].paddr,
+							ab->qmi.target_mem[i].size);
+				} else {
+					ab->qmi.target_mem[idx].paddr =
+						ATH11K_QMI_CALDB_ADDRESS;
+				}
 			} else {
 				ab->qmi.target_mem[idx].paddr = 0;
 				ab->qmi.target_mem[idx].vaddr = NULL;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 3bb0f9ef7996..f8d45b7dc821 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -95,6 +95,7 @@ struct target_mem_chunk {
 	u32 type;
 	dma_addr_t paddr;
 	u32 *vaddr;
+	void __iomem *iaddr;
 };
 
 struct target_info {
-- 
2.7.4

