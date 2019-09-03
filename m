Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBCA62AC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfICHhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:37:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40234 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727999AbfICHh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:37:29 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53NX-0004Cd-6Y; Tue, 03 Sep 2019 10:37:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:36:58 +0300
Message-Id: <20190903073714.32278-6-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 05/21] iwlwifi: pass the iwl_config_trans_params when needed
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Instead of accessing the iwl_config_trans_params from the cfg that is
stored in the trans struct, pass this structure directly to functions
that need it during trans_alloc.  This will be useful to isolate the
elements needed during allocation and pass them separately before the
actual cfg struct is known.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c    |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/internal.h   |  7 ++++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c  | 16 ++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5ecfc27a4d25..11e1c2b363bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1000,7 +1000,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (WARN_ONCE(!cfg->trans.csr, "CSR addresses aren't configured\n"))
 		return -EINVAL;
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, cfg);
+	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, &cfg->trans);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 53999ea7bb04..eba9660a2bc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -635,9 +635,10 @@ iwl_trans_pcie_get_trans(struct iwl_trans_pcie *trans_pcie)
  * Convention: trans API functions: iwl_trans_pcie_XXX
  *	Other functions: iwl_pcie_XXX
  */
-struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
-				       const struct pci_device_id *ent,
-				       const struct iwl_cfg *cfg);
+struct iwl_trans
+*iwl_trans_pcie_alloc(struct pci_dev *pdev,
+		      const struct pci_device_id *ent,
+		      const struct iwl_cfg_trans_params *cfg_trans);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
 
 /*****************************************************
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c602e4914424..e196e3b87574 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3373,8 +3373,8 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 };
 
 struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
-				       const struct pci_device_id *ent,
-				       const struct iwl_cfg *cfg)
+			       const struct pci_device_id *ent,
+			       const struct iwl_cfg_trans_params *cfg_trans)
 {
 	struct iwl_trans_pcie *trans_pcie;
 	struct iwl_trans *trans;
@@ -3384,7 +3384,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (cfg->trans.gen2)
+	if (cfg_trans->gen2)
 		trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie),
 					&pdev->dev, &trans_ops_pcie_gen2);
 	else
@@ -3409,7 +3409,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	}
 	trans_pcie->debug_rfkill = -1;
 
-	if (!cfg->trans.base_params->pcie_l1_allowed) {
+	if (!cfg_trans->base_params->pcie_l1_allowed) {
 		/*
 		 * W/A - seems to solve weird behavior. We need to remove this
 		 * if we don't want to stay in L1 all the time. This wastes a
@@ -3422,7 +3422,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie->def_rx_queue = 0;
 
-	if (cfg->trans.use_tfh) {
+	if (cfg_trans->use_tfh) {
 		addr_size = 64;
 		trans_pcie->max_tbs = IWL_TFH_NUM_TBS;
 		trans_pcie->tfd_size = sizeof(struct iwl_tfh_tfd);
@@ -3484,7 +3484,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * "dash" value). To keep hw_rev backwards compatible - we'll store it
 	 * in the old format.
 	 */
-	if (cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000) {
+	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_8000) {
 		trans->hw_rev = (trans->hw_rev & 0xfff0) |
 				(CSR_HW_REV_STEP(trans->hw_rev << 2) << 2);
 
@@ -3498,7 +3498,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		 * in-order to recognize C step driver should read chip version
 		 * id located at the AUX bus MISC address space.
 		 */
-		ret = iwl_finish_nic_init(trans, &cfg->trans);
+		ret = iwl_finish_nic_init(trans, cfg_trans);
 		if (ret)
 			goto out_no_pci;
 
@@ -3506,7 +3506,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", trans->hw_rev);
 
-	iwl_pcie_set_interrupt_capa(pdev, trans, &cfg->trans);
+	iwl_pcie_set_interrupt_capa(pdev, trans, cfg_trans);
 	trans->hw_id = (pdev->device << 16) + pdev->subsystem_device;
 	snprintf(trans->hw_id_str, sizeof(trans->hw_id_str),
 		 "PCI ID: 0x%04X:0x%04X", pdev->device, pdev->subsystem_device);
-- 
2.23.0.rc1

