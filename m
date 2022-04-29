Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7728951514D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379405AbiD2RJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379276AbiD2RJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:09:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A781651;
        Fri, 29 Apr 2022 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651251966; x=1682787966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4n02wHYUxGcANRVztd0neByrD+Q+U0/OQWwLncp/6t4=;
  b=Q/I/STQt9zdQkxciRYUply1GGZ+1fWX7FSe2Mr+s29wxteGnZ9h8PtW5
   JWHL4yt5kosnnHV3bahYW/R8BjvuxG34YZdfkJGxvtxWeJCvvcK1TsjxU
   zvvEoOB+KTsfg6Ht9ZXEnMUypnEe0LQHJD/zqGR98xmiDssk4o7H7yQab
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Apr 2022 10:06:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:06:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:33 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:30 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v7 2/9] ath11k: Move parameters in bus_params to hw_params
Date:   Fri, 29 Apr 2022 22:34:55 +0530
Message-ID: <20220429170502.20080-3-quic_mpubbise@quicinc.com>
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

In ath11k, bus_params were added with an intention to hold
parameters related to bus (AHB/PCI), but this is not true
as some bus parameters being different between chipsets of
the same bus.

With the addition of WCN6750 to ath11k, bus parameters are
going to be entirely different among AHB devices. Therefore,
it is wise to move bus_params to hw_params and get rid of
bus_params entirely.

Also, mhi_support parameter is not used anywhere in the driver,
remove it from bus_params.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 11 ++--------
 drivers/net/wireless/ath/ath11k/core.c | 28 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.h | 12 +----------
 drivers/net/wireless/ath/ath11k/hw.h   |  4 ++++
 drivers/net/wireless/ath/ath11k/pci.c  | 14 +++----------
 drivers/net/wireless/ath/ath11k/pcic.c |  4 ++--
 drivers/net/wireless/ath/ath11k/qmi.c  | 23 +++++++++++----------
 7 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f407d4af2074..49d79cfbf21c 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -28,13 +29,6 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, ath11k_ahb_of_match);
 
-static const struct ath11k_bus_params ath11k_ahb_bus_params = {
-	.mhi_support = false,
-	.m3_fw_support = false,
-	.fixed_bdf_addr = true,
-	.fixed_mem_region = true,
-};
-
 #define ATH11K_IRQ_CE0_OFFSET 4
 
 static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
@@ -685,8 +679,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	}
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(struct ath11k_ahb),
-			       ATH11K_BUS_AHB,
-			       &ath11k_ahb_bus_params);
+			       ATH11K_BUS_AHB);
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7e074b7716e7..19b5bb06c7e8 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -102,6 +102,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.dbr_debug_support = true,
 		.global_reset = false,
 		.bios_sar_capa = NULL,
+		.m3_fw_support = false,
+		.fixed_bdf_addr = true,
+		.fixed_mem_region = true,
+		.static_window_map = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -169,6 +173,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.dbr_debug_support = true,
 		.global_reset = false,
 		.bios_sar_capa = NULL,
+		.m3_fw_support = false,
+		.fixed_bdf_addr = true,
+		.fixed_mem_region = true,
+		.static_window_map = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -235,6 +243,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.dbr_debug_support = false,
 		.global_reset = true,
 		.bios_sar_capa = NULL,
+		.m3_fw_support = true,
+		.fixed_bdf_addr = false,
+		.fixed_mem_region = false,
+		.static_window_map = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -301,6 +313,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.dbr_debug_support = true,
 		.global_reset = false,
 		.bios_sar_capa = NULL,
+		.m3_fw_support = true,
+		.fixed_bdf_addr = false,
+		.fixed_mem_region = false,
+		.static_window_map = true,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -367,6 +383,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.dbr_debug_support = false,
 		.global_reset = true,
 		.bios_sar_capa = &ath11k_hw_sar_capa_wcn6855,
+		.m3_fw_support = true,
+		.fixed_bdf_addr = false,
+		.fixed_mem_region = false,
+		.static_window_map = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -432,6 +452,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.dbr_debug_support = false,
 		.global_reset = true,
 		.bios_sar_capa = &ath11k_hw_sar_capa_wcn6855,
