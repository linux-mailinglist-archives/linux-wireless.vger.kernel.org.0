Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192CE4AA7D8
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348174AbiBEJVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37996 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345248AbiBEJVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:51 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGP-0006b7-L9;
        Sat, 05 Feb 2022 11:21:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:35 +0200
Message-Id: <iwlwifi.20220205112029.9e6d9209293d.If5b22a9afe5f9dac9c7c45e68e494ffce4df8910@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: mvm: Disable WiFi bands selectively with BIOS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

The BIOS can contain data about sets of disabled channels.
Pass the bitmap to the firmware if present.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  5 +--
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 28 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 36 ++++++++++++++-----
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 5ac0979123fc..466c95c21aa9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #ifndef __iwl_fw_acpi__
 #define __iwl_fw_acpi__
@@ -128,7 +128,8 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_ENABLE_6E = 3,
 	DSM_FUNC_11AX_ENABLEMENT = 6,
 	DSM_FUNC_ENABLE_UNII4_CHAN = 7,
-	DSM_FUNC_ACTIVATE_CHANNEL = 8
+	DSM_FUNC_ACTIVATE_CHANNEL = 8,
+	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9
 };
 
 enum iwl_dsm_values_srd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index fc85ec426f43..91bfde6d5367 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -538,6 +538,32 @@ struct iwl_lari_config_change_cmd_v5 {
 	__le32 chan_state_active_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_5 */
 
+/**
+ * struct iwl_lari_config_change_cmd_v6 - change LARI configuration
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
+ * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
+ *     Each bit represents a set of channels in a specific band that should be disabled
+ */
+struct iwl_lari_config_change_cmd_v6 {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+	__le32 oem_11ax_allow_bitmap;
+	__le32 oem_unii4_allow_bitmap;
+	__le32 chan_state_active_bitmap;
+	__le32 force_disable_channels_bitmap;
+} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_6 */
+
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
  * @status: PNVM image loading status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 135a715d924b..77953ee708d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1313,7 +1313,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	int ret;
 	u32 value;
-	struct iwl_lari_config_change_cmd_v5 cmd = {};
+	struct iwl_lari_config_change_cmd_v6 cmd = {};
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
@@ -1340,26 +1340,43 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	if (!ret)
 		cmd.oem_uhb_allow_bitmap = cpu_to_le32(value);
 
+	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
+				   DSM_FUNC_FORCE_DISABLE_CHANNELS,
+				   &iwl_guid, &value);
+	if (!ret)
+		cmd.force_disable_channels_bitmap = cpu_to_le32(value);
+
 	if (cmd.config_bitmap ||
 	    cmd.oem_uhb_allow_bitmap ||
 	    cmd.oem_11ax_allow_bitmap ||
 	    cmd.oem_unii4_allow_bitmap ||
-	    cmd.chan_state_active_bitmap) {
+	    cmd.chan_state_active_bitmap ||
+	    cmd.force_disable_channels_bitmap) {
 		size_t cmd_size;
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 						   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 							   LARI_CONFIG_CHANGE),
 						   1);
-		if (cmd_ver == 5)
+		switch (cmd_ver) {
+		case 6:
+			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v6);
+			break;
+		case 5:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v5);
-		else if (cmd_ver == 4)
+			break;
+		case 4:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v4);
-		else if (cmd_ver == 3)
+			break;
+		case 3:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v3);
-		else if (cmd_ver == 2)
+			break;
+		case 2:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v2);
-		else
+			break;
+		default:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
+			break;
+		}
 
 		IWL_DEBUG_RADIO(mvm,
 				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
@@ -1371,8 +1388,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 				le32_to_cpu(cmd.chan_state_active_bitmap),
 				cmd_ver);
 		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x\n",
-				le32_to_cpu(cmd.oem_uhb_allow_bitmap));
+				"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x, force_disable_channels_bitmap=0x%x\n",
+				le32_to_cpu(cmd.oem_uhb_allow_bitmap),
+				le32_to_cpu(cmd.force_disable_channels_bitmap));
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE),
-- 
2.34.1

