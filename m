Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E96A4558A2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbhKRKKg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 05:10:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:64165 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245420AbhKRKJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 05:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637229976; x=1668765976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhjYBEvvk8tCfYJrDEoQrWDTu9EpI3g68lePNpAeV7o=;
  b=KZcxPoBFczM9Crwh0kMjVrclHUF95kbLGMjrATGrQdzHvJt/78CYt/BM
   RypmM978TRmdxx4Qgr6FJZyMJFfKiu7XlVw3HO2sSY2SfNrjrBokYGwCN
   6cpN3tAH56a+9Va4mlUfOrrt/x4t/Wf5LOMWNP7Ev+D05a/v2qnaQoGFN
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Nov 2021 02:06:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 02:06:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 02:06:15 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 02:06:13 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 2/2] ath11k: add 11d scan offload support
Date:   Thu, 18 Nov 2021 05:05:57 -0500
Message-ID: <20211118100557.9029-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118100557.9029-1-quic_wgong@quicinc.com>
References: <20211118100557.9029-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add handler for WMI_11D_NEW_COUNTRY_EVENTID, WMI_11D_SCAN_START_CMDID,
WMI_11D_SCAN_STOP_CMDID.

After vdev create for STATION, send WMI_11D_SCAN_START_CMDID to firmware
and wait firmware complete it, the scan from mac80211 also need to wait
the 11d scan finished, and send WMI_11D_SCAN_STOP_CMDID to firmware
before vdev delete for STATION.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  30 +++++
 drivers/net/wireless/ath/ath11k/core.h |   9 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 162 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath11k/pci.c  |   1 +
 drivers/net/wireless/ath/ath11k/reg.c  |  15 +++
 drivers/net/wireless/ath/ath11k/wmi.c  | 109 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  27 +++++
 8 files changed, 359 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a40bbca3e9af..ad0c20cbf976 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1045,6 +1045,34 @@ void ath11k_core_halt(struct ath11k *ar)
 	idr_init(&ar->txmgmt_idr);
 }
 
+static void ath11k_update_11d(struct work_struct *work)
+{
+	struct ath11k_base *ab = container_of(work, struct ath11k_base, update_11d_work);
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	struct wmi_set_current_country_params set_current_param = {};
+	int ret, i;
+
+	spin_lock_bh(&ab->base_lock);
+	memcpy(&set_current_param.alpha2, &ab->new_alpha2, 2);
+	spin_unlock_bh(&ab->base_lock);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "update 11d new cc %c%c\n",
+		   set_current_param.alpha2[0],
+		   set_current_param.alpha2[1]);
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		if (ret)
+			ath11k_warn(ar->ab,
+				    "pdev id %d failed set current country code: %d\n",
+				    i, ret);
+	}
+}
+
 static void ath11k_core_restart(struct work_struct *work)
 {
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, restart_work);
@@ -1214,12 +1242,14 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 
 	mutex_init(&ab->core_lock);
 	spin_lock_init(&ab->base_lock);
