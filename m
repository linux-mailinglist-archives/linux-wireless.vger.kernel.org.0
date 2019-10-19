Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4DDD7E1
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfJSKDl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 06:03:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50518 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbfJSKDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 06:03:41 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlaE-0002jL-DX; Sat, 19 Oct 2019 13:03:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 13:03:29 +0300
Message-Id: <20191019100331.21322-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019100331.21322-1-luca@coelho.fi>
References: <20191019100331.21322-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 3/5] iwlwifi: mvm: handle iwl_mvm_tvqm_enable_txq() error return
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

iwl_mvm_tvqm_enable_txq() can return an error, notably if unable
to allocate memory for the queue. Handle this error throughout,
avoiding storing the invalid value into a u16 which later leads
to a disable of an invalid queue ("queue 65524 not used", where
65524 is just -ENOMEM in a u16).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 140 +++++++++++--------
 1 file changed, 83 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 0bedba4c61f2..b3768d5d852a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1482,6 +1482,13 @@ static void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 					    mvm_sta->sta_id, i);
 			txq_id = iwl_mvm_tvqm_enable_txq(mvm, mvm_sta->sta_id,
 							 i, wdg);
+			/*
+			 * on failures, just set it to IWL_MVM_INVALID_QUEUE
+			 * to try again later, we have no other good way of
+			 * failing here
+			 */
+			if (txq_id < 0)
+				txq_id = IWL_MVM_INVALID_QUEUE;
 			tid_data->txq_id = txq_id;
 
 			/*
@@ -1950,30 +1957,73 @@ void iwl_mvm_dealloc_int_sta(struct iwl_mvm *mvm, struct iwl_mvm_int_sta *sta)
 	sta->sta_id = IWL_MVM_INVALID_STA;
 }
 
-static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 *queue,
+static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
 					  u8 sta_id, u8 fifo)
 {
 	unsigned int wdg_timeout = iwlmvm_mod_params.tfd_q_hang_detect ?
 		mvm->trans->trans_cfg->base_params->wd_timeout :
 		IWL_WATCHDOG_DISABLED;
+	struct iwl_trans_txq_scd_cfg cfg = {
+		.fifo = fifo,
+		.sta_id = sta_id,
+		.tid = IWL_MAX_TID_COUNT,
+		.aggregate = false,
+		.frame_limit = IWL_FRAME_LIMIT,
+	};
+
+	WARN_ON(iwl_mvm_has_new_tx_api(mvm));
+
+	iwl_mvm_enable_txq(mvm, NULL, queue, 0, &cfg, wdg_timeout);
+}
+
+static int iwl_mvm_enable_aux_snif_queue_tvqm(struct iwl_mvm *mvm, u8 sta_id)
+{
+	unsigned int wdg_timeout = iwlmvm_mod_params.tfd_q_hang_detect ?
+		mvm->trans->trans_cfg->base_params->wd_timeout :
+		IWL_WATCHDOG_DISABLED;
+
+	WARN_ON(!iwl_mvm_has_new_tx_api(mvm));
+
+	return iwl_mvm_tvqm_enable_txq(mvm, sta_id, IWL_MAX_TID_COUNT,
+				       wdg_timeout);
+}
 
+static int iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
+					  int maccolor,
+					  struct iwl_mvm_int_sta *sta,
+					  u16 *queue, int fifo)
+{
+	int ret;
+
+	/* Map queue to fifo - needs to happen before adding station */
+	if (!iwl_mvm_has_new_tx_api(mvm))
+		iwl_mvm_enable_aux_snif_queue(mvm, *queue, sta->sta_id, fifo);
+
+	ret = iwl_mvm_add_int_sta_common(mvm, sta, NULL, macidx, maccolor);
+	if (ret) {
+		if (!iwl_mvm_has_new_tx_api(mvm))
+			iwl_mvm_disable_txq(mvm, NULL, *queue,
+					    IWL_MAX_TID_COUNT, 0);
+		return ret;
+	}
+
+	/*
+	 * For 22000 firmware and on we cannot add queue to a station unknown
+	 * to firmware so enable queue here - after the station was added
+	 */
 	if (iwl_mvm_has_new_tx_api(mvm)) {
-		int tvqm_queue =
-			iwl_mvm_tvqm_enable_txq(mvm, sta_id,
-						IWL_MAX_TID_COUNT,
-						wdg_timeout);
-		*queue = tvqm_queue;
-	} else {
-		struct iwl_trans_txq_scd_cfg cfg = {
-			.fifo = fifo,
-			.sta_id = sta_id,
-			.tid = IWL_MAX_TID_COUNT,
-			.aggregate = false,
-			.frame_limit = IWL_FRAME_LIMIT,
-		};
+		int txq;
 
-		iwl_mvm_enable_txq(mvm, NULL, *queue, 0, &cfg, wdg_timeout);
+		txq = iwl_mvm_enable_aux_snif_queue_tvqm(mvm, sta->sta_id);
+		if (txq < 0) {
+			iwl_mvm_rm_sta_common(mvm, sta->sta_id);
+			return txq;
+		}
+
+		*queue = txq;
 	}
