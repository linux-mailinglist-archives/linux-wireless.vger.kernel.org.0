Return-Path: <linux-wireless+bounces-22373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CABFAA825D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FFD189D518
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603DB27F4F7;
	Sat,  3 May 2025 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/kpbWhi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3127E7F8
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301503; cv=none; b=tv/7UB2RWpyY9CWinMmmKd/efSxd3LdWQKN2ceeIM1wBCWu8QM8zhE56fN54qfJeikWsBZOAJCx3TN5x1JsLkDoYT2qACBCZjYKAk3/T6X8zfbZtLUh/yHO9ptjmwW/42EhFqalPio+kifZdliXlSloz4uIuqYwDApuS0TK3kS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301503; c=relaxed/simple;
	bh=ZUAV8PyrfQseooXRnlECQm4FcRss5saOXF6qaDcNqtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NP1F62icWFgqNBgnI6iqcpiluMqVic6XAHfC7t7uJOpXwbIDTzXg1jECswZ4Up2ZCleJsshWVvFh/58kn+hkh65qoTcxC6Tb98gIn404DvlQz+aGhSg9JUHm63kdgkegM6zZ0BYHdjv73Mxp1sa2ljs2OX9Mp5xTHJvwGLVrnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/kpbWhi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301501; x=1777837501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZUAV8PyrfQseooXRnlECQm4FcRss5saOXF6qaDcNqtI=;
  b=J/kpbWhi8pf0chbOh9hHuTmIITcx6UnF7elm/zh4uepWEybO3L8IO/C5
   taHjvbGH+1SMOMx0u0iaROrzUr0HKBqUgbgSQ+X5LgOPf9j14jyBs4lv/
   T3mBCICnhhVIvEikQIYt6PaLh9zRU7e+6fixLHDluWuESD3XTt7YzyHyQ
   jpp8NM7b/f8oFq86hOqr6Yb/+pKEcZ5QFcpBNSS8s0Rf26sOtx/d7urHv
   dtl1ThV/pdlBWj2MPRCqE113ZmaR+F8gb7rhsPwlo+GdT4AJeafAbc86V
   DVjPVtUGbr+oFJGq0Jz5DLEcMQBnGbCvVseAgYbcAg3wmnHYWiK6T/7iV
   Q==;
X-CSE-ConnectionGUID: giOK3+0CSvm1EpyuYsWUAg==
X-CSE-MsgGUID: vYPy+vePSN+FfROWvUxeYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613263"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613263"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:01 -0700
X-CSE-ConnectionGUID: V2Fz7FauQhyd2bI8HetiUg==
X-CSE-MsgGUID: pmDD8cj1SAeH4XJgPexG/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644289"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: remove PM mode and send-in-D3
Date: Sat,  3 May 2025 22:44:25 +0300
Message-Id: <20250503224231.cc3360761f1e.I72261afc42cee8983198b4660b7d38b7df7963da@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Simplify the logic here by tracking only suspended as a
status bit, and remove CMD_SEND_IN_D3 completely. There
is no value, since the op-mode sets the state and also
sends the commands.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 31 +++++++++++--------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 29 ++---------------
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  3 --
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 22 ++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  6 ----
 7 files changed, 27 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 67f9edcdf8f6..9f1c2870c5b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -342,17 +342,7 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 		     test_bit(STATUS_RFKILL_OPMODE, &trans->status)))
 		return -ERFKILL;
 
-	/*
-	 * We can't test IWL_MVM_STATUS_IN_D3 in mvm->status because this
-	 * bit is set early in the D3 flow, before we send all the commands
-	 * that configure the firmware for D3 operation (power, patterns, ...)
-	 * and we don't want to flag all those with CMD_SEND_IN_D3.
-	 * So use the system_pm_mode instead. The only command sent after
-	 * we set system_pm_mode is D3_CONFIG_CMD, which we now flag with
-	 * CMD_SEND_IN_D3.
-	 */
-	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
-		     !(cmd->flags & CMD_SEND_IN_D3)))
+	if (unlikely(test_bit(STATUS_SUSPENDED, &trans->status)))
 		return -EHOSTDOWN;
 
 	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
@@ -435,6 +425,8 @@ int iwl_trans_start_hw(struct iwl_trans *trans)
 	might_sleep();
 
 	clear_bit(STATUS_TRANS_RESET_IN_PROGRESS, &trans->status);
