Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433D044E231
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 08:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhKLHGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 02:06:32 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:17955 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhKLHGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 02:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636700621; x=1668236621;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6qOXSouFaC7mrf88qXzMzO0O38OmCXbXupu8Dr8wp6w=;
  b=tFGvuwPt0BrF9AHLAViHT3b6JwV4zr+476O7l/thA1x58ZJABq0bbiSH
   VhtBmStBf+VucuPQYw0tkvKarMrw79XLEkP62XdVv9yXZZmA/SGn7GUAa
   e5GwIIkKI06Xe4DPh554WBecw6ScXmk9MJQCU8xoLiErXPYjnnSEjdS9k
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Nov 2021 23:03:40 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 23:03:40 -0800
Received: from seevalam-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 11 Nov 2021 23:03:37 -0800
From:   Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: [PATCH] ath11k: Check supported hardware version
Date:   Fri, 12 Nov 2021 12:33:17 +0530
Message-ID: <1636700597-11113-1-git-send-email-quic_seevalam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read register TCSR_SOC_HW_VERSION for hardware version. This register
is present in all hardwares. Check whether the hardware version is
supported. Returns error if the hardware is unsupported.
This handling is already done for QCA6390 and WCN6855.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3
Tested-on: IPQ6018 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3

Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 46 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h | 13 ++++++++++
 drivers/net/wireless/ath/ath11k/pci.c  | 32 ++++++++++++++++-------
 3 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 8c9c781..be56787 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -13,6 +13,10 @@
 #include "hif.h"
 #include <linux/remoteproc.h>
 
+#define CORE_TOP_CSR_OFFSET		0x01900000
+#define CORE_TOP_CSR_SIZE		0x100000
+#define TCSR_SOC_HW_VERSION		0x4D000
+
 static const struct of_device_id ath11k_ahb_of_match[] = {
 	/* TODO: Should we change the compatible string to something similar
 	 * to one that ath10k uses?
@@ -650,6 +654,44 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_check_hw_version(struct ath11k_base *ab)
+{
+	void __iomem *mem_core;
+	u32 soc_hw_version, soc_hw_version_major, soc_hw_version_minor;
+
+	switch (ab->hw_rev) {
+	case ATH11K_HW_IPQ8074:
+	case ATH11K_HW_IPQ6018_HW10:
+		/* CORE_TOP_CSR register is out of wcss */
+		mem_core = ioremap(CORE_TOP_CSR_OFFSET, CORE_TOP_CSR_SIZE);
+		if (IS_ERR(mem_core)) {
+			ath11k_err(ab, "core_top_csr ioremap error\n");
+			return -ENOMEM;
+		}
+		soc_hw_version = ioread32(mem_core + TCSR_SOC_HW_VERSION);
+		iounmap(mem_core);
+		soc_hw_version_major = FIELD_GET(TCSR_SOC_HW_VERSION_MAJOR_MASK,
+						 soc_hw_version);
+		soc_hw_version_minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
+						 soc_hw_version);
+
+		ath11k_dbg(ab, ATH11K_DBG_AHB, "tcsr_soc_hw_version major %u minor %u\n",
+			   soc_hw_version_major,
+			   soc_hw_version_minor);
+
+		if (soc_hw_version_major != ath11k_hw_version[ab->hw_rev]) {
+			ath11k_err(ab, "Unsupported SOC hardware version: %u\n",
+				   soc_hw_version_major);
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		ath11k_err(ab, "Unknown hw_ver: %u\n", ab->hw_rev);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 static int ath11k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath11k_base *ab;
@@ -691,6 +733,10 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	ab->mem_len = resource_size(mem_res);
 	platform_set_drvdata(pdev, ab);
 
+	ret = ath11k_check_hw_version(ab);
+	if (ret)
+		goto err_core_free;
+
 	ret = ath11k_core_pre_init(ab);
 	if (ret)
 		goto err_core_free;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 2f1e10b..3b93a5d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -916,6 +916,19 @@ struct ath11k_fw_stats_bcn {
 	u32 tx_bcn_outage_cnt;
 };
 
+#define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(15, 8)
+#define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 0)
+#define ATH11K_HW_VERSION_HW10		1
+#define ATH11K_HW_VERSION_HW20		2
+
+static const u32 ath11k_hw_version[] = {
+	[ATH11K_HW_IPQ8074] = ATH11K_HW_VERSION_HW20,
+	[ATH11K_HW_QCA6390_HW20] = ATH11K_HW_VERSION_HW20,
+	[ATH11K_HW_IPQ6018_HW10] = ATH11K_HW_VERSION_HW10,
+	[ATH11K_HW_QCN9074_HW10] = ATH11K_HW_VERSION_HW10,
+	[ATH11K_HW_WCN6855_HW20] = ATH11K_HW_VERSION_HW20,
+};
+
 extern const struct ce_pipe_config ath11k_target_ce_config_wlan_ipq8074[];
 extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq8074[];
 extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq6018[];
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 3d353e7..fb001b7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -25,8 +25,7 @@
 #define WINDOW_RANGE_MASK		GENMASK(18, 0)
 
 #define TCSR_SOC_HW_VERSION		0x0224
-#define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(16, 8)
-#define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 0)
+#define QCN9074_TCSR_SOC_HW_VERSION	0x1B00000
 
 /* BAR0 + 4k is always accessible, and no
  * need to force wakeup.
@@ -1206,11 +1205,12 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.get_ce_msi_idx = ath11k_pci_get_ce_msi_idx,
 };
 
-static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
+static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 offset,
+				       u32 *major, u32 *minor)
 {
 	u32 soc_hw_version;
 
-	soc_hw_version = ath11k_pci_read32(ab, TCSR_SOC_HW_VERSION);
+	soc_hw_version = ath11k_pci_read32(ab, offset);
 	*major = FIELD_GET(TCSR_SOC_HW_VERSION_MAJOR_MASK,
 			   soc_hw_version);
 	*minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
@@ -1253,10 +1253,11 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 
 	switch (pci_dev->device) {
 	case QCA6390_DEVICE_ID:
-		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
+		ath11k_pci_read_hw_version(ab, TCSR_SOC_HW_VERSION,
+					   &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
-		case 2:
+		case ATH11K_HW_VERSION_HW20:
 			ab->hw_rev = ATH11K_HW_QCA6390_HW20;
 			break;
 		default:
@@ -1268,15 +1269,28 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath11k_msi_config[0];
 		break;
 	case QCN9074_DEVICE_ID:
+		ath11k_pci_read_hw_version(ab, QCN9074_TCSR_SOC_HW_VERSION,
+					   &soc_hw_version_major,
+					   &soc_hw_version_minor);
+		switch (soc_hw_version_major) {
+		case ATH11K_HW_VERSION_HW10:
+			ab->hw_rev = ATH11K_HW_QCN9074_HW10;
+			break;
+		default:
+			dev_err(&pdev->dev, "Unsupported QCN9074 SOC hardware version: %d %d\n",
+				soc_hw_version_major, soc_hw_version_minor);
+			ret = -EOPNOTSUPP;
+			goto err_pci_free_region;
+		}
 		ab_pci->msi_config = &ath11k_msi_config[1];
 		ab->bus_params.static_window_map = true;
-		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
 	case WCN6855_DEVICE_ID:
-		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
+		ath11k_pci_read_hw_version(ab, TCSR_SOC_HW_VERSION,
+					   &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
-		case 2:
+		case ATH11K_HW_VERSION_HW20:
 			ab->hw_rev = ATH11K_HW_WCN6855_HW20;
 			break;
 		default:
-- 
2.7.4

