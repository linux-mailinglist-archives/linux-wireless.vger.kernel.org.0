Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4357DA43BB
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfHaJtI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:49:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39634 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726316AbfHaJtH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:49:07 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400I-0002OQ-72; Sat, 31 Aug 2019 12:49:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:42 +0300
Message-Id: <20190831094859.6391-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 02/19] iwlwifi: mvm: simplify the channel switch flow for newer firmware
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Any firmware that supports the new channel switch flow is
able to close / re-open the queues when needed. It takes
into account the channel switch mode etc...
Don't open / close the queues or enable / disable beacon
abort before and after the channel switch in case the
firmware is able to do this by itself.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 81 ++++++++++++-------
 2 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cb22d447fcb8..8c9777424316 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1567,7 +1567,9 @@ void iwl_mvm_channel_switch_noa_notif(struct iwl_mvm *mvm,
 		RCU_INIT_POINTER(mvm->csa_vif, NULL);
 		return;
 	case NL80211_IFTYPE_STATION:
-		iwl_mvm_csa_client_absent(mvm, vif);
+		if (!fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD))
+			iwl_mvm_csa_client_absent(mvm, vif);
 		cancel_delayed_work(&mvmvif->csa_work);
 		ieee80211_chswitch_done(vif, true);
 		break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e49558fb8aa3..e3699df89572 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1326,15 +1326,20 @@ static int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 			goto out_unlock;
 		}
 
-		iwl_mvm_sta_modify_disable_tx(mvm, mvmsta, false);
+		if (!fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD))
+			iwl_mvm_sta_modify_disable_tx(mvm, mvmsta, false);
 
 		iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 
-		ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
-		if (ret)
-			goto out_unlock;
+		if (!fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD)) {
+			ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
+			if (ret)
+				goto out_unlock;
 
-		iwl_mvm_stop_session_protection(mvm, vif);
+			iwl_mvm_stop_session_protection(mvm, vif);
+		}
 	}
 
 	mvmvif->ps_disabled = false;
@@ -4411,6 +4416,42 @@ static int iwl_mvm_schedule_client_csa(struct iwl_mvm *mvm,
 				    0, sizeof(cmd), &cmd);
 }
 
+static int iwl_mvm_old_pre_chan_sw_sta(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_channel_switch *chsw)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u32 apply_time;
+
+	/* Schedule the time event to a bit before beacon 1,
+	 * to make sure we're in the new channel when the
+	 * GO/AP arrives. In case count <= 1 immediately schedule the
+	 * TE (this might result with some packet loss or connection
+	 * loss).
+	 */
+	if (chsw->count <= 1)
+		apply_time = 0;
+	else
+		apply_time = chsw->device_timestamp +
+			((vif->bss_conf.beacon_int * (chsw->count - 1) -
+			  IWL_MVM_CHANNEL_SWITCH_TIME_CLIENT) * 1024);
+
+	if (chsw->block_tx)
+		iwl_mvm_csa_client_absent(mvm, vif);
+
+	if (mvmvif->bf_data.bf_enabled) {
+		int ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+
+		if (ret)
+			return ret;
+	}
+
+	iwl_mvm_schedule_csa_period(mvm, vif, vif->bss_conf.beacon_int,
+				    apply_time);
+
+	return 0;
+}
+
 #define IWL_MAX_CSA_BLOCK_TX 1500
 static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
@@ -4419,7 +4460,6 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct ieee80211_vif *csa_vif;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	u32 apply_time;
 	int ret;
 
 	mutex_lock(&mvm->mutex);
@@ -4463,21 +4503,7 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 
 		break;
 	case NL80211_IFTYPE_STATION:
-		/* Schedule the time event to a bit before beacon 1,
-		 * to make sure we're in the new channel when the
-		 * GO/AP arrives. In case count <= 1 immediately schedule the
-		 * TE (this might result with some packet loss or connection
-		 * loss).
-		 */
-		if (chsw->count <= 1)
-			apply_time = 0;
-		else
-			apply_time = chsw->device_timestamp +
-				((vif->bss_conf.beacon_int * (chsw->count - 1) -
-				  IWL_MVM_CHANNEL_SWITCH_TIME_CLIENT) * 1024);
-
 		if (chsw->block_tx) {
-			iwl_mvm_csa_client_absent(mvm, vif);
 			/*
 			 * In case of undetermined / long time with immediate
 			 * quiet monitor status to gracefully disconnect
@@ -4489,19 +4515,14 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 						      msecs_to_jiffies(IWL_MAX_CSA_BLOCK_TX));
 		}
 
-		if (mvmvif->bf_data.bf_enabled) {
-			ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+		if (!fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD)) {
+			ret = iwl_mvm_old_pre_chan_sw_sta(mvm, vif, chsw);
 			if (ret)
 				goto out_unlock;
-		}
-
-		if (fw_has_capa(&mvm->fw->ucode_capa,
-				IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD))
+		} else {
 			iwl_mvm_schedule_client_csa(mvm, vif, chsw);
-		else
-			iwl_mvm_schedule_csa_period(mvm, vif,
-						    vif->bss_conf.beacon_int,
-						    apply_time);
+		}
 
 		mvmvif->csa_count = chsw->count;
 		mvmvif->csa_misbehave = false;
-- 
2.23.0.rc1

