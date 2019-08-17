Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7E90D7E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfHQGwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 02:52:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36388 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbfHQGwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 02:52:45 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hysZa-0006XT-Nl; Sat, 17 Aug 2019 09:52:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 17 Aug 2019 09:51:52 +0300
Message-Id: <20190817065200.9701-15-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190817065200.9701-1-luca@coelho.fi>
References: <20190817065200.9701-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 14/22] iwlwifi: mvm: remove the tx defer for d0i3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is not needed anymore

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 45 +------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 63 -------------------
 3 files changed, 1 insertion(+), 111 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b815d2b0b2ad..cb99a07ad689 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -742,42 +742,6 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	return ret;
 }
 
-static bool iwl_mvm_defer_tx(struct iwl_mvm *mvm,
-			     struct ieee80211_sta *sta,
-			     struct sk_buff *skb)
-{
-	struct iwl_mvm_sta *mvmsta;
-	bool defer = false;
-
-	/*
-	 * double check the IN_D0I3 flag both before and after
-	 * taking the spinlock, in order to prevent taking
-	 * the spinlock when not needed.
-	 */
-	if (likely(!test_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status)))
-		return false;
-
-	spin_lock(&mvm->d0i3_tx_lock);
-	/*
-	 * testing the flag again ensures the skb dequeue
-	 * loop (on d0i3 exit) hasn't run yet.
-	 */
-	if (!test_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status))
-		goto out;
-
-	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	if (mvmsta->sta_id == IWL_MVM_INVALID_STA ||
-	    mvmsta->sta_id != mvm->d0i3_ap_sta_id)
-		goto out;
-
-	__skb_queue_tail(&mvm->d0i3_tx, skb);
-
-	defer = true;
-out:
-	spin_unlock(&mvm->d0i3_tx_lock);
-	return defer;
-}
-
 static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 			   struct ieee80211_tx_control *control,
 			   struct sk_buff *skb)
@@ -822,8 +786,6 @@ static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 	}
 
 	if (sta) {
-		if (iwl_mvm_defer_tx(mvm, sta, skb))
-			return;
 		if (iwl_mvm_tx_skb(mvm, skb, sta))
 			goto drop;
 		return;
@@ -1156,9 +1118,6 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 		 * would do.
 		 */
 		clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status);
-#ifdef CONFIG_PM
-		iwl_mvm_d0i3_enable_tx(mvm, NULL);
-#endif
 	}
 
 	return ret;
@@ -1196,9 +1155,7 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 	mutex_lock(&mvm->mutex);
 
 	clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status);
-#ifdef CONFIG_PM
-	iwl_mvm_d0i3_enable_tx(mvm, NULL);
-#endif
+
 	ret = iwl_mvm_update_quotas(mvm, true, NULL);
 	if (ret)
 		IWL_ERR(mvm, "Failed to update quotas after restart (%d)\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 245e8c721102..6a79b6c49cd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1019,12 +1019,9 @@ struct iwl_mvm {
 	u8 d0i3_ap_sta_id;
 	bool d0i3_offloading;
 	struct work_struct d0i3_exit_work;
-	struct sk_buff_head d0i3_tx;
 	/* protect d0i3_suspend_flags */
 	struct mutex d0i3_suspend_mutex;
 	unsigned long d0i3_suspend_flags;
-	/* sync d0i3_tx queue and IWL_MVM_STATUS_IN_D0I3 status flag */
-	spinlock_t d0i3_tx_lock;
 	wait_queue_head_t d0i3_exit_waitq;
 	wait_queue_head_t rx_sync_waitq;
 
@@ -1861,7 +1858,6 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			       u32 cmd_flags);
 
 #ifdef CONFIG_PM
