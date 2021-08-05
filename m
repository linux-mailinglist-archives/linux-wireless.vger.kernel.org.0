Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8103E1274
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhHEKTy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:19:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51200 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240017AbhHEKTx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:53 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTQ-00240Q-6l; Thu, 05 Aug 2021 13:19:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:23 +0300
Message-Id: <iwlwifi.20210805130823.80721fc0fd61.I5a8fbba4e3a9606f700ee41c7a4244dd5e2af935@changeid>
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
Subject: [PATCH 01/12] iwlwifi: mvm: d3: separate TKIP data from key iteration
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We do a key iteration to program the keys, and while at it
we also collect the data necessary for TKIP. This code has
all kinds of dependencies on the firmware API though, so
take out the TKIP phase 1 key generation and do that in a
separate key iteration only if necessary.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 132 ++++++++++++--------
 1 file changed, 83 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6a259d867d90..14c24f3e0717 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -103,9 +103,8 @@ static const u8 *iwl_mvm_find_max_pn(struct ieee80211_key_conf *key,
 
 struct wowlan_key_data {
 	struct iwl_wowlan_rsc_tsc_params_cmd *rsc_tsc;
-	struct iwl_wowlan_tkip_params_cmd *tkip;
 	struct iwl_wowlan_kek_kck_material_cmd_v4 *kek_kck_cmd;
-	bool error, use_rsc_tsc, use_tkip, configure_keys;
+	bool error, use_rsc_tsc, configure_keys;
 	int wep_key_idx;
 };
 
@@ -120,11 +119,7 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 	struct wowlan_key_data *data = _data;
 	struct aes_sc *aes_sc, *aes_tx_sc = NULL;
 	struct tkip_sc *tkip_sc, *tkip_tx_sc = NULL;
-	struct iwl_p1k_cache *rx_p1ks;
-	u8 *rx_mic_key;
 	struct ieee80211_key_seq seq;
-	u32 cur_rx_iv32 = 0;
-	u16 p1k[IWL_P1K_SIZE];
 	int ret, i;
 
 	switch (key->cipher) {
@@ -204,26 +199,12 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			tkip_tx_sc =
 				&data->rsc_tsc->params.all_tsc_rsc.tkip.tsc;
 
-			rx_p1ks = data->tkip->rx_uni;
-
 			pn64 = atomic64_read(&key->tx_pn);
 			tkip_tx_sc->iv16 = cpu_to_le16(TKIP_PN_TO_IV16(pn64));
 			tkip_tx_sc->iv32 = cpu_to_le32(TKIP_PN_TO_IV32(pn64));
-
-			ieee80211_get_tkip_p1k_iv(key, TKIP_PN_TO_IV32(pn64),
-						  p1k);
-			iwl_mvm_convert_p1k(p1k, data->tkip->tx.p1k);
-
-			memcpy(data->tkip->mic_keys.tx,
-			       &key->key[NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY],
-			       IWL_MIC_KEY_SIZE);
-
-			rx_mic_key = data->tkip->mic_keys.rx_unicast;
 		} else {
 			tkip_sc =
 			  data->rsc_tsc->params.all_tsc_rsc.tkip.multicast_rsc;
-			rx_p1ks = data->tkip->rx_multi;
-			rx_mic_key = data->tkip->mic_keys.rx_mcast;
 			data->kek_kck_cmd->gtk_cipher =
 				cpu_to_le32(STA_KEY_FLG_TKIP);
 		}
@@ -237,23 +218,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			ieee80211_get_key_rx_seq(key, i, &seq);
 			tkip_sc[i].iv16 = cpu_to_le16(seq.tkip.iv16);
 			tkip_sc[i].iv32 = cpu_to_le32(seq.tkip.iv32);
-			/* wrapping isn't allowed, AP must rekey */
-			if (seq.tkip.iv32 > cur_rx_iv32)
-				cur_rx_iv32 = seq.tkip.iv32;
 		}
 
-		ieee80211_get_tkip_rx_p1k(key, vif->bss_conf.bssid,
-					  cur_rx_iv32, p1k);
-		iwl_mvm_convert_p1k(p1k, rx_p1ks[0].p1k);
-		ieee80211_get_tkip_rx_p1k(key, vif->bss_conf.bssid,
-					  cur_rx_iv32 + 1, p1k);
-		iwl_mvm_convert_p1k(p1k, rx_p1ks[1].p1k);
-
-		memcpy(rx_mic_key,
-		       &key->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY],
-		       IWL_MIC_KEY_SIZE);
-
-		data->use_tkip = true;
 		data->use_rsc_tsc = true;
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
@@ -352,6 +318,72 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 	}
 }
 
