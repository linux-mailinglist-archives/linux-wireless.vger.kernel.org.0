Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B643D17FC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhGUTjv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 15:39:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15055 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhGUTjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 15:39:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626898824; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Qi2gcuuhOAIwzcFAQT0jzcQ6MqzorBKRoNKIhy5Awm0=; b=qx+p4KRa7wybqNlg8tW2roXVs+WpqRPhii2jorxVZDk9UF0nU8yIONIqwSgIXnEfkncAAF9f
 bKh7t2UvF8A4Fo9lVieNA/7r5ja3g8WJIzQXy58LoC+UAehbAt9LAnLL41LlILzxF9vXy2gT
 HJhTNAfT0jHdYxgvjRH31OodZ8k=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60f88175b653fbdadd568c31 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 20:20:05
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F5CBC4360C; Wed, 21 Jul 2021 20:20:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3562BC4323A;
        Wed, 21 Jul 2021 20:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3562BC4323A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 4/4] ath11k: add caldata download support from EEPROM
Date:   Wed, 21 Jul 2021 23:19:27 +0300
Message-Id: <20210721201927.100369-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721201927.100369-1-jouni@codeaurora.org>
References: <20210721201927.100369-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Firmware updates EEPROM support capability in QMI FW caps, send QMI BDF
download request message with file type EEPROM, to get caldata download
from EEPROM. Firmware takes more time to update cal data from EEPROM, so
increase QMI timeout.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 135 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/qmi.h |  16 ++-
 2 files changed, 125 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 381ae70e45ff..cc3c4412d679 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -950,6 +950,78 @@ static struct qmi_elem_info qmi_wlanfw_cap_resp_msg_v01_ei[] = {
 		.offset		= offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
 					   num_macs),
 	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x16,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   voltage_mv_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x16,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   voltage_mv),
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x17,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   time_freq_hz_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x17,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   time_freq_hz),
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x18,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   otp_version_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x18,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   otp_version),
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x19,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   eeprom_read_timeout_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x19,
+		.offset         = offsetof(struct qmi_wlanfw_cap_resp_msg_v01,
+					   eeprom_read_timeout),
+	},
 	{
 		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
@@ -1900,6 +1972,12 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 		strlcpy(ab->qmi.target.fw_build_id, resp.fw_build_id,
 			sizeof(ab->qmi.target.fw_build_id));
 
+	if (resp.eeprom_read_timeout_valid) {
+		ab->qmi.target.eeprom_caldata =
+					resp.eeprom_read_timeout;
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi cal data supported from eeprom\n");
+	}
+
 	ath11k_info(ab, "chip_id 0x%x chip_family 0x%x board_id 0x%x soc_id 0x%x\n",
 		    ab->qmi.target.chip_id, ab->qmi.target.chip_family,
 		    ab->qmi.target.board_id, ab->qmi.target.soc_id);
@@ -1962,7 +2040,8 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 			req->end = 1;
 		}
 
