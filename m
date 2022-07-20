Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718757B7E8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbiGTNu2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiGTNuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:50:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DFA474DD
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:50:23 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KDm7T3003889;
        Wed, 20 Jul 2022 13:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=a0oIzoARst/nIH5Xd7+Pzrfpan2zxfG5Ufh5EUajJTA=;
 b=Qd6cyWXQ4sc/abjNdWgxOcalwipM0zwzpTA6LQuwuK95kValBCayRtMGNMiwL2Fngi2S
 R+YhXoP55t2kaFJdFCf8TmwD7ZNnA+ub2asmbUsFU7SPmvcILkgBYJUfZyN7waQxh9Xa
 thw1gQvKz5JTf0/GjzvUkBazO1Cf1pzgRbsodAheCqJbFLetv2HkPIZWu+x4oaq96tJu
 j3JgJYRf5oYr+aMqPQ3KZTZZmzXdMbJ8Z3BvQLJNoExJWtY5su7lNFr6yVegrEWg2iZm
 Re706cMay+fM3IHaXVDPDLOlEEE131Mq38dfgM0h3saVpX4/TDjDyfuH347SZg3Ga8gx uQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hebfv15ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:50:21 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KDoKae014017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:50:20 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:50:20 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:50:18 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 3/4] ath11k: Enable low power mode when WLAN is not active
Date:   Wed, 20 Jul 2022 19:19:58 +0530
Message-ID: <20220720134959.15688-4-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zLIfXYxKcvBsu3riB2I8LPh4vKzVeI0i
X-Proofpoint-ORIG-GUID: zLIfXYxKcvBsu3riB2I8LPh4vKzVeI0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_08,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, WLAN chip is powered once during driver probe and is kept
ON (powered) always even when WLAN is not active; keeping the chip
powered ON all the time will consume extra power which is not
desirable for a battery operated device. Same is the case with non-WoW
suspend, chip will never be put into low power mode when the system is
suspended resulting in higher battery drain.

As per the recommendation, sending a PDEV suspend WMI command followed
by a QMI MODE OFF command will cease all WLAN activity and put the device
in low power mode. When WLAN interfaces are brought up, sending a QMI
MISSION MODE command would be sufficient to bring the chip out of low
power. This is a better approach than doing hif_power_down()/hif_power_up()
for every WiFi ON/OFF sequence since the turnaround time for entry/exit of
low power mode is much less. Overhead is just the time taken for sending
QMI MODE OFF & QMI MISSION MODE commands instead of going through the
entire chip boot & QMI init sequence.

Change is applicable for all ath11k devices and should not cause any
negative impact.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Change-Id: I3cfc7420cef2a3eb88aed57f92c08a6e71647e5c
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 155 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  |   4 +
 3 files changed, 144 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index f4f88a19539e..2dd51f1ecfd0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1210,7 +1210,6 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
 	ath11k_debugfs_soc_destroy(ab);
-	ath11k_dp_free(ab);
 	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
 }
@@ -1266,11 +1265,7 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
-	ath11k_spectral_deinit(ab);
-	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
-	ath11k_hif_irq_disable(ab);
-	ath11k_dp_pdev_free(ab);
 	ath11k_debugfs_pdev_destroy(ab);
 }
 
@@ -1423,7 +1418,7 @@ static int ath11k_core_rfkill_config(struct ath11k_base *ab)
 	return ret;
 }
 
-int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
+static int ath11k_core_setup_device(struct ath11k_base *ab)
 {
 	int ret;
 
@@ -1456,17 +1451,44 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		break;
 	default:
 		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_dp_free;
 	}
 
 	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
 		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
 
+	return 0;
+
+err_dp_free:
+	ath11k_dp_free(ab);
+err_firmware_stop:
+	ath11k_qmi_firmware_stop(ab);
+
+	return ret;
+}
+
+static void ath11k_core_free_device(struct ath11k_base *ab)
+{
+	ath11k_dp_free(ab);
+	ath11k_qmi_firmware_stop(ab);
+}
+
+int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_core_setup_device(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to setup device: %d\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&ab->core_lock);
 	ret = ath11k_core_start(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to start core: %d\n", ret);
-		goto err_dp_free;
+		goto err_core_free;
 	}
 
 	ret = ath11k_core_pdev_create(ab);
@@ -1482,6 +1504,7 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		goto err_core_stop;
 	}
 
+	ath11k_core_stop_device(ab);
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -1489,11 +1512,9 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 err_core_stop:
 	ath11k_core_stop(ab);
 	ath11k_mac_destroy(ab);
