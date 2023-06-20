Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD67368BE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjFTKFE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFTKEk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13F10A
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255478; x=1718791478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MmYfxIqr99KMnXM6VI3ZDp89DhhLHh4P8n783TZGI2E=;
  b=ZVH45XM6dbkTwmCPiNILocq9E6zOSgvE73LwCxlVUVSs52iCw3pator0
   jYwrJfCo65W+f6JxyM3sogJP8Q9qYHNZj74hZvJ5dR4G9XBlHXNAeKA1u
   HCeYo7FvGwlOZSZA1UDJfprwjOUGgHpt2RPT38HsYIudhs+6JPD5B4MGM
   ZE5vquKMuMOlRxLejdXPYnQzKiOQ2BZkB8OZmrpM5fx7kGjoWJQpgW8jO
   t1AkvrcmTVkGluRVQCeWoey7Y8giKjNPAgSxwBCXo5TG9YzbPZtF0ZpSt
   7jlr+jSRWTLE0JJepjF9yRLGhekrgpNkhLBse1NzbBnothEIMQiSdJInI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819598"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819598"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143394"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143394"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:35 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/19] wifi: iwlwifi: mvm: use min_t() for agg_size
Date:   Tue, 20 Jun 2023 13:03:54 +0300
Message-Id: <20230620125813.211768036c1f.I78b7eea32eaae20cc9f32869aa3f42814634ce9a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can use min_t() for the agg_size and avoid
spelling out the (firmware) limit twice.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ff1ce990a9d8..3c24b25fe661 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -92,9 +92,8 @@ u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_link_sta *link_sta,
 				    IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
 
 	/* Limit to max A-MPDU supported by FW */
-	if (agg_size > (STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT))
-		agg_size = (STA_FLG_MAX_AGG_SIZE_4M >>
-			    STA_FLG_MAX_AGG_SIZE_SHIFT);
+	agg_size = min_t(u32, agg_size,
+			 STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT);
 
 	*_agg_size = agg_size;
 	return mpdu_dens;
-- 
2.38.1

