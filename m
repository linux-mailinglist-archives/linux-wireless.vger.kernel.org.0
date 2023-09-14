Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD13179FFAA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjINJJM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbjINJJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB82696
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 02:08:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E74Jrj024931;
        Thu, 14 Sep 2023 09:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=s/T399zFKFDJ9qJxBB6U40nxqAh5wgZrmZ/ilebRf7M=;
 b=eDPYrOiWGqmBkCWWR7nv4+rexu/NCFIlIEvEFvDFPLfcaJKxcgam3TdmHXdMEIT2xkEb
 leIiB9wPagg7CWrBBeuRSvWR+SOV3yHS2E8YTVIkefUb2Yb1nhC/FPSDEczFL86PflND
 AqxoiHDQ0Ns3C79Vccul9WJIAuzetNbNQ5xma+Fuk1lLO343zZiY/ucvtGq/9B2KaNrf
 FBuPqEus0QChi8YndydhW7+POD6UhC6ryuYivBlfkSfc1PzaPu9CkyZgiPGcpuCWuLiQ
 d5OssKYeMSc7+3c7fy6l3/q1oX40eBwzB4iJG+JtcQMFfUZtB3jJbqf8M8/Ys15VBeb0 pA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3h0dhyb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 09:08:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E989YK031567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 09:08:09 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 02:08:06 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 2/4] wifi: ath12k: add 11d scan offload support
Date:   Thu, 14 Sep 2023 05:07:44 -0400
Message-ID: <20230914090746.23560-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914090746.23560-1-quic_wgong@quicinc.com>
References: <20230914090746.23560-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GbOvdMXGkhh9a0kk-3dBfxaTKMHrujp_
X-Proofpoint-GUID: GbOvdMXGkhh9a0kk-3dBfxaTKMHrujp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140078
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add handler for WMI_11D_NEW_COUNTRY_EVENTID, WMI_11D_SCAN_START_CMDID,
WMI_11D_SCAN_STOP_CMDID.

The priority of 11d scan WMI_SCAN_PRIORITY_MEDIUM in firmware, the
priority of hw scan is WMI_SCAN_PRIORITY_LOW, then the 11d scan will
cancel the hw scan which is running. To avoid this, change the priority
of the 1st hw scan to WMI_SCAN_PRIORITY_MEDIUM. Add wait_for_completion_timeout
for ar->scan.completed in ath12k_reg_update_chan_list(), plus the existing
wait in ath12k_scan_stop(), then ath12k have 2 place to wait the
ar->scan.completed, they run in different thread, thus it is possible to
happen that the two threads both enter wait status. To handle this scenario,
ath12k should change the complete() to complete_all() for the ar->scan.completed,
this also work well when it is only one thread wait for ar->scan.completed.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  35 ++++-
 drivers/net/wireless/ath/ath12k/core.h |  16 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 170 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   7 +
 drivers/net/wireless/ath/ath12k/reg.c  |  37 +++++-
 drivers/net/wireless/ath/ath12k/reg.h  |   3 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 123 +++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  |  25 ++++
 8 files changed, 406 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3df8059d5512..71450dc1f48d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -668,6 +668,7 @@ void ath12k_core_halt(struct ath12k *ar)
 	ath12k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
+	cancel_work_sync(&ab->update_11d_work);
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
@@ -675,6 +676,34 @@ void ath12k_core_halt(struct ath12k *ar)
 	idr_init(&ar->txmgmt_idr);
 }
 
+static void ath12k_update_11d(struct work_struct *work)
+{
+	struct ath12k_base *ab = container_of(work, struct ath12k_base, update_11d_work);
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	struct wmi_set_current_country_params set_current_param = {};
+	int ret, i;
+
+	spin_lock_bh(&ab->base_lock);
+	memcpy(&set_current_param.alpha2, &ab->new_alpha2, 2);
+	spin_unlock_bh(&ab->base_lock);
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "update 11d new cc %c%c\n",
+		   set_current_param.alpha2[0],
+		   set_current_param.alpha2[1]);
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		ret = ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		if (ret)
+			ath12k_warn(ar->ab,
+				    "pdev id %d failed set current country code: %d\n",
+				    i, ret);
+	}
+}
+
 static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -693,8 +722,10 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 
 		ieee80211_stop_queues(ar->hw);
 		ath12k_mac_drain_tx(ar);
+		ar->state_11d = ATH12K_11D_IDLE;
+		complete(&ar->completed_11d_scan);
 		complete(&ar->scan.started);
