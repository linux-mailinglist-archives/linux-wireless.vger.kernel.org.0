Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79D130EFB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgAFIzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51422 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgAFIzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:21 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAO-0007qa-CC; Mon, 06 Jan 2020 10:55:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:55:00 +0200
Message-Id: <20200106085502.363205-11-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 10/12] iwlwifi: assume the driver_data is a trans_cfg, but allow full cfg
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

With the new concept of separating the trans-specific (trans_cfg) data
from the rest of the cfg, we will start mapping only the trans_cfg
part to the PCI device ID/subsystem device ID.  So we can assume that
the data passed to the probe function contains the trans_cfg, but
since the full cfg still contains the trans_cfg at the beginning, we
can allow a full cfg to be passed as well.  This makes it easier to
convert the existing tables one by one.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 90 +++++++++++--------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 79c24c696c8f..5eb528d2111f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -991,21 +991,32 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	const struct iwl_cfg *cfg = (struct iwl_cfg *)(ent->driver_data);
+	const struct iwl_cfg_trans_params *trans =
+		(struct iwl_cfg_trans_params *)(ent->driver_data);
 	const struct iwl_cfg *cfg_7265d __maybe_unused = NULL;
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
 	unsigned long flags;
 	int ret;
+	/*
+	 * This is needed for backwards compatibility with the old
+	 * tables, so we don't need to change all the config structs
+	 * at the same time.  The cfg is used to compare with the old
+	 * full cfg structs.
+	 */
+	const struct iwl_cfg *cfg = (struct iwl_cfg *)(ent->driver_data);
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, &cfg->trans);
+	/* make sure trans is the first element in iwl_cfg */
+	BUILD_BUG_ON(offsetof(struct iwl_cfg, trans));
+
+	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, trans);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
 
 	/* the trans_cfg should never change, so set it now */
-	iwl_trans->trans_cfg = &cfg->trans;
+	iwl_trans->trans_cfg = trans;
 
 #if IS_ENABLED(CONFIG_IWLMVM)
 	/*
@@ -1023,22 +1034,22 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		cfg_7265d = &iwl7265d_n_cfg;
 	if (cfg_7265d &&
 	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
-		cfg = cfg_7265d;
+		iwl_trans->cfg = cfg_7265d;
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
 
 	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
 		if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_TY) {
-			cfg = &iwlax210_2ax_cfg_ty_gf_a0;
+			iwl_trans->cfg = &iwlax210_2ax_cfg_ty_gf_a0;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
-			cfg = &iwlax210_2ax_cfg_so_jf_a0;
+			iwl_trans->cfg = &iwlax210_2ax_cfg_so_jf_a0;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF)) {
-			cfg = &iwlax211_2ax_cfg_so_gf_a0;
+			iwl_trans->cfg = &iwlax211_2ax_cfg_so_gf_a0;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF4)) {
-			cfg = &iwlax411_2ax_cfg_so_gf4_a0;
+			iwl_trans->cfg = &iwlax411_2ax_cfg_so_gf4_a0;
 		}
 	} else if (cfg == &iwl_ax101_cfg_qu_hr) {
 		if ((CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
@@ -1046,13 +1057,17 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		     iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) ||
 		    (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 		     CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR1))) {
-			cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
+			iwl_trans->cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
+		    iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
+			iwl_trans->cfg = &iwl_ax101_cfg_quz_hr;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR)) {
-			cfg = &iwl_ax101_cfg_qu_hr;
+			iwl_trans->cfg = &iwl_ax101_cfg_qu_hr;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
-			cfg = &iwl22000_2ax_cfg_jf;
+			iwl_trans->cfg = &iwl22000_2ax_cfg_jf;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HRCDB)) {
 			IWL_ERR(iwl_trans, "RF ID HRCDB is not supported\n");
@@ -1069,14 +1084,11 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		hw_status = iwl_read_prph(iwl_trans, UMAG_GEN_HW_STATUS);
 		if (CSR_HW_RF_STEP(iwl_trans->hw_rf_id) == SILICON_B_STEP)
-			/*
-			 * b step fw is the same for physical card and fpga
-			 */
-			cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
+			iwl_trans->cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
 		else if ((hw_status & UMAG_GEN_HW_IS_FPGA) &&
-			 CSR_HW_RF_STEP(iwl_trans->hw_rf_id) == SILICON_A_STEP) {
-			cfg = &iwl22000_2ax_cfg_qnj_hr_a0_f0;
-		}
+			 CSR_HW_RF_STEP(iwl_trans->hw_rf_id) ==
+			 SILICON_A_STEP)
+			iwl_trans->cfg = &iwl22000_2ax_cfg_qnj_hr_a0_f0;
 	}
 
 	/*
@@ -1087,45 +1099,53 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QU_C0) {
 		if (cfg == &iwl_ax101_cfg_qu_hr)
-			cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
+			iwl_trans->cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
 		else if (cfg == &iwl_ax201_cfg_qu_hr)
-			cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
+			iwl_trans->cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
 		else if (cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9461_2ac_cfg_qu_c0_jf_b0;
+			iwl_trans->cfg = &iwl9461_2ac_cfg_qu_c0_jf_b0;
 		else if (cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9462_2ac_cfg_qu_c0_jf_b0;
+			iwl_trans->cfg = &iwl9462_2ac_cfg_qu_c0_jf_b0;
 		else if (cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
-			cfg = &iwl9560_2ac_cfg_qu_c0_jf_b0;
+			iwl_trans->cfg = &iwl9560_2ac_cfg_qu_c0_jf_b0;
 		else if (cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-			cfg = &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
+			iwl_trans->cfg = &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
+		else if (cfg == &killer1650s_2ax_cfg_qu_b0_hr_b0)
+			iwl_trans->cfg = &killer1650s_2ax_cfg_qu_c0_hr_b0;
+		else if (cfg == &killer1650i_2ax_cfg_qu_b0_hr_b0)
+			iwl_trans->cfg = &killer1650i_2ax_cfg_qu_c0_hr_b0;
 	}
 
 	/* same thing for QuZ... */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
-		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
+		if (cfg == &iwl_ax101_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax101_cfg_quz_hr;
-		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
+		else if (cfg == &iwl_ax201_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax201_cfg_quz_hr;
-		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
+		else if (cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
+		else if (cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
+		else if (cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
+		else if (cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
 			iwl_trans->cfg = &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 	}
 
 #endif
-	/* now set the real cfg we decided to use */
-	iwl_trans->cfg = cfg;
+	/*
+	 * If we didn't set the cfg yet, assume the trans is actually
+	 * a full cfg from the old tables.
+	 */
+	if (!iwl_trans->cfg)
+		iwl_trans->cfg = cfg;
 
-	if (cfg->trans.mq_rx_supported) {
-		if (WARN_ON(!cfg->num_rbds)) {
+	if (iwl_trans->trans_cfg->mq_rx_supported) {
+		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
 			ret = -EINVAL;
 			goto out_free_trans;
 		}
-		trans_pcie->num_rx_bufs = cfg->num_rbds;
+		trans_pcie->num_rx_bufs = iwl_trans->cfg->num_rbds;
 	} else {
 		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
 	}
-- 
2.24.1

