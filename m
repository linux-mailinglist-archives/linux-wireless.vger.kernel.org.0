Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A376E3D6FB5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhG0Gv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 02:51:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:21763 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235675AbhG0Gvz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 02:51:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212104842"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212104842"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="505368842"
Received: from lgeva1-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.198.250])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:54 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     egrumbach@gmail.com,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v5 7/7] iwlwifi: mvm: read the rfkill state and feed it to iwlmei
Date:   Tue, 27 Jul 2021 09:51:34 +0300
Message-Id: <20210727065134.3902-7-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
References: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove the corresponding vendor command as well.
Read the rfkill state upon boot, mac start and mac stop.

Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 8 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 3 +++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 463af179f439..48d3253a3f50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1147,6 +1147,8 @@ static int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 	ret = __iwl_mvm_mac_start(mvm);
 	mutex_unlock(&mvm->mutex);
 
+	iwl_mvm_mei_set_sw_rfkill_state(mvm);
+
 	return ret;
 }
 
@@ -1264,6 +1266,8 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	 */
 	flush_work(&mvm->roc_done_wk);
 
+	iwl_mvm_mei_set_sw_rfkill_state(mvm);
+
 	mutex_lock(&mvm->mutex);
 	__iwl_mvm_mac_stop(mvm);
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bd8e00ae15fb..a9e9113c6b39 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2210,10 +2210,14 @@ static inline void iwl_mvm_mei_device_down(struct iwl_mvm *mvm)
 		iwl_mei_device_down();
 }
 
-static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm, bool sw_rfkill)
+static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm)
 {
+	bool sw_rfkill =
+		mvm->hw_registered ? rfkill_blocked(mvm->hw->wiphy->rfkill) : false;
+
 	if (mvm->mei_registered)
-		iwl_mei_set_rfkill_state(iwl_mvm_is_radio_killed(mvm), sw_rfkill);
+		iwl_mei_set_rfkill_state(iwl_mvm_is_radio_killed(mvm),
+					 sw_rfkill);
 }
 
 void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9898e1a72c7c..98ea986d75f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -753,6 +753,9 @@ static int iwl_mvm_start_post_nvm(struct iwl_mvm *mvm)
 	wiphy_rfkill_set_hw_state_reason(mvm->hw->wiphy,
 					 mvm->mei_rfkill_blocked,
 					 RFKILL_HARD_BLOCK_NOT_OWNER);
+
+	iwl_mvm_mei_set_sw_rfkill_state(mvm);
+
 	return 0;
 }
 
-- 
2.25.1