+
+	return 0;
 }
 
 int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm)
@@ -1989,59 +2039,26 @@ int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
-	/* Map Aux queue to fifo - needs to happen before adding Aux station */
-	if (!iwl_mvm_has_new_tx_api(mvm))
-		iwl_mvm_enable_aux_snif_queue(mvm, &mvm->aux_queue,
-					      mvm->aux_sta.sta_id,
-					      IWL_MVM_TX_FIFO_MCAST);
-
-	ret = iwl_mvm_add_int_sta_common(mvm, &mvm->aux_sta, NULL,
-					 MAC_INDEX_AUX, 0);
+	ret = iwl_mvm_add_int_sta_with_queue(mvm, MAC_INDEX_AUX, 0,
+					     &mvm->aux_sta, &mvm->aux_queue,
+					     IWL_MVM_TX_FIFO_MCAST);
 	if (ret) {
 		iwl_mvm_dealloc_int_sta(mvm, &mvm->aux_sta);
 		return ret;
 	}
 
-	/*
-	 * For 22000 firmware and on we cannot add queue to a station unknown
-	 * to firmware so enable queue here - after the station was added
-	 */
-	if (iwl_mvm_has_new_tx_api(mvm))
-		iwl_mvm_enable_aux_snif_queue(mvm, &mvm->aux_queue,
-					      mvm->aux_sta.sta_id,
-					      IWL_MVM_TX_FIFO_MCAST);
-
 	return 0;
 }
 
 int iwl_mvm_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	/* Map snif queue to fifo - must happen before adding snif station */
-	if (!iwl_mvm_has_new_tx_api(mvm))
-		iwl_mvm_enable_aux_snif_queue(mvm, &mvm->snif_queue,
-					      mvm->snif_sta.sta_id,
+	return iwl_mvm_add_int_sta_with_queue(mvm, mvmvif->id, mvmvif->color,
+					      &mvm->snif_sta, &mvm->snif_queue,
 					      IWL_MVM_TX_FIFO_BE);
-
-	ret = iwl_mvm_add_int_sta_common(mvm, &mvm->snif_sta, vif->addr,
-					 mvmvif->id, 0);
-	if (ret)
-		return ret;
-
-	/*
-	 * For 22000 firmware and on we cannot add queue to a station unknown
-	 * to firmware so enable queue here - after the station was added
-	 */
-	if (iwl_mvm_has_new_tx_api(mvm))
-		iwl_mvm_enable_aux_snif_queue(mvm, &mvm->snif_queue,
-					      mvm->snif_sta.sta_id,
-					      IWL_MVM_TX_FIFO_BE);
-
-	return 0;
 }
 
 int iwl_mvm_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -2133,6 +2150,10 @@ int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		queue = iwl_mvm_tvqm_enable_txq(mvm, bsta->sta_id,
 						IWL_MAX_TID_COUNT,
 						wdg_timeout);
+		if (queue < 0) {
+			iwl_mvm_rm_sta_common(mvm, bsta->sta_id);
+			return queue;
+		}
 
 		if (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_ADHOC)
@@ -2307,10 +2328,8 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	}
 	ret = iwl_mvm_add_int_sta_common(mvm, msta, maddr,
 					 mvmvif->id, mvmvif->color);
-	if (ret) {
-		iwl_mvm_dealloc_int_sta(mvm, msta);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	/*
 	 * Enable cab queue after the ADD_STA command is sent.
@@ -2323,6 +2342,10 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		int queue = iwl_mvm_tvqm_enable_txq(mvm, msta->sta_id,
 						    0,
 						    timeout);
+		if (queue < 0) {
+			ret = queue;
+			goto err;
+		}
 		mvmvif->cab_queue = queue;
 	} else if (!fw_has_api(&mvm->fw->ucode_capa,
 			       IWL_UCODE_TLV_API_STA_TYPE))
@@ -2330,6 +2353,9 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 				   timeout);
 
 	return 0;
+err:
+	iwl_mvm_dealloc_int_sta(mvm, msta);
+	return ret;
 }
 
 static int __iwl_mvm_remove_sta_key(struct iwl_mvm *mvm, u8 sta_id,
-- 
2.23.0

