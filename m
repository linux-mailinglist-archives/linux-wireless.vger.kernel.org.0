Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB834FC57
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhCaJPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43736 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234680AbhCaJO5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:14:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwA-00087q-2v; Wed, 31 Mar 2021 12:14:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:42 +0300
Message-Id: <iwlwifi.20210331121101.f62833fd9893.I612d7ac1c655ec4880329360e15d207698c750bc@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: mvm: clean up queue sync implementation
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we do queue sync, it's confusing that we have the structures
declared in the FW API header files that aren't really firmware,
and the union is also confusing - especially now in the code that
checks the size on the return.

So rework this: change the type of sync and whether to do it in a
synchronous fashion to arguments, and build the data structure in
the function, so we don't need the union.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 30 ----------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 44 +++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  8 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 58 ++++---------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 10 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  | 38 +++++++++---
 6 files changed, 80 insertions(+), 108 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 2c74db823778..3f13b572915a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -779,36 +779,6 @@ struct iwl_rxq_sync_notification {
 	u8 payload[];
 } __packed; /* MULTI_QUEUE_DRV_SYNC_HDR_CMD_API_S_VER_1 */
 
-/**
- * enum iwl_mvm_rxq_notif_type - Internal message identifier
- *
- * @IWL_MVM_RXQ_EMPTY: empty sync notification
- * @IWL_MVM_RXQ_NOTIF_DEL_BA: notify RSS queues of delBA
- * @IWL_MVM_RXQ_NSSN_SYNC: notify all the RSS queues with the new NSSN
- */
-enum iwl_mvm_rxq_notif_type {
-	IWL_MVM_RXQ_EMPTY,
-	IWL_MVM_RXQ_NOTIF_DEL_BA,
-	IWL_MVM_RXQ_NSSN_SYNC,
-};
-
-/**
- * struct iwl_mvm_internal_rxq_notif - Internal representation of the data sent
- * in &iwl_rxq_sync_cmd. Should be DWORD aligned.
- * FW is agnostic to the payload, so there are no endianity requirements.
- *
- * @type: value from &iwl_mvm_rxq_notif_type
- * @sync: ctrl path is waiting for all notifications to be received
- * @cookie: internal cookie to identify old notifications
- * @data: payload
- */
-struct iwl_mvm_internal_rxq_notif {
-	u16 type;
-	u16 sync;
-	u32 cookie;
-	u8 data[];
-} __packed;
-
 /**
  * enum iwl_mvm_pm_event - type of station PM event
  * @IWL_MVM_PM_EVENT_AWAKE: station woke up
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fbd37a19b6e0..fd35dd31613e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5144,28 +5144,50 @@ static void iwl_mvm_mac_event_callback(struct ieee80211_hw *hw,
 }
 
 void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
-				     struct iwl_mvm_internal_rxq_notif *notif,
-				     u32 size)
+				     enum iwl_mvm_rxq_notif_type type,
+				     bool sync,
+				     const void *data, u32 size)
 {
-	u32 qmask = BIT(mvm->trans->num_rx_queues) - 1;
+	struct {
+		struct iwl_rxq_sync_cmd cmd;
+		struct iwl_mvm_internal_rxq_notif notif;
+	} __packed cmd = {
+		.cmd.rxq_mask = cpu_to_le32(BIT(mvm->trans->num_rx_queues) - 1),
+		.cmd.count =
+			cpu_to_le32(sizeof(struct iwl_mvm_internal_rxq_notif) +
+				    size),
+		.notif.type = type,
+		.notif.sync = sync,
+	};
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DATA_PATH_GROUP, TRIGGER_RX_QUEUES_NOTIF_CMD),
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+		.data[1] = data,
+		.len[1] = size,
+		.flags = sync ? 0 : CMD_ASYNC,
+	};
 	int ret;
 
+	/* size must be a multiple of DWORD */
+	if (WARN_ON(cmd.cmd.count & cpu_to_le32(3)))
+		return;
 
 	if (!iwl_mvm_has_new_rx_api(mvm))
 		return;
 
-	if (notif->sync) {
-		notif->cookie = mvm->queue_sync_cookie;
+	if (sync) {
+		cmd.notif.cookie = mvm->queue_sync_cookie;
 		mvm->queue_sync_state = (1 << mvm->trans->num_rx_queues) - 1;
 	}
 
-	ret = iwl_mvm_notify_rx_queue(mvm, qmask, notif, size, !notif->sync);
+	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to trigger RX queues sync (%d)\n", ret);
 		goto out;
 	}
 
