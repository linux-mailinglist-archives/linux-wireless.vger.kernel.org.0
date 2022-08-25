Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB45A0ED9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiHYLSw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbiHYLSv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 07:18:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB0AEDAE
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 04:18:50 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P5pVnV018461;
        Thu, 25 Aug 2022 11:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6CsUPr2gXzA3SsoYjF5cGE5H2GpAJ2XqKBaEmYhsm+s=;
 b=Nqkz3qflVJxwGoXJWzv73I5h4P1pkSdSU7qoHOMQBaj6UKzi1M82GUUv3PfXKUH8F3fj
 F7lfjmwBlmNveFhq4D4w4M1LDeygdWO+WXM91mjSTw6GR2Qb1bVVjmFKUp8lJsDtDhSE
 cBz5BFsTEieTFoFmm/K55H8GM64CIdOOdNKjB+fdnkLgdEhNxhxb+rftnqDuUo9mE/LY
 7pFubWrEaPudits5TSJ9gQRiZn7uBirgIZwmVh1LI2JfCXSJrRxgcklJ46003SrddDTW
 lL88jvhDqJL68jM8xgC5lLBY/cSB2PCBNf8mGUfT9GC2ZPj/37hHEbNO4iCzxqVZCLg4 Ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j6399gwjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PBIgCt004039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:42 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 25 Aug 2022 04:18:40 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 3/4] ath11k: Enable low power mode when WLAN is not active
Date:   Thu, 25 Aug 2022 16:48:17 +0530
Message-ID: <20220825111818.30869-4-quic_mpubbise@quicinc.com>
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
X-Proofpoint-GUID: xdUy92288Fk2y8ulhBokDE-sJOscg1FF
X-Proofpoint-ORIG-GUID: xdUy92288Fk2y8ulhBokDE-sJOscg1FF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

Currently the changes are applicable only for WCN6750. This can be
extended to other targets with a future patch.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  45 ++++++++
 drivers/net/wireless/ath/ath11k/core.c | 149 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/hif.h  |  12 ++
 drivers/net/wireless/ath/ath11k/mac.c  |   8 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  26 +++++
 6 files changed, 222 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index c47414710138..d5784f319f2d 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -189,6 +189,47 @@ static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
 	.window_read32 = ath11k_ahb_window_read32_wcn6750,
 };
 
+static int ath11k_ahb_core_start_wcn6750(struct ath11k_base *ab)
+{
+	/* Initialize the hardware/firmware only for the first PDEV
+	 * or during hardware recovery.
+	 */
+	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
+	    ath11k_core_any_pdevs_on(ab))
+		return 0;
+
+	return ath11k_core_start_device(ab);
+}
+
+static void ath11k_ahb_core_stop_wcn6750(struct ath11k_base *ab)
+{
+	return ath11k_core_stop_device(ab);
+}
+
+static int ath11k_ahb_core_start_ipq8074(struct ath11k_base *ab)
+{
+	/* TODO: Currently initializing the hardware/firmware only
+	 * during hardware recovery. Support to shutdown/turn-on
+	 * the hardware during Wi-Fi OFF/ON will be added later.
+	 */
+	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
+		return 0;
+
+	return ath11k_core_start_device(ab);
+}
+
+static void ath11k_ahb_core_stop_ipq8074(struct ath11k_base *ab)
+{
+	/* TODO: Currently stopping the hardware/firmware only
+	 * during driver unload. Support to shutdown/turn-on
+	 * the hardware during Wi-Fi OFF/ON will be added later.
+	 */
+	if (!test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags))
+		return;
+
+	return ath11k_core_stop_device(ab);
+}
+
 static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
 {
 	return ioread32(ab->mem + offset);
@@ -695,6 +736,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_ipq8074 = {
 	.map_service_to_pipe = ath11k_ahb_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.core_start = ath11k_ahb_core_start_ipq8074,
+	.core_stop = ath11k_ahb_core_stop_ipq8074,
 };
 
 static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
@@ -709,6 +752,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
 	.map_service_to_pipe = ath11k_pcic_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.core_start = ath11k_ahb_core_start_wcn6750,
+	.core_stop = ath11k_ahb_core_stop_wcn6750,
 };
 
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8cfef7a07a65..88a54b36e178 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1175,7 +1175,6 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
 	ath11k_debugfs_soc_destroy(ab);
-	ath11k_dp_free(ab);
 	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
 }
