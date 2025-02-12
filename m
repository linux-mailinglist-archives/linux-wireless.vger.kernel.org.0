Return-Path: <linux-wireless+bounces-18823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43584A31EFD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 07:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34C6188A67A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8421FF7D9;
	Wed, 12 Feb 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FgkcHJod"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D61FCF53
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341954; cv=none; b=uCZ+hWm+RCqpmATaDe0Q6qgm6gpRyuF4/sOXrNuUdrCI/7snO+R65Sw3oku9byIgo9O5G9JkM7VJGKGiRcGFMsMCclnQFQVwtoXBhnaWMfjb5cIDLbu9HOYfrJZlyW3wtyEnPevYKtoXAj/2lqxTKJye6CIQGx0sxWaIzBaNiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341954; c=relaxed/simple;
	bh=ebCbDJqptHMblSe9wjKecekl8firaQ8LaFUAy7eKEGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zqenvzdo9MSvFqtUQnExmGC45kVVmtl/VrjDFD3SmRkV6XZavfxvg9Jil98hrAHKOww4VHkXGlZn6kUb8Yg2+sBm/oh28F9VNVKHPDV+SMZJ4lwIK3yj5sHkBSHoLl/J7iBN51mkAKru4wTc3m/f7N3K6ntDrriCKv1KsN6pYoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FgkcHJod; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0b97H030244;
	Wed, 12 Feb 2025 06:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZmWVT5Iqeu4Zu1L65I9eF46BNpgW5WWKMrnuJxtrkj0=; b=FgkcHJod97IbEzYZ
	NjWe5UtS8AWIUNye85QyXbhGhfDIyu80GNhSok7NHDbsaKxRFbKKEaCY55y6mvdv
	rYlFazcIAZedeubpN/YnNmTWEoC1TkzpSZf22u9m77fO9R2rciWFTO6Vr3grhy9o
	ZpAJRxY7daR98/HcG3S0Z3HaHT8qNPXn49JuNaTadY26Ug4V7FRmPjebVn5xu7+2
	Xy3KjPvNhXkEaj+fjLYjMndBHXqPCPrw/hZUMuMV7kcoJavUzr8/Rag9ISdW493I
	XEab7Vdbbsz5xNz/XnZqAYkVllBGtFFJqUhsbz8PmdRCbmYkme+sHSXPjdpHypod
	Ux6XKQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxg9kw2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 06:32:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51C6WRSR006618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 06:32:27 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Feb 2025 22:32:26 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v10 2/4] wifi: ath12k: add 11d scan offload support
Date: Wed, 12 Feb 2025 14:31:58 +0800
Message-ID: <20250212063200.1631-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250212063200.1631-1-quic_kangyang@quicinc.com>
References: <20250212063200.1631-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KBZVxDz3iOLPzXoJ-CTQ1D0y7VVi67xb
X-Proofpoint-GUID: KBZVxDz3iOLPzXoJ-CTQ1D0y7VVi67xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120049

From: Wen Gong <quic_wgong@quicinc.com>

The flow of 11d scan is:
1. trigger 11d scan.
2. receive, parse, and update 11d scan result.
3. stop 11d scan.

So need to add handler for WMI_11D_SCAN_START_CMDID and
WMI_11D_SCAN_STOP_CMDID to trigger/stop 11d scan. Add process of WMI
event WMI_11D_NEW_COUNTRY_EVENTID for 11d scan result.

There are two points that need to be noted:
1. The 11d scan priority is 'MEDIUM' in firmware, the hw scan priority
is 'LOW'. When 11d scan is running, hw scan will be canceled.
To avoid this, change the hw scan priority to 'MEDIUM' when 11d scan
is running.

2. Need to add wait_for_completion_timeout() for scan.complete in
ath12k_reg_update_chan_list() because 11d scan will cost more than 5
seconds. Due to another existing wait in ath12k_scan_stop(), there will
be two scan.complete in different threads. Therefore use complete_all()
instead of complete() for scan.complete. complete_all() can work well
when it is only one thread wait for scan.complete.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  33 ++++-
 drivers/net/wireless/ath/ath12k/core.h |  16 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 159 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath12k/reg.c  |  42 ++++++-
 drivers/net/wireless/ath/ath12k/reg.h  |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 122 ++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  |  25 ++++
 8 files changed, 396 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0c556023141b..598b562b5edf 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1259,6 +1259,7 @@ void ath12k_core_halt(struct ath12k *ar)
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->rfkill_work);
+	cancel_work_sync(&ab->update_11d_work);
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
@@ -1292,8 +1293,10 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			ar = &ah->radio[j];
 
 			ath12k_mac_drain_tx(ar);
