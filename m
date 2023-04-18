Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49A26E5D5C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDRJ2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjDRJ2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D3B5BA7
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810119; x=1713346119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iS4mItgQAkeCdU5pTcNevhrVfhjMgO/B41zcaRXwjFA=;
  b=UWaYQzKB/B+CKF80NZgSNx683CSnbMSJv2uu3LbbTYdU0rjkcgBTk1EB
   K4YFFNMKrr+tsznqJ4sn3jU1/M/3X995Jh9VGOE0MHWJmdIqcKiZdy3nN
   QTZvEV4czypW+6y8MyGl3FADvY9Ex3ZZbpaP56me7j2RfovXnmJDhQ9u/
   Y7DszWfmQHJfgBRpfAPoL15wv6JbG3QBFVWlf/iAMaVuJLzPm8svaS4JA
   VRblCoq9cmYE6te7bkXVs8LFlEHhjTphyC2tso1Cn4aG4QkQw9+fmFU/T
   whc67ywBatc1b3/vHsY8krGdG0ikvcolBpil4LE5jY5FCq/3xNHNdGd6E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341178"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341178"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511227"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511227"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/11] wifi: iwlwifi: mvm: prefer RCU_INIT_POINTER()
Date:   Tue, 18 Apr 2023 12:28:09 +0300
Message-Id: <20230418122405.7b400d21a27f.Iccdef9d777677390a9881c88b06c0ed13a83d978@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For constant values we don't need rcu_assign_pointer(),
use RCU_INIT_POINTER() instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ac63af549416..51399284e097 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3314,8 +3314,8 @@ void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 						     lockdep_is_held(&mvm->mutex));
 		sta_id = link_sta->sta_id;
 		if (sta == rcu_access_pointer(mvm->fw_id_to_mac_id[sta_id])) {
-			rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id],
-					   ERR_PTR(-ENOENT));
+			RCU_INIT_POINTER(mvm->fw_id_to_mac_id[sta_id],
+					 ERR_PTR(-ENOENT));
 			RCU_INIT_POINTER(mvm->fw_id_to_link_sta[sta_id], NULL);
 		}
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index d323d119c334..5469d634e289 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2152,7 +2152,7 @@ int iwl_mvm_allocate_int_sta(struct iwl_mvm *mvm,
 	sta->type = type;
 
 	/* put a non-NULL value so iterating over the stations won't stop */
-	rcu_assign_pointer(mvm->fw_id_to_mac_id[sta->sta_id], ERR_PTR(-EINVAL));
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[sta->sta_id], ERR_PTR(-EINVAL));
 	return 0;
 }
 
-- 
2.38.1

