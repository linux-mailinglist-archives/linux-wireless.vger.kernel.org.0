Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662F7728244
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjFHOHW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjFHOHP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A830C0
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233234; x=1717769234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TgT4wsb6c7Es+Urk5Tdw4BuJ+a/TJjwpyFe774/LmQ0=;
  b=fS6reJJnpTLk94VpoSdM3DOPvX0ytiYBma9pDkDbI8jvxa1g3dS1E0Vr
   60PQab8lrFENNYuVIHs+HU+F7zc4elpfE6UiOcQx2xefgQKy2AP+O/dk9
   u2mLitPMBzPsYo+En0jXwCMIWwn2mlVvkc8R2pDVaGtZ7+z43YpAywxip
   tU5VZG4YSLMqHbZl6iceYj+No7wGFFSdIKZybjv1/7aGnnaAuaeEN9vYm
   1BbKUtx+lLcLXkgBecNuBqE8HwgK+dzyLbTP4zoYUjKCTaaOyQgx4KCyk
   5oCat4Do7vxsbU2P9vKnEJwM9Za25QVuzuLHDSkQgENM9wQtsiu9R0S/9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176230"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176230"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706226"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706226"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: mac80211: fix CSA processing while scanning
Date:   Thu,  8 Jun 2023 16:36:03 +0300
Message-Id: <20230608163202.3366e9302468.I6c7e0b58c33b7fb4c675374cfe8c3a5cddcec416@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The channel switch parsing code would simply return if a scan is
in-progress. Supposedly, this was because channel switch announcements
from other APs should be ignored.

For the beacon case, the function is already only called if we are
associated with the sender. For the action frame cases, add the
appropriate check whether the frame is coming from the AP we are
associated with. Finally, drop the scanning check from
ieee80211_sta_process_chanswitch.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f13792994b4f..d1e30ff54c1f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1857,9 +1857,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	if (!cbss)
 		return;
 
-	if (local->scanning)
-		return;
-
 	current_band = cbss->channel->band;
 	bss = (void *)cbss->priv;
 	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
@@ -5997,6 +5994,10 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		ieee80211_rx_mgmt_assoc_resp(sdata, mgmt, skb->len);
 		break;
 	case IEEE80211_STYPE_ACTION:
+		if (!sdata->u.mgd.associated ||
+		    !ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr))
+			break;
+
 		if (mgmt->u.action.category == WLAN_CATEGORY_SPECTRUM_MGMT) {
 			struct ieee802_11_elems *elems;
 
-- 
2.38.1

