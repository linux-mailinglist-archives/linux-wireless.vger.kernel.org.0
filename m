Return-Path: <linux-wireless+bounces-16369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F8C9F081A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 10:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368E2282859
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8641B0103;
	Fri, 13 Dec 2024 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m/2Qn6f+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15581B3958
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082786; cv=none; b=Hy5GtQFqlojA1j80dDsGmqRpJ1fpk0QiKhZlUep1YuZYiNboxel09PE/MSG2HBROW6tn8akvr1w6bLCm9/p1ZYHXBrBP87bNL+GFuItSmX5oD7q4J4TFQT+E7KTKzoCgw+SB12aTI9Ce2Z2DQNrid+mixAcuiyYQOGsKdHgA8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082786; c=relaxed/simple;
	bh=gyT70xDYyVwIzhD9AVfwoygwsbWuKKXjQMaETwmjNu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH4VmALuexF5IVhKhbjEG+HhbzdyjgWij5D1AzbLKap5fe4bE/kyMPgKKu+w6j+W7TBLqWHeFkM7zRfZPrByzWsO1bjGdv8xQ8Icui6ey6e2S8khqVJ3xu/psbbgVxQ+LKpMHd/+MEvBoRSYNke415euj3BtP7jWwukss8keDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m/2Qn6f+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD2XtRT001149;
	Fri, 13 Dec 2024 09:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T1SD0ZnbKRqN29GXvH5SNGKOT3lqYKWL+bFaFxbKm58=; b=m/2Qn6f+zm+Ua4IQ
	AyrJHwfZqM5KfrLGa5lkd58o2EEn69wo33NhvpODNnAVppt3ENQsaHt0hsxWS7Tj
	z14vh9dw4g1VYxmJib2zdFZQzOwpgPNrSqccmE08L78tsgchJ33Vl4Ep/ePRiMGy
	DHESi23mFJSjdX6ELJm2LTa1G7K6GBgZQA5eLmqHFd8op1WeExzDEvSZ2CQOTOQ/
	pftoR21lhoJB6Yq4IADV4ADP8RWy51Gop7ymvKU4WqDqVSJoj9X5sQOtL/dFHzl/
	H+QEf5oZ/dsjOCxBvfEyb2i9bgv2QqI8iI+yWQHKhuv/AAEhE5DcqkQ4KvZNwsVF
	Vc0ZyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes4aq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:39:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD9dejF006434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:39:40 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 01:39:39 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 2/2] wifi: ath11k: move update channel list to worker when wait flag is set
Date: Fri, 13 Dec 2024 17:39:09 +0800
Message-ID: <20241213093909.629-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241213093909.629-1-quic_kangyang@quicinc.com>
References: <20241213093909.629-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eUlwCI2f-yTs-QKkkBn1WyGUuwRT-9Rb
X-Proofpoint-ORIG-GUID: eUlwCI2f-yTs-QKkkBn1WyGUuwRT-9Rb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130065

From: Wen Gong <quic_wgong@quicinc.com>

With previous patch "wifi: ath11k: move update channel list from update
reg worker to reg notifier", ath11k_reg_update_chan_list() will be
called during reg_process_self_managed_hint().

reg_process_self_managed_hint() will hold rtnl_lock all the time.
But ath11k_reg_update_chan_list() may increase the occupation time of
rtnl_lock, because wait flag is set and wait_for_completion_timeout()
will be called when 11d/hw scan is running.

Should minimize the occupation time of rtnl_lock as much as possible.

Move update channel list operation to a new worker, so that
wait_for_completion_timeout() won't be called and will not increase the
occupation time of rtnl_lock.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  4 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 14 +++++
 drivers/net/wireless/ath/ath11k/reg.c  | 87 +++++++++++++++++---------
 drivers/net/wireless/ath/ath11k/reg.h  |  1 +
 drivers/net/wireless/ath/ath11k/wmi.h  |  1 +
 6 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c576bbba52bf..e4db3cdecf29 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2056,6 +2056,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	ath11k_mac_scan_finish(ar);
 	ath11k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->update_11d_work);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a9dc7fe7765a..49c02cca501d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -685,7 +685,7 @@ struct ath11k {
 	struct mutex conf_mutex;
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath11k_sta info, ath11k_vif info,
-	 * channel context data, survey info, test mode data.
+	 * channel context data, survey info, test mode data, channel_update_queue.
 	 */
 	spinlock_t data_lock;
 
@@ -743,6 +743,8 @@ struct ath11k {
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
+	struct work_struct channel_update_work;
+	struct list_head channel_update_queue;
 
 	struct work_struct wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 31ae9b384a29..ec59ac829f79 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6288,6 +6288,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath11k *ar = hw->priv;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
+	struct scan_chan_list_params *params;
 	int ret;
 
 	ath11k_mac_drain_tx(ar);
@@ -6303,6 +6304,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
 
@@ -6312,10 +6314,19 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	}
 
 	spin_lock_bh(&ar->data_lock);
+
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
 		list_del(&ppdu_stats->list);
 		kfree(ppdu_stats);
 	}
