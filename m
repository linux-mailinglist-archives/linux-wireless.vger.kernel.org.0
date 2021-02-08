Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE53132C6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 13:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBHMwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 07:52:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44538 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229698AbhBHMwu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 07:52:50 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l95yL-0047PC-4B; Mon, 08 Feb 2021 14:48:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  8 Feb 2021 14:48:47 +0200
Message-Id: <iwlwifi.20210208144305.247ce46062e5.I850f29d3ff3931388447bda635dfbc742ea1df61@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208124847.1934441-1-luca@coelho.fi>
References: <20210208124847.1934441-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi:mvm: Add support for version 2 of the LARI_CONFIG_CHANGE command.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add support for version 2 of the LARI_CONFIG_CHANGE command.
this is needed to support UHB enable/disable from BIOS

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 15 +++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       | 13 ++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index b2706209b7d7..fbca9dd872e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -415,14 +415,25 @@ enum iwl_lari_config_masks {
 };
 
 /**
- * struct iwl_lari_config_change_cmd - change LARI configuration
+ * struct iwl_lari_config_change_cmd_v1 - change LARI configuration
  * @config_bitmap: bit map of the config commands. each bit will trigger a
  * different predefined FW config operation
  */
-struct iwl_lari_config_change_cmd {
+struct iwl_lari_config_change_cmd_v1 {
 	__le32 config_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_1 */
 
+/**
+ * struct iwl_lari_config_change_cmd_v2 - change LARI configuration
+ * @config_bitmap: bit map of the config commands. each bit will trigger a
+ * different predefined FW config operation
+ * @oem_uhb_allow_bitmap: bitmap of UHB enabled MCC sets
+ */
+struct iwl_lari_config_change_cmd_v2 {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_2 */
+
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
  * @status: PNVM image loading status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 992f99205ffb..6701c37ca5ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1193,7 +1193,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	u8 ret;
 	int cmd_ret;
-	struct iwl_lari_config_change_cmd cmd = {};
+	struct iwl_lari_config_change_cmd_v2 cmd = {};
 
 	if (iwl_mvm_eval_dsm_indonesia_5g2(mvm) == DSM_VALUE_INDONESIA_ENABLE)
 		cmd.config_bitmap |=
@@ -1211,11 +1211,18 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	/* apply more config masks here */
 
 	if (cmd.config_bitmap) {
-		IWL_DEBUG_RADIO(mvm, "sending LARI_CONFIG_CHANGE\n");
+		size_t cmd_size = iwl_fw_lookup_cmd_ver(mvm->fw,
+							REGULATORY_AND_NVM_GROUP,
+							LARI_CONFIG_CHANGE, 1) == 2 ?
+			sizeof(struct iwl_lari_config_change_cmd_v2) :
+			sizeof(struct iwl_lari_config_change_cmd_v1);
+		IWL_DEBUG_RADIO(mvm,
+				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x\n",
+				le32_to_cpu(cmd.config_bitmap));
 		cmd_ret = iwl_mvm_send_cmd_pdu(mvm,
 					       WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						       LARI_CONFIG_CHANGE),
-					       0, sizeof(cmd), &cmd);
+					       0, cmd_size, &cmd);
 		if (cmd_ret < 0)
 			IWL_DEBUG_RADIO(mvm,
 					"Failed to send LARI_CONFIG_CHANGE (%d)\n",
-- 
2.30.0

