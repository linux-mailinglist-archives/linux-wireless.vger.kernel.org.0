Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6070FD0F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjEXRq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjEXRqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:46:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA79CE68
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950354; x=1716486354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MRRddCliDwQ1uKWm6gCCDWlSuKiXOeoZbbHFVClmwqA=;
  b=TjgzM5I1DkaqoBB0ZJBNsewAoflT0s5j1p7C6jV950gPLo8hiUMksq9Q
   0otiCRrnj6Gk1z3R4GGCqvYcH/z0UelJuwHu+Gq6sHTH2r/jOR4rOjqiI
   ShE5ggRa3h8ykXRMDZtKTCw2jLLj8+p7+w8BGrXlOPUNdhScbDLcOFcbd
   iD3V7BiVbCaN8DDTNTwFRXHU3/+NuiBTqa8Z5hrccI8WkYNYqeciEM7t7
   lVi5VqZie9DSRH14M4z4iGAI4D/VbncVAdPKxW4rOCH7fz022EhCJ2Cu6
   24Nt8EHlzEUaZukJbyzrvhe4jKd2QMaCTvtg+rqWuLimYuDSvhVmzvC4l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000486"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:43:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769548075"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769548075"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:59 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: mvm: remove useless code
Date:   Wed, 24 May 2023 20:42:09 +0300
Message-Id: <20230524203151.30048b1cd0fd.Ie2c2ff6fd7c6e3ebf5b736de350dc15515970792@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
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

Setting the station to -EBUSY was originally done under
this lock, and the comment still refers to it. But this
no longer happens because that was removed when DQA was
removed. Remove the leftover code as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 4e3f994654c9..931562bb5bd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2070,13 +2070,6 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		cancel_delayed_work(&mvm->tdls_cs.dwork);
 	}
 
-	/*
-	 * Make sure that the tx response code sees the station as -EBUSY and
-	 * calls the drain worker.
-	 */
-	spin_lock_bh(&mvm_sta->lock);
-	spin_unlock_bh(&mvm_sta->lock);
-
 	return false;
 }
 
-- 
2.38.1

