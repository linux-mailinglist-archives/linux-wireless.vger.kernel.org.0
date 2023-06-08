Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60789728247
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbjFHOHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbjFHOHQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869F272E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233235; x=1717769235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yonp2O7QdMMBvfclWkPqvegINvTbzEk552teJI7pVu0=;
  b=O0GEia96nYi5znXUdqesDlnPADELZWPaLv/aBemf/JnHdXv+WOO53cO8
   cG/WmVrvb52loXR7WbE1CqRpV7xAmyg54QyBcANONkqRBHXpcsRPX1xC2
   0OleYWJ3OLwLtLXOVoPKKadneaTjwIynuR1r29CGy+UqeN/yvYrYBkZBZ
   S43fGrbWg8/DEkhUqeVIfLRKBj0NU7zuhPozRMMmVq59jfMgOhJ+MWHCw
   tqe57HCMb7CAuriX3mvcf6jD+4HJup0/dVfdZoKV8JM0aDOF3b/1K8pVF
   WwhB1hU+f2wJt2pDHc/EeXCtYq+tsQBsVSdyDAFHm/xj45daZoFkdmgg9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176255"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176255"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706293"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706293"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: mac80211: disable SMPS override via debugfs
Date:   Thu,  8 Jun 2023 16:36:06 +0300
Message-Id: <20230608163202.ef129e80556c.I74a298fdc86b87074c95228d3916739de1400597@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

There are cases in which we don't want the user to override the
smps mode, e.g. when SMPS should be disabled. Add a driver flag to
disable SMPS overriding and don't override if it is set

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h        | 3 +++
 net/mac80211/debugfs_netdev.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8ea23884a583..98cb2c532025 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1755,12 +1755,15 @@ struct ieee80211_channel_switch {
  * @IEEE80211_VIF_GET_NOA_UPDATE: request to handle NOA attributes
  *	and send P2P_PS notification to the driver if NOA changed, even
  *	this is not pure P2P vif.
+ * @IEEE80211_VIF_DISABLE_SMPS_OVERRIDE: disable user configuration of
+ *	SMPS mode via debugfs.
  */
 enum ieee80211_vif_flags {
 	IEEE80211_VIF_BEACON_FILTER		= BIT(0),
 	IEEE80211_VIF_SUPPORTS_CQM_RSSI		= BIT(1),
 	IEEE80211_VIF_SUPPORTS_UAPSD		= BIT(2),
 	IEEE80211_VIF_GET_NOA_UPDATE		= BIT(3),
+	IEEE80211_VIF_DISABLE_SMPS_OVERRIDE	= BIT(4),
 };
 
 
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index b0cef37eb394..3fea86c9a276 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2022 Intel Corporation
+ * Copyright (C) 2020-2023 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -267,6 +267,9 @@ static int ieee80211_set_smps(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	int err;
 
+	if (sdata->vif.driver_flags & IEEE80211_VIF_DISABLE_SMPS_OVERRIDE)
+		return -EOPNOTSUPP;
+
 	if (!(local->hw.wiphy->features & NL80211_FEATURE_STATIC_SMPS) &&
 	    smps_mode == IEEE80211_SMPS_STATIC)
 		return -EINVAL;
-- 
2.38.1

