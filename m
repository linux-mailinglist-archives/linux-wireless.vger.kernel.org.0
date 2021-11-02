Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4170F442813
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 08:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKBHSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 03:18:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:22772 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhKBHSi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 03:18:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="218394175"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="218394175"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 00:16:04 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="638100013"
Received: from egrumbac-mobl1.jer.intel.com ([10.13.16.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 00:16:03 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] iwlwifi: mvm: read the rfkill state and feed it to iwlmei
Date:   Tue,  2 Nov 2021 09:15:49 +0200
Message-Id: <20211102071549.5833-6-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102071549.5833-1-emmanuel.grumbach@intel.com>
References: <20211102071549.5833-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read the rfkill state upon boot, mac start and mac stop.

Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 8 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 3 +++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9a666cc259f4..20422e640059 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1148,6 +1148,8 @@ static int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 	ret = __iwl_mvm_mac_start(mvm);
 	mutex_unlock(&mvm->mutex);
 
+	iwl_mvm_mei_set_sw_rfkill_state(mvm);
+
 	return ret;
 }
 
@@ -1265,6 +1267,8 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	 */
 	flush_work(&mvm->roc_done_wk);
 
+	iwl_mvm_mei_set_sw_rfkill_state(mvm);
+
 	mutex_lock(&mvm->mutex);
 	__iwl_mvm_mac_stop(mvm);
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 34b4a280a293..64ff2395800c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2218,10 +2218,14 @@ static inline void iwl_mvm_mei_device_down(struct iwl_mvm *mvm)
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
index 82fea029d4d0..3ab0217abeea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -756,6 +756,9 @@ static int iwl_mvm_start_post_nvm(struct iwl_mvm *mvm)
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

