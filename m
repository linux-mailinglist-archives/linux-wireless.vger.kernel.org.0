Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69545ABB6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhKWSym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:54:42 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:14975 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238049AbhKWSyk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693491; x=1669229491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fRl7EvwIYpFNkA229GClNfw/ZXipbb+QJ2QhNH3szlo=;
  b=kQRcp2U/1b3V+vlVNt1FNohe/wF0V6KJcFKGIvug+22R6pTdHYncEcJJ
   lWhLv9ai+wUHa4iQkHwgToAZKk/FgGl6YXFiPn3NSKIhWo4UCgVk2izyW
   /Q7sOzi/Gxp3FttPkf5p4ryDCVjRKARq09fdtnWxRw1jJwoz/kaPL9Rvh
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 10:51:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:51:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:31 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:28 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 06/19] ath11k: Add HW params for WCN6750
Date:   Wed, 24 Nov 2021 00:20:21 +0530
Message-ID: <1637693434-15462-7-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add HW params for WCN6750. It is similar to the HW params
of QCA6390 with few differences wrt DP APIs and register
offsets.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 48 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/qmi.h  |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 6e3d4aa..a65a4f3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -299,6 +300,53 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 	},
+	{
+		.name = "wcn6750 hw1.0",
+		.hw_rev = ATH11K_HW_WCN6750_HW10,
+		.fw = {
+			.dir = "WCN6750/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+		},
+		.max_radios = 1,
+		.bdf_addr = 0x4B0C0000,
+		.ring_mask = &ath11k_hw_ring_mask_qca6390,
+		.internal_sleep_clock = false,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_WCN6750,
+		.host_ce_config = ath11k_host_ce_config_qca6390,
+		.ce_count = 9,
+		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
+		.target_ce_count = 9,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
+		.svc_to_ce_map_len = 14,
+		.single_pdev_only = true,
+		.rxdma1_enable = false,
+		.num_rxmda_per_pdev = 1,
+		.rx_mac_buf_ring = true,
+		.vdev_start_delay = true,
+		.htt_peer_map_v2 = false,
+
+		.spectral = {
+			.fft_sz = 0,
+			.fft_pad_sz = 0,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 0,
+			.max_fft_bins = 0,
+		},
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP),
+		.supports_monitor = false,
+		.supports_shadow_regs = true,
+		.idle_ps = true,
+		.cold_boot_calib = false,
+		.supports_suspend = false,
+		.fix_l1ss = true,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
+		.hal_params = &ath11k_hw_hal_params_qca6390,
+		.supports_dynamic_smps_6ghz = false,
+		.alloc_cacheable_memory = false,
+	},
 };
 
 int ath11k_core_suspend(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 70324ee..7cb90cd 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -118,6 +118,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_IPQ6018_HW10,
 	ATH11K_HW_QCN9074_HW10,
 	ATH11K_HW_WCN6855_HW20,
+	ATH11K_HW_WCN6750_HW10,
 };
 
 enum ath11k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 3bb0f9e..2b99cc5 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_QMI_H
@@ -20,6 +21,7 @@
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390	0x01
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074	0x02
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9074	0x07
+#define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_WCN6750	0x03
 #define ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
 #define ATH11K_QMI_RESP_LEN_MAX			8192
 #define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	52
-- 
2.7.4

