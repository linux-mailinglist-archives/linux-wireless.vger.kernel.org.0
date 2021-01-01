Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F442E841C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jan 2021 17:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbhAAQAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jan 2021 11:00:15 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:35026 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbhAAQAP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jan 2021 11:00:15 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B65BC13C2B0;
        Fri,  1 Jan 2021 07:59:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B65BC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609516773;
        bh=TDRpU1F/St0xBF59RDeBFQkYn4tIdQIm2MTUT5gxYDM=;
        h=From:To:Cc:Subject:Date:From;
        b=rnMjqJRWooxDHlbPK7QPUBq1c1ZY0DABdONKnm0CbuH4pRznfh9EvkRF41w4lN7ZE
         h12i+K7ENBC+6O5mrhdJ5Mn9hWB8NDhluHYpjUly/PYhak6TFZVWO/Q6TBjFhu+gYk
         5YLlZqvag+Y1QhGQLlhhA3wNNFiJ42RpQlBIpWpo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     luca@coelho.fi, Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iwlwifi:  Support changing antenna settings.
Date:   Fri,  1 Jan 2021 07:59:31 -0800
Message-Id: <20210101155931.22968-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Support 'iw phy foo set_antenna 0x1'

The old code had static he_capab, so instead change that to
have a constant initial he_capab object and also a
current-in-use object that we actually use.
Then we can easily re-initialize those settings when the
antenna settings change.

Tested on ax210 against Hawkeye ath11k /AX AP.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

* NOTE:  This is on top of the previous set of patches I posted
  (against 5.10).

 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |   5 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 148 ++++++++++++------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  11 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  17 ++
 6 files changed, 141 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index f3d1da746a1a..82a7c7e34dd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -784,8 +784,13 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
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
index c85209ea7005..5e34592732ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -591,7 +591,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
 }
 
