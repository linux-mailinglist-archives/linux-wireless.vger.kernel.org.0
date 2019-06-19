Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185AF4BFFA
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfFSRmM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 13:42:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54526 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726380AbfFSRmK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 13:42:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hdeb3-0002zq-7q; Wed, 19 Jun 2019 20:42:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4/6] iwlwifi: pcie: don't service an interrupt that was masked
Date:   Wed, 19 Jun 2019 20:41:57 +0300
Message-Id: <20190619174159.13927-5-luca@coelho.fi>
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

Sometimes the register status can include interrupts that
were masked. We can, for example, get the RF-Kill bit set
in the interrupt status register although this interrupt
was masked. Then if we get the ALIVE interrupt (for example)
that was not masked, we need to *not* service the RF-Kill
interrupt.
Fix this in the MSI-X interrupt handler.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 27 +++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index dcf891a4ce6e..e5220905dff1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2111,10 +2111,18 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (iwl_have_debug_level(IWL_DL_ISR))
-		IWL_DEBUG_ISR(trans, "ISR inta_fh 0x%08x, enabled 0x%08x\n",
-			      inta_fh,
+	if (iwl_have_debug_level(IWL_DL_ISR)) {
+		IWL_DEBUG_ISR(trans,
+			      "ISR inta_fh 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			      inta_fh, trans_pcie->fh_mask,
 			      iwl_read32(trans, CSR_MSIX_FH_INT_MASK_AD));
+		if (inta_fh & ~trans_pcie->fh_mask)
+			IWL_DEBUG_ISR(trans,
+				      "We got a masked interrupt (0x%08x)\n",
+				      inta_fh & ~trans_pcie->fh_mask);
+	}
+
+	inta_fh &= trans_pcie->fh_mask;
 
 	if ((trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX) &&
 	    inta_fh & MSIX_FH_INT_CAUSES_Q0) {
@@ -2154,11 +2162,18 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	}
 
 	/* After checking FH register check HW register */
-	if (iwl_have_debug_level(IWL_DL_ISR))
+	if (iwl_have_debug_level(IWL_DL_ISR)) {
 		IWL_DEBUG_ISR(trans,
-			      "ISR inta_hw 0x%08x, enabled 0x%08x\n",
-			      inta_hw,
+			      "ISR inta_hw 0x%08x, enabled (sw) 0x%08x (hw) 0x%08x\n",
+			      inta_hw, trans_pcie->hw_mask,
 			      iwl_read32(trans, CSR_MSIX_HW_INT_MASK_AD));
+		if (inta_hw & ~trans_pcie->hw_mask)
+			IWL_DEBUG_ISR(trans,
+				      "We got a masked interrupt 0x%08x\n",
+				      inta_hw & ~trans_pcie->hw_mask);
+	}
+
+	inta_hw &= trans_pcie->hw_mask;
 
 	/* Alive notification via Rx interrupt will do the real work */
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_ALIVE) {
-- 
2.20.1

