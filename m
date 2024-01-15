Return-Path: <linux-wireless+bounces-1901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAE282D322
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441951F20F07
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA41842;
	Mon, 15 Jan 2024 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="apyyJhBR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB071841
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40F2Z89D030313;
	Mon, 15 Jan 2024 02:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=NcD9Q2V
	jbIEF7ScjFJ7rLFvw2qKQQu/jPeE56YndeZI=; b=apyyJhBRuSLWknHnzdroUpH
	tNk367vkSXrt+TKXrjGUrqPunwWIAiIKK87YAJoDsylCHpJ4Gdf+qJbHYDkfZVci
	UxFMJ0Adyv3990pH5FBj5BPGAiRZl62fY51cJjaXvA/vowVrbVH0FAU7iCOq78Qy
	rQOCzYHFsusjql+golZ652GIK3XG5UxGuBPYD0p2GykiB4wqzdgPP3JX0tY7HdJJ
	ZRPT94VilkwVyhb8tSUUHv1X7A8nyVAa19Jbs90hw7KwE7c4CZAWsbJ96tubPeR2
	1QApuFEBe5X+r8wi5XXTO8sb1tNiIHw0R+lJvBrFh69vCiqJVg7TZCvYBU9F71w=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmkcjf7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 02:37:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40F2bbEs003596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 02:37:37 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 14 Jan 2024 18:37:35 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: add support for collecting firmware log
Date: Mon, 15 Jan 2024 10:37:26 +0800
Message-ID: <20240115023726.2866-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z8shJz1jytAOGTPnuYfs3rt7fEO1pwyH
X-Proofpoint-ORIG-GUID: Z8shJz1jytAOGTPnuYfs3rt7fEO1pwyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150019

Currently there is no way to collect firmware log because firmware
does not send it to host. Also host does not handle WMI_DIAG_EVENTID
which is used by firmware to upload firmware log.

So add support for it by firstly enabling firmware log upload via a
QMI message, and secondly processing WMI DIAG event to expose it to
userspace via trace event.

This change applies to both WCN7850 and QCN9274.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c   | 93 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/qmi.h   | 17 ++++-
 drivers/net/wireless/ath/ath12k/trace.h | 29 +++++++-
 drivers/net/wireless/ath/ath12k/wmi.c   | 11 ++-
 4 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index c4c7f31a91cd..7f4c92540b20 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1893,6 +1893,50 @@ static const struct qmi_elem_info qmi_wlanfw_fw_ready_ind_msg_v01_ei[] = {
 	},
 };
 
+static const struct qmi_elem_info qmi_wlanfw_wlan_ini_req_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_wlan_ini_req_msg_v01,
+					   enablefwlog_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_wlan_ini_req_msg_v01,
+					   enablefwlog),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static const struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_wlanfw_wlan_ini_resp_msg_v01,
+					   resp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
 static void ath12k_host_cap_parse_mlo(struct qmi_wlanfw_host_cap_req_msg_v01 *req)
 {
 	req->mlo_capable_valid = 1;
@@ -2721,6 +2765,49 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	return ret;
 }
 
