Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE027E80AF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbjKJSRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346158AbjKJSQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB9D28137
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 02:22:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFE1C433C9;
        Fri, 10 Nov 2023 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611735;
        bh=AcaHk0PrJK2dVjgoMo1xYXTH/me0LFjBYaxYXi9UtEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXuMHCF4l6JZDfRZh5Tozne+u7/feFfCqcI/HMptaLB/WJ6Ue6T/xujgBbmA1Ptgk
         8KTz28GT7qMtE+BZEyneo+RxGE30DCVCVUN7z7hcnFPTjILNGDpJoqud65NcDVoI/y
         8uWptJ96jm77hMKqr6i4NJJePF316VRGwyNEXgFoEsD8utKTpV+Z2EcjL7LRREE2Bc
         pZvFxAY+eKgKvZBawnCsEYIw8H3eb4XMESUYR59Ndn+jDINy9G+xlrQUmrlVy9S/xx
         V+M7lKbqzcLq1Edi3lPIbZtqTiRa93DgF9Wi+0rLx0kLg1GzHGeiYfWKLKVkZgcbLn
         TuondUOFTwrQg==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 8/8] wifi: ath11k: support hibernation
Date:   Fri, 10 Nov 2023 12:22:02 +0200
Message-Id: <20231110102202.3168243-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110102202.3168243-1-kvalo@kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <quic_bqiang@quicinc.com>

Now that all infrastructure is in place and ath11k is fixed to handle all the
corner cases, power down the ath11k firmware during suspend and power it back
up during resume. This fixes the problem when using hibernation with ath11k PCI
devices.

Change to use ath11k_hif_power_down() instead of ath11k_hif_suspend()
in suspend callback and to use ath11k_hif_power_up() instead of
ath11k_hif_resume() in resume callback.

In ath11k_hif_power_down(), we reset MHI channels to keep from unexpected
activities, and last we go PCI power down path to completely reset whole
hardware. Most importantly in power down path, we tell mhi_power_down() to not
to destroy MHI devices, making us get rid of the probe-defer issue when resume.

In ath11k_hif_power_up(), we go normal PCI power up path to download firmware
etc. Since MHI channels are not activated automatically, we do it manually as
the last part.

Also change related code due to interface changes.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  8 ++--
 drivers/net/wireless/ath/ath11k/core.c | 34 ++++++++--------
 drivers/net/wireless/ath/ath11k/core.h |  2 +
 drivers/net/wireless/ath/ath11k/hif.h  | 12 +++---
 drivers/net/wireless/ath/ath11k/mhi.c  | 21 +++++++++-
 drivers/net/wireless/ath/ath11k/mhi.h  |  4 +-
 drivers/net/wireless/ath/ath11k/pci.c  | 55 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/qmi.c  |  4 +-
 8 files changed, 103 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 235336ef2a7a..155ab9897bff 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -401,7 +401,7 @@ static void ath11k_ahb_stop(struct ath11k_base *ab)
 	ath11k_ce_cleanup_pipes(ab);
 }
 
-static int ath11k_ahb_power_up(struct ath11k_base *ab)
+static int ath11k_ahb_power_up(struct ath11k_base *ab, bool is_resume)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 	int ret;
@@ -413,11 +413,11 @@ static int ath11k_ahb_power_up(struct ath11k_base *ab)
 	return ret;
 }
 
-static void ath11k_ahb_power_down(struct ath11k_base *ab)
+static int ath11k_ahb_power_down(struct ath11k_base *ab, bool is_suspend)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 
-	rproc_shutdown(ab_ahb->tgt_rproc);
+	return rproc_shutdown(ab_ahb->tgt_rproc);
 }
 
 static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
