Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A987215B4
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFDJLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFDJLt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:11:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7BF2
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869907; x=1717405907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHjsNrQ8/Z69ZGy57nN8q6HEaKNCFJAXnMywIcIDDZ8=;
  b=SG6R9a/yTU/RtsMF/Ky7orwqsCiEmw6phXVZkIyi88DRO67w2qmB2t8D
   bJ+d6O5s6pQAMNC78GgnCyUmj6Pxw3PdMQZcSP7+Bq5cgsZdKpwKWKco9
   YyrIjeZzixDK8UxeLdg8K8tGjeJJianx7NHdI+VTfUIEhRuqsm0okh8ek
   b4ss26fnEXVTcA3txYhiihe01fSHMpW1xbXY1mPXIAft8cfmx5SNztacZ
   3bogRlT/vo8x3pcENc39uVHnxTwNud+FyEkfac6ad2Wd9Y1u6bb8H4NUX
   d0VSdeXYtr9VYpDa36ggQfn2528HIGdttN6Y3cTe+9yNqyAiR+oa6R1cn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526467"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526467"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804291"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804291"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/16] wifi: mac80211: use u64 to hold enum ieee80211_bss_change flags
Date:   Sun,  4 Jun 2023 12:11:13 +0300
Message-Id: <20230604120651.d53b7018a4eb.I1adaa041de51d50d84a11226573e81ceac0fe90d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The size of enum ieee80211_bss_change is bigger that 32,
so we need u64 to be used in a flag. Also pass u64
instead of u32 to ieee80211_reconfig_ap_links() for the same
reason.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index cd323fbea8df..d178dc8ab500 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2477,7 +2477,7 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 
 static void ieee80211_reconfig_ap_links(struct ieee80211_local *local,
 					struct ieee80211_sub_if_data *sdata,
-					u32 changed)
+					u64 changed)
 {
 	int link_id;
 
@@ -2654,7 +2654,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	/* Finally also reconfigure all the BSS information */
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		/* common change flags for all interface types - link only */
-		u32 changed = BSS_CHANGED_ERP_CTS_PROT |
+		u64 changed = BSS_CHANGED_ERP_CTS_PROT |
 			      BSS_CHANGED_ERP_PREAMBLE |
 			      BSS_CHANGED_ERP_SLOT |
 			      BSS_CHANGED_HT |
-- 
2.38.1

