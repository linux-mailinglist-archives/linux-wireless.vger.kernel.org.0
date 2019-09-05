Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1353AA43D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbfIENWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41070 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388580AbfIENWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:34 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5riZ-00062D-Ao; Thu, 05 Sep 2019 16:22:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:02 +0300
Message-Id: <20190905132220.23970-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 03/21] iwlwifi: pcie: move some cfg mangling from trans_pcie_alloc to probe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

There were a couple of special handling to find the correct cfg inside
iwl_trans_pcie_alloc().  Move them to iwl_pci_probe() so they're
together with the rest of the decisions.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 112 +++++++++++++-----
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  67 -----------
 2 files changed, 80 insertions(+), 99 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 63d9cc801e9b..7177061f79ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -72,6 +72,7 @@
 
 #include "iwl-trans.h"
 #include "iwl-drv.h"
+#include "iwl-prph.h"
 #include "internal.h"
 
 #define IWL_PCI_DEVICE(dev, subdev, cfg) \
@@ -1017,29 +1018,74 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else if (cfg == &iwl7265_n_cfg)
 		cfg_7265d = &iwl7265d_n_cfg;
 	if (cfg_7265d &&
-	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D) {
+	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
 		cfg = cfg_7265d;
-		iwl_trans->cfg = cfg_7265d;
-	}
 
