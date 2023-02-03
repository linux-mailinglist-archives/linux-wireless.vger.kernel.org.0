Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8751688F51
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 07:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBCGCD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 01:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCGCC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 01:02:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D298B6FD17
        for <linux-wireless@vger.kernel.org>; Thu,  2 Feb 2023 22:02:00 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3135Gc0D005169;
        Fri, 3 Feb 2023 06:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ncYpmLYbD9FwWZZ2ihCho8juPJXHPT8f2jXXLEyWqtU=;
 b=m4MVU8w0jowJuRccSlezfHnz9fKqHiflJTESjM+0ykWj+CqXP1lU6BgRG8EFuIosYIXV
 hS1b9aLv8WU7jp4WJAO4pxF6j6OVGIZYtzCU33dKctE7OcjDZI6+kyfTnv3IqLhFMLKq
 JjqIOwfedhpS8MqXSvJuf4+swCyvg4rpu2nUceczA6aH8SmrbECqikV7JFz+3F8siwBZ
 Lyyg5zO6WNeYXLqp1pZSh0fmepaZs4xvN3Mixmetb89JB4Qcfk2KRlEx0893OjhXDG5q
 r4f7PoVnUTXwPADzDePELDqQbHRoq6aBbcPWN295Eq/WxxfhB1iDwF36Nc4hi8H70c5w oQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfqt3mcp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 06:01:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31361vKV005062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 06:01:57 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 22:01:55 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v4 3/3] ath11k: Enable low power mode when WLAN is not active
Date:   Fri, 3 Feb 2023 11:31:28 +0530
Message-ID: <20230203060128.19625-4-quic_mpubbise@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LCFs4Is4UdiweVCucEb8iMNuQZ1M3OLV
X-Proofpoint-GUID: LCFs4Is4UdiweVCucEb8iMNuQZ1M3OLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030055
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

Currently the changes are applicable only for WCN6750. This can be
extended to other targets with a future patch.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  45 +++++
 drivers/net/wireless/ath/ath11k/core.c | 225 ++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/core.h |   4 +
 drivers/net/wireless/ath/ath11k/hif.h  |  11 ++
 drivers/net/wireless/ath/ath11k/mac.c  |   8 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  26 +++
 6 files changed, 275 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index cd48eca494ed..708a49f82297 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -194,6 +194,47 @@ static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
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
@@ -793,6 +834,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_ipq8074 = {
 	.map_service_to_pipe = ath11k_ahb_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.core_start = ath11k_ahb_core_start_ipq8074,
+	.core_stop = ath11k_ahb_core_stop_ipq8074,
 };
 
 static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
@@ -812,6 +855,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
 	.resume = ath11k_ahb_hif_resume,
 	.ce_irq_enable = ath11k_pci_enable_ce_irqs_except_wake_irq,
 	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
+	.core_start = ath11k_ahb_core_start_wcn6750,
+	.core_stop = ath11k_ahb_core_stop_wcn6750,
 };
 
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 5cdac963444e..0e41a54c1bdb 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1392,7 +1392,6 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
 	ath11k_debugfs_soc_destroy(ab);
-	ath11k_dp_free(ab);
 	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
 }
@@ -1413,31 +1412,14 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 		goto err_pdev_debug;
 	}
 
-	ret = ath11k_mac_register(ab);
-	if (ret) {
-		ath11k_err(ab, "failed register the radio with mac80211: %d\n", ret);
-		goto err_dp_pdev_free;
-	}
-
-	ret = ath11k_thermal_register(ab);
-	if (ret) {
-		ath11k_err(ab, "could not register thermal device: %d\n",
-			   ret);
-		goto err_mac_unregister;
-	}
-
 	ret = ath11k_spectral_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init spectral %d\n", ret);
-		goto err_thermal_unregister;
+		goto err_dp_pdev_free;
 	}
 
 	return 0;
 
-err_thermal_unregister:
-	ath11k_thermal_unregister(ab);
-err_mac_unregister:
-	ath11k_mac_unregister(ab);
 err_dp_pdev_free:
 	ath11k_dp_pdev_free(ab);
 err_pdev_debug:
@@ -1448,11 +1430,8 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
-	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
-	ath11k_hif_irq_disable(ab);
-	ath11k_dp_pdev_free(ab);
 	ath11k_debugfs_pdev_destroy(ab);
 }
 
@@ -1584,26 +1563,20 @@ static int ath11k_core_start_firmware(struct ath11k_base *ab,
 	return ret;
 }
 
