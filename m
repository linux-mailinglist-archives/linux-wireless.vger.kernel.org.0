Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9994D35B327
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhDKK0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:26:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44542 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235216AbhDKK0L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:26:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVXHr-000K0H-Nq; Sun, 11 Apr 2021 13:25:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 13:25:45 +0300
Message-Id: <iwlwifi.20210411132130.f95c0cfd50f7.I15ab8fc214edc35f1f362006a9e1a22b89e7ed8e@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411102545.438654-1-luca@coelho.fi>
References: <20210411102545.438654-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 8/8] iwlwifi: mvm: add support for timing measurement
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Krishnanand Prabhu <krishnanand.prabhu@intel.com>

Add support for timing measurement in extended capabilities, used for
time synchronization.

Signed-off-by: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 39 +++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 607d5d564928..4e00f8d20788 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -297,13 +297,31 @@ static const u8 he_if_types_ext_capa_sta[] = {
 	 [9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT,
 };
 
-static const struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
+static const u8 tm_if_types_ext_capa_sta[] = {
+	 [0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	 [2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT |
+	       WLAN_EXT_CAPA3_TIMING_MEASUREMENT_SUPPORT,
+	 [7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+	 [9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT,
+};
+
+/*
+ * Additional interface types for which extended capabilities are
+ * specified separately
+ */
+static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 	{
 		.iftype = NL80211_IFTYPE_STATION,
 		.extended_capabilities = he_if_types_ext_capa_sta,
 		.extended_capabilities_mask = he_if_types_ext_capa_sta,
 		.extended_capabilities_len = sizeof(he_if_types_ext_capa_sta),
 	},
+	{
+		.iftype = NL80211_IFTYPE_STATION,
+		.extended_capabilities = tm_if_types_ext_capa_sta,
+		.extended_capabilities_mask = tm_if_types_ext_capa_sta,
+		.extended_capabilities_len = sizeof(tm_if_types_ext_capa_sta),
+	},
 };
 
 static int
@@ -646,16 +664,29 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 			NL80211_EXT_FEATURE_OCE_PROBE_REQ_HIGH_TX_RATE);
 	}
 
+	hw->wiphy->iftype_ext_capab = NULL;
+	hw->wiphy->num_iftype_ext_capab = 0;
+
 	if (mvm->nvm_data->sku_cap_11ax_enable &&
 	    !iwlwifi_mod_params.disable_11ax) {
-		hw->wiphy->iftype_ext_capab = he_iftypes_ext_capa;
-		hw->wiphy->num_iftype_ext_capab =
-			ARRAY_SIZE(he_iftypes_ext_capa);
+		hw->wiphy->iftype_ext_capab = add_iftypes_ext_capa;
+		hw->wiphy->num_iftype_ext_capab = ARRAY_SIZE(add_iftypes_ext_capa) - 1;
 
 		ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 		ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
 	}
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
+				  WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD,
+				  IWL_FW_CMD_VER_UNKNOWN) == 1) {
+		IWL_DEBUG_INFO(mvm->trans, "Timing measurement supported\n");
+
+		hw->wiphy->iftype_ext_capab = add_iftypes_ext_capa + 1;
+		if (!hw->wiphy->iftype_ext_capab)
+			hw->wiphy->num_iftype_ext_capab =
+				hw->wiphy->num_iftype_ext_capab + 1;
+	}
+
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.31.0

