Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5559C7215C3
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFDJMg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFDJMf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E81B5
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869944; x=1717405944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pefnL6FCrBwb3qhCV//UU8NetvBku/p2PxFzdN5D4sQ=;
  b=inEKT0WxmIEpT3Yu+OlhzZu9nmdNgQPO+LMSPEJYK4CEYw3lYJ4wOLGL
   Geur5rc/S2v45tMdRaRbje1TZGG9QWaCJinn0qu8pGLh2qHGKvCCMDNjF
   OKMT9q9NK0N26KcHpWAyxTORDWcjxP+ukY3TDNTI0J/SvEnBxYYSVdTX/
   rvpS7uKUKLRBMOkkFIdS4DcBgkZURUZ03ojxMrP8ZdeWsXDm+A3Vo/ZM3
   wZh8O5ylwakwOOHyNC+YhNmLWzwJ9epPF8C5Y+yf45Pn/xH8g3jyfNp6E
   LGjVVFeFfbjMBpSpWliO7mattnsvADWM5tMY3eBrwx/yS6HvPxJMr8v5V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526561"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526561"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804852"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804852"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/16] wifi: mac80211: stop warning after reconfig failures
Date:   Sun,  4 Jun 2023 12:11:28 +0300
Message-Id: <20230604120651.3750c4ae6e76.I9e80d6026f59263c008a1a68f6cd6891ca0b93b0@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

If we have a reconfig failure in the driver, then we need
to shut down the network interface(s) at the network stack
level through cfg80211, which can result in a lot of those
"Failed check-sdata-in-driver check, ..." warnings, since
interfaces are considered to not be in the driver when the
reconfiguration fails, but we still need to go through all
the shutdown flow.

Avoid many of these warnings by storing the fact that the
stack experienced a reconfiguration failure and not doing
the warning in that case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/driver-ops.h  | 10 ++++++----
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/iface.c       |  3 +++
 net/mac80211/util.c        |  1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 45d3e53c7383..c4505593ba7a 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016 Intel Deutschland GmbH
-* Copyright (C) 2018 - 2019, 2021 Intel Corporation
+* Copyright (C) 2018 - 2019, 2021 - 2023 Intel Corporation
 */
 
 #ifndef __MAC80211_DRIVER_OPS
@@ -13,9 +13,11 @@
 #include "trace.h"
 
 #define check_sdata_in_driver(sdata)	({					\
-	!WARN_ONCE(!(sdata->flags & IEEE80211_SDATA_IN_DRIVER),			\
-		   "%s: Failed check-sdata-in-driver check, flags: 0x%x\n",	\
-		   sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);	\
+	WARN_ONCE(!sdata->local->reconfig_failure &&				\
+		  !(sdata->flags & IEEE80211_SDATA_IN_DRIVER),			\
+		  "%s: Failed check-sdata-in-driver check, flags: 0x%x\n",	\
+		  sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);	\
+	!!(sdata->flags & IEEE80211_SDATA_IN_DRIVER);				\
 })
 
 static inline struct ieee80211_sub_if_data *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 46adb1d9a589..8358051720f8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1394,6 +1394,9 @@ struct ieee80211_local {
 	/* device is during a HW reconfig */
 	bool in_reconfig;
 
+	/* reconfiguration failed ... suppress some warnings etc. */
+	bool reconfig_failure;
+
 	/* wowlan is enabled -- don't reconfig on resume */
 	bool wowlan;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f1e01f7a9b2e..2e2115af38f5 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1281,6 +1281,9 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	}
 
 	if (local->open_count == 0) {
+		/* here we can consider everything in good order (again) */
+		local->reconfig_failure = false;
+
 		res = drv_start(local);
 		if (res)
 			goto err_del_bss;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 316a052d61bd..45ab533ef4f1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2370,6 +2370,7 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 	local->resuming = false;
 	local->suspended = false;
 	local->in_reconfig = false;
+	local->reconfig_failure = true;
 
 	ieee80211_flush_completed_scan(local, true);
 
-- 
2.38.1

