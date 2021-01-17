Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240052F9315
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbhAQOxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:40 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40754 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729042AbhAQOx3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:29 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Q0-003sgA-Hk; Sun, 17 Jan 2021 16:52:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:31 +0200
Message-Id: <iwlwifi.20210117164916.fde99af4e0f7.I4cab95919eb35cc5bfb26d32dcf5e15419d0e0ef@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 6/9] iwlwifi: tx: move handing sync/async host command to trans
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Handling host commands in a sync way is not directly related to PCIe
transport, and can serve as common logic for any transport, so move
it to trans layer.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   7 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   7 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 131 +---------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 148 +-----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 129 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |   1 +
 9 files changed, 150 insertions(+), 285 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index b3ed4fa1dac4..f0985453c80b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -102,6 +102,9 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 		return NULL;
 	}
 
+	/* Initialize the wait queue for commands */
+	init_waitqueue_head(&trans->wait_command_queue);
+
 	return trans;
 }
 
@@ -161,7 +164,7 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 	if (trans->wide_cmd_header && !iwl_cmd_groupid(cmd->id))
 		cmd->id = DEF_ID(cmd->id);
 
-	ret = trans->ops->send_cmd(trans, cmd);
+	ret = iwl_trans_txq_send_hcmd(trans, cmd);
 
 	if (!(cmd->flags & CMD_ASYNC))
 		lock_map_release(&trans->sync_cmd_lockdep_map);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 619cc9d69eac..3348d582a46c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -918,6 +918,7 @@ struct iwl_trans_txqs {
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
  * @wide_cmd_header: true when ucode supports wide command header format
+ * @wait_command_queue: wait queue for sync commands
  * @num_rx_queues: number of RX queues allocated by the transport;
  *	the transport must set this before calling iwl_drv_start()
  * @iml_len: the length of the image loader
@@ -961,6 +962,7 @@ struct iwl_trans {
 	int command_groups_size;
 	bool wide_cmd_header;
 
+	wait_queue_head_t wait_command_queue;
 	u8 num_rx_queues;
 
 	size_t iml_len;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index e70be7c0f3d2..d9688c7bed07 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -363,7 +363,6 @@ struct iwl_trans_pcie {
 	bool ucode_write_complete;
 	bool sx_complete;
 	wait_queue_head_t ucode_write_waitq;
-	wait_queue_head_t wait_command_queue;
 	wait_queue_head_t sx_waitq;
 
 	u8 def_rx_queue;
@@ -797,4 +796,8 @@ void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
 void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
 void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
 				  bool test, bool reset);
+int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
+			       struct iwl_host_cmd *cmd);
+int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
+			  struct iwl_host_cmd *cmd);
 #endif /* __iwl_trans_int_pcie_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index f7b0a35dcf98..e3e53419b526 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1676,7 +1676,6 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
  */
 static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
 	/* W/A for WiFi/WiMAX coex and WiMAX own the RF */
@@ -1688,7 +1687,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 			    APMG_PS_CTRL_VAL_RESET_REQ))) {
 		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
 		iwl_op_mode_wimax_active(trans->op_mode);
-		wake_up(&trans_pcie->wait_command_queue);
+		wake_up(&trans->wait_command_queue);
 		return;
 	}
 
@@ -1703,7 +1702,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 	iwl_trans_fw_error(trans);
 
 	clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-	wake_up(&trans_pcie->wait_command_queue);
+	wake_up(&trans->wait_command_queue);
 }
 
 static u32 iwl_pcie_int_cause_non_ict(struct iwl_trans *trans)
@@ -1818,7 +1817,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
 				       &trans->status))
 			IWL_DEBUG_RF_KILL(trans,
 					  "Rfkill while SYNC HCMD in flight\n");
