Return-Path: <linux-wireless+bounces-8248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0208D2B8A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 05:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03F91F246B4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2D15AAB1;
	Wed, 29 May 2024 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J+qhxfy1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA8273DC
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716954271; cv=none; b=Mi7bhPGJp7e2Tfvy1HgPWXUNzmUX//swhDyWGeCVcTFH+wUw23QDFLOLK5aPp3M5/1+fwtm7/lOx/nvfxErdNNdhp1MJihalT0RJbtpwMlo0Knl3gtDa4ofjwXYqGNqs8iIE23AP2bpnvBc/GXNGBooNkJUHcSNhUVH0KFX540M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716954271; c=relaxed/simple;
	bh=pOXpODSkbDcQdOMB1yOQCLJ4tKgCNQ2ajuB8c8DoMC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Or/0eE3bv/x96ygNE4gSVwgmpOTBRwRFbqspKazJMPhciKFumyBqo01eBL2u9x3kWBt5b/fDCVMIlerWg8RULMkYdb3krAiPTNVROOxC0K1NSx2OC0kXQ3Kmg65pSBDGGKv6qnYpzJwQ3236jKx7ymhdUjI/Y3nscGfQf3lKUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J+qhxfy1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SMkTLa031447;
	Wed, 29 May 2024 03:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YWTELY7xv9JTRJKG/QGvhA
	8BiVdicICkBwkFxCqyq0Q=; b=J+qhxfy1PAriLqNzZwlo37MLCH5jDaONlCc2RL
	uXNzVR+oed/rRXTWa/rUd/6F1pj7Fb7CM4d/neSrGi5IzinJJKk8kbzS6gsLtgnQ
	+ugtH42LT8oWH8TJlL2sgcyrxyvd1PnCEzU+GeiD94c23oE2WuKaMTCbJdrNsFi2
	1jKevPDpoxlVLEI4oVPWsZenQxDGMOtg2y4xQXIM73KYGWpsgOdKLzBlKolI1/2W
	QMD+7CTu+MEwiOjvU16O68THADF6aBG1Ws9EsqQQP0NDpGAdCOjgTtHuMQnjs8Cs
	wCLIbeQjAVnI1SeoHp1n1Xgwc/UL1FHdlj4iEmSf8T2FWl4A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0x7wjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 03:44:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T3iLcF017512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 03:44:21 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 20:44:19 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in split-phy
Date: Wed, 29 May 2024 09:14:05 +0530
Message-ID: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 549p5_HYPi8fS4z2K6dH1FhSWXeBUj7Y
X-Proofpoint-ORIG-GUID: 549p5_HYPi8fS4z2K6dH1FhSWXeBUj7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290022

Whenever firmware is crashed in split-phy below WARN_ON triggered:

? __warn+0x7b/0x1a0
? drv_stop+0x1eb/0x210 [mac80211]
? report_bug+0x10b/0x200
? handle_bug+0x3f/0x70
? exc_invalid_op+0x13/0x60
? asm_exc_invalid_op+0x16/0x20
? drv_stop+0x1eb/0x210 [mac80211]
ieee80211_do_stop+0x5ba/0x850 [mac80211]
ieee80211_stop+0x51/0x180 [mac80211]
__dev_close_many+0xb3/0x130
dev_close_many+0xa3/0x180
? lock_release+0xde/0x420
dev_close.part.147+0x5f/0xa0
cfg80211_shutdown_all_interfaces+0x44/0xe0 [cfg80211]
ieee80211_restart_work+0xf9/0x130 [mac80211]
process_scheduled_works+0x377/0x6f0

The sequence of WARN_ON is:
Thread 1:
-Firmware crash calls ath12k_core_reset().
-Call ieee80211_restart_hw() inside
 ath12k_core_post_reconfigure_recovery() which schedules worker
 for both hardware.
-Wait for completion of ab->recovery_start.

Thread 2 (worker thread):
-One hardware acquires rtnl_lock() inside ieee80211_restart_hw() and
 calls ath12k_mac_wait_reconfigure() into ath12k_mac_op_start().
-Hardware is waiting for ab->reconfigure_complete but at this time
 recovery_start_count value is 1 because another worker thread
 (local->restart_work) is still waiting for rtnl_lock().
 recovery_start_count is not equal to number of radios
 (2 in split-phy). So ab->recovery_start complete does not set
 due to this, thread 1 is still waiting and not able to perform
 hif power down up and firmware reload.
-Wait timeout happens for ab->reconfigure_complete and comeback
 to caller (ath12k_mac_op_start()) and sends WMI command to
 crashed firmware and gets error.
-This returns error to drv_start() and local->started is set to false.
-Hardware calls cfg80211_shutdown_all_interfaces() after receiving error
 inside ieee80211_restart_work() and goes to drv_stop(), here we trigger
 WARN_ON as local->started is false.

