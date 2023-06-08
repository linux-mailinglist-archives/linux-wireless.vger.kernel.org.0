Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8D72824A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbjFHOH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbjFHOHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB932D64
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233232; x=1717769232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9WoqU1wGmiI+HRItiC0Pgw/JHfZUdhOLcaV2absBjyE=;
  b=YSi3iTIpLpcHsG/6muqKTjYLju6tUjWV3p5lHLpACEyysYrOKE6Khp31
   YERI3/OKwcmgSCe87ASY0Nm2e0hXcsPAdhA8SuGDUxwyWIGnF+c2I3UtP
   aRRJuw4N2g9dZ/BnLOxPYg9mB4G3a8mw19nDl1owaS54wNAI7eEscTrzW
   M3lagChPweA5lZyYKjDUpwmsmFKfLnL9heCGoGz+V1vo/S445eICQe3qq
   EdHUaHkDHcI1tvOBSDiJQVPJwBFQISZxWFsM+W5NnSpoiqi5zOa5FVkaW
   ZcpbhF8fq9/5/5AJz0Fjf1VTlWYkgxQhq3kjOOxqf9TQX0Ag2znPBpWko
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176209"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176209"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706165"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706165"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: mac80211: mlme: clarify WMM messages
Date:   Thu,  8 Jun 2023 16:36:00 +0300
Message-Id: <20230608163202.21a6bece4313.I08118e5e851fae2f9e43f8a58d3b6217709bf578@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133611.1303724-1-gregory.greenman@intel.com>
References: <20230608133611.1303724-1-gregory.greenman@intel.com>
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

These messages apply to a single link only, use link_info()
to indicate that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 270133883882..f13792994b4f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2639,9 +2639,9 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 		params[ac].aifs = pos[0] & 0x0f;
 
 		if (params[ac].aifs < 2) {
-			sdata_info(sdata,
-				   "AP has invalid WMM params (AIFSN=%d for ACI %d), will use 2\n",
-				   params[ac].aifs, aci);
+			link_info(link,
+				  "AP has invalid WMM params (AIFSN=%d for ACI %d), will use 2\n",
+				  params[ac].aifs, aci);
 			params[ac].aifs = 2;
 		}
 		params[ac].cw_max = ecw2cw((pos[1] & 0xf0) >> 4);
@@ -2652,9 +2652,9 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 
 		if (params[ac].cw_min == 0 ||
 		    params[ac].cw_min > params[ac].cw_max) {
-			sdata_info(sdata,
-				   "AP has invalid WMM params (CWmin/max=%d/%d for ACI %d), using defaults\n",
-				   params[ac].cw_min, params[ac].cw_max, aci);
+			link_info(link,
+				  "AP has invalid WMM params (CWmin/max=%d/%d for ACI %d), using defaults\n",
+				  params[ac].cw_min, params[ac].cw_max, aci);
 			return false;
 		}
 		ieee80211_regulatory_limit_wmm_params(sdata, &params[ac], ac);
@@ -2663,9 +2663,9 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 	/* WMM specification requires all 4 ACIs. */
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		if (params[ac].cw_min == 0) {
-			sdata_info(sdata,
-				   "AP has invalid WMM params (missing AC %d), using defaults\n",
-				   ac);
+			link_info(link,
+				  "AP has invalid WMM params (missing AC %d), using defaults\n",
+				  ac);
 			return false;
 		}
 	}
-- 
2.38.1

