Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4782D0334
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgLFLIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 06:08:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34792 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgLFLIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 06:08:20 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klrt7-003AAN-Kk; Sun, 06 Dec 2020 13:07:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 13:07:22 +0200
Message-Id: <iwlwifi.20201206130357.acd85b500d0c.Ic7aee4dbbf4be42287c338c2fa1b111473724116@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206110729.488452-1-luca@coelho.fi>
References: <20201206110729.488452-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: pcie: remove MSIX_HW_INT_CAUSES_REG_IML handling
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is actually wrong, the bit used here by the image loader
is BIT(1), not BIT(2). The latter will be reused by the new
reset flow soon.

However, as we never had any complaints about not printing
the IML status or not handling the IML error interrupt (and
I suspect the code handling it was incorrectly anyway) just
remove the code for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    | 11 -----------
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  1 -
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index cb9e8e189a1a..185d00b16220 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -628,7 +628,7 @@ enum msix_fh_int_causes {
 enum msix_hw_int_causes {
 	MSIX_HW_INT_CAUSES_REG_ALIVE		= BIT(0),
 	MSIX_HW_INT_CAUSES_REG_WAKEUP		= BIT(1),
-	MSIX_HW_INT_CAUSES_REG_IML              = BIT(2),
+	MSIX_HW_INT_CAUSES_REG_IML              = BIT(1),
 	MSIX_HW_INT_CAUSES_REG_CT_KILL		= BIT(6),
 	MSIX_HW_INT_CAUSES_REG_RF_KILL		= BIT(7),
 	MSIX_HW_INT_CAUSES_REG_PERIODIC		= BIT(8),
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index ed200f541bfc..8ad58dced045 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2283,17 +2283,6 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		}
 	}
 
-	if (inta_hw & MSIX_HW_INT_CAUSES_REG_IML) {
-		/* Reflect IML transfer status */
-		int res = iwl_read32(trans, CSR_IML_RESP_ADDR);
-
-		IWL_DEBUG_ISR(trans, "IML transfer status: %d\n", res);
-		if (res == IWL_IMAGE_RESP_FAIL) {
-			isr_stats->sw++;
-			iwl_pcie_irq_handle_error(trans);
-		}
-	}
-
 	/* Chip got too hot and stopped itself */
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_CT_KILL) {
 		IWL_ERR(trans, "Microcode CT kill error detected.\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2ed7de7262df..11c42a0b7a85 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1103,7 +1103,6 @@ static struct iwl_causes_list causes_list[] = {
 	{MSIX_FH_INT_CAUSES_FH_ERR,		CSR_MSIX_FH_INT_MASK_AD, 0x5},
 	{MSIX_HW_INT_CAUSES_REG_ALIVE,		CSR_MSIX_HW_INT_MASK_AD, 0x10},
 	{MSIX_HW_INT_CAUSES_REG_WAKEUP,		CSR_MSIX_HW_INT_MASK_AD, 0x11},
-	{MSIX_HW_INT_CAUSES_REG_IML,            CSR_MSIX_HW_INT_MASK_AD, 0x12},
 	{MSIX_HW_INT_CAUSES_REG_CT_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x16},
 	{MSIX_HW_INT_CAUSES_REG_RF_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x17},
 	{MSIX_HW_INT_CAUSES_REG_PERIODIC,	CSR_MSIX_HW_INT_MASK_AD, 0x18},
-- 
2.29.2

