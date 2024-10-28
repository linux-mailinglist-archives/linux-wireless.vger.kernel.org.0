Return-Path: <linux-wireless+bounces-14603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F283A9B2F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1948B22855
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13ED1D86F2;
	Mon, 28 Oct 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3WmKkBt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B191D9699
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116540; cv=none; b=Tc1ASiKS6uKWohfVUFW6nX1bFO5JCMfVvpEUVFeUfEmqdYr1kUAoKbdmAvN5QxiE2Tvmy+MaOvRpf/MVueFsvczK0Mwb/fzGmO/bGyK+20eY8fjUdLTR1og11V9kN5e21wDDET/HNjEKXh+p4osaLTUwoWu7uiIp2LYJ55pNeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116540; c=relaxed/simple;
	bh=SF0HGhAODiOLmLtIBjgJxawXYHDduNnAdGEeU2+RUP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KKNuRmhG5H9BMCy3QMb++ZcKGHc5tZ90Bv3lv/4JFWBzMXP0JEHcoO1pJWmWWNYDY/uurNnqfq52r0IQvMAgcS0NWOC5epkBG03sCPGAZFVRWTe1fpqYLaUQwKt8ieB5dgsFWJl1SFQHVcj+gUofYbCzPUIN7oY1Vq7f1F/4kYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3WmKkBt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116539; x=1761652539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SF0HGhAODiOLmLtIBjgJxawXYHDduNnAdGEeU2+RUP0=;
  b=O3WmKkBtF714euFyd/iCEj/5l51Ju/9lchpFKsQqY1qlvj5I6QzhlNt+
   8/nzl8tNhhawrk9kW9XBYYIv+tWVVyursdQOP75p2SnX7fmljGCehEvSy
   WSocdoJmD9GZ/4CUCjloi8RU0wKvpdPNrFn3JlN1C9rrD4jxgq9uEwgQx
   OhwzAfd1E2XMlTSxM2wG6w95wdlIqFQBSu3GqhdsIluWmkeqYG72uOcpl
   RCD9ZoV3bK4VYP9lzZSUUNjNTc+cW33jDLsX3GXYSCL3hmIZaw7RbNxB1
   om7+eDM6rc7C8ELPzJtGiddF59GKbruPenkVWpB5AEWk4JZDJjDiEJ5fy
   g==;
X-CSE-ConnectionGUID: zO2D2AeaQQWWmoroPlmYIA==
X-CSE-MsgGUID: sZW6lC2HS4uIQcldxTuTCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813929"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813929"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:38 -0700
X-CSE-ConnectionGUID: V77cJAGpSpO9X/QN/mvmFA==
X-CSE-MsgGUID: s6zxJAv+SH2Fka86bcxRpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432649"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: clean up FW restart a bit
Date: Mon, 28 Oct 2024 13:55:00 +0200
Message-Id: <20241028135215.c77c8ba2d2a2.I4eee724d9fe66c1d58229869cd6c283e6bb8dfb6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Approximately three years ago, in commit ddb6b76b6f96
("iwlwifi: yoyo: support TLV-based firmware reset"), the code
was (likely erroneously) changed to no longer treat error
interrupts as firmware errors. As a result, this meant that
the fw_restart counter was only applied in case of command
queue being stuck, which never seems to happen. Also, there's
no longer any way to set the mvm->fw_restart to a value that
doesn't match exactly the module parameter behaviour.

Instead of trying to fix this, simply remove the logic that
limits the number of restarts, it's clearly unused.

However, restore the logic that restart isn't unconditional,
by checking the module parameter.

Since the "fw_error" argument to iwl_mvm_nic_restart() is now
always true (except in the "never happens" case of CMD queue
stuck), just remove it too and treat command queue stuck the
same way as everything else.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  7 -------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 ----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 20 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  4 ++--
 6 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 84c2c87b017f..c282e43c20ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1395,13 +1395,6 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (ret < 0) {
 		iwl_mvm_free_nd(mvm);
 
-		if (!unified_image) {
-			if (mvm->fw_restart > 0) {
-				mvm->fw_restart--;
-				ieee80211_restart_hw(mvm->hw);
-			}
-		}
-
 		clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 	}
  out_noreset:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 91ca830a7b60..f5a029b8fa81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1159,10 +1159,6 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 
 	mutex_lock(&mvm->mutex);
 
