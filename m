Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD72F27AA9C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgI1JX1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52728 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbgI1JX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNU-002KgD-6h; Mon, 28 Sep 2020 12:23:24 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:10 +0300
Message-Id: <iwlwifi.20200928121852.4f0bea9fe077.Ib3b540a8288af32d6fa213448e13f82763f85bc9@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: add a common struct for all iwl_tx_power_cmd versions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Create a common structure to contain all different versions of the
tx_power_cmd instead of making a union of the different structs
everywhere we need them.  Also move the common part of these structs
into a separate structure (instead of reusing v3) and leave the
per_chain_restriction part out of the common part, because this will
change in version 6 of the command (which will be added soon).

While at it, rename per_chain_restriction to per_chain to shorten it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  5 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  4 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  3 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 46 +++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 16 +++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 18 ++++----
 6 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e3de4e11f4ae..448af3b1d5d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -420,7 +420,7 @@ static int iwl_sar_set_profile(union acpi_object *table,
 }
 
 int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
+			   __le16 per_chain[][IWL_NUM_SUB_BANDS],
 			   int prof_a, int prof_b)
 {
 	int i, j, idx;
@@ -462,8 +462,7 @@ int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 		IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
 		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
 			idx = (i * ACPI_SAR_NUM_SUB_BANDS) + j;
-			per_chain_restriction[i][j] =
-				cpu_to_le16(prof->table[idx]);
+			per_chain[i][j] = cpu_to_le16(prof->table[idx]);
 			IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
 					j, prof->table[idx]);
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index eafc23c6f55f..6accf5c57a44 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -183,7 +183,7 @@ u64 iwl_acpi_get_pwr_limit(struct device *dev);
 int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk);
 
 int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
+			   __le16 per_chain[][IWL_NUM_SUB_BANDS],
 			   int prof_a, int prof_b);
 
 int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt);
@@ -242,7 +242,7 @@ static inline int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 }
 
 static inline int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
