Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787066E42C9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDQImO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjDQImK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084B44B2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720928; x=1713256928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f2Gp2h7kn8M70T11hZPktaS9QbKRWXZwF19oTCfEfu0=;
  b=E0g+ZRRNT1c5SXpd4QUmceH4d6vnK4budZjR+DyN15QO9zfOWkLHpFC2
   6VRQpOwKGtMQzmtPs9WqVdFRUclCO/Gre3lPgAq9UCO6SsZ4kQu0J0/oW
   ct0MqkwPIyZN9D+dOtxpsTZF6vb9jvDKpoMscx7OBBoLk4oqatrq8lDr9
   lQyUoU3cPzq3wkI5UlrG1MqvZXZkW1/pH0zDW9gEm4t+xeG8gZYsjdymI
   9Ri8Vcjq+ChBkL/dd1RjIRJvOtXfWs70pN3GKCBdEloCOrBXK5PuIH1jQ
   +vTf1ed1j1Z4nsCexjw0MBE0YdyUxHpjoqV8GGGLHtbb5xMLHZUXxjzjg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634350"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634350"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173835"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173835"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: fix iwl_mvm_sta_rc_update for MLO
Date:   Mon, 17 Apr 2023 11:41:25 +0300
Message-Id: <20230417113648.fd47d0de8319.I87c5e5bcb2fadd70acc32021eed394fc1eea12a4@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
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

When this is called it might crash due to the use of
deflink's phy context, update all links instead. It
really shouldn't be called right now though, but it's
better to have safer code until we update this to be
with a link parameter.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b086229f339d..9d5d2c6625a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3585,9 +3585,9 @@ static void iwl_mvm_rs_rate_init_all_links(struct iwl_mvm *mvm,
 
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
 		struct ieee80211_bss_conf *conf =
-			link_conf_dereference_protected(vif, link_id);
+			link_conf_dereference_check(vif, link_id);
 		struct ieee80211_link_sta *link_sta =
-			link_sta_dereference_protected(sta, link_id);
+			link_sta_dereference_check(sta, link_id);
 
 		if (!conf || !link_sta || !mvmvif->link[link_id]->phy_ctxt)
 			continue;
@@ -3983,15 +3983,11 @@ void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, u32 changed)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	if (changed & (IEEE80211_RC_BW_CHANGED |
 		       IEEE80211_RC_SUPP_RATES_CHANGED |
 		       IEEE80211_RC_NSS_CHANGED))
-		iwl_mvm_rs_rate_init(mvm, sta,
-				     &vif->bss_conf, &sta->deflink,
-				     mvmvif->deflink.phy_ctxt->channel->band,
-				     true);
+		iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, true);
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    changed & IEEE80211_RC_NSS_CHANGED)
-- 
2.38.1

