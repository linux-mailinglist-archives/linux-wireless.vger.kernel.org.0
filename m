Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD7129BDF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfLWXrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:39 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54720 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726907AbfLWXrj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:39 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQH-00010j-AR; Tue, 24 Dec 2019 01:47:37 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:18 +0200
Message-Id: <20191223234721.1513938-5-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223234721.1513938-1-luca@coelho.fi>
References: <20191223234721.1513938-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 4/7] iwlwifi: pcie: always disable L0S states
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

L0S states have been found to be unstable with our devices and in
newer hardware they are not supported at all, so we must always set
the L0S_DISABLED bit.  Previously we were only disabling L0S states if
L1 was supported, because the assumption was that transitions from L0S
to L1 state was the problematic case.  But now we should never use
L0S, so do it regardless of whether L1 is supported or not.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2e599ba2f2ad..f60d66f1e55b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -302,18 +302,13 @@ void iwl_pcie_apm_config(struct iwl_trans *trans)
 	u16 cap;
 
 	/*
-	 * HW bug W/A for instability in PCIe bus L0S->L1 transition.
-	 * Check if BIOS (or OS) enabled L1-ASPM on this device.
-	 * If so (likely), disable L0S, so device moves directly L0->L1;
-	 *    costs negligible amount of power savings.
-	 * If not (unlikely), enable L0S, so there is at least some
-	 *    power savings, even without L1.
+	 * L0S states have been found to be unstable with our devices
+	 * and in newer hardware they are not officially supported at
+	 * all, so we must always set the L0S_DISABLED bit.
 	 */
+	iwl_set_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_DISABLED);
+
 	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_LNKCTL, &lctl);
-	if (lctl & PCI_EXP_LNKCTL_ASPM_L1)
-		iwl_set_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_DISABLED);
-	else
-		iwl_clear_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_DISABLED);
 	trans->pm_support = !(lctl & PCI_EXP_LNKCTL_ASPM_L0S);
 
 	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_DEVCTL2, &cap);
-- 
2.24.0

