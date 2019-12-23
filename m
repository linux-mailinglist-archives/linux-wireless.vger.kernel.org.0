Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E891129BE0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLWXrm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54734 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726907AbfLWXrl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQI-00010j-Rw; Tue, 24 Dec 2019 01:47:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:20 +0200
Message-Id: <20191223234721.1513938-7-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223234721.1513938-1-luca@coelho.fi>
References: <20191223234721.1513938-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 6/7] iwlwifi: remove lar_disable module parameter
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This is an old parameter that was used supposed to be used only when
LAR was still under development.  It should not be used anymore, but,
since it's available, end-users have been mangling with it
unnecessarily.  In some cases it can cause problems because when LAR
is supported the driver and the firmware do not expect it to be
disabled.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  3 ---
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h |  2 --
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 13 +++++++------
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       | 10 ++--------
 6 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4096ccf58b07..bc8c959588ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1817,9 +1817,6 @@ MODULE_PARM_DESC(antenna_coupling,
 module_param_named(nvm_file, iwlwifi_mod_params.nvm_file, charp, 0444);
 MODULE_PARM_DESC(nvm_file, "NVM file name");
 
-module_param_named(lar_disable, iwlwifi_mod_params.lar_disable, bool, 0444);
-MODULE_PARM_DESC(lar_disable, "disable LAR functionality (default: N)");
-
 module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
 MODULE_PARM_DESC(uapsd_disable,
 		 "disable U-APSD functionality bitmap 1: BSS 2: P2P Client (default: 3)");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index ebea3f308b5d..82e5cac23d8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -115,7 +115,6 @@ enum iwl_uapsd_disable {
  * @nvm_file: specifies a external NVM file
  * @uapsd_disable: disable U-APSD, see &enum iwl_uapsd_disable, default =
  *	IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT
- * @lar_disable: disable LAR (regulatory), default = 0
  * @fw_monitor: allow to use firmware monitor
  * @disable_11ac: disable VHT capabilities, default = false.
  * @remove_when_gone: remove an inaccessible device from the PCIe bus.
@@ -136,7 +135,6 @@ struct iwl_mod_params {
 	int antenna_coupling;
 	char *nvm_file;
 	u32 uapsd_disable;
-	bool lar_disable;
 	bool fw_monitor;
 	bool disable_11ac;
 	/**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 068e4924c04e..d4f834b52f50 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -967,10 +967,11 @@ iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 struct iwl_nvm_data *
 iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+		   const struct iwl_fw *fw,
 		   const __be16 *nvm_hw, const __le16 *nvm_sw,
 		   const __le16 *nvm_calib, const __le16 *regulatory,
 		   const __le16 *mac_override, const __le16 *phy_sku,
-		   u8 tx_chains, u8 rx_chains, bool lar_fw_supported)
+		   u8 tx_chains, u8 rx_chains)
 {
 	struct iwl_nvm_data *data;
 	bool lar_enabled;
@@ -1050,7 +1051,8 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		return NULL;
 	}
 
-	if (lar_fw_supported && lar_enabled)
+	if (lar_enabled &&
+	    fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_LAR_SUPPORT))
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_LAR;
 
 	if (iwl_nvm_no_wide_in_5ghz(trans, cfg, nvm_hw))
@@ -1449,9 +1451,6 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP, NVM_GET_INFO)
 	};
 	int  ret;
-	bool lar_fw_supported = !iwlwifi_mod_params.lar_disable &&
-				fw_has_capa(&fw->ucode_capa,
-					    IWL_UCODE_TLV_CAPA_LAR_SUPPORT);
 	bool empty_otp;
 	u32 mac_flags;
 	u32 sbands_flags = 0;
@@ -1529,7 +1528,9 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	nvm->valid_tx_ant = (u8)le32_to_cpu(rsp->phy_sku.tx_chains);
 	nvm->valid_rx_ant = (u8)le32_to_cpu(rsp->phy_sku.rx_chains);
 
-	if (le32_to_cpu(rsp->regulatory.lar_enabled) && lar_fw_supported) {
+	if (le32_to_cpu(rsp->regulatory.lar_enabled) &&
+	    fw_has_capa(&fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_LAR_SUPPORT)) {
 		nvm->lar_enabled = true;
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_LAR;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 4eeedb41e9ac..fb0b385d10fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -85,10 +85,11 @@ enum iwl_nvm_sbands_flags {
  */
 struct iwl_nvm_data *
 iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+		   const struct iwl_fw *fw,
 		   const __be16 *nvm_hw, const __le16 *nvm_sw,
 		   const __le16 *nvm_calib, const __le16 *regulatory,
 		   const __le16 *mac_override, const __le16 *phy_sku,
-		   u8 tx_chains, u8 rx_chains, bool lar_fw_supported);
+		   u8 tx_chains, u8 rx_chains);
 
 /**
  * iwl_parse_mcc_info - parse MCC (mobile country code) info coming from FW
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e5b21f8b02e7..67ab7e7e9c9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1298,9 +1298,6 @@ static inline bool iwl_mvm_is_lar_supported(struct iwl_mvm *mvm)
 	bool tlv_lar = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_LAR_SUPPORT);
 
-	if (iwlwifi_mod_params.lar_disable)
-		return false;
-
 	/*
 	 * Enable LAR only if it is supported by the FW (TLV) &&
 	 * enabled in the NVM
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 493bcc54a848..46128a2a9c6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -277,7 +277,6 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 	struct iwl_nvm_section *sections = mvm->nvm_sections;
 	const __be16 *hw;
 	const __le16 *sw, *calib, *regulatory, *mac_override, *phy_sku;
-	bool lar_enabled;
 	int regulatory_type;
 
 	/* Checking for required sections */
@@ -327,14 +326,9 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 		(const __le16 *)sections[NVM_SECTION_TYPE_REGULATORY_SDP].data :
 		(const __le16 *)sections[NVM_SECTION_TYPE_REGULATORY].data;
 
-	lar_enabled = !iwlwifi_mod_params.lar_disable &&
-		      fw_has_capa(&mvm->fw->ucode_capa,
-				  IWL_UCODE_TLV_CAPA_LAR_SUPPORT);
-
-	return iwl_parse_nvm_data(mvm->trans, mvm->cfg, hw, sw, calib,
+	return iwl_parse_nvm_data(mvm->trans, mvm->cfg, mvm->fw, hw, sw, calib,
 				  regulatory, mac_override, phy_sku,
-				  mvm->fw->valid_tx_ant, mvm->fw->valid_rx_ant,
-				  lar_enabled);
+				  mvm->fw->valid_tx_ant, mvm->fw->valid_rx_ant);
 }
 
 /* Loads the NVM data stored in mvm->nvm_sections into the NIC */
-- 
2.24.0

