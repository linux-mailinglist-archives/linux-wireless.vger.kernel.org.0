Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1E7AE771
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjIZIIB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjIZIH7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A711D
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715673; x=1727251673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j7BpSne/DpKSiCYdgZSY+UEOgIrykZxp7CdLzOi0PaI=;
  b=AJyECWzH3/8Y49aJClQ84h8jceI4U3FiFBotB+s/WPZtdi09TGSVzoED
   2TAO8Gyv9zNs02GygcJQ9Sw44uaTdR/EWVt4us8qoSU/HREErc1IVR0DE
   EilbXDsvNPr4256Bs2PNclx7k8wo6yYE7oKi++WNLKBC3aIwpbGn4l7K5
   cYhynOPczXC9W06j+h/IWFb5vtmNfhJObDZeQgaSKWRS349JucweaOebk
   4L6CD8qXsG8SwhZRe20Pdo9T7uyRoPsNwJTtITk6yIBqjSG7wJHUo7iSQ
   7xn/H24PvbWxSPjZ1arVzG9mTBqtRRsS96CIFt3s9s9RNjeMY9xBY2PAg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797286"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797286"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369363"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369363"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:51 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 8/9] wifi: iwlwifi: mvm: use correct sta ID for IGTK/BIGTK
Date:   Tue, 26 Sep 2023 11:07:20 +0300
Message-Id: <20230926110319.dbc653913353.I82e90c86010f0b9588a180d9835fd11f666f5196@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

We don't (yet) send the IGTK down to the firmware, but when
we do it needs to be with the broadcast station ID, not the
multicast station ID. Same for the BIGTK, which we may send
already if firmware advertises it (but it doesn't yet.)

Fixes: a5de7de7e78e ("wifi: iwlwifi: mvm: enable TX beacon protection")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 2c9f2f71b083..f49820647041 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -24,10 +24,15 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 			return 0;
 	}
 
-	/* AP group keys are per link and should be on the mcast STA */
+	/* AP group keys are per link and should be on the mcast/bcast STA */
 	if (vif->type == NL80211_IFTYPE_AP &&
-	    !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+	    !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
+		/* IGTK/BIGTK to bcast STA */
+		if (keyconf->keyidx >= 4)
+			return BIT(link_info->bcast_sta.sta_id);
+		/* GTK for data to mcast STA */
 		return BIT(link_info->mcast_sta.sta_id);
+	}
 
 	/* for client mode use the AP STA also for group keys */
 	if (!sta && vif->type == NL80211_IFTYPE_STATION)
-- 
2.38.1

