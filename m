Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE17F6CB8F8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjC1IAo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjC1IA2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1AF4694
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990427; x=1711526427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bAhVYpaCjq+neqi2241Kn6tTt9XAFWaAIdetdJhi58w=;
  b=a3Cl0I/Ck1wdfpMdbEQ9Ta//Cui6qDDVOt7WlT7Rj2Y3rZICQGuBR7Ug
   ggkBY5zgmcXGd/SexEyCdgboKINQeKmDPtOPXlp6/NRVvWt+LF0EegHd6
   vjKKW3ENSkCFWinAgkA6369x8tHDDeDlKKrfb6NLwvG9NAV5Kb3CAho7Z
   4Lt8RZVzEfHk6mOJuGDwEHXkqKtxeuRXvpfQz7swPFGsAsaxSaN0HwV+w
   VnqUeQ053fEHLazwwEu/lfnCvwtQyKapBAO1WoYMwDwyRVrQkpjUiETVR
   f/zbzyDBE8XISqRMWpOBCcsrHUV0orRd9lVe285ooqZcc09AoMHuyQvhG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958317"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045357"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045357"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 30/31] wifi: iwlwifi: mvm: adjust some cleanup functions to MLO
Date:   Tue, 28 Mar 2023 10:59:10 +0300
Message-Id: <20230328104949.948a7bee8b09.Ic6b202959c158258d391ccce77f66e1281879690@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Clean up data for all allocated links of a vif.
Invalidate all link sta pointers.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f778ac69c671..9e825e3cf630 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -983,18 +983,23 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 {
 	struct iwl_mvm *mvm = data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int link_id;
 
 	mvmvif->uploaded = false;
-	mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
 
 	spin_lock_bh(&mvm->time_event_lock);
 	iwl_mvm_te_clear_data(mvm, &mvmvif->time_event_data);
 	spin_unlock_bh(&mvm->time_event_lock);
 
-	mvmvif->deflink.phy_ctxt = NULL;
 	memset(&mvmvif->bf_data, 0, sizeof(mvmvif->bf_data));
-	memset(&mvmvif->deflink.probe_resp_data, 0,
-	       sizeof(mvmvif->deflink.probe_resp_data));
+
+	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+		mvmvif->link[link_id]->ap_sta_id = IWL_MVM_INVALID_STA;
+		mvmvif->link[link_id]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
+		mvmvif->link[link_id]->phy_ctxt = NULL;
+		memset(&mvmvif->link[link_id]->probe_resp_data, 0,
+		       sizeof(mvmvif->link[link_id]->probe_resp_data));
+	}
 }
 
 static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
@@ -3251,6 +3256,7 @@ void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	unsigned int link_id;
 
 	/*
 	 * This is called before mac80211 does RCU synchronisation,
@@ -3259,12 +3265,24 @@ void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 	 * be able to find the station this way, and we don't rely
 	 * on further RCU synchronisation after the sta_state()
 	 * callback deleted the station.
+	 * Since there's mvm->mutex here, no need to have RCU lock for
+	 * mvm_sta->link access.
 	 */
 	mutex_lock(&mvm->mutex);
-	if (sta == rcu_access_pointer(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id]))
-		rcu_assign_pointer(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id],
-				   ERR_PTR(-ENOENT));
+	for (link_id = 0; link_id < ARRAY_SIZE(mvm_sta->link); link_id++) {
+		struct iwl_mvm_link_sta *link_sta;
+		u32 sta_id;
+
+		if (!mvm_sta->link[link_id])
+			continue;
 
+		link_sta = rcu_dereference_protected(mvm_sta->link[link_id],
+						     lockdep_is_held(&mvm->mutex));
+		sta_id = link_sta->sta_id;
+		if (sta == rcu_access_pointer(mvm->fw_id_to_mac_id[sta_id]))
+			rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id],
+					   ERR_PTR(-ENOENT));
+	}
 	mutex_unlock(&mvm->mutex);
 }
 
-- 
2.38.1

