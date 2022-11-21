Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8EE631F05
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 12:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKULEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 06:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKULE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 06:04:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F8A2ED7F
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 03:04:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL8Opo1020398;
        Mon, 21 Nov 2022 11:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ox+BC+yrItfuFCOhxjZF9VhPXYG3PYdj/WL/RocwU4Q=;
 b=Ab2cE1d/tlzLaZcnzT9J+i1LujxXHfi5/0/bEypHErQmEMmU/7ZaX5P3g1Irsf+N+56M
 p5dvgQqp7ylNRSA3JOxuB1V0t7P8sYQIwscM8BZU+3gdrxPcRMiaRlBS+fhi9Ym4HGaZ
 sYvo+v1OvYPLcv7ndAouMxlpgVrzcrNnzXZUFrMN6BnsalLhe+3SKxf/AsGYCVzX2vs0
 cy+YLKjqHDOSg+yZriHzeQ2ZCXk0QroZgOc0AfD/HWftqdxIPYP7iUt0/AEeG2rSmDJi
 unZ1wykB1xy8YxmUn276f/WLllq66DqQLqyG380nNKSNQYzV1RYKIoTu1my3zIoLipCM Bw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrfbv9dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALB4PxB023593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:25 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 03:04:23 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 2/3] ath11k: Move hardware initialization logic to start()
Date:   Mon, 21 Nov 2022 16:33:58 +0530
Message-ID: <20221121110359.4652-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
References: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wUnMBfQkY0-G86CfAaaeCKIY8tM77YAc
X-Proofpoint-ORIG-GUID: wUnMBfQkY0-G86CfAaaeCKIY8tM77YAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index edf78df9b12f..d36e193b2db9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1559,10 +1559,8 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1574,27 +1572,8 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
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
@@ -1738,19 +1717,9 @@ static void ath11k_core_post_reconfigure_recovery(struct ath11k_base *ab)
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
@@ -1804,18 +1773,6 @@ static void ath11k_core_reset(struct work_struct *work)
 
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
@@ -1923,8 +1880,6 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	spin_lock_init(&ab->base_lock);
 	mutex_init(&ab->vdev_id_11d_lock);
 	init_completion(&ab->reset_complete);
-	init_completion(&ab->reconfigure_complete);
-	init_completion(&ab->recovery_start);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
@@ -1950,5 +1905,37 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
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
index 22460b0abf03..9b55ac94b36c 100644
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
@@ -926,11 +924,8 @@ struct ath11k_base {
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
@@ -1160,6 +1155,7 @@ void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
 void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
+int ath11k_core_start_device(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9e923ecb0891..c21ebf0578dc 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5788,27 +5788,6 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
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
@@ -5817,6 +5796,13 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
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
@@ -5825,7 +5811,6 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
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

