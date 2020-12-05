Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68642CFADA
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 10:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLEJdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 04:33:24 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34488 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728865AbgLEJcs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 04:32:48 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klTSx-0039ST-JQ; Sat, 05 Dec 2020 11:02:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  5 Dec 2020 11:02:52 +0200
Message-Id: <iwlwifi.20201205105241.bb5695c84b9c.Idb648536faf21716e2ab2c6d6890d3e49f719cd3@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205090252.337391-1-luca@coelho.fi>
References: <20201205090252.337391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 2/2] iwlwifi: mvm: add support for 6GHz
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add support to the 6GHz band (aka. Ultra High Band or UHB).  This
allows us to scan and connect to channels in that band, including all
the relevant features, such as preferred scan channels, colocated
channels etc.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   3 +-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |   1 +
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   5 +
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |   5 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  71 +++++
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  17 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  12 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 296 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  11 +
 14 files changed, 432 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d2bbe6a73514..5a03b95d3f39 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -155,7 +155,8 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 static const struct iwl_ht_params iwl_22000_ht_params = {
 	.stbc = true,
 	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
+		      BIT(NL80211_BAND_6GHZ),
 };
 
 #define IWL_DEVICE_22000_COMMON						\
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index e6a069683462..be9998d599a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -66,6 +66,7 @@
 /* Supported bands */
 #define PHY_BAND_5  (0)
 #define PHY_BAND_24 (1)
+#define PHY_BAND_6 (2)
 
 /* Supported channel width, vary if there is VHT support */
 #define PHY_VHT_CHANNEL_MODE20	(0x0)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 5cc33a1b7172..b6c29196d935 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -530,6 +530,11 @@ enum iwl_channel_flags {
 	IWL_CHANNEL_FLAG_PRE_SCAN_PASSIVE2ACTIVE	= BIT(3),
 };
 
+enum iwl_uhb_chan_cfg_flags {
+	IWL_UHB_CHAN_CFG_FLAG_UNSOLICITED_PROBE_RES = BIT(24),
+	IWL_UHB_CHAN_CFG_FLAG_PSC_CHAN_NO_LISTEN    = BIT(25),
+	IWL_UHB_CHAN_CFG_FLAG_FORCE_PASSIVE         = BIT(26),
+};
 /**
  * struct iwl_scan_dwell
  * @active:		default dwell time for active scan
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 02c64b988a13..a187253a59bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -486,6 +486,11 @@ enum iwl_ucode_tlv_capa {
 	/* set 3 */
 	IWL_UCODE_TLV_CAPA_MLME_OFFLOAD			= (__force iwl_ucode_tlv_capa_t)96,
 
+	/*
+	 * @IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT: supports PSC channels
+	 */
+	IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)98,
+
 	NUM_IWL_UCODE_TLV_CAPA
 #ifdef __CHECKER__
 		/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
