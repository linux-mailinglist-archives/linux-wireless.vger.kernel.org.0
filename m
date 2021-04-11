Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6935B2E2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhDKJrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:47:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44468 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235368AbhDKJr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:47:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfu-000Jkq-HY; Sun, 11 Apr 2021 12:46:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:27 +0300
Message-Id: <iwlwifi.20210411124417.306e2e56d3e8.I72e2977abbb1fddf23b8476bedf6a183fe969ff5@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 09/12] iwlwifi: pcie: add ISR debug info for msix debug
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The debug prints help in case we get timeout on waiting for
hw.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    | 16 +++++++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  5 +++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index e4607f943ac3..fb8491412be4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1023,6 +1023,9 @@ static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
 
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
 
+	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
+		      rxq->id, ret, budget);
+
 	if (ret < budget) {
 		spin_lock(&trans_pcie->irq_lock);
 		if (test_bit(STATUS_INT_ENABLED, &trans->status))
@@ -1636,10 +1639,13 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	if (WARN_ON(entry->entry >= trans->num_rx_queues))
 		return IRQ_NONE;
 
-	if (WARN_ONCE(!rxq, "Got MSI-X interrupt before we have Rx queues"))
+	if (WARN_ONCE(!rxq,
+		      "[%d] Got MSI-X interrupt before we have Rx queues",
+		      entry->entry))
 		return IRQ_NONE;
 
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
+	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
 
 	local_bh_disable();
 	if (napi_schedule_prep(&rxq->napi))
@@ -2203,8 +2209,8 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	if (iwl_have_debug_level(IWL_DL_ISR)) {
 		IWL_DEBUG_ISR(trans,
-			      "ISR inta_fh 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
-			      inta_fh, trans_pcie->fh_mask,
+			      "ISR[%d] inta_fh 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			      entry->entry, inta_fh, trans_pcie->fh_mask,
 			      iwl_read32(trans, CSR_MSIX_FH_INT_MASK_AD));
 		if (inta_fh & ~trans_pcie->fh_mask)
 			IWL_DEBUG_ISR(trans,
@@ -2259,8 +2265,8 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	/* After checking FH register check HW register */
 	if (iwl_have_debug_level(IWL_DL_ISR)) {
 		IWL_DEBUG_ISR(trans,
-			      "ISR inta_hw 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
-			      inta_hw, trans_pcie->hw_mask,
+			      "ISR[%d] inta_hw 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			      entry->entry, inta_hw, trans_pcie->hw_mask,
 			      iwl_read32(trans, CSR_MSIX_HW_INT_MASK_AD));
 		if (inta_hw & ~trans_pcie->hw_mask)
 			IWL_DEBUG_ISR(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 1bf4c37fe960..861dbc03d183 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1604,6 +1604,11 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 	} else {
 		trans_pcie->trans->num_rx_queues = num_irqs - 1;
 	}
+
+	IWL_DEBUG_INFO(trans,
+		       "MSI-X enabled with rx queues %d, vec mask 0x%x\n",
+		       trans_pcie->trans->num_rx_queues, trans_pcie->shared_vec_mask);
+
 	WARN_ON(trans_pcie->trans->num_rx_queues > IWL_MAX_RX_HW_QUEUES);
 
 	trans_pcie->alloc_vecs = num_irqs;
-- 
2.31.0

