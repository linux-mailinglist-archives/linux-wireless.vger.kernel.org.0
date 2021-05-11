Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAFD37ABD2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhEKQYU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 12:24:20 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:32070 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhEKQYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 12:24:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620750192; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Wg4GCO9yFePPA2nMfSeaT77mhhofzZGJqmjUaaqNO4k=; b=G8pRkEvl43QdMbD5sE189DzZ8RdHSSTWhSxAsYw43/DeRc7R+UKvmP3HHnnmReH9L2uFao21
 H8emZTobHy4RuY2mo2G81K1GMpFCsNj3kujvjbHnVBmoagb3NoDlGxsGDlwOj0BvhxtnHj87
 owrJF5gxD/2zH6Z/0k9lz8ykvYY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 609aaf6be0211609c47db422 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 16:23:07
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C344DC433D3; Tue, 11 May 2021 16:23:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-96-12-nat.elisa-mobile.fi [85.76.96.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70FD5C43145;
        Tue, 11 May 2021 16:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70FD5C43145
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 6/7] ath11k: add support for WCN6855
Date:   Tue, 11 May 2021 19:22:13 +0300
Message-Id: <20210511162214.29475-7-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511162214.29475-1-jouni@codeaurora.org>
References: <20210511162214.29475-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

This patch is to add support for WCN6855. For station mode,
WCN6855 is able to connect to an AP, and ping works well.
For AP mode, hostapd is able to bringup an SAP interface with
WCN6855, a normal station can connect to this AP and
ping works well.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 39 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 42 ++++++++++++++++++++------
 4 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 77ce3347ab86..fd8941905fdb 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -187,6 +187,45 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 	},
+	{
+		.name = "wcn6855 hw2.0",
+		.hw_rev = ATH11K_HW_WCN6855_HW20,
+		.fw = {
+			.dir = "WCN6855/hw2.0",
+			.board_size = 256 * 1024,
+			.cal_size = 256 * 1024,
+		},
+		.max_radios = 3,
+		.bdf_addr = 0x4B0C0000,
+		.hw_ops = &wcn6855_ops,
+		.ring_mask = &ath11k_hw_ring_mask_qca6390,
+		.internal_sleep_clock = true,
+		.regs = &wcn6855_regs,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390,
+		.host_ce_config = ath11k_host_ce_config_qca6390,
+		.ce_count = 9,
+		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
+		.target_ce_count = 9,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
+		.svc_to_ce_map_len = 14,
+		.single_pdev_only = true,
+		.rxdma1_enable = false,
+		.num_rxmda_per_pdev = 2,
+		.rx_mac_buf_ring = true,
+		.vdev_start_delay = true,
+		.htt_peer_map_v2 = false,
+		.tcl_0_only = true,
+		.spectral_fft_sz = 0,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP),
+		.supports_monitor = false,
+		.supports_shadow_regs = true,
+		.idle_ps = true,
+		.cold_boot_calib = false,
+		.supports_suspend = true,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
+	},
 };
 
 int ath11k_core_suspend(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 55af982deca7..6bd3bc5cee2f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -107,6 +107,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_QCA6390_HW20,
 	ATH11K_HW_IPQ6018_HW10,
 	ATH11K_HW_QCN9074_HW10,
+	ATH11K_HW_WCN6855_HW20,
 };
 
 enum ath11k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 27b394d115e2..75cc2d80fde8 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -354,6 +354,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		ath11k_mhi_config = &ath11k_mhi_config_qcn9074;
 		break;
 	case ATH11K_HW_QCA6390_HW20:
+	case ATH11K_HW_WCN6855_HW20:
 		ath11k_mhi_config = &ath11k_mhi_config_qca6390;
 		break;
 	default:
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 0f31eb566fb6..d33b5d66b494 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -36,9 +36,11 @@
 
 #define QCA6390_DEVICE_ID		0x1101
 #define QCN9074_DEVICE_ID		0x1104
+#define WCN6855_DEVICE_ID		0x1103
 
 static const struct pci_device_id ath11k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
+	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
 	/* TODO: add QCN9074_DEVICE_ID) once firmware issues are resolved */
 	{0}
 };
@@ -1176,12 +1178,26 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.get_ce_msi_idx = ath11k_pci_get_ce_msi_idx,
 };
 
+static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
+{
+	u32 soc_hw_version;
+
+	soc_hw_version = ath11k_pci_read32(ab, TCSR_SOC_HW_VERSION);
+	*major = FIELD_GET(TCSR_SOC_HW_VERSION_MAJOR_MASK,
+			   soc_hw_version);
+	*minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
+			   soc_hw_version);
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci tcsr_soc_hw_version major %d minor %d\n",
+		   *major, *minor);
+}
+
 static int ath11k_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *pci_dev)
 {
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
-	u32 soc_hw_version, soc_hw_version_major, soc_hw_version_minor;
+	u32 soc_hw_version_major, soc_hw_version_minor;
 	int ret;
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI,
@@ -1209,15 +1225,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 
 	switch (pci_dev->device) {
 	case QCA6390_DEVICE_ID:
-		soc_hw_version = ath11k_pci_read32(ab, TCSR_SOC_HW_VERSION);
-		soc_hw_version_major = FIELD_GET(TCSR_SOC_HW_VERSION_MAJOR_MASK,
-						 soc_hw_version);
-		soc_hw_version_minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
-						 soc_hw_version);
-
-		ath11k_dbg(ab, ATH11K_DBG_PCI, "pci tcsr_soc_hw_version major %d minor %d\n",
-			   soc_hw_version_major, soc_hw_version_minor);
-
+		ath11k_pci_read_hw_version(ab, &soc_hw_version_major, &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
 		case 2:
 			ab->hw_rev = ATH11K_HW_QCA6390_HW20;
@@ -1235,6 +1243,20 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ab->bus_params.static_window_map = true;
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
+	case WCN6855_DEVICE_ID:
+		ath11k_pci_read_hw_version(ab, &soc_hw_version_major, &soc_hw_version_minor);
+		switch (soc_hw_version_major) {
+		case 2:
+			ab->hw_rev = ATH11K_HW_WCN6855_HW20;
+			break;
+		default:
+			dev_err(&pdev->dev, "Unsupported WCN6855 SOC hardware version: %d %d\n",
+				soc_hw_version_major, soc_hw_version_minor);
+			ret = -EOPNOTSUPP;
+			goto err_pci_free_region;
+		}
+		ab_pci->msi_config = &ath11k_msi_config[0];
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
 			pci_dev->device);
-- 
2.25.1

