Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17FF706CED
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjEQPge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjEQPgb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 11:36:31 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A01996
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 08:36:24 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5FA0F5000C2
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 15:36:21 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id E964013C2B0;
        Wed, 17 May 2023 08:36:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E964013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684337781;
        bh=nq8Yw0kJ3nwAlivM+X+3QEgDoen0HzZovGFa4jX5j10=;
        h=From:To:Cc:Subject:Date:From;
        b=HMxazMr9OlXbXKBFOgjhOGhR2iqOiZrs0XWACiWkuyiGh/KfrKfaS+Z/H5I7x15VT
         nRLuxWvK+X6N09zfrEhwYEv76VFawT8H0yajBxPyRvMjqwk6sfx5HH2R6c6BabbLMX
         gVzwzsw7CJ7Kh5uaShSaSlV1OD3HXe8YiV4/vbR0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iwlwifi: Support changing antenna settings.
Date:   Wed, 17 May 2023 08:36:18 -0700
Message-Id: <20230517153618.941040-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684337783-4U-ZNw8xRPx9
X-MDID-O: us5;ut7;1684337783;4U-ZNw8xRPx9;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Support 'iw phy foo set_antenna 0x1'

Allow re-initializing the capabilities, and then call that when
antenna-change is requested

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

NOTE:  This is against recent iwlwifi backports driver.  Something
similar can work against in-kernel driver.

 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  5 ++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 77 +++++++++++++++++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    | 10 +++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 +++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 16 ++++
 7 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index 302794c7ed6a..8fbbae1a9509 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -83,8 +83,13 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 	ht_info->mcs.rx_mask[0] = 0xFF;
 	if (rx_chains >= 2)
 		ht_info->mcs.rx_mask[1] = 0xFF;
+	else
+		ht_info->mcs.rx_mask[1] = 0;
+
 	if (rx_chains >= 3)
 		ht_info->mcs.rx_mask[2] = 0xFF;
+	else
+		ht_info->mcs.rx_mask[2] = 0;
 
 	if (cfg->ht_params->ht_greenfield_support)
 		ht_info->cap |= IEEE80211_HT_CAP_GRN_FLD;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index f4f6e9b338ee..060c9cffcca2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -964,6 +964,12 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				iftype_data->eht_cap.eht_cap_elem.phy_cap_info[4] |= 0x10;
 			}
 		}
+		if (iftype_data->eht_cap.has_eht) {
+			struct ieee80211_eht_mcs_nss_supp *mcs_nss =
+				&iftype_data->eht_cap.eht_mcs_nss_supp;
+
+			memset(mcs_nss, 0x22, sizeof(*mcs_nss));
+		}
 	} else {
 		if (iftype_data->eht_cap.has_eht) {
 			struct ieee80211_eht_mcs_nss_supp *mcs_nss =
@@ -983,6 +989,26 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			iftype_data->he_cap.he_cap_elem.phy_cap_info[7] |=
 				IEEE80211_HE_PHY_CAP7_MAX_NC_1;
 		}
+
+		/* If antennas were forced - make sure not declaring MIMO when
+		 * we actually are SISO
+		 * Recall that there are 2 bits per stream in the "HE Tx/Rx HE
+		 * MCS NSS Support Field", so if some antenna is forced on but
+		 * not both A and B - we should work in SISO mode, so mark the
+		 * 2nd SS as not supported
+		 */
+		iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80p80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80p80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
 	}
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210 && !is_ap)
@@ -1058,10 +1084,6 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 	struct ieee80211_sband_iftype_data *iftype_data;
 	int i;
 
-	/* should only initialize once */
-	if (WARN_ON(sband->iftype_data))
-		return;
-
 	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_eht_capa));
 	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_eht_capa));
 	BUILD_BUG_ON(sizeof(data->iftd.uhb) != sizeof(iwl_he_eht_capa));
