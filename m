Return-Path: <linux-wireless+bounces-6223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BDF8A262E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37021F21F61
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5571B977;
	Fri, 12 Apr 2024 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c9NxSPaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619422EE3
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902018; cv=none; b=Zim+8vdhpgJKLFAMvy8SAVIMB0T8v9nu5r412W8DcFYqFx6OH+qPdWpK8h+6KAjeEP6c2LQJpXt79rf9PumDhM8byxQ3kWPDk1aDYAV9tS+Y/bHJ0zsbpgSpYOvnEq/BFzc6BDf+yTW2LOS0fcT2V+wAqX4z7JanM+ncAxs+STg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902018; c=relaxed/simple;
	bh=TqZ9zI+j5/vjl3pPIz0sC8TpouF4baW2HMZ4bghA/SA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M900YGAdQrLyKBr3uzb3tIK8BigbrmZK9M2rlL9LkrJmKanKK6j1r81QMzkqnXUQG80yUeW0aqhBVV93txN85gp5DpCYwyicOanqn5JEGR9L4iaYw/0bXgNmLyNqYTb6hz6ZqCq0dLi0q5PFS2Qu8GiaY5LA50TmU+pRn1mcTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c9NxSPaA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4kBdU012832;
	Fri, 12 Apr 2024 06:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2wwp/VpoyzMi//5IhLsEUh7s4YXlULX8xd5rIcqy5Wk=; b=c9
	NxSPaAfbVMEYdMiAW/PrPKjXiUjfW1Ak9SyVqxTwzBIDrpmrF5xZZxDgY9D//acb
	hpLofm+uCpao4bbx7rmb7h1DCH6NuIpi1gXIeuCzHw8z00kF7gYJLb/FVjIURydI
	LiGlOVAyGwyXo5NRBL4DIyU7HLf6bruSBq/kNUC5AndsmnMas+6j+VVHWfk4EWJ9
	W9OGZdsaRL5l+MVTb3QklDlzomcmKWGZWUrliXlTkvrffC1Y8z28EMXQB3GiwYkM
	CtpvFSNvVgZn8hAtdH35vZ4cfvTuCwSEkCtvZEgwrtuM1y3Yxaw9CaF45a2E5cmd
	U8yFadW87CB/DFgQxAdQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xem8m195f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C66nbl020008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:49 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 23:06:47 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 09/10] wifi: ath12k: support suspend/resume
Date: Fri, 12 Apr 2024 14:06:19 +0800
Message-ID: <20240412060620.27519-10-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412060620.27519-1-quic_bqiang@quicinc.com>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SEtzZpfLmxntad54n5TRNtE_0mntnqFU
X-Proofpoint-GUID: SEtzZpfLmxntad54n5TRNtE_0mntnqFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120042

Now that all infrastructure is in place and ath12k is fixed to handle all the
corner cases, power down the ath12k firmware during suspend and power it back
up during resume.

For suspend, two conditions needs to be satisfied:

1. since MHI channel unprepare would be done in late suspend stage,
   ath12k needs to get all QMI-dependent things done before that stage.
2. and because unprepare MHI channels requires a working MHI stack,
   ath12k is not allowed to call mhi_power_down() until that finishes.

So the original suspend callback is separated into two parts: the first part
handles all QMI-dependent things in suspend callback; while the second part
powers down MHI in suspend_late callback. This is valid because kernel calls
ath12k's suspend callback before calling all suspend_late callbacks, making
the first condition satisfied. And because MHI devices are children of ath12k
device (ab->dev), kernel guarantees that ath12k's suspend_late callback is
called after QRTR's suspend_late callback, this satisfies the second condition.

Above analysis also applies to resume process. so the original resume
callback is separated into two parts: the first part powers up MHI stack
in resume_early callback, this guarantees MHI stack is working when
QRTR tries to prepare MHI channels (kernel calls QRTR's resume_early callback
after ath12k's resume_early callback, due to the child-father relationship);
the second part waits for the completion of restart, which would succeed
since MHI channels are ready for use by QMI.

Another notable change is in power down path, we tell mhi_power_down() to not
to destroy MHI devices, making it possible for QRTR to help unprepare/prepare
MHI channels, and finally get us rid of the potential probe-defer issue when
resume.

Also change related code due to interface changes.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 67 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/core.h |  4 ++
 drivers/net/wireless/ath/ath12k/hif.h  | 14 ++++--
 drivers/net/wireless/ath/ath12k/mhi.c  | 33 +++++++++++--
 drivers/net/wireless/ath/ath12k/mhi.h  |  5 +-
 drivers/net/wireless/ath/ath12k/pci.c  | 41 +++++++++++++---
 drivers/net/wireless/ath/ath12k/pci.h  |  2 +-
 7 files changed, 134 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 380a3c8f7201..aefe667c3dcb 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -64,36 +64,70 @@ int ath12k_core_suspend(struct ath12k_base *ab)
 	}
 	rcu_read_unlock();
 
