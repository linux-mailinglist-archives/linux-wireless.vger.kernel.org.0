Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280237A4817
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjIRLMZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjIRLLz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FEE6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035507; x=1726571507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/AP0+xMpx34vxGXFnWLHmoaSPXkLi4eOiXOXfe9sFkU=;
  b=OBtpSysaLmwzYRr1fQ2il67RE9SDXI+jzr7qgSaoQXRmlZoqcul+Vc22
   bqh/2gD+KGpFQ8zjH744f2+DSCswWC5CobkXxZPknoCTpJjAC1H9HBNH6
   fOJt6p/LwkvX+qT04NvtVPqQk938HsIpuhjE/cuQL2y/EDNzoK+3w1jhe
   TN/jJkpGfSargEWqzg6jetTbB3oEt8OIY6jD0qnJsIRIUovgUpJej1D5X
   UzpmcWMSFX269dnSHvUIFsRTV+X6Yf1NzdnkRZbCE934EpitK8F0eH85c
   CG4mSpFkfss46b6Bci+FfxBBjJN+VjGjNMzUz4pjO7cUNnnJ0DZBQW/de
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535777"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025328"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025328"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/18] wifi: mac80211_hwsim: move kernel-doc description
Date:   Mon, 18 Sep 2023 14:10:53 +0300
Message-Id: <20230918140607.857157392f9f.I5e0cc993acf281d6d90f124c6cce9a2f47000c7d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
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

