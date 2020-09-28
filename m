Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517BB27AA9E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1JX3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52742 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbgI1JX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:29 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNW-002KgD-N9; Mon, 28 Sep 2020 12:23:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:12 +0300
Message-Id: <iwlwifi.20200928121852.d709a8f17d1d.I9fa54883667c72dabf6d813c70be77538d9af38d@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: support REDUCE_TX_POWER_CMD version 6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The new version of the command can support more subbands and CDB, so
it can contain more data than earlier versions.  Implement support for
the new version of the command, even though we don't have more data to
write to it yet.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 24 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 20 ++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  8 +++++--
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 28bb361fd0da..062e34b5b4f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -330,6 +330,7 @@ enum iwl_dev_tx_power_cmd_mode {
 }; /* TX_POWER_REDUCED_FLAGS_TYPE_API_E_VER_5 */;
 
 #define IWL_NUM_CHAIN_TABLES	1
+#define IWL_NUM_CHAIN_TABLES_V2	2
 #define IWL_NUM_CHAIN_LIMITS	2
 #define IWL_NUM_SUB_BANDS	5
 #define IWL_NUM_SUB_BANDS_V2	11
@@ -396,12 +397,34 @@ struct iwl_dev_tx_power_cmd_v5 {
 	__le32 timer_period;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_5 */
 
+/**
+ * struct iwl_dev_tx_power_cmd_v5 - TX power reduction command version 5
+ * @per_chain: per chain restrictions
+ * @enable_ack_reduction: enable or disable close range ack TX power
+ *	reduction.
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ */
+struct iwl_dev_tx_power_cmd_v6 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+	u8 enable_ack_reduction;
+	u8 per_chain_restriction_changed;
+	u8 reserved[2];
+	__le32 timer_period;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_6 */
+
 /**
  * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
  * @common: common part of the command
  * @v3: version 3 part of the command
  * @v4: version 4 part of the command
  * @v5: version 5 part of the command
+ * @v6: version 6 part of the command
  */
 struct iwl_dev_tx_power_cmd {
 	struct iwl_dev_tx_power_common common;
@@ -409,6 +432,7 @@ struct iwl_dev_tx_power_cmd {
 		struct iwl_dev_tx_power_cmd_v3 v3;
 		struct iwl_dev_tx_power_cmd_v4 v4;
 		struct iwl_dev_tx_power_cmd_v5 v5;
+		struct iwl_dev_tx_power_cmd_v6 v6;
 	};
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d55a8768ff6d..f3e149e70c67 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -742,17 +742,27 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	__le16 *per_chain;
 	int ret;
 	u16 len = 0;
-
-	if (fw_has_api(&mvm->fw->ucode_capa,
-		       IWL_UCODE_TLV_API_REDUCE_TX_POWER)) {
+	u32 n_subbands;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					   REDUCE_TX_POWER_CMD);
+
+	if (cmd_ver == 6) {
+		len = sizeof(cmd.v6);
+		n_subbands = IWL_NUM_SUB_BANDS_V2;
+		per_chain = cmd.v6.per_chain[0][0];
+	} else if (fw_has_api(&mvm->fw->ucode_capa,
+			      IWL_UCODE_TLV_API_REDUCE_TX_POWER)) {
 		len = sizeof(cmd.v5);
+		n_subbands = IWL_NUM_SUB_BANDS;
 		per_chain = cmd.v5.per_chain[0][0];
 	} else if (fw_has_capa(&mvm->fw->ucode_capa,
-			     IWL_UCODE_TLV_CAPA_TX_POWER_ACK)) {
+			       IWL_UCODE_TLV_CAPA_TX_POWER_ACK)) {
 		len = sizeof(cmd.v4);
+		n_subbands = IWL_NUM_SUB_BANDS;
 		per_chain = cmd.v4.per_chain[0][0];
 	} else {
 		len = sizeof(cmd.v3);
+		n_subbands = IWL_NUM_SUB_BANDS;
 		per_chain = cmd.v3.per_chain[0][0];
 	}
 
@@ -760,7 +770,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	len += sizeof(cmd.common);
 
 	ret = iwl_sar_select_profile(&mvm->fwrt, per_chain, ACPI_SAR_NUM_TABLES,
-				     ACPI_SAR_NUM_SUB_BANDS, prof_a, prof_b);
+				     n_subbands, prof_a, prof_b);
 
 	/* return on error or if the profile is disabled (positive number) */
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2beb54f97532..38666a181144 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1314,12 +1314,16 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id),
 		.common.pwr_restriction = cpu_to_le16(8 * tx_power),
 	};
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					   REDUCE_TX_POWER_CMD);
 
 	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
 		cmd.common.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
 
-	if (fw_has_api(&mvm->fw->ucode_capa,
-		       IWL_UCODE_TLV_API_REDUCE_TX_POWER))
+	if (cmd_ver == 6)
+		len = sizeof(cmd.v6);
+	else if (fw_has_api(&mvm->fw->ucode_capa,
+			    IWL_UCODE_TLV_API_REDUCE_TX_POWER))
 		len = sizeof(cmd.v5);
 	else if (fw_has_capa(&mvm->fw->ucode_capa,
 			     IWL_UCODE_TLV_CAPA_TX_POWER_ACK))
-- 
2.28.0

