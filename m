Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20BB31329D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhBHMn2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 07:43:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44352 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232447AbhBHMlj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 07:41:39 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l95qH-0047MN-Av; Mon, 08 Feb 2021 14:40:37 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  8 Feb 2021 14:40:24 +0200
Message-Id: <iwlwifi.20210208143712.e88a5107c588.I064c3e7823b616647293ed97da98edefb9ce9435@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208124034.1933780-1-luca@coelho.fi>
References: <20210208124034.1933780-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: pcie: don't disable interrupts for reg_lock
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The only thing we do touching the device in hard interrupt context
is, at most, writing an interrupt ACK register, which isn't racing
in with anything protected by the reg_lock.

Thus, avoid disabling interrupts here for potentially long periods
of time, particularly long periods have been observed with dumping
of firmware memory (leading to lockup warnings on some devices.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 11 +++++-----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  5 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 22 ++++++++-----------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 5897bda24810..54888df3d7f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1972,7 +1972,7 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	spin_lock_irqsave(&trans_pcie->reg_lock, *flags);
+	spin_lock_bh(&trans_pcie->reg_lock);
 
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
@@ -2057,7 +2057,7 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 		}
 
 err:
-		spin_unlock_irqrestore(&trans_pcie->reg_lock, *flags);
+		spin_unlock_bh(&trans_pcie->reg_lock);
 		return false;
 	}
 
@@ -2095,7 +2095,7 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans,
 	 * scheduled on different CPUs (after we drop reg_lock).
 	 */
 out:
-	spin_unlock_irqrestore(&trans_pcie->reg_lock, *flags);
+	spin_unlock_bh(&trans_pcie->reg_lock);
 }
 
 static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
@@ -2294,11 +2294,10 @@ static void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
 					 u32 mask, u32 value)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	unsigned long flags;
 
-	spin_lock_irqsave(&trans_pcie->reg_lock, flags);
+	spin_lock_bh(&trans_pcie->reg_lock);
 	__iwl_trans_pcie_set_bits_mask(trans, reg, mask, value);
-	spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
+	spin_unlock_bh(&trans_pcie->reg_lock);
 }
 
 static const char *get_csr_string(int cmd)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 1099df7bc26f..4456abb9a074 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -31,7 +31,6 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
-	unsigned long flags;
 	void *dup_buf = NULL;
 	dma_addr_t phys_addr;
 	int i, cmd_pos, idx;
@@ -244,11 +243,11 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
 		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
 
-	spin_lock_irqsave(&trans_pcie->reg_lock, flags);
+	spin_lock(&trans_pcie->reg_lock);
 	/* Increment and update queue's write index */
 	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
 	iwl_txq_inc_wr_ptr(trans, txq);
-	spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
+	spin_unlock(&trans_pcie->reg_lock);
 
 out:
 	spin_unlock_bh(&txq->lock);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index be2464fe0498..1293e584ccd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -218,12 +218,10 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
 
 		if (txq->read_ptr == txq->write_ptr) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&trans_pcie->reg_lock, flags);
+			spin_lock(&trans_pcie->reg_lock);
 			if (txq_id == trans->txqs.cmd.q_id)
 				iwl_pcie_clear_cmd_in_flight(trans);
-			spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
+			spin_unlock(&trans_pcie->reg_lock);
 		}
 	}
 
@@ -674,7 +672,6 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-	unsigned long flags;
 	int nfreed = 0;
 	u16 r;
 
@@ -705,9 +702,10 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 	}
 
 	if (txq->read_ptr == txq->write_ptr) {
-		spin_lock_irqsave(&trans_pcie->reg_lock, flags);
+		/* BHs are also disabled due to txq->lock */
+		spin_lock(&trans_pcie->reg_lock);
 		iwl_pcie_clear_cmd_in_flight(trans);
-		spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
+		spin_unlock(&trans_pcie->reg_lock);
 	}
 
 	iwl_txq_progress(txq);
@@ -916,7 +914,6 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
-	unsigned long flags;
 	void *dup_buf = NULL;
 	dma_addr_t phys_addr;
 	int idx;
@@ -1159,20 +1156,19 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
 		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
 
-	spin_lock_irqsave(&trans_pcie->reg_lock, flags);
+	spin_lock(&trans_pcie->reg_lock);
 	ret = iwl_pcie_set_cmd_in_flight(trans, cmd);
 	if (ret < 0) {
 		idx = ret;
-		spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
-		goto out;
+		goto unlock_reg;
 	}
 
 	/* Increment and update queue's write index */
 	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
 	iwl_pcie_txq_inc_wr_ptr(trans, txq);
 
-	spin_unlock_irqrestore(&trans_pcie->reg_lock, flags);
-
+ unlock_reg:
+	spin_unlock(&trans_pcie->reg_lock);
  out:
 	spin_unlock_bh(&txq->lock);
  free_dup_buf:
-- 
2.30.0

