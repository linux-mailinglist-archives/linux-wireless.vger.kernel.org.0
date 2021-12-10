Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB146FB11
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhLJHKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50822 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233407AbhLJHKF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:05 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZzA-001F9v-Gr; Fri, 10 Dec 2021 09:06:29 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:15 +0200
Message-Id: <iwlwifi.20211210090244.ff455b9d66bd.Ic7c1460e89f6b22101f3c5a2ea438031c7f11771@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/11] iwlwifi: mvm: support revision 1 of WTAS table
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

A new revision of WTAS was added in order to support
IEC optimisation. Add support for reading the new revision from ACPI and
passing it to the FW.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 47 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 18 +++++--
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 25 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 17 ++++---
 4 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 0495316d1fc1..790c96df58cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -242,17 +242,16 @@ union acpi_object *iwl_acpi_get_wifi_pkg_range(struct device *dev,
 IWL_EXPORT_SYMBOL(iwl_acpi_get_wifi_pkg_range);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     __le32 *block_list_array,
-		     int *block_list_size)
+		     struct iwl_tas_config_cmd_v3 *cmd)
 {
 	union acpi_object *wifi_pkg, *data;
-	int ret, tbl_rev, i;
-	bool enabled;
+	int ret, tbl_rev, i, block_list_size, enabled;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WTAS_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	/* try to read wtas table revision 1 or revision 0*/
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WTAS_WIFI_DATA_SIZE,
 					 &tbl_rev);
@@ -261,40 +260,54 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		goto out_free;
 	}
 
-	if (wifi_pkg->package.elements[0].type != ACPI_TYPE_INTEGER ||
-	    tbl_rev != 0) {
+	if (tbl_rev == 1 && wifi_pkg->package.elements[1].type ==
+		ACPI_TYPE_INTEGER) {
+		u32 tas_selection =
+			(u32)wifi_pkg->package.elements[1].integer.value;
+		u16 override_iec =
+			(tas_selection & ACPI_WTAS_OVERRIDE_IEC_MSK) >> ACPI_WTAS_OVERRIDE_IEC_POS;
+		u16 enabled_iec = (tas_selection & ACPI_WTAS_ENABLE_IEC_MSK) >>
+			ACPI_WTAS_ENABLE_IEC_POS;
+
+		enabled = tas_selection & ACPI_WTAS_ENABLED_MSK;
+		cmd->override_tas_iec = cpu_to_le16(override_iec);
+		cmd->enable_tas_iec = cpu_to_le16(enabled_iec);
+
+	} else if (tbl_rev == 0 &&
+		wifi_pkg->package.elements[1].type == ACPI_TYPE_INTEGER) {
+		enabled = !!wifi_pkg->package.elements[1].integer.value;
+	} else {
 		ret = -EINVAL;
 		goto out_free;
 	}
 
-	enabled = !!wifi_pkg->package.elements[1].integer.value;
-
 	if (!enabled) {
-		*block_list_size = -1;
 		IWL_DEBUG_RADIO(fwrt, "TAS not enabled\n");
 		ret = 0;
 		goto out_free;
 	}
 
+	IWL_DEBUG_RADIO(fwrt, "Reading TAS table revision %d\n", tbl_rev);
 	if (wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER ||
 	    wifi_pkg->package.elements[2].integer.value >
 	    APCI_WTAS_BLACK_LIST_MAX) {
 		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size %llu\n",
-				wifi_pkg->package.elements[1].integer.value);
+				wifi_pkg->package.elements[2].integer.value);
 		ret = -EINVAL;
 		goto out_free;
 	}
-	*block_list_size = wifi_pkg->package.elements[2].integer.value;
+	block_list_size = wifi_pkg->package.elements[2].integer.value;
+	cmd->block_list_size = cpu_to_le32(block_list_size);
 
-	IWL_DEBUG_RADIO(fwrt, "TAS array size %d\n", *block_list_size);
-	if (*block_list_size > APCI_WTAS_BLACK_LIST_MAX) {
+	IWL_DEBUG_RADIO(fwrt, "TAS array size %u\n", block_list_size);
+	if (block_list_size > APCI_WTAS_BLACK_LIST_MAX) {
 		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size value %u\n",
-				*block_list_size);
+				block_list_size);
 		ret = -EINVAL;
 		goto out_free;
 	}
 
