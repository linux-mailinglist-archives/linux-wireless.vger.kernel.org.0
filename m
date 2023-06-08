Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D366728242
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjFHOHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbjFHOHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37A2D65
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233232; x=1717769232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBf8o4UIHJ1SpzQxBrOKGTFKRGA9K39gDcYNf0ypHyo=;
  b=QSUlZmyW1sJFRqlNRdRo4iK5JMLhPlMTxWW+R2JUjFxRFsJgdMjYxovH
   pv+oCQsje/EgaaHfNr+t+hMJmZozCZ9Nbn82LAYjKqwfvovEFUrfF//I8
   iL2FZra9SYbCQKO+gaKtscWoVVmOQsP/dyFaAIrjKofxJneXiklvbSTti
   38XAcbJU/lodTLPgoJGqtVQgIvnIeMHtUHQtv0tmVKzEp1djwF+qNRCG4
   yPdUKYE5Z26QgJHga+MOGnRcYbIBjcY7vFpbG98Y2YxVOXb+P9JZ8ky7o
   YTG+mq5ShWTYQz8YwlwENgKs7BpBHWPxNkoqNyofV3DtYfiNFIJ8YZY8s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176202"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176202"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706145"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706145"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: mac80211: fix link activation settings order
Date:   Thu,  8 Jun 2023 16:35:59 +0300
Message-Id: <20230608163202.a2a86bba2f80.Iac97e04827966d22161e63bb6e201b4061e9651b@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

In the normal MLME code we always call
ieee80211_mgd_set_link_qos_params() before
ieee80211_link_info_change_notify() and some drivers,
notably iwlwifi, rely on that as they don't do anything
(but store the data) in their conf_tx.

Fix the order here to be the same as in the normal code
paths, so this isn't broken.

Fixes: 3d9011029227 ("wifi: mac80211: implement link switching")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index e82db88a47f8..40f030b8ece9 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -2,7 +2,7 @@
 /*
  * MLO link handling
  *
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -409,6 +409,7 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 						 IEEE80211_CHANCTX_SHARED);
 		WARN_ON_ONCE(ret);
 
+		ieee80211_mgd_set_link_qos_params(link);
 		ieee80211_link_info_change_notify(sdata, link,
 						  BSS_CHANGED_ERP_CTS_PROT |
 						  BSS_CHANGED_ERP_PREAMBLE |
@@ -423,7 +424,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 						  BSS_CHANGED_TWT |
 						  BSS_CHANGED_HE_OBSS_PD |
 						  BSS_CHANGED_HE_BSS_COLOR);
-		ieee80211_mgd_set_link_qos_params(link);
 	}
 
 	old_active = sdata->vif.active_links;
-- 
2.38.1

