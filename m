Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38348FCE8
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiAPMr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:47:57 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:9935 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235093AbiAPMrw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642337272; x=1673873272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rUfILe3vUM45RhuRlnYcd+1tvAi7Ntujv+KTzBJw1zo=;
  b=kt4jCxTvFZWnVeO7kdO750JI/FSw4fUtg49tzc0bS89AGUV8i4DrzjkB
   Qtm/kOXXR+F6TzokFF/Tb5uiEyfLVnBJ/k0ZAfEloFAjYsspwae1DjK9P
   ReINJBbSYsOzcwVu2blXGzM9DDNfyEjQ5NTFOr6+/PYFQCit+nIH2coDE
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jan 2022 04:47:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 04:47:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:51 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:48 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 08/19] ath11k: Add register access logic for WCN6750
Date:   Sun, 16 Jan 2022 18:17:04 +0530
Message-ID: <1642337235-8618-9-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN6750 uses static window mapping to access the HW registers.
Unlike QCN9074 which uses 2nd window for CE and 3rd window
for UMAC register accesses, WCN6750 uses 1st window for UMAC
and 2nd window for CE registers.

Code is refactored so that WCN6750 can use the existing
ath11k_pci_read/write() APIs for accessing the registers.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c     |  3 +++
 drivers/net/wireless/ath/ath11k/core.h    |  2 ++
 drivers/net/wireless/ath/ath11k/pci.c     |  4 ++++
 drivers/net/wireless/ath/ath11k/pci_cmn.c | 35 ++++++++++---------------------
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 6167d4f..ed3a439 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -42,6 +42,9 @@ const struct ath11k_bus_params ath11k_hybrid_bus_params = {
 	.fixed_bdf_addr = false,
 	.fixed_mem_region = false,
 	.hybrid_bus_type = true,
+	.static_window_map = true,
+	.dp_window_idx = 1,
+	.ce_window_idx = 2,
 };
 
 #define ATH11K_IRQ_CE0_OFFSET 4
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index c6cd2de..92c1ea1 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -655,6 +655,8 @@ struct ath11k_bus_params {
 	bool fixed_mem_region;
 	bool static_window_map;
 	bool hybrid_bus_type;
+	u8 dp_window_idx;
+	u8 ce_window_idx;
 	struct {
 		void (*wakeup)(struct ath11k_base *ab);
 		void (*release)(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 4f2fe72..07bfb86 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -765,6 +765,10 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ab->bus_params.ops.wakeup = NULL;
 		ab->bus_params.ops.release = NULL;
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
+
+		/* For QCN9074, CE: 2nd window, UMAC: 3rd window */
+		ab->bus_params.ce_window_idx = 2;
+		ab->bus_params.dp_window_idx = 3;
 		break;
 	case WCN6855_DEVICE_ID:
 		ab->id.bdf_search = ATH11K_BDF_SEARCH_BUS_AND_BOARD;
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.c b/drivers/net/wireless/ath/ath11k/pci_cmn.c
index a5b84b5..fede1d06d 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.c
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
@@ -122,16 +122,13 @@ int ath11k_pci_get_msi_config(struct ath11k_base *ab)
 static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
 					      u32 offset)
 {
-	u32 window_start;
+	u32 window_start = 0;
 
-	/* If offset lies within DP register range, use 3rd window */
 	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = 3 * ATH11K_PCI_WINDOW_START;
-	/* If offset lies within CE register range, use 2nd window */
-	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = 2 * ATH11K_PCI_WINDOW_START;
-	else
-		window_start = ATH11K_PCI_WINDOW_START;
+		window_start = ab->bus_params.dp_window_idx * ATH11K_PCI_WINDOW_START;
+	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
+		 ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = ab->bus_params.ce_window_idx * ATH11K_PCI_WINDOW_START;
 
 	return window_start;
 }
@@ -151,17 +148,12 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
 	} else {
-		if (ab->bus_params.static_window_map)
+		if (ab->bus_params.static_window_map) {
 			window_start = ath11k_pci_get_window_start(ab, offset);
-		else
-			window_start = ATH11K_PCI_WINDOW_START;
-
-		if (window_start == ATH11K_PCI_WINDOW_START &&
-		    ab->bus_params.ops.window_write32) {
-			ab->bus_params.ops.window_write32(ab, offset, value);
-		} else {
 			iowrite32(value, ab->mem + window_start +
 				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		} else if (ab->bus_params.ops.window_write32) {
+			ab->bus_params.ops.window_write32(ab, offset, value);
 		}
 	}
 
@@ -186,17 +178,12 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		val = ioread32(ab->mem + offset);
 	} else {
-		if (ab->bus_params.static_window_map)
+		if (ab->bus_params.static_window_map) {
 			window_start = ath11k_pci_get_window_start(ab, offset);
-		else
-			window_start = ATH11K_PCI_WINDOW_START;
-
-		if (window_start == ATH11K_PCI_WINDOW_START &&
-		    ab->bus_params.ops.window_read32) {
-			val = ab->bus_params.ops.window_read32(ab, offset);
-		} else {
 			val = ioread32(ab->mem + window_start +
 				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		} else if (ab->bus_params.ops.window_read32) {
+			val = ab->bus_params.ops.window_read32(ab, offset);
 		}
 	}
 
-- 
2.7.4

