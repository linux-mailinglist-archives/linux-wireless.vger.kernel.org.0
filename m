Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2601F34E901
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhC3NZm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43594 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232002AbhC3NZH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMf-0007fg-KL; Tue, 30 Mar 2021 16:25:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:50 +0300
Message-Id: <iwlwifi.20210330162204.1ab60af3f318.I51cc202f68a2a953223e70c3e8610343412961b6@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210330132500.468321-1-luca@coelho.fi>
References: <20210330132500.468321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: pcie: avoid unnecessarily taking spinlock
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Most devices don't set the apmg_wake_up_wa flag, so we don't do
anything for them. Avoid taking the spinlock for every command
unless the device needs this workaround.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 54 +++++++++-----------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 381e8f90b6f2..ac200e6e941e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -181,16 +181,20 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	lockdep_assert_held(&trans_pcie->reg_lock);
-
 	if (!trans->trans_cfg->base_params->apmg_wake_up_wa)
 		return;
-	if (WARN_ON(!trans_pcie->cmd_hold_nic_awake))
+
+	spin_lock(&trans_pcie->reg_lock);
+
+	if (WARN_ON(!trans_pcie->cmd_hold_nic_awake)) {
+		spin_unlock(&trans_pcie->reg_lock);
 		return;
+	}
 
 	trans_pcie->cmd_hold_nic_awake = false;
 	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
 				   CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	spin_unlock(&trans_pcie->reg_lock);
 }
 
 /*
@@ -198,7 +202,6 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
  */
 static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 
 	if (!txq) {
@@ -222,12 +225,9 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 		iwl_txq_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
 
-		if (txq->read_ptr == txq->write_ptr) {
-			spin_lock(&trans_pcie->reg_lock);
-			if (txq_id == trans->txqs.cmd.q_id)
-				iwl_pcie_clear_cmd_in_flight(trans);
-			spin_unlock(&trans_pcie->reg_lock);
-		}
+		if (txq->read_ptr == txq->write_ptr &&
+		    txq_id == trans->txqs.cmd.q_id)
+			iwl_pcie_clear_cmd_in_flight(trans);
 	}
 
 	while (!skb_queue_empty(&txq->overflow_q)) {
@@ -629,22 +629,23 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 				      const struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int ret;
-
-	lockdep_assert_held(&trans_pcie->reg_lock);
+	int ret = 0;
 
 	/* Make sure the NIC is still alive in the bus */
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return -ENODEV;
 
+	if (!trans->trans_cfg->base_params->apmg_wake_up_wa)
+		return 0;
+
+	spin_lock(&trans_pcie->reg_lock);
 	/*
 	 * wake up the NIC to make sure that the firmware will see the host
 	 * command - we will let the NIC sleep once all the host commands
 	 * returned. This needs to be done only on NICs that have
-	 * apmg_wake_up_wa set.
+	 * apmg_wake_up_wa set (see above.)
 	 */
-	if (trans->trans_cfg->base_params->apmg_wake_up_wa &&
-	    !trans_pcie->cmd_hold_nic_awake) {
+	if (!trans_pcie->cmd_hold_nic_awake) {
 		__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
 					 CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
@@ -657,12 +658,14 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 			__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
 					CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 			IWL_ERR(trans, "Failed to wake NIC for hcmd\n");
-			return -EIO;
+			ret = -EIO;
+		} else {
+			trans_pcie->cmd_hold_nic_awake = true;
 		}
-		trans_pcie->cmd_hold_nic_awake = true;
 	}
+	spin_unlock(&trans_pcie->reg_lock);
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -674,7 +677,6 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
  */
 static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	int nfreed = 0;
 	u16 r;
@@ -705,12 +707,8 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 		}
 	}
 
-	if (txq->read_ptr == txq->write_ptr) {
-		/* BHs are also disabled due to txq->lock */
-		spin_lock(&trans_pcie->reg_lock);
+	if (txq->read_ptr == txq->write_ptr)
 		iwl_pcie_clear_cmd_in_flight(trans);
-		spin_unlock(&trans_pcie->reg_lock);
-	}
 
 	iwl_txq_progress(txq);
 }
@@ -914,7 +912,6 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 			  struct iwl_host_cmd *cmd)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
@@ -1160,19 +1157,16 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
 		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
 
-	spin_lock(&trans_pcie->reg_lock);
 	ret = iwl_pcie_set_cmd_in_flight(trans, cmd);
 	if (ret < 0) {
 		idx = ret;
-		goto unlock_reg;
+		goto out;
 	}
 
 	/* Increment and update queue's write index */
 	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
 	iwl_pcie_txq_inc_wr_ptr(trans, txq);
 
- unlock_reg:
-	spin_unlock(&trans_pcie->reg_lock);
  out:
 	spin_unlock_bh(&txq->lock);
  free_dup_buf:
-- 
2.31.0

