Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E80127B46
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTMve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54040 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727370AbfLTMve (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkg-0007lx-UD; Fri, 20 Dec 2019 14:51:31 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:14 +0200
Message-Id: <20191220125124.1315679-2-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 01/11] iwlwifi: mvm: update powersave correctly for D3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This fixes a long-standing bug - we haven't been able to check the
firmware image that was loaded for D3/not-D3 since the introduction
of the unified image...

Fix this by keeping a status flag for D3 instead of checking for
the firmware image that's loaded.

This reduces occurrences of checks for IWL_UCODE_WOWLAN to just the
code that actually loads the image or deals with it in other ways.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  6 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 27 +++++++++----------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 43ebb2149b63..8878409d2f07 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -989,6 +989,8 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
+	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
+
 	vif = iwl_mvm_get_bss_vif(mvm);
 	if (IS_ERR_OR_NULL(vif)) {
 		ret = 1;
@@ -1083,6 +1085,8 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 				ieee80211_restart_hw(mvm->hw);
 			}
 		}
+
+		clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 	}
  out_noreset:
 	mutex_unlock(&mvm->mutex);
@@ -1929,6 +1933,8 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 	mutex_lock(&mvm->mutex);
 
+	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
+
 	/* get the BSS vif pointer again */
 	vif = iwl_mvm_get_bss_vif(mvm);
 	if (IS_ERR_OR_NULL(vif))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3ec8de00f3aa..3571b71fc51e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1160,6 +1160,7 @@ struct iwl_mvm {
  * @IWL_MVM_STATUS_ROC_AUX_RUNNING: AUX remain-on-channel is running
  * @IWL_MVM_STATUS_FIRMWARE_RUNNING: firmware is running
  * @IWL_MVM_STATUS_NEED_FLUSH_P2P: need to flush P2P bcast STA
+ * @IWL_MVM_STATUS_IN_D3: in D3 (or at least about to go into it)
  */
 enum iwl_mvm_status {
 	IWL_MVM_STATUS_HW_RFKILL,
@@ -1170,6 +1171,7 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_ROC_AUX_RUNNING,
 	IWL_MVM_STATUS_FIRMWARE_RUNNING,
 	IWL_MVM_STATUS_NEED_FLUSH_P2P,
+	IWL_MVM_STATUS_IN_D3,
 };
 
 /* Keep track of completed init configuration */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 25d7faea1c62..c146303ec73b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -198,7 +198,7 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 		if (!mvmvif->queue_params[ac].uapsd)
 			continue;
 
-		if (mvm->fwrt.cur_fw_img != IWL_UCODE_WOWLAN)
+		if (!test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))
 			cmd->flags |=
 				cpu_to_le16(POWER_FLAGS_ADVANCE_PM_ENA_MSK);
 
@@ -233,15 +233,15 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 		cmd->flags |= cpu_to_le16(POWER_FLAGS_SNOOZE_ENA_MSK);
 		cmd->snooze_interval = cpu_to_le16(IWL_MVM_PS_SNOOZE_INTERVAL);
 		cmd->snooze_window =
-			(mvm->fwrt.cur_fw_img == IWL_UCODE_WOWLAN) ?
+			test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status) ?
 				cpu_to_le16(IWL_MVM_WOWLAN_PS_SNOOZE_WINDOW) :
 				cpu_to_le16(IWL_MVM_PS_SNOOZE_WINDOW);
 	}
 
 	cmd->uapsd_max_sp = mvm->hw->uapsd_max_sp_len;
 
-	if (mvm->fwrt.cur_fw_img == IWL_UCODE_WOWLAN || cmd->flags &
-	    cpu_to_le16(POWER_FLAGS_SNOOZE_ENA_MSK)) {
+	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status) ||
+	    cmd->flags & cpu_to_le16(POWER_FLAGS_SNOOZE_ENA_MSK)) {
 		cmd->rx_data_timeout_uapsd =
 			cpu_to_le32(IWL_MVM_WOWLAN_PS_RX_DATA_TIMEOUT);
 		cmd->tx_data_timeout_uapsd =
@@ -354,8 +354,7 @@ static bool iwl_mvm_power_is_radar(struct ieee80211_vif *vif)
 
 static void iwl_mvm_power_config_skip_dtim(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
-					   struct iwl_mac_power_cmd *cmd,
-					   bool host_awake)
+					   struct iwl_mac_power_cmd *cmd)
 {
 	int dtimper = vif->bss_conf.dtim_period ?: 1;
 	int skip;
@@ -370,7 +369,7 @@ static void iwl_mvm_power_config_skip_dtim(struct iwl_mvm *mvm,
 	if (dtimper >= 10)
 		return;
 
-	if (host_awake) {
+	if (!test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status)) {
 		if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_LP)
 			return;
 		skip = 2;
@@ -390,8 +389,7 @@ static void iwl_mvm_power_config_skip_dtim(struct iwl_mvm *mvm,
 
 static void iwl_mvm_power_build_cmd(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
-				    struct iwl_mac_power_cmd *cmd,
-				    bool host_awake)
+				    struct iwl_mac_power_cmd *cmd)
 {
 	int dtimper, bi;
 	int keep_alive;
@@ -437,9 +435,9 @@ static void iwl_mvm_power_build_cmd(struct iwl_mvm *mvm,
 		cmd->lprx_rssi_threshold = POWER_LPRX_RSSI_THRESHOLD;
 	}
 
-	iwl_mvm_power_config_skip_dtim(mvm, vif, cmd, host_awake);
+	iwl_mvm_power_config_skip_dtim(mvm, vif, cmd);
 
-	if (!host_awake) {
+	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status)) {
 		cmd->rx_data_timeout =
 			cpu_to_le32(IWL_MVM_WOWLAN_PS_RX_DATA_TIMEOUT);
 		cmd->tx_data_timeout =
@@ -512,8 +510,7 @@ static int iwl_mvm_power_send_cmd(struct iwl_mvm *mvm,
 {
 	struct iwl_mac_power_cmd cmd = {};
 
-	iwl_mvm_power_build_cmd(mvm, vif, &cmd,
-				mvm->fwrt.cur_fw_img != IWL_UCODE_WOWLAN);
+	iwl_mvm_power_build_cmd(mvm, vif, &cmd);
 	iwl_mvm_power_log(mvm, &cmd);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	memcpy(&iwl_mvm_vif_from_mac80211(vif)->mac_pwr_cmd, &cmd, sizeof(cmd));
@@ -536,7 +533,7 @@ int iwl_mvm_power_update_device(struct iwl_mvm *mvm)
 		cmd.flags |= cpu_to_le16(DEVICE_POWER_FLAGS_POWER_SAVE_ENA_MSK);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	if ((mvm->fwrt.cur_fw_img == IWL_UCODE_WOWLAN) ?
+	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status) ?
 			mvm->disable_power_off_d3 : mvm->disable_power_off)
 		cmd.flags &=
 			cpu_to_le16(~DEVICE_POWER_FLAGS_POWER_SAVE_ENA_MSK);
@@ -943,7 +940,7 @@ static int iwl_mvm_power_set_ba(struct iwl_mvm *mvm,
 	if (!mvmvif->bf_data.bf_enabled)
 		return 0;
 
-	if (mvm->fwrt.cur_fw_img == IWL_UCODE_WOWLAN)
+	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))
 		cmd.ba_escape_timer = cpu_to_le32(IWL_BA_ESCAPE_TIMER_D3);
 
 	mvmvif->bf_data.ba_enabled = !(!mvmvif->pm_enabled ||
-- 
2.24.0

