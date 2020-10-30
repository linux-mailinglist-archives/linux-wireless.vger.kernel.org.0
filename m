Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD62A01F5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 10:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgJ3J6n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 05:58:43 -0400
Received: from z5.mailgun.us ([104.130.96.5]:35670 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3J6m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 05:58:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604051921; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=P2gVPnhEAFKdWNmJbpLeKq1UgpJwIoZACI0kC9Yn5Ho=; b=f3cWjERvgRZGricj/2T/T6tJocMUnMugI18e3Y34VVbxF5kPYS69nZ2Ud67c5VsORtZvwj+X
 NNuYdH5u9xCbJ33RL6NMR43mVLvNz/zUv8c4pIOwjYcBsV3ncnxCLfl8uunxsW7dT9KoDT1F
 zpMzScgoV0ta1jZevARqytbfMGg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f9be3d15dd9f092647f9f88 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Oct 2020 09:58:41
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5810EC433C9; Fri, 30 Oct 2020 09:58:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-E5430.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01AD6C433F0;
        Fri, 30 Oct 2020 09:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01AD6C433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [RFC] ath11k: enable non-wow suspend and resume
Date:   Fri, 30 Oct 2020 17:58:32 +0800
Message-Id: <20201030095832.7447-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For QCA6390, it needs to power down target when system suspends and
needs to power up target when system resumes in non-wow scenario.

The power up procedure downloads firmware again.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 62 ++++++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h |  8 +++++
 drivers/net/wireless/ath/ath11k/mac.c  | 21 ++++++++++--
 drivers/net/wireless/ath/ath11k/pci.c  | 46 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.c  | 21 ++++++++++--
 drivers/net/wireless/ath/ath11k/qmi.h  |  1 +
 6 files changed, 144 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 6487651..e3d4476 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -411,7 +411,20 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 	return 0;
 }
 
