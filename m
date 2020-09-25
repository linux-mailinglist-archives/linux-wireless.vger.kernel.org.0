Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D477027938D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgIYVbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52302 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbgIYVbC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvIx-002J1P-2Q; Sat, 26 Sep 2020 00:30:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:41 +0300
Message-Id: <iwlwifi.20200926002540.3d47f4e8ab98.I0fdd2ce23166c18284d2a7a624c40f35ea81cbc2@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/15] iwlwifi: regulatory: regulatory capabilities api change
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

Support v2 of regulatory capability flags parsed from the device
NVM. New API support is determined by FW lookup of the MCC update
command resposnse version, where version 6 supports the new API.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 98 +++++++++++++++++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +-
 3 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index ee410417761d..6d19de3058d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -254,6 +254,65 @@ enum iwl_reg_capa_flags {
 	REG_CAPA_11AX_DISABLED		= BIT(10),
 };
 
+/**
+ * enum iwl_reg_capa_flags_v2 - global flags applied for the whole regulatory
+ * domain (version 2).
+ * @REG_CAPA_V2_STRADDLE_DISABLED: Straddle channels (144, 142, 138) are
+ *	disabled.
+ * @REG_CAPA_V2_BF_CCD_LOW_BAND: Beam-forming or Cyclic Delay Diversity in the
+ *	2.4Ghz band is allowed.
+ * @REG_CAPA_V2_BF_CCD_HIGH_BAND: Beam-forming or Cyclic Delay Diversity in the
+ *	5Ghz band is allowed.
+ * @REG_CAPA_V2_160MHZ_ALLOWED: 11ac channel with a width of 160Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @REG_CAPA_V2_80MHZ_ALLOWED: 11ac channel with a width of 80Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @REG_CAPA_V2_MCS_8_ALLOWED: 11ac with MCS 8 is allowed.
+ * @REG_CAPA_V2_MCS_9_ALLOWED: 11ac with MCS 9 is allowed.
+ * @REG_CAPA_V2_WEATHER_DISABLED: Weather radar channels (120, 124, 128, 118,
+ *	126, 122) are disabled.
+ * @REG_CAPA_V2_40MHZ_ALLOWED: 11n channel with a width of 40Mhz is allowed
+ *	for this regulatory domain (uvalid only in 5Ghz).
+ * @REG_CAPA_V2_11AX_DISABLED: 11ax is forbidden for this regulatory domain.
+ */
+enum iwl_reg_capa_flags_v2 {
+	REG_CAPA_V2_STRADDLE_DISABLED	= BIT(0),
+	REG_CAPA_V2_BF_CCD_LOW_BAND	= BIT(1),
+	REG_CAPA_V2_BF_CCD_HIGH_BAND	= BIT(2),
+	REG_CAPA_V2_160MHZ_ALLOWED	= BIT(3),
+	REG_CAPA_V2_80MHZ_ALLOWED	= BIT(4),
+	REG_CAPA_V2_MCS_8_ALLOWED	= BIT(5),
+	REG_CAPA_V2_MCS_9_ALLOWED	= BIT(6),
+	REG_CAPA_V2_WEATHER_DISABLED	= BIT(7),
+	REG_CAPA_V2_40MHZ_ALLOWED	= BIT(8),
+	REG_CAPA_V2_11AX_DISABLED	= BIT(13),
+};
+
+/*
+* API v2 for reg_capa_flags is relevant from version 6 and onwards of the
+* MCC update command response.
+*/
+#define REG_CAPA_V2_RESP_VER	6
+
+/**
+ * struct iwl_reg_capa - struct for global regulatory capabilities, Used for
+ * handling the different APIs of reg_capa_flags.
+ *
+ * @allow_40mhz: 11n channel with a width of 40Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @allow_80mhz: 11ac channel with a width of 80Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @allow_160mhz: 11ac channel with a width of 160Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @disable_11ax: 11ax is forbidden for this regulatory domain.
+ */
+struct iwl_reg_capa {
+	u16 allow_40mhz;
+	u16 allow_80mhz;
+	u16 allow_160mhz;
+	u16 disable_11ax;
+};
+
 static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
 					       int chan, u32 flags)
 {
@@ -1064,7 +1123,7 @@ IWL_EXPORT_SYMBOL(iwl_parse_nvm_data);
 
 static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 				       int ch_idx, u16 nvm_flags,
-				       u16 cap_flags,
+				       struct iwl_reg_capa reg_capa,
 				       const struct iwl_cfg *cfg)
 {
 	u32 flags = NL80211_RRF_NO_HT40;
@@ -1104,29 +1163,46 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 		flags |= NL80211_RRF_GO_CONCURRENT;
 
 	/*
-	 * cap_flags is per regulatory domain so apply it for every channel
+	 * reg_capa is per regulatory domain so apply it for every channel
 	 */
 	if (ch_idx >= NUM_2GHZ_CHANNELS) {
-		if (cap_flags & REG_CAPA_40MHZ_FORBIDDEN)
+		if (!reg_capa.allow_40mhz)
 			flags |= NL80211_RRF_NO_HT40;
 
-		if (!(cap_flags & REG_CAPA_80MHZ_ALLOWED))
+		if (!reg_capa.allow_80mhz)
 			flags |= NL80211_RRF_NO_80MHZ;
 
-		if (!(cap_flags & REG_CAPA_160MHZ_ALLOWED))
+		if (!reg_capa.allow_160mhz)
 			flags |= NL80211_RRF_NO_160MHZ;
 	}
-
-	if (cap_flags & REG_CAPA_11AX_DISABLED)
+	if (reg_capa.disable_11ax)
 		flags |= NL80211_RRF_NO_HE;
 
 	return flags;
 }
 
