Return-Path: <linux-wireless+bounces-12575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70E96E848
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 05:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEA91C22C13
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 03:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959353D96A;
	Fri,  6 Sep 2024 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GvnLdfDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B11B969
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593552; cv=none; b=Ea4+xY6crXnotSpkNFvRNc4bmw9Uv59aA8PUS8Dn9RXnoc40kTm/2G5VIvFHsAmIQCve+NFdOkHlu7j3aUeNJLHCf77FOvVwvQionKBpFrckGM3us1z8D0ldDBwA+OhFdcoD4kzS9rbyY9sGf+rb0lnKaF79YRM1QY+6KM5UZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593552; c=relaxed/simple;
	bh=mqp153UZztp9ivd7up5T3NzTTMOXWcWfegF/fOube1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7ueoZVqwTsVhhKq6t2pGkUGeuwUFN7mp3iiLDkS7ug5K6YlKfqi7Kb4ZkdLWLscoXQExqZ2X1ARpNq1oaZKwqjF6WhJcsAuEaCpT0WvZqXu/i6enbosInoiujSyIstDfkfS3v8AyKaNtTsaCWk52XfuUxmhd7h29fXU9qjKHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GvnLdfDG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IUmG7024715;
	Fri, 6 Sep 2024 03:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PNro/IRSuF/Zm5yEV7WXgPPtpc2M64sw2Xt341DdeX4=; b=GvnLdfDGde3QKIzr
	DgrguIAM0A/q8yUWW3zZg5+uYtC9uykCIzmj88ioRZLoiRCXncxZiT3gDrLvbdY8
	Rbkrx8V4TL/C1UXwi3qzFiODGI9fuxhoo4zGBPLHbUYj3kf4dhuJsaZVZj3NfnLa
	AzC3UnLwld4PxfIOZE8eGao5BK9f/9hxQXlXX7MVae/NHpNk/QbotlMVhbClapES
	BNBz3fZXwg74nfIqOf1ZkxHa8LWcEYzMfndxfiIKYnvKpb7CUxSxSftguPX8QetF
	nYj4qG1NLu7X5preuelAZJp0qh8F15iYRT7GVZx+TV1d2qhR5NE5zEIONdsLc/wj
	IBrWqw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fj038wds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 03:32:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4863WPHM025973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 03:32:25 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 20:32:24 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath11k: move update channel list to worker for wait flag
Date: Fri, 6 Sep 2024 11:32:00 +0800
Message-ID: <20240906033200.472-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240906033200.472-1-quic_kangyang@quicinc.com>
References: <20240906033200.472-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: z0-1BjU7Xp9Tt7ms6xoDiUGi3M_WZfrX
X-Proofpoint-ORIG-GUID: z0-1BjU7Xp9Tt7ms6xoDiUGi3M_WZfrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409060024

From: Wen Gong <quic_wgong@quicinc.com>

When wait flag is set for ath11k_reg_update_chan_list(), it will wait
the completion of 11d/hw scan if 11d/hw scan is running.

With the previous patch "wifi: ath11k: move update channel list from
update reg worker to reg notifier", ath11k_reg_update_chan_list() will
be called when reg_work is running. The global lock rtnl_lock will be
held by reg_work in the meantime. If the wait_for_completion_timeout()
is called due to 11d/hw scan is running, the occupation time of
rtnl_lock will increase. This will increase blocking time for other
threads if they want to use rtnl_lock.

Move update channel list operation in ath11k_reg_update_chan_list() to
a new worker, then the wait of completion of 11d/hw scan will not
happen in reg_work and not increase the occupation time of the rtnl_lock.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  4 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 15 +++++
 drivers/net/wireless/ath/ath11k/reg.c  | 90 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/reg.h  |  1 +
 drivers/net/wireless/ath/ath11k/wmi.h  |  1 +
 6 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 03187df26000..ae9b42b4f50c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1974,6 +1974,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	ath11k_mac_scan_finish(ar);
 	ath11k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->update_11d_work);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7122176dd91e..73bdf0e9e976 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -739,6 +739,10 @@ struct ath11k {
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
+	struct work_struct channel_update_work;
+	struct list_head channel_update_queue;
+	/* protects channel_update_queue data */
+	spinlock_t channel_update_lock;
 
 	struct work_struct wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f8068d2e848c..40ae8ad61c4a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6289,6 +6289,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ath11k *ar = hw->priv;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
+	struct scan_chan_list_params *params;
 	int ret;
 
 	ath11k_mac_drain_tx(ar);
@@ -6304,6 +6305,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
 
@@ -6319,6 +6321,15 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	}
 	spin_unlock_bh(&ar->data_lock);
 
+	spin_lock_bh(&ar->channel_update_lock);
+	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
+						  struct scan_chan_list_params,
+						  list))) {
+		list_del(&params->list);
+		kfree(params);
+	}
+	spin_unlock_bh(&ar->channel_update_lock);
+
 	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
 
 	synchronize_rcu();
@@ -10019,6 +10030,7 @@ static const struct wiphy_iftype_ext_capab ath11k_iftypes_ext_capa[] = {
 
 static void __ath11k_mac_unregister(struct ath11k *ar)
 {
+	cancel_work_sync(&ar->channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 
 	ieee80211_unregister_hw(ar->hw);
@@ -10418,6 +10430,9 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->thermal.wmi_sync);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
+		INIT_WORK(&ar->channel_update_work, ath11k_regd_update_chan_list_work);
+		INIT_LIST_HEAD(&ar->channel_update_queue);
+		spin_lock_init(&ar->channel_update_lock);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
 
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath11k_mgmt_over_wmi_tx_work);
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index cb2cf9b63d18..8df7503997db 100644
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
@@ -231,8 +206,15 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 		}
 	}
 
-	ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
-	kfree(params);
+	if (wait) {
+		spin_lock_bh(&ar->channel_update_lock);
+		list_add_tail(&params->list, &ar->channel_update_queue);
+		spin_unlock_bh(&ar->channel_update_lock);
+		queue_work(ar->ab->workqueue, &ar->channel_update_work);
+	} else {
+		ret = ath11k_wmi_send_scan_chan_list_cmd(ar, params);
+		kfree(params);
+	}
 
 	return ret;
 }
@@ -811,6 +793,58 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
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
+	spin_lock_bh(&ar->channel_update_lock);
+	while ((params = list_first_entry_or_null(&ar->channel_update_queue,
+						  struct scan_chan_list_params,
+						  list))) {
+		list_del(&params->list);
+		list_add_tail(&params->list, &local_update_list);
+	}
+	spin_unlock_bh(&ar->channel_update_lock);
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


