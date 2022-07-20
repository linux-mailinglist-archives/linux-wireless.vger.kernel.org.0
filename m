Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC157B7E2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbiGTNtf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiGTNte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:49:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EACD5F109
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:49:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KD2WBu019121;
        Wed, 20 Jul 2022 13:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=eJP7+iTCMkpcBsikZQkuC6bp2/Mrd5pIz9O9gy15QZs=;
 b=NlFv7HdTooLwqwX/OcqvPBZCysE9oBYq4uXeUXy5g/xjdV4S7YTcubBrm+zKiFj5kglK
 Vu6+oDsNYkn0NZHKeDcCq2C5BkYzFGhLaSB3Z8Z6Q88jNOQL+fcLMRk7bHFlbpRO6+I+
 nRTEmiCEQExzyWelvV1HiqxyJF2SoIcLdzmgJWXYFK34LaUmSIZw+Y8+jPZBs5/MPJew
 7GhWHClu3HV9G1S6ieFcdUHzfEomIXjA25zneNkND3xM2aqzdJ8TkDIovRv2qUg+xSZd
 o5WCiK9/rzvoKejD7Lye9o3zNSekpVB/b1wAbQ0t+Y0Qg3hgUBHe9Sx617a9qjU8ylCo Sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hebfv15sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:49:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KDnSLm031056
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:49:28 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:49:27 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:49:26 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 1/2] ath11k: Fix incorrect QMI message ID mappings
Date:   Wed, 20 Jul 2022 19:19:08 +0530
Message-ID: <20220720134909.15626-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720134909.15626-1-quic_mpubbise@quicinc.com>
References: <20220720134909.15626-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h-_DJvES4WObil3TEtMUJozBAUvaaRem
X-Proofpoint-ORIG-GUID: h-_DJvES4WObil3TEtMUJozBAUvaaRem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_08,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=892
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0
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

QMI message IDs for some of the QMI messages were incorrectly
defined in the original implementation. These have to be corrected
to enable cold boot support on WCN6750. These corrections are
applicable for all chipsets and will not impact them. Refactor the
code accordingly.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 38 ++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/qmi.h | 10 +++++--
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 00136601cb7d..e6ced8597e1d 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1696,6 +1696,13 @@ static struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
 	},
 };
 
+static struct qmi_elem_info qmi_wlfw_fw_init_done_ind_msg_v01_ei[] = {
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+	},
+};
+
 static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_host_cap_req_msg_v01 req;
@@ -3006,6 +3013,10 @@ static void ath11k_qmi_msg_fw_ready_cb(struct qmi_handle *qmi_hdl,
 	struct ath11k_base *ab = qmi->ab;
 
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware ready\n");
+
+	ab->qmi.cal_done = 1;
+	wake_up(&ab->qmi.cold_boot_waitq);
+
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_FW_READY, NULL);
 }
 
@@ -3018,11 +3029,22 @@ static void ath11k_qmi_msg_cold_boot_cal_done_cb(struct qmi_handle *qmi_hdl,
 					      struct ath11k_qmi, handle);
 	struct ath11k_base *ab = qmi->ab;
 
-	ab->qmi.cal_done = 1;
-	wake_up(&ab->qmi.cold_boot_waitq);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi cold boot calibration done\n");
 }
 
+static void ath11k_qmi_msg_fw_init_done_cb(struct qmi_handle *qmi_hdl,
+					   struct sockaddr_qrtr *sq,
+					   struct qmi_txn *txn,
+					   const void *decoded)
+{
+	struct ath11k_qmi *qmi = container_of(qmi_hdl,
+					      struct ath11k_qmi, handle);
+	struct ath11k_base *ab = qmi->ab;
+
+	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_FW_INIT_DONE, NULL);
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware init done\n");
+}
+
 static const struct qmi_msg_handler ath11k_qmi_msg_handlers[] = {
 	{
 		.type = QMI_INDICATION,
@@ -3053,6 +3075,14 @@ static const struct qmi_msg_handler ath11k_qmi_msg_handlers[] = {
 			sizeof(struct qmi_wlanfw_fw_cold_cal_done_ind_msg_v01),
 		.fn = ath11k_qmi_msg_cold_boot_cal_done_cb,
 	},
+	{
+		.type = QMI_INDICATION,
+		.msg_id = QMI_WLFW_FW_INIT_DONE_IND_V01,
+		.ei = qmi_wlfw_fw_init_done_ind_msg_v01_ei,
+		.decoded_size =
+			sizeof(struct qmi_wlfw_fw_init_done_ind_msg_v01),
+		.fn = ath11k_qmi_msg_fw_init_done_cb,
+	},
 };
 
 static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
@@ -3145,7 +3175,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			}
 
 			break;
-		case ATH11K_QMI_EVENT_FW_READY:
+		case ATH11K_QMI_EVENT_FW_INIT_DONE:
 			clear_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
 			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
 				ath11k_hal_dump_srng_stats(ab);
@@ -3168,6 +3198,8 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 				set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
 			}
 
+			break;
+		case ATH11K_QMI_EVENT_FW_READY:
 			break;
 		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
 			break;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index c83cf822be81..2ec56a34fa81 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -31,8 +31,9 @@
 
 #define QMI_WLFW_REQUEST_MEM_IND_V01		0x0035
 #define QMI_WLFW_FW_MEM_READY_IND_V01		0x0037
-#define QMI_WLFW_COLD_BOOT_CAL_DONE_IND_V01	0x0021
-#define QMI_WLFW_FW_READY_IND_V01		0x0038
+#define QMI_WLFW_COLD_BOOT_CAL_DONE_IND_V01	0x003E
+#define QMI_WLFW_FW_READY_IND_V01		0x0021
+#define QMI_WLFW_FW_INIT_DONE_IND_V01		0x0038
 
 #define QMI_WLANFW_MAX_DATA_SIZE_V01		6144
 #define ATH11K_FIRMWARE_MODE_OFF		4
@@ -69,6 +70,7 @@ enum ath11k_qmi_event_type {
 	ATH11K_QMI_EVENT_FORCE_FW_ASSERT,
 	ATH11K_QMI_EVENT_POWER_UP,
 	ATH11K_QMI_EVENT_POWER_DOWN,
+	ATH11K_QMI_EVENT_FW_INIT_DONE,
 	ATH11K_QMI_EVENT_MAX,
 };
 
@@ -291,6 +293,10 @@ struct qmi_wlanfw_fw_cold_cal_done_ind_msg_v01 {
 	char placeholder;
 };
 
+struct qmi_wlfw_fw_init_done_ind_msg_v01 {
+	char placeholder;
+};
+
 #define QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN		0
 #define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN		235
 #define QMI_WLANFW_CAP_REQ_V01				0x0024
-- 
2.35.1

