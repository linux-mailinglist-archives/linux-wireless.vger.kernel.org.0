Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363925A0ED6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbiHYLSu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 07:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiHYLSt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 07:18:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11314AEDA3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 04:18:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P2vcX2017117;
        Thu, 25 Aug 2022 11:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zG5jvxHawmb5OK8jyGHswdT9HH2wnt69TP29blAGMmc=;
 b=X0fC7cJOUP3R58jRmSGy81TehSKoCfiQWHsa2edXm3pp+yC7AxetX1bArwQm/fhrwJYu
 JCGVLi86gqHnKve4pFLS+wvechRoJpFNsMfymdWRHCqZGJrybxQyslmLAeaItTWvkc/n
 jpQAiHKKBND+WGzk42jC2eJ2ml3ElC+vFn3qdBcUZZZEPWmQhygXILoN6NMzakgNDM3h
 ocNznza+FYiGKM2TMOVCfGVkxflknpEFlNzFsTbNOnFMGuUgfaISygPD/VaqKXDx+96h
 ZdEFLV8kBMiOhfsTt18dmZKp6trHekD/VeEhn89p27IGlsD3kEMhUUJGCWLShtsh9bVK yA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j60etsawg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PBIefK026394
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:40 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 25 Aug 2022 04:18:38 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 2/4] ath11k: Move hardware initialization logic to start()
Date:   Thu, 25 Aug 2022 16:48:16 +0530
Message-ID: <20220825111818.30869-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
References: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ByHC8Eyd9ozYAZNaV-333TyH-SYD2eTA
X-Proofpoint-ORIG-GUID: ByHC8Eyd9ozYAZNaV-333TyH-SYD2eTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently during recovery, hardware is re-initialized as part of
ath11k_core_reconfigure_on_crash(). In order to enable low power
mode support in the driver, it is required to move the hardware
re-initialization logic to ath11k_ops.start() hook.

Since ath11k_ops.start() hook is called during WiFi ON/resume and
also during hardware recovery, it is better to defer the hardware
initialization to ath11k_ops.start() in the case of hardware recovery.
This will help ensure that there is only path for the initialization
of the hardware across different scenarios. A future patch will add
the support of initializing the hardware from start() hook in
WiFi ON/resume cases as well.

Commit 38194f3a605e ("ath11k: add synchronization operation between
reconfigure of mac80211 and ath11k_base") introduced a similar change that
applies just to QCA6390/WCN6855 to defer the initialization of the hardware
during recovery by using wait logic. This is no more needed and therefore
remove it.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 87 +++++++++++---------------
 drivers/net/wireless/ath/ath11k/core.h |  6 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 29 +++------
 3 files changed, 44 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c3e9e4f7bc24..8cfef7a07a65 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1435,10 +1435,8 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 	return ret;
 }
 
-static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
+static void ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 {
-	int ret;
-
 	mutex_lock(&ab->core_lock);
 	ath11k_thermal_unregister(ab);
 	ath11k_hif_irq_disable(ab);
@@ -1450,27 +1448,8 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
-	ath11k_hal_srng_deinit(ab);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
-
-	ret = ath11k_hal_srng_init(ab);
-	if (ret)
-		return ret;
-
-	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
-
-	ret = ath11k_core_qmi_firmware_ready(ab);
-	if (ret)
-		goto err_hal_srng_deinit;
-
-	clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
-
-	return 0;
-
-err_hal_srng_deinit:
-	ath11k_hal_srng_deinit(ab);
-	return ret;
 }
 
 void ath11k_core_halt(struct ath11k *ar)
@@ -1608,22 +1587,10 @@ static void ath11k_core_post_reconfigure_recovery(struct ath11k_base *ab)
 static void ath11k_core_restart(struct work_struct *work)
 {
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, restart_work);
-	int ret;
-
-	if (!ab->is_reset)
-		ath11k_core_pre_reconfigure_recovery(ab);
-
-	ret = ath11k_core_reconfigure_on_crash(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to reconfigure driver on crash recovery\n");
-		return;
-	}
-
-	if (ab->is_reset)
-		complete_all(&ab->reconfigure_complete);
 
-	if (!ab->is_reset)
-		ath11k_core_post_reconfigure_recovery(ab);
+	ath11k_core_pre_reconfigure_recovery(ab);
+	ath11k_core_reconfigure_on_crash(ab);
+	ath11k_core_post_reconfigure_recovery(ab);
 }
 
 static void ath11k_core_reset(struct work_struct *work)
