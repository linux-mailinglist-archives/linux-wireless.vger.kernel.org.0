Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423556EF0F
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfGTK0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59506 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZB-0000Hj-5H; Sat, 20 Jul 2019 13:26:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:38 +0300
Message-Id: <20190720102545.5952-10-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 09/16] iwlwifi: fix locking in delayed GTK setting
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This code clearly never could have worked, since it locks
while already locked. Add an unlocked __iwl_mvm_mac_set_key()
variant that doesn't do locking to fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 39 ++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 982682ec74fd..1c904b5226aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -207,11 +207,11 @@ static const struct cfg80211_pmsr_capabilities iwl_mvm_pmsr_capa = {
 	},
 };
 
-static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
-			       enum set_key_cmd cmd,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta,
-			       struct ieee80211_key_conf *key);
+static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
+				 enum set_key_cmd cmd,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 struct ieee80211_key_conf *key);
 
 void iwl_mvm_ref(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type)
 {
@@ -2738,7 +2738,7 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 
 		mvmvif->ap_early_keys[i] = NULL;
 
-		ret = iwl_mvm_mac_set_key(hw, SET_KEY, vif, NULL, key);
+		ret = __iwl_mvm_mac_set_key(hw, SET_KEY, vif, NULL, key);
 		if (ret)
 			goto out_quota_failed;
 	}
@@ -3506,11 +3506,11 @@ static int iwl_mvm_mac_sched_scan_stop(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
-			       enum set_key_cmd cmd,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta,
-			       struct ieee80211_key_conf *key)
+static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
+				 enum set_key_cmd cmd,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 struct ieee80211_key_conf *key)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
@@ -3565,8 +3565,6 @@ static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			return -EOPNOTSUPP;
 	}
 
-	mutex_lock(&mvm->mutex);
-
 	switch (cmd) {
 	case SET_KEY:
 		if ((vif->type == NL80211_IFTYPE_ADHOC ||
@@ -3712,7 +3710,22 @@ static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		ret = -EINVAL;
 	}
 
+	return ret;
+}
+
+static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
+			       enum set_key_cmd cmd,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct ieee80211_key_conf *key)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+	ret = __iwl_mvm_mac_set_key(hw, cmd, vif, sta, key);
 	mutex_unlock(&mvm->mutex);
+
 	return ret;
 }
 
-- 
2.20.1

