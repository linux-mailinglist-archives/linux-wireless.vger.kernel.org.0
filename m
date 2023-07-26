Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C60763894
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjGZOMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjGZOLs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9B46B1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:11:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QCYY9D019843;
        Wed, 26 Jul 2023 14:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7/jNWXuc8GWD9NXfCV41vK+CR3OfSrJlggdVC3YKEhI=;
 b=en5c6ycWp2UY+pRcVnllKkKjDaIPcMBQXgA3Ys0yZkYhrhFxquTmVSj4EBEsDIJKyw3Y
 6X9vxD3SSN1AV1WIt6EqkI9IK8tOjfOa1OXt1IfKcJFbNltf007ZrzRXK0WGTnL24Ta4
 BWl0Q11inmCocS0afS1kcRVEGrE19v3LPWLx+3VTF7dtKXFy1M/tshyooST5XNH+pVnK
 YRbF+zvE2wpTBu+IQ22c2ZpKDFXxEDyHEYLbGmZsZcBjdGJ55VJKVNPYKKBpOex3GKw8
 /qO/miKCwO/NUwoI2NxIAE9Rddr7RbIsnSApdIB53pNyMQyhm+UMYMzzoqa7SUfk/Ph8 xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2mxrhvbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QEAtPT009941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:55 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 07:10:52 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 1/3] wifi: ath11k: Split coldboot calibration hw_param
Date:   Wed, 26 Jul 2023 19:40:30 +0530
Message-ID: <20230726141032.3061-2-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: wtgGsOfW_jYRDp33ZDbyU5GUOY2ItzBu
X-Proofpoint-ORIG-GUID: wtgGsOfW_jYRDp33ZDbyU5GUOY2ItzBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>

QCN9074 enables coldboot calibration only in Factory Test Mode (FTM).
Hence, split cold_boot_calib to two hw_params for mission and FTM
mode.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  3 +--
 drivers/net/wireless/ath/ath11k/core.c | 36 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  3 ++-
 drivers/net/wireless/ath/ath11k/qmi.c  |  6 ++---
 5 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 1cebba788..56aea2bc9 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -423,8 +423,7 @@ static int ath11k_ahb_fwreset_from_cold_boot(struct ath11k_base *ab)
 {
 	int timeout;
 
-	if (ath11k_cold_boot_cal == 0 || ab->qmi.cal_done ||
-	    ab->hw_params.cold_boot_calib == 0 ||
+	if (!ath11k_core_coldboot_cal_support(ab) || ab->qmi.cal_done ||
 	    ab->hw_params.cbcal_restart_fw == 0)
 		return 0;
 
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index bebfd342e..d5bf2896d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -86,7 +86,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.supports_sta_ps = false,
-		.cold_boot_calib = true,
+		.coldboot_cal_mm = true,
+		.coldboot_cal_ftm = true,
 		.cbcal_restart_fw = true,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
@@ -167,7 +168,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.supports_sta_ps = false,
-		.cold_boot_calib = true,
+		.coldboot_cal_mm = true,
+		.coldboot_cal_ftm = true,
 		.cbcal_restart_fw = true,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
@@ -248,7 +250,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.supports_sta_ps = true,
-		.cold_boot_calib = false,
+		.coldboot_cal_mm = false,
+		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
@@ -332,7 +335,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.supports_sta_ps = false,
-		.cold_boot_calib = false,
+		.coldboot_cal_mm = false,
+		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 2,
 		.num_vdevs = 8,
@@ -413,7 +417,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.supports_sta_ps = true,
-		.cold_boot_calib = false,
+		.coldboot_cal_mm = false,
+		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
@@ -495,7 +500,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.supports_sta_ps = true,
-		.cold_boot_calib = false,
+		.coldboot_cal_mm = false,
+		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
@@ -578,7 +584,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.supports_sta_ps = true,
-		.cold_boot_calib = true,
+		.coldboot_cal_mm = true,
+		.coldboot_cal_ftm = true,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
@@ -667,7 +674,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.single_pdev_only = false,
-		.cold_boot_calib = true,
+		.coldboot_cal_mm = true,
+		.coldboot_cal_ftm = true,
 		.cbcal_restart_fw = true,
 		.fix_l1ss = true,
 		.supports_dynamic_smps_6ghz = false,
@@ -749,6 +757,18 @@ void ath11k_fw_stats_free(struct ath11k_fw_stats *stats)
 	ath11k_fw_stats_bcn_free(&stats->bcn);
 }
 
+bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab)
+{
+	if (!ath11k_cold_boot_cal)
+		return false;
+
+	if (ath11k_ftm_mode)
+		return ab->hw_params.coldboot_cal_ftm;
+
+	else
+		return ab->hw_params.coldboot_cal_mm;
+}
+
 int ath11k_core_suspend(struct ath11k_base *ab)
 {
 	int ret;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9d15b4390..b04447762 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1186,6 +1186,7 @@ void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
 void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
+bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f5533630a..d51a99669 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -187,7 +187,8 @@ struct ath11k_hw_params {
 	bool supports_shadow_regs;
 	bool idle_ps;
 	bool supports_sta_ps;
-	bool cold_boot_calib;
+	bool coldboot_cal_mm;
+	bool coldboot_cal_ftm;
 	bool cbcal_restart_fw;
 	int fw_mem_mode;
 	u32 num_vdevs;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d4eaf7d2b..91a214caa 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2079,7 +2079,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 				return -EINVAL;
 			}
 
-			if (ath11k_cold_boot_cal && ab->hw_params.cold_boot_calib) {
+			if (ath11k_core_coldboot_cal_support(ab)) {
 				if (hremote_node) {
 					ab->qmi.target_mem[idx].paddr =
 							res.start + host_ddr_sz;
@@ -3209,8 +3209,8 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 				break;
 			}
 
-			if (ath11k_cold_boot_cal && ab->qmi.cal_done == 0 &&
-			    ab->hw_params.cold_boot_calib) {
+			if (ab->qmi.cal_done == 0 &&
+			    ath11k_core_coldboot_cal_support(ab)) {
 				ath11k_qmi_process_coldboot_calibration(ab);
 			} else {
 				clear_bit(ATH11K_FLAG_CRASH_FLUSH,
-- 
2.17.1

