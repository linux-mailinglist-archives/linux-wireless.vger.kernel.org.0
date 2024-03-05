Return-Path: <linux-wireless+bounces-4364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ADB87136D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 03:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E14BB23778
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 02:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803BD18032;
	Tue,  5 Mar 2024 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HTdOfDLg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009918030;
	Tue,  5 Mar 2024 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604839; cv=none; b=ofQA/Xzz+lXBRFomieS8huGg/T+1J5gcMO2EunaA47dKkVdjVNje4ITOTtTLtGcAKNHOXd5/Ujh6ceGK43uUKhwNCDE6gn1qZUy/jzYM5NXnwsI0hVQ1lcfPMIZDryYPXa+kIX1dJf7KLnGFEbkqtEYlHR7EANkf5SNB3NXSY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604839; c=relaxed/simple;
	bh=rlG7UAGD0iBtdMiKEFWuvXfB5ZZDpAmmK9+KwkPGPIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQWC4akqSnxzHKl6saxd1dXGOk4Hrwskf9UyFk9fGu+G838SFxeMFtpKIq7TQ3C26ORLQq4tQq3ZrbFzHKaOipKdbu1aqlIiEXPHXTXayL9TunqZ1xH/MLCgNHAH5VSA+R0te1P+/4p1fXkq52bFYsPSH3pDJA1qbQMEXx2sNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HTdOfDLg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4251duVb004921;
	Tue, 5 Mar 2024 02:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9B5gp7bqTu8z+7w8kkvtuddwT1/gJJaLMHWmjm/FkHs=; b=HT
	dOfDLgpAhykNJDbJQGFYenvnsQ8fATqNMJkFGkcnnqTE0xYdtj3SvM9Fl6MDC/06
	GcOXSkRdkZ6EqQrFxDja/it/FDzX7YbcKTaw4u3kz1Bm93lB6amU6VhOwhfzlWig
	MX+chE3y9V4HQ8HChVdDYxRbclldEKVLk7yvmkhALnk1T8dSKifN4AMaLfLC9P5H
	u4lCSMbBZ+74Wfq1LJo985U0989mkakuHVi+cQ+U/Y+UViFNErUX6vZUHH96DF8Q
	UatYbVUICJgCkk2Dv4TDQLf8n1jIW78WmJjQYI5GAyb7Xhtegpq+Sd2tECQwEhwF
	dwuezjIH/O5oOiLGua+g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnqwhr805-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 02:13:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4252DfV1009215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 02:13:41 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 18:13:38 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_bqiang@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: [PATCH v7 3/3] wifi: ath11k: support hibernation
Date: Tue, 5 Mar 2024 10:13:20 +0800
Message-ID: <20240305021320.3367-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240305021320.3367-1-quic_bqiang@quicinc.com>
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: zv04pz73oSlzsxgR_SynKY6obqLx4q8m
X-Proofpoint-ORIG-GUID: zv04pz73oSlzsxgR_SynKY6obqLx4q8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_20,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050015

Now that all infrastructure is in place and ath11k is fixed to handle all the
corner cases, power down the ath11k firmware during suspend and power it back
up during resume. This fixes the problem when using hibernation with ath11k PCI
devices.

For suspend, two conditions needs to be satisfied:
        1. since MHI channel unprepare would be done in late suspend stage,
           ath11k needs to get all QMI-dependent things done before that stage.
        2. and because unprepare MHI channels requires a working MHI stack,
           ath11k is not allowed to call mhi_power_down() until that finishes.
So the original suspend callback is separated into two parts: the first part
handles all QMI-dependent things in suspend callback; while the second part
powers down MHI in suspend_late callback. This is valid because kernel calls
ath11k's suspend callback before all suspend_late callbacks, making the first
condition happy. And because MHI devices are children of ath11k device
(ab->dev), kernel guarantees that ath11k's suspend_late callback is called
after QRTR's suspend_late callback, this satisfies the second condition.

