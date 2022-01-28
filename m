Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C159F49FAC9
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348921AbiA1Nem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37844 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348902AbiA1Nej (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:39 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROe-0002DK-KU;
        Fri, 28 Jan 2022 15:34:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:22 +0200
Message-Id: <iwlwifi.20220128153014.1d2ae1e6bcdb.I177929ed01ed7bf4614ea0f6db2af9e52de13316@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/13] iwlwifi: mvm: allow enabling UHB TAS in the USA via ACPI setting
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

Read a new bit defined in ACPI WTAS that allows OEMs to specify whether
TAS is allowed in UHB (6-7GHz) in the USA.  This can be used by OEMs
that got certified to use this feature.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 18 +++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  6 +++--
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 24 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 26 +++++++++++--------
 4 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 790c96df58cb..0e9e61508ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -242,7 +242,7 @@ union acpi_object *iwl_acpi_get_wifi_pkg_range(struct device *dev,
 IWL_EXPORT_SYMBOL(iwl_acpi_get_wifi_pkg_range);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     struct iwl_tas_config_cmd_v3 *cmd)
+		     union iwl_tas_config_cmd *cmd, int fw_ver)
 {
 	union acpi_object *wifi_pkg, *data;
 	int ret, tbl_rev, i, block_list_size, enabled;
@@ -268,10 +268,18 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 			(tas_selection & ACPI_WTAS_OVERRIDE_IEC_MSK) >> ACPI_WTAS_OVERRIDE_IEC_POS;
 		u16 enabled_iec = (tas_selection & ACPI_WTAS_ENABLE_IEC_MSK) >>
 			ACPI_WTAS_ENABLE_IEC_POS;
+		u8 usa_tas_uhb = (tas_selection & ACPI_WTAS_USA_UHB_MSK) >> ACPI_WTAS_USA_UHB_POS;
+
 
 		enabled = tas_selection & ACPI_WTAS_ENABLED_MSK;
-		cmd->override_tas_iec = cpu_to_le16(override_iec);
-		cmd->enable_tas_iec = cpu_to_le16(enabled_iec);
+		if (fw_ver <= 3) {
+			cmd->v3.override_tas_iec = cpu_to_le16(override_iec);
+			cmd->v3.enable_tas_iec = cpu_to_le16(enabled_iec);
+		} else {
+			cmd->v4.usa_tas_uhb_allowed = usa_tas_uhb;
+			cmd->v4.override_tas_iec = (u8)override_iec;
+			cmd->v4.enable_tas_iec = (u8)enabled_iec;
+		}
 
 	} else if (tbl_rev == 0 &&
 		wifi_pkg->package.elements[1].type == ACPI_TYPE_INTEGER) {
@@ -297,7 +305,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		goto out_free;
 	}
 	block_list_size = wifi_pkg->package.elements[2].integer.value;
-	cmd->block_list_size = cpu_to_le32(block_list_size);
+	cmd->v4.block_list_size = cpu_to_le32(block_list_size);
 
 	IWL_DEBUG_RADIO(fwrt, "TAS array size %u\n", block_list_size);
 	if (block_list_size > APCI_WTAS_BLACK_LIST_MAX) {
@@ -319,7 +327,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		}
 
 		country = wifi_pkg->package.elements[3 + i].integer.value;
-		cmd->block_list_array[i] = cpu_to_le32(country);
+		cmd->v4.block_list_array[i] = cpu_to_le32(country);
 		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n", country);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 22b3c665f91a..5ac0979123fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -77,6 +77,8 @@
 #define ACPI_WTAS_ENABLE_IEC_MSK	0x4
 #define ACPI_WTAS_OVERRIDE_IEC_POS	0x1
 #define ACPI_WTAS_ENABLE_IEC_POS	0x2
+#define ACPI_WTAS_USA_UHB_MSK		BIT(16)
+#define ACPI_WTAS_USA_UHB_POS		16
 
 
 #define ACPI_PPAG_WIFI_DATA_SIZE_V1	((IWL_NUM_CHAIN_LIMITS * \
@@ -213,7 +215,7 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		     u32 n_bands, u32 n_profiles);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     struct iwl_tas_config_cmd_v3 *cmd);
+		     union iwl_tas_config_cmd *cmd, int fw_ver);
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
@@ -294,7 +296,7 @@ static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 }
 
 static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-				   struct iwl_tas_config_cmd_v3 *cmd)
