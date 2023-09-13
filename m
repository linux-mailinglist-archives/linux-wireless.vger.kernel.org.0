Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA379E75D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjIML6J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbjIML6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:58:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98301996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606284; x=1726142284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6yH5au2yssJCGbjvy/6afac2gABFbi/CJ1aYqgO39E=;
  b=bawwlTBp6mTbuzzk9cnQVZ8uQSHzyWNlx7MxouGRAKLSrEOdg90Bk5rB
   m1kk+0m84wbydYvNVOOivi0Gz/aRdj+4pJ2cMqBl/N2Qyr3T/od67PWUx
   4yLm+MShU0SYplsUx6GS4uczmkZcoQSJa681IqKNFuZPO91ZoIiNS4XjA
   mLlW3uLTwY8px5iNkYhgAUydnK46oqz51800EEzyamp5jQ4ys8CYqe8rD
   mjN+fQztKY7omX6TBudDC4Am26K2PAB1Ohghm7/ih0vHLbTL9MFkuAWda
   oFjV0Mmn9QQQiHns0NaHYmfWhkpuhFmWk/jNKROLvJZGciMiEaTlYGOQL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903102"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903102"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470988"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470988"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: move listen interval to constants
Date:   Wed, 13 Sep 2023 14:56:50 +0300
Message-Id: <20230913145231.59823deebfda.Ied68b11ca40771d1cfc8c82ee8f9f2b9ea27da65@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This can be moved to constants, while at it also rename
it to have a better name with MVM_ prefix.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 243eccc68cb0..59df2bf6327c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -60,6 +60,7 @@
 #define IWL_MVM_UAPSD_NONAGG_PERIOD		5000 /* msecs */
 #define IWL_MVM_UAPSD_NOAGG_LIST_LEN		IWL_MVM_UAPSD_NOAGG_BSSIDS_NUM
 #define IWL_MVM_NON_TRANSMITTING_AP		0
+#define IWL_MVM_CONN_LISTEN_INTERVAL		10
 #define IWL_MVM_RS_NUM_TRY_BEFORE_ANT_TOGGLE    1
 #define IWL_MVM_RS_HT_VHT_RETRIES_PER_RATE      2
 #define IWL_MVM_RS_HT_VHT_RETRIES_PER_RATE_TW   1
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c7e31a60d9df..6fc5b3f22746 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -522,7 +522,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		ARRAY_SIZE(iwl_mvm_iface_combinations);
 
 	hw->wiphy->max_remain_on_channel_duration = 10000;
-	hw->max_listen_interval = IWL_CONN_MAX_LISTEN_INTERVAL;
+	hw->max_listen_interval = IWL_MVM_CONN_LISTEN_INTERVAL;
 
 	/* Extract MAC address */
 	memcpy(mvm->addresses[0].addr, mvm->nvm_data->hw_addr, ETH_ALEN);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a68d9f7a5547..8c1f6aa2bc70 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -137,7 +137,6 @@ enum iwl_power_scheme {
 	IWL_POWER_SCHEME_LP
 };
 
-#define IWL_CONN_MAX_LISTEN_INTERVAL	10
 #define IWL_UAPSD_MAX_SP		IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-- 
2.38.1

