Return-Path: <linux-wireless+bounces-12243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1875C9658AC
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 09:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC50B24432
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 07:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034097602D;
	Fri, 30 Aug 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FF/aInOG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345D4690
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003287; cv=none; b=IoYbN0UGGW36tFTDm7kLSYK+Z9ULezun9vMD3iYO11pZYDDzAcHrTEgDYI+0GIrpnAG9FqGVaJY+cnNyBwdFrLJ2voxc3K+kGQP6LGNtutzc/MJ7gYH2k5DgV/tJOseOIaX+C4gYCWXMIdCoS+kE8mlFpbcSQPB3Ekeka0DbRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003287; c=relaxed/simple;
	bh=/Uyj8XqOZst2M7//KaHhbW45DXPUYJ1moGPjrrIKiyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZBk6haAH8Wq7rfBn2+JxsgkJRgwL+/IvIaC0aPrn3FAQKagcgC2PxQ0ohv2e8ajKhSRBGyiat/Zq0UiP2IYxKlh/TFhyunnmHEwKX0RVFkv1F7dmkTZlSUEWUJuLUbECQ0nPnuaCUNVj8mYeN0LNIjIklcNlqhe4TZUsqiEIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FF/aInOG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7Nn3A010962;
	Fri, 30 Aug 2024 07:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yTwVoXAMsW+3yPe7OIG5yvICyZQkDsT0f5yB4XxTnZA=; b=FF/aInOG7lSYevBd
	FLQ/Z3h46mG+PLPf+kKT3E+hrB9See/yqgR+4xNlP2al4Gnn5X8I0VUR8OACbiJG
	qOz3q7u9ka1qDEHJXpJ1zsnx+HysL9B5rEU5rRn76HKgBoJ3twAkZBQ8lsJ5yEZV
	hASpq7bDvBybHC6JqJtLJzzYXhVzd9CJ22anWuu7pdSlW8HVNwAwTCAoSj8ZaFOc
	yaNradRrFjW5crXfro45SArqSFLSRjL29UOA6Lz+eyAja+AST7IfRA9B1jCnPBNC
	EIWDO8B4SLd4jTd7X4O1zhNS3wc9pE0azYCgzuLTzG7Hh+YWfJxkfmFLOBwkvHcr
	eDEwRw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0qw90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:34:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U7YYQb019128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:34:34 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 00:34:32 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH ath-current 2/2] Revert "wifi: ath11k: support hibernation"
Date: Fri, 30 Aug 2024 15:34:20 +0800
Message-ID: <20240830073420.5790-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830073420.5790-1-quic_bqiang@quicinc.com>
References: <20240830073420.5790-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xv97UUxnqF10pUL-CQmjd9gXc8NiwcqW
X-Proofpoint-ORIG-GUID: xv97UUxnqF10pUL-CQmjd9gXc8NiwcqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300055

This reverts commit 166a490f59ac10340ee5330e51c15188ce2a7f8f.

We get report [1][2] that this commit breaks system suspend on some specific
Lenovo platforms. Since there is no fix available, for now revert this commit
to make suspend work again on those platforms.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2301921

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219196
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2301921
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 107 ++++++++-----------------
 drivers/net/wireless/ath/ath11k/core.h |   4 -
 drivers/net/wireless/ath/ath11k/hif.h  |  12 +--
 drivers/net/wireless/ath/ath11k/mhi.c  |  12 +--
 drivers/net/wireless/ath/ath11k/mhi.h  |   3 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 ++--------
 drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
 8 files changed, 49 insertions(+), 139 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 634d385fd9ad..97b12f51ef28 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -413,7 +413,7 @@ static int ath11k_ahb_power_up(struct ath11k_base *ab)
 	return ret;
 }
 
