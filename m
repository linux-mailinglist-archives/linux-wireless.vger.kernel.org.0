Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED96BE5FC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 10:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCQJxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCQJxf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 05:53:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF875D47C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LFB0j2KP9ERqotivwZEO6FJvpOxOFYM17LytJnQIxak=;
        t=1679046812; x=1680256412; b=j7KLV9jFJMVVhdyUBMYeJu49r8uo1GuAH1DQIhLOtThTU4r
        0UjWEJseFl0+a1hgEb5+bIGtmEBVyLUvNbOiGSuE0uetED1BG/zXzwyTty6RQ5yaRfS9nIP7v9B4M
        HMSvcI+0jBj1E5nklKzulupY1p6fGVKXLt7M8q7zRaomHolWHONLpFiO7JQ2pRg7UJYA4YuhkXHsr
        TX6HfIPksrVwLGtdf0pq85LxmYanGBF5f7l/xjBuniY6u4si9SAqZN9H4JqYoO7PMkWEsLydkSm/q
        zUHFQ6bB41BMnG/QKpDMx6oqVi88W+EEROncSTEJ18qEz9VqekHDVkZ9w2oXgAAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pd6m8-0066kS-1Q;
        Fri, 17 Mar 2023 10:53:28 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH 2/2] wifi: iwlwifi: mvm: protect TXQ list manipulation
Date:   Fri, 17 Mar 2023 10:53:25 +0100
Message-Id: <20230317105323.71199222c725.Ife6276980e699d6d8dc0307bfd3a87b36c3e02d0@changeid>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317105323.3893cb26df9d.I68fc8d1a16a7c6927ac92fe855ada741acb9fe14@changeid>
References: <20230317105323.3893cb26df9d.I68fc8d1a16a7c6927ac92fe855ada741acb9fe14@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some recent upstream debugging uncovered the fact that in
iwlwifi, the TXQ list manipulation is racy.

Introduce a new state bit for when the TXQ is completely
ready and can be used without locking, and if that's not
set yet acquire the lock to check everything correctly.

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Tested-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 45 ++++++-------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 25 +++++++++--
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index af6d5c55c31e..b92f298f8032 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -810,42 +810,25 @@ static void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_txq *mvmtxq = iwl_mvm_txq_from_mac80211(txq);
 
-	/*
-	 * Please note that racing is handled very carefully here:
-	 * mvmtxq->txq_id is updated during allocation, and mvmtxq->list is
-	 * deleted afterwards.
-	 * This means that if:
-	 * mvmtxq->txq_id != INVALID_QUEUE && list_empty(&mvmtxq->list):
-	 *	queue is allocated and we can TX.
-	 * mvmtxq->txq_id != INVALID_QUEUE && !list_empty(&mvmtxq->list):
-	 *	a race, should defer the frame.
-	 * mvmtxq->txq_id == INVALID_QUEUE && list_empty(&mvmtxq->list):
-	 *	need to allocate the queue and defer the frame.
-	 * mvmtxq->txq_id == INVALID_QUEUE && !list_empty(&mvmtxq->list):
-	 *	queue is already scheduled for allocation, no need to allocate,
-	 *	should defer the frame.
-	 */
-
-	/* If the queue is allocated TX and return. */
-	if (!txq->sta || mvmtxq->txq_id != IWL_MVM_INVALID_QUEUE) {
-		/*
-		 * Check that list is empty to avoid a race where txq_id is
-		 * already updated, but the queue allocation work wasn't
-		 * finished
-		 */
-		if (unlikely(txq->sta && !list_empty(&mvmtxq->list)))
-			return;
-
+	if (likely(test_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state)) ||
+	    !txq->sta) {
 		iwl_mvm_mac_itxq_xmit(hw, txq);
 		return;
 	}
 
+	/* iwl_mvm_mac_itxq_xmit() will later be called by the worker
+	 * to handle any packets we leave on the txq now
+	 */
+
+	spin_lock_bh(&mvm->add_stream_lock);
 	/* The list is being deleted only after the queue is fully allocated. */