+			ar->state_11d = ATH12K_11D_IDLE;
+			complete(&ar->completed_11d_scan);
 			complete(&ar->scan.started);
-			complete(&ar->scan.completed);
+			complete_all(&ar->scan.completed);
 			complete(&ar->scan.on_channel);
 			complete(&ar->peer_assoc_done);
 			complete(&ar->peer_delete_done);
@@ -1314,6 +1317,33 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	wake_up(&ab->peer_mapping_wq);
 }
 
+static void ath12k_update_11d(struct work_struct *work)
+{
+	struct ath12k_base *ab = container_of(work, struct ath12k_base, update_11d_work);
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	struct wmi_set_current_country_arg arg = {};
+	int ret, i;
+
+	spin_lock_bh(&ab->base_lock);
+	memcpy(&arg.alpha2, &ab->new_alpha2, 2);
+	spin_unlock_bh(&ab->base_lock);
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "update 11d new cc %c%c\n",
+		   arg.alpha2[0], arg.alpha2[1]);
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		ret = ath12k_wmi_send_set_current_country_cmd(ar, &arg);
+		if (ret)
+			ath12k_warn(ar->ab,
+				    "pdev id %d failed set current country code: %d\n",
+				    i, ret);
+	}
+}
+
 static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag = ab->ag;
@@ -1967,6 +1997,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->reset_work, ath12k_core_reset);
 	INIT_WORK(&ab->rfkill_work, ath12k_rfkill_work);
 	INIT_WORK(&ab->dump_work, ath12k_coredump_upload);
+	INIT_WORK(&ab->update_11d_work, ath12k_update_11d);
 
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3fac4f00d383..ba6a023e43cc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -219,6 +219,12 @@ enum ath12k_scan_state {
 	ATH12K_SCAN_ABORTING,
 };
 
+enum ath12k_11d_state {
+	ATH12K_11D_IDLE,
+	ATH12K_11D_PREPARING,
+	ATH12K_11D_RUNNING,
+};
+
 enum ath12k_hw_group_flags {
 	ATH12K_GROUP_FLAG_REGISTERED,
 	ATH12K_GROUP_FLAG_UNREGISTER,
@@ -364,6 +370,8 @@ struct ath12k_vif_iter {
 #define HAL_RX_MAX_NSS		8
 #define HAL_RX_MAX_NUM_LEGACY_RATES 12
 
+#define ATH12K_SCAN_TIMEOUT_HZ (20 * HZ)
+
 struct ath12k_rx_peer_rate_stats {
 	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
 	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT + 1];
@@ -737,6 +745,12 @@ struct ath12k {
 
 	bool nlo_enabled;
 
+	/* Protected by wiphy::mtx lock. */
+	u32 vdev_id_11d_scan;
+	struct completion completed_11d_scan;
+	enum ath12k_11d_state state_11d;
+	bool regdom_set_by_user;
+
 	struct completion fw_stats_complete;
 
 	struct completion mlo_setup_done;
@@ -1011,6 +1025,8 @@ struct ath12k_base {
 	/* continuous recovery fail count */
 	atomic_t fail_cont_count;
 	unsigned long reset_fail_timeout;
+	struct work_struct update_11d_work;
+	u8 new_alpha2[2];
 	struct {
 		/* protected by data_lock */
 		u32 fw_crash_counter;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 27d2fad1b915..6ef98837e84f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3375,6 +3375,11 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	if (ret)
 		ath12k_warn(ar->ab, "failed to set vdev %i OBSS PD parameters: %d\n",
 			    arvif->vdev_id, ret);
+
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map) &&
+	    ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_stop_all(ar->ab);
 }
 
 static void ath12k_bss_disassoc(struct ath12k *ar,
@@ -3532,6 +3537,11 @@ static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac remove link interface (vdev %d link id %d)",
 		   arvif->vdev_id, arvif->link_id);
 
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map) &&
+	    ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_stop(ar);
+
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		ret = ath12k_peer_delete(ar, arvif->vdev_id, arvif->bssid);
 		if (ret)
@@ -4192,7 +4202,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
 		fallthrough;
 	case ATH12K_SCAN_STARTING:
 		cancel_delayed_work(&ar->scan.timeout);
-		complete(&ar->scan.completed);
+		complete_all(&ar->scan.completed);
 		wiphy_work_queue(ar->ah->hw->wiphy, &ar->scan.vdev_clean_wk);
 		break;
 	}
@@ -4536,7 +4546,12 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	ret = ath12k_start_scan(ar, arg);
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
@@ -4563,6 +4578,11 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		kfree(arg);
 	}
 
