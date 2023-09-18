Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C997A4815
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbjIRLMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjIRLLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24514E6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035502; x=1726571502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2fFo+Wm7cvoNXzzXtvKDYK4pH4ry27TxBKzRlPCFrE=;
  b=VsqtcoIMUiTcQbol0IALoH6wx5U/Rb5BaTB3VC/BM4bUbbb1Kh+fLCCD
   yb7+S0lnpO8BgIE6U2J9PMg2siVHGN+pt7AM1vhq9/eGEjHWeSrmyuUrH
   FoiVkSb4e13xf/wW7BY7i9mulUY3q8ba+4wjXm2/nhAnnB4Hb+ZUjeAwR
   2N7xyOu4kjb8oleUjvQWeN+84mlNwgQmY9izQmNksNIYZsIjmY6xmaEpG
   FdriVRHSLX50xKH7UJbZNa6JIBbjolSVkcqquTjn2BCPsbl3EKbRFeKH5
   ErVUJ3x+KIoVrqCh9eOTMuwkB4Oxx4HbYmF8cCO4RjYy18TZ9Q0QwfZTU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535756"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535756"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025291"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025291"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/18] wifi: cfg80211: reg: describe return values in kernel-doc
Date:   Mon, 18 Sep 2023 14:10:51 +0300
Message-Id: <20230918140607.ce0d9c919bc6.I6dbae4f6dfe8f5352bc44565cc5131e73dd1873f@changeid>
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

