Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E0318F59A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgCWNU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:20:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43480 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728521AbgCWNU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:20:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzZ-00023f-Jl; Mon, 23 Mar 2020 15:19:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:25 +0200
Message-Id: <iwlwifi.20200323151304.c8398a242e48.Ic01ce67db147e897ad2424f0e05a70a00d2c620e@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 14/14] iwlwifi: remove unnecessary cfg mangling for Qu C and QuZ with Jf
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Now that we identify the correct cfgs with the new tables for Qu step
C and QuZ with Jf, we can remove the mangling we do later on.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 139 +-----------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  13 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  25 +---
 3 files changed, 8 insertions(+), 169 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 76f2ee06d8f6..66f5df74a321 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -266,6 +266,11 @@ const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
 #define IWL_NUM_RBDS_22000_HE		2048
 #define IWL_NUM_RBDS_AX210_HE		4096
 
+/*
+ * All JF radio modules are part of the 9000 series, but the MAC part
+ * looks more like 22000.  That's why this device is here, but called
+ * 9560 nevertheless.
+ */
 const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg = {
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
@@ -436,127 +441,6 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-/*
- * All JF radio modules are part of the 9000 series, but the MAC part
- * looks more like 22000.  That's why this device is here, but called
- * 9560 nevertheless.
- */
-const struct iwl_cfg iwl9461_2ac_cfg_qu_b0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9461",
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9462_2ac_cfg_qu_b0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9462",
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_2ac_cfg_qu_b0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9560",
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_2ac_160_cfg_qu_b0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9461_2ac_cfg_qu_c0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9461",
-	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9462_2ac_cfg_qu_c0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9462",
-	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_2ac_cfg_qu_c0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9560",
-	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_2ac_160_cfg_qu_c0_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.integrated = true,
-	.trans.xtal_latency = 5000,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.integrated = true,
-	.trans.xtal_latency = 5000,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc = {
-	.name = "Intel(R) Dual Band Wireless AC 9461",
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.integrated = true,
-	.trans.xtal_latency = 5000,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc = {
-	.name = "Intel(R) Dual Band Wireless AC 9462",
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.integrated = true,
-	.trans.xtal_latency = 5000,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
 const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
 	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
 	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
@@ -609,19 +493,6 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl22000_2ax_cfg_jf = {
-	.name = "Intel(R) Dual Band Wireless AX 22000",
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
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
 const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0_f0 = {
 	.name = "Intel(R) Dual Band Wireless AX 22000",
 	.fw_name_pre = IWL_22000_HR_A_F0_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 2ecc94799e57..8549e8a39705 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -597,10 +597,6 @@ extern const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_qnj_b0_jf_b0_cfg;
-extern const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
-extern const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
-extern const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
-extern const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0;
@@ -618,15 +614,6 @@ extern const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
-extern const struct iwl_cfg iwl9461_2ac_cfg_qu_b0_jf_b0;
-extern const struct iwl_cfg iwl9462_2ac_cfg_qu_b0_jf_b0;
-extern const struct iwl_cfg iwl9560_2ac_cfg_qu_b0_jf_b0;
-extern const struct iwl_cfg iwl9560_2ac_160_cfg_qu_b0_jf_b0;
-extern const struct iwl_cfg iwl9461_2ac_cfg_qu_c0_jf_b0;
-extern const struct iwl_cfg iwl9462_2ac_cfg_qu_c0_jf_b0;
-extern const struct iwl_cfg iwl9560_2ac_cfg_qu_c0_jf_b0;
-extern const struct iwl_cfg iwl9560_2ac_160_cfg_qu_c0_jf_b0;
-extern const struct iwl_cfg iwl22000_2ax_cfg_jf;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0_f0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0_f0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7c228aa66a0f..ba4773e07bf2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1057,9 +1057,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR)) {
 			iwl_trans->cfg = &iwl_ax101_cfg_qu_hr;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
-			iwl_trans->cfg = &iwl22000_2ax_cfg_jf;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HRCDB)) {
 			IWL_ERR(iwl_trans, "RF ID HRCDB is not supported\n");
@@ -1085,23 +1082,15 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/*
 	 * This is a hack to switch from Qu B0 to Qu C0.  We need to
-	 * do this for all cfgs that use Qu B0.  All this code is in
-	 * urgent need for a refactor, but for now this is the easiest
-	 * thing to do to support Qu C-step.
+	 * do this for all cfgs that use Qu B0, except for those using
+	 * Jf, which have already been moved to the new table.  The
+	 * rest must be removed once we convert Qu with Hr as well.
 	 */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QU_C0) {
 		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
 		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9461_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9462_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
 		else if (iwl_trans->cfg == &killer1650s_2ax_cfg_qu_b0_hr_b0)
 			iwl_trans->cfg = &killer1650s_2ax_cfg_qu_c0_hr_b0;
 		else if (iwl_trans->cfg == &killer1650i_2ax_cfg_qu_b0_hr_b0)
@@ -1114,14 +1103,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			iwl_trans->cfg = &iwl_ax101_cfg_quz_hr;
 		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax201_cfg_quz_hr;
-		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
-		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 	}
 
 #endif
-- 
2.25.1