-	for (i = 0; i < *block_list_size; i++) {
+	for (i = 0; i < block_list_size; i++) {
 		u32 country;
 
 		if (wifi_pkg->package.elements[3 + i].type !=
@@ -306,11 +319,11 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		}
 
 		country = wifi_pkg->package.elements[3 + i].integer.value;
-		block_list_array[i] = cpu_to_le32(country);
+		cmd->block_list_array[i] = cpu_to_le32(country);
 		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n", country);
 	}
 
-	ret = 0;
+	ret = 1;
 out_free:
 	kfree(data);
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 4aaa8a6b071b..ac95d938109e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -65,10 +65,19 @@
 #define ACPI_ECKV_WIFI_DATA_SIZE	2
 
 /*
- * 1 type, 1 enabled, 1 block list size, 16 block list array
+ * TAS size: 1 elelment for type,
+ *	     1 element for enabled field,
+ *	     1 element for block list size,
+ *	     16 elements for block list array
  */
 #define APCI_WTAS_BLACK_LIST_MAX	16
 #define ACPI_WTAS_WIFI_DATA_SIZE	(3 + APCI_WTAS_BLACK_LIST_MAX)
+#define ACPI_WTAS_ENABLED_MSK		0x1
+#define ACPI_WTAS_OVERRIDE_IEC_MSK	0x2
+#define ACPI_WTAS_ENABLE_IEC_MSK	0x4
+#define ACPI_WTAS_OVERRIDE_IEC_POS	0x1
+#define ACPI_WTAS_ENABLE_IEC_POS	0x2
+
 
 #define ACPI_PPAG_WIFI_DATA_SIZE_V1	((IWL_NUM_CHAIN_LIMITS * \
 					  IWL_NUM_SUB_BANDS_V1) + 2)
@@ -198,8 +207,8 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		     struct iwl_per_chain_offset *table,
 		     u32 n_bands, u32 n_profiles);
 
-int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *block_list_array,
-		     int *block_list_size);
+int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
+		     struct iwl_tas_config_cmd_v3 *cmd);
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
@@ -280,8 +289,7 @@ static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 }
 
 static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-				   __le32 *block_list_array,
-				   int *block_list_size)
+				   struct iwl_tas_config_cmd_v3 *cmd)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 186199100929..4949fcf85257 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -393,17 +393,32 @@ enum iwl_mcc_source {
 	MCC_SOURCE_GETTING_MCC_TEST_MODE = 0x11,
 };
 
-#define IWL_TAS_BLACK_LIST_MAX 16
+#define IWL_TAS_BLOCK_LIST_MAX 16
 /**
- * struct iwl_tas_config_cmd - configures the TAS
+ * struct iwl_tas_config_cmd_v2 - configures the TAS
  * @block_list_size: size of relevant field in block_list_array
- * @block_list_array: block list countries (without TAS)
+ * @block_list_array: list of countries where TAS must be disabled
  */
-struct iwl_tas_config_cmd {
+struct iwl_tas_config_cmd_v2 {
 	__le32 block_list_size;
-	__le32 block_list_array[IWL_TAS_BLACK_LIST_MAX];
+	__le32 block_list_array[IWL_TAS_BLOCK_LIST_MAX];
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_2 */
 
+/**
+ * struct iwl_tas_config_cmd_v3 - configures the TAS
+ * @block_list_size: size of relevant field in block_list_array
+ * @block_list_array: list of countries where TAS must be disabled
+ * @override_tas_iec: indicates whether to override default value of IEC regulatory
+ * @enable_tas_iec: in case override_tas_iec is set -
+ *	indicates whether IEC regulatory is enabled or disabled
+ */
+struct iwl_tas_config_cmd_v3 {
+	__le32 block_list_size;
+	__le32 block_list_array[IWL_TAS_BLOCK_LIST_MAX];
+	__le16 override_tas_iec;
+	__le16 enable_tas_iec;
+} __packed; /* TAS_CONFIG_CMD_API_S_VER_3 */
+
 /**
  * enum iwl_lari_configs - bit masks for the various LARI config operations
  * @LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK: disable 11ac in ukraine
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 187637c81d1a..72227c87c6b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1156,8 +1156,8 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 	int ret;
-	struct iwl_tas_config_cmd cmd = {};
-	int list_size;
+	struct iwl_tas_config_cmd_v3 cmd = {};
+	int cmd_size;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cmd.block_list_array) <
 		     APCI_WTAS_BLACK_LIST_MAX);
@@ -1167,7 +1167,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	ret = iwl_acpi_get_tas(&mvm->fwrt, cmd.block_list_array, &list_size);
+	ret = iwl_acpi_get_tas(&mvm->fwrt, &cmd);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"TAS table invalid or unavailable. (%d)\n",
@@ -1175,15 +1175,18 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	if (list_size < 0)
+	if (ret == 0)
 		return;
 
-	/* list size if TAS enabled can only be non-negative */
-	cmd.block_list_size = cpu_to_le32((u32)list_size);
+	cmd_size = iwl_fw_lookup_cmd_ver(mvm->fw, REGULATORY_AND_NVM_GROUP,
+					 TAS_CONFIG,
+					 IWL_FW_CMD_VER_UNKNOWN) < 3 ?
+		sizeof(struct iwl_tas_config_cmd_v2) :
+		sizeof(struct iwl_tas_config_cmd_v3);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						TAS_CONFIG),
-				   0, sizeof(cmd), &cmd);
+				   0, cmd_size, &cmd);
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
-- 
2.34.1

