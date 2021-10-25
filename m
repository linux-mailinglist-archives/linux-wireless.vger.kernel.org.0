Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB9439A8F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhJYPdX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 11:33:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21289 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhJYPdX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 11:33:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635175861; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LVbvOgg2ZpPLgw5wF/6LIkMEKjqi3ZjkN9OPHruhDo8=; b=MZkB5QSvZgXoDJV7RHajTJ95Jh6y0V0ePezSKtTavUPJKRYyNcxYmJ9yWXo3LWzUHrdFYQZt
 PO9r0sccd8aUU1VlDaO+kpl2fzG45gLC4A4lCY6SNGMKz60rOCtfcfKeZ2ZkvN5zDlWZyqx8
 k+DI/TkWtUuFj0/RpGFCYZxzXLA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6176ccf5b03398c06c79dc18 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 15:27:49
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2FC63C4360D; Mon, 25 Oct 2021 15:27:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F053C4360C;
        Mon, 25 Oct 2021 15:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1F053C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Mon, 25 Oct 2021 20:57:28 +0530
Message-Id: <1635175648-23491-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635175648-23491-1-git-send-email-akolli@codeaurora.org>
References: <1635175648-23491-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host DDR memory (contiguous 45 MB in mode-0 or 15 MB in mode-2)
is reserved through DT entries for firmware usage. Send the base
address from DT entries.
If DT entry is available, PCI device will work with
fixed_mem_region else host allocates multiple segments.

IPQ8074 on HK10 board supports multiple PCI devices.
IPQ8074 + QCN9074 is tested with this patch.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 14 ++++++++++++--
 drivers/net/wireless/ath/ath11k/pci.c | 10 +++++++++-
 drivers/net/wireless/ath/ath11k/qmi.c | 36 ++++++++++++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/qmi.h |  1 +
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 26c7ae242db6..c4d03e859746 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -3,6 +3,7 @@
 
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/of.h>
 
 #include "core.h"
 #include "debug.h"
@@ -317,6 +318,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	struct mhi_controller *mhi_ctrl;
 	struct mhi_controller_config *ath11k_mhi_config;
 	int ret;
+	u32 addr;
 
 	mhi_ctrl = mhi_alloc_controller();
 	if (!mhi_ctrl)
@@ -339,8 +341,16 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		return ret;
 	}
 
-	mhi_ctrl->iova_start = 0;
-	mhi_ctrl->iova_stop = 0xffffffff;
+	if (!of_property_read_u32(ab->dev->of_node, "qcom,start-addr", &addr))
+		mhi_ctrl->iova_start = addr;
+	else
+		mhi_ctrl->iova_start = 0;
+
+	if (!of_property_read_u32(ab->dev->of_node, "qcom,end-addr", &addr))
+		mhi_ctrl->iova_stop = addr;
+	else
+		mhi_ctrl->iova_stop = 0xffffffff;
+
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 3d353e7c9d5c..44080883007f 100644
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
+	if (!of_property_read_u32(ab->dev->of_node, "qcom,base-addr", &addr))
+		ab->bus_params.fixed_mem_region = true;
+
 	ret = ath11k_pci_claim(ab_pci, pdev);
 	if (ret) {
 		ath11k_err(ab, "failed to claim device: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index fa73118de6db..ecabdc6ad2dc 100644
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
 
@@ -1866,10 +1867,25 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 
 static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 {
+	struct device *dev = ab->dev;
+	u32 addr = 0;
 	int i, idx;
 
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		switch (ab->qmi.target_mem[i].type) {
+		case HOST_DDR_REGION_TYPE:
+			if (of_property_read_u32(dev->of_node, "qcom,base-addr", &addr)) {
+				ath11k_warn(ab, "qmi fail to get base-addr from dt\n");
+				return -ENOENT;
+			}
+			ab->qmi.target_mem[idx].paddr = addr;
+			ab->qmi.target_mem[idx].iaddr =
+				ioremap(ab->qmi.target_mem[idx].paddr,
+					ab->qmi.target_mem[i].size);
+			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
+			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			idx++;
+			break;
 		case BDF_MEM_REGION_TYPE:
 			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
 			ab->qmi.target_mem[idx].vaddr = NULL;
@@ -1884,10 +1900,16 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			if (ath11k_cold_boot_cal && ab->hw_params.cold_boot_calib) {
-				ab->qmi.target_mem[idx].paddr =
-						     ATH11K_QMI_CALDB_ADDRESS;
-				ab->qmi.target_mem[idx].vaddr =
-						     (void *)ATH11K_QMI_CALDB_ADDRESS;
+				if (!of_property_read_u32(dev->of_node,
+							  "qcom,caldb-addr", &addr)) {
+					ab->qmi.target_mem[idx].paddr = addr;
+					ab->qmi.target_mem[idx].iaddr =
+						ioremap(ab->qmi.target_mem[idx].paddr,
+						ab->qmi.target_mem[i].size);
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

