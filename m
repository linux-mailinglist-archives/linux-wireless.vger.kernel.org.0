Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27AE4694D9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 12:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbhLFLTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 06:19:10 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:47707 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242243AbhLFLTJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 06:19:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638789340; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=q7uCSHF218rkMbu+VPHBuPtWxRa1uNY08sDk4YN8Cmw=; b=UGFSdtbCoSmlm/tVQ3yYIGXCN2Memn0lFTOExmjHOFbhBW11N5Rsb/u5LDlKS5gYtzTD5wUi
 II5e5oN9O7o65TsW/Ps6HyVgTWgpWLcthJNpg0ovXqqG93s81Wfkg8eGlAIKlZ7sC2Fz57EG
 X6VFxelcANOXm7ZAhcjM2xZCeio=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61adf0dc135a8a9d0e5f9bf0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 06 Dec 2021 11:15:40
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BE27C43619; Mon,  6 Dec 2021 11:15:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C17FBC4338F;
        Mon,  6 Dec 2021 11:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C17FBC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v7 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Mon,  6 Dec 2021 16:45:19 +0530
Message-Id: <1638789319-2950-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
References: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
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
V7:
  - Rebase on latest ath.git (Kalle)
V6:
  - Use of_parse_phandle() (Sven)
V5:
  - Use of_address_to_resource() (Sven)
V4:
  - Update code review comments to handle return (Kalle)
V3:
  - remove type cast and use of_property_read_u32_array() (Kalle)
V2:
  - Use of_ API to read from dt node (Rob)


 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  | 34 ++++++++++++++++-
 drivers/net/wireless/ath/ath11k/pci.c  | 11 +++++-
 drivers/net/wireless/ath/ath11k/qmi.c  | 67 +++++++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/qmi.h  |  1 +
 5 files changed, 101 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0103cfd0508d..e8157db337c7 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -201,6 +201,7 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_HTC_SUSPEND_COMPLETE,
 	ATH11K_FLAG_CE_IRQ_ENABLED,
 	ATH11K_FLAG_EXT_IRQ_ENABLED,
+	ATH11K_FLAG_FIXED_MEM_RGN,
 };
 
 enum ath11k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index d0f94a785a59..5f2789c40125 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -3,6 +3,9 @@
 
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/ioport.h>
 
 #include "core.h"
 #include "debug.h"
@@ -318,6 +321,26 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
 	writel(val, addr);
 }
 
+static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
+{
+	struct device_node *np;
+	struct resource res;
+	int ret;
+
+	np = of_find_node_by_type(NULL, "memory");
+	if (!np)
+		return -ENOENT;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+
+	mhi_ctrl->iova_start = res.start + 0x1000000;
+	mhi_ctrl->iova_stop = res.end;
+
+	return 0;
+}
+
 int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
@@ -349,8 +372,15 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
 		mhi_ctrl->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
 
-	mhi_ctrl->iova_start = 0;
-	mhi_ctrl->iova_stop = 0xffffffff;
+	if ((test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags))) {
+		ret = ath11k_mhi_read_addr_from_dt(mhi_ctrl);
+		if (ret < 0)
+			return ret;
+	} else {
+		mhi_ctrl->iova_start = 0;
+		mhi_ctrl->iova_stop = 0xFFFFFFFF;
+	}
+
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 1898b1a33960..83ee14623468 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/of.h>
 
 #include "pci.h"
 #include "core.h"
@@ -1347,7 +1348,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 {
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
-	u32 soc_hw_version_major, soc_hw_version_minor;
+	u32 soc_hw_version_major, soc_hw_version_minor, addr;
 	int ret;
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI,
@@ -1367,6 +1368,14 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, ab);
 	spin_lock_init(&ab_pci->window_lock);
 
+	/* Set fixed_mem_region to true for platforms support reserved memory
+	 * from DT. If memory is reserved from DT for FW, ath11k driver need not
+	 * allocate memory.
+	 */
+	ret = of_property_read_u32(ab->dev->of_node, "memory-region", &addr);
+	if (!ret)
+		set_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags);
+
 	ret = ath11k_pci_claim(ab_pci, pdev);
 	if (ret) {
 		ath11k_err(ab, "failed to claim device: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 25eb22cbeaeb..625d525a86b9 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -9,6 +9,8 @@
 #include "core.h"
 #include "debug.h"
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/ioport.h>
 #include <linux/firmware.h>
 
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
@@ -1751,7 +1753,9 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	 * failure to FW and FW will then request mulitple blocks of small
 	 * chunk size memory.
 	 */
-	if (!ab->bus_params.fixed_mem_region && ab->qmi.target_mem_delayed) {
+	if (!(ab->bus_params.fixed_mem_region ||
+	      test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
+	      ab->qmi.target_mem_delayed) {
 		delayed = true;
 		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi delays mem_request %d\n",
 			   ab->qmi.mem_seg_count);
@@ -1818,10 +1822,12 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
 {
 	int i;
 
-	if (ab->bus_params.fixed_mem_region)
-		return;
-
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+		if ((ab->bus_params.fixed_mem_region ||
+		     test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
+		     ab->qmi.target_mem[i].iaddr)
+			iounmap(ab->qmi.target_mem[i].iaddr);
+
 		if (!ab->qmi.target_mem[i].vaddr)
 			continue;
 
@@ -1869,10 +1875,44 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 
 static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 {
-	int i, idx;
+	struct device *dev = ab->dev;
+	struct device_node *hremote_node = NULL;
+	struct resource res;
+	u32 host_ddr_sz;
+	int i, idx, ret;
 
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		switch (ab->qmi.target_mem[i].type) {
+		case HOST_DDR_REGION_TYPE:
+			hremote_node = of_parse_phandle(dev->of_node, "memory-region", 0);
+			if (!hremote_node) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "qmi fail to get hremote_node\n");
+				return ret;
+			}
+
+			ret = of_address_to_resource(hremote_node, 0, &res);
+			if (ret) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "qmi fail to get reg from hremote\n");
+				return ret;
+			}
+
+			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "qmi fail to assign memory of sz\n");
+				return -EINVAL;
+			}
+
+			ab->qmi.target_mem[idx].paddr = res.start;
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
@@ -1887,10 +1927,16 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			if (ath11k_cold_boot_cal && ab->hw_params.cold_boot_calib) {
-				ab->qmi.target_mem[idx].paddr =
-						     ATH11K_QMI_CALDB_ADDRESS;
-				ab->qmi.target_mem[idx].vaddr =
-						     (void *)ATH11K_QMI_CALDB_ADDRESS;
+				if (hremote_node) {
+					ab->qmi.target_mem[idx].paddr =
+							res.start + host_ddr_sz;
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
@@ -2621,7 +2667,8 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 			   msg->mem_seg[i].type, msg->mem_seg[i].size);
 	}
 
-	if (ab->bus_params.fixed_mem_region) {
+	if (ab->bus_params.fixed_mem_region ||
+	    test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) {
 		ret = ath11k_qmi_assign_target_mem_chunk(ab);
 		if (ret) {
 			ath11k_warn(ab, "failed to assign qmi target memory: %d\n",
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

