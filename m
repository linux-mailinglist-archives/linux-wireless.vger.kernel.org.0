Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3A3AAD22
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFQHNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:13:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47932 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229816AbhFQHNE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:13:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm9A-001XeC-6X; Thu, 17 Jun 2021 10:09:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:52 +0300
Message-Id: <iwlwifi.20210617100544.223090c509c4.If03cb5393607ae494041b6187bcec134d6a1e06d@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617070852.496985-1-luca@coelho.fi>
References: <20210617070852.496985-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 12/12] iwlwifi: mvm: Read acpi dsm to get unii4 enable/disable bitmap.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

Read the UNII4 setting from the ACPI table and use it in the
LARI_CONFIG_CHANGE_CMD accordingly.

This setting allows OEMs to enable or disable UNII4, bypassing the FW
defaults.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  1 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 19 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 20 ++++++++++++++++---
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 9fe64476083d..b858e998999c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -78,6 +78,7 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_DISABLE_SRD = 1,
 	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
 	DSM_FUNC_11AX_ENABLEMENT = 6,
+	DSM_FUNC_ENABLE_UNII4_CHAN = 7
 };
 
 enum iwl_dsm_values_srd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index dc8f2777e944..cf48c6fa8f65 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -452,6 +452,25 @@ struct iwl_lari_config_change_cmd_v3 {
 	__le32 oem_11ax_allow_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_3 */
 
+/**
+ * struct iwl_lari_config_change_cmd_v4 - change LARI configuration
+ * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
+ *     different predefined FW config operation.
+ * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
+ * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
+ *     per country, one to indicate whether to override and the other to
+ *     indicate the value to use.
+ * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
+ *     per country, one to indicate whether to override and the other to
+ *     indicate allow/disallow unii4 channels.
+ */
+struct iwl_lari_config_change_cmd_v4 {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+	__le32 oem_11ax_allow_bitmap;
+	__le32 oem_unii4_allow_bitmap;
+} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_4 */
+
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
  * @status: PNVM image loading status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 8af24e446634..36ccfa302406 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1143,7 +1143,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	int ret;
 	u32 value;
-	struct iwl_lari_config_change_cmd_v3 cmd = {};
+	struct iwl_lari_config_change_cmd_v4 cmd = {};
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
@@ -1153,12 +1153,22 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
 	/* apply more config masks here */
 
-	if (cmd.config_bitmap || cmd.oem_11ax_allow_bitmap) {
+	ret = iwl_acpi_get_dsm_u32((&mvm->fwrt)->dev, 0,
+				   DSM_FUNC_ENABLE_UNII4_CHAN,
+				   &iwl_guid, &value);
+	if (!ret)
+		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
+
+	if (cmd.config_bitmap ||
+	    cmd.oem_11ax_allow_bitmap ||
+	    cmd.oem_unii4_allow_bitmap) {
 		size_t cmd_size;
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 						   REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE, 1);
-		if (cmd_ver == 3)
+		if (cmd_ver == 4)
+			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v4);
+		else if (cmd_ver == 3)
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v3);
 		else if (cmd_ver == 2)
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v2);
@@ -1169,6 +1179,10 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
 				le32_to_cpu(cmd.config_bitmap),
 				le32_to_cpu(cmd.oem_11ax_allow_bitmap));
+		IWL_DEBUG_RADIO(mvm,
+				"sending LARI_CONFIG_CHANGE, oem_unii4_allow_bitmap=0x%x, cmd_ver=%d\n",
+				le32_to_cpu(cmd.oem_unii4_allow_bitmap),
+				cmd_ver);
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE),
-- 
2.32.0