+
+	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
+						  struct scan_chan_list_params,
+						  list))) {
+		list_del(&params->list);
+		kfree(params);
+	}
+
 	spin_unlock_bh(&ar->data_lock);
 
 	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
@@ -10018,6 +10029,7 @@ static const struct wiphy_iftype_ext_capab ath11k_iftypes_ext_capa[] = {
 
 static void __ath11k_mac_unregister(struct ath11k *ar)
 {
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 
 	ieee80211_unregister_hw(ar->hw);
@@ -10417,6 +10429,8 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->thermal.wmi_sync);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
+		INIT_WORK(&ar->channel_update_work, ath11k_regd_update_chan_list_work);
+		INIT_LIST_HEAD(&ar->channel_update_queue);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
 
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath11k_mgmt_over_wmi_tx_work);
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index cb2cf9b63d18..9f27860fd93e 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -124,32 +124,7 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 	struct channel_param *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret, left;
-
-	if (wait && ar->state_11d != ATH11K_11D_IDLE) {
-		left = wait_for_completion_timeout(&ar->completed_11d_scan,
-						   ATH11K_SCAN_TIMEOUT_HZ);
-		if (!left) {
-			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-				   "failed to receive 11d scan complete: timed out\n");
-			ar->state_11d = ATH11K_11D_IDLE;
-		}
-		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "11d scan wait left time %d\n", left);
-	}
-
-	if (wait &&
-	    (ar->scan.state == ATH11K_SCAN_STARTING ||
-	    ar->scan.state == ATH11K_SCAN_RUNNING)) {
-		left = wait_for_completion_timeout(&ar->scan.completed,
-						   ATH11K_SCAN_TIMEOUT_HZ);
-		if (!left)
-			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-				   "failed to receive hw scan complete: timed out\n");
-
-		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "hw scan wait left time %d\n", left);
-	}
+	int i, ret = 0;
 
 	if (ar->state == ATH11K_STATE_RESTARTING)
 		return 0;
@@ -231,8 +206,16 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 		}
 	}
 
-	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
-	kfree(params);
+	if (wait) {
+		spin_lock_bh(&ar->data_lock);
+		list_add_tail(&params->list, &ar->channel_update_queue);
+		spin_unlock_bh(&ar->data_lock);
+
+		queue_work(ar->ab->workqueue, &ar->channel_update_work);
+	} else {
+		ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
+		kfree(params);
+	}
 
 	return ret;
 }
@@ -811,6 +794,54 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	return new_regd;
 }
 
+void ath11k_regd_update_chan_list_work(struct work_struct *work)
+{
+	struct ath11k *ar = container_of(work, struct ath11k,
+					 channel_update_work);
+	struct scan_chan_list_params *params;
+	struct list_head local_update_list;
+	int left;
+
+	INIT_LIST_HEAD(&local_update_list);
+
+	spin_lock_bh(&ar->data_lock);
+	list_splice_tail_init(&ar->channel_update_queue, &local_update_list);
+	spin_unlock_bh(&ar->data_lock);
+
+	while ((params = list_first_entry_or_null(&local_update_list,
+						  struct scan_chan_list_params,
+						  list))) {
+		if (ar->state_11d != ATH11K_11D_IDLE) {
+			left = wait_for_completion_timeout(&ar->completed_11d_scan,
+							   ATH11K_SCAN_TIMEOUT_HZ);
+			if (!left) {
+				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+					   "failed to receive 11d scan complete: timed out\n");
+				ar->state_11d = ATH11K_11D_IDLE;
+			}
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+				   "reg 11d scan wait left time %d\n", left);
+		}
+
+		if ((ar->scan.state == ATH11K_SCAN_STARTING ||
+		     ar->scan.state == ATH11K_SCAN_RUNNING)) {
+			left = wait_for_completion_timeout(&ar->scan.completed,
+							   ATH11K_SCAN_TIMEOUT_HZ);
+			if (!left)
+				ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+					   "failed to receive hw scan complete: timed out\n");
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+				   "reg hw scan wait left time %d\n", left);
+		}
+
+		ath11k_wmi_send_scan_chan_list_cmd(ar, params);
+		list_del(&params->list);
+		kfree(params);
+	}
+}
+
 static bool ath11k_reg_is_world_alpha(char *alpha)
 {
 	if (alpha[0] == '0' && alpha[1] == '0')
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 263ea9061948..0d5e10bb5730 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -33,6 +33,7 @@ void ath11k_reg_init(struct ath11k *ar);
 void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
 void ath11k_reg_free(struct ath11k_base *ab);
 void ath11k_regd_update_work(struct work_struct *work);
+void ath11k_regd_update_chan_list_work(struct work_struct *work);
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
 		      struct cur_regulatory_info *reg_info, bool intersect,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8982b909c821..30b4b0c17682 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3817,6 +3817,7 @@ struct wmi_stop_scan_cmd {
 };
 
 struct scan_chan_list_params {
+	struct list_head list;
 	u32 pdev_id;
 	u16 nallchans;
 	struct channel_param ch_param[];
-- 
2.34.1


