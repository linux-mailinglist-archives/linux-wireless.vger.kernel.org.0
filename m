Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FC3F2A86
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbhHTLEX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 07:04:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57564 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239343AbhHTLEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mH2J6-002IL4-Tb; Fri, 20 Aug 2021 14:03:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 20 Aug 2021 14:03:15 +0300
Message-Id: <iwlwifi.20210820140104.dc1997632cf4.I9d93ef704af34daed3c2075dfc3841ed03b9e590@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820110318.260751-1-luca@coelho.fi>
References: <20210820110318.260751-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 09/12] iwlwifi: mvm: add fixed_rate debugfs entry to public DHC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Expose the fixed_rate debugfs entry wnen IWLWIFI_DHC_PUBLIC is
enabled.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   | 12 ++++-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 40 ++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 46 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 33 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 10 ++--
 5 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
index 3ffc5904056f..481c942db2ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
@@ -22,7 +22,17 @@ enum iwl_dhc_table_id {
 enum iwl_dhc_umac_integration_table {
 	/* @DHC_INT_UMAC_TWT_OPERATION: trigger a TWT operation */
 	DHC_INT_UMAC_TWT_OPERATION = 4,
-	/* @DHC_INTEGRATION_MAX: Maximum UMAC integration table entries */
+	/**
+	 * @DHC_INTEGRATION_TLC_DEBUG_CONFIG: TLC debug
+	 */
+	DHC_INTEGRATION_TLC_DEBUG_CONFIG = 1,
+	/**
+	 * @DHC_INT_UMAC_TWT_CONTROL: TWT hooks (like disable internal TWT triggers)
+	 */
+	DHC_INT_UMAC_TWT_CONTROL = 10,
+	/**
+	 * @DHC_INTEGRATION_MAX: Maximum UMAC integration table entries
+	 */
 	DHC_INTEGRATION_MAX
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index fc2fa49e9825..f23766df236b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_rs_h__
@@ -184,8 +184,42 @@ struct iwl_tlc_update_notif {
 	__le32 amsdu_enabled;
 } __packed; /* TLC_MNG_UPDATE_NTFY_API_S_VER_2 */
 
-/*
- * These serve as indexes into
+#ifdef CONFIG_IWLWIFI_DHC
+/**
+ * enum iwl_tlc_debug_types - debug options
+ */
+enum iwl_tlc_debug_types {
+	/* @IWL_TLC_DEBUG_FIXED_RATE: set fixed rate for rate scaling */
+	IWL_TLC_DEBUG_FIXED_RATE,
+}; /* TLC_MNG_DEBUG_TYPES_API_E */
+#endif /* CONFIG_IWLWIFI_DHC */
+
+#ifdef CONFIG_IWLWIFI_DHC
+#define MAX_DATA_IN_DHC_TLC_CMD 10
+
+/**
+ * struct iwl_dhc_tlc_dbg - fixed debug config
+ * @sta_id: bit 0 - enable/disable, bits 1 - 7 hold station id
+ * @reserved1: reserved
+ * @type: type id of %enum iwl_tlc_debug_types
+ * @data: data to send
+ */
+struct iwl_dhc_tlc_cmd {
+	u8 sta_id;
+	u8 reserved1[3];
+	__le32 type;
+	__le32 data[MAX_DATA_IN_DHC_TLC_CMD];
+} __packed; /* TLC_MNG_DEBUG_CMD_S */
+#endif /* CONFIG_IWLWIFI_DHC */
+
+#define IWL_MAX_MCS_DISPLAY_SIZE        12
+
+struct iwl_rate_mcs_info {
+	char    mbps[IWL_MAX_MCS_DISPLAY_SIZE];
+	char    mcs[IWL_MAX_MCS_DISPLAY_SIZE];
+};
+
+/* These serve as indexes into
  * struct iwl_rate_info fw_rate_idx_to_plcp[IWL_RATE_COUNT];
  * TODO: avoid overlap between legacy and HT rates
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 5dc39fbb74d6..86a4dcd21681 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -414,6 +414,46 @@ static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
 	return ret;
 }
 
+#ifdef CONFIG_IWLWIFI_DHC
+static void iwl_rs_set_fixed_rate(struct iwl_mvm *mvm,
+				  struct iwl_lq_sta_rs_fw *lq_sta)
+{
+	int ret = iwl_rs_send_dhc(mvm, lq_sta,
+				  IWL_TLC_DEBUG_FIXED_RATE,
+				  lq_sta->pers.dbg_fixed_rate);
+
+	char pretty_rate[100];
+
+	if (ret) {
+		lq_sta->pers.dbg_fixed_rate = 0;
+		return;
+	}
+
+	rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate),
+			     lq_sta->pers.dbg_fixed_rate);
+	IWL_DEBUG_RATE(mvm, "sta_id %d rate %s\n",
+		       lq_sta->pers.sta_id, pretty_rate);
+}
+
+static ssize_t iwl_dbgfs_fixed_rate_write(struct ieee80211_sta *sta,
+					  char *buf, size_t count,
+					  loff_t *ppos)
+{
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->lq_sta.rs_fw;
+	struct iwl_mvm *mvm = lq_sta->pers.drv;
+	u32 parsed_rate;
+
+	if (kstrtou32(buf, 0, &parsed_rate))
+		lq_sta->pers.dbg_fixed_rate = 0;
+	else
+		lq_sta->pers.dbg_fixed_rate = parsed_rate;
+
+	iwl_rs_set_fixed_rate(mvm, lq_sta);
+	return count;
+}
+#endif /* CONFIG_IWLWIFI_DHC */
+
 static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_sta *sta,
 					 char *buf, size_t count,
 					 loff_t *ppos)
@@ -1889,6 +1929,9 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(bcast_filters_macs, 256);
 MVM_DEBUGFS_READ_FILE_OPS(sar_geo_profile);
 #endif
 
+#ifdef CONFIG_IWLWIFI_DHC
+MVM_DEBUGFS_WRITE_STA_FILE_OPS(fixed_rate, 64);
+#endif
 MVM_DEBUGFS_READ_WRITE_STA_FILE_OPS(amsdu_len, 16);
 
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(he_sniffer_params, 32);
@@ -2037,6 +2080,9 @@ void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 
 	if (iwl_mvm_has_tlc_offload(mvm)) {
 		MVM_DEBUGFS_ADD_STA_FILE(rs_data, dir, 0400);
+#ifdef CONFIG_IWLWIFI_DHC
+		MVM_DEBUGFS_ADD_STA_FILE(fixed_rate, dir, 0200);
+#endif
 	}
 	MVM_DEBUGFS_ADD_STA_FILE(amsdu_len, dir, 0600);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 2d58cb969918..dc12d8890021 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -359,6 +359,39 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_IWLWIFI_DHC
+int iwl_rs_send_dhc(struct iwl_mvm *mvm, struct iwl_lq_sta_rs_fw *lq_sta,
+		    u32 type, u32 data)
+{
+	int ret;
+	struct iwl_dhc_cmd *dhc_cmd;
+	struct iwl_dhc_tlc_cmd *dhc_tlc_cmd;
+	u32 cmd_id = iwl_cmd_id(DEBUG_HOST_COMMAND, IWL_ALWAYS_LONG_GROUP, 0);
+
+	dhc_cmd = kzalloc(sizeof(*dhc_cmd) + sizeof(*dhc_tlc_cmd), GFP_KERNEL);
+	if (!dhc_cmd)
+		return -ENOMEM;
+
+	dhc_tlc_cmd = (void *)dhc_cmd->data;
+	dhc_tlc_cmd->sta_id = lq_sta->pers.sta_id;
+	dhc_tlc_cmd->type = cpu_to_le32(type);
+	dhc_tlc_cmd->data[0] = cpu_to_le32(data);
+	dhc_cmd->length = cpu_to_le32(sizeof(*dhc_tlc_cmd) >> 2);
+	dhc_cmd->index_and_mask =
+		cpu_to_le32(DHC_TABLE_INTEGRATION | DHC_TARGET_UMAC |
+			    DHC_INTEGRATION_TLC_DEBUG_CONFIG);
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC,
+				   sizeof(*dhc_cmd) + sizeof(*dhc_tlc_cmd),
+				   dhc_cmd);
+	if (ret)
+		IWL_ERR(mvm, "Failed to send TLC Debug command: %d\n", ret);
+
+	kfree(dhc_cmd);
+	return ret;
+}
+#endif /* CONFIG_IWLWIFI_DHC */
+
 u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 32104c9f8f5e..2b72d477a46f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -211,13 +211,6 @@ struct rs_rate {
 #define is_ht80(rate)         ((rate)->bw == RATE_MCS_CHAN_WIDTH_80)
 #define is_ht160(rate)        ((rate)->bw == RATE_MCS_CHAN_WIDTH_160)
 
-#define IWL_MAX_MCS_DISPLAY_SIZE	12
-
-struct iwl_rate_mcs_info {
-	char	mbps[IWL_MAX_MCS_DISPLAY_SIZE];
-	char	mcs[IWL_MAX_MCS_DISPLAY_SIZE];
-};
-
 /**
  * struct iwl_lq_sta_rs_fw - rate and related statistics for RS in FW
  * @last_rate_n_flags: last rate reported by FW
@@ -454,4 +447,7 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 			      struct iwl_rx_cmd_buffer *rxb);
 
 u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta);
+
+int iwl_rs_send_dhc(struct iwl_mvm *mvm, struct iwl_lq_sta_rs_fw *lq_sta,
+		    u32 type, u32 data);
 #endif /* __rs__ */
-- 
2.33.0

