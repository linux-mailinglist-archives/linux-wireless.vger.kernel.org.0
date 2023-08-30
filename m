Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407BA78D9A8
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjH3Sdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbjH3IcC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:32:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C67C1A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384320; x=1724920320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tYCv6hwAXbS3cugjCzMnGRMEpXgFn2RsFyKtL59V8mE=;
  b=a8/A6IQe0tRWXZA3nWBZVlp4acGzo5Hus89jAbup+QCZawNiRGaDw1EI
   6BKRG8TJrBYpUhfgS/unU4BZk7YnusNIgc6U+ag6Dhzv3yn8myfy2SkCS
   i006AVB3jyk2/er76579ZHnodE5GkmhbrjdeX6xfQmh+pCD+NOwprGrxM
   6piwxexXWDKAafCD1go2KOdG+NhyAaaou2dHburv48TTY0y2/VNdKthvb
   T1SMny9fiCk5LG0qMBr9t/9Ohv6jVjxpJ6HIkCNpGR6zc+HsisVkr57Kz
   sfdvpKWtqDptlHEb55njJxR2FoFJtA89ncD8pEj0R+qFUEKsKZ0Kya8Pu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461959089"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461959089"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152497"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152497"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/16] wifi: iwlwifi: mvm: check link more carefully
Date:   Wed, 30 Aug 2023 11:31:01 +0300
Message-Id: <20230830112059.2b81f52ce18e.I8f3b1962013107e2d7491d817c3349359341c6ee@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some cases of restart crashing here have been reported,
while we figure out where this is going wrong, check
the link more carefully to avoid the crash.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b4f2b018388c..a4ac178d76b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3883,7 +3883,8 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 
 	/* this would be a mac80211 bug ... but don't crash */
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
-		if (WARN_ON_ONCE(!mvmvif->link[link_id]->phy_ctxt)) {
+		if (WARN_ON_ONCE(!mvmvif->link[link_id] ||
+				 !mvmvif->link[link_id]->phy_ctxt)) {
 			mutex_unlock(&mvm->mutex);
 			return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
 					&mvm->status) ? 0 : -EINVAL;
-- 
2.38.1