-static struct ieee80211_sband_iftype_data iwl_he_capa[] = {
+static const struct ieee80211_sband_iftype_data iwl_he_capa_const[] = {
 	{
 		.types_mask = BIT(NL80211_IFTYPE_STATION),
 		.he_cap = {
@@ -754,31 +754,62 @@ static struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 	},
 };
 
+static struct ieee80211_sband_iftype_data iwl_he_capa_cur[2];
+
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 				 struct iwl_nvm_data *data,
 				 struct ieee80211_supported_band *sband,
 				 u8 tx_chains, u8 rx_chains)
 {
-	sband->iftype_data = iwl_he_capa;
-	sband->n_iftype_data = ARRAY_SIZE(iwl_he_capa);
-
-	/* If not 2x2, we need to indicate 1x1 in the Midamble RX Max NSTS */
-	if ((tx_chains & rx_chains) != ANT_AB) {
-		int i;
-
-		for (i = 0; i < sband->n_iftype_data; i++) {
-			iwl_he_capa[i].he_cap.he_cap_elem.phy_cap_info[1] &=
-				~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
-			iwl_he_capa[i].he_cap.he_cap_elem.phy_cap_info[2] &=
-				~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
-			iwl_he_capa[i].he_cap.he_cap_elem.phy_cap_info[7] &=
-				~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
-		}
+	int i;
+
+	BUILD_BUG_ON(sizeof(iwl_he_capa_cur) != sizeof(iwl_he_capa_const));
+	memcpy(iwl_he_capa_cur, iwl_he_capa_const, sizeof(iwl_he_capa_cur));
+
+	sband->iftype_data = iwl_he_capa_cur;
+	sband->n_iftype_data = ARRAY_SIZE(iwl_he_capa_cur);
+
+	if ((tx_chains & rx_chains) == ANT_AB)
+		return;
+
+	for (i = 0; i < sband->n_iftype_data; i++) {
+		/* If not 2x2, we need to indicate 1x1 in the Midamble RX Max NSTS */
+		iwl_he_capa_cur[i].he_cap.he_cap_elem.phy_cap_info[1] &=
+			~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
+		iwl_he_capa_cur[i].he_cap.he_cap_elem.phy_cap_info[2] &=
+			~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
+		iwl_he_capa_cur[i].he_cap.he_cap_elem.phy_cap_info[7] &=
+			~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
+
+		/*
+		 * If antennas were forced - make sure not declaring MIMO when
+		 * we actually are SISO
+		 * Recall that there are 2 bits per stream in the "HE Tx/Rx HE
+		 * MCS NSS Support Field", so if some antenna is forced on but
+		 * not both A and B - we should work in SISO mode, so mark the
+		 * 2nd SS as not supported
+		 */
+		iwl_he_capa_cur[i].he_cap.he_mcs_nss_supp.rx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iwl_he_capa_cur[i].he_cap.he_mcs_nss_supp.tx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iwl_he_capa_cur[i].he_cap.he_mcs_nss_supp.rx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iwl_he_capa_cur[i].he_cap.he_mcs_nss_supp.tx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iwl_he_capa_cur[i].he_cap.he_mcs_nss_supp.rx_mcs_80p80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		iwl_he_capa_cur[i].he_cap.he_mcs_nss_supp.tx_mcs_80p80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+
+
 #ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
 		if (trans->dbg_cfg.ampdu_exponent_p1) {
 			/* Use whatever is set in the VHT element. */
-			iwl_he_capa[i].he_cap.he_cap_elem.mac_cap_info[3] &= ~IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK;
-			iwl_he_capa[i].he_cap.he_cap_elem.mac_cap_info[3] |= IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_USE_VHT;
+			iwl_he_capa_cur[i].he_cap.he_cap_elem.mac_cap_info[3] &=
+				~IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK;
+			iwl_he_capa_cur[i].he_cap.he_cap_elem.mac_cap_info[3] |=
+				IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_USE_VHT;
 		}
 #endif
 	}
@@ -797,14 +828,14 @@ static bool iwl_he_mcs_greater(u16 a, u16 b)
 	return false;
 }
 
-static void iwl_init_he_override(struct iwl_trans *trans,
-				 struct ieee80211_supported_band *sband)
+void iwl_init_he_override(struct iwl_trans *trans,
+			  struct ieee80211_supported_band *sband)
 {
 	struct ieee80211_sband_iftype_data *iftype_data;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(iwl_he_capa); i++) {
-		iftype_data = &iwl_he_capa[i];
+	for (i = 0; i < ARRAY_SIZE(iwl_he_capa_cur); i++) {
+		iftype_data = &iwl_he_capa_cur[i];
 
 		if (trans->dbg_cfg.rx_mcs_80) {
 			if (iwl_he_mcs_greater(trans->dbg_cfg.rx_mcs_80,
@@ -847,30 +878,6 @@ static void iwl_init_he_override(struct iwl_trans *trans,
 					cpu_to_le16(trans->dbg_cfg.tx_mcs_160);
 		}
 
-		/*
-		 * If antennas were forced - make sure not declaring MIMO when
-		 * we actually are SISO
-		 * Recall that there are 2 bits per stream in the "HE Tx/Rx HE
-		 * MCS NSS Support Field", so if some antenna is forced on but
-		 * not both A and B - we should work in SISO mode, so mark the
-		 * 2nd SS as not supported
-		 */
-		if (trans->dbg_cfg.valid_ants &&
-		    (trans->dbg_cfg.valid_ants & ANT_AB) != ANT_AB) {
-			iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80 |=
-				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
-			iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80 |=
-				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
-			iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_160 |=
-				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
-			iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160 |=
-				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
-			iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80p80 |=
-				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
-			iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80p80 |=
-				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
-		}
-
 		if (trans->dbg_cfg.no_ldpc)
 			iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &=
 				~IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
@@ -926,10 +933,51 @@ static void iwl_init_he_override(struct iwl_trans *trans,
 }
 #endif
 
-static void iwl_init_sbands(struct iwl_trans *trans,
-			    struct iwl_nvm_data *data,
-			    const void *nvm_ch_flags, u8 tx_chains,
-			    u8 rx_chains, u32 sbands_flags, bool v4)
+void iwl_reinit_capab(struct iwl_trans *trans,
+		      struct iwl_nvm_data *data,
+		      u8 tx_chains, u8 rx_chains) {
+	struct ieee80211_supported_band *sband;
+
+	sband = &data->bands[NL80211_BAND_2GHZ];
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_2GHZ,
+			     tx_chains, rx_chains);
+
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax) {
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains);
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+		iwl_init_he_override(trans, sband);
+#endif
+	}
+	else {
+		sband->iftype_data = NULL;
+	}
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
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax) {
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains);
+
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+		iwl_init_he_override(trans, sband);
+#endif
+	}
+	else {
+		sband->iftype_data = NULL;
+	}
+}
+IWL_EXPORT_SYMBOL(iwl_reinit_capab);
+
+void iwl_init_sbands(struct iwl_trans *trans,
+		     struct iwl_nvm_data *data,
+		     const void *nvm_ch_flags, u8 tx_chains,
+		     u8 rx_chains, u32 sbands_flags, bool v4)
 {
 	struct device *dev = trans->dev;
 	const struct iwl_cfg *cfg = trans->cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 50bd7fdcf852..42bda39ae91c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -135,4 +135,15 @@ void iwl_nvm_fixups(u32 hw_id, unsigned int section, u8 *data,
  */
 struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 				 const struct iwl_fw *fw);
+
+/**
+ * iwl_reinit_capab - Re-initialize the current HT, VHT and/or HE capabilities
+ *
+ * This should be called when changing values that affect the capabilities, such
+ * as number of spatial streams.
+ */
+void iwl_reinit_capab(struct iwl_trans *trans,
+		      struct iwl_nvm_data *data,
+		      u8 tx_chains, u8 rx_chains);
+
 #endif /* __iwl_nvm_parse_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 3e65f41cd6a4..1f8e4a4ffdb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -370,6 +370,13 @@ iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
+static int
+iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	return iwl_mvm_set_valid_ant(mvm, tx_ant, rx_ant);
+}
+
 int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 {
 	struct ieee80211_hw *hw = mvm->hw;
@@ -5247,6 +5254,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
 	.get_antenna = iwl_mvm_op_get_antenna,
+	.set_antenna = iwl_mvm_op_set_antenna,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7159d1da3e77..67b491685832 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1574,6 +1574,8 @@ static inline u8 iwl_mvm_get_valid_rx_ant(struct iwl_mvm *mvm)
 	       mvm->fw->valid_rx_ant;
 }
 
+int iwl_mvm_set_valid_ant(struct iwl_mvm *mvm, u32 tx_ant, u32 rx_ant);
+
 static inline void iwl_mvm_toggle_tx_ant(struct iwl_mvm *mvm, u8 *ant)
 {
 	*ant = iwl_mvm_next_antenna(mvm, iwl_mvm_get_valid_tx_ant(mvm), *ant);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 3123036978a5..09a70e77594f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -208,6 +208,23 @@ static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
 	IWL_DECLARE_RATE_INFO(54),
 };
 
+int iwl_mvm_set_valid_ant(struct iwl_mvm *mvm, u32 tx_ant, u32 rx_ant)
+{
+	if (mvm->nvm_data) {
+		mvm->nvm_data->valid_rx_ant = (rx_ant & ANT_ABC);
+		mvm->nvm_data->valid_tx_ant = (tx_ant & ANT_ABC);
+
+		iwl_reinit_capab(mvm->trans, mvm->nvm_data, mvm->nvm_data->valid_tx_ant,
+				 mvm->nvm_data->valid_rx_ant);
+
+		return 0;
+	}
+	else {
+		pr_err("ERROR:  iwl-mvm-set-valid-ant:  mvm->nvm_data is NULL\n");
+		return -EINVAL;
+	}
+}
+
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band)
 {
-- 
2.20.1

