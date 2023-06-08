Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26DE728245
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjFHOHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjFHOHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BF62D76
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233233; x=1717769233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/7nb2cQ7Hniq+3nBlE2/lCePJJQb5qGKE5M1Dca+pM=;
  b=DPBhp78xdO/t4y9zBDQzn8iBoQa7mI7iTNgTlXfE1REVMqBowpJ+q6Nq
   /+goyF2WbSBU1KNuwJAUD9ZVGh3MDc+xsWDihuTdznyMOoasGavmszIwq
   E13LC1jRMZsrOOflpJRD8LKv5A7ZgrHhuvDW9F51EZwQF1998W0NiMWR0
   TZnkEIksEis5SWOXvg5IQSYlddspF38SAnjoS+0wryiQIMa5XO6T+Zr5e
   Xio6U4jmnoReZ+W1mD/bu+SXxIXCaiy63c27ljLkBiXZAxi28qV7o9PzF
   +aqolsyCG9PW7TpIt52gySYNw9yq5gLgmYqgXvECDXvbWNIOcQW7CjSSp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176215"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176215"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706189"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706189"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: cfg80211: fix link del callback to call correct handler
Date:   Thu,  8 Jun 2023 16:36:01 +0300
Message-Id: <20230608163202.ebd00e000459.Iaff7dc8d1cdecf77f53ea47a0e5080caa36ea02a@changeid>
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

The wrapper function was incorrectly calling the add handler instead of
the del handler. This had no negative side effect as the default
handlers are essentially identical.

Fixes: f2a0290b2df2 ("wifi: cfg80211: add optional link add/remove callbacks")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/rdev-ops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2e497cf26ef2..69b508743e57 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2022 Intel Corporation
+ * Copyright (C) 2018, 2021-2023 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -1441,8 +1441,8 @@ rdev_del_intf_link(struct cfg80211_registered_device *rdev,
 		   unsigned int link_id)
 {
 	trace_rdev_del_intf_link(&rdev->wiphy, wdev, link_id);
-	if (rdev->ops->add_intf_link)
-		rdev->ops->add_intf_link(&rdev->wiphy, wdev, link_id);
+	if (rdev->ops->del_intf_link)
+		rdev->ops->del_intf_link(&rdev->wiphy, wdev, link_id);
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
-- 
2.38.1

