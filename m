Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806A6193F4F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgCZMzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44218 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728150AbgCZMzY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2c-00040Z-9G; Thu, 26 Mar 2020 14:55:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:55:03 +0200
Message-Id: <iwlwifi.20200326145047.c55e29a15c74.I190652101afcab682cfba873d062992f11efca32@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: remove support for QnJ HR FPGA
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We don't support the FPGA versions of this card combination anymore.
Remove the cfg mangling that tries to load it and all the relevant
structures.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 17 -----------------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 12 ------------
 3 files changed, 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index cafc322f01a4..a88aa15afc8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -76,7 +76,6 @@
 #define IWL_22000_JF_FW_PRE		"iwlwifi-Qu-a0-jf-b0-"
 #define IWL_22000_HR_FW_PRE		"iwlwifi-Qu-a0-hr-a0-"
 #define IWL_22000_HR_CDB_FW_PRE		"iwlwifi-QuIcp-z0-hrcdb-a0-"
-#define IWL_22000_HR_A_F0_FW_PRE	"iwlwifi-QuQnj-f0-hr-a0-"
 #define IWL_22000_QU_B_HR_B_FW_PRE	"iwlwifi-Qu-b0-hr-b0-"
 #define IWL_22000_HR_B_FW_PRE		"iwlwifi-QuQnj-b0-hr-b0-"
 #define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0-"
@@ -97,8 +96,6 @@
 	IWL_22000_HR_FW_PRE __stringify(api) ".ucode"
 #define IWL_22000_JF_MODULE_FIRMWARE(api) \
 	IWL_22000_JF_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_HR_A_F0_QNJ_MODULE_FIRMWARE(api) \
-	IWL_22000_HR_A_F0_FW_PRE __stringify(api) ".ucode"
 #define IWL_22000_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_22000_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_22000_HR_B_QNJ_MODULE_FIRMWARE(api)	\
@@ -502,19 +499,6 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0_f0 = {
-	.name = "Intel(R) Dual Band Wireless AX 22000",
-	.fw_name_pre = IWL_22000_HR_A_F0_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
 const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0 = {
 	.name = "Intel(R) Dual Band Wireless AX 22000",
 	.fw_name_pre = IWL_22000_HR_B_FW_PRE,
@@ -576,7 +560,6 @@ const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
 
 MODULE_FIRMWARE(IWL_22000_HR_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_JF_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_22000_HR_A_F0_QNJ_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_HR_B_QNJ_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 9a10bd593d95..d5d984d7ce83 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -617,7 +617,6 @@ extern const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
-extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0_f0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0_f0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d6735453849d..6744c0281ffb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1067,18 +1067,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id));
 			return -EINVAL;
 		}
-	} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-		   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		   iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) {
-		u32 hw_status;
-
-		hw_status = iwl_read_prph(iwl_trans, UMAG_GEN_HW_STATUS);
-		if (CSR_HW_RF_STEP(iwl_trans->hw_rf_id) == SILICON_B_STEP)
-			iwl_trans->cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
-		else if ((hw_status & UMAG_GEN_HW_IS_FPGA) &&
-			 CSR_HW_RF_STEP(iwl_trans->hw_rf_id) ==
-			 SILICON_A_STEP)
-			iwl_trans->cfg = &iwl22000_2ax_cfg_qnj_hr_a0_f0;
 	}
 
 	/*
-- 
2.25.1