+	mutex_init(&ab->vdev_id_11d_lock);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
 	init_waitqueue_head(&ab->wmi_ab.tx_credits_wq);
 	init_waitqueue_head(&ab->qmi.cold_boot_waitq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
+	INIT_WORK(&ab->update_11d_work, ath11k_update_11d);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bbfc10fd5c6d..98986b604806 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -585,6 +585,11 @@ struct ath11k {
 #endif
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
+	u32 vdev_id_11d_scan;
+	struct completion finish_11d_scan;
+	struct completion finish_11d_ch_list;
+	bool pending_11d;
+	bool regdom_set_by_user;
 };
 
 struct ath11k_band_cap {
@@ -754,6 +759,8 @@ struct ath11k_base {
 	struct completion driver_recovery;
 	struct workqueue_struct *workqueue;
 	struct work_struct restart_work;
+	struct work_struct update_11d_work;
+	u8 new_alpha2[3];
 	struct {
 		/* protected by data_lock */
 		u32 fw_crash_counter;
@@ -763,6 +770,8 @@ struct ath11k_base {
 	struct ath11k_dbring_cap *db_caps;
 	u32 num_db_cap;
 
+	/* To synchronize 11d scan vdev id */
+	struct mutex vdev_id_11d_lock;
 	struct timer_list mon_reap_timer;
 
 	struct completion htc_suspend;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 292b2b7eab11..047783f787b5 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2584,6 +2584,8 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	if (ret)
 		ath11k_warn(ar->ab, "failed to set vdev %i OBSS PD parameters: %d\n",
 			    arvif->vdev_id, ret);
+
+	ath11k_mac_11d_scan_stop_all(ar->ab);
 }
 
 static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
@@ -3313,6 +3315,7 @@ static int ath11k_start_scan(struct ath11k *ar,
 			     struct scan_req_params *arg)
 {
 	int ret;
+	unsigned long timeout = 1 * HZ;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -3323,7 +3326,14 @@ static int ath11k_start_scan(struct ath11k *ar,
 	if (ret)
 		return ret;
 
-	ret = wait_for_completion_timeout(&ar->scan.started, 1 * HZ);
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map)) {
+		timeout = 5 * HZ;
+
+		if (ar->supports_6ghz)
+			timeout += 5 * HZ;
+	}
+
+	ret = wait_for_completion_timeout(&ar->scan.started, timeout);
 	if (ret == 0) {
 		ret = ath11k_scan_stop(ar);
 		if (ret)
@@ -3380,6 +3390,26 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;
 
+	/* Currently the pending_11d=true only happened 1 time while
+	 * wlan interface up in ath11k_mac_11d_scan_start(), it is called by
+	 * ath11k_mac_op_add_interface(), after wlan interface up,
+	 * pending_11d=false always.
+	 * If remove below wait, it always happened scan fail and lead connect
+	 * fail while wlan interface up, because it has a 11d scan which is running
+	 * in firmware, and lead this scan failed.
+	 */
+	if (ar->pending_11d) {
+		long time_left;
+		unsigned long timeout = 5 * HZ;
+
+		if (ar->supports_6ghz)
+			timeout += 5 * HZ;
+
+		time_left = wait_for_completion_timeout(&ar->finish_11d_ch_list, timeout);
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+			   "mac wait 11d channel list time left %ld\n", time_left);
+	}
+
 	memset(&arg, 0, sizeof(arg));
 	ath11k_wmi_start_scan_init(ar, &arg);
 	arg.vdev_id = arvif->vdev_id;
@@ -5677,6 +5707,122 @@ static void ath11k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	}
 }
 
+static bool ath11k_mac_vif_ap_active_any(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	struct ath11k_vif *arvif;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		list_for_each_entry(arvif, &ar->arvifs, list) {
+			if (arvif->is_up && arvif->vdev_type == WMI_VDEV_TYPE_AP)
+				return true;
+		}
+	}
+	return false;
+}
+
+void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id, bool wait)
+{
+	struct wmi_11d_scan_start_params param;
+	int ret;
+
+	mutex_lock(&ar->ab->vdev_id_11d_lock);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev id for 11d scan %d\n",
+		   ar->vdev_id_11d_scan);
+
+	if (ar->regdom_set_by_user)
+		goto fin;
+
+	if (ar->vdev_id_11d_scan != ATH11K_11D_INVALID_VDEV_ID)
+		goto fin;
+
+	if (!test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map))
+		goto fin;
+
+	if (ath11k_mac_vif_ap_active_any(ar->ab))
+		goto fin;
+
+	param.vdev_id = vdev_id;
+	param.start_interval_msec = 0;
+	param.scan_period_msec = ATH11K_SCAN_11D_INTERVAL;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac start 11d scan\n");
+
+	if (wait)
+		reinit_completion(&ar->finish_11d_scan);
+
+	ret = ath11k_wmi_send_11d_scan_start_cmd(ar, &param);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to start 11d scan vdev %d ret: %d\n",
+			    vdev_id, ret);
+	} else {
+		ar->vdev_id_11d_scan = vdev_id;
+		if (wait) {
+			ar->pending_11d = true;
+			ret = wait_for_completion_timeout(&ar->finish_11d_scan,
+							  5 * HZ);
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+				   "mac 11d scan left time %d\n", ret);
+
+			if (!ret)
+				ar->pending_11d = false;
+		}
+	}
+
+fin:
+	mutex_unlock(&ar->ab->vdev_id_11d_lock);
+}
+
+void ath11k_mac_11d_scan_stop(struct ath11k *ar)
+{
+	int ret;
+	u32 vdev_id;
+
+	if (!test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map))
+		return;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac stop 11d scan\n");
+
+	mutex_lock(&ar->ab->vdev_id_11d_lock);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac stop 11d vdev id %d\n",
+		   ar->vdev_id_11d_scan);
+
+	if (ar->vdev_id_11d_scan != ATH11K_11D_INVALID_VDEV_ID) {
+		vdev_id = ar->vdev_id_11d_scan;
+
+		ret = ath11k_wmi_send_11d_scan_stop_cmd(ar, vdev_id);
+		if (ret)
+			ath11k_warn(ar->ab,
+				    "failed to stopt 11d scan vdev %d ret: %d\n",
+				    vdev_id, ret);
+		else
+			ar->vdev_id_11d_scan = ATH11K_11D_INVALID_VDEV_ID;
+	}
+	mutex_unlock(&ar->ab->vdev_id_11d_lock);
+}
+
+void ath11k_mac_11d_scan_stop_all(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	int i;
+
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac stop soc 11d scan\n");
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		ath11k_mac_11d_scan_stop(ar);
+	}
+}
+
 static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -5810,6 +5956,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+
