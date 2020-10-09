Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC562885E0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 11:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgJIJV3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 05:21:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:55074 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731262AbgJIJV2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 05:21:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQoab-002Rjn-IN; Fri, 09 Oct 2020 12:21:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, alexander@wetzel-home.de,
        andy.lavr@gmail.com
Date:   Fri,  9 Oct 2020 12:21:23 +0300
Message-Id: <iwlwifi.20201009122123.3e4ee0ad7a71.Id6d95ae601f048aeb4d2ed63a1712e469da84369@changeid>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH] Revert "iwlwifi: remove wide_cmd_header field"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This reverts commit 0a8159cbd11abf586693f1ec5264d0df587b71d8.

It turns out that this flag is used by iwldvm, so we can't get rid of
it.  This broke iwldvm devices with BAD_COMMAND errors.

Fixes: 0a8159cbd11a ("iwlwifi: remove wide_cmd_header field")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c   | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c   | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index a26da96763dd..becee92a5fd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -200,7 +200,7 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 	if (!(cmd->flags & CMD_ASYNC))
 		lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
 
-	if (!iwl_cmd_groupid(cmd->id))
+	if (trans->wide_cmd_header && !iwl_cmd_groupid(cmd->id))
 		cmd->id = DEF_ID(cmd->id);
 
 	ret = trans->ops->send_cmd(trans, cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b70294e9d07b..11a040e75bf3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -968,6 +968,7 @@ struct iwl_trans_txqs {
  * @hw_id_str: a string with info about HW ID. Set during transport allocation.
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
+ * @wide_cmd_header: true when ucode supports wide command header format
  * @num_rx_queues: number of RX queues allocated by the transport;
  *	the transport must set this before calling iwl_drv_start()
  * @iml_len: the length of the image loader
@@ -1009,6 +1010,7 @@ struct iwl_trans {
 
 	const struct iwl_hcmd_arr *command_groups;
 	int command_groups_size;
+	bool wide_cmd_header;
 
 	u8 num_rx_queues;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1e44a176b3d9..f1c5b3a9c26f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -761,6 +761,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		trans_cfg.rx_buf_size = rb_size_default;
 	}
 
+	trans->wide_cmd_header = true;
 	trans_cfg.bc_table_dword =
 		mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 8c89e4a2f7f8..966be5689d63 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1180,6 +1180,11 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
 	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
 
+	if (WARN(!trans->wide_cmd_header &&
+		 group_id > IWL_ALWAYS_LONG_GROUP,
+		 "unsupported wide command %#x\n", cmd->id))
+		return -EINVAL;
+
 	if (group_id != 0) {
 		copy_size = sizeof(struct iwl_cmd_header_wide);
 		cmd_size = sizeof(struct iwl_cmd_header_wide);
-- 
2.28.0

