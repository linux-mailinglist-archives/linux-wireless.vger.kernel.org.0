Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59972F91E0
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbhAQLMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:12:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40638 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728271AbhAQLLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xF-003sZv-3j; Sun, 17 Jan 2021 13:10:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:33 +0200
Message-Id: <iwlwifi.20210117130510.4bd0eca8c0ef.I1601aad2eb2cc83f6f73b8ca52be57bb9fd626ab@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/11] iwlwifi: mvm: add support for new flush queue response
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In the new api all the flush in the FW is done before we
get the response and in the response we only get the updated
read pointer and all queued packets don't get anymore rx_tx
per packet to free the queued packet, so driver needs to free
all queued packets on flushed queue at once after flush response.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  26 ++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 122 +++++++++++++-----
 6 files changed, 127 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index b2d8ccf5f5dd..644ced53160a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -855,6 +855,32 @@ struct iwl_tx_path_flush_cmd {
 	__le16 reserved;
 } __packed; /* TX_PATH_FLUSH_CMD_API_S_VER_2 */
 
+#define IWL_TX_FLUSH_QUEUE_RSP 16
+
+/**
+ * struct iwl_flush_queue_info - virtual flush queue info
+ * @queue_num: virtual queue id
+ * @read_before_flush: read pointer before flush
+ * @read_after_flush: read pointer after flush
+ */
+struct iwl_flush_queue_info {
+	__le16 tid;
+	__le16 queue_num;
+	__le16 read_before_flush;
+	__le16 read_after_flush;
+} __packed; /* TFDQ_FLUSH_INFO_API_S_VER_1 */
+
+/**
+ * struct iwl_tx_path_flush_cmd_rsp -- queue/FIFO flush command response
+ * @num_flushed_queues: number of queues in queues array
+ * @queues: all flushed queues
+ */
+struct iwl_tx_path_flush_cmd_rsp {
+	__le16 sta_id;
+	__le16 num_flushed_queues;
+	struct iwl_flush_queue_info queues[IWL_TX_FLUSH_QUEUE_RSP];
+} __packed; /* TX_PATH_FLUSH_CMD_RSP_API_S_VER_1 */
+
 /* Available options for the SCD_QUEUE_CFG HCMD */
 enum iwl_scd_cfg_actions {
 	SCD_CFG_DISABLE_QUEUE		= 0x0,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 8fb7911cfd6c..e8e94bcef3b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -91,7 +91,7 @@ static ssize_t iwl_dbgfs_tx_flush_write(struct iwl_mvm *mvm, char *buf,
 				    "FLUSHING all tids queues on sta_id = %d\n",
 				    flush_arg);
 		mutex_lock(&mvm->mutex);
-		ret = iwl_mvm_flush_sta_tids(mvm, flush_arg, 0xFFFF, 0)
+		ret = iwl_mvm_flush_sta_tids(mvm, flush_arg, 0xFFFF)
 			? : count;
 		mutex_unlock(&mvm->mutex);
 		return ret;
@@ -101,7 +101,7 @@ static ssize_t iwl_dbgfs_tx_flush_write(struct iwl_mvm *mvm, char *buf,
 			    flush_arg);
 
 	mutex_lock(&mvm->mutex);
-	ret =  iwl_mvm_flush_tx_path(mvm, flush_arg, 0) ? : count;
+	ret =  iwl_mvm_flush_tx_path(mvm, flush_arg) ? : count;
 	mutex_unlock(&mvm->mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b323e44fb565..f2bb7776ec7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4684,7 +4684,7 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 		if (drop) {
 			mutex_lock(&mvm->mutex);
 			iwl_mvm_flush_tx_path(mvm,
-				iwl_mvm_flushable_queues(mvm) & queues, 0);
+				iwl_mvm_flushable_queues(mvm) & queues);
 			mutex_unlock(&mvm->mutex);
 		} else {
 			iwl_trans_wait_tx_queues_empty(mvm->trans, queues);
@@ -4702,7 +4702,7 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 			continue;
 
 		if (drop)
-			iwl_mvm_flush_sta_tids(mvm, i, 0xFFFF, 0);
+			iwl_mvm_flush_sta_tids(mvm, i, 0xFFFF);
 		else
 			iwl_mvm_wait_sta_queues_empty(mvm,
 					iwl_mvm_sta_from_mac80211(sta));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e13fe0e0025f..5d022776a2da 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1473,10 +1473,9 @@ const char *iwl_mvm_get_tx_fail_reason(u32 status);
 #else
 static inline const char *iwl_mvm_get_tx_fail_reason(u32 status) { return ""; }
 #endif
-int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk, u32 flags);
+int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk);
 int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal);
