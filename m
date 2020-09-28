Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C054727AA9F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1JXa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52748 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgI1JXa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNX-002KgD-Dr; Mon, 28 Sep 2020 12:23:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:13 +0300
Message-Id: <iwlwifi.20200928121852.23ec241f16cd.I8cd21fc5a2498e820b50e1f49a4cbfe545afe30e@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: acpi: rename geo structs to contain versioning
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add the version number to the iwl_geo_tx_power_profile_cmd structs and
move the union into a common place.  Additionally, reuse the code that
sets elements that are at the same place in the struct across
different versions.

While at it remove an unused variable, add a comment and move the v2
specific element setting to inside the if statement.  Additionally,
invert the if for slightly more readability.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 15 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 42 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 ---
 5 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 91ee767662fb..838b2844e3d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -645,7 +645,7 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
 
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset_group *table)
+		     struct iwl_per_chain_offset_group_v1 *table)
 {
 	int ret, i, j;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 9524750607be..94fabe6cd368 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -196,7 +196,7 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt);
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset_group *table);
+		     struct iwl_per_chain_offset_group_v1 *table);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *black_list_array,
 		     int *black_list_size);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 062e34b5b4f8..c3111a1e9f57 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -460,7 +460,7 @@ struct iwl_per_chain_offset {
 	u8 chain_b;
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_PER_CHAIN_S_VER_1 */
 
-struct iwl_per_chain_offset_group {
+struct iwl_per_chain_offset_group_v1 {
 	struct iwl_per_chain_offset lb;
 	struct iwl_per_chain_offset hb;
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_GROUP_S_VER_1 */
@@ -472,7 +472,7 @@ struct iwl_per_chain_offset_group {
  */
 struct iwl_geo_tx_power_profiles_cmd_v1 {
 	__le32 ops;
-	struct iwl_per_chain_offset_group table[IWL_NUM_GEO_PROFILES];
+	struct iwl_per_chain_offset_group_v1 table[IWL_NUM_GEO_PROFILES];
 } __packed; /* GEO_TX_POWER_LIMIT_VER_1 */
 
 /**
@@ -481,11 +481,16 @@ struct iwl_geo_tx_power_profiles_cmd_v1 {
  * @table: offset profile per band.
  * @table_revision: BIOS table revision.
  */
-struct iwl_geo_tx_power_profiles_cmd {
+struct iwl_geo_tx_power_profiles_cmd_v2 {
 	__le32 ops;
-	struct iwl_per_chain_offset_group table[IWL_NUM_GEO_PROFILES];
+	struct iwl_per_chain_offset_group_v1 table[IWL_NUM_GEO_PROFILES];
 	__le32 table_revision;
-} __packed; /* GEO_TX_POWER_LIMIT */
+} __packed; /* GEO_TX_POWER_LIMIT_VER_2 */
+
+union iwl_geo_tx_power_profiles_cmd {
+	struct iwl_geo_tx_power_profiles_cmd_v1 v1;
+	struct iwl_geo_tx_power_profiles_cmd_v2 v2;
+};
 
 /**
  * struct iwl_geo_tx_power_profiles_resp -  response to GEO_TX_POWER_LIMIT cmd
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f3e149e70c67..644bd59cb0f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -782,22 +782,21 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
-	union geo_tx_power_profiles_cmd geo_tx_cmd;
+	union iwl_geo_tx_power_profiles_cmd geo_tx_cmd;
 	struct iwl_geo_tx_power_profiles_resp *resp;
 	u16 len;
 	int ret;
 	struct iwl_host_cmd cmd;
 
+	/* the ops field is at the same spot for all versions, so set in v1 */
+	geo_tx_cmd.v1.ops =
+		cpu_to_le32(IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE);
+
 	if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
-		       IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
-		geo_tx_cmd.geo_cmd.ops =
-			cpu_to_le32(IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE);
-		len = sizeof(geo_tx_cmd.geo_cmd);
-	} else {
-		geo_tx_cmd.geo_cmd_v1.ops =
-			cpu_to_le32(IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE);
-		len = sizeof(geo_tx_cmd.geo_cmd_v1);
-	}
+		       IWL_UCODE_TLV_API_SAR_TABLE_VER))
+		len = sizeof(geo_tx_cmd.v2);
+	else
+		len = sizeof(geo_tx_cmd.v1);
 
 	if (!iwl_sar_geo_support(&mvm->fwrt))
 		return -EOPNOTSUPP;
@@ -827,14 +826,13 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 
 static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 {
-	u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
-	union geo_tx_power_profiles_cmd cmd;
+	union iwl_geo_tx_power_profiles_cmd cmd;
 	u16 len;
 	int ret;
 
-	cmd.geo_cmd.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
+	/* the table is also at the same position both in v1 and v2 */
+	ret = iwl_sar_geo_init(&mvm->fwrt, cmd.v1.table);
 
-	ret = iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
 	/*
 	 * It is a valid scenario to not support SAR, or miss wgds table,
 	 * but in that case there is no need to send the command.
@@ -842,16 +840,20 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	if (ret)
 		return 0;
 
-	cmd.geo_cmd.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+	/* the ops field is at the same spot for all versions, so set in v1 */
+	cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
-	if (!fw_has_api(&mvm->fwrt.fw->ucode_capa,
-			IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
-		len = sizeof(struct iwl_geo_tx_power_profiles_cmd_v1);
+	if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
+		       IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
+		len = sizeof(cmd.v2);
+		cmd.v2.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 	} else {
-		len =  sizeof(cmd.geo_cmd);
+		len = sizeof(cmd.v1);
 	}
 
-	return iwl_mvm_send_cmd_pdu(mvm, cmd_wide_id, 0, len, &cmd);
+	return iwl_mvm_send_cmd_pdu(mvm,
+				    WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT),
+				    0, len, &cmd);
 }
 
 static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 05b707e23e39..37e490148876 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -184,11 +184,6 @@ enum iwl_power_scheme {
 	IWL_POWER_SCHEME_LP
 };
 
-union geo_tx_power_profiles_cmd {
-	struct iwl_geo_tx_power_profiles_cmd geo_cmd;
-	struct iwl_geo_tx_power_profiles_cmd_v1 geo_cmd_v1;
-};
-
 #define IWL_CONN_MAX_LISTEN_INTERVAL	10
 #define IWL_UAPSD_MAX_SP		IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL
 
-- 
2.28.0

