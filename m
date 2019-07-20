Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4E6EF09
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfGTK0F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59446 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homYz-0000Hj-Q2; Sat, 20 Jul 2019 13:26:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:32 +0300
Message-Id: <20190720102545.5952-4-luca@coelho.fi>
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
Subject: [PATCH 03/16] iwlwifi: mvm: add a new RSS sync notification for NSSN sync
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We will soon be using a new notification that will be
initiated by the driver, sent to the firmware and sent
back to all the RSS queues by the firmware. This new
notification will be useful to synchronize the NSSN across
all the queues.

For now, don't send the notification, just add the code to
handle it. Later patch will add the code to actually send
it.

While at it, validate the baid coming from the firmware to
avoid accessing an array with a bad index in the driver.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 84 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  6 ++
 5 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index d55312ef58c9..ed69eec4fcd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -812,10 +812,12 @@ struct iwl_rxq_sync_notification {
  *
  * @IWL_MVM_RXQ_EMPTY: empty sync notification
  * @IWL_MVM_RXQ_NOTIF_DEL_BA: notify RSS queues of delBA
+ * @IWL_MVM_RXQ_NSSN_SYNC: notify all the RSS queues with the new NSSN
  */
 enum iwl_mvm_rxq_notif_type {
 	IWL_MVM_RXQ_EMPTY,
 	IWL_MVM_RXQ_NOTIF_DEL_BA,
+	IWL_MVM_RXQ_NSSN_SYNC,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 48c77af54e99..c1e8b4766b0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1665,8 +1665,8 @@ void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 			      struct iwl_rx_cmd_buffer *rxb, int queue);
 int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
 			    const u8 *data, u32 count);
-void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb,
-			    int queue);
+void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
+			    struct iwl_rx_cmd_buffer *rxb, int queue);
 void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_mfu_assert_dump_notif(struct iwl_mvm *mvm,
 				   struct iwl_rx_cmd_buffer *rxb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d7d6f3398f86..4888054dc3d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1088,7 +1088,7 @@ static void iwl_mvm_rx_mq(struct iwl_op_mode *op_mode,
 		iwl_mvm_rx_mpdu_mq(mvm, napi, rxb, 0);
 	else if (unlikely(cmd == WIDE_ID(DATA_PATH_GROUP,
 					 RX_QUEUES_NOTIFICATION)))
-		iwl_mvm_rx_queue_notif(mvm, rxb, 0);
+		iwl_mvm_rx_queue_notif(mvm, napi, rxb, 0);
 	else if (cmd == WIDE_ID(LEGACY_GROUP, FRAME_RELEASE))
 		iwl_mvm_rx_frame_release(mvm, napi, rxb, 0);
 	else if (cmd == WIDE_ID(DATA_PATH_GROUP, RX_NO_DATA_NOTIF))
@@ -1812,7 +1812,7 @@ static void iwl_mvm_rx_mq_rss(struct iwl_op_mode *op_mode,
 		iwl_mvm_rx_frame_release(mvm, napi, rxb, queue);
 	else if (unlikely(cmd == WIDE_ID(DATA_PATH_GROUP,
 					 RX_QUEUES_NOTIFICATION)))
-		iwl_mvm_rx_queue_notif(mvm, rxb, queue);
+		iwl_mvm_rx_queue_notif(mvm, napi, rxb, queue);
 	else if (likely(cmd == WIDE_ID(LEGACY_GROUP, REPLY_RX_MPDU_CMD)))
 		iwl_mvm_rx_mpdu_mq(mvm, napi, rxb, queue);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 64f950501287..bf097329efa2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -665,8 +665,51 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 	rcu_read_unlock();
 }
 
-void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb,
-			    int queue)
+static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
+					      struct napi_struct *napi,
+					      u8 baid, u16 nssn, int queue)
+{
+	struct ieee80211_sta *sta;
+	struct iwl_mvm_reorder_buffer *reorder_buf;
+	struct iwl_mvm_baid_data *ba_data;
+
+	IWL_DEBUG_HT(mvm, "Frame release notification for BAID %u, NSSN %d\n",
+		     baid, nssn);
+
+	if (WARN_ON_ONCE(baid == IWL_RX_REORDER_DATA_INVALID_BAID ||
+			 baid >= ARRAY_SIZE(mvm->baid_map)))
+		return;
+
+	rcu_read_lock();
+
+	ba_data = rcu_dereference(mvm->baid_map[baid]);
+	if (WARN_ON_ONCE(!ba_data))
+		goto out;
+
+	sta = rcu_dereference(mvm->fw_id_to_mac_id[ba_data->sta_id]);
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta)))
+		goto out;
+
+	reorder_buf = &ba_data->reorder_buf[queue];
+
+	spin_lock_bh(&reorder_buf->lock);
+	iwl_mvm_release_frames(mvm, sta, napi, ba_data, reorder_buf, nssn);
+	spin_unlock_bh(&reorder_buf->lock);
+
+out:
+	rcu_read_unlock();
+}
+
+static void iwl_mvm_nssn_sync(struct iwl_mvm *mvm,
+			      struct napi_struct *napi, int queue,
+			      const struct iwl_mvm_nssn_sync_data *data)
+{
+	iwl_mvm_release_frames_from_notif(mvm, napi, data->baid,
+					  data->nssn, queue);
+}
+
+void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
+			    struct iwl_rx_cmd_buffer *rxb, int queue)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_rxq_sync_notification *notif;
@@ -687,6 +730,10 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb,
 	case IWL_MVM_RXQ_NOTIF_DEL_BA:
 		iwl_mvm_del_ba(mvm, queue, (void *)internal_notif->data);
 		break;
