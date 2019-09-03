Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35B1A62A9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfICHh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:37:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40216 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbfICHh0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:37:26 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53NU-0004Cd-Sm; Tue, 03 Sep 2019 10:37:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:36:55 +0300
Message-Id: <20190903073714.32278-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 02/21] iwlwifi: pcie: use the cfg we passed to iwl_trans_pcie_alloc()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Instead of using iwl_trans->cfg in iwl_trans_pcie_alloc(), use the
local argument that we received.  This will allow us to not to set the
cfg during iwl_trans_alloc() so it can be decided later.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 567f613572d8..8a95930e6c00 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3481,7 +3481,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * "dash" value). To keep hw_rev backwards compatible - we'll store it
 	 * in the old format.
 	 */
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000) {
+	if (cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000) {
 		unsigned long flags;
 
 		trans->hw_rev = (trans->hw_rev & 0xfff0) |
@@ -3497,7 +3497,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		 * in-order to recognize C step driver should read chip version
 		 * id located at the AUX bus MISC address space.
 		 */
-		ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
+		ret = iwl_finish_nic_init(trans, &cfg->trans);
 		if (ret)
 			goto out_no_pci;
 
@@ -3524,7 +3524,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 #if IS_ENABLED(CONFIG_IWLMVM)
 	trans->hw_rf_id = iwl_read32(trans, CSR_HW_RF_ID);
 
-	if (trans->cfg == &iwlax210_2ax_cfg_so_hr_a0) {
+	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
 		if (trans->hw_rev == CSR_HW_REV_TYPE_TY) {
 			trans->cfg = &iwlax210_2ax_cfg_ty_gf_a0;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
@@ -3563,10 +3563,10 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
 		   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		   ((trans->cfg != &iwl_ax200_cfg_cc &&
-		     trans->cfg != &killer1650x_2ax_cfg &&
-		     trans->cfg != &killer1650w_2ax_cfg &&
-		     trans->cfg != &iwl_ax201_cfg_quz_hr) ||
+		   ((cfg != &iwl_ax200_cfg_cc &&
+		     cfg != &killer1650x_2ax_cfg &&
+		     cfg != &killer1650w_2ax_cfg &&
+		     cfg != &iwl_ax201_cfg_quz_hr) ||
 		    trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0)) {
 		u32 hw_status;
 
-- 
2.23.0.rc1

