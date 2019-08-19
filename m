Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6080794AE4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfHSQus (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:50:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37108 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727995AbfHSQus (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:50:48 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrQ-0007zi-Ma; Mon, 19 Aug 2019 19:50:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:50:00 +0300
Message-Id: <20190819165007.10181-16-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 15/22] iwlwifi: mvm: remove the d0i3 entry/exit flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 111 +-----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  14 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  35 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 350 ------------------
 4 files changed, 2 insertions(+), 508 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 7493cae70ea6..2ddc6cc56d1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1118,37 +1118,12 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int iwl_mvm_enter_d0i3_sync(struct iwl_mvm *mvm)
-{
-	struct iwl_notification_wait wait_d3;
-	static const u16 d3_notif[] = { D3_CONFIG_CMD };
-	int ret;
-
-	iwl_init_notification_wait(&mvm->notif_wait, &wait_d3,
-				   d3_notif, ARRAY_SIZE(d3_notif),
-				   NULL, NULL);
-
-	ret = iwl_mvm_enter_d0i3(mvm->hw->priv);
-	if (ret)
-		goto remove_notif;
-
-	ret = iwl_wait_notification(&mvm->notif_wait, &wait_d3, HZ);
-	WARN_ON_ONCE(ret);
-	return ret;
-
-remove_notif:
-	iwl_remove_notification(&mvm->notif_wait, &wait_d3);
-	return ret;
-}
-
 int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_trans *trans = mvm->trans;
 	int ret;
 
-	/* make sure the d0i3 exit work is not pending */
-	flush_work(&mvm->d0i3_exit_work);
 	iwl_mvm_pause_tcm(mvm, true);
 
 	iwl_fw_runtime_suspend(&mvm->fwrt);
@@ -1157,25 +1132,6 @@ int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	if (ret)
 		return ret;
 
-	if (wowlan->any) {
-		trans->system_pm_mode = IWL_PLAT_PM_MODE_D0I3;
-
-		if (iwl_mvm_enter_d0i3_on_suspend(mvm)) {
-			ret = iwl_mvm_enter_d0i3_sync(mvm);
-
-			if (ret)
-				return ret;
-		}
-
-		mutex_lock(&mvm->d0i3_suspend_mutex);
-		__set_bit(D0I3_DEFER_WAKEUP, &mvm->d0i3_suspend_flags);
-		mutex_unlock(&mvm->d0i3_suspend_mutex);
-
-		iwl_trans_d3_suspend(trans, false, false);
-
-		return 0;
-	}
-
 	trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
 
 	return __iwl_mvm_suspend(hw, wowlan, false);
@@ -1751,30 +1707,6 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	return false;
 }
 
-void iwl_mvm_d0i3_update_keys(struct iwl_mvm *mvm,
-			      struct ieee80211_vif *vif,
-			      struct iwl_wowlan_status *status)
-{
-	struct iwl_mvm_d3_gtk_iter_data gtkdata = {
-		.mvm = mvm,
-		.status = status,
-	};
-
-	/*
-	 * rekey handling requires taking locks that can't be taken now.
-	 * however, d0i3 doesn't offload rekey, so we're fine.
-	 */
-	if (WARN_ON_ONCE(status->num_of_gtk_rekeys))
-		return;
-
-	/* find last GTK that we used initially, if any */
-	gtkdata.find_phase = true;
-	iwl_mvm_iter_d0i3_ap_keys(mvm, vif, iwl_mvm_d3_update_keys, &gtkdata);
-
-	gtkdata.find_phase = false;
-	iwl_mvm_iter_d0i3_ap_keys(mvm, vif, iwl_mvm_d3_update_keys, &gtkdata);
-}
-
 #define ND_QUERY_BUF_LEN (sizeof(struct iwl_scan_offload_profile_match) * \
 			  IWL_SCAN_MAX_PROFILES)
 
@@ -2125,53 +2057,12 @@ static int iwl_mvm_resume_d3(struct iwl_mvm *mvm)
 	return __iwl_mvm_resume(mvm, false);
 }
 
