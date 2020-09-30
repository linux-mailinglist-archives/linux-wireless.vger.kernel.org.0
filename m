Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1019727E9FF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgI3Nbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53334 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCi-002MJ5-ST; Wed, 30 Sep 2020 16:31:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:17 +0300
Message-Id: <iwlwifi.20200930161256.be16c51fef3c.If4fac0fbc5bede4679b5f875b60c4e9a6ea7ca7c@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] iwlwifi: mvm: support more GTK rekeying algorithms
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

add and use new API version for GTK rekeying. This will allow our
firmware to do GTK rekeying for more algorithms (GCMP 128, GCMP 256,
SAE).

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 29 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  5 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +++-
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index b152f5a6ba0f..f027029553dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -81,8 +81,11 @@ void iwl_mvm_set_rekey_data(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	memcpy(mvmvif->rekey_data.kek, data->kek, NL80211_KEK_LEN);
-	memcpy(mvmvif->rekey_data.kck, data->kck, NL80211_KCK_LEN);
+	mvmvif->rekey_data.kek_len = data->kek_len;
+	mvmvif->rekey_data.kck_len = data->kck_len;
+	memcpy(mvmvif->rekey_data.kek, data->kek, data->kek_len);
+	memcpy(mvmvif->rekey_data.kck, data->kck, data->kck_len);
+	mvmvif->rekey_data.akm = data->akm & 0xFF;
 	mvmvif->rekey_data.replay_ctr =
 		cpu_to_le64(be64_to_cpup((__be64 *)data->replay_ctr));
 	mvmvif->rekey_data.valid = true;
@@ -157,6 +160,7 @@ static const u8 *iwl_mvm_find_max_pn(struct ieee80211_key_conf *key,
 struct wowlan_key_data {
 	struct iwl_wowlan_rsc_tsc_params_cmd *rsc_tsc;
 	struct iwl_wowlan_tkip_params_cmd *tkip;
+	struct iwl_wowlan_kek_kck_material_cmd_v3 *kek_kck_cmd;
 	bool error, use_rsc_tsc, use_tkip, configure_keys;
 	int wep_key_idx;
 };
@@ -233,7 +237,12 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 	default:
 		data->error = true;
 		return;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
+		return;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
+		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_CCM);
 		/*
 		 * Ignore CMAC keys -- the WoWLAN firmware doesn't support them
 		 * but we also shouldn't abort suspend due to that. It does have
@@ -271,6 +280,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			  data->rsc_tsc->params.all_tsc_rsc.tkip.multicast_rsc;
 			rx_p1ks = data->tkip->rx_multi;
 			rx_mic_key = data->tkip->mic_keys.rx_mcast;
+			data->kek_kck_cmd->gtk_cipher =
+				cpu_to_le32(STA_KEY_FLG_TKIP);
 		}
 
 		/*
@@ -315,6 +326,10 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		} else {
 			aes_sc =
 			   data->rsc_tsc->params.all_tsc_rsc.aes.multicast_rsc;
+			data->kek_kck_cmd->gtk_cipher =
+				key->cipher == WLAN_CIPHER_SUITE_CCMP ?
+				cpu_to_le32(STA_KEY_FLG_CCM) :
+				cpu_to_le32(STA_KEY_FLG_GCMP);
 		}
 
 		/*
@@ -749,6 +764,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		.use_rsc_tsc = false,
 		.tkip = &tkip_cmd,
 		.use_tkip = false,
+		.kek_kck_cmd = &kek_kck_cmd,
 	};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -852,12 +868,13 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 
 		memset(&kek_kck_cmd, 0, sizeof(kek_kck_cmd));
 		memcpy(kek_kck_cmd.kck, mvmvif->rekey_data.kck,
-		       NL80211_KCK_LEN);
-		kek_kck_cmd.kck_len = cpu_to_le16(NL80211_KCK_LEN);
+		       mvmvif->rekey_data.kck_len);
+		kek_kck_cmd.kck_len = cpu_to_le16(mvmvif->rekey_data.kck_len);
 		memcpy(kek_kck_cmd.kek, mvmvif->rekey_data.kek,
-		       NL80211_KEK_LEN);
-		kek_kck_cmd.kek_len = cpu_to_le16(NL80211_KEK_LEN);
+		       mvmvif->rekey_data.kek_len);
+		kek_kck_cmd.kek_len = cpu_to_le16(mvmvif->rekey_data.kek_len);
 		kek_kck_cmd.replay_ctr = mvmvif->rekey_data.replay_ctr;
+		kek_kck_cmd.akm = cpu_to_le32(mvmvif->rekey_data.akm);
 
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WOWLAN_KEK_KCK_MATERIAL, cmd_flags,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1c5f18d1b4c2..5c9bde99ce19 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -666,6 +666,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 			IWL_UCODE_TLV_CAPA_WFA_TPC_REP_IE_SUPPORT))
 		hw->wiphy->features |= NL80211_FEATURE_WFA_TPC_IE_IN_PROBES;
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+				  WOWLAN_KEK_KCK_MATERIAL,
+				  IWL_FW_CMD_VER_UNKNOWN) == 3)
+		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
+
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_SCAN_TSF_REPORT)) {
 		wiphy_ext_feature_set(hw->wiphy,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1836589218fa..9187f8a1126d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -416,7 +416,11 @@ struct iwl_mvm_vif {
 #ifdef CONFIG_PM
 	/* WoWLAN GTK rekey data */
 	struct {
-		u8 kck[NL80211_KCK_LEN], kek[NL80211_KEK_LEN];
+		u8 kck[NL80211_KCK_EXT_LEN];
+		u8 kek[NL80211_KEK_EXT_LEN];
+		size_t kek_len;
+		size_t kck_len;
+		u32 akm;
 		__le64 replay_ctr;
 		bool valid;
 	} rekey_data;
-- 
2.28.0

