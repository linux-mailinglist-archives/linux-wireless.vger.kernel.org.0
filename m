Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905A2279391
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgIYVbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52336 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728925AbgIYVbF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvJ0-002J1P-Tc; Sat, 26 Sep 2020 00:31:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:46 +0300
Message-Id: <iwlwifi.20200926002540.72c604b4eda9.I21e75b31a9401870d18747355d4f4305b2fe1db8@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/15] iwlwifi: mvm: process ba-notifications also when sta rcu is invalid
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

The the driver prevents new Tx from being sent during the remove-station
flow is by invalidating the fw_id_to_mac_id rcu of that station.

However, if there was any Tx still in-flight (tx-cmd was sent but the
ba-notif wasn't received yet) the ba-response to those frames is simply
ignored without actually reclaiming anything. This later causes the
driver to think that that some of the station's queues aren't empty when
in practice they are which causes errors in the station remove flow.

Fix this by performing the tx-reclaim also if the rcu is invalid. any DB
that can't be updated due to this is not very important at this stage
since the station is about to be removed soon anyways.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 77 +++++++++++++--------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 2f6484e0d726..a372f32f4571 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1768,9 +1768,9 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			       struct ieee80211_tx_info *ba_info, u32 rate)
 {
 	struct sk_buff_head reclaimed_skbs;
-	struct iwl_mvm_tid_data *tid_data;
+	struct iwl_mvm_tid_data *tid_data = NULL;
 	struct ieee80211_sta *sta;
-	struct iwl_mvm_sta *mvmsta;
+	struct iwl_mvm_sta *mvmsta = NULL;
 	struct sk_buff *skb;
 	int freed;
 
@@ -1784,11 +1784,44 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 
 	/* Reclaiming frames for a station that has been deleted ? */
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta))) {
+	if (WARN_ON_ONCE(!sta)) {
 		rcu_read_unlock();
 		return;
 	}
 
+	__skb_queue_head_init(&reclaimed_skbs);
+
+	/*
+	 * Release all TFDs before the SSN, i.e. all TFDs in front of
+	 * block-ack window (we assume that they've been successfully
+	 * transmitted ... if not, it's too late anyway).
+	 */
+	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs);
+
+	skb_queue_walk(&reclaimed_skbs, skb) {
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+		iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
+
+		memset(&info->status, 0, sizeof(info->status));
+		/* Packet was transmitted successfully, failures come as single
+		 * frames because before failing a frame the firmware transmits
+		 * it without aggregation at least once.
+		 */
+		info->flags |= IEEE80211_TX_STAT_ACK;
+	}
+
+	/*
+	 * It's possible to get a BA response after invalidating the rcu (rcu is
+	 * invalidated in order to prevent new Tx from being sent, but there may
+	 * be some frames already in-flight).
+	 * In this case we just want to reclaim, and could skip all the
+	 * sta-dependent stuff since it's in the middle of being removed
+	 * anyways.
+	 */
+	if (IS_ERR(sta))
+		goto out;
+
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	tid_data = &mvmsta->tid_data[tid];
 
@@ -1800,15 +1833,6 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		return;
 	}
 
-	__skb_queue_head_init(&reclaimed_skbs);
-
-	/*
-	 * Release all TFDs before the SSN, i.e. all TFDs in front of
-	 * block-ack window (we assume that they've been successfully
-	 * transmitted ... if not, it's too late anyway).
-	 */
-	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs);
-
 	spin_lock_bh(&mvmsta->lock);
 
 	tid_data->next_reclaimed = index;
@@ -1832,15 +1856,6 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		else
 			WARN_ON_ONCE(tid != IWL_MAX_TID_COUNT);
 
-		iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
-
-		memset(&info->status, 0, sizeof(info->status));
-		/* Packet was transmitted successfully, failures come as single
-		 * frames because before failing a frame the firmware transmits
-		 * it without aggregation at least once.
-		 */
-		info->flags |= IEEE80211_TX_STAT_ACK;
-
 		/* this is the first skb we deliver in this batch */
 		/* put the rate scaling data there */
 		if (freed == 1) {
@@ -1917,8 +1932,14 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		rcu_read_lock();
 
 		mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, sta_id);
-		if (!mvmsta)
-			goto out_unlock;
+		/*
+		 * It's possible to get a BA response after invalidating the rcu
+		 * (rcu is invalidated in order to prevent new Tx from being
+		 * sent, but there may be some frames already in-flight).
+		 * In this case we just want to reclaim, and could skip all the
+		 * sta-dependent stuff since it's in the middle of being removed
+		 * anyways.
+		 */
 
 		/* Free per TID */
 		for (i = 0; i < le16_to_cpu(ba_res->tfd_cnt); i++) {
@@ -1929,7 +1950,9 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 			if (tid == IWL_MGMT_TID)
 				tid = IWL_MAX_TID_COUNT;
 
-			mvmsta->tid_data[i].lq_color = lq_color;
+			if (mvmsta)
+				mvmsta->tid_data[i].lq_color = lq_color;
+
 			iwl_mvm_tx_reclaim(mvm, sta_id, tid,
 					   (int)(le16_to_cpu(ba_tfd->q_num)),
 					   le16_to_cpu(ba_tfd->tfd_index),
@@ -1937,9 +1960,9 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 					   le32_to_cpu(ba_res->tx_rate));
 		}
 
-		iwl_mvm_tx_airtime(mvm, mvmsta,
-				   le32_to_cpu(ba_res->wireless_time));
-out_unlock:
+		if (mvmsta)
+			iwl_mvm_tx_airtime(mvm, mvmsta,
+					   le32_to_cpu(ba_res->wireless_time));
 		rcu_read_unlock();
 out:
 		IWL_DEBUG_TX_REPLY(mvm,
-- 
2.28.0