-		complete(&ar->scan.completed);
+		complete_all(&ar->scan.completed);
 		complete(&ar->peer_assoc_done);
 		complete(&ar->peer_delete_done);
 		complete(&ar->install_key_done);
@@ -913,6 +944,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 
 	mutex_init(&ab->core_lock);
 	spin_lock_init(&ab->base_lock);
+	mutex_init(&ab->vdev_id_11d_lock);
 	init_completion(&ab->reset_complete);
 	init_completion(&ab->reconfigure_complete);
 	init_completion(&ab->recovery_start);
@@ -921,6 +953,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	init_waitqueue_head(&ab->peer_mapping_wq);
 	init_waitqueue_head(&ab->wmi_ab.tx_credits_wq);
 	INIT_WORK(&ab->restart_work, ath12k_core_restart);
+	INIT_WORK(&ab->update_11d_work, ath12k_update_11d);
 	INIT_WORK(&ab->reset_work, ath12k_core_reset);
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4389ff40b49d..e739869ded73 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -36,6 +36,8 @@
 #define	ATH12K_RX_RATE_TABLE_NUM	320
 #define	ATH12K_RX_RATE_TABLE_11AX_NUM	576
 
+#define ATH12K_SCAN_TIMEOUT_HZ (20 * HZ)
+
 #define ATH12K_MON_TIMER_INTERVAL  10
 #define ATH12K_RESET_TIMEOUT_HZ			(20 * HZ)
 #define ATH12K_RESET_MAX_FAIL_COUNT_FIRST	3
@@ -171,6 +173,12 @@ enum ath12k_scan_state {
 	ATH12K_SCAN_ABORTING,
 };
 
+enum ath12k_11d_state {
+	ATH12K_11D_IDLE,
+	ATH12K_11D_PREPARING,
+	ATH12K_11D_RUNNING,
+};
+
 enum ath12k_dev_flags {
 	ATH12K_CAC_RUNNING,
 	ATH12K_FLAG_CRASH_FLUSH,
@@ -570,6 +578,10 @@ struct ath12k {
 	bool monitor_vdev_created;
 	bool monitor_started;
 	int monitor_vdev_id;
+	u32 vdev_id_11d_scan;
+	struct completion completed_11d_scan;
+	enum ath12k_11d_state state_11d;
+	bool regdom_set_by_user;
 };
 
 struct ath12k_band_cap {
@@ -755,6 +767,10 @@ struct ath12k_base {
 	/* continuous recovery fail count */
 	atomic_t fail_cont_count;
 	unsigned long reset_fail_timeout;
+	struct work_struct update_11d_work;
+	u8 new_alpha2[2];
+	/* To synchronize 11d scan vdev id */
+	struct mutex vdev_id_11d_lock;
 	struct {
 		/* protected by data_lock */
 		u32 fw_crash_counter;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0f2af2f14ef7..740e8045a6f1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2354,6 +2354,11 @@ static void ath12k_bss_assoc(struct ieee80211_hw *hw,
 	if (ret)
 		ath12k_warn(ar->ab, "failed to set vdev %i OBSS PD parameters: %d\n",
 			    arvif->vdev_id, ret);
+
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map) &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_stop_all(ar->ab);
 }
 
 static void ath12k_bss_disassoc(struct ieee80211_hw *hw,
@@ -2796,7 +2801,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
 		ar->scan_channel = NULL;
 		ar->scan.roc_freq = 0;
 		cancel_delayed_work(&ar->scan.timeout);
-		complete(&ar->scan.completed);
+		complete_all(&ar->scan.completed);
 		break;
 	}
 }
@@ -2913,6 +2918,9 @@ static int ath12k_start_scan(struct ath12k *ar,
 		if (ret)
 			ath12k_warn(ar->ab, "failed to stop scan: %d\n", ret);
 
+		if (ar->state_11d == ATH12K_11D_RUNNING)
+			return -EBUSY;
+
 		return -ETIMEDOUT;
 	}
 
@@ -3001,7 +3009,12 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	ret = ath12k_start_scan(ar, &arg);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
+		if (ret == -EBUSY)
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "scan engine is busy 11d state %d\n", ar->state_11d);
+		else
+			ath12k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
+
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH12K_SCAN_IDLE;
 		spin_unlock_bh(&ar->data_lock);
@@ -3019,6 +3032,12 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		kfree(arg.extraie.ptr);
 
 	mutex_unlock(&ar->conf_mutex);
+
+	if (ar->state_11d == ATH12K_11D_PREPARING &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_start(ar, arvif->vdev_id);
+
 	return ret;
 }
 
@@ -5060,7 +5079,7 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	/* TODO: Do we need to enable ANI? */
 
-	ath12k_reg_update_chan_list(ar);
+	ath12k_reg_update_chan_list(ar, false);
 
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
@@ -5128,6 +5147,9 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
+	cancel_work_sync(&ar->ab->update_11d_work);
+	ar->state_11d = ATH12K_11D_IDLE;
+	complete(&ar->completed_11d_scan);
 
 	spin_lock_bh(&ar->data_lock);
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
@@ -5306,6 +5328,124 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	}
 }
 
