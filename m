Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711973AAD13
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQHLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47918 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230211AbhFQHLL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm97-001XeC-IV; Thu, 17 Jun 2021 10:09:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:49 +0300
Message-Id: <iwlwifi.20210617100544.80fee3171b53.Idfb69643f4044ec26865d023d0c2a1d6466694aa@changeid>
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
Subject: [PATCH 09/12] iwlwifi: advertise broadcast TWT support
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

If the firmware supports broadcast TWT (know by TLV),
add the broadcast TWT HE MAC capability.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 30 ++++++++++++-------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index f9c5cf538ad1..d189e5de478b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2008-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2008-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -411,6 +411,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_PROTECTED_TWT		= (__force iwl_ucode_tlv_capa_t)56,
 	IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE		= (__force iwl_ucode_tlv_capa_t)57,
 	IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN		= (__force iwl_ucode_tlv_capa_t)58,
+	IWL_UCODE_TLV_CAPA_BROADCAST_TWT		= (__force iwl_ucode_tlv_capa_t)60,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 46f92b58f009..4c2817c94d05 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -723,7 +723,8 @@ static void
 iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			 struct ieee80211_supported_band *sband,
 			 struct ieee80211_sband_iftype_data *iftype_data,
-			 u8 tx_chains, u8 rx_chains)
+			 u8 tx_chains, u8 rx_chains,
+			 const struct iwl_fw *fw)
 {
 	bool is_ap = iftype_data->types_mask & BIT(NL80211_IFTYPE_AP);
 
@@ -770,12 +771,17 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
 		break;
 	}
+
+	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_BROADCAST_TWT))
+		iftype_data->he_cap.he_cap_elem.mac_cap_info[2] |=
+			IEEE80211_HE_MAC_CAP2_BCAST_TWT;
 }
 
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 				 struct iwl_nvm_data *data,
 				 struct ieee80211_supported_band *sband,
-				 u8 tx_chains, u8 rx_chains)
+				 u8 tx_chains, u8 rx_chains,
+				 const struct iwl_fw *fw)
 {
 	struct ieee80211_sband_iftype_data *iftype_data;
 	int i;
@@ -807,7 +813,7 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 
 	for (i = 0; i < sband->n_iftype_data; i++)
 		iwl_nvm_fixup_sband_iftd(trans, sband, &iftype_data[i],
-					 tx_chains, rx_chains);
+					 tx_chains, rx_chains, fw);
 
 	iwl_init_he_6ghz_capa(trans, data, sband, tx_chains, rx_chains);
 }
@@ -815,7 +821,8 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 static void iwl_init_sbands(struct iwl_trans *trans,
 			    struct iwl_nvm_data *data,
 			    const void *nvm_ch_flags, u8 tx_chains,
-			    u8 rx_chains, u32 sbands_flags, bool v4)
+			    u8 rx_chains, u32 sbands_flags, bool v4,
+			    const struct iwl_fw *fw)
 {
 	struct device *dev = trans->dev;
 	const struct iwl_cfg *cfg = trans->cfg;
@@ -835,7 +842,8 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 			     tx_chains, rx_chains);
 
 	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
-		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains);
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
+				     fw);
 
 	sband = &data->bands[NL80211_BAND_5GHZ];
 	sband->band = NL80211_BAND_5GHZ;
@@ -850,7 +858,8 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 				      tx_chains, rx_chains);
 
 	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
-		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains);
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
+				     fw);
 
 	/* 6GHz band. */
 	sband = &data->bands[NL80211_BAND_6GHZ];
@@ -862,7 +871,8 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 					  NL80211_BAND_6GHZ);
 
 	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
-		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains);
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
+				     fw);
 	else
 		sband->n_channels = 0;
 	if (n_channels != n_used)
@@ -1133,7 +1143,7 @@ iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_LAR;
 
 	iwl_init_sbands(trans, data, mei_nvm->channels, tx_chains, rx_chains,
-			sbands_flags, true);
+			sbands_flags, true, fw);
 
 	return data;
 }
@@ -1233,7 +1243,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_NO_WIDE_IN_5GHZ;
 
 	iwl_init_sbands(trans, data, ch_section, tx_chains, rx_chains,
-			sbands_flags, false);
+			sbands_flags, false, fw);
 	data->calib_version = 255;
 
 	return data;
@@ -1740,7 +1750,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 			channel_profile,
 			nvm->valid_tx_ant & fw->valid_tx_ant,
 			nvm->valid_rx_ant & fw->valid_rx_ant,
-			sbands_flags, v4);
+			sbands_flags, v4, fw);
 
 	iwl_free_resp(&hcmd);
 	return nvm;
-- 
2.32.0

