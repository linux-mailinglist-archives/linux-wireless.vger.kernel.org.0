Return-Path: <linux-wireless+bounces-13692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50E994048
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85BE2871B6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B771D07A7;
	Tue,  8 Oct 2024 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bG+jON3e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7F1F4710
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370782; cv=none; b=t5/0n6qmNfT0xOUOXk08NpppTSNQRY/F3dgvZSWebrlaPDN/DEne9lScqWqnw0zVrPn939LtFo6192vSnamMntnK3AToA/GoQZRYl4TKahspOqRM14cFms+d7TKkHXvzhKsUMXhCVOO5ETxAL5OAytIdZOxA+miFsyGNqjTxHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370782; c=relaxed/simple;
	bh=VOi8l5NZq7ZxSHiTtDNNJA4TyyTZnha4tiBfjSPjkv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAp/BZ0SYUyJksHhzyhlcmyC6KmaPLaKLhJiUR2DYOOvsU38fhU55nSPTwuO1a1JsjNXzl9npo9U/GB8SjQho65VOkj+FXNgUPNkcLkKAAOcmMSqx1psMVkOo8Z41Kb5T2nKcVrt4AZPWONePGoR/NmdI2ZghcsjQrTSWR+JxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bG+jON3e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984CrgC000652;
	Tue, 8 Oct 2024 06:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJbfM5qzc98ytv4uHfEAWXfnzctzXwvKqIs6vG3gPYY=; b=bG+jON3e3BVhWLx9
	Yzm/KgucBqy4mRFglCrLi8IgIJ6WvLBhVjRG58UGGGVPuAAW9AoaV81qXF4JzUny
	f5sQuOK6BXto1VvLJWJIVKFVhmk6dsIYpCXJBjAYdxJaChFF0YMSXp7/aiZO+SIH
	veYiuHYxzDWkZNYO/wDY9p+HuEijmBlPmAyo55MYaVzyfK2VE5Leq9XKFMa0t4On
	S65kdn4XeT5cvbGKgKm//5ycQxtZkiyx1kD1jvLZRGdO02mcPH81RebcAbzXkrAi
	Cn3vmjcPozscyE9itHYQifwRhe3wGzsw4+7YcfHsOGnamlu2JXV/PdtkA9lTUl3Q
	eQrHHg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wgs0avf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 06:59:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4986xW1b001701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 06:59:32 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 23:59:31 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 2/4] wifi: ath12k: add 11d scan offload support
Date: Tue, 8 Oct 2024 14:56:36 +0800
Message-ID: <20241008065638.1142-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241008065638.1142-1-quic_kangyang@quicinc.com>
References: <20241008065638.1142-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: y1ag9w2Ql62BqZioGJrjpEaAKvGIRVgt
X-Proofpoint-ORIG-GUID: y1ag9w2Ql62BqZioGJrjpEaAKvGIRVgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080044

From: Wen Gong <quic_wgong@quicinc.com>

Add process of event WMI_11D_NEW_COUNTRY_EVENTID. Add handler for
WMI_11D_SCAN_START_CMDID, WMI_11D_SCAN_STOP_CMDID.
Use WMI_11D_SCAN_START_CMDID to trigger 11d scan then firmware will
report 11d scan result by WMI_11D_NEW_COUNTRY_EVENTID. Host will
update the new country code back to firmware.

The priority of 11d scan is WMI_SCAN_PRIORITY_MEDIUM in firmware, the
priority of hw scan is WMI_SCAN_PRIORITY_LOW. Then hw scan will be
canceled when 11d scan is running.

To avoid this, need to change the priority of first hw scan to
WMI_SCAN_PRIORITY_MEDIUM. Add wait_for_completion_timeout() for
scan.complete in ath12k_reg_update_chan_list(). Plus another existing
wait in ath12k_scan_stop(), there are two places to wait the
scan.complete. They run in different threads so it is possible that both
of the enter into wait status. Therefore use complete_all() instead of
complete() for scan.complete. complete_all() can work well when it is
only one thread wait for scan.complete.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  33 ++++-
 drivers/net/wireless/ath/ath12k/core.h |  16 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 159 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath12k/reg.c  |  40 ++++++-
 drivers/net/wireless/ath/ath12k/reg.h  |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 122 ++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  |  25 ++++
 8 files changed, 396 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 51252e8bc1ae..8e469afba7f0 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1014,6 +1014,7 @@ void ath12k_core_halt(struct ath12k *ar)
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->rfkill_work);
+	cancel_work_sync(&ab->update_11d_work);
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
@@ -1021,6 +1022,33 @@ void ath12k_core_halt(struct ath12k *ar)
 	idr_init(&ar->txmgmt_idr);
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
 static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -1045,8 +1073,10 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
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
@@ -1312,6 +1342,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->restart_work, ath12k_core_restart);
 	INIT_WORK(&ab->reset_work, ath12k_core_reset);
 	INIT_WORK(&ab->rfkill_work, ath12k_rfkill_work);