-	if (notif->sync) {
+	if (sync) {
 		lockdep_assert_held(&mvm->mutex);
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
 					 READ_ONCE(mvm->queue_sync_state) == 0 ||
@@ -5177,7 +5199,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	}
 
 out:
-	if (notif->sync) {
+	if (sync) {
 		mvm->queue_sync_state = 0;
 		mvm->queue_sync_cookie++;
 	}
@@ -5186,13 +5208,9 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 static void iwl_mvm_sync_rx_queues(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mvm_internal_rxq_notif data = {
-		.type = IWL_MVM_RXQ_EMPTY,
-		.sync = 1,
-	};
 
 	mutex_lock(&mvm->mutex);
-	iwl_mvm_sync_rx_queues_internal(mvm, &data, sizeof(data));
+	iwl_mvm_sync_rx_queues_internal(mvm, IWL_MVM_RXQ_EMPTY, true, NULL, 0);
 	mutex_unlock(&mvm->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0a963d01b825..e607ad713f88 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1570,9 +1570,6 @@ void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 			      struct iwl_rx_cmd_buffer *rxb, int queue);
 void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 				  struct iwl_rx_cmd_buffer *rxb, int queue);
-int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
-			    const struct iwl_mvm_internal_rxq_notif *notif,
-			    u32 notif_size, bool async);
 void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 			    struct iwl_rx_cmd_buffer *rxb, int queue);
 void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
@@ -2001,8 +1998,9 @@ void iwl_mvm_rx_tdls_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_tdls_ch_switch_work(struct work_struct *work);
 
 void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
-				     struct iwl_mvm_internal_rxq_notif *notif,
-				     u32 size);
+				     enum iwl_mvm_rxq_notif_type type,
+				     bool sync,
+				     const void *data, u32 size);
 void iwl_mvm_reorder_timer_expired(struct timer_list *t);
 struct ieee80211_vif *iwl_mvm_get_bss_vif(struct iwl_mvm *mvm);
 struct ieee80211_vif *iwl_mvm_get_vif_by_macid(struct iwl_mvm *mvm, u32 macid);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c21736f80c29..5d40177dcf06 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -520,37 +520,6 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 	return false;
 }
 