-		wake_up(&trans_pcie->wait_command_queue);
+		wake_up(&trans->wait_command_queue);
 	} else {
 		clear_bit(STATUS_RFKILL_HW, &trans->status);
 		if (trans_pcie->opmode_down)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 9fd1e699292c..5897bda24810 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3337,7 +3337,7 @@ static const struct iwl_trans_ops trans_ops_pcie = {
 	.start_fw = iwl_trans_pcie_start_fw,
 	.stop_device = iwl_trans_pcie_stop_device,
 
-	.send_cmd = iwl_trans_pcie_send_hcmd,
+	.send_cmd = iwl_pcie_enqueue_hcmd,
 
 	.tx = iwl_trans_pcie_tx,
 	.reclaim = iwl_txq_reclaim,
@@ -3363,7 +3363,7 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.start_fw = iwl_trans_pcie_gen2_start_fw,
 	.stop_device = iwl_trans_pcie_gen2_stop_device,
 
-	.send_cmd = iwl_trans_pcie_gen2_send_hcmd,
+	.send_cmd = iwl_pcie_gen2_enqueue_hcmd,
 
 	.tx = iwl_txq_gen2_tx,
 	.reclaim = iwl_txq_reclaim,
@@ -3498,9 +3498,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	snprintf(trans->hw_id_str, sizeof(trans->hw_id_str),
 		 "PCI ID: 0x%04X:0x%04X", pdev->device, pdev->subsystem_device);
 
-	/* Initialize the wait queue for commands */
-	init_waitqueue_head(&trans_pcie->wait_command_queue);
-
 	init_waitqueue_head(&trans_pcie->sx_waitq);
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 2c741bc8a5c9..1099df7bc26f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -24,8 +24,8 @@
  * failed. On success, it returns the index (>= 0) of command in the
  * command queue.
  */
-static int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
-				      struct iwl_host_cmd *cmd)
+int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
+			       struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
@@ -257,130 +257,3 @@ static int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		kfree(dup_buf);
 	return idx;
 }
-
-#define HOST_COMPLETE_TIMEOUT	(2 * HZ)
-
-static int iwl_pcie_gen2_send_hcmd_sync(struct iwl_trans *trans,
-					struct iwl_host_cmd *cmd)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
-	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
-	int cmd_idx;
-	int ret;
-
-	IWL_DEBUG_INFO(trans, "Attempting to send sync command %s\n", cmd_str);
-
-	if (WARN(test_and_set_bit(STATUS_SYNC_HCMD_ACTIVE,
-				  &trans->status),
-		 "Command %s: a command is already active!\n", cmd_str))
-		return -EIO;
-
-	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n", cmd_str);
-
-	cmd_idx = iwl_pcie_gen2_enqueue_hcmd(trans, cmd);
-	if (cmd_idx < 0) {
-		ret = cmd_idx;
-		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-		IWL_ERR(trans, "Error sending %s: enqueue_hcmd failed: %d\n",
-			cmd_str, ret);
-		return ret;
-	}
-
-	ret = wait_event_timeout(trans_pcie->wait_command_queue,
-				 !test_bit(STATUS_SYNC_HCMD_ACTIVE,
-					   &trans->status),
-				 HOST_COMPLETE_TIMEOUT);
-	if (!ret) {
-		IWL_ERR(trans, "Error sending %s: time out after %dms.\n",
-			cmd_str, jiffies_to_msecs(HOST_COMPLETE_TIMEOUT));
-
-		IWL_ERR(trans, "Current CMD queue read_ptr %d write_ptr %d\n",
-			txq->read_ptr, txq->write_ptr);
-
-		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-		IWL_DEBUG_INFO(trans, "Clearing HCMD_ACTIVE for command %s\n",
-			       cmd_str);
-		ret = -ETIMEDOUT;
-
-		iwl_trans_sync_nmi(trans);
-		goto cancel;
-	}
-
-	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
-		IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
-		dump_stack();
-		ret = -EIO;
-		goto cancel;
-	}
-
-	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
-	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
-		IWL_DEBUG_RF_KILL(trans, "RFKILL in SYNC CMD... no rsp\n");
-		ret = -ERFKILL;
-		goto cancel;
-	}
-
-	if ((cmd->flags & CMD_WANT_SKB) && !cmd->resp_pkt) {
-		IWL_ERR(trans, "Error: Response NULL in '%s'\n", cmd_str);
-		ret = -EIO;
-		goto cancel;
-	}
-
-	return 0;
-
-cancel:
-	if (cmd->flags & CMD_WANT_SKB) {
-		/*
-		 * Cancel the CMD_WANT_SKB flag for the cmd in the
-		 * TX cmd queue. Otherwise in case the cmd comes
-		 * in later, it will possibly set an invalid
-		 * address (cmd->meta.source).
-		 */
-		txq->entries[cmd_idx].meta.flags &= ~CMD_WANT_SKB;
-	}
-
-	if (cmd->resp_pkt) {
-		iwl_free_resp(cmd);
-		cmd->resp_pkt = NULL;
-	}
-
-	return ret;
-}
-
-int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
-				  struct iwl_host_cmd *cmd)
-{
-	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
-	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
-		IWL_DEBUG_RF_KILL(trans, "Dropping CMD 0x%x: RF KILL\n",
-				  cmd->id);
-		return -ERFKILL;
-	}
-
-	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
-		     !(cmd->flags & CMD_SEND_IN_D3))) {
-		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
-		return -EHOSTDOWN;
-	}
-
-	if (cmd->flags & CMD_ASYNC) {
-		int ret;
-
-		/* An asynchronous command can not expect an SKB to be set. */
-		if (WARN_ON(cmd->flags & CMD_WANT_SKB))
-			return -EINVAL;
-
-		ret = iwl_pcie_gen2_enqueue_hcmd(trans, cmd);
-		if (ret < 0) {
-			IWL_ERR(trans,
-				"Error sending %s: enqueue_hcmd failed: %d\n",
-				iwl_get_cmd_string(trans, cmd->id), ret);
-			return ret;
-		}
-		return 0;
-	}
-
-	return iwl_pcie_gen2_send_hcmd_sync(trans, cmd);
-}
-
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 0de4c8239d7f..be2464fe0498 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -909,8 +909,8 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
  * failed. On success, it returns the index (>= 0) of command in the
  * command queue.
  */
