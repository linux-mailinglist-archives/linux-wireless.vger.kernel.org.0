Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABAC14EDB7
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 14:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgAaNpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 08:45:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:56010 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728708AbgAaNpo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 08:45:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixWcA-0002Nv-0n; Fri, 31 Jan 2020 15:45:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:45:29 +0200
Message-Id: <20200131134530.931641-7-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131134530.931641-1-luca@coelho.fi>
References: <20200131134530.931641-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 6/7] iwlwifi: mvm: fix TDLS discovery with the new firmware API
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

I changed the API for asking for a session protection but
I omitted the TDLS flows. Fix that now.
Note that for the TDLS flow, we need to block until the
session protection actually starts, so add this option
to iwl_mvm_schedule_session_protection.
This patch fixes a firmware assert in the TDLS flow since
the old TIME_EVENT_CMD is not supported anymore by newer
firwmare versions.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: fe959c7b2049 ("iwlwifi: mvm: use the new session protection command")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 10 ++-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 71 ++++++++++++++++---
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  4 +-
 4 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8ecd1f6875de..02df603b6400 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3291,7 +3291,7 @@ static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
 		iwl_mvm_schedule_session_protection(mvm, vif, 900,
-						    min_duration);
+						    min_duration, false);
 	else
 		iwl_mvm_protect_session(mvm, vif, duration,
 					min_duration, 500, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 1851719e9f4b..d781777b6b96 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -205,9 +205,15 @@ void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u32 duration = 2 * vif->bss_conf.dtim_period * vif->bss_conf.beacon_int;
 
-	mutex_lock(&mvm->mutex);
 	/* Protect the session to hear the TDLS setup response on the channel */
-	iwl_mvm_protect_session(mvm, vif, duration, duration, 100, true);
+	mutex_lock(&mvm->mutex);
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
+		iwl_mvm_schedule_session_protection(mvm, vif, duration,
+						    duration, true);
+	else
+		iwl_mvm_protect_session(mvm, vif, duration,
+					duration, 100, true);
 	mutex_unlock(&mvm->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 51b138673ddb..c0b420fe5e48 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1056,13 +1056,42 @@ int iwl_mvm_schedule_csa_period(struct iwl_mvm *mvm,
 	return iwl_mvm_time_event_send_add(mvm, vif, te_data, &time_cmd);
 }
 
+static bool iwl_mvm_session_prot_notif(struct iwl_notif_wait_data *notif_wait,
+				       struct iwl_rx_packet *pkt, void *data)
+{
+	struct iwl_mvm *mvm =
+		container_of(notif_wait, struct iwl_mvm, notif_wait);
+	struct iwl_mvm_session_prot_notif *resp;
+	int resp_len = iwl_rx_packet_payload_len(pkt);
+
+	if (WARN_ON(pkt->hdr.cmd != SESSION_PROTECTION_NOTIF ||
+		    pkt->hdr.group_id != MAC_CONF_GROUP))
+		return true;
+
+	if (WARN_ON_ONCE(resp_len != sizeof(*resp))) {
+		IWL_ERR(mvm, "Invalid SESSION_PROTECTION_NOTIF response\n");
+		return true;
+	}
+
+	resp = (void *)pkt->data;
+
+	if (!resp->status)
+		IWL_ERR(mvm,
+			"TIME_EVENT_NOTIFICATION received but not executed\n");
+
+	return true;
+}
+
 void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
-					 u32 duration, u32 min_duration)
+					 u32 duration, u32 min_duration,
+					 bool wait_for_notif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
-
+	const u16 notif[] = { iwl_cmd_id(SESSION_PROTECTION_NOTIF,
+					 MAC_CONF_GROUP, 0) };
+	struct iwl_notification_wait wait_notif;
 	struct iwl_mvm_session_prot_cmd cmd = {
 		.id_and_color =
 			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
@@ -1071,7 +1100,6 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 		.conf_id = cpu_to_le32(SESSION_PROTECT_CONF_ASSOC),
 		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
 	};
-	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1092,14 +1120,35 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	IWL_DEBUG_TE(mvm, "Add new session protection, duration %d TU\n",
 		     le32_to_cpu(cmd.duration_tu));
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SESSION_PROTECTION_CMD,
-						   MAC_CONF_GROUP, 0),
-				   0, sizeof(cmd), &cmd);
-	if (ret) {
+	if (!wait_for_notif) {
+		if (iwl_mvm_send_cmd_pdu(mvm,
+					 iwl_cmd_id(SESSION_PROTECTION_CMD,
+						    MAC_CONF_GROUP, 0),
+					 0, sizeof(cmd), &cmd)) {
+			IWL_ERR(mvm,
+				"Couldn't send the SESSION_PROTECTION_CMD\n");
+			spin_lock_bh(&mvm->time_event_lock);
+			iwl_mvm_te_clear_data(mvm, te_data);
+			spin_unlock_bh(&mvm->time_event_lock);
+		}
+
+		return;
+	}
+
+	iwl_init_notification_wait(&mvm->notif_wait, &wait_notif,
+				   notif, ARRAY_SIZE(notif),
+				   iwl_mvm_session_prot_notif, NULL);
+
+	if (iwl_mvm_send_cmd_pdu(mvm,
+				 iwl_cmd_id(SESSION_PROTECTION_CMD,
+					    MAC_CONF_GROUP, 0),
+				 0, sizeof(cmd), &cmd)) {
 		IWL_ERR(mvm,
-			"Couldn't send the SESSION_PROTECTION_CMD: %d\n", ret);
-		spin_lock_bh(&mvm->time_event_lock);
-		iwl_mvm_te_clear_data(mvm, te_data);
-		spin_unlock_bh(&mvm->time_event_lock);
+			"Couldn't send the SESSION_PROTECTION_CMD\n");
+		iwl_remove_notification(&mvm->notif_wait, &wait_notif);
+	} else if (iwl_wait_notification(&mvm->notif_wait, &wait_notif,
+					 TU_TO_JIFFIES(100))) {
+		IWL_ERR(mvm,
+			"Failed to protect session until session protection\n");
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index df6832b79666..3186d7e40567 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -250,10 +250,12 @@ iwl_mvm_te_scheduled(struct iwl_mvm_time_event_data *te_data)
  * @mvm: the mvm component
  * @vif: the virtual interface for which the protection issued
  * @duration: the duration of the protection
+ * @wait_for_notif: if true, will block until the start of the protection
  */
 void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
-					 u32 duration, u32 min_duration);
+					 u32 duration, u32 min_duration,
+					 bool wait_for_notif);
 
 /**
  * iwl_mvm_rx_session_protect_notif - handles %SESSION_PROTECTION_NOTIF
-- 
2.24.1

