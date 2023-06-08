Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16C572824C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjFHOHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbjFHOHN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3C2D48
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233231; x=1717769231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=alwB3U2WLQjWPdapBArGYccV+1O1Roar0zTX1iEAFbA=;
  b=V9lJapmUpDS7Uu8qjHI7lsnH228ZHNtl1QYRs77G3WepqX8v4lomfC9q
   LtLUBpCvEoq25ef4edrt0V8kj44vUfShdxsaCCxvgGxGMHiTV/nLKk1Dy
   IrgHu3/TvSRxcHI6ds+mGdl+zNCKUVgf85CWJWS5UU1w7OW/N+lvGy+a6
   sGI71pvF2Co/WCWleXBZ0q274xSseXbBQYZGc1ukdCBhJ0JlbhzaDeaOa
   EegOlRAviua6PEz+p5IG5U5P2JLGgrWt2sVdRFSAV6iDoT1cZFFW2DQIP
   U7oRHIAxNttauoy5e3vbwh18AjjwE00tTy1vtSIaSRpgB2+2plzGZluWg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176197"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176197"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706130"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706130"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: mac80211: pass roc->sdata to drv_cancel_remain_on_channel()
Date:   Thu,  8 Jun 2023 16:35:58 +0300
Message-Id: <20230608163202.c678187a308c.Ic11578778655e273931efc5355d570a16465d1be@changeid>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

In suspend flow "sdata" is NULL, destroy all roc's which are started.
pass "roc->sdata" to drv_cancel_remain_on_channel() to avoid NULL
dereference and destroy that roc

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/offchannel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index d78c82d6b696..cdf991e74ab9 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -8,7 +8,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019, 2022 Intel Corporation
+ * Copyright (C) 2019, 2022-2023 Intel Corporation
  */
 #include <linux/export.h>
 #include <net/mac80211.h>
@@ -1014,7 +1014,7 @@ void ieee80211_roc_purge(struct ieee80211_local *local,
 		if (roc->started) {
 			if (local->ops->remain_on_channel) {
 				/* can race, so ignore return value */
-				drv_cancel_remain_on_channel(local, sdata);
+				drv_cancel_remain_on_channel(local, roc->sdata);
 				ieee80211_roc_notify_destroy(roc);
 			} else {
 				roc->abort = true;
-- 
2.38.1

