Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D546FD7F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbhLJJQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50920 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239127AbhLJJQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:34 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxZ-001FED-NE; Fri, 10 Dec 2021 11:12:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:43 +0200
Message-Id: <iwlwifi.20211210110539.3dd63c381839.Id79b39f650103bb9b851e31ed6a0178e81988587@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210091245.289008-1-luca@coelho.fi>
References: <20211210091245.289008-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/10] iwlwifi: mvm: add support for OCE scan
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

In case the fw supports OCE scan and one of the OCE feature flags
are set in the scan request, set the corresponding flag in the
firmware scan request.
Note that new firmware that indicates OCE support does not support
the probe deferral and suppression feature (which is optional).

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h  |  5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 +++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c     |  6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 9aa7d0bbd64e..175e2ce3c82a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -640,6 +640,10 @@ enum iwl_umac_scan_general_flags2 {
  * @IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN_FILTER_IN: in case
  *      &IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN is enabled and scan is
  *      activated over 6GHz PSC channels, filter in beacons and probe responses.
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_OCE: if set, send probe requests in a minimum
+ *      rate of 5.5Mpbs, filter in broadcast probe responses and set the max
+ *      channel time indication field in the FILS request parameters element
+ *      (if included by the driver in the probe request IEs).
  */
 enum iwl_umac_scan_general_flags_v2 {
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC             = BIT(0),
@@ -657,6 +661,7 @@ enum iwl_umac_scan_general_flags_v2 {
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN     = BIT(12),
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN    = BIT(13),
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN_FILTER_IN = BIT(14),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_OCE                  = BIT(15),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 08177e9b5d6b..d1ab166b6e91 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -641,14 +641,21 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	}
 
 	if (iwl_mvm_is_oce_supported(mvm)) {
+		u8 scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+						    IWL_ALWAYS_LONG_GROUP,
+						    SCAN_REQ_UMAC, 0);
+
 		wiphy_ext_feature_set(hw->wiphy,
 			NL80211_EXT_FEATURE_ACCEPT_BCAST_PROBE_RESP);
 		wiphy_ext_feature_set(hw->wiphy,
 			NL80211_EXT_FEATURE_FILS_MAX_CHANNEL_TIME);
-		wiphy_ext_feature_set(hw->wiphy,
-			NL80211_EXT_FEATURE_OCE_PROBE_REQ_DEFERRAL_SUPPRESSION);
 		wiphy_ext_feature_set(hw->wiphy,
 			NL80211_EXT_FEATURE_OCE_PROBE_REQ_HIGH_TX_RATE);
+
+		/* Old firmware also supports probe deferral and suppression */
+		if (scan_ver < 15)
+			wiphy_ext_feature_set(hw->wiphy,
+					      NL80211_EXT_FEATURE_OCE_PROBE_REQ_DEFERRAL_SUPPRESSION);
 	}
 
 	if (mvm->nvm_data->sku_cap_11ax_enable &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 693afd78bc66..b401ab6d46a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2037,6 +2037,12 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 	if (params->enable_6ghz_passive)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN;
 
+	if (iwl_mvm_is_oce_supported(mvm) &&
+	    (params->flags & (NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP |
+			      NL80211_SCAN_FLAG_OCE_PROBE_REQ_HIGH_TX_RATE |
+			      NL80211_SCAN_FLAG_FILS_MAX_CHANNEL_TIME)))
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_OCE;
+
 	return flags;
 }
 
-- 
2.34.1

