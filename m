Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76270457D4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFNItB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 04:49:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54486 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726255AbfFNItB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 04:49:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hbhtK-00081c-DT; Fri, 14 Jun 2019 11:48:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 1/3] iwlwifi: add new cards for 22000 and fix struct name
Date:   Fri, 14 Jun 2019 11:48:49 +0300
Message-Id: <20190614084852.386-2-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614084852.386-1-luca@coelho.fi>
References: <20190614084852.386-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

add few PCI ID'S for 22000 and fix the wrong name for one
of the structs

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 20 ++++++++++++----
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 23 +++++++++++++------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  4 ++--
 4 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index a9c846c59289..650ca46efc48 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -241,6 +241,18 @@ const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 };
 
+const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
+	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
+	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+};
+
 const struct iwl_cfg iwl_ax101_cfg_quz_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX101",
 	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
@@ -424,12 +436,12 @@ const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0 = {
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
+	.name = "Intel(R) Wi-Fi 7 AX210 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
 };
 
-const struct iwl_cfg iwlax210_2ax_cfg_so_gf_a0 = {
+const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 	.name = "Intel(R) Wi-Fi 7 AX211 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
@@ -443,8 +455,8 @@ const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 	IWL_DEVICE_AX210,
 };
 
-const struct iwl_cfg iwlax210_2ax_cfg_so_gf4_a0 = {
-	.name = "Intel(R) Wi-Fi 7 AX210 160MHz",
+const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
+	.name = "Intel(R) Wi-Fi 7 AX411 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_GF4_A_FW_PRE,
 	IWL_DEVICE_AX210,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f3e69edf8907..29aaf649c13c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -562,6 +562,7 @@ extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
 extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
 extern const struct iwl_cfg iwl22000_2ax_cfg_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
+extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
 extern const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
@@ -580,9 +581,9 @@ extern const struct iwl_cfg iwl9560_2ac_cfg_qnj_jf_b0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0;
-extern const struct iwl_cfg iwlax210_2ax_cfg_so_gf_a0;
+extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
-extern const struct iwl_cfg iwlax210_2ax_cfg_so_gf4_a0;
+extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
 #endif /* CPTCFG_IWLMVM || CPTCFG_IWLFMAC */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index cd035061cdd5..2f3ee5769fdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -897,6 +897,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x02F0, 0x0310, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x02F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x02F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x02F0, 0x4070, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0070, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x06F0, 0x0074, iwl_ax101_cfg_qu_hr)},
@@ -905,6 +906,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, 0x0310, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x06F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x06F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
+	{IWL_PCI_DEVICE(0x06F0, 0x2074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x06F0, 0x4070, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0000, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x0040, iwl_ax101_cfg_qu_hr)},
@@ -918,6 +920,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x1080, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x2074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x2720, 0x4070, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0040, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0070, iwl_ax101_cfg_qu_hr)},
@@ -927,6 +930,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x34F0, 0x0310, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x34F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
+	{IWL_PCI_DEVICE(0x34F0, 0x2074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x34F0, 0x4070, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0040, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x43F0, 0x0070, iwl_ax101_cfg_qu_hr)},
@@ -935,6 +939,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x43F0, 0x007C, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
+	{IWL_PCI_DEVICE(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0x43F0, 0x4070, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0000, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x0040, iwl_ax101_cfg_qu_hr)},
@@ -946,6 +951,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xA0F0, 0x0A10, iwl_ax101_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
+	{IWL_PCI_DEVICE(0xA0F0, 0x2074, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x4070, iwl_ax101_cfg_qu_hr)},
 
 	{IWL_PCI_DEVICE(0x2723, 0x0080, iwl_ax200_cfg_cc)},
@@ -958,13 +964,16 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2723, 0x4080, iwl_ax200_cfg_cc)},
 	{IWL_PCI_DEVICE(0x2723, 0x4088, iwl_ax200_cfg_cc)},
 
-	{IWL_PCI_DEVICE(0x2725, 0x0090, iwlax210_2ax_cfg_so_hr_a0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0090, iwlax210_2ax_cfg_so_hr_a0)},
-	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax210_2ax_cfg_so_hr_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_so_hr_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_so_hr_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x0A10, iwlax210_2ax_cfg_so_hr_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x00B0, iwlax210_2ax_cfg_so_hr_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x0510, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x0A10, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
 
 #endif /* CONFIG_IWLMVM */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index dfa1bed124aa..fc0c2551e66d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3569,10 +3569,10 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 			trans->cfg = &iwlax210_2ax_cfg_so_jf_a0;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF)) {
-			trans->cfg = &iwlax210_2ax_cfg_so_gf_a0;
+			trans->cfg = &iwlax211_2ax_cfg_so_gf_a0;
 		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF4)) {
-			trans->cfg = &iwlax210_2ax_cfg_so_gf4_a0;
+			trans->cfg = &iwlax411_2ax_cfg_so_gf4_a0;
 		}
 	} else if (cfg == &iwl_ax101_cfg_qu_hr) {
 		if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
-- 
2.20.1

