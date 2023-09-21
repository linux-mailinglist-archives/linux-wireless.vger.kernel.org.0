Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8908C7A9BED
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjIUTFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjIUTE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884005A56B
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318623; x=1726854623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qlzk2SgvGxnJaXvH29WJ8Ri5QPsI0Iproy6HF8JbI9g=;
  b=DhOzpMztmmKtQmy5JydU2lRoMGQWFz1T4KZ7sW1Jg93MK1kWk9apsrPA
   zz51n4txsVAFG7w7opqYU22TJ+VGVjTWjQBMTCC6UpUMhy4lGzeMWb1Vo
   2aIe6C6XFes7VoTWkSe+FM4x7vWIeDVF+gq/YhGki8a05MzwEfB6Koy6O
   B18vkq3VKhrp5XDtnQejXWnXPxWJ06+PEGvt8rldpHCnZFMnLZcZk9qqi
   dmBRiZvQIfexpJScHRHqzRRkP9Djcw8Gy/fCG80IXgzvqwZfF5g8MkgCC
   FVKBbslf0uLq7McFgM/KHWd0iauSqPxHeN1LCbRdOsWVXyfTUgG4kDXXZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305307"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305307"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545507"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545507"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/12] wifi: iwlwifi: mvm: iterate active links for STA queues
Date:   Thu, 21 Sep 2023 11:58:00 +0300
Message-Id: <20230921110726.7ee1f1a55e1c.I410c512d1fad7d1cf9b2d2a3451a312821dc816d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

During HW restart in eSR, links allocated in a station and links
active in the interface may differ. Use for_each_sta_active_link
to capture this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 51ca99bd5117..61d564735d57 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -865,11 +865,11 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+		struct ieee80211_link_sta *link_sta;
 		unsigned int link_id;
 
-		for (link_id = 0;
-		     link_id < ARRAY_SIZE(mvmsta->link);
-		     link_id++) {
+		rcu_read_lock();
+		for_each_sta_active_link(mvmsta->vif, sta, link_sta, link_id) {
 			struct iwl_mvm_link_sta *link =
 				rcu_dereference_protected(mvmsta->link[link_id],
 							  lockdep_is_held(&mvm->mutex));
@@ -879,6 +879,7 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 
 			sta_mask |= BIT(link->sta_id);
 		}
+		rcu_read_unlock();
 	} else {
 		sta_mask |= BIT(sta_id);
 	}
-- 
2.38.1

