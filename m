Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2606B9D7D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCNRvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCNRvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:51:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49504B0B9D
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816243; x=1710352243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=akgXdz8kV+bZhrHdB29VUferdFN0rblF4BViRblg1mc=;
  b=E2GOIp4rMYHwxdBUGiUJ+zbwZY4l37ByhqaxvnIIpbYKVwTb3tyBzL2m
   RS6g7cA4kOsb5IOGUOkP6PXlVY7fjuqq9KCx6SMtecM0WcQZeYz4id6dL
   RCpzZEHM3RIuo4k3kbta1EhWCp6YAgYtopRRkFRJz9SYmeJyeqirNsLYw
   SamanU8hRSE7FAH3DUQtXbKvjY4FPVwlos48V2R1Z7XbZVLRBpa+/WsHA
   jy9fY+JZ2MioPSZHXdmoN7QlTdgVHa2ncpSKcdR9j1Kvlush4gfSMzSzs
   8alogcu7aJvkYHlUsPaoi/+Cy5kbpp7Ks6KfZISUvQfs3hU1CM+zL/Hqv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149531"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149531"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200460"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200460"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:49:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/22] wifi: iwlwifi: yoyo: Add driver defined dump file name
Date:   Tue, 14 Mar 2023 19:49:15 +0200
Message-Id: <20230314194113.2a2ee92995e9.I38fff588e32276796cd757309fc811241f827c7a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add driver defined dump file name extension for beacon loss
and FW Assert case.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 58 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 61 ++++++++++++-------
 5 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 05720352e49f..43fb5cf85f05 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -281,7 +281,7 @@ static const struct iwl_ht_params iwl_gl_a_ht_params = {
 	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
-	.min_umac_error_event_table = 0x400000,				\
+	.min_umac_error_event_table = 0xD0000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 60 * 1024,				\
 	.mon_smem_regs = {						\
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 792f7fee1840..59ed321bcc27 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -14,6 +14,13 @@
 #include "iwl-csr.h"
 #include "pnvm.h"
 
+#define FW_ASSERT_LMAC_FATAL			0x70
+#define FW_ASSERT_LMAC2_FATAL			0x72
+#define FW_ASSERT_UMAC_FATAL			0x71
+#define UMAC_RT_NMI_LMAC2_FATAL			0x72
+#define RT_NMI_INTERRUPT_OTHER_LMAC_FATAL	0x73
+#define FW_ASSERT_NMI_UNKNOWN			0x84
+
 /*
  * Note: This structure is read from the device with IO accesses,
  * and the reading already does the endian conversion. As it is
@@ -96,6 +103,17 @@ struct iwl_umac_error_event_table {
 #define ERROR_START_OFFSET  (1 * sizeof(u32))
 #define ERROR_ELEM_SIZE     (7 * sizeof(u32))
 
+static bool iwl_fwrt_if_errorid_other_cpu(u32 err_id)
+{
+	err_id &= 0xFF;
+
+	if ((err_id >= FW_ASSERT_LMAC_FATAL &&
+	     err_id <= RT_NMI_INTERRUPT_OTHER_LMAC_FATAL) ||
+	    err_id == FW_ASSERT_NMI_UNKNOWN)
+		return  true;
+	return false;
+}
+
 static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
 {
 	struct iwl_trans *trans = fwrt->trans;
@@ -113,6 +131,13 @@ static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
 	if (table.valid)
 		fwrt->dump.umac_err_id = table.error_id;
 
+	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.umac_err_id) &&
+	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
+		fwrt->trans->dbg.dump_file_name_ext_valid = true;
+		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
+			 "0x%x", fwrt->dump.umac_err_id);
+	}
+
 	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
 		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
 		IWL_ERR(trans, "Transport status: 0x%08lX, valid: %d\n",
@@ -189,6 +214,13 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 	if (table.valid)
 		fwrt->dump.lmac_err_id[lmac_num] = table.error_id;
 
+	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.lmac_err_id[lmac_num]) &&
+	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
+		fwrt->trans->dbg.dump_file_name_ext_valid = true;
+		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
+			 "0x%x", fwrt->dump.lmac_err_id[lmac_num]);
+	}
+
 	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
 		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
 		IWL_ERR(trans, "Transport status: 0x%08lX, valid: %d\n",
@@ -274,6 +306,16 @@ static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 
 	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
 
+	if (table.valid)
+		fwrt->dump.tcm_err_id[idx] = table.error_id;
+
+	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.tcm_err_id[idx]) &&
+	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
+		fwrt->trans->dbg.dump_file_name_ext_valid = true;
+		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
+			 "0x%x", fwrt->dump.tcm_err_id[idx]);
+	}
+
 	IWL_ERR(fwrt, "TCM%d status:\n", idx + 1);
 	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
 	IWL_ERR(fwrt, "0x%08X | tcm branchlink2\n", table.blink2);
@@ -337,6 +379,16 @@ static void iwl_fwrt_dump_rcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 
 	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
 
+	if (table.valid)
+		fwrt->dump.rcm_err_id[idx] = table.error_id;
+
+	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.rcm_err_id[idx]) &&
+	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
+		fwrt->trans->dbg.dump_file_name_ext_valid = true;
+		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
+			 "0x%x", fwrt->dump.rcm_err_id[idx]);
+	}
+
 	IWL_ERR(fwrt, "RCM%d status:\n", idx + 1);
 	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
 	IWL_ERR(fwrt, "0x%08X | rcm branchlink2\n", table.blink2);
@@ -444,8 +496,10 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	iwl_fwrt_dump_umac_error_log(fwrt);
 	iwl_fwrt_dump_tcm_error_log(fwrt, 0);
 	iwl_fwrt_dump_rcm_error_log(fwrt, 0);
-	iwl_fwrt_dump_tcm_error_log(fwrt, 1);
-	iwl_fwrt_dump_rcm_error_log(fwrt, 1);
+	if (fwrt->trans->dbg.tcm_error_event_table[1])
+		iwl_fwrt_dump_tcm_error_log(fwrt, 1);
+	if (fwrt->trans->dbg.rcm_error_event_table[1])
+		iwl_fwrt_dump_rcm_error_log(fwrt, 1);
 	iwl_fwrt_dump_iml_error_log(fwrt);
 	iwl_fwrt_dump_fseq_regs(fwrt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index d3cb1ae68a96..a59cf4d9567c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -24,6 +24,8 @@ struct iwl_fw_runtime_ops {
 };
 
 #define MAX_NUM_LMAC 2
+#define MAX_NUM_TCM 2
+#define MAX_NUM_RCM 2
 struct iwl_fwrt_shared_mem_cfg {
 	int num_lmacs;
 	int num_txfifo_entries;
@@ -129,6 +131,8 @@ struct iwl_fw_runtime {
 		unsigned long non_collect_ts_start[IWL_FW_INI_TIME_POINT_NUM];
 		u32 *d3_debug_data;
 		u32 lmac_err_id[MAX_NUM_LMAC];
+		u32 tcm_err_id[MAX_NUM_TCM];
+		u32 rcm_err_id[MAX_NUM_RCM];
 		u32 umac_err_id;
 
 		struct iwl_txf_iter_data txf_iter_data;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 45981e22b2db..3e9e9f13506b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -122,8 +122,6 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u32 version = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					      UCODE_ALIVE_NTFY, 0);
 	u32 i;
-	struct iwl_trans *trans = mvm->trans;
-	enum iwl_device_family device_family = trans->trans_cfg->device_family;
 
 
 	if (version == 6) {
@@ -233,8 +231,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 
 	if (umac_error_table) {
 		if (umac_error_table >=
-		    mvm->trans->cfg->min_umac_error_event_table ||
-		    device_family >= IWL_DEVICE_FAMILY_BZ) {
+		    mvm->trans->cfg->min_umac_error_event_table) {
 			iwl_fw_umac_set_alive_err_table(mvm->trans,
 							umac_error_table);
 		} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 114c96ba39ee..422550e31bc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -430,47 +430,55 @@ static void iwl_mvm_mac_ctxt_set_ht_flags(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
-					struct ieee80211_vif *vif,
-					struct iwl_mac_ctx_cmd *cmd,
-					const u8 *bssid_override,
-					u32 action)
+static int iwl_mvm_get_mac_type(struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct ieee80211_chanctx_conf *chanctx;
-	bool ht_enabled = !!(vif->bss_conf.ht_operation_mode &
-			     IEEE80211_HT_OP_MODE_PROTECTION);
-	u8 cck_ack_rates, ofdm_ack_rates;
-	const u8 *bssid = bssid_override ?: vif->bss_conf.bssid;
-	int i;
-
-	cmd->id_and_color = cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
-							    mvmvif->color));
-	cmd->action = cpu_to_le32(action);
+	u32 mac_type = FW_MAC_TYPE_BSS_STA;
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
 		if (vif->p2p)
-			cmd->mac_type = cpu_to_le32(FW_MAC_TYPE_P2P_STA);
+			mac_type = FW_MAC_TYPE_P2P_STA;
 		else
-			cmd->mac_type = cpu_to_le32(FW_MAC_TYPE_BSS_STA);
+			mac_type = FW_MAC_TYPE_BSS_STA;
 		break;
 	case NL80211_IFTYPE_AP:
-		cmd->mac_type = cpu_to_le32(FW_MAC_TYPE_GO);
+		mac_type = FW_MAC_TYPE_GO;
 		break;
 	case NL80211_IFTYPE_MONITOR:
-		cmd->mac_type = cpu_to_le32(FW_MAC_TYPE_LISTENER);
+		mac_type = FW_MAC_TYPE_LISTENER;
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
-		cmd->mac_type = cpu_to_le32(FW_MAC_TYPE_P2P_DEVICE);
+		mac_type = FW_MAC_TYPE_P2P_DEVICE;
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		cmd->mac_type = cpu_to_le32(FW_MAC_TYPE_IBSS);
+		mac_type = FW_MAC_TYPE_IBSS;
 		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
 
+	return mac_type;
+}
+
+static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct iwl_mac_ctx_cmd *cmd,
+					const u8 *bssid_override,
+					u32 action)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_chanctx_conf *chanctx;
+	bool ht_enabled = !!(vif->bss_conf.ht_operation_mode &
+			     IEEE80211_HT_OP_MODE_PROTECTION);
+	u8 cck_ack_rates, ofdm_ack_rates;
+	const u8 *bssid = bssid_override ?: vif->bss_conf.bssid;
+	int i;
+
+	cmd->id_and_color = cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
+							    mvmvif->color));
+	cmd->action = cpu_to_le32(action);
+	cmd->mac_type = cpu_to_le32(iwl_mvm_get_mac_type(vif));
+
 	cmd->tsf_id = cpu_to_le32(mvmvif->tsf_id);
 
 	memcpy(cmd->node_addr, vif->addr, ETH_ALEN);
@@ -1428,6 +1436,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	struct ieee80211_vif *vif;
 	u32 id = le32_to_cpu(mb->mac_id);
 	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
+	u32 mac_type;
 
 	IWL_DEBUG_INFO(mvm,
 		       "missed bcn mac_id=%u, consecutive=%u (%u, %u, %u)\n",
@@ -1443,6 +1452,14 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	if (!vif)
 		goto out;
 
+	mac_type = iwl_mvm_get_mac_type(vif);
+
+	IWL_DEBUG_INFO(mvm, "missed beacon mac_type=%u,\n", mac_type);
+
+	mvm->trans->dbg.dump_file_name_ext_valid = true;
+	snprintf(mvm->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
+		 "MacId_%d_MacType_%d", id, mac_type);
+
 	rx_missed_bcon = le32_to_cpu(mb->consec_missed_beacons);
 	rx_missed_bcon_since_rx =
 		le32_to_cpu(mb->consec_missed_beacons_since_last_rx);
-- 
2.38.1

