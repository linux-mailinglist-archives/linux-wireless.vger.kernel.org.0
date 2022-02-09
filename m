Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E24AEA11
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 07:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiBIGGI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 01:06:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiBIGAr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 01:00:47 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F74C02B64D
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 22:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644386450; x=1675922450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWBjkabdagozmH12dvklS1o6x6qX7BgdDkSpaGVrQak=;
  b=DqX+cy0ZYm4vl0ualY15NximYe/9t8hJVZBuGtzIEJfh8ukZCnv8d+7X
   HcLBBpEv/l0fPSLrXlf9WkOIRPWEXv5UJ3q76KaNphCGS0J/OrGQaWziG
   QNbw98N4RGal72LlnFdMrkW61jlS8a2sZ4WnMs89LpGQ71JA3Txa1Ct47
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 22:00:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 22:00:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:00:34 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:00:32 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 4/6] ath11k: add support for device recovery for QCA6390/WCN6855
Date:   Wed, 9 Feb 2022 01:00:10 -0500
Message-ID: <20220209060012.32478-5-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209060012.32478-1-quic_wgong@quicinc.com>
References: <20220209060012.32478-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
echo assert > /sys/kernel/debug/ath11k/wcn6855\ hw2.0/simulate_fw_crash

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

ath11k recovery success for QCA6390/WCN6855 after apply this patch.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 70 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h | 13 +++++
 drivers/net/wireless/ath/ath11k/mac.c  | 18 +++++++
 drivers/net/wireless/ath/ath11k/mhi.c  | 33 ++++++++++++
 4 files changed, 134 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7c508e9baa6d..00c83fdb0702 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1342,6 +1342,65 @@ static void ath11k_core_restart(struct work_struct *work)
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
@@ -1411,6 +1470,9 @@ EXPORT_SYMBOL(ath11k_core_deinit);
 
 void ath11k_core_free(struct ath11k_base *ab)
 {
+	flush_workqueue(ab->workqueue_aux);
+	destroy_workqueue(ab->workqueue_aux);
+
 	flush_workqueue(ab->workqueue);
 	destroy_workqueue(ab->workqueue);
 
@@ -1434,9 +1496,14 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	if (!ab->workqueue)
 		goto err_sc_free;
 
+	ab->workqueue_aux = create_singlethread_workqueue("ath11k_aux_wq");
+	if (!ab->workqueue_aux)
+		goto err_free_wq;
+
 	mutex_init(&ab->core_lock);
 	spin_lock_init(&ab->base_lock);
 	mutex_init(&ab->vdev_id_11d_lock);
+	init_completion(&ab->reset_complete);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
@@ -1445,6 +1512,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	INIT_WORK(&ab->update_11d_work, ath11k_update_11d);
 	INIT_WORK(&ab->rfkill_work, ath11k_rfkill_work);
+	INIT_WORK(&ab->reset_work, ath11k_core_reset);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
@@ -1455,6 +1523,8 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 
 	return ab;
 
+err_free_wq:
+	destroy_workqueue(ab->workqueue);
 err_sc_free:
 	kfree(ab);
 	return NULL;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 10846e9e871a..3fc49e633c29 100644
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
@@ -787,6 +791,15 @@ struct ath11k_base {
 	struct work_struct restart_work;
 	struct work_struct update_11d_work;
 	u8 new_alpha2[3];
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
index ed899055944e..c57a8f2c7820 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7860,6 +7860,8 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				enum ieee80211_reconfig_type reconfig_type)
 {
 	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	int recovery_count;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
@@ -7871,6 +7873,22 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
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
index fc3524e83e52..61d83be4841f 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -292,15 +292,48 @@ static void ath11k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
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
-- 
2.31.1

