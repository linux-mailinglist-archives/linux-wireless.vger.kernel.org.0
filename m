Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019A7277283
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgIXNhS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52084 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727846AbgIXNhS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDu-002IGj-Vw; Thu, 24 Sep 2020 16:23:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:38 +0300
Message-Id: <iwlwifi.20200924162105.6add94c21abe.I1aa1c5e3c2c12ce82ed30429e0ad92225ece7ce3@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924132339.337310-1-luca@coelho.fi>
References: <20200924132339.337310-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 6/7] iwlwifi: add new cards for MA family
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

add few PCI ID'S for ma with gf and mr in AX family.

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 51 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  9 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 15 ++++++
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index df7346eed14f..d2fb64fd7990 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -90,6 +90,8 @@
 #define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
 #define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
 #define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
+#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
+#define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
@@ -121,6 +123,10 @@
 	IWL_SNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api) \
+	IWL_MA_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
+	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -338,9 +344,23 @@ const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.bisr_workaround = 1,
 };
 
+const struct iwl_cfg_trans_params iwl_ma_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.integrated = true,
+	.umac_prph_offset = 0x300000
+};
+
+const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
 const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
-const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
+const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6 AX211 160MHz";
+const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6 AX411 160MHz";
+const char iwl_ma_name[] = "Intel(R) Wi-Fi 6";
 
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
@@ -546,7 +566,7 @@ const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0 = {
 };
 
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
+	.name = iwl_ax211_name,
 	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -554,7 +574,7 @@ const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 };
 
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long = {
-	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
+	.name = iwl_ax211_name,
 	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -572,7 +592,7 @@ const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 };
 
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
+	.name = iwl_ax411_name,
 	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -580,7 +600,7 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 };
 
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
-	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
+	.name = iwl_ax411_name,
 	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -590,7 +610,7 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
 };
 
 const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
+	.name = iwl_ax411_name,
 	.fw_name_pre = IWL_SNJ_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -598,7 +618,7 @@ const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
 };
 
 const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
+	.name = iwl_ax211_name,
 	.fw_name_pre = IWL_SNJ_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -613,6 +633,20 @@ const struct iwl_cfg iwlax201_cfg_snj_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_ma_a0_gf_a0 = {
+	.fw_name_pre = IWL_MA_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
+	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -628,4 +662,5 @@ MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-
+MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 64e4ba4d96fc..d03f51bf7dfd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -472,6 +472,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_QU		0x33
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
 #define IWL_CFG_MAC_TYPE_QNJ		0x36
+#define IWL_CFG_MAC_TYPE_MA		0x44
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -479,6 +480,8 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_JF1		0x108
 #define IWL_CFG_RF_TYPE_HR2		0x10A
 #define IWL_CFG_RF_TYPE_HR1		0x10C
+#define IWL_CFG_RF_TYPE_GF		0x10D
+#define IWL_CFG_RF_TYPE_MR		0x110
 
 #define IWL_CFG_RF_ID_TH		0x1
 #define IWL_CFG_RF_ID_TH1		0x1
@@ -522,6 +525,7 @@ extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
 extern const char iwl9260_1_name[];
@@ -545,6 +549,9 @@ extern const char iwl_ax200_killer_1650w_name[];
 extern const char iwl_ax200_killer_1650x_name[];
 extern const char iwl_ax201_killer_1650s_name[];
 extern const char iwl_ax201_killer_1650i_name[];
+extern const char iwl_ma_name[];
+extern const char iwl_ax211_name[];
+extern const char iwl_ax411_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
@@ -643,6 +650,8 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
 extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
 extern const struct iwl_cfg iwlax201_cfg_snj_hr_b0;
+extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d84afe0013a2..cb70ebf06074 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -563,6 +563,9 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x7AF0, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
 
+/* Ma devices */
+	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_trans_cfg)},
+
 #endif /* CONFIG_IWLMVM */
 
 	{0}
@@ -970,6 +973,18 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
 
+/* Ma */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_ma_a0_gf_a0, iwl_ax211_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_ma_a0_mr_a0, iwl_ma_name),
+
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.28.0

