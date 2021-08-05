Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647CA3E1276
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhHEKTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:19:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51212 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240169AbhHEKTz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:55 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTS-00240Q-9N; Thu, 05 Aug 2021 13:19:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:25 +0300
Message-Id: <iwlwifi.20210805130823.78e431c9aaeb.I5b83b8b30e3e7c04706a1f99b3970e4e5f36af9e@changeid>
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
Subject: [PATCH 03/12] iwlwifi: mvm: d3: refactor TSC/RSC configuration
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Refactor the TSC/RSC configuration out from the normal wowlan
key iteration so we can replace it later with a different one
adapted to a different firmware API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 197 ++++++++++++--------
 1 file changed, 116 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 0d87de66bf8d..0979fc18d4fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -102,9 +102,8 @@ static const u8 *iwl_mvm_find_max_pn(struct ieee80211_key_conf *key,
 }
 
 struct wowlan_key_data {
-	struct iwl_wowlan_rsc_tsc_params_cmd *rsc_tsc;
 	struct iwl_wowlan_kek_kck_material_cmd_v4 *kek_kck_cmd;
-	bool error, use_rsc_tsc, configure_keys;
+	bool error, configure_keys;
 	int wep_key_idx;
 };
 
@@ -117,10 +116,7 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct wowlan_key_data *data = _data;
-	struct aes_sc *aes_sc, *aes_tx_sc = NULL;
-	struct tkip_sc *tkip_sc, *tkip_tx_sc = NULL;
-	struct ieee80211_key_seq seq;
-	int ret, i;
+	int ret;
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
@@ -190,6 +186,71 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		 * be deauthenticated, but that was considered acceptable.
 		 */
 		return;
+	case WLAN_CIPHER_SUITE_TKIP:
+		if (!sta)
+			data->kek_kck_cmd->gtk_cipher =
+				cpu_to_le32(STA_KEY_FLG_TKIP);
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		if (!sta)
+			data->kek_kck_cmd->gtk_cipher =
+				key->cipher == WLAN_CIPHER_SUITE_CCMP ?
+				cpu_to_le32(STA_KEY_FLG_CCM) :
+				cpu_to_le32(STA_KEY_FLG_GCMP);
+		break;
+	}
+
+	IWL_DEBUG_WOWLAN(mvm, "GTK cipher %d\n", data->kek_kck_cmd->gtk_cipher);
+
+	if (data->configure_keys) {
+		mutex_lock(&mvm->mutex);
+		/*
+		 * The D3 firmware hardcodes the key offset 0 as the key it
+		 * uses to transmit packets to the AP, i.e. the PTK.
+		 */
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+			mvm->ptk_ivlen = key->iv_len;
+			mvm->ptk_icvlen = key->icv_len;
+			ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 0);
+		} else {
+			/*
+			 * firmware only supports TSC/RSC for a single key,
+			 * so if there are multiple keep overwriting them
+			 * with new ones -- this relies on mac80211 doing
+			 * list_add_tail().
+			 */
+			mvm->gtk_ivlen = key->iv_len;
+			mvm->gtk_icvlen = key->icv_len;
+			ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 1);
+		}
+		mutex_unlock(&mvm->mutex);
+		data->error = ret != 0;
+	}
+}
+
+struct wowlan_key_rsc_tsc_data {
+	struct iwl_wowlan_rsc_tsc_params_cmd *rsc_tsc;
+	bool have_rsc_tsc;
+};
+
+static void iwl_mvm_wowlan_get_rsc_tsc_data(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct ieee80211_sta *sta,
+					    struct ieee80211_key_conf *key,
+					    void *_data)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct wowlan_key_rsc_tsc_data *data = _data;
+	struct aes_sc *aes_sc;
+	struct tkip_sc *tkip_sc, *tkip_tx_sc = NULL;
+	struct ieee80211_key_seq seq;
+	int i;
+
+	switch (key->cipher) {
+	default:
+		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		if (sta) {
 			u64 pn64;
@@ -205,8 +266,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		} else {
 			tkip_sc =
 			  data->rsc_tsc->params.all_tsc_rsc.tkip.multicast_rsc;
-			data->kek_kck_cmd->gtk_cipher =
-				cpu_to_le32(STA_KEY_FLG_TKIP);
 		}
 
 		/*
@@ -220,12 +279,13 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			tkip_sc[i].iv32 = cpu_to_le32(seq.tkip.iv32);
 		}
 
-		data->use_rsc_tsc = true;
+		data->have_rsc_tsc = true;
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		if (sta) {
+			struct aes_sc *aes_tx_sc;
 			u64 pn64;
 
 			aes_sc =
@@ -238,10 +298,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		} else {
 			aes_sc =
 			   data->rsc_tsc->params.all_tsc_rsc.aes.multicast_rsc;
-			data->kek_kck_cmd->gtk_cipher =
-				key->cipher == WLAN_CIPHER_SUITE_CCMP ?
-				cpu_to_le32(STA_KEY_FLG_CCM) :
-				cpu_to_le32(STA_KEY_FLG_GCMP);
 		}
 
 		/*
@@ -286,36 +342,48 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 							   ((u64)pn[0] << 40));
 			}
 		}
-		data->use_rsc_tsc = true;
+		data->have_rsc_tsc = true;
 		break;
 	}
+}
 
-	IWL_DEBUG_WOWLAN(mvm, "GTK cipher %d\n", data->kek_kck_cmd->gtk_cipher);
+static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					WOWLAN_TSC_RSC_PARAM,
+					IWL_FW_CMD_VER_UNKNOWN);
+	struct wowlan_key_rsc_tsc_data data = {};
+	int size;
+	int ret;
 
-	if (data->configure_keys) {
-		mutex_lock(&mvm->mutex);
-		/*
-		 * The D3 firmware hardcodes the key offset 0 as the key it
-		 * uses to transmit packets to the AP, i.e. the PTK.
-		 */
-		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
-			mvm->ptk_ivlen = key->iv_len;
-			mvm->ptk_icvlen = key->icv_len;
-			ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 0);
-		} else {
-			/*
-			 * firmware only supports TSC/RSC for a single key,
-			 * so if there are multiple keep overwriting them
-			 * with new ones -- this relies on mac80211 doing
-			 * list_add_tail().
-			 */
-			mvm->gtk_ivlen = key->iv_len;
-			mvm->gtk_icvlen = key->icv_len;
-			ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 1);
-		}
-		mutex_unlock(&mvm->mutex);
-		data->error = ret != 0;
+	data.rsc_tsc = kzalloc(sizeof(*data.rsc_tsc), GFP_KERNEL);
+	if (!data.rsc_tsc)
+		return -ENOMEM;
+
+	if (ver == 4) {
+		size = sizeof(*data.rsc_tsc);
+		data.rsc_tsc->sta_id = cpu_to_le32(mvmvif->ap_sta_id);
+	} else if (ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN) {
+		size = sizeof(data.rsc_tsc->params);
+	} else {
+		ret = 0;
+		WARN_ON_ONCE(1);
+		goto out;
 	}