-int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id,
-			   u16 tids, u32 flags);
+int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids);
 
 void iwl_mvm_async_handlers_purge(struct iwl_mvm *mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index dc174410bf9c..f54dda8bfdae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3105,11 +3105,11 @@ int iwl_mvm_sta_tx_agg_flush(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 		if (iwl_mvm_has_new_tx_api(mvm)) {
 			if (iwl_mvm_flush_sta_tids(mvm, mvmsta->sta_id,
-						   BIT(tid), 0))
+						   BIT(tid)))
 				IWL_ERR(mvm, "Couldn't flush the AGG queue\n");
 			iwl_trans_wait_txq_empty(mvm->trans, txq_id);
 		} else {
-			if (iwl_mvm_flush_tx_path(mvm, BIT(txq_id), 0))
+			if (iwl_mvm_flush_tx_path(mvm, BIT(txq_id)))
 				IWL_ERR(mvm, "Couldn't flush the AGG queue\n");
 			iwl_trans_wait_tx_queues_empty(mvm->trans, BIT(txq_id));
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 7448175c4cd8..c8c07b7fe0ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1701,7 +1701,8 @@ void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			       int txq, int index,
-			       struct ieee80211_tx_info *ba_info, u32 rate)
+			       struct ieee80211_tx_info *tx_info, u32 rate,
+			       bool is_flush)
 {
 	struct sk_buff_head reclaimed_skbs;
 	struct iwl_mvm_tid_data *tid_data = NULL;
@@ -1744,7 +1745,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		 * frames because before failing a frame the firmware transmits
 		 * it without aggregation at least once.
 		 */
-		info->flags |= IEEE80211_TX_STAT_ACK;
+		if (!is_flush)
+			info->flags |= IEEE80211_TX_STAT_ACK;
 	}
 
 	/*
@@ -1763,7 +1765,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 
 	if (tid_data->txq_id != txq) {
 		IWL_ERR(mvm,
-			"invalid BA notification: Q %d, tid %d\n",
+			"invalid reclaim request: Q %d, tid %d\n",
 			tid_data->txq_id, tid);
 		rcu_read_unlock();
 		return;
@@ -1778,26 +1780,28 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	freed = 0;
 
 	/* pack lq color from tid_data along the reduced txp */
-	ba_info->status.status_driver_data[0] =
+	tx_info->status.status_driver_data[0] =
 		RS_DRV_DATA_PACK(tid_data->lq_color,
-				 ba_info->status.status_driver_data[0]);
-	ba_info->status.status_driver_data[1] = (void *)(uintptr_t)rate;
+				 tx_info->status.status_driver_data[0]);
+	tx_info->status.status_driver_data[1] = (void *)(uintptr_t)rate;
 
 	skb_queue_walk(&reclaimed_skbs, skb) {
 		struct ieee80211_hdr *hdr = (void *)skb->data;
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
-		if (ieee80211_is_data_qos(hdr->frame_control))
-			freed++;
-		else
-			WARN_ON_ONCE(tid != IWL_MAX_TID_COUNT);
+		if (!is_flush) {
+			if (ieee80211_is_data_qos(hdr->frame_control))
+				freed++;
+			else
+				WARN_ON_ONCE(tid != IWL_MAX_TID_COUNT);
+		}
 
 		/* this is the first skb we deliver in this batch */
 		/* put the rate scaling data there */
 		if (freed == 1) {
 			info->flags |= IEEE80211_TX_STAT_AMPDU;
-			memcpy(&info->status, &ba_info->status,
-			       sizeof(ba_info->status));
+			memcpy(&info->status, &tx_info->status,
+			       sizeof(tx_info->status));
 			iwl_mvm_hwrate_to_tx_status(rate, info);
 		}
 	}
