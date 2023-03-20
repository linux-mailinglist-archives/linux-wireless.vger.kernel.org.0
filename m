Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20F56C0EF1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCTKed (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCTKeF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09B7D307
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308430; x=1710844430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTJLABXqc+14Br9OSI4mmyZu2vAYTaqBqfpt5/Rf1qc=;
  b=hWpflk7vLQRrSIDcWTqexb8Lhl5FZAWIa8i7ks3kZamjo8VirmiG8ifx
   zTkdkuxp0kJbQQv6AQg0m3SJ8M5hBz4vZG6RmbVIf+Wv/EmDGgW9BSLuX
   o3s/bmO8G4AtYdSRp6rAH75IMEIgr7P9sY1+b0arCDDybFLRWZJTr8ioA
   Dnr5nN24XAGgkigsYNq0OS6M6YFOO2i49+zn2tsSBnm2AUl+i1nSk7cYn
   TkVA1EXS8+fyhNmHgIQrawI1Qw5xEohBzYrDdWiHyBEMzZJW5/MFW2hoG
   NWy6uv42Ac0XxfUPpRVHP9xwFVnIFnBWvttijr9on2MoC/DG3oDJaKtAK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997892"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997892"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523655"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523655"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/18] wifi: iwlwifi: mvm: add support for timing measurement
Date:   Mon, 20 Mar 2023 12:33:05 +0200
Message-Id: <20230320122330.001d2b459ece.I15ab8fc214edc35f1f362006a9e1a22b89e7ed8e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Krishnanand Prabhu <krishnanand.prabhu@intel.com>

Add support for timing measurement in extended capabilities, used for
time synchronization.

Signed-off-by: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 93ca92e8eb98..7ee8d24606a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -222,19 +222,39 @@ int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm)
 	return ret;
 }
 
+/* Each capability added here should also be add to tm_if_types_ext_capa_sta */
 static const u8 he_if_types_ext_capa_sta[] = {
 	 [0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
 	 [2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	 [7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
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
+/* Additional interface types for which extended capabilities are
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
+		/* relevant only if EHT is supported */
+		.eml_capabilities = IEEE80211_EML_CAP_EMLSR_SUPP,
+	},
 };
 
 static int
@@ -562,16 +582,34 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 					      NL80211_EXT_FEATURE_OCE_PROBE_REQ_DEFERRAL_SUPPRESSION);
 	}
 
+	hw->wiphy->iftype_ext_capab = NULL;
+	hw->wiphy->num_iftype_ext_capab = 0;
+
 	if (mvm->nvm_data->sku_cap_11ax_enable &&
 	    !iwlwifi_mod_params.disable_11ax) {
-		hw->wiphy->iftype_ext_capab = he_iftypes_ext_capa;
+		hw->wiphy->iftype_ext_capab = add_iftypes_ext_capa;
 		hw->wiphy->num_iftype_ext_capab =
-			ARRAY_SIZE(he_iftypes_ext_capa);
+			ARRAY_SIZE(add_iftypes_ext_capa) - 1;
 
 		ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 		ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
 	}
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw,
+				  WIDE_ID(DATA_PATH_GROUP,
+					  WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD),
+				  IWL_FW_CMD_VER_UNKNOWN) >= 1) {
+		IWL_DEBUG_INFO(mvm->trans, "Timing measurement supported\n");
+
+		if (!hw->wiphy->iftype_ext_capab) {
+			hw->wiphy->num_iftype_ext_capab = 1;
+			hw->wiphy->iftype_ext_capab = add_iftypes_ext_capa +
+				ARRAY_SIZE(add_iftypes_ext_capa) - 1;
+		} else {
+			hw->wiphy->iftype_ext_capab = add_iftypes_ext_capa + 1;
+		}
+	}
+
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.38.1

