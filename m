Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB046A05C8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjBWKM0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjBWKMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BDD51930
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147136; x=1708683136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2a+35iGuEv9EdfKoWr4lTWaf2kGgez/r07CwsNrdxb0=;
  b=GLg2orlkeJGW7i9uBXG0r7jy8hfRn/1S/lmFTLisOscQQaUKc82bEZFY
   pKJmMPT4LY/53R0ROLm0YUeXdeTOhRTGJ+56wv7mUqIwJwKzC/6rQfF/x
   Znj5qPOALckdNqsYoJalpyvDVSKCtjS1l7X8x01hgJ582cy5+P/BIFbU0
   t+0OpInJBzUw+TILvJKQ/RaIu1tUW+18i9u+aRyHwviLEhPW5kbb1G72F
   m/Kx6NsxKcEL5NQpPzty3CDI3wWJXq+8k9L5OWee1ApPZZ2PyUwKNSZ2z
   p4sYhywj2Ie53cXge+0vgVrv+y7J3MIDLjxJRz8VsINff8aruvr7KNLv3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396414"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396414"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245518"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245518"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:56 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/21] wifi: mac80211: remove SMPS from AP debugfs
Date:   Thu, 23 Feb 2023 12:09:35 +0200
Message-Id: <20230223114629.cf060e45b8de.Iee69f2e4df98581f259ef2c76309b940b20174be@changeid>
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