+	INIT_WORK(&ab->update_11d_work, ath12k_update_11d);
 
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7f2e9a9b4097..3d80a1c6e032 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -199,6 +199,12 @@ enum ath12k_scan_state {
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
@@ -319,6 +325,8 @@ struct ath12k_vif_iter {
 #define ATH12K_RX_RATE_TABLE_11AX_NUM	576
 #define ATH12K_RX_RATE_TABLE_NUM 320
 
+#define ATH12K_SCAN_TIMEOUT_HZ (20 * HZ)
+
 struct ath12k_rx_peer_rate_stats {
 	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
 	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT + 1];
@@ -654,6 +662,12 @@ struct ath12k {
 	u32 freq_low;
 	u32 freq_high;
 
+	/* Protected by wiphy::mtx lock. */
+	u32 vdev_id_11d_scan;
+	struct completion completed_11d_scan;
+	enum ath12k_11d_state state_11d;
+	bool regdom_set_by_user;
+
 	bool nlo_enabled;
 };
 
@@ -886,6 +900,8 @@ struct ath12k_base {
 	/* continuous recovery fail count */
 	atomic_t fail_cont_count;
 	unsigned long reset_fail_timeout;
+	struct work_struct update_11d_work;
+	u8 new_alpha2[2];
 	struct {
 		/* protected by data_lock */
 		u32 fw_crash_counter;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6d0784a21558..8d87ea8b50ad 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2949,6 +2949,11 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	if (ret)
 		ath12k_warn(ar->ab, "failed to set vdev %i OBSS PD parameters: %d\n",
 			    arvif->vdev_id, ret);
+
+	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map) &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_stop_all(ar->ab);
 }
 
 static void ath12k_bss_disassoc(struct ath12k *ar,
@@ -3524,7 +3529,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
 		ar->scan_channel = NULL;
 		ar->scan.roc_freq = 0;
 		cancel_delayed_work(&ar->scan.timeout);
-		complete(&ar->scan.completed);
+		complete_all(&ar->scan.completed);
 		break;
 	}
 }
@@ -3790,7 +3795,12 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
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
@@ -3810,6 +3820,11 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	mutex_unlock(&ar->conf_mutex);
 
+	if (ar->state_11d == ATH12K_11D_PREPARING &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE)
+		ath12k_mac_11d_scan_start(ar, arvif->vdev_id);
+
 	return ret;
 }
 
@@ -5994,7 +6009,7 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 	/* TODO: Do we need to enable ANI? */
 
-	ath12k_reg_update_chan_list(ar);
+	ath12k_reg_update_chan_list(ar, false);
 
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
@@ -6174,6 +6189,9 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->rfkill_work);
+	cancel_work_sync(&ar->ab->update_11d_work);
+	ar->state_11d = ATH12K_11D_IDLE;
+	complete(&ar->completed_11d_scan);
 
 	spin_lock_bh(&ar->data_lock);
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
@@ -6420,6 +6438,117 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	ath12k_mac_update_vif_offload(arvif);
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
 static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 {
 	struct ath12k_hw *ah = ar->ah;
@@ -6534,6 +6663,7 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 				    arvif->vdev_id, ret);
 			goto err_peer_del;
 		}
+		ath12k_mac_11d_scan_stop_all(ar->ab);
 		break;
 	case WMI_VDEV_TYPE_STA:
 		param_id = WMI_STA_PS_PARAM_RX_WAKE_POLICY;
@@ -6572,6 +6702,13 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
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
 		break;
 	default:
 		break;
@@ -6912,6 +7049,11 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
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
@@ -7752,6 +7894,14 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
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
 
@@ -9339,6 +9489,9 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 	INIT_WORK(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
+
+	ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
+	init_completion(&ar->completed_11d_scan);
 }
 
 int ath12k_mac_register(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 5efbb6822628..28cc113b7d00 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -51,6 +51,13 @@ enum ath12k_supported_bw {
 
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
index 439d61f284d8..aecfd55aef59 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
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
index 29c7ec3260da..e4ceae46e556 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_REG_H
@@ -96,6 +96,6 @@ struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
 						  struct ath12k_reg_info *reg_info,
 						  bool intersect);
 int ath12k_regd_update(struct ath12k *ar, bool init);
-int ath12k_reg_update_chan_list(struct ath12k *ar);
+int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f7b6e0a45f7c..f60c0eeb221f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -171,6 +171,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct ath12k_wmi_p2p_noa_info) },
 	[WMI_TAG_P2P_NOA_EVENT] = {
 		.min_len = sizeof(struct wmi_p2p_noa_event) },
+	[WMI_TAG_11D_NEW_COUNTRY_EVENT] = {
+		.min_len = sizeof(struct wmi_11d_new_cc_event) },
 };
 
 static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
@@ -2364,7 +2366,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
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
@@ -3120,6 +3125,74 @@ int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
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
@@ -5705,6 +5778,50 @@ static void ath12k_wmi_op_ep_tx_credits(struct ath12k_base *ab)
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
@@ -7306,6 +7423,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
 		ath12k_wmi_gtk_offload_status_event(ab, skb);
 		break;
+	case WMI_11D_NEW_COUNTRY_EVENTID:
+		ath12k_reg_11d_new_cc_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 1797f5c88fb5..dad40b21d974 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3860,6 +3860,28 @@ struct wmi_init_country_cmd {
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
@@ -5565,6 +5587,9 @@ int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
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


