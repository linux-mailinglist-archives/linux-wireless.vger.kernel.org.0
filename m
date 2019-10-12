Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF3D5109
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfJLQau (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:30:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48828 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727939AbfJLQau (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:30:50 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGx-00062r-Rc; Sat, 12 Oct 2019 19:29:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:23 +0300
Message-Id: <20191012192536.048a5113ea25.I5c7497c483448a99cf22b9b0b8088970d45a1399@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 12/13] iwlwifi: nvm: create function to convert channel index to nl80211_band
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

Create function to convert channel index to nl80211_band
and use it.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index c8972f6e38ba..b0a0901ce0f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -256,12 +256,12 @@ static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
 #undef CHECK_AND_PRINT_I
 }
 
-static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, bool is_5ghz,
+static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, enum nl80211_band band,
 				 u32 nvm_flags, const struct iwl_cfg *cfg)
 {
 	u32 flags = IEEE80211_CHAN_NO_HT40;
 
-	if (!is_5ghz && (nvm_flags & NVM_CHANNEL_40MHZ)) {
+	if (band == NL80211_BAND_2GHZ && (nvm_flags & NVM_CHANNEL_40MHZ)) {
 		if (ch_num <= LAST_2GHZ_HT_PLUS)
 			flags &= ~IEEE80211_CHAN_NO_HT40PLUS;
 		if (ch_num >= FIRST_2GHZ_HT_MINUS)
@@ -299,6 +299,13 @@ static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, bool is_5ghz,
 	return flags;
 }
 
+static enum nl80211_band iwl_nl80211_band_from_channel_idx(int ch_idx)
+{
+	if (ch_idx >= NUM_2GHZ_CHANNELS)
+		return NL80211_BAND_5GHZ;
+	return NL80211_BAND_2GHZ;
+}
+
 static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 				struct iwl_nvm_data *data,
 				const void * const nvm_ch_flags,
@@ -308,7 +315,7 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 	int n_channels = 0;
 	struct ieee80211_channel *channel;
 	u32 ch_flags;
-	int num_of_ch, num_2ghz_channels = NUM_2GHZ_CHANNELS;
+	int num_of_ch;
 	const u16 *nvm_chan;
 
 	if (cfg->uhb_supported) {
@@ -323,7 +330,8 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 	}
 
 	for (ch_idx = 0; ch_idx < num_of_ch; ch_idx++) {
-		bool is_5ghz = (ch_idx >= num_2ghz_channels);
+		enum nl80211_band band =
+			iwl_nl80211_band_from_channel_idx(ch_idx);
 
 		if (v4)
 			ch_flags =
@@ -332,12 +340,13 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 			ch_flags =
 				__le16_to_cpup((__le16 *)nvm_ch_flags + ch_idx);
 
-		if (is_5ghz && !data->sku_cap_band_52ghz_enable)
+		if (band == NL80211_BAND_5GHZ &&
+		    !data->sku_cap_band_52ghz_enable)
 			continue;
 
 		/* workaround to disable wide channels in 5GHz */
 		if ((sbands_flags & IWL_NVM_SBANDS_FLAGS_NO_WIDE_IN_5GHZ) &&
-		    is_5ghz) {
+		    band == NL80211_BAND_5GHZ) {
 			ch_flags &= ~(NVM_CHANNEL_40MHZ |
 				     NVM_CHANNEL_80MHZ |
 				     NVM_CHANNEL_160MHZ);
@@ -362,8 +371,7 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 		n_channels++;
 
 		channel->hw_value = nvm_chan[ch_idx];
-		channel->band = is_5ghz ?
-				NL80211_BAND_5GHZ : NL80211_BAND_2GHZ;
+		channel->band = band;
 		channel->center_freq =
 			ieee80211_channel_to_frequency(
 				channel->hw_value, channel->band);
@@ -379,7 +387,7 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 		/* don't put limitations in case we're using LAR */
 		if (!(sbands_flags & IWL_NVM_SBANDS_FLAGS_LAR))
 			channel->flags = iwl_get_channel_flags(nvm_chan[ch_idx],
-							       ch_idx, is_5ghz,
+							       ch_idx, band,
 							       ch_flags, cfg);
 		else
 			channel->flags = 0;
-- 
2.23.0

