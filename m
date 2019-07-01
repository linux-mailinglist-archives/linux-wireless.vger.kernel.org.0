Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B94BFF8
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfFSRmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 13:42:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54514 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727076AbfFSRmJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 13:42:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hdeb1-0002zq-M9; Wed, 19 Jun 2019 20:42:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 1/6] iwlwifi: mvm: delay GTK setting in FW in AP mode
Date:   Wed, 19 Jun 2019 20:41:54 +0300
Message-Id: <20190619174159.13927-2-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619174159.13927-1-luca@coelho.fi>
References: <20190619174159.13927-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In AP (and IBSS) mode, we can only set GTKs to firmware after we have
sent down the multicast station, but this we can only do after we've
enabled beaconing, etc.

However, during rfkill exit, hostapd will configure the keys before
starting the AP, and cfg80211/mac80211 accept it happily.

On earlier devices, this didn't bother us as GTK TX wasn't really
handled in firmware, we just put the key material into the TX cmd
and thus it only mattered when we actually transmitted a frame.

On newer devices, however, the firmware needs to track all of this
and that doesn't work if we add the key before the (multicast) sta
it belongs to.

To fix this, keep a list of keys to add during AP enable, and call
the function there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 53 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fdbabca0280e..964c7baabede 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -207,6 +207,12 @@ static const struct cfg80211_pmsr_capabilities iwl_mvm_pmsr_capa = {
 	},
 };
 
+static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
+			       enum set_key_cmd cmd,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct ieee80211_key_conf *key);
+
 void iwl_mvm_ref(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type)
 {
 	if (!iwl_mvm_is_d0i3_supported(mvm))
@@ -2636,7 +2642,7 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret;
+	int ret, i;
 
 	/*
 	 * iwl_mvm_mac_ctxt_add() might read directly from the device
@@ -2710,6 +2716,20 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	/* must be set before quota calculations */
 	mvmvif->ap_ibss_active = true;
 
+	/* send all the early keys to the device now */
+	for (i = 0; i < ARRAY_SIZE(mvmvif->ap_early_keys); i++) {
+		struct ieee80211_key_conf *key = mvmvif->ap_early_keys[i];
+
+		if (!key)
+			continue;
+
+		mvmvif->ap_early_keys[i] = NULL;
+
+		ret = iwl_mvm_mac_set_key(hw, SET_KEY, vif, NULL, key);
+		if (ret)
+			goto out_quota_failed;
+	}
+
 	if (vif->type == NL80211_IFTYPE_AP && !vif->p2p) {
 		iwl_mvm_vif_set_low_latency(mvmvif, true,
 					    LOW_LATENCY_VIF_TYPE);
@@ -3479,11 +3499,12 @@ static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			       struct ieee80211_sta *sta,
 			       struct ieee80211_key_conf *key)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_key_pn *ptk_pn;
 	int keyidx = key->keyidx;
-	int ret;
+	int ret, i;
 	u8 key_offset;
 
 	if (iwlwifi_mod_params.swcrypto) {
@@ -3556,6 +3577,22 @@ static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 				key->hw_key_idx = STA_KEY_IDX_INVALID;
 				break;
 			}
+
+			if (!mvmvif->ap_ibss_active) {
+				for (i = 0;
+				     i < ARRAY_SIZE(mvmvif->ap_early_keys);
+				     i++) {
+					if (!mvmvif->ap_early_keys[i]) {
+						mvmvif->ap_early_keys[i] = key;
+						break;
+					}
+				}
+
+				if (i >= ARRAY_SIZE(mvmvif->ap_early_keys))
+					ret = -ENOSPC;
+
+				break;
+			}
 		}
 
 		/* During FW restart, in order to restore the state as it was,
@@ -3624,6 +3661,18 @@ static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 		break;
 	case DISABLE_KEY:
+		ret = -ENOENT;
+		for (i = 0; i < ARRAY_SIZE(mvmvif->ap_early_keys); i++) {
+			if (mvmvif->ap_early_keys[i] == key) {
+				mvmvif->ap_early_keys[i] = NULL;
+				ret = 0;
+			}
+		}
+
+		/* found in pending list - don't do anything else */
+		if (ret == 0)
+			break;
+
 		if (key->hw_key_idx == STA_KEY_IDX_INVALID) {
 			ret = 0;
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 02efcf2189c4..88af1f0ba3f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -501,6 +501,9 @@ struct iwl_mvm_vif {
 	netdev_features_t features;
 
 	struct iwl_probe_resp_data __rcu *probe_resp_data;
+
+	/* we can only have 2 GTK + 2 IGTK active at a time */
+	struct ieee80211_key_conf *ap_early_keys[4];
 };
 
 static inline struct iwl_mvm_vif *
-- 
2.20.1

