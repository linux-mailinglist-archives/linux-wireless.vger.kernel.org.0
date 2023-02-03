Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60E6688F50
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 07:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBCGCA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 01:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjBCGB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 01:01:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E9F6FD2B
        for <linux-wireless@vger.kernel.org>; Thu,  2 Feb 2023 22:01:58 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3135HAta025683;
        Fri, 3 Feb 2023 06:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=LYSQyu1j/QvH/H/UngGSw+5D4Cyb+dS8pRJY04xaRZ0=;
 b=TdQo7lwgtM8eNaG9pwUSC47jL/DhEjG4wZMnkGMd9XbEh2AHd1iJa+XTSXOhwu9VXT6I
 hc7JZ/pSvLm1UGmi7hodfDxC1Dwj9BYoWFHrsvOBlDaULbq4BrsJDeJmQaBuZSlcZMSc
 XFFKsMdJDkYk8grp5cx65aYMLj7T2hYOtppjpyG7Awp1mvMjtaANm9t/vq5xHK2FZeyq
 kx5gSJ4Cl80H4ZDYPKYo3rLUlB4+ZjmK3d8AhqbsR7FV7lXfDifUCVA8jT9RHuei+Zpz
 QNomBZaUtZvFI3TgJQkJ9A9FxuUXQs1uGsVXWzlYsCd0qJX/159g12qom38jqUtw7j0W Lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngns2gqna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 06:01:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31361tr9004912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 06:01:55 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 22:01:53 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v4 2/3] ath11k: Move hardware initialization logic to start()
Date:   Fri, 3 Feb 2023 11:31:27 +0530
Message-ID: <20230203060128.19625-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KlCdCfR1hmO4VTydww-R374orWQ2rrk4
X-Proofpoint-ORIG-GUID: KlCdCfR1hmO4VTydww-R374orWQ2rrk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 83 +++++++++++---------------
 drivers/net/wireless/ath/ath11k/core.h |  6 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 29 +++------
 drivers/net/wireless/ath/ath11k/qmi.c  |  3 +-
 4 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 75fdbe4ef83a..5cdac963444e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1652,10 +1652,8 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1667,27 +1665,8 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
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
@@ -1831,19 +1810,9 @@ static void ath11k_core_post_reconfigure_recovery(struct ath11k_base *ab)
 static void ath11k_core_restart(struct work_struct *work)
 {
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, restart_work);
-	int ret;
 
-	ret = ath11k_core_reconfigure_on_crash(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to reconfigure driver on crash recovery\n");
-		return;
-	}
-
-	if (ab->is_reset)
-		complete_all(&ab->reconfigure_complete);
-
-	if (!ab->is_reset)
-		ath11k_core_post_reconfigure_recovery(ab);
+	ath11k_core_reconfigure_on_crash(ab);
+	ath11k_core_post_reconfigure_recovery(ab);
 }
 
 static void ath11k_core_reset(struct work_struct *work)
@@ -1897,18 +1866,6 @@ static void ath11k_core_reset(struct work_struct *work)
 
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
@@ -2016,8 +1973,6 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	spin_lock_init(&ab->base_lock);
 	mutex_init(&ab->vdev_id_11d_lock);
 	init_completion(&ab->reset_complete);
-	init_completion(&ab->reconfigure_complete);
-	init_completion(&ab->recovery_start);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
@@ -2043,5 +1998,37 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
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
index 0830276e5028..582960deb27b 100644
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
@@ -935,11 +933,8 @@ struct ath11k_base {
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
@@ -1172,6 +1167,7 @@ void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
 void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
+int ath11k_core_start_device(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 110a38cce0a7..742fbac3d54f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5810,27 +5810,6 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
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
@@ -5839,6 +5818,13 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
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
@@ -5847,7 +5833,6 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 		break;
 	case ATH11K_STATE_RESTARTING:
 		ar->state = ATH11K_STATE_RESTARTED;
-		ath11k_mac_wait_reconfigure(ab);
 		break;
 	case ATH11K_STATE_RESTARTED:
 	case ATH11K_STATE_WEDGED:
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index ab923e24b0a9..2e651b0fec8a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3165,8 +3165,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			set_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 			set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
 
-			if (!ab->is_reset)
-				ath11k_core_pre_reconfigure_recovery(ab);
+			ath11k_core_pre_reconfigure_recovery(ab);
 			break;
 		case ATH11K_QMI_EVENT_REQUEST_MEM:
 			ret = ath11k_qmi_event_mem_request(qmi);
-- 
2.38.0

