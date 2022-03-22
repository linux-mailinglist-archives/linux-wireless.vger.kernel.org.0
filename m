Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983C04E3EAF
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiCVMoM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiCVMoK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 08:44:10 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F0585962
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647952962; x=1679488962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GG909Gg2Gz0SruVTGw7ypa56UVz0Wv5jG8qsoXjcQos=;
  b=LrhAX7GFWO94q6e5zKD0oTG4AMBQEGm1vtLfr0IAymlJGYwf+rtRfQdR
   EgJ4RpXUCJt5mRHD5Gd9JBif3AVSgeTFK8obHeu3AQhJo5Q7cAADzAwt4
   bbgJ4C2pOtIzFkt1yr0W1U4Ud7ZThlef3TgiC3MkFkBXiPeUfZBhzxw6X
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Mar 2022 05:42:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 05:42:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 05:42:41 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 05:42:40 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: reduce the wait time of 11d scan and hw scan while add interface
Date:   Tue, 22 Mar 2022 08:42:26 -0400
Message-ID: <20220322124226.18347-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Currently ath11k will wait 11d scan complete while add interface in
ath11k_mac_op_add_interface(), when system resume without enable
wowlan, ath11k_mac_op_add_interface() is called for each resume, thus
it increase the resume time of system. And ath11k_mac_op_hw_scan()
after ath11k_mac_op_add_interface() also needs some time cost because
the previous 11d scan need more than 5 seconds when 6 GHz is enabled,
then the scan started event will indicated to ath11k after the 11d
scan completed.

While 11d scan/hw scan is running in firmware, if ath11k update channel
list to firmware by WMI_SCAN_CHAN_LIST_CMDID, then firmware will cancel
the current scan which is running, it lead the scan failed. The patch
commit 9dcf6808b253 ("ath11k: add 11d scan offload support") used
finish_11d_scan/finish_11d_ch_list/pending_11d to synchronize the 11d
scan/hw scan/channel list between ath11k/firmware/mac80211 and to avoid
the scan fail.

Add wait operation before ath11k update channel list, function
ath11k_reg_update_chan_list() will wait until the current 11d scan/hw
scan completed. And remove the wait operation of start 11d scan and
waiting channel list complete in hw scan. After these changes, resume
time cost reduce about 5 seconds and also hw scan time cost reduced
obviously, and scan failed not seen.

The 11d scan is sent to firmware only one time for each interface added
in mac.c, and it is moved after the 1st hw scan because 11d scan will
cost some time and thus leads the AP scan result update to UI delay.
Currently priority of ath11k's hw scan is WMI_SCAN_PRIORITY_LOW, and
priority of 11d scan in firmware is WMI_SCAN_PRIORITY_MEDIUM, then the
11d scan which sent after hw scan will cancel the hw scan in firmware,
so change the priority to WMI_SCAN_PRIORITY_MEDIUM for the hw scan which
is in front of the 11d scan, thus it will not happen scan cancel in
firmware.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: 9dcf6808b253 ("ath11k: add 11d scan offload support")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h | 13 ++++--
 drivers/net/wireless/ath/ath11k/mac.c  | 64 +++++++++-----------------
 drivers/net/wireless/ath/ath11k/mac.h  |  2 +-
 drivers/net/wireless/ath/ath11k/reg.c  | 38 +++++++++------
 drivers/net/wireless/ath/ath11k/wmi.c  | 16 ++++++-
 6 files changed, 74 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 71eb7d04c3bf..90a5df1fbdbd 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1288,6 +1288,7 @@ static void ath11k_core_restart(struct work_struct *work)
 
 		ieee80211_stop_queues(ar->hw);
 		ath11k_mac_drain_tx(ar);
+		complete(&ar->completed_11d_scan);
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
 		complete(&ar->peer_assoc_done);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index c0228e91a596..b8634eddf49a 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -38,6 +38,8 @@
 
 extern unsigned int ath11k_frame_mode;
 
