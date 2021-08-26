Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63A83F8F29
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhHZTsu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 15:48:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33454 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243602AbhHZTst (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 15:48:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJLLz-002XB4-42; Thu, 26 Aug 2021 22:48:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 22:47:44 +0300
Message-Id: <iwlwifi.20210826224715.1545e8f7d6f4.I53b8d9fb194b88070a0df6613f7f57668ea0eaf8@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826194748.826360-1-luca@coelho.fi>
References: <20210826194748.826360-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH v2 08/12] iwlwifi: export DHC framework and add first public entry, twt_setup
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Export the debug host command framework and add the twt_setup entry.
This will allow external parties to use these debugging features.
More entries can be added later on.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    |   6 +
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +
 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   | 122 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  87 +++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 6 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 1085afbefba8..1a948520d7dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -92,6 +92,12 @@ config IWLWIFI_BCAST_FILTERING
 	  If unsure, don't enable this option, as some programs might
 	  expect incoming broadcasts for their normal operations.
 
+config IWLWIFI_DHC
+	bool "Enable debug host commands" if EXPERT
+	help
+	  This option enables the debug host command API.  It's used
+	  for debugging and validation purposes.
+
 menu "Debugging Options"
 
 config IWLWIFI_DEBUG
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index ee6b5844a871..b07e75be8679 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -495,6 +495,11 @@ enum iwl_legacy_cmds {
 	 */
 	DTS_MEASUREMENT_NOTIFICATION = 0xdd,
 
+	/**
+	 * @DEBUG_HOST_COMMAND: &struct iwl_dhc_cmd
+	 */
+	DEBUG_HOST_COMMAND = 0xf1,
+
 	/**
 	 * @LDBG_CONFIG_CMD: configure continuous trace recording
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
new file mode 100644
index 000000000000..3ffc5904056f
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2016-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2021 Intel Corporation
+ */
+#ifndef __iwl_fw_api_dhc_h__
+#define __iwl_fw_api_dhc_h__
+
+#define DHC_TABLE_MASK_POS (28)
+
+/**
+ * enum iwl_dhc_table_id - DHC table operations index
+ */
+enum iwl_dhc_table_id {
+	/* @DHC_TABLE_INTEGRATION: select the integration table */
+	DHC_TABLE_INTEGRATION	= 2 << DHC_TABLE_MASK_POS,
+};
+
+/**
+ * enum iwl_dhc_umac_integration_table - integration operations
+ */
+enum iwl_dhc_umac_integration_table {
+	/* @DHC_INT_UMAC_TWT_OPERATION: trigger a TWT operation */
+	DHC_INT_UMAC_TWT_OPERATION = 4,
+	/* @DHC_INTEGRATION_MAX: Maximum UMAC integration table entries */
+	DHC_INTEGRATION_MAX
+};
+
+#define DHC_TARGET_UMAC BIT(27)
+#define DHC_ADWELL_SCAN_CHANNEL_DWELL_INDEX 2
+#define DHC_ADWELL_SCAN_FINE_TUNE_INDEX 3
+
+/**
+ * struct iwl_dhc_cmd - debug host command
+ * @length: length in DWs of the data structure that is concatenated to the end
+ *	of this struct
+ * @index_and_mask: bit 31 is 1 for data set operation else it's 0
+ *	bits 28-30 is the index of the table of the operation -
+ *	&enum iwl_dhc_table_id *
+ *	bit 27 is 0 if the cmd targeted to LMAC and 1 if targeted to UMAC,
+ *	(LMAC is 0 for backward compatibility)
+ *	bit 26 is 0 if the cmd targeted to LMAC0 and 1 if targeted to LMAC1,
+ *	relevant only if bit 27 set to 0
+ *	bits 0-25 is a specific entry index in the table specified in bits 28-30
+ *
+ * @data: the concatenated data.
+ */
+struct iwl_dhc_cmd {
+	__le32 length;
+	__le32 index_and_mask;
+	__le32 data[0];
+} __packed; /* DHC_CMD_API_S */
+
+/**
+ * enum iwl_dhc_twt_operation_type - describes the TWT operation type
+ *
+ * @DHC_TWT_REQUEST: Send a Request TWT command
+ * @DHC_TWT_SUGGEST: Send a Suggest TWT command
+ * @DHC_TWT_DEMAND: Send a Demand TWT command
+ * @DHC_TWT_GROUPING: Send a Grouping TWT command
+ * @DHC_TWT_ACCEPT: Send a Accept TWT command
+ * @DHC_TWT_ALTERNATE: Send a Alternate TWT command
+ * @DHC_TWT_DICTATE: Send a Dictate TWT command
+ * @DHC_TWT_REJECT: Send a Reject TWT command
+ * @DHC_TWT_TEARDOWN: Send a TearDown TWT command
+ */
+enum iwl_dhc_twt_operation_type {
+	DHC_TWT_REQUEST,
+	DHC_TWT_SUGGEST,
+	DHC_TWT_DEMAND,
+	DHC_TWT_GROUPING,
+	DHC_TWT_ACCEPT,
+	DHC_TWT_ALTERNATE,
+	DHC_TWT_DICTATE,
+	DHC_TWT_REJECT,
+	DHC_TWT_TEARDOWN,
+}; /* DHC_TWT_OPERATION_TYPE_E */
+
+/**
+ * struct iwl_dhc_twt_operation - trigger a TWT operation
+ *
+ * @mac_id: the mac Id on which to trigger TWT operation
+ * @twt_operation: see &enum iwl_dhc_twt_operation_type
+ * @target_wake_time: when should we be on channel
+ * @interval_exp: the exponent for the interval
+ * @interval_mantissa: the mantissa for the interval
+ * @min_wake_duration: the minimum duration for the wake period
+ * @trigger: is the TWT triggered or not
+ * @flow_type: is the TWT announced or not
+ * @flow_id: the TWT flow identifier from 0 to 7
+ * @protection: is the TWT protected
+ * @ndo_paging_indicator: is ndo_paging_indicator set
+ * @responder_pm_mode: is responder_pm_mode set
+ * @negotiation_type: if the responder wants to doze outside the TWT SP
+ * @twt_request: 1 for TWT request, 0 otherwise
+ * @implicit: is TWT implicit
+ * @twt_group_assignment: the TWT group assignment
+ * @twt_channel: the TWT channel
+ * @reserved: reserved
+ */
+struct iwl_dhc_twt_operation {
+	__le32 mac_id;
+	__le32 twt_operation;
+	__le64 target_wake_time;
+	__le32 interval_exp;
+	__le32 interval_mantissa;
+	__le32 min_wake_duration;
+	u8 trigger;
+	u8 flow_type;
+	u8 flow_id;
+	u8 protection;
+	u8 ndo_paging_indicator;
+	u8 responder_pm_mode;
+	u8 negotiation_type;
+	u8 twt_request;
+	u8 implicit;
+	u8 twt_group_assignment;
+	u8 twt_channel;
+	u8 reserved;
+}; /* DHC_TWT_OPERATION_API_S */
+
+#endif /* __iwl_fw_api_dhc_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 7d9faeffd154..4ddd18ae5f86 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -686,6 +686,86 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file *file,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
+#ifdef CONFIG_IWLWIFI_DHC
+static ssize_t iwl_dbgfs_twt_setup_write(struct ieee80211_vif *vif, char *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	struct iwl_dhc_twt_operation *dhc_twt_cmd;
+	struct iwl_dhc_cmd *cmd;
+
+	u32 twt_operation;
+	u64 target_wake_time;
+	u32 interval_exp;
+	u32 interval_mantissa;
+	u32 min_wake_duration;
+	u8 trigger;
+	u8 flow_type;
+	u8 flow_id;
+	u8 protection;
+	u8 twt_request = 1;
+	u8 broadcast = 0;
+	u8 tenth_param;
+	int ret;
+
+	ret = sscanf(buf, "%u %llu %u %u %u %hhu %hhu %hhu %hhu %hhu",
+		     &twt_operation, &target_wake_time, &interval_exp,
+		     &interval_mantissa, &min_wake_duration, &trigger,
+		     &flow_type, &flow_id, &protection, &tenth_param);
+
+	// the new twt_request parameter is optional for station
+	if ((ret != 9 && ret != 10) ||
+	    (vif->type != NL80211_IFTYPE_STATION && tenth_param == 1))
+		return -EINVAL;
+
+	/*
+	 * The 10th parameter:
+	 * In STA mode - the TWT type (broadcast or individual)
+	 * In AP mode - the role (0 responder, 1 requester, 2 unsolicited)
+	 */
+	if (ret == 10) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			broadcast = tenth_param;
+		else
+			twt_request = tenth_param;
+	}
+
+	cmd = kzalloc(sizeof(*cmd) + sizeof(*dhc_twt_cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	dhc_twt_cmd = (void *)cmd->data;
+	dhc_twt_cmd->mac_id = cpu_to_le32(mvmvif->id);
+	dhc_twt_cmd->twt_operation = cpu_to_le32(twt_operation);
+	dhc_twt_cmd->target_wake_time = cpu_to_le64(target_wake_time);
+	dhc_twt_cmd->interval_exp = cpu_to_le32(interval_exp);
+	dhc_twt_cmd->interval_mantissa = cpu_to_le32(interval_mantissa);
+	dhc_twt_cmd->min_wake_duration = cpu_to_le32(min_wake_duration);
+	dhc_twt_cmd->trigger = trigger;
+	dhc_twt_cmd->flow_type = flow_type;
+	dhc_twt_cmd->flow_id = flow_id;
+	dhc_twt_cmd->protection = protection;
+	dhc_twt_cmd->twt_request = twt_request;
+	dhc_twt_cmd->negotiation_type = broadcast ? 3 : 0;
+
+	cmd->length = cpu_to_le32(sizeof(*dhc_twt_cmd) >> 2);
+	cmd->index_and_mask =
+		cpu_to_le32(DHC_TABLE_INTEGRATION | DHC_TARGET_UMAC |
+			    DHC_INT_UMAC_TWT_OPERATION);
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(DEBUG_HOST_COMMAND,
+						   IWL_ALWAYS_LONG_GROUP, 0),
+				   0, sizeof(*cmd) + sizeof(*dhc_twt_cmd),
+				   cmd);
+	mutex_unlock(&mvm->mutex);
+	kfree(cmd);
+
+	return ret ?: count;
+}
+#endif
+
 #define MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz) \
 	_MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz, struct ieee80211_vif)
 #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
