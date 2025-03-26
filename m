Return-Path: <linux-wireless+bounces-20823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEB9A70E83
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126A11695AE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 01:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38891624CE;
	Wed, 26 Mar 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/JpWAyn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B320328;
	Wed, 26 Mar 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952834; cv=none; b=D0cbUN/qDKFvardmrOj06GCIBcOKyfq6tBrOmhD6VwaPZwsQsoX0Pwmml5LeYiEvgoXU95OczckSzqcT0Q7Abdmc+gOXedHabVhsRMJDCaXDLmkqHwnCE9GCr02HTdcl/cyQZGuwRjeqdyBTcuayN3F6umXI3Iv13z0KX8kEawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952834; c=relaxed/simple;
	bh=eonGk3taNKUCV3b2qZoZHIXbcGEuDTxLR/0CH1pG9Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=etj+VSmlhAXD3W7SQ2qW1o/X/AgXH+m5vBkvBSiMEa9sV5qd5067fgenitxKoOE0ObsUP+GsYr9OVj5OfU7XXBGXn1VkJAFoH7AUHB9ccaRrWkATceUQKJNJcvbikFd+8YbcZDShiBPHkGso1YFVjwEBjB0zudhX0/zXHD2S6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/JpWAyn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGaYaU001796;
	Wed, 26 Mar 2025 01:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukAmqQ3Kt/Kk7k64DjE2nr/F+L9+bNnInAGc9ajhO7w=; b=B/JpWAynk1tdkflh
	k/ne7rr8v/V3py3ECSPKQAnRYQX/TajddSrBaUbiVr6E8luRdgVBKy0z64lgSsvS
	xj58Dj0LORE3z1uUUtTHn4JUQyyyl33NU46YgihhQxFjGmB6pXC1oREU4ErERTtv
	LgASU+elK/93mUtv2ybIs+IoooJaEM2PYPQxGAlNNG+JIb/bkn9cjXD5HMWvp9Zd
	WUYBzLk/R7Tfd7mSPi3YkTjyoSRkCv54qAmp/sXP9GAwQopeTpzkdjnrhfEEor9r
	jVuDEVAKi6sRDXie52+woqy5i07cxp0MrwytYkcJVt7+doK73B+qyAH7yMKj5/w/
	pu5odw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktena5dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q1Xcnq027573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:39 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Mar
 2025 18:33:36 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 26 Mar 2025 09:33:08 +0800
Subject: [PATCH ath-next v2 4/6] wifi: ath11k: support non-WoWLAN mode
 suspend as well
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250326-ath11k-bring-hibernation-back-v2-4-87fdc2d6428f@quicinc.com>
References: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
In-Reply-To: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e35974 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8
 a=8jZZvdo-tVb-0EKf4OwA:9 a=QEXdDO2ut3YA:10 a=RVmHIydaz68A:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: b8lRhx_xcFQq1JCjYlnwr73b8sh5yVN5
X-Proofpoint-ORIG-GUID: b8lRhx_xcFQq1JCjYlnwr73b8sh5yVN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260008

Previously commit 166a490f59ac ("wifi: ath11k: support hibernation") was
reverted due to [1], so currently we only support WoWLAN mode suspend.
This works well in scenarios where WLAN power is sustained during suspend,
however breaks in those where power is cut off.

This change basically brings the reverted commit back, but differs in that
we decide based on the PM policy to choose WoWLAN mode suspend or the
non-WoWLAN mode. As stated in the previous patch for now the PM policy is
determined based on machine models. That said we will choose WoWLAN mode
suspend if we are running on machines listed in ath11k_pm_quirk_table,
otherwise we choose the other one.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 123 +++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |   4 ++
 drivers/net/wireless/ath/ath11k/hif.h  |  14 ++--
 drivers/net/wireless/ath/ath11k/mhi.c  |  14 +++-
 drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 ++++++++++--
 drivers/net/wireless/ath/ath11k/qmi.c  |   4 +-
 8 files changed, 187 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index eedba3766ba24430e7034fcbae39bd38b0ac5165..511f5f91da0f36f6dfe81a7824bb8a84b5cee3c2 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -413,7 +413,7 @@ static int ath11k_ahb_power_up(struct ath11k_base *ab)
 	return ret;
 }
 