+static struct iwl_reg_capa iwl_get_reg_capa(u16 flags, u8 resp_ver)
+{
+	struct iwl_reg_capa reg_capa;
+
+	if (resp_ver >= REG_CAPA_V2_RESP_VER) {
+		reg_capa.allow_40mhz = flags & REG_CAPA_V2_40MHZ_ALLOWED;
+		reg_capa.allow_80mhz = flags & REG_CAPA_V2_80MHZ_ALLOWED;
+		reg_capa.allow_160mhz = flags & REG_CAPA_V2_160MHZ_ALLOWED;
+		reg_capa.disable_11ax = flags & REG_CAPA_V2_11AX_DISABLED;
+	} else {
+		reg_capa.allow_40mhz = !(flags & REG_CAPA_40MHZ_FORBIDDEN);
+		reg_capa.allow_80mhz = flags & REG_CAPA_80MHZ_ALLOWED;
+		reg_capa.allow_160mhz = flags & REG_CAPA_160MHZ_ALLOWED;
+		reg_capa.disable_11ax = flags & REG_CAPA_11AX_DISABLED;
+	}
+	return reg_capa;
+}
+
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u16 cap)
+		       u16 geo_info, u16 cap, u8 resp_ver)
 {
 	int ch_idx;
 	u16 ch_flags;
@@ -1139,6 +1215,7 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	int valid_rules = 0;
 	bool new_rule;
 	int max_num_ch;
+	struct iwl_reg_capa reg_capa;
 
 	if (cfg->uhb_supported) {
 		max_num_ch = IWL_NVM_NUM_CHANNELS_UHB;
@@ -1169,6 +1246,9 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	regd->alpha2[0] = fw_mcc >> 8;
 	regd->alpha2[1] = fw_mcc & 0xff;
 
+	/* parse regulatory capability flags */
+	reg_capa = iwl_get_reg_capa(cap, resp_ver);
+
 	for (ch_idx = 0; ch_idx < num_of_ch; ch_idx++) {
 		ch_flags = (u16)__le32_to_cpup(channels + ch_idx);
 		band = iwl_nl80211_band_from_channel_idx(ch_idx);
@@ -1183,7 +1263,7 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		}
 
 		reg_rule_flags = iwl_nvm_get_regdom_bw_flags(nvm_chan, ch_idx,
-							     ch_flags, cap,
+							     ch_flags, reg_capa,
 							     cfg);
 
 		/* we can't continue the same rule */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index fb0b385d10fd..50bd7fdcf852 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -104,7 +104,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u16 cap);
+		       u16 geo_info, u16 cap, u8 resp_ver);
 
 /**
  * struct iwl_nvm_section - describes an NVM section in memory.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 12f217f2d7b3..6e8af84f386a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -234,6 +234,7 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mcc_update_resp *resp;
+	u8 resp_ver;
 
 	IWL_DEBUG_LAR(mvm, "Getting regdomain data for %s from FW\n", alpha2);
 
@@ -252,13 +253,16 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 		*changed = (status == MCC_RESP_NEW_CHAN_PROFILE ||
 			    status == MCC_RESP_ILLEGAL);
 	}
+	resp_ver = iwl_fw_lookup_notif_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					   MCC_UPDATE_CMD, 0);
+	IWL_DEBUG_LAR(mvm, "MCC update response version: %d\n", resp_ver);
 
 	regd = iwl_parse_nvm_mcc_info(mvm->trans->dev, mvm->cfg,
 				      __le32_to_cpu(resp->n_channels),
 				      resp->channels,
 				      __le16_to_cpu(resp->mcc),
 				      __le16_to_cpu(resp->geo_info),
-				      __le16_to_cpu(resp->cap));
+				      __le16_to_cpu(resp->cap), resp_ver);
 	/* Store the return source id */
 	src_id = resp->source_id;
 	kfree(resp);
-- 
2.28.0

