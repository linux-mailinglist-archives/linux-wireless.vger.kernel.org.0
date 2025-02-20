Return-Path: <linux-wireless+bounces-19179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A548FA3D31B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C453A4682
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188B1EB192;
	Thu, 20 Feb 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dtnlPDmQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBBD1EB181
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039914; cv=none; b=pzEHYL0+H+rk3twpDndDSJh5lEn6aZiLFXsB4Z/jabRwiwuU/Ex1yrKPxefCCXE6TOW9DyHgli5w+ZWxk4g1dxzCH7jzF981SbvB87424YIIevQzIzDeZ+YKW+JdFQgqhs6AkytxMqC1PoMF0A3Z4UWump50Ird9mmpJ3HSHpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039914; c=relaxed/simple;
	bh=0oIuBV9zQkztFuaI/3dratPvAK3GOqI8qVxaQ4xPa08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAe8PsyPUrfzzshh3kVw5VV7FntqEBudg9hsAomJjTxbLzLD33A9n+PpMMWc/2nz+sOyrR6H3FFHVXnQA+yzTt43JaXu+akUCMxnlOIWM/+Rzy44wYKc8DCCNLCxVdQQcSreSe50fDS2WEH7Kuv3MhGwiGEaLxKf6NNn1GdlLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dtnlPDmQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K53HdZ023289;
	Thu, 20 Feb 2025 08:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a9iEWNtgnaAAHg0KsqwQ6ZdSVRD/0Arsp1LZm4T8A+k=; b=dtnlPDmQy8QXDyZ2
	iZPOJyYcLMoDwtsAFGcPpmoVnZcBbjxdC+bnzJiE2EDYfaal2eMBTps4dMi0PgtH
	mWrHNcrJ8lxvKhklJJt1P5s0K00dyXhs6yEw9z2MOXRRLtHz8jAwRNMe7E7G9Tzl
	5U5jiDwL93QDdldOpljZ4Iw5UnOJwo0/f2IXTpxTLHAtNZEcolndzHH6nLtfN2zB
	xnZHlGMEolbTO7keEUonehP4QhKY4l1dXHeIQ4hzEescIGuhZIF5FLDMZNvaqW/x
	dpSGnR9SAyS5XeW2bEUeIhqy4DyHwFiOiWyOcdb9H9dc+25YVK9aGJ/keJu9kLi0
	dYkGdQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3ngk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8P6r0030933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:06 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 00:25:04 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 4/7] wifi: ath11k: move some firmware stats related functions outside of debugfs
Date: Thu, 20 Feb 2025 16:24:45 +0800
Message-ID: <20250220082448.31039-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220082448.31039-1-quic_bqiang@quicinc.com>
References: <20250220082448.31039-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bHZJCx4I4cpGJLctYc0SNQidtIAIRjPh
X-Proofpoint-ORIG-GUID: bHZJCx4I4cpGJLctYc0SNQidtIAIRjPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200060

Commit b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
and commit c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")
call debugfs functions in mac ops. Those functions are no-ops if CONFIG_ATH11K_DEBUGFS is
not enabled, thus cause wrong status reported.

Move them to mac.c.

Besides, since WMI_REQUEST_RSSI_PER_CHAIN_STAT and WMI_REQUEST_VDEV_STAT stats could also
be requested via mac ops, process them directly in ath11k_update_stats_event().

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
Fixes: c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 126 ++--------------------
 drivers/net/wireless/ath/ath11k/debugfs.h |  10 +-
 drivers/net/wireless/ath/ath11k/mac.c     |  88 ++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h     |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c     |  45 +++++++-
 5 files changed, 135 insertions(+), 138 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index ccf0e62c7d7a..5d46f8e4c231 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -93,58 +93,14 @@ void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 	spin_unlock_bh(&dbr_data->lock);
 }
 
-static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
-{
-	spin_lock_bh(&ar->data_lock);
-	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
-	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
-	ar->fw_stats.num_vdev_recvd = 0;
-	ar->fw_stats.num_bcn_recvd = 0;
-	spin_unlock_bh(&ar->data_lock);
-}
-
 void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *stats)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_pdev *pdev;
 	bool is_end = true;