Above analysis also applies to resume process. so the original resume
callback is separated into two parts: the first part powers up MHI stack
in resume_early callback, this guarantees MHI stack is working when
QRTR tries to prepare MHI channels (kernel calls QRTR's resume_early callback
after ath11k's resume_early callback, due to the child-father relationship);
the second part waits for the completion of restart, which won't fail now
since MHI channels are ready for use by QMI.

Another notable change is in power down path, we tell mhi_power_down() to not
to destroy MHI devices, making it possible for QRTR to help unprepare/prepare
MHI channels, and finally get us rid of the probe-defer issue when resume.

Also change related code due to interface changes.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |   6 +-
 drivers/net/wireless/ath/ath11k/core.c | 107 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/core.h |   6 +-
 drivers/net/wireless/ath/ath11k/hif.h  |  14 +++-
 drivers/net/wireless/ath/ath11k/mhi.c  |  12 ++-
 drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 ++++++++--
 drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
 8 files changed, 143 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 7c0a23517949..60b4c2800a33 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -413,7 +413,7 @@ static int ath11k_ahb_power_up(struct ath11k_base *ab)
 	return ret;
 }
 
-static void ath11k_ahb_power_down(struct ath11k_base *ab)
+static void ath11k_ahb_power_down(struct ath11k_base *ab, bool is_suspend)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 
@@ -1256,7 +1256,7 @@ static void ath11k_ahb_remove(struct platform_device *pdev)
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_ahb_power_down(ab);
+		ath11k_ahb_power_down(ab, false);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c78bce19bd75..ca3387ff394e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -894,12 +894,6 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ret = ath11k_wow_enable(ab);
-	if (ret) {
-		ath11k_warn(ab, "failed to enable wow during suspend: %d\n", ret);
-		return ret;
-	}
-
 	ret = ath11k_dp_rx_pktlog_stop(ab, false);
 	if (ret) {
 		ath11k_warn(ab, "failed to stop dp rx pktlog during suspend: %d\n",
@@ -910,29 +904,85 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 	ath11k_ce_stop_shadow_timers(ab);
 	ath11k_dp_stop_shadow_timers(ab);
 
+	/* PM framework skips suspend_late/resume_early callbacks
+	 * if other devices report errors in their suspend callbacks.
+	 * However ath11k_core_resume() would still be called because
+	 * here we return success thus kernel put us on dpm_suspended_list.
+	 * Since we won't go through a power down/up cycle, there is
+	 * no chance to call complete(&ab->restart_completed) in
+	 * ath11k_core_restart(), making ath11k_core_resume() timeout.
+	 * So call it here to avoid this issue. This also works in case
+	 * no error happens thus suspend_late/resume_early get called,
+	 * because it will be reinitialized in ath11k_core_resume_early().
+	 */
+	complete(&ab->restart_completed);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_core_suspend);
+
+int ath11k_core_suspend_late(struct ath11k_base *ab)
+{
+	struct ath11k_pdev *pdev;
+	struct ath11k *ar;
+
+	if (!ab->hw_params.supports_suspend)
+		return -EOPNOTSUPP;
+
+	/* so far single_pdev_only chips have supports_suspend as true
+	 * and only the first pdev is valid.
+	 */
+	pdev = ath11k_core_get_single_pdev(ab);
+	ar = pdev->ar;
+	if (!ar || ar->state != ATH11K_STATE_OFF)
+		return 0;
+
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ret = ath11k_hif_suspend(ab);
-	if (ret) {
-		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
-		return ret;
-	}
+	ath11k_hif_power_down(ab, true);
 
 	return 0;
 }
-EXPORT_SYMBOL(ath11k_core_suspend);
+EXPORT_SYMBOL(ath11k_core_suspend_late);
+
+int ath11k_core_resume_early(struct ath11k_base *ab)
+{
+	int ret;
+	struct ath11k_pdev *pdev;
+	struct ath11k *ar;
+
+	if (!ab->hw_params.supports_suspend)
+		return -EOPNOTSUPP;
+
+	/* so far single_pdev_only chips have supports_suspend as true
+	 * and only the first pdev is valid.
+	 */
+	pdev = ath11k_core_get_single_pdev(ab);
+	ar = pdev->ar;
+	if (!ar || ar->state != ATH11K_STATE_OFF)
+		return 0;
+
+	reinit_completion(&ab->restart_completed);
+	ret = ath11k_hif_power_up(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to power up hif during resume: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL(ath11k_core_resume_early);
 
 int ath11k_core_resume(struct ath11k_base *ab)
 {
 	int ret;
 	struct ath11k_pdev *pdev;
 	struct ath11k *ar;
+	long time_left;
 
 	if (!ab->hw_params.supports_suspend)
 		return -EOPNOTSUPP;
 
-	/* so far signle_pdev_only chips have supports_suspend as true
+	/* so far single_pdev_only chips have supports_suspend as true
 	 * and only the first pdev is valid.
 	 */
 	pdev = ath11k_core_get_single_pdev(ab);
@@ -940,29 +990,19 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	if (!ar || ar->state != ATH11K_STATE_OFF)
 		return 0;
 
-	ret = ath11k_hif_resume(ab);
-	if (ret) {
-		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
-		return ret;
+	time_left = wait_for_completion_timeout(&ab->restart_completed,
+						ATH11K_RESET_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath11k_warn(ab, "timeout while waiting for restart complete");
+		return -ETIMEDOUT;
 	}
 
-	ath11k_hif_ce_irq_enable(ab);
-	ath11k_hif_irq_enable(ab);
-
 	ret = ath11k_dp_rx_pktlog_start(ab);
-	if (ret) {
+	if (ret)
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
 			    ret);
-		return ret;
-	}
-
-	ret = ath11k_wow_wakeup(ab);
-	if (ret) {
-		ath11k_warn(ab, "failed to wakeup wow during resume: %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(ath11k_core_resume);
 
@@ -2060,6 +2100,8 @@ static void ath11k_core_restart(struct work_struct *work)
 
 	if (!ab->is_reset)
 		ath11k_core_post_reconfigure_recovery(ab);
+
+	complete(&ab->restart_completed);
 }
 
 static void ath11k_core_reset(struct work_struct *work)
@@ -2129,7 +2171,7 @@ static void ath11k_core_reset(struct work_struct *work)
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ath11k_hif_power_down(ab);
+	ath11k_hif_power_down(ab, false);
 	ath11k_hif_power_up(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
@@ -2202,7 +2244,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 
 	mutex_unlock(&ab->core_lock);
 
-	ath11k_hif_power_down(ab);
+	ath11k_hif_power_down(ab, false);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 	ath11k_fw_destroy(ab);
@@ -2255,6 +2297,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
+	init_completion(&ab->restart_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b3fb74a226fb..a20c29e3a227 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_CORE_H
@@ -1033,6 +1033,8 @@ struct ath11k_base {
 		DECLARE_BITMAP(fw_features, ATH11K_FW_FEATURE_COUNT);
 	} fw;
 
+	struct completion restart_completed;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 data_pos;
@@ -1232,8 +1234,10 @@ void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 int ath11k_core_check_dt(struct ath11k_base *ath11k);
 int ath11k_core_check_smbios(struct ath11k_base *ab);
 void ath11k_core_halt(struct ath11k *ar);
+int ath11k_core_resume_early(struct ath11k_base *ab);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
+int ath11k_core_suspend_late(struct ath11k_base *ab);
 void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
 bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index 877a4073fed6..c4c6cc09c7c1 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _HIF_H_
@@ -18,7 +18,7 @@ struct ath11k_hif_ops {
 	int (*start)(struct ath11k_base *ab);
 	void (*stop)(struct ath11k_base *ab);
 	int (*power_up)(struct ath11k_base *ab);
-	void (*power_down)(struct ath11k_base *ab);
+	void (*power_down)(struct ath11k_base *ab, bool is_suspend);
 	int (*suspend)(struct ath11k_base *ab);
 	int (*resume)(struct ath11k_base *ab);
 	int (*map_service_to_pipe)(struct ath11k_base *ab, u16 service_id,
@@ -67,12 +67,18 @@ static inline void ath11k_hif_irq_disable(struct ath11k_base *ab)
 
 static inline int ath11k_hif_power_up(struct ath11k_base *ab)
 {
+	if (!ab->hif.ops->power_up)
+		return -EOPNOTSUPP;
+
 	return ab->hif.ops->power_up(ab);
 }
 
-static inline void ath11k_hif_power_down(struct ath11k_base *ab)
+static inline void ath11k_hif_power_down(struct ath11k_base *ab, bool is_suspend)
 {
-	ab->hif.ops->power_down(ab);
+	if (!ab->hif.ops->power_down)
+		return;
+
+	ab->hif.ops->power_down(ab, is_suspend);
 }
 
 static inline int ath11k_hif_suspend(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index fb4ecf9a103e..90eacfe7e6d7 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -442,9 +442,17 @@ int ath11k_mhi_start(struct ath11k_pci *ab_pci)
 	return 0;
 }
 
-void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
+void ath11k_mhi_stop(struct ath11k_pci *ab_pci, bool is_suspend)
 {
-	mhi_power_down(ab_pci->mhi_ctrl, true);
+	/* During suspend we need to use mhi_power_down_keep_dev()
+	 * workaround, otherwise ath11k_core_resume() will timeout
+	 * during resume.
+	 */
+	if (is_suspend)
+		mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
+	else
+		mhi_power_down(ab_pci->mhi_ctrl, true);
+
 	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index f81fba2644a4..2d567705e732 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef _ATH11K_MHI_H
 #define _ATH11K_MHI_H
@@ -18,7 +18,7 @@
 #define MHICTRL_RESET_MASK			0x2
 
 int ath11k_mhi_start(struct ath11k_pci *ar_pci);
-void ath11k_mhi_stop(struct ath11k_pci *ar_pci);
+void ath11k_mhi_stop(struct ath11k_pci *ar_pci, bool is_suspend);
 int ath11k_mhi_register(struct ath11k_pci *ar_pci);
 void ath11k_mhi_unregister(struct ath11k_pci *ar_pci);
 void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab);
@@ -26,5 +26,4 @@ void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 
 int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
 int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
-
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index be9d2c69cc41..8d63b84d1261 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -638,7 +638,7 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	return 0;
 }
 
-static void ath11k_pci_power_down(struct ath11k_base *ab)
+static void ath11k_pci_power_down(struct ath11k_base *ab, bool is_suspend)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
@@ -649,7 +649,7 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 
 	ath11k_pci_msi_disable(ab_pci);
 
-	ath11k_mhi_stop(ab_pci);
+	ath11k_mhi_stop(ab_pci, is_suspend);
 	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
@@ -970,7 +970,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_pci_power_down(ab);
+		ath11k_pci_power_down(ab, false);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
@@ -998,7 +998,7 @@ static void ath11k_pci_shutdown(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	ath11k_pci_power_down(ab);
+	ath11k_pci_power_down(ab, false);
 }
 
 static __maybe_unused int ath11k_pci_pm_suspend(struct device *dev)
@@ -1035,9 +1035,39 @@ static __maybe_unused int ath11k_pci_pm_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(ath11k_pci_pm_ops,
-			 ath11k_pci_pm_suspend,
-			 ath11k_pci_pm_resume);
+static __maybe_unused int ath11k_pci_pm_suspend_late(struct device *dev)
+{
+	struct ath11k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath11k_core_suspend_late(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to late suspend core: %d\n", ret);
+
+	/* Similar to ath11k_pci_pm_suspend(), we return success here
+	 * even error happens, to allow system suspend/hibernation survive.
+	 */
+	return 0;
+}
+
+static __maybe_unused int ath11k_pci_pm_resume_early(struct device *dev)
+{
+	struct ath11k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath11k_core_resume_early(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to early resume core: %d\n", ret);
+
+	return ret;
+}
+
+static const struct dev_pm_ops __maybe_unused ath11k_pci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ath11k_pci_pm_suspend,
+				ath11k_pci_pm_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(ath11k_pci_pm_suspend_late,
+				     ath11k_pci_pm_resume_early)
+};
 
 static struct pci_driver ath11k_pci_driver = {
 	.name = "ath11k_pci",
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 5006f81f779b..d4a243b64f6c 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2877,7 +2877,7 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
 	}
 
 	/* reset the firmware */
-	ath11k_hif_power_down(ab);
+	ath11k_hif_power_down(ab, false);
 	ath11k_hif_power_up(ab);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "exit wait for cold boot done\n");
 	return 0;
-- 
2.25.1


