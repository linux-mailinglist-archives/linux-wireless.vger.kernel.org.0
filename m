Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D133E1277
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbhHEKT5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:19:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51218 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240012AbhHEKT4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:56 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTT-00240Q-By; Thu, 05 Aug 2021 13:19:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:26 +0300
Message-Id: <iwlwifi.20210805130823.c99f86423702.Icf7d4e93be77ea05a80235d01851ad0155593de9@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805101934.431479-1-luca@coelho.fi>
References: <20210805101934.431479-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/12] iwlwifi: mvm: d3: add separate key iteration for GTK type
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we're sending the KEK/KCK data we also need the GTK and
IGTK type, add a separate key iteration for that so we can
make the configure_key iteration optional later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 63 +++++++++++++++------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 0979fc18d4fb..61490f17a1fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -102,7 +102,6 @@ static const u8 *iwl_mvm_find_max_pn(struct ieee80211_key_conf *key,
 }
 
 struct wowlan_key_data {
-	struct iwl_wowlan_kek_kck_material_cmd_v4 *kek_kck_cmd;
 	bool error, configure_keys;
 	int wep_key_idx;
 };
@@ -174,10 +173,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		return;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
 		return;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_CCM);
 		/*
 		 * Ignore CMAC keys -- the WoWLAN firmware doesn't support them
 		 * but we also shouldn't abort suspend due to that. It does have
@@ -187,23 +184,12 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		 */
 		return;
 	case WLAN_CIPHER_SUITE_TKIP:
-		if (!sta)
-			data->kek_kck_cmd->gtk_cipher =
-				cpu_to_le32(STA_KEY_FLG_TKIP);
-		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		if (!sta)
-			data->kek_kck_cmd->gtk_cipher =
-				key->cipher == WLAN_CIPHER_SUITE_CCMP ?
-				cpu_to_le32(STA_KEY_FLG_CCM) :
-				cpu_to_le32(STA_KEY_FLG_GCMP);
 		break;
 	}
 
-	IWL_DEBUG_WOWLAN(mvm, "GTK cipher %d\n", data->kek_kck_cmd->gtk_cipher);
-
 	if (data->configure_keys) {
 		mutex_lock(&mvm->mutex);
 		/*
@@ -452,6 +438,42 @@ static void iwl_mvm_wowlan_get_tkip_data(struct ieee80211_hw *hw,
 	}
 }
 
+struct wowlan_key_gtk_type_iter {
+	struct iwl_wowlan_kek_kck_material_cmd_v4 *kek_kck_cmd;
+};
+
+static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 struct ieee80211_key_conf *key,
+					 void *_data)
+{
+	struct wowlan_key_gtk_type_iter *data = _data;
+
+	switch (key->cipher) {
+	default:
+		return;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
+		return;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_CCM);
+		return;
+	case WLAN_CIPHER_SUITE_CCMP:
+		if (!sta)
+			data->kek_kck_cmd->gtk_cipher =
+				cpu_to_le32(STA_KEY_FLG_CCM);
+		break;
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		if (!sta)
+			data->kek_kck_cmd->gtk_cipher =
+				cpu_to_le32(STA_KEY_FLG_GCMP);
+		break;
+	}
+}
+
 static int iwl_mvm_send_patterns_v1(struct iwl_mvm *mvm,
 				    struct cfg80211_wowlan *wowlan)
 {
@@ -815,13 +837,10 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif)
 {
-	struct iwl_wowlan_kek_kck_material_cmd_v4 kek_kck_cmd = {};
-	struct iwl_wowlan_kek_kck_material_cmd_v4 *_kek_kck_cmd = &kek_kck_cmd;
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 	struct wowlan_key_data key_data = {
 		.configure_keys = !unified,
-		.kek_kck_cmd = _kek_kck_cmd,
 	};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -884,6 +903,13 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 
 	/* configure rekey data only if offloaded rekey is supported (d3) */
 	if (mvmvif->rekey_data.valid) {
+		struct iwl_wowlan_kek_kck_material_cmd_v4 kek_kck_cmd = {};
+		struct iwl_wowlan_kek_kck_material_cmd_v4 *_kek_kck_cmd =
+			&kek_kck_cmd;
+		struct wowlan_key_gtk_type_iter gtk_type_data = {
+			.kek_kck_cmd = _kek_kck_cmd,
+		};
+
 		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 						IWL_ALWAYS_LONG_GROUP,
 						WOWLAN_KEK_KCK_MATERIAL,
@@ -892,6 +918,9 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 			    cmd_ver != IWL_FW_CMD_VER_UNKNOWN))
 			return -EINVAL;
 
+		ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_gtk_type_iter,
+				    &gtk_type_data);
+
 		memcpy(kek_kck_cmd.kck, mvmvif->rekey_data.kck,
 		       mvmvif->rekey_data.kck_len);
 		kek_kck_cmd.kck_len = cpu_to_le16(mvmvif->rekey_data.kck_len);
-- 
2.32.0

