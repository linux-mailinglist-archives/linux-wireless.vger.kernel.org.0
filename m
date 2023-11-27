Return-Path: <linux-wireless+bounces-115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FE7FA636
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6EC1C20E37
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB22374D8;
	Mon, 27 Nov 2023 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWYToPUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1E3716F;
	Mon, 27 Nov 2023 16:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A4C433CB;
	Mon, 27 Nov 2023 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102035;
	bh=9oM5P+nMCCDTJaVjj1eBP9OTkAV08EbWyWVkINE81XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWYToPUy+6IDY2dl8jrLHPpE+zXhO++BojfJVtkro2DLO/t0Ny9kIzmAB2n8hsKHf
	 k2jBtiGmiIidv9nPidvZTzK8V5ril2KBXbrfYVMBquGLVDW2NanOB3nxBXLKtBUttT
	 0mlXKvnizZaarVK9sb0PkpBw2DIxMvCzYC+OmKjtNIxEvwMs/yWUjG2tGbEcqVd17c
	 B+CBHckBr9oAByM9SkPqee6n99vlAHkvsJoNuRUzkYTd9vbDpkg1Meq19myVLdwryw
	 3fnRCHpNCKpsIgsC8gGHCJ/J4tT37DNgSkCGRY/gJcC9dy8Zbvh6ytrk6UGD7HAuDQ
	 Gmuae0u0Cxz+w==
From: Kalle Valo <kvalo@kernel.org>
To: mhi@lists.linux.dev
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 8/8] wifi: ath11k: support hibernation
Date: Mon, 27 Nov 2023 18:20:22 +0200
Message-Id: <20231127162022.518834-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127162022.518834-1-kvalo@kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index f8f5e653cd03..0ff5e85392aa 100644
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
index 7e3b6779f4e9..b3816b8be934 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -995,6 +995,8 @@ struct ath11k_base {
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
index 579af57f7377..58b92f7ce2b8 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -441,9 +441,16 @@ int ath11k_mhi_start(struct ath11k_pci *ab_pci)
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
 
@@ -478,3 +485,13 @@ int ath11k_mhi_resume(struct ath11k_pci *ab_pci)
 
 	return 0;
 }
+
+int ath11k_mhi_prepare_for_transfer(struct ath11k_pci *ab_pci)
+{
+	return mhi_prepare_all_for_transfer(ab_pci->mhi_ctrl);
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


