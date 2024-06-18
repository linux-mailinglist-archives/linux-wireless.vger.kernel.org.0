Return-Path: <linux-wireless+bounces-9202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6F90D9B2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540B51F22BEB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8613C673;
	Tue, 18 Jun 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFlU20IJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190B13C674
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729067; cv=none; b=Y3lw1EmaKg7bJ46j6Wgc9pdbXMPKX3cu36AqbQRk+no5rmQ8/d78lhjRCQtB9Ph5gBLz1D7hHkjgxUOYnCWK/J42svQtdOU6xQiHzrk+OSu2XYBBZ3w1AXrU4moCkRegzAB6QaM+XTnRphWXXSFFcT2AmJwnBXATbFFlejEFbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729067; c=relaxed/simple;
	bh=dnsPCnoP48ahpUkMbaJr4nLD///1EeJGIkPTTg4t8K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqYnUR782M+eyYR8Ng8LCwxLXfhlBRbnCzpQJuxWNuo48mk5puxYE37HPszTPvigju5f0YvzN8uVSpauepqdtEWejS9ThgvBuur5u3X/9L1F8IO12nOt6+F3SGb0ebQpbYRrYFwu9QVdStcWdXH2lGvf9/cgxhppHVlhO+NahO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFlU20IJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729065; x=1750265065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnsPCnoP48ahpUkMbaJr4nLD///1EeJGIkPTTg4t8K8=;
  b=dFlU20IJziPo5ljj3Pk1z7cafJJuBE4yZm8RNLWnrIpYjht5u63kQ27C
   QeAGScgcnG1Z8NP+LPS5+UukPfT2vUteRhLo/Z2/mnLy4Jbq7aup/jt1O
   dyDben0oLNuerw21jO2nuXWSpLKcBhIN7pJFPX5CllHY5CwHyTNF9Z4ox
   Dp3hrGfotz4l/uLey+3lnkvwWlCl2jQ8DwI2uetI09wQ/6+37XIGglPwx
   bWbNdr+2/Mrrog7YrWd85l6jT5L5ZyaKpUXw11KY9ckZcRGadVz9/uKoR
   BROBYLhMAlOUkLQZYiVjR7DlBwv64/6UvRD+5YIgfLditXKGWt5rfARkn
   w==;
X-CSE-ConnectionGUID: nUb2bIURRNqkMBB5d61zsw==
X-CSE-MsgGUID: tKbnSuv5RUGFV5vs0k3IAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257164"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257164"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:24 -0700
X-CSE-ConnectionGUID: DShJ/lK9QsiAQU/HHDFxUg==
X-CSE-MsgGUID: e6GQg5mgQ8qgx6v3kP4DiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306500"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/11] wifi: iwlwifi: support fast resume
Date: Tue, 18 Jun 2024 19:44:03 +0300
Message-Id: <20240618194245.03b8d2801044.I613d17c712de7a0d611cde4e14f37ebbe0c3c964@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will allow to suspend / resume the system without resetting the
firmware. This will allow to reduce the resume time.
In case the fast_resume fails, stop the device and bring it up from
scratch.

Raise the timeout for the D3_END notification since in some iterations,
it took 240ms.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 85 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 40 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 14 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  2 +-
 4 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 54f4acbbd05b..b4d650583ac2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2493,6 +2493,9 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 		return;
 	}
 
+	if (mvm->fast_resume)
+		return;
+
 	iwl_mvm_convert_key_counters_v5(status, &data->gtk[0].sc);
 	iwl_mvm_convert_gtk_v3(status, data->gtk);
 	iwl_mvm_convert_igtk(status, &data->igtk[0]);
@@ -3049,7 +3052,7 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 	if (iwl_mvm_rt_status(mvm->trans,
 			      mvm->trans->dbg.lmac_error_event_table[0],
 			      &err_id)) {
-		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN) {
+		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN && vif) {
 			struct cfg80211_wowlan_wakeup wakeup = {
 				.rfkill_release = true,
 			};
@@ -3366,7 +3369,7 @@ static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
 	return ret;
 }
 
