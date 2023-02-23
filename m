Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0D6A05C0
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjBWKMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjBWKMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E394D51920
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147131; x=1708683131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/XLU5TAF9oxzqNV5OVC+IVp21D0COeFjCZvX+r2c9Y=;
  b=hN7bjDi7gwqZocGIaJA6QL6IjWhHyFGKRbh8WZwtJ42xp8r35ro5/orS
   zVuwMqEdiunWz73MXgkt3A2OFYrB1O/BIlhGAqRJtOh/O3awv0FlJlXVO
   7RPq5V4JWbIDpBgxxzOtEdsif7zCNfl+9VA9pKOrxYPgVjVb6eb3Ohirz
   ys3Z7bP2LLiqVqjnVjEVla/HcEiBuj0LR5XhDu2YErioi6vcGYym8pgZU
   0msd/SsAELcZoJ1w7wnZ69WW41sF29zmLpl0QDxzQ2g5MRrJffgT4QVDl
   tCVqpRgOi1dTDh2i4AAQIq9KD/d/TuNizaTBTh56WepJAA0Bk4rrgKH9h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396331"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396331"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245305"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245305"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:40 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/21] wifi: net: wireless: cleanup unused function parameters
Date:   Thu, 23 Feb 2023 12:09:29 +0200
Message-Id: <20230223114629.4ad5ef22a7ec.I255f5ecd77cb24fcf2f1641bb5833ea2d121296e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In the past ftype was used for deciding about 6G DUP beacon, but the
logic was removed and ftype is not needed anymore.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h |  4 +---
 net/wireless/scan.c    | 21 +++++----------------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f115b2550309..03b911abd772 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6814,13 +6814,11 @@ enum cfg80211_bss_frame_type {
  * @ie: IEs
  * @ielen: length of IEs
  * @band: enum nl80211_band of the channel
- * @ftype: frame type
  *
  * Returns the channel number, or -1 if none could be determined.
  */
 int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
-				    enum nl80211_band band,
-				    enum cfg80211_bss_frame_type ftype);
+				    enum nl80211_band band);
 
 /**
  * cfg80211_inform_bss_data - inform cfg80211 of a new BSS
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0cdfbb104b80..f95cb4840b69 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1810,8 +1810,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 }
 
 int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
-				    enum nl80211_band band,
-				    enum cfg80211_bss_frame_type ftype)
+				    enum nl80211_band band)
 {
 	const struct element *tmp;
 
@@ -1868,15 +1867,14 @@ EXPORT_SYMBOL(cfg80211_get_ies_channel_number);
 static struct ieee80211_channel *
 cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 			 struct ieee80211_channel *channel,
-			 enum nl80211_bss_scan_width scan_width,
-			 enum cfg80211_bss_frame_type ftype)
+			 enum nl80211_bss_scan_width scan_width)
 {
 	u32 freq;
 	int channel_number;
 	struct ieee80211_channel *alt_channel;
 
 	channel_number = cfg80211_get_ies_channel_number(ie, ielen,
-							 channel->band, ftype);
+							 channel->band);
 
 	if (channel_number < 0) {
 		/* No channel information in frame payload */
@@ -1953,7 +1951,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		return NULL;
 
 	channel = cfg80211_get_bss_channel(wiphy, ie, ielen, data->chan,
-					   data->scan_width, ftype);
+					   data->scan_width);
 	if (!channel)
 		return NULL;
 
@@ -2387,7 +2385,6 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	size_t ielen, min_hdr_len = offsetof(struct ieee80211_mgmt,
 					     u.probe_resp.variable);
 	int bss_type;
-	enum cfg80211_bss_frame_type ftype;
 
 	BUILD_BUG_ON(offsetof(struct ieee80211_mgmt, u.probe_resp.variable) !=
 			offsetof(struct ieee80211_mgmt, u.beacon.variable));
@@ -2424,16 +2421,8 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 			variable = ext->u.s1g_beacon.variable;
 	}
 
-	if (ieee80211_is_beacon(mgmt->frame_control))
-		ftype = CFG80211_BSS_FTYPE_BEACON;
-	else if (ieee80211_is_probe_resp(mgmt->frame_control))
-		ftype = CFG80211_BSS_FTYPE_PRESP;
-	else
-		ftype = CFG80211_BSS_FTYPE_UNKNOWN;
-
 	channel = cfg80211_get_bss_channel(wiphy, variable,
-					   ielen, data->chan, data->scan_width,
-					   ftype);
+					   ielen, data->chan, data->scan_width);
 	if (!channel)
 		return NULL;
 
-- 
2.38.1

