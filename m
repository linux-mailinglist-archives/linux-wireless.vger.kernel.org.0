Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19056F6D28
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjEDNps (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjEDNpq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511807D9C
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207944; x=1714743944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xKhsdJpkyCEcSpDCh+zHKNurr8cUaFuDHo2IZFYPWcw=;
  b=Os9MdXl1OGW2dU3qsjty3t1X7U0F6qbVPkzjLj3zEIYlQxEJezfvuQ7b
   VrRJGr2ChYPb5ro82xrLRkk5R0mtB/0b+AgKKkWAUJ3YLIyqyE2iv+34b
   UDjwAGoo6dMcOWeVqbh2h3QQ032V59NeBwA4xs15zfC24CHJs8hlJHxsv
   YHYvuxF8V5yKHghGYXf+CvEvlu6pfxPtA5NPOkpcWr5qeeAaiQ93MF8Ve
   VYDVGElmWoMKl39gFG+L83IU4yIFq/HmiuVGlm3a/RFPxHtd80HOXCCfH
   81CFNfolrfNu8KDFhCC6L/9ZnMeRpz5Ov8aignA11N6B0wUmVYD9AGF1q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242665"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591806"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591806"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/11] wifi: mac80211: skip EHT BSS membership selector
Date:   Thu,  4 May 2023 16:45:08 +0300
Message-Id: <20230504134511.828474-9-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504134511.828474-1-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Skip the EHT BSS membership selector for getting rates.
While at it, add the definitions for GLK and EPS, and
sort the list.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 5 ++++-
 net/mac80211/mlme.c       | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c4cf296e7eaf..c271184a3968 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1349,8 +1349,11 @@ struct ieee80211_mgmt {
 /* Supported rates membership selectors */
 #define BSS_MEMBERSHIP_SELECTOR_HT_PHY	127
 #define BSS_MEMBERSHIP_SELECTOR_VHT_PHY	126
-#define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
+#define BSS_MEMBERSHIP_SELECTOR_GLK	125
+#define BSS_MEMBERSHIP_SELECTOR_EPS	124
 #define BSS_MEMBERSHIP_SELECTOR_SAE_H2E 123
+#define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
+#define BSS_MEMBERSHIP_SELECTOR_EHT_PHY	121
 
 /* mgmt header + 1 byte category code */
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e13a0354c397..0020c9e41caa 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3902,8 +3902,8 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 			*have_higher_than_11mbit = true;
 
 		/*
-		 * Skip HT, VHT, HE and SAE H2E only BSS membership selectors
-		 * since they're not rates.
+		 * Skip HT, VHT, HE, EHT and SAE H2E only BSS membership
+		 * selectors since they're not rates.
 		 *
 		 * Note: Even though the membership selector and the basic
 		 *	 rate flag share the same bit, they are not exactly
@@ -3912,6 +3912,7 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 		if (supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HT_PHY) ||
 		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_VHT_PHY) ||
 		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HE_PHY) ||
+		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_EHT_PHY) ||
 		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_SAE_H2E))
 			continue;
 
-- 
2.38.1