-#define IWL_MVM_D3_NOTIF_TIMEOUT (HZ / 5)
+#define IWL_MVM_D3_NOTIF_TIMEOUT (HZ / 3)
 
 static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 				 struct iwl_d3_data *d3_data)
@@ -3377,12 +3380,22 @@ static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 		WIDE_ID(SCAN_GROUP, OFFLOAD_MATCH_INFO_NOTIF),
 		WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION)
 	};
+	static const u16 d3_fast_resume_notif[] = {
+		WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION)
+	};
 	struct iwl_notification_wait wait_d3_notif;
 	int ret;
 
-	iwl_init_notification_wait(&mvm->notif_wait, &wait_d3_notif,
-				   d3_resume_notif, ARRAY_SIZE(d3_resume_notif),
-				   iwl_mvm_wait_d3_notif, d3_data);
+	if (mvm->fast_resume)
+		iwl_init_notification_wait(&mvm->notif_wait, &wait_d3_notif,
+					   d3_fast_resume_notif,
+					   ARRAY_SIZE(d3_fast_resume_notif),
+					   iwl_mvm_wait_d3_notif, d3_data);
+	else
+		iwl_init_notification_wait(&mvm->notif_wait, &wait_d3_notif,
+					   d3_resume_notif,
+					   ARRAY_SIZE(d3_resume_notif),
+					   iwl_mvm_wait_d3_notif, d3_data);
 
 	ret = iwl_mvm_resume_firmware(mvm, d3_data->test);
 	if (ret) {
@@ -3567,6 +3580,68 @@ void iwl_mvm_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 	device_set_wakeup_enable(mvm->trans->dev, enabled);
 }
 
+void iwl_mvm_fast_suspend(struct iwl_mvm *mvm)
+{
+	struct iwl_d3_manager_config d3_cfg_cmd_data = {};
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	IWL_DEBUG_WOWLAN(mvm, "Starting fast suspend flow\n");
+
+	mvm->fast_resume = true;
+	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
+
+	WARN_ON(iwl_mvm_power_update_device(mvm));
+	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
+	ret = iwl_mvm_send_cmd_pdu(mvm, D3_CONFIG_CMD, CMD_SEND_IN_D3,
+				   sizeof(d3_cfg_cmd_data), &d3_cfg_cmd_data);
+	if (ret)
+		IWL_ERR(mvm,
+			"fast suspend: couldn't send D3_CONFIG_CMD %d\n", ret);
+
+	WARN_ON(iwl_mvm_power_update_mac(mvm));
+
+	ret = iwl_trans_d3_suspend(mvm->trans, false, false);
+	if (ret)
+		IWL_ERR(mvm, "fast suspend: trans_d3_suspend failed %d\n", ret);
+}
+
+int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
+{
+	struct iwl_d3_data d3_data = {
+		.notif_expected =
+			IWL_D3_NOTIF_D3_END_NOTIF,
+	};
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	IWL_DEBUG_WOWLAN(mvm, "Starting the fast resume flow\n");
+
+	mvm->last_reset_or_resume_time_jiffies = jiffies;
+	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
+
+	if (iwl_mvm_check_rt_status(mvm, NULL)) {
+		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
+		iwl_mvm_dump_nic_error_log(mvm);
+		iwl_dbg_tlv_time_point(&mvm->fwrt,
+				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
+		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
+					false, 0);
+		return -ENODEV;
+	}
+	ret = iwl_mvm_d3_notif_wait(mvm, &d3_data);
+	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
+	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
+	mvm->fast_resume = false;
+
+	if (ret)
+		IWL_ERR(mvm, "Couldn't get the d3 notif %d\n", ret);
+
+	return ret;
+}
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 static int iwl_mvm_d3_test_open(struct inode *inode, struct file *file)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 896e560f5a82..df2f121aff55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1209,6 +1209,7 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 
 int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 {
+	bool fast_resume = false;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -1234,6 +1235,30 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 		mvm->nvm_data = NULL;
 	}
 
