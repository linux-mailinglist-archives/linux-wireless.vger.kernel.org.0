Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E66FA226
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjEHIZb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjEHIY7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:24:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02E91C0F4
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534297; x=1715070297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+JkSkfvkv1cXhhzvR1efj36ToSOCv287MVFFsp3NKOQ=;
  b=LmhDWH3dl0PuZnj8FMZWGFAeh6xQkifKbRidDVocuC9MLt1VIRt2lUwd
   +rXzbnNEbt4q9DDVmgnma2B9sMJFlCy7+qOHBzXi/CJjbjIz6ZkZXbBb7
   edwyXIQqyusT1HnvuLHAPeYrx2TZL3CAVo8bxeWxTKqq4xhOiMW4F226h
   D6gwJOTz1Cr3yGAomu5TAshgJOc1swAkMz1kmmeyHKr0bPYWsckB6ILf+
   44X7o8CfnjXcuPil54/e09gTkpWtpydpbCLPqODQD/Ypl3eZ+AGcJi5HT
   An5zNT0UfmWF6ycXec7lLg56oy411JxxRq/yXtnv7jOXA4WJoLm3LsOtQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949879"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949879"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982623"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982623"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:56 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: mvm: don't double-init spinlock
Date:   Mon,  8 May 2023 11:24:25 +0300
Message-Id: <20230508082433.1349733-7-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

We don't need to (and shouldn't) initialize the spinlock
during HW restart that was already initialized, so move
that into the correct if block. Since then we have two
consecutive if statements with the same (though inverted)
condition, unify those as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index f877be850589..19f1545b3c7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -667,15 +667,15 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		ret = iwl_mvm_mld_alloc_sta_links(mvm, vif, sta);
 		if (ret)
 			return ret;
-	}
 
-	spin_lock_init(&mvm_sta->lock);
+		spin_lock_init(&mvm_sta->lock);
 
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		ret = iwl_mvm_alloc_sta_after_restart(mvm, vif, sta);
-	else
 		ret = iwl_mvm_sta_init(mvm, vif, sta, IWL_MVM_INVALID_STA,
 				       STATION_TYPE_PEER);
+	} else {
+		ret = iwl_mvm_alloc_sta_after_restart(mvm, vif, sta);
+	}
+
 	if (ret)
 		goto err;
 
-- 
2.38.1

