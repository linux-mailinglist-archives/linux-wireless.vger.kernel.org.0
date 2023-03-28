Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF356CB8E0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjC1H7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjC1H7f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A34483
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990371; x=1711526371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iYWV6pu5zt0edpbJKVZ7WjMATlC2zW4d1/BNY7MTsX8=;
  b=LXn1MaHqSFXztghk6Oek2MCTyCFfSfTkjP56w5PFdzpxqOQx5P6rDtEC
   j3U/R4QOqCtxv4y66CyRrK3s3rQSVzK/6fOa2v+WYxyaVfHJ/TEv7RAxA
   JjQmovQhozes/JJP99k8O25LEAUuThkaF8SgXkFWO4BJ/jTgiGFNfEls6
   mo4VjKSaAeUywrnrJnfLHcMEcLcmHcjYfxkZHhtXv24zsTFXjD5SWG7+Z
   5vQcy6xJZvl96zmySDKX+3aQSxUk2xCc9qbu9TWWr7oFcu4cZ6wHszIbx
   ZKwFSoW5VXV2Ji1/fN6Y/s/stoli4LHwFRLVmI+3Xlocae735109b7OKg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958040"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958040"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045102"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045102"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/31] wifi: iwlwifi: mvm: sta preparation for MLO
Date:   Tue, 28 Mar 2023 10:58:42 +0300
Message-Id: <20230328104948.34eace06d583.I1f8c5e919a71b21030460fbdd220d42401b688b1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Split iwl_mvm_sta into general and link specific parts. As a first
step, all link dependent parameters reside in deflink.

The change was done mostly using the spatch below with some manual
adjustments.

@iwl_mvm_sta@
struct iwl_mvm_sta *s;
identifier var = {sta_id, lq_sta, avg_energy};
@@