+		.m3_fw_support = true,
+		.fixed_bdf_addr = false,
+		.fixed_mem_region = false,
+		.static_window_map = false,
 	},
 };
 
@@ -1730,8 +1754,7 @@ void ath11k_core_free(struct ath11k_base *ab)
 EXPORT_SYMBOL(ath11k_core_free);
 
 struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
-				      enum ath11k_bus bus,
-				      const struct ath11k_bus_params *bus_params)
+				      enum ath11k_bus bus)
 {
 	struct ath11k_base *ab;
 
@@ -1770,7 +1793,6 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	init_completion(&ab->wow.wakeup_completed);
 
 	ab->dev = dev;
-	ab->bus_params = *bus_params;
 	ab->hif.bus = bus;
 
 	return ab;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7a505531acf9..d8ab28413d95 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -748,14 +748,6 @@ struct ath11k_board_data {
 	size_t len;
 };
 
-struct ath11k_bus_params {
-	bool mhi_support;
-	bool m3_fw_support;
-	bool fixed_bdf_addr;
-	bool fixed_mem_region;
-	bool static_window_map;
-};
-
 struct ath11k_pci_ops {
 	int (*wakeup)(struct ath11k_base *ab);
 	void (*release)(struct ath11k_base *ab);
@@ -887,7 +879,6 @@ struct ath11k_base {
 	int bd_api;
 
 	struct ath11k_hw_params hw_params;
-	struct ath11k_bus_params bus_params;
 
 	const struct firmware *cal_file;
 
@@ -1135,8 +1126,7 @@ int ath11k_core_pre_init(struct ath11k_base *ab);
 int ath11k_core_init(struct ath11k_base *ath11k);
 void ath11k_core_deinit(struct ath11k_base *ath11k);
 struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
-				      enum ath11k_bus bus,
-				      const struct ath11k_bus_params *bus_params);
+				      enum ath11k_bus bus);
 void ath11k_core_free(struct ath11k_base *ath11k);
 int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
 			  struct ath11k_board_data *bd);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index b7ece3d5678c..09fa020bfee4 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -196,6 +196,10 @@ struct ath11k_hw_params {
 	bool dbr_debug_support;
 	bool global_reset;
 	const struct cfg80211_sar_capa *bios_sar_capa;
+	bool m3_fw_support;
+	bool fixed_bdf_addr;
+	bool fixed_mem_region;
+	bool static_window_map;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 024661a17008..dedf1b88ddf6 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -115,13 +115,6 @@ static const struct ath11k_pci_ops ath11k_pci_ops_qcn9074 = {
 	.window_read32 = ath11k_pci_window_read32,
 };
 
-static const struct ath11k_bus_params ath11k_pci_bus_params = {
-	.mhi_support = true,
-	.m3_fw_support = true,
-	.fixed_bdf_addr = false,
-	.fixed_mem_region = false,
-};
-
 static const struct ath11k_msi_config msi_config_one_msi = {
 	.total_vectors = 1,
 	.total_users = 4,
@@ -593,7 +586,7 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 		return ret;
 	}
 
-	if (ab->bus_params.static_window_map)
+	if (ab->hw_params.static_window_map)
 		ath11k_pci_select_static_window(ab_pci);
 
 	return 0;
@@ -706,8 +699,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	u32 soc_hw_version_major, soc_hw_version_minor, addr;
 	int ret;
 
-	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI,
-			       &ath11k_pci_bus_params);
+	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
+
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
@@ -764,7 +757,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ab->pci.ops = &ath11k_pci_ops_qca6390;
 		break;
 	case QCN9074_DEVICE_ID:
