Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717C7215B6
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjFDJL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjFDJLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:11:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F73B1
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869913; x=1717405913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hp2tzqMm1p/VMXXzdT6imo/Wil+zcAhDp/JRnbDdss8=;
  b=HX4/mZQ/3PDlfsXgzAi+nl1S8VCo4NJadYtFpeQNT0sDVmSkk7ofEBXF
   FLRDnprd0dvoVq0JzU695oGdCjMM6Idpl/O3GRJ80zSQ0Sqg2QKYBQgXj
   yobb4Ja+6uYx8B4hrBaVmsesstlhhnpvoGwgg6zXXVCA3AnvqKv9F8MGc
   YaUuiTY43BmEWHWnc+z3IzQEgCGtGBbY8GOAo7VGnmK3raFDHLw46JWYi
   mSAz+cnDyDkjI/A4dDyYfdEYXNhfAuztJDo2x8eD/CXJdgQ/H1h+5dRH5
   7fcZu148CvykThqjZMWLLsTsN3r8KKOjoEgEqLXxSZHftRMWF7jevA1Xx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526490"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526490"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804378"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804378"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:51 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/16] wifi: mac80211: don't translate beacon/presp addrs
Date:   Sun,  4 Jun 2023 12:11:15 +0300
Message-Id: <20230604120651.62adead1b43a.Ifc25eed26ebf3b269f60b1ec10060156d0e7ec0d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
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

Don't do link address translation for beacons and probe responses,
this leads to reporting multiple scan list entries for the same AP
(one with the MLD address) which just breaks things.

We might need to extend this in the future for some other (action)
frames that aren't MLD addressed.

Fixes: 42fb9148c078 ("wifi: mac80211: do link->MLD address translation on RX")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 58222c077898..d996aa2579df 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4965,7 +4965,9 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	}
 
 	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
-	    is_unicast_ether_addr(hdr->addr1)) {
+	    is_unicast_ether_addr(hdr->addr1) &&
+	    !ieee80211_is_probe_resp(hdr->frame_control) &&
+	    !ieee80211_is_beacon(hdr->frame_control)) {
 		/* translate to MLD addresses */
 		if (ether_addr_equal(link->conf->addr, hdr->addr1))
 			ether_addr_copy(hdr->addr1, rx->sdata->vif.addr);
-- 
2.38.1