(
  s->
-    var
+    deflink.var
)

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  19 +--
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  42 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 113 ++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  37 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  34 +++---
 13 files changed, 161 insertions(+), 123 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 73ef1da3ccac..21ba3c7dd9b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -194,7 +194,7 @@ static int iwl_mvm_bt_coex_reduced_txp(struct iwl_mvm *mvm, u8 sta_id,
 	if (mvmsta->bt_reduced_txpower == enable)
 		return 0;
 
-	value = mvmsta->sta_id;
+	value = mvmsta->deflink.sta_id;
 
 	if (enable)
 		value |= BT_REDUCED_TX_POWER_BIT;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 2a6f42f07c9e..b5eb0ee298ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -376,7 +376,7 @@ static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
 {
 	struct ieee80211_sta *sta = file->private_data;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->lq_sta.rs_fw;
+	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
 	struct iwl_mvm *mvm = lq_sta->pers.drv;
 	static const size_t bufsz = 2048;
 	char *buff;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 163515db6828..282c15e74f08 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -922,7 +922,7 @@ static int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
 		if (iwl_mvm_vif_from_mac80211(vif)->deflink.ap_sta_id ==
-				iwl_mvm_sta_from_mac80211(sta)->sta_id) {
+		    iwl_mvm_sta_from_mac80211(sta)->deflink.sta_id) {
 			struct iwl_mvm_vif *mvmvif;
 			u16 macid = iwl_mvm_vif_from_mac80211(vif)->id;
 			struct iwl_mvm_tcm_mac *mdata = &mvm->tcm.data[macid];
@@ -3116,7 +3116,7 @@ static void __iwl_mvm_mac_sta_notify(struct ieee80211_hw *hw,
 		 */
 		break;
 	case STA_NOTIFY_AWAKE:
-		if (WARN_ON(mvmsta->sta_id == IWL_MVM_INVALID_STA))
+		if (WARN_ON(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 			break;
 
 		if (txqs)
@@ -3206,8 +3206,8 @@ static void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 	 * callback deleted the station.
 	 */
 	mutex_lock(&mvm->mutex);
-	if (sta == rcu_access_pointer(mvm->fw_id_to_mac_id[mvm_sta->sta_id]))
-		rcu_assign_pointer(mvm->fw_id_to_mac_id[mvm_sta->sta_id],
+	if (sta == rcu_access_pointer(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id]))
+		rcu_assign_pointer(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id],
 				   ERR_PTR(-ENOENT));
 
 	mutex_unlock(&mvm->mutex);
@@ -3534,7 +3534,8 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			     !iwlwifi_mod_params.disable_11ax) ||
 			    (vif->bss_conf.eht_support &&
 			     !iwlwifi_mod_params.disable_11be))
-				iwl_mvm_cfg_he_sta(mvm, vif, mvm_sta->sta_id);
+				iwl_mvm_cfg_he_sta(mvm, vif,
+						   mvm_sta->deflink.sta_id);
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
 			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
 
@@ -5470,13 +5471,13 @@ static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-	if (mvmsta->avg_energy) {
-		sinfo->signal_avg = -(s8)mvmsta->avg_energy;
+	if (mvmsta->deflink.avg_energy) {
+		sinfo->signal_avg = -(s8)mvmsta->deflink.avg_energy;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 	}
 
 	if (iwl_mvm_has_tlc_offload(mvm)) {
-		struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->lq_sta.rs_fw;
+		struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
 
 		iwl_mvm_set_sta_rate(lq_sta->last_rate_n_flags, &sinfo->txrate);
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
@@ -5491,7 +5492,7 @@ static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	if (mvmvif->deflink.ap_sta_id != mvmsta->sta_id)
+	if (mvmvif->deflink.ap_sta_id != mvmsta->deflink.sta_id)
 		goto unlock;
 
 	if (iwl_mvm_request_statistics(mvm, false))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 4eaba89ba0c5..154f145396ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -22,7 +22,7 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-		return BIT(mvmsta->sta_id);
+		return BIT(mvmsta->deflink.sta_id);
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index b2a7fa09f900..c063383247f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -243,7 +243,7 @@ static int iwl_mvm_mld_disable_txq(struct iwl_mvm *mvm,
 			.operation = cpu_to_le32(IWL_SCD_QUEUE_REMOVE),
 			.u.remove.tid = cpu_to_le32(tid),
 			.u.remove.sta_mask =
-				cpu_to_le32(BIT(mvmsta->sta_id)),
+				cpu_to_le32(BIT(mvmsta->deflink.sta_id)),
 		};
 
 		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0,
@@ -348,7 +348,7 @@ static void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
 
 	mvm_sta->disable_tx = disable;
 
-	cmd.sta_id = cpu_to_le32(mvm_sta->sta_id);
+	cmd.sta_id = cpu_to_le32(mvm_sta->deflink.sta_id);
 	cmd.disable = cpu_to_le32(disable);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index e3fb1b2cea6d..a33673c6ae7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -438,7 +438,7 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 
 	flags = le32_to_cpu(notif->flags);
 
-	lq_sta = &mvmsta->lq_sta.rs_fw;
+	lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
 
 	if (flags & IWL_TLC_NOTIF_FLAG_RATE) {
 		char pretty_rate[100];
@@ -547,12 +547,12 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 {
 	struct ieee80211_hw *hw = mvm->hw;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->lq_sta.rs_fw;
+	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
 	struct ieee80211_supported_band *sband = hw->wiphy->bands[band];
 	u16 max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
-		.sta_id = mvmsta->sta_id,
+		.sta_id = mvmsta->deflink.sta_id,
 		.max_ch_width = update ?
 			rs_fw_bw_from_sta_bw(sta) : IWL_TLC_MNG_CH_WIDTH_20MHZ,
 		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, sta, sband)),
@@ -641,12 +641,12 @@ int rs_fw_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 
 void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta)
 {
-	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->lq_sta.rs_fw;
+	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
 
 	IWL_DEBUG_RATE(mvm, "create station rate scale window\n");
 
 	lq_sta->pers.drv = mvm;
-	lq_sta->pers.sta_id = mvmsta->sta_id;
+	lq_sta->pers.sta_id = mvmsta->deflink.sta_id;
 	lq_sta->pers.chains = 0;
 	memset(lq_sta->pers.chain_signal, 0, sizeof(lq_sta->pers.chain_signal));
 	lq_sta->pers.last_rssi = S8_MIN;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index bd135b7168cb..1b0e99377156 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -754,7 +754,7 @@ static int rs_collect_tlc_data(struct iwl_mvm *mvm,
 		return -EINVAL;
 
 	if (tbl->column != RS_COLUMN_INVALID) {
-		struct lq_sta_pers *pers = &mvmsta->lq_sta.rs_drv.pers;
+		struct lq_sta_pers *pers = &mvmsta->deflink.lq_sta.rs_drv.pers;
 
 		pers->tx_stats[tbl->column][scale_index].total += attempts;
 		pers->tx_stats[tbl->column][scale_index].success += successes;
@@ -2599,7 +2599,7 @@ void rs_update_last_rssi(struct iwl_mvm *mvm,
 			 struct iwl_mvm_sta *mvmsta,
 			 struct ieee80211_rx_status *rx_status)
 {
-	struct iwl_lq_sta *lq_sta = &mvmsta->lq_sta.rs_drv;
+	struct iwl_lq_sta *lq_sta = &mvmsta->deflink.lq_sta.rs_drv;
 	int i;
 
 	lq_sta->pers.chains = rx_status->chains;
@@ -2711,7 +2711,7 @@ static void *rs_drv_alloc_sta(void *mvm_rate, struct ieee80211_sta *sta,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_op_mode *op_mode = (struct iwl_op_mode *)mvm_rate;
 	struct iwl_mvm *mvm  = IWL_OP_MODE_GET_MVM(op_mode);
-	struct iwl_lq_sta *lq_sta = &mvmsta->lq_sta.rs_drv;
+	struct iwl_lq_sta *lq_sta = &mvmsta->deflink.lq_sta.rs_drv;
 
 	IWL_DEBUG_RATE(mvm, "create station rate scale window\n");
 
@@ -2917,18 +2917,18 @@ static void rs_drv_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_lq_sta *lq_sta = &mvmsta->lq_sta.rs_drv;
+	struct iwl_lq_sta *lq_sta = &mvmsta->deflink.lq_sta.rs_drv;
 	struct ieee80211_supported_band *sband;
 	unsigned long supp; /* must be unsigned long for for_each_set_bit */
 
-	lockdep_assert_held(&mvmsta->lq_sta.rs_drv.pers.lock);
+	lockdep_assert_held(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 
 	/* clear all non-persistent lq data */
 	memset(lq_sta, 0, offsetof(typeof(*lq_sta), pers));
 
 	sband = hw->wiphy->bands[band];
 
-	lq_sta->lq.sta_id = mvmsta->sta_id;
+	lq_sta->lq.sta_id = mvmsta->deflink.sta_id;
 	mvmsta->amsdu_enabled = 0;
 	mvmsta->max_amsdu_len = sta->cur->max_amsdu_len;
 
@@ -2940,7 +2940,7 @@ static void rs_drv_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	IWL_DEBUG_RATE(mvm,
 		       "LQ: *** rate scale station global init for station %d ***\n",
-		       mvmsta->sta_id);
+		       mvmsta->deflink.sta_id);
 	/* TODO: what is a good starting rate for STA? About middle? Maybe not
 	 * the lowest or the highest rate.. Could consider using RSSI from
 	 * previous packets? Need to have IEEE 802.1X auth succeed immediately
@@ -3032,7 +3032,7 @@ static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
 	u8 lq_color = RS_DRV_DATA_LQ_COLOR_GET(tlc_info);
 	u32 tx_resp_hwrate = (uintptr_t)info->status.status_driver_data[1];
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_lq_sta *lq_sta = &mvmsta->lq_sta.rs_drv;
+	struct iwl_lq_sta *lq_sta = &mvmsta->deflink.lq_sta.rs_drv;
 
 	if (!lq_sta->pers.drv) {
 		IWL_DEBUG_RATE(mvm, "Rate scaling not initialized yet.\n");
@@ -3256,11 +3256,11 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	/* If it's locked we are in middle of init flow
 	 * just wait for next tx status to update the lq_sta data
 	 */
-	if (!spin_trylock(&mvmsta->lq_sta.rs_drv.pers.lock))
+	if (!spin_trylock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock))
 		return;
 
 	__iwl_mvm_rs_tx_status(mvm, sta, tid, info, ndp);
-	spin_unlock(&mvmsta->lq_sta.rs_drv.pers.lock);
+	spin_unlock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
@@ -3436,7 +3436,7 @@ static void rs_bfer_active_iter(void *_data,
 {
 	struct rs_bfer_active_iter_data *data = _data;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_lq_cmd *lq_cmd = &mvmsta->lq_sta.rs_drv.lq;
+	struct iwl_lq_cmd *lq_cmd = &mvmsta->deflink.lq_sta.rs_drv.lq;
 	u32 ss_params = le32_to_cpu(lq_cmd->ss_params);
 
 	if (sta == data->exclude_sta)
@@ -3467,7 +3467,8 @@ static int rs_bfer_priority(struct iwl_mvm_sta *sta)
 		prio = 1;
 		break;
 	default:
-		WARN_ONCE(true, "viftype %d sta_id %d", viftype, sta->sta_id);
+		WARN_ONCE(true, "viftype %d sta_id %d", viftype,
+			  sta->deflink.sta_id);
 		prio = -1;
 	}
 
@@ -3544,12 +3545,12 @@ static void rs_set_lq_ss_params(struct iwl_mvm *mvm,
 	}
 
 	IWL_DEBUG_RATE(mvm, "Found existing sta %d with BFER activated\n",
-		       bfer_mvmsta->sta_id);
+		       bfer_mvmsta->deflink.sta_id);
 
 	/* Disallow BFER on another STA if active and we're a higher priority */
 	if (rs_bfer_priority_cmp(mvmsta, bfer_mvmsta) > 0) {
 		struct iwl_lq_cmd *bfersta_lq_cmd =
-			&bfer_mvmsta->lq_sta.rs_drv.lq;
+			&bfer_mvmsta->deflink.lq_sta.rs_drv.lq;
 		u32 bfersta_ss_params = le32_to_cpu(bfersta_lq_cmd->ss_params);
 
 		bfersta_ss_params &= ~LQ_SS_BFER_ALLOWED;
@@ -3559,7 +3560,7 @@ static void rs_set_lq_ss_params(struct iwl_mvm *mvm,
 		ss_params |= LQ_SS_BFER_ALLOWED;
 		IWL_DEBUG_RATE(mvm,
 			       "Lower priority BFER sta found (%d). Switch BFER\n",
-			       bfer_mvmsta->sta_id);
+			       bfer_mvmsta->deflink.sta_id);
 	}
 out:
 	lq_cmd->ss_params = cpu_to_le32(ss_params);
@@ -3744,7 +3745,7 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 
 	struct iwl_lq_sta *lq_sta = file->private_data;
 	struct iwl_mvm_sta *mvmsta =
-		container_of(lq_sta, struct iwl_mvm_sta, lq_sta.rs_drv);
+		container_of(lq_sta, struct iwl_mvm_sta, deflink.lq_sta.rs_drv);
 	struct iwl_mvm *mvm;
 	struct iwl_scale_tbl_info *tbl = &(lq_sta->lq_info[lq_sta->active_tbl]);
 	struct rs_rate *rate = &tbl->rate;
@@ -4045,7 +4046,8 @@ static void rs_drv_add_sta_debugfs(void *mvm, void *priv_sta,
 	struct iwl_lq_sta *lq_sta = priv_sta;
 	struct iwl_mvm_sta *mvmsta;
 
-	mvmsta = container_of(lq_sta, struct iwl_mvm_sta, lq_sta.rs_drv);
+	mvmsta = container_of(lq_sta, struct iwl_mvm_sta,
+			      deflink.lq_sta.rs_drv);
 
 	if (!mvmsta->vif)
 		return;
@@ -4102,9 +4104,9 @@ void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	} else {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-		spin_lock(&mvmsta->lq_sta.rs_drv.pers.lock);
+		spin_lock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 		rs_drv_rate_init(mvm, sta, band);
-		spin_unlock(&mvmsta->lq_sta.rs_drv.pers.lock);
+		spin_unlock(&mvmsta->deflink.lq_sta.rs_drv.pers.lock);
 	}
 }
 
@@ -4121,7 +4123,7 @@ void iwl_mvm_rate_control_unregister(void)
 static int rs_drv_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 				bool enable)
 {
-	struct iwl_lq_cmd *lq = &mvmsta->lq_sta.rs_drv.lq;
+	struct iwl_lq_cmd *lq = &mvmsta->deflink.lq_sta.rs_drv.lq;
 
 	lockdep_assert_held(&mvm->mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 4105b79db467..e08dca8d2baa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -241,7 +241,7 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 	     !mvmvif->deflink.queue_params[IEEE80211_AC_VI].uapsd &&
 	     !mvmvif->deflink.queue_params[IEEE80211_AC_BE].uapsd &&
 	     !mvmvif->deflink.queue_params[IEEE80211_AC_BK].uapsd) ||
-	    mvmsta->sta_id != mvmvif->deflink.ap_sta_id)
+	    mvmsta->deflink.sta_id != mvmvif->deflink.ap_sta_id)
 		return;
 
 	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
@@ -712,14 +712,14 @@ static void iwl_mvm_stats_energy_iter(void *_data,
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	u8 *energy = _data;
-	u32 sta_id = mvmsta->sta_id;
+	u32 sta_id = mvmsta->deflink.sta_id;
 
 	if (WARN_ONCE(sta_id >= IWL_MVM_STATION_COUNT_MAX, "sta_id %d >= %d",
 		      sta_id, IWL_MVM_STATION_COUNT_MAX))
 		return;
 
 	if (energy[sta_id])
-		mvmsta->avg_energy = energy[sta_id];
+		mvmsta->deflink.avg_energy = energy[sta_id];
 
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 6286132f165a..b160ae137c4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -979,9 +979,10 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		return false;
 	}
 
-	if (WARN(tid != baid_data->tid || mvm_sta->sta_id != baid_data->sta_id,
+	if (WARN(tid != baid_data->tid ||
+		 mvm_sta->deflink.sta_id != baid_data->sta_id,
 		 "baid 0x%x is mapped to sta:%d tid:%d, but was received for sta:%d tid:%d\n",
-		 baid, baid_data->sta_id, baid_data->tid, mvm_sta->sta_id,
+		 baid, baid_data->sta_id, baid_data->tid, mvm_sta->deflink.sta_id,
 		 tid))
 		return false;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index c3b81021898b..d01c67e1ce2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -119,7 +119,7 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_add_sta_cmd add_sta_cmd = {
-		.sta_id = mvm_sta->sta_id,
+		.sta_id = mvm_sta->deflink.sta_id,
 		.mac_id_n_color = cpu_to_le32(mvm_sta->mac_id_n_color),
 		.add_modify = update ? 1 : 0,
 		.station_flags_msk = cpu_to_le32(STA_FLG_FAT_EN_MSK |
@@ -314,7 +314,7 @@ static int iwl_mvm_invalidate_sta_queue(struct iwl_mvm *mvm, int queue,
 	mvmsta->tid_disable_agg |= disable_agg_tids;
 
 	cmd.mac_id_n_color = cpu_to_le32(mvmsta->mac_id_n_color);
-	cmd.sta_id = mvmsta->sta_id;
+	cmd.sta_id = mvmsta->deflink.sta_id;
 	cmd.add_modify = STA_MODE_MODIFY;
 	cmd.modify_mask = STA_MODIFY_QUEUES;
 	if (disable_agg_tids)
@@ -856,15 +856,15 @@ static int iwl_mvm_sta_alloc_queue_tvqm(struct iwl_mvm *mvm,
 
 	IWL_DEBUG_TX_QUEUES(mvm,
 			    "Allocating queue for sta %d on tid %d\n",
-			    mvmsta->sta_id, tid);
-	queue = iwl_mvm_tvqm_enable_txq(mvm, sta, mvmsta->sta_id,
+			    mvmsta->deflink.sta_id, tid);
+	queue = iwl_mvm_tvqm_enable_txq(mvm, sta, mvmsta->deflink.sta_id,
 					tid, wdg_timeout);
 	if (queue < 0)
 		return queue;
 
 	mvmtxq->txq_id = queue;
 	mvm->tvqm_info[queue].txq_tid = tid;
-	mvm->tvqm_info[queue].sta_id = mvmsta->sta_id;
+	mvm->tvqm_info[queue].sta_id = mvmsta->deflink.sta_id;
 
 	IWL_DEBUG_TX_QUEUES(mvm, "Allocated queue is %d\n", queue);
 
@@ -1049,7 +1049,7 @@ static void iwl_mvm_unshare_queue(struct iwl_mvm *mvm, int queue)
 		mvmsta->tid_disable_agg &= ~BIT(tid);
 
 		cmd.mac_id_n_color = cpu_to_le32(mvmsta->mac_id_n_color);
-		cmd.sta_id = mvmsta->sta_id;
+		cmd.sta_id = mvmsta->deflink.sta_id;
 		cmd.add_modify = STA_MODE_MODIFY;
 		cmd.modify_mask = STA_MODIFY_TID_DISABLE_TX;
 		cmd.tfd_queue_msk = cpu_to_le32(mvmsta->tfd_queue_msk);
@@ -1274,7 +1274,7 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.fifo = iwl_mvm_mac_ac_to_tx_fifo(mvm, ac),
-		.sta_id = mvmsta->sta_id,
+		.sta_id = mvmsta->deflink.sta_id,
 		.tid = tid,
 		.frame_limit = IWL_FRAME_LIMIT,
 	};
@@ -1300,7 +1300,7 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 	spin_unlock_bh(&mvmsta->lock);
 
 	if (tid == IWL_MAX_TID_COUNT) {
-		queue = iwl_mvm_find_free_queue(mvm, mvmsta->sta_id,
+		queue = iwl_mvm_find_free_queue(mvm, mvmsta->deflink.sta_id,
 						IWL_MVM_DQA_MIN_MGMT_QUEUE,
 						IWL_MVM_DQA_MAX_MGMT_QUEUE);
 		if (queue >= IWL_MVM_DQA_MIN_MGMT_QUEUE)
@@ -1319,12 +1319,12 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 	}
 
 	if (queue < 0)
-		queue = iwl_mvm_find_free_queue(mvm, mvmsta->sta_id,
+		queue = iwl_mvm_find_free_queue(mvm, mvmsta->deflink.sta_id,
 						IWL_MVM_DQA_MIN_DATA_QUEUE,
 						IWL_MVM_DQA_MAX_DATA_QUEUE);
 	if (queue < 0) {
 		/* try harder - perhaps kill an inactive queue */
-		queue = iwl_mvm_inactivity_check(mvm, mvmsta->sta_id);
+		queue = iwl_mvm_inactivity_check(mvm, mvmsta->deflink.sta_id);
 	}
 
 	/* No free queue - we'll have to share */
@@ -1364,7 +1364,7 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 	IWL_DEBUG_TX_QUEUES(mvm,
 			    "Allocating %squeue #%d to sta %d on tid %d\n",
 			    shared_queue ? "shared " : "", queue,
-			    mvmsta->sta_id, tid);
+			    mvmsta->deflink.sta_id, tid);
 
 	if (shared_queue) {
 		/* Disable any open aggs on this queue */
@@ -1431,7 +1431,7 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 
 out_err:
 	queue_tmp = queue;
-	iwl_mvm_disable_txq(mvm, sta, mvmsta->sta_id, &queue_tmp, tid);
+	iwl_mvm_disable_txq(mvm, sta, mvmsta->deflink.sta_id, &queue_tmp, tid);
 
 	return ret;
 }
@@ -1500,12 +1500,12 @@ static int iwl_mvm_reserve_sta_stream(struct iwl_mvm *mvm,
 	     IWL_MVM_QUEUE_FREE))
 		queue = IWL_MVM_DQA_BSS_CLIENT_QUEUE;
 	else
-		queue = iwl_mvm_find_free_queue(mvm, mvmsta->sta_id,
+		queue = iwl_mvm_find_free_queue(mvm, mvmsta->deflink.sta_id,
 						IWL_MVM_DQA_MIN_DATA_QUEUE,
 						IWL_MVM_DQA_MAX_DATA_QUEUE);
 	if (queue < 0) {
 		/* try again - this time kick out a queue if needed */
-		queue = iwl_mvm_inactivity_check(mvm, mvmsta->sta_id);
+		queue = iwl_mvm_inactivity_check(mvm, mvmsta->deflink.sta_id);
 		if (queue < 0) {
 			IWL_ERR(mvm, "No available queues for new station\n");
 			return -ENOSPC;
@@ -1516,7 +1516,7 @@ static int iwl_mvm_reserve_sta_stream(struct iwl_mvm *mvm,
 	mvmsta->reserved_queue = queue;
 
 	IWL_DEBUG_TX_QUEUES(mvm, "Reserving data queue #%d for sta_id %d\n",
-			    queue, mvmsta->sta_id);
+			    queue, mvmsta->deflink.sta_id);
 
 	return 0;
 }
@@ -1536,7 +1536,7 @@ static void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 		iwl_mvm_get_wd_timeout(mvm, mvm_sta->vif, false, false);
 	int i;
 	struct iwl_trans_txq_scd_cfg cfg = {
-		.sta_id = mvm_sta->sta_id,
+		.sta_id = mvm_sta->deflink.sta_id,
 		.frame_limit = IWL_FRAME_LIMIT,
 	};
 
@@ -1558,9 +1558,9 @@ static void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 		if (iwl_mvm_has_new_tx_api(mvm)) {
 			IWL_DEBUG_TX_QUEUES(mvm,
 					    "Re-mapping sta %d tid %d\n",
-					    mvm_sta->sta_id, i);
+					    mvm_sta->deflink.sta_id, i);
 			txq_id = iwl_mvm_tvqm_enable_txq(mvm, sta,
-							 mvm_sta->sta_id,
+							 mvm_sta->deflink.sta_id,
 							 i, wdg);
 			/*
 			 * on failures, just set it to IWL_MVM_INVALID_QUEUE
@@ -1589,7 +1589,8 @@ static void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 
 			IWL_DEBUG_TX_QUEUES(mvm,
 					    "Re-mapping sta %d tid %d to queue %d\n",
-					    mvm_sta->sta_id, i, txq_id);
+					    mvm_sta->deflink.sta_id, i,
+					    txq_id);
 
 			iwl_mvm_enable_txq(mvm, sta, txq_id, seq, &cfg, wdg);
 			mvm->queue_info[txq_id].status = IWL_MVM_QUEUE_READY;
@@ -1658,7 +1659,9 @@ static int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	mvm_sta->sta_id = sta_id;
+	mvm_sta->deflink.sta_id = sta_id;
+	rcu_assign_pointer(mvm_sta->link[0], &mvm_sta->deflink);
+
 	mvm_sta->mac_id_n_color = FW_CMD_ID_AND_COLOR(mvmvif->id,
 						      mvmvif->color);
 	mvm_sta->vif = vif;
@@ -1724,7 +1727,7 @@ static int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (iwl_mvm_has_tlc_offload(mvm))
 		iwl_mvm_rs_add_sta(mvm, mvm_sta);
 	else
-		spin_lock_init(&mvm_sta->lq_sta.rs_drv.pers.lock);
+		spin_lock_init(&mvm_sta->deflink.lq_sta.rs_drv.pers.lock);
 
 	iwl_mvm_toggle_tx_ant(mvm, &mvm_sta->tx_ant);
 
@@ -1747,7 +1750,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		sta_id = iwl_mvm_find_free_sta_id(mvm,
 						  ieee80211_vif_type_p2p(vif));
 	else
-		sta_id = mvm_sta->sta_id;
+		sta_id = mvm_sta->deflink.sta_id;
 
 	if (sta_id == IWL_MVM_INVALID_STA)
 		return -ENOSPC;
@@ -1810,7 +1813,7 @@ int iwl_mvm_drain_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 	lockdep_assert_held(&mvm->mutex);
 
 	cmd.mac_id_n_color = cpu_to_le32(mvmsta->mac_id_n_color);
-	cmd.sta_id = mvmsta->sta_id;
+	cmd.sta_id = mvmsta->deflink.sta_id;
 	cmd.add_modify = STA_MODE_MODIFY;
 	cmd.station_flags = drain ? cpu_to_le32(STA_FLG_DRAIN_FLOW) : 0;
 	cmd.station_flags_msk = cpu_to_le32(STA_FLG_DRAIN_FLOW);
@@ -1825,12 +1828,12 @@ int iwl_mvm_drain_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 	switch (status & IWL_ADD_STA_STATUS_MASK) {
 	case ADD_STA_SUCCESS:
 		IWL_DEBUG_INFO(mvm, "Frames for staid %d will drained in fw\n",
-			       mvmsta->sta_id);
+			       mvmsta->deflink.sta_id);
 		break;
 	default:
 		ret = -EIO;
 		IWL_ERR(mvm, "Couldn't drain frames for staid %d\n",
-			mvmsta->sta_id);
+			mvmsta->deflink.sta_id);
 		break;
 	}
 
@@ -1882,7 +1885,7 @@ static void iwl_mvm_disable_sta_queues(struct iwl_mvm *mvm,
 		if (mvm_sta->tid_data[i].txq_id == IWL_MVM_INVALID_QUEUE)
 			continue;
 
-		iwl_mvm_disable_txq(mvm, sta, mvm_sta->sta_id,
+		iwl_mvm_disable_txq(mvm, sta, mvm_sta->deflink.sta_id,
 				    &mvm_sta->tid_data[i].txq_id, i);
 		mvm_sta->tid_data[i].txq_id = IWL_MVM_INVALID_QUEUE;
 	}
@@ -1926,7 +1929,7 @@ static bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	u8 sta_id = mvm_sta->sta_id;
+	u8 sta_id = mvm_sta->deflink.sta_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -2022,8 +2025,8 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 	if (iwl_mvm_sta_del(mvm, vif, sta, &ret))
 		return ret;
 
-	ret = iwl_mvm_rm_sta_common(mvm, mvm_sta->sta_id);
-	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta->sta_id], NULL);
+	ret = iwl_mvm_rm_sta_common(mvm, mvm_sta->deflink.sta_id);
+	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id], NULL);
 
 	return ret;
 }
@@ -2654,7 +2657,7 @@ static int iwl_mvm_fw_baid_op_sta(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_add_sta_cmd cmd = {
 		.mac_id_n_color = cpu_to_le32(mvm_sta->mac_id_n_color),
-		.sta_id = mvm_sta->sta_id,
+		.sta_id = mvm_sta->deflink.sta_id,
 		.add_modify = STA_MODE_MODIFY,
 	};
 	u32 status;
@@ -2710,7 +2713,8 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 	BUILD_BUG_ON(sizeof(struct iwl_rx_baid_cfg_resp) != sizeof(baid));
 
 	if (start) {
-		cmd.alloc.sta_id_mask = cpu_to_le32(BIT(mvm_sta->sta_id));
+		cmd.alloc.sta_id_mask =
+			cpu_to_le32(BIT(mvm_sta->deflink.sta_id));
 		cmd.alloc.tid = tid;
 		cmd.alloc.ssn = cpu_to_le16(ssn);
 		cmd.alloc.win_size = cpu_to_le16(buf_size);
@@ -2719,7 +2723,8 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.remove_v1.baid = cpu_to_le32(baid);
 		BUILD_BUG_ON(sizeof(cmd.remove_v1) > sizeof(cmd.remove));
 	} else {
-		cmd.remove.sta_id_mask = cpu_to_le32(BIT(mvm_sta->sta_id));
+		cmd.remove.sta_id_mask =
+			cpu_to_le32(BIT(mvm_sta->deflink.sta_id));
 		cmd.remove.tid = cpu_to_le32(tid);
 	}
 
@@ -2843,7 +2848,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			    iwl_mvm_rx_agg_session_expired, 0);
 		baid_data->mvm = mvm;
 		baid_data->tid = tid;
-		baid_data->sta_id = mvm_sta->sta_id;
+		baid_data->sta_id = mvm_sta->deflink.sta_id;
 
 		mvm_sta->tid_to_baid[tid] = baid;
 		if (timeout)
@@ -2858,7 +2863,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		 * RX is being processed in parallel
 		 */
 		IWL_DEBUG_HT(mvm, "Sta %d(%d) is assigned to BAID %d\n",
-			     mvm_sta->sta_id, tid, baid);
+			     mvm_sta->deflink.sta_id, tid, baid);
 		WARN_ON(rcu_access_pointer(mvm->baid_map[baid]));
 		rcu_assign_pointer(mvm->baid_map[baid], baid_data);
 	} else  {
@@ -2920,7 +2925,7 @@ int iwl_mvm_sta_tx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	cmd.mac_id_n_color = cpu_to_le32(mvm_sta->mac_id_n_color);
-	cmd.sta_id = mvm_sta->sta_id;
+	cmd.sta_id = mvm_sta->deflink.sta_id;
 	cmd.add_modify = STA_MODE_MODIFY;
 	if (!iwl_mvm_has_new_tx_api(mvm))
 		cmd.modify_mask = STA_MODIFY_QUEUES;
@@ -3012,7 +3017,7 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 */
 	txq_id = mvmsta->tid_data[tid].txq_id;
 	if (txq_id == IWL_MVM_INVALID_QUEUE) {
-		ret = iwl_mvm_find_free_queue(mvm, mvmsta->sta_id,
+		ret = iwl_mvm_find_free_queue(mvm, mvmsta->deflink.sta_id,
 					      IWL_MVM_DQA_MIN_DATA_QUEUE,
 					      IWL_MVM_DQA_MAX_DATA_QUEUE);
 		if (ret < 0) {
@@ -3050,7 +3055,8 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	IWL_DEBUG_TX_QUEUES(mvm,
 			    "Start AGG: sta %d tid %d queue %d - ssn = %d, next_recl = %d\n",
-			    mvmsta->sta_id, tid, txq_id, tid_data->ssn,
+			    mvmsta->deflink.sta_id, tid, txq_id,
+			    tid_data->ssn,
 			    tid_data->next_reclaimed);
 
 	/*
@@ -3089,7 +3095,7 @@ int iwl_mvm_sta_tx_agg_oper(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	u16 ssn;
 
 	struct iwl_trans_txq_scd_cfg cfg = {
-		.sta_id = mvmsta->sta_id,
+		.sta_id = mvmsta->deflink.sta_id,
 		.tid = tid,
 		.frame_limit = buf_size,
 		.aggregate = true,
@@ -3161,7 +3167,7 @@ int iwl_mvm_sta_tx_agg_oper(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		}
 
 		ret = iwl_mvm_reconfig_scd(mvm, queue, cfg.fifo,
-					   mvmsta->sta_id, tid,
+					   mvmsta->deflink.sta_id, tid,
 					   buf_size, ssn);
 		if (ret) {
 			IWL_ERR(mvm,
@@ -3194,12 +3200,13 @@ int iwl_mvm_sta_tx_agg_oper(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 */
 	mvmsta->max_agg_bufsize =
 		min(mvmsta->max_agg_bufsize, buf_size);
-	mvmsta->lq_sta.rs_drv.lq.agg_frame_cnt_limit = mvmsta->max_agg_bufsize;
+	mvmsta->deflink.lq_sta.rs_drv.lq.agg_frame_cnt_limit =
+		mvmsta->max_agg_bufsize;
 
 	IWL_DEBUG_HT(mvm, "Tx aggregation enabled on ra = %pM tid = %d\n",
 		     sta->addr, tid);
 
-	return iwl_mvm_send_lq_cmd(mvm, &mvmsta->lq_sta.rs_drv.lq);
+	return iwl_mvm_send_lq_cmd(mvm, &mvmsta->deflink.lq_sta.rs_drv.lq);
 }
 
 static void iwl_mvm_unreserve_agg_queue(struct iwl_mvm *mvm,
@@ -3248,7 +3255,8 @@ int iwl_mvm_sta_tx_agg_stop(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	txq_id = tid_data->txq_id;
 
 	IWL_DEBUG_TX_QUEUES(mvm, "Stop AGG: sta %d tid %d q %d state %d\n",
-			    mvmsta->sta_id, tid, txq_id, tid_data->state);
+			    mvmsta->deflink.sta_id, tid, txq_id,
+			    tid_data->state);
 
 	mvmsta->agg_tids &= ~BIT(tid);
 
@@ -3287,7 +3295,7 @@ int iwl_mvm_sta_tx_agg_stop(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	default:
 		IWL_ERR(mvm,
 			"Stopping AGG while state not ON or starting for %d on %d (%d)\n",
-			mvmsta->sta_id, tid, tid_data->state);
+			mvmsta->deflink.sta_id, tid, tid_data->state);
 		IWL_ERR(mvm,
 			"\ttid_data->txq_id = %d\n", tid_data->txq_id);
 		err = -EINVAL;
@@ -3313,7 +3321,8 @@ int iwl_mvm_sta_tx_agg_flush(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	spin_lock_bh(&mvmsta->lock);
 	txq_id = tid_data->txq_id;
 	IWL_DEBUG_TX_QUEUES(mvm, "Flush AGG: sta %d tid %d q %d state %d\n",
-			    mvmsta->sta_id, tid, txq_id, tid_data->state);
+			    mvmsta->deflink.sta_id, tid, txq_id,
+			    tid_data->state);
 	old_state = tid_data->state;
 	tid_data->state = IWL_AGG_OFF;
 	mvmsta->agg_tids &= ~BIT(tid);
@@ -3325,7 +3334,7 @@ int iwl_mvm_sta_tx_agg_flush(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		iwl_mvm_drain_sta(mvm, mvmsta, true);
 
 		if (iwl_mvm_has_new_tx_api(mvm)) {
-			if (iwl_mvm_flush_sta_tids(mvm, mvmsta->sta_id,
+			if (iwl_mvm_flush_sta_tids(mvm, mvmsta->deflink.sta_id,
 						   BIT(tid)))
 				IWL_ERR(mvm, "Couldn't flush the AGG queue\n");
 			iwl_trans_wait_txq_empty(mvm->trans, txq_id);
@@ -3690,7 +3699,7 @@ static int __iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 	if (sta) {
 		struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 
-		sta_id = mvm_sta->sta_id;
+		sta_id = mvm_sta->deflink.sta_id;
 		mfp = sta->mfp;
 	} else if (vif->type == NL80211_IFTYPE_AP &&
 		   !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
@@ -3739,7 +3748,7 @@ int iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 			IWL_ERR(mvm, "Failed to find station\n");
 			return -EINVAL;
 		}
-		sta_id = mvm_sta->sta_id;
+		sta_id = mvm_sta->deflink.sta_id;
 
 		/*
 		 * It is possible that the 'sta' parameter is NULL, and thus
@@ -3834,7 +3843,7 @@ int iwl_mvm_remove_sta_key(struct iwl_mvm *mvm,
 	/* Get the station from the mvm local station table */
 	mvm_sta = iwl_mvm_get_key_sta(mvm, vif, sta);
 	if (mvm_sta)
-		sta_id = mvm_sta->sta_id;
+		sta_id = mvm_sta->deflink.sta_id;
 	else if (!sta && vif->type == NL80211_IFTYPE_AP && mcast)
 		sta_id = iwl_mvm_vif_from_mac80211(vif)->deflink.mcast_sta.sta_id;
 
@@ -3892,7 +3901,7 @@ void iwl_mvm_update_tkip_key(struct iwl_mvm *mvm,
 	mvm_sta = iwl_mvm_get_key_sta(mvm, vif, sta);
 	if (WARN_ON_ONCE(!mvm_sta))
 		goto unlock;
-	iwl_mvm_send_sta_key(mvm, mvm_sta->sta_id, keyconf, mcast,
+	iwl_mvm_send_sta_key(mvm, mvm_sta->deflink.sta_id, keyconf, mcast,
 			     iv32, phase1key, CMD_ASYNC, keyconf->hw_key_idx,
 			     mfp);
 
@@ -3906,7 +3915,7 @@ void iwl_mvm_sta_modify_ps_wake(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_add_sta_cmd cmd = {
 		.add_modify = STA_MODE_MODIFY,
-		.sta_id = mvmsta->sta_id,
+		.sta_id = mvmsta->deflink.sta_id,
 		.station_flags_msk = cpu_to_le32(STA_FLG_PS),
 		.mac_id_n_color = cpu_to_le32(mvmsta->mac_id_n_color),
 	};
@@ -3927,7 +3936,7 @@ void iwl_mvm_sta_modify_sleep_tx_count(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_add_sta_cmd cmd = {
 		.add_modify = STA_MODE_MODIFY,
-		.sta_id = mvmsta->sta_id,
+		.sta_id = mvmsta->deflink.sta_id,
 		.modify_mask = STA_MODIFY_SLEEPING_STA_TX_COUNT,
 		.sleep_tx_count = cpu_to_le16(cnt),
 		.mac_id_n_color = cpu_to_le32(mvmsta->mac_id_n_color),
@@ -4024,7 +4033,7 @@ void iwl_mvm_sta_modify_disable_tx(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_add_sta_cmd cmd = {
 		.add_modify = STA_MODE_MODIFY,
-		.sta_id = mvmsta->sta_id,
+		.sta_id = mvmsta->deflink.sta_id,
 		.station_flags = disable ? cpu_to_le32(STA_FLG_DISABLE_TX) : 0,
 		.station_flags_msk = cpu_to_le32(STA_FLG_DISABLE_TX),
 		.mac_id_n_color = cpu_to_le32(mvmsta->mac_id_n_color),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index a0c13c409ccd..bfd44c489286 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -330,9 +330,27 @@ struct iwl_mvm_rxq_dup_data {
 	u8 last_sub_frame[IWL_MAX_TID_COUNT + 1];
 } ____cacheline_aligned_in_smp;
 
+/**
+ * struct iwl_mvm_link_sta - link specific parameters of a station
+ * @rcu_head: used for freeing the data
+ * @sta_id: the index of the station in the fw
+ * @lq_sta: holds rate scaling data, either for the case when RS is done in
+ *	the driver - %rs_drv or in the FW - %rs_fw.
+ * @avg_energy: energy as reported by FW statistics notification
+ */
+struct iwl_mvm_link_sta {
+	struct rcu_head rcu_head;
+	u32 sta_id;
+	union {
+		struct iwl_lq_sta_rs_fw rs_fw;
+		struct iwl_lq_sta rs_drv;
+	} lq_sta;
+
+	u8 avg_energy;
+};
+
 /**
  * struct iwl_mvm_sta - representation of a station in the driver
- * @sta_id: the index of the station in the fw (will be replaced by id_n_color)
  * @tfd_queue_msk: the tfd queues used by the station
  * @mac_id_n_color: the MAC context this station is linked to
  * @tid_disable_agg: bitmap: if bit(tid) is set, the fw won't send ampdus for
@@ -347,8 +365,6 @@ struct iwl_mvm_rxq_dup_data {
  * and from Tx response flow, it needs a spinlock.
  * @tid_data: per tid data + mgmt. Look at %iwl_mvm_tid_data.
  * @tid_to_baid: a simple map of TID to baid
- * @lq_sta: holds rate scaling data, either for the case when RS is done in
- *	the driver - %rs_drv or in the FW - %rs_fw.
  * @reserved_queue: the queue reserved for this STA for DQA purposes
  *	Every STA has is given one reserved queue to allow it to operate. If no
  *	such queue can be guaranteed, the STA addition will fail.
@@ -374,6 +390,12 @@ struct iwl_mvm_rxq_dup_data {
  *	used during connection establishment (e.g. for the 4 way handshake
  *	exchange).
  * @pairwise_cipher: used to feed iwlmei upon authorization
+ * @deflink: the default link station, for non-MLO STA, all link specific data
+ *	is accessed via deflink (or link[0]). For MLO, it will hold data of the
+ *	first added link STA.
+ * @link: per link sta entries. For non-MLO only link[0] holds data. For MLO,
+ *	link[0] points to deflink and link[link_id] is allocated when new link
+ *	sta is added.
  *
  * When mac80211 creates a station it reserves some space (hw->sta_data_size)
  * in the structure for use by driver. This structure is placed in that
@@ -381,7 +403,6 @@ struct iwl_mvm_rxq_dup_data {
  *
  */
 struct iwl_mvm_sta {
-	u32 sta_id;
 	u32 tfd_queue_msk;
 	u32 mac_id_n_color;
 	u16 tid_disable_agg;
@@ -393,10 +414,6 @@ struct iwl_mvm_sta {
 	spinlock_t lock;
 	struct iwl_mvm_tid_data tid_data[IWL_MAX_TID_COUNT + 1];
 	u8 tid_to_baid[IWL_MAX_TID_COUNT];
-	union {
-		struct iwl_lq_sta_rs_fw rs_fw;
-		struct iwl_lq_sta rs_drv;
-	} lq_sta;
 	struct ieee80211_vif *vif;
 	struct iwl_mvm_key_pn __rcu *ptk_pn[4];
 	struct iwl_mvm_rxq_dup_data *dup_data;
@@ -414,9 +431,11 @@ struct iwl_mvm_sta {
 	bool sleeping;
 	u8 agg_tids;
 	u8 sleep_tx_count;
-	u8 avg_energy;
 	u8 tx_ant;
 	u32 pairwise_cipher;
+
+	struct iwl_mvm_link_sta deflink;
+	struct iwl_mvm_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 674dd137fb9f..dae6f2a1aad9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -369,7 +369,7 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 		goto out;
 	}
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	cmd.peer_sta_id = cpu_to_le32(mvmsta->sta_id);
+	cmd.peer_sta_id = cpu_to_le32(mvmsta->deflink.sta_id);
 
 	if (!chandef) {
 		if (mvm->tdls_cs.state == IWL_MVM_TDLS_SW_REQ_SENT &&
@@ -414,7 +414,7 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 	}
 
 	iwl_mvm_set_tx_cmd(mvm, skb, &tail->frame.tx_cmd, info,
-			   mvmsta->sta_id);
+			   mvmsta->deflink.sta_id);
 
 	iwl_mvm_set_tx_cmd_rate(mvm, &tail->frame.tx_cmd, info, sta,
 				hdr->frame_control);
@@ -431,7 +431,7 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 
 	/* channel switch has started, update state */
 	if (type != TDLS_MOVE_CH) {
-		mvm->tdls_cs.cur_sta_id = mvmsta->sta_id;
+		mvm->tdls_cs.cur_sta_id = mvmsta->deflink.sta_id;
 		iwl_mvm_tdls_update_cs_state(mvm,
 					     type == TDLS_SEND_CHAN_SW_REQ ?
 					     IWL_MVM_TDLS_SW_REQ_SENT :
@@ -541,7 +541,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 	}
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	mvm->tdls_cs.peer.sta_id = mvmsta->sta_id;
+	mvm->tdls_cs.peer.sta_id = mvmsta->deflink.sta_id;
 	mvm->tdls_cs.peer.chandef = *chandef;
 	mvm->tdls_cs.peer.initiator = sta->tdls_initiator;
 	mvm->tdls_cs.peer.op_class = oper_class;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 890fe93896ba..1737f2ad21ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1084,7 +1084,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (WARN_ON_ONCE(!mvmsta))
 		return -1;
 
-	if (WARN_ON_ONCE(mvmsta->sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
 	if (unlikely(ieee80211_is_any_nullfunc(fc)) && sta->deflink.he_cap.has_he)
@@ -1094,7 +1094,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 		iwl_mvm_probe_resp_set_noa(mvm, skb);
 
 	dev_cmd = iwl_mvm_set_tx_params(mvm, skb, info, hdrlen,
-					sta, mvmsta->sta_id);
+					sta, mvmsta->deflink.sta_id);
 	if (!dev_cmd)
 		goto drop;
 
@@ -1170,7 +1170,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	}
 
 	IWL_DEBUG_TX(mvm, "TX to [%d|%d] Q:%d - seq: 0x%x len %d\n",
-		     mvmsta->sta_id, tid, txq_id,
+		     mvmsta->deflink.sta_id, tid, txq_id,
 		     IEEE80211_SEQ_TO_SN(seq_number), skb->len);
 
 	/* From now on, we cannot access info->control */
@@ -1205,7 +1205,8 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	iwl_trans_free_tx_cmd(mvm->trans, dev_cmd);
 	spin_unlock(&mvmsta->lock);
 drop:
-	IWL_DEBUG_TX(mvm, "TX to [%d|%d] dropped\n", mvmsta->sta_id, tid);
+	IWL_DEBUG_TX(mvm, "TX to [%d|%d] dropped\n", mvmsta->deflink.sta_id,
+		     tid);
 	return -1;
 }
 
@@ -1222,7 +1223,7 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (WARN_ON_ONCE(!mvmsta))
 		return -1;
 
-	if (WARN_ON_ONCE(mvmsta->sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
 	memcpy(&info, skb->cb, sizeof(info));
@@ -2230,17 +2231,22 @@ int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids)
 
 int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal)
 {
-	struct iwl_mvm_int_sta *int_sta = sta;
-	struct iwl_mvm_sta *mvm_sta = sta;
+	u32 sta_id, tfd_queue_msk;
 
-	BUILD_BUG_ON(offsetof(struct iwl_mvm_int_sta, sta_id) !=
-		     offsetof(struct iwl_mvm_sta, sta_id));
+	if (internal) {
+		struct iwl_mvm_int_sta *int_sta = sta;
 
-	if (iwl_mvm_has_new_tx_api(mvm))
-		return iwl_mvm_flush_sta_tids(mvm, mvm_sta->sta_id, 0xffff);
+		sta_id = int_sta->sta_id;
+		tfd_queue_msk = int_sta->tfd_queue_msk;
+	} else {
+		struct iwl_mvm_sta *mvm_sta = sta;
 
-	if (internal)
-		return iwl_mvm_flush_tx_path(mvm, int_sta->tfd_queue_msk);
+		sta_id = mvm_sta->deflink.sta_id;
+		tfd_queue_msk = mvm_sta->tfd_queue_msk;
+	}
+
+	if (iwl_mvm_has_new_tx_api(mvm))
+		return iwl_mvm_flush_sta_tids(mvm, sta_id, 0xffff);
 
-	return iwl_mvm_flush_tx_path(mvm, mvm_sta->tfd_queue_msk);
+	return iwl_mvm_flush_tx_path(mvm, tfd_queue_msk);
 }
-- 
2.38.1