-		ab->bus_params.static_window_map = true;
 		ab->pci.ops = &ath11k_pci_ops_qcn9074;
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 63c678aea29e..7a920d65023f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -163,7 +163,7 @@ void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
 	} else {
-		if (ab->bus_params.static_window_map)
+		if (ab->hw_params.static_window_map)
 			window_start = ath11k_pcic_get_window_start(ab, offset);
 		else
 			window_start = ATH11K_PCI_WINDOW_START;
@@ -198,7 +198,7 @@ u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 	if (offset < ATH11K_PCI_WINDOW_START) {
 		val = ioread32(ab->mem + offset);
 	} else {
-		if (ab->bus_params.static_window_map)
+		if (ab->hw_params.static_window_map)
 			window_start = ath11k_pcic_get_window_start(ab, offset);
 		else
 			window_start = ATH11K_PCI_WINDOW_START;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 0442faa3b7af..c89e76108237 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -1648,7 +1649,7 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 	req.bdf_support_valid = 1;
 	req.bdf_support = 1;
 
-	if (ab->bus_params.m3_fw_support) {
+	if (ab->hw_params.m3_fw_support) {
 		req.m3_support_valid = 1;
 		req.m3_support = 1;
 		req.m3_cache_support_valid = 1;
@@ -1803,7 +1804,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	 * failure to FW and FW will then request mulitple blocks of small
 	 * chunk size memory.
 	 */
-	if (!(ab->bus_params.fixed_mem_region ||
+	if (!(ab->hw_params.fixed_mem_region ||
 	      test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
 	      ab->qmi.target_mem_delayed) {
 		delayed = true;
@@ -1873,7 +1874,7 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
-		if ((ab->bus_params.fixed_mem_region ||
+		if ((ab->hw_params.fixed_mem_region ||
 		     test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
 		     ab->qmi.target_mem[i].iaddr)
 			iounmap(ab->qmi.target_mem[i].iaddr);
@@ -2124,7 +2125,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 
 	memset(&resp, 0, sizeof(resp));
 
-	if (ab->bus_params.fixed_bdf_addr) {
+	if (ab->hw_params.fixed_bdf_addr) {
 		bdf_addr = ioremap(ab->hw_params.bdf_addr, ab->hw_params.fw.board_size);
 		if (!bdf_addr) {
 			ath11k_warn(ab, "qmi ioremap error for bdf_addr\n");
@@ -2153,7 +2154,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 			req->end = 1;
 		}
 
-		if (ab->bus_params.fixed_bdf_addr ||
+		if (ab->hw_params.fixed_bdf_addr ||
 		    type == ATH11K_QMI_FILE_TYPE_EEPROM) {
 			req->data_valid = 0;
 			req->end = 1;
@@ -2162,7 +2163,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 			memcpy(req->data, temp, req->data_len);
 		}
 
-		if (ab->bus_params.fixed_bdf_addr) {
+		if (ab->hw_params.fixed_bdf_addr) {
 			if (type == ATH11K_QMI_FILE_TYPE_CALDATA)
 				bdf_addr += ab->hw_params.fw.cal_offset;
 
@@ -2201,7 +2202,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 			goto err_iounmap;
 		}
 
-		if (ab->bus_params.fixed_bdf_addr ||
+		if (ab->hw_params.fixed_bdf_addr ||
 		    type == ATH11K_QMI_FILE_TYPE_EEPROM) {
 			remaining = 0;
 		} else {
@@ -2214,7 +2215,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 	}
 
 err_iounmap:
-	if (ab->bus_params.fixed_bdf_addr)
+	if (ab->hw_params.fixed_bdf_addr)
 		iounmap(bdf_addr);
 
 err_free_req:
@@ -2353,7 +2354,7 @@ static void ath11k_qmi_m3_free(struct ath11k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 
-	if (!ab->bus_params.m3_fw_support || !m3_mem->vaddr)
+	if (!ab->hw_params.m3_fw_support || !m3_mem->vaddr)
 		return;
 
 	dma_free_coherent(ab->dev, m3_mem->size,
@@ -2373,7 +2374,7 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
 
-	if (ab->bus_params.m3_fw_support) {
+	if (ab->hw_params.m3_fw_support) {
 		ret = ath11k_qmi_m3_load(ab);
 		if (ret) {
 			ath11k_err(ab, "failed to load m3 firmware: %d", ret);
@@ -2792,7 +2793,7 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 			   msg->mem_seg[i].type, msg->mem_seg[i].size);
 	}
 
-	if (ab->bus_params.fixed_mem_region ||
+	if (ab->hw_params.fixed_mem_region ||
 	    test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) {
 		ret = ath11k_qmi_assign_target_mem_chunk(ab);
 		if (ret) {
-- 
2.35.1

