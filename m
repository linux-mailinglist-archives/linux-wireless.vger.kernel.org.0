Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112EA270320
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIRRU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 13:20:57 -0400
Received: from 3.mo174.mail-out.ovh.net ([178.33.253.172]:35897 "EHLO
        3.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRRU5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 13:20:57 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 13:20:56 EDT
Received: from mxplan8.mail.ovh.net (unknown [10.108.4.44])
        by mo174.mail-out.ovh.net (Postfix) with ESMTPS id 4D7144308944;
        Fri, 18 Sep 2020 19:14:55 +0200 (CEST)
Received: from awhome.eu (37.59.142.100) by mxplan8.mail.ovh.net (172.16.2.41)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 19:14:54 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-100R003305ec58f-3226-4eb2-8efe-03918e07111d,
                    F9FE146EF93C85F40DBD97615D12AF9DB5AACA18) smtp.auth=postmaster@awhome.eu
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1600449293;
        bh=JZrGVAYZb3MLPYqzK8/nuxX8mc7hqOP83kVS/XX+E3I=;
        h=From:To:Cc:Subject:Date;
        b=TjR+Ty+In5pwDSvfUPucUMvL4dCiPAzYp6xb34tzRc+5gbcgn0njJCBhH5ZJt5QFq
         zirsDHVT4BcSgBacMiK2pWGqySVVeVn2knDFXf4MyhcX3Pk+ggSEqDcQnj0Yq+dVLe
         EabziExgbFkQoue7SnUUbbF2t8cBPgiugK9I/RUQ=
To:     linux-wireless@vger.kernel.org
Cc:     luciano.coelho@intel.com, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, linuxwifi@intel.com,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] iwlwifi: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
Date:   Fri, 18 Sep 2020 19:13:01 +0200
Message-ID: <20200918171301.6942-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Ovh-Tracer-GUID: d47dce7d-41d5-4682-8820-d713e4cf1746
X-Ovh-Tracer-Id: 16937756727419083939
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfgtsehtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhguvghrucghvghtiigvlhcuoegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgeqnecuggftrfgrthhtvghrnheptdeggefhjeeujeehkeehhffgheevgedvkeffffeuveetfeetjeehgfevveetfedvnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnkedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid a not needed warning and queue flush from mac80211 when deleting
PTK keys.

The flush is only needed when queued MPDUs depend on the key table
instead carrying the needed key material directly in the MPDU info.

Set NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 and flush the queues only when
needed.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c  |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  | 18 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    |  6 ------
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 423d3c396b2d..8846203526d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -201,6 +201,7 @@ int iwlagn_mac_setup_register(struct iwl_priv *priv,
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_EXT_KEY_ID);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 
 	ret = ieee80211_register_hw(priv->hw);
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9374c85c5caf..40003de28556 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -83,6 +83,9 @@
 #include "iwl-prph.h"
 #include "iwl-nvm-parse.h"
 
+static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif, u32 queues, bool drop);
+
 static const struct ieee80211_iface_limit iwl_mvm_limits[] = {
 	{
 		.max = 1,
@@ -543,6 +546,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 
 	/* The new Tx API does not allow to pass the key or keyid of a MPDU to
 	 * the hw, preventing us to control which key(id) to use per MPDU.
@@ -3540,6 +3544,20 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			break;
 		}
 
+		/* GCMP and 256 bit CCMP keys the key can't be copied into the
+		 * MPDU struct ieee80211_tx_info. We therefore must flush the
+		 * queues to ensure there are no MPDUs left which are referring
+		 * to the outgoing key.
+		 */
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
+		    (key->cipher == WLAN_CIPHER_SUITE_GCMP ||
+		     key->cipher == WLAN_CIPHER_SUITE_GCMP_256 ||
+		     key->cipher == WLAN_CIPHER_SUITE_CCMP_256)) {
+			ieee80211_stop_queues(hw);
+			iwl_mvm_mac_flush(hw, vif, 0, true);
+			ieee80211_wake_queues(hw);
+		}
+
 		if (sta && iwl_mvm_has_new_rx_api(mvm) &&
 		    key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
 		    (key->cipher == WLAN_CIPHER_SUITE_CCMP ||
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 2f6484e0d726..9e0c55b75478 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -472,12 +472,6 @@ static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 		type = TX_CMD_SEC_GCMP;
 		/* Fall through */
 	case WLAN_CIPHER_SUITE_CCMP_256:
-		/* TODO: Taking the key from the table might introduce a race
-		 * when PTK rekeying is done, having an old packets with a PN
-		 * based on the old key but the message encrypted with a new
-		 * one.
-		 * Need to handle this.
-		 */
 		tx_cmd->sec_ctl |= type | TX_CMD_SEC_KEY_FROM_TABLE;
 		tx_cmd->key[0] = keyconf->hw_key_idx;
 		iwl_mvm_set_tx_cmd_pn(info, crypto_hdr);
-- 
2.28.0