+#ifdef CONFIG_PM
+	/* fast_resume will be cleared by iwl_mvm_fast_resume */
+	fast_resume = mvm->fast_resume;
+
+	if (fast_resume) {
+		ret = iwl_mvm_fast_resume(mvm);
+		if (ret) {
+			iwl_mvm_stop_device(mvm);
+			/* iwl_mvm_up() will be called further down */
+		} else {
+			/*
+			 * We clear IWL_MVM_STATUS_FIRMWARE_RUNNING upon
+			 * mac_down() so that debugfs will stop honoring
+			 * requests after we flush all the workers.
+			 * Set the IWL_MVM_STATUS_FIRMWARE_RUNNING bit again
+			 * now that we are back. This is a bit abusing the
+			 * flag since the firmware wasn't really ever stopped,
+			 * but this still serves the purpose.
+			 */
+			set_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
+		}
+	}
+#endif /* CONFIG_PM */
+
 	if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status)) {
 		/*
 		 * Now convert the HW_RESTART_REQUESTED flag to IN_HW_RESTART
@@ -1244,7 +1269,10 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 		/* Clean up some internal and mac80211 state on restart */
 		iwl_mvm_restart_cleanup(mvm);
 	}
-	ret = iwl_mvm_up(mvm);
+
+	/* we also want to load the firmware if fast_resume failed */
+	if (!fast_resume || ret)
+		ret = iwl_mvm_up(mvm);
 
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_POST_INIT,
 			       NULL);
@@ -1327,7 +1355,7 @@ void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 	}
 }
 
-void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
+void __iwl_mvm_mac_stop(struct iwl_mvm *mvm, bool suspend)
 {
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1343,7 +1371,11 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 	if (!iwl_mvm_has_new_station_api(mvm->fw))
 		iwl_mvm_rm_aux_sta(mvm);
 
-	iwl_mvm_stop_device(mvm);
+	if (suspend &&
+	    mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		iwl_mvm_fast_suspend(mvm);
+	else
+		iwl_mvm_stop_device(mvm);
 
 	iwl_mvm_async_handlers_purge(mvm);
 	/* async_handlers_list is empty and will stay empty: HW is stopped */
@@ -1412,7 +1444,7 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw, bool suspend)
 	iwl_mvm_mei_set_sw_rfkill_state(mvm);
 
 	mutex_lock(&mvm->mutex);
-	__iwl_mvm_mac_stop(mvm);
+	__iwl_mvm_mac_stop(mvm, suspend);
 	mutex_unlock(&mvm->mutex);
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 54c3553db219..a57f4738a8c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1161,6 +1161,7 @@ struct iwl_mvm {
 	struct ieee80211_channel **nd_channels;
 	int n_nd_channels;
 	bool net_detect;
+	bool fast_resume;
 	u8 offload_tid;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	bool d3_wake_sysassert;
@@ -1739,7 +1740,7 @@ struct iwl_rate_info {
 	u8 ieee;	/* MAC header:  IWL_RATE_6M_IEEE, etc. */
 };
 
-void __iwl_mvm_mac_stop(struct iwl_mvm *mvm);
+void __iwl_mvm_mac_stop(struct iwl_mvm *mvm, bool suspend);
 int __iwl_mvm_mac_start(struct iwl_mvm *mvm);
 
 /******************
@@ -2261,11 +2262,22 @@ extern const struct file_operations iwl_dbgfs_d3_test_ops;
 #ifdef CONFIG_PM
 void iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
+void iwl_mvm_fast_suspend(struct iwl_mvm *mvm);
+int iwl_mvm_fast_resume(struct iwl_mvm *mvm);
 #else
 static inline void
 iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 }
+
+static inline void iwl_mvm_fast_suspend(struct iwl_mvm *mvm)
+{
+}
+
+static inline int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
+{
+	return 0;
+}
 #endif
 void iwl_mvm_set_wowlan_qos_seq(struct iwl_mvm_sta *mvm_ap_sta,
 				struct iwl_wowlan_config_cmd *cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 45b431ffbc97..718184be19b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -299,7 +299,7 @@ static void check_exit_ctkill(struct work_struct *work)
 
 	ret = iwl_mvm_get_temp(mvm, &temp);
 
-	__iwl_mvm_mac_stop(mvm);
+	__iwl_mvm_mac_stop(mvm, false);
 
 	if (ret)
 		goto reschedule;
-- 
2.34.1


