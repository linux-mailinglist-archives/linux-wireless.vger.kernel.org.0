Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06A7187D0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjEaQvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaQvg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DF9138
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551893; x=1717087893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iOXKuGdBVqiSjQNxTyyFcIQ0nRcenx2eNbwyfDSqGQs=;
  b=hdQyFZrClN2Ru3xED2d8sTiM4dHI0KuctDoHrGsTxT7kEiho1D9PjevC
   cj9X/6RCib7kOHeT5EcFN6eK5r0jq3BmEBVOOqwI56WOAzQQzs4LODf/E
   N6WhH6Kl4r5SYRKzTnpRQikh5lCDaCr68CSLlnRfyiabOP8MCsWB2AgHN
   l7Ic5bT/48K+Rj3Im1wp6BYmiLZGFnnyo2R/FAFjA1KQmyrChNdJyqxz6
   rxTmu7RSMrjdnzWpzgj53BOGJoknYIFWqqsO3b5CMP9p8oWOMPAkZo5dv
   /jO/PfJVRiji+4YGBXe3WtF249/dal75c8NZXD3r7Md7K14aHH5qczti2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890578"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987979"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987979"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: mvm: FTM initiator MLO support
Date:   Wed, 31 May 2023 19:50:01 +0300
Message-Id: <20230531194629.a0d86655e7d2.I8f140ca55094da1d73c387fc036394fb2c148c85@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When checking if the initiator is associated to the responder,
iterate over all active links.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 45 +++++++++++++------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 3963a0d4ed04..233ae81884a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -72,15 +72,24 @@ int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * the TK is already configured for this station, so it
 	 * shouldn't be set again here.
 	 */
-	if (vif->cfg.assoc &&
-	    !memcmp(addr, vif->bss_conf.bssid, ETH_ALEN)) {
+	if (vif->cfg.assoc) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		struct ieee80211_bss_conf *link_conf;
+		unsigned int link_id;
 		struct ieee80211_sta *sta;
+		u8 sta_id;
 
 		rcu_read_lock();
-		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id]);
-		if (!IS_ERR_OR_NULL(sta) && sta->mfp)
-			expected_tk_len = 0;
+		for_each_vif_active_link(vif, link_conf, link_id) {
+			if (memcmp(addr, link_conf->bssid, ETH_ALEN))
+				continue;
+
+			sta_id = mvmvif->link[link_id]->ap_sta_id;
+			sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
+			if (!IS_ERR_OR_NULL(sta) && sta->mfp)
+				expected_tk_len = 0;
+			break;
+		}
 		rcu_read_unlock();
 	}
 
@@ -518,20 +527,30 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_ftm_put_target_common(mvm, peer, target);
 
-	if (vif->cfg.assoc &&
-	    !memcmp(peer->addr, vif->bss_conf.bssid, ETH_ALEN)) {
+	if (vif->cfg.assoc) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 		struct ieee80211_sta *sta;
+		struct ieee80211_bss_conf *link_conf;
+		unsigned int link_id;
 
 		rcu_read_lock();
+		for_each_vif_active_link(vif, link_conf, link_id) {
+			if (memcmp(peer->addr, link_conf->bssid, ETH_ALEN))
+				continue;
+
+			target->sta_id = mvmvif->link[link_id]->ap_sta_id;
+			sta = rcu_dereference(mvm->fw_id_to_mac_id[target->sta_id]);
+			if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta))) {
+				rcu_read_unlock();
+				return PTR_ERR_OR_ZERO(sta);
+			}
 
-		sta = rcu_dereference(mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id]);
-		if (sta->mfp && (peer->ftm.trigger_based || peer->ftm.non_trigger_based))
-			FTM_PUT_FLAG(PMF);
-
+			if (sta->mfp && (peer->ftm.trigger_based ||
+					 peer->ftm.non_trigger_based))
+				FTM_PUT_FLAG(PMF);
+			break;
+		}
 		rcu_read_unlock();
-
-		target->sta_id = mvmvif->deflink.ap_sta_id;
 	} else {
 		target->sta_id = IWL_MVM_INVALID_STA;
 	}
-- 
2.38.1

