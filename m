Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0308A728243
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjFHOHV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjFHOHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6222D7F
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233234; x=1717769234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gsuQcX44owvjiTFHVsZVIMRX0g/zSGCDAnxryWX2ntI=;
  b=fgy+5PLZnHVlKsRxQyTvG/LHcldfEAY6ZhOT66E1K1objRu6FAg2hdtg
   aM2gSnv/OzXnSpasw8o4jazDwC1e41GpsCMynR0JmsfKHIpyLXeSpS441
   M64XoC50oZZvDR0iAEGcae2+wkjdr8BKmsYIwwAFP4JuHeaGy2P63T2jK
   v1ji5Rdo14Ro2+V5zXnxiZZsW7cYcp3dWRDebp/TEt8oBaN+8XNKgT+Mw
   8BKgl6BHLughP7t1cUK1M1386c+OePNZy7uVOEuPgaXA73ww+ejhYiQGi
   6QexBE6x0u8MmSFwaRdfRUJAnapmtkiwMaAN59SHwaVtUMX1bjpPcAnqR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176222"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176222"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706205"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706205"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:35 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: mac80211: take lock before setting vif links
Date:   Thu,  8 Jun 2023 16:36:02 +0300
Message-Id: <20230608163202.fa0c6597fdad.I83dd70359f6cda30f86df8418d929c2064cf4995@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133611.1303724-1-gregory.greenman@intel.com>
References: <20230608133611.1303724-1-gregory.greenman@intel.com>
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

From: Benjamin Berg <benjamin.berg@intel.com>

ieee80211_vif_set_links requires the sdata->local->mtx lock to be held.
Add the appropriate locking around the calls in both the link add and
remove handlers.

This causes a warning when e.g. ieee80211_link_release_channel is called
via ieee80211_link_stop from ieee80211_vif_update_links.

Fixes: 0d8c4a3c8688 ("wifi: mac80211: implement add/del interface link callbacks")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1b78a2ae7a83..4aaead4895b7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4862,11 +4862,16 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 				   unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	int res;
 
 	if (wdev->use_4addr)
 		return -EOPNOTSUPP;
 
-	return ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_lock(&sdata->local->mtx);
+	res = ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_unlock(&sdata->local->mtx);
+
+	return res;
 }
 
 static void ieee80211_del_intf_link(struct wiphy *wiphy,
@@ -4875,7 +4880,9 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
+	mutex_lock(&sdata->local->mtx);
 	ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_unlock(&sdata->local->mtx);
 }
 
 static int sta_add_link_station(struct ieee80211_local *local,
-- 
2.38.1

