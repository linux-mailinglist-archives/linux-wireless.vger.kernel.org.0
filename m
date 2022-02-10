Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0414B138C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiBJQwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiBJQwn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:43 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC21128
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:43 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDg-000Bxy-Jd;
        Thu, 10 Feb 2022 18:22:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:34 +0200
Message-Id: <iwlwifi.20220210181930.b8c1228a0c0a.I71da6a799253650f3d0b181315de388cb9360e30@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 11/11] iwlwifi: yoyo: send hcmd to fw after dump collection completes.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Send a command to FW once the driver completes the dump collection
for the timepoint which requires the command to be send.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  2 ++
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 19 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 32 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  5 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 ++
 5 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 55edd5ada899..52bf96585fc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -475,6 +475,7 @@ enum iwl_fw_ini_time_point {
  * @IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG: override trigger configuration
  * @IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA: override trigger data.
  *	Append otherwise
+ * @IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD: send cmd once dump collected
  */
 enum iwl_fw_ini_trigger_apply_policy {
 	IWL_FW_INI_APPLY_POLICY_MATCH_TIME_POINT	= BIT(0),
@@ -482,6 +483,7 @@ enum iwl_fw_ini_trigger_apply_policy {
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_REGIONS	= BIT(8),
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG		= BIT(9),
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA		= BIT(10),
+	IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD	= BIT(16),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 029ae64bf2b2..6255257ddebe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -42,6 +42,12 @@ enum iwl_debug_cmds {
 	 * &struct iwl_buf_alloc_cmd
 	 */
 	BUFFER_ALLOCATION = 0x8,
+	/**
+	 * @FW_DUMP_COMPLETE_CMD:
+	 * sends command to fw once dump collection completed
+	 * &struct iwl_dbg_dump_complete_cmd
+	 */
+	FW_DUMP_COMPLETE_CMD = 0xB,
 	/**
 	 * @MFU_ASSERT_DUMP_NTF:
 	 * &struct iwl_mfu_assert_dump_notif
@@ -404,4 +410,15 @@ struct iwl_dbg_host_event_cfg_cmd {
 	__le32 enabled_severities;
 } __packed; /* DEBUG_HOST_EVENT_CFG_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_dbg_dump_complete_cmd - dump complete cmd
+ *
+ * @tp: timepoint whose dump has completed
+ * @tp_data: timepoint data
+ */
+struct iwl_dbg_dump_complete_cmd {
+	__le32 tp;
+	__le32 tp_data;
+} __packed; /* FW_DUMP_COMPLETE_CMD_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_debug_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 656a5e7fb4a0..a08f80b9f357 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2845,6 +2845,28 @@ int iwl_fw_start_dbg_conf(struct iwl_fw_runtime *fwrt, u8 conf_id)
 }
 IWL_EXPORT_SYMBOL(iwl_fw_start_dbg_conf);
 
+void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
+				    u32 timepoint,
+				    u32 timepoint_data)
+{
+	struct iwl_dbg_dump_complete_cmd hcmd_data;
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DEBUG_GROUP, FW_DUMP_COMPLETE_CMD),
+		.data[0] = &hcmd_data,
+		.len[0] = sizeof(hcmd_data),
+	};
+
+	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+		return;
+
+	if (fw_has_capa(&fwrt->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT)) {
+		hcmd_data.tp = cpu_to_le32(timepoint);
+		hcmd_data.tp_data = cpu_to_le32(timepoint_data);
+		iwl_trans_send_cmd(fwrt->trans, &hcmd);
+	}
+}
+
 /* this function assumes dump_start was called beforehand and dump_end will be
  * called afterwards
  */
@@ -2853,7 +2875,8 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	struct iwl_fw_dbg_params params = {0};
 	struct iwl_fwrt_dump_data *dump_data =
 		&fwrt->dump.wks[wk_idx].dump_data;
-
+	u32 policy;
+	u32 time_point;
 	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
@@ -2879,6 +2902,13 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
+	policy = le32_to_cpu(dump_data->trig->apply_policy);
+	time_point = le32_to_cpu(dump_data->trig->time_point);
+
+	if (policy & IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD) {
+		IWL_DEBUG_FW_INFO(fwrt, "WRT: sending dump complete\n");
+		iwl_send_dbg_dump_complete_cmd(fwrt, time_point, 0);
+	}
 	if (fwrt->trans->dbg.last_tp_resetfw == IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY)
 		iwl_force_nmi(fwrt->trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 8c3c890066b0..be7806407de8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2019, 2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -324,4 +324,7 @@ static inline void iwl_fwrt_update_fw_versions(struct iwl_fw_runtime *fwrt,
 }
 
 void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt);
+void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
+				    u32 timepoint,
+				    u32 timepoint_data);
 #endif  /* __iwl_fw_dbg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 5b30136983c3..f44aedb3f049 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -369,6 +369,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	reset flow
  * @IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN: Support for passive scan on 6GHz PSC
  *      channels even when these are not enabled.
+ * @IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT: Support for indicating dump collection
+ *	complete to FW.
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -454,6 +456,7 @@ enum iwl_ucode_tlv_capa {
 
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
 	IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)104,
+	IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)105,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
-- 
2.34.1

