Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F97368C9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjFTKF0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFTKFD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:05:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C324AFC
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255502; x=1718791502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdS3BSvrC78Kiq9y11Yq6Qqn3cNHk8MO3fJN/GEvEXM=;
  b=RByzsHEW16jTmXtCrNk3gEfoyxq+ztzTkYaIVMsXnOn8FFW8DHBHiqEt
   LDS4vkSr9x/xAsIQoE6KY3Bp+hGSBPwM9EH5bWxOilC9E5UTDPMkPbEgk
   zPz8Il9wYamZjOBK4kuvq3vSMYRZb1Z6WwJvSN2iRpg3qEE3MLvY/Ce8y
   FvrpW657E131D+X5KrwO27nM5CR0CdIYtw9aZcEk1xUoNTIMgc11KX1kQ
   1eMpFaAX9DswZXvH6cD0UX7zlS4jSxsfUQaaPfRy4PnyNylfEl/X8dnxp
   2iHDFzwTdqrb00yP7OCEN00K+kaY0JD4xxKo23g9Uz3eoGMOyjOHT38rA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819673"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819673"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143607"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143607"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:05:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/19] wifi: iwlwifi: mvm: adjust skip-over-dtim in D3
Date:   Tue, 20 Jun 2023 13:04:04 +0300
Message-Id: <20230620125813.32406b6828ae.I88c315b85f7c56ac6109f84580b95a3dd104ff6c@changeid>
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

The current formula can skip both too much and not enough time,
given the +1 (where the comment about firmware is wrong). Adjust
the formula accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 34d4b7a94d82..9131b5f1bc76 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -327,12 +327,11 @@ static void iwl_mvm_power_config_skip_dtim(struct iwl_mvm *mvm,
 
 		if (WARN_ON(!dtimper_tu))
 			return;
-		/* configure skip over dtim up to 306TU - 314 msec */
-		skip = max_t(u8, 1, 306 / dtimper_tu);
+		/* configure skip over dtim up to 900 TU DTIM interval */
+		skip = max_t(u8, 1, 900 / dtimper_tu);
 	}
 
-	/* the firmware really expects "look at every X DTIMs", so add 1 */
-	cmd->skip_dtim_periods = 1 + skip;
+	cmd->skip_dtim_periods = skip;
 	cmd->flags |= cpu_to_le16(POWER_FLAGS_SKIP_OVER_DTIM_MSK);
 }
 
-- 
2.38.1

