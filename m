Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F86C0F0D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCTKgl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCTKgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:36:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25324BD6
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308544; x=1710844544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oj/yfpqexRIdLF7U/8KJn3aZr2+qeIz31WDdwpcSSnI=;
  b=ebi7GrUtoLN1BNmJqMJ9N8lwGIx4mfeaL83B93K7dE7Z9SXBWJXKJ2+c
   0LUxH0/KtL1i0C+hrFzUKxq1k5tP3DKjiCm+AcCOzWuK5MXkJSXwEcIvM
   qcrjmlCixBwRN5v1Wt7xoUxSRRBm9X631he151IjIQwsshh3rzftTSYRE
   zLZZBpLuj0thanQhwWnnp8cxUU63eKaNQxB7FkwY8ZnOfu4g3guJv4YBd
   b5wG9SW5Hk5RmR8xdURBsPthTPu5d3+KrnVoSg4ZZsQtcU5pmEVbVGBCA
   qZ/a8kdAof8zR8eWNlHW05WZrxCzbK4DrJSbUbb0P8IKxXSIZBSGAWg8C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997961"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997961"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523709"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523709"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/18] wifi: iwlwifi: mvm: support enabling and disabling HW timestamping
Date:   Mon, 20 Mar 2023 12:33:18 +0200
Message-Id: <20230320122330.62b98fbf545b.I450c1017ada7900a71a63d879bb542a08e3166c8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Instead of enabling HW timestamping by default every time a station
is connected, disable it by default and enable it only upon request
for a specific station. HW timestamping can be enabled for only one
peer at a time.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  7 ++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 29 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  8 -----
 .../wireless/intel/iwlwifi/mvm/time-sync.c    | 13 +++------
 .../wireless/intel/iwlwifi/mvm/time-sync.h    |  4 +--
 .../chromeOS/adjustments/024-time-sync.spatch |  6 ++++
 6 files changed, 47 insertions(+), 20 deletions(-)
 create mode 100644 intc-scripts/chromeOS/adjustments/024-time-sync.spatch

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4079c0d939c1..05236b09bcdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -21,6 +21,7 @@
 #include "iwl-phy-db.h"
 #include "iwl-modparams.h"
 #include "iwl-nvm-parse.h"
+#include "time-sync.h"
 
 #define MVM_UCODE_ALIVE_TIMEOUT	(HZ)
 #define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
@@ -1666,8 +1667,12 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 			goto error;
 	}
 
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		iwl_mvm_send_recovery_cmd(mvm, ERROR_RECOVERY_UPDATE_DB);
+		iwl_mvm_time_sync_config(mvm, mvm->time_sync.peer_addr,
+					 IWL_TIME_SYNC_PROTOCOL_TM |
+					 IWL_TIME_SYNC_PROTOCOL_FTM);
+	}
 
 	if (!mvm->ptp_data.ptp_clock)
 		iwl_mvm_ptp_init(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6e059027517f..33582f4eea91 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -28,6 +28,7 @@
 #include "fw/error-dump.h"
 #include "iwl-prph.h"
 #include "iwl-nvm-parse.h"
+#include "time-sync.h"
 
 static const struct ieee80211_iface_limit iwl_mvm_limits[] = {
 	{
@@ -416,6 +417,10 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT);
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_TIME_SYNC_BOTH_FTM_TM))
+		hw->wiphy->hw_timestamp_max_peers = 1;
+
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	hw->wiphy->features |=
 		NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
@@ -5765,6 +5770,29 @@ static bool iwl_mvm_mac_can_aggregate(struct ieee80211_hw *hw,
 	return iwl_mvm_can_hw_csum(skb) == iwl_mvm_can_hw_csum(head);
 }
 
