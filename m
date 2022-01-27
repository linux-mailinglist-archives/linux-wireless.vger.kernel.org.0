Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355EF49DA3A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiA0Fdq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:33:46 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:50885 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiA0Fdp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261625; x=1674797625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2h0dYAYmdlN5eRAPm8zpvihUYGff15A2BFWGba7H+ac=;
  b=ElrkjwTzlQTw3CSw3Zp0gu8hkjJs46AsJMvWdSW4uPynZNPJ12eFupdQ
   HPwvWDIKASRcVUHN+cts7dGej/Sdqc4znX12Cjjp2QYztTBl56RCwC381
   0TwN7eYIooDXcQaWxxilLsfsN1lGzQ2w5ohU8z/O1/DU9PvgYamGxBYHZ
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Jan 2022 21:33:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:33:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:44 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:42 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH RFC 1/8] ath11k: Enable low power mode when WLAN is not active
Date:   Thu, 27 Jan 2022 11:03:22 +0530
Message-ID: <1643261609-13500-2-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, WLAN chip is powered once during driver probe and
is kept ON (powered) always even when WLAN is not active;
keeping the chip powered ON all the time will consume extra
power which is not desirable on a battery operated device.
Same is the case with non-WoW suspend, chip will not be put
into low power mode when the system is suspended resulting
in higher battery drain.

As per the recommendation, sending a PDEV suspend WMI command
followed by a QMI MODE OFF command will cease all WLAN activity
and put the device in low power mode. Put the chip in low power
mode when there are no active WLAN interfaces and during non-WoW
suspend to conserve power.

The logic is being applied only for WCN6750 not impacting other
supported chips.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c    | 141 ++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h    |   5 +-
 drivers/net/wireless/ath/ath11k/hw.h      |   3 +-
 drivers/net/wireless/ath/ath11k/mac.c     |  27 +++++-
 drivers/net/wireless/ath/ath11k/thermal.c |  12 +++
 5 files changed, 159 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 86373d6..acb8861 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -97,6 +97,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = true,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.non_wow_suspend = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -160,6 +161,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = true,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.non_wow_suspend = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -222,6 +224,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.non_wow_suspend = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -284,6 +287,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = true,
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
+		.non_wow_suspend = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -346,6 +350,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.non_wow_suspend = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -407,6 +412,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
+		.non_wow_suspend = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -468,6 +474,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = false,
+		.non_wow_suspend = true,
 	},
 };
 
@@ -931,7 +938,6 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
 	ath11k_debugfs_soc_destroy(ab);
-	ath11k_dp_free(ab);
 	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
 }
@@ -987,11 +993,10 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
-	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
-	ath11k_hif_irq_disable(ab);
-	ath11k_dp_pdev_free(ab);
+	if (!test_bit(ATH11K_FLAG_DEVICE_STOPPED, &ab->dev_flags))
+		ath11k_core_stop_device(ab);
 	ath11k_debugfs_pdev_destroy(ab);
 }
 
@@ -1205,6 +1210,9 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 
 	mutex_unlock(&ab->core_lock);
 
+	if (!test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		ath11k_core_stop_device(ab);
+
 	return 0;
 
 err_core_stop:
@@ -1221,10 +1229,7 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 
 static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 {
-	int ret;
-
 	mutex_lock(&ab->core_lock);
-	ath11k_thermal_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_spectral_deinit(ab);
@@ -1234,27 +1239,11 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
-	ath11k_hal_srng_deinit(ab);
+	set_bit(ATH11K_FLAG_DEVICE_STOPPED, &ab->dev_flags);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
-	ret = ath11k_hal_srng_init(ab);
-	if (ret)
-		return ret;
-
-	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
-
-	ret = ath11k_core_qmi_firmware_ready(ab);
-	if (ret)
-		goto err_hal_srng_deinit;
-
-	clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
-
 	return 0;
-
-err_hal_srng_deinit:
-	ath11k_hal_srng_deinit(ab);
-	return ret;
 }
 
 void ath11k_core_halt(struct ath11k *ar)
@@ -1465,7 +1454,6 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	mutex_lock(&ab->core_lock);
 
 	ath11k_core_pdev_destroy(ab);
-	ath11k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
 
@@ -1527,5 +1515,106 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 }
 EXPORT_SYMBOL(ath11k_core_alloc);
 