To fix this issue call ieee80211_restart_hw() after firmware has been
reloaded. Now, each hardware can send WMI command to firmware
successfully. With this fix we don't need to wait for
ab->recovery_start completion so remove
ath12k_mac_wait_reconfigure().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 21 ++++++++-------------
 drivers/net/wireless/ath/ath12k/core.h |  3 ---
 drivers/net/wireless/ath/ath12k/mac.c  | 23 -----------------------
 3 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index e7f628e935e4..9fac8b1b064e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1059,8 +1059,6 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 				mutex_unlock(&ar->conf_mutex);
 			}
 
-			/* Restart after all the link/radio halt */
-			ieee80211_restart_hw(ah->hw);
 			break;
 		case ATH12K_HW_STATE_OFF:
 			ath12k_warn(ab,
@@ -1087,7 +1085,8 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 static void ath12k_core_restart(struct work_struct *work)
 {
 	struct ath12k_base *ab = container_of(work, struct ath12k_base, restart_work);
-	int ret;
+	struct ath12k_hw *ah;
+	int ret, i;
 
 	ret = ath12k_core_reconfigure_on_crash(ab);
 	if (ret) {
@@ -1095,8 +1094,12 @@ static void ath12k_core_restart(struct work_struct *work)
 		return;
 	}
 
-	if (ab->is_reset)
-		complete_all(&ab->reconfigure_complete);
+	if (ab->is_reset) {
+		for (i = 0; i < ab->num_hw; i++) {
+			ah = ab->ah[i];
+			ieee80211_restart_hw(ah->hw);
+		}
+	}
 
 	complete(&ab->restart_completed);
 }
@@ -1150,20 +1153,14 @@ static void ath12k_core_reset(struct work_struct *work)
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset starting\n");
 
 	ab->is_reset = true;
-	atomic_set(&ab->recovery_start_count, 0);
-	reinit_completion(&ab->recovery_start);
 	atomic_set(&ab->recovery_count, 0);
 
 	ath12k_core_pre_reconfigure_recovery(ab);
 
-	reinit_completion(&ab->reconfigure_complete);
 	ath12k_core_post_reconfigure_recovery(ab);
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "waiting recovery start...\n");
 
-	time_left = wait_for_completion_timeout(&ab->recovery_start,
-						ATH12K_RECOVER_START_TIMEOUT_HZ);
-
 	ath12k_hif_irq_disable(ab);
 	ath12k_hif_ce_irq_disable(ab);
 
@@ -1246,8 +1243,6 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	mutex_init(&ab->core_lock);
 	spin_lock_init(&ab->base_lock);
 	init_completion(&ab->reset_complete);
-	init_completion(&ab->reconfigure_complete);
-	init_completion(&ab->recovery_start);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7d20b09c52e6..96fafa0e05dc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -846,11 +846,8 @@ struct ath12k_base {
 	struct work_struct reset_work;
 	atomic_t reset_count;
 	atomic_t recovery_count;
-	atomic_t recovery_start_count;
 	bool is_reset;
 	struct completion reset_complete;
-	struct completion reconfigure_complete;
-	struct completion recovery_start;
 	/* continuous recovery fail count */
 	atomic_t fail_cont_count;
 	unsigned long reset_fail_timeout;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..33616ab795af 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5834,28 +5834,6 @@ static int ath12k_mac_config_mon_status_default(struct ath12k *ar, bool enable)
 	/* TODO: Need to support new monitor mode */
 }
 
-static void ath12k_mac_wait_reconfigure(struct ath12k_base *ab)
-{
-	int recovery_start_count;
-
-	if (!ab->is_reset)
-		return;
-
-	recovery_start_count = atomic_inc_return(&ab->recovery_start_count);
-
-	ath12k_dbg(ab, ATH12K_DBG_MAC, "recovery start count %d\n", recovery_start_count);
-
-	if (recovery_start_count == ab->num_radios) {
-		complete(&ab->recovery_start);
-		ath12k_dbg(ab, ATH12K_DBG_MAC, "recovery started success\n");
-	}
-
-	ath12k_dbg(ab, ATH12K_DBG_MAC, "waiting reconfigure...\n");
-
-	wait_for_completion_timeout(&ab->reconfigure_complete,
-				    ATH12K_RECONFIGURE_TIMEOUT_HZ);
-}
-
 static int ath12k_mac_start(struct ath12k *ar)
 {
 	struct ath12k_hw *ah = ar->ah;
@@ -5987,7 +5965,6 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 		break;
 	case ATH12K_HW_STATE_RESTARTING:
 		ah->state = ATH12K_HW_STATE_RESTARTED;
-		ath12k_mac_wait_reconfigure(ah->ab);
 		break;
 	case ATH12K_HW_STATE_RESTARTED:
 	case ATH12K_HW_STATE_WEDGED:

base-commit: 0442aec67bbd9cbf93bf7f6ee59c9bf5348b9249
-- 
2.34.1


