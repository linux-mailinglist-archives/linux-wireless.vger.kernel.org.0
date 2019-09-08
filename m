Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BCFACB9B
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfIHIjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:39:13 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:51394 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfIHIjM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:39:12 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 04:39:09 EDT
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 08 Sep 2019 10:33:03 +0200
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg03-ams.qualcomm.com with ESMTP; 08 Sep 2019 10:33:00 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 02/11] wil6210: add support for pci linkdown recovery
Date:   Sun,  8 Sep 2019 11:32:46 +0300
Message-Id: <1567931575-27984-3-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some platforms can notify on pci linkdown events.
Add pci linkdown recovery flow, invoked upon pci linkdown
notification.
A new wil6210 status flag is added, wil_status_pci_linkdown, to
prevent pci suspend / resume until the recovery is completed.
After the pci link is recovered in the platform pci recovery
callback the device is being reset and the interface and AP
mode states are restored.

Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/main.c         |  31 +++++--
 drivers/net/wireless/ath/wil6210/pcie_bus.c     | 107 ++++++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/pm.c           |   6 ++
 drivers/net/wireless/ath/wil6210/wil6210.h      |   6 ++
 drivers/net/wireless/ath/wil6210/wil_platform.h |   8 ++
 5 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 173561f..0f270b8 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -533,22 +533,16 @@ bool wil_is_recovery_blocked(struct wil6210_priv *wil)
 	return no_fw_recovery && (wil->recovery_state == fw_recovery_pending);
 }
 