+static int ath12k_qmi_wlanfw_wlan_ini_send(struct ath12k_base *ab, bool enable)
+{
+	int ret;
+	struct qmi_txn txn;
+	struct qmi_wlanfw_wlan_ini_req_msg_v01 req = {};
+	struct qmi_wlanfw_wlan_ini_resp_msg_v01 resp = {};
+
+	req.enablefwlog_valid = true;
+	req.enablefwlog = enable ? 1 : 0;
+
+	ret = qmi_txn_init(&ab->qmi.handle, &txn,
+			   qmi_wlanfw_wlan_ini_resp_msg_v01_ei, &resp);
+	if (ret < 0)
+		goto out;
+
+	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
+			       ATH12K_QMI_WLANFW_WLAN_INI_REQ_V01,
+			       QMI_WLANFW_WLAN_INI_REQ_MSG_V01_MAX_LEN,
+			       qmi_wlanfw_wlan_ini_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		qmi_txn_cancel(&txn);
+		ath12k_warn(ab, "qmi failed to send wlan ini request, err = %d\n",
+			    ret);
+		goto out;
+	}
+
+	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH12K_QMI_WLANFW_TIMEOUT_MS));
+	if (ret < 0) {
+		ath12k_warn(ab, "qmi failed wlan ini request, err = %d\n", ret);
+		goto out;
+	}
+
+	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		ath12k_warn(ab, "qmi wlan ini request failed, result: %d, err: %d\n",
+			    resp.resp.result, resp.resp.error);
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
 void ath12k_qmi_firmware_stop(struct ath12k_base *ab)
 {
 	int ret;
@@ -2737,6 +2824,12 @@ int ath12k_qmi_firmware_start(struct ath12k_base *ab,
 {
 	int ret;
 
+	ret = ath12k_qmi_wlanfw_wlan_ini_send(ab, true);
+	if (ret < 0) {
+		ath12k_warn(ab, "qmi failed to send wlan fw ini:%d\n", ret);
+		return ret;
+	}
+
 	ret = ath12k_qmi_wlanfw_wlan_cfg_send(ab);
 	if (ret < 0) {
 		ath12k_warn(ab, "qmi failed to send wlan cfg:%d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index e25bbaa125e8..86fc282ab7b0 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_QMI_H
@@ -559,6 +559,21 @@ struct qmi_wlanfw_wlan_cfg_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
+#define ATH12K_QMI_WLANFW_WLAN_INI_REQ_V01	0x002F
+#define ATH12K_QMI_WLANFW_WLAN_INI_RESP_V01	0x002F
+#define QMI_WLANFW_WLAN_INI_REQ_MSG_V01_MAX_LEN		7
+#define QMI_WLANFW_WLAN_INI_RESP_MSG_V01_MAX_LEN	7
+
+struct qmi_wlanfw_wlan_ini_req_msg_v01 {
+	/* Must be set to true if enablefwlog is being passed */
+	u8 enablefwlog_valid;
+	u8 enablefwlog;
+};
+
+struct qmi_wlanfw_wlan_ini_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
 int ath12k_qmi_firmware_start(struct ath12k_base *ab,
 			      u32 mode);
 void ath12k_qmi_firmware_stop(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/trace.h b/drivers/net/wireless/ath/ath12k/trace.h
index f72096684b74..240737e1542d 100644
--- a/drivers/net/wireless/ath/ath12k/trace.h
+++ b/drivers/net/wireless/ath/ath12k/trace.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #if !defined(_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
@@ -140,6 +140,33 @@ TRACE_EVENT(ath12k_htt_rxdesc,
 	 )
 );
 
+TRACE_EVENT(ath12k_wmi_diag,
+	    TP_PROTO(struct ath12k_base *ab, const void *data, size_t len),
+
+	TP_ARGS(ab, data, len),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(ab->dev))
+		__string(driver, dev_driver_string(ab->dev))
+		__field(u16, len)
+		__dynamic_array(u8, data, len)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(ab->dev));
+		__assign_str(driver, dev_driver_string(ab->dev));
+		__entry->len = len;
+		memcpy(__get_dynamic_array(data), data, len);
+	),
+
+	TP_printk(
+		"%s %s tlv diag len %d",
+		__get_str(driver),
+		__get_str(device),
+		__entry->len
+	)
+);
+
 #endif /* _TRACE_H_ || TRACE_HEADER_MULTI_READ*/
 
 /* we don't want to use include/trace/events */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 553d2566b3f7..3776f9ea94db 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -6661,6 +6661,12 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	kfree(tb);
 }
 
+static void
+ath12k_wmi_diag_event(struct ath12k_base *ab, struct sk_buff *skb)
+{
+	trace_ath12k_wmi_diag(ab, skb->data, skb->len);
+}
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -6771,6 +6777,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_VDEV_DELETE_RESP_EVENTID:
 		ath12k_vdev_delete_resp_event(ab, skb);
 		break;
+	case WMI_DIAG_EVENTID:
+		ath12k_wmi_diag_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);

base-commit: b7e181d8d8483ade26ce3b15b957ca5bf9653b72
-- 
2.25.1