-static int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
-				 struct iwl_host_cmd *cmd)
+int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
+			  struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
@@ -1244,7 +1244,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
 		IWL_DEBUG_INFO(trans, "Clearing HCMD_ACTIVE for command %s\n",
 			       iwl_get_cmd_string(trans, cmd_id));
-		wake_up(&trans_pcie->wait_command_queue);
+		wake_up(&trans->wait_command_queue);
 	}
 
 	meta->flags = 0;
@@ -1252,148 +1252,6 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	spin_unlock_bh(&txq->lock);
 }
 
-#define HOST_COMPLETE_TIMEOUT	(2 * HZ)
-
-static int iwl_pcie_send_hcmd_async(struct iwl_trans *trans,
-				    struct iwl_host_cmd *cmd)
-{
-	int ret;
-
-	/* An asynchronous command can not expect an SKB to be set. */
-	if (WARN_ON(cmd->flags & CMD_WANT_SKB))
-		return -EINVAL;
-
-	ret = iwl_pcie_enqueue_hcmd(trans, cmd);
-	if (ret < 0) {
-		IWL_ERR(trans,
-			"Error sending %s: enqueue_hcmd failed: %d\n",
-			iwl_get_cmd_string(trans, cmd->id), ret);
-		return ret;
-	}
-	return 0;
-}
-
-static int iwl_pcie_send_hcmd_sync(struct iwl_trans *trans,
-				   struct iwl_host_cmd *cmd)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
-	int cmd_idx;
-	int ret;
-
-	IWL_DEBUG_INFO(trans, "Attempting to send sync command %s\n",
-		       iwl_get_cmd_string(trans, cmd->id));
-
-	if (WARN(test_and_set_bit(STATUS_SYNC_HCMD_ACTIVE,
-				  &trans->status),
-		 "Command %s: a command is already active!\n",
-		 iwl_get_cmd_string(trans, cmd->id)))
-		return -EIO;
-
-	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n",
-		       iwl_get_cmd_string(trans, cmd->id));
-
-	cmd_idx = iwl_pcie_enqueue_hcmd(trans, cmd);
-	if (cmd_idx < 0) {
-		ret = cmd_idx;
-		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-		IWL_ERR(trans,
-			"Error sending %s: enqueue_hcmd failed: %d\n",
-			iwl_get_cmd_string(trans, cmd->id), ret);
-		return ret;
-	}
-
-	ret = wait_event_timeout(trans_pcie->wait_command_queue,
-				 !test_bit(STATUS_SYNC_HCMD_ACTIVE,
-					   &trans->status),
-				 HOST_COMPLETE_TIMEOUT);
-	if (!ret) {
-		IWL_ERR(trans, "Error sending %s: time out after %dms.\n",
-			iwl_get_cmd_string(trans, cmd->id),
-			jiffies_to_msecs(HOST_COMPLETE_TIMEOUT));
-
-		IWL_ERR(trans, "Current CMD queue read_ptr %d write_ptr %d\n",
-			txq->read_ptr, txq->write_ptr);
-
-		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-		IWL_DEBUG_INFO(trans, "Clearing HCMD_ACTIVE for command %s\n",
-			       iwl_get_cmd_string(trans, cmd->id));
-		ret = -ETIMEDOUT;
-
-		iwl_trans_sync_nmi(trans);
-		goto cancel;
-	}
-
-	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_trans_pcie_dump_regs(trans);
-		IWL_ERR(trans, "FW error in SYNC CMD %s\n",
-			iwl_get_cmd_string(trans, cmd->id));
-		dump_stack();
-		ret = -EIO;
-		goto cancel;
-	}
-
-	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
-	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
-		IWL_DEBUG_RF_KILL(trans, "RFKILL in SYNC CMD... no rsp\n");
-		ret = -ERFKILL;
-		goto cancel;
-	}
-
-	if ((cmd->flags & CMD_WANT_SKB) && !cmd->resp_pkt) {
-		IWL_ERR(trans, "Error: Response NULL in '%s'\n",
-			iwl_get_cmd_string(trans, cmd->id));
-		ret = -EIO;
-		goto cancel;
-	}
-
-	return 0;
-
-cancel:
-	if (cmd->flags & CMD_WANT_SKB) {
-		/*
-		 * Cancel the CMD_WANT_SKB flag for the cmd in the
-		 * TX cmd queue. Otherwise in case the cmd comes
-		 * in later, it will possibly set an invalid
-		 * address (cmd->meta.source).
-		 */
-		txq->entries[cmd_idx].meta.flags &= ~CMD_WANT_SKB;
-	}
-
-	if (cmd->resp_pkt) {
-		iwl_free_resp(cmd);
-		cmd->resp_pkt = NULL;
-	}
-
-	return ret;
-}
-
-int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
-{
-	/* Make sure the NIC is still alive in the bus */
-	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
-		return -ENODEV;
-
-	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
-	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
-		IWL_DEBUG_RF_KILL(trans, "Dropping CMD 0x%x: RF KILL\n",
-				  cmd->id);
-		return -ERFKILL;
-	}
-
-	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
-		     !(cmd->flags & CMD_SEND_IN_D3))) {
-		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
-		return -EHOSTDOWN;
-	}
-
-	if (cmd->flags & CMD_ASYNC)
-		return iwl_pcie_send_hcmd_async(trans, cmd);
-
-	/* We still can fail on RFKILL that can be asserted while we wait */
-	return iwl_pcie_send_hcmd_sync(trans, cmd);
-}
-
 static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 			     struct iwl_txq *txq, u8 hdr_len,
 			     struct iwl_cmd_meta *out_meta)
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 27eea909e32d..9421147974c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1725,3 +1725,132 @@ void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
 	}
 }
 
