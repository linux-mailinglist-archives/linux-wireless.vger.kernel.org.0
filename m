Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4234E909
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhC3NZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43636 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231966AbhC3NZL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMl-0007fg-HY; Tue, 30 Mar 2021 16:25:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:57 +0300
Message-Id: <iwlwifi.20210330162204.a1cdda2fa270.I02a82312679f4541f30bb8db8747a797dbb70ee7@changeid>
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
Subject: [PATCH 09/12] iwlwifi: pcie: clear only FH bits handle in the interrupt
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

For simplicity we assume that msix has 2 IRQ lines one used for rx data
called msix_non_share, and another used for one bit flags messages
(alive, hw error, sw error, rx data flag) called msix_share.

Every time the FW has data to send it puts it on the RX queue and HW
turns on the flags in msix_share (inta_fw) indicating about rx data,
and HW sends an interrupt a bit later to the msix_non_share _unless_
the msix_shared RX data bit was cleared.

Currently in the code every time we get an msix_shared we clear all bits
including rx data queue bits.

So we can have a race

----------------------------------------------------
DRIVER		       |   HW          	     |   FW
----------------------------------------------------
- send host cmd to FW  |		     |
		       |		     | - handle message
		       |		     |   and put a response
		       |		     |   on the RX queue
		       | - RX flag on        |
		       |	     	     | - send alive msix
		       | - alive flag on     |
		       | - interrupt         |
		       |   msix_share driver |
- handle msix_shared   |		     |
  and clear all flags  |		     |
  bits		       |		     |
		       | - don't send an     |
		       |   interrupt on	     |
		       |   msix_non_shared   |
		       |   (driver cleared)  |
- driver timeout on    |		     |
  waiting for host cmd |		     |
  respond	       |		     |
		       |		     |
----------------------------------------------------

The change is to clear only the msi_shared flags that are handled in
the msix_shared flow, which will cause the hardware to send an interrupt
on the msix_non_share line as well, when it has data.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h | 3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 6ccde7e30211..db312abd2e09 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -578,6 +578,9 @@ enum msix_fh_int_causes {
 	MSIX_FH_INT_CAUSES_FH_ERR		= BIT(21),
 };
 
+/* The low 16 bits are for rx data queue indication */
+#define MSIX_FH_INT_CAUSES_DATA_QUEUE 0xffff
+
 /*
  * Causes for the HW register interrupts
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 2bec97133119..0cbc79949982 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2194,9 +2194,16 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	struct iwl_trans_pcie *trans_pcie = iwl_pcie_get_trans_pcie(entry);
 	struct iwl_trans *trans = trans_pcie->trans;
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
+	u32 inta_fh_msk = ~MSIX_FH_INT_CAUSES_DATA_QUEUE;
 	u32 inta_fh, inta_hw;
 	bool polling = false;
 
+	if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX)
+		inta_fh_msk |= MSIX_FH_INT_CAUSES_Q0;
+
+	if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS)
+		inta_fh_msk |= MSIX_FH_INT_CAUSES_Q1;
+
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 
 	spin_lock_bh(&trans_pcie->irq_lock);
@@ -2205,7 +2212,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	/*
 	 * Clear causes registers to avoid being handling the same cause.
 	 */
-	iwl_write32(trans, CSR_MSIX_FH_INT_CAUSES_AD, inta_fh);
+	iwl_write32(trans, CSR_MSIX_FH_INT_CAUSES_AD, inta_fh & inta_fh_msk);
 	iwl_write32(trans, CSR_MSIX_HW_INT_CAUSES_AD, inta_hw);
 	spin_unlock_bh(&trans_pcie->irq_lock);
 
-- 
2.31.0

