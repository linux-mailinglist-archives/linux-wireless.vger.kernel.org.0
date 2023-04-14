Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A96E207F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDNKOm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNKOm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:14:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF329EE3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467244; x=1713003244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rnh/09B8REPWfJf13TAcZgaqxybHk47gXo8zBfx3v0=;
  b=cFUrvFTQ/R7Oku0NOC+cADm6y63LdKR9gFgujHwyL+Lf9z406A8OdDel
   HlGhuKbMDub0VJkA0nihOSPOvjwfF//y91ApiKH8fzIsZ6RE5NdOIvVLu
   zyZZVAmNar08SR8pRfkpdFlRY6ysjPL4q+6yP6pZfhS9nstuGxz4DnFCU
   9p7CjmRzS1ezFnysQNDKFtbp+8/ldzDNmzHQWJ6o+ZnmXk71qN3Wn6cri
   ZKV9CVj1xJjystJujmsY8mv+//e6H3jkaXsnAdJt7hf7IKiFFgzEyHuum
   /Y9BCYkWCh+ZK0WZq6ZJsFIM/Z7H7mcGhYkjRRKI1fQ9VYKW/dDSyLxDw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263636"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263636"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351766"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351766"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: track AP STA pointer and use it for MFP
Date:   Fri, 14 Apr 2023 13:12:00 +0300
Message-Id: <20230414130637.7db01b1508de.I88e6d252cdb0a6e4581d7c5fd7cbc037b4fd40ae@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Instead of relying on the AP STA ID and dereferencing our
firmware -> mac80211 STA array when we really only need
the STA, not the per-link information (and might not have
it, e.g. for a pairwise key installation where this is
relevant), keep track of the AP STA as a pointer to the
mac80211 STA, protected by the mutex. Then use it here in
the key code instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  8 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c  | 13 ++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  2 ++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d6f29aa2a66f..1670c2cef4c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3669,6 +3669,7 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 				   struct ieee80211_sta *sta,
 				   struct iwl_mvm_sta_state_ops *callbacks)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	unsigned int i;
 	int ret;
 
@@ -3704,6 +3705,9 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 	}
 	ieee80211_sta_recalc_aggregates(sta);
 
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		mvmvif->ap_sta = sta;
+
 	return 0;
 }
 
@@ -3931,8 +3935,10 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_NONE &&
 		   new_state == IEEE80211_STA_NOTEXIST) {
-		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 			iwl_mvm_stop_session_protection(mvm, vif);
+			mvmvif->ap_sta = NULL;
+		}
 		ret = callbacks->rm_sta(mvm, vif, sta);
 		if (sta->tdls) {
 			iwl_mvm_recalc_tdls_state(mvm, vif, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index f4785c0a0b84..9ec1c505002f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -41,6 +41,8 @@ static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u32 flags = 0;
 
+	lockdep_assert_held(&mvm->mutex);
+
 	if (!(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		flags |= IWL_SEC_KEY_FLAG_MCAST_KEY;
 
@@ -68,18 +70,11 @@ static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 		break;
 	}
 
-	rcu_read_lock();
-	if (!sta && vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
-		u8 sta_id = mvmvif->deflink.ap_sta_id;
-
-		sta = rcu_dereference_check(mvm->fw_id_to_mac_id[sta_id],
-					    lockdep_is_held(&mvm->mutex));
-	}
+	if (!sta && vif->type == NL80211_IFTYPE_STATION)
+		sta = mvmvif->ap_sta;
 
 	if (!IS_ERR_OR_NULL(sta) && sta->mfp)
 		flags |= IWL_SEC_KEY_FLAG_MFP;
-	rcu_read_unlock();
 
 	return flags;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 42e67df13a1e..f435260af519 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -434,6 +434,8 @@ struct iwl_mvm_vif {
 	/* TCP Checksum Offload */
 	netdev_features_t features;
 
+	struct ieee80211_sta *ap_sta;
+
 	/* we can only have 2 GTK + 2 IGTK active at a time */
 	struct ieee80211_key_conf *ap_early_keys[4];
 
-- 
2.38.1

