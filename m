Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124D62F91DF
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbhAQLMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:12:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40608 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728089AbhAQLLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:33 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xA-003sZv-RR; Sun, 17 Jan 2021 13:10:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:28 +0200
Message-Id: <iwlwifi.20210117130510.3e155d5e5f90.I2121fa4ac7cd7eb98970d84b793796646afa3eed@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/11] iwlwifi: mvm: add notification size checks
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't trust the firmware with the sizes (or contents)
of notifications, accessing too much data could cause page
faults if the data doesn't fit into the allocated space. This
applies more on older NICs where multiple notifications can
be in a single RX buffer.

Add a general framework for checking a minimum size of any
notification in the RX handlers and use it for most. Some RX
handlers were already checking and I've moved the checks,
some more complex checks I left and made them _NO_SIZE for
the RX handlers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  15 +++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  18 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 121 +++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   6 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  14 +-
 6 files changed, 113 insertions(+), 70 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index ace0ef46001a..8adccd5da095 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -185,6 +185,21 @@ struct iwl_shared_mem_cfg {
 	__le32 rxfifo2_control_size;
 } __packed; /* SHARED_MEM_ALLOC_API_S_VER_4 */
 
+/**
+ * struct iwl_mfuart_load_notif_v1 - mfuart image version & status
+ * ( MFUART_LOAD_NOTIFICATION = 0xb1 )
+ * @installed_ver: installed image version
+ * @external_ver: external image version
+ * @status: MFUART loading status
+ * @duration: MFUART loading time
+*/
+struct iwl_mfuart_load_notif_v1 {
+	__le32 installed_ver;
+	__le32 external_ver;
+	__le32 status;
+	__le32 duration;
+} __packed; /* MFU_LOADER_NTFY_API_S_VER_1 */
+
 /**
  * struct iwl_mfuart_load_notif - mfuart image version & status
  * ( MFUART_LOAD_NOTIFICATION = 0xb1 )
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9078fcb5286c..fd5e08961651 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1289,6 +1289,7 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 			     struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
 	struct iwl_extended_beacon_notif *beacon = (void *)pkt->data;
 	struct iwl_extended_beacon_notif_v5 *beacon_v5 = (void *)pkt->data;
 	struct ieee80211_vif *csa_vif;
@@ -1304,6 +1305,9 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 		struct iwl_mvm_tx_resp *beacon_notify_hdr =
 			&beacon_v5->beacon_notify_hdr;
 
+		if (unlikely(pkt_len < sizeof(*beacon_v5)))
+			return;
+
 		mvm->ibss_manager = beacon_v5->ibss_mgr_status != 0;
 		agg_status = iwl_mvm_get_agg_status(mvm, beacon_notify_hdr);
 		status = le16_to_cpu(agg_status->status) & TX_STATUS_MSK;
@@ -1314,6 +1318,9 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
 			     mvm->ap_last_beacon_gp2,
 			     le32_to_cpu(beacon_notify_hdr->initial_rate));
 	} else {
+		if (unlikely(pkt_len < sizeof(*beacon)))
+			return;
+
 		mvm->ibss_manager = beacon->ibss_mgr_status != 0;
 		status = le32_to_cpu(beacon->status) & TX_STATUS_MSK;
 		IWL_DEBUG_RX(mvm,
@@ -1419,12 +1426,13 @@ void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
 				    struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
 	struct iwl_stored_beacon_notif *sb = (void *)pkt->data;
 	struct ieee80211_rx_status rx_status;
 	struct sk_buff *skb;
 	u32 size = le32_to_cpu(sb->byte_count);
 
-	if (size == 0)
+	if (size == 0 || pkt_len < struct_size(sb, data, size))
 		return;
 
 	skb = alloc_skb(size, GFP_ATOMIC);
@@ -1460,14 +1468,10 @@ void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_probe_resp_data_notif *notif = (void *)pkt->data;
 	struct iwl_probe_resp_data *old_data, *new_data;
-	int len = iwl_rx_packet_payload_len(pkt);
 	u32 id = le32_to_cpu(notif->mac_id);
 	struct ieee80211_vif *vif;
 	struct iwl_mvm_vif *mvmvif;
 
-	if (WARN_ON_ONCE(len < sizeof(*notif)))
-		return;
-
 	IWL_DEBUG_INFO(mvm, "Probe response data notif: noa %d, csa %d\n",
 		       notif->noa_active, notif->csa_counter);
 
@@ -1514,12 +1518,8 @@ void iwl_mvm_channel_switch_noa_notif(struct iwl_mvm *mvm,
 	struct iwl_channel_switch_noa_notif *notif = (void *)pkt->data;
 	struct ieee80211_vif *csa_vif, *vif;
 	struct iwl_mvm_vif *mvmvif;
-	int len = iwl_rx_packet_payload_len(pkt);
 	u32 id_n_color, csa_id, mac_id;
 
-	if (WARN_ON_ONCE(len < sizeof(*notif)))
-		return;
-
 	id_n_color = le32_to_cpu(notif->id_and_color);
 	mac_id = id_n_color & FW_CTXT_ID_MSK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 98f62d78cf9c..286ae1757fc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -169,15 +169,21 @@ enum iwl_rx_handler_context {
  * @fn: the function is called when notification is received
  */
 struct iwl_rx_handlers {
-	u16 cmd_id;
+	u16 cmd_id, min_size;
 	enum iwl_rx_handler_context context;
 	void (*fn)(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
 };
 
-#define RX_HANDLER(_cmd_id, _fn, _context)	\
-	{ .cmd_id = _cmd_id, .fn = _fn, .context = _context }
-#define RX_HANDLER_GRP(_grp, _cmd, _fn, _context)	\
-	{ .cmd_id = WIDE_ID(_grp, _cmd), .fn = _fn, .context = _context }
+#define RX_HANDLER_NO_SIZE(_cmd_id, _fn, _context)		\
+	{ .cmd_id = _cmd_id, .fn = _fn, .context = _context, }
+#define RX_HANDLER_GRP_NO_SIZE(_grp, _cmd, _fn, _context)	\
+	{ .cmd_id = WIDE_ID(_grp, _cmd), .fn = _fn, .context = _context, }
+#define RX_HANDLER(_cmd_id, _fn, _context, _struct)		\
+	{ .cmd_id = _cmd_id, .fn = _fn,				\
+	  .context = _context, .min_size = sizeof(_struct), }
+#define RX_HANDLER_GRP(_grp, _cmd, _fn, _context, _struct)	\
+	{ .cmd_id = WIDE_ID(_grp, _cmd), .fn = _fn,		\
+	  .context = _context, .min_size = sizeof(_struct), }
 
 /*
  * Handlers for fw notifications
@@ -187,85 +193,104 @@ struct iwl_rx_handlers {
  * The handler can be one from three contexts, see &iwl_rx_handler_context
  */
 static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
-	RX_HANDLER(TX_CMD, iwl_mvm_rx_tx_cmd, RX_HANDLER_SYNC),
-	RX_HANDLER(BA_NOTIF, iwl_mvm_rx_ba_notif, RX_HANDLER_SYNC),
+	RX_HANDLER(TX_CMD, iwl_mvm_rx_tx_cmd, RX_HANDLER_SYNC,
+		   struct iwl_mvm_tx_resp),
+	RX_HANDLER(BA_NOTIF, iwl_mvm_rx_ba_notif, RX_HANDLER_SYNC,
+		   struct iwl_mvm_ba_notif),
 
 	RX_HANDLER_GRP(DATA_PATH_GROUP, TLC_MNG_UPDATE_NOTIF,
-		       iwl_mvm_tlc_update_notif, RX_HANDLER_SYNC),
+		       iwl_mvm_tlc_update_notif, RX_HANDLER_SYNC,
+		       struct iwl_tlc_update_notif),
 
 	RX_HANDLER(BT_PROFILE_NOTIFICATION, iwl_mvm_rx_bt_coex_notif,
-		   RX_HANDLER_ASYNC_LOCKED),
-	RX_HANDLER(BEACON_NOTIFICATION, iwl_mvm_rx_beacon_notif,
-		   RX_HANDLER_ASYNC_LOCKED),
-	RX_HANDLER(STATISTICS_NOTIFICATION, iwl_mvm_rx_statistics,
-		   RX_HANDLER_ASYNC_LOCKED),
+		   RX_HANDLER_ASYNC_LOCKED, struct iwl_bt_coex_profile_notif),
+	RX_HANDLER_NO_SIZE(BEACON_NOTIFICATION, iwl_mvm_rx_beacon_notif,
+			   RX_HANDLER_ASYNC_LOCKED),
+	RX_HANDLER_NO_SIZE(STATISTICS_NOTIFICATION, iwl_mvm_rx_statistics,
+			   RX_HANDLER_ASYNC_LOCKED),
 
 	RX_HANDLER(BA_WINDOW_STATUS_NOTIFICATION_ID,
-		   iwl_mvm_window_status_notif, RX_HANDLER_SYNC),
+		   iwl_mvm_window_status_notif, RX_HANDLER_SYNC,
+		   struct iwl_ba_window_status_notif),
 
 	RX_HANDLER(TIME_EVENT_NOTIFICATION, iwl_mvm_rx_time_event_notif,
-		   RX_HANDLER_SYNC),
+		   RX_HANDLER_SYNC, struct iwl_time_event_notif),
 	RX_HANDLER_GRP(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF,
-		       iwl_mvm_rx_session_protect_notif, RX_HANDLER_SYNC),
+		       iwl_mvm_rx_session_protect_notif, RX_HANDLER_SYNC,
+		       struct iwl_mvm_session_prot_notif),
 	RX_HANDLER(MCC_CHUB_UPDATE_CMD, iwl_mvm_rx_chub_update_mcc,
-		   RX_HANDLER_ASYNC_LOCKED),
+		   RX_HANDLER_ASYNC_LOCKED, struct iwl_mcc_chub_notif),
 
