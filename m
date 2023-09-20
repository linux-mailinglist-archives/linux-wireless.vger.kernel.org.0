Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158277A8BAC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjITS0d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjITS0c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2309E4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234386; x=1726770386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2fFo+Wm7cvoNXzzXtvKDYK4pH4ry27TxBKzRlPCFrE=;
  b=Kj2VFY3HwvZVgkUZoZkxh0yJ7+T+hDGr7nIqdnBwVgIPJt7HHz093caD
   9JVJ95ak38XoKdurxDs4kFkkAoHxAVfJni0UGoT+1h4sybKOTHBy3F7Ud
   M05/sWiHQIExYMzNfTGbFxJs0XQmgTtPyrpXELmWsbIMJIYCgFui5AReS
   KopnVeSqJDYtaTK1ngxubQHbbetLGSaL6vXvsCc69c5nxvnrK1QHZ9jzg
   N97ETjBJ//hD6kiR7JKxRs6RhUlAQS7rkTBxUalddst+F3UbJBFf8JEby
   WtY8tnGwm3ZlL5I2Lu4TJyPLlq+idqae9oSxS6550cdDR/E5UYkKlLhKe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556325"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556325"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424226"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424226"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:24 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 06/18] wifi: cfg80211: reg: describe return values in kernel-doc
Date:   Wed, 20 Sep 2023 21:25:17 +0300
Message-Id: <20230920211508.8b1e45c8bab8.I6dbae4f6dfe8f5352bc44565cc5131e73dd1873f@changeid>
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

Describe the function return values in kernel-doc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/reg.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index eb2fa97457b4..2ef4f6cc7a32 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1283,7 +1283,9 @@ static bool is_valid_rd(const struct ieee80211_regdomain *rd)
  * 60 GHz band.
  * This resolution can be lowered and should be considered as we add
  * regulatory rule support for other "bands".
- **/
+ *
+ * Returns: whether or not the frequency is in the range
+ */
 static bool freq_in_rule_band(const struct ieee80211_freq_range *freq_range,
 			      u32 freq_khz)
 {
@@ -1492,6 +1494,8 @@ static void add_rule(struct ieee80211_reg_rule *rule,
  * Returns a pointer to the regulatory domain structure which will hold the
  * resulting intersection of rules between rd1 and rd2. We will
  * kzalloc() this structure for you.
+ *
+ * Returns: the intersected regdomain
  */
 static struct ieee80211_regdomain *
 regdom_intersect(const struct ieee80211_regdomain *rd1,
@@ -2673,6 +2677,9 @@ static void reg_set_request_processed(void)
  *
  * The wireless subsystem can use this function to process
  * a regulatory request issued by the regulatory core.
+ *
+ * Returns: %REG_REQ_OK or %REG_REQ_IGNORE, indicating if the
+ *	hint was processed or ignored
  */
 static enum reg_request_treatment
 reg_process_hint_core(struct regulatory_request *core_request)
@@ -2729,6 +2736,9 @@ __reg_process_hint_user(struct regulatory_request *user_request)
  *
  * The wireless subsystem can use this function to process
  * a regulatory request initiated by userspace.
+ *
+ * Returns: %REG_REQ_OK or %REG_REQ_IGNORE, indicating if the
+ *	hint was processed or ignored
  */
 static enum reg_request_treatment
 reg_process_hint_user(struct regulatory_request *user_request)
@@ -2784,7 +2794,7 @@ __reg_process_hint_driver(struct regulatory_request *driver_request)
  * The wireless subsystem can use this function to process
  * a regulatory request issued by an 802.11 driver.
  *
- * Returns one of the different reg request treatment values.
+ * Returns: one of the different reg request treatment values.
  */
 static enum reg_request_treatment
 reg_process_hint_driver(struct wiphy *wiphy,
@@ -2888,7 +2898,7 @@ __reg_process_hint_country_ie(struct wiphy *wiphy,
  * The wireless subsystem can use this function to process
  * a regulatory request issued by a country Information Element.
  *
- * Returns one of the different reg request treatment values.
+ * Returns: one of the different reg request treatment values.
  */
 static enum reg_request_treatment
 reg_process_hint_country_ie(struct wiphy *wiphy,
-- 
2.38.1