+static bool ath12k_mac_vif_ap_active_any(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	struct ath12k_vif *arvif;
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
+void ath12k_mac_11d_scan_start(struct ath12k *ar, u32 vdev_id)
+{
+	struct wmi_11d_scan_start_params param;
+	int ret;
+
+	mutex_lock(&ar->ab->vdev_id_11d_lock);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev id for 11d scan %d\n",
+		   ar->vdev_id_11d_scan);
+
+	if (ar->regdom_set_by_user)
+		goto fin;
+
+	if (ar->vdev_id_11d_scan != ATH12K_11D_INVALID_VDEV_ID)
+		goto fin;
+
+	if (!test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map))
+		goto fin;
+
+	if (ath12k_mac_vif_ap_active_any(ar->ab))
+		goto fin;
+
+	param.vdev_id = vdev_id;
+	param.start_interval_msec = 0;
+	param.scan_period_msec = ATH12K_SCAN_11D_INTERVAL;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac start 11d scan\n");
+
+	ret = ath12k_wmi_send_11d_scan_start_cmd(ar, &param);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to start 11d scan vdev %d ret: %d\n",
+			    vdev_id, ret);
+	} else {
+		ar->vdev_id_11d_scan = vdev_id;
+		if (ar->state_11d == ATH12K_11D_PREPARING)
+			ar->state_11d = ATH12K_11D_RUNNING;
+	}
+
+fin:
+	if (ar->state_11d == ATH12K_11D_PREPARING) {
+		ar->state_11d = ATH12K_11D_IDLE;
+		complete(&ar->completed_11d_scan);
+	}
+
+	mutex_unlock(&ar->ab->vdev_id_11d_lock);
+}
+
+void ath12k_mac_11d_scan_stop(struct ath12k *ar)
+{
+	int ret;
+	u32 vdev_id;
+
+	if (!test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map))
+		return;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac stop 11d scan\n");
+
+	mutex_lock(&ar->ab->vdev_id_11d_lock);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac stop 11d vdev id %d\n",
+		   ar->vdev_id_11d_scan);
+
+	if (ar->state_11d == ATH12K_11D_PREPARING) {
+		ar->state_11d = ATH12K_11D_IDLE;
+		complete(&ar->completed_11d_scan);
+	}
+
+	if (ar->vdev_id_11d_scan != ATH12K_11D_INVALID_VDEV_ID) {
+		vdev_id = ar->vdev_id_11d_scan;
+
+		ret = ath12k_wmi_send_11d_scan_stop_cmd(ar, vdev_id);
+		if (ret) {
+			ath12k_warn(ar->ab,
+				    "failed to stopt 11d scan vdev %d ret: %d\n",
+				    vdev_id, ret);
+		} else {
+			ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
+			ar->state_11d = ATH12K_11D_IDLE;
+			complete(&ar->completed_11d_scan);
+		}
+	}
+	mutex_unlock(&ar->ab->vdev_id_11d_lock);
+}
+
+void ath12k_mac_11d_scan_stop_all(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	int i;
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac stop soc 11d scan\n");
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		ath12k_mac_11d_scan_stop(ar);
+	}
+}
+
 static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -5438,6 +5578,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+		ath12k_mac_11d_scan_stop_all(ar->ab);
 		break;
 	case WMI_VDEV_TYPE_STA:
 		param_id = WMI_STA_PS_PARAM_RX_WAKE_POLICY;
@@ -5476,6 +5617,14 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+
+		if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map) &&
+		    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+		    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE) {
+			reinit_completion(&ar->completed_11d_scan);
+			ar->state_11d = ATH12K_11D_PREPARING;
+		}
+
 		break;
 	default:
 		break;
@@ -5579,6 +5728,11 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map) &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_stop(ar);
+
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		ret = ath12k_peer_delete(ar, arvif->vdev_id, vif->addr);
 		if (ret)
