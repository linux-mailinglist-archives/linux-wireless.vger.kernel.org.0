Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017C735880
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjFSN1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjFSN1R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FE619C
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181236; x=1718717236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AE+zYL1FUgAosGMm+jzMUM+rPYWAbQLeX2CiQjF/VA8=;
  b=Oam6R+Y43ItkpQJm78bsHNJkEllj9za3Eq6tmLzrYz0j+7v35pVkc6wM
   Hg7epWZwiThQ4fU6K4NTkOGmTNvnqhI5DUoDhx/V4dw18S3xhszZ/UJOg
   KpBNob9H1HTIR26WUlFxSP/iHn2LjfA1YynIp+1DL9s5CNGoLW7tWH/EN
   4cQkxED96Z4Dzt68OJjfP+h0t4Wu2xsE2t1eOpU05im9MEJfZjYSHAF60
   tP8vDpo9aEQmsCZWDLRMwaBHIPALUTiRe5NhHEWY51iepF9oFgkuvCL0U
   aKB6Drwv1Wcqc+/mvFJlu56sqVLmFFKHeABP0a2c3bbi2JGB75p0jX0pe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240683"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240683"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871735"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871735"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/9] wifi: mac80211: always hold sdata lock in chanctx assign/unassign
Date:   Mon, 19 Jun 2023 16:26:49 +0300
Message-Id: <20230619161906.a5cf7534beda.I5b51664231abee27e02f222083df7ccf88722929@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Due to all the multi-link handling, we now expose the fact that
the sdata/vif is locked to drivers, e.g. when the driver uses
ieee80211_set_monitor_channel(). This was true when a chanctx
is added to or removed from a link, _except_ in monitor mode
with the virtual sdata/vif. Change that, so that drivers can
make that assumption.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c   | 16 +++++++++++-----
 net/mac80211/iface.c |  7 +++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index eea7028a46a7..e7ac24603892 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -913,24 +913,30 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 	if (cfg80211_chandef_identical(&local->monitor_chandef, chandef))
 		return 0;
 
-	mutex_lock(&local->mtx);
 	if (local->use_chanctx) {
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
 		if (sdata) {
+			sdata_lock(sdata);
+			mutex_lock(&local->mtx);
 			ieee80211_link_release_channel(&sdata->deflink);
 			ret = ieee80211_link_use_channel(&sdata->deflink,
 							 chandef,
 							 IEEE80211_CHANCTX_EXCLUSIVE);
+			mutex_unlock(&local->mtx);
+			sdata_unlock(sdata);
+		}
+	} else {
+		mutex_lock(&local->mtx);
+		if (local->open_count == local->monitors) {
+			local->_oper_chandef = *chandef;
+			ieee80211_hw_config(local, 0);
 		}
-	} else if (local->open_count == local->monitors) {
-		local->_oper_chandef = *chandef;
-		ieee80211_hw_config(local, 0);
+		mutex_unlock(&local->mtx);
 	}
 
 	if (ret == 0)
 		local->monitor_chandef = *chandef;
-	mutex_unlock(&local->mtx);
 
 	return ret;
 }
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9518acf9643b..be586bc0b5b7 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1133,6 +1133,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	snprintf(sdata->name, IFNAMSIZ, "%s-monitor",
 		 wiphy_name(local->hw.wiphy));
 	sdata->wdev.iftype = NL80211_IFTYPE_MONITOR;
+	mutex_init(&sdata->wdev.mtx);
 
 	ieee80211_sdata_init(local, sdata);
 
@@ -1157,16 +1158,19 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	rcu_assign_pointer(local->monitor_sdata, sdata);
 	mutex_unlock(&local->iflist_mtx);
 
+	sdata_lock(sdata);
 	mutex_lock(&local->mtx);
 	ret = ieee80211_link_use_channel(&sdata->deflink, &local->monitor_chandef,
 					 IEEE80211_CHANCTX_EXCLUSIVE);
 	mutex_unlock(&local->mtx);
+	sdata_unlock(sdata);
 	if (ret) {
 		mutex_lock(&local->iflist_mtx);
 		RCU_INIT_POINTER(local->monitor_sdata, NULL);
 		mutex_unlock(&local->iflist_mtx);
 		synchronize_net();
 		drv_remove_interface(local, sdata);
+		mutex_destroy(&sdata->wdev.mtx);
 		kfree(sdata);
 		return ret;
 	}
@@ -1202,12 +1206,15 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 
 	synchronize_net();
 
+	sdata_lock(sdata);
 	mutex_lock(&local->mtx);
 	ieee80211_link_release_channel(&sdata->deflink);
 	mutex_unlock(&local->mtx);
+	sdata_unlock(sdata);
 
 	drv_remove_interface(local, sdata);
 
+	mutex_destroy(&sdata->wdev.mtx);
 	kfree(sdata);
 }
 
-- 
2.38.1