+#define ATH11K_SCAN_TIMEOUT_HZ (20 * HZ)
+
 #define ATH11K_MON_TIMER_INTERVAL  10
 
 enum ath11k_supported_bw {
@@ -189,6 +191,12 @@ enum ath11k_scan_state {
 	ATH11K_SCAN_ABORTING,
 };
 
+enum ath11k_11d_state {
+	ATH11K_11D_IDLE,
+	ATH11K_11D_PREPARING,
+	ATH11K_11D_RUNNING,
+};
+
 enum ath11k_dev_flags {
 	ATH11K_CAC_RUNNING,
 	ATH11K_FLAG_CORE_REGISTERED,
@@ -607,9 +615,8 @@ struct ath11k {
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
 	u32 vdev_id_11d_scan;
-	struct completion finish_11d_scan;
-	struct completion finish_11d_ch_list;
-	bool pending_11d;
+	struct completion completed_11d_scan;
+	enum ath11k_11d_state state_11d;
 	bool regdom_set_by_user;
 	int hw_rate_code;
 	u8 twt_enabled;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d5b83f90d27a..798111e22c66 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3595,26 +3595,6 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;
 
-	/* Currently the pending_11d=true only happened 1 time while
-	 * wlan interface up in ath11k_mac_11d_scan_start(), it is called by
-	 * ath11k_mac_op_add_interface(), after wlan interface up,
-	 * pending_11d=false always.
-	 * If remove below wait, it always happened scan fail and lead connect
-	 * fail while wlan interface up, because it has a 11d scan which is running
-	 * in firmware, and lead this scan failed.
-	 */
-	if (ar->pending_11d) {
-		long time_left;
-		unsigned long timeout = 5 * HZ;
-
-		if (ar->supports_6ghz)
-			timeout += 5 * HZ;
-
-		time_left = wait_for_completion_timeout(&ar->finish_11d_ch_list, timeout);
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-			   "mac wait 11d channel list time left %ld\n", time_left);
-	}
-
 	memset(&arg, 0, sizeof(arg));
 	ath11k_wmi_start_scan_init(ar, &arg);
 	arg.vdev_id = arvif->vdev_id;
@@ -3680,6 +3660,10 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		kfree(arg.extraie.ptr);
 
 	mutex_unlock(&ar->conf_mutex);
+
+	if (ar->state_11d == ATH11K_11D_PREPARING)
+		ath11k_mac_11d_scan_start(ar, arvif->vdev_id);
+
 	return ret;
 }
 
@@ -6045,7 +6029,7 @@ static bool ath11k_mac_vif_ap_active_any(struct ath11k_base *ab)
 	return false;
 }
 
-void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id, bool wait)
+void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id)
 {
 	struct wmi_11d_scan_start_params param;
 	int ret;
@@ -6073,28 +6057,22 @@ void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id, bool wait)
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac start 11d scan\n");
 
-	if (wait)
-		reinit_completion(&ar->finish_11d_scan);
-
 	ret = ath11k_wmi_send_11d_scan_start_cmd(ar, &param);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start 11d scan vdev %d ret: %d\n",
 			    vdev_id, ret);
 	} else {
 		ar->vdev_id_11d_scan = vdev_id;
-		if (wait) {
-			ar->pending_11d = true;
-			ret = wait_for_completion_timeout(&ar->finish_11d_scan,
-							  5 * HZ);
-			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-				   "mac 11d scan left time %d\n", ret);
-
-			if (!ret)
-				ar->pending_11d = false;
-		}
+		if (ar->state_11d == ATH11K_11D_PREPARING)
+			ar->state_11d = ATH11K_11D_RUNNING;
 	}
 
 fin:
+	if (ar->state_11d == ATH11K_11D_PREPARING) {
+		ar->state_11d = ATH11K_11D_IDLE;
+		complete(&ar->completed_11d_scan);
+	}
+
 	mutex_unlock(&ar->ab->vdev_id_11d_lock);
 }
 
@@ -6117,12 +6095,15 @@ void ath11k_mac_11d_scan_stop(struct ath11k *ar)
 		vdev_id = ar->vdev_id_11d_scan;
 
 		ret = ath11k_wmi_send_11d_scan_stop_cmd(ar, vdev_id);
-		if (ret)
+		if (ret) {
 			ath11k_warn(ar->ab,
 				    "failed to stopt 11d scan vdev %d ret: %d\n",
 				    vdev_id, ret);
-		else
+		} else {
 			ar->vdev_id_11d_scan = ATH11K_11D_INVALID_VDEV_ID;
+			ar->state_11d = ATH11K_11D_IDLE;
+			complete(&ar->completed_11d_scan);
+		}
 	}
 	mutex_unlock(&ar->ab->vdev_id_11d_lock);
 }
@@ -6318,8 +6299,10 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 			goto err_peer_del;
 		}
 
-		ath11k_mac_11d_scan_start(ar, arvif->vdev_id, true);
-
+		if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map)) {
+			reinit_completion(&ar->completed_11d_scan);
+			ar->state_11d = ATH11K_11D_PREPARING;
+		}
 		break;
 	case WMI_VDEV_TYPE_MONITOR:
 		set_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