-static void ath11k_ahb_power_down(struct ath11k_base *ab, bool is_suspend)
+static void ath11k_ahb_power_down(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 
@@ -1280,7 +1280,7 @@ static void ath11k_ahb_remove(struct platform_device *pdev)
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_ahb_power_down(ab, false);
+		ath11k_ahb_power_down(ab);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 325b930aaf06..ccf4ad35fdc3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -906,6 +906,12 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 		return ret;
 	}
 
+	ret = ath11k_wow_enable(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to enable wow during suspend: %d\n", ret);
+		return ret;
+	}
+
 	ret = ath11k_dp_rx_pktlog_stop(ab, false);
 	if (ret) {
 		ath11k_warn(ab, "failed to stop dp rx pktlog during suspend: %d\n",
@@ -916,85 +922,29 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 	ath11k_ce_stop_shadow_timers(ab);
 	ath11k_dp_stop_shadow_timers(ab);
 
-	/* PM framework skips suspend_late/resume_early callbacks
-	 * if other devices report errors in their suspend callbacks.
-	 * However ath11k_core_resume() would still be called because
-	 * here we return success thus kernel put us on dpm_suspended_list.
-	 * Since we won't go through a power down/up cycle, there is
-	 * no chance to call complete(&ab->restart_completed) in
-	 * ath11k_core_restart(), making ath11k_core_resume() timeout.
-	 * So call it here to avoid this issue. This also works in case
-	 * no error happens thus suspend_late/resume_early get called,
-	 * because it will be reinitialized in ath11k_core_resume_early().
-	 */
-	complete(&ab->restart_completed);
-
-	return 0;
-}
-EXPORT_SYMBOL(ath11k_core_suspend);
-
-int ath11k_core_suspend_late(struct ath11k_base *ab)
-{
-	struct ath11k_pdev *pdev;
-	struct ath11k *ar;
-
-	if (!ab->hw_params.supports_suspend)
-		return -EOPNOTSUPP;
-
-	/* so far single_pdev_only chips have supports_suspend as true
-	 * and only the first pdev is valid.
-	 */
-	pdev = ath11k_core_get_single_pdev(ab);
-	ar = pdev->ar;
-	if (!ar || ar->state != ATH11K_STATE_OFF)
-		return 0;
-
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ath11k_hif_power_down(ab, true);
+	ret = ath11k_hif_suspend(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-EXPORT_SYMBOL(ath11k_core_suspend_late);
-
-int ath11k_core_resume_early(struct ath11k_base *ab)
-{
-	int ret;
-	struct ath11k_pdev *pdev;
-	struct ath11k *ar;
-
-	if (!ab->hw_params.supports_suspend)
-		return -EOPNOTSUPP;
-
-	/* so far single_pdev_only chips have supports_suspend as true
-	 * and only the first pdev is valid.
-	 */
-	pdev = ath11k_core_get_single_pdev(ab);
-	ar = pdev->ar;
-	if (!ar || ar->state != ATH11K_STATE_OFF)
-		return 0;
-
-	reinit_completion(&ab->restart_completed);
-	ret = ath11k_hif_power_up(ab);
-	if (ret)
-		ath11k_warn(ab, "failed to power up hif during resume: %d\n", ret);
-
-	return ret;
-}
-EXPORT_SYMBOL(ath11k_core_resume_early);
+EXPORT_SYMBOL(ath11k_core_suspend);
 
 int ath11k_core_resume(struct ath11k_base *ab)
 {
 	int ret;
 	struct ath11k_pdev *pdev;
 	struct ath11k *ar;
-	long time_left;
 
 	if (!ab->hw_params.supports_suspend)
 		return -EOPNOTSUPP;
 
-	/* so far single_pdev_only chips have supports_suspend as true
+	/* so far signle_pdev_only chips have supports_suspend as true
 	 * and only the first pdev is valid.
 	 */
 	pdev = ath11k_core_get_single_pdev(ab);
@@ -1002,19 +952,29 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	if (!ar || ar->state != ATH11K_STATE_OFF)
 		return 0;
 
-	time_left = wait_for_completion_timeout(&ab->restart_completed,
-						ATH11K_RESET_TIMEOUT_HZ);
-	if (time_left == 0) {
-		ath11k_warn(ab, "timeout while waiting for restart complete");
-		return -ETIMEDOUT;
+	ret = ath11k_hif_resume(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
+		return ret;
 	}
 
+	ath11k_hif_ce_irq_enable(ab);
+	ath11k_hif_irq_enable(ab);
+
 	ret = ath11k_dp_rx_pktlog_start(ab);
-	if (ret)
+	if (ret) {
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
 			    ret);
+		return ret;
+	}
 
-	return ret;
+	ret = ath11k_wow_wakeup(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to wakeup wow during resume: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(ath11k_core_resume);
 
@@ -2109,8 +2069,6 @@ static void ath11k_core_restart(struct work_struct *work)
 
 	if (!ab->is_reset)
 		ath11k_core_post_reconfigure_recovery(ab);
-
-	complete(&ab->restart_completed);
 }
 
 static void ath11k_core_reset(struct work_struct *work)
@@ -2180,7 +2138,7 @@ static void ath11k_core_reset(struct work_struct *work)
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_down(ab);
 	ath11k_hif_power_up(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
@@ -2253,7 +2211,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 
 	mutex_unlock(&ab->core_lock);
 
-	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 	ath11k_fw_destroy(ab);
@@ -2306,7 +2264,6 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
-	init_completion(&ab->restart_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7122176dd91e..76faa55fd0f3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1037,8 +1037,6 @@ struct ath11k_base {
 		DECLARE_BITMAP(fw_features, ATH11K_FW_FEATURE_COUNT);
 	} fw;
 
-	struct completion restart_completed;
-
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 data_pos;
@@ -1238,10 +1236,8 @@ void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 int ath11k_core_check_dt(struct ath11k_base *ath11k);
 int ath11k_core_check_smbios(struct ath11k_base *ab);
 void ath11k_core_halt(struct ath11k *ar);
-int ath11k_core_resume_early(struct ath11k_base *ab);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
-int ath11k_core_suspend_late(struct ath11k_base *ab);
 void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
 bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index c4c6cc09c7c1..674ff772b181 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -18,7 +18,7 @@ struct ath11k_hif_ops {
 	int (*start)(struct ath11k_base *ab);
 	void (*stop)(struct ath11k_base *ab);
 	int (*power_up)(struct ath11k_base *ab);
-	void (*power_down)(struct ath11k_base *ab, bool is_suspend);
+	void (*power_down)(struct ath11k_base *ab);
 	int (*suspend)(struct ath11k_base *ab);
 	int (*resume)(struct ath11k_base *ab);
 	int (*map_service_to_pipe)(struct ath11k_base *ab, u16 service_id,
@@ -67,18 +67,12 @@ static inline void ath11k_hif_irq_disable(struct ath11k_base *ab)
 
 static inline int ath11k_hif_power_up(struct ath11k_base *ab)
 {
-	if (!ab->hif.ops->power_up)
-		return -EOPNOTSUPP;
-
 	return ab->hif.ops->power_up(ab);
 }
 
-static inline void ath11k_hif_power_down(struct ath11k_base *ab, bool is_suspend)
+static inline void ath11k_hif_power_down(struct ath11k_base *ab)
 {
-	if (!ab->hif.ops->power_down)
-		return;
-
-	ab->hif.ops->power_down(ab, is_suspend);
+	ab->hif.ops->power_down(ab);
 }
 
 static inline int ath11k_hif_suspend(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index ab182690aed3..6974a551883f 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -453,17 +453,9 @@ int ath11k_mhi_start(struct ath11k_pci *ab_pci)
 	return 0;
 }
 
-void ath11k_mhi_stop(struct ath11k_pci *ab_pci, bool is_suspend)
+void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
 {
-	/* During suspend we need to use mhi_power_down_keep_dev()
-	 * workaround, otherwise ath11k_core_resume() will timeout
-	 * during resume.
-	 */
-	if (is_suspend)
-		mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
-	else
-		mhi_power_down(ab_pci->mhi_ctrl, true);
-
+	mhi_power_down(ab_pci->mhi_ctrl, true);
 	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index 2d567705e732..a682aad52fc5 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -18,7 +18,7 @@
 #define MHICTRL_RESET_MASK			0x2
 
 int ath11k_mhi_start(struct ath11k_pci *ar_pci);
-void ath11k_mhi_stop(struct ath11k_pci *ar_pci, bool is_suspend);
+void ath11k_mhi_stop(struct ath11k_pci *ar_pci);
 int ath11k_mhi_register(struct ath11k_pci *ar_pci);
 void ath11k_mhi_unregister(struct ath11k_pci *ar_pci);
 void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab);
@@ -26,4 +26,5 @@ void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 
 int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
 int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
+
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 8d63b84d1261..be9d2c69cc41 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -638,7 +638,7 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	return 0;
 }
 
-static void ath11k_pci_power_down(struct ath11k_base *ab, bool is_suspend)
+static void ath11k_pci_power_down(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
@@ -649,7 +649,7 @@ static void ath11k_pci_power_down(struct ath11k_base *ab, bool is_suspend)
 
 	ath11k_pci_msi_disable(ab_pci);
 
-	ath11k_mhi_stop(ab_pci, is_suspend);
+	ath11k_mhi_stop(ab_pci);
 	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
@@ -970,7 +970,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_pci_power_down(ab, false);
+		ath11k_pci_power_down(ab);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
@@ -998,7 +998,7 @@ static void ath11k_pci_shutdown(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	ath11k_pci_power_down(ab, false);
+	ath11k_pci_power_down(ab);
 }
 
 static __maybe_unused int ath11k_pci_pm_suspend(struct device *dev)
@@ -1035,39 +1035,9 @@ static __maybe_unused int ath11k_pci_pm_resume(struct device *dev)
 	return ret;
 }
 
-static __maybe_unused int ath11k_pci_pm_suspend_late(struct device *dev)
-{
-	struct ath11k_base *ab = dev_get_drvdata(dev);
-	int ret;
-
-	ret = ath11k_core_suspend_late(ab);
-	if (ret)
-		ath11k_warn(ab, "failed to late suspend core: %d\n", ret);
-
-	/* Similar to ath11k_pci_pm_suspend(), we return success here
-	 * even error happens, to allow system suspend/hibernation survive.
-	 */
-	return 0;
-}
-
-static __maybe_unused int ath11k_pci_pm_resume_early(struct device *dev)
-{
-	struct ath11k_base *ab = dev_get_drvdata(dev);
-	int ret;
-
-	ret = ath11k_core_resume_early(ab);
-	if (ret)
-		ath11k_warn(ab, "failed to early resume core: %d\n", ret);
-
-	return ret;
-}
-
-static const struct dev_pm_ops __maybe_unused ath11k_pci_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ath11k_pci_pm_suspend,
-				ath11k_pci_pm_resume)
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(ath11k_pci_pm_suspend_late,
-				     ath11k_pci_pm_resume_early)
-};
+static SIMPLE_DEV_PM_OPS(ath11k_pci_pm_ops,
+			 ath11k_pci_pm_suspend,
+			 ath11k_pci_pm_resume);
 
 static struct pci_driver ath11k_pci_driver = {
 	.name = "ath11k_pci",
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 1bc648920ab6..f477afd325de 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2877,7 +2877,7 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
 	}
 
 	/* reset the firmware */
-	ath11k_hif_power_down(ab, false);
+	ath11k_hif_power_down(ab);
 	ath11k_hif_power_up(ab);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "exit wait for cold boot done\n");
 	return 0;
-- 
2.25.1


