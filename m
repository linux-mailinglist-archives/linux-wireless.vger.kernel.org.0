Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650B046FB15
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhLJHKI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:08 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50846 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234835AbhLJHKI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:08 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZzD-001F9v-RU; Fri, 10 Dec 2021 09:06:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:19 +0200
Message-Id: <iwlwifi.20211210090244.7d1a57f3df1b.Ibc01dde2b064329ad5f5bcefa83d1998d557cbdb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/11] iwlwifi: rs: add support for TLC config command ver 4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The new version enables support for EHT mode configurations.

The name of IWL_TLC_HT_BW_NONE_160 change to IWL_TLC_MCS_PER_BW_80
to make the difference from 80 bandwidth (non 160), and the new bandwidth
320 which is also non 160.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 56 +++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 72 +++++++++++++------
 2 files changed, 99 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index a09081d7ed45..173a6991587b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -116,9 +116,20 @@ enum IWL_TLC_MNG_NSS {
 	IWL_TLC_NSS_MAX
 };
 
-enum IWL_TLC_HT_BW_RATES {
-	IWL_TLC_HT_BW_NONE_160,
-	IWL_TLC_HT_BW_160,
+/**
+ * enum IWL_TLC_MCS_PER_BW - mcs index per BW
+ * @IWL_TLC_MCS_PER_BW_80: mcs for bw - 20Hhz, 40Hhz, 80Hhz
+ * @IWL_TLC_MCS_PER_BW_160: mcs for bw - 160Mhz
+ * @IWL_TLC_MCS_PER_BW_320: mcs for bw - 320Mhz
+ * @IWL_TLC_MCS_PER_BW_NUM_V3: number of entries up to version 3
+ * @IWL_TLC_MCS_PER_BW_NUM_V4: number of entries from version 4
+ */
+enum IWL_TLC_MCS_PER_BW {
+	IWL_TLC_MCS_PER_BW_80,
+	IWL_TLC_MCS_PER_BW_160,
+	IWL_TLC_MCS_PER_BW_320,
+	IWL_TLC_MCS_PER_BW_NUM_V3 = IWL_TLC_MCS_PER_BW_160 + 1,
+	IWL_TLC_MCS_PER_BW_NUM_V4 = IWL_TLC_MCS_PER_BW_320 + 1,
 };
 
 /**
@@ -131,8 +142,8 @@ enum IWL_TLC_HT_BW_RATES {
  * @amsdu: TX amsdu is supported
  * @flags: bitmask of &enum iwl_tlc_mng_cfg_flags
  * @non_ht_rates: bitmap of supported legacy rates
- * @ht_rates: bitmap of &enum iwl_tlc_mng_ht_rates, per <nss, channel-width>
- *	      pair (0 - 80mhz width and below, 1 - 160mhz).
+ * @ht_rates: bitmap of &enum iwl_tlc_mng_ht_rates, per &enum IWL_TLC_MCS_PER_BW
+ *	      <nss, channel-width> pair (0 - 80mhz width and below, 1 - 160mhz).
  * @max_mpdu_len: max MPDU length, in bytes
  * @sgi_ch_width_supp: bitmap of SGI support per channel width
  *		       use BIT(@enum iwl_tlc_mng_cfg_cw)
@@ -140,7 +151,7 @@ enum IWL_TLC_HT_BW_RATES {
  * @max_tx_op: max TXOP in uSecs for all AC (BK, BE, VO, VI),
  *	       set zero for no limit.
  */
-struct iwl_tlc_config_cmd {
+struct iwl_tlc_config_cmd_v3 {
 	u8 sta_id;
 	u8 reserved1[3];
 	u8 max_ch_width;
@@ -149,13 +160,44 @@ struct iwl_tlc_config_cmd {
 	u8 amsdu;
 	__le16 flags;
 	__le16 non_ht_rates;
-	__le16 ht_rates[IWL_TLC_NSS_MAX][2];
+	__le16 ht_rates[IWL_TLC_NSS_MAX][IWL_TLC_MCS_PER_BW_NUM_V3];
 	__le16 max_mpdu_len;
 	u8 sgi_ch_width_supp;
 	u8 reserved2;
 	__le32 max_tx_op;
 } __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_3 */
 
+/**
+ * struct tlc_config_cmd - TLC configuration
+ * @sta_id: station id
+ * @reserved1: reserved
+ * @max_ch_width: max supported channel width from &enum iwl_tlc_mng_cfg_cw
+ * @mode: &enum iwl_tlc_mng_cfg_mode
+ * @chains: bitmask of &enum iwl_tlc_mng_cfg_chains
+ * @sgi_ch_width_supp: bitmap of SGI support per channel width
+ *		       use BIT(&enum iwl_tlc_mng_cfg_cw)
+ * @flags: bitmask of &enum iwl_tlc_mng_cfg_flags
+ * @non_ht_rates: bitmap of supported legacy rates
+ * @ht_rates: bitmap of &enum iwl_tlc_mng_ht_rates, per <nss, channel-width>
+ *	      pair (0 - 80mhz width and below, 1 - 160mhz, 2 - 320mhz).
+ * @max_mpdu_len: max MPDU length, in bytes
+ * @max_tx_op: max TXOP in uSecs for all AC (BK, BE, VO, VI),
+ *	       set zero for no limit.
+ */
+struct iwl_tlc_config_cmd_v4 {
+	u8 sta_id;
+	u8 reserved1[3];
+	u8 max_ch_width;
+	u8 mode;
+	u8 chains;
+	u8 sgi_ch_width_supp;
+	__le16 flags;
+	__le16 non_ht_rates;
+	__le16 ht_rates[IWL_TLC_NSS_MAX][IWL_TLC_MCS_PER_BW_NUM_V4];
+	__le16 max_mpdu_len;
+	__le16 max_tx_op;
+} __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_4 */
+
 /**
  * enum iwl_tlc_update_flags - updated fields
  * @IWL_TLC_NOTIF_FLAG_RATE: last initial rate update
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 970b92fd7042..c41487652ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -129,7 +129,7 @@ int rs_fw_vht_highest_rx_mcs_index(const struct ieee80211_sta_vht_cap *vht_cap,
 static void
 rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 			    const struct ieee80211_sta_vht_cap *vht_cap,
-			    struct iwl_tlc_config_cmd *cmd)
+			    struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	u16 supp;
 	int i, highest_mcs;
@@ -154,7 +154,7 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 		if (sta->bandwidth == IEEE80211_STA_RX_BW_20)
 			supp &= ~BIT(IWL_TLC_MNG_HT_RATE_MCS9);
 
-		cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160] = cpu_to_le16(supp);
+		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80] = cpu_to_le16(supp);
 		/*
 		 * Check if VHT extended NSS indicates that the bandwidth/NSS
 		 * configuration is supported - only for MCS 0 since we already
@@ -164,8 +164,8 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 		    ieee80211_get_vht_max_nss(&ieee_vht_cap,
 					      IEEE80211_VHT_CHANWIDTH_160MHZ,
 					      0, true, nss) >= nss)
-			cmd->ht_rates[i][IWL_TLC_HT_BW_160] =
-				cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160];
+			cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_160] =
+				cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80];
 	}
 }
 
@@ -189,7 +189,7 @@ static u16 rs_fw_he_ieee80211_mcs_to_rs_mcs(u16 mcs)
 static void
 rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 			   struct ieee80211_supported_band *sband,
-			   struct iwl_tlc_config_cmd *cmd)
+			   struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	u16 mcs_160 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
@@ -219,7 +219,7 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 		}
 		if (_mcs_80 > _tx_mcs_80)
 			_mcs_80 = _tx_mcs_80;
-		cmd->ht_rates[i][IWL_TLC_HT_BW_NONE_160] =
+		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80] =
 			cpu_to_le16(rs_fw_he_ieee80211_mcs_to_rs_mcs(_mcs_80));
 
 		/* If one side doesn't support - mark both as not supporting */
@@ -230,14 +230,14 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 		}
 		if (_mcs_160 > _tx_mcs_160)
 			_mcs_160 = _tx_mcs_160;
-		cmd->ht_rates[i][IWL_TLC_HT_BW_160] =
+		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_160] =
 			cpu_to_le16(rs_fw_he_ieee80211_mcs_to_rs_mcs(_mcs_160));
 	}
 }
 
 static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 				 struct ieee80211_supported_band *sband,