-err_dp_free:
-	ath11k_dp_free(ab);
+err_core_free:
 	mutex_unlock(&ab->core_lock);
-err_firmware_stop:
-	ath11k_qmi_firmware_stop(ab);
+	ath11k_core_free_device(ab);
 
 	return ret;
 }
@@ -1794,7 +1815,6 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	mutex_lock(&ab->core_lock);
 
 	ath11k_core_pdev_destroy(ab);
-	ath11k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
 
@@ -1863,35 +1883,136 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 }
 EXPORT_SYMBOL(ath11k_core_alloc);
 
+static int ath11k_core_suspend_target(struct ath11k_base *ab, u32 suspend_opt)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	unsigned long time_left;
+	int ret;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		reinit_completion(&ab->htc_suspend);
+
+		ret = ath11k_wmi_pdev_suspend(ar, suspend_opt, pdev->pdev_id);
+		if (ret) {
+			ath11k_warn(ab, "could not suspend target (%d)\n", ret);
+			return ret;
+		}
+
+		time_left = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
+
+		if (!time_left) {
+			ath11k_warn(ab, "suspend timed out - target pause event never came\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+void ath11k_core_stop_device(struct ath11k_base *ab)
+{
+	ath11k_core_suspend_target(ab, WMI_PDEV_SUSPEND_AND_DISABLE_INTR);
+	ath11k_hif_irq_disable(ab);
+	ath11k_hif_stop(ab);
+
+	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
+		ath11k_qmi_firmware_stop(ab);
+
+	ath11k_wmi_detach(ab);
+	ath11k_dp_pdev_reo_cleanup(ab);
+	ath11k_spectral_deinit(ab);
+	ath11k_thermal_unregister(ab);
+	ath11k_dp_pdev_free(ab);
+	ath11k_dp_free(ab);
+}
+
+int ath11k_core_any_pdevs_on(struct ath11k_base *ab)
+{
+	struct ath11k_pdev *pdev;
+	struct ath11k *ar;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		if (!ar)
+			continue;
+
+		if (ar->state == ATH11K_STATE_ON)
+			return true;
+	}
+
+	return false;
+}
+
 int ath11k_core_start_device(struct ath11k_base *ab)
 {
 	int ret;
 
-	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
+	/* Initialize the hardware/firmware only for the first PDEV
+	 * or during hardware recovery.
+	 */
+	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
+	    ath11k_core_any_pdevs_on(ab))
 		return 0;
 
+	mutex_lock(&ab->core_lock);
+
 	ath11k_hal_srng_deinit(ab);
 
 	ret = ath11k_hal_srng_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init srng: %d\n", ret);
-		return ret;
+		goto err_unlock;
 	}
 
 	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
-	ret = ath11k_core_qmi_firmware_ready(ab);
+	ret = ath11k_core_setup_device(ab);
 	if (ret) {
-		ath11k_err(ab, "failed to init core: %d\n", ret);
+		ath11k_err(ab, "failed to setup device: %d\n", ret);
 		goto err_hal_srng_deinit;
 	}
 
+	ret = ath11k_core_start(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to start core: %d\n", ret);
+		goto err_core_free;
+	}
+
+	ret = ath11k_core_pdev_create(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
+		goto err_core_stop;
+	}
+	ath11k_hif_irq_enable(ab);
+
+	ret = ath11k_core_rfkill_config(ab);
+	if (ret && ret != -EOPNOTSUPP) {
+		ath11k_err(ab, "failed to config rfkill: %d\n", ret);
+		goto err_core_stop;
+	}
+
 	clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
 
+	mutex_unlock(&ab->core_lock);
+
 	return 0;
 
+err_core_stop:
+	ath11k_core_stop(ab);
+	ath11k_mac_destroy(ab);
+err_core_free:
+	ath11k_core_free_device(ab);
 err_hal_srng_deinit:
 	ath11k_hal_srng_deinit(ab);
+err_unlock:
+	mutex_unlock(&ab->core_lock);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 5ecb60a1b51d..61f8a3e7cabe 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1140,6 +1140,8 @@ void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
 int ath11k_core_start_device(struct ath11k_base *ab);
+void ath11k_core_stop_device(struct ath11k_base *ab);
+int ath11k_core_any_pdevs_on(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 84f2604a16e4..c459e43dee74 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5926,6 +5926,10 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	synchronize_rcu();
 
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
+
+	/* If all PDEVs on the SoC are down, then power down the device */
+	if (!ath11k_core_any_pdevs_on(ar->ab))
+		ath11k_core_stop_device(ar->ab);
 }
 
 static void
-- 
2.35.1

