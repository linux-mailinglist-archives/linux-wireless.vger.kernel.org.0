Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2D631F06
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 12:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKULEg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 06:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKULEc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 06:04:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2EA2E9E3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 03:04:30 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL8PS9Q021302;
        Mon, 21 Nov 2022 11:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=3C6DFFQwcmVH7U/BKDUXzl7W96eE+xnicwWoEZMsLxc=;
 b=ef1m+4mhPrBf+HTRJsM6514p24/SkxrNxllT873F1w69pxiXVDcjJWxqyVJUXtStTifo
 77Bo0+GTzhrXxgwD/izUhrHXEvDBOUtsyKUcxo0S28i2ClwCJ9htwJrU4BMwVOIE7uUa
 JeEF5S909aZ5P8e6Uj6o7qGPoT4fICDnM7YIfuG/YSjOE3mdYv/NUN0MoUDUIh4VKqqB
 ISUTL2z+v17xvQ8/2tJU4V6HSG4yqH75DajhtAnNRpamKzOrKwRAmnOMYalcPD8uUAKV
 A8QZ4LOxQrSZOXe5dUSyQ62aowCB7Nxz4LBQDnbmm23/XQmn22e9lusVyKfcexU7IGR8 BA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrfbv9fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALB4R74023605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:27 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 03:04:25 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 3/3] ath11k: Enable low power mode when WLAN is not active
Date:   Mon, 21 Nov 2022 16:33:59 +0530
Message-ID: <20221121110359.4652-4-quic_mpubbise@quicinc.com>
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
X-Proofpoint-GUID: 2yqEDBOHJydCqes_y7YyMbm5abZMs1r7
X-Proofpoint-ORIG-GUID: 2yqEDBOHJydCqes_y7YyMbm5abZMs1r7
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
index d34a4d6325b2..5fe375014ecb 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -191,6 +191,47 @@ static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
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
@@ -778,6 +819,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_ipq8074 = {
 	.map_service_to_pipe = ath11k_ahb_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.core_start = ath11k_ahb_core_start_ipq8074,
+	.core_stop = ath11k_ahb_core_stop_ipq8074,
 };
 
 static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
@@ -797,6 +840,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
 	.resume = ath11k_ahb_hif_resume,
 	.ce_irq_enable = ath11k_pci_enable_ce_irqs_except_wake_irq,
 	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
+	.core_start = ath11k_ahb_core_start_wcn6750,
+	.core_stop = ath11k_ahb_core_stop_wcn6750,
 };
 
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index d36e193b2db9..f64bf42048a3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1299,7 +1299,6 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
 	ath11k_debugfs_soc_destroy(ab);
-	ath11k_dp_free(ab);
 	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
 }
@@ -1320,31 +1319,14 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
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
@@ -1355,11 +1337,8 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
-	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
-	ath11k_hif_irq_disable(ab);
-	ath11k_dp_pdev_free(ab);
 	ath11k_debugfs_pdev_destroy(ab);
 }
 
@@ -1491,26 +1470,20 @@ static int ath11k_core_start_firmware(struct ath11k_base *ab,
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
@@ -1524,17 +1497,47 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1542,7 +1545,10 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
 		goto err_core_stop;
 	}
+
 	ath11k_hif_irq_enable(ab);
+	ath11k_hif_core_stop(ab);
+
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -1550,8 +1556,8 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1559,10 +1565,43 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1837,7 +1876,6 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	mutex_lock(&ab->core_lock);
 
 	ath11k_core_pdev_destroy(ab);
-	ath11k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
 
@@ -1905,37 +1943,140 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
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
+	ath11k_hif_stop(ab);
+
+	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
+		ath11k_qmi_firmware_stop(ab);
+
+	ath11k_wmi_detach(ab);
+	ath11k_dp_pdev_reo_cleanup(ab);
+	ath11k_dp_pdev_free(ab);
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
index 9b55ac94b36c..338f6f71baa0 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -964,6 +964,8 @@ struct ath11k_base {
 		const struct ath11k_pci_ops *ops;
 	} pci;
 
+	bool core_stopped;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -1156,6 +1158,8 @@ int ath11k_core_resume(struct ath11k_base *ab);
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
index c21ebf0578dc..31b794ea52ad 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5797,9 +5797,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath11k_mac_drain_tx(ar);
 
-	ret = ath11k_core_start_device(ab);
+	ret = ath11k_hif_core_start(ab);
 	if (ret) {
-		ath11k_err(ab, "failed to start device : %d\n", ret);
+		ath11k_err(ab, "failed to start core : %d\n", ret);
 		return ret;
 	}
 
@@ -5960,6 +5960,10 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	synchronize_rcu();
 
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
+
+	/* If all PDEVs on the SoC are down, then power down the device */
+	if (!ath11k_core_any_pdevs_on(ar->ab))
+		ath11k_hif_core_stop(ar->ab);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 99cf3357c66e..be350ed671b7 100644
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
@@ -698,6 +722,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+	.core_start = ath11k_pci_core_start,
+	.core_stop = ath11k_pci_core_stop,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
-- 
2.38.0