-static int iwl_mvm_resume_d0i3(struct iwl_mvm *mvm)
-{
-	bool exit_now;
-	enum iwl_d3_status d3_status;
-	struct iwl_trans *trans = mvm->trans;
-
-	iwl_trans_d3_resume(trans, &d3_status, false, false);
-
-	/*
-	 * make sure to clear D0I3_DEFER_WAKEUP before
-	 * calling iwl_trans_resume(), which might wait
-	 * for d0i3 exit completion.
-	 */
-	mutex_lock(&mvm->d0i3_suspend_mutex);
-	__clear_bit(D0I3_DEFER_WAKEUP, &mvm->d0i3_suspend_flags);
-	exit_now = __test_and_clear_bit(D0I3_PENDING_WAKEUP,
-					&mvm->d0i3_suspend_flags);
-	mutex_unlock(&mvm->d0i3_suspend_mutex);
-	if (exit_now) {
-		IWL_DEBUG_RPM(mvm, "Run deferred d0i3 exit\n");
-		_iwl_mvm_exit_d0i3(mvm);
-	}
-
-	iwl_trans_resume(trans);
-
-	if (iwl_mvm_enter_d0i3_on_suspend(mvm)) {
-		int ret = iwl_mvm_exit_d0i3(mvm->hw->priv);
-
-		if (ret)
-			return ret;
-		/*
-		 * d0i3 exit will be deferred until reconfig_complete.
-		 * make sure there we are out of d0i3.
-		 */
-	}
-	return 0;
-}
-
 int iwl_mvm_resume(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
 
-	if (mvm->trans->system_pm_mode == IWL_PLAT_PM_MODE_D0I3)
-		ret = iwl_mvm_resume_d0i3(mvm);
-	else
-		ret = iwl_mvm_resume_d3(mvm);
+	ret = iwl_mvm_resume_d3(mvm);
 
 	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index cb99a07ad689..2a246f69229d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1128,19 +1128,6 @@ static int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
 
-	/* Some hw restart cleanups must not hold the mutex */
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
-		/*
-		 * Make sure we are out of d0i3. This is needed
-		 * to make sure the reference accounting is correct
-		 * (and there is no stale d0i3_exit_work).
-		 */
-		wait_event_timeout(mvm->d0i3_exit_waitq,
-				   !test_bit(IWL_MVM_STATUS_IN_D0I3,
-					     &mvm->status),
-				   HZ);
-	}
-
 	mutex_lock(&mvm->mutex);
 	ret = __iwl_mvm_mac_start(mvm);
 	mutex_unlock(&mvm->mutex);
@@ -1244,7 +1231,6 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	flush_work(&mvm->d0i3_exit_work);
 	flush_work(&mvm->async_handlers_wk);
 	flush_work(&mvm->add_stream_wk);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6a79b6c49cd5..2cf5d31ad3ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1017,12 +1017,7 @@ struct iwl_mvm {
 
 	/* d0i3 */
 	u8 d0i3_ap_sta_id;
-	bool d0i3_offloading;
-	struct work_struct d0i3_exit_work;
-	/* protect d0i3_suspend_flags */
-	struct mutex d0i3_suspend_mutex;
-	unsigned long d0i3_suspend_flags;
-	wait_queue_head_t d0i3_exit_waitq;
+
 	wait_queue_head_t rx_sync_waitq;
 
 	/* BT-Coex */
@@ -1290,19 +1285,6 @@ static inline bool iwl_mvm_is_short_beacon_notif_supported(struct iwl_mvm *mvm)
 			  IWL_UCODE_TLV_API_SHORT_BEACON_NOTIF);
 }
 
-static inline bool iwl_mvm_enter_d0i3_on_suspend(struct iwl_mvm *mvm)
-{
-	/* For now we only use this mode to differentiate between
-	 * slave transports, which handle D0i3 entry in suspend by
-	 * themselves in conjunction with runtime PM D0i3.  So, this
-	 * function is used to check whether we need to do anything
-	 * when entering suspend or if the transport layer has already
-	 * done it.
-	 */
-	return (mvm->trans->system_pm_mode == IWL_PLAT_PM_MODE_D0I3) &&
-		(mvm->trans->runtime_pm_mode != IWL_PLAT_PM_MODE_D0I3);
-}
-
 static inline bool iwl_mvm_is_dqa_data_queue(struct iwl_mvm *mvm, u8 queue)
 {
 	return (queue >= IWL_MVM_DQA_MIN_DATA_QUEUE) &&
@@ -1824,9 +1806,6 @@ int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif,
 				     bool host_awake,
 				     u32 cmd_flags);
-void iwl_mvm_d0i3_update_keys(struct iwl_mvm *mvm,
-			      struct ieee80211_vif *vif,
-			      struct iwl_wowlan_status *status);
 void iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 #else
