Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC9D50FF
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfJLQ3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48758 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729417AbfJLQ3f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:35 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGq-00062r-1I; Sat, 12 Oct 2019 19:29:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:15 +0300
Message-Id: <20191012192536.7c9ca02b16f9.I0532b6ccef24fcec9652beb065c5fbab19f86062@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 04/13] iwlwifi: mvm: use the new session protection command
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware has now a new session protection command.
This new API allows the firmware to manage the protection
needed for association. It'll also remove the event when
the association is complete.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  14 +-
 .../intel/iwlwifi/fw/api/time-event.h         |  80 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  33 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   4 +
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 189 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  21 +-
 7 files changed, 331 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 6b4d59daacd6..69786343aff4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -77,6 +77,16 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @CHANNEL_SWITCH_TIME_EVENT_CMD: &struct iwl_chan_switch_te_cmd
 	 */
 	CHANNEL_SWITCH_TIME_EVENT_CMD = 0x4,
+	/**
+	 * @SESSION_PROTECTION_CMD: &struct iwl_mvm_session_prot_cmd
+	 */
+	SESSION_PROTECTION_CMD = 0x5,
+
+	/**
+	 * @SESSION_PROTECTION_NOTIF: &struct iwl_mvm_session_prot_notif
+	 */
+	SESSION_PROTECTION_NOTIF = 0xFB,
+
 	/**
 	 * @PROBE_RESPONSE_DATA_NOTIF: &struct iwl_probe_resp_data_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index 4621ef93a2cf..416e817d7b4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -393,4 +393,80 @@ struct iwl_hs20_roc_res {
 	__le32 status;
 } __packed; /* HOT_SPOT_RSP_API_S_VER_1 */
 