@@ -1808,7 +1812,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	 * possible (i.e. first MPDU in the aggregation wasn't acked)
 	 * Still it's important to update RS about sent vs. acked.
 	 */
-	if (skb_queue_empty(&reclaimed_skbs)) {
+	if (!is_flush && skb_queue_empty(&reclaimed_skbs)) {
 		struct ieee80211_chanctx_conf *chanctx_conf = NULL;
 
 		if (mvmsta->vif)
@@ -1818,13 +1822,13 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		if (WARN_ON_ONCE(!chanctx_conf))
 			goto out;
 
-		ba_info->band = chanctx_conf->def.chan->band;
-		iwl_mvm_hwrate_to_tx_status(rate, ba_info);
+		tx_info->band = chanctx_conf->def.chan->band;
+		iwl_mvm_hwrate_to_tx_status(rate, tx_info);
 
 		if (!iwl_mvm_has_tlc_offload(mvm)) {
 			IWL_DEBUG_TX_REPLY(mvm,
 					   "No reclaim. Update rs directly\n");
-			iwl_mvm_rs_tx_status(mvm, sta, tid, ba_info, false);
+			iwl_mvm_rs_tx_status(mvm, sta, tid, tx_info, false);
 		}
 	}
 
@@ -1899,7 +1903,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 					   (int)(le16_to_cpu(ba_tfd->q_num)),
 					   le16_to_cpu(ba_tfd->tfd_index),
 					   &ba_info,
-					   le32_to_cpu(ba_res->tx_rate));
+					   le32_to_cpu(ba_res->tx_rate), false);
 		}
 
 		if (mvmsta)
@@ -1942,7 +1946,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	rcu_read_unlock();
 
 	iwl_mvm_tx_reclaim(mvm, sta_id, tid, txq, index, &ba_info,
-			   tid_data->rate_n_flags);
+			   tid_data->rate_n_flags, false);
 
 	IWL_DEBUG_TX_REPLY(mvm,
 			   "BA_NOTIFICATION Received from %pM, sta_id = %d\n",
@@ -1966,7 +1970,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
  * 2) flush the Tx path
  * 3) wait for the transport queues to be empty
  */
-int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk, u32 flags)
+int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk)
 {
 	int ret;
 	struct iwl_tx_path_flush_cmd_v1 flush_cmd = {
@@ -1975,29 +1979,89 @@ int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk, u32 flags)
 	};
 
 	WARN_ON(iwl_mvm_has_new_tx_api(mvm));
-
-	ret = iwl_mvm_send_cmd_pdu(mvm, TXPATH_FLUSH, flags,
+	ret = iwl_mvm_send_cmd_pdu(mvm, TXPATH_FLUSH, 0,
 				   sizeof(flush_cmd), &flush_cmd);
 	if (ret)
 		IWL_ERR(mvm, "Failed to send flush command (%d)\n", ret);
 	return ret;
 }
 
