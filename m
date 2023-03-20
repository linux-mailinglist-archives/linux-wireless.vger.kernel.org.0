Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9266C0EF9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjCTKf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCTKeS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD522386D
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308438; x=1710844438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IEn1U4/HW+NspPpKPSuiP8Eep0uBDMl+Q8mFWdBznxM=;
  b=dMl7oT+iYEMyCXubBGoEvDoQFXdg93o07igO7Cbyv8b0HLaPbMy+eiCH
   HrAMkERwo28xMhTzF9Cm9KJfRal+jcgWfSNIfZtfnT7ZFE3ujDznJqoZB
   xk87zCgbDH8qQXPQmWxrghaRH3vXhoi+1q3Sqa2cA4b/6grTWAF4BVTfi
   dA9vEygpPGHApCnAQgq8FP7IrNXETBp+S2ccqg1+4F8WsLzXdfy9E2R/+
   2q85+/5dgnpJGdaOIZEfb/cGd/sxk86rE/VLrXmm5rD7Bil+ImovH6zEe
   a2qRGFTmV4TjfHSBHjRTz026e2um04MdtvFvcD8q2DuhCCA19ZSHghil1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997895"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997895"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523658"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523658"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/18] wifi: iwlwifi: mvm: enable TX beacon protection
Date:   Mon, 20 Mar 2023 12:33:06 +0200
Message-Id: <20230320122330.6a90a4f4f469.Ia028dea75f9a8eed40786d876d51f97fb3142688@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Check hardware/firmware support and enable TX beacon protection
as well if supported, programming the key into the firmware as
usual.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 30 ++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 1c47046e8f69..f2eefca6e260 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -457,6 +457,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)105,
 	IWL_UCODE_TLV_CAPA_SYNCED_TIME			= (__force iwl_ucode_tlv_capa_t)106,
 	IWL_UCODE_TLV_CAPA_TIME_SYNC_BOTH_FTM_TM        = (__force iwl_ucode_tlv_capa_t)108,
+	IWL_UCODE_TLV_CAPA_BIGTK_TX_SUPPORT		= (__force iwl_ucode_tlv_capa_t)109,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7ee8d24606a2..99a51d519214 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -280,6 +280,8 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 #endif
+	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
+	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
 
 	/* Tell mac80211 our characteristics */
 	ieee80211_hw_set(hw, SIGNAL_DBM);
@@ -404,8 +406,13 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->pmsr_capa = &iwl_mvm_pmsr_capa;
 	}
 
-	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT))
+	if (sec_key_ver &&
+	    fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_BIGTK_TX_SUPPORT))
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_BEACON_PROTECTION);
+	else if (fw_has_capa(&mvm->fw->ucode_capa,
+			     IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT))
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT);
 
@@ -3778,7 +3785,8 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 	switch (cmd) {
 	case SET_KEY:
-		if (keyidx == 6 || keyidx == 7)
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    (keyidx == 6 || keyidx == 7))
 			rcu_assign_pointer(mvmvif->bcn_prot.keys[keyidx - 6],
 					   key);
 
@@ -3789,10 +3797,14 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			 * on IBSS they're per-station and because we're lazy
 			 * we don't support them for RX, so do the same.
 			 * CMAC/GMAC in AP/IBSS modes must be done in software.
+			 *
+			 * Except, of course, beacon protection - it must be
+			 * offloaded since we just set a beacon template.
 			 */
-			if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
-			    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-			    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256) {
+			if (keyidx < 6 &&
+			    (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+			     key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
+			     key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256)) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
@@ -3873,7 +3885,8 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		if (mvmsta && key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
 			mvmsta->pairwise_cipher = key->cipher;
 
-		IWL_DEBUG_MAC80211(mvm, "set hwcrypto key\n");
+		IWL_DEBUG_MAC80211(mvm, "set hwcrypto key (sta:%pM, id:%d)\n",
+				   sta ? sta->addr : NULL, key->keyidx);
 
 		if (sec_key_ver)
 			ret = iwl_mvm_sec_key_add(mvm, vif, sta, key);
@@ -3897,7 +3910,8 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 		break;
 	case DISABLE_KEY:
-		if (keyidx == 6 || keyidx == 7)
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    (keyidx == 6 || keyidx == 7))
 			RCU_INIT_POINTER(mvmvif->bcn_prot.keys[keyidx - 6],
 					 NULL);
 
-- 
2.38.1