-	if (iwl_trans->cfg->trans.rf_id && cfg == &iwl22000_2ac_cfg_hr_cdb &&
-	    iwl_trans->hw_rev != CSR_HW_REV_TYPE_HR_CDB) {
-		u32 rf_id_chp = CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id);
-		u32 jf_chp_id = CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF);
-		u32 hr_chp_id = CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR);
-
-		if (rf_id_chp == jf_chp_id) {
-			if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ)
-				cfg = &iwl9560_2ac_cfg_qnj_jf_b0;
-			else
-				cfg = &iwl22000_2ac_cfg_jf;
-		} else if (rf_id_chp == hr_chp_id) {
-			if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ)
-				cfg = &iwl22000_2ax_cfg_qnj_hr_a0;
-			else
-				cfg = &iwl22000_2ac_cfg_hr;
+	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
+
+	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
+		if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_TY) {
+			cfg = &iwlax210_2ax_cfg_ty_gf_a0;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
+			cfg = &iwlax210_2ax_cfg_so_jf_a0;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF)) {
+			cfg = &iwlax211_2ax_cfg_so_gf_a0;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF4)) {
+			cfg = &iwlax411_2ax_cfg_so_gf4_a0;
+		}
+	} else if (cfg == &iwl_ax101_cfg_qu_hr) {
+		if ((CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+		     CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
+		     iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) ||
+		    (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+		     CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR1))) {
+			cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
+		    iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
+			cfg = &iwl_ax101_cfg_quz_hr;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR)) {
+			cfg = &iwl_ax101_cfg_qu_hr;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
+			cfg = &iwl22000_2ax_cfg_jf;
+		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HRCDB)) {
+			IWL_ERR(iwl_trans, "RF ID HRCDB is not supported\n");
+			return -EINVAL;
+		} else {
+			IWL_ERR(iwl_trans, "Unrecognized RF ID 0x%08x\n",
+				CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id));
+			return -EINVAL;
+		}
+	} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
+		   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
+		   ((cfg != &iwl_ax200_cfg_cc &&
+		     cfg != &killer1650x_2ax_cfg &&
+		     cfg != &killer1650w_2ax_cfg &&
+		     cfg != &iwl_ax201_cfg_quz_hr) ||
+		    iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0)) {
+		u32 hw_status;
+
+		hw_status = iwl_read_prph(iwl_trans, UMAG_GEN_HW_STATUS);
+		if (CSR_HW_RF_STEP(iwl_trans->hw_rf_id) == SILICON_B_STEP)
+			/*
+			 * b step fw is the same for physical card and fpga
+			 */
+			cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
+		else if ((hw_status & UMAG_GEN_HW_IS_FPGA) &&
+			 CSR_HW_RF_STEP(iwl_trans->hw_rf_id) == SILICON_A_STEP) {
+			cfg = &iwl22000_2ax_cfg_qnj_hr_a0_f0;
+		} else {
+			/*
+			 * a step no FPGA
+			 */
+			cfg = &iwl22000_2ac_cfg_hr;
 		}
-		iwl_trans->cfg = cfg;
 	}
 
 	/*
@@ -1049,20 +1095,22 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * thing to do to support Qu C-step.
 	 */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QU_C0) {
-		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9461_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9462_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
+		if (cfg == &iwl_ax101_cfg_qu_hr)
+			cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
+		else if (cfg == &iwl_ax201_cfg_qu_hr)
+			cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
+		else if (cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
+			cfg = &iwl9461_2ac_cfg_qu_c0_jf_b0;
+		else if (cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
+			cfg = &iwl9462_2ac_cfg_qu_c0_jf_b0;
+		else if (cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
+			cfg = &iwl9560_2ac_cfg_qu_c0_jf_b0;
+		else if (cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
+			cfg = &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
 	}
 #endif
+	/* now set the real cfg we decided to use */
+	iwl_trans->cfg = cfg;
 
 	pci_set_drvdata(pdev, iwl_trans);
 	iwl_trans->drv = iwl_drv_start(iwl_trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8a95930e6c00..a1863b9bf1f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3521,73 +3521,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", trans->hw_rev);
 
-#if IS_ENABLED(CONFIG_IWLMVM)
-	trans->hw_rf_id = iwl_read32(trans, CSR_HW_RF_ID);
-
-	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
-		if (trans->hw_rev == CSR_HW_REV_TYPE_TY) {
-			trans->cfg = &iwlax210_2ax_cfg_ty_gf_a0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
-			trans->cfg = &iwlax210_2ax_cfg_so_jf_a0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF)) {
-			trans->cfg = &iwlax211_2ax_cfg_so_gf_a0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF4)) {
-			trans->cfg = &iwlax411_2ax_cfg_so_gf4_a0;
-		}
-	} else if (cfg == &iwl_ax101_cfg_qu_hr) {
-		if ((CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-		     CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		     trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) ||
-		    (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-		     CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR1))) {
-			trans->cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR)) {
-			trans->cfg = &iwl_ax101_cfg_qu_hr;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
-			trans->cfg = &iwl22000_2ax_cfg_jf;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HRCDB)) {
-			IWL_ERR(trans, "RF ID HRCDB is not supported\n");
-			ret = -EINVAL;
-			goto out_no_pci;
-		} else {
-			IWL_ERR(trans, "Unrecognized RF ID 0x%08x\n",
-				CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id));
-			ret = -EINVAL;
-			goto out_no_pci;
-		}
-	} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-		   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		   ((cfg != &iwl_ax200_cfg_cc &&
-		     cfg != &killer1650x_2ax_cfg &&
-		     cfg != &killer1650w_2ax_cfg &&
-		     cfg != &iwl_ax201_cfg_quz_hr) ||
-		    trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0)) {
-		u32 hw_status;
-
-		hw_status = iwl_read_prph(trans, UMAG_GEN_HW_STATUS);
-		if (CSR_HW_RF_STEP(trans->hw_rf_id) == SILICON_B_STEP)
-			/*
-			* b step fw is the same for physical card and fpga
-			*/
-			trans->cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
-		else if ((hw_status & UMAG_GEN_HW_IS_FPGA) &&
-			 CSR_HW_RF_STEP(trans->hw_rf_id) == SILICON_A_STEP) {
-			trans->cfg = &iwl22000_2ax_cfg_qnj_hr_a0_f0;
-		} else {
-			/*
-			* a step no FPGA
-			*/
-			trans->cfg = &iwl22000_2ac_cfg_hr;
-		}
-	}
-#endif
-
 	iwl_pcie_set_interrupt_capa(pdev, trans);
 	trans->hw_id = (pdev->device << 16) + pdev->subsystem_device;
 	snprintf(trans->hw_id_str, sizeof(trans->hw_id_str),
-- 
2.23.0.rc1

