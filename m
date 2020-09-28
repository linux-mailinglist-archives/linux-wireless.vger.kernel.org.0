Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F927AAA8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgI1JXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52810 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726565AbgI1JXo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:44 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNb-002KgD-Qp; Mon, 28 Sep 2020 12:23:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:19 +0300
Message-Id: <iwlwifi.20200928121852.e6137861d917.I93405604eb503568688b28d3169fea7fbb88ed7e@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/12] iwlwifi: remove wide_cmd_header field
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Driver doesn't support fw without wide_cmd
so driver always sets it to true.  instead of setting
it always to true just remove the field.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c   | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c   | 5 -----
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index a99e0c5af512..073efce47e74 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -181,7 +181,7 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 	if (!(cmd->flags & CMD_ASYNC))
 		lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
 
-	if (trans->wide_cmd_header && !iwl_cmd_groupid(cmd->id))
+	if (!iwl_cmd_groupid(cmd->id))
 		cmd->id = DEF_ID(cmd->id);
 
 	ret = trans->ops->send_cmd(trans, cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 868e137c51f0..8fe720ac1c74 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -960,7 +960,6 @@ struct iwl_trans_txqs {
  * @hw_id_str: a string with info about HW ID. Set during transport allocation.
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
- * @wide_cmd_header: true when ucode supports wide command header format
  * @num_rx_queues: number of RX queues allocated by the transport;
  *	the transport must set this before calling iwl_drv_start()
  * @iml_len: the length of the image loader
@@ -1000,7 +999,6 @@ struct iwl_trans {
 
 	const struct iwl_hcmd_arr *command_groups;
 	int command_groups_size;
-	bool wide_cmd_header;
 
 	u8 num_rx_queues;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e184a163946a..5a6f0fe2fb90 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -757,7 +757,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		trans_cfg.rx_buf_size = rb_size_default;
 	}
 
-	trans->wide_cmd_header = true;
 	trans_cfg.bc_table_dword =
 		mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index e15939849a23..027b4e787ee6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1538,11 +1538,6 @@ static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
 	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
 
-	if (WARN(!trans->wide_cmd_header &&
-		 group_id > IWL_ALWAYS_LONG_GROUP,
-		 "unsupported wide command %#x\n", cmd->id))
-		return -EINVAL;
-
 	if (group_id != 0) {
 		copy_size = sizeof(struct iwl_cmd_header_wide);
 		cmd_size = sizeof(struct iwl_cmd_header_wide);
-- 
2.28.0