+/**
+ * enum iwl_mvm_session_prot_conf_id - session protection's configurations
+ * @SESSION_PROTECT_CONF_ASSOC: Start a session protection for association.
+ *	The firmware will allocate two events.
+ *	Valid for BSS_STA and P2P_STA.
+ *	* A rather short event that can't be fragmented and with a very
+ *	high priority. If every goes well (99% of the cases) the
+ *	association should complete within this first event. During
+ *	that event, no other activity will happen in the firmware,
+ *	which is why it can't be too long.
+ *	The length of this event is hard-coded in the firmware: 300TUs.
+ *	* Another event which can be much longer (it's duration is
+ *	configurable by the driver) which has a slightly lower
+ *	priority and that can be fragmented allowing other activities
+ *	to run while this event is running.
+ *	The firmware will automatically remove both events once the driver sets
+ *	the BSS MAC as associated. Neither of the events will be removed
+ *	for the P2P_STA MAC.
+ *	Only the duration is configurable for this protection.
+ * @SESSION_PROTECT_CONF_GO_CLIENT_ASSOC: not used
+ * @SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV: Schedule the P2P Device to be in
+ *	listen mode. Will be fragmented. Valid only on the P2P Device MAC.
+ *	Valid only on the P2P Device MAC. The firmware will take into account
+ *	the duration, the interval and the repetition count.
+ * @SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION: Schedule the P2P Device to be be
+ *	able to run the GO Negotiation. Will not be fragmented and not
+ *	repetitive. Valid only on the P2P Device MAC. Only the duration will
+ *	be taken into account.
+ */
+enum iwl_mvm_session_prot_conf_id {
+	SESSION_PROTECT_CONF_ASSOC,
+	SESSION_PROTECT_CONF_GO_CLIENT_ASSOC,
+	SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV,
+	SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION,
+}; /* SESSION_PROTECTION_CONF_ID_E_VER_1 */
+
+/**
+ * struct iwl_mvm_session_prot_cmd - configure a session protection
+ * @id_and_color: the id and color of the mac for which this session protection
+ *	is sent
+ * @action: can be either FW_CTXT_ACTION_ADD or FW_CTXT_ACTION_REMOVE
+ * @conf_id: see &enum iwl_mvm_session_prot_conf_id
+ * @duration_tu: the duration of the whole protection in TUs.
+ * @repetition_count: not used
+ * @interval: not used
+ *
+ * Note: the session protection will always be scheduled to start as
+ * early as possible, but the maximum delay is configuration dependent.
+ * The firmware supports only one concurrent session protection per vif.
+ * Adding a new session protection will remove any currently running session.
+ */
+struct iwl_mvm_session_prot_cmd {
+	/* COMMON_INDEX_HDR_API_S_VER_1 hdr */
+	__le32 id_and_color;
+	__le32 action;
+	__le32 conf_id;
+	__le32 duration_tu;
+	__le32 repetition_count;
+	__le32 interval;
+} __packed; /* SESSION_PROTECTION_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_mvm_session_prot_notif - session protection started / ended
+ * @mac_id: the mac id for which the session protection started / ended
+ * @status: 1 means success, 0 means failure
+ * @start: 1 means the session protection started, 0 means it ended
+ *
+ * Note that any session protection will always get two notifications: start
+ * and end even the firmware could not schedule it.
+ */
+struct iwl_mvm_session_prot_notif {
+	__le32 mac_id;
+	__le32 status;
+	__le32 start;
+} __packed; /* SESSION_PROTECTION_NOTIFICATION_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_time_event_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 105fd37f7da5..07628566cb4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -445,6 +445,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_CS_MODIFY			= (__force iwl_ucode_tlv_capa_t)49,
 	IWL_UCODE_TLV_CAPA_SET_LTR_GEN2			= (__force iwl_ucode_tlv_capa_t)50,
 	IWL_UCODE_TLV_CAPA_SET_PPAG			= (__force iwl_ucode_tlv_capa_t)52,
+	IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD		= (__force iwl_ucode_tlv_capa_t)54,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index cd1b10042fbf..8465dfe5d90b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2280,7 +2280,9 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 			}
 
 			if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
-				     &mvm->status)) {
+				     &mvm->status) &&
+			    !fw_has_capa(&mvm->fw->ucode_capa,
+					 IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
 				/*
 				 * If we're restarting then the firmware will
 				 * obviously have lost synchronisation with
@@ -2294,6 +2296,10 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 				 *
 				 * Set a large maximum delay to allow for more
 				 * than a single interface.
+				 *
+				 * For new firmware versions, rely on the
+				 * firmware. This is relevant for DCM scenarios
+				 * only anyway.
 				 */
 				u32 dur = (11 * vif->bss_conf.beacon_int) / 10;
 				iwl_mvm_protect_session(mvm, vif, dur, dur,
@@ -2384,8 +2390,11 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		/*
 		 * We received a beacon from the associated AP so
 		 * remove the session protection.
+		 * A firmware with the new API will remove it automatically.
 		 */
-		iwl_mvm_stop_session_protection(mvm, vif);
+		if (!fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
+			iwl_mvm_stop_session_protection(mvm, vif);
 
 		iwl_mvm_sf_update(mvm, vif, false);
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
@@ -3255,8 +3264,22 @@ static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 		duration = req_duration;
 
 	mutex_lock(&mvm->mutex);
-	/* Try really hard to protect the session and hear a beacon */
-	iwl_mvm_protect_session(mvm, vif, duration, min_duration, 500, false);
+	/* Try really hard to protect the session and hear a beacon
+	 * The new session protection command allows us to protect the
+	 * session for a much longer time since the firmware will internally
+	 * create two events: a 300TU one with a very high priority that
+	 * won't be fragmented which should be enough for 99% of the cases,
+	 * and another one (which we configure here to be 900TU long) which
+	 * will have a slightly lower priority, but more importantly, can be
+	 * fragmented so that it'll allow other activities to run.
+	 */
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
+		iwl_mvm_schedule_session_protection(mvm, vif, 900,
+						    min_duration);
+	else
+		iwl_mvm_protect_session(mvm, vif, duration,
+					min_duration, 500, false);
 	mutex_unlock(&mvm->mutex);
 }
 
@@ -3848,7 +3871,7 @@ static int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
 	IWL_DEBUG_MAC80211(mvm, "enter\n");
 
 	mutex_lock(&mvm->mutex);
-	iwl_mvm_stop_roc(mvm);
+	iwl_mvm_stop_roc(mvm, vif);
 	mutex_unlock(&mvm->mutex);
 
 	IWL_DEBUG_MAC80211(mvm, "leave\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index cc4b5554c715..dcdc195ac1d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -263,6 +263,8 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 
 	RX_HANDLER(TIME_EVENT_NOTIFICATION, iwl_mvm_rx_time_event_notif,
 		   RX_HANDLER_SYNC),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF,
+		       iwl_mvm_rx_session_protect_notif, RX_HANDLER_SYNC),
 	RX_HANDLER(MCC_CHUB_UPDATE_CMD, iwl_mvm_rx_chub_update_mcc,
 		   RX_HANDLER_ASYNC_LOCKED),
 
@@ -432,6 +434,8 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
  */
 static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(CHANNEL_SWITCH_TIME_EVENT_CMD),
+	HCMD_NAME(SESSION_PROTECTION_CMD),
+	HCMD_NAME(SESSION_PROTECTION_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_NOA_NOTIF),
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index a06bc63fb516..51b138673ddb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -734,6 +734,11 @@ void iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 		return;
 }
 
