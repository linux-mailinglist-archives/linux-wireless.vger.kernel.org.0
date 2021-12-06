Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB64692F0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 10:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbhLFJwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 04:52:30 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:18279 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241499AbhLFJwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 04:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638784134; x=1670320134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hwKJ/axYaIAgbKvPW/cwUvOdDi+iX6PE5iTzUs7SSHk=;
  b=WFXSj+sRzZ8WDqhfLX/1UUQ7f+KugN4ubRCuCivOgRpJUWLh3BcznF8O
   0zdAqCNzbTmckz7H4Srcq5WRxy3qZV8BcHjP91o5GK8CarnDA6B1G0rTn
   /tNddfmWwzIyEieivPuglxd5EUe69PN+ESit2+Q+NS/DRTfPrbUKs7PxV
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 01:48:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 01:48:53 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 01:48:52 -0800
Received: from FUZHOU.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 01:48:51 -0800
From:   Cheng Wang <quic_chengwan@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_chengwan@quicinc.com>
Subject: [PATCH] ath11k: add support of firmware logging for WCN6855
Date:   Mon, 6 Dec 2021 17:48:34 +0800
Message-ID: <20211206094834.2060080-1-quic_chengwan@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host enables WMI firmware logging feature via QMI message.
Host receives firmware logging messages on WMI_DIAG_EVENTID, then
sends logging messages to user space via event tracing infrastructure.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Cheng Wang <quic_chengwan@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c  |  5 ++
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 drivers/net/wireless/ath/ath11k/qmi.c   | 94 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.h   | 12 ++++
 drivers/net/wireless/ath/ath11k/trace.h | 27 +++++++
 drivers/net/wireless/ath/ath11k/wmi.c   | 10 +++
 6 files changed, 149 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 969bf1a590d9..949c0b781cba 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -71,6 +71,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.fw_wmi_diag_event = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -112,6 +113,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.fw_wmi_diag_event = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -152,6 +154,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.fw_wmi_diag_event = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -190,6 +193,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.fix_l1ss = true,
+		.fw_wmi_diag_event = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -230,6 +234,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
+		.fw_wmi_diag_event = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 62f5978b3005..a05a964dc567 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -163,6 +163,7 @@ struct ath11k_hw_params {
 	bool supports_suspend;
 	u32 hal_desc_sz;
 	bool fix_l1ss;
+	bool fw_wmi_diag_event;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index f06f452a6f9f..1081e7115b3a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1545,6 +1545,50 @@ static struct qmi_elem_info qmi_wlanfw_athdiag_read_req_msg_v01_ei[] = {
 	},
 };
 
+static struct qmi_elem_info qmi_wlanfw_wlan_ini_req_msg_v01_ei[] = {
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
+static struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
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
 static struct qmi_elem_info qmi_wlanfw_athdiag_read_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
@@ -2467,6 +2511,48 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 	return ret;
 }
 
+int ath11k_qmi_wlanfw_wlan_ini_send(struct ath11k_base *ab, bool enable)
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
+			       QMI_WLANFW_WLAN_INI_REQ_V01,
+			       QMI_WLANFW_WLAN_INI_REQ_MSG_V01_MAX_LEN,
+			       qmi_wlanfw_wlan_ini_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		ath11k_warn(ab, "qmi failed to send wlan ini request, err = %d\n",
+			    ret);
+		qmi_txn_cancel(&txn);
+		goto out;
+	}
+
+	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
+	if (ret < 0) {
+		ath11k_warn(ab, "qmi failed wlan ini request, err = %d\n", ret);
+		goto out;
+	}
+
+	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		ath11k_warn(ab, "qmi wlan ini request failed, result: %d, err: %d\n",
+			    resp.resp.result, resp.resp.error);
+		ret = -EINVAL;
+	}
+
+out:
+	return ret;
+}
+
 void ath11k_qmi_firmware_stop(struct ath11k_base *ab)
 {
 	int ret;
@@ -2487,6 +2573,14 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware start\n");
 
+	if (ab->hw_params.fw_wmi_diag_event) {
+		ret = ath11k_qmi_wlanfw_wlan_ini_send(ab, true);
+		if (ret < 0) {
+			ath11k_warn(ab, "qmi failed to send wlan fw ini:%d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = ath11k_qmi_wlanfw_wlan_cfg_send(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to send wlan cfg: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index fb643165e2ff..847c96380251 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -456,10 +456,12 @@ struct qmi_wlanfw_m3_info_resp_msg_v01 {
 #define QMI_WLANFW_WLAN_MODE_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN		803
 #define QMI_WLANFW_WLAN_CFG_RESP_MSG_V01_MAX_LEN	7
+#define QMI_WLANFW_WLAN_INI_REQ_MSG_V01_MAX_LEN		4
 #define QMI_WLANFW_WLAN_MODE_REQ_V01			0x0022
 #define QMI_WLANFW_WLAN_MODE_RESP_V01			0x0022
 #define QMI_WLANFW_WLAN_CFG_REQ_V01			0x0023
 #define QMI_WLANFW_WLAN_CFG_RESP_V01			0x0023
+#define QMI_WLANFW_WLAN_INI_REQ_V01			0x002F
 #define QMI_WLANFW_MAX_STR_LEN_V01			16
 #define QMI_WLANFW_MAX_NUM_CE_V01			12
 #define QMI_WLANFW_MAX_NUM_SVC_V01			24
@@ -501,6 +503,16 @@ struct qmi_wlanfw_wlan_cfg_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
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
 int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 			      u32 mode);
 void ath11k_qmi_firmware_stop(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless/ath/ath11k/trace.h
index d2d2a3cb0826..e7a1db805284 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -105,6 +105,33 @@ TRACE_EVENT(ath11k_htt_rxdesc,
 	 )
 );
 
+TRACE_EVENT(ath11k_wmi_diag,
+	    TP_PROTO(struct ath11k_base *ab, const void *data, size_t len),
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
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6c253eae9d06..324325a66656 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6967,6 +6967,13 @@ static void ath11k_wmi_event_wow_wakeup_host(struct ath11k_base *ab, struct sk_b
 	complete(&ab->wow.wakeup_completed);
 }
 
+static void
+ath11k_wmi_diag_event(struct ath11k_base *ab,
+		      struct sk_buff *skb)
+{
+	trace_ath11k_wmi_diag(ab, skb->data, skb->len);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -7077,6 +7084,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_WOW_WAKEUP_HOST_EVENTID:
 		ath11k_wmi_event_wow_wakeup_host(ab, skb);
 		break;
+	case WMI_DIAG_EVENTID:
+		ath11k_wmi_diag_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
-- 
2.25.1

