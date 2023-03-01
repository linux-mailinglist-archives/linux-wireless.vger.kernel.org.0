Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775726A6A98
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCAKLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCAKKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981C13B840
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665440; x=1709201440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2a+35iGuEv9EdfKoWr4lTWaf2kGgez/r07CwsNrdxb0=;
  b=JEMDy/mxVJeGdECJSiKcsJakJiIkYa3lRMEAxETh3nyk9DcS21o2KRKn
   ES8iqe8iecaf9I6kNR9LFej9tjn/YevWFyFBRcLviIBo7roy1XK8tOT9l
   iWWGUoOULMc3A0+/GHpuXBFV0a8Vr4rgirKRsZHMgUG06z+XTip8vSw7v
   VJAjQ8hEw5oUjAAFhHeO0zdxg2BtXy+MI/SKK4Jkf4ZRa9Udf5mDwEHQ4
   AThngd6S6OLxCJtLp1D2feflM79Y+V6RAO4ynNQFyHCyCAT2PJemrOuB8
   Tjrpg5SKCIovyO1hlV0e7w3onr+EdpUv+Qy4psVfL57cFo4gJj45Q4Ztx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662897"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662897"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589162"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589162"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:34 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 14/23] wifi: mac80211: remove SMPS from AP debugfs
Date:   Wed,  1 Mar 2023 12:09:26 +0200
Message-Id: <20230301115906.01b167027dd5.Iee69f2e4df98581f259ef2c76309b940b20174be@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The spatial multiplexing power save feature does not apply to
AP mode. Remove it from debugfs in this case.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/debugfs_netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 0bac9af3ca96..187bb22c0bbd 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -698,7 +698,6 @@ static void add_sta_files(struct ieee80211_sub_if_data *sdata)
 static void add_ap_files(struct ieee80211_sub_if_data *sdata)
 {
 	DEBUGFS_ADD(num_mcast_sta);
-	DEBUGFS_ADD_MODE(smps, 0600);
 	DEBUGFS_ADD(num_sta_ps);
 	DEBUGFS_ADD(dtim_count);
 	DEBUGFS_ADD(num_buffered_multicast);
-- 
2.38.1

