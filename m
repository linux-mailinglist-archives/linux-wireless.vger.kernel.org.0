Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92935515153
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379417AbiD2RJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379410AbiD2RJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:09:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5928167F;
        Fri, 29 Apr 2022 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651251969; x=1682787969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/ROsx4+MeSBltXz89s2h6jVomlQ7IJET5yIUcpUNBQ=;
  b=tPPLChbq5b2B+dShUnKmiR7XaGL6YSVuknctuj+Cq+kPqpLe1KliWsoB
   t3Pj44D9FM3a1PdQGtQdlqb50V3Yr3LzSkNP8vRNaunXaCELI23zHQbMT
   VOM0gVehIH29h8E9css3BhHTDOf3cB/B+g90xhHFfnOGYeAtI60y7ASG5
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Apr 2022 10:06:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:06:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:38 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:35 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v7 4/9] ath11k: Add register access logic for WCN6750
Date:   Fri, 29 Apr 2022 22:34:57 +0530
Message-ID: <20220429170502.20080-5-quic_mpubbise@quicinc.com>
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

WCN6750 uses static window mapping to access the HW registers.
Unlike QCN9074 which uses 3rd window for UMAC and 2nd window
for CE register access, WCN6750 uses 1st window for UMAC
and 2nd window for CE registers.

Also, refactor the code so that WCN6750 can use the existing
ath11k_pci_read32/write32() APIs for accessing the registers.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 15 +++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  2 +
 drivers/net/wireless/ath/ath11k/pcic.c | 54 +++++++++-----------------
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index dc1084532cef..3be4327b4d9c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -107,6 +107,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = true,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
+		.dp_window_idx = 0,
+		.ce_window_idx = 0,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -179,6 +181,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = true,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
+		.dp_window_idx = 0,
+		.ce_window_idx = 0,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -250,6 +254,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
+		.dp_window_idx = 0,
+		.ce_window_idx = 0,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -321,6 +327,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = true,
 		.hybrid_bus_type = false,
+		.dp_window_idx = 3,
+		.ce_window_idx = 2,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -392,6 +400,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
+		.dp_window_idx = 0,
+		.ce_window_idx = 0,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -462,6 +472,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_mem_region = false,
 		.static_window_map = false,
 		.hybrid_bus_type = false,
+		.dp_window_idx = 0,
+		.ce_window_idx = 0,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -527,7 +539,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.m3_fw_support = false,
 		.fixed_bdf_addr = false,
 		.fixed_mem_region = false,
+		.static_window_map = true,
 		.hybrid_bus_type = true,
+		.dp_window_idx = 1,
+		.ce_window_idx = 2,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 03eb5dfd4a5e..b63538084215 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -201,6 +201,8 @@ struct ath11k_hw_params {
 	bool fixed_mem_region;
 	bool static_window_map;
 	bool hybrid_bus_type;
+	u8 dp_window_idx;
+	u8 ce_window_idx;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 7a920d65023f..46cf96d3e1d2 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -134,16 +134,13 @@ EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
 static inline u32 ath11k_pcic_get_window_start(struct ath11k_base *ab,
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
+		window_start = ab->hw_params.dp_window_idx * ATH11K_PCI_WINDOW_START;
+	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
+		 ATH11K_PCI_WINDOW_RANGE_MASK)
+		window_start = ab->hw_params.ce_window_idx * ATH11K_PCI_WINDOW_START;
 
 	return window_start;
 }
@@ -162,19 +159,12 @@ void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
-	} else {
-		if (ab->hw_params.static_window_map)
-			window_start = ath11k_pcic_get_window_start(ab, offset);
-		else
-			window_start = ATH11K_PCI_WINDOW_START;
-
-		if (window_start == ATH11K_PCI_WINDOW_START &&
-		    ab->pci.ops->window_write32) {
-			ab->pci.ops->window_write32(ab, offset, value);
-		} else {
-			iowrite32(value, ab->mem + window_start +
-				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-		}
+	} else if (ab->hw_params.static_window_map) {
+		window_start = ath11k_pcic_get_window_start(ab, offset);
+		iowrite32(value, ab->mem + window_start +
+			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	} else if (ab->pci.ops->window_write32) {
+		ab->pci.ops->window_write32(ab, offset, value);
 	}
 
 	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
@@ -185,7 +175,8 @@ void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 
 u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 {
-	u32 val, window_start;
+	u32 val = 0;
+	u32 window_start;
 	int ret = 0;
 
 	/* for offset beyond BAR + 4K - 32, may
@@ -197,19 +188,12 @@ u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		val = ioread32(ab->mem + offset);
-	} else {
-		if (ab->hw_params.static_window_map)
-			window_start = ath11k_pcic_get_window_start(ab, offset);
-		else
-			window_start = ATH11K_PCI_WINDOW_START;
-
-		if (window_start == ATH11K_PCI_WINDOW_START &&
-		    ab->pci.ops->window_read32) {
-			val = ab->pci.ops->window_read32(ab, offset);
-		} else {
-			val = ioread32(ab->mem + window_start +
-				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
-		}
+	} else if (ab->hw_params.static_window_map) {
+		window_start = ath11k_pcic_get_window_start(ab, offset);
+		val = ioread32(ab->mem + window_start +
+			       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	} else if (ab->pci.ops->window_read32) {
+		val = ab->pci.ops->window_read32(ab, offset);
 	}
 
 	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
-- 
2.35.1

