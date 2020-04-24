Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7571B7A81
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgDXPsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57916 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbgDXPsf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z6-000OY2-Ru; Fri, 24 Apr 2020 18:48:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:13 +0300
Message-Id: <iwlwifi.20200424182644.674a325b008b.Ifc925ca84500fb76c7b6f926a24a34ca777b4192@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: mvm: stop supporting swcrypto and bt_coex_active module parameters
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Leave them active for iwldvm. We do not test this configuration
and there is no reason nowadays to allow this.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  7 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 31 ++++++--------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 42 ++++++++-----------
 3 files changed, 33 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 3d2abbc5c76c..5ae22cd7ecdb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2013 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  *
  * This program is free software; you can redistribute it and/or modify
@@ -26,7 +26,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2013 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * All rights reserved.
  *
@@ -216,8 +216,7 @@ int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm)
 		goto send_cmd;
 	}
 
-	mode = iwlwifi_mod_params.bt_coex_active ? BT_COEX_NW : BT_COEX_DISABLE;
-	bt_cmd.mode = cpu_to_le32(mode);
+	bt_cmd.mode = cpu_to_le32(BT_COEX_NW);
 
 	if (IWL_MVM_BT_COEX_SYNC2SCO)
 		bt_cmd.enabled_modules |=
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 222775714859..89096bcb053e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -80,9 +78,6 @@ void iwl_mvm_set_rekey_data(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (iwlwifi_mod_params.swcrypto)
-		return;
-
 	mutex_lock(&mvm->mutex);
 
 	memcpy(mvmvif->rekey_data.kek, data->kek, NL80211_KEK_LEN);
@@ -843,18 +838,16 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 			return ret;
 	}
 
-	if (!iwlwifi_mod_params.swcrypto) {
-		/*
-		 * This needs to be unlocked due to lock ordering
-		 * constraints. Since we're in the suspend path
-		 * that isn't really a problem though.
-		 */
-		mutex_unlock(&mvm->mutex);
-		ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
-		mutex_lock(&mvm->mutex);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * This needs to be unlocked due to lock ordering
+	 * constraints. Since we're in the suspend path
+	 * that isn't really a problem though.
+	 */
+	mutex_unlock(&mvm->mutex);
+	ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
+	mutex_lock(&mvm->mutex);
+	if (ret)
+		return ret;
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, 0,
 				   sizeof(*wowlan_config_cmd),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 853ba7b8bf3f..ee3d2ff432f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -475,23 +475,23 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->n_cipher_suites++;
 	}
 
-	/* Enable 11w if software crypto is not enabled (as the
-	 * firmware will interpret some mgmt packets, so enabling it
-	 * with software crypto isn't safe).
-	 */
-	if (!iwlwifi_mod_params.swcrypto) {
-		ieee80211_hw_set(hw, MFP_CAPABLE);
+	if (iwlwifi_mod_params.swcrypto)
+		IWL_ERR(mvm,
+			"iwlmvm doesn't allow to disable HW crypto, check swcrypto module parameter\n");
+	if (!iwlwifi_mod_params.bt_coex_active)
+		IWL_ERR(mvm,
+			"iwlmvm doesn't allow to disable BT Coex, check bt_coex_active module parameter\n");
+
+	ieee80211_hw_set(hw, MFP_CAPABLE);
+	mvm->ciphers[hw->wiphy->n_cipher_suites] = WLAN_CIPHER_SUITE_AES_CMAC;
+	hw->wiphy->n_cipher_suites++;
+	if (iwl_mvm_has_new_rx_api(mvm)) {
 		mvm->ciphers[hw->wiphy->n_cipher_suites] =
-			WLAN_CIPHER_SUITE_AES_CMAC;
+			WLAN_CIPHER_SUITE_BIP_GMAC_128;
+		hw->wiphy->n_cipher_suites++;
+		mvm->ciphers[hw->wiphy->n_cipher_suites] =
+			WLAN_CIPHER_SUITE_BIP_GMAC_256;
 		hw->wiphy->n_cipher_suites++;
-		if (iwl_mvm_has_new_rx_api(mvm)) {
-			mvm->ciphers[hw->wiphy->n_cipher_suites] =
-				WLAN_CIPHER_SUITE_BIP_GMAC_128;
-			hw->wiphy->n_cipher_suites++;
-			mvm->ciphers[hw->wiphy->n_cipher_suites] =
-				WLAN_CIPHER_SUITE_BIP_GMAC_256;
-			hw->wiphy->n_cipher_suites++;
-		}
 	}
 
 	/* currently FW API supports only one optional cipher scheme */
@@ -697,10 +697,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 				     WIPHY_WOWLAN_EAP_IDENTITY_REQ |
 				     WIPHY_WOWLAN_RFKILL_RELEASE |
 				     WIPHY_WOWLAN_NET_DETECT;
-		if (!iwlwifi_mod_params.swcrypto)
-			mvm->wowlan.flags |= WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
-					     WIPHY_WOWLAN_GTK_REKEY_FAILURE |
-					     WIPHY_WOWLAN_4WAY_HANDSHAKE;
+		mvm->wowlan.flags |= WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
+				     WIPHY_WOWLAN_GTK_REKEY_FAILURE |
+				     WIPHY_WOWLAN_4WAY_HANDSHAKE;
 
 		mvm->wowlan.n_patterns = IWL_WOWLAN_MAX_PATTERNS;
 		mvm->wowlan.pattern_min_len = IWL_WOWLAN_MIN_PATTERN_LEN;
@@ -3366,11 +3365,6 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	int ret, i;
 	u8 key_offset;
 
-	if (iwlwifi_mod_params.swcrypto) {
-		IWL_DEBUG_MAC80211(mvm, "leave - hwcrypto disabled\n");
-		return -EOPNOTSUPP;
-	}
-
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
 		if (!mvm->trans->trans_cfg->gen2) {
-- 
2.26.2

