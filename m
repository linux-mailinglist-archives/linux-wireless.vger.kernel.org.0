Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDB66CD29A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC2HI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjC2HIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89C740C6
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073686; x=1711609686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=htegX3XBza4BoIo5lkXcbsyCqkq9DR9uFUAc2lc+hAw=;
  b=ng3vaba6fGARTQ9KZSL4HAxsXgzNfy4fizcCSoYTDFOu1PDjoKAuC5ff
   NUKlYmYOoEHRMr7+Tz9hgZC11mPcBoE5ekzWt7ED8S3NxENkjzJS2cinB
   yYfpKQxMMFFSchXoYI5/Kn0FiMthDAoCxBXNLenRbOFaZAEOMs+3S2Ne3
   vd1HPgCTe59Fr3g2C1YNI0GkJBCuGk8XZZOvl4Fss5V4TrR1bZtUYENup
   PRoNIniXfAXELpPfomcLzKs866iPTpm4WTELpPg00QPWIRabJIYmaTloj
   D48KLAYqJeI4V3L6l/NWBlnfXqheI813zDNp1YangexKYLHsl0pOvnwGy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450932"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111404"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111404"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 24/34] wifi: iwlwifi: mvm: fix station link data leak
Date:   Wed, 29 Mar 2023 10:05:30 +0300
Message-Id: <20230329100039.1d81d4c71f35.I8fc60ac28ffc1147e9b1250e5e6237b3cb5516ac@changeid>
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

When we remove the station, we call iwl_mvm_sta_del() which
returns true if we cannot remove it from the firmware yet,
which happens if this is the station ID for the AP station
that's still used because the MAC is still associated.

However, we still must free the link data as the station is
only kept alive in the firmware, in mac80211 and driver the
data structures are destroyed.

To fix that, we need to make iwl_mvm_mld_free_sta_link()
track whether or not the station is still alive in FW, as
otherwise we might reuse the station ID in the meantime and
iwl_mvm_mld_rm_sta_from_fw() would reject the later delete
from the firmware. Add an argument to it for that. Then we
can use the return value of iwl_mvm_sta_del() for that to
fix the issue, and call iwl_mvm_mld_rm_sta_from_fw() only
if we need to not keep the station in FW.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 59 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +-
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index ddc09012549b..beef706d0598 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -545,7 +545,7 @@ static void iwl_mvm_mld_vif_delete_all_stas(struct iwl_mvm *mvm,
 			continue;
 
 		iwl_mvm_sec_key_remove_ap(mvm, vif, link, i);
-		ret = iwl_mvm_mld_rm_sta_id(mvm, vif, link->ap_sta_id);
+		ret = iwl_mvm_mld_rm_sta_id(mvm, link->ap_sta_id);
 		if (ret)
 			IWL_ERR(mvm, "failed to remove AP station\n");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 5e382981bfa2..b3377b4d7924 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -458,6 +458,21 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	return iwl_mvm_mld_send_sta_cmd(mvm, &cmd);
 }
 
+static void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
+				      struct iwl_mvm_sta *mvm_sta,
+				      struct iwl_mvm_link_sta *mvm_sta_link,
+				      unsigned int link_id,
+				      bool is_in_fw)
+{
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id],
+			 is_in_fw ? ERR_PTR(-EINVAL) : NULL);
+	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[mvm_sta_link->sta_id], NULL);
+	RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
+
+	if (mvm_sta_link != &mvm_sta->deflink)
+		kfree_rcu(mvm_sta_link, rcu_head);
+}
+
 static void iwl_mvm_mld_sta_rm_all_sta_links(struct iwl_mvm *mvm,
 					     struct iwl_mvm_sta *mvm_sta)
 {
@@ -471,28 +486,10 @@ static void iwl_mvm_mld_sta_rm_all_sta_links(struct iwl_mvm *mvm,
 		if (!link)
 			continue;
 
-		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[link->sta_id], NULL);
-		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[link->sta_id], NULL);
-		RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
-
-		if (link != &mvm_sta->deflink)
-			kfree_rcu(link, rcu_head);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, link, link_id, false);
 	}
 }
 
-static void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
-				      struct iwl_mvm_sta *mvm_sta,
-				      struct iwl_mvm_link_sta *mvm_sta_link,
-				      unsigned int link_id)
-{
-	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id], NULL);
-	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[mvm_sta_link->sta_id], NULL);
-	RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
-
-	if (mvm_sta_link != &mvm_sta->deflink)
-		kfree_rcu(mvm_sta_link, rcu_head);
-}
-
 static int iwl_mvm_mld_alloc_sta_link(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -787,20 +784,24 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		struct iwl_mvm_link_sta *mvm_link_sta =
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
+		bool stay_in_fw;
 
-		if (iwl_mvm_sta_del(mvm, vif, sta, mvm_link_sta, &ret))
-			return ret;
+		stay_in_fw = iwl_mvm_sta_del(mvm, vif, sta, mvm_link_sta, &ret);
+		if (ret)
+			break;
 
-		ret = iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_link_sta->sta_id);
-	}
+		if (!stay_in_fw)
+			ret = iwl_mvm_mld_rm_sta_from_fw(mvm,
+							 mvm_link_sta->sta_id);
 
-	iwl_mvm_mld_sta_rm_all_sta_links(mvm, mvm_sta);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta,
+					  link_id, stay_in_fw);
+	}
 
 	return ret;
 }
 
-int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			  u8 sta_id)
+int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id)
 {
 	int ret = iwl_mvm_mld_rm_sta_from_fw(mvm, sta_id);
 
@@ -978,7 +979,8 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 		if (vif->type == NL80211_IFTYPE_STATION)
 			mvm_vif_link->ap_sta_id = IWL_MVM_INVALID_STA;
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id,
+					  false);
 	}
 
 	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
@@ -1054,7 +1056,8 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
 
-		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id);
+		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id,
+					  false);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 2402b41bc0bb..824d12047019 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -639,8 +639,7 @@ int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
-int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			  u8 sta_id);
+int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id);
 int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
-- 
2.38.1