-	RX_HANDLER(EOSP_NOTIFICATION, iwl_mvm_rx_eosp_notif, RX_HANDLER_SYNC),
+	RX_HANDLER(EOSP_NOTIFICATION, iwl_mvm_rx_eosp_notif, RX_HANDLER_SYNC,
+		   struct iwl_mvm_eosp_notification),
 
 	RX_HANDLER(SCAN_ITERATION_COMPLETE,
-		   iwl_mvm_rx_lmac_scan_iter_complete_notif, RX_HANDLER_SYNC),
+		   iwl_mvm_rx_lmac_scan_iter_complete_notif, RX_HANDLER_SYNC,
+		   struct iwl_lmac_scan_complete_notif),
 	RX_HANDLER(SCAN_OFFLOAD_COMPLETE,
 		   iwl_mvm_rx_lmac_scan_complete_notif,
-		   RX_HANDLER_ASYNC_LOCKED),
-	RX_HANDLER(MATCH_FOUND_NOTIFICATION, iwl_mvm_rx_scan_match_found,
-		   RX_HANDLER_SYNC),
+		   RX_HANDLER_ASYNC_LOCKED, struct iwl_periodic_scan_complete),
+	RX_HANDLER_NO_SIZE(MATCH_FOUND_NOTIFICATION,
+			   iwl_mvm_rx_scan_match_found,
+			   RX_HANDLER_SYNC),
 	RX_HANDLER(SCAN_COMPLETE_UMAC, iwl_mvm_rx_umac_scan_complete_notif,
-		   RX_HANDLER_ASYNC_LOCKED),
+		   RX_HANDLER_ASYNC_LOCKED, struct iwl_umac_scan_complete),
 	RX_HANDLER(SCAN_ITERATION_COMPLETE_UMAC,
-		   iwl_mvm_rx_umac_scan_iter_complete_notif, RX_HANDLER_SYNC),
+		   iwl_mvm_rx_umac_scan_iter_complete_notif, RX_HANDLER_SYNC,
+		   struct iwl_umac_scan_iter_complete_notif),
 
 	RX_HANDLER(CARD_STATE_NOTIFICATION, iwl_mvm_rx_card_state_notif,
-		   RX_HANDLER_SYNC),
+		   RX_HANDLER_SYNC, struct iwl_card_state_notif),
 
 	RX_HANDLER(MISSED_BEACONS_NOTIFICATION, iwl_mvm_rx_missed_beacons_notif,
-		   RX_HANDLER_SYNC),
+		   RX_HANDLER_SYNC, struct iwl_missed_beacons_notif),
 
