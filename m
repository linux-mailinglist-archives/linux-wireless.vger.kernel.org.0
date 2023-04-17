Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13956E3F16
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 07:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDQFmV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 01:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQFmT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 01:42:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F523ABA
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 22:42:11 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H1nc68004029;
        Mon, 17 Apr 2023 05:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OW2erR0NUqXxoeZ1XRo3Jaym4q2PKSf4cC4TPe5BdnE=;
 b=lzQnAc1ZMo2tw4x+yAVIw5n6rwQC2Nxx1muQvMrxlnmhnXxAUChBZo4MOkv4hbn6vPyr
 GsnMwMYxH+fXx3YgyT4qkxNBT234O20NNwoWf6Te0kVyx8rIkVtMlvbSGZAFWLrkYiI+
 5tnbE19ROghzo0JEW1nnaYbVGAK2bmqv0u9Wst6YHkZ/n5KwGOAfrBFmqeVpbHGg3sDj
 1htaCT6x3nPRgdc8oS5fW40NCHgEx2gZhFd4BPEf1/tfvg+eTdJNFHSyyaSKU2+ws5kY
 vJGT1ZxulstHVVmhIXCXH0D+KuABgIR4t9J6+uNLO6opNSflQmj9g67saL+b9TCTIpAk VA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyn3tjjy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:42:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H5g7xc008868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:42:07 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 16 Apr 2023 22:42:05 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v5 3/3] wifi: ath11k: Enable low power mode when WLAN is not active on WCN6750
Date:   Mon, 17 Apr 2023 11:11:45 +0530
Message-ID: <20230417054145.12359-4-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230417054145.12359-1-quic_mpubbise@quicinc.com>
References: <20230417054145.12359-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jjsz8n9DZ16fgp9OvwML7f6XT56EkRy2
X-Proofpoint-ORIG-GUID: Jjsz8n9DZ16fgp9OvwML7f6XT56EkRy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170051
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Following command is used to suspend the device,
echo mem > /sys/power/state

On WCN6750, it has been verified that the power from the firmware is
completely turned off when the device is suspended.

Although the changes are specific to WCN6750, these changes act as a
framework and can be used to bring in the support on other ath11k
devices with a future patch.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  42 +++
 drivers/net/wireless/ath/ath11k/core.c | 426 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/core.h |   4 +
 drivers/net/wireless/ath/ath11k/hif.h  |  11 +
 drivers/net/wireless/ath/ath11k/mac.c  |   8 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  23 ++
 6 files changed, 392 insertions(+), 122 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 5cbba9a8b6ba..0b5708557d06 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -194,6 +194,44 @@ static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
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
+	 * during hardware recovery. Support to turn the hardware
+	 * ON/OFF during WLAN interface UP/DOWN or during
+	 * suspend/resume will be added later for IPQ8074.
+	 */
+	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
+		return 0;
+
+	return ath11k_core_start_device(ab);
+}
+
+static void ath11k_ahb_core_stop_ipq8074(struct ath11k_base *ab)
+{
+	/* TODO: Support to turn the hardware ON/OFF during WLAN
+	 * interface UP/DOWN or during suspend/resume will be
+	 * added later for IPQ8074.
+	 */
+}
+
 static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
 {
 	return ioread32(ab->mem + offset);
@@ -793,6 +831,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_ipq8074 = {
 	.map_service_to_pipe = ath11k_ahb_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.core_start = ath11k_ahb_core_start_ipq8074,
+	.core_stop = ath11k_ahb_core_stop_ipq8074,
 };
 
 static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
@@ -812,6 +852,8 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
 	.resume = ath11k_ahb_hif_resume,
 	.ce_irq_enable = ath11k_pci_enable_ce_irqs_except_wake_irq,
 	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
+	.core_start = ath11k_ahb_core_start_wcn6750,
+	.core_stop = ath11k_ahb_core_stop_wcn6750,
 };
 
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 707ccff8b7f6..9ec7529650cc 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1405,33 +1405,8 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
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
-	ret = ath11k_spectral_init(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to init spectral %d\n", ret);
-		goto err_thermal_unregister;
-	}
-
 	return 0;
 
