Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F543728248
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjFHOH0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbjFHOHQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124052726
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233235; x=1717769235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=orgMaRnvG4azastAsyl2CS0eCcfX1KbsbSyhwgWZmoA=;
  b=lpu68yiBJPBVGSiBY8upVyxVTApCY9FyNdy9brsZ+nJ+/DWgEEA0k3uO
   ZF/uRQR9HgFKv3Dv7f94WpUFBZ1ZHhq3BBuW1/T2Sq6EXeIEKUEwcFnuj
   UW+k6locp912/xzvRxLYAPC8Bb82YnHEKPDLcv8PsdwjoHN01SquTV4ML
   HoN0hPnjqPqZ7ODU9cR737prOsMY1QrgBeLKDxlEt2/DvTAI3tCSw8bxR
   dNJDOnwpGX0JGndlsh5it62BDtjXg84/stCw6Qof4v7Y3loN8N3girzf9
   1uvE27n+l2c6zDSR3zcYygQGzhYcdVkzZJqwFt/lJF3ulRMEUeLcq4VUJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176246"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176246"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706268"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706268"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: mac80211: don't update rx_stats.last_rate for NDP
Date:   Thu,  8 Jun 2023 16:36:05 +0300
Message-Id: <20230608163202.8af46c4ac094.I13d9d5019addeaa4aff3c8a05f56c9f5a86b1ebd@changeid>
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

If we get an NDP (null data packet), there's reason to
believe the peer is just sending it to probe, and that
would happen at a low rate. Don't track this packet for
purposes of last RX rate reporting.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ed9939466198..77c7dac760ba 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -1732,7 +1732,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 		if (ether_addr_equal(bssid, rx->sdata->u.ibss.bssid) &&
 		    test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
 			link_sta->rx_stats.last_rx = jiffies;
-			if (ieee80211_is_data(hdr->frame_control) &&
+			if (ieee80211_is_data_present(hdr->frame_control) &&
 			    !is_multicast_ether_addr(hdr->addr1))
 				link_sta->rx_stats.last_rate =
 					sta_stats_encode_rate(status);
@@ -1746,7 +1746,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 		 * match the current local configuration when processed.
 		 */
 		link_sta->rx_stats.last_rx = jiffies;
-		if (ieee80211_is_data(hdr->frame_control))
+		if (ieee80211_is_data_present(hdr->frame_control))
 			link_sta->rx_stats.last_rate = sta_stats_encode_rate(status);
 	}
 
-- 
2.38.1

