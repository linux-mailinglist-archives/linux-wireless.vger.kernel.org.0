Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C95FD936
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKOJbI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:31:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKOJbH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:31:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FC3E61657; Fri, 15 Nov 2019 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810266;
        bh=G62Xq5cJkWuZH9wADqFJ3JX58F/pdJDe4S+XxxYc2ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDZQCxZx27xwxhhQIz3Z5sCr94vGk6WoNuvU/Frmacw1AcaorfDYvNZQQEuXi0BGh
         WU32IL/GgX/jkvexu4TJdRP4MfKbw1pb9LhysiVMb/gG2/nPO5m1+pv0A6Pl1M830R
         FvoouYWOQQHU2kjCxN9HwuFB4gvkCV95EaelpEjk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5285261506;
        Fri, 15 Nov 2019 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810251;
        bh=G62Xq5cJkWuZH9wADqFJ3JX58F/pdJDe4S+XxxYc2ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FL1FMChsCiDm5ZJAAgAqvsx/ptaZkX+zD9m+Bap/ZqHpc2EpdoQojLMhtahBzgI5D
         wHyEWXbj8V/0MtfhajunBOvbgUg2sCNsaPASz+J8ft40ABg4Aqf5umMVQsJKMnAF3d
         4XFJSu/GHSWNacL1U6ij0f0v8M/mwbMJjS2DSlcs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5285261506
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 36/49] ath11k: add qmi.h
Date:   Fri, 15 Nov 2019 11:29:00 +0200
Message-Id: <1573810153-29623-37-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.h | 445 ++++++++++++++++++++++++++++++++++
 1 file changed, 445 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