+				   union iwl_tas_config_cmd *cmd, int fw_ver)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 4949fcf85257..fc85ec426f43 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -419,6 +419,30 @@ struct iwl_tas_config_cmd_v3 {
 	__le16 enable_tas_iec;
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_3 */
 
+/**
+ * struct iwl_tas_config_cmd_v3 - configures the TAS
+ * @block_list_size: size of relevant field in block_list_array
+ * @block_list_array: list of countries where TAS must be disabled
+ * @override_tas_iec: indicates whether to override default value of IEC regulatory
+ * @enable_tas_iec: in case override_tas_iec is set -
+ *	indicates whether IEC regulatory is enabled or disabled
+ * @usa_tas_uhb_allowed: if set, allow TAS UHB in the USA
+ * @reserved: reserved
+*/
+struct iwl_tas_config_cmd_v4 {
+	__le32 block_list_size;
+	__le32 block_list_array[IWL_TAS_BLOCK_LIST_MAX];
+	u8 override_tas_iec;
+	u8 enable_tas_iec;
+	u8 usa_tas_uhb_allowed;
+	u8 reserved;
+} __packed; /* TAS_CONFIG_CMD_API_S_VER_4 */
+
+union iwl_tas_config_cmd {
+	struct iwl_tas_config_cmd_v2 v2;
+	struct iwl_tas_config_cmd_v3 v3;
+	struct iwl_tas_config_cmd_v4 v4;
+};
 /**
  * enum iwl_lari_configs - bit masks for the various LARI config operations
  * @LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK: disable 11ac in ukraine
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6f4690e56a46..6a2a8ed1429a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1206,10 +1206,10 @@ static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigne
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 	int ret;
-	struct iwl_tas_config_cmd_v3 cmd = {};
-	int cmd_size;
+	union iwl_tas_config_cmd cmd = {};
+	int cmd_size, fw_ver;
 
-	BUILD_BUG_ON(ARRAY_SIZE(cmd.block_list_array) <
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.v3.block_list_array) <
 		     APCI_WTAS_BLACK_LIST_MAX);
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_TAS_CFG)) {
@@ -1217,7 +1217,10 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	ret = iwl_acpi_get_tas(&mvm->fwrt, &cmd);
+	fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, REGULATORY_AND_NVM_GROUP,
+				       TAS_CONFIG, IWL_FW_CMD_VER_UNKNOWN);
+
+	ret = iwl_acpi_get_tas(&mvm->fwrt, &cmd, fw_ver);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"TAS table invalid or unavailable. (%d)\n",
@@ -1232,19 +1235,20 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
 				dmi_get_system_info(DMI_SYS_VENDOR));
-		if ((!iwl_mvm_add_to_tas_block_list(cmd.block_list_array,
-						    &cmd.block_list_size, IWL_TAS_US_MCC)) ||
-		    (!iwl_mvm_add_to_tas_block_list(cmd.block_list_array,
-						    &cmd.block_list_size, IWL_TAS_CANADA_MCC))) {
+		if ((!iwl_mvm_add_to_tas_block_list(cmd.v4.block_list_array,
+						    &cmd.v4.block_list_size,
+							IWL_TAS_US_MCC)) ||
+		    (!iwl_mvm_add_to_tas_block_list(cmd.v4.block_list_array,
+						    &cmd.v4.block_list_size,
+							IWL_TAS_CANADA_MCC))) {
 			IWL_DEBUG_RADIO(mvm,
 					"Unable to add US/Canada to TAS block list, disabling TAS\n");
 			return;
 		}
 	}
 
-	cmd_size = iwl_fw_lookup_cmd_ver(mvm->fw, REGULATORY_AND_NVM_GROUP,
-					 TAS_CONFIG,
-					 IWL_FW_CMD_VER_UNKNOWN) < 3 ?
+	/* v4 is the same size as v3, so no need to differentiate here */
+	cmd_size = fw_ver < 3 ?
 		sizeof(struct iwl_tas_config_cmd_v2) :
 		sizeof(struct iwl_tas_config_cmd_v3);
 
-- 
2.34.1