-static void ath11k_ahb_power_down(struct ath11k_base *ab)
+static void ath11k_ahb_power_down(struct ath11k_base *ab, bool is_suspend)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
 
@@ -1280,7 +1280,7 @@ static void ath11k_ahb_remove(struct platform_device *pdev)
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_ahb_power_down(ab);
+		ath11k_ahb_power_down(ab, false);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index e9077b1c4c522291c0b87f23d6f1fcfffebe7509..e1c0eca773fc0243aa4d159dd8671f6a4084b29a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1082,6 +1082,52 @@ static int ath11k_core_suspend_wow(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_core_suspend_default(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_dp_rx_pktlog_stop(ab, true);
+	if (ret) {
+		ath11k_warn(ab, "failed to stop dp rx (and timer) pktlog during suspend: %d\n",
+			    ret);
+		return ret;
+	}
+
+	/* So far only single_pdev_only devices can reach here,
+	 * so it is valid to handle the first, and the only, pdev.
+	 */
+	ret = ath11k_mac_wait_tx_complete(ab->pdevs[0].ar);
+	if (ret) {
+		ath11k_warn(ab, "failed to wait tx complete: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_dp_rx_pktlog_stop(ab, false);
+	if (ret) {
+		ath11k_warn(ab, "failed to stop dp rx pktlog during suspend: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ath11k_ce_stop_shadow_timers(ab);
+	ath11k_dp_stop_shadow_timers(ab);
+
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
+
 int ath11k_core_suspend(struct ath11k_base *ab)
 {
 	int ret;
@@ -1090,10 +1136,73 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 	if (ret <= 0)
 		return ret;
 
-	return ath11k_core_suspend_wow(ab);
+	if (ab->pm_policy == ATH11K_PM_WOW)
+		return ath11k_core_suspend_wow(ab);
+
+	return ath11k_core_suspend_default(ab);
 }
 EXPORT_SYMBOL(ath11k_core_suspend);
 
+int ath11k_core_suspend_late(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
+
+	if (ab->pm_policy == ATH11K_PM_WOW)
+		return 0;
+
+	ath11k_hif_irq_disable(ab);
+	ath11k_hif_ce_irq_disable(ab);
+
+	ath11k_hif_power_down(ab, true);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_core_suspend_late);
+
+int ath11k_core_resume_early(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_core_continue_suspend_resume(ab);
+	if (ret <= 0)
+		return ret;
+
+	if (ab->pm_policy == ATH11K_PM_WOW)
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
+
+static int ath11k_core_resume_default(struct ath11k_base *ab)
+{
+	long time_left;
+	int ret;
+
+	time_left = wait_for_completion_timeout(&ab->restart_completed,
+						ATH11K_RESET_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath11k_warn(ab, "timeout while waiting for restart complete");
+		return -ETIMEDOUT;
+	}
+
+	ret = ath11k_dp_rx_pktlog_start(ab);
+	if (ret)
+		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
+			    ret);
+
+	return ret;
+}
+
 static int ath11k_core_resume_wow(struct ath11k_base *ab)
 {
 	int ret;
@@ -1131,7 +1240,10 @@ int ath11k_core_resume(struct ath11k_base *ab)
 	if (ret <= 0)
 		return ret;
 
-	return ath11k_core_resume_wow(ab);
+	if (ab->pm_policy == ATH11K_PM_WOW)
+		return ath11k_core_resume_wow(ab);
+
+	return ath11k_core_resume_default(ab);
 }
 EXPORT_SYMBOL(ath11k_core_resume);
 
@@ -2266,6 +2378,8 @@ static void ath11k_core_restart(struct work_struct *work)
 
 	if (!ab->is_reset)
 		ath11k_core_post_reconfigure_recovery(ab);
+
+	complete(&ab->restart_completed);
 }
 
 static void ath11k_core_reset(struct work_struct *work)
@@ -2336,7 +2450,7 @@ static void ath11k_core_reset(struct work_struct *work)
 	ath11k_hif_irq_disable(ab);
 	ath11k_hif_ce_irq_disable(ab);
 
-	ath11k_hif_power_down(ab);
+	ath11k_hif_power_down(ab, false);
 	ath11k_hif_power_up(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
@@ -2418,7 +2532,7 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 
 	mutex_unlock(&ab->core_lock);
 
-	ath11k_hif_power_down(ab);
+	ath11k_hif_power_down(ab, false);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 }
@@ -2471,6 +2585,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
+	init_completion(&ab->restart_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index df2b0cb2f0b5a700806cd261ffeb31f5da0741f5..7a9354e0eadb58730028217960e5bbfe0056c2fb 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1055,6 +1055,8 @@ struct ath11k_base {
 		DECLARE_BITMAP(fw_features, ATH11K_FW_FEATURE_COUNT);
 	} fw;
 
+	struct completion restart_completed;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 data_pos;
@@ -1256,8 +1258,10 @@ void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
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
index 770c39ff99b45e93de65c88c13bdf30e75fa8e64..cd9c4b838246815ecb2a10784732c009a5423b6e 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
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
@@ -68,12 +68,18 @@ static inline void ath11k_hif_irq_disable(struct ath11k_base *ab)
 
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
index fc77eac83e953148b96cad096d26b32222157b24..acd76e9392d31192aca6776319ef0829a1c69628 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/msi.h>
@@ -454,9 +454,17 @@ int ath11k_mhi_start(struct ath11k_pci *ab_pci)
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
index 651470091bd5ab60b3fbfb37c1be14b048e877c5..be997652b2cd0c9b16df9ea4e9a746abb81f4382 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
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
@@ -27,5 +27,4 @@ void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
 int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
 void ath11k_mhi_coredump(struct mhi_controller *mhi_ctrl, bool in_panic);
-
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 412f4a134e4a8bf5f8b7ecfe26197acec48858cc..37f5ed7f74f2f6adb3a6b5e176ed8c0105d235c2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -821,7 +821,7 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	return 0;
 }
 
-static void ath11k_pci_power_down(struct ath11k_base *ab)
+static void ath11k_pci_power_down(struct ath11k_base *ab, bool is_suspend)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
@@ -832,7 +832,7 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 
 	ath11k_pci_msi_disable(ab_pci);
 
-	ath11k_mhi_stop(ab_pci);
+	ath11k_mhi_stop(ab_pci, is_suspend);
 	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
@@ -1161,7 +1161,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath11k_pci_power_down(ab);
+		ath11k_pci_power_down(ab, false);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
 		goto qmi_fail;
@@ -1192,7 +1192,7 @@ static void ath11k_pci_shutdown(struct pci_dev *pdev)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	ath11k_pci_power_down(ab);
+	ath11k_pci_power_down(ab, false);
 }
 
 static __maybe_unused int ath11k_pci_pm_suspend(struct device *dev)
@@ -1229,9 +1229,39 @@ static __maybe_unused int ath11k_pci_pm_resume(struct device *dev)
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
index 4f8b08ed1bbc6ec426da83bd7ce49a73b3a93c0c..47b9d4126d3a9b85b424fe50aaca2bce65045994 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -2887,7 +2887,7 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
 	}
 
 	/* reset the firmware */
-	ath11k_hif_power_down(ab);
+	ath11k_hif_power_down(ab, false);
 	ath11k_hif_power_up(ab);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "exit wait for cold boot done\n");
 	return 0;

-- 
2.34.1


