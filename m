Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602717327FE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjFPGzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbjFPGyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9B296C
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898486; x=1718434486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MtYhfWuUeLZ7rUjo/Sgr4ZilfKVSWzdaJ37dQN3E4QU=;
  b=epb/YJGB4tu7f2X7iK9aHo3wDA6cnZ0eVmZa9h8g5h6hpWY5Y00DCpoH
   s+ceqS4VyPldll+3gVrjQd4xquoiM+zT94r5leO3Tiv35oNy4I3XuBzNk
   25wN2UR3SLF+d5FnrBppPfsFgkfC184UN5bbvt+SdY6RGpCf8nW5SW5hI
   UCuhJ5NbZVSgUpXCN0ftoiQPGT961ejjyVAQokpfiFEWczpDfAZEA084Q
   T6ecGBiDffMhv6lCR56TCeUTjIyYgbKp029qKmj9AInYW4a1BA/mYLTOJ
   ClFcsB+XrhpeOgtwHltcT+N+uVpch0LBZ6nxtilRuiK6z1ghps3q8KXjL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078866"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078866"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720091"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720091"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/20] wifi: cfg80211: move regulatory_hint_found_beacon to be earlier
Date:   Fri, 16 Jun 2023 09:53:58 +0300
Message-Id: <20230616094948.a5bf3558eae9.I33c7465d983c8bef19deb7a533ee475a16f91774@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

These calls do not require any locking, so move them in preparation for
the next patches.

A minor change/bugfix is to not hint a beacon for nontransmitted BSSes

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index ce2104dc05c6..19e7014f8bc3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1971,6 +1971,18 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		tmp.pub.max_bssid_indicator = non_tx_data->max_bssid_indicator;
 	} else {
 		ts = jiffies;
+
+		if (channel->band == NL80211_BAND_60GHZ) {
+			bss_type = capability & WLAN_CAPABILITY_DMG_TYPE_MASK;
+			if (bss_type == WLAN_CAPABILITY_DMG_TYPE_AP ||
+			    bss_type == WLAN_CAPABILITY_DMG_TYPE_PBSS)
+				regulatory_hint_found_beacon(wiphy, channel,
+							     gfp);
+		} else {
+			if (capability & WLAN_CAPABILITY_ESS)
+				regulatory_hint_found_beacon(wiphy, channel,
+							     gfp);
+		}
 	}
 
 	/*
@@ -2007,16 +2019,6 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	if (!res)
 		return NULL;
 
-	if (channel->band == NL80211_BAND_60GHZ) {
-		bss_type = res->pub.capability & WLAN_CAPABILITY_DMG_TYPE_MASK;
-		if (bss_type == WLAN_CAPABILITY_DMG_TYPE_AP ||
-		    bss_type == WLAN_CAPABILITY_DMG_TYPE_PBSS)
-			regulatory_hint_found_beacon(wiphy, channel, gfp);
-	} else {
-		if (res->pub.capability & WLAN_CAPABILITY_ESS)
-			regulatory_hint_found_beacon(wiphy, channel, gfp);
-	}
-
 	if (non_tx_data) {
 		/* this is a nontransmitting bss, we need to add it to
 		 * transmitting bss' list if it is not there
@@ -2445,6 +2447,16 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 		capability = le16_to_cpu(mgmt->u.probe_resp.capab_info);
 	}
 
+	if (channel->band == NL80211_BAND_60GHZ) {
+		bss_type = capability & WLAN_CAPABILITY_DMG_TYPE_MASK;
+		if (bss_type == WLAN_CAPABILITY_DMG_TYPE_AP ||
+		    bss_type == WLAN_CAPABILITY_DMG_TYPE_PBSS)
+			regulatory_hint_found_beacon(wiphy, channel, gfp);
+	} else {
+		if (capability & WLAN_CAPABILITY_ESS)
+			regulatory_hint_found_beacon(wiphy, channel, gfp);
+	}
+
 	ies = kzalloc(sizeof(*ies) + ielen, gfp);
 	if (!ies)
 		return NULL;
@@ -2478,16 +2490,6 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	if (!res)
 		return NULL;
 
-	if (channel->band == NL80211_BAND_60GHZ) {
-		bss_type = res->pub.capability & WLAN_CAPABILITY_DMG_TYPE_MASK;
-		if (bss_type == WLAN_CAPABILITY_DMG_TYPE_AP ||
-		    bss_type == WLAN_CAPABILITY_DMG_TYPE_PBSS)
-			regulatory_hint_found_beacon(wiphy, channel, gfp);
-	} else {
-		if (res->pub.capability & WLAN_CAPABILITY_ESS)
-			regulatory_hint_found_beacon(wiphy, channel, gfp);
-	}
-
 	trace_cfg80211_return_bss(&res->pub);
 	/* cfg80211_bss_update gives us a referenced result */
 	return &res->pub;
-- 
2.38.1

