Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF077DBDD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbjHPIMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbjHPILe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4945AB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173493; x=1723709493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EvU02tBiSCPkpojybDawq7l5S0gCw7hnQ91l9b2gOgU=;
  b=RVSdu86hmCUwF9jrOGUQb09+ej9YPngz3ynJ1prsKXb9CyIvRy5WCNle
   B298m5YPX9+YiGm0gyFSoIWHEHV422bO0jd6hogg34zH+ewxTl1fepMzi
   5A6aFhnz9TG/Igz77wTT15AoJXp+BelqOqka2O8IcUw0xFkVjjN7CBpoi
   Cewi0k6gIOqQSYHHdfrWywaKi334OMVagT+ql/r+bFEK0K0f/YwWEFt9Y
   X3I7KWChrG99AtLPJxfTmI3zME+0RY8kCCXtxUOXzOeDe3rwgaEQonUzn
   cSJFYIovg11frcgyOsaXNyNO7smsxWcpWLxhAqub78jo8tgYQGKpDrfaq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447879"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447879"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098860"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098860"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/12] wifi: iwlwifi: mvm: support flush on AP interfaces
Date:   Wed, 16 Aug 2023 11:10:53 +0300
Message-Id: <20230816104355.f4b749b91ec2.Ia8381bd4f7d47592e74387c564739798a01c4049@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816081054.245480-1-gregory.greenman@intel.com>
References: <20230816081054.245480-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Support TX flush on AP interfaces so that we will do a
proper flush for frames on the queue before keys are
removed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e7fe5b76def4..5918c1f2b10c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5605,9 +5605,6 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return;
 	}
 
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
-
 	/* Make sure we're done with the deferred traffic before flushing */
 	flush_work(&mvm->add_stream_wk);
 
@@ -5631,9 +5628,6 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			ap_sta_done = true;
 		}
 
-		/* make sure only TDLS peers or the AP are flushed */
-		WARN_ON_ONCE(sta != mvmvif->ap_sta && !sta->tdls);
-
 		if (drop) {
 			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
 				IWL_ERR(mvm, "flush request fail\n");
-- 
2.38.1

