Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF11763897
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjGZOMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 10:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjGZOLs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009E2D40
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:11:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QDGgg1005271;
        Wed, 26 Jul 2023 14:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=CzFmdiRwEj5/Dg4zB4V9253Bz7Qb1UA0+vnHFNwn7B4=;
 b=KGfWJs0pGZPatMc9f0uPiPSlxQFSmVyw3ysb9wOba6/8llP05lj/RBmXMfqyGFO6tU8f
 EwOgEFIlfzzfsnb+HrCFJ6wRJizI6INXySftVqmw14Mnuqh5qngVlZMNHQkVYx5emBAO
 C1n8PtOnO6s8hrvcLmHiRkstLtdUxW34VVIaAu6p+zaItxqBO0jrQdRSyF6+lk0dMUt7
 ze25Fdf5j6vUHFbk1IhdxJmepbH6P/S2vDVrLX9Lnlu3ZZui589G8I0tEpehF8T1T9zm
 Q07shNyF7yptfCufuke4mwqxN7pwmfE0hY/1hoYpDHUZAxFl1oXjRtnPeD45HFL8qldu yw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1tf1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QEAutH005936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:56 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 07:10:54 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 2/3] wifi: ath11k: Add coldboot calibration support for QCN9074
Date:   Wed, 26 Jul 2023 19:40:31 +0530
Message-ID: <20230726141032.3061-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230726141032.3061-1-quic_rajkbhag@quicinc.com>
References: <20230726141032.3061-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hi0LAP1N7aDJ6uyv7PJIt5O5vLt1QaPB
X-Proofpoint-ORIG-GUID: hi0LAP1N7aDJ6uyv7PJIt5O5vLt1QaPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <quic_akolli@quicinc.com>

QCN9074 supports 6 GHz, which has increased number of channels
compared to 5 GHz/2 GHz. So, to support coldboot calibration in
QCN9074 ATH11K_COLD_BOOT_FW_RESET_DELAY extended to 60 seconds. To
avoid code redundancy, fwreset_from_cold_boot moved to QMI and made
common for both ahb and pci. Coldboot calibration is enabled only in
FTM mode for QCN9074. QCN9074 requires firmware restart after coldboot,
hence enable cbcal_restart_fw in hw_params.

This support can be enabled/disabled using hw params for different
hardware. Currently it is not enabled for QCA6390.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 28 ++------------------------
 drivers/net/wireless/ath/ath11k/core.c |  4 ++--
 drivers/net/wireless/ath/ath11k/pci.c  |  2 ++
 drivers/net/wireless/ath/ath11k/qmi.c  | 28 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.h  |  3 ++-
 5 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 56aea2bc9..b0a40970b 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -14,6 +14,7 @@
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
+#include "qmi.h"
 #include <linux/remoteproc.h>
 #include "pcic.h"
 #include <linux/soc/qcom/smem.h>
@@ -419,31 +420,6 @@ static void ath11k_ahb_power_down(struct ath11k_base *ab)
 	rproc_shutdown(ab_ahb->tgt_rproc);
 }
 
-static int ath11k_ahb_fwreset_from_cold_boot(struct ath11k_base *ab)
-{
-	int timeout;
-
-	if (!ath11k_core_coldboot_cal_support(ab) || ab->qmi.cal_done ||
-	    ab->hw_params.cbcal_restart_fw == 0)
-		return 0;
-
-	ath11k_dbg(ab, ATH11K_DBG_AHB, "wait for cold boot done\n");
-	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
-				     (ab->qmi.cal_done  == 1),
-				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
-	if (timeout <= 0) {
-		ath11k_cold_boot_cal = 0;
-		ath11k_warn(ab, "Coldboot Calibration failed timed out\n");
-	}
-
-	/* reset the firmware */
-	ath11k_ahb_power_down(ab);
-	ath11k_ahb_power_up(ab);
-
-	ath11k_dbg(ab, ATH11K_DBG_AHB, "exited from cold boot mode\n");
-	return 0;
-}
-
 static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 {
 	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
@@ -1226,7 +1202,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		goto err_ce_free;
 	}
 
-	ath11k_ahb_fwreset_from_cold_boot(ab);
+	ath11k_qmi_fwreset_from_cold_boot(ab);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index d5bf2896d..fc7c4564a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -336,8 +336,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.supports_sta_ps = false,
 		.coldboot_cal_mm = false,
-		.coldboot_cal_ftm = false,
-		.cbcal_restart_fw = false,
+		.coldboot_cal_ftm = true,
+		.cbcal_restart_fw = true,
 		.fw_mem_mode = 2,
 		.num_vdevs = 8,
 		.num_peers = 128,
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 79e2cbe82..5fd08ffc2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -15,6 +15,7 @@
 #include "mhi.h"
 #include "debug.h"
 #include "pcic.h"
+#include "qmi.h"
 
 #define ATH11K_PCI_BAR_NUM		0
 #define ATH11K_PCI_DMA_MASK		32
@@ -897,6 +898,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ath11k_err(ab, "failed to init core: %d\n", ret);
 		goto err_irq_affinity_cleanup;
 	}
+	ath11k_qmi_fwreset_from_cold_boot(ab);
 	return 0;
 
 err_irq_affinity_cleanup:
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 91a214caa..c4eab5d7f 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -9,6 +9,7 @@
 #include "qmi.h"
 #include "core.h"
 #include "debug.h"
+#include "hif.h"
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/ioport.h>
@@ -2839,6 +2840,33 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 	return 0;
 }
 
+int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
+{
+	int timeout;
+
+	if (!ath11k_core_coldboot_cal_support(ab) || ab->qmi.cal_done ||
+	    ab->hw_params.cbcal_restart_fw == 0)
+		return 0;
+
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "wait for cold boot done\n");
+
+	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
+				     (ab->qmi.cal_done == 1),
+				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
+
+	if (timeout <= 0) {
+		ath11k_warn(ab, "Coldboot Calibration timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	/* reset the firmware */
+	ath11k_hif_power_down(ab);
+	ath11k_hif_power_up(ab);
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "exit wait for cold boot done\n");
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_qmi_fwreset_from_cold_boot);
+
 static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
 {
 	int timeout;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 0909d53ce..b0407abf9 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -37,7 +37,7 @@
 
 #define QMI_WLANFW_MAX_DATA_SIZE_V01		6144
 #define ATH11K_FIRMWARE_MODE_OFF		4
-#define ATH11K_COLD_BOOT_FW_RESET_DELAY		(40 * HZ)
+#define ATH11K_COLD_BOOT_FW_RESET_DELAY		(60 * HZ)
 
 #define ATH11K_QMI_DEVICE_BAR_SIZE		0x200000
 
@@ -519,5 +519,6 @@ void ath11k_qmi_msg_recv_work(struct work_struct *work);
 void ath11k_qmi_deinit_service(struct ath11k_base *ab);
 int ath11k_qmi_init_service(struct ath11k_base *ab);
 void ath11k_qmi_free_resource(struct ath11k_base *ab);
+int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab);
 
 #endif
-- 
2.17.1

