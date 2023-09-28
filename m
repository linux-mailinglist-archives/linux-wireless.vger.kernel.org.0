Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4877B1FB8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjI1OgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1OgA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FBC19E
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911759; x=1727447759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b94g+ONjafCwQ0/vWHGJALy5Kr7HChBWeh4Cpj5gZTI=;
  b=aZlDMzq3COg5gWJCN+BUNsRoYPqiJyVDXatXe4F746azHO7IHIRUlXc3
   RCzA9hIkXtWFy6AY1kMlgUNiQqrx4lsWj1xHt9UmUJ4Q8qVnHjkmFnnZM
   zAnXMKGCm6L77kd6QvUxq6HeQU7C+Sfpy2N0QtCgNOHR/J1SBrjfZaNUv
   DXNrMaQ/vMsHY1uLi2OVyPJ50Vk596AFtMdl+wnsdLxzrF4kcaotYZ4y1
   UGEUT1bd2PyvFDWuU2SzG9i+XsJX4r+A9rk5/dLHeAMzk5fpTtR6psrDs
   gSKz132LybsxCv8SC004ONc2boPbkr16DtFIvLC4MAT9tjOHayJFiVQ7Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688411"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688411"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590394"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590394"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/18] wifi: mac80211: don't recreate driver link debugfs in reconfig
Date:   Thu, 28 Sep 2023 17:35:24 +0300
Message-Id: <20230928172905.3d0214838421.I512a0ff86f631ff42bf25ea0cb2e8e8616794a94@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can delete any that we want to remove, but we can't
recreate the links as they already exist.

Fixes: 170cd6a66d9a ("wifi: mac80211: add netdev per-link debugfs data and driver hook")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/driver-ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 169dbbca54b6..9112715a749a 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -526,10 +526,13 @@ int drv_change_vif_links(struct ieee80211_local *local,
 	if (ret)
 		return ret;
 
-	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		link = rcu_access_pointer(sdata->link[link_id]);
+	if (!local->in_reconfig) {
+		for_each_set_bit(link_id, &links_to_add,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			link = rcu_access_pointer(sdata->link[link_id]);
 
-		ieee80211_link_debugfs_drv_add(link);
+			ieee80211_link_debugfs_drv_add(link);
+		}
 	}
 
 	return 0;
-- 
2.38.1