+
+	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_get_rsc_tsc_data,
+			    &data);
+
+	if (data.have_rsc_tsc)
+		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
+					   CMD_ASYNC, size, data.rsc_tsc);
+	else
+		ret = 0;
+out:
+	kfree(data.rsc_tsc);
+	return ret;
 }
 
 struct wowlan_key_tkip_data {
@@ -753,7 +821,6 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 	struct wowlan_key_data key_data = {
 		.configure_keys = !unified,
-		.use_rsc_tsc = false,
 		.kek_kck_cmd = _kek_kck_cmd,
 	};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -761,10 +828,6 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	u8 cmd_ver;
 	size_t cmd_size;
 
-	key_data.rsc_tsc = kzalloc(sizeof(*key_data.rsc_tsc), GFP_KERNEL);
-	if (!key_data.rsc_tsc)
-		return -ENOMEM;
-
 	/*
 	 * if we have to configure keys, call ieee80211_iter_keys(),
 	 * as we need non-atomic context in order to take the
@@ -779,37 +842,12 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_program_keys,
 			    &key_data);
 
-	if (key_data.error) {
-		ret = -EIO;
-		goto out;
-	}
-
-	if (key_data.use_rsc_tsc) {
-		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-						WOWLAN_TSC_RSC_PARAM,
-						IWL_FW_CMD_VER_UNKNOWN);
-		int size;
-
-		if (ver == 4) {
-			size = sizeof(*key_data.rsc_tsc);
-			key_data.rsc_tsc->sta_id =
-				cpu_to_le32(mvmvif->ap_sta_id);
-
-		} else if (ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN) {
-			size = sizeof(key_data.rsc_tsc->params);
-		} else {
-			ret = 0;
-			WARN_ON_ONCE(1);
-			goto out;
-		}
-
-		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
-					   CMD_ASYNC, size,
-					   key_data.rsc_tsc);
+	if (key_data.error)
+		return -EIO;
 
-		if (ret)
-			goto out;
-	}
+	ret = iwl_mvm_wowlan_config_rsc_tsc(mvm, vif);
+	if (ret)
+		return ret;
 
 	if (!fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_TKIP_MIC_KEYS)) {
@@ -826,9 +864,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		} else if (ver == 1 || ver == IWL_FW_CMD_VER_UNKNOWN) {
 			size = sizeof(struct iwl_wowlan_tkip_params_cmd_ver_1);
 		} else {
-			ret =  -EINVAL;
 			WARN_ON_ONCE(1);
-			goto out;
+			return -EINVAL;
 		}
 
 		ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_get_tkip_data,
@@ -841,7 +878,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 						   CMD_ASYNC, size,
 						   &tkip_data.tkip);
 			if (ret)
-				goto out;
+				return ret;
 		}
 	}
 
@@ -885,12 +922,10 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_KEK_KCK_MATERIAL,
 					   CMD_ASYNC, cmd_size, _kek_kck_cmd);
 		if (ret)
-			goto out;
+			return ret;
 	}
-	ret = 0;
-out:
-	kfree(key_data.rsc_tsc);
-	return ret;
+
+	return 0;
 }
 
 static int
-- 
2.32.0

