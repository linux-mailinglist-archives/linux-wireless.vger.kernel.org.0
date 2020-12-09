Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3476E2D4CC0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbgLIVVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:21:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35766 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733299AbgLIVVl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:21:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pc-003Drx-Cz; Wed, 09 Dec 2020 23:17:04 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:17 +0200
Message-Id: <iwlwifi.20201209231352.a9dba2daca59.I2b18bccf0d409f1517c3e2841b667014f9dafc24@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 13/47] iwlwifi: enable sending/setting debug host event
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This is used for BT node and for any user that wants to
control what events would be send from FW to the driver.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 14 +++++++++
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 29 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 94b1a1268476..48d7c8485e3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -78,6 +78,12 @@ enum iwl_debug_cmds {
 	 * &struct iwl_dbg_mem_access_rsp
 	 */
 	UMAC_RD_WR = 0x1,
+	/**
+	 * @HOST_EVENT_CFG:
+	 * updates the enabled event severities
+	 * &struct iwl_dbg_host_event_cfg_cmd
+	 */
+	HOST_EVENT_CFG = 0x3,
 	/**
 	 * @DBGC_SUSPEND_RESUME:
 	 * DBGC suspend/resume commad. Uses a single dword as data:
@@ -395,4 +401,12 @@ struct iwl_buf_alloc_cmd {
 	struct iwl_buf_alloc_frag frags[BUF_ALLOC_MAX_NUM_FRAGS];
 } __packed; /* BUFFER_ALLOCATION_CMD_API_S_VER_2 */
 
+/**
+ * struct iwl_dbg_host_event_cfg_cmd
+ * @enabled_severities: enabled severities
+ */
+struct iwl_dbg_host_event_cfg_cmd {
+	__le32 enabled_severities;
+} __packed; /* DEBUG_HOST_EVENT_CFG_CMD_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_debug_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 267ad4eddb5c..ce1186068f2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -200,6 +200,34 @@ static int iwl_fw_send_timestamp_marker_cmd(struct iwl_fw_runtime *fwrt)
 	return iwl_trans_send_cmd(fwrt->trans, &hcmd);
 }
 
+static int iwl_dbgfs_enabled_severities_write(struct iwl_fw_runtime *fwrt,
+					      char *buf, size_t count)
+{
+	struct iwl_dbg_host_event_cfg_cmd event_cfg;
+	struct iwl_host_cmd hcmd = {
+		.id = iwl_cmd_id(HOST_EVENT_CFG, DEBUG_GROUP, 0),
+		.flags = CMD_ASYNC,
+		.data[0] = &event_cfg,
+		.len[0] = sizeof(event_cfg),
+	};
+	u32 enabled_severities;
+	int ret = kstrtou32(buf, 10, &enabled_severities);
+
+	if (ret < 0)
+		return ret;
+
+	event_cfg.enabled_severities = cpu_to_le32(enabled_severities);
+
+	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
+	IWL_INFO(fwrt,
+		 "sent host event cfg with enabled_severities: %u, ret: %d\n",
+		 enabled_severities, ret);
+
+	return ret ?: count;
+}
+
+FWRT_DEBUGFS_WRITE_FILE_OPS(enabled_severities, 16);
+
 static void iwl_fw_timestamp_marker_wk(struct work_struct *work)
 {
 	int ret;
@@ -431,5 +459,6 @@ void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
 	FWRT_DEBUGFS_ADD_FILE(timestamp_marker, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(fw_info, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(send_hcmd, dbgfs_dir, 0200);
+	FWRT_DEBUGFS_ADD_FILE(enabled_severities, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(fw_dbg_domain, dbgfs_dir, 0400);
 }
-- 
2.29.2