@@ -7184,7 +7167,7 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
-		ath11k_mac_11d_scan_start(ar, arvif->vdev_id, false);
+		ath11k_mac_11d_scan_start(ar, arvif->vdev_id);
 
 	mutex_unlock(&ar->conf_mutex);
 }
@@ -8665,8 +8648,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		ar->monitor_vdev_id = -1;
 		clear_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
 		ar->vdev_id_11d_scan = ATH11K_11D_INVALID_VDEV_ID;
-		init_completion(&ar->finish_11d_scan);
-		init_completion(&ar->finish_11d_ch_list);
+		init_completion(&ar->completed_11d_scan);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0e6c870b09c8..29b523af66dd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -130,7 +130,7 @@ extern const struct htt_rx_ring_tlv_filter ath11k_mac_mon_status_filter_default;
 #define ATH11K_SCAN_11D_INTERVAL		600000
 #define ATH11K_11D_INVALID_VDEV_ID		0xFFFF
 
-void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id, bool wait);
+void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id);
 void ath11k_mac_11d_scan_stop(struct ath11k *ar);
 void ath11k_mac_11d_scan_stop_all(struct ath11k_base *ab);
 
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 81e11cde31d7..5e2fa69ae565 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -111,7 +111,31 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 	struct channel_param *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret;
+	int i, ret, left;
+
+	if (ar->state_11d != ATH11K_11D_IDLE) {
+		left = wait_for_completion_timeout(&ar->completed_11d_scan,
+						   ATH11K_SCAN_TIMEOUT_HZ);
+		if (!left) {
+			ath11k_warn(ar->ab,
+				    "failed to receive 11d scan complete: timed out\n");
+			ar->state_11d = ATH11K_11D_IDLE;
+		}
+		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+			   "reg 11d scan wait left time %d\n", left);
+	}
+
+	if (ar->scan.state == ATH11K_SCAN_STARTING ||
+	    ar->scan.state == ATH11K_SCAN_RUNNING) {
+		left = wait_for_completion_timeout(&ar->scan.completed,
+						   ATH11K_SCAN_TIMEOUT_HZ);
+		if (!left)
+			ath11k_warn(ar->ab,
+				    "failed to receive hw scan complete: timed out\n");
+
+		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+			   "reg hw scan wait left time %d\n", left);
+	}
 
 	bands = hw->wiphy->bands;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
@@ -193,11 +217,6 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
 	kfree(params);
 
-	if (ar->pending_11d) {
-		complete(&ar->finish_11d_ch_list);
-		ar->pending_11d = false;
-	}
-
 	return ret;
 }
 
@@ -263,15 +282,8 @@ int ath11k_regd_update(struct ath11k *ar)
 		goto err;
 	}
 
-	if (ar->pending_11d)
-		complete(&ar->finish_11d_scan);
-
 	rtnl_lock();
 	wiphy_lock(ar->hw->wiphy);
-
-	if (ar->pending_11d)
-		reinit_completion(&ar->finish_11d_ch_list);
-
 	ret = regulatory_set_wiphy_regd_sync(ar->hw->wiphy, regd_copy);
 	wiphy_unlock(ar->hw->wiphy);
 	rtnl_unlock();
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b4f86c45d81f..2751fe8814df 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2015,7 +2015,10 @@ void ath11k_wmi_start_scan_init(struct ath11k *ar,
 {
 	/* setup commonly used values */
 	arg->scan_req_id = 1;
-	arg->scan_priority = WMI_SCAN_PRIORITY_LOW;
+	if (ar->state_11d == ATH11K_11D_PREPARING)
+		arg->scan_priority = WMI_SCAN_PRIORITY_MEDIUM;
+	else
+		arg->scan_priority = WMI_SCAN_PRIORITY_LOW;
 	arg->dwell_time_active = 50;
 	arg->dwell_time_active_2g = 0;
 	arg->dwell_time_passive = 150;
@@ -6350,8 +6353,10 @@ static void ath11k_wmi_op_ep_tx_credits(struct ath11k_base *ab)
 static int ath11k_reg_11d_new_cc_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	const struct wmi_11d_new_cc_ev *ev;
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
 	const void **tb;
-	int ret;
+	int ret, i;
 
 	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
@@ -6377,6 +6382,13 @@ static int ath11k_reg_11d_new_cc_event(struct ath11k_base *ab, struct sk_buff *s
 
 	kfree(tb);
 
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		ar->state_11d = ATH11K_11D_IDLE;
+		complete(&ar->completed_11d_scan);
+	}
+
 	queue_work(ab->workqueue, &ab->update_11d_work);
 
 	return 0;

base-commit: d845cf007bdf8b2bf41522e1ecd0eb804e553d57
-- 
2.31.1