+/*
+ * When the firmware supports the session protection API,
+ * this is not needed since it'll automatically remove the
+ * session protection after association + beacon reception.
+ */
 void iwl_mvm_stop_session_protection(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif)
 {
@@ -757,6 +762,101 @@ void iwl_mvm_stop_session_protection(struct iwl_mvm *mvm,
 	iwl_mvm_remove_time_event(mvm, mvmvif, te_data);
 }
 
+void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
+				      struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_mvm_session_prot_notif *notif = (void *)pkt->data;
+	struct ieee80211_vif *vif;
+
+	rcu_read_lock();
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, le32_to_cpu(notif->mac_id),
+					     true);
+
+	if (!vif)
+		goto out_unlock;
+
+	/* The vif is not a P2P_DEVICE, maintain its time_event_data */
+	if (vif->type != NL80211_IFTYPE_P2P_DEVICE) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		struct iwl_mvm_time_event_data *te_data =
+			&mvmvif->time_event_data;
+
+		if (!le32_to_cpu(notif->status)) {
+			iwl_mvm_te_check_disconnect(mvm, vif,
+						    "Session protection failure");
+			iwl_mvm_te_clear_data(mvm, te_data);
+		}
+
+		if (le32_to_cpu(notif->start)) {
+			spin_lock_bh(&mvm->time_event_lock);
+			te_data->running = le32_to_cpu(notif->start);
+			te_data->end_jiffies =
+				TU_TO_EXP_TIME(te_data->duration);
+			spin_unlock_bh(&mvm->time_event_lock);
+		} else {
+			/*
+			 * By now, we should have finished association
+			 * and know the dtim period.
+			 */
+			iwl_mvm_te_check_disconnect(mvm, vif,
+						    "No beacon heard and the session protection is over already...");
+			iwl_mvm_te_clear_data(mvm, te_data);
+		}
+
+		goto out_unlock;
+	}
+
+	if (!le32_to_cpu(notif->status) || !le32_to_cpu(notif->start)) {
+		/* End TE, notify mac80211 */
+		ieee80211_remain_on_channel_expired(mvm->hw);
+		set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
+		iwl_mvm_roc_finished(mvm);
+	} else if (le32_to_cpu(notif->start)) {
+		set_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
+		ieee80211_ready_on_channel(mvm->hw); /* Start TE */
+	}
+
+ out_unlock:
+	rcu_read_unlock();
+}
+
+static int
+iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 int duration,
+					 enum ieee80211_roc_type type)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_session_prot_cmd cmd = {
+		.id_and_color =
+			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
+							mvmvif->color)),
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
+	};
+
+	lockdep_assert_held(&mvm->mutex);
+
+	switch (type) {
+	case IEEE80211_ROC_TYPE_NORMAL:
+		cmd.conf_id =
+			cpu_to_le32(SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV);
+		break;
+	case IEEE80211_ROC_TYPE_MGMT_TX:
+		cmd.conf_id =
+			cpu_to_le32(SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION);
+		break;
+	default:
+		WARN_ONCE(1, "Got an invalid ROC type\n");
+		return -EINVAL;
+	}
+
+	return iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
+						    MAC_CONF_GROUP, 0),
+				    0, sizeof(cmd), &cmd);
+}
+
 int iwl_mvm_start_p2p_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			  int duration, enum ieee80211_roc_type type)
 {
@@ -770,6 +870,12 @@ int iwl_mvm_start_p2p_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return -EBUSY;
 	}
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
+		return iwl_mvm_start_p2p_roc_session_protection(mvm, vif,
+								duration,
+								type);
+
 	time_cmd.action = cpu_to_le32(FW_CTXT_ACTION_ADD);
 	time_cmd.id_and_color =
 		cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id, mvmvif->color));
