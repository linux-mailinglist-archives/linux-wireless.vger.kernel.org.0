Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B756A6A89
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCAKK1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCAKKL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9334F67
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665410; x=1709201410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AubojJ5ErUthQoQCDUqPhRMSqIc2vIwQGz4rpStf/YY=;
  b=Ky3ushR1TRmd41gXg5kB0/jkUmDXl3V2XILQTbLawvihLORQaUwfLW9t
   IOtI1OTX9IU+Y7W+cIloBOAmIFml0+/cGJUzeCeJx9kizS7W5HXHFk4Ig
   UEa/Nq5kEl675zhArVsSG00O6l4f2TfJoTbVAjCvhRfvoXEdBElc4S0jb
   d99c3dDf14oFl0shV4R9GPnPdILKWXQG/4ldw+nsaWm0OqlnxbkQj0DBJ
   pbER8PV2v1/uOcryRSVNOEOd4c9eAa6osv1AeXb14CPF7Z/1J/oMSamOm
   ry37hizVRbw1Lo7LZlbV661kklAbcZBGO7Z2c9RRxwSdwfxu9vSVfKhVp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662769"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662769"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589003"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589003"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:09:58 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 02/23] wifi: mac80211: adjust scan cancel comment/check
Date:   Wed,  1 Mar 2023 12:09:14 +0200
Message-Id: <20230301115906.84352e46f342.Id90fef8c581cebe19cb30274340cf43885d55c74@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