+static int ath11k_core_suspend_target(struct ath11k_base *ab, u32 suspend_opt)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	unsigned long time_left;
+	int ret;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		reinit_completion(&ab->htc_suspend);
+
+		ret = ath11k_wmi_pdev_suspend(ar, suspend_opt, pdev->pdev_id);
+		if (ret) {
+			ath11k_warn(ab, "could not suspend target (%d)\n", ret);
+			return ret;
+		}
+
+		time_left = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
+
+		if (!time_left) {
+			ath11k_warn(ab, "suspend timed out - target pause event never came\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+void ath11k_core_stop_device(struct ath11k_base *ab)
+{
+	if (!ab->hw_params.non_wow_suspend &&
+	    !test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags))
+		return;
+
+	ath11k_core_suspend_target(ab, WMI_PDEV_SUSPEND_AND_DISABLE_INTR);
+
+	ath11k_hif_irq_disable(ab);
+	ath11k_core_stop(ab);
+	ath11k_spectral_deinit(ab);
+	ath11k_dp_pdev_free(ab);
+	ath11k_dp_free(ab);
+
+	set_bit(ATH11K_FLAG_DEVICE_STOPPED, &ab->dev_flags);
+}
+
+int ath11k_core_start_device(struct ath11k_base *ab)
+{
+	int i;
+	int ret;
+	struct ath11k_pdev *pdev;
+	struct ath11k *ar;
+
+	if (!ab->hw_params.non_wow_suspend &&
+	    !test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
+		return 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		if (!ar)
+			continue;
+
+		if (ar->state == ATH11K_STATE_ON)
+			break;
+	}
+
+	if (i == ab->num_radios ||
+	    test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags)) {
+		if (!test_bit(ATH11K_FLAG_DEVICE_STOPPED, &ab->dev_flags))
+			return -EAGAIN;
+
+		ath11k_hal_srng_deinit(ab);
+
+		ret = ath11k_hal_srng_init(ab);
+		if (ret) {
+			ath11k_err(ab, "failed to allocate ce pipes: %d\n", ret);
+			return ret;
+		}
+
+		clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
+
+		ret = ath11k_core_qmi_firmware_ready(ab);
+		if (ret) {
+			ath11k_err(ab, "failed to init core: %d\n", ret);
+			goto err_hal_srng_deinit;
+		}
+
+		clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+		clear_bit(ATH11K_FLAG_DEVICE_STOPPED, &ab->dev_flags);
+	}
+
+	return 0;
+
+err_hal_srng_deinit:
+	ath11k_hal_srng_deinit(ab);
+	return ret;
+}
+
 MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 76f5aef..758f271 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_CORE_H
@@ -208,6 +208,7 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_FIXED_MEM_RGN,
 	ATH11K_FLAG_DEVICE_INIT_DONE,
 	ATH11K_FLAG_MULTI_MSI_VECTORS,
+	ATH11K_FLAG_DEVICE_STOPPED,
 };
 
 enum ath11k_monitor_flags {
@@ -1025,6 +1026,8 @@ int ath11k_core_check_dt(struct ath11k_base *ath11k);
 void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
+void ath11k_core_stop_device(struct ath11k_base *ab);
+int ath11k_core_start_device(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index a220c9a..a38745e 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HW_H
@@ -192,6 +192,7 @@ struct ath11k_hw_params {
 	bool alloc_cacheable_memory;
 	bool supports_rssi_stats;
 	bool fw_wmi_diag_event;
+	bool non_wow_suspend;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ac6a192..2402405 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -5726,6 +5726,14 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	int ret;
 
 	ath11k_mac_drain_tx(ar);
+
+	ret = ath11k_core_start_device(ab);
+	if (ret) {
+		if (ret != -EAGAIN)
+			ath11k_err(ab, "failed to start device : %d\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&ar->conf_mutex);
 
 	switch (ar->state) {
@@ -5847,8 +5855,11 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_pdev *pdev;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
 	int ret;
+	int i;
 
 	ath11k_mac_drain_tx(ar);
 
@@ -5879,6 +5890,20 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	synchronize_rcu();
 
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		if (!ar || ar->state == ATH11K_STATE_OFF)
+			continue;
+		break;
+	}
+
+	/* All PDEVs on the SoC are down, time to power down
+	 * the device.
+	 */
+	if (i == ab->num_radios)
+		ath11k_core_stop_device(ab);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index c96b26f..acb3b45 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/device.h>
@@ -69,6 +70,11 @@ static ssize_t ath11k_thermal_show_temp(struct device *dev,
 
 	mutex_lock(&ar->conf_mutex);
 
+	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
 	/* Can't get temperature when the card is off */
 	if (ar->state != ATH11K_STATE_ON) {
 		ret = -ENETDOWN;
@@ -131,6 +137,9 @@ int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
 
 	lockdep_assert_held(&ar->conf_mutex);
 
+	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+		return 0;
+
 	if (ar->state != ATH11K_STATE_ON)
 		return 0;
 
@@ -162,6 +171,9 @@ int ath11k_thermal_register(struct ath11k_base *sc)
 	struct ath11k_pdev *pdev;
 	int i, ret;
 
+	if (test_bit(ATH11K_FLAG_REGISTERED, &sc->dev_flags))
+		return 0;
+
 	for (i = 0; i < sc->num_radios; i++) {
 		pdev = &sc->pdevs[i];
 		ar = pdev->ar;
-- 
2.7.4