@@ -1677,18 +1644,6 @@ static void ath11k_core_reset(struct work_struct *work)
 
 	ab->is_reset = true;
 	atomic_set(&ab->recovery_count, 0);
-	reinit_completion(&ab->recovery_start);
-	atomic_set(&ab->recovery_start_count, 0);
-
-	ath11k_core_pre_reconfigure_recovery(ab);
-
-	reinit_completion(&ab->reconfigure_complete);
-	ath11k_core_post_reconfigure_recovery(ab);
-
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "waiting recovery start...\n");
-
-	time_left = wait_for_completion_timeout(&ab->recovery_start,
-						ATH11K_RECOVER_START_TIMEOUT_HZ);
 
 	ath11k_hif_power_down(ab);
 	ath11k_hif_power_up(ab);
@@ -1796,8 +1751,6 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	spin_lock_init(&ab->base_lock);
 	mutex_init(&ab->vdev_id_11d_lock);
 	init_completion(&ab->reset_complete);
-	init_completion(&ab->reconfigure_complete);
-	init_completion(&ab->recovery_start);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
@@ -1823,5 +1776,37 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 }
 EXPORT_SYMBOL(ath11k_core_alloc);
 
+int ath11k_core_start_device(struct ath11k_base *ab)
+{
+	int ret;
+
+	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
+		return 0;
+
+	ath11k_hal_srng_deinit(ab);
+
+	ret = ath11k_hal_srng_init(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init srng: %d\n", ret);
+		return ret;
+	}
+
+	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
+
+	ret = ath11k_core_qmi_firmware_ready(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init core: %d\n", ret);
+		goto err_hal_srng_deinit;
+	}
+
+	clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+
+	return 0;
+
+err_hal_srng_deinit:
+	ath11k_hal_srng_deinit(ab);
+	return ret;
+}
+
 MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index afad8f55e433..086cc127c39c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -60,8 +60,6 @@ extern unsigned int ath11k_frame_mode;
 #define ATH11K_RESET_MAX_FAIL_COUNT_FIRST 3
 #define ATH11K_RESET_MAX_FAIL_COUNT_FINAL 5
 #define ATH11K_RESET_FAIL_TIMEOUT_HZ (20 * HZ)
-#define ATH11K_RECONFIGURE_TIMEOUT_HZ (10 * HZ)
-#define ATH11K_RECOVER_START_TIMEOUT_HZ (20 * HZ)
 
 enum ath11k_supported_bw {
 	ATH11K_BW_20	= 0,
@@ -913,11 +911,8 @@ struct ath11k_base {
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
@@ -1140,6 +1135,7 @@ int ath11k_core_check_smbios(struct ath11k_base *ab);
 void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
+int ath11k_core_start_device(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7e91e347c9ff..56d63e9d2f1a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5696,27 +5696,6 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 	return ret;
 }
 
-static void ath11k_mac_wait_reconfigure(struct ath11k_base *ab)
-{
-	int recovery_start_count;
-
-	if (!ab->is_reset)
-		return;
-
-	recovery_start_count = atomic_inc_return(&ab->recovery_start_count);
-	ath11k_dbg(ab, ATH11K_DBG_MAC, "recovery start count %d\n", recovery_start_count);
-
-	if (recovery_start_count == ab->num_radios) {
-		complete(&ab->recovery_start);
-		ath11k_dbg(ab, ATH11K_DBG_MAC, "recovery started success\n");
-	}
-
-	ath11k_dbg(ab, ATH11K_DBG_MAC, "waiting reconfigure...\n");
-
-	wait_for_completion_timeout(&ab->reconfigure_complete,
-				    ATH11K_RECONFIGURE_TIMEOUT_HZ);
-}
-
 static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath11k *ar = hw->priv;
@@ -5725,6 +5704,13 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	int ret;
 
 	ath11k_mac_drain_tx(ar);
+
+	ret = ath11k_core_start_device(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to start device : %d\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&ar->conf_mutex);
 
 	switch (ar->state) {
@@ -5733,7 +5719,6 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 		break;
 	case ATH11K_STATE_RESTARTING:
 		ar->state = ATH11K_STATE_RESTARTED;
-		ath11k_mac_wait_reconfigure(ab);
 		break;
 	case ATH11K_STATE_RESTARTED:
 	case ATH11K_STATE_WEDGED:
-- 
2.37.1

