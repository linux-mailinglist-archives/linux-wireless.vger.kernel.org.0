Return-Path: <linux-wireless+bounces-23733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4AACEBC8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31793168AA2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8613AD05;
	Thu,  5 Jun 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRh4mVcx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E31FBC92
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111960; cv=none; b=JrE/MlAOQ+KfKroDdViIs0P1d3Xh5tG08GawFrLaUrDMghUHqKtF26a8KPCGvoaSHNaX9kQc3zpLnBxDy3B9Rn6nXi+eVSjxQFSNzWkVck9UPS3CcnQOyRGKnpnMm5j2RKdCXttEKdDk44o0Dqk9lDAauz7AVQZh6WTXIssZEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111960; c=relaxed/simple;
	bh=0oYVyRPCqz1GhfpsOrztVzBmBzh2XzEW7JoEnUkxMjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+bX7QdNHrK/Gng3ISgn+NGUEGm4Z07o2/Q/nE4DpTAh2woyqiPimBOgSKvPu6l6x4wKkxUdA6KB1tJ/Upx/nevHmb4qz/8f31d/wyOYMkp3u3LX/YB7zACbdBfy1d8VODuC7Y1fjPc1r34ta1cN/GvqQ8LWmfWwIWcwJHyWiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pRh4mVcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557mtFl010362
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 08:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7AgNGohyuHwznRb/NWY98uyYm0XW6Bli7qL
	1fCuFkEY=; b=pRh4mVcxHICD+/ZTShxmDKiaz9ZG06pSp3nR5C6XzBnLTHul/1c
	z79lozKuPGRrfzDh+OWiijZzEIjiAOyV+2/0mjCxt8IhgzLkvunLrJCTihXhbWdI
	oaC1bUS3X1Pkf+F/hd8s20k9hIf5k8qET6BfZKe78AaQZq5AAW186QahKk/MqM1f
	VAfaFWMhTYb7kO/ooK6QOQ3fkVmN2/SRhv6P8zicPqXYKgLHuYQ8FLo6iSxgIiAw
	e5eHFKUtIY5Zsb7S3av136rj7sPSDDOY0ZViBH/a7PbXgrPRSnUDF+3Wjck1IDZC
	Bocr/mQKWm1P3Ar4W0PDSqcqvRnk+jhbycA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yrn5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Jun 2025 08:25:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a46163297eso16551441cf.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Jun 2025 01:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111957; x=1749716757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AgNGohyuHwznRb/NWY98uyYm0XW6Bli7qL1fCuFkEY=;
        b=OzLV/wtx7+BO6QGrM3QV9a5n46DCT55eZbGojWKWyI9ToK2/N/1z7VLVwX7660N1fR
         I65kvQQKGkkRC5/+AOOx2vHpbkIIFXX4ffCbKB3RNX2OCl63g+WGWrfWmjS4EpJ2DhfT
         2VCIte4Ed2lNhekJSuh3iI7hWeDKFylZEH8qHaqXrvy9CijYF9jTSla88kdlfKYrK/JJ
         Nnak7Mk5rectKJuW8DwGiPPxQCVTtFXho+3ssXF7nppR40ndS0LB7wyJJeae0dFgHHU5
         OkLOzqfO4HBPNty5jVNoB/eBm1epGwC1HPiXADKkNcWRZAHmwvQifkPDq2RJyFIpi/Na
         iC8w==
X-Gm-Message-State: AOJu0YxQdyjVW4V/+t1UDCgy4a4CFa6HbkrRnrNlG66mQgCSBhBm8mPn
	6f7B4OkQ7qd24zD6ED1l5I+C7N5EwInArtnsrzdTfLTj65O5nIdP2sRRm7mMfNEvTJpIg7LdpPE
	D4NDcMol76xQiNtm+TBEjvjs913fh8bIxQVoLWMaWKUZgCcbDm1nh1l3YpDQnM2NwVapK7mjJRb
	zfEA==
X-Gm-Gg: ASbGncvTCs9tDa648rXvWWo1rKGSwCM435VLTOYn1a8U6pD/7e4WIktp1gDW1nTNvzJ
	e2HGa0jFCY4PbTDpOJtWysoQLhO/OSWef1P157Grqiquy87z712smm6fT8/6Pv1YvJghsMqC62A
	wJCw8LOpWWW/bKIXY3VaJ9W9U6SnwmLvZHsBBDGWySc4bEaKuU+6yLIYrcjNVdFiMcHqcidv7HD
	QS/mcFMyPSk40h1xmqnPPynZ/hvrhGQI/DhuchiJNFDguG0kKkcFHU8U03D0t9px3HTo5EmX1qI
	KRcnGsXxT1ImRRLwKPJDSk2co0RyeID0uF5CNpwzwKw37NpgSYJMnJCfR2YT5FufFZiod4OWzsx
	HI+8y2BKs5kmP6AVmpseHRV/d8Q==
