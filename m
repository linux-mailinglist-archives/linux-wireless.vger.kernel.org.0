Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3127B2CFAC1
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 10:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgLEJHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 04:07:40 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34468 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727967AbgLEJEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 04:04:33 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klTSw-0039ST-Kb; Sat, 05 Dec 2020 11:02:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  5 Dec 2020 11:02:51 +0200
Message-Id: <iwlwifi.20201205105241.6b4ee30c59e4.I0c30ef78b3bf727fe80b16a19c7588016d6b04bf@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205090252.337391-1-luca@coelho.fi>
References: <20201205090252.337391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 1/2] iwlwifi: copy iwl_he_capa for modifications
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This data is not necessarily the same across devices as we may
modify it due to the number of antennas and for overrides (though
in practice overrides are likely to be identical), so modifying
the global data is wrong.

Make a copy of it in the NVM data and modify it there instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |  6 ++++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 33 ++++++++++++++++---
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
index 03a748cc98fa..3a4562b45410 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
@@ -99,6 +99,12 @@ struct iwl_nvm_data {
 	bool lar_enabled;
 	bool vht160_supported;
 	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
+
+	struct {
+		struct ieee80211_sband_iftype_data low[2];
+		struct ieee80211_sband_iftype_data high[2];
+	} iftd;
+
 	struct ieee80211_channel channels[];
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 6d19de3058d2..6f3aca19a254 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -580,7 +580,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
 }
 
-static struct ieee80211_sband_iftype_data iwl_he_capa[] = {
+static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 	{
 		.types_mask = BIT(NL80211_IFTYPE_STATION),
 		.he_cap = {
@@ -748,7 +748,30 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 				 struct ieee80211_supported_band *sband,
 				 u8 tx_chains, u8 rx_chains)
 {
-	sband->iftype_data = iwl_he_capa;
+	struct ieee80211_sband_iftype_data *iftype_data;
+
+	/* should only initialize once */
+	if (WARN_ON(sband->iftype_data))
+		return;
+
+	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_capa));
+	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_capa));
+
+	switch (sband->band) {
+	case NL80211_BAND_2GHZ:
+		iftype_data = data->iftd.low;
+		break;
+	case NL80211_BAND_5GHZ:
+		iftype_data = data->iftd.high;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	memcpy(iftype_data, iwl_he_capa, sizeof(iwl_he_capa));
+
+	sband->iftype_data = iftype_data;
 	sband->n_iftype_data = ARRAY_SIZE(iwl_he_capa);
 
 	/* If not 2x2, we need to indicate 1x1 in the Midamble RX Max NSTS */
@@ -756,11 +779,11 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 		int i;
 
 		for (i = 0; i < sband->n_iftype_data; i++) {
-			iwl_he_capa[i].he_cap.he_cap_elem.phy_cap_info[1] &=
+			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[1] &=
 				~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
-			iwl_he_capa[i].he_cap.he_cap_elem.phy_cap_info[2] &=
+			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[2] &=
 				~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
-			iwl_he_capa[i].he_cap.he_cap_elem.phy_cap_info[7] &=
+			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[7] &=
 				~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
 		}
 	}
-- 
2.29.2

