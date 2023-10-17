Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD457CBEBE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjJQJRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjJQJRP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F6ED
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534233; x=1729070233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1iRDnZogfjzDKpvHj3fNHNwkZ8GL7w5F7tsSwjdm5U=;
  b=kQi40u0ItbsCf94apqny3N9yQD83ZXjKx5G0UwclMsnSvxf2G9AB4UP4
   3+nHsg7CLrJkSlq4/2erltSGT/LgtNXhQewAVMxxx7UEPy8UEux5z3GWD
   GMb4rclqCQhF8Mu/L4lFt4imJUuNvJXnoIIj66zqMmTEsuGqxQLc2yvlQ
   iMUVOQQgRJkOLu5mjvxFBvamDj+bazRmt3z7aV2I/UAhCZDuqPjq2IqBa
   r786NMpf9itI8rXqHwofSDVhLOWMyMpkZ6tj2hxlGn73i+g9e1bOhK6nI
   hNUztlXZF1DIk0VZR818WALtnAJzLf59gmuYIYn76YZPT+6XYfakm3iwz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808529"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808529"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731888"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731888"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: mvm: remove set_tim callback for MLD ops
Date:   Tue, 17 Oct 2023 12:16:40 +0300
Message-Id: <20231017115047.1a1ded96ffc2.Ie49d3004acdd6299fb84346c76b2b2b2f195196b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
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

In new firmware, we don't need this any more and it won't
be called any more by mac80211, since powersave handling
is all done by firmware. Remove it from the MLD ops.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          | 2 --
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 38ee1629ec4b..c1c9cdf49a41 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5273,8 +5273,8 @@ int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw)
 	return mvm->ibss_manager;
 }
 
-int iwl_mvm_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
-		    bool set)
+static int iwl_mvm_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			   bool set)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8402482a74a0..407b34a224c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1266,8 +1266,6 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 
 	.tx_last_beacon = iwl_mvm_tx_last_beacon,
 
-	.set_tim = iwl_mvm_set_tim,
-
 	.channel_switch = iwl_mvm_channel_switch,
 	.pre_channel_switch = iwl_mvm_pre_channel_switch,
 	.post_channel_switch = iwl_mvm_post_channel_switch,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0bd2a8bcaee5..385bbeca4796 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2688,8 +2688,6 @@ void iwl_mvm_remove_chanctx(struct ieee80211_hw *hw,
 void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 			    struct ieee80211_chanctx_conf *ctx, u32 changed);
 int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw);
-int iwl_mvm_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
-		    bool set);
 void iwl_mvm_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_channel_switch *chsw);
 int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
-- 
2.38.1

