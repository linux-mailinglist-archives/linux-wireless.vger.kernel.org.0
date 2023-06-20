Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB07368C8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjFTKFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFTKFD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:05:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F32E58
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255500; x=1718791500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiExqCU0EnkmD9OHAOIhE7Kj+uFT42m/PaFItAsnMe0=;
  b=c2vZWgQL6y1mW+qCKXYcbArRtnoHN0ttbzZjuD1ieR3fjXA2nmUY9aKC
   huj8C4OvhJX9OwlVVBYp9AAW+207AfBTVxSynUbya7UycaJSJNex98SXJ
   8QFn/tJ/SaAXRqEPY4rq/zZdLyfGSj8U6apVi+/wvjDSXBYlhsEjLtS38
   G4roLpXnZTiIc2ABvM/a3CYWCByCHbo9xZhkLBmXmIKgCeXHqk3GYm9Oq
   9zfT8+o28+iVy16faqgPlPKYc/FT9vxWB5ZsLRdyJKEH8220OsBzX+DaB
   zDmWKn+4RAatGbhLT1qJ53kW4/sO3fTbD36WynG8RLDEShfmtLHnPGAKJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819666"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819666"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143587"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143587"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/19] wifi: iwlwifi: mvm: check only affected links
Date:   Tue, 20 Jun 2023 13:04:03 +0300
Message-Id: <20230620125813.c3d5a006ec21.Ib4715381f598f4c18d67cd9598ebd5cdbe7d2b09@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When hostapd starts up, it may start up with only one link
while the other is still scanning for overlapping BSSes. A
station might start to connect at this point, but we run
into this warning instead. Since there's no need to check
for _all_ links, restrict the check to just the affected
links that the STA will be using.

Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()")
Reported-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f083ebda1e83..ce7905faa08f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3836,6 +3836,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
 	int ret;
 
@@ -3877,7 +3878,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	mutex_lock(&mvm->mutex);
 
 	/* this would be a mac80211 bug ... but don't crash */
-	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		if (WARN_ON_ONCE(!mvmvif->link[link_id]->phy_ctxt)) {
 			mutex_unlock(&mvm->mutex);
 			return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-- 
2.38.1

