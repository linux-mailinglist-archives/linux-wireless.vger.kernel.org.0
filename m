Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441F66A05B9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjBWKLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjBWKKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:10:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329AE51F98
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147039; x=1708683039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AubojJ5ErUthQoQCDUqPhRMSqIc2vIwQGz4rpStf/YY=;
  b=WhdjF+IT2Qx/WjB5UJDOLR2G5IftRpmvtJ4tR8hs/xK48wc7Gmas0Yf0
   vchd+IOS5dQqyBHt0G8dDzfFWmx8YZN/VlE6KmNP2crGd5g/hStFGJUzK
   cboGs9XgYbUz7KToD/pa5I50POTK51tZcs/SclJnNDds47NeDh2EooB8U
   FFxP7y/1M/EaM1WZ/rYSssR/IyODW2JHEJ63lIGN6YyZfBLHZsocJ+qsx
   ENXwBOKV4Z9T/D8IJmk5zxsBUDk7+A12zFC23j7Znh0soZNqEZAE8QuTg
   jTe3UhnuJdkaiSaymgbB2kEnuimqK+IP7+3/Y4I0f3tt0KZ/XsbxsGVb6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396189"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396189"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796244915"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796244915"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:15 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/21] wifi: mac80211: adjust scan cancel comment/check
Date:   Thu, 23 Feb 2023 12:09:23 +0200
Message-Id: <20230223114629.a6f019765317.Id90fef8c581cebe19cb30274340cf43885d55c74@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Instead of the comment about holding RTNL, which is now wrong,
add a proper lockdep assertion for the wiphy mutex.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index dc3cdee51e66..32fa8aca7005 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -1246,11 +1246,11 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-/*
- * Only call this function when a scan can't be queued -- under RTNL.
- */
 void ieee80211_scan_cancel(struct ieee80211_local *local)
 {
+	/* ensure a new scan cannot be queued */
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/*
 	 * We are canceling software scan, or deferred scan that was not
 	 * yet really started (see __ieee80211_start_scan ).
-- 
2.38.1

