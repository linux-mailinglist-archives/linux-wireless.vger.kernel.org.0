Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4275E3AC5A9
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhFRIFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48054 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232746AbhFRIDq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RL-001YIf-3h; Fri, 18 Jun 2021 11:01:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:12 +0300
Message-Id: <iwlwifi.20210618105614.7c30f85ed241.Ibc19fdbefca7135f2c4ea83d0aef6b81b5033dcd@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/10] iwlwifi: mvm: Explicitly stop session protection before unbinding
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

In case of unbinding, the FW would remove the session protection time
events without sending a notification, so explicitly cancel the
session protection, so future requests for mgd_prepare_tx() would not
assume that the session protection is running.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 -
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 41 ++++++++++++++-----
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 80dd4506f205..4c9c64210646 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4261,7 +4261,6 @@ static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	struct ieee80211_vif *disabled_vif = NULL;
 
 	lockdep_assert_held(&mvm->mutex);
-
 	iwl_mvm_remove_time_event(mvm, mvmvif, &mvmvif->time_event_data);
 
 	switch (vif->type) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index f19081a6f046..d3307a11fcac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -31,6 +31,13 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 		return;
 
 	list_del(&te_data->list);
+
+	/*
+	 * the list is only used for AUX ROC events so make sure it is always
+	 * initialized
+	 */
+	INIT_LIST_HEAD(&te_data->list);
+
 	te_data->running = false;
 	te_data->uid = 0;
 	te_data->id = TE_MAX;
@@ -609,14 +616,15 @@ void iwl_mvm_protect_session(struct iwl_mvm *mvm,
 }
 
 static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
-					      struct iwl_mvm_vif *mvmvif)
+					      struct iwl_mvm_vif *mvmvif,
+					      u32 id)
 {
 	struct iwl_mvm_session_prot_cmd cmd = {
 		.id_and_color =
 			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
 							mvmvif->color)),
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
-		.conf_id = cpu_to_le32(mvmvif->time_event_data.id),
+		.conf_id = cpu_to_le32(id),
 	};
 	int ret;
 
@@ -634,6 +642,12 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 {
 	u32 id;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(te_data->vif);
+	enum nl80211_iftype iftype;
+
+	if (!te_data->vif)
+		return false;
+
+	iftype = te_data->vif->type;
 
 	/*
 	 * It is possible that by the time we got to this point the time
@@ -658,8 +672,8 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
 		if (mvmvif && id < SESSION_PROTECT_CONF_MAX_ID) {
 			/* Session protection is still ongoing. Cancel it */
-			iwl_mvm_cancel_session_protection(mvm, mvmvif);
-			if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+			iwl_mvm_cancel_session_protection(mvm, mvmvif, id);
+			if (iftype == NL80211_IFTYPE_P2P_DEVICE) {
 				set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
 				iwl_mvm_roc_finished(mvm);
 			}
@@ -740,11 +754,6 @@ void iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 		IWL_ERR(mvm, "Couldn't remove the time event\n");
 }
 
-/*
- * When the firmware supports the session protection API,
- * this is not needed since it'll automatically remove the
- * session protection after association + beacon reception.
- */
 void iwl_mvm_stop_session_protection(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif)
 {
@@ -758,7 +767,15 @@ void iwl_mvm_stop_session_protection(struct iwl_mvm *mvm,
 	id = te_data->id;
 	spin_unlock_bh(&mvm->time_event_lock);
 
-	if (id != TE_BSS_STA_AGGRESSIVE_ASSOC) {
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
+		if (id != SESSION_PROTECT_CONF_ASSOC) {
+			IWL_DEBUG_TE(mvm,
+				     "don't remove session protection id=%u\n",
+				     id);
+			return;
+		}
+	} else if (id != TE_BSS_STA_AGGRESSIVE_ASSOC) {
 		IWL_DEBUG_TE(mvm,
 			     "don't remove TE with id=%u (not session protection)\n",
 			     id);
@@ -985,7 +1002,8 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 		if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-			iwl_mvm_cancel_session_protection(mvm, mvmvif);
+			iwl_mvm_cancel_session_protection(mvm, mvmvif,
+							  mvmvif->time_event_data.id);
 			set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
 		} else {
 			iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
@@ -1145,6 +1163,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 
 	iwl_mvm_te_clear_data(mvm, te_data);
 	te_data->duration = le32_to_cpu(cmd.duration_tu);
+	te_data->vif = vif;
 	spin_unlock_bh(&mvm->time_event_lock);
 
 	IWL_DEBUG_TE(mvm, "Add new session protection, duration %d TU\n",
-- 
2.32.0

