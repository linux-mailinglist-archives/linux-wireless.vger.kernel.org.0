Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD16A5D1E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 17:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjB1Q3G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 11:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjB1Q3E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 11:29:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF319F2C
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677601738; x=1709137738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N0I8Pr28OQ/BUMXsVVB3Jj3rOIxZmI4REJbM4qETlHM=;
  b=M4vd0np9pBzmCqvnsjDu5KeuUmXc/tPETM8tfU85rlaHKr1zEw4rBVec
   XZ/QV91qaGTnRGCAxFrRx7i7KgUChXge4m5cFExqz0KA7UzP20uJENksf
   haMX199uRR13cZfCi8aok3aD5zxvO6SP6GKITwWFBiAT1XTQUZHLM8RmM
   pvA4B6gD9ZvXViCE3Zs5DJ6IkuEGzOJLjhdnXz+F5Xn0BqzV1/sfhkhK+
   Q0+zIC4YlDp/AmIzSy60ia4uVs+sKXUMlf9AO/p5Q/eyeh8749l1Sxtpo
   GQ+33x7KqqM+xF5GthKdwTri21shqoJjRWBZ5eNRMnEY2rGHSR7+d72B4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="398964480"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="398964480"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:28:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="676361744"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="676361744"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:28:33 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 3/3] wifi: nl80211: convert cfg80211_scan_request allocation to *_size macros
Date:   Tue, 28 Feb 2023 08:28:27 -0800
Message-Id: <20230228162827.3876606-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
In-Reply-To: <20230228162827.3876606-1-jacob.e.keller@intel.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
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
 
-- 
2.39.1.405.gd4c25cc71f83

