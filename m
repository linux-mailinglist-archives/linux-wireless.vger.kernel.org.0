Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AE6EF12
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfGTK1U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:27:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59560 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbfGTK1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:27:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZF-0000Hj-8t; Sat, 20 Jul 2019 13:26:19 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:40 +0300
Message-Id: <20190720102545.5952-12-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 11/16] iwlwifi: mvm: send LQ command always ASYNC
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

The only place where the command was sent as SYNC is during
init and this is not really critical. This change is required
for replacing RS mutex with a spinlock (in the subsequent patch),
since SYNC comamnd requres sleeping and thus the flow cannot
be done when holding a spinlock.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 23 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  4 ++--
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fd1764df592f..a263cc629d75 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1813,7 +1813,7 @@ iwl_mvm_vif_dbgfs_clean(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
 
 /* rate scaling */
-int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq, bool sync);
+int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq);
 void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg);
 int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate);
 void rs_update_last_rssi(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index b50a47e86ef0..bd977ec8629b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1328,7 +1328,7 @@ static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
 			IWL_DEBUG_RATE(mvm,
 				       "Too many rates mismatch. Send sync LQ. rs_state %d\n",
 				       lq_sta->rs_state);
-			iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq, false);
+			iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq);
 		}
 		/* Regardless, ignore this status info for outdated rate */
 		return;
@@ -1390,7 +1390,8 @@ static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
 		if (info->status.ampdu_ack_len == 0)
 			info->status.ampdu_len = 1;
 
-		rs_collect_tlc_data(mvm, mvmsta, tid, curr_tbl, tx_resp_rate.index,
+		rs_collect_tlc_data(mvm, mvmsta, tid, curr_tbl,
+				    tx_resp_rate.index,
 				    info->status.ampdu_len,
 				    info->status.ampdu_ack_len);
 
@@ -1833,7 +1834,7 @@ static void rs_update_rate_tbl(struct iwl_mvm *mvm,
 			       struct iwl_scale_tbl_info *tbl)
 {
 	rs_fill_lq_cmd(mvm, sta, lq_sta, &tbl->rate);
-	iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq, false);
+	iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq);
 }
 
 static bool rs_tweak_rate_tbl(struct iwl_mvm *mvm,
@@ -2935,7 +2936,7 @@ void rs_update_last_rssi(struct iwl_mvm *mvm,
 static void rs_initialize_lq(struct iwl_mvm *mvm,
 			     struct ieee80211_sta *sta,
 			     struct iwl_lq_sta *lq_sta,
-			     enum nl80211_band band, bool update)
+			     enum nl80211_band band)
 {
 	struct iwl_scale_tbl_info *tbl;
 	struct rs_rate *rate;
@@ -2965,7 +2966,7 @@ static void rs_initialize_lq(struct iwl_mvm *mvm,
 	rs_set_expected_tpt_table(lq_sta, tbl);
 	rs_fill_lq_cmd(mvm, sta, lq_sta, rate);
 	/* TODO restore station should remember the lq cmd */
-	iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq, !update);
+	iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq);
 }
 
 static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
@@ -3214,7 +3215,7 @@ void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg)
  * Called after adding a new station to initialize rate scaling
  */
 static void rs_drv_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			     enum nl80211_band band, bool update)
+			     enum nl80211_band band)
 {
 	int i, j;
 	struct ieee80211_hw *hw = mvm->hw;
@@ -3294,7 +3295,7 @@ static void rs_drv_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_mvm_reset_frame_stats(mvm);
 #endif
-	rs_initialize_lq(mvm, sta, lq_sta, band, update);
+	rs_initialize_lq(mvm, sta, lq_sta, band);
 }
 
 static void rs_drv_rate_update(void *mvm_r,
@@ -3608,7 +3609,7 @@ static void rs_set_lq_ss_params(struct iwl_mvm *mvm,
 
 		bfersta_ss_params &= ~LQ_SS_BFER_ALLOWED;
 		bfersta_lq_cmd->ss_params = cpu_to_le32(bfersta_ss_params);
-		iwl_mvm_send_lq_cmd(mvm, bfersta_lq_cmd, false);
+		iwl_mvm_send_lq_cmd(mvm, bfersta_lq_cmd);
 
 		ss_params |= LQ_SS_BFER_ALLOWED;
 		IWL_DEBUG_RATE(mvm,
@@ -3774,7 +3775,7 @@ static void rs_program_fix_rate(struct iwl_mvm *mvm,
 
 	if (lq_sta->pers.dbg_fixed_rate) {
 		rs_fill_lq_cmd(mvm, NULL, lq_sta, NULL);
-		iwl_mvm_send_lq_cmd(lq_sta->pers.drv, &lq_sta->lq, false);
+		iwl_mvm_send_lq_cmd(lq_sta->pers.drv, &lq_sta->lq);
 	}
 }
 
@@ -4177,7 +4178,7 @@ void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 		mutex_lock(&mvmsta->lq_sta.rs_drv.mutex);
-		rs_drv_rate_init(mvm, sta, band, update);
+		rs_drv_rate_init(mvm, sta, band);
 		mutex_unlock(&mvmsta->lq_sta.rs_drv.mutex);
 	}
 }
@@ -4209,7 +4210,7 @@ static int rs_drv_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 			lq->flags &= ~LQ_FLAG_USE_RTS_MSK;
 	}
 
-	return iwl_mvm_send_lq_cmd(mvm, lq, false);
+	return iwl_mvm_send_lq_cmd(mvm, lq);
 }
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 23fd3108adb9..88d16b5442e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2978,7 +2978,7 @@ int iwl_mvm_sta_tx_agg_oper(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	IWL_DEBUG_HT(mvm, "Tx aggregation enabled on ra = %pM tid = %d\n",
 		     sta->addr, tid);
 
-	return iwl_mvm_send_lq_cmd(mvm, &mvmsta->lq_sta.rs_drv.lq, false);
+	return iwl_mvm_send_lq_cmd(mvm, &mvmsta->lq_sta.rs_drv.lq);
 }
 
 static void iwl_mvm_unreserve_agg_queue(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 9ecd5f09615a..b8e20a01c192 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -653,12 +653,12 @@ int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
  * this case to clear the state indicating that station creation is in
  * progress.
  */
-int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq, bool sync)
+int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq)
 {
 	struct iwl_host_cmd cmd = {
 		.id = LQ_CMD,
 		.len = { sizeof(struct iwl_lq_cmd), },
-		.flags = sync ? 0 : CMD_ASYNC,
+		.flags = CMD_ASYNC,
 		.data = { lq, },
 	};
 
-- 
2.20.1

