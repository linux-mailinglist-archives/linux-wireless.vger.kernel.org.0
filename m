Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE6127B50
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTMvq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54110 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727269AbfLTMvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkr-0007lx-71; Fri, 20 Dec 2019 14:51:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:23 +0200
Message-Id: <20191220125124.1315679-11-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 10/11] iwlwifi: remove some outdated iwl22000 configurations
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

A few configuration structures were either not referenced anymore or
assigned to devices IDs that were not in use anymore.  Remove them.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 22 -------------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  6 -----
 3 files changed, 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index bd687e745dc9..1d3dc7cf4d63 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -247,28 +247,6 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 #define IWL_NUM_RBDS_22000_HE		2048
 #define IWL_NUM_RBDS_AX210_HE		4096
 
-const struct iwl_cfg iwl22000_2ac_cfg_hr = {
-	.name = "Intel(R) Dual Band Wireless AC 22000",
-	.fw_name_pre = IWL_22000_HR_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl22000_2ac_cfg_hr_cdb = {
-	.name = "Intel(R) Dual Band Wireless AC 22000",
-	.fw_name_pre = IWL_22000_HR_CDB_FW_PRE,
-	IWL_DEVICE_22500,
-	.cdb = true,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl22000_2ac_cfg_jf = {
-	.name = "Intel(R) Dual Band Wireless AC 22000",
-	.fw_name_pre = IWL_22000_JF_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
 const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX101",
 	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f8a93324d7c0..31a6f286f7f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -598,9 +598,6 @@ extern const struct iwl_cfg iwl9560_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_shared_clk;
 extern const struct iwl_cfg iwl9560_killer_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_shared_clk;
-extern const struct iwl_cfg iwl22000_2ac_cfg_hr;
-extern const struct iwl_cfg iwl22000_2ac_cfg_hr_cdb;
-extern const struct iwl_cfg iwl22000_2ac_cfg_jf;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index cdf112d6c0f9..bac3d3fa0dec 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -910,7 +910,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x0074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0078, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x007C, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0090, iwl22000_2ac_cfg_hr_cdb)},
 	{IWL_PCI_DEVICE(0x2720, 0x0244, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0310, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0A10, iwl_ax201_cfg_qu_hr)},
@@ -1083,11 +1082,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		else if ((hw_status & UMAG_GEN_HW_IS_FPGA) &&
 			 CSR_HW_RF_STEP(iwl_trans->hw_rf_id) == SILICON_A_STEP) {
 			cfg = &iwl22000_2ax_cfg_qnj_hr_a0_f0;
-		} else {
-			/*
-			 * a step no FPGA
-			 */
-			cfg = &iwl22000_2ac_cfg_hr;
 		}
 	}
 
-- 
2.24.0

