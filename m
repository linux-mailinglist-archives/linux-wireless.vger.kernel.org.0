Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40A6D5108
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfJLQas (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:30:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48822 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727939AbfJLQas (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:30:48 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGx-00062r-4g; Sat, 12 Oct 2019 19:29:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:22 +0300
Message-Id: <20191012192536.08eb9ccfdcc7.Ib35d53a1447210f4db54523b47c6147246f20399@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 11/13] iwlwifi: mvm: Invert the condition for OFDM rate
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

OFDM rate used for all bands except to band 2.4 which use CCK rate.
Inverting the condition help that in future we won't need to expand the
condition for more bands.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 7 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c       | 7 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index d9c23cd96336..b78992e341d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -855,11 +855,10 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct ieee80211_tx_info *info,
 				    struct ieee80211_vif *vif)
 {
 	u8 rate;
-
-	if (info->band == NL80211_BAND_5GHZ || vif->p2p)
-		rate = IWL_FIRST_OFDM_RATE;
-	else
+	if (info->band == NL80211_BAND_2GHZ && !vif->p2p)
 		rate = IWL_FIRST_CCK_RATE;
+	else
+		rate = IWL_FIRST_OFDM_RATE;
 
 	return rate;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index e3b2a2bf3863..f4778a6a40b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -341,8 +341,11 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 		rate_idx = rate_lowest_index(
 				&mvm->nvm_data->bands[info->band], sta);
 
-	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
-	if (info->band == NL80211_BAND_5GHZ)
+	/*
+	 * For non 2 GHZ band, remap mac80211 rate
+	 * indices into driver indices
+	 */
+	if (info->band != NL80211_BAND_2GHZ)
 		rate_idx += IWL_FIRST_OFDM_RATE;
 
 	/* For 2.4 GHZ band, check that there is no need to remap */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 8686107da116..6096276cb0d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -217,7 +217,7 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 	int band_offset = 0;
 
 	/* Legacy rate format, search for match in table */
-	if (band == NL80211_BAND_5GHZ)
+	if (band != NL80211_BAND_2GHZ)
 		band_offset = IWL_FIRST_OFDM_RATE;
 	for (idx = band_offset; idx < IWL_RATE_COUNT_LEGACY; idx++)
 		if (fw_rate_idx_to_plcp[idx] == rate)
-- 
2.23.0