new file mode 100644
index 000000000000..df0685564e21
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -0,0 +1,445 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_QMI_H
+#define ATH11K_QMI_H
+
+#include <linux/mutex.h>
+#include <linux/soc/qcom/qmi.h>
+
+#define ATH11K_HOST_VERSION_STRING		"WIN"
+#define ATH11K_QMI_WLANFW_TIMEOUT_MS		5000
+#define ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE	64
+#define ATH11K_QMI_BDF_ADDRESS			0x4B0C0000
+#define ATH11K_QMI_BDF_MAX_SIZE			(256 * 1024)
+#define ATH11K_QMI_CALDATA_OFFSET		(128 * 1024)
+#define ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
+#define ATH11K_QMI_WLFW_SERVICE_ID_V01		0x45
+#define ATH11K_QMI_WLFW_SERVICE_VERS_V01	0x01
+#define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
+#define ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
+#define ATH11K_QMI_RESP_LEN_MAX			8192
+#define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	32
+#define ATH11K_QMI_CALDB_SIZE			0x480000
+#define ATH11K_QMI_DEFAULT_CAL_FILE_NAME	"caldata.bin"
+
+#define QMI_WLFW_REQUEST_MEM_IND_V01		0x0035
+#define QMI_WLFW_FW_MEM_READY_IND_V01		0x0037
+#define QMI_WLFW_COLD_BOOT_CAL_DONE_IND_V01	0x0021
+#define QMI_WLFW_FW_READY_IND_V01		0x0038
+
+#define QMI_WLANFW_MAX_DATA_SIZE_V01		6144
+#define ATH11K_FIRMWARE_MODE_OFF		4
+#define ATH11K_QMI_TARGET_MEM_MODE_DEFAULT	0
+
+struct ath11k_base;
+
+enum ath11k_qmi_file_type {
+	ATH11K_QMI_FILE_TYPE_BDF_GOLDEN,
+	ATH11K_QMI_FILE_TYPE_CALDATA,
+	ATH11K_QMI_MAX_FILE_TYPE,
+};
+
+enum ath11k_qmi_event_type {
+	ATH11K_QMI_EVENT_SERVER_ARRIVE,
+	ATH11K_QMI_EVENT_SERVER_EXIT,
+	ATH11K_QMI_EVENT_REQUEST_MEM,
+	ATH11K_QMI_EVENT_FW_MEM_READY,
+	ATH11K_QMI_EVENT_FW_READY,
+	ATH11K_QMI_EVENT_COLD_BOOT_CAL_START,
+	ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE,
+	ATH11K_QMI_EVENT_REGISTER_DRIVER,
+	ATH11K_QMI_EVENT_UNREGISTER_DRIVER,
+	ATH11K_QMI_EVENT_RECOVERY,
+	ATH11K_QMI_EVENT_FORCE_FW_ASSERT,
+	ATH11K_QMI_EVENT_POWER_UP,
+	ATH11K_QMI_EVENT_POWER_DOWN,
+	ATH11K_QMI_EVENT_MAX,
+};
+
+struct ath11k_qmi_driver_event {
+	struct list_head list;
+	enum ath11k_qmi_event_type type;
+	void *data;
+};
+
+struct ath11k_qmi_ce_cfg {
+	const u8 *tgt_ce;
+	int tgt_ce_len;
+	const u8 *svc_to_ce_map;
+	int svc_to_ce_map_len;
+	const u8 *shadow_reg;
+	int shadow_reg_len;
+	u8 *shadow_reg_v2;
+	int shadow_reg_v2_len;
+};
+
+struct ath11k_qmi_event_msg {
+	struct list_head list;
+	enum ath11k_qmi_event_type type;
+};
+
+struct target_mem_chunk {
+	u32 size;
+	u32 type;
+	dma_addr_t paddr;
+	u32 vaddr;
+};
+
+struct target_info {
+	u32 chip_id;
+	u32 chip_family;
+	u32 board_id;
+	u32 soc_id;
+	u32 fw_version;
+	char fw_build_timestamp[ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01 + 1];
+	char fw_build_id[ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01 + 1];
+};
+
+struct ath11k_qmi {
+	struct ath11k_base *ab;
+	struct qmi_handle handle;
+	struct sockaddr_qrtr sq;
+	struct work_struct event_work;
+	struct workqueue_struct *event_wq;
+	struct list_head event_list;
+	spinlock_t event_lock; /* spinlock for qmi event list */
+	struct ath11k_qmi_ce_cfg ce_cfg;
+	struct target_mem_chunk target_mem[ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
+	u32 mem_seg_count;
+	u32 target_mem_mode;
+	u8 cal_done;
+	struct target_info target;
+};
+
+#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		189
+#define QMI_WLANFW_HOST_CAP_REQ_V01			0x0034
+#define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN	7
+#define QMI_WLFW_HOST_CAP_RESP_V01			0x0034
+#define QMI_WLFW_MAX_NUM_GPIO_V01			32
+#define QMI_IPQ8074_FW_MEM_MODE				0xFF
+#define HOST_DDR_REGION_TYPE				0x1
+#define BDF_MEM_REGION_TYPE				0x2
+#define CALDB_MEM_REGION_TYPE				0x4
+
+struct qmi_wlanfw_host_cap_req_msg_v01 {
+	u8 num_clients_valid;
+	u32 num_clients;
+	u8 wake_msi_valid;
+	u32 wake_msi;
+	u8 gpios_valid;
+	u32 gpios_len;
+	u32 gpios[QMI_WLFW_MAX_NUM_GPIO_V01];
+	u8 nm_modem_valid;
+	u8 nm_modem;
+	u8 bdf_support_valid;
+	u8 bdf_support;
+	u8 bdf_cache_support_valid;
+	u8 bdf_cache_support;
+	u8 m3_support_valid;
+	u8 m3_support;
+	u8 m3_cache_support_valid;
+	u8 m3_cache_support;
+	u8 cal_filesys_support_valid;
+	u8 cal_filesys_support;
+	u8 cal_cache_support_valid;
+	u8 cal_cache_support;
+	u8 cal_done_valid;
+	u8 cal_done;
+	u8 mem_bucket_valid;
+	u32 mem_bucket;
+	u8 mem_cfg_mode_valid;
+	u8 mem_cfg_mode;
+};
+
+struct qmi_wlanfw_host_cap_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+#define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54
+#define QMI_WLANFW_IND_REGISTER_REQ_V01				0x0020
+#define QMI_WLANFW_IND_REGISTER_RESP_MSG_V01_MAX_LEN		18
+#define QMI_WLANFW_IND_REGISTER_RESP_V01			0x0020
+#define QMI_WLANFW_CLIENT_ID					0x4b4e454c
+
+struct qmi_wlanfw_ind_register_req_msg_v01 {
+	u8 fw_ready_enable_valid;
+	u8 fw_ready_enable;
+	u8 initiate_cal_download_enable_valid;
+	u8 initiate_cal_download_enable;
+	u8 initiate_cal_update_enable_valid;
+	u8 initiate_cal_update_enable;
+	u8 msa_ready_enable_valid;
+	u8 msa_ready_enable;
+	u8 pin_connect_result_enable_valid;
+	u8 pin_connect_result_enable;
+	u8 client_id_valid;
+	u32 client_id;
+	u8 request_mem_enable_valid;
+	u8 request_mem_enable;
+	u8 fw_mem_ready_enable_valid;
+	u8 fw_mem_ready_enable;
+	u8 fw_init_done_enable_valid;
+	u8 fw_init_done_enable;
+	u8 rejuvenate_enable_valid;
+	u32 rejuvenate_enable;
+	u8 xo_cal_enable_valid;
+	u8 xo_cal_enable;
+	u8 cal_done_enable_valid;
+	u8 cal_done_enable;
+};
+
+struct qmi_wlanfw_ind_register_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	u8 fw_status_valid;
+	u64 fw_status;
+};
+
+#define QMI_WLANFW_REQUEST_MEM_IND_MSG_V01_MAX_LEN	1124
+#define QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN	548
+#define QMI_WLANFW_RESPOND_MEM_RESP_MSG_V01_MAX_LEN	7
+#define QMI_WLANFW_REQUEST_MEM_IND_V01			0x0035
+#define QMI_WLANFW_RESPOND_MEM_REQ_V01			0x0036
+#define QMI_WLANFW_RESPOND_MEM_RESP_V01			0x0036
+#define QMI_WLANFW_MAX_NUM_MEM_CFG_V01			2
+
+struct qmi_wlanfw_mem_cfg_s_v01 {
+	u64 offset;
+	u32 size;
+	u8 secure_flag;
+};
+
+enum qmi_wlanfw_mem_type_enum_v01 {
+	WLANFW_MEM_TYPE_ENUM_MIN_VAL_V01 = INT_MIN,
+	QMI_WLANFW_MEM_TYPE_MSA_V01 = 0,
+	QMI_WLANFW_MEM_TYPE_DDR_V01 = 1,
+	QMI_WLANFW_MEM_BDF_V01 = 2,
+	QMI_WLANFW_MEM_M3_V01 = 3,
+	QMI_WLANFW_MEM_CAL_V01 = 4,
+	QMI_WLANFW_MEM_DPD_V01 = 5,
+	WLANFW_MEM_TYPE_ENUM_MAX_VAL_V01 = INT_MAX,
+};
+
+struct qmi_wlanfw_mem_seg_s_v01 {
+	u32 size;
+	enum qmi_wlanfw_mem_type_enum_v01 type;
+	u32 mem_cfg_len;
+	struct qmi_wlanfw_mem_cfg_s_v01 mem_cfg[QMI_WLANFW_MAX_NUM_MEM_CFG_V01];
+};
+
+struct qmi_wlanfw_request_mem_ind_msg_v01 {
+	u32 mem_seg_len;
+	struct qmi_wlanfw_mem_seg_s_v01 mem_seg[ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
+};
+
+struct qmi_wlanfw_mem_seg_resp_s_v01 {
+	u64 addr;
+	u32 size;
+	enum qmi_wlanfw_mem_type_enum_v01 type;
+	u8 restore;
+};
+
+struct qmi_wlanfw_respond_mem_req_msg_v01 {
+	u32 mem_seg_len;
+	struct qmi_wlanfw_mem_seg_resp_s_v01 mem_seg[ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
+};
+
+struct qmi_wlanfw_respond_mem_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+struct qmi_wlanfw_fw_mem_ready_ind_msg_v01 {
+	char placeholder;
+};
+
+#define QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN	0
+#define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN	207
+#define QMI_WLANFW_CAP_REQ_V01			0x0024
+#define QMI_WLANFW_CAP_RESP_V01			0x0024
+
+enum qmi_wlanfw_pipedir_enum_v01 {
+	QMI_WLFW_PIPEDIR_NONE_V01 = 0,
+	QMI_WLFW_PIPEDIR_IN_V01 = 1,
+	QMI_WLFW_PIPEDIR_OUT_V01 = 2,
+	QMI_WLFW_PIPEDIR_INOUT_V01 = 3,
+};
+
+struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01 {
+	__le32 pipe_num;
+	__le32 pipe_dir;
+	__le32 nentries;
+	__le32 nbytes_max;
+	__le32 flags;
+};
+
+struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01 {
+	__le32 service_id;
+	__le32 pipe_dir;
+	__le32 pipe_num;
+};
+
+struct qmi_wlanfw_shadow_reg_cfg_s_v01 {
+	u16 id;
+	u16 offset;
+};
+
+struct qmi_wlanfw_shadow_reg_v2_cfg_s_v01 {
+	u32 addr;
+};
+
+struct qmi_wlanfw_memory_region_info_s_v01 {
+	u64 region_addr;
+	u32 size;
+	u8 secure_flag;
+};
+
+struct qmi_wlanfw_rf_chip_info_s_v01 {
+	u32 chip_id;
+	u32 chip_family;
+};
+
+struct qmi_wlanfw_rf_board_info_s_v01 {
+	u32 board_id;
+};
+
+struct qmi_wlanfw_soc_info_s_v01 {
+	u32 soc_id;
+};
+
+struct qmi_wlanfw_fw_version_info_s_v01 {
+	u32 fw_version;
+	char fw_build_timestamp[ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01 + 1];
+};
+
+enum qmi_wlanfw_cal_temp_id_enum_v01 {
+	QMI_WLANFW_CAL_TEMP_IDX_0_V01 = 0,
+	QMI_WLANFW_CAL_TEMP_IDX_1_V01 = 1,
+	QMI_WLANFW_CAL_TEMP_IDX_2_V01 = 2,
+	QMI_WLANFW_CAL_TEMP_IDX_3_V01 = 3,
+	QMI_WLANFW_CAL_TEMP_IDX_4_V01 = 4,
+	QMI_WLANFW_CAL_TEMP_ID_MAX_V01 = 0xFF,
+};
+
+struct qmi_wlanfw_cap_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	u8 chip_info_valid;
+	struct qmi_wlanfw_rf_chip_info_s_v01 chip_info;
+	u8 board_info_valid;
+	struct qmi_wlanfw_rf_board_info_s_v01 board_info;
+	u8 soc_info_valid;
+	struct qmi_wlanfw_soc_info_s_v01 soc_info;
+	u8 fw_version_info_valid;
+	struct qmi_wlanfw_fw_version_info_s_v01 fw_version_info;
+	u8 fw_build_id_valid;
+	char fw_build_id[ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01 + 1];
+	u8 num_macs_valid;
+	u8 num_macs;
+};
+
+struct qmi_wlanfw_cap_req_msg_v01 {
+	char placeholder;
+};
+
+#define QMI_WLANFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_LEN	6182
+#define QMI_WLANFW_BDF_DOWNLOAD_RESP_MSG_V01_MAX_LEN	7
+#define QMI_WLANFW_BDF_DOWNLOAD_RESP_V01		0x0025
+#define QMI_WLANFW_BDF_DOWNLOAD_REQ_V01			0x0025
+/* TODO: Need to check with MCL and FW team that data can be pointer and
+ * can be last element in structure
+ */
+struct qmi_wlanfw_bdf_download_req_msg_v01 {
+	u8 valid;
+	u8 file_id_valid;
+	enum qmi_wlanfw_cal_temp_id_enum_v01 file_id;
+	u8 total_size_valid;
+	u32 total_size;
+	u8 seg_id_valid;
+	u32 seg_id;
+	u8 data_valid;
+	u32 data_len;
+	u8 data[QMI_WLANFW_MAX_DATA_SIZE_V01];
+	u8 end_valid;
+	u8 end;
+	u8 bdf_type_valid;
+	u8 bdf_type;
+
+};
+
+struct qmi_wlanfw_bdf_download_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+#define QMI_WLANFW_M3_INFO_REQ_MSG_V01_MAX_MSG_LEN	18
+#define QMI_WLANFW_M3_INFO_RESP_MSG_V01_MAX_MSG_LEN	7
+#define QMI_WLANFW_M3_INFO_RESP_V01		0x003C
+#define QMI_WLANFW_M3_INFO_REQ_V01		0x003C
+
+struct qmi_wlanfw_m3_info_req_msg_v01 {
+	u64 addr;
+	u32 size;
+};
+
+struct qmi_wlanfw_m3_info_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+#define QMI_WLANFW_WLAN_MODE_REQ_MSG_V01_MAX_LEN	11
+#define QMI_WLANFW_WLAN_MODE_RESP_MSG_V01_MAX_LEN	7
+#define QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN		803
+#define QMI_WLANFW_WLAN_CFG_RESP_MSG_V01_MAX_LEN	7
+#define QMI_WLANFW_WLAN_MODE_REQ_V01			0x0022
+#define QMI_WLANFW_WLAN_MODE_RESP_V01			0x0022
+#define QMI_WLANFW_WLAN_CFG_REQ_V01			0x0023
+#define QMI_WLANFW_WLAN_CFG_RESP_V01			0x0023
+#define QMI_WLANFW_MAX_STR_LEN_V01			16
+#define QMI_WLANFW_MAX_NUM_CE_V01			12
+#define QMI_WLANFW_MAX_NUM_SVC_V01			24
+#define QMI_WLANFW_MAX_NUM_SHADOW_REG_V01		24
+#define QMI_WLANFW_MAX_NUM_SHADOW_REG_V2_V01		36
+
+struct qmi_wlanfw_wlan_mode_req_msg_v01 {
+	u32 mode;
+	u8 hw_debug_valid;
+	u8 hw_debug;
+};
+
+struct qmi_wlanfw_wlan_mode_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+struct qmi_wlanfw_wlan_cfg_req_msg_v01 {
+	u8 host_version_valid;
+	char host_version[QMI_WLANFW_MAX_STR_LEN_V01 + 1];
+	u8  tgt_cfg_valid;
+	u32  tgt_cfg_len;
+	struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01
+			tgt_cfg[QMI_WLANFW_MAX_NUM_CE_V01];
+	u8  svc_cfg_valid;
+	u32 svc_cfg_len;
+	struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01
+			svc_cfg[QMI_WLANFW_MAX_NUM_SVC_V01];
+	u8 shadow_reg_valid;
+	u32 shadow_reg_len;
+	struct qmi_wlanfw_shadow_reg_cfg_s_v01
+		shadow_reg[QMI_WLANFW_MAX_NUM_SHADOW_REG_V01];
+	u8 shadow_reg_v2_valid;
+	u32 shadow_reg_v2_len;
+	struct qmi_wlanfw_shadow_reg_v2_cfg_s_v01
+		shadow_reg_v2[QMI_WLANFW_MAX_NUM_SHADOW_REG_V2_V01];
+};
+
+struct qmi_wlanfw_wlan_cfg_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+};
+
+int ath11k_qmi_firmware_start(struct ath11k_base *ab,
+			      u32 mode);
+void ath11k_qmi_firmware_stop(struct ath11k_base *ab);
+void ath11k_qmi_event_work(struct work_struct *work);
+void ath11k_qmi_msg_recv_work(struct work_struct *work);
+void ath11k_qmi_deinit_service(struct ath11k_base *ab);
+int ath11k_qmi_init_service(struct ath11k_base *ab);
+
+#endif