+			   __le16 per_chain[][IWL_NUM_SUB_BANDS],
 			   int prof_a, int prof_b)
 {
 	return -ENOENT;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 4f46f3ed8794..42e81c174205 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -431,8 +431,7 @@ enum iwl_legacy_cmds {
 
 	/**
 	 * @REDUCE_TX_POWER_CMD:
-	 * &struct iwl_dev_tx_power_cmd_v3 or &struct iwl_dev_tx_power_cmd_v4
-	 * or &struct iwl_dev_tx_power_cmd
+	 * &struct iwl_dev_tx_power_cmd
 	 */
 	REDUCE_TX_POWER_CMD = 0x9f,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 45503e78d705..3114cfbbd6a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -334,44 +334,49 @@ enum iwl_dev_tx_power_cmd_mode {
 #define IWL_NUM_SUB_BANDS_V2	11
 
 /**
- * struct iwl_dev_tx_power_cmd - TX power reduction command
+ * struct iwl_dev_tx_power_common - Common part of the TX power reduction cmd
  * @set_mode: see &enum iwl_dev_tx_power_cmd_mode
  * @mac_context_id: id of the mac ctx for which we are reducing TX power.
  * @pwr_restriction: TX power restriction in 1/8 dBms.
  * @dev_24: device TX power restriction in 1/8 dBms
  * @dev_52_low: device TX power restriction upper band - low
  * @dev_52_high: device TX power restriction upper band - high
- * @per_chain_restriction: per chain restrictions
  */
-struct iwl_dev_tx_power_cmd_v3 {
+struct iwl_dev_tx_power_common {
 	__le32 set_mode;
 	__le32 mac_context_id;
 	__le16 pwr_restriction;
 	__le16 dev_24;
 	__le16 dev_52_low;
 	__le16 dev_52_high;
-	__le16 per_chain_restriction[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+};
+
+/**
+ * struct iwl_dev_tx_power_cmd_v3 - TX power reduction command version 3
+ * @per_chain: per chain restrictions
+ */
+struct iwl_dev_tx_power_cmd_v3 {
+	__le16 per_chain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
 } __packed; /* TX_REDUCED_POWER_API_S_VER_3 */
 
 #define IWL_DEV_MAX_TX_POWER 0x7FFF
 
 /**
- * struct iwl_dev_tx_power_cmd - TX power reduction command
- * @v3: version 3 of the command, embedded here for easier software handling
+ * struct iwl_dev_tx_power_cmd_v4 - TX power reduction command version 4
+ * @per_chain: per chain restrictions
  * @enable_ack_reduction: enable or disable close range ack TX power
  *	reduction.
  * @reserved: reserved (padding)
  */
 struct iwl_dev_tx_power_cmd_v4 {
-	/* v4 is just an extension of v3 - keep this here */
-	struct iwl_dev_tx_power_cmd_v3 v3;
+	__le16 per_chain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
 	u8 enable_ack_reduction;
 	u8 reserved[3];
 } __packed; /* TX_REDUCED_POWER_API_S_VER_4 */
 
 /**
- * struct iwl_dev_tx_power_cmd - TX power reduction command
- * @v3: version 3 of the command, embedded here for easier software handling
+ * struct iwl_dev_tx_power_cmd_v5 - TX power reduction command version 5
+ * @per_chain: per chain restrictions
  * @enable_ack_reduction: enable or disable close range ack TX power
  *	reduction.
  * @per_chain_restriction_changed: is per_chain_restriction has changed
@@ -382,15 +387,30 @@ struct iwl_dev_tx_power_cmd_v4 {
  * @timer_period: timer in milliseconds. if expires FW will change to default
  *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
  */
-struct iwl_dev_tx_power_cmd {
-	/* v5 is just an extension of v3 - keep this here */
-	struct iwl_dev_tx_power_cmd_v3 v3;
+struct iwl_dev_tx_power_cmd_v5 {
+	__le16 per_chain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
 	u8 enable_ack_reduction;
 	u8 per_chain_restriction_changed;
 	u8 reserved[2];
 	__le32 timer_period;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_5 */
 
+/**
+ * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
+ * @common: common part of the command
+ * @v3: version 3 part of the command
+ * @v4: version 4 part of the command
+ * @v5: version 5 part of the command
+ */
+struct iwl_dev_tx_power_cmd {
+	struct iwl_dev_tx_power_common common;
+	union {
+		struct iwl_dev_tx_power_cmd_v3 v3;
+		struct iwl_dev_tx_power_cmd_v4 v4;
+		struct iwl_dev_tx_power_cmd_v5 v5;
+	};
+};
+
 #define IWL_NUM_GEO_PROFILES   3
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f76ed9d10af3..fd8d6190ee24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -736,11 +736,8 @@ static int iwl_mvm_config_ltr(struct iwl_mvm *mvm)
 #ifdef CONFIG_ACPI
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 {
-	union {
-		struct iwl_dev_tx_power_cmd v5;
-		struct iwl_dev_tx_power_cmd_v4 v4;
-	} cmd = {
-		.v5.v3.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
+	struct iwl_dev_tx_power_cmd cmd = {
+		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
 	};
 	int ret;
 	u16 len = 0;
@@ -750,13 +747,14 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		len = sizeof(cmd.v5);
 	else if (fw_has_capa(&mvm->fw->ucode_capa,
 			     IWL_UCODE_TLV_CAPA_TX_POWER_ACK))
-		len = sizeof(struct iwl_dev_tx_power_cmd_v4);
+		len = sizeof(cmd.v4);
 	else
-		len = sizeof(cmd.v4.v3);
+		len = sizeof(cmd.v3);
 
+	/* all structs have the same common part, add it */
+	len += sizeof(cmd.common);
 
-	ret = iwl_sar_select_profile(&mvm->fwrt,
-				     cmd.v5.v3.per_chain_restriction,
+	ret = iwl_sar_select_profile(&mvm->fwrt, cmd.v5.per_chain,
 				     prof_a, prof_b);
 
 	/* return on error or if the profile is disabled (positive number) */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5e141eb47abc..2beb54f97532 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1308,18 +1308,15 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				s16 tx_power)
 {
 	int len;
-	union {
-		struct iwl_dev_tx_power_cmd v5;
-		struct iwl_dev_tx_power_cmd_v4 v4;
-	} cmd = {
-		.v5.v3.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC),
-		.v5.v3.mac_context_id =
+	struct iwl_dev_tx_power_cmd cmd = {
+		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC),
+		.common.mac_context_id =
 			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id),
-		.v5.v3.pwr_restriction = cpu_to_le16(8 * tx_power),
+		.common.pwr_restriction = cpu_to_le16(8 * tx_power),
 	};
 
 	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
-		cmd.v5.v3.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
+		cmd.common.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_REDUCE_TX_POWER))
@@ -1328,7 +1325,10 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     IWL_UCODE_TLV_CAPA_TX_POWER_ACK))
 		len = sizeof(cmd.v4);
 	else
-		len = sizeof(cmd.v4.v3);
+		len = sizeof(cmd.v3);
+
+	/* all structs have the same common part, add it */
+	len += sizeof(cmd.common);
 
 	return iwl_mvm_send_cmd_pdu(mvm, REDUCE_TX_POWER_CMD, 0, len, &cmd);
 }
-- 
2.28.0