+struct wowlan_key_tkip_data {
+	struct iwl_wowlan_tkip_params_cmd tkip;
+	bool have_tkip_keys;
+};
+
+static void iwl_mvm_wowlan_get_tkip_data(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 struct ieee80211_key_conf *key,
+					 void *_data)
+{
+	struct wowlan_key_tkip_data *data = _data;
+	struct iwl_p1k_cache *rx_p1ks;
+	u8 *rx_mic_key;
+	struct ieee80211_key_seq seq;
+	u32 cur_rx_iv32 = 0;
+	u16 p1k[IWL_P1K_SIZE];
+	int i;
+
+	switch (key->cipher) {
+	default:
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		if (sta) {
+			u64 pn64;
+
+			rx_p1ks = data->tkip.rx_uni;
+
+			pn64 = atomic64_read(&key->tx_pn);
+
+			ieee80211_get_tkip_p1k_iv(key, TKIP_PN_TO_IV32(pn64),
+						  p1k);
+			iwl_mvm_convert_p1k(p1k, data->tkip.tx.p1k);
+
+			memcpy(data->tkip.mic_keys.tx,
+			       &key->key[NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY],
+			       IWL_MIC_KEY_SIZE);
+
+			rx_mic_key = data->tkip.mic_keys.rx_unicast;
+		} else {
+			rx_p1ks = data->tkip.rx_multi;
+			rx_mic_key = data->tkip.mic_keys.rx_mcast;
+		}
+
+		for (i = 0; i < IWL_NUM_RSC; i++) {
+			/* wrapping isn't allowed, AP must rekey */
+			if (seq.tkip.iv32 > cur_rx_iv32)
+				cur_rx_iv32 = seq.tkip.iv32;
+		}
+
+		ieee80211_get_tkip_rx_p1k(key, vif->bss_conf.bssid,
+					  cur_rx_iv32, p1k);
+		iwl_mvm_convert_p1k(p1k, rx_p1ks[0].p1k);
+		ieee80211_get_tkip_rx_p1k(key, vif->bss_conf.bssid,
+					  cur_rx_iv32 + 1, p1k);
+		iwl_mvm_convert_p1k(p1k, rx_p1ks[1].p1k);
+
+		memcpy(rx_mic_key,
+		       &key->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY],
+		       IWL_MIC_KEY_SIZE);
+
+		data->have_tkip_keys = true;
+		break;
+	}
+}
+
 static int iwl_mvm_send_patterns_v1(struct iwl_mvm *mvm,
 				    struct cfg80211_wowlan *wowlan)
 {
@@ -718,14 +750,11 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 {
 	struct iwl_wowlan_kek_kck_material_cmd_v4 kek_kck_cmd = {};
 	struct iwl_wowlan_kek_kck_material_cmd_v4 *_kek_kck_cmd = &kek_kck_cmd;
-	struct iwl_wowlan_tkip_params_cmd tkip_cmd = {};
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 	struct wowlan_key_data key_data = {
 		.configure_keys = !unified,
 		.use_rsc_tsc = false,
-		.tkip = &tkip_cmd,
-		.use_tkip = false,
 		.kek_kck_cmd = _kek_kck_cmd,
 	};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -785,17 +814,17 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 			goto out;
 	}
 
-	if (key_data.use_tkip &&
-	    !fw_has_api(&mvm->fw->ucode_capa,
+	if (!fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_TKIP_MIC_KEYS)) {
 		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
 						WOWLAN_TKIP_PARAM,
 						IWL_FW_CMD_VER_UNKNOWN);
+		struct wowlan_key_tkip_data tkip_data = {};
 		int size;
 
 		if (ver == 2) {
-			size = sizeof(tkip_cmd);
-			key_data.tkip->sta_id =
+			size = sizeof(tkip_data.tkip);
+			tkip_data.tkip.sta_id =
 				cpu_to_le32(mvmvif->ap_sta_id);
 		} else if (ver == 1 || ver == IWL_FW_CMD_VER_UNKNOWN) {
 			size = sizeof(struct iwl_wowlan_tkip_params_cmd_ver_1);
@@ -805,13 +834,18 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 			goto out;
 		}
 
-		/* send relevant data according to CMD version */
-		ret = iwl_mvm_send_cmd_pdu(mvm,
-					   WOWLAN_TKIP_PARAM,
-					   cmd_flags, size,
-					   &tkip_cmd);
-		if (ret)
-			goto out;
+		ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_get_tkip_data,
+				    &tkip_data);
+
+		if (tkip_data.have_tkip_keys) {
+			/* send relevant data according to CMD version */
+			ret = iwl_mvm_send_cmd_pdu(mvm,
+						   WOWLAN_TKIP_PARAM,
+						   cmd_flags, size,
+						   &tkip_data.tkip);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* configure rekey data only if offloaded rekey is supported (d3) */
-- 
2.32.0