+	/* opmode may not resume if it detects errors */
+	clear_bit(STATUS_SUSPENDED, &trans->status);
 
 	return iwl_trans_pcie_start_hw(trans);
 }
@@ -525,18 +517,31 @@ IWL_EXPORT_SYMBOL(iwl_trans_dump_data);
 
 int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
 {
+	int err;
+
 	might_sleep();
 
-	return iwl_trans_pcie_d3_suspend(trans, test, reset);
+	err = iwl_trans_pcie_d3_suspend(trans, test, reset);
+
+	if (!err)
+		set_bit(STATUS_SUSPENDED, &trans->status);
+
+	return err;
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_suspend);
 
 int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
 			bool test, bool reset)
 {
+	int err;
+
 	might_sleep();
 
-	return iwl_trans_pcie_d3_resume(trans, status, test, reset);
+	err = iwl_trans_pcie_d3_resume(trans, status, test, reset);
+
+	clear_bit(STATUS_SUSPENDED, &trans->status);
+
+	return err;
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_resume);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 34e386bf96b6..550045438223 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -109,16 +109,12 @@ static inline u32 iwl_rx_packet_payload_len(const struct iwl_rx_packet *pkt)
  *	the response. The caller needs to call iwl_free_resp when done.
  * @CMD_SEND_IN_RFKILL: Send the command even if the NIC is in RF-kill.
  * @CMD_BLOCK_TXQS: Block TXQs while the comment is executing.
- * @CMD_SEND_IN_D3: Allow the command to be sent in D3 mode, relevant to
- *	SUSPEND and RESUME commands. We are in D3 mode when we set
- *	trans->system_pm_mode to IWL_PLAT_PM_MODE_D3.
  */
 enum CMD_MODE {
 	CMD_ASYNC		= BIT(0),
 	CMD_WANT_SKB		= BIT(1),
 	CMD_SEND_IN_RFKILL	= BIT(2),
 	CMD_BLOCK_TXQS		= BIT(3),
-	CMD_SEND_IN_D3          = BIT(4),
 };
 #define CMD_MODE_BITS 5
 
