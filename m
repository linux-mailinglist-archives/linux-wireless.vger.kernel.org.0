Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87000789D1E
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjH0LGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjH0LGB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630C0183
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134359; x=1724670359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D8sIuWUtoGnEfnLvHnL3v/+k8TS2eEEzXYk2biWFvKQ=;
  b=EcWEXxgq4klzrOdcXLjGJm1l3Erphh3ttgkn75laBF6ujo2tW/JmyMUl
   ertMwbVVAl0TAcPTMzO5/dl30tZ1Re/J8a7vumxKgDHev6ly0xqcpKVkt
   vpjImFhMUqwsZlpOXlIP1zOh1AmjudicN09kyW6SGlW0KRe4i3kBZbVLh
   MSditTCnd4XsV6OqsVVz7LojUsVapRDyWCy/PjqdjpdXHe2ZdNifmk9GU
   Y+qOAFGTpZUwP0cijUGmfdwO2TsqXwjWQ5SbJkrc2kQgKRJjtt7dn0xY0
   ILSvRVNTjLRkFJ43fgm9AIDe7vjWnpf3nhyu0O6FghZHLrc+5GSd4J6DQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301551"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632976"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: mac80211: add more warnings about inserting sta info
Date:   Sun, 27 Aug 2023 14:05:23 +0300
Message-Id: <20230827135854.eeb43b3cc9e3.I5fd8236f70e64bf6268f33c883f7a878d963b83e@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The sta info needs to be inserted before its links may be modified.
Add a few warnings to prevent accidental usage of these functions.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/sta_info.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 7751f8ba960e..86f8bb878dbd 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2874,6 +2874,8 @@ int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
 
 	lockdep_assert_held(&sdata->local->sta_mtx);
 
+	WARN_ON(!test_sta_flag(sta, WLAN_STA_INSERTED));
+
 	/* must represent an MLD from the start */
 	if (WARN_ON(!sta->sta.valid_links))
 		return -EINVAL;
@@ -2903,6 +2905,8 @@ void ieee80211_sta_free_link(struct sta_info *sta, unsigned int link_id)
 {
 	lockdep_assert_held(&sta->sdata->local->sta_mtx);
 
+	WARN_ON(!test_sta_flag(sta, WLAN_STA_INSERTED));
+
 	sta_remove_link(sta, link_id, false);
 }
 
@@ -2930,7 +2934,7 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 
 	sta->sta.valid_links = new_links;
 
-	if (!test_sta_flag(sta, WLAN_STA_INSERTED))
+	if (WARN_ON(!test_sta_flag(sta, WLAN_STA_INSERTED)))
 		goto hash;
 
 	ieee80211_recalc_min_chandef(sdata, link_id);
@@ -2963,7 +2967,7 @@ void ieee80211_sta_remove_link(struct sta_info *sta, unsigned int link_id)
 
 	sta->sta.valid_links &= ~BIT(link_id);
 
-	if (test_sta_flag(sta, WLAN_STA_INSERTED))
+	if (!WARN_ON(!test_sta_flag(sta, WLAN_STA_INSERTED)))
 		drv_change_sta_links(sdata->local, sdata, &sta->sta,
 				     old_links, sta->sta.valid_links);
 
-- 
2.38.1

