Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4FC2876CA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgJHPKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:10:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54498 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730898AbgJHPKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:10:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYN-002Qut-DI; Thu, 08 Oct 2020 18:09:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:45 +0300
Message-Id: <iwlwifi.20201008180656.71b441c8b682.Ia1d216cb680308b91d6da9f73e23ae9f4baac79f@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/13] iwlwifi: mvm: prepare roc_done_wk to work sync
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

As part of changes made to properly support auxiliary activities in CDB
NICs, an aux sta will be added when using hot spot 2.0 and will need
to be removed when roc flow is done.
In order to do so, prepare the roc_done_wk to work synchronously as the
rm_aux_sta is a SYNC command.

Since now all of th iwl_mvm_flush_sta function are using it sync,
removed the flag argument from the function.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 ++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  6 +++---
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 21 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 10 ++++-----
 6 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d56458ab5634..79770b78122d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1223,12 +1223,6 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 
 	/* async_handlers_wk is now blocked */
 
-	/*
-	 * The work item could be running or queued if the
-	 * ROC time event stops just as we get here.
-	 */
-	flush_work(&mvm->roc_done_wk);
-
 	iwl_mvm_rm_aux_sta(mvm);
 
 	iwl_mvm_stop_device(mvm);
@@ -1284,6 +1278,12 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
 	cancel_delayed_work_sync(&mvm->scan_timeout_dwork);
 
+	/*
+	 * The work item could be running or queued if the
+	 * ROC time event stops just as we get here.
+	 */
+	flush_work(&mvm->roc_done_wk);
+
 	mutex_lock(&mvm->mutex);
 	__iwl_mvm_mac_stop(mvm);
 	mutex_unlock(&mvm->mutex);
@@ -4738,7 +4738,7 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 		WARN_ON(i != mvmvif->ap_sta_id && !sta->tdls);
 
 		if (drop) {
-			if (iwl_mvm_flush_sta(mvm, mvmsta, false, 0))
+			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
 				IWL_ERR(mvm, "flush request fail\n");
 		} else {
 			msk |= mvmsta->tfd_queue_msk;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e54bbf6965f4..7159d1da3e77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1528,7 +1528,7 @@ const char *iwl_mvm_get_tx_fail_reason(u32 status);
 static inline const char *iwl_mvm_get_tx_fail_reason(u32 status) { return ""; }
 #endif
 int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk, u32 flags);
-int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal, u32 flags);
+int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal);
 int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id,
 			   u16 tids, u32 flags);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 2eb5b2c9da13..4b2dcd60d496 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1856,7 +1856,7 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		return ret;
 
 	/* flush its queues here since we are freeing mvm_sta */
-	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false, 0);
+	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false);
 	if (ret)
 		return ret;
 	if (iwl_mvm_has_new_tx_api(mvm)) {
@@ -2188,7 +2188,7 @@ static void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->bcast_sta, true, 0);
+	iwl_mvm_flush_sta(mvm, &mvmvif->bcast_sta, true);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
@@ -2437,7 +2437,7 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->mcast_sta, true, 0);
+	iwl_mvm_flush_sta(mvm, &mvmvif->mcast_sta, true);
 
 	iwl_mvm_disable_txq(mvm, NULL, mvmvif->cab_queue, 0, 0);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 8abb57012240..3a57a260081a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -116,14 +114,9 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 	 * event finishes or is canceled, so that frames queued for it
 	 * won't get stuck on the queue and be transmitted in the next
 	 * time event.
-	 * We have to send the command asynchronously since this cannot
-	 * be under the mutex for locking reasons, but that's not an
-	 * issue as it will have to complete before the next command is
-	 * executed, and a new time event means a new command.
 	 */
-	iwl_mvm_flush_sta(mvm, &mvm->aux_sta, true, CMD_ASYNC);
 
-	/* Do the same for the P2P device queue (STA) */
+	mutex_lock(&mvm->mutex);
 	if (test_and_clear_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status)) {
 		struct iwl_mvm_vif *mvmvif;
 
@@ -136,10 +129,14 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 
 		if (!WARN_ON(!mvm->p2p_device_vif)) {
 			mvmvif = iwl_mvm_vif_from_mac80211(mvm->p2p_device_vif);
-			iwl_mvm_flush_sta(mvm, &mvmvif->bcast_sta, true,
-					  CMD_ASYNC);
+			iwl_mvm_flush_sta(mvm, &mvmvif->bcast_sta, true);
 		}
+	} else {
+		/* do the same in case of hot spot 2.0 */
+		iwl_mvm_flush_sta(mvm, &mvm->aux_sta, true);
 	}
+
+	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_roc_finished(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index d5ce0f9d3a85..340c892b30ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -349,6 +349,8 @@ static void check_exit_ctkill(struct work_struct *work)
 
 	duration = tt->params.ct_kill_duration;
 
+	flush_work(&mvm->roc_done_wk);
+
 	mutex_lock(&mvm->mutex);
 
 	if (__iwl_mvm_mac_start(mvm))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 8f347f2256b4..12e5d00ef5cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2059,7 +2059,7 @@ int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id,
 	return ret;
 }
 
-int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal, u32 flags)
+int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal)
 {
 	struct iwl_mvm_int_sta *int_sta = sta;
 	struct iwl_mvm_sta *mvm_sta = sta;
@@ -2068,12 +2068,10 @@ int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal, u32 flags)
 		     offsetof(struct iwl_mvm_sta, sta_id));
 
 	if (iwl_mvm_has_new_tx_api(mvm))
-		return iwl_mvm_flush_sta_tids(mvm, mvm_sta->sta_id,
-					      0xffff, flags);
+		return iwl_mvm_flush_sta_tids(mvm, mvm_sta->sta_id, 0xffff, 0);
 
 	if (internal)
-		return iwl_mvm_flush_tx_path(mvm, int_sta->tfd_queue_msk,
-					     flags);
+		return iwl_mvm_flush_tx_path(mvm, int_sta->tfd_queue_msk, 0);
 
-	return iwl_mvm_flush_tx_path(mvm, mvm_sta->tfd_queue_msk, flags);
+	return iwl_mvm_flush_tx_path(mvm, mvm_sta->tfd_queue_msk, 0);
 }
-- 
2.28.0