-	size_t total_vdevs_started = 0;
-	int i;
-
-	/* WMI_REQUEST_PDEV_STAT request has been already processed */
-
-	if (stats->stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
-		complete(&ar->fw_stats_done);
-		return;
-	}
-
-	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
-		if (list_empty(&stats->vdevs)) {
-			ath11k_warn(ab, "empty vdev stats");
-			return;
-		}
-		/* FW sends all the active VDEV stats irrespective of PDEV,
-		 * hence limit until the count of all VDEVs started
-		 */
-		for (i = 0; i < ab->num_radios; i++) {
-			pdev = rcu_dereference(ab->pdevs_active[i]);
-			if (pdev && pdev->ar)
-				total_vdevs_started += ar->num_started_vdevs;
-		}
-
-		if (total_vdevs_started)
-			is_end = ((++ar->fw_stats.num_vdev_recvd) ==
-				  total_vdevs_started);
-
-		list_splice_tail_init(&stats->vdevs,
-				      &ar->fw_stats.vdevs);
-
-		if (is_end)
-			complete(&ar->fw_stats_done);
-
-		return;
-	}
 
+	/* WMI_REQUEST_PDEV_STAT, WMI_REQUEST_RSSI_PER_CHAIN_STAT and
+	 * WMI_REQUEST_VDEV_STAT requests have been already processed.
+	 */
 	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
 		if (list_empty(&stats->bcn)) {
 			ath11k_warn(ab, "empty bcn stats");
@@ -165,76 +121,6 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 	}
 }
 
-static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
-					   struct stats_request_params *req_param)
-{
-	struct ath11k_base *ab = ar->ab;
-	unsigned long time_left;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	ath11k_debugfs_fw_stats_reset(ar);
-
-	reinit_completion(&ar->fw_stats_complete);
-	reinit_completion(&ar->fw_stats_done);
-
-	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
-
-	if (ret) {
-		ath11k_warn(ab, "could not request fw stats (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
-int ath11k_debugfs_get_fw_stats(struct ath11k *ar, u32 pdev_id,
-				u32 vdev_id, u32 stats_id)
-{
-	struct ath11k_base *ab = ar->ab;
-	struct stats_request_params req_param;
-	int ret;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto err_unlock;
-	}
-
-	req_param.pdev_id = pdev_id;
-	req_param.vdev_id = vdev_id;
-	req_param.stats_id = stats_id;
-
-	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
-	if (ret)
-		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
-
-	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
-		   pdev_id, vdev_id, stats_id);
-
-err_unlock:
-	mutex_unlock(&ar->conf_mutex);
-
-	return ret;
-}
-
 static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
 {
 	struct ath11k *ar = inode->i_private;
@@ -260,7 +146,7 @@ static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
 	req_param.vdev_id = 0;
 	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
 
-	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
 	if (ret) {
 		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
 		goto err_free;
@@ -331,7 +217,7 @@ static int ath11k_open_vdev_stats(struct inode *inode, struct file *file)
 	req_param.vdev_id = 0;
 	req_param.stats_id = WMI_REQUEST_VDEV_STAT;
 
-	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to request fw vdev stats: %d\n", ret);
 		goto err_free;
@@ -407,7 +293,7 @@ static int ath11k_open_bcn_stats(struct inode *inode, struct file *file)
 			continue;
 
 		req_param.vdev_id = arvif->vdev_id;
-		ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+		ret = ath11k_mac_fw_stats_request(ar, &req_param);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to request fw bcn stats: %d\n", ret);
 			goto err_free;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index a39e458637b0..ed7fec177588 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH11K_DEBUGFS_H_
@@ -273,8 +273,6 @@ void ath11k_debugfs_unregister(struct ath11k *ar);
 void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *stats);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
-int ath11k_debugfs_get_fw_stats(struct ath11k *ar, u32 pdev_id,
-				u32 vdev_id, u32 stats_id);
 
 static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
@@ -381,12 +379,6 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
-static inline int ath11k_debugfs_get_fw_stats(struct ath11k *ar,
-					      u32 pdev_id, u32 vdev_id, u32 stats_id)
-{
-	return 0;
-}
-
 static inline void
 ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 				enum wmi_direct_buffer_module id,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e28dae55c802..abc01a11e3fd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8992,6 +8992,86 @@ static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
 	}
 }
 
