Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37B52D7D14
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395385AbgLKRiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:38:12 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:51447 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395398AbgLKRg6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708197; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=F6VqIKqa15lIvunwvfTAID7o+gmbItZVefmhEq/B/sY=; b=adknAYgHw+dqkLQXalSsoHf7EmOimnVN7N8KxkPikDT14tzEa3cKkPKC40Arm2LjF4kLNwGe
 qQDj8Yo7+VnQldTPNM5x94EUoimUSJNzUKtoKZBtTRWYaMO0opYAKxyiV3Ju7/pw2lJXb646
 J5YP1AsLmu5FV9NHhRQu707qIOk=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fd3ae0b35a25d1b16de8065 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6057C433CA; Fri, 11 Dec 2020 17:36:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AEF8C433C6;
        Fri, 11 Dec 2020 17:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AEF8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/10] ath11k: implement suspend for QCA6390 PCI devices
Date:   Fri, 11 Dec 2020 19:35:50 +0200
Message-Id: <1607708150-21066-11-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Now that all the needed pieces are in place implement suspend support QCA6390
PCI devices. All other devices will return -EOPNOTSUPP during suspend. The
suspend is implemented by switching the firmware to WoW mode during suspend, so
the firmware will be running on low power mode while host is in suspend.

At the moment we are not able to shutdown and fully power off the device due to
bugs in MHI subsystem, so WoW mode is a workaround for the time being.

During suspend we enable WoW mode, disable CE irq and DP irq, then put MHI to
suspend state.  During resume, driver resumes MHI firstly, then enables CE irq
and dp IRQ, and sends WoW wakeup command to firmware.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c   |  2 +-
 drivers/net/wireless/ath/ath11k/ce.h   |  2 +
 drivers/net/wireless/ath/ath11k/core.c | 85 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  2 +
 drivers/net/wireless/ath/ath11k/dp.c   |  2 +-
 drivers/net/wireless/ath/ath11k/dp.h   |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 31 +++++++++++++
 8 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 9d730f8ac816..987c65010272 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -195,7 +195,7 @@ static bool ath11k_ce_need_shadow_fix(int ce_id)
 	return false;
 }
 
-static void ath11k_ce_stop_shadow_timers(struct ath11k_base *ab)
+void ath11k_ce_stop_shadow_timers(struct ath11k_base *ab)
 {
 	int i;
 
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 269b599ac0b0..d6eeef919349 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -190,4 +190,6 @@ int ath11k_ce_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 int ath11k_ce_attr_attach(struct ath11k_base *ab);
 void ath11k_ce_get_shadow_config(struct ath11k_base *ab,
 				 u32 **shadow_cfg, u32 *shadow_cfg_len);
+void ath11k_ce_stop_shadow_timers(struct ath11k_base *ab);
+
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 451748fa8fff..b97c38b9a270 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -13,6 +13,7 @@
 #include "dp_rx.h"
 #include "debug.h"
 #include "hif.h"
+#include "wow.h"
 
 unsigned int ath11k_debug_mask;
 EXPORT_SYMBOL(ath11k_debug_mask);
@@ -66,6 +67,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.cold_boot_calib = true,
+		.supports_suspend = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -103,6 +105,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.cold_boot_calib = true,
+		.supports_suspend = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -139,9 +142,91 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.cold_boot_calib = false,
+		.supports_suspend = true,
 	},
 };
 
+int ath11k_core_suspend(struct ath11k_base *ab)
+{
+	int ret;
+
+	if (!ab->hw_params.supports_suspend)
+		return -EOPNOTSUPP;
+
+	/* TODO: there can frames in queues so for now add delay as a hack.
+	 * Need to implement to handle and remove this delay.
+	 */
+	msleep(500);
+
+	ret = ath11k_dp_rx_pktlog_stop(ab, true);
+	if (ret) {
+		ath11k_warn(ab, "failed to stop dp rx (and timer) pktlog during suspend: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ret = ath11k_wow_enable(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to enable wow during suspend: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_dp_rx_pktlog_stop(ab, false);
+	if (ret) {
+		ath11k_warn(ab, "failed to stop dp rx pktlog during suspend: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ath11k_ce_stop_shadow_timers(ab);
+	ath11k_dp_stop_shadow_timers(ab);
+
+	ath11k_hif_irq_disable(ab);
+	ath11k_hif_ce_irq_disable(ab);
+
+	ret = ath11k_hif_suspend(ab);
+	if (!ret) {
+		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_core_suspend);
+
+int ath11k_core_resume(struct ath11k_base *ab)
+{
+	int ret;
+
+	if (!ab->hw_params.supports_suspend)
+		return -EOPNOTSUPP;
+
+	ret = ath11k_hif_resume(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
+		return ret;
+	}
+
+	ath11k_hif_ce_irq_enable(ab);
+	ath11k_hif_irq_enable(ab);
+
+	ret = ath11k_dp_rx_pktlog_start(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ret = ath11k_wow_wakeup(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to wakeup wow during resume: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_core_resume);
+
 int ath11k_core_check_dt(struct ath11k_base *ab)
 {
 	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index ba8f2222169d..799bf3de1117 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -897,6 +897,8 @@ void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 int ath11k_core_check_dt(struct ath11k_base *ath11k);
 
 void ath11k_core_halt(struct ath11k *ar);
+int ath11k_core_resume(struct ath11k_base *ab);
+int ath11k_core_suspend(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f977056ae5e8..04f6c4e0658b 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -304,7 +304,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 	return 0;
 }
 
-static void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
+void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
 {
 	int i;
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 1d9e2d6de3ae..ee768ccce46e 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1641,5 +1641,6 @@ void ath11k_dp_shadow_stop_timer(struct ath11k_base *ab,
 void ath11k_dp_shadow_init_timer(struct ath11k_base *ab,
 				 struct ath11k_hp_update_timer *update_timer,
 				 u32 interval, u32 ring_id);
+void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f33a458a465f..8af0034fdb05 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -156,6 +156,7 @@ struct ath11k_hw_params {
 	bool supports_shadow_regs;
 	bool idle_ps;
 	bool cold_boot_calib;
+	bool supports_suspend;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index e720ac6354fc..857647aa57c8 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1204,12 +1204,43 @@ static void ath11k_pci_shutdown(struct pci_dev *pdev)
 	ath11k_pci_power_down(ab);
 }
 
+static __maybe_unused int ath11k_pci_pm_suspend(struct device *dev)
+{
+	struct ath11k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath11k_core_suspend(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to suspend core: %d\n", ret);
+
+	return ret;
+}
+
+static __maybe_unused int ath11k_pci_pm_resume(struct device *dev)
+{
+	struct ath11k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath11k_core_resume(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to resume core: %d\n", ret);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(ath11k_pci_pm_ops,
+			 ath11k_pci_pm_suspend,
+			 ath11k_pci_pm_resume);
+
 static struct pci_driver ath11k_pci_driver = {
 	.name = "ath11k_pci",
 	.id_table = ath11k_pci_id_table,
 	.probe = ath11k_pci_probe,
 	.remove = ath11k_pci_remove,
 	.shutdown = ath11k_pci_shutdown,
+#ifdef CONFIG_PM
+	.driver.pm = &ath11k_pci_pm_ops,
+#endif
 };
 
 static int ath11k_pci_init(void)
-- 
2.7.4