+	/* PM framework skips suspend_late/resume_early callbacks
+	 * if other devices report errors in their suspend callbacks.
+	 * However ath12k_core_resume() would still be called because
+	 * here we return success thus kernel put us on dpm_suspended_list.
+	 * Since we won't go through a power down/up cycle, there is
+	 * no chance to call complete(&ab->restart_completed) in
+	 * ath12k_core_restart(), making ath12k_core_resume() timeout.
+	 * So call it here to avoid this issue. This also works in case
+	 * no error happens thus suspend_late/resume_early get called,
+	 * because it will be reinitialized in ath12k_core_resume_early().
+	 */
+	complete(&ab->restart_completed);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath12k_core_suspend);
+
+int ath12k_core_suspend_late(struct ath12k_base *ab)
+{
+	if (!ab->hw_params->supports_suspend)
+		return -EOPNOTSUPP;
+
 	ath12k_hif_irq_disable(ab);
 	ath12k_hif_ce_irq_disable(ab);
 
-	ret = ath12k_hif_suspend(ab);
-	if (ret) {
-		ath12k_warn(ab, "failed to suspend hif: %d\n", ret);
-		return ret;
-	}
+	ath12k_hif_power_down(ab, true);
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_core_suspend_late);
 
-int ath12k_core_resume(struct ath12k_base *ab)
+int ath12k_core_resume_early(struct ath12k_base *ab)
 {
 	int ret;
 
 	if (!ab->hw_params->supports_suspend)
 		return -EOPNOTSUPP;
 
-	ret = ath12k_hif_resume(ab);
-	if (ret) {
-		ath12k_warn(ab, "failed to resume hif during resume: %d\n", ret);
-		return ret;
-	}
+	reinit_completion(&ab->restart_completed);
+	ret = ath12k_hif_power_up(ab);
+	if (ret)
+		ath12k_warn(ab, "failed to power up hif during resume: %d\n", ret);
 
-	ath12k_hif_ce_irq_enable(ab);
-	ath12k_hif_irq_enable(ab);
+	return ret;
+}
+EXPORT_SYMBOL(ath12k_core_resume_early);
+
+int ath12k_core_resume(struct ath12k_base *ab)
+{
+	long time_left;
+
+	if (!ab->hw_params->supports_suspend)
+		return -EOPNOTSUPP;
+
+	time_left = wait_for_completion_timeout(&ab->restart_completed,
+						ATH12K_RESET_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath12k_warn(ab, "timeout while waiting for restart complete");
+		return -ETIMEDOUT;
+	}
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_core_resume);
 
 static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					   size_t name_len, bool with_variant,
@@ -1053,6 +1087,8 @@ static void ath12k_core_restart(struct work_struct *work)
 
 	if (ab->is_reset)
 		complete_all(&ab->reconfigure_complete);
+
+	complete(&ab->restart_completed);
 }
 
 static void ath12k_core_reset(struct work_struct *work)
@@ -1121,7 +1157,7 @@ static void ath12k_core_reset(struct work_struct *work)
 	ath12k_hif_irq_disable(ab);
 	ath12k_hif_ce_irq_disable(ab);
 
-	ath12k_hif_power_down(ab);
+	ath12k_hif_power_down(ab, false);
 	ath12k_qmi_free_resource(ab);
 	ath12k_hif_power_up(ab);
 
@@ -1165,7 +1201,7 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 
 	mutex_unlock(&ab->core_lock);
 
-	ath12k_hif_power_down(ab);
+	ath12k_hif_power_down(ab, false);
 	ath12k_mac_destroy(ab);
 	ath12k_core_soc_destroy(ab);
 	ath12k_fw_unmap(ab);
@@ -1213,6 +1249,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 
 	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
