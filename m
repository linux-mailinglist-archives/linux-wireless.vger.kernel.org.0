Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF43B97B0C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfHUNiO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:38:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37788 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728932AbfHUNiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:38:14 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0QoV-0000lZ-PG; Wed, 21 Aug 2019 16:38:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:50 +0300
Message-Id: <20190821133800.23636-9-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 08/18] iwlwifi: pcie: remove the refs / unrefs from the transport
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This code is now stale

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 14 -----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  9 ----
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 33 ------------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 31 +----------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 53 +++++--------------
 5 files changed, 15 insertions(+), 125 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 727f73e0b3f1..d47ba334c7ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -202,17 +202,3 @@ int iwl_cmd_groups_verify_sorted(const struct iwl_trans_config *trans)
 	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_cmd_groups_verify_sorted);
-
-void iwl_trans_ref(struct iwl_trans *trans)
-{
-	if (trans->ops->ref)
-		trans->ops->ref(trans);
-}
-IWL_EXPORT_SYMBOL(iwl_trans_ref);
-
-void iwl_trans_unref(struct iwl_trans *trans)
-{
-	if (trans->ops->unref)
-		trans->ops->unref(trans);
-}
-IWL_EXPORT_SYMBOL(iwl_trans_unref);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b50290a724ff..7c63706eb07b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -531,11 +531,6 @@ struct iwl_trans_rxq_dma_data {
  * @release_nic_access: let the NIC go to sleep. The "flags" parameter
  *	must be the same one that was sent before to the grab_nic_access.
  * @set_bits_mask - set SRAM register according to value and mask.
- * @ref: grab a reference to the transport/FW layers, disallowing
- *	certain low power states
- * @unref: release a reference previously taken with @ref. Note that
- *	initially the reference count is 1, making an initial @unref
- *	necessary to allow low power states.
  * @dump_data: return a vmalloc'ed buffer with debug data, maybe containing last
  *	TX'ed commands and similar. The buffer will be vfree'd by the caller.
  *	Note that the transport must fill in the proper file headers.
@@ -605,8 +600,6 @@ struct iwl_trans_ops {
 				   unsigned long *flags);
 	void (*set_bits_mask)(struct iwl_trans *trans, u32 reg, u32 mask,
 			      u32 value);
-	void (*ref)(struct iwl_trans *trans);
-	void (*unref)(struct iwl_trans *trans);
 	int  (*suspend)(struct iwl_trans *trans);
 	void (*resume)(struct iwl_trans *trans);
 
@@ -1254,8 +1247,6 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  const struct iwl_cfg *cfg,
 				  const struct iwl_trans_ops *ops);
 void iwl_trans_free(struct iwl_trans *trans);
-void iwl_trans_ref(struct iwl_trans *trans);
-void iwl_trans_unref(struct iwl_trans *trans);
 
 /*****************************************************
 * driver (transport) register/unregister functions
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8eaacf423d33..8d509ec0e113 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2360,37 +2360,6 @@ static void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
 	spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
 }
 
-static void iwl_trans_pcie_ref(struct iwl_trans *trans)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-
-	if (iwlwifi_mod_params.d0i3_disable)
-		return;
-
-	pm_runtime_get(&trans_pcie->pci_dev->dev);
-
-#ifdef CONFIG_PM
-	IWL_DEBUG_RPM(trans, "runtime usage count: %d\n",
-		      atomic_read(&trans_pcie->pci_dev->dev.power.usage_count));
-#endif /* CONFIG_PM */
-}
-
-static void iwl_trans_pcie_unref(struct iwl_trans *trans)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-
-	if (iwlwifi_mod_params.d0i3_disable)
-		return;
-
-	pm_runtime_mark_last_busy(&trans_pcie->pci_dev->dev);
-	pm_runtime_put_autosuspend(&trans_pcie->pci_dev->dev);
-
-#ifdef CONFIG_PM
-	IWL_DEBUG_RPM(trans, "runtime usage count: %d\n",
-		      atomic_read(&trans_pcie->pci_dev->dev.power.usage_count));
-#endif /* CONFIG_PM */
-}
-
 static const char *get_csr_string(int cmd)
 {
 #define IWL_CMD(x) case x: return #x
@@ -3335,8 +3304,6 @@ static void iwl_trans_pcie_resume(struct iwl_trans *trans)
 	.grab_nic_access = iwl_trans_pcie_grab_nic_access,		\
 	.release_nic_access = iwl_trans_pcie_release_nic_access,	\
 	.set_bits_mask = iwl_trans_pcie_set_bits_mask,			\
-	.ref = iwl_trans_pcie_ref,					\
-	.unref = iwl_trans_pcie_unref,					\
 	.dump_data = iwl_trans_pcie_dump_data,				\
 	.d3_suspend = iwl_trans_pcie_d3_suspend,			\
 	.d3_resume = iwl_trans_pcie_d3_resume,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 38d110338987..3a3ac81195dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -641,12 +641,8 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 				      iwl_pcie_gen2_get_num_tbs(trans, tfd));
 
 	/* start timer if queue currently empty */
-	if (txq->read_ptr == txq->write_ptr) {
-		if (txq->wd_timeout)
-			mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
-		IWL_DEBUG_RPM(trans, "Q: %d first tx - take ref\n", txq->id);
-		iwl_trans_ref(trans);
-	}
+	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
+		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
 
 	/* Tell device the write index *just past* this latest filled TFD */
 	txq->write_ptr = iwl_queue_inc_wrap(trans, txq->write_ptr);
