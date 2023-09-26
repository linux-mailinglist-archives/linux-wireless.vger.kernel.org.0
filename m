Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33E7AE768
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjIZIHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjIZIHm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A7FC
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715656; x=1727251656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shP0liIzuLg4auyW1ffFDnjNNe9mZbNVfTHCZnudP5I=;
  b=GN3aFqnYQz2Hpu1XVL9uKeesvTuRsxxOEIWk+tk7JBeae3qQ4HXyR0CV
   ZN0VkKCTZ4/zUkOK2nNoVV+ESPzRjBBZNF1HSzwN28leU3tRKNBEq9EpB
   z5a+vw/PGUzWH+/fT6EnxWDuKopPkWK+Tqu1iFF2ifLzRP4H+ZsmZaaik
   XWoT1G5aACpJCYAesZIQVMiazaktfn1UUg6gWrdosx8Cd3i1eMJk29WQm
   WCi7iuiviQ/XDm809KvMV6a3ZJPDLP1Ve8nvfsfkuQTkehXUZdYgepOjb
   xpPTBX2ShNv9/iLg+lirDg9bfZZ/5PDg7Nwy9sJ3I1OKE5MQazrlyn9Ze
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797229"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797229"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369257"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369257"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/9] wifi: iwlwifi: mvm: update station's MFP flag after association
Date:   Tue, 26 Sep 2023 11:07:13 +0300
Message-Id: <20230926110319.2488cbd01bde.Ic0f08b7d3efcbdce27ec897f84d740fec8d169ef@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926080721.876640-1-gregory.greenman@intel.com>
References: <20230926080721.876640-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The management frames protection flag is always set when the station
is not yet authorized. However, it was not cleared after association
even if the association did not use MFP. As a result, all public
action frames are not parsed by fw (which will cause FTM to fail,
for example). Update the station MFP flag after the station is
authorized.

Fixes: 4c8d5c8d079e ("wifi: iwlwifi: mvm: tell firmware about per-STA MFP enablement")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6fc5b3f22746..f9a4168e3e1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3809,6 +3809,12 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
+	/* MFP is set by default before the station is authorized.
+	 * Clear it here in case it's not used.
+	 */
+	if (!sta->mfp)
+		return callbacks->update_sta(mvm, vif, sta);
+
 	return 0;
 }
 
-- 
2.38.1

