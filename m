Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8063C4BFF9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 19:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfFSRmL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 13:42:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54522 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729659AbfFSRmK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 13:42:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hdeb2-0002zq-O0; Wed, 19 Jun 2019 20:42:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 3/6] iwlwifi: fix RF-Kill interrupt while FW load for gen2 devices
Date:   Wed, 19 Jun 2019 20:41:56 +0300
Message-Id: <20190619174159.13927-4-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619174159.13927-1-luca@coelho.fi>
References: <20190619174159.13927-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Newest devices have a new firmware load mechanism. This
mechanism is called the context info. It means that the
driver doesn't need to load the sections of the firmware.
The driver rather prepares a place in DRAM, with pointers
to the relevant sections of the firmware, and the firmware
loads itself.
At the end of the process, the firmware sends the ALIVE
interrupt. This is different from the previous scheme in
which the driver expected the FH_TX interrupt after each
section being transferred over the DMA.

In order to support this new flow, we enabled all the
interrupts. This broke the assumption that we have in the
code that the RF-Kill interrupt can't interrupt the firmware
load flow.

Change the context info flow to enable only the ALIVE
interrupt, and re-enable all the other interrupts only
after the firmware is alive. Then, we won't see the RF-Kill
interrupt until then. Getting the RF-Kill interrupt while
loading the firmware made us kill the firmware while it is
loading and we ended up dumping garbage instead of the firmware
state.

Re-enable the ALIVE | RX interrupts from the ISR when we
get the ALIVE interrupt to be able to get the RX interrupt
that comes immediately afterwards for the ALIVE
notification. This is needed for non MSI-X only.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    | 27 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  5 ++++
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  9 +++++++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index f496d1bcb643..1719a5ff77a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -169,7 +169,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	memcpy(iml_img, trans->iml, trans->iml_len);
 
-	iwl_enable_interrupts(trans);
+	iwl_enable_fw_load_int_ctx_info(trans);
 
 	/* kick FW self load */
 	iwl_write64(trans, CSR_CTXT_INFO_ADDR,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 8969b47bacf2..d38cefbb779e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -222,7 +222,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	trans_pcie->ctxt_info = ctxt_info;
 
-	iwl_enable_interrupts(trans);
+	iwl_enable_fw_load_int_ctx_info(trans);
 
 	/* Configure debug, if exists */
 	if (iwl_pcie_dbg_on(trans))
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 85973dd57234..dcb3a3768cbd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -874,6 +874,33 @@ static inline void iwl_enable_fw_load_int(struct iwl_trans *trans)
 	}
 }
 
+static inline void iwl_enable_fw_load_int_ctx_info(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	IWL_DEBUG_ISR(trans, "Enabling ALIVE interrupt only\n");
+
+	if (!trans_pcie->msix_enabled) {
+		/*
+		 * When we'll receive the ALIVE interrupt, the ISR will call
+		 * iwl_enable_fw_load_int_ctx_info again to set the ALIVE
+		 * interrupt (which is not really needed anymore) but also the
+		 * RX interrupt which will allow us to receive the ALIVE
+		 * notification (which is Rx) and continue the flow.
+		 */
+		trans_pcie->inta_mask =  CSR_INT_BIT_ALIVE | CSR_INT_BIT_FH_RX;
+		iwl_write32(trans, CSR_INT_MASK, trans_pcie->inta_mask);
+	} else {
+		iwl_enable_hw_int_msk_msix(trans,
+					   MSIX_HW_INT_CAUSES_REG_ALIVE);
+		/*
+		 * Leave all the FH causes enabled to get the ALIVE
+		 * notification.
+		 */
+		iwl_enable_fh_int_msk_msix(trans, trans_pcie->fh_init_mask);
+	}
+}
+
 static inline u16 iwl_pcie_get_cmd_index(const struct iwl_txq *q, u32 index)
 {
 	return index & (q->n_window - 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 3df12b3f71a8..dcf891a4ce6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1845,6 +1845,8 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 			 */
 			iwl_pcie_rxmq_restock(trans, trans_pcie->rxq);
 		}
+
+		handled |= CSR_INT_BIT_ALIVE;
 	}
 
 	/* Safely ignore these bits for debug checks below */
@@ -1963,6 +1965,9 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	/* Re-enable RF_KILL if it occurred */
 	else if (handled & CSR_INT_BIT_RF_KILL)
 		iwl_enable_rfkill_int(trans);
+	/* Re-enable the ALIVE / Rx interrupt if it occurred */
+	else if (handled & (CSR_INT_BIT_ALIVE | CSR_INT_BIT_FH_RX))
+		iwl_enable_fw_load_int_ctx_info(trans);
 	spin_unlock(&trans_pcie->irq_lock);
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 8507a7bdcfdd..ea1d2bed502d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -273,6 +273,15 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	 * paging memory cannot be freed included since FW will still use it
 	 */
 	iwl_pcie_ctxt_info_free(trans);
+
+	/*
+	 * Re-enable all the interrupts, including the RF-Kill one, now that
+	 * the firmware is alive.
+	 */
+	iwl_enable_interrupts(trans);
+	mutex_lock(&trans_pcie->mutex);
+	iwl_pcie_check_hw_rf_kill(trans);
+	mutex_unlock(&trans_pcie->mutex);
 }
 
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
-- 
2.20.1