X-Received: by 2002:a05:622a:4cc4:b0:47a:eade:95eb with SMTP id d75a77b69052e-4a5a589679dmr96684651cf.40.1749111946295;
        Thu, 05 Jun 2025 01:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRqtPuFK4ho1ynltyfx5bNwh0w/3ERQTIA0dkvc1RaATudlWxbd+u6Idl3pyqpaU0h9uwmig==
X-Received: by 2002:a17:902:e741:b0:234:eb6:a35d with SMTP id d9443c01a7336-235e11ebd84mr81677345ad.27.1749111935399;
        Thu, 05 Jun 2025 01:25:35 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd34f9sm114984925ad.157.2025.06.05.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:25:35 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: update channel list in worker when wait flag is set
Date: Thu,  5 Jun 2025 16:25:28 +0800
Message-ID: <20250605082528.701-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3MyBTYWx0ZWRfXxUVMXIZRKCQO
 3rstCSBDcHDM/BwMdyIGQooTgDmdpfmxBXf3GArZ6vMmylp4wImGNJMu/bWG4ne7ZX3lzUoicHs
 SqLk8xRGz6AtaFX+Z+BAJbeHz6aD7+V8bWHE6DBKkxJT00L8Job1W654r+V82qgkknYX9hZvKY0
 6Qs4JEgh9fyHHYkEl8b0X87ylmtcypcmMvtEGAshTjDEXBbfXq7Z1y7kcWLlumN96Rscm1+MTyy
 /mrKVYF5AKkdjaUdISyGN695Szax/Lfk5kEV+9ltPXd7Lh1I3pApetNhFSUiF+aIlD9dcuZaQh7
 13tsx8Vy8LEqjGHZmdcnVpmNy2qJTYWin/VbYhxr/05nggWyNpBrv21faPAQ3lXG4RGnEm+B+UD
 8rjo2Rwy8qxUlwbYoZaZ+lzfpLLNd1Lgl/FXzeSHA8owl95E5rmRTUBMx2fcw7THGYoiIrZ5
X-Proofpoint-ORIG-GUID: FPGHyemHuEwIuJ4BvGlw1rx1jE1Ibryl
X-Proofpoint-GUID: FPGHyemHuEwIuJ4BvGlw1rx1jE1Ibryl
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=68415495 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=JRbU3RNS0gVZ2NvkieAA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050073

With previous patch [1], ath12k_reg_update_chan_list() will be called
during reg_process_self_managed_hint().

reg_process_self_managed_hint() will hold rtnl_lock all the time.
But ath12k_reg_update_chan_list() may increase the occupation time of
rtnl_lock, because when wait flag is set, wait_for_completion_timeout()
will be called during 11d/hw scan.

Should minimize the occupation time of rtnl_lock as much as possible
to avoid interfering with rest of the system. So move the update channel
list operation to a new worker, so that wait_for_completion_timeout()
won't be called with the rtnl_lock held.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: f335295aa29c ("wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()") #[1]
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  1 +
 drivers/net/wireless/ath/ath12k/core.h |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 13 ++++
 drivers/net/wireless/ath/ath12k/reg.c  | 85 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/reg.h  |  1 +
 drivers/net/wireless/ath/ath12k/wmi.h  |  1 +
 6 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 31d851d8e688..745bd9aaf79d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1407,6 +1407,7 @@ void ath12k_core_halt(struct ath12k *ar)
 	ath12k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
+	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ab->rfkill_work);
 	cancel_work_sync(&ab->update_11d_work);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 941db6e49d6e..6c55d065dd3a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -712,7 +712,7 @@ struct ath12k {
 
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_link_vif info,
-	 * channel context data, survey info, test mode data.
+	 * channel context data, survey info, test mode data, regd_channel_update_queue.
 	 */
 	spinlock_t data_lock;
 
@@ -771,6 +771,8 @@ struct ath12k {
 	struct completion bss_survey_done;
 
 	struct work_struct regd_update_work;
+	struct work_struct regd_channel_update_work;
+	struct list_head regd_channel_update_queue;
 
 	struct wiphy_work wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..5e5cb9b56aa4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7940,6 +7940,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 {
 	struct ath12k_hw *ah = ar->ah;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
+	struct ath12k_wmi_scan_chan_list_arg *arg;
 	int ret;
 
 	lockdep_assert_held(&ah->hw_mutex);
@@ -7954,6 +7955,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
+	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->rfkill_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
@@ -7961,10 +7963,18 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	complete(&ar->completed_11d_scan);
 
 	spin_lock_bh(&ar->data_lock);
+
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
 		list_del(&ppdu_stats->list);
 		kfree(ppdu_stats);
 	}
+
+	while ((arg = list_first_entry_or_null(&ar->regd_channel_update_queue,
+					       struct ath12k_wmi_scan_chan_list_arg,
+					       list))) {
+		list_del(&arg->list);
+		kfree(arg);
+	}
 	spin_unlock_bh(&ar->data_lock);
 
 	rcu_assign_pointer(ar->ab->pdevs_active[ar->pdev_idx], NULL);
@@ -11858,6 +11868,7 @@ static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 	int i;
 
 	for_each_ar(ah, ar, i) {
+		cancel_work_sync(&ar->regd_channel_update_work);
 		cancel_work_sync(&ar->regd_update_work);
 		ath12k_debugfs_unregister(ar);
 		ath12k_fw_stats_reset(ar);
@@ -12218,6 +12229,8 @@ static void ath12k_mac_setup(struct ath12k *ar)
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
+	INIT_WORK(&ar->regd_channel_update_work, ath12k_regd_update_chan_list_work);
+	INIT_LIST_HEAD(&ar->regd_channel_update_queue);
 	INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
 
 	wiphy_work_init(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 2598b39d5d7e..0fc7f209956d 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -137,32 +137,7 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 	struct ath12k_wmi_channel_arg *ch;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret, left;
-
-	if (wait && ar->state_11d == ATH12K_11D_RUNNING) {
-		left = wait_for_completion_timeout(&ar->completed_11d_scan,
-						   ATH12K_SCAN_TIMEOUT_HZ);
-		if (!left) {
-			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-				   "failed to receive 11d scan complete: timed out\n");
-			ar->state_11d = ATH12K_11D_IDLE;
-		}
-		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-			   "reg 11d scan wait left time %d\n", left);
-	}
-
-	if (wait &&
-	    (ar->scan.state == ATH12K_SCAN_STARTING ||
-	    ar->scan.state == ATH12K_SCAN_RUNNING)) {
-		left = wait_for_completion_timeout(&ar->scan.completed,
-						   ATH12K_SCAN_TIMEOUT_HZ);
-		if (!left)
-			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-				   "failed to receive hw scan complete: timed out\n");
-
-		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-			   "reg hw scan wait left time %d\n", left);
-	}
+	int i, ret = 0;
 
 	if (ar->ah->state == ATH12K_HW_STATE_RESTARTING)
 		return 0;
