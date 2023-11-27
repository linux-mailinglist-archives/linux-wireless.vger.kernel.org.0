Return-Path: <linux-wireless+bounces-108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A827FA629
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA22817F7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209AA36B09;
	Mon, 27 Nov 2023 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZkJKFT4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5B364D7;
	Mon, 27 Nov 2023 16:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB99C433C7;
	Mon, 27 Nov 2023 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102026;
	bh=YAdkjq83QHNmK1xM3DlfzXQzyIjuMXcCdzBqx4MLxSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZkJKFT4s0YdXmb6Wctps9iT0fdI769gub61B9SVDV5vSTqOgEOtb8b/d3SqBxHds
	 a4WA6ZgUX1GV87Hq4mItxwNKHVOZ6+X+i5Mv+WUioAOLly/Gl6uygSjRcvhykJFiJO
	 WqF0PvYV9SGNQXO0i9YHKuBgSto3s5Y/79MbEyMvXh6NUIikJjvso3CYko61MU9F7X
	 D/OcHcGaynRHZsEJkvU6WzeK/mTSP64iInO1OW+nWJq/vKM3lEnp0uWoZNDYmyRa4t
	 XOZRzP9sd67HUuFjuIR7m/gMLa7K7mDdh7y2ybt+D+IoUnNe86R6lOzKMI6LJWDnfq
	 +vUSx5F2rHjyg==
From: Kalle Valo <kvalo@kernel.org>
To: mhi@lists.linux.dev
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 1/8] bus: mhi: host: add mhi_power_down_no_destroy()
Date: Mon, 27 Nov 2023 18:20:15 +0200
Message-Id: <20231127162022.518834-2-kvalo@kernel.org>
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

If ath11k tries to call mhi_power_up() during resume it fails:

ath11k_pci 0000:06:00.0: timeout while waiting for restart complete

This happens because when calling mhi_power_up() the MHI subsystem eventually
calls device_add() from mhi_create_devices() but the device creation is
deferred:

mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral

The reason for deferring device creation is explained in dpm_prepare():

	/*
	 * It is unsafe if probing of devices will happen during suspend or
	 * hibernation and system behavior will be unpredictable in this case.
	 * So, let's prohibit device's probing here and defer their probes
	 * instead. The normal behavior will be restored in dpm_complete().
	 */

Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not called and
qcom_mhi_qrtr_dl_callback() fails silently as qdev is zero:

static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
				      struct mhi_result *mhi_res)
{
	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
	int rc;

	if (!qdev || mhi_res->transaction_status)
		return;

So what this means that QRTR is not delivering messages and the QMI connection
is not working between ath11k and the firmware, resulting a failure in firmware
initialisation.

To fix this add new function mhi_power_down_no_destroy() which does not destroy
the devices during power down. This way mhi_power_up() can be called during
resume and we can get ath11k hibernation working with the following patches.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/bus/mhi/host/init.c     |  1 +
 drivers/bus/mhi/host/internal.h |  1 +
 drivers/bus/mhi/host/pm.c       | 26 +++++++++++++++++++-------
 include/linux/mhi.h             | 29 +++++++++++++++++++++++++++--
 4 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 65ceac1837f9..e626b03ffafa 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -43,6 +43,7 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
 	[DEV_ST_TRANSITION_FP] = "FLASH PROGRAMMER",
 	[DEV_ST_TRANSITION_SYS_ERR] = "SYS ERROR",
 	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
+	[DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE] = "DISABLE (DESTROY DEVICE)",
 };
 
 const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 30ac415a3000..3f45c9c447bd 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -69,6 +69,7 @@ enum dev_st_transition {
 	DEV_ST_TRANSITION_FP,
 	DEV_ST_TRANSITION_SYS_ERR,
 	DEV_ST_TRANSITION_DISABLE,
+	DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE,
 	DEV_ST_TRANSITION_MAX,
 };
 
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index a2f2feef1476..8833b0248393 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -458,7 +458,8 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
 }
 
 /* Handle shutdown transitions */
-static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
+static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
+				      bool destroy_device)
 {
 	enum mhi_pm_state cur_state;
 	struct mhi_event *mhi_event;
@@ -520,8 +521,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 	dev_dbg(dev, "Waiting for all pending threads to complete\n");
 	wake_up_all(&mhi_cntrl->state_event);
 
-	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
-	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
+	if (destroy_device) {
+		dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
+		device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
+	}
 
 	mutex_lock(&mhi_cntrl->pm_mutex);
 
@@ -806,7 +809,10 @@ void mhi_pm_st_worker(struct work_struct *work)
 			mhi_pm_sys_error_transition(mhi_cntrl);
 			break;
 		case DEV_ST_TRANSITION_DISABLE:
-			mhi_pm_disable_transition(mhi_cntrl);
+			mhi_pm_disable_transition(mhi_cntrl, false);
+			break;
+		case DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE:
+			mhi_pm_disable_transition(mhi_cntrl, true);
 			break;
 		default:
 			break;
@@ -1160,7 +1166,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_async_power_up);
 
-void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
+		      bool destroy_device)
 {
 	enum mhi_pm_state cur_state, transition_state;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -1196,14 +1203,19 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 	write_unlock_irq(&mhi_cntrl->pm_lock);
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
+	if (destroy_device)
+		mhi_queue_state_transition(mhi_cntrl,
+					   DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE);
+	else
+		mhi_queue_state_transition(mhi_cntrl,
+					   DEV_ST_TRANSITION_DISABLE);
 
 	/* Wait for shutdown to complete */
 	flush_work(&mhi_cntrl->st_worker);
 
 	disable_irq(mhi_cntrl->irq[0]);
 }
-EXPORT_SYMBOL_GPL(mhi_power_down);
+EXPORT_SYMBOL_GPL(__mhi_power_down);
 
 int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
 {
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d0f9b522f328..ae092bc8b97e 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -648,12 +648,37 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
  */
 int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
 
+void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
+		    bool destroy_device);
+
 /**
- * mhi_power_down - Start MHI power down sequence
+ * mhi_power_down - Start MHI power down sequence. See also
+ * mhi_power_down_no_destroy() which is a variant of this for suspend.
+ *
  * @mhi_cntrl: MHI controller
  * @graceful: Link is still accessible, so do a graceful shutdown process
  */
-void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
+static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+{
+	__mhi_power_down(mhi_cntrl, graceful, true);
+}
+
+/**
+ * mhi_power_down_no_destroy - Start MHI power down sequence but don't
+ * destroy struct devices. This is a variant for mhi_power_down() and is a
+ * workaround to make it possible to use mhi_power_up() in a resume
+ * handler. When using this variant the caller must also call
+ * mhi_prepare_all_for_transfer_autoqueue() and
+ * mhi_unprepare_all_from_transfer().
+ *
+ * @mhi_cntrl: MHI controller
+ * @graceful: Link is still accessible, so do a graceful shutdown process
+ */
+static inline void mhi_power_down_no_destroy(struct mhi_controller *mhi_cntrl,
+					     bool graceful)
+{
+	__mhi_power_down(mhi_cntrl, graceful, false);
+}
 
 /**
  * mhi_unprepare_after_power_down - Free any allocated memory after power down
-- 
2.39.2