-int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
+static int ath11k_core_setup_resources(struct ath11k_base *ab)
 {
 	int ret;
 
-	ret = ath11k_core_start_firmware(ab, ATH11K_FIRMWARE_MODE_NORMAL);
-	if (ret) {
-		ath11k_err(ab, "failed to start firmware: %d\n", ret);
-		return ret;
-	}
-
 	ret = ath11k_ce_init_pipes(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to initialize CE: %d\n", ret);
-		goto err_firmware_stop;
+		return ret;
 	}
 
 	ret = ath11k_dp_alloc(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init DP: %d\n", ret);
-		goto err_firmware_stop;
+		return ret;
 	}
 
 	switch (ath11k_crypto_mode) {
@@ -1617,17 +1590,47 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
+
+	return ret;
+}
+
+static void ath11k_core_free_resources(struct ath11k_base *ab)
+{
+	ath11k_dp_free(ab);
+}
+
+static int ath11k_core_setup_device(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_core_start_firmware(ab, ATH11K_FIRMWARE_MODE_NORMAL);
+	if (ret) {
+		ath11k_err(ab, "failed to start firmware: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_core_setup_resources(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to setup resources: %d\n", ret);
+		goto err_firmware_stop;
+	}
+
 	mutex_lock(&ab->core_lock);
 	ret = ath11k_core_start(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to start core: %d\n", ret);
-		goto err_dp_free;
+		goto err_free_resources;
 	}
 
 	ret = ath11k_core_pdev_create(ab);
@@ -1635,7 +1638,10 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
 		goto err_core_stop;
 	}
+
 	ath11k_hif_irq_enable(ab);
+	ath11k_hif_core_stop(ab);
+
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -1643,8 +1649,8 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 err_core_stop:
 	ath11k_core_stop(ab);
 	ath11k_mac_destroy(ab);
-err_dp_free:
-	ath11k_dp_free(ab);
+err_free_resources:
+	ath11k_core_free_resources(ab);
 	mutex_unlock(&ab->core_lock);
 err_firmware_stop:
 	ath11k_qmi_firmware_stop(ab);
@@ -1652,10 +1658,43 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 	return ret;
 }
 
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
+	ret = ath11k_mac_register(ab);
+	if (ret) {
+		ath11k_err(ab, "failed register the radio with mac80211: %d\n", ret);
+		goto err_free_device;
+	}
+
+	ret = ath11k_thermal_register(ab);
+	if (ret) {
+		ath11k_err(ab, "could not register thermal device: %d\n",
+			   ret);
+		goto err_mac_unregister;
+	}
+
+	return 0;
+
+err_mac_unregister:
+	ath11k_mac_unregister(ab);
+err_free_device:
+	ath11k_core_stop_device(ab);
+	ath11k_mac_destroy(ab);
+
+	return ret;
+}
+
 static void ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 {
 	mutex_lock(&ab->core_lock);
-	ath11k_thermal_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_spectral_deinit(ab);
@@ -1930,7 +1969,6 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	mutex_lock(&ab->core_lock);
 
 	ath11k_core_pdev_destroy(ab);
-	ath11k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
 
@@ -1998,37 +2036,140 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
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
+	if (ab->core_stopped)
+		return;
+
+	ath11k_spectral_deinit(ab);
+	ath11k_core_suspend_target(ab, WMI_PDEV_SUSPEND_AND_DISABLE_INTR);
+	ath11k_hif_irq_disable(ab);
+	ath11k_dp_pdev_free(ab);
+	ath11k_hif_stop(ab);
+
+	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
+		ath11k_qmi_firmware_stop(ab);
+
+	ath11k_wmi_detach(ab);
+	ath11k_dp_pdev_reo_cleanup(ab);
+	ath11k_dp_free(ab);
+
+	ab->core_stopped = true;
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
+	ret = ath11k_core_start_firmware(ab, ATH11K_FIRMWARE_MODE_NORMAL);
 	if (ret) {
-		ath11k_err(ab, "failed to init core: %d\n", ret);
+		ath11k_err(ab, "failed to start firmware: %d\n", ret);
 		goto err_hal_srng_deinit;
 	}
 
+	ret = ath11k_core_setup_resources(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to setup resources: %d\n", ret);
+		goto err_firmware_stop;
+	}
+
+	ret = ath11k_core_start(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to start core: %d\n", ret);
+		goto err_free_resources;
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
+	ab->core_stopped = false;
 	return 0;
 
+err_core_stop:
+	ath11k_core_stop(ab);
+err_free_resources:
+	ath11k_core_free_resources(ab);
+err_firmware_stop:
+	ath11k_qmi_firmware_stop(ab);
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
index 582960deb27b..ef4ab36f84e2 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -973,6 +973,8 @@ struct ath11k_base {
 		const struct ath11k_pci_ops *ops;
 	} pci;
 
+	bool core_stopped;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -1168,6 +1170,8 @@ int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
 void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
 int ath11k_core_start_device(struct ath11k_base *ab);
+void ath11k_core_stop_device(struct ath11k_base *ab);
+int ath11k_core_any_pdevs_on(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index 659b80d2abd4..395b3dbf79b8 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -30,6 +30,8 @@ struct ath11k_hif_ops {
 	void (*ce_irq_enable)(struct ath11k_base *ab);
 	void (*ce_irq_disable)(struct ath11k_base *ab);
 	void (*get_ce_msi_idx)(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
+	int (*core_start)(struct ath11k_base *ab);
+	void (*core_stop)(struct ath11k_base *ab);
 };
 
 static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
@@ -145,4 +147,13 @@ static inline void ath11k_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
 		*msi_data_idx = ce_id;
 }
 
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
index 742fbac3d54f..a3929ce6cd0f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5819,9 +5819,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath11k_mac_drain_tx(ar);
 
-	ret = ath11k_core_start_device(ab);
+	ret = ath11k_hif_core_start(ab);
 	if (ret) {
-		ath11k_err(ab, "failed to start device : %d\n", ret);
+		ath11k_err(ab, "failed to start core : %d\n", ret);
 		return ret;
 	}
 
@@ -5982,6 +5982,10 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	synchronize_rcu();
 
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
+
+	/* If all PDEVs on the SoC are down, then power down the device */
+	if (!ath11k_core_any_pdevs_on(ar->ab))
+		ath11k_hif_core_stop(ar->ab);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 776362d151cb..c95e25cd4fa6 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -682,6 +682,30 @@ static int ath11k_pci_start(struct ath11k_base *ab)
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
@@ -700,6 +724,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+	.core_start = ath11k_pci_core_start,
+	.core_stop = ath11k_pci_core_stop,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
-- 
2.38.0

