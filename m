Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C025A926DB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfHSOfo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 10:35:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36866 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726627AbfHSOfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 10:35:44 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzikw-0007sP-NX; Mon, 19 Aug 2019 17:35:35 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 17:35:04 +0300
Message-Id: <20190819143507.6989-20-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819143507.6989-1-luca@coelho.fi>
References: <20190819143507.6989-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 19/22] iwlwifi: mvm: remove last leftovers of d0i3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We're now left with a status bit that is never set and a few
other leftovers.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 7 -------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 7 -------
 3 files changed, 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f4aa121f36f8..e49558fb8aa3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1079,9 +1079,6 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 
 	ieee80211_wake_queues(mvm->hw);
 
-	/* clear any stale d0i3 state */
-	clear_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status);
-
 	mvm->vif_count = 0;
 	mvm->rx_ba_sessions = 0;
 	mvm->fwrt.dump.conf = FW_DBG_INVALID;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 15780e994a30..ed52e2ea97d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -588,11 +588,6 @@ struct iwl_mvm_frame_stats {
 	int last_frame_idx;
 };
 
-enum {
-	D0I3_DEFER_WAKEUP,
-	D0I3_PENDING_WAKEUP,
-};
-
 #define IWL_MVM_DEBUG_SET_TEMPERATURE_DISABLE 0xff
 #define IWL_MVM_DEBUG_SET_TEMPERATURE_MIN -100
 #define IWL_MVM_DEBUG_SET_TEMPERATURE_MAX 200
@@ -1157,7 +1152,6 @@ struct iwl_mvm {
  * @IWL_MVM_STATUS_ROC_RUNNING: remain-on-channel is running
  * @IWL_MVM_STATUS_HW_RESTART_REQUESTED: HW restart was requested
  * @IWL_MVM_STATUS_IN_HW_RESTART: HW restart is active
- * @IWL_MVM_STATUS_IN_D0I3: NIC is in D0i3
  * @IWL_MVM_STATUS_ROC_AUX_RUNNING: AUX remain-on-channel is running
  * @IWL_MVM_STATUS_FIRMWARE_RUNNING: firmware is running
  * @IWL_MVM_STATUS_NEED_FLUSH_P2P: need to flush P2P bcast STA
@@ -1168,7 +1162,6 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_ROC_RUNNING,
 	IWL_MVM_STATUS_HW_RESTART_REQUESTED,
 	IWL_MVM_STATUS_IN_HW_RESTART,
-	IWL_MVM_STATUS_IN_D0I3,
 	IWL_MVM_STATUS_ROC_AUX_RUNNING,
 	IWL_MVM_STATUS_FIRMWARE_RUNNING,
 	IWL_MVM_STATUS_NEED_FLUSH_P2P,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index b0f92c9b20f0..aa0a2a3e0875 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2759,13 +2759,6 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	spin_lock_bh(&mvmsta->lock);
 
-	/* possible race condition - we entered D0i3 while starting agg */
-	if (test_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status)) {
-		spin_unlock_bh(&mvmsta->lock);
-		IWL_ERR(mvm, "Entered D0i3 while starting Tx agg\n");
-		return -EIO;
-	}
-
 	/*
 	 * Note the possible cases:
 	 *  1. An enabled TXQ - TXQ needs to become agg'ed
-- 
2.23.0.rc1

