Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4838BA43CD
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfHaJwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:52:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39742 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726323AbfHaJwz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:52:55 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400R-0002OQ-2k; Sat, 31 Aug 2019 12:49:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:54 +0300
Message-Id: <20190831094859.6391-15-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 14/19] iwlwifi: mvm: look for the first supported channel when add/remove phy ctxt
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

Can't rely that band 2.4 is always supported by the NIC and use the
first channel in this band for the phy ctxt.
Instead, look for the first channel in the first band that is supported

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       | 11 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d2baea22cba2..a6e360194e00 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1282,6 +1282,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	int ret, i;
 	struct ieee80211_channel *chan;
 	struct cfg80211_chan_def chandef;
+	struct ieee80211_supported_band *sband = NULL;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1371,7 +1372,15 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		goto error;
 
 	/* Add all the PHY contexts */
-	chan = &mvm->hw->wiphy->bands[NL80211_BAND_2GHZ]->channels[0];
+	i = 0;
+	while (!sband && i < NUM_NL80211_BANDS)
+		sband = mvm->hw->wiphy->bands[i++];
+
+	if (WARN_ON_ONCE(!sband))
+		goto error;
+
+	chan = &sband->channels[0];
+
 	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
 	for (i = 0; i < NUM_PHY_CTX; i++) {
 		/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 86e40bae57e3..0243dbe8ac49 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -289,8 +289,17 @@ void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
 	if (ctxt->ref == 0) {
 		struct ieee80211_channel *chan;
 		struct cfg80211_chan_def chandef;
+		struct ieee80211_supported_band *sband = NULL;
+		enum nl80211_band band = NL80211_BAND_2GHZ;
+
+		while (!sband && band < NUM_NL80211_BANDS)
+			sband = mvm->hw->wiphy->bands[band++];
+
+		if (WARN_ON(!sband))
+			return;
+
+		chan = &sband->channels[0];
 
-		chan = &mvm->hw->wiphy->bands[NL80211_BAND_2GHZ]->channels[0];
 		cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
 		iwl_mvm_phy_ctxt_changed(mvm, ctxt, &chandef, 1, 1);
 	}
-- 
2.23.0.rc1

