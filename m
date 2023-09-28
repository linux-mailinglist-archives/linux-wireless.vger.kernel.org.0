Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72E97B1FC9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjI1Ogf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjI1Ogd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA711AB
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911791; x=1727447791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiSTdOTbZyN9JxSp528AmscEDwYbu12+VXV1VJ3Cfd0=;
  b=eH8wHVy+fGyaNkhpSElEody5hEjOUZFicKs+Zn63O7DxIs1mPV2j/BWn
   onUy5p6s4WYtukHJOKmvIAlcPZxA3d5uwKGNhsRTVJiIYCVYNYppdkNoO
   0h9EuS9x/rKElO+oqH8xjuXVHw32pJqXl0QF8/sLJGt9vhLWm/GGmqXf2
   By85b5QhX9VO0XMTcHjGG2AY2v0nIBODOBL4mLcaa38zG9KJtpRzK+m1+
   G9k5fqzV0s4sGtZcwDnQdz0NZ/e/zH7yls7g4gxs9jSk5JpyU95qVq7hK
   sfJ0TfNkLV73pjf8OzqiDOir9xqgDPHalYYCurOyGesbxbcQ9++i6LKEe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688523"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688523"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590555"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590555"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/18] wifi: cfg80211: wext: convert return value to kernel-doc
Date:   Thu, 28 Sep 2023 17:35:37 +0300
Message-Id: <20230928172905.ab3b9274bf07.If263f9f6726d6ad4661f8603e6a4485e0385d67f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
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

Since I'm getting a warning here right now, fix the
kernel-doc to be "Returns:" rather than just writing
that out in the doc paragraph.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/wext-compat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index d23ce088bffa..2371069f3c43 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -7,7 +7,7 @@
  * we directly assign the wireless handlers of wireless interfaces.
  *
  * Copyright 2008-2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019-2022 Intel Corporation
+ * Copyright (C) 2019-2023 Intel Corporation
  */
 
 #include <linux/export.h>
@@ -227,7 +227,7 @@ EXPORT_WEXT_HANDLER(cfg80211_wext_giwrange);
  * cfg80211_wext_freq - get wext frequency for non-"auto"
  * @freq: the wext freq encoding
  *
- * Returns a frequency, or a negative error code, or 0 for auto.
+ * Returns: a frequency, or a negative error code, or 0 for auto.
  */
 int cfg80211_wext_freq(struct iw_freq *freq)
 {
-- 
2.38.1