@@ -1838,12 +1817,6 @@ static inline int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	return 0;
 }
 
-static inline void iwl_mvm_d0i3_update_keys(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif,
-					    struct iwl_wowlan_status *status)
-{
-}
-
 static inline void
 iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
@@ -1857,12 +1830,6 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			       bool offload_ns,
 			       u32 cmd_flags);
 
-#ifdef CONFIG_PM
-int iwl_mvm_enter_d0i3(struct iwl_op_mode *op_mode);
-int iwl_mvm_exit_d0i3(struct iwl_op_mode *op_mode);
-int _iwl_mvm_exit_d0i3(struct iwl_mvm *mvm);
-#endif
-
 /* BT Coex */
 int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm);
 void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e9b0aee38f35..efd694fd8b79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -516,9 +516,6 @@ static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 
 /* this forward declaration can avoid to export the function */
 static void iwl_mvm_async_handlers_wk(struct work_struct *wk);
-#ifdef CONFIG_PM
-static void iwl_mvm_d0i3_exit_work(struct work_struct *wk);
-#endif
 
 static u32 iwl_mvm_min_backoff(struct iwl_mvm *mvm)
 {
@@ -695,7 +692,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->drop_bcn_ap_mode = true;
 
 	mutex_init(&mvm->mutex);
-	mutex_init(&mvm->d0i3_suspend_mutex);
 	spin_lock_init(&mvm->async_handlers_lock);
 	INIT_LIST_HEAD(&mvm->time_event_list);
 	INIT_LIST_HEAD(&mvm->aux_roc_te_list);
@@ -705,15 +701,11 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	INIT_WORK(&mvm->async_handlers_wk, iwl_mvm_async_handlers_wk);
 	INIT_WORK(&mvm->roc_done_wk, iwl_mvm_roc_done_wk);
-#ifdef CONFIG_PM
-	INIT_WORK(&mvm->d0i3_exit_work, iwl_mvm_d0i3_exit_work);
-#endif
 	INIT_DELAYED_WORK(&mvm->tdls_cs.dwork, iwl_mvm_tdls_ch_switch_work);
 	INIT_DELAYED_WORK(&mvm->scan_timeout_dwork, iwl_mvm_scan_timeout_wk);
 	INIT_WORK(&mvm->add_stream_wk, iwl_mvm_add_new_dqa_stream_wk);
 	INIT_LIST_HEAD(&mvm->add_stream_txqs);
 
-	init_waitqueue_head(&mvm->d0i3_exit_waitq);
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
 	atomic_set(&mvm->queue_sync_counter, 0);
@@ -909,7 +901,6 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 
 	iwl_fw_runtime_free(&mvm->fwrt);
 	mutex_destroy(&mvm->mutex);
-	mutex_destroy(&mvm->d0i3_suspend_mutex);
 
 	ieee80211_free_hw(mvm->hw);
 }
@@ -1337,346 +1328,6 @@ static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
 	iwl_mvm_nic_restart(mvm, true);
 }
 
