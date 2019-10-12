Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEAD5107
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfJLQar (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:30:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48818 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727939AbfJLQar (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:30:47 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGw-00062r-7b; Sat, 12 Oct 2019 19:29:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:21 +0300
Message-Id: <20191012192536.aabda89c84f4.I7637fc924b7d78e047ddb951a434bc81b11b101e@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 10/13] iwlwifi: mvm: create function to convert nl80211 band to phy band
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

Create the function and use it.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 22 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 20 +++++------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a7d5bd1c1206..e879c02ca4db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3636,8 +3636,7 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 
 	/* Set the channel info data */
 	iwl_mvm_set_chan_info(mvm, &aux_roc_req.channel_info, channel->hw_value,
-			      (channel->band == NL80211_BAND_2GHZ) ?
-			       PHY_BAND_24 : PHY_BAND_5,
+			      iwl_mvm_phy_band_from_nl80211(channel->band),
 			      PHY_VHT_CHANNEL_MODE20,
 			      0);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f0246969dca0..d9c437682a5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2077,6 +2077,19 @@ void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 			     struct dentry *dir);
 #endif
 
+static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
+{
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		return PHY_BAND_24;
+	case NL80211_BAND_5GHZ:
+		return PHY_BAND_5;
+	default:
+		WARN_ONCE(1, "Unsupported band (%u)\n", band);
+		return PHY_BAND_5;
+	}
+}
+
 /* Channel info utils */
 static inline bool iwl_mvm_has_ultra_hb_channel(struct iwl_mvm *mvm)
 {
@@ -2125,11 +2138,12 @@ iwl_mvm_set_chan_info_chandef(struct iwl_mvm *mvm,
 			      struct iwl_fw_channel_info *ci,
 			      struct cfg80211_chan_def *chandef)
 {
+	enum nl80211_band band = chandef->chan->band;
+
 	iwl_mvm_set_chan_info(mvm, ci, chandef->chan->hw_value,
-			      (chandef->chan->band == NL80211_BAND_2GHZ ?
-			       PHY_BAND_24 : PHY_BAND_5),
-			       iwl_mvm_get_channel_width(chandef),
-			       iwl_mvm_get_ctrl_pos(chandef));
+			      iwl_mvm_phy_band_from_nl80211(band),
+			      iwl_mvm_get_channel_width(chandef),
+			      iwl_mvm_get_ctrl_pos(chandef));
 }
 
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index f6b3045badbd..2f92f6516415 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -79,9 +79,6 @@
 #define IWL_SCAN_NUM_OF_FRAGS		3
 #define IWL_SCAN_LAST_2_4_CHN		14
 
-#define IWL_SCAN_BAND_5_2		0
-#define IWL_SCAN_BAND_2_4		1
-
 /* adaptive dwell max budget time [TU] for full scan */
 #define IWL_SCAN_ADWELL_MAX_BUDGET_FULL_SCAN 300
 /* adaptive dwell max budget time [TU] for directed scan */
@@ -196,14 +193,6 @@ static inline __le16 iwl_mvm_scan_rx_chain(struct iwl_mvm *mvm)
 	return cpu_to_le16(rx_chain);
 }
 
-static __le32 iwl_mvm_scan_rxon_flags(enum nl80211_band band)
-{
-	if (band == NL80211_BAND_2GHZ)
-		return cpu_to_le32(PHY_BAND_24);
-	else
-		return cpu_to_le32(PHY_BAND_5);
-}
-
 static inline __le32
 iwl_mvm_scan_rate_n_flags(struct iwl_mvm *mvm, enum nl80211_band band,
 			  bool no_cck)
@@ -981,6 +970,7 @@ static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 mvm->fw->ucode_capa.n_scan_channels);
 	u32 ssid_bitmap = 0;
 	int i;
+	u8 band;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1000,7 +990,8 @@ static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd->scan_flags = cpu_to_le32(iwl_mvm_scan_lmac_flags(mvm, params,
 							      vif));
 
-	cmd->flags = iwl_mvm_scan_rxon_flags(params->channels[0]->band);
+	band = iwl_mvm_phy_band_from_nl80211(params->channels[0]->band);
+	cmd->flags = cpu_to_le32(band);
 	cmd->filter_flags = cpu_to_le32(MAC_FILTER_ACCEPT_GRP |
 					MAC_FILTER_IN_BEACON);
 	iwl_mvm_scan_fill_tx_cmd(mvm, cmd->tx_cmd, params->no_cck);
@@ -1402,9 +1393,10 @@ iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 		channel_cfg[i].flags = cpu_to_le32(ssid_bitmap);
 		channel_cfg[i].v1.channel_num = channels[i]->hw_value;
 		if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
+			enum nl80211_band band = channels[i]->band;
+
 			channel_cfg[i].v2.band =
-				channels[i]->hw_value <= IWL_SCAN_LAST_2_4_CHN ?
-					IWL_SCAN_BAND_2_4 : IWL_SCAN_BAND_5_2;
+				iwl_mvm_phy_band_from_nl80211(band);
 			channel_cfg[i].v2.iter_count = 1;
 			channel_cfg[i].v2.iter_interval = 0;
 		} else {
-- 
2.23.0

