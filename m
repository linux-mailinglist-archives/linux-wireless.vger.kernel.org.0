Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0849FAC8
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348885AbiA1Nei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37842 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348884AbiA1Nei (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:38 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROd-0002DK-85;
        Fri, 28 Jan 2022 15:34:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:21 +0200
Message-Id: <iwlwifi.20220128153013.ac3af0ff22c7.Ie87c62047b71b93b12aa80b5dc5391b4798dbe97@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/13] iwlwifi: mvm: offload channel switch timing to FW
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

Since FW is now in charge of timing the channel switch, there is no need
to send the add/modify/remove time event command to fw with every (e)CSA
element.
However, the driver needs to cancel the channel switch if the CS start
notification arrives and it does not know about an ongoing channel switch.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 34 +++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 37 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 26 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 20 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 ++
 7 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index d088c820b1a9..712532f17630 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -27,6 +27,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @SESSION_PROTECTION_CMD: &struct iwl_mvm_session_prot_cmd
 	 */
 	SESSION_PROTECTION_CMD = 0x5,
+	/**
+	 * @CANCEL_CHANNEL_SWITCH_CMD: &struct iwl_cancel_channel_switch_cmd
+	 */
+	CANCEL_CHANNEL_SWITCH_CMD = 0x6,
 
 	/**
 	 * @SESSION_PROTECTION_NOTIF: &struct iwl_mvm_session_prot_notif
@@ -42,6 +46,11 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @CHANNEL_SWITCH_START_NOTIF: &struct iwl_channel_switch_start_notif
 	 */
 	CHANNEL_SWITCH_START_NOTIF = 0xFF,
+
+	/**
+	 *@CHANNEL_SWITCH_ERROR_NOTIF: &struct iwl_channel_switch_error_notif
+	 */
+	CHANNEL_SWITCH_ERROR_NOTIF = 0xF9,
 };
 
 #define IWL_P2P_NOA_DESC_COUNT	(2)
@@ -110,6 +119,31 @@ struct iwl_channel_switch_start_notif {
 	__le32 id_and_color;
 } __packed; /* CHANNEL_SWITCH_START_NTFY_API_S_VER_1 */
 
+#define CS_ERR_COUNT_ERROR BIT(0)
+#define CS_ERR_LONG_DELAY_AFTER_CS BIT(1)
+#define CS_ERR_LONG_TX_BLOCK BIT(2)
+#define CS_ERR_TX_BLOCK_TIMER_EXPIRED BIT(3)
+
+/**
+ * struct iwl_channel_switch_error_notif - Channel switch error notification
+ *
+ * @mac_id: the mac for which the ucode sends the notification for
+ * @csa_err_mask: mask of channel switch error that can occur
+ */
+struct iwl_channel_switch_error_notif {
+	__le32 mac_id;
+	__le32 csa_err_mask;
+} __packed; /* CHANNEL_SWITCH_ERROR_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_cancel_channel_switch_cmd - Cancel Channel Switch command
+ *
+ * @mac_id: the mac that should cancel the channel switch
+ */
+struct iwl_cancel_channel_switch_cmd {
+	__le32 mac_id;
+} __packed; /* MAC_CANCEL_CHANNEL_SWITCH_S_VER_1 */
+
 /**
  * struct iwl_chan_switch_te_cmd - Channel Switch Time Event command
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index fd7d4abfb454..bcce3c1c5feb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1602,6 +1602,18 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 		RCU_INIT_POINTER(mvm->csa_vif, NULL);
 		return;
 	case NL80211_IFTYPE_STATION:
+		/*
+		 * if we don't know about an ongoing channel switch,
+		 * make sure FW cancels it
+		 */
+		if (iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
+					    CHANNEL_SWITCH_ERROR_NOTIF,
+					    0) && !vif->csa_active) {
+			IWL_DEBUG_INFO(mvm, "Channel Switch was canceled\n");
+			iwl_mvm_cancel_channel_switch(mvm, vif, mac_id);
+			break;
+		}
+
 		iwl_mvm_csa_client_absent(mvm, vif);
 		cancel_delayed_work(&mvmvif->csa_work);
 		ieee80211_chswitch_done(vif, true);
@@ -1615,6 +1627,31 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 	rcu_read_unlock();
 }
 
