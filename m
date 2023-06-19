Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA6735882
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjFSN1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjFSN1T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B26123
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181238; x=1718717238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YFVinmtOTtmyyhOBrd1LPRNqExPLk/at6Sw/o9lg0Ew=;
  b=ebSF+TuYTe7tsNyautTiILakQBqRrRtxNkoRxYQIO248Ui4xbJ0Gczw1
   BN+ZqT9qhJjAIPib+OSzDl5FmJT7Ax6EYymgtz0cX3lcgHZ78RqLJrqLj
   3BC5Hs9O3li/r2GigFsqbOCSf78BJ/+x30u9daKT1IuDXxX2IvXhHYif8
   iKZKnE5ulwRTpaKwqqZGy8gJSNjPwP/9MtO+iK0+y/DWYy1qZhE66h6nU
   sz2ev1JBq4KTBc8Gqg+YaDU7JRyaZzKylCjQcPEx9z7FQC3yVeJZJOaVp
   F2AKCPmY6drHSSYjLlBeLL0Ui35amDiWy5/9bvlufDl2j6wqYBs954Rah
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240691"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240691"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871739"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871739"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 6/9] wifi: mac80211: avoid lockdep checking when removing deflink
Date:   Mon, 19 Jun 2023 16:26:50 +0300
Message-Id: <20230619161906.cdd81377dea0.If5a6734b4b85608a2275a09b4f99b5564d82997f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619132653.902084-1-gregory.greenman@intel.com>
References: <20230619132653.902084-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

struct sta_info may be removed without holding sta_mtx if it has not
yet been inserted. To support this, only assert that the lock is held
for links other than the deflink.

This fixes lockdep issues that may be triggered in error cases.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/sta_info.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 731b832b257c..7751f8ba960e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -355,8 +355,9 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 	struct sta_link_alloc *alloc = NULL;
 	struct link_sta_info *link_sta;
 
-	link_sta = rcu_dereference_protected(sta->link[link_id],
-					     lockdep_is_held(&sta->local->sta_mtx));
+	link_sta = rcu_access_pointer(sta->link[link_id]);
+	if (link_sta != &sta->deflink)
+		lockdep_assert_held(&sta->local->sta_mtx);
 
 	if (WARN_ON(!link_sta))
 		return;
-- 
2.38.1

