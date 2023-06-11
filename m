Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0172B113
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjFKJPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjFKJOt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 05:14:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119EF193
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jun 2023 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686474889; x=1718010889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eianGgCkBSQzE52ZAXpW4mlh7j7aKdF1SenvLZWSur8=;
  b=k0UyngctaJrMvLBtuOsLLnqagcNhu64bzzyQP5BzKYLtdG7S8kFv7Jin
   hP7jbSc2spgjke4XTh7krfqCZRaqelIfw7FCs8JHyUN+B+0gv+ZQYsbaY
   Z7tR1LQsDBMRnwQ2/w6bkpUnGKY5yHN/FlRr4aJ7wWDiEnkHRqPKrMWaw
   gEn+FZNt2XeQ0PR4llNSgAGKe3Ho6tlZybCdgHSy81HN1Z5Jq3mhqZIFI
   oO/viAiI8rzHPff2EPOgFAq1BM0WPdwTHKqFBGBeCBvciJqG9PlfK0cjB
   04kfToSGWGNwPPQGeOPJ7R4pvJOnH2ZFkdS7kKM59w7jPcOKg24OIjwSa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="347488940"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="347488940"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688249747"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="688249747"
Received: from rganonx-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.222.121])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/4] wifi: mac80211: Fix permissions for valid_links debugfs entry
Date:   Sun, 11 Jun 2023 12:14:28 +0300
Message-Id: <20230611121219.c75316990411.I1565a7fcba8a37f83efffb0cc6b71c572b896e94@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611091429.24517-1-gregory.greenman@intel.com>
References: <20230611091429.24517-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The entry should be a read only one and not a write only one. Fix it.
While at it, change the code to use debugs_create_x16().

Fixes: 3d9011029227 ("wifi: mac80211: implement link switching")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/debugfs_netdev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 6253d0127207..b45a45df062b 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -598,13 +598,6 @@ static ssize_t ieee80211_if_parse_tsf(
 }
 IEEE80211_IF_FILE_RW(tsf);
 
-static ssize_t ieee80211_if_fmt_valid_links(const struct ieee80211_sub_if_data *sdata,
-					    char *buf, int buflen)
-{
-	return snprintf(buf, buflen, "0x%x\n", sdata->vif.valid_links);
-}
-IEEE80211_IF_FILE_R(valid_links);
-
 static ssize_t ieee80211_if_fmt_active_links(const struct ieee80211_sub_if_data *sdata,
 					     char *buf, int buflen)
 {
@@ -733,7 +726,7 @@ static void add_sta_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD_MODE(uapsd_queues, 0600);
 	DEBUGFS_ADD_MODE(uapsd_max_sp_len, 0600);
 	DEBUGFS_ADD_MODE(tdls_wider_bw, 0600);
-	DEBUGFS_ADD_MODE(valid_links, 0200);
+	DEBUGFS_ADD_X16(valid_links, 0400);
 	DEBUGFS_ADD_MODE(active_links, 0600);
 	DEBUGFS_ADD_X16(dormant_links, 0400);
 }
-- 
2.38.1

