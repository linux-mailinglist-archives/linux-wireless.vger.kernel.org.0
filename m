Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213B443098B
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbhJQOCS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53976 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343806AbhJQOCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hm-000Yi6-Rk; Sun, 17 Oct 2021 17:00:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:52 +0300
Message-Id: <iwlwifi.20211017165728.23d4f2d182c0.I39ac5ff74ac6f2223f393657205eddc1c8e48890@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/10] iwlwifi: mvm: Read acpi dsm to get channel activation bitmap
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Read the bitmap from the ACPI and pass it to he FW
through LARI_CONFIG_CHANGE_CMD.

This allows OEMs to override channel state to active
as per Geo Location bitmap.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  3 ++-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 23 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 18 +++++++++++----
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 16ed0995b51e..0822c6b15c43 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -116,7 +116,8 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_DISABLE_SRD = 1,
 	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
 	DSM_FUNC_11AX_ENABLEMENT = 6,
-	DSM_FUNC_ENABLE_UNII4_CHAN = 7
+	DSM_FUNC_ENABLE_UNII4_CHAN = 7,
+	DSM_FUNC_ACTIVATE_CHANNEL = 8
 };
 
 enum iwl_dsm_values_srd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index cf48c6fa8f65..3551a3f1c1aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -471,6 +471,29 @@ struct iwl_lari_config_change_cmd_v4 {
 	__le32 oem_unii4_allow_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_4 */
 
+/**
+ * struct iwl_lari_config_change_cmd_v5 - change LARI configuration
+ * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
+ *     different predefined FW config operation.
+ * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
+ * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
+ *     per country, one to indicate whether to override and the other to
+ *     indicate the value to use.
+ * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
+ *     per country, one to indicate whether to override and the other to
+ *     indicate allow/disallow unii4 channels.
+ * @chan_state_active_bitmap: Bitmap for overriding channel state to active.
+ *     Each bit represents a country or region to activate, according to the BIOS
+ *     definitions.
+ */
+struct iwl_lari_config_change_cmd_v5 {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+	__le32 oem_11ax_allow_bitmap;
+	__le32 oem_unii4_allow_bitmap;
+	__le32 chan_state_active_bitmap;
+} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_5 */
+
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
  * @status: PNVM image loading status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 660860b8d02f..410a8d20d56e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1139,7 +1139,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	int ret;
 	u32 value;
-	struct iwl_lari_config_change_cmd_v4 cmd = {};
+	struct iwl_lari_config_change_cmd_v5 cmd = {};
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
@@ -1155,14 +1155,23 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	if (!ret)
 		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
 
+	ret = iwl_acpi_get_dsm_u32((&mvm->fwrt)->dev, 0,
+				   DSM_FUNC_ACTIVATE_CHANNEL,
+				   &iwl_guid, &value);
+	if (!ret)
+		cmd.chan_state_active_bitmap = cpu_to_le32(value);
+
 	if (cmd.config_bitmap ||
 	    cmd.oem_11ax_allow_bitmap ||
-	    cmd.oem_unii4_allow_bitmap) {
+	    cmd.oem_unii4_allow_bitmap ||
+	    cmd.chan_state_active_bitmap) {
 		size_t cmd_size;
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 						   REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE, 1);
-		if (cmd_ver == 4)
+		if (cmd_ver == 5)
+			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v5);
+		else if (cmd_ver == 4)
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v4);
 		else if (cmd_ver == 3)
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v3);
@@ -1176,8 +1185,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 				le32_to_cpu(cmd.config_bitmap),
 				le32_to_cpu(cmd.oem_11ax_allow_bitmap));
 		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, oem_unii4_allow_bitmap=0x%x, cmd_ver=%d\n",
+				"sending LARI_CONFIG_CHANGE, oem_unii4_allow_bitmap=0x%x, chan_state_active_bitmap=0x%x, cmd_ver=%d\n",
 				le32_to_cpu(cmd.oem_unii4_allow_bitmap),
+				le32_to_cpu(cmd.chan_state_active_bitmap),
 				cmd_ver);
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-- 
2.33.0

