Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A082F9311
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbhAQOxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:33 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40724 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728799AbhAQOx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:26 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Px-003sgA-2R; Sun, 17 Jan 2021 16:52:37 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:26 +0200
Message-Id: <iwlwifi.20210117164916.1935a993b471.I3192c93c030576ca16773c01b009c4d93610d6ea@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 1/9] iwlwifi: mvm: don't send commands during suspend\resume transition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

D3_CONFIG_CMD and D0I3_END_CMD should be the last\first
command upon suspend\resume correspondingly, otherwise,
FW will raise an assert (0x342).

There are firmware notifications that cause the driver to
send a command back to the firmware. If such a notification
is sent to the driver while the the driver prepares the
firmware for D3, operation, what is likely to happen is that
the handling of the notification will try to get the mutex
and will wait unil the driver finished configuring the
firmware for D3. Then the handling notification will get
the mutex and handle the notification which will lead to
the aforementioned ASSERT 342.

To avoid this, we need to prevent any command to be sent to
the firmware between the D3_CONFIG_CMD and the D0I3_END_CMD.
Check this in the utility layer that sends the host commands
and in the transport layer as well.
Flag the D3_CONFIG_CMD and the D0I3_END_CMD commands as
commands that must be sent even if the firmware has already
been configured for D3 operation.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 13 +++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 19 ++++++-------------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  7 +++++--
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  6 ++++++
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  6 ++++++
 6 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index cc76826da5d5..b3ed4fa1dac4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -130,6 +130,19 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 		     test_bit(STATUS_RFKILL_OPMODE, &trans->status)))
 		return -ERFKILL;
 
+	/*
+	 * We can't test IWL_MVM_STATUS_IN_D3 in mvm->status because this
+	 * bit is set early in the D3 flow, before we send all the commands
+	 * that configure the firmware for D3 operation (power, patterns, ...)
+	 * and we don't want to flag all those with CMD_SEND_IN_D3.
+	 * So use the system_pm_mode instead. The only command sent after
+	 * we set system_pm_mode is D3_CONFIG_CMD, which we now flag with
+	 * CMD_SEND_IN_D3.
+	 */
+	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
+		     !(cmd->flags & CMD_SEND_IN_D3)))
+		return -EHOSTDOWN;
+
 	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
 		return -EIO;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index ee97e2df3a1d..619cc9d69eac 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -107,12 +107,16 @@ static inline u32 iwl_rx_packet_payload_len(const struct iwl_rx_packet *pkt)
  *	the response. The caller needs to call iwl_free_resp when done.
  * @CMD_WANT_ASYNC_CALLBACK: the op_mode's async callback function must be
  *	called after this command completes. Valid only with CMD_ASYNC.
+ * @CMD_SEND_IN_D3: Allow the command to be sent in D3 mode, relevant to
+ *	SUSPEND and RESUME commands. We are in D3 mode when we set
+ *	trans->system_pm_mode to IWL_PLAT_PM_MODE_D3.
  */
 enum CMD_MODE {
 	CMD_ASYNC		= BIT(0),
 	CMD_WANT_SKB		= BIT(1),
 	CMD_SEND_IN_RFKILL	= BIT(2),
 	CMD_WANT_ASYNC_CALLBACK	= BIT(3),
+	CMD_SEND_IN_D3          = BIT(4),
 };
 
 #define DEF_CMD_PAYLOAD_SIZE 320
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index cc523fb26f39..f98eb7b71068 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -975,7 +975,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	};
 	struct iwl_host_cmd d3_cfg_cmd = {
 		.id = D3_CONFIG_CMD,
-		.flags = CMD_WANT_SKB,
+		.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
 		.data[0] = &d3_cfg_cmd_data,
 		.len[0] = sizeof(d3_cfg_cmd_data),
 	};
@@ -1067,6 +1067,8 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_fw_dbg_stop_restart_recording(&mvm->fwrt, NULL, true);
 
+	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
+
 	/* must be last -- this switches firmware state */
 	ret = iwl_mvm_send_cmd(mvm, &d3_cfg_cmd);
 	if (ret)
@@ -1105,14 +1107,11 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_trans *trans = mvm->trans;
 
 	iwl_mvm_pause_tcm(mvm, true);
 
 	iwl_fw_runtime_suspend(&mvm->fwrt);
 
-	trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
-
 	return __iwl_mvm_suspend(hw, wowlan, false);
 }
 
@@ -2064,7 +2063,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	if (d0i3_first) {
 		struct iwl_host_cmd cmd = {
 			.id = D0I3_END_CMD,
-			.flags = CMD_WANT_SKB,
+			.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
 		};
 		int len;
 
@@ -2097,6 +2096,8 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		}
 	}
 
+	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
+
 	/*
 	 * Query the current location and source from the D3 firmware so we
 	 * can play it back when we re-intiailize the D0 firmware
@@ -2178,8 +2179,6 @@ int iwl_mvm_resume(struct ieee80211_hw *hw)
 
 	ret = iwl_mvm_resume_d3(mvm);
 
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
-
 	iwl_mvm_resume_tcm(mvm);
 
 	iwl_fw_runtime_resume(&mvm->fwrt);
@@ -2205,10 +2204,6 @@ static int iwl_mvm_d3_test_open(struct inode *inode, struct file *file)
 
 	file->private_data = inode->i_private;
 
-	synchronize_net();
-
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
-
 	iwl_mvm_pause_tcm(mvm, true);
 
 	iwl_fw_runtime_suspend(&mvm->fwrt);
@@ -2278,8 +2273,6 @@ static int iwl_mvm_d3_test_release(struct inode *inode, struct file *file)
 
 	iwl_fw_runtime_resume(&mvm->fwrt);
 
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
-
 	iwl_abort_notification_waits(&mvm->notif_wait);
 	if (!unified_image) {
 		int remaining_time = 10;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index cf1bee04041a..01a0fe86fd0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -45,8 +45,11 @@ int iwl_mvm_send_cmd(struct iwl_mvm *mvm, struct iwl_host_cmd *cmd)
 	if (cmd->flags & CMD_WANT_SKB)
 		return ret;
 
-	/* Silently ignore failures if RFKILL is asserted */
-	if (!ret || ret == -ERFKILL)
+	/*
+	 * Silently ignore failures if RFKILL is asserted or
+	 * we are in suspend\resume process
+	 */
+	if (!ret || ret == -ERFKILL || ret == -EHOSTDOWN)
 		return 0;
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 563d12939854..2c741bc8a5c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -358,6 +358,12 @@ int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 		return -ERFKILL;
 	}
 
+	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
+		     !(cmd->flags & CMD_SEND_IN_D3))) {
+		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
+		return -EHOSTDOWN;
+	}
+
 	if (cmd->flags & CMD_ASYNC) {
 		int ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 67b5fc0b8f3a..0de4c8239d7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1381,6 +1381,12 @@ int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 		return -ERFKILL;
 	}
 
+	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
+		     !(cmd->flags & CMD_SEND_IN_D3))) {
+		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
+		return -EHOSTDOWN;
+	}
+
 	if (cmd->flags & CMD_ASYNC)
 		return iwl_pcie_send_hcmd_async(trans, cmd);
 
-- 
2.29.2