-int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
-			    const struct iwl_mvm_internal_rxq_notif *notif,
-			    u32 notif_size, bool async)
-{
-	u8 buf[sizeof(struct iwl_rxq_sync_cmd) +
-	       sizeof(struct iwl_mvm_rss_sync_notif)];
-	struct iwl_rxq_sync_cmd *cmd = (void *)buf;
-	u32 data_size = sizeof(*cmd) + notif_size;
-	int ret;
-
-	/*
-	 * size must be a multiple of DWORD
-	 * Ensure we don't overflow buf
-	 */
-	if (WARN_ON(notif_size & 3 ||
-		    notif_size > sizeof(struct iwl_mvm_rss_sync_notif)))
-		return -EINVAL;
-
-	cmd->rxq_mask = cpu_to_le32(rxq_mask);
-	cmd->count =  cpu_to_le32(notif_size);
-	cmd->flags = 0;
-	memcpy(cmd->payload, notif, notif_size);
-
-	ret = iwl_mvm_send_cmd_pdu(mvm,
-				   WIDE_ID(DATA_PATH_GROUP,
-					   TRIGGER_RX_QUEUES_NOTIF_CMD),
-				   async ? CMD_ASYNC : 0, data_size, cmd);
-
-	return ret;
-}
-
 /*
  * Returns true if sn2 - buffer_size < sn1 < sn2.
  * To be used only in order to compare reorder buffer head with NSSN.
@@ -566,15 +535,13 @@ static bool iwl_mvm_is_sn_less(u16 sn1, u16 sn2, u16 buffer_size)
 static void iwl_mvm_sync_nssn(struct iwl_mvm *mvm, u8 baid, u16 nssn)
 {
 	if (IWL_MVM_USE_NSSN_SYNC) {
-		struct iwl_mvm_rss_sync_notif notif = {
-			.metadata.type = IWL_MVM_RXQ_NSSN_SYNC,
-			.metadata.sync = 0,
-			.nssn_sync.baid = baid,
-			.nssn_sync.nssn = nssn,
+		struct iwl_mvm_nssn_sync_data notif = {
+			.baid = baid,
+			.nssn = nssn,
 		};
 
-		iwl_mvm_sync_rx_queues_internal(mvm, (void *)&notif,
-						sizeof(notif));
+		iwl_mvm_sync_rx_queues_internal(mvm, IWL_MVM_RXQ_NSSN_SYNC, false,
+						&notif, sizeof(notif));
 	}
 }
 
@@ -823,8 +790,7 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 		      "invalid notification size %d (%d)",
 		      len, (int)(sizeof(*notif) + sizeof(*internal_notif))))
 		return;
-	/* remove only the firmware header, we want all of our payload below */
-	len -= sizeof(*notif);
+	len -= sizeof(*notif) + sizeof(*internal_notif);
 
 	if (internal_notif->sync &&
 	    mvm->queue_sync_cookie != internal_notif->cookie) {
@@ -834,21 +800,19 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	switch (internal_notif->type) {
 	case IWL_MVM_RXQ_EMPTY:
-		WARN_ONCE(len != sizeof(*internal_notif),
-			  "invalid empty notification size %d (%d)",
-			  len, (int)sizeof(*internal_notif));
+		WARN_ONCE(len, "invalid empty notification size %d", len);
 		break;
 	case IWL_MVM_RXQ_NOTIF_DEL_BA:
-		if (WARN_ONCE(len != sizeof(struct iwl_mvm_rss_sync_notif),
+		if (WARN_ONCE(len != sizeof(struct iwl_mvm_delba_data),
 			      "invalid delba notification size %d (%d)",
-			      len, (int)sizeof(struct iwl_mvm_rss_sync_notif)))
+			      len, (int)sizeof(struct iwl_mvm_delba_data)))
 			break;
 		iwl_mvm_del_ba(mvm, queue, (void *)internal_notif->data);
 		break;
 	case IWL_MVM_RXQ_NSSN_SYNC:
-		if (WARN_ONCE(len != sizeof(struct iwl_mvm_rss_sync_notif),
+		if (WARN_ONCE(len != sizeof(struct iwl_mvm_nssn_sync_data),
 			      "invalid nssn sync notification size %d (%d)",
-			      len, (int)sizeof(struct iwl_mvm_rss_sync_notif)))
+			      len, (int)sizeof(struct iwl_mvm_nssn_sync_data)))
 			break;
 		iwl_mvm_nssn_sync(mvm, napi, queue,
 				  (void *)internal_notif->data);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 3a411bbda5fd..f618368eda83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2441,12 +2441,12 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 static void iwl_mvm_sync_rxq_del_ba(struct iwl_mvm *mvm, u8 baid)
 {
-	struct iwl_mvm_rss_sync_notif notif = {
-		.metadata.type = IWL_MVM_RXQ_NOTIF_DEL_BA,
-		.metadata.sync = 1,
-		.delba.baid = baid,
+	struct iwl_mvm_delba_data notif = {
+		.baid = baid,
 	};
-	iwl_mvm_sync_rx_queues_internal(mvm, (void *)&notif, sizeof(notif));
+
+	iwl_mvm_sync_rx_queues_internal(mvm, IWL_MVM_RXQ_NOTIF_DEL_BA, true,
+					&notif, sizeof(notif));
 };
 
 static void iwl_mvm_free_reorder(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 35a18b96aac5..32b4d1935788 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -281,6 +281,36 @@ struct iwl_mvm_key_pn {
 	} ____cacheline_aligned_in_smp q[];
 };
 
+/**
+ * enum iwl_mvm_rxq_notif_type - Internal message identifier
+ *
+ * @IWL_MVM_RXQ_EMPTY: empty sync notification
+ * @IWL_MVM_RXQ_NOTIF_DEL_BA: notify RSS queues of delBA
+ * @IWL_MVM_RXQ_NSSN_SYNC: notify all the RSS queues with the new NSSN
+ */
+enum iwl_mvm_rxq_notif_type {
+	IWL_MVM_RXQ_EMPTY,
+	IWL_MVM_RXQ_NOTIF_DEL_BA,
+	IWL_MVM_RXQ_NSSN_SYNC,
+};
+
+/**
+ * struct iwl_mvm_internal_rxq_notif - Internal representation of the data sent
+ * in &iwl_rxq_sync_cmd. Should be DWORD aligned.
+ * FW is agnostic to the payload, so there are no endianity requirements.
+ *
+ * @type: value from &iwl_mvm_rxq_notif_type
+ * @sync: ctrl path is waiting for all notifications to be received
+ * @cookie: internal cookie to identify old notifications
+ * @data: payload
+ */
+struct iwl_mvm_internal_rxq_notif {
+	u16 type;
+	u16 sync;
+	u32 cookie;
+	u8 data[];
+} __packed;
+
 struct iwl_mvm_delba_data {
 	u32 baid;
 } __packed;
@@ -290,14 +320,6 @@ struct iwl_mvm_nssn_sync_data {
 	u32 nssn;
 } __packed;
 
-struct iwl_mvm_rss_sync_notif {
-	struct iwl_mvm_internal_rxq_notif metadata;
-	union {
-		struct iwl_mvm_delba_data delba;
-		struct iwl_mvm_nssn_sync_data nssn_sync;
-	};
-} __packed;
-
 /**
  * struct iwl_mvm_rxq_dup_data - per station per rx queue data
  * @last_seq: last sequence per tid for duplicate packet detection
-- 
2.31.0

