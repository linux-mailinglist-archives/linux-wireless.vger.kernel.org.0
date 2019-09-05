Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CCAAA441
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbfIENWj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41100 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388593AbfIENWj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:39 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rie-00062D-Mx; Thu, 05 Sep 2019 16:22:37 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:06 +0300
Message-Id: <20190905132220.23970-8-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 07/21] iwlwifi: pass the iwl_trans instead of cfg to some functions
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

A few functions were receiving the iwl_cfg struct directly, but we
will also need other parts of the trans, so pass the trans (which
includes the cfg) to them.

Signed-off-by: Ido Yariv <idox.yariv@intel.com>
Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index e43e452403f5..83d4311e83d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -393,11 +393,12 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 	return n_channels;
 }
 
-static void iwl_init_vht_hw_capab(const struct iwl_cfg *cfg,
+static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 				  struct iwl_nvm_data *data,
 				  struct ieee80211_sta_vht_cap *vht_cap,
 				  u8 tx_chains, u8 rx_chains)
 {
+	const struct iwl_cfg *cfg = trans->cfg;
 	int num_rx_ants = num_of_ant(rx_chains);
 	int num_tx_ants = num_of_ant(tx_chains);
 	unsigned int max_ampdu_exponent = (cfg->max_vht_ampdu_exponent ?:
@@ -669,11 +670,13 @@ static void iwl_init_he_hw_capab(struct ieee80211_supported_band *sband,
 	}
 }
 
-static void iwl_init_sbands(struct device *dev, const struct iwl_cfg *cfg,
+static void iwl_init_sbands(struct iwl_trans *trans,
 			    struct iwl_nvm_data *data,
 			    const void *nvm_ch_flags, u8 tx_chains,
 			    u8 rx_chains, u32 sbands_flags, bool v4)
 {
+	struct device *dev = trans->dev;
+	const struct iwl_cfg *cfg = trans->cfg;
 	int n_channels;
 	int n_used = 0;
 	struct ieee80211_supported_band *sband;
@@ -701,7 +704,7 @@ static void iwl_init_sbands(struct device *dev, const struct iwl_cfg *cfg,
 	iwl_init_ht_hw_capab(cfg, data, &sband->ht_cap, NL80211_BAND_5GHZ,
 			     tx_chains, rx_chains);
 	if (data->sku_cap_11ac_enable && !iwlwifi_mod_params.disable_11ac)
-		iwl_init_vht_hw_capab(cfg, data, &sband->vht_cap,
+		iwl_init_vht_hw_capab(trans, data, &sband->vht_cap,
 				      tx_chains, rx_chains);
 
 	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
@@ -1019,7 +1022,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (iwl_nvm_no_wide_in_5ghz(dev, cfg, nvm_hw))
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_NO_WIDE_IN_5GHZ;
 
-	iwl_init_sbands(dev, cfg, data, ch_section, tx_chains, rx_chains,
+	iwl_init_sbands(trans, data, ch_section, tx_chains, rx_chains,
 			sbands_flags, false);
 	data->calib_version = 255;
 
@@ -1485,7 +1488,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	channel_profile = v4 ? (void *)rsp->regulatory.channel_profile :
 			  (void *)rsp_v3->regulatory.channel_profile;
 
-	iwl_init_sbands(trans->dev, trans->cfg, nvm,
+	iwl_init_sbands(trans, nvm,
 			channel_profile,
 			nvm->valid_tx_ant & fw->valid_tx_ant,
 			nvm->valid_rx_ant & fw->valid_rx_ant,
-- 
2.23.0.rc1