-static void wil_fw_error_worker(struct work_struct *work)
+void wil_fw_recovery(struct wil6210_priv *wil)
 {
-	struct wil6210_priv *wil = container_of(work, struct wil6210_priv,
-						fw_error_worker);
 	struct net_device *ndev = wil->main_ndev;
 	struct wireless_dev *wdev;
 
-	wil_dbg_misc(wil, "fw error worker\n");
+	wil_dbg_misc(wil, "fw recovery\n");
 
-	if (!ndev || !(ndev->flags & IFF_UP)) {
-		wil_info(wil, "No recovery - interface is down\n");
-		return;
-	}
 	wdev = ndev->ieee80211_ptr;
 
-	/* increment @recovery_count if less then WIL6210_FW_RECOVERY_TO
+	/* increment @recovery_count if less than WIL6210_FW_RECOVERY_TO
 	 * passed since last recovery attempt
 	 */
 	if (time_is_after_jiffies(wil->last_fw_recovery +
@@ -608,6 +602,22 @@ static void wil_fw_error_worker(struct work_struct *work)
 	rtnl_unlock();
 }
 
+static void wil_fw_error_worker(struct work_struct *work)
+{
+	struct wil6210_priv *wil = container_of(work, struct wil6210_priv,
+						fw_error_worker);
+	struct net_device *ndev = wil->main_ndev;
+
+	wil_dbg_misc(wil, "fw error worker\n");
+
+	if (!ndev || !(ndev->flags & IFF_UP)) {
+		wil_info(wil, "No recovery - interface is down\n");
+		return;
+	}
+
+	wil_fw_recovery(wil);
+}
+
 static int wil_find_free_ring(struct wil6210_priv *wil)
 {
 	int i;
@@ -720,6 +730,8 @@ int wil_priv_init(struct wil6210_priv *wil)
 
 	INIT_WORK(&wil->wmi_event_worker, wmi_event_worker);
 	INIT_WORK(&wil->fw_error_worker, wil_fw_error_worker);
+	INIT_WORK(&wil->pci_linkdown_recovery_worker,
+		  wil_pci_linkdown_recovery_worker);
 
 	INIT_LIST_HEAD(&wil->pending_wmi_ev);
 	spin_lock_init(&wil->wmi_ev_lock);
@@ -836,6 +848,7 @@ void wil_priv_deinit(struct wil6210_priv *wil)
 
 	wil_set_recovery_state(wil, fw_recovery_idle);
 	cancel_work_sync(&wil->fw_error_worker);
+	cancel_work_sync(&wil->pci_linkdown_recovery_worker);
 	wmi_event_flush(wil);
 	destroy_workqueue(wil->wq_service);
 	destroy_workqueue(wil->wmi_wq);
diff --git a/drivers/net/wireless/ath/wil6210/pcie_bus.c b/drivers/net/wireless/ath/wil6210/pcie_bus.c
index 9f5a914..cd417fa 100644
--- a/drivers/net/wireless/ath/wil6210/pcie_bus.c
+++ b/drivers/net/wireless/ath/wil6210/pcie_bus.c
@@ -296,6 +296,107 @@ static int wil_platform_rop_fw_recovery(void *wil_handle)
 	return 0;
 }
 
+void wil_pci_linkdown_recovery_worker(struct work_struct *work)
+{
+	struct wil6210_priv *wil = container_of(work, struct wil6210_priv,
+						pci_linkdown_recovery_worker);
+	int rc, i;
+	struct wil6210_vif *vif;
+	struct net_device *ndev = wil->main_ndev;
+
+	wil_dbg_misc(wil, "starting pci_linkdown recovery\n");
+
+	rtnl_lock();
+	mutex_lock(&wil->mutex);
+	down_write(&wil->mem_lock);
+	clear_bit(wil_status_fwready, wil->status);
+	set_bit(wil_status_pci_linkdown, wil->status);
+	set_bit(wil_status_resetting, wil->status);
+	up_write(&wil->mem_lock);
+
+	if (test_and_clear_bit(wil_status_napi_en, wil->status)) {
+		napi_disable(&wil->napi_rx);
+		napi_disable(&wil->napi_tx);
+	}
+
+	mutex_unlock(&wil->mutex);
+	rtnl_unlock();
+
+	mutex_lock(&wil->mutex);
+
+	mutex_lock(&wil->vif_mutex);
+	wil_p2p_stop_radio_operations(wil);
+	wil_abort_scan_all_vifs(wil, false);
+	mutex_unlock(&wil->vif_mutex);
+
+	for (i = 0; i < wil->max_vifs; i++) {
+		vif = wil->vifs[i];
+		if (vif) {
+			cancel_work_sync(&vif->disconnect_worker);
+			wil6210_disconnect(vif, NULL,
+					   WLAN_REASON_DEAUTH_LEAVING);
+		}
+	}
+
+	wmi_event_flush(wil);
+	flush_workqueue(wil->wq_service);
+	flush_workqueue(wil->wmi_wq);
+
+	/* Recover PCIe */
+	if (wil->platform_ops.pci_linkdown_recovery) {
+		rc = wil->platform_ops.pci_linkdown_recovery(
+			wil->platform_handle);
+		if (rc) {
+			wil_err(wil,
+				"platform device failed to recover from pci linkdown (%d)\n",
+				rc);
+			goto out;
+		}
+	} else {
+		wil_err(wil,
+			"platform device doesn't support pci_linkdown recovery\n");
+		goto out;
+	}
+
+	if (!ndev || !(ndev->flags & IFF_UP)) {
+		wil_reset(wil, false);
+		mutex_unlock(&wil->mutex);
+	} else {
+		mutex_unlock(&wil->mutex);
+		wil->recovery_state = fw_recovery_pending;
+		wil_fw_recovery(wil);
+	}
+
+	return;
+
+out:
+	mutex_unlock(&wil->mutex);
+}
+
+static int wil_platform_rop_notify(void *wil_handle,
+				   enum wil_platform_notif notif)
+{
+	struct wil6210_priv *wil = wil_handle;
+
+	if (!wil)
+		return -EINVAL;
+
+	switch (notif) {
+	case WIL_PLATFORM_NOTIF_PCI_LINKDOWN:
+		wil_info(wil, "received WIL_PLATFORM_NOTIF_PCI_LINKDOWN\n");
+		clear_bit(wil_status_fwready, wil->status);
+		set_bit(wil_status_resetting, wil->status);
+		set_bit(wil_status_pci_linkdown, wil->status);
+
+		schedule_work(&wil->pci_linkdown_recovery_worker);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static void wil_platform_ops_uninit(struct wil6210_priv *wil)
 {
 	if (wil->platform_ops.uninit)
@@ -311,6 +412,7 @@ static int wil_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	const struct wil_platform_rops rops = {
 		.ramdump = wil_platform_rop_ramdump,
 		.fw_recovery = wil_platform_rop_fw_recovery,
+		.notify = wil_platform_rop_notify,
 	};
 	u32 bar_size = pci_resource_len(pdev, 0);
 	int dma_addr_size[] = {64, 48, 40, 32}; /* keep descending order */
@@ -548,6 +650,11 @@ static int wil6210_resume(struct device *dev, bool is_runtime)
 	struct wil6210_priv *wil = pci_get_drvdata(pdev);
 	bool keep_radio_on, active_ifaces;
 
+	if (test_bit(wil_status_pci_linkdown, wil->status)) {
+		wil_dbg_pm(wil, "ignore resume during pci linkdown\n");
+		return 0;
+	}
+
 	wil_dbg_pm(wil, "resume: %s\n", is_runtime ? "runtime" : "system");
 
 	mutex_lock(&wil->vif_mutex);
diff --git a/drivers/net/wireless/ath/wil6210/pm.c b/drivers/net/wireless/ath/wil6210/pm.c
index 56143e7..bc642d0 100644
--- a/drivers/net/wireless/ath/wil6210/pm.c
+++ b/drivers/net/wireless/ath/wil6210/pm.c
@@ -101,6 +101,12 @@ int wil_can_suspend(struct wil6210_priv *wil, bool is_runtime)
 		goto out;
 	}
 
+	if (test_bit(wil_status_pci_linkdown, wil->status)) {
+		wil_dbg_pm(wil, "Delay suspend during pci linkdown\n");
+		rc = -EBUSY;
+		goto out;
+	}
+
 	mutex_lock(&wil->vif_mutex);
 	active_ifaces = wil_has_active_ifaces(wil, true, false);
 	mutex_unlock(&wil->vif_mutex);
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index ecda3ca..6463310 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -661,6 +661,7 @@ enum { /* for wil6210_priv.status */
 	wil_status_suspending, /* suspend in progress */
 	wil_status_suspended, /* suspend completed, device is suspended */
 	wil_status_resuming, /* resume in progress */
+	wil_status_pci_linkdown, /* pci linkdown occurred */
 	wil_status_last /* keep last */
 };
 
@@ -1059,6 +1060,8 @@ struct wil6210_priv {
 
 	u32 max_agg_wsize;
 	u32 max_ampdu_size;
+
+	struct work_struct pci_linkdown_recovery_worker;
 };
 
 #define wil_to_wiphy(i) (i->wiphy)
@@ -1354,6 +1357,9 @@ void wil6210_disconnect_complete(struct wil6210_vif *vif, const u8 *bssid,
 
 void wil_init_txrx_ops(struct wil6210_priv *wil);
 
+void wil_fw_recovery(struct wil6210_priv *wil);
+void wil_pci_linkdown_recovery_worker(struct work_struct *work);
+
 /* TX API */
 int wil_ring_init_tx(struct wil6210_vif *vif, int cid);
 int wil_vring_init_bcast(struct wil6210_vif *vif, int id, int size);
diff --git a/drivers/net/wireless/ath/wil6210/wil_platform.h b/drivers/net/wireless/ath/wil6210/wil_platform.h
index bca0906..20f69e8 100644
--- a/drivers/net/wireless/ath/wil6210/wil_platform.h
+++ b/drivers/net/wireless/ath/wil6210/wil_platform.h
@@ -27,6 +27,10 @@ enum wil_platform_event {
 	WIL_PLATFORM_EVT_POST_SUSPEND = 4,
 };
 
+enum wil_platform_notif {
+	WIL_PLATFORM_NOTIF_PCI_LINKDOWN = 0,
+};
+
 enum wil_platform_features {
 	WIL_PLATFORM_FEATURE_FW_EXT_CLK_CONTROL = 0,
 	WIL_PLATFORM_FEATURE_TRIPLE_MSI = 1,
@@ -52,6 +56,7 @@ struct wil_platform_ops {
 	int (*notify)(void *handle, enum wil_platform_event evt);
 	int (*get_capa)(void *handle);
 	void (*set_features)(void *handle, int features);
+	int (*pci_linkdown_recovery)(void *handle);
 };
 
 /**
@@ -63,10 +68,13 @@ struct wil_platform_ops {
  * @fw_recovery: start a firmware recovery process. Called as
  *      part of a crash recovery process which may include other
  *      related platform subsystems.
+ * @notify: get notifications from the Platform driver, such as
+ *      pci linkdown
  */
 struct wil_platform_rops {
 	int (*ramdump)(void *wil_handle, void *buf, uint32_t size);
 	int (*fw_recovery)(void *wil_handle);
+	int (*notify)(void *wil_handle, enum wil_platform_notif notif);
 };
 
 /**
-- 
1.9.1

