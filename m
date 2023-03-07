Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5B6AFA05
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 00:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCGXDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 18:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCGXDX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 18:03:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164973AFA
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678230162; x=1709766162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=82qDVbgDhGmazkSGNPMtdbjYcAvCFNUQ03s5mU3w36I=;
  b=HYtwJUgGfcnwWtI6oDtde/nCXfSXbf0W4h6CW7IKTWxxG10jK22SyVZR
   9AXx6QcGzIUEX4KV0LgX1COHhgIb46t/w9I5Wuwpl2sWwWCfHtqiAs9bj
   HZxAaraEsGFGrWwh1ZVjumO6/4UshWg4vDSHsYNmDMhhyXjtC6nbmzIpT
   Tru+C07L/O4MSWRBKeE5Zpn7wn57kHc3nxKK7dSnQbSOsMHVduAPU395j
   /fRr3ewZEcpB0t+7QiPoTh/oi0mhg4FoYG9mY6YK/68PJANZcgwNRE/x5
   sbCEoSHiiavL2YPHecKfG9olqPWFoOIFQVLbONDfU38cZ/oY+ycNxKe5/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="400824025"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="400824025"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 15:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="1006063567"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="1006063567"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 15:02:40 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2] wifi: nl80211: convert cfg80211_scan_request allocation to *_size macros
Date:   Tue,  7 Mar 2023 15:02:32 -0800
Message-Id: <20230307230232.3735945-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The cfg80211_scan_request structure is followed by a flexible array member
as well as several other arrays that are then stored into pointers in the
structure. These are allocated currently using a simple sequence of
multiplications.

Replace the calculations with struct_size(), size_add(), and array_size()
helper macros. These macros saturate the calculation at SIZE_MAX rather
than overflowing.

Note that we can't use flex_array_size() instead of array_size() because
the fields are not arrays, but simple pointers.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
This was discovered by a coccinelle patch I developed, and submitted at:
  https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/

V1: https://lore.kernel.org/linux-wireless/99a9d4a2-d032-1c9d-90c6-3a68f6b3a092@intel.com/
Changes since v1
* Split series into individual postings to avoid confusion about dependency

 net/wireless/nl80211.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..e5b08546bf30 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9019,7 +9019,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr;
 	struct wiphy *wiphy;
 	int err, tmp, n_ssids = 0, n_channels, i;
-	size_t ie_len;
+	size_t ie_len, size;
 
 	wiphy = &rdev->wiphy;
 
@@ -9064,10 +9064,10 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	if (ie_len > wiphy->max_scan_ie_len)
 		return -EINVAL;
 
-	request = kzalloc(sizeof(*request)
-			+ sizeof(*request->ssids) * n_ssids
-			+ sizeof(*request->channels) * n_channels
-			+ ie_len, GFP_KERNEL);
+	size = struct_size(request, channels, n_channels);
+	size = size_add(size, array_size(sizeof(*request->ssids), n_ssids));
+	size = size_add(size, ie_len);
+	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
 
@@ -9400,7 +9400,7 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct nlattr *attr;
 	int err, tmp, n_ssids = 0, n_match_sets = 0, n_channels, i, n_plans = 0;
 	enum nl80211_band band;
-	size_t ie_len;
+	size_t ie_len, size;
 	struct nlattr *tb[NL80211_SCHED_SCAN_MATCH_ATTR_MAX + 1];
 	s32 default_match_rssi = NL80211_SCAN_RSSI_THOLD_OFF;
 
@@ -9509,12 +9509,14 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 	     attrs[NL80211_ATTR_SCHED_SCAN_RSSI_ADJUST]))
 		return ERR_PTR(-EINVAL);
 
-	request = kzalloc(sizeof(*request)
-			+ sizeof(*request->ssids) * n_ssids
-			+ sizeof(*request->match_sets) * n_match_sets
-			+ sizeof(*request->scan_plans) * n_plans
-			+ sizeof(*request->channels) * n_channels
-			+ ie_len, GFP_KERNEL);
+	size = struct_size(request, channels, n_channels);
+	size = size_add(size, array_size(sizeof(*request->ssids), n_ssids));
+	size = size_add(size, array_size(sizeof(*request->match_sets),
+					  n_match_sets));
+	size = size_add(size, array_size(sizeof(*request->scan_plans),
+					 n_plans));
+	size = size_add(size, ie_len);
+	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return ERR_PTR(-ENOMEM);
 

base-commit: 8f9850dd8d23c1290cb642ce9548a440da5771ec
-- 
2.39.1.405.gd4c25cc71f83