-void iwl_mvm_d0i3_enable_tx(struct iwl_mvm *mvm, __le16 *qos_seq);
 int iwl_mvm_enter_d0i3(struct iwl_op_mode *op_mode);
 int iwl_mvm_exit_d0i3(struct iwl_op_mode *op_mode);
 int _iwl_mvm_exit_d0i3(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 255b402f7b19..e9b0aee38f35 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -713,8 +713,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	INIT_WORK(&mvm->add_stream_wk, iwl_mvm_add_new_dqa_stream_wk);
 	INIT_LIST_HEAD(&mvm->add_stream_txqs);
 
-	spin_lock_init(&mvm->d0i3_tx_lock);
-	skb_queue_head_init(&mvm->d0i3_tx);
 	init_waitqueue_head(&mvm->d0i3_exit_waitq);
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
@@ -1590,62 +1588,6 @@ static void iwl_mvm_d0i3_exit_work_iter(void *_data, u8 *mac,
 		iwl_mvm_d0i3_update_keys(data->mvm, vif, data->status);
 }
 
-void iwl_mvm_d0i3_enable_tx(struct iwl_mvm *mvm, __le16 *qos_seq)
-{
-	struct ieee80211_sta *sta = NULL;
-	struct iwl_mvm_sta *mvm_ap_sta;
-	int i;
-	bool wake_queues = false;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	spin_lock_bh(&mvm->d0i3_tx_lock);
-
-	if (mvm->d0i3_ap_sta_id == IWL_MVM_INVALID_STA)
-		goto out;
-
-	IWL_DEBUG_RPM(mvm, "re-enqueue packets\n");
-
-	/* get the sta in order to update seq numbers and re-enqueue skbs */
-	sta = rcu_dereference_protected(
-			mvm->fw_id_to_mac_id[mvm->d0i3_ap_sta_id],
-			lockdep_is_held(&mvm->mutex));
-
-	if (IS_ERR_OR_NULL(sta)) {
-		sta = NULL;
-		goto out;
-	}
-
-	if (mvm->d0i3_offloading && qos_seq) {
-		/* update qos seq numbers if offloading was enabled */
-		mvm_ap_sta = iwl_mvm_sta_from_mac80211(sta);
-		for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
-			u16 seq = le16_to_cpu(qos_seq[i]);
-			/* firmware stores last-used one, we store next one */
-			seq += 0x10;
-			mvm_ap_sta->tid_data[i].seq_number = seq;
-		}
-	}
-out:
-	/* re-enqueue (or drop) all packets */
-	while (!skb_queue_empty(&mvm->d0i3_tx)) {
-		struct sk_buff *skb = __skb_dequeue(&mvm->d0i3_tx);
-
-		if (!sta || iwl_mvm_tx_skb(mvm, skb, sta))
-			ieee80211_free_txskb(mvm->hw, skb);
-
-		/* if the skb_queue is not empty, we need to wake queues */
-		wake_queues = true;
-	}
-	clear_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status);
-	wake_up(&mvm->d0i3_exit_waitq);
-	mvm->d0i3_ap_sta_id = IWL_MVM_INVALID_STA;
-	if (wake_queues)
-		ieee80211_wake_queues(mvm->hw);
-
-	spin_unlock_bh(&mvm->d0i3_tx_lock);
-}
-
 static void iwl_mvm_d0i3_exit_work(struct work_struct *wk)
 {
 	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm, d0i3_exit_work);
@@ -1655,7 +1597,6 @@ static void iwl_mvm_d0i3_exit_work(struct work_struct *wk)
 
 	struct iwl_wowlan_status *status;
 	u32 wakeup_reasons = 0;
-	__le16 *qos_seq = NULL;
 
 	mutex_lock(&mvm->mutex);
 
@@ -1667,7 +1608,6 @@ static void iwl_mvm_d0i3_exit_work(struct work_struct *wk)
 	}
 
 	wakeup_reasons = le32_to_cpu(status->wakeup_reasons);
-	qos_seq = status->qos_seq_ctr;
 
 	IWL_DEBUG_RPM(mvm, "wakeup reasons: 0x%x\n", wakeup_reasons);
 
@@ -1678,12 +1618,9 @@ static void iwl_mvm_d0i3_exit_work(struct work_struct *wk)
 					    iwl_mvm_d0i3_exit_work_iter,
 					    &iter_data);
 out:
-	iwl_mvm_d0i3_enable_tx(mvm, qos_seq);
-
 	IWL_DEBUG_INFO(mvm, "d0i3 exit completed (wakeup reasons: 0x%x)\n",
 		       wakeup_reasons);
 
-	/* qos_seq might point inside resp_pkt, so free it only now */
 	kfree(status);
 
 	/* the FW might have updated the regdomain */
-- 
2.23.0.rc1

