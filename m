Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572CB6E0800
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDMHpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDMHpO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97283FF
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371911; x=1712907911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kq3HXqD5fExKDlXAvCQVE/+fPL5rctbLUqA+QeKS77M=;
  b=Ag60XpzbtC+b+XOvt8SgxwmZ6Aw17ePVwa5XRk/wMGE+ve9/xCoq3PW7
   2oiRM/d+WR4YEEJxWKLnibeRQpjjRJvvOreyauzOdnh3581GcnHo9Jdw3
   +BCs9odk1PhaYlbx2tdraIzfaIIphtcpgaPX8Op1AM29961wk0FTL7+qP
   5QzD0uWgbZ//gGEW5V8PP3qif0xCi8vDk0DrL3is1qp7lQ7e2APjbhP+Q
   9V64FNS/ZcnQ9z5lbQFsD94ebTc5oDGQP/toqiG2V4MbrrvP896s7sUga
   CIR63tW4OGdEMlmbvBjZ76DyYVQgxcY6q11qrVqlNjjItAV8RRqlP0LtE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735921"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034674"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034674"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: debug: fix crash in __iwl_err()
Date:   Thu, 13 Apr 2023 10:44:01 +0300
Message-Id: <20230413102635.e27134c6bcd4.Ib3894cd2ba7a5ad5e75912a7634f146ceaa569e2@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In __iwl_err(), if we rate-limit the message away, then
vaf.va is still NULL-initialized by the time we get to
the tracing code, which then crashes. When it doesn't
get rate-limited out, it's still wrong to reuse the old
args2 that was already printed, which is why we bother
making a copy in the first place.

Assign vaf.va properly to fix this.

Fixes: e5f1cc98cc1b ("iwlwifi: allow rate-limited error messages")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
index ae4c2a3d63d5..3a3c13a41fc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2011, 2021 Intel Corporation
+ * Copyright (C) 2005-2011, 2021-2022 Intel Corporation
  */
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -57,6 +57,7 @@ void __iwl_err(struct device *dev, enum iwl_err_mode mode, const char *fmt, ...)
 	default:
 		break;
 	}
+	vaf.va = &args;
 	trace_iwlwifi_err(&vaf);
 	va_end(args);
 }
-- 
2.38.1

