Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E784BFF7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfFSRmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 13:42:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54518 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728845AbfFSRmJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 13:42:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hdeb2-0002zq-74; Wed, 19 Jun 2019 20:42:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 2/6] iwlwifi: pcie: fix ALIVE interrupt handling for gen2 devices w/o MSI-X
Date:   Wed, 19 Jun 2019 20:41:55 +0300
Message-Id: <20190619174159.13927-3-luca@coelho.fi>
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

We added code to restock the buffer upon ALIVE interrupt
when MSI-X is disabled. This was added as part of the context
info code. This code was added only if the ISR debug level
is set which is very unlikely to be related.
Move this code to run even when the ISR debug level is not
set.

Note that gen2 devices work with MSI-X in most cases so that
this path is seldom used.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 34 +++++++++-----------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 31b3591f71d1..3df12b3f71a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1827,25 +1827,23 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		goto out;
 	}
 
-	if (iwl_have_debug_level(IWL_DL_ISR)) {
-		/* NIC fires this, but we don't use it, redundant with WAKEUP */
-		if (inta & CSR_INT_BIT_SCD) {
-			IWL_DEBUG_ISR(trans,
-				      "Scheduler finished to transmit the frame/frames.\n");
-			isr_stats->sch++;
-		}
+	/* NIC fires this, but we don't use it, redundant with WAKEUP */
+	if (inta & CSR_INT_BIT_SCD) {
+		IWL_DEBUG_ISR(trans,
+			      "Scheduler finished to transmit the frame/frames.\n");
+		isr_stats->sch++;
+	}
 
-		/* Alive notification via Rx interrupt will do the real work */
-		if (inta & CSR_INT_BIT_ALIVE) {
-			IWL_DEBUG_ISR(trans, "Alive interrupt\n");
-			isr_stats->alive++;
-			if (trans->cfg->gen2) {
-				/*
-				 * We can restock, since firmware configured
-				 * the RFH
-				 */
-				iwl_pcie_rxmq_restock(trans, trans_pcie->rxq);
-			}
+	/* Alive notification via Rx interrupt will do the real work */
+	if (inta & CSR_INT_BIT_ALIVE) {
+		IWL_DEBUG_ISR(trans, "Alive interrupt\n");
+		isr_stats->alive++;
+		if (trans->cfg->gen2) {
+			/*
+			 * We can restock, since firmware configured
+			 * the RFH
+			 */
+			iwl_pcie_rxmq_restock(trans, trans_pcie->rxq);
 		}
 	}
 
-- 
2.20.1