+static int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct cfg80211_set_hw_timestamp *hwts)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	u32 protocols = 0;
+	int ret;
+
+	/* HW timestamping is only supported for a specific station */
+	if (!hwts->macaddr)
+		return -EOPNOTSUPP;
+
+	if (hwts->enable)
+		protocols =
+			IWL_TIME_SYNC_PROTOCOL_TM | IWL_TIME_SYNC_PROTOCOL_FTM;
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_time_sync_config(mvm, hwts->macaddr, protocols);
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
+}
+
 const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -5853,4 +5881,5 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.sta_add_debugfs = iwl_mvm_sta_add_debugfs,
 #endif
+	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 7d9d4e85b548..ec843f1b0165 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -9,7 +9,6 @@
 #include "mvm.h"
 #include "sta.h"
 #include "rs.h"
-#include "time-sync.h"
 
 /*
  * New version of ADD_STA_sta command added new fields at the end of the
@@ -1793,11 +1792,6 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		}
 	}
 
-	if (!sta->tdls)
-		iwl_mvm_time_sync_config(mvm, sta->addr,
-					 IWL_TIME_SYNC_PROTOCOL_TM |
-					 IWL_TIME_SYNC_PROTOCOL_FTM);
-
 	rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
 
 	return 0;
@@ -1987,8 +1981,6 @@ static bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	spin_lock_bh(&mvm_sta->lock);
 	spin_unlock_bh(&mvm_sta->lock);
 
-	iwl_mvm_time_sync_sta_rm(mvm, sta);
-
 	return false;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
index 434d27a44dea..edae3e24192b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
@@ -125,7 +125,7 @@ void iwl_mvm_time_sync_msmt_confirm_event(struct iwl_mvm *mvm,
 	ieee80211_tx_status_ext(mvm->hw, &status);
 }
 
-int iwl_mvm_time_sync_config(struct iwl_mvm *mvm, u8 *addr, u32 protocols)
+int iwl_mvm_time_sync_config(struct iwl_mvm *mvm, const u8 *addr, u32 protocols)
 {
 	struct iwl_time_sync_cfg_cmd cmd = {};
 	int err;
@@ -166,13 +166,8 @@ int iwl_mvm_time_sync_config(struct iwl_mvm *mvm, u8 *addr, u32 protocols)
 		IWL_DEBUG_INFO(mvm, "Time sync: set peer addr=%pM\n", addr);
 	}
 
-	return err;
-}
+	if (!mvm->time_sync.active)
+		skb_queue_purge(&mvm->time_sync.frame_list);
 
-void iwl_mvm_time_sync_sta_rm(struct iwl_mvm *mvm, struct ieee80211_sta *sta)
-{
-	/* Disable time sync with this station */
-	iwl_mvm_time_sync_config(mvm, sta->addr, 0);
-
-	skb_queue_purge(&mvm->time_sync.frame_list);
+	return err;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h
index c43d1d0b25cb..2cfd0fb5e781 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h
@@ -13,8 +13,8 @@ void iwl_mvm_time_sync_msmt_event(struct iwl_mvm *mvm,
 				  struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_time_sync_msmt_confirm_event(struct iwl_mvm *mvm,
 					  struct iwl_rx_cmd_buffer *rxb);
-int iwl_mvm_time_sync_config(struct iwl_mvm *mvm, u8 *addr, u32 protocols);
-void iwl_mvm_time_sync_sta_rm(struct iwl_mvm *mvm, struct ieee80211_sta *sta);
+int iwl_mvm_time_sync_config(struct iwl_mvm *mvm, const u8 *addr,
+			     u32 protocols);
 
 static inline
 bool iwl_mvm_time_sync_frame(struct iwl_mvm *mvm, struct sk_buff *skb, u8 *addr)
diff --git a/intc-scripts/chromeOS/adjustments/024-time-sync.spatch b/intc-scripts/chromeOS/adjustments/024-time-sync.spatch
new file mode 100644
index 000000000000..425e4700b343
--- /dev/null
+++ b/intc-scripts/chromeOS/adjustments/024-time-sync.spatch
@@ -0,0 +1,6 @@
+@@
+struct ieee80211_hw *hw;
+expression val;
+@@
+-hw->wiphy->hw_timestamp_max_peers = val
++hw_timestamp_max_peers(hw)
-- 
2.38.1

