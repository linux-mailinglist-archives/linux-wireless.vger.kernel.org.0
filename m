Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A81701C77
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjENJQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjENJQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B132A1FCD
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055778; x=1715591778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vylG+aDfIpc82m6n9qKaKMNNlC8SS2AEmr+j1TAi8yM=;
  b=CTUsOLIhdLcRO+eAYy1JCCtw4jCMCpgPKO5sBk4hw661T49+btzKZ00C
   RrXGDBr/nh7117DGipFwlmgp1tE9i4NP3/HQyPXqAV0wUZmnwMUfEBvBV
   +V4zkxx73X0Ryh8+vVwLkry39iPN510ZCpqjpV6brtNVUnKw5ykcruSuO
   HWwYEZy9e5KV7cTK/VT9M50ITRtUUi+C2d3MPPdUyLTX1k/a0NIRKyLhL
   d3IxSJs68c1tmvjVn0WdRM+auPCPMMS2hAk9CA6cvynYvW+N+E2T0Jktj
   CV6wNn5Om4rQqVAabVCdkdu3woZrigPPF0ecQX+SSizTpwt+2gOtYbTBe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366824"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300295"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300295"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 01/12] wifi: iwlwifi: mvm: always free dup_data
Date:   Sun, 14 May 2023 12:15:44 +0300
Message-Id: <20230514120631.173938681d72.Iff4b55fc52943825d6e3e28d78a24b155ea5cd22@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
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

There are some assertions in the STA removal code that can
fail, and in that case we may leak memory since we skip
the freeing.

Fix this by freeing the dup_data earlier in the function,
we already have a check for when we free the station, and
this we don't need to do it with and without MLD API, so
it's a win all around.

Fixes: a571f5f635ef ("iwlwifi: mvm: add duplicate packet detection per rx queue")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 3 ---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f01b62357c6..1c96cf020801 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3889,6 +3889,9 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 		 * from the AP now.
 		 */
 		iwl_mvm_reset_cca_40mhz_workaround(mvm, vif);
+
+		/* Also free dup data just in case any assertions below fail */
+		kfree(mvm_sta->dup_data);
 	}
 
 	mutex_lock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 0bfdf4462755..f877be850589 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -791,8 +791,6 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	kfree(mvm_sta->dup_data);
-
 	/* flush its queues here since we are freeing mvm_sta */
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct iwl_mvm_link_sta *mvm_link_sta =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 5469d634e289..1e8592d3bcd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2089,9 +2089,6 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (iwl_mvm_has_new_rx_api(mvm))
-		kfree(mvm_sta->dup_data);
-
 	ret = iwl_mvm_drain_sta(mvm, mvm_sta, true);
 	if (ret)
 		return ret;
-- 
2.38.1