-int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id,
-			   u16 tids, u32 flags)
+int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids)
 {
 	int ret;
+	struct iwl_tx_path_flush_cmd_rsp *rsp;
 	struct iwl_tx_path_flush_cmd flush_cmd = {
 		.sta_id = cpu_to_le32(sta_id),
 		.tid_mask = cpu_to_le16(tids),
 	};
 
+	struct iwl_host_cmd cmd = {
+		.id = TXPATH_FLUSH,
+		.len = { sizeof(flush_cmd), },
+		.data = { &flush_cmd, },
+	};
+
 	WARN_ON(!iwl_mvm_has_new_tx_api(mvm));
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, TXPATH_FLUSH, flags,
-				   sizeof(flush_cmd), &flush_cmd);
-	if (ret)
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TXPATH_FLUSH, 0) > 0)
+		cmd.flags |= CMD_WANT_SKB;
+
+	IWL_DEBUG_TX_QUEUES(mvm, "flush for sta id %d tid mask 0x%x\n",
+			    sta_id, tids);
+
+	ret = iwl_mvm_send_cmd(mvm, &cmd);
+
+	if (ret) {
 		IWL_ERR(mvm, "Failed to send flush command (%d)\n", ret);
+		return ret;
+	}
+
+	if (cmd.flags & CMD_WANT_SKB) {
+		int i;
+		int num_flushed_queues;
+
+		if (WARN_ON_ONCE(iwl_rx_packet_payload_len(cmd.resp_pkt) != sizeof(*rsp))) {
+			ret = -EIO;
+			goto free_rsp;
+		}
+
+		rsp = (void *)cmd.resp_pkt->data;
+
+		if (WARN_ONCE(le16_to_cpu(rsp->sta_id) != sta_id,
+			      "sta_id %d != rsp_sta_id %d",
+			      sta_id, le16_to_cpu(rsp->sta_id))) {
+			ret = -EIO;
+			goto free_rsp;
+		}
+
+		num_flushed_queues = le16_to_cpu(rsp->num_flushed_queues);
+		if (WARN_ONCE(num_flushed_queues > IWL_TX_FLUSH_QUEUE_RSP,
+			      "num_flushed_queues %d", num_flushed_queues)) {
+			ret = -EIO;
+			goto free_rsp;
+		}
+
+		for (i = 0; i < num_flushed_queues; i++) {
+			struct ieee80211_tx_info tx_info = {};
+			struct iwl_flush_queue_info *queue_info = &rsp->queues[i];
+			int tid = le16_to_cpu(queue_info->tid);
+			int read_before = le16_to_cpu(queue_info->read_before_flush);
+			int read_after = le16_to_cpu(queue_info->read_after_flush);
+			int queue_num = le16_to_cpu(queue_info->queue_num);
+
+			if (tid == IWL_MGMT_TID)
+				tid = IWL_MAX_TID_COUNT;
+
+			IWL_DEBUG_TX_QUEUES(mvm,
+					    "tid %d queue_id %d read-before %d read-after %d\n",
+					    tid, queue_num, read_before, read_after);
+
+			iwl_mvm_tx_reclaim(mvm, sta_id, tid, queue_num, read_after,
+					   &tx_info, 0, true);
+		}
+free_rsp:
+		iwl_free_resp(&cmd);
+	}
 	return ret;
 }
 
@@ -2010,10 +2074,10 @@ int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal)
 		     offsetof(struct iwl_mvm_sta, sta_id));
 
 	if (iwl_mvm_has_new_tx_api(mvm))
-		return iwl_mvm_flush_sta_tids(mvm, mvm_sta->sta_id, 0xffff, 0);
+		return iwl_mvm_flush_sta_tids(mvm, mvm_sta->sta_id, 0xffff);
 
 	if (internal)
-		return iwl_mvm_flush_tx_path(mvm, int_sta->tfd_queue_msk, 0);
+		return iwl_mvm_flush_tx_path(mvm, int_sta->tfd_queue_msk);
 
-	return iwl_mvm_flush_tx_path(mvm, mvm_sta->tfd_queue_msk, 0);
+	return iwl_mvm_flush_tx_path(mvm, mvm_sta->tfd_queue_msk);
 }
-- 
2.29.2