-err_thermal_unregister:
-	ath11k_thermal_unregister(ab);
-err_mac_unregister:
-	ath11k_mac_unregister(ab);
-err_dp_pdev_free:
-	ath11k_dp_pdev_free(ab);
 err_pdev_debug:
 	ath11k_debugfs_pdev_destroy(ab);
 
@@ -1440,9 +1415,6 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
-	ath11k_spectral_deinit(ab);
-	ath11k_thermal_unregister(ab);
-	ath11k_mac_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_debugfs_pdev_destroy(ab);
@@ -1559,95 +1531,9 @@ static int ath11k_core_start(struct ath11k_base *ab)
 	return ret;
 }
 
-static int ath11k_core_start_firmware(struct ath11k_base *ab,
-				      enum ath11k_firmware_mode mode)
-{
-	int ret;
-
-	ath11k_ce_get_shadow_config(ab, &ab->qmi.ce_cfg.shadow_reg_v2,
-				    &ab->qmi.ce_cfg.shadow_reg_v2_len);
-
-	ret = ath11k_qmi_firmware_start(ab, mode);
-	if (ret) {
-		ath11k_err(ab, "failed to send firmware start: %d\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
-int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
-{
-	int ret;
-
-	ret = ath11k_core_start_firmware(ab, ATH11K_FIRMWARE_MODE_NORMAL);
-	if (ret) {
-		ath11k_err(ab, "failed to start firmware: %d\n", ret);
-		return ret;
-	}
-
-	ret = ath11k_ce_init_pipes(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to initialize CE: %d\n", ret);
-		goto err_firmware_stop;
-	}
-
-	ret = ath11k_dp_alloc(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to init DP: %d\n", ret);
-		goto err_firmware_stop;
-	}
-
-	switch (ath11k_crypto_mode) {
-	case ATH11K_CRYPT_MODE_SW:
-		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
-		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
-		break;
-	case ATH11K_CRYPT_MODE_HW:
-		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
-		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
-		break;
-	default:
-		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
-		return -EINVAL;
-	}
-
-	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
-		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
-
-	mutex_lock(&ab->core_lock);
-	ret = ath11k_core_start(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to start core: %d\n", ret);
-		goto err_dp_free;
-	}
-
-	ret = ath11k_core_pdev_create(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
-		goto err_core_stop;
-	}
-	ath11k_hif_irq_enable(ab);
-	mutex_unlock(&ab->core_lock);
-
-	return 0;
-
-err_core_stop:
-	ath11k_core_stop(ab);
-	ath11k_mac_destroy(ab);
-err_dp_free:
-	ath11k_dp_free(ab);
-	mutex_unlock(&ab->core_lock);
-err_firmware_stop:
-	ath11k_qmi_firmware_stop(ab);
-
-	return ret;
-}
-
 static void ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 {
 	mutex_lock(&ab->core_lock);
-	ath11k_thermal_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_spectral_deinit(ab);
@@ -1865,6 +1751,191 @@ static void ath11k_core_reset(struct work_struct *work)
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
 }
 
+static int ath11k_core_register(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_mac_register(ab);
+	if (ret) {
+		ath11k_err(ab, "failed register the radio with mac80211: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_thermal_register(ab);
+	if (ret) {
+		ath11k_err(ab, "could not register thermal device: %d\n",
+			   ret);
+		goto err_mac_unregister;
+	}
+
+	mutex_lock(&ab->core_lock);
+
+	ret = ath11k_spectral_init(ab);
+	if (ret) {
+		mutex_unlock(&ab->core_lock);
+		ath11k_err(ab, "failed to init spectral %d\n", ret);
+		goto err_thermal_unregister;
+	}
+
+	mutex_unlock(&ab->core_lock);
+
+	return 0;
+
+err_thermal_unregister:
+	ath11k_thermal_unregister(ab);
+err_mac_unregister:
+	ath11k_mac_unregister(ab);
+
+	return ret;
+}
+
+static void ath11k_core_unregister(struct ath11k_base *ab)
+{
+	mutex_lock(&ab->core_lock);
+	ath11k_spectral_deinit(ab);
+	mutex_unlock(&ab->core_lock);
+
+	ath11k_thermal_unregister(ab);
+	ath11k_mac_unregister(ab);
+}
+
+static int ath11k_core_setup_resources(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_ce_init_pipes(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to initialize CE: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_dp_alloc(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init DP: %d\n", ret);
+		return ret;
+	}
+
+	switch (ath11k_crypto_mode) {
+	case ATH11K_CRYPT_MODE_SW:
+		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	case ATH11K_CRYPT_MODE_HW:
+		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	default:
+		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
+		ret = -EINVAL;
+		goto err_dp_free;
+	}
+
+	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
+		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+
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
+static int ath11k_core_start_firmware(struct ath11k_base *ab,
+				      enum ath11k_firmware_mode mode)
+{
+	int ret;
+
+	ath11k_ce_get_shadow_config(ab, &ab->qmi.ce_cfg.shadow_reg_v2,
+				    &ab->qmi.ce_cfg.shadow_reg_v2_len);
+
+	ret = ath11k_qmi_firmware_start(ab, mode);
+	if (ret) {
+		ath11k_err(ab, "failed to send firmware start: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
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
+	mutex_lock(&ab->core_lock);
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
+	ath11k_hif_core_stop(ab);
+
+	mutex_unlock(&ab->core_lock);
+
+	return 0;
+
+err_core_stop:
+	ath11k_core_stop(ab);
+	ath11k_mac_destroy(ab);
+err_free_resources:
+	ath11k_core_free_resources(ab);
+	mutex_unlock(&ab->core_lock);
+err_firmware_stop:
+	ath11k_qmi_firmware_stop(ab);
+
+	return ret;
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
+	ret = ath11k_core_register(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to register core: %d\n", ret);
+		goto err_free_device;
+	}
+
+	return 0;
+
+err_free_device:
+	ath11k_core_stop_device(ab);
+	ath11k_mac_destroy(ab);
+
+	return ret;
+}
+
 static int ath11k_init_hw_params(struct ath11k_base *ab)
 {
 	const struct ath11k_hw_params *hw_params = NULL;
@@ -1919,10 +1990,13 @@ EXPORT_SYMBOL(ath11k_core_init);
 
 void ath11k_core_deinit(struct ath11k_base *ab)
 {
+	ath11k_core_unregister(ab);
+
 	mutex_lock(&ab->core_lock);
 
 	ath11k_core_pdev_destroy(ab);
-	ath11k_core_stop(ab);
+	if (!ab->core_stopped)
+		ath11k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
 
@@ -1990,37 +2064,149 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
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
+
+	ret = ath11k_spectral_init(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init spectral %d\n", ret);
+		goto err_pdev_destroy;
+	}
+
 	clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
 
+	mutex_unlock(&ab->core_lock);
+
+	ab->core_stopped = false;
 	return 0;
 
+err_pdev_destroy:
+	ath11k_core_pdev_destroy(ab);
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
index 8d6d54cd4c35..1558703913a1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6005,9 +6005,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath11k_mac_drain_tx(ar);
 
-	ret = ath11k_core_start_device(ab);
+	ret = ath11k_hif_core_start(ab);
 	if (ret) {
-		ath11k_err(ab, "failed to start device : %d\n", ret);
+		ath11k_err(ab, "failed to start core : %d\n", ret);
 		return ret;
 	}
 
@@ -6168,6 +6168,10 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	synchronize_rcu();
 
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
+
+	/* If all PDEVs on the SoC are down, then power down the device */
+	if (!ath11k_core_any_pdevs_on(ar->ab))
+		ath11k_hif_core_stop(ar->ab);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 522d01e5e11c..d138040a62e7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -679,6 +679,27 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_pci_core_start(struct ath11k_base *ab)
+{
+	/* TODO: Currently initializing the hardware/firmware only
+	 * during hardware recovery. Support to turn the hardware
+	 * ON/OFF during WLAN interface UP/DOWN or during
+	 * suspend/resume will be added later.
+	 */
+	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
+		return 0;
+
+	return ath11k_core_start_device(ab);
+}
+
+static void ath11k_pci_core_stop(struct ath11k_base *ab)
+{
+	/* TODO: Support to turn the hardware ON/OFF during WLAN
+	 * interface UP/DOWN or during suspend/resume will be
+	 * added later.
+	 */
+}
+
 static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.start = ath11k_pci_start,
 	.stop = ath11k_pcic_stop,
@@ -697,6 +718,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+	.core_start = ath11k_pci_core_start,
+	.core_stop = ath11k_pci_core_stop,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
-- 
2.17.1