-				 struct iwl_tlc_config_cmd *cmd)
+				 struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	int i;
 	u16 supp = 0;
@@ -263,15 +263,15 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 		rs_fw_vht_set_enabled_rates(sta, vht_cap, cmd);
 	} else if (ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
-		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_HT_BW_NONE_160] =
+		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_MCS_PER_BW_80] =
 			cpu_to_le16(ht_cap->mcs.rx_mask[0]);
 
 		/* the station support only a single receive chain */
 		if (sta->smps_mode == IEEE80211_SMPS_STATIC)
-			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
+			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_MCS_PER_BW_80] =
 				0;
 		else
-			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
+			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_MCS_PER_BW_80] =
 				cpu_to_le16(ht_cap->mcs.rx_mask[1]);
 	}
 }
@@ -422,23 +422,18 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	u32 cmd_id = iwl_cmd_id(TLC_MNG_CONFIG_CMD, DATA_PATH_GROUP, 0);
 	struct ieee80211_supported_band *sband = hw->wiphy->bands[band];
 	u16 max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
-	struct iwl_tlc_config_cmd cfg_cmd = {
+	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
 		.sta_id = mvmsta->sta_id,
 		.max_ch_width = update ?
 			rs_fw_bw_from_sta_bw(sta) : RATE_MCS_CHAN_WIDTH_20,
 		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, sta, sband)),
 		.chains = rs_fw_set_active_chains(iwl_mvm_get_valid_tx_ant(mvm)),
 		.sgi_ch_width_supp = rs_fw_sgi_cw_support(sta),
