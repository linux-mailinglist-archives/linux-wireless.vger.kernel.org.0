Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A627B1FC8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjI1Oge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjI1Oga (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA21B6
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911787; x=1727447787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ynZuRgpIjSHnKLlrFmMVxUWKvuMbw2fkHYfGUFJo+tU=;
  b=QpQu0uy3CVbKBY7LYlN+K+Tuc8qQlU0/W9mI1YLrX1UHhq4MIJRhgOAb
   vfon12USLcoW8d/JdR+y8ZTHa+JvV+L37GjF1tkrly/3jnPEx1dLrkg8t
   EZDlRNqsh+IX6ZOHze5MGGZHNa9Xg+uCsKZ1jU3X2IKxIjuUYjE+Cu4+K
   EVZIhq+qpaR6egBWGeG+mlso4Jzwh5vPq1t6rcGO5Wos70OYi6fn8btjp
   4xXortI8ujykf0cxx5tiK8GIdu/cjvj6eFPTkOtgE63/UONEr5kJJoAXu
   /sPZV2ai6JIfllknNhjgh8xh88nanizMLDJWRgSPpdy5qio+HbIsQgZCp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688503"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688503"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590526"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590526"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/18] wifi: mac80211: make mgd_protect_tdls_discover MLO-aware
Date:   Thu, 28 Sep 2023 17:35:35 +0300
Message-Id: <20230928172905.ef12ce3eb835.If864f406cfd9e24f36a2b88fd13a37328633fcf9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Since userspace can choose now what link to establish the
TDLS on, we should know on what channel to do session protection.
Add a link id parameter to this callback.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 5 +++--
 include/net/mac80211.h                        | 3 ++-
 net/mac80211/driver-ops.h                     | 8 ++++++--
 net/mac80211/tdls.c                           | 2 +-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 66d9de0f1511..74cb2f863472 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2345,7 +2345,8 @@ void iwl_mvm_teardown_tdls_peers(struct iwl_mvm *mvm);
 void iwl_mvm_recalc_tdls_state(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			       bool sta_added);
 void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif);
+					   struct ieee80211_vif *vif,
+					   unsigned int link_id);
 int iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta, u8 oper_class,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index dae6f2a1aad9..fac992af3ddb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2022 Intel Corporation
+ * Copyright (C) 2018-2020, 2022-2023 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include "mvm.h"
@@ -144,7 +144,8 @@ void iwl_mvm_recalc_tdls_state(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 }
 
 void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif)
+					   struct ieee80211_vif *vif,
+					   unsigned int link_id)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u32 duration = 2 * vif->bss_conf.dtim_period * vif->bss_conf.beacon_int;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index db3e3bd62a61..c839a04ad9db 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4525,7 +4525,8 @@ struct ieee80211_ops {
 				   struct ieee80211_prep_tx_info *info);
 
 	void	(*mgd_protect_tdls_discover)(struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif);
+					     struct ieee80211_vif *vif,
+					     unsigned int link_id);
 
 	int (*add_chanctx)(struct ieee80211_hw *hw,
 			   struct ieee80211_chanctx_conf *ctx);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 3c8eb6afd6fd..568633b38c47 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -956,7 +956,8 @@ static inline void drv_mgd_complete_tx(struct ieee80211_local *local,
 
 static inline void
 drv_mgd_protect_tdls_discover(struct ieee80211_local *local,
-			      struct ieee80211_sub_if_data *sdata)
+			      struct ieee80211_sub_if_data *sdata,
+			      int link_id)
 {
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -965,9 +966,12 @@ drv_mgd_protect_tdls_discover(struct ieee80211_local *local,
 		return;
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
+	link_id = link_id > 0 ? link_id : 0;
+
 	trace_drv_mgd_protect_tdls_discover(local, sdata);
 	if (local->ops->mgd_protect_tdls_discover)
-		local->ops->mgd_protect_tdls_discover(&local->hw, &sdata->vif);
+		local->ops->mgd_protect_tdls_discover(&local->hw, &sdata->vif,
+						      link_id);
 	trace_drv_return_void(local);
 }
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f3fd66d30b84..05a7dff69fe9 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1318,7 +1318,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 		 * response frame. It is transmitted directly and not buffered
 		 * by the AP.
 		 */
-		drv_mgd_protect_tdls_discover(sdata->local, sdata);
+		drv_mgd_protect_tdls_discover(sdata->local, sdata, link_id);
 		fallthrough;
 	case WLAN_TDLS_SETUP_CONFIRM:
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
-- 
2.38.1