-	RX_HANDLER(REPLY_ERROR, iwl_mvm_rx_fw_error, RX_HANDLER_SYNC),
+	RX_HANDLER(REPLY_ERROR, iwl_mvm_rx_fw_error, RX_HANDLER_SYNC,
+		   struct iwl_error_resp),
 	RX_HANDLER(PSM_UAPSD_AP_MISBEHAVING_NOTIFICATION,
-		   iwl_mvm_power_uapsd_misbehaving_ap_notif, RX_HANDLER_SYNC),
-	RX_HANDLER(DTS_MEASUREMENT_NOTIFICATION, iwl_mvm_temp_notif,
-		   RX_HANDLER_ASYNC_LOCKED),
-	RX_HANDLER_GRP(PHY_OPS_GROUP, DTS_MEASUREMENT_NOTIF_WIDE,
-		       iwl_mvm_temp_notif, RX_HANDLER_ASYNC_UNLOCKED),
+		   iwl_mvm_power_uapsd_misbehaving_ap_notif, RX_HANDLER_SYNC,
+		   struct iwl_uapsd_misbehaving_ap_notif),
+	RX_HANDLER_NO_SIZE(DTS_MEASUREMENT_NOTIFICATION, iwl_mvm_temp_notif,
+			   RX_HANDLER_ASYNC_LOCKED),
+	RX_HANDLER_GRP_NO_SIZE(PHY_OPS_GROUP, DTS_MEASUREMENT_NOTIF_WIDE,
+			       iwl_mvm_temp_notif, RX_HANDLER_ASYNC_UNLOCKED),
 	RX_HANDLER_GRP(PHY_OPS_GROUP, CT_KILL_NOTIFICATION,
-		       iwl_mvm_ct_kill_notif, RX_HANDLER_SYNC),
+		       iwl_mvm_ct_kill_notif, RX_HANDLER_SYNC,
+		       struct ct_kill_notif),
 
 	RX_HANDLER(TDLS_CHANNEL_SWITCH_NOTIFICATION, iwl_mvm_rx_tdls_notif,
-		   RX_HANDLER_ASYNC_LOCKED),
+		   RX_HANDLER_ASYNC_LOCKED,
+		   struct iwl_tdls_channel_switch_notif),
 	RX_HANDLER(MFUART_LOAD_NOTIFICATION, iwl_mvm_rx_mfuart_notif,
-		   RX_HANDLER_SYNC),
+		   RX_HANDLER_SYNC, struct iwl_mfuart_load_notif_v1),
 	RX_HANDLER_GRP(LOCATION_GROUP, TOF_RESPONDER_STATS,
-		       iwl_mvm_ftm_responder_stats, RX_HANDLER_ASYNC_LOCKED),
+		       iwl_mvm_ftm_responder_stats, RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_ftm_responder_stats),
 