@@ -1256,7 +1256,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_ahb_power_down(ab);
+		ath11k_ahb_power_down(ab, false);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index fbd6b6a0e12c..0e0b02692282 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -800,12 +800,6 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ret = ath11k_wow_enable(ab);
-	if (ret) {
-		ath11k_warn(ab, "failed to enable wow during suspend: %d\n", ret);
-		return ret;
-	}
-
 	ret = ath11k_dp_rx_pktlog_stop(ab, false);
 	if (ret) {
 		ath11k_warn(ab, "failed to stop dp rx pktlog during suspend: %d\n",
@@ -819,7 +813,7 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ret = ath11k_hif_suspend(ab);
+	ret = ath11k_hif_power_down(ab, true);
 	if (ret) {
 		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
 		return ret;
@@ -834,6 +828,7 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	int ret;
 	struct ath11k_pdev *pdev;
 	struct ath11k *ar;
+	long time_left;
 
 	if (!ab->hw_params.supports_suspend)
 		return -EOPNOTSUPP;
@@ -846,11 +841,18 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	if (!ar || ar->state != ATH11K_STATE_OFF)
 		return 0;
 
-	ret = ath11k_hif_resume(ab);
+	reinit_completion(&ab->restart_completed);
+	ret = ath11k_hif_power_up(ab, true);
 	if (ret) {
 		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
 		return ret;
 	}
+	time_left = wait_for_completion_timeout(&ab->restart_completed,
+						ATH11K_RESET_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath11k_warn(ab, "timeout while waiting for restart complete");
+		return -ETIMEDOUT;
+	}
 
 	ret = ath11k_dp_rx_pktlog_start(ab);
 	if (ret) {
@@ -859,12 +861,6 @@ int ath11k_core_resume(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ret = ath11k_wow_wakeup(ab);
-	if (ret) {
-		ath11k_warn(ab, "failed to wakeup wow during resume: %d\n", ret);
-		return ret;
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL(ath11k_core_resume);
@@ -1488,7 +1484,7 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 		goto err_qmi_deinit;
 	}
 
-	ret = ath11k_hif_power_up(ab);
+	ret = ath11k_hif_power_up(ab, false);
 	if (ret) {
 		ath11k_err(ab, "failed to power up :%d\n", ret);
 		goto err_debugfs_reg;
@@ -1963,6 +1959,8 @@ static void ath11k_core_restart(struct work_struct *work)
 
 	if (!ab->is_reset)
 		ath11k_core_post_reconfigure_recovery(ab);
+
+	complete(&ab->restart_completed);
 }
 
 static void ath11k_core_reset(struct work_struct *work)
@@ -2032,6 +2030,9 @@ static void ath11k_core_reset(struct work_struct *work)
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
+	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_up(ab, false);
+
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
 }
 
@@ -2102,7 +2103,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 
 	mutex_unlock(&ab->core_lock);
 
-	ath11k_hif_power_down(ab);
+	ath11k_hif_power_down(ab, false);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 	ath11k_fw_destroy(ab);
@@ -2155,6 +2156,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
+	init_completion(&ab->restart_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index f12b606e2d2e..444f5d95acea 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -996,6 +996,8 @@ struct ath11k_base {
 		DECLARE_BITMAP(fw_features, ATH11K_FW_FEATURE_COUNT);
 	} fw;
 
+	struct completion restart_completed;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 data_pos;
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index d68ed4214dec..7f08591ed5c8 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -16,8 +16,8 @@ struct ath11k_hif_ops {
 	void (*irq_disable)(struct ath11k_base *ab);
 	int (*start)(struct ath11k_base *ab);
 	void (*stop)(struct ath11k_base *ab);
-	int (*power_up)(struct ath11k_base *ab);
-	void (*power_down)(struct ath11k_base *ab);
+	int (*power_up)(struct ath11k_base *ab, bool is_resume);
+	int (*power_down)(struct ath11k_base *ab, bool is_suspend);
 	int (*suspend)(struct ath11k_base *ab);
 	int (*resume)(struct ath11k_base *ab);
 	int (*map_service_to_pipe)(struct ath11k_base *ab, u16 service_id,
@@ -64,14 +64,14 @@ static inline void ath11k_hif_irq_disable(struct ath11k_base *ab)
 	ab->hif.ops->irq_disable(ab);
 }
 
-static inline int ath11k_hif_power_up(struct ath11k_base *ab)
+static inline int ath11k_hif_power_up(struct ath11k_base *ab, bool is_resume)
 {
-	return ab->hif.ops->power_up(ab);
+	return ab->hif.ops->power_up(ab, is_resume);
 }
 
-static inline void ath11k_hif_power_down(struct ath11k_base *ab)
+static inline int ath11k_hif_power_down(struct ath11k_base *ab, bool is_resume)
 {
-	ab->hif.ops->power_down(ab);
+	return ab->hif.ops->power_down(ab, is_resume);
 }
 
 static inline int ath11k_hif_suspend(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index d4fe1d1c86e4..76c67bdf48a1 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -469,9 +469,16 @@ int ath11k_mhi_start(struct ath11k_pci *ab_pci)
 	return 0;
 }
 
-void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
+void ath11k_mhi_stop(struct ath11k_pci *ab_pci, bool is_suspend)
 {
-	mhi_power_down(ab_pci->mhi_ctrl, true);
+	/* During suspend we need to use mhi_power_down_no_destroy()
+	 * workaround, otherwise mhi_power_up() will fail during resume.
+	 */
+	if (is_suspend)
+		mhi_power_down_no_destroy(ab_pci->mhi_ctrl, true);
+	else
+		mhi_power_down(ab_pci->mhi_ctrl, true);
+
 	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
 }
 
@@ -506,3 +513,13 @@ int ath11k_mhi_resume(struct ath11k_pci *ab_pci)
 
 	return 0;
 }
+
+int ath11k_mhi_prepare_for_transfer(struct ath11k_pci *ab_pci)
+{
+	return mhi_prepare_all_for_transfer_autoqueue(ab_pci->mhi_ctrl);
+}
+
+int ath11k_mhi_unprepare_from_transfer(struct ath11k_pci *ab_pci)
+{
+	return mhi_unprepare_all_from_transfer(ab_pci->mhi_ctrl);
+}
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index 8d9f852da695..80902fda5842 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -17,7 +17,7 @@
 #define MHICTRL_RESET_MASK			0x2
 
 int ath11k_mhi_start(struct ath11k_pci *ar_pci);
-void ath11k_mhi_stop(struct ath11k_pci *ar_pci);
+void ath11k_mhi_stop(struct ath11k_pci *ar_pci, bool is_suspend);
 int ath11k_mhi_register(struct ath11k_pci *ar_pci);
 void ath11k_mhi_unregister(struct ath11k_pci *ar_pci);
 void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab);
@@ -26,4 +26,6 @@ void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
 int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
 
+int ath11k_mhi_prepare_for_transfer(struct ath11k_pci *ar_pci);
+int ath11k_mhi_unprepare_from_transfer(struct ath11k_pci *ar_pci);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 09e65c5e55c4..3d6195bc6f55 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -625,7 +625,7 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	return 0;
 }
 
-static void ath11k_pci_power_down(struct ath11k_base *ab)
+static void ath11k_pci_power_down(struct ath11k_base *ab, bool is_suspend)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
@@ -636,11 +636,54 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 
 	ath11k_pci_msi_disable(ab_pci);
 
-	ath11k_mhi_stop(ab_pci);
+	ath11k_mhi_stop(ab_pci, is_suspend);
 	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
 
+static int ath11k_pci_hif_power_down(struct ath11k_base *ab, bool is_suspend)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	int ret;
+
+	if (is_suspend) {
+		ret = ath11k_mhi_unprepare_from_transfer(ab_pci);
+		if (ret) {
+			ath11k_err(ab_pci->ab, "failed to unprepare from transfer %d\n",
+				   ret);
+			return ret;
+		}
+	}
+
+	ath11k_pci_power_down(ab, is_suspend);
+	return 0;
+}
+
+static int ath11k_pci_hif_power_up(struct ath11k_base *ab, bool is_resume)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	int ret;
+
+	ret =  ath11k_pci_power_up(ab);
+	if (ret) {
+		ath11k_err(ab_pci->ab, "failed to power up %d\n", ret);
+		return ret;
+	}
+
+	if (is_resume) {
+		/* sleep for 500ms to let mhi_pm_mission_mode_transition()
+		 * finishes, or we may be wake up immediately after mission
+		 * mode event received and call
+		 * ath11k_mhi_prepare_for_transfer(), while bottom half of
+		 * mhi_pm_mission_mode_transition() does not finish.
+		 */
+		msleep(500);
+		ret = ath11k_mhi_prepare_for_transfer(ab_pci);
+	}
+
+	return ret;
+}
+
 static int ath11k_pci_hif_suspend(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);
@@ -688,8 +731,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.read32 = ath11k_pcic_read32,
 	.write32 = ath11k_pcic_write32,
 	.read = ath11k_pcic_read,
-	.power_down = ath11k_pci_power_down,
-	.power_up = ath11k_pci_power_up,
+	.power_down = ath11k_pci_hif_power_down,
+	.power_up = ath11k_pci_hif_power_up,
 	.suspend = ath11k_pci_hif_suspend,
 	.resume = ath11k_pci_hif_resume,
 	.irq_enable = ath11k_pcic_ext_irq_enable,
@@ -938,7 +981,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_pci_power_down(ab);
+		ath11k_pci_power_down(ab, false);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
@@ -966,7 +1009,7 @@ static void ath11k_pci_shutdown(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	ath11k_pci_power_down(ab);
+	ath11k_pci_power_down(ab, false);
 }
 
 static __maybe_unused int ath11k_pci_pm_suspend(struct device *dev)
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 97a74563d4a6..7d856d8b7f89 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2877,8 +2877,8 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
 	}
 
 	/* reset the firmware */
-	ath11k_hif_power_down(ab);
-	ath11k_hif_power_up(ab);
+	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_up(ab, false);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "exit wait for cold boot done\n");
 	return 0;
 }
-- 
2.39.2

