Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2B6CD295
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC2HID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjC2HIC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30013AB9
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073660; x=1711609660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0hfbqrct4a7ne7TEeTA9t/ef6xqr+O8ClV+eZSS5LBI=;
  b=mtw0Z/++tbAVJnSTrBZgLkE07C70n23aagwxFCWD0y7H5KYOI+V/bUk0
   VdUZKgXiG0FFUzGvjY76lgdDPmLAa01+e4xisgQoZv+sGjtekiYgkRL4c
   oZptsYyF2MOZPWwICDKfo8I9KNPiVp8BpUpZ+fQ3uf5AVe5vlL2YdrvoA
   g7FJPLuxW/2A7+OIPPVx3Yckdr/aaWcBTcUF4aBJZWNDvJp3c9ELXCQ6G
   iuB6I5EGWyFxlCS3/PueYLO4gRNF40w4MgGydmcfLpwqbzyQLT/PDNQ6J
   G+QuLbOxrAjPvGVBZLTVwjFgToCkzLSj7v+4Kr0AvuZKAYLpwq3MwFma5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450852"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450852"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111345"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111345"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/34] wifi: iwlwifi: mvm: remove only link-specific AP keys
Date:   Wed, 29 Mar 2023 10:05:24 +0300
Message-Id: <20230329100039.e724878f502e.I66870d4629244b4b309be79e11cbbd384bdf93be@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

When we remove the AP station, we iterate over the links
and remove all the keys, however, the key iteration will
return all keys for all links, so skip the ones that we
don't need based on the link ID.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c      | 9 +++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c          | 2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1fd7e5bf594d..98c940271648 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2722,7 +2722,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 				      &mvm->status)) {
 				/* first remove remaining keys */
 				iwl_mvm_sec_key_remove_ap(mvm, vif,
-							  &mvmvif->deflink);
+							  &mvmvif->deflink, 0);
 
 				/*
 				 * Remove AP station now that
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 44206e3e1a87..f4785c0a0b84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -195,6 +195,7 @@ static void iwl_mvm_sec_key_remove_ap_iter(struct ieee80211_hw *hw,
 					   void *data)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	unsigned int link_id = (uintptr_t)data;
 
 	if (key->hw_key_idx == STA_KEY_IDX_INVALID)
 		return;
@@ -202,13 +203,17 @@ static void iwl_mvm_sec_key_remove_ap_iter(struct ieee80211_hw *hw,
 	if (sta)
 		return;
 
+	if (key->link_id >= 0 && key->link_id != link_id)
+		return;
+
 	_iwl_mvm_sec_key_del(mvm, vif, NULL, key, CMD_ASYNC);
 	key->hw_key_idx = STA_KEY_IDX_INVALID;
 }
 
 void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
-			       struct iwl_mvm_vif_link_info *link)
+			       struct iwl_mvm_vif_link_info *link,
+			       unsigned int link_id)
 {
 	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
 	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
@@ -222,5 +227,5 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 
 	ieee80211_iter_keys_rcu(mvm->hw, vif,
 				iwl_mvm_sec_key_remove_ap_iter,
-				NULL);
+				(void *)(uintptr_t)link_id);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index e475d0daf512..1a97bf925817 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -544,7 +544,7 @@ static void iwl_mvm_mld_vif_delete_all_stas(struct iwl_mvm *mvm,
 		if (!link)
 			continue;
 
-		iwl_mvm_sec_key_remove_ap(mvm, vif, link);
+		iwl_mvm_sec_key_remove_ap(mvm, vif, link, i);
 		ret = iwl_mvm_mld_rm_sta_id(mvm, vif, link->ap_sta_id);
 		if (ret)
 			IWL_ERR(mvm, "failed to remove AP station\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a7a7018edd2b..23d797247915 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2328,7 +2328,8 @@ int iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 			struct ieee80211_key_conf *keyconf);
 void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
-			       struct iwl_mvm_vif_link_info *link);
+			       struct iwl_mvm_vif_link_info *link,
+			       unsigned int link_id);
 
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
 			    struct iwl_rfi_lut_entry *rfi_table);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index f9f512a85ef1..9a3a7eabded8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2022,7 +2022,7 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			return true;
 
 		/* first remove remaining keys */
-		iwl_mvm_sec_key_remove_ap(mvm, vif, &mvmvif->deflink);
+		iwl_mvm_sec_key_remove_ap(mvm, vif, &mvmvif->deflink, 0);
 
 		/* unassoc - go ahead - remove the AP STA now */
 		mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
-- 
2.38.1