-	RX_HANDLER_GRP(LOCATION_GROUP, TOF_RANGE_RESPONSE_NOTIF,
-		       iwl_mvm_ftm_range_resp, RX_HANDLER_ASYNC_LOCKED),
-	RX_HANDLER_GRP(LOCATION_GROUP, TOF_LC_NOTIF,
-		       iwl_mvm_ftm_lc_notif, RX_HANDLER_ASYNC_LOCKED),
+	RX_HANDLER_GRP_NO_SIZE(LOCATION_GROUP, TOF_RANGE_RESPONSE_NOTIF,
+			       iwl_mvm_ftm_range_resp, RX_HANDLER_ASYNC_LOCKED),
+	RX_HANDLER_GRP_NO_SIZE(LOCATION_GROUP, TOF_LC_NOTIF,
+			       iwl_mvm_ftm_lc_notif, RX_HANDLER_ASYNC_LOCKED),
 
 	RX_HANDLER_GRP(DEBUG_GROUP, MFU_ASSERT_DUMP_NTF,
-		       iwl_mvm_mfu_assert_dump_notif, RX_HANDLER_SYNC),
+		       iwl_mvm_mfu_assert_dump_notif, RX_HANDLER_SYNC,
+		       struct iwl_mfu_assert_dump_notif),
 	RX_HANDLER_GRP(PROT_OFFLOAD_GROUP, STORED_BEACON_NTF,
-		       iwl_mvm_rx_stored_beacon_notif, RX_HANDLER_SYNC),
+		       iwl_mvm_rx_stored_beacon_notif, RX_HANDLER_SYNC,
+		       struct iwl_stored_beacon_notif),
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MU_GROUP_MGMT_NOTIF,
-		       iwl_mvm_mu_mimo_grp_notif, RX_HANDLER_SYNC),
+		       iwl_mvm_mu_mimo_grp_notif, RX_HANDLER_SYNC,
+		       struct iwl_mu_group_mgmt_notif),
 	RX_HANDLER_GRP(DATA_PATH_GROUP, STA_PM_NOTIF,
-		       iwl_mvm_sta_pm_notif, RX_HANDLER_SYNC),
+		       iwl_mvm_sta_pm_notif, RX_HANDLER_SYNC,
+		       struct iwl_mvm_pm_state_notification),
 	RX_HANDLER_GRP(MAC_CONF_GROUP, PROBE_RESPONSE_DATA_NOTIF,
 		       iwl_mvm_probe_resp_data_notif,
-		       RX_HANDLER_ASYNC_LOCKED),
+		       RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_probe_resp_data_notif),
 	RX_HANDLER_GRP(MAC_CONF_GROUP, CHANNEL_SWITCH_NOA_NOTIF,
 		       iwl_mvm_channel_switch_noa_notif,
-		       RX_HANDLER_SYNC),
+		       RX_HANDLER_SYNC, struct iwl_channel_switch_noa_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -960,6 +985,7 @@ static void iwl_mvm_rx_common(struct iwl_mvm *mvm,
 			      struct iwl_rx_cmd_buffer *rxb,
 			      struct iwl_rx_packet *pkt)
 {
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
 	int i;
 	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
 
@@ -981,6 +1007,9 @@ static void iwl_mvm_rx_common(struct iwl_mvm *mvm,
 		if (rx_h->cmd_id != WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd))
 			continue;
 
+		if (unlikely(pkt_len < rx_h->min_size))
+			return;
+
 		if (rx_h->context == RX_HANDLER_SYNC) {
 			rx_h->fn(mvm, rxb);
 			return;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index f0364add85f9..2a57e51f056a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -874,12 +874,11 @@ void iwl_mvm_window_status_notif(struct iwl_mvm *mvm,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_ba_window_status_notif *notif = (void *)pkt->data;
 	int i;
-	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 
-	if (WARN_ONCE(pkt_len != sizeof(*notif),
-		      "Received window status notification of wrong size (%u)\n",
-		      pkt_len))
-		return;
+	BUILD_BUG_ON(ARRAY_SIZE(notif->ra_tid) != BA_WINDOW_STREAMS_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(notif->mpdu_rx_count) != BA_WINDOW_STREAMS_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(notif->bitmap) != BA_WINDOW_STREAMS_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(notif->start_seq_num) != BA_WINDOW_STREAMS_MAX);
 
 	rcu_read_lock();
 	for (i = 0; i < BA_WINDOW_STREAMS_MAX; i++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 507625f96dd7..9dfe0381cbeb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -156,12 +156,6 @@ void iwl_mvm_ct_kill_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct ct_kill_notif *notif;
-	int len = iwl_rx_packet_payload_len(pkt);
-
-	if (WARN_ON_ONCE(len != sizeof(*notif))) {
-		IWL_ERR(mvm, "Invalid CT_KILL_NOTIFICATION\n");
-		return;
-	}
 
 	notif = (struct ct_kill_notif *)pkt->data;
 	IWL_DEBUG_TEMP(mvm, "CT Kill notification temperature = %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index a983c215df31..7448175c4cd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1840,6 +1840,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
 	int sta_id, tid, txq, index;
 	struct ieee80211_tx_info ba_info = {};
 	struct iwl_mvm_ba_notif *ba_notif;
@@ -1852,8 +1853,12 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		struct iwl_mvm_compressed_ba_notif *ba_res =
 			(void *)pkt->data;
 		u8 lq_color = TX_RES_RATE_TABLE_COL_GET(ba_res->tlc_rate_info);
+		u16 tfd_cnt;
 		int i;
 
+		if (unlikely(sizeof(*ba_res) > pkt_len))
+			return;
+
 		sta_id = ba_res->sta_id;
 		ba_info.status.ampdu_ack_len = (u8)le16_to_cpu(ba_res->done);
 		ba_info.status.ampdu_len = (u8)le16_to_cpu(ba_res->txed);
@@ -1862,8 +1867,9 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		ba_info.status.status_driver_data[0] =
 			(void *)(uintptr_t)ba_res->reduced_txp;
 
-		if (!le16_to_cpu(ba_res->tfd_cnt))
-			goto out;
+		tfd_cnt = le16_to_cpu(ba_res->tfd_cnt);
+		if (!tfd_cnt || struct_size(ba_res, tfd, tfd_cnt) > pkt_len)
+			return;
 
 		rcu_read_lock();
 
@@ -1878,7 +1884,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		 */
 
 		/* Free per TID */
-		for (i = 0; i < le16_to_cpu(ba_res->tfd_cnt); i++) {
+		for (i = 0; i < tfd_cnt; i++) {
 			struct iwl_mvm_compressed_ba_tfd *ba_tfd =
 				&ba_res->tfd[i];
 
@@ -1900,7 +1906,7 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 			iwl_mvm_tx_airtime(mvm, mvmsta,
 					   le32_to_cpu(ba_res->wireless_time));
 		rcu_read_unlock();
-out:
+
 		IWL_DEBUG_TX_REPLY(mvm,
 				   "BA_NOTIFICATION Received from sta_id = %d, flags %x, sent:%d, acked:%d\n",
 				   sta_id, le32_to_cpu(ba_res->flags),
-- 
2.29.2