-	if (!list_empty(&mvmtxq->list))
-		return;
-
-	list_add_tail(&mvmtxq->list, &mvm->add_stream_txqs);
-	schedule_work(&mvm->add_stream_wk);
+	if (list_empty(&mvmtxq->list) &&
+	    /* recheck under lock */
+	    !test_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state)) {
+		list_add_tail(&mvmtxq->list, &mvm->add_stream_txqs);
+		schedule_work(&mvm->add_stream_wk);
+	}
+	spin_unlock_bh(&mvm->add_stream_lock);
 }
 
 #define CHECK_BA_TRIGGER(_mvm, _trig, _tid_bm, _tid, _fmt...)		\
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 569cf13bb03a..5c2da0f67d98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -734,6 +734,7 @@ struct iwl_mvm_txq {
 	atomic_t tx_request;
 #define IWL_MVM_TXQ_STATE_STOP_FULL	0
 #define IWL_MVM_TXQ_STATE_STOP_REDIRECT	1
+#define IWL_MVM_TXQ_STATE_READY		2
 	unsigned long state;
 };
 
@@ -863,6 +864,7 @@ struct iwl_mvm {
 		struct iwl_mvm_tvqm_txq_info tvqm_info[IWL_MAX_TVQM_QUEUES];
 	};
 	struct work_struct add_stream_wk; /* To add streams to queues */
+	spinlock_t add_stream_lock;
 
 	const char *nvm_file_name;
 	struct iwl_nvm_data *nvm_data;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 467da97bd2fa..72b465690540 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1213,6 +1213,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	INIT_DELAYED_WORK(&mvm->scan_timeout_dwork, iwl_mvm_scan_timeout_wk);
 	INIT_WORK(&mvm->add_stream_wk, iwl_mvm_add_new_dqa_stream_wk);
 	INIT_LIST_HEAD(&mvm->add_stream_txqs);
+	spin_lock_init(&mvm->add_stream_lock);
 
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 0f5697f0df50..facf831b048d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -401,8 +401,11 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		struct iwl_mvm_txq *mvmtxq =
 			iwl_mvm_txq_from_tid(sta, tid);
 
-		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		spin_lock_bh(&mvm->add_stream_lock);
 		list_del_init(&mvmtxq->list);
+		clear_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		spin_unlock_bh(&mvm->add_stream_lock);
 	}
 
 	/* Regardless if this is a reserved TXQ for a STA - mark it as false */
@@ -496,8 +499,11 @@ static int iwl_mvm_remove_sta_queue_marking(struct iwl_mvm *mvm, int queue)
 			disable_agg_tids |= BIT(tid);
 		mvmsta->tid_data[tid].txq_id = IWL_MVM_INVALID_QUEUE;
 
-		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		spin_lock_bh(&mvm->add_stream_lock);
 		list_del_init(&mvmtxq->list);
+		clear_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		spin_unlock_bh(&mvm->add_stream_lock);
 	}
 
 	mvmsta->tfd_queue_msk &= ~BIT(queue); /* Don't use this queue anymore */
@@ -1465,12 +1471,22 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 		 * a queue in the function itself.
 		 */
 		if (iwl_mvm_sta_alloc_queue(mvm, txq->sta, txq->ac, tid)) {
+			spin_lock_bh(&mvm->add_stream_lock);
 			list_del_init(&mvmtxq->list);
+			spin_unlock_bh(&mvm->add_stream_lock);
 			continue;
 		}
 
-		list_del_init(&mvmtxq->list);
+		/* now we're ready, any remaining races/concurrency will be
+		 * handled in iwl_mvm_mac_itxq_xmit()
+		 */
+		set_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+
 		local_bh_disable();
+		spin_lock(&mvm->add_stream_lock);
+		list_del_init(&mvmtxq->list);
+		spin_unlock(&mvm->add_stream_lock);
+
 		iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
 		local_bh_enable();
 	}
@@ -1891,8 +1907,11 @@ static void iwl_mvm_disable_sta_queues(struct iwl_mvm *mvm,
 		struct iwl_mvm_txq *mvmtxq =
 			iwl_mvm_txq_from_mac80211(sta->txq[i]);
 
+		spin_lock_bh(&mvm->add_stream_lock);
 		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
 		list_del_init(&mvmtxq->list);
+		clear_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		spin_unlock_bh(&mvm->add_stream_lock);
 	}
 }
 
-- 
2.39.2