+	if (ar->state_11d == ATH12K_11D_PREPARING &&
+	    ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_start(ar, arvif->vdev_id);
+
 	return ret;
 }
 
@@ -7592,7 +7612,7 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 	/* TODO: Do we need to enable ANI? */
 
-	ath12k_reg_update_chan_list(ar);
+	ath12k_reg_update_chan_list(ar, false);
 
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
@@ -7779,6 +7799,9 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->rfkill_work);
+	cancel_work_sync(&ar->ab->update_11d_work);
+	ar->state_11d = ATH12K_11D_IDLE;
+	complete(&ar->completed_11d_scan);
 
 	spin_lock_bh(&ar->data_lock);
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
@@ -8072,6 +8095,118 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	ath12k_mac_update_vif_offload(&ahvif->deflink);
 }
 
+static bool ath12k_mac_vif_ap_active_any(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	struct ath12k_link_vif *arvif;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		list_for_each_entry(arvif, &ar->arvifs, list) {
+			if (arvif->is_up &&
+			    arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP)
+				return true;
+		}
+	}
+	return false;
+}
+
+void ath12k_mac_11d_scan_start(struct ath12k *ar, u32 vdev_id)
+{
+	struct wmi_11d_scan_start_arg arg;
+	int ret;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
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
+	arg.vdev_id = vdev_id;
+	arg.start_interval_msec = 0;
+	arg.scan_period_msec = ATH12K_SCAN_11D_INTERVAL;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac start 11d scan for vdev %d\n", vdev_id);
+
+	ret = ath12k_wmi_send_11d_scan_start_cmd(ar, &arg);
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
+}
+
+void ath12k_mac_11d_scan_stop(struct ath12k *ar)
+{
+	int ret;
+	u32 vdev_id;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (!test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map))
+		return;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac stop 11d for vdev %d\n",
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
 int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 {
 	struct ath12k_hw *ah = ar->ah;
@@ -8206,6 +8341,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+		ath12k_mac_11d_scan_stop_all(ar->ab);
 		break;
 	case WMI_VDEV_TYPE_STA:
 		param_id = WMI_STA_PS_PARAM_RX_WAKE_POLICY;
@@ -8244,6 +8380,13 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+
+		if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map) &&
+		    ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+		    ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE) {
+			reinit_completion(&ar->completed_11d_scan);
+			ar->state_11d = ATH12K_11D_PREPARING;
+		}
 		break;
 	default:
 		break;
@@ -9571,6 +9714,14 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
+
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ab->wmi_ab.svc_map) &&
+	    ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ahvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE &&
+	    ar->state_11d != ATH12K_11D_PREPARING) {
+		reinit_completion(&ar->completed_11d_scan);
+		ar->state_11d = ATH12K_11D_PREPARING;
+	}
 }
 
 static int
@@ -11392,6 +11543,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	ar->num_tx_chains = hweight32(pdev->cap.tx_chain_mask);
 	ar->num_rx_chains = hweight32(pdev->cap.rx_chain_mask);
 	ar->scan.arvif = NULL;
+	ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
 
 	spin_lock_init(&ar->data_lock);
 	INIT_LIST_HEAD(&ar->arvifs);
@@ -11407,6 +11559,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->scan.completed);
 	init_completion(&ar->scan.on_channel);
 	init_completion(&ar->mlo_setup_done);
+	init_completion(&ar->completed_11d_scan);
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index ae35b73312bf..6b3dce98185a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -66,6 +66,13 @@ struct ath12k_mac_get_any_chanctx_conf_arg {
 
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
+#define ATH12K_SCAN_11D_INTERVAL		600000
+#define ATH12K_11D_INVALID_VDEV_ID		0xFFFF
+
+void ath12k_mac_11d_scan_start(struct ath12k *ar, u32 vdev_id);
+void ath12k_mac_11d_scan_stop(struct ath12k *ar);
+void ath12k_mac_11d_scan_stop_all(struct ath12k_base *ab);
+
 void ath12k_mac_destroy(struct ath12k_hw_group *ag);
 void ath12k_mac_unregister(struct ath12k_hw_group *ag);
 int ath12k_mac_register(struct ath12k_hw_group *ag);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 439d61f284d8..01741b1fb5bb 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/rtnetlink.h>
 #include "core.h"
@@ -94,10 +94,16 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 		if (ret)
 			ath12k_warn(ar->ab,
 				    "INIT Country code set to fw failed : %d\n", ret);
+
+		wiphy_lock(wiphy);
+		ath12k_mac_11d_scan_stop(ar);
+		wiphy_unlock(wiphy);
+
+		ar->regdom_set_by_user = true;
 	}
 }
 