-		.max_mpdu_len = cpu_to_le16(max_amsdu_len),
-		.amsdu = iwl_mvm_is_csum_supported(mvm),
+		.max_mpdu_len = iwl_mvm_is_csum_supported(mvm) ?
+				cpu_to_le16(max_amsdu_len) : 0,
 	};
 	int ret;
-	u16 cmd_size = sizeof(cfg_cmd);
-
-	/* In old versions of the API the struct is 4 bytes smaller */
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
-				  TLC_MNG_CONFIG_CMD, 0) < 3)
-		cmd_size -= 4;
+	int cmd_ver;
 
 	memset(lq_sta, 0, offsetof(typeof(*lq_sta), pers));
 
@@ -453,8 +448,41 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	 */
 	sta->max_amsdu_len = max_amsdu_len;
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, cmd_size,
-				   &cfg_cmd);
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
+					TLC_MNG_CONFIG_CMD, 0);
+	if (cmd_ver == 4) {
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC,
+					   sizeof(cfg_cmd), &cfg_cmd);
+	} else if (cmd_ver < 4) {
+		struct iwl_tlc_config_cmd_v3 cfg_cmd_v3 = {
+			.sta_id = cfg_cmd.sta_id,
+			.max_ch_width = cfg_cmd.max_ch_width,
+			.mode = cfg_cmd.mode,
+			.chains = cfg_cmd.chains,
+			.amsdu = !!cfg_cmd.max_mpdu_len,
+			.flags = cfg_cmd.flags,
+			.non_ht_rates = cfg_cmd.non_ht_rates,
+			.ht_rates[0][0] = cfg_cmd.ht_rates[0][0],
+			.ht_rates[0][1] = cfg_cmd.ht_rates[0][1],
+			.ht_rates[1][0] = cfg_cmd.ht_rates[1][0],
+			.ht_rates[1][1] = cfg_cmd.ht_rates[1][1],
+			.sgi_ch_width_supp = cfg_cmd.sgi_ch_width_supp,
+			.max_mpdu_len = cfg_cmd.max_mpdu_len,
+		};
+
+		u16 cmd_size = sizeof(cfg_cmd_v3);
+
+		/* In old versions of the API the struct is 4 bytes smaller */
+		if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
+					  TLC_MNG_CONFIG_CMD, 0) < 3)
+			cmd_size -= 4;
+
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, cmd_size,
+					   &cfg_cmd_v3);
+	} else {
+		ret = -EINVAL;
+	}
+
 	if (ret)
 		IWL_ERR(mvm, "Failed to send rate scale config (%d)\n", ret);
 }
-- 
2.34.1

