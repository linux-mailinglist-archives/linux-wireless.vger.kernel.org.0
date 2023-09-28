Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76C67B1FB6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjI1Of5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjI1Of4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:35:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A619D
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911755; x=1727447755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbWqyNksiStUY8BysPpWEKAuiSEhX+dVWzIyeIZXMq0=;
  b=lNFdshQIeiXf/CnJHT1PqQzirVi86neCG7ldVh3erMMV6lJrw77nohkI
   U6v8mxhSmADt/bQUzMhT0oF2pdryiVuANCgrB5U/s2cmVmFYLuOsblpuY
   0J6cP3wR7F+G7XSZSgsU3UZ7sICUKHq2iHschf7ybTrhnalwWfgU37O+A
   90PJK1hS2uXGS4s0Cd+MfV562Co8ZsxoUMVCbEhBei3cumerpzmqQZw9E
   ibP8TtSLb5ZuA8HXYVbtaWMmqLQS6YcxK1z4bq2WmgL5RJKD0KZiJqCJc
   PxW/unlkbhO6Xlcnheb9AI9XLMIpgrMpSCRm5yos5AsFNNNHKr4GEOqG9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688398"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688398"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590385"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590385"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/18] wifi: mac80211: cleanup auth_data only if association continues
Date:   Thu, 28 Sep 2023 17:35:22 +0300
Message-Id: <20230928172905.c9855f46ebc8.I7f3dcd4120a186484a91b87560e9b7201d40984f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
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

From: Benjamin Berg <benjamin.berg@intel.com>

If the association command fails then the authentication is still valid
and it makes sense to keep it alive. Otherwise, we would currently get
into an inconsistent state because mac80211 on the one hand is
disconnected but on the other hand the state is not entirely cleared
and a new authentication could not continue.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index dc9a94bd3b11..e92598dcf3ed 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7715,7 +7715,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		match = ether_addr_equal(ifmgd->auth_data->ap_addr,
 					 assoc_data->ap_addr) &&
 			ifmgd->auth_data->link_id == req->link_id;
-		ieee80211_destroy_auth_data(sdata, match);
+
+		/* Cleanup is delayed if auth_data matches */
+		if (!match)
+			ieee80211_destroy_auth_data(sdata, false);
 	}
 
 	/* prepare assoc data */
@@ -7938,11 +7941,17 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	run_again(sdata, assoc_data->timeout);
 
+	/* We are associating, clean up auth_data */
+	if (ifmgd->auth_data)
+		ieee80211_destroy_auth_data(sdata, true);
+
 	return 0;
  err_clear:
-	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-					  BSS_CHANGED_BSSID);
+	if (!ifmgd->auth_data) {
+		eth_zero_addr(sdata->deflink.u.mgd.bssid);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_BSSID);
+	}
 	ifmgd->assoc_data = NULL;
  err_free:
 	kfree(assoc_data);
-- 
2.38.1