@@ -244,6 +219,16 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 		}
 	}
 
+	if (wait) {
+		spin_lock_bh(&ar->data_lock);
+		list_add_tail(&arg->list, &ar->regd_channel_update_queue);
+		spin_unlock_bh(&ar->data_lock);
+
+		queue_work(ar->ab->workqueue, &ar->regd_channel_update_work);
+
+		return 0;
+	}
+
 	ret = ath12k_wmi_send_scan_chan_list_cmd(ar, arg);
 	kfree(arg);
 
@@ -764,6 +749,54 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 	return new_regd;
 }
 
+void ath12k_regd_update_chan_list_work(struct work_struct *work)
+{
+	struct ath12k *ar = container_of(work, struct ath12k,
+					 regd_channel_update_work);
+	struct ath12k_wmi_scan_chan_list_arg *arg;
+	struct list_head local_update_list;
+	int left;
+
+	INIT_LIST_HEAD(&local_update_list);
+
+	spin_lock_bh(&ar->data_lock);
+	list_splice_tail_init(&ar->regd_channel_update_queue, &local_update_list);
+	spin_unlock_bh(&ar->data_lock);
+
+	while ((arg = list_first_entry_or_null(&local_update_list,
+					       struct ath12k_wmi_scan_chan_list_arg,
+					       list))) {
+		if (ar->state_11d != ATH12K_11D_IDLE) {
+			left = wait_for_completion_timeout(&ar->completed_11d_scan,
+							   ATH12K_SCAN_TIMEOUT_HZ);
+			if (!left) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+					   "failed to receive 11d scan complete: timed out\n");
+				ar->state_11d = ATH12K_11D_IDLE;
+			}
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+				   "reg 11d scan wait left time %d\n", left);
+		}
+
+		if ((ar->scan.state == ATH12K_SCAN_STARTING ||
+		     ar->scan.state == ATH12K_SCAN_RUNNING)) {
+			left = wait_for_completion_timeout(&ar->scan.completed,
+							   ATH12K_SCAN_TIMEOUT_HZ);
+			if (!left)
+				ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+					   "failed to receive hw scan complete: timed out\n");
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+				   "reg hw scan wait left time %d\n", left);
+		}
+
+		ath12k_wmi_send_scan_chan_list_cmd(ar, arg);
+		list_del(&arg->list);
+		kfree(arg);
+	}
+}
+
 void ath12k_regd_update_work(struct work_struct *work)
 {
 	struct ath12k *ar = container_of(work, struct ath12k,
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 8af8e9ba462e..0aeba06182c5 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -113,6 +113,7 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 				struct ath12k_reg_info *reg_info,
 				enum wmi_vdev_type vdev_type,
 				enum ieee80211_ap_reg_power power_type);
+void ath12k_regd_update_chan_list_work(struct work_struct *work);
 enum wmi_reg_6g_ap_type
 ath12k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type);
 enum ath12k_reg_status ath12k_reg_validate_reg_info(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ac18f75e0449..07423ce43a85 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3934,6 +3934,7 @@ struct wmi_stop_scan_cmd {
 } __packed;
 
 struct ath12k_wmi_scan_chan_list_arg {
+	struct list_head list;
 	u32 pdev_id;
 	u16 nallchans;
 	struct ath12k_wmi_channel_arg channel[];

base-commit: c3910de7bab78afbc106206aed5ec8e79458fbee
-- 
2.34.1


