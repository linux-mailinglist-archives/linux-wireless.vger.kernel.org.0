Return-Path: <linux-wireless+bounces-16837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A59FD1C0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACD71615D4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD9B1553AB;
	Fri, 27 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0pVwjPg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834114F9F8
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286509; cv=none; b=E088d5qbFLis6RbXMWl7GyRA7Au/y4fC+VAnNcgVN05SAXWTpDiCDYZGm+e1DG7Jviivd7EynaiObiaRDwLE1EAs1kOB90M1ujZULgj3NYMDWptFMWg4/IQrv1ivW2qtdeZoEz1xC8VltBrVuiZ1Jf/mWKIdKmkgKayqG0At49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286509; c=relaxed/simple;
	bh=uRAge5VYHwR/kBkItatx+99dv/n7cLCM+ZBO9eJgXIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ob3hmOzVeimzWcCF1ddF6HI5w5e7i815RZNi80/bEaqfGwLHtoVCDN+MdILd25ZmlftoZlTOUygMJqQJ/NYzJxy7wezdRbfuqj+wfh3agRKjzL4WlWC5bRA31GXGhJUmu+TWPQZeiGi7zFwdi5aLVXE9ZsRd1XxPKAPXs9r8+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0pVwjPg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286507; x=1766822507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uRAge5VYHwR/kBkItatx+99dv/n7cLCM+ZBO9eJgXIk=;
  b=g0pVwjPgrzwbiVJ4fdJVVn7ICp1AE8WQfDwn6qr/i4vM7G/W9bq/S1SL
   f83G8xKUYfcfTAjjBvXTHloDRdf9JhuQzz4kKwbyA/Puj2zUxXBWC4d60
   J8cjEOilEDm1QTxZBFapEeY96tiP8gBdkHjm+zzMKtZpsUrbug2KM4VTj
   0BMcCpBeatdmeJwfm2F9fYUTG+ZIi0OxxXrlOvZC3Bc0o6NbFY56T+Cmf
   61i4LNTEG1V0WO3WWbYpYjdDT+Weh0z4E8bhH8VsKnTWI/OyLbEQBnKsB
   fZU2rvKXNHHhr21bwk3pCI94tC1QrE8z9klsmL36oGG9vFbQfAmlsyUbE
   w==;
X-CSE-ConnectionGUID: sc0KfpAATK2d1NnBpxa3WQ==
X-CSE-MsgGUID: ETK1nDeIQEKPhuf33nxJVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690982"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690982"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:44 -0800
X-CSE-ConnectionGUID: CB8x+MsgSPys+8QfIDpVrg==
X-CSE-MsgGUID: V6j3b6lUQpiMeQaVxrhoug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858431"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/17] wifi: iwlwifi: mvm: clean up FW restart a bit
Date: Fri, 27 Dec 2024 10:01:08 +0200
Message-Id: <20241227095718.b0489daf323c.I0cd3233b2214c5f06e059f746041b19d08647e40@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
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
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  7 -------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 ----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 19 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  4 ++--
 6 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index cab11229bd7b..cbb09389f3bf 100644
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
index ccf377a6d73d..7fbfec6750c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1167,10 +1167,6 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 
 	mutex_lock(&mvm->mutex);
 
-	/* allow one more restart that we're provoking here */
-	if (mvm->fw_restart >= 0)
-		mvm->fw_restart++;
-
 	if (count == 6 && !strcmp(buf, "nolog\n")) {
 		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
 		set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &mvm->trans->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6b58231add55..9a6dd59fbc6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5412,7 +5412,7 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 
 out_restart:
 	/* things keep failing, better restart the hw */
-	iwl_mvm_nic_restart(mvm, false);
+	iwl_mvm_nic_restart(mvm);
 	return ret;
 }
 
@@ -5448,7 +5448,7 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 
 out_restart:
 	/* things keep failing, better restart the hw */
-	iwl_mvm_nic_restart(mvm, false);
+	iwl_mvm_nic_restart(mvm);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d0ba9e0f15b7..40a609533eb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1174,8 +1174,6 @@ struct iwl_mvm {
 
 	struct ieee80211_bss_conf __rcu *link_id_to_link_conf[IWL_FW_MAX_LINK_ID + 1];
 
-	/* -1 for always, 0 for never, >0 for that many times */
-	s8 fw_restart;
 	u8 *error_recovery_buf;
 
 #ifdef CONFIG_IWLWIFI_LEDS
@@ -2588,7 +2586,7 @@ void iwl_mvm_tcm_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_tcm_rm_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u8 iwl_mvm_tcm_load_percentage(u32 airtime, u32 elapsed);
 
-void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error);
+void iwl_mvm_nic_restart(struct iwl_mvm *mvm);
 unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif);
 void iwl_mvm_connection_loss(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index de815504183c..aad0449fab36 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1354,7 +1354,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		}
 	}
 
-	mvm->fw_restart = iwlwifi_mod_params.fw_restart ? -1 : 0;
 	mvm->bios_enable_puncturing = iwl_uefi_get_puncturing(&mvm->fwrt);
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
@@ -2026,7 +2025,7 @@ static void iwl_mvm_reprobe_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
+void iwl_mvm_nic_restart(struct iwl_mvm *mvm)
 {
 	iwl_abort_notification_waits(&mvm->notif_wait);
 	iwl_dbg_tlv_del_timers(mvm->trans);
@@ -2049,9 +2048,7 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	 * If WoWLAN fw asserted, don't restart either, mac80211
 	 * can't recover this since we're already half suspended.
 	 */
-	if (!mvm->fw_restart && fw_error) {
-		iwl_fw_error_collect(&mvm->fwrt, false);
-	} else if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		struct iwl_mvm_reprobe *reprobe;
 
 		IWL_ERR(mvm,
@@ -2103,10 +2100,10 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 
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
@@ -2140,7 +2137,7 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode,
 	if (!test_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status))
 		return;
 
-	iwl_mvm_nic_restart(mvm, false);
+	iwl_mvm_nic_restart(mvm);
 }
 
 static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
@@ -2148,7 +2145,7 @@ static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
 	WARN_ON(1);
-	iwl_mvm_nic_restart(mvm, true);
+	iwl_mvm_nic_restart(mvm);
 }
 
 static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 376b9b12fa62..0bcd1fca31bc 100644
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