@@ -306,6 +302,8 @@ enum iwl_d3_status {
  *	the firmware state yet
  * @STATUS_TRANS_RESET_IN_PROGRESS: reset is still in progress, don't
  *	attempt another reset yet
+ * @STATUS_SUSPENDED: device is suspended, don't send commands that
+ *	aren't marked accordingly
  */
 enum iwl_trans_status {
 	STATUS_SYNC_HCMD_ACTIVE,
@@ -320,6 +318,7 @@ enum iwl_trans_status {
 	STATUS_IN_SW_RESET,
 	STATUS_RESET_PENDING,
 	STATUS_TRANS_RESET_IN_PROGRESS,
+	STATUS_SUSPENDED,
 };
 
 static inline int
@@ -516,23 +515,6 @@ enum iwl_trans_state {
  * be confused with the physical device power state.
  */
 
-/**
- * enum iwl_plat_pm_mode - platform power management mode
- *
- * This enumeration describes the device's platform power management
- * behavior when in system-wide suspend (i.e WoWLAN).
- *
- * @IWL_PLAT_PM_MODE_DISABLED: power management is disabled for this
- *	device.  In system-wide suspend mode, it means that the all
- *	connections will be closed automatically by mac80211 before
- *	the platform is suspended.
- * @IWL_PLAT_PM_MODE_D3: the device goes into D3 mode (i.e. WoWLAN).
- */
-enum iwl_plat_pm_mode {
-	IWL_PLAT_PM_MODE_DISABLED,
-	IWL_PLAT_PM_MODE_D3,
-};
-
 /**
  * enum iwl_ini_cfg_state
  * @IWL_INI_CFG_STATE_NOT_LOADED: no debug cfg was given
@@ -869,9 +851,6 @@ struct iwl_txq {
  *	start of the 802.11 header in the @rx_mpdu_cmd
  * @dbg: additional debug data, see &struct iwl_trans_debug
  * @init_dram: FW initialization DMA data
- * @system_pm_mode: the system-wide power management mode in use.
- *	This mode is set dynamically, depending on the WoWLAN values
- *	configured from the userspace at runtime.
  * @name: the device name
  * @mbx_addr_0_step: step address data 0
  * @mbx_addr_1_step: step address data 1
@@ -951,8 +930,6 @@ struct iwl_trans {
 	struct iwl_trans_debug dbg;
 	struct iwl_self_init_dram init_dram;
 
-	enum iwl_plat_pm_mode system_pm_mode;
-
 	const char *name;
 	u32 mbx_addr_0_step;
 	u32 mbx_addr_1_step;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 21b20e07aab4..f90043728689 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1346,7 +1346,6 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 	} else {
 		/* Async notification might send hcmds, which is not allowed in suspend */
 		iwl_mld_cancel_async_notifications(mld);
-		mld->trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
 		mld->fw_status.in_d3 = true;
 	}
 
@@ -1371,7 +1370,6 @@ int iwl_mld_no_wowlan_resume(struct iwl_mld *mld)
 
 	IWL_DEBUG_WOWLAN(mld, "Starting the no wowlan resume flow\n");
 
-	mld->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	mld->fw_status.in_d3 = false;
 	iwl_fw_dbg_read_d3_debug_data(&mld->fwrt);
 
@@ -1902,7 +1900,6 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 
 	IWL_DEBUG_WOWLAN(mld, "Starting the wowlan resume flow\n");
 
-	mld->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	if (!mld->fw_status.in_d3) {
 		IWL_DEBUG_WOWLAN(mld,
 				 "Device_powered_off() was called during wowlan\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index e26fcce773aa..81a4443d3b4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -710,7 +710,6 @@ static void iwl_mld_device_powered_off(struct iwl_op_mode *op_mode)
 	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
 
 	wiphy_lock(mld->wiphy);
-	mld->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	iwl_mld_stop_fw(mld);
 	mld->fw_status.in_d3 = false;
 	wiphy_unlock(mld->wiphy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 3e8b7168af01..456ad4fadd8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1266,7 +1266,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	};
 	struct iwl_host_cmd d3_cfg_cmd = {
 		.id = D3_CONFIG_CMD,
-		.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
+		.flags = CMD_WANT_SKB,
 		.data[0] = &d3_cfg_cmd_data,
 		.len[0] = sizeof(d3_cfg_cmd_data),
 	};
@@ -1373,8 +1373,6 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_fw_dbg_stop_restart_recording(&mvm->fwrt, NULL, true);
 
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
-
 	/* must be last -- this switches firmware state */
 	ret = iwl_mvm_send_cmd(mvm, &d3_cfg_cmd);
 	if (ret)
@@ -3407,9 +3405,9 @@ static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
 	int ret;
 	enum iwl_d3_status d3_status;
 	struct iwl_host_cmd cmd = {
-			.id = D0I3_END_CMD,
-			.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
-		};
+		.id = D0I3_END_CMD,
+		.flags = CMD_WANT_SKB,
+	};
 	bool reset = fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 
@@ -3564,9 +3562,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_WOWLAN);
 
-	/* after the successful handshake, we're out of D3 */
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
-
 	/* when reset is required we can't send these following commands */
 	if (d3_data.d3_end_flags & IWL_D0I3_RESET_REQUIRE)
 		goto query_wakeup_reasons;
@@ -3639,9 +3634,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	 */
 	set_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
 
-	/* regardless of what happened, we're now out of D3 */
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
-
 	return 1;
 }
 
@@ -3679,8 +3671,7 @@ void iwl_mvm_fast_suspend(struct iwl_mvm *mvm)
 	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
 	WARN_ON(iwl_mvm_power_update_device(mvm));
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
-	ret = iwl_mvm_send_cmd_pdu(mvm, D3_CONFIG_CMD, CMD_SEND_IN_D3,
+	ret = iwl_mvm_send_cmd_pdu(mvm, D3_CONFIG_CMD, 0,
 				   sizeof(d3_cfg_cmd_data), &d3_cfg_cmd_data);
 	if (ret)
 		IWL_ERR(mvm,
@@ -3735,7 +3726,6 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 
 out:
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	mvm->fast_resume = false;
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5c7c1d53a28d..5629aa0a91fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2126,7 +2126,6 @@ static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
 
 	mutex_lock(&mvm->mutex);
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
-	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	iwl_mvm_stop_device(mvm);
 	mvm->fast_resume = false;
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 3c86a5f23d8f..7d7a217b1575 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2659,12 +2659,6 @@ int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 		return -ERFKILL;
 	}
 
-	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
-		     !(cmd->flags & CMD_SEND_IN_D3))) {
-		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
-		return -EHOSTDOWN;
-	}
-
 	if (cmd->flags & CMD_ASYNC) {
 		int ret;
 
-- 
2.34.1


