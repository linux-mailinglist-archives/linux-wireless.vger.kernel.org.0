Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B51B7C1F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgDXQrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58054 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727021AbgDXQrp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U7-000OcH-DM; Fri, 24 Apr 2020 19:47:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:47:06 +0300
Message-Id: <iwlwifi.20200424194456.ec0e04102d2c.Ia36f2c7bbf06cb6436424d40d6adb2376f2962ee@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/11] iwlwifi: pcie: convert all AX101 devices to the device tables
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Convert all Qu/Hr1 devices to the new device tables, by modifying the
corresponding structures, adding a new name and generalizing the
device recognition.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 10 ++--
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 11 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 52 +++++++++----------
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index b9d13e38f12b..1fcc346ba425 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -337,14 +337,14 @@ const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 
 const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
+const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
 
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
 const char iwl_ax200_killer_1650x_name[] =
 	"Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW)";
 
-const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
-	.name = "Intel(R) Wi-Fi 6 AX101",
+const struct iwl_cfg iwl_qu_b0_hr1_b0 = {
 	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
@@ -370,8 +370,7 @@ const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0 = {
-	.name = "Intel(R) Wi-Fi 6 AX101",
+const struct iwl_cfg iwl_qu_c0_hr1_b0 = {
 	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
@@ -397,8 +396,7 @@ const struct iwl_cfg iwl_ax201_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_ax101_cfg_quz_hr = {
-	.name = "Intel(R) Wi-Fi 6 AX101",
+const struct iwl_cfg iwl_quz_a0_hr1_b0 = {
 	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 91ec41e0d427..244899f3f3bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -477,12 +477,16 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_TH1		0x108
 #define IWL_CFG_RF_TYPE_JF2		0x105
 #define IWL_CFG_RF_TYPE_JF1		0x108
+#define IWL_CFG_RF_TYPE_HR2		0x10A
+#define IWL_CFG_RF_TYPE_HR1		0x10C
 
 #define IWL_CFG_RF_ID_TH		0x1
 #define IWL_CFG_RF_ID_TH1		0x1
 #define IWL_CFG_RF_ID_JF		0x3
 #define IWL_CFG_RF_ID_JF1		0x6
 #define IWL_CFG_RF_ID_JF1_DIV		0xA
+#define IWL_CFG_RF_ID_HR		0x7
+#define IWL_CFG_RF_ID_HR1		0x4
 
 #define IWL_CFG_NO_160			0x0
 #define IWL_CFG_160			0x1
@@ -536,6 +540,7 @@ extern const char iwl9560_killer_1550i_name[];
 extern const char iwl9560_killer_1550s_name[];
 extern const char iwl_ax200_name[];
 extern const char iwl_ax201_name[];
+extern const char iwl_ax101_name[];
 extern const char iwl_ax200_killer_1650w_name[];
 extern const char iwl_ax200_killer_1650x_name[];
 
@@ -610,9 +615,9 @@ extern const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_qnj_b0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
-extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
-extern const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0;
-extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
+extern const struct iwl_cfg iwl_qu_b0_hr1_b0;
+extern const struct iwl_cfg iwl_qu_c0_hr1_b0;
+extern const struct iwl_cfg iwl_quz_a0_hr1_b0;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d5f437ac3c43..f179cd08b418 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -594,89 +594,68 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2720, IWL_CFG_ANY, iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
 
 	/* Qu with Hr */
-	IWL_DEV_INFO(0x43F0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x43F0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
-	IWL_DEV_INFO(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x43F0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0xA0F0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0xA0F0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0A10, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0xA0F0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x0070, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x0074, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x0078, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x007C, iwl_ax201_cfg_quz_hr, NULL),
-	IWL_DEV_INFO(0x02F0, 0x0244, iwl_ax101_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x0310, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x1651, iwl_ax1650s_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x1652, iwl_ax1650i_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x2074, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x4070, iwl_ax201_cfg_quz_hr, NULL),
-	IWL_DEV_INFO(0x02F0, 0x4244, iwl_ax101_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x0070, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x0074, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x0078, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x007C, iwl_ax201_cfg_quz_hr, NULL),
-	IWL_DEV_INFO(0x06F0, 0x0244, iwl_ax101_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x0310, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x1651, iwl_ax1650s_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x1652, iwl_ax1650i_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x2074, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x06F0, 0x4070, iwl_ax201_cfg_quz_hr, NULL),
-	IWL_DEV_INFO(0x06F0, 0x4244, iwl_ax101_cfg_quz_hr, NULL),
-	IWL_DEV_INFO(0x34F0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x34F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x34F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x34F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x34F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x34F0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x34F0, 0x0310, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x34F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x34F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x34F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x34F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x34F0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
 
-	IWL_DEV_INFO(0x3DF0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x3DF0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x0310, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x3DF0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
 
-	IWL_DEV_INFO(0x4DF0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x4DF0, 0x0244, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x0310, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
-	IWL_DEV_INFO(0x4DF0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
@@ -951,6 +930,29 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
+
+/* Qu with Hr */
+	/* Qu B step */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_qu_b0_hr1_b0, iwl_ax101_name),
+
+	/* Qu C step */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_qu_c0_hr1_b0, iwl_ax101_name),
+
+	/* QuZ */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
+
 #endif /* CONFIG_IWLMVM */
 };
 
@@ -1057,9 +1059,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * rest must be removed once we convert Qu with Hr as well.
 	 */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QU_C0) {
-		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
+		if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
 		else if (iwl_trans->cfg == &killer1650s_2ax_cfg_qu_b0_hr_b0)
 			iwl_trans->cfg = &killer1650s_2ax_cfg_qu_c0_hr_b0;
@@ -1069,9 +1069,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* same thing for QuZ... */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
-		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax101_cfg_quz_hr;
-		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
+		if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
 			iwl_trans->cfg = &iwl_ax201_cfg_quz_hr;
 	}
 
-- 
2.26.2

