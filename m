Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693163F1D06
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhHSPld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56948 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240640AbhHSPld (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9t-002Hje-UO; Thu, 19 Aug 2021 18:40:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:34 +0300
Message-Id: <iwlwifi.20210819183728.8c147659b331.If5924375e9bfd46214ab8ab81cb9d0f5c82fbcbc@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819154035.72584-1-luca@coelho.fi>
References: <20210819154035.72584-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/11] iwlwifi: mvm: don't schedule the roc_done_wk if it is already running
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When P2P roc is removed, the IWL_MVM_STATUS_NEED_FLUSH_P2P bit is set
to indicate to iwl_mvm_roc_done_wk() that the removed roc is a P2P
one, so it will flush the broadcast station and not the aux station.

However, since setting this bit and scheduling the worker is done
in roc ended flow as well as in case the roc is removed, there is
a race where the worker has already started running (but did not
test this bit yet) and then it is scheduled again. In this case,
the first run of the worker will clear this bit, and thus the second
run will find it already cleared and will try to flush and remove
the aux station by mistake.

Fix it by scheduling the worker only if this bit is not yet set. In
case this bit is already set, the worker is either running or
scheduled, so there is no need to re-schedule it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 788fd2b84ed2..25af88a3edce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -256,6 +256,18 @@ static void iwl_mvm_te_check_trigger(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_p2p_roc_finished(struct iwl_mvm *mvm)
+{
+	/*
+	 * If the IWL_MVM_STATUS_NEED_FLUSH_P2P is already set, then the
+	 * roc_done_wk is already scheduled or running, so don't schedule it
+	 * again to avoid a race where the roc_done_wk clears this bit after
+	 * it is set here, affecting the next run of the roc_done_wk.
+	 */
+	if (!test_and_set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status))
+		iwl_mvm_roc_finished(mvm);
+}
+
 /*
  * Handles a FW notification for an event that is known to the driver.
  *
@@ -307,8 +319,7 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 		switch (te_data->vif->type) {
 		case NL80211_IFTYPE_P2P_DEVICE:
 			ieee80211_remain_on_channel_expired(mvm->hw);
-			set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
-			iwl_mvm_roc_finished(mvm);
+			iwl_mvm_p2p_roc_finished(mvm);
 			break;
 		case NL80211_IFTYPE_STATION:
 			/*
@@ -684,8 +695,7 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 			/* Session protection is still ongoing. Cancel it */
 			iwl_mvm_cancel_session_protection(mvm, mvmvif, id);
 			if (iftype == NL80211_IFTYPE_P2P_DEVICE) {
-				set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
-				iwl_mvm_roc_finished(mvm);
+				iwl_mvm_p2p_roc_finished(mvm);
 			}
 		}
 		return false;
@@ -852,8 +862,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
 		ieee80211_remain_on_channel_expired(mvm->hw);
-		set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
-		iwl_mvm_roc_finished(mvm);
+		iwl_mvm_p2p_roc_finished(mvm);
 	} else if (le32_to_cpu(notif->start)) {
 		if (WARN_ON(mvmvif->time_event_data.id !=
 				le32_to_cpu(notif->conf_id)))
@@ -1014,14 +1023,13 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 			iwl_mvm_cancel_session_protection(mvm, mvmvif,
 							  mvmvif->time_event_data.id);
-			set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
+			iwl_mvm_p2p_roc_finished(mvm);
 		} else {
 			iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
 						  &mvmvif->time_event_data);
+			iwl_mvm_roc_finished(mvm);
 		}
 
-		iwl_mvm_roc_finished(mvm);
-
 		return;
 	}
 
@@ -1035,12 +1043,11 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		iwl_mvm_remove_time_event(mvm, mvmvif, te_data);
-		set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
+		iwl_mvm_p2p_roc_finished(mvm);
 	} else {
 		iwl_mvm_remove_aux_roc_te(mvm, mvmvif, te_data);
+		iwl_mvm_roc_finished(mvm);
 	}
-
-	iwl_mvm_roc_finished(mvm);
 }
 
 void iwl_mvm_remove_csa_period(struct iwl_mvm *mvm,
-- 
2.33.0

