Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC15E309BED
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 13:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhAaL6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 06:58:33 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:42920 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231666AbhAaL5w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 06:57:52 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6AY0-004131-UV; Sun, 31 Jan 2021 13:05:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 13:05:27 +0200
Message-Id: <iwlwifi.20210131125921.ae6ed654e557.Ic11ed4df410328359b6a2c997456692901d99468@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131110533.887130-1-luca@coelho.fi>
References: <20210131110533.887130-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] iwlwifi: add support for SnJ with Jf devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add support for SnJ devices with Jf and a workaround for some cases
where the devices erroneously show as QnJ devices.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 18 +++--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 72 +++++++++++++++----
 3 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 4ffe28c248d6..65a2dacc083e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -42,6 +42,7 @@
 #define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
 #define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
 #define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
+#define IWL_SNJ_A_JF_B_FW_PRE		"iwlwifi-SoSnj-a0-jf-b0-"
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
 #define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
 #define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
@@ -76,7 +77,9 @@
 	IWL_SNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api) \
+#define IWL_SNJ_A_JF_B_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_JF_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
 	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
@@ -619,9 +622,15 @@ const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
-const struct iwl_cfg iwlax201_cfg_snj_hr_b0 = {
-	.name = iwl_ax201_name,
-	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
+const struct iwl_cfg iwl_cfg_snj_hr_b0 = {
+	.fw_name_pre = IWL_SNJ_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_snj_a0_jf_b0 = {
+	.fw_name_pre = IWL_SNJ_A_JF_B_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
@@ -663,6 +672,7 @@ MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 56ca35b345cd..b215fd060163 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -601,7 +601,8 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
 extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
-extern const struct iwl_cfg iwlax201_cfg_snj_hr_b0;
+extern const struct iwl_cfg iwl_cfg_snj_hr_b0;
+extern const struct iwl_cfg iwl_cfg_snj_a0_jf_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 852c6b8b7568..462ff6114c69 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -528,9 +528,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2723, 0x1654, iwl_ax200_cfg_cc, iwl_ax200_killer_1650x_name),
 	IWL_DEV_INFO(0x2723, IWL_CFG_ANY, iwl_ax200_cfg_cc, iwl_ax200_name),
 
-	/* QnJ with Hr */
-	IWL_DEV_INFO(0x2720, IWL_CFG_ANY, iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
-
 	/* Qu with Hr */
 	IWL_DEV_INFO(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
@@ -617,20 +614,12 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	/* SnJ with HR */
 	IWL_DEV_INFO(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x0070, iwlax201_cfg_snj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2726, 0x0074, iwlax201_cfg_snj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2726, 0x0078, iwlax201_cfg_snj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2726, 0x007C, iwlax201_cfg_snj_hr_b0, NULL),
 	IWL_DEV_INFO(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0, NULL),
 	IWL_DEV_INFO(0x2726, 0x0098, iwlax211_cfg_snj_gf_a0, NULL),
 	IWL_DEV_INFO(0x2726, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
 	IWL_DEV_INFO(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x2074, iwlax201_cfg_snj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2726, 0x4070, iwlax201_cfg_snj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2726, 0x0244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
-	IWL_DEV_INFO(0x2726, 0x1651, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650s_name),
-	IWL_DEV_INFO(0x2726, 0x1652, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650i_name),
-	IWL_DEV_INFO(0x2726, 0x4244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
+	IWL_DEV_INFO(0x2726, 0x1651, iwl_cfg_snj_hr_b0, iwl_ax201_killer_1650s_name),
+	IWL_DEV_INFO(0x2726, 0x1652, iwl_cfg_snj_hr_b0, iwl_ax201_killer_1650i_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
@@ -928,6 +917,53 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
 
+/* QnJ with Hr */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
+
+/* SnJ with Jf */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl_cfg_snj_a0_jf_b0, iwl9461_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl_cfg_snj_a0_jf_b0, iwl9461_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl_cfg_snj_a0_jf_b0, iwl9462_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl_cfg_snj_a0_jf_b0, iwl9462_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl_cfg_snj_a0_jf_b0, iwl9560_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl_cfg_snj_a0_jf_b0, iwl9560_name),
+
+/* SnJ with Hr */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_snj_hr_b0, iwl_ax201_name),
+
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
@@ -1008,6 +1044,16 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	/*
+	 * Workaround for problematic SnJ device: sometimes when
+	 * certain RF modules are connected to SnJ, the device ID
+	 * changes to QnJ's ID.  So we are using QnJ's trans_cfg until
+	 * here.  But if we detect that the MAC type is actually SnJ,
+	 * we should switch to it here to avoid problems later.
+	 */
+	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_SNJ)
+		iwl_trans->trans_cfg = &iwl_so_trans_cfg;
+
 #if IS_ENABLED(CONFIG_IWLMVM)
 	/*
 	 * special-case 7265D, it has the same PCI IDs.
-- 
2.29.2