@@ -847,11 +953,44 @@ void iwl_mvm_cleanup_roc_te(struct iwl_mvm *mvm)
 		__iwl_mvm_remove_time_event(mvm, te_data, &uid);
 }
 
-void iwl_mvm_stop_roc(struct iwl_mvm *mvm)
+static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
+					      struct iwl_mvm_vif *mvmvif)
+{
+	struct iwl_mvm_session_prot_cmd cmd = {
+		.id_and_color =
+			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
+							mvmvif->color)),
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+	};
+	int ret;
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
+						   MAC_CONF_GROUP, 0),
+				   0, sizeof(cmd), &cmd);
+	if (ret)
+		IWL_ERR(mvm,
+			"Couldn't send the SESSION_PROTECTION_CMD: %d\n", ret);
+}
+
+void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif;
 	struct iwl_mvm_time_event_data *te_data;
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
+		mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+		iwl_mvm_cancel_session_protection(mvm, mvmvif);
+
+		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
+			set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
+
+		iwl_mvm_roc_finished(mvm);
+
+		return;
+	}
+
 	te_data = iwl_mvm_get_roc_te(mvm);
 	if (!te_data) {
 		IWL_WARN(mvm, "No remain on channel event\n");
@@ -916,3 +1055,51 @@ int iwl_mvm_schedule_csa_period(struct iwl_mvm *mvm,
 
 	return iwl_mvm_time_event_send_add(mvm, vif, te_data, &time_cmd);
 }
+
+void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 u32 duration, u32 min_duration)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
+
+	struct iwl_mvm_session_prot_cmd cmd = {
+		.id_and_color =
+			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
+							mvmvif->color)),
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
+		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
+	};
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	spin_lock_bh(&mvm->time_event_lock);
+	if (te_data->running &&
+	    time_after(te_data->end_jiffies, TU_TO_EXP_TIME(min_duration))) {
+		IWL_DEBUG_TE(mvm, "We have enough time in the current TE: %u\n",
+			     jiffies_to_msecs(te_data->end_jiffies - jiffies));
+		spin_unlock_bh(&mvm->time_event_lock);
+
+		return;
+	}
+
+	iwl_mvm_te_clear_data(mvm, te_data);
+	te_data->duration = le32_to_cpu(cmd.duration_tu);
+	spin_unlock_bh(&mvm->time_event_lock);
+
+	IWL_DEBUG_TE(mvm, "Add new session protection, duration %d TU\n",
+		     le32_to_cpu(cmd.duration_tu));
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
+						   MAC_CONF_GROUP, 0),
+				   0, sizeof(cmd), &cmd);
+	if (ret) {
+		IWL_ERR(mvm,
+			"Couldn't send the SESSION_PROTECTION_CMD: %d\n", ret);
+		spin_lock_bh(&mvm->time_event_lock);
+		iwl_mvm_te_clear_data(mvm, te_data);
+		spin_unlock_bh(&mvm->time_event_lock);
+	}
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index 1dd3d01245ea..df6832b79666 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -7,6 +7,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
+ * Copyright (C) 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,6 +29,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
+ * Copyright (C) 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -178,12 +180,13 @@ int iwl_mvm_start_p2p_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 /**
  * iwl_mvm_stop_roc - stop remain on channel functionality
  * @mvm: the mvm component
+ * @vif: the virtual interface for which the roc is stopped
  *
  * This function can be used to cancel an ongoing ROC session.
  * The function is async, it will instruct the FW to stop serving the ROC
  * session, but will not wait for the actual stopping of the session.
  */
-void iwl_mvm_stop_roc(struct iwl_mvm *mvm);
+void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 
 /**
  * iwl_mvm_remove_time_event - general function to clean up of time event
@@ -242,4 +245,20 @@ iwl_mvm_te_scheduled(struct iwl_mvm_time_event_data *te_data)
 	return !!te_data->uid;
 }
 
+/**
+ * iwl_mvm_schedule_session_protection - schedule a session protection
+ * @mvm: the mvm component
+ * @vif: the virtual interface for which the protection issued
+ * @duration: the duration of the protection
+ */
+void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 u32 duration, u32 min_duration);
+
+/**
+ * iwl_mvm_rx_session_protect_notif - handles %SESSION_PROTECTION_NOTIF
+ */
+void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
+				      struct iwl_rx_cmd_buffer *rxb);
+
 #endif /* __time_event_h__ */
-- 
2.23.0