index 3a4562b45410..10e7b055867f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
@@ -100,6 +100,11 @@ struct iwl_nvm_data {
 	bool vht160_supported;
 	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
 
+	/*
+	 * iftype data for low (2.4 GHz) and high (5 and 6 GHz) bands,
+	 * we can use the same for 5 and 6 GHz bands because they have
+	 * the same data
+	 */
 	struct {
 		struct ieee80211_sband_iftype_data low[2];
 		struct ieee80211_sband_iftype_data high[2];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 6f3aca19a254..41a79da878ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -166,6 +166,7 @@ static const u16 iwl_uhb_nvm_channels[] = {
 #define IWL_NVM_NUM_CHANNELS_EXT	ARRAY_SIZE(iwl_ext_nvm_channels)
 #define IWL_NVM_NUM_CHANNELS_UHB	ARRAY_SIZE(iwl_uhb_nvm_channels)
 #define NUM_2GHZ_CHANNELS		14
+#define NUM_5GHZ_CHANNELS		37
 #define FIRST_2GHZ_HT_MINUS		5
 #define LAST_2GHZ_HT_PLUS		9
 #define N_HW_ADDR_MASK			0xF
@@ -389,6 +390,10 @@ static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, enum nl80211_band band,
 
 static enum nl80211_band iwl_nl80211_band_from_channel_idx(int ch_idx)
 {
+	if (ch_idx >= NUM_2GHZ_CHANNELS + NUM_5GHZ_CHANNELS) {
+		return NL80211_BAND_6GHZ;
+	}
+
 	if (ch_idx >= NUM_2GHZ_CHANNELS)
 		return NL80211_BAND_5GHZ;
 	return NL80211_BAND_2GHZ;
@@ -480,6 +485,11 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 		else
 			channel->flags = 0;
 
+		/* TODO: Don't put limitations on UHB devices as we still don't
+		 * have NVM for them
+		 */
+		if (cfg->uhb_supported)
+			channel->flags = 0;
 		iwl_nvm_print_channel_flags(dev, IWL_DL_EEPROM,
 					    channel->hw_value, ch_flags);
 		IWL_DEBUG_EEPROM(dev, "Ch. %d: %ddBm\n",
@@ -743,6 +753,52 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 	},
 };
 
+static void iwl_init_he_6ghz_capa(struct iwl_trans *trans,
+				  struct iwl_nvm_data *data,
+				  struct ieee80211_supported_band *sband,
+				  u8 tx_chains, u8 rx_chains)
+{
+	struct ieee80211_sta_ht_cap ht_cap;
+	struct ieee80211_sta_vht_cap vht_cap = {};
+	struct ieee80211_sband_iftype_data *iftype_data;
+	u16 he_6ghz_capa = 0;
+	u32 exp;
+	int i;
+
+	if (sband->band != NL80211_BAND_6GHZ)
+		return;
+
+	/* grab HT/VHT capabilities and calculate HE 6 GHz capabilities */
+	iwl_init_ht_hw_capab(trans, data, &ht_cap, NL80211_BAND_5GHZ,
+			     tx_chains, rx_chains);
+	WARN_ON(!ht_cap.ht_supported);
+	iwl_init_vht_hw_capab(trans, data, &vht_cap, tx_chains, rx_chains);
+	WARN_ON(!vht_cap.vht_supported);
+
+	he_6ghz_capa |=
+		u16_encode_bits(ht_cap.ampdu_density,
+				IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+	exp = u32_get_bits(vht_cap.cap,
+			   IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
+	he_6ghz_capa |=
+		u16_encode_bits(exp, IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+	exp = u32_get_bits(vht_cap.cap, IEEE80211_VHT_CAP_MAX_MPDU_MASK);
+	he_6ghz_capa |=
+		u16_encode_bits(exp, IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+	/* we don't support extended_ht_cap_info anywhere, so no RD_RESPONDER */
+	if (vht_cap.cap & IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN)
+		he_6ghz_capa |= IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS;
+	if (vht_cap.cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
+		he_6ghz_capa |= IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+	IWL_DEBUG_EEPROM(trans->dev, "he_6ghz_capa=0x%x\n", he_6ghz_capa);
+
+	/* we know it's writable - we set it before ourselves */
+	iftype_data = (void *)sband->iftype_data;
+	for (i = 0; i < sband->n_iftype_data; i++)
+		iftype_data[i].he_6ghz_capa.capa = cpu_to_le16(he_6ghz_capa);
+}
+
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 				 struct iwl_nvm_data *data,
 				 struct ieee80211_supported_band *sband,
@@ -762,6 +818,7 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 		iftype_data = data->iftd.low;
 		break;
 	case NL80211_BAND_5GHZ:
+	case NL80211_BAND_6GHZ:
 		iftype_data = data->iftd.high;
 		break;
 	default:
@@ -787,6 +844,7 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 				~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
 		}
 	}
+	iwl_init_he_6ghz_capa(trans, data, sband, tx_chains, rx_chains);
 }
 
 static void iwl_init_sbands(struct iwl_trans *trans,
@@ -829,6 +887,19 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
 		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains);
 
+	/* 6GHz band. */
+	sband = &data->bands[NL80211_BAND_6GHZ];
+	sband->band = NL80211_BAND_6GHZ;
+	/* use the same rates as 5GHz band */
+	sband->bitrates = &iwl_cfg80211_rates[RATES_52_OFFS];
+	sband->n_bitrates = N_RATES_52;
+	n_used += iwl_init_sband_channels(data, sband, n_channels,
+					  NL80211_BAND_6GHZ);
+
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains);
+	else
+		sband->n_channels = 0;
 	if (n_channels != n_used)
 		IWL_ERR_DEV(dev, "NVM: used only %d of %d channels\n",
 			    n_used, n_channels);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 2487871eac73..b4eeb4be3ac7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -165,5 +165,6 @@
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT 20016
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT  20016
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_AGE_SEC    2
+#define IWL_MVM_DISABLE_AP_FILS			false
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 8698ca4d30de..ca8983cf3a4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -61,6 +61,7 @@
  *****************************************************************************/
 
 #include <linux/etherdevice.h>
+#include <linux/crc32.h>
 #include <net/mac80211.h>
 #include "iwl-io.h"
 #include "iwl-prph.h"
@@ -980,12 +981,28 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	struct iwl_mac_beacon_cmd beacon_cmd = {};
 	u8 rate = iwl_mvm_mac_ctxt_get_lowest_rate(info, vif);
 	u16 flags;
+	struct ieee80211_chanctx_conf *ctx;
+	int channel;
 
 	flags = iwl_mvm_mac80211_idx_to_hwrate(rate);
 
 	if (rate == IWL_FIRST_CCK_RATE)
 		flags |= IWL_MAC_BEACON_CCK;
 
+	/* Enable FILS on PSC channels only */
+	rcu_read_lock();
+	ctx = rcu_dereference(vif->chanctx_conf);
+	channel = ieee80211_frequency_to_channel(ctx->def.chan->center_freq);
+	WARN_ON(channel == 0);
+	if (cfg80211_channel_is_psc(ctx->def.chan) &&
+	    !IWL_MVM_DISABLE_AP_FILS) {
+		flags |= IWL_MAC_BEACON_FILS;
+		beacon_cmd.short_ssid =
+			cpu_to_le32(~crc32_le(~0, vif->bss_conf.ssid,
+					      vif->bss_conf.ssid_len));
+	}
+	rcu_read_unlock();
+
 	beacon_cmd.flags = cpu_to_le16(flags);
 	beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
 	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 688c1125e67b..b40b88740b48 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -566,6 +566,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
 	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	hw->wiphy->flags |= WIPHY_FLAG_SPLIT_SCAN_6GHZ;
 
 	hw->wiphy->iface_combinations = iwl_mvm_iface_combinations;
 	hw->wiphy->n_iface_combinations =
@@ -619,6 +620,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 			hw->wiphy->bands[NL80211_BAND_5GHZ]->vht_cap.cap |=
 				IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE;
 	}
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_PSC_CHAN_SUPPORT) &&
+	    mvm->nvm_data->bands[NL80211_BAND_6GHZ].n_channels)
+		hw->wiphy->bands[NL80211_BAND_6GHZ] =
+			&mvm->nvm_data->bands[NL80211_BAND_6GHZ];
 
 	hw->wiphy->hw_version = mvm->trans->hw_id;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a27ac3032218..047bd47df32e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2100,6 +2100,8 @@ static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 		return PHY_BAND_24;
 	case NL80211_BAND_5GHZ:
 		return PHY_BAND_5;
+	case NL80211_BAND_6GHZ:
+		return PHY_BAND_6;
 	default:
 		WARN_ONCE(1, "Unsupported band (%u)\n", band);
 		return PHY_BAND_5;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index e0e80906fdc6..12fe6342cbd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -420,9 +420,21 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 
 u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 {
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 
+	if (mvmsta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ) {
+		switch (le16_get_bits(sta->he_6ghz_capa.capa,
+				      IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN)) {
+		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
+			return IEEE80211_MAX_MPDU_LEN_VHT_11454;
+		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
+			return IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		default:
+			return IEEE80211_MAX_MPDU_LEN_VHT_3895;
+		}
+	} else
 	if (vht_cap->vht_supported) {
 		switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 838734fec502..22bd3a84aaac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1591,6 +1591,8 @@ static inline u8 iwl_mvm_nl80211_band_from_rx_msdu(u8 phy_band)
 		return NL80211_BAND_2GHZ;
 	case PHY_BAND_5:
 		return NL80211_BAND_5GHZ;
+	case PHY_BAND_6:
+		return NL80211_BAND_6GHZ;
 	default:
 		WARN_ONCE(1, "Unsupported phy band (%u)\n", phy_band);
 		return NL80211_BAND_5GHZ;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 875281cf7fc0..ea10d6e906dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -64,6 +64,7 @@
 
 #include <linux/etherdevice.h>
 #include <net/mac80211.h>
+#include <linux/crc32.h>
 
 #include "mvm.h"
 #include "fw/api/scan.h"
@@ -148,6 +149,9 @@ struct iwl_mvm_scan_params {
 	int n_scan_plans;
 	struct cfg80211_sched_scan_plan *scan_plans;
 	bool iter_notif;
+	struct cfg80211_scan_6ghz_params *scan_6ghz_params;
+	u32 n_6ghz_params;
+	bool scan_6ghz;
 };
 
 static inline void *iwl_mvm_get_scan_req_umac_data(struct iwl_mvm *mvm)
@@ -844,6 +848,12 @@ iwl_mvm_build_scan_probe(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		cpu_to_le16(ies->len[NL80211_BAND_5GHZ]);
 	pos += ies->len[NL80211_BAND_5GHZ];
 
+	memcpy(pos, ies->ies[NL80211_BAND_6GHZ],
+	       ies->len[NL80211_BAND_6GHZ]);
+	params->preq.band_data[2].offset = cpu_to_le16(pos - params->preq.buf);
+	params->preq.band_data[2].len =
+		cpu_to_le16(ies->len[NL80211_BAND_6GHZ]);
+	pos += ies->len[NL80211_BAND_6GHZ];
 	memcpy(pos, ies->common_ies, ies->common_ie_len);
 	params->preq.common_data.offset = cpu_to_le16(pos - params->preq.buf);
 
@@ -1516,6 +1526,14 @@ static const struct iwl_mvm_scan_channel_segment scan_channel_segments[] = {
 		.channel_spacing_shift = 2,
 		.band = PHY_BAND_5
 	},
+	{
+		.start_idx = 51,
+		.end_idx = 111,
+		.first_channel_id = 1,
+		.last_channel_id = 241,
+		.channel_spacing_shift = 2,
+		.band = PHY_BAND_6
+	},
 };
 
 static int iwl_mvm_scan_ch_and_band_to_idx(u8 channel_id, u8 band)
@@ -1687,11 +1705,210 @@ iwl_mvm_umac_scan_cfg_channels_v6(struct iwl_mvm *mvm,
 		cfg->flags = cpu_to_le32(flags | n_aps_flag);
 		cfg->v2.channel_num = channels[i]->hw_value;
 		cfg->v2.band = iwl_mvm_phy_band_from_nl80211(band);
+		if (cfg80211_channel_is_psc(channels[i]))
+			cfg->flags = 0;
 		cfg->v2.iter_count = 1;
 		cfg->v2.iter_interval = 0;
 	}
 }
 
+static int
+iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm_scan_params *params,
+				    __le32 *cmd_short_ssid, u8 *cmd_bssid,
+				    u8 *scan_ssid_num, u8 *bssid_num)
+{
+	int j, idex_s = 0, idex_b = 0;
+	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
+		params->scan_6ghz_params;
+
+	if (!params->n_6ghz_params) {
+		for (j = 0; j < params->n_ssids; j++) {
+			cmd_short_ssid[idex_s++] =
+				cpu_to_le32(~crc32_le(~0, params->ssids[j].ssid,
+						      params->ssids[j].ssid_len));
+			(*scan_ssid_num)++;
+		}
+		return 0;
+	}
+
+	/*
+	 * Populate the arrays of the short SSIDs and the BSSIDs using the 6GHz
+	 * collocated parameters. This might not be optimal, as this processing
+	 * does not (yet) correspond to the actual channels, so it is possible
+	 * that some entries would be left out.
+	 *
+	 * TODO: improve this logic.
+	 */
+	for (j = 0; j < params->n_6ghz_params; j++) {
+		int k;
+
+		/* First, try to place the short SSID */
+		if (scan_6ghz_params[j].short_ssid_valid) {
+			for (k = 0; k < idex_s; k++) {
+				if (cmd_short_ssid[k] ==
+				    cpu_to_le32(scan_6ghz_params[j].short_ssid))
+					break;
+			}
+
+			if (k == idex_s && idex_s < SCAN_SHORT_SSID_MAX_SIZE) {
+				cmd_short_ssid[idex_s++] =
+					cpu_to_le32(scan_6ghz_params[j].short_ssid);
+				(*scan_ssid_num)++;
+			}
+		}
+
+		/* try to place BSSID for the same entry */
+		for (k = 0; k < idex_b; k++) {
+			if (!memcmp(&cmd_bssid[ETH_ALEN * k],
+				    scan_6ghz_params[j].bssid, ETH_ALEN))
+				break;
+		}
+
+		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE) {
+			memcpy(&cmd_bssid[ETH_ALEN * idex_b++],
+			       scan_6ghz_params[j].bssid, ETH_ALEN);
+			(*bssid_num)++;
+		}
+	}
+	return 0;
+}
+
+/* TODO: this function can be merged with iwl_mvm_scan_umac_fill_ch_p_v6 */
+static void
+iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
+				     u32 n_channels, __le32 *cmd_short_ssid,
+				     u8 *cmd_bssid, u8 scan_ssid_num,
+				     u8 bssid_num,
+				     struct iwl_scan_channel_params_v6 *cp,
+				     enum nl80211_iftype vif_type)
+{
+	struct iwl_scan_channel_cfg_umac *channel_cfg = cp->channel_config;
+	int i;
+	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
+		params->scan_6ghz_params;
+
+	for (i = 0; i < params->n_channels; i++) {
+		struct iwl_scan_channel_cfg_umac *cfg =
+			&cp->channel_config[i];
+
+		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
+		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
+		bool force_passive, found = false,
+		     unsolicited_probe_on_chan = false, psc_no_listen = false;
+
+		cfg->v1.channel_num = params->channels[i]->hw_value;
+		cfg->v2.band = 2;
+		cfg->v2.iter_count = 1;
+		cfg->v2.iter_interval = 0;
+
+		/*
+		 * The optimize the scan time, i.e., reduce the scan dwell time
+		 * on each channel, the below logic tries to set 3 direct BSSID
+		 * probe requests for each broadcast probe request with a short
+		 * SSID.
+		 * TODO: improve this logic
+		 */
+		n_used_bssid_entries = 3;
+		for (j = 0; j < params->n_6ghz_params; j++) {
+			if (!(scan_6ghz_params[j].channel_idx == i))
+				continue;
+
+			found = false;
+			unsolicited_probe_on_chan |=
+				scan_6ghz_params[j].unsolicited_probe;
+			psc_no_listen |= scan_6ghz_params[j].psc_no_listen;
+
+			for (k = 0; k < scan_ssid_num; k++) {
+				if (!scan_6ghz_params[j].unsolicited_probe &&
+				    le32_to_cpu(cmd_short_ssid[k]) ==
+				    scan_6ghz_params[j].short_ssid) {
+					/* Relevant short SSID bit set */
+					if (s_ssid_bitmap & BIT(k)) {
+						found = true;
+						break;
+					}
+
+					/*
+					 * Use short SSID only to create a new
+					 * iteration during channel dwell.
+					 */
+					if (n_used_bssid_entries >= 3) {
+						s_ssid_bitmap |= BIT(k);
+						s_max++;
+						n_used_bssid_entries -= 3;
+						found = true;
+						break;
+					}
+				}
+			}
+
+			if (found)
+				continue;
+
+			for (k = 0; k < bssid_num; k++) {
+				if (!memcmp(&cmd_bssid[ETH_ALEN * k],
+					    scan_6ghz_params[j].bssid,
+					    ETH_ALEN)) {
+					if (!(bssid_bitmap & BIT(k))) {
+						bssid_bitmap |= BIT(k);
+						b_max++;
+						n_used_bssid_entries++;
+					}
+					break;
+				}
+			}
+		}
+
+		flags = bssid_bitmap | (s_ssid_bitmap << 16);
+
+		if (cfg80211_channel_is_psc(params->channels[i]) &&
+		    psc_no_listen)
+			flags |= IWL_UHB_CHAN_CFG_FLAG_PSC_CHAN_NO_LISTEN;
+
+		if (unsolicited_probe_on_chan)
+			flags |= IWL_UHB_CHAN_CFG_FLAG_UNSOLICITED_PROBE_RES;
+
+		/*
+		 * In the following cases apply passive scan:
+		 * 1. Non fragmented scan:
+		 *	- PSC channel with NO_LISTEN_FLAG on should be treated
+		 *	  like non PSC channel
+		 *	- Non PSC channel with more than 3 short SSIDs or more
+		 *	  than 9 BSSIDs.
+		 *	- Non PSC Channel with unsolicited probe response and
+		 *	  more than 2 short SSIDs or more than 6 BSSIDs.
+		 *	- PSC channel with more than 2 short SSIDs or more than
+		 *	  6 BSSIDs.
+		 * 3. Fragmented scan:
+		 *	- PSC channel with more than 1 SSID or 3 BSSIDs.
+		 *	- Non PSC channel with more than 2 SSIDs or 6 BSSIDs.
+		 *	- Non PSC channel with unsolicited probe response and
+		 *	  more than 1 SSID or more than 3 BSSIDs.
+		 */
+		if (!iwl_mvm_is_scan_fragmented(params->type)) {
+			if (!cfg80211_channel_is_psc(params->channels[i]) ||
+			    flags & IWL_UHB_CHAN_CFG_FLAG_PSC_CHAN_NO_LISTEN) {
+				force_passive = (s_max > 3 || b_max > 9);
+				force_passive |= (unsolicited_probe_on_chan &&
+						  (s_max > 2 || b_max > 6));
+			} else {
+				force_passive = (s_max > 2 || b_max > 6);
+			}
+		} else if (cfg80211_channel_is_psc(params->channels[i])) {
+			force_passive = (s_max > 1 || b_max > 3);
+		} else {
+			force_passive = (s_max > 2 || b_max > 6);
+			force_passive |= (unsolicited_probe_on_chan &&
+					  (s_max > 1 || b_max > 3));
+		}
+		if (force_passive ||
+		    (!flags && !cfg80211_channel_is_psc(params->channels[i])))
+			flags |= IWL_UHB_CHAN_CFG_FLAG_FORCE_PASSIVE;
+
+		channel_cfg[i].flags |= cpu_to_le32(flags);
+	}
+}
+
 static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
 					  struct iwl_mvm_scan_params *params,
 					  struct ieee80211_vif *vif)
