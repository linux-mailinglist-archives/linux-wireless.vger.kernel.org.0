Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9756E7368BC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjFTKFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjFTKEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77169170D
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255475; x=1718791475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvMt9bxxuEBfFC3PmbqOmRGsrSJtHNXRRiG+nA5fU1g=;
  b=CR5eM7JetfeZSeAjBqi5S8nmoWT+5B2HuusCrTFp9qLUQnyuGuXNxtcP
   66Y0GsluZzfGmLCM2L0t1QT30U58EWBnoxhQa9PDyZpnsLkUq98R+eCtJ
   y1Z0QAm7iNBN2tkyJbJiRttmCg0KpMZ2txg68+DCMXBqmy54TfgDdRVaL
   IfJ17A4LUJBAov+/XeByaeyuIdOlbJHLI12MeAooktd0ot8WASexz7NLc
   XnqEezWOSgF+rno3aJeMbais+ojSWtQzJNFMZxPsijrc3DHlFh2aJl1Q9
   d/BUpmzOHDWnOuos6OrddIEgfeH1eT+ove93glE5+OKQMv0otn1yPz8ol
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819538"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838142989"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838142989"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/19] wifi: iwlwifi: fw: send marker cmd before suspend cmd
Date:   Tue, 20 Jun 2023 13:03:50 +0300
Message-Id: <20230620125813.9c84322c41b5.Id13816b3ece103f88514a7523b22bb2b9dcc8ab7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

This is needed to sync the times in the FW and driver logs

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 56 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  2 +
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 22 --------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  6 +-
 4 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3253d89e522a..3ab6a68f1e9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -3154,6 +3154,51 @@ static int iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 	return 0;
 }
 
+int iwl_fw_send_timestamp_marker_cmd(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_mvm_marker marker = {
+		.dw_len = sizeof(struct iwl_mvm_marker) / 4,
+		.marker_id = MARKER_ID_SYNC_CLOCK,
+	};
+	struct iwl_host_cmd hcmd = {
+		.flags = CMD_ASYNC,
+		.id = WIDE_ID(LONG_GROUP, MARKER_CMD),
+		.dataflags = {},
+	};
+	struct iwl_mvm_marker_rsp *resp;
+	int cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+					    WIDE_ID(LONG_GROUP, MARKER_CMD),
+					    IWL_FW_CMD_VER_UNKNOWN);
+	int ret;
+
+	if (cmd_ver == 1) {
+		/* the real timestamp is taken from the ftrace clock
+		 * this is for finding the match between fw and kernel logs
+		 */
+		marker.timestamp = cpu_to_le64(fwrt->timestamp.seq++);
+	} else if (cmd_ver == 2) {
+		marker.timestamp = cpu_to_le64(ktime_get_boottime_ns());
+	} else {
+		IWL_DEBUG_INFO(fwrt,
+			       "Invalid version of Marker CMD. Ver = %d\n",
+			       cmd_ver);
+		return -EINVAL;
+	}
+
+	hcmd.data[0] = &marker;
+	hcmd.len[0] = sizeof(marker);
+
+	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
+
+	if (cmd_ver > 1 && hcmd.resp_pkt) {
+		resp = (void *)hcmd.resp_pkt->data;
+		IWL_DEBUG_INFO(fwrt, "FW GP2 time: %u\n",
+			       le32_to_cpu(resp->gp2));
+	}
+
+	return ret;
+}
+
 void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 				       struct iwl_fw_dbg_params *params,
 				       bool stop)
@@ -3164,12 +3209,15 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_DBG_SUSPEND_RESUME_CMD_SUPP))
+			IWL_UCODE_TLV_CAPA_DBG_SUSPEND_RESUME_CMD_SUPP)) {
+		if (stop)
+			iwl_fw_send_timestamp_marker_cmd(fwrt);
 		ret = iwl_fw_dbg_suspend_resume_hcmd(fwrt->trans, stop);
-	else if (stop)
+	} else if (stop) {
 		iwl_fw_dbg_stop_recording(fwrt->trans, params);
-	else
+	} else {
 		ret = iwl_fw_dbg_restart_recording(fwrt->trans, params);
+	}
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	if (!ret) {
 		if (stop)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index dcba0eefe70d..4227fbd2b977 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -227,6 +227,8 @@ static inline void iwl_fw_flush_dumps(struct iwl_fw_runtime *fwrt)
 		flush_delayed_work(&fwrt->dump.wks[i].wk);
 }
 
+int iwl_fw_send_timestamp_marker_cmd(struct iwl_fw_runtime *fwrt);
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 static inline void iwl_fw_cancel_timestamp(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index ebacf0e9fb0f..3cdbc6ac7ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -123,28 +123,6 @@ static const struct file_operations iwl_dbgfs_##name##_ops = {		\
 #define FWRT_DEBUGFS_ADD_FILE(name, parent, mode) \
 	FWRT_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
 
-static int iwl_fw_send_timestamp_marker_cmd(struct iwl_fw_runtime *fwrt)
-{
-	struct iwl_mvm_marker marker = {
-		.dw_len = sizeof(struct iwl_mvm_marker) / 4,
-		.marker_id = MARKER_ID_SYNC_CLOCK,
-
-		/* the real timestamp is taken from the ftrace clock
-		 * this is for finding the match between fw and kernel logs
-		 */
-		.timestamp = cpu_to_le64(fwrt->timestamp.seq++),
-	};
-
-	struct iwl_host_cmd hcmd = {
-		.id = MARKER_CMD,
-		.flags = CMD_ASYNC,
-		.data[0] = &marker,
-		.len[0] = sizeof(marker),
-	};
-
-	return iwl_trans_send_cmd(fwrt->trans, &hcmd);
-}
-
 static int iwl_dbgfs_enabled_severities_write(struct iwl_fw_runtime *fwrt,
 					      char *buf, size_t count)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index df689a9b7e2c..702586945533 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #ifndef __iwl_fw_runtime_h__
 #define __iwl_fw_runtime_h__
@@ -146,12 +146,14 @@ struct iwl_fw_runtime {
 			u32 umac_minor;
 		} fw_ver;
 	} dump;
-#ifdef CONFIG_IWLWIFI_DEBUGFS
 	struct {
+#ifdef CONFIG_IWLWIFI_DEBUGFS
 		struct delayed_work wk;
 		u32 delay;
+#endif
 		u64 seq;
 	} timestamp;
+#ifdef CONFIG_IWLWIFI_DEBUGFS
 	bool tpc_enabled;
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
 #ifdef CONFIG_ACPI
-- 
2.38.1

