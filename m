Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87872CAA9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbjFLPvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjFLPvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2C810D3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585099; x=1718121099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=guqWNB0QKB5WbTINImrnRco9EM2qDPXO02THsRhu9bo=;
  b=emTesBiIoYf1yVTH3CyuuN3KQf30xj2+Gp4bReX7gmhf+9Fm68MRQ420
   Rmwv8aGQHOpj+QPJnUTgIp5fxAQBMvKlNWEBtlnZHQY8UxqRmRZAwERkQ
   tdGOM1dS2fgupzvgwO0H/YqQZ7vpk/FZ52m47vfT67g1EPRPNyBNkMvQt
   LF/HLViItJYyOaQpl7XzpS7e7akuV8qWPniW/p2eNzASXwEtWZFLpqJ7C
   YS9lazJmfeESQUqJGZG4SEtW7cmJsGhRxIgRF8D4s6IxCqZ6p7k3GPwEg
   JGNAzkuBMf1SUcU+6sK6WrrMYSIAh4hX+A0kL7VRuUp+ndn96FROgUCJg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674193"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674193"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499281"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499281"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: FTM initiator MLO support
Date:   Mon, 12 Jun 2023 18:51:05 +0300
Message-Id: <20230612184434.1737f26e9cf7.I8f140ca55094da1d73c387fc036394fb2c148c85@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 48 ++++++++++++-------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 652a603c4500..233ae81884a0 100644
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
 
@@ -518,25 +527,30 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
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
-		if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta))) {
-			rcu_read_unlock();
-			return PTR_ERR_OR_ZERO(sta);
+			if (sta->mfp && (peer->ftm.trigger_based ||
+					 peer->ftm.non_trigger_based))
+				FTM_PUT_FLAG(PMF);
+			break;
 		}
-
-		if (sta->mfp && (peer->ftm.trigger_based || peer->ftm.non_trigger_based))
-			FTM_PUT_FLAG(PMF);
-
 		rcu_read_unlock();
-
-		target->sta_id = mvmvif->deflink.ap_sta_id;
 	} else {
 		target->sta_id = IWL_MVM_INVALID_STA;
 	}
-- 
2.38.1

