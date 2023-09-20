Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DEB7A8BAE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjITS0j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjITS0h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F2DD
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234391; x=1726770391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/AP0+xMpx34vxGXFnWLHmoaSPXkLi4eOiXOXfe9sFkU=;
  b=PLiQnZ/D7L8Q5KXeYPnyJKDCqiezJ+eOiMGQu1JPaQsqbKmYfCgAnz1L
   GxrJDxpHyEgjspzw6YD979C9IwuybW3ZegOzbDz1DrjIh1aRq4w4zWd6i
   TIn7uJIpRyfCP9JNJmzhDRkvYtXXXR99xuVCCDvVdmWs27M2KIz4ctVq3
   xFtJ9ouFf/l4ErVPgBAjnJqjWbD50zvs5FR//QrFcZBd9ILt0XXDr8zDR
   4vqbrV61bagRfYu4E5SEBxRlxSy7TZFxglvd+OlC9xGz0n9L+ujlEvhL+
   VBvYgKNyue3gulHxxap7oDiKwtqVJ90XrU0MScWXuy28sqiz8IRbMxf9G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556362"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556362"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424236"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424236"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 08/18] wifi: mac80211_hwsim: move kernel-doc description
Date:   Wed, 20 Sep 2023 21:25:19 +0300
Message-Id: <20230920211508.7f5951a8e327.I5e0cc993acf281d6d90f124c6cce9a2f47000c7d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Move the description after the parameter section, to make the
kernel-doc script in verbose mode happy about it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 36f2d2388ddd..17ecd5fe7258 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -72,15 +72,6 @@ MODULE_PARM_DESC(mlo, "Support MLO");
 /**
  * enum hwsim_regtest - the type of regulatory tests we offer
  *
- * These are the different values you can use for the regtest
- * module parameter. This is useful to help test world roaming
- * and the driver regulatory_hint() call and combinations of these.
- * If you want to do specific alpha2 regulatory domain tests simply
- * use the userspace regulatory request as that will be respected as
- * well without the need of this module parameter. This is designed
- * only for testing the driver regulatory request, world roaming
- * and all possible combinations.
- *
  * @HWSIM_REGTEST_DISABLED: No regulatory tests are performed,
  * 	this is the default value.
  * @HWSIM_REGTEST_DRIVER_REG_FOLLOW: Used for testing the driver regulatory
@@ -125,6 +116,15 @@ MODULE_PARM_DESC(mlo, "Support MLO");
  * 	    domain request
  * 	6 and on - should follow the intersection of the 3rd, 4rth and 5th radio
  * 	           regulatory requests.
+ *
+ * These are the different values you can use for the regtest
+ * module parameter. This is useful to help test world roaming
+ * and the driver regulatory_hint() call and combinations of these.
+ * If you want to do specific alpha2 regulatory domain tests simply
+ * use the userspace regulatory request as that will be respected as
+ * well without the need of this module parameter. This is designed
+ * only for testing the driver regulatory request, world roaming
+ * and all possible combinations.
  */
 enum hwsim_regtest {
 	HWSIM_REGTEST_DISABLED = 0,
-- 
2.38.1

