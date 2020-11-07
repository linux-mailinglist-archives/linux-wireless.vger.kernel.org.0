Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424842AA3FB
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgKGIuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:50:19 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58794 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728302AbgKGIuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:50:19 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kbJvL-002on9-Nq; Sat, 07 Nov 2020 10:50:16 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  7 Nov 2020 10:50:08 +0200
Message-Id: <iwlwifi.20201107104557.3642f730333d.I01a98ecde62096d00d171cf34ad775bf80cb0277@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107085011.57943-1-luca@coelho.fi>
References: <20201107085011.57943-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 3/6] iwlwifi: mvm: properly cancel a session protection for P2P
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to feed the configuration id to remove  session protection
properly.
Remember the conf_id when we add the session protection so that we
can give it back when we want to remove the session protection.
While at it, slightly improve the kernel doc for the conf_id
of the notification.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: fe959c7b2049 ("iwlwifi: mvm: use the new session protection command")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/fw/api/time-event.h         |  8 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 94 +++++++++++++------
 2 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index a731f28e101a..53b438d709db 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -421,12 +421,14 @@ struct iwl_hs20_roc_res {
  *	able to run the GO Negotiation. Will not be fragmented and not
  *	repetitive. Valid only on the P2P Device MAC. Only the duration will
  *	be taken into account.
+ * @SESSION_PROTECT_CONF_MAX_ID: not used
  */
 enum iwl_mvm_session_prot_conf_id {
 	SESSION_PROTECT_CONF_ASSOC,
 	SESSION_PROTECT_CONF_GO_CLIENT_ASSOC,
 	SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV,
 	SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION,
+	SESSION_PROTECT_CONF_MAX_ID,
 }; /* SESSION_PROTECTION_CONF_ID_E_VER_1 */
 
 /**
@@ -459,7 +461,7 @@ struct iwl_mvm_session_prot_cmd {
  * @mac_id: the mac id for which the session protection started / ended
  * @status: 1 means success, 0 means failure
  * @start: 1 means the session protection started, 0 means it ended
- * @conf_id: the configuration id of the session that started / eneded
+ * @conf_id: see &enum iwl_mvm_session_prot_conf_id
  *
  * Note that any session protection will always get two notifications: start
  * and end even the firmware could not schedule it.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index a9ebe69a6670..1db6d8d38822 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -641,11 +641,32 @@ void iwl_mvm_protect_session(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
+					      struct iwl_mvm_vif *mvmvif)
+{
+	struct iwl_mvm_session_prot_cmd cmd = {
+		.id_and_color =
+			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
+							mvmvif->color)),
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.conf_id = cpu_to_le32(mvmvif->time_event_data.id),
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
 static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 					struct iwl_mvm_time_event_data *te_data,
 					u32 *uid)
 {
 	u32 id;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(te_data->vif);
 
 	/*
 	 * It is possible that by the time we got to this point the time
@@ -663,14 +684,29 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	iwl_mvm_te_clear_data(mvm, te_data);
 	spin_unlock_bh(&mvm->time_event_lock);
 
-	/*
-	 * It is possible that by the time we try to remove it, the time event
-	 * has already ended and removed. In such a case there is no need to
-	 * send a removal command.
+	/* When session protection is supported, the te_data->id field
+	 * is reused to save session protection's configuration.
 	 */
-	if (id == TE_MAX) {
-		IWL_DEBUG_TE(mvm, "TE 0x%x has already ended\n", *uid);
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
+		if (mvmvif && id < SESSION_PROTECT_CONF_MAX_ID) {
+			/* Session protection is still ongoing. Cancel it */
+			iwl_mvm_cancel_session_protection(mvm, mvmvif);
+			if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+				set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
+				iwl_mvm_roc_finished(mvm);
+			}
+		}
 		return false;
+	} else {
+		/* It is possible that by the time we try to remove it, the
+		 * time event has already ended and removed. In such a case
+		 * there is no need to send a removal command.
+		 */
+		if (id == TE_MAX) {
+			IWL_DEBUG_TE(mvm, "TE 0x%x has already ended\n", *uid);
+			return false;
+		}
 	}
 
 	return true;