+		ath11k_mac_11d_scan_stop_all(ar->ab);
 		break;
 	case WMI_VDEV_TYPE_STA:
 		param_id = WMI_STA_PS_PARAM_RX_WAKE_POLICY;
@@ -5849,6 +5997,9 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+
+		ath11k_mac_11d_scan_start(ar, arvif->vdev_id, true);
+
 		break;
 	case WMI_VDEV_TYPE_MONITOR:
 		set_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
@@ -5950,6 +6101,9 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
+	if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
+		ath11k_mac_11d_scan_stop(ar);
+
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		ret = ath11k_peer_delete(ar, arvif->vdev_id, vif->addr);
 		if (ret)
@@ -6698,6 +6852,9 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				    ret);
 	}
 
+	if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
+		ath11k_mac_11d_scan_start(ar, arvif->vdev_id, false);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -8099,6 +8256,9 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 
 		ar->monitor_vdev_id = -1;
 		clear_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
+		ar->vdev_id_11d_scan = ATH11K_11D_INVALID_VDEV_ID;
+		init_completion(&ar->finish_11d_scan);
+		init_completion(&ar->finish_11d_ch_list);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index f6f37e8c8c6a..dfa112c10834 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -127,6 +127,13 @@ struct ath11k_generic_iter {
 
 extern const struct htt_rx_ring_tlv_filter ath11k_mac_mon_status_filter_default;
 
+#define ATH11K_SCAN_11D_INTERVAL		600000
+#define ATH11K_11D_INVALID_VDEV_ID		0xFFFF
+
+void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id, bool wait);
+void ath11k_mac_11d_scan_stop(struct ath11k *ar);
+void ath11k_mac_11d_scan_stop_all(struct ath11k_base *ab);
+
 void ath11k_mac_destroy(struct ath11k_base *ab);
 void ath11k_mac_unregister(struct ath11k_base *ab);
 int ath11k_mac_register(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 958c2b2c5b3e..3cc666a002b9 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1383,6 +1383,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 
+	cancel_work_sync(&ab->update_11d_work);
 	ath11k_core_deinit(ab);
 
 qmi_fail:
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 8606170ba80d..1f8a81987187 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -86,6 +86,9 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	if (ret)
 		ath11k_warn(ar->ab,
 			    "INIT Country code set to fw failed : %d\n", ret);
+
+	ath11k_mac_11d_scan_stop(ar);
+	ar->regdom_set_by_user = true;
 }
 
 int ath11k_reg_update_chan_list(struct ath11k *ar)
@@ -179,6 +182,11 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
 	kfree(params);
 
+	if (ar->pending_11d) {
+		complete(&ar->finish_11d_ch_list);
+		ar->pending_11d = false;
+	}
+
 	return ret;
 }
 
@@ -244,8 +252,15 @@ int ath11k_regd_update(struct ath11k *ar)
 		goto err;
 	}
 
+	if (ar->pending_11d)
+		complete(&ar->finish_11d_scan);
+
 	rtnl_lock();
 	wiphy_lock(ar->hw->wiphy);
+
+	if (ar->pending_11d)
+		reinit_completion(&ar->finish_11d_ch_list);
+
 	ret = regulatory_set_wiphy_regd_sync(ar->hw->wiphy, regd_copy);
 	wiphy_unlock(ar->hw->wiphy);
 	rtnl_unlock();
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e5f3d04645d4..652d80eeedf4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -130,6 +130,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
 	[WMI_TAG_OBSS_COLOR_COLLISION_EVT] = {
 		.min_len = sizeof(struct wmi_obss_color_collision_event) },