-		if (ab->bus_params.fixed_bdf_addr) {
+		if (ab->bus_params.fixed_bdf_addr ||
+		    type == ATH11K_QMI_FILE_TYPE_EEPROM) {
 			req->data_valid = 0;
 			req->end = 1;
 			req->data_len = ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE;
@@ -2006,7 +2085,8 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 			goto out;
 		}
 
-		if (ab->bus_params.fixed_bdf_addr) {
+		if (ab->bus_params.fixed_bdf_addr ||
+		    type == ATH11K_QMI_FILE_TYPE_EEPROM) {
 			remaining = 0;
 		} else {
 			remaining -= req->data_len;
@@ -2033,6 +2113,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 	struct ath11k_board_data bd;
 	u32 fw_size, file_type;
 	int ret = 0, bdf_type;
+	const u8 *tmp;
 
 	memset(&bd, 0, sizeof(bd));
 	ret = ath11k_core_fetch_bdf(ab, &bd);
@@ -2057,31 +2138,38 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 		goto out;
 	}
 
-	/* QCA6390 does not support cal data file, skip it */
+	/* QCA6390 does not support cal data, skip it */
 	if (bdf_type == ATH11K_QMI_BDF_TYPE_ELF)
 		goto out;
 
-	file_type = ATH11K_QMI_FILE_TYPE_CALDATA;
-
-	/* cal-<bus>-<id>.bin */
-	snprintf(filename, sizeof(filename), "cal-%s-%s.bin",
-		 ath11k_bus_str(ab->hif.bus), dev_name(dev));
-	fw_entry = ath11k_core_firmware_request(ab, filename);
-	if (!IS_ERR(fw_entry))
-		goto success;
-
-	fw_entry = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_CAL_FILE);
-	if (IS_ERR(fw_entry)) {
-		ret = PTR_ERR(fw_entry);
-		ath11k_warn(ab,
-			    "qmi failed to load CAL data file:%s\n",
-			    filename);
-		goto out;
+	if (ab->qmi.target.eeprom_caldata) {
+		file_type = ATH11K_QMI_FILE_TYPE_EEPROM;
+		tmp = filename;
+		fw_size = ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE;
+	} else {
+		file_type = ATH11K_QMI_FILE_TYPE_CALDATA;
+
+		/* cal-<bus>-<id>.bin */
+		snprintf(filename, sizeof(filename), "cal-%s-%s.bin",
+			 ath11k_bus_str(ab->hif.bus), dev_name(dev));
+		fw_entry = ath11k_core_firmware_request(ab, filename);
+		if (!IS_ERR(fw_entry))
+			goto success;
+
+		fw_entry = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_CAL_FILE);
+		if (IS_ERR(fw_entry)) {
+			ret = PTR_ERR(fw_entry);
+			ath11k_warn(ab,
+				    "qmi failed to load CAL data file:%s\n",
+				    filename);
+			goto out;
+		}
+success:
+		fw_size = min_t(u32, ab->hw_params.fw.board_size, fw_entry->size);
+		tmp = fw_entry->data;
 	}
 
-success:
-	fw_size = min_t(u32, ab->hw_params.fw.board_size, fw_entry->size);
-	ret = ath11k_qmi_load_file_target_mem(ab, fw_entry->data, fw_size, file_type);
+	ret = ath11k_qmi_load_file_target_mem(ab, tmp, fw_size, file_type);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to load caldata\n");
 		goto out_qmi_cal;
@@ -2090,7 +2178,8 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi caldata type: %u\n", file_type);
 
 out_qmi_cal:
-	release_firmware(fw_entry);
+	if (!ab->qmi.target.eeprom_caldata)
+		release_firmware(fw_entry);
 out:
 	ath11k_core_free_bdf(ab, &bd);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi BDF download sequence completed\n");
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 30236c5d26e2..3bb0f9ef7996 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -10,7 +10,7 @@
 #include <linux/soc/qcom/qmi.h>
 
 #define ATH11K_HOST_VERSION_STRING		"WIN"
-#define ATH11K_QMI_WLANFW_TIMEOUT_MS		5000
+#define ATH11K_QMI_WLANFW_TIMEOUT_MS		10000
 #define ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE	64
 #define ATH11K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
@@ -42,6 +42,7 @@ struct ath11k_base;
 enum ath11k_qmi_file_type {
 	ATH11K_QMI_FILE_TYPE_BDF_GOLDEN,
 	ATH11K_QMI_FILE_TYPE_CALDATA,
+	ATH11K_QMI_FILE_TYPE_EEPROM,
 	ATH11K_QMI_MAX_FILE_TYPE,
 };
 
@@ -102,6 +103,7 @@ struct target_info {
 	u32 board_id;
 	u32 soc_id;
 	u32 fw_version;
+	u32 eeprom_caldata;
 	char fw_build_timestamp[ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01 + 1];
 	char fw_build_id[ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01 + 1];
 	char bdf_ext[ATH11K_QMI_BDF_EXT_STR_LENGTH];
@@ -133,7 +135,7 @@ struct ath11k_qmi {
 	wait_queue_head_t cold_boot_waitq;
 };
 
-#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		189
+#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		261
 #define QMI_WLANFW_HOST_CAP_REQ_V01			0x0034
 #define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLFW_HOST_CAP_RESP_V01			0x0034
@@ -283,7 +285,7 @@ struct qmi_wlanfw_fw_cold_cal_done_ind_msg_v01 {
 };
 
 #define QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN	0
-#define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN	207
+#define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN	235
 #define QMI_WLANFW_CAP_REQ_V01			0x0024
 #define QMI_WLANFW_CAP_RESP_V01			0x0024
 
@@ -364,6 +366,14 @@ struct qmi_wlanfw_cap_resp_msg_v01 {
 	char fw_build_id[ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01 + 1];
 	u8 num_macs_valid;
 	u8 num_macs;
+	u8 voltage_mv_valid;
+	u32 voltage_mv;
+	u8 time_freq_hz_valid;
+	u32 time_freq_hz;
+	u8 otp_version_valid;
+	u32 otp_version;
+	u8 eeprom_read_timeout_valid;
+	u32 eeprom_read_timeout;
 };
 
 struct qmi_wlanfw_cap_req_msg_v01 {
-- 
2.25.1