+static void ath11k_mac_fw_stats_reset(struct ath11k *ar)
+{
+	spin_lock_bh(&ar->data_lock);
+	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
+	spin_unlock_bh(&ar->data_lock);
+}
+
+int ath11k_mac_fw_stats_request(struct ath11k *ar,
+				struct stats_request_params *req_param)
+{
+	struct ath11k_base *ab = ar->ab;
+	unsigned long time_left;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ath11k_mac_fw_stats_reset(ar);
+
+	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
+
+	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
+
+	if (ret) {
+		ath11k_warn(ab, "could not request fw stats (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
+				   u32 vdev_id, u32 stats_id)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	req_param.pdev_id = pdev_id;
+	req_param.vdev_id = vdev_id;
+	req_param.stats_id = stats_id;
+
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
+	if (ret)
+		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   pdev_id, vdev_id, stats_id);
+
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
 static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
@@ -9029,8 +9109,8 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) &&
 	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
 	    ar->ab->hw_params.supports_rssi_stats &&
-	    !ath11k_debugfs_get_fw_stats(ar, ar->pdev->pdev_id, 0,
-					 WMI_REQUEST_RSSI_PER_CHAIN_STAT)) {
+	    !ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				     WMI_REQUEST_RSSI_PER_CHAIN_STAT)) {
 		ath11k_mac_put_chain_rssi(sinfo, arsta, "fw stats", true);
 	}
 
@@ -9038,8 +9118,8 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	if (!signal &&
 	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
 	    ar->ab->hw_params.supports_rssi_stats &&
-	    !(ath11k_debugfs_get_fw_stats(ar, ar->pdev->pdev_id, 0,
-					WMI_REQUEST_VDEV_STAT)))
+	    !(ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				      WMI_REQUEST_VDEV_STAT)))
 		signal = arsta->rssi_beacon;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index f5800fbecff8..5e61eea1bb03 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_MAC_H
@@ -179,4 +179,6 @@ int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
 void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_chanctx_conf *ctx);
+int ath11k_mac_fw_stats_request(struct ath11k *ar,
+				struct stats_request_params *req_param);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 27cb0bb06b93..98811726d33b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8158,6 +8158,11 @@ static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff
 static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct ath11k_fw_stats stats = {};
+	size_t total_vdevs_started = 0;
+	struct ath11k_pdev *pdev;
+	bool is_end = true;
+	int i;
+
 	struct ath11k *ar;
 	int ret;
 
@@ -8184,7 +8189,8 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 
 	spin_lock_bh(&ar->data_lock);
 
-	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
+	/* WMI_REQUEST_PDEV_STAT, WMI_REQUEST_VDEV_STAT and
+	 * WMI_REQUEST_RSSI_PER_CHAIN_STAT can be requested via mac ops or via
 	 * debugfs fw stats. Therefore, processing it separately.
 	 */
 	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
@@ -8193,9 +8199,40 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 		goto complete;
 	}
 
-	/* WMI_REQUEST_VDEV_STAT, WMI_REQUEST_BCN_STAT and WMI_REQUEST_RSSI_PER_CHAIN_STAT
-	 * are currently requested only via debugfs fw stats. Hence, processing these
-	 * in debugfs context
+	if (stats.stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
+		complete(&ar->fw_stats_done);
+		goto complete;
+	}
+
+	if (stats.stats_id == WMI_REQUEST_VDEV_STAT) {
+		if (list_empty(&stats.vdevs)) {
+			ath11k_warn(ab, "empty vdev stats");
+			goto complete;
+		}
+		/* FW sends all the active VDEV stats irrespective of PDEV,
+		 * hence limit until the count of all VDEVs started
+		 */
+		for (i = 0; i < ab->num_radios; i++) {
+			pdev = rcu_dereference(ab->pdevs_active[i]);
+			if (pdev && pdev->ar)
+				total_vdevs_started += ar->num_started_vdevs;
+		}
+
+		if (total_vdevs_started)
+			is_end = ((++ar->fw_stats.num_vdev_recvd) ==
+				  total_vdevs_started);
+
+		list_splice_tail_init(&stats.vdevs,
+				      &ar->fw_stats.vdevs);
+
+		if (is_end)
+			complete(&ar->fw_stats_done);
+
+		goto complete;
+	}
+
+	/* WMI_REQUEST_BCN_STAT is currently requested only via debugfs fw stats.
+	 * Hence, processing it in debugfs context
 	 */
 	ath11k_debugfs_fw_stats_process(ar, &stats);
 
-- 
2.25.1


