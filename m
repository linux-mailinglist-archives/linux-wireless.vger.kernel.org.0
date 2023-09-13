Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DC979E757
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbjIML52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbjIML51 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3104E19B4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606243; x=1726142243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/5rF8y8x+oahHF+LINJnWuvebHpdaqw4nq0T6NNk6c=;
  b=aejQrf9YbveoTRFRCW3s52/qBv9da+jO1NbhUCXRQurQkrlxsK8TUMM/
   6GhrU+g8q50eQ8P+CprQqUh+GvkizNwBUHtkiiaEsRjpW7QOV9GYXsNg6
   MymcCKUTfEOrc1nl4t0Hm7+42laO/CwctjqVlExa55k3tm38N62bDdXND
   3T1CJS3IoFFP9JH0ogsdj74mt4PcCW3UDBzyEvO2nKZdXwMNtad59xY9r
   wxejw5Fa73Y8CkGnezxl/YetGKpfXyaHpOc34BK5ZHhk3MqDJGsnC9E18
   chFvQU1yN434OiTpLgbza+bGjEhDFaL+lEX1FDR/mug00Gyz9Fs1T8sZC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903030"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903030"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470942"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470942"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:17 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: fw: disable firmware debug asserts
Date:   Wed, 13 Sep 2023 14:56:41 +0300
Message-Id: <20230913145231.8feafd9b17be.Ia7bec82ac25897caab581692d67055aa1aca2ed2@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Disable firmware debug asserts, which are used for internal
firmware testing purposes only.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 22 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 25 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  1 +
 6 files changed, 53 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 90ce8d9b6ad3..7b18e098b125 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -522,4 +522,26 @@ enum iwl_mvm_tas_statically_disabled_reason {
 	TAS_DISABLED_REASON_MAX,
 }; /*_TAS_STATICALLY_DISABLED_REASON_E*/
 
+/**
+ * enum iwl_fw_dbg_config_cmd_type - types of FW debug config command
+ * @DEBUG_TOKEN_CONFIG_TYPE: token config type
+ */
+enum iwl_fw_dbg_config_cmd_type {
+	DEBUG_TOKEN_CONFIG_TYPE = 0x2B,
+}; /* LDBG_CFG_CMD_TYPE_API_E_VER_1 */
+
+/* this token disables debug asserts in the firmware */
+#define IWL_FW_DBG_CONFIG_TOKEN 0x00011301
+
+/**
+ * struct iwl_fw_dbg_config_cmd - configure FW debug
+ *
+ * @type: according to &enum iwl_fw_dbg_config_cmd_type
+ * @conf: FW configuration
+ */
+struct iwl_fw_dbg_config_cmd {
+	__le32 type;
+	__le32 conf;
+} __packed; /* LDBG_CFG_CMD_API_S_VER_7 */
+
 #endif /* __iwl_fw_api_debug_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3ab6a68f1e9f..e236c1d95e8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3228,3 +3228,28 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 #endif
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_restart_recording);
+
+void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_fw_dbg_config_cmd cmd = {
+		.type = cpu_to_le32(DEBUG_TOKEN_CONFIG_TYPE),
+		.conf = cpu_to_le32(IWL_FW_DBG_CONFIG_TOKEN),
+	};
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(LONG_GROUP, LDBG_CONFIG_CMD),
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+	u32 preset = u32_get_bits(fwrt->trans->dbg.domains_bitmap,
+				  GENMASK(31, IWL_FW_DBG_DOMAIN_POS + 1));
+
+	/* supported starting from 9000 devices */
+	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
+		return;
+
+	if (fwrt->trans->dbg.yoyo_bin_loaded || (preset && preset != 1))
+		return;
+
+	iwl_trans_send_cmd(fwrt->trans, &hcmd);
+}
+IWL_EXPORT_SYMBOL(iwl_fw_disable_dbg_asserts);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 4227fbd2b977..66b233250c7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -329,6 +329,7 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt);
 void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
 				    u32 timepoint,
 				    u32 timepoint_data);
+void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt);
 
 #define IWL_FW_CHECK_FAILED(_obj, _fmt, ...)				\
 	IWL_ERR_LIMIT(_obj, _fmt, __VA_ARGS__)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index ef5baee6c9c5..b658cf228fbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -509,6 +509,8 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	if (res)
 		return;
 
+	trans->dbg.yoyo_bin_loaded = true;
+
 	iwl_dbg_tlv_parse_bin(trans, fw->data, fw->size);
 
 	release_firmware(fw);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index aa77cd4cc8d9..3d58a2b9518c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -839,6 +839,7 @@ struct iwl_pc_data {
  * @dump_file_name_ext_valid: dump file name extension if valid or not
  * @num_pc: number of program counter for cpu
  * @pc_data: details of the program counter
+ * @yoyo_bin_loaded: tells if a yoyo debug file has been loaded
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -880,6 +881,7 @@ struct iwl_trans_debug {
 	bool dump_file_name_ext_valid;
 	u32 num_pc;
 	struct iwl_pc_data *pc_data;
+	bool yoyo_bin_loaded;
 };
 
 struct iwl_dma_ptr {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1f5db65a088d..f682c9067abb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1527,6 +1527,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	/* FW loaded successfully */
 	mvm->pldr_sync = false;
 
+	iwl_fw_disable_dbg_asserts(&mvm->fwrt);
 	iwl_get_shared_mem_conf(&mvm->fwrt);
 
 	ret = iwl_mvm_sf_update(mvm, NULL, false);
-- 
2.38.1

