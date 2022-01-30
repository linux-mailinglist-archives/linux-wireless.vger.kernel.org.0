Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432BA4A3583
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354550AbiA3JxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:16 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37910 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354542AbiA3JxP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:15 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tV-0003JO-Ep;
        Sun, 30 Jan 2022 11:53:14 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:53:02 +0200
Message-Id: <iwlwifi.20220130115024.26c0044110cc.Ie0d215a22618e7a3ecc39eca349914981b608b4d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: remove unused DC2DC_CONFIG_CMD definitions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We haven't used this command for a long time, if ever, so we can
remove all related definitions.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  8 -----
 .../wireless/intel/iwlwifi/fw/api/config.h    | 33 -------------------
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 -
 4 files changed, 44 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 0703e41403a6..dded6e8a074a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -322,14 +322,6 @@ enum iwl_legacy_cmds {
 	 */
 	REPLY_THERMAL_MNG_BACKOFF = 0x7e,
 
-	/**
-	 * @DC2DC_CONFIG_CMD:
-	 * Set/Get DC2DC frequency tune
-	 * Command is &struct iwl_dc2dc_config_cmd,
-	 * response is &struct iwl_dc2dc_config_resp
-	 */
-	DC2DC_CONFIG_CMD = 0x83,
-
 	/**
 	 * @NVM_ACCESS_CMD: using &struct iwl_nvm_access_cmd
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
index 1ab92f62c414..087354b3c308 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
@@ -114,37 +114,4 @@ enum iwl_dc2dc_config_id {
 	DCDC_FREQ_TUNE_SET = 0x2,
 }; /* MARKER_ID_API_E_VER_1 */
 
-/**
- * struct iwl_dc2dc_config_cmd - configure dc2dc values
- *
- * (DC2DC_CONFIG_CMD = 0x83)
- *
- * Set/Get & configure dc2dc values.
- * The command always returns the current dc2dc values.
- *
- * @flags: set/get dc2dc
- * @enable_low_power_mode: not used.
- * @dc2dc_freq_tune0: frequency divider - digital domain
- * @dc2dc_freq_tune1: frequency divider - analog domain
- */
-struct iwl_dc2dc_config_cmd {
-	__le32 flags;
-	__le32 enable_low_power_mode; /* not used */
-	__le32 dc2dc_freq_tune0;
-	__le32 dc2dc_freq_tune1;
-} __packed; /* DC2DC_CONFIG_CMD_API_S_VER_1 */
-
-/**
- * struct iwl_dc2dc_config_resp - response for iwl_dc2dc_config_cmd
- *
- * Current dc2dc values returned by the FW.
- *
- * @dc2dc_freq_tune0: frequency divider - digital domain
- * @dc2dc_freq_tune1: frequency divider - analog domain
- */
-struct iwl_dc2dc_config_resp {
-	__le32 dc2dc_freq_tune0;
-	__le32 dc2dc_freq_tune1;
-} __packed; /* DC2DC_CONFIG_RESP_API_S_VER_1 */
-
 #endif /* __iwl_fw_api_config_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index e7d3032cd3f9..5b30136983c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -312,7 +312,6 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  * @IWL_UCODE_TLV_CAPA_TDLS_CHANNEL_SWITCH: supports TDLS channel switching
  * @IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG: Consolidated D3-D0 image
  * @IWL_UCODE_TLV_CAPA_HOTSPOT_SUPPORT: supports Hot Spot Command
- * @IWL_UCODE_TLV_CAPA_DC2DC_SUPPORT: supports DC2DC Command
  * @IWL_UCODE_TLV_CAPA_CSUM_SUPPORT: supports TCP Checksum Offload
  * @IWL_UCODE_TLV_CAPA_RADIO_BEACON_STATS: support radio and beacon statistics
  * @IWL_UCODE_TLV_CAPA_P2P_SCM_UAPSD: supports U-APSD on p2p interface when it
@@ -388,7 +387,6 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_TDLS_CHANNEL_SWITCH		= (__force iwl_ucode_tlv_capa_t)13,
 	IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG		= (__force iwl_ucode_tlv_capa_t)17,
 	IWL_UCODE_TLV_CAPA_HOTSPOT_SUPPORT		= (__force iwl_ucode_tlv_capa_t)18,
-	IWL_UCODE_TLV_CAPA_DC2DC_CONFIG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)19,
 	IWL_UCODE_TLV_CAPA_CSUM_SUPPORT			= (__force iwl_ucode_tlv_capa_t)21,
 	IWL_UCODE_TLV_CAPA_RADIO_BEACON_STATS		= (__force iwl_ucode_tlv_capa_t)22,
 	IWL_UCODE_TLV_CAPA_P2P_SCM_UAPSD		= (__force iwl_ucode_tlv_capa_t)26,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index fd866ab38e18..5626eb091943 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -449,7 +449,6 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(POWER_TABLE_CMD),
 	HCMD_NAME(PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION),
 	HCMD_NAME(REPLY_THERMAL_MNG_BACKOFF),
-	HCMD_NAME(DC2DC_CONFIG_CMD),
 	HCMD_NAME(NVM_ACCESS_CMD),
 	HCMD_NAME(BEACON_NOTIFICATION),
 	HCMD_NAME(BEACON_TEMPLATE_CMD),
-- 
2.34.1