+	init_completion(&ab->restart_completed);
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 397d8c973265..c4a3912567d9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -901,6 +901,8 @@ struct ath12k_base {
 	 */
 	u8 mlo_capable_flags;
 
+	struct completion restart_completed;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -927,8 +929,10 @@ int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd
 int ath12k_core_check_dt(struct ath12k_base *ath12k);
 int ath12k_core_check_smbios(struct ath12k_base *ab);
 void ath12k_core_halt(struct ath12k *ar);
+int ath12k_core_resume_early(struct ath12k_base *ab);
 int ath12k_core_resume(struct ath12k_base *ab);
 int ath12k_core_suspend(struct ath12k_base *ab);
+int ath12k_core_suspend_late(struct ath12k_base *ab);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index c653ca1f59b2..7f0926fe751d 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HIF_H
@@ -17,7 +17,7 @@ struct ath12k_hif_ops {
 	int (*start)(struct ath12k_base *ab);
 	void (*stop)(struct ath12k_base *ab);
 	int (*power_up)(struct ath12k_base *ab);
-	void (*power_down)(struct ath12k_base *ab);
+	void (*power_down)(struct ath12k_base *ab, bool is_suspend);
 	int (*suspend)(struct ath12k_base *ab);
 	int (*resume)(struct ath12k_base *ab);
 	int (*map_service_to_pipe)(struct ath12k_base *ab, u16 service_id,
@@ -133,12 +133,18 @@ static inline void ath12k_hif_write32(struct ath12k_base *ab, u32 address,
 
 static inline int ath12k_hif_power_up(struct ath12k_base *ab)
 {
+	if (!ab->hif.ops->power_up)
+		return -EOPNOTSUPP;
+
 	return ab->hif.ops->power_up(ab);
 }
 
-static inline void ath12k_hif_power_down(struct ath12k_base *ab)
+static inline void ath12k_hif_power_down(struct ath12k_base *ab, bool is_suspend)
 {
-	ab->hif.ops->power_down(ab);
+	if (!ab->hif.ops->power_down)
+		return;
+
+	ab->hif.ops->power_down(ab, is_suspend);
 }
 
 #endif /* ATH12K_HIF_H */
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index d6083a187021..72d3e804f453 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -414,6 +414,8 @@ static char *ath12k_mhi_state_to_str(enum ath12k_mhi_state mhi_state)
 		return "POWER_ON";
 	case ATH12K_MHI_POWER_OFF:
 		return "POWER_OFF";
+	case ATH12K_MHI_POWER_OFF_KEEP_DEV:
+		return "POWER_OFF_KEEP_DEV";
 	case ATH12K_MHI_FORCE_POWER_OFF:
 		return "FORCE_POWER_OFF";
 	case ATH12K_MHI_SUSPEND:
@@ -445,6 +447,7 @@ static void ath12k_mhi_set_state_bit(struct ath12k_pci *ab_pci,
 		set_bit(ATH12K_MHI_POWER_ON, &ab_pci->mhi_state);
 		break;
 	case ATH12K_MHI_POWER_OFF:
+	case ATH12K_MHI_POWER_OFF_KEEP_DEV:
 	case ATH12K_MHI_FORCE_POWER_OFF:
 		clear_bit(ATH12K_MHI_POWER_ON, &ab_pci->mhi_state);
 		clear_bit(ATH12K_MHI_TRIGGER_RDDM, &ab_pci->mhi_state);
@@ -488,6 +491,7 @@ static int ath12k_mhi_check_state_bit(struct ath12k_pci *ab_pci,
 			return 0;
 		break;
 	case ATH12K_MHI_POWER_OFF:
+	case ATH12K_MHI_POWER_OFF_KEEP_DEV:
 	case ATH12K_MHI_SUSPEND:
 		if (test_bit(ATH12K_MHI_POWER_ON, &ab_pci->mhi_state) &&
 		    !test_bit(ATH12K_MHI_SUSPEND, &ab_pci->mhi_state))
@@ -538,12 +542,27 @@ static int ath12k_mhi_set_state(struct ath12k_pci *ab_pci,
 		ret = 0;
 		break;
 	case ATH12K_MHI_POWER_ON:
-		ret = mhi_async_power_up(ab_pci->mhi_ctrl);
+		/* In case of resume, QRTR's resume_early() is called
+		 * right after ath12k' resume_early(). Since QRTR requires
+		 * MHI mission mode state when preparing IPCR channels
+		 * (see ee_mask of that channel), we need to use the 'sync'
+		 * version here to make sure MHI is in that state when we
+		 * return. Or QRTR might resume before that state comes,
+		 * and as a result it fails.
+		 *
+		 * The 'sync' version works for non-resume (normal power on)
+		 * case as well.
+		 */
+		ret = mhi_sync_power_up(ab_pci->mhi_ctrl);
 		break;
 	case ATH12K_MHI_POWER_OFF:
 		mhi_power_down(ab_pci->mhi_ctrl, true);
 		ret = 0;
 		break;
+	case ATH12K_MHI_POWER_OFF_KEEP_DEV:
+		mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
+		ret = 0;
+		break;
 	case ATH12K_MHI_FORCE_POWER_OFF:
 		mhi_power_down(ab_pci->mhi_ctrl, false);
 		ret = 0;
@@ -597,9 +616,17 @@ int ath12k_mhi_start(struct ath12k_pci *ab_pci)
 	return ret;
 }
 
-void ath12k_mhi_stop(struct ath12k_pci *ab_pci)
+void ath12k_mhi_stop(struct ath12k_pci *ab_pci, bool is_suspend)
 {
-	ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF);
+	/* During suspend we need to use mhi_power_down_keep_dev()
+	 * workaround, otherwise ath12k_core_resume() will timeout
+	 * during resume.
+	 */
+	if (is_suspend)
+		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF_KEEP_DEV);
+	else
+		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF);
+
 	ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mhi.h b/drivers/net/wireless/ath/ath12k/mhi.h
index ebc23640ce7a..9362ad1958c3 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.h
+++ b/drivers/net/wireless/ath/ath12k/mhi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef _ATH12K_MHI_H
 #define _ATH12K_MHI_H
@@ -22,6 +22,7 @@ enum ath12k_mhi_state {
 	ATH12K_MHI_DEINIT,
 	ATH12K_MHI_POWER_ON,
 	ATH12K_MHI_POWER_OFF,
+	ATH12K_MHI_POWER_OFF_KEEP_DEV,
 	ATH12K_MHI_FORCE_POWER_OFF,
 	ATH12K_MHI_SUSPEND,
 	ATH12K_MHI_RESUME,
@@ -34,7 +35,7 @@ extern const struct mhi_controller_config ath12k_mhi_config_qcn9274;
 extern const struct mhi_controller_config ath12k_mhi_config_wcn7850;
 
 int ath12k_mhi_start(struct ath12k_pci *ar_pci);
-void ath12k_mhi_stop(struct ath12k_pci *ar_pci);
+void ath12k_mhi_stop(struct ath12k_pci *ar_pci, bool is_suspend);
 int ath12k_mhi_register(struct ath12k_pci *ar_pci);
 void ath12k_mhi_unregister(struct ath12k_pci *ar_pci);
 void ath12k_mhi_set_mhictrl_reset(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 14954bc05144..752b30809a43 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1271,7 +1271,7 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
 	return 0;
 }
 
-void ath12k_pci_power_down(struct ath12k_base *ab)
+void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
@@ -1280,7 +1280,7 @@ void ath12k_pci_power_down(struct ath12k_base *ab)
 
 	ath12k_pci_force_wake(ab_pci->ab);
 	ath12k_pci_msi_disable(ab_pci);
-	ath12k_mhi_stop(ab_pci);
+	ath12k_mhi_stop(ab_pci, is_suspend);
 	clear_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 	ath12k_pci_sw_reset(ab_pci->ab, false);
 }
@@ -1503,7 +1503,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
-		ath12k_pci_power_down(ab);
+		ath12k_pci_power_down(ab, false);
 		ath12k_qmi_deinit_service(ab);
 		goto qmi_fail;
 	}
@@ -1531,7 +1531,7 @@ static void ath12k_pci_shutdown(struct pci_dev *pdev)
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
 	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
-	ath12k_pci_power_down(ab);
+	ath12k_pci_power_down(ab, false);
 }
 
 static __maybe_unused int ath12k_pci_pm_suspend(struct device *dev)
@@ -1558,9 +1558,36 @@ static __maybe_unused int ath12k_pci_pm_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(ath12k_pci_pm_ops,
-			 ath12k_pci_pm_suspend,
-			 ath12k_pci_pm_resume);
+static __maybe_unused int ath12k_pci_pm_suspend_late(struct device *dev)
+{
+	struct ath12k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath12k_core_suspend_late(ab);
+	if (ret)
+		ath12k_warn(ab, "failed to late suspend core: %d\n", ret);
+
+	return ret;
+}
+
+static __maybe_unused int ath12k_pci_pm_resume_early(struct device *dev)
+{
+	struct ath12k_base *ab = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ath12k_core_resume_early(ab);
+	if (ret)
+		ath12k_warn(ab, "failed to early resume core: %d\n", ret);
+
+	return ret;
+}
+
+static const struct dev_pm_ops __maybe_unused ath12k_pci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ath12k_pci_pm_suspend,
+				ath12k_pci_pm_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(ath12k_pci_pm_suspend_late,
+				     ath12k_pci_pm_resume_early)
+};
 
 static struct pci_driver ath12k_pci_driver = {
 	.name = "ath12k_pci",
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index ca93693ba4e9..6186a78038cf 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -143,5 +143,5 @@ int ath12k_pci_hif_resume(struct ath12k_base *ab);
 void ath12k_pci_stop(struct ath12k_base *ab);
 int ath12k_pci_start(struct ath12k_base *ab);
 int ath12k_pci_power_up(struct ath12k_base *ab);
-void ath12k_pci_power_down(struct ath12k_base *ab);
+void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend);
 #endif /* ATH12K_PCI_H */
-- 
2.25.1


