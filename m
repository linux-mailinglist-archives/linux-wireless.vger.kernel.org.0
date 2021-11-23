Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4745ABBE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhKWSzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:55:19 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15076 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232655AbhKWSzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693530; x=1669229530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=q0eY6uZfNL+5cMRSIQpbJ6/XqmzBNKX33FWvqW5dyHk=;
  b=ghh7NReiIt62m6Rtj+xpUotq4gnZLQPw+kaz7g6vILiKYFubBAljgvsv
   RefCUig8muqdyFTcJulmpxtNm5xuXbelAmoiSFeCNBkVlkDJVrrSRNzni
   qNm9x3mzpxCFSDXeAo8l1//2Y00KI9Axesx91FTg9uolOwJHhZ1hukMIK
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 10:52:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:52:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:38 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:36 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 09/19] ath11k: Fetch device information via QMI for WCN6750
Date:   Wed, 24 Nov 2021 00:20:24 +0530
Message-ID: <1637693434-15462-10-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since WPPS Q6 does the PCIe enumeration of WCN6750, device
information like BAR and BAR size is not known to the APPS
processor (Application Processor SubSystem). In order to
fetch these details, a QMI message called device info request
will be sent to the target. Therefore, add logic to fetch
BAR details from the target.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 144 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.h |  24 +++++-
 2 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 700a9c1..d47f838 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -10,6 +11,8 @@
 #include "debug.h"
 #include <linux/of.h>
 #include <linux/firmware.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
@@ -743,6 +746,68 @@ static struct qmi_elem_info qmi_wlanfw_cap_req_msg_v01_ei[] = {
 	},
 };
 
+static struct qmi_elem_info qmi_wlanfw_device_info_req_msg_v01_ei[] = {
+	{
+		.data_type      = QMI_EOTI,
+		.array_type     = NO_ARRAY,
+		.tlv_type       = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info qmi_wlfw_device_info_resp_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_wlanfw_device_info_resp_msg_v01,
+					   resp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_device_info_resp_msg_v01,
+					   bar_addr_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_8_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u64),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_device_info_resp_msg_v01,
+					   bar_addr),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_wlanfw_device_info_resp_msg_v01,
+					   bar_size_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_wlanfw_device_info_resp_msg_v01,
+					   bar_size),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
 static struct qmi_elem_info qmi_wlanfw_rf_chip_info_s_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
@@ -1910,6 +1975,79 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_qmi_request_device_info(struct ath11k_base *ab)
+{
+	struct qmi_wlanfw_device_info_req_msg_v01 req = {};
+	struct qmi_wlanfw_device_info_resp_msg_v01 resp = {};
+	struct qmi_txn txn;
+	void __iomem *bar_addr_va;
+	int ret;
+
+	/* device info message req is only sent for hybrid bus devices */
+	if (!ab->bus_params.hybrid_bus_type)
+		return 0;
+
+	ret = qmi_txn_init(&ab->qmi.handle, &txn,
+			   qmi_wlfw_device_info_resp_msg_v01_ei, &resp);
+	if (ret < 0)
+		goto out;
+
+	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
+			       QMI_WLANFW_DEVICE_INFO_REQ_V01,
+			       QMI_WLANFW_DEVICE_INFO_REQ_MSG_V01_MAX_LEN,
+			       qmi_wlanfw_device_info_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		qmi_txn_cancel(&txn);
+		ath11k_warn(ab, "qmi failed to send target device info request, err = %d\n",
+			    ret);
+		goto out;
+	}
+
+	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
+	if (ret < 0) {
+		ath11k_warn(ab, "qmi failed target device info request %d\n", ret);
+		goto out;
+	}
+
+	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		ath11k_warn(ab, "qmi device info req failed, result: %d, err: %d\n",
+			    resp.resp.result, resp.resp.error);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!resp.bar_addr_valid || !resp.bar_size_valid) {
+		ath11k_warn(ab, "qmi device info response invalid, result: %d, err: %d\n",
+			    resp.resp.result, resp.resp.error);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!resp.bar_addr ||
+	    resp.bar_size != ATH11K_QMI_DEVICE_BAR_SIZE) {
+		ath11k_warn(ab, "qmi device info invalid addr and size, result: %d, err: %d\n",
+			    resp.resp.result, resp.resp.error);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	bar_addr_va = devm_ioremap(ab->dev, resp.bar_addr, resp.bar_size);
+
+	if (!bar_addr_va) {
+		ath11k_warn(ab, "qmi device info ioremap failed\n");
+		ab->mem_len = 0;
+		ret = -EIO;
+		goto out;
+	}
+
+	ab->mem = bar_addr_va;
+	ab->mem_len = resp.bar_size;
+
+	return 0;
+out:
+	return ret;
+}
+
 static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_cap_req_msg_v01 req;
@@ -2584,6 +2722,12 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 		return ret;
 	}
 
+	ret = ath11k_qmi_request_device_info(ab);
+	if (ret < 0) {
+		ath11k_warn(ab, "failed to request qmi device info %d\n", ret);
+		return ret;
+	}
+
 	ret = ath11k_qmi_load_bdf_qmi(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "failed to load board data file: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 2b99cc5..5689da0 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -39,6 +39,8 @@
 #define ATH11K_QMI_TARGET_MEM_MODE_DEFAULT	0
 #define ATH11K_COLD_BOOT_FW_RESET_DELAY		(40 * HZ)
 
+#define ATH11K_QMI_DEVICE_BAR_SIZE		0x200000
+
 struct ath11k_base;
 
 enum ath11k_qmi_file_type {
@@ -286,10 +288,12 @@ struct qmi_wlanfw_fw_cold_cal_done_ind_msg_v01 {
 	char placeholder;
 };
 
-#define QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN	0
-#define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN	235
-#define QMI_WLANFW_CAP_REQ_V01			0x0024
-#define QMI_WLANFW_CAP_RESP_V01			0x0024
+#define QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN		0
+#define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN		235
+#define QMI_WLANFW_CAP_REQ_V01				0x0024
+#define QMI_WLANFW_CAP_RESP_V01				0x0024
+#define QMI_WLANFW_DEVICE_INFO_REQ_V01			0x004C
+#define QMI_WLANFW_DEVICE_INFO_REQ_MSG_V01_MAX_LEN	0
 
 enum qmi_wlanfw_pipedir_enum_v01 {
 	QMI_WLFW_PIPEDIR_NONE_V01 = 0,
@@ -382,6 +386,18 @@ struct qmi_wlanfw_cap_req_msg_v01 {
 	char placeholder;
 };
 
+struct qmi_wlanfw_device_info_req_msg_v01 {
+	char placeholder;
+};
+
+struct qmi_wlanfw_device_info_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	u64 bar_addr;
+	u32 bar_size;
+	u8 bar_addr_valid;
+	u8 bar_size_valid;
+};
+
 #define QMI_WLANFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_LEN	6182
 #define QMI_WLANFW_BDF_DOWNLOAD_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLANFW_BDF_DOWNLOAD_RESP_V01		0x0025
-- 
2.7.4