-static void ath11k_core_stop(struct ath11k_base *ab)
+void ath11k_core_cutoff_stop(struct ath11k_base *ab)
+{
+	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
+		ath11k_qmi_firmware_stop(ab);
+
+	ath11k_hif_stop(ab);
+	ath11k_wmi_detach(ab);
+	ath11k_thermal_unregister(ab);
+	ath11k_dp_pdev_free(ab);
+	ath11k_dp_free(ab);
+	ath11k_dp_pdev_reo_cleanup(ab);
+}
+
+void ath11k_core_stop(struct ath11k_base *ab)
 {
 	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath11k_qmi_firmware_stop(ab);
@@ -466,16 +479,19 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 {
 	int ret;
 
-	ret = ath11k_debugfs_pdev_create(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to create core pdev debugfs: %d\n", ret);
-		return ret;
-	}
+	if (!test_bit(ATH11K_FLAG_CORE_STARTING, &ab->dev_flags)) {
+		ret = ath11k_debugfs_pdev_create(ab);
+		if (ret) {
+			ath11k_err(ab, "failed to create core pdev debugfs: %d\n", ret);
+			return ret;
+		}
 
-	ret = ath11k_mac_register(ab);
-	if (ret) {
-		ath11k_err(ab, "failed register the radio with mac80211: %d\n", ret);
-		goto err_pdev_debug;
+		ret = ath11k_mac_register(ab);
+		if (ret) {
+			ath11k_err(ab, "failed register the radio with mac80211: %d\n",
+				   ret);
+			goto err_pdev_debug;
+		}
 	}
 
 	ret = ath11k_dp_pdev_alloc(ab);
@@ -689,6 +705,9 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 	ath11k_hif_irq_enable(ab);
 	mutex_unlock(&ab->core_lock);
 
+	if (test_bit(ATH11K_FLAG_CORE_STARTING, &ab->dev_flags))
+		complete(&ab->fw_mac_restart);
+
 	return 0;
 
 err_core_stop:
@@ -943,5 +962,28 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 }
 EXPORT_SYMBOL(ath11k_core_alloc);
 
+int ath11k_core_suspend(struct ath11k_base *ab)
+{
+	ath11k_hif_irq_disable(ab);
+	ath11k_core_cutoff_stop(ab);
+	ath11k_hif_power_down(ab);
+	ath11k_qmi_free_resource(ab);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_core_suspend);
+
+int ath11k_core_resume(struct ath11k_base *ab)
+{
+	int ret = 0;
+
+	set_bit(ATH11K_FLAG_CORE_STARTING, &ab->dev_flags);
+	init_completion(&ab->fw_mac_restart);
+	ath11k_hif_power_up(ab);
+
+	return ret;
+}
+EXPORT_SYMBOL(ath11k_core_resume);
+
 MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 031de2b..e38817c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -168,6 +168,8 @@ enum ath11k_scan_state {
 	ATH11K_SCAN_ABORTING,
 };
 
+#define  ATH11K_MAC_START_TIMEOUT (3 * HZ)
+
 enum ath11k_dev_flags {
 	ATH11K_CAC_RUNNING,
 	ATH11K_FLAG_CORE_REGISTERED,
@@ -178,6 +180,8 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_RECOVERY,
 	ATH11K_FLAG_UNREGISTERING,
 	ATH11K_FLAG_REGISTERED,
+	ATH11K_FLAG_CORE_STOPPED,
+	ATH11K_FLAG_CORE_STARTING
 };
 
 enum ath11k_monitor_flags {
@@ -731,6 +735,8 @@ struct ath11k_base {
 	u32 num_db_cap;
 
 	struct timer_list mon_reap_timer;
+	struct completion fw_mac_restart;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
@@ -889,6 +895,8 @@ void ath11k_core_halt(struct ath11k *ar);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
+int ath11k_core_resume(struct ath11k_base *ab);
+int ath11k_core_suspend(struct ath11k_base *ab);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index dfced9c..2a76c19 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -15,6 +15,7 @@
 #include "testmode.h"
 #include "peer.h"
 #include "debugfs_sta.h"
+#include "hif.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -837,12 +838,15 @@ static int ath11k_config_ps(struct ath11k *ar)
 
 static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
+	struct ath11k *ar = hw->priv;
+	int ret = 0;
+
 	mutex_lock(&ar->conf_mutex);
 	if (changed & IEEE80211_CONF_CHANGE_PS)
-		ath11k_config_ps(ar);
+		ret = ath11k_config_ps(ar);
 	mutex_unlock(&ar->conf_mutex);
 
-	return 0;
+	return ret;
 }
 
 static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
@@ -4209,6 +4213,18 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 
 	switch (ar->state) {
 	case ATH11K_STATE_OFF:
+		/* mac_op_stop was called before, so here need to wait
+		 * target powered up and everything is ready.
+		 */
+		if (test_bit(ATH11K_FLAG_CORE_STARTING, &ab->dev_flags)) {
+			if (!wait_for_completion_timeout(&ab->fw_mac_restart,
+							 ATH11K_MAC_START_TIMEOUT)) {
+				ath11k_err(ab, "wait mac start timeout\n");
+				ret = -ETIMEDOUT;
+			}
+			clear_bit(ATH11K_FLAG_CORE_STARTING, &ab->dev_flags);
+			clear_bit(ATH11K_FLAG_CORE_STOPPED, &ab->dev_flags);
+		}
 		ar->state = ATH11K_STATE_ON;
 		break;
 	case ATH11K_STATE_RESTARTING:
@@ -4330,6 +4346,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 
 	clear_bit(ATH11K_CAC_RUNNING, &ar->dev_flags);
 	ar->state = ATH11K_STATE_OFF;
+	set_bit(ATH11K_FLAG_CORE_STOPPED, &ar->ab->dev_flags);
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d7eb6b7..7ffb198 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1030,12 +1030,58 @@ static void ath11k_pci_shutdown(struct pci_dev *pdev)
 	ath11k_pci_power_down(ab);
 }
 
+static int ath11k_pci_suspend(struct ath11k_base *ab)
+{
+	return ath11k_core_suspend(ab);
+}
+
+static int ath11k_pci_resume(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);
+
+	ar_pci->register_window = 0;
+
+	return ath11k_core_resume(ab);
+}
+
+static __maybe_unused int ath11k_pci_pm_suspend(struct device *dev)
+{
+	struct ath11k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath11k_pci_suspend(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
+
+	return ret;
+}
+
+static __maybe_unused int ath11k_pci_pm_resume(struct device *dev)
+{
+	struct ath11k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath11k_pci_resume(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to resume hif: %d\n", ret);
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
+
 };
 
 static int ath11k_pci_init(void)
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c2b1651..868ddd1 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2612,12 +2612,22 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			ath11k_qmi_event_load_bdf(qmi);
 			break;
 		case ATH11K_QMI_EVENT_FW_READY:
-			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
+			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags) &&
+			    !test_bit(ATH11K_FLAG_CORE_STARTING, &ab->dev_flags)) {
 				ath11k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
 				break;
 			}
 
+			/* mac_op_stop and then mac_op_start on non-wow
+			 * case, need to clear ATH11K_FLAG_CRASH_FLUSH and
+			 * ATH11K_FLAG_RECOVERY.
+			 */
+			if (test_bit(ATH11K_FLAG_CORE_STARTING, &ab->dev_flags)) {
+				clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
+				clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+			}
+
 			ath11k_core_qmi_firmware_ready(ab);
 			ab->qmi.cal_done = 1;
 			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
@@ -2674,12 +2684,17 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	return ret;
 }
 
+void ath11k_qmi_free_resource(struct ath11k_base *ab)
+{
+	ath11k_qmi_m3_free(ab);
+	ath11k_qmi_free_target_mem_chunk(ab);
+}
+
 void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 {
 	qmi_handle_release(&ab->qmi.handle);
 	cancel_work_sync(&ab->qmi.event_work);
 	destroy_workqueue(ab->qmi.event_wq);
-	ath11k_qmi_m3_free(ab);
-	ath11k_qmi_free_target_mem_chunk(ab);
+	ath11k_qmi_free_resource(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index b0a818f..3aadc4f 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -462,5 +462,6 @@ void ath11k_qmi_event_work(struct work_struct *work);
 void ath11k_qmi_msg_recv_work(struct work_struct *work);
 void ath11k_qmi_deinit_service(struct ath11k_base *ab);
 int ath11k_qmi_init_service(struct ath11k_base *ab);
+void ath11k_qmi_free_resource(struct ath11k_base *ab);
 
 #endif
-- 
2.7.4

