Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386B8129BDE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLWXri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54712 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbfLWXri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:38 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQE-00010j-A5; Tue, 24 Dec 2019 01:47:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:17 +0200
Message-Id: <20191223234721.1513938-4-luca@coelho.fi>
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
Subject: [PATCH v5.5 3/7] iwlwifi: pcie: rename L0S_ENABLED bit to L0S_DISABLED
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This bit has been misnamed since the initial implementation of the
driver.  The correct semantics is that setting this bit disables L0S
states, and we already clearly use it as such in the code.  Rename it
to avoid confusion.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h    | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 92d9898ab7c2..c2f7252ae4e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -379,7 +379,7 @@ enum {
 
 
 /* CSR GIO */
-#define CSR_GIO_REG_VAL_L0S_ENABLED	(0x00000002)
+#define CSR_GIO_REG_VAL_L0S_DISABLED	(0x00000002)
 
 /*
  * UCODE-DRIVER GP (general purpose) mailbox register 1
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 91fa439d1255..2e599ba2f2ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -311,9 +311,9 @@ void iwl_pcie_apm_config(struct iwl_trans *trans)
 	 */
 	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_LNKCTL, &lctl);
 	if (lctl & PCI_EXP_LNKCTL_ASPM_L1)
-		iwl_set_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_ENABLED);
+		iwl_set_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_DISABLED);
 	else
-		iwl_clear_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_ENABLED);
+		iwl_clear_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_DISABLED);
 	trans->pm_support = !(lctl & PCI_EXP_LNKCTL_ASPM_L0S);
 
 	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_DEVCTL2, &cap);
-- 
2.24.0