@@ -1231,11 +1230,7 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
-	ath11k_spectral_deinit(ab);
-	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
-	ath11k_hif_irq_disable(ab);
-	ath11k_dp_pdev_free(ab);
 	ath11k_debugfs_pdev_destroy(ab);
 }
 
@@ -1367,7 +1362,7 @@ static int ath11k_core_start_firmware(struct ath11k_base *ab,
 	return ret;
 }
 
-int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
+static int ath11k_core_setup_device(struct ath11k_base *ab)
 {
 	int ret;
 
@@ -1400,17 +1395,44 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1418,7 +1440,10 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
 		goto err_core_stop;
 	}
+
 	ath11k_hif_irq_enable(ab);
+	ath11k_hif_core_stop(ab);
+
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -1426,11 +1451,9 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1708,7 +1731,6 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	mutex_lock(&ab->core_lock);
 
 	ath11k_core_pdev_destroy(ab);
-	ath11k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
 
@@ -1776,37 +1798,128 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
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
+EXPORT_SYMBOL(ath11k_core_stop_device);
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
+EXPORT_SYMBOL(ath11k_core_any_pdevs_on);
+
 int ath11k_core_start_device(struct ath11k_base *ab)
 {
 	int ret;
 
-	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
-		return 0;
+	mutex_lock(&ab->core_lock);
 
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
+
+	ath11k_hif_irq_enable(ab);
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
+EXPORT_SYMBOL(ath11k_core_start_device);
 
 MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 086cc127c39c..e5436b7a8f5d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1136,6 +1136,8 @@ void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
 int ath11k_core_start_device(struct ath11k_base *ab);
+void ath11k_core_stop_device(struct ath11k_base *ab);
+int ath11k_core_any_pdevs_on(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index e9366f786fbb..e23b6ed17542 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -29,6 +29,8 @@ struct ath11k_hif_ops {
 	void (*ce_irq_enable)(struct ath11k_base *ab);
 	void (*ce_irq_disable)(struct ath11k_base *ab);
 	void (*get_ce_msi_idx)(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
+	int (*core_start)(struct ath11k_base *ab);
+	void (*core_stop)(struct ath11k_base *ab);
 };
 
 static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
@@ -134,4 +136,14 @@ static inline void ath11k_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
 	else
 		*msi_data_idx = ce_id;
 }
+
+static inline int ath11k_hif_core_start(struct ath11k_base *ab)
+{
+	return ab->hif.ops->core_start(ab);
+}
+
+static inline void ath11k_hif_core_stop(struct ath11k_base *ab)
+{
+	return ab->hif.ops->core_stop(ab);
+}
 #endif /* _HIF_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 56d63e9d2f1a..0cb5f6b7e90e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5705,9 +5705,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath11k_mac_drain_tx(ar);
 
-	ret = ath11k_core_start_device(ab);
+	ret = ath11k_hif_core_start(ab);
 	if (ret) {
-		ath11k_err(ab, "failed to start device : %d\n", ret);
+		ath11k_err(ab, "failed to start core : %d\n", ret);
 		return ret;
 	}
 
@@ -5868,6 +5868,10 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	synchronize_rcu();
 
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
+
+	/* If all PDEVs on the SoC are down, then power down the device */
+	if (!ath11k_core_any_pdevs_on(ar->ab))
+		ath11k_hif_core_stop(ar->ab);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5bd34a6273d9..b4ad69d06a90 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -680,6 +680,30 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_pci_core_start(struct ath11k_base *ab)
+{
+	/* TODO: Currently initializing the hardware/firmware only
+	 * during hardware recovery. Support to shutdown/turn-on
+	 * the hardware during Wi-Fi OFF/ON will be added later.
+	 */
+	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
+		return 0;
+
+	return ath11k_core_start_device(ab);
+}
+
+static void ath11k_pci_core_stop(struct ath11k_base *ab)
+{
+	/* TODO: Currently stopping the hardware/firmware only
+	 * during driver unload. Support to shutdown/turn-on
+	 * the hardware during Wi-Fi OFF/ON will be added later.
+	 */
+	if (!test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags))
+		return;
+
+	return ath11k_core_stop_device(ab);
+}
+
 static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.start = ath11k_pci_start,
 	.stop = ath11k_pcic_stop,
@@ -697,6 +721,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+	.core_start = ath11k_pci_core_start,
+	.core_stop = ath11k_pci_core_stop,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
-- 
2.37.1

