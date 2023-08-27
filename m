Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FA1789D22
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjH0LGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjH0LGI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23093139
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134366; x=1724670366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OYCtneyq/PZ7XFrGnEqJv07Y4gOp6k4qa1LW8/CveBc=;
  b=BgZudv89Kdjemh1T8vf2EOvDJbUy69rxXZnJrT2J/SQx0rlrQEQPQl5X
   oQhWNbGNSEZA3m0MNPNjsC5YA08DWjorptA5JXfXxU5T8ngC/ODf2/ptL
   FlugG3gAZ0VSifNeNKWNT0xMxDY/jMyrPdWaFGTb4A3P/LN3fYJ6RLhdf
   zqGubTtFwynzPRgFmH2xrEMJUC+tBEXAsK62sL4NxcUwhuvF7NqGnCOrC
   ieErtTqgie8Yxwkm7hkJEpdjxPc9SvM6ju4pdJECTLIzxqubsJZKXhrgg
   mz05qafxrZHpO/WY8LLzxth8cv8Fno/hVa//ssQsxLouzDGeT0ZE91FMa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301561"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632993"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: cfg80211: reg: fix various kernel-doc issues
Date:   Sun, 27 Aug 2023 14:05:26 +0300
Message-Id: <20230827135854.36d7b52da0f5.I85fbfb3095613f4a0512493cbbdda881dc31be2c@changeid>
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

Clean up the kernel-doc comments in reg.h.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/reg.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/wireless/reg.h b/net/wireless/reg.h
index f3707f729024..a703e53c23ee 100644
--- a/net/wireless/reg.h
+++ b/net/wireless/reg.h
@@ -5,7 +5,7 @@
 
 /*
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2023 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -133,7 +133,7 @@ void regulatory_hint_disconnect(void);
 /**
  * cfg80211_get_unii - get the U-NII band for the frequency
  * @freq: the frequency for which we want to get the UNII band.
-
+ *
  * Get a value specifying the U-NII band frequency belongs to.
  * U-NII bands are defined by the FCC in C.F.R 47 part 15.
  *
@@ -156,11 +156,11 @@ bool regulatory_indoor_allowed(void);
 
 /**
  * regulatory_propagate_dfs_state - Propagate DFS channel state to other wiphys
- * @wiphy - wiphy on which radar is detected and the event will be propagated
+ * @wiphy: wiphy on which radar is detected and the event will be propagated
  *	to other available wiphys having the same DFS domain
- * @chandef - Channel definition of radar detected channel
- * @dfs_state - DFS channel state to be set
- * @event - Type of radar event which triggered this DFS state change
+ * @chandef: Channel definition of radar detected channel
+ * @dfs_state: DFS channel state to be set
+ * @event: Type of radar event which triggered this DFS state change
  *
  * This function should be called with rtnl lock held.
  */
@@ -171,8 +171,8 @@ void regulatory_propagate_dfs_state(struct wiphy *wiphy,
 
 /**
  * reg_dfs_domain_same - Checks if both wiphy have same DFS domain configured
- * @wiphy1 - wiphy it's dfs_region to be checked against that of wiphy2
- * @wiphy2 - wiphy it's dfs_region to be checked against that of wiphy1
+ * @wiphy1: wiphy it's dfs_region to be checked against that of wiphy2
+ * @wiphy2: wiphy it's dfs_region to be checked against that of wiphy1
  */
 bool reg_dfs_domain_same(struct wiphy *wiphy1, struct wiphy *wiphy2);
 
-- 
2.38.1

