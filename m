Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9076CD28A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjC2HHM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC2HHI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657B2D54
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073611; x=1711609611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvkKmlVUBkpqhFkm7v+Z89cfxVBoEhTOPtl/BuFOdd4=;
  b=jBSFu4Z9OzXyt8GyrBkf+eX46pVqbfUz1ZLh4RcULnT9e28OlaAd+Dyx
   cp3Sl+gDOdbDO0a+4aYSAuw3r/XRLrp9p+rIs26+GgX6WrO+pWExdY6LX
   iw6kBkL6IF7AH4vYHmx1FSW7bhE/Cyp2IgkNlCgNiLUF2GFjqKgHvi61v
   tbaGbjgs6ULEyPW6byd3DCmj+jBFoHzRn0cOgMzlE6mTC8dtKYM3Q6CjS
   VFe/tS0QFlQrIoazChg+x72OOCI1Gdugk2QKIW6NbwiqkUDUwje/RYG8k
   /+/QL45E7H5WqQghh6YdkSIvj8PUjNkS/3Gq78rfQRtPUpaJbj7Hdkxwe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450772"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450772"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111245"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111245"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/34] wifi: iwlwifi: mvm: adjust iwl_mvm_sec_key_remove_ap to MLO
Date:   Wed, 29 Mar 2023 10:05:14 +0300
Message-Id: <20230329100039.19d729cc4654.I4ebe8e3eb5fc00a994761f7c0ad40107382705ca@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

It has to be done per link. We still don't support keys
configuration for several links, but the single vif link can
still point to a link different from deflink. For now handle
the removal of keys for the default link.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c      | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c          | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2b2221d7582b..44542b00fa14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2699,7 +2699,8 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
 				      &mvm->status)) {
 				/* first remove remaining keys */
-				iwl_mvm_sec_key_remove_ap(mvm, vif);
+				iwl_mvm_sec_key_remove_ap(mvm, vif,
+							  &mvmvif->deflink);
 
 				/*
 				 * Remove AP station now that
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index aa8b4fb9c201..44206e3e1a87 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -207,14 +207,14 @@ static void iwl_mvm_sec_key_remove_ap_iter(struct ieee80211_hw *hw,
 }
 
 void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
-			       struct ieee80211_vif *vif)
+			       struct ieee80211_vif *vif,
+			       struct iwl_mvm_vif_link_info *link)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
 	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
 
 	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION ||
-			 mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA))
+			 link->ap_sta_id == IWL_MVM_INVALID_STA))
 		return;
 
 	if (!sec_key_ver)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 7463cb8a271a..be9b2efa5ef5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -538,14 +538,13 @@ static void iwl_mvm_mld_vif_delete_all_stas(struct iwl_mvm *mvm,
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
 		return;
 
-	iwl_mvm_sec_key_remove_ap(mvm, vif);
-
 	for_each_mvm_vif_valid_link(mvmvif, i) {
 		struct iwl_mvm_vif_link_info *link = mvmvif->link[i];
 
 		if (!link)
 			continue;
 
+		iwl_mvm_sec_key_remove_ap(mvm, vif, link);
 		ret = iwl_mvm_mld_rm_sta_id(mvm, vif, link->ap_sta_id);
 		if (ret)
 			IWL_ERR(mvm, "failed to remove AP station\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index dfe1aff10548..6421edd53404 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2326,7 +2326,8 @@ int iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 			struct ieee80211_sta *sta,
 			struct ieee80211_key_conf *keyconf);
 void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
-			       struct ieee80211_vif *vif);
+			       struct ieee80211_vif *vif,
+			       struct iwl_mvm_vif_link_info *link);
 
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
 			    struct iwl_rfi_lut_entry *rfi_table);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index eb57acaef96a..f9f512a85ef1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2022,7 +2022,7 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			return true;
 
 		/* first remove remaining keys */
-		iwl_mvm_sec_key_remove_ap(mvm, vif);
+		iwl_mvm_sec_key_remove_ap(mvm, vif, &mvmvif->deflink);
 
 		/* unassoc - go ahead - remove the AP STA now */
 		mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
-- 
2.38.1

