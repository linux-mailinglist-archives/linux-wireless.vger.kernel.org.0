Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3316C44E25F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 08:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhKLHaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 02:30:04 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20674 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLHaD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 02:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636702034; x=1668238034;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=dlfSG1D2mx/vBP+vnwowPBejgPbOvAbVJsnexb2MEJc=;
  b=s4/4jbC6am8FfK+NzZAHCQX6OnsQXNOxM4GYdXO+9W4nOdbfa+NB+y8A
   e3SwzNQGlOLOml8xjYw/jOwDXFiMk7+mMheX2r9DvoPfQbn/ND2JxRN79
   Y3j3AVpCtgjtRxYNiKn05D2YRTrbm4MAPJqzKd7uOwMHkX0JUdme96acN
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Nov 2021 23:27:13 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 23:27:13 -0800
Received: from seevalam-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 11 Nov 2021 23:27:11 -0800
From:   Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: [PATCH] ath11k: add hw_param for wakeup_mhi
Date:   Fri, 12 Nov 2021 12:56:59 +0530
Message-ID: <1636702019-26142-1-git-send-email-quic_seevalam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wakeup mhi is needed before pci_read/write only for QCA6390
and WCN6855. Since wakeup & release mhi is enabled for all
hardwares, below mhi assert is seen in QCN9074.

	Kernel panic - not syncing: dev_wake != 0
	CPU: 2 PID: 13535 Comm: procd Not tainted 4.4.60 #1
	Hardware name: Generic DT based system
	[<80316dac>] (unwind_backtrace) from [<80313700>] (show_stack+0x10/0x14)
	[<80313700>] (show_stack) from [<805135dc>] (dump_stack+0x7c/0x9c)
	[<805135dc>] (dump_stack) from [<8032136c>] (panic+0x84/0x1f8)
	[<8032136c>] (panic) from [<80549b24>] (mhi_pm_disable_transition+0x3b8/0x5b8)
	[<80549b24>] (mhi_pm_disable_transition) from [<80549ddc>] (mhi_power_down+0xb8/0x100)
	[<80549ddc>] (mhi_power_down) from [<7f5242b0>] (ath11k_mhi_op_status_cb+0x284/0x3ac [ath11k_pci])
	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET pm_state:SHUTDOWN Process
	[<7f5242b0>] (ath11k_mhi_op_status_cb [ath11k_pci]) from [<7f524878>] (ath11k_mhi_stop+0x10/0x20 [ath11k_pci])
	[<7f524878>] (ath11k_mhi_stop [ath11k_pci]) from [<7f525b94>] (ath11k_pci_power_down+0x54/0x90 [ath11k_pci])
	[<7f525b94>] (ath11k_pci_power_down [ath11k_pci]) from [<8056b2a8>] (pci_device_shutdown+0x30/0x44)
	[<8056b2a8>] (pci_device_shutdown) from [<805cfa0c>] (device_shutdown+0x124/0x174)
	[<805cfa0c>] (device_shutdown) from [<8033aaa4>] (kernel_restart+0xc/0x50)
	[<8033aaa4>] (kernel_restart) from [<8033ada8>] (SyS_reboot+0x178/0x1ec)
	[<8033ada8>] (SyS_reboot) from [<80301b80>] (ret_fast_syscall+0x0/0x34)

Hence, disable wakeup/release mhi using hw_param for other hardwares.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01060-QCAHKSWPL_SILICONZ-1

Fixes: a05bd85133 ("ath11k: read and write registers below unwindowed address")
Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  5 +++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 12 ++++++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index bd77aed..4ac09f0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -84,6 +84,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = false,
+		.wakeup_mhi = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -135,6 +136,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = false,
+		.wakeup_mhi = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -185,6 +187,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
+		.wakeup_mhi = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -235,6 +238,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = true,
+		.wakeup_mhi = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -285,6 +289,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
+		.wakeup_mhi = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 2c7bd7a..83b6240 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -178,6 +178,7 @@ struct ath11k_hw_params {
 	u8 max_tx_ring;
 	const struct ath11k_hw_hal_params *hal_params;
 	bool supports_dynamic_smps_6ghz;
+	bool wakeup_mhi;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 3d353e7..fadded5 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -182,7 +182,8 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
 	 */
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
 	    offset >= ACCESS_ALWAYS_OFF)
 		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
 
@@ -206,7 +207,8 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 		}
 	}
 
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
 	    offset >= ACCESS_ALWAYS_OFF)
 		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
@@ -219,7 +221,8 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
 	 */
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
 	    offset >= ACCESS_ALWAYS_OFF)
 		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
 
@@ -243,7 +246,8 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 		}
 	}
 
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	if (ab->hw_params.wakeup_mhi &&
+	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
 	    offset >= ACCESS_ALWAYS_OFF)
 		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 
-- 
2.7.4

