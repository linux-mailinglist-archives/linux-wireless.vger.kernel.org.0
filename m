Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819A245290E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 05:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbhKPEUm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 23:20:42 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34059 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242934AbhKPESn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 23:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637036147; x=1668572147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o9LFXsp5D6UHurkwDfJQ3ZDpDitn+LVXEXR+RyC/f48=;
  b=bR5YHCUvFHoJo/B+yzZJtsIFKRrrLe3mVe0urSJzCt7tlmcOgWZ1BzpY
   vTALYbnkM9Xd1qP73sSMq39VF7ayrOgGlOj/S2/xTN9STrKkDPbgVrtEp
   y282JPo/VuU9x7d/vMYaoIXxs2WBCIuPOy9MdpQ9WaIGAIJWQAh29Opqs
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Nov 2021 20:15:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 20:15:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 20:15:42 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 20:15:41 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v4 3/4] ath11k: add support for device recovery for QCA6390
Date:   Mon, 15 Nov 2021 23:15:21 -0500
Message-ID: <20211116041522.23529-4-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116041522.23529-1-quic_wgong@quicinc.com>
References: <20211116041522.23529-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ath11k has device recovery logic, it is introduced by this
patch "ath11k: Add support for subsystem recovery" which is upstream
by https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath11k-bringup&id=3a7b4838b6f6f234239f263ef3dc02e612a083ad.

The patch is for AHB devices such as IPQ8074, it has remote proc module
which is used to download the firmware and boots the processor which
firmware is running on. If firmware crashed, remote proc module will
detect it and download and boot firmware again. Below command will
trigger a firmware crash, and then user can test feature of device
recovery.

Test command:
echo assert > /sys/kernel/debug/ath11k/qca6390\ hw2.0/simulate_fw_crash

Unfortunately, QCA6390 is PCIe bus, it does not have the remote proc
module, it use mhi module to communicate between firmware and ath11k.
So ath11k does not support device recovery for QCA6390 currently.

This patch is to add the extra logic which is different for QCA6390.
When firmware crashed, MHI_CB_EE_RDDM event will be indicate by
firmware and then ath11k_mhi_op_status_cb which is the callback of
mhi_controller will receive the MHI_CB_EE_RDDM event, then ath11k
will start to do recovery process, ath11k_core_reset() calls
ath11k_hif_power_down()/ath11k_hif_power_up(), then the mhi/ath11k
will start to download and boot firmware. There are some logic to
avoid deadloop recovery and two simultaneous recovery operations.
And because it has muti-radios for the soc, so it add some logic
in ath11k_mac_op_reconfig_complete() to make sure all radios has
reconfig complete and then complete the device recovery.

Also it add workqueue_aux, because ab->workqueue is used when receive
ATH11K_QMI_EVENT_FW_READY in recovery process(queue_work(ab->workqueue,
&ab->restart_work)), and ath11k_core_reset will wait for max
ATH11K_RESET_TIMEOUT_HZ for the previous restart_work finished, if
ath11k_core_reset also queued in ab->workqueue, then it will delay
restart_work of previous recovery and lead previous recovery fail.

ath11k recovery success for QCA6390 after apply this patch.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 67 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h | 13 +++++
 drivers/net/wireless/ath/ath11k/mac.c  | 18 +++++++
 drivers/net/wireless/ath/ath11k/mhi.c  | 33 +++++++++++++
 drivers/net/wireless/ath/ath11k/pci.c  |  3 ++
 5 files changed, 134 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 969bf1a590d9..be788ec08200 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1043,6 +1043,65 @@ static void ath11k_core_restart(struct work_struct *work)
 	complete(&ab->driver_recovery);
 }
 
