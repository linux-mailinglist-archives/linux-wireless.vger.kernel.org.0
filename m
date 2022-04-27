Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E41511636
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 13:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiD0LWd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiD0LWc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 07:22:32 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183772ED69;
        Wed, 27 Apr 2022 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651058361; x=1682594361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/AXtOuRa8oelXWybdr3yw1r2OhGKxYqOekMawY2GmFw=;
  b=TidZ3nPLZjnJC3C28x6k+FAhhrll0n4biz7Pn9Vv9JK+8aUEyseEXzPc
   Z//iRNSYBuGg3ExNad0jA718KVJY4GhvMLyuAxkeOygxGq1NsI+YKdikF
   nkjcQZ9lcEg0JIwX9eZt1o/FaaPIZIbRZAkK9Wfw7fdLQDMajK0hwNJ/g
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 04:19:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 04:19:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 04:19:20 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 04:19:17 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v6 5/9] ath11k: Fetch device information via QMI for WCN6750
Date:   Wed, 27 Apr 2022 16:48:44 +0530
Message-ID: <20220427111848.9257-6-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
References: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since WPPS Q6 does the PCIe enumeration of WCN6750, device
information like BAR and BAR size is not known to the APPS
processor (Application Processor SubSystem). In order to
fetch these details, a QMI message called device info request
will be sent to the target. Therefore, add logic to fetch
BAR details from the target.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 144 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.h |  24 ++++-
 2 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 0442faa3b7af..df49f8b68556 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -12,6 +13,8 @@
 #include <linux/of_address.h>
 #include <linux/ioport.h>
 #include <linux/firmware.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
@@ -748,6 +751,68 @@ static struct qmi_elem_info qmi_wlanfw_cap_req_msg_v01_ei[] = {
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
@@ -2007,6 +2072,79 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
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
@@ -2748,6 +2886,12 @@ static int ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 		return ret;
 	}
 
+	ret = ath11k_qmi_request_device_info(ab);
+	if (ret < 0) {
+		ath11k_warn(ab, "failed to request qmi device info %d\n", ret);
+		return ret;
+	}
+
 	if (ab->hw_params.supports_regdb)
 		ath11k_qmi_load_bdf_qmi(ab, true);
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 872646c3b3ed..445b6bd34eb5 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -38,6 +38,8 @@
 #define ATH11K_FIRMWARE_MODE_OFF		4
 #define ATH11K_COLD_BOOT_FW_RESET_DELAY		(40 * HZ)
 
+#define ATH11K_QMI_DEVICE_BAR_SIZE		0x200000
+
 struct ath11k_base;
 
 enum ath11k_qmi_file_type {
@@ -287,10 +289,12 @@ struct qmi_wlanfw_fw_cold_cal_done_ind_msg_v01 {
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
@@ -383,6 +387,18 @@ struct qmi_wlanfw_cap_req_msg_v01 {
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
2.35.1