@@ -1746,6 +1963,10 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 	if (type == IWL_MVM_SCAN_SCHED || type == IWL_MVM_SCAN_NETDETECT)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_PREEMPTIVE;
 
+	if ((type == IWL_MVM_SCAN_SCHED || type == IWL_MVM_SCAN_NETDETECT) &&
+	    params->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN;
+
 	return flags;
 }
 
@@ -2056,6 +2277,8 @@ static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_scan_req_umac_v14 *cmd = mvm->scan_cmd;
 	struct iwl_scan_req_params_v14 *scan_p = &cmd->scan_params;
+	struct iwl_scan_channel_params_v6 *cp = &scan_p->channel_params;
+	struct iwl_scan_probe_params_v4 *pb = &scan_p->probe_params;
 	int ret;
 	u16 gen_flags;
 	u32 bitmap_ssid = 0;
@@ -2078,8 +2301,34 @@ static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_scan_umac_fill_probe_p_v4(params, &scan_p->probe_params,
 					  &bitmap_ssid);
-	iwl_mvm_scan_umac_fill_ch_p_v6(mvm, params, vif,
-				       &scan_p->channel_params, bitmap_ssid);
+	if (!params->scan_6ghz) {
+		iwl_mvm_scan_umac_fill_ch_p_v6(mvm, params, vif,
+					       &scan_p->channel_params, bitmap_ssid);
+
+		return 0;
+	}
+	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
+	cp->n_aps_override[0] = IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY;
+	cp->n_aps_override[1] = IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS;
+
+	ret = iwl_mvm_umac_scan_fill_6g_chan_list(params, pb->short_ssid,
+						  pb->bssid_array[0],
+						  &pb->short_ssid_num,
+						  &pb->bssid_num);
+	if (ret)
+		return ret;
+
+	iwl_mvm_umac_scan_cfg_channels_v6_6g(params,
+					     params->n_channels,
+					     pb->short_ssid,
+					     pb->bssid_array[0],
+					     pb->short_ssid_num,
+					     pb->bssid_num, cp,
+					     vif->type);
+	cp->count = params->n_channels;
+	if (!params->n_ssids ||
+	    (params->n_ssids == 1 && !params->ssids[0].ssid_len))
+		cp->flags |= IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER;
 
 	return 0;
 }
