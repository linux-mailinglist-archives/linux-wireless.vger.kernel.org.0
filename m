Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7945D925
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhKYLZk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 06:25:40 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:62639 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233973AbhKYLXj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 06:23:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637839228; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=f7YH3pss2zXEKtFG6ODSc1b/BfXie7bujS1KAKpQhKg=; b=nw2usyM/yxx/cIivmXNRpnpSX8l5mPrmIePd6EZ95tkF9yNOuuspaolcDMcx4N/Yfr4M/Y1R
 n02c3BE5W5/Y6BEiwaiHzjwJFJJE6UDhQ7K9mZEqm720hpJ5Wo0ajVa4pzXCiQvfoW3+1fLJ
 RMGNk6fm5fcXWpit70Dya5LZVpA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 619f717cbebfa3d4d5617e21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Nov 2021 11:20:28
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 351DCC4338F; Thu, 25 Nov 2021 11:20:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39217C4360D;
        Thu, 25 Nov 2021 11:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 39217C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v6 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Thu, 25 Nov 2021 16:50:11 +0530
Message-Id: <1637839211-1503-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637839211-1503-1-git-send-email-akolli@codeaurora.org>
References: <1637839211-1503-1-git-send-email-akolli@codeaurora.org>
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
index 2f1e10b7cc17..8492ca7efb92 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -194,6 +194,7 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_REGISTERED,
 	ATH11K_FLAG_QMI_FAIL,
 	ATH11K_FLAG_HTC_SUSPEND_COMPLETE,
+	ATH11K_FLAG_FIXED_MEM_RGN,
 };
 
 enum ath11k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 26c7ae242db6..b6003406e2a1 100644
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
@@ -311,6 +314,26 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
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
@@ -339,8 +362,15 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		return ret;
 	}
 
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
index 3d353e7c9d5c..e12d9753f113 100644
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
@@ -1245,6 +1246,14 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
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
index fa73118de6db..fb3758b87a70 100644
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
@@ -1749,7 +1751,9 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
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
@@ -1815,10 +1819,12 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
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
 
@@ -1866,10 +1872,44 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 
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
@@ -1884,10 +1924,16 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
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
@@ -2614,7 +2660,8 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
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