@@ -891,12 +887,6 @@ static int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
 
 	spin_lock_irqsave(&trans_pcie->reg_lock, flags);
-	if (!(cmd->flags & CMD_SEND_IN_IDLE) &&
-	    !trans_pcie->ref_cmd_in_flight) {
-		trans_pcie->ref_cmd_in_flight = true;
-		IWL_DEBUG_RPM(trans, "set ref_cmd_in_flight - ref\n");
-		iwl_trans_ref(trans);
-	}
 	/* Increment and update queue's write index */
 	txq->write_ptr = iwl_queue_inc_wrap(trans, txq->write_ptr);
 	iwl_pcie_gen2_txq_inc_wr_ptr(trans, txq);
@@ -1064,23 +1054,6 @@ void iwl_pcie_gen2_txq_unmap(struct iwl_trans *trans, int txq_id)
 		}
 		iwl_pcie_gen2_free_tfd(trans, txq);
 		txq->read_ptr = iwl_queue_inc_wrap(trans, txq->read_ptr);
-
-		if (txq->read_ptr == txq->write_ptr) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&trans_pcie->reg_lock, flags);
-			if (txq_id != trans_pcie->cmd_queue) {
-				IWL_DEBUG_RPM(trans, "Q %d - last tx freed\n",
-					      txq->id);
-				iwl_trans_unref(trans);
-			} else if (trans_pcie->ref_cmd_in_flight) {
-				trans_pcie->ref_cmd_in_flight = false;
-				IWL_DEBUG_RPM(trans,
-					      "clear ref_cmd_in_flight\n");
-				iwl_trans_unref(trans);
-			}
-			spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
-		}
 	}
 
 	while (!skb_queue_empty(&txq->overflow_q)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index b25f51b5893c..45356195c228 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -639,12 +639,6 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 
 	lockdep_assert_held(&trans_pcie->reg_lock);
 
-	if (trans_pcie->ref_cmd_in_flight) {
-		trans_pcie->ref_cmd_in_flight = false;
-		IWL_DEBUG_RPM(trans, "clear ref_cmd_in_flight - unref\n");
-		iwl_trans_unref(trans);
-	}
-
 	if (!trans->cfg->base_params->apmg_wake_up_wa)
 		return;
 	if (WARN_ON(!trans_pcie->cmd_hold_nic_awake))
@@ -683,13 +677,8 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 			unsigned long flags;
 
 			spin_lock_irqsave(&trans_pcie->reg_lock, flags);
-			if (txq_id != trans_pcie->cmd_queue) {
-				IWL_DEBUG_RPM(trans, "Q %d - last tx freed\n",
-					      txq->id);
-				iwl_trans_unref(trans);
-			} else {
+			if (txq_id == trans_pcie->cmd_queue)
 				iwl_pcie_clear_cmd_in_flight(trans);
-			}
 			spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
 		}
 	}
@@ -1225,11 +1214,6 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		txq->overflow_tx = false;
 	}
 
-	if (txq->read_ptr == txq->write_ptr) {
-		IWL_DEBUG_RPM(trans, "Q %d - last tx reclaimed\n", txq->id);
-		iwl_trans_unref(trans);
-	}
-
 out:
 	spin_unlock_bh(&txq->lock);
 }
@@ -1261,13 +1245,6 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return -ENODEV;
 
-	if (!(cmd->flags & CMD_SEND_IN_IDLE) &&
-	    !trans_pcie->ref_cmd_in_flight) {
-		trans_pcie->ref_cmd_in_flight = true;
-		IWL_DEBUG_RPM(trans, "set ref_cmd_in_flight - ref\n");
-		iwl_trans_ref(trans);
-	}
-
 	/*
 	 * wake up the NIC to make sure that the firmware will see the host
 	 * command - we will let the NIC sleep once all the host commands
@@ -2518,22 +2495,18 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	wait_write_ptr = ieee80211_has_morefrags(fc);
 
 	/* start timer if queue currently empty */
-	if (txq->read_ptr == txq->write_ptr) {
-		if (txq->wd_timeout) {
-			/*
-			 * If the TXQ is active, then set the timer, if not,
-			 * set the timer in remainder so that the timer will
-			 * be armed with the right value when the station will
-			 * wake up.
-			 */
-			if (!txq->frozen)
-				mod_timer(&txq->stuck_timer,
-					  jiffies + txq->wd_timeout);
-			else
-				txq->frozen_expiry_remainder = txq->wd_timeout;
-		}
-		IWL_DEBUG_RPM(trans, "Q: %d first tx - take ref\n", txq->id);
-		iwl_trans_ref(trans);
+	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout) {
+		/*
+		 * If the TXQ is active, then set the timer, if not,
+		 * set the timer in remainder so that the timer will
+		 * be armed with the right value when the station will
+		 * wake up.
+		 */
+		if (!txq->frozen)
+			mod_timer(&txq->stuck_timer,
+				  jiffies + txq->wd_timeout);
+		else
+			txq->frozen_expiry_remainder = txq->wd_timeout;
 	}
 
 	/* Tell device the write index *just past* this latest filled TFD */
-- 
2.23.0.rc1

