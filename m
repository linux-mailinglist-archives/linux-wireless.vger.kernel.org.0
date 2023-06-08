Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14370728246
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjFHOHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjFHOHP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 10:07:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC69C26AD
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686233234; x=1717769234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhFpFWrk6tYA6L0xTgfTzoFw9oV/QpDxC5iZDJQVL+0=;
  b=RxAnqlTCp6yqyp20fLSGn18p1cs07JInjSRdmWxABcBYViXwnvp8udku
   MsYOnPlhGhfMQJNf9IoJ+yTd4Oocw00q0mXW8yIwBhuk6fihqvMGuF4V0
   7qvMMGyvWBlrqrv8miJINJzd6A/7F1M8/KuFI11suA8mBcomh05oscxmc
   ACn2Yrz6LGGL9Y0qOekc8fTZQA6TMuA+S9kR9Hg0pNNkxuZSavHPxjBop
   SwiKjWYKFlnoOlfw9t32mcbnXOHAdTNJHo1C7nS054QCz7d2Srzj8tgfl
   XrxDjuGYE8TwXNwQm0s9i+S9B+ugKQww2/lzTB6R9uLAo2TeqjKV3TDqW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423176237"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423176237"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956706249"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956706249"
Received: from unknown (HELO ggreenma-mobl2.intel.com) ([10.249.94.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:36:39 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: cfg80211: remove links only on AP
Date:   Thu,  8 Jun 2023 16:36:04 +0300
Message-Id: <20230608163202.ed65b94916fa.I2458c46888284cc5ce30715fe642bc5fc4340c8f@changeid>
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

Since links are only controlled by userspace via cfg80211
in AP mode, also only remove them from the driver in that
case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 3bc0c3072e78..9755ef281040 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -2558,6 +2558,13 @@ void cfg80211_remove_links(struct wireless_dev *wdev)
 {
 	unsigned int link_id;
 
+	/*
+	 * links are controlled by upper layers (userspace/cfg)
+	 * only for AP mode, so only remove them here for AP
+	 */
+	if (wdev->iftype != NL80211_IFTYPE_AP)
+		return;
+
 	wdev_lock(wdev);
 	if (wdev->valid_links) {
 		for_each_valid_link(wdev, link_id)
-- 
2.38.1