@@ -1244,6 +1266,8 @@ static void iwl_init_eht_band_override(struct iwl_trans *trans,
 	int i;
 
 	for (i = 0; i < sband->n_iftype_data; i++) {
+		struct ieee80211_eht_mcs_nss_supp *mcs_nss;
+
 		/* we know it's writable - we set it before ourselves */
 		iftype_data = (void *)(uintptr_t)&sband->iftype_data[i];
 
@@ -1251,16 +1275,16 @@ static void iwl_init_eht_band_override(struct iwl_trans *trans,
 		if (!iftype_data->eht_cap.has_eht)
 			continue;
 
+		mcs_nss = &iftype_data->eht_cap.eht_mcs_nss_supp;
 		if (trans->dbg_cfg.valid_ants &&
 		    (trans->dbg_cfg.valid_ants & ANT_AB) != ANT_AB) {
 			/* For all MCS and bandwidth, set 1 NSS for both Tx and
 			 * Rx - note we don't set the only_20mhz, but due to this
 			 * being a union, it gets set correctly anyway.
 			 */
-			struct ieee80211_eht_mcs_nss_supp *mcs_nss =
-				&iftype_data->eht_cap.eht_mcs_nss_supp;
-
 			memset(mcs_nss, 0x11, sizeof(*mcs_nss));
+		} else {
+			memset(mcs_nss, 0x22, sizeof(*mcs_nss));
 		}
 
 		IWL_COPY_BIN(eht_ppe_thres, eht_cap.eht_ppe_thres);
@@ -1302,6 +1326,45 @@ static void iwl_init_he_eht_override(struct iwl_trans *trans,
 }
 #endif
 
+/* This is a subsection of the logic in iwl_init_bands */
+void iwl_reinit_capab(struct iwl_trans *trans,
+		      struct iwl_nvm_data *data,
+		      u8 tx_chains, u8 rx_chains, const struct iwl_fw *fw)
+{
+	struct ieee80211_supported_band *sband;
+
+	sband = &data->bands[NL80211_BAND_2GHZ];
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_2GHZ,
+			     tx_chains, rx_chains);
+
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains, fw);
+	else
+		sband->iftype_data = NULL;
+
+	sband = &data->bands[NL80211_BAND_5GHZ];
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_5GHZ,
+			     tx_chains, rx_chains);
+	if (data->sku_cap_11ac_enable && !iwlwifi_mod_params.disable_11ac)
+		iwl_init_vht_hw_capab(trans, data, &sband->vht_cap,
+				      tx_chains, rx_chains);
+	else
+		sband->vht_cap.vht_supported = false;
+
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains, fw);
+	else
+		sband->iftype_data = NULL;
+
+	sband = &data->bands[NL80211_BAND_6GHZ];
+
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains, fw);
+	else
+		sband->iftype_data = NULL;
+}
+IWL_EXPORT_SYMBOL(iwl_reinit_capab);
+
 static void iwl_init_sbands(struct iwl_trans *trans,
 			    struct iwl_nvm_data *data,
 			    const void *nvm_ch_flags, u8 tx_chains,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index c79f72d54482..a4d5b19038fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -90,4 +90,14 @@ iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		       const struct iwl_mei_nvm *mei_nvm,
 		       const struct iwl_fw *fw);
 
+/**
+ * iwl_reinit_capab - Re-initialize the current HT, VHT and/or HE capabilities
+ *
+ * This should be called when changing values that affect the capabilities, such
+ * as number of spatial streams.
+ */
+void iwl_reinit_capab(struct iwl_trans *trans,
+		      struct iwl_nvm_data *data,
+		      u8 tx_chains, u8 rx_chains, const struct iwl_fw *fw);
+
 #endif /* __iwl_nvm_parse_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 622c63de4b4b..a03f93cfa73b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -319,6 +319,14 @@ int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
+int
+iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	return iwl_mvm_set_valid_ant(mvm, tx_ant, rx_ant);
+}
+
 int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 {
 	struct ieee80211_hw *hw = mvm->hw;
@@ -6443,6 +6451,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
 	.get_antenna = iwl_mvm_op_get_antenna,
+	.set_antenna = iwl_mvm_op_set_antenna,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 2102cb4cbd7f..2c20f358b02c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1164,6 +1164,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
 	.get_antenna = iwl_mvm_op_get_antenna,
+	.set_antenna = iwl_mvm_op_set_antenna,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 41398b42fd9e..3b414bee4e9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1779,6 +1779,8 @@ static inline u8 iwl_mvm_get_valid_rx_ant(struct iwl_mvm *mvm)
 	       mvm->fw->valid_rx_ant;
 }
 
+int iwl_mvm_set_valid_ant(struct iwl_mvm *mvm, u32 tx_ant, u32 rx_ant);
+
 static inline void iwl_mvm_toggle_tx_ant(struct iwl_mvm *mvm, u8 *ant)
 {
 	*ant = iwl_mvm_next_antenna(mvm, iwl_mvm_get_valid_tx_ant(mvm), *ant);
@@ -2694,6 +2696,7 @@ int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_ampdu_params *params);
 int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant);
 int iwl_mvm_mac_start(struct ieee80211_hw *hw);
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 				   enum ieee80211_reconfig_type reconfig_type);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 2d7deb08cd45..8bff4ef84563 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -150,6 +150,22 @@ int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
 	return is_LB ? rate : -1;
 }
 
+int iwl_mvm_set_valid_ant(struct iwl_mvm *mvm, u32 tx_ant, u32 rx_ant)
+{
+	if (mvm->nvm_data) {
+		mvm->nvm_data->valid_rx_ant = (rx_ant & ANT_ABC);
+		mvm->nvm_data->valid_tx_ant = (tx_ant & ANT_ABC);
+
+		iwl_reinit_capab(mvm->trans, mvm->nvm_data, mvm->nvm_data->valid_tx_ant,
+				 mvm->nvm_data->valid_rx_ant, mvm->fw);
+
+		return 0;
+	} else {
+		pr_err("ERROR:  iwl-mvm-set-valid-ant:  mvm->nvm_data is NULL\n");
+		return -EINVAL;
+	}
+}
+
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band)
 {
-- 
2.40.0

