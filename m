Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF827AA9D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1JX3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52734 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgI1JX2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNV-002KgD-1i; Mon, 28 Sep 2020 12:23:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:11 +0300
Message-Id: <iwlwifi.20200928121852.da5a95917df4.I84d44c9dd0b858c403a81ca621b5a7b615a3aa7e@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: acpi: prepare SAR profile selection code for multiple sizes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The SAR profile tables will be larger in the next version, so prepare
the iwl_sar_select_profile() function to handle multiple sizes and
update the relevant callers.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 36 +++++++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  5 +--
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  7 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 17 +++++----
 4 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 448af3b1d5d6..91ee767662fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -419,16 +419,12 @@ static int iwl_sar_set_profile(union acpi_object *table,
 	return 0;
 }
 
-int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 per_chain[][IWL_NUM_SUB_BANDS],
-			   int prof_a, int prof_b)
+static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
+			      __le16 *per_chain, u32 n_subbands,
+			      int prof_a, int prof_b)
 {
-	int i, j, idx;
 	int profs[ACPI_SAR_NUM_CHAIN_LIMITS] = { prof_a, prof_b };
-
-	BUILD_BUG_ON(ACPI_SAR_NUM_CHAIN_LIMITS < 2);
-	BUILD_BUG_ON(ACPI_SAR_NUM_CHAIN_LIMITS * ACPI_SAR_NUM_SUB_BANDS !=
-		     ACPI_SAR_TABLE_SIZE);
+	int i, j, idx;
 
 	for (i = 0; i < ACPI_SAR_NUM_CHAIN_LIMITS; i++) {
 		struct iwl_sar_profile *prof;
@@ -460,9 +456,10 @@ int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 			       "SAR EWRD: chain %d profile index %d\n",
 			       i, profs[i]);
 		IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
-		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
-			idx = (i * ACPI_SAR_NUM_SUB_BANDS) + j;
-			per_chain[i][j] = cpu_to_le16(prof->table[idx]);
+		for (j = 0; j < n_subbands; j++) {
+			idx = i * ACPI_SAR_NUM_SUB_BANDS + j;
+			per_chain[i * n_subbands + j] =
+				cpu_to_le16(prof->table[idx]);
 			IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
 					j, prof->table[idx]);
 		}
@@ -470,6 +467,23 @@ int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 
 	return 0;
 }
+
+int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
+			   __le16 *per_chain, u32 n_tables, u32 n_subbands,
+			   int prof_a, int prof_b)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < n_tables; i++) {
+		ret = iwl_sar_fill_table(fwrt,
+			 &per_chain[i * n_subbands * ACPI_SAR_NUM_CHAIN_LIMITS],
+			 n_subbands, prof_a, prof_b);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
 IWL_EXPORT_SYMBOL(iwl_sar_select_profile);
 
 int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 6accf5c57a44..9524750607be 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -89,6 +89,7 @@
 
 #define ACPI_SAR_NUM_CHAIN_LIMITS	2
 #define ACPI_SAR_NUM_SUB_BANDS		5
+#define ACPI_SAR_NUM_TABLES		1
 
 #define ACPI_WRDS_WIFI_DATA_SIZE	(ACPI_SAR_TABLE_SIZE + 2)
 #define ACPI_EWRD_WIFI_DATA_SIZE	((ACPI_SAR_PROFILE_NUM - 1) * \
@@ -183,7 +184,7 @@ u64 iwl_acpi_get_pwr_limit(struct device *dev);
 int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk);
 
 int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 per_chain[][IWL_NUM_SUB_BANDS],
+			   __le16 *per_chain, u32 n_tables, u32 n_subbands,
 			   int prof_a, int prof_b);
 
 int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt);
@@ -242,7 +243,7 @@ static inline int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 }
 
 static inline int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 per_chain[][IWL_NUM_SUB_BANDS],
+			   __le16 *per_chain, u32 n_tables, u32 n_subbands,
 			   int prof_a, int prof_b)
 {
 	return -ENOENT;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 3114cfbbd6a2..28bb361fd0da 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -329,6 +329,7 @@ enum iwl_dev_tx_power_cmd_mode {
 	IWL_TX_POWER_MODE_SET_SAR_TIMER_DEFAULT_TABLE = 5,
 }; /* TX_POWER_REDUCED_FLAGS_TYPE_API_E_VER_5 */;
 
+#define IWL_NUM_CHAIN_TABLES	1
 #define IWL_NUM_CHAIN_LIMITS	2
 #define IWL_NUM_SUB_BANDS	5
 #define IWL_NUM_SUB_BANDS_V2	11
@@ -356,7 +357,7 @@ struct iwl_dev_tx_power_common {
  * @per_chain: per chain restrictions
  */
 struct iwl_dev_tx_power_cmd_v3 {
-	__le16 per_chain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
 } __packed; /* TX_REDUCED_POWER_API_S_VER_3 */
 
 #define IWL_DEV_MAX_TX_POWER 0x7FFF
@@ -369,7 +370,7 @@ struct iwl_dev_tx_power_cmd_v3 {
  * @reserved: reserved (padding)
  */
 struct iwl_dev_tx_power_cmd_v4 {
-	__le16 per_chain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
 	u8 enable_ack_reduction;
 	u8 reserved[3];
 } __packed; /* TX_REDUCED_POWER_API_S_VER_4 */
@@ -388,7 +389,7 @@ struct iwl_dev_tx_power_cmd_v4 {
  *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
  */
 struct iwl_dev_tx_power_cmd_v5 {
-	__le16 per_chain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
 	u8 enable_ack_reduction;
 	u8 per_chain_restriction_changed;
 	u8 reserved[2];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index fd8d6190ee24..d55a8768ff6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -739,23 +739,28 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	struct iwl_dev_tx_power_cmd cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
 	};
+	__le16 *per_chain;
 	int ret;
 	u16 len = 0;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
-		       IWL_UCODE_TLV_API_REDUCE_TX_POWER))
+		       IWL_UCODE_TLV_API_REDUCE_TX_POWER)) {
 		len = sizeof(cmd.v5);
-	else if (fw_has_capa(&mvm->fw->ucode_capa,
-			     IWL_UCODE_TLV_CAPA_TX_POWER_ACK))
+		per_chain = cmd.v5.per_chain[0][0];
+	} else if (fw_has_capa(&mvm->fw->ucode_capa,
+			     IWL_UCODE_TLV_CAPA_TX_POWER_ACK)) {
 		len = sizeof(cmd.v4);
-	else
+		per_chain = cmd.v4.per_chain[0][0];
+	} else {
 		len = sizeof(cmd.v3);
+		per_chain = cmd.v3.per_chain[0][0];
+	}
 
 	/* all structs have the same common part, add it */
 	len += sizeof(cmd.common);
 
-	ret = iwl_sar_select_profile(&mvm->fwrt, cmd.v5.per_chain,
-				     prof_a, prof_b);
+	ret = iwl_sar_select_profile(&mvm->fwrt, per_chain, ACPI_SAR_NUM_TABLES,
+				     ACPI_SAR_NUM_SUB_BANDS, prof_a, prof_b);
 
 	/* return on error or if the profile is disabled (positive number) */
 	if (ret)
-- 
2.28.0

