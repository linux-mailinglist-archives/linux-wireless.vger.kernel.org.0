Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F29B27AAA0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI1JXb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52754 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgI1JXb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:31 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNY-002KgD-6x; Mon, 28 Sep 2020 12:23:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:14 +0300
Message-Id: <iwlwifi.20200928121852.3700197ed1ed.Ia53fb9c4b5033683fd426d51a0ddc46fb444c805@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: support version 3 of GEO_TX_POWER_LIMIT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add support for the new version of the GEO_TX_POWER_LIMIT command.
This new version includes UHB values in the table, but for now, since
we don't have the ACPI values yet, we support the API, but don't set
the extra values.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  9 ++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  6 ++---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 26 +++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 20 ++++++++++----
 4 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 838b2844e3d6..e93656e461ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -645,7 +645,7 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
 
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset_group_v1 *table)
+		     struct iwl_per_chain_offset *table, u32 n_bands)
 {
 	int ret, i, j;
 
@@ -661,16 +661,11 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		return -ENOENT;
 	}
 
-	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES * ACPI_WGDS_NUM_BANDS *
-		     ACPI_WGDS_TABLE_SIZE + 1 !=  ACPI_WGDS_WIFI_DATA_SIZE);
-
-	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES > IWL_NUM_GEO_PROFILES);
-
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
 		struct iwl_per_chain_offset *chain =
 			(struct iwl_per_chain_offset *)&table[i];
 
-		for (j = 0; j < ACPI_WGDS_NUM_BANDS; j++) {
+		for (j = 0; j < n_bands; j++) {
 			u8 *value;
 
 			value = &fwrt->geo_profiles[i].values[j *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 94fabe6cd368..9d08d74e6939 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -196,7 +196,7 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt);
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset_group_v1 *table);
+		     struct iwl_per_chain_offset *table, u32 n_bands);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *black_list_array,
 		     int *black_list_size);
@@ -269,8 +269,8 @@ static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 	return false;
 }
 
-static inline int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-				   struct iwl_per_chain_offset_group *table)
+static int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
+			    struct iwl_per_chain_offset *table, u32 n_bands)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index c3111a1e9f57..4e6ad1793d0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -437,6 +437,8 @@ struct iwl_dev_tx_power_cmd {
 };
 
 #define IWL_NUM_GEO_PROFILES   3
+#define IWL_NUM_BANDS_PER_CHAIN_V1 2
+#define IWL_NUM_BANDS_PER_CHAIN_V2 3
 
 /**
  * enum iwl_geo_per_chain_offset_operation - type of operation
@@ -460,11 +462,6 @@ struct iwl_per_chain_offset {
 	u8 chain_b;
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_PER_CHAIN_S_VER_1 */
 
-struct iwl_per_chain_offset_group_v1 {
-	struct iwl_per_chain_offset lb;
-	struct iwl_per_chain_offset hb;
-} __packed; /* PER_CHAIN_LIMIT_OFFSET_GROUP_S_VER_1 */
-
 /**
  * struct iwl_geo_tx_power_profile_cmd_v1 - struct for GEO_TX_POWER_LIMIT cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
@@ -472,24 +469,37 @@ struct iwl_per_chain_offset_group_v1 {
  */
 struct iwl_geo_tx_power_profiles_cmd_v1 {
 	__le32 ops;
-	struct iwl_per_chain_offset_group_v1 table[IWL_NUM_GEO_PROFILES];
+	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES][IWL_NUM_BANDS_PER_CHAIN_V1];
 } __packed; /* GEO_TX_POWER_LIMIT_VER_1 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd - struct for GEO_TX_POWER_LIMIT cmd.
+ * struct iwl_geo_tx_power_profile_cmd_v2 - struct for GEO_TX_POWER_LIMIT cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: BIOS table revision.
  */
 struct iwl_geo_tx_power_profiles_cmd_v2 {
 	__le32 ops;
-	struct iwl_per_chain_offset_group_v1 table[IWL_NUM_GEO_PROFILES];
+	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES][IWL_NUM_BANDS_PER_CHAIN_V1];
 	__le32 table_revision;
 } __packed; /* GEO_TX_POWER_LIMIT_VER_2 */
 
+/**
+ * struct iwl_geo_tx_power_profile_cmd_v3 - struct for GEO_TX_POWER_LIMIT cmd.
+ * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
+ * @table: offset profile per band.
+ * @table_revision: BIOS table revision.
+ */
+struct iwl_geo_tx_power_profiles_cmd_v3 {
+	__le32 ops;
+	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES][IWL_NUM_BANDS_PER_CHAIN_V2];
+	__le32 table_revision;
+} __packed; /* GEO_TX_POWER_LIMIT_VER_3 */
+
 union iwl_geo_tx_power_profiles_cmd {
 	struct iwl_geo_tx_power_profiles_cmd_v1 v1;
 	struct iwl_geo_tx_power_profiles_cmd_v2 v2;
+	struct iwl_geo_tx_power_profiles_cmd_v3 v3;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 644bd59cb0f0..06bb8ad84efb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -787,13 +787,17 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	u16 len;
 	int ret;
 	struct iwl_host_cmd cmd;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
 
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	geo_tx_cmd.v1.ops =
 		cpu_to_le32(IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE);
 
-	if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
-		       IWL_UCODE_TLV_API_SAR_TABLE_VER))
+	if (cmd_ver == 3)
+		len = sizeof(geo_tx_cmd.v3);
+	else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
+			    IWL_UCODE_TLV_API_SAR_TABLE_VER))
 		len = sizeof(geo_tx_cmd.v2);
 	else
 		len = sizeof(geo_tx_cmd.v1);
@@ -829,9 +833,12 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	union iwl_geo_tx_power_profiles_cmd cmd;
 	u16 len;
 	int ret;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
 
 	/* the table is also at the same position both in v1 and v2 */
-	ret = iwl_sar_geo_init(&mvm->fwrt, cmd.v1.table);
+	ret = iwl_sar_geo_init(&mvm->fwrt, &cmd.v1.table[0][0],
+			       ACPI_WGDS_NUM_BANDS);
 
 	/*
 	 * It is a valid scenario to not support SAR, or miss wgds table,
@@ -843,8 +850,11 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
-	if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
-		       IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
+	if (cmd_ver == 3) {
+		len = sizeof(cmd.v3);
+		cmd.v3.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+	} else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
+			      IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
 		len = sizeof(cmd.v2);
 		cmd.v2.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 	} else {
-- 
2.28.0