@@ -705,6 +785,9 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(uapsd_misbehaving, 20);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
+#ifdef CONFIG_IWLWIFI_DHC
+MVM_DEBUGFS_WRITE_FILE_OPS(twt_setup, 256);
+#endif
 
 
 void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -745,6 +828,10 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	    mvmvif == mvm->bf_allowed_vif)
 		MVM_DEBUGFS_ADD_FILE_VIF(bf_params, mvmvif->dbgfs_dir, 0600);
 
+#ifdef CONFIG_IWLWIFI_DHC
+	MVM_DEBUGFS_ADD_FILE_VIF(twt_setup, mvmvif->dbgfs_dir, S_IWUSR);
+#endif
+
 	/*
 	 * Create symlink for convenience pointing to interface specific
 	 * debugfs entries for the driver. For example, under
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
index 73a82f07dc59..aa18d802de8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -37,5 +37,6 @@
 #include "fw/api/location.h"
 #include "fw/api/tx.h"
 #include "fw/api/rfi.h"
+#include "fw/api/dhc.h"
 
 #endif /* __fw_api_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 6f60018feed1..51eb52003cb1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -493,6 +493,7 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(SCAN_ITERATION_COMPLETE),
 	HCMD_NAME(D0I3_END_CMD),
 	HCMD_NAME(LTR_CONFIG),
+	HCMD_NAME(DEBUG_HOST_COMMAND),
 	HCMD_NAME(LDBG_CONFIG_CMD),
 };
 
-- 
2.33.0