+static void ath11k_core_reset(struct work_struct *work)
+{
+	struct ath11k_base *ab = container_of(work, struct ath11k_base, reset_work);
+	int reset_count, fail_cont_count;
+	long time_left;
+
+	if (!(test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))) {
+		ath11k_warn(ab, "ignore reset dev flags 0x%lx\n", ab->dev_flags);
+		return;
+	}
+
+	/* Sometimes the recovery will fail and then the next all recovery fail,
+	 * this is to avoid infinite recovery since it can not recovery success.
+	 */
+	fail_cont_count = atomic_read(&ab->fail_cont_count);
+
+	if (fail_cont_count >= ATH11K_RESET_MAX_FAIL_COUNT_FINAL)
+		return;
+
+	if (fail_cont_count >= ATH11K_RESET_MAX_FAIL_COUNT_FIRST &&
+	    time_before(jiffies, ab->reset_fail_timeout))
+		return;
+
+	reset_count = atomic_inc_return(&ab->reset_count);
+
+	if (reset_count > 1) {
+		/* Sometimes it happened another reset worker before the previous one
+		 * completed, then the second reset worker will destroy the previous one,
+		 * thus below is to avoid that.
+		 */
+		ath11k_warn(ab, "already reseting count %d\n", reset_count);
+
+		reinit_completion(&ab->reset_complete);
+		time_left = wait_for_completion_timeout(&ab->reset_complete,
+							ATH11K_RESET_TIMEOUT_HZ);
+
+		if (time_left) {
+			ath11k_dbg(ab, ATH11K_DBG_BOOT, "to skip reset\n");
+			atomic_dec(&ab->reset_count);
+			return;
+		}
+
+		ab->reset_fail_timeout = jiffies + ATH11K_RESET_FAIL_TIMEOUT_HZ;
+		/* Record the continuous recovery fail count when recovery failed*/
+		fail_cont_count = atomic_inc_return(&ab->fail_cont_count);
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset starting\n");
+
+	ab->is_reset = true;
+	atomic_set(&ab->recovery_count, 0);
+
+	ath11k_hif_power_down(ab);
+	ath11k_qmi_free_resource(ab);
+	ath11k_hif_power_up(ab);
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
+}
+
 static int ath11k_init_hw_params(struct ath11k_base *ab)
 {
 	const struct ath11k_hw_params *hw_params = NULL;
@@ -1132,14 +1191,20 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	if (!ab->workqueue)
 		goto err_sc_free;
 
+	ab->workqueue_aux = create_singlethread_workqueue("ath11k_aux_wq");
+	if (!ab->workqueue_aux)
+		goto err_free_wq;
+
 	mutex_init(&ab->core_lock);
 	spin_lock_init(&ab->base_lock);
+	init_completion(&ab->reset_complete);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
 	init_waitqueue_head(&ab->wmi_ab.tx_credits_wq);
 	init_waitqueue_head(&ab->qmi.cold_boot_waitq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
+	INIT_WORK(&ab->reset_work, ath11k_core_reset);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
@@ -1150,6 +1215,8 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 
 	return ab;
 
+err_free_wq:
+	destroy_workqueue(ab->workqueue);
 err_sc_free:
 	kfree(ab);
 	return NULL;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 018fb2385f2a..9a9f8f24d407 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -39,6 +39,10 @@
 extern unsigned int ath11k_frame_mode;
 
 #define ATH11K_MON_TIMER_INTERVAL  10
+#define ATH11K_RESET_TIMEOUT_HZ (20 * HZ)
+#define ATH11K_RESET_MAX_FAIL_COUNT_FIRST 3
+#define ATH11K_RESET_MAX_FAIL_COUNT_FINAL 5
+#define ATH11K_RESET_FAIL_TIMEOUT_HZ (20 * HZ)
 
 enum ath11k_supported_bw {
 	ATH11K_BW_20	= 0,
@@ -734,6 +738,15 @@ struct ath11k_base {
 	struct completion driver_recovery;
 	struct workqueue_struct *workqueue;
 	struct work_struct restart_work;
+	struct workqueue_struct *workqueue_aux;
+	struct work_struct reset_work;
+	atomic_t reset_count;
+	atomic_t recovery_count;
+	bool is_reset;
+	struct completion reset_complete;
+	/* continuous recovery fail count */
+	atomic_t fail_cont_count;
+	unsigned long reset_fail_timeout;
 	struct {
 		/* protected by data_lock */
 		u32 fw_crash_counter;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index eb52332dbe3f..b0a2f257f328 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6032,6 +6032,8 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				enum ieee80211_reconfig_type reconfig_type)
 {
 	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	int recovery_count;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
@@ -6043,6 +6045,22 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			    ar->pdev->pdev_id);
 		ar->state = ATH11K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
+
+		if (ab->is_reset) {
+			recovery_count = atomic_inc_return(&ab->recovery_count);
+			ath11k_dbg(ab, ATH11K_DBG_BOOT,
+				   "recovery count %d\n", recovery_count);
+			/* When there are multiple radios in an SOC,
+			 * the recovery has to be done for each radio
+			 */
+			if (recovery_count == ab->num_radios) {
+				atomic_dec(&ab->reset_count);
+				complete(&ab->reset_complete);
+				ab->is_reset = false;
+				atomic_set(&ab->fail_cont_count, 0);
+				ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset success\n");
+			}
+		}
 	}
 
 	mutex_unlock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 75cc2d80fde8..aea21ea2ca47 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -281,15 +281,48 @@ static void ath11k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
 {
 }
 
+static char *ath11k_mhi_op_callback_to_str(enum mhi_callback reason)
+{
+	switch (reason) {
+	case MHI_CB_IDLE:
+		return "MHI_CB_IDLE";
+	case MHI_CB_PENDING_DATA:
+		return "MHI_CB_PENDING_DATA";
+	case MHI_CB_LPM_ENTER:
+		return "MHI_CB_LPM_ENTER";
+	case MHI_CB_LPM_EXIT:
+		return "MHI_CB_LPM_EXIT";
+	case MHI_CB_EE_RDDM:
+		return "MHI_CB_EE_RDDM";
+	case MHI_CB_EE_MISSION_MODE:
+		return "MHI_CB_EE_MISSION_MODE";
+	case MHI_CB_SYS_ERROR:
+		return "MHI_CB_SYS_ERROR";
+	case MHI_CB_FATAL_ERROR:
+		return "MHI_CB_FATAL_ERROR";
+	case MHI_CB_BW_REQ:
+		return "MHI_CB_BW_REQ";
+	default:
+		return "UNKNOWN";
+	}
+};
+
 static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 				    enum mhi_callback cb)
 {
 	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
 
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "mhi notify status reason %s\n",
+		   ath11k_mhi_op_callback_to_str(cb));
+
 	switch (cb) {
 	case MHI_CB_SYS_ERROR:
 		ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
 		break;
+	case MHI_CB_EE_RDDM:
+		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
+			queue_work(ab->workqueue_aux, &ab->reset_work);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 646ad79f309c..1f8e3837cdfb 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1346,6 +1346,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 
+	cancel_work_sync(&ab->reset_work);
 	ath11k_core_deinit(ab);
 
 qmi_fail:
@@ -1357,6 +1358,8 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 
 	ath11k_hal_srng_deinit(ab);
 	ath11k_ce_free_pipes(ab);
+
+	destroy_workqueue(ab->workqueue_aux);
 	ath11k_core_free(ab);
 }
 
-- 
2.31.1

