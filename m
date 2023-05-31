Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77C7187D4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjEaQv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEaQv5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0E139
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551912; x=1717087912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gMOB+o3qmEVKajS3pT324vOkwe86BonMBM3vf6l+WI=;
  b=LmcFRV+l+rFAAkFr+I3OFAXOriP59wHQOVHs39s2hqlAUp8f11JXD/K7
   bl0u96TUU13ucj5XpW7/Xf6cH9pn+tuwbsJxLYDIajGWQ0uNEefhqx2hQ
   LxVppH9CsBxp4wvhALa2sSr2OfMPg7bW12xH7nzsjX+Cof1XjfHSuxBPU
   F9wY8p9CpzSfbV+CtrP3n08KonKEcsDqYR+GUIrskQhxOFFM9o7c5hg+E
   YQRD/zmxaVaJm04wq1rpRmexCYdknEWetJSen75sMNDIU7mAox1aqoP+E
   FtiV/5fE3K/LBZyqMLXGCdeZfzISy8X+yREsIvcNfC0KOQR7UIxLwSCko
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890757"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890757"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706988003"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706988003"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: mvm: remove warning for beacon filtering error
Date:   Wed, 31 May 2023 19:50:05 +0300
Message-Id: <20230531194630.29fe6990d372.I00ff5dc7bfb4025a609f380a0a3911d842b72449@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This warning is sometimes happening if we force a FW error
while disconnecting, which is annoying but harmless.

However, it's also pointless to throw a warning here, since
the stack and driver state doesn't really help, so just
remove that so the driver will ignore the error if any.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7ea200c85cac..6a712e519bac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3801,7 +3801,6 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -3820,10 +3819,7 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 		mvmvif->authorized = 0;
 
 		/* disable beacon filtering */
-		ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
-		WARN_ON(ret &&
-			!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-				  &mvm->status));
+		iwl_mvm_disable_beacon_filter(mvm, vif, 0);
 	}
 
 	return 0;
-- 
2.38.1