+void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
+					struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_channel_switch_error_notif *notif = (void *)pkt->data;
+	struct ieee80211_vif *vif;
+	u32 id = le32_to_cpu(notif->mac_id);
+	u32 csa_err_mask = le32_to_cpu(notif->csa_err_mask);
+
+	rcu_read_lock();
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
+	if (!vif) {
+		rcu_read_unlock();
+		return;
+	}
+
+	IWL_DEBUG_INFO(mvm, "FW reports CSA error: mac_id=%u, csa_err_mask=%u\n",
+		       id, csa_err_mask);
+	if (csa_err_mask & (CS_ERR_COUNT_ERROR |
+			    CS_ERR_LONG_DELAY_AFTER_CS |
+			    CS_ERR_TX_BLOCK_TIMER_EXPIRED))
+		ieee80211_channel_switch_disconnect(vif, true);
+	rcu_read_unlock();
+}
+
 void iwl_mvm_rx_missed_vap_notif(struct iwl_mvm *mvm,
 				 struct iwl_rx_cmd_buffer *rxb)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 65f4fe3ef504..8ef572bcc2ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1414,6 +1414,15 @@ static void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 	};
 
+	/*
+	 * In the new flow since FW is in charge of the timing,
+	 * if driver has canceled the channel switch he will receive the
+	 * CHANNEL_SWITCH_START_NOTIF notification from FW and then cancel it
+	 */
+	if (iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
+				    CHANNEL_SWITCH_ERROR_NOTIF, 0))
+		return;
+
 	IWL_DEBUG_MAC80211(mvm, "Abort CSA on mac %d\n", mvmvif->id);
 
 	mutex_lock(&mvm->mutex);
@@ -4846,6 +4855,15 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 
 		break;
 	case NL80211_IFTYPE_STATION:
+		/*
+		 * In the new flow FW is in charge of timing the switch so there
+		 * is no need for all of this
+		 */
+		if (iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
+					    CHANNEL_SWITCH_ERROR_NOTIF,
+					    0))
+			break;
+
 		/*
 		 * We haven't configured the firmware to be associated yet since
 		 * we don't know the dtim period. In this case, the firmware can't
@@ -4917,6 +4935,14 @@ static void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 		.cs_mode = chsw->block_tx,
 	};
 
+	/*
+	 * In the new flow FW is in charge of timing the switch so there is no
+	 * need for all of this
+	 */
+	if (iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
+				    CHANNEL_SWITCH_ERROR_NOTIF, 0))
+		return;
+
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_CS_MODIFY))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1dcbb0eb63c3..8a0e17adcb56 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1684,6 +1684,8 @@ void iwl_mvm_rx_missed_vap_notif(struct iwl_mvm *mvm,
 				 struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 					struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
+					struct iwl_rx_cmd_buffer *rxb);
 /* Bindings */
 int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 87630d38dc52..1d2a4b711e5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -382,6 +382,10 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(MAC_CONF_GROUP, CHANNEL_SWITCH_START_NOTIF,
 		       iwl_mvm_channel_switch_start_notif,
 		       RX_HANDLER_SYNC, struct iwl_channel_switch_start_notif),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, CHANNEL_SWITCH_ERROR_NOTIF,
+		       iwl_mvm_channel_switch_error_notif,
+		       RX_HANDLER_ASYNC_UNLOCKED,
+		       struct iwl_channel_switch_error_notif),
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
 		       iwl_mvm_rx_monitor_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_datapath_monitor_notif),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index feab0bfcd7a2..5a4a8ffbfc02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3939,7 +3939,7 @@ void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, mvmvif->ap_sta_id);
 
-	if (!WARN_ON(!mvmsta))
+	if (mvmsta)
 		iwl_mvm_sta_modify_disable_tx(mvm, mvmsta, true);
 
 	rcu_read_unlock();
@@ -3998,3 +3998,21 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	iwl_mvm_dealloc_int_sta(mvm, sta);
 	return ret;
 }
+
+void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   u32 mac_id)
+{
+	struct iwl_cancel_channel_switch_cmd cancel_channel_switch_cmd = {
+		.mac_id = cpu_to_le32(mac_id),
+	};
+	int ret;
+
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   iwl_cmd_id(CANCEL_CHANNEL_SWITCH_CMD, MAC_CONF_GROUP, 0),
+				   CMD_ASYNC,
+				   sizeof(cancel_channel_switch_cmd),
+				   &cancel_channel_switch_cmd);
+	if (ret)
+		IWL_ERR(mvm, "Failed to cancel the channel switch\n");
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index e34b82b2a288..f1a4fc3e4038 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -548,4 +548,7 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
 			 u8 *key, u32 key_len);
+void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   u32 mac_id);
 #endif /* __sta_h__ */
-- 
2.34.1