@@ -2291,6 +2540,9 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	params.scan_plans = &scan_plan;
 	params.n_scan_plans = 1;
 
+	params.n_6ghz_params = req->n_6ghz_params;
+	params.scan_6ghz_params = req->scan_6ghz_params;
+	params.scan_6ghz = req->scan_6ghz;
 	iwl_mvm_fill_scan_type(mvm, &params, vif);
 
 	if (req->duration)
@@ -2340,6 +2592,8 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	};
 	struct iwl_mvm_scan_params params = {};
 	int ret;
+	int i, j;
+	bool non_psc_included = false;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -2356,8 +2610,6 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	if (WARN_ON(!mvm->scan_cmd))
 		return -ENOMEM;
 
-	if (!iwl_mvm_scan_fits(mvm, req->n_ssids, ies, req->n_channels))
-		return -ENOBUFS;
 
 	params.n_ssids = req->n_ssids;
 	params.flags = req->flags;
@@ -2397,8 +2649,44 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
+	/* for 6 GHZ band only PSC channels need to be added */
+	for (i = 0; i < params.n_channels; i++) {
+		struct ieee80211_channel *channel = params.channels[i];
+
+		if (channel->band == NL80211_BAND_6GHZ &&
+		    !cfg80211_channel_is_psc(channel)) {
+			non_psc_included = true;
+			break;
+		}
+	}
+
+	if (non_psc_included) {
+		params.channels = kmemdup(params.channels,
+					  sizeof(params.channels[0]) *
+					  params.n_channels,
+					  GFP_KERNEL);
+		if (!params.channels)
+			return -ENOMEM;
+
+		for (i = j = 0; i < params.n_channels; i++) {
+			if (params.channels[i]->band == NL80211_BAND_6GHZ &&
+			    !cfg80211_channel_is_psc(params.channels[i]))
+				continue;
+			params.channels[j++] = params.channels[i];
+		}
+		params.n_channels = j;
+	}
+
+	if (non_psc_included &&
+	    !iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
+		kfree(params.channels);
+		return -ENOBUFS;
+	}
+
 	ret = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
 
+	if (non_psc_included)
+		kfree(params.channels);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 017537944fd0..be185feaa8a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -196,6 +196,17 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		mpdu_dens = sta->ht_cap.ampdu_density;
 	}
 
+
+	if (mvm_sta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ) {
+		add_sta_cmd.station_flags_msk |=
+			cpu_to_le32(STA_FLG_MAX_AGG_SIZE_MSK |
+				    STA_FLG_AGG_MPDU_DENS_MSK);
+
+		mpdu_dens = le16_get_bits(sta->he_6ghz_capa.capa,
+					  IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+		agg_size = le16_get_bits(sta->he_6ghz_capa.capa,
+				IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+	} else
 	if (sta->vht_cap.vht_supported) {
 		agg_size = sta->vht_cap.cap &
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
-- 
2.29.2