@@ -6289,6 +6443,14 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
 
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map) &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE &&
+	    ar->state_11d != ATH12K_11D_PREPARING) {
+		reinit_completion(&ar->completed_11d_scan);
+		ar->state_11d = ATH12K_11D_PREPARING;
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -7461,6 +7623,8 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
 		skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
 		clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
+		ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
+		init_completion(&ar->completed_11d_scan);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 7b16b70df4fa..0653b6b54891 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -47,6 +47,13 @@ enum ath12k_supported_bw {
 
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
+#define ATH12K_SCAN_11D_INTERVAL		600000
+#define ATH12K_11D_INVALID_VDEV_ID		0xFFFF
+
+void ath12k_mac_11d_scan_start(struct ath12k *ar, u32 vdev_id);
+void ath12k_mac_11d_scan_stop(struct ath12k *ar);
+void ath12k_mac_11d_scan_stop_all(struct ath12k_base *ab);
+
 void ath12k_mac_destroy(struct ath12k_base *ab);
 void ath12k_mac_unregister(struct ath12k_base *ab);
 int ath12k_mac_register(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 6ede91ebc8e1..c2f2fcce9fb1 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -88,9 +88,12 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	if (ret)
 		ath12k_warn(ar->ab,
 			    "INIT Country code set to fw failed : %d\n", ret);
+
+	ath12k_mac_11d_scan_stop(ar);
+	ar->regdom_set_by_user = true;
 }
 
-int ath12k_reg_update_chan_list(struct ath12k *ar)
+int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 {
 	struct ieee80211_supported_band **bands;
 	struct ath12k_wmi_scan_chan_list_arg *arg;
@@ -99,7 +102,35 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
 	struct ath12k_wmi_channel_arg *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret;
+	int i, ret, left;
+
+	if (wait && ar->state_11d != ATH12K_11D_IDLE) {
+		left = wait_for_completion_timeout(&ar->completed_11d_scan,
+						   ATH12K_SCAN_TIMEOUT_HZ);
+		if (!left) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+				   "failed to receive 11d scan complete: timed out\n");
+			ar->state_11d = ATH12K_11D_IDLE;
+		}
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+			   "reg 11d scan wait left time %d\n", left);
+	}
+
+	if (wait &&
+	    (ar->scan.state == ATH12K_SCAN_STARTING ||
+	    ar->scan.state == ATH12K_SCAN_RUNNING)) {
+		left = wait_for_completion_timeout(&ar->scan.completed,
+						   ATH12K_SCAN_TIMEOUT_HZ);
+		if (!left)
+			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+				   "failed to receive hw scan complete: timed out\n");
+
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+			   "reg hw scan wait left time %d\n", left);
+	}
+
+	if (ar->state == ATH12K_STATE_RESTARTING)
+		return 0;
 
 	bands = hw->wiphy->bands;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
@@ -257,7 +288,7 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 		goto err;
 
 	if (ar->state == ATH12K_STATE_ON) {
-		ret = ath12k_reg_update_chan_list(ar);
+		ret = ath12k_reg_update_chan_list(ar, true);
 		if (ret)
 			goto err;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 56d009a47234..7e8f9d7970dd 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -90,6 +90,5 @@ struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
 						  struct ath12k_reg_info *reg_info,
 						  bool intersect);
 int ath12k_regd_update(struct ath12k *ar, bool init);
-int ath12k_reg_update_chan_list(struct ath12k *ar);
-
+int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d22ff9c2326a..92f08e512443 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -160,6 +160,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
 	[WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
+	[WMI_TAG_11D_NEW_COUNTRY_EVENT] = {
+		.min_len = sizeof(struct wmi_11d_new_cc_event) },
 };
 
 static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