@@ -771,6 +807,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mvm_session_prot_notif *notif = (void *)pkt->data;
 	struct ieee80211_vif *vif;
+	struct iwl_mvm_vif *mvmvif;
 
 	rcu_read_lock();
 	vif = iwl_mvm_rcu_dereference_vif_id(mvm, le32_to_cpu(notif->mac_id),
@@ -779,9 +816,10 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 	if (!vif)
 		goto out_unlock;
 
+	mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
 	/* The vif is not a P2P_DEVICE, maintain its time_event_data */
 	if (vif->type != NL80211_IFTYPE_P2P_DEVICE) {
-		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 		struct iwl_mvm_time_event_data *te_data =
 			&mvmvif->time_event_data;
 
@@ -816,10 +854,14 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 
 	if (!le32_to_cpu(notif->status) || !le32_to_cpu(notif->start)) {
 		/* End TE, notify mac80211 */
+		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
 		ieee80211_remain_on_channel_expired(mvm->hw);
 		set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
 		iwl_mvm_roc_finished(mvm);
 	} else if (le32_to_cpu(notif->start)) {
+		if (WARN_ON(mvmvif->time_event_data.id !=
+				le32_to_cpu(notif->conf_id)))
+			goto out_unlock;
 		set_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
 		ieee80211_ready_on_channel(mvm->hw); /* Start TE */
 	}
@@ -845,20 +887,24 @@ iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	/* The time_event_data.id field is reused to save session
+	 * protection's configuration.
+	 */
 	switch (type) {
 	case IEEE80211_ROC_TYPE_NORMAL:
-		cmd.conf_id =
-			cpu_to_le32(SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV);
+		mvmvif->time_event_data.id =
+			SESSION_PROTECT_CONF_P2P_DEVICE_DISCOV;
 		break;
 	case IEEE80211_ROC_TYPE_MGMT_TX:
-		cmd.conf_id =
-			cpu_to_le32(SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION);
+		mvmvif->time_event_data.id =
+			SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION;
 		break;
 	default:
 		WARN_ONCE(1, "Got an invalid ROC type\n");
 		return -EINVAL;
 	}
 
+	cmd.conf_id = cpu_to_le32(mvmvif->time_event_data.id);
 	return iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
 						    MAC_CONF_GROUP, 0),
 				    0, sizeof(cmd), &cmd);
@@ -960,25 +1006,6 @@ void iwl_mvm_cleanup_roc_te(struct iwl_mvm *mvm)
 		__iwl_mvm_remove_time_event(mvm, te_data, &uid);
 }
 
-static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
-					      struct iwl_mvm_vif *mvmvif)
-{
-	struct iwl_mvm_session_prot_cmd cmd = {
-		.id_and_color =
-			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
-							mvmvif->color)),
-		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
-	};
-	int ret;
-
-	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
-						   MAC_CONF_GROUP, 0),
-				   0, sizeof(cmd), &cmd);
-	if (ret)
-		IWL_ERR(mvm,
-			"Couldn't send the SESSION_PROTECTION_CMD: %d\n", ret);
-}
-
 void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif;
@@ -1129,10 +1156,15 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
 							mvmvif->color)),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
-		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
 		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
 	};
 
+	/* The time_event_data.id field is reused to save session
+	 * protection's configuration.
+	 */
+	mvmvif->time_event_data.id = SESSION_PROTECT_CONF_ASSOC;
+	cmd.conf_id = cpu_to_le32(mvmvif->time_event_data.id);
+
 	lockdep_assert_held(&mvm->mutex);
 
 	spin_lock_bh(&mvm->time_event_lock);
-- 
2.28.0

