Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62A66A6A9C
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCAKLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCAKK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF593B3CF
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665452; x=1709201452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfNSk1dVqOdAcsSzsI3FCNbHkExYJ/PUpNwOIx7vPus=;
  b=SdrWkShc1KVs8BKlAcJR1wx3nhn+KAVNjJdg07Y5DgmhN0HNf/JLk9NG
   yVKOovwQCT5CmZERXrRLGdwyqjl70ofWPTdtrt/514smAXjKHfr5Dl8aV
   4UTLBwBrk6JZIwy2PIvbiQnIkvAd4r/5YwMvNO0kNsN5LgulNMnSwnGRw
   E+Wbv3JVNZTAxxEun+9Is/fvhSVAS5zgQftI0cJYU3UBNgk0SRJS8sKKi
   WG7YXN/tZdPUpDV1V5tnntGKVzxiM9ay6WgVijaw4WmDLNlBOpdlKKmWS
   9UkF2XK0M/asqP3F5EPP7o4iJYCGFz1mOgV+AGMLmaew/pH8mP4T+Pdl/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662937"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662937"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589207"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589207"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:43 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 17/23] wifi: nl80211: fix NULL-ptr deref in offchan check
Date:   Wed,  1 Mar 2023 12:09:29 +0200
Message-Id: <20230301115906.71bd4803fbb9.Iee39c0f6c2d3a59a8227674dc55d52e38b1090cf@changeid>
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

If, e.g. in AP mode, the link was already created by userspace
but not activated yet, it has a chandef but the chandef isn't
valid and has no channel. Check for this and ignore this link.

Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 22dbc30096b2..a42b37de68b0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8909,7 +8909,7 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 		struct cfg80211_chan_def *chandef;
 
 		chandef = wdev_chandef(wdev, link_id);
-		if (!chandef)
+		if (!chandef || !chandef->chan)
 			continue;
 
 		/*
-- 
2.38.1