+	[WMI_TAG_11D_NEW_COUNTRY_EVENT] = {
+		.min_len = sizeof(struct wmi_11d_new_cc_ev) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -2893,6 +2895,75 @@ ath11k_wmi_send_thermal_mitigation_param_cmd(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_send_11d_scan_start_cmd(struct ath11k *ar,
+				       struct wmi_11d_scan_start_params *param)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_11d_scan_start_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_11d_scan_start_cmd *)skb->data;
+	cmd->tlv_header =
+		FIELD_PREP(WMI_TLV_TAG, WMI_TAG_11D_SCAN_START_CMD) |
+		FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = param->vdev_id;
+	cmd->scan_period_msec = param->scan_period_msec;
+	cmd->start_interval_msec = param->start_interval_msec;
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_11D_SCAN_START_CMDID);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "send 11d scan start vdev id %d period %d ms internal %d ms\n",
+		   cmd->vdev_id,
+		   cmd->scan_period_msec,
+		   cmd->start_interval_msec);
+
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_11D_SCAN_START_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath11k_wmi_send_11d_scan_stop_cmd(struct ath11k *ar, u32 vdev_id)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_11d_scan_stop_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_11d_scan_stop_cmd *)skb->data;
+	cmd->tlv_header =
+		FIELD_PREP(WMI_TLV_TAG, WMI_TAG_11D_SCAN_STOP_CMD) |
+		FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_11D_SCAN_STOP_CMDID);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "send 11d scan stop vdev id %d\n",
+		   cmd->vdev_id);
+
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_11D_SCAN_STOP_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath11k_wmi_pdev_pktlog_enable(struct ath11k *ar, u32 pktlog_filter)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
@@ -5932,6 +6003,41 @@ static void ath11k_wmi_op_ep_tx_credits(struct ath11k_base *ab)
 	wake_up(&ab->wmi_ab.tx_credits_wq);
 }
 
+static int ath11k_reg_11d_new_cc_event(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	const struct wmi_11d_new_cc_ev *ev;
+	const void **tb;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return ret;
+	}
+
+	ev = tb[WMI_TAG_11D_NEW_COUNTRY_EVENT];
+	if (!ev) {
+		kfree(tb);
+		ath11k_warn(ab, "failed to fetch 11d new cc ev");
+		return -EPROTO;
+	}
+
+	spin_lock_bh(&ab->base_lock);
+	memcpy(&ab->new_alpha2, &ev->new_alpha2, 2);
+	spin_unlock_bh(&ab->base_lock);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi 11d new cc %c%c\n",
+		   ab->new_alpha2[0],
+		   ab->new_alpha2[1]);
+
+	kfree(tb);
+
+	queue_work(ab->workqueue, &ab->update_11d_work);
+
+	return 0;
+}
+
 static void ath11k_wmi_htc_tx_complete(struct ath11k_base *ab,
 				       struct sk_buff *skb)
 {
@@ -7321,6 +7427,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_WOW_WAKEUP_HOST_EVENTID:
 		ath11k_wmi_event_wow_wakeup_host(ab, skb);
 		break;
+	case WMI_11D_NEW_COUNTRY_EVENTID:
+		ath11k_reg_11d_new_cc_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index e1686a2ab520..3b7ad14f0901 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3813,6 +3813,28 @@ struct wmi_init_country_cmd {
 	} cc_info;
 } __packed;
 
+struct wmi_11d_scan_start_params {
+	u32 vdev_id;
+	u32 scan_period_msec;
+	u32 start_interval_msec;
+};
+
+struct wmi_11d_scan_start_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 scan_period_msec;
+	u32 start_interval_msec;
+} __packed;
+
+struct wmi_11d_scan_stop_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+} __packed;
+
+struct wmi_11d_new_cc_ev {
+	u32 new_alpha2;
+} __packed;
+
 #define THERMAL_LEVELS  1
 struct tt_level_config {
 	u32 tmplwm;
@@ -5448,6 +5470,11 @@ int ath11k_wmi_send_set_current_country_cmd(struct ath11k *ar,
 int
 ath11k_wmi_send_init_country_cmd(struct ath11k *ar,
 				 struct wmi_init_country_params init_cc_param);
+
+int ath11k_wmi_send_11d_scan_start_cmd(struct ath11k *ar,
+				       struct wmi_11d_scan_start_params *param);
+int ath11k_wmi_send_11d_scan_stop_cmd(struct ath11k *ar, u32 vdev_id);
+
 int
 ath11k_wmi_send_thermal_mitigation_param_cmd(struct ath11k *ar,
 					     struct thermal_mitigation_params *param);
-- 
2.31.1

