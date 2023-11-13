Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1657E9914
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 10:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjKMJgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 04:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjKMJgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 04:36:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DED10F4
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699868164; x=1731404164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fcy1GRs9ak3XVJEIToWskIyyxHg66/NuBosaj+yP2AY=;
  b=Mil1ot7fT4NFWw6X0qVaJ3XiX6rBhw1c9phk7RNkrg8Xcntola+eO06w
   xMXFTU3Vt8VlIvvs0fiiPTX5+FZhTqN+HML+e4gi4uFdK1dqmHlkWg+Rv
   nRfjfDxlVTfjy+UYM6J8x4HAy2Xo9NPZ6Erf3prvB8j69Yk6m0b51nnV8
   dzhF401L+CU7Z02kVUc3a2VxD8k1HuD1DgqCQ6AQEPAyVSd2kM/AfqQsU
   LiTlYw4y65zaoHauaIDx228D2/IhQ1HOj/rXd3ZaGKKFwXqBIS9fhI2te
   sXS5L/5RIj6TPLixAvsAahBM1FOXPitSZjEpaV19yIRBs/T4Q8VoEgx/R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369735750"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369735750"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937695297"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937695297"
Received: from tdistelf-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.220.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:36:02 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 6/6] wifi: mac80211_hwsim: Add custom reg for DFS concurrent
Date:   Mon, 13 Nov 2023 11:35:05 +0200
Message-Id: <20231113112844.560597906f17.Ic285ca7a4728e77a4bea1394a6a52cf286fbea22@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231113093505.456824-1-gregory.greenman@intel.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Add custom regulatory that marks DFS channels as DFS_CONCURRENT.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index c7b4414cc6c3..3816b0d335f0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -190,10 +190,25 @@ static const struct ieee80211_regdomain hwsim_world_regdom_custom_03 = {
 	}
 };
 
+static const struct ieee80211_regdomain hwsim_world_regdom_custom_04 = {
+	.n_reg_rules = 6,
+	.alpha2 =  "99",
+	.reg_rules = {
+		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
+		REG_RULE(2484 - 10, 2484 + 10, 40, 0, 20, 0),
+		REG_RULE(5150 - 10, 5240 + 10, 80, 0, 30, 0),
+		REG_RULE(5260 - 10, 5320 + 10, 80, 0, 30,
+			 NL80211_RRF_DFS_CONCURRENT | NL80211_RRF_DFS),
+		REG_RULE(5745 - 10, 5825 + 10, 80, 0, 30, 0),
+		REG_RULE(5855 - 10, 5925 + 10, 80, 0, 33, 0),
+	}
+};
+
 static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 	&hwsim_world_regdom_custom_01,
 	&hwsim_world_regdom_custom_02,
 	&hwsim_world_regdom_custom_03,
+	&hwsim_world_regdom_custom_04,
 };
 
 struct hwsim_vif_priv {
@@ -5288,6 +5303,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		schedule_timeout_interruptible(1);
 	}
 
+	/* TODO: Add param */
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_DFS_CONCURRENT);
+
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
 
-- 
2.38.1