@@ -2110,7 +2112,10 @@ void ath12k_wmi_start_scan_init(struct ath12k *ar,
 {
 	/* setup commonly used values */
 	arg->scan_req_id = 1;
-	arg->scan_priority = WMI_SCAN_PRIORITY_LOW;
+	if (ar->state_11d == ATH12K_11D_PREPARING)
+		arg->scan_priority = WMI_SCAN_PRIORITY_MEDIUM;
+	else
+		arg->scan_priority = WMI_SCAN_PRIORITY_LOW;
 	arg->dwell_time_active = 50;
 	arg->dwell_time_active_2g = 0;
 	arg->dwell_time_passive = 150;
@@ -2880,6 +2885,75 @@ int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_send_11d_scan_start_cmd(struct ath12k *ar,
+				       struct wmi_11d_scan_start_params *param)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_11d_scan_start_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_11d_scan_start_cmd *)skb->data;
+	cmd->tlv_header =
+		ath12k_wmi_tlv_cmd_hdr(WMI_TAG_11D_SCAN_START_CMD,
+				       sizeof(*cmd));
+
+	cmd->vdev_id = cpu_to_le32(param->vdev_id);
+	cmd->scan_period_msec = cpu_to_le32(param->scan_period_msec);
+	cmd->start_interval_msec = cpu_to_le32(param->start_interval_msec);
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_11D_SCAN_START_CMDID);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "send 11d scan start vdev id %d period %d ms internal %d ms\n",
+		   param->vdev_id,
+		   param->scan_period_msec,
+		   param->start_interval_msec);
+
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to send WMI_11D_SCAN_START_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath12k_wmi_send_11d_scan_stop_cmd(struct ath12k *ar, u32 vdev_id)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_11d_scan_stop_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_11d_scan_stop_cmd *)skb->data;
+	cmd->tlv_header =
+		ath12k_wmi_tlv_cmd_hdr(WMI_TAG_11D_SCAN_STOP_CMD,
+				       sizeof(*cmd));
+
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_11D_SCAN_STOP_CMDID);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "send 11d scan stop vdev id %d\n",
+		   cmd->vdev_id);
+
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to send WMI_11D_SCAN_STOP_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int
 ath12k_wmi_send_twt_enable_cmd(struct ath12k *ar, u32 pdev_id)
 {
@@ -5418,6 +5492,50 @@ static void ath12k_wmi_op_ep_tx_credits(struct ath12k_base *ab)
 	wake_up(&ab->wmi_ab.tx_credits_wq);
 }
 
+static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *skb)
+{
+	const struct wmi_11d_new_cc_event *ev;
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	const void **tb;
+	int ret, i;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return ret;
+	}
+
+	ev = tb[WMI_TAG_11D_NEW_COUNTRY_EVENT];
+	if (!ev) {
+		kfree(tb);
+		ath12k_warn(ab, "failed to fetch 11d new cc ev");
+		return -EPROTO;
+	}
+
+	spin_lock_bh(&ab->base_lock);
+	memcpy(&ab->new_alpha2, &ev->new_alpha2, REG_ALPHA2_LEN);
+	spin_unlock_bh(&ab->base_lock);
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "wmi 11d new cc %c%c\n",
+		   ab->new_alpha2[0],
+		   ab->new_alpha2[1]);
+
+	kfree(tb);
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		ar->state_11d = ATH12K_11D_IDLE;
+		complete(&ar->completed_11d_scan);
+	}
+
+	queue_work(ab->workqueue, &ab->update_11d_work);
+
+	return 0;
+}
+
 static void ath12k_wmi_htc_tx_complete(struct ath12k_base *ab,
 				       struct sk_buff *skb)
 {
@@ -6718,6 +6836,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_VDEV_DELETE_RESP_EVENTID:
 		ath12k_vdev_delete_resp_event(ab, skb);
 		break;
+	case WMI_11D_NEW_COUNTRY_EVENTID:
+		ath12k_reg_11d_new_cc_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index fead9eba0791..f4f1df057812 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3782,6 +3782,28 @@ struct wmi_init_country_cmd {
 	} cc_info;
 } __packed;
 
+struct wmi_11d_scan_start_params {
+	u32 vdev_id;
+	u32 scan_period_msec;
+	u32 start_interval_msec;
+};
+
+struct wmi_11d_scan_start_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 scan_period_msec;
+	__le32 start_interval_msec;
+} __packed;
+
+struct wmi_11d_scan_stop_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+} __packed;
+
+struct wmi_11d_new_cc_event {
+	__le32 new_alpha2;
+} __packed;
+
 struct wmi_delba_send_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
@@ -4897,6 +4919,9 @@ int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
 					   dma_addr_t paddr, u8 tid,
 					   u8 ba_window_size_valid,
 					   u32 ba_window_size);
+int ath12k_wmi_send_11d_scan_start_cmd(struct ath12k *ar,
+				       struct wmi_11d_scan_start_params *param);
+int ath12k_wmi_send_11d_scan_stop_cmd(struct ath12k *ar, u32 vdev_id);
 int
 ath12k_wmi_rx_reord_queue_remove(struct ath12k *ar,
 				 struct ath12k_wmi_rx_reorder_queue_remove_arg *arg);
-- 
2.40.1