-int ath12k_reg_update_chan_list(struct ath12k *ar)
+int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 {
 	struct ieee80211_supported_band **bands;
 	struct ath12k_wmi_scan_chan_list_arg *arg;
@@ -106,7 +112,35 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
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
+	if (ar->ah->state == ATH12K_HW_STATE_RESTARTING)
+		return 0;
 
 	bands = hw->wiphy->bands;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
@@ -295,7 +329,7 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	 */
 	for_each_ar(ah, ar, i) {
 		ab = ar->ab;
-		ret = ath12k_reg_update_chan_list(ar);
+		ret = ath12k_reg_update_chan_list(ar, true);
 		if (ret)
 			goto err;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 75f80df2aa0c..b1eb584ff34c 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -99,6 +99,6 @@ struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
 						  struct ath12k_reg_info *reg_info,
 						  bool intersect);
 int ath12k_regd_update(struct ath12k *ar, bool init);
-int ath12k_reg_update_chan_list(struct ath12k *ar);
+int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 0794aaf9ca03..80e285207785 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -177,6 +177,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct ath12k_wmi_p2p_noa_info) },
 	[WMI_TAG_P2P_NOA_EVENT] = {
 		.min_len = sizeof(struct wmi_p2p_noa_event) },
+	[WMI_TAG_11D_NEW_COUNTRY_EVENT] = {
+		.min_len = sizeof(struct wmi_11d_new_cc_event) },
 };
 
 __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
@@ -2591,7 +2593,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	cmd->scan_id = cpu_to_le32(arg->scan_id);
 	cmd->scan_req_id = cpu_to_le32(arg->scan_req_id);
 	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
-	cmd->scan_priority = cpu_to_le32(arg->scan_priority);
+	if (ar->state_11d == ATH12K_11D_PREPARING)
+		arg->scan_priority = WMI_SCAN_PRIORITY_MEDIUM;
+	else
+		arg->scan_priority = WMI_SCAN_PRIORITY_LOW;
 	cmd->notify_scan_events = cpu_to_le32(arg->notify_scan_events);
 
 	ath12k_wmi_copy_scan_event_cntrl_flags(cmd, arg);
@@ -3349,6 +3354,74 @@ int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_send_11d_scan_start_cmd(struct ath12k *ar,
+				       struct wmi_11d_scan_start_arg *arg)
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
+	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
+	cmd->scan_period_msec = cpu_to_le32(arg->scan_period_msec);
+	cmd->start_interval_msec = cpu_to_le32(arg->start_interval_msec);
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_11D_SCAN_START_CMDID);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "send 11d scan start vdev id %d period %d ms internal %d ms\n",
+		   arg->vdev_id, arg->scan_period_msec,
+		   arg->start_interval_msec);
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
@@ -5969,6 +6042,50 @@ static void ath12k_wmi_op_ep_tx_credits(struct ath12k_base *ab)
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
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
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
@@ -8673,6 +8790,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_HALPHY_STATS_CTRL_PATH_EVENTID:
 		ath12k_wmi_process_tpc_stats(ab, skb);
 		break;
+	case WMI_11D_NEW_COUNTRY_EVENTID:
+		ath12k_reg_11d_new_cc_event(ab, skb);
+		break;
 	/* add Unsupported events (rare) here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 8a8504ccdc02..b011a52d40e4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4026,6 +4026,28 @@ struct wmi_init_country_cmd {
 	} cc_info;
 } __packed;
 
+struct wmi_11d_scan_start_arg {
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
@@ -6008,6 +6030,9 @@ int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
 					   dma_addr_t paddr, u8 tid,
 					   u8 ba_window_size_valid,
 					   u32 ba_window_size);
+int ath12k_wmi_send_11d_scan_start_cmd(struct ath12k *ar,
+				       struct wmi_11d_scan_start_arg *arg);
+int ath12k_wmi_send_11d_scan_stop_cmd(struct ath12k *ar, u32 vdev_id);
 int
 ath12k_wmi_rx_reord_queue_remove(struct ath12k *ar,
 				 struct ath12k_wmi_rx_reorder_queue_remove_arg *arg);
-- 
2.34.1