-	/* allow one more restart that we're provoking here */
-	if (mvm->fw_restart >= 0)
-		mvm->fw_restart++;
-
 	if (count == 6 && !strcmp(buf, "nolog\n")) {
 		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
 		set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &mvm->trans->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c4fc99ec97e6..510436ac28ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5407,7 +5407,7 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 
 out_restart:
 	/* things keep failing, better restart the hw */
-	iwl_mvm_nic_restart(mvm, false);
+	iwl_mvm_nic_restart(mvm);
 	return ret;
 }
 
@@ -5443,7 +5443,7 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 
 out_restart:
 	/* things keep failing, better restart the hw */
-	iwl_mvm_nic_restart(mvm, false);
+	iwl_mvm_nic_restart(mvm);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2ad615293c75..a48b19608782 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1174,8 +1174,6 @@ struct iwl_mvm {
 
 	struct ieee80211_bss_conf __rcu *link_id_to_link_conf[IWL_FW_MAX_LINK_ID + 1];
 
-	/* -1 for always, 0 for never, >0 for that many times */
-	s8 fw_restart;
 	u8 *error_recovery_buf;
 
 #ifdef CONFIG_IWLWIFI_LEDS
@@ -2591,7 +2589,7 @@ void iwl_mvm_tcm_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_tcm_rm_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u8 iwl_mvm_tcm_load_percentage(u32 airtime, u32 elapsed);
 
-void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error);
+void iwl_mvm_nic_restart(struct iwl_mvm *mvm);
 unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif);
 void iwl_mvm_connection_loss(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e25d7570ffab..e4bf0696898d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1350,7 +1350,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 			goto out_free;
 	}
 
-	mvm->fw_restart = iwlwifi_mod_params.fw_restart ? -1 : 0;
 	mvm->bios_enable_puncturing = iwl_uefi_get_puncturing(&mvm->fwrt);
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
@@ -2015,7 +2014,7 @@ static void iwl_mvm_reprobe_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
+void iwl_mvm_nic_restart(struct iwl_mvm *mvm)
 {
 	iwl_abort_notification_waits(&mvm->notif_wait);
 	iwl_dbg_tlv_del_timers(mvm->trans);
@@ -2038,10 +2037,7 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	 * If WoWLAN fw asserted, don't restart either, mac80211
 	 * can't recover this since we're already half suspended.
 	 */
-	if (!mvm->fw_restart && fw_error) {
-		iwl_fw_error_collect(&mvm->fwrt, false);
-	} else if (test_bit(IWL_MVM_STATUS_STARTING,
-			    &mvm->status)) {
+	if (test_bit(IWL_MVM_STATUS_STARTING, &mvm->status)) {
 		IWL_ERR(mvm, "Starting mac, retry will be triggered anyway\n");
 	} else if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		struct iwl_mvm_reprobe *reprobe;
@@ -2095,10 +2091,10 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 
 		iwl_fw_error_collect(&mvm->fwrt, false);
 
-		if (fw_error && mvm->fw_restart > 0) {
-			mvm->fw_restart--;
-			ieee80211_restart_hw(mvm->hw);
-		} else if (mvm->fwrt.trans->dbg.restart_required) {
+		if (!iwlwifi_mod_params.fw_restart)
+			return;
+
+		if (mvm->fwrt.trans->dbg.restart_required) {
 			IWL_DEBUG_INFO(mvm, "FW restart requested after debug collection\n");
 			mvm->fwrt.trans->dbg.restart_required = false;
 			ieee80211_restart_hw(mvm->hw);
@@ -2135,7 +2131,7 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
 	if (!test_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status))
 		return;
 
-	iwl_mvm_nic_restart(mvm, false);
+	iwl_mvm_nic_restart(mvm);
 }
 
 static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
@@ -2143,7 +2139,7 @@ static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
 	WARN_ON(1);
-	iwl_mvm_nic_restart(mvm, true);
+	iwl_mvm_nic_restart(mvm);
 }
 
 static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 6fb241d0c5f5..c895a4097472 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3477,7 +3477,7 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 			 * restart_hw, so do not report if FW is about to be
 			 * restarted.
 			 */
-			if (!mvm->fw_restart)
+			if (!iwlwifi_mod_params.fw_restart)
 				ieee80211_sched_scan_stopped(mvm->hw);
 			mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 			mvm->scan_uid_status[uid] = 0;
@@ -3528,7 +3528,7 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 		 * restarted.
 		 */
 		if ((mvm->scan_status & IWL_MVM_SCAN_SCHED) &&
-		    !mvm->fw_restart) {
+		    !iwlwifi_mod_params.fw_restart) {
 			ieee80211_sched_scan_stopped(mvm->hw);
 			mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 		}
-- 
2.34.1