+#define HOST_COMPLETE_TIMEOUT	(2 * HZ)
+
+static int iwl_trans_txq_send_hcmd_sync(struct iwl_trans *trans,
+					struct iwl_host_cmd *cmd)
+{
+	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
+	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
+	int cmd_idx;
+	int ret;
+
+	IWL_DEBUG_INFO(trans, "Attempting to send sync command %s\n", cmd_str);
+
+	if (WARN(test_and_set_bit(STATUS_SYNC_HCMD_ACTIVE,
+				  &trans->status),
+		 "Command %s: a command is already active!\n", cmd_str))
+		return -EIO;
+
+	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n", cmd_str);
+
+	cmd_idx = trans->ops->send_cmd(trans, cmd);
+	if (cmd_idx < 0) {
+		ret = cmd_idx;
+		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
+		IWL_ERR(trans, "Error sending %s: enqueue_hcmd failed: %d\n",
+			cmd_str, ret);
+		return ret;
+	}
+
+	ret = wait_event_timeout(trans->wait_command_queue,
+				 !test_bit(STATUS_SYNC_HCMD_ACTIVE,
+					   &trans->status),
+				 HOST_COMPLETE_TIMEOUT);
+	if (!ret) {
+		IWL_ERR(trans, "Error sending %s: time out after %dms.\n",
+			cmd_str, jiffies_to_msecs(HOST_COMPLETE_TIMEOUT));
+
+		IWL_ERR(trans, "Current CMD queue read_ptr %d write_ptr %d\n",
+			txq->read_ptr, txq->write_ptr);
+
+		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
+		IWL_DEBUG_INFO(trans, "Clearing HCMD_ACTIVE for command %s\n",
+			       cmd_str);
+		ret = -ETIMEDOUT;
+
+		iwl_trans_sync_nmi(trans);
+		goto cancel;
+	}
+
+	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
+		IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
+		dump_stack();
+		ret = -EIO;
+		goto cancel;
+	}
+
+	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
+	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
+		IWL_DEBUG_RF_KILL(trans, "RFKILL in SYNC CMD... no rsp\n");
+		ret = -ERFKILL;
+		goto cancel;
+	}
+
+	if ((cmd->flags & CMD_WANT_SKB) && !cmd->resp_pkt) {
+		IWL_ERR(trans, "Error: Response NULL in '%s'\n", cmd_str);
+		ret = -EIO;
+		goto cancel;
+	}
+
+	return 0;
+
+cancel:
+	if (cmd->flags & CMD_WANT_SKB) {
+		/*
+		 * Cancel the CMD_WANT_SKB flag for the cmd in the
+		 * TX cmd queue. Otherwise in case the cmd comes
+		 * in later, it will possibly set an invalid
+		 * address (cmd->meta.source).
+		 */
+		txq->entries[cmd_idx].meta.flags &= ~CMD_WANT_SKB;
+	}
+
+	if (cmd->resp_pkt) {
+		iwl_free_resp(cmd);
+		cmd->resp_pkt = NULL;
+	}
+
+	return ret;
+}
+
+int iwl_trans_txq_send_hcmd(struct iwl_trans *trans,
+			    struct iwl_host_cmd *cmd)
+{
+	/* Make sure the NIC is still alive in the bus */
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return -ENODEV;
+
+	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
+	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
+		IWL_DEBUG_RF_KILL(trans, "Dropping CMD 0x%x: RF KILL\n",
+				  cmd->id);
+		return -ERFKILL;
+	}
+
+	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
+		     !(cmd->flags & CMD_SEND_IN_D3))) {
+		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
+		return -EHOSTDOWN;
+	}
+
+	if (cmd->flags & CMD_ASYNC) {
+		int ret;
+
+		/* An asynchronous command can not expect an SKB to be set. */
+		if (WARN_ON(cmd->flags & CMD_WANT_SKB))
+			return -EINVAL;
+
+		ret = trans->ops->send_cmd(trans, cmd);
+		if (ret < 0) {
+			IWL_ERR(trans,
+				"Error sending %s: enqueue_hcmd failed: %d\n",
+				iwl_get_cmd_string(trans, cmd->id), ret);
+			return ret;
+		}
+		return 0;
+	}
+
+	return iwl_trans_txq_send_hcmd_sync(trans, cmd);
+}
+
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index cff694c25ccc..af1dbdf5617a 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -181,4 +181,5 @@ void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
 				bool freeze);
 void iwl_txq_progress(struct iwl_txq *txq);
 void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq);
+int iwl_trans_txq_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
 #endif /* __iwl_trans_queue_tx_h__ */
-- 
2.29.2