-#ifdef CONFIG_PM
-struct iwl_d0i3_iter_data {
-	struct iwl_mvm *mvm;
-	struct ieee80211_vif *connected_vif;
-	u8 ap_sta_id;
-	u8 vif_count;
-	u8 offloading_tid;
-	bool disable_offloading;
-};
-
-static bool iwl_mvm_disallow_offloading(struct iwl_mvm *mvm,
-					struct ieee80211_vif *vif,
-					struct iwl_d0i3_iter_data *iter_data)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_sta *mvmsta;
-	u32 available_tids = 0;
-	u8 tid;
-
-	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION ||
-		    mvmvif->ap_sta_id == IWL_MVM_INVALID_STA))
-		return false;
-
-	mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, mvmvif->ap_sta_id);
-	if (!mvmsta)
-		return false;
-
-	spin_lock_bh(&mvmsta->lock);
-	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
-		struct iwl_mvm_tid_data *tid_data = &mvmsta->tid_data[tid];
-
-		/*
-		 * in case of pending tx packets, don't use this tid
-		 * for offloading in order to prevent reuse of the same
-		 * qos seq counters.
-		 */
-		if (iwl_mvm_tid_queued(mvm, tid_data))
-			continue;
-
-		if (tid_data->state != IWL_AGG_OFF)
-			continue;
-
-		available_tids |= BIT(tid);
-	}
-	spin_unlock_bh(&mvmsta->lock);
-
-	/*
-	 * disallow protocol offloading if we have no available tid
-	 * (with no pending frames and no active aggregation,
-	 * as we don't handle "holes" properly - the scheduler needs the
-	 * frame's seq number and TFD index to match)
-	 */
-	if (!available_tids)
-		return true;
-
-	/* for simplicity, just use the first available tid */
-	iter_data->offloading_tid = ffs(available_tids) - 1;
-	return false;
-}
-
-static void iwl_mvm_enter_d0i3_iterator(void *_data, u8 *mac,
-					struct ieee80211_vif *vif)
-{
-	struct iwl_d0i3_iter_data *data = _data;
-	struct iwl_mvm *mvm = data->mvm;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	u32 flags = CMD_ASYNC | CMD_HIGH_PRIO | CMD_SEND_IN_IDLE;
-
-	IWL_DEBUG_RPM(mvm, "entering D0i3 - vif %pM\n", vif->addr);
-	if (vif->type != NL80211_IFTYPE_STATION ||
-	    !vif->bss_conf.assoc)
-		return;
-
-	/*
-	 * in case of pending tx packets or active aggregations,
-	 * avoid offloading features in order to prevent reuse of
-	 * the same qos seq counters.
-	 */
-	if (iwl_mvm_disallow_offloading(mvm, vif, data))
-		data->disable_offloading = true;
-
-	iwl_mvm_update_d0i3_power_mode(mvm, vif, true, flags);
-	iwl_mvm_send_proto_offload(mvm, vif, data->disable_offloading,
-				   false, flags);
-
-	/*
-	 * on init/association, mvm already configures POWER_TABLE_CMD
-	 * and REPLY_MCAST_FILTER_CMD, so currently don't
-	 * reconfigure them (we might want to use different
-	 * params later on, though).
-	 */
-	data->ap_sta_id = mvmvif->ap_sta_id;
-	data->vif_count++;
-
-	/*
-	 * no new commands can be sent at this stage, so it's safe
-	 * to save the vif pointer during d0i3 entrance.
-	 */
-	data->connected_vif = vif;
-}
-
-static void iwl_mvm_set_wowlan_data(struct iwl_mvm *mvm,
-				    struct iwl_wowlan_config_cmd *cmd,
-				    struct iwl_d0i3_iter_data *iter_data)
-{
-	struct ieee80211_sta *ap_sta;
-	struct iwl_mvm_sta *mvm_ap_sta;
-
-	if (iter_data->ap_sta_id == IWL_MVM_INVALID_STA)
-		return;
-
-	rcu_read_lock();
-
-	ap_sta = rcu_dereference(mvm->fw_id_to_mac_id[iter_data->ap_sta_id]);
-	if (IS_ERR_OR_NULL(ap_sta))
-		goto out;
-
-	mvm_ap_sta = iwl_mvm_sta_from_mac80211(ap_sta);
-	cmd->is_11n_connection = ap_sta->ht_cap.ht_supported;
-	cmd->offloading_tid = iter_data->offloading_tid;
-	cmd->flags = ENABLE_L3_FILTERING | ENABLE_NBNS_FILTERING |
-		ENABLE_DHCP_FILTERING | ENABLE_STORE_BEACON;
-	/*
-	 * The d0i3 uCode takes care of the nonqos counters,
-	 * so configure only the qos seq ones.
-	 */
-	iwl_mvm_set_wowlan_qos_seq(mvm_ap_sta, cmd);
-out:
-	rcu_read_unlock();
-}
-
-int iwl_mvm_enter_d0i3(struct iwl_op_mode *op_mode)
-{
-	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-	u32 flags = CMD_ASYNC | CMD_HIGH_PRIO | CMD_SEND_IN_IDLE;
-	int ret;
-	struct iwl_d0i3_iter_data d0i3_iter_data = {
-		.mvm = mvm,
-	};
-	struct iwl_wowlan_config_cmd wowlan_config_cmd = {
-		.wakeup_filter = cpu_to_le32(IWL_WOWLAN_WAKEUP_RX_FRAME |
-					     IWL_WOWLAN_WAKEUP_BEACON_MISS |
-					     IWL_WOWLAN_WAKEUP_LINK_CHANGE),
-	};
-	struct iwl_d3_manager_config d3_cfg_cmd = {
-		.min_sleep_time = cpu_to_le32(1000),
-		.wakeup_flags = cpu_to_le32(IWL_WAKEUP_D3_CONFIG_FW_ERROR),
-	};
-
-	IWL_DEBUG_RPM(mvm, "MVM entering D0i3\n");
-
-	if (WARN_ON_ONCE(mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR))
-		return -EINVAL;
-
-	set_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status);
-
-	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
-						   IEEE80211_IFACE_ITER_NORMAL,
-						   iwl_mvm_enter_d0i3_iterator,
-						   &d0i3_iter_data);
-	if (d0i3_iter_data.vif_count == 1) {
-		mvm->d0i3_ap_sta_id = d0i3_iter_data.ap_sta_id;
-		mvm->d0i3_offloading = !d0i3_iter_data.disable_offloading;
-	} else {
-		WARN_ON_ONCE(d0i3_iter_data.vif_count > 1);
-		mvm->d0i3_ap_sta_id = IWL_MVM_INVALID_STA;
-		mvm->d0i3_offloading = false;
-	}
-
-	iwl_mvm_pause_tcm(mvm, true);
-	/* make sure we have no running tx while configuring the seqno */
-	synchronize_net();
-
-	/* Flush the hw queues, in case something got queued during entry */
-	/* TODO new tx api */
-	if (iwl_mvm_has_new_tx_api(mvm)) {
-		WARN_ONCE(1, "d0i3: Need to implement flush TX queue\n");
-	} else {
-		ret = iwl_mvm_flush_tx_path(mvm, iwl_mvm_flushable_queues(mvm),
-					    flags);
-		if (ret)
-			return ret;
-	}
-
-	/* configure wowlan configuration only if needed */
-	if (mvm->d0i3_ap_sta_id != IWL_MVM_INVALID_STA) {
-		/* wake on beacons only if beacon storing isn't supported */
-		if (!fw_has_capa(&mvm->fw->ucode_capa,
-				 IWL_UCODE_TLV_CAPA_BEACON_STORING))
-			wowlan_config_cmd.wakeup_filter |=
-				cpu_to_le32(IWL_WOWLAN_WAKEUP_BCN_FILTERING);
-
-		iwl_mvm_wowlan_config_key_params(mvm,
-						 d0i3_iter_data.connected_vif,
-						 true, flags);
-
-		iwl_mvm_set_wowlan_data(mvm, &wowlan_config_cmd,
-					&d0i3_iter_data);
-
-		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, flags,
-					   sizeof(wowlan_config_cmd),
-					   &wowlan_config_cmd);
-		if (ret)
-			return ret;
-	}
-
-	return iwl_mvm_send_cmd_pdu(mvm, D3_CONFIG_CMD,
-				    flags | CMD_MAKE_TRANS_IDLE,
-				    sizeof(d3_cfg_cmd), &d3_cfg_cmd);
-}
-
-static void iwl_mvm_exit_d0i3_iterator(void *_data, u8 *mac,
-				       struct ieee80211_vif *vif)
-{
-	struct iwl_mvm *mvm = _data;
-	u32 flags = CMD_ASYNC | CMD_HIGH_PRIO;
-
-	IWL_DEBUG_RPM(mvm, "exiting D0i3 - vif %pM\n", vif->addr);
-	if (vif->type != NL80211_IFTYPE_STATION ||
-	    !vif->bss_conf.assoc)
-		return;
-
-	iwl_mvm_update_d0i3_power_mode(mvm, vif, false, flags);
-}
-
-struct iwl_mvm_d0i3_exit_work_iter_data {
-	struct iwl_mvm *mvm;
-	struct iwl_wowlan_status *status;
-	u32 wakeup_reasons;
-};
-
-static void iwl_mvm_d0i3_exit_work_iter(void *_data, u8 *mac,
-					struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_d0i3_exit_work_iter_data *data = _data;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	u32 reasons = data->wakeup_reasons;
-
-	/* consider only the relevant station interface */
-	if (vif->type != NL80211_IFTYPE_STATION || !vif->bss_conf.assoc ||
-	    data->mvm->d0i3_ap_sta_id != mvmvif->ap_sta_id)
-		return;
-
-	if (reasons & IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_DEAUTH)
-		iwl_mvm_connection_loss(data->mvm, vif, "D0i3");
-	else if (reasons & IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_MISSED_BEACON)
-		ieee80211_beacon_loss(vif);
-	else
-		iwl_mvm_d0i3_update_keys(data->mvm, vif, data->status);
-}
-
-static void iwl_mvm_d0i3_exit_work(struct work_struct *wk)
-{
-	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm, d0i3_exit_work);
-	struct iwl_mvm_d0i3_exit_work_iter_data iter_data = {
-		.mvm = mvm,
-	};
-
-	struct iwl_wowlan_status *status;
-	u32 wakeup_reasons = 0;
-
-	mutex_lock(&mvm->mutex);
-
-	status = iwl_mvm_send_wowlan_get_status(mvm);
-	if (IS_ERR_OR_NULL(status)) {
-		/* set to NULL so we don't need to check before kfree'ing */
-		status = NULL;
-		goto out;
-	}
-
-	wakeup_reasons = le32_to_cpu(status->wakeup_reasons);
-
-	IWL_DEBUG_RPM(mvm, "wakeup reasons: 0x%x\n", wakeup_reasons);
-
-	iter_data.wakeup_reasons = wakeup_reasons;
-	iter_data.status = status;
-	ieee80211_iterate_active_interfaces(mvm->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mvm_d0i3_exit_work_iter,
-					    &iter_data);
-out:
-	IWL_DEBUG_INFO(mvm, "d0i3 exit completed (wakeup reasons: 0x%x)\n",
-		       wakeup_reasons);
-
-	kfree(status);
-
-	/* the FW might have updated the regdomain */
-	iwl_mvm_update_changed_regdom(mvm);
-
-	iwl_mvm_resume_tcm(mvm);
-	mutex_unlock(&mvm->mutex);
-}
-
-int _iwl_mvm_exit_d0i3(struct iwl_mvm *mvm)
-{
-	u32 flags = CMD_ASYNC | CMD_HIGH_PRIO | CMD_SEND_IN_IDLE |
-		    CMD_WAKE_UP_TRANS;
-	int ret;
-
-	IWL_DEBUG_RPM(mvm, "MVM exiting D0i3\n");
-
-	if (WARN_ON_ONCE(mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR))
-		return -EINVAL;
-
-	mutex_lock(&mvm->d0i3_suspend_mutex);
-	if (test_bit(D0I3_DEFER_WAKEUP, &mvm->d0i3_suspend_flags)) {
-		IWL_DEBUG_RPM(mvm, "Deferring d0i3 exit until resume\n");
-		__set_bit(D0I3_PENDING_WAKEUP, &mvm->d0i3_suspend_flags);
-		mutex_unlock(&mvm->d0i3_suspend_mutex);
-		return 0;
-	}
-	mutex_unlock(&mvm->d0i3_suspend_mutex);
-
-	ret = iwl_mvm_send_cmd_pdu(mvm, D0I3_END_CMD, flags, 0, NULL);
-	if (ret)
-		goto out;
-
-	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
-						   IEEE80211_IFACE_ITER_NORMAL,
-						   iwl_mvm_exit_d0i3_iterator,
-						   mvm);
-out:
-	schedule_work(&mvm->d0i3_exit_work);
-	return ret;
-}
-
-int iwl_mvm_exit_d0i3(struct iwl_op_mode *op_mode)
-{
-	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-
-	return _iwl_mvm_exit_d0i3(mvm);
-}
-
-#define IWL_MVM_D0I3_OPS					\
-	.enter_d0i3 = iwl_mvm_enter_d0i3,			\
-	.exit_d0i3 = iwl_mvm_exit_d0i3,
-#else /* CONFIG_PM */
-#define IWL_MVM_D0I3_OPS
-#endif /* CONFIG_PM */
-
 #define IWL_MVM_COMMON_OPS					\
 	/* these could be differentiated */			\
 	.async_cb = iwl_mvm_async_cb,				\
@@ -1687,7 +1338,6 @@ int iwl_mvm_exit_d0i3(struct iwl_op_mode *op_mode)
 	.nic_error = iwl_mvm_nic_error,				\
 	.cmd_queue_full = iwl_mvm_cmd_queue_full,		\
 	.nic_config = iwl_mvm_nic_config,			\
-	IWL_MVM_D0I3_OPS					\
 	/* as we only register one, these MUST be common! */	\
 	.start = iwl_op_mode_mvm_start,				\
 	.stop = iwl_op_mode_mvm_stop
-- 
2.23.0.rc1