+	case IWL_MVM_RXQ_NSSN_SYNC:
+		iwl_mvm_nssn_sync(mvm, napi, queue,
+				  (void *)internal_notif->data);
+		break;
 	default:
 		WARN_ONCE(1, "Invalid identifier %d", internal_notif->type);
 	}
@@ -1840,40 +1887,13 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 out:
 	rcu_read_unlock();
 }
+
 void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 			      struct iwl_rx_cmd_buffer *rxb, int queue)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_frame_release *release = (void *)pkt->data;
-	struct ieee80211_sta *sta;
-	struct iwl_mvm_reorder_buffer *reorder_buf;
-	struct iwl_mvm_baid_data *ba_data;
-
-	int baid = release->baid;
 
-	IWL_DEBUG_HT(mvm, "Frame release notification for BAID %u, NSSN %d\n",
-		     release->baid, le16_to_cpu(release->nssn));
-
-	if (WARN_ON_ONCE(baid == IWL_RX_REORDER_DATA_INVALID_BAID))
-		return;
-
-	rcu_read_lock();
-
-	ba_data = rcu_dereference(mvm->baid_map[baid]);
-	if (WARN_ON_ONCE(!ba_data))
-		goto out;
-
-	sta = rcu_dereference(mvm->fw_id_to_mac_id[ba_data->sta_id]);
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta)))
-		goto out;
-
-	reorder_buf = &ba_data->reorder_buf[queue];
-
-	spin_lock_bh(&reorder_buf->lock);
-	iwl_mvm_release_frames(mvm, sta, napi, ba_data, reorder_buf,
-			       le16_to_cpu(release->nssn));
-	spin_unlock_bh(&reorder_buf->lock);
-
-out:
-	rcu_read_unlock();
+	iwl_mvm_release_frames_from_notif(mvm, napi, release->baid,
+					  le16_to_cpu(release->nssn), queue);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 79d655b3fce0..4823c06e6909 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -343,10 +343,16 @@ struct iwl_mvm_delba_data {
 	u32 baid;
 } __packed;
 
+struct iwl_mvm_nssn_sync_data {
+	u32 baid;
+	u32 nssn;
+} __packed;
+
 struct iwl_mvm_rss_sync_notif {
 	struct iwl_mvm_internal_rxq_notif metadata;
 	union {
 		struct iwl_mvm_delba_data delba;
+		struct iwl_mvm_nssn_sync_data nssn_sync;
 	};
 } __packed;
 
-- 
2.20.1

