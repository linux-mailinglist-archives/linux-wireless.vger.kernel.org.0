Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8F7327F6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbjFPGym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbjFPGyh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FE2966
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898476; x=1718434476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZYlS4uJnjR0mN6ENuQdy9ue2iFVPEiYOsiDxM+qZjAo=;
  b=aNOyDkQvaYXxb3U3w0j3Is2aWlhExE0LcMB1Ovkagi/fuIqXCWPrWCOV
   QHekukK+2D7Yf/oGOx9OH2qdnqEy59S3Swby8GCgelTke2ZOxDYSLL+xH
   BZrf/7XYv6AdxdifzScIBbqs1W7foZJeMHyKHW7hn6H3AXDF/azb4ApwL
   nT22TLzj74B1PPnu7KP8k5ZSfUw98dv22+H33FJOGmUPCHht0J0edFtBT
   rFBn0ONLs5YMPK+VBYAPCATcXsWR/N+eyhwRjRqNDpv91LAAofoXe5nEK
   4gDiPJFCxJLcP24l5JEw3IjE+g+qljsxskYuQCU8xEf7iE/oM4FhBBPvA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078810"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078810"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720027"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720027"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/20] wifi: mac80211: Extend AID element addition for TDLS frames
Date:   Fri, 16 Jun 2023 09:53:54 +0300
Message-Id: <20230616094948.483bf44ce684.Ia2387eb24c06fa41febc213923160bedafce2085@changeid>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Extend AID element addition in TDLS setup request and response
frames to add it when HE or EHT capabilities are supported.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tdls.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index c085c076aaef..5ffa3b752720 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -503,17 +503,21 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 		offset = noffset;
 	}
 
-	/* build the VHT-cap similarly to the HT-cap */
+	/* add AID if VHT, HE or EHT capabilities supported */
 	memcpy(&vht_cap, &sband->vht_cap, sizeof(vht_cap));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
+	if ((vht_cap.vht_supported || he_cap || eht_cap) &&
+	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
+	     action_code == WLAN_TDLS_SETUP_RESPONSE))
+		ieee80211_tdls_add_aid(sdata, skb);
+
+	/* build the VHT-cap similarly to the HT-cap */
 	if ((action_code == WLAN_TDLS_SETUP_REQUEST ||
 	     action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) &&
 	    vht_cap.vht_supported) {
 		ieee80211_apply_vhtcap_overrides(sdata, &vht_cap);
 
-		/* the AID is present only when VHT is implemented */
-		if (action_code == WLAN_TDLS_SETUP_REQUEST)
-			ieee80211_tdls_add_aid(sdata, skb);
-
 		pos = skb_put(skb, sizeof(struct ieee80211_vht_cap) + 2);
 		ieee80211_ie_build_vht_cap(pos, &vht_cap, vht_cap.cap);
 	} else if (action_code == WLAN_TDLS_SETUP_RESPONSE &&
@@ -521,9 +525,6 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 		/* the peer caps are already intersected with our own */
 		memcpy(&vht_cap, &sta->sta.deflink.vht_cap, sizeof(vht_cap));
 
-		/* the AID is present only when VHT is implemented */
-		ieee80211_tdls_add_aid(sdata, skb);
-
 		pos = skb_put(skb, sizeof(struct ieee80211_vht_cap) + 2);
 		ieee80211_ie_build_vht_cap(pos, &vht_cap, vht_cap.cap);
 
@@ -551,7 +552,6 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	}
 
 	/* build the HE-cap from sband */
-	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (he_cap &&
 	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
 	     action_code == WLAN_TDLS_SETUP_RESPONSE ||
@@ -595,7 +595,6 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	}
 
 	/* build the EHT-cap from sband */
-	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
 	if (he_cap && eht_cap &&
 	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
 	     action_code == WLAN_TDLS_SETUP_RESPONSE ||
-- 
2.38.1

