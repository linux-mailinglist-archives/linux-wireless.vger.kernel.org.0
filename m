Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3174B789D23
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjH0LGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjH0LGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF3109
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134370; x=1724670370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPDkWIgejJkU/DxZnCndTShyy8rCOAquoZefLlrlvzk=;
  b=c/b4q5IEw+4AcfMfHqKBW3kL5DIn88DhEhUpugoKixoRzy/Wg3x1drla
   X4HgYBD+pdFNWLvpFNIZdnCieKlHGRMiNsrl+McEdTqXtgZsrCDtNmra4
   DXRiJxnCIOpwedcWKroqrm8NaiHWZRHQasXjhvAAlAlFUivkmjThc2nbd
   oCRs7QDs3egNUUd9M29+pMD1/td7BsuxjsBXVVAZotA7NliKlUhR4IIsQ
   n8F++vq3BgmRwIaYsdwU71EaZNIxzU9ytuAcidHtgcQZ7W5UkV6tEeRq1
   U4jLziQSyzLbw/R/aGr4B6BVZmwnzT8kqwCcsXzc0m18F8ekeiPGScDcs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301571"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881633005"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: mac80211: fix # of MSDU in A-MSDU calculation
Date:   Sun, 27 Aug 2023 14:05:28 +0300
Message-Id: <20230827135854.51bf1b8b0adb.Iffbd337fdad2b86ae12f5a39c69fb82b517f7486@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
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

During my refactoring I wanted to get rid of the switch,
but replaced it with the wrong calculation. Fix that.

Fixes: 175ad2ec89fe ("wifi: mac80211: limit A-MSDU subframes for client too")
Reported-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/sta_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 86f8bb878dbd..bf249e77acad 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2994,7 +2994,7 @@ void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 				   WLAN_EXT_CAPA9_MAX_MSDU_IN_AMSDU_MSB) << 1;
 
 	if (val)
-		sta->sta.max_amsdu_subframes = 4 << val;
+		sta->sta.max_amsdu_subframes = 4 << (4 - val);
 }
 
 #ifdef CONFIG_LOCKDEP
-- 
2.38.1

